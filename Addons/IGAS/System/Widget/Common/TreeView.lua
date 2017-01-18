-- Author       : Kurapica
-- Create Date  : 9/6/2008
-- Change Log   :
--				2009.12.29	Add New ScriptType: OnClick, OnDoubleClick
--				2010.01.23 	Add Some function to TreeNode
--				2011/03/13	Recode as class
--				2011/03/21	Recode to reduce the memory cost.
--				2011/04/06	Using MetaData to keep data of the tree.
--				2011/06/20	OnDoubleClick script added.
--				2012/03/25  Recode to increase the performance
--              2013/04/26  NoOrderChange property is added to TreeNode
--              2014/06/10	Fix display error when clicking vscroll

-- Check Version
local version = 18
if not IGAS:NewAddon("IGAS.Widget.TreeView", version) then
	return
end

__Doc__[[
	<desc>TreeView is used to display hierarchical data</desc>
	<usage>
		Like :
			Alpha
			Bravo
			  -Charlie
			  -Delta
				-Echo
			Foxtrot

		Code :

			treeView = TreeView("TestTree")

			treeView:SetTree{
				ChildOrderChangable = false,
				ShowTootip = false,
				{
					Text = "Alpha",
					FunctionName = "ADD",
				},
				{
					Text = "Bravo",
					ChildOrderChangable = true,
					Childs = {
						{
							Text = "Charlie",
						},
						{
							Text = "Delta",
							Childs = {
								{
									Text = "Echo",
								}
							}
						}
					}
				},
				{
					Text = "Foxtrot",
				},
			}
	</usage>
]]
__AutoProperty__()
class "TreeView"
	inherit "Frame"

    GameTooltip = IGAS.GameTooltip

	_Height = 20
	_Indent = 8

	_UpdatingTree = _UpdatingTree or setmetatable({}, {__mode = "k"})

    -- Style
    TEMPLATE_LEFT = "LEFT"
    TEMPLATE_RIGHT = "RIGHT"
	TEMPLATE_CLASSIC = "CLASSIC"
	TEMPLATE_SMOOTH = "SMOOTH"

    -- Define Block
	enum "TreeViewStyle" {
        TEMPLATE_LEFT,
		TEMPLATE_RIGHT,
		TEMPLATE_CLASSIC,
		TEMPLATE_SMOOTH,
    }

	local _RefreshTree

	local function _Index2Name(index)
		 return ("TreeNode%d"):format(index)
	end

	local function _Index2Button(index)
		return ("_TreeNode%d"):format(index)
	end

	__Doc__[[TreeNode is used to store data for tree nodes]]
	__AutoProperty__()
	class "TreeNode"
		inherit "VirtualUIObject"

		local _RefreshTree = _RefreshTree
		local _Index2Name = _Index2Name

		local _AddNode
		local _SetNode
		local _Dispose
		local _RemoveNode

		local function Refresh(self)
			return _RefreshTree(self.__Root)
		end

		function _AddNode(self, node)
			local root = self.__Root
			local value

			if type(node) == "table" then

				local subNode = TreeNode(_Index2Name((self.__ChildNodeCount or 0) + 1), self)
				_SetNode(subNode, node)

				return subNode
			end
		end

		function _SetNode(self, node)
			local index
			local childNode

			if type(node) == "table" then
				self.__MetaData = node

				if Object.IsClass(self.Parent, TreeNode) then
					if type(self.Parent.MetaData.Childs) ~= "table" then
						self.Parent.MetaData.Childs = {}
					end
					self.Parent.MetaData.Childs[self.Index] = self.__MetaData
				else
					self.Parent.MetaData[self.Index] = self.__MetaData
				end

				-- Childs
				index = 0

				--- Set node's child
				if type(node.Childs) == "table" then
					for idx, cht in ipairs(node.Childs) do
						if type(cht) ~= "table" then
							break
						end

						index = index + 1

						if self:GetChild(_Index2Name(index)) then
							_SetNode(self:GetChild(_Index2Name(index)), cht)
						else
							_AddNode(self, cht)
						end
					end
				end

				--- remove useless child-node.
				for i = self.__ChildNodeCount or 0, index+1, -1 do
					_RemoveNode(self, i)
				end
			end
		end

		-- Dispose, release resource
		function _Dispose(self)
			local index = self.__NodeIndex
			local parent = self.Parent
			local menu = self.Menu
			local isNode = Object.IsClass(parent, TreeNode)
			local node

			if menu and menu.Owner == self then
				menu.Visible = false
				menu.Owner = nil
				self.Menu = nil
			end

			-- Dispose child node first
			if self.__ChildNodeCount and self.__ChildNodeCount > 0 then
				for i = self.__ChildNodeCount, 1, -1 do
					_Dispose(self:GetChild(_Index2Name(i)))
				end
			end

			parent:RemoveChild(self)

			if parent.__ChildNodeCount > index then
				for i = index + 1, parent.__ChildNodeCount do
					node = parent:GetChild(_Index2Name(i))
					node.__NodeIndex = i - 1
					node.Name = _Index2Name(i - 1)

					if isNode then
						parent.MetaData.Childs[i - 1] = node.MetaData
					else
						parent.MetaData[i - 1] = node.MetaData
					end
				end
			end

			if isNode then
				parent.MetaData.Childs[parent.__ChildNodeCount] = nil
			else
				parent.MetaData[parent.__ChildNodeCount] = nil
			end
			parent.__ChildNodeCount = parent.__ChildNodeCount - 1

			if self.__Root.__SelectedItem == self then
				self.__Root.__SelectedItem = nil
			end
		end

		function _RemoveNode(self, index)
			if type(index) == "number" and self:GetChild(_Index2Name(index)) then
				return _Dispose(self:GetChild(_Index2Name(index)))
			end
		end

		------------------------------------------------------
		-- Event
		------------------------------------------------------
		__Doc__[[Run when the treenode is toggled]]
		event "OnToggle"

		__Doc__[[
			<desc>Run when the treenode is double-clicked</desc>
			<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
		]]
		event "OnDoubleClick"

		__Doc__[[
			<desc>Run when the function button of the treenode is clicked</desc>
			<param name="funcName">string, the function button's name</param>
		]]
		event "OnFunctionClick"

		__Doc__[[Run when the treenode is selected]]
		event "OnSelected"

		__Doc__[[
			<desc>Run when the mouse is over an item, and the tooltip is set</desc>
			<param name="gameTooltip">System.Widget.GameTooltip, the GameTooltip object</param>
		]]
		event "OnGameTooltipShow"

		__Doc__[[Run when the node's index is changed]]
		event "OnIndexChanged"

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		__Doc__[[
			<desc>Add child-node to the treenode</desc>
			<param name="node">table, a table contains node informations</param>
			<return type="System.Widget.TreeView.TreeNode">the created tree node</return>
			<usage>object:AddNode{Text = "Show Text"}</usage>
		]]
		function AddNode(self, node)
			local subNode = _AddNode(self, node)

			if subNode then
				Refresh(self)
			end

			return subNode
		end

		__Doc__[[
			<desc>Gets a child-node by index</desc>
			<param name="index">number, the child-node's index</param>
			<return type="System.Widget.TreeView.TreeNode"></return>
		]]
		function GetNode(self, index)
			return (type(index) == "number" and self:GetChild(_Index2Name(index))) or nil
		end

		__Doc__[[
			<desc> Removes a child-node by index</desc>
			<param name="index">number, the index of the child-node</param>
			]]
		function RemoveNode(self, index)
			_RemoveNode(self, index)

			return Refresh(self)
		end

		__Doc__[[
			<desc>Whether the TreeNode is selected</desc>
			<return type="boolean">true if the treenode is selected</return>
		]]
		function IsSelected(self)
			return (self.__Root.__SelectedItem == self)
		end

		__Doc__[[Select the TreeNode]]
		function Select(self)
			local root = self.__Root
			local parent = self.Parent

			if root.__SelectedItem ~= self then
				-- Toggle
				while parent and parent ~= root do
					parent.ToggleState = true
					parent = parent.Parent
				end

				-- Select
				root.__SelectedItem = self
				Refresh(self)
			end

			Object.Fire(self, "OnSelected")

			if Object.IsClass(self, TreeNode) then
				return Object.Fire(root, "OnNodeSelected", self)
			end
		end

		__Doc__[[
			<desc>Reset the TreeNode's information</desc>
			<param name="node">table, a table contains node informations</param>
			<usage>object:SetNode{["Text"] = "Show Text"}</usage>
		]]
		function SetNode(self, node)
			_SetNode(self, node)

			return Refresh(self)
		end

		__Doc__[[
			<desc>Gets the TreeNode's toggle state</desc>
			<return type="boolean">true if the TreeNode is toggled</return>
		]]
		function GetToggleState(self)
			return self.__ToggleState or false
		end

		__Doc__[[
			<desc>Sets the TreeNode's toggle state</desc>
			<param name="toggled">boolean, true if toggle the TreeNode</param>
		]]
		function SetToggleState(self, flag)
			flag = (flag and true) or false

			if self.__ToggleState == flag then
				return
			end

			self.__ToggleState = flag

			Refresh(self)

			Object.Fire(self, "OnToggle")

			if Object.IsClass(self, TreeNode) then
				return Object.Fire(self.__Root, "OnNodeToggle", self)
			end
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[the treeNode's displayed text]]
		property "Text" {
			Get = function(self)
				if type(self.MetaData.Text) ~= "string" then
					self.MetaData.Text  = nil
				end
				return self.MetaData.Text or ""
			end,
			Set = function(self, text)
				self.MetaData.Text  = text

				return Refresh(self)
			end,
			Type = LocaleString,
		}

		__Doc__[[the treeNode's toggle state]]
		property "ToggleState" { Type = Boolean }

		__Doc__[[the treeNode's menu]]
		property "Menu" {
			Set = function(self, list)
				self.MetaData.Menu = list
			end,
			Get = function(self)
				if self.MetaData.Menu and not Object.IsClass(self.MetaData.Menu, DropDownList) then
					self.MetaData.Menu = nil
				end
				return self.MetaData.Menu
			end,
			Type = DropDownList,
		}

		__Doc__[[whether the treeNode has child-nodes]]
		property "CanToggle" {
			Get = function(self)
				return self.__ChildNodeCount and self.__ChildNodeCount > 0 or false
			end,
		}

		__Doc__[[the treeNode's child-nodes count]]
		property "ChildNodeCount" {
			Get = function(self)
				return self.__ChildNodeCount or 0
			end,
		}

		__Doc__[[the treeNode's index]]
		property "Index" {
			Field = "__NodeIndex",
			Set = function(self, index)
				local parent = self.Parent
				local isNode = Object.IsClass(parent, TreeNode)

				if index < 1 then
					index = 1
				elseif index > parent.__ChildNodeCount then
					index = parent.__ChildNodeCount
				end

				if index == self.__NodeIndex then
					return
				end

				local node

				self.Name = "Temp"..tostring(GetTime())

				if index < self.__NodeIndex then
					for i = self.__NodeIndex - 1, index, -1 do
						node = parent:GetChild(_Index2Name(i))

						node.__NodeIndex = i + 1
						node.Name = _Index2Name(i + 1)

						if isNode then
							parent.MetaData.Childs[i + 1] = node.MetaData
						else
							parent.MetaData[i + 1] = node.MetaData
						end

						Object.Fire(node, "OnIndexChanged")
						Object.Fire(node.__Root, "OnNodeIndexChanged", node)
					end
				else
					for i = self.__NodeIndex + 1, index, 1 do
						node = parent:GetChild(_Index2Name(i))

						node.__NodeIndex = i - 1
						node.Name = _Index2Name(i - 1)

						if isNode then
							parent.MetaData.Childs[i - 1] = node.MetaData
						else
							parent.MetaData[i - 1] = node.MetaData
						end

						Object.Fire(node, "OnIndexChanged")
						Object.Fire(node.__Root, "OnNodeIndexChanged", node)
					end
				end

				self.__NodeIndex = index
				self.Name = _Index2Name(index)

				if isNode then
					parent.MetaData.Childs[index] = self.MetaData
				else
					parent.MetaData[index] = self.MetaData
				end

				Object.Fire(self, "OnIndexChanged")
				Object.Fire(self.__Root, "OnNodeIndexChanged", self)

				return Refresh(self)
			end,
			Type = Number,
		}

		__Doc__[[the treeNode's level in the treeView]]
		property "Level" {
			Get = function(self)
				return self.__TreeLevel
			end,
		}

		__Doc__[[the function button's text, seperated by ","]]
		property "FunctionName" {
			Get = function(self)
				if self.MetaData.FunctionName and type(self.MetaData.FunctionName) ~= "string" then
					self.MetaData.FunctionName = nil
				end
				return self.MetaData.FunctionName
			end,
			Set = function(self, value)
				self.MetaData.FunctionName = value

				if self.__Root.__FocusButton and self.__Root.__FocusButton.__TreeNode == self then
					return Refresh(self)
				end
			end,
			Type = LocaleString,
		}

		__Doc__[[whether the child-nodes's order can be changed]]
		property "ChildOrderChangable" {
			Get = function(self)
				return self.MetaData.ChildOrderChangable and true or false
			end,
			Set = function(self, value)
				self.MetaData.ChildOrderChangable = value
				return Refresh(self)
			end,
			Type = Boolean,
		}

		__Doc__[[the meta-data table for the treeNode, set by SetNode or AddNode]]
		property "MetaData" {
			Get = function(self)
				if type(self.__MetaData) ~= "table" then
					self.__MetaData = {}

					if Object.IsClass(self.Parent, TreeNode) then
						if type(self.Parent.MetaData.Childs) ~= "table" then
							self.Parent.MetaData.Childs = {}
						end
						self.Parent.MetaData.Childs[self.Index] = self.__MetaData
					else
						self.Parent.MetaData[self.Index] = self.__MetaData
					end
				end
				return self.__MetaData
			end,
		}

		__Doc__[[the treeView]]
		property "Root" {
			Get = function(self)
				return self.__Root
			end,
		}

		__Doc__[[Whether the node's order can't be changed if the parent's ChildOrderChangable is true]]
		property "NoOrderChange" {
			Get = function(self)
				return self.MetaData.NoOrderChange
			end,
			Set = function(self, value)
				self.MetaData.NoOrderChange = value
			end,
			Type = Boolean,
		}

		------------------------------------------------------
		-- Dispose
		------------------------------------------------------
		function Dispose(self)
			local tree = self.__Root

			_Dispose(self)

			return _RefreshTree(tree)
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function TreeNode(self, name, parent, ...)
			Super(self, name, parent, ...)

			parent.__ChildNodeCount = (parent.__ChildNodeCount or 0) + 1

			if Object.IsClass(parent, TreeNode) then
				self.__Root = parent.__Root
			else
				self.__Root = parent
			end

			self.__NodeIndex = parent.__ChildNodeCount
			self.__TreeLevel = (parent.__TreeLevel or 0) + 1
		end
	endclass "TreeNode"

	------------------------------------------------------
	-- Event Handlers
	------------------------------------------------------
	local _FrameBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 9,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}
	local _FrameBackdropCommon = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 9 }
	}

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

	local function RefreshFunctionButton(self, flag)
		local index = 1
		local btnFunc, btnPrev, width

		for i = 1, 3 do
			btnFunc = self.Parent:GetChild(("_Func_%d"):format(i))

			btnFunc.Owner = nil
			btnFunc:ClearAllPoints()
			btnFunc.Visible = false
		end

		if flag or not self.__TreeNode or not self.__TreeNode.FunctionName then
			return
		end

		btnFunc = nil

		for name in self.__TreeNode.FunctionName:gmatch("[^,]+") do
			name = strtrim(name)

			if name ~= "" then
				btnPrev = btnFunc
				btnFunc = self.Parent:GetChild(("_Func_%d"):format(index))

				btnFunc.Visible = true

				btnFunc.Owner = self.__TreeNode

				if not btnPrev then
					if self.Parent:GetChild("UpArrow").Visible or self.Parent:GetChild("DownArrow").Visible then
						btnFunc:SetPoint("RIGHT", self, "RIGHT", -30, 0)
					else
						btnFunc:SetPoint("RIGHT", self, "RIGHT", -15, 0)
					end
				else
					btnFunc:SetPoint("RIGHT", btnPrev, "LEFT")
				end

				btnFunc.Text = name

				width = btnFunc:GetTextWidth()
				if ( width > 30 ) then
					btnFunc:SetWidth(width + 10)
				else
					btnFunc:SetWidth(40)
				end

				index = index + 1
				if index > 3 then
					return
				end
			end
		end
	end

	local function RefreshOrderButton(self, flag)
		local upArrow = self.Parent:GetChild("UpArrow")
		local downArrow = self.Parent:GetChild("DownArrow")

		upArrow:ClearAllPoints()

		upArrow.Visible = false
		downArrow.Visible = false
		upArrow.Owner = nil
		downArrow.Owner = nil

		if flag or not self.__TreeNode or self.__TreeNode.NoOrderChange or not self.__TreeNode.Parent.ChildOrderChangable then
			return
		end

		upArrow:SetPoint("TOP", self, "TOP", 0, -3)
		upArrow:SetPoint("RIGHT", self, "RIGHT", -15, 0)

		if self.__TreeNode.Index > 1 and not self.__TreeNode.Parent:GetNode(self.__TreeNode.Index-1).NoOrderChange then
			upArrow.Visible = true
		end

		if self.__TreeNode.Index < self.__TreeNode.Parent.ChildNodeCount and not self.__TreeNode.Parent:GetNode(self.__TreeNode.Index+1).NoOrderChange then
			downArrow.Visible = true
		end

		upArrow.Owner = self.__TreeNode
		downArrow.Owner = self.__TreeNode
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

	local function ScrollBar_OnEnter(self)
		return self.Parent:Fire("OnEnter")
	end

	local function ScrollBar_OnLeave(self)
		return self.Parent:Fire("OnLeave")
	end

	local function ScrollBar_OnValueChanged(self)
		return self.Parent.Visible and _RefreshTree(self.Parent, true)
	end

	local function ScrollBar_OnSizeChanged(self)
		local cnt = ceil((self.Height - 14) / _Height)

		if cnt > 0 and cnt ~= self.Parent.__DisplayItemCount then
			self.Parent.__DisplayItemCount = cnt
			return self.Parent.Visible and _RefreshTree(self.Parent)
		end
	end

	local function TreeNode_OnClick(self, button, down)
		if not self.__TreeNode then
			return
		end

		if button == "RightButton" then
			if self.__TreeNode.Menu then
				local menu = self.__TreeNode.Menu
				menu.Visible = false
				menu.Owner = self.__TreeNode
				menu.Visible = true
			end
			return true
		end

		if self.Parent.Style == TEMPLATE_CLASSIC or self.Parent.Style == TEMPLATE_SMOOTH then
			self.__TreeNode.ToggleState = not self.__TreeNode.ToggleState
			return self.__TreeNode:Select()
		else
			return self.__TreeNode:Select()
		end
	end

	local function TreeNode_OnDoubleClick(self, button)
		if not self.__TreeNode then
			return
		end

		local node = self.__TreeNode

		Object.Fire(node, "OnDoubleClick", button)

		if Object.IsClass(node, TreeNode) then
			return Object.Fire(node.__Root, "OnDoubleClick", node, button)
		end
	end

	local function TreeNode_OnEnter(self)
		if self.Parent.ShowTootip and self.__TreeNode then
			local from, to = getAnchors(self)

			GameTooltip:ClearLines()
			GameTooltip:Hide()

			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(from, self, to, 0, 0)
			GameTooltip:SetText(self.__TreeNode.Text)
			self.__TreeNode:Fire("OnGameTooltipShow", GameTooltip)
			self.Parent:Fire("OnNodeGameTooltipShow", GameTooltip, self.__TreeNode)
			GameTooltip:Show()
		end

		-- Refresh FunctionButton
		self.Parent.__FocusButton = self

		RefreshOrderButton(self)
		RefreshFunctionButton(self)

		return-- self.Parent:Fire("OnEnter")
	end

	local function TreeNode_OnLeave(self)
		GameTooltip:ClearLines()
		GameTooltip:Hide()

		return-- self.Parent:Fire("OnLeave")
	end

	local function ToggleBtn_OnClick(self)
		if self.Parent.__TreeNode then
			self.Parent.__TreeNode.ToggleState = not self.Parent.__TreeNode.ToggleState
		end
	end

	local function FuncButton_OnClick(self)
		if self.Owner then
			Object.Fire(self.Owner, "OnFunctionClick", self.Text)

			if Object.IsClass(self.Owner, TreeNode) then
				return Object.Fire(self.Parent, "OnNodeFunctionClick", self.Text, self.Owner)
			end
		end
	end

	local function OrderButton_OnEnter(self)
		self.Alpha = 1
	end

	local function OrderButton_OnLeave(self)
		self.Alpha = 0.6
	end

	local function OrderButton_OnUpClick(self)
		if self.Owner and self.Owner.Index > 1 and not self.Owner.Parent:GetNode(self.Owner.Index-1).NoOrderChange then
			self.Owner.Index = self.Owner.Index - 1
		end
	end

	local function OrderButton_OnDownClick(self)
		if self.Owner and self.Owner.Parent.ChildNodeCount > self.Owner.Index and not self.Owner.Parent:GetNode(self.Owner.Index+1).NoOrderChange then
			self.Owner.Index = self.Owner.Index + 1
		end
	end

	local function TreeView_OnEnter(self)
		self.Parent.__FocusButton = nil

		RefreshOrderButton(self:GetChild("ScrollBar"), true)
		return RefreshFunctionButton(self:GetChild("ScrollBar"), true)
	end

	local function TreeView_OnLeave(self)
		self.Parent.__FocusButton = nil

		RefreshOrderButton(self:GetChild("ScrollBar"), true)
		return RefreshFunctionButton(self:GetChild("ScrollBar"), true)
	end

	local function GetNextNode(self)
		if self then
			if self.ToggleState then
				if self:GetChild(_Index2Name(1)) then
					return self:GetChild(_Index2Name(1))
				end
			end

			while self.Index and self.Parent and (self.Parent.__ChildNodeCount or 0) <= self.Index do
				self = self.Parent
			end

			if self.Index and self.Parent and (self.Parent.__ChildNodeCount or 0) > self.Index then
				return self.Parent:GetChild(_Index2Name(self.Index + 1))
			end
		end
	end

	local function GetHighLightText(text)
		if text:find("\124c") then
			return text:gsub("\124r([^\124]+)\124c", "\124r"..FontColor.HIGHLIGHT.."%1"..FontColor.CLOSE.."\124c")
							 :gsub("^([^\124]+)\124c", FontColor.HIGHLIGHT.."%1"..FontColor.CLOSE.."\124c")
							 :gsub("\124r([^\124]+)$", "\124r"..FontColor.HIGHLIGHT.."%1"..FontColor.CLOSE)
		else
			return FontColor.HIGHLIGHT..text..FontColor.CLOSE
		end
	end

	function _RefreshTree(self, smartSkip, needUpdate)
		if _UpdatingTree[self] or not self.__Layout then
			return
		end

		_UpdatingTree[self] = true

		local btn, toggleBtn, text, line, texture
		local offset = floor(self:GetChild("ScrollBar").Value)
		local node, startNode = self:GetChild(_Index2Name(1))

		local cnt = ceil((self:GetChild("ScrollBar").Height - 14) / _Height)

		if cnt > 0 and cnt ~= self.__DisplayItemCount then
			self.__DisplayItemCount = cnt
		end

		local nodeCount, startIndex = 0, 0

		while node do
			nodeCount = nodeCount + 1

			if nodeCount == offset then
				startNode = node
				startIndex = nodeCount
			end

			node = GetNextNode(node)
		end

		-- Modify ScrollBar
		local _, maxV = self:GetChild("ScrollBar"):GetMinMaxValues()

		if nodeCount > self.__DisplayItemCount and maxV ~= (nodeCount - self.__DisplayItemCount + 1) then
			smartSkip = false

			self:GetChild("ScrollBar"):SetMinMaxValues(1, nodeCount - self.__DisplayItemCount + 1)
			self:GetChild("ScrollBar").Visible = true

			-- Check Value
			if startIndex > 1 and startIndex + self.__DisplayItemCount - 1 > nodeCount then
				startIndex = nodeCount - self.__DisplayItemCount + 1

				self:GetChild("ScrollBar").Value = startIndex

				-- Refind startnode
				node = self:GetChild(_Index2Name(1))
				nodeCount = 0
				startNode = nil

				while node do
					nodeCount = nodeCount + 1

					if nodeCount == startIndex then
						startNode = node
						break
					end

					node = GetNextNode(node)
				end
			end
		elseif nodeCount <= self.__DisplayItemCount and maxV ~= 1 then
			smartSkip = false

			self:GetChild("ScrollBar"):SetMinMaxValues(1, 1)
			self:GetChild("ScrollBar").Value = 1
			self:GetChild("ScrollBar").Visible = true

			startNode = self:GetChild(_Index2Name(1))
		end

		RefreshOrderButton(self:GetChild("ScrollBar"), true)
		RefreshFunctionButton(self:GetChild("ScrollBar"), true)

		local focusBtnID = self.__FocusButton and self.__FocusButton.ID

		node = startNode

		-- Create buttons
		for index = 1, self.__DisplayItemCount do
			btn = self:GetChild(_Index2Button(index))

			if not btn then
				smartSkip = false
				needUpdate = true

				-- Create buttons
				btn = Widget.Button(_Index2Button(index), self)
				btn.ID = index

				btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
				btn:ClearAllPoints()
				btn:SetPoint("LEFT", self, "LEFT", 4, 0)
				btn:SetPoint("RIGHT", self:GetChild("ScrollBar"), "LEFT", -4, 0)
				if index == 1 then
					btn:SetPoint("TOP", self, "TOP", 0, -4 + (index - 1) * -_Height)
				else
					btn:SetPoint("TOP", self:GetChild(_Index2Button(index - 1)), "BOTTOM")
				end
				btn:SetHeight(_Height)
				btn:SetHighlightTexture([[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]], "ADD")

				btn.NormalFontObject = "GameFontNormalSmallLeft"
				btn.HighlightFontObject = "GameFontHighlightSmallLeft"

				toggleBtn = Widget.Button("ToggleBtn", btn)
				toggleBtn.Visible = false
				toggleBtn.Width = 14
				toggleBtn.Height = 14
				toggleBtn:RegisterForClicks("LeftButtonUp")
				toggleBtn:SetPoint("TOPLEFT", btn, "TOPLEFT")

				text = Widget.FontString("Text", btn)
				text.FontObject = "GameFontNormal"
				text.JustifyH = "LEFT"
				text.Height = _Height
				btn:SetFontString(text)

				line = Widget.Texture("Line", btn, "BACKGROUND")
				line.TexturePath = [[Interface\AuctionFrame\UI-AuctionFrame-FilterLines]]
				line.Width = 7
				line.Height = _Height
				line.Visible = false
				line:SetTexCoord(0, 0.4375, 0, 0.625)
				line:SetPoint("RIGHT", text, "LEFT")

				btn.NormalTexturePath = [[Interface\AuctionFrame\UI-AuctionFrame-FilterBg]]

				btn.NormalTexture:SetTexCoord(0, 0.53125, 0, 0.625)
				btn.NormalTexture:ClearAllPoints()
				btn.NormalTexture:SetAllPoints(btn)

				btn.OnClick = btn.OnClick + TreeNode_OnClick
				btn.OnDoubleClick = btn.OnDoubleClick + TreeNode_OnDoubleClick
				btn.OnEnter = btn.OnEnter + TreeNode_OnEnter
				btn.OnLeave = btn.OnLeave + TreeNode_OnLeave
				toggleBtn.OnClick = toggleBtn.OnClick + ToggleBtn_OnClick
			end

			btn.FrameLevel = self.FrameLevel + 1
		end

		-- Refresh buttons
		local refreshStart, refreshEnd = 1, self.__DisplayItemCount

		if smartSkip then
			if self.__DisplayOffset > offset then
				if self.__DisplayOffset < offset + self.__DisplayItemCount then
					refreshStart = 1
					refreshEnd = self.__DisplayOffset - offset

					-- Rename
					for i = 1, self.__DisplayItemCount - refreshEnd do
						self:GetChild(_Index2Button(i)).Name = _Index2Button(-i)
					end

					for i = 1, refreshEnd do
						self:GetChild(_Index2Button(i + self.__DisplayItemCount - refreshEnd)).ID = i
						self:GetChild(_Index2Button(i + self.__DisplayItemCount - refreshEnd)).Name = _Index2Button(i)
					end

					for i = 1, self.__DisplayItemCount - refreshEnd do
						self:GetChild(_Index2Button(-i)).ID = refreshEnd + i
						self:GetChild(_Index2Button(-i)).Name = _Index2Button(refreshEnd + i)
					end

					-- Update position
					self:GetChild(_Index2Button(1)):SetPoint("TOP", self, "TOP", 0, -4)
					self:GetChild(_Index2Button(refreshEnd + 1)):SetPoint("TOP", self:GetChild(_Index2Button(refreshEnd)), "BOTTOM")
				else
					smartSkip = false
				end
			elseif self.__DisplayOffset < offset then
				if self.__DisplayOffset + self.__DisplayItemCount > offset then
					refreshStart = self.__DisplayItemCount - (offset - self.__DisplayOffset) + 1
					refreshEnd = self.__DisplayItemCount

					-- Rename
					for i = 1, refreshEnd - refreshStart + 1 do
						self:GetChild(_Index2Button(i)).Name = _Index2Button(-i)
					end

					for i = 1, refreshStart - 1 do
						self:GetChild(_Index2Button(i + refreshEnd - refreshStart + 1)).ID = i
						self:GetChild(_Index2Button(i + refreshEnd - refreshStart + 1)).Name = _Index2Button(i)
					end

					for i = 1, refreshEnd - refreshStart + 1 do
						self:GetChild(_Index2Button(-i)).ID = refreshStart + i - 1
						self:GetChild(_Index2Button(-i)).Name = _Index2Button(refreshStart + i - 1)
					end

					-- Update position
					self:GetChild(_Index2Button(1)):SetPoint("TOP", self, "TOP", 0, -4)
					self:GetChild(_Index2Button(refreshStart)):SetPoint("TOP", self:GetChild(_Index2Button(refreshStart - 1)), "BOTTOM")
				else
					smartSkip = false
				end
			else
				smartSkip = false
			end
		end

		self.__DisplayOffset = offset

		local updateStyle = needUpdate

		for index = 1, self.__DisplayItemCount do
			if index >= refreshStart and index <= refreshEnd then
				btn = self:GetChild(_Index2Button(index))

				toggleBtn = btn:GetChild("ToggleBtn")
				text = btn:GetChild("Text")
				line = btn:GetChild("Line")
				texture = btn.NormalTexture

				if node then
					btn.__TreeNode = node
					updateStyle = needUpdate or not btn.Visible
					btn.Visible = false
					btn.HighlightLocked = (node == self.__SelectedItem)

					if self.Style == TEMPLATE_SMOOTH then
						if updateStyle then
							texture.TexturePath = [[Interface\CharacterFrame\Char-Paperdoll-Parts]]
							texture:SetTexCoord(0.00390625, 0.66406250, 0.38281250, 0.49218750)

							toggleBtn:ClearAllPoints()

							toggleBtn.Width = 7
							toggleBtn:SetNormalTexture([[Interface\CharacterFrame\Char-Paperdoll-Parts]])
							toggleBtn:SetPushedTexture(nil)

							text:ClearAllPoints()
							text:SetPoint("RIGHT", btn, "RIGHT")
							text:SetPoint("LEFT", toggleBtn, "RIGHT")
						end

						toggleBtn:SetPoint("LEFT", btn, "LEFT", 4 + (node.__TreeLevel - 1) * _Indent, 0)

						if updateStyle or btn.__PrevToggleState ~= node.ToggleState then
							if node.ToggleState then
								toggleBtn.Height = 3
								toggleBtn.NormalTexture:SetTexCoord(0.00390625, 0.03125000, 0.95312500, 0.97656250)
							else
								toggleBtn.Height = 7
								toggleBtn.NormalTexture:SetTexCoord(0.40625000, 0.43359375, 0.87500000, 0.92968750)
							end
						end

						btn.__PrevToggleState = node.ToggleState

						if node.__TreeLevel == 1 then
							texture.Alpha = 1
							line.Visible = false
							toggleBtn.Visible = node.CanToggle
							text.Text = node.Text
						elseif node.__TreeLevel == 2 then
							texture.Alpha = 0.4
							line.Visible = false
							toggleBtn.Visible = node.CanToggle
							text.Text = GetHighLightText(node.Text)
						else
							texture.Alpha = 0
							line.Visible = false
							toggleBtn.Visible = node.CanToggle
							text.Text = GetHighLightText(node.Text)
						end

					elseif self.Style == TEMPLATE_CLASSIC then
						if updateStyle then
							texture.TexturePath = [[Interface\AuctionFrame\UI-AuctionFrame-FilterBg]]
							texture:SetTexCoord(0, 0.53125, 0, 0.625)

							toggleBtn:ClearAllPoints()
							toggleBtn.Width = 14
							toggleBtn.Height = 14
							toggleBtn:SetPoint("RIGHT", btn, "RIGHT")

							text:ClearAllPoints()
							text:SetPoint("RIGHT", btn, "RIGHT")
						end

						text:SetPoint("LEFT", btn, "LEFT", (node.__TreeLevel - 1) * _Indent, 0)

						if updateStyle or btn.__PrevToggleState ~= node.ToggleState then
							if node.ToggleState then
								toggleBtn:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
								toggleBtn:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
							else
								toggleBtn:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
								toggleBtn:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
							end
						end

						btn.__PrevToggleState = node.ToggleState

						if node.__TreeLevel == 1 then
							texture.Alpha = 1
							line.Visible = false
							toggleBtn.Visible = false
							text.Text = node.Text
						elseif node.__TreeLevel == 2 then
							texture.Alpha = 0.4
							line.Visible = false
							toggleBtn.Visible = false
							text.Text = GetHighLightText(node.Text)
						else
							texture.Alpha = 0
							line.Visible = true
							toggleBtn.Visible = node.CanToggle
							text.Text = GetHighLightText(node.Text)
						end

					elseif self.Style == TEMPLATE_RIGHT then
						if updateStyle then
							texture.Alpha = 0
							toggleBtn:ClearAllPoints()
							toggleBtn.Width = 14
							toggleBtn.Height = 14
							toggleBtn:SetPoint("RIGHT", btn, "RIGHT")

							text:ClearAllPoints()
							text:SetPoint("RIGHT", btn, "RIGHT")
						end

						text:SetPoint("LEFT", btn, "LEFT", (node.__TreeLevel - 1) * _Indent, 0)

						toggleBtn.Visible = node.CanToggle

						if updateStyle or btn.__PrevToggleState ~= node.ToggleState then
							if node.ToggleState then
								toggleBtn:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
								toggleBtn:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
							else
								toggleBtn:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
								toggleBtn:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
							end
						end

						btn.__PrevToggleState = node.ToggleState

						if node.__TreeLevel == 1 then
							line.Visible = false
							text.Text = node.Text
						elseif node.__TreeLevel == 2 then
							line.Visible = false
							text.Text = GetHighLightText(node.Text)
						else
							line.Visible = false
							text.Text = GetHighLightText(node.Text)
						end
					else
						if updateStyle then
							texture.Alpha = 0
							toggleBtn:ClearAllPoints()
							toggleBtn.Width = 14
							toggleBtn.Height = 14

							text:ClearAllPoints()
							text:SetPoint("RIGHT", btn, "RIGHT")
							text:SetPoint("LEFT", toggleBtn, "RIGHT")
						end

						toggleBtn:SetPoint("LEFT", btn, "LEFT", (node.__TreeLevel - 1) * _Indent, 0)

						toggleBtn.Visible = node.CanToggle

						if updateStyle or btn.__PrevToggleState ~= node.ToggleState then
							if node.ToggleState then
								toggleBtn:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
								toggleBtn:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
							else
								toggleBtn:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
								toggleBtn:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
							end
						end

						btn.__PrevToggleState = node.ToggleState

						if node.__TreeLevel == 1 then
							line.Visible = false
							text.Text = node.Text
						elseif node.__TreeLevel == 2 then
							line.Visible = false
							text.Text = GetHighLightText(node.Text)
						else
							line.Visible = false
							text.Text = GetHighLightText(node.Text)
						end
					end
					btn.Visible = true
				else
					btn.__TreeNode = nil
					btn.Visible = false
					text.Text = ""
				end
			end

			-- Get next TreeNode
			node = GetNextNode(node)
		end

		-- Clear buttons
		if focusBtnID and focusBtnID > self.__DisplayItemCount then
			self.__FocusButton = nil
		elseif focusBtnID then
			self.__FocusButton = self:GetChild(_Index2Button(focusBtnID))
		end

		local index = self.__DisplayItemCount + 1
		while self:GetChild(_Index2Button(index)) do
			self:GetChild(_Index2Button(index)):Dispose()
			index = index + 1
		end

		if self.__FocusButton then
			RefreshOrderButton(self.__FocusButton)
			RefreshFunctionButton(self.__FocusButton)
		end

		_UpdatingTree[self] = nil
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when a treenode is toggled</desc>
		<param name="node">System.Widget.TreeView.TreeNode</param>
	]]
	event "OnNodeToggle"

	__Doc__[[
		<desc>Run when the button is double-clicked</desc>
		<param name="node">System.Widget.TreeView.TreeNode</param>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
	]]
	event "OnDoubleClick"

	__Doc__[[
		<desc>Run when a treenode's function button is clicked</desc>
		<param name="funcName">the function button's name</param>
		<param name="node">System.Widget.TreeView.TreeNode</param>
	]]
	event "OnNodeFunctionClick"

	__Doc__[[
		<desc>Run when an treenode in the treeview is selected</desc>
		<param name="node">System.Widget.TreeView.TreeNode</param>
	]]
	event "OnNodeSelected"

	__Doc__[[
		<desc>Run when the mouse is over an item, and the tooltip is set</desc>
		<param name="gameTooltip">System.Widget.GameTooltip, the GameTooltip object</param>
		<param name="node">System.Widget.TreeView.TreeNode</param>
	]]
	event "OnNodeGameTooltipShow"

	__Doc__[[
		<desc>Run when a node's index is changed</desc>
		<param name="node">System.Widget.TreeView.TreeNode</param>
	]]
	event "OnNodeIndexChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Select none node]]
	function SelectNone(self)
		self.__SelectedItem = nil

		for i = (self.__ChildNodeCount or 0), 1, -1 do
			self:GetChild(_Index2Name(i)).HighlightLocked = false
		end
	end

	__Doc__[[
		<desc>Gets the selected TreeNode of the TreeView</desc>
		<return type="System.Widget.TreeView.TreeNode">the selected node</return>
	]]
	function GetSelectNode(self)
		return self.__SelectedItem
	end

	__Doc__[[
		<desc>Adds child-nodes by the given information</desc>
		<param name="node">table, a table contains the node's information</param>
		<return type="System.Widget.TreeView.TreeNode">the created tree node</return>
		<usage>object:AddNode{["Text"] = "Show Text"}</usage>
	]]
	function AddNode(self, node)
		if type(node) == "table" then
			local treeNode = TreeNode(_Index2Name((self.__ChildNodeCount or 0) + 1), self)
			treeNode:SetNode(node)
			return treeNode
		end
	end

	__Doc__[[
		<desc>Gets a child-node by index</desc>
		<param name="index">number, the index of a child-node</param>
		<return type="System.Widget.TreeView.TreeNode">the child-node with that index</return>
	]]
	function GetNode(self, index)
		return type(index) == "number" and self:GetChild(_Index2Name(index)) or nil
	end

	__Doc__[[
		<desc>Removes a child-node by index</desc>
		<param name="index">number, the index of the child-node</param>
		]]
	function RemoveNode(self, index)
		if type(index) == "number" and self:GetChild(_Index2Name(index)) then
			return self:GetChild(_Index2Name(index)):Dispose()
		end
	end

	__Doc__[[
		<desc>ReBudild the treeView with a data table</desc>
		<param name="tree">table, a table contains a data table</param>
	]]
	function SetTree(self, tree)
		local index = 0
		local node

		_UpdatingTree[self] = _UpdatingTree[self] or "SetTree"

		if type(tree) ~= "table" then
			self.__SelectedItem = nil
			for i = (self.__ChildNodeCount or 0), index+1, -1 do
				self:GetChild(_Index2Name(i)):Dispose()
			end

			self.__MetaData = nil
		else
			self.__MetaData = tree

			for idx, cht in ipairs(tree) do
				if type(cht) ~= "table" then
					break
				end

				index = index + 1

				node = TreeNode(_Index2Name(index), self)
				node:SetNode(cht)
			end

			if self.__ChildNodeCount and self.__ChildNodeCount > index then
				for i = self.__ChildNodeCount, index+1, -1 do
					self:GetChild(_Index2Name(i)):Dispose()
				end
			end
		end

		if _UpdatingTree[self] == "SetTree" then
			_UpdatingTree[self] = nil
		end

		return _RefreshTree(self)
	end

	__Doc__[[Stop the refresh of the list]]
	function SuspendLayout(self)
		self.__Layout = false
	end

	__Doc__[[Resume the refresh of the list]]
	function ResumeLayout(self)
		self.__Layout = true
		_RefreshTree(self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the selected treeNode]]
	property "SelectedNode" {
		Field = "__SelectedItem",
		Set = function(self, value)
			if value and value.__Root ~= self then
				error("SelectedNode must be a childnode of this tree.", 2)
			end

			if value then
				return TreeNode.Select(value)
			else
				return SelectNone(self)
			end
		end,
		Type = TreeNode,
	}

	__Doc__[[the child-node's count]]
	property "ChildNodeCount" {
		Get = function(self)
			return self.__ChildNodeCount or 0
		end,
	}

	__Doc__[[the treeView's style]]
	property "Style" {
		Field = "__Style",
		Set = function(self, value)
			if self.__Style == value then return end

			if value == TEMPLATE_CLASSIC then
				self:GetChild("ScrollBar").Style = TEMPLATE_CLASSIC
			else
				self:GetChild("ScrollBar").Style = "Light"
			end

			self.__Style = value

			return _RefreshTree(self, false, true)
		end,
		Type = TreeViewStyle, Default = TEMPLATE_LEFT
	}

	__Doc__[[whether show the tooltip or not]]
	property "ShowTootip" { Type = Boolean }

	__Doc__[[whether the child-node's order can be changed]]
	property "ChildOrderChangable" {
		Get = function(self)
			return self.MetaData.ChildOrderChangable and true or false
		end,
		Set = function(self, value)
			self.MetaData.ChildOrderChangable = value
		end,
		Type = Boolean,
	}

	__Doc__[[the meta-data for the treeView, set by SetTree]]
	property "MetaData" {
		Get = function(self)
			if type(self.__MetaData) ~= "table" then
				self.__MetaData = {}
			end
			return self.__MetaData
		end,
	}

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self.Visible = false

		SetTree(self, nil)
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function TreeView(self, ...)
		Super(self, ...)

		self.MouseWheelEnabled = true
		self.Visible = true
		self:ClearAllPoints()
		self:SetBackdrop(_FrameBackdrop)
		self:SetBackdropColor(0, 0, 0, 1)
		self.__DisplayItemCount = 6
		self.__Layout = true
		self.Height = 6 * _Height + 6

		-- Scroll Bar
		local scrollBar = ScrollBar("ScrollBar", self)
        scrollBar:SetPoint("TOPRIGHT", self, "TOPRIGHT", -8, -2)
        scrollBar:SetPoint("BOTTOM", self, "BOTTOM", 0, 2)
		scrollBar:SetMinMaxValues(1, 1)
		scrollBar.Value = 1
		scrollBar.Visible = false

		-- Event Handle
		scrollBar.OnValueChanged = ScrollBar_OnValueChanged
		scrollBar.OnSizeChanged = ScrollBar_OnSizeChanged
		scrollBar.OnEnter = ScrollBar_OnEnter
		scrollBar.OnLeave = ScrollBar_OnLeave

		-- Function Buttons
		local func1 = NormalButton("_Func_1", self)
		local func2 = NormalButton("_Func_2", self)
		local func3 = NormalButton("_Func_3", self)

		func1.FrameLevel = self.FrameLevel + 3
		func2.FrameLevel = self.FrameLevel + 3
		func3.FrameLevel = self.FrameLevel + 3

		func1.Style = "CLASSIC"
		func2.Style = "CLASSIC"
		func3.Style = "CLASSIC"

		func1.Height = _Height - 2
		func2.Height = _Height - 2
		func3.Height = _Height - 2

		func1.Visible = false
		func2.Visible = false
		func3.Visible = false

		func1.OnClick = FuncButton_OnClick
		func2.OnClick = FuncButton_OnClick
		func3.OnClick = FuncButton_OnClick

		-- OrderButtons
		local upArrow = Button("UpArrow", self)
		upArrow.Visible = false
		upArrow.Height = 8
		upArrow.Width = 16
		upArrow.NormalTexturePath = [[Interface\PaperDollInfoFrame\StatSortArrows]]
		upArrow.NormalTexture.Alpha = 0.6
		upArrow.NormalTexture:SetTexCoord(0, 1, 0, 0.5)
		upArrow.FrameLevel = self.FrameLevel + 3

		upArrow.OnEnter = OrderButton_OnEnter
		upArrow.OnLeave = OrderButton_OnLeave
		upArrow.OnClick = OrderButton_OnUpClick

		local downArrow = Button("DownArrow", self)
		downArrow.Visible = false
		downArrow.Height = 8
		downArrow.Width = 16
		downArrow:SetPoint("TOPLEFT", upArrow, "BOTTOMLEFT")
		downArrow.NormalTexturePath = [[Interface\PaperDollInfoFrame\StatSortArrows]]
		downArrow.NormalTexture.Alpha = 0.6
		downArrow.NormalTexture:SetTexCoord(0, 1, 0.5, 1)
		downArrow.FrameLevel = self.FrameLevel + 3

		downArrow.OnEnter = OrderButton_OnEnter
		downArrow.OnLeave = OrderButton_OnLeave
		downArrow.OnClick = OrderButton_OnDownClick

		self.OnMouseWheel = self.OnMouseWheel + OnMouseWheel

		self.OnEnter = self.OnEnter + TreeView_OnEnter
		self.OnLeave = self.OnLeave + TreeView_OnLeave
	end
endclass "TreeView"
