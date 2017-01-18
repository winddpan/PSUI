-- Author      : Kurapica

-- Check Version
local version = 5

if not IGAS:NewAddon("IGAS.Special.MsgBox", version) then
	return
end

import "System"
import "System.Widget"

tinsert = table.insert
tremove = table.remove
strfind = string.find
strlower = string.lower
_Queue = _Queue or {}
_MaxQueue = 10

frmPop = PopupDialog("IGAS_GUI_MSGBOX", UIParent)
frmPop.Style = "LIGHT"
frmPop.OkayButtonText = L"Okay"
frmPop.NoButtonText = L"No"
frmPop.CancelButtonText = L"Cancel"
frmPop.ShowWhileDead = true

function ShowDialog(_Message, _Map, _KeyList, _Callback, _Thread)
	frmPop.Message = _Message
	frmPop.ShowNoButton = (strfind(_Map, "n") and true) or false
	frmPop.ShowCancelButton = (strfind(_Map, "c") and true) or false
	frmPop.ShowInputBox = (strfind(_Map, "i") and true) or false
	frmPop.Input:Clear()
	frmPop.Text = ""
	frmPop.__CallBack = _Callback or _Thread

	if frmPop.ShowInputBox and type(_KeyList) == "table" and next(_KeyList) then
		frmPop.Input.HideDropDownButton = false
		frmPop.Input.Editable = false
		frmPop.Input.AutoFocus = false

		frmPop.Input:SetList(_KeyList)
	else
		frmPop.Input.HideDropDownButton = true
		frmPop.Input.Editable = true
		frmPop.Input.AutoFocus = true
	end

	frmPop.Visible = true
end

function frmPop:OnHide()
	if _Queue[1] then
		local info = _Queue[1]
		tremove(_Queue, 1)

		return ShowDialog(info.Message, info.Map, info.KeyList, info.Callback, info.Thread)
	end
end

function frmPop:OnOkay()
	if not self.__CallBack then
		return
	end
	if self.ShowInputBox then
		return self.__CallBack(self.Text)
	else
		return self.__CallBack(true)
	end
end

function frmPop:OnNo()
	if not self.__CallBack then
		return
	end
	if self.ShowInputBox then
		return self.__CallBack(nil)
	else
		return self.__CallBack(false)
	end
end

function frmPop:OnCancel()
	if not self.__CallBack then
		return
	end
	if self.ShowInputBox then
		return self.__CallBack(nil)
	else
		return self.__CallBack(nil)
	end
end

------------------------------------
--- Show a custom popup dialog
-- @name IGAS:MsgBox
-- @class function
-- @param _Message The message to be displayed in the popupdialog.
-- @param _Map Combined by "n", "c", "i", "n" means show No Button, "c" means show Cancel Button, "i" means show the input box
-- @param _KeyList Optional,a list contains some strings to be selected for the input box.
-- @param _Callback The function to receive the result.If input box is showed, and okay button is clicked the text would be passed in, click other button, would be nil. If input box is hidden, okay button pass true, no button pass false, cancel button pass nil.
-- @return nil
-- @usage IGAS:MsgBox("Hello World!!!", "nc") will show a dialog with message "Hello World!!!", and three button with text "Okay" and "NO", "Cancel"
------------------------------------
function IGAS:MsgBox(_Message, _Map, _KeyList, _Callback)
	if type(_Message) ~= "string" then
		error("Usage : IGAS:MsgBox(message, map[, keylist][,callback]) - 'message' must be string.", 2)
	end
	if not _Map or type(_Map) ~= "string" then
		_Map = ""
	end

	if type(_KeyList) == "function" then
		_KeyList, _Callback = _Callback, _KeyList
	end

	if _Callback and type(_Callback) ~= "function" then
		error("Usage : IGAS:MsgBox(message, map[, keylist][,callback]) - 'callback' must be function.", 2)
	end

	_Map = strlower(_Map)

	local _Thread = System.Threading.Thread()

	if frmPop.Visible then
		if #_Queue < _MaxQueue then
			tinsert(_Queue, {["Message"] = _Message, ["Map"] = _Map, ["Callback"] = _Callback, ["KeyList"] = _KeyList, ["Thread"] = _Thread})
		else
			error("Too many request for MsgBox.", 2)
		end
	else
		ShowDialog(_Message, _Map, _KeyList, _Callback, _Thread)
	end

	if not _Callback then
		return _Thread:Yield()
	end
end
