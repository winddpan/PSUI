--以下内容可自行增加修改
--信息中将被过滤器过滤的 UTF-8 符号（常被用于干扰）
local UTF8Symbols = {['·']='',['＠']='',['＃']='',['％']='',
	['＆']='',['＊']='',['——']='',['＋']='',['｜']='',['～']='',['　']='',
	['，']='',['。']='',['、']='',['？']='',['！']='',['：']='',['；']='',
	['’']='',['‘']='',['“']='',['”']='',['【']='',['】']='',['『']='',
	['』']='',['《']='',['》']='',['（']='',['）']='',['￥']='',['＝']='',
	['…']='',['……']='',['１']='1',['２']='2',['３']='3',['４']='4',['５']='5',
	['６']='6',['７']='7',['８']='8',['９']='9',['０']='0',['⒈']='1',['⒉']='2',
	['⒊']='3',['⒋']='4',['⒌']='5',['⒍']='6',['⒎']='7',['⒏']='8',['⒐']='9',
	['Ａ']='A',['Ｂ']='B',['Ｃ']='C',['Ｄ']='D',['Ｅ']='E',['Ｆ']='F',['Ｇ']='G',['Ｈ']='H',
	['Ｉ']='I',['Ｊ']='J',['Ｋ']='K',['Ｌ']='L',['Ｍ']='M',['Ｎ']='N',['Ｏ']='O',['Ｐ']='P',
	['Ｑ']='Q',['Ｒ']='R',['Ｓ']='S',['Ｔ']='T',['Ｕ']='U',['Ｖ']='V',['Ｗ']='W',['Ｘ']='X',
	['Ｙ']='Y',['Ｚ']='Z',['〔']='',['〕']='',['〈']='',['〉']='',['‖']=''}
local RaidAlertTagList = {"%*%*(.+)%*%*", "EUI:(.+)施放了", "EUI:(.+)中断", "EUI:(.+)就绪", "EUI_RaidCD", "PS 死亡: (.+)>", "|Hspell(.+) => ", "受伤源自 |Hspell(.+) (总计): "}  --RaidAlert 特征
local QuestReportTagList = {"任务进度提示%s?[:：]", "%(任务完成%)", "<大脚组队提示>", "%[接受任务%]", "<大脚团队提示>", "进度:(.+):%d/%d"} --QuestReport 特征
local lootFilterList = {118043, 944, 71096} --按物品id过滤

--EnhancedChatFilter 内部定义
local ecfVersioin = GetAddOnMetadata("EnhancedChatFilter","Version")
local _, ecf = ...
local utf8replace = ecf.utf8replace -- utf8.lua
local L = ecf.L -- locales.lua
local chatLines = {}
local prevLineID = 0
local filterResult = nil
local filterCharList = "[|@!/<>\"`'_#&;:~\\]"
local filterCharListRegex = "[%(%)%.%%%+%-%*%?%[%]%$%^={}]"
local allowWisper = {}
local config

local gsub, select, ipairs, tremove, tinsert, pairs, strsub, sort, format, tonumber, strmatch =
gsub, select, ipairs, tremove, tinsert, pairs, strsub, sort, format, tonumber, strmatch

--http://www.wowwiki.com/USERAPI_StringHash
local function StringHash(text)
	local counter = 1
	local len = string.len(text)
	for i = 1, len, 3 do
	counter = math.fmod(counter*8161, 4294967279) +  -- 2^32 - 17: Prime!
		(string.byte(text,i)*16776193) +
		((string.byte(text,i+1) or (len-i+256))*8372226) +
		((string.byte(text,i+2) or (len-i+256))*3932164)
	end
	return math.fmod(counter, 4294967291) -- 2^32 - 5: Prime (and different from the prime in the loop)
end

local EnhancedChatFilter = LibStub("AceAddon-3.0"):NewAddon("EnhancedChatFilter", "AceConsole-3.0", "AceEvent-3.0")

