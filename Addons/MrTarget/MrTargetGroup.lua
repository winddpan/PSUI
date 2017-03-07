-- MrTargetGroup
-- =====================================================================
-- Copyright (C) 2016 Lock of War, Renevatium
--

local NAME_OPTIONS = {
  'Pikachu', 'Bellsprout', 'Zubat', 'Bulbasaur', 'Charmander', 'Diglett', 'Slowpoke', 'Squirtle', 'Oddish', 'Geodude',
  'Mew', 'Gastly', 'Onix', 'Golduck', 'Spearow', 'Butterfree', 'Charizard', 'Graveler', 'Psyduck', 'Meowth',
  'Krabby', 'Mankey', 'Rattata', 'Metapod', 'Alakazam', 'Pidgeotto', 'Poliwag', 'Kadabra',  'Primeape', 'Caterpie',
  'Gloom', 'Raichu', 'Golem', 'Sandshrew', 'Kakuna', 'Tentacool', 'Vulpix', 'Weedle', 'Jigglypuff', 'Blastoise'
};

local CYRILLIC = {
  ["А"]="A", ["а"]="a", ["Б"]="B", ["б"]="b", ["В"]="V", ["в"]="v", ["Г"]="G", ["г"]="g", ["Д"]="D", ["д"]="d", ["Е"]="E",
  ["е"]="e", ["Ё"]="E", ["ё"]="e", ["Ж"]="Zh", ["ж"]="zh", ["З"]="Z", ["з"]="z", ["И"]="I", ["и"]="i", ["Й"]="I", ["й"]="i",
  ["К"]="K", ["к"]="k", ["Л"]="L", ["л"]="l", ["М"]="M", ["м"]="m", ["Н"]="N", ["н"]="n", ["О"]="O", ["о"]="o", ["П"]="P",
  ["п"]="p", ["Р"]="R", ["р"]="r", ["С"]="S", ["с"]="s", ["Т"]="T", ["т"]="t", ["У"]="U", ["у"]="u", ["Ф"]="F", ["ф"]="f",
  ["Х"]="Kh", ["х"]="kh", ["Ц"]="Ts", ["ц"]="ts", ["Ч"]="Ch", ["ч"]="ch", ["Ш"]="Sh", ["ш"]="sh", ["Щ"]="Shch", ["щ"]="shch",
  ["Ъ"]="Ie", ["ъ"]="ie", ["Ы"]="Y", ["ы"]="y", ["Ь"]="X", ["ь"]="x", ["Э"]="E", ["э"]="e", ["Ю"]="Iu", ["ю"]="iu",
  ["Я"]="Ia", ["я"]="ia"
};

local ROLES = {};
for classID=1, MAX_CLASSES do
  local className, classTag, classID = GetClassInfoByID(classID);
  local numTabs = GetNumSpecializationsForClassID(classID);
  ROLES[classTag] = {};
  for i=1, numTabs do
    local id, name, description, icon, role = GetSpecializationInfoForClassID(classID, i);
    ROLES[classTag][name] = { class=className, role=role, id=id, description=description, icon=icon, spec=name };
  end
end

MrTargetGroup = {
  active=false,
  faction=nil,
  friendly=false,
  update=0,
  tick=1,
  max=40,
  frame=nil,
  reverse=false,
  frames={},
  units={},
  next_name=1,
  update_units=false,
  columns=1
};

MrTargetGroup.__index = MrTargetGroup;

local function SortUnits(u,v)
  if v ~= nil and u ~= nil then
    if u.role == v.role then
      if u.class == v.class then
        if u.name < v.name then
          return true;
        end
      elseif u.class < v.class then
        return true;
      end
    elseif u.role > v.role then
      return true;
    end
  elseif u then
    return true;
  end
end

