local _, AddonDB = ...

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

	local Localizations = {}

--<<DEFAULT LOCALIZATION>>--------------------------------------------------------------------------<<>>

	-- This will be used for enGB, enUS and any empty Localization function
	
	local function Default()
		local L = {}

		L.General 		= "General"
		L.Indicator 	= "Indicator"
		L.Tasks 		= "Tasks"
		L.TabTip 		= "Settings that alter the look and functionality of quest indicators that display over your enemys head"

		L.DisableInInstance 			= {"Disable In Any Instance", "Quest indicators will not display while in any instance"}
		L.DisableInCombat 				= {"Disable In Combat", "When in combat with a mob, its quest indicator will be disabled"}

		L.TextureVariant 				= {"Texture Variant", "Change the image used for the quest indicator."}
		L.Alpha 						= {"Opacity", "How visible the indicator will be."}
		L.NormalQuestcolor 				= {"Normal Quest Colour", "Change the colour of the normal quest indicator."}
		L.GroupQuestcolor				= {"Group Quest Colour", "Change the colour of the Group quest indicator."}
		L.AreaQuestcolor 				= {"Bonus Area Quest Colour", "Change the colour of the bonus area quest indicator."}
		L.Scale 						= {"Scale", "Change the scale of the quest indicator."}
		L.IconXOffset 					= {"Horizontal Offset", "Moves the icon either to the left or the right."}
		L.IconYOffset 					= {"Vertical Offset", "Moves the icon either up or down."}

		L.ShowQuestTask 				= {"Show Tasks", "Each task will be displayed in plain text."}
		L.ShowQuestTaskOnMouseOver 		= {"Mouse Over Only", "Quest tasks will only display if your mouse is over the quest indicator."}
		L.TasksXOffset 					= {"Horizontal Offset", "Moves the quest tasks either to the left or the right."}
		L.TasksYOffset 					= {"Vertical Offset", "Moves the quest tasks either up or down."}
		L.TextSize 						= {"Text Size", "The size of the text which displays the quests task."}

		return L
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

	function AddonDB.GetLocalizedText(SelectedLanguage)
		return Localizations[SelectedLanguage]()
	end

----------------------------------------------------------------------------------------------------<<END>>