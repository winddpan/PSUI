local Minimap_Filter = {
	"MiniMapMailFrame",
	"QueueStatusMinimapButton",
	"QueueStatusMinimapButtonDropDownButton",
	"MinimapBackdrop",	
	
	"MiniMapWorldMapButton",
	"MiniMapTrackingDropDownButton",
	"MiniMapTrackingButton",
	"MinimapZoomIn",
	"MinimapZoomOut",
	"GameTimeFrame",
	"MiniMapVoiceChatFrame",
	"MiniMapVoiceChatDropDownButton",
	"TimeManagerClockButton",
}

local function isMinimapButton(frame)
	local name = frame:GetName()
	if frame and frame:GetObjectType() == "Button" and frame:GetNumRegions() >= 3 and name ~=nil and string.find(name, "LibDBIcon") ~= nil then
		for j = 1, #Minimap_Filter do
			if name == Minimap_Filter[j] then
				return false
			end
		end
		return true
	end
end

function findButtons(parent, frame)
	if frame then
		for i, button in ipairs({frame:GetChildren()}) do
			if isMinimapButton(button) and button:GetParent() ~= f then
				button:SetParent(parent)
			else
				findButtons(parent, button)
			end	
		end
	end
end

local function updateCollect(f, parent)
	local x,y
	local i = 0
	for index, button in ipairs({f:GetChildren()}) do
		if button:IsVisible() then
			button:SetScale(1)
			
			x = i - floor(i/11)*11
			y = floor(i/11)
			i = i + 1

			button:ClearAllPoints()
			button:SetPoint("RIGHT", parent, "RIGHT", 32 + x*30-y*30*0.25, 0)
			button:SetMovable(false)
			button:SetScript("OnDragStart", dummy)
			button:SetScript("OnDragStop", dummy)
			
		end
	end
end

local Collect = CreateFrame("Frame", "Minimap_Collect", Minimap)
Collect:SetAllPoints(Minimap)
Collect:SetFrameStrata(Minimap:GetFrameStrata())

local delay = 0
Collect.icon = CreateFrame("Button", "Icon_Collect", Minimap)
Collect.icon:SetSize(32, 32)
Collect.icon:SetPoint("BOTTOMRIGHT", Minimap.mnMap, "BOTTOMRIGHT", 6, -6)
Collect.icon:SetFrameLevel(Minimap:GetFrameLevel() + 1)
Collect.icon:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" or button == "RightButton" then
		if Collect:IsVisible() then
			Collect.icon:SetScript("OnUpdate", nil)
			Collect:Hide()
		else
			updateCollect(Collect, self)
			Collect:Show()
			
			delay = 0
			Collect.icon:SetScript("OnUpdate", function(self, elapsed)
				delay = delay + elapsed
				if delay > 5 and Collect:IsVisible() then
					Collect.icon:SetScript("OnUpdate", nil)
					Collect:Hide()
				end
			end)
		end
	end
end)

local fs = Collect.icon:CreateFontString(nil, "OVERLAY")
fs:SetFont(STANDARD_TEXT_FONT, 13, "THINOUTLINE")
fs:SetPoint("CENTER", Collect.icon, "CENTER",0,0)
fs:SetText("|cff8AFF30>>|r")
		
Collect:RegisterEvent("PLAYER_ENTERING_WORLD")
Collect:SetScript("OnEvent", function(self, event, addon)
	findButtons(self, Minimap)
	updateCollect(self, Collect.icon)
	Collect:Hide()
end)
