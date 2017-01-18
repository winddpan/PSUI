-- Addon & Module System
-- Author      : kurapica.igas@gmail.com
-- Create Date : 2011/02/26
-- ChangeLog   :
--               2011/03/16	Modify the enable-disable system.
--               2011/06/12	Allow access Base namespaces without imports them.
--               2011/06/27	GetModules method added for addon & module
--               2011/08/03 Hook System added.
--               2011/10/29 OnHook Script added.
--               2011/10/31 New SlashCmd System for addon & module.
--               2013/08/05 Remove the version check, seal the definition environment
--               2014/07/03	Recode with System.Task
--               2014/08/13 OnQuit event added for PLAYER_LOGOUT

------------------------------------------------------
-- Addon system definition environment
------------------------------------------------------
Module "System.Addon" "1.18.0"

namespace "System"

------------------------------------------------------
-- Global Definition
------------------------------------------------------
_MetaWK = {__mode = "k"}

_Logined = false

_Addon = {}

_Addon_Loaded = setmetatable({}, _MetaWK)
_Addon_Disabled = setmetatable({}, _MetaWK)
_Addon_DefaultState = setmetatable({}, _MetaWK)
_Addon_SavedVariables = setmetatable({}, _MetaWK)
_Addon_NoAutoWrapper = setmetatable({}, _MetaWK)
_Addon_MetaData = setmetatable({}, _MetaWK)

geterrorhandler = geterrorhandler or function()
	return print
end

errorhandler = errorhandler or function(err)
	return geterrorhandler()(err)
end

------------------------------------------------------
-- _EventManager
--
-- _EventManager:Register(event, obj)
-- _EventManager:IsRegistered(event, obj)
-- _EventManager:Unregister(event, obj)
-- _EventManager:UnregisterAll(obj)
------------------------------------------------------
do
	_EventManager = CreateFrame("Frame")
	_EventDistribution = {}

	_UsedEvent = {}

	-- Register
	function _EventManager:Register(event, obj)
		if type(event) == "string" and event ~= "" then
			self:RegisterEvent(event)

			if self:IsEventRegistered(event) then
				_EventDistribution[event] = _EventDistribution[event] or setmetatable({}, _MetaWK)

				_EventDistribution[event][obj] = true
			else
				error("Usage : IFModule:RegisterEvent(event) : 'event' - not existed.", 3)
			end
		end
	end

	-- IsRegistered
	function _EventManager:IsRegistered(event, obj)
		if _EventDistribution[event] then
			return _EventDistribution[event][obj] or false
		end
	end

	-- Unregister
	function _EventManager:Unregister(event, obj)
		if type(event) == "string" and event ~= "" then
			if _EventDistribution[event] then
				_EventDistribution[event][obj] = nil

				if not next(_EventDistribution[event]) and not _UsedEvent[event] then
					self:UnregisterEvent(event)
				end
			end
		end
	end

	-- UnregisterAll
	function _EventManager:UnregisterAll(obj)
		for event, data in pairs(_EventDistribution) do
			if data[obj] then
				data[obj] = nil

				if not next(data) and not _UsedEvent[event] then
					self:UnregisterEvent(event)
				end
			end
		end
	end

	--  Special Settings for _EventManager
	do
		local fireEvent = Object.Fire

		function _EventManager:OnEvent(event, ...)
			local chk, ret

			if type(self[event]) == "function" then
				chk, ret = pcall(self[event], self, ...)
				if not chk then
					errorhandler(ret)
				end
			end

			if _EventDistribution[event] then
				for obj in pairs(_EventDistribution[event]) do
					if not _Addon_Disabled[obj] then
						fireEvent(obj, "OnEvent", event, ...)
					end
				end
			end
		end

		-- Loading
		local function loading(self)
			fireEvent(self, "OnLoad")

			for _, mdl in self:GetModules() do
				loading(mdl)
			end
		end

		-- Enabling
		local function enabling(self)
			if not _Addon_Disabled[self] then
				fireEvent(self, "OnEnable")

				for _, mdl in self:GetModules() do
					enabling(mdl)
				end
			end
		end

		-- Quit
		local function quit(self)
			fireEvent(self, "OnQuit")

			for _, mdl in self:GetModules() do
				quit(mdl)
			end
		end

		function _EventManager:ADDON_LOADED(addonName)
			local addon = _Addon[addonName]

			if addon and _Addon_SavedVariables[addon] then
				-- relocate savedvariables
				for svn in pairs(_Addon_SavedVariables[addon]) do
					_G[svn] = _G[svn] or {}
					addon[svn] = _G[svn]
				end

				_Addon_SavedVariables[addon] = nil
			end

			if addon and not _Addon_Loaded[addon] then
				_Addon_Loaded[addon] = true

				-- Fire OnLoad, addon no need register ADDON_LOADED self.
				loading(addon)

				if _M._Logined then
					-- enable addon if player was already in game.
					enabling(addon)
				end
			end
		end

		function _EventManager:PLAYER_LOGIN()
			for _, addon in pairs(_Addon) do
				if _Addon_SavedVariables[addon] then
					-- relocate savedvariables
					for svn in pairs(_Addon_SavedVariables[addon]) do
						_G[svn] = _G[svn] or {}
						addon[svn] = _G[svn]
					end

					_Addon_SavedVariables[addon] = nil
				end

				if not _Addon_Loaded[addon] then
					_Addon_Loaded[addon] = true
					loading(addon)
				end

				-- Enabling addons
				enabling(addon)
			end

			_M._Logined = true
		end

		function _EventManager:PLAYER_LOGOUT()
			for _, addon in pairs(_Addon) do
				-- quit addons
				quit(addon)
			end
		end

		_UsedEvent.ADDON_LOADED = true
		_UsedEvent.PLAYER_LOGIN = true
		_UsedEvent.PLAYER_LOGOUT = true

		_EventManager:Hide()
		_EventManager:UnregisterAllEvents()
		for event, flag in pairs(_UsedEvent) do
			if flag then
				_EventManager:RegisterEvent(event)
			end
		end

		_EventManager:SetScript("OnEvent", _EventManager.OnEvent)
	end
