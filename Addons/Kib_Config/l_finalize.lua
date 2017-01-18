local LocalDatabase, GlobalDatabase, Locals = unpack(select(2, ...))

--<<NOTES>>-----------------------------------------------------------------------------------------<<>>

    -- A Profile Key doesn't contain any config settings, it's just a path pointing to the current selected profile... Which contains all the settings
    -- (which allows you to switch profiles between different characters and the settings will be the same on both)

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local KibFonts = "Interface\\AddOns\\Kib_Config\\Media\\font\\"
    local BlizFonts = "Fonts\\"

    local ConfigDefaults = {LanguageID = 1, FontID = 1, UseAsGlobalFont = false, UseOldMenu = false, ShowConfigButton = true,}

    local FontList = {
        {KibFonts .. "Walkway.ttf", "Walkway"}, {KibFonts .. "UrbanElegance.ttf", "Urban Elegance"}, {KibFonts .. "Prototype.ttf", "Prototype"}, 
        {KibFonts .. "Mobile_Sans.ttf", "Mobile Sans"}, {KibFonts .. "Cinzel.ttf", "Cinzel"},  {KibFonts .. "EarthOrbiter.ttf", "Earth Orbiter"}, 
        {KibFonts .. "ModernSerif.ttf", "Modern Serif"}, {BlizFonts .."ARIALN.ttf", "Bliz: Arialn"}, {BlizFonts .. "FRIZQT__.ttf", "Bliz: Friz Quadrata"}, 
        {BlizFonts .. "MORPHEUS.ttf", "Bliz: Morpheus"}, {BlizFonts .. "skurri.ttf", "Bliz: Skurri"},
    }

    local LanguageList = {
        [1] = {"Client"}, [2] = {"enUS"}, [3] = {"enGB"}, [4] = {"esES"}, [5] = {"esMX"}, [6] = {"frFR"},
        [7] = {"itIT"}, [8] = {"koKR"}, [9] = {"ptBR"}, [10] = {"ruRU"}, [11] = {"zhCN"}, [12] = {"zhTW"}, [13] = {"deDE"},
    }

--<<INIT THE ADDON>>----------------------------------------------------------------------------<<>>

    local function Init()
        GlobalDatabase.Player_Name = UnitName("player")

        -- Set Prolfile
        local PlayerID = GetRealmName() .. " | " .. GlobalDatabase.Player_Name
        local CharacterKey = "Character Key: " .. PlayerID
    
        if not KIBDB then KIBDB = {} end
        if not KIBDB[CharacterKey] then KIBDB[CharacterKey] = {} end
        if not KIBDB[CharacterKey].ProfileKey then KIBDB[CharacterKey].ProfileKey = PlayerID end
    
        local ProfileKey = KIBDB[CharacterKey].ProfileKey
        if not KIBDB[ProfileKey] then KIBDB[ProfileKey] = {} end

        LocalDatabase.CharacterKey = CharacterKey
        LocalDatabase.ProfileKey = ProfileKey

        local Profile = KIBDB[LocalDatabase.ProfileKey]

        -- Setup Config Default Values
        if not Profile[LocalDatabase.addonName] then Profile[LocalDatabase.addonName] = {} end

        for name, value in pairs(ConfigDefaults) do
            if Profile[LocalDatabase.addonName][name] == nil then Profile[LocalDatabase.addonName][name] = value end
        end

        --Setup Localization
        local LanguageID = Profile[LocalDatabase.addonName].LanguageID
        local Localization = (LanguageID == 1 and GetLocale()) or LanguageList[LanguageID][1]
        LocalDatabase.GetLocalizedText(Localization)
        GlobalDatabase.Localization = Localization

        --Setup Font
        local FontID = Profile[LocalDatabase.addonName].FontID
        GlobalDatabase.Font = FontList[FontID][1]

        if Profile[LocalDatabase.addonName].UseAsGlobalFont then LocalDatabase.SetFonts(GlobalDatabase.Font) end

        -- Setup Game Menu
        LocalDatabase.Init_GameMenu(Profile[LocalDatabase.addonName]) 

        -- Setup General Settings
        local MiscSettings = {
            [1] = {
                element = "DropDown", 
                text = Locals.Language_Title,
                tip = Locals.Language_Tip01 .. Locals.Language_Tip02, 
                value = Profile[LocalDatabase.addonName].LanguageID, 
                Contents = LanguageList,
                popup_text = Locals.Language_Popup,
                func = function(value) Profile[LocalDatabase.addonName].LanguageID = value end
            },
            [2] = {
                element = "DropDown", 
                text = Locals.Font_Title,
                tip = Locals.Font_Tip, 
                value = Profile[LocalDatabase.addonName].FontID, 
                Contents = FontList,
                popup_text = Locals.Font_Popup,
                func = function(value) Profile[LocalDatabase.addonName].FontID = value end
            },
            [3] = {
                element = "CheckButton", 
                text = Locals.UseAsGlobalFont_Title,
                tip = Locals.UseAsGlobalFont_Tip, 
                value = Profile[LocalDatabase.addonName].UseAsGlobalFont, 
                popup_text = Locals.UseAsGlobalFont_Popup,
                func = function(value) Profile[LocalDatabase.addonName].UseAsGlobalFont = value end
            },
            [4] = {
                element = "CheckButton", 
                text = Locals.UseOldMenu_Title,
                tip = Locals.UseOldMenu_Tip, 
                value = Profile[LocalDatabase.addonName].UseOldMenu, 
                popup_text = Locals.UseOldMenu_Popup,
                func = function(value) Profile[LocalDatabase.addonName].UseOldMenu = value end
            },
            [5] = {
                element = "CheckButton", 
                text = Locals.ShowConfigButton_Title,
                tip = Locals.ShowConfigButton_Tip, 
                value = Profile[LocalDatabase.addonName].ShowConfigButton, 
                popup_text = Locals.ShowConfigButton_Popup,
                func = function(value) Profile[LocalDatabase.addonName].ShowConfigButton = value end
            },
        }       

        GlobalDatabase.Config_Add(MiscSettings, Locals.General, Locals.Misc, "Interface\\AddOns\\Kib_Config\\Media\\Config_Icon", Locals.GeneralTabTip)
    end

