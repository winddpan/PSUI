
-- oUF_SimpleConfig: tags
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Tags
-----------------------------

local floor = floor

-- calculating the ammount of latters
local function utf8sub(string, i, dots)
	if string then
	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = string:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then
			return string:sub(1, pos - 1)..(dots and '..' or '')
		else
			return string
		end
	end
	end
end
-- turn hex colors into RGB format
local function hex(r, g, b)
	if r then
		if (type(r) == 'table') then
			if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
		end
		return ('|cff%02x%02x%02x'):format(r * 255, g * 255, b * 255)
	end
end

--tag method: oUF_SimpleConfig:status
L.C.tagMethods["oUF_SimpleConfig:status"] = function(unit,...)
  if UnitAffectingCombat(unit) then
    return "|TInterface\\CharacterFrame\\UI-StateIcon:15:15:0:0:64:64:33:64:0:31|t"
  elseif unit == "player" and IsResting() then
    return "|TInterface\\CharacterFrame\\UI-StateIcon:15:15:0:0:64:64:0:31:0:31|t"
  end
end
--tag event: oUF_Simple:status
L.C.tagEvents["oUF_SimpleConfig:status"] = "PLAYER_REGEN_DISABLED PLAYER_REGEN_ENABLED PLAYER_UPDATE_RESTING"

L.C.tagMethods['PSUI:shortname'] = function(u, r)
	local name = UnitName(r or u)
	return utf8sub(name, 3, false)
end
L.C.tagEvents['PSUI:shortname'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION'

L.C.tagMethods['PSUI:color'] = function(u, r)
	local _, class = UnitClass(u)
	local reaction = UnitReaction(u, "player")
	if UnitIsTapDenied(u) then
		return hex(oUF.colors.tapped)
	elseif (UnitIsPlayer(u)) then
		return hex(oUF.colors.class[class])
	elseif reaction then
		return hex(oUF.colors.reaction[reaction])
	else
		return hex(1, 1, 1)
	end
end
L.C.tagEvents['PSUI:color'] = 'UNIT_HEALTH UNIT_POWER_UPDATE'