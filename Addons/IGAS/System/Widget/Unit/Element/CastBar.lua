-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.Unit.CastBar", version) then
	return
end

__Doc__[[The cast bar]]
class "CastBar"
	inherit "Frame"
	extend "IFCast" "IFCooldownLabel" "IFCooldownStatus"

	_DELAY_TEMPLATE = FontColor.RED .. "(%.1f)" .. FontColor.CLOSE

	-- Update SafeZone
	local function Status_OnValueChanged(self, value)
		local parent = self.Parent

		if parent.Unit ~= "player" then
			return
		end

		local _, _, _, latencyWorld = GetNetStats()

		if latencyWorld == parent.LatencyWorld then
			-- well, GetNetStats update every 30s, so no need to go on
			return
		end

		parent.LatencyWorld = latencyWorld

		if latencyWorld > 0 and parent.Duration and parent.Duration > 0 then
			parent.SafeZone.Visible = true

			local pct = latencyWorld / parent.Duration / 1000

			if pct > 1 then pct = 1 end

			parent.SafeZone.Width = self.Width * pct
		else
			parent.SafeZone.Visible = false
		end
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetUpCooldownLabel(self, label)
		label:SetPoint("RIGHT")
		label.JustifyH = "RIGHT"
		label.FontObject = "TextStatusBarText"
	end

	function SetUpCooldownStatus(self, status)
		status:SetPoint("TOPLEFT", self.Icon, "TOPRIGHT")
		status:SetPoint("BOTTOMRIGHT")
		status.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
		status.FrameStrata = "LOW"
		status.MinMaxValue = MinMax(1, 100)
		status.Layer = "BORDER"

		status.OnValueChanged = status.OnValueChanged + Status_OnValueChanged
	end

	function Start(self, spell, rank, lineID, spellID)
		local name, _, text, texture, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(self.Unit)

		if not name then
			self.Alpha = 0
			return
		end

		startTime = startTime / 1000
		endTime = endTime / 1000

		self.Duration = endTime - startTime
		self.EndTime = endTime
		self.Icon.TexturePath = texture
		self.Shield.Visible = notInterruptible
		self.SpellName.Text = name
		self.LineID = lineID

		-- Init
		self.DelayTime = 0
		self.LatencyWorld = 0
		self.IFCooldownStatusReverse = true

		-- SafeZone
		self.SafeZone:ClearAllPoints()
		self.SafeZone:SetPoint("TOP")
		self.SafeZone:SetPoint("BOTTOM")
		self.SafeZone:SetPoint("RIGHT")
		self.SafeZone.Visible = false

		self:OnCooldownUpdate(startTime, self.Duration)

		self.Alpha = 1
	end

	function Fail(self, spell, rank, lineID, spellID)
		if not lineID or lineID == self.LineID then
			self:OnCooldownUpdate()
			self.Alpha = 0
			self.Duration = 0
			self.LineID = nil
		end
	end

	function Stop(self, spell, rank, lineID, spellID)
		if not lineID or lineID == self.LineID then
			self:OnCooldownUpdate()
			self.Alpha = 0
			self.Duration = 0
			self.LineID = nil
		end
	end

	function Interrupt(self, spell, rank, lineID, spellID)
		if not lineID or lineID == self.LineID then
			self:OnCooldownUpdate()
			self.Alpha = 0
			self.Duration = 0
			self.LineID = nil
		end
	end

	function Interruptible(self)
		self.Shield.Visible = false
	end

	function UnInterruptible(self)
		self.Shield.Visible = true
	end

	function Delay(self, spell, rank, lineID, spellID)
		local name, _, text, texture, startTime, endTime = UnitCastingInfo(self.Unit)

		if not startTime or not endTime then return end

		startTime = startTime / 1000
		endTime = endTime / 1000

		local duration = endTime - startTime

		-- Update
		self.LatencyWorld = 0
		self.EndTime = self.EndTime or endTime
		self.DelayTime = endTime - self.EndTime
		self.Duration = duration
		self.SpellName.Text = name .. self.DelayFormatString:format(self.DelayTime)

		self:OnCooldownUpdate(startTime, self.Duration)
	end

	function ChannelStart(self, spell, rank, lineID, spellID)
		local name, _, text, texture, startTime, endTime, _, notInterruptible = UnitChannelInfo(self.Unit)

		if not name then
			self.Alpha = 0
			self.Duration = 0
			return
		end

		startTime = startTime / 1000
		endTime = endTime / 1000

		self.Duration = endTime - startTime
		self.EndTime = endTime
		self.Icon.TexturePath = texture
		self.Shield.Visible = notInterruptible
		self.SpellName.Text = name

		-- Init
		self.DelayTime = 0
		self.LatencyWorld = 0
		self.IFCooldownStatusReverse = false

		-- SafeZone
		self.SafeZone:ClearAllPoints()
		self.SafeZone:SetPoint("TOP")
		self.SafeZone:SetPoint("BOTTOM")
		self.SafeZone:SetPoint("LEFT", self.Icon, "RIGHT")
		self.SafeZone.Visible = false

		self:OnCooldownUpdate(startTime, self.Duration)

		self.Alpha = 1
	end

	function ChannelUpdate(self, spell, rank, lineID, spellID)
		local name, _, text, texture, startTime, endTime = UnitChannelInfo(self.Unit)

		if not name or not startTime or not endTime then
			self:OnCooldownUpdate()
			self.Alpha = 0
			return
		end

		startTime = startTime / 1000
		endTime = endTime / 1000

		local duration = endTime - startTime

		-- Update
		self.LatencyWorld = 0
		self.EndTime = self.EndTime or endTime
		self.DelayTime = endTime - self.EndTime
		self.Duration = duration
		if self.DelayTime > 0 then
			self.SpellName.Text = name .. self.DelayFormatString:format(self.DelayTime)
		end
		self:OnCooldownUpdate(startTime, self.Duration)
	end

	function ChannelStop(self, spell, rank, lineID, spellID)
		self:OnCooldownUpdate()
		self.Alpha = 0
		self.Duration = 0
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The delay time format string like "%.1f"]]
	property "DelayFormatString" { Type = String, Default = _DELAY_TEMPLATE }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnSizeChanged(self)
		if self.Height > 0 then
			self.Icon.Width = self.Height
			self.SpellName:SetFont(self.SpellName:GetFont(), self.Height * 4 / 7, "OUTLINE")
		end
	end

	local function OnHide(self)
		self:OnCooldownUpdate()
		self.Alpha = 0
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function CastBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 16
		self.Width = 200

		self.IFCooldownLabelUseDecimal = true
		self.IFCooldownLabelAutoColor = false

		-- Icon
		local icon = Texture("Icon", self, "ARTWORK")
		icon:SetPoint("TOPLEFT")
		icon:SetPoint("BOTTOMLEFT")
		icon.Width = self.Height

		-- Shield
		local shield = Texture("Shield", self, "OVERLAY")
		shield:SetPoint("TOPLEFT", icon,"TOPLEFT", -8, 8)
		shield:SetPoint("BOTTOMRIGHT", icon,"BOTTOMRIGHT", 8, -8)
		shield.TexturePath = [[Interface\SpellActivationOverlay\IconAlert]]
		shield:SetTexCoord(0.00781250,0.50781250,0.27734375,0.52734375)
		shield.Visible = false

		-- SpellName
		local text = FontString("SpellName", self, "ARTWORK", "TextStatusBarText")
		text:SetPoint("LEFT", shield, "RIGHT")
		text.JustifyH = "LEFT"
		text:SetFont(text:GetFont(), self.Height * 4 / 7, "OUTLINE")

		-- SafeZone
		local safeZone = Texture("SafeZone", self, "ARTWORK")
		safeZone.Color = ColorType(1, 0, 0)
		safeZone.Visible = false

		self.OnSizeChanged = self.OnSizeChanged + OnSizeChanged
		self.OnHide = self.OnHide + OnHide
	end
endclass "CastBar"
