-- License: Public Domain

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_OrderHallUI" then
		self:UnregisterEvent(event)
		local b = OrderHallCommandBar
		b:UnregisterAllEvents()
		b:SetScript("OnShow", b.Hide)
		b:Hide()

		UIParent:UnregisterEvent("UNIT_AURA")
	end
end)