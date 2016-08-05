local function bossexists()
	for i = 1, MAX_BOSS_FRAMES do
		if UnitExists("boss"..i) then
			return true
		end
	end
end


local vmboss = CreateFrame("Frame", nil)
vmboss:RegisterEvent("PLAYER_ENTERING_WORLD")
vmboss:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
vmboss:RegisterEvent("UNIT_TARGETABLE_CHANGED")
vmboss:RegisterEvent("PLAYER_REGEN_ENABLED")
vmboss:RegisterEvent("UPDATE_WORLD_STATES")
vmboss:SetScript("OnEvent", function(self, event)
	local _, instanceType = IsInInstance()
	local bar = _G["WorldStateCaptureBar1"]
	
	-- boss战自动关闭
	if bossexists() then
		ObjectiveTracker_Collapse()
	-- PVP自动关闭
	elseif instanceType=="arena" or instanceType=="pvp" then
		ObjectiveTracker_Collapse()
	-- 获得追踪栏关闭
	elseif bar and bar:IsVisible() then
		ObjectiveTracker_Collapse()
	end
end)