end

------------------------------------------------------
-- _HookManager
--
-- _HookManager:Hook(obj, target, targetFunc, handler)
-- _HookManager:UnHook(obj, target, targetFunc)
-- _HookManager:UnHookAll(obj)
--
-- _HookManager:SecureHook(obj, target, targetFunc, handler)
-- _HookManager:SecureUnHook(obj, target, targetFunc)
-- _HookManager:SecureUnHookAll(obj)
------------------------------------------------------
do
	_HookManager = {}

	-- Normal Hook API
	_HookDistribution = {}

	function _HookManager:Hook(obj, target, targetFunc, handler)
		if type(target[targetFunc]) == "function" or (_HookDistribution[target] and _HookDistribution[target][targetFunc]) then
			if issecurevariable(target, targetFunc) then
				error(("'%s' is secure method, use SecureHook instead."):format(targetFunc), 3)
			end

			_HookDistribution[target] = _HookDistribution[target] or {}

			local _store = _HookDistribution[target][targetFunc]

			if not _store then
				_HookDistribution[target][targetFunc] = setmetatable({}, _MetaWK)

				local _orig = target[targetFunc]

				_store = _HookDistribution[target][targetFunc]

				_HookDistribution[target][targetFunc][0] = function(...)
					for mdl, func in pairs(_store) do
						if mdl ~= 0 and not _Addon_Disabled[mdl] then
							if func == true then
								Object.Fire(mdl, "OnHook", targetFunc, ...)
							else
								Object.Fire(mdl, "OnHook", func, ...)
							end
						end
					end

					return _orig(...)
				end

				target[targetFunc] = _HookDistribution[target][targetFunc][0]
			end

			_store[obj] = (type(handler) == "function" or type(handler) == "string") and handler or true
		else
			error(("No method named '%s' can be found."):format(targetFunc), 3)
		end
	end

	function _HookManager:UnHook(obj, target, targetFunc)
		if _HookDistribution[target] then
			if type(targetFunc) == "string" then
				if _HookDistribution[target][targetFunc] then
					_HookDistribution[target][targetFunc][obj] = nil
				end
			elseif targetFunc == nil then
				for _, store in pairs(_HookDistribution[target]) do
					store[obj] = nil
				end
			end
		end
	end

	function _HookManager:UnHookAll(obj)
		for _, pool in pairs(_HookDistribution) do
			for _, store in pairs(pool) do
				store[obj] = nil
			end
		end
	end

	-- Secure Hook API
	_SecureHookDistribution = {}

	function _HookManager:SecureHook(obj, target, targetFunc, handler)
		if type(target[targetFunc]) == "function" or (_SecureHookDistribution[target] and _SecureHookDistribution[target][targetFunc]) then
			_SecureHookDistribution[target] = _SecureHookDistribution[target] or {}

			local _store = _SecureHookDistribution[target][targetFunc]

			if not _store then
				_SecureHookDistribution[target][targetFunc] = setmetatable({}, _MetaWK)

				_store = _SecureHookDistribution[target][targetFunc]

				_SecureHookDistribution[target][targetFunc][0] = function(...)
					for mdl, func in pairs(_store) do
						if mdl ~= 0 and not _Addon_Disabled[mdl] then
							if func == true then
								Object.Fire(mdl, "OnHook", targetFunc, ...)
							else
								Object.Fire(mdl, "OnHook", func, ...)
							end
						end
					end
				end

				hooksecurefunc(target, targetFunc, _SecureHookDistribution[target][targetFunc][0])
			end

			_store[obj] = (type(handler) == "function" or type(handler) == "string") and handler or true
		else
			error(("No method named '%s' can be found."):format(targetFunc), 3)
		end
	end

	function _HookManager:SecureUnHook(obj, target, targetFunc)
		if _SecureHookDistribution[target] then
			if type(targetFunc) == "string" then
				if _SecureHookDistribution[target][targetFunc] then
					_SecureHookDistribution[target][targetFunc][obj] = nil
				end
			elseif targetFunc == nil then
				for _, store in pairs(_SecureHookDistribution[target]) do
					store[obj] = nil
				end
			end
		end
	end

	function _HookManager:SecureUnHookAll(obj)
		for _, pool in pairs(_SecureHookDistribution) do
			for _, store in pairs(pool) do
				store[obj] = nil
			end
		end
	end
