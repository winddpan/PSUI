if select(2, UnitClass("player")) ~= "ROGUE" then return end

local spn1 = 2823 --����
local spn2 = 8679 --����
local _, _, icon_texture = GetSpellInfo(2823)
						
local bar = CreateFrame("Frame", "PoisonAlert", UIParent)
bar:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
bar:SetWidth(40)
bar:SetHeight(40)
bar:SetFrameStrata("HIGH")
bar:SetFrameLevel(0)
bar:Hide()

icon = bar:CreateTexture("$parentIcon", "BORDER")
icon:SetPoint("TOPLEFT", 2, -2)
icon:SetPoint("BOTTOMRIGHT", -2 , 2)
icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
icon:SetVertexColor(0.1, 0.8, 0.1, 1)
icon:SetTexture(icon_texture)
text = bar:CreateFontString("$parentSpellName", "OVERLAY")
text:SetFont(GameTooltipText:GetFont(), 12, "OUTLINE")
text:SetShadowOffset(1, -1)
text:SetPoint("TOP", bar, "BOTTOM", 0, -2)
text:SetJustifyH("LEFT")
text:SetText("!POISON")
text:SetTextColor(0.7, 0.1, 0.1, 1)

local CheckerFrame = CreateFrame("Frame") 
CheckerFrame:RegisterEvent("UNIT_AURA")

local timeDuration = 0

local SpecWatch = CreateFrame("Frame") 
SpecWatch:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
SpecWatch:RegisterEvent("PLAYER_ENTERING_WORLD")
SpecWatch:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4 ,arg5, ...)
	if GetSpecialization() == 1 then
		CheckerFrame:SetScript("OnUpdate", function(self, elapsed)
			if timeDuration >= 0.5 then
				timeDuration = 0
				for i=1,40 do 
					local buffId = select(10, UnitBuff("player",i))
					if buffId ~= nil and (buffId == spn1 or buffId == spn2) then
						bar:Hide()
						return
					end
				end
				bar:Show()
			else
				timeDuration = timeDuration + elapsed
			end
		end)
	else
		CheckerFrame:SetScript("OnUpdate", nil)
		bar:Hide()
	end
end)