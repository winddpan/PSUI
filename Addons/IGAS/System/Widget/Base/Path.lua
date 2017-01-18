-- Author      : Kurapica
-- Create Date : 2013/04/11
-- ChangeLog

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Path", version) then
	return
end

__Doc__[[Path is an Animation type that  combines multiple transitions into a single control path with multiple ControlPoints.]]
__AutoProperty__()
class "Path"
	inherit "Animation"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Creates a new control point for the given path</desc>
		<format>[name [, template [, order] ] ]</format>
		<param name="name">string, the name of the object</param>
		<param name="template">string, the template from which the new point should inherit</param>
		<param name="order">number, the order of the new control point</param>
		<return type="System.Widget.ControlPoint">Reference to the new control point object</return>
	]]
	function CreateControlPoint(self, name, ...)
		return ControlPoint(name, self, ...)
	end

	__Doc__[[
		<desc>Returns the control points that belong to a given path</desc>
		<return type="..."> A list of ControlPoint objects that belong to the given path.</return>
	]]
	function GetControlPoints(self)
		local lst = {IGAS:GetUI(self):GetControlPoints()}

		for i, v in ipairs(lst) do
			lst[i] = IGAS:GetWrapper(v)
		end

		return unpack(lst)
	end

	__Doc__"GetMaxOrder" [[
		<desc>Returns the maximum order of the control points belonging to a given path</desc>
		<return type="number">The maximum order of the control points belonging to the given path.</return>
	]]

	__Doc__"SetCurve" [[
		<desc>Sets the curve type for the path animation</desc>
		<param name="curveType">string, NONE | SMOOTH</param>
	]]

	__Doc__"GetCurve" [[
		<desc>Returns the curveType of the given path</desc>
		<return type="curveType">string, NONE | SMOOTH</return>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, AnimationGroup) then
			error("Usage : Path(name, parent) : 'parent' - AnimationGroup element expected.", 2)
		end

		return IGAS:GetUI(parent):CreateAnimation("Path", nil, ...)
	end
endclass "Path"

class "Path"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Path, AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The curveType of the given path]]
	property "Curve" { Type = AnimCurveType }
endclass "Path"

__Doc__[[A special type of UIObject that represent a point in a Path Animation.]]
__AutoProperty__()
class "ControlPoint"
	inherit "UIObject"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"SetOffset" [[
		<desc>Sets the offset for the control point</desc>
		<param name="xOffset">numner, Distance away from the left edge of the screen (in pixels) to move the region over the animation's duration</param>
		<param name="yOffset">number, Distance away from the bottom edge of the screen (in pixels) to move the region over the animation's duration</param>
	]]

	__Doc__"GetOffset" [[
		<desc>Gets the offset for the control point</desc>
		<return type="xOffset">number, Distance away from the left edge of the screen (in pixels) to move the region over the animation's duration</return>
		<return type="yOffset">number, Distance away from the bottom edge of the screen (in pixels) to move the region over the animation's duration</return>
	]]

	__Doc__"SetOrder" [[
		<desc>Sets the order for control point to play within its parent group.</desc>
		<param name="order">number, position at which the animation should play relative to others in its group (between 0 and 100)</param>
	]]

	__Doc__"GetOrder" [[
		<desc>Returns the order of control point within its parent group.</desc>
		<return type="number">Position at which the animation will play relative to others in its group (between 0 and 100)</return>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, Path) then
			error("Usage : ControlPoint(name, parent) : 'parent' - Path UI element expected.", 2)
		end
		return IGAS:GetUI(parent):CreateControlPoint(nil, ...)
	end
endclass "ControlPoint"

class "ControlPoint"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(ControlPoint, Path, AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the control point offsets]]
	property "Offset" {
		Get = function(self)
			return Dimension(elf:GetOffset())
		end,
		Set = function(self, offset)
			return self:SetOffset(offset.x, offset.y)
		end,
		Type = Dimension,
	}

	__Doc__[[Position at which the animation will play relative to others in its group (between 0 and 100)]]
	property "Order" { Type = Number }
endclass "ControlPoint"
