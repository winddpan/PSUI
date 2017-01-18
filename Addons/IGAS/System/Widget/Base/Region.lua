-- Author      : Kurapica
-- Create Date : 6/12/2008 1:13:21 AM
-- ChangeLog
--				2011/03/10	Recode as class
--              2012/04/13  ShowDialog is added
--              2012/07/09  OnVisibleChanged Script is added

-- Check Version
local version = 9
if not IGAS:NewAddon("IGAS.Widget.Region", version) then
	return
end

__Doc__[[Region is the basic type for anything that can occupy an area of the screen. As such, Frames, Textures and FontStrings are all various kinds of Region. Region provides most of the functions that support size, position and anchoring, including animation. It is a "real virtual" type; it cannot be instantiated, but objects can return true when asked if they are Regions.]]
__AutoProperty__()
class "Region"
	inherit "UIObject"

	local function GetPos(frame, point)
		local e = frame:GetEffectiveScale()/UIParent:GetScale()
		local x, y = frame:GetCenter()

		if strfind(point, "TOP") then
			y = frame:GetTop()
		elseif strfind(point, "BOTTOM") then
			y = frame:GetBottom()
		end

		if strfind(point, "LEFT") then
			x = frame:GetLeft()
		elseif strfind(point, "RIGHT") then
			x = frame:GetRight()
		end

		return x * e, y * e
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Run when the Region becomes visible]]
	__WidgetEvent__() event "OnShow"

	__Doc__[[Run when the Region's visbility changes to hidden]]
	__WidgetEvent__() event "OnHide"

	__Doc__[[Run when the Region's visible state is changed]]
	__WidgetEvent__() event "OnVisibleChanged"

	__Doc__[[Run when the Region's location is changed]]
	__WidgetEvent__() event "OnPositionChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetAlpha" [[
		<desc>Returns the opacity of the region relative to its parent</desc>
		<return type="number">Alpha (opacity) of the region (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__[[Hide the region]]
	function Hide(self)
		local flag = self:IsShown()

		self.__UI:Hide()

		if flag then
			if self:IsClass(LayeredRegion) then
				self:Fire("OnHide")
			end

			self:Fire("OnVisibleChanged")
		end

		return self.__ShowDialogThread and self.__ShowDialogThread()
	end

	__Doc__"IsShown" [[
		<desc>Returns whether the region is shown. Indicates only whether the region has been explicitly shown or hidden -- a region may be explicitly shown but not appear on screen because its parent region is hidden. See VisibleRegion:IsVisible() to test for actual visibility.</desc>
		<return type="boolean">1 if the region is shown; otherwise nil</return>
	]]

	__Doc__"IsVisible" [[
		<desc>Returns whether the region is visible. A region is "visible" if it has been explicitly shown (or not explicitly hidden) and its parent is visible (that is, all of its ancestor frames (parent, parent's parent, etc) are also shown)</desc>
		<return type="boolean">1 if the region is visible; otherwise nil</return>
	]]

	__Doc__"SetAlpha" [[
		<desc>Sets the opacity of the region relative to its parent</desc>
		<param name="alpha">number, alpha (opacity) of the region (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__[[Show the region]]
	function Show(self)
		local flag = self:IsShown()

		self.__UI:Show()

		if not flag then
			if self:IsClass(LayeredRegion) then
				self:Fire("OnShow")
			end

			self:Fire("OnVisibleChanged")
		end
	end

	__Doc__[[Show the region and stop parent's calling thread]]
	function ShowDialog(self)
		local flag = self:IsShown()

		self.__ShowDialogThread = System.Threading.Thread()
		self.__UI:Show()

		if not flag then
			if self:IsClass(LayeredRegion) then
				self:Fire("OnShow")
			end

			self:Fire("OnVisibleChanged")
		end

		return self.__ShowDialogThread:Yield()
	end

	__Doc__"CanChangeProtectedState" [[
		<desc>Returns whether protected properties of the region can be changed by non-secure scripts. Addon scripts are allowed to change protected properties for non-secure frames, or for secure frames while the player is not in combat.</desc>
		<return type="boolean">1 if addon scripts are currently allowed to change protected properties of the region (e.g. showing or hiding it, changing its position, or altering frame attributes); otherwise nil</return>
	]]

	__Doc__"ClearAllPoints" [[Removes all anchor points from the region]]

	__Doc__[[
		<desc>Creates a new AnimationGroup as a child of the region</desc>
		<param name="name">string, name to use for the new animation group</param>
		<param name="inheritsFrom">string, template from which the new animation group should inherit</param>
		<return type="System.Widget.AnimationGroup">The newly created AnimationGroup</return>
	]]
	function CreateAnimationGroup(self, name, inheritsFrom)
		return Widget["AnimationGroup"] and Widget["AnimationGroup"](name, self, inheritsFrom)
	end

	__Doc__[[
		<desc>Returns a list of animation groups belonging to the region</desc>
		<return type="...">- A list of AnimationGroup objects for which the region is parent</return>
	]]
	function GetAnimationGroups(self)
		local lst = {self.__UI:GetAnimationGroups()}

		for i, v in ipairs(lst) do
			lst[i] = IGAS:GetWrapper(v)
		end

		return unpack(lst)
	end

	__Doc__"GetBottom" [[
		<desc>Returns the distance from the bottom of the screen to the bottom of the region</desc>
		<return type="number">Distance from the bottom edge of the screen to the bottom edge of the region (in pixels)</return>
	]]

	__Doc__"GetCenter" [[
		<desc>Returns the screen coordinates of the region's center</desc>
		<return type="x">number, distance from the left edge of the screen to the center of the region (in pixels)</return>
		<return type="y">number, distance from the bottom edge of the screen to the center of the region (in pixels)</return>
	]]

	__Doc__"GetHeight" [[
		<desc>Returns the height of the region</desc>
		<return type="number">Height of the region (in pixels)</return>
	]]

	__Doc__"GetLeft" [[
		<desc>Returns the distance from the left edge of the screen to the left edge of the region</desc>
		<return type="number">Distance from the left edge of the screen to the left edge of the region (in pixels)</return>
	]]

	__Doc__"GetNumPoints" [[
		<desc>Returns the number of anchor points defined for the region</desc>
		<return type="number">Number of defined anchor points for the region</return>
	]]

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
		local point, frame, relativePoint, x, y = self.__UI:GetPoint(pointNum)
		frame = IGAS:GetWrapper(frame)
		return point, frame, relativePoint, x, y
	end

	__Doc__"GetRect" [[
		<desc>Returns the position and dimensions of the region</desc>
		<return type="left">number, Distance from the left edge of the screen to the left edge of the region (in pixels)</return>
		<return type="bottom">number, Distance from the bottom edge of the screen to the bottom of the region (in pixels)</return>
		<return type="width">number, Width of the region (in pixels)</return>
		<return type="height">number, Height of the region (in pixels)</return>
	]]

	__Doc__"GetRight" [[
		<desc>Returns the distance from the left edge of the screen to the right edge of the region</desc>
		<return type="number">Distance from the left edge of the screen to the right edge of the region (in pixels)</return>
	]]

	__Doc__"GetSize" [[
		<desc>Returns the width and height of the region</desc>
		<return type="width">number, the width of the region</return>
		<return type="height">number, the height of the region</return>
	]]

	__Doc__"GetTop" [[
		<desc>Returns the distance from the bottom of the screen to the top of the region</desc>
		<return type="number">Distance from the bottom edge of the screen to the top edge of the region (in pixels)</return>
	]]

	__Doc__"GetWidth" [[
		<desc>Returns the width of the region</desc>
		<return type="number">Width of the region (in pixels)</return>
	]]

	__Doc__"IsDragging" [[
		<desc>Returns whether the region is currently being dragged</desc>
		<return type="boolean">1 if the region (or its parent or ancestor) is currently being dragged; otherwise nil</return>
	]]

	__Doc__"IsMouseOver" [[
		<desc>Returns whether the mouse cursor is over the given region. This function replaces the previous MouseIsOver FrameXML function.</desc>
		<param name="topOffset">number, the amount by which to displace the top edge of the test rectangle</param>
		<param name="leftOffset">number, the amount by which to displace the left edge of the test rectangle</param>
		<param name="bottomOffset">number, the amount by which to displace the bottom edge of the test rectangle</param>
		<param name="rightOffset">number, the amount by which to displace the right edge of the test rectangle</param>
		<return type="boolean">1 if the mouse is over the region; otherwise nil</return>
	]]

	__Doc__"IsProtected" [[
		<desc>Returns whether the region is protected. Non-secure scripts may change certain properties of a protected region (e.g. showing or hiding it, changing its position, or altering frame attributes) only while the player is not in combat. Regions may be explicitly protected by Blizzard scripts or XML; other regions can become protected by becoming children of protected regions or by being positioned relative to protected regions.</desc>
		<return type="isProtected">boolean, 1 if the region is protected; otherwise nil</return>
		<return type="explicit">boolean, 1 if the region is explicitly protected; nil if the frame is only protected due to relationship with a protected region</return>
	]]

	__Doc__"SetAllPoints" [[
		<desc>Sets all anchor points of the region to match those of another region. If no region is specified, the region's anchor points are set to those of its parent.</desc>
		<format>[name|region]</format>
		<param name="name">global name of a System.Widget.Region</param>
		<param name="region">System.Widget.Region</param>
	]]

	__Doc__"SetHeight" [[
		<desc>Sets the region's height</desc>
		<param name="height">number, New height for the region (in pixels); if 0, causes the region's height to be determined automatically according to its anchor points</param>
	]]

	__Doc__"GetHeight" [[
		<desc>Gets the region's height</desc>
		<return type="number">the height of the region</return>
	]]

	__Doc__"SetPoint" [[
		<desc>Sets an anchor point for the region</desc>
		<param name="point">System.Widget.FramePoint, point on this region at which it is to be anchored to another</param>
		<param name="relativeTo">System.Widget.Region, reference to the other region to which this region is to be anchored; if nil or omitted, anchors the region relative to its parent (or to the screen dimensions if the region has no parent)</param>
		<param name="relativePoint">System.Widget.FramePoint, point on the other region to which this region is to be anchored; if nil or omitted, defaults to the same value as point</param>
		<param name="xOffset">number, horizontal distance between point and relativePoint (in pixels; positive values put point to the right of relativePoint); if nil or omitted, defaults to 0</param>
		<param name="yOffset">number, vertical distance between point and relativePoint (in pixels; positive values put point below relativePoint); if nil or omitted, defaults to 0</param>
	]]

	__Doc__"SetSize" [[
		<desc>Sets the size of the region to the specified values</desc>
		<param name="width">number, the width to set for the region</param>
		<param name="height">number, the height to set for the region</param>
	]]

	__Doc__"SetWidth" [[
		<desc>Sets the region's width</desc>
		<param name="width">number,New width for the region (in pixels); if 0, causes the region's width to be determined automatically according to its anchor points</param>
	]]

	__Doc__"StopAnimating" [[Stops any active animations involving the region or its children]]


	__Doc__[[Change the anchor settings with a location value]]
	__Arguments__{ Location }
	function UpdateWithAnchorSetting(self, oLoc)
		local loc = {}

		for i, anchor in ipairs(oLoc) do
			local relativeTo = anchor.relativeTo
			local relativeFrame

			if relativeTo then
				relativeFrame = self.Parent:GetChild(relativeTo) or IGAS:GetFrame(relativeTo)
			else
				relativeFrame = self.Parent
			end

			if relativeFrame then
				local e = self:GetEffectiveScale()
				local ep = UIParent:GetScale()
				local x, y = GetPos(self, anchor.point)
				local rx, ry = GetPos(relativeFrame, anchor.relativePoint or anchor.point)

				tinsert(loc, AnchorPoint(anchor.point, (x-rx)*ep/e, (y-ry)*ep/e, relativeTo, anchor.relativePoint or anchor.point))
			end
		end

		if #loc > 0 then
			self.Location = loc
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the frame's transparency value(0-1)]]
	property "Alpha" {
		Get = function(self)
			return self:GetAlpha()
		end,
		Set = function(self, alpha)
			self:SetAlpha(alpha)
		end,
		Type = ColorFloat,
	}

	__Doc__[[the height of the region]]
	property "Height" {
		Get = function(self)
			return self:GetHeight()
		end,
		Set = function(self, height)
			self:SetHeight(height)
		end,
		Type = Number,
	}

	__Doc__[[the width of the region]]
	property "Width" {
		Get = function(self)
			return self:GetWidth()
		end,
		Set = function(self, width)
			self:SetWidth(width)
		end,
		Type = Number,
	}

	__Doc__[[wheter the region is shown or not.]]
	property "Visible" {
		Get = function(self)
			return self:IsShown() and true or false
		end,
		Set = function(self, visible)
			if visible then
				self:Show()
			else
				self:Hide()
			end
		end,
		Type = Boolean,
	}

	__Doc__[[the size of the region]]
	property "Size" {
		Get = function(self)
			return System.Widget.Size(self:GetWidth(), self:GetHeight())
		end,
		Set = function(self, size)
			self:SetWidth(size.width)
			self:SetHeight(size.height)
		end,
		Type = Size,
	}

	__Doc__[[the location of the region]]
	property "Location" {
		Get = function(self)
			local ret = {}

			for i = 1, self:GetNumPoints() do
				local point, relativeTo, relativePoint, x, y = self:GetPoint(i)

				relativeTo = relativeTo or IGAS.UIParent
				if relativeTo == self.Parent then
					relativeTo = nil
				elseif relativeTo.Parent == self.Parent then
					relativeTo = relativeTo.Name
				else
					relativeTo = relativeTo and relativeTo:GetName()
				end

				if relativePoint == point then
					relativePoint = nil
				end

				if x == 0 then x = nil end
				if y == 0 then y = nil end

				ret[i] = AnchorPoint(point, x, y, relativeTo, relativePoint)
			end

			return ret
		end,
		Set = function(self, loc)
			if #loc > 0 then
				self:ClearAllPoints()
				for _, anchor in ipairs(loc) do
					local relativeTo = anchor.relativeTo

					if relativeTo then
						relativeTo = self.Parent:GetChild(relativeTo) or IGAS:GetFrame(relativeTo)
					else
						relativeTo = self.Parent
					end

					if relativeTo then
						self:SetPoint(anchor.point, relativeTo, anchor.relativePoint or anchor.point, anchor.xOffset or 0, anchor.yOffset or 0)
					end
				end

				return self:Fire("OnPositionChanged")
			end
		end,
		Type = Location,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self:ClearAllPoints()
		self:Hide()
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
endclass "Region"
