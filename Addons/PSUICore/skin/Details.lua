if not IsAddOnLoaded("Details") then return end

DetailsBaseFrame1:ClearAllPoints()
DetailsBaseFrame1:SetClampedToScreen(false)
DetailsBaseFrame1:SetPoint("TOPLEFT",rightPanel2 ,"TOPLEFT",3, -19)
DetailsBaseFrame1:SetSize(rightPanel2:GetWidth() -6, rightPanel2:GetHeight() -19)