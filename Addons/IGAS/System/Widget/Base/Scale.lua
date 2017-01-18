-- Author      : Kurapica
-- Create Date : 8/18/2009
-- ChangeLog
--				2011/03/11	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Scale", version) then
	return
end

__Doc__[[Scale is an Animation type that automatically applies an affine scalar transformation to the region being animated as it progresses. You can set both the multiplier by which it scales, and the point from which it is scaled.]]
__AutoProperty__()
class "Scale"
	inherit "Animation"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetOrigin" [[
		<desc>Returns the scale animation's origin point. During a scale animation, the origin point remains in place while the positions of all other points in the scaled region are moved according to the scale factor.</desc>
		<return type="point">System.Widget.FramePoint, Anchor point for the scale origin</return>
		<return type="xOffset">number, Horizontal distance from the anchor point to the scale origin (in pixels)</return>
		<return type="yOffset">number, Vertical distance from the anchor point to the scale origin (in pixels)</return>
	]]

	__Doc__"GetScale" [[
		<desc>Returns the animation's scaling factors. At the end of the scale animation, the animated region's dimensions are equal to its initial dimensions multiplied by its scaling factors.</desc>
		<return type="xFactor">number, Horizontal scaling factor</return>
		<return type="yFactor">number, Vertical scaling factor</return>
	]]

	__Doc__"SetOrigin" [[
		<desc>Sets the scale animation's origin point. During a scale animation, the origin point remains in place while the positions of all other points in the scaled region are moved according to the scale factor.</desc>
		<param name="point">System.Widget.FramePoint, anchor point for the scale origin</param>
		<param name="xOffset">number, horizontal distance from the anchor point to the scale origin (in pixels)</param>
		<param name="yOffset">number, vertical distance from the anchor point to the scale origin (in pixels)</param>
	]]

	__Doc__"SetScale" [[
		<desc>Sets the animation's scaling factors. At the end of the scale animation, the animated region's dimensions are equal to its initial dimensions multiplied by its scaling factors.</desc>
		<param name="xFactor">number, Horizontal scaling factor</param>
		<param name="yFactor">number, Vertical scaling factor</param>
	]]

	__Doc__"GetFromScale" [[
		<desc>Gets the animation's scale amount that start from.</desc>
		<return>the animation's scale amount that start from</return>
	]]

	__Doc__"SetFromScale" [[
		<desc>Sets the animation's scale amount that start from.</desc>
		<param name="fromscale">the animation's scale amount that start from</param name="fromscale">
	]]

	__Doc__"GetToScale" [[
		<desc>Gets the animation's scale amount that end to.</desc>
		<return>the animation's scale amount that end to</return>
	]]

	__Doc__"SetToScale" [[
		<desc>Sets the animation's scale amount that end to.</desc>
		<param name="fromscale">the animation's scale amount that end to</param name="fromscale">
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, AnimationGroup) then
			error("Usage : Scale(name, parent) : 'parent' - AnimationGroup element expected.", 2)
		end

		return IGAS:GetUI(parent):CreateAnimation("Scale", nil, ...)
	end
endclass "Scale"

class "Scale"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Scale, AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the animation's scaling factors]]
	property "Scale" {
		Get = function(self)
			return Dimension(self:GetScale())
		end,
		Set = function(self, offset)
			self:SetScale(offset.x, offset.y)
		end,
		Type = Dimension,
	}

	__Doc__[[the scale animation's origin point]]
	property "Origin" {
		Get = function(self)
			return AnimOriginType(self:GetOrigin())
		end,
		Set = function(self, origin)
			self:SetOrigin(origin.point, origin.x, origin.y)
		end,
		Type = AnimOriginType,
	}

	__Doc__[[the animation's scale amount that start from]]
	property "FromScale" {
		Get = function(self)
			return Dimension(self:GetFromScale())
		end,
		Set = function(self, offset)
			self:SetFromScale(offset.x, offset.y)
		end,
		Type = Dimension,
	}

	__Doc__[[the animation's scale amount that end to]]
	property "ToScale" {
		Get = function(self)
			return Dimension(self:GetToScale())
		end,
		Set = function(self, offset)
			self:SetToScale(offset.x, offset.y)
		end,
		Type = Dimension,
	}
endclass "Scale"
