local L = setmetatable({},{ __index = function(self, key) return key end })
select(2, ...).L = L

if GetLocale() == "zhCN" or GetLocale == "zhTW" then
    L["Sort Quests"] = "任务排序"
    L["Sort quest watches by distance of objectives. This was done by SortQuestWatches() before 7.0 which is broken currently."]
        = "按照任务远近排序。\n\n7.0之前系统自带此功能，但目前因暴雪问题导致失效。\n网易有爱携warbaby提供解决方案"
end