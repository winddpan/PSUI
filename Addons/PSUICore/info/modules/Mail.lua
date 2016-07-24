local addon, ns = ...
local cfg = ns.cfg
local init = ns.init
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.Mail == true then
    local Stat = CreateFrame("Frame")
    Stat:EnableMouse(false)

    local Text  = panel:CreateFontString(nil, "OVERLAY")
    Text:SetFont(unpack(cfg.Fonts))
    Text:SetPoint(unpack(cfg.MailPoint))
	Stat:SetAllPoints(Text)

	Stat:SetScript("OnUpdate", function()
		Text:SetText(cfg.ColorClass and (HasNewMail() and "|cff00FF00New|r"..init.Colored.."mail" or init.Colored.."No mail|r") or HasNewMail() and "|cff00FF00New|r mail" or "No mail")
	end)
end