function MrTargetGroup:New(group, friendly)
  local this = setmetatable({}, MrTargetGroup);
  this.units = setmetatable({}, nil);
  this.frames = setmetatable({}, nil);
  this.group = group;
  this.friendly = friendly;
  this.columns = MrTarget:GetOption('COLUMNS');
  this.max = MrTarget:GetSize();
  this.frame = CreateFrame('Frame', 'MrTargetGroup'..group, UIParent, 'MrTargetGroupTemplate');
  this.frame:SetScript('OnEvent', function(frame, ...) this:OnEvent(...); end);
  this.frame:SetScript('OnUpdate', function(frame, ...) this:OnUpdate(...); end);
  this.frame:SetScript('OnDragStart', function(frame, ...) this:OnDragStart(...); end);
  this.frame:SetScript('OnDragStop', function(frame, ...) this:OnDragStop(...); end);
  this:InitFrame();
  this:CreateFrames();
  return this;
end

function MrTargetGroup:Activate()
  self.frame:RegisterEvent('UPDATE_BATTLEFIELD_SCORE');
  self.frame:RegisterEvent('PLAYER_TARGET_CHANGED');
  self.frame:RegisterEvent('UNIT_TARGET');
  self.frame:RegisterEvent('PLAYER_DEAD');
  self:Show();
end

function MrTargetGroup:Show()
  if not InCombatLockdown() then
    self:UpdateOrientation();
    self.frame:Show();
  end
end

function MrTargetGroup:SetTarget(unit)
  if unit and unit.frame then
    self.frame.TARGET:ClearAllPoints();
    if self.columns > 1 then
      if MrTarget:GetOption('ICONS') then
        self.frame.TARGET:SetPoint('TOPRIGHT', unit.frame, 'TOPLEFT', -4, -2);
      else
        self.frame.TARGET:SetPoint('TOPRIGHT', unit.frame, 'TOPRIGHT', -4, -2);
      end
    elseif self.reverse then
      self.frame.TARGET:SetPoint('TOPLEFT', unit.frame, 'TOPRIGHT', 4, -2);
    else
      self.frame.TARGET:SetPoint('TOPRIGHT', unit.frame, 'TOPLEFT', -4, -2);
    end
    self.frame.TARGET.unit = unit;
    self.frame.TARGET:Show();
  else
    self.frame.TARGET.unit = false;
    self.frame.TARGET:Hide();
  end
end

function MrTargetGroup:PlayerTargetChanged()
  if not UnitIsDeadOrGhost('player') then
    local target = GetUnitName('playertarget', true);
    if target then
      for i=1, #self.frames do
        if self.frames[i] then
          if target == self.frames[i].name then
            self:SetTarget(self.frames[i]);
            return;
          end
        end
      end
    end
  end
  self:SetTarget(nil);
end

function MrTargetGroup:SetAssist(unit)
  if unit and unit.frame then
    self.frame.ASSIST:ClearAllPoints();
    if self.columns > 1 then
      if MrTarget:GetOption('ICONS') then
        self.frame.ASSIST:SetPoint('TOPRIGHT', unit.frame, 'TOPLEFT', -6, -4);
      else
        self.frame.ASSIST:SetPoint('TOPRIGHT', unit.frame, 'TOPRIGHT', -6, -4);
      end
    elseif self.reverse then
      self.frame.ASSIST:SetPoint('TOPLEFT', unit.frame, 'TOPRIGHT', 8, -4);
    else
      self.frame.ASSIST:SetPoint('TOPRIGHT', unit.frame, 'TOPLEFT', -6, -4);
    end
    self.frame.ASSIST.unit = unit;
    self.frame.ASSIST:Show();
  else
    self.frame.ASSIST.unit = false;
    self.frame.ASSIST:Hide();
  end
end

function MrTargetGroup:UnitTarget(unit)
  if UnitIsGroupLeader(unit) then
    if not UnitIsDeadOrGhost(unit) then
      local target = GetUnitName(unit..'target', true);
      if target then
        for i=1, #self.frames do
          if self.frames[i] then
            if target == self.frames[i].name then
              self:SetAssist(self.frames[i]);
              return;
            end
          end
        end
      end
    end
    self:SetAssist(nil);
  end
end

function MrTargetGroup:SetMax(max)
  self.max = max;
end

function MrTargetGroup:GetMax()
  for k,v in pairs({ 10, 15, 40 }) do
    if #self.units <= v then
      return v;
    end
  end
end

