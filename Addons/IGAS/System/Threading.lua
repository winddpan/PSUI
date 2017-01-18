 -- Author      : Kurapica
-- Create Date  : 2013/08/13
-- ChangeLog    :
--                2014/07/07 Recode with System.Task for older version

Module "System.Threading" "99.0.0"

namespace "System.Threading"

__Sealed__()
enum "ThreadStatus" {
    "running",
    "suspended",
    "normal",
    "dead",
}

------------------------------------------------------
-- System.Threading
------------------------------------------------------
__Doc__[[
	<desc>Make current thread sleep for a while</desc>
	<param name="delay" type="number">the sleep time for current thread</param>
	<usage>System.Threading.Sleep(10)</usage>
]]
Threading.Sleep = Task.Delay

__Doc__[[
	<desc>Make current thread sleeping until event triggered</desc>
	<param name="event">the event name</param>
	<usage>System.Threading.WaitEvent(event)</usage>
]]
Threading.WaitEvent = Task.Event

__Doc__[[
	<desc>Make current thread sleeping until event triggered or meet the timeline</desc>
	<param name="delay">number, the waiting time's deadline</param>
	<param name="...">the event list</param>
	<usage>System.Threading.Wait(10, event1, event2)</usage>
]]
Threading.Wait = Task.Wait

------------------------------------------------------
-- System.Threading.Thread
------------------------------------------------------
__Doc__[[
    Thread object is used to control lua coroutines.
    Thread object can be created with a default function that will be convert to coroutine, also can create a empty Thread object.
    Thread object can use 'Thread' property to receive function, coroutine, other Thread object as it's control coroutine.
    Thread object can use 'Resume' method to resume coroutine like 'obj:Resume(arg1, arg2, arg3)'. Also can use 'obj(arg1, arg2, arg3)' for short.
    In the Thread object's controling function, can use the System.Threading's method to control the coroutine.
]]
__Sealed__()
class "Thread" (function(_ENV)
    inherit "Object"

    _MainThread = running() or 0

    local function chkValue(flag, ...)
        if flag then
            return ...
        else
            local value = ...

            if value then
                error(value, 2)
            else
                error(..., 2)
            end
        end
    end

    ------------------------------------------------------
    -- Event
    ------------------------------------------------------

    ------------------------------------------------------
    -- Method
    ------------------------------------------------------
    __Doc__[[
        <desc>Resume the thread</desc>
        <param name="...">any arguments passed to the thread</param>
        <return name="..."> any return values from the thread</return>
    ]]
    function Resume(self, ...)
        if self.Thread then
            if running() == self.Thread then
                return ...
            else
                return chkValue( resume(self.Thread, ...) )
            end
        elseif running() ~= _MainThread then
            self.Thread = running()
            return ...
        end
    end

    __Doc__[[
        <desc>Yield the thread</desc>
        <param name="...">return arguments</param>
    ]]
    function Yield(self, ...)
        local co = running()

        if co ~= _MainThread then
            self.Thread = co

            return yield(...)
        end
    end

    __Doc__[[
        <desc>Whether the thread is running</desc>
        <return type="boolean">true if the thread is running</return>
    ]]
    function IsRunning(self)
        local co = self.Thread
        return co and (status(co) == "running" or status(co) == "normal") or false
    end

    __Doc__[[
        <desc>Whether the thread is suspended</desc>
        <return type="boolean">true if the thread is suspended</return>
    ]]
    function IsSuspended(self)
        return self.Thread and status(self.Thread) == "suspended" or false
    end

    __Doc__[[
        <desc>Whether the thread is dead</desc>
        <return type="boolean">true if the thread is dead</return>
    ]]
    function IsDead(self)
        return not self.Thread or status(self.Thread) == "dead" or false
    end

	__Doc__[[
		<desc>Make current thread sleeping until event triggered or meet the timeline</desc>
		<param name="delay">the waiting time</param>
		<param name="...">the event list</param>
	]]
	function Wait(self, ...)
		self.Thread = running()
		return Task.Wait(...)
	end

	__Doc__[[
		<desc>Make current thread sleeping until event triggered</desc>
		<param name="event">the event name</param>
	]]
	function WaitEvent(self, event)
		self.Thread = running()
		return Task.Event(event)
	end

	__Doc__[[
		<desc>Make current thread sleeping</desc>
		<param name="delay">the waiting time</param>
	]]
	function Sleep(self, delay)
		self.Thread = running()
		return Task.Delay(delay)
	end

    ------------------------------------------------------
    -- Property
    ------------------------------------------------------
    __Doc__[[Get the thread's status]]
    property "Status" {
        Get = function(self)
            if self.Thread then
                return status(self.Thread)
            else
                return "dead"
            end
        end,
        Type = ThreadStatus,
    }

    __Doc__[[Get the thread object's coroutine or set a new function/coroutine to it]]
    property "Thread" {
        Field = "__Thread",
        Set = function(self, th)
            if type(th) == "function" then
                self.__Thread = create(th)
            elseif type(th) == "thread" then
                self.__Thread = th

            elseif th and Reflector.ObjectIsClass(th, Threading.Thread) then
                self.__Thread = th.Thread
            else
                self.__Thread = nil
            end
        end,
    }

    ------------------------------------------------------
    -- Constructor
    ------------------------------------------------------
    __Arguments__( System.Thread + Function )
    function Thread(self, func)
        self.Thread = func
    end

    ------------------------------------------------------
    -- __call for class instance
    ------------------------------------------------------
    function __call(self, ...)
        return Resume(self, ...)
    end
end)
