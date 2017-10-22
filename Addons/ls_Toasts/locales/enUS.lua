﻿-- Contributors:

local _, addonTable = ...

-- Lua
local _G = getfenv(0)

-- Mine
local L = {}
addonTable.L = L

L["ACHIEVEMENT_PROGRESSED"] = _G.ACHIEVEMENT_PROGRESSED
L["ACHIEVEMENT_UNLOCKED"] = _G.ACHIEVEMENT_UNLOCKED
L["BLIZZARD_STORE_PURCHASE_DELIVERED"] = _G.BLIZZARD_STORE_PURCHASE_COMPLETE
L["CANCEL"] = _G.CANCEL
L["DELETE"] = _G.DELETE
L["DIGSITE_COMPLETED"] = _G.ARCHAEOLOGY_DIGSITE_COMPLETE_TOAST_FRAME_TITLE
L["DUNGEON_COMPLETED"] = _G.DUNGEON_COMPLETED
L["ENABLE"] = _G.ENABLE
L["ENABLE_SOUND"] = _G.ENABLE_SOUND
L["GARRISON_MISSION_ADDED"] = _G.GARRISON_MISSION_ADDED_TOAST1
L["GARRISON_MISSION_COMPLETED"] = _G.GARRISON_MISSION_COMPLETE
L["GARRISON_NEW_BUILDING"] = _G.GARRISON_UPDATE
L["GARRISON_NEW_TALENT"] = _G.GARRISON_TALENT_ORDER_ADVANCEMENT
L["GENERAL"] = _G.GENERAL_LABEL
L["HONOR_POINTS"] = _G.HONOR_POINTS
L["ITEM_LEGENDARY"] = _G.LEGENDARY_ITEM_LOOT_LABEL
L["ITEM_UPGRADED"] = _G.ITEM_UPGRADED_LABEL
L["ITEM_UPGRADED_FORMAT"] = _G.LOOTUPGRADEFRAME_TITLE:format("%s%s|r")
L["LOOT_THRESHOLD"] = _G.LOOT_THRESHOLD
L["LS_TOASTS"] = "ls: |cff1a9fc0Toasts|r"
L["NEW_PROFILE"] = _G.NEW_COMPACT_UNIT_FRAME_PROFILE
L["OKAY"] = _G.OKAY
L["RECIPE_LEARNED"] = _G.NEW_RECIPE_LEARNED_TITLE
L["RECIPE_UPGRADED"] = _G.UPGRADED_RECIPE_LEARNED_TITLE
L["RELOADUI"] = _G.RELOADUI
L["RESET"] = _G.RESET
L["SCENARIO_COMPLETED"] = _G.SCENARIO_COMPLETED
L["SCENARIO_INVASION_COMPLETED"] = _G.SCENARIO_INVASION_COMPLETE
L["SETTINGS_GENERAL_LABEL"] = _G.GENERAL_LABEL
L["WORLD_QUEST_COMPLETED"] = _G.WORLD_QUEST_COMPLETE
L["XP_FORMAT"] = _G.BONUS_OBJECTIVE_EXPERIENCE_FORMAT
L["YOU_EARNED"] = _G.YOU_EARNED_LABEL
L["YOU_RECEIVED"] = _G.YOU_RECEIVED_LABEL
L["YOU_WON"] = _G.YOU_WON_LABEL

-- Require translation
L["ANCHOR"] = "Toast Anchor"
L["ANCHOR_FRAME"] = "Anchor Frame"
L["BORDER"] = "Border"
L["COLORS"] = "Colours"
L["COPPER_THRESHOLD"] = "Copper Threshold"
L["COPPER_THRESHOLD_DESC"] = "Min amount of copper to create a toast for."
L["DND"] = "DND"
L["DND_TOOLTIP"] = "Toasts in DND mode won't be displayed in combat, but will be queued up in the system. Once you leave combat, they'll start popping up."
L["FADE_OUT_DELAY"] = "Fade Out Delay"
L["GROWTH_DIR"] = "Growth Direction"
L["GROWTH_DIR_DOWN"] = "Down"
L["GROWTH_DIR_LEFT"] = "Left"
L["GROWTH_DIR_RIGHT"] = "Right"
L["GROWTH_DIR_UP"] = "Up"
L["ICON_BORDER"] = "Icon Border"
L["NAME"] = "Name"
L["OPEN_CONFIG"] = "Open Config"
L["SCALE"] = "Scale"
L["SETTINGS_TYPE_LABEL"] = "Toast Types"
L["SHOW_ILVL"] = "Show iLvl"
L["SHOW_ILVL_DESC"] = "Show item level next to item name."
L["SHOW_QUEST_ITEMS"] = "Show Quest Items"
L["SHOW_QUEST_ITEMS_DESC"] = "Show quest items regardless of their quality."
L["SKIN"] = "Skin"
L["STRATA"] = "Strata"
L["TEST"] = "Test"
L["TEST_ALL"] = "Test All"
L["TOAST_NUM"] = "Number of Toasts"
L["TRANSMOG_ADDED"] = "Appearance Added"
L["TRANSMOG_REMOVED"] = "Appearance Removed"
L["TYPE_ACHIEVEMENT"] = "Achievement"
L["TYPE_ARCHAEOLOGY"] = "Archaeology"
L["TYPE_CLASS_HALL"] = "Class Hall"
L["TYPE_COLLECTION"] = "Collection"
L["TYPE_COLLECTION_DESC"] = "Toasts for newly collected mounts, pets and toys."
L["TYPE_DUNGEON"] = "Dungeon"
L["TYPE_GARRISON"] = "Garrison"
L["TYPE_LOOT_COMMON"] = "Loot (Common)"
L["TYPE_LOOT_COMMON_DESC"] = "Toasts triggered by chat events, e.g. greens, blues, some epics, everything that isn't handled by special loot toasts."
L["TYPE_LOOT_CURRENCY"] = "Loot (Currency)"
L["TYPE_LOOT_GOLD"] = "Loot (Gold)"
L["TYPE_LOOT_SPECIAL"] = "Loot (Special)"
L["TYPE_LOOT_SPECIAL_DESC"] = "Toasts triggered by special loot events, e.g. won rolls, legendary drops, personal loot, etc."
L["TYPE_RECIPE"] = "Recipe"
L["TYPE_TRANSMOG"] = "Transmogrification"
L["TYPE_WORLD_QUEST"] = "World Quest"
