-- Author      : Kurapica
-- ChangreLog  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.ColorPicker", version) then
	return
end

__Doc__[[ColorPicker is using to pick color for special using]]
__AutoProperty__()
class "ColorPicker"
	inherit "ColorSelect"

	-- Define Style
    -- Style
    TEMPLATE_CLASSIC = "CLASSIC"
    TEMPLATE_LIGHT = "LIGHT"

    -- Define Block
	enum "ColorPickerStyle" {
        TEMPLATE_CLASSIC,
		TEMPLATE_LIGHT,
    }

	-- Backdrop Handlers
	_FrameBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 9,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}
	_FrameBackdropTitle = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "",
		tile = true, tileSize = 16, edgeSize = 0,
		insets = { left = 3, right = 3, top = 3, bottom = 0 }
	}
	_FrameBackdropCommon = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	}
	_FrameBackdropSlider = {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 6, bottom = 6 }
	}

	-- Event Handlers
	local function frameOnMouseDown(self)
		self.Parent:StartMoving()
	end

	local function frameOnMouseUp(self)
		self.Parent:StopMovingOrSizing()
	end

	local function Format(value)
		return tonumber(format("%.2f", value))
	end

	local function Slider_OnValueChanged(self)
		self.Text.Text = format("%.2f", 1 - self.Value)
		if self.Visible and self.Enabled then
			return self.Parent:Fire("OnColorPicking", self.Parent:GetColor())
		end
	end

	local function OnColorSelect(self)
		self.ColorSwatch:SetTexture(self:GetColorRGB())
		return self:Fire("OnColorPicking", self:GetColor())
	end

	local function Okay_OnClick(self)
		local parent = self.Parent
		parent:Fire("OnColorPicked", parent:GetColor())
		parent.Visible = false
	end

	local function Cancel_OnClick(self)
		local parent = self.Parent
		parent:Fire("OnColorPicked", parent.__DefaultValue.r, parent.__DefaultValue.g, parent.__DefaultValue.b, parent.__DefaultValue.a)
		parent.Visible = false
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the color is picked</desc>
		<param name="r">number, [0-1] the red parent</param>
		<param name="g">number, [0-1] the green parent</param>
		<param name="b">number, [0-1] the blue parent</param>
		<param name="a">number, [0-1] the alpha parent</param>
	]]
	event "OnColorPicked"

	__Doc__[[
		<desc>Run when the color is picking</desc>
		<param name="r">number, [0-1] the red parent</param>
		<param name="g">number, [0-1] the green parent</param>
		<param name="b">number, [0-1] the blue parent</param>
		<param name="a">number, [0-1] the alpha parent</param>
	]]
	event "OnColorPicking"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Sets the ColorPicker's style</desc>
		<param name="style">System.Widget.ColorPicker.ColorPickerStyle</param>
	]]
	function SetStyle(self, style)
		local t

		-- Check Style
		if not style or type(style) ~= "string" or style == self.__Style then
			return
		end

		-- Change Style
		if style == TEMPLATE_CLASSIC then
			self:SetBackdrop(_FrameBackdropCommon)

			self.ColorPicker_Caption:SetBackdrop(nil)
			self.ColorPicker_Caption:ClearAllPoints()
			self.ColorPicker_Caption:SetPoint("TOP", self, "TOP", 0, 12)
			self.ColorPicker_Caption.Width = 136
			self.ColorPicker_Caption.Height = 36
			self.ColorPicker_Caption.Text.JustifyV = "MIDDLE"
			self.ColorPicker_Caption.Text.JustifyH = "CENTER"

			local backTexture = Texture("HeaderBack", self.ColorPicker_Caption, "BACKGROUND")

			backTexture.TexturePath = [[Interface\DialogFrame\UI-DialogBox-Header]]
			backTexture:SetAllPoints(self.ColorPicker_Caption)
			backTexture:SetTexCoord(0.24, 0.76, 0, 0.56)
			backTexture.Visible = true

			if self:GetChild("ColorPicker_Caption"):GetChild("Text").Width + 36 > 136 then
				self:GetChild("ColorPicker_Caption").Width = self:GetChild("ColorPicker_Caption"):GetChild("Text").Width + 36
			else
				self:GetChild("ColorPicker_Caption").Width = 136
			end
		elseif style == TEMPLATE_LIGHT then
			self:SetBackdrop(_FrameBackdrop)
			self:SetBackdropColor(0, 0, 0)
			self:SetBackdropBorderColor(0.4, 0.4, 0.4)

			local title = Frame("ColorPicker_Caption", self)
			title:ClearAllPoints()
			title:SetPoint("TOPLEFT", self, "TOPLEFT", 6, 0)
			title:SetPoint("RIGHT", self, "RIGHT")
			title:SetBackdrop(_FrameBackdropTitle)
			title:SetBackdropColor(1, 0, 0, 0)
			title.Height = 24

			if title.HeaderBack then
				title.HeaderBack.Visible = false
			end
		end

		self.__Style = style
	end

	__Doc__[[
		<desc>Gets the ColorPicker's style</desc>
		<return type="System.Widget.ColorPicker.ColorPickerStyle"></return>
	]]
	function GetStyle(self)
		return self.__Style or TEMPLATE_LIGHT
	end

	__Doc__[[
		<desc>Sets the ColorPicker's default color</desc>
		<param name="r">number, component of the color (0.0 - 1.0)</param>
		<param name="g">number, component of the color (0.0 - 1.0)</param>
		<param name="b">number, component of the color (0.0 - 1.0)</param>
		<param name="a">number, Optional,opacity for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetColor(self, r, g, b, a)
		a = (a and type(a) == "number" and a >= 0 and a <= 1 and a) or 1

		self.OpacitySlider.Value = 1 - a

		self:SetColorRGB(r, g, b)

		r, g, b = self:GetColorRGB()

		a = 1 - self.OpacitySlider.Value

		-- Keep default
		self.__DefaultValue.r, self.__DefaultValue.g, self.__DefaultValue.b, self.__DefaultValue.a = Format(r), Format(g), Format(b), Format(a)
	end

	__Doc__[[
		<desc>Gets the ColorPicker's default color</desc>
		<return type="r">number, component of the color (0.0 - 1.0)</return>
		<return type="g">number, component of the color (0.0 - 1.0)</return>
		<return type="b">number, component of the color (0.0 - 1.0)</return>
		<return type="a">number, Optional,opacity for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetColor(self)
		local r, g, b = self:GetColorRGB()

		if self.OpacitySlider.Visible and self.OpacitySlider.Enabled then
			return Format(r), Format(g), Format(b), Format(1 - self.OpacitySlider.Value)
		else
			return Format(r), Format(g), Format(b)
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the color displayed now on the ColorPicker]]
	property "Color" {
		Set = function(self, color)
			self:SetColor(color.r, color.g, color.b, color.a)
		end,
		Get = function(self)
			return ColorType(self:GetColor())
		end,
		Type = ColorType,
	}

	__Doc__[[the style of the ColorPicker]]
	property "Style" { Type = ColorPickerStyle }

	__Doc__[[the caption alignment of the ColorPicker]]
	property "CaptionAlign" {
		Get = function(self)
			return self:GetChild("ColorPicker_Caption"):GetChild("Text").JustifyH
		end,
		Set = function(self, value)
			if self.Style ~= TEMPLATE_CLASSIC then
				self:GetChild("ColorPicker_Caption"):GetChild("Text").JustifyH = value
			end
		end,
		Type = JustifyHType,
	}

	__Doc__[[the title bar color of the ColorPicker]]
	property "TitleBarColor" {
		Get = function(self)
			return self:GetChild("ColorPicker_Caption").BackdropColor
		end,
		Set = function(self, value)
			self:GetChild("ColorPicker_Caption").BackdropColor = value
		end,
		Type = ColorType,
	}

	__Doc__[[the caption text of the ColorPicker]]
	property "Caption" {
		Set = function(self, title)
			self:GetChild("ColorPicker_Caption"):GetChild("Text").Text = title

			if self.Style == TEMPLATE_CLASSIC then
				if self:GetChild("ColorPicker_Caption"):GetChild("Text").Width + 36 > 136 then
					self:GetChild("ColorPicker_Caption").Width =  self:GetChild("ColorPicker_Caption"):GetChild("Text").Width + 36
				else
					self:GetChild("ColorPicker_Caption").Width = 136
				end
			end
		end,
		Get = function(self)
			return self:GetChild("ColorPicker_Caption"):GetChild("Text").Text
		end,
		Type = LocaleString,
	}

	__Doc__[[the okay button's text]]
	property "OkayButtonText" {
		Set = function(self, text)
			self:GetChild("OkayBtn").Text = text or "Okay"
		end,
		Get = function(self)
			return self:GetChild("OkayBtn").Text
		end,
		Type = LocaleString,
	}

	__Doc__[[the cancel button's text]]
	property "CancelButtonText" {
		Set = function(self, text)
			self:GetChild("CancelBtn").Text = text or "Cancel"
		end,
		Get = function(self)
			return self:GetChild("CancelBtn").Text
		end,
		Type = LocaleString,
	}

	__Doc__[[whether the ColorPicker can pick opacity]]
	property "HasOpacity" {
		Set = function(self, flag)
			self:GetChild("OpacitySlider").Enabled = flag
		end,
		Get = function(self)
			return self:GetChild("OpacitySlider").Enabled
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function ColorPicker(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Width = 360
		self.Height = 220
		self.Movable = true
		self.Resizable = true
		self.FrameStrata = "FULLSCREEN_DIALOG"
		self.Toplevel = true
		self.MouseEnabled = true
		self.KeyboardEnabled = true

		self:SetPoint("CENTER",parent,"CENTER",0,0)
		self:SetMinResize(300,200)
        self:SetBackdrop(_FrameBackdrop)
		self:SetBackdropColor(0, 0, 0)
		self:SetBackdropBorderColor(0.4, 0.4, 0.4)

		self.__DefaultValue = {}

		self.OnColorSelect = self.OnColorSelect + OnColorSelect

		-- Caption
		local title = Frame("ColorPicker_Caption", self)
		title.MouseEnabled = true
		title.Height = 24
		title:SetPoint("TOPLEFT", self, "TOPLEFT", 6, 0)
		title:SetPoint("RIGHT", self, "RIGHT")
		title:SetBackdrop(_FrameBackdropTitle)
		title:SetBackdropColor(1, 0, 0, 0)
		title.OnMouseDown = frameOnMouseDown
		title.OnMouseUp = frameOnMouseUp

		local titleText = FontString("Text", title, "OVERLAY", "GameFontNormal")
		titleText:SetPoint("LEFT", title, "LEFT")
		titleText:SetPoint("RIGHT", title, "RIGHT")
		titleText:SetPoint("CENTER", title, "CENTER")
		titleText.Height = 24
		titleText.Text = "ColorPicker"
		titleText.JustifyV = "MIDDLE"
		titleText.JustifyH = "CENTER"

		-- ColorWheelTexture
		local colorWheel = Texture("ColorWheel", self)
		colorWheel.Width = 128
		colorWheel.Height = 128
		colorWheel:SetPoint("TOPLEFT", self, "TOPLEFT", 32, -32)
		self:SetColorWheelTexture(colorWheel)

		-- ColorWheelThumbTexture
		local colorWheelThumb = Texture("ColorWheelThumb", self)
		colorWheelThumb.Width = 10
		colorWheelThumb.Height = 10
		colorWheelThumb.TexturePath = [[Interface\Buttons\UI-ColorPicker-Buttons]]
		colorWheelThumb:SetTexCoord(0, 0.15625, 0, 0.625)
		self:SetColorWheelThumbTexture(colorWheelThumb)

		-- ColorValueTexture
		local colorValue = Texture("ColorValue", self)
		colorValue.Width = 32
		colorValue.Height = 128
		colorValue:SetPoint("TOPLEFT", colorWheel, "TOPRIGHT", 24, 0)
		self:SetColorValueTexture(colorValue)

		-- ColorValueThumbTexture
		local colorValueThumb = Texture("ColorValueThumb", self)
		colorValueThumb.Width = 48
		colorValueThumb.Height = 14
		colorValueThumb.TexturePath = [[Interface\Buttons\UI-ColorPicker-Buttons]]
		colorValueThumb:SetTexCoord(0.25, 1.0, 0, 0.875)
		self:SetColorValueThumbTexture(colorValueThumb)

		-- ColorSwatch
		local watch = Texture("ColorSwatch", self, "ARTWORK")
		watch.Width = 32
		watch.Height = 32
		watch:SetPoint("TOPLEFT", colorValue, "TOPRIGHT", 24, 0)
		watch:SetTexture(1, 1, 1, 1)

		-- OpacitySlider
		local sliderOpacity = Slider("OpacitySlider", self)
		sliderOpacity:SetMinMaxValues(0, 1)
		sliderOpacity:SetPoint("TOPLEFT", watch, "TOPRIGHT", 24, 0)
		sliderOpacity.Orientation = "VERTICAL"
		sliderOpacity.ValueStep = 0.01
		sliderOpacity.Value = 0
		sliderOpacity.Width = 16
		sliderOpacity.Height = 128
		sliderOpacity:SetBackdrop(_FrameBackdropSlider)
		sliderOpacity:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")

		local thumb = sliderOpacity:GetThumbTexture()
		thumb.Height = 32
		thumb.Width = 32

		local sliderText = FontString("Text", sliderOpacity, "ARTWORK", "GameFontNormalSmall")
		sliderText:SetPoint("BOTTOM", sliderOpacity, "TOP")
		sliderText.Text = "1.00"

		local subText = FontString("SubText", sliderOpacity, "ARTWORK", "GameFontNormalHuge")
		subText.Text = "-"
		subText:SetPoint("BOTTOMLEFT", sliderOpacity, "BOTTOMRIGHT", 8, 3)
		subText:SetTextColor(1, 1, 1)

		local addText = FontString("AddText", sliderOpacity, "ARTWORK", "GameFontNormalHuge")
		addText.Text = "+"
		addText:SetPoint("TOPLEFT", sliderOpacity, "TOPRIGHT", 6, -3)
		addText:SetTextColor(1, 1, 1)

		sliderOpacity.OnValueChanged = Slider_OnValueChanged

		-- Okay Button
		local btnOkay = NormalButton("OkayBtn", self)
		btnOkay.Style = "CLASSIC"
		btnOkay.Height = 24
		btnOkay.Text = "Okay"
		btnOkay:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 6, 12)
		btnOkay:SetPoint("RIGHT", self, "CENTER")
		btnOkay.OnClick = Okay_OnClick

		-- Cancel Button
		local btnCancel = NormalButton("CancelBtn", self)
		btnCancel.Style = "CLASSIC"
		btnCancel.Height = 24
		btnCancel.Text = "Cancel"
		btnCancel:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -6, 12)
		btnCancel:SetPoint("LEFT", self, "CENTER")
		btnCancel.OnClick = Cancel_OnClick
	end
endclass "ColorPicker"
