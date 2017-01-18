-- Author      : Kurapica
-- Create Date : 7/16/2008 14:51
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 8
if not IGAS:NewAddon("IGAS.Widget.StatusBar", version) then
	return
end

__Doc__[[StatusBars are similar to Sliders, but they are generally used for display as they don't offer any tools to receive user input.]]
__AutoProperty__()
class "StatusBar"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	-----------------------------------------------------
	__Doc__[[
		<desc>Fired when the status bar's minimum and maximum values change</desc>
		<param name="min">new minimun value of the status bar</param>
		<param name="max">new maximum value of the status bar</param>
	]]
	__WidgetEvent__() event "OnMinMaxChanged"

	__Doc__[[
		<desc>Fired when the status bar's value changes</desc>
		<param name="value">new value of the status bar</param>
	]]
	__WidgetEvent__() event "OnValueChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetMinMaxValues" [[
		<desc>Returns the minimum and maximum values of the status bar</desc>
		<return type="minValue">number, lower boundary for values represented on the status bar</return>
		<return type="maxValue">number, upper boundary for values represented on the status bar</return>
	]]

	__Doc__"GetOrientation" [[
		<desc>Returns the orientation of the status bar</desc>
		<return type="System.Widget.Orientation"></return>
	]]

	__Doc__"GetRotatesTexture" [[
		<desc>Returns whether the status bar's texture is rotated to match its orientation</desc>
		<return type="boolean">1 if the status bar texture should be rotated 90 degrees counter-clockwise when the status bar is vertically orientation, otherwise nil</return>
	]]

	__Doc__"GetStatusBarColor" [[
		<desc>Returns the color shading used for the status bar's texture</desc>
		<return type="red">number, Red component of the color (0.0 - 1.0)</return>
		<return type="green">number, Green component of the color (0.0 - 1.0)</return>
		<return type="blue">number, Blue component of the color (0.0 - 1.0)</return>
		<return type="alpha">number, Alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__[[
		<desc>Returns the Texture object used for drawing the filled-in portion of the status bar</desc>
		<return type="System.Widget.Texture">the Texture object used for drawing the filled-in portion of the status bar</return>
	]]
	function GetStatusBarTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetStatusBarTexture(...))
	end

	__Doc__"GetValue" [[
		<desc>Returns the current value of the status bar</desc>
		<return type="number">the value indicating the amount of the status bar's area to be filled in</return>
	]]

	__Doc__"SetMinMaxValues" [[
		<desc>Sets the minimum and maximum values of the status bar</desc>
		<param name="minValue">number, Lower boundary for values represented on the status bar</param>
		<param name="maxValue">number, Upper boundary for values represented on the status bar</param>
	]]

	__Doc__"SetOrientation" [[
		<desc>Sets the orientation of the status bar</desc>
		<param name="orientation">System.Widget.Orientation, token describing the orientation and direction of the status bar</param>
	]]

	__Doc__"SetRotatesTexture" [[
		<desc>Sets whether the status bar's texture is rotated to match its orientation</desc>
		<param name="boolean">True to rotate the status bar texture 90 degrees counter-clockwise when the status bar is vertically oriented; false otherwise</param>
	]]

	__Doc__"SetStatusBarColor" [[
		<desc>Sets the color shading for the status bar's texture. As with :SetVertexColor(), this color is a shading applied to the texture image.</desc>
		<param name="red">number, Red component of the color (0.0 - 1.0)</param>
		<param name="green">number, Green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, Blue component of the color (0.0 - 1.0)</param>
		<param name="alpha">number, Alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__[[
		<desc>Sets the texture used for drawing the filled-in portion of the status bar. The texture image is stretched to fill the dimensions of the entire status bar, then cropped to show only a portion corresponding to the status bar's current value.</desc>
		<format>texture|filename[, layer]</format>
		<param name="texture">System.Widget.Texture, Reference to an existing Texture object</param>
		<param name="filename">string, Path to a texture image file</param>
		<param name="layer">System.Widget.DrawLayer, Graphics layer in which the texture should be drawn; defaults to ARTWORK if not specified</param>
	]]
	function SetStatusBarTexture(self, texture, layer)
		self.__Layer = layer
		return self.__UI:SetStatusBarTexture(IGAS:GetUI(texture), layer)
	end

	__Doc__"SetValue" [[
		<desc>Sets the value of the status bar</desc>
		<param name="value">number, indicating the amount of the status bar's area to be filled in</param>
	]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("StatusBar", nil, parent, ...)
	end
endclass "StatusBar"

class "StatusBar"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(StatusBar)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the minimum and maximum values of the status bar]]
	property "MinMaxValue" {
		Get = function(self)
			return MinMax(self:GetMinMaxValues())
		end,
		Set = function(self, set)
			self:SetMinMaxValues(set.min, set.max)
		end,
		Type = MinMax,
	}

	__Doc__[[the orientation of the status bar]]
	property "Orientation" { Type = Orientation }

	__Doc__[[the color shading for the status bar's texture]]
	property "StatusBarColor" {
		Get = function(self)
			return ColorType(self:GetStatusBarColor())
		end,
		Set = function(self, colorTable)
			self:SetStatusBarColor(colorTable.r, colorTable.g, colorTable.b, colorTable.a)
		end,
		Type = ColorType,
	}

	__Doc__[[the texture used for drawing the filled-in portion of the status bar]]
	property "StatusBarTexture" {
		Set = function(self, texture)
			self:SetStatusBarTexture(texture, self.Layer)
		end,
		Get = "GetStatusBarTexture",
		Type = Texture,
	}

	__Doc__[[the texture file used for drawing the filled-in portion of the status bar]]
	property "StatusBarTexturePath" {
		Get = function(self)
			return self:GetStatusBarTexture() and self:GetStatusBarTexture().TexturePath
		end,
		Set = function(self, texture)
			self:SetStatusBarTexture(texture, self.Layer)
		end,
		Type = String,
	}

	__Doc__[[the layer used for drawing the filled-in portion of the status bar]]
	property "Layer" {
		Field = "__Layer",
		Set = function(self, layer)
			self:SetStatusBarTexture(self:GetStatusBarTexture(), layer)
		end,
		Default = "ARTWORK",
		Type = DrawLayer,
	}

	__Doc__[[ the value of the status bar]]
	property "Value" { Type = Number }

	__Doc__[[whether the status bar's texture is rotated to match its orientation]]
	property "RotatesTexture" { Type = Boolean }

	__Doc__[[Whether the status bar's texture is reverse filled]]
	property "ReverseFill" { Type = Boolean }
endclass "StatusBar"
