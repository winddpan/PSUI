local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- Always check line number in regexp and file, must be 1
--[===[@debug@
print('Loaded',__FILE__)
--@end-debug@]===]
local function pp(...) print(GetTime(),"|cff009900",__FILE__:sub(-15),strjoin(",",tostringall(...)),"|r") end
--*TYPE module
--*CONFIG profile=true,enhancedProfile=true
-- Auto Generated
local me,ns=...
if ns.die then return end
local addon=ns --#Addon (to keep eclipse happy)
ns=nil
local module=addon:NewSubModule('Data')  --#Module
function addon:GetDataModule() return module end
-- Template
local G=C_Garrison
local _
local AceGUI=LibStub("AceGUI-3.0")
local C=addon:GetColorTable()
local L=addon:GetLocale()
local new=addon:Wrap("NewTable")
local del=addon:Wrap("DelTable")
local kpairs=addon:Wrap("Kpairs")
local empty=addon:Wrap("Empty")

local todefault=addon:Wrap("todefault")

local tonumber=tonumber
local type=type
local OHF=OrderHallMissionFrame
local OHFMissionTab=OrderHallMissionFrame.MissionTab --Container for mission list and single mission
local OHFMissions=OrderHallMissionFrame.MissionTab.MissionList -- same as OrderHallMissionFrameMissions Call Update on this to refresh Mission Listing
local OHFFollowerTab=OrderHallMissionFrame.FollowerTab -- Contains model view
local OHFFollowerList=OrderHallMissionFrame.FollowerList -- Contains follower list (visible in both follower and mission mode)
local OHFFollowers=OrderHallMissionFrameFollowers -- Contains scroll list
local OHFMissionPage=OrderHallMissionFrame.MissionTab.MissionPage -- Contains mission description and party setup 
local OHFMapTab=OrderHallMissionFrame.MapTab -- Contains quest map
local OHFCompleteDialog=OrderHallMissionFrameMissions.CompleteDialog
local OHFMissionScroll=OrderHallMissionFrameMissionsListScrollFrame
local OHFMissionScrollChild=OrderHallMissionFrameMissionsListScrollFrameScrollChild
local followerType=LE_FOLLOWER_TYPE_GARRISON_7_0
local garrisonType=LE_GARRISON_TYPE_7_0
local FAKE_FOLLOWERID="0x0000000000000000"
local MAX_LEVEL=110

local ShowTT=OrderHallCommanderMixin.ShowTT
local HideTT=OrderHallCommanderMixin.HideTT

local dprint=print
local ddump
--[===[@debug@
LoadAddOn("Blizzard_DebugTools")
ddump=DevTools_Dump
LoadAddOn("LibDebug")

if LibDebug then LibDebug() dprint=print end
local safeG=addon.safeG

--@end-debug@]===]
--@non-debug@
dprint=function() end
ddump=function() end
local print=function() end
--@end-non-debug@
local LE_FOLLOWER_TYPE_GARRISON_7_0=LE_FOLLOWER_TYPE_GARRISON_7_0
local LE_GARRISON_TYPE_7_0=LE_GARRISON_TYPE_7_0
local GARRISON_FOLLOWER_COMBAT_ALLY=GARRISON_FOLLOWER_COMBAT_ALLY
local GARRISON_FOLLOWER_ON_MISSION=GARRISON_FOLLOWER_ON_MISSION
local GARRISON_FOLLOWER_INACTIVE=GARRISON_FOLLOWER_INACTIVE
local ViragDevTool_AddData=_G.ViragDevTool_AddData
if not ViragDevTool_AddData then ViragDevTool_AddData=function() end end
local KEY_BUTTON1 = "\124TInterface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:228:283\124t" -- left mouse button
local KEY_BUTTON2 = "\124TInterface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:330:385\124t" -- right mouse button
local CTRL_KEY_TEXT,SHIFT_KEY_TEXT=CTRL_KEY_TEXT,SHIFT_KEY_TEXT
local CTRL_KEY_TEXT,SHIFT_KEY_TEXT=CTRL_KEY_TEXT,SHIFT_KEY_TEXT
local CTRL_SHIFT_KET_TEXT=CTRL_KEY_TEXT .. '-' ..SHIFT_KEY_TEXT
local format,pcall=format,pcall
local function safeformat(mask,...)
  local rc,result=pcall(format,mask,...)
  if not rc then
    for k,v in pairs(L) do
      if v==mask then
        mask=k
        break
      end
    end
 end
  rc,result=pcall(format,mask,...)
  return rc and result or mask 
end

-- End Template - DO NOT MODIFY ANYTHING BEFORE THIS LINE
--*BEGIN
local fake={}
local data={
	ArtifactNotes={
		146745
	},
	U850={
		136412,
		137207,
		137208,

	},
	U880={
		153005,
	},
	U900={
    147348,
    147349,
    147350,
    151842,
	},
	U925={
	 151843
	},
	U950={
		151844,
	},
	Buffs={
		140749,
		143852,
		139419,
		140760,
		140156,
		139428,
		143605,
		139177,
		139420,
		138883,
		139376,
		139418,
		138412,
		140922,
		139670,
		148349,
		148350,
		142209,
	},
	Xp={
		141028
	},
	Krokuls={
	 152095,
   152096,
   152097,
	},
	Equipments={}
}
local icon2item={}
local itemquality={}
function addon:GetData(key)
	key=key or "none"
	return data[key] or fake
end
local tickle
function module:OnInitialized()
  data.Equipments=addon.allEquipments
	--[===[@debug@
	addon:Print("Starting coroutine")
	--@end-debug@]===]
	addon.coroutineExecute(module,0.1,"TickleServer")
end
local GetItemIcon=GetItemIcon
local GetItemInfo=GetItemInfo
local pcall=pcall
function module:AddItem(itemID)

end
function addon:GetItemIdByIcon(iconid)
  if not icon2item[iconid] then icon2item[iconid] = select(2,pcall,GetItemIcon,iconid) end 
	return icon2item[iconid]
end
function addon:GetItemQuality(itemid)
  if not itemquality[itemid] then itemquality[itemid] = select(4,pcall,GetItemInfo,itemid) end
	return itemquality[itemid]
end

do
  local pairs=pairs
  local type=type
  local GetItemIcon=GetItemIcon
  local GetItemInfo=GetItemInfo
  local coroutine=coroutine
  local pcall=pcall
  local i=0
  local debugprofilestop=debugprofilestop
  local start=0
  local function tickle(category,useleft)
    for left,right in pairs(category) do
      local itemid=useleft and left or right
  		if type(itemid)=="number" and itemid > 10 then
  			if not itemquality[itemid] then
  				local rc,name,link,quality=pcall(GetItemInfo,itemid)
  				if rc and name then
  					itemquality[itemid]=quality
  					icon2item[GetItemIcon(itemid)]=itemid
  					i=i+1
  --[===[@debug@
  					if i % 100 == 0 then
  						addon:Print(format("Precached %d items in %.3f so far",i,(debugprofilestop()-start)))
  					end
  --@end-debug@]===]
  				end
  				if coroutine.running() then coroutine.yield() end
  			end
  		end
  	end
  end
  function module:TickleServer()
  	start=debugprofilestop()
  	tickle(data.Equipments)
    tickle(addon.allArtifactPower,true)
  	--[===[@debug@
  	addon:Print(format("Precached %d items in %.3f seconds",i,(debugprofilestop()-start)/1000))
  	--@end-debug@]===]
  end
end
