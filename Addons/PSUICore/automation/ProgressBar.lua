local SCALE			= 1
local WIDTH 		= Minimap.mnMap:GetWidth()
local HEIGHT 		= 5
local _, CLASS 		= UnitClass("player")
local COLOR			= CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[CLASS] or RAID_CLASS_COLORS[CLASS]
local POSITION		= {"TOP", Minimap.mnMap, "BOTTOM", 0, -3}
local OFFSET		= 6
local TEXTURE 		= "Interface\\AddOns\\\PSUICore\\media\\statusbar.tga"

-- LOCALE
local L = {}
if (GetLocale() == "zhCN") then
	L = {
		["Hated"]		= "仇恨",
		["Hostile"]		= "敌对",
		["Unfriendly"]	= "冷淡",
		["Neutral"]		= "中立",
		["Friendly"]	= "友善",
		["Honored"]		= "尊敬",
		["Revered"]		= "崇敬",
		["Exalted"]		= "崇拜",
		["ParagonRep"]  = "ParagonRep",
	}
else
	L = {
		["Hated"]		= "Hated",
		["Hostile"]		= "Hostile",
		["Unfriendly"]	= "Unfriendly",
		["Neutral"]		= "Neutral",
		["Friendly"]	= "Friendly",
		["Honored"]		= "Honored",
		["Revered"]		= "Revered",
		["Exalted"]		= "Exalted",
		["ParagonRep"]  = "ParagonRep",
	}
end

-- DATA METHODS
local FactionInfo = {
	[1] = {170/255, 70/255, 70/255, L["Hated"], "FFaa4646"},
	[2] = {170/255, 70/255, 70/255, L["Hostile"], "FFaa4646"},
	[3] = {170/255, 70/255, 70/255, L["Unfriendly"], "FFaa4646"},
	[4] = {200/255, 180/255, 100/255, L["Neutral"], "FFc8b464"},
	[5] = {75/255, 175/255, 75/255, L["Friendly"], "FF4baf4b"},
	[6] = {75/255, 175/255, 75/255, L["Honored"], "FF4baf4b"},
	[7] = {75/255, 175/255, 75/255, L["Revered"], "FF4baf4b"},
	[8] = {155/255, 255/255, 155/255, L["Exalted"],"FF9bff9b"},
}

f = CreateFrame("Frame", nil, UIParent)
f:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], POSITION[5])
f:SetWidth(WIDTH)
f:SetHeight(HEIGHT)
f:SetScale(SCALE)
f:SetFrameStrata(Minimap:GetFrameStrata())
f.shadow = CreateFrame("Frame", nil, f)
f.shadow:SetPoint("TOPLEFT", f, "TOPLEFT", -3, 3)
f.shadow:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 3, -3)
f.shadow:SetBackdrop({edgeFile = [[Interface\AddOns\PSUICore\media\glow]], edgeSize = 3})
f.shadow:SetBackdropColor(0, 0, 0, 0)
f.shadow:SetBackdropBorderColor(0, 0, 0, 0.67)
	
-- SETUP BARS
local setBar = function(frame)
	frame:SetStatusBarTexture(TEXTURE)
	frame:SetWidth(WIDTH)
	frame:SetHeight(HEIGHT)
	frame:SetScale(SCALE)
end

local setBackdrop = function(frame) 
	frame.bg = CreateFrame("Frame", nil, frame)
	frame.bg:SetBackdrop({
		bgFile = [[Interface/Buttons/WHITE8X8]],
		tiled = false,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	frame.bg:SetPoint("TOPLEFT", frame, -1, 1)
	frame.bg:SetPoint("BOTTOMRIGHT", frame, 1, -1)
	frame.bg:SetFrameLevel(1)
	frame.bg:SetBackdropColor(0, 0, 0, .35)
end

local Experience = CreateFrame("StatusBar", nil, f, 'AnimatedStatusBarTemplate')
setBar(Experience)
Experience:SetFrameLevel(4)
Experience:SetStatusBarColor(.4, .1, .6)
Experience:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], POSITION[5])
setBackdrop(Experience)

local Rest = CreateFrame("StatusBar", nil, Experience)
setBar(Rest)
Rest:SetFrameLevel(3)
Rest:EnableMouse(false)
Rest:SetStatusBarColor(.2, .4, .8)
Rest:SetAllPoints(Experience)

