local _, Addon = ...
Addon.L = {}

local L = Addon.L
--GARRISON_ABILITY_COUNTERS_FORMAT.."(|cFFFFFFFF%d|r,|cFFFF0000%d|r)"
if GetLocale() == "zhCN" then
	L.UnPressed = "按下Shift显示其他可能的技能|n按下Alt显示可能的技能组合"
	L.ShiftDown = "其他可能的技能"
	L.AltDown = "可能的技能组合"
	L.AbilityCountFormat = "%s(%d/%d)"
	L.AbilityPair = "此组合: 激活%d  总计%d"
elseif GetLocale() == "zhTW" then
	L.UnPressed = "按下Shift顯示其他可能的技能|n按下Alt顯示可能的技能組合"
	L.ShiftDown = "其他可能的技能"
	L.AltDown = "可能的技能組合"
	L.AbilityCountFormat = "%s(%d/%d)"
	L.AbilityPair = "此組合: 任用%d  總計%d"
elseif GetLocale() == "koKR" then
	L.UnPressed = "쉬프트키를 눌러 다른 능력들 보기...|n알트키를 눌러 능력 조합 보기..."
	L.ShiftDown = "다른 능력들"
	L.AltDown = "능력 조합"
	L.AbilityCountFormat = "%s(%d/%d)"
	L.AbilityPair = "이 조합: 활성 %d 전체 %d"
else --enUS
	L.UnPressed = "Press SHIFT to show other abilities...|nPress ALT to show ability pairs..."	--need review
	L.ShiftDown = "Other Abilities"	--need review
	L.AltDown = "Ability Pairs"
	L.AbilityCountFormat = "%s(%d/%d)"
	L.AbilityPair = "This Pair: Active %d  Total %d"
end

-- RaceName
if GetLocale() == "zhCN" then
	L.raceName = 
	{
		[2] = "人类",
		[3] = "血精灵",
		[4] = "德莱尼",
		[5] = "矮人",
		[6] = "侏儒",
		[7] = "地精",
		[8] = "暗夜精灵",
		[9] = "兽人",
		[10] = "熊猫人",
		[11] = "牛头人",
		[12] = "巨魔",
		[13] = "亡灵",
		[14] = "狼人",
		[15] = "食人魔",
		[28] = "机械",
		[29] = "刃牙虎人",
		[30] = "独眼魔",
		[31] = "木精",
		[33] = "豺狼人",
		[34] = "锦鱼人",
		[35] = "猢狲",
		[36] = "鸦人流亡者",
		[41] = "埃匹希斯守卫",
		[42] = "高等鸦人"
	}
elseif GetLocale() == "zhTW" then
	L.raceName = 
	{
		[2] = "人類",
		[3] = "血精靈",
		[4] = "德萊尼",
		[5] = "矮人",
		[6] = "地精",
		[7] = "哥布林",
		[8] = "夜精靈",
		[9] = "獸人",
		[10] = "熊貓人",
		[11] = "牛頭人",
		[12] = "食人妖",
		[13] = "不死族",
		[14] = "狼人",
		[15] = "巨魔",
		[28] = "機械",
		[29] = "劍齒人",
		[30] = "歐格隆",
		[31] = "波塔尼",
		[33] = "豺狼人",
		[34] = "錦魚人",
		[35] = "猴人",
		[36] = "阿拉卡流亡者",
		[41] = "頂尖守護者",
		[42] = "高等阿拉卡人"
	}
elseif GetLocale() == "deDE" then
	L.raceName = 
	{
		[2] = "Mensch",
		[3] = "Blutelf",
		[4] = "Draenei",
		[5] = "Zwerg",
		[6] = "Gnom",
		[7] = "Goblin",
		[8] = "Nachtelf",
		[9] = "Orc",
		[10] = "Pandaren",
		[11] = "Tauren",
		[12] = "Troll",
		[13] = "Untoter",
		[14] = "Worgen"
	}
