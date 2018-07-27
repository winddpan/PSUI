local B, C, L, DB = unpack(select(2, ...))

-- Colors
DB.MyClass = select(2, UnitClass("player"))
DB.ClassColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[DB.MyClass]

-- Fonts
DB.Font = {STANDARD_TEXT_FONT, 15, "OUTLINE"}

-- Textures
local Media = "Interface\\Addons\\LightAO\\Media\\"
DB.bgTex = Media.."bgTex"
DB.glowTex = Media.."glowTex"

DB.bdTex = "Interface\\ChatFrame\\ChatFrameBackground"

-- Function
local cr, cg, cb = DB.ClassColor.r, DB.ClassColor.g, DB.ClassColor.b

-- Create Backdrop
B.CreateBD = function(f, a, s, square)
	f:SetBackdrop({
		bgFile = DB.bdTex, edgeFile = square and DB.bdTex or DB.glowTex, edgeSize = s or 3,
		insets = {left = s or 3, right = s or 3, top = s or 3, bottom = s or 3},
	})
	f:SetBackdropColor(0, 0, 0, a or .5)
	f:SetBackdropBorderColor(0, 0, 0)
end

-- Create Shadow
B.CreateSD = function(f, m, s)
	if f.Shadow then return end
	local frame = f
	if f:GetObjectType() == "Texture" then frame = f:GetParent() end
	local lvl = frame:GetFrameLevel()

	f.Shadow = CreateFrame("Frame", nil, frame)
	f.Shadow:SetPoint("TOPLEFT", f, -m, m)
	f.Shadow:SetPoint("BOTTOMRIGHT", f, m, -m)
	f.Shadow:SetBackdrop({
		edgeFile = DB.glowTex, edgeSize = s })
	f.Shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.Shadow:SetFrameLevel(lvl == 0 and 1 or lvl - 1)
	return f.Shadow
end

-- Create Skin
B.CreateTex = function(f)
	if f.Tex then return end
	local frame = f
	if f:GetObjectType() == "Texture" then frame = f:GetParent() end

	f.Tex = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.Tex:SetAllPoints()
	f.Tex:SetTexture(DB.bgTex, true, true)
	f.Tex:SetHorizTile(true)
	f.Tex:SetVertTile(true)
	f.Tex:SetBlendMode("ADD")
end

-- Frame Text
B.CreateFS = function(f, size, text, classcolor, anchor, x, y)
	local fs = f:CreateFontString(nil, "OVERLAY")
	fs:SetFont(DB.Font[1], size, DB.Font[3])
	fs:SetText(text)
	fs:SetWordWrap(false)
	if classcolor then
		fs:SetTextColor(cr, cg, cb)
	end
	if anchor and x and y then
		fs:SetPoint(anchor, x, y)
	else
		fs:SetPoint("CENTER", 1, 0)
	end
	return fs
end

-- Numberize
B.Numb = function(n)
	if type(n) == "number" then
		if n >= 1e8 then
			return ("%.2f亿"):format(n / 1e8)
		elseif n >= 1e4 then
			return ("%.1f万"):format(n / 1e4)
		else
			return ("%.0f"):format(n)
		end
	else
		return n
	end
end