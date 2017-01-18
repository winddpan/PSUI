-- Author      : Kurapica
-- Create Date : 2012/07/22
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.TotemBar", version) then
	return
end

MAX_TOTEMS = _G.MAX_TOTEMS

__Doc__[[The common totem bar]]
class "TotemBar"
	inherit "ElementPanel"
	extend "IFTotem"

	-----------------------------------------------
	--- Totem
	-- -- -----------------------------------------------
	class "Totem"
		inherit "Button"
		extend "IFCooldownIndicator"

		_Border = {
			edgeFile = [[Interface\ChatFrame\CHATFRAMEBACKGROUND]],
			edgeSize = 2,
		}

		_BorderColor = ColorType(0, 0, 0)

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		function SetUpCooldownIndicator(self, indicator)
			indicator:SetHideCountdownNumbers(true)
			indicator:SetPoint("TOPLEFT", 2, -2)
			indicator:SetPoint("BOTTOMRIGHT", -2, 2)
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		-- Icon
		property "Icon" {
			Get = function(self)
				return self:GetChild("Icon").TexturePath
			end,
			Set = function(self, value)
				self:GetChild("Icon").TexturePath = value
				if value then self:GetChild("Icon"):SetTexCoord(0.1, 0.9, 0.1, 0.9) end
			end,
			Type = String,
		}

		local function UpdateTooltip(self)
			self = IGAS:GetWrapper(self)
			if self.Slot then
				IGAS.GameTooltip:SetTotem(self.Slot)
			end
		end

		local function OnEnter(self)
			if self.Visible and self.Slot then
				IGAS.GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
				UpdateTooltip(self)
			end
		end

		local function OnLeave(self)
			IGAS.GameTooltip:Hide()
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function Totem(self, ...)
			Super(self, ...)

			self.MouseEnabled = true

			self:RegisterForClicks("RightButtonUp")

			local icon = Texture("Icon", self, "BACKGROUND")
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)

			self.Backdrop = _Border
			self.BackdropBorderColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

			self.OnEnter = self.OnEnter + OnEnter
			self.OnLeave = self.OnLeave + OnLeave
			IGAS:GetUI(self).UpdateTooltip = UpdateTooltip
		end
	endclass "Totem"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetTotemByIndex(self, index, haveTotem, name, start, duration, icon)
		local btn = self.Element[index]

		if btn then
			if haveTotem and name and duration > 0 then
				btn.Icon = icon
				btn:OnCooldownUpdate(start, duration)

				btn.Visible = true
			else
				btn:OnCooldownUpdate()
				btn.Visible = false
			end
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function TotemBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.FrameStrata = "LOW"
		self.KeepMaxSize = true
		self.ColumnCount = MAX_TOTEMS
		self.RowCount = 1
		self.ElementWidth = 24
		self.ElementHeight = 24
		self.HSpacing = 2
		self.VSpacing = 2
		self.MouseEnabled = false
		self.MouseWheelEnabled = false
		self.ElementType = Totem

		for i, v in ipairs(IFTotem.TotemSlotMap) do
			self.Element[i].Slot = v
		end
	end
endclass "TotemBar"

__Doc__[[The common totem bar]]
class "SecureTotemBar"
	inherit "SecureFrame"
	extend "IFSecurePanel"
	extend "IFTotem"

	-----------------------------------------------
	--- Totem
	-- -- -----------------------------------------------
	class "SecureTotem"
		inherit "SecureButton"
		extend "IFCooldownIndicator"

		_Border = {
			edgeFile = [[Interface\ChatFrame\CHATFRAMEBACKGROUND]],
			edgeSize = 2,
		}

		_BorderColor = ColorType(0, 0, 0)

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		function SetUpCooldownIndicator(self, indicator)
			indicator:SetHideCountdownNumbers(true)
			indicator:SetPoint("TOPLEFT", 2, -2)
			indicator:SetPoint("BOTTOMRIGHT", -2, 2)
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		-- Icon
		property "Icon" {
			Get = function(self)
				return self:GetChild("Icon").TexturePath
			end,
			Set = function(self, value)
				self:GetChild("Icon").TexturePath = value
				if value then self:GetChild("Icon"):SetTexCoord(0.1, 0.9, 0.1, 0.9) end
			end,
			Type = String,
		}

		local function UpdateTooltip(self)
			self = IGAS:GetWrapper(self)
			if self.Slot and self.Alpha > 0 then
				IGAS.GameTooltip:SetTotem(self.Slot)
			else
				IGAS.GameTooltip:Hide()
			end
		end

		local function OnEnter(self)
			if self.Visible and self.Slot then
				IGAS.GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
				UpdateTooltip(self)
			end
		end

		local function OnLeave(self)
			IGAS.GameTooltip:Hide()
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function SecureTotem(self, ...)
			Super(self, ...)

			self.MouseEnabled = true
			self:RegisterForClicks("RightButtonUp")

			local icon = Texture("Icon", self, "BACKGROUND")
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)

			self.Backdrop = _Border
			self.BackdropBorderColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

			self.OnEnter = self.OnEnter + OnEnter
			self.OnLeave = self.OnLeave + OnLeave
			IGAS:GetUI(self).UpdateTooltip = UpdateTooltip
		end
	endclass "SecureTotem"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetTotemByIndex(self, index, haveTotem, name, start, duration, icon)
		local btn = self.Element[index]

		if btn then
			if haveTotem and name and duration > 0 then
				btn.Icon = icon
				btn:OnCooldownUpdate(start, duration)

				btn.Alpha = 1
			else
				btn:OnCooldownUpdate()
				btn.Alpha = 0
			end
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function SecureTotemBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.FrameStrata = "LOW"
		self.KeepMaxSize = true
		self.ColumnCount = MAX_TOTEMS
		self.RowCount = 1
		self.ElementWidth = 24
		self.ElementHeight = 24
		self.HSpacing = 2
		self.VSpacing = 2
		self.MouseEnabled = false
		self.MouseWheelEnabled = false
		self.ElementType = SecureTotem

		for i, v in ipairs(IFTotem.TotemSlotMap) do
			self.Element[i].Slot = v

			self.Element[i]:SetAttribute("type", "destroytotem")
			self.Element[i]:SetAttribute("totem-slot", v)
		end
	end
endclass "SecureTotemBar"
