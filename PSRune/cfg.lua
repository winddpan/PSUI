  local addon, ns = ...
  local cfg = CreateFrame("Frame")
  
  cfg.defaultPos = {"CENTER", UIParent, 0, -135}

  --符文设置
  cfg.runeWidth = 50
  cfg.runeHeight = 14
  cfg.spacing = 3
  cfg.lineNum = 3
  
  cfg.fadeEnable = true
  cfg.sortFunction = true
  cfg.runesequence = { 4,2,3,1 }

  --符文能量条设置
  cfg.powerbarEnable = true
  cfg.powerbarPos = {"BOTTOM", "PSRuneFrame", "BOTTOM", 0 , 8}
  cfg.powerbarWdith = 80
  cfg.powerbarHeight = 12
  
  --符文能量文字设置
  cfg.powerValuePos = {"BOTTOM", "PSRuneFrame", "BOTTOM", 0 , 28}
  cfg.powerValueFont = 'Interface\\addons\\PSRune\\media\\font.ttf'
  cfg.powerValueSize = 20
  
  
  
  local t = CreateFrame('Frame')
  t:RegisterEvent('PLAYER_ENTERING_WORLD')
  t:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
  ------------------------------
  --根据天赋自动排列符文显示顺序
  --------1血 2邪 3冰 4死-------
  t:SetScript("OnEvent", function(self, event, ...)
	if GetSpecialization() == 1 then	-- 血天赋
	  cfg.runesequence = { 4,1,2,3 }
	elseif GetSpecialization() == 2 then	-- 冰天赋
	  cfg.runesequence = { 4,3,2,1 }    --冰天赋没有血符文放最后
	elseif GetSpecialization() == 3 then	--邪天赋
	  cfg.runesequence = { 4,2,3,1 }
	end
  end)
  
  -- HANDOVER
  ns.cfg = cfg