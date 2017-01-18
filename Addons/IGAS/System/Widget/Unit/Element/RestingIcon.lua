-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.RestingIcon", version) then
	return
end

__Doc__[[The resting indicator]]
class "RestingIcon"
	inherit "Texture"
	extend "IFResting"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function RestingIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.TexturePath = [[Interface\CharacterFrame\UI-StateIcon]]
		self:SetTexCoord(0, .5, 0, .421875)
		self.Height = 16
		self.Width = 16
	end
endclass "RestingIcon"
