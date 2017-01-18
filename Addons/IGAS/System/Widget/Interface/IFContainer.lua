-- Author      : Kurapica
-- Create Date : 2012/07/01
-- ChangeLog

local version = 1
if not IGAS:NewAddon("IGAS.Widget.IFContainer", version) then
	return
end

import "System.Collections"

__Doc__[[IFContainer is used to provide a layout panel to contain ui elements for the ui objects]]
__AutoProperty__()
interface "IFContainer"
	extend "IList"

	local function nextWidget(self, key)
		key = key + 1
		local obj = self:GetWidget(key)

		if obj then
			return key, obj
		end
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function Panel_OnMinResizeChanged(self, width, height)
		if self.Parent:GetNumPoints() == 0 or width == 0 or height == 0 or not self:GetLeft() then return end

		width = self:GetLeft() - self.Parent:GetLeft() + self.Parent:GetRight() - self:GetRight() + width
		height = self.Parent:GetTop() - self:GetTop() + self:GetBottom() - self.Parent:GetBottom() + height

		local mWidth, mHeight = self.Parent:GetMinResize()

		mWidth = mWidth or 0
		mHeight = mHeight or 0

		width = mWidth > width and mWidth or width
		height = mHeight > height and mHeight or height

		self.Parent:SetMinResize(width, height)
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Add element to the panel</desc>
		<format>[name, ]element[, ...]</format>
		<param name="name">string, the element's name when created, only needed when the element is a ui element class not a ui element, default the class's name</param>
		<param name="element">System.Widget.Region | System.Widget.VirtualUIObject | System.Widget.Region class | System.Widget.VirtualUIObject class, an ui element or ui element class to be added</param>
		<param name="...">arguments for the layout panel's AddWidget method</param>
		<return type="number">the element's index</return>
	]]
	function AddWidget(self, name, element, ...)
		local widget

		if type(name) == "string" then
			if Reflector.IsClass(element) and (Reflector.IsSuperClass(element, Region) or Reflector.IsSuperClass(element, VirtualUIObject)) then
				widget = element(name, self.Panel)

				return self.Panel:AddWidget(widget, ...)
			else
				error("Usage : IFContainer:AddWidget(name, element, ...) : element - must be a widget or class of [System.Widget.Region] or [System.Widget.VirtualUIObject].", 2)
			end
		elseif Reflector.ObjectIsClass(name, Region) or Reflector.ObjectIsClass(name, VirtualUIObject) then
			widget = name

			return self.Panel:AddWidget(widget, element, ...)
		elseif Reflector.IsClass(name) and (Reflector.IsSuperClass(name, Region) or Reflector.IsSuperClass(name, VirtualUIObject)) then
			widget = name(Reflector.GetNameSpaceName(name), self.Panel)

			return self.Panel:AddWidget(widget, element, ...)
		else
			error("Usage : IFContainer:AddWidget([name, ]element, ...) : element - must be a widget or class of [System.Widget.Region] or [System.Widget.VirtualUIObject].", 2)
		end
	end

	__Doc__[[
		<desc>Insert element to the panel</desc>
		<format>before, [name, ]element[, ...]</format>
		<param name="before">element that existed in the layout panel</param>
		<param name="name">string, the element's name when created, only needed when the element is a ui element class not a ui element, default the class's name</param>
		<param name="element">System.Widget.Region | System.Widget.VirtualUIObject | System.Widget.Region class | System.Widget.VirtualUIObject class, an ui element or ui element class to be inserted</param>
		<param name="...">arguments for the layout panel's AddWidget method</param>
		<return type="number">the element's index</return>
	]]
	function InsertWidget(self, before, name, element, ...)
		local widget

		if type(name) == "string" then
			if Reflector.IsClass(element) and (Reflector.IsSuperClass(element, Region) or Reflector.IsSuperClass(element, VirtualUIObject)) then
				widget = element(name, self.Panel)

				return self.Panel:InsertWidget(before, widget, ...)
			else
				error("Usage : IFContainer:InsertWidget(before, name, element, ...) : element - must be a Region class.", 2)
			end
		elseif Reflector.ObjectIsClass(name, Region) or Reflector.ObjectIsClass(name, VirtualUIObject) then
			widget = name

			return self.Panel:InsertWidget(before, widget, element, ...)
		elseif Reflector.IsClass(name) and (Reflector.IsSuperClass(name, Region) or Reflector.IsSuperClass(name, VirtualUIObject)) then
			widget = name(Reflector.GetNameSpaceName(name), self.Panel)

			return self.Panel:InsertWidget(before, widget, element, ...)
		else
			error("Usage : IFContainer:InsertWidget(before, [name, ]element, ...) : element - must be a widget or class of [System.Widget.Region] or [System.Widget.VirtualUIObject].", 2)
		end
	end

	__Doc__[[
		<desc>Get element from the panel</desc>
		<param name="element">string | System.Widget.Region class, name or or ui element class</param>
		<return type="element">the ui element</return>
		<return type="number">the element's index</return>
	]]
	function GetWidget(self, element)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:GetWidget(widget)
	end

	__Doc__[[
		<desc>Remove element from the panel</desc>
		<format>index|name|element[, withoutDispose]</format>
		<param name="index">number, the index of the element</param>
		<param name="name">string, the name of the element</param>
		<param name="element">System.Widget.Region|System.Widget.VirtualUIObject, the element</param>
		<param name="withoutDispose">boolean, true if need get the removed widget</param>
		<return type="element">if withoutDispose is set to true</return>

	]]
	function RemoveWidget(self, element, withoutDispose)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:RemoveWidget(widget, withoutDispose)
	end

	__Doc__[[
		<desc>Set Widget's left margin and right margin</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="left">number, left margin value</param>
		<param name="leftunit">string, left margin's unit</param>
		<param name="right">number, right margin value</param>
		<param name="rightunit">string, right margin's unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetLeftRight(self, element, left, leftunit, right, rightunit)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:SetWidgetLeftRight(widget, left, leftunit, right, rightunit)
	end

	__Doc__[[
		<desc>Short for SetWidgetLeftRight, Set Widget's left margin and right margin</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="left">number, left margin value</param>
		<param name="leftunit">System.Widget.LayoutPanel.Unit, left margin's unit</param>
		<param name="right">number, right margin value</param>
		<param name="rightunit">System.Widget.LayoutPanel.Unit, right margin's unit</param>
		<return type="object">the panel self</return>
	]]
	SWLR = SetWidgetLeftRight

	__Doc__[[
		<desc>Set Widget's left margin and width</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="left">number, left margin value</param>
		<param name="leftunit">System.Widget.LayoutPanel.Unit, left margin's unit</param>
		<param name="width">number, width value</param>
		<param name="widthunit">System.Widget.LayoutPanel.Unit, width unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetLeftWidth(self, element, left, leftunit, width, widthunit)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:SetWidgetLeftWidth(widget, left, leftunit, width, widthunit)
	end

	__Doc__[[
		<desc>Short for SetWidgetLeftWidth.Set Widget's left margin and width</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="left">number, left margin value</param>
		<param name="leftunit">System.Widget.LayoutPanel.Unit, left margin's unit</param>
		<param name="width">number, width value</param>
		<param name="widthunit">System.Widget.LayoutPanel.Unit, width unit</param>
		<return type="object">the panel self</return>
	]]
	SWLW = SetWidgetLeftWidth

	__Doc__[[
		<desc>Set Widget's right margin and width</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="right">number, right margin value</param>
		<param name="rightunit">System.Widget.LayoutPanel.Unit, right margin's unit</param>
		<param name="width">number, width value</param>
		<param name="widthunit">System.Widget.LayoutPanel.Unit, width unitv</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetRightWidth(self, element, right, rightunit, width, widthunit)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:SetWidgetRightWidth(widget, right, rightunit, width, widthunit)
	end

	__Doc__[[
		<desc>Short for SetWidgetRightWidth. Set Widget's right margin and width</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="right">number, right margin value</param>
		<param name="rightunit">System.Widget.LayoutPanel.Unit, right margin's unit</param>
		<param name="width">number, width value</param>
		<param name="widthunit">System.Widget.LayoutPanel.Unit, width unitv</param>
		<return type="object">the panel self</return>
	]]
	SWRW = SetWidgetRightWidth

	__Doc__[[
		<desc>Set Widget's top margin and bottom margin</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="top">number, top margin value</param>
		<param name="topunit">System.Widget.LayoutPanel.Unit, top margin's unit</param>
		<param name="bottom">number, bottom margin value</param>
		<param name="bottomunit">System.Widget.LayoutPanel.Unit, bottom margin's unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetTopBottom(self, element, top, topunit, bottom, bottomunit)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:SetWidgetTopBottom(widget, top, topunit, bottom, bottomunit)
	end

	__Doc__[[
		<desc>description</desc>
		<desc>Short for SetWidgetTopBottom. Set Widget's top margin and bottom margin</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="top">number, top margin value</param>
		<param name="topunit">System.Widget.LayoutPanel.Unit, top margin's unit</param>
		<param name="bottom">number, bottom margin value</param>
		<param name="bottomunit">System.Widget.LayoutPanel.Unit, bottom margin's unit</param>
		<return type="object">the panel self</return>
	]]
	SWTB = SetWidgetTopBottom

	__Doc__[[
		<desc>Set Widget's top margin and height</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="top">number, top margin value</param>
		<param name="topunit">System.Widget.LayoutPanel.Unit, top margin's unit</param>
		<param name="height">number, height value</param>
		<param name="heightunit">System.Widget.LayoutPanel.Unit, height's unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetTopHeight(self, element, top, topunit, height, heightunit)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:SetWidgetTopHeight(widget, top, topunit, height, heightunit)
	end

	__Doc__[[
		<desc>Short for SetWidgetTopHeight. Set Widget's top margin and height</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="top">number, top margin value</param>
		<param name="topunit">System.Widget.LayoutPanel.Unit, top margin's unit</param>
		<param name="height">number, height value</param>
		<param name="heightunit">System.Widget.LayoutPanel.Unit, height's unit</param>
		<return type="object">the panel self</return>
	]]
	SWTH = SetWidgetTopHeight

	__Doc__[[
		<desc>Set Widget's bottom margin and height</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="bottom">number, bottom margin value</param>
		<param name="bottomunit">System.Widget.LayoutPanel.Unit, bottom margin's unit</param>
		<param name="height">number, height value</param>
		<param name="heightunit">System.Widget.LayoutPanel.Unit, height's unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetBottomHeight(self, element, bottom, bottomunit, height, heightunit)
		local widget

		if Reflector.IsClass(element) then
			widget = Reflector.GetNameSpaceName(element)
		else
			widget = element
		end

		if not widget then return end

		return self.Panel:SetWidgetBottomHeight(widget, bottom, bottomunit, height, heightunit)
	end

	__Doc__[[
		<desc>Short for SetWidgetBottomHeight. Set Widget's bottom margin and height</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="bottom">number, bottom margin value</param>
		<param name="bottomunit">System.Widget.LayoutPanel.Unit, bottom margin's unit</param>
		<param name="height">number, height value</param>
		<param name="heightunit">System.Widget.LayoutPanel.Unit, height's unit</param>
		<return type="object">the panel self</return>
	]]
	SWBH = SetWidgetBottomHeight

	__Doc__[[Refresh the layout panel]]
	function RefreshLayout(self)
		return self.Panel:Layout()
	end

	__Doc__[[Stop the refresh of the layout panel]]
	function SuspendLayout(self)
		return self.Panel:SuspendLayout()
	end

	__Doc__[[Resume the refresh of the layout panel]]
	function ResumeLayout(self)
		return self.Panel:ResumeLayout()
	end

	__Doc__[[
		<desc>Set the layout panel's type</desc>
		<param name="layout">System.Widget.LayoutPanel class</param>
		]]
	function SetLayout(self, layout)
		assert(Reflector.IsSuperClass(layout, LayoutPanel), "Usage : IFContainer:SetLayout(layout) : the layout must be a child class of the LayoutPanel")

		-- just keep safe
		if self.__IFContainer_NoSetPanel then return end

		local obj = self:GetChild("Panel")

		if obj then
			if obj:GetClass() == layout then
				return
			end

			obj:Dispose()
		end

		obj = layout("Panel", self)

		obj.OnMinResizeChanged = obj.OnMinResizeChanged + Panel_OnMinResizeChanged

		self.__IFContainer_NoSetPanel = true

		pcall(self.UpdatePanelPosition, self)

		self.__IFContainer_NoSetPanel = nil

		obj.AutoLayout = self.AutoLayout
	end

	__Doc__[[
		<desc>Get the layout panel's type</desc>
		<return type="class">the layout panel's type</return>
	]]
	function GetLayout(self)
		local obj = self:GetChild("Panel")

		return obj and obj:GetClass() or LayoutPanel
	end

	__Doc__[[
		<desc>Get the layout panel</desc>
		<return type="System.Widget.LayoutPanel"></return>
	]]
	function GetPanel(self)
		local obj = self:GetChild("Panel")

		if not obj or not obj:IsClass(LayoutPanel) then
			if obj then obj:Dispose() end

			obj = LayoutPanel("Panel", self)

			obj.OnMinResizeChanged = obj.OnMinResizeChanged + Panel_OnMinResizeChanged

			self.__IFContainer_NoSetPanel = true

			pcall(self.UpdatePanelPosition, self)

			self.__IFContainer_NoSetPanel = nil

			obj.AutoLayout = self.AutoLayout
		end

		return obj
	end

	__Doc__[[Update the container's panel's postion, Overridable]]
	function UpdatePanelPosition(self)
		self.Panel:ClearAllPoints()
		self.Panel:SetAllPoints(self)
	end

	function GetIterator(self, key)
		return nextWidget, self, tonumber(key) or 0
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The layout panel]]
	property "Panel" {
		Get = GetPanel,	-- don't want use custom GetPanel
	}

	__Doc__[[The layout panel's type]]
	property "Layout" {
		Set = SetLayout,
		Get = GetLayout,
		--Type = - LayoutPanel,
	}

	__Doc__[[The element's count in the layout panel]]
	property "Count" {
		Get = function(self)
			return self.Panel.Count
		end,
	}

	__Doc__[[Whether the layout panel is auto update]]
	__Handler__( function (self, value)
		if self:GetChild("Panel") then
			self:GetChild("Panel").AutoLayout = value
		end
	end )
	property "AutoLayout" { Type = Boolean }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
endinterface "IFContainer"
