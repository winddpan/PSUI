-- Author      : Kurapica
-- Create Date : 2012/07/03
-- Change Log  :

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.Unit.IFSpellHandler", version) then
	return
end

------------------------------------------------------
-- Module
--
-- DB :
--		_DBChar
--
-- Function List :
--		GetGroup(group) : True Group name
------------------------------------------------------
do
	_GlobalGroup = "Global"
	_WeakMode = {__mode = "k"}

	function GetGroup(group)
		return tostring(type(group) == "string" and strtrim(group) ~= "" and strtrim(group) or _GlobalGroup):upper()
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	function OnLoad(self)
		-- DB
		IGAS_DB_Char.Unit_IFSpellHandler_DB = IGAS_DB_Char.Unit_IFSpellHandler_DB or {}

		if not IGAS_DB_Char.Unit_IFSpellHandler_DBVer then
			IGAS_DB_Char.Unit_IFSpellHandler_DBVer = 70000
			IGAS_DB_Char.Unit_IFSpellHandler_DB = {}
		end

		_DBChar = IGAS_DB_Char.Unit_IFSpellHandler_DB

		self:RegisterEvent('PLAYER_LOGOUT')
	end

	function OnEnable(self)
		for grp in pairs(_DBChar) do
			Task.NoCombatCall(SetupGroup, grp)
		end
	end

	function PLAYER_LOGOUT(self)
		-- Clear empte settings
		for grp, db in pairs(_DBChar) do
			if not next(db) then
				_DBChar[grp] = nil
			end
		end
	end
end

