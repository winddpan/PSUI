ShowHelp = function() 
	print("PSUI命令帮助")
	print("|cff3399ff/psui 命令帮助|r")
	print("|cff3399ff/as 重置UI缩放|r")
	print("|cff3399ff/rl 重载插件|r")
	print("|cff3399ff/rc 团队准备检查|r")
	print("|cff3399ff/ss 切换专精|r")
	print("|cff3399ff/hb 快速按键绑定|r")
	if IsAddOnLoaded("ShestakUI_Filger") then
		print("|cff3399ff/Filger Filger设置|r")
	end
	
	if select(2, UnitClass("player")) == "DEATHKNIGHT" then 
		if IsAddOnLoaded("PSDKHelper") then
			print("|cff3399ff/dkh PSDKHelper锁定/解锁|r")
		end
		if IsAddOnLoaded("PSRune") then
			print("|cff3399ff/psr PSRune锁定/解锁|r")
		end
	end
	print("")
end

local SetScreen = function()
	if not InCombatLockdown() then
		SetCVar("useUiScale", 1)
		local scale = 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
		if scale < .64 then
			UIParent:SetScale(scale)
		else
			SetCVar("uiScale", scale)
		end
	end
end
SlashCmdList["AutoSet"] = function() SetScreen() end
SLASH_AutoSet1 = "/autoset"
SLASH_AutoSet2 = "/as"


StaticPopupDialogs["CONFIGURE_PSUI"] = {
text = "初始化设置PS UI吗？",
button1 = YES,
button2 = NO,
OnAccept = function()
	if not InCombatLockdown() then
		SetScreen()
		ReloadUI()
	end
end,
timeout = 0,
whileDead = 1,
hideOnEscape = 1
}
SlashCmdList["CONFIG"] = function() StaticPopup_Show("CONFIGURE_PSUI") end
SLASH_CONFIG1 = "/config"

SlashCmdList['RELOADUI'] = function() ReloadUI() end
SLASH_RELOADUI1 = '/rl'

SlashCmdList["READYCHECK"] = function() DoReadyCheck() end
SLASH_READYCHECK1 = '/rc'

SlashCmdList["SPEC"] = function() 
	if GetActiveSpecGroup()==1 then SetActiveSpecGroup(2) elseif GetActiveSpecGroup()==2 then SetActiveSpecGroup(1) end
end
SLASH_SPEC1 = "/ss"
SLASH_SPEC2 = "/spec"

SlashCmdList["CmdHelp"] = function() ShowHelp() end
SLASH_CmdHelp1 = "/psui"
SLASH_CmdHelp2 = "/ps"