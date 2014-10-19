--[[
Author: Affli@RU-Howling Fjord, 
Modified: Loshine
All rights reserved.
]]--

local DBMskin = true

if DBMskin then

local DBMSkin = CreateFrame("Frame")
DBMSkin:RegisterEvent("PLAYER_LOGIN")
DBMSkin:SetScript("OnEvent", function()
	
	if IsAddOnLoaded("DBM-Core") then

		local croprwicons = true			-- crops blizz shitty borders from icons in RaidWarning messages
		local rwiconsize = 18			-- RaidWarning icon size, because 12 is small for me. Works only if croprwicons=true
		local buttonsize = 25

		local function CreateShadow(self)
		self.shadow = CreateFrame("Frame", nil, self)
		self.shadow:SetFrameLevel(1)
		self.shadow:SetFrameStrata(self:GetFrameStrata())
		self.shadow:SetPoint("TOPLEFT", -2, 2)
		self.shadow:SetPoint("BOTTOMRIGHT", 2, -2)
		self.shadow:SetBackdrop({
			edgeFile = "Interface\\addons\\PSUICore\\media\\glow", 
			edgeSize = 4,
			insets = { left = 3, right = 3, top = 3, bottom = 3 }
		})
		self.shadow:SetBackdropBorderColor(0,0,0)
		end

		local function CreateBorder(self)
		self.Border = CreateFrame("Frame", nil, self)
		self.Border:SetPoint("TOPLEFT", 1, -1)
		self.Border:SetPoint("BOTTOMRIGHT", -1, 1)
		self.Border:SetBackdrop({ 
			edgeFile = "Interface\\Buttons\\WHITE8x8" , edgeSize = 2,
		})
		self.Border:SetBackdropBorderColor(41.0/255, 128.0/255, 176.0/255,1)  --BELIZEHOLE
		self.Border:SetFrameLevel(0)
		end

		local function SkinBars(self)
			for bar in self:GetBarIterator() do
				if not bar.injected then
						bar.ApplyStyle=function()
						local frame = bar.frame
						local tbar = _G[frame:GetName().."Bar"]
						local spark = _G[frame:GetName().."BarSpark"]
						local texture = _G[frame:GetName().."BarTexture"]
						local icon1 = _G[frame:GetName().."BarIcon1"]
						local icon2 = _G[frame:GetName().."BarIcon2"]
						local name = _G[frame:GetName().."BarName"]
						local timer = _G[frame:GetName().."BarTimer"]
				
						if not (icon1.overlay) then
							icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
							--icon1.overlay:CreatePanel(template, buttonsize+2, buttonsize+2, "BOTTOMRIGHT", tbar, "BOTTOMLEFT", -buttonsize/4, -3)
							icon1.overlay:SetFrameLevel(1)
							icon1.overlay:SetSize(buttonsize+2, buttonsize+2)
							icon1.overlay:SetFrameStrata("BACKGROUND")
							icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -buttonsize/4+2, -3)
					
							local backdroptex = icon1.overlay:CreateTexture(nil, "BORDER")
							backdroptex:SetTexture([=[Interface\Icons\Spell_Nature_WispSplode]=])
							backdroptex:SetPoint("TOPLEFT", icon1.overlay, "TOPLEFT", 3, -3)
							backdroptex:SetPoint("BOTTOMRIGHT", icon1.overlay, "BOTTOMRIGHT", -3, 3)
							backdroptex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
							CreateBorder(icon1.overlay)
							CreateShadow(icon1.overlay)
						end

						if not (icon2.overlay) then
							icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
							--icon2.overlay:CreatePanel(template, buttonsize+2, buttonsize+2, "BOTTOMLEFT", tbar, "BOTTOMRIGHT", buttonsize/4, -3)
							icon2.overlay:SetFrameLevel(1)
							icon2.overlay:SetSize(buttonsize+2, buttonsize+2)
							icon2.overlay:SetFrameStrata("BACKGROUND")
							icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", buttonsize/4+2, -3)
					
							local backdroptex = icon2.overlay:CreateTexture(nil, "BORDER")
							backdroptex:SetTexture([=[Interface\Icons\Spell_Nature_WispSplode]=])
							backdroptex:SetPoint("TOPLEFT", icon2.overlay, "TOPLEFT", 3, -3)
							backdroptex:SetPoint("BOTTOMRIGHT", icon2.overlay, "BOTTOMRIGHT", -3, 3)
							backdroptex:SetTexCoord(0.08, 0.92, 0.08, 0.92)		
							CreateBorder(icon2.overlay)
							CreateShadow(icon2.overlay)
						end

						if bar.color then
							tbar:SetStatusBarColor(bar.color.r, bar.color.g, bar.color.b)
						else
							tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
						end
				
						if bar.enlarged then frame:SetWidth(bar.owner.options.HugeWidth) else frame:SetWidth(bar.owner.options.Width) end
						if bar.enlarged then tbar:SetWidth(bar.owner.options.HugeWidth) else tbar:SetWidth(bar.owner.options.Width) end
		
						if not frame.styled then
							frame:SetScale(1)
							frame.SetScale = function() return end
							frame:SetHeight(buttonsize/2)
							if not frame.bg then
								frame.bg = CreateFrame("Frame", nil, frame)
								frame.bg:SetPoint("TOPLEFT", 0, 0)
								frame.bg:SetPoint("BOTTOMRIGHT", 0, 0)
								
								local texture = frame.bg:CreateTexture()
								texture:ClearAllPoints()
								texture:SetPoint("TOPLEFT", 2, -2)
								texture:SetPoint("BOTTOMRIGHT", -2, 2)
								texture:SetTexture(46.0/255, 204.0/255, 112.0/255,0.2)
								frame.bg.texture = texture
							end
							CreateShadow(frame.bg)
							frame.styled=true
						end

						if not spark.killed then
							spark:SetAlpha(0)
							spark:SetTexture(nil)
							spark.killed=true
						end
	
						if not icon1.styled then
							icon1:SetTexCoord(0.08, 0.92, 0.08, 0.92)
							icon1:ClearAllPoints()
							icon1:SetPoint("TOPLEFT", icon1.overlay, 3, -3)
							icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, -3, 3)
							icon1.styled=true
						end
				
						if not icon2.styled then
							icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
							icon2:ClearAllPoints()
							icon2:SetPoint("TOPLEFT", icon2.overlay, 3, -3)
							icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, -3, 3)
							icon2.styled=true
						end

						if not texture.styled then
							texture:SetTexture("Interface\\AddOns\\PSUICore\\media\\statusbar")
							texture.styled=true
						end
						texture:SetTexture("Interface\\AddOns\\PSUICore\\media\\statusbar")
				
						if not tbar.styled then
							tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
							tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
							tbar.styled=true
						end

						if not name.styled then
							name:ClearAllPoints()
							name:SetPoint("LEFT", frame, "LEFT", 4, 9)
							name:SetWidth(165)
							name:SetHeight(8)
							name:SetFont(GameTooltipText:GetFont(), 14, "THINOUTLINE")
							name:SetJustifyH("LEFT")
							name:SetShadowColor(0, 0, 0, 0)
							name.SetFont = function() return end
							name.styled=true
						end
				
						if not timer.styled then	
							timer:ClearAllPoints()
							timer:SetPoint("RIGHT", frame, "RIGHT", -4, 9)
							timer:SetFont(GameTooltipText:GetFont(), 14, "THINOUTLINE")
							timer:SetJustifyH("RIGHT")
							timer:SetShadowColor(0, 0, 0, 0)
							timer.SetFont = function() return end
							timer.styled=true
						end

						if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
						if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
						tbar:SetAlpha(1)
						frame:SetAlpha(1)
						texture:SetAlpha(1)
						frame:Show()
						bar:Update(0)
						bar.injected=true
					end
					bar:ApplyStyle()
				end
			end
		end
 
		local SkinBossTitle=function()
			local anchor=DBMBossHealthDropdown:GetParent()
			if not anchor.styled then
				local header={anchor:GetRegions()}
					if header[1]:IsObjectType("FontString") then
						header[1]:SetFont(GameTooltipText:GetFont(), 14, "THINOUTLINE")
						header[1]:SetTextColor(1,1,1,1)
						header[1]:SetShadowColor(0, 0, 0, 0)
						anchor.styled=true	
					end
				header=nil
			end
			anchor=nil
		end

		local SkinBoss=function()
			local count = 1
			while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
			
				local barHeight = buttonsize *2/3 
				local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
				local background = _G[bar:GetName().."BarBorder"]
				local progress = _G[bar:GetName().."Bar"]
				local name = _G[bar:GetName().."BarName"]
				local timer = _G[bar:GetName().."BarTimer"]
				local prev = _G[format("DBM_BossHealth_Bar_%d", count-1)]	

				if (count == 1) then
					local	_, anch, _ ,_, _ = bar:GetPoint()
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOM", anch, "TOP" , 0 , 2)
					else
						bar:SetPoint("TOP", anch, "BOTTOM" , 0, -barHeight)
					end
				else
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, barHeight+4)
					else
						bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, -(barHeight+4))
					end
				end

				if not bar.styled then
					bar:SetHeight(barHeight)
					if not bar.bg then
						bar.bg = CreateFrame("Frame", nil, bar)
						bar.bg:SetPoint("TOPLEFT", 0, 0)
						bar.bg:SetPoint("BOTTOMRIGHT", 0, 0)
					end

					CreateShadow(bar.bg)
					background:SetNormalTexture(nil)
					bar.styled=true
				end	
		
				if not progress.styled then
					progress:SetStatusBarTexture("Interface\\AddOns\\PSUICore\\media\\statusbar")
					progress.styled=true
				end				
				progress:ClearAllPoints()
				progress:SetPoint("TOPLEFT", bar, "TOPLEFT", 2, -2)
				progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("LEFT", bar, "LEFT", 4, 2)
					name:SetFont(GameTooltipText:GetFont(), 12, "THINOUTLINE")
					name:SetJustifyH("LEFT")
					name:SetShadowColor(0, 0, 0, 0)
					name.styled=true
				end
		
				if not timer.styled then
					timer:ClearAllPoints()
					timer:SetPoint("RIGHT", bar, "RIGHT", -4, 2)
					timer:SetFont(GameTooltipText:GetFont(), 12, "THINOUTLINE")
					timer:SetJustifyH("RIGHT")
					timer:SetShadowColor(0, 0, 0, 0)
					timer.styled=true
				end
				count = count + 1
			end
		end

		-- mwahahahah, eat this ugly DBM.
		hooksecurefunc(DBT,"CreateBar",SkinBars)
		hooksecurefunc(DBM.BossHealth,"Show",SkinBossTitle)
		hooksecurefunc(DBM.BossHealth,"AddBoss",SkinBoss)
		hooksecurefunc(DBM.BossHealth,"UpdateSettings",SkinBoss)

		--[[
		DBM.RangeCheck:Show()
		DBM.RangeCheck:Hide()
		DBMRangeCheck:HookScript("OnShow",function(self)
			self:SetBackdrop({
				edgeFile = "Interface\\Buttons\\WHITE8x8", 
				edgeSize = 1, 
			})
			self:SetBackdropBorderColor(65/255, 74/255, 79/255)
			self.shadow = CreateFrame("Frame", nil, self)
			self.shadow:SetFrameLevel(1)
			self.shadow:SetFrameStrata(self:GetFrameStrata())
			self.shadow:SetPoint("TOPLEFT", -5, 5)
			self.shadow:SetPoint("BOTTOMRIGHT", 5, -5)
			self.shadow:SetBackdrop({
				edgeFile = "Interface\\AddOns\\PSUICore\\media\\media\\glow", 
				edgeSize = 5,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			})
			self.shadow:SetBackdropBorderColor(0,0,0)
		end)

		DBMRangeCheckRadar:HookScript("OnShow",function(self)
			self:SetBackdrop({
				edgeFile = "Interface\\Buttons\\WHITE8x8", 
				edgeSize = 1, 
			})
			self:SetBackdropBorderColor(65/255, 74/255, 79/255)
			self.shadow = CreateFrame("Frame", nil, self)
			self.shadow:SetFrameLevel(1)
			self.shadow:SetFrameStrata(self:GetFrameStrata())
			self.shadow:SetPoint("TOPLEFT", -5, 5)
			self.shadow:SetPoint("BOTTOMRIGHT", 5, -5)
			self.shadow:SetBackdrop({
				edgeFile = "Interface\\AddOns\\PSUICore\\media\\media\\glow", 
				edgeSize = 5,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			})
			self.shadow:SetBackdropBorderColor(0,0,0)
			self.text:SetFont(DBMRangeCheckRadar.text:GetFont(), 14, "THINOUTLINE")
		end)]]


		local RaidNotice_AddMessage_=RaidNotice_AddMessage
		RaidNotice_AddMessage=function(noticeFrame, textString, colorInfo)
			if textString:find(" |T") then
				textString = string.gsub(textString,"(:12:12)",":18:18:0:0:64:64:5:59:5:59")
			end
			return RaidNotice_AddMessage_(noticeFrame, textString, colorInfo)
		end
	end
end)
	
--[[
local ForceOptions = function()
	DBM_SavedOptions.Enabled=true

	DBT_SavedOptions["DBM"].Scale = 1
	DBT_SavedOptions["DBM"].HugeScale = 1
	DBT_SavedOptions["DBM"].BarXOffset = 0
end

local loadOptions = CreateFrame("Frame")
loadOptions:RegisterEvent("PLAYER_LOGIN")
loadOptions:SetScript("OnEvent", ForceOptions)
]]

end