-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFMana", version) then
	return
end

_IFManaUnitList = _IFManaUnitList or UnitList(_Name)

SPELL_POWER_MANA = _G.SPELL_POWER_MANA

if select(2, UnitClass('player')) == 'DRUID' then
	_UseHiddenMana = true
else
	_UseHiddenMana = false
end

function _IFManaUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

	self.OnUnitListChanged = nil
end

function _IFManaUnitList:ParseEvent(event, unit, type)
	if (unit and unit ~= "player") or (type and type ~= "MANA") then return end

	if event == "UNIT_POWER" or event == "UNIT_MAXPOWER" then
		local mana, max = UnitPower("player", SPELL_POWER_MANA), UnitPowerMax("player", SPELL_POWER_MANA)
		for obj in self:GetIterator("player") do
			obj:SetUnitMana(mana, max)
		end
	else
		self:EachK("player", OnForceRefresh)
	end
end

function OnForceRefresh(self)
	if UnitPowerType('player') == SPELL_POWER_MANA then
		self:SetManaVisible(false)
		return
	else
		self:SetManaVisible(true)
	end

	self:SetUnitMana(UnitPower("player", SPELL_POWER_MANA), UnitPowerMax("player", SPELL_POWER_MANA))
end

__Doc__[[IFMana is used to handle the unit mana updating]]
interface "IFMana"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the unit mana & max mana to the element, overridable]]
	__Optional__() function SetUnitMana(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	__Doc__[[Whether show or hide the hidden mana bar]]
	__Optional__() function SetManaVisible(self, show)
		self.Visible = show
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFManaUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFManaUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFMana(self)
		if _M._UseHiddenMana then
			self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
			self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
		else
			self:SetManaVisible(false)
		end
	end
endinterface "IFMana"
