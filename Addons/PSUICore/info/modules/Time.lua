--------------------------------------------------------------------
-- TIME
--------------------------------------------------------------------
local addon, ns = ...
local cfg = ns.cfg
local init = ns.init
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.Time == true then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = panel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(unpack(cfg.Fonts))
	Text:SetPoint(unpack(cfg.TimePoint))

	local int = 1
	local function Update(self, t)
		local pendingCalendarInvites = CalendarGetNumPendingInvites()
		int = int - t
		if int < 0 then
			if GetCVar("timeMgrUseLocalTime") == "1" then
				Hr24 = tonumber(date("%H"))
				Hr = tonumber(date("%I"))
				Min = date("%M")
				if GetCVar("timeMgrUseMilitaryTime") == "1" then
					if pendingCalendarInvites > 0 then
					Text:SetText("|cffFF0000"..Hr24..":"..Min)
				else
					Text:SetText(Hr24..":"..Min)
				end
			else
				if Hr24>=12 then
					if pendingCalendarInvites > 0 then
						Text:SetText(cfg.ColorClass and "|cffFF0000"..Hr..":"..Min..init.Colored.."pm|r" or "|cffFF0000"..Hr..":"..Min.."|cffffffffpm|r")
					else
						Text:SetText(cfg.ColorClass and Hr..":"..Min..init.Colored.."pm|r" or Hr..":"..Min.."|cffffffffpm|r")
					end
				else
					if pendingCalendarInvites > 0 then
						Text:SetText(cfg.ColorClass and "|cffFF0000"..Hr..":"..Min..init.Colored.."am|r" or "|cffFF0000"..Hr..":"..Min.."|cffffffffam|r")
					else
						Text:SetText(cfg.ColorClass and Hr..":"..Min..init.Colored.."am|r" or Hr..":"..Min.."|cffffffffam|r")
					end
				end
			end
		else
			local Hr, Min = GetGameTime()
			if Min<10 then Min = "0"..Min end
			if GetCVar("timeMgrUseMilitaryTime") == "1" then
				if pendingCalendarInvites > 0 then			
					Text:SetText("|cffFF0000"..Hr..":"..Min.."|cffffffff|r")
				else
					Text:SetText(Hr..":"..Min.."|cffffffff|r")
				end
			else
				if Hr>=12 then
					if Hr>12 then Hr = Hr-12 end
					if pendingCalendarInvites > 0 then
						Text:SetText(cfg.ColorClass and "|cffFF0000"..Hr..":"..Min..init.Colored.."pm|r" or "|cffFF0000"..Hr..":"..Min.."|cffffffffpm|r")
					else
						Text:SetText(cfg.ColorClass and Hr..":"..Min..init.Colored.."pm|r" or Hr..":"..Min.."|cffffffffpm|r")
					end
				else
					if Hr == 0 then Hr = 12 end
					if pendingCalendarInvites > 0 then
						Text:SetText(cfg.ColorClass and "|cffFF0000"..Hr..":"..Min..init.Colored.."am|r" or "|cffFF0000"..Hr..":"..Min.."|cffffffffam|r")
					else
						Text:SetText(cfg.ColorClass and Hr..":"..Min..init.Colored.."am|r" or Hr..":"..Min.."|cffffffffam|r")
					end
				end
			end
		end
		self:SetAllPoints(Text)
		int = 1
		end
	end
	
	local function zsub(s,...) local t={...} for i=1,#t,2 do s=gsub(s,t[i],t[i+1]) end return s end

	Stat:SetScript("OnEnter", function(self)
		OnLoad = function(self) RequestRaidInfo() end
		
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, -10)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(date'%A, %B %d',0,.6,1)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(gsub(TIMEMANAGER_TOOLTIP_LOCALTIME,':',''),zsub(GameTime_GetLocalTime(true),'%s*AM','am','%s*PM','pm'),.6,.8,1,1,1,1)
		GameTooltip:AddDoubleLine(gsub(TIMEMANAGER_TOOLTIP_REALMTIME,':',''),zsub(GameTime_GetGameTime(true),'%s*AM','am','%s*PM','pm'),.6,.8,1,1,1,1)
		GameTooltip:AddLine(" ")
		local pvp = GetNumWorldPVPAreas()
		for i=1, pvp do
			local timeleft = select(5, GetWorldPVPAreaInfo(i))
			local name = select(2, GetWorldPVPAreaInfo(i))
			local inprogress = select(3, GetWorldPVPAreaInfo(i))
			local inInstance, instanceType = IsInInstance()
			if not ( instanceType == "none" ) then
				timeleft = QUEUE_TIME_UNAVAILABLE
			elseif inprogress then
				timeleft = WINTERGRASP_IN_PROGRESS
			else
				local hour = tonumber(format("%01.f", floor(timeleft/3600)))
				local min = format(hour>0 and "%02.f" or "%01.f", floor(timeleft/60 - (hour*60)))
				local sec = format("%02.f", floor(timeleft - hour*3600 - min *60)) 
				timeleft = (hour>0 and hour..":" or "")..min..":"..sec
			end
			GameTooltip:AddDoubleLine(name,timeleft,.6,.8,1,1,1,1)
		end

		Hr = tonumber(date("%I"))
		Min = date("%M")
		
		local oneraid
		for i = 1, GetNumSavedInstances() do
			local name,_,reset,difficulty,locked,extended,_,isRaid,maxPlayers = GetSavedInstanceInfo(i)
			--if isRaid and (locked or extended) then
			if (locked or extended) then
				local tr,tg,tb,diff
				if not oneraid then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(RAID_INFO,.6,.8,1)
					oneraid = true
				end

				local function fmttime(sec,table)
				local table = table or {}
				local d,h,m,s = ChatFrame_TimeBreakDown(floor(sec))
				local string = gsub(gsub(format(" %dd %dh %dm "..((d==0 and h==0) and "%ds" or ""),d,h,m,s)," 0[dhms]"," "),"%s+"," ")
				local string = strtrim(gsub(string, "([dhms])", {d=table.days or "d",h=table.hours or "h",m=table.minutes or "m",s=table.seconds or "s"})," ")
				return strmatch(string,"^%s*$") and "0"..(table.seconds or "s") or string
			end
			if extended then tr,tg,tb = 0.3,1,0.3 else tr,tg,tb = 1,1,1 end
			if difficulty == 3 or difficulty == 4 then diff = "H" else diff = "N" end
			GameTooltip:AddDoubleLine(name,fmttime(reset),1,1,1,tr,tg,tb)
			end
		end
		local killbossnum = GetNumSavedWorldBosses()
		GameTooltip:AddLine(" ")
		if killbossnum == 0 then
			GameTooltip:AddLine("本周還未擊殺世界首領", 1, 0.1, 0.1)
		else
			--GameTooltip:AddDoubleLine("您已经击杀的野外boss", "下次重置时间", 1, 1, 1, 1, 1, 1)
			for i=1, killbossnum do
				local name, _, reset = GetSavedWorldBossInfo(i)
				GameTooltip:AddDoubleLine(name,"已擊殺", 1, 1, 1,tr,tg,tb)
			end
		end
		GameTooltip:Show()
	end)
	
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnUpdate", Update)
	Stat:RegisterEvent("UPDATE_INSTANCE_INFO")
	Stat:SetScript("OnMouseDown", function(self, btn)
		if btn == 'RightButton'  then
			ToggleTimeManager()
		else
			GameTimeFrame:Click()
		end
	end)
	Update(Stat, 10)
end