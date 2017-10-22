local _, T = ...
local gfxBase = ([[Interface\AddOns\%s\gfx\]]):format((...))

local function cc(m, f, ...)
	f[m](f, ...)
	return f
end
local darken do
	local CSL = CreateFrame("ColorSelect")
	function darken(r,g,b, vf, sf)
		CSL:SetColorRGB(r,g,b)
		local h,s,v = CSL:GetColorHSV()
		CSL:SetColorHSV(h, s*(sf or 1), v*(vf or 1))
		return CSL:GetColorRGB()
	end
end
local function shortBindName(bind)
	local a, s, c, k = bind:match("ALT%-"), bind:match("SHIFT%-"), bind:match("CTRL%-"), bind:match("[^-]*.$"):gsub("^(.).-(%d+)$","%1%2")
	return (a and "A" or "") .. (s and "S" or "") .. (c and "C" or "") .. k
end
local CreateQuadTexture do
	local function qf(f)
		return function (self, ...)
			for i=1,4 do
				local v = self[i]
				v[f](v, ...)
			end
		end
	end
	local quadPoints, quadTemplate = {"BOTTOMRIGHT", "BOTTOMLEFT", "TOPLEFT", "TOPRIGHT"}, {__index={SetVertexColor=qf("SetVertexColor"), SetAlpha=qf("SetAlpha"), SetShown=qf("SetShown")}}
	function CreateQuadTexture(layer, size, file, parent, qparent)
		local group, size = setmetatable({}, quadTemplate), size/2
		for i=1,4 do
			local tex, d, l = cc("SetSize", cc("SetTexture", (parent or qparent[i]):CreateTexture(nil, layer), file), size, size), i > 2, 2 > i or i > 3
			tex:SetTexCoord(l and 0 or 1, l and 1 or 0, d and 1 or 0, d and 0 or 1)
			group[i] = cc("SetPoint", tex, quadPoints[i], parent or qparent[i], parent and "CENTER" or quadPoints[i])
		end
		return group
	end
end

local function cooldownFormat(cd)
	if (cd or 0) == 0 then return "" end
	local f, n, unit = cd >= 9.95 and "%d%s" or "%.1f", cd, ""
	if n > 86400 then n, unit = ceil(n/86400), "d"
	elseif n > 3600 then n, unit = ceil(n/3600), "h"
	elseif n > 89 then n, unit = ceil(n/60), "m"
	elseif n > 60 then f, n, unit = "%d:%02d", n/60, ceil(n % 60)
	elseif cd >= 9.95 then n = ceil(n) end
	return f, n, unit
end

local indicatorAPI = {}
do -- inherit SetPoint, SetScale, GetScale, SetShown, SetParent
	local m = getmetatable(UIParent).__index
	for k in ("SetPoint SetScale GetScale SetShown SetParent"):gmatch("%S+") do
		local f = m[k]
		indicatorAPI[k] = function(self, ...)
			return f(self[0], ...)
		end
	end
end
function indicatorAPI:SetIcon(texture)
	self.icon:SetTexture(texture)
	local ofs = 2.5/64
	self.icon:SetTexCoord(ofs, 1-ofs, ofs, 1-ofs)
end
function indicatorAPI:SetIconTexCoord(a,b,c,d, e,f,g,h)
	if a and b and c and d then
		if e and f and g and h then
			self.icon:SetTexCoord(a,b,c,d, e,f,g,h)
		else
			self.icon:SetTexCoord(a,b,c,d)
		end
	end
end
function indicatorAPI:SetIconVertexColor(r,g,b)
	self.icon:SetVertexColor(r,g,b)
end
function indicatorAPI:SetUsable(usable, _usableCharge, _cd, nomana, norange)
	local state = usable and 0 or (norange and 1 or (nomana and 2 or 3))
	if self.ustate == state then return end
	self.ustate = state
	if not usable and (nomana or norange) then
		self.ribbon:Show()
		if norange then
			self.ribbon:SetVertexColor(1, 0.20, 0.15)
		else
			self.ribbon:SetVertexColor(0.15, 0.75, 1)
		end
	else
		self.ribbon:Hide()
	end
	self.veil:SetAlpha(usable and 0 or 0.40)
