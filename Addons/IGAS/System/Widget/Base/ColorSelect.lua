-- Author      : Kurapica
-- Create Date : 7/16/2008 11:15
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.ColorSelect", version) then
	return
end

__Doc__[[ColorSelect is a very specialized type of frame with a specific purpose; to allow the user to interactively select a color, typically to control the appearance of another UI element.]]
__AutoProperty__()
class "ColorSelect"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the color select frame's color selection changes</desc>
		<param name="r">number, red component of the selected color (0.0 - 1.0)</param>
		<param name="g">number, green component of the selected color (0.0 - 1.0)</param>
		<param name="b">number, blue component of the selected color (0.0 - 1.0)</param>
		<param name="a">number, alpha component of the selected color (0.0 - 1.0)</param>
	]]
	__WidgetEvent__() event "OnColorSelect"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetColorHSV" [[
		<desc>Returns the hue, saturation and value of the currently selected color</desc>
		<return type="hue">number, Hue of the selected color (angle on the color wheel in degrees; 0 = red, increasing counter-clockwise)</return>
		<return type="saturation">number, Saturation of the selected color (0.0 - 1.0)</return>
		<return type="value">number, Value of the selected color (0.0 - 1.0)</return>
	]]

	__Doc__"GetColorRGB" [[
		<desc>Returns the red, green and blue components of the currently selected color</desc>
		<return type="red">number, Red component of the color (0.0 - 1.0)</return>
		<return type="blue">number, Blue component of the color (0.0 - 1.0)</return>
		<return type="green">number, Green component of the color (0.0 - 1.0)</return>
	]]

	__Doc__[[
		<desc>Returns the texture for the color picker's value slider background. The color picker's value slider displays a value gradient (and allows control of the color's value component) for whichever hue and saturation is selected in the color wheel. (In the default UI's ColorPickerFrame, this part is found to the right of the color wheel.)</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used for drawing the value slider background</return>
	]]
	function GetColorValueTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetColorValueTexture(...))
	end

	__Doc__[[
		<desc> Returns the texture for the color picker's value slider thumb. The color picker's value slider displays a value gradient (and allows control of the color's value component) for whichever hue and saturation is selected in the color wheel. (In the default UI's ColorPickerFrame, this part is found to the right of the color wheel.) The thumb texture is the movable part indicating the current value selection.</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used for drawing the slider thumb</return>
	]]
	function GetColorValueThumbTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetColorValueThumbTexture(...))
	end

	__Doc__[[
		<desc>Returns the texture for the color picker's hue/saturation wheel</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used for drawing the hue/saturation wheel</return>
	]]
	function GetColorWheelTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetColorWheelTexture(...))
	end

	__Doc__[[
		<desc>Returns the texture for the selection indicator on the color picker's hue/saturation wheel</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used for drawing the hue/saturation wheel's selection indicator</return>
	]]
	function GetColorWheelThumbTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetColorWheelThumbTexture(...))
	end

	__Doc__"SetColorHSV" [[
		<desc>Sets the color picker's selected color by hue, saturation and value</desc>
		<param name="hue">number,ue of a color (angle on the color wheel in degrees; 0 = red, increasing counter-clockwise)</param>
		<param name="saturation">number,aturation of a color (0.0 - 1.0)</param>
		<param name="value">number,alue of a color (0.0 - 1.0)</param>
	]]

	__Doc__"SetColorRGB" [[
		<desc>Sets the color picker's selected color by red, green and blue components</desc>
		<param name="red">number,ed component of the color (0.0 - 1.0)</param>
		<param name="blue">number,lue component of the color (0.0 - 1.0)</param>
		<param name="green">number,reen component of the color (0.0 - 1.0)</param>
	]]

	__Doc__"SetColorValueTexture" [[
		<desc>Sets the Texture object used to display the color picker's value slider. The color picker's value slider displays a value gradient (and allows control of the color's value component) for whichever hue and saturation is selected in the color wheel. In the default UI's ColorPickerFrame, this part is found to the right of the color wheel.</p></desc>
		<param name="texture|filename"></param>
		<param name="texture">System.Widget.Texture, Reference to a Texture object</param>
		<param name="filename">string, Path to a texture image file</param>
	]]

	__Doc__"SetColorValueThumbTexture" [[
		<desc>Sets the texture for the color picker's value slider thumb. The color picker's value slider displays a value gradient (and allows control of the color's value component) for whichever hue and saturation is selected in the color wheel. (In the default UI's ColorPickerFrame, this part is found to the right of the color wheel.) The thumb texture is the movable part indicating the current value selection.</desc>
		<param name="texture|filename"></param>
		<param name="texture">System.Widget.Texture, Reference to a Texture object</param>
		<param name="filename">string, Path to a texture image file</param>
	]]

	__Doc__"SetColorWheelTexture" [[
		<desc>Sets the Texture object used to display the color picker's hue/saturation wheel. This method does not allow changing the texture image displayed for the color wheel; rather, it allows customization of the size and placement of the Texture object into which the game engine draws the standard color wheel image.</desc>
		<param name="texture|filename"></param>
		<param name="texture">System.Widget.Texture, Reference to a Texture object</param>
		<param name="filename">string, Path to a texture image file</param>
	]]

	__Doc__"SetColorWheelThumbTexture" [[
		<desc>Sets the texture for the selection indicator on the color picker's hue/saturation wheel</desc>
		<param name="texture|filename"></param>
		<param name="texture">System.Widget.Texture, Reference to a Texture object</param>
		<param name="filename">string, Path to a texture image file</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("ColorSelect", nil, parent, ...)
	end
endclass "ColorSelect"

class "ColorSelect"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(ColorSelect)
endclass "ColorSelect"
