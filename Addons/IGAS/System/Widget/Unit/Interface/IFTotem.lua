-- Author      : Kurapica
-- Create Date : 2012/07/22
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFTotem", version) then
	return
end

MAX_TOTEMS = _G.MAX_TOTEMS

PRIORITIES = STANDARD_TOTEM_PRIORITIES

if(select(2, UnitClass'player') == 'SHAMAN') then
	PRIORITIES = SHAMAN_TOTEM_PRIORITIES
end

SLOT_MAP = {}

for slot, index in ipairs(PRIORITIES) do
	SLOT_MAP[index] = slot
end

_IFTotemUnitList = _IFTotemUnitList or UnitList(_Name)

function _IFTotemUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_TOTEM_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")	-- won't update if leave instance.

	self.OnUnitListChanged = nil
end

function _IFTotemUnitList:ParseEvent(event)
	self:EachK("player", OnForceRefresh)
end

function OnForceRefresh(self)
	for i = 1, MAX_TOTEMS do
		if SLOT_MAP[i] then
			self:SetTotemByIndex(i, GetTotemInfo(SLOT_MAP[i]))
		end
	end
end

__Doc__[[IFTotem is used to handle the unit's totem updating]]
interface "IFTotem"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFTotemUnitList[self] = self.Unit
			self:SetTotemVisible(true)
		else
			_IFTotemUnitList[self] = nil
			self:SetTotemVisible(false)
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Refresh the rune by index]]
	__Optional__() function SetTotemByIndex(self, index, haveTotem, name, start, duration, icon)
	end

	__Doc__[[Whether show or hide the totem bar]]
	__Optional__() function SetTotemVisible(self, show)
		self.Visible = show
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The slot map of the totems]]
	__Getter__"Clone"
	__Static__() property "TotemSlotMap" { Default = SLOT_MAP, Set = false }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFTotemUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFTotem(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFTotem"
