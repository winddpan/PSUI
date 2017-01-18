-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.Unit.IFThreat", version) then
	return
end

_IFThreatUnitList = _IFThreatUnitList or UnitList(_Name)

function _IFThreatUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self.OnUnitListChanged = nil
end

function _IFThreatUnitList:ParseEvent(event, unit)
	if unit and unit ~= "player" and self:HasUnit(unit) then
		self:EachK(unit, OnForceRefresh)
	else
		for unit in pairs(self) do
			local status = GetThreatLevel(unit)

			for obj in self:GetIterator(unit) do
				obj:SetThreatLevel(status)
			end
		end
	end
end

function GetThreatLevel(unit)
	local status = 0

	if unit then
		if not UnitIsPlayer(unit) then
			if UnitCanAttack("player", unit) then
				status = UnitThreatSituation("player", unit) or 0
			end
		else
			status = UnitThreatSituation(unit) or 0
		end
	end

	return status
end

function OnForceRefresh(self)
	self:SetThreatLevel(GetThreatLevel(self.Unit))
end

__Doc__[[IFThreat is used to handle the unit threat level's update]]
interface "IFThreat"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFThreatUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the threat level to the element, overridable]]
	__Optional__() function SetThreatLevel(self, lvl)
		if self:IsClass(LayeredRegion) then
			if value > 0 then
				self:SetVertexColor(GetThreatStatusColor(value))
				self.Visible = true
			else
				self.Visible = false
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFThreatUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFThreat(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFThreat"
