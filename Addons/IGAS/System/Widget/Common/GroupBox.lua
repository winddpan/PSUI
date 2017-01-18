-- Author      : Kurapica
-- Change Log  :
--				2011/03/13	Recode as class

---------------------------------------------------------------------------------------------------------------------------------------
--- GroupBox is created as a box to contains other frames.
-- <br><br>inherit <a href="..\Base\Frame.html">Frame</a> For all methods, properties and scriptTypes
-- @name GroupBox
-- @class table
-- @field Caption the groupbox's caption text
---------------------------------------------------------------------------------------------------------------------------------------

-- Check Version
local version = 6

if not IGAS:NewAddon("IGAS.Widget.GroupBox", version) then
	return
end

__AutoProperty__()
class "GroupBox"
	inherit "Frame"
	extend "IFContainer"

    -- GroupBox Template
    TEMPLATE_CLASSIC = "CLASSIC"
	TEMPLATE_INLINE = "INLINE"

	enum "GroupBoxStyle" {
		TEMPLATE_CLASSIC,
		TEMPLATE_INLINE
	}

    _FrameBackdrop = {
        bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
        edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
        tile = true, tileSize = 8, edgeSize = 8,
        insets = { left = 3, right = 3, top = 6, bottom = 6 }
    }

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Update the container's postion, needed by the IFContainer</desc>
		<param name="..."></param>
	]]
	function UpdatePanelPosition(self)
		self.Panel:ClearAllPoints()
		self.Panel:SetPoint("BOTTOMLEFT")
		self.Panel:SetPoint("BOTTOMRIGHT")
		self.Panel:SetPoint("TOP", self:GetChild("Text"), 0, -3)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the caption text for the groupbox]]
	property "Caption" {
		Set = function(self, text)
			self:GetChild("Text").Text = text
		end,

		Get = function(self)
			return self:GetChild("Text").Text
		end,

		Type = LocaleString,
	}

	__Doc__[[the groupbox's style]]
	__Handler__( function (self, style)
		if style == TEMPLATE_CLASSIC then
			self:GetChild("Text"):ClearAllPoints()
			self:GetChild("Text"):SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 0)

			return self:GetChild("Underline") and self:GetChild("Underline"):Hide()
		elseif style == TEMPLATE_INLINE then
			self:GetChild("Text"):ClearAllPoints()
			self:GetChild("Text"):SetPoint("TOPLEFT", self, "TOPLEFT", 16, -16)

			local underLine = Texture("Underline", self)
			underLine:SetPoint("TOPLEFT", self:GetChild("Text"), "BOTTOMLEFT", 0, -3)
			underLine:SetPoint("RIGHT", self, "RIGHT", -16, 0)
			underLine.Height = 1
			underLine:SetTexture(1, 1, 1, 0.2)
			underLine:Show()
		end
	end )
	property "Style" { Type = GroupBoxStyle, Default = TEMPLATE_CLASSIC }

	__Doc__[[whether show the groupbox's border]]
	property "ShowBorder" {
		Set = function(self, flag)
			if flag then
				self:SetBackdrop(_FrameBackdrop)
				self:SetBackdropColor(0,0,0,1)
			else
				self:SetBackdrop(nil)
			end
		end,
		Get = function(self)
			return self:GetBackdrop() and true or false
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function GroupBox(self, name, parent, ...)
    	Super(self, name, parent, ...)

        self:SetPoint("CENTER",parent,"CENTER",0,0)
        self:SetBackdrop(_FrameBackdrop)
        self:SetBackdropColor(0,0,0,1)

        local text = FontString("Text", self, "OVERLAY","OptionsFontHighlight")
        text.JustifyH = "LEFT"
        text:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 0)
        text.Text = "GroupBox"
    end
endclass "GroupBox"
