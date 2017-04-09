-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Fader
-----------------------------

local fader = {
  fadeInAlpha = 1,
  fadeInDuration = 0.1,
  fadeInSmooth = "OUT",
  fadeOutAlpha = 0,
  fadeOutDuration = 0.1,
  fadeOutSmooth = "OUT",
}

-----------------------------
-- BagBar
-----------------------------

local bagbar = {
  frameVisibility = "hide",
  framePoint      = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -5, 5 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 2,
  numCols         = 6, --number of buttons per column
  startPoint      = "BOTTOMRIGHT", --start postion of first button: BOTTOMLEFT, TOPLEFT, TOPRIGHT, BOTTOMRIGHT
  fader           = fader,
}
--create
rActionBar:CreateBagBar(A, bagbar)

-----------------------------
-- MicroMenuBar
-----------------------------

local micromenubar = {
  framePoint      = { "TOP", UIParent, "TOP", 0, 0 },
  frameScale      = .9,
  framePadding    = 2,
  buttonWidth     = 28,
  buttonHeight    = 58,
  buttonMargin    = 0,
  numCols         = 12,
  startPoint      = "BOTTOMLEFT",
  fader           = fader,
}
--create
rActionBar:CreateMicroMenuBar(A, micromenubar)

-----------------------------
-- Bar1
-----------------------------

local bar1 = {
  framePoint      = { "BOTTOM", UIParent, "BOTTOM", 0, 60 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 40,
  buttonHeight    = 40,
  buttonMargin    = 0,
  numCols         = 10,
  numButtons	  = 10,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateActionBar1(A, bar1)

-----------------------------
-- Bar2
-----------------------------

local bar2 = {
  framePoint      = { "BOTTOM", UIParent, "BOTTOM", 0, 100 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 40,
  buttonHeight    = 40,
  buttonMargin    = 0,
  numCols         = 10,
  numButtons	  = 10,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateActionBar2(A, bar2)

-----------------------------
-- Bar3
-----------------------------
local bar3 = {
  framePoint      = { "BOTTOMLEFT", UIParent, "BOTTOM", 380, 8 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 34,
  buttonHeight    = 34,
  buttonMargin    = 0,
  numCols         = 6,
  startPoint      = "BOTTOMLEFT",
  fader           = {
                      fadeInAlpha = 1,
                      fadeInDuration = 0.1,
                      fadeInSmooth = "OUT",
                      fadeOutAlpha = 0,
                      fadeOutDuration = 0.1,
                      fadeOutSmooth = "OUT",
                    },
}
--create
rActionBar:CreateActionBar3(A, bar3)

-----------------------------
-- Bar4
-----------------------------

local bar4 = {
  framePoint      = { "RIGHT", UIParent, "RIGHT", 1, 0 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 36,
  buttonHeight    = 36,
  buttonMargin    = 0,
  numCols         = 1,
  startPoint      = "TOPRIGHT",
  fader           = nil,
}
--create
rActionBar:CreateActionBar4(A, bar4)

-----------------------------
-- Bar5
-----------------------------

local bar5 = {
  framePoint      = { "RIGHT", _G[A.."Bar4"], "LEFT", 2, 0 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 36,
  buttonHeight    = 36,
  buttonMargin    = 0,
  numCols         = 1,
  startPoint      = "TOPRIGHT",
  fader           = nil,
}
--create
rActionBar:CreateActionBar5(A, bar5)

-----------------------------
------ Combine bar4&5
-----------------------------

function GetButtonList(buttonName)
  local buttonList = {}
  for i=1, NUM_ACTIONBAR_BUTTONS do
    local button = _G[buttonName..i]
    if not button then break end
    table.insert(buttonList, button)
  end
  return buttonList
end

function combineBar4And5() 
  local numRows = NUM_ACTIONBAR_BUTTONS
  local numCols = 1
  local frameWidth = numCols*bar4.buttonWidth + (numCols-1)*bar4.buttonMargin + 2*bar4.framePadding
  local frameHeight = numRows*bar4.buttonHeight + (numRows-1)*bar4.buttonMargin + 2*bar4.framePadding
  
  local frame = CreateFrame("Frame", A.."Bar4&5", UIParent, "SecureHandlerStateTemplate")
  frame:SetPoint(unpack(bar4.framePoint))
  frame:SetSize(frameWidth * 2, frameHeight)

  _G[A.."Bar4"]:SetParent(frame)
  _G[A.."Bar5"]:SetParent(frame)

  local buttonList = GetButtonList("MultiBarRightButton")
  for i,v in pairs(GetButtonList("MultiBarLeftButton")) do
    table.insert(buttonList, v)
  end
  rLib:CreateButtonFrameFader(frame, buttonList, fader)
end
combineBar4And5()

-----------------------------
-- StanceBar
-----------------------------

local stancebar = {
  framePoint      = { "BOTTOMLEFT", A.."Bar2", "TOPLEFT", 1, 0 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 0,
  numCols         = 12,
  startPoint      = "BOTTOMLEFT",
  fader           = fader,
}
--create
rActionBar:CreateStanceBar(A, stancebar)

-----------------------------
-- PetBar
-----------------------------

--petbar
local petbar = {
  framePoint      = { "BOTTOM", UIParent, "BOTTOM", 0, 10 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 0,
  numCols         = 12,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreatePetBar(A, petbar)

-----------------------------
-- ExtraBar
-----------------------------

local extrabar = {
  framePoint      = { "RIGHT", A.."Bar2", "BOTTOMLEFT", 0, 0 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 44,
  buttonHeight    = 44,
  buttonMargin    = 0,
  numCols         = 1,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateExtraBar(A, extrabar)

-----------------------------
-- VehicleExitBar
-----------------------------

local vehicleexitbar = {
  framePoint      = { "LEFT", A.."Bar2", "RIGHT", 5, 0 },
  frameScale      = 1,
  framePadding    = 2,
  buttonWidth     = 36,
  buttonHeight    = 36,
  buttonMargin    = 0,
  numCols         = 1,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateVehicleExitBar(A, vehicleexitbar)

-----------------------------
-- PossessExitBar
-----------------------------

local possessexitbar = {
  framePoint      = { "BOTTOMLEFT", A.."Bar1", "BOTTOMRIGHT", 5, 0 },
  frameScale      = 0.95,
  framePadding    = 2,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 0,
  numCols         = 1,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreatePossessExitBar(A, possessexitbar)