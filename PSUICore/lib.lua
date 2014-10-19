local addon, ns = ...
local lib = CreateFrame("Frame")

local glow = "Interface\\addons\\PSUICore\\media\\glow.tga"
local WHITE8x8 =  "Interface\\Buttons\\WHITE8x8"
local panels,k   = {},0
----------------------------------------------------------------------------------------------------------------------------
------	move func
----------------------------------------------------------------------------------------------------------------------------
local Onmove = {}
local frameInScreenMap = {}

local isFrameInScreen = function(PANEL)
	if frameInScreenMap[PANEL] == nil then frameInScreenMap[PANEL] = true end
	return frameInScreenMap[PANEL]
end
lib.isFrameInScreen = isFrameInScreen

function CreateStyle(f, size, level, alpha, alphaborder) --
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(level or 0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -size, size)
	shadow:SetPoint("BOTTOMRIGHT", size, -size)
	shadow:SetBackdrop(style)
	shadow:SetBackdropColor(.08,.08,.08, alpha or .9)
	shadow:SetBackdropBorderColor(0, 0, 0, alphaborder or 1)
	f.shadow = shadow
	return shadow
end

lib.movefunc = function(PANEL,direction,lock)
	if Onmove[PANEL] == nil then Onmove[PANEL] = false end
	if lock and UnitAffectingCombat("player") then print("战斗中无法移动！") return end
	if not Onmove[PANEL] then
		if isFrameInScreen(PANEL) == true then
		 local Anchor, relativeTo, relativePoint, OriginalX, OriginalY = PANEL:GetPoint()
		 local Step, MaxStep = 0, 25
		 local Height = PANEL:GetHeight() + 50
		 local Width = PANEL:GetWidth() + 10
		 local Updater = CreateFrame("Frame")
		 Updater:SetScript("OnUpdate", function(self, elapsed)
			Step = Step + 1
			Onmove[PANEL] = true
			if direction == "Right" then
				PANEL:SetPoint(Anchor, OriginalX + (Step/MaxStep)*Width, OriginalY)
			elseif direction == "Left" then
				PANEL:SetPoint(Anchor, OriginalX - (Step/MaxStep)*Width, OriginalY)
			elseif direction =="UP" then
				PANEL:SetPoint(Anchor, OriginalX, OriginalY + (Step/MaxStep)*Height)
			else
				PANEL:SetPoint(Anchor, OriginalX, OriginalY - (Step/MaxStep)*Height)
			end
			if Step >= MaxStep then
			   self:SetScript("OnUpdate", nil)
			   frameInScreenMap[PANEL] = false
			   Onmove[PANEL] = false
			end
		 end) 
		else
		 local Anchor, relativeTo, relativePoint, OriginalX, OriginalY = PANEL:GetPoint()
		 local Step, MaxStep = 0, 25
		 local Height = PANEL:GetHeight() +50
		 local Width = PANEL:GetWidth() + 10
		 local Updater = CreateFrame("Frame")
		 Updater:SetScript("OnUpdate", function(self, elapsed)
			Step = Step + 1
			Onmove[PANEL] = true
			if direction == "Right" then
				PANEL:SetPoint(Anchor, OriginalX - (Step/MaxStep)*Width, OriginalY)
			elseif direction == "Left" then
				PANEL:SetPoint(Anchor, OriginalX + (Step/MaxStep)*Width, OriginalY)
			elseif direction =="UP" then
				PANEL:SetPoint(Anchor, OriginalX, OriginalY - (Step/MaxStep)*Height)
			else
				PANEL:SetPoint(Anchor, OriginalX, OriginalY + (Step/MaxStep)*Height)
			end
			if Step >= MaxStep then
			   self:SetScript("OnUpdate", nil)
			   frameInScreenMap[PANEL] = true
			   Onmove[PANEL] = false
			end
		 end) 
	    end
	end
end
----------------------------------------------------------------------------------------------------------------------------
------	Createpanel func
----------------------------------------------------------------------------------------------------------------------------
lib.Createpanel = function(name,width,heigth,parent,strata,texture,inset,color,backdropc) 
	panels[k] = CreateFrame("Frame",name,parent) 
    panels[k]:SetWidth(width)
	panels[k]:SetHeight(heigth)
	panels[k]:SetFrameStrata(strata)
	panels[k]:SetFrameLevel(2)
	panels[k]:SetBackdrop({ 
		bgFile = WHITE8x8,
		insets = {left = inset,right = inset,top = inset,bottom = inset}, 
		edgeFile = glow, edgeSize = inset,})
	panels.bg = panels[k]:CreateTexture(nil, "PARENT")
	panels.bg:SetTexture(texture or 1,1,1,0)
	panels.bg:ClearAllPoints()
	panels.bg:SetPoint("TOPLEFT", panels[k], "TOPLEFT", 3, -3);
	panels.bg:SetPoint("BOTTOMRIGHT", panels[k], "BOTTOMRIGHT", -3, 3);
	panels.bg:SetVertexColor(.1,.1,.1,.7)
	panels.bg:SetBlendMode(blend or "BLEND")
	panels[k]:SetBackdropColor(unpack(backdropc))
	panels[k]:SetBackdropBorderColor(unpack(color))
end

lib.CreateButton = function(tag,movetag,direction,clickcolor,lock)
		local point, relativeTo, relativePoint, xOfs, yOfs = tag:GetPoint()
		tag:SetScript("OnMouseDown",function(self)
			tag:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-1)
		end)
		tag:SetScript("OnMouseUp",function(self)
			tag:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
			if clickcolor then tag:SetBackdropBorderColor(unpack(clickcolor)) end
			if movetag then lib.movefunc(movetag,direction,lock) end
		end)
end

ns.lib = lib