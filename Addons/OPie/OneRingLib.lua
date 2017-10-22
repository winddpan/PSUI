local versionMajor, versionRev, L, ADDON, T, ORI = 3, 90, newproxy(true), ...
local api, OR_Rings, OR_ModifierLockState, TL, EV, OR_LoadedState = {ext={ActionBook=T.ActionBook},lang=L}, {}, nil, T.L, T.Evie, 1
local defaultConfig = {ClickActivation=false, IndicationOffsetX=0, IndicationOffsetY=0, RingAtMouse=false, RingScale=1, ClickPriority=true, CenterAction=false, MouseBucket=1, NoClose=false, NoCloseOnSlice=false, SliceBinding=false, SliceBindingString="1 2 3 4 5 6 7 8 9 0", SelectedSliceBind="", PrimaryButton="BUTTON4", SecondaryButton="BUTTON5", OpenNestedRingButton="BUTTON3", ScrollNestedRingUpButton="", ScrollNestedRingDownButton="", UseDefaultBindings=true}
local configRoot, configInstance, activeProfile, PersistentStorageInfo, optionValidators, optionsMeta = {}, nil, nil, {}, {}, {__index=defaultConfig}
local charId, internalFreeId = ("%s-%s"):format(GetRealmName(), UnitName("player")), 420

local AB, KR = T.ActionBook:compatible(2,14), T.ActionBook:compatible("Kindred",1,11) do
	AB:RegisterActionType("ring", function(name)
		return type(name) == "string" and OR_Rings[name] and OR_Rings[name].action or nil
	end, function(name)
		return "OPie Ring", OR_Rings[name] and OR_Rings[name].name or name, [[Interface\AddOns\OPie\gfx\opie_ring_icon]]
	end)
	AB:AugmentCategory("OPie rings", function(_, add)
		for i=1,#OR_Rings do
			add("ring", OR_Rings[i])
		end
	end)
end

local function assert(condition, text, level, ...)
	return (not condition) and error(tostring(text):format(...), 1 + (level or 1)) or condition
end
local copy do -- (tbl, into) -> into
	local copies = {}
	local function icopy(t, into)
		if type(into) == "table" then
			for k,v in pairs(into) do
				if not (type(k) ~= "table" and type(v) == "table" and type(t[k]) == "table") then
					into[k] = nil
				end
			end
		else
			into = {}
		end
		copies[t] = into
		for k,v in pairs(t) do
			into[type(k) == "table" and (copies[k] or icopy(k)) or k] = type(v) == "table" and (copies[v] or icopy(v, into[k])) or v
		end
		return into
	end
	function copy(t, into)
		assert(type(t) == "table" and (into == nil or type(into) == "table"), "Syntax: copy(tbl[, into])")
		local _, ret = wipe(copies), icopy(t, into), wipe(copies)
		return ret
	end
end
local function tostringf(b)
	return b and "true" or "nil"
end
local function getSpecCharIdent()
	local tg = GetSpecialization()
	return (tg == 1 and "%s" or "%s-%d"):format(charId, tg)
end
local safequote do
	local r = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
	function safequote(s)
		return (("%q"):format(s):gsub("[{}u]", r))
	end
end
getmetatable(L).__call, T.L = TL and function(_,k) return TL[k] or k end or function(_,k) return k end, L

-- Here be (Secure) Dragons
local OR_SecCore = CreateFrame("Button", "ORL_RTrigger", UIParent, "SecureActionButtonTemplate,SecureHandlerAttributeTemplate,SecureHandlerMouseWheelTemplate")
local OR_OpenProxy = CreateFrame("Button", "ORLOpen", nil, "SecureActionButtonTemplate")
local OR_SecEnv, OR_ActiveRingName, OR_ActiveCollectionID, OR_ActiveSliceCount
OR_SecCore:SetSize(9001*4, 9001*4); OR_SecCore:SetFrameStrata("FULLSCREEN_DIALOG"); OR_SecCore:RegisterForClicks("AnyUp", "AnyDown"); OR_SecCore:Hide();
OR_SecCore:SetFrameRef("AB", AB:seclib())
OR_SecCore:SetFrameRef("KR", KR:seclib())
local OR_DeferExecute do
	local queue, qc, qpos = {}, 0
	function OR_DeferExecute(block, ...)
		if block then queue[qc+1], qc = block:format(...), qc + 1 end
		if InCombatLockdown() or qpos then return end
		qpos = 1 while qpos <= qc do
			OR_SecCore:Execute(queue[qpos])
			qpos = qpos + 1
		end
		qc, qpos = 0
	end
