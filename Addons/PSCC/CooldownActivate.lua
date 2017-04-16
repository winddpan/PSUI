local AddonName, Addon = ...
local Timer = {}
local timers = {}
local unusedCooldown = {}
local _G = _G

--local bindings!
local Config = Addon.Config
local Activate = Addon.Activate
local GetTime = _G['GetTime']
local MIN_DELAY = 0.01

function Timer.SetNextUpdate(self, duration)
	C_Timer.After(max(duration, MIN_DELAY), self.OnTimerDone)
end

--stops the timer
function Timer.Stop(self)
	if self.enabled and self.cooldown ~= nil then
		Activate:Setup(self.cooldown)
		Activate:Run(self.cooldown)
	end
	self.enabled = nil
end

--forces the given timer to update on the next frame
function Timer.Update(self)
	if self.enabled and self.cooldown then
	    local start, duration  = GetActionCooldown(self.button.action)
		local isCharging = self.button and self.button.chargeCooldown
		local remain = not isCharging and (duration - (GetTime() - start)) or 0 
		
		if remain > 0 then
			Timer.SetNextUpdate(self, remain)
			Activate:Stop(self.cooldown)
		elseif not isCharging then
			Timer.Stop(self)
		end
	end
end


--returns a new timer object
function Timer.Create(cooldown)
	local timer = {}
	timer.OnTimerDone = function() 
		Timer.Update(timer) 
	end
	timers[cooldown] = timer

	return timer
end

function Timer.Start(cooldown, start, duration, enable, forceShowDrawEdge, modRate)
	if unusedCooldown[cooldown] then
		return
	end

	local button = cooldown:GetParent()
	local isButton = button and button:IsShown() and button:GetAlpha() > 0 and button:GetName() and (string.find(button:GetName(), "^[ActionButton]%d") or string.find(button:GetName(), "^[MultiBar].*"))
	if not isButton then
		unusedCooldown[cooldown] = true
		return 
	end
	
	--start timer
	if duration and start and start > 0  and duration > Config.minActivateDuration and (not cooldown.noTimerCount) then
		local timer = timers[cooldown] or Timer.Create(cooldown)
		timer.enabled = true
		timer.cooldown = cooldown
		timer.button = button
	else
		local timer = timers[cooldown]
		if timer then
			Timer.Stop(timer)
		end
	end
end

do
	local f = CreateFrame('Frame');
	f:SetScript('OnEvent', function(self, event)
		for cooldown, timer in pairs(timers) do
			Timer.Update(timer)
		end
	end)
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	--f:RegisterEvent('ACTIONBAR_UPDATE_STATE')
	f:RegisterEvent('ACTIONBAR_UPDATE_COOLDOWN')

	hooksecurefunc(getmetatable(_G['ActionButton1Cooldown']).__index, 'SetCooldown', Timer.Start)
end