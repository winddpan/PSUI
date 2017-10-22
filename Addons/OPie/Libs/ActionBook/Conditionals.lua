local _, T = ...
if T.SkipLocalActionBook then return end
local KR, EV = assert(T.ActionBook:compatible("Kindred", 1,12), "A compatible version of Kindred is required"), T.Evie
local playerClassLocal, playerClass = UnitClass("player")

local safequote do
	local r = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
	function safequote(s)
		return (("%q"):format(s):gsub("[{}u]", r))
	end
end

local RegisterStateConditional do
	local f = CreateFrame("FRAME", nil, nil, "SecureHandlerAttributeTemplate")
	f:SetFrameRef("KR", KR:seclib())
	f:Execute('KR, cndName, curValue = self:GetFrameRef("KR"), newtable(), newtable()')
	f:SetAttribute("_onattributechanged", [[--
		local state = name:match("^state%-(.+)")
		if state and value ~= "_" then
			KR:RunAttribute("UpdateStateConditional", cndName[state], value, curValue[state] or "")
			curValue[state] = value
		end
	]])
	function RegisterStateConditional(name, forName, conditional, usesExtendedConditionals)
		f:SetAttribute(forName, "_")
		f:Execute(([[-- KR-InternalStateConditionalRemap
			local name, forName, conditional, isExt = %q, %q, %s, %s
			cndName[name] = forName
			if isExt then
				KR:SetAttribute("frameref-RegisterStateDriver-frame", self)
				KR:RunAttribute("RegisterStateDriver", name, conditional)
			else
				RegisterStateDriver(self, name, conditional)
			end
		]]):format(name, forName, safequote(conditional), usesExtendedConditionals and 1 or "nil"))
	end
end

do -- zone:Zone/Sub Zone
	local function onZoneUpdate()
		local cz
		for i=1,4 do
			local z = (i == 1 and GetRealZoneText or i == 2 and GetSubZoneText or i == 3 and GetZoneText or GetMinimapZoneText)()
			if z and z ~= "" then
				cz = (cz and (cz .. "/") or "") .. z
			end
		end
		KR:SetStateConditionalValue("zone", cz or false)
	end
	onZoneUpdate()
	EV.RegisterEvent("ZONE_CHANGED", onZoneUpdate)
	EV.RegisterEvent("ZONE_CHANGED_INDOORS", onZoneUpdate)
	EV.RegisterEvent("ZONE_CHANGED_NEW_AREA", onZoneUpdate)
	EV.RegisterEvent("PLAYER_ENTERING_WORLD", onZoneUpdate)
end
do -- me:Player Name/Class
	KR:SetStateConditionalValue("me", UnitName("player") .. "/" .. playerClassLocal .. "/" .. playerClass)
end
do -- known:spell id
	KR:SetSecureExecConditional("known", [=[-- KR_KnownSpell
		local ids = ...
		for sid in (type(ids) == "string" and ids or ""):gmatch("[^/]+") do
			local id = tonumber(sid:match("^%s*(%d+)%s*$"))
			if id and (FindSpellBookSlotBySpellID(id, true) or FindSpellBookSlotBySpellID(id, false)) then
				return true
			end
		end
		return false
	]=])
	local f = CreateFrame("FRAME")
	f:SetScript("OnUpdate", function(self)
		self:Hide()
		KR:PokeConditional("known")
	end)
	f:SetScript("OnEvent", f.Show)
	f:RegisterEvent("LEARNED_SPELL_IN_TAB")
	f:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
end
do -- spec:id/name
	local _, _, cid = UnitClass("player")
	local function sync()
		local idx, s = GetSpecialization(), "-1/unspec"
		if idx then
			local id, name = GetSpecializationInfoForClassID(cid, idx)
			if id and name then
				s = id .. "/" .. name
			end
		end
		if idx then
			s = s .. "/" .. idx
		end
		KR:SetStateConditionalValue("spec", s)
	end
	EV.PLAYER_SPECIALIZATION_CHANGED = sync
	sync()
