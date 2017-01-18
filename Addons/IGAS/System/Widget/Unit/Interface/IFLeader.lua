-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFLeader", version) then
	return
end

_All = "all"
_IFLeaderUnitList = _IFLeaderUnitList or UnitList(_Name)

function _IFLeaderUnitList:OnUnitListChanged()
	self:RegisterEvent("PARTY_LEADER_CHANGED")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFLeaderUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	local unit = self.Unit
	self:SetLeader(unit and (UnitInParty(unit) or UnitInRaid(unit)) and UnitIsGroupLeader(unit))
end

__Doc__[[IFLeader is used to handle the unit leader state's updating]]
interface "IFLeader"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFLeaderUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the leader state to the element, overridable]]
	__Optional__() function SetLeader(self, isLeader)
		self.Visible = isLeader
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFLeaderUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFLeader(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFLeader"
