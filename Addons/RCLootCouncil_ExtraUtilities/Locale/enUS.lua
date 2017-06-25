-- Translate RCLootCouncil - ExtraUtilities to your language at:
-- http://wow.curseforge.com/addons/rclootcouncil-extrautilities/localization/

-- Default english translation
local L = LibStub("AceLocale-3.0"):NewLocale("RCExtraUtilities", "enUS", true)
if not L then return end

L["Advanced"] = true
L["Accept Pawn"] = true
L["Artifact Traits"] = true
L["Bonus"] = true
L["Bonus Rolls"] = true
L["Class"] = true
L["column_width_desc"] = "Chose the width of the %s column."
L["extra_util_desc"] = "RCLootCouncil - Extra Utilities |cFF87CEFAv %s |r.\nNote: these settings are not shared with the group, so each council member can have different settings."
L["Extra Utilities Columns"] = true
L["Forged"] = true
L["GuildNote"] = true
L["Guild Notes"] = true
L["ilvl Decimals"] = true
L["ilvl Upg."] = true
L["ilvl Upgrades"] = true
L["Legendaries"] = true
L["Officer Note"] = true
L["Open Voting Frame"] = true
L["Other"] = true
L["Pawn specific options"] = true
L["RCLootCouncil Columns"] = true
L["Scales"] = true
L["Score Mode"] = "Raw Score"
L["Set Pieces"] = true
L["Sockets"] = true
L["Spec Icon"] = true
L["Traits"] = true
L["Upgrades"] = true
L["You can't change these settings while the voting frame is showing."] = true


L["opt_acceptPawn_desc"] = "Enables candidates to calculate and send their own Pawn scores instead of relying on you to keep your own scales up to date."
L["opt_pawn_desc"] = "Enables a Pawn column, showing upgrade statistics for the candidate."
L["opt_pawnMode_desc"] = "Enabling this will display the raw Pawn scores, while disabling will result in upgrade percentage scores."
L["opt_traits_desc"] = "Enables a column showing the number of artifact traits a candidate has."
L["opt_upgrades_desc"] = "Enables a column showing x of y valor upgrades a candidate has performed."
L["opt_sockets_desc"] = "Enables a column showing how many sockets a candidate has on his/her equipped gear."
L["opt_setpieces_desc"] = "Enables a column showing the number of set pieces the candidate has equipped."
L["opt_forged_desc"] = "Enables a column showing how many Titan-/Warforged items the cancidate has equipped."
L["opt_legendaries_desc"] = "Enables a column showing how many legendaries the candidate has equipped."
L["opt_ilvlupgrades_desc"] = "Enables a column showing the total ilvls a candidate have optained through item upgrades. It's basicly the 'Upgrade' option put into actual ilvls."
L["opt_bonusRoll_desc"] = "Enables a column showing a candidate's bonus roll, if any."
L["opt_guildNotes_desc"] = "Enables a column showing a candidate's Guild and Officer notes, if any and you're allowed to see them."
L["opt_normalcolumn_desc"] = "Enables the %s column from RCLootCouncil."
L["opt_pawn_warning"] = "You cannot activate Pawn column with having installed Pawn."
L["opt_ilvldecimals_desc"] = "Check to show a more accurate ilvl in the ilvl column."
L["opt_specIcon_desc"] = "Enables a column showing a candidate's specialization."
L["opt_scalesGroup_desc"] = "Here you can change the Pawn scales RCLootCouncil uses. You can edit these scales through Pawn (/pawn). Note the scale weights are forced to be normalized. You should do a /reload if you recently created a new scale.\n"
L["opt_advanced_desc"] = "Here you can change the position and width of the columns.\nPositions accepts both positive (indicating which order a column should come in) and negative (how far from the end) numbers.\nClick the button to open the voting frame and see your changes right away. When things start to look funny, just do a /reload to refresh all the icons.\nNote: There's no quarantee of the order if several columns share the same index once calculated. Just do a /reload to check the permanent changes.\n"
L["opt_advReset_desc"] = "Resets all positions and widths to default."
L["opt_position_desc"] = "Change the position of the %s column"
L["opt_ep_desc"] = "Enables a column showing the candidates EP values as gathered from EPGP."
L["opt_gp_desc"] = "Enables a column showing the candidate's GP values as gathered from EPGP."
L["opt_pr_desc"] = "Enables a column showing PR values, calculated as EP / GP."

L["opt_position_usage"] = "Accepts postive and negative numbers only."
L["opt_addon_requirement"] = "needs to be installed and enabled to use this option."
