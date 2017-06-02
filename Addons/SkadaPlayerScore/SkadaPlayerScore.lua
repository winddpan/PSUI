local addonName, vars = ...
local Skada = Skada;

local SPS = LibStub("AceAddon-3.0"):NewAddon("SkadaPlayerScore");
local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false);
local Toast = LibStub("LibToast-1.0");

local mod = Skada:NewModule(L["Player Score"]);
local myself = UnitName("player");
local myspecrole = "NONE";
local myscore = 0;
local MINIMUMDT	= 200000; -- ie. need to do 10M dmg/heal to score 100 when taking no damage at all

local defaultmultipliers = {
	damage = {
		NONE    = 1.0,
		TANK    = 1.5, -- tanks do 50% less damage than dpsers these days
		HEALER  = 1.0,
		DAMAGER = 2.0,
	},
	healing = {
		NONE    = 1.0,
		TANK    = 1.5,
		HEALER  = 2.0,
		DAMAGER = 1.0,
	},
	mitigation = {
		NONE    = 1.0,
		TANK    = 2.0,
		HEALER  = 1.0,
		DAMAGER = 1.0,
	},
};

local function getdifficultyname()
	if (IsInInstance()) then
		local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize = GetInstanceInfo();
		return difficultyName;
	else
		return L["Normal"];
	end
end

local function formatscore(score,diff)
	if (diff) then
		return format("%.1f (%.1f)",score,diff);
	else
		return format("%.1f",score);
	end
end

local function toasthighscoreself(toast,text)
    toast:SetTitle(L["Personal High Score!"]);
    toast:SetText(text);
    toast:SetIconTexture("Interface\\FriendsFrame\\Battlenet-WoWicon");
	toast:SetSoundFile("Sound\\Spells\\LevelUp.ogg");
end

local function toasthighscoreraid(toast,text)
    toast:SetTitle(L["Raid High Score!"]);
    toast:SetText(text);
    toast:SetIconTexture("Interface\\FriendsFrame\\Battlenet-WoWicon");
	toast:SetSoundFile("Sound\\interface\\UI_GuildLevelUp.ogg");
end

local selftoasttext = "?";
local selfimprovement = 0;
local function toastselftimer()
--	local oldToaster = _G.Toaster;
--	_G.Toaster = SPSToaster;
	Toast:Spawn("HIGHSCORESELF",selftoasttext);
    Skada:Print(L["Personal High Score!"].." (+"..formatscore(selfimprovement)..")");
--	_G.Toaster = oldToaster;
end

local raidtoasttext = "?";
local raidimprovement = 0;
local function toastraidtimer()
--	local oldToaster = _G.Toaster;
--	_G.Toaster = SPSToaster;
	Toast:Spawn("HIGHSCORERAID",raidtoasttext);
    Skada:Print(L["Raid High Score!"].." (+"..formatscore(raidimprovement)..")");
--	_G.Toaster = oldToaster;
end

-- defer the window and sounds so as not to overlap with bossmod victory sounds etc.
local function shownewhighscore(isself,difficulty,mobname,score,previous)
	local str = ("\n%s %s\n|cFF00FF00%s %s|r\n|cFFFF0000%s %s|r\n\n"):format(difficulty,mobname,L["New record"],formatscore(score),L["Previous best"],formatscore(previous));
	
	if (isself) then
		selftoasttext = str;
		selfimprovement = score - previous;
		C_Timer.After(5,toastselftimer);
	else
		raidtoasttext = str;
		raidimprovement = score - previous;
		C_Timer.After(10,toastraidtimer);
	end
end

local function getmitigation(player)
	local mitigation = 0;
	local spellname,spell;
	
	for spellname,spell in pairs(player.damagetakenspells) do
		mitigation = mitigation + spell.blocked + spell.absorbed + spell.resisted;
	end
	return mitigation;
end