local Reputation = CreateFrame("StatusBar", nil, f, 'AnimatedStatusBarTemplate')
setBar(Reputation)
Reputation:SetFrameLevel(4)
setBackdrop(Reputation)

local Artifact = CreateFrame("StatusBar", nil, f, 'AnimatedStatusBarTemplate')
setBar(Artifact)
Artifact:SetFrameLevel(4)
Artifact:SetStatusBarColor(229/255, 205/255, 157/255)
setBackdrop(Artifact)

local update = function() 
	local height = 0
	local y = 0
	if Artifact:IsShown() then
		Artifact:SetPoint("BOTTOM", f, "BOTTOM", 0, y)
		y = y + OFFSET
		height = height + OFFSET
	end
	if Reputation:IsShown() then
		Reputation:SetPoint("BOTTOM", f, "BOTTOM", 0, y)
		y = y + OFFSET
		height = height + OFFSET
	end
	if Experience:IsShown() then
		Experience:SetPoint("BOTTOM", f, "BOTTOM", 0, y)
		Rest:SetAllPoints(Experience)
	end
	f:SetHeight(height - (OFFSET - HEIGHT))
	f:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], POSITION[5])

	if height == 0 then
		f:Hide()
	else
		f:Show()
	end
end

local numberize = function(v)
	if v <= 9999 then return v end
	if v >= 1000000 then
		local value = string.format("%.1fm", v/1000000)
		return value
	elseif v >= 10000 then
		local value = string.format("%.1fk", v/1000)
		return value
	end
end

local experience_update = function()
	if UnitLevel("player") < MAX_PLAYER_LEVEL and not IsXPUserDisabled() then
		local c, m = UnitXP("player"), UnitXPMax("player")
		local p, r = math.ceil(c/m*100), GetXPExhaustion()

		Experience:SetMinMaxValues(min(0, c), m)
		Experience:SetValue(c)
		Rest:SetMinMaxValues(min(0, c), m)
		Rest:SetValue(r and (c + r) or 0)
		
		Experience:Show() 
		Rest:Show()
	else
		Experience:Hide() 
		Rest:Hide()
	end
	update()
end

local showExperienceTooltip = function(self)
	if UnitLevel("player") < MAX_PLAYER_LEVEL and not IsXPUserDisabled() then
		local xpc, xpm, xpr = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion("player")

		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		--GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

		GameTooltip:AddLine("Level "..UnitLevel("player"), COLOR.r, COLOR.g, COLOR.b)
		GameTooltip:AddLine((numberize(xpc).."/"..numberize(xpm).." ("..floor((xpc/xpm)*100) .."%)"), 1, 1, 1)
		if xpr then
			GameTooltip:AddLine(numberize(xpr).." ("..floor((xpr/xpm)*100) .."%)", .2, .4, .8)
		end

		GameTooltip:Show()
	end
end

local reputation_update = function()
	if GetWatchedFactionInfo() then
		local _, standing, min, max, value, factionID = GetWatchedFactionInfo()
		local friendID, friendRep, _, _, _, _, _, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)

		if friendID then
			if nextFriendThreshold then
				min, max, value = friendThreshold, nextFriendThreshold, friendRep
			else
				min, max, value = 0, 1, 1
			end
			standing = 5
		elseif C_Reputation.IsFactionParagon(factionID) then
			local currentValue, threshold = C_Reputation.GetFactionParagonInfo(factionID)
			min, max, value = 0, threshold, currentValue
		else
			if standing == MAX_REPUTATION_REACTION then
				min, max, value = 0, 1, 1
			end
		end

		Reputation:ClearAllPoints()
		Reputation:SetMinMaxValues(min, max)
		Reputation:SetValue(value)
		Reputation:SetStatusBarColor(FACTION_BAR_COLORS[standing].r, FACTION_BAR_COLORS[standing].g, FACTION_BAR_COLORS[standing].b)
		Reputation:Show()
	else
		Reputation:Hide()
	end
	update()
end

