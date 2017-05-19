-- Translate RCLootCouncil to your language at:
-- http://wow.curseforge.com/addons/rclootcouncil/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("RCLootCouncil", "zhCN")
if not L then return end

L[" is not active in this raid."] = "在当前团队中未启用。"
L[" you are now the Master Looter and RCLootCouncil is now handling looting."] = " 你现在是战利品分配者，RCLootCouncil正在管理分配。"
L["&p was awarded with &i for &r!"] = "&p 获得了 &i 理由为 &r！"
--Translation missing 
-- L["A format to copy/paste to another player."] = ""
L["A new session has begun, type '/rc open' to open the voting frame."] = "新的分配已经开始，输入 /rc open 开启投票界面。"
--Translation missing 
-- L["A tab delimited output for Excel. Might work with other spreadsheets."] = ""
--Translation missing 
-- L["A tab delimited output for Excel. Might work with outher spreadsheets."] = ""
L["Abort"] = "中止"
L["Accept Whispers"] = "接受密语"
L["accept_whispers_desc"] = "允许玩家密语他们当前的物品给你, 由你来添加到分配界面."
L["Acknowledged as 'response'"] = "已收到回应 \" %s \""
L["Active"] = "启用"
L["active_desc"] = "取消勾选以禁用RCLootCouncil。当你在团队中但没参与副本活动时这很有用。备注：此选项在每次登出时重置。"
L["add"] = "添加"
L["Add Item"] = "添加物品"
L["Add Note"] = "添加笔记"
L["Add ranks"] = "添加会阶"
L["Add rolls"] = "添加Roll"
L["add_ranks_desc"] = "选择参与战利品分配议会的最低会阶"
L["add_ranks_desc2"] = [=[在上方选择一个会阶，添加该会阶以及高于此会阶的所有公会成员为议会成员。

点击左侧的会阶，添加指定玩家为议会成员。

点击 "当前议会成员" 页 来查看你所选择的成员。]=]
L["All items"] = "所有物品"
L["All items has been awarded and  the loot session concluded"] = "所有战利品已分配完毕"
L["Alt click Looting"] = "Alt+左键分配"
L["alt_click_looting_desc"] = "启用Alt+左键分配。使用Alt+左键点击物品以开始分配。"
L["Alternatively, flag the loot as award later."] = "另外，标记该物品为稍后分配。"
L["Always use RCLootCouncil when I'm Master Looter"] = "当拥有分配权时，总是使用RCLootCouncil"
L["Always use when leader"] = "当为队长时，总是使用RCLootCouncil"
L["Announce Awards"] = "通告分配"
L["Announce Considerations"] = "通告待定"
L["announce_awards_desc"] = "在聊天频道中显示物品分配信息。"
L["announce_awards_desc2"] = [=[
选择要通告物品分配信息的频道。
使用 &p 指代获取该物品的玩家名，&i 指代该物品，&r 指代分配理由。]=]
L["announce_considerations_desc"] = "当物品分配开始时，通告待定的物品。"
L["announce_considerations_desc2"] = [=[
选择你想通告的频道和消息。
该消息将出现在物品列表之前。]=]
L["Announcements"] = "通告"
L["Anonymous Voting"] = "匿名投票"
L["anonymous_voting_desc"] = "开启匿名投票，成员无法看到谁投给了谁。"
L["Appearance"] = "外观"
L["Append realm names"] = "附加服务器名"
L["Are you sure you want to abort?"] = "确定要中止分配吗？"
L["Are you sure you want to give #item to #player?"] = "确定将 %s 分配给 %s？"
--Translation missing 
-- L["Armor Token"] = ""
L["Ask me every time I become Master Looter"] = "当成为战利品分配者时，总是询问我"
L["Ask me when leader"] = "当为队长时，询问我"
L["Auto Award"] = "自动分配"
L["Auto Award to"] = "自动分配给"
L["Auto awarded 'item'"] = "自动分配 %s"
L["Auto Close"] = "自动关闭"
L["Auto Enable"] = "自动开启"
L["Auto Loot"] = "自动拾取"
L["Auto Open"] = "自动打开"
L["Auto Pass"] = "自动放弃"
L["Auto pass BoE"] = "自动放弃装绑"
L["Auto Start"] = "自动开始"
L["auto_award_desc"] = "启用自动分配。"
L["auto_award_to_desc"] = "接受自动分配物品的玩家。当在团队中时，会有一个可选择团队成员的列表。"
L["auto_close_desc"] = "在战利品分配者结束物品分配时自动关闭投票窗口"
L["auto_enable_desc"] = "总是允许RCLootCouncil管理物品分配。非勾选状态下，每次加入团队或成为战利品分配者时，插件都会询问是否开启。"
L["auto_loot_desc"] = "开启自动拾取所有可装备的物品。"
L["auto_open_desc"] = "勾选以自动打开投票界面。非勾选状态下，也可通过输入 /rc open 手动开启。注意：需要战利品分配者的许可。"
L["auto_pass_boe_desc"] = "取消勾选以禁用自动放弃装绑。"
L["auto_pass_desc"] = "勾选以自动放弃当前职业无法使用的物品。"
L["auto_start_desc"] = "启用自动开始，开始分配所有符合条件的物品。取消勾选则会在开始分配物品前显示选择要分配物品的列表。"
L["Autoloot BoE"] = "自动拾取装绑"
L["autoloot_BoE_desc"] = "开启自动拾取装绑物品。"
L["Autopass"] = "自动放弃"
L["Autopassed on 'item'"] = "自动放弃 %s"
L["Autostart isn't supported when testing"] = "自动开始在测试模式无法使用"
L["award"] = "奖励"
L["Award"] = "分配"
L["Award Announcement"] = "分配通知"
L["Award for ..."] = "分配为"
L["Award later?"] = "稍后分配？"
L["Award Reasons"] = "分配理由"
L["award_reasons_desc"] = [=[Roll点时无法选择分配理由。
用于自动分配，以及右键更改回应时。
]=]
L["Awards"] = "分配"
L["Background"] = "背景"
L["Background Color"] = "背景颜色"
L["Banking"] = "收藏"
--Translation missing 
-- L["BBCode export, tailored for SMF."] = ""
L["Border"] = "边框"
L["Border Color"] = "边框颜色"
L["Button"] = "按钮"
L["Buttons and Responses"] = "按钮与回应"
L["buttons_and_responses_desc"] = [=[设置团队成员拾取界面的回应按钮。
在这里的顺序决定了投票窗口的排序，并且在拾取界面是从左到右排列的，使用滑动条设置按钮的数量 (最多为 %d)。

"放弃" 按钮自动添加至最右侧]=]
L["Cancel"] = "取消"
L["Candidate didn't respond on time"] = "没有及时回应"
L["Candidate has disabled RCLootCouncil"] = "RCLootCouncil已被禁用"
L["Candidate is not in the instance"] = "不在副本中"
L["Candidate is selecting response, please wait"] = "正在考虑中，请稍等"
L["Candidate removed"] = "已被排除"
L["Cannot autoaward:"] = "无法自动分配："
L["Cannot give 'item' to 'player' due to Blizzard limitations. Gave it to you for distribution."] = "由于暴雪的限制，你无法将 %s 分配给 %s。交给你分配了。"
L["Change Response"] = "更改回应"
L["Changing loot threshold to enable Auto Awarding"] = "更改物品分配界限以启用自动分配"
L["Changing LootMethod to Master Looting"] = "拾取方式更改为队长分配"
L["Channel"] = "频道"
L["channel_desc"] = "要发送消息的频道。"
L["chat tVersion string"] = "|cFF87CEFARCLootCouncil |cFFFFFFFF版本 |cFFFFA500 %s - %s"
L["chat version String"] = "|cFF87CEFARCLootCouncil |cFFFFFFFF版本 |cFFFFA500 %s"
L["chat_commands"] = [=[

- config    - 开启配置界面
- council   - 开启议会界面
- history   - 开启拾取历史 (也可以用 'h' 或 'his')
- version   - 检查更新 (也可以用 'v' 或 'ver')
- open      - 开启投票界面
- reset     - 重置界面位置
- test (#)  - 模拟分配 # 个物品，缺省为 1
- whisper   - 显示密语命令帮助
- add [物品]- 添加一件物品到分配界面
- award     - 开始分配已经拾取到你背包里的物品
- winners   - 显示获胜者
]=]
L["Check this to loot the items and distribute them later."] = "勾选此项将拾取这些物品并稍后分配。"
L["Check to append the realmname of a player from another realm"] = "勾选以显示来自其他服务器玩家的服务器名"
L["Check to have all frames minimize when entering combat"] = "勾选此项将使所有窗口在进入战斗时最小化"
L["Choose timeout length in seconds"] = "选择超时时长(秒)"
L["Choose when to use RCLootCouncil"] = "选择何时使用RCLootCouncil"
L["Clear Loot History"] = "清除拾取历史"
--Translation missing 
-- L["Clear Selection"] = ""
L["clear_loot_history_desc"] = "清除所有拾取历史记录。"
L["Click to add note to send to the council."] = "点击添加要发送给议会的备注。"
L["Click to expand/collapse more info"] = "点击 展开/折叠 更多信息"
L["Click to switch to 'item'"] = "点击切换为 %s"
L["Close"] = "关闭"
L["config"] = "配置"
L["confirm_usage_text"] = [=[|cFF87CEFA RCLootCouncil |r

是否在此团队使用RCLootCouncil？]=]
L["Could not Auto Award i because the Loot Threshold is too high!"] = "无法自动分配 %s 因为拾取物品分配界限过高！"
L["Could not find 'player' in the group."] = "在队伍中无法找到 %s。"
L["Couldn't find any councilmembers in the group"] = "在队伍中无法找到任何议会成员"
L["council"] = "议会"
L["Council"] = "议会"
L["Current Council"] = "当前议会成员"
L["current_council_desc"] = [=[
点击将指定玩家从议会中移除
]=]
L["Customize appearance"] = "自定义外观"
L["customize_appearance_desc"] = "你可以在这定制RCLootCouncil的外观。使用上方的保存功能快速切换皮肤。"
L["Date"] = "日期"
L["days and x months"] = "%s 和 %d 月。"
L["days, x months, y years"] = "%s，%d 月 和 %d 年。"
L["Delete Skin"] = "删除皮肤"
L["delete_skin_desc"] = "从列表中删除当前选择的非默认皮肤。"
L["Deselect responses to filter them"] = "取消选择回应以过滤它们"
L["Diff"] = "提升"
L["Disenchant"] = "分解"
L["disenchant_desc"] = "当通过'分解'按钮分配物品时使用该理由"
--Translation missing 
-- L["Double click to delete this entry."] = ""
L["DPS"] = "伤害输出"
L["Dropped by:"] = "掉落自："
L["Enable Loot History"] = "启用拾取历史"
L["Enable Timeout"] = "启用超时"
L["enable_loot_history_desc"] = "启用历史记录。如果关闭，RCLootCouncil 将不会记录任何数据。"
L["enable_timeout_desc"] = "勾选以启用拾取窗口的计时器"
L["Enter your note:"] = "输入你的备注："
--Translation missing 
-- L["EQdkp-Plus XML output, tailored for Enjin import."] = ""
L["Everyone have voted"] = "所有人都已投票"
L["Export"] = "导出"
L["Filter"] = "过滤"
L["Following winners was registered:"] = "以下获胜者已被登记："
L["Free"] = "自由支配"
L["From:"] = "来自："
L["g1"] = true
L["g2"] = true
L["General"] = "常规"
L["General options"] = "常规选项"
L["Greed"] = "贪婪"
L["Group"] = "队伍"
L["Group Council Members"] = "队伍议会成员"
L["group_council_members_desc"] = "在此将来自其他服务器或其他公会的成员添加至议会。"
L["group_council_members_head"] = "从当前队伍添加议会成员。"
L["Guild"] = "公会"
L["Guild Council Members"] = "公会议会成员"
L["Healer"] = "治疗"
L["help"] = "帮助"
L["Hide Votes"] = "隐藏投票"
L["hide_votes_desc"] = "直到玩家投票后才能看见投票详情。"
L["history"] = "历史"
L["Ignore List"] = "忽略列表"
L["Ignore Options"] = "忽略选项"
L["ignore_input_desc"] = "输入一个物品ID，将其添加至忽略列表，RCLootCouncil 不再将此物品加入分配列表"
L["ignore_input_usage"] = "此功能仅支持物品ID(数字)"
L["ignore_list_desc"] = "被RCLootCouncil忽略的物品，点击该物品来移除它。"
L["ignore_options_desc"] = "控制RCLootCouncil忽略的物品。如果添加的物品未显示，切到其他标签再切回来，这样你就可以看到了。"
L["ilvl"] = "装等"
L["ilvl: x"] = "装等: %d"
L["Item"] = "物品"
L["Item has been awarded"] = "物品已经被分配"
L["Item received and added from 'player'"] = "物品已收到，来自 %s。"
L["Item(s) replaced:"] = "已被替换的物品："
L["Items under consideration:"] = "在考虑中的物品："
--Translation missing 
-- L["Latest item(s) won"] = ""
--Translation missing 
-- L["leaderUsage_desc"] = ""
--Translation missing 
-- L["Length"] = ""
L["Log"] = "记录"
L["log_desc"] = "启用以在拾取历史中记录"
L["Loot announced, waiting for answer"] = "拾取已发送，等待回应"
L["Loot Everything"] = "全部拾取"
L["Loot History"] = "拾取历史"
L["Loot won:"] = "拾取赢得："
L["loot_everything_desc"] = "开启自动拾取非装备类物品(例如坐骑，套装兑换物)"
L["loot_history_desc"] = [=[RCLootCouncil 将自动记录分配相关信息。
原始数据储存在 ".../SavedVariables/RCLootCouncil.lua"。

注意: 非物品分配者只会储存来自物品分配者发送的数据。
]=]
L["Looted items to award later"] = "拾取物品，稍后再进行分配"
L["Looting options"] = "拾取选项"
L["Lower Quality Limit"] = "最低品质限定"
L["lower_quality_limit_desc"] = [=[选择自动分配时物品的最低品质限定 (含此品质！)。
注意: 这将会更改物品分配界限。]=]
L["Mainspec/Need"] = "主天赋/需求"
L["Master Looter"] = "战利品分配者"
L["master_looter_desc"] = "注意: 这些设置仅供战利品分配者使用。"
L["Message"] = "消息"
L["message_desc"] = "要发送至所选频道的消息。"
L["Minimize in combat"] = "战斗中最小化"
L["Minor Upgrade"] = "较小提升"
L["ML sees voting"] = "物品分配者可见投票"
L["ml_sees_voting_desc"] = "允许物品分配者查看投票详情。"
--Translation missing 
-- L["Modules"] = ""
--Translation missing 
-- L["More Info"] = ""
--Translation missing 
-- L["more_info_desc"] = ""
L["Multi Vote"] = "多选投票"
L["multi_vote_desc"] = "允许多选投票，投票者可以投票给多个可拾取成员。"
L["'n days' ago"] = "%s 前"
L["Name"] = "名字"
L["Need"] = "需求"
L["Never use RCLootCouncil"] = "禁用RCLootCouncil"
L["No"] = "否"
L["No (dis)enchanters found"] = "未发现附魔师"
L["No entries in the Loot History"] = "历史记录中无任何条目"
L["No items to award later registered"] = "没有已记录的'稍后分配'物品"
L["No session running"] = "当前无分配在进行"
L["No winners registered"] = "没有已记录的获胜者"
L["None"] = "没有"
L["Not announced"] = "不通告"
L["Not cached, please reopen."] = "没有获取, 请重新打开."
L["Not Found"] = "未找到"
L["Not installed"] = "未安装"
L["Note"] = "备注"
L["Note: Huge exports will cause lag."] = "注意：导出大量数据可能造成延迟。"
L["Notes"] = "备注"
L["notes_desc"] = "允许可拾取成员向议会发送备注。"
L["Now handles looting"] = "现在管理分配"
L["Number of buttons"] = "按钮个数"
L["Number of reasons"] = "理由个数"
--Translation missing 
-- L["Number of responses"] = ""
L["number_of_buttons_desc"] = "滑动以改变按钮个数。"
L["number_of_reasons_desc"] = "滑动以改变理由个数。"
L["Observe"] = "观察"
L["observe_desc"] = "允许非议会成员查看投票界面，但他们并不能投票。"
L["Officer"] = "官员"
L["Offline or RCLootCouncil not installed"] = "离线或未安装RCLootCouncil"
L["Offspec/Greed"] = "副天赋/贪婪"
--Translation missing 
-- L["Only use in raids"] = ""
--Translation missing 
-- L["onlyUseInRaids_desc"] = ""
L["open"] = "开启"
L["Open the Loot History"] = "打开拾取历史"
L["open_the_loot_history_desc"] = "点击打开拾取历史。"
L["Party"] = "小队"
L["Pass"] = "放弃"
L["'player' has asked you to reroll"] = "%s 要求你重新选择"
L["'player' has ended the session"] = "%s 结束了分配"
L["Raid"] = "团队"
L["Raid Warning"] = "团队警告"
L["Rank"] = "会阶"
--Translation missing 
-- L["Raw lua output. Doesn't work well with date selection."] = ""
L["RCLootCouncil Loot Frame"] = "RCLootCouncil 拾取界面"
L["RCLootCouncil Loot History"] = "RCLootCouncil 拾取历史记录"
L["RCLootCouncil Session Setup"] = "RCLootCouncil 分配设置"
L["RCLootCouncil Version Checker"] = "RCLootCouncil 检查更新"
L["RCLootCouncil Voting Frame"] = "RCLootCouncil 投票界面"
L["Reannounce ..."] = "再次通告..."
L["Reason"] = "理由"
L["reason_desc"] = "自动分配时分配理由将自动添加至拾取历史记录。"
L["Remove All"] = "移除所有"
L["Remove from consideration"] = "从待定中移除"
L["remove_all_desc"] = "移除所有议会成员。"
L["reset"] = "重置"
L["Reset Skin"] = "重置皮肤"
L["Reset skins"] = "重置皮肤"
L["Reset to default"] = "恢复默认设置"
L["reset_announce_to_default_desc"] = "重置所有通告选项"
L["reset_buttons_to_default_desc"] = "重置所有按钮，颜色及其回应。"
L["reset_skin_desc"] = "重置当前皮肤的所有颜色及背景。"
L["reset_skins_desc"] = "重置默认皮肤。"
L["reset_to_default_desc"] = "重置分配理由。"
L["Response"] = "回应"
L["Response color"] = "回应颜色"
L["response_color_desc"] = "为回应设置一种颜色。"
L["Responses from Chat"] = "来自聊天的回应"
L["responses_from_chat_desc"] = [=[如果有人没有安装本插件 (当没有指定的关键字时，使用第1个按钮)。
例如："/w 战利品分配者 [物品] 贪婪" 将自动视为贪婪该物品。
在下方你可以设定每个按钮的关键词。关键词仅支持 A-Z，a-z 与 0-9，其他视为分隔符。
当插件启用时(例如在团队副本中时)，玩家可以通过密语战利品分配者"rchelp"来获取关键词列表。]=]
L["Role"] = "职责"
L["Roll"] = true
L["Save Skin"] = "保存皮肤"
L["save_skin_desc"] = "输入你的皮肤名称，点击'确认'以保存。注意，你可以覆盖任何非默认皮肤。"
L["Say"] = "说"
L["Self Vote"] = "自我投票"
L["self_vote_desc"] = "允许投票者为自己投票。"
L["Send History"] = "发送历史"
L["send_history_desc"] = "发送数据给队伍中所有成员，无论是不是你自己记录的。只有你是战利品分配者时， RCLootCouncil才会发送数据。"
L["Sent whisper help to 'player'"] = "发送密语帮助给 %s"
L["session_error"] = "出现了一些错误 - 请重新开始分配"
L["Set the text for button i's response."] = "设置第 %d 个按钮的回应文本"
L["Set the text on button 'number'"] = "设置第 %i 个按钮上的文本"
L["Set the whisper keys for button i."] = "设置第 %d 个按钮的密语关键词"
L["Silent Auto Pass"] = "静默自动放弃"
L["silent_auto_pass_desc"] = "勾选以隐藏自动放弃信息"
--Translation missing 
-- L["Simple BBCode output."] = ""
L["Skins"] = "皮肤"
L["skins_description"] = "选择一个默认皮肤或自己创建一个。打开版本检查查看效果 ('/rc version')。"
L["Something went wrong :'("] = "出现了一些问题"
--Translation missing 
-- L["Standard .csv output."] = ""
L["Start"] = "开始"
L["Status texts"] = "状态文字"
L["Tank"] = "坦克"
L["Test"] = "测试"
L["test"] = "测试"
L["test_desc"] = "为你以及团队里的所有人进行模拟分配。"
L["Text color"] = "文字颜色"
L["Text for reason #i"] = "理由文本 #"
L["text_color_desc"] = "文字显示时的颜色"
L["The following council members have voted"] = "以下议会成员已投票"
L["The item would now be awarded to 'player'"] = "这件物品现在将分配给 %s"
L["The loot is already on the list"] = "拾取已经在此列表"
L["The Master Looter doesn't allow multiple votes."] = "战利品分配者已禁用多次投票。"
L["The Master Looter doesn't allow votes for yourself."] = "战利品分配者已禁用自我投票。"
L["The session has ended."] = "分配已经结束。"
L["This item"] = "这件物品"
L["This item has been awarded"] = "这件物品已经被分配了"
--Translation missing 
-- L["Tier 19"] = ""
--Translation missing 
-- L["Tier 20"] = ""
--Translation missing 
-- L["Tier tokens received from here:"] = ""
--Translation missing 
-- L["tier_token_heroic"] = ""
--Translation missing 
-- L["tier_token_mythic"] = ""
--Translation missing 
-- L["tier_token_normal"] = ""
--Translation missing 
-- L["Time"] = ""
L["Time left (num seconds)"] = "剩余时间：%d"
L["Timeout"] = "超时"
--Translation missing 
-- L["Tokens received"] = ""
--Translation missing 
-- L["Total awards"] = ""
L["Total items received:"] = "总计收到物品："
L["Total items won:"] = "总计赢得物品："
--Translation missing 
-- L["Totals"] = ""
L["tVersion_outdated_msg"] = "最新的RCLootCouncil版本是：%s"
L["Unable to give 'item' to 'player' - (player offline, left group or instance?)"] = "无法将 %s 分配给 %s - (玩家离线，不在队伍中 或 在副本外？)"
L["Unable to give out loot without the loot window open."] = "拾取窗口关闭时无法分配。"
L["Unguilded"] = "无公会"
L["Unknown"] = "未知"
L["Unknown date"] = "未知日期"
L["Unknown/Chest"] = "未知/箱子"
L["Unvote"] = "未投票"
L["Upper Quality Limit"] = "最高品质限定"
L["upper_quality_limit_desc"] = [=[选择自动分配时物品的最高品质限定 (含此品质！).
注意: 这将会更改物品分配界限。]=]
L["Usage"] = "用法"
--Translation missing 
-- L["Usage Options"] = ""
L["version"] = "版本"
L["Version"] = "版本"
L["Version Check"] = "版本检查"
L["version_check_desc"] = "开启版本检查模块。"
L["version_outdated_msg"] = "当前版本 %s 已经过期. 最新版本为 %s，请升级你的 RCLootCouncil。"
L["Vote"] = "投票"
L["Voters"] = "投票者"
L["Votes"] = "投票"
L["Voting options"] = "投票选项"
L["Waiting for item info"] = "等待物品信息"
L["Waiting for response"] = "等待回应"
L["whisper"] = "密语"
L["whisper_guide"] = "[RCLootCouncil]：用数字回应 [物品1] [物品2]。发送要替换的物品链接与编号，回应为如下关键词：例如 '1 贪婪 [物品1]' 就是贪婪物品1"
L["whisper_guide2"] = "[RCLootCouncil]：如果你被成功添加，你将收到一条确认信息。"
L["whisper_help"] = [=[没有安装插件的团队成员可以使用密语系统.。
密语战利品分配者 "rchelp" 可以获取关键词列表，该列表可以在 "按钮与回应" 选项卡来修改。
建议团长开启 "通告待定"，因为密语系统需要每件物品编号才能使用。
注意: 团员仍然应当安装插件, 否则所有玩家的信息都将不可用。]=]
L["whisperKey_greed"] = "贪婪, 副天赋, os, 2"
L["whisperKey_minor"] = "较小提升, minor, 3"
L["whisperKey_need"] = "需求, 主天赋, ms, 1"
L["Windows reset"] = "窗口重置"
L["winners"] = "获胜者"
L["x days"] = "%d 天"
L["x out of x have voted"] = "%d / %d 已投票"
L["Yell"] = "大喊"
L["Yes"] = "是"
L["You are not allowed to see the Voting Frame right now."] = "你现在无法查看投票界面。"
L["You can only auto award items with a quality lower than 'quality' to yourself due to Blizaard restrictions"] = "由于暴雪的限定，你只能自动分配低于 %s 品质的物品给自己"
L["You cannot initiate a test while in a group without being the MasterLooter."] = "当你在队伍中且无不是战利品分配者时无法开启测试。"
--Translation missing 
-- L["You cannot start an empty session."] = ""
L["You cannot use the menu when the session has ended."] = "你无法使用菜单，因为分配已经结束。"
L["You cannot use this command without being the Master Looter"] = "你无法使用此命令，因为你不是战利品分配者"
L["You can't start a loot session while in combat."] = "战斗中无法开始物品分配。"
L["You can't start a session before all items are loaded!"] = "在所有物品加载完成前，你不能开始物品分配！"
L["You haven't set a council! You can edit your council by typing '/rc council'"] = "你还没有设定议会！你可以输入 '/rc council' 来进行编辑。"
L["Your note:"] = "你的备注："
L["You're already running a session."] = "你已经在进行物品分配了。"

