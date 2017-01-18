-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.EclipseBar", version) then
	return
end

__Doc__[[The eclipse bar]]
class "EclipseBar"
	inherit "Frame"
	extend "IFEclipse"

	SPELL_POWER_ECLIPSE = _G.SPELL_POWER_ECLIPSE

	ECLIPSE_MARKER_COORDS = _G.ECLIPSE_MARKER_COORDS
	ECLIPSE_ICONS = _G.ECLIPSE_ICONS

	GameTooltip = _G.GameTooltip
	BALANCE = _G.BALANCE
	BALANCE_TOOLTIP = _G.BALANCE_TOOLTIP

	ECLIPSE_BAR_TRAVEL = 38

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Handler__( function(self, flag)
		if flag then
			self.Glow:ClearAllPoints()

			local glowInfo = ECLIPSE_ICONS["sun"].big
			self.Glow:SetPoint("CENTER", self.Sun, "CENTER", 0, 0)
			self.Glow:SetWidth(glowInfo.x)
			self.Glow:SetHeight(glowInfo.y)
			self.Glow:SetTexCoord(glowInfo.left, glowInfo.right, glowInfo.top, glowInfo.bottom)
		end

		self.SunBar.SunActivate.Playing = flag
		self.Glow.SunActivate.Playing = flag
		self.DarkMoon.SunActivate.Playing = flag

		self.SunBar.SunDeactivate.Playing = not flag
		self.Glow.SunDeactivate.Playing = not flag
		self.DarkMoon.SunDeactivate.Playing = not flag
	end )
	property "SunActivated" { Type = Boolean }

	__Handler__( function (self, flag)
		if flag then
			self.Glow:ClearAllPoints()

			local glowInfo = ECLIPSE_ICONS["moon"].big
			self.Glow:SetPoint("CENTER", self.Moon, "CENTER", 0, 0)
			self.Glow:SetWidth(glowInfo.x)
			self.Glow:SetHeight(glowInfo.y)
			self.Glow:SetTexCoord(glowInfo.left, glowInfo.right, glowInfo.top, glowInfo.bottom)
		end

		self.MoonBar.MoonActivate.Playing = flag
		self.Glow.MoonActivate.Playing = flag
		self.DarkSun.MoonActivate.Playing = flag

		self.MoonBar.MoonDeactivate.Playing = not flag
		self.Glow.MoonDeactivate.Playing = not flag
		self.DarkSun.MoonDeactivate.Playing = not flag
	end)
	property "MoonActivated" { Type = Boolean }

	__Handler__( function (self, dir) self.Marker:SetTexCoord(unpack(ECLIPSE_MARKER_COORDS[dir])) end )
	property "Direction" { Type = EclipseDirection, Default = EclipseDirection.None }

	property "MinMaxValue" {
		Get = function(self)
			return MinMax(self.__Min, self.__Max)
		end,
		Set = function(self, value)
			self.__Min, self.__Max = value.min, value.max
		end,
		Type = MinMax,
	}

	__Handler__( function (self, value)
		self.PowerText.Text = tostring(abs(value))

		if self.__Max and self.__Max > 0 and value then
			self.Marker:SetPoint("CENTER", (value/self.__Max) *  ECLIPSE_BAR_TRAVEL, 0)
		end
	end )
	property "Value" { Type = NumberNil }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnEnter(self)
		self.PowerText.Visible = true
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(BALANCE, 1, 1, 1)
		GameTooltip:AddLine(BALANCE_TOOLTIP, nil, nil, nil, true)
		GameTooltip:Show()
	end

	local function OnLeave(self)
		if not self.LockShow then
			self.PowerText.Visible = false
		end
		GameTooltip:Hide()
	end

	local function SunActivate_OnPlay(self)
		local panel = self.Parent.Parent

		panel.MoonBar.Alpha = 0
		panel.DarkSun.Alpha = 0
	end

	local function SunActivate_OnFinished(self)
		local panel = self.Parent.Parent

		panel.SunBar.Alpha = 1
		panel.Glow.Alpha = 1
		panel.DarkMoon.Alpha = 1

		panel.Glow.Pulse:Play()
	end

	local function SunDeactivate_OnPlay(self)
		local panel = self.Parent.Parent

		panel.Glow.Pulse:Stop()
	end

	local function SunDeactivate_OnFinished(self)
		local panel = self.Parent.Parent

		panel.SunBar.Alpha = 0
		panel.Glow.Alpha = 0
		panel.DarkMoon.Alpha = 0
	end

	local function MoonActivate_OnPlay(self)
		local panel = self.Parent.Parent

		panel.SunBar.Alpha = 0
		panel.DarkMoon.Alpha = 0
	end

	local function MoonActivate_OnFinished(self)
		local panel = self.Parent.Parent

		panel.MoonBar.Alpha = 1
		panel.Glow.Alpha = 1
		panel.DarkSun.Alpha = 1

		panel.Glow.Pulse:Play()
	end

	local function MoonDeactivate_OnPlay(self)
		local panel = self.Parent.Parent

		panel.Glow.Pulse:Stop()
	end

	local function MoonDeactivate_OnFinished(self)
		local panel = self.Parent.Parent

		panel.MoonBar.Alpha = 0
		panel.Glow.Alpha = 0
		panel.DarkSun.Alpha = 0
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function EclipseBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self:SetSize(140, 38)
		self:SetHitRectInsets(4, 4, 6, 6)

		-- Bar
		local bar = Texture("Bar", self, "ARTWORK")
		bar.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		bar:SetSize(140, 38)
		bar:SetPoint("CENTER")
		bar:SetTexCoord(0.00390625, 0.55078125, 0.63281250, 0.92968750)

		-- Sun
		local sun = Texture("Sun", self, "BACKGROUND")
		sun.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		sun:SetSize(23, 23)
		sun:SetPoint("CENTER", bar, "RIGHT", -17, 1)
		sun:SetTexCoord(0.65625000, 0.74609375, 0.37500000, 0.55468750)

		-- Moon
		local moon = Texture("Moon", self, "BACKGROUND")
		moon.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		moon:SetSize(23, 23)
		moon:SetPoint("CENTER", bar, "LEFT", 17, 1)
		moon:SetTexCoord(0.55859375, 0.64843750, 0.57031250, 0.75000000)

		-- DarkSun
		local darkSun = Texture("DarkSun", self, "BACKGROUND", nil, 1)
		darkSun.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		darkSun.Alpha = 0
		darkSun:SetSize(23, 23)
		darkSun:SetPoint("CENTER", sun, "CENTER")
		darkSun:SetTexCoord(0.55859375, 0.64843750, 0.76562500, 0.94531250)

		-- DarkMoon
		local darkMoon = Texture("DarkMoon", self, "BACKGROUND", nil, 1)
		darkMoon.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		darkMoon.Alpha = 0
		darkMoon:SetSize(23, 23)
		darkMoon:SetPoint("CENTER", moon, "CENTER")
		darkMoon:SetTexCoord(0.55859375, 0.64843750, 0.37500000, 0.55468750)

		-- SunBar
		local sunBar = Texture("SunBar", self, "ARTWORK", nil, 1)
		sunBar.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		sunBar.Alpha = 0
		sunBar:SetSize(140, 38)
		sunBar:SetPoint("CENTER")
		sunBar:SetTexCoord(0.00390625, 0.55078125, 0.32031250, 0.61718750)

		-- MoonBar
		local moonBar = Texture("MoonBar", self, "ARTWORK", nil, 1)
		moonBar.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		moonBar.Alpha = 0
		moonBar:SetSize(140, 38)
		moonBar:SetPoint("CENTER")
		moonBar:SetTexCoord(0.00390625, 0.55078125, 0.00781250, 0.30468750)

		-- Marker
		local marker = Texture("Marker", self, "OVERLAY")
		marker.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		marker.BlendMode = "ADD"
		marker:SetSize(20, 20)
		marker:SetPoint("CENTER", 0, 2)
		marker:SetTexCoord(1.0, 0.914, 0.82, 1.0)

		-- Glow
		local glow = Texture("Glow", self, "OVERLAY")
		glow.TexturePath = [[Interface\PlayerFrame\UI-DruidEclipse]]
		glow.Alpha = 0
		glow.BlendMode = "ADD"
		glow:SetSize(43, 45)
		glow:SetPoint("CENTER")
		glow:SetTexCoord(0.55859375, 0.72656250, 0.00781250, 0.35937500)

		-- PowerText
		local powerText = FontString("PowerText", self, "OVERLAY", "TextStatusBarText")
		powerText:SetPoint("CENTER")
		powerText.Visible = false

		-- Animation for Glow
		local glowPulse = AnimationGroup("Pulse", glow)
		glowPulse.Looping = "REPEAT"

		local scale = Scale("Scale1", glowPulse)
		scale.Order = 1
		scale.Duration = 0.5
		scale.Smoothing = "IN_OUT"
		scale.Scale = Dimension(1.08, 1.08)

		scale = Scale("Scale2", glowPulse)
		scale.Order = 2
		scale.Duration = 0.5
		scale.Smoothing = "IN_OUT"
		scale.Scale = Dimension(0.9259, 0.9259)

		-- Animation for sunActivate
		local sunActivate = AnimationGroup("SunActivate", sunBar)
		sunActivate.OnPlay = SunActivate_OnPlay
		sunActivate.OnFinished = SunActivate_OnFinished

		local alpha = Alpha("Alpha", sunActivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = 1

		sunActivate = AnimationGroup("SunActivate", glow)

		alpha = Alpha("Alpha", sunActivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = 1

		sunActivate = AnimationGroup("SunActivate", darkMoon)

		alpha = Alpha("Alpha", sunActivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = 1

		-- Animation for sunDeactivate
		local sunDeactivate = AnimationGroup("SunDeactivate", sunBar)
		sunDeactivate.OnPlay = SunDeactivate_OnPlay
		sunDeactivate.OnFinished = SunDeactivate_OnFinished

		alpha = Alpha("Alpha", sunDeactivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = -1

		sunDeactivate = AnimationGroup("SunDeactivate", glow)

		alpha = Alpha("Alpha", sunDeactivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = -1

		sunDeactivate = AnimationGroup("SunDeactivate", darkMoon)

		alpha = Alpha("Alpha", sunDeactivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = -1

		-- Animation for moonActivate
		local moonActivate = AnimationGroup("MoonActivate", moonBar)
		moonActivate.OnPlay = MoonActivate_OnPlay
		moonActivate.OnFinished = MoonActivate_OnFinished

		alpha = Alpha("Alpha", moonActivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = 1

		moonActivate = AnimationGroup("MoonActivate", glow)

		alpha = Alpha("Alpha", moonActivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = 1

		moonActivate = AnimationGroup("MoonActivate", darkSun)

		alpha = Alpha("Alpha", moonActivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = 1

		-- Animation for moonDeactivate
		local moonDeactivate = AnimationGroup("MoonDeactivate", moonBar)
		moonDeactivate.OnPlay = MoonDeactivate_OnPlay
		moonDeactivate.OnFinished = MoonDeactivate_OnFinished

		alpha = Alpha("Alpha", moonDeactivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = -1

		moonDeactivate = AnimationGroup("MoonDeactivate", glow)

		alpha = Alpha("Alpha", moonDeactivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = -1

		moonDeactivate = AnimationGroup("MoonDeactivate", darkSun)

		alpha = Alpha("Alpha", moonDeactivate)
		alpha.Order = 1
		alpha.Duration = 0.6
		alpha.Change = -1

		-- Event Handler
		self.OnEnter = self.OnEnter + OnEnter
		self.OnLeave = self.OnLeave + OnLeave
	end
endclass "EclipseBar"
