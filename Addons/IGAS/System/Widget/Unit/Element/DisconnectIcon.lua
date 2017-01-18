-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.DisconnectIcon", version) then
	return
end

__Doc__[[The disconnect indicator]]
class "DisconnectIcon"
	inherit "Texture"
	extend "IFConnect"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function DisconnectIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.TexturePath = [[Interface\CharacterFrame\Disconnect-Icon]]
		self.Height = 16
		self.Width = 16
	end
endclass "DisconnectIcon"