local showReputationTooltip = function(self)
	if GetWatchedFactionInfo() then
		local name, standing, min, max, value, factionID = GetWatchedFactionInfo()
		local friendID, _, _, _, _, _, friendTextLevel, _, nextFriendThreshold = GetFriendshipReputation(factionID)
		local currentRank, maxRank = GetFriendshipReputationRanks(friendID)
		local standingtext
		if friendID then
			if maxRank > 0 then
				name = name.." ("..currentRank.." / "..maxRank..")"
			end
			if not nextFriendThreshold then
				value = max - 1
			end
			standingtext = friendTextLevel
		else
			if standing == MAX_REPUTATION_REACTION then
				max = min + 1e3
				value = max - 1
			end
			standingtext = GetText("FACTION_STANDING_LABEL"..standing, UnitSex("player"))
		end

		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		--GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

		GameTooltip:AddLine(name, 0,.6,1)
		GameTooltip:AddDoubleLine(standingtext, value - min.."/"..max - min.." ("..floor((value - min)/(max - min)*100).."%)", .6,.8,1, 1,1,1)

		-- GameTooltip:AddDoubleLine("Reputation:", name, r, g, b, 1, 1, 1)
		-- GameTooltip:AddDoubleLine("Standing:", string.format("|c"..FactionInfo[rank][5].."%s|r", FactionInfo[rank][4]), r, g, b)
		-- GameTooltip:AddDoubleLine("Rep:", string.format("%s/%s (%d%%)", BreakUpLargeNumbers(value-start), BreakUpLargeNumbers(cap-start), (value-start)/(cap-start)*100), r, g, b, 1, 1, 1)
		-- GameTooltip:AddDoubleLine("Remaining:", string.format("%s", BreakUpLargeNumbers(cap-value)), r, g, b, 1, 1, 1)

		if C_Reputation.IsFactionParagon(factionID) then
			local currentValue, threshold = C_Reputation.GetFactionParagonInfo(factionID)
			GameTooltip:AddDoubleLine(L["ParagonRep"], currentValue.."/"..threshold.." ("..floor(currentValue/threshold*100).."%)", .6,.8,1, 1,1,1)
		end

		GameTooltip:Show()
	end
end

local artifact_update = function(self, event)
	local data    = {};
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem();
	if(C_AzeriteItem.HasActiveAzeriteItem() and azeriteItemLocation) then
		local currentXP, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation);
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation); 
		data.id       = 1;
		data.level    = currentLevel;
		data.current  = currentXP;
		data.max  	  = totalLevelXP;
	end
	
	if data.id ~= nil then
		Artifact:ClearAllPoints()
		Artifact:SetMinMaxValues(0, data.max)
		Artifact:SetValue(data.current)

		Artifact:Show()
	else
		Artifact:Hide()
	end
	update()
end

function GetArtifactName()
	return "艾泽拉斯之心"
end

local showArtifactTooltip = function(self) 
	local data    = {};
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem();
	if(C_AzeriteItem.HasActiveAzeriteItem() and azeriteItemLocation) then
		local currentXP, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation);
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation); 
		data.id       = 1;
		data.level    = currentLevel;
		data.current  = currentXP;
		data.max  	  = totalLevelXP;
	end
	
	if data.id ~= nil then
		local remaining         = data.max - data.current;
		local progress          = data.current / data.max;
	
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:AddLine(name, COLOR.r, COLOR.g, COLOR.b)
		GameTooltip:AddDoubleLine(GetArtifactName(), data.current.."/"..data.max.." ("..floor(progress*100).."%)", .6,.8,1, 1,1,1)

		GameTooltip:Show()
	end
end

-- events
Experience:RegisterEvent("PLAYER_ENTERING_WORLD")
Experience:RegisterEvent("PLAYER_LEVEL_UP")
Experience:RegisterEvent("PLAYER_XP_UPDATE")
Experience:RegisterEvent("UPDATE_EXHAUSTION")
Experience:SetScript("OnEvent", experience_update)
Experience:SetScript("OnEnter", function() showExperienceTooltip(Experience) end)
Experience:SetScript("OnLeave", function() GameTooltip:Hide() end)

Reputation:RegisterEvent("PLAYER_ENTERING_WORLD")
Reputation:RegisterEvent("PLAYER_LEVEL_UP")
Reputation:RegisterEvent("UPDATE_EXHAUSTION")
Reputation:RegisterEvent("UPDATE_FACTION")
Reputation:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
Reputation:SetScript("OnEvent", reputation_update)
Reputation:SetScript("OnEnter", function() showReputationTooltip(Reputation) end)
Reputation:SetScript("OnLeave", function() GameTooltip:Hide() end)

Artifact:RegisterEvent("PLAYER_ENTERING_WORLD")
Artifact:RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
Artifact:SetScript("OnEvent", artifact_update)
Artifact:SetScript("OnEnter", function() showArtifactTooltip(Artifact) end)
Artifact:SetScript("OnLeave", function() GameTooltip:Hide() end)
