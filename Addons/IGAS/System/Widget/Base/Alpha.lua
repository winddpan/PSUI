-- Author      : Kurapica
-- Create Date : 8/18/2009
-- ChangeLog
--				2011/03/11	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Alpha", version) then
	return
end

__Doc__[[Alpha is a type of animation that automatically changes the transparency level of its attached region as it progresses. You can set the degree by which it will change the alpha as a fraction; for instance, a change of -1 will fade out a region completely]]
__AutoProperty__()
class "Alpha"
	inherit "Animation"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetFromAlpha" [[
		<desc>Returns the animation's amount of alpha (opacity) start from.</desc>
		<return type="number">Amount by which the region's alpha value start from over the animation's duration (between -1 and 1)</return>
	]]

	__Doc__"SetFromAlpha" [[
		<desc>Sets the animation's amount of alpha (opacity) start from.</desc>
		<param name="change">number, Amount by which the region's alpha value should start from (between -1 and 1)</param>
	]]

	__Doc__"GetToAlpha" [[
		<desc>Returns the animation's amount of alpha (opacity) end to.</desc>
		<return type="number">Amount by which the region's alpha value end to over the animation's duration (between -1 and 1)</return>
	]]

	__Doc__"SetToAlpha" [[
		<desc>Sets the animation's amount of alpha (opacity) end to.</desc>
		<param name="change">number, Amount by which the region's alpha value should end to (between -1 and 1)</param>
	]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, AnimationGroup) then
			error("Usage : Alpha(name, parent) : 'parent' - AnimationGroup element expected.", 2)
		end

		return IGAS:GetUI(parent):CreateAnimation("Alpha", nil, ...)
	end
endclass "Alpha"

class "Alpha"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Alpha, AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the animation's amount of alpha (opacity) start from]]
	property "FromAlpha" { Type = Number }

	__Doc__[[the animation's amount of alpha (opacity) end to]]
	property "ToAlpha" { Type = Number }
endclass "Alpha"