end
do -- Click dispatcher
	local bindProxy = CreateFrame("Frame", "ORL_BindProxy", nil, "SecureFrameTemplate")
	OR_SecCore:SetFrameRef("bindProxy", bindProxy)
	OR_SecCore:SetFrameRef("sliceBindProxy", CreateFrame("Frame", "ORL_BindProxySlice", nil, "SecureFrameTemplate"))
	OR_SecCore:SetFrameRef("overBindProxy", CreateFrame("Frame", "ORL_BindProxyOverride", nil, "SecureFrameTemplate"))
	OR_SecCore:Execute([=[-- OR_SecCore
		ORL_GlobalOptions, ORL_RingData, ORL_RingDataN = newtable(), newtable(), newtable()
		ORL_KnownCollections, ORL_StoredCA = newtable(), newtable()
		collections, ctokens, rotation, rtokens, fcIgnore, rotIgnore, emptyTable = newtable(), newtable(), newtable(), newtable(), newtable(), newtable(), newtable()
		modState, sizeSq, bindProxy, sliceProxy, overProxy = "", 16*9001^2, self:GetFrameRef("bindProxy"), self:GetFrameRef("sliceBindProxy"), self:GetFrameRef("overBindProxy")
		AB, KR = self:GetFrameRef("AB"), self:GetFrameRef("KR")

		PrepareCollection = [==[-- PrepareCollection
			wipe(collections) wipe(ctokens)
			local firstFC, root, colData, openAction = nil, ..., AB:RunAttribute("GetCollectionContent", ...)
			for cid, i, aid, tok in (colData or ""):gmatch("\n(%d+) (%d+) (%d+) (%S+)") do
				cid, i, aid = tonumber(cid), tonumber(i), tonumber(aid)
				if not collections[cid] then collections[cid], ctokens[cid] = newtable(), newtable() end
				collections[cid][i], ctokens[cid][i], ctokens[cid][tok], firstFC = aid, tok, i, firstFC or (cid == root and not fcIgnore[tok] and tok)
			end
			collections[root], ctokens[root] = collections[root] or emptyTable, ctokens[root] or emptyTable
			for cid, list in pairs(collections) do
				for i, aid in pairs(list) do
					if collections[aid] then
						local tok = ctokens[cid][i]
						rotation[tok] = not rotIgnore[ctokens[cid][i]] and ctokens[aid][rtokens[tok]] or 1
					end
				end
			end
			return openAction, firstFC
		]==]
		ORL_CloseActiveRing = [[-- CloseActiveRing
			local old, shouldKeepOwner, selSliceIndex, selSliceAction = activeRing, ...;
			if not shouldKeepOwner then	owner:Hide();	end
			bindProxy:ClearBindings()
			sliceProxy:ClearBindings()
			activeRing, activeBind, openCollection, openCollectionID = nil
			owner:CallMethod("NotifyState", "close", old.name, old.action, selSliceIndex, selSliceAction);
		]]
		ORL_RegisterVariations = [[-- RegisterVariations
			local binding, mapkey, downmix = ...;
			for alt=0,downmix:match("ALT") and 1 or 0 do for ctrl=0,downmix:match("CTRL") and 1 or 0 do for shift=0,downmix:match("SHIFT") and 1 or 0 do
				self:SetBindingClick(true, (alt == 1 and "ALT-" or "") .. (ctrl == 1 and "CTRL-" or "") .. (shift == 1 and "SHIFT-" or "") .. binding, owner, mapkey);
			end end end
		]]
		ORL_OpenRing = [==[-- OpenRing
			local ring, ringID, interactBinding, forceLC, fastSwitch = ORL_RingData[...], ...
			leftActivation = not not (forceLC or ring.ClickActivation)
			modState = (leftActivation and "") or (fastSwitch and modState) or ((IsAltKeyDown() and "A" or "") .. (IsControlKeyDown() and "C" or "") .. (IsShiftKeyDown() and "S" or ""))
			
			local cid = ring.action
			local openAction, firstFC = owner:Run(PrepareCollection, cid)
			openCollection, openCollectionID = collections[cid], cid
			activeRing, activeBind = ring, leftActivation and "BUTTON1" or (fastSwitch and activeBind or interactBinding)
			if ORL_StoredCA[ring.name] and not ring.fcToken then ring.fcToken, ORL_StoredCA[ring.name] = ORL_StoredCA[ring.name] end
			fastClick = ring.CenterAction and ((not fcIgnore[ring.fcToken] and ctokens[cid][ring.fcToken]) or (ring.OpprotunisticCA and ctokens[cid][firstFC])) or nil
			
			if interactBinding ~= "BUTTON2" then bindProxy:SetBindingClick(true, "BUTTON2", owner, "close") end
			bindProxy:SetBindingClick(true, "ESCAPE", owner, "close")
			owner:RunFor(bindProxy, ORL_RegisterVariations, "MOUSEWHEELUP", "mwup", "ALT-CTRL-SHIFT")
			owner:RunFor(bindProxy, ORL_RegisterVariations, "MOUSEWHEELDOWN", "mwdown", "ALT-CTRL-SHIFT")
			do local down, up, open = ORL_GlobalOptions.ScrollNestedRingDownButton or "", ORL_GlobalOptions.ScrollNestedRingUpButton or "", ORL_GlobalOptions.OpenNestedRingButton or ""
				if down ~= "" then owner:RunFor(bindProxy, ORL_RegisterVariations, down, "mwdownK", "ALT-CTRL-SHIFT") end
				if up ~= "" then owner:RunFor(bindProxy, ORL_RegisterVariations, up, "mwupK", "ALT-CTRL-SHIFT") end
				if open ~= "" and not (interactBinding or ""):match(open .. "$") then owner:RunFor(bindProxy, ORL_RegisterVariations, open, "mwin", "ALT-CTRL-SHIFT"); end
			end
			if leftActivation and interactBinding then
				bindProxy:SetBindingClick(true, interactBinding, self, "close");
			end
			owner:Run(ORL_OpenRing2)
			if activeBind and (leftActivation or not fastSwitch) then
				bindProxy:SetBindingClick(true, activeBind, self, "use")
			end
			
			owner:SetScale(ring.scale)
			owner:SetPoint('CENTER', ring.ofs, ring.ofsx/owner:GetEffectiveScale(), ring.ofsy/owner:GetEffectiveScale())
			if ring.ClickPriority then owner:Show() end

			owner:CallMethod("NotifyState", "open", ring.name, ring.action, fastClick, fastSwitch, modState)
			return owner:RunFor(self, ORL_PerformAB, openAction)
		]==];
		ORL_OpenRing2 = [[-- OpenRing2
			sliceProxy:ClearBindings()
			if activeRing.SliceBinding then
				local prefix = activeRing.bind and not leftActivation and activeRing.bind:match("^(.-)[^-]*$") or "";
				for i,b in pairs(activeRing.SliceBinding) do
					if openCollection[i] then
						owner:RunFor(sliceProxy, ORL_RegisterVariations, b, "slice" .. i, prefix);
					end
				end
			end
			if (activeRing.SelectedSliceBind or "") ~= "" then
				local prefix = activeRing.bind and not leftActivation and activeRing.bind:match("^(.-)[^-]*$") or "";
				owner:RunFor(sliceProxy, ORL_RegisterVariations, activeRing.SelectedSliceBind, "usenow", prefix)
			end
			wheelBucket = 0
		]]
		ORL_GetPureSlice = [[-- GetPureSlice
			if not openCollection[1] then return nil end
			local x, y = owner:GetMousePosition(); x, y = x - 0.5, y - 0.5;
			local radius, segAngle = (x*x*sizeSq + y*y*sizeSq)^0.5, 360/#openCollection;
			if radius >= 40 then return floor(((math.deg(math.atan2(x, y)) + segAngle/2 - activeRing.ofsRad) % 360) / segAngle) + 1, false;
			elseif radius <= 20 then return fastClick, true; end
		]];
		ORL_GetSlice = [[-- GetSlice
			local col, index = ...
			visitedSlices = wipe(visitedSlices or newtable())
			while 1 do
				local aid, ct = collections[col] and collections[col][index], ctokens[col] and ctokens[col][index]
				if visitedSlices[ct] or not aid then
					return
				elseif not collections[aid] then
					return aid
				end
				visitedSlices[ct], col, index = true, aid, rotation[ct] or 1
			end
		]];
		ORL_PerformAB = [[-- PerformAB
			local action = ...
			if action then
				self:SetAttribute("type", "macro")
				self:SetAttribute("macrotext", AB:RunAttribute("UseAction", action))
			end
			return action or false, 0
		]]
		ORL_PerformSliceAction = [[-- PerformSliceAction
			local pureSlice, shouldUpdateFastClick, noClose = ...
			local pureToken, action = ctokens[openCollectionID][pureSlice], owner:Run(ORL_GetSlice, openCollectionID, pureSlice)
			activeRing.fcToken = shouldUpdateFastClick and activeRing.CenterAction and not fcIgnore[pureToken] and pureToken or activeRing.fcToken
			if not (leftActivation and activeRing.NoClose or noClose) then owner:Run(ORL_CloseActiveRing, nil, pureSlice, action) end
			return owner:RunFor(self, ORL_PerformAB, action)
		]];
		ORL_OnWheel = [==[-- OnWheel (delta)
			local slice = owner:Run(ORL_GetPureSlice)
			local nestedCol = collections[openCollection[slice]]
			if not (slice and nestedCol) then return end
			if slice ~= wheelSlice then wheelSlice, wheelBucket = slice, 0 end
			wheelBucket = wheelBucket + (...)
			if abs(wheelBucket) >= activeRing.bucket then wheelBucket = 0 else return end
			local stoken, step, count, c = ctokens[openCollectionID][slice], (...) > 0 and 0 or -2, #nestedCol, 0
			repeat
				rotation[stoken], c = (rotation[stoken] + step) % count + 1, c + 1
			until owner:Run(ORL_GetSlice, openCollectionID, slice) or c == count
			rtokens[stoken] = (ctokens[openCollection[slice]] or emptyTable)[rotation[stoken]] or rtokens[stoken]
		]==];
		ORL_OnClick = [==[-- OnClick
			local button, down = ...;
			local b2 = "-" .. (IsAltKeyDown() and "ALT-" or "") ..  (IsControlKeyDown() and "CTRL-" or "") .. (IsShiftKeyDown() and "SHIFT-" or "") .. button:upper();
			local openHotkeyOverride, openHotkeyId = button:match("^r(o?)(%d+)$"); openHotkeyId = tonumber(openHotkeyId)
			if openHotkeyOverride == "o" and activeRing == ORL_RingData[openHotkeyId] and activeBind ~= "BUTTON1" and not down then button = "use" end
			if button == "LeftButton" and activeRing and leftActivation then button = "use"; end
			if button == "RightButton" or (activeRing and activeRing.ClickPriority and leftActivation and activeRing.bind and b2:match(activeRing.bindMatch)) then button = "close"; end
			if button == "MiddleButton" and ORL_GlobalOptions.OpenNestedRingButton == "BUTTON3" then button = "mwin"; end

			if activeRing and down and button:match("^mw[ud]") then
				return false, owner:Run(ORL_OnWheel, (button:match("^mwup") and 1 or -1) * (button:match("K$") and activeRing.bucket or 1))
			elseif activeRing and not down and ((button == "use") or (button == "close" and leftActivation and fastClick)) then
				local slice, isFC = control:Run(ORL_GetPureSlice);
				if button == "close" and not (isFC and slice) then return false; end
				return control:RunFor(self, ORL_PerformSliceAction, slice, openCollectionID == activeRing.action);
			elseif activeRing and down and button == "close"  then
				return false, control:Run(ORL_CloseActiveRing);
			elseif activeRing and down and button == "usenow" then
				return control:RunFor(self, ORL_PerformSliceAction, control:Run(ORL_GetPureSlice), false, true)
			elseif activeRing and leftActivation and button == "Button1" then
				return control:RunFor(self, ORL_OnClick, "use", down);
			elseif activeRing and activeRing.bind and b2:match(activeRing.bindMatch) then
				return control:RunFor(self, ORL_OnClick, leftActivation and "close" or "use", down);
			elseif activeRing and button:match("slice(%d+)") then
				local b = tonumber(button:match("slice(%d+)"))
				if openCollection and openCollection[b] and not down then
					return control:RunFor(self, ORL_PerformSliceAction, b, activeRing.NoCloseOnSlice)
				end
			elseif button:match("Button%d+") then
				-- The click-capturing overlay captures all mouse clicks, including those used in proper bindings
				local lvalue, lkey = 0, nil;
				for k, v in pairs(ORL_RingData) do
					if v.bind and b2:match(v.bindMatch) and #v.bind > lvalue then
						lkey, lvalue = k, #v.bind;
					end
				end
				if lkey then
					return owner:RunFor(self, ORL_OnClick, "r" .. lkey, down);
				end
			elseif button == "mwin" and activeRing and down then
				local aid = openCollection[control:Run(ORL_GetPureSlice)]
				if not collections[aid] then
				elseif ORL_KnownCollections[aid] then
					return control:RunFor(self, ORL_OpenRing, ORL_KnownCollections[aid], nil, leftActivation, true)
				else
					openCollection, openCollectionID, fastClick = collections[aid], aid
					owner:Run(ORL_OpenRing2)
					control:CallMethod("NotifyState", "switch", nil, openCollectionID, fastClick, true, modState)
				end
			elseif openHotkeyId and activeRing ~= ORL_RingData[openHotkeyId] and down then
				if activeRing then
					-- If the click-capturing overlay gets the binding DOWN event, only *it* will be notified of the corresponding UP.
					owner:Run(ORL_CloseActiveRing, self == owner);
				end
				local binding = ORL_RingData[openHotkeyId].bind
				if openHotkeyOverride == "o" and bindOverrides[openHotkeyId] then
					binding = bindOverrides[openHotkeyId]
				end
				return owner:RunFor(self, ORL_OpenRing, openHotkeyId, binding)
			end
			return false
		]==];
		ORL_OpenClick = [[-- OpenClick
			local rdata, cur = ORL_RingDataN[...], activeRing
			if not rdata then
				return print("|cffff0000[ORL] Unknown ring alias: ".. tostring((...)))
			elseif cur then
				control:Run(ORL_CloseActiveRing)
				if cur == rdata then return end
			end
			return control:RunFor(self, ORL_OpenRing, rdata.id, nil, true)
		]];
	]=])
	OR_SecCore:SetAttribute("_onmousewheel", "return self:Run(ORL_OnWheel, delta)")
	OR_SecCore:WrapScript(OR_SecCore, "OnClick", "return self:Run(ORL_OnClick, button, down)", "self:SetAttribute('type', nil)")
	OR_SecCore:WrapScript(OR_OpenProxy, "OnClick", "return owner:Run(ORL_OpenClick, button)")
	OR_SecCore:WrapScript(bindProxy, "OnAttributeChanged", [[-- ORL.BindProxy-OnAttributeChanged
		local data = ORL_RingData[tonumber(type(name) == "string" and name:match("^binding%-r(%d+)$"))]
		if data then
			value = value ~= "" and value or nil
			data.bind, data.bindMatch = value, value and (value:gsub("[%-%[%]%*%+%?%.]", "%%%1") .. "$")
		end
	]])
	OR_SecEnv = GetManagedEnvironment(OR_SecCore)
