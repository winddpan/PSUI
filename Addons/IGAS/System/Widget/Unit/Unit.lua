------------------------------------------------------
-- Author : kurapica.igas@gmail.com
-- Create Date 	: 2012/06/28
-- ChangeLog

------------------------------------------------------
local version = 8

if not IGAS:NewAddon("IGAS.Widget.Unit", version) then
	return
end

------------------------------------------------------
-- Header for System.Widget.Unit.*
------------------------------------------------------
import "System"
import "System.Widget"

namespace "System.Widget.Unit"

------------------------------------------------------
-- Constants
------------------------------------------------------
ClassPowerMap = {
	[0] = "MANA",
	[1] = "RAGE",
	[2] = "FOCUS",
	[3] = "ENERGY",
	[4] = "COMBO_POINTS",
	[5] = "RUNES",
	[6] = "RUNIC_POWER",
	[7] = "SOUL_SHARDS",
	[8] = "LUNAR_POWER",
	[9] = "HOLY_POWER",
	[10] = "ALTERNATE_POWER",
	[11] = "MAELSTROM",
	[12] = "CHI",
	[13] = "INSANITY",
	[14] = "OBSOLETE",
	[15] = "OBSOLETE2",
	[16] = "ARCANE_CHARGES",
	[17] = "FURY",
	[18] = "PAIN",
}

for i, v in ipairs(ClassPowerMap) do
	ClassPowerMap[v] = i
end

