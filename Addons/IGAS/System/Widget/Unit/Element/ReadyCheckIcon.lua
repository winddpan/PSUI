-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.ReadyCheckIcon", version) then
	return
end

__Doc__[[The ready check indicator]]
class "ReadyCheckIcon"
	inherit "Texture"
	extend "IFReadyCheck"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function ReadyCheckIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 16
		self.Width = 16
	end
endclass "ReadyCheckIcon"
