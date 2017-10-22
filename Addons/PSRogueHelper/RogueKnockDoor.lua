if select(2, UnitClass("player")) ~= "ROGUE" then return end

local NPC = {
	["96782"] = "鲁希安",
	["93188"] = "墨戈",
	["97004"] = "红发",
}

local function GetNPCGUID()
	local a = UnitGUID("npc")
	return a and select(3, a:find("Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)%-")) or nil
end

local OnGossip = function()
	if IsAltKeyDown() or IsShiftKeyDown() or IsControlKeyDown() then
		return
	end

	if NPC[GetNPCGUID()] then
		SelectGossipOption(1)
	end
end

local f = CreateFrame("Frame") 
f:RegisterEvent("GOSSIP_SHOW") 
f:SetScript("OnEvent", OnGossip)

