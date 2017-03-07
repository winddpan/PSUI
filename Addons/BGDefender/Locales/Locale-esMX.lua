--[[****************************************************************************
  * Locales/Locale-esMX.lua - Localized string constants (es-MX).              *
  ****************************************************************************]]
function BGD_init_esMX()
    BGD_HELP    = "$base necesita ayuda." 
    BGD_SAFE    = "$base esta asegurado." 
    BGD_INC     = "$base $num llegando." 
    BGD_INCPLUS = "$base mas de 5 llegando." 
end

if ((GetLocale() == "esES") or (GetLocale() == "esMX")) then
    BGD_AV      = "Valle de Alterac" 
    BGD_AB      = "Cuenca de Arathi" 
    BGD_WSG     = "Garganta Grito de Guerra" 
    BGD_WSL     = "Serreria Grito de Guerra" 
    BGD_SWH     = "Basti�n Ala de Plata" 
    BGD_EOTS    = "Ojo de la Tormenta" 
    BGD_SOTA    = "Playa de los Ancestros" 
    BGD_IOC     = "Isla de la Conquista" 
    BGD_TP      = "Cumbres Gemelas"
    BGD_DMH     = "Basti�n Faucedraco"    
    BGD_GIL     = "La Batalla por Gilneas" 

    BGD_WG      = "Conquista del Invierno" 
    BGD_TB      = "Tol Barad" 

    BGD_AWAY    = "No estas cerca de un punto que defender!" 
    BGD_OUT     = "No estas en un campo de batalla!"

    BGD_GENERAL = "General"
end
