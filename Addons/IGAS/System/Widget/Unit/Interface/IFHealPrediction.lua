-- Author      : Kurapica
-- Create Date : 2012/08/06
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFHealPrediction", version) then
	return
end

_IFMyHealPredictionUnitList = _IFMyHealPredictionUnitList or UnitList(_Name.."My")
_IFOtherHealPredictionUnitList = _IFOtherHealPredictionUnitList or UnitList(_Name.."Other")
_IFAllHealPredictionUnitList = _IFAllHealPredictionUnitList or UnitList(_Name.."All")
_IFAbsorbUnitList = _IFAbsorbUnitList or UnitList(_Name.."Absorb")
_IFHealAbsorbUnitList = _IFHealAbsorbUnitList or UnitList(_Name.."HealAbsorb")

_IFHealPredictionUnits = _IFHealPredictionUnits or {}

local function OnUnitListChanged()
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_HEAL_PREDICTION")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_MAXHEALTH")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_HEALTH")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED")

	_IFMyHealPredictionUnitList.OnUnitListChanged = nil
	_IFOtherHealPredictionUnitList.OnUnitListChanged = nil
	_IFAllHealPredictionUnitList.OnUnitListChanged = nil
	_IFAbsorbUnitList.OnUnitListChanged = nil
	_IFHealAbsorbUnitList.OnUnitListChanged = nil
end

_IFMyHealPredictionUnitList.OnUnitListChanged = OnUnitListChanged
_IFOtherHealPredictionUnitList.OnUnitListChanged = OnUnitListChanged
_IFAllHealPredictionUnitList.OnUnitListChanged = OnUnitListChanged
_IFAbsorbUnitList.OnUnitListChanged = OnUnitListChanged
_IFHealAbsorbUnitList.OnUnitListChanged = OnUnitListChanged

MAX_INCOMING_HEAL_OVERFLOW = 1.0

function _IFMyHealPredictionUnitList:ParseEvent(event, unit)
	if _IFHealPredictionUnits[unit] then
		local health = UnitHealth(unit)
		local maxHealth = UnitHealthMax(unit)

		local myIncomingHeal = UnitGetIncomingHeals(unit, "player") or 0
		local allIncomingHeal = UnitGetIncomingHeals(unit) or 0
		local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0
		local myCurrentHealAbsorb = UnitGetTotalHealAbsorbs(unit) or 0

		local overHealAbsorb = false
		local hasIncomingHeal = false
		local hasAbsorb = false

		--We don't fill outside the health bar with healAbsorbs.  Instead, an overHealAbsorbGlow is shown.
		if ( health < myCurrentHealAbsorb ) then
			overHealAbsorb = true
			myCurrentHealAbsorb = health
		end

		--See how far we're going over the health bar and make sure we don't go too far out of the frame.
		if ( health - myCurrentHealAbsorb + allIncomingHeal > maxHealth * MAX_INCOMING_HEAL_OVERFLOW ) then
			allIncomingHeal = maxHealth * MAX_INCOMING_HEAL_OVERFLOW - health + myCurrentHealAbsorb
		end

		local otherIncomingHeal = 0

		--Split up incoming heals.
		if ( allIncomingHeal >= myIncomingHeal ) then
			otherIncomingHeal = allIncomingHeal - myIncomingHeal
		else
			myIncomingHeal = allIncomingHeal
		end

		--We don't fill outside the the health bar with absorbs.  Instead, an overAbsorbGlow is shown.
		local overAbsorb = false
		if ( health - myCurrentHealAbsorb + allIncomingHeal + totalAbsorb >= maxHealth or health + totalAbsorb >= maxHealth ) then
			if ( totalAbsorb > 0 ) then
				overAbsorb = true
			end

			if ( allIncomingHeal > myCurrentHealAbsorb ) then
				totalAbsorb = max(0,maxHealth - (health - myCurrentHealAbsorb + allIncomingHeal))
			else
				totalAbsorb = max(0,maxHealth - health)
			end
		end

		--If allIncomingHeal is greater than myCurrentHealAbsorb, then the current
		--heal absorb will be completely overlayed by the incoming heals so we don't show it.
		if ( myCurrentHealAbsorb > allIncomingHeal ) then
			myCurrentHealAbsorb = myCurrentHealAbsorb - allIncomingHeal

			--If there are incoming heals the left shadow would be overlayed by the incoming heals
			--so it isn't shown.
			hasIncomingHeal = allIncomingHeal > 0

			-- The right shadow is only shown if there are absorbs on the health bar.
			hasAbsorb = totalAbsorb > 0
		else
			myCurrentHealAbsorb = 0
		end

		for obj in _IFMyHealPredictionUnitList:GetIterator(unit) do
			obj:SetUnitMyHealPrediction(myIncomingHeal, maxHealth)
		end

		for obj in _IFOtherHealPredictionUnitList:GetIterator(unit) do
			obj:SetUnitOtherHealPrediction(otherIncomingHeal, maxHealth)
		end

		for obj in _IFAllHealPredictionUnitList:GetIterator(unit) do
			obj:SetUnitAllHealPrediction(allIncomingHeal, maxHealth)
		end

		for obj in _IFAbsorbUnitList:GetIterator(unit) do
			obj:SetUnitTotalAbsorb(totalAbsorb, maxHealth)
			obj:SetUnitOverAbsorb(overAbsorb)
		end

		for obj in _IFHealAbsorbUnitList:GetIterator(unit) do
			obj:SetUnitHealAbsorb(myCurrentHealAbsorb, maxHealth)
			obj:SetUnitOverAbsorb(overHealAbsorb)
			obj:SetUnitHasIncomingHeal(hasIncomingHeal)
			obj:SetUnitHasAbsorb(hasAbsorb)
		end
	end
