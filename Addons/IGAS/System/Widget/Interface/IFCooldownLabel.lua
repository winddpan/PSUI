-- Author      : Kurapica
-- Create Date : 2012/07/24
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.IFCooldownLabel", version) then
	return
end

__Doc__[[IFCooldownLabel is used to provide a label to display the cooldown]]
__AutoProperty__()
interface "IFCooldownLabel"
	extend "IFCooldown"

	_IFCooldownLabel_List = _IFCooldownLabel_List or {}

	_IFCooldownLabel_Timer = Timer("IGAS_IFCooldownLabel_Timer")
	_IFCooldownLabel_Timer.Enabled = false
	_IFCooldownLabel_Timer.Interval = 0.1	-- Keep low

	_NORMAL_COLOR = ColorType(1, 1, 1)
	_DAY_COLOR = ColorType(0.4, 0.4, 0.4)
	_HOUR_COLOR = ColorType(0.6, 0.4, 0)
	_MIN_COLOR = ColorType(0.8, 0.6, 0)
	_SEC_COLOR = ColorType(1, 0.82, 0)
	_LAST_COLOR_1 = ColorType(1, 0.12, 0.12)
	_LAST_COLOR_2 = ColorType(1, 0.82, 0.12)

	local function GetDisplayInfo(frame, remain)
		if remain < 10 then
			if frame.IFCooldownLabelUseDecimal then
				return ("%.1f"):format(remain), remain-floor(remain)>0.5 and _LAST_COLOR_1 or _LAST_COLOR_2, 0.1
			else
				return tostring(ceil(remain)), remain-floor(remain)>0.5 and _LAST_COLOR_1 or _LAST_COLOR_2, 0.2
			end
		elseif remain < 60 then
			return tostring(ceil(remain)), _SEC_COLOR, remain - floor(remain)
		elseif remain < 3600 then
			return ceil(remain/60).."m", _MIN_COLOR, remain % 60
		elseif (remain < 86400) then
			return ceil(remain/3600).."h", _HOUR_COLOR, remain % 3600
		else
			return ceil(remain/86400).."d", _DAY_COLOR, remain % 86400
		end
	end

	function _IFCooldownLabel_Timer:OnTimer()
		local now = GetTime()
		local label
		local text, color, wait

		for frame in pairs(_IFCooldownLabel_List) do
			if frame.__IFCooldownLabel_UpdateTime and now >= frame.__IFCooldownLabel_UpdateTime then
				label = frame:GetChild("CooldownLabel")

				if now >= frame.__IFCooldownLabel_End then
					-- Clear label
					_IFCooldownLabel_List[frame] = nil
					label.Visible = false

					if not next(_IFCooldownLabel_List) then
						_IFCooldownLabel_Timer.Enabled = false
					end
				else
					-- Update label
					text, color, wait = GetDisplayInfo(frame, frame.__IFCooldownLabel_End - now)

					label.Text = text
					if frame.IFCooldownLabelAutoColor then
						label.TextColor = color
					end

					frame.__IFCooldownLabel_UpdateTime = now + wait
					--print(wait, label.Text)
				end
			end
		end
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Custom the label</desc>
		<param name="label">System.Widget.FontString</param>
	]]
	function SetUpCooldownLabel(self, label)
		label:SetPoint("BOTTOM")
		if self.Height > 0 then
			label:SetFont(label:GetFont(), self.Height * 2 / 3, "OUTLINE")
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether the cooldown label using decimal format]]
	property "IFCooldownLabelUseDecimal" { Type = Boolean }

	__Doc__[[Whether the cooldown label using auto color]]
	__Handler__( function (self, value)
		if not value then
			self:GetChild("CooldownLabel").TextColor = _NORMAL_COLOR
		end
	end )
	property "IFCooldownLabelAutoColor" { Type = Boolean }

	__Doc__[[Whether change the font size based on the jeight]]
	property "IFCooldownLabelAutoSize" { Type = Boolean, Default = true }

	__Doc__[[The min duration to display the label]]
	property "IFCooldownLabelMinDuration" { Type = Number, Default = 0 }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnCooldownUpdate(self, start, duration)
		local label = self:GetChild("CooldownLabel")

		if start and start > 0 and duration and duration > self.IFCooldownLabelMinDuration then
			-- Insert to update list
			self.__IFCooldownLabel_End = start + duration
			self.__IFCooldownLabel_UpdateTime = GetTime()

			label.Visible = true

			_IFCooldownLabel_List[self] = true
			_IFCooldownLabel_Timer.Enabled = true
		elseif _IFCooldownLabel_List[self] then
			-- Remove from update list
			_IFCooldownLabel_List[self] = nil

			label.Visible = false

			if not next(_IFCooldownLabel_List) then
				_IFCooldownLabel_Timer.Enabled = false
			end
		end
	end

	local function OnSizeChanged(self)
		if self.Height > 0 and self.IFCooldownLabelAutoSize then
			self:GetChild("CooldownLabel"):SetFont(self:GetChild("CooldownLabel"):GetFont(), self.Height * 4 / 7, "OUTLINE")
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFCooldownLabel_List[self] = nil

		if not next(_IFCooldownLabel_List) then
			_IFCooldownLabel_Timer.Enabled = false
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFCooldownLabel(self)
		if not Reflector.ObjectIsClass(self, Frame) then return end

		local label = self:GetChild("CooldownLabel")

		if label and label:IsClass(FontString) then
			-- pass
		else
			if label then label:Dispose() end
			self:SetUpCooldownLabel(FontString("CooldownLabel", self, "ARTWORK", "CombatTextFont"))
		end

		if self.Height > 0 then
			self:GetChild("CooldownLabel"):SetFont(self:GetChild("CooldownLabel"):GetFont(), self.Height * 4 / 7, "OUTLINE")
		end

		self.OnCooldownUpdate = self.OnCooldownUpdate + OnCooldownUpdate
		self.OnSizeChanged = self.OnSizeChanged + OnSizeChanged
	end
endinterface "IFCooldownLabel"
