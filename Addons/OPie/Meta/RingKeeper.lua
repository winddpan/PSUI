local RingKeeper, _, T = {}, ...
local RK_RingDesc, RK_CollectionIDs, RK_Version, RK_Rev, EV, SV = {}, {}, 2, 46, T.Evie
local unlocked, queue, RK_DeletedRings, RK_FlagStore, sharedCollection = false, {}, {}, {}, {}

local function assert(condition, text, level, ...)
	return (not condition) and error(tostring(text):format(...), 1 + (level or 1)) or condition
end

local AB = assert(T.ActionBook:compatible(2,19), "A compatible version of ActionBook is required")
local RW = assert(T.ActionBook:compatible("Rewire", 1,10), "A compatible version of Rewire is required")
local ORI = OneRingLib.ext.OPieUI
local CLASS, FULLNAME

local RK_ParseMacro, RK_QuantizeMacro do -- +RingKeeper:SetMountPreference(groundSpellID, airSpellID)
	local castAlias = {[SLASH_CAST1]=1,[SLASH_CAST2]=1,[SLASH_CAST3]=1,[SLASH_CAST4]=1,[SLASH_USE1]=1,[SLASH_USE2]=1,["#show"]=1,["#showtooltip"]=1,[SLASH_CASTSEQUENCE1]=2,[SLASH_CASTSEQUENCE2]=2,[SLASH_CASTRANDOM1]=3,[SLASH_CASTRANDOM2]=3}
	local function replaceSpellID(sidlist, prefix)
		for id, sn in sidlist:gmatch("%d+") do
			id, sn = id+0, GetSpellInfo(id)
			if RW:IsSpellCastable(id) then
				return prefix .. sn
			end
		end
	end
	local replaceMountTag do
		local skip, gmSid, gmPref, fmSid, fmPref = {[44153]=1, [44151]=1, [61451]=1, [75596]=1, [61309]=1, [169952]=1, [171844]=1, [213339]=1,}
		local function IsKnownSpell(sid)
			local sn, sr = GetSpellInfo(sid or 0)
			return GetSpellInfo(sn, sr) ~= nil and sid or (RW:GetCastEscapeAction(sn) and sid)
		end
		local function findMount(prefSID, mtype)
			local myFactionId, nc, cs = UnitFactionGroup("player") == "Horde" and 0 or 1, 0
			local idm = C_MountJournal.GetMountIDs()
			local gmi, gmiex = C_MountJournal.GetMountInfoByID, C_MountJournal.GetMountInfoExtraByID
			for i=1, #idm do
				i = idm[i]
				local _1, sid, _3, _4, _5, _6, _7, factionLocked, factionId, hide, have = gmi(i)
				if have and not hide
				   and (not factionLocked or factionId == myFactionId)
				   and RW:IsSpellCastable(sid)
				   then
					local _, _, _, _, t = gmiex(i)
					if sid == prefSID then
						return sid
					elseif t == mtype and not skip[sid] then
						nc = nc + 1
						if math.random(1,nc) == 1 then
							cs = sid
						end
					end
				end
			end
			return cs
		end
		function replaceMountTag(tag, prefix)
			if tag == "ground" then
				gmSid = gmSid and IsKnownSpell(gmSid) or findMount(gmPref or gmSid, 230)
				return replaceSpellID(tostring(gmSid), prefix)
			elseif tag == "air" then
				fmSid = fmSid and IsKnownSpell(fmSid) or findMount(fmPref or fmSid, 248)
				return replaceSpellID(tostring(fmSid), prefix)
			end
			return ""
		end
		function RingKeeper:SetMountPreference(groundSpellID, airSpellID)
			if type(groundSpellID) == "number" then
				gmPref = groundSpellID
			end
			if type(airSpellID) == "number" then
				fmPref = airSpellID
			end
		end
	end
	local function replaceAlternatives(replaceFunc, args)
		local ret
		for alt in (args .. ","):gmatch("(.-),") do
			local alt2 = replaceFunc(alt)
			if alt == alt2 or (alt2 and alt2:match("%S")) then
				ret = (ret and (ret .. ", ") or "") .. alt2:match("^%s*(.-)%s*$")
			end
		end
		return ret
	end
	local function genLineParser(replaceFunc)
		return function(commandPrefix, command, args)
			local ctype = castAlias[command:lower()]
			if not ctype then return end
			local pos, len, ret = 1, #args
			repeat
				local cstart, cend, vend = pos
				repeat
					local ce, cs = args:match("();", pos) or (len+1), args:match("()%[", pos)
					if cs and cs < ce then
						pos = args:match("%]()", cs)
					else
						cend, vend, pos = pos, ce-1, ce + 1
					end
				until cend or not pos
				if not pos then return end
				local cval = args:sub(cend, vend)
				if ctype < 2 then
					cval = replaceFunc(args:sub(cend, vend))
				else
					local val, reset = args:sub(cend, vend)
					if ctype == 2 then reset, val = val:match("^(%s*reset=%S+%s*)"), val:gsub("^%s*reset=%S+%s*", "") end
					val = replaceAlternatives(replaceFunc, val)
					cval = val and ((reset or "") .. val) or nil
				end
				if cval or ctype == 0 then
					local clause = (cstart < cend and (args:sub(cstart, cend-1):match("^%s*(.-)%s*$") .. " ") or "") .. (cval and cval:match("^%s*(.-)%s*$") or "")
					ret = (ret and (ret .. "; ") or commandPrefix) .. clause
				end
			until not pos or pos > #args
			return ret or ""
		end
	end
	local parseLine, quantizeLine, prepareQuantizer do
		local tip = CreateFrame("GameTooltip")
		tip:AddFontStrings(tip:CreateFontString(), tip:CreateFontString())
		tip:SetOwner(UIParent, "ANCHOR_NONE")
		parseLine = genLineParser(function(value)
			local prefix, tkey, tval = value:match("^%s*(!?)%s*{{(%a+):([%a%d/]+)}}%s*$")
			if tkey == "spell" then
				return replaceSpellID(tval, prefix)
			elseif tkey == "mount" then
				return replaceMountTag(tval, prefix)
			end
			return value
		end)
		local spells = {}
		quantizeLine = genLineParser(function(value)
			local mark, name = value:match("^%s*(!?)(.-)%s*$")
			local sid = spells[name:lower()]
			if not sid and mark == "!" then mark, sid = "", spells[mark .. name:lower()] end
			return sid and (mark .. "{{spell:" .. sid .. "}}") or value
		end)
		function prepareQuantizer(reuse)
			if reuse and next(spells) then return end
			wipe(spells)
			spells[GetSpellInfo(150544):lower()] = 150544
			local idm = C_MountJournal.GetMountIDs()
			local gmi = C_MountJournal.GetMountInfoByID
			for i=1, #idm do
				local _, sid = gmi(idm[i])
				local sname = GetSpellInfo(sid)
				if sname then
					spells[sname:lower()] = sid
				end
			end
			for spec=1,GetNumSpecializations() do
				for tier=1, MAX_TALENT_TIERS do
					for column=1, 3 do
						tip:SetTalent(GetTalentInfoBySpecialization(spec, tier, column))
						local name, _, id = tip:GetSpell()
						if id and type(name) == "string" then
							spells[name:lower()] = id
						end
					end
				end
			end
			for i=GetNumSpellTabs()+12,1,-1 do
				local _, _, ofs, c, _, sid = GetSpellTabInfo(i)
				for j=ofs+1,sid == 0 and (ofs+c) or 0 do
					local n, st, id = GetSpellBookItemName(j, "spell"), GetSpellBookItemInfo(j, "spell")
					if type(n) ~= "string" or not id then
					elseif st == "SPELL" or st == "FUTURESPELL" then
						spells[n:lower()] = id
					elseif st == "FLYOUT" then
						for j=1,select(3,GetFlyoutInfo(id)) do
							local sid, _, _, sname = GetFlyoutSlotInfo(id, j)
							if sid and type(sname) == "string" then
								spells[sname:lower()] = sid
							end
						end
					end
				end
			end
		end
	end
	function RK_ParseMacro(macro)
		if type(macro) == "string" and (macro:match("{{spell:[%d/]+}}") or macro:match("{{mount:%a+}}") ) then
			macro = ("\n" .. macro):gsub("(\n([#/]%S+) ?)([^\n]*)", parseLine)
		end
		return macro
	end
	function RK_QuantizeMacro(macro, useCache)
		return type(macro) == "string" and (prepareQuantizer(useCache) or true) and ("\n" .. macro):gsub("(\n([#/]%S+) ?)([^\n]*)", quantizeLine):sub(2) or macro
	end