------------------------------------------------------
-- Action type settings
--
-- _IFSPellHandler_ActionType
--
-- Function List :
--		GetBindingDB(group, type, content)
--		GetBindingDB4Key(group, key, harmful)
--		ClearBindingDB(group, type, content)
--		ClearBindingDB4Key(group, key)
--		SaveBindngDB(group, key, type, content, with, harmful)
--		GetSnippet(group)
------------------------------------------------------
do
	tbl_concat = table.concat

	_Key2Name = setmetatable(
		{
			["1"] = "one",
			["2"] = "two",
			["3"] = "three",
			["4"] = "four",
			["5"] = "five",
			["6"] = "six",
			["7"] = "seven",
			["8"] = "eight",
			["9"] = "nine",
			["0"] = "zero",
			[","] = "comma",
			["."] = "period",
			["/"] = "slash",
			["`"] = "backtick ",
			["["] = "leftbracket",
			["]"] = "rightbracket",
			["\\"] = "backslash",
			["-"] = "minus",
			["="] = "equals",
			[";"] = "semicolon",
			["'"] = "singlequote",
			["ESCAPE"] = false,
			["PRINTSCREEN"] = false,
			["LSHIFT"] = false,
			["RSHIFT"] = false,
			["LCTRL"] = false,
			["LALT"] = false,
			["RALT"] = false,
			["RCTRL"] = false,
			["UNKNOWN"] = false,
		},{
			__index = function (self, key)
				if type(key) == "string" then
					return key:lower()
				end
			end
		}
	)

	function ParseSpell(spell)
		if (type(spell) == "string" or type(spell) == "number") and GetSpellInfo(spell) then
			-- Only keep spell id
			return tonumber(GetSpellLink(spell):match('spell:(%d+)')), IsHarmfulSpell(spell)
		end

		error("Invalid spell name|id - "..tostring(spell), 3)
	end

	function ParseMacro(macro)
		if type(macro) == "string" then
			macro = GetMacroIndexByName(macro)
		end

		if type(macro) == "number" and macro > 0 and GetMacroInfo(macro) then
			return macro
		end

		error("Invalid macro name|index", 3)
	end

	function ParseMacroText(macroText)
		if type(macroText) == "string" and strtrim(macroText) ~= "" then
			return strtrim(macroText)
		end

		error("Invalid macro text", 3)
	end

	function ParseItem(item)
		if (type(item) == "string" or type(item) == "number") and GetItemInfo(item) then
			return tonumber(select(GetItemInfo(item), 2):match('item:(%d+)'))
		end

		error("Invalid item|id|link", 3)
	end

	function ParseBindKey(key)
		local ret

		if type(key) == "string" and strtrim(key) ~= "" then
			key = strtrim(key):upper()

			-- Check the tail key is "-"
			if key:sub(-1) == "-" then
				 ret = "-"
			else
				ret = key:match("[^-]+$")
			end

			if not ret or ret == "" or not _Key2Name[ret] then
				return
			end

			-- Remap mouse key
			if ret == "LEFTBUTTON" then
				ret = "BUTTON1"
			elseif ret == "RIGHTBUTTON" then
				ret = "BUTTON2"
			elseif ret == "MIDDLEBUTTON" then
				ret = "BUTTON3"
			end

			-- Remap option key
			if key:find("SHIFT-") then
				ret = "SHIFT-" .. ret
			end

			if key:find("CTRL-") then
				ret = "CTRL-" .. ret
			end

			if key:find("ALT-") then
				ret = "ALT-" .. ret
			end
		end

		if not ret then
			error("Invalid binding key", 3)
		end

		return ret
	end

	function TransSpell2Macro(spell, with)
		return ("/%s %%unit\n/cast %s"):format(with, GetSpellInfo(spell))
	end

	function TransItem2Macro(item, with)
		return ("/%s %%unit\n/use %s"):format(with, GetItemInfo(item))
	end

	_IFSPellHandler_ActionType = {
		Spell = {type = "spell", parse = ParseSpell, content = "spell", tranMacro=TransSpell2Macro},
		Macro = {type = "macro", parse = ParseMacro, content = "macro"},
		MacroText = {type = "macro", parse = ParseMacroText, content = "macrotext"},
		Item = {type = "item", parse = ParseItem, content = "item", tranMacro=TransItem2Macro},
		Menu = {type =  "menu"},
		Target = {type = "target"},
		Focus = {type = "focus"},
		Assist = {type = "assist"},
	}

	function GetBindingDB(group, type, content)
		if not _DBChar[group] then
			return
		end

		for key, set in pairs(_DBChar[group]) do
			if set["HarmAction"] == type and set["HarmContent"] == content then
				return key, set["HarmWith"], true
			elseif set["HelpAction"] == type and set["HelpContent"] == content then
				return key, set["HelpWith"], false
			end
		end
	end

	function GetBindingDB4Key(group, key, harmful)
		local db = _DBChar[group] and _DBChar[group][key]

		local prev = harmful and "Harm" or "Help"

		if db then
			return db[prev.."Action"], db[prev.."Content"], db[prev.."With"]
		end
	end

	function ClearBindingDB(group, type, content)
		local key, with, harmful = GetBindingDB(group, type, content)

		if key then
			local db = _DBChar[group][key]

			local prev = harmful and "Harm" or "Help"

			db[prev.."Action"] = nil
			db[prev.."Content"] = nil
			db[prev.."With"] = nil

			if not next(db) then
				_DBChar[group][key] = nil
			end

			return true
		end
	end

	function ClearBindingDB4Key(group, key)
		if not _DBChar[group] then
			return false
		end

		if not key then
			wipe(_DBChar[group])
			return true
		end

		if not _DBChar[group][key] then
			return false
		end

		_DBChar[group][key] = nil

		return true
	end

	function SaveBindngDB(group, key, type, content, with, harmful)
		if not key then
			error("No binding key is set.", 3)
		end

		if not type or not _IFSPellHandler_ActionType[type] then
			error("No action type is set.", 3)
		end

		if _IFSPellHandler_ActionType[type].content and not content then
			error("No action content is set.", 3)
		end

		-- one spell in one group only match one key
		ClearBindingDB(group, type, content)

		_DBChar[group] = _DBChar[group] or {}
		_DBChar[group][key] = _DBChar[group][key] or {}

		local db = _DBChar[group][key]

		local prev = harmful and "Harm" or "Help"

		db[prev.."Action"] = type
		db[prev.."Content"] = content
		db[prev.."With"] = with
	end

	function MapKey(key)
		key = key:lower()

		local isClk = false
		local prev

		-- Check tail key
		if key:sub(-1) == "-" then
			prev, key = key:sub(1, -2), key:sub(-1)
		else
			prev, key = key:match("(.-)([^-]+)$")
		end

		if key:match("button%d+") then
			isClk = true
			key = key:match("button(%d+)")
		else
			key = prev:gsub("-", "") .. _Key2Name[key]
			prev = ""
		end

		return isClk, prev, key
	end

	function MapAction(action, content, with)
		local actionSet = _IFSPellHandler_ActionType[action]

		if not actionSet then
			return
		end

		if not with or not actionSet.tranMacro then
			return action, content
		else
			return "MacroText", actionSet.tranMacro(content, with)
		end
	end

	_IFSpellHandler_SetupTemplate = [[self:SetAttribute("%s", %q)]]
	_IFSpellHandler_ClearTemplate = [[self:SetAttribute("%s", nil)]]

	_IFSpellHandler_EnterTemplate = [[self:SetBindingClick(true, "%s", self, "%s")]]
	_IFSpellHandler_LeaveTemplate = [[self:ClearBinding("%s")]]

	function GetSnippet(group)
		if not _DBChar[group] then
			return
		end

		local setup = {}
		local clear = {}
		local enter = {}
		local leave = {}

		local isMouseClk, prev, keyName, virtualKey, useVirtual, connect
		local actionSet, tranType, tranContent

		for key, set in pairs(_DBChar[group]) do
			useVirtual = false

			isMouseClk, prev, keyName = MapKey(key)

			if not isMouseClk then
				tinsert(enter, _IFSpellHandler_EnterTemplate:format(key, keyName))
				tinsert(leave, _IFSpellHandler_LeaveTemplate:format(key))
			end

			connect = isMouseClk and "" or "-"

			if set.HarmAction and set.HelpAction then
				useVirtual = true
			end

			if set.HarmAction then
				if useVirtual then
					virtualKey = "enemy" .. keyName
					tinsert(setup, _IFSpellHandler_SetupTemplate:format("harmbutton" .. connect .. keyName, virtualKey))
					tinsert(clear, _IFSpellHandler_ClearTemplate:format("harmbutton" .. connect .. keyName))

					virtualKey = "-" .. virtualKey
				else
					virtualKey = connect .. keyName
				end

				tranType, tranContent = MapAction(set.HarmAction, set.HarmContent, set.HarmWith)

				actionSet = _IFSPellHandler_ActionType[tranType]

				if actionSet then
					tinsert(setup, _IFSpellHandler_SetupTemplate:format(prev .. "type" .. virtualKey, actionSet.type))
					tinsert(clear, _IFSpellHandler_ClearTemplate:format(prev .. "type" .. virtualKey))

					if actionSet.content then
						tinsert(setup, _IFSpellHandler_SetupTemplate:format(prev .. actionSet.content .. virtualKey, tranContent))
						tinsert(clear, _IFSpellHandler_ClearTemplate:format(prev .. actionSet.content .. virtualKey))
					end
				end
			end

			if set.HelpAction then
				if useVirtual then
					virtualKey = "friend" .. keyName
					tinsert(setup, _IFSpellHandler_SetupTemplate:format("helpbutton" .. connect .. keyName, virtualKey))
					tinsert(clear, _IFSpellHandler_ClearTemplate:format("helpbutton" .. connect .. keyName))

					virtualKey = "-" .. virtualKey
				else
					virtualKey = connect .. keyName
				end

				tranType, tranContent = MapAction(set.HelpAction, set.HelpContent, set.HelpWith)

				actionSet = _IFSPellHandler_ActionType[tranType]

				if actionSet then
					tinsert(setup, _IFSpellHandler_SetupTemplate:format(prev .. "type" .. virtualKey, actionSet.type))
					tinsert(clear, _IFSpellHandler_ClearTemplate:format(prev .. "type" .. virtualKey))

					if actionSet.content then
						tinsert(setup, _IFSpellHandler_SetupTemplate:format(prev .. actionSet.content .. virtualKey, tranContent))
						tinsert(clear, _IFSpellHandler_ClearTemplate:format(prev .. actionSet.content .. virtualKey))
					end
				end
			end
		end
		return tbl_concat(setup, "\n"), tbl_concat(clear, "\n"), tbl_concat(enter, "\n"), tbl_concat(leave, "\n")
	end
