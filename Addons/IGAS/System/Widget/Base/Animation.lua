-- Author      : Kurapica
-- Create Date : 8/18/2009
-- ChangeLog
--				2011/03/11	Recode as class

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.Animation", version) then
	return
end

__Doc__[[
	Animations are used to change presentations or other characteristics of a frame or other region over time. The Animation object will take over the work of calling code over time, or when it is done, and tracks how close the animation is to completion.
	The Animation type doesn't create any visual effects by itself, but it does provide an OnUpdate handler that you can use to support specialized time-sensitive behaviors that aren't provided by the transformations descended from Animations. In addition to tracking the passage of time through an elapsed argument, you can query the animation's progress as a 0-1 fraction to determine how you should set your behavior.
	You can also change how the elapsed time corresponds to the progress by changing the smoothing, which creates acceleration or deceleration, or by adding a delay to the beginning or end of the animation.
	You can also use an Animation as a timer, by setting the Animation's OnFinished script to trigger a callback and setting the duration to the desired time.
]]
__AutoProperty__()
class "Animation"
	inherit "UIObject"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the animation (or animation group) finishes animating</desc>
		<param name="requested">boolean, true if animation finished because of a call to AnimationGroup:Finish(); false otherwise</param>
	]]
	__WidgetEvent__() event "OnFinished"

	__Doc__[[Run when the frame is created]]
	__WidgetEvent__() event "OnLoad"

	__Doc__[[Run when the animation (or animation group) is paused]]
	__WidgetEvent__() event "OnPause"

	__Doc__[[Run when the animation (or animation group) begins to play]]
	__WidgetEvent__() event "OnPlay"

	__Doc__[[
		<desc>Run when the animation (or animation group) is stopped</desc>
		<param name="requested">boolean, true if the animation was stopped due to a call to the animation's or group's :Stop() method; false if the animation was stopped for other reasons</param>
	]]
	__WidgetEvent__() event "OnStop"

	__Doc__[[
		<desc>Run each time the screen is drawn by the game engine</desc>
		<param name="elapsed">number, number of seconds since the OnUpdate handlers were last run (likely a fraction of a second)</param>
	]]
	__WidgetEvent__() event "OnUpdate"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetDuration" [[
		<desc>Returns the time for the animation to progress from start to finish</desc>
		<return type="number">Time for the animation to progress from start to finish (in seconds)</return>
	]]

	__Doc__"GetElapsed" [[
		<desc>Returns the amount of time since the animation began playing. This amount includes start and end delays.</desc>
		<return type="number">Amount of time since the animation began playing (in seconds)</return>
	]]

	__Doc__"GetEndDelay" [[
		<desc>Returns the amount of time the animation delays after finishing. A later animation in an animation group will not begin until after the end delay period of the preceding animation has elapsed.</desc>
		<return type="number">Time the animation delays after finishing (in seconds)</return>
	]]

	__Doc__"GetMaxFramerate" [[
		<desc>Returns the maximum number of times per second that the animation will update its progress. Does not necessarily reflect the running framerate of the animation in progress; World of Warcraft itself may be running at a lower framerate.</desc>
		<return type="number">Maximum number of times per second that the animation will update its progress</return>
	]]

	__Doc__"GetOrder" [[
		<desc>Returns the order of the animation within its parent group. When the parent AnimationGroup plays, Animations with a lower order number are played before those with a higher number. Animations with the same order number are played at the same time.</desc>
		<return type="number">Position at which the animation will play relative to others in its group (between 0 and 100)</return>
	]]

	__Doc__"GetProgress" [[
		<desc>Returns the progress of an animation, ignoring smoothing effects. The value returned by this method increases linearly with time while the animation is playing, while the value returned by Animation:GetSmoothProgress() may change at a different rate if the animation's smoothing type is set to a value other than NONE.</desc>
		<return type="number">Progress of the animation: between 0.0 (at start) and 1.0 (at end)</return>
	]]

	__Doc__"GetProgressWithDelay" [[
		<desc>Returns the progress of the animation and associated delays</desc>
		<return type="number">Progress of the animation and its delays: between 0.0 (at start of start delay) and 1.0 (at end of end delay)</return>
	]]

	__Doc__[[
		<desc>Returns the Region object on which the animation operates</desc>
		<return type="System.Widget.Region">Reference to the Region object on which the animation operates</return>
	]]
	function GetRegionParent(self)
		return IGAS:GetWrapper(self.__UI:GetRegionParent())
	end

	__Doc__"GetSmoothing" [[
		<desc>Returns the smoothing type for the animation. This setting affects the rate of change in the animation's progress value as it plays.</desc>
		<return type="System.Widget.AnimSmoothType"> Type of smoothing for the animation</return>
	]]

	__Doc__"GetSmoothProgress" [[
		<desc>Returns the progress of the animation (ignoring start and end delay). When using a generic Animation object to animate effects not handled by the built-in Animation subtypes, this method should be used for updating effects in the animation's OnUpdate handler, as it properly accounts for smoothing and delays managed by the Animation object.</desc>
		<return type="number">Progress of the animation: between 0.0 (at start) and 1.0 (at end)</return>
	]]

	__Doc__"GetStartDelay" [[
		<desc>Returns the amount of time the animation delays before its progress begins</desc>
		<return type="number">Amount of time the animation delays before its progress begins (in seconds)</return>
	]]

	__Doc__"IsDelaying" [[
		<desc>Returns whether the animation is currently in the middle of a start or end delay</desc>
		<return type="True">if the animation is currently in its start or end delay period; false if the animation is currently between its start and end periods (or has none) or is not playing</return>
	]]

	__Doc__"IsDone" [[
		<desc>Returns whether the animation has finished playing</desc>
		<return type="boolean">True if the animation is finished playing; otherwise false</return>
	]]

	__Doc__"IsPaused" [[
		<desc>Returns whether the animation is currently paused</desc>
		<return type="boolean">True if the animation is currently paused; false otherwise</return>
	]]

	__Doc__"IsPlaying" [[
		<desc>Returns whether the animation is currently playing</desc>
		<return type="boolean">True if the animation is currently playing; otherwise false</return>
	]]

	__Doc__"IsStopped" [[
		<desc>Returns whether the animation is currently stopped</desc>
		<return type="boolean">True if the animation is currently stopped; otherwise false</return>
	]]

	__Doc__"Pause" [[Pauses the animation. Unlike with Animation:Stop(), the animation is paused at its current progress state (e.g. in a fade-out-fade-in animation, the element will be at partial opacity) instead of reset to the initial state; animation can be resumed with Animation:Play().]]

	__Doc__"Play" [[Plays the animation. If the animation has been paused, it resumes from the paused state; otherwise the animation begins at its initial state.]]

	__Doc__"SetDuration" [[
		<desc>Sets the time for the animation to progress from start to finish</desc>
		<param name="duration">number, time for the animation to progress from start to finish (in seconds)</param>
	]]

	__Doc__"SetEndDelay" [[
		<desc>Sets the amount of time for the animation to delay after finishing. A later animation in an animation group will not begin until after the end delay period of the preceding animation has elapsed.</desc>
		<param name="delay">number, time for the animation to delay after finishing (in seconds)</param>
	]]

	__Doc__"SetMaxFramerate" [[
		<desc>Sets the maximum number of times per second for the animation to update its progress. Useful for limiting the amount of CPU time used by an animation. For example, if an UI element is 30 pixels square and is animated to double in size in 1 second, any visible increase in animation quality if WoW is running faster than 30 frames per second will be negligible. Limiting the animation's framerate frees CPU time to be used for other animations or UI scripts.</desc>
		<param name="framerate">number, maximum number of times per second for the animation to update its progress, or 0 to run at the maximum possible framerate</param>
	]]

	__Doc__"SetOrder" [[
		<desc>Sets the order for the animation to play within its parent group. When the parent AnimationGroup plays, Animations with a lower order number are played before those with a higher number. Animations with the same order number are played at the same time.</desc>
		<param name="order">number, position at which the animation should play relative to others in its group (between 0 and 100)</param>
	]]

	function SetParent(self, parent)
		parent = IGAS:GetWrapper(parent)

		if parent and not Object.IsClass(parent, AnimationGroup) then
			error("Usage : Animation:SetParent(parent) : 'parent' - AnimationGroup element expected.", 2)
		end

		return UIObject.SetParent(self, parent)
	end

	__Doc__"SetSmoothing" [[
		<desc>Sets the smoothing type for the animation. This setting affects the rate of change in the animation's progress value as it plays.</desc>
		<param name="smoothType">System.Widget.AnimSmoothType, type of smoothing for the animation</param>
		]]

	__Doc__"SetSmoothProgress" [[
		<desc>Sets the progress of an animation, ignoring smoothing effects.</desc>
		<param name="smooth">number, progress of the animation: between 0.0 (at start) and 1.0 (at end)</param>
		]]

	__Doc__"SetStartDelay" [[
		<desc>Sets the amount of time for the animation to delay before its progress begins. Start delays can be useful with concurrent animations in a group: see example for details.</desc>
		<param name="delay">number, amount of time for the animation to delay before its progress begins (in seconds)</param>
		]]

	__Doc__"Stop" [[Stops the animation. Also resets the animation to its initial state.]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, AnimationGroup) then
			error("Usage : Animation(name, parent) : 'parent' - AnimationGroup element expected.", 2)
		end

		return IGAS:GetUI(parent):CreateAnimation("Animation", nil, ...)
	end
endclass "Animation"

class "Animation"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Animation, AnimationGroup)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Amount of time the animation delays before its progress begins (in seconds)]]
	property "StartDelay" { Type = Number }

	__Doc__[[Time for the animation to delay after finishing (in seconds)]]
	property "EndDelay" { Type = Number }

	__Doc__[[Time for the animation to progress from start to finish (in seconds)]]
	property "Duration" { Type = Number }

	__Doc__[[Maximum number of times per second that the animation will update its progress]]
	property "MaxFramerate" { Type = Number }

	__Doc__[[Position at which the animation will play relative to others in its group (between 0 and 100)]]
	property "Order" { Type = Number }

	__Doc__[[Type of smoothing for the animation, IN, IN_OUT, NONE, OUT]]
	property "Smoothing" { Type = AnimSmoothType }

	__Doc__[[whether the animation is playing]]
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

	__Doc__[[whether the animation is paused]]
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

	__Doc__[[whether the animation is stoped]]
	property "Stoped" {
		Get = "IsStopped",
		Set = function(self, value)
			if value then
				if self:IsPlaying() or self:IsPaused() then
					return self:Stop()
				end
			else
				if self:IsStopped()  then
					return self:Play()
				end
			end
		end,
	}
endclass "Animation"