CLASS_ICON_TCOORDS = {
	["WARRIOR"]		= {0, 0.25, 0, 0.25},
	["MAGE"]		= {0.25, 0.49609375, 0, 0.25},
	["ROGUE"]		= {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"]		= {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"]		= {0, 0.25, 0.25, 0.5},
	["SHAMAN"]	 	= {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"]		= {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"]		= {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"]		= {0, 0.25, 0.5, 0.75},
	["DEATHKNIGHT"]	= {0.25, .5, 0.5, .75},
	["MONK"]		= {0.5, 0.73828125, 0.5, .75},
	["DEMONHUNTER"]	= {0.7421875, 0.98828125, 0.5, 0.75},
}

RAID_CLASS_COLORS = {
	["HUNTER"] = { r = 0.67, g = 0.83, b = 0.45, colorStr = "ffabd473" },
	["WARLOCK"] = { r = 0.53, g = 0.53, b = 0.93, colorStr = "ff8788ee" },
	["PRIEST"] = { r = 1.0, g = 1.0, b = 1.0, colorStr = "ffffffff" },
	["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73, colorStr = "fff58cba" },
	["MAGE"] = { r = 0.25, g = 0.78, b = 0.92, colorStr = "ff3fc7eb" },
	["ROGUE"] = { r = 1.0, g = 0.96, b = 0.41, colorStr = "fffff569" },
	["DRUID"] = { r = 1.0, g = 0.49, b = 0.04, colorStr = "ffff7d0a" },
	["SHAMAN"] = { r = 0.0, g = 0.44, b = 0.87, colorStr = "ff0070de" },
	["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43, colorStr = "ffc79c6e" },
	["DEATHKNIGHT"] = { r = 0.77, g = 0.12 , b = 0.23, colorStr = "ffc41f3b" },
	["MONK"] = { r = 0.0, g = 1.00 , b = 0.59, colorStr = "ff00ff96" },
	["DEMONHUNTER"] = { r = 0.64, g = 0.19, b = 0.79, colorStr = "ffa330c9" },
}

FIRE_TOTEM_SLOT = 1
EARTH_TOTEM_SLOT = 2
WATER_TOTEM_SLOT = 3
AIR_TOTEM_SLOT = 4

STANDARD_TOTEM_PRIORITIES = {1, 2, 3, 4}

SHAMAN_TOTEM_PRIORITIES = {
    EARTH_TOTEM_SLOT,
    FIRE_TOTEM_SLOT,
    WATER_TOTEM_SLOT,
    AIR_TOTEM_SLOT,
}

PowerBarColor = {}
PowerBarColor["MANA"] = { r = 0.00, g = 0.00, b = 1.00 }
PowerBarColor["RAGE"] = { r = 1.00, g = 0.00, b = 0.00, fullPowerAnim=true }
PowerBarColor["FOCUS"] = { r = 1.00, g = 0.50, b = 0.25, fullPowerAnim=true }
PowerBarColor["ENERGY"] = { r = 1.00, g = 1.00, b = 0.00, fullPowerAnim=true }
PowerBarColor["COMBO_POINTS"] = { r = 1.00, g = 0.96, b = 0.41 }
PowerBarColor["RUNES"] = { r = 0.50, g = 0.50, b = 0.50 }
PowerBarColor["RUNIC_POWER"] = { r = 0.00, g = 0.82, b = 1.00 }
PowerBarColor["SOUL_SHARDS"] = { r = 0.50, g = 0.32, b = 0.55 }
PowerBarColor["LUNAR_POWER"] = { r = 0.30, g = 0.52, b = 0.90, atlas="_Druid-LunarBar" }
PowerBarColor["HOLY_POWER"] = { r = 0.95, g = 0.90, b = 0.60 }
PowerBarColor["MAELSTROM"] = { r = 0.00, g = 0.50, b = 1.00, atlas = "_Shaman-MaelstromBar", fullPowerAnim=true }
PowerBarColor["INSANITY"] = { r = 0.40, g = 0, b = 0.80, atlas = "_Priest-InsanityBar"}
PowerBarColor["CHI"] = { r = 0.71, g = 1.0, b = 0.92 }
PowerBarColor["ARCANE_CHARGES"] = { r = 0.1, g = 0.1, b = 0.98 }
PowerBarColor["FURY"] = { r = 0.788, g = 0.259, b = 0.992, atlas = "_DemonHunter-DemonicFuryBar", fullPowerAnim=true }
PowerBarColor["PAIN"] = { r = 255/255, g = 156/255, b = 0, atlas = "_DemonHunter-DemonicPainBar", fullPowerAnim=true }
-- vehicle colors
PowerBarColor["AMMOSLOT"] = { r = 0.80, g = 0.60, b = 0.00 }
PowerBarColor["FUEL"] = { r = 0.0, g = 0.55, b = 0.5 }
PowerBarColor["STAGGER"] = { {r = 0.52, g = 1.0, b = 0.52}, {r = 1.0, g = 0.98, b = 0.72}, {r = 1.0, g = 0.42, b = 0.42},}

-- these are mostly needed for a fallback case (in case the code tries to index a power token that is missing from the table,
-- it will try to index by power type instead)

PowerBarColor[0] = PowerBarColor["MANA"]
PowerBarColor[1] = PowerBarColor["RAGE"]
PowerBarColor[2] = PowerBarColor["FOCUS"]
PowerBarColor[3] = PowerBarColor["ENERGY"]
PowerBarColor[4] = PowerBarColor["COMBO_POINTS"]
PowerBarColor[5] = PowerBarColor["RUNES"]
PowerBarColor[6] = PowerBarColor["RUNIC_POWER"]
PowerBarColor[7] = PowerBarColor["SOUL_SHARDS"]
PowerBarColor[8] = PowerBarColor["LUNAR_POWER"]
PowerBarColor[9] = PowerBarColor["HOLY_POWER"]
PowerBarColor[10] = PowerBarColor["ALTERNATE_POWER"]
PowerBarColor[11] = PowerBarColor["MAELSTROM"]
PowerBarColor[12] = PowerBarColor["CHI"]
PowerBarColor[13] = PowerBarColor["INSANITY"]
PowerBarColor[14] = PowerBarColor["OBSOLETE"]
PowerBarColor[15] = PowerBarColor["OBSOLETE2"]
PowerBarColor[16] = PowerBarColor["ARCANE_CHARGES"]
PowerBarColor[17] = PowerBarColor["FURY"]
PowerBarColor[18] = PowerBarColor["PAIN"]

DebuffTypeColor = {}
DebuffTypeColor["none"] = { r = 0.80, g = 0, b = 0 }
DebuffTypeColor["Magic"]    = { r = 0.20, g = 0.60, b = 1.00 }
DebuffTypeColor["Curse"]    = { r = 0.60, g = 0.00, b = 1.00 }
DebuffTypeColor["Disease"]  = { r = 0.60, g = 0.40, b = 0 }
DebuffTypeColor["Poison"]   = { r = 0.00, g = 0.60, b = 0 }
DebuffTypeColor[""] = DebuffTypeColor["none"]

------------------------------------------------------
-- UnitList Definition
------------------------------------------------------
__Doc__[[UnitList is used to contain ui elements that with the same unit for some special using]]
class "UnitList"
	import "System.Collections"
	extend "IList"

	------------------------------------------------------
	-- Event Manager
	------------------------------------------------------
	_UnitListEventDistribution = _UnitListEventDistribution or setmetatable({}, {
		__index = function (self, key)
			if type(key) == "string" then
				rawset(self, key, {})
			end
			return rawget(self, key)
		end
	})
	_UnitListEventManager = _UnitListEventManager or CreateFrame("Frame")
	_UnitListEventManager:Hide()
	_UnitListEventManager:SetScript("OnEvent", function(self, event, ...)
		for _, lst in ipairs(_UnitListEventDistribution[event]) do
			lst:ParseEvent(event, ...)
		end
	end)

	------------------------------------------------------
	-- Iterator
	------------------------------------------------------
	_UnitList_Info = _UnitList_Info or {}
	_UnitList_Prev = _UnitList_Prev or {}
	_UnitList_Next = _UnitList_Next or {}
	_UnitList_Traverse = _UnitList_Traverse or {}

	local function traversalUnit(self, key)
		local k, v = next(self, key)

		while k do
			if type(k) == "string" and not k:match("^_") and type(v) == "table" then
				return k, k
			end
			k, v = next(self, k)
		end
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the unit list's elements is added or removed]]
	event "OnUnitListChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Parse event, Overridable</desc>
		<param name="event">the event's name</param>
		<param name="...">the arguments</param>
	]]
	function ParseEvent(self, event, unit, ...)
		if self:HasUnit(unit) then
			return self:EachK(unit, "Refresh", ...)
		end
	end

	__Doc__[[
		<desc>Register an event</desc>
		<param name="event">string, the event name</param>
	]]
	function RegisterEvent(self, event)
		_UnitListEventManager:RegisterEvent(event)

		for i, lst in ipairs(_UnitListEventDistribution[event]) do
			if lst == self then
				return
			end
		end
		tinsert(_UnitListEventDistribution[event], self)
	end

	__Doc__[[
		<desc>Undo register an event</desc>
		<param name="event">string, the event name</param>
	]]
	function UnregisterEvent(self, event)
		for i, lst in ipairs(_UnitListEventDistribution[event]) do
			if lst == self then
				tremove(_UnitListEventDistribution[event], i)
				if #_UnitListEventDistribution[event] == 0 then
					_UnitListEventManager:UnregisterEvent(event)
					break
				end
			end
		end
	end

	------------------------------------
	--- Iterate with key
	------------------------------------
	local iterKey = setmetatable({}, {__mode="k"})

	function EachK(self, key, ...)
		iterKey[self] = key
		return IList.Each(self, ...)
	end

	function Each(self, ...)
		iterKey[self] = nil
		return IList.Each(self, ...)
	end

	function GetIterator(self, key)
		key = key or iterKey[self]
		if type(key) == "string" then
			iterKey[self] = nil
			return _UnitList_Traverse[self], self, key:lower()
		else
			return traversalUnit, self, nil
		end
	end

	__Doc__[[
		<desc>Check if UnitList contains items with the unit</desc>
		<param name="unit"></param>
		<return type="boolean"></return>
	]]
	function HasUnit(self, unit)
		unit = type(unit) == "string" and unit:lower() or nil

		if unit and rawget(self, unit) then
			return true
		else
			return false
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function UnitList(self, name)
		if type(name) ~= "string" then
			error("Usage : UnitList(name) - name must be a unique string.", 2)
		end

		local prev = "__UnitList_" .. name .. "_Prev"
		local nxt = "__UnitList_" .. name .. "_Next"

		_UnitList_Info[name] = self
		_UnitList_Prev[self] = prev
		_UnitList_Next[self] = nxt
		_UnitList_Traverse[self] = function (data, key)
			if type(key) == "string" and not key:match("^_") and type(data[key]) == "table" then
				return data[key], data[key]
			elseif type(key) == "table" then
				return key[nxt], key[nxt]
			end
		end
	end

	------------------------------------------------------
	-- __exist
	------------------------------------------------------
	function __exist(name)
		if type(name) == "string" and _UnitList_Info[name] then
			return _UnitList_Info[name]
		end
	end

	------------------------------------------------------
	-- MetaMethod
	------------------------------------------------------
	function __index(self, unit)
		if type(unit) == "string" then
			return rawget(self, unit:lower())
		end
	end

	function __newindex(self, frame, unit)
		if type(frame) == "string" and type(unit) == "function" then
			rawset(self, frame, unit)
			return
		end

		if type(frame) ~= "table" then
			error("key must be a table.", 2)
		end

		if unit ~= nil and ( type(unit) ~= "string" or unit:match("^__") ) then
			error("value not supported.", 2)
		end

		unit = unit and unit:lower()

		if UnitList[unit] then
			error("value not supported.", 2)
		end

		local preKey = _UnitList_Prev[self]
		local nxtKey = _UnitList_Next[self]

		local prev = frame[preKey]
		local next = frame[nxtKey]
		local header = prev

		while type(header) == "table" do
			header = header[preKey]
		end

		-- no change
		if header == unit then
			return
		end

		-- Remove link
		if header then
			if prev == header then
				rawset(self, header, next)
				if next then next[preKey] = prev end
			else
				prev[nxtKey] = next
				if next then next[preKey] = prev end
			end

			frame[preKey] = nil
			frame[nxtKey] = nil
		end

		-- Add link
		if unit then
			local tail = self[unit]

			rawset(self, unit, frame)
			frame[preKey] = unit

			if tail then
				tail[preKey] = frame
				frame[nxtKey] = tail
			end
		end

		Object.Fire(self, "OnUnitListChanged")
	end

	__call = GetIterator
endclass "UnitList"

__Doc__[[SmoothValue is used to smooth the value changes]]
class "SmoothValue"

	local Next = System.Task.Next
	local ThreadCall = System.Task.ThreadCall

	local function process(self)
		self.Processing = true

		local chkTime = GetTime()

		while not self.Disposed and self.NowDelay > 0 do
			Next() -- Wait for next phase

			local now = GetTime()
			local delay = self.NowDelay - (now - chkTime)
			chkTime = now

			if delay < 0 then delay = 0 end
			self.NowDelay = delay

			self.Value = (self.RealValue - self.OldValue) * (1 - delay / self.SmoothDelay) + self.OldValue
			OnValueChanged(self, self.Value)
		end

		self.Processing = false
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the smoothed value is changed]]
	event "OnValueChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetValue(self, value, max)
		self.RealValue = value

		if not self.Processing then
			self.NowDelay = self.SmoothDelay
			self.OldValue = self.Value or 0
			if self.OldValue > max then self.OldValue = max end
			self.TargetValue = value
			if value == self.OldValue then
				self.Value = value
				return OnValueChanged(self, value)
			else
				return ThreadCall(process, self)
			end
		else
			if self.TargetValue > self.OldValue then
				if value > self.TargetValue then
					self.NowDelay = self.SmoothDelay
					self.OldValue = self.Value
					self.TargetValue = value
				end
			else
				if value < self.TargetValue then
					self.NowDelay = self.SmoothDelay
					self.OldValue = self.Value
					self.TargetValue = value
				end
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The delay time for smoothing value changes]]
	property "SmoothDelay" { Type = PositiveNumber, Default = 1 }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function SmoothValue(self)
		self.Processing = false
		self.Disposed = false
		self.OldValue = 0
		self.Value = 0
	end
endclass "SmoothValue"
