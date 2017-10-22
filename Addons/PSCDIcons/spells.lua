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
			{spellID = 212283, spec = "敏锐"},
			
			-- 死标
			{spellID = 137619, talent = "7/2"},
			-- 天降
			{spellID = 152150, talent = "7/3"},
			
			{spellID = 209782, spec = "敏锐"},
			{spellID = 121471, spec = "敏锐"},

			-- 冲动
			{spellID = 13750, spec = "狂徒"},
			-- 恐惧之刃
			{spellID = 202665, spec = "狂徒"},

			-- 仇杀
			{spellID = 79140, spec = "刺杀"},
			-- 萃毒
			{spellID = 245388, spec = "刺杀", talent = "6/1"},
			-- 抽血
			{spellID = 200806, spec = "刺杀", talent = "6/3"},
			-- 君王
			{spellID = 192759, spec = "刺杀"},



			-- 正中眉心
			{spellID = 199804, spec = "狂徒"},

			-- 消失
			{spellID = 1856},
		},
	},
	["DEATHKNIGHT"] = {
		{
			Direction = "CENTER",
			Interval = 0,
			IconSize = size,
			Position = pos,
			
			{spellID = 130736, spec = "邪恶", talent = "7/3"},
			{spellID = 220143, spec = "邪恶"},
			{spellID = 194918, spec = "邪恶", talent = "2/3"},
			{spellID = 207317, spec = "邪恶", talent = "2/1"},
			{spellID = 49206, spec = "邪恶"},
			{spellID = 63560, spec = "邪恶"},
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