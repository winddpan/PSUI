--[[****************************************************************************
  * Locales/Locale-ruRU.lua - Localized string constants (ru-RU).              *
  ****************************************************************************]]
function BGD_init_ruRU()
    BGD_HELP     = "$base нужна помощь!"
    BGD_SAFE     = "$base все спокойно."
    BGD_INC      = "$base напали $num"
    BGD_INCPLUS  = "$base зергают!" 
end

if (GetLocale() == "ruRU") then
    BGD_AV       = "Альтеракская Долина"
    BGD_AB       = "Низина Арати"
    BGD_WSG      = "Ущелье Песни Войны"
    BGD_WSL      = "Лесопилка Песни Войны"
    BGD_SWH      = "Крепость Серебряного Крыла"
    BGD_EOTS     = "Око бури"
    BGD_SOTA     = "Берег Древних"
    BGD_IOC      = "Остров Завоеваний"
    BGD_TP       = "Два Пика"
    BGD_DMH      = "Форт Драконьей Пасти"
    BGD_GIL      = "Битва за Гилнеас"

    BGD_WG       = "Озеро Ледяных Оков"
    BGD_TB       = "Тол Барад"

    BGD_AWAY     = "Вы не около точки!"
    BGD_OUT      = "Вы не на бг!"

    BGD_GENERAL = "Общее"
end
