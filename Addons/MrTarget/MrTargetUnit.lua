-- MrTargetUnit
-- =====================================================================
-- Copyright (C) 2016 Lock of War, Renevatium
--

local POWER_BAR_COLORS = {
  MANA={ r=0.00,g=0.00,b=1.00 },
  RAGE={ r=1.00,g=0.00,b=0.00 },
  FOCUS={ r=1.00,g=0.50,b=0.25 },
  ENERGY={ r=1.00,g=1.00,b=0.00 },
  CHI={ r=0.71,g=1.0,b=0.92 },
  RUNES={ r=0.50,g=0.50,b=0.50 }
};

local LFGRoleTexCoords = { TANK={ 0.5,0.75,0,1 }, DAMAGER={ 0.25,0.5,0,1 }, HEALER={ 0.75,1,0,1 }};
local function GetTexCoordsForRole(role, borderless)
  role = role or 'DAMAGER';
  local c = borderless and LFGRoleTexCoords[role] or {GetTexCoordsForRoleSmallCircle(role)};
  return unpack(c);
end

MrTargetUnit = {
  update=0,
  parent=0,
  dead=false,
  test=false,
  name=nil,
  icon=nil,
  display=nil,
  unit=nil,
  frame=nil,
  spec=nil,
  class=nil,
  role=nil,
  health=1,
  healthMax=1,
  power=1,
  powerMax=1,
  targeted='',
  range=nil,
  track=nil,
  last_update=0,
  update_targeted=true,
  enemy=false,
  auras=nil
};

MrTargetUnit.__index = MrTargetUnit;

function MrTargetUnit:New(parent, count)
  local this = setmetatable({}, MrTargetUnit);
  this.parent = parent;
  this.frame = CreateFrame('Button', parent.frame:GetName()..'MrTargetUnit'..count, parent.frame, 'MrTargetUnitTemplate');
  this.frame:SetScript('OnEvent', function(frame, ...) this:OnEvent(...); end);
  this.frame:SetScript('OnUpdate', function(frame, ...) this:OnUpdate(...); end);
  this.frame:SetScript('OnEnter', function(frame, ...) this:OnEnter(...); end);
  this.frame:SetScript('OnLeave', function(frame, ...) this:OnLeave(...); end);
  this.frame:SetScript('OnDragStart', function(frame, ...) parent:OnDragStart(...); end);
  this.frame:SetScript('OnDragStop', function(frame, ...) parent:OnDragStop(...); end);
  this.frame.UPDATE_TARGETED:SetScript('OnUpdate', function(frame, ...) this:UpdateTargeted(...); end);
  this.frame:EnableMouse(true);
  this.frame:RegisterForDrag('RightButton');
  this.frame:RegisterForClicks('LeftButtonUp', 'RightButtonUp');
  this.frame:SetAttribute('type1', 'macro');
  this.frame:SetAttribute('type2', 'macro');
  this.frame:SetAttribute('macrotext1', '');
  this.frame:SetAttribute('macrotext2', '');
  this.auras = MrTargetAuras:New(this);
  this.track = MrTargetRange:New(this);
  return this;
end

function MrTargetUnit:SetUnit(unit, name, display, class, spec, role, icon, test)
  self.unit = unit;
  self.frame.unit = unit;
  self.name = name;
  self.display = display;
  self.class = class;
  self.spec = spec;
  self.role = role;
  self.icon = icon;
  self.test = test;
  self:RegisterEvents();
  self:SetFrameStyle();
  self.frame:Show();
end

function MrTargetUnit:UnsetUnit()
  self.name = nil;
  self.display = nil;
  self.class = nil;
  self.spec = nil;
  self.role = nil;
  self.unit = nil;
  self.frame.unit = nil;
  self.dead = false;
  self.test = false;
  self.frame.SPEC:SetText('');
  self.frame.SPEC_ICON:SetTexture(nil);
  self.frame.NAME:SetText('');
  self.health = 1;
  self.healthMax = 1;
  self.power = 1;
  self.powerMax = 1;
  self:UnregisterEvents();
  self:Hide();
