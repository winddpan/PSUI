-- Author      : Kurapica
-- Create Date : 2012/08/06
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFAlternatePower", version) then
	return
end

ALTERNATE_POWER_INDEX = _G.ALTERNATE_POWER_INDEX
ALT_POWER_TYPE_COUNTER = _G.ALT_POWER_TYPE_COUNTER

_IFAlternatePowerUnitList = _IFAlternatePowerUnitList or UnitList(_Name)

function _IFAlternatePowerUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self.OnUnitListChanged = nil
end

function _IFAlternatePowerUnitList:ParseEvent(event, unit, powerType)
	if event == "UNIT_POWER_BAR_SHOW" or event == "UNIT_POWER_BAR_HIDE" then
		self:EachK(unit, OnForceRefresh)
	elseif event == "UNIT_MAXPOWER" and powerType == "ALTERNATE" then
		for obj in self:GetIterator(unit) do
			obj:SetUnitAlternatePower(UnitPower(unit, ALTERNATE_POWER_INDEX), select(2, UnitAlternatePowerInfo(unit)), UnitPowerMax(unit, ALTERNATE_POWER_INDEX))
		end
	elseif event == "UNIT_POWER" and powerType == "ALTERNATE" then
		for obj in self:GetIterator(unit) do
			obj:SetUnitAlternatePower(UnitPower(unit, ALTERNATE_POWER_INDEX))
		end
	end
end

function OnForceRefresh(self)
	local barType, minPower, _, _, _, hideFromOthers = self.Unit and UnitAlternatePowerInfo(self.Unit)
	if ( barType and (not hideFromOthers or self.Unit == "player") ) then
		local currentPower = UnitPower(self.Unit, ALTERNATE_POWER_INDEX)
		local maxPower = UnitPowerMax(self.Unit, ALTERNATE_POWER_INDEX)

		self:SetUnitAlternatePowerBarType(barType)
		self:SetUnitAlternatePowerVisible(true)
		self:SetUnitAlternatePower(currentPower, minPower, maxPower)
	else
		self:SetUnitAlternatePowerVisible(false)
	end
end

__Doc__[[IFAlternatePower is used to handle the unit alternate power's update]]
interface "IFAlternatePower"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the unit alternate power & max power to the element]]
	__Optional__() function SetUnitAlternatePower(self, value, min, max)
		if min and max then self:SetMinMaxValues(min, max) end
		if value then self:SetValue(value) end
	end

	__Doc__[[Set whether show or hide the alternate power bar]]
	__Optional__() function SetUnitAlternatePowerVisible(self, show)
		self.Visible = show
	end

	__Doc__[[Set the unit alternate power bar type to the element]]
	__Optional__() function SetUnitAlternatePowerBarType(self, ty) end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFAlternatePowerUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAlternatePowerUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAlternatePower(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFAlternatePower"
