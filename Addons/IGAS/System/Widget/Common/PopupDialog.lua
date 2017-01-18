-- Author      : Kurapica
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 8

if not IGAS:NewAddon("IGAS.Widget.PopupDialog", version) then
	return
end

__Doc__[[PopupDialog is using to show message and apply some operations like, confirm, cancel.]]
__AutoProperty__()
class "PopupDialog"
	inherit "Frame"

	-- Only need one table to help set button's pos.
	_CheckBtn = {}

	-- Backdrop settings
	_FrameBackdrop = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	}
	_FrameBackdropLight = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 9,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}

    -- Style
    TEMPLATE_CLASSIC = "CLASSIC"
    TEMPLATE_LIGHT = "LIGHT"

    -- Define Block
	enum "PopupDialogStyle" {
        TEMPLATE_CLASSIC,
		TEMPLATE_LIGHT,
    }

	local function OnMouseDown(self)
		self:StartMoving()
	end

	local function OnMouseUp(self)
		self:StopMovingOrSizing()
	end

	local function Okay_OnClick(self)
		self.Parent:Fire("OnOkay")
		self.Parent:Hide()
	end

	local function No_OnClick(self)
		self.Parent:Fire("OnNo")
		self.Parent:Hide()
	end

	local function Cancel_OnClick(self)
		self.Parent:Fire("OnCancel")
		self.Parent:Hide()
	end

	local function OnTextChanged(self)
		self.Parent:Fire("OnTextChanged")
	end

	local function OnEnterPressed(self)
		self.Parent:Fire("OnOkay")
		self.Parent:Hide()
	end

	local function OnEscapePressed(self)
		self.Parent:Fire("OnCancel")
		self.Parent:Hide()
	end

	local function resize(self)
		local width, height

		local width = 320
		if self:GetChild("OkayBtn").Visible and self:GetChild("NoBtn").Visible and self:GetChild("CancelBtn").Visible then
			width = 440
		elseif self:GetChild("AlertIcon").Visible then
			width = 420
		end

		if self:GetChild("InputTxt").Visible then
			height = 16 + self:GetChild("AlertText").Height + 8 + self:GetChild("InputTxt").Height + 8 + self:GetChild("OkayBtn").Height + 16
		else
			height = 16 + self:GetChild("AlertText").Height + 8 + self:GetChild("OkayBtn").Height + 16
		end

		self.Width = width
		self.Height = height
	end

	local function OnShow(self)
		if (UnitIsDeadOrGhost("player") and not self.ShowWhileDead ) then
			self:Fire("OnCancel")
			self:Hide()
			return
		end

		if (InCinematic() and not self.ShowWhileCinematic ) then
			self:Fire("OnCancel")
			self:Hide()
			return
		end

		self:ClearAllPoints()
		self:SetPoint("TOP", UIParent, "TOP", 0, -133)

		resize(self)

		wipe(_CheckBtn)

		-- Set buttons position
		self:GetChild("OkayBtn"):ClearAllPoints()
		self:GetChild("NoBtn"):ClearAllPoints()
		self:GetChild("CancelBtn"):ClearAllPoints()

		if self:GetChild("OkayBtn").Visible then
			table.insert(_CheckBtn, self:GetChild("OkayBtn"))
		end

		if self:GetChild("NoBtn").Visible  then
			table.insert(_CheckBtn, self:GetChild("NoBtn"))
		end

		if self:GetChild("CancelBtn").Visible then
			table.insert(_CheckBtn, self:GetChild("CancelBtn"))
		end

		if _CheckBtn[3] then
			if self:GetChild("InputTxt").Visible then
				_CheckBtn[1]:SetPoint("TOPRIGHT", self:GetChild("InputTxt"), "BOTTOM", -72, -8)
				_CheckBtn[2]:SetPoint("LEFT", _CheckBtn[1], "RIGHT", 13, 0)
				_CheckBtn[3]:SetPoint("LEFT", _CheckBtn[2], "RIGHT", 13, 0)
			else
				_CheckBtn[1]:SetPoint("TOPRIGHT", self:GetChild("AlertText"), "BOTTOM", -72, -8);
				_CheckBtn[2]:SetPoint("LEFT", _CheckBtn[1], "RIGHT", 13, 0)
				_CheckBtn[3]:SetPoint("LEFT", _CheckBtn[2], "RIGHT", 13, 0)
			end
		elseif _CheckBtn[2] then
			if self:GetChild("InputTxt").Visible then
				_CheckBtn[1]:SetPoint("TOPRIGHT", self:GetChild("InputTxt"), "BOTTOM", -6, -8)
				_CheckBtn[2]:SetPoint("LEFT", _CheckBtn[1], "RIGHT", 13, 0)
			else
				_CheckBtn[1]:SetPoint("TOPRIGHT", self:GetChild("AlertText"), "BOTTOM", -6, -8)
				_CheckBtn[2]:SetPoint("LEFT", _CheckBtn[1], "RIGHT", 13, 0)
			end
		elseif _CheckBtn[1] then
			if self:GetChild("InputTxt").Visible then
				_CheckBtn[1]:SetPoint("TOP", self:GetChild("InputTxt"), "BOTTOM", 0, -8)
			else
				_CheckBtn[1]:SetPoint("TOP", self:GetChild("AlertText"), "BOTTOM", 0, -8)
			end
		end

		if self:GetChild("InputTxt").Visible then
			self:GetChild("InputTxt").Focused = true
		end
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Run when the popupdialog's cancel button is clicked]]
	event "OnCancel"

	__Doc__[[Run when the popupdialog's no button is clicked]]
	event "OnNo"

	__Doc__[[Run when the popupdialog's okay button is clicked]]
	event "OnOkay"

	__Doc__[[Run when the popupdialog's inputbox's text is changed]]
	event "OnTextChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Sets the popupdialog's style</desc>
		<param name="style">System.Widget.PopupDialog.PopupDialogStyle</param>
	]]
	function SetStyle(self, style)
		local t

		-- Check Style
		if not style or type(style) ~= "string" then
			return
		end

		if (not PopupDialogStyle[style]) or style == self.__Style then
			return
		end

		-- Change Style
		if style == TEMPLATE_CLASSIC then
			self:SetBackdrop(_FrameBackdrop)
			self:SetBackdropColor(0,0,0,1)
			self.InputTxt.Style = "CLASSIC"
		elseif style == TEMPLATE_LIGHT then
			self:SetBackdrop(_FrameBackdropLight)
			self:SetBackdropColor(0,0,0,1)
			self.InputTxt.Style = "LIGHT"
		end

		self.__Style = style
	end

	__Doc__[[
		<desc>Gets the popupdialog's style</desc>
		<return type="System.Widget.PopupDialog.PopupDialogStyle"></return>
	]]
	function GetStyle(self)
		return self.__Style or TEMPLATE_NONE
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the message to be shown]]
	property "Message" {
		Set = function(self, text)
			self:GetChild("AlertText").Text = text or ""
		end,
		Get = function(self)
			return self:GetChild("AlertText").Text
		end,
		Type = LocaleString,
	}

	__Doc__[[the text in the input edit box]]
	property "Text" {
		Set = function(self, text)
			self:GetChild("InputTxt").Text = text or ""
		end,

		Get = function(self)
			return self:GetChild("InputTxt").Text
		end,

		Type = LocaleString,
	}

	__Doc__[[the text that displayed on the okay button]]
	property "OkayButtonText" {
		Set = function(self, text)
			self:GetChild("OkayBtn").Text = text or "Okay"
			local width = self:GetChild("OkayBtn"):GetTextWidth()
			if (width > 110 ) then
				self:GetChild("OkayBtn"):SetWidth(width + 20)
			else
				self:GetChild("OkayBtn"):SetWidth(120);
			end
		end,
		Get = function(self)
			return self:GetChild("OkayBtn").Text
		end,
		Type = LocaleString,
	}

	__Doc__[[the text that displayed on the no button]]
	property "NoButtonText" {
		Set = function(self, text)
			self:GetChild("NoBtn").Text = text or "No"
			local width = self:GetChild("NoBtn"):GetTextWidth()
			if (width > 110 ) then
				self:GetChild("NoBtn"):SetWidth(width + 20)
			else
				self:GetChild("NoBtn"):SetWidth(120);
			end
		end,
		Get = function(self)
			return self:GetChild("NoBtn").Text
		end,
		Type = LocaleString,
	}

	__Doc__[[the text that displayed on the cancel button]]
	property "CancelButtonText" {
		Set = function(self, text)
			self:GetChild("CancelBtn").Text = text or "Cancel"
			local width = self:GetChild("CancelBtn"):GetTextWidth()
			if (width > 110 ) then
				self:GetChild("CancelBtn"):SetWidth(width + 20)
			else
				self:GetChild("CancelBtn"):SetWidth(120);
			end
		end,
		Get = function(self)
			return self:GetChild("CancelBtn").Text
		end,
		Type = LocaleString,
	}

	__Doc__[[whether show the alert icon]]
	property "ShowAlertIcon" {
		Set = function(self, flag)
			self:GetChild("AlertIcon").Visible = (flag and true) or false
		end,

		Get = function(self)
			return self:GetChild("AlertIcon").Visible
		end,

		Type = Boolean,
	}

	__Doc__[[whether show the okay button]]
	property "ShowOkayButton" {
		Set = function(self, flag)
			self:GetChild("OkayBtn").Visible = (flag and true) or false
		end,

		Get = function(self)
			return self:GetChild("OkayBtn").Visible
		end,

		Type = Boolean,
	}

	__Doc__[[whether show the no button]]
	property "ShowNoButton" {
		Set = function(self, flag)
			self:GetChild("NoBtn").Visible = (flag and true) or false
		end,

		Get = function(self)
			return self:GetChild("NoBtn").Visible
		end,

		Type = Boolean,
	}

	__Doc__[[whether show the cancel button]]
	property "ShowCancelButton" {
		Set = function(self, flag)
			self:GetChild("CancelBtn").Visible = (flag and true) or false
		end,

		Get = function(self)
			return self:GetChild("CancelBtn").Visible
		end,

		Type = Boolean,
	}

	__Doc__[[whether show the input edit box]]
	property "ShowInputBox" {
		Set = function(self, flag)
			self:GetChild("InputTxt").Visible = (flag and true) or false
		end,

		Get = function(self)
			return self:GetChild("InputTxt").Visible
		end,

		Type = Boolean,
	}

	__Doc__[[whether show while player is dead]]
	property "ShowWhileDead" {
		Field = "__ShowWhileDead",
		Type = Boolean,
	}

	__Doc__[[whether show while player is in cinematic]]
	property "ShowWhileCinematic" {
		Field = "__ShowWhileCinematic",
		Type = Boolean,
	}

	__Doc__[[the popupdialog's style]]
	property "Style" {
		Set = "SetStyle",
		Get = "GetStyle",
		Type = PopupDialogStyle,
	}

	__Doc__[[the instance of the popupdialog's input object(It's a ComboBox, can be used in special way)]]
	property "Input" {
		Get = function(self)
			return self:GetChild("InputTxt")
		end,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PopupDialog(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Width = 320
		self.Height = 72
		self.MouseEnabled = true
        self.Movable = true
		self.FrameStrata = "FULLSCREEN_DIALOG"
		self.Visible = false
		self.Toplevel = true

		self:SetPoint("CENTER",UIParent,"CENTER",0,0)
		--self:ClearAllPoints()
		self:SetBackdrop(_FrameBackdrop)
		self:SetBackdropColor(0,0,0,1)
		self:SetMinResize(400,200)

		-- Layers
		local text = FontString("AlertText", self, "ARTWORK", "GameFontHighlight")
		text.Width = 290
		text.Height = 0
		text:SetPoint("TOP", self, "TOP", 0, -16)

		local icon = Texture("AlertIcon", self, "ARTWORK")
		icon:SetTexture("Interface\\DialogFrame\\DialogAlertIcon")
		icon.Height = 64
		icon.Width = 64
		icon.Visible = false
		icon:SetPoint("LEFT", self, "LEFT", 12, 0)

		-- Okay Button
		local btnOkay = NormalButton("OkayBtn", self)
		btnOkay.Style = "CLASSIC"
		btnOkay.Height = 20
		btnOkay.Width = 128
		btnOkay.ID = 1
		btnOkay.Text = "Okay"

		-- No Button
		local btnNo = NormalButton("NoBtn", self)
		btnNo.Style = "CLASSIC"
		btnNo.Height = 20
		btnNo.Width = 128
		btnNo.ID = 2
		btnNo.Text = "No"

		-- Cancel Button
		local btnCancel = NormalButton("CancelBtn", self)
		btnCancel.Style = "CLASSIC"
		btnCancel.Height = 20
		btnCancel.Width = 128
		btnCancel.ID = 3
		btnCancel.Text = "Cancel"

		-- SingleTextBox
		local txtInput = ComboBox("InputTxt", self)
		txtInput.Height = 32
		txtInput.Width = 240
		txtInput.Visible = false
		txtInput.HideDropDownButton = true
		txtInput.Editable = true
		txtInput.AutoFocus = true
		txtInput:SetPoint("BOTTOM", self, "BOTTOM", 0, 45)

		self.OnMouseDown = self.OnMouseDown + OnMouseDown
		self.OnMouseUp = self.OnMouseUp + OnMouseUp
		self.OnShow = self.OnShow + OnShow

		btnOkay.OnClick = Okay_OnClick
		btnNo.OnClick = No_OnClick
		btnCancel.OnClick = Cancel_OnClick

		txtInput.OnTextChanged = OnTextChanged
		txtInput.OnEnterPressed = OnEnterPressed
		txtInput.OnEscapePressed = OnEscapePressed
	end
endclass "PopupDialog"