end

function MrTargetUnit:PlayerRegenEnabled()
  self.frame:UnregisterEvent('PLAYER_REGEN_ENABLED');
  self.frame:SetAttribute('macrotext1', nil);
  self.frame:SetAttribute('macrotext2', nil);
  self.frame:Hide();
end

function MrTargetUnit:Hide()
  if InCombatLockdown() then
    self.frame:RegisterEvent('PLAYER_REGEN_ENABLED');
  else
    self.frame:Hide();
  end
end

function MrTargetUnit:Destroy()
  self:UnsetUnit();
  self.auras:Destroy();
end

function MrTargetUnit:UnitHealthColor(alpha)
  local color = RAID_CLASS_COLORS[self.class];
  self.frame.HEALTH_BAR:SetStatusBarColor(color.r, color.g, color.b, alpha);
  self.frame.HEALTH_BAR.r, self.frame.HEALTH_BAR.g, self.frame.HEALTH_BAR.b, self.frame.HEALTH_BAR.alpha = color.r, color.g, color.b, alpha;
end

function MrTargetUnit:UnitPowerColor(alpha)
  local powerType, powerToken = UnitPowerType(self.name);
  local color = POWER_BAR_COLORS[powerToken] or POWER_BAR_COLORS.MANA;
  self.frame.POWER_BAR:SetStatusBarColor(color.r, color.g, color.b, alpha);
end

function MrTargetUnit:SetAlpha(alpha)
  self:UnitHealthColor(alpha);
  self:UnitPowerColor(alpha);
  self.frame.NAME:SetTextColor(1, 1, 1, alpha)
  self.frame.SPEC_ICON:SetAlpha(alpha);
  self.frame:SetAlpha(alpha);
end

function MrTargetUnit:UnitUpdate()
  if self.unit then
    self.last_update = GetTime();
    self.enemy = UnitIsEnemy(self.unit, 'player');
    self.health = UnitHealth(self.unit);
    self.healthMax = UnitHealthMax(self.unit);
    self.power = UnitPower(self.unit);
    self.powerMax = UnitPowerMax(self.unit);
    if UnitIsDeadOrGhost(self.unit) or UnitHealth(self.unit) == 0 then
      self.health = 0;
      self.power = 0;
      self.range = nil;
      self.dead = true;
      self.auras:Destroy();
    else
      self.auras:UnitAura(self.unit);
      self.dead = false;
    end
  end
end

function MrTargetUnit:UnitCheck(unit)
  if self:GetUnit(unit) then
    self:UnitUpdate();
  end
end

function MrTargetUnit:UpdateTargeted(unit)
  if MrTarget:GetOption('TARGETED') then
    if self.update_targeted then
      self.targeted = 0;
      self.update_targeted = false;
      for i=1, GetNumGroupMembers() do
        if GetUnitName('raid'..i..'target', true) == self.name then
          self.targeted = self.targeted+1;
        end
      end
      self.targeted = self.targeted>0 and self.targeted or '';
      self.update_targeted = true;
    end
  end
end

function MrTargetUnit:GetUnit(unit)
  self.unit = false;
  if UnitExists(unit) then
    if GetUnitName(unit, true) == self.name then
      self.unit = unit;
    elseif GetUnitName(unit..'target', true) == self.name then
      self.unit = unit..'target';
    end
  end
  self.frame.unit = self.unit;
  return self.unit;
end

function MrTargetUnit:UnitLost()
  for i=1, GetNumGroupMembers() do
    local unit = self.enemy and 'raid'..i..'target' or 'raid'..i;
    if GetUnitName(unit, true) == self.name then
      self.unit = unit;
      self.frame.unit = unit;
      self:UnitUpdate();
      return;
    end
  end
  self.auras:Destroy();
end

function MrTargetUnit:OnUpdate(time)
  self.update = self.update + time;
  if self.update < 0.1 then
    return;
  end
  self.update = 0;
  self:UpdateDisplay();
end

