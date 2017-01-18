-- Author      : Kurapica
-- Create Date : 2012/08/03
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.AuraPanel", version) then
	return
end

__Doc__[[The aura panel to display buffs or debuffs]]
class "AuraPanel"
	inherit "Frame"
	extend "IFElementPanel" "IFAura"

	_FILTER_LIST = {
		CANCELABLE = true,
		HARMFUL = true,
		HELPFUL = true,
		NOT_CANCELABLE = true,
		PLAYER = true,
		RAID = true,
		INCLUDE_NAME_PLATE_ONLY = true,
	}

	local function CheckFilter(...)
		local ret = ""

		for i = 1, select('#', ...) do
			local part = select(i, ...)

			part = part and strtrim(part)

			if _FILTER_LIST[part] then
				if #ret > 0 then
					ret = ret .. "|" .. part
				else
					ret = part
				end
			end
		end

		return ret
	end

	__Doc__[[The icon to display buff or debuff]]
	class "AuraIcon"
		inherit "Frame"
		extend "IFCooldownIndicator"


		_BorderColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		_BackDrop = {
		    edgeFile = "Interface\\Buttons\\WHITE8x8",
		    edgeSize = 1,
		}

		------------------------------------------------------
		-- Event
		------------------------------------------------------

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		__Doc__[[
			<desc>Refresh the icon</desc>
			<format>unit, index[, filter]</format>
			<param name="unit">string, the unit</param>
			<param name="index">number, the aura index</param>
			<param name="filter">string, the filiter token</param>
			]]
		function Refresh(self, unit, index, filter)
			local name, rank, texture, count, dtype, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff = UnitAura(unit, index, filter)

			if name then
				self.Index = index

				-- Texture
				self.Icon.TexturePath = texture
				if texture then self.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9) end

				-- Count
				if count and count > 1 then
					self.Count.Visible = true
					self.Count.Text = tostring(count)
				else
					self.Count.Visible = false
				end

				-- Stealable
				self.Stealable.Visible = not UnitIsUnit("player", unit) and isStealable

				-- Debuff
				if filter and not filter:find("HELPFUL") then
					self.Overlay.VertexColor = DebuffTypeColor[dtype] or DebuffTypeColor.none
					self.Overlay.Visible = true
				else
					self.Overlay.Visible = false
				end

				if self.Parent.HighLightPlayer then
					if caster == "player" then
						self:SetBackdrop(_BackDrop)
						self:SetBackdropBorderColor(_BorderColor.r, _BorderColor.g, _BorderColor.b)
					else
						self:SetBackdrop(nil)
					end
				else
					self:SetBackdrop(nil)
				end

				-- Remain
				self:OnCooldownUpdate(expires - duration, duration)

				self.Visible = true
			else
				self.Visible = false
			end
		end

		------------------------------------------------------
		-- Event Handler
		------------------------------------------------------
		local function UpdateTooltip(self)
			self = IGAS:GetWrapper(self)
			IGAS.GameTooltip:SetUnitAura(self.Parent.Unit, self.Index, self.Parent.Filter)
		end

		local function OnEnter(self)
			if self.Visible then
				IGAS.GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT')
				UpdateTooltip(self)
			end
		end

		local function OnLeave(self)
			IGAS.GameTooltip.Visible = false
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[The aura index]]
		property "Index" { Type = Number }

		__Doc__[[Whether show the tooltip of the aura]]
		__Handler__( function(self, flag)
			if flag then
				self.OnEnter = self.OnEnter + OnEnter
				self.OnLeave = self.OnLeave + OnLeave
				self.MouseEnabled = true
			else
				self.OnEnter = self.OnEnter - OnEnter
				self.OnLeave = self.OnLeave - OnLeave
				self.MouseEnabled = false
			end
		end )
		property "ShowTooltip" { Type = Boolean, Default = true }

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function AuraIcon(self, name, parent, ...)
			Super(self, name, parent, ...)

			self.MouseEnabled = true
			self.MouseWheelEnabled = false

			local icon = Texture("Icon", self, "BORDER")
			icon:SetPoint("TOPLEFT", 1, -1)
			icon:SetPoint("BOTTOMRIGHT", -1, 1)

			local count = FontString("Count", self, "OVERLAY", "NumberFontNormal")
			count:SetPoint("BOTTOMRIGHT", -1, 0)

			local overlay = Texture("Overlay", self, "OVERLAY")
			overlay:SetAllPoints(self)
			overlay.TexturePath = [[Interface\Buttons\UI-Debuff-Overlays]]
			overlay:SetTexCoord(.296875, .5703125, 0, .515625)

			local stealable = Texture("Stealable", self, "OVERLAY")
			stealable.TexturePath = [[Interface\TargetingFrame\UI-TargetingFrame-Stealable]]
			stealable.BlendMode = "ADD"
			stealable:SetPoint("TOPLEFT", -3, 3)
			stealable:SetPoint("BOTTOMRIGHT", 3, -3)

			self.OnEnter = self.OnEnter + OnEnter
			self.OnLeave = self.OnLeave + OnLeave

			IGAS:GetUI(self).UpdateTooltip = UpdateTooltip
		end
	endclass "AuraIcon"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function UpdateAuras(self)
		local index = 1
		local i = 1
		local name
		local unit = self.Unit
		local filter = self.Filter

		if unit then
			while i <= self.MaxCount do
				if UnitAura(unit, index, filter) then
					if self:CustomFilter(unit, index, filter) then
						self.Element[i]:Refresh(unit, index, filter)
						i = i + 1
					end
				else
					break
				end

				index = index + 1
			end
		end

		while i <= self.Count do
			self.Element[i].Visible = false
			i = i + 1
		end

		self:UpdatePanelSize()
	end

	__Doc__[[
		<desc>The custom filter method, overridable</desc>
		<format>unit, index[, filter]</format>
		<param name="unit">string, the unit</param>
		<param name="index">number, the aura index</param>
		<param name="filter">string, the filiter token</param>
		<return type="boolean">true if the aura should be shown</return>
	]]
	function CustomFilter(self, unit, index, filter)
		return true
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The filter token, CANCELABLE | HARMFUL | HELPFUL | NOT_CANCELABLE | PLAYER | RAID, can be combined with '|']]
	property "Filter" {
		Get = function(self)
			return self.__AuraPanelFilter
		end,
		Set = function(self, filter)
			if filter then
				filter = CheckFilter(strsplit("|", filter:upper()))

				if #filter == 0 then
					filter = nil
				end
			end

			self.__AuraPanelFilter = filter
		end,
		Type = String,
	}

	__Doc__[[Whether should highlight auras that casted by the player]]
	property "HighLightPlayer" { Type = Boolean }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function AuraPanel(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.FrameStrata = "MEDIUM"
		self.AutoSize = true
		self.ColumnCount = 7
		self.RowCount = 6
		self.ElementWidth = 16
		self.ElementHeight = 16
		self.HSpacing = 2
		self.VSpacing = 2
		self.MouseEnabled = false
		self.MouseWheelEnabled = false
		self.ElementType = AuraIcon
	end
endclass "AuraPanel"