end
function indicatorAPI:SetDominantColor(r,g,b)
	r, g, b = r or 1, g or 1, b or 0.6
	local cd, r2, g2, b2 = self.cd, darken(r,g,b, 0.20)
	local r3, g3, b3 = darken(r,g,b, 0.10, 0.50)
	self.hiEdge:SetVertexColor(r, g, b)
	self.iglow:SetVertexColor(r, g, b)
	self.oglow:SetVertexColor(r, g, b)
	self.edge:SetVertexColor(darken(r,g,b, 0.80))
	self.cdText:SetTextColor(r, g, b)
	cd.spark:SetVertexColor(r, g, b)
	for i=1,4 do
		cd[i]:SetVertexColor(r2, g2, b2)
		cd[i+4]:SetVertexColor(r3, g3, b3)
	end
	cd[9]:SetVertexColor(r3, g3, b3)
end
function indicatorAPI:SetOverlayIcon(texture, w, h, ...)
	if not texture then
		self.overIcon:Hide()
	else
		self.overIcon:Show()
		self.overIcon:SetTexture(texture)
		self.overIcon:SetSize(w, h)
		if ... then
			self.overIcon:SetTexCoord(...)
		end
	end
end
function indicatorAPI:SetCount(count)
	self.count:SetText(count or "")
end
function indicatorAPI:SetBinding(binding)
	self.key:SetText(binding and shortBindName(binding) or "")
end
function indicatorAPI:SetCooldown(remain, duration, usable)
	if (duration or 0) <= 0 or (remain or 0) <= 0 then
		self.cd:Hide()
		self.cdText:SetText("")
	else
		local now = GetTime()
		local expire, usable, cd = now + remain, not not usable, self.cd
		local d = expire - (cd.expire or 0)
		if d < -0.05 or d > 0.05 then
			cd.duration, cd.expire, cd.updateCooldownStep, cd.updateCooldown = duration, expire, duration/1536/self[0]:GetEffectiveScale()
			cd:Show()
		end
		if cd.usable ~= usable then
			cd.usable = usable
			for i=1,4 do cd[i]:SetAlpha(usable and 0.45 or 1) end
			for i=5,9 do cd[i]:SetAlpha(usable and 0.25 or 0.85) end
			cd.spark:SetShown(usable)
		end
		local gcS, gcL = GetSpellCooldown(61304)
		if (duration ~= gcL or gcS+gcL-now < remain) and self[usable and "rcTextShown" or "cdTextShown"] then
			self.cdText:SetFormattedText(cooldownFormat(remain))
		else
			self.cdText:SetText("")
		end
	end
end
function indicatorAPI:SetCooldownTextShown(cooldownShown, rechargeShown)
	self.cdTextShown, self.rcTextShown = cooldownShown, rechargeShown
end
function indicatorAPI:SetHighlighted(highlight)
	self.hiEdge:SetShown(highlight)
end
function indicatorAPI:SetActive(active)
	self.iglow:SetShown(active)
end
function indicatorAPI:SetOuterGlow(shown)
	self.oglow:SetShown(shown)
end
function indicatorAPI:SetEquipState(isInContainer, isInInventory)
	local s, v, r, g, b = self.equipBanner, isInContainer or isInInventory, 0.1, 0.9, 0.15
	s:SetShown(v)
	if v then
		if not isInInventory then
			r, g, b = 1, 0.9, 0.2
		end
		s:SetVertexColor(r, g, b)
	end
end

