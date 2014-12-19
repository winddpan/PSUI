local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("GARRISON_MISSION_FINISHED")
frame:RegisterEvent("GARRISON_MISSION_COMPLETE")
SetCVar("lastGarrisonMissionTutorial", 8);

local function myDebug(text)
    --[===[@debug@
    print("|cff2476ffBreeze:|r " .. text)
    --@end-debug@]===]
end

SLASH_BREEZE1 = "/breeze";

function BreezeInit(self, event, arg1, ...)

  
  if event == "ADDON_LOADED" and arg1 == "Blizzard_GarrisonUI" then
    
    Orig_Initialize = GarrisonMissionComplete_BeginAnims;
    GarrisonMissionComplete_BeginAnims = function(...)
      myDebug("GarrisonMissionComplete_BeginAnims triggered!")

      local self = ...
      self.BonusRewards.ChestModel.OpenAnim:Stop();
      self.BonusRewards.ChestModel.LockBurstAnim:Stop();
      self.BonusRewards.ChestModel:SetAlpha(1);
      for i = 1, #self.BonusRewards.Rewards do
        self.BonusRewards.Rewards[i]:Hide();
      end
      self.BonusRewards.ChestModel.LockBurstAnim:Stop();
      self.ChanceFrame.SuccessAnim:Stop();
      self.ChanceFrame.FailureAnim:Stop();
      self.BonusRewards.Saturated:Show();
      self.BonusRewards.ChestModel.Lock:Hide();
      self.BonusRewards.ChestModel:SetAnimation(0, 0);
      self.BonusRewards.ChestModel.ClickFrame:Show();
      self.ChanceFrame.ChanceText:SetAlpha(0);
      self.ChanceFrame.FailureText:SetAlpha(0);
      self.ChanceFrame.SuccessText:SetAlpha(1);
      self.ChanceFrame.Banner:SetAlpha(1);
      self.ChanceFrame.Banner:SetWidth(GARRISON_MISSION_COMPLETE_BANNER_WIDTH);
      
      self.encounterIndex = 1;
      self.animIndex = animIndex or 0;
      self.animTimeLeft = 0;
      self:SetScript("OnUpdate", GarrisonMissionComplete_OnUpdate);
      -- let's try setting the encounter numbers to 0, see what happens!
      -- GarrisonMissionComplete_SetNumEncounters(0)
      -- results: while technically this works, the followers frame is still delayed by whatever time it used to take to do the animation. Need to find a better way.
      
      -- self.NextMissionButton:Enable()
      -- C_Garrison.MissionBonusRoll(GarrisonMissionFrame.MissionComplete.currentMission.missionID);

      if ( C_Garrison.CanOpenMissionChest(GarrisonMissionFrame.MissionComplete.currentMission.missionID) ) then
        GarrisonMissionFrame.MissionComplete.BonusRewards.ChestModel:Hide();
     
        local bonusRewards = GarrisonMissionFrame.MissionComplete.BonusRewards;
        bonusRewards.waitForEvent = true;
        bonusRewards.waitForTimer = true;
        bonusRewards.success = false;
        bonusRewards:RegisterEvent("GARRISON_MISSION_BONUS_ROLL_COMPLETE");
        bonusRewards.ChestModel.OpenAnim:Play();
        C_Timer.After(0.1, GarrisonMissionComplete_OnRewardTimer);
        C_Garrison.MissionBonusRoll(GarrisonMissionFrame.MissionComplete.currentMission.missionID);
        PlaySound("UI_Garrison_CommandTable_ChestUnlock_Gold_Success");
        GarrisonMissionFrame.MissionComplete.NextMissionButton:Disable();
      else
        GarrisonMissionFrame.MissionComplete.NextMissionButton:Enable();
      end
    end
    
    GARRISON_ANIMATION_LENGTH = 0;
    

    function Local_NoAnimation(self, entry)
        GarrisonMissionFrame.MissionComplete.Stage:Hide();
        GarrisonMissionFrame.MissionComplete.NextMissionButton:Click();
    end
    
    -- if BREEZE_TURBO then
        -- OVER_ANIMATION_CONTROL = {
          -- [1] = { duration = nil,   onStartFunc = Local_NoAnimation },         -- line between encounters
          -- [2] = { duration = nil,   onStartFunc = Local_NoAnimation },      -- check that models are loaded
          -- [3] = { duration = nil,   onStartFunc = Local_NoAnimation },         -- model fight
          -- [4] = { duration = nil,   onStartFunc = Local_NoAnimation },    -- impact sound when follower hits
          -- [5] = { duration = nil,  onStartFunc = Local_NoAnimation },       -- X over portrait
          -- [6] = { duration = nil,   onStartFunc = Local_NoAnimation },    -- evaluate whether to do next encounter or move on
          -- [7] = { duration = nil,  onStartFunc = Local_NoAnimation },        -- reward panel
          -- [8] = { duration = nil,   onStartFunc = Local_NoAnimation },        -- explode the lock if mission successful
          -- [9] = { duration = nil,   onStartFunc = Local_NoAnimation },      -- show all the mission followers
          -- [10] = { duration = nil,    onStartFunc = Local_NoAnimation },           -- follower xp
        -- }
    -- else 
        OVER_ANIMATION_CONTROL = {
          [1] = { duration = nil,   onStartFunc = GarrisonMissionComplete_AnimLine },         -- line between encounters
          [2] = { duration = nil,   onStartFunc = GarrisonMissionComplete_AnimCheckModels },      -- check that models are loaded
          [3] = { duration = nil,   onStartFunc = GarrisonMissionComplete_AnimModels },         -- model fight
          [4] = { duration = nil,   onStartFunc = GarrisonMissionComplete_AnimPlayImpactSound },    -- impact sound when follower hits
          [5] = { duration = 0,  onStartFunc = GarrisonMissionComplete_AnimPortrait },       -- X over portrait
          [6] = { duration = nil,   onStartFunc = GarrisonMissionComplete_AnimCheckEncounters },    -- evaluate whether to do next encounter or move on
          [7] = { duration = 0,  onStartFunc = GarrisonMissionComplete_AnimRewards },        -- reward panel
          [8] = { duration = 0,   onStartFunc = GarrisonMissionComplete_AnimLockBurst },        -- explode the lock if mission successful
          [9] = { duration = 0,   onStartFunc = GarrisonMissionComplete_AnimFollowersIn },      -- show all the mission followers
          [10] = { duration = 0,    onStartFunc = GarrisonMissionComplete_AnimXP },           -- follower xp
        }
    -- end
     
    
    Or_GarrisonMissionComplete_FindAnimIndexFor = GarrisonMissionComplete_FindAnimIndexFor;
    GarrisonMissionComplete_FindAnimIndexFor = function(func)
      for i = 1, #OVER_ANIMATION_CONTROL do
        if ( OVER_ANIMATION_CONTROL[i].onStartFunc == func ) then
          myDebug("GarrisonMissionComplete_FindAnimIndexFor triggered: " .. i);
          return i;
        end
      end
      return 0;
    end
    
    Or_GarrisonMissionComplete_OnUpdate = GarrisonMissionComplete_OnUpdate;
    GarrisonMissionComplete_OnUpdate = function(self, elapsed)
        -- myDebug("GarrisonMissionComplete_OnUpdate triggered")
        
        self.animTimeLeft = self.animTimeLeft - elapsed;
        if ( self.animTimeLeft <= 0 ) then
            self.animIndex = self.animIndex + 1;
            local entry = OVER_ANIMATION_CONTROL[self.animIndex];
            if ( entry ) then
              entry.onStartFunc(self, entry);
              self.animTimeLeft = entry.duration;
            else
              -- done
              self:SetScript("OnUpdate", nil);
            end
        end
    end
    
  end
end

function SlashCmdList.BREEZE(arg)
    if arg == "turbo" then
        BREEZE_TURBO = not BREEZE_TURBO
        SELECTED_CHAT_FRAME:AddMessage("|cff33ff99Breeze|r: Turbo mode " .. (BREEZE_TURBO and "enabled" or "disabled"))
    else
        SELECTED_CHAT_FRAME:AddMessage("|cff33ff99Breeze Options|r: turbo")
    end
end

    
frame:SetScript("OnEvent", BreezeInit)