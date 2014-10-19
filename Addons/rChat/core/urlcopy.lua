
  local color = "0099FF"
  local foundurl = false

  function string.color(text, color)
    return "|cff"..color..text.."|r"
  end

  function string.link(text, type, value, color)
    return "|H"..type..":"..tostring(value).."|h"..tostring(text):color(color or "ffffff").."|h"
  end

  local function highlighturl(before,url,after)
    foundurl = true
    return " "..string.link("["..url.."]", "url", url, color).." "
  end

  local function searchforurl(frame, text, ...)

    foundurl = false

    if string.find(text, "%pTInterface%p+") or string.find(text, "%pTINTERFACE%p+") then
      --disable interface textures (lol)
      foundurl = true
    end

    if not foundurl then
      --192.168.1.1:1234
      text = string.gsub(text, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)(%s?)", highlighturl)
    end
    if not foundurl then
      --192.168.1.1
      text = string.gsub(text, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?)(%s?)", highlighturl)
    end
    if not foundurl then
      --www.teamspeak.com:3333
      text = string.gsub(text, "(%s?)([%w_-]+%.?[%w_-]+%.[%w_-]+:%d%d%d?%d?%d?)(%s?)", highlighturl)
    end
    if not foundurl then
      --http://www.google.com
      text = string.gsub(text, "(%s?)(%a+://[%w_/%.%?%%=~&-'%-]+)(%s?)", highlighturl)
    end
    if not foundurl then
      --www.google.com
      text = string.gsub(text, "(%s?)(www%.[%w_/%.%?%%=~&-'%-]+)(%s?)", highlighturl)
    end
    if not foundurl then
      --lol@lol.com
      text = string.gsub(text, "(%s?)([_%w-%.~-]+@[_%w-]+%.[_%w-%.]+)(%s?)", highlighturl)
    end

    frame.am(frame,text,...)

  end

  for i = 1, NUM_CHAT_WINDOWS do
    if ( i ~= 2 ) then
      local cf = _G["ChatFrame"..i]
      cf.am = cf.AddMessage
      cf.AddMessage = searchforurl
    end
  end

  local orig = ChatFrame_OnHyperlinkShow
  function ChatFrame_OnHyperlinkShow(frame, link, text, button)
    local type, value = link:match("(%a+):(.+)")
    if ( type == "url" ) then
      --local eb = _G[frame:GetName()..'EditBox'] --sometimes this is not the active chatbox. thus use the last active one for this
      local eb = LAST_ACTIVE_CHAT_EDIT_BOX or _G[frame:GetName()..'EditBox']
      if eb then
        eb:SetText(value)
        eb:SetFocus()
        eb:HighlightText()
      end
    else
      orig(self, link, text, button)
    end
  end