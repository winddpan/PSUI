local api, MAJ, REV, _, T = {}, 1, 10, ...
if T.ActionBook then return end
local AB, KR = nil, assert(T.Kindred:compatible(1,8), "A compatible version of Kindred is required.")

local function assert(condition, err, ...)
	return (not condition) and error(tostring(err):format(...), 3) or condition
end
local safequote do
	local r = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
	function safequote(s)
		return (("%q"):format(s):gsub("[{}u]", r))
	end
end
local forall do
	local function r(n, f, a, ...)
		if n > 0 then
			return f(a), r(n-1, f, ...)
		end
	end
	function forall(f, ...)
		return r(select("#", ...), f, ...)
	end
end

local Spell_UncastableIDs do
	local classLockedMounts = {
		[48778]="DEATHKNIGHT", [54729]="DEATHKNIGHT", [229387]="DEATHKNIGHT",
		[229417]="DEMONHUNTER", [200175]="DEMONHUNTER",
		[229386]="HUNTER", [229438]="HUNTER", [229439]="HUNTER",
		[229376]="MAGE",
		[229385]="MONK",
		[13819]="PALADIN", [23214]="PALADIN", [34767]="PALADIN", [34769]="PALADIN", [66906]="PALADIN", [69820]="PALADIN", [69826]="PALADIN", [221883]="PALADIN", [205656]="PALADIN", [221885]="PALADIN", [221886]="PALADIN", [231587]="PALADIN", [231588]="PALADIN", [231589]="PALADIN", [231435]="PALADIN",
		[229377]="PRIEST",
		[231434]="ROGUE", [231523]="ROGUE", [231524]="ROGUE", [231525]="ROGUE",
		[231442]="SHAMAN",
		[5784]="WARLOCK", [23161]="WARLOCK", [232412]="WARLOCK", [238452]="WARLOCK", [238454]="WARLOCK",
		[229388]="WARRIOR",
	}
	local _, class = UnitClass("player")
	for k,v in pairs(classLockedMounts) do
		if v == class then
			classLockedMounts[k] = nil
		end
	end
	Spell_UncastableIDs = classLockedMounts
end
local Spell_CheckKnown = {[33891]=IsSpellKnown, [102543]=IsSpellKnown, [102558]=IsSpellKnown} do
	Spell_CheckKnown[102560] = function()
		return IsSpellKnown(194223) and select(7, GetSpellInfo(GetSpellInfo(194223))) == 102560 or false
	end
end
local Spell_ForcedID = {[126819]=1, [28272]=1, [28271]=1, [161372]=1, [51514]=1, [210873]=1, [211004]=1, [211010]=1, [211015]=1}

