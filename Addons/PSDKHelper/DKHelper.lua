local addon, ns = ...
local lib = ns.lib

if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local cfgMode = false
local defalutPostion = {
	buff = {"CENTER", UIParent, "CENTER", -100, -50},
	debuff = {"CENTER", UIParent, "CENTER", 100, -50},
	APStatu = {'CENTER', UIParent, 'CENTER', 0, 0},
}

local MAXBUFF = 15
local BUFFTABLE , DEBUFFTABLE= {},{}
local BuffIDs = {
	["BloodCharge"] = 114851,
	["ScentOfBlood"] = 50421,
	["BloodShield"] = 77535,
	--["Vengeance"] = 132365,
}

local DeBuffIDs = {
	--["NecroticStrike"] = 73975,
	["SoulReaper_Blood"] = 114866,
}

local DKHelper = CreateFrame("Frame", "DKHelper", UIParent)
DKHelper:RegisterEvent("PLAYER_ENTERING_WORLD")
DKHelper:RegisterEvent("UNIT_HEALTH")
DKHelper:RegisterEvent("UNIT_AURA")
DKHelper:RegisterEvent("PLAYER_TARGET_CHANGED")

local BuffAnchor = lib.cAnchor(DKHelper, "BuffAnchor",defalutPostion.buff)
local DebuffAnchor = lib.cAnchor(DKHelper, "DebuffAnchor",defalutPostion.debuff)

local Buff = CreateFrame("Frame", "Buff", DKHelper)
Buff:SetSize(cfg.iconsize, cfg.iconsize)
Buff:SetPoint("BOTTOMRIGHT","BuffAnchor","BOTTOMRIGHT",0,0)

local Debuff = CreateFrame("Frame", "Debuff", DKHelper)
Debuff:SetSize(cfg.iconsize, cfg.iconsize)
Debuff:SetPoint("BOTTOMRIGHT","DebuffAnchor","BOTTOMRIGHT",0,0)

local function init()
	local i=0
	for spellName,spellId in pairs(BuffIDs) do
		local  frame = lib.cFrame(Buff, spellName, spellId)
		--frame:SetPoint("BOTTOMLEFT", (i+1)*(cfg.iconsize+cfg.spacing), 0)
		frame:Hide()
		tinsert(BUFFTABLE,frame)
		i = i+1
	end
	i = 0
	for spellName,spellId in pairs(DeBuffIDs) do
		local  frame = lib.cFrame(Debuff, spellName, spellId)
		--frame:SetPoint("BOTTOMLEFT", (i+1)*(cfg.iconsize+cfg.spacing), 0)
		frame:Hide()
		tinsert(DEBUFFTABLE,frame)
		i = i+1
	end
end
init()

--["SoulReaper_Blood"] = 114866,
--["SoulReaper_Frost"] = 130735,
--["SoulReaper_Unholy"] = 130736,

local function sortIconFrames(TABLE , direction)
	local i = 0
	for _, achildrenFrame in pairs(TABLE) do
		if achildrenFrame:IsVisible()  then
			if direction == "RIGHT" then
				achildrenFrame:SetPoint("BOTTOMLEFT", (i+1)*(cfg.iconsize+cfg.spacing), 0)
			elseif  direction == "LEFT" then
				achildrenFrame:SetPoint("BOTTOMRIGHT", -(i+1)*(cfg.iconsize+cfg.spacing), 0)
			end
			i = i+1
		end
	end
end

local function SoulReaper_Update(Frame)
	local debufIndex = 1
	local foundFlag = false
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,_, value1, value2, value3= UnitDebuff("target", debufIndex, "player")
	while spellID do
		if (spellID == 114866 or spellID == 130735 or spellID == 130736 ) and caster == "player" then
				foundFlag = true
				break
		else
			debufIndex = debufIndex + 1
			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,_, value1, value2, value3= UnitDebuff("target", debufIndex, "player")
		end
	end
   	if not Frame.texture then
			Frame.texture = Frame:CreateTexture()
			Frame.texture:SetAllPoints(Frame)
			Frame.texture:SetTexture(1,0,0,0.6)
	end
	
	--foundFlag = false
	if  foundFlag then
		Frame:SetAlpha(1)
		Frame.texture:SetAlpha(0)
		CooldownFrame_SetTimer(Frame.cooldown, expires - duration, duration, 1)
	else		
		local missFlag = false
		local start, duration
		if select(2, GetSpellCooldown(114866)) > 1.5 then
			start, duration = GetSpellCooldown(114866)
			missFlag = true
		elseif select(2, GetSpellCooldown(130735)) > 1.5 then
			start, duration = GetSpellCooldown(130735)
			missFlag = true
		elseif select(2, GetSpellCooldown(130736)) > 1.5 then
			start, duration = GetSpellCooldown(130736)
			missFlag = true
		end
		
		--missFlag = false

		if missFlag then
			Frame:SetAlpha(1)
			Frame.texture:SetAlpha(1)
			CooldownFrame_SetTimer(Frame.cooldown, start, duration, 1) 
		else
			Frame:SetAlpha(0.5)
			Frame.texture:SetAlpha(0)
			Frame.cooldown:SetCooldown(0,0)
		end
   end 
   
