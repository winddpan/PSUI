-- Author      : Kurapica
-- Create Date : 7/16/2008 15:06
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.PlayerModel", version) then
	return
end

__Doc__[[PlayerModels are the most commonly used subtype of Model frame. They expand on the Model type by adding functions to quickly set the model to represent a particular player or creature, by unitID or creature ID.]]
__AutoProperty__()
class "PlayerModel"
	inherit "Model"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"RefreshCamera" [[
	]]

	__Doc__"RefreshUnit" [[Updates the model's appearance to match that of its unit. Used in the default UI's inspect window when the player's target changes (changing the model to match the "new appearance" of the unit "target") or when the UNIT_MODEL_CHANGED event fires for the inspected unit (updating the model's appearance to reflect changes in the unit's equipment or shapeshift form).]]

	__Doc__"SetBarberShopAlternateForm" [[
	]]

	__Doc__"SetCamDistanceScale" [[
	]]

	__Doc__"SetCreature" [[
		<desc>Sets the model to display the 3D model of a specific creature. Used in the default UI to set the model used for previewing non-combat pets and mounts (see GetCompanionInfo()), but can also be used to display the model for any creature whose data is cached by the client.</desc>
		<param name="creatureID">number, numeric ID of a creature</param>
	]]

	__Doc__"SetDisplayInfo" [[
	]]

	__Doc__"SetPortraitZoom" [[
	]]

	__Doc__"SetRotation" [[
		<desc>Sets the model's current rotation by animating the model. This method is similar to Model:SetFacing() in that it rotates the 3D model displayed about its vertical axis; however, since the PlayerModel object displays a unit's model, this method is provided to allow for animating the rotation using the model's built-in animations for turning right and left.</desc>
		<param name="facing">number, rotation angle for the model (in radians)</param>
	]]

	__Doc__"SetUnit" [[
		<desc>Sets the model to display the 3D model of a specific unit</desc>
		<param name="unit">string, unit ID of a visible unit</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("PlayerModel", nil, parent, ...)
	end
endclass "PlayerModel"

class "PlayerModel"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(PlayerModel)
endclass "PlayerModel"
