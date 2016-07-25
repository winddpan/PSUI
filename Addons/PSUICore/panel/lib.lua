local addon, ns = ...
local lib = CreateFrame("Frame")

local glow = "Interface\\addons\\PSUICore\\media\\glow.tga"
local WHITE8x8 =  "Interface\\Buttons\\WHITE8x8"
local panels,k   = {},0
----------------------------------------------------------------------------------------------------------------------------
------	move func
----------------------------------------------------------------------------------------------------------------------------
local Onmove = {}
local FrameNotInScreenMap = {}

local IsFrameInScreen = function(PANEL)
	return FrameNotInScreenMap[PANEL] == nil
end
lib.isFrameInScreen = IsFrameInScreen

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

lib.movefunc = function(PANEL, direction, lock, animated)
	if Onmove[PANEL] == nil then Onmove[PANEL] = false end
	if lock and UnitAffectingCombat("player") then print("战斗中无法移动！") return end
	if not Onmove[PANEL] then
		Onmove[PANEL] = true
		local InScreen = IsFrameInScreen(PANEL)
		local Anchor, relativeTo, relativePoint, OriginalX, OriginalY = PANEL:GetPoint()
		local Step, MaxStep = 0, 25
		local Height = PANEL:GetHeight() + 50
		local Width = PANEL:GetWidth() + 10
		local Updater = CreateFrame("Frame")
		Updater:SetScript("OnUpdate", function(self, elapsed)
			Step = math.min(Step + elapsed*60, MaxStep)
			if not animated then
				Step = MaxStep;
			end
			if direction == "Right" then
				if InScreen then
					PANEL:SetPoint(Anchor, OriginalX + (Step/MaxStep)*Width, OriginalY)
				else
					PANEL:SetPoint(Anchor, OriginalX - (Step/MaxStep)*Width, OriginalY)
				end
			elseif direction == "Left" then
				if InScreen then
					PANEL:SetPoint(Anchor, OriginalX - (Step/MaxStep)*Width, OriginalY)
				else
					PANEL:SetPoint(Anchor, OriginalX + (Step/MaxStep)*Width, OriginalY)
				end
			elseif direction == "Up" then
				if InScreen then
					PANEL:SetPoint(Anchor, OriginalX, OriginalY + (Step/MaxStep)*Height)
				else
					PANEL:SetPoint(Anchor, OriginalX, OriginalY - (Step/MaxStep)*Height)
				end
			elseif direction == "Down" then
				if InScreen then
					PANEL:SetPoint(Anchor, OriginalX, OriginalY - (Step/MaxStep)*Height)
				else
					PANEL:SetPoint(Anchor, OriginalX, OriginalY + (Step/MaxStep)*Height)
				end
			end
			if Step >= MaxStep then
			   self:SetScript("OnUpdate", nil)
			   Updater = nil
			   Onmove[PANEL] = false
			   if InScreen then
			   		FrameNotInScreenMap[PANEL] = 1
				else
					FrameNotInScreenMap[PANEL] = nil
			   end
			end
		end) 
	end
end
----------------------------------------------------------------------------------------------------------------------------
------	Createpanel func
----------------------------------------------------------------------------------------------------------------------------
lib.Createpanel = function(name,width,heigth,parent,strata,texture,inset,color,backdropc,framelevel) 
	panels[k] = CreateFrame("Frame",name,parent) 
    panels[k]:SetWidth(width)
	panels[k]:SetHeight(heigth)
	panels[k]:SetFrameStrata(strata)
	panels[k]:SetFrameLevel(0)
	panels[k]:SetBackdrop({ 
		bgFile = WHITE8x8,
		insets = {left = inset,right = inset,top = inset,bottom = inset}, 
		edgeFile = glow, edgeSize = inset,})
		
	panels.bg = panels[k]:CreateTexture(nil, "PARENT")
	panels.bg:ClearAllPoints()
	panels.bg:SetPoint("TOPLEFT", panels[k], "TOPLEFT", 3, -3);
	panels.bg:SetPoint("BOTTOMRIGHT", panels[k], "BOTTOMRIGHT", -3, 3);
	panels.bg:SetColorTexture(.1,.1,.1,0.5)
	
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
			if movetag then lib.movefunc(movetag,direction,lock,true) end
		end)
end

ns.lib = lib