end

local function NecroticStrike_Update(Frame)

	if not Frame.texture then
		Frame.texture = Frame:CreateTexture()
		--Frame.texture:SetAllPoints(Frame)
		Frame.texture:SetTexture(0,0.6,0.88,0.6)
		Frame.texture:SetAlpha(0.5)
		Frame.texture:SetPoint("TOPLEFT", 3 , -3 )
        Frame.texture:SetPoint("BOTTOMRIGHT", -3 , 3 )
	end
	
	local debufIndex = 1
	local foundFlag = false
	
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,_, value1, value2, value3= UnitDebuff("target", debufIndex, "player")
	
	local frame = lib.getFrame("NecroticStrike")
	while spellID do
		if spellID == DeBuffIDs.NecroticStrike and caster == "player" then
				frame:Show()
				if not frame.text then
					frame.text = frame:CreateFontString(nil, "OVERLAY")
				end
				frame.text:SetFont(cfg.font, cfg.fontsize, cfg.fontflag)
				frame.text:SetPoint("BOTTOM",0, -cfg.fontsize-3)
				frame.text:SetText(lib.formatNumber(value1))
				
				CooldownFrame_SetTimer(frame.cooldown, expires - duration, duration, 1)
				foundFlag  = true
				break
		else
			debufIndex = debufIndex + 1
			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,_, value1, value2, value3= UnitDebuff("target", debufIndex, "player")
		end
	end
	
	if foundFlag then
		Frame:Show()
	else 
		Frame:Hide()
	end
		
	return foundFlag
end

local function UpdateBuffs()
	local bufIndex = 1
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,_, value1, value2, value3= UnitBuff("player", bufIndex, "player")
	
    local frame_BloodShield = lib.getFrame("BloodShield")
	frame_BloodShield.foundFlag = false
	
    local frame_ScentOfBlood = lib.getFrame("ScentOfBlood")
	frame_ScentOfBlood.foundFlag = false
	
    --local frame_Vengeance = lib.getFrame("Vengeance")
	--frame_Vengeance.foundFlag = false
	
	local frame_BloodCharge = lib.getFrame("BloodCharge")
	frame_BloodCharge.foundFlag = false
	
	while spellID do
		--print(name..spellID..caster)
		if spellID == BuffIDs.BloodShield and caster == "player" then
				frame_BloodShield:Show()
				if not frame_BloodShield.text then
					frame_BloodShield.text = frame_BloodShield:CreateFontString(nil, "OVERLAY")
				end
				frame_BloodShield.text:SetFont(cfg.font, cfg.fontsize, cfg.fontflag)
				frame_BloodShield.text:SetPoint("BOTTOM",0, -cfg.fontsize-3)
				frame_BloodShield.text:SetText(lib.formatNumber(value1))
				if not frame_BloodShield.Cooldown then 
					frame_BloodShield.Cooldown = CreateFrame("Cooldown", nil, frame_BloodShield) 
					frame_BloodShield.Cooldown:SetAllPoints() 
				end
				frame_BloodShield.Cooldown:SetReverse(true) 
				CooldownFrame_SetTimer(frame_BloodShield.Cooldown, expires - duration, duration, 1)
				frame_BloodShield.foundFlag = true
		elseif spellID == BuffIDs.Vengeance and caster == "player" and cfg.show_Vengeance then
		--[[
				frame_Vengeance:Show()
				if not frame_Vengeance.text then
						frame_Vengeance.text = frame_Vengeance:CreateFontString(nil, "OVERLAY")
				end
				frame_Vengeance.text:SetFont(cfg.font, cfg.fontsize, cfg.fontflag)
				frame_Vengeance.text:SetPoint("BOTTOM",0, -cfg.fontsize-3)
				frame_Vengeance.text:SetText(lib.formatNumber(value1))
				frame_Vengeance.foundFlag = true]]
		elseif spellID == BuffIDs.ScentOfBlood and caster == "player"  and cfg.show_BloodCharge then
				local frame = frame_ScentOfBlood
				CooldownFrame_SetTimer(frame.cooldown, expires - duration, duration, 1)
				frame.count:SetText(count > 1 and count or nil)
				frame.foundFlag = true
		elseif spellID == BuffIDs.BloodCharge and caster == "player" and cfg.show_ScentOfBlood then
				local frame = frame_BloodCharge
				CooldownFrame_SetTimer(frame.cooldown, expires - duration, duration, 1)
				frame.count:SetText(count > 1 and count or nil)
				frame_BloodCharge.foundFlag = true
		end
		bufIndex = bufIndex + 1
			if bufIndex >= MAXBUFF then
				break
			end
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,_, value1, value2, value3= UnitBuff("player", bufIndex, "player")
		
	end	--while end

	for _, frame in pairs(BUFFTABLE) do
		if frame.foundFlag then
			frame:Show() else frame:Hide()
		end
	end

