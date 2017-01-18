-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFGroupLoot", version) then
	return
end

_All = "all"
_IFGroupLootUnitList = _IFGroupLootUnitList or UnitList(_Name)

function _IFGroupLootUnitList:OnUnitListChanged()
	self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFGroupLootUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	local unit = self.Unit
	if unit and (UnitInParty(unit) or UnitInRaid(unit)) then
		local method, pid, rid = GetLootMethod()

		if(method == 'master') then
			local mlUnit
			if(pid) then
				if(pid == 0) then
					mlUnit = 'player'
				else
					mlUnit = 'party'..pid
				end
			elseif(rid) then
				mlUnit = 'raid'..rid
			end

			self:SetLootMaster(UnitIsUnit(self.Unit, mlUnit))
		else
			self:SetLootMaster(false)
		end
	else
		self:SetLootMaster(false)
	end
end

__Doc__[[IFGroupLoot is used to handle the root master indicator's updating]]
interface "IFGroupLoot"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFGroupLootUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set whether the unit is loot master to the element, overridable]]
	__Optional__() function SetLootMaster(self, isLootMaster)
		self.Visible = isLootMaster
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFGroupLootUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFGroupLoot(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFGroupLoot"
