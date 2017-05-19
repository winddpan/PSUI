-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.Unit.HealthBar", version) then
	return
end

_DEBUFF_ABILITIES = {
	["WARRIOR"] = false,
	["ROGUE"] = false,
	["HUNTER"] = false,
	["MAGE"] = { Curse = true, },
	["DRUID"] = { Poison = true, Curse = true, Magic = true, },
	["PALADIN"] = { Poison = true, Disease = true, Magic = true, },
	["PRIEST"] = { Disease = true, Magic = true, },
	["SHAMAN"] = { Curse = true, Magic = true, },
	["WARLOCK"] = { Magic = true, },
	["DEATHKNIGHT"] = false,
	["MONK"] = { Poison = true, Disease = true, Magic = true, },
	["DEMONHUNTER"] = false,
}

_DEBUFF_ABLE = _DEBUFF_ABILITIES[select(2, UnitClass('player'))] or false
_DEBUFF_ABILITIES = nil

_ColorMap = {
	Magic = DebuffTypeColor.Magic,
	Curse = DebuffTypeColor.Curse,
	Disease = DebuffTypeColor.Disease,
	Poison = DebuffTypeColor.Poison,

	GlobalDefault = ColorType(0, 1, 0),

    HUNTER = RAID_CLASS_COLORS.HUNTER,
    WARLOCK = RAID_CLASS_COLORS.WARLOCK,
    PRIEST = RAID_CLASS_COLORS.PRIEST,
    PALADIN = RAID_CLASS_COLORS.PALADIN,
    MAGE = RAID_CLASS_COLORS.MAGE,
    ROGUE = RAID_CLASS_COLORS.ROGUE,
    DRUID = RAID_CLASS_COLORS.DRUID,
    SHAMAN = RAID_CLASS_COLORS.SHAMAN,
    WARRIOR = RAID_CLASS_COLORS.WARRIOR,
    DEATHKNIGHT = RAID_CLASS_COLORS.DEATHKNIGHT,
    MONK = RAID_CLASS_COLORS.MONK,
    DEMONHUNTER = RAID_CLASS_COLORS.DEMONHUNTER,
}

function HealthBar_OnStateChanged(self)
	if not self.Unit then return end
	local value = self.Value
	if not value then return end

	local color
	local r, g, b
	local min, max = self:GetMinMaxValues()
	if ( (value < min) or (value > max) ) then return end
	if ( (max - min) > 0 ) then
		value = (value - min) / (max - min)
	else
		value = 0
	end

	-- Choose color
	if self.UseDebuffColor and not UnitCanAttack("player", self.Unit) then
		color = self.__HealthBar_DebuffType
	end

	local colorInfo

	if not color then
		color = self.DefaultColor and "Default" or self.UseClassColor and select(2, UnitClass(self.Unit)) or "GlobalDefault"

		if self.UseSmoothColor then
			value = floor(value * 10) / 10

			if self.__HealthBar_PreColor == color and self.__HealthBar_PreValue == value then return end

			if color == "Default" then
				colorInfo = self.DefaultColor
			else
				colorInfo = _ColorMap[color]
			end
			r, g, b = colorInfo.r, colorInfo.g, colorInfo.b

			self.__HealthBar_PreValue = value

			-- Smooth the color
			if value > 0.5 then
				r = (1 - value) * 2 * (1 - r) + r
				b = b - b * (1-value) * 2
			else
				r = 1
				g = g * value * 2
				b = 0
			end
		else
			if self.__HealthBar_PreColor == color then return end

			if color == "Default" then
				colorInfo = self.DefaultColor
			else
				colorInfo = _ColorMap[color]
			end
			r, g, b = colorInfo.r, colorInfo.g, colorInfo.b
		end
	else
		if self.__HealthBar_PreColor == color then return end

		colorInfo = _ColorMap[color]
		r, g, b = colorInfo.r, colorInfo.g, colorInfo.b
	end

	self.__HealthBar_PreColor = color

	return self:SetStatusBarColor(r, g, b)
end

function GetDebuffType(self)
	local unit = self.Unit
	local index = 1
	local name, _, dtype
	local debuffType

	while unit do
		name, _, _, _, dtype = UnitAura(unit, index, "HARMFUL")

		if name then
			if dtype == "Magic" and _DEBUFF_ABLE["Magic"] then
				debuffType = "Magic"
				break
			elseif dtype == "Curse" and _DEBUFF_ABLE["Curse"]  then
				debuffType = "Curse"
				break
			elseif dtype == "Disease" and _DEBUFF_ABLE["Disease"]  then
				debuffType = "Disease"
				break
			elseif dtype == "Poison" and _DEBUFF_ABLE["Poison"]  then
				debuffType = "Poison"
				break
			end
		else
			break
		end

		index = index + 1
	end

	return debuffType
