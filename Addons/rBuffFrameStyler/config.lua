
  -- // rBuffFrameStyler
  -- // zork - 2012

  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...
  local cfg = CreateFrame("Frame")
  ns.cfg = cfg

  -----------------------------
  -- CONFIG
  -----------------------------

  local font = "Interface\\AddOns\\rBuffFrameStyler\\media\\font.ttf"
  --adjust the oneletter abbrev?
  cfg.adjustOneletterAbbrev = true
  
  --scale of the consolidated tooltip
  cfg.consolidatedTooltipScale = 1
  
  --combine buff and debuff frame - should buffs and debuffs be displayed in one single frame?
  --if you disable this it is intended that you unlock the buff and debuffs and move them apart!
  cfg.combineBuffsAndDebuffs = true

  --buff frame settings
  cfg.buffFrame = {
    pos             = { a1 = "TOPRIGHT", af = "UIParent", a2 = "TOPRIGHT", x = -22, y = -22 },
    gap             = 10, --gap between buff and debuff rows
    userplaced      = false, --want to place the bar somewhere else?
    rowSpacing      = 10,
    colSpacing      = 5,
    buttonsPerRow   = 10,
    button = {
      size              = 36,
    },
    icon = {
      padding           = -2,
    },
    border = {
      texture           = "Interface\\AddOns\\rBuffFrameStyler\\media\\gloss",
      color             = { r = 0.4, g = 0.35, b = 0.35, },
      classcolored      = false,
    },
    background = {
      show              = true,   --show backdrop
      edgeFile          = "Interface\\AddOns\\rBuffFrameStyler\\media\\outer_shadow",
      color             = { r = 0, g = 0, b = 0, a = 0.9},
      classcolored      = false,
      inset             = 3,
      padding           = 1,
    },
    duration = {
      font              = font,
      size              = 13,
      pos               = { a1 = "BOTTOM", x = 0, y = -4 },
    },
    count = {
      font              = font,
      size              = 12,
      pos               = { a1 = "TOPRIGHT", x = 0, y = 0 },
    },
  }

  --debuff frame settings
  cfg.debuffFrame = {
    pos             = { a1 = "TOPRIGHT", af = "rBFS_BuffDragFrame", a2 = "BOTTOMRIGHT", x = 0, y = -40 },
    userplaced      = false, --want to place the bar somewhere else?
    rowSpacing      = 10,
    colSpacing      = 5,
    buttonsPerRow   = 6,
    button = {
      size              = 42,
    },
    icon = {
      padding           = -2,
    },
    border = {
      texture           = "Interface\\AddOns\\rBuffFrameStyler\\media\\gloss",
    },
    background = {
      show              = true,   --show backdrop
      edgeFile          = "Interface\\AddOns\\rBuffFrameStyler\\media\\outer_shadow",
      color             = { r = .9, g = 0, b = 0, a = 0.9},
      classcolored      = false,
      inset             = 3,
      padding           = 1,
    },
    duration = {
      font              = font,
      size              = 15,
      pos               = { a1 = "BOTTOM", x = 0, y = -4 },
    },
    count = {
      font              = font,
      size              = 12,
      pos               = { a1 = "TOPRIGHT", x = 0, y = 0 },
    },
  }