end
local function OR_GetRingOption(ringName, option)
	if not configInstance then return defaultConfig[option], nil, nil, nil, defaultConfig[option] end
	local ring, global, default, value, setting = configInstance.RingOptions[ringName and (ringName .. "#" .. option)], rawget(configInstance, option), defaultConfig[option]
	if ringName ~= nil then setting = ring else setting = global end
	if ringName ~= nil and ring ~= nil then value = ring
	elseif ring == nil and global ~= nil then value = global
	else value = default end
	return value, setting, ring, global, default
end
local OR_SyncRingBinding do -- Binding management
	local bindingEncodeChars = {["["]="OPEN", ["]"]="CLOSE", [";"]="SEMICOLON"}
	local function RemoveConflictingBindings(whole, bind)
		return GetBindingAction(bind) ~= "" and ";" or whole
	end
	function OR_SyncRingBinding(name, props)
		if InCombatLockdown() then return end
		local hotkey, isSoftBinding, id = configInstance and configInstance.Bindings[name], false, props.internalID
		if hotkey == nil and type(props.hotkey) == "string" and OR_GetRingOption(name, "UseDefaultBindings") then
			hotkey, isSoftBinding = props.hotkey, true
		end
		if hotkey then
			if not hotkey:match("%[.*%]") then
				hotkey = "[] " .. hotkey:gsub("([^-]+)%s*$", bindingEncodeChars)
			end
			if isSoftBinding then
				hotkey = (hotkey .. ";"):gsub("(([^%s%[%];]+)%s*;)", RemoveConflictingBindings)
			end
		end
		if not OR_SecCore:GetAttribute("frameref-proxy" .. id) then
			local f = CreateFrame("Button", "ORL_RProxy" .. id, nil, "SecureActionButtonTemplate")
			f:RegisterForClicks("AnyUp", "AnyDown")
			OR_SecCore:WrapScript(f, "OnClick", "return owner:RunFor(self, ORL_OnClick, button, down)", 'self:SetAttribute("type", nil)')
			OR_SecCore:SetFrameRef("proxy" .. id, f)
			_G["BINDING_NAME_CLICK ".. f:GetName() .. ":r" .. id] = (L"OPie ring: %s"):format(props.name or "?")
		end
		if props.currentBindingConditional == hotkey then
			return
		end
		props.currentBindingConditional = hotkey
		OR_DeferExecute([=[-- OR_SyncRingBinding
			local ringName, internalId = %s, %d
			KR:SetAttribute("frameref-RegisterBindingDriver-target", self:GetFrameRef("proxy" .. internalId))
			KR:SetAttribute("frameref-RegisterBindingDriver-notify", bindProxy)
			KR:RunAttribute("RegisterBindingDriver", "r" .. internalId, %s, -10)
		]=], safequote(name), id, safequote((hotkey or "") .. ";"))
	end
	OR_SecCore:Execute([=[-- BindingInit
		bindOverrides = newtable()
		RegisterStateDriver(self, "combat", "[combat] combat; nocombat")
		ORL_RegisterOverride = [[-- ORL_RegisterOverride
			local id, bind = ...
			if bindOverrides[id] then overProxy:ClearBinding(bindOverrides[id]) end
			if bindOverrides[bind] then bindOverrides[ bindOverrides[bind] ] = nil end
			if bind then
				overProxy:SetBindingClick(true, bind, self:GetFrameRef("proxy" .. id), "ro" .. id)
				bindOverrides[bind] = ring
			end
			bindOverrides[id] = bind
		]]
	]=])
	OR_SecCore:SetAttribute("_onattributechanged", [=[-- ORL_UpdateBinding
		if name == "state-combat" and value == "combat" then
			overProxy:ClearBindings()
			wipe(bindOverrides)
		end
	]=])
