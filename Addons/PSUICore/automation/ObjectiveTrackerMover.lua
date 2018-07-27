
  -- // rObjectiveTrackerMover
  -- // zork - 2014

  -----------------------------
  -- VARIABLES
  -----------------------------
  
  local an, at = ...
  local unpack = unpack  
  local ObjectiveTrackerFrame = ObjectiveTrackerFrame

  local frame = CreateFrame("Frame")
  local pos = {"TOPRIGHT", UIParent, "TOPRIGHT", -80, -305}
  local pa1,paf,pa2,px,py = unpack(pos)

  -----------------------------
  -- FUNCTIONS
  -----------------------------

  local function AdjustSetPoint(self,...)
    local a1,af,a2,x,y = ...
    if a1 and af == "MinimapCluster" and y ~= py or x ~= px then 
		self:SetPoint(unpack(pos))     
    end
  end 

  frame:SetScript("OnEvent", function(self,event)
    self:UnregisterEvent(event)
    if event == "PLAYER_LOGIN" then
      self.point = {ObjectiveTrackerFrame:GetPoint()}      
      hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", AdjustSetPoint) 
	  
	  local gbtn = _G["GarrisonLandingPageMinimapButton"]
	  gbtn:ClearAllPoints()
	  gbtn:SetPoint("TOPLEFT", Minimap.mnMap, "TOPLEFT", -25, 25) 
	  gbtn:SetScale(.78)
    end
    if not InCombatLockdown() then
      ObjectiveTrackerFrame:SetPoint(unpack(self.point))
    end
  end)
  
  frame:RegisterEvent("PLAYER_LOGIN")

