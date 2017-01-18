-- Author      : Kurapica
-- Create Date : 8/18/2009
-- ChangeLog
--				2011/03/11	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Rotation", version) then
	return
end

__Doc__[[Rotation is an Animation that automatically applies an affine rotation to the region being animated. You can set the origin around which the rotation is being done, and the angle of rotation in either degrees or radians.]]
__AutoProperty__()
class "Rotation"
	inherit "Animation"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetDegrees" [[
		<desc>Returns the animation's rotation amount (in degrees)</desc>
		<return type="number">Amount by which the region rotates over the animation's duration (in degrees; positive values for counter-clockwise rotation, negative for clockwise)</return>
	]]

	__Doc__"GetOrigin" [[
		<desc>Returns the rotation animation's origin point. During a rotation animation, the origin point remains in place while the positions of all other points in the scaled region are moved according to the rotation amount.</desc>
		<return type="point">System.Widget.FramePoint, anchor point for the rotation origin</return>
		<return type="xOffset">number, horizontal distance from the anchor point to the rotation origin (in pixels)</return>
		<return type="yOffset">number, vertical distance from the anchor point to the rotation origin (in pixels)</return>
	]]

	__Doc__"GetRadians" [[
		<desc>Returns the animation's rotation amount (in radians)</desc>
		<return type="number">Amount by which the region rotates over the animation's duration (in radians; positive values for counter-clockwise rotation, negative for clockwise)</return>
	]]

	__Doc__"SetDegrees" [[
		<desc>Sets the animation's rotation amount (in degrees)</desc>
		<param name="degrees">number, Amount by which the region should rotate over the animation's duration (in degrees; positive values for counter-clockwise rotation, negative for clockwise)</param>
	]]

	__Doc__"SetOrigin" [[
		<desc>Sets the rotation animation's origin point. During a rotation animation, the origin point remains in place while the positions of all other points in the scaled region are moved according to the rotation amount.</desc>
		<param name="point">System.Widget.FramePoint, anchor point for the rotation origin</param>
		<param name="xOffset">number, horizontal distance from the anchor point to the rotation origin (in pixels)</param>
		<param name="yOffset">number, vertical distance from the anchor point to the rotation origin (in pixels)</param>
	]]

	__Doc__"SetRadians" [[
		<desc>Sets the animation's rotation amount (in radians)</desc>
		<param name="radians">number, amount by which the region should rotate over the animation's duration (in radians; positive values for counter-clockwise rotation, negative for clockwise)</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, AnimationGroup) then
			error("Usage : Rotation(name, parent) : 'parent' - AnimationGroup element expected.", 2)
		end

		return IGAS:GetUI(parent):CreateAnimation("Rotation", nil, ...)
	end
endclass "Rotation"

class "Rotation"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Rotation, AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the animation's rotation amount (in degrees)]]
	property "Degrees" { Type = Number }

	__Doc__[[the animation's rotation amount (in radians)]]
	property "Radians" { Type = Number }

	__Doc__[[the rotation animation's origin point]]
	property "Origin" {
		Get = function(self)
			return AnimOriginType(self:GetOrigin())
		end,
		Set = function(self, origin)
			self:SetOrigin(origin.point, origin.x, origin.y)
		end,
		Type = AnimOriginType,
	}
endclass "Rotation"
