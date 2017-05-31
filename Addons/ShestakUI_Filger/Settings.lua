local Colors = {
	["DK"]		= {r = .77, g = .12, b = .23},
	["DLY"]		= {r = 1, g = 0.49, b = .04},
	["LR"]		= {r = .67, g = .83, b = .45},
	["FS"]		= {r = .41, g = .8, b = .94},
	["WS"]		= {r = 0, g = 1, b = .59},
	["QS"]		= {r = .96, g = .55, b = .73},
	["MS"]		= {r = 1, g = 1, b = 1},
	["DZ"]		= {r = 1, g = .96, b = .41},
	["SM"]		= {r = 0, g = .44, b = .87},
	["SS"]		= {r = .58, g = .51, b = .79},
	["ZS"]		= {r = .78, g = .61, b = .43},
	["Black"]	= {r = 0, g = 0, b = 0},
	["Gray"]	= {r = .37, g = .3, b = .3},
	["Green"]   = { r = 49/255, g = 213/255, b = 78/255},
	["Red"]     = { r = 249/255, g = 51/255, b = 26/255},
	["OWN"]		= RAID_CLASS_COLORS[class],
}

local Misc = CreateFrame("Frame")
local Media = "Interface\\AddOns\\ShestakUI_Filger\\Media\\"
Misc.Media = Media
Misc.Colors = Colors

-- ShestakUI_Filger.lua
Misc.font = Media.."number.ttf"
Misc.barfg = Media.."White"
Misc.back = Misc.Media.."HalBackground"
Misc.border = Misc.Media.."GlowTex"
Misc.barbg = Misc.Media.."Texture"

Misc.modefg = "OWN"					-- ��ʱ����ɫ
Misc.modeback = "Black"				-- ͼ�걳��
Misc.modeBuffBorder = "Green"
Misc.modeDebuffBorder = "Red"
Misc.numsize = 14					-- ����, ��ʱ���ļ�ʱ���ִ�С
Misc.namesize = 14					-- �������������С
Misc.maxTestIcon = 8				-- ����ģʽ��,ÿ����ʾ���ͼ������
Misc.mult = 1 

-- �����ռ�
local _, ns = ...
ns.Misc = Misc
