-- Author      : Kurapica
-- Create Date : 5/4/2012
-- ChangeLog
--               2012/07/18 Support nonRegion object
--               2012/12/07 Fix for not setpoint panel

local version = 6
if not IGAS:NewAddon("IGAS.Widget.LayoutPanel", version) then
	return
end

__Doc__[[LayoutPanel is used to manage its children's layout]]
__AutoProperty__()
class "LayoutPanel"
	inherit "Frame"

	import "System.Reflector"

	_Use_ShortCut = true

	_Error_Widget = "%swidget not existed."
	_Error_NotRegion = "%swidget must be a region object."
	_Error_Number = "%s%s must be a number, got %s."
	_Error_Percent = "%s%s must be 0 - 100."
	_Error_Zero = "%s%s can't be less than 0."
	_Error_Size = "%s%s can't be greater than parent's %s."
	_Error_Combine = "%sthe settings are oversize."

	local abs = math.abs
	local floor = math.floor

	local function mround(v)
		local a = abs(v)
		local f = floor(v)
		if (a-f) >= 0.5 then f = f + 1 end
		if v < 0 then return -f end
		return f
	end

	local function CalcMixValue(self, param, value)
		return floor(self[param] * floor(value * 100 % 100) / 100) + floor(value)
	end

	local function ValidateSet(self, index, prefix, selfParam,
			startName, startUnitName, endName, endUnitName, sizeName, sizeUnitName,
			startValue, startUnit, endValue, endUnit, sizeValue, sizeUnit)
		local size = self[selfParam]
		local obj = GetWidget(self, index)
		local startFunc, endFunc, sizeFunc
		local minSize, remainPct, realSize

		if size == 0 then size = 65535 end 	-- Since can't get real value when not setpoint

		prefix = prefix or ""
		remainPct = 100
		realSize = 0

		if obj and Reflector.ObjectIsClass(obj, Region) then
			-- Check start
			if startName then
				if type(startValue) ~= "number" then
					error(_Error_Number:format(prefix, startName, type(startValue)), 3)
				end

				startUnit = Reflector.Validate(Unit, startUnit, startUnitName, prefix, 1)

				if startUnit == _PERCENT then
					if startValue < 0 or startValue > 100 then
						error(_Error_Percent:format(prefix, startName), 3)
					end

					remainPct = remainPct - startValue
					startFunc = function() return floor(self[selfParam] * startValue / 100) end
				elseif startUnit == _PIXEL then
					if startValue < 0 then
						error(_Error_Zero:format(prefix, startName), 3)
					elseif startValue > size then
						error(_Error_Size:format(prefix, startName, selfParam), 3)
					end

					startValue = floor(startValue)
					realSize = realSize + startValue
					startFunc = function() return startValue end
				elseif startUnit == _MIX then
					if startValue < 0 then
						error(_Error_Zero:format(prefix, startName), 3)
					end

					local calc = function() return CalcMixValue(self, selfParam, startValue) end

					if calc() > size then
						error(_Error_Size:format(prefix, startName, selfParam), 3)
					end

					remainPct = remainPct - floor(startValue * 100 % 100)
					realSize = realSize + floor(startValue)
					startFunc = calc
				end
			end

			-- Check end
			if endName then
				if type(endValue) ~= "number" then
					error(_Error_Number:format(prefix, endName, type(endValue)), 3)
				end

				endUnit = Reflector.Validate(Unit, endUnit, endUnitName, prefix, 1)

				if endUnit == _PERCENT then
					if endValue < 0 or endValue > 100 then
						error(_Error_Percent:format(prefix, endName), 3)
					end
					remainPct = remainPct - endValue
					endFunc = function() return floor(self[selfParam] * endValue / 100) end
				elseif endUnit == _PIXEL then
					if endValue < 0 then
						error(_Error_Zero:format(prefix, endName), 3)
					elseif endValue > size then
						error(_Error_Size:format(prefix, endName, selfParam), 3)
					end
					endValue = floor(endValue)
					realSize = realSize + endValue
					endFunc = function() return endValue end
				elseif endUnit == _MIX then
					if endValue < 0 then
						error(_Error_Zero:format(prefix, endName), 3)
					end

					local calc = function() return CalcMixValue(self, selfParam, endValue) end

					if calc() > size then
						error(_Error_Size:format(prefix, endName, selfParam), 3)
					end

					remainPct = remainPct - floor(endValue * 100 % 100)
					realSize = realSize + floor(endValue)
					endFunc = calc
				end
			end

			-- Check size
			if sizeName then
				if type(sizeValue) ~= "number" then
					error(_Error_Number:format(prefix, sizeName, type(sizeValue)), 3)
				end

				sizeUnit = Reflector.Validate(Unit, sizeUnit, sizeUnitName, prefix, 1)

				if sizeUnit == _PERCENT then
					if sizeValue < 0 or sizeValue > 100 then
						error(_Error_Percent:format(prefix, sizeName), 3)
					end
					remainPct = remainPct - sizeValue
					sizeFunc = function() return floor(self[selfParam] * sizeValue / 100) end
				elseif sizeUnit == _PIXEL then
					if sizeValue < 0 then
						error(_Error_Zero:format(prefix, sizeName), 3)
					elseif sizeValue > size then
						error(_Error_Size:format(prefix, sizeName, selfParam), 3)
					end
					sizeValue = floor(sizeValue)
					realSize = realSize + sizeValue
					sizeFunc = function() return sizeValue end
				elseif sizeUnit == _MIX then
					if sizeValue < 0 then
						error(_Error_Zero:format(prefix, sizeName), 3)
					end

					local calc = function() return CalcMixValue(self, selfParam, sizeValue) end

					if calc() > size then
						error(_Error_Size:format(prefix, sizeName, selfParam), 3)
					end

					remainPct = remainPct - floor(sizeValue * 100 % 100)
					realSize = realSize + floor(sizeValue)
					sizeFunc = calc
				end
			end

			if not startFunc then
				startFunc = function() return floor(self[selfParam] - endFunc() - sizeFunc()) end
			elseif not sizeFunc then
				sizeFunc = function() return floor(self[selfParam] - endFunc() - startFunc()) end
			end

			-- Final check
			if self[selfParam] > 0 and (startFunc() < 0 or sizeFunc() < 0 or startFunc() + sizeFunc() > size) then
				error(_Error_Combine:format(prefix), 3)
			end

			if realSize > 0 then
				minSize = ceil(realSize * 100 / remainPct)
			end

			self.__NeedUpdateMinSize = true

			if selfParam == "Width" then
				obj.__Layout_Left = startFunc
				obj.__Layout_Width = sizeFunc
				obj.__Layout_MinWidth = minSize
			elseif selfParam == "Height" then
				obj.__Layout_Top = startFunc
				obj.__Layout_Height = sizeFunc
				obj.__Layout_MinHeight = minSize
			end
		elseif obj then
			error(_Error_NotRegion:format(prefix), 3)
		else
			error(_Error_Widget:format(prefix), 3)
		end
	end

	local function ValidateWidgets(self)
		local widget

		for i = #(self.__LayoutItems), 1, -1 do
			widget = self.__LayoutItems[i]

			if widget.Disposed then
				tremove(self.__LayoutItems, i)
			end
		end
	end

	------------------------------------------------------
	-- Enum
	------------------------------------------------------
	_PERCENT = "PERCENT"
	_PIXEL = "PIXEL"
	_MIX = "MIX"

	enum "Unit" {
		PCT = _PERCENT,
		PX = _PIXEL,
		MIX = _MIX,
	}

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Add a ui element to the panel</desc>
		<param name="widget">System.Widget.VirtualUIObject|System.Widget.Region, the ui element need to be added</param>
		<return type="number">the element's index</return>
	]]
	function AddWidget(self, widget)
		ValidateWidgets(self)

		if widget and (Reflector.ObjectIsClass(widget, Region) or Reflector.ObjectIsClass(widget, VirtualUIObject)) then
			if self:GetChild(widget.Name) == widget then
				for i = 1, #(self.__LayoutItems) do
					if self.__LayoutItems[i] == widget then
						return i
					end
				end
			elseif self:GetChild(widget.Name) then
				error("Usage : LayoutPanel:AddWidget(widget) : a widget already existed with same name.", 2)
			end

			-- Insert the widget
			if widget.Parent ~= self then
				widget.Parent = self
			end

			tinsert(self.__LayoutItems, widget)

			return #(self.__LayoutItems)
		else
			error("Usage : LayoutPanel:AddWidget(widget) : widget must be an object of [System.Widget.Region]or [System.Widget.VirtualUIObject].", 2)
		end
	end

	__Doc__[[
		<desc>Insert widget to the panel</desc>
		<param name="before">the element to be inserted before</param>
		<param name="widget">System.Widget.VirtualUIObject|System.Widget.Region, the ui element need to be added</param>
	]]
	function InsertWidget(self, before, widget)
		ValidateWidgets(self)

		-- Remap args
		if widget == nil then
			widget = before
			before = nil
		end

		if type(before) == "number" and before == #(self.__LayoutItems) + 1 then
			-- skip
		elseif before then
			local obj

			obj, before = GetWidget(self, before)

			if not before then
				error("Usage : LayoutPanel:InsertWidget([before, ]widget) : before not exist.", 2)
			end
		else
			before = #(self.__LayoutItems) + 1
		end

		if widget and (Reflector.ObjectIsClass(widget, Region) or Reflector.ObjectIsClass(widget, VirtualUIObject)) then
			if self:GetChild(widget.Name) == widget then
				for i = 1, #(self.__LayoutItems) do
					if self.__LayoutItems[i] == widget then
						return i
					end
				end
			elseif self:GetChild(widget.Name) then
				error("Usage : LayoutPanel:InsertWidget([before, ]widget) : a widget already existed with same name.", 2)
			end

			-- Insert the widget
			if widget.Parent ~= self then
				widget.Parent = self
			end

			tinsert(self.__LayoutItems, before, widget)

			return before
		else
			error("Usage : LayoutPanel:InsertWidget([before, ]widget) : widget must be an object of [System.Widget.Region]or [System.Widget.VirtualUIObject].", 2)
		end
	end

	__Doc__[[
		<desc>Get Widget from the panel</desc>
		<format>index|name</format>
		<param name="index">number, the index of the element</param>
		<param name="name">string, the name of the element</param>
		<return type="widget">the widget</return>
	]]
	function GetWidget(self, index)
		if type(index) == "number" then
			index = floor(index)

			if index > 0 and index <= #(self.__LayoutItems) then
				return self.__LayoutItems[index], index
			end
		end

		if type(index) == "string" then
			index = self:GetChild(index)
		end

		if Reflector.ObjectIsClass(index, Region) or Reflector.ObjectIsClass(index, VirtualUIObject) then
			if self:GetChild(index.Name) == index then
				for i = 1, #(self.__LayoutItems) do
					if self.__LayoutItems[i] == index then
						return index, i
					end
				end
			end
		end
	end

	__Doc__[[
		<desc>Get the element's index</desc>
		<format>name|widget</format>
		<param name="name">string, the name of the element</param>
		<param name="widget">System.Widget.Region|System.Widget.VirtualUIObject, the element</param>
		<return type="number">the element's index</return>
	]]
	function GetWidgetIndex(self, widget)
		local _, index = GetWidget(self, widget)

		return index
	end

	__Doc__[[
		<desc>Remove element to the panel</desc>
		<format>index|name|widget[, withoutDispose]</format>
		<param name="index">number, the index of the element</param>
		<param name="name">string, the name of the element</param>
		<param name="widget">System.Widget.Region|System.Widget.VirtualUIObject, the element</param>
		<param name="withoutDispose">boolean, true if need get the removed widget</param>
		<return type="widget">if withoutDispose is set to true</return>
	]]
	function RemoveWidget(self, index, withoutDispose)
		local obj

		obj, index = GetWidget(self, index)

		if index and obj then
			tremove(self.__LayoutItems, index)

			if not withoutDispose then
				obj:Dispose()
			else
				obj.__Layout_Left = nil
				obj.__Layout_Width = nil
				obj.__Layout_MinWidth = nil
				obj.__Layout_Top = nil
				obj.__Layout_Height = nil
				obj.__Layout_MinHeight = nil

				return obj
			end
		end
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
	function SetWidgetLeftRight(self, index, left, leftunit, right, rightunit)
		local prefix = "Usage : LayoutPanel:SetWidgetLeftRight(index||name||widget, left, leftunit, right, rightunit) : "

		ValidateSet(self, index, prefix, "Width",
			"left", "leftunit", "right", "rightunit", nil, nil,
			left, leftunit, right, rightunit, nil, nil)

		Layout(self)

		return self
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
	if _Use_ShortCut then SWLR = SetWidgetLeftRight end

	__Doc__[[
		<desc>Set Widget's left margin and width</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="left">number, left margin value</param>
		<param name="leftunit">System.Widget.LayoutPanel.Unit, left margin's unit</param>
		<param name="width">number, width value</param>
		<param name="widthunit">System.Widget.LayoutPanel.Unit, width unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetLeftWidth(self, index, left, leftunit, width, widthunit)
		local prefix = "Usage : LayoutPanel:SetWidgetLeftWidth(index||name||widget, left, leftunit, width, widthunit) :"

		ValidateSet(self, index, prefix, "Width",
			"left", "leftunit", nil, nil, "width", "widthunit",
			left, leftunit, nil, nil, width, widthunit)

		Layout(self)

		return self
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
	if _Use_ShortCut then SWLW = SetWidgetLeftWidth end

	__Doc__[[
		<desc>Set Widget's right margin and width</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="right">number, right margin value</param>
		<param name="rightunit">System.Widget.LayoutPanel.Unit, right margin's unit</param>
		<param name="width">number, width value</param>
		<param name="widthunit">System.Widget.LayoutPanel.Unit, width unitv</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetRightWidth(self, index, right, rightunit, width, widthunit)
		local prefix = "Usage : LayoutPanel:SetWidgetRightWidth(index||name||widget, right, rightunit, width, widthunit) : "

		ValidateSet(self, index, prefix, "Width",
			nil, nil, "right", "rightunit", "width", "widthunit",
			nil, nil, right, rightunit, width, widthunit)

		Layout(self)

		return self
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
	if _Use_ShortCut then SWRW = SetWidgetRightWidth end

	__Doc__[[
		<desc>Set Widget's top margin and bottom margin</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="top">number, top margin value</param>
		<param name="topunit">System.Widget.LayoutPanel.Unit, top margin's unit</param>
		<param name="bottom">number, bottom margin value</param>
		<param name="bottomunit">System.Widget.LayoutPanel.Unit, bottom margin's unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetTopBottom(self, index, top, topunit, bottom, bottomunit)
		local prefix = "Usage : LayoutPanel:SetWidgetTopBottom(index||name||widget, top, topunit, bottom, bottomunit) : "

		ValidateSet(self, index, prefix, "Height",
			"top", "topunit", "bottom", "bottomunit", nil, nil,
			top, topunit, bottom, bottomunit, nil, nil)

		Layout(self)

		return self
	end

	__Doc__[[
		<desc>Short for SetWidgetTopBottom. Set Widget's top margin and bottom margin</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="top">number, top margin value</param>
		<param name="topunit">System.Widget.LayoutPanel.Unit, top margin's unit</param>
		<param name="bottom">number, bottom margin value</param>
		<param name="bottomunit">System.Widget.LayoutPanel.Unit, bottom margin's unit</param>
		<return type="object">the panel self</return>
	]]
	if _Use_ShortCut then SWTB = SetWidgetTopBottom end

	__Doc__[[
		<desc>Set Widget's top margin and height</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="top">number, top margin value</param>
		<param name="topunit">System.Widget.LayoutPanel.Unit, top margin's unit</param>
		<param name="height">number, height value</param>
		<param name="heightunit">System.Widget.LayoutPanel.Unit, height's unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetTopHeight(self, index, top, topunit, height, heightunit)
		local prefix = "Usage : LayoutPanel:SetWidgetTopHeight(index||name||widget, top, topunit, height, heightunit) : "

		ValidateSet(self, index, prefix, "Height",
			"top", "topunit", nil, nil, "height", "heightunit",
			top, topunit, nil, nil, height, heightunit)

		Layout(self)

		return self
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
	if _Use_ShortCut then SWTH = SetWidgetTopHeight end

	__Doc__[[
		<desc>Set Widget's bottom margin and height</desc>
		<param name="index|name|widget">the ui element</param>
		<param name="bottom">number, bottom margin value</param>
		<param name="bottomunit">System.Widget.LayoutPanel.Unit, bottom margin's unit</param>
		<param name="height">number, height value</param>
		<param name="heightunit">System.Widget.LayoutPanel.Unit, height's unit</param>
		<return type="object">the panel self</return>
	]]
	function SetWidgetBottomHeight(self, index, bottom, bottomunit, height, heightunit)
		local prefix = "Usage : LayoutPanel:SetWidgetBottomHeight(index||name||widget, bottom, bottomunit, height, heightunit) : "

		ValidateSet(self, index, prefix, "Height",
			nil, nil, "bottom", "bottomunit", "height", "heightunit",
			nil, nil, bottom, bottomunit, height, heightunit)

		Layout(self)

		return self
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
	if _Use_ShortCut then SWBH = SetWidgetBottomHeight end

	__Doc__[[Refresh layout]]
	function Layout(self)
		if self.__SuspendLayout or not self.__LayoutItems then
			return
		end

		local obj, left, top, width, height
		local minWidth, minHeight = 0, 0

		for i = 1, #(self.__LayoutItems) do
			obj = self.__LayoutItems[i]

			-- make sure not disposed and not VirtualUIObject
			if Reflector.ObjectIsClass(obj, Region) then
				-- Check MinSize
				if obj.__Layout_MinWidth and obj.__Layout_MinWidth > minWidth then
					minWidth = obj.__Layout_MinWidth
				end

				if obj.__Layout_MinHeight and obj.__Layout_MinHeight > minHeight then
					minHeight = obj.__Layout_MinHeight
				end

				-- Calculate obj's new position
				if obj.__Layout_Left or obj.__Layout_Width or obj.__Layout_Top or obj.__Layout_Height then
					left = obj.__Layout_Left and obj.__Layout_Left() or 0
					width = obj.__Layout_Width and obj.__Layout_Width() or self.Width
					top = obj.__Layout_Top and obj.__Layout_Top() or 0
					height = obj.__Layout_Height and obj.__Layout_Height() or self.Height

					if left and width and top and height then
						obj:ClearAllPoints()

						obj:SetPoint("LEFT", self, "LEFT", left, 0)
						obj:SetPoint("TOP", self, "TOP", 0, -top)

						obj.Width = width
						obj.Height = height
					end
				end
			end
		end

		if self.__NeedUpdateMinSize then
			self.__NeedUpdateMinSize = nil

			local mWidth, mHeight = self:GetMinResize()

			mWidth = mWidth or 0
			mHeight = mHeight or 0

			mWidth = mWidth > minWidth and mWidth or minWidth
			mHeight = mHeight > minHeight and mHeight or minHeight

			self:SetMinResize(minWidth, minHeight)
		end
	end

	__Doc__[[Stop the refresh of the LayoutPanel]]
	function SuspendLayout(self)
		self.__SuspendLayout = true
	end

	__Doc__[[Resume the refresh of the LayoutPanel]]
	function ResumeLayout(self)
		self.__SuspendLayout = nil
		Layout(self)
	end

	__Doc__[[Whether the panel is suspended]]
	function IsSuspended(self)
		return self.__SuspendLayout
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the element's count]]
	property "Count" {
		Get = function(self)
			return #(self.__LayoutItems)
		end,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnSizeChanged(self, width, height)
		local owidth = self._ChkWidth or 0
		local oheight = self._ChkHeight or 0

		width = mround(width)
		height = mround(height)

		if abs(width - owidth) >= 1 or abs(height - oheight) >= 1 then
			self._ChkWidth = width
			self._ChkHeight = height
			return self:Layout()
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function LayoutPanel(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.__LayoutItems = self.__LayoutItems or {}

		self.OnSizeChanged = self.OnSizeChanged + OnSizeChanged
	end
endclass "LayoutPanel"
