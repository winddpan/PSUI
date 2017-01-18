-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.CombatIcon", version) then
	return
end

__Doc__[[The combat indicator]]
class "CombatIcon"
	inherit "Texture"
	extend "IFCombat"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function CombatIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.TexturePath = [[Interface\CharacterFrame\UI-StateIcon]]
		self:SetTexCoord(.5, 1, 0, .49)
		self.Height = 32
		self.Width = 32
	end
endclass "CombatIcon"
