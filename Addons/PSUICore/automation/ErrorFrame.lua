local addon, ns = ...
local cfg = ns.cfg

-- Hiding default blizzard's Error Frame (thx nightcracker)
local f, o, ncErrorDB = CreateFrame("Frame"), "No error yet.", {
	["Inventory is full"] = true,
}
f:SetScript("OnEvent", function(self, event, error)
	if ncErrorDB[error] then
		UIErrorsFrame:AddMessage(error)
	else
	o = error
	end
end)
SLASH_NCERROR1 = "/error"
function SlashCmdList.NCERROR() print(o) end
UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
f:RegisterEvent("UI_ERROR_MESSAGE")