function MrTargetUnit:UpdateDisplay()
  self.frame.NAME:SetText(self.display);
  self.frame.SPEC:SetText(self.spec);
  self.frame.SPEC_ICON:SetTexture(self.icon);
  self.frame.SPEC_ICON:SetAlpha(1);
  self.frame.HEALTH_BAR:SetMinMaxValues(0, self.healthMax);
  self.frame.HEALTH_BAR:SetValue(self.health);
  self.frame.POWER_BAR:SetMinMaxValues(0, self.powerMax);
  self.frame.POWER_BAR:SetValue(self.power);
  self.frame.TARGETED:SetText(self.targeted);
  self:UnitHealthColor(1);
  self:UnitPowerColor(1);
  self:ResetTargetMacro();
  if GetTime() - self.last_update > 3 and not self.test then
    if GetTime() - self.last_update > 30 then
      self.health = self.healthMax;
      self.power = self.powerMax;
    end
    self:SetAlpha(0.5);
    self:UnitLost();
  elseif MrTarget:GetOption('RANGE') and self.range == nil then
    self:SetAlpha(0.5);
  else
    self:SetAlpha(1);
  end
end

function MrTargetUnit:ResetTargetMacro()
  if not InCombatLockdown() then
    self.frame:SetAttribute('macrotext1', '/targetexact '..self.name);
    self.frame:SetAttribute('macrotext2', '/targetexact '..self.name..'\n/focus\n/targetlasttarget');
  end
end

function MrTargetUnit:OnEnter() self.frame.HOVER:Show(); end
function MrTargetUnit:OnLeave() self.frame.HOVER:Hide(); end

function MrTargetUnit:OnEvent(event, unit, x, y, z)
  if event == 'UNIT_HEALTH_FREQUENT' then self:UnitCheck(unit);
  elseif event == 'UNIT_COMBAT' then self:UnitCheck(unit);
  elseif event == 'UNIT_TARGET' then self:UnitCheck(unit);
  elseif event == 'UPDATE_MOUSEOVER_UNIT' then self:UnitCheck('mouseover');
  elseif event == 'PLAYER_REGEN_ENABLED' then self:PlayerRegenEnabled();
  end
end

function MrTargetUnit:RegisterEvents()
  self.frame:RegisterEvent('UNIT_HEALTH_FREQUENT');
  self.frame:RegisterEvent('UPDATE_MOUSEOVER_UNIT');
  self.frame:RegisterEvent('UNIT_COMBAT');
  self.frame:RegisterEvent('UNIT_TARGET');
end

function MrTargetUnit:UnregisterEvents()
  self.frame:UnregisterEvent('UNIT_HEALTH_FREQUENT');
  self.frame:UnregisterEvent('UPDATE_MOUSEOVER_UNIT');
  self.frame:UnregisterEvent('UNIT_COMBAT');
  self.frame:UnregisterEvent('UNIT_TARGET');
end

function MrTargetUnit:SetFrameStyle()
  if MrTarget:GetOption('BORDERLESS') then
    self:SetStyleBorderless();
  else
    self:SetStyleDefault();
  end
end

function MrTargetUnit:GetPosition()
  for i=1, self.frame:GetNumPoints() do
    local point, relativeTo, relativePoint, x, y = self.frame:GetPoint(i);
    return { point, relativeTo, relativePoint, x, y };
  end
end

