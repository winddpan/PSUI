--[[----------------------------------------------------------------------------

  LiteBag/Print.lua

  Copyright 2013-2016 Mike Battersby

  Released under the terms of the GNU General Public License version 2 (GPLv2).
  See the file LICENSE.txt.

----------------------------------------------------------------------------]]--

local addonName, addonTable = ...

--[[----------------------------------------------------------------------------
    Printing to active chat frame.
----------------------------------------------------------------------------]]--

local function ActiveChatFrame()
    for i = 1, NUM_CHAT_WINDOWS do
        local f = _G["ChatFrame"..i]
        if f and f:IsShown() then return f end
    end
    return DEFAULT_CHAT_FRAME
end

function LiteBag_Print(...)
    ActiveChatFrame():AddMessage("|cff00ff00LiteBag:|r " .. format(...))
end

function LiteBag_Debug(...)
    if LiteBag_GetGlobalOption("DebugEnabled") then
        -- Outputs into the first chat tab instead of LiteBag_Print. Even I
        -- find the spam too much.
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00LiteBag:|r " .. format(...))
    end
end
