-- Author      : Kurapica
-- Create Date : 2013/11/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Action.WorldMarkerHandler", version) then
	return
end

_Enabled = false

enum "WorldMarkerActionType" {
	"set",
	"clear",
	"toggle",
}

_WorldMarker = {
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_6",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_4",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_3",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_7",
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_1",
}

handler = ActionTypeHandler {
	Name = "worldmarker",

	Target = "marker",

	Detail = "action",

	DragStyle = "Block",

	ReceiveStyle = "Block",

	OnEnableChanged = function(self) _Enabled = self.Enabled end,
}

-- Overwrite methods
function handler:GetActionTexture()
	return _WorldMarker[tonumber(self.ActionTarget)]
end

function handler:IsActivedAction()
	local target = tonumber(self.ActionTarget)
	-- No event for world marker, disable it now
	return false and target and target >= 1 and target <= NUM_WORLD_RAID_MARKERS and IsRaidMarkerActive(target)
end

-- Expand IFActionHandler
interface "IFActionHandler"
	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The action button's content if its type is 'worldmarker']]
	property "WorldMarker" {
		Get = function(self)
			return self:GetAttribute("actiontype") == "worldmarker" and tonumber(self:GetAttribute("marker")) or nil
		end,
		Set = function(self, value)
			self:SetAction("worldmarker", value, self.WorldMarkerActionType)
		end,
		Type = NumberNil,
	}

	__Doc__[[The world marker action type]]
	property "WorldMarkerActionType" {
		Get = function (self)
			return self:GetAttribute("actiontype") == "worldmarker" and self:GetAttribute("action")
		end,
		Set = function (self, type)
			self:SetAction("worldmarker", self.WorldMarker, type)
		end,
		Type = WorldMarkerActionType,
		Default = "toggle",
	}
endinterface "IFActionHandler"
