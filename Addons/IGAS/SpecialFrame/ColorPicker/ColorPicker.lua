-- Author      : Kurapica

do
	-- Check Version
	local version = 2

	if not IGAS:NewAddon("IGAS.Special.ColorPicker", version) then
		return
	end

	import "System"
	import "System.Widget"

	local tinsert = table.insert
	local tremove = table.remove
	local getn = table.getn
	local strfind = string.find
	local strlower = string.lower
	local _Queue = {}
	local _MaxQueue = 10
	local UIParent = IGAS.UIParent

	local frmColorPicker = ColorPicker("IGAS_GUI_COLORPICKER", UIParent)
	frmColorPicker.Caption = L"Color Picker"
	frmColorPicker.OkayButtonText = L"Okay"
	frmColorPicker.CancelButtonText = L"Cancel"
	frmColorPicker.Visible = false

	-- Special settings for dropdownlist
    local _DropDownListContainer = Frame("IGAS_GUI_ListContainer", UIParent)
	local _DropDownColorPicker =ColorPicker("DropDownColorPicker", _DropDownListContainer)
	_DropDownColorPicker.Caption = L"Color Picker"
	_DropDownColorPicker.OkayButtonText = L"Okay"
	_DropDownColorPicker.CancelButtonText = L"Cancel"

	-- Show the dialog
	local function ShowDialog(callback, red, green, blue, alpha)
		frmColorPicker.__CallBack = callback

		frmColorPicker.HasOpacity = alpha

		frmColorPicker:SetColor(red, green, blue, alpha or 1)

		frmColorPicker.Visible = true
	end

	function frmColorPicker:OnHide()
		if _Queue[1] then
			local info = _Queue[1]
			tremove(_Queue, 1)

			return ShowDialog(info.Callback, info.Red, info.Green, info.Blue, info.Alpha)
		end
	end

	function frmColorPicker:OnColorPicked(red, green, blue, alpha)
		if not self.__CallBack and type(self.__CallBack) ~= "function" then
			return
		end

		return self.__CallBack(red, green, blue, alpha)
	end

	------------------------------------
	--- Show a custom color pick dialog
	-- @name IGAS:ColorPick
	-- @class function
	-- @param _Callback The function to receive the result.
	-- @param _Red The default red color (0 - 1)
	-- @param _Green The default green color (0 - 1)
	-- @param _Blue The default blue color (0 - 1)
	-- @param _Alpha Optinal,The default opacity (0 - 1)
	-- @return nil
	-- @usage IGAS:ColorPick(function(...) MyFrame:SetBackdropColor(...) end,1, 0, 0, 0.3)
	------------------------------------
	function IGAS:ColorPick(_Callback, _Red, _Green, _Blue, _Alpha)
		if _Callback and type(_Callback) ~= "function" then
			error("The callback must be a function", 2)
		end

		_Red = (_Red and type(_Red) == "number" and _Red >= 0 and _Red <= 1 and _Red) or 1
		_Green = (_Green and type(_Green) == "number" and _Green >= 0 and _Green <= 1 and _Green) or 1
		_Blue = (_Blue and type(_Blue) == "number" and _Blue >= 0 and _Blue <= 1 and _Blue) or 1
		_Alpha = (_Alpha and type(_Alpha) == "number" and _Alpha >= 0 and _Alpha <=1 and _Alpha) or nil

		if frmColorPicker.Visible then
			if getn(_Queue) < _MaxQueue then
				return tinsert(_Queue, {["Callback"] = _Callback, ["Red"] = _Red, ["Green"] = _Green, ["Blue"] = _Blue, ["Alpha"] = _Alpha})
			else
				error("Too many request for MsgBox.", 2)
			end
		end

		return ShowDialog(_Callback, _Red, _Green, _Blue, _Alpha)
	end
end
