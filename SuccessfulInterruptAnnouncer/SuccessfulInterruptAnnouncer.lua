-- Load Variables
if type(INSraid) ~= "boolean" then
	INSraid = false;
else
end
if type(INSparty) ~= "boolean" then
	INSparty = false;
else
end
if type(INSyell) ~= "boolean" then
	INSyell = true;
else
end

if type(INSsay) ~= "boolean" then
	INSsay = true;
else
end

if type(INSself) ~= "boolean" then
 INSself = true;
else
end

if type(INSspell) ~= "boolean" then
 INSspell = true;
else
end

if type(INStarget) ~= "boolean" then
 INStarget = true;
else
end

-- Define Event Action
local function OnEvent(self, event, ...)
	if ( event == "PLAYER_LOGIN" ) then
		self:UnregisterEvent("PLAYER_LOGIN");
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	elseif ( event == "COMBAT_LOG_EVENT_UNFILTERED" ) then
		local numParty	= GetNumGroupMembers();
		
		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _, extraskillID, extraskillname = ...; 
		if (eventType == "SPELL_INTERRUPT") and sourceName == UnitName("player") then
			intmsg = ("Kicked>");
			if(INStarget == true) then
				intmsg = (intmsg.." "..destName)
			end

			if(INSspell == true) then
				if(INStarget == true) then
					intmsg = (intmsg.."的 "..GetSpellLink(extraskillID))
				else
					intmsg = (intmsg.." "..GetSpellLink(extraskillID))
				end
			end

			if UnitInRaid("player") and (INSraid == true) then
				SendChatMessage(intmsg, "RAID")
			elseif UnitInParty("player") and (INSparty == true) and (numParty > 0) then
				SendChatMessage(intmsg, "PARTY")
			end
			if (INSyell == true) then
				SendChatMessage(intmsg, "YELL")
			end
			if (INSsay == true) then
				SendChatMessage(intmsg, "SAY")
			end
			if (INSself == true) then
				print(intmsg)
			end
		
		end
	end
end

-- Register Event
local SuccessfulInterruptAnnouncer = CreateFrame("Frame")
SuccessfulInterruptAnnouncer:RegisterEvent("PLAYER_LOGIN")
SuccessfulInterruptAnnouncer:SetScript("OnEvent", OnEvent)

-- Configuration Frame
local mainFrame = CreateFrame("Frame", "SuccessfulInterruptAnnouncer", InterfaceOptionsFramePanelContainer);
mainFrame.name = "SuccessfulInterruptAnnouncer";
mainFrame:Hide();
mainFrame:SetScript("OnShow", function(frame)
	
	local fontString = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	fontString:SetText("SuccessfulInterruptAnnouncer\nby EISENHEIM");
	fontString:SetPoint("CENTER", frame, "TOP", 0, -20);
	
	local myselfonoff = CreateFrame("CheckButton", "myselfonoff", frame, "InterfaceOptionsCheckButtonTemplate")
	local myselfFunc = function(self, value) INSself = value end
	myselfonoff:SetScript("OnClick", function(self)
		myselfFunc(self, self:GetChecked() and true or false)
	end)
	myselfonoff:SetChecked(INSself)
	_G[myselfonoff:GetName() .. "Text"]:SetText("密语自己")
	myselfonoff:SetPoint("CENTER", frame, "LEFT", 30, -40)

	
	local sayonoff = CreateFrame("CheckButton", "sayonoff", frame, "InterfaceOptionsCheckButtonTemplate")
	local sayFunc = function(self, value) INSsay = value end
	sayonoff:SetScript("OnClick", function(self)
		sayFunc(self, self:GetChecked() and true or false)
	end)
	sayonoff:SetChecked(INSsay)
	_G[sayonoff:GetName() .. "Text"]:SetText("说")
	sayonoff:SetPoint("CENTER", frame, "LEFT", 30, -10)

        
	local yellonoff = CreateFrame("CheckButton", "yellonoff", frame, "InterfaceOptionsCheckButtonTemplate")
	local yellFunc = function(self, value) INSyell = value end
	yellonoff:SetScript("OnClick", function(self)
		yellFunc(self, self:GetChecked() and true or false)
	end)
	yellonoff:SetChecked(INSyell)
	_G[yellonoff:GetName() .. "Text"]:SetText("大喊")
	yellonoff:SetPoint("CENTER", frame, "LEFT", 30, 20)
	
		
	local partyonoff = CreateFrame("CheckButton", "partyonoff", frame, "InterfaceOptionsCheckButtonTemplate")
	local partyFunc = function(self, value) INSparty = value end
	partyonoff:SetScript("OnClick", function(self)
		partyFunc(self, self:GetChecked() and true or false)
	end)
	partyonoff:SetChecked(INSparty)
	_G[partyonoff:GetName() .. "Text"]:SetText("发送到小队")
	partyonoff:SetPoint("CENTER", frame, "LEFT", 30, 50)
	
	
	local raidonoff = CreateFrame("CheckButton", "raidonoff", frame, "InterfaceOptionsCheckButtonTemplate")
	local raidFunc = function(self, value) INSraid = value end
	raidonoff:SetScript("OnClick", function(self)
		raidFunc(self, self:GetChecked() and true or false)
	end)
	raidonoff:SetChecked(INSraid)
	_G[raidonoff:GetName() .. "Text"]:SetText("发送到团队")
	raidonoff:SetPoint("CENTER", frame, "LEFT", 30, 80)
	
	
	local spellonoff = CreateFrame("CheckButton", "spellonoff", frame, "InterfaceOptionsCheckButtonTemplate")
	local spellFunc = function(self, value) INSspell = value end
	spellonoff:SetScript("OnClick", function(self)
		spellFunc(self, self:GetChecked() and true or false)
	end)
	spellonoff:SetChecked(INSspell)
	_G[spellonoff:GetName() .. "Text"]:SetText("通报消息中包括你打断的法术名称.")
	spellonoff:SetPoint("CENTER", frame, "LEFT", 30, 130)

	local targetonoff = CreateFrame("CheckButton", "targetonoff", frame, "InterfaceOptionsCheckButtonTemplate")
	local targetFunc = function(self, value) INStarget = value end
	targetonoff:SetScript("OnClick", function(self)
		targetFunc(self, self:GetChecked() and true or false)
	end)
	targetonoff:SetChecked(INStarget)
	_G[targetonoff:GetName() .. "Text"]:SetText("通报消息中包括你打断了谁的法术.")
	targetonoff:SetPoint("CENTER", frame, "LEFT", 30, 160)
	
	
	
	mainFrame:SetScript("OnShow", nil)
end)	



InterfaceOptions_AddCategory(mainFrame);
