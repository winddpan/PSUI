-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :
--               2013/06/08 Make sure the object will be hidden

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFResurrect", version) then
	return
end

_IFResurrectUnitList = _IFResurrectUnitList or UnitList(_Name)

function _IFResurrectUnitList:OnUnitListChanged()
	self:RegisterEvent("INCOMING_RESURRECT_CHANGED")

	self.OnUnitListChanged = nil
end

function checkUnitForResurrect(unit)
	if UnitHasIncomingResurrection(unit) then
		_IFResurrectUnitList:EachK(unit, OnForceRefresh)

		-- Some times the resurrect event don't come when the target select resurrect to the tomb
		Task.ThreadCall(function()
			while UnitExists(unit) and UnitHasIncomingResurrection(unit) do
				Task.Delay(2)
			end

			return _IFResurrectUnitList:EachK(unit, OnForceRefresh)
		end)
	else
		_IFResurrectUnitList:EachK(unit, OnForceRefresh)
	end
end

function _IFResurrectUnitList:ParseEvent(event)
	self:Each(checkUnitForResurrect)
end

function OnForceRefresh(self)
	self:SetResurrectState(self.Unit and UnitHasIncomingResurrection(self.Unit))
end

__Doc__[[IFResurrect is used to handle the unit resurrection state's updating]]
interface "IFResurrect"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFResurrectUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the resurrect state to the element, overridable]]
	__Optional__() function SetResurrectState(self, isResurrect)
		self.Visible = isResurrect
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFResurrectUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFResurrect(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFResurrect"