end

------------------------------------------------------
-- Secure Frame Management System
--
-- Function List :
--		InitUnitFrame(self)
--		RemoveUnitFrame(self, group)
------------------------------------------------------
do
	-- Manager Frame
	_IFSpellHandler_ManagerFrame = _IFSpellHandler_ManagerFrame or SecureFrame("IGAS_IFSpellHandler_Manager")

	-- Init manger frame's enviroment
	Task.NoCombatCall(
		function ()
			_IFSpellHandler_ManagerFrame:Execute[[
				_HoverOnUnitFrame = nil
				_HoverOnUnitFrameLeaveSnippet = nil

				_GroupMap = newtable()
				_UnitMap = newtable()

				_SetupSnippet = newtable()
				_ClearSnippet = newtable()
				_EnterSnippet = newtable()
				_LeaveSnippet = newtable()
			]]
		end
	)

	-- Global script sinppet, keep all run at global enviroment
	-- Init Snippet
	_IFSpellHandler_InitSnippet = [[
		local group = "%s"
		local initFrame = control:GetFrameRef("InitUnitFrame")

		_GroupMap[initFrame] = group
	]]
	-- Dispose Snippet
	_IFSpellHandler_DisposeSnippet = [[
		local group = "%s"
		local disposeFrame = control:GetFrameRef("DisposeUnitFrame")

		_GroupMap[disposeFrame] = nil

		if _HoverOnUnitFrame == disposeFrame then
			if _HoverOnUnitFrameLeaveSnippet then
				_HoverOnUnitFrame:UnregisterAutoHide()
			end
			_HoverOnUnitFrame = nil
			_HoverOnUnitFrameLeaveSnippet = nil
		end

		if _LeaveSnippet[group] then
			control:RunFor(disposeFrame, _LeaveSnippet[group])
		end

		if _ClearSnippet[group] then
			control:RunFor(disposeFrame, _ClearSnippet[group])
		end
	]]
	-- OnEnter Snippet
	-- Also keep clear & leave snippet for update using
	_IFSpellHandler_OnEnterSnippet = [[
		local group = "%s"
		local unit = self:GetAttribute("unit")

		if _HoverOnUnitFrame and _HoverOnUnitFrameLeaveSnippet and _HoverOnUnitFrame ~= self then
			_HoverOnUnitFrame:UnregisterAutoHide()
			control:RunFor(_HoverOnUnitFrame, _HoverOnUnitFrameLeaveSnippet)
			if _HoverOnUnitFrame:GetAttribute("unit") then
				_HoverOnUnitFrame:Show()
			end
		end

		if _SetupSnippet[group] and _UnitMap[self] ~= unit then
			_UnitMap[self] = unit
			control:RunFor(self, _SetupSnippet[group]:gsub("%%%%unit", unit or ""))
		end

		_HoverOnUnitFrame = self
		_HoverOnUnitFrameLeaveSnippet = _LeaveSnippet[group]

		if _EnterSnippet[group] then
			control:RunFor(self, _EnterSnippet[group])
		end

		if _HoverOnUnitFrameLeaveSnippet then
			_HoverOnUnitFrame:RegisterAutoHide(0.25)
		end
	]]
	-- OnLeave Snippet
	_IFSpellHandler_OnLeaveSnippet = [[
		local group = "%s"

		if _HoverOnUnitFrame == self then
			if _HoverOnUnitFrameLeaveSnippet then
				_HoverOnUnitFrame:UnregisterAutoHide()
				if _HoverOnUnitFrame:GetAttribute("unit") then
					_HoverOnUnitFrame:Show()
				end
			end
			_HoverOnUnitFrame = nil
			_HoverOnUnitFrameLeaveSnippet = nil
		end

		if _LeaveSnippet[group] then
			control:RunFor(self, _LeaveSnippet[group])
		end
	]]
	-- OnHide Snippet
	_IFSpellHandler_OnHideSnippet = [[
		local group = "%s"

		if _HoverOnUnitFrame ~= self then
			return
		end

		if _HoverOnUnitFrameLeaveSnippet then
			self:UnregisterAutoHide()
			if self:GetAttribute("unit") then
				self:Show()
			end
		end

		_HoverOnUnitFrame = nil
		_HoverOnUnitFrameLeaveSnippet = nil

		if _LeaveSnippet[group] then
			control:RunFor(self, _LeaveSnippet[group])
		end
	]]
	-- Build Snippet for group
	_IFSpellHandler_SetupGroupSnippet = [[
		local group = "%s"

		if _HoverOnUnitFrame and _GroupMap[_HoverOnUnitFrame] == group then
			if _HoverOnUnitFrameLeaveSnippet then
				_HoverOnUnitFrame:UnregisterAutoHide()
				control:RunFor(_HoverOnUnitFrame, _HoverOnUnitFrameLeaveSnippet)
			end
			_HoverOnUnitFrame = nil
			_HoverOnUnitFrameLeaveSnippet = nil
		end

		for frm, grp in pairs(_GroupMap) do
			if grp == group then
				_UnitMap[frm] = nil

				if _ClearSnippet[group] then
					control:RunFor(frm, _ClearSnippet[group])
				end
			end
		end

		_SetupSnippet[group] = %q
		_ClearSnippet[group] = %q
		_EnterSnippet[group] = %q
		_LeaveSnippet[group] = %q

		if _SetupSnippet[group] == "" then
			_SetupSnippet[group] = nil
		end

		if _ClearSnippet[group] == "" then
			_ClearSnippet[group] = nil
		end

		if _EnterSnippet[group] == "" then
			_EnterSnippet[group] = nil
		end

		if _LeaveSnippet[group] == "" then
			_LeaveSnippet[group] = nil
		end
	]]

	-- Set up group
	function SetupGroup(group)
		Log(2, "[IFSpellHandler]Setup for group: %s", group or "Global")
		_IFSpellHandler_ManagerFrame:Execute(_IFSpellHandler_SetupGroupSnippet:format(group, GetSnippet(group)))
	end

	-- Initialize unit frame
	function InitUnitFrame(self)
		local group = GetGroup(self.IFSpellHandlerGroup)

		_DBChar[group] = _DBChar[group] or {}

		_IFSpellHandler_ManagerFrame:WrapScript(self, "OnEnter", _IFSpellHandler_OnEnterSnippet:format(group))
		_IFSpellHandler_ManagerFrame:WrapScript(self, "OnLeave", _IFSpellHandler_OnLeaveSnippet:format(group))
		_IFSpellHandler_ManagerFrame:WrapScript(self, "OnHide", _IFSpellHandler_OnHideSnippet:format(group))

		_IFSpellHandler_ManagerFrame:SetFrameRef("InitUnitFrame", self)
		_IFSpellHandler_ManagerFrame:Execute(_IFSpellHandler_InitSnippet:format(group))
	end

	-- Dispose unit frame
	function RemoveUnitFrame(self, group)
		_IFSpellHandler_ManagerFrame:UnwrapScript(self, "OnEnter")
		_IFSpellHandler_ManagerFrame:UnwrapScript(self, "OnLeave")
		_IFSpellHandler_ManagerFrame:UnwrapScript(self, "OnHide")

		_IFSpellHandler_ManagerFrame:SetFrameRef("DisposeUnitFrame", self)
		_IFSpellHandler_ManagerFrame:Execute(_IFSpellHandler_DisposeSnippet:format(group))
	end
