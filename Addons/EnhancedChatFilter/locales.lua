local _, ecf = ...

local L = {}
-----------------------------------------------------------------------
-- zhCN: 07.06.16
-----------------------------------------------------------------------
if (GetLocale() == "zhCN") then
	L["ClickToOpenConfig"] = "点击打开配置界面"
	L["MainFilter"] = "总开关"
	L["MinimapButton"] = "小地图图标"
	L["WhisperWhitelistMode"] = "密语白名单模式"
	L["DND"] = "'忙碌'玩家"
	L["Repeat"] = "重复信息"
	L["Achievement"] = "成就刷屏"
	L["RaidAlert"] = "团队警报"
	L["QuestReport"] = "任务组队"
	L["IgnoreMoreList"] = "扩展屏蔽名单"
	L["IncludeAutofilteredWord"] = "包含会被自动过滤的字符，将忽略该关键词！"
	L["Remove"] = "移除"
	L["ClearUp"] = "清空"
	L["AddBlackWordTitle"] = "添加新黑名单关键字"
	L["Regex"] = "正则"
	L["CommandLine"] = "命令"
	L["ClearedBlackWordList"] = "已清空黑名单"
	L["ClearedIgnoreMoreList"] = "已清空扩展屏蔽列表"
	L["And"] = "、"
	L["GotAchievement"] = "获得了成就"
	L["DoYouWantToClearBlackList?"] = "你确定要清空关键词列表么？"
	L["chatLinesLimitSlider"] = "重复信息缓存行数"
	L["stringDifferenceLimitSlider"] = "重复信息区分度"
	L["UseWithCare"] = "危险设置"
	L["Filters"] = "过滤器"
	L["Import"] = "导入"
	L["Export"] = "导出"
	L["StringHashMismatch"] = "字符串校验错误"
	L["ImportSucceeded"] = "导入成功"
	L["MultiLines"] = "多行喊话过滤"
	L["EnableAdvancedConfig"] = "启用高级选项"
	L["AdvancedWarningText"] = "不要随意更改高级选项中你不清楚的设置，不然你很有可能会把ECF玩坏！如果你已经知道危险性，请继续..."

	L["General"] = "常规"
	L["BlackworldList"] = "黑名单关键词"
	L["StringIO"] = "字符串导入导出"
	L["AdvancedConfig"] = "高级"

	L["WhisperWhitelistModeTooltip"] = "启用后除了工会、团队、小队、战网好友发送的密语外，只允许你发送过密语的对方才能对你发起密语|n|cffE2252D慎用！"
	L["MultiLinesTooltip"] = "重复过滤器现在也会过滤同一个人在短时间内的多行信息，这有助于减少各类宏的刷屏但同时也会过滤掉诸如dps统计的各插件通告"
	L["DNDfilterTooltip"] = "启用后过滤'忙碌'玩家及其自动回复"
	L["RepeatFilterTooltip"] = "启用后过滤同一玩家发送的相似信息"
	L["AchievementFilterTooltip"] = "启用后合并显示多个玩家获得同一成就"
	L["RaidAlertFilterTooltip"] = "启用后过滤各类技能/打断喊话提示"
	L["QuestReportFilterTooltip"] = "启用后过滤各类组队任务喊话提醒"
	L["RegexTooltip"] = "标记添加的关键词为正则表达式|n仅对该次添加的关键词有效"
	L["chatLinesLimitSliderTooltips"] = "重复信息的行数设定。请根据聊天频道的聊天量调整数值。增加数值会提高内存占用。默认值20"
	L["stringDifferenceLimitSliderTooltips"] = "重复信息判定标准，范围0至1。对于同一个人的发言，0为只过滤完全相同的内容，1为过滤任意内容。提高设定值会提高相似信息的过滤效果但会提高误处理几率。默认值0.1"
