local addon, ns = ...
local lib = CreateFrame("Frame")

local FrameTable = FrameTable or {}
function lib.getFrame(name)
	for num,aframe in pairs(FrameTable) do
		if  aframe:GetName() == name then
			return aframe
		end
	end
end

lib.formatNumber = function(val)
	if val then
		if (val >= 1e8) then
			return ("%de"):format(val / 1e8)
		elseif (val >= 1e4) then
			return ("%.1fw"):format(val / 1e4)
		else
			return ("%d"):format(val)
		end
	end
end

local uiscale = min(2, max(0.64, 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)"))) 
local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / uiscale 

--print("mult"..mult)
function CreateTheFrame(f)
	local F = CreateFrame("Frame", nil, f)
	F:SetFrameLevel(3)
	F:SetPoint("TOPLEFT", -1 * mult, 1 * mult)
	F:SetPoint("BOTTOMRIGHT", 1 * mult, -1 * mult)
	F:SetBackdrop({edgeFile = "Interface\\Addons\\PSDKHelper\\media\\backdrop.tga", edgeSize = 4})
	F:SetBackdropColor(.05, .05, .05, .6)
	F:SetBackdropBorderColor(0,0,0)
	
	F.Border = CreateFrame("Frame", nil, F)
    F.Border:SetPoint("TOPLEFT", 3 , -3 )
    F.Border:SetPoint("BOTTOMRIGHT", -3 , 3 )
    F.Border:SetBackdrop({ 
		edgeFile = "Interface\\Buttons\\WHITE8x8" , edgeSize = 1,
	 })
    F.Border:SetBackdropBorderColor(49/255, 213/255, 78/255,1)
	--F.Border:SetBackdropBorderColor(1,1,1,1)
    --F.Border:SetFrameLevel(4)
	
	f.icon = f:CreateTexture(nil, "ARTWORK")
	f.icon:SetPoint("TOPLEFT", 3 * mult, -3 * mult)
	f.icon:SetPoint("BOTTOMRIGHT", -3 * mult, 3 * mult)
	f.icon:SetTexCoord(.08, .92, .08, .92)
	f.text = f:CreateFontString(nil, "OVERLAY")
	f.text:SetFont(cfg.font, cfg.fontsize, cfg.fontflag)
	f.text:SetPoint("TOP", f, "BOTTOM")
	f.cooldown = CreateFrame("Cooldown", nil, f) 
	f.cooldown:SetPoint("TOPLEFT", 3 * mult, -3 * mult)
	f.cooldown:SetPoint("BOTTOMRIGHT", -3 * mult, 3 * mult)
	f.cooldown:SetReverse(true)
	f.count = f.cooldown:CreateFontString(nil, "OVERLAY") 
	f.count:SetFont(cfg.font, cfg.iconsize/2.2, "THINOUTLINE") 
	f.count:SetPoint("BOTTOMRIGHT", 2, -2)
end

function lib.cFrame(parent, name, spellId)
	local f = CreateFrame("Frame", name, parent)
	local size = cfg.iconsize
	f:SetSize(size, size)
	CreateTheFrame(f)
	f.id = spellId
	f.icon:SetTexture(select(3, GetSpellInfo(f.id)))
	tinsert(FrameTable, f)
	return f
end

DKHelperDB = DKHelperDB or {}
function lib.cAnchor(parent, name, pos)
	local f = CreateFrame("Frame", name, parent)
	f:SetSize(cfg.iconsize/2, cfg.iconsize/2)
	if not DKHelperDB[name] then 
		f:SetPoint(unpack(pos))
	else
		f:SetPoint(unpack(DKHelperDB[name]))		
	end
	f:SetBackdrop({ 
		bgFile = "Interface\\Buttons\\WHITE8x8" ,
	 })
	f:SetBackdropColor(0, 1, 0)
	f.text = f:CreateFontString(nil, "OVERLAY")
	f.text:SetFont(cfg.font, cfg.fontsize, "THINOUTLINE")
	f.text:SetPoint("TOP", f, "BOTTOM")
	f.text:SetText(name)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:RegisterForDrag("LeftButton")
	f:Hide()
	f:SetScript("OnDragStart", function(self) self:StartMoving() end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local AnchorF, _, AnchorT, ax, ay = self:GetPoint()
		DKHelperDB[name] = {AnchorF, "UIParent", AnchorT, ax, ay}
	end)
	Anchor = f
	return Anchor
end

ns.lib = lib