-- Author      : Kurapica
-- Create Date : 2012/07/22
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.WarlockPowerBar", version) then
	return
end

__Doc__[[The power bar for warlock]]
class "WarlockPowerBar"
	inherit "Frame"
	extend "IFClassPower"

	GameTooltip = _G.GameTooltip

	SOUL_SHARDS_POWER = _G.SOUL_SHARDS_POWER
	SOUL_SHARDS_TOOLTIP = _G.SOUL_SHARDS_TOOLTIP

	DEMONIC_FURY = _G.DEMONIC_FURY
	DEMONIC_FURY_TOOLTIP = _G.DEMONIC_FURY_TOOLTIP

	BURNING_EMBERS = _G.BURNING_EMBERS
	BURNING_EMBERS_TOOLTIP = _G.BURNING_EMBERS_TOOLTIP

	SPELL_POWER_SOUL_SHARDS = _G.SPELL_POWER_SOUL_SHARDS
	SPELL_POWER_DEMONIC_FURY = _G.SPELL_POWER_DEMONIC_FURY
	SPELL_POWER_BURNING_EMBERS = _G.SPELL_POWER_BURNING_EMBERS

	MAX_POWER_PER_EMBER = _G.MAX_POWER_PER_EMBER

	WARLOCK_METAMORPHOSIS = _G.WARLOCK_METAMORPHOSIS

	WARLOCK_POWER_FILLBAR = {
		Demonology 			= { left = 0.03906250, right = 0.55468750, top = 0.10546875, bottom = 0.19921875, width = 132, fileWidth = 256 },
		DemonologyActivated	= { left = 0.03906250, right = 0.55468750, top = 0.00390625, bottom = 0.09765625, width = 132, fileWidth = 256 },
		Destruction			= { left = 0.30078125, right = 0.37890625, top = 0.32812500, bottom = 0.67187500, height = 22, fileHeight = 64 },
	}

	__Doc__[[The shard element]]
	class "Shard"
		inherit "Frame"

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Handler__( function (self, value)
			if value then
				self.Fill.AnimOut.Playing = false
				self.SmokeA.AnimOut.Playing = false
				self.SmokeB.AnimOut.Playing = false

				self.Fill.AnimIn.Playing = true
				self.Glow.AnimIn.Playing = true
			else
				self.Fill.AnimIn.Playing = false
				self.Glow.AnimIn.Playing = false

				self.Fill.AnimOut.Playing = true
				self.SmokeA.AnimOut.Playing = true
				self.SmokeB.AnimOut.Playing = true
			end
		end )
		property "Activated" { Type = Boolean }

		------------------------------------------------------
		-- Event Handler
		------------------------------------------------------
		local function AnimIn_OnPlay(self)
			local parent = self.Parent.Parent

			parent.Fill.Alpha = 0
			parent.Fill.Visible = true
			parent.Glow.Alpha = 0
		end

		local function AnimIn_OnFinished(self)
			local parent = self.Parent.Parent

			parent.Fill.Alpha = 1
			parent.Glow.Alpha = 0
		end

		local function AnimOut_OnFinished(self)
			self.Parent.Visible = false
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function Shard(self, ...)
	    	Super(self, ...)

			self:SetSize(52, 29)

			local glow = Texture("Glow", self, "OVERLAY")
			glow.BlendMode = "ADD"
			glow.Alpha = 0
			glow.TexturePath = [[Interface\PlayerFrame\UI-WarlockShard]]
			glow:SetSize(26, 23)
			glow:SetPoint("TOPLEFT", -2, 1)
			glow:SetTexCoord(0.01562500, 0.42187500, 0.14843750, 0.32812500)

			local smokeA = Texture("SmokeA", self, "OVERLAY")
			smokeA.TexturePath = [[Interface\PlayerFrame\UI-WarlockShard]]
			smokeA:SetSize(32, 32)
			smokeA:SetPoint("TOPLEFT", -8, 5)
			smokeA:SetTexCoord(0.01562500, 0.51562500, 0.34375000, 0.59375000)
			smokeA.Alpha = 0

			local smokeB = Texture("SmokeB", self, "OVERLAY")
			smokeB.TexturePath = [[Interface\PlayerFrame\UI-WarlockShard]]
			smokeB:SetSize(32, 32)
			smokeB:SetPoint("TOPLEFT", smokeA, "TOPLEFT")
			smokeB:SetTexCoord(0.01562500, 0.51562500, 0.34375000, 0.59375000)
			smokeB.Alpha = 0

			local fill = Texture("Fill", self, "ARTWORK")
			fill.TexturePath = [[Interface\PlayerFrame\UI-WarlockShard]]
			fill:SetSize(17, 16)
			fill:SetPoint("TOPLEFT", 3, -2)
			fill:SetTexCoord(0.01562500, 0.28125000, 0.00781250, 0.13281250)
			fill.Visible = false

			local border = Texture("Border", self, "BORDER")
			border.TexturePath = [[Interface\PlayerFrame\UI-WarlockShard]]
			border:SetSize(52, 29)
			border:SetPoint("TOPLEFT", -5, 3)
			border:SetTexCoord(0.01562500, 0.82812500, 0.60937500, 0.83593750)

			-- AnimIn
			local animIn = AnimationGroup("AnimIn", fill)

			local alpha = Alpha("Alpha", animIn)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 1

			animIn = AnimationGroup("AnimIn", glow)

			alpha = Alpha("Alpha1", animIn)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", animIn)
			alpha.Duration = 0.1
			alpha.Order = 2
			alpha.Change = -1

			animIn.OnPlay = AnimIn_OnPlay
			animIn.OnFinished = AnimIn_OnFinished

			-- AnimOut
			local animOut = AnimationGroup("AnimOut", fill)

			animOut.OnFinished = AnimOut_OnFinished

			alpha = Alpha("Alpha", animOut)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = -1

			animOut = AnimationGroup("AnimOut", smokeA)

			alpha = Alpha("Alpha1", animOut)
			alpha.Duration = 0.1
			alpha.Order = 1
			alpha.Change = 1

			local rotation = Rotation("Rotation", animOut)
			rotation.Duration = 0.3
			rotation.Order = 1
			rotation.Radians = 1.1

			local scale = Scale("Scale1", animOut)
			scale.Duration = 0.3
			scale.Order = 1
			scale.Scale = Dimension(1.2, 1.2)

			alpha = Alpha("Alpha2", animOut)
			alpha.Duration = 0.25
			alpha.Order = 2
			alpha.Change = -1

			scale = Scale("Scale2", animOut)
			scale.Duration = 0.25
			scale.Order = 2
			scale.Scale = Dimension(0.4, 0.4)

			animOut = AnimationGroup("AnimOut", smokeB)

			alpha = Alpha("Alpha1", animOut)
			alpha.Duration = 0.1
			alpha.Order = 1
			alpha.Change = 1

			rotation = Rotation("Rotation", animOut)
			rotation.Duration = 0.4
			rotation.Order = 1
			rotation.Radians = -0.9

			scale = Scale("Scale1", animOut)
			scale.Duration = 0.4
			scale.Order = 1
			scale.Scale = Dimension(2.5, 2.5)

			alpha = Alpha("Alpha2", animOut)
			alpha.Duration = 0.25
			alpha.Order = 2
			alpha.Change = -1

			scale = Scale("Scale2", animOut)
			scale.Duration = 0.25
			scale.Order = 2
			scale.Scale = Dimension(0.4, 0.4)
	    end
	endclass "Shard"

	__Doc__[[the burning ember element]]
	class "BurningEmber"
		inherit "Frame"

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Handler__( function (self, value)
			if value then
				self.FireIcon.Visible = true

				self.Glow.AnimOut.Playing = false
				self.Glow2.AnimOut.Playing = false

				self.Glow.AnimIn.Playing = true
				self.Glow2.AnimIn.Playing = true
			else
				self.FireIcon.Visible = false

				self.Glow.AnimIn.Playing = false
				self.Glow2.AnimIn.Playing = false

				self.Glow.AnimOut.Playing = true
				self.Glow2.AnimOut.Playing = true
			end
		end )
		property "Activated" { Type = Boolean }

		------------------------------------------------------
		-- Event Hanlder
		------------------------------------------------------
		local function AnimIn_OnFinished(self)
			self.Parent.Parent.Glow.Alpha = 0
			self.Parent.Parent.Glow2.Alpha = 0
		end

		local function AnimOut_OnFinished(self)
			self.Parent.Parent.Glow.Alpha = 0
			self.Parent.Parent.Glow2.Alpha = 0
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function BurningEmber(self, ...)
	    	Super(self, ...)

			self:SetSize(36, 39)

			local border = Texture("Border", self, "BORDER")
			border:SetAllPoints()
			border.TexturePath = [[Interface\PlayerFrame\Warlock-DestructionUI]]
			border:SetTexCoord(0.15234375, 0.29296875, 0.32812500, 0.93750000)

			local fill = Texture("Fill", self, "ARTWORK")
			fill:SetSize(20, 22)
			fill:SetPoint("BOTTOM", 0, 7)
			fill.TexturePath = [[Interface\PlayerFrame\Warlock-DestructionUI]]
			fill:SetTexCoord(0.30078125, 0.37890625, 0.32812500, 0.67187500)

			local fireIcon = Texture("FireIcon", self, "ARTWORK", nil, 1)
			fireIcon.TexturePath = [[Interface\PlayerFrame\Warlock-DestructionUI]]
			fireIcon:SetAllPoints()
			fireIcon.Visible = false
			fireIcon:SetTexCoord(0.00390625, 0.14453125, 0.32812500, 0.93750000)

			local glow = Texture("Glow", self, "OVERLAY")
			glow.TexturePath = [[Interface\PlayerFrame\Warlock-DestructionUI]]
			glow:SetAllPoints()
			glow.BlendMode = "ADD"
			glow.Alpha = 0
			glow:SetTexCoord(0.00390625, 0.14453125, 0.32812500, 0.93750000)

			local glow2 = Texture("Glow2", self, "OVERLAY")
			glow2.TexturePath = [[Interface\PlayerFrame\Warlock-DestructionUI]]
			glow2:SetAllPoints()
			glow2.BlendMode = "ADD"
			glow2.Alpha = 0
			glow2:SetTexCoord(0.00390625, 0.14453125, 0.32812500, 0.93750000)

			-- AnimIn
			local animIn = AnimationGroup("AnimIn", glow)

			local alpha = Alpha("Alpha1", animIn)
			alpha.Duration = 0.1
			alpha.Order = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", animIn)
			alpha.Duration = 0.15
			alpha.Order = 2
			alpha.Change = -1

			animIn = AnimationGroup("AnimIn", glow2)

			alpha = Alpha("Alpha1", animIn)
			alpha.Duration = 0.1
			alpha.Order = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", animIn)
			alpha.Duration = 0.15
			alpha.Order = 2
			alpha.Change = -1

			animIn.OnFinished = AnimIn_OnFinished

			-- AnimOut
			local animOut = AnimationGroup("AnimOut", glow)

			alpha = Alpha("Alpha1", animOut)
			alpha.Duration = 0.1
			alpha.Order = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", animOut)
			alpha.Duration = 0.15
			alpha.Order = 2
			alpha.Change = -1

			animOut = AnimationGroup("AnimOut", glow2)

			alpha = Alpha("Alpha1", animOut)
			alpha.Duration = 0.1
			alpha.Order = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", animOut)
			alpha.Duration = 0.15
			alpha.Order = 2
			alpha.Change = -1

			animOut.OnFinished = AnimOut_OnFinished
	    end
	endclass "BurningEmber"

	------------------------------------------------------
	-- Help Function
	------------------------------------------------------
	local function WarlockPowerBar_UpdateFill(texture, texData, value, maxValue)
		if ( value <= 0 ) then
			texture:Hide()
		elseif ( value >= maxValue ) then
			texture:SetTexCoord(texData["left"], texData["right"], texData["top"], texData["bottom"])
			if ( texData.width ) then
				texture:SetWidth(texData["width"])
			else
				texture:SetHeight(texData["height"])
			end
			texture:Show()
		else
			if ( texData.width ) then
				local texWidth = (value / maxValue) * texData["width"]
				local right = texData["left"] + texWidth / texData["fileWidth"]
				texture:SetTexCoord(texData["left"], right, texData["top"], texData["bottom"])
				texture:SetWidth(texWidth)
			else
				local texHeight = (value / maxValue) * texData["height"]
				local top = texData["bottom"] - texHeight / texData["fileHeight"]
				texture:SetTexCoord(texData["left"], texData["right"], top, texData["bottom"])
				texture:SetHeight(texHeight)
			end
			texture:Show()
		end
	end

	local function UNIT_AURA(self, event, unit)
		if unit and unit ~= "player" then return end

		local activated = false
		local index = 1
		local name, _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player", index)
		while spellId do
			if ( spellId == WARLOCK_METAMORPHOSIS ) then
				activated = true
				break
			end
			name, _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player", index)
			index = index + 1
		end
		local frame = self.DemonicFuryBarFrame
		if ( activated and not frame.Activated ) then
			frame.Activated = true
			frame.Bar:SetTexCoord(0.03906250, 0.69921875, 0.30859375, 0.51171875)
			frame.Notch:SetTexCoord(0.00390625, 0.03125000, 0.00390625, 0.08984375)

			local value = self.__Value
			self.__Value = nil
			self.Value = value
		elseif ( not activated and frame.Activated ) then
			frame.Activated = nil
			frame.Bar:SetTexCoord(0.03906250, 0.69921875, 0.51953125, 0.72265625)
			frame.Notch:SetTexCoord(0.00390625, 0.03125000, 0.09765625, 0.18359375)

			local value = self.__Value
			self.__Value = nil
			self.Value = value
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Handler__( function (self, value)
		if self.ActiveFrame then
			self.ActiveFrame.Visible = false
			self.ActiveFrame = nil
		end

		self:UnregisterEvent("UNIT_AURA")

		if value == SPELL_POWER_SOUL_SHARDS then
			self.ActiveFrame = self.ShardBarFrame
		elseif value == SPELL_POWER_DEMONIC_FURY then
			self.ActiveFrame = self.DemonicFuryBarFrame
			self:RegisterUnitEvent("UNIT_AURA", "player", "vehicle")
		elseif value == SPELL_POWER_BURNING_EMBERS then
			self.ActiveFrame = self.BurningEmbersBarFrame
		end

		if self.ActiveFrame then
			self.ActiveFrame.Visible = true
			self.ShowAnim.Playing = true
		end
	end )
	property "ClassPowerType" { Type = NumberNil }

	-- MinMaxValue
	property "MinMaxValue" {
		Get = function(self)
			return MinMax(self.__Min, self.__Max)
		end,
		Set = function(self, value)
			if self.__Max ~= value.max then
				self.__Min, self.__Max = value.min, value.max

				local frame = self.ActiveFrame
				if frame == self.ShardBarFrame then
					if ( value.max == 3 ) then
						frame[1]:SetPoint("TOPLEFT", 0, 0)
						frame[2]:SetPoint("TOPLEFT", frame[1], "TOPLEFT", 35, 0)
						frame[3]:SetPoint("TOPLEFT", frame[2], "TOPLEFT", 35, 0)
						frame[4]:Hide()
					else
						frame[1]:SetPoint("TOPLEFT", -10, 0)
						frame[2]:SetPoint("TOPLEFT", frame[1], "TOPLEFT", 30, 0)
						frame[3]:SetPoint("TOPLEFT", frame[2], "TOPLEFT", 30, 0)
						frame[4]:Show()
					end
					frame.MaxShards = value.max
				elseif frame == self.BurningEmbersBarFrame then
					local numEmbers = floor(value.max / MAX_POWER_PER_EMBER)
					if ( numEmbers == 3 ) then
						frame[1]:SetPoint("TOPLEFT", 17, 7)
						frame[2]:SetPoint("LEFT", frame[1], 40, 0)
						frame[3]:SetPoint("LEFT", frame[2], 40, 0)
						frame[4].FireIcon:Hide()
						frame[4].Activated= false
						frame[4]:Hide()
					else
						frame[1]:SetPoint("TOPLEFT", 16, 7)
						frame[2]:SetPoint("LEFT", frame[1], 26, 0)
						frame[3]:SetPoint("LEFT", frame[2], 26, 0)
						frame[4]:Show()
					end
					frame.MaxEmbers = numEmbers
				end
				local value = self.__Value
				self.__Value = nil
				self.Value = value
			end
		end,
		Type = MinMax,
	}
	-- Value
	property "Value" {
		Field = "__Value",
		Set = function(self, value)
			local frame = self.ActiveFrame

			if self.__Value ~= value then
				if frame == self.ShardBarFrame then
					for i = 1, frame.MaxShards or 0 do
						frame[i].Activated = i <= value
					end
				elseif frame == self.DemonicFuryBarFrame then
					local texData
					if ( frame.Activated ) then
						texData = WARLOCK_POWER_FILLBAR["DemonologyActivated"]
					else
						texData = WARLOCK_POWER_FILLBAR["Demonology"]
					end
					WarlockPowerBar_UpdateFill(frame.Fill, texData, value, self.__Max)
					if ( self.ShowPercent and self.__Max > 0 ) then
						frame.PowerText:SetText(floor(abs(value/self.__Max*100)).."%")
					else
						frame.PowerText:SetText(floor(abs(value)))
					end
				elseif frame == self.BurningEmbersBarFrame then
					for i = 1, frame.MaxEmbers or 0 do
						local ember = frame[i]
						WarlockPowerBar_UpdateFill(ember.Fill, WARLOCK_POWER_FILLBAR["Destruction"], value, MAX_POWER_PER_EMBER)

						if ( value >= MAX_POWER_PER_EMBER ) then
							ember.Activated = true
						else
							ember.Activated = false
						end

						value = value - MAX_POWER_PER_EMBER
					end
				end
			end

			self.__Value = value
		end,
		Type = Number,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function ShowAnim_OnFinished(self)
		self.Parent.Alpha = 1
	end

	local function ShardBarFrame_OnEnter(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, IGAS:GetUI(self))
		GameTooltip:SetText(SOUL_SHARDS_POWER, 1, 1, 1)
		GameTooltip:AddLine(SOUL_SHARDS_TOOLTIP, nil, nil, nil, true)
		GameTooltip:Show()
	end

	local function ShardBarFrame_OnLeave(self)
		GameTooltip:Hide()
	end

	local function DemonicFuryBarFrame_OnEnter(self)
		self.PowerText:Show()
		GameTooltip_SetDefaultAnchor(GameTooltip, IGAS:GetUI(self))
		GameTooltip:SetText(DEMONIC_FURY, 1, 1, 1)
		GameTooltip:AddLine(DEMONIC_FURY_TOOLTIP, nil, nil, nil, true)
		GameTooltip:Show()
	end

	local function DemonicFuryBarFrame_OnLeave(self)
		if not self.LockShow then
			self.PowerText:Hide()
		end
		GameTooltip:Hide()
	end

	local function BurningEmbersBarFrame_OnEnter(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, IGAS:GetUI(self))
		GameTooltip:SetText(BURNING_EMBERS, 1, 1, 1)
		GameTooltip:AddLine(BURNING_EMBERS_TOOLTIP, nil, nil, nil, true)
		GameTooltip:Show()
	end

	local function BurningEmbersBarFrame_OnLeave(self)
		GameTooltip:Hide()
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function WarlockPowerBar(self, name, parent, ...)
    	Super(self, name, parent, ...)

		self.__Value = 0
		self.__Min, self.__Max = 0, 0

		self.FrameStrata = "LOW"
		self.Toplevel = true
		self:SetSize(110, 25)

		self.OnEvent = UNIT_AURA

		local showAnim = AnimationGroup("ShowAnim", self)
		showAnim.OnFinished = ShowAnim_OnFinished

		local alpha = Alpha("Alpha", showAnim)
		alpha.Duration = 0.5
		alpha.Order = 1
		alpha.Change = 1

		-- ShardBarFrame
		local shardBar = Frame("ShardBarFrame", self)
		shardBar.Visible = false
		shardBar.MouseEnabled = true
		shardBar:SetSize(110, 25)
		shardBar:SetPoint("TOPLEFT")
		shardBar:SetHitRectInsets(10, 9, 0, 3)
		shardBar.OnEnter = ShardBarFrame_OnEnter
		shardBar.OnLeave = ShardBarFrame_OnLeave

		for i = 1, 4 do
			shardBar[i] = Shard("Shard"..i, shardBar)

			if i == 1 then
				shardBar[i]:SetPoint("TOPLEFT")
			elseif i == 4 then
				shardBar[i].Visible = false
				shardBar[i]:SetPoint("TOPLEFT", shardBar[i-1], "TOPLEFT", 30, 0)
			else
				shardBar[i]:SetPoint("TOPLEFT", shardBar[i-1], "TOPLEFT", 35, 0)
			end
		end

		-- DemonicFuryBarFrame
		local demonicBar = Frame("DemonicFuryBarFrame", self)
		demonicBar.Visible = false
		demonicBar.MouseEnabled = true
		demonicBar:SetSize(169, 52)
		demonicBar:SetPoint("TOPLEFT", -28, 15)
		demonicBar:SetHitRectInsets(14, 17, 12, 12)
		demonicBar.OnEnter = DemonicFuryBarFrame_OnEnter
		demonicBar.OnLeave = DemonicFuryBarFrame_OnLeave

		local bg = Texture("Bg", demonicBar, "BACKGROUND")
		bg.TexturePath = [[Interface\PlayerFrame\Warlock-DemonologyUI]]
		bg:SetSize(132, 24)
		bg:SetPoint("CENTER", -2, -1)
		bg:SetTexCoord(0.03906250, 0.55468750, 0.20703125, 0.30078125)

		local fill = Texture("Fill", demonicBar, "BORDER")
		fill.TexturePath = [[Interface\PlayerFrame\Warlock-DemonologyUI]]
		fill:SetSize(132, 24)
		fill:SetPoint("LEFT", 17, -1)
		fill:SetTexCoord(0.03906250, 0.55468750, 0.10546875, 0.19921875)

		local bar = Texture("Bar", demonicBar, "ARTWORK")
		bar.TexturePath = [[Interface\PlayerFrame\Warlock-DemonologyUI]]
		bar:SetAllPoints()
		bar:SetTexCoord(0.03906250, 0.69921875, 0.51953125, 0.72265625)

		local notch = Texture("Notch", demonicBar, "OVERLAY")
		notch.TexturePath = [[Interface\PlayerFrame\Warlock-DemonologyUI]]
		notch:SetSize(7, 22)
		notch:SetPoint("LEFT", 40, -1)
		notch:SetTexCoord(0.00390625, 0.03125000, 0.09765625, 0.18359375)

		local powerText = FontString("PowerText", demonicBar, "OVERLAY", "TextStatusBarText")
		powerText.Visible = false
		powerText:SetPoint("CENTER", 0, -2)

		-- BurningEmbersBarFrame
		local burningBar = Frame("BurningEmbersBarFrame", self)
		burningBar.Visible = false
		burningBar.MouseEnabled = true
		burningBar:SetSize(148, 18)
		burningBar:SetPoint("TOPLEFT", -21, 1)
		burningBar:SetHitRectInsets(22, 25, 3, -9)
		burningBar.OnEnter = BurningEmbersBarFrame_OnEnter
		burningBar.OnLeave = BurningEmbersBarFrame_OnLeave

		local bg = Texture("Bg", burningBar, "BACKGROUND")
		bg.TexturePath = [[Interface\PlayerFrame\Warlock-DestructionUI]]
		bg:SetAllPoints()
		bg:SetTexCoord(0.00390625, 0.58203125, 0.01562500, 0.29687500)

		for i = 1, 4 do
			burningBar[i] = BurningEmber("Ember"..i, burningBar)

			if i == 1 then
				burningBar[i]:SetPoint("TOPLEFT", 17, 7)
			elseif i == 4 then
				burningBar[i].Visible = false
				burningBar[i]:SetPoint("LEFT", burningBar[i-1], "LEFT", 26, 0)
			else
				burningBar[i]:SetPoint("LEFT", burningBar[i-1], "LEFT", 40, 0)
			end
		end
	end
endclass "WarlockPowerBar"
