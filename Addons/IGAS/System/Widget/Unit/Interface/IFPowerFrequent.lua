-- Author      : Kurapica
-- Create Date : 2012/11/07
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFPowerFrequent", version) then
	return
end

_IFPowerFrequentUnitList = _IFPowerFrequentUnitList or UnitList(_Name)
_IFPowerFrequentUnitPowerType = _IFPowerFrequentUnitPowerType or {}

function _IFPowerFrequentUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_POWER_FREQUENT")
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFPowerFrequentUnitList:ParseEvent(event, unit, type)
	if unit and self:HasUnit(unit) then
		local powerType = UnitPowerType(unit)

		if powerType ~= _IFPowerFrequentUnitPowerType[unit] then
			_IFPowerFrequentUnitPowerType[unit] = powerType

			local max = UnitPowerMax(unit, powerType)
			local value = UnitPower(unit, powerType)

			for obj in self:GetIterator(unit) do
				obj:SetUnitPowerType(powerType)
				obj:SetUnitPower(value, max)
			end

			return
		end

		if event == "UNIT_POWER_FREQUENT" then
			if powerType and ClassPowerMap[powerType] ~= type then return end

			local max = UnitPowerMax(unit, powerType)
			local value = UnitPower(unit, powerType)

			for obj in self:GetIterator(unit) do
				obj:SetUnitPower(value, max)
			end
		elseif event == "UNIT_MAXPOWER" then
			local max = UnitPowerMax(unit, powerType)
			local value = UnitPower(unit, powerType)

			for obj in self:GetIterator(unit) do
				obj:SetUnitPower(value, max)
			end
		end
	elseif event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" then
		for unit in self:GetIterator() do
			local powerType = UnitPowerType(unit)

			if powerType ~= _IFPowerFrequentUnitPowerType[unit] then
				_IFPowerFrequentUnitPowerType[unit] = powerType

				for obj in self:GetIterator(unit) do
					obj:SetUnitPowerType(powerType)
				end
			end

			local max = UnitPowerMax(unit, powerType)
			local value = UnitPower(unit, powerType)

			for obj in self:GetIterator(unit) do
				obj:SetUnitPower(value, max)
			end
		end
	end
end

function OnForceRefresh(self)
	local unit = self.Unit
	if not unit or not UnitExists(unit) then return end

	local powerType = UnitPowerType(unit)
	self:SetUnitPowerType(powerType)

	local power, max = UnitPower(unit, powerType), UnitPowerMax(unit, powerType)
	if not UnitIsConnected(unit) then power = max end
	self:SetUnitPower(power, max)
end

__Doc__[[IFPowerFrequent is used to handle the unit frequent power updating]]
interface "IFPowerFrequent"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the unit power & max power to the element, overridable]]
	__Optional__() function SetUnitPower(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		self:SetValue(value, value or 0)
	end

	__Doc__[[Set the unit power color to the element, overridable]]
	__Optional__() function SetUnitPowerType(self, powerType)
		local powerType, powerToken, altR, altG, altB = UnitPowerType(self.Unit)
		local info = PowerBarColor[powerToken]

		info = info or (not altR and (PowerBarColor[powerType] or PowerBarColor["MANA"]))
		if info then altR, altG, altB = info.r, info.g, info.b end

		if self:IsClass(StatusBar) then
			self:SetStatusBarColor(altR, altG, altB)
		elseif self:IsClass(LayeredRegion) then
			self:SetVertexColor(altR, altG, altB, 1)
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFPowerFrequentUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFPowerFrequentUnitList[self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFPowerFrequent(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFPowerFrequent"
