-- Author      : Kurapica
-- Create Date : 2012/09/07
-- ChangeLog

local version = 1
if not IGAS:NewAddon("IGAS.Widget.StackLayoutPanel", version) then
	return
end

__Doc__[[Auto stack elements into the layout panel]]
__AutoProperty__()
class "StackLayoutPanel"
	inherit "LayoutPanel"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------

	------------------------------------
	--- Add Widget to the panel
	-- <param name="widget"></param>
	-- <return type="index"></return>
	------------------------------------
	function AddWidget(self, widget)
	end

	------------------------------------
	--- Insert Widget to the panel
	-- <param name="before">the index to be insert</param>
	-- <param name="widget"></param>
	------------------------------------
	function InsertWidget(self, before, widget)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
endclass "StackLayoutPanel"
