-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.ThreatIcon", version) then
	return
end

__Doc__[[The threat indicator]]
class "ThreatIcon"
	inherit "Texture"
	extend "IFThreat"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function ThreatIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.TexturePath = [[Interface\Minimap\ObjectIcons]]
		self:SetTexCoord(1/4, 3/8, 0, 1/4)

		self.Height = 16
		self.Width = 16
	end
endclass "ThreatIcon"
