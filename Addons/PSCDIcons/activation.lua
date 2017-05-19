local A, L = ...

local duration = 4
local Activate = {}
Activate.id = 'activate'
L.Activate = Activate

function Activate:Setup(cooldown)
	if not cooldown.overlay then
		local button = cooldown:GetParent()
		local overlay = CreateFrame('Frame', nil, button)
		overlay:SetFrameLevel(button:GetFrameLevel() + 10)
		overlay:SetPoint('TOPLEFT', button, 'TOPLEFT', -4, 4)
		overlay:SetPoint('BOTTOMRIGHT', button, 'BOTTOMRIGHT', 4, -4)
		cooldown.overlay = overlay
		cooldown.overlay.cooldown = cooldown
	end
end

function Activate:Run(cooldown)
	self:Setup(cooldown)
	ActionButton_ShowOverlayGlow(cooldown.overlay)
	
	local t = 0
	cooldown.overlay:SetScript("OnUpdate", function(s, e) 
		t = t + e
		if t >= duration then
			self:Stop(s.cooldown)
		end
    end)
end

function Activate:Stop(cooldown)
	if cooldown.overlay then
		cooldown.overlay:SetScript("OnUpdate", nil)
		ActionButton_HideOverlayGlow(cooldown.overlay)
	end
end