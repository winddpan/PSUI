-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFUnitLevel", version) then
	return
end

_IFUnitLevelUnitList = _IFUnitLevelUnitList or UnitList(_Name)

_All = "all"

function _IFUnitLevelUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFUnitLevelUnitList:ParseEvent(event, level)
	self:EachK(_All, OnForceRefresh, event == "PLAYER_LEVEL_UP" and level or nil)
end

function OnForceRefresh(self, playerLevel)
	if self.Unit then
		if self.Unit == "player" and playerLevel then
			self:SetUnitLevel(playerLevel)
		else
			self:SetUnitLevel(UnitLevel(self.Unit))
		end
	else
		self:SetUnitLevel(nil)
	end
end

__Doc__[[IFUnitLevel is used to handle the unit level's update]]
interface "IFUnitLevel"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFUnitLevelUnitList[self] = self.Unit and _All or nil
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the unit level to the element, overridable]]
	__Optional__() function SetUnitLevel(self, lvl)
		self:SetText(lvl or "???")
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFUnitLevelUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFUnitLevel(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFUnitLevel"
