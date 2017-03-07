-- MrTargetRange
-- =====================================================================
-- Copyright (C) 2016 Lock of War, Renevatium
--

MrTargetRange = {
  frame=nil,
  parent=nil,
  range=nil,
  update=0,
  frequency=0.25,
  harmful={},
  helpful={}
};

MrTargetRange.__index = MrTargetRange;

function MrTargetRange:New(parent)
  local this = setmetatable({}, MrTargetRange);
  this.harmful = setmetatable({}, nil);
  this.helpful = setmetatable({}, nil);
  this.parent = parent;
  this.frame = CreateFrame('Frame', parent.frame:GetName()..'Range', parent.frame);
  this.frame:SetScript('OnUpdate', function(frame, time) this:OnUpdate(time); end);
  this.frame:SetScript('OnEvent', function(frame, ...) this:OnEvent(...); end);
  this.frame:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED');
  -- this.frame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED');
  this:UpdateSpells();
  this.frame:Show();
  return this;
end

local function SortByRange(u,v)
  if v and u then
    if u.range > v.range then
      return true;
    end
  elseif u then
    return true;
  end
end

function MrTargetRange:UpdateSpells()
  self.harmful = table.wipe(self.harmful);
  self.helpful = table.wipe(self.helpful);
  local numTabs = GetNumSpellTabs();
  for i=1,numTabs do
    local name,texture,offset,numSpells = GetSpellTabInfo(i);
    for j=1,numSpells do
      local id = j+offset;
      local name, rank = GetSpellBookItemName(id, 'spell');
      local range = select(6, GetSpellInfo(name));
      if range then
        if IsHarmfulSpell(id, 'spell') then
          table.insert(self.harmful, { name=name, range=range });
        elseif IsHelpfulSpell(id, 'spell') then
          table.insert(self.helpful, { name=name, range=range });
        end
      end
    end
  end
  table.sort(self.harmful, SortByRange)
  table.sort(self.helpful, SortByRange)
end

function MrTargetRange:GetHarmfulRange()
  local range = nil;
  for i=1, #self.harmful do
    if IsSpellInRange(self.harmful[i].name, self.parent.unit) == 1 then
      range = range == nil and self.harmful[i].range or math.min(range, self.harmful[i].range);
      if range then
        break;
      end
    end
  end
  return range;
end

function MrTargetRange:GetHelpfulRange()
  local range = nil;
  for i=1, #self.helpful do
    if IsSpellInRange(self.helpful[i].name, self.parent.unit) == 1 then
      range = range == nil and self.helpful[i].range or math.min(range, self.helpful[i].range);
      if range then
        break;
      end
    end
  end
  return range;
end

function MrTargetRange:OnUpdate(time)
  if UnitIsDeadOrGhost('player') then
    self.parent.range = nil;
    self.range = nil;
    self.update = 0;
    return;
  end
  self.update = self.update + time;
  if self.update > self.frequency then
    if self.parent:GetUnit(self.parent.unit) then
      if UnitIsConnected(self.parent.unit) and not UnitIsDeadOrGhost(self.parent.unit) then
        if UnitIsEnemy('player', self.parent.unit) then
          self.range = self:GetHarmfulRange();
        else
          self.range = self:GetHelpfulRange();
        end
      end
      self.parent.range = self.range;
      self.update = 0;
    end
  end
end

-- function MrTargetRange:CombatLogRangeCheck(sourceName, destName, spellId)
--   if sourceName and self.parent.name == sourceName then
--     if UnitIsEnemy('player', sourceName) then
--       print('Enemy in range '..sourceName);
--       self.range = self:GetHarmfulRange();
--       return;
--     else
--       return;
--     end
--   end
--   if destName and self.parent.name == destName then
--     if UnitIsEnemy('player', destName) then
--       print('Enemy in range '..destName);
--       self.range = self:GetHarmfulRange();
--       return;
--     else
--       return;
--     end
--   end
-- end

function MrTargetRange:OnEvent(event, unit, ...)
  if event == 'ACTIVE_TALENT_GROUP_CHANGED' then
    self:UpdateSpells();
  -- elseif event == 'COMBAT_LOG_EVENT_UNFILTERED' then
  --   local _, _, _, sourceName, _, _, _, destName, _, _, spellId = ...;
  --   self:CombatLogRangeCheck(sourceName, destName, spellId);
  end
end