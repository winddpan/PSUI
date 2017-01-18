-- Author     : Kurapica
-- ChangreLog :
--              2010.01.13 Change the Timer's Parent to WorldFrame
--              2011/03/13 Recode as class
--              2014/07/08 Recode with System.Task
--              2014/10/23 No need complex queue system

-- Check Version
local version = 14

if not IGAS:NewAddon("IGAS.Widget.Timer", version) then
	return
end

import "System.Task"
import "System.Data"

function CallTimer(self, guid)
	if self._GUID == guid and self.Interval > 0 and self.Enabled then self:Fire("OnTimer") end
	return self._GUID == guid and self.Interval > 0 and self.Enabled and DelayCall(self.Interval, CallTimer, self, guid)
end

function RefreshTimer(self)
	local guid = Guid()
	self._GUID = guid
	return self.Interval > 0 and self.Enabled and DelayCall(self.Interval, CallTimer, self, guid)
end

__Doc__[[Timer is used to fire an event on a specified interval]]
__AutoProperty__()
class "Timer"
	inherit "VirtualUIObject"

	__StructType__(StructType.Custom)
	__Default__( 0 )
	struct "TimerInterval"
		function __init(value)
			if type(value) ~= "number" or value < 0 then
				value = 0
			elseif value > 0 and value < 0.1 then
				value = 0.1
			end
			return value
		end
	endstruct "TimerInterval"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Run when the timer is at the right time]]
	event "OnTimer"

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Gets or sets the interval at which to fire the Elapsed event]]
	__Handler__( RefreshTimer )
	property "Interval" { Type = TimerInterval }

	__Doc__[[Whether the timer is enabled or disabled, default true]]
	__Handler__( RefreshTimer )
	property "Enabled" { Type = Boolean, Default = true }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self.Interval = 0
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
endclass "Timer"
