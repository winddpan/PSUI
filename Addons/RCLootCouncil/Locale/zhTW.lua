-- Translate RCLootCouncil to your language at:
-- http://wow.curseforge.com/addons/rclootcouncil/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("RCLootCouncil", "zhTW")
if not L then return end

L[" is not active in this raid."] = "並未啓用於此團隊"
L[" you are now the Master Looter and RCLootCouncil is now handling looting."] = "你現在是分裝者，RCLootCouncil開始管理分配"
L["&p was awarded with &i for &r!"] = "&i分配給&p (&r)"
--Translation missing 
-- L["A format to copy/paste to another player."] = ""
L["A new session has begun, type '/rc open' to open the voting frame."] = "新的分配已經開始，輸入/rc open 開啟投票介面"
--Translation missing 
-- L["A tab delimited output for Excel. Might work with other spreadsheets."] = ""
--Translation missing 
-- L["A tab delimited output for Excel. Might work with outher spreadsheets."] = ""
L["Abort"] = "中止"
L["Accept Whispers"] = "接受密語"
L["accept_whispers_desc"] = "允許玩家密語物品給你，讓你添加到投票"
L["Acknowledged as 'response'"] = "已確認 \" %s \""
L["Active"] = "啓用"
L["active_desc"] = "取消勾選此項以停用RCLootCouncil，適用於你在團隊中但是並未參與活動時。每次登出都會重置這個選項"
L["add"] = "添加"
L["Add Item"] = "添加物品"
L["Add Note"] = "添加筆記"
L["Add ranks"] = "添加階級"
L["Add rolls"] = "添加擲骰"
L["add_ranks_desc"] = "選擇可拾取成員的最低階級"
L["add_ranks_desc2"] = [=[

從上方選擇一個階級，添加所有大於等於此階級的會員為可拾取成員

點擊左側階級，添加獨立玩家為可拾取成員

點擊"目前分配組"分頁來查看所有可拾取成員]=]
L["All items"] = "所有物品"
L["All items has been awarded and  the loot session concluded"] = "所有物品已分配完成，總結分配"
L["Alt click Looting"] = "按Alt拾取"
L["alt_click_looting_desc"] = "啓用Alt鍵拾取 (按住Alt，左鍵點擊物品開始分配)"
L["Alternatively, flag the loot as award later."] = "額外，標記掉落物稍後分配"
L["Always use RCLootCouncil when I'm Master Looter"] = "擁有分配權時，總是使用"
L["Always use when leader"] = "身為隊長時，總是使用"
L["Announce Awards"] = "通知分配"
L["Announce Considerations"] = "通知待決定"
L["announce_awards_desc"] = "啟用聊天分配通知"
L["announce_awards_desc2"] = [=[
選擇通知頻道
&p - 玩家ID
&i - 物品
&r - 理由]=]
L["announce_considerations_desc"] = "當分配開始時通知待決定物品"
L["announce_considerations_desc2"] = [=[
選擇你想通知的頻道和訊息]=]
L["Announcements"] = "通知"
L["Anonymous Voting"] = "匿名投票"
L["anonymous_voting_desc"] = "啓用匿名投票"
--Translation missing 
-- L["Appearance"] = ""
--Translation missing 
-- L["Append realm names"] = ""
L["Are you sure you want to abort?"] = "確定中止分配？"
L["Are you sure you want to give #item to #player?"] = "確定將%s分配給%s？"
--Translation missing 
-- L["Armor Token"] = ""
L["Ask me every time I become Master Looter"] = "擁有分配權時，總是詢問"
L["Ask me when leader"] = "身為隊長時，總是詢問"
L["Auto Award"] = "自動分配"
L["Auto Award to"] = "自動分配給"
L["Auto awarded 'item'"] = "自動分配%s"
--Translation missing 
-- L["Auto Close"] = ""
L["Auto Enable"] = "自動啓用"
L["Auto Loot"] = "自動拾取"
L["Auto Open"] = "自動開啓"
L["Auto Pass"] = "自動放棄"
L["Auto pass BoE"] = "自動放棄裝綁"
L["Auto Start"] = "自動開始"
L["auto_award_desc"] = "啓用自動分配"
L["auto_award_to_desc"] = "自動獲得物品的玩家"
--Translation missing 
-- L["auto_close_desc"] = ""
L["auto_enable_desc"] = "總是允許RCLootCouncil 管理拾取。不勾每次加入隊伍或獲得分裝權時都會詢問"
L["auto_loot_desc"] = "啓用自動拾取所有可裝備物品"
L["auto_open_desc"] = "自動開啟分配界面。不勾也可輸入/rc open 手動開啟但需要分裝者授權"
L["auto_pass_boe_desc"] = "自動放棄裝備綁定物品"
L["auto_pass_desc"] = "自動放棄你不能用的物品"
L["auto_start_desc"] = "啓用自動開始分配，取消將會在每次分配前顯示物品列表"
L["Autoloot BoE"] = "自動拾取裝綁"
L["autoloot_BoE_desc"] = "啓用自動拾取裝綁物品"
L["Autopass"] = "自動放棄"
L["Autopassed on 'item'"] = "自動放棄%s"
L["Autostart isn't supported when testing"] = "無法在測試中自動分配"
L["award"] = "獎勵"
L["Award"] = "分配"
L["Award Announcement"] = "通知分配"
L["Award for ..."] = "分配爲..."
L["Award later?"] = "稍後分配?"
L["Award Reasons"] = "分配理由"
L["award_reasons_desc"] = [=[用於自動分配時右鍵選單中
擲骰時無法選擇分配理由]=]
L["Awards"] = "分配"
--Translation missing 
-- L["Background"] = ""
--Translation missing 
-- L["Background Color"] = ""
L["Banking"] = "收藏"
--Translation missing 
-- L["BBCode export, tailored for SMF."] = ""
--Translation missing 
-- L["Border"] = ""
--Translation missing 
-- L["Border Color"] = ""
L["Button"] = "按鈕"
L["Buttons and Responses"] = "按鈕和回應"
L["buttons_and_responses_desc"] = "設定團隊拾取介面的回應按鈕"
L["Cancel"] = "取消"
L["Candidate didn't respond on time"] = "可拾取成員沒有及時回應"
L["Candidate has disabled RCLootCouncil"] = "可拾取成員禁用了RCLootCouncil"
--Translation missing 
-- L["Candidate is not in the instance"] = ""
L["Candidate is selecting response, please wait"] = "可拾取成員正在回應，請稍候"
L["Candidate removed"] = "移除可拾取成員"
L["Cannot autoaward:"] = "無法自動分配："
L["Cannot give 'item' to 'player' due to Blizzard limitations. Gave it to you for distribution."] = "由於暴雪限制，你無法將%s分配給%s"
L["Change Response"] = "更改回應"
L["Changing loot threshold to enable Auto Awarding"] = "更改拾取品質以啟用自動分配"
L["Changing LootMethod to Master Looting"] = "分配方式更改爲隊長分配"
L["Channel"] = "頻道"
L["channel_desc"] = "發送信息的頻道"
L["chat tVersion string"] = "|cFF87CEFARCLootCouncil |cFFFFFFFF版本 |cFFFFA500 %s - %s"
L["chat version String"] = "|cFF87CEFARCLootCouncil |cFFFFFFFF版本 |cFFFFA500 %s"
L["chat_commands"] = [=[
- config - 開啟設定介面 
- council - 開啟分配介面 
- history/h/his - 開啟拾取歷史
- version/v/ver - 檢查更新
- open - 開啟投票介面 
- reset - 重置介面位置 
- test # - 模擬分配#件物品 (不輸入#默認爲1件) 
- whisper - 顯示密語幫助
- add [物品] - 添加一件物品到分配介面 
- award - 分配包裡已拾取的物品
- winners - 顯示贏得分配的玩家]=]
L["Check this to loot the items and distribute them later."] = "點擊拾取物品稍後分配"
--Translation missing 
-- L["Check to append the realmname of a player from another realm"] = ""
L["Check to have all frames minimize when entering combat"] = "進入戰鬥時最小化"
--Translation missing 
-- L["Choose timeout length in seconds"] = ""
L["Choose when to use RCLootCouncil"] = "選擇何時使用RCLootCouncil"
L["Clear Loot History"] = "清除拾取歷史"
--Translation missing 
-- L["Clear Selection"] = ""
L["clear_loot_history_desc"] = "刪除全部拾取歷史"
L["Click to add note to send to the council."] = "點擊增加發送筆記"
L["Click to expand/collapse more info"] = "點擊展開/收起"
L["Click to switch to 'item'"] = "點擊切換為%s"
L["Close"] = "關閉"
L["config"] = "設定"
L["confirm_usage_text"] = [=[|cFF87CEFA RCLootCouncil |r 

是否在此隊伍使用RCLootCouncil?]=]
L["Could not Auto Award i because the Loot Threshold is too high!"] = "無法自動分配%s 因為拾取門欄過高"
L["Could not find 'player' in the group."] = "隊伍中無法找到%s"
--Translation missing 
-- L["Couldn't find any councilmembers in the group"] = ""
L["council"] = "可分配"
L["Council"] = "分配組"
L["Current Council"] = "目前分配組"
L["current_council_desc"] = [=[
點擊將特定玩家從可拾取成員中移除]=]
--Translation missing 
-- L["Customize appearance"] = ""
--Translation missing 
-- L["customize_appearance_desc"] = ""
--Translation missing 
-- L["Date"] = ""
L["days and x months"] = "%s，%d月"
L["days, x months, y years"] = "%s，%d月和%d年"
--Translation missing 
-- L["Delete Skin"] = ""
--Translation missing 
-- L["delete_skin_desc"] = ""
L["Deselect responses to filter them"] = "取消回應以過濾"
L["Diff"] = "差異"
L["Disenchant"] = "分解"
L["disenchant_desc"] = "當你經由分解按鈕贏得物品時使用這個理由"
--Translation missing 
-- L["Double click to delete this entry."] = ""
L["DPS"] = "輸出"
--Translation missing 
-- L["Dropped by:"] = ""
L["Enable Loot History"] = "啓用拾取歷史"
--Translation missing 
-- L["Enable Timeout"] = ""
L["enable_loot_history_desc"] = "啓用拾取歷史。如果關閉RCLootCouncil 將不會記錄任何數據。"
--Translation missing 
-- L["enable_timeout_desc"] = ""
L["Enter your note:"] = "輸入你的筆記："
--Translation missing 
-- L["EQdkp-Plus XML output, tailored for Enjin import."] = ""
--Translation missing 
-- L["Everyone have voted"] = ""
--Translation missing 
-- L["Export"] = ""
L["Filter"] = "過濾"
L["Following winners was registered:"] = "下個贏家已登記："
L["Free"] = "自由拾取"
--Translation missing 
-- L["From:"] = ""
L["g1"] = "1"
L["g2"] = "2"
L["General"] = "一般"
L["General options"] = "一般選項"
L["Greed"] = "貪婪"
L["Group"] = "隊伍"
L["Group Council Members"] = "隊伍分配者"
L["group_council_members_desc"] = "添加其他伺服器或其他公會的可拾取成員"
L["group_council_members_head"] = "從目前隊伍添加可拾取成員"
L["Guild"] = "公會"
L["Guild Council Members"] = "公會分配者"
L["Healer"] = "治療"
L["help"] = "幫助"
L["Hide Votes"] = "隱藏投票"
L["hide_votes_desc"] = "隱藏投票數直到有人投票"
L["history"] = "歷史"
L["Ignore List"] = "忽略列表"
L["Ignore Options"] = "忽略選項"
L["ignore_input_desc"] = "輸入一個物品ID 將其添加至忽略列表, RCLootCouncil 永遠不會將此物品加入分配"
L["ignore_input_usage"] = "只接受物品ID(數字)"
L["ignore_list_desc"] = "物品已被RCLootCouncil忽略，點擊物品來移除。"
L["ignore_options_desc"] = "控制RCLootCouncil忽略的物品。 如果添加的物品未找到，請切到其他介面, 然後返回，這樣你就可以看到了。"
L["ilvl"] = "ilv"
L["ilvl: x"] = "ilv: %d"
L["Item"] = "物品"
L["Item has been awarded"] = "物品已分配"
L["Item received and added from 'player'"] = "物品已收到，來自%s"
--Translation missing 
-- L["Item(s) replaced:"] = ""
L["Items under consideration:"] = "待決定的物品："
--Translation missing 
-- L["Latest item(s) won"] = ""
--Translation missing 
-- L["leaderUsage_desc"] = ""
--Translation missing 
-- L["Length"] = ""
L["Log"] = "日誌"
L["log_desc"] = "啓用拾取歷史記錄"
L["Loot announced, waiting for answer"] = "拾取已發送，正在等待回應"
L["Loot Everything"] = "拾取全部"
L["Loot History"] = "拾取歷史"
--Translation missing 
-- L["Loot won:"] = ""
L["loot_everything_desc"] = "啓用自動拾取非裝備物品(坐騎、兌換物)"
L["loot_history_desc"] = [=[RCLootCouncil 將自動記錄分配相關訊息
原始數據儲存於".../SavedVariables/RCLootCouncil.lua" 

注意: 非分裝者只能記錄來自分裝者發送的數據]=]
L["Looted items to award later"] = "拾取物品稍後分配"
L["Looting options"] = "拾取選項"
L["Lower Quality Limit"] = "最低品質"
L["lower_quality_limit_desc"] = "選擇自動分配時物品的最低品質"
L["Mainspec/Need"] = "主天賦/需求"
L["Master Looter"] = "分裝者"
L["master_looter_desc"] = "注意: 這些設置僅供分裝者使用"
L["Message"] = "訊息"
L["message_desc"] = "訊息已發送至所選頻道"
L["Minimize in combat"] = "戰鬥中最小化"
L["Minor Upgrade"] = "小提升"
L["ML sees voting"] = "分裝者可見投票"
L["ml_sees_voting_desc"] = "允許分裝者查看投票詳情"
--Translation missing 
-- L["Modules"] = ""
--Translation missing 
-- L["More Info"] = ""
--Translation missing 
-- L["more_info_desc"] = ""
L["Multi Vote"] = "多選投票"
L["multi_vote_desc"] = "允許投票者可以投給多個可拾取成員"
--Translation missing 
-- L["'n days' ago"] = ""
L["Name"] = "名字"
L["Need"] = "需求"
L["Never use RCLootCouncil"] = "禁用RCLootCouncil"
L["No"] = "否"
L["No (dis)enchanters found"] = "團隊中沒人會分解"
--Translation missing 
-- L["No entries in the Loot History"] = ""
L["No items to award later registered"] = "沒有物品登記"
L["No session running"] = "目前沒有分配進行中"
L["No winners registered"] = "沒有贏家登記"
L["None"] = "無"
--Translation missing 
-- L["Not announced"] = ""
L["Not cached, please reopen."] = "沒有獲取，請重新打開"
L["Not Found"] = "沒找到"
L["Not installed"] = "沒安裝"
L["Note"] = "筆記"
--Translation missing 
-- L["Note: Huge exports will cause lag."] = ""
L["Notes"] = "筆記"
L["notes_desc"] = "允許可拾取成員發送筆記"
--Translation missing 
-- L["Now handles looting"] = ""
L["Number of buttons"] = "按鈕數量"
L["Number of reasons"] = "理由數量"
--Translation missing 
-- L["Number of responses"] = ""
L["number_of_buttons_desc"] = "滑動以改變按鍵數量"
L["number_of_reasons_desc"] = "滑動以改變理由數量"
L["Observe"] = "觀察"
L["observe_desc"] = "如果開啟, 非可拾取成員可以看到分配介面, 但他們不能投票"
L["Officer"] = "幹部"
L["Offline or RCLootCouncil not installed"] = "離線/沒有安裝插件"
L["Offspec/Greed"] = "副天賦/貪婪"
--Translation missing 
-- L["Only use in raids"] = ""
--Translation missing 
-- L["onlyUseInRaids_desc"] = ""
L["open"] = "開啓"
L["Open the Loot History"] = "開啟拾取歷史"
L["open_the_loot_history_desc"] = "打開拾取歷史"
L["Party"] = "小隊"
L["Pass"] = "放棄"
--Translation missing 
-- L["'player' has asked you to reroll"] = ""
L["'player' has ended the session"] = "%s結束了分配"
L["Raid"] = "團隊"
L["Raid Warning"] = "團隊警告"
L["Rank"] = "階級"
--Translation missing 
-- L["Raw lua output. Doesn't work well with date selection."] = ""
L["RCLootCouncil Loot Frame"] = "RCLootCouncil 拾取介面"
--Translation missing 
-- L["RCLootCouncil Loot History"] = ""
L["RCLootCouncil Session Setup"] = "RCLootCouncil 分配設定"
L["RCLootCouncil Version Checker"] = "RCLootCouncil 檢查更新"
L["RCLootCouncil Voting Frame"] = "RCLootCouncil 投票介面"
L["Reannounce ..."] = "再次通知..."
L["Reason"] = "理由"
L["reason_desc"] = "自動分配時分配理由將記錄在拾取歷史"
L["Remove All"] = "移除全部"
L["Remove from consideration"] = "從待決定中移除"
L["remove_all_desc"] = "移除所有可拾取成員"
L["reset"] = "重置"
--Translation missing 
-- L["Reset Skin"] = ""
--Translation missing 
-- L["Reset skins"] = ""
L["Reset to default"] = "恢復爲預設"
L["reset_announce_to_default_desc"] = "重置所有通知選項"
L["reset_buttons_to_default_desc"] = "重置所有按鍵、顏色和回應"
--Translation missing 
-- L["reset_skin_desc"] = ""
--Translation missing 
-- L["reset_skins_desc"] = ""
L["reset_to_default_desc"] = "重置分配理由"
L["Response"] = "回應"
L["Response color"] = "回應顏色"
L["response_color_desc"] = "為回應設置一種顏色"
L["Responses from Chat"] = "聊天頻道回應"
L["responses_from_chat_desc"] = [=[如果有人沒裝插件，他可以密分裝者 "rchelp" 來得知關鍵字列表
ex: /w 分裝者ID [裝備] 需求]=]
L["Role"] = "角色"
L["Roll"] = "擲骰"
--Translation missing 
-- L["Save Skin"] = ""
--Translation missing 
-- L["save_skin_desc"] = ""
L["Say"] = "說"
L["Self Vote"] = "自我投票"
L["self_vote_desc"] = "允許投票者投給他自己"
L["Send History"] = "發送歷史"
L["send_history_desc"] = "發送數據給隊伍中所有成員。只有你是分裝者RCLootCouncil 才會發送數據"
L["Sent whisper help to 'player'"] = "發送密語幫助給%s"
L["session_error"] = "出現了一些錯誤 - 請重新分配"
L["Set the text for button i's response."] = "設定回應按鈕%d的文字"
L["Set the text on button 'number'"] = "設置按鍵文字%i"
--Translation missing 
-- L["Set the whisper keys for button i."] = ""
L["Silent Auto Pass"] = "隱藏自動放棄"
L["silent_auto_pass_desc"] = "隱藏自動放棄信息"
--Translation missing 
-- L["Simple BBCode output."] = ""
--Translation missing 
-- L["Skins"] = ""
--Translation missing 
-- L["skins_description"] = ""
L["Something went wrong :'("] = "出現了一些問題 哭哭"
--Translation missing 
-- L["Standard .csv output."] = ""
L["Start"] = "開始"
L["Status texts"] = "狀態文字"
L["Tank"] = "坦克"
L["Test"] = "測試"
L["test"] = "測試"
L["test_desc"] = "為所有人開啟模擬分配"
L["Text color"] = "文字顏色"
L["Text for reason #i"] = "輸入理由"
L["text_color_desc"] = "文字顯示顏色"
--Translation missing 
-- L["The following council members have voted"] = ""
L["The item would now be awarded to 'player'"] = "這件物品現在將分配給%s"
L["The loot is already on the list"] = "掉落物已經在列表"
L["The Master Looter doesn't allow multiple votes."] = "分裝者禁用多選投票"
L["The Master Looter doesn't allow votes for yourself."] = "分裝者禁用自我投票"
L["The session has ended."] = "分配已結束"
L["This item"] = "這件物品"
L["This item has been awarded"] = "這件物品已分配"
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
--Translation missing 
-- L["Time left (num seconds)"] = ""
--Translation missing 
-- L["Timeout"] = ""
--Translation missing 
-- L["Tokens received"] = ""
--Translation missing 
-- L["Total awards"] = ""
--Translation missing 
-- L["Total items received:"] = ""
--Translation missing 
-- L["Total items won:"] = ""
--Translation missing 
-- L["Totals"] = ""
L["tVersion_outdated_msg"] = "最新的RCLootCouncil版本是：%s"
L["Unable to give 'item' to 'player' - (player offline, left group or instance?)"] = "無法將%s分配給%s"
L["Unable to give out loot without the loot window open."] = "拾取視窗關閉時無法分配"
L["Unguilded"] = "無公會"
L["Unknown"] = "未知"
--Translation missing 
-- L["Unknown date"] = ""
L["Unknown/Chest"] = "未知"
L["Unvote"] = "未投票"
L["Upper Quality Limit"] = "最高品質"
L["upper_quality_limit_desc"] = "選擇自動分配時物品的最高品質"
L["Usage"] = "使用"
--Translation missing 
-- L["Usage Options"] = ""
L["version"] = "版本"
L["Version"] = "版本"
L["Version Check"] = "版本檢查"
L["version_check_desc"] = "開啓版本檢查模組"
L["version_outdated_msg"] = "你的版本%s已經過期。最新版本為%s，請升級你的RCLootCouncil"
L["Vote"] = "投票"
L["Voters"] = "投票者"
L["Votes"] = "投票"
L["Voting options"] = "投票選項"
L["Waiting for item info"] = "等待物品訊息"
L["Waiting for response"] = "等待回應"
L["whisper"] = "密語"
--Translation missing 
-- L["whisper_guide"] = ""
L["whisper_guide2"] = "[RCLootCouncil]: 如果你被成功添加，你將收到一條確認訊息。"
L["whisper_help"] = [=[沒有安裝插件的團員可以使用密語系統
可以密分裝者 "rchelp" 讓他彈出回應列表，而列表可以在"按鈕和回應"選項裡編輯
建議分裝者開啟"通知待決定" 並且密語系統需要使用物品ID
注意: 分裝者必需要安裝插件，否則所有團員的訊息都將無效]=]
L["whisperKey_greed"] = "貪婪, 副天賦, os, 2"
L["whisperKey_minor"] = "小提升, minor, 3"
L["whisperKey_need"] = "需求, 主天賦, ms, 1"
L["Windows reset"] = "視窗重置"
L["winners"] = "贏家"
L["x days"] = "%d天"
--Translation missing 
-- L["x out of x have voted"] = ""
L["Yell"] = "大喊"
L["Yes"] = "是"
L["You are not allowed to see the Voting Frame right now."] = "你現在無法查看分配介面"
L["You can only auto award items with a quality lower than 'quality' to yourself due to Blizaard restrictions"] = "由於暴雪限制，你只能自動分配低於%s品質的物品給自己"
L["You cannot initiate a test while in a group without being the MasterLooter."] = "你無法在隊伍中且無分配權的狀態下做測試"
--Translation missing 
-- L["You cannot start an empty session."] = ""
L["You cannot use the menu when the session has ended."] = "你無法使用menu，因為分配已經結束。"
L["You cannot use this command without being the Master Looter"] = "你不能使用這個命令，因為你不是分裝者"
L["You can't start a loot session while in combat."] = "戰鬥中無法分配"
--Translation missing 
-- L["You can't start a session before all items are loaded!"] = ""
L["You haven't set a council! You can edit your council by typing '/rc council'"] = "你還沒有設定分配 輸入 /rc council 來進行編輯"
L["Your note:"] = "你的筆記："
L["You're already running a session."] = "你正在進行分配"