end
local function OR_SyncRing(name, actionId, newprops)
	local props = OR_Rings[name] or {}
	if not OR_Rings[name] then
		OR_Rings[name], OR_Rings[#OR_Rings+1], props.internalID, internalFreeId = props, name, internalFreeId, internalFreeId+1
	end
	if newprops then
		props.action, props.offset, props.name, props.hotkey, props.internal = actionId, newprops.offset or 0, newprops.name or name, newprops.hotkey, newprops.internal
		local fcBlock = ""
		for i=1,#newprops do
			if newprops[i].sliceToken then
				fcBlock = fcBlock .. ("fcIgnore[%s], rotIgnore[%1$s] = %s, %s "):format(safequote(newprops[i].sliceToken), tostringf(not newprops[i].fastClick), tostringf(newprops[i].lockRotation))
			end
		end
		props.fcBlock, props.opportunisticCA, props.noPersistentCA = fcBlock, not newprops.noOpportunisticCA, newprops.noPersistentCA
	end

	local sliceBindTable = "false"
	if OR_GetRingOption(name, "SliceBinding") then
		local bound = false
		for s in OR_GetRingOption(name, "SliceBindingString"):gmatch("%S+") do
			local u = s:upper();
			if u:match("BUTTON[123]$") or u:match("ESCAPE$") then s = "false"; end
			if sliceBindTable == "false" then
				sliceBindTable = ("newtable(%s"):format(safequote(s))
			else
				sliceBindTable = ("%s, %s"):format(sliceBindTable, safequote(s))
			end
			bound = bound or (s ~= "false")
		end
		sliceBindTable = bound and (sliceBindTable .. ")") or "false";
	end

	OR_DeferExecute([[-- SyncRing
		local ringName, internalId, actionId = %s, %d, %d
		local data = ORL_RingData[internalId] or newtable()
		ORL_KnownCollections[actionId], ORL_RingData[internalId], ORL_RingDataN[ringName], data.action, data.name, data.id = internalId, data, data, actionId, ringName, internalId
		data.name, data.ofs, data.ofsx, data.ofsy, data.ofsRad = ringName, "%s", %d, %d, %f
		data.CenterAction, data.ClickActivation, data.ClickPriority, data.NoClose, data.NoCloseOnSlice, data.scale, data.bucket = %s, %s, %s, %s, %s, %f, %d
		data.SliceBinding, data.SelectedSliceBind, data.OpprotunisticCA = %s, %s, %s
		%s
	]], safequote(name), props.internalID, props.action,
		OR_GetRingOption(name, "RingAtMouse") and "$cursor" or "$screen", OR_GetRingOption(name, "IndicationOffsetX"), -OR_GetRingOption(name, "IndicationOffsetY"), props.offset,
		tostringf(OR_GetRingOption(name, "CenterAction")), tostringf(OR_GetRingOption(name, "ClickActivation")), tostringf(OR_GetRingOption(name, "ClickPriority")), tostringf(OR_GetRingOption(name, "NoClose")), tostringf(OR_GetRingOption(name, "NoCloseOnSlice")), math.max(0.1, (OR_GetRingOption(name, "RingScale"))), (OR_GetRingOption(name, "MouseBucket")),
		sliceBindTable, safequote(OR_GetRingOption(name, "SelectedSliceBind") or ""), tostringf(props.opportunisticCA),
		props.fcBlock or "")
	OR_SyncRingBinding(name, props)
	if newprops and AB then AB:NotifyObservers("ring") end
end
local function OR_DeleteRing(name, data)
	OR_DeferExecute([[-- DeleteRing
		local ringName, internalId, actionId = %s, %d, %d
		self:SetAttribute("state-r" .. internalId, nil)
		ORL_KnownCollections[actionId], ORL_RingData[internalId], ORL_RingDataN[ringName] = nil
		KR:SetAttribute("frameref-UnregisterBindingDriver-target", self:GetFrameRef("proxy" .. internalId))
		KR:RunAttribute("UnregisterBindingDriver", "r" .. internalId)
	]], safequote(name), data.internalID, data.action or 0)

	local bind = configInstance and configInstance.Bindings[name]
	if configRoot and configRoot.ProfileStorage then
		local rnOpt = "^" .. name:gsub("[%]%[().+*-?^$%%]", "%%%1") .. "#"
		for _,v in pairs(configRoot.ProfileStorage) do
			if v.Bindings then
				v.Bindings[name] = nil
			end
			if v.RingOptions then
				for k2, _v2 in pairs(v.RingOptions) do
					if type(k2) ~= "string" or k2:match(rnOpt) then
						v.RingOptions[k2] = nil
					end
				end
			end
		end
	end
	OR_Rings[name] = nil
	tDeleteItem(OR_Rings, name)

	if bind then
		for k, v in pairs(OR_Rings) do
			if v.hotkey == bind then
				OR_SyncRing(k)
			end
		end
	end
end
local function OR_SecProfilePull()
	local pInstance = configRoot.ProfileStorage[OR_SecEnv.activeProfile]
	if not pInstance then return end
	for k, v in rtable.pairs(OR_SecEnv.rtokens) do
		pInstance.RotationTokens[k] = v
	end
end
local function OR_SecProfilePush()
	if InCombatLockdown() or (activeProfile == OR_SecEnv.activeProfile) then return end
	local e = ("-- SecProfilePush\n activeProfile = %s"):format(safequote(activeProfile))
	for k,v in pairs(configInstance.RotationTokens) do
		e = e .. ("\n rtokens[%s] = %s"):format(safequote(k), safequote(v))
	end
	OR_SecCore:Execute(e)
end
local function OR_PullCAs()
	local t = {}
	for k,v in rtable.pairs(OR_SecEnv.ORL_StoredCA) do
		t[k] = v
	end
	for _, k in ipairs(OR_Rings) do
		local rt = OR_SecEnv.ORL_RingDataN[k] and OR_SecEnv.ORL_RingDataN[k].fcToken or t[k]
		t[k] = not ((OR_Rings[k] and OR_Rings[k].noPersistentCA) or OR_SecEnv.fcIgnore[rt]) and rt or nil
	end
	return next(t) and t or nil
end
local OR_FindFinalAction do
	local seen, wipe = {}, table.wipe
	local secRotation, secCollections, secTokens = OR_SecEnv.rotation, OR_SecEnv.collections, OR_SecEnv.ctokens
	function OR_FindFinalAction(collection, id, from, rotationBonus)
		local col = OR_SecEnv.collections[collection]
		local act = col and col[id]
		if act then
			local nCol, tok = secCollections[act], secTokens[collection][id]
			if nCol and not seen[tok] then
				seen[tok] = true
				local rot = secRotation[tok] or 1
				if tok == from then rot = (rot + rotationBonus - 1) % #nCol + 1 end
				return OR_FindFinalAction(act, rot, from, rotationBonus)
			elseif nCol == nil then
				wipe(seen)
				return act, tok
			end
		end
		wipe(seen)
	end
end
function OR_SecCore:NotifyState(state, _ringName, collection, ...)
	if state == "open" then
		MouselookStop()
		local bind, fastClick, fastOpen, ms = OR_SecEnv.activeBind or "", ...
		OR_ModifierLockState = (ms:match("A") or bind:match("ALT%-") and "a" or "-") .. (ms:match("S") or bind:match("SHIFT%-") and "s" or "-") .. (ms:match("C") or bind:match("CTRL%-") and "c" or "-")
		OR_ActiveCollectionID, OR_ActiveRingName, OR_ActiveSliceCount = collection, OR_SecEnv.activeRing.name, #OR_SecEnv.openCollection
		if ORI then
			securecall(ORI.Show, ORI, collection, fastClick, fastOpen)
		end
	elseif state == "switch" then
		OR_ActiveCollectionID, OR_ActiveSliceCount = collection, #OR_SecEnv.openCollection
		if ORI then
			securecall(ORI.Show, ORI, collection, ..., true)
		end
	elseif state == "close" then
		if ORI then
			securecall(ORI.Hide, ORI, ...)
		end
		OR_ActiveSliceCount, OR_ActiveCollectionID, OR_ActiveRingName = 0
	end
end

-- Responding to WoW Events
local function OR_NotifyPVars(event, filter, perProfile)
	for k, v in pairs(PersistentStorageInfo) do
		if type(v.f) == "function" and v.t == (filter or v.t) and (perProfile == nil or perProfile == v.perProfile) then
			securecall(v.f, event, k, v.t);
		end
	end
end
local function OR_ForceResync(filter)
	for _,v in ipairs(OR_Rings) do
		if (filter or v) == v then
			OR_SyncRing(v)
		end
	end
	if (filter or true) == true then
		OR_DeferExecute([[-- SyncGlobalOptions
			ORL_GlobalOptions.OpenNestedRingButton, ORL_GlobalOptions.ScrollNestedRingUpButton, ORL_GlobalOptions.ScrollNestedRingDownButton = %s, %s, %s
		]], safequote(OR_GetRingOption(nil, "OpenNestedRingButton")), safequote(OR_GetRingOption(nil, "ScrollNestedRingUpButton")), safequote(OR_GetRingOption(nil, "ScrollNestedRingDownButton")))
	end
end
local function OR_CheckBindings()
	if InCombatLockdown() then return end
	for i=1,#OR_Rings do
		local k = OR_Rings[i]
		OR_SyncRingBinding(k, OR_Rings[k])
	end
end
function EV:PLAYER_REGEN_ENABLED()
	OR_CheckBindings()
	OR_SecProfilePush()
	OR_DeferExecute()
end
local function OR_UnserializeConfigInstance(profile)
	activeProfile = configRoot.ProfileStorage[profile] and profile or "default";
	local newCI = configRoot.ProfileStorage[activeProfile];
	for t in ("RingOptions Bindings RotationTokens"):gmatch("%S+") do
		if type(newCI[t]) ~= "table" then newCI[t] = {} end
	end
	for k,v in pairs(PersistentStorageInfo) do if v.perProfile then	copy(newCI[k], v.t) end end
	configInstance = setmetatable(newCI, optionsMeta)
end
local function OR_NotifyOptions()
	for option, func in pairs(optionValidators) do
		if func then
			securecall(func, option, configInstance[option]);
		end
	end
end
local function OR_InitConfigState()
	if type(OneRing_Config) == "table" then
		for k, v in pairs(OneRing_Config) do
			configRoot[k] = v
		end
	end
	if GetCVarBool("enableWowMouse") then
		defaultConfig.PrimaryButton, defaultConfig.SecondaryButton = "BUTTON12", "BUTTON13"
	end

	for t in ("CharProfiles PersistentStorage ProfileStorage"):gmatch("%S+") do
		if type(configRoot[t]) ~= "table" then configRoot[t] = {}; end
	end
	
	local gameVersion = GetBuildInfo()
	if configRoot._GameVersion ~= gameVersion then
		for _,v in pairs(configRoot.ProfileStorage) do
			if type(v) == "table" then
				v.RotationTokens = nil
			end
		end
	end
	configRoot._GameVersion, configRoot._GameLocale = gameVersion, GetLocale()
	configRoot._OPieVersion = ("%s (%d.%d)"):format(api:GetVersion())
	
	if type(configRoot.ProfileStorage.default) ~= "table" then
		configRoot.ProfileStorage.default = {Bindings=configRoot.Bindings or {}, RingOptions=configRoot.RingOptions or {}};
	end
	OR_UnserializeConfigInstance(configRoot.CharProfiles[getSpecCharIdent()] or configRoot.CharProfiles[charId])

	if type(configRoot.CenterActions) == "table" then
		local exec = "-- InitCA"
		for name, tok in pairs(configRoot.CenterActions) do
			exec = ("%s\nORL_StoredCA[%s] = %s"):format(exec, safequote(name), safequote(tok))
		end
		OR_SecCore:Execute(exec)
	end

	-- Load variables into relevant tables, unlock core and fire notifications.
	for k, v in pairs(configRoot.PersistentStorage) do
		if PersistentStorageInfo[k] and not PersistentStorageInfo[k].perProfile then
			copy(v, PersistentStorageInfo[k].t)
		end
	end
	OneRing_Config, configRoot.CenterActions = nil
	OR_NotifyPVars("LOADED")
	OR_NotifyOptions()
	OR_SecProfilePush()
	OR_ForceResync()
end
function EV:ADDON_LOADED(addon)
	if addon == ADDON then
		ORI, OR_LoadedState = T.OPieUI, OR_LoadedState == 1 and 2 or OR_LoadedState
		OR_InitConfigState()
		OR_ForceResync(true)
		return "remove"
	end
end
function EV:SAVED_VARIABLES_TOO_LARGE(addon)
	if addon == ADDON then
		OR_LoadedState = false
	end
end
function EV:PLAYER_LOGIN()
	OR_LoadedState = OR_LoadedState == 1 and 3 or OR_LoadedState
	OR_NotifyPVars("LOGIN")
	return "remove"
	--TODO: OR_SecCore:Execute(OR_SecEnv.ORL_ReassertBindings)
end
function EV:PLAYER_LOGOUT()
	OneRing_Config = configRoot
	OR_NotifyPVars("LOGOUT")
	OR_SecProfilePull()
	configRoot.CenterActions = OR_PullCAs()
	for k, v in pairs(configInstance) do
		if v == defaultConfig[k] then
			configInstance[k] = nil
		end
	end
	for k, v in pairs(PersistentStorageInfo) do
		local store = v.perProfile and configInstance or configRoot.PersistentStorage
		store[k] = next(v.t) ~= nil and v.t or nil
	end
	for _, v in pairs(configRoot.ProfileStorage) do
		if v.RingOptions and next(v.RingOptions) == nil then v.RingOptions = nil end
		if v.Bindings and next(v.Bindings) == nil then v.Bindings = nil end
		if v.RotationTokens and next(v.RotationTokens) == nil then v.RotationTokens = nil end
	end
end
local function OR_SaveCurrentProfile()
	OR_NotifyPVars("SAVE", nil, true)
	for k, v in pairs(PersistentStorageInfo) do
		if v.perProfile then
			configInstance[k] = next(v.t) and copy(v.t)
		end
	end
	OR_SecProfilePull()
end
local function OR_SwitchProfile(ident)
	if ident ~= activeProfile then OR_SaveCurrentProfile() end
	OR_UnserializeConfigInstance(ident)
	OR_NotifyPVars("UPDATE", nil, true)
	OR_NotifyOptions()
	OR_SecProfilePush()
	OR_ForceResync()
end
function EV:ACTIVE_TALENT_GROUP_CHANGED()
	local newProfile = configRoot.CharProfiles[getSpecCharIdent()];
	if configRoot.ProfileStorage[newProfile] and newProfile ~= activeProfile then
		OR_SwitchProfile(newProfile);
	end
end

-- Public API
function api:SetRing(name, actionId, props)
	assert(type(name) == "string" and (actionId == nil or (type(props) == "table" or type(actionId) == "number")), 'Syntax: api:SetRing("ringName"[, actionId, propsTable])', 2)
	if actionId then
		OR_SyncRing(name, actionId, props)
	elseif OR_Rings[name] then
		OR_DeleteRing(name, OR_Rings[name])
	end
end
function api:GetNumRings()
	return #OR_Rings;
end
function api:GetRingInfo(id)
	assert(type(id) == "number" or type(id) == "string", 'Syntax: name, key, macro, flags = api:GetRingInfo(index or "ringName")', 2)
	local key = type(id) == "string" and OR_Rings[id] and id or OR_Rings[id]
	if not key then return end
	local props = OR_Rings[key]
	return props.name, key, "/click "..OR_OpenProxy:GetName().." "..key, (props.internal and 1 or 0)
end
function api:IsKnownRingName(ringName)
	assert(type(ringName) == "string", 'Syntax: isKnown = api:IsKnownRingName("ringName")', 2)
	if OR_Rings[ringName] then return true end
	for _, v in pairs(configRoot.ProfileStorage) do
		if type(v.Bindings) == "table" and v.Bindings[ringName] then
			return true
		end
	end
	return false
end
function api:GetOption(option, ringName)
	assert(type(option) == "string" and (ringName == nil or type(ringName) == "string"), 'Syntax: value, setting, ring, global, default = api:GetOption("option"[, "ringName"])', 2)
	if defaultConfig[option] == nil then return end
	return OR_GetRingOption(ringName, option)
end
function api:SetOption(option, value, ringName)
	assert(type(option) == "string" and (ringName == nil or type(ringName) == "string"), 'Syntax: api:SetOption("option", value[, "ringName"])', 2)
	assert(defaultConfig[option] ~= nil, "Option %q is undefined.", 2, option)
	assert(ringName == nil or OR_Rings[ringName], "Ring %q is undefined.", 2, ringName)
	assert(value == nil or type(defaultConfig[option]) == type(value), "Type mismatch: %q expected to be a %s (got %s).", 2, option, type(defaultConfig[option]), type(value))
	assert(not optionValidators[option] or optionValidators[option](option, value, ringName) ~= false, "Value rejected by option validator.", 2)
	local scope, prefix = ringName and configInstance.RingOptions or configInstance, ringName and (ringName .. "#") or ""
	scope[prefix .. option] = value
	if optionValidators[option] == nil then
		OR_ForceResync(ringName)
	end
end
function api:SetRingBinding(ringName, bind)
	assert(type(ringName) == "string" and (type(bind) == "string" or bind == false or bind == nil), 'Syntax: api:SetRingBinding("ringName", "binding" or false or nil)', 2);
	assert(OR_Rings[ringName], "Ring %q is not defined", 2, ringName);
	if bind == configInstance.Bindings[ringName] then return; end
	local obind = api:GetRingBinding(ringName)
	configInstance.Bindings[ringName] = bind
	for i=1,#OR_Rings do
		local ikey, cbind, _, over = OR_Rings[i], api:GetRingBinding(OR_Rings[i]);
		if ikey ~= ringName and (cbind == bind or cbind == obind) then
			if over and cbind == bind and cbind then
				configInstance.Bindings[ikey] = nil
			end
			OR_SyncRing(ikey)
		end
	end
	OR_SyncRing(ringName)
end
function api:GetRingBinding(ringName)
	assert(type(ringName) == "string", 'Syntax: binding, currentKey, isUserBinding, isActiveInternal, isActiveExternal = api:GetRingBinding("ringName")', 2)
	assert(OR_Rings[ringName], 'Ring %q is not defined', 2, ringName)
	local binding, isUser, iid = configInstance.Bindings[ringName], true, OR_Rings[ringName].internalID
	if binding == nil then binding, isUser = OR_Rings[ringName].hotkey, false end
	local secRingData = OR_SecEnv.ORL_RingData[iid]
	local curKey = secRingData and secRingData.bind
	local curAct = curKey and GetBindingAction(curKey, 1)
	curAct = (curKey == nil) or (curAct == ("CLICK ORL_RProxy" .. iid .. ":r" .. iid)) or curAct
	return binding, curKey, isUser, curKey ~= nil, curAct
end
function api:OverrideRingBinding(ringName, bind)
	assert(type(ringName) == "string" and (bind == nil or type(bind) == "string"), 'Syntax: api:OverrideRingBinding("ringName", "binding")', 2)
	assert(OR_Rings[ringName], 'Ring %q is not defined', 2, ringName)
	if OR_SecEnv.bindOverrides[OR_Rings[ringName].internalID] ~= bind then
		OR_SecCore:Execute(("owner:Run(ORL_RegisterOverride, %d, %s)"):format(OR_Rings[ringName].internalID, bind and safequote(bind) or "nil"))
	end
end
function api:ResetOptions(includePerRing)
	assert(type(includePerRing) == "boolean" or includePerRing == nil, "Syntax: api:ResetOptions([includePerRing])", 2);
	for k in pairs(defaultConfig) do
		configInstance[k] = nil;
	end
	if includePerRing then
		configInstance.RingOptions = {};
	end
	OR_ForceResync();
end
function api:ResetRingBindings()
	wipe(configInstance.Bindings)
	OR_ForceResync()
end
function api:SwitchProfile(ident, inherit)
	assert(type(ident) == "string" and (inherit == nil or type(inherit) == "boolean" or type(inherit) == "table"), 'Syntax: api:SwitchProfile("profile"[, deriveFromCurrent or profileData])', 2);
	if type(inherit) == "table" then
		local data = copy(inherit)
		if data._usedBy then
			for _, charid in pairs(data._usedBy) do
				configRoot.CharProfiles[charid] = ident
			end
			data._usedBy = nil
		end
		configRoot.ProfileStorage[ident] = data
	elseif not configRoot.ProfileStorage[ident] then
		configRoot.ProfileStorage[ident] = inherit and copy(configInstance) or {}
	end
	OR_SwitchProfile(ident)
	configRoot.CharProfiles[getSpecCharIdent()] = activeProfile
end
function api:DeleteProfile(ident)
	assert(type(ident) == "string", 'Syntax: api:DeleteProfile("profile")', 2);
	local oldP = assert(configRoot.ProfileStorage[ident], "Profile %q does not exist.", 2, ident);
	if configRoot.CharProfiles then
		for k,v in pairs(configRoot.CharProfiles) do
			if v == ident then configRoot.CharProfiles[k] = nil; end
		end
	end
	configRoot.ProfileStorage[ident] = nil;
	if configInstance == oldP then self:SwitchProfile("default"); end
end
function api:GetCurrentProfile()
	return activeProfile;
end
function api:ExportProfile(ident)
	assert(type(ident) == "string" or ident == nil, 'Syntax: profileData = api:ExportProfile(["profile"])', 2)
	assert(ident == nil or configRoot.ProfileStorage[ident], 'Profile %q does not exist.', 2, ident)
	if ident == nil then OR_SaveCurrentProfile() end
	local data = copy(ident == nil and configInstance or configRoot.ProfileStorage[ident])
	if configRoot.CharProfiles then
		local id, ni, usedBy = ident or activeProfile, 1, {}
		for k,v in pairs(configRoot.CharProfiles) do
			if v == id then
				usedBy[ni], ni = k, ni + 1
			end
		end
		data._usedBy = ni > 1 and usedBy or nil
	end
	return data
end
function api:Profiles(prev)
	if not configInstance then return; end
	local ident, data = next(configRoot.ProfileStorage, prev);
	return ident, data == configInstance;
end
function api:ProfileExists(ident)
	return configRoot.ProfileStorage[ident] ~= nil;
end
function api:GetOpenRing(optTable)
	if type(optTable) == "table" then
		for k in pairs(defaultConfig) do
			optTable[k] = OR_GetRingOption(OR_ActiveRingName or "default", k);
		end
	end
	return OR_ActiveRingName, OR_ActiveSliceCount, OR_SecEnv.activeRing and OR_SecEnv.activeRing.ofsRad or 0
end
function api:GetOpenRingSlice(id)
	if type(id) ~= "number" or id < 1 or id > OR_ActiveSliceCount then return false end
	local sbt, act, tok = OR_SecEnv.activeRing.SliceBinding, OR_FindFinalAction(OR_ActiveCollectionID, id)
	local nt = OR_SecEnv.collections[OR_SecEnv.collections[OR_ActiveCollectionID][id]]
	return act, tok, sbt and sbt[id], nt and #nt or 0;
end
function api:GetOpenRingSliceAction(id, id2)
	if id < 1 or id > OR_ActiveSliceCount then return end
	local s, tok = OR_FindFinalAction(OR_ActiveCollectionID, id, OR_SecEnv.ctokens[OR_ActiveCollectionID][id], (id2 or 1)-1)
	if type(s) == "number" then
		return tok, AB:GetSlotInfo(s, OR_ModifierLockState)
	end
	return tok, false, 0, [[Interface\Icons\INV_Misc_QuestionMark]], "Unknown Slice", 0, 0, 0
end
function api:RegisterOption(name, default, validator)
	assert(type(name) == "string" and default ~= nil and (validator == nil or type(validator) == "function"), 'Syntax: api:RegisterOption("name", defaultValue[, validatorFunc])', 2);
	assert(defaultConfig[name] == nil and PersistentStorageInfo[name] == nil, "Option %q has a conflicting name", 2, name);
	defaultConfig[name], optionValidators[name] = default, validator or false;
end
function api:RegisterPVar(name, into, notifier, perProfile)
	assert(type(name) == "string" and (into == nil or type(into) == "table") and (notifier == nil or type(notifier) == "function"), 'Syntax: api:RegisterPVar("name"[, storageTable[, notifierFunc[, perProfile]]])', 2);
	assert(PersistentStorageInfo[name] == nil and defaultConfig[name] == nil, "Persistent variable %q already declared.", 2, name);
	assert(name:match("^%a"), "%q is not a valid persistent variable name", 2, name);
	local store, into = ((perProfile == true) and configInstance or configRoot.PersistentStorage), into or {};
	PersistentStorageInfo[name] = {t=into, f=notifier, perProfile=perProfile == true};
	if configInstance then
		if store and store[name] then copy(store[name], into) end
		OR_NotifyPVars("LOADED", into);
	end
	return into;
end
function api:GetVersion()
	return GetAddOnMetadata(ADDON, "Version") or "?", versionMajor, versionRev
end
function api:GetSVState()
	return OR_LoadedState
end

_G.OneRingLib, EV.UPDATE_BINDINGS = api, OR_CheckBindings