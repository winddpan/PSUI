-- Author      : Kurapica
-- Create Date : 2016/07/21
-- ChangeLog   :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.CinematicModel", version) then
	return
end

__AutoProperty__()
class "CinematicModel"
	inherit "PlayerModel"

	------------------------------------------------------
	-- Method
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("CinematicModel", nil, parent, ...)
	end
endclass "CinematicModel"

class "CinematicModel"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(CinematicModel)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
endclass "CinematicModel"