end

------------------------------------------------------
-- _SlashCmdManager
--
-- _SlashCmdManager:AddSlashCmd(obj, cmd, ...)
------------------------------------------------------
do
	_SlashCmdManager = {}
	_SlashFuncs = {}

	-- SlashCmd Operation
	local function GetSlashCmdArgs(msg, input)
		local option, info

		if msg and type(msg) == "string" and msg ~= "" then
			msg = strtrim(msg)

			if msg:sub(1, 1) == "\"" and msg:find("\"", 2) then
				option, info = msg:match("\"([^\"]+)\"%s*(.*)")
			else
				option, info = msg:match("(%S+)%s*(.*)")
			end

			if option == "" then option = nil end
			if info == "" then info = nil end
		end

		if IGAS.GetWrapper then
			-- Wrapper the inputbox if IGAS GUI lib is loaded.
			input = IGAS:GetWrapper(input)
		end

		return option, info, input
	end

	local function GetSlashCmd(name)
		_SlashFuncs[name] = _SlashFuncs[name] or function(msg, input)
			local mdl = IGAS:GetAddon(name)
			if mdl then
				return Object.Fire(mdl, "OnSlashCmd", GetSlashCmdArgs(msg, input))
			end
		end
		return _SlashFuncs[name]
	end

	------------------------------------
	--- Add slash commands to an addon
	-- @name _SlashCmdManager:AddSlashCmd
	-- @class function
	-- <param name="module">addon or module</param>
	-- <param name="slash1">the slash commands, a string started with "/", if not started with "/", will auto add it.</param>
	-- <param name="slash2,">... Optional,other slash commands</param>
	-- @return nil
	-- @usage _SlashCmdManager:AddSlashCmd(_Addon, "/hw", hw2")
	------------------------------------
	function _SlashCmdManager:AddSlashCmd(obj, ...)
		if not (obj:IsClass(Addon.Module) or obj:IsClass(Addon)) then
			return
		end

		if select('#', ...) == 0 then
			return nil
		end

		local AddName = obj._Name

		while obj:IsClass(Addon.Module) do
			obj = obj._Parent

			AddName = obj._Name .. "." .. AddName
		end

		local slash = {}
		local sl
		for i = 1, select('#', ...) do
			sl = select(i, ...)
			if sl and type(sl) == "string" then
				if sl:match("^/%S+") then
					slash[sl:match("^/%S+")] = true
				elseif sl:match("^%S+") then
					slash["/"..sl:match("^%S+")] = true
				end
			end
		end

		if not next(slash) then
			--error("Usage : Addon:AddSlashCmd(slash1 [, slash2, ...]) : no slash commands found.", 3)
			return
		end

		local index = 1

		while _G["SLASH_"..AddName..index] do
			slash[_G["SLASH_"..AddName..index]] = nil
			index = index + 1
		end

		for cmd in pairs(slash) do
			_G["SLASH_"..AddName..index] = cmd
			index = index + 1
		end

		if not _G["SlashCmdList"][AddName] then
			_G["SlashCmdList"][AddName] = GetSlashCmd(AddName)
		end
	end
end

------------------------------------------------------
-- IFModule
------------------------------------------------------
__Doc__[[Common methods for addon objects]]
interface "IFModule"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the addon(module) and it's saved variables is loaded]]
	event "OnLoad"

	__Doc__[[Fired when the addon(module) is enabled]]
	event "OnEnable"

	__Doc__[[Fired when the addon(module) is disabled]]
	event "OnDisable"

	__Doc__[[Fired when the addon(module) is dispoing]]
	event "OnDispose"

	__Doc__[[Fired when the player log out]]
	event "OnQuit"

	__Doc__[[
		<desc>Fired when the addon(module) registered slash commands is called</desc>
		<param name="option">the first word in slash command</param>
		<param name="info">remain string</param>
	]]
	event "OnSlashCmd"

	__Doc__[[
		<desc>Fired when the addon(module) hooked function is called, already has default handler, so no need to handle yourself</desc>
		<param name="function">the hooked function name</param>
		<param name="...">arguments from the hooked function</param>
	]]
	event "OnHook"

	__Doc__[[
		<desc>Run whenever an event fires for which the addon(module) has registered</desc>
		<param name="event">string, the event's name</param>
		<param name="...">the event's parameters</param>
	]]
	event "OnEvent"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
    __Doc__[[
        <desc>Get the class type of the object</desc>
        <return type="class">the object's class</return>
    ]]
    GetClass = Reflector.GetObjectClass

    __Doc__[[
        <desc>Check if the object is an instance of the class</desc>
        <param name="class"></param>
        <return type="boolean">true if the object is an instance of the class</return>
    ]]
    IsClass = Reflector.ObjectIsClass

    __Doc__[[
        <desc>Check if the object is extend from the interface</desc>
        <param name="interface"></param>
        <return type="boolean">true if the object is extend from the interface</return>
    ]]
    IsInterface = Reflector.ObjectIsInterface

	__Doc__[[
		<desc>Fire an object's event, to trigger the object's event handlers</desc>
		<param name="event">the event name</param>
		<param name="...">the event's arguments</param>
	]]
	Fire = Reflector.FireObjectEvent

	__Doc__[[
		<desc>Check if the event type is supported by the object</desc>
		<param name="name">the event's name</param>
		<return type="boolean">true if the object has that event type</return>
	]]
	function HasEvent(self, name)
		if type(name) ~= "string" then
			error(("Usage : object:HasEvent(name) : 'name' - string expected, got %s."):format(type(name)), 2)
		end
		return Reflector.HasEvent(Reflector.GetObjectClass(self), name) or false
	end

	__Doc__[[
		<desc>Block some events for the object</desc>
		<param name="...">the event's name list</param>
	]]
	BlockEvent = Reflector.BlockEvent

	__Doc__[[
		<desc>Check if the event is blocked for the object</desc>
		<param name="event">the event's name</param>
		<return type="boolean">true if th event is blocked</return>
	]]
	IsEventBlocked = Reflector.IsEventBlocked

	__Doc__[[
		<desc>Un-Block some events for the object</desc>
		<param name="...">the event's name list</param>
	]]
	UnBlockEvent = Reflector.UnBlockEvent

	ThreadCall = function(self, method, ...)
	    if type(method) == "string" then method = self[method] end
	    if type(method) == "function" then return Threading.ThreadCall(method, self, ...) end
	end

	if _EventManager then
		__Doc__[[
			<desc>Register an event</desc>
			<param name="event">string, the event's name</param>
		]]
		function RegisterEvent(self, event)
			if type(event) == "string" and event ~= "" then
				return _EventManager:Register(event, self)
			else
				error(("Usage : IFModule:RegisterEvent(event) : 'event' - string expected, got %s."):format(type(event) == "string" and "empty string" or type(event)), 2)
			end
		end

		__Doc__[[
			<desc>Check if the addon(module) registered an event</desc>
			<param name="event">string, the event's name</param>
			<return type="boolean">true if the event is registered</return>
		]]
		function IsEventRegistered(self, event)
			if type(event) == "string" and event ~= "" then
				return _EventManager:IsRegistered(event, self)
			else
				error(("Usage : IFModule:IsEventRegistered(event) : 'event' - string expected, got %s."):format(type(event) == "string" and "empty string" or type(event)), 2)
			end
		end

		__Doc__[[Un-register all events for the addon(module)]]
		function UnregisterAllEvents(self)
			return _EventManager:UnregisterAll(self)
		end

		__Doc__[[
			<desc>Un-register an event for the addon(module)</desc>
			<param name="event">string, the event's name</param>
		]]
		function UnregisterEvent(self, event)
			if type(event) == "string" and event ~= "" then
				return _EventManager:Unregister(event, self)
			else
				error(("Usage : IFModule:UnregisterEvent(event) : 'event' - string expected, got %s."):format(type(event) == "string" and "empty string" or type(event)), 2)
			end
		end
	end

	if _SlashCmdManager then
		__Doc__[[
			<desc>Add some slash commands to the addon(module)</desc>
			<param name="...">the slash command list</param>
		]]
		function AddSlashCmd(self, ...)
			return _SlashCmdManager:AddSlashCmd(self, ...)
		end
	end

	if _HookManager then
		__Doc__[[
			<desc>Hook a table's function</desc>
			<format>[target, ]targetFunction[, handler]</format>
			<param name="target">table, default _G</param>
			<param name="targetFunction">string, the hook function name</param>
			<param name="handler">string|function the hook handler</param>
		]]
		function Hook(self, target, targetFunc, handler)
			if type(target) ~= "table" then
				target, targetFunc, handler = _G, target, targetFunc
			end

			if type(target) ~= "table" then
				error("Usage: IFModule:Hook([taget,] targetFunc[, handler]) - 'target' must be a table.", 2)
			end

			if type(targetFunc) ~= "string" then
				error("Usage: IFModule:Hook([taget,] targetFunc[, handler]) - 'targetFunc' must be the name of the method.", 2)
			end

			_HookManager:Hook(self, target, targetFunc, handler)
		end

		__Doc__[[
			<desc>Un-hook a table's function</desc>
			<format>[target, ]targetFunction</format>
			<param name="target">table, default _G</param>
			<param name="targetFunction">taget function name</param>
		]]
		function UnHook(self, target, targetFunc)
			if type(target) ~= "table" then
				target, targetFunc = _G, target
			end

			if type(target) ~= "table" then
				error("Usage: IFModule:UnHook([taget,] targetFunc) - 'target' must be a table.", 2)
			end

			if type(targetFunc) ~= "string" then
				error("Usage: IFModule:UnHook([taget,] targetFunc) - 'targetFunc' must be the name of the method.", 2)
			end

			_HookManager:UnHook(self, target, targetFunc)
		end

		__Doc__[[Un-hook all functions]]
		function UnHookAll(self)
			_HookManager:UnHookAll(self)
		end

		__Doc__[[
			<desc>Secure hook a table's function</desc>
			<format>[target, ]targetFunction[, handler]</format>
			<param name="target">table, default _G</param>
			<param name="targetFunction">string the function's name</param>
			<param name="handler">string|function, the hook handler</param>
		]]
		function SecureHook(self, target, targetFunc, handler)
			if type(target) ~= "table" then
				target, targetFunc, handler = _G, target, targetFunc
			end

			if type(target) ~= "table" then
				error("Usage: IFModule:SecureHook([taget,] targetFunc[, handler]) - 'target' must be a table.", 2)
			end

			if type(targetFunc) ~= "string" then
				error("Usage: IFModule:SecureHook([taget,] targetFunc[, handler]) - 'targetFunc' must be the name of the method.", 2)
			end

			_HookManager:SecureHook(self, target, targetFunc, handler)
		end

		__Doc__[[
			<desc>Un-hook a table's function</desc>
			<format>[target, ]targetFunction</format>
			<param name="target">table, default _G</param>
			<param name="targetFunction">string, the hooked function's name</param>
		]]
		function SecureUnHook(self, target, targetFunc)
			if type(target) ~= "table" then
				target, targetFunc = _G, target
			end

			if type(target) ~= "table" then
				error("Usage: IFModule:SecureUnHook([taget,] targetFunc) - 'target' must be a table.", 2)
			end

			if type(targetFunc) ~= "string" then
				error("Usage: IFModule:SecureUnHook([taget,] targetFunc) - 'targetFunc' must be the name of the method.", 2)
			end

			_HookManager:SecureUnHook(self, target, targetFunc)
		end

		__Doc__[[Un-hook all functions]]
		function SecureUnHookAll(self)
			_HookManager:SecureUnHookAll(self)
		end
	end

	__Doc__[[Enable the addon(module)]]
	function Enable(self)
		if _Addon_Disabled[self] then
			if self._Parent and _Addon_Disabled[self._Parent] then
				error("The module's parent module(addon) is disabled, can't enable it.", 2)
			end

			_Addon_Disabled[self] = nil
			_Addon_DefaultState[self] = nil

			if _M._Logined then Object.Fire(self, "OnEnable") end

			for _, mdl in self:GetModules() do
				if _Addon_DefaultState[mdl] ~= false then
					Enable(mdl)
				end
			end
		end
	end

	__Doc__[[Disable the addon(module)]]
	function Disable(self)
		if not _Addon_Disabled[self] then
			_Addon_Disabled[self] = true

			if _M._Logined then Object.Fire(self, "OnDisable") end

			for _, mdl in self:GetModules() do
				_Addon_DefaultState[mdl] = not _Addon_Disabled[mdl]

				if not _Addon_Disabled[mdl] then
					Disable(mdl)
				end
			end
		else
			_Addon_DefaultState[self] = false
		end
	end

	__Doc__[[
		<desc>Active thread mode for special events.</desc>
		<param name="...">the event name list</param>
	]]
	function ActiveThread(self, ...)
		for i = 1, select('#', ...) do
			local name = select(i, ...)

			if self:HasEvent(name) then self[name].Delegate = System.Threading.ThreadCall end
		end
	end

	__Doc__[[
		<desc>Check if the addon(module) is enabled</desc>
		<return type="boolean">true if the addon(module) is enabled</return>
	]]
	function IsEnabled(self)
		return not _Addon_Disabled[self]
	end

	__Doc__[[
		<desc>Create or get a child-module of the the addon(module), and the environment will be changed to the child-module</desc>
		<format>name[, version]</format>
		<param name="name">string, the child-module's name, like 'SubMdl1.SubSubMdl1', useing dot to concat</param>
		<param name="version">number, used for version control, if there is an existed module with equal or big version number, no module would return</param>
		<return type="System.Addon.Module">the child-module</return>
	]]
	function NewModule(self, name, version)
		if type(name) ~= "string" or strtrim(name) == "" then
			error(("Usage : Module:NewModule(name[, version]) : 'name' - string expected, got %s."):format(type(name) == "string" and "empty string" or type(name)), 2)
		elseif not name:match("^[%w]+[_%w%.]+$") then
			error("Usage : Module:NewModule(name[, version]) : 'name' - the name format must be like 'xxx.xxx.xxx'.", 2)
		end

		if version then
			if type(version) ~= "number" then
				error(("Usage : Module:NewModule(name, [version]) : 'version' - number expected, got %s."):format(type(version)), 2)
			elseif version < 1 then
				error("Usage : Module:NewModule(name, [version]) : 'version' - must be greater than 0.", 2)
			end
		end

		local mdl = self

		for sub in name:gmatch("[_%w]+") do
			mdl = Addon.Module(sub, mdl)
		end

		if mdl then
			-- Validate the version
			if version and not mdl:ValidateVersion(version) then
				return false
			end

			-- the module should modify the environment itself
			mdl(version, 2)

			return mdl
		end

		return false
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether the addon(module) is enabled]]
	property "_Enabled" {
		Get = function(self)
			return IsEnabled(self)
		end,
		Set = function(self, enabled)
			if enabled then
				Enable(self)
			else
				Disable(self)
			end
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnEvent(self, event, ...)
		if type(self[event]) == "function" then
			return self[event](self, ...)
		end
	end

	local function OnHook(self, func, ...)
		if type(func) == "function" then
			return func(...)
		elseif type(self[func]) == "function" then
			return self[func](...)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self:UnregisterAllEvents()
		self:UnHookAll()
		self:SecureUnHookAll()
	end

	------------------------------------------------------
	-- Initialize
	------------------------------------------------------
	function IFModule(self)
		self.OnEvent = self.OnEvent + OnEvent
		self.OnHook = self.OnHook + OnHook
	end
endinterface "IFModule"

------------------------------------------------------
-- Addon
------------------------------------------------------
__Doc__[[Addon object is used as a project's container and manager.]]
class "Addon"
	inherit "System.Module"
	extend "IFModule"

	------------------------------------------------------
	-- Module
	------------------------------------------------------
	__Doc__[[Module object is used as a project's module's container and manager.]]
	class "Module"
		inherit "System.Module"
		extend "IFModule"


		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function Module(self, name, parent)
			Super(self, name, parent)

			_Addon_DefaultState[self] = true
			_Addon_Disabled[self] = _Addon_Disabled[parent]
		end
	endclass "Module"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Add SaveVariables to the addon</desc>
		<param name="name">string, the savedvariables's name</param>
		<return type="table">the savedvariables's container table, no need receive it, automatically install into the Addon with the name</return>
	]]
	function AddSavedVariable(self, name)
		if type(name) ~= "string" or strtrim(name) == "" then
			error(("Usage : Addon:AddSavedVariable(name) : 'name' - string expected, got %s."):format(type(name) == "string" and "empty string" or type(name)), 2)
		end

		name = strtrim(name)
		if not _M._Logined then
			_Addon_SavedVariables[self] = _Addon_SavedVariables[self] or {}

			_Addon_SavedVariables[self][name] = true
		end

		_G[name] = _G[name] or {}
		self[name] = _G[name]

		return self[name]
	end

	__Doc__[[
		<desc>Get the addon's information by the given name</desc>
		<param name="field">string, the information's name</param>
		<return type="string">information like 'Author'</return>
	]]
	function GetMetadata(self, field)
		if type(field) ~= "string" or strtrim(field) == "" then
			error(("Usage : Addon:GetMetadata(field) : 'field' - string expected, got %s."):format(type(field) == "string" and "empty string" or type(field)), 2)
		end

		return self._Metadata[field]
	end

	__Doc__[[
		<desc>Set the addon's information</desc>
		<param name="field">string, the information's name</param>
		<param name="value">any, the information's value</param>
	]]
	function SetMetadata(self, field, value)
		if type(field) ~= "string" or strtrim(field) == "" then
			error(("Usage : Addon:SetMetadata(field, value) : 'field' - string expected, got %s."):format(type(field) == "string" and "empty string" or type(field)), 2)
		end

		self._Metadata[field] = value
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the addon's self]]
	property "_Addon" {
		Get = function(self)
			return self
		end,
	}

	__Doc__[[Auto wrapper blizzard's ui element to IGAS object when needed, default true]]
	property "_AutoWrapper" {
		Get = function(self)
			return not _Addon_NoAutoWrapper[self]
		end,
		Set = function(self, auto)
			_Addon_NoAutoWrapper[self] = not auto
		end,
		Type = Boolean,
	}

	__Doc__[[a table to access the addon's informations]]
	property "_Metadata" {
		Get = function(self)
			_Addon_MetaData[self] = _Addon_MetaData[self] or setmetatable({}, {
				__index = function(meta, key)
					local value = GetAddOnMetadata and GetAddOnMetadata(self._Name, key)

					if value ~= nil then
						rawset(meta, key, value)
					end

					return rawget(meta, key)
				end,
				__newindex = function(meta, key, value)
					if type(key) == "string" and strtrim(key) ~= "" then
						rawset(meta, strtrim(key), value)
					end
				end,
			})

			return _Addon_MetaData[self]
		end,
	}

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_Addon[self._Name] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Addon(self, name)
		Super(self, name)

		_Addon[name] = self
	end

	------------------------------------------------------
	-- __index for class instance
	------------------------------------------------------
	local oIndex = Super.__index

	function __index(self, key)
		local value = oIndex(self, key)

		if not _Addon_NoAutoWrapper[self] then
			if type(value) == "table" and type(value[0]) == "userdata" and rawget(self, key) == value then
				value = IGAS:GetWrapper(value)
				rawset(self, key, value)
			end
		end

		return value
	end
endclass "Addon"

------------------------------------------------------
-- Global Settings
------------------------------------------------------
do
	------------------------------------
	--- Create or Get an addon by name, then change the environment to the addon if not set setEnv to false
	-- @name IGAS:NewAddon
	-- @class function
	-- @param addonName	the addon's name, must be unique, also can be a serie tokens seperate by ".",the first token is addon' name, the second token will be a child-module to the addon, the third token will create the child-module to the second, and go on.
	-- <param name="version">Optional,used for version control, if there is another version, and the old version is equal or great than this one, return nil, else return the child-module</param>
	-- <param name="info">Optional,Optional,must be a table, contains informations such as "author", "version" .etc</param>
	-- <return type="addon">that a table contains the addon's scope, no need to receive it if you don't set setEnv to false, after call this function, you can using "_Addon" to access the addon</return>
	-- @usage local addon = IGAS:NewAddon("HelloWorld", 1, {Author="Kurapica", Version="1.0", Note="Hello World Example", Interface="30010", Title="Hello World"})
	-- @usage IGAS:NewAddon("HelloWorld")
	------------------------------------
	function IGAS:NewAddon(name, version, info)
		if type(name) ~= "string" or strtrim(name) == "" then
			error(("Usage : IGAS:NewAddon(name[, version]) : 'name' - string expected, got %s."):format(type(name) == "string" and "empty string" or type(name)), 2)
		elseif not name:match("^[%w]+[_%w%.]+$") then
			error("Usage : IGAS:NewAddon(name[, version]) : 'name' - the name format must be like 'xxx.xxx.xxx'.", 2)
		end

		if version then
			if type(version) ~= "number" then
				error(("Usage : IGAS:NewAddon(name, [version]) : 'version' - number expected, got %s."):format(type(version)), 2)
			elseif version < 1 then
				error("Usage : IGAS:NewAddon(name, [version]) : 'version' - must be greater than 0.", 2)
			end
		end

		local mdl
		local addon

		for sub in name:gmatch("[_%w]+") do
			if not mdl then
				mdl = Addon(sub)
				addon = mdl
			else
				mdl = Addon.Module(sub, mdl)
			end
		end

		if mdl then
			-- MetaData
			if type(info) == "table" and next(info) then
				for field, v in pairs(info) do
					if type(field) == "string" and strtrim(field) ~= "" then
						addon._Metadata[field] = v
					end
				end
			end

			-- Validate the version
			if version and not mdl:ValidateVersion(version) then
				return false
			end

			-- the module should modify the environment itself
			mdl(version, 3)

			return mdl
		end

		return false
	end

	------------------------------------
	--- Get an addon by name
	-- @name IGAS:GetAddon
	-- @class function
	-- @param addonName	the addon's name, must be unique, also can be a serie tokens seperate by ".",the first token is addon' name, the second token will be a child-module to the addon, the third token will create the child-module to the second, and go on.
	-- <return type="addon">that a table contains the addon's scope, no need to receive it if you don't set setEnv to false, after call this function, you can using "_Addon" to access the addon</return>
	-- @usage local addon = IGAS:GetAddon("HelloWorld")
	-- @usage IGAS:GetAddon("HelloWorld")
	------------------------------------
	function IGAS:GetAddon(name)
		if type(name) ~= "string" or strtrim(name) == "" then
			error(("Usage : IGAS:GetAddon(name) : 'name' - string expected, got %s."):format(type(name) == "string" and "empty string" or type(name)), 2)
		end

		local mdl = _Addon

		for sub in name:gmatch("[_%w]+") do
			if mdl == _Addon then
				mdl = _Addon[sub]
			else
				mdl = mdl:GetModule(sub)
			end

			if not mdl then return end
		end

		if not mdl or mdl == _Addon then return end

		return mdl
	end

	------------------------------------
	--- Get a list of the existed addons' name
	-- @name IGAS:GetAddonList
	-- @class function
	-- <return type="list">a table contains all the existed addons' name</return>
	-- @usage IGAS:GetAddonList()
	------------------------------------
	function IGAS:GetAddonList()
		local lst = {}

		for name in pairs(_Addon) do
			tinsert(lst, name)
		end

		return lst
	end
end