end

local SoulReaperPercent = .35
local function updateSPPercent()
	SoulReaperPercent = 0.35
	if GetSpellInfo(157342) ~= nil then
		SoulReaperPercent = 0.45
	end
end

local function checkSoulReaper(SoulReaper_Frame)
	updateSPPercent()
	if  UnitName("target") and UnitHealth("target")/UnitHealthMax("target") < SoulReaperPercent then
			 if ( UnitCanAttack("player", "target") and not UnitIsDead("target") ) then 
				 SoulReaper_Frame:Show()
				 SoulReaper_Update(SoulReaper_Frame)
			else
				SoulReaper_Frame:Hide() 
			 end 
		else
			 SoulReaper_Frame:Hide() 
		end
end

DKHelper:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
	
	if not cfgMode then
		local SoulReaper_Frame = lib.getFrame("SoulReaper_Blood")
		local NecroticStrike_Frame = lib.getFrame("NecroticStrike")
		if event == "UNIT_HEALTH" then
			checkSoulReaper(SoulReaper_Frame)
		 end 
		 
		 if  event == "PLAYER_TARGET_CHANGED" then
			checkSoulReaper(SoulReaper_Frame)
			--NecroticStrike_Update(NecroticStrike_Frame)
		 end
		 
		  if  event == "UNIT_AURA" then
			--NecroticStrike_Update(NecroticStrike_Frame)
			checkSoulReaper(SoulReaper_Frame)
			UpdateBuffs()
		  end
		  
		  sortIconFrames(BUFFTABLE , cfg.Buff_Direction)
		  sortIconFrames(DEBUFFTABLE, cfg.DeBuff_Direction)
	end
end)

local function test(TABLE , direction , AnchorFrame, showFlag)
	local i = 0
	for _, achildrenFrame in pairs(TABLE) do
		if direction == "RIGHT" then
			achildrenFrame:SetPoint("BOTTOMLEFT", (i)*(cfg.iconsize+cfg.spacing) + cfg.iconsize/2, 0)
		elseif  direction == "LEFT" then
			achildrenFrame:SetPoint("BOTTOMRIGHT", -(i)*(cfg.iconsize+cfg.spacing) - cfg.iconsize/2, 0)
		end
		if showFlag then
			AnchorFrame:Show()
			achildrenFrame:Show()
		else
			AnchorFrame:Hide()
			achildrenFrame:Hide()
		end
		i = i+1
	end
end


SlashCmdList["DKHelper"] = function(msg) 
    if msg:lower() =="" then
		if BuffAnchor:IsVisible() or DebuffAnchor:IsVisible() then 
			print("|cff3399FFDKHelper Lock!|r")
			test(BUFFTABLE , cfg.Buff_Direction, BuffAnchor, false )
			test(DEBUFFTABLE, cfg.DeBuff_Direction, DebuffAnchor, false)
			cfgMode = false
		else 
			print("|cff3399FFDKHelper UnLock!|r")
			test(BUFFTABLE , cfg.Buff_Direction, BuffAnchor, true)
			test(DEBUFFTABLE, cfg.DeBuff_Direction, DebuffAnchor, true)
			cfgMode = true
		end
	elseif msg:lower() == "reset" then
		print("|cff3399FFDKHelper Reset!|r")
		BuffAnchor:SetPoint(unpack(defalutPostion.buff))
		DebuffAnchor:SetPoint(unpack(defalutPostion.debuff))
	else
		print("/dkh reset  ---- 恢复默认位置")
	end
end
SLASH_DKHelper1 = "/DKHelper"
SLASH_DKHelper2 = "/dkh"