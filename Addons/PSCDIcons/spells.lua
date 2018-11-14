local pos = {"BOTTOM", UIParent, 0, 145}
--local pos = {"CENTER", UIParent, "BOTTOM", 0, 274}
local size = 48

Cooldowns = {
	["ROGUE"] = {
		{
			Direction = "CENTER",
			Interval = 0,
			IconSize = size,
			Position = pos,
			--NumPerLine = 6,

			-- 敏锐
			{spellID = 185313, spec = "敏锐"},
			-- 影分身
			{spellID = 280719, talent = "7/2", spec = "敏锐"},
			{spellID = 212283, spec = "敏锐"},

			-- 死标
			{spellID = 137619, talent = "3/3"},
			
			{spellID = 121471, spec = "敏锐"},

			-- 正中眉心
			{spellID = 199804, spec = "狂徒"},
			{spellID = 51690, talent = "7/3", spec = "狂徒"},
			{spellID = 271877, talent = "7/2", spec = "狂徒"},
			
			-- 冲动
			{spellID = 13750, spec = "狂徒"},

			-- 萃毒
			{spellID = 245388, spec = "奇袭", talent = "6/2"},
			-- 抽血
			{spellID = 200806, spec = "奇袭", talent = "6/3"},

			-- 仇杀
			{spellID = 79140, spec = "奇袭"},

			-- 消失
			{spellID = 1856},
			-- 烟雾弹
			{spellID = 212182, pvp = true},
			{spellID = 207736, pvp = true},
			{spellID = 269513, pvp = true},
			{spellID = 206328, pvp = true},
			{spellID = 207777, pvp = true},
			{spellID = 198529, pvp = true},

		},
	},
	["DEATHKNIGHT"] = {
		{
			Direction = "CENTER",
			Interval = 0,
			IconSize = size,
			Position = pos,
			
			{spellID = 275699, spec = "邪恶"},
			{spellID = 49206, spec = "邪恶", talent = "7/3"},
			{spellID = 63560, spec = "邪恶"},
			
			{spellID = 196770, spec = "冰霜"},
			{spellID = 51271, spec = "冰霜"},
			{spellID = 47568, spec = "冰霜"},
			{spellID = 279302, spec = "冰霜", talent = "6/3"},
			
			{spellID = 43265, spec = "鲜血"},
			{spellID = 55233, spec = "鲜血"},
			{spellID = 49028, spec = "鲜血"},
			{spellID = 206977, spec = "鲜血", talent = "7/2"},
			{spellID = 194844, spec = "鲜血", talent = "7/3"},

		},
	},
	["DEMONHUNTER"] = {
		{
			Direction = "CENTER",
			Interval = 0,
			IconSize = size,
			Position = pos,
			
			{spellID = 211048},
			{spellID = 206491},
			{spellID = 211053},
			{spellID = 211881},
			{spellID = 201467},
			{spellID = 232893},
			{spellID = 188499},
			--{spellID = 185123},
		},
	},
	["HUNTER"] = {
		{
			Direction = "CENTER",
			Interval = 0,
			IconSize = size,
			Position = pos,
			
			{spellID = 19574},
			{spellID = 120679},
			{spellID = 34026},
			{spellID = 131894},
			{spellID = 120360},
		},
	}
}