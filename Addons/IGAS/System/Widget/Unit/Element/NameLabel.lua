-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.NameLabel", version) then
	return
end

__Doc__[[The unit name label with faction color settings]]
class "NameLabel"
	inherit "FontString"
	extend "IFUnitName" "IFFaction"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	SetUnitName = FontString.SetText

	function UpdateFaction(self)
		self:SetTextColor(self:GetFactionColor())
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function NameLabel(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.DrawLayer = "BORDER"
	end
endclass "NameLabel"
