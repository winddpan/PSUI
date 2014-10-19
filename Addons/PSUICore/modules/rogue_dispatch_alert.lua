-----------------------------------------------
------------- 刺杀 35%血提示一次	-----------
-----------------------------------------------
if select(2, UnitClass("player")) == "ROGUE" then
	local currentSpecID = nil
	currentSpecID = GetSpecialization() and select(1, GetSpecializationInfo(GetSpecialization()))

	local DispatchSpelled = false
	local DispatchAlert = CreateFrame("Frame") 
	DispatchAlert:RegisterEvent("UNIT_HEALTH")
	DispatchAlert:RegisterEvent("PLAYER_TARGET_CHANGED")
	DispatchAlert:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	DispatchAlert:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	DispatchAlert:RegisterEvent("PLAYER_ENTERING_WORLD")

	DispatchAlert:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4 ,arg5, ...)
		
		if event == "ACTIVE_TALENT_GROUP_CHANGED" then
			currentSpecID = GetSpecialization() and select(1, GetSpecializationInfo(GetSpecialization()))
			return
		end
		
		if currentSpecID ~= 259 then return end		--是否刺杀天赋
		
		if event == "PLAYER_TARGET_CHANGED" or (UnitName("target") and UnitHealth("target")/UnitHealthMax("target")>= 0.35) then
			SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame,111240)
			DispatchSpelled = false
		end
		
		if not DispatchSpelled and UnitName("target") and not UnitIsDead("target") and UnitHealth("target")/UnitHealthMax("target") < 0.35 then
			SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame,111240,"TEXTURES\\SPELLACTIVATIONOVERLAYS\\RIME.BLP","TOP",1.3,255,255,255,false,false) 
		end
		
		if event == "UNIT_SPELLCAST_SUCCEEDED" and arg5 == 111240 then
			SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame,111240) 
			DispatchSpelled = true
		end
	end)
end
