COMBAT_TEXT_ABSORB = "Absorb";
COMBAT_TEXT_BLOCK = "Block";
COMBAT_TEXT_DEFLECT = "Deflect";
COMBAT_TEXT_DODGE = "Dodge";
COMBAT_TEXT_EVADE = "Evade";
COMBAT_TEXT_IMMUNE = "Immune";
COMBAT_TEXT_MISFIRE = "Miss";
COMBAT_TEXT_MISS = "Miss";
COMBAT_TEXT_NONE = "None";
COMBAT_TEXT_PARRY = "Parry";
COMBAT_TEXT_REFLECT = "Reflect";
COMBAT_TEXT_RESIST = "Resist";


local customLossControlFrame = function()
	LossOfControlFrame:ClearAllPoints()
	LossOfControlFrame:SetPoint("CENTER",UIParent,"CENTER",0,200)
	LossOfControlFrame:SetScale(0.8)
end
local f = CreateFrame"Frame"
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function() customLossControlFrame() end)