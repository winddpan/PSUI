local class = select(2, UnitClass("player"))
local Colors = {
	["OwnClass"] = RAID_CLASS_COLORS[class],
	["Black"]	= {r = 0, g = 0, b = 0},
	["Gray"]	= {r = .37, g = .3, b = .3},
	["Green"]   = { r = 49/255, g = 213/255, b = 78/255},
	["Red"]     = { r = 249/255, g = 51/255, b = 26/255},
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

Misc.barColor = "OwnClass"					-- ��ʱ����ɫ
Misc.backdropColor = "Black"				-- ͼ�걳��
Misc.buffBorderColor = "Green"
Misc.debuffBorderColor = "Red"
Misc.numSize = 14					-- ����, ��ʱ���ļ�ʱ���ִ�С
Misc.barNumSize = 12				-- ��ʱ���ļ�ʱ���ִ�С
Misc.barNameSize = 12				-- ��ʱ���������������С
Misc.maxTestIcon = 8				-- ����ģʽ��,ÿ����ʾ���ͼ������
Misc.mult = 1 

-- �����ռ�
local _, ns = ...
ns.Misc = Misc
