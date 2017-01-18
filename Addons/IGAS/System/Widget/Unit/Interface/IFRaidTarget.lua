-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFRaidTarget", version) then
	return
end

_All = "all"
_IFRaidTargetUnitList = _IFRaidTargetUnitList or UnitList(_Name)

function _IFRaidTargetUnitList:OnUnitListChanged()
	self:RegisterEvent("RAID_TARGET_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFRaidTargetUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	self:SetRaidTarget(self.Unit and GetRaidTargetIndex(self.Unit) or nil)
end

__Doc__[[IFRaidTarget is used to handle the unit's raid target icon's updating(only for texture)]]
interface "IFRaidTarget"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFRaidTargetUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the raid target index to the element, overridable]]
	__Optional__() function SetRaidTarget(self, raidTargetIndex) end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRaidTargetUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFRaidTarget(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFRaidTarget"
