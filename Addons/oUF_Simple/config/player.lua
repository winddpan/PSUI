
-- oUF_SimpleConfig: player
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Player Config
-----------------------------

oUF.colors.power['RUNES'] = {108 / 255, 205 / 255, 205 / 255}
	
local fWidht = 190
local _, playerClass = UnitClass'player'

local classBarEnable = true
local castbarOffsetY = 0
if playerClass == 'ROGUE' then
	classBarEnable = false
end
if playerClass == 'DEATHKNIGHT' then
	castbarOffsetY = 10
end

local castbarCfg = rLib.CopyTable(L.C.mods.castbar)
castbarCfg.point = {"BOTTOM","TOP",0,2+castbarOffsetY}

L.C.player = {
  enabled = true,
  size = {fWidht,19},
  point = {"CENTER",UIParent,"BOTTOM",0,250},
  scale = 1*L.C.globalscale,
  frameVisibility = "show", --"[combat][mod][@target,exists][@vehicle,exists][overridebar][shapeshift][vehicleui][possessbar] show; hide",
  --healthbar
  healthbar = {
    --orientation = "VERTICAL",
    --health and absorb bar cannot be disabled, they match the size of the frame
    colorClass = true,
    colorHealth = true,
    colorThreat = false,
    name = {
      enabled = false,
      points = {
        {"TOPLEFT",2,-1},
        {"TOPRIGHT",0,-1},
      },
      size = 12,
      --tag = "[oUF_SimpleConfig:status]",
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
    power = {
      enabled = false,
      point = {"RIGHT",-2,0},
      size = 16,
      tag = "[perpp]",
    },
  },
  --raidmark
  raidmark = {
    enabled = true,
    size = {18,18},
    point = {"CENTER","TOP",0,0},
  },
  --castbar
  castbar = castbarCfg,
  --classbar
  classbar = {
    enabled = classBarEnable,
    size = {fWidht,5},
    point = {"BOTTOMRIGHT","TOPRIGHT",0,4},
    splits = {
      enabled = true,
      texture = L.C.textures.split,
      size = {4,5},
      color = {0,0,0,1}
    },
  },
  --altpowerbar
  altpowerbar = {
    enabled = true,
    size = {130,5},
    point = {"BOTTOMLEFT","TOPLEFT",0,4},
  },
  --addpowerbar (additional powerbar, like mana if a druid has rage display atm)
  addpowerbar = {
    enabled = true,
    size = {26,35},
    point = {"TOPRIGHT","TOPLEFT",-4,0},
    orientation = "VERTICAL",
    colorPower = true,
  },
}
