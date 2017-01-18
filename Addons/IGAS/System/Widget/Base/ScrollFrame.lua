-- Author      : Kurapica
-- Create Date : 7/16/2008 14:16
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.ScrollFrame", version) then
	return
end

__Doc__[[ScrollFrame is used to show a large body of content through a small window. The ScrollFrame is the size of the "window" through which you want to see the larger content, and it has another frame set as a "ScrollChild" containing the full content.]]
__AutoProperty__()
class "ScrollFrame"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the scroll frame's horizontal scroll position changes</desc>
		<param name="offset">number, new horizontal scroll position (in pixels, measured from the leftmost scroll position)</param>
	]]
	__WidgetEvent__() event "OnHorizontalScroll"

	__Doc__[[
		<desc>Run when the scroll frame's scroll position is changed</desc>
		<param name="xOffset">number, new horizontal scroll range (in pixels, measured from the leftmost scroll position)</param>
		<param name="yOffset">number, new vertical scroll range (in pixels, measured from the topmost scroll position)</param>
	]]
	__WidgetEvent__() event "OnScrollRangeChanged"

	__Doc__[[
		<desc>Run when the scroll frame's vertical scroll position changes</desc>
		<param name="offset">number, new vertical scroll position (in pixels, measured from the topmost scroll position)</param>
	]]
	__WidgetEvent__() event "OnVerticalScroll"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetHorizontalScroll" [[
		<desc>Returns the scroll frame's current horizontal scroll position</desc>
		<return type="number">Current horizontal scroll position</return>
	]]

	__Doc__"GetHorizontalScrollRange" [[
		<desc>Returns the scroll frame's maximum horizontal (rightmost) scroll position</desc>
		<return type="number">Maximum horizontal scroll position</return>
	]]

	__Doc__"GetScrollChild" [[
		<desc>Returns the frame scrolled by the scroll frame</desc>
		<return type="widgetObject">Reference to the Frame object scrolled by the scroll frame</return>
	]]

	__Doc__"GetVerticalScroll" [[
		<desc>Returns the scroll frame's current vertical scroll position</desc>
		<return type="number">Current vertical scroll position</return>
	]]

	__Doc__"GetVerticalScrollRange" [[
		<desc>Returns the scroll frame's maximum vertical (bottom) scroll position</desc>
		<return type="number">Maximum vertical scroll position</return>
	]]

	__Doc__"SetHorizontalScroll" [[
		<desc>Sets the scroll frame's horizontal scroll position</desc>
		<param name="scroll">number, Current horizontal scroll position</param>
	]]

	__Doc__"SetScrollChild" [[
		<desc>Sets the scroll child for the scroll frame. The scroll child frame represents the (generally larger) area into which the scroll frame provides a (generally smaller) movable "window". The child must have an absolute size</desc>
		<param name="frame">widgetObject, Reference to another frame to be the ScrollFrame's child.</param>
	]]

	__Doc__"SetVerticalScroll" [[
		<desc>Sets the scroll frame's vertical scroll position</desc>
		<param name="scroll">number, Current vertical scroll position</param>
	]]

	__Doc__"UpdateScrollChildRect" [[Updates the position of the scroll frame's child. The ScrollFrame automatically adjusts the position of the child frame when scrolled, but manually updating its position may be necessary when changing the size or contents of the child frame.]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("ScrollFrame", nil, parent, ...)
	end
endclass "ScrollFrame"

class "ScrollFrame"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(ScrollFrame)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the scroll frame's current horizontal scroll position]]
	property "HorizontalScroll" { Type = Number }

	__Doc__[[the scroll frame's vertical scroll position]]
	property "VerticalScroll" { Type = Number }
endclass "ScrollFrame"