end
local function RK_IsRelevantRingDescription(desc)
	if desc then
		local limit = desc.limit
		return limit == nil or limit == FULLNAME or limit == CLASS
	end
end
local serialize, unserialize do
	local sigT, sigN = {}
	for i, c in ("01234qwertyuiopasdfghjklzxcvbnm5678QWERTYUIOPASDFGHJKLZXCVBNM9"):gmatch("()(.)") do sigT[i-1], sigT[c], sigN = c, i-1, i end
	local function checksum(s)
		local h = (134217689 * #s) % 17592186044399
		for i=1,#s,4 do
			local a, b, c, d = s:match("(.?)(.?)(.?)(.?)", i)
			a, b, c, d = sigT[a], (sigT[b] or 0) * sigN, (sigT[c] or 0) * sigN^2, (sigT[d] or 0) * sigN^3
			h = (h * 211 + a + b + c + d) % 17592186044399
		end
		return h % 3298534883309
	end
	local function nenc(v, b, rest)
		if b == 0 then return v == 0 and rest or error("numeric overflow") end
		local v1 = v % sigN
		local v2 = (v - v1) / sigN
		return nenc(v2, b - 1, sigT[v1] .. (rest or ""))
	end
	local function cenc(c)
		local b, m = c:byte(), sigN-1
		return sigT[(b - b % m) / m] .. sigT[b % m]
	end
	local function venc(v, t, reg)
		if reg[v] then
			table.insert(t, sigT[1] .. sigT[reg[v]])
		elseif type(v) == "table" then
			local n = math.min(sigN-1, #v)
			for i=n,1,-1 do venc(v[i], t, reg) end
			table.insert(t, sigT[3] .. sigT[n])
			for k,v2 in pairs(v) do
				if not (type(k) == "number" and k >= 1 and k <= n and k % 1 == 0) then
					venc(v2, t, reg)
					venc(k, t, reg)
					table.insert(t, sigT[4])
				end
			end
		elseif type(v) == "number" then
			if v % 1 ~= 0 then error("non-integer value") end
			if v < -1000000 then error("integer underflow") end
			table.insert(t, sigT[5] .. nenc(v + 1000000, 4))
		elseif type(v) == "string" then
			table.insert(t, sigT[6] .. v:gsub("[^a-zA-Z5-8]", cenc) .. "9")
		else
			table.insert(t, sigT[1] .. ((v == true and sigT[1]) or (v == nil and sigT[0]) or sigT[2]))
		end
		return t
	end

	local ops = {"local ops, sigT, sigN, s, r, pri = {}, ...\nlocal cdec, ndec = function(c, l) return string.char(sigT[c]*(sigN-1) + sigT[l]) end, function(s) local r = 0 for i=1,#s do r = r * sigN + sigT[s:sub(i,i)] end return r end",
		"s[d+1], d, pos = r[sigT[pri:sub(pos,pos)]], d + 1, pos + 1", "r[sigT[pri:sub(pos,pos)]], pos = s[d], pos + 1",
		"local t, n = {}, sigT[pri:sub(pos,pos)]\nfor i=1,n do t[i] = s[d-i+1] end\ns[d - n + 1], d, pos = t, d - n + 1, pos + 1", "s[d-2][s[d]], d = s[d-1], d - 2",
		"s[d+1], d, pos = ndec(pri:sub(pos, pos + 3)) - 1000000, d + 1, pos + 4", "d, s[d+1], pos = d + 1, pri:match('^(.-)9()', pos)\ns[d] = s[d]:gsub('([0-4])(.)', cdec)",
		"s[d-1], d = s[d-1]+s[d], d - 1", "s[d-1], d = s[d-1]*s[d], d - 1", "s[d-1], d = s[d-1]/s[d], d - 1", "function ops.bind(...) s, r, pri = ... end\nreturn ops"}
	for i=2,#ops-1 do ops[i] = ("ops[%q] = function(d, pos)\n %s\n return d, pos\nend"):format(sigT[i-1], ops[i]) end
	ops = loadstring(table.concat(ops, "\n"))(sigT, sigN)

	function serialize(t, sign, regGhost)
		local payload = table.concat(venc(t, {}, setmetatable({},regGhost)), "")
		return ((sign .. nenc(checksum(sign .. payload), 7) .. payload):gsub("(.......)", "%1 "):gsub(" ?$", ".", 1))
	end
	function unserialize(s, sign, regGhost)
		local h, pri = s:gsub("[^a-zA-Z0-9.]", ""):match("^" .. sign .. "(.......)([^.]+)")
		if nenc(checksum(sign .. pri), 7) ~= h then return end
	
		local stack, depth, pos, len = {}, 0, 1, #pri
		ops.bind(stack, setmetatable({true, false}, regGhost), pri)
		while pos <= len do
			depth, pos = ops[pri:sub(pos, pos)](depth, pos + 1)
		end
		return depth == 1 and stack[1]
	end
end
local encodeMacro, decodeMacro do
	local function slash_i18n(command, lead)
		if lead == "!" then return "\n!" .. command end
		local key = command:upper()
		if type(hash_ChatTypeInfoList[key]) == "string" and not hash_ChatTypeInfoList[key]:match("!") then
			return "\n!" .. hash_ChatTypeInfoList[key] .. "!" .. command
		elseif type(hash_EmoteTokenList[key]) == "string" and not hash_EmoteTokenList[key]:match("!") then
			return "\n!" .. hash_EmoteTokenList[key] .. "!" .. command
		end
	end
	local function slash_l10n(key, command)
		if key == "" then return "\n!" .. command end
		local k2 = command:upper()
		if hash_ChatTypeInfoList[k2] == key or hash_EmoteTokenList[k2] == key then
		elseif _G["SLASH_" .. key .. 1] then
			return "\n" .. _G["SLASH_" .. key .. 1]
		else
			local i, v = 2, EMOTE1_TOKEN
			while v do
				if v == key then
					return "\n" .. _G["EMOTE" .. (i-1) .. "_CMD1"]
				end
				i, v = i + 1, _G["EMOTE" .. i .. "_TOKEN"]
			end
		end
		return "\n" .. command
	end
	function encodeMacro(m)
		ChatFrame_ImportAllListsToHash()
		return ("\n" .. m):gsub("\n(([/!])%S*)", slash_i18n):sub(2)
	end
	function decodeMacro(m)
		ChatFrame_ImportAllListsToHash()
		return ("\n" .. m):gsub("\n!(.-)!(%S*)", slash_l10n):sub(2)
	end
end
local copy do
	local copies = {}
	function copy(t, isInnerCall)
		if not isInnerCall then wipe(copies) end
		local into = {} copies[t] = into
		for k,v in pairs(t) do
			into[type(k) == "table" and (copies[k] or copy(k, true)) or k] = type(v) == "table" and (copies[v] or copy(v, true)) or v
		end
		if not isInnerCall then wipe(copies) end
		return into
	end
end

local sReg, sRegRev, sSign = {__index={nil, nil, "name", "hotkey", "offset", "noOpportunisticCA", "noPersistentCA", "internal", "limit", "id", "skipSpecs", "caption", "icon", "show"}}, {__index={}}, string.char(111,101,116,111,104,72,55)
for k,v in pairs(sReg.__index) do sRegRev.__index[v] = k end

local function pullOptions(e, a, ...)
	if a then return e[a], pullOptions(e, ...) end
end
local function unpackABAction(e, s)
	if e[s] then return e[s], unpackABAction(e, s+1) end
	return pullOptions(e, AB:GetActionOptions(e[1]))
end
local function RK_SyncRing(name, force, tok)
	local desc, changed, cid = RK_RingDesc[name], (force == true), RK_CollectionIDs[name]
	if not RK_IsRelevantRingDescription(desc) then return; end
	tok = tok or AB:GetLastObserverUpdateToken("*")
	if not force and tok == desc._lastUpdateToken then return end
	desc._lastUpdateToken = tok
	
	if not cid then
		wipe(sharedCollection)
		changed, cid = true, AB:CreateActionSlot(nil, nil, "collection", sharedCollection)
		RK_CollectionIDs[name], RK_CollectionIDs[cid] = cid, name
		OneRingLib:SetRing(name, cid, desc)
	end

	for _, e in ipairs(desc) do
		local ident, action = e[1]
		if ident == "macrotext" then
			local m = RK_ParseMacro(e[2])
			if m:match("%S") then action = AB:GetActionSlot("macrotext", m) end
		elseif type(ident) == "string" then
			action = AB:GetActionSlot(unpackABAction(e, 1))
		end
		changed = changed or (action ~= e._action) or (e.fastClick ~= e._fastClick) or (e.lockRotation ~= e._lockRotation) or (action and (e.show ~= e._show) or (e.embed ~= e._embed))
		e._action, e._fastClick, e._lockRotation = action, e.fastClick, e.lockRotation
	end
	changed = changed or (desc._embed ~= desc.embed)

	if not changed and not force then return end
	local collection, cn = sharedCollection, 1
	wipe(collection)
	for _, e in ipairs(desc) do
		if e._action then
			collection[e.sliceToken], collection[cn], cn = e._action, e.sliceToken, cn + 1
			collection['__visibility-' .. e.sliceToken], e._show = e.show or nil, e.show
			collection['__embed-' .. e.sliceToken], e._embed = e.embed, e.embed
			ORI:SetDisplayOptions(e.sliceToken, e.icon, e.caption, e._r, e._g, e._b)
		end
	end
	collection['__embed'], desc._embed = desc.embed, desc.embed
	AB:UpdateActionSlot(cid, collection)
	OneRingLib:SetRing(name, cid, desc)
end
local function dropUnderscoreKeys(t)
	for k in pairs(t) do
		if type(k) == "string" and k:sub(1,1) == "_" then
			t[k] = nil
		end
	end
end
local function RK_SanitizeDescription(props)
	local uprefix = type(props._u) == "string" and props._u
	for i=#props,1,-1 do
		local v = props[i]
		if type(v.c) == "string" then
			local r,g,b = v.c:match("^(%x%x)(%x%x)(%x%x)$")
			if r then
				v._r, v._g, v._b = tonumber(r, 16)/255, tonumber(g, 16)/255, tonumber(b, 16)/255
			end
		end
		local rt, id = v.rtype, v.id
		if rt and id then
			v[1], v[2], v.rtype, v.id = rt, id
		elseif type(id) == "number" then
			v[1], v[2], v.rtype, v.id = "spell", id
		elseif type(id) == "string" then
			v[1], v[2], v.rtype, v.id = "macrotext", id
		elseif v[1] == nil then
			table.remove(props, i)
		end
		v.show = v.show ~= "" and v.show or nil
		v.sliceToken = v.sliceToken or (uprefix and type(v._u) == "string" and (uprefix .. v._u)) or AB:CreateToken()
		v._action, v._embed = nil
	end
	props._embed = nil
	return props
end
local function RK_SerializeDescription(props)
	for _, slice in ipairs(props) do
		if slice[1] == "spell" or slice[1] == "macrotext" then
			slice.id, slice[1], slice[2] = slice[2]
		end
		dropUnderscoreKeys(slice)
	end
	dropUnderscoreKeys(props)
	return props
end
function EV.PLAYER_REGEN_DISABLED()
	for k in pairs(RK_RingDesc) do
		securecall(RK_SyncRing, k)
	end
end
local function abPreOpen(_, _, id)
	local k = RK_CollectionIDs[id]
	if k then
		RK_SyncRing(k)
	end
end
local function svInitializer(event, _name, sv)
	if event == "LOGOUT" and unlocked then
		for k in pairs(sv) do sv[k] = nil end
		for k, v in pairs(RK_RingDesc) do
			if type(v) == "table" and not RK_DeletedRings[k] and v.save then
				sv[k] = RK_SerializeDescription(v)
			end
		end
		sv.OPieDeletedRings, sv.OPieFlagStore = next(RK_DeletedRings) and RK_DeletedRings, next(RK_FlagStore) and RK_FlagStore

	elseif event == "LOGIN" then
		local name, realm, _ = UnitFullName("player")
		FULLNAME, _, CLASS = name .. '-' .. realm, UnitClass("player")

		unlocked = true
		local deleted, flags, mousemap = SV.OPieDeletedRings or RK_DeletedRings, SV.OPieFlagStore or RK_FlagStore
		mousemap, SV.OPieDeletedRings, SV.OPieFlagStore = {PRIMARY=OneRingLib:GetOption("PrimaryButton"), SECONDARY=OneRingLib:GetOption("SecondaryButton")}
		for k,v in pairs(flags) do RK_FlagStore[k] = v end

		for k, v in pairs(queue) do
			if v.hotkey then v.hotkey = v.hotkey:gsub("[^-; ]+", mousemap) end
			if deleted[k] == nil and SV[k] == nil then
				securecall(RingKeeper.SetRing, RingKeeper, k, v)
				SV[k] = nil
			elseif deleted[k] then
				RK_DeletedRings[k] = true
			end
		end
		local colorFlush = not RK_FlagStore.FlushedDefaultColors
		for k, v in pairs(SV) do
			if colorFlush and type(v) == "table" then
				for _,v in pairs(v) do
					if type(v) == "table" and v.c == "e5ff00" then
						v.c = nil
					end
				end
			end
			securecall(RingKeeper.SetRing, RingKeeper, k, v)
		end
		RK_FlagStore.FlushedDefaultColors = true
		collectgarbage("collect")
	end
end
local function ringIterator(isDeleted, k)
	local nk, v = next(isDeleted and RK_DeletedRings or RK_RingDesc, k)
	if nk and isDeleted then
		return RK_IsRelevantRingDescription(queue[nk]) and nk or ringIterator(isDeleted, nk)
	elseif nk then
		return nk, v.name or nk, RK_CollectionIDs[nk] ~= nil, #v, v.internal, v.limit
	end
end

-- Public API
function RingKeeper:GetVersion()
	return RK_Version, RK_Rev
end
function RingKeeper:SetRing(name, desc)
	assert(type(name) == "string" and (type(desc) == "table" or desc == false), "Syntax: RingKeeper:SetRing(name, descTable or false)", 2);
	if not unlocked then
		queue[name] = desc
	elseif desc == false then
		if RK_RingDesc[name] then
			OneRingLib:SetRing(name, nil)
			if RK_CollectionIDs[name] then RK_CollectionIDs[RK_CollectionIDs[name]] = nil end
			RK_DeletedRings[name], RK_RingDesc[name], RK_CollectionIDs[name], SV[name] = queue[name] and true or nil
		end
	else
		RK_RingDesc[name], RK_DeletedRings[name] = RK_SanitizeDescription(copy(desc)), nil
		RK_SyncRing(name, true)
	end
end
function RingKeeper:GetManagedRings()
	return ringIterator, false, nil
end
function RingKeeper:GetDeletedRings()
	return ringIterator, true, nil
end
function RingKeeper:GetRingDescription(name, serialize)
	assert(type(name) == "string", 'Syntax: desc = RingKeeper:GetRingDescription("name"[, serialize])', 2)
	local ring = RK_RingDesc[name] and copy(RK_RingDesc[name]) or false
	return serialize and ring and RK_SerializeDescription(ring) or ring
end
function RingKeeper:GetRingInfo(name)
	assert(type(name) == "string", 'Syntax: title, numSlices, isDefault, isOverriden = RingKeeper:GetRingInfo("name")', 2)
	local ring = RK_RingDesc[name]
	return ring and (ring.name or name), ring and #ring, not not queue[name], ring and ring.save
end
function RingKeeper:RestoreDefaults(name)
	if name == nil then
		for k, v in pairs(queue) do
			if RK_IsRelevantRingDescription(v) then
				self:SetRing(k, queue[k])
			end
		end
	elseif queue[name] then
		self:SetRing(name, queue[name])
	end
end
function RingKeeper:GetDefaultDescription(name)
	assert(type(name) == "string", 'Syntax: desc = RingKeeper:GetDefaultDescription("name")', 2)
	return queue[name] and copy(queue[name]) or false
end
function RingKeeper:GenFreeRingName(base, t)
	assert(type(base) == "string" and (t == nil or type(t) == "table"), 'Syntax: name = RingKeeper:GenFreeRingName("base"[, reservedNamesTable])', 2)
	base = base:gsub("[^%a%d]", ""):sub(-10)
	if base:match("^OPie") or not base:match("^%a") then base = "x" .. base end
	local suffix, c = "", 1
	while RK_RingDesc[base .. suffix] or SV[base .. suffix] or (t and t[base .. suffix] ~= nil) or OneRingLib:IsKnownRingName(base .. suffix) do
		suffix, c = math.random(2^c), c < 30 and (c + 1) or c
	end
	return base .. suffix
end
function RingKeeper:UnpackABAction(slice)
	if type(slice) == "table" and slice[1] == "macrotext" and type(slice[2]) == "string" then
		local pmt = RK_ParseMacro(slice[2])
		return "macrotext", pmt == "" and slice[2] ~= "" and "#empty" or pmt, unpackABAction(slice, 3)
	else
		return unpackABAction(slice, 1)
	end
end
function RingKeeper:IsRingSliceActive(ring, slice)
	return RK_RingDesc[ring] and RK_RingDesc[ring][slice] and RK_RingDesc[ring][slice]._action and true or false
end
function RingKeeper:SoftSync(name)
	assert(type(name) == "string", 'Syntax: RingKeeper:SoftSync("name")', 2)
	securecall(RK_SyncRing, name)
end
function RingKeeper:GetRingSnapshot(name)
	assert(type(name) == "string", 'Syntax: snapshot = RingKeeper:GetRingSnapshot("name")', 2)
	local ring, first = RK_RingDesc[name] and RK_SerializeDescription(copy(RK_RingDesc[name])) or false, true
	if ring then
		ring.limit, ring.save = type(ring.limit) == "string" and ring.limit:match("[^A-Z]") and "PLAYER" or ring.limit
		for i=1,#ring do
			local v = ring[i]
			if v[1] == nil and type(v.id) == "string" then
				v.id, first = encodeMacro(RK_QuantizeMacro(v.id, not first)), false
			end
			v.sliceToken = nil
		end
	end
	return ring and serialize(ring, sSign, sRegRev)
end
function RingKeeper:GetSnapshotRing(snap)
	assert(type(snap) == "string", 'Syntax: desc = RingKeeper:GetSnapshotRing("snapshot")', 2)
	local ok, ret = pcall(unserialize, snap, sSign, sReg)
	if ok and type(ret) == "table" and type(ret.name) == "string" and #ret > 0 then
		for i=1,#ret do
			local v = ret[i]
			if not v then
				return
			else
				v.caption = type(v.caption) == "string" and v.caption:gsub("|?|", "||") or nil
				if v[1] == nil and type(v.id) == "string" then
					v.id = decodeMacro(v.id)
				end
			end
		end
		ret.name, ret.quarantineBind, ret.hotkey = ret.name:gsub("|?|", "||"), type(ret.hotkey) == "string" and ret.hotkey or nil
		return ret
	end
end
function RingKeeper:QuantizeMacro(macrotext)
	return RK_QuantizeMacro(macrotext)
end

SV, OneRingLib.ext.RingKeeper = OneRingLib:RegisterPVar("RingKeeper", SV, svInitializer), RingKeeper
AB:AddObserver("internal.collection.preopen", abPreOpen)