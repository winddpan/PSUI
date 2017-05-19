------------------------------------------------------------
-- Plugin.lua
--
-- Abin
-- 2016-10-25
------------------------------------------------------------

local _, addon = ...
local L = addon.L

local PLUGIN_NAME = "Broker_Altcon"

local plugin = LibStub("LibDataBroker-1.1"):NewDataObject(PLUGIN_NAME, {
	type 		= "data source",
	category	= "Chat/Communication",
	icon 		= 237446,
	text		= addon.name,
	OnClick 	= function() addon:ToggleFrame() end
})

if not plugin then return end

function plugin.OnTooltipShow(tooltip)
	tooltip:AddLine(addon.name)
	tooltip:AddLine(L["click to open frame"], 1, 1, 1, 1)
end

local minimapCheck = CreateFrame("CheckButton", "AltconMinimapIconCheckButton", addon.frame, "InterfaceOptionsCheckButtonTemplate")
minimapCheck:SetPoint("BOTTOMLEFT", 12, 10)

local buttonText = AltconMinimapIconCheckButtonText
buttonText:SetFont(STANDARD_TEXT_FONT, 13)
buttonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
buttonText:SetText(L["show minimap button"])

minimapCheck:SetScript("OnClick", function(self)
	addon.db.showMinimapButton = self:GetChecked()
	addon:UpdateMinimapButton()
end)

function addon:UpdateMinimapButton()
	if self.db.showMinimapButton then
		if not self.minimapButton then
			self.minimapButton = LibStub("LibDBIcon-1.0")
			self.minimapButton:Register(PLUGIN_NAME, plugin, self.db.minimapButton)
		end
		self.minimapButton:Show(PLUGIN_NAME)
	else
		if self.minimapButton then
			self.minimapButton:Hide(PLUGIN_NAME)
		end
	end
end

addon:RegisterEventCallback("OnInitialize", function(db)
	if type(db.minimapButton) ~= "table" then
		db.showMinimapButton = 1
		db.minimapButton = {}
	end

	if db.showMinimapButton then
		minimapCheck:SetChecked(1)
		addon:UpdateMinimapButton()
	end
end)