-- Author      : Kurapica
-- Create Date : 2012/07/14
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFRune", version) then
	return
end

_IFRuneUnitList = _IFRuneUnitList or UnitList(_Name)

SPELL_POWER_RUNES = _G.SPELL_POWER_RUNES

function _IFRuneUnitList:OnUnitListChanged()
	self:RegisterEvent("RUNE_POWER_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_MAXPOWER")

	self.OnUnitListChanged = nil
end

function _IFRuneUnitList:ParseEvent(event, runeIndex, isEnergize)
	if event == "RUNE_POWER_UPDATE" and runeIndex and runeIndex >=1 then
		local start, duration, ready = GetRuneCooldown(runeIndex)

		for obj in self:GetIterator("player") do
			obj:SetRuneByIndex(runeIndex, start, duration, ready, isEnergize)
		end
	elseif event == "UNIT_MAXPOWER" and runeIndex == "player" then
		local max = UnitPowerMax("player", SPELL_POWER_RUNES)
		for obj in self:GetIterator("player") do
			obj:SetMaxRune(max)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:EachK("player", OnForceRefresh)
	end
end

function OnForceRefresh(self)
	if self.Unit == "player" then
		self:SetRuneVisible(true)

		local max = UnitPowerMax("player", SPELL_POWER_RUNES)

		self:SetMaxRune(max)

		for i = 1, max do
			self:SetRuneByIndex(i, GetRuneCooldown(i))
		end
	else
		self:SetRuneVisible(false)
	end
end

__Doc__[[IFRune is used to handle the unit's rune power's updating]]
interface "IFRune"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Refresh the rune by index]]
	__Optional__() function SetRuneByIndex(self, index, start, duration, ready, isEnergize)
		if self[index] then
			if not ready then
				if start then
					self[index]:Fire("OnCooldownUpdate", start, duration)
				end
				self[index].Ready = false
			else
				self[index].Ready = true
			end

			self[index].Energize = isEnergize
		end
	end

	__Doc__[[Set the max rune count to the element]]
	__Optional__() function SetMaxRune(self, max) end

	__Doc__[[Whether show or hide the rune bar]]
	__Optional__() function SetRuneVisible(self, show)
		self.Visible = show
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFRuneUnitList[self] = "player"
			self:SetRuneVisible(true)
		else
			_IFRuneUnitList[self] = nil
			self:SetRuneVisible(false)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRuneUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFRune(self)
		if select(2, UnitClass("player")) == "DEATHKNIGHT" then
			self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
			self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
		else
			self:SetRuneVisible(false)
		end
	end
endinterface "IFRune"
