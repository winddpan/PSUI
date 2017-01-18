-- Author      : Kurapica
-- Change Log  :
--				2011/03/13	Recode as class
--              2012/06/10  Inherit change to Frame


-- Check Version
local version = 7

if not IGAS:NewAddon("IGAS.Widget.OptionSlider", version) then
	return
end

__Doc__[[OptionSlider is using to make settings in numbers]]
__AutoProperty__()
class "OptionSlider"
	inherit "Frame"

	GameTooltip = IGAS.GameTooltip

	_FrameBackdrop = {
        bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
        edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
        tile = true, tileSize = 8, edgeSize = 8,
        insets = { left = 3, right = 3, top = 6, bottom = 6 }
    }

    -- Event Handler
	local function OnEnter(self)
		if self.Enabled then
			if self.__TooltipText and self.__TooltipText ~= "" then
				GameTooltip:SetOwner(self, self.__TooltipAnchor or "ANCHOR_RIGHT")
				GameTooltip:SetText(self.__TooltipText)
				GameTooltip:Show()
			end
		end
	end

	local function OnLeave(self)
		GameTooltip:Hide()
	end

	local function OnValueChanged(self)
		self.Parent:GetChild("Text").Text = strformat(self.__Format or "%.0f", self.Value)
		return self.Parent:Fire("OnValueChanged")
	end

	local function OnMinMaxChanged(self)
		return self.Parent:Fire("OnMinMaxChanged")
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the option slider's minimum and maximum values change</desc>
		<param name="min">number, minimum value of the option slider</param>
		<param name="max">number, maximum value of the option slider</param>
	]]
	event "OnMinMaxChanged"

	__Doc__[[
		<desc>Run when the option slider's value changes</desc>
		<param name="value">number, value of the option slider</param>
	]]
	event "OnValueChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Sets the minimum and maximum values for the slider</desc>
		<param name="minValue">number, lower boundary for values represented by the slider position (number)</param>
		<param name="maxValue">number, upper boundary for values represented by the slider position (number)</param>
	]]
	function SetMinMaxValues(self, minV, maxV)
		self = self:GetChild("Slider")

		if type(minV) ~= "number" or type(maxV) ~= "number" or minV >= maxV then
			return
		end

		self.Parent:GetChild("Low").Text = strformat(self.__Format, minV)
		self.Parent:GetChild("High").Text = strformat(self.__Format, maxV)

		if self.Value > maxV then
			self.Value = maxV
		elseif self.Value < minV then
			self.Value = minV
		end

		self.Parent:GetChild("Text").Text = ""..self.Value

		return self.__UI:SetMinMaxValues(minV, maxV)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the texture object for the slider thumb]]
	property "ThumbTexture" {
		Get = function(self)
			return self:GetChild("Slider").ThumbTexture
		end,
		Set = function(self, texture)
			self:GetChild("Slider").ThumbTexture = texture
		end,
		Type = Texture,
	}

	__Doc__[[the texture file path for the slider thumb]]
	property "ThumbTexturePath" {
		Get = function(self)
			return self:GetChild("Slider").ThumbTexturePath
		end,
		Set = function(self, texture)
			self:GetChild("Slider").ThumbTexturePath = texture
		end,
		Type = String,
	}

	__Doc__[[the layer used for drawing the filled-in portion of the slider]]
	property "Layer" {
		Get = function(self)
			return self:GetChild("Slider").Layer
		end,
		Set = function(self, layer)
			self:GetChild("Slider").Layer = layer
		end,
		Type = DrawLayer,
	}

	__Doc__[[the value representing the current position of the slider thumb]]
	property "Value" {
		Get = function(self)
			return self:GetChild("Slider").Value
		end,
		Set = function(self, value)
			self:GetChild("Slider").Value = value
		end,
		Type = Number,
	}

	__Doc__[[whether user interaction with the slider is allowed]]
	property "Enabled" {
		Get = function(self)
			return self:GetChild("Slider").Enabled
		end,
		Set = function(self, enabled)
			self:GetChild("Slider").Enabled = enabled
		end,
		Type = Boolean,
	}

	__Doc__[[the minimum and maximum values of the slider bar]]
	property "MinMaxValue" {
		Get = function(self)
			return self:GetChild("Slider").MinMaxValue
		end,
		Set = function(self, value)
			self:GetChild("Slider").MinMaxValue = value
		end,
		Type = MinMax,
	}

	__Doc__[[the minimum increment between allowed slider values]]
	property "ValueStep" {
		Get = function(self)
			return self:GetChild("Slider"):GetValueStep()
		end,
		Set = function(self, value)
			self = self:GetChild("Slider")

			if value <= 0 then
				error("The OptionSlider's value step must be greater than 0", 2)
			end

			local fmt = tostring(value)

			if strfind(fmt, "%.") then
				self.__Format = "%."..tostring(strlen(fmt) - strfind(fmt, "%.")).."f"
			else
				self.__Format = "%.0f"
			end

			self:SetValueStep(value)

			local minV, maxV = self.__UI:GetMinMaxValues()

			self.Parent:GetChild("Low").Text = strformat(self.__Format, minV)
			self.Parent:GetChild("High").Text = strformat(self.__Format, maxV)
			self.Parent:GetChild("Text").Text = strformat(self.__Format, self.Value)
		end,
		Type = Number,
	}

	__Doc__[[the text to be diplayed at the topleft of the slide bar]]
	property "Title" {
		Set = function(self, title)
			self:GetChild("Title").Text = title

			if title ~= "" then
				self:GetChild("Slider"):SetPoint("TOP", self:GetChild("Title"), "BOTTOM")
			else
				self:GetChild("Slider"):SetPoint("TOP")
			end
		end,

		Get = function(self)
			return self:GetChild("Title").Text
		end,

		Type = LocaleString,
	}

	__Doc__[[the tooltip to be shown when mouse is over the silder bar]]
	property "TooltipText" {
		Set = function(self, text)
			if type(text) == "string" and text ~= "" then
				self:GetChild("Slider").__TooltipText = text
			else
				self:GetChild("Slider").__TooltipText = nil
			end
		end,

		Get = function(self)
			return self:GetChild("Slider").__TooltipText or ""
		end,

		Type = LocaleString,
	}

	__Doc__[[the tooltip's position]]
	property "TooltipAnchor" {
		Set = function(self, anchor)
			self:GetChild("Slider").__TooltipAnchor = anchor
		end,

		Get = function(self)
			return self:GetChild("Slider").__TooltipAnchor or "ANCHOR_RIGHT"
		end,

		Type = AnchorType,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function OptionSlider(self, name, parent, ...)
    	Super(self, name, parent, ...)

		self.Width = 144
		self.Height = 26

		-- Text part
        local title = FontString("Title", self, "ARTWORK", "GameFontHighlight")
		title:SetPoint("TOP")
		title.Text = ""

		local low = FontString("Low", self, "ARTWORK", "GameFontHighlightSmall")
		low:SetPoint("BOTTOMLEFT", 0, 3)
		low.Text = "1"

		local high = FontString("High", self, "ARTWORK", "GameFontHighlightSmall")
		high:SetPoint("BOTTOMRIGHT", 0, 3)
		high.Text = "10"

		local text = FontString("Text", self, "ARTWORK", "GameFontHighlightSmall")
		text:SetPoint("BOTTOM")
		text.Text = "1"

		-- Slider part
        local slider = Slider("Slider", self)
		slider:SetPoint("TOP")
		slider:SetPoint("LEFT")
		slider:SetPoint("RIGHT")
		slider:SetPoint("BOTTOM", text, "TOP")
        slider.Orientation = "HORIZONTAL"
		slider.ValueStep = 1
		slider.__Format = "%.0f"
		slider:SetMinMaxValues(1, 10)

        slider.ThumbTexturePath = "Interface\\Buttons\\UI-SliderBar-Button-Horizontal"
        slider.ThumbTexture.Height = 32
        slider.ThumbTexture.Width = 32

        slider:SetHitRectInsets(0, 0, -10, -10)
        slider:SetBackdrop(_FrameBackdrop)

		slider.Value = 1

		slider.OnEnter = slider.OnEnter + OnEnter
		slider.OnLeave = slider.OnLeave + OnLeave

		slider.OnValueChanged = slider.OnValueChanged + OnValueChanged
		slider.OnMinMaxChanged = slider.OnMinMaxChanged + OnMinMaxChanged
    end
endclass "OptionSlider"
