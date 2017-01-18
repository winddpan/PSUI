-- Author      : Kurapica
-- Create Date : 2012/06/24

local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.Unit2DPortrait", version) then
	return
end

__Doc__[[The 2D unit portrait]]
class "Unit2DPortrait"
	inherit "Texture"
	extend "IFPortrait"
endclass "Unit2DPortrait"
