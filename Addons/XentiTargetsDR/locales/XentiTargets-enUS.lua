local L = LibStub('AceLocale-3.0'):NewLocale('XentiTargets', 'enUS', true)

if not L then return end;


L["MESSAGES_WELCOME1"] = "We wish you a lot of fun with the alpha version of XentiTargets."
L["MESSAGES_WELCOME2"] = "If you have any questions please visit us (Xentaria, thered87) at: http://www.twitch.tv/xentaria."
L["BG_MESSAGE_WG_TP_DG_PICKED"] = "was picked up by (.+)!"
L["BG_MESSAGE_WG_TP_DG_DROPPED"] = "was dropped"
L["BG_MESSAGE_WG_TP_DG_CAPTURED"] = "captured the"

L["BG_MESSAGE_EOTS_PICKED"] = "(.+) has taken the flag!"
L["BG_MESSAGE_EOTS_DROPPED"] = "The flag has been dropped!"
L["BG_MESSAGE_EOTS_CAPTURED"] = "(.+) has captured the flag!"

L["BG_MESSAGE_TOK_TAKEN"] = "(.+) has taken the (.+) orb!"
L["BG_MESSAGE_TOK_RETURNED"] = "The (.+) orb has been returned!"

-- ui/addon
L["UI_XentiTargets"] = "XentiTargets"
--- settings
L["UI_General"] = "General"
L["UI_General settings"] = "General settings"
L["UI_Lock frame"] = "Lock frame"
L["UI_Size"] = "Size"
L["UI_Size settings"] = "Size settings"
L["UI_Bar width"] = "Bar width"
L["UI_Width of the bars"] = "Width of the bars"
L["UI_Frame scale"] = "Frame scale"
L["UI_Scale of the frame"] = "Scale of the frame"
L["UI_Toggle if the frame can be moved"] = "Toggle if the frame can be moved"

L["UI_Font"] = "Font"
L["UI_Font settings"] = "Font settings"
L["UI_Global Font"] = "Global font"
L["UI_Global Font Size"] = "Font size of the names"
L["UI_Global Font Size desc"] = "Font size which should be used for the names"
L["UI_Use Global Font Size"] = "Use Global Font Size"
L["UI_Toggle if you want to use the global font size"] = "Toggle if you want to use the global font size"

L["UI_Show realm"] = "Show realm"
L["UI_Toggle if the name should contain the realm"] = "Toggle if the name should contain the realm"

--[[ 

Message: ...dOns\Bartender4\libs\AceLocale-3.0\AceLocale-3.0.lua:49: assertion failed!
Time: Thu May 21 08:03:15 2015
Count: 1
Stack: [C]: ?
...dOns\Bartender4\libs\AceLocale-3.0\AceLocale-3.0.lua:49: in function <...dOns\Bartender4\libs\AceLocale-3.0\AceLocale-3.0.lua:49>
...ce\AddOns\XentiTargets\locales/XentiTargets-enUS.lua:10: in main chunk

Locals: (*temporary) = false


L.UI["lock"] = "lock"
L.UI["Lock"] = "Lock"
L.UI["Toggles windows being locked"] = "Toggles windows being locked"

L.UI["sync"] = "sync"
L.UI["Sync"] = "Synchronize"
L.UI["Toggles sending synchronization messages"] = "Toggles sending synchronization messages"

L.UI["reset"] = "zurücksetzen"
L.UI["Reset"] = "Zurücksetzen"
L.UI["Resets the position"] = "Resets the position"

L.UI["scaling"] = "scaling"
L.UI["Scaling"] = "Scaling"
L.UI["Sets the scaling of the frame"] = "Sets the scaling of the frame"

L.UI["Friendly"] = "Friendly"
L.UI["Toggles whenever to see friendly players or enemies"] = "Toggles whenever to see friendly players or enemies"
]]