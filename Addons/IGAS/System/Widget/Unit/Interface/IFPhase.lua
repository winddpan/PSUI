-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFPhase", version) then
	return
end

_All = "all"
_IFPhaseUnitList = _IFPhaseUnitList or UnitList(_Name)

function _IFPhaseUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_PHASE")

	self.OnUnitListChanged = nil
end

function _IFPhaseUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	self:SetInPhase(self.Unit and UnitInPhase(self.Unit))
end

__Doc__[[IFPhase is used to check whether the unit is in the same phase with the player]]
interface "IFPhase"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFUnitNameUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the phase state to the element, overridable]]
	__Optional__() function SetInPhase(self, inPhase)
		self.Visible = inPhase
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFPhaseUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFPhase(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFPhase"
