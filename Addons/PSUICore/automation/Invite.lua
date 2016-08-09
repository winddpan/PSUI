local accept_invites = false
local whisper_invite = true
local whisper_invite_word = "123"
local whisper_reset_word = "reset"

-- Accept invites from guild or friend list 
if accept_invites then
	local IsFriend = function(name)
		for i = 1, GetNumFriends() do
			if GetFriendInfo(i) == name then
				return true
			end
		end
		for i = 1, select(2, BNGetNumFriends()) do
			local presenceID, _, _, _, _, _, client, isOnline = BNGetFriendInfo(i)
			if client == "WoW" and isOnline then
				local _, toonName, _, realmName = BNGetToonInfo(presenceID)
				if name == toonName or name == toonName.."-"..realmName then
					return true
				end
			end
		end
		if IsInGuild() then
			for i = 1, GetNumGuildMembers() do
				if Ambiguate(GetGuildRosterInfo(i), "guild") == name then
					return true
				end
			end
		end
	end
	local ai = CreateFrame("Frame")
	ai:RegisterEvent("PARTY_INVITE_REQUEST")
	ai:SetScript("OnEvent", function(self, event, name)
		if QueueStatusMinimapButton:IsShown() or GetNumGroupMembers() > 0 then return end
		if IsFriend(name) then
			RaidNotice_AddMessage(RaidWarningFrame, "Group invitation from |cffFFC354"..name.."|r accepted.", {r = 0.41, g = 0.8, b = 0.94}, 3)
			print("Group invitation from |cffFFC354"..name.."|r accepted.")
			AcceptGroup()
			for i = 1, STATICPOPUP_NUMDIALOGS do
				local frame = _G["StaticPopup"..i]
				if frame:IsVisible() and frame.which == "PARTY_INVITE" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE")
					return
				elseif frame:IsVisible() and frame.which == "PARTY_INVITE_XREALM" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE_XREALM")
					return
				end
			end
		else
			SendWho(name)
		end
	end)
end

-- Autoinvite by whisper
if whisper_invite then
	local f = CreateFrame("frame")
	f:RegisterEvent("CHAT_MSG_WHISPER")
	f:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
		if (not IsInGroup() or UnitIsGroupLeader("player")) then 
			if arg1:lower():match(whisper_invite_word) then
				print("已邀请"..arg2)
				InviteUnit(arg2)
			elseif arg1:lower():match(whisper_reset_word) then
				print("已重置副本")
				ResetInstances()
				SendChatMessage("副本已重置","whisper",GetDefaultLanguage("arg2"),arg2)
			end
		end
	end)
end