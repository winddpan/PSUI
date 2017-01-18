-- Author      : Kurapica
-- Create Date : 2012/11/14
-- Change Log  :
--               2012/12/01 Update for PLAYER_LEVEL_UP, UnitLevel("player") need +1
--               2013/10/15 _PlayerActivePower can't be nil, so stop look the parent environment

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.Unit.IFClassPower", version) then
	return
end

SPEC_WARLOCK_AFFLICTION = 1
SPEC_WARLOCK_DEMONOLOGY = 2
SPEC_WARLOCK_DESTRUCTION = 3
SPEC_PRIEST_SHADOW = 3
SPEC_MONK_MISTWEAVER = 2
SPEC_MONK_BREWMASTER = 1
SPEC_MONK_WINDWALKER = 3
SPEC_PALADIN_RETRIBUTION = 3
SPEC_MAGE_ARCANE = 1
SPEC_SHAMAN_ELEMENTAL = 1
SPEC_SHAMAN_ENHANCEMENT = 2
SPEC_SHAMAN_RESTORATION = 3

SPEC_DRUID_BALANCE = 1
SPEC_DRUID_FERAL = 2
SPEC_DRUID_GUARDIAN = 3
SPEC_DRUID_RESTORATION = 4

CAT_FORM = _G.CAT_FORM

_IFClassPowerUnitList = _IFClassPowerUnitList or UnitList(_Name)

_PlayerClass = select(2, UnitClass("player"))
_PlayerActivePower = false

SPEC_ALL = 0

_ClassMap = {
	ROGUE = {
		[SPEC_ALL] = {
			PowerType = _G.SPELL_POWER_COMBO_POINTS,
			PowerToken = {
				COMBO_POINTS = true,
			},
		},
	},
	PALADIN = {
		[SPEC_PALADIN_RETRIBUTION] = {
			ShowLevel = _G.PALADINPOWERBAR_SHOW_LEVEL,
			PowerType = _G.SPELL_POWER_HOLY_POWER,
			PowerToken = {
				HOLY_POWER = true,
			},
		},
	},
	MAGE = {
		[SPEC_MAGE_ARCANE] = {
			PowerType = _G.SPELL_POWER_ARCANE_CHARGES,
			PowerToken = {
				ARCANE_CHARGES = true,
			},
		},
	},
	DRUID = {
		USE_SHAPESHIFTFORM = true,
		[CAT_FORM] = {
			PowerType = _G.SPELL_POWER_COMBO_POINTS,
			PowerToken = {
				COMBO_POINTS = true,
			},
		},
	},
	PRIEST = {
		[SPEC_PRIEST_SHADOW] = {
			PowerType = _G.SPELL_POWER_MANA,
			PowerToken = {
				MANA = true,
			},
		},
	},
	MONK = {
		[SPEC_MONK_WINDWALKER] = {
			PowerType = _G.SPELL_POWER_CHI,
			PowerToken = {
				CHI = true,
			},
		},
	},
	WARLOCK = {
		[SPEC_ALL] = {
			PowerType = _G.SPELL_POWER_SOUL_SHARDS,
			PowerToken = {
				SOUL_SHARDS = true,
			},
		},
	},
	SHAMAN = {
		[SPEC_SHAMAN_ELEMENTAL] = {
			PowerType = _G.SPELL_POWER_MANA,
			PowerToken = {
				MANA = true,
			},
		},
		[SPEC_SHAMAN_ENHANCEMENT] = {
			PowerType = _G.SPELL_POWER_MANA,
			PowerToken = {
				MANA = true,
			},
		},
	},
}

_PlayerClassMap = _ClassMap[_PlayerClass] or false

function _IFClassPowerUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_POWER_FREQUENT")
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- Check require
	if _PlayerClassMap.USE_SHAPESHIFTFORM then
		self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	end
	if not _PlayerClassMap[SPEC_ALL] then
		self:RegisterEvent("PLAYER_TALENT_UPDATE")
	elseif _PlayerClassMap[SPEC_ALL].ShowLevel and UnitLevel("player") < _PlayerClassMap[0].ShowLevel then
		self:RegisterEvent("PLAYER_LEVEL_UP")
	end

	self.OnUnitListChanged = nil
end

