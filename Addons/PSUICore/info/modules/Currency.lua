local addon, ns = ...
local cfg = ns.cfg
local init = ns.init
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.Currency == true then
    local Stat = CreateFrame("Frame")
    Stat:EnableMouse(true)

    local Text  = panel:CreateFontString(nil, "OVERLAY")
    Text:SetFont(unpack(cfg.Fonts))
    Text:SetPoint(unpack(cfg.CurrencyPoint))
	Stat:SetAllPoints(Text)
	
	local Currency = 0
	local a,b
	local function formatCurrency() return 
	format(cfg.ColorClass and init.Colored..infoL["Currency"]..": ".."|r".."%d", Currency) 
	end
	
	Stat:SetScript("OnUpdate", function()
		a, Currency, b = GetCurrencyInfo(1220)  --824要塞
		Text:SetText(formatCurrency())
	end)

end