-- Author      : Kurapica
-- Create Date : 2012/11/09
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFConnect", version) then
	return
end

_IFConnectUnitList = _IFConnectUnitList or UnitList(_Name)

_IFConnectTimer = Timer("IGAS_IFConnect_Timer")
_IFConnectTimer.Enabled = false
_IFConnectTimer.Interval = 3

function _IFConnectUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_CONNECTION")
	_IFConnectTimer.Enabled = true

	self.OnUnitListChanged = nil
end

function _IFConnectUnitList:ParseEvent(event, unit)
	if _IFConnectUnitList:HasUnit(unit) then
		return UpdateConnectState(unit)
	end
end

function _IFConnectTimer:OnTimer()
	for unit in pairs(_IFConnectUnitList) do
		UpdateConnectState(unit)
	end
end

function UpdateConnectState(unit)
	_IFConnectUnitList:EachK(unit, OnForceRefresh)
end

function OnForceRefresh(self)
	self:SetConnectState(not self.Unit or UnitIsConnected(self.Unit))
end

__Doc__[[IFConnect is used to check whether the unit is connected]]
interface "IFConnect"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFConnectUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the connect state to the element, overridable]]
	__Optional__() function SetConnectState(self, connected)
		self.Visible = not connected
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFConnectUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFConnect(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFConnect"
