-- Author      : Kurapica
-- Create Date : 8/18/2009
-- ChangeLog
--				2011/03/11	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Translation", version) then
	return
end

__Doc__[[Translation is an Animation type that applies an affine translation to its affected region automatically as it progresses.]]
__AutoProperty__()
class "Translation"
	inherit "Animation"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"SetOffset" [[
		<desc>Sets the animation's translation offsets</desc>
		<param name="xOffset">numner, Distance away from the left edge of the screen (in pixels) to move the region over the animation's duration</param>
		<param name="yOffset">number, Distance away from the bottom edge of the screen (in pixels) to move the region over the animation's duration</param>
	]]

	__Doc__"GetOffset" [[
		<desc>Gets the animation's translation offsets</desc>
		<return type="xOffset">number, Distance away from the left edge of the screen (in pixels) to move the region over the animation's duration</return>
		<return type="yOffset">number, Distance away from the bottom edge of the screen (in pixels) to move the region over the animation's duration</return>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, AnimationGroup) then
			error("Usage : Translation(name, parent) : 'parent' - AnimationGroup element expected.", 2)
		end

		return IGAS:GetUI(parent):CreateAnimation("Translation", nil, ...)
	end
endclass "Translation"

class "Translation"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Translation, AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the animation's translation offsets]]
	property "Offset" {
		Get = function(self)
			return Dimension(self:GetOffset())
		end,
		Set = function(self, offset)
			return self:SetOffset(offset.x, offset.y)
		end,
		Type = Dimension,
	}

endclass "Translation"
