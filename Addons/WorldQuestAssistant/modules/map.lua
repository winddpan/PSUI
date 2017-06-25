local addon, private = ...
local WQA = LibStub("AceAddon-3.0"):GetAddon(addon)
local L = LibStub("AceLocale-3.0"):GetLocale("WorldQuestAssistant")
local mod = WQA:NewModule("Map Buttons", "AceEvent-3.0", "AceHook-3.0")

function mod:OnInitialize()
  local lastWorldMapID = GetCurrentMapAreaID()

  self:RegisterEvent("PLAYER_ENTERING_WORLD")
  self:RegisterEvent("WORLD_MAP_UPDATE", function()
    if GetCurrentMapAreaID() ~= lastWorldMapID or not WorldMapFrame:IsVisible() then
      WQA.UI:SetMapButton(nil)
    end
    lastWorldMapID = GetCurrentMapAreaID()
  end)

  hooksecurefunc("WorldMap_UpdateQuestBonusObjectives", function()
    WQA.UI:ReleaseStaleMapButtons()
  end)

  hooksecurefunc("TaskPOI_OnEnter", function(self)
    if self.worldQuest and WQA:IsEligibleQuest(self.questID, true) and mod:IsInSameZone() then
      WorldMapTooltip:AddLine(L["Middle-click or ctrl-right-click to find a group for this quest"])
      WorldMapTooltip:Show()
    end
  end)
end

function mod:IsInSameZone()
  return GetPlayerMapAreaID("player") == GetCurrentMapAreaID()
end

function mod:PLAYER_ENTERING_WORLD()
  if not self.hooked then
    self.hooked = true
    self:HookWorldQuestTracker()
    self:HookBaseUIPOITracker()
  end
end

function mod:HookBaseUIPOITracker()
  hooksecurefunc("WorldMap_GetOrCreateTaskPOI", function(i)
    local button = _G["WorldMapFrameTaskPOI" .. i]
    button:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp")
    if not self:IsHooked(button, "OnClick") then
      self:SecureHookScript(button, "OnClick", "ClickWQSecure")
    end
  end)
end

function mod:HookWorldQuestTracker()
  if _G.WorldQuestTrackerAddon then
    self:RawHook(WorldQuestTrackerAddon, "CreateZoneWidget", function(...)
      local button = self.hooks[WorldQuestTrackerAddon].CreateZoneWidget(...)
      if not self:IsHooked(button, "OnClick") then
        self:RawHookScript(button, "OnClick", "ClickWQRaw")
      end
      return button
    end)
  end
end

local function wantsGroup(button)
  return (button == "MiddleButton") or (button == "RightButton" and IsControlKeyDown())
end

local function handleMapGroupFind(button)
  if mod:IsInSameZone() then
    if WQA:IsEligibleQuest(tonumber(button.questID), true) then
      if WQA.UI:IsActiveMapButton(button) then
        WQA.UI:SetMapButton(nil)
      else
        WQA:FindQuestGroups(button.questID, true)
        WQA.UI:SetMapButton(button)
      end
    end
  end
end

function mod:ClickWQRaw(poiButton, mouseButton, ...)
  self:ClickWQSecure(poiButton, mouseButton, ...)
  if not (wantsGroup(mouseButton) and mod:IsInSameZone()) then
    return self.hooks[poiButton].OnClick(poiButton, mouseButton, ...)
  end
end

function mod:ClickWQSecure(poiButton, mouseButton)
  if wantsGroup(mouseButton) then
    handleMapGroupFind(poiButton)
    -- Undo tracking installed on click by the base UI
    if IsWorldQuestHardWatched(poiButton.questID) or (IsWorldQuestWatched(poiButton.questID) and GetSuperTrackedQuestID() == poiButton.questID) then
      BonusObjectiveTracker_UntrackWorldQuest(poiButton.questID)
    end
  end
end