end


__Doc__[[
	<desc>IFSpellHandler provides hover and click spell casting for secure unit frames</desc>
	<optional name="IFSpellHandlerGroup" type="property" valuetype="string">used to mark the unit frame object into a group with the same behavior</optional>
	<usage>
		For a group named 'GroupA', it's easy to set or clear binding keys like :

			IFSpellHandler._Group("GroupA").Target.Key = "ctrl-f"
			IFSpellHandler._Group("GroupA").Focus.Key = "ctrl-f"
			IFSpellHandler._Group("GroupA").Assist.Key = "ctrl-f"

			IFSpellHandler._Group("GroupA").Spell("Holy Light").Key = "ctrl-f"
			IFSpellHandler._Group("GroupA").MacroText("/cast Holy Light").Key = "ctrl-f"
			IFSpellHandler._Group("GroupA").Spell("Holy Light").WithTarget.Key = "ctrl-f"
			IFSpellHandler._Group("GroupA").Spell("Holy Light").AsHelpful.WithTarget.Key = "ctrl-f"

			IFSpellHandler._Group("GroupA"):Clear("ctrl-f")
	</usage>
]]
interface "IFSpellHandler"

	__Doc__[[SpellHandlerGroup object is the manager for the binding key settings in a group]]
	class "SpellHandlerGroup"
		inherit "System.Object"

		_IFSpellHandler_SpellHandlerGroup = _IFSpellHandler_SpellHandlerGroup or {}

		enum "ActionType" {
			"Spell",
			"Macro",
			"MacroText",
			"Item",
			"Menu",
			"Target",
			"Focus",
			"Assist",
		}

		enum "ActionWith" {
			"target",
			"focus",
			"assist",
		}

		struct "KeySet"
			HarmAction = ActionType
			HarmContent = StringNumber
			HarmWith = ActionWith
			HelpAction = ActionType
			HelpContent = StringNumber
			HelpWith = ActionWith
		endstruct "KeySet"

		__Doc__[[DataAccessor is a helper class to the SpellHandlerGroup to access the binding settings]]
		class "DataAccessor"

			------------------------------------------------------
			-- Event
			------------------------------------------------------

			------------------------------------------------------
			-- Method
			------------------------------------------------------

			------------------------------------------------------
			-- Property
			------------------------------------------------------
			__Doc__[[The group's name]]
			property "Group" {
				Get = function(self)
					return self.__GroupHandler.Group
				end,
			}

			__Doc__[[The binding setting's type]]
			property "Type" {
				Get = function(self)
					return self.__AccessType
				end,
				Set = function(self, value)
					self.__AccessType = value
					-- Clear all
					self.__AccessKey = nil
					self.__AccessContent = nil
					self.__AccessHarmful = false
					self.__AccessWith = nil
				end,
				Type = String,
			}

			__Doc__[[Mark the setting is for harmful target]]
			property "AsHarmful" {
				Get = function(self)
					self.__AccessHarmful = true
					return self
				end,
			}

			__Doc__[[Mark the setting is for helpful target]]
			property "AsHelpful" {
				Get = function(self)
					self.__AccessHarmful = false
					return self
				end,
			}

			__Doc__[[Mark the setting is combined with 'target' command]]
			property "WithTarget" {
				Get = function(self)
					self.__AccessWith = "target"
					return self
				end,
			}

			__Doc__[[Mark the setting is combined with 'focus' command]]
			property "WithFocus" {
				Get = function(self)
					self.__AccessWith = "focus"
					return self
				end,
			}

			__Doc__[[Mark the setting is combined with 'assist' command]]
			property "WithAssist" {
				Get = function(self)
					self.__AccessWith = "assist"
					return self
				end,
			}

			__Doc__[[Get the with settings for the binding setting]]
			property "With" {
				Get = function(self)
					return select(2, GetBindingDB(self.Group, self.__AccessType, self.__AccessContent))
				end,
			}

			__Doc__[[The binding key for the setting]]
			property "Key" {
				Get = function(self)
					return GetBindingDB(self.Group, self.__AccessType, self.__AccessContent)
				end,
				Set = function(self, value)
					self.__AccessKey = ParseBindKey(value)

					local type, content, with = GetBindingDB4Key(self.Group, self.__AccessKey, self.__AccessHarmful)

					if type then
						if type ~= self.__AccessType or content ~= self.__AccessContent then
							if content then
								Log(3, L"[%s][%s]'s binding key[%s] is removed in group[%s]", type, content, self.__AccessKey, self.Group)
							else
								Log(3, L"[%s]'s binding key[%s] is removed in group[%s]", type, self.__AccessKey, self.Group)
							end
						elseif type == self.__AccessType and content == self.__AccessContent and with == self.__AccessWith then
							return
						end
					end

					SaveBindngDB(self.Group,
						self.__AccessKey,
						self.__AccessType,
						self.__AccessContent,
						self.__AccessWith,
						self.__AccessHarmful)

					self.__GroupHandler:Fire("OnSettingUpdate")
				end,
				Type = String,
			}

			------------------------------------------------------
			-- Constructor
			------------------------------------------------------
		    function DataAccessor(self, groupHandler)
				self.__GroupHandler = groupHandler
		    end

			------------------------------------------------------
			-- Metamethod
			------------------------------------------------------
			function __call(self, key, with, asHarmful)
				local chkHarm

				-- Clear all
				self.__AccessKey = nil
				self.__AccessContent = nil
				self.__AccessHarmful = false
				self.__AccessWith = nil

				if _IFSPellHandler_ActionType[self.Type] then
					if _IFSPellHandler_ActionType[self.Type].parse then
						self.__AccessContent, chkHarm = _IFSPellHandler_ActionType[self.Type].parse(key)

						if chkHarm ~= nil and asHarmful == nil then
							asHarmful = chkHarm
						end
					else
						key, with, asHarmful = nil, nil, key
					end

					if with then
						if type(with) ~= "string" then
							error("Usage: DataAccessor(key[, with[, asHarmful]]) - 'with' must be a string or nil", 2)
						end

						with = with:lower()

						if with ~= "target" and with ~= "focus" and with ~= "assist" then
							error("Usage: DataAccessor(key[, with[, asHarmful]]) - 'with' must be 'target'|'focus'|'assist'", 2)
						end
					end

					self.__AccessWith = with
					self.__AccessHarmful = asHarmful
				else
					error("Invalid data type.", 2)
				end

				return self
			end
		endclass "DataAccessor"

		local function CopyData(src, dest)
			if not src then return end

			dest = dest or {}

			for k, v in pairs(src) do
				if type(v) == "table" then
					dest[k] = CopyData(v)
				else
					dest[k] = v
				end
			end

			return dest
		end

		local function CompareData(src, dest)
			if type(src) == "table" and type(dest) == "table" then
				local keyChk = {}

				-- Check if src & dest has same key
				for k in pairs(src) do
					keyChk[k] = 1
				end

				for k in pairs(dest) do
					keyChk[k] = (keyChk[k] or 0) - 1
				end

				for k, v in pairs(keyChk) do
					if v ~= 0 then
						keyChk = nil
						return false
					end
				end

				keyChk = nil

				-- Check if src & dest has same value
				for k in pairs(src) do
					if src[k] ~= dest[k] then
						if type(src[k]) ~= "table" or
							type(dest[k]) ~= "table" or
							not CompareData(src[k], dest[k]) then
							return false
						end
					end
				end
			else
				return false
			end

			return true
		end

		------------------------------------------------------
		-- Event
		------------------------------------------------------
		__Doc__[[Fired when the settings is updateds]]
		event "OnSettingUpdate"

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		__Doc__[[Clear the settings]]
		__Arguments__{ Argument(String, true) }
		function Clear(self, key)
			if ClearBindingDB4Key(self.Group, key) then
				return self:Fire("OnSettingUpdate")
			end
		end

		__Arguments__{ ActionType, StringNumber }
		function Clear(self, type, content)
			if ClearBindingDB(self.Group, type, content) then
				return self:Fire("OnSettingUpdate")
			end
		end

		__Doc__[[Begin update settings and block script OnSettingUpdate]]
		function BeginUpdate(self)
			self:BlockEvent("OnSettingUpdate")
			self.__BackUp = CopyData(_DBChar[self.Group])
		end

		__Doc__[[Commit the changes and un-block script OnSettingUpdate]]
		function CommitUpdate(self)
			if self.__BackUp then
				self:UnBlockEvent("OnSettingUpdate")

				if not CompareData(_DBChar[self.Group], self.__BackUp) then
					self:Fire("OnSettingUpdate")
				end

				self.__BackUp = nil
			end
		end

		__Doc__[[Cancel the changes and un-block script OnSettingUpdate]]
		function CancelUpdate(self)
			if self.__BackUp then
				_DBChar[self.Group] = self.__BackUp
				self.__BackUp = nil

				self:UnBlockEvent("OnSettingUpdate")
			end
		end

		__Doc__[[
			<desc>Export settings</desc>
			<return type="table">the settings</return>
		]]
		function Export(self)
			return CopyData(_DBChar[self.Group])
		end

		__Doc__[[
			<desc>Import settings</desc>
			<param name="set">table, the key settings</param>
			<return type="boolean">true if success</return>
		]]
		function Import(self, set)
			if type(set) == "table" and next(set) then
				local result = {}

				for key, setting in pairs(set) do
					-- if not right, direct error out
					key = ParseBindKey(key)

					KeySet(setting)

					result[key] = {
						HarmAction = setting.HarmAction,
						HarmContent = setting.HarmContent,
						HarmWith = setting.HarmWith,
						HelpAction = setting.HelpAction,
						HelpContent = setting.HelpContent,
						HelpWith = setting.HelpWith,
					}
				end

				if CompareData(_DBChar[self.Group], result) then
					-- same settings, just return
					return
				end

				_DBChar[self.Group] = CopyData(result)
				self:Fire("OnSettingUpdate")
			else
				self:Clear()
			end
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[The group name]]
		property "Group" {
			Get = function(self)
				return self.__Group
			end,
		}

		-- Generate propeties based on the action types
		for key in pairs(_IFSPellHandler_ActionType) do
			__Doc__ (([[
				<desc>Get the data accessor of the '%s' action type</desc>
			]]):format(key, key))
			property (key) {
				Get = function(self)
					self.__Accessor.Type = key
					return self.__Accessor
				end,
				Type = DataAccessor,
			}
		end

		------------------------------------------------------
		-- Event Handler
		------------------------------------------------------
		local function OnSettingUpdate(self)
			Task.NoCombatCall(SetupGroup, self.Group)
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function SpellHandlerGroup(self, group)
	    	group = GetGroup(group)

			self.__Group = group
			self.__Accessor = DataAccessor(self)

			_IFSpellHandler_SpellHandlerGroup[group] = self
			_DBChar[group] = _DBChar[group] or {}

			self.OnSettingUpdate = self.OnSettingUpdate + OnSettingUpdate
	    end

		------------------------------------------------------
		-- Metamethod
		------------------------------------------------------
		function __exist(group)
	    	group = GetGroup(group)

			return _IFSpellHandler_SpellHandlerGroup[group]
		end

		--[[
		function __index(self, key)
			if _IFSPellHandler_ActionType[key] then
				self.__Accessor.Type = key
				return self.__Accessor
			end
		end

		function __newindex(self, key, value)
			if _IFSPellHandler_ActionType[key] then
				error(("Key %s is read-only"):format(key), 2)
			end

			rawset(self, key, value)
		end--]]
	endclass "SpellHandlerGroup"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Get the group setting object</desc>
		<param name="group">string, the group's name</param>
		<return type="System.Widget.Unit.IFSpellHandler.SpellHandlerGroup"></return>
	]]
	__Static__() function _Group(group)
		if group and type(group) ~= "string" then
			return nil
		end
		return SpellHandlerGroup(group)
	end

	__Doc__[[
		<desc>Get the all groups's name</desc>
		<return type="table">the name list</return>
	]]
	__Static__() function _GetGroupList(tbl)
		local ret = type(tbl) == "table" and tbl or {}

		wipe(ret)

		for grp in pairs(_DBChar) do
			tinsert(ret, grp)
		end

		return ret
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The object's group name, overridable]]
	property "IFSpellHandlerGroup" {
		Get = function(self)
			return _GlobalGroup
		end,
	}

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		-- Use real frame table to dispose, because the igas part frame table is already disposed.
		Task.NoCombatCall(RemoveUnitFrame, IGAS:GetUI(self), GetGroup(self.IFSpellHandlerGroup))
	end

	------------------------------------------------------
	-- Initialize
	------------------------------------------------------
    function IFSpellHandler(self)
		if not select(2, self:IsProtected()) then
			error("[" .. tostring(System.Reflector.GetObjectClass(self)) .."] Header frame must be explicitly protected")
			return
		end

		Task.NoCombatCall(InitUnitFrame, self)
    end
endinterface "IFSpellHandler"
