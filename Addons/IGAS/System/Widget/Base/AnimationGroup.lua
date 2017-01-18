-- Author      : Kurapica
-- Create Date : 8/18/2009
-- ChangeLog
--				2011/03/11	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.AnimationGroup", version) then
	return
end

__Doc__[[
	An AnimationGroup is how various animations are actually applied to a region; this is how different behaviors can be run in sequence or in parallel with each other, automatically. When you pause an AnimationGroup, it tracks which of its child animations were playing and how far advanced they were, and resumes them from that point.
	An Animation in a group has an order from 1 to 100, which determines when it plays; once all animations with order 1 have completed, including any delays, the AnimationGroup starts all animations with order 2.
	An AnimationGroup can also be set to loop, either repeating from the beginning or playing backward back to the beginning. An AnimationGroup has an OnLoop handler that allows you to call your own code back whenever a loop completes. The :Finish() method stops the animation after the current loop has completed, rather than immediately.
]]
__AutoProperty__()
class "AnimationGroup"
	inherit "UIObject"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the animation group finishes animating</desc>
		<param name="requested">boolean, true if animation finished because of a call to AnimationGroup:Finish(); false otherwise</param>
	]]
	__WidgetEvent__() event "OnFinished"

	__Doc__[[Run when the frame is created, no use in IGAS]]
	__WidgetEvent__() event "OnLoad"

	__Doc__[[
		<desc>Run when the animation group's loop state changes</desc>
		<param name="loopState">System.Widget.AnimLoopStateType, the animation group's loop state</param>
	]]
	__WidgetEvent__() event "OnLoop"

	__Doc__[[Run when the animation group is paused]]
	__WidgetEvent__() event "OnPause"

	__Doc__[[Run when the animation group begins to play]]
	__WidgetEvent__() event "OnPlay"

	__Doc__[[
		<desc>Run when the animation group is stopped</desc>
		<param name="requested">boolean true if the animation was stopped due to a call to the animation's or group's :Stop() method; false if the animation was stopped for other reasons</param>
	]]
	__WidgetEvent__() event "OnStop"

	__Doc__[[
		<desc>Run each time the screen is drawn by the game engine</desc>
		<param name="elapsed">number, Number of seconds since the OnUpdate handlers were last run (likely a fraction of a second)</param>
	]]
	__WidgetEvent__() event "OnUpdate"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Creates an Animation as a child of this group</desc>
		<param name="animationType">string, type of Animation object to be create</param>
		<param name="name">string, global name to use for the new animation</param>
		<param name="inheritsFrom">string, a template from which to inherit</param>
		<return type="System.Widget.Animation"></return>
	]]
	function CreateAnimation(self, animationType, name, inheritsFrom)
		return Widget[animationType] and Widget[animationType](name, self, inheritsFrom)
	end

	__Doc__"Finish" [[Causes animations within the group to complete and stop. If the group is playing, animations will continue until the current loop cycle is complete before stopping.]]

	__Doc__[[
		<desc>Returns a list of animations belonging to the group</desc>
		<return type="...">A list of Animation objects belonging to the animation group</return>
	]]
	function GetAnimations(self)
		local tbl = {self.__UI:GetAnimations()}
		for i, v in ipairs(tbl) do
			tbl[i] = IGAS:GetWrapper(v)
		end

		return unpack(tbl)
	end

	__Doc__"GetDuration" [[
		<desc>Returns the duration of a single loop cycle for the group, as determined by its child animations.</desc>
		<return type="number">Total duration of all child animations (in seconds)</return>
	]]

	__Doc__"GetInitialOffset" [[
		<desc>Returns the starting static translation for the animated region</desc>
		<return type="x">number, horizontal distance to offset the animated region (in pixels)</return>
		<return type="y">number, vertical distance to offset the animated region (in pixels)</return>
	]]

	__Doc__"GetLooping" [[
		<desc>Returns the looping behavior of the group</desc>
		<return type="System.Widget.AnimLoopType">Looping type for the animation group</return>
	]]

	__Doc__"GetLoopState" [[
		<desc>Returns the current loop state of the group</desc>
		<return type="System.Widget.AnimLoopStateType">Loop state of the animation group</return>
	]]

	__Doc__"GetProgress" [[
		<desc>Returns the current state of the animation group's progress</desc>
		<return type="number">Value indicating the current state of the group animation: between 0.0 (initial state, child animations not yet started) and 1.0 (final state, all child animations complete)</return>
	]]

	__Doc__"IsDone" [[
		<desc>Returns whether the group has finished playing. Only valid in the OnFinished and OnUpdate handlers, and only applies if the animation group does not loop.</desc>
		<return type="boolean">True if the group has finished playing; false otherwise</return>
	]]

	__Doc__"IsPaused" [[
		<desc>Returns whether the group is paused</desc>
		<return type="boolean">True if animation of the group is currently paused; false otherwise</return>
	]]

	__Doc__"IsPendingFinish" [[
		<desc>Returns whether or not the animation group is pending finish</desc>
		<return type="boolean">Whether or not the animation group is currently pending a finish command.  Since the Finish() method does not immediately stop the animation group, this method can be used to test if Finish() has been called and the group will finish at the end of the current loop.</return>
	]]

	__Doc__"IsPlaying" [[
		<desc>Returns whether the group is playing</desc>
		<return type="boolean">True if the group is currently animating; false otherwise</return>
	]]

	__Doc__"Pause" [[Pauses animation of the group. Unlike with AnimationGroup:Stop(), the animation is paused at its current progress state (e.g. in a fade-out-fade-in animation, the element will be at partial opacity) instead of reset to the initial state; animation can be resumed with AnimationGroup:Play().]]

	__Doc__"Play" [[Starts animating the group. If the group has been paused, animation resumes from the paused state; otherwise animation begins at the initial state.]]

	__Doc__"SetInitialOffset" [[
		<desc>Sets a static translation for the animated region. This translation is only used while the animation is playing.</desc>
		<param name="x">number, horizontal distance to offset the animated region (in pixels)</param>
		<param name="y">number, vertical distance to offset the animated region (in pixels)</param>
	]]

	__Doc__"SetLooping" [[
		<desc>Sets the looping behavior of the group</desc>
		<param name="loopType">System.Widget.AnimLoopType</param>
	]]

	__Doc__"Stop" [[Stops animation of the group. Unlike with AnimationGroup:Pause(), the animation is reset to the initial state (e.g. in a fade-out-fade-in animation, the element will be instantly returned to full opacity) instead of paused at its current progress state.]]

	__Doc__"SetToFinalAlpha" [[Set the final alpha to the animated region]]

	__Doc__"IsSetToFinalAlpha" [[Whether set the final alpha to the animated region]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not IGAS:GetUI(parent).CreateAnimationGroup then
			error("Usage : AnimationGroup(name, parent) : 'parent' - can't create AnimationGroup.")
		end

		return IGAS:GetUI(parent):CreateAnimationGroup(nil, ...)
	end
endclass "AnimationGroup"

class "AnimationGroup"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[looping type for the animation group: BOUNCE , NONE  , REPEAT]]
	property "Looping" { Type = AnimLoopType }

	__Doc__[[the current loop state of the group: FORWARD , NONE , REVERSE]]
	property "LoopState" { Type = AnimLoopStateType	}

	__Doc__[[the starting static translation for the animated region]]
	property "InitialOffset" {
		Get = function(self)
			return Dimension(self:GetInitialOffset())
		end,
		Set = function(self, value)
			return self:SetInitialOffset(value.x, value.y)
		end,
		Type = Dimension,
	}

	__Doc__[[whether the animationgroup is playing]]
	property "Playing" {
		Get = "IsPlaying",
		Set = function(self, value)
			if value then
				if not self:IsPlaying() then
					return self:Play()
				end
			else
				if self:IsPlaying() then
					return self:Stop()
				end
			end
		end,
	}

	__Doc__[[whether the animationgroup is paused]]
	property "Paused" {
		Get = "IsPaused",
		Set = function(self, value)
			if value then
				if self:IsPlaying() then
					return self:Pause()
				end
			else
				if self:IsPaused() then
					return self:Play()
				end
			end
		end,
	}

	__Doc__[[whether the animationgroup is stoped]]
	property "Stoped" {
		Get = function(self)
			return not (self:IsPlaying() or self:IsPaused())
		end,
		Set = function(self, value)
			if value then
				if self:IsPlaying() or self:IsPaused() then
					return self:Stop()
				end
			else
				if not (self:IsPlaying() or self:IsPaused()) then
					return self:Play()
				end
			end
		end,
	}

	__Doc__[[duration of all child animations (in seconds)]]
	property "Duration" { }

	__Doc__[[Whether to final alpha is set]]
	property "ToFinalAlpha" { Type = Boolean, Set = SetToFinalAlpha, Get = IsSetToFinalAlpha }
endclass "AnimationGroup"
