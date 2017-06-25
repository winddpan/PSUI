local addon, private = ...
local WQA = LibStub("AceAddon-3.0"):GetAddon(addon)
local HBD = LibStub("HereBeDragons-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("WorldQuestAssistant")
local mod = WQA:NewModule("Leech Police", "AceEvent-3.0")

BINDING_NAME_WQA_ANTI_LEECH = L["Kick leeching group members"]

local timer = nil
local lastPosition = {}
local unitsPendingKicks = {}
local kickedUnits = {}

local TICK_FREQUENCY = 1
local SECONDS_PER_TICK = 1 / TICK_FREQUENCY
local MAX_FLYING_IDLE_TICKS = 8
local MAX_OOB_IDLE_TICKS = 8 * SECONDS_PER_TICK
local MAX_IDLE_TICKS = 30 * SECONDS_PER_TICK   -- If a player hasn't moved in this many seconds, mark as kickable. This is generous because sitting around waiting for spawns may result in idling.
local MAX_OOB_TICKS = 15 * SECONDS_PER_TICK    -- If a player is out of bounds this many seconds, mark as kickable


local KickFlaggedFrame

function mod:OnInitialize()
  self:RegisterEvent("GROUP_ROSTER_UPDATE")
  self:RegisterEvent("PLAYER_REGEN_DISABLED")
  self:RegisterEvent("PLAYER_REGEN_ENABLED")
  self.db = WQA.db:RegisterNamespace("LeechPolice", {
    profile = {
      kickOob = true,
      kickIdle = true
    }
  })

  do
    KickFlaggedFrame = CreateFrame("Button", nil, ButtonsFrame, "UIPanelButtonTemplate")
    local f = KickFlaggedFrame
    f:SetSize(WQA.UI.BUTTON_SIZE, WQA.UI.BUTTON_SIZE)
    f:SetNormalTexture("Interface/Icons/ability_monk_mightyoxkick")
    f:SetScript("OnClick", function()
      mod:DropTheHammer()
    end)
    f.tooltipText = L["Kick flagged group members"]
    f:SetScript("OnEnter", WQA.UI.showTooltip)
    f:SetScript("OnLeave", WQA.UI.hideTooltip)
    f.glow = CreateFrame("Frame", nil, f, "ActionBarButtonSpellActivationAlert")
    f.glow.animIn:Stop()
    local frameWidth, frameHeight = f:GetSize()
    f.glow:SetSize(frameWidth * 1.4, frameHeight * 1.4)
    f.glow:SetPoint("TOPLEFT", f, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2);
    f.glow:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2);
    f.glow.animIn:Play()
    f:Hide()
  end
end

function mod:GetConfig()
  return {
    type = "group",
    name = L["Anti-Leeching"],
    args = {
      kickOob = {
        type = "toggle",
        width = "full",
        name = L["Flag far-away group members"],
        get = function()
          return mod.db.profile.kickOob
        end,
        set = function(info, v)
          mod.db.profile.kickOob = true
        end
      },
      kickIdle = {
        type = "toggle",
        width = "full",
        name = L["Flag idling group members"],
        get = function()
          return mod.db.profile.kickIdle
        end,
        set = function(info, v)
          mod.db.profile.kickIdle = true
        end
      },
      kickKeybind = {
        type = "keybinding",
        name = L["Keybind: Kick flagged party members"],
        desc = L["Kick keybind help"],
        order = 10,
        width = "double",
        get = function()
          return GetBindingKey("WQA_ANTI_LEECH")
        end,
        set = function(info, v)
          local old = GetBindingKey("WQA_ANTI_LEECH")
          if old then
            SetBinding(old)
          end
          SetBinding(v, "WQA_ANTI_LEECH")
          SaveBindings(GetCurrentBindingSet())
        end
      }
    }
  }
end

local function getKickMessage(msg, unit)
  local binding = GetBindingKey("WQA_ANTI_LEECH")
  if binding then
    msg = msg .. ". " .. L["Kick keybind prompt"]:format(binding, L["sex_" .. (UnitSex(unit) or "1")])
  end
  return msg
end

local hasEnteredCombatForGroup = false
local lastCombatAt = 0

function mod:PLAYER_REGEN_DISABLED()
  hasEnteredCombatForGroup = true
  lastCombatAt = GetTime()
end

