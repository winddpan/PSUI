-- Author      : Kurapica
-- Create Date : 2011/02/28
-- ChangeLog   :
--               2011/10/24 can use code like L"XXXX".
--               2013/01/07 Recode with new class system.

Module "System.Locale" "1.3.0"

namespace "System"

_GameLocale = GetLocale and GetLocale() or "enUS"
if _GameLocale == "enGB" then
	_GameLocale = "enUS"
end

__Doc__[[Locale object is used as localization strings storage and manager]]
class "Locale"

	_Locale = _Locale or {}

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		for name, loc in pairs(_Locale) do
			if loc == self then
				_Locale[name] = nil
				break
			end
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Locale(self, name)
		name = type(name) == "string" and name:match("%S+")

		if not name or name == "" then return end

		_Locale[name] = self
	end

	------------------------------------------------------
	-- Exist checking
	------------------------------------------------------
	function __exist(name)
		if type(name) ~= "string" then
			return
		end

		name = type(name) == "string" and name:match("%S+")

		if not name or name == "" then return end

		return _Locale[name]
	end

	------------------------------------------------------
	-- __index for class instance
	------------------------------------------------------
	function __index(self, key)
		if type(key) == "string" then
			rawset(self, key, key)
			return rawget(self, key)
		else
			error(("No '%s' keeped in the locale table."):format(tostring(key)))
		end
	end

	------------------------------------------------------
	-- __newindex for class instance
	------------------------------------------------------
	function __newindex(self, key, value)
		if type(key) ~= "number" and type(key) ~= "string" then
			error("Locale[key] = value : 'key' - number or string expected.")
		end

		if type(value) == "string" or ( type(key) == "string" and value == true ) then
			value = (value == true and key) or value
			rawset(self, key, value)
		else
			error("Locale[key] = value : 'value' - tring expected.")
		end
	end

	------------------------------------------------------
	-- __call for class instance
	------------------------------------------------------
	function __call(self, key)
		return self[key]
	end
endclass "Locale"

------------------------------------
--- Create or get a localization file
-- @name IGAS:NewLocale
-- @class function
-- <param name="name">always be the addon's name</param>
-- <param name="language">the language' name, such as "zhCN"</param>
-- <param name="asDefault">if this language is default, always set to true if the locale is "enUS"</param>
-- <return type="if">"locale" is setted and equal to the game's version or "isDefault" is true, return the local table, else nil</return>
-- <usage>L = IGAS:NewLocale("HelloWorld", "zhCN")</usage>
------------------------------------
function IGAS:NewLocale(name, language, asDefault)
	if type(name) ~= "string" then
		error(("Usage : IGAS:NewLocale(name[, language, asDefault]) : 'name' - string expected, got %s."):format(type(name)), 2)
	end

	if language ~= nil and type(language) ~= "string" then
		error(("Usage : IGAS:NewLocale(name[, language, asDefault]) : 'language' - string expected, got %s."):format(type(language)), 2)
	end

	name = name:match("%S+")

	if not name or name == "" then return end

	if not asDefault and language and language:lower() ~= _GameLocale:lower() then
		return
	end

	return Locale(name)
end
