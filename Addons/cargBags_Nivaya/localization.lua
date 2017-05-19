cBnivL = {}
local gl = GetLocale()

function LocalizeStr(str)
	local i, j
	local s = cBnivL[str]
	if s ~= nil then
		return s
	end
	
	i, j = string.find(str, "- .*")
	if i and j and j-i >= 2 then
		s = string.sub(str, i+2, j)
		s = cBnivL[s]
		if s ~= nil then
			str = string.sub(str, 0, i+1)..s
		end
	end
	return str
end

cBnivL.Search = SEARCH
cBnivL.Armor = GetItemClassInfo(4)
cBnivL.BattlePet = GetItemClassInfo(17)
cBnivL.Consumables = GetItemClassInfo(0)
cBnivL.Gem = GetItemClassInfo(3)
cBnivL.Quest = GetItemClassInfo(12)
cBnivL.Trades = GetItemClassInfo(7)
cBnivL.Weapon = GetItemClassInfo(2)
cBnivL.ArtifactPower = ARTIFACT_POWER

cBnivL.bagCaptions = {
	["cBniv_Bank"] 			= BANK,
	["cBniv_BankReagent"]	= REAGENT_BANK,
	["cBniv_BankSets"]		= LOOT_JOURNAL_ITEM_SETS,
	["cBniv_BankArmor"]		= BAG_FILTER_EQUIPMENT,
	["cBniv_BankGem"]		= AUCTION_CATEGORY_GEMS,
	["cBniv_BankQuest"]		= AUCTION_CATEGORY_QUEST_ITEMS,
	["cBniv_BankTrade"]		= BAG_FILTER_TRADE_GOODS,
	["cBniv_BankCons"]		= BAG_FILTER_CONSUMABLES,
	["cBniv_BankArtifact"]  = ARTIFACT_POWER,
	["cBniv_Junk"]			= BAG_FILTER_JUNK,
	["cBniv_ItemSets"]		= LOOT_JOURNAL_ITEM_SETS,
	["cBniv_Armor"]			= BAG_FILTER_EQUIPMENT,
	["cBniv_Gem"]			= AUCTION_CATEGORY_GEMS,
	["cBniv_Quest"]			= AUCTION_CATEGORY_QUEST_ITEMS,
	["cBniv_Consumables"]	= BAG_FILTER_CONSUMABLES,
	["cBniv_Artifact"]      = ARTIFACT_POWER,
	["cBniv_ArtifactPower"] = ARTIFACT_POWER,
	["cBniv_TradeGoods"]	= BAG_FILTER_TRADE_GOODS,
	["cBniv_BattlePet"]		= AUCTION_CATEGORY_BATTLE_PETS,
	["cBniv_Bag"]			= INVENTORY_TOOLTIP,
	["cBniv_Keyring"]		= KEYRING,
}	


if gl == "deDE" then
	cBnivL.MarkAsNew = "Als neu markieren"
	cBnivL.MarkAsKnown = "Als bekannt markieren"
	cBnivL.bagCaptions.cBniv_Stuff = "Cooles Zeugs"
	cBnivL.bagCaptions.cBniv_NewItems = "Neue Items"
elseif gl == "ruRU" then
	cBnivL.MarkAsNew = "Перенести в Новые предметы"
	cBnivL.MarkAsKnown = "Перенести в Известные предметы"
	cBnivL.bagCaptions.cBniv_Stuff = "Разное"
	cBnivL.bagCaptions.cBniv_NewItems = "Новые предметы"
elseif gl == "koKR" then
	cBnivL.MarkAsNew = "Mark as New"
	cBnivL.MarkAsKnown = "Mark as Known"
	cBnivL.bagCaptions.cBniv_Stuff = "지정"
	cBnivL.bagCaptions.cBniv_NewItems = "신규"
elseif gl == "frFR" then
	cBnivL.MarkAsNew = "Marquer comme Neuf"
	cBnivL.MarkAsKnown = "Marquer comme Connu"
	cBnivL.bagCaptions.cBniv_Stuff = "Divers"
	cBnivL.bagCaptions.cBniv_NewItems = "Nouveaux Objets"
elseif gl == "itIT" then
    cBnivL.MarkAsNew = "Segna come Nuovo"
    cBnivL.MarkAsKnown = "Segna come Conosciuto"
	cBnivL.bagCaptions.cBniv_Stuff = "Cose Interessanti"
	cBnivL.bagCaptions.cBniv_NewItems = "Oggetti Nuovi"
