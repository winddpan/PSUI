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
			--SpecName = "敏锐",
			--NumPerLine = 6,

			-- 敏锐
			{spellID = 185313},
			{spellID = 212283},
			{spellID = 209782},
			{spellID = 121471},

			-- 狂徒
			{spellID = 13750},
			{spellID = 202665},

			-- 刺杀
			{spellID = 79140},
			{spellID = 245388},
			{spellID = 192759},
			{spellID = 200806},

			{spellID = 137619},
			{spellID = 152150},

			-- 正中眉心
			{spellID = 199804},

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
			SpecName = "邪恶",
			
			{spellID = 49206},
			{spellID = 220143},
			{spellID = 130736},
			{spellID = 194918},

		},
	},
	["DEMONHUNTER"] = {
		{
			Direction = "CENTER",
			Interval = 0,
			IconSize = size,
			Position = pos,
			SpecName = "浩劫",
			
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
			SpecName = "野兽控制",
			
			{spellID = 19574},
			{spellID = 120679},
			{spellID = 34026},
			{spellID = 131894},
			{spellID = 120360},
		},
	}
}