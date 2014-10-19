-- ����
local Misc = CreateFrame("Frame")
local Media = "Interface\\AddOns\\ShestakUI_Filger\\Media\\"
Misc.Media = Media

-- ShestakUI_Filger.lua
Misc.font = Media.."number.ttf"
Misc.barfg = Media.."White"			-- ��ʱ������
Misc.modefg = "OWN"					-- ��ʱ����ɫ
Misc.modeback = "Black"				-- ͼ�걳�����ɰ���ɫ��һ���غ�ë������ʽ��Ч��
Misc.modeborder = "Black"			-- �߿���ɫ
Misc.numsize = 14					-- ����, ��ʱ���ļ�ʱ���ִ�С
Misc.namesize = 14					-- �������������С
Misc.maxTestIcon = 8				-- ����ģʽ��,ÿ����ʾ���ͼ������

-- Cooldowns.lua
Misc.cdsize = 16					-- ͼ���м�� CD ���ִ�С

-- config.lua
Misc.Tbar = "OFF"					-- ��(ON)\��(OFF) target_bar Ŀ���ʱ��
Misc.Pbar = "OFF"					-- ��(ON)\��(OFF) pve_cc ��ʱ��
Misc.barw = 180						-- ��ʱ������
Misc.CDnum = 5						-- COOLDOWN ��ȴͼ��ÿ����ʾ����

-------------------------------------------------------- 
getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")) 
getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d")) 

--   Pixel perfect script of custom ui Scale 
UIScale = function() 
   uiscale = min(2, max(0.64, 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)"))) 
end 
UIScale() 

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / uiscale 
local Scale = function(x) 
   return mult * math.floor(x / mult + 0.5) 
end 
Misc.mult = mult 
----------------------- ShestakUI_Filger_1px -----------------------

-- �����ռ�
local _, ns = ...
ns.Misc = Misc
