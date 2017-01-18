-- Author      : Kurapica
-- Create Date : 2012/07/18
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.RangeChecker", version) then
	return
end

__Doc__[[The in-range indicator]]
class "RangeChecker"
	inherit "Frame"
	extend "IFRange"

	pi = math.pi
	atan = math.atan

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetInRange(self, inRange)
		if inRange then
			self.Parent.Alpha = 1

			self.Visible = false
		else
			self.Parent.Alpha = 0.5

			if self.UseIndicator and (UnitInParty(self.Unit) or UnitInRaid(self.Unit)) then
				self.Visible = true
			else
				self.Visible = false
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether use an indicator]]
	property "UseIndicator" { Type = Boolean }

	__Doc__[[The texture file path for the indicator]]
	property "TexturePath" {
		Get = function(self)
			return self:GetChild("Indicator").TexturePath
		end,
		Set = function(self, value)
			self:GetChild("Indicator").TexturePath = value
		end,
		Type = String,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUpdate(self, elapsed)
		local unit = self.Unit

		if UnitIsVisible(unit) then
			local tarx, tary = GetPlayerMapPosition(unit)
			local x, y = GetPlayerMapPosition("player")
			local facing = 2 * pi - (GetPlayerFacing() or 0)
			local rad = 0

			if tarx and tary and x and y then
				self.Alpha = 1

				if tarx == x and tary == y then
					rad = facing
				elseif tarx >= x then
					if tary < y then
						rad = atan((tarx - x)/(y - tary))
					elseif tary == y then
						rad = pi / 2
					else
						rad = pi - atan((tarx - x)/(tary - y))
					end
				elseif tarx < x then
					if tary > y then
						rad = pi + atan((x - tarx)/(tary - y))
					elseif tary == y then
						rad = pi + pi / 2
					else
						rad = 2 * pi - atan((x - tarx)/(y - tary))
					end
				end

				return self:GetChild("Indicator"):RotateRadian(rad - facing)
			end
		else
			self.Alpha = 0
		end
	end

	local function OnSizeChanged(self)
		local width, height = self:GetSize()
		local min = math.min(width, height)
		self:GetChild("Indicator"):SetSize(min, min)
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function RangeChecker(self, name, parent, ...)
		Super(self, name, parent, ...)

		self:SetSize(32, 32)
		self.Visible = false

		local icon = Texture("Indicator", self)
		icon:SetPoint("CENTER")
		icon:SetSize(32, 32)
		self.TexturePath = [[Interface\Minimap\MiniMap-QuestArrow]]

		self.OnUpdate = self.OnUpdate + OnUpdate
		self.OnSizeChanged = self.OnSizeChanged + OnSizeChanged
	end
endclass "RangeChecker"
