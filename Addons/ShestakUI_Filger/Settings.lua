local Misc = CreateFrame("Frame")
local Media = "Interface\\AddOns\\ShestakUI_Filger\\Media\\"
Misc.Media = Media

-- ShestakUI_Filger.lua
Misc.font = Media.."number.ttf"
Misc.barfg = Media.."White"
Misc.back = Misc.Media.."HalBackground"
Misc.border = Misc.Media.."GlowTex"
Misc.barbg = Misc.Media.."Texture"

Misc.modefg = "OWN"					-- ��ʱ����ɫ
Misc.modeback = "Black"				-- ͼ�걳��
Misc.modeborder = "Green"			-- �߿���ɫ
Misc.numsize = 14					-- ����, ��ʱ���ļ�ʱ���ִ�С
Misc.namesize = 14					-- �������������С
Misc.maxTestIcon = 8				-- ����ģʽ��,ÿ����ʾ���ͼ������
Misc.mult = 1 

-- �����ռ�
local _, ns = ...
ns.Misc = Misc
