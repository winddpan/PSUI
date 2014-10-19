  local addon, ns = ...
  local cfg = ns.cfg
  local lib = ns.lib
  local playerClass = select(2, UnitClass('player'))
  if playerClass ~= 'DEATHKNIGHT' then return end

  local RuneColor = {
    [1] = {r = 0.7, g = 0.1, b = 0.1},
    [2] = {r = 0.7, g = 0.1, b = 0.1},
    [3] = {r = 0.4, g = 0.8, b = 0.2},
    [4] = {r = 0.4, g = 0.8, b = 0.2},
    [5] = {r = 0.0, g = 0.6, b = 0.8},
    [6] = {r = 0.0, g = 0.6, b = 0.8},
  }

  local rownum = 6 / cfg.lineNum
  local f = CreateFrame('Frame', "PSRune_frame", UIParent)
  f:SetSize(1, 1)
  f:EnableMouse(false)
  f:RegisterEvent('PLAYER_ENTERING_WORLD')
  f:RegisterEvent('RUNE_TYPE_UPDATE')
  f:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
  f:RegisterEvent('UNIT_POWER')
  
  f.Rune = CreateFrame("Frame", nil, f)

  local runeAnchor = lib.cAnchor(f.Rune, "PSRuneFrame",cfg.defaultPos)
  runeAnchor:SetSize(cfg.runeWidth *rownum +(rownum-1)*cfg.spacing, 50)
	
  ----------------------------------------
  -- sort function --
  ---------------------------------------- 
  local runeFrames = {}
  for i=0,5 do
    local frame = {"TOPLEFT", runeAnchor, "BOTTOMLEFT", (cfg.spacing+ cfg.runeWidth) * (i - floor(i/rownum) * rownum), -(cfg.spacing+ cfg.runeHeight) *string.format("%d",i/rownum)}
    
    table.insert( runeFrames, frame )
    --print(frame[4].."   y:"..frame[5].."   index:"..i)
  end

  local sortFlag = false
  local cdCmp = function(a,b)
    local startA,_,_ = GetRuneCooldown(a)
    local startB,_,_ = GetRuneCooldown(b)

    return GetTime() -startA > GetTime() -startB
  end
  local function sortrunesByTypes()
    sortFlag = true
    local runemap = { [1] = {},[2] = {},[3] = {},[4] = {} }
    for i=1, 6 do
    local runeType = GetRuneType(i)
      table.insert( runemap[runeType], i )
    end
    
    for i=1, 4 do
      table.sort(runemap[i],cdCmp) 
    end

    local sequence = cfg.runesequence
    local index = 0
    for i=1,4 do
      for j,rid in ipairs(runemap[sequence[i]]) do
      index = index+1
      f.Rune[rid]:SetPoint(unpack(runeFrames[index]))
      end
    end

  end
  
  ----------------------------------------
  -- init frames --
  ----------------------------------------
  for i = 1, 6 do 
    RuneFrame:UnregisterAllEvents()
    _G['RuneButtonIndividual'..i]:Hide()
  end

  for i = 1, 6 do
    r = CreateFrame("StatusBar", f:GetName().."_Runes"..i, f)
    r:SetMinMaxValues(0, 1)
    r:SetSize(cfg.runeWidth, cfg.runeHeight)
    r:SetFrameLevel(11)
    r:SetPoint(unpack(runeFrames[i]))
    r:SetStatusBarTexture("Interface\\addons\\PSRune\\media\\statusbarTexture")
    r:GetStatusBarTexture():SetHorizTile(false)
    lib.createShadow(r)
    f.Rune[i] = r
    
    f.Rune[i].bg = f.Rune[i]:CreateTexture(nil, "BORDER")
    f.Rune[i].bg:SetAllPoints()
    f.Rune[i].bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
  end

  f.powerbar = CreateFrame("StatusBar", f:GetName().."_Powerbar", f)
  f.powerbar:SetMinMaxValues(0, 100)
  f.powerbar:SetSize(cfg.powerbarWdith, cfg.powerbarHeight)
  f.powerbar:SetFrameLevel(11)
  f.powerbar:SetPoint(unpack(cfg.powerbarPos))
  f.powerbar:SetStatusBarTexture("Interface\\addons\\PSRune\\media\\statusbarTexture")
  f.powerbar:GetStatusBarTexture():SetHorizTile(false)
  f.powerbar:SetValue(0)
  lib.createShadow(f.powerbar)
  if not cfg.powerbarEnable then f.powerbar:Hide() end


  f.powerbarValue = f:CreateFontString(nil, 'ARTWORK')
  f.powerbarValue:SetFont(cfg.powerValueFont, cfg.powerValueSize)
  f.powerbarValue:SetShadowOffset(1, -1)
  f.powerbarValue:SetPoint(unpack(cfg.powerValuePos))

  local unitPower = PowerBarColor["RUNIC_POWER"]
  f.powerbarValue:SetTextColor(unitPower.r, unitPower.g, unitPower.b)

  ----------------------------------------
  -- update rune function --
  ----------------------------------------
  local function SetRuneColor(i)
    if (f.Rune[i].type == 4) then
      return 1, 0, 1
    else
      return RuneColor[i].r, RuneColor[i].g, RuneColor[i].b
    end
  end

  local OnUpdate = function(self, elapsed)
    local duration = self.duration + elapsed

    if(duration >= self.max) then
      return self:SetScript("OnUpdate", nil)
    else
      self.duration = duration
    if cfg.fadeEnable then
     self:SetAlpha(duration/self.cooldown)
    end
      return self:SetValue(duration)
    end
  end

  local UpdateRune = function(rune, rid)
    if(not rune) then return end

	rune.type = GetRuneType(rid)
    rune:SetStatusBarColor(SetRuneColor(rid))
  
  local r,g,b = SetRuneColor(rid)
    rune.bg:SetVertexColor(r,g,b,.15)
  
    local start, duration, runeReady = GetRuneCooldown(rid)
    rune.cooldown = duration
    if(runeReady) then
      rune:SetAlpha(1)
      rune:SetMinMaxValues(0, 1)
      rune:SetValue(1)
      rune:SetScript("OnUpdate", nil)
    else
      rune.duration = GetTime() - start
      rune.max = duration
      rune:SetMinMaxValues(1, duration)
      rune:SetScript("OnUpdate", OnUpdate)
    end
  end
  
  ----------------------------------------
  -- update powerbar function --
  ----------------------------------------
  local function UpdateBarColor()
    local _, powerType, altR, altG, altB = UnitPowerType('player')
    local unitPower = PowerBarColor[powerType]
    
    if (unitPower) then
        f.powerbar:SetStatusBarColor(unitPower.r, unitPower.g, unitPower.b)
    else
        f.powerbar:SetStatusBarColor(altR, altG, altB)
    end
  end
  
  local function UpdateBarValue()
    f.powerbarValue:SetText(UnitPower('player') > 0 and UnitPower('player') or '')
  end
  
  local function UpdateBar()
    if cfg.powerbarEnable then
    f.powerbar:SetMinMaxValues(0, UnitPowerMax('player', f))
    f.powerbar:SetValue(UnitPower('player'))
  end
  end
  
  ----------------------------------------
  -- function driver --
  ----------------------------------------
  f:SetScript('OnEvent', function(self, event, arg1)
    if event == 'PLAYER_ENTERING_WORLD' or event == 'ACTIVE_TALENT_GROUP_CHANGED' then
      sortFlag = false
    end
    if event == 'RUNE_TYPE_UPDATE' then
      f.Rune[arg1].type = GetRuneType(arg1)
      if cfg.sortFunction then sortrunesByTypes() end
    end
	if event =='UNIT_POWER' or event == 'PLAYER_ENTERING_WORLD' then
		if cfg.powerbarEnable then
            UpdateBarColor()  
            UpdateBar()  
        end
		UpdateBarValue()
	end
  end)

  local updateTimer = 0
  local updateTimer2 = 0

  f:SetScript('OnUpdate', function(self, elapsed)
    updateTimer = updateTimer + elapsed
    updateTimer2 = updateTimer2 + elapsed

    if (updateTimer > 0.1) then
	  if f.Rune then
        for i = 1, 6 do
          if (UnitHasVehicleUI('player')) then
            if (f.Rune[i]:IsShown()) then
              f.Rune[i]:Hide()
            end
          else
            if (not f.Rune[i]:IsShown()) then
              f.Rune[i]:Show()
            end
          end
      
          --初始化排列一次，以后由事件触发
          if not sortFlag  and cfg.sortFunction then
		    sortrunesByTypes()
		  end
          UpdateRune(f.Rune[i], i)

        end --end for
		
      end
      updateTimer   = 0
	end
	
	if (updateTimer2 > 1.5) then
	  if cfg.sortFunction then 
	    sortrunesByTypes() 
	  end
	  updateTimer2 = 0
	end

  end)
  
  ----------------------------------------
  -- SlashCMD --
  ----------------------------------------
  SlashCmdList["PSRune"] = function(msg) 
    if msg:lower() =="" then
		if runeAnchor:IsVisible() then 
			print("|cff3399FFPSRune Lock!|r")
			runeAnchor:Hide()
		else 
			print("|cff3399FFPSRune UnLock!|r")
			runeAnchor:Show()
		end
	elseif msg:lower() == "reset" then
		print("|cff3399FFPSRune Reset!|r")
		wipe(PSRuneDB)
		runeAnchor:SetPoint(unpack(cfg.defaultPos))
	else
		print("/DKH reset  ---- 恢复默认位置")
	end
  end
  SLASH_PSRune1 = "/PSRUNE"
  SLASH_PSRune2 = "/PSR"
