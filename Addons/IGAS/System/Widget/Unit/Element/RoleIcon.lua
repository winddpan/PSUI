-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.RoleIcon", version) then
	return
end

__Doc__[[The group role indicator]]
class "RoleIcon"
	inherit "Texture"
	extend "IFGroupRole" "IFCombat"

	local function refreshRole(self)
		if self.InCombat == self.ShowInCombat and self.GroupRole ~= "NONE" then
			self:SetTexCoord(GetTexCoordsForRoleSmallCircle(self.GroupRole))
			self.Visible = true
		else
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetCombatState(self, inCombat)
		self.InCombat = inCombat
		return refreshRole(self)
	end

	function SetGroupRole(self, role)
		self.GroupRole = role
		return refreshRole(self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Handler__ "Refresh"
	property "ShowInCombat" { Type = Boolean }

	property "InCombat" { Type = Boolean }
	property "GroupRole" { Type = String }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function RoleIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 16
		self.Width = 16

		self.TexturePath = [[Interface\LFGFrame\UI-LFG-ICON-PORTRAITROLES]]
	end
endclass "RoleIcon"
