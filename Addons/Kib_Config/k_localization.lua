local LocalDatabase, _, Locals = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

	local Localizations = {}

--<<DEFAULT LOCALIZATION>>--------------------------------------------------------------------------<<>>

	-- This will be used for enUS, enGB and any empty Localization function
	
	local function Default()
		Locals.Welcome_Message_A 		= "To start using Kib Config, select one of the buttons above the white line."
		Locals.Welcome_Message_B 		= "\n\nIf any issues arise, please post in the forum or PM the author. Thanks! \n\nConfig Version: "

		Locals.ConfigLine_Hint 			= {"Left Click: Copy Settings", "Right Click: Paste Settings"}

		Locals.GeneralTabTip 			= "Contains many general settings"

		Locals.ProfileButton_New 		= {"Create a New Profile", "Type the name of your new Profile"}
		Locals.ProfileButton_Delete 		= {"Delete a Profile", "Select a specific Profile to delete"}
		Locals.ProfileButton_Rename 		= {"Rename Profile", "Type a new name for your current Profile"}
		Locals.ProfileButton_Copy 		= {"Copy a Profile", "Select a specific Profile to copy from"}
		Locals.ProfileButton_Switch 		= {"Switch Profiles", "Select a specific Profile to switch to"}

		Locals.UseAsGlobalFont_Title, Locals.UseAsGlobalFont_Tip = "Use As Global Font", "Your selected font will be applied to all ingame text\n\nNote: Combat text will not update until you restart the game"
		Locals.UseAsGlobalFont_Popup = "Toggle use as global font"

		Locals.ShowConfigButton_Title, Locals.ShowConfigButton_Tip = "Add Config Button to Default Menu", "Adds a button for Kib: Config to the default game menu"
		Locals.ShowConfigButton_Popup = "Toggle the Kib: Config button"

		Locals.UseOldMenu_Title, Locals.UseOldMenu_Tip = "Use Default Game Menu", "Toggle between the default game menu and Kib_Configs game menu"
		Locals.UseOldMenu_Popup = "Toggle the Game Menu"

		Locals.Language_Title, Locals.Language_Popup = "Language", "Switch the Language to: "
		Locals.Language_Tip01 = "Select the specific Language you would like to use.\n\nIf any Non-English Language is still in English, then they have yet to be translated (or your selected font doesn't support it)."
		Locals.Language_Tip02 = "\n\nThink you can help with translation? if so, contact the author."

		Locals.Font_Title, Locals.Font_Popup = "Font", "Switch Font to: "
		Locals.Font_Tip = "The global font used for KIB related addons \n\nNote:\nMost custom fonts don't support non English characters. If this is an issue, stick to using fonts that say [Bliz:] "

		Locals.Addon_Tip, Locals.Addon_Version, Locals.Addon_Popup = "Enable or Disable this Addon", "Addon Version", "Toggle This Addon?"

		Locals.Author = "Author"
		Locals.R, Locals.G, Locals.B = "R", "G", "B"
		Locals.Yes, Locals.No, Locals.Disabled, Locals.General, Locals.Addons = "Yes", "No", "Disabled", "General", "Addons"
		Locals.Values, Locals.Misc, Locals.Reload, Locals.Accept, Locals.Decline = "Values", "Misc", " (Reload)", "Accept", "Decline"
		Locals.Addons2, Locals.Settings, Locals.Help, Locals.Shop, Locals.System = "ADDONS", "SETTINGS", "HELP", "SHOP", "SYSTEM"
		Locals.Interface, Locals.KeyBindings, Locals.Macros, Locals.Logout	= "INTERFACE", "KEY BINDINGS", "MACROS", "LOGOUT"
		Locals.Exit, Locals.Close, Locals.Quit, Locals.GameMenu, Locals.CurrentProfile	= "EXIT", "CLOSE", "QUIT GAME", "GAME MENU", "Current Profile"
	end

--<<itIT>>------------------------------------------------------------------------------------------<<>>

	function Localizations.itIT()
		return Default()
	end

--<<koKR>>------------------------------------------------------------------------------------------<<>>

	function Localizations.koKR()
		return Default()
	end

--<<ptBR>>------------------------------------------------------------------------------------------<<>>

	function Localizations.ptBR()
		return Default()
	end

--<<ruRU>>------------------------------------------------------------------------------------------<<>>

	function Localizations.ruRU()
		return Default()
	end

--<<zhCN>>------------------------------------------------------------------------------------------<<>>

	function Localizations.zhCN()
		return Default()
	end

--<<zhTW>>------------------------------------------------------------------------------------------<<>>

	function Localizations.zhTW()
		return Default()
	end

--<<deDE>>------------------------------------------------------------------------------------------<<>>

	function Localizations.deDE()
		return Default()
	end

--<<enGB>>------------------------------------------------------------------------------------------<<>>

	function Localizations.enGB() -- Leave as Default
		return Default()
	end

--<<enUS>>------------------------------------------------------------------------------------------<<>>

	function Localizations.enUS() -- Leave as Default
		return Default()
	end

--<<esES>>------------------------------------------------------------------------------------------<<>>

	function Localizations.esES()
		return Default()
	end

--<<esMX>>------------------------------------------------------------------------------------------<<>>

	function Localizations.esMX()
		return Default()
	end

--<<frFR>>------------------------------------------------------------------------------------------<<>>

	function Localizations.frFR()
		return Default()
	end

--<<GET LOCALIZED TEXT>>----------------------------------------------------------------------------<<>>

	function LocalDatabase.GetLocalizedText(SelectedLanguage)
		Localizations[SelectedLanguage]()
	end

----------------------------------------------------------------------------------------------------<<END>>