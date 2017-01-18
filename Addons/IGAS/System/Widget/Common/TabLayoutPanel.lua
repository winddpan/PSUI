-- Author      : Kurapica
-- Create Date : 5/29/2012
-- ChangeLog

local version = 2
if not IGAS:NewAddon("IGAS.Widget.TabLayoutPanel", version) then
	return
end

__Doc__[[TabLayoutPanel is used to contain tabpages]]
__AutoProperty__()
class "TabLayoutPanel"
	inherit "LayoutPanel"

	_HeaderSize = 24
	_Header_MinWidth = 100

	_Selected = "SELECTED"
	_Disabled = "DISABLED"
	_Normal = "Normal"

	local function UpdateHeader(self)
		local widget, fontString
		local btn, left, middle, right

		local container = self.TabLayoutPanel_Header.Container
		local headerArray = self.__TabLayoutPanel_HeaderArray
		local totalWidth = 0
		local offsetWidth = 0

		for i = 1, self.Count do
			widget = self:GetWidget(i)

			if not headerArray[i] then
				-- Create Header button
				btn = Button("Header_"..i, container)

				btn._Display = _Normal

				btn:RegisterForClicks("AnyDown")
				btn.Width = _Header_MinWidth
				btn.Height = _HeaderSize

				-- FontString
				fontString = FontString("Label", btn)
				fontString.FontObject = "GameFontNormalSmall"
				fontString:SetPoint("LEFT", btn, "LEFT", 5, -4)
				fontString:SetPoint("RIGHT", btn, "RIGHT", -5, -4)
				btn.FontString = fontString

				btn.Text = "NewTab"

				-- HighlightTexture
				btn.HighlightTexturePath = [[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]]
				btn.HighlightTexture:SetBlendMode("ADD")
				btn.HighlightTexture:ClearAllPoints()
				btn.HighlightTexture:SetPoint("TOPLEFT", btn, "TOPLEFT", 2, -7)
				btn.HighlightTexture:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2, -3)

				-- Texture
				left = Texture("Left", btn, "BACKGROUND")
				middle = Texture("Middle", btn, "BACKGROUND")
				right = Texture("Right", btn, "BACKGROUND")

				left.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]]
				left.Width = 20
				left.Height = _HeaderSize
				left:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT")
				left:SetTexCoord(0, 0.15625, 0, 1.0)

				right.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]]
				right.Width = 20
				right.Height = _HeaderSize
				right:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT")
				right:SetTexCoord(0.84375, 1.0, 0, 1.0)

				middle.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]]
				middle.Height = _HeaderSize
				middle:SetPoint("BOTTOMLEFT", left, "BOTTOMRIGHT")
				middle:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")
				middle:SetTexCoord(0.15625, 0.84375, 0, 1.0)

				headerArray:Insert(btn)

				if headerArray.Count == 1 then
					btn:SetPoint("BOTTOMLEFT")
				else
					btn:SetPoint("BOTTOMLEFT", headerArray[i-1], "BOTTOMRIGHT")
				end
			end

			-- Update Display
			btn = headerArray[i]

			left = btn.Left
			middle = btn.Middle
			right = btn.Right

			-- Update Texture
			if widget.__TabLayoutPanel_Selected then
				widget.Visible = true

				if btn._Display ~= _Selected then
					btn._Display = _Selected

					-- Select this button
					btn.FontString:SetTextColor(1,1,1)
					btn.HighlightTexture.Visible = false

					left.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-ActiveTab]]
					left:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0, -3)
					left:SetTexCoord(0, 0.15625, 0, 1.0)

					right.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-ActiveTab]]
					right:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 0, -3)
					right:SetTexCoord(0.84375, 1.0, 0, 1.0)

					middle.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-ActiveTab]]
					middle:SetTexCoord(0.15625, 0.84375, 0, 1.0)
				end
			else
				widget.Visible = false

				if btn._Display == _Selected then
					left.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]]
					left:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT")
					left:SetTexCoord(0, 0.15625, 0, 1.0)

					right.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]]
					right:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT")
					right:SetTexCoord(0.84375, 1.0, 0, 1.0)

					middle.TexturePath = [[Interface\OptionsFrame\UI-OptionsFrame-InActiveTab]]
					middle:SetTexCoord(0.15625, 0.84375, 0, 1.0)
				end

				if widget.__TabLayoutPanel_Disabled then
					if btn._Display ~= _Disabled then
						btn._Display = _Disabled

						btn.FontString:SetTextColor(0.5,0.5,0.5)
						btn.HighlightTexture.Visible = false
					end
				else
					if btn._Display ~= _Normal then
						btn._Display = _Normal

						btn.FontString:SetTextColor(1,0.82,0)
						btn.HighlightTexture.Visible = true
					end
				end
			end

			-- Update Text
			if btn.Text ~= widget.__TabLayoutPanel_Header then
				btn.Text = widget.__TabLayoutPanel_Header

				if btn.FontString.StringWidth + 20 > _Header_MinWidth then
					btn.Width = btn.FontString.StringWidth + 30
				else
					btn.Width = _Header_MinWidth
				end
			end

			totalWidth = totalWidth + btn.Width

			if i <= container._Offset then
				offsetWidth = offsetWidth + btn.Width
			end
		end

		-- Clear Buttons
		for i = headerArray.Count, self.Count + 1, -1 do
			btn = headerArray[i]

			headerArray:Remove(i)

			btn:Dispose()
		end

		container.Width = totalWidth

		-- Update Header
		if totalWidth > self.TabLayoutPanel_Header.Width then
			self.TabLayoutPanel_Right.Visible = true
			self.TabLayoutPanel_Left.Visible = true

			self.TabLayoutPanel_Left.Enabled = (offsetWidth ~= 0)

			if offsetWidth + self.TabLayoutPanel_Header.Width < totalWidth then
				self.TabLayoutPanel_Right.Enabled = true
			else
				offsetWidth = totalWidth - self.TabLayoutPanel_Header.Width

				self.TabLayoutPanel_Right.Enabled = false

				-- Update offset
				totalWidth = 0

				for i = 1, self.Count do
					totalWidth = totalWidth + headerArray[i].Width

					if totalWidth >= offsetWidth then
						container._Offset = i
						break
					end
				end
			end

			container:SetPoint("TOPLEFT", - offsetWidth, 0)
		else
			container._Offset = 0
			self.TabLayoutPanel_Right.Visible = false
			self.TabLayoutPanel_Left.Visible = false

			container:SetPoint("TOPLEFT")
		end

		-- Update Close button
		self.TabLayoutPanel_Close.Visible = self.TabLayoutPanel_Close._Visible and self.Count > 0
	end

	local function SelectOther(self, widget)
		local otherWidget

		if widget.__TabLayoutPanel_Selected then
			for i = 1, self.Count do
				otherWidget = self:GetWidget(i)

				if otherWidget and (not widget.__TabLayoutPanel_Disabled) and otherWidget ~= widget then
					widget.__TabLayoutPanel_Selected = nil
					otherWidget.__TabLayoutPanel_Selected = true

					self:Fire("OnTabChange", widget, otherWidget)

					return
				end
			end
		end
	end

	local function SelectSelf(self, widget)
		local otherWidget

		if not widget.__TabLayoutPanel_Selected and not widget.__TabLayoutPanel_Disabled then
			for i = 1, self.Count do
				otherWidget = self:GetWidget(i)

				if otherWidget and otherWidget.__TabLayoutPanel_Selected then
					otherWidget.__TabLayoutPanel_Selected = nil
					break
				end

				otherWidget = nil
			end

			widget.__TabLayoutPanel_Selected = true
			self:Fire("OnTabChange", otherWidget, widget)
		end
	end

	------------------------------------------------------
	-- Enum
	------------------------------------------------------

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the an Tab is selected</desc>
		<param name="oldTab">System.Widget.Region, the old tabpage</param>
		<param name="newTab">System.Widget.Region, the new tabpage</param>
	]]
	event "OnTabChange"

	__Doc__[[
		<desc>Run when an tab is closed</desc>
		<param name="closeTab">System.Widget.Region, the closed tabpage</param>
	]]
	event "OnTabClose"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Add element to the panel</desc>
		<param name="element">System.Widget.Region, the ui element to be added</param>
		<param name="header">string, the tabpage's header title</param>
		<return type="number">the tabpage's index</return>
	]]
	function AddWidget(self, widget, header)
		if not Reflector.ObjectIsClass(widget, Region) then
			error("Usage: TabLayoutPanel:AddWidget(widget, header) : widget - must be an object of System.Widget.Region.", 2)
		end

		header = header or widget.Name

		if type(header) ~= "string" then
			error("Usage: TabLayoutPanel:AddWidget(widget, header) : header - must be string.", 2)
		end

		local index = Super.GetWidgetIndex(self, widget) or Super.AddWidget(self, widget)

		if not index then return nil end

		self:SetWidgetTopBottom(widget, _HeaderSize, "px", 0, "px")

		widget.__TabLayoutPanel_Header = header

		if self.Count == 1 and index == 1 and not widget.__TabLayoutPanel_Disabled then
			widget.__TabLayoutPanel_Selected = true
		end

		UpdateHeader(self)

		return index
	end

	__Doc__[[
		<desc>Insert element to the panel</desc>
		<param name="before">number, the index to be insert</param>
		<param name="element">System.Widget.Region, the ui element to be added</param>
		<param name="header">string, the tabpage's header title</param>
		<return type="number">the tabpage's index</return>
	]]
	function InsertWidget(self, before, widget, header)
		before = Super.GetWidgetIndex(self, before)

		if not before then
			error("Usage: TabLayoutPanel:InsertWidget(before, widget, header) : before - not exist.", 2)
		end

		if not Reflector.ObjectIsClass(widget, Region) then
			error("Usage: TabLayoutPanel:InsertWidget(before, widget, header) : widget - must be an object of System.Widget.Region.", 2)
		end

		header = header or widget.Name

		if type(header) ~= "string" then
			error("Usage: TabLayoutPanel:InsertWidget(before, widget, header) : header - must be string.", 2)
		end

		local index = Super.GetWidgetIndex(self, widget) or Super.InsertWidget(self, before, widget)

		if not index then return nil end

		self:SetWidgetTopBottom(widget, _HeaderSize, "px", 0, "px")

		widget.__TabLayoutPanel_Header = header

		if self.Count == 1 and index == 1 and not widget.__TabLayoutPanel_Disabled then
			widget.__TabLayoutPanel_Selected = true
		end

		UpdateHeader(self)

		return index
	end

	__Doc__[[
		<desc>Remove element from the panel</desc>
		<format>index|name[, withoutDispose]</format>
		<param name="index">number, index of the tabpage that need to be removed</param>
		<param name="name">string, the name that need to be removed</param>
		<param name="withoutDispose">boolean, true if no need dispose the removed widget</param>
		<return type="System.Widget.Region">return the ui element if withoutDispose is set to true</return>
	]]
	function RemoveWidget(self, index, withoutDispose)
		local obj = self:GetWidget(index)

		if obj then
			SelectOther(self, obj)

			obj = Super.RemoveWidget(self, index, withoutDispose or self.__NoAutoDisposing)

			UpdateHeader(self)

			if obj then
				obj.__TabLayoutPanel_Selected = nil
				obj.__TabLayoutPanel_Disabled = nil
				obj.__TabLayoutPanel_Header = nil

				return obj
			end
		end
	end

	__Doc__[[
		<desc>Select widget</desc>
		<param name="element">System.Widget.Region, the ui element need to be selected</param>
	]]
	function SelectWidget(self, widget)
		widget = self:GetWidget(widget)

		if widget then
			SelectSelf(self, widget)

			UpdateHeader(self)
		end
	end

	__Doc__[[
		<desc>Disable widget</desc>
		<param name="element">System.Widget.Region, the ui element need to be disabled</param>
	]]
	function DisableWidget(self, widget)
		widget = self:GetWidget(widget)

		if widget then
			SelectOther(self, widget)

			widget.__TabLayoutPanel_Selected = nil
			widget.__TabLayoutPanel_Disabled = true

			UpdateHeader(self)
		end
	end

	__Doc__[[
		<desc>Enable widget</desc>
		<param name="element">System.Widget.Region, the ui element need to be enabled</param>
	]]
	function EnableWidget(self, widget)
		widget = self:GetWidget(widget)

		if widget then
			widget.__TabLayoutPanel_Disabled = nil

			UpdateHeader(self)
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether the tabpages can be closed]]
	property "ShowCloseButton" {
		Get = function(self)
			return self.TabLayoutPanel_Close._Visible
		end,
		Set = function(self, value)
			self.TabLayoutPanel_Close._Visible = value

			UpdateHeader(self)
		end,
		Type = Boolean,
	}

	__Doc__[[The confirm message if need to close the tabpage]]
	property "CloseMessage" {
		Get = function(self)
			return self.TabLayoutPanel_Header.Container._Message
		end,
		Set = function(self, value)
			if value == nil then
				self.TabLayoutPanel_Close:InactiveThread("OnClick")
			else
				self.TabLayoutPanel_Close:ActiveThread("OnClick")
			end
			self.TabLayoutPanel_Header.Container._Message = value
		end,
		Type = String,
	}

	__Doc__[[The selected ui element]]
	property "SelectedWidget" {
		Get = function(self)
			local widget

			for i = 1, self.Count do
				widget = self:GetWidget(i)

				if widget and widget.__TabLayoutPanel_Selected then
					return widget
				end
			end
		end,
		Set = function(self, widget)
			SelectWidget(self, widget)
		end,
		Type = Region,
	}

	__Doc__[[Whether should auto disposing the object if closed]]
	property "AutoDisposing" {
		Get = function(self)
			return not self.__NoAutoDisposing
		end,
		Set = function(self, value)
			self.__NoAutoDisposing = not value
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnClick_Close(self)
		local pass = true
		local widget = self.Parent.SelectedWidget

		if not widget then return end

		if self.Parent.TabLayoutPanel_Header.Container._Message then
			pass = IGAS:MsgBox(self.Parent.TabLayoutPanel_Header.Container._Message, "c")
		end

		if pass then
			self.Parent:Fire("OnTabClose", widget)
			-- Delete
			RemoveWidget(self.Parent, widget)
		end
	end

	local function OnClick_Right(self)
		self.Parent.TabLayoutPanel_Header.Container._Offset = self.Parent.TabLayoutPanel_Header.Container._Offset + 1

		UpdateHeader(self.Parent)
	end

	local function OnClick_Left(self)
		self.Parent.TabLayoutPanel_Header.Container._Offset = self.Parent.TabLayoutPanel_Header.Container._Offset - 1

		UpdateHeader(self.Parent)
	end

	local function OnSizeChanged_Header(self)
		UpdateHeader(self.Parent)
	end

	local function OnClick_HeaderItem(self, index)
		local panel = self[index].Parent.Parent.Parent
		local widget = panel:GetWidget(index)

		if widget and not widget.__TabLayoutPanel_Disabled then
			SelectSelf(panel, widget)

			UpdateHeader(panel)
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function TabLayoutPanel(self, ...)
		Super(self, ...)

		-- Close
		local btnClose = NormalButton("TabLayoutPanel_Close", self)
        btnClose.Style = "CLOSE"
		btnClose.OnClick = OnClick_Close

		btnClose:SetPoint("TOPRIGHT")
		btnClose.Visible = false
		btnClose.Height = _HeaderSize
		btnClose.Width = _HeaderSize

		-- Right
        local btnScrollRight = Button("TabLayoutPanel_Right", self)
        btnScrollRight:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-NextPage-Up.blp")
        btnScrollRight:SetPushedTexture("Interface\\BUTTONS\\UI-SpellbookIcon-NextPage-Down.blp")
        btnScrollRight:SetDisabledTexture("Interface\\BUTTONS\\UI-SpellbookIcon-NextPage-Disabled.blp")
        btnScrollRight:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight.blp", "ADD")
        btnScrollRight.OnClick = OnClick_Right

		btnScrollRight:SetPoint("TOPRIGHT", - _HeaderSize, 0)
		btnScrollRight.Visible = false
		btnScrollRight.Height = _HeaderSize
		btnScrollRight.Width = _HeaderSize

		-- Left
        local btnScrollLeft = Button("TabLayoutPanel_Left", self)
        btnScrollLeft:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-PrevPage-Up.blp")
        btnScrollLeft:SetPushedTexture("Interface\\BUTTONS\\UI-SpellbookIcon-PrevPage-Down.blp")
        btnScrollLeft:SetDisabledTexture("Interface\\BUTTONS\\UI-SpellbookIcon-PrevPage-Disabled.blp")
        btnScrollLeft:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight.blp", "ADD")
		btnScrollLeft.OnClick = OnClick_Left

		btnScrollLeft:SetPoint("TOPRIGHT", -2 * _HeaderSize, 0)
		btnScrollLeft.Visible = false
		btnScrollLeft.Height = _HeaderSize
		btnScrollLeft.Width = _HeaderSize

		-- Header
        local header = ScrollFrame("TabLayoutPanel_Header",self)
		header.MouseEnabled = true
        header.OnSizeChanged = OnSizeChanged_Header

		header:SetPoint("TOPLEFT")
		header:SetPoint("TOPRIGHT", -3 * _HeaderSize, 0)
		header.Visible = true
		header.Height = _HeaderSize

		-- Header Container
        local headerContainer = Frame("Container", header)
        header:SetScrollChild(headerContainer)
		headerContainer:SetPoint("TOPLEFT")
        headerContainer.Height = header.Height
        headerContainer.Width = header.Width
		headerContainer._Offset = 0

		-- HeaderItemArray
		self.__TabLayoutPanel_HeaderArray = System.Array(Button)
		self.__TabLayoutPanel_HeaderArray.OnClick = OnClick_HeaderItem
	end
endclass "TabLayoutPanel"
