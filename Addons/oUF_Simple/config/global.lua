
-- oUF_SimpleConfig: global
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Global Config
-----------------------------

--mediapath
L.C.mediapath = "interface\\addons\\"..A.."\\config\\media\\"

L.C.globalscale = 1

--print("ouf_SimepleConfig:","UI scale",UIParent:GetScale(),"L.C.globalscale",L.C.globalscale)

--backdrop
L.C.backdrop = {
  bgFile = L.C.mediapath.."backdrop",
  bgColor = {0,0,0,0.67},
  edgeFile = L.C.mediapath.."backdrop_edge",
  edgeColor = {0,0,0,1},
  tile = false,
  tileSize = 0,
  inset = 3,
  edgeSize = 3,
  insets = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  },
}

--fonts
L.C.fonts = {
  pixel = L.C.mediapath.."pixfont.ttf",
  number = L.C.mediapath.."numberfont.ttf",
}

--textures
L.C.textures = {
  statusbar = L.C.mediapath.."statusbar",
  statusbarBG = L.C.mediapath.."statusbar",
  absorb = L.C.mediapath.."statusbar",
  aura = L.C.mediapath.."square",
  split = L.C.mediapath.."split",
}

--colors
L.C.colors = {}
--colors bgMultiplier
L.C.colors.bgMultiplier = 0.3
--colors castbar
L.C.colors.castbar = {
  default = {0.3,0.45,0.65},
  defaultBG = {0, 0, 0, 0},
  shielded = {1,.49,0},
  shieldedBG = {0.7*L.C.colors.bgMultiplier,0.7*L.C.colors.bgMultiplier,0.7*L.C.colors.bgMultiplier},
}
--colors healthbar
L.C.colors.healthbar = {
  --default = {0,1,0},
  --defaultBG = {0*L.C.colors.bgMultiplier,1*L.C.colors.bgMultiplier,0},
  threat = {1,0,0},
  threatBG = {1*L.C.colors.bgMultiplier,0,0},
  threatInvers = {0,1,0},
  threatInversBG = {0,1*L.C.colors.bgMultiplier,0},
  absorb = {0.1,1,1,0.7}
}
--fix way to dark mana color
L.C.colors.power = {
  mana = {0.1, 0.2, 1}
}


L.C.mods = {
  castbar = {
    enabled = true,
    size = {190,20},
    point = {"BOTTOM","TOP",0,2},
    --orientation = "VERTICAL",
    name = {
      enabled = true,
      points = {
        {"LEFT",3,0},
        {"RIGHT",-3,0},
      },
      --font = STANDARD_TEXT_FONT,
      size = 12,
      outline = "NONE",
      --align = "CENTER",
      --noshadow = true,
    },
    icon = {
      enabled = true,
      size = {19,19},
      point = {"RIGHT","LEFT",-3,0},
    },
  },
  healthbar = {
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
  },
}
