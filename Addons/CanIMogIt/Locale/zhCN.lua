local translations = {
	["Adds tooltips to items showing if you have learned a transmog appearance."] = "当你解锁幻化外观时，将添加一个提示到物品信息。",
	["Another class can learn this item."] = "其他职业可以解锁",
	["Can be learned by:"] = "可以解锁通过：",
	["Can I Mog It? Important Message: Please log into all of your characters to compile complete transmog appearance data."] = "Can I Mog It? 重要提示：请登录所有角色以生成插件的幻化外观数据库",
	["CanIMogItOptions not found, loading defaults!"] = "CanIMogIt插件配置未找到，加载默认配置！",
	["Cannot be learned."] = "无法解锁",
	["Cannot be learned by this character."] = "当前角色不能解锁",
	["Cannot determine status on other characters."] = "无法确认其他角色状态",
	["Cannot learn:"] = "无法解锁：",
	["Cannot learn: Soulbound"] = "无法解锁：已绑定",
	["Debug Tooltip"] = "调试工具提示",
	["Detailed information for debug purposes. Use this when sending bug reports."] = "显示详细的装备提示",
	["Equippable Items Only"] = "只提示装备",
	["Learned."] = "已解锁",
	["Learned but cannot transmog yet."] = "已解锁但不满足幻化要求",
	["Learned for a different class."] = "已被其他职业解锁",
	["Learned for a different class and item."] = "已被其他职业和装备解锁",
	["Learned from another item."] = "已解锁同模型装备",
	["Learned from another item but cannot transmog yet."] = "已解锁同模型装备但不满足幻化要求",
	["Not learned."] = "未解锁",
	["Only show on items that can be equipped."] = "只对装备进行提示，过滤非装备物品的提示",
	["Only show on items that can be transmoggrified."] = "只对可加入幻化试衣间的物品进行提示",
	["Only show on items that you haven't learned."] = "只对无法加入幻化试衣间的物品进行提示",
	["Show Bag Icons"] = "显示状态图标",
	["Shows a more detailed text for some of the tooltips."] = "为部分物品显示更为详细的提示",
	["Shows the icon directly on the item in your bag."] = "在背包物品上显示解锁状态的图标",
	["Transmoggable Items Only"] = "只提示可解锁的物品",
	["Unknown Items Only"] = "只提示无法解锁的物品",
	["Verbose Text"] = "详细提示",
}



CanIMogIt:RegisterLocale("zhCN", translations)
translations = nil