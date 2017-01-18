-- Author      : Kurapica
-- Create Date : 2016/07/21
-- ChangeLog   :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Line", version) then
	return
end

__AutoProperty__()
class "Line"
	inherit "Texture"

	------------------------------------------------------
	-- Method
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, UIObject) or not IGAS:GetUI(parent).CreateLine then
			error("Usage : FontString(name, parent) : 'parent' - UI element expected.", 2)
		end

		return IGAS:GetUI(parent):CreateLine(nil, ...)
	end
endclass "Line"

class "Line"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Line)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
endclass "Line"
