--------------------------------------------------------------------
-- Memory Stats
--------------------------------------------------------------------
local addon, ns = ...
local cfg = ns.cfg
local init = ns.init
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.Memory == true then

	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)
	
	local Text  = panel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(unpack(cfg.Fonts))
	Text:SetPoint(unpack(cfg.MemoryPoint))
	Stat:SetAllPoints(Text)

	local colorme = string.format("%02x%02x%02x", 1*255, 1*255, 1*255)

	local function formatMem(memory, color)
		if color then
			statColor = { "|cff"..colorme, "|r" }
		else
			statColor = { "", "" }
		end
		
		local mult = 10^1
		if memory > 999 then
			local mem = floor((memory/1024) * mult + 0.5) / mult
			if mem % 1 == 0 then
				return mem..string.format(".0 %smb%s", unpack(statColor))
			else
				return mem..string.format(" %smb%s", unpack(statColor))
			end
		else
			local mem = floor(memory * mult + 0.5) / mult
				if mem % 1 == 0 then
					return mem..string.format(".0 %skb%s", unpack(statColor))
				else
					return mem..string.format(" %skb%s", unpack(statColor))
				end
		end

	end

	local Total, Mem, MEMORY_TEXT, Memory
	local function RefreshMem(self)
		Memory = {}
		UpdateAddOnMemoryUsage()
		Total = 0
		for i = 1, GetNumAddOns() do
			Mem = GetAddOnMemoryUsage(i)
			Memory[i] = { select(2, GetAddOnInfo(i)), Mem, IsAddOnLoaded(i) }
			Total = Total + Mem
		end
		
		MEMORY_TEXT = formatMem(Total, true)
		table.sort(Memory, function(a, b)
			if a and b then
				return a[2] > b[2]
			end
		end)
	end
	
	local function RefreshText()
		UpdateAddOnMemoryUsage()
		tTotal = 0
		for i = 1, GetNumAddOns() do
			tMem = GetAddOnMemoryUsage(i)
			tTotal = tTotal + tMem
		end
	end
	
	local function formatTotal(Total)
		if Total >= 1024 then
			return format(cfg.ColorClass and "%.1f"..init.Colored.."mb|r" or "%.1fmb", Total / 1024)
		else
			return format(cfg.ColorClass and "%.1f"..init.Colored.."kb|r" or "%.1fkb", Total)
		end
	end

	local int = 5
	local function Update(self, t)
		int = int - t
		if int < 0 then
			RefreshText()
			int = 5
		end
		Text:SetText(formatTotal(tTotal))
	end


	if diminfo.AutoCollect == nil then diminfo.AutoCollect = true end

	Stat:SetScript("OnMouseDown", function(self,btn)
		if btn == "LeftButton" then
			RefreshMem(self)
			local before = gcinfo()
			collectgarbage("collect")
			RefreshMem(self)
			print(format("|cff66C6FF%s:|r %s",infoL["Garbage collected"],formatMem(before - gcinfo())))
		elseif btn == "RightButton" then
			diminfo.AutoCollect = not diminfo.AutoCollect
		end
		self:GetScript("OnEnter")(self)
		RefreshText()
	end)

	Stat:SetScript("OnEnter", function(self)
			RefreshMem(self)
		
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 10);
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
			GameTooltip:ClearLines()
			local _, _, latencyHome, latencyWorld = GetNetStats()
			GameTooltip:AddDoubleLine(format("%s:",ADDONS),formatMem(Total), 0, 0.6, 1, 1, 1, 1)
			GameTooltip:AddLine(" ")
			if IsShiftKeyDown() then
				maxAddOns = #Memory
			else
				maxAddOns = math.min(cfg.MaxAddOns, #Memory)
			end

			for i = 1, maxAddOns do
				if Memory[i][3] then
					local color = Memory[i][2] <= 102.4 and {0,1} -- 0 - 100
					or Memory[i][2] <= 512 and {0.75,1} -- 100 - 512
					or Memory[i][2] <= 1024 and {1,1} -- 512 - 1mb
					or Memory[i][2] <= 2560 and {1,0.75} -- 1mb - 2.5mb
					or Memory[i][2] <= 5120 and {1,0.5} -- 2.5mb - 5mb
					or {1,0.1} -- 5mb +
					GameTooltip:AddDoubleLine(Memory[i][1], formatMem(Memory[i][2], false), 1, 1, 1, color[1], color[2], 0)						
				end
			end

			local more = 0
			local moreMem = 0
			if not IsShiftKeyDown() then
				for i = (cfg.MaxAddOns + 1), #Memory do
					if Memory[i][3] then
						more = more + 1
						moreMem = moreMem + Memory[i][2]
					end
				end
				GameTooltip:AddDoubleLine(format("%d %s (%s)",more,infoL["Hidden"],infoL["Shift"]),formatMem(moreMem),.6,.8,1,.6,.8,1)
			end

			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(infoL["Default UI Memory Usage:"],formatMem(gcinfo() - Total),.6,.8,1,1,1,1)
			GameTooltip:AddDoubleLine(infoL["Total Memory Usage:"],formatMem(collectgarbage'count'),.6,.8,1,1,1,1)
			--GameTooltip:AddDoubleLine(" ","--------------",1,1,1,0.5,0.5,0.5)
			--GameTooltip:AddDoubleLine(" ",infoL["AutoCollect"]..": "..(diminfo.AutoCollect and "|cff55ff55"..infoL["ON"] or "|cffff5555"..strupper(OFF)),1,1,1,.4,.78,1)
			GameTooltip:Show()
	end)

	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 20)
	
	--[[
	--自动回收内存
	local eventcount = 0
	local a = CreateFrame("Frame")
	a:RegisterAllEvents()
	a:SetScript("OnEvent", function(self, event)
		if diminfo.AutoCollect == true then
			eventcount = eventcount + 1
			if InCombatLockdown() then return end
			if eventcount > 6000 or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_REGEN_ENABLED" then
				collectgarbage("collect")
				eventcount = 0
			end
		end
	end)]]
end