local namedMacros = {}
local core, coreEnv = CreateFrame("FRAME", nil, nil, "SecureHandlerBaseTemplate") do
	local bni = 1
	for i=1,9 do
		local bn repeat
			bn, bni = "RW!" .. bni, bni + 1
		until GetClickFrame(bn) == nil
		core:WrapScript(CreateFrame("BUTTON", bn, core, "SecureActionButtonTemplate"), "OnClick",
		[=[-- Rewire:OnClick_Pre
			idle[self], numIdle, numActive, ns = nil, numIdle - 1, numActive + 1, ns - 1
			self:SetAttribute("macrotext", owner:RunAttribute("RunMacro", nil))
			return nil, 1
		]=], [=[-- Rewire:OnClick_Post
			idle[self], numIdle, numActive = 1, numIdle + 1, numActive - 1
			if ns == 0 and #execQueue > 0 then
				owner:CallMethod("throw", "Rewire executor pool exhausted; spilling queue (n=" .. #execQueue .. ").")
				wipe(execQueue)
				overfull, mutedAbove = false, -1, mutedAbove >= 0 and owner:CallMethod("setMute", false)
				KR:RunAttribute("SetButtonState", false)
			end
		]=])
	end
	core:SetFrameRef("Kindred", KR:seclib())
	core:Execute([=[-- Rewire_Init
		KR = self:GetFrameRef("Kindred")
		execQueue, mutedAbove, QUEUE_LIMIT, overfull = newtable(), -1, 20000, false
		idle, cache, numIdle, numActive, ns = newtable(), newtable(), 0, 0, 0
		macros, commandInfo, commandHandler, commandAlias = newtable(), newtable(), newtable(), newtable()
		MACRO_TOKEN, metaCommands, transferTokens = newtable(nil, nil, nil, "MACRO_TOKEN"), newtable(), newtable()
		metaCommands.mute, metaCommands.unmute, metaCommands.mutenext, metaCommands.parse = 1, 1, 1, 1
		castEscapes = newtable()
		for _, k in pairs(self:GetChildList(newtable())) do
			idle[k], numIdle = 1, numIdle + 1
			k:SetAttribute("type", "macro")
		end
	]=])
	coreEnv = GetManagedEnvironment(core)
end
core:SetAttribute("RunSlashCmd", [=[-- Rewire:Internal_RunSlashCmd
	local slash, v, target = ...
	if not v then
	elseif slash == "/cast" or slash == "/use" then
		local oid = v and castEscapes[v:lower()]
		if oid then
			return AB:RunAttribute("UseAction", oid, target)
		elseif v then
			return (target and (slash .. " [@" .. target .. "] ") or (slash .. " ")) .. v
		end
	elseif slash == "/stopmacro" then
		repeat
			local r = table.remove(execQueue)
		until r == MACRO_TOKEN or r == nil
	elseif slash == "#mutenext" or slash == "#mute" then
		local breakOnCommand = slash == "#mutenext"
		for i=#execQueue,1,-1 do
			local m = execQueue[i]
			if m == MACRO_TOKEN or (breakOnCommand and m[4] == nil) then
				if i > 1 then i = i - 1 end
				if mutedAbove < 0 or i < mutedAbove then
					mutedAbove = i, mutedAbove < 0 and self:CallMethod("setMute", true)
				end
				return
			end
		end
	elseif slash == "#unmute" and mutedAbove > -1 then
		for i=#execQueue,mutedAbove+1,-1 do
			if m == MACRO_TOKEN then
				return
			end
		end
		mutedAbove = -1, self:CallMethod("setMute", false)
	elseif slash == "#parse" then
		local m = execQueue[#execQueue]
		if m and m[2] and m[3] then
			execQueue[#execQueue] = nil
			local parsed = KR:RunAttribute("EvaluateCmdOptions", m[3], nil, nil)
			if parsed then
				return m[2] .. " " .. parsed
			end
		end
	elseif slash == "/runmacro" then
		if macros[v] then
			return macros[v]:RunAttribute("RunNamedMacro", v)
		end
		print(('|cffffff00Macro %q is unknown.'):format(v))
	end
]=])
core:SetAttribute("RunMacro", [=[-- Rewire:RunMacro
	local m, macrotext, transferButtonState = cache[...], ...
	if macrotext and not m then
		m = newtable()
		for line in macrotext:gmatch("%S[^\n\r]*") do
			local slash, args = line:match("^(%S+)%s*(.-)%s*$")
			slash = slash:lower()
			local meta, meta4 = slash:match("^#((.?.?.?.?).*)")
			if meta == nil or metaCommands[meta] then
				m[#m+1] = newtable(line, slash, args, meta)
			end
		end
		cache[macrotext] = m
	end

	if m and #m > 0 and not overfull then
		if #execQueue > QUEUE_LIMIT then
			overfull = true, owner:CallMethod("throw", "Rewire execution queue overfull; ignoring subsequent commands.")
		else
			local ni = #execQueue+1
			if transferButtonState then
				local nbs = SecureCmdOptionParse("[btn:1] 1; [btn:2] 2; [btn:3] 3; [btn:4] 4; [btn:5] 5")
				if not (#execQueue == 0 and nbs == "1") then
					local nt, os = #transferTokens, KR:RunAttribute("SetButtonState", nbs)
					local tt = nt > 0 and transferTokens[nt] or newtable(nil, nil, nil, "TRANSFER_TOKEN")
					execQueue[ni], ni, tt[3], transferTokens[nt] = tt, ni + 1, os
				end
			end
			execQueue[ni], ni = MACRO_TOKEN, ni + 1
			for i=#m, 1, -1 do
				execQueue[ni], ni = m[i], ni + 1
			end
		end
	end

	if ns < #execQueue and numIdle > 0 then
		local m = "\n/click " .. next(idle):GetName()
		local n = math.min(math.floor(1000/#m), math.ceil(#execQueue*1.25 + numActive*1.3^numActive))
		ns = ns + n
		return m:rep(n)
	else
		local i, nextLine, m, t, k, v, ct = #execQueue
		repeat
			m, i, execQueue[i] = execQueue[i], i-1
		until i < 1 or m ~= MACRO_TOKEN
		if mutedAbove > 0 and mutedAbove > i then
			mutedAbove = -1, self:CallMethod("setMute", false)
		end
		if not m then overfull = false return "" end
		k, v = commandAlias[m[2]] or m[2], m[3]
		ct = commandInfo[k] or 0
		if ct % 2 > 0 and m[3] ~= "" then
			local skipChunks = nil
			v, t = KR:RunAttribute("EvaluateCmdOptions", m[3], nil, skipChunks)
			if v then
				nextLine = m[2] .. (t and " [@" .. t .. "] " or " ") .. v
			else
				nextLine = m[2] .. " [form:42]"
			end
		elseif m[4] == "TRANSFER_TOKEN" then
			KR:RunAttribute("SetButtonState", m[3])
			transferTokens[#transferTokens+1], nextLine = m
		else
			nextLine = m[1]
		end
		if commandHandler[k] then
			nextLine = commandHandler[k]:RunAttribute("RunSlashCmd", m[2], v, t)
		end
		return (nextLine or "") ~= "" and nextLine or #execQueue > 0 and self:RunAttribute("RunMacro", nil) or ""
	end
]=])
core:SetAttribute("SetNamedMacroHandler", [=[-- Rewire:SetNamedMacroHandler
	local name, handlerFrame = ..., self:GetFrameRef("SetNamedMacroHandler-handlerFrame")
	if type(name) == "string" and macros[name] ~= handlerFrame then
		macros[name] = handlerFrame
		self:CallMethod("clearHinter", name)
	end
	self:SetAttribute("frameref-SetNamedMacroHandler-handlerFrame", nil)
]=])
function core:throw(err)
	error(err)
end
function core:clearHinter(name)
	namedMacros[name] = nil
end
do -- core:setMute
	local isMuted, f, _AddMessage, _SFX = false, CreateFrame("Frame")
	local function noop() end
	function core:setMute(mute)
		assert(mute ~= isMuted, "setMute assertion failed")
		if not mute then
			UIErrorsFrame.AddMessage = _AddMessage, SetCVar("Sound_EnableSFX", _SFX)
		else
			_AddMessage, _SFX = UIErrorsFrame.AddMessage, GetCVar("Sound_EnableSFX")
			UIErrorsFrame.AddMessage = noop, SetCVar("Sound_EnableSFX", 0)
		end
		isMuted = mute
		f:SetShown(mute)
	end
	f:SetScript("OnUpdate", function()
		assert(core:setMute(false), "Muted state persisted after macro execution")
	end)
	f:Hide()
end

local function setCommandType(slash, ctype, handler)
	if handler ~= nil then core:SetFrameRef('hand', handler) end
	core:Execute(("commandInfo[%s], commandHandler[%1$s] = %d, %s"):format(safequote(slash), ctype, handler and "self:GetFrameRef('hand')" or "nil"))
end
local function getAliases(p, i)
	local v = _G[p .. i]
	if v then
		return v, getAliases(p, i+1)
	end
end

local setCommandHinter, getMacroHint, getCommandHint, getCommandHintRaw do
	local hintFunc, pri, cache, ht, ht2, nInf, cDepth, DEPTH_LIMIT = {}, {}, {}, {}, {}, -math.huge, 0, 20
	local store do
		local function write(t, n, i, a,b,c,d, ...)
			if n > 0 then
				t[i], t[i+1], t[i+2], t[i+3] = a,b,c,d
				return write(t, n-4, i+4, ...)
			end
		end
		function store(ok, ...)
			if ok then
				local n = select("#", ...)
				write(ht2, n+1, 0, n, ...)
			end
			return ok
		end
	end
	local iconReplCache = setmetatable({}, {__index=function(t,k)
		if k then
			local v = tonumber(k)
			if not v then
				if k:match("[/\\]") then
					v = k
				elseif k ~= "" then
					v = "Interface\\Icons\\" .. k
				end
			end
			t[k] = v ~= 0 and v
			return v
		end
	end})
	local function replaceIcon(nico, ...)
		if not nico then return ... end
		nico = iconReplCache[nico]
		if not nico then return ... end
		local n, f = ...
		return n, f, nico, select(4, ...)
	end
	function getCommandHintRaw(hslash, ...)
		local hf = hintFunc[hslash]
		if not hf then return false end
		return hf(...)
	end
	local function clearDepth(...)
		cDepth = 0
		return ...
	end
	function getCommandHint(priLimit, slash, args, modState, otarget, priBias)
		slash = coreEnv.commandAlias[slash] or slash
		local hf, pri, args2, target = hintFunc[slash], pri[slash]
		if hf and pri > (priLimit or nInf) - (priBias or 0) then
			if cDepth == 0 then
				cDepth = 1
				return clearDepth(securecall(getCommandHint, priLimit, slash, args, modState, otarget, priBias))
			elseif cDepth > DEPTH_LIMIT then
				return false
			elseif otarget ~= nil then
				args, args2, target = nil, args, otarget
			elseif (coreEnv.commandInfo[slash] or 0) % 2 > 0 then
				if args == "" then
					args2, args = ""
				else
					args, args2, target = nil, KR:EvaluateCmdOptions(args, modState)
				end
			end
			cDepth = cDepth + 1
			local res = store(securecall(hf, slash, args, args2, target, modState, priLimit))
			cDepth = cDepth - 1
			if res == "stop" then
				return res, pri
			elseif priLimit then
				return res, (res ~= true and res or pri) + (priBias or 0)
			elseif res then
				return res, unpack(ht2, 1, ht2[0])
			end
		elseif not pri then
			return false
		end
	end
	function getMacroHint(macrotext, modState, minPriority)
		if not macrotext then return end
		local m, lowPri = cache[macrotext], minPriority or nInf
		if not m then
			m = {}
			for line in macrotext:gmatch("%S[^\n\r]*") do
				local slash, args = line:match("^(%S+)%s*(.-)%s*$")
				slash = slash:lower()
				local meta, meta4 = slash:match("^#((.?.?.?.?).*)")
				if meta4 == "show" and args ~= "" then
					m[-1], m[0] = "/use", args
				elseif meta == "icon" then
					m.icon = args
				elseif meta == nil or meta == "skip" or meta == "important" then
					m[#m+1], m[#m+2] = slash, args
				end
			end
			cache[macrotext] = m
		end
		local bestPri, bias, oico, haveUnknown = lowPri, m[-1] and 1000 or 0, m.icon
		for i=m[-1] and -1 or 1, #m, 2 do
			local cmd, args = m[i], m[i+1]
			if cmd == "#skip" or cmd == "#important" then
				local v = args == "" or KR:EvaluateCmdOptions(args, modState)
				if v ~= nil then
					v = tonumber(v)
					bias = cmd == "#skip" and (v and -v or nInf) or (v or 1000)
				end
			else
				local res, pri = getCommandHint(bestPri, cmd, args, modState, nil, bias)
				if res == "stop" then
					break
				elseif res and pri > bestPri then
					bestPri, ht, ht2 = pri, ht2, ht
				elseif res == false and i > 0 then
					haveUnknown = true
				end
				bias = 0
			end
		end
		if bestPri > lowPri then
			return select(minPriority and 1 or 2, bestPri, replaceIcon(oico and KR:EvaluateCmdOptions(oico, modState), unpack(ht, 1, ht[0]) ))
		elseif haveUnknown or oico then
			return select(minPriority and 1 or 2, false, replaceIcon(oico and KR:EvaluateCmdOptions(oico, modState), nil, 0, "Interface/Icons/INV_Misc_QuestionMark", "", 0, 0, 0))
		end
	end
	function setCommandHinter(slash, priority, hint)
		hintFunc[slash], pri[slash] = hint, hint and priority
	end
end

local function init()
	for k, v in pairs(_G) do
		local k = type(k) == "string" and k:match("^SLASH_(.*)1$")
		if k and IsSecureCmd(v) then
			api:ImportSlashCmd(k, true, false)
		end
	end
	for k in ("DISMOUNT LEAVEVEHICLE SET_TITLE USE_TALENT_SPEC TARGET_MARKER"):gmatch("%S+") do
		api:ImportSlashCmd(k, true, false)
	end
	for m in ("#mute #unmute #mutenext #parse"):gmatch("%S+") do
		api:RegisterCommand(m, true, false, core)
	end
	api:RegisterCommand("/stopmacro", true, false, core)
	api:AddCommandAliases("/stopmacro", getAliases("SLASH_STOPMACRO", 1))
	api:SetCommandHint("/stopmacro", math.huge, function(_, _, clause)
		return clause and "stop" or nil
	end)
	api:SetCommandHint(SLASH_CLICK1, math.huge, function(...)
		local _, _, clause = ...
		local name = clause and clause:match("%S+")
		return getCommandHintRaw(name and ("/click " .. name), ...)
	end)
	setCommandType("/use", 1+2, core)
	setCommandType("/cast", 1+2, core)
	api:AddCommandAliases("/cast", getAliases("SLASH_CAST", 1))
	api:AddCommandAliases("/use", getAliases("SLASH_USE", 1))
	setCommandType(SLASH_USERANDOM1, 1+2+4)
	api:AddCommandAliases(SLASH_USERANDOM1, getAliases("SLASH_CASTRANDOM", 1))
	setCommandType(SLASH_CASTSEQUENCE1, 1+2+4+8)
	api:RegisterCommand("/runmacro", true, false, core)
	api:SetCommandHint("/runmacro", math.huge, function(_slash, _, ...)
		local f = namedMacros[...]
		if f then return f(...) end
	end)

	AB = assert(T.ActionBook:compatible(2, 18), "A compatible version of ActionBook is required.")
	core:SetFrameRef("ActionBook", AB:seclib())
	core:Execute([[AB = self:GetFrameRef('ActionBook')]])
end
local caEscapeCache, cuHints = {}, {} do
	setmetatable(caEscapeCache, {__index=function(t, k)
		if k then
			local v = coreEnv.castEscapes[k:lower()] or false
			t[k] = v
			return v
		end
	end})
	local function mixHint(slash, _, clause, target, ...)
		local ca = caEscapeCache[clause]
		if ca then
			return true, AB:GetSlotInfo(ca)
		else
			local hint = cuHints[slash]
			if hint then
				return hint(slash, _, clause, target, ...)
			end
		end
	end
	setCommandHinter("/use", 100, mixHint)
	setCommandHinter("/cast", 100, mixHint)
end


function api:compatible(cmaj, crev)
	if init then
		init()
		init = nil
	end
	return (cmaj == MAJ and crev <= REV) and api or nil, MAJ, REV
end
function api:seclib()
	return core
end
function api:RegisterCommand(slash, isConditional, allowVars, handlerFrame)
	assert(type(slash) == "string" and (handlerFrame == nil or type(handlerFrame) == "table" and type(handlerFrame.GetAttribute) == "function"),
		'Syntax: Rewire:RegisterCommand("/slash", parseConditional, allowVars[, handlerFrame])')
	assert(handlerFrame == nil or handlerFrame:GetAttribute("RunSlashCmd"), 'Handler frame must have "RunSlashCmd" attribute set.')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local ct = (isConditional and 1 or 0) + (allowVars and 2 or 0)
	setCommandType(slash, ct, handlerFrame)
end
function api:AddCommandAliases(primary, ...)
	assert(type(primary) == "string", 'Syntax: Rewire:AddCommandAliases("/slash", ["/alias1", "/alias2", ...])')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local n, s = select("#", ...), "-- Rewire_AddCommandAliases\nlocal a, p = commandAlias, %s\n"
	s = s .. ("a[%s], "):rep(n-1) .. "a[%s] = " .. ("p, "):rep(n-1) .. "p\n"
	core:Execute(s:format(forall(safequote, primary, ...)))
end
function api:ImportSlashCmd(key, isConditional, allowVars, priority, hint)
	assert(type(key) == "string" and (hint == nil or type(hint) == "function" and type(priority) == "number"), 'Syntax: Rewire:ImportSlashCmd("KEY", parseConditional, allowVars[, hintPriority, hintFunc])')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local primary = _G["SLASH_" .. key .. "1"]
	api:RegisterCommand(primary, isConditional, allowVars)
	if _G["SLASH_" .. key .. "2"] then
		api:AddCommandAliases(getAliases("SLASH_" .. key, 1))
	end
	if primary and hint then
		self:SetCommandHint(primary, priority, hint)
	end
end
function api:SetCommandHint(slash, priority, hint)
	assert(type(slash) == "string" and (hint == nil or type(hint) == "function" and type(priority) == "number"), 'Syntax: Rewire:SetCommandHint("/slash", priority, hintFunc)')
	if slash ~= "/use" and slash ~= "/cast" then
		setCommandHinter(slash, priority, hint)
	else
		cuHints[slash] = hint
	end
end
function api:SetClickHint(buttonName, priority, hint)
	assert(type(buttonName) == "string" and (hint == nil or type(hint) == "function" and type(priority) == "number"), 'Syntax: Rewire:SetClickHint("buttonName", priority, hintFunc)')
	setCommandHinter("/click " .. buttonName, priority, hint)
end
function api:SetNamedMacroHandler(name, handlerFrame, hintFunc)
	assert(type(name) == "string" and type(handlerFrame) == "table" and type(handlerFrame.GetAttribute) == "function" and (hintFunc == nil or type(hintFunc) == "function"),
		'Syntax: Rewire:SetNamedMacroHandler(name, handlerFrame[, hintFunc])')
	assert(handlerFrame:GetAttribute("RunNamedMacro"), 'Handler frame must have "RunNamedMacro" attribute set.')
	if handlerFrame ~= GetFrameHandleFrame(coreEnv.macros[name]) then
		assert(not InCombatLockdown(), 'Combat lockdown in effect')
		core:SetFrameRef("SetNamedMacroHandler-handlerFrame", handlerFrame)
		core:Execute(('self:RunAttribute("SetNamedMacroHandler", %s)'):format(safequote(name)))
	end
	namedMacros[name] = hintFunc
end
function api:ClearNamedMacroHandler(name, handlerFrame)
	assert(type(handlerFrame) == "table" and type(name) == "string", 'Syntax: Rewire:ClearNamedMacroHandler("name", handlerFrame)')
	if GetFrameHandleFrame(coreEnv.macros[name]) == handlerFrame then
		core:Execute(('macros[%s] = nil'):format(safequote(name)))
		namedMacros[name] = nil
	end
end
function api:GetNamedMacros()
	return rtable.pairs(coreEnv.macros)
end
function api:GetMacroAction(macrotext, modState, minPriority)
	return getMacroHint(macrotext, modState, minPriority)
end
function api:GetCommandAction(slash, args, target, modState)
	return getCommandHint(nil, slash, args, modState, target)
end
function api:SetCastEscapeAction(castArg, action)
	assert(type(castArg) == "string" and (type(action) == "number" and action % 1 == 0 or action == nil), 'Syntax: Rewire:SetCastEscapeAction("castAction", abActionID or nil)')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	core:Execute(([[castEscapes[%q] = %s]]):format(castArg:lower(), action or "nil"))
	wipe(caEscapeCache)
end
function api:GetCastEscapeAction(castArg)
	return coreEnv.castEscapes[castArg and castArg:lower()]
end
function api:IsSpellCastable(id, disallowRewireEscapes)
	local cks = Spell_CheckKnown[id]
	if cks and not cks(id) then
		return false, "known-check"
	elseif Spell_UncastableIDs[id] then
		return false, "uncastable-class-lock"
	elseif Spell_ForcedID[id] then
		return not not FindSpellBookSlotBySpellID(id), "forced-id-cast"
	end
	local name, rank = GetSpellInfo(id)
	if disallowRewireEscapes ~= true and coreEnv.castEscapes[name and name:lower()] then
		return true, "rewire-escape"
	end
	return not not (name and GetSpellInfo(name, rank)), "double-gsi"
end

T.Rewire = {compatible=api.compatible}