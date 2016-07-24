local addon, ns = ...
local cfg = ns.cfg
local init = ns.init
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.Bags == true then
    local Stat = CreateFrame("Frame")
    Stat:EnableMouse(true)

    local Text  = panel:CreateFontString(nil, "OVERLAY")
    Text:SetFont(unpack(cfg.Fonts))
    Text:SetPoint(unpack(cfg.BagsPoint))

	local function OnEvent(self, event, ...)
		if (diminfo.AutoSell == nil) then diminfo.AutoSell = true end
		local free, total, used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
		end
		used = total - free
		Text:SetText(cfg.ColorClass and "Bags: "..init.Colored..free or "Bags:"..free)
		self:SetAllPoints(Text)
		Stat:SetScript("OnEnter", function()

			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6);
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(infoL["Bags"],0,.6,1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(infoL["Total"]..":",total,.6,.8,1, 1, 1, 1)
			GameTooltip:AddDoubleLine(infoL["Used"]..":",used,.6,.8,1, 1, 1, 1)
			GameTooltip:AddDoubleLine(" ","--------------",1,1,1,0.5,0.5,0.5)
			GameTooltip:AddDoubleLine(" ",infoL["AutoSell junk"]..": "..(diminfo.AutoSell and "|cff55ff55"..infoL["ON"] or "|cffff5555"..strupper(OFF)),1,1,1,.6,.8,1)
			GameTooltip:Show()
		end)
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
          
    Stat:RegisterEvent("PLAYER_LOGIN")
    Stat:RegisterEvent("BAG_UPDATE")
    Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function(self,button)
		if button == "RightButton" then
			diminfo.AutoSell = not diminfo.AutoSell
			self:GetScript("OnEnter")(self)	
		else
			ToggleAllBags()
		end
	end)

	local f = CreateFrame("Frame")
	f:SetScript("OnEvent", function()
		if diminfo.AutoSell == true then
			local c = 0
			for b = 0, 4 do
				for s = 1, GetContainerNumSlots(b) do
					local l = GetContainerItemLink(b, s)
					if l then
						local p = select(11, GetItemInfo(l)) * select(2, GetContainerItemInfo(b, s))
						if select(3, GetItemInfo(l)) == 0 and p > 0 then
							UseContainerItem(b, s)
							PickupMerchantItem()
							c = c + p
						end
					end
				end
			end
			if c > 0 then
				print(format("|cff99CCFF"..infoL["Your vendor trash has been sold and you earned"].."|r|cffFFFFFF%.1f|r|cffffd700%s|r", c * 0.0001,GOLD_AMOUNT_SYMBOL))
			end
		end
	end)
	f:RegisterEvent("MERCHANT_SHOW")
end