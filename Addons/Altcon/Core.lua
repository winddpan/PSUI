------------------------------------------------------------
-- Core.lua
--
-- Abin
-- 2016-10-20
------------------------------------------------------------

local type = type
local pairs = pairs
local ipairs = ipairs
local strmatch = strmatch
local wipe = wipe
local time = time
local format = format
local IsAddOnLoaded = IsAddOnLoaded
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemID = GetContainerItemID
local strfind = strfind
local tonumber = tonumber
local IsResting = IsResting

local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local C_Garrison = C_Garrison
local  C_ChallengeMode = C_ChallengeMode
local LibScanTip = LibScanTip

local PATTERN_KEYSTONE_NAME = gsub(CHALLENGE_MODE_KEYSTONE_NAME, "%%s", "(.+)")
local PATTERN_KEYSTONE_DEPLETED = CHALLENGE_MODE_KEYSTONE_DEPLETED
local PATTERN_KEYSTONE_LEVEL = gsub(CHALLENGE_MODE_ITEM_POWER_LEVEL, "%%d", "(%%d+)")

local addon = LibAddonManager:CreateAddon(...)
local L = addon.L

addon:RegisterDB("AltconDB", 1)
addon:RegisterSlashCmd("altcon")

function addon:OnInitialize(db, dbNew, chardb, chardbNew)
	db.currentResetTime = nil
	if not db.weeklyReset then
		db.weeklyReset = LibServerResetTime:GetNextWeeklyResetTime()
	elseif db.weeklyReset <= time() then
		db.weeklyReset = LibServerResetTime:GetNextWeeklyResetTime()
		self:EmptyWeeklyData()
	end

	local profile, data
	for profile, data in pairs(db.profiles) do
		if type(data.research) ~= "table" then
			if data == chardb then
				wipe(data)
				data.research = {}
				data.challenge = {}
			else
				db.profiles[profile] = nil
			end
		else
			if self:IsDataEmpty(data) then
				db.profiles[profile] = nil
			end
		end

	end

	chardb.profile = self:GetCurProfileName()
	chardb.class = self.class

	self:BroadcastEvent("OnInitialize", db, dbNew, chardb, chardbNew)

	LibServerResetTime:RegisterNotify(self)
	self:RegisterEvent("GARRISON_LANDINGPAGE_SHIPMENTS", "UpdateNoteOrder")
	self:RegisterEvent("SHIPMENT_CRAFTER_CLOSED", "RefreshShipment")
	self:RegisterEvent("SHIPMENT_UPDATE")
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	self:RegisterEvent("CHALLENGE_MODE_START", "DelayCheckKeystone")
	self:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	self:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE")

	self.challengeMaps = C_ChallengeMode.GetMapTable()
	--C_ChallengeMode.GetMapTable(self.challengeMaps)
	C_ChallengeMode.RequestMapInfo()

	self:CURRENCY_DISPLAY_UPDATE()
	self:RefreshShipment()
	self:DelayCheckKeystone()
end


function addon:IsDataEmpty(data)
	return not data.research.start and not data.challenge.completed and not data.challenge.key and not data.resource and data ~= self.chardb
end

function addon:CHALLENGE_MODE_MAPS_UPDATE()
	local highest = 0
	local _, mapId
	for _, mapId in ipairs(self.challengeMaps) do
		local _, _, level = C_ChallengeMode.GetMapPlayerStats(mapId)
		if level and level > highest then
		    highest = level
		end
	end

	if highest == 0 then
		highest = nil
	end

	if highest ~= self.chardb.challenge.completed then
		self.chardb.challenge.completed = highest
		self:BroadcastEvent("OnDataUpdate", self.chardb)
	end
end

function addon:CHALLENGE_MODE_COMPLETED()
	local _, level = C_ChallengeMode.GetCompletionInfo()
	if level and level > (self.chardb.challenge.completed or 0) then
		self.chardb.challenge.completed = level
		self:BroadcastEvent("OnDataUpdate", self.chardb)
	end
	self:DelayCheckKeystone()
end

function addon:RefreshShipment()
	C_Garrison.RequestLandingPageShipmentInfo()
end

function addon:DelayCheckKeystone()
	self:RegisterTick(1)
end

function addon:OnTick()
	self:UnregisterTick()
	self:UpdateKeystone()
end

function addon:SHIPMENT_UPDATE(success)
	if success then
		self:UpdateNoteOrder()
	end
end

