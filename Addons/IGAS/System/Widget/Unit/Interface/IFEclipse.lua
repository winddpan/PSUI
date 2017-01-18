-- Author      : Kurapica
-- Create Date : 2012/08/05
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFEclipse", version) then
	return
end

------------------------------------------------------
-- Enum
------------------------------------------------------
enum "EclipseDirection" {
	"none",
	"sun",
	"moon",
}

------------------------------------------------------
-- Controller
------------------------------------------------------
ECLIPSE_BAR_SOLAR_BUFF_ID = _G.ECLIPSE_BAR_SOLAR_BUFF_ID
ECLIPSE_BAR_LUNAR_BUFF_ID = _G.ECLIPSE_BAR_LUNAR_BUFF_ID
SPELL_POWER_ECLIPSE = _G.SPELL_POWER_ECLIPSE
MOONKIN_FORM = _G.MOONKIN_FORM

_All = "all"
_IFEclipseUnitList = _IFEclipseUnitList or UnitList(_Name)

_ShowEclipse = false

function _IFEclipseUnitList:OnUnitListChanged()
	self:RegisterEvent("ECLIPSE_DIRECTION_CHANGE")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self.OnUnitListChanged = nil
end

function _IFEclipseUnitList:ParseEvent(event, unit, powerType)
	if event == "UNIT_POWER" then
		if unit == "player" and powerType == "ECLIPSE" then
			self:EachK(_All, "Value", UnitPower('player', SPELL_POWER_ECLIPSE))
		end
	elseif event == "UNIT_AURA" then
		if unit == "player" then
			local hasLunarEclipse, hasSolarEclipse = GetEclipseActive()
			self:EachK(_All, "MoonActivated", hasLunarEclipse)
			self:EachK(_All, "SunActivated", hasSolarEclipse)
		end
	elseif event == "ECLIPSE_DIRECTION_CHANGE" then
		-- unit -> isLunar
		self:EachK(_All, "Direction", unit)
	elseif event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TALENT_UPDATE" or event == "UPDATE_SHAPESHIFT_FORM" then
		local needShow = NeedShowEclipse()

		if needShow ~= _ShowEclipse then
			_ShowEclipse = needShow

			if needShow then
				self:EachK(_All, ShowEclipse)
			else
				self:EachK(_All, HideEclipse)
			end
		end
	end
end

function ShowEclipse(self)
	local maxPower = UnitPowerMax('player', SPELL_POWER_ECLIPSE)

	self.Direction = GetEclipseDirection()
	self.MinMaxValue = MinMax(-maxPower, maxPower)
	self.MoonActivated, self.SunActivated = GetEclipseActive()
	self.Value = UnitPower('player', SPELL_POWER_ECLIPSE)
	self.Visible = true
end

function HideEclipse(self)
	self.Visible = false
end

function NeedShowEclipse()
	local form = GetShapeshiftFormID()

	if not form then
		if GetSpecialization() == 1 then
			return true
		end
	elseif form == MOONKIN_FORM then
		return true
	end

	return false
end

function GetEclipseActive()
	local hasLunarEclipse = false
	local hasSolarEclipse = false

	local i = 1
	local name, _, _, _, _, _, _, _, _, _, spellID = UnitAura("player", i, "HELPFUL")

	while name do
		if spellID == ECLIPSE_BAR_SOLAR_BUFF_ID then
			hasSolarEclipse = true
			break
		elseif spellID == ECLIPSE_BAR_LUNAR_BUFF_ID then
			hasLunarEclipse = true
			break
		end

		i = i + 1
		name, _, _, _, _, _, _, _, _, _, spellID = UnitAura("player", i, "HELPFUL")
	end

	return hasLunarEclipse, hasSolarEclipse
end

__Doc__[[IFEclipse is used to handle the updating for the player's eclipse power]]
interface "IFEclipse"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self)
		if _M._ShowEclipse then
			ShowEclipse(self)
		else
			HideEclipse(self)
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the eclipse's Direction]]
	__Optional__() property "EclipseDirection" { Type = EclipseDirection }

	__Doc__[[used to receive whether the sun is activated]]
	__Optional__() property "SunActivated" { Type = Boolean }

	__Doc__[[used to receive whether the moon is activated]]
	__Optional__() property "MoonActivated" { Type = Boolean }

	__Doc__[[used to receive the min and max value]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the eclipse power's value]]
	__Optional__() property "Value" { Type = Number }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFEclipseUnitList[self] = _All
		else
			_IFEclipseUnitList[self] = nil
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFEclipseUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFEclipse(self)
		if select(2, UnitClass("player")) == "DRUID" then
			self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		else
			self.Visible = false
		end
	end
endinterface "IFEclipse"