-----------------------------------------------------------------------
-- zhTW: 07.06.16
-- Contributors: 老虎007@NGA
-----------------------------------------------------------------------
elseif (GetLocale() == "zhTW") then
	L["ClickToOpenConfig"] = "點擊打開配置介面"
	L["MainFilter"] = "總開關"
	L["MinimapButton"] = "小地圖圖標"
	L["WhisperWhitelistMode"] = "密語白名單模式"
	L["DND"] = "'忙碌,玩家"
	L["Repeat"] = "重複信息"
	L["Achievement"] = "成就刷屏"
	L["RaidAlert"] = "團隊警報"
	L["QuestReport"] = "任務組隊"
	L["IgnoreMoreList"] = "擴展屏蔽名單"
	L["IncludeAutofilteredWord"] = "包含會被自動過濾的字符，蔣忽略該關鍵詞！"
	L["Remove"] = "移除"
	L["ClearUp"] = "清空"
	L["AddBlackWordTitle"] = "添加新黑名單關鍵詞"
	L["Regex"] = "正規"
	L["CommandLine"] = "命令"
	L["ClearedBlackWordList"] = "已清空黑名單"
	L["ClearedIgnoreMoreList"] = "已清空扩展屏蔽列表"
	L["And"] = "、"
	L["GotAchievement"] = "獲得了成就"
	L["DoYouWantToClearBlackList?"] = "你确定要清空关键词列表么？" -- Fixme
	L["chatLinesLimitSlider"] = "重复信息缓存行数" -- Fixme
	L["stringDifferenceLimitSlider"] = "重复信息区分度" -- Fixme
	L["UseWithCare"] = "危险设置" -- Fixme
	L["Filters"] = "過濾器" -- Fixme
	L["Import"] = "導入"
	L["Export"] = "導出"
	L["StringHashMismatch"] = "字符串校驗錯誤"
	L["ImportSucceeded"] = "導入成功"
	L["MultiLines"] = "多行喊话过滤" -- Fixme
	L["EnableAdvancedConfig"] = "启用高级选项" -- Fixme
	L["AdvancedWarningText"] = "不要随意更改高级选项中你不清楚的设置，不然你很有可能会把ECF玩坏！如果你已经知道危险性，请继续..." -- Fixme

	L["General"] = "常规" -- Fixme
	L["BlackworldList"] = "黑名单關鍵詞" -- Fixme
	L["StringIO"] = "字符串導入導出" -- Fixme
	L["AdvancedConfig"] = "高级" -- Fixme

	L["WhisperWhitelistModeTooltip"] = "启用后除了工会、团队、小队、战网好友发送的密语外，只允许你发送过密语的对方才能对你发起密语|n|cffE2252D慎用！" -- Fixme
	L["MultiLinesTooltip"] = "重复过滤器现在也会过滤同一个人在短时间内的多行信息，这有助于减少各类宏的刷屏但同时也会过滤掉诸如dps统计的各插件通告" -- Fixme
	L["DNDfilterTooltip"] = "启用后过滤'忙碌'玩家及其自动回复" -- Fixme
	L["RepeatFilterTooltip"] = "启用后过滤同一玩家发送的相似信息" -- Fixme
	L["AchievementFilterTooltip"] = "启用后合并显示多个玩家获得同一成就" -- Fixme
	L["RaidAlertFilterTooltip"] = "启用后过滤各类技能/打断喊话提示" -- Fixme
	L["QuestReportFilterTooltip"] = "启用后过滤各类组队任务喊话提醒" -- Fixme
	L["RegexTooltip"] = "标记添加的关键词为正则表达式|n仅对该次添加的关键词有效" -- Fixme
	L["chatLinesLimitSliderTooltips"] = "重复信息的行数设定。请根据聊天频道的聊天量调整数值。增加数值会提高内存占用。默认值20" -- Fixme
	L["stringDifferenceLimitSliderTooltips"] = "重复信息判定标准值，范围0至1。对于同一个人的发言，0为只过滤完全相同的内容，1为过滤任意内容。提高设定值会提高类似信息的过滤效果但会提高误处理几率。默认值0.1" -- Fixme
-----------------------------------------------------------------------
-- Default: 07.06.16 -- NEED HELP
-----------------------------------------------------------------------
else
	L["ClickToOpenConfig"] = "Click To Open Config"
	L["MainFilter"] = "Main Filter"
	L["MinimapButton"] = "Minimap Button"
	L["WhisperWhitelistMode"] = "Whisper Whitelist Mode"
	L["DND"] = "DND"
	L["Repeat"] = "Repeat"
	L["Achievement"] = "Achievement"
	L["RaidAlert"] = "RaidAlert"
	L["QuestReport"] = "QuestReport"
	L["IgnoreMoreList"] = "IgnoreMore List"
	L["ClearUp"] = "ClearUp"
	L["IncludeAutofilteredWord"] = "Includes symbels to be filtered. It will be ignored."
	L["Remove"] = "Remove"
	L["AddBlackWordTitle"] = "Add Blackword"
	L["Regex"] = "Regex"
	L["CommandLine"] = "CommandLine"
	L["ClearedBlackWordList"] = "BlackWordList Cleared."
	L["ClearedIgnoreMoreList"] = "IgnoreMore List Cleared."
	L["And"] = ", "
	L["GotAchievement"] = "have earned the achievement"
	L["DoYouWantToClearBlackList?"] = "Do you want to clear blacklist?"
	L["chatLinesLimitSlider"] = "Repeat message cache lines"
	L["stringDifferenceLimitSlider"] = "Repeat message Difference"
	L["UseWithCare"] = "UseWithCare"
	L["Filters"] = "Filters" -- Fixme
	L["Import"] = "Import"
	L["Export"] = "Export"
	L["StringHashMismatch"] = "String Hash Mismatch"
	L["ImportSucceeded"] = "Import Succeeded"
	L["MultiLines"] = "MultiLines"
	L["EnableAdvancedConfig"] = "Enable Advanced Config"
	L["AdvancedWarningText"] = "Please do NOT change any options that you don't understand, or you may mess ECF up. If you DO know the risk, you may continue..."

	L["General"] = "General"
	L["BlackworldList"] = "BlackWordList"
	L["StringIO"] = "Import/Export"
	L["AdvancedConfig"] = "Advanced"

	L["WhisperWhitelistModeTooltip"] = "While enabled, it will filter all whisper unless it's from guild/group/raid/battlenet friend or you have just whisper them|n|cffE2252DUse with care!"
	L["MultiLinesTooltip"] = "Filtered msg that is sent from the same person and in less than 1 sec. This may reduce chat spam but also remove report from addons."
	L["DNDfilterTooltip"] = "While enabled, it will filter all DND players and their auto reply"
	L["RepeatFilterTooltip"] = "While enabled, it will filter similar messages from the same player"
	L["AchievementFilterTooltip"] = "While enabled, it will filter achievement spam"
	L["RaidAlertFilterTooltip"] = "While enabled, it will filter raid alert from other players"
	L["QuestReportFilterTooltip"] = "While enabled, it will filter many kind of grouping messages"
	L["RegexTooltip"] = "Blackword that will be added should be a regex expression. Only works for this blackword."
	L["chatLinesLimitSliderTooltips"] = "Repeat message lines. Please change it to suit your message amount. Increase it will consume more memory. Default 20." -- Fixme
	L["stringDifferenceLimitSliderTooltips"] = "Message difference limit. Ranging from 0 to 1. For the same sender, 0 will only filter the same message while 1 will filter any message. Increase it will filter more similar messages but also some unwanted ones. Default 0.1." -- Fixme
end

ecf.L = L

setmetatable(ecf.L, {__index=function(self, key)
	return key
end})