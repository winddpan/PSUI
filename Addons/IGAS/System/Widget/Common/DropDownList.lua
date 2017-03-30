-- Author      : Kurapica
-- ChangreLog  :
--				2010.01.13	Change the DropDownList's Parent to WorldFrame
--				2010.10.14  Add Color Choose for DropDownMenuButton
--				2010.12.22	GetMenuButton can use numeric paramters as index, or fix using with string
--				2011.01.04	Now menubutton's dropdownlist can be a Frame or DropDownList
--				2011/03/13	Recode as class
--				2016/06/02  Fix menu not show

-- Check Version
local version = 19

if not IGAS:NewAddon("IGAS.Widget.DropDownList", version) then
	return
end

__Doc__[[
	<desc>DropDownList is used to create pop-up menus.</desc>
	<usage>
		menu = DropDownList("Menu", myForm)      -- Create a pop-up menu
		mnuEdit = menu:AddMenuButton("Edit")     -- Create a menu button to the menu and displayed 'Edit' on it
		mnuHide = mnuEdit:AddMenuButton("Hide")  -- Create a sub pop-up menu for mnuEdit, and add a 'Hide' menu button to the sub pop-up menu

		function mnuHide:OnClick()
			myForm.Visible = false               -- Hide myForm when click the 'Hide' menu button
		end
	</usage>
]]
__AutoProperty__()
class "DropDownList"
	inherit "VirtualUIObject"

	UIParent = IGAS.UIParent

	-- Container & ColorPicker
	_DropDownListContainer = Frame("IGAS_GUI_ListContainer", UIParent)
	_DropDownListContainer.__ShowList = _DropDownListContainer.__ShowList or nil

	_DropDownColorPicker = ColorPicker("DropDownColorPicker", _DropDownListContainer)
	_DropDownColorPicker:ClearAllPoints()
	_DropDownColorPicker:SetPoint("CENTER", UIParent, "CENTER")
	_DropDownColorPicker.Visible = false

	function _DropDownColorPicker:OnColorPicked(red, green, blue, alpha)
		if self._DropDownButton then
			self._DropDownButton.ColorSwatch.NormalTexture:SetVertexColor(red, green, blue, alpha)
			self._DropDownButton:Fire("OnColorPicked", red, green, blue, alpha)
		end
	end

	function _DropDownColorPicker:OnColorPicking(red, green, blue, alpha)
		if self._DropDownButton then
			self._DropDownButton.ColorSwatch.NormalTexture:SetVertexColor(red, green, blue, alpha)
			self._DropDownButton:Fire("OnColorPicking", red, green, blue, alpha)
		end
	end

	function _DropDownColorPicker:OnShow()
		if self._DropDownButton then
			self.Color = self._DropDownButton.Color
		end
	end

	__Doc__[[DropDownMenuButton is used to create menu buttons to the DropDownList]]
	__AutoProperty__()
	class "DropDownMenuButton"
		inherit "Button"

		itemHeight = 16

		-- Events
		--- colorBack
		local function colorsWatch_OnClick(self)
			self.Parent:Fire("OnClick")
			_DropDownColorPicker._DropDownButton = self.Parent
			_DropDownColorPicker.Visible = true
		end

		local function colorsWatch_OnEnter(self)
			self:GetChild("SwatchBg"):SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			self.Parent:Fire("OnEnter")
		end

		local function colorsWatch_OnLeave(self)
			self:GetChild("SwatchBg"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			self.Parent:Fire("OnLeave")
		end

		local function hideDropList(self)
			if self["IsObjectType"] and self:IsObjectType("DropDownList") then
				self = self.__DdList or self
			end
			if self.__Childs and type(self.__Childs) == "table" then
				for _, v in pairs(self.__Childs) do
					if type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) then
						if v.__DropDownList then
							hideDropList(v.__DropDownList)
						end
					end
				end
			end
			self.Visible = false
		end

		local function hideDropDownList(self)
			if self["IsObjectType"] and self:IsObjectType(DropDownMenuButton) and self.__DropDownList then
				hideDropList(self.__DropDownList)
			end
		end

		local function showDropDownList(self)
			local offsetx, offsety, menu

			-- Hide other sub dropdownlist
			if self.Parent.__Childs and type(self.Parent.__Childs) == "table" then
				for _,v in pairs(self.Parent.__Childs) do
					if type(v) == "table" then
						hideDropDownList(v)
					end
				end
			end

			-- Show self's dropdownlist
			menu = self.__DropDownList

			if menu then
				menu.Visible = true

				-- Offset-X
				if self.Parent.__Mask.ShowOnLeft then
					if self.Parent:GetLeft() - menu.Width < 0 then
						offsetx = 0
						menu.ShowOnLeft = false
					else
						offsetx = - (self.Parent.Width + menu.Width)
						menu.ShowOnLeft = true
					end
				else
					if self.Parent:GetRight() + menu.Width > GetScreenWidth() then
						offsetx = - (self.Parent.Width + menu.Width)
						menu.ShowOnLeft = true
					else
						offsetx = 0
						menu.ShowOnLeft = false
					end
				end
				-- Offset-Y
				if self:GetTop() < menu.Height then
					offsety = menu.Height - self:GetTop()
				else
					offsety = 0
				end
				menu:ClearAllPoints()
				menu:SetPoint("TOPLEFT", self, "TOPRIGHT", offsetx, offsety)
			end
		end

		local function toggleDropDownList(self)
			if self.__DropDownList then
				if self.__DropDownList.Visible then
					hideDropDownList(self)
				else
					showDropDownList(self)
				end
			end
		end

		--- expandArrow
		local function expandArrow_OnClick(self)
			toggleDropDownList(self.Parent)
		end

		local function expandArrow_OnEnter(self)
			showDropDownList(self.Parent)
			self.Parent.Parent:Fire("OnEnter")
		end

		local function expandArrow_OnLeave(self)
			self.Parent.Parent:Fire("OnLeave")
		end

		-- Item
		local function item_OnEnter(self)
			showDropDownList(self)
			self:GetChild("HighLight"):Show()
			self.Parent:Fire("OnEnter")
		end

		local function item_OnLeave(self)
			self:GetChild("HighLight"):Hide()
			self.Parent:Fire("OnLeave")
		end

		local function updateWidth(self)
			local maxW = 0

			if self.__Childs and type(self.__Childs) == "table" then
				for i,v in pairs(self.__Childs) do
					if type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) then
						if v:GetChild("Text"):GetStringWidth()> maxW then
							maxW = v:GetChild("Text"):GetStringWidth()
						end
					end
				end

				maxW = maxW + 48

				self.Width = maxW
			end
		end

		-- OnClick Script
		local function OnClick(self, ...)
			-- if this is checkButton
			if self.__IsCheckButton then
				if self.Parent.__MultiSelect then
					self.Checked = not self.Checked
					return true
				else
					if self.Checked then
						-- No need to action
						hideDropList(self.Parent)
						return true
					end
					self.Checked = true
					for i, v in pairs(self.Parent.__Childs) do
						if type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) and v.__IsCheckButton and v ~= self and v.Checked then
							v.Checked = false
						end
					end
					hideDropList(self.Parent)
				end
				return
			elseif self.ColorSwatch.Visible then
				_DropDownColorPicker._DropDownButton = self
				_DropDownColorPicker.Visible = true
			end

			local root = self.Parent

			while root.__MenuBase do
				root = root.__MenuBase
			end

			if root.AutoHide then
				hideDropList(root)
			end
		end

		local function Frame_OnEnter(self)
			if self.__MenuBase then
				return self.__MenuBase:Fire("OnEnter")
			end
		end

		local function Frame_OnLeave(self)
			if self.__MenuBase then
				return self.__MenuBase:Fire("OnLeave")
			end
		end

		------------------------------------------------------
		-- Event
		------------------------------------------------------
		__Doc__[[Run when the button's checking state is changed]]
		event "OnCheckChanged"

		__Doc__[[
			<desc>Run when the color is selected</desc>
			<param name="r">number, [0-1], the red part of the color</param>
			<param name="g">number, [0-1], the green part of the color</param>
			<param name="b">number, [0-1], the blue part of the color</param>
			<param name="a">number, [0-1], the alpha part of the color</param>
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
			<desc>Add or get a dropDownMenuButton with the given name list</desc>
			<param name="name">string, the name of the menu button</param>
			<param name="...">the sub menu item's name list</param>
			<return type="System.Widget.DropDownList.DropDownMenuButton">Reference to the new dropdown menu button</return>
			<usage>btn = object:AddMenuButton("File", "New", "Lua")</usage>
		]]
		function AddMenuButton(self, ...)
			local name, mnuBtn, menu

			mnuBtn = self

			for i = 1, select("#", ...) do
				name = select(i, ...)

				if name and type(name) == "string" and name ~= "" then
					menu = mnuBtn.DropDownList or DropDownList("MenuList", mnuBtn)

					mnuBtn:SetDropDownList(menu)

					if not menu:IsObjectType("DropDownList") then
						error("The object with name ["..name.."] is not a DropDownList.")
					end

					if menu:GetMenuButton(name) then
						mnuBtn = menu:GetMenuButton(name)
					else
						mnuBtn = DropDownMenuButton(name, menu.__DdList)
						mnuBtn.Text = name
					end
				else
					error("The name must be string.", 2)
				end
			end

			return mnuBtn
		end

		__Doc__[[
			<desc>Get a dropDownMenuButton with the given name list</desc>
			<param name="name">string, the name of the menu button</param>
			<param name="...">the sub menu item's name list</param>
			<return type="System.Widget.DropDownList.DropDownMenuButton">Reference to the new dropdown menu button</return>
			<usage>btn = object:GetMenuButton("File", "New", "Lua")</usage>
		]]
		function GetMenuButton(self, ...)
			local name, mnuBtn, menu

			menu = self.DropDownList

			for i = 1, select("#", ...) do
				name = select(i, ...)

				if name and type(name) == "string" and name ~= "" then
					if not menu or not menu:IsObjectType("DropDownList") then
						return nil
					end

					mnuBtn = menu.__DdList:GetChild(name)

					if not mnuBtn then
						return nil
					end

					menu = mnuBtn.DropDownList
				elseif name and type(name) == "number" and name > 0 then
					if not menu or not menu:IsObjectType("DropDownList")  or name > (menu.__DdList.__ItemCount or 0) then
						return nil
					end

					mnuBtn = nil

					 for _, v in pairs(menu.__DdList:GetChilds()) do
						if type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) and v.__Index == name then
							mnuBtn = v
							break
						end
					end

					if not mnuBtn then
						return nil
					end

					menu = mnuBtn.DropDownList
				else
					return nil
				end
			end

			return mnuBtn
		end

		__Doc__[[
			<desc>Remove dropDownMenuButton with the given name list</desc>
			<param name="name">string, the name of the menu button</param>
			<param name="...">the sub menu item's name list</param>
			<usage>object:RemoveMenuButton("File", "New", "Lua")</usage>
		]]
		function RemoveMenuButton(self, ...)
			local mnuBtn = self:GetMenuButton(...)

			return mnuBtn and mnuBtn:Dispose()
		end

		__Doc__[[
			<desc>Sets the button's display text</desc>
			<param name="text">string, tht text to be displayed</param>
			]]
		function SetText(self, text)
			if self.__TextColor and next(self.__TextColor) then
				self:GetChild("Text").Text = string.format("|cFF%02x%02x%02x", floor(self.__TextColor.red * 255), floor(self.__TextColor.green * 255), floor(self.__TextColor.blue * 255))..text.."|r"
			else
				self:GetChild("Text").Text = text
			end
			self.__Text = text
			updateWidth(self.Parent)
		end

		__Doc__[[
			<desc>Gets the button's display text</desc>
			<return type="string"></return>
		]]
		function GetText(self)
			return self.__Text or ""
		end

		__Doc__[[
			<desc>Set the sub menu for the button</desc>
			<format>dropdownList|list</format>
			<param name="dropDownList">System.Widget.DropDownList</param>
			<param name="list">System.Widget.List</param>
			]]
		function SetDropDownList(self, list)
			if list == nil or (type(list) == "table" and list.IsObjectType and list.Show and list.Hide) then
				if self.__DropDownList == list then
					return
				end

				if self.__DropDownList and not self.__DropDownList:IsObjectType("DropDownList") then
					self.__DropDownList.OnEnter = self.__DropDownList.OnEnter - Frame_OnEnter
					self.__DropDownList.OnLeave = self.__DropDownList.OnLeave - Frame_OnLeave
					self.__DropDownList.__MenuBase = nil
				end

				self.__DropDownList = list
				if self.__DropDownList then
					self:GetChild("ExpandArrow"):Show()
					if list:IsObjectType("DropDownList") then
						list.__DdList.__MenuLevel = self.Parent.__MenuLevel + 1
						list.__DdList.__MenuBase = self.Parent
					else
						list.__MenuBase = self.Parent
						list.OnEnter = list.OnEnter + Frame_OnEnter
						list.OnLeave = list.OnLeave + Frame_OnLeave
					end
				else
					self:GetChild("ExpandArrow"):Hide()
				end
			else
				error("The parameter must be a DropDownList or Frame.")
			end
		end

		__Doc__[[
			<desc>Get the sub menu for the button</desc>
			<return type="dropDownList|list"></return>
		]]
		function GetDropDownList(self)
			return self.__DropDownList
		end

		__Doc__[[
			<desc>Set the icon to be displayed on the button</desc>
			<param name="icon">string, the texture path to be displayed</param>
			]]
		function SetIcon(self, texture)
			self:GetChild("Icon").Visible = (texture and true) or false
			self:GetChild("Icon").TexturePath = texture
		end

		__Doc__[[
			<desc>Get the icon to be displayed on the button</desc>
			<return type="string">the texture's path</return>
		]]
		function GetIcon(self)
			return self:GetChild("Icon").TexturePath
		end

		__Doc__[[
			<desc>Set the text color for the button</desc>
			<param name="red">number, red component of the color (0.0 - 1.0)</param>
			<param name="green">number, green component of the color (0.0 - 1.0)</param>
			<param name="blue">number, blue component of the color (0.0 - 1.0)</param>
		]]
		function SetTextColor(self, r, g, b)
			if r and type(r) == "number" and r >= 0 and r <= 1
				and g and type(g) == "number" and g >=0 and g <= 1
				and b and type(b) == "number" and b >=0 and b <= 1 then

				self.__TextColor = {
					red = r,
					green = g,
					blue = b,
				}

				if self.__Text then
					self:GetChild("Text").Text = string.format("|cFF%02x%02x%02x", floor(r * 255), floor(g * 255), floor(b * 255))..self.__Text.."|r"

				end
			else
				self.__TextColor = nil
				self:GetChild("Text").Text = self.__Text
			end
		end

		__Doc__[[
			<desc>Get the text color for the button</desc>
			<return type="red">number, red component of the color (0.0 - 1.0)</return>
			<return type="green">number, green component of the color (0.0 - 1.0)</return>
			<return type="blue">number, blue component of the color (0.0 - 1.0)</return>
		]]
		function GetTextColor(self)
			if self.__TextColor then
				return self.__TextColor.red, self.__TextColor.green, self.__TextColor.blue
			end
		end

		__Doc__[[
			<desc>Set the menu button's index</desc>
			<param name="index">number</param>
		]]
		function SetIndex(self, index)
			if type(index) ~= "number" or index <= 0 then
				error("The Index must be more than 0.", 2)
			end

			if index > self.Parent.__ItemCount then
				index = self.Parent.__ItemCount
			end

			if self.__Index == index then
				return
			end

			if index > self.__Index then
				for i,v in pairs(self.Parent:GetChilds()) do
					if v ~= self and type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) then
						if v.__Index > self.__Index and v.__Index <= index then
							v.__Index = v.__Index - 1
							v:SetPoint("TOP", self.Parent, "TOP", 0, -(16 + itemHeight * (v.__Index - 1)))
						end
					end
				end
			else
				for i,v in pairs(self.Parent:GetChilds()) do
					if v ~= self and type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) then
						if v.__Index < self.__Index and v.__Index >= index then
							v.__Index = v.__Index + 1
							v:SetPoint("TOP", self.Parent, "TOP", 0, -(16 + itemHeight * (v.__Index - 1)))
						end
					end
				end
			end

			self.__Index = index

			self:SetPoint("TOP", self.Parent, "TOP", 0, -(16 + itemHeight * (index - 1)))
		end

		__Doc__[[
			<desc>Return the menu button's index</desc>
			<return type="number"></return>
		]]
		function GetIndex(self)
			return self.__Index
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[the index of the dropDownMenuButton]]
		property "Index" { Type = Number }

		__Doc__[[the text color of the dropDownMenuButton]]
		property "TextColor" {
			Set = function(self, color)
				self:SetTextColor(color.red, color.green, color.blue)
			end,

			Get = function(self)
				return self.__TextColor or {}
			end,

			Type = ColorType,
		}

		__Doc__[[the icon to be displayed on the dropDownMenuButton]]
		property "Icon" { Type = String + Number }

		__Doc__[[the sub pop-up menu for the dropDownMenuButton]]
		property "DropDownList" {  }

		__Doc__[[the displayed text]]
		property "Text" { Type = LocaleString }

		__Doc__[[whether the dropDownMenuButton is a checkButton]]
		property "IsCheckButton" {
			Field = "__IsCheckButton",
			Set = function(self, flag)
				self.__IsCheckButton = (flag and true) or false
				if not flag then
					self:GetChild("Check").Visible = false
				end
			end,
			Type = Boolean,
		}

		__Doc__[[whether the dropDownMenuButton is checked]]
		property "Checked" {
			Set = function(self, flag)
				self:GetChild("Check").Visible = flag
				self:Fire("OnCheckChanged")
			end,

			Get = function(self)
				return self:GetChild("Check").Visible
			end,

			Type = Boolean,
		}

		__Doc__[[whether the dropDownMenuButton is used as a colorpicker]]
		property "IsColorPicker" {
			Set = function(self, flag)
				self.ColorSwatch.Visible = flag
			end,

			Get = function(self)
				return self.ColorSwatch.Visible
			end,

			Type = Boolean,
		}

		__Doc__[[the color used to for the ColorPicker]]
		property "Color" {
			Get = function(self)
				return self.ColorSwatch.NormalTexture.VertexColor
			end,
			Set = function(self, color)
				self.ColorSwatch.NormalTexture.VertexColor = color
			end,
			Type = ColorType,
		}

		------------------------------------------------------
		-- Dispose
		------------------------------------------------------
		function Dispose(self)
			for i,v in pairs(self.Parent:GetChilds()) do
				if v ~= self and type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) then
					if v.__Index > self.__Index then
						v.__Index = v.__Index - 1
						v:SetPoint("TOP", self.Parent, "TOP", 0, -(16 + itemHeight * (v.__Index - 1)))
					end
				end
			end

			self.Parent.__ItemCount = self.Parent.__ItemCount - 1
			self.Parent.Height = self.Parent.Height - itemHeight
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function DropDownMenuButton(self, name, parent, ...)
			Super(self, name, parent, ...)

			parent = parent.__DdList or parent

			local maxID = parent.__ItemCount or 0

			self.Width = 100
			self.Height = itemHeight

			maxID = maxID + 1
			self.__Index = maxID
			parent.__ItemCount = maxID

			-- Anchor
			self:SetPoint("LEFT", parent, "LEFT", 4, 0)
			self:SetPoint("RIGHT", parent, "RIGHT", -4, 0)
			self:SetPoint("TOP", parent, "TOP", 0, - (16 + itemHeight * (maxID - 1)))
			parent.Height = 32 + itemHeight * maxID

			-- HighLightTexture
			local highLight = Texture("HighLight", self, "BACKGROUND")
			highLight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
			highLight:SetBlendMode("ADD")
			highLight:SetAllPoints(self)
			highLight.Visible = false

			-- CheckTexture
			local check = Texture("Check", self, "ARTWORK")
			check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
			check.Height = 18
			check.Width = 18
			check.Visible = false
			check:SetPoint("LEFT", self, "LEFT")

			-- IconTexture
			local icon = Texture("Icon", self, "ARTWORK")
			icon.Height = 16
			icon.Width = 16
			icon.Visible = false
			icon:SetPoint("LEFT", self, "LEFT")

			-- ColorSwatch
			local colorsWatch = Button("ColorSwatch", self)
			colorsWatch.Height = 16
			colorsWatch.Width = 16
			colorsWatch.Visible = false
			colorsWatch:SetPoint("RIGHT", self, "RIGHT", -6, 0)
			colorsWatch:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")

			local colorBack = Texture("SwatchBg", colorsWatch, "BACKGROUND")
			colorBack.Height = 14
			colorBack.Width = 14
			colorBack.DrawLayer = "BACKGROUND"
			colorBack:SetPoint("CENTER", colorsWatch, "CENTER")
			colorBack:SetVertexColor(1.0, 1.0, 1.0)

			colorsWatch.OnClick = colorsWatch_OnClick
			colorsWatch.OnEnter = colorsWatch_OnEnter
			colorsWatch.OnLeave = colorsWatch_OnLeave

			-- ExpandArrow
			local expandArrow = Button("ExpandArrow", self)
			expandArrow.Height = 16
			expandArrow.Width = 16
			expandArrow.Visible = false
			expandArrow:SetPoint("RIGHT", self, "RIGHT", 0, 0)
			expandArrow:SetNormalTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")

			expandArrow.OnClick = expandArrow_OnClick
			expandArrow.OnEnter = expandArrow_OnEnter
			expandArrow.OnLeave = expandArrow_OnLeave

			-- FontString
			local text = FontString("Text",self,"OVERLAY","GameFontNormal")
			text.JustifyH = "LEFT"
			text:SetPoint("LEFT", self, "LEFT", 18, 0)
			text:SetHeight(16)
			self:SetFontString(text)

			-- Event
			self.OnEnter = self.OnEnter + item_OnEnter
			self.OnLeave = self.OnLeave + item_OnLeave
			self.OnClick = self.OnClick + OnClick

			--- Font
			self:SetNormalFontObject(GameFontHighlightSmallLeft)
			self:SetDisabledFontObject(GameFontDisableSmallLeft)
			self:SetHighlightFontObject(GameFontHighlightSmallLeft)
		end
	endclass "DropDownMenuButton"

	------------------------------------------------------
	--------------------- DropDownList ----------------------
	------------------------------------------------------

	_FrameBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 9,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	}

	local function hideDropList(self)
		if self["IsObjectType"] and self:IsObjectType("DropDownList") then
			self = self.__DdList or self
		end
		if self.__Childs and type(self.__Childs) == "table" then
			for i,v in pairs(self.__Childs) do
				if type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) then
					if v.__DropDownList then
						hideDropList(v.__DropDownList)
					end
				end
			end
		end
		self.Visible = false
	end

	local function OnTimer(self)
		hideDropList(self.Parent)
		self.Interval = 0
	end

	local function OnEnter(self)
		self:GetChild("DropDownList_Timer").Interval = 0

		if self.__MenuBase then
			self.__MenuBase:Fire("OnEnter")
		end

		return self.__Mask:Fire("OnEnter")
	end

	local function OnLeave(self)
		if self.Visible and not self.__DisableAutoHide then
			self:GetChild("DropDownList_Timer").Interval = 2
		end
		if self.__MenuBase then
			self.__MenuBase:Fire("OnLeave")
		end

		return self.__Mask:Fire("OnLeave")
	end

	local function OnShow(self, ...)
		if not self.__DisableAutoHide then
			self:GetChild("DropDownList_Timer").Interval = 2
		end

		-- Set the dropdownframe scale
		local uiScale
		local uiParentScale = UIParent:GetScale()
		if (GetCVar("useUIScale") == "1" ) then
			uiScale = tonumber(GetCVar("uiscale"))
			if (uiParentScale < uiScale ) then
				uiScale = uiParentScale
			end
		else
			uiScale = uiParentScale
		end

		self:SetScale(1)

		if self.__MenuLevel > 1 then
			return self.__Mask:Fire("OnShow")
		end

		-- Hide the previous
		if not self.__DisableAutoHide then
			if _DropDownListContainer.__ShowList and _DropDownListContainer.__ShowList ~= self then
				_DropDownListContainer.__ShowList.Visible = false
			end

			_DropDownListContainer.__ShowList = self
		end

		if self.__ShowOnCursor then
			local cursorX, cursorY = GetCursorPosition()
			cursorX = cursorX/self:GetEffectiveScale()
			cursorY =  cursorY/self:GetEffectiveScale()

			local offsetX, offsetY

			offsetX = cursorX
			offsetY = cursorY

			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", offsetX, offsetY)

			local x, y = self:GetCenter()

			if not (x and y) then
				self:Hide()
				return
			end

			-- Determine whether the menu is off the screen or not
			local offscreenY, offscreenX;
			if ((y - self:GetHeight()/2) < 0 ) then
				offscreenY = 1
			end
			if (self:GetRight() > GetScreenWidth() ) then
				offscreenX = 1
			end

			self:ClearAllPoints()
			if offscreenX and offscreenY then
				self:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", offsetX, offsetY)
			elseif offscreenX then
				self:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", offsetX, offsetY)
			elseif offscreenY then
				self:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", offsetX, offsetY)
			else
				self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", offsetX, offsetY)
			end
		end

		return self.__Mask:Fire("OnShow")
	end

	local function OnHide(self, ...)
		self:GetChild("DropDownList_Timer").Interval = 0

		hideDropList(self)

		if self.__MenuLevel > 1 then
			return self.__Mask:Fire("OnHide")
		end

		if _DropDownListContainer.__ShowList and _DropDownListContainer.__ShowList == self then
			_DropDownListContainer.__ShowList = nil
		end

		return self.__Mask:Fire("OnHide")
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Run when the Region becomes visible]]
	event "OnShow"

	__Doc__[[Run when the Region's visbility changes to hidden]]
	event "OnHide"

	__Doc__[[
		<desc>Run when the mouse cursor enters the frame's interactive area</desc>
		<param name="motion">boolean, true if the handler is being run due to actual mouse movement; false if the cursor entered the frame due to other circumstances (such as the frame being created underneath the cursor)</param>
	]]
	event "OnEnter"

	__Doc__[[
		<desc>Run when the mouse cursor leaves the frame's interactive area</desc>
		<param name="motion">boolean, true if the handler is being run due to actual mouse movement; false if the cursor left the frame due to other circumstances (such as the frame being created underneath the cursor)</param>
	]]
	event "OnLeave"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Add or get a dropDownMenuButton with the given name list</desc>
		<param name="name">string, the name of the menu button</param>
		<param name="...">the sub menu item's name list</param>
		<return type="System.Widget.DropDownList.DropDownMenuButton">Reference to the new dropdown menu button</return>
		<usage>btn = object:AddMenuButton("File", "New", "Lua")</usage>
	]]
	function AddMenuButton(self, ...)
		local name, mnuBtn, menu

		for i = 1, select("#", ...) do
			name = select(i, ...)

			if name and type(name) == "string" and name ~= "" then
				menu = (mnuBtn and (mnuBtn.DropDownList or DropDownList("MenuList", mnuBtn))) or self

				if not menu:IsObjectType("DropDownList") then
					error("The object with name ["..name.."] is not a DropDownList.")
				end

				if mnuBtn then
					mnuBtn:SetDropDownList(menu)
				end

				if menu:GetMenuButton(name) then
					mnuBtn = menu:GetMenuButton(name)
				else
					mnuBtn = DropDownMenuButton(name, menu.__DdList)
					mnuBtn.Text = name
				end
			else
				error("The name must be string.", 2)
			end
		end

		return mnuBtn
	end

	__Doc__[[
		<desc>Get a dropDownMenuButton with the given name list</desc>
		<param name="name">string, the name of the menu button</param>
		<param name="...">the sub menu item's name list</param>
		<return type="System.Widget.DropDownList.DropDownMenuButton">Reference to the new dropdown menu button</return>
		<usage>btn = object:GetMenuButton("File", "New", "Lua")</usage>
	]]
	function GetMenuButton(self, ...)
		local name, mnuBtn, menu

		menu = self

		for i = 1, select("#", ...) do
			name = select(i, ...)

			if name and type(name) == "string" and name ~= "" then
				if not menu or not menu:IsObjectType("DropDownList") then
					return nil
				end

				mnuBtn = menu.__DdList:GetChild(name)

				if not mnuBtn then
					return nil
				end

				menu = mnuBtn.DropDownList
			elseif name and type(name) == "number" and name > 0 then
				if not menu or not menu:IsObjectType("DropDownList") or name > (menu.__DdList.__ItemCount or 0) then
					return nil
				end

				mnuBtn = nil

				 for _, v in pairs(menu.__DdList:GetChilds()) do
					if type(v) == "table" and v["IsObjectType"] and v:IsObjectType(DropDownMenuButton) and v.__Index == name then
						mnuBtn = v
						break
					end
				end

				if not mnuBtn then
					return nil
				end

				menu = mnuBtn.DropDownList
			else
				return nil
			end
		end

		return mnuBtn
	end

	__Doc__[[
		<desc>Remove dropDownMenuButton with the given name list</desc>
		<param name="name">string, the name of the menu button</param>
		<param name="...">the sub menu item's name list</param>
		<usage>object:RemoveMenuButton("File", "New", "Lua")</usage>
	]]
	function RemoveMenuButton(self, ...)
		local mnuBtn = self:GetMenuButton(...)

		return mnuBtn and mnuBtn:Dispose()
	end

	__Doc__[[
		<desc>Returns the opacity of the region relative to its parent</desc>
		<return type="number">Alpha (opacity) of the region (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetAlpha(self)
		return self.__DdList:GetAlpha() or 1
	end

	__Doc__[[
		<desc>Sets the opacity of the region relative to its parent</desc>
		<param name="alpha">number, alpha (opacity) of the region (0.0 = fully transparent, 1.0 = fully opaque)</param>
		]]
	function SetAlpha(self, alpha)
		self.__DdList:SetAlpha(alpha)
	end

	__Doc__[[Removes all anchor points from the region]]
	function ClearAllPoints(self)
		self.__DdList:ClearAllPoints()
	end

	__Doc__[[
		<desc>Returns the distance from the bottom of the screen to the bottom of the region</desc>
		<return type="number">Distance from the bottom edge of the screen to the bottom edge of the region (in pixels)</return>
	]]
	function GetBottom(self)
		return self.__DdList:GetBottom()
	end

	__Doc__[[
		<desc>Returns the screen coordinates of the region's center</desc>
		<return type="x">number, distance from the left edge of the screen to the center of the region (in pixels)</return>
		<return type="y">number, distance from the bottom edge of the screen to the center of the region (in pixels)</return>
	]]
	function GetCenter(self)
		return self.__DdList:GetCenter()
	end

	__Doc__[[
		<desc>Returns the height of the region</desc>
		<return type="number">Height of the region (in pixels)</return>
	]]
	function GetHeight(self)
		return self.__DdList:GetHeight()
	end

	__Doc__[[
		<desc>Returns the distance from the left edge of the screen to the left edge of the region</desc>
		<return type="number">Distance from the left edge of the screen to the left edge of the region (in pixels)</return>
	]]
	function GetLeft(self)
		return self.__DdList:GetLeft()
	end

	__Doc__[[
		<desc>Returns the number of anchor points defined for the region</desc>
		<return type="number">Number of defined anchor points for the region</return>
	]]
	function GetNumPoints(self)
		return self.__DdList:GetNumPoints()
	end

	__Doc__[[
		<desc>Returns information about one of the region's anchor points</desc>
		<param name="index">number, index of an anchor point defined for the region (between 1 and region:GetNumPoints())</param>
		<return type="point">System.Widget.FramePoint, point on this region at which it is anchored to another</return>
		<return type="relativeTo">System.Widget.Region, reference to the other region to which this region is anchored</return>
		<return type="relativePoint">System.Widget.FramePoint, point on the other region to which this region is anchored</return>
		<return type="xOffset">number, horizontal distance between point and relativePoint (in pixels; positive values put point to the right of relativePoint)</return>
		<return type="yOffset">number, vertical distance between point and relativePoint (in pixels; positive values put point below relativePoint)</return>
	]]
	function GetPoint(self, pointNum)
		return self.__DdList:GetPoint(pointNum)
	end

	__Doc__[[
		<desc>Returns the distance from the left edge of the screen to the right edge of the region</desc>
		<return type="number">Distance from the left edge of the screen to the right edge of the region (in pixels)</return>
	]]
	function GetRight(self)
		return self.__DdList:GetRight()
	end

	__Doc__[[
		<desc>Returns the distance from the bottom of the screen to the top of the region</desc>
		<return type="number">Distance from the bottom edge of the screen to the top edge of the region (in pixels)</return>
	]]
	function GetTop(self)
		return self.__DdList:GetTop()
	end

	__Doc__[[
		<desc>Returns the width of the region</desc>
		<return type="number">Width of the region (in pixels)</return>
	]]
	function GetWidth(self)
		return self.__DdList:GetWidth()
	end

	__Doc__[[Hide the region]]
	function Hide(self)
		return self.__DdList:Hide()
	end

	__Doc__[[Show the region]]
	function Show(self)
		self.__DdList:Show()
	end

	__Doc__[[
		<desc>Returns whether the region is shown. Indicates only whether the region has been explicitly shown or hidden -- a region may be explicitly shown but not appear on screen because its parent region is hidden. See VisibleRegion:IsVisible() to test for actual visibility.</desc>
		<return type="boolean">1 if the region is shown; otherwise nil</return>
	]]
	function IsShown(self)
		return self.__DdList:IsShown()
	end

	__Doc__[[
		<desc>Returns whether the region is visible. A region is "visible" if it has been explicitly shown (or not explicitly hidden) and its parent is visible (that is, all of its ancestor frames (parent, parent's parent, etc) are also shown)</desc>
		<return type="boolean">1 if the region is visible; otherwise nil</return>
	]]
	function IsVisible(self)
		return self.__DdList:IsVisible()
	end

	__Doc__[[
		<desc>Sets all anchor points of the region to match those of another region. If no region is specified, the region's anchor points are set to those of its parent.</desc>
		<format>[name|region]</format>
		<param name="name">global name of a System.Widget.Region</param>
		<param name="region">System.Widget.Region</param>
		]]
	function SetAllPoints(self, frame)
		if frame and type(frame) == "string" then
			frame = _G[frame]
		end

		if not frame or type(frame) ~= "table" then
			frame = self.Parent
		end

		self.__DdList:SetAllPoints(frame)
	end

	__Doc__[[
		<desc>Sets an anchor point for the region</desc>
		<param name="point">System.Widget.FramePoint, point on this region at which it is to be anchored to another</param>
		<param name="relativeTo">System.Widget.Region, reference to the other region to which this region is to be anchored; if nil or omitted, anchors the region relative to its parent (or to the screen dimensions if the region has no parent)</param>
		<param name="relativePoint">System.Widget.FramePoint, point on the other region to which this region is to be anchored; if nil or omitted, defaults to the same value as point</param>
		<param name="xOffset">number, horizontal distance between point and relativePoint (in pixels; positive values put point to the right of relativePoint); if nil or omitted, defaults to 0</param>
		<param name="yOffset">number, vertical distance between point and relativePoint (in pixels; positive values put point below relativePoint); if nil or omitted, defaults to 0</param>
	]]
	function SetPoint(self, point, relativeObject, relativePoint, xOfs, yOfs)
		self.__DdList:SetPoint(point, relativeObject, relativePoint, xOfs, yOfs)
	end

	__Doc__[[
		<desc>Returns the position and dimensions of the region</desc>
		<return type="left">number, Distance from the left edge of the screen to the left edge of the region (in pixels)</return>
		<return type="bottom">number, Distance from the bottom edge of the screen to the bottom of the region (in pixels)</return>
		<return type="width">number, Width of the region (in pixels)</return>
		<return type="height">number, Height of the region (in pixels)</return>
	]]
	function GetRect(self)
		return self.__DdList:GetRect()
	end

	__Doc__[[
		<desc>Returns whether the region is currently being dragged</desc>
		<return type="boolean">1 if the region (or its parent or ancestor) is currently being dragged; otherwise nil</return>
	]]
	function IsDragging(self)
		return self.__DdList:IsDragging()
	end

	__Doc__[[
		<desc>Prevents display of all child objects of the frame on a specified graphics layer</desc>
		<param name="layer">System.Widget.DrawLayer, name of a graphics layer</param>
	]]
	function DisableDrawLayer(self, ...)
		return self.__DdList:DisableDrawLayer(...)
	end

	__Doc__[[
		<desc>Allows display of all child objects of the frame on a specified graphics layer</desc>
		<param name="layer">System.Widget.DrawLayer, name of a graphics layer</param>
	]]
	function EnableDrawLayer(self, ...)
		return self.__DdList:EnableDrawLayer(...)
	end

	__Doc__[[
		<desc>Returns information about the frame's backdrop graphic.</desc>
		<return type="System.Widget.BackdropType">A table containing the backdrop settings, or nil if the frame has no backdrop</return>
	]]
	function GetBackdrop(self, ...)
		return self.__DdList:GetBackdrop(...)
	end

	__Doc__[[
		<desc>Sets a backdrop graphic for the frame. See example for details of the backdrop table format.</desc>
		<param name="backdrop">System.Widget.BackdropType A table containing the backdrop settings, or nil to remove the frame's backdrop</param>
	]]
	function SetBackdrop(self, backdropTable)
		return self.__DdList:SetBackdrop(backdropTable or nil)
	end

	__Doc__[[
		<desc>Returns the shading color for the frame's border graphic</desc>
		<return type="red">number, red component of the color (0.0 - 1.0)</return>
		<return type="green">number, green component of the color (0.0 - 1.0)</return>
		<return type="blue">number, blue component of the color (0.0 - 1.0)</return>
		<return type="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetBackdropBorderColor(self, ...)
		return self.__DdList:GetBackdropBorderColor(...)
	end

	__Doc__[[
		<desc>Sets a shading color for the frame's border graphic. As with Texture:SetVertexColor(), this color is a shading applied to the colors of the texture image; a color of (1, 1, 1) allows the image's original colors to show.</desc>
		<param name="red">number, red component of the color (0.0 - 1.0)</param>
		<param name="green">number, green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the color (0.0 - 1.0)</param>
		<param name="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetBackdropBorderColor(self, ...)
		return self.__DdList:SetBackdropBorderColor(...)
	end

	__Doc__[[
		<desc>Returns the shading color for the frame's background graphic</desc>
		<return type="red">number, red component of the color (0.0 - 1.0)</return>
		<return type="green">number, green component of the color (0.0 - 1.0)</return>
		<return type="blue">number, blue component of the color (0.0 - 1.0)</return>
		<return type="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetBackdropColor(self, ...)
		return self.__DdList:GetBackdropColor(...)
	end

	__Doc__[[
		<desc>Sets a shading color for the frame's background graphic. As with Texture:SetVertexColor(), this color is a shading applied to the colors of the texture image; a color of (1, 1, 1) allows the image's original colors to show.</desc>
		<param name="red">number, red component of the color (0.0 - 1.0)</param>
		<param name="green">number, green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the color (0.0 - 1.0)</param>
		<param name="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetBackdropColor(self, ...)
		return self.__DdList:SetBackdropColor(...)
	end

	__Doc__[[
		<desc>Returns offsets from the frame's edges used when limiting user movement or resizing of the frame. Note: despite the name of this method, the values are all offsets along the normal axes, so to inset the frame's clamping area from its edges, the left and bottom measurements should be positive and the right and top measurements should be negative.</desc>
		<return type="left">number, offset from the left edge of the frame to the left edge of its clamping area (in pixels)</return>
		<return type="right">number, offset from the right edge of the frame's clamping area to the right edge of the frame (in pixels)</return>
		<return type="top">number, offset from the top edge of the frame's clamping area to the top edge of the frame (in pixels)</return>
		<return type="bottom">number, offset from the bottom edge of the frame to the bottom edge of its clamping area (in pixels)</return>
	]]
	function GetClampRectInsets(self, ...)
		return self.__DdList:GetClampRectInsets(...)
	end

	__Doc__[[
		<desc>Sets offsets from the frame's edges used when limiting user movement or resizing of the frame. Note: despite the name of this method, the parameters are offsets along the normal axes -- to inset the frame's clamping area from its edges, the left and bottom measurements should be positive and the right and top measurements should be negative.</desc>
		<param name="left">number, offset from the left edge of the frame to the left edge of its clamping area (in pixels)</param>
		<param name="right">number, offset from the right edge of the frame's clamping area to the right edge of the frame (in pixels)</param>
		<param name="top">number, offset from the top edge of the frame's clamping area to the top edge of the frame (in pixels)</param>
		<param name="bottom">number, offset from the bottom edge of the frame to the bottom edge of its clamping area (in pixels)</param>
	]]
	function SetClampRectInsets(self, ...)
		return self.__DdList:SetClampRectInsets(...)
	end

	__Doc__[[
		<desc>Returns the 3D depth of the frame (for stereoscopic 3D setups)</desc>
		<return type="number">apparent 3D depth of this frame relative to that of its parent frame</return>
	]]
	function GetDepth(self, ...)
		return self.__DdList:GetDepth(...)
	end

	__Doc__[[
		<desc>Sets the 3D depth of the frame (for stereoscopic 3D configurations)</desc>
		<param name="depth">number, apparent 3D depth of this frame relative to that of its parent frame</param>
	]]
	function SetDepth(self, ...)
		return self.__DdList:SetDepth(...)
	end

	__Doc__[[
		<desc>Returns the overall opacity of the frame. Unlike :GetAlpha() which returns the opacity of the frame relative to its parent, this function returns the absolute opacity of the frame, taking into account the relative opacity of parent frames.</desc>
		<return type="number,">effective alpha (opacity) of the region (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetEffectiveAlpha(self, ...)
		return self.__DdList:GetEffectiveAlpha(...)
	end

	__Doc__[[
		<desc>Returns the overall 3D depth of the frame (for stereoscopic 3D configurations). Unlike :GetDepth() which returns the apparent depth of the frame relative to its parent, this function returns the absolute depth of the frame, taking into account the relative depths of parent frames.</desc>
		<return type="number,">apparent 3D depth of this frame relative to the screen</return>
	]]
	function GetEffectiveDepth(self, ...)
		return self.__DdList:GetEffectiveDepth(...)
	end

	__Doc__[[
		<desc>Returns the overall scale factor of the frame. Unlike :GetScale() which returns the scale factor of the frame relative to its parent, this function returns the absolute scale factor of the frame, taking into account the relative scales of parent frames.</desc>
		<return type="number,">scale factor for the frame relative to its parent</return>
	]]
	function GetEffectiveScale(self, ...)
		return self.__DdList:GetEffectiveScale(...)
	end

	__Doc__[[
		<desc>Returns the insets from the frame's edges which determine its mouse-interactable area</desc>
		<return type="left">number, distance from the left edge of the frame to the left edge of its mouse-interactive area (in pixels)</return>
		<return type="right">number, distance from the right edge of the frame to the right edge of its mouse-interactive area (in pixels)</return>
		<return type="top">number, distance from the top edge of the frame to the top edge of its mouse-interactive area (in pixels)</return>
		<return type="bottom">number, distance from the bottom edge of the frame to the bottom edge of its mouse-interactive area (in pixels)</return>
	]]
	function GetHitRectInsets(self, ...)
		return self.__DdList:GetHitRectInsets(...)
	end

	__Doc__[[
		<desc>Sets the insets from the frame's edges which determine its mouse-interactable area</desc>
		<param name="left">number, distance from the left edge of the frame to the left edge of its mouse-interactive area (in pixels)</param>
		<param name="right">number, distance from the right edge of the frame to the right edge of its mouse-interactive area (in pixels)</param>
		<param name="top">number, distance from the top edge of the frame to the top edge of its mouse-interactive area (in pixels)</param>
		<param name="bottom">number, distance from the bottom edge of the frame to the bottom edge of its mouse-interactive area (in pixels)</param>
	]]
	function SetHitRectInsets(self, ...)
		return self.__DdList:SetHitRectInsets(...)
	end

	__Doc__[[
		<desc>Returns the frame's numeric identifier. Frame IDs have no effect on frame behavior, but can be a useful way to keep track of multiple similar frames, especially in cases where a list of frames is created from a template (such as for action buttons, loot slots, or lines in a FauxScrollFrame).</desc>
		<return type="number,">a numeric identifier for the frame</return>
	]]
	function GetID(self, ...)
		return self.__DdList:GetID(...)
	end

	__Doc__[[
		<desc>Sets a numeric identifier for the frame. Frame IDs have no effect on frame behavior, but can be a useful way to keep track of multiple similar frames, especially in cases where a list of frames is created from a template (such as for action buttons, loot slots, or lines in a FauxScrollFrame).</desc>
		<param name="id">number, a numeric identifier for the frame</param>
	]]
	function SetID(self, ...)
		return self.__DdList:SetID(...)
	end

	__Doc__[[
		<desc>Sets whether the frame's depth property is ignored (for stereoscopic 3D setups). If a frame's depth property is ignored, the frame itself is not rendered with stereoscopic 3D separation, but 3D graphics within the frame may be; this property is used on the default UI's WorldFrame.</desc>
		<param name="enable">boolean, true to ignore the frame's depth property; false to disable</param>
	]]
	function IgnoreDepth(self, ...)
		return self.__DdList:IgnoreDepth(...)
	end

	__Doc__[[
		<desc>Returns whether the frame's depth property is ignored (for stereoscopic 3D setups)</desc>
		<return type="boolean">1 if the frame's depth property is ignored; otherwise nil</return>
	]]
	function IsIgnoringDepth(self, ...)
		return self.__DdList:IsIgnoringDepth(...)
	end

	__Doc__[[
		<desc>Get the child list of the widget object, !!!IMPORTANT!!!, don't do any change to the return table, this table is the real table that contains the child objects.</desc>
		<return type="table">the child objects list</return>
	]]
	function GetChilds(self, ...)
		return self.__DdList:GetChilds()
	end

	__Doc__[[
		<desc>Get the child object for the given name</desc>
		<param name="name">string, the child's name</param>
		<return type="widgetObject">the child widget object if existed</return>
	]]
	function GetChild(self, ob)
		return self.__DdList:GetChild(ob)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the frame's transparency value(0-1)]]
	property "Alpha" { Type = ColorFloat }

	__Doc__[[whether show on the cursor position]]
	property "ShowOnCursor" {
		Set = function(self, flag)
			self = self.__DdList
			self.__ShowOnCursor = (flag and true) or false
		end,

		Get = function(self)
			self = self.__DdList
			return (self.__ShowOnCursor and true) or false
		end,

		Type = Boolean,
	}

	__Doc__[[whether the checkButton on the dropDownList can be multi-selected]]
	property "MultiSelect" {
		Set = function(self, flag)
			self = self.__DdList
			self.__MultiSelect = (flag and true) or false
		end,

		Get = function(self)
			self = self.__DdList
			return (self.__MultiSelect and true) or false
		end,

		Type = Boolean,
	}

	__Doc__[[the height of the region]]
	property "Height" {
		Get = function(self)
			self = self.__DdList
			return self:GetHeight()
		end,

		Type = Number,
	}

	__Doc__[[the width of the region]]
	property "Width" {
		Get = function(self)
			self = self.__DdList
			return self:GetWidth()
		end,

		Type = Number,
	}

	__Doc__[[wheter the region is shown or not.]]
	property "Visible" {
		Set = function(self, visible)
			self.__DdList.Visible = visible
		end,

		Get = function(self)
			return self.__DdList.Visible
		end,

		Type = Boolean,
	}

	__Doc__[[the backdrop graphic for the frame]]
	property "Backdrop" {
		Set = "SetBackdrop",
		Get = "GetBackdrop",
		Type = BackdropType,
	}

	__Doc__[[the shading color for the frame's border graphic]]
	property "BackdropBorderColor" {
		Set = function(self, colorTable)
			self:SetBackdropBorderColor(colorTable.red, colorTable.green, colorTable.blue, colorTable.alpha)
		end,

		Get = function(self)
			local colorTable = {}
			colorTable.red, colorTable.green, colorTable.blue, colorTable.alpha = self:GetBackdropBorderColor()
			return colorTable
		end,

		Type = ColorType,
	}

	__Doc__[[the shading color for the frame's background graphic]]
	property "BackdropColor" {
		Set = function(self, colorTable)
			self:SetBackdropColor(colorTable.red, colorTable.green, colorTable.blue, colorTable.alpha)
		end,

		Get = function(self)
			local colorTable = {}
			colorTable.red, colorTable.green, colorTable.blue, colorTable.alpha = self:GetBackdropColor()
			return colorTable
		end,

		Type = ColorType,
	}

	__Doc__[[offsets from the frame's edges used when limiting user movement or resizing of the frame]]
	property "ClampRectInsets" {
		Set = function(self, RectInset)
			self:SetClampRectInsets(RectInset.left, RectInset.right, RectInset.top, RectInset.bottom)
		end,

		Get = function(self)
			local RectInset = {}
			RectInset.left, RectInset.right, RectInset.top, RectInset.bottom = self:GetClampRectInsets()
			return RectInset
		end,

		Type = Inset,
	}

	__Doc__[[the insets from the frame's edges which determine its mouse-interactable area]]
	property "HitRectInsets" {
		Set = function(self, RectInset)
			self:SetHitRectInsets(RectInset.left, RectInset.right, RectInset.top, RectInset.bottom)
		end,

		Get = function(self)
			local RectInset = {}
			RectInset.left, RectInset.right, RectInset.top, RectInset.bottom = self:GetHitRectInsets()
			return RectInset
		end,

		Type = Inset,
	}

	__Doc__[[a numeric identifier for the frame]]
	property "ID" {
		Set = "SetID",
		Get = "GetID",
		Type = Number,
	}

	__Doc__[[the 3D depth of the frame (for stereoscopic 3D setups)]]
	property "Depth" {
		Set = "SetDepth",
		Get = "GetDepth",
		Type = Number,
	}

	__Doc__[[whether the frame's depth property is ignored (for stereoscopic 3D setups)]]
	property "DepthIgnored" {
		Set = "IgnoreDepth",
		Get = "IsIgnoringDepth",
		Type = Boolean,
	}

	__Doc__[[dropDownMenuButton's count]]
	property "ItemCount" {
		Get = function(self)
			return self.__DdList.__ItemCount
		end,

		Type = Number,
	}

	__Doc__[[Whether auto hide the dropdownlist]]
	property "AutoHide" {
		Get = function(self)
			return not self.__DdList.__DisableAutoHide
		end,
		Set = function(self, value)
			self.__DdList.__DisableAutoHide = not value
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self.__DdList:Dispose()
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function DropDownList(self, name, parent, ...)
		Super(self, name, parent, ...)

		local frame = Button(nil, _DropDownListContainer)
		frame.__Mask = self
		self.__DdList = frame

		frame.FrameStrata = "TOOLTIP"
		frame.MouseWheelEnabled = true
		frame.Visible = false
		frame:ClearAllPoints()
		frame:SetBackdrop(_FrameBackdrop)
		frame:SetBackdropBorderColor(1, 1, 1);
		frame:SetBackdropColor(0.09, 0.09, 0.19);
		frame.Height = 8
		frame.Width = 100
		frame.__ShowOnCursor = true
		frame.__MultiSelect = true
		frame.__ItemCount = 0

		frame.OnShow = OnShow
		frame.OnHide = OnHide
		frame.OnEnter = OnEnter
		frame.OnLeave = OnLeave

		-- Timer
		local timer = Timer("DropDownList_Timer", frame)
		timer.Interval = 0
		timer.OnTimer = OnTimer

		-- MenuLevel
		frame.__MenuLevel = 1
	end
endclass "DropDownList"
