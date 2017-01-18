-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.AssistantIcon", version) then
	return
end

__Doc__[[The assistant icon]]
class "AssistantIcon"
	inherit "Texture"
	extend "IFAssistant"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function AssistantIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.TexturePath = [[Interface\GroupFrame\UI-Group-AssistantIcon]]
		self.Height = 16
		self.Width = 16
	end
endclass "AssistantIcon"