end
do -- form:token
	if playerClass == "DRUID" then
		KR:SetAliasConditional("stance", "form")
		local map, curCnd, pending = {
			[GetSpellInfo(40120)]="/flight",
			[GetSpellInfo(33943)]="/flight",
			[GetSpellInfo(1066)]="/aquatic",
			[GetSpellInfo(783)]="/travel",
			[GetSpellInfo(24858)]="/moon/moonkin",
			[GetSpellInfo(768)]="/cat",
			[GetSpellInfo(171745) or 1]="/cat",
			[GetSpellInfo(5487)]="/bear",
			[GetSpellInfo(114282)]="/treant",
			[GetSpellInfo(210053)]="/stag",
		}, nil
		local function sync()
			local s = ""
			for i=1,10 do
				local _, name = GetShapeshiftFormInfo(i)
				s = ("%s[form:%d] %d%s;"):format(s, i,i, map[name] or "")
			end
			if curCnd ~= s then
				RegisterStateConditional("form", "form", s, false)
			end
			pending = nil
			return "remove"
		end
		EV.RegisterEvent("PLAYER_LOGIN", sync)
		EV.RegisterEvent("UPDATE_SHAPESHIFT_FORMS", function()
			if not InCombatLockdown() then
				sync()
			elseif not pending then
				pending = 1
				EV.RegisterEvent("PLAYER_REGEN_ENABLED", sync)
			end
		end)
	end
end
do -- talent:tier.num/name
	local cur, levels = false, CLASS_TALENT_LEVELS[playerClass] or CLASS_TALENT_LEVELS.DEFAULT
	local function updateTalents()
		local s
		for tier=1, MAX_TALENT_TIERS do
			for column=1, 3 do
				local _, name, _, selected = GetTalentInfo(tier, column, 1)
				if name and selected then
					s = (s and s .. "/" or "") .. tier .. "." .. column .. "/" .. levels[tier] .. "." .. column .. "/" .. name
				end
			end
		end
		if s ~= cur then
			cur = s
			KR:SetStateConditionalValue("talent", cur or "")
		end
	end
	EV.RegisterEvent("PLAYER_TALENT_UPDATE", updateTalents)
	updateTalents()
end
do -- instance:arena/bg/ratedbg/raid/instance/scenario + draenor/pandaria
	local mapTypes = {
		party="dungeon", pvp="battleground/bg", ratedbg="ratedbg/rgb", none="world",
		[1116]="world/draenor", [1464]="world/draenor", [1191]="world/draenor/ashran/worldpvp",
		[870]="world/pandaria", [1064]="world/pandaria",
		[530]="world/outland", [571]="world/northrend",
		[1220]="world/broken isles",
	}
	for n in ("1158 1331 1159 1152 1330 1153"):gmatch("%d+") do
		mapTypes[tonumber(n)] = "world/draenor/garrison"
	end
	EV.RegisterEvent("PLAYER_ENTERING_WORLD", function()
		local _, itype, did, _, _, _, _, imid = GetInstanceInfo()
		if imid and mapTypes[imid] then
			itype = mapTypes[imid]
		elseif itype == "pvp" and IsRatedBattleground() then
			itype = "ratedbg"
		elseif itype == "none" and IsInActiveWorldPVP() then
			itype = "worldpvp"
		elseif itype == "raid" then
			if did == 7 then
				itype = "lfr"
			end
		end
		KR:SetStateConditionalValue("in", mapTypes[itype] or itype)
	end)
	KR:SetAliasConditional("instance", "in")
	KR:SetStateConditionalValue("in", "daze")
end
do -- petcontrol
	local hasControl = (playerClass ~= "HUNTER" and playerClass ~= "WARLOCK") or UnitLevel("player") >= 10
	KR:SetStateConditionalValue("petcontrol", hasControl)
	if not hasControl then
		EV.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
			if level >= 10 then
				KR:SetStateConditionalValue("petcontrol", "*")
				return "remove"
			end
		end)
	end
