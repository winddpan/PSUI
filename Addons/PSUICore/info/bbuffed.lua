local classc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass('player'))] 

local raidBuffs = CreateFrame('frame', "Raid Buffs", UIParent)
raidBuffs:SetPoint("TOP", UIParent,  -40, -10)
raidBuffs:SetSize(20, 20)

local potentialBuffs = {
    ["Kings"] = {GetSpellInfo(203538)},
	["Wise"] = {GetSpellInfo(203539)},
	["Might"] = {GetSpellInfo(203528)},
	["Rune"] = {GetSpellInfo(224001)},
	["Food"] = {GetSpellInfo(225604), GetSpellInfo(225599), GetSpellInfo(160894), 
	GetSpellInfo(174306), GetSpellInfo(160881), GetSpellInfo(174307)},
    ["Flask"] = {GetSpellInfo(188033), GetSpellInfo(188034), GetSpellInfo(188031), GetSpellInfo(188035)}
}

local index = 0
local lastframe = nil
local textFrames = {}
for k, v in pairs(potentialBuffs) do
	index = index + 1;
	local text = raidBuffs:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	text:SetFont("fonts\\1.ttf", 14, "OUTLINE")
	text:SetTextColor(.4, .4, .4)
	text:SetShadowColor(0,0,0,0)
	text:SetText(k)
	
	if (index == 1) then
		text:SetPoint("RIGHT", raidBuffs, "RIGHT", 0, 0)
	else
		text:SetPoint("RIGHT", lastframe, "LEFT", -10, 0)
	end
	
	lastframe = text
	textFrames[k] = text
end


raidBuffs:RegisterEvent("UNIT_AURA")
raidBuffs:RegisterEvent("PLAYER_ENTERING_WORLD")
raidBuffs:SetScript("OnEvent", function(arg1, arg2, unit)
	if (unit == "player") then
		for k, v in pairs(potentialBuffs) do
			local found = false
			for u = 1, #v do
				local name = select(1, UnitBuff('player', v[u]))
				if (name) then
					found = true
				end
			end
			
			if (found) then
				textFrames[k]:SetTextColor(classc.r,classc.g,classc.b)
			else
				textFrames[k]:SetTextColor(.4, .4, .4)		
			end
		end
	end
end)