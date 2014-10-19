--------------------------------------------------------------------
-- System Stats
--------------------------------------------------------------------
local addon, ns = ...
local cfg = ns.cfg
local init = ns.init
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.System == true then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)

	local Text  = panel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(unpack(cfg.Fonts))
	Text:SetPoint(unpack(cfg.SystemPoint))

	local function colorlatency(latency)
		if latency < 300 then
			return "|cff0CD809"..latency
		elseif (latency >= 300 and latency < 500) then
			return "|cffE8DA0F"..latency
		else
			return "|cffD80909"..latency
		end
	end
	local int = 1
	local function Update(self, t)
		int = int - t
		local fpscolor
		local latencycolor

		if int < 0 then
			local _, _, latencyHome, latencyWorld = GetNetStats()
			lat = math.max(latencyHome, latencyWorld)
			if floor(GetFramerate()) >= 30 then
				fpscolor = "|cff0CD809"
			elseif (floor(GetFramerate()) > 15 and floor(GetFramerate()) < 30) then
				fpscolor = "|cffE8DA0F"
			else
				fpscolor = "|cffD80909"
			end
			Text:SetText(fpscolor..floor(GetFramerate()).."|r".."fps "..colorlatency(lat).."|r".."ms")
			int = 0.8
		end
	end
	local Total, Cpuu, Cput
	local function RefreshCput(self)
		Cput = {}
		UpdateAddOnCPUUsage()
		Total = 0
		for i = 1, GetNumAddOns() do
			Cpuu = GetAddOnCPUUsage(i)
			Cput[i] = { select(2, GetAddOnInfo(i)), Cpuu, IsAddOnLoaded(i) }
			Total = Total + Cpuu
		end

		table.sort(Cput, function(a, b)
			if a and b then
				return a[2] > b[2]
			end
		end)
	end

	Stat:SetAllPoints(Text)
	Stat:SetScript("OnEnter", function(self)
		RefreshCput(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6);
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(infoL["System"],0,.6,1)
		GameTooltip:AddLine(" ")
		if IsShiftKeyDown() then
			maxAddOns = #Cput
		else
			maxAddOns = math.min(cfg.MaxAddOns, #Cput)
		end

		if GetCVar("scriptProfile") == "1" then
			for i = 1, maxAddOns do
				if Cput[i][3] then
					local color = Cput[i][2]/Total*100 <= 1 and {0,1} -- 0 - 1
					or Cput[i][2]/Total*100 <= 5 and {0.75,1} -- 1 - 5
					or Cput[i][2]/Total*100 <= 10 and {1,1} -- 5 - 10
					or Cput[i][2]/Total*100 <= 25 and {1,0.75} -- 10 - 25
					or Cput[i][2]/Total*100 <= 50 and {1,0.5} -- 25 - 50
					or {1,0.1} -- 50 +
					GameTooltip:AddDoubleLine(Cput[i][1], format("%.2f%s", Cput[i][2]/Total*100," %"), 1, 1, 1, color[1], color[2], 0)						
				end
			end
			local more, moreCpuu = 0, 0
			if not IsShiftKeyDown() then
				for i = (cfg.MaxAddOns + 1), #Cput do
					if Cput[i][3] then
						more = more + 1
						moreCpuu = moreCpuu + Cput[i][2]
					end
				end
				GameTooltip:AddDoubleLine(format("%d %s (%s)",more,infoL["Hidden"],infoL["Shift"]),format("%.2f%s",moreCpuu/Total*100," %"),.6,.8,1,.6,.8,1)
			end
			GameTooltip:AddLine(" ")
		end
		--GameTooltip:AddLine(infoL["Latency"]..":",.6, .8, 1)
		local _, _, latencyHome, latencyWorld = GetNetStats()
		--GameTooltip:AddDoubleLine(infoL["Home"]..":", format("%s%s",colorlatency(latencyHome).."|r","ms"), 1 , 1, 1, 1, 1, 1)
		--GameTooltip:AddDoubleLine(CHANNEL_CATEGORY_WORLD..":", format("%s%s",colorlatency(latencyWorld).."|r","ms"), 1 , 1, 1, 1, 1, 1)
		--GameTooltip:AddDoubleLine(infoL["Home"].."/"..CHANNEL_CATEGORY_WORLD..":",format("%s%s/%s%s",colorlatency(latencyHome).."|r","ms",colorlatency(latencyWorld).."|r","ms"), 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(infoL["Latency"]..":",format("%s%s(%s)/%s%s(%s)",colorlatency(latencyHome).."|r","ms",infoL["Home"],colorlatency(latencyWorld).."|r","ms",CHANNEL_CATEGORY_WORLD),.6, .8, 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnMouseDown", function(self,btn)
		if btn == "RightButton" then
			if GetCVar("scriptProfile") == "0" then SetCVar("scriptProfile", 1) print(infoL["Reload UI(on)"]) else SetCVar("scriptProfile", 0) print(infoL["Reload UI(off)"]) end
		end
		ResetCPUUsage()
		RefreshCput(self)
		self:GetScript("OnEnter")(self)
	end)
	Stat:SetScript("OnUpdate", Update) 
end