--数据库初始设置
local defaults = {
	profile = {
		enableFilter = true, --ECF聊天过滤总开关
		enableWisper = false, --密语白名单过滤
		enableDND = true, --“忙碌”玩家过滤
		enableRPT = true, --重复聊天过滤
		enableCFA = true, --成就刷屏过滤
		enableRAF = false, --团队刷屏过滤
		enableQRF = false, --任务组队过滤
		enableIGM = false, --扩展屏蔽名单
		multiLine = false, -- 多行喊话过滤
		blackWordList = {}, --关键词列表
		ignoreMoreList = {}, --扩展屏蔽名单
		minimap = {
			hide = false, --小地图图标选项
		},
		advancedConfig = false, --显示高级设置
		chatLinesLimit = 20,
		stringDifferenceLimit = 0.1,
		debugMode = false,
	}
}

--确保关键词自身不会被预处理干扰
local function checkBlacklist(blackWord, typeModus)
	local newWord = blackWord:gsub("%s", ""):gsub(filterCharList, "")
	if (typeModus ~= "regex") then newWord=newWord:gsub(filterCharListRegex, "") end
	newWord = utf8replace(newWord, UTF8Symbols)
	if(newWord ~= blackWord) then return true end
end

--旧关键词表转化成新的
local function convert()
	if(config.blackList) then
		for _,v in ipairs(config.blackList) do
			config.blackWordList[v[1]] = v[2] or true
		end
		config.blackList = nil
	end
	for key,v in pairs(config.blackWordList) do
		if(checkBlacklist(key,v)) then config.blackWordList[key] = nil end
	end
end

--创建小地图图标数据
local ecfLDB = LibStub("LibDataBroker-1.1"):NewDataObject("Enhanced Chat Filter", {
	type = "data source",
	text = "Enhanced Chat Filter",
	icon = "Interface\\Icons\\Trade_Archaeology_Orc_BloodText",
	OnClick = function() EnhancedChatFilter:EnhancedChatFilterOpen() end,
	OnTooltipShow = function(tooltip)
		tooltip:AddLine("|cffecf0f1Enhanced Chat Filter|r\n"..L["ClickToOpenConfig"])
	end
})
--创建 Libstub 变量
local icon = LibStub("LibDBIcon-1.0")

--初始化插件
function EnhancedChatFilter:OnInitialize()
	EnhancedChatFilter:RegisterChatCommand("ecf", "EnhancedChatFilterOpen")
	EnhancedChatFilter:RegisterChatCommand("ecf-clear", "EnhancedChatFilterClear")
	EnhancedChatFilter:RegisterChatCommand("ecf-iml", "EnhancedChatFilterIgnoreMoreList")
	EnhancedChatFilter:RegisterChatCommand("ecf-cleariml", "EnhancedChatFilterClearIMList")
	EnhancedChatFilter:RegisterChatCommand("ecf-debug", "EnhancedChatFilterDebug")

	config = LibStub("AceDB-3.0"):New("ecfDB", defaults, "Default").profile
	icon:Register("Enhanced Chat Filter", ecfLDB, config.minimap)
	convert()
	
	print("|cffffff00Enhanced Chat Filter MOD|r|cff3498db v"..ecfVersioin.."|cffecf0f1 - "..L["CommandLine"].." '/ecf'")
end

--Options
--这些设置不会被保存
local scrollHighlight = {}
local regexToggle = false
local stringIO = ""

