-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.MasterLooterIcon", version) then
	return
end

__Doc__[[The master looter indicator]]
class "MasterLooterIcon"
	inherit "Texture"
	extend "IFGroupLoot"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function MasterLooterIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.TexturePath = [[Interface\GroupFrame\UI-Group-MasterLooter]]
		self.Height = 16
		self.Width = 16
	end
endclass "MasterLooterIcon"
