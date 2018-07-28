local _, ns = ...

local IconSize = 36
local Filger_Settings = {
	player_buff_icon = {"BOTTOMRIGHT", UIParent, "CENTER", -200, 0},	-- P_BUFF_ICON
	player_proc_icon = {"TOPRIGHT", UIParent, "CENTER", -200, -4},		-- P_PROC_ICON
	target_debuff_icon = {"BOTTOMLEFT", UIParent, "CENTER", 200, 0},	-- T_DEBUFF_ICON
	trinket = {"TOPLEFT", "oUF_monoPlayerFrame", "TOPLEFT", -2, -55},  	-- Trinket
	cooldown = {"BOTTOMLEFT", UIParent, "CENTER", -306, -247},   		-- Cooldown
}

Filger_Spells = {
	["ALL"] = {
		{
			Name = "Trinket",
			Direction = "DOWN",
			Mode = "BAR",
			BarWidth = 178,
			Interval = 1,
			Alpha = 1,
			IconSize = 26,
			Position = {unpack(Filger_Settings.trinket)},
			
			{spellID = 7744, unitID = "7744", caster = "player", filter = "CD"},
			{spellID = 195710, unitID = "7744", caster = "player", filter = "CD"},
			{spellID = 214027, unitID = "7744", caster = "player", filter = "CD"},

		},
	},
	["DEATHKNIGHT"] = {
		{
			Name = "SP",
			Direction = "LEFT",
			Interval = 2,
			Mode = "ICON",
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},
				{ spellID = 207127, unitID = "player", caster = "player", filter = "BUFF"},
				--冰霜之柱
				{ spellID = 51271, unitID = "player", caster = "player", filter = "BUFF"},
				{ spellID = 53365, unitID = "player", caster = "player", filter = "BUFF"},
				{ spellID = 242583, unitID = "player", caster = "player", filter = "BUFF"},

				-- 收割急速buff
				{spellID = 215711, unitID = "player", caster = "player", filter = "BUFF" },
				{spellID = 207319, unitID = "player",caster = "all", filter = "BUFF"}, 
				{spellID = 216974, unitID = "player", caster = "player", filter = "BUFF"},
				--符文劍舞
				{ spellID = 49028, unitID = "player", caster = "player", filter = "BUFF" },
				--冰霜之柱
				--{ spellID = 51271, unitID = "player", caster = "player", filter = "BUFF"},
				--拖把SP
				{ spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
				--反魔法护罩
				{ spellID = 48707, unitID = "player", caster = "player", filter = "BUFF"},
				--冰封之韧
				{ spellID = 48792, unitID = "player", caster = "player", filter = "BUFF"},
				-- 嗜血
				{spellID =  2825, unitID = "player",caster = "all", filter = "BUFF"},
				-- 英勇气概
				{spellID = 32182, unitID = "player",caster = "all", filter = "BUFF"},
				-- 时间扭曲
				{spellID = 80353, unitID = "player",caster = "all", filter = "BUFF"},
				-- 杀戮机器
				--{spellID = 51124, unitID = "player",caster = "all", filter = "BUFF"},
				-- 吸血鬼之血
				{spellID = 55233, unitID = "player",caster = "all", filter = "BUFF"},
				-- 冰冻之雾
				--{spellID = 59052, unitID = "player",caster = "all", filter = "BUFF"},
				-- 赤色天灾
				{spellID = 81141, unitID = "player",caster = "all", filter = "BUFF"},
				-- 符文刃舞
				{spellID = 81256, unitID = "player",caster = "all", filter = "BUFF"},
				--黑暗突变
				{spellID = 63560, unitID = "pet",caster = "all", filter = "BUFF"}, 
				--符能转换
				{ spellID = 119975, unitID = "player", caster = "player", filter = "BUFF" },	
				--符文腐化
				{spellID = 51460, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 2,
			Alpha = 1,
			IconSize = 36,
			Position = {unpack(Filger_Settings.player_proc_icon)},
			
			{ spellID = 101568, unitID = "player", caster = "player", filter = "BUFF"},
			{ spellID = 196770, unitID = "player", caster = "player", filter = "BUFF"},

			-- 溃烂之伤
			{spellID = 194310, unitID = "target", caster = "player", filter = "DEBUFF"},
			
			{spellID = 195181, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "DEBUFF",
			Direction = "RIGHT",
			Interval = 0,
			Mode = "ICON",
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},
			
			-- 溃烂之伤
			--{spellID = 194310, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 196782, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- 恶性瘟疫
			{spellID = 191587, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- 血之疫病
			{spellID = 55078, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- 冰霜疫病
			{spellID = 55095, unitID = "target", caster = "player", filter = "DEBUFF"},
			
			--灵魂收割
			{spellID = 130736, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- 冰链
			{spellID = 45524, unitID = "target", caster = "player", filter = "DEBUFF"},
			
			{spellID = 206977, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 143375, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 206930, unitID = "target", caster = "player", filter = "DEBUFF"},

		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 2,
			Alpha = 1,
			IconSize = 38,
			Position = {unpack(Filger_Settings.player_buff_icon)},
			
			{spellID = 221630, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 193641, unitID = "player", caster = "player", filter = "BUFF"},
			--{spellID = 192425, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- 萃毒之刃
			{spellID = 245389, unitID = "target", caster = "player", filter = "DEBUFF"},
			
			-- 影舞
			{spellID = 185422, unitID = "player", caster = "player", filter = "BUFF"},
			-- 暗刃
			{spellID = 121471, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- 敏锐死亡标记
			{spellID = 212283, unitID = "player", caster = "player", filter = "BUFF"},
			-- Master of Subtlety
			{spellID = 31665, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- 狂徒神器
			{spellID = 202665, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- 敏锐神器
			{spellID = 220901, unitID = "player", caster = "player", filter = "BUFF"},

			-- 嗜血
			{spellID =  2825, unitID = "player",caster = "all", filter = "BUFF"},
			-- 英勇气概
			{spellID = 32182, unitID = "player",caster = "all", filter = "BUFF"},
			-- 时间扭曲
			{spellID = 80353, unitID = "player",caster = "all", filter = "BUFF"},
			
			{spellID = 227151, unitID = "player", caster = "player", filter = "BUFF"},
			--{spellID = 195627, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- Slice and Dicepoison
			{spellID = 5171, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- 动如脱兔
			{spellID = 197003, unitID = "player", caster = "player", filter = "BUFF"},
			-- 登船突击队
			{spellID = 209754, unitID = "player", caster = "player", filter = "BUFF"},
			-- 阴险伎俩
			{spellID = 213995, unitID = "player", caster = "player", filter = "BUFF"},

			--潜行
			--{spellID = 115191, unitID = "player", caster = "player", filter = "BUFF"},
			--暗影集中
			{spellID = 112942, unitID = "player", caster = "player", filter = "BUFF"},
			--强化消失
			{spellID = 115193, unitID = "player", caster = "player", filter = "BUFF"},
			--诡诈
			{spellID = 115192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Envenom
			{spellID = 32645, unitID = "player", caster = "player", filter = "BUFF"},
			-- Adrenaline Rush
			{spellID = 13750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 199754, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cloak of Shadows
			{spellID = 31224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vanish
			{spellID = 1856, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Readiness
			{spellID = 74001, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Flurry
			{spellID = 13877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sprint
			{spellID = 2983, unitID = "player", caster = "player", filter = "BUFF"},
			-- Feint
			{spellID = 1966, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 137573, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 2,
			Alpha = 1,
			IconSize = 38,
			Position = {unpack(Filger_Settings.player_proc_icon)},
						
						
			-- 必爆肩膀
			{spellID = 235027, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 245640, unitID = "player", caster = "player", filter = "BUFF"},

			-- 灌铅骰子
			{spellID = 240837, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- 巅峰敏捷
			{spellID = 242584, unitID = "player", caster = "player", filter = "BUFF"},	--铁花爆击

			-- 敏锐终结技buff
			{spellID = 197496, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 197498, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- 天赋-敏锐
			{spellID = 193538, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- 披风
			{spellID = 208693, unitID = "player", caster = "player", filter = "BUFF", stack = 20},
			{spellID = 228224, unitID = "player", caster = "player", filter = "BUFF", stack = 20},
			
			-- SP
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},	--铁花爆击
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},	--铁花精通
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},	--铁花急速

			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},	--焦镜暴击
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},	--焦镜精通
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},  --焦镜急速
			
			{spellID = 225736, unitID = "player", caster = "player", filter = "BUFF"},	--回归打击

			{spellID = 221796, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "狂徒buff",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = -1,
			Alpha = 1,
			IconSize = 36,
			Position = {"TOPRIGHT", UIParent, "CENTER", -200, -64},

			-- 骰子6buff
			{spellID = 193359, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 193357, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 193356, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 199603, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 199600, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 193358, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 2,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},
			
			-- 狂徒 鬼魅攻击
			{spellID = 196937, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 192925, unitID = "target", caster = "player", filter = "DEBUFF"},
 
			--移动速度减70%
			{spellID = 115196, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 185763, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Find Weakness 洞悉弱点
			{spellID = 91021, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 195452, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 206760, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Vendetta 仇杀
			{spellID = 79140, unitID = "target", caster = "player", filter = "DEBUFF"},
			--君王之灾debuff
			{spellID = 192759, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rupture
			{spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Garrote
			{spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Hemorrhage
			{spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Poison
			{spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 200803, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 198097, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Wound Poison
			{spellID = 8680, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 207777, unitID = "target", caster = "player", filter = "DEBUFF"},

		},
	},
	["DEMONHUNTER"] = {{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 2,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},
			
			{spellID = 208628, unitID = "player", caster = "player", filter = "BUFF"},

			-- DPS
			{spellID = 162264, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 211048, unitID = "player", caster = "player", filter = "BUFF"},

			-- TANK
			{spellID = 178740, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 187827, unitID = "player", caster = "player", filter = "BUFF"},

		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 2,
			Alpha = 1,
			IconSize = 36,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			{spellID = 208605, unitID = "player", caster = "player", filter = "BUFF"},

			{spellID = 188499, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 212800, unitID = "player", caster = "player", filter = "BUFF"},
			
			{spellID = 203819, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 218256, unitID = "player", caster = "player", filter = "BUFF"},
		},
		
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 2,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			{spellID = 207690, unitID = "target", caster = "player", filter = "DEBUFF"},
			
			{spellID = 206491, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 198813, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 207744, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
	},
	["DRUID"] = {			--[小德]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Cenarion Ward
			{spellID = 102351, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Chosen of Elunee
			{spellID = 102560, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: King of the Jungle
			{spellID = 102543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Son of Ursoc
			{spellID = 102558, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Vigil
			{spellID = 124974, unitID = "player", caster = "player", filter = "BUFF"},
			-- Survival Instincts
			{spellID = 61336, unitID = "player", caster = "player", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Defense
			{spellID = 132402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Roar
			{spellID = 52610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger's Fury
			{spellID = 5217, unitID = "player", caster = "player", filter = "BUFF"},
			-- Celestial Alignment
			{spellID = 112071, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Wild
			{spellID = 108294, unitID = "player", caster = "player", filter = "BUFF"},
			-- Starfall
			{spellID = 48505, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dash
			{spellID = 1850, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Shooting Stars
			{spellID = 93400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Shower
			--WoD {spellID = 81192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grace
			--WoD {spellID = 16886, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Rejuvenation
			{spellID = 96206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting
			{spellID = 16870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul of the Forest
			{spellID = 114108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tooth and Claw
			{spellID = 135286, unitID = "player", caster = "player", filter = "BUFF"},
			-- Predator's Swiftness
			{spellID = 69369, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- Item sets 套装
			-- Sage Mender (治疗T16)
			{spellID = 144871, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- 雷神的精准之视
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Physical Melee
			-- Dancing Steel (Agility)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			
			-- 橙色多彩
			-- 不屈之源钻 (耐力, 减伤)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- 阴险之源钻 (暴击, 急速)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
			-- 英勇之源钻 (智力, 节能)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- 史诗披风
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Moonfire
			{spellID = 164812, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunfire
			{spellID = 164815, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rake
			{spellID = 155722, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rip
			{spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Lacerate
			{spellID = 33745, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- 痛击
			{spellID = 77758, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immobilized
			{spellID = 45334, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
	},
	["HUNTER"] = {			--[猎人]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- 宠物顺劈
			{spellID = 118455, unitID = "pet", caster = "all", filter = "BUFF"},

			-- Deterrence
			{spellID = 19263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Fire
			{spellID = 3045, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Beast Within
			--WoD {spellID = 34471, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Mend
			{spellID = 90361, unitID = "player", caster = "player", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 54216, unitID = "player", caster = "all", filter = "BUFF"},
			{spellID = 53480, unitID = "player", caster = "all", filter = "BUFF"},

		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Ready, Set, Aim...
			--WoD {spellID = 82925, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire!
			--WoD {spellID = 82926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steady Focus
			--WoD {spellID = 53220, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lock and Load
			--WoD {spellID = 56453, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thrill of the Hunt
			-- Frenzy
			{spellID = 19615, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mend Pet
			{spellID = 136, unitID = "pet", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Physical General
			-- Physical Ranged
			-- Mirror Scope (Crit)
			{spellID = 109092, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lord Blastington's Scope of Doom (Agility)
			{spellID = 109085, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Narrow Escape
			{spellID = 136634, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- 冰冻弹减速
			{spellID = 162546, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- 震荡
			{spellID = 5116, unitID = "target", caster = "player", filter = "DEBUFF"},

		},
	},
	["MAGE"] = {			--[法师]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Ice Block
			{spellID = 45438, unitID = "player", caster = "player", filter = "BUFF"},
			-- Invisibility
			{spellID = 32612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Greater Invisibility
			{spellID = 110960, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Icy Veins
			{spellID = 12472, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Power
			{spellID = 12042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Barrier
			{spellID = 11426, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Ward
			{spellID = 111264, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heating Up
			{spellID = 48107, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Floes
			{spellID = 108839, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incanter's Ward
			{spellID = 1463, unitID = "player", caster = "player", filter = "BUFF"},
			-- Alter Time
			{spellID = 110909, unitID = "player", caster = "player", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Power
			{spellID = 116014, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Fingers of Frost
			{spellID = 44544, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brain Freeze
			{spellID = 57761, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Missiles!
			{spellID = 79683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pyroblast!
			{spellID = 48108, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- 雷神的精准之视
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},

			-- 橙色多彩
			-- 阴险之源钻 (暴击, 急速)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Arcane Charge
			{spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ignite
			{spellID = 12654, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Living Bomb
			{spellID = 44457, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Nether Tempest
			{spellID = 114923, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Bomb
			{spellID = 112948, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast
			{spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Combustion
			{spellID = 83853, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freeze (Pet)
			{spellID = 33395, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frostfire Bolt
			{spellID = 44614, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
	},
	["MONK"] = {			--[武僧]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Guard金钟罩
			{spellID = 115295, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fortifying Brew壮胆酒
			{spellID = 120954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elusive Brew飘渺酒
			{spellID = 115308, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tigereye Brew虎眼酒
			{spellID = 116740, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Touch of Karma业报之触
			{spellID = 125174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avert Harm慈悲庇护
			--WoD {spellID = 115213, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diffuse Magic散魔功
			{spellID = 122783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Energizing Brew豪能酒
			{spellID = 115288, unitID = "player", caster = "player", filter = "BUFF"},
			-- Momentum势如破竹
			{spellID = 119085, unitID = "player", caster = "player", filter = "BUFF"},
			--轻度醉拳
			{spellID = 124275, unitID = "player", caster = "all", filter = "DEBUFF"},
			--中度醉拳
			{spellID = 124274, unitID = "player", caster = "all", filter = "DEBUFF"},
			--重度醉拳
			{spellID = 124273, unitID = "player", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- 猛虎连击
			{spellID = 120273, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger Power
			{spellID = 125359, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Blackout Kick
			{spellID = 116768, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Tiger Palm
			{spellID = 118864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Guard
			--WoD {spellID = 118636, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shuffle
			{spellID = 115307, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vital Mists活力之雾
			{spellID = 118674, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serpent's Zeal青龙之忱
			{spellID = 127722, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Physical Melee
			-- Dancing Steel (Agility)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- 橙色多彩
			-- 不屈之源钻 (耐力, 减伤)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- 英勇之源钻 (智力, 节能)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- 史诗披风
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Heavy Stagger
			{spellID = 124273, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Dizzying Haze
			{spellID = 116330, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Breath of Fire
			{spellID = 123725, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
	},
	["PALADIN"] = {			--[圣骑]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Divine Shield
			{spellID = 642, unitID = "player", caster = "player", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Avenger
			{spellID = 105809, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avenging Wrath
			{spellID = 31884, unitID = "player", caster = "player", filter = "BUFF"},
			-- Argent Defender
			{spellID = 31850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed of Light
			{spellID = 85499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eternal Flame
			{spellID = 114163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sacred Shield
			{spellID = 20925, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Shield of the righteous 正义盾击
			--{spellID = 53600, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Infusion of Light
			{spellID = 54149, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bastion of Glory
			{spellID = 114637, unitID = "player", caster = "player", filter = "BUFF"},
			-- Selfless Healer
			{spellID = 114250, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Purpose
			{spellID = 90174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grand Crusader
			{spellID = 85416, unitID = "player", caster = "player", filter = "BUFF"},
			-- Daybreak
			{spellID = 88819, unitID = "player", caster = "player", filter = "BUFF"},
			-- Long Arm of the Law
			{spellID = 87173, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item sets
			-- Divine Crusader (T16)
			{spellID = 144595, unitID = "player", caster = "player", filter = "BUFF"},
			
			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Assurance of Consequence (Strength, Proc)
			{spellID = 146245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Tail Tip (Strength, Proc)
			{spellID = 146250, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skeer's Bloodsoaked Talisman (Strength, Proc)
			{spellID = 146285, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fusion-Fire Core (Strength, Proc)
			{spellID = 148899, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Alacrity of Xuen (Haste, Proc)
			{spellID = 146296, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brutal Talisman of the Shado-Pan Assault (Strength, Proc)
			{spellID = 138702, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fabled Feather of Ji-Kun (Strength, Proc)
			{spellID = 138759, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spark of Zandalar (Strength, Proc)
			{spellID = 138958, unitID = "player", caster = "player", filter = "BUFF"},
			-- Primordius' Talisman of Rage (Strength, Proc)
			{spellID = 138870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gaze of the Twins (Crit, Proc)
			{spellID = 139170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Helmbreaker Medallion (Crit, Use)
			{spellID = 136084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmist Vortex (Haste, Proc)
			{spellID = 126657, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lei Shin's Final Orders (Strength, Proc)
			{spellID = 126582, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Charioteer Figurine (Strength, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Iron Belly Wok (Haste, Use)
			{spellID = 129812, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Use)
			{spellID = 126679, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Proc)
			{spellID = 126700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Physical Melee
			-- Dancing Steel (Strength)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- 橙色多彩
			-- 不屈之源钻 (耐力, 减伤)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- 英勇之源钻 (智力, 节能)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- 史诗披风
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Forbearance
			{spellID = 25771, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Censure
			{spellID = 31803, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Glyph of Dazing Shield
			{spellID = 63529, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seal of Justice
			{spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Denounce
			{spellID = 2812, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
	},
	["PRIEST"] = {			--[牧师]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Dispersion
			{spellID = 47585, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Infusion
			{spellID = 10060, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Shell
			{spellID = 109964, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Vampiric Embrace
			{spellID = 15286, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Word: Shield
			{spellID = 17, unitID = "player", caster = "all", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fade
			{spellID = 586, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Will
			{spellID = 45242, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Divine Insight
			{spellID = 124430, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Light
			{spellID = 114255, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Darkness
			{spellID = 87160, unitID = "player", caster = "player", filter = "BUFF"},
			-- Twist of Fate
			{spellID = 123254, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- 雷神的精准之视
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- 橙色多彩
			--{spellID = 137596, unitID = "player", caster = "all", filter = "BUFF"},
			-- 阴险之源钻 (暴击, 急速)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
			-- 英勇之源钻 (智力, 节能)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- 史诗披风
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			{spellID = 17, unitID = "target", caster = "player", filter = "BUFF"},
			{spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF"},
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Void Tendril's Grasp
			{spellID = 114404, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Glyph of Mind Blast
		},
	},
	["SHAMAN"] = {			--[萨满]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Maelstorm Weapon
			{spellID = 53817, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield
			{spellID = 324, unitID = "player", caster = "player", filter = "BUFF", spec = 1, count = 5},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Mastery
			{spellID = 16166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance
			{spellID = 114049, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Flame
			{spellID = 73683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Life
			{spellID = 73685, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature Guardian
			{spellID = 31616, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stone Bulwark
			{spellID = 114893, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ancestral Guidance
			{spellID = 108281, unitID = "player", caster = "player", filter = "BUFF"},
			-- Astral Shift
			{spellID = 108271, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Clearcasting
			--WoD {spellID = 16246, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lava Surge
			{spellID = 77762, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Blast
			{spellID = 118522, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tidal Waves
			{spellID = 53390, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- 雷神的精准之视
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Physical General
			-- Physical Melee
			-- Dancing Steel (Agility)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- 橙色多彩
			-- 阴险之源钻 (暴击, 急速)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
			-- 英勇之源钻 (智力, 节能)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- 史诗披风
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Stormstrike
			{spellID = 17364, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flame Shock
			{spellID = 8050, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Searing Flames
			--WoD {spellID = 77661, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
	},
	["WARLOCK"] = {			--[术士]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Unending Resolve
			{spellID = 104773, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Knowledge
			{spellID = 113861, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Misery
			{spellID = 113860, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Instability
			{spellID = 113858, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul burn
			{spellID = 74434, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Swap
			{spellID = 86211, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Rush
			{spellID = 111400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire and Brimstone 硫磺烈火
			{spellID = 108683, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Molten Core
			{spellID = 122355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Backdraft
			{spellID = 117828, unitID = "player", caster = "player", filter = "BUFF"},
			-- Backlash
			--WoD {spellID = 34936, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demonic Rebirth
			--WoD {spellID = 108559, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item sets
			-- Ember Master (T16)
			{spellID = 145164, unitID = "player", caster = "player", filter = "BUFF"},

			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},

			-- 橙色多彩
			-- 阴险之源钻 (暴击, 急速)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Self
			-- Enslave Demon
			{spellID = 1098, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
	},
	["WARRIOR"] = {			--[战士]
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Shield Wall
			{spellID = 871, unitID = "player", caster = "player", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enraged Regeneration
			{spellID = 55694, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Block
			{spellID = 2565, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Barrier
			{spellID = 112048, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "player", caster = "player", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avatar
			{spellID = 107574, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodbath
			{spellID = 12292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recklesness
			{spellID = 1719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sweeping Strikes
			{spellID = 12328, unitID = "player", caster = "player", filter = "BUFF"},
			-- Victorious
			{spellID = 32216, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Raging Blow 怒击
			{spellID = 131116, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodsurge
			{spellID = 46916, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sword and Board
			{spellID = 50227, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ultimatum
			{spellID = 122510, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meat Cleaver
			{spellID = 85739, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 12880, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rude Interruption
			{spellID = 86663, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Assurance of Consequence (Strength, Proc)
			{spellID = 146245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Tail Tip (Strength, Proc)
			{spellID = 146250, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skeer's Bloodsoaked Talisman (Strength, Proc)
			{spellID = 146285, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fusion-Fire Core (Strength, Proc)
			{spellID = 148899, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Alacrity of Xuen (Haste, Proc)
			{spellID = 146296, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brutal Talisman of the Shado-Pan Assault (Strength, Proc)
			{spellID = 138702, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fabled Feather of Ji-Kun (Strength, Proc)
			{spellID = 138759, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spark of Zandalar (Strength, Proc)
			{spellID = 138958, unitID = "player", caster = "player", filter = "BUFF"},
			-- Primordius' Talisman of Rage (Strength, Proc)
			{spellID = 138870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gaze of the Twins (Crit, Proc)
			{spellID = 139170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Helmbreaker Medallion (Crit, Use)
			{spellID = 136084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmist Vortex (Haste, Proc)
			{spellID = 126657, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lei Shin's Final Orders (Strength, Proc)
			{spellID = 126582, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Charioteer Figurine (Strength, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Iron Belly Wok (Haste, Use)
			{spellID = 129812, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Use)
			{spellID = 126679, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Proc)
			{spellID = 126700, unitID = "player", caster = "player", filter = "BUFF"},
			-- 碳酸红宝石
			{spellID = 126513, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Physical Melee
			-- Dancing Steel (Strength)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},

			-- 橙色多彩
			-- 不屈之源钻 (耐力, 减伤)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = IconSize,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Colossus Smash
			{spellID = 86346, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Demoralizing Shout
			{spellID = 1160, unitID = "target", caster = "all", filter = "DEBUFF"},
		},
	},
}