-- Author      : Kurapica
-- Create Date : 2012/11/09
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFDebuffState", version) then
	return
end

_IFDebuffStateUnitList = _IFDebuffStateUnitList or UnitList(_Name)

_IFDebuffStateCache_Magic = {}
_IFDebuffStateCache_Curse = {}
_IFDebuffStateCache_Disease = {}
_IFDebuffStateCache_Poison = {}

function _IFDebuffStateUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_AURA")

	self.OnUnitListChanged = nil
end

function _IFDebuffStateUnitList:ParseEvent(event, unit)
	if not _IFDebuffStateUnitList:HasUnit(unit) then return end

	return UpdateAuraState(unit)
end

function UpdateAuraState(unit)
	local index = 1
	local name, _, dtype
	local hasMagic, hasCurse, hasDisease, hasPoison = false, false, false, false
	local changed = false

	while true do
		name, _, _, _, dtype = UnitAura(unit, index, "HARMFUL")

		if name then
			if dtype == "Magic" then
				hasMagic = true
			elseif dtype == "Curse" then
				hasCurse = true
			elseif dtype == "Disease" then
				hasDisease = true
			elseif dtype == "Poison" then
				hasPoison = true
			end
		else
			break
		end

		index = index + 1
	end

	if _IFDebuffStateCache_Magic[unit] ~= hasMagic then
		changed = true
		_IFDebuffStateCache_Magic[unit] = hasMagic
		_IFDebuffStateUnitList:EachK(unit, "HasMagic", hasMagic)
	end

	if _IFDebuffStateCache_Curse[unit] ~= hasCurse then
		changed = true
		_IFDebuffStateCache_Curse[unit] = hasCurse
		_IFDebuffStateUnitList:EachK(unit, "HasCurse", hasCurse)
	end

	if _IFDebuffStateCache_Disease[unit] ~= hasDisease then
		changed = true
		_IFDebuffStateCache_Disease[unit] = hasDisease
		_IFDebuffStateUnitList:EachK(unit, "HasDisease", hasDisease)
	end

	if _IFDebuffStateCache_Poison[unit] ~= hasPoison then
		changed = true
		_IFDebuffStateCache_Poison[unit] = hasPoison
		_IFDebuffStateUnitList:EachK(unit, "HasPoison", hasPoison)
	end

	if changed then
		for ele in _IFDebuffStateUnitList(unit) do
			Object.Fire(ele, "OnStateChanged")
		end
	end
end

__Doc__[[IFDebuffState is used to handle the unit debuff's update]]
interface "IFDebuffState"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the unit's debuff state is changed]]
	event "OnStateChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self)
		return self.Unit and UpdateAuraState(self.Unit)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the result for whether the unit has a magic debuff]]
	__Optional__() property "HasMagic" { Type = Boolean }

	__Doc__[[used to receive the result for whether the unit has a curse debuff]]
	__Optional__() property "HasCurse" { Type = Boolean }

	__Doc__[[used to receive the result for whether the unit has a disease debuff]]
	__Optional__() property "HasDisease" { Type = Boolean }

	__Doc__[[used to receive the result for whether the unit has a poison debuff]]
	__Optional__() property "HasPoison" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFDebuffStateUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFDebuffStateUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFDebuffState(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
	end
endinterface "IFDebuffState"
