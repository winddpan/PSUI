local addon, ns = ...
local lib = ns.lib
local _G = _G

local screenwidth = string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x%d+")
local screenhigh = string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
local bordercolor = {0,0,0,.95}
local mainfont = "Fonts\\ARIALN.TTF"
----------------------------------------------------------------------------------------------------------------------------
------	create panels
----------------------------------------------------------------------------------------------------------------------------	(UIParent:GetWidth()/UIParent:GetScale())

------- Bottompanel
lib.Createpanel("Bottompanel",UIParent:GetWidth()+6,22,UIParent,"medium",nil,3,bordercolor,{0,0,0,.67}) 
Bottompanel:SetFrameLevel(0)
Bottompanel:SetPoint("BOTTOM",UIParent,"BOTTOM", 0, -3)

-------- Chat
lib.Createpanel("ChatPanel",368,150,UIParent,"BACKGROUND",nil,3,bordercolor,{0,0,0,.77}) 
ChatPanel:SetFrameLevel(0)
ChatPanel:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT", 7, 17)

--------- DamageMeter
lib.Createpanel("rightPanel2",250,150,UIParent,"BACKGROUND",nil,3,bordercolor,{0,0,0,.5}) 
rightPanel2:SetFrameLevel(0)
--rightPanel2:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT", -137, 17)
rightPanel2:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT", -7, 17)

--------- extraActionbar
--[[
lib.Createpanel("rightPanel",125,154,UIParent,"BACKGROUND",nil,3,bordercolor,{0,0,0,.5}) 
rightPanel:SetFrameLevel(1)
rightPanel:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT", -7, 17)
]]

--------- ChatButtonControl Button
lib.Createpanel("L1",60,16,Bottompanel,"HIGH",nil,3,bordercolor,{0,0,0,.1}) 
L1:SetPoint("BOTTOMLEFT",Bottompanel,"BOTTOMLEFT", 10, 3)
L1:SetFrameLevel(11)
local fs = L1:CreateFontString(nil, "OVERLAY")
		fs:SetFont(mainfont, 13, "THINOUTLINE")
		fs:SetPoint("CENTER", L1, "CENTER",0,0)
		fs:SetText("|cff8AFF30<<|r")
lib.CreateButton(L1,ChatPanel,"Down",bordercolor)

-------- extraActionbarControl Button
--[[
lib.Createpanel("R1",60,16,Bottompanel,"HIGH",nil,3,bordercolor,{0,0,0,.1}) 
R1:SetPoint("BOTTOMRIGHT",Bottompanel,"BOTTOMRIGHT", -10, 3)
local fs = R1:CreateFontString(nil, "OVERLAY")
		fs:SetFont(mainfont, 13, "THINOUTLINE")
		fs:SetPoint("CENTER", R1, "CENTER",0,0)
		fs:SetText("|cff8AFF30>>|r")
lib.CreateButton(R1,rightPanel,"Down",nil,true) 
]]

--------- DamageMeterControl Button
lib.Createpanel("R2",60,16,Bottompanel,"HIGH",nil,3,bordercolor,{0,0,0,.1}) 
R2:SetPoint("BOTTOMRIGHT",Bottompanel,"BOTTOMRIGHT", -10, 3)
R2:SetFrameLevel(11)
local fs = R2:CreateFontString(nil, "OVERLAY")
		fs:SetFont(mainfont, 13, "THINOUTLINE")
		fs:SetPoint("CENTER", R2, "CENTER",0,0)
		fs:SetText("|cff8AFF30>>|r")
lib.CreateButton(R2,rightPanel2,"Down") 

----------------------------------------------------------------------------------------------------------------------------
------	init panels when login
----------------------------------------------------------------------------------------------------------------------------
local function EditBoxConfig()

	--隐藏状态输入文字自动弹出输入框
	for i=1, NUM_CHAT_WINDOWS do 
		local cf = _G[format("%s%d%s", "ChatFrame", i, "EditBox")]
		cf:EnableMouse(false)
		hooksecurefunc(cf, "SetFocus", function(self)
			cf:EnableMouse(true)
			if not lib.isFrameInScreen(ChatPanel) then
				lib.movefunc(ChatPanel)
			end
		end)
		hooksecurefunc(cf, "ClearFocus", function(self)
			cf:EnableMouse(false)
		end)
	end
	
	--显示状态隐藏自动关闭输入框
	L1:HookScript("OnMouseUp",function(self)
		if lib.isFrameInScreen(ChatPanel) then
			for i=1, NUM_CHAT_WINDOWS do 
				local cf = _G[format("%s%d%s", "ChatFrame", i, "EditBox")]
				if cf:HasFocus() then  cf:ClearFocus() end
			end
		end 
	end)
	
end

local f = CreateFrame("Frame")
local login = function()
	if lib.isFrameInScreen(rightPanel2) then
		lib.movefunc(rightPanel2, "Down", false, false)
	end
	
	FCF_SetLocked(ChatFrame1, nil)
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMLEFT",ChatPanel ,"BOTTOMLEFT",5,5)
	ChatFrame1:SetWidth(358)
	ChatFrame1:SetHeight(ChatPanel:GetHeight() -8)
	ChatFrame1:SetFrameLevel(0)

	for i=1, 10 do 
		  local cf = _G[format("%s%d", "ChatFrame", i)] 
		  cf:SetClampedToScreen(false) 
		  cf:SetClampRectInsets(0,0,0,0) 
	end 
	ChatFrame1:SetUserPlaced(true)
	FCF_SavePositionAndDimensions(ChatFrame1)
	FCF_SetLocked(ChatFrame1, 1)
	
	EditBoxConfig()
	ShowHelp()
	Bottompanel:SetWidth(UIParent:GetWidth()+6)
end
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function() login() end)

----------------------------------------------------------------------------------------------------------------------------
-------  whisper alert func
----------------------------------------------------------------------------------------------------------------------------
local function CheckWhisperWindows(self, event)
		local chat = self:GetName()
		if chat == "ChatFrame1" and not lib.isFrameInScreen(ChatPanel) then 
			if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_BN_WHISPER" then
				L1:SetBackdropBorderColor(1,1,1)
			end
		end	
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", CheckWhisperWindows)	
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", CheckWhisperWindows)