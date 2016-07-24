if not IsAddOnLoaded("Skada") then return end

local barSpacing = 0
local Skada = Skada
local barmod = Skada.displays["bar"]
local blank = "Interface\\Addons\\PSUICore\\media\\statusbar2.tga"

local titleBG = {
	bgFile = "Interface\\Buttons\\WHITE8x8",
	tile = false,
	tileSize = 0
}

local barWidth = rightPanel2:GetWidth() -6
barmod.ApplySettings_ = barmod.ApplySettings
barmod.ApplySettings = function(self, win)
	barmod.ApplySettings_(self, win)

	local skada = win.bargroup
	win.db.barwidth = barWidth
	win.db.barslocked = true
	
	if win.db.enabletitle then
		skada.button:SetBackdrop(titleBG)
		skada.button:SetBackdropColor(.05,.05,.05, .0)
	end
	
	skada:SetTexture(blank)
	skada:SetFont(STANDARD_TEXT_FONT, 10, "THICKOUTLINE")
	skada:SetSpacing(barSpacing)
	skada:SetBarHeight(16)
	skada:SetFrameLevel(1)
	skada:SetFrameStrata("LOW")
	skada:SetBackdrop(nil)
	
	SkadaBarWindowSkada:ClearAllPoints()
	SkadaBarWindowSkada:SetClampedToScreen(false)
	SkadaBarWindowSkada:SetPoint("TOPLEFT",rightPanel2 ,"TOPLEFT",3, -19)
	SkadaBarWindowSkada:SetSize(rightPanel2:GetWidth() -6, rightPanel2:GetHeight() -19)
end

for _, window in ipairs(Skada:GetWindows()) do
	window:UpdateDisplay()
end