end
do -- outpost
	local map, state, name = {
		[161676]="garrison", [161332]="garrison",
		[164012]="arena", [164050]="lumber yard/yard",
		[161767]="sanctum", [162075]="arsenal",
		[168499]="brewery", [168487]="brewery", [170108]="smuggling run/run", [170097]="smuggling run/run",
		[164222]="corral", [165803]="corral", [160240]="tankworks", [160241]="tankworks",
	}, false, GetSpellInfo(161691)
	local function sync()
		local ns = map[select(7, GetSpellInfo(name))]
		if state ~= ns then
			KR:SetStateConditionalValue("outpost", ns or "")
			state = ns
		end
	end
	EV.RegisterEvent("SPELLS_CHANGED", sync)
	sync()
end
do -- glyph:(defunct)
	KR:SetStateConditionalValue("glyph", "")
end
do -- level:floor
	local function sync()
		KR:SetThresholdConditionalValue("level", UnitLevel("player") or 0)
	end
	sync()
	EV.PLAYER_LEVEL_UP = sync
end
do -- horde/alliance
	local function sync()
		local fg = UnitFactionGroup("player")
		KR:SetStateConditionalValue("horde", fg == "Horde" and "*" or "")
		KR:SetStateConditionalValue("alliance", fg == "Alliance" and "*" or "")
	end
	sync()
	EV.PLAYER_ENTERING_WORLD = sync
end
do -- moving
	KR:SetNonSecureConditional("moving", function()
		return GetUnitSpeed("player") > 0
	end)
