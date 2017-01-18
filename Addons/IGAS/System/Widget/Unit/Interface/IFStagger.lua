-- Author      : Kurapica
-- Create Date : 2013/03/09
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFStagger", version) then
	return
end

_IFStaggerUnitList = _IFStaggerUnitList or UnitList(_Name)

SPEC_MONK_BREWMASTER = _G.SPEC_MONK_BREWMASTER

function _IFStaggerUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

	UpdateCondition(self)

	self.OnUnitListChanged = nil
end

function _IFStaggerUnitList:ParseEvent(event, unit)
	if unit and unit ~= "player" then return end

	if event == "PLAYER_SPECIALIZATION_CHANGED" then
		UpdateCondition(self)
	else
		local stagger, max = UnitStagger("player", SPELL_POWER_MANA) or 0, UnitHealthMax("player")
		for obj in self:GetIterator("player") do
			obj:SetUnitStagger(stagger, max)
		end
	end
end

function UpdateCondition(self)
	-- Only for player now
	if SPEC_MONK_BREWMASTER == GetSpecialization() then
		self:RegisterEvent("UNIT_MAXHEALTH")
		self:RegisterEvent("UNIT_HEALTH_FREQUENT")
	else
		self:UnregisterEvent("UNIT_MAXHEALTH")
		self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
	end
	self:EachK("player", OnForceRefresh)
end

function OnForceRefresh(self)
	if self.Unit == "player" and SPEC_MONK_BREWMASTER == GetSpecialization() then
		self:SetStaggerVisible(true)

		self:SetUnitStagger(UnitStagger("player") or 0, UnitHealthMax("player"))
	else
		self:SetStaggerVisible(false)
	end
end

__Doc__[[IFStagger is used to handle the unit's stagger]]
interface "IFStagger"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the unit stagger & max health to the element, overridable]]
	__Optional__() function SetUnitStagger(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	__Doc__[[Whether show or hide the stargger bar]]
	__Optional__() function SetStaggerVisible(self, show)
		self.Visible = show
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFStaggerUnitList[self] = self.Unit
		else
			_IFStaggerUnitList[self] = nil
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFStaggerUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFStagger(self)
		if select(2, UnitClass("player")) == "MONK" then
			self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
			self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
		else
			self:SetStaggerVisible(false)
		end
	end
endinterface "IFStagger"
