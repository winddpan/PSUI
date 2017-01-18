-- IGAS
-- In-Game Addon System
-- Author: kurapica.igas@gmail.com
-- Create Date : 2011/03/01
-- ChangeLog   :

local version = 7

if not IGAS:NewAddon("IGAS", version) then
	return
end

namespace "System"

----------------------------------------------
-- Addon Initialize
----------------------------------------------
-- Keep this setting for gui lib, no need to set _AutoWrapper in other addons.
_AutoWrapper = false

----------------------------------------------
-- Looger
----------------------------------------------
Log = System.Logger("IGAS")

Log.TimeFormat = "%X"
Log:SetPrefix(1, "[IGAS][Trace]")
Log:SetPrefix(2, "[IGAS][Debug]")
Log:SetPrefix(3, "[IGAS][Info]")
Log:SetPrefix(4, "[IGAS][Warn]")
Log:SetPrefix(5, "[IGAS][Error]")
Log:SetPrefix(6, "[IGAS][Fatal]")
Log.LogLevel = 3

Log:AddHandler(print)

----------------------------------------------
-- Short API
----------------------------------------------
strlen = string.len
strformat = string.format
strfind = string.find
strsub = string.sub
strbyte = string.byte
strchar = string.char
strrep = string.rep
strsub = string.gsub
strupper = string.upper
strtrim = strtrim or function(s)
  return (s:gsub("^%s*(.-)%s*$", "%1")) or ""
end
strmatch = string.match

wipe = wipe or function(t)
	for k in pairs(t) do
		t[k] = nil
	end
	return t
end

geterrorhandler = geterrorhandler or function()
	return print
end

errorhandler = errorhandler or function(err)
	return geterrorhandler()(err)
end

tblconcat = table.concat
tinsert = tinsert or table.insert
tremove = tremove or table.remove

floor = math.floor
ceil = math.ceil
log = math.log
pow = math.pow
min = math.min
max = math.max
random = math.random

date = date or (os and os.date)

----------------------------------------------
-- Localization
----------------------------------------------
L = System.Locale("IGAS")

----------------------------------------------
-- Event Handler
----------------------------------------------
function OnLoad(self)
	-- SavedVariables
	self:AddSavedVariable("IGAS_DB")
	self:AddSavedVariable("IGAS_DB_Char")

	-- Log Level
	if type(IGAS_DB.LogLevel) == "number" then
		Log.LogLevel = IGAS_DB.LogLevel
	end

	-- Slash command
	self:AddSlashCmd("/igas")
end

function OnSlashCmd(self, option, info)
	if option and option:lower() == "log" then
		if tonumber(info) then
			Log.LogLevel = tonumber(info)
			IGAS_DB.LogLevel = Log.LogLevel

			Log(3, "%s's LogLevel is switched to %d.", _Name, Log.LogLevel)
		else
			Log(3, "%s's LogLevel is %d for now.", _Name, Log.LogLevel)
		end
	end
end

----------------------------------------------
-- WOW Special Definitions
----------------------------------------------

------------------------------------------------------
-- LocaleString
------------------------------------------------------
__StructType__(StructType.Custom)
struct "LocaleString"
	function LocaleString(value)
		if type(value) ~= "string" then
			error(format("%s must be a string, got %s.", "%s", type(value)))
		end
		return value
	end
endstruct "LocaleString"

------------------------------------------------------
-- PositiveNumber
------------------------------------------------------
struct "StringNumber"
	function StringNumber(value)
		if type(value) ~= "number" and type(value) ~= "string" then error(format("%s must be a number or string, got %s.", "%s", type(value))) end
	end
endstruct "StringNumber"

struct "TableUserdata"
	function TableUserdata(value)
		if type(value) ~= "table" and type(value) ~= "userdata" then error(format("%s must be a table or userdata, got %s.", "%s", type(value))) end
	end
endstruct "TableUserdata"

__AttributeUsage__{AttributeTarget = AttributeTargets.Method + AttributeTargets.Property, Inherited = false}
__Sealed__() __Unique__()
__Doc__ [[Whether the method or property is optional to be overrided]]
class "__Optional__" { IAttribute }

------------------------------------
--- Create or get the logger for the given log name
-- @name IGAS:NewLogger
-- @class function
-- @param name always be the addon's name, using to manage an addon's message
-- @return Logger used for the log name
-- @usage IGAS:NewLogger("IGAS")
------------------------------------
function IGAS:NewLogger(name)
	return System.Logger(name)
end

------------------------------------
--- Get the namespace for the given name
-- @name IGAS:GetNameSpace
-- @class function
-- @param name the namespace's full name
-- @return namespace
-- @usage IGAS:GetNameSpace("System")
------------------------------------
function IGAS:GetNameSpace(ns)
	return System.Reflector.GetNameSpaceForName(ns)
end
