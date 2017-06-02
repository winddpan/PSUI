local L = LibStub("AceLocale-3.0"):NewLocale ("AddonCpuUsage", "enUS", true) 
if not L then return end 

L["STRING_CAPTURING_CPU"] = "Capturing Addons Cpu Usage"
L["STRING_CLOSE"] = "close"
L["STRING_DATABROKER_HELP_LEFTBUTTON"] = "|cFFFFFF00Left Click|r: open cpu panel."
L["STRING_DATABROKER_HELP_RIGHTBUTTON"] = "|cFFFFFF00Right Click|r: open options."
L["STRING_FINISHED_INCOMBAT"] = "waiting the end of the combat to open the window."
L["STRING_FINISHED_NOTENOUGHTIME"] = "combat elapsed time was too short."
L["STRING_FINISHED_SUCCESSFUL"] = "data successfully captured."
L["STRING_HELP_DONTSHOWAGAIN"] = "Don't show this screen again."
L["STRING_LISTPANEL_ADDONNAME"] = "Addon Name"
L["STRING_LISTPANEL_AVERAGE"] = "Average:"
L["STRING_LISTPANEL_AVERAGE_DESC"] = [=[Average time in milliseconds used
to process addons information.

The game needs to deliver one
frame every |cFFFFFF0016ms|r, any delay causes
a frame rate loss.]=]
L["STRING_LISTPANEL_AVERAGE_DESC_TITLE"] = "Average Time Spent"
L["STRING_LISTPANEL_MS"] = "Milliseconds"
L["STRING_LISTPANEL_MS_DESC"] = "Average time used every second."
L["STRING_LISTPANEL_PEAK"] = "Peak"
L["STRING_LISTPANEL_PEAK_DESC"] = "Highest usage during the measure."
L["STRING_LISTPANEL_PERCENT"] = "Percent"
L["STRING_LISTPANEL_TOTAL"] = "Total:"
L["STRING_LISTPANEL_TOTAL_DESC"] = [=[Amount of time where the game has freezed
to process information from addons.

This amount are distributed among
every frame processed.]=]
L["STRING_LISTPANEL_TOTAL_DESC_TITLE"] = "Total Time Spent"
L["STRING_LISTPANEL_TOTALUSAGE"] = "Total Usage"
L["STRING_LISTPANEL_TOTALUSAGE_DESC"] = [=[Total time in seconds used by the
addon to process information.]=]
L["STRING_NO_INTENDED"] = "Not intended? |cFFFF7700Click Here|r"
L["STRING_OPTIONS_GATHERTIME"] = "Gather Time"
L["STRING_OPTIONS_GATHERTIME_DESC"] = "Time to stay gathering data from addons."
L["STRING_OPTIONS_MINIMAP"] = "Minimap Icon"
L["STRING_OPTIONS_MINIMAP_DESC"] = "Show or hide the minimap icon."
L["STRING_OPTIONS_STARTDELAY"] = "Start Delay"
L["STRING_OPTIONS_STARTDELAY_DESC"] = "After the encounter beginning, wait X seconds to start gather data."
L["STRING_PROFILE_DISABLED"] = "The game client isn't running CPU Performance Profiler (required by this addon). Click on the button to active:"
L["STRING_PROFILE_ENABLED"] = "The game client has CPU Profiling enabled! The addon is ready to use."
L["STRING_PROFILE_START"] = "Start Profiler"
L["STRING_PROFILE_STOP"] = "Stop Profiler"
L["STRING_SWITCH_SHOWGRAPHIC"] = "Show Graphic"
L["STRING_SWITCH_SHOWLIST"] = "Show List"
L["STRING_TUTORIAL_LINE_1"] = "|cFFFFFFFF1|r) Enter in a raid instance (can be a raid finder one)."
L["STRING_TUTORIAL_LINE_2"] = "|cFFFFFFFF2|r) When inside the instance, check if the Cpu Performance Profiler is enabled (see at the bottom of the window)."
L["STRING_TUTORIAL_LINE_3"] = "|cFFFFFFFF3|r) If isn't enabled, click on the 'Start Profiler' button."
L["STRING_TUTORIAL_LINE_4"] = "|cFFFFFFFF4|r) Play a boss encounter for at least two minutes."
L["STRING_TUTORIAL_LINE_5"] = "|cFFFFFFFF5|r) At the end, the addon shows to you the window with the results."
L["STRING_TUTORIAL_LINE_6"] = [=[

|cFFFFFFFFImportant:|r) When you are done with your tests, make sure to disable the Cpu Profiler clicking on the 'Stop Profiler' button.]=]
L["STRING_TUTORIAL_TITLE"] = "Follow these steps:"

