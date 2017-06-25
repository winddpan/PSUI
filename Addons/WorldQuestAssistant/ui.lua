local mod = _G.WQA
local L = LibStub("AceLocale-3.0"):GetLocale("WorldQuestAssistant")
mod.UI = {
  BUTTON_SIZE = 25
}

BINDING_HEADER_WQAHEAD = L["World Quest Assistant"]
BINDING_NAME_WQA_AUTOMATE = L["Automate group find/join"]
BINDING_NAME_WQA_ABORT_PARTY_LEAVE = L["Cancel group leave"]
BINDING_NAME_WQA_NEW_PARTY = L["Create a new group"]

StaticPopupDialogs["WQA_FIND_GROUP"] = {
  text = L["Do you want to find a group for this quest?"],
  button1 = L["Yes"],
  button2 = L["No"],
  button3 = L["New group"],
  OnAccept = function()
    mod:FindQuestGroups()
  end,
  OnAlt = function()
    mod:CreateQuestGroup()
  end,
  timeout = 45,
  whileDead = false,
  hideOnEscape = true,
  preferredIndex = 3
}

StaticPopupDialogs["WQA_NEW_GROUP"] = {
  text = L["No open groups found. Do you want to create a new group?"],
  button1 = L["Yes"],
  button2 = L["No"],
  OnAccept = function()
    mod:CreateQuestGroup()
  end,
  timeout = 30,
  whileDead = false,
  hideOnEscape = true,
  preferredIndex = 3
}

StaticPopupDialogs["WQA_LEAVE_GROUP"] = {
  text = L["Do you want to leave the group?"],
  button1 = L["Yes"],
  button2 = L["No"],
  OnAccept = function()
    WQA:MaybeLeaveParty()
  end,
  timeout = 45,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3
}

local buttonGroups = {}
local blockAttachments = {}

local function ReleaseButtonGroup(group)
  if group then
    group:Hide()
    group:SetScale(1.0)
    group:ClearAllPoints()
    if group.questID then
      blockAttachments[group.questID] = nil
    end
    tinsert(buttonGroups, group)
  end
end

