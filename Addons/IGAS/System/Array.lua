-- Author      : Kurapica
-- Create Date : 2012/02/08
-- ChangeLog   :
--               2012/05/06 Push, Pop, Shift, Unshift added
--               2012/07/31 Struct supported
--               2012/09/18 Contain method added

_ENV = Module "System.Array" "1.0.0"

namespace "System"

__Doc__[[Array object is used to control a group objects with same class, event handlers can be assign to all objects with one definition]]
class "Array" (function(_ENV)
	inherit "System.Collections.List"

	_ArrayInfo = _ArrayInfo or setmetatable({}, {__mode = "k",})

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Insert object into the array</desc>
		@format [index, ]object
		<param name="index" optional="true">the insert position</param>
		<param name="object">the object need to be inserted</param>
	]]
	function Insert(self, ...)
		if select('#', ...) == 2 then
			local index, value = ...

			if type(index) ~= "number" then
				error("Usage: Array:Insert([index], value) - index must be a number.", 2)
			end

			if value == nil then
				error("Usage: Array:Insert([index], value) - value must not be nil.", 2)
			end

			if index < 1 then
				error("Usage: Array:Insert([index], value) - index must be greater than 0.", 2)
			end

			if index > #self + 1 then index = #self + 1 end

			for i, obj in ipairs(self) do
				if obj == value then
					return i
				end
			end

			if _ArrayInfo[self] and _ArrayInfo[self].IsClass and _ArrayInfo[self].Type then
				if Reflector.ObjectIsClass(value, _ArrayInfo[self].Type) then
					for sc in Reflector.GetAllEvents(_ArrayInfo[self].Type) do
						if _ArrayInfo[self]["_ArrayActive_" .. sc] then
							value[sc].Delegate = System.Task.ThreadCall
						end
						if _ArrayInfo[self]["_ArrayBlock_" .. sc] then
							Reflector.BlockEvent(value, sc)
						end

						if _ArrayInfo[self][sc] then
							value[sc] = _ArrayInfo[self][sc]
						end
					end
				else
					error(("Usage: Array:Insert([index], value) - value must be %s."):format(Reflector.GetFullName(_ArrayInfo[self].Type)), 2)
				end
			elseif _ArrayInfo[self] and _ArrayInfo[self].IsStruct and _ArrayInfo[self].Type then
				value = Reflector.Validate(_ArrayInfo[self].Type, value, "value", "Usage: Array:Insert([index], value) - ")
			end

			tinsert(self, index, value)

			return index
		elseif select('#', ...) == 1 then
			local value = ...

			if _ArrayInfo[self] and _ArrayInfo[self].IsClass and _ArrayInfo[self].Type then
				if Reflector.ObjectIsClass(value, _ArrayInfo[self].Type) then
					for sc in Reflector.GetAllEvents(_ArrayInfo[self].Type) do
						if _ArrayInfo[self]["_ArrayActive_" .. sc] then
							value[sc].Delegate = System.Task.ThreadCall
						end
						if _ArrayInfo[self]["_ArrayBlock_" .. sc] then
							Reflector.BlockEvent(value, sc)
						end

						if _ArrayInfo[self][sc] then
							value[sc] = _ArrayInfo[self][sc]
						end
					end
				else
					error(("Usage: Array:Insert([index], value) - value must be %s."):format(Reflector.GetFullName(_ArrayInfo[self].Type)), 2)
				end
			elseif _ArrayInfo[self] and _ArrayInfo[self].IsStruct and _ArrayInfo[self].Type then
				value = Reflector.Validate(_ArrayInfo[self].Type, value, "value", "Usage: Array:Insert([index], value) - ")
			end

			tinsert(self, value)

			return #self
		else
			error("Usage: Array:Insert([index], value)", 2)
		end
	end

	__Doc__[[
		<desc>Remove object from array</desc>
		<param name="object">the object position or the object itself</param>
		<return>the removed object</return>
	]]
	function Remove(self, index)
		if type(index) ~= "number" then
			for i, ob in ipairs(self) do
				if ob == index then
					index = i
				end
			end

			if type(index) ~= "number" then
				error("Usage: Array:Remove(index) - index must be a number.", 2)
			end
		end

		if not self[index] then
			return
		end

		local value = self[index]

		if _ArrayInfo[self] and _ArrayInfo[self].IsClass and _ArrayInfo[self].Type and Reflector.ObjectIsClass(value, _ArrayInfo[self].Type) then
			for sc in Reflector.GetAllEvents(_ArrayInfo[self].Type) do
				if _ArrayInfo[self]["_ArrayActive_" .. sc] then
					value[sc].Delegate = nil
				end
				if _ArrayInfo[self]["_ArrayBlock_" .. sc] then
					Reflector.UnBlockEvent(value, sc)
				end

				if _ArrayInfo[self][sc] then
					value[sc] = nil
				end
			end
		end

		return tremove(self, index)
	end

	__Doc__[[
		<desc>Check if the event type is supported by the array's element type</desc>
		<param name="event">string, the event's name</param>
		<return type="boolean">true if the array's element's type has the event</return>
	]]
	function HasEvent(self, key)
		return type(key) == "string" and _ArrayInfo[self] and _ArrayInfo[self].IsClass and Reflector.HasEvent(_ArrayInfo[self].Type, key)
	end

	__Doc__[[
		<desc>Active the thread mode for special event</desc>
		<param name="...">the event list</param>
	]]
	function ActiveThread(self, ...)
		if _ArrayInfo[self] and _ArrayInfo[self].IsClass then
			local cls = _ArrayInfo[self].Type
			local name

			if cls then
				for i = 1, select('#', ...) do
					name = select(i, ...)

					if Reflector.HasEvent(cls, name) then
						_ArrayInfo[self]["_ArrayActive_" .. name] = true

						for _, obj in ipairs(self) do
							if Reflector.ObjectIsClass(obj, cls) then
								obj[name].Delegate = System.Task.ThreadCall
							end
						end
					end
				end
			end
		end
	end

	__Doc__[[
		<desc>Check if the thread mode is actived for the event</desc>
		<param name="event">the event's name</param>
		<return type="boolean">true if the event is in thread mode</return>
	]]
	function IsThreadActivated(self, sc)
		return type(sc) == "string" and _ArrayInfo[self] and _ArrayInfo[self].IsClass and _ArrayInfo[self]["_ArrayActive_" .. sc] or false
	end

	__Doc__[[
		<desc>Turn off the thread mode for the scipts</desc>
		<param name="...">the event list</param>
	]]
	function InactiveThread(self, ...)
		if _ArrayInfo[self] and _ArrayInfo[self].IsClass then
			local cls = _ArrayInfo[self].Type
			local name

			if cls then
				for i = 1, select('#', ...) do
					name = select(i, ...)

					if Reflector.HasEvent(cls, name) then
						_ArrayInfo[self]["_ArrayActive_" .. name] = nil

						for _, obj in ipairs(self) do
							if Reflector.ObjectIsClass(obj, cls) then
								obj[name].Delegate = nil
							end
						end
					end
				end
			end
		end
	end

	__Doc__[[
		<desc>Block some event for the object</desc>
		<param name="...">the event list</param>
	]]
	function BlockEvent(self, ...)
		if _ArrayInfo[self] and _ArrayInfo[self].IsClass then
			local cls = _ArrayInfo[self].Type
			local name

			if cls then
				for i = 1, select('#', ...) do
					name = select(i, ...)

					if Reflector.HasEvent(cls, name) then
						_ArrayInfo[self]["_ArrayBlock_" .. name] = true

						for _, obj in ipairs(self) do
							if Reflector.ObjectIsClass(obj, cls) then
								Reflector.BlockEvent(obj, name)
							end
						end
					end
				end
			end
		end
	end

	__Doc__[[
		<desc>Check if the event is blocked for the object</desc>
		<param name="event">the event's name</param>
		<return type="boolean">true if th event is blocked</return>
	]]
	function IsEventBlocked(self, sc)
		return type(sc) == "string" and _ArrayInfo[self] and _ArrayInfo[self].IsClass and _ArrayInfo[self]["_ArrayBlock_" .. sc] or false
	end

	__Doc__[[
		<desc>Un-Block some events for the object</desc>
		<param name="...">the event list</param>
	]]
	function UnBlockEvent(self, ...)
		if _ArrayInfo[self] and _ArrayInfo[self].IsClass then
			local cls = _ArrayInfo[self].Type
			local name

			if cls then
				for i = 1, select('#', ...) do
					name = select(i, ...)

					if Reflector.HasEvent(cls, name) then
						_ArrayInfo[self]["_ArrayBlock_" .. name] = nil

						for _, obj in ipairs(self) do
							if Reflector.ObjectIsClass(obj, cls) then
								Reflector.UnBlockEvent(obj, name)
							end
						end
					end
				end
			end
		end
	end

	__Doc__[[
		<desc>add object into Array's end</desc>
		<param name="...">the object list</param>
	]]
	function Push(self, ...)
		for i = 1, select('#', ...) do
			self:Insert((select(i, ...)))
		end
	end

	__Doc__[[
		<desc>Remove and return the Array's last object</desc>
		<return>the removed object</return>
	]]
	function Pop(self)
		local value = self[#self]

		if value then
			self:Remove(#self)

			return value
		end
	end

	__Doc__[[
		<desc>Add value into the Array's first position</desc>
		<param name="...">the object list</param>
	]]
	function Unshift(self, ...)
		for i = select('#', ...), 1, -1 do
			self:Insert(1, select(i, ...))
		end
	end

	__Doc__[[
		<desc>Remove and return the Array's first element</desc>
		<return>the removed object</return>
	]]
	function Shift(self)
		local value = self[1]

		if value then
			self:Remove(1)

			return value
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Get the array element's type]]
	property "Type" {
		Get = function(self)
			return _ArrayInfo[self] and _ArrayInfo[self].Type
		end,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Array(self, cls)
		if type(cls) == "string" then
			cls = Reflector.ForName(cls)
		end

		if cls and Reflector.IsClass(cls) then
			_ArrayInfo[self] = {
				Type = cls,
				IsClass = true,
			}
		elseif cls and Reflector.IsStruct(cls) then
			_ArrayInfo[self] = {
				Type = cls,
				IsStruct = true,
			}
		end
	end

	------------------------------------------------------
	-- Exist checking
	------------------------------------------------------

	------------------------------------------------------
	-- __index for class instance
	------------------------------------------------------
	function __index(self, key)
		if type(key) == "string" and _ArrayInfo[self] and _ArrayInfo[self].IsClass and Reflector.HasEvent(_ArrayInfo[self].Type, key) then
			return _ArrayInfo[self]["_ArrayEvent_"..key]
		end
	end

	------------------------------------------------------
	-- __newindex for class instance
	------------------------------------------------------
	function __newindex(self, key, value)
		if type(key) == "string" and _ArrayInfo[self] and _ArrayInfo[self].IsClass and Reflector.HasEvent(_ArrayInfo[self].Type, key) then
			if value == nil or type(value) == "function" then
				_ArrayInfo[self]["_ArrayEvent_"..key] = value

				_ArrayInfo[self][key] = value and function(obj, ...)
					for i = 1, #self do
						if rawget(self, i) == obj then
							return value(self, i, ...)
						end
					end
				end

				for _, obj in ipairs(self) do
					if Reflector.ObjectIsClass(obj, _ArrayInfo[self].Type) then
						obj[key] = _ArrayInfo[self][key]
					end
				end
			else
				error(("The %s is the event name of this Array's elements, it's value must be nil or a function."):format(key), 2)
			end
		elseif type(key) == "number" then
			error("Use Array:Insert(index, obj) | Array:Remove(index) to modify this array.", 2)
		end

		return rawset(self, key, value)
	end
end)
