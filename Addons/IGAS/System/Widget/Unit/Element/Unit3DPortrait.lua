-- Author      : Kurapica
-- Create Date : 2012/06/24

local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.Unit3DPortrait", version) then
	return
end

__Doc__[[The 3D unit portrait]]
class "Unit3DPortrait"
	inherit "PlayerModel"
	extend "IFPortrait"
endclass "Unit3DPortrait"
