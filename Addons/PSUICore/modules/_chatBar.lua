-- pixel perfect script of custom ui scale.
local scale = min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")))
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/scale
local function scale(x)
    return mult*math.floor(x/mult+.5)
end
function Scale(x) return scale(x) end
mult = mult

local addon = CreateFrame('Frame', 'qChatBar', qChatBar)
addon:SetScript('OnEvent', function(self, event, ...) self[event](self, event, ...) end)
addon:RegisterEvent('ADDON_LOADED')

local font = STANDARD_TEXT_FONT
local texture = "Interface\\Buttons\\WHITE8x8"

function framechat(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = mult, right = mult, top = mult, bottom = mult} 
	})
	f:SetBackdropBorderColor(.15,.15,.15,0)	
end

local height, width = 11, 11

function addon:S(button)
ChatFrame_OpenChat("/s ", SELECTED_DOCK_FRAME);	
end
function addon:W(button)
ChatFrame_OpenChat("/w ", SELECTED_DOCK_FRAME);		
end
function addon:G(button)
ChatFrame_OpenChat("/g ", SELECTED_DOCK_FRAME);	
end
function addon:O(button)
ChatFrame_OpenChat("/o ", SELECTED_DOCK_FRAME);		
end
function addon:P(button)
ChatFrame_OpenChat("/p ", SELECTED_DOCK_FRAME);	
end
function addon:R(button)
ChatFrame_OpenChat("/raid ", SELECTED_DOCK_FRAME);
end
function addon:GE(button)
ChatFrame_OpenChat("/1 ", SELECTED_DOCK_FRAME);		
end
function addon:T(button)
ChatFrame_OpenChat("/2 ", SELECTED_DOCK_FRAME);		
end
function addon:D(button)
ChatFrame_OpenChat("/3 ", SELECTED_DOCK_FRAME);	
end
function addon:Y(button)
ChatFrame_OpenChat("/y ", SELECTED_DOCK_FRAME);		
end

function addon:Style()
	qChatBar:ClearAllPoints()
	qChatBar:SetParent(chatbar)
	
	s = CreateFrame('Button', 's', qChatBar)
    s:ClearAllPoints()
	s:SetParent(qChatBar)
	s:SetPoint("TOP", chatbar, "TOP", 0, -1)
	s:SetWidth(width)
	s:SetHeight(height)
	framechat(s)
	s:SetBackdropColor(1,1,1,1)
	s:RegisterForClicks('AnyUp')
	s:SetScript('OnClick', addon.S)	
	
	
	w = CreateFrame('Button', 'w', qChatBar)
    w:ClearAllPoints()
	w:SetParent(qChatBar)
	w:SetPoint("RIGHT", s, "RIGHT", 0, -12)
	w:SetWidth(width)
	w:SetHeight(height)
	framechat(w)
	w:SetBackdropColor(.7,.33,.82, 1) 
	w:RegisterForClicks('AnyUp')
	w:SetScript('OnClick', addon.W)
	
    g = CreateFrame('Button', 'g', qChatBar)
    g:ClearAllPoints()
	g:SetParent(qChatBar)
	g:SetPoint("RIGHT", w, "RIGHT", 0, -12)
	g:SetWidth(width)
	g:SetHeight(height)
	framechat(g)
	g:SetBackdropColor(0,.8,0,1) 
	g:RegisterForClicks('AnyUp')
	g:SetScript('OnClick', addon.G)	
	
	
    o = CreateFrame('Button', 'o', qChatBar)
    o:ClearAllPoints()
	o:SetParent(qChatBar)
	o:SetPoint("RIGHT", g, "RIGHT", 0, -12)
	o:SetWidth(width)
	o:SetHeight(height)
	framechat(o)
	o:SetBackdropColor(0,.54,0, 1) 
	o:RegisterForClicks('AnyUp')
	o:SetScript('OnClick', addon.O)	
	
	
    r = CreateFrame('Button', 'r', qChatBar)
	r:ClearAllPoints()
	r:SetParent(qChatBar)
	r:SetPoint("RIGHT", o, "RIGHT", 0, -12)
	r:SetWidth(width)
	r:SetHeight(height)
	framechat(r)
	r:SetBackdropColor(.8,.4,.1, 1)
	r:RegisterForClicks('AnyUp')
    r:SetScript('OnClick', addon.R)	
    
	
	p = CreateFrame('Button', 'p', qChatBar)
	p:ClearAllPoints()
	p:SetParent(qChatBar)
	p:SetPoint("RIGHT", r, "RIGHT", 0, -12)
	p:SetWidth(width)
	p:SetHeight(height)
	framechat(p)
	p:SetBackdropColor(.11,.5,.7, 1)
	p:RegisterForClicks('AnyUp')
    p:SetScript('OnClick', addon.P)	
	
	ge = CreateFrame('Button', 'ge', qChatBar)
	ge:ClearAllPoints()
	ge:SetParent(qChatBar)
	ge:SetPoint("RIGHT", p, "RIGHT", 0, -12)
	ge:SetWidth(width)
	ge:SetHeight(height)
	framechat(ge)
	ge:SetBackdropColor(.7,.7,0, 1)
	ge:RegisterForClicks('AnyUp')
    ge:SetScript('OnClick', addon.GE)
	
    t = CreateFrame('Button', 't', qChatBar)
	t:ClearAllPoints()
	t:SetParent(qChatBar)
	t:SetPoint("RIGHT", ge, "RIGHT", 0, -12)
	t:SetWidth(width)
	t:SetHeight(height)
	framechat(t)
	t:SetBackdropColor(.7,.7,0, 1)
	t:RegisterForClicks('AnyUp')
    t:SetScript('OnClick', addon.T)
	
    d = CreateFrame('Button', 'd', qChatBar)
	d:ClearAllPoints()
	d:SetParent(qChatBar)
	d:SetPoint("RIGHT", t, "RIGHT", 0, -12)
	d:SetWidth(width)
	d:SetHeight(height)
	framechat(d)
	d:SetBackdropColor(.7,.7,0, 1)
	d:RegisterForClicks('AnyUp')
    d:SetScript('OnClick', addon.D)
	
	y = CreateFrame('Button', 'y', qChatBar)
	y:ClearAllPoints()
	y:SetParent(qChatBar)
	y:SetPoint("RIGHT", d, "RIGHT", 0, -12)
	y:SetWidth(width)
	y:SetHeight(height)
	framechat(y)
	y:SetBackdropColor(1,0,0, 1)
	y:RegisterForClicks('AnyUp')
    y:SetScript('OnClick', addon.Y)	
    
end

function addon:ADDON_LOADED(event, name)	
self:Style()	
end