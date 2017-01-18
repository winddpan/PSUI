-- Author      : Kurapica
-- Create Date : 7/16/2008 15:10
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.DressUpModel", version) then
	return
end

__Doc__[[The DressUpModel type was added to provide support for the "dressing room" functionality when it was introduced. This model can be set to a particular unit, and then given different pieces of gear to display on that unit with the TryOn function. It also provides an Undress feature which can be used to view how your character's gear will look without concealing articles such as a cloak or tabard that you might be wearing.]]
__AutoProperty__()
class "DressUpModel"
	inherit "PlayerModel"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"Dress" [[Updates the model to reflect the character's currently equipped items]]

	__Doc__"TryOn" [[
		<desc>Updates the model to reflect the character's appearance after equipping a specific item</desc>
		<format>itemID|itemName|itemLink</format>
		<param name="itemID">number, an item's ID</param>
		<param name="itemName">string, an item's name</param>
		<param name="itemLink">string, an item's hyperlink, or any string containing the itemString portion of an item link</param>
	]]

	__Doc__"Undress" [[Updates the model to reflect the character's appearance without any equipped items]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("DressUpModel", nil, parent, ...)
	end
endclass "DressUpModel"

class "DressUpModel"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(DressUpModel)
endclass "DressUpModel"
