if not DBM then return end
local DBMSkinHalf = false

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
		
function SkinDBM(event, addon)
	if event == 'PLAYER_ENTERING_WORLD' then
		local croprwicons = true
		local BarHeight
		local function SkinBars(self)
			for bar in self:GetBarIterator() do
				if not bar.injected then
					hooksecurefunc(bar, "Update", function()
						local sparkEnabled = bar.owner.options.Style ~= "BigWigs" and bar.owner.options.Spark
						if not sparkEnabled then return end
						local spark = _G[bar.frame:GetName().."BarSpark"]
						spark:SetSize(12, bar.owner.options.Height*3/2 - 2)
						local a,b,c,d = spark:GetPoint()
						spark:SetPoint(a,b,c,d,0)
					end)
					hooksecurefunc(bar, "ApplyStyle", function()
						local frame = bar.frame
						local tbar = _G[frame:GetName()..'Bar']
						local icon1 = _G[frame:GetName()..'BarIcon1']
						local icon2 = _G[frame:GetName()..'BarIcon2']
						local name = _G[frame:GetName()..'BarName']
						local timer = _G[frame:GetName()..'BarTimer']

						if not icon1.overlay then
							icon1.overlay = CreateFrame('Frame', '$parentIcon1Overlay', tbar)
							CreateBorder(icon1.overlay)
							icon1.overlay:SetFrameLevel(0)
							icon1.overlay:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMLEFT', -(AS.PixelMode and 2 or 3), 0)
						end

						if not icon2.overlay then
							icon2.overlay = CreateFrame('Frame', '$parentIcon2Overlay', tbar)
							CreateBorder(icon2.overlay)
							icon2.overlay:SetFrameLevel(0)
							icon2.overlay:SetPoint('BOTTOMLEFT', frame, 'BOTTOMRIGHT', (AS.PixelMode and 2 or 3), 0)
						end

						if not icon1.styled then
							icon1:SetTexCoord(0.08, 0.92, 0.08, 0.92)
							icon1:ClearAllPoints()
							icon1:SetPoint("TOPLEFT", icon1.overlay, 1, -1)
							icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, -1, 1)
							icon1.styled=true
						end
				
						if not icon2.styled then
							icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
							icon2:ClearAllPoints()
							icon2:SetPoint("TOPLEFT", icon2.overlay, 1, -1)
							icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, -1, 1)
							icon2.styled=true
						end
						
						if not texture.styled then
							texture:SetTexture("Interface\\AddOns\\PSUICore\\media\\statusbar2")
							texture.styled=true
						end

						if not tbar.styled then
							tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
							tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
							tbar.styled=true
						end
						
						icon1.overlay:SetSize(bar.owner.options.Height, bar.owner.options.Height)
						icon2.overlay:SetSize(bar.owner.options.Height, bar.owner.options.Height)
						BarHeight = bar.owner.options.Height

						frame:SetTemplate('Transparent')

						name:ClearAllPoints()
						name:SetWidth(165)
						name:SetHeight(8)
						name:SetJustifyH('LEFT')
						name:SetShadowColor(0, 0, 0, 0)

						timer:ClearAllPoints()
						timer:SetJustifyH('RIGHT')
						timer:SetShadowColor(0, 0, 0, 0)

						if DBMSkinHalf then
							frame:SetHeight(bar.owner.options.Height / 3)
							name:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 0, 3)
							timer:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -1, 1)
						else
							frame:SetHeight(bar.owner.options.Height)
							name:SetPoint('LEFT', frame, 'LEFT', 4, 0)
							timer:SetPoint('RIGHT', frame, 'RIGHT', -4, 0)
						end

						if bar.owner.options.IconLeft then icon1.overlay:Show() else icon1.overlay:Hide() end
						if bar.owner.options.IconRight then icon2.overlay:Show() else icon2.overlay:Hide() end

						bar.injected = true
					end)
					bar:ApplyStyle()
				end
			end
		end

		local SkinBoss = function()
			local count = 1
			while (_G[format('DBM_BossHealth_Bar_%d', count)]) do
				local bar = _G[format('DBM_BossHealth_Bar_%d', count)]
				local barname = bar:GetName()
				local background = _G[barname..'BarBorder']
				local progress = _G[barname..'Bar']
				local name = _G[barname..'BarName']
				local timer = _G[barname..'BarTimer']
				local pointa, anchor, pointb, _, _ = bar:GetPoint()

				if not pointa then return end
				bar:ClearAllPoints()

				bar:SetTemplate('Transparent')

				background:SetNormalTexture(nil)

				if not progress.styled then
					progress:SetStatusBarTexture("Interface\\AddOns\\PSUICore\\media\\statusbar2")
					progress.styled=true
				end				
				progress:ClearAllPoints()
				progress:SetPoint("TOPLEFT", bar, "TOPLEFT", 1, -1)
				progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -1, 1)

				name:ClearAllPoints()
				name:SetJustifyH('LEFT')
				name:SetShadowColor(0, 0, 0, 0)

				timer:ClearAllPoints()
				timer:SetJustifyH('RIGHT')
				timer:SetShadowColor(0, 0, 0, 0)

				local MainOffset, BarOffset
				if DBMSkinHalf then
					bar:SetHeight((BarHeight or 22) / 3)
					name:SetPoint('BOTTOMLEFT', bar, 'TOPLEFT', 4, 0)
					timer:SetPoint('BOTTOMRIGHT', bar, 'TOPRIGHT', -4, 0)
					MainOffset = 16
					BarOffset = 16
				else
					bar:SetHeight(BarHeight or 22)
					name:SetPoint('LEFT', bar, 'LEFT', 4, 0)
					timer:SetPoint('RIGHT', bar, 'RIGHT', -4, 0)
					MainOffset = 8
					BarOffset = 4
				end

				local header = {bar:GetParent():GetRegions()}
				if header and header[1]:IsObjectType('FontString') then
					header[1]:SetTextColor(1, 1, 1)
					header[1]:SetShadowColor(0, 0, 0, 0)
				end

				if DBM.Options.HealthFrameGrowUp then
					bar:SetPoint(pointa, anchor, pointb, 0, count == 1 and MainOffset or BarOffset)
				else
					bar:SetPoint(pointa, anchor, pointb, 0, -(count == 1 and MainOffset or BarOffset))
				end

				count = count + 1
			end
		end

		local function SkinInfo(self, maxLines, event, ...)
			if DBM.Options.DontShowInfoFrame and (event or 0) ~= "test" then return end
			if DBMInfoFrame then
				DBMInfoFrame:SetTemplate('Transparent')
			end
		end

		hooksecurefunc(DBT, 'CreateBar', SkinBars)
		hooksecurefunc(DBM.BossHealth, 'Show', SkinBoss)
		hooksecurefunc(DBM.BossHealth, 'AddBoss', SkinBoss)
		hooksecurefunc(DBM.BossHealth, 'UpdateSettings', SkinBoss)

		if croprwicons then
			local RaidNotice_AddMessage_ = RaidNotice_AddMessage
			RaidNotice_AddMessage = function(noticeFrame, textString, colorInfo, displayTime)
				if textString:find('|T') then
					textString = gsub(textString,'(:12:12)',':18:18:0:0:64:64:5:59:5:59')
				end
				return RaidNotice_AddMessage_(noticeFrame, textString, colorInfo, displayTime)
			end
		end
	end
end

local DBMSkin = CreateFrame("Frame")
DBMSkin:RegisterEvent("PLAYER_ENTERING_WORLD")
DBMSkin:SetScript("OnEvent", SkinDBM)