local options = {
	type = "group",
	name = "EnhancedChatFilter",
	get = function(info) return config[info[#info]] end,
	set = function(info, value) config[info[#info]] = value end,
	disabled = function() return not config.enableFilter end,
	args = {
		enableFilter = {
			type = "toggle",
			name = L["MainFilter"],
			order = 1,
			disabled = false,
		},
		MinimapToggle = {
			type = "toggle",
			name = L["MinimapButton"],
			get = function() return not config.minimap.hide end,
			set = function(_,toggle)
					config.minimap.hide = not toggle
					if(toggle) then icon:Show("Enhanced Chat Filter") else icon:Hide("Enhanced Chat Filter") end
				end,
			order = 2,
			disabled = false,
		},
		ToggleTab = {
			type = "group",
			name = L["General"],
			order = 3,
			args = {
				line1 = {
					type = "header",
					name = L["Filters"],
					order = 10,
				},
				enableDND = {
					type = "toggle",
					name = L["DND"],
					desc = L["DNDfilterTooltip"],
					order = 11,
				},
				enableRPT = {
					type = "toggle",
					name = L["Repeat"],
					desc = L["RepeatFilterTooltip"],
					order = 12,
				},
				enableCFA = {
					type = "toggle",
					name = L["Achievement"],
					desc = L["AchievementFilterTooltip"],
					order = 13,
				},
				enableRAF = {
					type = "toggle",
					name = L["RaidAlert"],
					desc = L["RaidAlertFilterTooltip"],
					order = 14,
				},
				enableQRF = {
					type = "toggle",
					name = L["QuestReport"],
					desc = L["QuestReportFilterTooltip"],
					order = 15,
				},
				enableIGM = {
					type = "toggle",
					name = L["IgnoreMoreList"],
					order = 16,
				},
				line2 = {
					type = "header",
					name = L["UseWithCare"],
					order = 20,
				},
				enableWisper = {
					type = "toggle",
					name = L["WhisperWhitelistMode"],
					desc = L["WhisperWhitelistModeTooltip"],
					order = 21,
				},
				multiLine = {
					type = "toggle",
					name = L["MultiLines"],
					desc = L["MultiLinesTooltip"],
					order = 22,
					disabled = function() return not config.enableFilter or not config.enableRPT end,
				},
			},
		},
		blackListTab = {
			type = "group",
			name = L["BlackworldList"],
			order = 4,
			args = {
				blackword = {
					type = "input",
					name = L["AddBlackWordTitle"],
					order = 1,
					get = nil,
					set = function(_,value)
						if (checkBlacklist(value, regexToggle)) then
							print(value..L["IncludeAutofilteredWord"])
						else
							config.blackWordList[value] = regexToggle or true
							scrollHighlight = {}
						end
					end,
				},
				regex = {
					type = "toggle",
					name = L["Regex"],
					desc = L["RegexTooltip"],
					order = 2,
					get = function() return regexToggle end,
					set = function(_,value) regexToggle = value and "regex" end,
				},
				DeleteButton = {
					type = "execute",
					name = L["Remove"],
					order = 3,
					func = function()
						for key in pairs(scrollHighlight) do config.blackWordList[key] = nil end
						scrollHighlight = {}
					end,
					disabled = function() return next(scrollHighlight) == nil end,
				},
				ClearUpButton = {
					type = "execute",
					name = L["ClearUp"],
					order = 4,
					func = function() EnhancedChatFilter:EnhancedChatFilterClear() end,
					confirm = true,
					confirmText = L["DoYouWantToClearBlackList?"],
					disabled = function() return next(config.blackWordList) == nil end,
				},
				blackWordList = {
					type = "multiselect",
					name = L["BlackworldList"],
					order = 10,
					get = function(_,key) return scrollHighlight[key] end,
					set = function(_,key,value) scrollHighlight[key] = value or nil end,
					values = function()
						local blacklistname = {}
						for key in pairs(config.blackWordList) do blacklistname[key] = key end
						return blacklistname
					end,
				},
				line1 = {
					type = "header",
					name = L["StringIO"],
					order = 20,
				},
				stringconfig = {
					type = "input",
					name = "",
					order = 21,
					get = function() return stringIO end,
					set = function(_,value) stringIO = value end,
					width = "double",
				},
				import = {
					type = "execute",
					name = L["Import"],
					order = 22,
					func = function()
						local wordString, HashString = strsplit("@", stringIO)
						if (tonumber(HashString) ~= tonumber(StringHash(wordString))) then
							print(L["StringHashMismatch"])
							return
						end
						local newBlackList = {strsplit(";", wordString)}
						for _, blacklist in ipairs(newBlackList) do
							if (blacklist ~= nil) then
								local imNewWord, imTypeWord = strsplit(",",blacklist)
								if (checkBlacklist(imNewWord, imTypeWord)) then
									print(imNewWord..L["IncludeAutofilteredWord"])
								else
									config.blackWordList[imNewWord] = imTypeWord or true
								end
							end
						end
						stringIO = ""
						print(L["ImportSucceeded"])
					end,
					disabled = function() return stringIO == "" end,
				},
				export = {
					type = "execute",
					name = L["Export"],
					order = 23,
					func = function()
						local blackStringList = {}
						for key,v in pairs(config.blackWordList) do
							if (checkBlacklist(key, v)) then
								print(key..L["IncludeAutofilteredWord"])
							else
								if (v == true) then
									blackStringList[#blackStringList+1] = key
								else
									blackStringList[#blackStringList+1] = key..","..v
								end
							end
						end
						local blackString = table.concat(blackStringList,";")
						stringIO = blackString.."@"..StringHash(blackString)
					end,
				},
			},
		},
		Advanced = {
			type = "group",
			name = L["AdvancedConfig"],
			order = 5,
			args = {
				AdvancedWarning = {
					type = "execute",
					name = L["EnableAdvancedConfig"],
					confirm = true,
					confirmText = L["AdvancedWarningText"],
					func = function() config.advancedConfig = true end,
					hidden = function() return config.advancedConfig end,
					order = 1,
				},
				chatLinesLimit = {
					type = "range",
					name = L["chatLinesLimitSlider"],
					desc = L["chatLinesLimitSliderTooltips"],
					order = 11,
					min = 1,
					max = 100,
					step = 1,
					bigStep = 5,
					disabled = function() return not config.enableRPT end,
					hidden = function() return not config.advancedConfig end,
				},
				stringDifferenceLimit = {
					type = "range",
					name = L["stringDifferenceLimitSlider"],
					desc = L["stringDifferenceLimitSliderTooltips"],
					order = 12,
					min = 0,
					max = 1,
					step = 0.01,
					bigStep = 0.1,
					isPercent = true,
					disabled = function() return not config.enableRPT end,
					hidden = function() return not config.advancedConfig end,
				},
				line1 = {
					type = "header",
					name = "",
					order = 20,
					hidden = function() return not config.advancedConfig end,
				},
				debugMode = {
					type = "toggle",
					name = "DebugMode",
					desc = "For test only",
					order = 21,
					hidden = function() return not config.advancedConfig end,
				},
			},
		},
	},
}
LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("EnhancedChatFilter", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EnhancedChatFilter", "EnhancedChatFilter")

--扩展黑名单
local function SendMessage(event, msg)
	local info = ChatTypeInfo[strsub(event, 10)]
	for i = 1, NUM_CHAT_WINDOWS do
		local ChatFrames = _G["ChatFrame"..i]
		if (ChatFrames and ChatFrames:IsEventRegistered(event)) then
			ChatFrames:AddMessage(msg, info.r, info.g, info.b)
		end
	end
end

local function ignoreMore(player)
	if (not config.enableIGM or not player) then return end
	local ignore = nil
	if GetNumIgnores() >= 50 then
		for i = 1, GetNumIgnores() do
			local name = GetIgnoreName(i)
			if (player == name) then
				ignore = true
				break
			end
		end
		if (not ignore) then
			local trimmedPlayer = Ambiguate(player, "none")
			tinsert(config.ignoreMoreList,{trimmedPlayer})
			if config.debugMode then print("Added to ECF ignoreMoreList!") end
			SendMessage("CHAT_MSG_SYSTEM", format(ERR_IGNORE_ADDED_S, trimmedPlayer))
		end
	end
end

hooksecurefunc("AddIgnore", ignoreMore)
hooksecurefunc("AddOrDelIgnore", ignoreMore)

--禁用暴雪内部语言过滤器
local GetCVar,SetCVar = GetCVar,SetCVar

local profanityFilter=CreateFrame("Frame")

local function allowSwearing()
	if GetCVar("profanityFilter")~="0" then SetCVar("profanityFilter", "0") end
end

profanityFilter:SetScript("OnEvent", allowSwearing)
profanityFilter:RegisterEvent("VARIABLES_LOADED")
profanityFilter:RegisterEvent("CVAR_UPDATE")
profanityFilter:RegisterEvent("PLAYER_ENTERING_WORLD")
profanityFilter:RegisterEvent("BN_MATURE_LANGUAGE_FILTER")
profanityFilter:RegisterEvent("BN_CONNECTED")

allowSwearing() -- 确认再次载入

--登陆/好友列表更新时同步更新允许密语玩家列表
local login = nil
local ecfFrame = CreateFrame("Frame")
ecfFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
ecfFrame:RegisterEvent("FRIENDLIST_UPDATE")
ecfFrame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		ShowFriends() --强制刷新一次好友列表
	else
		if not login then --登陆时只添加一次
			login = true
			local num = GetNumFriends()
			for i = 1, num do
				local n = GetFriendInfo(i)
				--添加好友到允许名单
				if n then allowWisper[n] = true end
			end
			return
		end
	end
	if config.debugMode then for k in pairs(allowWisper) do print("ECF allowed: "..k) end end
end)

--自己主动密语的玩家加入安全名单
local function addToAllowWisper(self,_,_,player)
	local trimmedPlayer = Ambiguate(player, "none")
	allowWisper[trimmedPlayer] = true
end

--字符串不同程度, 范围0..1, 0为完全相同, 1为完全不同
local function stringDifference(stringA, stringB)
	local len_a, len_b = #stringA, #stringB
	local templast, temp = {}, {}
	for j=0, len_b do templast[j+1] = j end
	for i=1, len_a do
		temp[1] = i
		for j=1, len_b do
			if(stringA:sub(i,i) == stringB:sub(j,j)) then
				temp[j+1] = templast[j]
			else
				temp[j+1] = min(templast[j+1], temp[j], templast[j]) + 1
			end
		end
		for j=0, len_b do templast[j+1]=temp[j+1] end
	end
	return temp[len_b+1]/(len_a+len_b)
end

-------------------------------------- Filters ------------------------------------

local chatChannel = {["CHAT_MSG_WHISPER"] = 1, ["CHAT_MSG_SAY"] = 2, ["CHAT_MSG_CHANNEL"] = 3, ["CHAT_MSG_YELL"] = 3, ["CHAT_MSG_PARTY"] = 4, ["CHAT_MSG_PARTY_LEADER"] = 4, ["CHAT_MSG_RAID"] = 4, ["CHAT_MSG_RAID_LEADER"] = 4, ["CHAT_MSG_RAID_WARNING"] = 4, ["CHAT_MSG_INSTANCE_CHAT"] = 4,["CHAT_MSG_INSTANCE_CHAT_LEADER"] = 4, ["CHAT_MSG_DND"] = 101}

local function ECFfilter(self,event,msg,player,_,_,_,flags,_,_,_,_,lineID)
	--如果不启用过滤直接返回
	if(not config.enableFilter) then return end

	--避免自己被过滤
	local trimmedPlayer = Ambiguate(player, "none")
	if UnitIsUnit(trimmedPlayer,"player") then return end

	--对 GM 和 DEV 的密语不做处理
	if type(flags) == "string" and (flags == "GM" or flags == "DEV") then return end

	--如果这行被处理过，则直接引用之前的结果，避免多聊天窗口时触发重复过滤器
	if(lineID == prevLineID) then
		return filterResult
	else
		prevLineID = lineID
		filterResult = nil
	end
	
	if config.debugMode then print("RAWMsg: "..msg) end
	--删除颜色代码, 物品链接标志, 空格以及一些符号
	local filterString = msg:upper():gsub("|C[0-9A-F]+",""):gsub("|H[^|]+|H",""):gsub("|H|R",""):gsub("%s", ""):gsub(filterCharList, "")

	--删除 UTF-8 干扰符
	filterString = utf8replace(filterString, UTF8Symbols)
	local newfilterString = filterString:gsub(filterCharListRegex, "")

	if(config.enableIGM and chatChannel[event] <= 1) then --拓展黑名单过滤
		for _,ignorePlayer in ipairs(config.ignoreMoreList) do
			if (trimmedPlayer == ignorePlayer[1]) then
				if config.debugMode then print("Trigger: IgnoreMore Filter") end
				filterResult = true
				return true
			end
		end
	end

	if(config.enableWisper and chatChannel[event] <= 1) then --密语白名单过滤
		--强制刷新一次好友列表
		ShowFriends()
		--同工会，同团队，同小队和好友不做处理
		if allowWisper[trimmedPlayer] or UnitIsInMyGuild(trimmedPlayer) or UnitInRaid(trimmedPlayer) or UnitInParty(trimmedPlayer) then return end
		--战网好友不做处理
		for i = 1, select(2, BNGetNumFriends()) do
			local GameAccount = BNGetNumFriendGameAccounts(i)
			for j = 1, GameAccount do
				local _, rName, rGame = BNGetFriendGameAccountInfo(i, j)
				if (rName == trimmedPlayer and rGame == "WoW") then return end
			end
		end
		if config.debugMode then print("Trigger: WhiteListMode") end
		filterResult = true
		return true
	end

	if(config.enableDND and (chatChannel[event] <= 3 or chatChannel[event] == 101)) then --"忙碌"玩家过滤
		if ((type(flags) == "string" and flags == "DND") or chatChannel[event] == 101) then
			if config.debugMode then print("Trigger: DND Filter") end
			filterResult = true
			return true
		end
	end

	if(chatChannel[event] <= 3) then --关键词过滤
		--从处理过的聊天信息中过滤包含黑名单词语的聊天内容
		for keyWord,v in pairs(config.blackWordList) do
			local currentString
			if (v ~= "regex") then -- 如果不是正则，也过滤正则中使用的特殊字符
				keyWord = keyWord:upper()
				currentString = newfilterString
			else
				currentString = filterString
			end
			--检查常规黑名单
			if (currentString:find(keyWord)) then
				if config.debugMode then print("Trigger: Keyword: "..keyWord) end
				filterResult = true
				return true
			end
		end
	end

	if (config.enableRAF and IsInGroup() and (chatChannel[event] == 4 or chatChannel[event] == 2)) then
		for _,RaidAlertTag in ipairs(RaidAlertTagList) do
			if(msg:find(RaidAlertTag)) then
				if config.debugMode then print("Trigger: "..RaidAlertTag.." in RaidAlertTag") end
				filterResult = true
				return true
			end
		end
	end

	if (config.enableQRF and IsInGroup() and (chatChannel[event] == 4 or chatChannel[event] == 2)) then
		for _,QuestReportTag in ipairs(QuestReportTagList) do
			if(msg:find(QuestReportTag)) then
				if config.debugMode then print("Trigger: "..QuestReportTag.." in QuestReportTag") end
				filterResult = true
				return true
			end
		end
	end

	if(config.enableRPT and chatChannel[event] <= 4) then --重复信息过滤
		local msgLine = newfilterString
		if(msgLine == "") then msgLine = msg end --如果对话只有符号则保留原信息

		--处理重复信息
		local msgtable = {Sender = trimmedPlayer, Msg = msgLine, Time = GetTime()}
		for i=1, #chatLines do
			--如果一个人在0.6秒钟之内发了多条信息, 过滤
			--如果一个人的信息完全相同, 过滤
			if (chatLines[i].Sender == msgtable.Sender and ((config.multiLine and (msgtable.Time - chatLines[i].Time) < 0.600) or stringDifference(chatLines[i].Msg,msgtable.Msg) <= config.stringDifferenceLimit)) then
				chatLines[i] = msgtable
				if config.debugMode then print("Trigger: Repeat Filter") end
				filterResult = true
				return true
			end
			if i >= config.chatLinesLimit then tremove(chatLines, 1) end
		end
		tinsert(chatLines, msgtable)
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", addToAllowWisper)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ECFfilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ECFfilter)

--method run on /ecf
function EnhancedChatFilter:EnhancedChatFilterOpen()
	if(InCombatLockdown()) then return end
	InterfaceOptionsFrame_OpenToCategory("EnhancedChatFilter")
end

--method run on /ecf-clear
function EnhancedChatFilter:EnhancedChatFilterClear()
	config.blackWordList = {}
	scrollHighlight = {}
	print(L["ClearedBlackWordList"])
end

--method run on /ecf-iml
function EnhancedChatFilter:EnhancedChatFilterIgnoreMoreList()
	local ignoreMoreList = config.ignoreMoreList
	print(L["IgnoreMoreList"]..": ")
	for _,ignorePlayer in ipairs(ignoreMoreList) do
		print(ignorePlayer[1])
	end
end

--method run on /ecf-cleariml
function EnhancedChatFilter:EnhancedChatFilterClearIMList()
	config.ignoreMoreList = {}
	print(L["ClearedIgnoreMoreList"])
end

--method run on /ecf-debug
function EnhancedChatFilter:EnhancedChatFilterDebug()
	if(config.debugMode) then print("Debug Mode Off!") else print("Debug Mode On!") end
	config.debugMode = not config.debugMode
end

-----------------------------------------------------------------------
-- ChatFilter 成就刷屏过滤模块
-----------------------------------------------------------------------

local achievements, alreadySent = {}, {}
local achievementFrame = CreateFrame("Frame")
achievementFrame:Hide()

local function SendAchievement(event, achievementID, players)
	if (not players) then return end
	for k in pairs(alreadySent) do alreadySent[k] = nil end
	for i = #(players), 1, -1 do
		if (alreadySent[players[i].name]) then
			tremove(players, i)
		else
			alreadySent[players[i].name] = true
		end
	end
	if (#(players) > 1) then
		sort(players, function(a, b) return a.name < b.name end)
	end
	for i = 1, #(players) do
		local class, color, r, g, b
		if (players[i].guid and players[i].guid:find("Player")) then
			class = select(2, GetPlayerInfoByGUID(players[i].guid))
			color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		end
		if (not color) then
			local info = ChatTypeInfo[strsub(event, 10)]
			r, g, b = info.r, info.g, info.b
		else
			r, g, b = color.r, color.g, color.b
		end
		players[i] = format("|cff%02x%02x%02x|Hplayer:%s|h%s|h|r", r*255, g*255, b*255, players[i].name, players[i].name)
	end
	SendMessage(event, format("[%s]"..L["GotAchievement"].."%s!", table.concat(players, L["And"]), GetAchievementLink(achievementID)))
end

local function achievementReady(id, achievement)
	if (achievement.area and achievement.guild) then
		local playerGuild = GetGuildInfo("player")
		for i = #(achievement.area), 1, -1 do
			local player = achievement.area[i].name
			if (UnitExists(player) and playerGuild and playerGuild == GetGuildInfo(player)) then
				tinsert(achievement.guild, tremove(achievement.area, i))
			end
		end
	end
	if (achievement.area and #(achievement.area) > 0) then
		SendAchievement("CHAT_MSG_ACHIEVEMENT", id, achievement.area)
	end
	if (achievement.guild and #(achievement.guild) > 0) then
		SendAchievement("CHAT_MSG_GUILD_ACHIEVEMENT", id, achievement.guild)
	end
end

achievementFrame:SetScript("OnUpdate", function(self)
	local found
	for id, achievement in pairs(achievements) do
		if (achievement.timeout <= GetTime()) then
			achievementReady(id, achievement)
			achievements[id] = nil
		end
		found = true
	end
	if (not found) then self:Hide() end
end)

local function queueAchievementSpam(event, achievementID, playerdata)
	achievements[achievementID] = achievements[achievementID] or {timeout = GetTime() + 0.5}
	achievements[achievementID][event] = achievements[achievementID][event] or {}
	tinsert(achievements[achievementID][event], playerdata)
	achievementFrame:Show()
end

local function ChatFilter_Achievement(self, event, msg, _, _, _, _, _, _, _, _, _, _, guid)
	if not config.enableCFA then return end
	local achievementID = strmatch(msg, "achievement:(%d+)")
	if (not achievementID) then return end
	achievementID = tonumber(achievementID)
	local Name, Server
	if (guid and guid:find("Player")) then
		Name = select(6, GetPlayerInfoByGUID(guid))
		Server = select(7, GetPlayerInfoByGUID(guid))
		if (Name and Server and Server ~= "" and Server ~= GetRealmName()) then
			Name = Name.."-"..Server
		end
	end
	local playerdata = {name = Name, guid = guid}
	queueAchievementSpam((event == "CHAT_MSG_GUILD_ACHIEVEMENT" and "guild" or "area"), achievementID, playerdata)
	return true
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_ACHIEVEMENT", ChatFilter_Achievement)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", ChatFilter_Achievement)

--拾取物品过滤器
local function lootfilter(self,_,msg)
	for _, itemId in ipairs(lootFilterList) do
		if (itemId == tonumber(strmatch(msg, "|Hitem:(%d+)"))) then return true end
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", lootfilter)