-- Author      : Kurapica
-- Create Date : 8/03/2008 17:14
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6

if not IGAS:NewAddon("IGAS.Widget.SingleTextBox", version) then
	return
end

__Doc__[[SingleTextBox is a widget type using to contain one line text]]
__AutoProperty__()
class "SingleTextBox"
	inherit "EditBox"

    -- Style
    TEMPLATE_CLASSIC = "CLASSIC"
    TEMPLATE_LIGHT = "LIGHT"

    -- Define Block
	enum "TextBoxStyle" {
        TEMPLATE_CLASSIC,
		TEMPLATE_LIGHT,
    }

    -- Events
    local _FrameBackdropLight = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 9,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }

    local function OnEscapePressed(self, ...)
	    self:ClearFocus()
    end

	local function OnEditFocusLost(self, ...)
		self:HighlightText(0, 0)
    end

    local function OnEditFocusGained(self, ...)
	    self:HighlightText()
    end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Sets the singletextbox's style</desc>
		<param name="style">System.Widget.SingleTextBox.TextBoxStyle</param>
	]]
	function SetStyle(self, style)
		local t

		-- Check Style
		if not style or type(style) ~= "string" then
			return
		end

		if (not TextBoxStyle[style]) or style == self.__Style then
			return
		end

		-- Change Style
		if style == TEMPLATE_CLASSIC then
			self:SetBackdrop(nil)

			local left = Texture("LEFT", self, "BACKGROUND")
			left.Visible = true
			left.Width = 8
			left:SetTexture("Interface\\Common\\Common-Input-Border")
			left:SetTexCoord(0, 0.0625, 0, 0.625)
			left:SetPoint("TOPLEFT", self, "TOPLEFT", -5, 0)
			left:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -5, 0)

			local right = Texture("RIGHT", self, "BACKGROUND")
			right.Visible = true
			right.Width = 8
			right:SetTexture("Interface\\Common\\Common-Input-Border")
			right:SetTexCoord(0.9375, 1.0, 0, 0.625)
			right:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
			right:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)

			local middle = Texture("MIDDLE", self, "BACKGROUND")
			middle.Visible = true
			middle.Width = 10
			middle:SetTexture("Interface\\Common\\Common-Input-Border")
			middle:SetTexCoord(0.0625, 0.9375, 0, 0.625)
			middle:SetPoint("TOPLEFT", left, "TOPRIGHT", 0, 0)
			middle:SetPoint("TOPRIGHT", right, "TOPLEFT", 0, 0)
			middle:SetPoint("BOTTOMLEFT", left, "BOTTOMRIGHT", 0, 0)
			middle:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT", 0, 0)
		elseif style == TEMPLATE_LIGHT then
			if self:GetChild("LEFT") then
				self:GetChild("LEFT"):Hide()
			end
			if self:GetChild("RIGHT") then
				self:GetChild("RIGHT"):Hide()
			end
			if self:GetChild("MIDDLE") then
				self:GetChild("MIDDLE"):Hide()
			end

			self:SetBackdrop(_FrameBackdropLight)
			self:SetBackdropColor(0, 0, 0, 1)
		end

		self.__Style = style
	end

	__Doc__[[
		<desc>Gets the singletextbox's style</desc>
		<return type="System.Widget.SingleTextBox"></return>
	]]
	function GetStyle(self)
		return self.__Style or TEMPLATE_NONE
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the singletextbox's style]]
	property "Style" { Type = TextBoxStyle }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function SingleTextBox(self, name, parent, ...)
    	Super(self, name, parent, ...)

		self.Height = 25
		self.FontObject = "GameFontNormal"
		self:SetTextInsets(4 , -4, 0, 0)
        self.MouseEnabled = true
        self.AutoFocus = false
		self:SetBackdrop(_FrameBackdropLight)
        self:SetBackdropColor(0, 0, 0, 1)
		self.__Style = TEMPLATE_LIGHT

        self.OnEscapePressed = self.OnEscapePressed + OnEscapePressed
        self.OnEditFocusLost = self.OnEditFocusLost + OnEditFocusLost
        self.OnEditFocusGained = self.OnEditFocusGained + OnEditFocusGained
	end
endclass "SingleTextBox"
