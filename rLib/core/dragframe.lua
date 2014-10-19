
  -- // dragframe functionality - drag, lock, unlock, reset
  -- // zork - 2012

  -----------------------------
  -- GLOBAL FUNCTIONS
  -----------------------------

  --add some global functions

  --rGetPoint func
  function rGetPoint(self)
    if not self then return end
    local point = {}
    point.a1, point.af, point.a2, point.x, point.y = self:GetPoint()
    if point.af and point.af:GetName() then
      point.af = point.af:GetName()
    end
    return point
  end

  --rGetSize func
  function rGetSize(self)
    if not self then return end
    local size = {}
    size.w, size.h = self:GetWidth(), self:GetHeight()
    return size
  end

  --rResetToDefaultPoint func
  function rResetToDefaultPoint(self)
    if not self then return end
    if not self.defaultPoint then return end
    if InCombatLockdown() then return end --sorry not in combat
    rResetToPoint(self,self.defaultPoint)
  end

  --rResetToDefaultSize func
  function rResetToDefaultSize(self)
    if not self then return end
    if not self.defaultSize then return end
    if InCombatLockdown() then return end --sorry not in combat
    self:SetSize(self.defaultSize.w,self.defaultSize.h)
  end

  --rResetToPoint func
  function rResetToPoint(self,point)
    if not self or not point then return end
    if InCombatLockdown() then return end --sorry not in combat
    self:ClearAllPoints()
    if point.af and point.a2 then
      self:SetPoint(point.a1 or "CENTER", point.af, point.a2, point.x or 0, point.y or 0)
    elseif point.af then
      self:SetPoint(point.a1 or "CENTER", point.af, point.x or 0, point.y or 0)
    else
      self:SetPoint(point.a1 or "CENTER", point.x or 0, point.y or 0)
    end
  end

  --rUnlockFrame func
  function rUnlockFrame(self)
    if not self then return end
    if not self:IsUserPlaced() then return end
    if not self:IsShown() then
      self.visibilityState = false
      if not InCombatLockdown() then --impossible for protected frames
        self:Show()
      end
    else
      self.visibilityState = true
    end
    self.opacityValue = self:GetAlpha()
    self:SetAlpha(1)
    self.dragFrame:Show()
  end

  --rLockFrame func
  function rLockFrame(self)
    if not self then return end
    if not self:IsUserPlaced() then return end
    self.dragFrame:Hide()
    if self.opacityValue then
      self:SetAlpha(self.opacityValue)
    end
    if not self.visibilityState then
      if not InCombatLockdown() then --impossible for protected frames
        self:Hide()
      end
    end
  end

  --rUnlockAllFrames func
  function rUnlockAllFrames(dragFrameList,txt)
    if not dragFrameList then return end
    if txt then print(txt) end
    for _, frame in pairs(dragFrameList) do
      rUnlockFrame(frame)
    end
  end

  --rLockAllFrames func
  function rLockAllFrames(dragFrameList,txt)
    if not dragFrameList then return end
    if txt then print(txt) end
    for _, frame in pairs(dragFrameList) do
      rLockFrame(frame)
    end
  end

  --rResetAllFramesToDefault func
  function rResetAllFramesToDefault(dragFrameList,txt)
    if not dragFrameList then return end
    if txt then print(txt) end
    for _, frame in pairs(dragFrameList) do
      rResetToDefaultPoint(frame)
      rResetToDefaultSize(frame)
    end
  end

  --rCreateDragFrame func
  function rCreateDragFrame(self, dragFrameList, inset, clamp)
    if not self or not dragFrameList then return end
    --save the default position for later
    self.defaultPoint = rGetPoint(self)
    table.insert(dragFrameList,self) --add frame object to the list
    --anchor a dragable frame on self
    local df = CreateFrame("Frame",nil,self)
    df:SetAllPoints(self)
    df:SetFrameStrata("HIGH")
    df:SetHitRectInsets(inset or 0,inset or 0,inset or 0,inset or 0)
    df:EnableMouse(true)
    df:RegisterForDrag("LeftButton")
    df:SetScript("OnDragStart", function(self) if IsAltKeyDown() and IsShiftKeyDown() then self:GetParent():StartMoving() end end)
    df:SetScript("OnDragStop", function(self) self:GetParent():StopMovingOrSizing() end)
    df:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_TOP")
      GameTooltip:AddLine(self:GetParent():GetName(), 0, 1, 0.5, 1, 1, 1)
      GameTooltip:AddLine("Hold down ALT+SHIFT to drag!", 1, 1, 1, 1, 1, 1)
      GameTooltip:Show()
    end)
    df:SetScript("OnLeave", function(s) GameTooltip:Hide() end)
    df:Hide()
    --overlay texture
    local t = df:CreateTexture(nil,"OVERLAY",nil,6)
    t:SetAllPoints(df)
    t:SetTexture(0,1,0)
    t:SetAlpha(0.2)
    df.texture = t
    --self stuff
    self.dragFrame = df
    self:SetClampedToScreen(clamp or false)
    self:SetMovable(true)
    self:SetUserPlaced(true)
  end

  --rCreateDragResizeFrame func
  function rCreateDragResizeFrame(self, dragFrameList, inset, clamp)
    if not self or not dragFrameList then return end
    --save the default position for later
    self.defaultPoint = rGetPoint(self)
    self.defaultSize = rGetSize(self)
    table.insert(dragFrameList,self) --add frame object to the list
    --anchor a dragable frame on self
    local df = CreateFrame("Frame",nil,self)
    df:SetAllPoints(self)
    df:SetFrameStrata("HIGH")
    df:SetHitRectInsets(inset or 0,inset or 0,inset or 0,inset or 0)
    df:EnableMouse(true)
    df:RegisterForDrag("LeftButton","RightButton")
    df:SetScript("OnDragStart", function(self, button)
      if IsAltKeyDown() and IsShiftKeyDown() and button == "LeftButton" then
        self:GetParent():StartMoving()
      elseif IsAltKeyDown() and IsShiftKeyDown() and button == "RightButton" then
        self:GetParent():StartSizing()
      end
    end)
    df:SetScript("OnDragStop", function(self) self:GetParent():StopMovingOrSizing() end)
    df:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_TOP")
      GameTooltip:AddLine(self:GetParent():GetName(), 0, 1, 0.5, 1, 1, 1)
      GameTooltip:AddLine("ALT+SHIFT+LeftButton to drag!", 1, 1, 1, 1, 1, 1)
      GameTooltip:AddLine("ALT+SHIFT+RightButton to resize!", 1, 1, 1, 1, 1, 1)
      GameTooltip:Show()
    end)
    df:SetScript("OnLeave", function(s) GameTooltip:Hide() end)
    df:Hide()
    --overlay texture
    local t = df:CreateTexture(nil,"OVERLAY",nil,6)
    t:SetAllPoints(df)
    t:SetTexture(1,0.6,1)
    t:SetAlpha(0.2)
    df.texture = t
    --self stuff
    self.dragFrame = df
    self:SetClampedToScreen(clamp or false)
    self:SetMovable(true)
    self:SetResizable(true)
    self:SetUserPlaced(true)
  end