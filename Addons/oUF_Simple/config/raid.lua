
-- oUF_SimpleConfig: raid
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Raid Config
-----------------------------

L.C.raid = {
  enabled = true,
  size = {110,19},
  points = { --list of 8 points, one for each raid group
    {"TOPLEFT",25, -220},
    {"TOP", "oUF_SimpleRaidHeader1", "BOTTOM", 0, -10},
    {"TOP", "oUF_SimpleRaidHeader2", "BOTTOM", 0, -10},
    {"TOP", "oUF_SimpleRaidHeader3", "BOTTOM", 0, -10},
    {"LEFT", "oUF_SimpleRaidHeader1", "RIGHT", 85, 0},
    {"TOP", "oUF_SimpleRaidHeader5", "BOTTOM", 0, -10},
    {"TOP", "oUF_SimpleRaidHeader6", "BOTTOM", 0, -10},
    {"TOP", "oUF_SimpleRaidHeader7", "BOTTOM", 0, -10},
  },
  scale = 1*L.C.globalscale,
  --healthbar
  healthbar = {
    --health and absorb bar cannot be disabled, they match the size of the frame
    colorDisconnected = true,
    colorClass = true,
    colorReaction = true,
    colorHealth = true,
    colorThreat = true,
	--[[
    name = {
      enabled = true,
	  align = "CENTER",
	  points = {
        {"RIGHT",2,0},
        {"RIGHT",-2,0},
      },     
	  size = 12,
      outline = "NONE",
      noshadow = false,
      tag = "[PSUI:color][difficulty][name]|r",
    },]]
	name = {
      enabled = true,
	  point = {"LEFT","RIGHT",5,0},     
	  size = 12,
      outline = "OUTLINE",
      noshadow = false,
      tag = "[difficulty][name]|r",
    },
    debuffHighlight = true,
  },
  --raidmark
  raidmark = {
    enabled = true,
    size = {18,18},
    point = {"CENTER","CENTER",0,0},
  },
  setup = {
    template = nil,
    visibility = "custom [group:raid] show; hide",
    showPlayer = false,
    showSolo = false,
    showParty = false,
    showRaid = true,
    point = "TOP",
    xOffset = 0,
    yOffset = -8,
  },
}