function MrTargetGroup:HasRaidIndex(name)
  for i=1, GetNumGroupMembers() do
    if GetUnitName('raid'..i, true) == name then
      return 'raid'..i;
    end
  end
  return name;
end

function MrTargetGroup:IsOnBattlefield()
  return select(2, IsInInstance()) == 'pvp';
end

function MrTargetGroup:UpdateBattlefieldScore()
  if self:IsOnBattlefield() then
    self.faction = GetBattlefieldArenaFaction();
    local numScores = GetNumBattlefieldScores();
    if numScores > 0 then
      self.next_name = 1;
      self.units = table.wipe(self.units);
      for i=1, numScores do
        local name, _, _, _, _, faction, race, _, class, _, _, _, _, _, _, spec = GetBattlefieldScore(i);
        if (faction == self.faction) == self.friendly then
          class = class or select(2, UnitClass(name));
          if ROLES[class][spec] then
            table.insert(self.units, {
              name=name,
              display=name,
              class=class,
              spec=spec,
              role=ROLES[class][spec].role,
              unit=self:HasRaidIndex(name)
            });
          end
        end
      end
      table.sort(self.units, SortUnits);
      for i=1,#self.units do
        self.units[i].display = self:GetDisplayName(self.units[i].name);
      end
      self.update_units = true;
    end
  end
end

function MrTargetGroup:InitFrame()
  self.frame:RegisterForDrag('RightButton');
  self.frame:SetClampedToScreen(true);
  self.frame:EnableMouse(true);
  self.frame:SetMovable(true);
  self.frame:SetUserPlaced(true);
end

function MrTargetGroup:CreateFrames()
  for i=1, self.max do
    if not self.frames[i] then self.frames[i] = MrTargetUnit:New(self, i, self.reverse); end
  end
  self:UpdateLayout();
end

function MrTargetGroup:UpdateLayout()
  for i=2, self.max do
    if self.frames[i] then
      self.frames[i].frame:ClearAllPoints();
      local rows = math.ceil(self.max/self.columns);
      if i > rows then
        local offset = MrTarget:GetOption('ICONS') and 36 or 0;
        self.frames[i].frame:SetPoint('TOPLEFT', self.frames[i-rows].frame, 'TOPRIGHT', offset, 0);
      else
        local offset = MrTarget:GetOption('BORDERLESS') and 0 or -1;
        self.frames[i].frame:SetPoint('TOP', self.frames[i-1].frame, 'BOTTOM', 0, offset);
      end
    end
  end
end

function MrTargetGroup:Hide()
  if InCombatLockdown() then
    self.frame:RegisterEvent('PLAYER_REGEN_ENABLED');
  else
    self.frame:Hide();
  end
end

function MrTargetGroup:PlayerDead()
  self:SetTarget(nil);
  self:SetAssist(nil);
end

function MrTargetGroup:PlayerRegenEnabled()
  self.frame:UnregisterEvent('PLAYER_REGEN_ENABLED');
  self.frame:Hide();
end

function MrTargetGroup:Destroy()
  for i=1, #self.frames do
    if self.frames[i] then
      self.frames[i]:Destroy();
    end
  end
  self.frame:UnregisterEvent('UPDATE_BATTLEFIELD_SCORE');
  self.frame:UnregisterEvent('PLAYER_TARGET_CHANGED');
  self.frame:UnregisterEvent('UNIT_TARGET');
  self.units = table.wipe(self.units);
  self.frame.TARGET:ClearAllPoints();
  self.frame.ASSIST:ClearAllPoints();
  self:Hide();
end

