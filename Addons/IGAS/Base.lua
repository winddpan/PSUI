-- Author		:	Kurapica
-- Create Date	:	2011/01/21
-- ChangeLog    :
--                  2013/08/05 Remove the version check, seal the metatable for IGAS

IGAS = setmetatable({}, {
	-- __call
	-- get the addons that stored in the IGAS's addon system
	-- like IGAS("IGAS") return the addon object of the igas
	__call = function(self, name)
		if rawget(self, "GetAddon") and name and type(name) == "string" and name ~= "" then
			return self:GetAddon(name)
		end
	end,

	-- __index
	-- 1. get the wrapper of existed ui elements, like IGAS.UIParent to get the wrapper of UIParent
	-- 2. get the namespace of the class system, like IGAS.System.Widget.Form return the Form class
	__index = function(self, key)
		-- Return the namespace of the given name
		if rawget(self, "GetNameSpace") and type(key) == "string" then
			local ns = self:GetNameSpace(key)

			if ns then
				rawset(self, key, ns)
				return ns
			end
		end

		-- Return the wrapper object of the given ui element's global name
		if rawget(self, "GetWrapper") and _G[key] and _G[key][0] then
			local frame = _G[key]

			if type(frame) == "table" and type(frame[0]) == "userdata" then
				rawset(self, key, self:GetWrapper(frame))
				return rawget(self, key)
			end
		end
	end,

	-- seal the metatable
	__metatable = true,
})

Module "IGAS_SYSTEM_EXTENSION" ""

namespace "System"

------------------------------------------------------
-- System.Object
------------------------------------------------------
__Sealed__()
__Doc__[[The root class of other classes. Object class contains several methodes for common use.]]
class "Object" (function(_ENV)
    ------------------------------------------------------
    -- Method
    ------------------------------------------------------
    __Doc__[[
        <desc>Get the class type of the object</desc>
        <return type="class">the object's class</return>
    ]]
    GetClass = Reflector.GetObjectClass

    __Doc__[[
        <desc>Check if the object is an instance of the class</desc>
        <param name="class"></param>
        <return type="boolean">true if the object is an instance of the class</return>
    ]]
    IsClass = Reflector.ObjectIsClass

    __Doc__[[
        <desc>Check if the object is extend from the interface</desc>
        <param name="interface"></param>
        <return type="boolean">true if the object is extend from the interface</return>
    ]]
    IsInterface = Reflector.ObjectIsInterface

	__Doc__[[
		<desc>Fire an object's event, to trigger the object's event handlers</desc>
		<param name="event">the event name</param>
		<param name="...">the event's arguments</param>
	]]
	Fire = Reflector.FireObjectEvent

	__Doc__[[
		<desc>Check if the event type is supported by the object</desc>
		<param name="name">the event's name</param>
		<return type="boolean">true if the object has that event type</return>
	]]
	function HasEvent(self, name)
		if type(name) ~= "string" then
			error(("Usage : object:HasEvent(name) : 'name' - string expected, got %s."):format(type(name)), 2)
		end
		return Reflector.HasEvent(Reflector.GetObjectClass(self), name) or false
	end

	__Doc__[[
		<desc>Block some events for the object</desc>
		<param name="...">the event's name list</param>
	]]
	BlockEvent = Reflector.BlockEvent

	__Doc__[[
		<desc>Check if the event is blocked for the object</desc>
		<param name="event">the event's name</param>
		<return type="boolean">true if th event is blocked</return>
	]]
	IsEventBlocked = Reflector.IsEventBlocked

	__Doc__[[
		<desc>Un-Block some events for the object</desc>
		<param name="...">the event's name list</param>
	]]
	UnBlockEvent = Reflector.UnBlockEvent

	ThreadCall = function(self, method, ...)
	    if type(method) == "string" then method = self[method] end
	    if type(method) == "function" then return Threading.ThreadCall(method, self, ...) end
	end
end)
