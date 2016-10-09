local F = CreateFrame("Frame") 
    F:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") 
    F:SetScript("OnEvent", function(_,_,unit,_,_,_,spell) 
      if unit == "player" and spell == 200749 then 
	local currentSpecName = (select(2, GetSpecializationInfo(GetSpecialization()))) 
        EquipmentManager_EquipSet(currentSpecName)   
      end 
end)