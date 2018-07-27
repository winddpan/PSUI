local soloCycles = {
	{
        chatType = "SAY",   --SAY
        use = function(self, editbox) return 1 end,
	},
    {
        chatType = "PARTY",  --小队
        use = function(self, editbox) return IsInGroup() end,
    },
    {
        chatType = "RAID",  --团队
        use = function(self, editbox) return IsInRaid() end,
    },
    {
        chatType = "INSTANCE_CHAT",  --副本
        use = function(self, editbox) return select(2, IsInInstance()) == 'pvp' end,
    },
    {
        chatType = "GUILD",   --工会
        use = function(self, editbox) return IsInGuild() end,
    },    
	{
        chatType = "CHANNEL",
        use = function(self, editbox, currChatType)
            if currChatType~="CHANNEL" then
                currNum = IsShiftKeyDown() and 21 or 0
            else
                currNum = editbox:GetAttribute("channelTarget");
            end
            local h, r, step = currNum+1, 20, 1
            if IsShiftKeyDown() then h, r, step = currNum-1, 1, -1 end
            for i=h,r,step do
                local channelNum, channelName = GetChannelName(i);
                if channelNum > 0 
				and not channelName:find("本地防务 %-") 
				and not channelName:find("寻求组队") 
				and not channelName:find("本地防務 %-") 
				and not channelName:find("LFGForwarder") 
				and not channelName:find("TCForwarder") 
				then
                    editbox:SetAttribute("channelTarget", i);
                    return true;
                end
            end
        end,
    }, 
    {
        chatType = "SAY",
        use = function(self, editbox) return 1 end,
    },
}

local partyCycles = {
	{
        chatType = "SAY",   --SAY
        use = function(self, editbox) return 1 end,
	},
    {
        chatType = "PARTY",  --小队
        use = function(self, editbox) return IsInGroup() end,
    },
    {
        chatType = "RAID",  --团队
        use = function(self, editbox) return IsInRaid() end,
    },
    {
        chatType = "INSTANCE_CHAT",  --副本
        use = function(self, editbox) return select(2, IsInInstance()) == 'pvp' end,
    },
    {
        chatType = "GUILD",   --工会
        use = function(self, editbox) return IsInGuild() end,
    },    
    {
        chatType = "SAY",
        use = function(self, editbox) return 1 end,
    },
}

function ChatEdit_CustomTabPressed(self)
	if strsub(tostring(self:GetText()), 1, 1) == "/" then return end
    local currChatType = self:GetAttribute("chatType")
	local cycles = soloCycles
	if IsInGroup() or IsInRaid() then
		cycles = partyCycles
	end
    for i, curr in ipairs(cycles) do
        if curr.chatType== currChatType then
            local h, r, step = i+1, #cycles, 1
            if IsShiftKeyDown() then h, r, step = i-1, 1, -1 end
			if currChatType=="CHANNEL" then h = i end
            for j=h, r, step do
                if cycles[j]:use(self, currChatType) then
                    self:SetAttribute("chatType", cycles[j].chatType);
                    ChatEdit_UpdateHeader(self);
                    return;
                end
            end
        end
    end
	-- 没有匹配则跳到SAY
	self:SetAttribute("chatType", cycles[1].chatType);
	ChatEdit_UpdateHeader(self);
end