local function showTooltip(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
  GameTooltip:Show()
end

local function hideTooltip(self)
  GameTooltip:Hide()
end

mod.UI.showTooltip = showTooltip
mod.UI.hideTooltip = hideTooltip

local function CreateButtonGroup()
  local ButtonsFrame = CreateFrame("Frame", nil, UIParent)
  local ApplyFrame = CreateFrame("Button", nil, ButtonsFrame, "UIPanelButtonTemplate")
  local SearchFrame = CreateFrame("Button", nil, ButtonsFrame, "UIPanelButtonTemplate")
  local NewGroupFrame = CreateFrame("Button", nil, ButtonsFrame, "UIPanelButtonTemplate")
  local LeavePartyFrame = CreateFrame("Button", nil, ButtonsFrame, "UIPanelCloseButton")

  local SIZE = mod.UI.BUTTON_SIZE
  ButtonsFrame.ApplyFrame = ApplyFrame
  ButtonsFrame.SearchFrame = SearchFrame
  ButtonsFrame.SearchFrame = SearchFrame
  ButtonsFrame.NewGroupFrame = NewGroupFrame
  ButtonsFrame.LeavePartyFrame = LeavePartyFrame
  ButtonsFrame.getAnchor = function(self)
    local anchor = (self:GetLeft() or 0) > (UIParent:GetWidth() / 2) and "RIGHT" or "LEFT"
    return anchor, anchor == "RIGHT" and "LEFT" or "RIGHT"
  end

  local function updateLayout(block)
    local anchor = (block:GetLeft() or 0) > (UIParent:GetWidth() / 2) and "RIGHT" or "LEFT"
    local otherAnchor = anchor == "LEFT" and "RIGHT" or "LEFT"
    local SPACING = anchor == "RIGHT" and -4 or 4
    local OFFSET = anchor == "RIGHT" and -12 or 12

    SearchFrame:ClearAllPoints()
    SearchFrame:SetPoint("TOP" .. anchor, ButtonsFrame, "TOP" .. anchor)
    NewGroupFrame:ClearAllPoints()
    NewGroupFrame:SetPoint("TOP" .. anchor, SearchFrame, "TOP" .. otherAnchor, SPACING, 0)
    ApplyFrame:ClearAllPoints()
    ApplyFrame:SetPoint("TOP" .. anchor, NewGroupFrame, "TOP" .. otherAnchor, SPACING, 0)
    LeavePartyFrame:ClearAllPoints()
    LeavePartyFrame:SetPoint("TOP" .. anchor, ButtonsFrame, "TOP" .. anchor, 0, 0)
    ButtonsFrame:ClearAllPoints()
    ButtonsFrame:SetPoint("TOP" .. anchor, block, "TOP" .. otherAnchor, OFFSET, 0)
  end

  local f

  f = SearchFrame
  f:SetSize(SIZE, SIZE)
  f.tooltipText = L["Find a new group for this world quest"]
  f:SetNormalTexture("Interface/Icons/inv_darkmoon_eye")
  f:SetScript("OnEnter", showTooltip)
  f:SetScript("OnLeave", hideTooltip)
  f:SetScript("OnClick", function()
    mod:FindQuestGroups(ButtonsFrame.questID, true)
  end)

  f = NewGroupFrame
  f:SetSize(SIZE, SIZE)
  f:SetNormalTexture("Interface/Icons/inv_misc_groupneedmore")
  f.tooltipText = L["Create a new group"]
  f:SetScript("OnEnter", showTooltip)
  f:SetScript("OnLeave", hideTooltip)
  f:SetScript("OnClick", function()
    mod:CreateQuestGroup(ButtonsFrame.questID)
  end)

  f = ApplyFrame
  f.SetPendingInvites = function(self)
    self:SetEnabled(#mod.pendingGroups > 0)
    self:SetText(#mod.pendingGroups)
    if #mod.pendingGroups == 0 or tostring(mod.activeQuestID) ~= tostring(ButtonsFrame.questID) then
      self:Hide()
    else
      self:Show()
    end
  end
  f:SetSize(SIZE, SIZE)
  f:SetNormalTexture("Interface/Tooltips/CHATBUBBLE-BACKGROUND")
  f:SetScript("OnClick", function()
    mod:JoinNextGroup(ButtonsFrame.questID)
  end)
  f.tooltipText = L["Apply to groups for this quest"]
  f:SetScript("OnEnter", showTooltip)
  f:SetScript("OnLeave", hideTooltip)
  f.glow = CreateFrame("Frame", nil, ApplyFrame, "ActionBarButtonSpellActivationAlert")

  f.glow.animIn:Stop()
  local frameWidth, frameHeight = f:GetSize()
  f.glow:SetSize(frameWidth * 1.4, frameHeight * 1.4)
	f.glow:SetPoint("TOPLEFT", ApplyFrame, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2);
	f.glow:SetPoint("BOTTOMRIGHT", ApplyFrame, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2);
  f.glow.animIn:Play()

  f = LeavePartyFrame
  f:Hide()
  f:SetSize(30, 30)
  f:SetScript("OnClick", function()
    WQA:MaybeLeaveParty()
  end)
  f.tooltipText = L["Leave Party"]
  f:SetScript("OnEnter", showTooltip)
  f:SetScript("OnLeave", hideTooltip)

  f = ButtonsFrame
  f:SetSize(1, 1)
  f:Hide()

  ButtonsFrame.Attach = function(self, block)
    self:SetParent(block)
    if block and block.id then
      f.questID = tostring(block.id)
      blockAttachments[f.questID] = f
      f:Show()
      updateLayout(block)
    else
      f:Hide()
    end
  end

  ButtonsFrame.Update = function(self)
    ApplyFrame:SetPendingInvites()
    if mod:IsInParty() then
      ApplyFrame:Hide()
      NewGroupFrame:Hide()
      SearchFrame:Hide()
      LeavePartyFrame:Show()
    else
      NewGroupFrame:Show()
      SearchFrame:Show()
      LeavePartyFrame:Hide()
    end
  end

  return ButtonsFrame
end

local function GetButtonGroup()
  if #buttonGroups > 0 then
    return tremove(buttonGroups)
  else
    return CreateButtonGroup()
  end
end

function mod.UI:GetActiveQuestBlock()
  if WQA.activeQuestID then
    return blockAttachments[tostring(WQA.activeQuestID)]
  else
    return nil
  end
end

function mod.UI:SetSearch()
  for id, attachment in pairs(blockAttachments) do
    attachment:SetSearch()
  end
end

function mod.UI:SetPendingInvites()
  for id, attachment in pairs(blockAttachments) do
    attachment:SetSearch()
  end
end

function mod.UI:ReleaseBlock(block)
  if block and block.id then
    ReleaseButtonGroup(blockAttachments[block.id])
  end
end

local mapButton = nil
local preserved = {}

local function updateBlock(block)
  local strID = tostring(block.id)
  local group = blockAttachments[strID] or GetButtonGroup()
  preserved[strID] = true
  if mod:IsInOtherQueues() then
    group:Hide()
  else
    group:Attach(block)
    group:Update()
  end
  return group
end

function mod.UI:Blocks()
  return blockAttachments
end

function mod.UI:SetupTrackerBlocks()
  table.wipe(preserved)
  if mod.db.profile.showUI then
    mod.UI:GetTrackerBlocks(updateBlock)
  end
  if mapButton then
    local m = updateBlock(mapButton)
    m:SetScale(0.8)
  end

  for id, block in pairs(blockAttachments) do
    if not preserved[tostring(id)] then
      blockAttachments[id] = nil
      ReleaseButtonGroup(block)
    end
  end
end

function mod.UI:GetTrackerBlocks(callback)
  if not ObjectiveTrackerFrame.MODULES then return end
  for i, module in ipairs(ObjectiveTrackerFrame.MODULES) do
    for name, block in pairs(module.usedBlocks) do
      if mod:IsEligibleQuest(block.id) then
        callback(block)
      end
    end
  end
end

function mod.UI:SetMapButton(button)
  if button then
    button.id = tostring(button.questID)
    mapButton = button
  else
    mapButton = nil
  end
  self:SetupTrackerBlocks()
end

function mod.UI:IsActiveMapButton(button)
  return button == mapButton
end

function mod.UI:ReleaseStaleMapButtons()
  if mapButton and blockAttachments[tostring(mapButton.questID)] and tostring(mapButton.questID) ~= blockAttachments[tostring(mapButton.questID)].questID then
    self:SetMapButton(nil)
  end
end
