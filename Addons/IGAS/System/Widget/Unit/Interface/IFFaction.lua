-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFFaction", version) then
	return
end

_IFFactionUnitList = _IFFactionUnitList or UnitList(_Name)

function _IFFactionUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_FACTION")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFFactionUnitList:ParseEvent(event, unit)
	if event == "GROUP_ROSTER_UPDATE" or unit == "player" then
		-- Update all
		for unit in pairs(self) do
			self:EachK(unit, OnForceRefresh)
		end
	else
		self:EachK(unit, OnForceRefresh)
	end
end

_DefaultColor = ColorType(1, 1, 1)

function OnForceRefresh(self)
	self:UpdateFaction()
end

__Doc__[[IFFaction is used to handle the unit faction state's updating]]
interface "IFFaction"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFFactionUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Update the faction to the element, overridable]]
	__Optional__() function UpdateFaction(self)	end

	__Doc__[[Get the faction color of the unit]]
	function GetFactionColor(self)
		local unit = self.Unit
		if not unit then return 1, 1, 1 end

		local isTapDenied = UnitIsTapDenied(unit)
		if self.UseTapColor and isTapDenied then
			return 0.5, 0.5, 0.5
		end

		local r, g, b

		if self.UseSelectionColor and not UnitIsPlayer(unit) then
			r, g, b = UnitSelectionColor(unit)
		elseif self.UseClassColor then
			local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))] or _DefaultColor
			r, g, b = color.r, color.g, color.b
		else
			r, g, b = _DefaultColor.r, _DefaultColor.g, _DefaultColor.b
		end

		return r, g, b
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether using the tap color, default true]]
	property "UseTapColor" { Type = Boolean, Default = true }

	__Doc__[[Whether using the selection color, default true]]
	property "UseSelectionColor" { Type = Boolean, Default = true  }

	__Doc__[[Whether using the class color, default true]]
	property "UseClassColor" { Type = Boolean, Default = true  }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFFactionUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFFaction(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFFaction"
