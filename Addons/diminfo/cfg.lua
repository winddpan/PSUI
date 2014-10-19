local addon, ns = ...
local cfg = CreateFrame("Frame")

local ajustX = -10
-- enable modules
cfg.Bags = false
cfg.BagsPoint = {"bottomleft", UIParent, -200 +ajustX, 2}

cfg.Coords = false
cfg.CoordsPoint = {"bottom", Minimap, 0 +ajustX, 2}

cfg.Durability = true
cfg.DurabilityPoint = {"bottomleft", UIParent, 100 +ajustX, 2}

cfg.Friends = false
cfg.FriendsPoint = {"bottomleft", UIParent, 160 +ajustX, 2}

cfg.Gold = false
cfg.GoldPoint = {"bottom", UIParent, 220 +ajustX, 2}

cfg.Guild = false
cfg.GuildPoint = {"bottom", UIParent, 105 +ajustX, 2}

cfg.Mail = false
cfg.MailPoint = {"center",UIParent}

cfg.Memory = true
cfg.MemoryPoint = {"bottomleft", UIParent, 160 +ajustX, 2}
cfg.MaxAddOns = 20

cfg.Positions = false
cfg.PositionsPoint = {"top", UIParent, "topright", -22 +ajustX, -2}

cfg.Spec = true
cfg.SpecPoint = {"bottomleft", UIParent, 325 +ajustX, 2}

cfg.System = true
cfg.SystemPoint = {"bottomleft", UIParent, 228 +ajustX, 2}

cfg.Time = false
cfg.TimePoint = {"bottomleft", UIParent, 385 +ajustX, 2}

--Fonts and Colors
cfg.Fonts = {STANDARD_TEXT_FONT, 11, "thinoutline"}
cfg.ColorClass = false


ns.cfg = cfg