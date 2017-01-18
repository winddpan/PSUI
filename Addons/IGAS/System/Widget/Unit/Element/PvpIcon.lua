-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.PvpIcon", version) then
	return
end

__Doc__[[The pvp indicator]]
class "PvpIcon"
	inherit "Texture"
	extend "IFFaction"

	------------------------------------
	--- Refresh the element
	-- -- ------------------------------------
	function UpdateFaction(self)
		local unit = self.Unit
		if unit and UnitIsPVPFreeForAll(unit) then
			self.TexturePath = [[Interface\TargetingFrame\UI-PVP-FFA]]
			self.Visible = true
		elseif unit and UnitIsPVP(unit) and (select(1, UnitFactionGroup(self.Unit))) then
			self.TexturePath = [[Interface\TargetingFrame\UI-PVP-]]..(select(1, UnitFactionGroup(self.Unit)))
			self.Visible = true
		else
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PvpIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 64
		self.Width = 64
	end
endclass "PvpIcon"
