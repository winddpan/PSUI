local _, Addon = ...

Addon.LoadWithUI = {}

local frame = CreateFrame("frame")
local bLoaded = false

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, ...)
	local funcs
	if not bLoaded and IsAddOnLoaded("Blizzard_GarrisonUI") then
		funcs = Addon.LoadWithUI
		for func, _ in pairs(funcs) do
			funcs[func]()
		end
		bLoaded = true
	end
end)