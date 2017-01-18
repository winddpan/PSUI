-- Author      : Kurapica
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 11

if not IGAS:NewAddon("IGAS.Widget.CheckBox", version) then
	return
end

__Doc__[[CheckBox is a widget type using for boolean selection with a label]]
__AutoProperty__()
class "CheckBox"
	inherit "Button"

    GameTooltip = IGAS.GameTooltip

	_OnGameTooltip = nil

    local function getAnchors(frame)
        local x, y = frame:GetCenter()
        local xFrom, xTo = "", ""
        local yFrom, yTo = "", ""
        if x < GetScreenWidth() / 3 then
            xFrom, xTo = "LEFT", "RIGHT"
        elseif x > GetScreenWidth() / 3 then
            xFrom, xTo = "RIGHT", "LEFT"
        end
        if y < GetScreenHeight() / 3 then
            yFrom, yTo = "BOTTOM", "TOP"
        elseif y > GetScreenWidth() / 3 then
            yFrom, yTo = "TOP", "BOTTOM"
        end
        local from = yFrom..xFrom
        local to = yTo..xTo
        return (from == "" and "CENTER" or from), (to == "" and "CENTER" or to)
    end

	local function UpdateText(self)
		if self:GetChild("ChkBtn").Checked and type(self.TrueText) == "string" then
			self.Text = self.TrueText
		elseif (not self:GetChild("ChkBtn").Checked) and type(self.FalseText) == "string" then
			self.Text = self.FalseText
		end
	end

    local function OnClick(self, ...)
        self:GetChild("ChkBtn").Checked = not self:GetChild("ChkBtn").Checked
		UpdateText(self)

        return self:Fire("OnValueChanged", self:GetChild("ChkBtn").Checked)
    end

    local function OnEnter(self)
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		_OnGameTooltip = nil

		if self.Tooltip then
			_OnGameTooltip = self
			local from, to = getAnchors(self)

			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(from, self, to, 0, 0)
			GameTooltip:SetText(self.Tooltip)
			self:Fire("OnGameTooltipShow", GameTooltip)
			GameTooltip:Show()
		end
        self:GetHighlightTexture():Show()
    end

    local function OnLeave(self)
		_OnGameTooltip = nil
		GameTooltip:ClearLines()
        GameTooltip:Hide()
        self:GetHighlightTexture():Hide()
    end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the checkbox's checking state is changed</desc>
		<param name="checked">boolean, true if the checkbox is checked</param>
	]]
	event "OnValueChanged"

	__Doc__[[
		<desc>Run when the mouse is over an item, and the tooltip is setted</desc>
		<param name="gameTooltip">System.Widget.GameTooltip, the GameTooltip object</param>
	]]
	event "OnGameTooltipShow"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Sets the checkbox's checking state</desc>
		<param name="checked">boolean, true if set the checkbox to be checked</param>
	]]
	function SetChecked(self, flag)
		self:GetChild("ChkBtn").Checked = (flag and true) or false
		UpdateText(self)
	end

	__Doc__[[
		<desc> Gets the checkbox's checking state</desc>
		<return type="boolean">true if set the checkbox to be checked</return>
	]]
	function GetChecked(self)
		return self:GetChild("ChkBtn").Checked or false
	end

	__Doc__[[
		<desc>Sets the checkbox's label</desc>
		<param name="text">string, the text to be displyed</param>
	]]
	function SetText(self, text)
		self:GetChild("Text").Text = text
		self.Width = self:GetChild("Text"):GetStringWidth() + 32
	end

	__Doc__[[
		<desc>Gets the checkbox's label</desc>
		<return type="string">the text to be displyed</return>
	]]
	function GetText(self)
		return self:GetChild("Text").Text
	end

	__Doc__[[Enable the checkbox, make it clickable]]
	function Enable(self)
		self.__UI:Enable()
		self:GetChild("ChkBtn"):Enable()
	end

	__Doc__[[Disable the checkbox, make it un-clickable]]
	function Disable(self)
		self.__UI:Disable()
		self:GetChild("ChkBtn"):Disable()
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[whether the CheckBox is checked]]
	property "Checked" { Type = Boolean }

	__Doc__[[the default text to be displyed]]
	property "Text" { Type = LocaleString }

	__Doc__[[the text to be displyed when checked if set]]
	__Handler__( UpdateText )
	property "TrueText" { Type = LocaleString }

	__Doc__[[the text to be displyed when un-checked if set]]
	__Handler__( UpdateText )
	property "FalseText" { Type = LocaleString }

	__Doc__[[the tooltip to be displyed when mouse over]]
	__Handler__( function(self, tip)
		if _OnGameTooltip == self then
			GameTooltip:ClearLines()
			GameTooltip:Hide()
			_OnGameTooltip = nil

			if tip then
				_OnGameTooltip = self
				local from, to = getAnchors(self)

				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint(from, self, to, 0, 0)
				GameTooltip:SetText(tip)
				self:Fire("OnGameTooltipShow", GameTooltip)
				GameTooltip:Show()
			end
		end
	end )
	property "Tooltip" { Type = LocaleString }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function CheckBox(self, name, parent, ...)
		Super(self, name, parent, ...)

        self.Height = 24
        self.Width = 100
        self.MouseEnabled = true

        local chkBtn = CheckButton("ChkBtn", self)
        chkBtn:SetPoint("LEFT", self, "LEFT")
        chkBtn.MouseEnabled = false

		chkBtn.Height = 26
		chkBtn.Width = 26

		chkBtn:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
		chkBtn:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
		chkBtn:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
		chkBtn:SetDisabledCheckedTexture([[Interface\Buttons\UI-CheckBox-Check-Disabled]])

        local text = FontString("Text",self,"OVERLAY","GameFontNormal")
        text.JustifyH = "LEFT"
		text.JustifyV = "MIDDLE"
        text:SetPoint("TOP", self, "TOP")
        text:SetPoint("LEFT", chkBtn, "RIGHT")
        text:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
        text.Text = ""

        self:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
        local t = self:GetHighlightTexture()
        t:SetBlendMode("ADD")
        t:SetAllPoints(text)

        self.OnEnter = self.OnEnter + OnEnter
        self.OnLeave = self.OnLeave + OnLeave
        self.OnClick = self.OnClick + OnClick
	end
endclass "CheckBox"
