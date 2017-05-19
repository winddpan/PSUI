﻿local addon, ns = ...
ns[1] = {} -- T, functions, constants, variables
ns[2] = {} -- C, config
ns[3] = {} -- L, localization
ns[4] = {} -- G, globals (Optionnal)

local T, C, L, G = unpack(select(2, ...))

--[[ Global ]]--

C.numberstyle = false --數字樣式/infinity plates's number style

--[[ Textures ]]--

G.iconcastbar = "Interface\\AddOns\\EKplates\\media\\dM3"
G.raidicon = "Interface\\AddOns\\EKplates\\media\\raidicons"
G.redarrow1 = "Interface\\AddOns\\EKplates\\media\\NeonRedArrow"
G.redarrow2 = "Interface\\AddOns\\EKplates\\media\\NeonRedArrowH"
G.ufbar = "Interface\\AddOns\\EKplates\\media\\ufbar"
G.blank = "Interface\\Buttons\\WHITE8x8"
G.glow = "Interface\\AddOns\\EKplates\\media\\glow"
G.myClass = select(2, UnitClass("player"))  --dont touch this!/別碰這個！

--[[ Fonts ]]--

G.numberstylefont = "Interface\\AddOns\\EKplates\\media\\Infinity Gears.ttf"  --數字樣式的數字字體/number style's number font
G.numFont = 'Fonts\\FRIZQT__.TTF' --數字字體/number font
G.norFont = STANDARD_TEXT_FONT  --名字字體/name font(or use"GameFontHighlight:GetFont()")
G.fontsize = 13  --名字字體大小/name font size
G.aurafontsize = 9  --光環字體大小/Aura font size
G.fontflag = "OUTLINE"  -- "OUTLINE" or none

--[[ Config ]]--

C.CVAR = false  --舊版姓名板/do a cvar setting to turn nameplate work like WOD
C.MinAlpha = 0.6 --非當前目標與遠距離姓名板的透明度/set fadeout for out range and non-target
C.FriendlyClickThrough = true --友方姓名板點擊穿透/friendly nameplate click through
C.EnemyClickThrough = false  --敵方姓名板點擊穿透/enemy nameplate click through
C.SelectedScale = 1.1 --縮放當前目標的姓名板大小/scale select target nameplate

C.friendlyCR = true --友方職業顏色/friendly class color
C.enemyCR = true --敵方職業顏色/enemy class color
C.threatcolor = true --名字仇恨染色/change name color by threat
C.cbshield = true  --施法條不可打斷圖示/show castbar un-interrupt shield icon
C.level = false --顯示等級/show level
C.HorizontalArrow = true --橫向箭頭/horizontal red arrow at right
C.HideArrow = false  --隱藏箭頭/hide arrow

--number style additional config
C.cbtext = false --施法條法術名稱/show castbar text

--[[ the Player Plate ]]--

C.playerplate = false  --玩家個人資源/player self nameplate
C.classresource_show = false
C.classresource = "player" -- "player", "target"  
C.plateaura = false

--[[ Aura Icons on Plates ]]--

C.auranum = 5 --圖示數量
C.auraiconsize = 18 --圖示大小
C.myfiltertype = "whitelist" --自身施放/show aura cast by player
C.otherfiltertype = "none"  --他人施放/show aura cast by other

-- "whitelist": show only list/白名單：只顯示列表中
-- "blacklist": show only unlist/黑名單：只顯示列表外
-- "none": do not show anything/不顯示任何光環

