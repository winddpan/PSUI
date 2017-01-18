-- Author      : Kurapica
-- Create Date : 2013/07/22
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.IFSecurePanel", version) then
	return
end

import "System.Collections"

-------------------------------------
-- Secure Manager
-------------------------------------
do
	-- Manager Frame
	_IFSecurePanel_ManagerFrame = SecureFrame("IGAS_IFSecurePanel_Manager", IGAS.UIParent)
	_IFSecurePanel_ManagerFrame.Visible = false

	_IFSecurePanel_ManagerFrame:Execute[[
		Manager = self

		IFSecurePanel_Panels = newtable()
		IFSecurePanel_Cache = newtable()
		IFSecurePanel_Map = newtable()

		UpdatePanelSize = [=[
			local noForce = ...
			local panel = IFSecurePanel_Map[self] or self
			local elements = IFSecurePanel_Panels[panel]
			local count = 0

			local row
			local column
			local columnCount = panel:GetAttribute("IFSecurePanel_ColumnCount") or 99
			local rowCount = panel:GetAttribute("IFSecurePanel_RowCount") or 99
			local elementWidth = panel:GetAttribute("IFSecurePanel_ElementWidth") or 16
			local elementHeight = panel:GetAttribute("IFSecurePanel_ElementHeight") or 16
			local hSpacing = panel:GetAttribute("IFSecurePanel_HSpacing") or 0
			local vSpacing = panel:GetAttribute("IFSecurePanel_VSpacing") or 0
			local marginTop = panel:GetAttribute("IFSecurePanel_MarginTop") or 0
			local marginBottom = panel:GetAttribute("IFSecurePanel_MarginBottom") or 0
			local marginLeft = panel:GetAttribute("IFSecurePanel_MarginLeft") or 0
			local marginRight = panel:GetAttribute("IFSecurePanel_MarginRight") or 0
			local orientation = panel:GetAttribute("IFSecurePanel_Orientation") or "HORIZONTAL"
			local leftToRight = panel:GetAttribute("IFSecurePanel_LeftToRight")
			local topToBottom = panel:GetAttribute("IFSecurePanel_TopToBottom")

			if leftToRight == nil then leftToRight = true end
			if topToBottom == nil then topToBottom = true end

			if elements then
				if panel:GetAttribute("IFSecurePanel_AutoPosition") then
					for i = 1, #elements do
						local frm = elements[i]

						if frm:IsShown() then
							local posX = (orientation == "HORIZONTAL" and count % columnCount or floor(count / rowCount)) * (elementWidth + hSpacing)
							local posY = (orientation == "HORIZONTAL" and floor(count / columnCount) or count % rowCount) * (elementHeight + vSpacing)

							frm:ClearAllPoints()

							if topToBottom then
								frm:SetPoint("TOP", panel, "TOP", 0, - posY - marginTop)
							else
								frm:SetPoint("BOTTOM", panel, "BOTTOM", 0, posY + marginBottom)
							end

							if leftToRight then
								frm:SetPoint("LEFT", panel, "LEFT", posX + marginLeft, 0)
							else
								frm:SetPoint("RIGHT", panel, "RIGHT", - posX - marginRight, 0)
							end

							count = count + 1
						end
					end
				else
					for i = #elements, 1, -1 do
						if elements[i]:IsShown() then
							count = i
							break
						end
					end
				end
			end

			if not panel:GetAttribute("IFSecurePanel_KeepMaxSize") then
				if not noForce or panel:GetAttribute("IFSecurePanel_AutoSize") then
					if count ~= IFSecurePanel_Cache[panel] then
						IFSecurePanel_Cache[panel] = count

						if orientation == "HORIZONTAL" then
							row = ceil(count / columnCount)
							column = row == 1 and count or columnCount
						else
							column = ceil(count / rowCount)
							row = column == 1 and count or rowCount
						end

						if panel:GetAttribute("IFSecurePanel_KeepColumnSize") then
							column = columnCount
							if row == 0 then row = 1 end
						end
						if panel:GetAttribute("IFSecurePanel_KeepRowSize") then
							row = rowCount
							if column == 0 then column = 1 end
						end

						if row > 0 and column > 0 then
							panel:SetWidth(column * elementWidth + (column - 1) * hSpacing + marginLeft + marginRight)
							panel:SetHeight(row * elementHeight + (row - 1) * vSpacing + marginTop + marginBottom)
						else
							panel:SetWidth(1)
							panel:SetHeight(1)
						end
					end
				end
			end
		]=]
	]]

	_IFSecurePanel_RegisterPanel = [=[
		local panel = Manager:GetFrameRef("SecurePanel")

		if panel and not IFSecurePanel_Panels[panel] then
			IFSecurePanel_Panels[panel] = newtable()
		end
	]=]

	_IFSecurePanel_UnregisterPanel = [=[
		local panel = Manager:GetFrameRef("SecurePanel")

		if panel then
			IFSecurePanel_Panels[panel] = nil
			IFSecurePanel_Cache[panel] = nil
		end
	]=]

	_IFSecurePanel_RegisterFrame = [=[
		local panel = Manager:GetFrameRef("SecurePanel")
		local frame = Manager:GetFrameRef("SecureElement")

		if panel and frame then
			IFSecurePanel_Panels[panel] = IFSecurePanel_Panels[panel] or newtable()
			tinsert(IFSecurePanel_Panels[panel], frame)

			IFSecurePanel_Map[frame] = panel
		end
	]=]

	_IFSecurePanel_UnregisterFrame = [=[
		local panel = Manager:GetFrameRef("SecurePanel")
		local frame = Manager:GetFrameRef("SecureElement")

		IFSecurePanel_Map[frame] = nil

		if panel and frame and IFSecurePanel_Panels[panel] then
			for k, v in ipairs(IFSecurePanel_Panels[panel]) do
				if v == frame then
					return tremove(IFSecurePanel_Panels[panel], k)
				end
			end
		end
	]=]

	_IFSecurePanel_WrapShow = [[
		Manager:RunFor(self, UpdatePanelSize, true)
	]]

	_IFSecurePanel_WrapHide = [[
		Manager:RunFor(self, UpdatePanelSize, true)
	]]

	_IFSecurePanel_UpdatePanelSize = [=[
		local panel = Manager:GetFrameRef("SecurePanel")

		IFSecurePanel_Cache[panel] = nil

		Manager:RunFor(panel, UpdatePanelSize)
	]=]

	_IFSecurePanel_ClearCache = [=[
		local panel = Manager:GetFrameRef("SecurePanel")

		IFSecurePanel_Cache[panel] = nil
	]=]

	function RegisterPanel(self)
		_IFSecurePanel_ManagerFrame:SetFrameRef("SecurePanel", self)
		_IFSecurePanel_ManagerFrame:Execute(_IFSecurePanel_RegisterPanel)
	end

	function UnregisterPanel(self)
		_IFSecurePanel_ManagerFrame:SetFrameRef("SecurePanel", self)
		_IFSecurePanel_ManagerFrame:Execute(_IFSecurePanel_UnregisterPanel)
	end

	function RegisterFrame(self, frame)
		_IFSecurePanel_ManagerFrame:SetFrameRef("SecurePanel", self)
		_IFSecurePanel_ManagerFrame:SetFrameRef("SecureElement", frame)
		_IFSecurePanel_ManagerFrame:Execute(_IFSecurePanel_RegisterFrame)

		_IFSecurePanel_ManagerFrame:WrapScript(frame, "OnShow", _IFSecurePanel_WrapShow)
		_IFSecurePanel_ManagerFrame:WrapScript(frame, "OnHide", _IFSecurePanel_WrapHide)
	end

	function UnregisterFrame(self, frame)
		_IFSecurePanel_ManagerFrame:UnwrapScript(frame, "OnShow")
    	_IFSecurePanel_ManagerFrame:UnwrapScript(frame, "OnHide")

		_IFSecurePanel_ManagerFrame:SetFrameRef("SecurePanel", self)
		_IFSecurePanel_ManagerFrame:SetFrameRef("SecureElement", frame)
		_IFSecurePanel_ManagerFrame:Execute(_IFSecurePanel_UnregisterFrame)
	end

	function SecureUpdatePanelSize(self)
		_IFSecurePanel_ManagerFrame:SetFrameRef("SecurePanel", self)
		_IFSecurePanel_ManagerFrame:Execute(_IFSecurePanel_UpdatePanelSize)
	end

	function SecureClearPanelCache(self)
		_IFSecurePanel_ManagerFrame:SetFrameRef("SecurePanel", self)
		_IFSecurePanel_ManagerFrame:Execute(_IFSecurePanel_ClearCache)
	end
