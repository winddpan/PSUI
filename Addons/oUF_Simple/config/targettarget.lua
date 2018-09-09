
-- oUF_SimpleConfig: targettarget
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- TargetTarget Config
-----------------------------

L.C.targettarget = {
  enabled = true,
  size = {50,21},
  point = {"TOPRIGHT","oUF_SimpleTarget","BOTTOMRIGHT",0,-20},
  scale = 1*L.C.globalscale,
  --healthbar
  healthbar = {
    --health and absorb bar cannot be disabled, they match the size of the frame
    colorTapping = true,
    colorDisconnected = true,
    colorReaction = true,
    colorClass = true,
    colorHealth = true,
    name = {
      enabled = true,
      point = {"RIGHT",-3,1},
      size = 11,
      outline = "NONE",
      noshadow = false,
      --align = "CENTER",
      tag = "[PSUI:color][PSUI:shortname]",
    },
    debuffHighlight = false,
  },
  --raidmark
  raidmark = {
    enabled = true,
    size = {18,18},
    point = {"CENTER","TOP",0,0},
  },
  --debuffs
  debuffs = {
    enabled = true,
    point = {"LEFT","RIGHT", 5,0},
    num = 5,
    cols = 5,
    size = 20,
    spacing = 4,
    initialAnchor = "TOPLEFT",
    growthX = "RIGHT",
    growthY = "DOWN",
    disableCooldown = true,
  },
}