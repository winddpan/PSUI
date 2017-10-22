-- Credits: Katjes (HandyNotes_LegionRaresTreasures)
local Argus = LibStub("AceAddon-3.0"):NewAddon("ArgusRaresTreasures", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end

local iconDefaults = {
    skull_grey = "Interface\\Addons\\HandyNotes_Argus\\Artwork\\RareWhite.blp",
    skull_purple = "Interface\\Addons\\HandyNotes_Argus\\Artwork\\RarePurple.blp",
    skull_blue = "Interface\\Addons\\HandyNotes_Argus\\Artwork\\RareBlue.blp",
    skull_yellow = "Interface\\Addons\\HandyNotes_Argus\\Artwork\\RareYellow.blp",
    battle_pet = "Interface\\Addons\\HandyNotes_Argus\\Artwork\\BattlePet.blp",
	treasure = "Interface\\Addons\\HandyNotes_Argus\\Artwork\\Treasure.blp",
	portal = "Interface\\Addons\\HandyNotes_Argus\\Artwork\\Portal.blp",
	default = "Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS",
}
local itemTypeMisc = 0;
local itemTypePet = 1;
local itemTypeMount = 2;
local itemTypeToy = 3;

Argus.nodes = { }

local nodes = Argus.nodes
local isTomTomloaded = false
local isDBMloaded = false

-- [XXXXYYYY] = { QUEST_ID_TRACKING, TITLE, LOOT_INFO, NOTES, ICON, SETTING, LOOT_ITEMID },
-- /run local find="Crimson Slavermaw"; for i,mid in ipairs(C_MountJournal.GetMountIDs()) do local n,_,_,_,_,_,_,_,_,_,c,j=C_MountJournal.GetMountInfoByID(mid); if ( n == find ) then print(j .. " " .. n); end end
-- /run local find="Uuna's Doll"; for i=0,2500 do local n=C_PetJournal.GetPetInfoBySpeciesID(i); if ( n == find ) then print(i .. " " .. n); end end

-- Antoran Wastes
nodes["ArgusCore"] = {
	[52702950] = { 48822, "监视者艾瓦", nil, nil, "skull_grey", "rare_aw" },
	[63902090] = { 48809, "普希拉", "", "洞穴入口在东南方 - 从东面的桥到达那里。", "skull_blue", "rare_aw", { { 152903, itemTypeMount, 981 } } },
	[53103580] = { 48810, "弗拉克苏尔", "", "", "skull_blue", "rare_aw", { { 152903, itemTypeMount, 981 } } },
	[63225754] = { 48811, "维农", nil, "洞穴入口在东北方，从蜘蛛区域 66, 54.1", "skull_grey", "rare_aw" },
	[64304820] = { 48812, "瓦加", "", "", "skull_blue", "rare_aw", { { 153190, itemTypeMisc } } },
	[62405380] = { 48813, "萨卡尔中尉", nil, nil, "skull_grey", "rare_aw" },
	[61906430] = { 48814, "愤怒领主亚雷兹", "", "", "skull_blue", "rare_aw", { { 153126, itemTypeToy } } },
	[60674831] = { 48815, "审判官维斯洛兹", "", "", "skull_grey", "rare_aw", { { 151543, itemTypeMisc } } },
	[80206230] = { 48816, "传送到指挥官泰克拉兹", nil, "", "portal", "rare_aw" },
	[82006600] = { 48816, "指挥官泰克拉兹", nil, "使用偏西的传送门位于 80.2, 62.3 到达船上", "skull_grey", "rare_aw" },
	[73207080] = { 48817, "雷尔瓦将军", "", "", "skull_grey", "rare_aw", { { 153324, itemTypeMisc } } },
	[75605650] = { 48818, "全知者萨纳里安", nil, nil, "skull_grey", "rare_aw" },
	[50905530] = { 48820, "裂世者斯库尔", nil, nil, "skull_grey", "rare_aw" },
	[63102520] = { 48821, "驯犬大师克拉克斯", "", "", "skull_blue", "rare_aw", { { 152790, itemTypeMount, 955 } } },
	[55702190] = { 48824, "虚空守望者瓦苏拉", "", "", "skull_grey", "rare_aw", { { 153319, itemTypeMisc } } },
	[60902290] = { 48865, "首席炼金师蒙库鲁斯", nil, nil, "skull_grey", "rare_aw" },
	[54003800] = { 48966, "千面吞噬者", "", "", "skull_blue", "rare_aw", { { 153195, itemTypePet, 2136 } } },
	[77177319] = { 48967, "传送到中队指挥官维沙克斯", "", "第一步先从虚空行者身上找到碎裂的传送门发生器。然后收集导电护套，弧光电路，能量电池，把他们组合起来打开去往维沙克斯的传送门。", "portal", "rare_aw" },
	[84368118] = { 48967, "中队指挥官维沙克斯", "", "使用传送门位于 77.2, 73.2 上船", "skull_blue", "rare_aw", { { 153253, itemTypeToy } } },
	[58001200] = { 48968, "末日法师苏帕克斯", "", "", "skull_blue", "rare_aw", { { 153194, itemTypeToy } } },
	[66981777] = { 48970, "主母罗苏拉", "", "洞穴入口在东南方 - 从东面的桥到达那里。收集洞里小鬼掉的100个小鬼的肉。使用它做一份黑暗料理扔进绿池子里召唤主母。", "skull_blue", "rare_aw", { { 152903, itemTypeMount, 981 }, { 153252, itemTypePet, 2135 } } },
	[64948290] = { 48971, "先知雷兹拉", "", "使用观察者之地共鸣器打开传送门", "skull_blue", "rare_aw", { { 153293, itemTypeToy } } },
	[61703720] = { 49183, "疱喉", "", "", "skull_blue", "rare_aw", { { 152905, itemTypeMount, 979 } } },
	[57403290] = { 49240, "妖女伊森黛拉", "", "", "skull_blue", "rare_aw", { { 153327, itemTypeMisc } } },
	[56204550] = { 49241, "加尔佐斯", nil, nil, "skull_grey", "rare_aw" },


	[59804030] = { 0, "小乌祖", nil, nil, "battle_pet", "pet_aw" },
	[76707390] = { 0, "小型克西斯号", nil, nil, "battle_pet", "pet_aw" },
	[51604140] = { 0, "凝视者", nil, nil, "battle_pet", "pet_aw" },
	[56605420] = { 0, "小胖", nil, nil, "battle_pet", "pet_aw" },
	[56102870] = { 0, "啮耳者", nil, nil, "battle_pet", "pet_aw" },
	[64106600] = { 0, "小贼", nil, nil, "battle_pet", "pet_aw" },
	
	[56903570] = { 48383, "48383", nil, nil, "treasure", "treasure_aw" },
	[50605720] = { 48385, "48385", nil, nil, "treasure", "treasure_aw" },
	[51502610] = { 48388, "48388", nil, nil, "treasure", "treasure_aw" },
	[64305040] = { 48389, "48389", nil, nil, "treasure", "treasure_aw" },
	[60254351] = { 48389, "48389", nil, nil, "treasure", "treasure_aw" },
	[81306860] = { 48390, "48390", nil, "在船上", "treasure", "treasure_aw" },
	[64135867] = { 48391, "48391", nil, "在维农的巢穴内", "treasure", "treasure_aw" },
	[67404790] = { 48391, "48391", nil, nil, "treasure", "treasure_aw" },
	[80406152] = { 48390, "48390", nil, nil, "treasure", "treasure_aw" },
	[69403965] = { 48387, "48387", nil, nil, "treasure", "treasure_aw" },
	[57633179] = { 48383, "48383", nil, nil, "treasure", "treasure_aw" },
	[59261743] = { 48388, "48388", nil, nil, "treasure", "treasure_aw" },
	[50655715] = { 48385, "48385", nil, nil, "treasure", "treasure_aw" },
	[60872900] = { 48384, "48384", nil, nil, "treasure", "treasure_aw" },
	[55921387] = { 48388, "48388", nil, nil, "treasure", "treasure_aw" },
	[52182918] = { 48383, "48383", nil, nil, "treasure", "treasure_aw" },
	[67466226] = { 48382, "48382", nil, nil, "treasure", "treasure_aw" },
	[82566503] = { 48390, "48390", nil, "在船上", "treasure", "treasure_aw" },
	[63615622] = { 48391, "48391", nil, "在维农的巢穴内", "treasure", "treasure_aw" },
	[65514081] = { 48389, "48389", nil, nil, "treasure", "treasure_aw" },
	[58174021] = { 48383, "48383", nil, nil, "treasure", "treasure_aw" },
	[68983342] = { 48387, "48387", nil, nil, "treasure", "treasure_aw" },
	[58413097] = { 48383, "48383", nil, "建筑物内，第一层", "treasure", "treasure_aw" },
	[59081942] = { 48384, "48384", nil, "建筑物内", "treasure", "treasure_aw" },
	[55841722] = { 48388, "48388", nil, nil, "treasure", "treasure_aw" },
	[60304675] = { 48389, "48389", nil, nil, "treasure", "treasure_aw" },
	[57135124] = { 48385, "48385", nil, nil, "treasure", "treasure_aw" },
	[65005049] = { 48391, "48391", nil, "蜘蛛区域外", "treasure", "treasure_aw" },
	[73316858] = { 48390, "48390", nil, "雷尔瓦将军顶层边上", "treasure", "treasure_aw" },
	[71326946] = { 48382, "48382", nil, "任务怪边上", "treasure", "treasure_aw" },
	[64152305] = { 48384, "48384", nil, "驯犬大师克拉克斯洞穴内", "treasure", "treasure_aw" },
}

-- Krokuun
nodes["ArgusSurface"] = {
	[44390734] = { 48561, "卡扎杜姆", nil, "入口在东南位于 50.3, 17.3", "skull_grey", "rare_kr" },
	[33007600] = { 48562, "指挥官萨森纳尔", nil, nil, "skull_grey", "rare_kr" },
	[44505870] = { 48564, "指挥官安达西斯", "", "", "skull_blue", "rare_kr", { { 153255, itemTypeMisc } } },
	[53403090] = { 48565, "苏薇西娅姐妹", "", "", "skull_blue", "rare_kr", { { 153124, itemTypeToy } } },
	[58007480] = { 48627, "攻城大师沃兰", nil, nil, "skull_grey", "rare_kr" },
	[55508020] = { 48628, "恶毒者泰勒斯塔", "", "", "skull_blue", "rare_kr", { { 153329, itemTypeMisc } } },
	[38145920] = { 48563, "指挥官维卡娅", "", "路径起始点在东，位于 42, 57.1", "skull_blue", "rare_kr", { { 153299, itemTypeMisc } } },
	[60802080] = { 48629, "背弃者瓦加斯", nil, nil, "skull_grey", "rare_kr" },
	[69605750] = { 48664, "分选者泰瑞克", "", "", "skull_blue", "rare_kr", { { 153263, itemTypeMisc } } },
	[69708050] = { 48665, "焦油喷吐者", nil, nil, "skull_grey", "rare_kr" },
	[41707020] = { 48666, "鬼母拉格拉丝", nil, nil, "skull_grey", "rare_kr" },
	[70503370] = { 48667, "纳罗瓦", "", "", "skull_blue", "rare_kr", { { 153190, itemTypeMisc } } },

	[43005200] = { 0, "梦魇之焰", nil, nil, "battle_pet", "pet_kr" },
	[51506380] = { 0, "污染之爪", nil, nil, "battle_pet", "pet_kr" },
	[66847263] = { 0, "毁灭之蹄", nil, nil, "battle_pet", "pet_kr" },
	[29605790] = { 0, "死亡之啸", nil, nil, "battle_pet", "pet_kr" },
	[39606650] = { 0, "小牙", nil, nil, "battle_pet", "pet_kr" },
	[58302970] = { 0, "小脏", nil, nil, "battle_pet", "pet_kr" },

	[56108050] = { 47752, "47752", nil, nil, "treasure", "treasure_kr" },
	[51425958] = { 47753, "47753", nil, nil, "treasure", "treasure_kr" },
	[70907370] = { 48000, "48000", nil, nil, "treasure", "treasure_kr" },
	[74136784] = { 48000, "48000", nil, nil, "treasure", "treasure_kr" },
	[33515510] = { 48336, "48336", nil, nil, "treasure", "treasure_kr" },
	[32047441] = { 48336, "48336", nil, nil, "treasure", "treasure_kr" },
	[62592581] = { 47999, "47999", nil, nil, "treasure", "treasure_kr" },
	[68533891] = { 48339, "48339", nil, nil, "treasure", "treasure_kr" },
	[75136432] = { 48000, "48000", nil, nil, "treasure", "treasure_kr" },
	[63054240] = { 48339, "48339", nil, nil, "treasure", "treasure_kr" },
	[53137304] = { 47753, "47753", nil, nil, "treasure", "treasure_kr" },
	[59763951] = { 47999, "47999", nil, nil, "treasure", "treasure_kr" },
	[69605772] = { 48000, "48000", nil, nil, "treasure", "treasure_kr" },
	[55228114] = { 47753, "47753", nil, nil, "treasure", "treasure_kr" },
	[59071884] = { 47999, "47999", nil, "上面，岩石后面", "treasure", "treasure_kr" },
	[55555863] = { 47752, "47752", nil, "跳上岩石，起点偏西", "treasure", "treasure_kr" },
	[69787836] = { 48000, "48000", nil, "跳上斜坡到达", "treasure", "treasure_kr" },
	[27196668] = { 48336, "48336", nil, nil, "treasure", "treasure_kr" },
	[52185431] = { 47752, "47752", nil, "位于第一次看到奥蕾莉亚的上面", "treasure", "treasure_kr" },
	[64964156] = { 48339, "48339", nil, nil, "treasure", "treasure_kr" },
	[68566054] = { 48000, "48000", nil, "分选者泰瑞克洞穴前面", "treasure", "treasure_kr" },
	[73393438] = { 48339, "48339", nil, nil, "treasure", "treasure_kr" },
	[61643520] = { 47999, "47999", nil, nil, "treasure", "treasure_kr" },
	[35415637] = { 48336, "48336", nil, nil, "treasure", "treasure_kr", "地面，在去往泽尼达尔入口下面的前方" },
}

nodes["ArgusCitadelSpire"] = {
	[38954032] = { 48561, "卡扎杜姆", nil, nil, "skull_grey", "rare_kr" },
}

-- Mac'Aree
nodes["ArgusMacAree"] = {
	[55705990] = { 0, "牧羊人卡沃斯", "", "", "skull_blue", "rare_ma", 152814 },
	[43806020] = { 0, "嗜血的巴鲁特", "", "", "skull_grey", "rare_ma", 153193 },
	[36302360] = { 0, "警卫泰诺斯", nil, nil, "skull_grey", "rare_ma" },
	[33704750] = { 0, "毒尾天鳍鳐", "", "", "skull_blue", "rare_ma", 152844 },
	[27202980] = { 0, "法鲁克队长", nil, nil, "skull_grey", "rare_ma" },
	[30304040] = { 0, "阿塔克松", nil, nil, "skull_grey", "rare_ma" },
	[35505870] = { 0, "混沌先驱", nil, "He's on the 2nd floor.", "skull_grey", "rare_ma" },
	[48504090] = { 0, "杰德尼勇士沃鲁斯克", nil, nil, "skull_grey", "rare_ma" },
	[58003090] = { 0, "监视者伊索纳", nil, nil, "skull_grey", "rare_ma" },
	[61405020] = { 0, "导师塔拉娜", nil, nil, "skull_grey", "rare_ma" },
	[56801450] = { 0, "指挥官泽斯加尔", nil, nil, "skull_grey", "rare_ma" },
	[49505280] = { 0, "最后的希里索恩", nil, nil, "skull_grey", "rare_ma" },
	[44607160] = { 0, "暗影法师沃伦", nil, nil, "skull_grey", "rare_ma" },
	[65306750] = { 0, "灵魂扭曲的畸体", nil, nil, "skull_grey", "rare_ma" },
	[38705580] = { 0, "苍白的卡拉", "", "", "skull_blue", "rare_ma", 153190 },
	[41301160] = { 0, "麦芬大盗费舍尔", nil, nil, "skull_grey", "rare_ma" },
	[63806460] = { 0, "警卫库洛", nil, nil, "skull_grey", "rare_ma" },
	[39206660] = { 0, "清醒者图瑞克", nil, nil, "skull_grey", "rare_ma" },
	[35203720] = { 0, "乌伯拉利斯", nil, nil, "skull_grey", "rare_ma" },
	[70404670] = { 0, "厄运者索洛里斯", nil, nil, "skull_grey", "rare_ma" },
	[44204980] = { 0, "沙布尔", "", "", "skull_blue", "rare_ma", 153190 },
	[59203770] = { 0, "监视者伊比达", nil, nil, "skull_grey", "rare_ma" },
	[60402970] = { 0, "监视者伊莫拉", nil, nil, "skull_grey", "rare_ma" },
	[64002950] = { 0, "万千之主祖尔坦", nil, nil, "skull_grey", "rare_ma" },
	[49700990] = { 0, "吞噬者斯克里格", "", "", "skull_blue", "rare_ma", 152904 },

	[60007110] = { 0, "烁光之翼", nil, nil, "battle_pet", "pet_ma" },
	[67604390] = { 0, "巴基", nil, nil, "battle_pet", "pet_ma" },
	[74703620] = { 0, "马库斯", nil, nil, "battle_pet", "pet_ma" },
	[69705190] = { 0, "鼠鼠", nil, nil, "battle_pet", "pet_ma" },
	[31903120] = { 0, "阿古斯的腐化之血", nil, nil, "battle_pet", "pet_ma" },
	[36005410] = { 0, "曳影兽", nil, nil, "battle_pet", "pet_ma" },
}

local function GetItem(ID)
    if (ID == "1220" or ID == "1508") then
        local currency, _, _ = GetCurrencyInfo(ID)

        if (currency ~= nil) then
            return currency
        else
            return "Error loading CurrencyID"
        end
    else
        local _, item, _, _, _, _, _, _, _, _ = GetItemInfo(ID)

        if (item ~= nil) then
            return item
        else
            return "Error loading ItemID"
        end
    end
end 

local function GetIcon(ID)
    if (ID == "1220") then
        local _, _, icon = GetCurrencyInfo(ID)

        if (icon ~= nil) then
            return icon
        else
            return "Interface\\Icons\\inv_misc_questionmark"
        end
    else
		local _, _, _, _, icon = GetItemInfoInstant(ID)
        --local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(ID)

        if (icon ~= nil) then
            return icon
        else
            return "Interface\\Icons\\inv_misc_questionmark"
        end
    end
end

function Argus:OnEnter(mapFile, coord)
    if (not nodes[mapFile][coord]) then return end
    
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

    if ( self:GetCenter() > UIParent:GetCenter() ) then
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    tooltip:SetText(nodes[mapFile][coord][2])
    if (nodes[mapFile][coord][3] ~= nil) and (Argus.db.profile.show_loot == true) then
        if ((nodes[mapFile][coord][7] ~= nil) and (type(nodes[mapFile][coord][7]) == "number")) then
			-- loot
            tooltip:AddLine(("" .. GetItem(nodes[mapFile][coord][7])), nil, nil, nil, true)

            if ((nodes[mapFile][coord][3] ~= nil) and (nodes[mapFile][coord][3] ~= "")) then
				-- lootinfo
                tooltip:AddLine(("" .. nodes[mapFile][coord][3]), nil, nil, nil, true)
            end
		elseif ((nodes[mapFile][coord][7] ~= nil) and (type(nodes[mapFile][coord][7]) == "table")) then
			local ii
			for ii = 1, #nodes[mapFile][coord][7] do
				-- loot
				if ( nodes[mapFile][coord][7][ii][2] == itemTypeMount ) then
					local n,_,_,_,_,_,_,_,_,_,c,j=C_MountJournal.GetMountInfoByID( nodes[mapFile][coord][7][ii][3] );
					if ( c == true ) then
						tooltip:AddLine(("" .. GetItem(nodes[mapFile][coord][7][ii][1]) .. " (|cFF00FF00已学会坐骑|r)"), nil, nil, nil, true)
					else
						tooltip:AddLine(("" .. GetItem(nodes[mapFile][coord][7][ii][1]) .. " (|cFFFF0000坐骑缺少|r)"), nil, nil, nil, true)
					end
				elseif ( nodes[mapFile][coord][7][ii][2] == itemTypePet ) then
					local n,m = C_PetJournal.GetNumCollectedInfo( nodes[mapFile][coord][7][ii][3] );
					tooltip:AddLine(("" .. GetItem(nodes[mapFile][coord][7][ii][1]) .. " (宠物 " .. n .. "/" .. m .. ")"), nil, nil, nil, true)
				elseif ( nodes[mapFile][coord][7][ii][2] == itemTypeToy ) then
					if ( PlayerHasToy( nodes[mapFile][coord][7][ii][1] ) == true ) then
						tooltip:AddLine(("" .. GetItem(nodes[mapFile][coord][7][ii][1]) .. " (|cFF00FF00已学会玩具|r)"), nil, nil, nil, true)
					else
						tooltip:AddLine(("" .. GetItem(nodes[mapFile][coord][7][ii][1]) .. " (|cFFFF0000玩具缺少|r)"), nil, nil, nil, true)
					end
				else
					tooltip:AddLine(("" .. GetItem(nodes[mapFile][coord][7][ii][1])), nil, nil, nil, true)
				end
			end
		else
			-- loot
            tooltip:AddLine(("" .. nodes[mapFile][coord][3]), nil, nil, nil, true)
        end
    end
	if nodes[mapFile][coord][4] and nodes[mapFile][coord][4] ~= "" and Argus.db.profile.show_notes == true then
		-- notes
		tooltip:AddLine(("" .. nodes[mapFile][coord][4]), nil, nil, nil, true)
	end

    tooltip:Show()
end

local isMoving = false
local info = {}
local clickedMapFile = nil
local clickedCoord = nil

local function LRTHideDBMArrow()
    DBM.Arrow:Hide(true)
end

local function LRTDisableTreasure(button, mapFile, coord)
    if (nodes[mapFile][coord][1] ~= nil) then
        Argus.db.char[nodes[mapFile][coord][1]] = true;
    end

    Argus:Refresh()
end

local function LRTResetDB()
    table.wipe(Argus.db.char)
    Argus:Refresh()
end

local function LRTaddtoTomTom(button, mapFile, coord)
    if isTomTomloaded == true then
        local mapId = HandyNotes:GetMapFiletoMapID(mapFile)
        local x, y = HandyNotes:getXY(coord)
        local desc = nodes[mapFile][coord][2];

        if (nodes[mapFile][coord][3] ~= nil) and (Argus.db.profile.show_loot == true) then
            if ((nodes[mapFile][coord][7] ~= nil) and (nodes[mapFile][coord][7] ~= "")) then
                desc = desc.."\n掉落：" .. GetItem(nodes[mapFile][coord][7]);
                desc = desc.."\n掉落信息：" .. nodes[mapFile][coord][3];
            else
                desc = desc.."\n掉落：" .. nodes[mapFile][coord][3];
            end
        end

        if (nodes[mapFile][coord][4] ~= "") and (Argus.db.profile.show_notes == true) then
            desc = desc.."\n注释：" .. nodes[mapFile][coord][4]
        end

        TomTom:AddMFWaypoint(mapId, nil, x, y, {
            title = desc,
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function LRTAddDBMArrow(button, mapFile, coord)
    if isDBMloaded == true then
        local mapId = HandyNotes:GetMapFiletoMapID(mapFile)
        local x, y = HandyNotes:getXY(coord)
        local desc = nodes[mapFile][coord][2];

        if (nodes[mapFile][coord][3] ~= nil) and (Argus.db.profile.show_loot == true) then
            if ((nodes[mapFile][coord][7] ~= nil) and (nodes[mapFile][coord][7] ~= "")) then
                desc = desc.."\n掉落：" .. GetItem(nodes[mapFile][coord][7]);
                desc = desc.."\n掉落信息：" .. nodes[mapFile][coord][3];
            else
                desc = desc.."\n掉落：" .. nodes[mapFile][coord][3];
            end
        end

        if (nodes[mapFile][coord][4] ~= "") and (Argus.db.profile.show_notes == true) then
            desc = desc.."\n注释：" .. nodes[mapFile][coord][4]
        end

        if not DBMArrow.Desc:IsShown() then
            DBMArrow.Desc:Show()
        end

        x = x*100
        y = y*100
        DBMArrow.Desc:SetText(desc)
        DBM.Arrow:ShowRunTo(x, y, nil, nil, true)
    end
end

local function generateMenu(button, level)
    if (not level) then return end

    for k in pairs(info) do info[k] = nil end

    if (level == 1) then
        info.isTitle = 1
        info.text = "Argus"
        info.notCheckable = 1
        UIDropDownMenu_AddButton(info, level)
        
        info.disabled = nil
        info.isTitle = nil
        info.notCheckable = nil
        info.text = "从地图上移除此物件"
        info.func = LRTDisableTreasure
        info.arg1 = clickedMapFile
        info.arg2 = clickedCoord
        UIDropDownMenu_AddButton(info, level)
        
        if isTomTomloaded == true then
            info.text = "在 TomTom 添加此路径点位置"
            info.func = LRTaddtoTomTom
            info.arg1 = clickedMapFile
            info.arg2 = clickedCoord
            UIDropDownMenu_AddButton(info, level)
        end

        if isDBMloaded == true then
            info.text = "在 DBM 中添加此财宝箭头"
            info.func = LRTAddDBMArrow
            info.arg1 = clickedMapFile
            info.arg2 = clickedCoord
            UIDropDownMenu_AddButton(info, level)
            
            info.text = "隐藏 DBM 箭头"
            info.func = LRTHideDBMArrow
            UIDropDownMenu_AddButton(info, level)
        end

        info.text = CLOSE
        info.func = function() CloseDropDownMenus() end
        info.arg1 = nil
        info.arg2 = nil
        info.notCheckable = 1
        UIDropDownMenu_AddButton(info, level)

        info.text = "恢复已移除物件"
        info.func = LRTResetDB
        info.arg1 = nil
        info.arg2 = nil
        info.notCheckable = 1
        UIDropDownMenu_AddButton(info, level)
        
    end
end

local HandyNotes_ArgusDropdownMenu = CreateFrame("Frame", "HandyNotes_ArgusDropdownMenu")
HandyNotes_ArgusDropdownMenu.displayMode = "MENU"
HandyNotes_ArgusDropdownMenu.initialize = generateMenu

function Argus:OnClick(button, down, mapFile, coord)
    if button == "RightButton" and down then
        clickedMapFile = mapFile
        clickedCoord = coord
        ToggleDropDownMenu(1, nil, HandyNotes_ArgusDropdownMenu, self, 0, 0)
    end
end

function Argus:OnLeave(mapFile, coord)
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

local options = {
    type = "group",
    name = "阿古斯稀有和财宝",
    desc = "阿古斯稀有和财宝位置",
    get = function(info) return Argus.db.profile[info.arg] end,
    set = function(info, v) Argus.db.profile[info.arg] = v; Argus:Refresh() end,
    args = {
        desc = {
            name = "常用设置",
            type = "description",
            order = 0,
        },
        icon_scale_treasures = {
            type = "range",
            name = "财宝图标大小",
            desc = "图标的大小",
            min = 0.25, max = 3, step = 0.01,
            arg = "icon_scale_treasures",
            order = 1,
        },
        icon_scale_rares = {
            type = "range",
            name = "稀有图标大小",
            desc = "图标的大小",
            min = 0.25, max = 3, step = 0.01,
            arg = "icon_scale_rares",
            order = 2,
        },
        icon_alpha = {
            type = "range",
            name = "图标透明度",
            desc = "图标的透明度",
            min = 0, max = 1, step = 0.01,
            arg = "icon_alpha",
            order = 20,
        },
        VisibilityOptions = {
            type = "group",
            name = "可见性设定",
            desc = "可见性设定",
            args = {
                VisibilityGroup = {
                    type = "group",
                    order = 0,
                    name = "选择哪些区域要显示什么：",
                    inline = true,
                    args = {
                        groupAW = {
                            type = "header",
                            name = "安托兰废土",
                            desc = "安托兰废土",
                            order = 0,
                        },
                        treasureAW = {
                            type = "toggle",
                            arg = "treasure_aw",
                            name = "财宝",
                            desc = "财宝会提供很多物品",
                            order = 1,
                            width = "normal",
                        },
                        rareAW = {
                            type = "toggle",
                            arg = "rare_aw",
                            name = "稀有",
                            desc = "稀有刷新",
                            order = 2,
                            width = "normal",
                        },
                        petAW = {
                            type = "toggle",
                            arg = "pet_aw",
                            name = "战斗宠物",
                            order = 3,
                            width = "normal",
                        },
                        groupKR = {
                            type = "header",
                            name = "克罗库恩",
                            desc = "克罗库恩",
                            order = 10,
                        },  
                        treasureKR = {
                            type = "toggle",
                            arg = "treasure_kr",
                            name = "财宝",
                            desc = "财宝会提供很多物品",
                            width = "normal",
                            order = 11,
                        },
                        rareKR = {
                            type = "toggle",
                            arg = "rare_kr",
                            name = "稀有",
                            desc = "稀有刷新",
                            width = "normal",
                            order = 12,
                        },
                        petKR = {
                            type = "toggle",
                            arg = "pet_kr",
                            name = "战斗宠物",
                            width = "normal",
                            order = 13,
                        },
                        groupMA = {
                            type = "header",
                            name = "玛凯雷",
                            desc = "玛凯雷",
                            order = 20,
                        },  
                        treasureMA = {
                            type = "toggle",
                            arg = "treasure_ma",
                            name = "财宝",
                            desc = "财宝会提供很多物品",
                            width = "normal",
                            order = 21,
                        },
                        rareMA = {
                            type = "toggle",
                            arg = "rare_ma",
                            name = "稀有",
                            desc = "稀有刷新",
                            width = "normal",
                            order = 22,
                        },  
                        petMA = {
                            type = "toggle",
                            arg = "pet_ma",
                            name = "战斗宠物",
                            width = "normal",
                            order = 23,
                        },  
                    },
                },
                alwaysshowrares = {
                    type = "toggle",
                    arg = "alwaysshowrares",
                    name = "总是显示已拾取的稀有",
                    desc = "显示每个稀有无论是否已拾取状态",
                    order = 100,
                    width = "full",
                },
                alwaysshowtreasures = {
                    type = "toggle",
                    arg = "alwaysshowtreasures",
                    name = "总是显示已拾取的财宝",
                    desc = "显示每个财宝无论是否已拾取状态",
                    order = 101,
                    width = "full",
                },
                show_loot = {
                    type = "toggle",
                    arg = "show_loot",
                    name = "显示掉落",
                    desc = "显示每个财宝/稀有的掉落",
                    order = 102,
                },
                show_notes = {
                    type = "toggle",
                    arg = "show_notes",
                    name = "显示注释",
                    desc = "当可用时显示每个财宝/稀有的注释",
                    order = 103,
                },
            },
        },
    },
}

function Argus:OnInitialize()
    local defaults = {
        profile = {
            icon_scale_treasures = 1.5,
            icon_scale_rares = 1.5,
            icon_alpha = 1.00,
            alwaysshowrares = false,
            alwaysshowtreasures = false,
            save = true,
            treasure_aw = true,
            treasure_kr = true,
            treasure_ma = true,
            rare_aw = true,
            rare_kr = true,
            rare_ma = true,
			pet_aw = true,
			pet_kr = true,
			pet_ma = true,
            show_loot = true,
            show_notes = true,
        },
    }

    self.db = LibStub("AceDB-3.0"):New("HandyNotesArgusDB", defaults, "Default")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "WorldEnter")
end

function Argus:WorldEnter()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self:ScheduleTimer("RegisterWithHandyNotes", 8)
	self:ScheduleTimer("LoadCheck", 6)
end

function Argus:RegisterWithHandyNotes()
    do
        local function iter(t, prestate)
            if not t then return nil end

            local state, value = next(t, prestate)

            while state do

                -- QuestID[1], Name[2], Loot[3], Notes[4], Icon[5], Tag[6], ItemID[7]
                if (value[1] and self.db.profile[value[6]] and not Argus:HasBeenLooted(value)) then
                    if ((value[7] ~= nil) and (type(value[7]) == "number")) then
                        GetIcon(value[7]) --this should precache the Item, so that the loot is correctly returned
                    elseif ((value[7] ~= nil) and (type(value[7]) == "table")) then
						local ii
						for ii = 1, #value[7] do
							GetIcon(value[7][ii][1]) -- this should precache the Item, so that the loot is correctly returned
						end
                    end

                    if ((value[5] == "default") or (value[5] == "unknown")) then
                        if ((value[7] ~= nil) and (value[7] ~= "")) then
                            return state, nil, GetIcon(value[7]), Argus.db.profile.icon_scale_treasures, Argus.db.profile.icon_alpha
                        else
                            return state, nil, iconDefaults[value[5]], Argus.db.profile.icon_scale_treasures, Argus.db.profile.icon_alpha
                        end
                    end

                    return state, nil, iconDefaults[value[5]], Argus.db.profile.icon_scale_rares, Argus.db.profile.icon_alpha
                end

                state, value = next(t, state)
            end
        end

        function Argus:GetNodes(mapFile, isMinimapUpdate, dungeonLevel)
            return iter, nodes[mapFile], nil
        end
    end

    HandyNotes:RegisterPluginDB("HandyNotesArgus", self, options)
    self:RegisterBucketEvent({ "LOOT_CLOSED" }, 2, "Refresh")
    self:Refresh()
end
 
function Argus:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotesArgus")
end

function Argus:HasBeenLooted(value)
    if (self.db.profile.alwaysshowtreasures and (string.find(value[6], "treasure") ~= nil)) then return false end
    if (self.db.profile.alwaysshowrares and (string.find(value[6], "treasure") == nil)) then return false end
    if (value[1] and value[1] == 0) then return false end
    if (Argus.db.char[value[1]] and self.db.profile.save) then return true end
    if (IsQuestFlaggedCompleted(value[1])) then
        return true
    end

    return false
end

function Argus:LoadCheck()
	if (IsAddOnLoaded("TomTom")) then 
		isTomTomloaded = true
	end

	if (IsAddOnLoaded("DBM-Core")) then 
		isDBMloaded = true
	end

	if isDBMloaded == true then
		local ArrowDesc = DBMArrow:CreateFontString(nil, "OVERLAY", "GameTooltipText")
		ArrowDesc:SetWidth(400)
		ArrowDesc:SetHeight(100)
		ArrowDesc:SetPoint("CENTER", DBMArrow, "CENTER", 0, -35)
		ArrowDesc:SetTextColor(1, 1, 1, 1)
		ArrowDesc:SetJustifyH("CENTER")
		DBMArrow.Desc = ArrowDesc
	end
end
