-- Author      : Kurapica
-- Create Date : 2013/02/03
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.PetUnitPanel", version) then
	return
end

__Doc__[[The unit panel for pets]]
class "PetUnitPanel"
	inherit "SecureFrame"
	extend "IFPetGroup"

	MAX_RAID_MEMBERS = _G.MAX_RAID_MEMBERS
	NUM_RAID_GROUPS = _G.NUM_RAID_GROUPS
	MEMBERS_PER_RAID_GROUP = _G.MEMBERS_PER_RAID_GROUP

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function PetUnitPanel(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.ElementType = UnitFrame	-- Default Element, need override

		self.RowCount = MEMBERS_PER_RAID_GROUP
		self.ColumnCount = NUM_RAID_GROUPS
		self.ElementWidth = 80
		self.ElementHeight = 32

		self.Orientation = Orientation.VERTICAL
		self.HSpacing = 2
		self.VSpacing = 2
		self.AutoSize = true

		self.MarginTop = 0
		self.MarginBottom = 0
		self.MarginLeft = 0
		self.MarginRight = 0

		-- Init for IFPetGroup
		self.ShowRaid = false
		self.ShowParty = true
		self.ShowSolo = true
		self.ShowPlayer = true
    end
endclass "PetUnitPanel"
