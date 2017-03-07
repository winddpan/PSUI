--[[****************************************************************************
  * Locales/Locale-deDE.lua - Localized string constants (de-DE).              *
  ****************************************************************************]]
function BGD_init_deDE()
    BGD_HELP      = "$base Hilfe erforderlich!"
    BGD_SAFE      = "$base sicher."
    BGD_INC       = "$base $num inc."
    BGD_INCPLUS   = "$base mehr als 5 inc."
end

if (GetLocale() == "deDE") then
    BGD_AV        = "Alteractal"
    BGD_AB        = "Arathibecken"
    BGD_WSG       = "Kriegshymnenschlucht"
    BGD_WSL       = "Kriegshymnenschlucht"
    BGD_SWH       = "Kriegshymnenschlucht"
    BGD_EOTS      = "Auge des Sturms"
    BGD_SOTA      = "Strand der Uralten" 
    BGD_IOC       = "Insel der Eroberung"
    BGD_TP        = "Zwillingsgipfel" 
    BGD_DMH       = "Zwillingsgipfel "
    BGD_GIL       = "Die Schlacht um Gilneas" 

    BGD_WG        = "Tausendwintersee"
    BGD_TB        = "Tol Barad"

    BGD_AWAY      = "Du bist zu weit von einer Basis entfernt!"
    BGD_OUT       = "Du bist nicht im schlachtfeld!"

    BGD_GENERAL   = "Allgemein"
end
