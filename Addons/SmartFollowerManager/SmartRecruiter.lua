local _, Addon = ...

local API = Addon.API
local GarrisonFollowerTooltip_Owner = Addon.GarrisonFollowerTooltip_Owner

local function GetRecruitLink(index)
	local follower = C_Garrison.GetAvailableRecruits()[index];
	local link;
	local lvl = follower.level;
	local iLvl = follower.iLevel
	local id = follower.followerID;
	local quality = follower.quality;
	local name = follower.name;
	local abilities = {0, 0, 0, 0};
	local traits = {0, 0, 0, 0};
	local color = ITEM_QUALITY_COLORS[quality].hex
	
	local abilityIndex = 0;
	local traitIndex = 0;
	
	local rec = C_Garrison.GetRecruitAbilities(index)
	for _, ability in pairs(rec) do
		if not ability.isTrait then
			abilityIndex = abilityIndex + 1;
			abilities[abilityIndex] = ability.id;
		else
			traitIndex = traitIndex + 1;
			traits[traitIndex] = ability.id;
		end
	end
	
	link = string.format("%s|Hgarrfollower:%d:%d:%d:%d", color, id, quality, lvl, iLvl);
	for i= 1, 4 do
		link = link .. ":" .. abilities[i];
	end
	for i= 1, 4 do
		link = link .. ":" .. traits[i];
	end
	link = string.format("%s|h[%s]|h|r", link, name);
	
	return link;
end

local function RecruitLink_OnClick(self)
	if not IsModifiedClick("CHATLINK") then
		return
	end
	
	local frame = self:GetParent();
	local index = frame.index;
	
	local link = GetRecruitLink(index);
	local editBox
	
	for i = 1, NUM_CHAT_WINDOWS do
		editBox = _G[format("%s%d%s", "ChatFrame", i, "EditBox")];
		if editBox:HasFocus() then
			editBox:Insert(link);
		end
	end
end
local function RecruitLink_OnEnter(self)
	local index = self:GetParent().index
	local follower = C_Garrison.GetAvailableRecruits()[index];
	local lvl = follower.level;
	local iLvl = follower.iLevel
	local id = follower.followerID;
	local quality = follower.quality;
	local name = follower.name;
	local abilities = {0, 0, 0, 0};
	local traits = {0, 0, 0, 0};
	
	local abilityIndex = 0;
	local traitIndex = 0;
	
	for _, ability in pairs(C_Garrison.GetRecruitAbilities(index)) do
		if not ability.isTrait then
			abilityIndex = abilityIndex + 1;
			abilities[abilityIndex] = ability.id;
		else
			traitIndex = traitIndex + 1;
			traits[traitIndex] = ability.id;
		end
	end
	
	GarrisonFollowerTooltip_Owner = self
	GarrisonFollowerTooltip:ClearAllPoints()
	GarrisonFollowerTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT")
	
	GarrisonFollowerTooltip_Show(id, false, quality, lvl, 0, 0, iLvl, abilities[1], abilities[2], abilities[3], abilities[4], traits[1], traits[2], traits[3], traits[4], false)
end
local function RecruitLink_OnLeave(self)
	if GarrisonFollowerTooltip_Owner == self then
		GarrisonFollowerTooltip:Hide()
		GarrisonFollowerTooltip_Owner = nil
	end
end

local function ShowRecruitInfo(waiting)
	if waiting then 
		return 
	end

	local followers = C_Garrison.GetAvailableRecruits();
	local id, frame, btn;
	local color = NORMAL_FONT_COLOR;
	if next(followers) ~= nil then
		for i = 1, 3 do
			id = followers[i].followerID;
			frame = GarrisonRecruitSelectFrame.FollowerSelection["Recruit"..i];
			
			frame.race = frame.race or frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			frame.class = frame.class or frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			
			frame.race:SetText(API.GetRaceName(id));
			frame.class:SetText(followers[i].className);
			
			frame.race:SetPoint("TOPLEFT", frame.PortraitFrame, "BOTTOMLEFT", 8, -5);
			frame.class:SetPoint("TOPLEFT", frame.race, "BOTTOMLEFT", 0 , 0);
			
			if frame.Abilities:IsShown() then
				frame.Abilities:SetPoint("TOPLEFT", frame.class, "BOTTOMLEFT", 0 , -5);
				if frame.Traits:IsShown() then
					frame.Traits:SetPoint("TOPLEFT", frame.Abilities, "BOTTOMLEFT", 0 , 0);
				end
			else
				frame.Traits:SetPoint("TOPLEFT", frame.class, "BOTTOMLEFT", 0 , -5);
			end
			
			frame.class:SetVertexColor(color.r, color.g, color.b);
			
			frame.race:Show();
			frame.class:Show();
			frame.index = i;
			
			if not frame.btnLink then
				btn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
				btn:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
				btn:SetWidth(188);
				btn:SetHeight(50);
				btn:SetScript("OnClick", RecruitLink_OnClick);
				btn:SetScript("OnEnter", RecruitLink_OnEnter);
				btn:SetScript("OnLeave", RecruitLink_OnLeave);
				btn:SetAlpha(0.0);
				frame.btnLink = btn;
			end
		end
	end
end

function Addon.LoadWithUI.SmartRecruiter()
	hooksecurefunc("GarrisonRecruitSelectFrame_UpdateRecruits", ShowRecruitInfo)
end