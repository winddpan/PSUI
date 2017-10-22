local _, T = ...

local function L(key)
	local o = OneRingLib and OneRingLib.lang
	return o and o(key) or key
end

local multilineInput do
	local function onNavigate(self, _x,y, _w,h)
		local scroller = self.scroll
		local occH, occP, y = scroller:GetHeight(), scroller:GetVerticalScroll(), -y
		if occP > y then
			occP = y -- too far
		elseif (occP + occH) < (y+h) then
			occP = y+h-occH -- not far enough
		else
			return
		end
		scroller:SetVerticalScroll(occP)
		local _, mx = scroller.ScrollBar:GetMinMaxValues()
		scroller.ScrollBar:SetMinMaxValues(0, occP < mx and mx or occP)
		scroller.ScrollBar:SetValue(occP)
	end
	local function onClick(self)
		self.input:SetFocus()
	end
	function multilineInput(name, parent, width)
		local scroller = CreateFrame("ScrollFrame", name .. "Scroll", parent, "UIPanelScrollFrameTemplate")
		local input = CreateFrame("Editbox", name, scroller)
		input:SetWidth(width)
		input:SetMultiLine(true)
		input:SetAutoFocus(false)
		input:SetTextInsets(2,4,0,2)
		input:SetFontObject(GameFontHighlight)
		input:SetScript("OnCursorChanged", onNavigate)
		scroller:EnableMouse(1)
		scroller:SetScript("OnMouseDown", onClick)
		scroller:SetScrollChild(input)
		input.scroll, scroller.input = scroller, input
		return input, scroller
	end
end

do -- .macrotext
	local bg = CreateFrame("Frame")
	bg:SetBackdrop({edgeFile="Interface/Tooltips/UI-Tooltip-Border", bgFile="Interface/DialogFrame/UI-DialogBox-Background-Dark", tile=true, edgeSize=16, tileSize=16, insets={left=4,right=4,bottom=4,top=4}})
	bg:SetBackdropBorderColor(0.7,0.7,0.7)
	bg:SetBackdropColor(0,0,0,0.7)
	bg:Hide()
	local eb, scroll = multilineInput("ABE_MacroInput", bg, 511)
	eb:SetScript("OnEscapePressed", eb.ClearFocus)
	eb:SetScript("OnEditFocusLost", function()
		local p = bg:GetParent()
		p = p and p.SaveAction and p:SaveAction()
	end)
	scroll:SetPoint("TOPLEFT", 5, -4)
	scroll:SetPoint("BOTTOMRIGHT", -26, 4)
	eb:SetHyperlinksEnabled(true)
	eb:SetScript("OnHyperlinkClick", function(self, link, text, button)
		local pos = string.find(self:GetText(), text, 1, 1)-1
		self:HighlightText(pos, pos + #text)
		if button == "RightButton" and link:match("^rk%d+:") then
			local replace = IsAltKeyDown() and text:match("|h(.-)|h") or ("{{" .. link:match("^rk%d+:(.+)") .. "}}")
			self:Insert(replace)
			self:HighlightText(pos, pos + #replace)
		else
			self:SetCursorPosition(pos + #text)
		end
		self:SetFocus()
	end)
	
	local decodeSpellLink do
		local names, tag = {}, 0
		function decodeSpellLink(sid)
			local tname
			for id in sid:gmatch("%d+") do
				local name = GetSpellInfo(tonumber(id))
				if name and names[name] ~= tag then
					names[name], tname = tag, (tname and (tname .. " / ") or "") .. name
				end
			end
			tag = tag + 1
			return tname and ("|cff71d5ff|Hrkspell:" .. sid .. "|h" .. tname .. "|h|r")
		end
	end
	local tagCounter = 0
	local function tagReplace()
		tagCounter = tagCounter + 1
		return "|Hrk" .. tagCounter .. ":"
	end
	function bg:SetAction(owner, action)
		bg:SetParent(nil)
		bg:ClearAllPoints()
		bg:SetAllPoints(owner)
		bg:SetParent(owner)
		bg:Show()
		tagCounter = 0
		eb:SetText((
			(action[1] == "macrotext" and type(action[2]) == "string" and action[2] or "")
			:gsub("{{spell:([%d/]+)}}", decodeSpellLink)
			:gsub("{{mount:ground}}", "|cff71d5ff|Hrkmount:ground|h" .. L"Ground Mount" .. "|h|r")
			:gsub("{{mount:air}}", "|cff71d5ff|Hrkmount:air|h" .. L"Flying Mount" .. "|h|r")
			:gsub("|Hrk", tagReplace)
		))
	end
	function bg:GetAction(into)
		local text = eb:GetText():gsub("|c%x+|Hrk%d+:([%a:%d/]+)|h.-|h|r", "{{%1}}")
		local RK = OneRingLib.ext.RingKeeper
		text = RK:QuantizeMacro(text)
		for i=#into,1,-1 do
			into[i] = nil
		end
		into[1], into[2] = "macrotext", text
	end
	function bg:Release(owner)
		if bg:IsOwned(owner) then
			bg:SetParent(nil)
			bg:ClearAllPoints()
			bg:Hide()
		end
	end
	function bg:IsOwned(owner)
		return bg:GetParent() == owner
	end
	bg.editBox, bg.scrollFrame = bg, eb
	do -- Hook linking
		local old = ChatEdit_InsertLink
		function ChatEdit_InsertLink(link, ...)
			if GetCurrentKeyBoardFocus() == eb then
				local isEmpty = eb:GetText() == ""
				if link:match("item:") then
					eb:Insert((isEmpty and (GetItemSpell(link) and SLASH_USE1 or SLASH_EQUIP1) or "") .. " " .. GetItemInfo(link))
				elseif link:match("spell:") and not IsPassiveSpell(tonumber(link:match("spell:(%d+)"))) then
					eb:Insert((isEmpty and SLASH_CAST1 or "") .. " " .. decodeSpellLink(link:match("spell:(%d+)")):gsub("|Hrk", tagReplace))
				else
					eb:Insert(link:match("|h%[?(.-[^%]])%]?|h"))
				end
				return true
			else
				return old(link, ...)
			end
		end
	end
	T.TEMP_AB_EDITORS = {macrotext=bg}
end