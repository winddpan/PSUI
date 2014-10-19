  local addon, ns = ...
  local lib = CreateFrame("Frame")
  
  function lib.createShadow(f , w)
     if f.Shadow then return end
	 width = w or 4
     f:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground"})
     f:SetBackdropColor(.05, .05, .05, .66)
     local Shadow = CreateFrame("Frame", nil, f)
     Shadow:SetFrameLevel(0)
     Shadow:SetPoint("TOPLEFT", -width, width)
     Shadow:SetPoint("BOTTOMRIGHT", width, -width)
     Shadow:SetBackdrop({edgeFile = "Interface\\Addons\\PSRune\\media\\textureGlow", edgeSize = width})
     Shadow:SetBackdropBorderColor(0, 0, 0, 1)
     f.Shadow = Shadow
     return Shadow
  end
  
  function lib.cAnchor(parent, name, default_pos)
	local f = CreateFrame("Frame", name, parent)
	f:SetSize(30, 30)
	f:SetPoint(unpack(default_pos))
	f:SetBackdrop({ 
		bgFile = "Interface\\Buttons\\WHITE8x8" ,
	 })
	f:SetBackdropColor(0, 1, 0, 0.5)
	--f.text = f:CreateFontString(nil, "OVERLAY")
	--f.text:SetFont(cfg.font, 12, "THINOUTLINE")
	--f.text:SetPoint("TOP", f, "BOTTOM")
	--f.text:SetText(name)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:RegisterForDrag("LeftButton")
	f:Hide()
	f:SetScript("OnDragStart", function(self) self:StartMoving() end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)
	return f
end


  ns.lib = lib