local CreateCooldown do
	local function onUpdate(self, elapsed)
		local ucd, expire, time = self.updateCooldown or 0, self.expire or 0, GetTime()
		if ucd > elapsed and time < expire then
			self.updateCooldown = ucd - elapsed
			return
		end
		self.updateCooldown = self.updateCooldownStep
		local duration, progress = self.duration or 0, expire - time

		if progress >= duration or duration == 0 then
			self:Hide()
		else
			progress = progress < 0 and 0 or (1 - progress/duration)
			local tri, pos, sp, pp, scale = self[9], 1+4*(progress - progress % 0.25), progress % 0.25 >= 0.125, (progress % 0.125) * 8, self.scale
			if self.pos ~= pos then
				for i=1,4 do
					self[i]:SetShown(i >= pos)
					self[4+i]:SetShown(i > pos or (i == pos and not sp))
					if i > pos then
						self[i]:SetSize(24, 24)
						local L, T = i > 2, i == 1 or i == 4
						self[i]:SetTexCoord(L and 0 or 0.5, L and 0.5 or 1, T and 0 or 0.5, T and 0.5 or 1)
						self[4+i]:SetSize(21*scale, 21*scale)
					end
				end
				tri:ClearAllPoints()
				tri:SetPoint((pos % 4 < 2 and "BOTTOM" or "TOP") .. (pos < 3 and "LEFT" or "RIGHT") , self, "CENTER")
				local iH, iV = pos == 2 or pos == 3, pos > 2
				tri:SetTexCoord(iH and 1 or 0, iH and 0 or 1, iV and 1 or 0, iV and 0 or 1)
				self.pos = pos
			end

			local l, r, inv = sp and 21 or (pp * 21), 21 - (sp and pp * 21 or 0), pos == 2 or pos == 4
			l, r = l > 0 and l or 0.00000001, r > 0 and r or 0.00000001
			tri:SetSize((inv and r or l)*scale, (inv and l or r)*scale)

			local chunk, shrunk = self[4+pos], 21 - 21*pp
			chunk:SetSize((inv and 21 or shrunk)*scale, (inv and shrunk or 21)*scale)
			chunk:SetShown(not sp or pp >= 0.9999)

			local p1, p2, e, p1a, p2a = sp and 1 or pp, sp and pp or 0, self[pos]
			if p1 > 0.9 and p2 < 0.1 then
				p1a = 0.9 + (p1 + p2 - 0.9)/2
				p2a = 1-(1.81 - p1a*p1a)^0.5
			else
				p1a, p2a = p1, p2
			end
			if p2 > 0.5 then
			elseif p2 > 0.06 then
				p2 = 0.20 + (p2 - 0.06)*30/44
			elseif p1 > 0.96 then
				p1, p2 = 1, (p2 + p1 - 0.96) * 2
			elseif p1 > 0.56 then
				p1 = p1 + (p1 - 0.56)*0.1
			end
			local p1c, p2c = 24 - 21*p1, 24 - 24*p2
			e:SetSize(inv and p2c or p1c, inv and p1c or p2c)
			if pos == 1 then
				e:SetTexCoord(0.5 + 28/64*p1, 1, 0.5*p2, 0.5)
				self.spark:SetPoint("CENTER", self, "TOP", 22.5 * p1a, -22.5*p2a-1.5)
			elseif pos == 2 then
				e:SetTexCoord(0.5, 1-0.5*p2, 0.5 + 28/64*p1, 1)
				self.spark:SetPoint("CENTER", self, "RIGHT", -22.5*p2a-1.5, -22.5*p1a)
			elseif pos == 3 then
				e:SetTexCoord(0, 0.5 - 28/64*p1, 0.5, 1 - 0.5*p2)
				self.spark:SetPoint("CENTER", self, "BOTTOM", -22.5 * p1a, 1.5+22.5*p2a)
			else
				e:SetTexCoord(0.5*p2, 0.5, 0, 0.5 - 28/64*p1)
				self.spark:SetPoint("CENTER", self, "LEFT", 1.5+22.5*p2a, 22.5*p1a)
			end
			if p2 >= 0.9999 then e:Hide() end
		end
	end
	local function onHide(self)
		local toExpire = GetTime() - (self.expire or 0)
		self.expire, self.pos = nil
		for i=5,9 do self[i]:Hide() end
		if -0.1 < toExpire and toExpire < 0.25 then
			self.flashAG:Play()
		end
		self:Hide()
	end
	local function onShow(self)
		self[9]:Show()
		self.pos = nil -- Forces quad texture update; probably redundant with onHide
		return onUpdate(self, 0)
	end
	function CreateCooldown(parent, size)
		local cd, scale = cc("SetScale", cc("SetAllPoints", CreateFrame("FRAME", nil, parent)), size/48), size * 87/4032
		cc("SetScript", cc("SetScript", cc("SetScript", cd, "OnShow", onShow), "OnHide", onHide), "OnUpdate", onUpdate)
		cd.cdText = cc("SetPoint", cd:CreateFontString(nil, "OVERLAY", "GameFontNormalLargeOutline"), "CENTER")
		
		cd.scale, cd.spark = scale, cc("SetSize", cc("SetTexture", cd:CreateTexture(nil, "OVERLAY", nil, 2), gfxBase .. "spark"), 24, 24)
		local sparkAG = cc("SetLooping", cd.spark:CreateAnimationGroup(), "REPEAT")
		cc("SetDuration", cc("SetDegrees", sparkAG:CreateAnimation("Rotation"), 90), 1/3)
		sparkAG:Play()
		
		cd.flash = cc("SetPoint", cc("SetBlendMode", cc("SetTexture", parent:CreateTexture(nil, "OVERLAY"), [[Interface\cooldown\star4]]), "ADD"), "CENTER")
		cc("SetAlpha", cc("SetSize", cd.flash, 60*size/64, 60*size/64), 0)
		cd.flashAG = cd.flash:CreateAnimationGroup()
		cc("SetDuration", cc("SetDegrees", cd.flashAG:CreateAnimation("ROTATION"), -90), 1/2)
		cc("SetDuration", cc("SetToAlpha", cc("SetFromAlpha", cd.flashAG:CreateAnimation("ALPHA"), 0), 0.7), 1/8)
		cc("SetDuration", cc("SetStartDelay", cc("SetToAlpha", cc("SetFromAlpha", cd.flashAG:CreateAnimation("ALPHA"), 0.7), 0), 1/8), 3/8)
		
		cd[1] = cc("SetPoint", cc("SetTexture", cd:CreateTexture(nil, "ARTWORK"), gfxBase .. "borderlo"), "BOTTOMRIGHT", cd, "RIGHT")
		cd[2] = cc("SetPoint", cc("SetTexture", cd:CreateTexture(nil, "ARTWORK"), gfxBase .. "borderlo"), "BOTTOMLEFT", cd, "BOTTOM")
		cd[3] = cc("SetPoint", cc("SetTexture", cd:CreateTexture(nil, "ARTWORK"), gfxBase .. "borderlo"), "TOPLEFT", cd, "LEFT")
		cd[4] = cc("SetPoint", cc("SetTexture", cd:CreateTexture(nil, "ARTWORK"), gfxBase .. "borderlo"), "TOPRIGHT", cd, "TOP")
		for i=1,4 do
			cd[4+i] = cc("SetPoint", cc("SetColorTexture", parent:CreateTexture(nil, "ARTWORK", nil, 3), 1,1,1),
				(i % 4 < 2 and "TOP" or "BOTTOM") .. (i < 3 and "RIGHT" or "LEFT"), cd, "CENTER", (i < 3 and 21 or -21)*scale, (i % 4 < 2 and 21 or -21)*scale)
		end
		cd[9] = cc("SetTexture", parent:CreateTexture(nil, "ARTWORK", nil, 3), gfxBase .. "tri")
		
		return cd
	end