function MrTargetGroup:OnUpdate(time)
  RequestBattlefieldScoreData();
  self.update = self.update + time;
  if self.update < self.tick or (WorldStateScoreFrame and WorldStateScoreFrame:IsShown()) then
    return;
  end
  if self.update_units and not InCombatLockdown() and #self.units > 0 then
    for i=1, #self.frames do
      if self.units[i] then
        self.frames[i]:SetUnit(
          self.units[i].unit,
          self.units[i].name,
          self.units[i].display,
          self.units[i].class,
          self.units[i].spec,
          self.units[i].role,
          ROLES[self.units[i].class][self.units[i].spec].icon,
          self.units[i].test
        );
      elseif self.frames[i] then
        self.frames[i]:UnsetUnit();
      end
    end
    self.frame:SetSize(101*self.columns, math.min(math.ceil(#self.units/self.columns), #self.frames)*self.frames[1].frame:GetHeight()+14);
    self:UpdateLayout();
    self.update_units = false;
  end
  -- self:SetTarget(self.frames[1]);
  -- self:SetAssist(self.frames[1]);
  self.update = 0;
end

function MrTargetGroup:OnEvent(event, ...)
  if event == 'UPDATE_BATTLEFIELD_SCORE' then self:UpdateBattlefieldScore();
  elseif event == 'PLAYER_TARGET_CHANGED' then self:PlayerTargetChanged(...);
  elseif event == 'UNIT_TARGET' then self:UnitTarget(...);
  elseif event == 'PLAYER_REGEN_ENABLED' then self:PlayerRegenEnabled();
  elseif event == 'PLAYER_DEAD' then self:PlayerDead();
  end
end

function MrTargetGroup:GetDisplayName(name)
  if MrTarget:GetOption('NAMING') == 'Transmute' then
    name = self:Transmute(name);
  elseif MrTarget:GetOption('NAMING') == 'Transliterate' then
    name = self:Transliterate(name);
  end
  return name;
end

function MrTargetGroup:Transliterate(name)
  if name then
    for c, r in pairs(CYRILLIC) do
      name = string.gsub(name, c, r);
    end
  end
  return name;
end

function MrTargetGroup:Transmute(name)
  if self:IsUTF8(name) then
    name = NAME_OPTIONS[self.next_name];
    self.next_name = self.next_name+1;
  end
  return name;
end

function MrTargetGroup:IsUTF8(name)
  local c,a,n,i = nil,nil,0,1;
  while true do
    c = string.sub(name,i,i);
    i = i + 1;
    if c == '' then
        break;
    end
    a = string.byte(c);
    if a > 191 or a < 127 then
        n = n + 1;
    end
  end
  return (strlen(name) > n*1.5);
end

function MrTargetGroup:SetColumns(columns)
  self.columns = columns;
  self:UpdateLayout();
end

local function RandomKey(t)
  local keys, i = {}, 1;
  for k in pairs(t) do
    keys[i] = k;
    i = i+1;
  end
  return keys[math.random(1, #keys)];
end

function MrTargetGroup:CreateStub(names, max)
  self.next_name = 1;
  table.wipe(self.units);
  if #self.units == 0 then
    local class, spec = nil, nil;
    for i=1, max do
      class = RandomKey(ROLES);
      spec = RandomKey(ROLES[class]);
      table.insert(self.units, {
        test=true,
        name=names[i],
        display=self:GetDisplayName(names[i]),
        class=class,
        spec=spec,
        role=ROLES[class][spec].role,
        unit=names[i]
      });
    end
    table.sort(self.units, SortUnits);
  else
    for i=1, max do
      self.units[i].display = self:GetDisplayName(names[i]);
    end
  end
  self.update_units = true;
  self.max = max;
  self:Show();
end

function MrTargetGroup:UpdateOrientation()
  local point, relativeTo, relativePoint, x, y = unpack(self:GetPosition());
  self.reverse = x < 0 or x > GetScreenWidth()/2;
  for i=1, #self.frames do
    self.frames[i]:UpdateOrientation();
  end
end

function MrTargetGroup:GetPosition()
  for i=1, self.frame:GetNumPoints() do
    local point, relativeTo, relativePoint, x, y = self.frame:GetPoint(i);
    return { point, relativeTo, relativePoint, x, y };
  end
end

function MrTargetGroup:OnDragStart()
  if InterfaceOptionsFrame:IsShown() then
    self.frame:ClearAllPoints();
    self.frame:StartMoving();
  end
end

function MrTargetGroup:OnDragStop()
  if InterfaceOptionsFrame:IsShown() then
    MrTarget.OPTIONS[self.max].POSITION[self.group] = self:GetPosition();
    self.frame:StopMovingOrSizing();
    self:UpdateOrientation();
  end
end