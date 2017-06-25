local addon, private = ...
local WQA = LibStub("AceAddon-3.0"):GetAddon(addon)
local mod = WQA:NewModule("Kaliel's Tracker Support", "AceHook-3.0")

function mod:OnEnable()
  if _G["!KalielsTrackerFrame"] then
    -- We just want a posthook, it doesn't need to be secure
    self:SecureHook(WQA.UI, "SetupTrackerBlocks")
  end
end

function mod:SetupTrackerBlocks()
  -- If any blocks were set up, anchor them to the Kaliel's sbutton frame
  local anchor = _G["!KalielsTrackerButtons"]:IsVisible() and _G["!KalielsTrackerButtons"] or _G["!KalielsTrackerFrame"]
  local anchorPoint, relativePoint = "TOPLEFT", "TOPRIGHT"
  local left = anchor and anchor:GetLeft()
  if left > UIParent:GetWidth() / 2 then
    anchorPoint, relativePoint = "TOPRIGHT", "TOPLEFT"
  end

  local blocks = WQA.UI:Blocks()
  if not ObjectiveTrackerFrame.MODULES then return end
  for i, module in ipairs(ObjectiveTrackerFrame.MODULES) do
    for name, block in pairs(module.usedBlocks) do
      local attachment = blocks[tostring(block.id)]
      if attachment then
        attachment:SetParent(anchor)
        attachment:ClearAllPoints()
        attachment:SetPoint(anchorPoint, anchor, relativePoint, 0, -7)
        break
      end
    end
  end
end