end

__Doc__[[IFMyHealPrediction is used to handle the unit's prediction health by the player]]
interface "IFMyHealPrediction"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the player's heal prediction the element, overridable]]
	__Optional__() function SetUnitMyHealPrediction(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFMyHealPredictionUnitList[self] = self.Unit
		if self.Unit then _IFHealPredictionUnits[self.Unit] = true end
	end

	local function OnForceRefresh(self)
		if self.Unit then
			self:SetUnitMyHealPrediction(0, UnitHealthMax(self.Unit))
		else
			self:SetUnitMyHealPrediction(0, 100)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFMyHealPredictionUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFMyHealPrediction(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFMyHealPrediction"

__Doc__[[IFOtherHealPrediction is used to handle the unit's prediction health by other players]]
interface "IFOtherHealPrediction"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set other's heal prediction to the element, overridable]]
	__Optional__() function SetUnitOtherHealPrediction(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFOtherHealPredictionUnitList[self] = self.Unit
		if self.Unit then _IFHealPredictionUnits[self.Unit] = true end
	end

	local function OnForceRefresh(self)
		if self.Unit then
			self:SetUnitOtherHealPrediction(0, UnitHealthMax(self.Unit))
		else
			self:SetUnitOtherHealPrediction(0, 100)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFOtherHealPredictionUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFOtherHealPrediction(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFOtherHealPrediction"

__Doc__[[IFAllHealPrediction is used to handle the unit's prediction health by all player]]
interface "IFAllHealPrediction"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set all heal prediction to the element, overridable]]
	__Optional__() function SetUnitAllHealPrediction(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFAllHealPredictionUnitList[self] = self.Unit
		if self.Unit then _IFHealPredictionUnits[self.Unit] = true end
	end

	local function OnForceRefresh(self)
		if self.Unit then
			self:SetUnitAllHealPrediction(0, UnitHealthMax(self.Unit))
		else
			self:SetUnitAllHealPrediction(0, 100)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAllHealPredictionUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAllHealPrediction(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFAllHealPrediction"

__Doc__[[IFAbsorb is used to handle the unit's total absorb value]]
interface "IFAbsorb"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the total absorb to the element, overridable]]
	__Optional__() function SetUnitTotalAbsorb(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	__Doc__[[Set the result whether the unit's absorb effect is absorb]]
	__Optional__() function SetUnitOverAbsorb(self, isOver) end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFAbsorbUnitList[self] = self.Unit
		if self.Unit then _IFHealPredictionUnits[self.Unit] = true end
	end

	local function OnForceRefresh(self)
		if self.Unit then
			self:SetUnitTotalAbsorb(0, UnitHealthMax(self.Unit))
		else
			self:SetUnitTotalAbsorb(0, 100)
		end
		self:SetUnitOverAbsorb(false)
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAbsorbUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAbsorb(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFAbsorb"

__Doc__[[IFHealAbsorb is used to handle the unit's health absorb value]]
interface "IFHealAbsorb"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the health absorb to the element, overridable]]
	__Optional__() function SetUnitHealAbsorb(self, value, max)
		if max then self:SetMinMaxValues(0, max) end
		if value then self:SetValue(value) end
	end

	__Doc__[[Set whether the unit has over absorb]]
	__Optional__() function SetUnitOverAbsorb(self, isOver) end

	__Doc__[[Set whether the unit has incoming heal]]
	__Optional__() function SetUnitHasIncomingHeal(self, has) end

	__Doc__[[Set whether the unit has total absorb]]
	__Optional__() function SetUnitHasAbsorb(self, has) end


	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFHealAbsorbUnitList[self] = self.Unit
		if self.Unit then _IFHealPredictionUnits[self.Unit] = true end
	end

	local function OnForceRefresh(self)
		if self.Unit then
			self:SetUnitHealAbsorb(0, UnitHealthMax(self.Unit))
		else
			self:SetUnitHealAbsorb(0, 100)
		end
		self:SetUnitOverAbsorb(false)
		self:SetUnitHasIncomingHeal(false)
		self:SetUnitHasAbsorb(false)
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFHealAbsorbUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFHealAbsorb(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFHealAbsorb"
