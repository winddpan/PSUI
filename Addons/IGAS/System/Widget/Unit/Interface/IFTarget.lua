-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFTarget", version) then
	return
end

_All = "all"
_IFTargetUnitList = _IFTargetUnitList or UnitList(_Name)

function _IFTargetUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_TARGET_CHANGED")

	self.OnUnitListChanged = nil
end

function _IFTargetUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	if self.Unit then
		self:SetTargetState(UnitIsUnit(self.Unit, 'target'))
	else
		self:SetTargetState(false)
	end
end

__Doc__[[IFTarget is used to check whether the unit is the target]]
interface "IFTarget"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFTargetUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the target state to the element, overridable]]
	__Optional__() function SetTargetState(self, isTarget) end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFTargetUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFTarget(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFTarget"
