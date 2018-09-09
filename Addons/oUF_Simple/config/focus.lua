
-- oUF_SimpleConfig: focus
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Focus Config
-----------------------------
local fWidht = 190

L.C.focus = {
  enabled = true,
  size = {fWidht,19},
  point = {"TOPRIGHT","oUF_SimpleTarget","BOTTOMRIGHT",0,320},
  scale = 1*L.C.globalscale,
  --healthbar
  healthbar = {
    --health and absorb bar cannot be disabled, they match the size of the frame
    colorTapping = true,
    colorDisconnected = true,
    colorReaction = true,
    colorClass = true,
    colorHealth = true,
    colorThreat = true,
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
    debuffHighlight = true,
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
  --debuffs
  debuffs = {
    enabled = false,
    point = {"TOPLEFT","BOTTOMLEFT",0,-5},
    num = 5,
    cols = 5,
    size = 22,
    spacing = 5,
    initialAnchor = "TOPLEFT",
    growthX = "RIGHT",
    growthY = "DOWN",
    disableCooldown = true,
  },
}
