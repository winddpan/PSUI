-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.LeaderIcon", version) then
	return
end

__Doc__[[The leader indicator]]
class "LeaderIcon"
	inherit "Texture"
	extend "IFLeader"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function LeaderIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.TexturePath = [[Interface\GroupFrame\UI-Group-LeaderIcon]]
		self.Height = 16
		self.Width = 16
	end
endclass "LeaderIcon"
