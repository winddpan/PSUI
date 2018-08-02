  function UpdateHotkeyText(button)
	local hotkey = _G[button:GetName() .. "HotKey"]
	local text = hotkey:GetText()
	if not text then return end

	text = string.gsub(text, "Capslock", "CAP")
	text = string.gsub(text, "SHIFT%-", "S")
	text = string.gsub(text, "ALT%-", "A")
	text = string.gsub(text, "CTRL%-", "C")
	text = string.gsub(text, "BUTTON", "M")
	text = string.gsub(text, "MOUSEWHEELUP", "MwU")
	text = string.gsub(text, "MOUSEWHEELDOWN", "MwD")
	text = string.gsub(text, "NUMPAD", "NP")
	text = string.gsub(text, "PAGEUP", "PU")
	text = string.gsub(text, "PAGEDOWN", "PD")
	text = string.gsub(text, "SPACE", "SpB")
	text = string.gsub(text, "INSERT", "Ins")
	text = string.gsub(text, "HOME", "Hm")
	text = string.gsub(text, "DELETE", "Del")
	text = string.gsub(text, "NMULTIPLY", "*");
	text = string.gsub(text, "NMINUS", "N-");
	text = string.gsub(text, "NPLUS", "N+");
	text = string.gsub(text, "(s%-)", "S")
	text = string.gsub(text, "(a%-)", "A")
	text = string.gsub(text, "(c%-)", "C")
	text = string.gsub(text, "(Mouse Button )", "M")
	text = string.gsub(text, "(滑鼠按鍵)", "M")
	text = string.gsub(text, "(鼠标按键)", "M")
	text = string.gsub(text, "鼠标中键", "MI")
	text = string.gsub(text, KEY_BUTTON3, "M3")
	text = string.gsub(text, "(Num Pad )", "NP")
	text = string.gsub(text, KEY_PAGEUP, "PU")
	text = string.gsub(text, KEY_PAGEDOWN, "PD")
	text = string.gsub(text, KEY_SPACE, "SpB")
	text = string.gsub(text, KEY_INSERT, "Ins")
	text = string.gsub(text, KEY_HOME, "Hm")
	text = string.gsub(text, KEY_DELETE, "Del")
	text = string.gsub(text, KEY_MOUSEWHEELUP, "MwU")
	text = string.gsub(text, KEY_MOUSEWHEELDOWN, "MwD")

	if hotkey:GetText() == _G["RANGE_INDICATOR"] then
		hotkey:SetText("")
	else
		hotkey:SetText(text)
	end
  end
  
 hooksecurefunc("ActionButton_UpdateHotkeys",  UpdateHotkeyText)

  