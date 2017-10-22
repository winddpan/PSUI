local function defaultsetting() 
   SetCVar("namePlateMinScale", 0.5)  --default is 0.8 
   SetCVar("namePlateMaxScale", 0.5) 
   SetCVar("ShowClassColorInFriendlyNameplate", 1)
end 

local DFS = CreateFrame("FRAME", "defaultsetting") 
DFS:RegisterEvent("VARIABLES_LOADED") 
DFS:RegisterEvent("NAME_PLATE_CREATED") 
DFS:RegisterEvent("NAME_PLATE_UNIT_ADDED") 
DFS:RegisterEvent("NAME_PLATE_UNIT_REMOVED") 
DFS:RegisterEvent("CVAR_UPDATE") 
DFS:RegisterEvent("DISPLAY_SIZE_CHANGED") 
DFS:RegisterEvent("PLAYER_ENTERING_WORLD") 
DFS:RegisterEvent("PLAYER_LOGIN") 
local function eventHandler(self, event, ...) 
   defaultsetting() 
end 
DFS:SetScript("OnEvent", eventHandler)

local function SetFont(obj, optSize) 
   local fontName, _,fontFlags  = obj:GetFont() 
   obj:SetFont(fontName,optSize,"OUTLINE") 
   obj:SetShadowOffset(0, 0) 
end 

local size = 20
SetFont(SystemFont_LargeNamePlate, size) 
SetFont(SystemFont_LargeNamePlateFixed, size)
SetFont(SystemFont_NamePlate, size)  
SetFont(SystemFont_NamePlateFixed, size) 
SetFont(SystemFont_NamePlateCastBar, size)