--<<REGISTER FOR INIT>>-------------------------------------------------------------------------------<<>>

    local InitDummy = CreateFrame("Frame")
    InitDummy:RegisterEvent("ADDON_LOADED")

    InitDummy:SetScript("OnEvent", function(self,_, Addon)
        if Addon == LocalDatabase.addonName then
            Init()
            self:UnregisterEvent("ADDON_LOADED")
        end
    end)

--<<GLOBAL FUNCTION TO REGISTER ADDONS WITH KIB_CONFIG>>--------------------------------------------<<>>

    function Kib_Register_Addon(Addon_Name, Addon_Version, Defaults, Author)
        local Profile = KIBDB[LocalDatabase.ProfileKey]
        if not Profile[Addon_Name] then Profile[Addon_Name] = {} end 

        -- Setup Addon Default Values
        if Defaults then
            for name_A, value_A in pairs(Defaults) do

                if type(value_A) == "table" then
                    if Profile[Addon_Name][name_A] == nil then Profile[Addon_Name][name_A] = {} end

                    for name_B, value_B in pairs(value_A) do
                        if Profile[Addon_Name][name_A][name_B] == nil then Profile[Addon_Name][name_A][name_B] = value_B end
                    end
                else
                    if Profile[Addon_Name][name_A] == nil then Profile[Addon_Name][name_A] = value_A  end
                end
            end
        end

        if Profile[Addon_Name].State == nil then Profile[Addon_Name].State = true end -- Just incase someone forgets to include this variable

        -- Add Addon Toggle Setting
        local AddonToggle = {
            [1] = {
                element = "CheckButton", 
                text = Addon_Name,
                tip = format("%s\n\n%s: %s\n%s: %s", Locals.Addon_Tip, Locals.Addon_Version, tostring(Addon_Version), Locals.Author, Author or "Unknown"), 
                value = Profile[Addon_Name].State, 
                popup_text = Locals.Addon_Popup,
                func = function(value) Profile[Addon_Name].State = value end
            },
        }       
        GlobalDatabase.Config_Add(AddonToggle, Locals.General, Locals.Addons)

        return Profile[Addon_Name], GlobalDatabase
    end

----------------------------------------------------------------------------------------------------<<END>>