local function getraidscore(set)
	local score,myscore,diff,mydiff = 0,0,nil,nil;
	
	if (set) then
		if (#set.players >= 5) then -- need at least a full group to do raid scoring
			for i, player in ipairs(set.players) do
				score = score + player.score;
				if (player.name == myself) then
					myscore = player.score
				end
			end
			local count = #set.players;
			if (count) then
				score = score / count;
			end
		else -- personal score only
			for i, player in ipairs(set.players) do
				if (player.name == myself) then
					myscore = player.score
					break;
				end
			end
		end
-- deltas
		if (PScoresRaid and PScoresRaid[set.difficultyname] and PScoresRaid[set.difficultyname][set.mobname]) then
			diff = score - PScoresRaid[set.difficultyname][set.mobname];
		end
		if (PScoresChar and PScoresChar[set.difficultyname] and PScoresChar[set.difficultyname][set.mobname]) then
			mydiff = myscore - PScoresChar[set.difficultyname][set.mobname];
		end
	end
	return score,myscore,diff,mydiff;
end

local function checkhighscores(set)
	if (set.endtime and set.gotboss) then
		local raid,myself = getraidscore(set);
-- personal
		PScoresChar = PScoresChar or {};
		PScoresChar[set.difficultyname] = PScoresChar[set.difficultyname] or {};
		PScoresChar[set.difficultyname][set.mobname] = PScoresChar[set.difficultyname][set.mobname] or 0;
		if (myself > PScoresChar[set.difficultyname][set.mobname]+0.05) then
			shownewhighscore(true,set.difficultyname,set.mobname,myself,PScoresChar[set.difficultyname][set.mobname]);
			PScoresChar[set.difficultyname][set.mobname] = myself;
		end
-- group
		if (raid > 0) then
			PScoresRaid = PScoresRaid or {};
			PScoresRaid[set.difficultyname] = PScoresRaid[set.difficultyname] or {};
			PScoresRaid[set.difficultyname][set.mobname] = PScoresRaid[set.difficultyname][set.mobname] or 0;
			if (raid > PScoresRaid[set.difficultyname][set.mobname]+0.05) then
				shownewhighscore(false,set.difficultyname,set.mobname,raid,PScoresRaid[set.difficultyname][set.mobname]);
				PScoresRaid[set.difficultyname][set.mobname] = raid;
			end
		end
	end
end

-- Tooltip for a specific player.
local function score_tooltip(win, id, label, tooltip)
	local set = win:get_selected_set();
	local player = Skada:find_player(set, id);

	if player then
		local me = player.name == myself;
		if (me) then
			tooltip:AddLine(L["My Score"]);
		else
			tooltip:AddLine(player.name..L["'s Score"]);
		end
		tooltip:AddDoubleLine(L["Damage done"], Skada:FormatNumber(player.damage),255,255,255,255,255,255);
		tooltip:AddDoubleLine(L["Healing done"], Skada:FormatNumber(player.healing),255,255,255,0,255,0);
		tooltip:AddDoubleLine(L["Damage taken"], Skada:FormatNumber(player.damagetaken),255,255,255,255,0,0);
		tooltip:AddDoubleLine(L["Damage mitigated"], Skada:FormatNumber(getmitigation(player)),255,255,255,255,255,0);
		tooltip:AddLine(" ");
		tooltip:AddDoubleLine(L["Score"], formatscore(player.score),255,255,255,255,255,255);
		if (me and set.gotboss and set.endtime) then
			if (PScoresChar and PScoresChar[set.difficultyname]) then
				tooltip:AddDoubleLine(L["My High Score"], formatscore(PScoresChar[set.difficultyname][set.mobname] or 0),255,255,255,255,255,255);
			end
			if (PScoresRaid and PScoresRaid[set.difficultyname]) then
				tooltip:AddDoubleLine(L["Raid High Score"], formatscore(PScoresRaid[set.difficultyname][set.mobname] or 0),255,255,255,255,255,255);
			end
		end
	end
end

-- Update the data set displayed
function mod:Update(win, set)
	local maxscore = 0;
	local nr = 1;
	local dt,mit;

	for i, player in ipairs(set.players) do
		dt = player.damagetaken;
		if (set.endtime and player.mitigated) then -- use the final value in a finished set
			mit = player.mitigated;
		else
			mit = getmitigation(player);
			player.mitigated = mit;
		end
-- solo legacy content role fix (and GetSpecialisation change potentially returning main stat number instead of role)
		if (myself == player.name and (not player.role or player.role == "NONE" or type(player.role) == "number")) then
			player.role = myspecrole;
		end
-- saved sets from older Skada versions can have nil role
		if (not player.role) then
			player.role = "NONE";
		elseif (player.role == "TANK") then -- tanks scores would always be last due to their role, so reward better mitigation with a higher score
			dt = dt - mit;
		end
		if (dt < MINIMUMDT) then
			player.score = 0;
			if (player.role ~= "NONE") then -- pet? eg. Guardian of Ancient Kings
				dt = MINIMUMDT;
			end
		end
		-- print(player.name,player.role,dt,myspecrole);
		if (dt >= MINIMUMDT) then
			if (not PSMultipliers) then
				PSMultipliers = defaultmultipliers;
			end
			player.score = (player.damage * (PSMultipliers.damage[player.role] or 1) + player.healing * (PSMultipliers.healing[player.role] or 1) + mit * (PSMultipliers.mitigation[player.role] or 1)) / dt;
			--[[if (player.score > 100) then
				player.score = 100;
			end]]
			if (player.score > maxscore) then
				maxscore =  player.score;
			end
-- add the bars to the window
			if (win) then
				local d = win.dataset[nr] or {};
				win.dataset[nr] = d;
				d.label = player.name;
				d.value = player.score;
				d.valuetext = formatscore(player.score);
				d.id = player.id;
				d.class = player.class;
				d.role = player.role; -- TANK,HEALER,DAMAGER,NONE
				nr = nr + 1;
			end
		end
	end
	if (win) then
		win.metadata.maxvalue = maxscore;
	end
end

function mod:OnEnable()
	mod.metadata = {showspots = true, tooltip=score_tooltip}
	Skada:AddMode(self);
	Skada:AddFeed(L["Raid Score"], function()
		return mod:GetSetSummary(Skada.current);
	end)
end

function mod:OnDisable()
	Skada:RemoveMode(self);
	Skada:RemoveFeed(L["Raid Score"]);
end

function mod:AddToTooltip(set, tooltip)
	local raid,me,rdiff,mydiff = getraidscore(set);
	tooltip:AddDoubleLine(L["Raid Score"],formatscore(raid,rdiff),1,1,1);
	tooltip:AddDoubleLine(L["Player Score"],formatscore(me,mydiff),1,1,1);
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.score then
		player.score = 0;
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
	if not set.difficultyname then
		set.difficultyname = getdifficultyname();
	end
	local id, name, description, icon, --[[background,]] role = GetSpecializationInfo(GetSpecialization());
	myspecrole = role; -- when doing legacy content solo, player.role is not set by Skada
end

function mod:GetSetSummary(set) -- return a string
	local raid,me,rdiff,mydiff = getraidscore(set);
	return ("%s [%s]"):format(formatscore(me,mydiff),formatscore(raid,rdiff));
end

function mod:SetComplete(set)
	mod:Update(nil,set); -- force player score calcs even if not the current module
	checkhighscores(set); -- do a high score check now
end

-- slash commands
local function printscores(diff,name,list)
	local boss,score;
	print(diff..L[" high scores for "]..name.."...");
	for boss,score in pairs(list) do
		print("   "..boss.." : "..formatscore(score));
	end
end

local function printallscores(name,main)
	print(L["All high scores..."]);
	if (main) then
		local diff,list;
		for diff, list in pairs(main) do
			printscores(diff,name,list);
			print(" ");
		end
	end
end

local function printmultipliers(name,multipliers)
	print(L["Action"].." "..name);
	print("   "..L["Damager"].." "..formatscore(multipliers.DAMAGER));
	print("   "..L["Healer"].." "..formatscore(multipliers.HEALER));
	print("   "..L["Tank"].." "..formatscore(multipliers.TANK));
end

local function setnewmultipliers(name,multipliers,strd,strh,strt)
	local d,h,t = tonumber(strd),tonumber(strh),tonumber(strt);
	if (d and h and t) then
		multipliers.TANK = t;
		multipliers.HEALER = h;
		multipliers.DAMAGER = d;
		printmultipliers(name,multipliers);
	else
		print(strd,strh,strt,"input error: 3 numbers expected");
	end
end

local function handler(msg)
    local set, diff = msg:match("^(%S*)%s*(.-)$");
	local d,h,t = diff:match("([%d%.%,]+) ([%d%.%,]+) ([%d%.%,]+)"); -- three floating point numbers

	if (not PSMultipliers) then
		PSMultipliers = defaultmultipliers;
	end
	if (not diff or strlen(diff)==0) then
		diff = L["all"];
	end
	
	if (set == "test") then
		shownewhighscore(true ,"test difficulty","test enemy",9.5,0);
		shownewhighscore(false,"test difficulty","test enemy",5,4);
	elseif (set == L["defaults"]) then
		PSMultipliers = defaultmultipliers;
	elseif (set == L["multipliers"]) then
		printmultipliers(L["Damage"],PSMultipliers.damage);
		printmultipliers(L["Healing"],PSMultipliers.healing);
		printmultipliers(L["Mitigation"],PSMultipliers.mitigation);
	elseif (set == L["Damage"]) then
		setnewmultipliers(set,PSMultipliers.damage,d,h,t);
	elseif (set == L["Healing"]) then
		setnewmultipliers(set,PSMultipliers.healing,d,h,t);
	elseif (set == L["Mitigation"]) then
		setnewmultipliers(set,PSMultipliers.mitigation,d,h,t);
	elseif ((set == L["raid"] or set == L["self"]) and diff == L["all"]) then
		if (set == L["raid"]) then
			printallscores(L["raid"],PScoresRaid);
		else
			printallscores(myself,PScoresChar);
		end
	elseif (set == L["raid"] and diff and strlen(diff)>0 and PScoresRaid[diff] ~= nil) then
		printscores(diff,L["raid"],PScoresRaid[diff]);
	elseif (set == L["self"] and diff and strlen(diff)>0 and PScoresChar[diff] ~= nil) then
		printscores(diff,myself,PScoresChar[diff]);
	else
		print("|cFFFFFF00"..L["Skada Player Score options"].."|cFFFF0000 v"..GetAddOnMetadata(addonName,"Version"));
		print("<"..L["self"].." || "..L["raid"].."> ["..L["all"].." || "..L["<difficulty>"].."] : "..L["Show the high scores for a difficulty (default all)"]);
		print(L["multipliers"].." : "..L["Show score multipliers for each role and action"]);
		print("<"..L["Action"].."> <"..L["Damager"].."> <"..L["Healer"].."> <"..L["Tank"].."> : "..L["Change the score multipliers for an action (Damage or Healing or Mitigation)"]);
		print(L["defaults"].." : "..L["Set score multipliers back to their defaults"]);
	end
end

SLASH_SPSSLASH1 = "/sps"
SlashCmdList["SPSSLASH"] = handler;

-- tooltip stuff
local function spstooltiphook(self)
	if (not InCombatLockdown()) then
		local name = self:GetUnit();
		local diff = getdifficultyname();
		if (PScoresChar and PScoresChar[diff] and PScoresChar[diff][name]) then
			self:AddDoubleLine(L["My High Score"], formatscore(PScoresChar[diff][name]),255,255,255,255,255,255);
		end
		if (PScoresRaid and PScoresRaid[diff] and PScoresRaid[diff][name]) then
			self:AddDoubleLine(L["Raid High Score"], formatscore(PScoresRaid[diff][name]),255,255,255,255,255,255);
		end
	end
end

GameTooltip:HookScript("OnTooltipSetUnit",spstooltiphook);
Toast:Register("HIGHSCORESELF",toasthighscoreself);
Toast:Register("HIGHSCORERAID",toasthighscoreraid);