----------------------------------------------------------zhCN----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
elseif gl == "zhCN" then
	cBnivL.MarkAsNew = "标记为新增"
    cBnivL.MarkAsKnown = "标记为已知"
	cBnivL.bagCaptions.cBniv_Stuff = "施法材料"
	cBnivL.bagCaptions.cBniv_NewItems = "新增"
	cBnivL['Toggle unlocked status.'] = "切换解锁状态."
	cBnivL['Toggle the "New Items" filter.'] = '切换 "新增" 标签显示状态.'
	cBnivL['Toggle the "Trade Goods" filter .'] = '切换 "商品" 标签显示状态.'
	cBnivL['Toggle the "Armor and Weapons" filter .'] = '切换 "装备" 标签显示状态.'
	cBnivL['Toggle the "Gem" filter .'] = '切换 "宝石" 标签显示状态.'
	cBnivL['Toggle the "Junk" filter.'] = '切换 "垃圾" 标签显示状态.'
	cBnivL['Toggle the "ItemSets" filters.'] = '切换 "套装" 标签显示状态.'
	cBnivL['Toggle the "Consumables" filters.'] = '切换 "消耗品" 标签显示状态.'
	cBnivL['Toggle the "Artifact" filters.'] = '切换 "神器能量" 标签显示状态.'
	cBnivL['Toggle the "Quest" filters.'] = '切换 "任务" 标签显示状态.'
	cBnivL['Toggle black bank background color.'] = '切换 黑色银行背景.'
	cBnivL['Toggle bank filtering.'] = '切换银行标签显示状态.'
	cBnivL['Toggle empty bagspace compression.'] = '切换背包空余格数显示状态.'
	cBnivL['Toggle auto sorting the bags.'] = '切换背包排序.'
	cBnivL['Toggle auto sorting the bank.'] = '切换银行排序.'
	cBnivL['Set the overall scale.'] = '设置缩放大小.'
	cBnivL['Add a custom container.'] = '添加一个自定义标签.'
	cBnivL['Remove a custom container.'] = '删除一个自定义标签.'
	cBnivL['List all custom containers.'] = '列出所有自定义标签.'
	cBnivL['Toggle buttons to move custom containers (up, down, left, right).'] = '显示按钮移动自定义分类(上, 下, 左, 右).'
	cBnivL['Changes the filter priority of a custom container.'] = '更改自定义分类优先级.'
	cBnivL['Show custom containers in the bank too.'] = '在银行中显示自定义标签.'
	cBnivL['You have to specify a name, e.g.'] = '必须指定一个分类名称,例如:'
	cBnivL['There is no custom container named'] = '该自定义分类不存在'
	cBnivL['There is custom container named'] = '请勿重复添加相同分类 '
	cBnivL['The "New Items" filter is now '] = '"新增" 标签显示状态 '
	cBnivL['The "Trade Goods" filter is now '] = '"商品" 标签显示状态 '
	cBnivL['The "Armor and Weapons" filter is now '] = '"装备" 标签显示状态 '
	cBnivL['The "Gem and Weapons" filter is now '] = '"宝石" 标签显示状态 '
	cBnivL['The "Junk" filter is now '] = '"垃圾" 标签显示状态 '
	cBnivL['The "ItemSets" filters are now '] = '"套装" 标签显示状态 '
	cBnivL['The "Consumables" filters are now '] = '"消耗品" 标签显示状态 '
	cBnivL['The "Artifact" filters are now '] = '"神器能量" 标签显示状态 '
	cBnivL['The "Quest" filters are now '] = '"任务" 标签显示状态 '
	cBnivL['Black background color for the bank is now '] = '黑色银行背景 '
	cBnivL['Bank filtering is now '] = '银行标签显示状态 '
	cBnivL['. Reload your UI for this change to take effect!'] = '. /Reload 重载插件后生效!'
	cBnivL['Empty bagspace compression is now '] = '背包空余格数显示状态 '
	cBnivL['Movable bags are now '] = '[背包]解锁 '
	cBnivL['Auto sorting bags is now '] = '背包排序 '
	cBnivL['Auto sorting bank is now '] = '银行排序 '
	cBnivL['Overall scale has been set to '] = '背包缩放:'
	cBnivL['You have to specify a value, e.g. '] = '你必须指定一个缩放比 ,例如:'
	cBnivL['The new custom container has been created. Reload your UI for this change to take effect!'] = '已成功添加自定义标签. /Reload 重载插件后生效!'
	cBnivL['A custom container with this name already exists.'] = '请勿重复添加相同分类.'
	cBnivL['The specified custom container has been removed. Reload your UI for this change to take effect!'] = '已成功移除自定义标签. /Reload 重载插件后生效!'
	cBnivL['There are '] = '总计'
	cBnivL[' custom containers.'] = '个自定义分类'
	cBnivL['Custom container movers are now '] = '[自定义分类]解锁 '
	cBnivL['The priority of the specified custom container has been set to '] = '已将指定的自定义分类优先级设置为 '
	cBnivL['Display of custom containers in the bank is now '] = '显示银行自定义分类 '	
	cBnivL['Reset New'] = '刷新'	
	cBnivL['Toggle Bags'] = '背包'	
	cBnivL['Restack'] = '整理'	
	cBnivL['Options'] = '设置'	
	cBnivL['Sell Junk '] = '售卖垃圾 '	
	cBnivL['Ctrl + Alt + Right Click an item to assign category'] = 'Ctrl + Alt + 右键单击一个物品进行分类'	
	cBnivL['Vendor trash sold: '] = '出售垃圾: '
	cBnivL['Changes the filter priority of a custom container. High priority prevents items from being classified as junk or new, low priority doesn\'t.'] = '更改自定义容器的优先级，高优先级的能防止被归类为\'垃圾\'或者\'新增\'.'
elseif gl == "zhTW" then
	cBnivL.MarkAsNew = "Mark as New"
	cBnivL.MarkAsKnown = "Mark as Known"
	cBnivL.bagCaptions.cBniv_Stuff = "施法材料"
	cBnivL.bagCaptions.cBniv_NewItems = "新增"	
else
	cBnivL.MarkAsNew = "Mark as New"
	cBnivL.MarkAsKnown = "Mark as Known"
	cBnivL.bagCaptions.cBniv_Stuff = "Cool Stuff"
	cBnivL.bagCaptions.cBniv_NewItems = "New Items"
end
