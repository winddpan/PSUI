-- Author      : Kurapica
-- Create Date : 7/16/2008 15:10
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.TabardModel", version) then
	return
end

__Doc__[[TabardModel is a frame type provided specifically for designing or modifying guild tabards.]]
__AutoProperty__()
class "TabardModel"
	inherit "PlayerModel"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetLowerBackgroundFileName" [[
		<desc>Returns the image file for the lower portion of the tabard model's current background design</desc>
		<return type="string">the image file for the lower portion of the tabard model's current background design</return>
	]]

	__Doc__"GetLowerEmblemFileName" [[
		<desc>Returns the image file for the lower portion of the tabard model's current emblem design</desc>
		<return type="string">the image file for the lower portion of the tabard model's current emblem design</return>
	]]

	__Doc__[[
		<desc>Gets the texture object to display the lower portion of the tabard model's current emblem design</desc>
		<return type="System.Widget.Texture">the texture object to display the lower portion of the tabard model's current emblem design</return>
	]]
	function GetLowerEmblemTexture(self)
		return IGAS:GetWrapper(self.__UI:GetLowerEmblemTexture())
	end

	__Doc__"GetUpperBackgroundFileName" [[
		<desc>Returns the image file for the upper portion of the tabard model's current background design</desc>
		<return type="string">the image file path for the upper portion of the tabard model's current background design</return>
	]]

	__Doc__"GetUpperEmblemFileName" [[
		<desc>Returns the image file for the upper portion of the tabard model's current emblem design</desc>
		<return type="string">the image file path for the upper portion of the tabard model's current emblem design</return>
	]]

	__Doc__[[
		<desc>Gets a Texture object to display the upper portion of the tabard model's current emblem design</desc>
		<return type="System.Widget.Texture">the texture object to display the upper portion of the tabard model's current emblem design</return>
	]]
	function GetUpperEmblemTexture(self)
		return IGAS:GetWrapper(self.__UI:GetUpperEmblemTexture())
	end

	__Doc__"InitializeTabardColors" [[Sets the tabard model's design to match the player's guild tabard. If the player is not in a guild or the player's guild does not yet have a tabard design, randomizes the tabard model's design.]]

	__Doc__"Save" [[Saves the current tabard model design as the player's guild tabard. Has no effect if the player is not a guild leader.]]

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("TabardModel", nil, parent, ...)
	end
endclass "TabardModel"

class "TabardModel"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(TabardModel)
endclass "TabardModel"
