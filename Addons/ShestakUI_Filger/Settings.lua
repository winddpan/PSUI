local Misc = CreateFrame("Frame")
local Media = "Interface\\AddOns\\ShestakUI_Filger\\Media\\"
Misc.Media = Media

-- ShestakUI_Filger.lua
Misc.font = Media.."number.ttf"
Misc.barfg = Media.."White"
Misc.back = Misc.Media.."HalBackground"
Misc.border = Misc.Media.."GlowTex"
Misc.barbg = Misc.Media.."Texture"

Misc.modefg = "OWN"					-- 计时条颜色
Misc.modeback = "Black"				-- 图标背景
Misc.modeborder = "Green"			-- 边框颜色
Misc.numsize = 14					-- 层数, 计时条的计时数字大小
Misc.namesize = 14					-- 法术名称字体大小
Misc.maxTestIcon = 8				-- 测试模式下,每项显示最大图标数量
Misc.mult = 1 

-- 命名空间
local _, ns = ...
ns.Misc = Misc
