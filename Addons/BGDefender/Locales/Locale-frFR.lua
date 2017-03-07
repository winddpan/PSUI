--[[****************************************************************************
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]
function BGD_init_frFR()
    BGD_HELP    = "Besoin d'aide à $base."
    BGD_SAFE    = "$base sécurisée."
    BGD_INC     = "$num ennemis en approche à $base."
    BGD_INCPLUS = "Plus de 5 ennemis arrivent à $base."
end

if (GetLocale() == "frFR") then
    BGD_AV      = "Vallée d'Alterac"
    BGD_AB      = "Bassin Arathi"
    BGD_WSG     = "Goulet des Chanteguerres"
    BGD_WSL     = "Scierie des Chanteguerres"
    BGD_SWH     = "Fort d'Aile-argent"
    BGD_EOTS    = "L’Œil du cyclone"
    BGD_SOTA    = "Rivage des Anciens"
    BGD_IOC     = "Île des Conquérants"
    BGD_TP      = "Pics-Jumeaux"
    BGD_DMH     = "Bastion Gueule-de-dragon"
    BGD_GIL     = "La bataille de Gilnéas"

    BGD_WG      = "Joug-d'hiver"
    BGD_TB      = "Tol Barad"

    BGD_AWAY    = "Vous n'êtes pas assez près d'un point à défendre!"
    BGD_OUT     = "Vous n’êtes pas dans un Champ de bataille!"

    BGD_GENERAL = "Général"
end 