function mod:PLAYER_REGEN_ENABLED()
  lastCombatAt = GetTime()
end

function mod:GROUP_ROSTER_UPDATE()
  if not WQA:IsWQAGroup() then
    hasEnteredCombatForGroup = false
    table.wipe(lastPosition)
    table.wipe(unitsPendingKicks)
    table.wipe(kickedUnits)
    KickFlaggedFrame:Hide()
  elseif WQA:IsWQAGroup() then
    local foundUnits = {}
    for i = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
      local unit = (IsInRaid() and "raid" or "party") .. i
      if UnitExists(unit) then
        local guid = UnitGUID(unit)
        foundUnits[guid] = true
        if kickedUnits[guid] then
          unitsPendingKicks[guid] = "recurring invite"
          WQA:Print(getKickMessage(L["Kicked member rejoined"]:format(UnitName(unit)), unit))
          mod:AttachUIToActiveQuestBlock()
        end
      end
    end

    for guid, reason in pairs(unitsPendingKicks) do
      if not foundUnits[guid] then
        unitsPendingKicks[guid] = nil
      end
    end
    self:UpdateKickButton()
  end
end

function mod:OnEnable()
  timer = C_Timer.NewTicker(TICK_FREQUENCY, function()
    if WQA:IsWQAGroup() then
      for i = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
        local unit = (IsInRaid() and "raid" or "party") .. i
        if UnitExists(unit) then
          mod:PoliceUnit(unit)
        end
        if UnitAffectingCombat("player") then
          lastCombatAt = GetTime()
        end
      end
    end
  end)
end

function mod:OnDisable()
  timer:Cancel()
  table.wipe(lastPosition)
end

function mod:PoliceUnit(unit)
  local stats = self:UpdateUnitStats(unit)
  if not stats then return end
  local distance = stats.distanceFromQuest and math.floor(stats.distanceFromQuest) or "???"

  if stats.ticksIdle > MAX_OOB_IDLE_TICKS and stats.ticksOOB > MAX_OOB_IDLE_TICKS then
    self:WoopWoop(unit, "oob_and_idle", distance)
  elseif stats.ticksIdle > MAX_FLYING_IDLE_TICKS and stats.ticksNonInteracting > MAX_FLYING_IDLE_TICKS then
    self:WoopWoop(unit, "idle_flying")
  elseif stats.ticksIdle > MAX_IDLE_TICKS then
    self:WoopWoop(unit, "idle")
  elseif stats.ticksOOB > MAX_OOB_TICKS then
    self:WoopWoop(unit, "oob", distance)
  else
    unitsPendingKicks[stats.guid] = nil
    self:UpdateKickButton()
  end
end

function mod:DropTheHammer()
  if WQA:IsWQAGroup() and UnitIsGroupLeader("player") then
    local kickedAny = false
    for i = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
      local unit = (IsInRaid() and "raid" or "party") .. i
      local guid = UnitGUID(unit)
      if unitsPendingKicks[guid] then
        kickedUnits[guid] = true
        unitsPendingKicks[guid] = nil
        UninviteUnit(unit)
        kickedAny = true
        break
      end
    end
    if not kickedAny then
      table.wipe(unitsPendingKicks)
    end
    self:UpdateKickButton()
  end
end

function mod:UpdateKickButton()
  for i = 1, GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
    local unit = (IsInRaid() and "raid" or "party") .. i
    local guid = UnitGUID(unit)
    if unitsPendingKicks[guid] then
      KickFlaggedFrame:Show()
      return
    end
  end
  KickFlaggedFrame:Hide()
end

function mod:WoopWoop(unit, reason, ...) -- That's the sound of the police
  if UnitIsGroupLeader("player") then
    if not unitsPendingKicks[UnitGUID(unit)] then
      WQA:Print(getKickMessage(L["Kick prompt"]:format(UnitName(unit), L["kick_reason_" .. reason]:format(...)), unit))
      unitsPendingKicks[UnitGUID(unit)] = reason
      self:AttachUIToActiveQuestBlock()
      self:UpdateKickButton()
    end
  end
end

function mod:AttachUIToActiveQuestBlock()
  local block = WQA.UI:GetActiveQuestBlock()
  if block then
    KickFlaggedFrame:SetParent(block)
    local anchor, relative = block:getAnchor()
    KickFlaggedFrame:SetPoint("TOP" .. anchor, block.LeavePartyFrame, "TOP" .. relative)
    KickFlaggedFrame:Show()
  end
