-- Author      : Kurapica
-- Create Date : 2011/03/13
-- Change Log  :

----------------------------------------------------------------------------------------------------------------------------------------
---
-- <br><br>inherit <a href=".\Frame.html">Frame</a> For all methods, properties and scriptTypes
-- @name ArchaeologyDigSiteFrame
-- @class table
----------------------------------------------------------------------------------------------------------------------------------------

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.ArchaeologyDigSiteFrame", version) then
	return
end

__Doc__[[
	ArchaeologyDigSiteFrame is a frame that is used to display digsites. Any one frame can be used to display any number of digsites, called blobs. Each blob is a polygon with a border and a filling texture.
	To draw a blob onto the frame use the DrawBlob function. This will draw a polygon representing the specified digsite. It seems that it's only possible to draw digsites where you can dig and is on the current map.
	Changes to how the blobs should render will only affect newly drawn blobs. That means that if you want to change the opacity of a blob you must first clear all blobs using the DrawNone function and then redraw the blobs.
]]
__AutoProperty__()
class "ArchaeologyDigSiteFrame"
	inherit "Frame"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"DrawBlob" [[
		<desc>Draws a blob onto the frame. This will render the specified blob onto the frame with the current settings.</desc>
		<param name="blobId">numeric, the numeric ID of the blob to draw</param>
		<param name="draw">boolean, draw the blob</param>
	]]

	__Doc__"DrawNone" [[Removes all drawn blobs on the frame. Removes all blobs from the frame.]]

	__Doc__"EnableMerging" [[
		<param name="boolean"></param>
	]]

	__Doc__"EnableSmoothing" [[
		<param name="boolean"></param>
	]]

	__Doc__"SetBorderAlpha" [[
		<param name="alpha">number, (0-255)</param>
	]]

	__Doc__"SetBorderScalar" [[
		<param name="scala">number</param>
	]]

	__Doc__"SetBorderTexture" [[
		<param name="filename">string</param>
	]]

	__Doc__"SetFillAlpha" [[
	]]

	__Doc__"SetFillTexture" [[
	]]

	__Doc__"SetMergeThreshold" [[
	]]

	__Doc__"SetNumSplinePoints" [[
		<desc>Sets the number of points used in the blob polygon. Sets the number of corners of the polygon used when a drawing a blob using the DrawBlob function.The blob will allways have a minimum of 8 points, any number below that will default to 8.</desc>
		<param name="points">number, the number of points in the polygon used to draw the blobs.</param>
	]]

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("ArchaeologyDigSiteFrame", nil, parent, ...)
	end
endclass "ArchaeologyDigSiteFrame"

class "ArchaeologyDigSiteFrame"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(ArchaeologyDigSiteFrame)
endclass "ArchaeologyDigSiteFrame"