function MrTargetUnit:SetStyleDefault()
  self.frame:EnableDrawLayer('BORDER');
  self.frame.NAME:ClearAllPoints();
  self.frame.NAME:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 15, -2);
  self.frame.NAME:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -3, -3.2);
  self.frame.NAME:SetFontObject("GameFontHighlight");
  self.frame.TARGETED:SetFontObject("TextStatusBarTextRed");
  self.frame.HEALTH_BAR:ClearAllPoints();
  self.frame.HEALTH_BAR:SetPoint('TOPLEFT', self.frame, 'TOPLEFT', 1, -1);
  if MrTarget:GetOption('POWER') then
    self.frame.POWER_BAR:ClearAllPoints();
    self.frame.HEALTH_BAR:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMRIGHT', -1, 10);
    self.frame.POWER_BAR:SetPoint('TOPLEFT', self.frame.HEALTH_BAR, 'BOTTOMLEFT', 0, -2);
    self.frame.POWER_BAR:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMRIGHT', -1, 0);
    self.frame.POWER_BAR:Show();
    self.frame.horizDivider:Show();
  else
    self.frame.HEALTH_BAR:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMRIGHT', -1, 2);
    self.frame.POWER_BAR:Hide();
    self.frame.horizDivider:Hide();
  end
  self.frame.ROLE_ICON:ClearAllPoints();
  self.frame.ROLE_ICON:SetTexture('Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES');
  self.frame.ROLE_ICON:SetPoint('TOPLEFT', self.frame, 'TOPLEFT', 2.5, -2.5);
  self.frame.ROLE_ICON:SetTexCoord(GetTexCoordsForRole(self.role, false));
  self.frame.ROLE_ICON:Show();
  self.frame.SPEC:ClearAllPoints();
  self.frame.SPEC:SetPoint("TOPLEFT", self.frame.NAME, "BOTTOMLEFT", 0, 0);
  self.frame.SPEC:SetPoint("TOPRIGHT", self.frame.NAME, "BOTTOMRIGHT", 0, 0);
  self.frame.SPEC:Show();
  self.frame.SPEC_ICON:Hide();
end

function MrTargetUnit:SetStyleBorderless()
  self.frame:DisableDrawLayer('BORDER');
  self.frame.NAME:ClearAllPoints();
  self.frame.NAME:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 15, -2);
  self.frame.NAME:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -3, -3.2);
  self.frame.NAME:SetFontObject("GameFontHighlightBorderless");
  self.frame.TARGETED:SetFontObject("TextStatusBarTextRedBorderless");
  self.frame.HEALTH_BAR:ClearAllPoints();
  self.frame.HEALTH_BAR:SetPoint('TOPLEFT', self.frame, 'TOPLEFT', 0, 0);
  if MrTarget:GetOption('POWER') then
    self.frame.POWER_BAR:ClearAllPoints();
    self.frame.HEALTH_BAR:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMRIGHT', 0, 15);
    self.frame.POWER_BAR:SetPoint('TOPLEFT', self.frame.HEALTH_BAR, 'BOTTOMLEFT', 0, -1);
    self.frame.POWER_BAR:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMRIGHT', 0, 1);
    self.frame.POWER_BAR:Show();
    self.frame.horizDivider:Show();
  else
    self.frame.HEALTH_BAR:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMRIGHT', 0, 1);
    self.frame.POWER_BAR:Hide();
    self.frame.horizDivider:Hide();
  end
  self.frame.POWER_BAR:ClearAllPoints();
  self.frame.POWER_BAR:SetPoint('TOPLEFT', self.frame.HEALTH_BAR, 'BOTTOMLEFT', 0, -1);
  self.frame.POWER_BAR:SetPoint('BOTTOMRIGHT', self.frame, 'BOTTOMRIGHT', 0, 1);
  self.frame.POWER_BAR:Show();
  self.frame.ROLE_ICON:ClearAllPoints();
  self.frame.ROLE_ICON:SetTexture('Interface\\LFGFrame\\LFGRole');
  self.frame.ROLE_ICON:SetPoint('TOPLEFT', self.frame, 'TOPLEFT', 2.5, -3);
  self.frame.ROLE_ICON:SetTexCoord(GetTexCoordsForRole(self.role, true));
  self.frame.ROLE_ICON:Show();
  self.frame.SPEC:Hide();
  if MrTarget:GetOption('ICONS') then
    self.frame.SPEC_ICON:Show();
  else
    self.frame.SPEC_ICON:Hide();
  end
end

function MrTargetUnit:UpdateOrientation()
  self.frame.SPEC_ICON:ClearAllPoints();
  if self.parent.reverse then
    self.frame.SPEC_ICON:SetPoint('TOPLEFT', self.frame, 'TOPRIGHT', 1, 0);
  else
    self.frame.SPEC_ICON:SetPoint('TOPRIGHT', self.frame, 'TOPLEFT', -1, 0);
  end
end