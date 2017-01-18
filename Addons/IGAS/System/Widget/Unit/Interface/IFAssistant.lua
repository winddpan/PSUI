-- Author      : Kurapica
-- Create Date : 2012/08/06
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFAssistant", version) then
	return
end

_All = "all"
_IFAssistantUnitList = _IFAssistantUnitList or UnitList(_Name)

function _IFAssistantUnitList:OnUnitListChanged()
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFAssistantUnitList:ParseEvent(event)
	self:EachK(_All, OnForceRefresh)
end

function OnForceRefresh(self)
	local unit = self.Unit
	self:SetAssistant(unit and UnitInRaid(unit) and UnitIsGroupAssistant(unit) and not UnitIsGroupLeader(unit))
end

__Doc__[[IFAssistant is used to check whether the unit is the assistant in the group]]
interface "IFAssistant"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFAssistantUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set whether the unit is assistant to the element, overridable]]
	__Optional__() function SetAssistant(self, isAssistant)
		self.Visible = isAssistant
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAssistantUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAssistant(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFAssistant"