end

local CreateIndicator do
	local apimeta = {__index=indicatorAPI}
	function CreateIndicator(name, parent, size, nested)
		local e = cc("SetSize", CreateFrame("Frame", name, parent), size, size)
		local cd = CreateCooldown(e, size)
		return setmetatable({[0]=e, cd=cd, cdText=cd.cdText,
			edge = cc("SetAllPoints", cc("SetTexture", e:CreateTexture(nil, "OVERLAY"), gfxBase .. "borderlo")),
			hiEdge = cc("SetAllPoints", cc("SetTexture", e:CreateTexture(nil, "OVERLAY", nil, 1), gfxBase .. "borderhi")),
			oglow = cc("SetShown", CreateQuadTexture("BACKGROUND", size*2, gfxBase .. "oglow", e), false),
			iglow = cc("SetAllPoints", cc("SetAlpha", cc("SetTexture", e:CreateTexture(nil, "ARTWORK", nil, 1), gfxBase .. "iglow"), nested and 0.60 or 1)),
			icon = cc("SetPoint", cc("SetSize", e:CreateTexture(nil, "ARTWORK"), 60*size/64, 60*size/64), "CENTER"),
			veil = cc("SetColorTexture", cc("SetPoint", cc("SetSize", e:CreateTexture(nil, "ARTWORK", nil, 2), 60*size/64, 60*size/64), "CENTER"), 0, 0, 0),
			ribbon = cc("SetShown", cc("SetTexture", cc("SetAllPoints", e:CreateTexture(nil, "ARTWORK", nil, 3)), gfxBase .. "ribbon"), false),
			overIcon = cc("SetPoint", e:CreateTexture(nil, "ARTWORK", nil, 4), "BOTTOMLEFT", e, "BOTTOMLEFT", 4, 4),
			count = cc("SetPoint", cc("SetJustifyH", e:CreateFontString(nil, "OVERLAY", "NumberFontNormalLarge"), "RIGHT"), "BOTTOMRIGHT", -4, 4),
			key = cc("SetPoint", cc("SetJustifyH", e:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmallGray"), "RIGHT"), "TOPRIGHT", -1, -4),
			equipBanner = cc("SetPoint", cc("SetTexCoord", cc("SetTexture", cc("SetSize", e:CreateTexture(nil, "ARTWORK", nil, 2), size/5, size/4), "Interface\\GuildFrame\\GuildDifficulty"), 0, 42/128, 6/64, 52/64), "TOPLEFT", 6*size/64, -3*size/64),
		}, apimeta)
	end
end

T.Mirage = {CreateIndicator=CreateIndicator, _api=indicatorAPI, _CreateQuadTexture=CreateQuadTexture}