C.WhiteList = {
	-- CC
	[25046]  = true, -- 奧流之術
	
	[118]    = true, -- 變形術
	[51514]  = true, -- 妖術
	[217832] = true, -- 禁錮
	[605]    = true, -- 心控
	[710]    = true, -- 放逐
	[2094]   = true, -- 致盲
	[6770]   = true, -- 悶棍
	[9484]   = true, -- 束縛不死生物
	[20066]  = true, -- 懺悔
	[115078] = true, -- 點穴
	
	[339]    = true, -- 小d綁
	[102359] = true, -- 群纏
	[3355]   = true, -- 冰凍陷阱
	[64695]  = true, -- 地縛圖騰
	
	[5211]   = true, -- 蠻力猛擊
	[853]    = true, -- 制裁(聖騎)
	[221562] = true, -- 窒息(dk)
	
	[118905] = true, -- 電容(薩滿)
	[132168] = true, -- 震懾波(戰士)
	[179057] = true, -- 混沌新星(dh)
	[30283]  = true, -- 暗影之怒(術士)
 	[207171] = true, -- 凜冬將至(dk)
	[117405] = true, -- 束縛射擊(獵人)
	[119381] = true, -- 掃葉腿(武僧)
	[127797] = true, -- 厄索克之旋(小德)
	[205369] = true, -- 精神炸彈 
	[81261]  = true, -- 日光(小德)
	
	-- ROUGE
	[703] = true,    -- garrote
	[1943] = true,   -- rupture
	[16511] = true,  -- hemorrhage
	[79140] = true,  -- vendetta
	[2818] = true,   -- deadly poison
	[8680] = true,   -- wound poison
	[137619] = true, -- marked for death
	[195452] = true, -- nightblade
	[192759] = true, -- kingsbane
	[196937] = true, -- ghostly strike
	[200803] = true, -- agonizing poison
	
	-- DH
	[207744] = true, -- fiery brand
	[207771] = true, -- fiery brand 2
	[204598] = true, -- sigil of flame
	[204490] = true, -- sigil of silence
	[207407] = true, -- soul carver
	[224509] = true, -- frail
	[206491] = true, -- nemesis
	[207690] = true, -- bloodlet
	[213405] = true, -- master of the glaive snare
}

C.BlackList = {
	--[11426]  = true, -- 寒冰護體(test)
	--[196741] = true, -- 連珠狂拳(test)	
	[166646] = true, -- 御風而行
	[15407]  = true, -- 精神鞭笞
}

--[[ Custom colored plates ]]--

C.Customcoloredplates = {
	[1] = {
		name = "暴躁蠍子", --水晶蠍的大怪
		color = {r = 1, g = 1, b = 1},
	},
	[2] = {
		name = "寒冰裂片", --法刃的冰塊
		color = {r = 1, g = 0, b = 1},
	},
	[3] = {
		name = "邪能炸药",
		color = {r = 1, g = 0, b = 1},
	},
}

--[[ Show Power ]]--

C.show_power = true  --替特定怪(自行編輯清單)顯示特特殊能量/show spacial power
C.ShowPower = {
	["清扫器"] = true,
	["清掃者"] = true,
	["Scrubber"] = true,
}

--[[ BOSS MOD: Show Important Aura Icon on Friendly Nameplates ]]--

C.boss_mod = false
C.boss_mod_iconscale = 2
C.boss_mod_hidename = false --隱藏玩家名稱/hide player name

--[[If you enable this function, remember shift+v to enable friendly-nameplates.
	friendly-nameplates health will be hided.
	啟用首領模塊要在遊戲內shift+v開啟友方姓名板，開啟此選項會將友方姓名板的血量隱藏]]--

C.ImportantAuras = {
	--[spell id] = check filter
	--[法術id] = 過濾條件
	--[225506] = 61295, --test
	--[166646] = "none", --test
	--[57723]  = "none", --test
	--[227723]  = "compare", --test
	
	--[[ TrialofValor ]]--
	--顯示中了沫液的人/Show Volatile Foam
	[228818] = "none", -- 暗影易變沫液
	[228810] = "none", -- 鹽蝕易變沫液
	[228744] = "none", -- 火焰易變沫液	
	--當中了沫液，顯示和沫液同色吐息debuff的人/show match breath color debuff when you gain Volatile Foam
	[228769] = 228818, -- 暗黑吐息
	[228768] = 228810, -- 鹽蝕唾沫
	[228758] = 228744, -- 熾炎痰液
	
	--[[ Nighthold ]]--
	--時光異象
	[206617] = "none", --定時炸彈
	--法刃
	[212647] = 212587, --冰霜咬噬
	--植物學家
	[218342] = "none", --寄生專注
	[218304] = "none", --寄生束縛
	--提克迪奧斯
	[206480] = "none", --腐屍瘟疫
	--星占師
	--[206589] = "none", --冰凍
	--[205445] = "none", --貪狼
	--[205429] = "none", --巨蟹
	--[216345] = "none", --獵戶
	--[216344] = "none", --飛龍	
	[205445] = "compare", --貪狼
	[205429] = "compare", --巨蟹
	[216345] = "compare", --獵戶
	[216344] = "compare", --飛龍
	--古爾丹
	[221606] = "none", --薩格拉斯之焰
	[221603] = "none", --薩格拉斯之焰	
}
