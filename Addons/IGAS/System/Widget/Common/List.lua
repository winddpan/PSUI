--	Author     	 	Kurapica
--	Create Date	 	12/07/2009
--	ChangeLog
--		2010.01.09	Add icons and frames settings
--		2010/02/08  remove the list FrameStrata settings
--		2010/02/12  Add OnSizeChanged script
--		2010/03/03	Add OnItemDoubleClick script
--		2010/06/21  Use # to instead of getn, make proxy can be used as keys, items, icons or frames
--		2010/10/19	Now can show tooltip to the listitem buy set ShowTooltip to true
--		2011/03/13	Recode as class
--      2011/11/02  Remvoe visible check
--      2015/03/18  Add GameTooltip for selected item

-- Check Version
local version = 15
if not IGAS:NewAddon("IGAS.Widget.List", version) then
	return
end

__Doc__[[List is a widget type using for show list of infomations]]
__AutoProperty__()
class "List"
	inherit "Frame"

    _GameTooltip = IGAS.GameTooltip
    rycGameTooltip = Recycle(GameTooltip, "IGAS_List_GameTooltip%d", IGAS.UIParent, "GameTooltipTemplate")

    function rycGameTooltip:OnInit(obj)
    	obj.Visible = false
    end

    function rycGameTooltip:OnPush(obj)
    	obj:ClearLines()
    	obj.Visible = false
    	obj.Parent = IGAS.UIParent
    end

	_Height = 26

    -- Style
    TEMPLATE_CLASSIC = "CLASSIC"
    TEMPLATE_LIGHT = "LIGHT"

    -- Define Block
	enum "ListStyle" {
        TEMPLATE_CLASSIC,
		TEMPLATE_LIGHT,
    }

    -- Backdrop settings
	_FrameBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 9,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}
	_FrameBackdropCommon = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 9 }
	}

	-- Help functions
    local function getAnchors(frame)
        local x, y = frame:GetCenter()
        if not x then x, y = frame.Parent:GetCenter() end
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

	local _OnGameTooltip

	local function Item_OnEnter(self)
		if self.Parent.ShowTooltip and not self.Parent.ShowTooltipForSelectedItem then
			local from, to = getAnchors(self)
			local parent = self.Parent

			if _OnGameTooltip then
				_OnGameTooltip = nil
				_GameTooltip:ClearLines()
				_GameTooltip:Hide()
			end

			if not parent.Items[self.ID] then
				return
			end

			_OnGameTooltip = self
			_GameTooltip:SetOwner(self, "ANCHOR_NONE")
			_GameTooltip:ClearAllPoints()
			_GameTooltip:SetPoint(from, self, to, 0, 0)
			_GameTooltip:SetText(parent.Items[self.ID])
			parent:Fire("OnGameTooltipShow", _GameTooltip, parent.Keys[self.ID], parent.Items[self.ID], parent.Icons[self.ID], parent.Frames[self.ID])
			_GameTooltip:Show()
		end
		self.Parent:Fire("OnEnter")
	end

	local function Item_OnLeave(self)
		_OnGameTooltip = nil
		_GameTooltip:ClearLines()
        _GameTooltip:Hide()
		self.Parent:Fire("OnLeave")
	end

	local function Item_OnClick(self)
		local parent = self.Parent
		parent.__ChooseItem = self.ID
		for i = 1, parent.__DisplayItemCount do
			parent:GetChild("ListBtn_"..i).HighlightLocked = false
		end
		self.HighlightLocked = true
		return parent:Fire("OnItemChoosed", parent.Keys[self.ID], parent.Items[self.ID], parent.Icons[self.ID], parent.Frames[self.ID])
	end

	local function Item_OnDoubleClick(self)
		local parent = self.Parent
		return parent:Fire("OnItemDoubleClick", parent.Keys[self.ID], parent.Items[self.ID], parent.Icons[self.ID], parent.Frames[self.ID])
	end

	local function ScrollBar_OnEnter(self)
		return self.Parent:Fire("OnEnter")
	end

	local function ScrollBar_OnLeave(self)
		return self.Parent:Fire("OnLeave")
	end

	local function RefreshItem(self, btnIdx, itemIdx)
		local btn = self:GetChild("ListBtn_"..btnIdx)

		if not btn then return end

		if itemIdx and self.Keys[itemIdx] ~= nil then
			btn:GetChild("Text"):SetText(self.Items[itemIdx] or "")
			if self.Icons[itemIdx] then
				btn:GetChild("Icon").Width = 18
				btn:GetChild("Icon"):SetTexture(self.Icons[itemIdx])
			else
				btn:GetChild("Icon").Width = 1
				btn:GetChild("Icon"):SetTexture(nil)
			end
			if self.Frames[itemIdx] and type(self.Frames[itemIdx]) == "table" and self.Frames[itemIdx].SetAllPoints then
				btn:GetChild("Text").Visible = false
				btn:GetChild("Icon").Visible = false
				if btn.__ShowF and btn.__ShowF.Parent == btn then
					btn.__ShowF.Visible = false
					btn.__ShowF:ClearAllPoints()
					btn.__ShowF.Parent = nil
				end
				btn.__ShowF = self.Frames[itemIdx]
				self.Frames[itemIdx].Parent = btn
				self.Frames[itemIdx]:ClearAllPoints()
				self.Frames[itemIdx]:SetAllPoints(btn)
				self.Frames[itemIdx].FrameLevel = btn.FrameLevel - 1
				self.Frames[itemIdx].Visible = true
			else
				btn:GetChild("Text").Visible = true
				btn:GetChild("Icon").Visible = true
				if btn.__ShowF and btn.__ShowF.Parent == btn then
					btn.__ShowF.Visible = false
					btn.__ShowF:ClearAllPoints()
					btn.__ShowF.Parent = nil
				end
				btn.__ShowF = nil
			end
		else
			btn:GetChild("Text"):SetText("")
			btn:GetChild("Icon"):SetTexture(nil)
			if btn.__ShowF and btn.__ShowF.Parent == btn then
				btn.__ShowF.Visible = false
				btn.__ShowF:ClearAllPoints()
				btn.__ShowF.Parent = nil
			end
			btn.__ShowF = nil
		end

		if btn == _OnGameTooltip then
			_GameTooltip:ClearLines()
			_GameTooltip:Hide()
			_OnGameTooltip = nil

			if self.ShowTooltip and self.Items[btn.ID] then
				local from, to = getAnchors(btn)

				_OnGameTooltip = btn
				_GameTooltip:SetOwner(btn, "ANCHOR_NONE")
				_GameTooltip:ClearAllPoints()
				_GameTooltip:SetPoint(from, btn, to, 0, 0)
				_GameTooltip:SetText(self.Items[btn.ID])
				self:Fire("OnGameTooltipShow", _GameTooltip, self.Keys[btn.ID], self.Items[btn.ID], self.Icons[btn.ID], self.Frames[btn.ID])
				_GameTooltip:Show()
			end
		end
	end

	local function ScrollBar_OnValueChanged(self)
		local parent = self.Parent

		--if not parent.Visible then return end

		for i = 1, parent.__DisplayItemCount do
			RefreshItem(parent, i, i + self:GetValue() - 1)
			parent:GetChild("ListBtn_"..i).ID = i + self:GetValue() - 1
			parent:GetChild("ListBtn_"..i).HighlightLocked = false
			if parent:GetChild("ListBtn_"..i).ID == parent.__ChooseItem then
				parent:GetChild("ListBtn_"..i).HighlightLocked = true
			end
		end
	end

	local function relayoutFrame(self)
		if not self.__Layout then return end

		-- Dropdown List
		local dropCount = self.__DisplayItemCount

		-- Scroll Bar
		local scrollBar = self:GetChild("ScrollBar")

		local i, btn, btnFontString, texture, icon

		-- Add Button
		for i = 1, dropCount do
			if not self:GetChild("ListBtn_"..i) then
				btn = Button("ListBtn_"..i, self)
				btn:ClearAllPoints()
				btn:SetPoint("LEFT", self, "LEFT")
				btn:SetPoint("RIGHT", scrollBar, "LEFT")
				btn:SetPoint("TOP", self, "TOP", 0, (i - 1) * -_Height)
				btn:SetHeight(_Height)
				btn:SetHighlightTexture("Interface\\BUTTONS\\UI-Common-MouseHilight.blp", "ADD")
				texture = btn:GetHighlightTexture()
				texture:SetTexCoord(0.125,0.875,0.125,0.875)

				icon = Texture("Icon", btn, "OVERLAY")
				icon:SetWidth(18)
				icon:SetHeight(18)
				icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
				icon:SetPoint("LEFT", btn, "LEFT", 8, 0)

				btnFontString = FontString("Text", btn, "ARTWORK","GameFontNormal")
				--btn:SetFontString(btnFontString)
				btnFontString:SetPoint("LEFT", icon, "RIGHT")
				btnFontString:SetPoint("RIGHT", btn, "RIGHT")
				btnFontString:SetJustifyH(self.__JustifyH or "LEFT")
				btnFontString:SetJustifyV("MIDDLE")

				btn:SetText("")
				--btn:Hide()
				btn.OnClick = Item_OnClick
				btn.OnDoubleClick = Item_OnDoubleClick
				btn.OnEnter = Item_OnEnter
				btn.OnLeave = Item_OnLeave
			else
				self:GetChild("ListBtn_"..i).Visible = true
			end
		end

		-- Hide no use button
		i = dropCount + 1
		while self:GetChild("ListBtn_"..i) do
			self:GetChild("ListBtn_"..i):Hide()
			i = i + 1
		end

		local iStrCount = (self.Keys and #self.Keys) or 0

		if iStrCount == 0 then
			for i = 1, dropCount do
				self:GetChild("ListBtn_"..i):Hide()
				RefreshItem(self, i)
			end
			self:GetChild("ScrollBar"):SetMinMaxValues(1, 1)
			self:GetChild("ScrollBar"):Hide()
		elseif dropCount >= iStrCount then
			for i = 1, iStrCount do
				self:GetChild("ListBtn_"..i):Show()
				RefreshItem(self, i, i)
				self:GetChild("ListBtn_"..i).ID = i
				self:GetChild("ListBtn_"..i).HighlightLocked = false
				if self:GetChild("ListBtn_"..i).ID == self.__ChooseItem then
					self:GetChild("ListBtn_"..i).HighlightLocked = true
				end
			end

			if dropCount > iStrCount then
				for i = iStrCount +1, dropCount do
					self:GetChild("ListBtn_"..i):Hide()
					RefreshItem(self, i)
					self:GetChild("ListBtn_"..i).ID = i
					self:GetChild("ListBtn_"..i).HighlightLocked = false
				end
			end

			self:GetChild("ScrollBar"):SetMinMaxValues(1, 1)
			self:GetChild("ScrollBar"):Hide()
		else
			for i = 1, dropCount do
				self:GetChild("ListBtn_"..i):Show()
				RefreshItem(self, i, i)
				self:GetChild("ListBtn_"..i).ID = i
				self:GetChild("ListBtn_"..i).HighlightLocked = false
				if self:GetChild("ListBtn_"..i).ID == self.__ChooseItem then
					self:GetChild("ListBtn_"..i).HighlightLocked = true
				end
			end
			self:GetChild("ScrollBar"):SetMinMaxValues(1, iStrCount - dropCount + 1)
			self:GetChild("ScrollBar"):Show()
		end

		self:GetChild("ScrollBar"):SetValue(1)
	end

	local function OnMouseWheel(self, arg1)
		local scrollBar = self:GetChild("ScrollBar")
		local iMin, iMax = scrollBar:GetMinMaxValues()
		local iPos = scrollBar:GetValue()
		local step = scrollBar.ValueStep
		local btnC = self.__DisplayItemCount

		if arg1 > 0 then
			if IsShiftKeyDown() then
				scrollBar.Value = iMin
			elseif IsControlKeyDown() then
				if iPos - btnC > iMin then
					scrollBar.Value = iPos - btnC
				else
					scrollBar.Value = iMin
				end
			else
				if iPos - step > iMin then
					scrollBar.Value = iPos - step
				else
					scrollBar.Value = iMin
				end
			end
		elseif arg1 < 0 then
			if IsShiftKeyDown() then
				scrollBar.Value = iMax
			elseif IsControlKeyDown() then
				if iPos + btnC < iMax then
					scrollBar.Value = iPos + btnC
				else
					scrollBar.Value = iMax
				end
			else
				if iPos + step < iMax then
					scrollBar.Value = iPos + step
				else
					scrollBar.Value = iMax
				end
			end
		end
	end

	local function ScrollBar_OnSizeChanged(self)
		if self.__LastRefreshTime and GetTime() - self.__LastRefreshTime < 0.1 then
			return
		else
			self.__LastRefreshTime = GetTime()
		end

		local cnt = math.ceil((self.Height - 12) / _Height)

		if cnt > 0 and cnt ~= self.Parent.__DisplayItemCount then
			self.Parent.__DisplayItemCount = cnt
			--if self.Parent.Visible then
			self.Parent:Refresh()
			--end
		end
	end

	local function OnItemChoosed_Tip(self, ...)
		if not self.Visible then return end

		for i = 1, self.__DisplayItemCount do
			if self:GetChild("ListBtn_"..i).HighlightLocked then
				self = self:GetChild("ListBtn_"..i)
				local from, to = getAnchors(self)
				local parent = self.Parent

				if parent._GameTooltip then
					parent._GameTooltip:ClearLines()
					parent._GameTooltip.Visible = false
				end

				if not parent.Items[self.ID] then
					return
				end

				if not parent._GameTooltip then
					parent._GameTooltip = rycGameTooltip()
					parent._GameTooltip.Parent = parent
				end

				parent._GameTooltip:SetOwner(self, "ANCHOR_NONE")
				parent._GameTooltip:ClearAllPoints()
				parent._GameTooltip:SetPoint(from, self, to, 0, 0)
				parent._GameTooltip:SetText(parent.Items[self.ID])
				parent:Fire("OnGameTooltipShow", parent._GameTooltip, parent.Keys[self.ID], parent.Items[self.ID], parent.Icons[self.ID], parent.Frames[self.ID])
				parent._GameTooltip:Show()
				return
			end
		end
	end

	local function OnShow(self)
		self:Refresh()
		return self.ShowTooltipForSelectedItem and OnItemChoosed_Tip(self)
	end

	local function OnHide(self)
		if self._GameTooltip then
			self._GameTooltip:ClearLines()
			self._GameTooltip.Visible = false
		end
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the mouse is over an item, and the Tooltip property is set</desc>
		<param name="gameTooltip">System.Widget.GameTooltip, the GameTooltip object</param>
		<param name="key">any, the choosed item's value</param>
		<param name="text">string, the choosed item's text</param>
		<param name="icon">string, the choosed item's icon texture path</param>
	]]
	event "OnGameTooltipShow"

	__Doc__[[
		<desc>Run when the choosed item is changed</desc>
		<param name="key">any, the choosed item's value</param>
		<param name="text">string, the choosed item's text</param>
		<param name="icon">string, the choosed item's icon texture path</param>
	]]
	event "OnItemChoosed"

	__Doc__[[
		<desc>Run when an item is double-clicked</desc>
		<param name="key">any, the choosed item's value</param>
		<param name="text">string, the choosed item's text</param>
		<param name="icon">string, the choosed item's icon texture path</param>
	]]
	event "OnItemDoubleClick"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Sets the list's style</desc>
		<param name="style">System.Widget.List.ListStyle</param>
	]]
	function SetStyle(self, style)
		local t

		-- Check Style
		if not style or type(style) ~= "string" then
			return
		end

		if (not ListStyle[style]) or style == self.__Style then
			return
		end

		-- Change Style
		if style == TEMPLATE_CLASSIC then
			self:SetBackdrop(_FrameBackdropCommon)
			self:SetBackdropColor(0,0,0,1)
		elseif style == TEMPLATE_LIGHT then
			self:SetBackdrop(_FrameBackdrop)
			self:SetBackdropColor(0,0,0,1)
		end

		self.__Style = style

		self.ScrollBar.Style = style
	end

	__Doc__[[
		<desc>Gets the List's style</desc>
		<return type="System.Widget.List.ListStyle"></return>
	]]
	function GetStyle(self)
		return self.__Style or TEMPLATE_LIGHT
	end

	__Doc__[[
		<desc>Select a item by index</desc>
		<param name="index">number</param>
	]]
	function SelectItemByIndex(self, index)
		-- Check later, maybe nil
		if not index or type(index) ~= "number" or index <= 0 then
			index = 0
		elseif index > #self.Keys then
			index = #self.Keys
		end

		if index == 0 or #self.Keys <= self.__DisplayItemCount then
			self:GetChild("ScrollBar"):SetValue(1)
		elseif self.__DisplayItemCount + index > #self.Keys then
			self:GetChild("ScrollBar"):SetValue(#self.Keys - self.__DisplayItemCount + 1)
		else
			self:GetChild("ScrollBar"):SetValue(index)
		end

		for i = 1, self.__DisplayItemCount do
			self:GetChild("ListBtn_"..i).HighlightLocked = false
			if self:GetChild("ListBtn_"..i).ID == index then
				self:GetChild("ListBtn_"..i).HighlightLocked = true
			end
		end

		if self.__ChooseItem ~= index then
			self.__ChooseItem = index
			--self:Fire("OnItemChoosed", self.Keys[self.__ChooseItem], self.Items[self.__ChooseItem], self.Icons[self.__ChooseItem], self.Frames[self.__ChooseItem])
		end

		return self.ShowTooltipForSelectedItem and OnItemChoosed_Tip(self)
	end

	__Doc__[[
		<desc>Select a item by text</desc>
		<param name="text">string</param>
	]]
	function SelectItemByText(self, text)
		if text and type(text) == "string" then
			for i =1, #self.Items do
				if self.Items[i] == text then
					return self:SelectItemByIndex(i)
				end
			end
		end
		return self:SelectItemByIndex(0)
	end

	__Doc__[[
		<desc>Select a item by value</desc>
		<param name="value">any</param>
	]]
	function SelectItemByValue(self, val)
		if val ~= nil then	-- val could be false, so check with nil
			for i = 1, #self.Keys do
				if self.Keys[i] == val then
					return self:SelectItemByIndex(i)
				end
			end
		end
		return self:SelectItemByIndex(0)
	end

	__Doc__[[
		<desc>Gets the selected item's index</desc>
		<return type="number"></return>
	]]
	function GetSelectedItemIndex(self)
		return self.__ChooseItem or 0
	end

	__Doc__[[
		<desc>Gets the selected item's value</desc>
		<return type="any"></return>
	]]
	function GetSelectedItemValue(self)
		return self.__ChooseItem and self.Keys[self.__ChooseItem]
	end

	__Doc__[[
		<desc>Gets the selected item's text</desc>
		<return type="string"></return>
	]]
	function GetSelectedItemText(self)
		return self.__ChooseItem and self.Items[self.__ChooseItem]
	end

	__Doc__[[
		<desc>Returns the minimum increment between allowed slider values</desc>
		<return type="number"></return>
	]]
	function GetScrollStep(self)
		return self:GetChild("ScrollBar").ValueStep
	end

	__Doc__[[
		<desc>Sets the minimum increment between allowed slider values</desc>
		<param name="step">number, minimum increment between allowed slider values</param>
	]]
	function SetScrollStep(self, step)
		if step > 0 then
			self:GetChild("ScrollBar").ValueStep = step
		end
	end

	__Doc__[[Refresh the list]]
	function Refresh(self)
		--if not self.Visible then
		--	return
		--end

		-- ReDraw
		relayoutFrame(self)

		-- Select Item
		return self:SelectItemByIndex(self.__ChooseItem)
	end

	__Doc__[[
		<desc>Stop the refresh of the list</desc>
		<param name="..."></param>
	]]
	function SuspendLayout(self)
		self.__Layout = false
	end

	__Doc__[[Resume the refresh of the list]]
	function ResumeLayout(self)
		self.__Layout = true
		self:Refresh()
	end

	__Doc__[[Clear the list]]
	function Clear(self)
		for i = #self.Keys, 1, -1 do
			self.Keys[i] = nil
			self.Items[i] = nil
			self.Icons[i] = nil
			self.Frames[i] = nil
		end
		self.__ChooseItem = nil

		--if self.Visible then
		self:Refresh()
		--end
	end

	__Doc__[[
		<desc>Add an item to the list</desc>
		<format>key, text[, icon]</format>
		<param name="key">any, the value of the item</param>
		<param name="text">string, the text of the item, to be displayed for informations</param>
		<param name="icon">string ,the icon path of the item, will be shown at the left of the text if set</param>
	]]
	function AddItem(self, key, text, icon, frame)
		if key ~= nil then
			self.Keys[#self.Keys + 1] = key
			if text and type(text) == "string" then
				self.Items[#self.Items + 1] = text
			else
				self.Items[#self.Items + 1] = tostring(key)
			end
			self.Icons[#self.Keys] = icon
			self.Frames[#self.Keys] = frame
		end

		--if self.Visible then
		self:Refresh()
		--end
	end

	__Doc__[[
		<desc>Modify or add an item in the item list</desc>
		<format>key, text[, icon]</format>
		<param name="key">any, the value of the item</param>
		<param name="text">string, the text of the item, to be displayed for informations</param>
		<param name="icon">string ,the icon path of the item, will be shown at the left of the text if set</param>
	]]
	function SetItem(self, key, text, icon, frame)
		local idx = 1
		if key == nil then
			return
		end
		while self.Keys[idx] and self.Keys[idx] ~= key do
			idx = idx + 1
		end
		self.Keys[idx] = key
		if text and type(text) == "string" then
			self.Items[idx] = text
		else
			self.Items[idx] = tostring(key)
		end
		self.Icons[idx] = icon
		self.Frames[idx] = frame

		--if self.Visible then
		self:Refresh()
		--end
	end

	__Doc__[[
		<desc>Get an item's info from the item list by key</desc>
		<param name="key">any, the value of the item</param>
		<return type="key">any, the value of the item</return>
		<return type="text">string, the text of the item, to be displayed for informations</return>
		<return type="icon">string ,the icon path of the item, will be shown at the left of the text if set</return>
	]]
	function GetItem(self, key)
		local idx = 1
		if key == nil then
			return
		end
		while self.Keys[idx] and self.Keys[idx] ~= key do
			idx = idx + 1
		end
		if self.Keys[idx] then
			return self.Keys[idx], self.Items[idx], self.Icons[idx], self.Frames[idx]
		end
	end

	__Doc__[[
		<desc>Get an item's info from the item list by index</desc>
		<param name="index">number, the item's index</param>
		<return type="key">any, the value of the item</return>
		<return type="text">string, the text of the item, to be displayed for informations</return>
		<return type="icon">string ,the icon path of the item, will be shown at the left of the text if set</return>
	]]
	function GetItemByIndex(self, idx)
		if self.Keys[idx] then
			return self.Keys[idx], self.Items[idx], self.Icons[idx], self.Frames[idx]
		end
	end

	__Doc__[[
		<desc>Insert an item to the list</desc>
		<param name="index">number, the index to be inserted, if nil, would be insert at last</param>
		<param name="key">any, the value of the item</param>
		<param name="text">string, the text of the item, to be displayed for informations</param>
		<param name="icon">string ,the icon path of the item, will be shown at the left of the text if set</param>
	]]
	function InsertItem(self, index, key, text, icon, frame)
		if not index or type(index) ~= "number" or index > #self.Keys + 1 then
			index = #self.Keys + 1
		end

		if key == nil then
			return
		end

		for i = #self.Keys, index, -1 do
			self.Keys[i + 1] = self.Keys[i]
			self.Items[i + 1] = self.Items[i]
			self.Icons[i + 1] = self.Icons[i]
			self.Frames[i + 1] = self.Frames[i]
		end

		self.Keys[index] = key
		if text and type(text) == "string" then
			self.Items[index] = text
		else
			self.Items[index] = tostring(key)
		end
		self.Icons[index] = icon
		self.Frames[index] = frame

		--if self.Visible then
		self:Refresh()
		--end
	end

	__Doc__[[
		<desc>Remove an item from the item list by key</desc>
		<param name="key">any, the value of the item</param>
	]]
	function RemoveItem(self, key)
		local idx = 1
		if key == nil then
			return
		end
		while self.Keys[idx] and self.Keys[idx] ~= key do
			idx = idx + 1
		end
		if self.Keys[idx] and self.Keys[idx] == key then
			if idx == self.__ChooseItem then
				self.__ChooseItem = nil
			end

			for i = idx, #self.Keys do
				self.Keys[i] = self.Keys[i + 1]
				self.Items[i] = self.Items[i + 1]
				self.Icons[i] = self.Icons[i + 1]
				self.Frames[i] = self.Frames[i + 1]
			end

			--if self.Visible then
			self:Refresh()
			--end
		end
	end

	__Doc__[[
		<desc>Remove an item from the item list by index</desc>
		<param name="index">number, the item's index</param>
	]]
	function RemoveItemByIndex(self, idx)
		if self.Keys[idx] then
			if idx == self.__ChooseItem then
				self.__ChooseItem = nil
			end

			for i = idx, #self.Keys do
				self.Keys[i] = self.Keys[i + 1]
				self.Items[i] = self.Items[i + 1]
				self.Icons[i] = self.Icons[i + 1]
				self.Frames[i] = self.Frames[i + 1]
			end

			--if self.Visible then
			self:Refresh()
			--end
		end
	end

	__Doc__[[
		<desc>Build item list from a table</desc>
		<param name="list">table, a table contains key-value pairs like {[true] = "True", [false] = "False"}</param>
	]]
	function SetList(self, list)
		if type(list) == "table" then
			self:SuspendLayout()
			self:Clear()
			for k, v in pairs(list) do
				self:AddItem(k, v)
			end
			self:ResumeLayout()
		else
			error("The parameter must be a table")
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the minimum increment between allowed slider values]]
	property "ScrollStep" { Type = Number }

	__Doc__[[the display count in the list]]
	property "DisplayItemCount" {
		Field = "__DisplayItemCount",
		Set = function(self, cnt)
			if cnt and type(cnt) == "number" and cnt > 3 and cnt ~= self.__DisplayItemCount then
				self.__DisplayItemCount = cnt
				self.Height = cnt * _Height + 6
				--if self.Visible then
				self:Refresh()
				--end
			end
		end,
		Type = Number,
	}

	__Doc__[[a table that contains keys of the items]]
	property "Keys" {
		Set = function(self, keys)
			self.__Keys = keys or {}
		end,
		Get = function(self)
			self.__Keys = self.__Keys or {
				_AutoCreated = true,
			}
			return self.__Keys
		end,
		Type = TableUserdata,
	}

	__Doc__[[a table that contains Text of the items]]
	property "Items" {
		Set = function(self, items)
			items = items or {}

			if not self.__Keys or self.__Keys._AutoCreated or self.__Keys == self.__Items then
				self.__Keys = items
			end

			self.__Items = items

			self:Refresh()
		end,
		Get = function(self)
			self.__Items = self.__Items or {}
			return self.__Items
		end,
		Type = TableUserdata,
	}

	__Doc__[[a table that contains icons of the items]]
	property "Icons" {
		Set = function(self, icons)
			self.__Icons = icons or {}
			self:Refresh()
		end,
		Get = function(self)
			self.__Icons = self.__Icons or {}
			return self.__Icons
		end,
		Type = TableUserdata,
	}

	__Doc__[[a table that contains frames of the items]]
	property "Frames" {
		Set = function(self, frames)
			self.__Frames = frames or {}
			self:Refresh()
		end,
		Get = function(self)
			self.__Frames = self.__Frames or {}
			return self.__Frames
		end,
		Type = TableUserdata,
	}

	__Doc__[[the item's count]]
	property "ItemCount" {
		Get = function(self)
			return #self.Keys
		end,
		Type = Number,
	}

	__Doc__[[the list's horizontal text alignment style]]
	property "JustifyH" {
		Field = "__JustifyH",
		Set = function(self, justifyH)
			self.__JustifyH = justifyH
			local i = 1
			while self:GetChild("ListBtn_"..i) do
				local btn = Button("ListBtn_"..i, self)

				local btnFontString = FontString("Text", btn, "ARTWORK","GameFontNormal")
				btnFontString:SetJustifyH(self.__JustifyH or "LEFT")

				i = i + 1
			end
		end,
		Type = JustifyHType,
	}

	__Doc__[[the list's style]]
	property "Style" { Type = ListStyle }

	__Doc__[[the selected item's index]]
	property "SelectedIndex" {
		Set = function(self, index)
			self:SelectItemByIndex(index)
		end,
		Get = function(self)
			return self.__ChooseItem or 0
		end,
		Type = NumberNil,
	}

	__Doc__[[whether show tooltip or not]]
	property "ShowTooltip" { Type = Boolean }

	__Doc__[[whether only show tooltip for the selected item]]
	__Handler__(function (self, value)
		if value then
			self.OnItemChoosed = self.OnItemChoosed + OnItemChoosed_Tip
			OnItemChoosed_Tip(self)
		else
			self.OnItemChoosed = self.OnItemChoosed - OnItemChoosed_Tip
			if self._GameTooltip then
				rycGameTooltip(self._GameTooltip)
				self._GameTooltip = nil
			end
		end
	end)
	property "ShowTooltipForSelectedItem" { Type = Boolean }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function List(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.MouseWheelEnabled = true
		self.Visible = true
		self:ClearAllPoints()
		self:SetBackdrop(_FrameBackdrop)
		self:SetBackdropColor(0, 0, 0, 1)
		self.__DisplayItemCount = 6
		self.Height = 6 * _Height + 6
		self.__Layout = true

		-- Scroll Bar
		local scrollBar = ScrollBar("ScrollBar", self)
		scrollBar:Hide()

		-- Event Handle
		scrollBar.OnValueChanged = ScrollBar_OnValueChanged
		scrollBar.OnSizeChanged = ScrollBar_OnSizeChanged
		scrollBar.OnEnter = ScrollBar_OnEnter
		scrollBar.OnLeave = ScrollBar_OnLeave

		self.OnMouseWheel = self.OnMouseWheel + OnMouseWheel
		self.OnShow = self.OnShow + OnShow
		self.OnHide = self.OnHide + OnHide

		self.__JustifyH = "LEFT"
		self.__Style = TEMPLATE_LIGHT

		relayoutFrame(self)
	end
endclass "List"
