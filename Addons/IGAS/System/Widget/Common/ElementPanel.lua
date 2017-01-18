-- Author      : Kurapica
-- Create Date : 2012/08/03
-- ChangeLog

local version = 2
if not IGAS:NewAddon("IGAS.Widget.ElementPanel", version) then
	return
end

__Doc__[[ElementPanel is used to contains several same class ui elements like a grid.]]
__AutoProperty__()
class "ElementPanel"
	inherit "Frame"
	extend "IFElementPanel"

endclass "ElementPanel"
