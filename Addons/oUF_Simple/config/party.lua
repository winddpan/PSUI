
-- oUF_SimpleConfig: party
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Party Config
-----------------------------

L.C.party = {
  enabled = true,
  size = {180,19},
  point = {"BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 25, 360},
  scale = 1*L.C.globalscale,
  --healthbar
  healthbar = {
    --health and absorb bar cannot be disabled, they match the size of the frame
    colorDisconnected = true,
    colorClass = true,
    colorReaction = true,
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
    size = {180,5},
    point = {"TOP","BOTTOM",0,-2}, --if no relativeTo is given the frame base will be the relativeTo reference
    colorPower = true,
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
    point = {"LEFT","RIGHT",5,0},
    num = 5,
    cols = 5,
    size = 22,
    spacing = 5,
    initialAnchor = "TOPLEFT",
    growthX = "RIGHT",
    growthY = "DOWN",
    disableCooldown = false,
  },
  setup = {
    template = nil,
    visibility = 'custom [group:party,nogroup:raid][@raid6,noexists,group:raid] show;hide',
    showPlayer = false,
    showSolo = false,
    showParty = true,
    showRaid = false,
    point = "TOP",
    xOffset = 0,
    yOffset = -25,
  },
}
