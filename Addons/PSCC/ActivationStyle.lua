local AddonName, Addon = ...

local duration = Addon.Config.minDuration
local Activate = {}
Activate.id = 'activate'
Addon.Activate = Activate

local function OnAnimInFinished(self)
	C_Timer.After(duration, self:GetParent().FadeOut)
end

function Activate:Setup(cooldown)
	if self:Get(cooldown) then
		return
	end

	local button = cooldown:GetParent()
	local width, height = button:GetSize()
	local overlay = CreateFrame('Frame', '$parentCCActivate', button, 'ActionBarButtonSpellActivationAlert')

	overlay:SetSize(width * 1.4, height * 1.4)
	overlay:SetFrameLevel(overlay:GetFrameLevel() + 5)
	overlay:SetPoint('TOPLEFT', button, 'TOPLEFT', -width * 0.2, height * 0.2)
	overlay:SetPoint('BOTTOMRIGHT', button, 'BOTTOMRIGHT', width * 0.2, -height * 0.2)
	
	overlay.FadeOut = function() 
		overlay.animIn:Stop()
		overlay.animOut:Play()
	end
	overlay.animIn:HookScript('OnFinished', OnAnimInFinished)
	cooldown.ccActivate = overlay
end

function Activate:Run(cooldown)
	local overlay = self:Get(cooldown)
	if overlay then
		if overlay.animOut:IsPlaying() then
			overlay.animOut:Stop()
		end
		if not overlay.animIn:IsPlaying() then
			overlay.animIn:Play()
		end
	end
end

function Activate:Stop(cooldown)
	local overlay = self:Get(cooldown)
	if overlay then
		if overlay.animIn:IsPlaying() then
			overlay.animIn:Stop()
		end
		if not overlay.animOut:IsPlaying() then
			overlay.animOut:Play()
		end
	end
end

function Activate:Get(cooldown)
	return cooldown.ccActivate
end
