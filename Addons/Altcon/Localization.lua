---------------------------------------------------------
-- Localization.lua
--
-- Abin
---------------------------------------------------------

local _, addon = ...

addon.L = {
	["title"] = "Altcon",
	["delete confirm"] = "Delete data for |cff00ff00 %s |r, are you sure?",
	["click to open frame"] = "Click to open the frame",
	["show minimap button"] = "Show minimap button",
}

if GetLocale() == "zhCN" then
	addon.L = {
		["title"] = "Altcon - 小号控",
		["delete confirm"] = "删除|cff00ff00 %s |r保存的数据，确定吗？",
		["click to open frame"] = "点击打开框体",
		["show minimap button"] = "显示小地图按钮",
	}
end

if GetLocale() == "zhTW" then
	addon.L = {
		["title"] = "Altcon - 小隻控",
		["delete confirm"] = "刪除|cff00ff00 %s |r保存的數據，確定嗎？",
		["click to open frame"] = "點擊打開框體",
		["show minimap button"] = "顯示小地圖按鈕",
	}
end