end
local stringArgCache = {} do
	local empty = {}
	setmetatable(stringArgCache, {__index=function(t,k)
		if k then
			local at
			for s in k:gmatch("[^/]+") do
				s = s:match("^%s*(.-)%s*$")
				if #s > 0 then
					at = at or {}
					at[#at + 1] = s
				end
			end
			at = at or empty
			t[k] = at
			return at
		end
		return empty
	end})
end
do -- ready:spell name/spell id/item name/item id
	KR:SetNonSecureConditional("ready", function(_name, args)
		if not args or args == "" then
			local gcS, gcL = GetSpellCooldown(61304)
			return gcS == 0 and gcL == 0
		end
		
		local at = stringArgCache[args]

		local gcS, gcL = GetSpellCooldown(61304)
		local gcE = gcS and gcL and (gcS + gcL) or math.huge
		for i=1,#at do
			local rc = at[i]
			local cdS, cdL, _cdA = GetSpellCooldown(rc)
			if cdL == nil then
				local _, iid = GetItemInfo(rc)
				iid = tonumber((iid or rc):match("item:(%d+)"))
				if iid then
					cdS, cdL, _cdA = GetItemCooldown(iid)
				end
			end
			if cdL == 0 or (cdS and cdL and (cdS + cdL) <= gcE) then
				return true
			end
		end
		
		return false
	end)
end
do -- have:item name/id
	KR:SetNonSecureConditional("have", function(_name, args)
		if not args or args == "" then
			return false
		end
		
		local at = stringArgCache[args]
		for i=1,#at do
			if (GetItemCount(at[i]) or 0) > 0 then
				return true
			end
		end
		
		return false
	end)
end
do -- selfbuff:name
	local function checkSelf(name, args)
		if not args or args == "" then
			return false
		end
		
		local at, query = stringArgCache[args], name == "selfbuff" and UnitBuff or UnitDebuff
		for i=1,#at do
			if query("player", at[i]) then
				return true
			end
		end
		
		return false
	end
	KR:SetNonSecureConditional("selfbuff", checkSelf)
	KR:SetNonSecureConditional("selfdebuff", checkSelf)
end
do -- debuff:name
	local function checkAura(name, args, target)
		if not args or args == "" then
			return false
		end
		local at = stringArgCache[args], name == "owndebuff" and "PLAYER" or ""
		local filter = (name == "owndebuff" or name == "ownbuff") and "PLAYER" or ""
		local query = (name == "debuff" or name == "owndebuff") and UnitDebuff or UnitBuff
		for i=1,#at do
			if query(target, at[i], nil, filter) then
				return true
			end
		end
		return false
	end
	KR:SetNonSecureConditional("debuff", checkAura)
	KR:SetNonSecureConditional("owndebuff", checkAura)
	KR:SetNonSecureConditional("buff", checkAura)
	KR:SetNonSecureConditional("ownbuff", checkAura)
	KR:SetNonSecureConditional("cleanse", function(_, _, target)
		target = target or "target"
		return UnitIsFriend("player", target) and (UnitDebuff(target, 1, "RAID") ~= nil)
	end)
end
do -- combo:count
	local power, powerMap = 4, {[265]=7, [267]=14, [258]=13, PALADIN=9, MONK=12}
	local defaultPower = powerMap[playerClass] or 4
	KR:SetNonSecureConditional("combo", function(_name, args)
		return UnitPower("player", power) >= (tonumber(args) or 1)
	end)
	local function sync()
		power = powerMap[GetSpecializationInfo(GetSpecialization() or 0)] or defaultPower
	end
	EV.PLAYER_SPECIALIZATION_CHANGED, EV.PLAYER_LOGIN = sync, sync
end
do -- race:token
	KR:SetStateConditionalValue("race", (select(2,UnitRace("player"))))
end
do -- professions
	local ct, ot, map = {}, {}, {
		[197]="tail", [165]="lw", [164]="bs",
		[171]="alch", [202]="engi", [333]="ench", [744]="jc", [773]="scri",
		[20219]="nomeng", [20222]="gobeng",
	}
	local function syncInner(id, ...)
		if id then
			local _1, _2, cur, _cap, ns, sofs, skid, _bonus, specIdx, _ = GetProfessionInfo(id)
			local et, sid = GetSpellBookItemInfo(ns == 2 and sofs and specIdx > -1 and sofs+2 or 0, "spell")
			local e1, e2 = map[skid], map[et == "SPELL" and sid or nil]
			if e1 then ct[e1] = cur end
			if e2 then ct[e2] = cur end
		end
		if select("#", ...) > 0 then
			return syncInner(...)
		end
	end
	local function sync()
		ct, ot = ot, ct
		for k in pairs(ct) do ct[k] = nil end
		syncInner(GetProfessions())
		for k,v in pairs(ct) do
			if ot[k] ~= v then
				KR:SetThresholdConditionalValue(k, v)
				ot[k] = v
			end
		end
		for k,v in pairs(ot) do
			if ct[k] ~= v then
				KR:SetThresholdConditionalValue(k, false)
				ot[k] = nil
			end
		end
	end
	for _, v in pairs(map) do
		KR:SetThresholdConditionalValue(v, false)
	end
	for alias, real in ("tailoring:tail leatherworking:lw alchemy:alch engineering:engi enchanting:ench jewelcrafting:jc blacksmithing:bs inscription:scri"):gmatch("(%a+):(%a+)") do
		KR:SetAliasConditional(alias, real)
	end
	EV.PLAYER_LOGIN, EV.CHAT_MSG_SKILL = sync, sync
end
if playerClass == "HUNTER" then -- pet:stable id; havepet:stable id
	local pt, noPendingSync = {}, true
	local function sync(e)
		if InCombatLockdown() then
			if noPendingSync then
				EV.PLAYER_REGEN_ENABLED, noPendingSync = sync, false
			end
			return
		end
		for k in pairs(pt) do pt[k] = nil end
		local o, hpo
		for i=1,5 do
			local _, n, _, r = GetStablePetInfo(i)
			if n and r then
				local k = n == r and n or (n .. "/" .. r)
				pt[k] = (pt[k] or ("[pet:" .. n .. (n ~= r and ",pet:" .. r .. "] " or "] ") .. k)) .. "/" .. i
				hpo = (hpo and hpo .. "/" .. i or i)
			end
		end
		for k, v in pairs(pt) do
			o = k:match("/") and (v .. (o and "; " .. o or "")) or ((o and o .. "; " or "") .. v)
		end
		RegisterStateConditional("pet", "pet", "[nopet]; " .. (o and o .. "; 0" or " 0"), false)
		KR:SetStateConditionalValue("havepet", hpo and tostring(hpo) or "")
		noPendingSync = true
		return e == "PLAYER_REGEN_ENABLED" and "remove" or nil
	end
	KR:SetStateConditionalValue("havepet", false)
	EV.PLAYER_LOGIN, EV.PET_STABLE_UPDATE, EV.LOCALPLAYER_PET_RENAMED = sync, sync, sync
else
	KR:SetStateConditionalValue("havepet", false)
end