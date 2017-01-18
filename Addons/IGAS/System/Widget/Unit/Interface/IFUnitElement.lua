-- Author      : Kurapica
-- Create Date : 2012/07/02
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFUnitElement", version) then
	return
end

------------------------------------------------------
-- Enum
------------------------------------------------------
enum "Classification" {
	"elite",
	"normal",
	"rare",
	"rareelite",
	"worldboss",
}

enum "Role" {
	"DAMAGER",
	"HEALER",
	"NONE",
	"TANK",
}

enum "PowerType" {
	[0] = "MANA",
	[1] = "RAGE",
	[2] = "FOCUS",
	[3] = "ENERGY",
	[4] = "COMBO_POINTS",
	[5] = "RUNES",
	[6] = "RUNIC_POWER",
	[7] = "SOUL_SHARDS",
	[8] = "LUNAR_POWER",
	[9] = "HOLY_POWER",
	[10] = "ALTERNATE_POWER",
	[11] = "MAELSTROM",
	[12] = "CHI",
	[13] = "INSANITY",
	[14] = "OBSOLETE",
	[15] = "OBSOLETE2",
	[16] = "ARCANE_CHARGES",
	[17] = "FURY",
	[18] = "PAIN",
}

enum "Reaction" {
	["1"] = "Hated",
	["2"] = "Hostile",
	["3"] = "Unfriendly",
	["4"] = "Neutral",
	["5"] = "Friendly",
	["6"] = "Honored",
	["7"] = "Revered",
	["8"] = "Exalted",
}

enum "Gender" {
	["1"] = "Neuter",
	["2"] = "Male",
	["3"] = "Female",
}

__Doc__[[IFUnitElement is the root interface for the unit system, contains several useful definitions]]
interface "IFUnitElement"

	local fireEvent = System.Reflector.FireObjectEvent

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the object's unit is changed]]
	event "OnUnitChanged"

	__Doc__[[Fired when the object's forced to refresh]]
	event "OnForceRefresh"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Force to refresh the element]]
	function Refresh(self, ...) return fireEvent(self, "OnForceRefresh", ...) end

	__Doc__[[Activate the unit element]]
	function Activate(self)
		if self.__IFUnitElement_Deactivated then
			local unit = type(self.__IFUnitElement_Deactivated) == "string" and self.__IFUnitElement_Deactivated or nil

			-- Unblock the unit settings
			self.__IFUnitElement_Deactivated = nil

			-- Set the Visible property back
			self.Visible = self.__IFUnitElement_DeactivatedVisible
			self.__IFUnitElement_DeactivatedVisible = nil

			-- Set the Unit property back
			self.Unit = unit
		end
	end

	__Doc__[[Deactivate the unit element]]
	function Deactivate(self)
		if not self.__IFUnitElement_Deactivated then
			local unit = self.Unit

			-- Block the unit settings after the deactivation
			self.Unit = nil
			self.__IFUnitElement_Deactivated = unit or true

			-- Change the Visible property if existed
			self.__IFUnitElement_DeactivatedVisible = self.Visible
			self.Visible = false
		end
	end
	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether the unit element is activated]]
	property "Activated" {
		Get = function(self)
			return not self.__IFUnitElement_Deactivated
		end,
		Set = function(self, value)
			if value then
				self:Activate()
			else
				self:Deactivate()
			end
		end,
		Type = Boolean,
	}

	__Doc__[[The object's unit]]
	property "Unit" {
		Field = "__IFUnitElement_Unit",
		Set = function(self, unit)
			unit = unit and unit:lower()

			if self.__IFUnitElement_Deactivated then
				self.__IFUnitElement_Deactivated = unit or true
			elseif self.__IFUnitElement_Unit ~= unit then
				self.__IFUnitElement_Unit = unit
				self:Fire("OnUnitChanged")
				self:Refresh()
			end
		end,
		Type = String,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
endinterface "IFUnitElement"
