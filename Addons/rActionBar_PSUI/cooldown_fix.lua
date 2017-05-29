  --cooldown spiral alpha fix

  --SetCooldownSwipeAlpha
  local function SetCooldownSwipeAlpha(self,cooldown,alpha)
    cooldown:SetSwipeColor(0,0,0,alpha)
	if alpha == 0 then
        cooldown:SetDrawBling(false)
		cooldown:SetDrawSwipe(false) 
    else
        cooldown:SetDrawBling(true)
		cooldown:SetDrawSwipe(true) 
    end
  end
   
  --ApplyButtonCooldownAlphaFix
  local function ApplyButtonCooldownAlphaFix(button)
    if not button then return end
    if not button.cooldown then return end
	
    local parent = button:GetParent():GetParent():GetParent()
	if parent == nil or parent:GetName() == nil or string.find(parent:GetName(), "rActionBar") == nil then
		parent = button:GetParent():GetParent()
	end
	if parent == nil or parent:GetName() == nil or string.find(parent:GetName(), "rActionBar") == nil then
		parent = button:GetParent()
	end
	hooksecurefunc(parent, "SetAlpha", function(self,alpha) SetCooldownSwipeAlpha(self,button.cooldown,alpha) end)
  end


  local function CooldownAlphaFix()
	--style the actionbar buttons
	for i = 1, NUM_ACTIONBAR_BUTTONS do
	  ApplyButtonCooldownAlphaFix(_G["ActionButton"..i])
	  ApplyButtonCooldownAlphaFix(_G["MultiBarBottomLeftButton"..i])
	  ApplyButtonCooldownAlphaFix(_G["MultiBarBottomRightButton"..i])
	  ApplyButtonCooldownAlphaFix(_G["MultiBarRightButton"..i])
	  ApplyButtonCooldownAlphaFix(_G["MultiBarLeftButton"..i])
	end
	--override buttons
	for i = 1, 6 do
	  ApplyButtonCooldownAlphaFix(_G["OverrideActionBarButton"..i])
	end
	--petbar buttons
	for i=1, NUM_PET_ACTION_SLOTS do
	  ApplyButtonCooldownAlphaFix(_G["PetActionButton"..i])
	end
	--stancebar buttons
	for i=1, NUM_STANCE_SLOTS do
	  ApplyButtonCooldownAlphaFix(_G["StanceButton"..i])
	end
	--possess buttons
	for i=1, NUM_POSSESS_SLOTS do
	  ApplyButtonCooldownAlphaFix(_G["PossessButton"..i])
	end
  end
  
  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_LOGIN")
  f:SetScript("OnEvent", CooldownAlphaFix)