function _IFClassPowerUnitList:ParseEvent(event, unit, powerToken)
	if event == "UNIT_MAXPOWER" then
		if unit ~= "player" then return end

		if _PlayerActivePower and _PlayerActivePower.Max ~= UnitPowerMax("player", _PlayerActivePower.PowerType, _PlayerActivePower.RealPower) then
			_PlayerActivePower.Max = UnitPowerMax("player", _PlayerActivePower.PowerType, _PlayerActivePower.RealPower)
			local power = UnitPower("player", _PlayerActivePower.PowerType, _PlayerActivePower.RealPower)

			for obj in self:GetIterator("player") do
				obj:SetUnitClassPower(power, _PlayerActivePower.Max)
			end
		end
	elseif event == "UNIT_POWER_FREQUENT" then
		if unit ~= "player" then return end

		if _PlayerActivePower and _PlayerActivePower.PowerToken[powerToken] then
			local power = UnitPower("player", _PlayerActivePower.PowerType, _PlayerActivePower.RealPower)

			for obj in self:GetIterator("player") do
				obj:SetUnitClassPower(power, _PlayerActivePower.Max)
			end
		end
	else
		RefreshActivePower(event=="PLAYER_LEVEL_UP" and unit or nil)
	end
end

function RefreshActivePower(trueLevel)
	local map

	if _PlayerClassMap.USE_SHAPESHIFTFORM then
		local shift = GetShapeshiftFormID()
		map = shift and _PlayerClassMap[shift]
	else
		local spec = GetSpecialization() or 1
		map = _PlayerClassMap[spec] or _PlayerClassMap[SPEC_ALL]
	end

	_IFClassPowerUnitList:UnregisterEvent("SPELLS_CHANGED")

	if map then
		_PlayerActivePower = false

		if map.ShowLevel then
			trueLevel = trueLevel or UnitLevel("player")
			if trueLevel >= map.ShowLevel then
				_PlayerActivePower = map
				_IFClassPowerUnitList:UnregisterEvent("PLAYER_LEVEL_UP")
			end
		elseif map.RequireSpell then
			if IsPlayerSpell(map.RequireSpell) then
				_PlayerActivePower = map
			else
				_IFClassPowerUnitList:RegisterEvent("SPELLS_CHANGED")
			end
		else
			_PlayerActivePower = map
		end

		if _PlayerActivePower then
			local powerType = _PlayerActivePower.PowerType
			local power, max = UnitPower("player", powerType, _PlayerActivePower.RealPower), UnitPowerMax("player", powerType, _PlayerActivePower.RealPower)

			for obj in _IFClassPowerUnitList:GetIterator("player") do
				obj:SetClassPowerVisible(true)
				obj:SetClassPowerType(powerType)
				obj:SetUnitClassPower(power, max)
			end
		else
			for obj in _IFClassPowerUnitList:GetIterator("player") do
				obj:SetClassPowerVisible(false)
				obj:SetClassPowerType(nil)
				obj:SetUnitClassPower(0, 0)
			end
		end
	else
		_PlayerActivePower = false

		for obj in _IFClassPowerUnitList:GetIterator("player") do
			obj:SetClassPowerVisible(false)
			obj:SetClassPowerType(nil)
			obj:SetUnitClassPower(0, 0)
		end
	end
end

function OnForceRefresh(self)
	if self.Unit == "player" then
		RefreshActivePower()
	else
		self:SetClassPowerVisible(false)
	end
end

__Doc__[[IFClassPower is used to handle the unit's class power, for monk's chi, priest's shadow orb, paladin's holy power, warlock's sould shard, demonic fury, burning ember.]]
interface "IFClassPower"
	extend "IFUnitElement"

	_DefaultColor = ColorType(1, 1, 1)

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the unit class power & max power to the element, overridable]]
	__Optional__() function SetUnitClassPower(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	__Doc__[[Set the unit's class power type to the element]]
	__Optional__() function SetClassPowerType(self, ty)
		local info = ty and PowerBarColor[ty] or _DefaultColor
		if self:IsClass(StatusBar) then
			self:SetStatusBarColor(info.r, info.g, info.b)
		elseif self:IsClass(LayeredRegion) then
			self:SetVertexColor(info.r, info.g, info.b, 1)
		end
	end

	__Doc__[[Whether show or hide the class power bar]]
	__Optional__() function SetClassPowerVisible(self, show)
		self.Visible = show
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFClassPowerUnitList[self] = self.Unit
		else
			_IFClassPowerUnitList[self] = nil
			self:SetClassPowerVisible(false)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFClassPowerUnitList[self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFClassPower(self)
		if not _M._PlayerClassMap then
			self:SetClassPowerVisible(false)
			return
		end

		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFClassPower"
