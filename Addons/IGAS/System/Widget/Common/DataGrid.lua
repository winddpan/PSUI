-- Author      : Kurapica
-- Change Log  :
--				2011/03/13	Recode as class
--              2012/04/22  Fix some bug

-- Check Version
local version = 7

if not IGAS:NewAddon("IGAS.Widget.DataGrid", version) then
	return
end

__Doc__[[DataGrid is used to display data settings. Beta version]]
__AutoProperty__()
class "DataGrid"
	inherit "Frame"

	_Height = 26

	-- Define Block
	enum "DataGridCellType" {
		"Number",
		"String",
		"Label",
		"ComboBox",
		"Boolean",
		"Advance",
	}

	_blKey = {true, false}
	_blItem = {"True", "False"}

	_DefaultBackColor = ColorType(0, 0, 0)

	_FrameBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\ChatFrame\\CHATFRAMEBACKGROUND",
		tile = true, tileSize = 16, edgeSize = 1,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}

	local function errorhandler(err)
		return geterrorhandler()(err)
	end

	local function ConvertLst(keyList, itemList)
		if keyList and type(keyList) == "table" then
			if itemList and type(itemList) == "table" and getn(keyList) == getn(itemList) then
				return keyList, itemList
			else
				local key, item = {}, {}
				for i,v in pairs(keyList) do
					tinsert(key, i)
					tinsert(item, v)
				end

				return key, item
			end
		end
	end

	local function DropdownBtn_OnClick(self)
		local cell = self.Parent.__Cell

		cell.Parent:Fire("OnAdvance", cell.RowIndex, cell.ColumnIndex)

		-- return true to block onclick
		return true
	end

	local function RefreshCell(self, display, cell)
		display.__Cell = cell

		if cell then
			display.DropdownBtn.OnClick = display.DropdownBtn.OnClick - DropdownBtn_OnClick

			display.BackdropColor = cell.BackColor
			display:GetChild("Text").Numeric = false
			if cell.CellType == "Number" then
				display:GetChild("Text").Numeric = true
				display.Editable = true
				display:GetChild("DropdownBtn").Visible = false
			elseif cell.CellType == "String" then
				display.Editable = true
				display:GetChild("DropdownBtn").Visible = false
			elseif cell.CellType == "ComboBox" then
				display.Editable = false
				display:GetChild("DropdownBtn").Visible = true
				display.Keys = cell.Keys
				display.Items = cell.Items
			elseif cell.CellType == "Boolean" then
				display.Editable = false
				display:GetChild("DropdownBtn").Visible = true
				display.Keys = _blKey
				display.Items = _blItem
			elseif cell.CellType == "Advance" then
				display.Editable = false
				display:GetChild("DropdownBtn").Visible = true
				display.DropdownBtn.OnClick = display.DropdownBtn.OnClick + DropdownBtn_OnClick
			else
				display.Editable = false
				display:GetChild("DropdownBtn").Visible = false
			end
			display.Text = cell.Text
		else
			display.Editable = false
			display:GetChild("DropdownBtn").Visible = false
			display.Text = ""
		end
	end

	------------------------------------
	-- Column
	------------------------------------
	__Doc__[[Column object using in the DataGrid]]
	__AutoProperty__()
	class "Column"
		inherit "Button"

		-- Event
		--[[
		local function OnClick(self)
			if not self.Parent.__CanSort then
				return
			end

			if self == self.Parent.__SortColumn then
				self.SortReversed = not self.SortReversed

				return self:Fire("OnSortChanged")
			end

			if self.Parent.__SortColumn then
				self.Parent.__SortColumn:GetNormalTexture():Hide()
			end

			self.Parent.__SortColumn = self
			self.SortReversed = false

			return self:Fire("OnSortChanged")
		end--]]

		local function RefreshColumn(self, index, clear)
			local cell

			if clear then
				for i = 1, self.RowCount do
					cell = self:GetChild("Cell_"..i.."_"..index)

					cell.CellType = nil
				end

				return
			end

			-- Refresh Display
			for i = 1, self.Panel.__MaxRow do
				cell = self:GetChild("DisplayCell_"..i.."_"..index)

				if cell then
					RefreshCell(self, cell, cell.__Cell)
				end
			end
		end

		------------------------------------------------------
		-- Event
		------------------------------------------------------
		--event "OnSortChanged"

		------------------------------------------------------
		-- Method
		------------------------------------------------------

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		--[[ SortReversed
		property "SortReversed" {
			Set = function(self, flag)
				if (flag) then
					self:GetNormalTexture():Show();
					self:GetNormalTexture():SetTexCoord(0, 0.5625, 1.0, 0);
				else
					self:GetNormalTexture():Show();
					self:GetNormalTexture():SetTexCoord(0, 0.5625, 0, 1.0);
				end

				self.__SortReversed = (flag and true) or false
			end,

			Get = function(self)
				return (self.__SortReversed and true) or false
			end,

			Type = Boolean,
		}--]]

		__Doc__[[the column data field]]
		property "Field" {
			Set = function(self, field)
				self.__Field = field
			end,

			Get = function(self)
				return self.__Field
			end,

			Type = String,
		}

		__Doc__[[the default cell type of the column]]
		property "CellType" {
			Set = function(self, cellType)
				-- Check Style
				if not cellType then
					cellType = "Label"
				end

				self.__CellType = cellType
				if cellType ~= "ComboBox" then
					self.__Keys = nil
					self.__Items = nil
				end

				return RefreshColumn(self.Parent, self.Index, true)
			end,

			Get = function(self)
				return self.__CellType or "Label"
			end,

			Type = DataGridCellType,
		}

		__Doc__[[the default key list for the column's cells]]
		property "Keys" {
			Set = function(self, keys)
				if keys and type(keys) == "table" then
					self.__Keys = keys
				else
					self.__Keys = nil
				end

				if self.__Keys and self.__Items then
					return RefreshColumn(self.Parent, self.Index)
				end
			end,
			Get = function(self)
				return self.__Keys
			end,
			Type = Table,
		}

		__Doc__[[the default text list for the column's cells]]
		property "Items" {
			Set = function(self, items)
				if items and type(items) == "table" then
					self.__Items = items
				else
					self.__Items = nil
				end

				if self.__Keys and self.__Items then
					return RefreshColumn(self.Parent, self.Index)
				end
			end,
			Get = function(self)
				return self.__Items
			end,
			Type = Table,
		}

		__Doc__[[the column index]]
		property "Index" {
			Get = function(self)
				return tonumber(strmatch(self.Name, "(%d+)$"))
			end,
			Type = Number,
		}

		__Doc__[[the default back color for the column's cells]]
		property "BackColor" {
			Set = function(self, colorTable)
				self.__BackColor = colorTable

				return RefreshColumn(self.Parent, self.Index)
			end,

			Get = function(self)
				return self.__BackColor or _DefaultBackColor
			end,

			Type = ColorType,
		}

		__Doc__[[the column width]]
		property "ColumnWidth" {
			Set = function(self, percent)
				self.Parent:SetColumnWidth(self.Index, percent)
			end,
			Get = function(self)
				return self.Parent:GetColumnWidth(self.Index)
			end,
			Type = Number,
		}

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function Column(self, name, parent, ...)
			Super(self, name, parent, ...)

			local t = Texture("Left", self, "BACKGROUND")
			t:SetTexture([[Interface\FriendsFrame\WhoFrame-ColumnTabs]])
			t.Width = 5
			t:SetPoint("TOPLEFT", self, "TOPLEFT")
			t:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
			t:SetTexCoord(0, 0.078125, 0, 0.59375)

			t = Texture("Right", self, "BACKGROUND")
			t:SetTexture([[Interface\FriendsFrame\WhoFrame-ColumnTabs]])
			t.Width = 5
			t:SetPoint("TOPRIGHT", self, "TOPRIGHT")
			t:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
			t:SetTexCoord(0.90625, 0.96875, 0, 0.59375)

			t = Texture("Middle", self, "BACKGROUND")
			t:SetTexture([[Interface\FriendsFrame\WhoFrame-ColumnTabs]])
			t.Width = 5
			t:SetPoint("TOPLEFT", self.Left, "TOPRIGHT")
			t:SetPoint("BOTTOMRIGHT", self.Right, "BOTTOMLEFT")
			t:SetTexCoord(0.078125, 0.90625, 0, 0.59375)

			--[==[self:SetHighlightTexture([[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]])
            t = self:GetHighlightTexture()
            t:SetBlendMode("ADD")
            t:SetPoint("TOPLEFT",self,"TOPLEFT",2,-3)
            t:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-2,3)--]==]

			local f = FontString("ButtonText", self)
			self:SetFontString(f)
			f.JustifyH = "LEFT"
			f:SetPoint("LEFT", self, "LEFT", 8, 0)

			self:SetNormalFontObject("GameFontHighlightSmall")

			--[==[self:SetNormalTexture([[Interface\Buttons\UI-Panel-Button-Up]])
			t = self:GetNormalTexture()
			t.Visible = false
			t.Width = 9
			t.Height = 8
			t:ClearAllPoints()
			t:SetPoint("LEFT", f, "RIGHT", 3, -2)
			t:SetTexCoord(0, 0.5625, 0, 1.0)--]==]

			--self.OnClick = self.OnClick + OnClick

			self.__CellType = "Label"
			self.Locked = true
		end
	endclass "Column"

	------------------------------------
	-- Columns
	------------------------------------
	__Doc__[[
		<desc>Column accessor</desc>
		<usage>object.Columns(startColumn, endColumn).CellType = "number"</usage>
	]]
	__AutoProperty__()
	class "Columns"
		inherit "VirtualUIObject"

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[the columns width]]
		property "ColumnWidth" {
			Set = function(self, percent)
				if self.__StartCol then
					for j = self.__StartCol, self.__EndCol do
						if self.Parent:GetChild("Column"..j) then
							self.Parent:GetChild("Column"..j).ColumnWidth = percent
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartCol and self.__StartCol == self.__EndCol then
					return self.Parent:GetChild("Column"..self.__StartCol).ColumnWidth
				end

				error("Can't get the width percent for multi columns.", 2)
			end,
			Type = Number,
		}

		__Doc__[[the columns text]]
		property "Text" {
			Set = function(self, text)
				if self.__StartCol then
					for j = self.__StartCol, self.__EndCol do
						if self.Parent:GetChild("Column"..j) then
							self.Parent:GetChild("Column"..j).Text = text
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartCol and self.__StartCol == self.__EndCol then
					return self.Parent:GetChild("Column"..self.__StartCol).Text
				end

				error("Can't get the text for multi columns.", 2)
			end,
			Type = LocaleString,
		}

		__Doc__[[the columns data field]]
		property "Field" {
			Set = function(self, field)
				if self.__StartCol then
					for j = self.__StartCol, self.__EndCol do
						if self.Parent:GetChild("Column"..j) then
							self.Parent:GetChild("Column"..j).Field = field
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartCol and self.__StartCol == self.__EndCol then
					return self.Parent:GetChild("Column"..self.__StartCol).Field
				end

				error("Can't get the field for multi columns.", 2)
			end,
			Type = String,
		}

		__Doc__[[the columns default cell type for cells]]
		property "CellType" {
			Set = function(self, cellType)
				if self.__StartCol then
					for j = self.__StartCol, self.__EndCol do
						if self.Parent:GetChild("Column"..j) then
							self.Parent:GetChild("Column"..j).CellType = cellType
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartCol and self.__StartCol == self.__EndCol then
					return self.Parent:GetChild("Column"..self.__StartCol).CellType
				end

				error("Can't get the cellType for multi columns.", 2)
			end,
			Type = DataGridCellType,
		}

		__Doc__[[the columns default key list for cells]]
		property "Keys" {
			Set = function(self, keys)
				if self.__StartCol then
					for j = self.__StartCol, self.__EndCol do
						if self.Parent:GetChild("Column"..j) then
							self.Parent:GetChild("Column"..j).Keys = keys
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartCol and self.__StartCol == self.__EndCol then
					return self.Parent:GetChild("Column"..self.__StartCol).Keys
				end

				error("Can't get the keys for multi columns.", 2)
			end,
			Type = Table,
		}

		__Doc__[[the columns defalut item list for cells]]
		property "Items" {
			Set = function(self, items)
				if self.__StartCol then
					for j = self.__StartCol, self.__EndCol do
						if self.Parent:GetChild("Column"..j) then
							self.Parent:GetChild("Column"..j).Items = items
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartCol and self.__StartCol == self.__EndCol then
					return self.Parent:GetChild("Column"..self.__StartCol).Items
				end

				error("Can't get the items for multi columns.", 2)
			end,
			Type = Table,
		}

		__Doc__[[the columns default backColor for cells]]
		property "BackColor" {
			Set = function(self, color)
				if self.__StartCol then
					for j = self.__StartCol, self.__EndCol do
						if self.Parent:GetChild("Column"..j) then
							self.Parent:GetChild("Column"..j).BackColor = color
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartCol and self.__StartCol == self.__EndCol then
					return self.Parent:GetChild("Column"..self.__StartCol).BackColor
				end

				error("Can't get the backColor for multi columns.", 2)
			end,
			Type = ColorType,
		}

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------

		------------------------------------------------------
		-- __call
		------------------------------------------------------
		function __call(self, startCol, endCol)
			if not startCol or type(startCol) ~= "number" or startCol < 1 or startCol > self.Parent.ColumnCount or
				(endCol and (type(endCol) ~= "number" or endCol < startCol or endCol > self.Parent.ColumnCount)) then
				error("No such columns", 2)
			end

			self.__StartCol = startCol
			self.__EndCol = endCol or startCol

			return self
		end
	endclass "Columns"

	------------------------------------
	-- Cell
	------------------------------------
	__Doc__[[Cell object in the DataGrid]]
	__AutoProperty__()
	class "Cell"
		inherit "VirtualUIObject"

		-- Event
		local function Refresh(self)
			if self.RowIndex >= self.Parent.TopRow and self.RowIndex < self.Parent.TopRow + self.Parent.Panel.__MaxRow then
				RefreshCell(self.Parent, self.Parent.Panel:GetChild("DisplayCell_"..(self.RowIndex - self.Parent.TopRow + 1).."_"..self.ColumnIndex), self)
			end
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[the cell type]]
		property "CellType" {
			Set = function(self, cellType)
				self.__CellType = cellType
				if cellType ~= "ComboBox" then
					self.__Keys = nil
					self.__Items = nil
				end

				return Refresh(self)
			end,

			Get = function(self)
				return self.__CellType or self.Parent:GetChild("Column"..self.ColumnIndex).CellType
			end,

			Type = DataGridCellType,
		}

		__Doc__[[the cell value]]
		property "Value" {
			Set = function(self, value)
				if self.__Value == value then
					return
				end

				if self.CellType == "Number" then
					self.__Value = tonumber(value)
					self.__Text = tostring(value)
				elseif self.CellType == "Boolean" then
					self.__Value = (value and true) or false
					self.__Text = tostring(self.__Value)
				elseif self.CellType == "Advance" then
					self.__Value = value
				elseif self.CellType ~= "ComboBox" then
					self.__Value = value
					self.__Text = tostring(value)
				else
					local text = ""
					if value then
						for i,k in ipairs(self.Keys or {}) do
							if k == value then
								text = self.Items[i] or ""
								break
							end
						end

						self.__Value = value
						self.__Text = text
					else
						self.__Value = nil
						self.__Text = ""
					end
				end

				self.Parent:Fire("OnCellValueChanged", self.RowIndex, self.ColumnIndex, self.__Value)
				self.Parent:Fire("OnCellTextChanged",  self.RowIndex, self.ColumnIndex, self.__Text)

				return Refresh(self)
			end,

			Get = function(self)
				if self.CellType == "Number" then
					return self.__Value or 0
				elseif self.CellType == "Boolean" then
					return (self.__Value and true) or false
				elseif self.CellType == "Advance" then
					return self.__Value
				elseif self.CellType ~= "ComboBox" then
					return tostring(self.__Value or "")
				else
					return self.__Value
				end
			end,

			Type = Any,
		}

		__Doc__[[the cell text]]
		property "Text" {
			Set = function(self, text)
				if not text or type(text) ~= "string" or self.__Text == strtrim(text) then
					return
				end

				text = strtrim(text)

				if self.CellType == "Number" then
					self.__Value = tonumber(text)
					self.__Text = text
				elseif self.CellType == "Boolean" then
					self.__Value = (strupper(tostring(text)) == "TRUE" and true) or false
					self.__Text = (self.__Value and "True") or "False"
				elseif self.CellType ~= "ComboBox" then
					self.__Value = text
					self.__Text = text
				else
					local value

					for i,t in ipairs(self.Items or {}) do
						if t == text then
							value = self.Keys[i]
							break
						end
					end

					self.__Value = value
					self.__Text = text
				end

				self.Parent:Fire("OnCellValueChanged", self.RowIndex, self.ColumnIndex, self.__Value)
				self.Parent:Fire("OnCellTextChanged",  self.RowIndex, self.ColumnIndex, self.__Text)

				return Refresh(self)
			end,

			Get = function(self)
				if self.CellType == "Number" then
					return self.__Text or "0"
				elseif self.CellType == "Boolean" then
					return (self.__Value and "True") or "False"
				elseif self.CellType == "Advance" then
					return self.__Text or ""
				elseif self.CellType ~= "ComboBox" then
					return self.__Text or ""
				else
					return self.__Text or ""
				end
			end,

			Type = LocaleString,
		}

		__Doc__[[the cell's key list]]
		property "Keys" {
			Set = function(self, keys)
				if keys and type(keys) == "table" then
					self.__Keys = keys
				else
					self.__Keys = nil
				end

				if self.__Keys and self.__Items then
					return Refresh(self)
				end
			end,
			Get = function(self)
				return (self.__CellType and self.__Keys) or self.Parent:GetChild("Column"..self.ColumnIndex).Keys
			end,
			Type = Table,
		}

		__Doc__[[the cell's item list]]
		property "Items" {
			Set = function(self, items)
				if items and type(items) == "table" then
					self.__Items = items
				else
					self.__Items = nil
				end

				if self.__Keys and self.__Items then
					return Refresh(self)
				end
			end,
			Get = function(self)
				return (self.__CellType and self.__Items) or self.Parent:GetChild("Column"..self.ColumnIndex).Items
			end,
			Type = Table,
		}

		__Doc__[[the cell's row index]]
		property "RowIndex" {
			Get = function(self)
				return tonumber(strmatch(self.Name, "(%d+)"))
			end,
			Type = Number,
		}

		__Doc__[[the cell's column index]]
		property "ColumnIndex" {
			Get = function(self)
				return tonumber(strmatch(self.Name, "(%d+)$"))
			end,
			Type = Number,
		}

		__Doc__[[the cell's backColor]]
		property "BackColor" {
			Set = function(self, colorTable)
				self.__BackColor = colorTable
				return Refresh(self)
			end,

			Get = function(self)
				return self.__BackColor or self.Parent:GetChild("Column"..self.ColumnIndex).BackColor
			end,

			Type = ColorType,
		}

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	endclass "Cell"

	------------------------------------
	-- Cells
------------------------------------
	__Doc__[[
		<desc>Cells accessor</desc>
		<usage>
			object.Cells(startRow, startColumn, endRow, endColumn).CellType = "number"
			object.Cells(row, column).CellType = "number"
		</usage>
	]]
	__AutoProperty__()
	class "Cells"
		inherit "VirtualUIObject"

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[the cells type]]
		property "CellType" {
			Set = function(self, cellType)
				if self.__StartRow and self.__StartCol then
					for i = self.__StartRow, self.__EndRow do
						for j = self.__StartCol, self.__EndCol do
							if self.Parent:GetChild("Cell_"..i.."_"..j) then
								self.Parent:GetChild("Cell_"..i.."_"..j).CellType = cellType
							end
						end
					end
				end
			end,

			Get = function(self)
				if self.__StartRow and self.__StartCol and self.__StartRow == self.__EndRow and self.__StartCol == self.__EndCol then
					if self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol) then
						return self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol).CellType
					end
				end

				error("Can't get the celltype for multi cells.", 2)
			end,

			Type = DataGridCellType,
		}

		__Doc__[[the cells value]]
		property "Value" {
			Set = function(self, value)
				if self.__StartRow and self.__StartCol then
					for i = self.__StartRow, self.__EndRow do
						for j = self.__StartCol, self.__EndCol do
							if self.Parent:GetChild("Cell_"..i.."_"..j) then
								self.Parent:GetChild("Cell_"..i.."_"..j).Value = value
							end
						end
					end
				end
			end,

			Get = function(self)
				if self.__StartRow and self.__StartCol and self.__StartRow == self.__EndRow and self.__StartCol == self.__EndCol then
					if self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol) then
						return self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol).Value
					end
				end

				error("Can't get the value for multi cells.", 2)
			end,

			Type = Any,
		}

		__Doc__[[the cells text]]
		property "Text" {
			Set = function(self, text)
				if self.__StartRow and self.__StartCol then
					for i = self.__StartRow, self.__EndRow do
						for j = self.__StartCol, self.__EndCol do
							if self.Parent:GetChild("Cell_"..i.."_"..j) then
								self.Parent:GetChild("Cell_"..i.."_"..j).Text = text
							end
						end
					end
				end
			end,

			Get = function(self)
				if self.__StartRow and self.__StartCol and self.__StartRow == self.__EndRow and self.__StartCol == self.__EndCol then
					if self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol) then
						return self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol).Text
					end
				end

				error("Can't get the text for multi cells.", 2)
			end,

			Type = LocaleString,
		}

		__Doc__[[the key list for the cells]]
		property "Keys" {
			Set = function(self, keys)
				if self.__StartRow and self.__StartCol then
					for i = self.__StartRow, self.__EndRow do
						for j = self.__StartCol, self.__EndCol do
							if self.Parent:GetChild("Cell_"..i.."_"..j) then
								self.Parent:GetChild("Cell_"..i.."_"..j).Keys = keys
							end
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartRow and self.__StartCol and self.__StartRow == self.__EndRow and self.__StartCol == self.__EndCol then
					if self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol) then
						return self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol).Keys
					end
				end

				error("Can't get the keys for multi cells.", 2)
			end,
			Type = Table,
		}

		__Doc__[[the text list for the cells]]
		property "Items" {
			Set = function(self, items)
				if self.__StartRow and self.__StartCol then
					for i = self.__StartRow, self.__EndRow do
						for j = self.__StartCol, self.__EndCol do
							if self.Parent:GetChild("Cell_"..i.."_"..j) then
								self.Parent:GetChild("Cell_"..i.."_"..j).Items = items
							end
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartRow and self.__StartCol and self.__StartRow == self.__EndRow and self.__StartCol == self.__EndCol then
					if self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol) then
						return self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol).Items
					end
				end

				error("Can't get the items for multi cells.", 2)
			end,
			Type = Table,
		}

		__Doc__[[the backColor for the cells]]
		property "BackColor" {
			Set = function(self, colorTable)
				if self.__StartRow and self.__StartCol then
					for i = self.__StartRow, self.__EndRow do
						for j = self.__StartCol, self.__EndCol do
							if self.Parent:GetChild("Cell_"..i.."_"..j) then
								self.Parent:GetChild("Cell_"..i.."_"..j).BackColor = colorTable
							end
						end
					end
				end
			end,
			Get = function(self)
				if self.__StartRow and self.__StartCol and self.__StartRow == self.__EndRow and self.__StartCol == self.__EndCol then
					if self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol) then
						return self.Parent:GetChild("Cell_"..self.__StartRow.."_"..self.__StartCol).BackColor
					end
				end

				error("Can't get the back-color for multi cells.", 2)
			end,
			Type = ColorType,
		}

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------

		------------------------------------------------------
		-- __call
		------------------------------------------------------
		function __call(self, startRow, startCol, endRow, endCol)
			if not startRow or type(startRow) ~= "number" or startRow < 1 or startRow > self.Parent.RowCount or
				not startCol or type(startCol) ~= "number" or startCol < 1 or startCol > self.Parent.ColumnCount or
				(endRow and (type(endRow) ~= "number" or endRow < startRow or endRow > self.Parent.RowCount)) or
				(endCol and (type(endCol) ~= "number" or endCol < startCol or endCol > self.Parent.ColumnCount)) then
				error("No such cells", 2)
			end

			self.__StartRow = startRow
			self.__StartCol = startCol
			self.__EndRow = endRow or startRow
			self.__EndCol = endCol or startCol

			return self
		end
	endclass "Cells"

	-- Event
	local function Column_OnSortChanged(self)

	end

	local function DisplayCell_OnEditFocusGained(self)
		--self.Parent.__ActiveCell = self.__Cell
		local text = self:GetChild("Text").Text or ""
		self:GetChild("Text"):HighlightText(0, text:len())
	end

	local function DisplayCell_OnEditFocusLost(self)
		if self.__Cell then
			self.__Cell.Text = self.Text
		end
	end

	local function DisplayCell_OnValueChanged(self)
		if self.__Cell then
			self.__Cell.Text = self.Text
		end
	end

	local function DisplayCell_OnSizeChanged(self)
		-- to fix the disappear text error
		self:GetTextObject().CursorPosition = 0
	end

	local function DisplayCellText_OnEnter(self)
		if self.Parent.__Cell then
			self.Parent.__Cell.Parent:Fire("OnCellEnter", self.Parent.__Cell.RowIndex, self.Parent.__Cell.ColumnIndex)
		end
	end

	local function DisplayCellText_OnLeave(self)
		if self.Parent.__Cell then
			self.Parent.__Cell.Parent:Fire("OnCellLeave", self.Parent.__Cell.RowIndex, self.Parent.__Cell.ColumnIndex)
		end
	end

	local function DisplayCell_OnEnter(self)
		if not self.Editable and self.__Cell then
			self.__Cell.Parent:Fire("OnCellEnter", self.__Cell.RowIndex, self.__Cell.ColumnIndex)
		end
	end

	local function DisplayCell_OnLeave(self)
		if not self.Editable and self.__Cell then
			self.__Cell.Parent:Fire("OnCellLeave", self.__Cell.RowIndex, self.__Cell.ColumnIndex)
		end
	end

	local function RefreshColumn(self)
		local width = self.Panel.Width
		local lastWidth = width

		self.__ColumnWidth = self.__ColumnWidth or {}

		for i = 1, #(self.__ColumnWidth) - 1 do
			self:GetChild("Column"..i).Width = width * self.__ColumnWidth[i] / 100
			lastWidth = lastWidth - self:GetChild("Column"..i).Width
		end

		self:GetChild("Column"..tostring(#(self.__ColumnWidth))).Width = lastWidth
	end

	local function Refresh(self)
		local Panel = self.Panel
		local scrollbar = self.ScrollBar
		local row, col = Panel.__DisplayItemCount or 0, self.ColumnCount
		local cell, column

		-- Refresh cells
		Panel.__MaxCellRow = Panel.__MaxCellRow or 0
		Panel.__MaxCellCol = Panel.__MaxCellCol or 0

		for i = 1, Panel.__MaxCellRow do
			for j = 1, Panel.__MaxCellCol do
				if i > self.RowCount or j > col then
					cell = self:GetChild("Cell_"..i.."_"..j)

					if cell then
						cell:Dispose()
					end
				end
			end
		end

		for i = 1, self.RowCount do
			for j = 1, col do
				cell = Cell("Cell_"..i.."_"..j, self)
			end
		end

		Panel.__MaxCellRow = self.RowCount
		Panel.__MaxCellCol = col

		-- Refresh Displayed items
		Panel.__MaxRow = Panel.__MaxRow or 0
		Panel.__MaxCol = Panel.__MaxCol or 0

		for j = 1, Panel.__MaxCol do
			for i = 1, Panel.__MaxRow do
				if i > row or j > col then
					cell = Panel:GetChild("DisplayCell_"..i.."_"..j)

					if cell then
						cell:Dispose()
					end
				elseif i > self.RowCount then
					cell = Panel:GetChild("DisplayCell_"..i.."_"..j)

					if cell then
						cell.Visible = false
					end
				end
			end
		end

		for j = 1, col do
			column = self:GetChild("Column"..j)
			for i = 1, min(row, self.RowCount) do
				if not Panel:GetChild("DisplayCell_"..i.."_"..j) then
					cell = ComboBox("DisplayCell_"..i.."_"..j, Panel)

					cell:SetBackdrop(_FrameBackdrop)
					cell:SetPoint("TOP", Panel, "TOP", 0, - (i - 1) * _Height)
					cell:SetPoint("LEFT", column, "LEFT")
					cell:SetPoint("RIGHT", column, "RIGHT")
					cell.Height = _Height
					cell.Editable = false
					cell:GetChild("DropdownBtn").Visible = false
					cell.OnEditFocusLost = DisplayCell_OnEditFocusLost
					cell.OnSizeChanged = DisplayCell_OnSizeChanged
					cell.OnEditFocusGained = DisplayCell_OnEditFocusGained
					cell.OnValueChanged = DisplayCell_OnValueChanged
					cell:GetChild("Text").OnEnter = DisplayCellText_OnEnter
					cell:GetChild("Text").OnLeave = DisplayCellText_OnLeave
					cell.OnEnter = DisplayCell_OnEnter
					cell.OnLeave = DisplayCell_OnLeave
					cell.Text = ""
				else
					Panel:GetChild("DisplayCell_"..i.."_"..j).Visible = true
				end
			end
		end

		Panel.__MaxRow = row
		Panel.__MaxCol = col

		-- Scroll Bar
		if self.RowCount > row then
			local value = scrollbar.Value

			scrollbar:SetMinMaxValues(1, self.RowCount - row + 1)
			scrollbar.Visible = true

			if value > self.RowCount - row + 1 then
				scrollbar.value = self.RowCount - row + 1
			end
		else
			scrollbar:SetMinMaxValues(1, 1)
			scrollbar.Visible = false
			scrollbar.Value = 1
		end

		scrollbar:Fire("OnValueChanged")
	end

	local function OnSizeChanged(self)
		local cnt = math.ceil((self.Height - 12) / _Height)

		if cnt > 0 and cnt ~= self.__DisplayItemCount then
			self.__DisplayItemCount = cnt
			Refresh(self.Parent)
		end

		RefreshColumn(self.Parent)
	end

	local function OnValueChanged(self)
		local parent = self.Parent
		local value = self.Value - 1
		local Panel = parent.Panel

		for j = 1, Panel.__MaxCol or 0 do
			for i = 1, Panel.__MaxRow or 0 do
				if Panel:GetChild("DisplayCell_"..i.."_"..j) then
					Panel:GetChild("DisplayCell_"..i.."_"..j).Focused = false
					RefreshCell(parent, Panel:GetChild("DisplayCell_"..i.."_"..j), parent:GetChild("Cell_"..(value + i).."_"..j))
				end
			end
		end
	end

	local function OnMouseWheel(self, delta)
		local scrollBar = self.Parent:GetChild("ScrollBar")
		local iMin, iMax = scrollBar:GetMinMaxValues()
		local iPos = scrollBar:GetValue()
		local step = scrollBar.ValueStep
		local btnC = self.__MaxRow

		if delta > 0 then
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
		elseif delta < 0 then
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

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Fired when a cell's value is changed</desc>
		<param name="row">number, the cell's row index</param>
		<param name="column">number, the cell's column index</param>
		<param name="value">any</param>
	]]
	event "OnCellValueChanged"

	__Doc__[[
		<desc>Fired when a cells's text is changed</desc>
		<param name="row">number, the cell's row index</param>
		<param name="column">number, the cell's column index</param>
		<param name="text">string</param>
	]]
	event "OnCellTextChanged"

	__Doc__[[
		<desc>Fired when click the cell's dropdownbutton and this cell's celltype is 'advance'</desc>
		<param name="row">number, the cell's row index</param>
		<param name="column">number, the cell's column index</param>
	]]
	event "OnAdvance"

	__Doc__[[
		<desc>Fired when cursor move into the cell</desc>
		<param name="row">number, the cell's row index</param>
		<param name="column">number, the cell's column index</param>
	]]
	event "OnCellEnter"

	__Doc__[[
		<desc>Fired when the cursor move out the cell</desc>
		<param name="row">number, the cell's row index</param>
		<param name="column">number, the cell's column index</param>
	]]
	event "OnCellLeave"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Set a column's label</desc>
		<param name="index">number, the column's index</param>
		<param name="text">string, the column's label</param>
	]]
	function SetColumnLabel(self, index, label)
		if not index or type(index) ~= "number" then
			error("the column index is not set.", 2)
		end

		if not self:GetChild("Column"..index) then
			error("the column is not exist.", 2)
		end

		self:GetChild("Column"..index).Text = tostring(label or "")
	end

	__Doc__[[
		<desc>Return the column's label</desc>
		<param name="index">number, the column's index</param>
		<return type="string"></return>
	]]
	function GetColumnLabel(self, index)
		if not index or type(index) ~= "number" then
			error("the column index is not set.", 2)
		end

		if not self:GetChild("Column"..index) then
			error("the column is not exist.", 2)
		end

		return self:GetChild("Column"..index).Text
	end

	__Doc__[[
		<desc>Set the column's count</desc>
		<param name="count">number</param>
	]]
	function SetColumnCount(self, count)
		local btn
		local splitWidth

		if not count or type(count) ~= "number" then
			error("the column count must be a number.", 2)
		end

		if count < 1 then
			error("the column count can't be less than 1.", 2)
		end

		count = floor(count)

		self.__ColumnWidth = self.__ColumnWidth or {}

		if #(self.__ColumnWidth) == count then
			return
		end

		-- Remove additional columns
		for i = getn(self.__ColumnWidth), count + 1, -1 do
			btn = self:GetChild("Column"..i)
			if btn then
				btn:Dispose()

				-- Modify the column width settings
				self.__ColumnWidth[i - 1] = self.__ColumnWidth[i - 1] + self.__ColumnWidth[i]
				self.__ColumnWidth[i] = nil
			end
		end

		for i=1, count do
			if not self:GetChild("Column"..i) then
				if not splitWidth then
					if i > 1 then
						splitWidth = ((i == 1 and 100) or self.__ColumnWidth[i - 1]) / (count - i + 2)
					else
						splitWidth = 100 / count
					end

					if i > 1 then
						self.__ColumnWidth[i - 1] = splitWidth

						btn = self:GetChild("Column"..(i-1))

						btn:ClearAllPoints()

						if i - 1 == 1 then
							btn:SetPoint("TOPLEFT", self, "TOPLEFT")
							btn:SetPoint("BOTTOMLEFT", self.Panel, "TOPLEFT")
						else
							btn:SetPoint("TOPLEFT", self:GetChild("Column"..(i-2)), "TOPRIGHT")
							btn:SetPoint("BOTTOMLEFT", self:GetChild("Column"..(i-2)), "BOTTOMRIGHT")
						end
					end
				end

				btn = Column("Column"..i, self)

				btn.__CellType = "Label"

				self.__ColumnWidth[i] = splitWidth

				if i == 1 then
					btn:SetPoint("TOPLEFT", self, "TOPLEFT")
					btn:SetPoint("BOTTOMLEFT", self.Panel, "TOPLEFT")
				else
					btn:SetPoint("TOPLEFT", self:GetChild("Column"..(i-1)), "TOPRIGHT")
					btn:SetPoint("BOTTOMLEFT", self:GetChild("Column"..(i-1)), "BOTTOMRIGHT")
				end

				if i == count then
					btn:SetPoint("BOTTOMRIGHT", self.Panel, "TOPRIGHT")
				end
			end
		end

		RefreshColumn(self)
		Refresh(self)
	end

	__Doc__[[
		<desc>Return the column's count</desc>
		<return type="number"></return>
	]]
	function GetColumnCount(self)
		return (self.__ColumnWidth and getn(self.__ColumnWidth)) or 0
	end

	__Doc__[[
		<desc>Set one column's width</desc>
		<param name="index">number, the column's index</param>
		<param name="percent">number, 1-100, the width percent</param>
	]]
	function SetColumnWidth(self, index, percent)
		self.__ColumnWidth = self.__ColumnWidth or {}

		if not index or type(index) ~= "number" then
			error("the column index is not set.", 2)
		end

		if not self:GetChild("Column"..index) then
			error("the column is not exist.", 2)
		end

		if not percent or type(percent) ~= "number" or percent < 1 or percent > 100 then
			error("the percent must be 1 - 100.", 2)
		end

		if index == getn(self.__ColumnWidth) then
			error("no need to set the last column.", 2)
		end

		if percent > self.__ColumnWidth[index] and self.__ColumnWidth[getn(self.__ColumnWidth)] - 1 < percent - self.__ColumnWidth[index] then
			error("percent can't be more than "..(self.__ColumnWidth[getn(self.__ColumnWidth)] - 1), 2)
		end
		self.__ColumnWidth[getn(self.__ColumnWidth)] = self.__ColumnWidth[getn(self.__ColumnWidth)] + self.__ColumnWidth[index] - percent
		self.__ColumnWidth[index] = percent

		RefreshColumn(self)
	end

	__Doc__[[
		<desc>Return the column's width percent</desc>
		<param name="index">number the column's index</param>
		<return type="number">the width percent</return>
	]]
	function GetColumnWidth(self, index)
		self.__ColumnWidth = self.__ColumnWidth or {}

		return self.__ColumnWidth[index]
	end

	__Doc__[[
		<desc>description</desc>
		<format>row, column, cellType[, keyList, itemList]</format>
		<param name="row">number, the cell's row index</param>
		<param name="column">number, the cell's column index</param>
		<param name="cellType">System.Widget.DataGrid.DataGridCellType</param>
		<param name="keyList">table, key values</param>
		<param name="itemList">table, label string for each value</param>
	]]
	function SetCellType(self, row, column, cellType, keyList, itemList)
		local prefix = "object:SetCellType(row, column, cellType[, keyList, itemList]) - "

		row = Reflector.Validate(Number, row, "row", prefix)
		column = Reflector.Validate(Number, column, "column", prefix)
		cellType = Reflector.Validate(DataGridCellType, cellType, "cellType", prefix)

		local cell = self:GetChild("Cell_"..row.."_"..column)

		if not cell then
			error(prefix .. "No such cell.", 2)
		end

		cell.CellType = cellType
		cell.Keys, cell.Items = ConvertLst(keyList, itemList)
	end

	__Doc__[[
		<desc>Return the cell's celltype</desc>
		<param name="row">number, the cell's row index</param>
		<param name="column">number, the cell's column index</param>
		<return type="System.Widget.DataGrid.DataGridCellType"></return>
	]]
	function GetCellType(self, row, column)
		if not row or not column or type(row)~= "number" or type(column) ~= "number" then
			error("No such cell.", 2)
		end

		local cell = self:GetChild("Cell_"..row.."_"..column)

		if not cell then
			error("No such cell.", 2)
		end

		return cell.CellType
	end

	__Doc__[[
		<desc>Set the column's default cellType</desc>
		<format>column, cellType[, keyList, itemList]</format>
		<param name="column">number, the column index</param>
		<param name="cellType">System.Widget.DataGrid.DataGridCellType</param>
		<param name="keyList">table, key values</param>
		<param name="itemList">table, label string for each value</param>
	]]
	function SetColumnCellType(self, index, cellType, keyList, itemList)
		local prefix = "object:SetColumnCellType(column, cellType[, keyList, itemList]) - "

		index = Reflector.Validate(Number, index, "column", prefix)
		cellType = Reflector.Validate(DataGridCellType, cellType, "cellType", prefix)

		local column = self:GetChild("Column"..index)

		if not column then
			error(prefix .. "No such column.", 2)
		end

		column.CellType = cellType
		column.Keys, column.Items = ConvertLst(keyList, itemList)
	end

	__Doc__[[
		<desc>Return the colunn's defalut celltype</desc>
		<param name="column">number, the column index</param>
		<return type="System.Widget.DataGrid.DataGridCellType"></return>
	]]
	function GetColumnCellType(self, index)
		local column = self:GetChild("Column"..index)

		if not column then
			error("No such column.", 2)
		end

		return column.CellType
	end

	__Doc__[[
		<desc>Set the row count</desc>
		<param name="count">number, the row count</param>
	]]
	function SetRowCount(self, count)
		if not count or type(count) ~= "number" then
			error("the column count must be a number.", 2)
		end

		if count < 0 then
			error("the column count can't be less than 0.", 2)
		end

		self.__RowCount = count

		Refresh(self)
	end

	__Doc__[[
		<desc>Return the row count</desc>
		<return type="number"></return>
	]]
	function GetRowCount(self)
		return self.__RowCount or 0
	end

	__Doc__[[
		<desc>Set the cell's value</desc>
		<param name="row">number, the row index</param>
		<param name="column">number, the column index</param>
		<param name="value">any</param>
	]]
	function SetCellValue(self, row, column, value)
		local prefix = "object:SetCellValue(row, column, value) - "

		row = Reflector.Validate(Number, row, "row", prefix)
		column = Reflector.Validate(Number, column, "column", prefix)

		local cell = self:GetChild("Cell_"..row.."_"..column)

		if not cell then
			error(prefix .. "No such cell.", 2)
		end

		cell.Value = value
	end

	__Doc__[[
		<desc>Return the cell's value</desc>
		<param name="row">number, the row index</param>
		<param name="column">number, the column index</param>
		<return type="value">any</return>
	]]
	function GetCellValue(self, row, column)
		if not row or not column or type(row)~= "number" or type(column) ~= "number" then
			error("No such cell.", 2)
		end

		local cell = self:GetChild("Cell_"..row.."_"..column)

		if not cell then
			error("No such cell.", 2)
		end

		return cell.Value
	end

	__Doc__[[
		<desc>Return the column object</desc>
		<param name="column">number, the column index</param>
		<return type="System.Widget.DataGrid.Column"></return>
	]]
	function GetColumn(self, index)
		local column = self:GetChild("Column"..index)

		if not column then
			error("No such column.", 2)
		end

		return column
	end

	__Doc__[[
		<desc>Get the cell object</desc>
		<param name="row">number, the row index</param>
		<param name="column">number, the column index</param>
		<return type="System.Widget.DataGrid.Cell"></return>
	]]
	function GetCell(self, row, column)
		if not row or not column or type(row)~= "number" or type(column) ~= "number" then
			error("No such cell.", 2)
		end

		local cell = self:GetChild("Cell_"..row.."_"..column)

		if not cell then
			error("No such cell.", 2)
		end

		return cell
	end

	__Doc__[[
		<desc>Set the data source</desc>
		<param name="datasource">table, datatable like {{filed1=value1, field2=value2}, {...}}</param>
	]]
	function SetDataSource(self, ds)
		if ds and type(ds) ~= "table" then
			error("The data source must be a table", 2)
		end

		for _, item in ipairs(ds) do
			if type(item) ~= "table" then
				error("The data item must be a table", 2)
			end
		end

		-- Refresh
		self:SetRowCount(getn(ds))

		-- Refesh Data
		local cell, field

		for j = 1, self.ColumnCount do
			field = self:GetColumn(j).Field

			if field then
				for i = 1, self.RowCount do
					cell = Cell("Cell_"..i.."_"..j, self)

					cell.Value = ds[i][field]
				end
			end
		end
	end

	__Doc__[[
		<desc>Save data to datasource</desc>
		<param name="datasource">table</param>
	]]
	function SaveDataSource(self, ds)
		if ds and type(ds) ~= "table" then
			error("The data source must be a table", 2)
		end

		-- Refesh Data
		local cell, field

		for i = getn(ds) + 1, self.RowCount do
			ds[i] = {}
		end

		for i = self.RowCount + 1, getn(ds) do
			ds[i] = nil
		end

		for i = 1, self.RowCount do
			if not ds[i] or type(ds[i]) ~= "table" then
				ds[i] = {}
			end

			for j = 1, self.ColumnCount do
				field = self:GetColumn(j).Field

				if field then
					cell = Cell("Cell_"..i.."_"..j, self)

					ds[i][field] = cell.Value
				end
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the row count]]
	property "RowCount" {
		Set = function(self, cnt)
			self:SetRowCount(cnt)
		end,

		Get = function(self)
			return self:GetRowCount()
		end,

		Type = Number,
	}

	__Doc__[[the column count]]
	property "ColumnCount" {
		Set = function(self, cnt)
			self:SetColumnCount(cnt)
		end,

		Get = function(self)
			return self:GetColumnCount()
		end,

		Type = Number,
	}

	__Doc__[[the top row index show now]]
	property "TopRow" {
		Set = function(self, row)
			local minV, maxV = self.ScrollBar:GetMinMaxValues()

			if not row or type(row) ~= "number" then
				return
			end

			if row > maxV then
				row = maxV
			elseif row < minV then
				row = minV
			end

			self.ScrollBar.Value = row
		end,

		Get = function(self)
			return self.ScrollBar.Value
		end,

		Type = Number,
	}

	__Doc__[[the cells accessor]]
	property "Cells" {
		Get = function(self)
			return Cells("Cells", self)
		end,

		Type = Cells,
	}

	__Doc__[[the columns accessor]]
	property "Columns" {
		Get = function(self)
			return Columns("Columns", self)
		end,

		Type = Columns,
	}
	--[[ CanSort
	property "CanSort" {
		Set = function(self, can)
			self.__CanSort = (can and true) or false
		end,

		Get = function(self)
			return self.__CanSort
		end,

		Type = Boolean,
	}--]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function DataGrid(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Visible = true
		self:ClearAllPoints()
		self:SetBackdropColor(0, 0, 0, 1)

		-- Scroll Bar
		local scrollBar = ScrollBar("ScrollBar", self)
		scrollBar:Hide()

		-- Panel
		local Panel = Frame("Panel", self)
		Panel.MouseWheelEnabled = true
		Panel:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -26)
		Panel:SetPoint("BOTTOM", self, "BOTTOM")
		Panel:SetPoint("RIGHT", scrollBar, "LEFT")

		-- Event Handler
		scrollBar.OnValueChanged = OnValueChanged
		Panel.OnSizeChanged = OnSizeChanged
		Panel.OnMouseWheel = OnMouseWheel

		self.__CanSort = false
	end
endclass "DataGrid"
