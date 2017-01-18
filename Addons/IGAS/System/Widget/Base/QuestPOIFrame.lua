-- Author      : Kurapica
-- Create Date : 2011/03/13
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.QuestPOIFrame", version) then
	return
end

__AutoProperty__()
class "QuestPOIFrame"
	inherit "Frame"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"DrawBlob" [[
		<desc>Draws the Blob for the Quest. If a quest has a area where the quest need to be completed at, this function will draw a Blob to show that area.</desc>
		<param name="questId">number, the Id of the quest</param>
		<param name="draw">boolean, draw the Blob</param>
	]]

	__Doc__"DrawNone" [[
	]]

	__Doc__"EnableMerging" [[
	]]

	__Doc__"EnableSmoothing" [[
	]]

	__Doc__"GetNumTooltips" [[
	]]

	__Doc__"GetTooltipIndex" [[
	]]

	__Doc__"SetBorderAlpha" [[
		<desc> Set the alpha for the border texture</desc>
		<param name="alpha">number, set alpha the border texture is drawn</param>
	]]

	__Doc__"SetBorderScalar" [[
		<desc>Set the Border Scalar</desc>
		<param name="scalar">number, set the glow(size) of the border</param>
	]]

	__Doc__"SetBorderTexture" [[
		<desc>Sets the border texture for the blob</desc>
		<param name="path">string, the texture path for the border textureof the blob</param>
	]]

	__Doc__"SetFillAlpha" [[
		<desc>Set the Alpha for the fill Texture</desc>
		<param name="alpha">number the alpha for the fill texture</param>
	]]

	__Doc__"SetFillTexture" [[
		<desc>Set the fill texture for the blob.</desc>
		<param name="path">string, the texture path for the fill texture</param>
	]]

	__Doc__"SetMergeThreshold" [[
	]]

	__Doc__"SetNumSplinePoints" [[
	]]

	__Doc__"UpdateMouseOverTooltip" [[
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("QuestPOIFrame", nil, parent, ...)
	end
endclass "QuestPOIFrame"

class "QuestPOIFrame"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(QuestPOIFrame)
endclass "QuestPOIFrame"
