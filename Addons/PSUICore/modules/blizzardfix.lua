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

--[[
setfenv(WorldMapFrame_OnShow, setmetatable({UpdateMicroButtons = function() end}, {__index = _G}))
setfenv(FriendsFrame_OnShow, setmetatable({UpdateMicroButtons = function() end}, {__index = _G}))


local ParentalControls = CreateFrame("Frame")
ParentalControls:RegisterEvent("ADDON_LOADED")
ParentalControls:SetScript("OnEvent", function(self, event, addon)
		if addon == "Blizzard_GuildUI" then
				setfenv(GuildFrame_OnShow, setmetatable({UpdateMicroButtons = function() end}, {__index = _G}))
		elseif addon == "Blizzard_AchievementUI" then
				setfenv(AchievementFrame_OnShow, setmetatable({UpdateMicroButtons = function() end}, {__index = _G}))
				setfenv(AchievementFrame_OnHide, setmetatable({UpdateMicroButtons = function() end}, {__index = _G}))
		--elseif addon == "Blizzard_TalentUI" then
		--		setfenv(PlayerTalentFrame_OnShow, setmetatable({UpdateMicroButtons = function() end}, {__index = _G}))
		--		setfenv(PlayerTalentFrame_OnHide, setmetatable({UpdateMicroButtons = function() end}, {__index = _G}))
		end
end)

UIParent:HookScript("OnEvent", function(s, e, a1, a2) if e:find("ACTION_FORBIDDEN") and ((a1 or "")..(a2 or "")):find("IsDisabledByParentalControls") then StaticPopup_Hide(e) end; end)

function SendAddonMessageToRaid(pre, msg)
	if GetRealNumRaidMembers() == 0 or GetRealNumPartyMembers() == 0 then return end
	SendAddonMessage(pre, msg, "RAID")
end
]]