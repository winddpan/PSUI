-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFCombat", version) then
	return
end

_All = "all"
_IFCombatUnitList = _IFCombatUnitList or UnitList(_Name)

function _IFCombatUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self.OnUnitListChanged = nil
end

function _IFCombatUnitList:ParseEvent(event, unit)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	self:SetCombatState(UnitAffectingCombat('player'))
end

__Doc__[[IFCombat is used to check whether the player is in the combat]]
interface "IFCombat"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFCombatUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the combat state to the element, overridable]]
	__Optional__() function SetCombatState(self, inCombat)
		self.Visible = inCombat
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFCombatUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFCombat(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFCombat"