end

__Doc__[[The health bar with debuff state]]
class "HealthBar"
	inherit "StatusBar"
	extend "IFHealth"

	if _DEBUFF_ABLE then
		extend "IFAura"
	end

	local function OnValueChanged(self, value)
		self = self.Owner
		self:SetValue(value)
		return HealthBar_OnStateChanged(self)
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetUnitHealth(self, health, max)
		if max then self:SetMinMaxValues(0, max) end
		if health then
			if self.Smoothing then
				self.SmoothValue:SetValue(health, max)
			else
				self:SetValue(health)
				return HealthBar_OnStateChanged(self, health)
			end
		end
	end

	function UpdateAuras(self)
		if not self.UseDebuffColor then
			self.__HealthBar_DebuffType = false
			return
		end

		local debuffType = GetDebuffType(self)

		if self.__HealthBar_DebuffType ~= debuffType then
			self.__HealthBar_DebuffType = debuffType or false
			return HealthBar_OnStateChanged(self)
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether smoothing the value changes]]
	property "Smoothing" { Type = Boolean }

	__Doc__[[The delay time for smoothing value changes]]
	property "SmoothDelay" {
		Type = PositiveNumber,
		Set  = function(self, delay) self.SmoothValue.SmoothDelay = delay end,
		Get  = function(self) return self.SmoothValue.SmoothDelay end,
	}

	property "SmoothValue" {
		Set = false,
		Default = function(self)
			local obj = SmoothValue()
			obj.Owner = self
			obj.OnValueChanged = OnValueChanged
			return obj
		end,
	}

	__Doc__[[Whether use the debuff color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseDebuffColor" { Type = Boolean, }

	__Doc__[[Whether use the unit's class color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseClassColor" { Type = Boolean, }

	__Doc__[[Whether smoothing the color changing]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseSmoothColor" { Type = Boolean, }

	__Doc__[[The default status bar's color]]
	__Handler__(HealthBar_OnStateChanged)
	property "DefaultColor" { Type = ColorType }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function HealthBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
		self.StatusBarColor = _ColorMap.GlobalDefault

		self.MouseEnabled = false
		self.FrameStrata = "LOW"

		self.__HealthBar_DebuffType = false
	end
endclass "HealthBar"

__Doc__[[The frequent health bar with debuff state]]
class "HealthBarFrequent"
	inherit "StatusBar"
	extend "IFHealthFrequent"

	if _DEBUFF_ABLE then
		extend "IFAura"
	end

	local function OnValueChanged(self, value)
		self.Owner:SetValue(value)
		return HealthBar_OnStateChanged(self.Owner)
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetUnitHealth(self, health, max)
		if max then self:SetMinMaxValues(0, max) end
		if health then
			if self.Smoothing then
				self.SmoothValue:SetValue(health, max)
			else
				self:SetValue(health)
				return HealthBar_OnStateChanged(self, health)
			end
		end
	end

	function UpdateAuras(self)
		if not self.UseDebuffColor then
			self.__HealthBar_DebuffType = false
			return
		end

		local debuffType = GetDebuffType(self)

		if self.__HealthBar_DebuffType ~= debuffType then
			self.__HealthBar_DebuffType = debuffType or false
			return HealthBar_OnStateChanged(self)
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether smoothing the value changes]]
	property "Smoothing" { Type = Boolean }

	__Doc__[[The delay time for smoothing value changes]]
	property "SmoothDelay" {
		Type = PositiveNumber,
		Set  = function(self, delay) self.SmoothValue.SmoothDelay = delay end,
		Get  = function(self) return self.SmoothValue.SmoothDelay end,
	}

	property "SmoothValue" {
		Set = false,
		Default = function(self)
			local obj = SmoothValue()
			obj.Owner = self
			obj.OnValueChanged = OnValueChanged
			return obj
		end,
	}

	__Doc__[[Whether use the debuff color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseDebuffColor" { Type = Boolean, }

	__Doc__[[Whether use the unit's class color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseClassColor" { Type = Boolean, }

	__Doc__[[Whether smoothing the color changing]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseSmoothColor" { Type = Boolean, }

	__Doc__[[The default status bar's color]]
	__Handler__(HealthBar_OnStateChanged)
	property "DefaultColor" { Type = ColorType }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function HealthBarFrequent(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
		self.StatusBarColor = _ColorMap.GlobalDefault

		self.MouseEnabled = false
		self.FrameStrata = "LOW"

		self.__HealthBar_DebuffType = false
	end
endclass "HealthBarFrequent"
