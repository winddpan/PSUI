-- from diminfo

local addon, ns = ...
local cfg = CreateFrame("Frame")
local ParentBar = Bottompanel

local ajustX = -10
-- enable modules
cfg.Bags = false
cfg.BagsPoint = {"bottomleft", ParentBar, -200 +ajustX, 2}

cfg.Coords = false
cfg.CoordsPoint = {"bottom", Minimap, 0 +ajustX, 2}

cfg.Durability = true
cfg.DurabilityPoint = {"bottomleft", ParentBar, 100 +ajustX, 2}

cfg.Friends = false
cfg.FriendsPoint = {"bottomleft", ParentBar, 160 +ajustX, 2}

cfg.Gold = false
cfg.GoldPoint = {"bottom", ParentBar, 220 +ajustX, 2}

cfg.Guild = false
cfg.GuildPoint = {"bottom", ParentBar, 105 +ajustX, 2}

cfg.Mail = false
cfg.MailPoint = {"center",ParentBar}

cfg.Memory = true
cfg.MemoryPoint = {"bottomleft", ParentBar, 160 +ajustX, 2}
cfg.MaxAddOns = 20

cfg.Positions = false
cfg.PositionsPoint = {"top", ParentBar, "topright", -22 +ajustX, -2}

cfg.Spec = true
cfg.SpecPoint = {"bottomleft", ParentBar, 325 +ajustX, 2}

cfg.System = true
cfg.SystemPoint = {"bottomleft", ParentBar, 228 +ajustX, 2}

cfg.Time = false
cfg.TimePoint = {"bottomleft", ParentBar, 385 +ajustX, 2}

--Fonts and Colors
cfg.Fonts = {STANDARD_TEXT_FONT, 11, "thinoutline"}
cfg.ColorClass = false

ns.cfg = cfg