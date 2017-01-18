-- Author      : Kurapica
-- Create Date : 8/22/2008 23:25
-- ChangeLog   :
--              1/04/2009 the Container's Height can't be less then the frame
--              2010/02/16 Remove the back
--              2010/02/22 Add FixHeight to Container
--				2011/03/13 Recode as class
--              2013/02/04 Recode

-- Check Version
local version = 9
if not IGAS:NewAddon("IGAS.Widget.ScrollForm", version) then
	return
end

__Doc__[[ScrollForm is used as a scrollable container]]
__AutoProperty__()
class "ScrollForm"
	inherit "ScrollFrame"

	__Doc__[[The container used for scroll form]]
	__AutoProperty__()
	class "Container"
		inherit "Frame"

		local function DoFixHeight(self)
			local top = self:GetTop()
			local bottom = top

			if not top then return end

			for i, v in pairs(self:GetChilds()) do
				if v.GetBottom and v.Visible then
					if v:GetBottom() and v:GetBottom() < bottom then
						bottom = v:GetBottom()
					end
				end
			end

			self.Height = top - bottom
		end


		------------------------------------------------------
		-- Event
		------------------------------------------------------

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		__Doc__[[Update the size based on child elements]]
		function UpdateSize(self)
			return DoFixHeight(self)
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	endclass "Container"

	-- Back drop setting
    _FrameBackdrop = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 9,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Sets the scroll child frame</desc>
		<param name="frame">System.Widget.Region</param>
	]]
	function SetScrollChild(self, frame)
		if not Reflector.ObjectIsClass(frame, System.Widget.Region) then
			frame = nil
		end

		if self.__ScrollChild == frame then
			return
		end

		-- Clear previous scroll child
		if self.__ScrollChild then
			Super.SetScrollChild(self, nil)
			self.__ScrollChild:Dispose()
			self.__ScrollChild = nil
		end

		-- Add new scroll child
		Super.SetScrollChild(self, frame)
		self.__ScrollChild = frame

    	if self.__ScrollChild then
    		self.__ScrollChild:SetPoint("TOPLEFT")

    		if self.Width then
    			self.__ScrollChild.Width = self.Width - self:GetChild("Bar").Width
    		end
    	end
	end

	__Doc__[[Gets the scoll child frame]]
	function GetScrollChild(self)
		if not self.__ScrollChild then
			local container = Container("Container", self)
			container.Height = 1 -- Default height to make sure the container will be positioned
			self:SetScrollChild(container)
		end
		return self.__ScrollChild
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the minimum increment between allowed slider values]]
	property "ValueStep" {
		Set = function(self, value)
			if value > 1 then
				self:GetChild("Bar").ValueStep = value
			else
				self:GetChild("Bar").ValueStep = 1
			end
		end,

		Get = function(self)
			return self:GetChild("Bar").ValueStep
		end,

		Type = Number,
	}

	__Doc__[[the value representing the current position of the slider thumb]]
	property "Value" {
		Set = function(self, value)
			self:GetChild("Bar").Value = value
		end,

		Get = function(self)
			return self:GetChild("Bar").Value
		end,

		Type = Number,
	}

	__Doc__[[The scroll child frame]]
	property "ScrollChild" { Type = Region }

	------------------------------------------------------
	-- Event handler
	------------------------------------------------------
	local function OnScrollRangeChanged(self, xrange, yrange)
		if ( not yrange ) then
			yrange = self:GetVerticalScrollRange()
		end

		local bar = self:GetChild("Bar")
		local value = bar:GetValue()
		if value > yrange then
			value = yrange
		end
		bar:SetMinMaxValues(0, yrange)
		bar:SetValue(value)
	end

    local function OnMouseWheel(self, delta)
        local scrollBar = self:GetChild("Bar")
		local minV, maxV = scrollBar:GetMinMaxValues()

        if (delta > 0 ) then
			if scrollBar.Value - (scrollBar.Height / 2) >= minV then
				scrollBar.Value = scrollBar.Value - (scrollBar.Height / 2)
			else
				scrollBar.Value = minV
			end
        else
			if scrollBar.Value + (scrollBar.Height / 2) <= maxV then
				scrollBar.Value = scrollBar.Value + (scrollBar.Height / 2)
			else
				scrollBar.Value = maxV
			end
        end
    end

    local function OnSizeChanged(self)
    	if self.__ScrollChild and self.Width then
    		self.__ScrollChild.Width = self.Width - self:GetChild("Bar").Width
    		if self.__ScrollChild.Height == 0 then
    			self.__ScrollChild.Height = self.Height
    		end
    	end
    end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		if self.__ScrollChild then
			self.__ScrollChild:Dispose()
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function ScrollForm(self, name, parent, ...)
    	Super(self, name, parent, ...)

        self:SetBackdrop(_FrameBackdrop)
		self:SetBackdropColor(0, 0, 0)
		self:SetBackdropBorderColor(0.4, 0.4, 0.4)
        self.MouseWheelEnabled = true
		self.MouseEnabled = true

        local slider = ScrollBar("Bar", self)
        slider:SetMinMaxValues(0,0)
        slider.Value = 0
        slider.ValueStep = 10

        self.OnScrollRangeChanged = self.OnScrollRangeChanged + OnScrollRangeChanged
        self.OnMouseWheel = self.OnMouseWheel + OnMouseWheel
        self.OnSizeChanged = self.OnSizeChanged + OnSizeChanged
    end
endclass "ScrollForm"
