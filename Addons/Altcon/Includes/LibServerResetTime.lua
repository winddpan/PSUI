--------------------------------------------------------------
-- LibServerResetTime
--
-- A library for obtaining daily/weekly quest resetting times, most core codes were copied from "SavedInstances".
--
-- API:
--
-- LibServerResetTime:GetRegion() -- Returns server region: "US", "EU", "CN", "TW", "KR", etc
-- LibServerResetTime:GetNextDailyResetTime() -- Returns the next daily reset time
-- LibServerResetTime:GetNextWeeklyResetTime() -- Returns the next weekly reset time
-- LibServerResetTime:RegisterNotify(object) -- Register a callback which will be called when a daily/weekly reset time occurs, object can be type or "function" or "table"
                                             -- for function, object("daily") or object("weekly") are called
					     -- for table, object:OnServerReset("daily") or object:OnServerReset("weekly") are called
-- LibServerResetTime:UnregisterNotify(object) -- Unregister a callback so it will no longer receive notifications
-- LibServerResetTime:IsNotifyRegistered(object) -- Checks if a callback is registered

-- Abin
-- 2016-10-27
--------------------------------------------------------------

local type = type
local CalendarGetDate = CalendarGetDate
local tonumber = tonumber
local date = date
local GetGameTime = GetGameTime
local floor = floor
local GetCVar = GetCVar
local GetCurrentRegion = GetCurrentRegion
local GetRealmName = GetRealmName
local strupper = strupper
local GetQuestResetTime = GetQuestResetTime
local time = time
local tinsert = tinsert
local tremove = tremove
local ipairs = ipairs

local VERSION = 1.01

local lib = _G.LibServerResetTime
if type(lib) == "table" then
	local version = lib.version
	if type(version) == "number" and version >= VERSION then
		return
	end
else
	lib = {}
	_G.LibServerResetTime = lib
end

lib.version = VERSION

local notifyQueue = lib.notifyQueue
if not notifyQueue then
	notifyQueue = {}
	lib.notifyQueue = notifyQueue
end

local function GetServerOffset()
	if lib.serverOffset then
		return lib.serverOffset
	end

	local serverDay = CalendarGetDate() - 1 -- 1-based starts on Sun
	local localDay = tonumber(date("%w")) -- 0-based starts on Sun
	local serverHour, serverMinute = GetGameTime()
	local localHour, localMinute = tonumber(date("%H")), tonumber(date("%M"))

	if serverDay == (localDay + 1) % 7 then -- server is a day ahead
		serverHour = serverHour + 24
	elseif localDay == (serverDay + 1) % 7 then -- local is a day ahead
		localHour = localHour + 24
	end

	local server = serverHour + serverMinute / 60
	local localT = localHour + localMinute / 60
	local offset = floor((server - localT) * 2 + 0.5) / 2
	lib.serverOffset = offset
	return offset
end

function lib:GetRegion()
	if self.serverRegion then
		return self.serverRegion
	end

	local reg = GetCVar("portal")
	if reg == "public-test" then -- PTR uses US region resets, despite the misleading realm name suffix
		reg = "US"
	end

	if not reg or #reg ~= 2 then
		local gcr = GetCurrentRegion()
		reg = gcr and ({ "US", "KR", "EU", "TW", "CN" })[gcr]
	end

	if not reg or #reg ~= 2 then
		reg = (GetCVar("realmList") or ""):match("^(%a+)%.")
	end

	if not reg or #reg ~= 2 then -- other test realms?
		reg = (GetRealmName() or ""):match("%((%a%a)%)")
	end

	if reg and #reg == 2 then
		self.serverRegion = strupper(reg)
		return self.serverRegion
	end
end

function lib:GetNextDailyResetTime()
	local now = time()
	if self.nextDailyResetTime and self.nextDailyResetTime >= now then
		return self.nextDailyResetTime
	end

	local resettime = GetQuestResetTime()
	if resettime and resettime > 0 and resettime <= 24 * 3600 + 30 then
		self.nextDailyResetTime = now + resettime
		return self.nextDailyResetTime
	end
end

function lib:GetNextWeeklyResetTime()
	if self.nextWeeklyResetTime and self.nextWeeklyResetTime >= time() then
		return self.nextWeeklyResetTime
	end

	local region = self:GetRegion()
	if not region then
		return
	end

	local nightlyReset = self:GetNextDailyResetTime()
	if not nightlyReset then
		return
	end

	local resetDays = { DLHoffset = 0 }
	if region == "US" then
		resetDays["2"] = true -- tuesday
		-- ensure oceanic servers over the dateline still reset on tues UTC (wed 1/2 AM server)
		resetDays.DLHoffset = -3
	elseif region == "EU" then
		resetDays["3"] = true -- wednesday
	elseif region == "CN" or region == "KR" or region == "TW" then -- XXX: codes unconfirmed
		resetDays["4"] = true -- thursday
	else
		resetDays["2"] = true -- tuesday?
	end

	local offset = (GetServerOffset() + resetDays.DLHoffset) * 3600

	while not resetDays[date("%w", nightlyReset + offset)] do
		nightlyReset = nightlyReset + 24 * 3600
	end

	self.nextWeeklyResetTime = nightlyReset
	return nightlyReset
end

function lib:RegisterNotify(object)
	if type(object) == "function" or type(object) == "table" then
		local index = self:IsNotifyRegistered(object)
		if not index then
			tinsert(notifyQueue, object)
			self.frame:Show()
		end
	end
end

function lib:UnregisterNotify(object)
	local index = self:IsNotifyRegistered(object)
	if index then
		tremove(notifyQueue, index)
		if #notifyQueue == 0 then
			self.frame:Hide()
		end
	end
end

function lib:IsNotifyRegistered(object)
	local k, v
	for k, v in ipairs(notifyQueue) do
		if v == object then
			return k
		end
	end
end

local function NotifyQueue(...)
	local _, object
	for _, object in ipairs(notifyQueue) do
		if type(object) == "function" then
			object(...)
		else
			local func = object.OnServerReset
			if type(func) == "function" then
				func(object, ...)
			end
		end
	end
end

local frame = lib.frame
if not frame then
	frame = CreateFrame("Frame")
	lib.frame = frame
	frame:Hide()
end

frame:SetScript("OnUpdate", function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < 1 then
		return
	end
	self.elapsed = 0

	local now = time()
	local prevDailyTime = self.prevDailyTime
	if not prevDailyTime then
		self.prevDailyTime = lib:GetNextDailyResetTime()
	elseif prevDailyTime < now then
		self.prevDailyTime = lib:GetNextDailyResetTime()
		NotifyQueue("daily")
	end

	local prevWeeklyTime = self.prevWeeklyTime
	if not prevWeeklyTime then
		self.prevWeeklyTime = lib:GetNextWeeklyResetTime()
	elseif prevWeeklyTime < now then
		self.prevWeeklyTime = lib:GetNextWeeklyResetTime()
		NotifyQueue("weekly")
	end
end)