elseif GetLocale() == "frFR" then
	L.raceName = 
	{
		[2] = "Humain",
		[3] = "Elfe de sang",
		[4] = "Draeneï",
		[5] = "Nain",
		[6] = "Gnome",
		[7] = "Gobelin",
		[8] = "Elfe de la nuit",
		[9] = "Orc",
		[10] = "Pandaren",
		[11] = "Tauren",
		[12] = "Troll",
		[13] = "Mort-vivant",
		[14] = "Worgen"
	}
elseif GetLocale() == "koKR" then
	L.raceName = 
	{
		[2] = "인간",
		[3] = "블러드 엘프",
		[4] = "드레나이",
		[5] = "드워프",
		[6] = "노움",
		[7] = "고블린",
		[8] = "나이트 엘프",
		[9] = "오크",
		[10] = "판다렌",
		[11] = "타우렌",
		[12] = "트롤",
		[13] = "언데드",
		[14] = "늑대인간"
	}
elseif GetLocale() == "esES" then
	L.raceName = 
	{
		[2] = "Humano",
		[3] = "Elfo de sangre",
		[4] = "Draenei",
		[5] = "Enano",
		[6] = "Gnomo",
		[7] = "Goblin",
		[8] = "Elfo de la noche",
		[9] = "Orco",
		[10] = "Pandaren",
		[11] = "Tauren",
		[12] = "Trol",
		[13] = "No-muerto",
		[14] = "Huargen"
	}
elseif GetLocale() == "esMX" then
	L.raceName = 
	{
		[2] = "Humano",
		[3] = "Elfo de Sangre",
		[4] = "Draenei",
		[5] = "Enano",
		[6] = "Gnomo",
		[7] = "Goblin",
		[8] = "Elfo de la noche",
		[9] = "Orco",
		[10] = "Pandaren",
		[11] = "Tauren",
		[12] = "Trol",
		[13] = "No-muerto",
		[14] = "Huargen"
	}
elseif GetLocale() == "ptBR" then
	L.raceName = 
	{
		[2] = "Humano",
		[3] = "Elfo Sangrento",
		[4] = "Draenei",
		[5] = "Anão",
		[6] = "Gnomo",
		[7] = "Goblin",
		[8] = "Elfo Noturno",
		[9] = "Orc",
		[10] = "Pandaren",
		[11] = "Tauren",
		[12] = "Troll",
		[13] = "Renegado",
		[14] = "Worgen"
	}
elseif GetLocale() == "itIT" then
	L.raceName = 
	{
		[2] = "Umano",
		[3] = "Elfo del Sangue",
		[4] = "Draenei",
		[5] = "Nano",
		[6] = "Gnomo",
		[7] = "Goblin",
		[8] = "Elfo della Notte",
		[9] = "Orco",
		[10] = "Pandaren",
		[11] = "Tauren",
		[12] = "Troll",
		[13] = "Non Morto",
		[14] = "Worgen"
	}
elseif GetLocale() == "ruRU" then
	L.raceName = 
	{
		[2] = "Человек",
		[3] = "Эльф крови",
		[4] = "Дреней",
		[5] = "Дворф",
		[6] = "Гном",
		[7] = "Гоблин",
		[8] = "Ночной эльф",
		[9] = "Орк",
		[10] = "Пандарен",
		[11] = "Таурен",
		[12] = "Тролль",
		[13] = "Нежить",
		[14] = "Ворген"
	}
else --enUS
	L.raceName = 
	{
		[2] = "Human",
		[3] = "Blood Elf",
		[4] = "Draenei",
		[5] = "Dwarf",
		[6] = "Gnome",
		[7] = "Goblin",
		[8] = "Night Elf",
		[9] = "Orc",
		[10] = "Pandaren",
		[11] = "Tauren",
		[12] = "Troll",
		[13] = "Undead",
		[14] = "Worgen",
		[15] = "Ogre",
		[28] = "Mechanical",
		[29] = "Saberon",
		[30] = "Ogron",
		[31] = "Botani",
		[33] = "Gnoll",
		[34] = "Jinyu",
		[35] = "Hozen",
		[36] = "Outcast Arakkoa",
		[41] = "Apexis Guardian",
		[42] = "High Arakkoa",
	}
end