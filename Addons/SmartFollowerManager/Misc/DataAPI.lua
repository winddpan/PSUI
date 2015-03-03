local _, Addon = ...
local race = Addon.raceID
local raceName = Addon.L.raceName
local specFollower = Addon.specFollower

local API = {}

function API.GetClassSpecNameBySpecID(specID)
	local garrFollowerID = specFollower[specID]
	if garrFollowerID then
		return C_Garrison.GetFollowerClassSpecName(garrFollowerID)
	end
end

function API.GetRaceID(garrFollowerID)
	local id = garrFollowerID
	if not id then
		return
	end
	if type(id) == "string" then
		id = tonumber(id)
	end
	
	return race[id]
end

function API.GetRaceName(garrFollowerID)
	local id = garrFollowerID
	if not id then
		return
	end
	if type(id) == "string" then
		id = tonumber(id)
	end
	
	local rID = race[id]
	if not rID then
		return
	end
	
	local rName = raceName[rID]
	if not rName then
		rName = OTHER
	end
	
	return rName
end

Addon.API = API