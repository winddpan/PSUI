if not Skada then return end

local function CreateBackdrop(f, t, tex)
	if f.backdrop then return end
	
	local b = CreateFrame("Frame", nil, f)
	b:SetPoint("TOPLEFT", -2, 2)
	b:SetPoint("BOTTOMRIGHT", 2, -2)
	--CreateStyle(b, 2)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end
	
	f.backdrop = b
end

local function StripTextures(object, kill)
	for i = 1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				Kill(region)
			else
				region:SetTexture(nil)
			end
		end
	end
end

local Skada = Skada
local barSpacing = 0
local borderWidth = 2

local barmod = Skada.displays["bar"]

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

	skada:SetTexture("Interface\\AddOns\\oUF_mono\\media\\statusbar2.tga")
	skada:SetSpacing(barSpacing)
	skada:SetBarHeight(16)
	--skada:SetFont(STANDARD_TEXT_FONT, 10, "PLAIN")
	skada:SetFrameLevel(5)
	
	skada:SetBackdrop(nil)
	hooksecurefunc(Skada, "OpenReportWindow", function(self)
		if not self.ReportWindow.frame.reskinned then
			--StripTextures(self.ReportWindow.frame)
			--CreateStyle(self.ReportWindow.frame, 2)
			self.ReportWindow.frame.reskinned = true
		end
	end)
	
	SkadaBarWindowSkada:ClearAllPoints()
	SkadaBarWindowSkada:SetClampedToScreen(false)
	SkadaBarWindowSkada:SetPoint("TOPLEFT",rightPanel2 ,"TOPLEFT",3, -19)
	SkadaBarWindowSkada:SetSize(rightPanel2:GetWidth() -6, rightPanel2:GetHeight() -19)
end

for _, window in ipairs(Skada:GetWindows()) do
	window:UpdateDisplay()
end

--[[
function EmbedSkada()
	for _, window in ipairs(Skada:GetWindows()) do
		window:UpdateDisplay()
	end
end

local Skada_Skin = CreateFrame("Frame")
Skada_Skin:RegisterEvent("PLAYER_ENTERING_WORLD")
Skada_Skin:SetScript("OnEvent", function(self)
	SkadaBarWindowSkada:SetAlpha(0)
	self:UnregisterAllEvents()
	
	local index = 0
	Skada_Skin:SetScript("OnUpdate", function(self, elapsed)
		index = index +1
		if index < 10 then return end
		Skada_Skin:SetScript("OnUpdate", nil)
		
		SkadaBarWindowSkada:SetAlpha(1)
		EmbedSkada()
	end)
end)]]
