--[[
	Curation settings for tullaCC
--]]

local AddonName, Addon = ...
local _G = _G

local defaults = {
	-- glowy animation at the end of a cooldown
	drawBling = false,

	-- show/hide the cooldown animation itself
	drawEdge = false,

	--show hide a glowy edge on the cooldown
	drawSwipe = true,

	--what font to use
	fontFace = function()
		--return _G['STANDARD_TEXT_FONT']
		return "Interface\\AddOns\\"..AddonName.."\\media\\number.ttf"
	end,

	--the base font size to use at a scale of 1
	fontSize = 15,

	--the minimum scale we want to show cooldown counts at, anything below this will be hidden
	minScale = 0.6,

	--the minimum number of seconds a cooldown's duration must be to display text
	minDuration = 2.0,
	
	--the minimum number of seconds a cooldown must be to display in the expiring format
	expiringDuration = 5,

	--format for timers that are soon to expire
	expiringFormat = '|cffff2020%d|r',

	--format for timers that have seconds remaining
	secondsFormat = '|cffffffff%d|r',

	--format for timers that have minutes remaining
	minutesFormat = '|cffffffff%dm|r',

	--format for timers that have hours remaining
	hoursFormat = '|cff66ffff%dh|r',

	--format for timers that have days remaining
	daysFormat = '|cff6666ff%dd|r' 
}

Addon.Config = setmetatable({}, {
	__index = function(t, k)
		local value = defaults[k]

		if value and type(value) == 'function' then
			return value()
		end

		return value
	end
})

--make config editable
do
	local gAddon = _G[AddonName] or {}

	gAddon.Config = Addon.Config

	_G[AddonName] = gAddon
end