end

function mod:UpdateUnitStats(unit)
  local guid = UnitGUID(unit)
  if not guid then return nil end

  local x, y = HBD:GetUnitWorldPosition(unit)
  local px, py = HBD:GetUnitWorldPosition("player")
  lastPosition[guid] = lastPosition[guid] or {x = 0, y = 0, ticksIdle = 0, ticksOOB = 0, ticksNonInteracting = 0, distanceFromQuest = 0, guid = guid}

  local distance, deltaX, deltaY = HBD:GetWorldDistance(nil, x, y, lastPosition[guid].x, lastPosition[guid].y)
  lastPosition[guid].x = x
  lastPosition[guid].y = y

  -- We don't start accumulating idle information until we've entered combat once in the group
  -- This is specifically to avoid accumulating "idle" scores when waiting for an elite spawn
  if hasEnteredCombatForGroup and (GetTime() - lastCombatAt) < (MAX_IDLE_TICKS / SECONDS_PER_TICK) then
    if IsFlying(unit) then
      lastPosition[guid].ticksNonInteracting = lastPosition[guid].ticksNonInteracting + 1
      WQA:Debug("Adding non-interaction tick for", UnitName(unit), lastPosition[guid].ticksNonInteracting, "flying:", IsFlying(unit))
    else
      if lastPosition[guid].ticksNonInteracting > 0 then
        WQA:Debug("Reset non-interaction ticks for", UnitName(unit))
      end
      lastPosition[guid].ticksNonInteracting = 0
    end

    if distance and distance < 0.1 and not UnitAffectingCombat(unit) then
      lastPosition[guid].ticksIdle = lastPosition[guid].ticksIdle + 1
      WQA:Debug("Adding idle tick for", UnitName(unit), lastPosition[guid].ticksIdle)
    elseif distance then
      if lastPosition[guid].ticksIdle > 0 then
        WQA:Debug("Reset idle ticks for", UnitName(unit))
      end
      lastPosition[guid].ticksIdle = 0
    end
  else
    WQA:Debug("Not performing idle checks because player has not entered combat in the last 40 seconds")
  end

  local info = mod:GetCurrentQuestIDInfo()
  if info then
    local x, y = HBD:GetWorldCoordinatesFromZone(info.x, info.y, GetCurrentMapAreaID(), nil)
    local distance, deltaX, deltaY = HBD:GetWorldDistance(nil, x, y, lastPosition[guid].x, lastPosition[guid].y)
    local playerDistance = HBD:GetWorldDistance(nil, x, y, px, py)
    local playerUnitDistance = HBD:GetWorldDistance(nil, lastPosition[guid].x, lastPosition[guid].y, px, py)

    -- We only perform OOB checks when we're in bounds
    if distance and playerUnitDistance and playerDistance and playerDistance < 300 then
      lastPosition[guid].distanceFromQuest = distance
      -- If they're REALLY far away, we're going to penalize them heavily
      if distance > 1000 and playerUnitDistance > 1000 then
        lastPosition[guid].ticksOOB = lastPosition[guid].ticksOOB + 10
        WQA:Debug("Adding extreme OOB tick for", UnitName(unit), lastPosition[guid].ticksOOB, "distance", distance)
      elseif distance > 500 and playerUnitDistance > 500 then
        lastPosition[guid].ticksOOB = lastPosition[guid].ticksOOB + 1
        WQA:Debug("Adding OOB tick for", UnitName(unit), lastPosition[guid].ticksOOB, "distance", distance)
      else
        if lastPosition[guid].ticksOOB > 0 then
          WQA:Debug("Reset OOB ticks for", UnitName(unit))
        end
        lastPosition[guid].ticksOOB = 0
      end
    end
  end

  return lastPosition[guid]
end

local lastQuestID = nil
local lastQuestInfo = nil
function mod:GetCurrentQuestIDInfo()
  if lastQuestID ~= WQA.activeQuestID then
    local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(GetCurrentMapAreaID(), nil)
    if (taskInfo and #taskInfo > 0) then
      for i, info in ipairs (taskInfo) do
        if info.questId == WQA.activeQuestID then
          lastQuestID = WQA.activeQuestID
          lastQuestInfo = info
          break
        end
      end
    end
  end
  return lastQuestInfo
end
