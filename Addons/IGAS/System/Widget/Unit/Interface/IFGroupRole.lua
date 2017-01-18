-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFGroupRole", version) then
	return
end

_All = "all"
_IFGroupRoleUnitList = _IFGroupRoleUnitList or UnitList(_Name)

function _IFGroupRoleUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFGroupRoleUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	if self.Unit then
		self:SetGroupRole(UnitGroupRolesAssigned(self.Unit))
	else
		self:SetGroupRole("NONE")
	end
end

__Doc__[[IFGroupRole is used to handle group role's updating]]
interface "IFGroupRole"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFGroupRoleUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the group role to the element, overridable]]
	__Optional__() function SetGroupRole(self, role) end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFGroupRoleUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFGroupRole(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFGroupRole"
