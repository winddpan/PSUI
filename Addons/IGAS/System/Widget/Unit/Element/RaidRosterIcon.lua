-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.RaidRosterIcon", version) then
	return
end

__Doc__[[The raid roster indicator]]
class "RaidRosterIcon"
	inherit "Texture"
	extend "IFRaidRoster"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetPartyAssignment(self, assignment)
		if assignment == "MAINTANK" then
			self.Visible = true
			self.TexturePath = [[Interface\GROUPFRAME\UI-GROUP-MAINTANKICON]]
		elseif assignment == "MAINASSIST" then
			self.Visible = true
			self.TexturePath = [[Interface\GROUPFRAME\UI-GROUP-MAINASSISTICON]]
		else
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function RaidRosterIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 16
		self.Width = 16
	end
endclass "RaidRosterIcon"
