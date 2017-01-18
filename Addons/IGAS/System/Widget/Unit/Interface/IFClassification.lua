-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFClassification", version) then
	return
end

_IFClassificationUnitList = _IFClassificationUnitList or UnitList(_Name)

function _IFClassificationUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")

	self.OnUnitListChanged = nil
end

function _IFClassificationUnitList:ParseEvent(event, unit)
	if self:HasUnit(unit) then
		self:EachK(unit, OnForceRefresh)
	end
end

function OnForceRefresh(self)
	self:SetClassification(self.Unit and UnitClassification(self.Unit))
end

__Doc__[[IFClassification is used to check whether the unit's classification, the default refresh method is used to check if the unit is a quest boss]]
interface "IFClassification"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFClassificationUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the classification to the element, overridable]]
	__Optional__() function SetClassification(self, classification) end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFClassificationUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFClassification(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFClassification"
