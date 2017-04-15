local addon, _ = ... 

function InitChooseChannelButton()
	--local button = CreateFrame("Button", "SimpleChannelButton", UIParent, "UIPanelButtonTemplate")
	local button = CreateFrame("frame", "SimpleChannelButton", UIParent)
	button:SetSize(24,24)
	button:SetBackdrop(nil)
	local fs = button:CreateFontString(nil, "OVERLAY")
	fs:SetFont("Fonts\\ARIALN.TTF", 11, "THINOUTLINE")
	fs:SetPoint("CENTER", button, "CENTER",0,0)
	fs:SetText("|cff8AFF30M|r")

	button:SetPoint("BOTTOMRIGHT", _G["ChatFrame1"], "TOPRIGHT", 8, 2)
	ChatFrameMenuButton:SetPoint("TOPRIGHT", button, "TOPRIGHT")
	button:SetScript("OnMouseUp", 
						function() 
							if ChatMenu:IsShown() then
								ChatMenu:Hide()
							else
								ChatMenu:Show()
							end
						end);
end

InitChooseChannelButton()



