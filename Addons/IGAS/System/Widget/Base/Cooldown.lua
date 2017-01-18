-- Author      : Kurapica
-- Create Date : 7/16/2008 11:05
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Cooldown", version) then
	return
end

__Doc__[[Cooldown is a specialized variety of Frame that displays the little "clock" effect over abilities and buffs. It can be set with its running time, whether it should appear to "fill up" or "empty out", and whether or not there should be a bright edge where it's changing between dim and bright.]]
__AutoProperty__()
class "Cooldown"
	inherit "Frame"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetDrawEdge" [[
		<desc>Returns whether a bright line should be drawn on the moving edge of the cooldown animation</desc>
		<return type="boolean">1 if a bright line should be drawn on the moving edge of the cooldown "sweep" animation; otherwise nil</return>
	]]

	__Doc__"GetReverse" [[
		<desc>Returns whether the bright and dark portions of the cooldown animation should be inverted</desc>
		<return type="boolean">1 if the cooldown animation "sweeps" an area of darkness over the underlying image; nil if the animation darkens the underlying image and "sweeps" the darkened area away</return>
	]]

	__Doc__"SetCooldown" [[
		<desc>Sets up the parameters for a Cooldown model.. Note: Most Cooldown animations in the default UI are managed via the function CooldownFrame_SetTimer(self, start, duration, enable), a wrapper for this method which automatically shows the Cooldown element while animating and hides it otherwise.</desc>
		<param name="start">number, value of GetTime() at the start of the cooldown animation</param>
		<param name="duration">number, duration of the cooldown animation (excluding that of the final "flash" animation)</param>
	]]

	__Doc__"SetDrawEdge" [[
		<desc>Sets whether a bright line should be drawn on the moving edge of the cooldown animation. Does not change the appearance of a currently running cooldown animation; only affects future runs of the animation.</desc>
		<param name="enable">boolean, true to cause a bright line to be drawn on the moving edge of the cooldown "sweep" animation; false for the default behavior (no line drawn)</param>
	]]

	__Doc__"SetReverse" [[
		<desc>Sets whether to invert the bright and dark portions of the cooldown animation</desc>
		<param name="reverse">boolean, true for an animation "sweeping" an area of darkness over the underlying image; false for the default animation of darkening the underlying image and "sweeping" the darkened area away</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("Cooldown", nil, parent, "CooldownFrameTemplate")
	end
endclass "Cooldown"

class "Cooldown"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Cooldown)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[true if the cooldown animation "sweeps" an area of darkness over the underlying image; false if the animation darkens the underlying image and "sweeps" the darkened area away]]
	property "Reverse" { Type = Boolean }
endclass "Cooldown"
