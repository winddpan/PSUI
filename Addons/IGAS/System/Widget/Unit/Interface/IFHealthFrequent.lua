-- Author      : Kurapica
-- Create Date : 2012/10/29
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFHealthFrequent", version) then
	return
end

_IFHealthFrequentUnitList = _IFHealthFrequentUnitList or UnitList(_Name)

function _IFHealthFrequentUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_HEALTH_FREQUENT")
	self:RegisterEvent("UNIT_MAXHEALTH")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self.OnUnitListChanged = nil
end

function _IFHealthFrequentUnitList:ParseEvent(event, unit)
	if unit and self:HasUnit(unit) then
		local max = UnitHealthMax(unit)
		local value = UnitIsConnected(unit) and UnitHealth(unit) or UnitHealthMax(unit)

		for obj in self:GetIterator(unit) do
			obj:SetUnitHealth(value, max)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		for unit in self:GetIterator() do
			local max = UnitHealthMax(unit)
			local value = UnitIsConnected(unit) and UnitHealth(unit) or UnitHealthMax(unit)

			for obj in self:GetIterator(unit) do
				obj:SetUnitHealth(value, max)
			end
		end
	end
end

function OnForceRefresh(self)
	if self.Unit then
		self:SetUnitHealth(UnitHealth(self.Unit), UnitHealthMax(self.Unit))
	else
		self:SetUnitHealth(0, 100)
	end
end

__Doc__[[IFHealthFrequent is used to handle the unit frequent health updating]]
interface "IFHealthFrequent"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the unit health & max health to the element, overridable]]
	__Optional__() function SetUnitHealth(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFHealthFrequentUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFHealthFrequentUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFHealthFrequent(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFHealthFrequent"
