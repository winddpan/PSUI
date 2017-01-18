-- Author      : Kurapica
-- Create Date : 7/16/2008 14:39
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Slider", version) then
	return
end

__Doc__[[Sliders are elements intended to display or allow the user to choose a value in a range.]]
__AutoProperty__()
class "Slider"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	-----------------------------------------------------
	__Doc__[[
		<desc>Fired when the slider's minimum and maximum values change</desc>
		<param name="min">new minimun value of the slider bar</param>
		<param name="max">new maximum value of the slider bar</param>
	]]
	__WidgetEvent__() event "OnMinMaxChanged"

	__Doc__[[
		<desc>Fired when the slider's value changes</desc>
		<param name="value">new value of the slider bar</param>
	]]
	__WidgetEvent__() event "OnValueChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"Enable" [[Allows user interaction with the slider]]

	__Doc__"GetOrientation" [[
		<desc>Returns the orientation of the slider</desc>
		<return type="System.Widget.Orientation"></return>
	]]

	__Doc__[[
		<desc>Returns the texture for the slider thumb</desc>
		<return type="System.Widget.Texture">the Texture object used for the slider thumb</return>
	]]
	function GetThumbTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetThumbTexture(...))
	end

	__Doc__"GetValue" [[
		<desc>Returns the value representing the current position of the slider thumb</desc>
		<return type="number">Value representing the current position of the slider thumb</return>
	]]

	__Doc__"GetValueStep" [[
		<desc>Returns the minimum increment between allowed slider values</desc>
		<return type="number">minimum increment between allowed slider values</return>
	]]

	__Doc__"IsEnabled" [[
		<desc>Returns whether user interaction with the slider is allowed</desc>
		<return type="boolean">1 if user interaction with the slider is allowed; otherwise nil</return>
	]]

	__Doc__"SetMinMaxValues" [[
		<desc>Sets the minimum and maximum values of the slider</desc>
		<param name="minValue">number, Lower boundary for values represented on the slider</param>
		<param name="maxValue">number, Upper boundary for values represented on the slider</param>
	]]

	__Doc__"SetOrientation" [[
		<desc>Sets the orientation of the slider</desc>
		<param name="orientation">System.Widget.Orientation, token describing the orientation and direction of the slider</param>
	]]

	__Doc__[[
		<desc>Sets the texture for the slider thumb</desc>
		<format>filename|texture[, layer]</format>
		<param name="texture">System.Widget.Texture, Reference to an existing Texture object</param>
		<param name="filename">string, Path to a texture image file</param>
		<param name="layer">System.Widget.DrawLayer, Graphics layer in which the texture should be drawn; defaults to ARTWORK if not specified</param>
	]]
	function SetThumbTexture(self, texture, layer)
		self.__Layer = layer
		return self.__UI:SetThumbTexture(IGAS:GetUI(texture), layer)
	end

	__Doc__"SetValue" [[
		<desc>Sets the value representing the position of the slider thumb</desc>
		<param name="value">number, representing the new position of the slider thumb</param>
	]]

	__Doc__"SetValueStep" [[
		<desc>Sets the minimum increment between allowed slider values. The portion of the slider frame's area in which the slider thumb moves is its width (or height, for vertical sliders) minus 16 pixels on either end. If the number of possible values determined by the slider's minimum, maximum, and step values is less than the width (or height) of this area, the step value also affects the movement of the slider thumb</desc>
		<param name="step">number, minimum increment between allowed slider values</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("Slider", nil, parent, ...)
	end
endclass "Slider"

class "Slider"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Slider)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the orientation of the slider]]
	property "Orientation" { Type = Orientation }

	__Doc__[[the texture object for the slider thumb]]
	property "ThumbTexture" {
		Set = function(self, texture)
			self:SetThumbTexture(texture, self.Layer)
		end,
		Get = "GetThumbTexture",
		Type = Texture,
	}

	__Doc__[[the texture file path for the slider thumb]]
	property "ThumbTexturePath" {
		Get = function(self)
			return self:GetThumbTexture() and self:GetThumbTexture().TexturePath
		end,
		Set = function(self, texture)
			self:SetThumbTexture(texture, self.Layer)
		end,
		Type = String,
	}

	__Doc__[[the layer used for drawing the filled-in portion of the slider]]
	property "Layer" {
		Field = "__Layer",
		Set = function(self, layer)
			self:SetThumbTexture(self:GetThumbTexture(), layer)
		end,
		Default = "ARTWORK",
		Type = DrawLayer,
	}

	__Doc__[[the value representing the current position of the slider thumb]]
	property "Value" { Type = Number }

	__Doc__[[the minimum increment between allowed slider values]]
	property "ValueStep" { Type = Number }

	__Doc__[[whether user interaction with the slider is allowed]]
	property "Enabled" {
		Get = "IsEnabled",
		Set = function(self, enabled)
			if enabled then
				self:Enable()
			else
				self:Disable()
			end
		end,
		Type = Boolean,
	}

	__Doc__[[the minimum and maximum values of the slider bar]]
	property "MinMaxValue" {
		Get = function(self)
			return MinMax(self:GetMinMaxValues())
		end,
		Set = function(self, value)
			return self:SetMinMaxValues(value.min, value.max)
		end,
		Type = MinMax,
	}
endclass "Slider"