end

__Doc__[[IFSecurePanel provides features to build a secure panel to contain elements of same secure class in a grid, the elements are generated by the IFSecurePanel]]
interface "IFSecurePanel"
	extend "IList"

	local function AdjustElements(self)
		local index = 0
		local isHorizontal = self.Orientation == Orientation.HORIZONTAL
		local isTopToBottom = self.TopToBottom
		local isLeftToRight = self.LeftToRight
		local marginLeft = self.MarginLeft
		local marginRight = self.MarginRight
		local marginTop = self.MarginTop
		local marginBottom = self.MarginBottom
		local columnCount = self.ColumnCount
		local rowCount = self.RowCount
		local widthPer = self.ElementWidth + self.HSpacing
		local heightPer = self.ElementHeight + self.VSpacing

		self:Each(function(element)
			element.Width = self.ElementWidth
			element.Height = self.ElementHeight

			if not self.AutoPosition or element.Visible then
				--if self.Orientation == Orientation.HORIZONTAL then
				--	-- Row first
				--	element:SetPoint("CENTER", self, "TOPLEFT", index % self.ColumnCount * (self.ElementWidth + self.HSpacing) + self.MarginLeft + (self.ElementWidth/2), -floor(index / self.ColumnCount) * (self.ElementHeight + self.VSpacing) - self.MarginTop - (self.ElementHeight/2))
				--else
				--	-- Column first
				--	element:SetPoint("CENTER", self, "TOPLEFT", floor(index / self.RowCount) * (self.ElementWidth + self.HSpacing) + self.MarginLeft + (self.ElementWidth/2), -(index % self.RowCount) * (self.ElementHeight + self.VSpacing) - self.MarginTop - (self.ElementHeight/2))
				--end

				local posX = (isHorizontal and index % columnCount or floor(index / rowCount)) * widthPer
				local posY = (isHorizontal and floor(index / columnCount) or index % rowCount) * heightPer

				element:ClearAllPoints()

				if isTopToBottom then
					element:SetPoint("TOP", 0, - posY - marginTop)
				else
					element:SetPoint("BOTTOM", 0, posY + marginBottom)
				end

				if isLeftToRight then
					element:SetPoint("LEFT", posX + marginLeft, 0)
				else
					element:SetPoint("RIGHT", - posX - marginRight, 0)
				end

				index = index + 1
			end
		end)
	end

	local function AdjustPanel(self)
		if self.KeepMaxSize then
			self.Width = self.ColumnCount * self.ElementWidth + (self.ColumnCount - 1) * self.HSpacing + self.MarginLeft + self.MarginRight
			self.Height = self.RowCount * self.ElementHeight + (self.RowCount - 1) * self.VSpacing + self.MarginTop + self.MarginBottom
			--[[local row, column

			if self.Orientation == "HORIZONTAL" then
				row = ceil(self.Count / self.ColumnCount)
				column = row == 1 and self.Count or self.ColumnCount
			else
				column = ceil(self.Count / self.RowCount)
				row = column == 1 and self.Count or self.RowCount
			end

			if row > 0 and column > 0 then
				self:SetWidth(column * self.ElementWidth + (column - 1) * self.HSpacing + self.MarginLeft + self.MarginRight)
				self:SetHeight(row * self.ElementHeight + (row - 1) * self.VSpacing + self.MarginTop + self.MarginBottom)
			else
				self:SetWidth(1)
				self:SetHeight(1)
			end--]]
		else
			SecureUpdatePanelSize(self)
		end
	end

	local function Reduce(self, index)
		index = index or self.RowCount * self.ColumnCount

		if index < self.Count then
			local ele

			for i = self.Count, index + 1, -1 do
				ele = self:GetChild(self.ElementPrefix .. i)
				self:Fire("OnElementRemove", ele)
				--ele:Dispose()
				self.ElementRecycle(ele)
				self:SetAttribute("IFSecurePanel_Count", i - 1)
			end

			AdjustPanel(self)
		end
	end

	local function Generate(self, index)
		if self.ElementType and index > self.Count then
			self.ElementRecycle = self.ElementRecycle or Recycle(self.ElementType, self.ElementPrefix .. "%d", self)

			local ele

			for i = self.Count + 1, index do
				ele = self.ElementRecycle()
				ele.ID = i

				self:Fire("OnElementAdd", ele)

				self:SetAttribute("IFSecurePanel_Count", i)
			end

			AdjustElements(self)
			AdjustPanel(self)
		end
	end

	local function nextItem(self, index)
		index = index + 1
		if self:GetChild(self.ElementPrefix .. index) then
			return index, self:GetChild(self.ElementPrefix .. index)
		end
	end

	_OperationMap = {
		-- 0 - AdjustPanel(self)
		KeepMaxSize = 0,
		MarginRight = 0,
		MarginBottom = 0,
		AutoSize = 0,
		KeepColumnSize = 0,
		KeepRowSize = 0,

		-- 1 - self:Each(AdjustElement, self)
		MarginLeft = 1,
		MarginTop = 1,
		VSpacing = 1,
		HSpacing = 1,
		Orientation = 1,
		ElementHeight = 1,
		ElementWidth = 1,
		TopToBottom = 1,
		LeftToRight = 1,

		-- 3 - Reduce + AdjustElement
		RowCount = 3,
		ColumnCount = 3,

		-- 4
		AutoPosition = 4,
	}

	local function OnPropertyChanged(self, value, old, prop)
		return Task.NoCombatCall(function()
			self:SetAttribute("IFSecurePanel_" .. prop, value)

			local oper = _OperationMap[prop]
			if oper == 1 or oper == 3 then
				if oper == 3 then Reduce(self) end
				return AdjustElements(self)
			elseif oper == 2 then
				return SecureUpdatePanelSize(self)
			elseif oper == 4 then
				if value then
					return SecureUpdatePanelSize(self)
				else
					return AdjustElements(self)
				end
			end

			return AdjustPanel(self)
		end)
	end

	class "Element"
		__Doc__[[Element is an accessor to the IFSecurePanel's elements, used like object.Element[i].Prop = value]]

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function Element(self, elementPanel)
			self.__IFSecurePanel = elementPanel
	    end

		------------------------------------------------------
		-- __index
		------------------------------------------------------
		function __index(self, index)
			self = self.__IFSecurePanel

			if type(index) == "number" and index >= 1 and index <= self.ColumnCount * self.RowCount then
				index = floor(index)

				if self:GetChild(self.ElementPrefix .. index) then return self:GetChild(self.ElementPrefix .. index) end

				if self.ElementType and not InCombatLockdown() then
					Generate(self, index)

					return self:GetChild(self.ElementPrefix .. index)
				else
					return nil
				end
			end
		end
	endclass "Element"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Fired when an element is added</desc>
		<param name="element">System.Widget.Region, the new element that added to the panel</param>
	]]
	event "OnElementAdd"

	__Doc__[[
		<desc>Fired when an element is removed</desc>
		<param name="element">System.Widget.Region, the new element that removed from the panel</param>
	]]
	event "OnElementRemove"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function GetIterator(self, key) return nextItem, self, tonumber(key) or 0 end

	function Each(self, ...)
		IList.Each(self, ...)

		Task.NoCombatCall(AdjustPanel, self)
	end

	__Doc__[[Update the panel size manually]]
	function UpdatePanelSize(self)
		Task.NoCombatCall(SecureUpdatePanelSize, self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The columns's count]]
	__Handler__( OnPropertyChanged )
	property "ColumnCount" { Type = PositiveNumber, Default = 99 }

	__Doc__[[The row's count]]
	__Handler__( OnPropertyChanged )
	property "RowCount" { Type = PositiveNumber, Default = 99 }

	__Doc__[[The elements's max count]]
	property "MaxCount" { Get = function(self) return self.ColumnCount * self.RowCount end }

	__Doc__[[The element's width]]
	__Handler__( OnPropertyChanged )
	property "ElementWidth" { Type = PositiveNumber, Default = 16 }

	__Doc__[[The element's height]]
	__Handler__( OnPropertyChanged )
	property "ElementHeight" { Type = PositiveNumber, Default = 16 }

	__Doc__[[The element's count]]
	property "Count" {
		Get = function(self)
			return self:GetAttribute("IFSecurePanel_Count")
		end,
		Set = function(self, cnt)
			if cnt > self.RowCount * self.ColumnCount then
				error("Count can't be more than "..self.RowCount * self.ColumnCount, 2)
			end

			if cnt > self.Count then
				if self.ElementType then
					Task.NoCombatCall(Generate, self, cnt)
				else
					error("ElementType not set.", 2)
				end
			elseif cnt < self.Count then
				Task.NoCombatCall(Reduce, self, cnt)
			end
		end,
		Type = NaturalNumber,
	}

	__Doc__[[The orientation for elements]]
	__Handler__( OnPropertyChanged )
	property "Orientation" { Type = Orientation, Default = Orientation.HORIZONTAL }

	__Doc__[[Whether the elements start from left to right]]
	__Handler__( OnPropertyChanged )
	property "LeftToRight" { Type = Boolean, Default = true }

	__Doc__[[Whether the elements start from top to bottom]]
	__Handler__( OnPropertyChanged )
	property "TopToBottom" { Type = Boolean, Default = true }

	__Doc__[[The element's type]]
	property "ElementType" { Type = Class }

	__Doc__[[The horizontal spacing]]
	__Handler__( OnPropertyChanged )
	property "HSpacing" { Type = Number }

	__Doc__[[The vertical spacing]]
	__Handler__( OnPropertyChanged )
	property "VSpacing" { Type = Number }

	__Doc__[[Whether the elementPanel is autosize]]
	__Handler__( OnPropertyChanged )
	property "AutoSize" { Type = Boolean }

	__Doc__[[The top margin]]
	__Handler__( OnPropertyChanged )
	property "MarginTop" { Type = Number }

	__Doc__[[The bottom margin]]
	__Handler__( OnPropertyChanged )
	property "MarginBottom" { Type = Number }

	__Doc__[[The left margin]]
	__Handler__( OnPropertyChanged )
	property "MarginLeft" { Type = Number }

	__Doc__[[The right margin]]
	__Handler__( OnPropertyChanged )
	property "MarginRight" { Type = Number }

	__Doc__[[The Element accessor, used like obj.Element[i].]]
	property "Element" {
		Get = function(self)
			self.__IFSecurePanel_Element = self.__IFSecurePanel_Element or Element(self)
			return self.__IFSecurePanel_Element
		end,
	}

	__Doc__[[The prefix for the element's name]]
	property "ElementPrefix" { Type = String, Default = "Element" }

	__Doc__[[Whether the elementPanel should keep it's max size]]
	__Handler__( OnPropertyChanged )
	property "KeepMaxSize" { Type = Boolean }

	__Doc__[[Whether adjust the elements position automatically]]
	__Handler__( OnPropertyChanged )
	property "AutoPosition" { Type = Boolean }

	__Doc__[[Whether keep the max size for columns]]
	__Handler__( OnPropertyChanged )
	property "KeepColumnSize" { Type = Boolean }

	__Doc__[[Whether keep the max size for rows]]
	__Handler__( OnPropertyChanged )
	property "KeepRowSize" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnElementAdd(self, element)
		Task.NoCombatCall(RegisterFrame, self, element)
	end

	local function OnElementRemove(self, element)
		Task.NoCombatCall(UnregisterFrame, self, IGAS:GetUI(element))
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self.OnElementAdd = self.OnElementAdd - OnElementAdd
		self.OnElementRemove = self.OnElementRemove - OnElementRemove

		for i = 1, self.Count do
			Task.NoCombatCall(UnregisterFrame, IGAS:GetUI(self), IGAS:GetUI(self.Element[i]))
		end

		Task.NoCombatCall(UnregisterPanel, IGAS:GetUI(self))
	end

	------------------------------------------------------
	-- Initialize
	------------------------------------------------------
	function IFSecurePanel(self)
		self.OnElementAdd = self.OnElementAdd + OnElementAdd
		self.OnElementRemove = self.OnElementRemove + OnElementRemove

		RegisterPanel(self)
	end
endinterface "IFSecurePanel"