function addon:CURRENCY_DISPLAY_UPDATE(...)
	local _, amount = GetCurrencyInfo(1220)
	if amount and amount > 0 then
		self.chardb.resource = amount
	else
		self.chardb.resource = nil
	end
end

local LOOT_PATTERN = gsub(LOOT_ITEM_SELF, "%%s", "(.+)")
function addon:CHAT_MSG_LOOT(arg1)
	local _, _, link = strfind(arg1, LOOT_PATTERN)
	if not link then
		return
	end

	local _, _, id = strfind(link, "item:(%d+)")
	if id == "139390" then
		self.chardb.research.secondStart = nil
		C_Garrison.RequestLandingPageShipmentInfo()
	elseif id == "138019" then
		self:DelayCheckKeystone()
	end
end

function addon:EmptyWeeklyData(notify)
	local profile, data
	for profile, data in pairs(self.db.profiles) do
		wipe(data.challenge)
		if notify then
			self:BroadcastEvent("OnDataUpdate", data)
		end
	end
end

function addon:OnServerReset(key)
	if key == "weekly" then
		self:EmptyWeeklyData(1)
	end
end

function addon:GetDisplayName(profile)
	local name, realm = strmatch(profile, "(.+) %- (.+)")
	if realm == self.realm then
		return name
	end
	return profile
end

function addon:GetDisplayColor(class)
	local data = RAID_CLASS_COLORS[class]
	if data then
		return data.r, data.g, data.b
	end
end

function addon:UpdateNoteOrder()
	if not self.itemName then
		return
	end

	local newReady, newTotal, newStart, newDuration
	local shipments = C_Garrison.GetLooseShipments(3)
	local i
	for i = 1, #shipments do
		local name, _, _, ready, total, start, duration = C_Garrison.GetLandingPageShipmentInfoByContainerID(shipments[i])
		if name and name == self.itemName then
			newReady, newTotal, newStart, newDuration = ready, total, start, duration
			break
		end
	end

	local research = self.chardb.research
	if research.ready ~= newReady or research.total ~= newTotal or research.start ~= newStart or research.duration ~= newDuration then
		if (newTotal or 0) < 2 then
			research.secondStart = nil
		elseif research.total == 1 then
			research.secondStart = time()
		end
		research.ready, research.total, research.start, research.duration = newReady, newTotal, newStart, newDuration
		self:BroadcastEvent("OnDataUpdate", self.chardb)
	end
end

local CURRENT_BONUS = 30 * 3600 -- 30 hours

function addon:GetDataReadyCount(data)
	local research = data.research
	if not research.start then
		return 0, 0, 0
	end

	local now = time()
	local remain = research.start + research.duration - now
	if remain > 0 then
		return research.ready, research.total, remain
	end

	local ready = research.ready + 1
	if ready >= research.total then
		return ready, research.total, 0
	end

	local assumeRemain
	if research.secondStart then
		assumeRemain = research.secondStart + research.duration - now
	else
		assumeRemain = remain + research.duration - CURRENT_BONUS
	end

	return ready, research.total, assumeRemain
end

local function GetKeystoneInfo(bag, slot)
	LibScanTip:CallMethod("SetBagItem", bag, slot)
	local _, _, name = strfind(LibScanTip:GetText(1), PATTERN_KEYSTONE_NAME)
	if not name then
		return
	end

	local level, depleted

	local i
	for i = 2, 6 do
		local line = LibScanTip:GetText(i)
		if not depleted then
			if line == PATTERN_KEYSTONE_DEPLETED then
				 depleted = 1
			end
		end

		if not level then
			local _, _, arg1 = strfind(line, PATTERN_KEYSTONE_LEVEL)
			if arg1 then
				level = tonumber(arg1)
			end
		end
	end

	return name, level or 2, depleted
end

local function FindKeystone()
	local bag, slot
	for bag = 0, 4 do
    		for slot = 1, GetContainerNumSlots(bag) do
			if GetContainerItemID(bag, slot) == 138019 then
				return GetKeystoneInfo(bag, slot)
			end
    		end
  	end
end

function addon:UpdateKeystone()
	self.needUpdateKeystone = nil
	local challenge = self.chardb.challenge
	local key, level, depleted = FindKeystone()
	if key ~= challenge.key or level ~= challenge.level or depleted ~= challenge.depleted then
		challenge.key, challenge.level, challenge.depleted = key, level, depleted
		self:BroadcastEvent("OnDataUpdate", self.chardb)
	end
end

LibItemQuery:QueryItem(139390, function(id, name)
	addon.itemName = name
end)