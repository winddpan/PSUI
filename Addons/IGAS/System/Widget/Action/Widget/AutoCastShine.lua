-- Author      : Kurapica
-- Create Date : 2012/10/17
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Action.AutoCastShine", version) then
	return
end

AUTOCAST_SHINE_R = .95
AUTOCAST_SHINE_G = .95
AUTOCAST_SHINE_B = .32

AUTOCAST_SHINE_SPEEDS = { 2, 4, 6, 8 }
AUTOCAST_SHINE_TIMERS = { 0, 0, 0, 0 }

_Action_AUTOCAST_SHINES = _Action_AUTOCAST_SHINES or {}

_Action_AutoCastShine = _Action_AutoCastShine or Frame("IGAS_ACTION_AUTOCASTSHINE")
_Action_AutoCastShine.Visible = false

function _Action_AutoCastShine:OnUpdate(elapsed)
	for i in next, AUTOCAST_SHINE_TIMERS do
		AUTOCAST_SHINE_TIMERS[i] = AUTOCAST_SHINE_TIMERS[i] + elapsed
		if AUTOCAST_SHINE_TIMERS[i] > AUTOCAST_SHINE_SPEEDS[i]*4 then
			AUTOCAST_SHINE_TIMERS[i] = 0
		end
	end

	for button in next, _Action_AUTOCAST_SHINES do
		local distance = button:GetWidth()

		for i = 1, 4 do
			local timer = AUTOCAST_SHINE_TIMERS[i]
			local speed = AUTOCAST_SHINE_SPEEDS[i]

			if ( timer <= speed ) then
				local basePosition = timer/speed*distance
				button[0+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)
				button[4+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
				button[8+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)
				button[12+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
			elseif ( timer <= speed*2 ) then
				local basePosition = (timer-speed)/speed*distance
				button[0+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)
				button[4+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
				button[8+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
				button[12+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)
			elseif ( timer <= speed*3 ) then
				local basePosition = (timer-speed*2)/speed*distance
				button[0+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
				button[4+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)
				button[8+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
				button[12+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)
			else
				local basePosition = (timer-speed*3)/speed*distance
				button[0+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
				button[4+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)
				button[8+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)
				button[12+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
			end
		end
	end
end

__Doc__[[Animation for auto cast action button]]
__AutoProperty__()
class "AutoCastShine"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[ Start Auto cast shine]]
	function Start(self)
		if not _Action_AUTOCAST_SHINES[self] then
			_Action_AUTOCAST_SHINES[self] = true
			self.Visible = true

			_Action_AutoCastShine.Visible = true
		end
	end

	__Doc__[[Stop Auto cast shine]]
	function Stop(self)
		_Action_AUTOCAST_SHINES[self] = nil
		self.Visible = false
		if not next(_Action_AUTOCAST_SHINES) then
			_Action_AutoCastShine.Visible = false
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function AutoCastShine(self, name, parent, ...)
    	Super(self, name, parent, ...)

		self:SetPoint("TOPLEFT", 1, -1)
		self:SetPoint("BOTTOMRIGHT", -1, 1)
		self.Visible = false

		-- BACKGROUND
		for i = 1, 16 do
			local part = Texture("part"..i, self, "BACKGROUND")
			part.TexturePath = [[Interface\ItemSocketingFrame\UI-ItemSockets]]
			part.BlendMode = "ADD"
			part:SetTexCoord(0.3984375, 0.4453125, 0.40234375, 0.44921875)
			part:SetPoint("CENTER")

			local size = i%4 == 1 and 13
						or i%4 == 2 and 10
						or i%4 == 3 and 7
						or 4
			part:SetSize(size, size)

			self[i] = part
		end
    end
endclass "AutoCastShine"
