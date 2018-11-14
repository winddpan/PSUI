local onLogin = function()
	SpellActivationOverlayFrame:SetScale(0.8)
	SpellActivationOverlayFrame:SetFrameStrata("MEDIUM")
	SpellActivationOverlayFrame:SetFrameLevel(1)
	SpellActivationOverlayFrame:ClearAllPoints()
	SpellActivationOverlayFrame:SetPoint("BOTTOM", UIParent ,"CENTER", 0, 100)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function() onLogin() end)