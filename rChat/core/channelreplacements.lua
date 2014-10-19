  
  --[[
  --guild
  CHAT_GUILD_GET = "|Hchannel:GUILD|h[G]|h %s "
  CHAT_OFFICER_GET = "|Hchannel:[OFFICER]|hO|h %s "
    
  --raid
  CHAT_RAID_GET = "|Hchannel:[RAID]|hR|h %s "
  CHAT_RAID_WARNING_GET = "RW %s "
  CHAT_RAID_LEADER_GET = "|Hchannel:[RAID]|hRL|h %s "
  
  --party
  CHAT_PARTY_GET = "|Hchannel:[PARTY]|hP|h %s "
  CHAT_PARTY_LEADER_GET =  "|Hchannel:PARTY|hPL|h %s "
  CHAT_PARTY_GUIDE_GET =  "|Hchannel:PARTY|hPG|h %s "

  --instance
  CHAT_INSTANCE_CHAT_GET = "|Hchannel:Battleground|hI.|h %s: "
  CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:Battleground|hIL.|h %s: "
  
  --whisper  
  CHAT_WHISPER_INFORM_GET = "to %s "
  CHAT_WHISPER_GET = "from %s "
  CHAT_BN_WHISPER_INFORM_GET = "to %s "
  CHAT_BN_WHISPER_GET = "from %s "
  
  --say / yell
  CHAT_SAY_GET = " %s "
  CHAT_YELL_GET = "%s "
  
  --flags
  CHAT_FLAG_AFK = "[AFK] "
  CHAT_FLAG_DND = "[DND] "
  CHAT_FLAG_GM = "[GM] "
]]

-- Global strings
CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[".."R".."]|h %s:\32"
CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[".."RL".."]|h %s:\32"
--CHAT_BN_WHISPER_GET = "Fr".." %s:\32"
CHAT_GUILD_GET = "|Hchannel:GUILD|h[".."G".."]|h %s:\32"
CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[".."O".."]|h %s:\32"
CHAT_PARTY_GET = "|Hchannel:PARTY|h[".."P".."]|h %s:\32"
CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[".."PL".."]|h %s:\32"
CHAT_PARTY_GUIDE_GET = CHAT_PARTY_LEADER_GET
CHAT_RAID_GET = "|Hchannel:RAID|h[".."R".."]|h %s:\32"
CHAT_RAID_LEADER_GET = "|Hchannel:RAID|h[".."RL".."]|h %s:\32"
CHAT_RAID_WARNING_GET = "[".."RW".."] %s:\32"
CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h[".."PB".."]|h:\32"
CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h[".."PB".."]|h:\32"
CHAT_SAY_GET = "%s:\32"
--CHAT_WHISPER_GET = "Fr".." %s:\32"
CHAT_YELL_GET = "%s:\32"
CHAT_FLAG_AFK = "|cffE7E716".."[AFK]".."|r "
CHAT_FLAG_DND = "|cffFF0000".."[DND]".."|r "
CHAT_FLAG_GM = "|cff4154F5".."[GM]".."|r "
ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h ".."has come |cff298F00online|r."
ERR_FRIEND_OFFLINE_S = "[%s] ".."has gone |cffff0000offline|r."

--[[
_G.TIMESTAMP_FORMAT_HHMM = "|cff64C2F5[%I:%M]|r "
_G.TIMESTAMP_FORMAT_HHMMSS = "|cff64C2F5[%I:%M:%S]|r "
_G.TIMESTAMP_FORMAT_HHMMSS_24HR = "|cff64C2F5[%H:%M:%S]|r "
_G.TIMESTAMP_FORMAT_HHMMSS_AMPM = "|cff64C2F5[%I:%M:%S %p]|r "
_G.TIMESTAMP_FORMAT_HHMM_24HR = "|cff64C2F5[%H:%M]|r "
_G.TIMESTAMP_FORMAT_HHMM_AMPM = "|cff64C2F5[%I:%M %p]|r "
]]

local gsub = _G.string.gsub

for i = 1, NUM_CHAT_WINDOWS do
  local f = _G["ChatFrame"..i]
  local am = f.AddMessage
  f.AddMessage = function(frame, text, ...)
		if text:find(INTERFACE_ACTION_BLOCKED) then return am(frame, text, ...) end
		if not text:find("BN_CONVERSATION") then
			text = text:gsub("|h%[(%d+)%. .-%]|h", "|h[%1]|h")
		end
		return am(frame, text, ...)
  end
end
