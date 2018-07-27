-- from diminfo

local addon, ns = ...
local cfg = CreateFrame("Frame")
local ParentBar = Bottompanel

local ajustY = 6
local ajustX = -10

-- enable modules
cfg.Bags = false
cfg.BagsPoint = {"bottomleft", ParentBar, -200 +ajustX, ajustY}

cfg.Durability = true
cfg.DurabilityPoint = {"bottomleft", ParentBar, 100 +ajustX, ajustY}

cfg.Guild = false
cfg.GuildPoint = {"bottom", ParentBar, 105 +ajustX, ajustY}

cfg.Memory = true
cfg.MemoryPoint = {"bottomleft", ParentBar, 160 +ajustX, ajustY}
cfg.MaxAddOns = 30

cfg.Positions = false
cfg.PositionsPoint = {"top", ParentBar, "topright", -22 +ajustX, -ajustY}

cfg.Spec = false
cfg.SpecPoint = {"bottomleft", ParentBar, 325 +ajustX, ajustY}

cfg.System = true
cfg.SystemPoint = {"bottomleft", ParentBar, 228 +ajustX, ajustY}

cfg.Time = false
cfg.TimePoint = {"bottom", Minimap, 0, -8}

cfg.Currency = false
cfg.CurrencyPoint = {"bottomright", UIParent, -480, 2}

--Fonts and Colors
cfg.Fonts = {STANDARD_TEXT_FONT, 11, "thinoutline"}
cfg.ColorClass = false

ns.cfg = cfg