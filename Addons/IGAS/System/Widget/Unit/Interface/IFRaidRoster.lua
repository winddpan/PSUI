-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFRaidRoster", version) then
	return
end

_All = "all"
_IFRaidRosterUnitList = _IFRaidRosterUnitList or UnitList(_Name)

function _IFRaidRosterUnitList:OnUnitListChanged()
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFRaidRosterUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	if IsInRaid() and self.Unit and not UnitHasVehicleUI(self.Unit) then
		if GetPartyAssignment('MAINTANK', self.Unit) then
			self:SetPartyAssignment("MAINTANK")
		elseif GetPartyAssignment('MAINASSIST', self.Unit) then
			self:SetPartyAssignment("MAINASSIST")
		else
			self:SetPartyAssignment("NONE")
		end
	else
		self:SetPartyAssignment("NONE")
	end
end

__Doc__[[IFRaidRoster is used to handle the unit raid roster state's updating]]
interface "IFRaidRoster"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFRaidRosterUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the party assignment to the element, overridable]]
	__Optional__() function SetPartyAssignment(self, assignment) end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRaidRosterUnitList[self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFRaidRoster(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFRaidRoster"
