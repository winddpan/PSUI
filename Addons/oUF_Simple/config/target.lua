
-- oUF_SimpleConfig: target
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Target Config
-----------------------------
local fWidht = 190

L.C.target = {
  enabled = true,
  size = {fWidht,19},
  point = {"LEFT",UIParent,"CENTER",190,-190},
  scale = 1*L.C.globalscale,
  --healthbar
  healthbar = {
    --health and absorb bar cannot be disabled, they match the size of the frame
    colorTapping = true,
    colorDisconnected = true,
    colorClass = true,
    colorReaction = true,
    colorHealth = true,
    colorThreat = false,
    colorThreatInvers = true,
    name = {
      enabled = true,
      point = {"RIGHT",-3,0},
      size = 12,
      outline = "NONE",
      noshadow = false,
      tag = "[PSUI:color][difficulty][name]|r",
    },
    health = {
      enabled = true,
      point = {"LEFT",4,0},
      size = 8,
      font = L.C.fonts.pixel,
      outline = "OUTLINE",
      noshadow = true,
      tag = "[oUF_Simple:health]",
    },
    debuffHighlight = false,
  },
  --powerbar
  powerbar = {
    enabled = true,
    size = {fWidht,5},
    point = {"TOP","BOTTOM",0,-2}, --if no relativeTo is given the frame base will be the relativeTo reference
    colorPower = true,
  },
  --raidmark
  raidmark = {
    enabled = true,
    size = {18,18},
    point = {"CENTER","TOP",0,0},
  },
  --castbar
  castbar = L.C.mods.castbar,
  buffs = {
    enabled = true,
    point = {"BOTTOMLEFT","RIGHT",10,5},
    num = 32,
    cols = 8,
    size = 22,
    spacing = 5,
    initialAnchor = "BOTTOMLEFT",
    growthX = "RIGHT",
    growthY = "UP",
    disableCooldown = false,
  },
  debuffs = {
    enabled = true,
    point = {"TOPLEFT","RIGHT",10,-5},
    num = 40,
    cols = 8,
    size = 22,
    spacing = 5,
    initialAnchor = "TOPLEFT",
    growthX = "RIGHT",
    growthY = "DOWN",
    disableCooldown = true,
  },
}
