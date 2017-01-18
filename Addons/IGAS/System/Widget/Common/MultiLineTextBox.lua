-- Author      : Kurapica
-- Create Date : 8/03/2008 17:14
--              2011/03/13 Recode as class
--              2012/04/04 Row Number is added.
--              2012/04/04 Undo redo system added, plenty function added
--              2012/04/10 Fix the margin click
--              2012/05/13 Fix delete on double click selected multi-text
--              2013/02/07 Recode for scrollForm's change, and fix the double click error
--              2013/05/15 Auto complete function added
--              2013/05/19 Auto pairs function added
--              2013/06/16 Fix undo/redo for tab and shift-tab
--              2013/10/18 Fix the arrow key disabled
--              2015/03/17 Move the auto complate ability to CodeEditor

-- Check Version
local version = 26

if not IGAS:NewAddon("IGAS.Widget.MultiLineTextBox", version) then
	return
end

import "System.Threading"

do
	_GetCursorPosition = _G.GetCursorPosition

	_DBL_CLK_CHK = 0.3
	_FIRST_WAITTIME = 0.3
	_CONTINUE_WAITTIME = 0.03
	_ConcatReturn = nil

	_UTF8_Three_Char = 224
	_UTF8_Two_Char = 192

	_TabWidth = 4

	-- Bytes
	_Byte = setmetatable({
		-- LineBreak
		LINEBREAK_N = strbyte("\n"),
		LINEBREAK_R = strbyte("\r"),

		-- Space
		SPACE = strbyte(" "),
		TAB = strbyte("\t"),

		-- UnderLine
		UNDERLINE = strbyte("_"),

		-- Number
		ZERO = strbyte("0"),
		NINE = strbyte("9"),
		E = strbyte("E"),
		e = strbyte("e"),
		x = strbyte("x"),
		a = strbyte("a"),
		f = strbyte("f"),

		-- String
		SINGLE_QUOTE = strbyte("'"),
		DOUBLE_QUOTE = strbyte('"'),

		-- Operator
		PLUS = strbyte("+"),
		MINUS = strbyte("-"),
		ASTERISK = strbyte("*"),
		SLASH = strbyte("/"),
		PERCENT = strbyte("%"),

		-- Compare
		LESSTHAN = strbyte("<"),
		GREATERTHAN = strbyte(">"),
		EQUALS = strbyte("="),

		-- Parentheses
		LEFTBRACKET = strbyte("["),
		RIGHTBRACKET = strbyte("]"),
		LEFTPAREN = strbyte("("),
		RIGHTPAREN = strbyte(")"),
		LEFTWING = strbyte("{"),
		RIGHTWING = strbyte("}"),

		-- Punctuation
		PERIOD = strbyte("."),
		BACKSLASH = strbyte("\\"),
		COMMA = strbyte(","),
		SEMICOLON = strbyte(";"),
		COLON = strbyte(":"),
		TILDE = strbyte("~"),
		HASH = strbyte("#"),

		-- WOW
		VERTICAL = strbyte("|"),
		r = strbyte("r"),
		c = strbyte("c"),
	}, {
		__index = function(self, key)
			if type(key) == "string" and key:len() == 1 then
				rawset(self, key, strbyte(key))
			end

			return rawget(self, key)
		end,
	})

	-- Special
	_Special = {
		-- LineBreak
		[_Byte.LINEBREAK_N] = 1,
		[_Byte.LINEBREAK_R] = 1,

		-- Space
		[_Byte.SPACE] = 1,
		[_Byte.TAB] = 1,

		-- String
		[_Byte.SINGLE_QUOTE] = 1,
		[_Byte.DOUBLE_QUOTE] = 1,

		-- Operator
		[_Byte.MINUS] = 1,
		[_Byte.PLUS] = 1,
		[_Byte.SLASH] = 1,
		[_Byte.ASTERISK] = 1,
		[_Byte.PERCENT] = 1,

		-- Compare
		[_Byte.LESSTHAN] = 1,
		[_Byte.GREATERTHAN] = 1,
		[_Byte.EQUALS] = 1,

		-- Parentheses
		[_Byte.LEFTBRACKET] = 1,
		[_Byte.RIGHTBRACKET] = 1,
		[_Byte.LEFTPAREN] = 1,
		[_Byte.RIGHTPAREN] = 1,
		[_Byte.LEFTWING] = 1,
		[_Byte.RIGHTWING] = 1,

		-- Punctuation
		[_Byte.PERIOD] = 1,
		[_Byte.COMMA] = 1,
		[_Byte.SEMICOLON] = 1,
		[_Byte.COLON] = 1,
		[_Byte.TILDE] = 1,
		[_Byte.HASH] = 1,

		-- WOW
		[_Byte.VERTICAL] = 1,
	}

	-- Operation
	_Operation = {
		CHANGE_CURSOR = 1,
		INPUTCHAR = 2,
		INPUTTAB = 3,
		DELETE = 4,
		BACKSPACE = 5,
		ENTER = 6,
		PASTE = 7,
		CUT = 8,
	}

	_KEY_OPER = {
		PAGEUP = _Operation.CHANGE_CURSOR,
		PAGEDOWN = _Operation.CHANGE_CURSOR,
		HOME = _Operation.CHANGE_CURSOR,
		END = _Operation.CHANGE_CURSOR,
		UP = _Operation.CHANGE_CURSOR,
		DOWN = _Operation.CHANGE_CURSOR,
		RIGHT = _Operation.CHANGE_CURSOR,
		LEFT = _Operation.CHANGE_CURSOR,
		TAB = _Operation.INPUTTAB,
		DELETE = _Operation.DELETE,
		BACKSPACE = _Operation.BACKSPACE,
		ENTER = _Operation.ENTER,
	}

	-- SkipKey
	_SkipKey = {
		-- Control keys
		LALT = true,
		LCTRL = true,
		LSHIFT = true,
		RALT = true,
		RCTRL = true,
		RSHIFT = true,
		-- other nouse keys
		ESCAPE = true,
		CAPSLOCK = true,
		PRINTSCREEN = true,
		INSERT = true,
		UNKNOWN = true,
	}

	-- Auto Pairs
	_AutoPairs = {
		[_Byte.LEFTBRACKET] = _Byte.RIGHTBRACKET, -- []
		[_Byte.LEFTPAREN] = _Byte.RIGHTPAREN, -- ()
		[_Byte.LEFTWING] = _Byte.RIGHTWING, --{}
		[_Byte.SINGLE_QUOTE] = true, -- ''
		[_Byte.DOUBLE_QUOTE] = true, -- ""
		[_Byte.RIGHTBRACKET] = false,
		[_Byte.RIGHTPAREN] = false,
		[_Byte.RIGHTWING] = false,
	}

	-- Temp list
	_BackSpaceList = {}

	------------------------------------------------------
	-- Test FontString
	------------------------------------------------------
	_TestFontString = FontString("IGAS_MultiLineTextBox_TestFontString")
	_TestFontString.Visible = false
	_TestFontString:SetWordWrap(true)

	------------------------------------------------------
	-- Key Scanner
	------------------------------------------------------
	_KeyScan = Frame("IGAS_MultiLineTextBox_KeyScan", IGAS.UIParent)
	_KeyScan:SetPropagateKeyboardInput(true)
	_KeyScan.KeyboardEnabled = true
	_KeyScan.FrameStrata = "TOOLTIP"
	_KeyScan.Visible = false
	_KeyScan.ActiveKeys = {}
	--_KeyScan:ActiveThread("OnKeyDown")

	------------------------------------------------------
	-- Thread Helper
	------------------------------------------------------
	_Thread = System.Threading.Thread()

	------------------------------------------------------
	-- Short Key Block
	------------------------------------------------------
	_BtnBlockUp = SecureButton("IGAS_MultiLineTextBox_UpBlock", IGAS.UIParent)
	_BtnBlockDown = SecureButton("IGAS_MultiLineTextBox_DownBlock", IGAS.UIParent)
	_BtnBlockUp.Visible = false
	_BtnBlockDown.Visible = false

	------------------------------------------------------
	-- Local functions
	------------------------------------------------------
	function RemoveColor(str)
		local byte
		local pos = 1
		local ret = ""

		if not str or #str == 0 then return "" end

		byte = strbyte(str, pos)

		while true do
			if byte == _Byte.VERTICAL then
				-- handle the color code
				pos = pos + 1
				byte = strbyte(str, pos)

				if byte == _Byte.c then
					pos = pos + 9
				elseif byte == _Byte.r then
					pos = pos + 1
				else
					ret = ret .. strchar(_Byte.VERTICAL)
				end

				byte = strbyte(str, pos)
			else
				if not byte then
					break
				end

				ret = ret .. strchar(byte)

				pos = pos + 1
				byte = strbyte(str, pos)
			end
		end

		return ret
	end

	function ReplaceBlock(str, startp, endp, replace)
		return str:sub(1, startp - 1) .. replace .. str:sub(endp + 1, -1)
	end

	function AdjustCursorPosition(self, pos)
		self.__OldCursorPosition = pos
		self.__Text:SetCursorPosition(pos)
		return self:HighlightText(pos, pos)
	end

	function UpdateLineNum(self)
		if self.__LineNum.Visible then
			local inset = self.__Text.TextInsets
			local lineWidth = self.__Text.Width - inset.left - inset.right
			local lineHeight = self.__Text.Font.height + self.__Text.Spacing

			local endPos

			local text = self.__Text.Text
			local index = 0
			local count = 0
			local extra = 0

			local lineNum = self.__LineNum

			lineNum.Lines = lineNum.Lines or {}
			local Lines = lineNum.Lines

			lineNum.Height = self.__Text.Height

			_TestFontString:SetFontObject(self.__Text:GetFontObject())
			_TestFontString:SetSpacing(self.__Text:GetSpacing())
			_TestFontString:SetIndentedWordWrap(self.__Text:GetIndentedWordWrap())
			_TestFontString.Width = lineWidth

			if not _ConcatReturn then
				if text:find("\n") then
					_ConcatReturn = "\n"
				elseif text:find("\r") then
					_ConcatReturn = "\r"
				end
			end

			for line, endp in text:gmatch( "([^\r\n]*)()" ) do
				if endp ~= endPos then
					-- skip empty match
					endPos = endp

					index = index + 1
					count = count + 1

					Lines[count] = index

					_TestFontString.Text = line

					extra = _TestFontString:GetStringHeight() / lineHeight

					extra = floor(extra) - 1

					for i = 1, extra do
						count = count + 1

						Lines[count] = ""
					end
				end
			end

			for i = #Lines, count + 1, -1 do
				Lines[i] = nil
			end

			if _ConcatReturn then
				lineNum.Text = tblconcat(Lines, _ConcatReturn)
			else
				lineNum.Text = tostring(Lines[1] or "")
			end
		end
	end

	function Ajust4Font(self)
		self.__LineNum:SetFont(self.__Text:GetFont())
		self.__LineNum:SetSpacing(self.__Text:GetSpacing())

		_TestFontString:SetFont(self.__Text:GetFont())
		_TestFontString.Text = "XXXX"

		self.__LineNum.Width = _TestFontString:GetStringWidth() + 8
		self.__LineNum.Text = ""

		local inset = self.__Text.TextInsets

		if self.__LineNum.Visible then
			inset.left = self.__LineNum.Width + 5

			self.__Text.TextInsets = inset

			self.__LineNum:SetPoint("TOP", self.__Text, "TOP", 0, - (inset.top))
		else
			inset.left = 5

			self.__Text.TextInsets = inset

			self.__LineNum:SetPoint("TOP", self.__Text, "TOP", 0, - (inset.top))
		end

		self.ValueStep = self.__Text.Font.height + self.__Text.Spacing

		UpdateLineNum(self)
	end

	function GetLines4Line(self, line)
		if not _ConcatReturn then
			return 0, self.__Text.Text:len()
		end

		local startp, endp = 0, 0
		local str = self.__Text.Text
		local count = 0

		while count < line and endp do
			startp = endp
			endp = endp + 1

			endp = str:find(_ConcatReturn, endp)
			count = count + 1
		end

		if not endp then
			endp = str:len()
		end

		return startp, endp
	end

	function GetLines(str, startp, endp)
		local byte

		endp = (endp and (endp + 1)) or startp + 1

		-- get prev LineBreak
		while startp > 0 do
			byte = strbyte(str, startp)

			if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				break
			end

			startp = startp - 1
		end

		startp = startp + 1

		-- get next LineBreak
		while true do
			byte = strbyte(str, endp)

			if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				break
			end

			endp = endp + 1
		end

		endp = endp - 1

		-- get block
		return startp, endp, str:sub(startp, endp)
	end

	function GetLinesByReturn(str, startp, returnCnt)
		local byte
		local handledReturn = 0
		local endp = startp + 1

		returnCnt = returnCnt or 0

		-- get prev LineBreak
		while startp > 0 do
			byte = strbyte(str, startp)

			if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				break
			end

			startp = startp - 1
		end

		startp = startp + 1

		-- get next LineBreak
		while true do
			byte = strbyte(str, endp)

			if not byte then
				break
			elseif byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				returnCnt = returnCnt - 1

				if returnCnt < 0 then
					break
				end

				handledReturn = handledReturn + 1
			end

			endp = endp + 1
		end

		endp = endp - 1

		-- get block
		return startp, endp, str:sub(startp, endp), handledReturn
	end

	function GetPrevLinesByReturn(str, startp, returnCnt)
		local byte
		local handledReturn = 0
		local endp = startp + 1

		returnCnt = returnCnt or 0

		-- get prev LineBreak
		while true do
			byte = strbyte(str, endp)

			if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				break
			end

			endp = endp + 1
		end

		endp = endp - 1

		local prevReturn

		-- get prev LineBreak
		while startp > 0 do
			byte = strbyte(str, startp)

			if not byte then
				break
			elseif byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				returnCnt = returnCnt - 1

				if returnCnt < 0 then
					break
				end

				prevReturn = startp

				handledReturn = handledReturn + 1
			end

			startp = startp - 1
		end

		if not prevReturn or prevReturn >  startp + 1 then
			startp = startp + 1
		end

		-- get block
		return startp, endp, str:sub(startp, endp), handledReturn
	end

	function GetOffsetByCursorPos(str, startp, cursorPos)
		if not cursorPos or cursorPos < 0 then
			return 0
		end

		startp = startp or cursorPos

		while startp > 0 do
			byte = strbyte(str, startp)

			if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				break
			end

			startp = startp - 1
		end

		startp = startp + 1

		local byte = strbyte(str, startp)
		local byteCnt = 0

		while startp <= cursorPos do
			if byte == _Byte.VERTICAL then
				-- handle the color code
				startp = startp + 1
				byte = strbyte(str, startp)

				if byte == _Byte.c then
					startp = startp + 9
				elseif byte == _Byte.r then
					startp = startp + 1
				end

				byte = strbyte(str, startp)
			else
				if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
					break
				end

				byteCnt = byteCnt + 1
				startp = startp + 1
				byte = strbyte(str, startp)
			end
		end

		return byteCnt
	end

	function GetCursorPosByOffset(str, startp, offset)
		startp = startp or 1
		offset = offset or 0

		while startp > 0 do
			byte = strbyte(str, startp)

			if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
				break
			end

			startp = startp - 1
		end

		local byte
		local byteCnt = 0

		while byteCnt < offset do
			startp  = startp  + 1
			byte = strbyte(str, startp)

			if byte == _Byte.VERTICAL then
				-- handle the color code
				startp = startp + 1
				byte = strbyte(str, startp)

				if byte == _Byte.c then
					startp = startp + 8
				end
			else
				if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
					startp = startp - 1
					break
				end

				byteCnt = byteCnt + 1
			end
		end

		return startp
	end

	function GetWord(str, cursorPos, noTail)
		local startp, endp = GetLines(str, cursorPos)

		if startp > endp then return end

		_BackSpaceList.LastIndex = 0

		local prevPos = startp
		local byte
		local curIndex = -1
		local prevSpecial = nil

		while prevPos <= endp do
			byte = strbyte(str, prevPos)

			if byte == _Byte.VERTICAL then
				prevPos = prevPos + 1
				byte = strbyte(str, prevPos)

				if byte == _Byte.c then
					-- color start
					_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
					_BackSpaceList[_BackSpaceList.LastIndex] = prevPos - 1

					if cursorPos == prevPos - 2 then
						curIndex = _BackSpaceList.LastIndex
					end

					prevPos = prevPos + 9
				elseif byte == _Byte.r then
					-- color end
					_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
					_BackSpaceList[_BackSpaceList.LastIndex] = prevPos - 1

					if cursorPos == prevPos - 2 then
						curIndex = _BackSpaceList.LastIndex
					end

					prevPos = prevPos + 1
				else
					-- only mean "||"
					_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
					_BackSpaceList[_BackSpaceList.LastIndex] = prevPos - 1

					if cursorPos == prevPos - 2 then
						curIndex = _BackSpaceList.LastIndex
					end

					prevPos = prevPos + 1
				end
			elseif _Special[byte] then
				_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
				_BackSpaceList[_BackSpaceList.LastIndex] = prevPos

				if cursorPos == prevPos - 1 then
					curIndex = _BackSpaceList.LastIndex
				end

				prevPos = prevPos + 1
			else
				_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
				_BackSpaceList[_BackSpaceList.LastIndex] = prevPos

				if cursorPos == prevPos - 1 then
					curIndex = _BackSpaceList.LastIndex
				end

				if byte >= _UTF8_Three_Char then
					prevPos = prevPos + 3
				elseif byte >= _UTF8_Two_Char then
					prevPos = prevPos + 2
				else
					prevPos = prevPos + 1
				end
			end
		end

		if cursorPos == endp then
			curIndex = _BackSpaceList.LastIndex + 1
		end

		if curIndex > 0 then
			local prevIndex = curIndex - 1
			local isSpecial = nil
			local isColor

			while prevIndex > 0 do
				prevPos = _BackSpaceList[prevIndex]
				byte = strbyte(str, prevPos)

				isColor = false

				if byte == _Byte.VERTICAL then
					prevPos = prevPos + 1
					byte = strbyte(str, prevPos)

					if byte == _Byte.c or byte == _Byte.r then
						isColor = true
					end
				end

				if isColor then
					-- skip
				elseif isSpecial == nil then
					isSpecial = _Special[byte] and true or false
				elseif isSpecial then
					if not _Special[byte] then
						break
					end
				else
					if _Special[byte] then
						break
					end
				end

				prevIndex = prevIndex - 1
			end

			prevIndex = prevIndex + 1

			local nextIndex = curIndex

			prevSpecial = isSpecial
			isSpecial = nil

			while nextIndex <= _BackSpaceList.LastIndex do
				prevPos = _BackSpaceList[nextIndex]
				byte = strbyte(str, prevPos)

				isColor = false

				if byte == _Byte.VERTICAL then
					prevPos = prevPos + 1
					byte = strbyte(str, prevPos)

					if byte == _Byte.c or byte == _Byte.r then
						isColor = true
					end
				end

				if isColor then
					-- skip
				elseif isSpecial == nil then
					isSpecial = _Special[byte] and true or false

					if noTail and isSpecial ~= prevSpecial then
						break
					end
				elseif isSpecial then
					if not _Special[byte] then
						break
					end
				else
					if _Special[byte] then
						break
					end
				end

				nextIndex = nextIndex + 1
			end

			nextIndex = nextIndex - 1

			startp = _BackSpaceList[prevIndex]
			if _BackSpaceList.LastIndex > nextIndex and _BackSpaceList[nextIndex + 1] then
				endp = _BackSpaceList[nextIndex + 1] - 1
			end

			return startp, endp, str:sub(startp, endp)
		end
	end

	function SaveOperation(self)
		if not self.__OperationOnLine then
			return
		end

		local nowText = self.__Text.Text

		-- check change
		if nowText == self.__OperationBackUpOnLine then
			self.__OperationOnLine = nil
			self.__OperationBackUpOnLine = nil
			self.__OperationStartOnLine = nil
			self.__OperationEndOnLine = nil

			return
		end

		self.__OperationIndex = self.__OperationIndex + 1
		self.__MaxOperationIndex = self.__OperationIndex

		local index = self.__OperationIndex

		-- Modify some oper var
		if self.__OperationOnLine == _Operation.DELETE then
			local _, oldLineCnt, newLineCnt

			_, oldLineCnt = self.__OperationBackUpOnLine:gsub("\n", "\n")
			_, newLineCnt = nowText:gsub("\n", "\n")

			_, self.__OperationEndOnLine = GetLinesByReturn(self.__OperationBackUpOnLine, self.__OperationStartOnLine, oldLineCnt - newLineCnt)
		end

		if self.__OperationOnLine == _Operation.BACKSPACE then
			local _, oldLineCnt, newLineCnt

			_, oldLineCnt = self.__OperationBackUpOnLine:gsub("\n", "\n")
			_, newLineCnt = nowText:gsub("\n", "\n")

			self.__OperationStartOnLine = GetPrevLinesByReturn(self.__OperationBackUpOnLine, self.__OperationEndOnLine, oldLineCnt - newLineCnt)
		end

		-- keep operation data
		self.__Operation[index] = self.__OperationOnLine

		self.__OperationBackUp[index] = select(3, GetLines(self.__OperationBackUpOnLine, self.__OperationStartOnLine, self.__OperationEndOnLine))
		self.__OperationStart[index] = self.__OperationStartOnLine
		self.__OperationEnd[index] = self.__OperationEndOnLine

		self.__OperationData[index] = select(3, GetLines(nowText, self.__HighlightTextStart, self.__HighlightTextEnd))
		self.__OperationFinalStart[index] = self.__HighlightTextStart
		self.__OperationFinalEnd[index] = self.__HighlightTextEnd

		-- special operation
		if self.__OperationOnLine == _Operation.ENTER then
			local realStart = GetLines(self.__OperationBackUpOnLine, self.__OperationStartOnLine, self.__OperationEndOnLine)
			if realStart > self.__OperationStartOnLine then
				realStart = self.__OperationStartOnLine
			end
			self.__OperationData[index] = select(3, GetLines(nowText, realStart, self.__HighlightTextEnd))
			self.__OperationFinalStart[index] = realStart
			self.__OperationFinalEnd[index] = self.__HighlightTextEnd
		end

		if self.__OperationOnLine == _Operation.PASTE then
			self.__OperationData[index] = select(3, GetLines(nowText, self.__OperationStartOnLine, self.__HighlightTextEnd))
			self.__OperationFinalStart[index] = self.__OperationStartOnLine
			self.__OperationFinalEnd[index] = self.__HighlightTextEnd
		end

		if self.__OperationOnLine == _Operation.CUT then
			self.__OperationData[index] = select(3, GetLines(nowText, self.__HighlightTextStart, self.__HighlightTextStart))
			self.__OperationFinalStart[index] = self.__HighlightTextStart
			self.__OperationFinalEnd[index] = self.__HighlightTextStart
		end

		self.__OperationOnLine = nil
		self.__OperationBackUpOnLine = nil
		self.__OperationStartOnLine = nil
		self.__OperationEndOnLine = nil

		return self:Fire("OnOperationListChanged")
	end

	function NewOperation(self, oper)
		if self.__OperationOnLine == oper then
			return
		end

		-- save last operation
		SaveOperation(self)

		self.__OperationOnLine = oper

		self.__OperationBackUpOnLine = self.__Text.Text
		self.__OperationStartOnLine = self.__HighlightTextStart
		self.__OperationEndOnLine = self.__HighlightTextEnd
	end

	function EndPrevKey(self)
		if self.__SKIPCURCHGARROW then
			self.__SKIPCURCHG = nil
			self.__SKIPCURCHGARROW = nil
		end

		self.__InPasting = nil
	end

	function BlockShortKey()
		SetOverrideBindingClick(IGAS:GetUI(_BtnBlockDown), false, "DOWN", _BtnBlockDown.Name, "LeftButton")
		SetOverrideBindingClick(IGAS:GetUI(_BtnBlockUp), false, "UP", _BtnBlockUp.Name, "LeftButton")
	end

	function UnblockShortKey()
		ClearOverrideBindings(IGAS:GetUI(_BtnBlockDown))
		ClearOverrideBindings(IGAS:GetUI(_BtnBlockUp))
	end

	_IndentFunc = _IndentFunc or {}
	_ShiftIndentFunc = _ShiftIndentFunc or {}

	do
		setmetatable(_IndentFunc, {
			__index = function(self, key)
				if tonumber(key) then
					local tab = floor(tonumber(key))

					if tab > 0 then
						if not rawget(self, key) then
							rawset(self, key, function(str)
								return strrep(" ", tab) .. str
							end)
						end

						return rawget(self, key)
					end
				end
			end,
		})

		setmetatable(_ShiftIndentFunc, {
			__index = function(self, key)
				if tonumber(key) then
					local tab = floor(tonumber(key))

					if tab > 0 then
						if not rawget(self, key) then
							rawset(self, key, function(str)
								local _, len = str:find("^%s+")

								if len and len > 0 then
									return strrep(" ", len - tab) .. str:sub(len + 1, -1)
								end
							end)
						end

						return rawget(self, key)
					end
				end
			end,
		})

		wipe(_IndentFunc)
		wipe(_ShiftIndentFunc)
	end

	function Search2Next(self)
		if not self.__InSearch then
			return
		end

		local text = self.__Text.Text

		local startp, endp = text:find(self.__InSearch, self.CursorPosition)

		if not startp then
			startp, endp = text:find(self.__InSearch, 0)
		end

		local s, e

		s = startp
		e = endp

		if s and e then
			SaveOperation(self)

			AdjustCursorPosition(self, e)

			self:HighlightText(s - 1, e)
		else
			IGAS:MsgBox(L"'%s' can't be found in the content.":format(self.__InSearch))

			self:SetFocus()
		end
	end

	function GoLineByNo(self, no)
		local text = self.__Text.Text
		local lineBreak

		if text:find("\n") then
			lineBreak = "\n"
		elseif text:find("\r") then
			lineBreak = "\r"
		else
			lineBreak = false
		end

		no = no - 1

		local pos = 0
		local newPos

		if not lineBreak then
			return
		end

		SaveOperation(self)

		while no > 0 do
			newPos = text:find(lineBreak, pos + 1)

			if newPos then
				no = no - 1
				pos = newPos
			else
				break
			end
		end

		return AdjustCursorPosition(self, pos)
	end

	function Thread_FindText(self)
		local searchText = IGAS:MsgBox(L"Please input the search content", "ic")

		self:SetFocus()

		searchText = searchText and strtrim(searchText)

		if searchText and searchText ~= "" then
			-- Prepare the search
			self.__InSearch = searchText

			Search2Next(self)
		end
	end

	function Thread_GoLine(self)
		local goLine = IGAS:MsgBox(L"Please input the line number", "ic")

		self:SetFocus()

		goLine = goLine and tonumber(goLine)

		if goLine and goLine >= 1 then
			GoLineByNo(self, floor(goLine))
		end
	end

	function Thread_GoLastLine4Enter(self, value, h)
		local count = 10

		while count > 0 and self:GetVerticalScrollRange() + h < value do
			count = count - 1
			Threading.Sleep(0.1)
		end

		self.Value = value
	end

	function Thread_DELETE(self)
		local first = true
		local str = self.__Text.Text
		local pos = self.CursorPosition + 1
		local byte
		local isSpecial = nil
		local nextPos

		while self.__DELETE do
			isSpecial = nil

			if first and self.__HighlightTextStart ~= self.__HighlightTextEnd then
				pos = self.__HighlightTextStart + 1
				nextPos = self.__HighlightTextEnd + 1
			else
				nextPos = pos
				byte = strbyte(str, nextPos)

				-- yap, I should do this myself
				if IsControlKeyDown() then
					-- delete words
					while true do
						if not byte then
							break
						elseif byte == _Byte.VERTICAL then
							nextPos = nextPos + 1
							byte = strbyte(str, nextPos)

							if byte == _Byte.c then
								-- skip color start
								nextPos = nextPos + 8
							elseif byte == _Byte.r then
								-- skip color end
							else
								-- only mean "||"
								if isSpecial == nil then
									isSpecial = true
								elseif not isSpecial then
									nextPos = nextPos - 1
									break
								end
							end
						else
							if isSpecial == nil then
								isSpecial = _Special[byte] and true or false
							elseif not isSpecial then
								if _Special[byte] then
									break
								end
							else
								if not _Special[byte] then
									break
								end
							end
						end

						nextPos = nextPos + 1
						byte = strbyte(str, nextPos)
					end
				else
					-- delete char
					while true do
						if not byte then
							break
						elseif byte == _Byte.VERTICAL then
							nextPos = nextPos + 1
							byte = strbyte(str, nextPos)

							if byte == _Byte.c then
								-- skip color start
								nextPos = nextPos + 8
							elseif byte == _Byte.r then
								-- skip color end
							else
								-- only mean "||"
								nextPos = nextPos + 1
								break
							end
						else
							if byte >= _UTF8_Three_Char then
								nextPos = nextPos + 3
							elseif byte >= _UTF8_Two_Char then
								nextPos = nextPos + 2
							else
								nextPos = nextPos + 1
							end
							break
						end

						nextPos = nextPos + 1
						byte = strbyte(str, nextPos)
					end
				end
			end

			if pos == nextPos then
				break
			end

			str = ReplaceBlock(str, pos, nextPos - 1, "")

			self.__Text.Text = str

			AdjustCursorPosition(self, pos - 1)

			-- Do for long press
			if first then
				Threading.Sleep(_FIRST_WAITTIME)
				first = false
			else
				Threading.Sleep(_CONTINUE_WAITTIME)
			end
		end

		self:Fire("OnDeleteFinished")
	end

	function Thread_BACKSPACE(self)
		local first = true
		local str = self.__Text.Text
		local pos = self.CursorPosition
		local byte
		local isSpecial = nil
		local prevPos
		local prevIndex
		local prevColorStart = nil
		local prevWhite = 0
		local whiteIndex = 0

		_BackSpaceList.LastIndex = 0

		while self.__BACKSPACE do
			isSpecial = nil

			if first and self.__HighlightTextStart ~= self.__HighlightTextEnd then
				pos = self.__HighlightTextEnd
				prevPos = self.__HighlightTextStart + 1
			else
				-- prepare char list
				if _BackSpaceList.LastIndex == 0 then
					-- index the prev return char
					prevPos = pos
					byte = strbyte(str, prevPos)
					prevWhite = 0
					whiteIndex = 0

					while true do
						if not byte or byte == _Byte.LINEBREAK_N or byte == _Byte.LINEBREAK_R then
							break
						end

						prevPos = prevPos - 1
						byte = strbyte(str, prevPos)
					end

					if byte then
						-- record the newline
						_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
						_BackSpaceList[_BackSpaceList.LastIndex] = prevPos
					end

					prevPos = prevPos + 1

					-- Check prev space
					if prevPos <= pos then
						byte = strbyte(str, prevPos)

						if byte == _Byte.SPACE then
							_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
							_BackSpaceList[_BackSpaceList.LastIndex] = prevPos
							whiteIndex = _BackSpaceList.LastIndex

							while prevPos <= pos do
								prevWhite = prevWhite + 1
								prevPos = prevPos + 1
								byte = strbyte(str, prevPos)

								if byte ~= _Byte.SPACE then
									break
								end
							end
						end
					end

					while prevPos <= pos do
						byte = strbyte(str, prevPos)

						if byte == _Byte.VERTICAL then
							prevPos = prevPos + 1
							byte = strbyte(str, prevPos)

							if byte == _Byte.c then
								prevColorStart = prevColorStart or (prevPos - 1)
								-- skip color start
								prevPos = prevPos + 9
							elseif byte == _Byte.r then
								prevColorStart = prevColorStart or (prevPos - 1)
								-- skip color end
								prevPos = prevPos + 1
							else
								-- only mean "||"
								_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
								_BackSpaceList[_BackSpaceList.LastIndex] = prevColorStart or prevPos - 1
								prevColorStart = nil

								prevPos = prevPos + 1
							end
						elseif _Special[byte] then
							_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
							_BackSpaceList[_BackSpaceList.LastIndex] = prevColorStart or prevPos
							prevColorStart = nil

							prevPos = prevPos + 1
						else
							_BackSpaceList.LastIndex = _BackSpaceList.LastIndex + 1
							_BackSpaceList[_BackSpaceList.LastIndex] = prevColorStart or prevPos
							prevColorStart = nil

							if byte >= _UTF8_Three_Char then
								prevPos = prevPos + 3
							elseif byte >= _UTF8_Two_Char then
								prevPos = prevPos + 2
							else
								prevPos = prevPos + 1
							end
						end
					end
				end

				if _BackSpaceList.LastIndex == 0 then
					break
				end

				prevIndex = _BackSpaceList.LastIndex

				-- yap, I should do this myself
				if IsControlKeyDown() then
					-- delete words
					while prevIndex > 0 do
						prevPos = _BackSpaceList[prevIndex]
						byte = strbyte(str, prevPos)

						while byte == _Byte.VERTICAL do
							prevPos = prevPos + 1
							byte = strbyte(str, prevPos)

							if byte == _Byte.c then
								-- skip color start
								prevPos = prevPos + 9
								byte = strbyte(str, prevPos)
							elseif byte == _Byte.r then
								-- skip color end
								prevPos = prevPos + 1
								byte = strbyte(str, prevPos)
							else
								prevPos = prevPos - 1
								byte = strbyte(str, prevPos)
								break
							end
						end

						if isSpecial == nil then
							isSpecial = _Special[byte] and true or false
						elseif isSpecial then
							if not _Special[byte] then
								break
							end
						else
							if _Special[byte] then
								break
							end
						end

						prevIndex = prevIndex - 1
					end

					prevIndex = prevIndex + 1
					prevPos = _BackSpaceList[prevIndex]

					_BackSpaceList.LastIndex = prevIndex - 1
				else
					if prevIndex ~= whiteIndex or (prevIndex == whiteIndex and prevWhite == 0) then
						-- delete char
						prevPos = _BackSpaceList[prevIndex]

						_BackSpaceList.LastIndex = prevIndex - 1
					else
						prevPos = _BackSpaceList[prevIndex]

						prevWhite = (ceil(prevWhite / self.TabWidth) - 1) * self.TabWidth
						if prevWhite < 0 then prevWhite = 0 end

						prevPos = prevPos + prevWhite

						if prevWhite <= 0 then
							_BackSpaceList.LastIndex = prevIndex - 1
						end
					end
				end
			end

			-- Auto pairs check
			local char = str:sub(prevPos, pos)
			local offset = pos

			char = RemoveColor(char)

			if char and char:len() == 1 and _AutoPairs[strbyte(char)] then
				offset = offset + 1

				byte = strbyte(str, offset)

				while true do
					if byte == _Byte.VERTICAL then
						-- handle the color code
						offset = offset + 1
						byte = strbyte(str, offset)

						if byte == _Byte.c then
							offset = offset + 9
						elseif byte == _Byte.r then
							offset = offset + 1
						else
							offset = offset - 1
							break
						end

						byte = strbyte(str, offset)
					else
						break
					end
				end

				if (_AutoPairs[strbyte(char)] == true and byte == strbyte(char)) or _AutoPairs[strbyte(char)] == byte then
					-- pass
				else
					offset = pos
				end
			end

			-- Delete
			str = ReplaceBlock(str, prevPos, offset, "")

			self.__Text.Text = str

			AdjustCursorPosition(self, prevPos - 1)

			pos = prevPos - 1

			-- Do for long press
			if first then
				Threading.Sleep(_FIRST_WAITTIME)
				first = false
			else
				Threading.Sleep(_CONTINUE_WAITTIME)
			end
		end

		-- shift tab
		pos = self.CursorPosition
		local startp, endp, line = GetLines(str, pos)

		local _, len = line:find("^%s+")

		if len and len > 1 and startp + len - 1 >= pos then
			if len % self.TabWidth ~= 0 then
				line = line:sub(len + 1, -1)
				len = floor(len/self.TabWidth) * self.TabWidth

				line = strrep(" ", len) .. line

				str = ReplaceBlock(str, startp, endp, line)

				self.__Text.Text = str

				AdjustCursorPosition(self, startp - 1 + len)
			end
		end

		self:Fire("OnBackspaceFinished")
	end

	_DirectionKeyEventArgs = EventArgs()

	function _KeyScan:OnKeyDown(key)
		if _SkipKey[key] then return end

		if self.FocusEditor and key then
			local editor = self.FocusEditor
			local cursorPos = editor.CursorPosition

			local oper = _KEY_OPER[key]

			if oper then
				if oper == _Operation.CHANGE_CURSOR then

					_DirectionKeyEventArgs.Handled = false
					_DirectionKeyEventArgs.Cancel = false
					_DirectionKeyEventArgs.Key = key

					editor:Fire("OnDirectionKey", _DirectionKeyEventArgs)

					if _DirectionKeyEventArgs.Handled or _DirectionKeyEventArgs.Cancel then
						self.ActiveKeys[key] = true
						return self:SetPropagateKeyboardInput(false)
					end

					if key == "PAGEUP" then
						local text = editor.__Text.Text
						local skipLine = floor(editor.Height / editor.ValueStep)
						local startp, endp, _, line = GetPrevLinesByReturn(text, cursorPos, skipLine)

						if line == 0 then
							return
						end

                        EndPrevKey(editor)

						SaveOperation(editor)

						if editor.Value > editor.Height then
							editor.Value = editor.Value - editor.Height
						else
							editor.Value = 0
						end

						if IsShiftKeyDown() then
							editor.__SKIPCURCHG = cursorPos
						end

						editor.CursorPosition = GetCursorPosByOffset(text, startp, GetOffsetByCursorPos(text, nil, cursorPos))

						return
					end

					if key == "PAGEDOWN" then
						local text = editor.__Text.Text
						local skipLine = floor(editor.Height / editor.ValueStep)
						local startp, endp, _, line = GetLinesByReturn(text, cursorPos, skipLine)

						if line == 0 then
							return
                        end

                        EndPrevKey(editor)

						SaveOperation(editor)

						local maxValue = editor.Container.Height - editor.Height

						if editor.Value + editor.Height < maxValue then
							editor.Value = editor.Value + editor.Height
						else
							editor.Value = maxValue
						end

						if IsShiftKeyDown() then
							editor.__SKIPCURCHG = cursorPos
						end

						editor.CursorPosition = GetCursorPosByOffset(text, endp, GetOffsetByCursorPos(text, nil, cursorPos))

						return
					end

					if key == "HOME" then
						local text = editor.__Text.Text
						local startp, endp = GetLines(text, cursorPos)
						local byte

						if startp - 1 == cursorPos then
							return
						end

                        EndPrevKey(editor)

						SaveOperation(editor)

						if IsShiftKeyDown() then
							editor.__SKIPCURCHG = cursorPos
						end

						return
					end

					if key == "END" then
						local startp, endp = GetLines(editor.__Text.Text, cursorPos)

						if endp == cursorPos then
							return
						end

                        EndPrevKey(editor)

						SaveOperation(editor)

						if IsShiftKeyDown() then
							editor.__SKIPCURCHG = cursorPos
						end

						return
					end

					if key == "UP" then
						local _, _, _, line = GetPrevLinesByReturn(editor.__Text.Text, cursorPos, 1)

						if line > 0 then
                            EndPrevKey(editor)

							SaveOperation(editor)

							if IsShiftKeyDown() then
								editor.__SKIPCURCHG = cursorPos
								editor.__SKIPCURCHGARROW = true
							end
						end

						return
					end

					if key == "DOWN" then
						local _, _, _, line = GetLinesByReturn(editor.__Text.Text, cursorPos, 1)

						if line > 0 then
                            EndPrevKey(editor)

							SaveOperation(editor)

							if IsShiftKeyDown()  then
								editor.__SKIPCURCHG = cursorPos
								editor.__SKIPCURCHGARROW = true
							end
						end

						return
					end

					if key == "RIGHT" then
						if cursorPos < editor.__Text.Text:len() then
                            EndPrevKey(editor)

							SaveOperation(editor)

							if IsShiftKeyDown() then
								editor.__SKIPCURCHG = cursorPos
								editor.__SKIPCURCHGARROW = true
							end
						end

						return
					end

					if key == "LEFT" then
						if cursorPos > 0 then
                            EndPrevKey(editor)

							SaveOperation(editor)

							if IsShiftKeyDown() then
								editor.__SKIPCURCHG = cursorPos
								editor.__SKIPCURCHGARROW = true
							end
						end

						return
					end
				end

				if key == "TAB" then
                    EndPrevKey(editor)
					return NewOperation(editor, _Operation.INPUTTAB)
				end

				if key == "DELETE" then
					if not editor.__DELETE and not IsShiftKeyDown() and (editor.__HighlightTextStart ~= editor.__HighlightTextEnd or cursorPos < editor.__Text.Text:len()) then
                        EndPrevKey(editor)
						editor.__DELETE = true
						NewOperation(editor, _Operation.DELETE)
						self.ActiveKeys[key] = true
						self:SetPropagateKeyboardInput(false)

						_Thread.Thread = Thread_DELETE
						return _Thread(editor)
					end
					return
				end

				if key == "BACKSPACE" then
					if not editor.__BACKSPACE and cursorPos > 0 then
                        EndPrevKey(editor)
						editor.__BACKSPACE = cursorPos
						NewOperation(editor, _Operation.BACKSPACE)
						self.ActiveKeys[key] = true
						self:SetPropagateKeyboardInput(false)

						_Thread.Thread = Thread_BACKSPACE
						return _Thread(editor)
					end
					return
				end

				if key == "ENTER" then
                    EndPrevKey(editor)
					-- editor.__SKIPCURCHG = true
					return NewOperation(editor, _Operation.ENTER)
				end
			end

            EndPrevKey(editor)

			-- Don't consider multi-modified keys
			if IsShiftKeyDown() then
				-- shift+
			elseif IsAltKeyDown() then
				return editor:Fire("OnAltKey", key)
			elseif IsControlKeyDown() then
				if key == "A" then
					editor:HighlightText()
					return
				elseif key == "V" then
					editor.__InPasting = true
					return NewOperation(editor, _Operation.PASTE)
				elseif key == "C" then
					-- do nothing
					return
				--[[elseif key == "Z" then
					return editor:Undo()
				elseif key == "Y" then
					return editor:Redo()--]]
				elseif key == "X" then
					if editor.__HighlightTextStart ~= editor.__HighlightTextEnd then
						NewOperation(editor, _Operation.CUT)
					end
					return
				elseif key == "F" then
					_Thread.Thread = Thread_FindText
					return _Thread(editor)
				elseif key == "G" then
					_Thread.Thread = Thread_GoLine
					return _Thread(editor)
				else
					return editor:Fire("OnControlKey", key)
				end
			elseif key:find("^F%d+") == 1 then
				if key == "F3" and editor.__InSearch then
					-- Continue Search
					return Search2Next(editor)
				end

				return editor:Fire("OnFunctionKey", key)
			end

			return NewOperation(editor, _Operation.INPUTCHAR)
		end
	end

	function _KeyScan:OnKeyUp(key)
		self:SetPropagateKeyboardInput(true)

		self.ActiveKeys[key] = nil

		if self.FocusEditor then
			if key == "DELETE" then
				self.FocusEditor.__DELETE = nil
			end
			if key == "BACKSPACE" then
				self.FocusEditor.__BACKSPACE = nil
			end
		end

		if _Thread:IsSuspended() then
			_Thread:Resume()
		end
	end
end

__Doc__[[MultiLineTextBox is used as a multi-line text editor.]]
__AutoProperty__()
class "MultiLineTextBox"
	inherit "ScrollForm"

	enum "Operation" (_Operation)

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the edit box's text is changed</desc>
		<param name="isUserInput">boolean</param>
	]]
	event "OnTextChanged"

	__Doc__[[
		<desc>Run when the position of the text insertion cursor in the edit box changes</desc>
		<param name="x">number, horizontal position of the cursor relative to the top left corner of the edit box (in pixels)</param>
		<param name="y">number, vertical position of the cursor relative to the top left corner of the edit box (in pixels)</param>
		<param name="width">number, width of the cursor graphic (in pixels)</param>
		<param name="height">number, height of the cursor graphic (in pixels); matches the height of a line of text in the edit box</param>
	]]
	event "OnCursorChanged"

	__Doc__[[Run when the edit box becomes focused for keyboard input]]
	event "OnEditFocusGained"

	__Doc__[[Run when the edit box loses keyboard input focus]]
	event "OnEditFocusLost"

	__Doc__[[Run when the Enter (or Return) key is pressed while the edit box has keyboard focus]]
	event "OnEnterPressed"

	__Doc__[[Run when the Escape key is pressed while the edit box has keyboard focus]]
	event "OnEscapePressed"

	__Doc__[[
		<desc>Run when the edit box's language input mode changes</desc>
		<param name="language">string, name of the new input language</param>
	]]
	event "OnInputLanguageChanged"

	__Doc__[[Run when the space bar is pressed while the edit box has keyboard focus]]
	event "OnSpacePressed"

	__Doc__[[Run when the Tab key is pressed while the edit box has keyboard focus]]
	event "OnTabPressed"

	__Doc__[[Run when the edit box's text is set programmatically]]
	event "OnTextSet"

	__Doc__[[
		<desc>Run for each text character typed in the frame</desc>
		<param name="char">string, the text character typed</param>
	]]
	event "OnChar"

	__Doc__[[
		<desc>Run when the edit box's input composition mode changes</desc>
		<param name="text">string, The text entered</param>
	]]
	event "OnCharComposition"

	__Doc__[[
		<desc>Run when the edit box's FunctionKey is pressed</desc>
		<param name="key">string, the function key (like 'F5')</param>
	]]
	event "OnFunctionKey"

	__Doc__[[
		<desc>Fired when a key is combined with ctrl</desc>
		<param name="key">string, The key entered</param>
	]]
	event "OnControlKey"

	__Doc__[[
		<desc>Fired when a key is combined with alt</desc>
		<param name="key">string, The key entered</param>
	]]
	event "OnAltKey"

	__Doc__[[Fired when the direction key is used, such like PAGEDOWN, LEFT, HOME]]
	event "OnDirectionKey"

	__Doc__[[
		<desc>Run when the edit box's operation list is changed</desc>
		<param name="startp">number, the start position</param>
		<param name="endp">number, the end position</param>
	]]
	event "OnOperationListChanged"

	__Doc__[[Run when the delete key is up]]
	event "OnDeleteFinished"

	__Doc__[[Run when the backspace key is up]]
	event "OnBackspaceFinished"

	__Doc__[[
		<desc>Run when pasting finished</desc>
		<param name="startp">number, the start position</param>
		<param name="endp">number, the end position</param>
	]]
	event "OnPasting"

	__Doc__[[
		<desc>Run when cut finished</desc>
		<param name="startp">number, the start position</param>
		<param name="endp">number, the end position</param>
		<param name="cutText">string, the cut text</param>
	]]
	event "OnCut"

	__Doc__[[Fired when a new line is created]]
	event "OnNewLine"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Set the cursor position without change the operation list</desc>
		<param name="pos">number, the position of the cursor inside the MultiLineTextBox</param>
	]]
	AdjustCursorPosition = AdjustCursorPosition

	__Doc__[[
		<desc>Returns the font instance's basic font properties</desc>
		<return type="filename">string, path to a font file (string)</return>
		<return type="fontHeight">number, height (point size) of the font to be displayed (in pixels) (number)</return>
		<return type="flags">string, additional properties for the font specified by one or more (separated by commas)</return>
	]]
	function GetFont(self, ...)
		return self.__Text:GetFont(...)
	end

	__Doc__[[
		<desc>Returns the Font object from which the font instance's properties are inherited</desc>
		<return type="System.Widget.Font">the Font object from which the font instance's properties are inherited, or nil if the font instance has no inherited properties</return>
	]]
	function GetFontObject(self, ...)
		return self.__Text:GetFontObject(...)
	end

	__Doc__[[
		<desc>Returns the color of the font's text shadow</desc>
		<return type="shadowR">number, Red component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowG">number, Green component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetShadowColor(self, ...)
		return self.__Text:GetShadowColor(...)
	end

	__Doc__[[
		<desc>Returns the offset of the font instance's text shadow from its text</desc>
		<return type="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</return>
		<return type="yOffset">number, Vertical distance between the text and its shadow (in pixels)</return>
	]]
	function GetShadowOffset(self, ...)
		return self.__Text:GetShadowOffset(...)
	end

	__Doc__[[
		<desc>Returns the font instance's amount of spacing between lines</desc>
		<return type="number">amount of space between lines of text (in pixels)</return>
	]]
	function GetSpacing(self, ...)
		return self.__Text:GetSpacing(...)
	end

	__Doc__[[
		<desc>Returns the font instance's default text color</desc>
		<return type="textR">number, Red component of the text color (0.0 - 1.0)</return>
		<return type="textG">number, Green component of the text color (0.0 - 1.0)</return>
		<return type="textB">number, Blue component of the text color (0.0 - 1.0)</return>
		<return type="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetTextColor(self, ...)
		return self.__Text:GetTextColor(...)
	end

	__Doc__[[
		<desc>Sets the font instance's basic font properties</desc>
		<param name="filename">string, path to a font file</param>
		<param name="fontHeight">number, height (point size) of the font to be displayed (in pixels)</param>
		<param name="flags">string, additional properties for the font specified by one or more (separated by commas) of the following tokens: MONOCHROME, OUTLINE, THICKOUTLINE</param>
		<return type="boolean">1 if filename refers to a valid font file; otherwise nil</return>
	]]
	function SetFont(self, ...)
		self.__Text:SetFont(...)
		Ajust4Font(self)
	end

	__Doc__[[
		<desc>Sets the Font object from which the font instance's properties are inherited</desc>
		<format>fontObject|fontName</format>
		<param name="fontObject">System.Widget.Font, a font object</param>
		<param name="fontName">string, global font object's name</param>
	]]
	function SetFontObject(self, ...)
		self.__Text:SetFontObject(...)
		Ajust4Font(self)
	end

	__Doc__[[
		<desc>Sets the color of the font's text shadow</desc>
		<param name="shadowR">number, Red component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowG">number, Green component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetShadowColor(self, ...)
		return self.__Text:SetShadowColor(...)
	end

	__Doc__[[
		<desc>Sets the offset of the font instance's text shadow from its text</desc>
		<param name="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</param>
		<param name="yOffset">number, Vertical distance between the text and its shadow (in pixels)</param>
	]]
	function SetShadowOffset(self, ...)
		return self.__Text:SetShadowOffset(...)
	end

	__Doc__[[
		<desc>Sets the font instance's amount of spacing between lines</desc>
		<param name="spacing">number, amount of space between lines of text (in pixels)</param>
	]]
	function SetSpacing(self, ...)
		self.__Text:SetSpacing(...)
		Ajust4Font(self)
	end

	__Doc__[[
		<desc>Sets the font instance's default text color. This color is used for otherwise unformatted text displayed using the font instance</desc>
		<param name="textR">number, Red component of the text color (0.0 - 1.0)</param>
		<param name="textG">number, Green component of the text color (0.0 - 1.0)</param>
		<param name="textB">number, Blue component of the text color (0.0 - 1.0)</param>
		<param name="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetTextColor(self, ...)
		return self.__Text:SetTextColor(...)
	end

	__Doc__[[
		<desc>Sets the font's properties to match those of another Font object. Unlike Font:SetFontObject(), this method allows one-time reuse of another font object's properties without continuing to inherit future changes made to the other object's properties.</desc>
		<format>object|name</format>
		<param name="object">System.Widget.Font, reference to a Font object</param>
		<param name="name">string, global name of a Font object</param>
	]]
	function CopyFontObject(self, ...)
		self.__Text:CopyFontObject(...)
		Ajust4Font(self)
	end

	__Doc__[[
		<desc>Gets whether long lines of text are indented when wrapping</desc>
		<return type="boolean"></return>
	]]
	function GetIndentedWordWrap(self, ...)
		return self.__Text:GetIndentedWordWrap(...)
	end

	__Doc__[[
		<desc>Sets whether long lines of text are indented when wrapping</desc>
		<param name="boolean"></param>
	]]
	function SetIndentedWordWrap(self, ...)
		self.__Text:SetIndentedWordWrap(...)
		Ajust4Font(self)
	end

	__Doc__[[Clear history]]
	function ClearHistory(self, ...)
		return self.__Text:ClearHistory(...)
	end

	__Doc__[[
		<desc>Returns the cursor's numeric position in the edit box, taking UTF-8 multi-byte character into account. If the EditBox contains multi-byte Unicode characters, the GetCursorPosition() method will not return correct results, as it considers each eight byte character to count as a single glyph.  This method properly returns the position in the edit box from the perspective of the user.</desc>
		<return type="number">The cursor's numeric position (leftmost position is 0), taking UTF8 multi-byte characters into account.</return>
	]]
	function GetUTF8CursorPosition(self, ...)
		return self.__Text:GetUTF8CursorPosition(...)
	end

	__Doc__[[
		@desc
		<return type="boolean"></return>
	]]
	function IsCountInvisibleLetters(self, ...)
		return self.__Text:IsCountInvisibleLetters(...)
	end

	__Doc__[[
		<desc>Returns whether the edit box is in Input Method Editor composition mode. Character composition mode is used for input methods in which multiple keypresses generate one printed character. In such input methods, the edit box's OnChar script is run for each keypress</desc>
		<return type="boolean">1 if the edit box is in IME character composition mode; otherwise nil</return>
	]]
	function IsInIMECompositionMode(self, ...)
		return self.__Text:IsInIMECompositionMode(...)
	end

	__Doc__[[
		<param name="..."></param>
	]]
	function SetCountInvisibleLetters(self, ...)
		return self.__Text:SetCountInvisibleLetters(...)
	end

	__Doc__[[
		<desc>Add text to the edit history</desc>
		<param name="text">string, text to be added to the edit box's list of history lines</param>
	]]
	function AddHistoryLine(self, ...)
		return self.__Text:AddHistoryLine(...)
	end

	__Doc__[[Releases keyboard input focus from the edit box]]
	function ClearFocus(self, ...)
		return self.__Text:ClearFocus(...)
	end

	__Doc__[[
		<desc>Returns whether arrow keys are ignored by the edit box unless the Alt key is held</desc>
		<return type="boolean">1 if arrow keys are ignored by the edit box unless the Alt key is held; otherwise nil</return>
	]]
	function GetAltArrowKeyMode(self, ...)
		return self.__Text:GetAltArrowKeyMode(...)
	end

	__Doc__[[
		<desc>Returns the rate at which the text insertion blinks when the edit box is focused</desc>
		<return type="number">Amount of time for which the cursor is visible during each "blink" (in seconds)</return>
	]]
	function GetBlinkSpeed(self, ...)
		return self.__Text:GetBlinkSpeed(...)
	end

	__Doc__[[
		<desc>Returns the current cursor position inside edit box</desc>
		<return type="number">Current position of the keyboard input cursor (between 0, for the position before the first character, and editbox:GetNumLetters(), for the position after the last character)</return>
	]]
	function GetCursorPosition(self, ...)
		return self.__Text:GetCursorPosition(...)
	end

	__Doc__[[
		<desc>Returns the maximum number of history lines stored by the edit box</desc>
		<return type="number">Maximum number of history lines stored by the edit box</return>
	]]
	function GetHistoryLines(self, ...)
		return self.__Text:GetHistoryLines(...)
	end

	__Doc__[[
		<desc>Returns the currently selected keyboard input language (character set / input method). Applies to keyboard input methods, not in-game languages or client locales.</desc>
		<return type="string">the input language</return>
	]]
	function GetInputLanguage(self, ...)
		return self.__Text:GetInputLanguage(...)
	end

	__Doc__[[
		<desc>Returns the maximum number of bytes of text allowed in the edit box. Note: Unicode characters may consist of more than one byte each, so the behavior of a byte limit may differ from that of a character limit in practical use.</desc>
		<return type="number">Maximum number of text bytes allowed in the edit box</return>
	]]
	function GetMaxBytes(self, ...)
		return self.__Text:GetMaxBytes(...)
	end

	__Doc__[[
		<desc>Returns the maximum number of text characters allowed in the edit box</desc>
		<return type="number">Maximum number of text characters allowed in the edit box</return>
	]]
	function GetMaxLetters(self, ...)
		return self.__Text:GetMaxLetters(...)
	end

	__Doc__[[
		<desc>Returns the number of text characters in the edit box</desc>
		<return type="number">Number of text characters in the edit box</return>
	]]
	function GetNumLetters(self, ...)
		return self.__Text:GetNumLetters(...)
	end

	__Doc__[[
		<desc>Returns the contents of the edit box as a number. Similar to tonumber(editbox:GetText()); returns 0 if the contents of the edit box cannot be converted to a number.</desc>
		<return type="number">Contents of the edit box as a number</return>
	]]
	function GetNumber(self, ...)
		return self.__Text:GetNumber(...)
	end

	__Doc__[[
		<desc>Returns the edit box's text contents</desc>
		<return type="string">Text contained in the edit box</return>
	]]
	function GetText(self, ...)
		return self.__Text:GetText(...)
	end

	__Doc__[[
		<desc>Returns the insets from the edit box's edges which determine its interactive text area</desc>
		<return type="left">number, distance from the left edge of the edit box to the left edge of its interactive text area (in pixels)</return>
		<return type="right">number, distance from the right edge of the edit box to the right edge of its interactive text area (in pixels)</return>
		<return type="top">number, distance from the top edge of the edit box to the top edge of its interactive text area (in pixels)</return>
		<return type="bottom">number, distance from the bottom edge of the edit box to the bottom edge of its interactive text area (in pixels)</return>
	]]
	function GetTextInsets(self, ...)
		return self.__Text:GetTextInsets(...)
	end

	__Doc__[[
		<desc>Selects all or a portion of the text in the edit box</desc>
		<param name="start">number, character position at which to begin the selection (between 0, for the position before the first character, and editbox:GetNumLetters(), for the position after the last character); defaults to 0 if not specified</param>
		<param name="end">number, character position at which to end the selection; if not specified or if less than start, selects all characters after the start position; if equal to start, selects nothing and positions the cursor at the start position</param>
	]]
	function HighlightText(self, ...)
		local startp, endp = ...

		if not startp then
			startp = 0
		end

		if not endp then
			endp = self.__Text.Text:len()
		end

		if endp < startp then
			startp, endp = endp, startp
		end

		if startp ~= endp and self.__OperationOnLine and self.__OperationOnLine ~= _Operation.INPUTTAB then
			SaveOperation(self)
		end

		self.__HighlightTextStart, self.__HighlightTextEnd = startp, endp

		return self.__Text:HighlightText(startp, endp)
	end

	__Doc__[[
		<desc>Inserts text into the edit box at the current cursor position</desc>
		<param name="text">string, text to be inserted</param>
	]]
	function Insert(self, ...)
		return self.__Text:Insert(...)
	end

	__Doc__[[
		<desc>Returns whether the edit box automatically acquires keyboard input focus</desc>
		<return type="boolean">1 if the edit box automatically acquires keyboard input focus; otherwise nil</return>
	]]
	function IsAutoFocus(self, ...)
		return self.__Text:IsAutoFocus(...)
	end

	__Doc__[[
		<desc>Returns whether the edit box shows more than one line of text</desc>
		<return type="boolean">1 if the edit box shows more than one line of text; otherwise nil</return>
	]]
	function IsMultiLine(self, ...)
		return self.__Text:IsMultiLine(...)
	end

	__Doc__[[
		<desc>Returns whether the edit box only accepts numeric input</desc>
		<return type="boolean">1 if only numeric input is allowed; otherwise nil</return>
	]]
	function IsNumeric(self, ...)
		return self.__Text:IsNumeric(...)
	end

	__Doc__[[
		<desc>Returns whether the text entered in the edit box is masked</desc>
		<return type="boolean">1 if text entered in the edit box is masked with asterisk characters (*); otherwise nil</return>
	]]
	function IsPassword(self, ...)
		return self.__Text:IsPassword(...)
	end

	__Doc__[[
		<desc>Sets whether arrow keys are ignored by the edit box unless the Alt key is held</desc>
		<param name="enable">boolean, true to cause the edit box to ignore arrow key presses unless the Alt key is held; false to allow unmodified arrow key presses for cursor movement</param>
	]]
	function SetAltArrowKeyMode(self, ...)
		return self.__Text:SetAltArrowKeyMode(...)
	end

	__Doc__[[
		<desc>Sets whether the edit box automatically acquires keyboard input focus. If auto-focus behavior is enabled, the edit box automatically acquires keyboard focus when it is shown and when no other edit box is focused.</desc>
		<param name="enable">boolean, true to enable the edit box to automatically acquire keyboard input focus; false to disable</param>
	]]
	function SetAutoFocus(self, ...)
		return self.__Text:SetAutoFocus(...)
	end

	__Doc__[[
		<desc>Sets the rate at which the text insertion blinks when the edit box is focused. The speed indicates how long the cursor stays in each state (shown and hidden); e.g. if the blink speed is 0.5 (the default, the cursor is shown for one half second and then hidden for one half second (thus, a one-second cycle); if the speed is 1.0, the cursor is shown for one second and then hidden for one second (a two-second cycle).</desc>
		<param name="duration">number, Amount of time for which the cursor is visible during each "blink" (in seconds)</param>
	]]
	function SetBlinkSpeed(self, ...)
		return self.__Text:SetBlinkSpeed(...)
	end

	__Doc__[[
		<desc>Sets the cursor position in the edit box</desc>
		<param name="position">number, new position for the keyboard input cursor (between 0, for the position before the first character, and editbox:GetNumLetters(), for the position after the last character)</param>
	]]
	function SetCursorPosition(self, position)
		if self.__OperationOnLine then
			SaveOperation(self)
		end

		return self.__Text:SetCursorPosition(position)
	end

	__Doc__[[Focuses the edit box for keyboard input. Only one edit box may be focused at a time; setting focus to one edit box will remove it from the currently focused edit box.]]
	function SetFocus(self, ...)
		return self.__Text:SetFocus(...)
	end

	__Doc__[[
		<desc>Sets the maximum number of history lines stored by the edit box. Lines of text can be added to the edit box's history by calling :AddHistoryLine(); once added, the user can quickly set the edit box's contents to one of these lines by pressing the up or down arrow keys. (History lines are only accessible via the arrow keys if the edit box is not in multi-line mode.)</desc>
		<param name="count">number, Maximum number of history lines to be stored by the edit box</param>
	]]
	function SetHistoryLines(self, ...)
		return self.__Text:SetHistoryLines(...)
	end

	__Doc__[[
		<desc>Sets the maximum number of bytes of text allowed in the edit box</desc>
		<param name="maxBytes">number, Maximum number of text bytes allowed in the edit box, or 0 for no limit</param>
	]]
	function SetMaxBytes(self, ...)
		return self.__Text:SetMaxBytes(...)
	end

	__Doc__[[
		<desc>Sets the maximum number of text characters allowed in the edit box.</desc>
		<param name="maxLetters">number, Maximum number of text characters allowed in the edit box, or 0 for no limit</param>
	]]
	function SetMaxLetters(self, ...)
		return self.__Text:SetMaxLetters(...)
	end

	__Doc__[[
		<desc>Sets whether the edit box shows more than one line of text. When in multi-line mode, the edit box's height is determined by the number of lines shown and cannot be set directly -- enclosing the edit box in a ScrollFrame may prove useful in such cases.</desc>
		<param name="multiLine">boolean, true to allow the edit box to display more than one line of text; false for single-line display</param>
	]]
	function SetMultiLine(self, ...)
		error("This editbox must be multi-line", 2)
	end

	__Doc__[[
		<desc>Sets the contents of the edit box to a number</desc>
		<param name="num">number, new numeric content for the edit box</param>
	]]
	function SetNumber(self, ...)
		return self.__Text:SetNumber(...)
	end

	__Doc__[[
		<desc>Sets whether the edit box only accepts numeric input. Note: an edit box in numeric mode <em>only</em> accepts numeral input -- all other characters, including those commonly used in numeric representations (such as ., E, and -) are not allowed.</desc>
		<param name="enable">boolean, true to allow only numeric input; false to allow any text</param>
	]]
	function SetNumeric(self, ...)
		return self.__Text:SetNumeric(...)
	end

	__Doc__[[
		<desc>Sets whether the text entered in the edit box is masked</desc>
		<param name="enable">boolean, true to mask text entered in the edit box with asterisk characters (*); false to show the actual text entered</param>
	]]
	function SetPassword(self, ...)
		return self.__Text:SetPassword(...)
	end

	__Doc__[[
		<desc>Sets the edit box's text contents</desc>
		<param name="text">string, text to be placed in the edit box</param>
	]]
	function SetText(self, text)
		text = tostring(text) or ""

		-- Clear operation history
		wipe(self.__Operation)

		wipe(self.__OperationStart)
		wipe(self.__OperationEnd)
		wipe(self.__OperationBackUp)

		wipe(self.__OperationFinalStart)
		wipe(self.__OperationFinalEnd)
		wipe(self.__OperationData)

		self.__OperationIndex = 0

		-- Clear now operation
		self.__OperationOnLine = nil
		self.__OperationBackUpOnLine = nil
		self.__OperationStartOnLine = nil
		self.__OperationEndOnLine = nil

		self.__Text.Text = text

		AdjustCursorPosition(self, 0)
	end

	__Doc__[[
		<desc>Sets the edit box's text contents without clear the operation list</desc>
		<param name="text">string, text to be placed in the edit box</param>
	]]
	function AdjustText(self, text)
		self.__Text.Text = text
	end

	__Doc__[[
		<desc>Sets the insets from the edit box's edges which determine its interactive text area</desc>
		<param name="left">number, distance from the left edge of the edit box to the left edge of its interactive text area (in pixels)</param>
		<param name="right">number, distance from the right edge of the edit box to the right edge of its interactive text area (in pixels)</param>
		<param name="top">number, distance from the top edge of the edit box to the top edge of its interactive text area (in pixels)</param>
		<param name="bottom">number, distance from the bottom edge of the edit box to the bottom edge of its interactive text area (in pixels)</param>
	]]
	function SetTextInsets(self, ...)
		self.__Text:SetTextInsets(...)
		Ajust4Font(self)
	end

	__Doc__[[Switches the edit box's language input mode. If the edit box is in ROMAN mode and an alternate Input Method Editor composition mode is available (as determined by the client locale and system settings), switches to the alternate input mode. If the edit box is in IME composition mode, switches back to ROMAN.]]
	function ToggleInputLanguage(self, ...)
		return self.__Text:ToggleInputLanguage(...)
	end

	__Doc__[[
		<desc>Returns whether the edit box is currently focused for keyboard input</desc>
		<return type="boolean">1 if the edit box is currently focused for keyboard input; otherwise nil</return>
	]]
	function HasFocus(self, ...)
		return self.__Text:HasFocus(...)
	end

	__Doc__[[
		<desc>Whether the MultiLineTextBox has operation can be undo</desc>
		<return type="boolean">true if the MultiLineTextBox can undo operations</return>
	]]
	function CanUndo(self)
		return self.__OperationIndex > 0
	end

	__Doc__[[Undo the operation]]
	function Undo(self)
		SaveOperation(self)

		if self.__OperationIndex > 0 then
			local idx = self.__OperationIndex
			local text = self.__Text.Text
			local startp, endp = GetLines(text, self.__OperationFinalStart[idx], self.__OperationFinalEnd[idx])

			self.__Text.Text = ReplaceBlock(text, startp, endp, self.__OperationBackUp[idx])

			startp, endp = self.__OperationStart[idx], self.__OperationEnd[idx]

			if self.__Operation[idx] == _Operation.DELETE then
				AdjustCursorPosition(self, self.__OperationStart[idx])

				self:HighlightText(self.__OperationStart[idx], self.__OperationStart[idx])
			elseif self.__Operation[idx] == _Operation.BACKSPACE then
				AdjustCursorPosition(self, self.__OperationEnd[idx])

				self:HighlightText(self.__OperationEnd[idx], self.__OperationEnd[idx])
			else
				AdjustCursorPosition(self, self.__OperationEnd[idx])

				self:HighlightText(self.__OperationStart[idx], self.__OperationEnd[idx])
			end

			self.__OperationIndex = self.__OperationIndex - 1

			return self:Fire("OnOperationListChanged", startp, endp)
		end
	end

	__Doc__[[
		<desc>Whether the MultiLineTextBox has operation can be redo</desc>
		<return type="boolean">true if the MultiLineTextBox can redo operations</return>
	]]
	function CanRedo(self)
		return self.__OperationIndex < self.__MaxOperationIndex
	end

	__Doc__[[Redo the operation]]
	function Redo(self)
		if self.__OperationIndex < self.__MaxOperationIndex then
			local idx = self.__OperationIndex + 1
			local text = self.__Text.Text

			local startp, endp = GetLines(text, self.__OperationStart[idx], self.__OperationEnd[idx])

			self.__Text.Text = ReplaceBlock(text, startp, endp, self.__OperationData[idx])

			startp, endp = self.__OperationFinalStart[idx], self.__OperationFinalEnd[idx]

			AdjustCursorPosition(self, self.__OperationFinalEnd[idx])

			self:HighlightText(self.__OperationFinalEnd[idx], self.__OperationFinalEnd[idx])

			self.__OperationIndex = self.__OperationIndex + 1

			return self:Fire("OnOperationListChanged", startp, endp)
		end
	end

	__Doc__[[Reset the MultiLineTextBox's modified state]]
	function ResetModifiedState(self)
		self.__DefaultText = self.__Text.Text
	end

	__Doc__[[
		<desc>Whether the MultiLineTextBox is modified</desc>
		<return type="boolean">true if the MultiLineTextBox is modified</return>
	]]
	function IsModified(self)
		return self.__DefaultText ~= self.__Text.Text
	end

	__Doc__[[
		<desc>Set the tabwidth for the MultiLineTextBox</desc>
		<param name="tabWidth">number, the tab's width</param>
	]]
	function SetTabWidth(self, tabWidth)
		tabWidth = tonumber(tabWidth) and floor(tonumber(tabWidth)) or _TabWidth

		if tabWidth < 1 then
			error("The TabWidth must be greater than 0.", 2)
		end

		local oldTab = self:GetTabWidth()

		if oldTab ~= tabWidth then
			self.__TabWidth = tabWidth

			-- modify the line head space
			local text = self.__Text.Text
			local lineBreak

			if text == "" then return end

			if text:find("\n") then
				lineBreak = "\n"
			elseif text:find("\r") then
				lineBreak = "\r"
			else
				lineBreak = false
			end

			local headSpace = text:match("^%s+")

			if headSpace and headSpace ~= "" then
				local len = headSpace:len()

				text = strrep(" ", floor(len / oldTab) * tabWidth) .. text:sub(len + 1)
			end

			if lineBreak then
				text = text:gsub(lineBreak .. "(%s+)", function(str)
					local len = str:len()

					len = floor(len / oldTab) * tabWidth
					return lineBreak .. strrep(" ", len)
				end)
			end

			self.__Text.Text = text

			AdjustCursorPosition(self, 0)

			-- Clear operation history
			wipe(self.__Operation)

			wipe(self.__OperationStart)
			wipe(self.__OperationEnd)
			wipe(self.__OperationBackUp)

			wipe(self.__OperationFinalStart)
			wipe(self.__OperationFinalEnd)
			wipe(self.__OperationData)

			self.__OperationIndex = 0

			-- Clear now operation
			self.__OperationOnLine = nil
			self.__OperationBackUpOnLine = nil
			self.__OperationStartOnLine = nil
			self.__OperationEndOnLine = nil
		end
	end

	__Doc__[[
		<desc>Get the tabwidth for the MultiLineTextBox</desc>
		<return type="number">the tab's width</return>
	]]
	function GetTabWidth(self)
		return self.__TabWidth or _TabWidth
	end

	__Doc__[[Whether a key is pressed ]]
	function IsKeyPressed(self, key)
		return _KeyScan.FocusEditor == self and _KeyScan.ActiveKeys[key] or false
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the font's defined table, contains font path, height and flags' settings]]
	property "Font" {
		Get = function(self)
			return self.__Text.Font
		end,
		Set = function(self, font)
			self.__Text.Font = font

			Ajust4Font(self)
		end,
		Type = FontType,
	}

	__Doc__[[the Font object]]
	property "FontObject" { Type = FontObject }

	__Doc__[[the color of the font's text shadow]]
	property "ShadowColor" {
		Get = function(self)
			return ColorType(self:GetShadowColor())
		end,
		Set = function(self, color)
			self:SetShadowColor(color.r, color.g, color.b, color.a)
		end,
		Type = ColorType,
	}

	__Doc__[[the offset of the fontstring's text shadow from its text]]
	property "ShadowOffset" {
		Get = function(self)
			return Dimension(self:GetShadowOffset())
		end,
		Set = function(self, offset)
			self:SetShadowOffset(offset.x, offset.y)
		end,
		Type = Dimension,
	}

	__Doc__[[the fontstring's amount of spacing between lines]]
	property "Spacing" { Type = Number }

	__Doc__[[the fontstring's default text color]]
	property "TextColor" {
		Get = function(self)
			return ColorType(self:GetTextColor())
		end,
		Set = function(self, color)
			self:SetTextColor(color.r, color.g, color.b, color.a)
		end,
		Type = ColorType,
	}

	__Doc__[[true if the edit box only accepts numeric input]]
	property "Numeric" { Type = Boolean }

	__Doc__[[true if the text entered in the edit box is masked]]
	property "Password" { Type = Boolean }

	__Doc__[[true if the edit box automatically acquires keyboard input focus]]
	property "AutoFocus" { Type = Boolean }

	__Doc__[[the maximum number of history lines stored by the edit box]]
	property "HistoryLines" { Type = Number }

	__Doc__[[true if the edit box is currently focused]]
	property "Focused" {
		Set = function(self, focus)
			if focus then
				self:SetFocus()
			else
				self:ClearFocus()
			end
		end,
		Get = "HasFocus",
		Type = Boolean,
	}

	__Doc__[[true if the arrow keys are ignored by the edit box unless the Alt key is held]]
	property "AltArrowKeyMode" { Type = Boolean }

	__Doc__[[the rate at which the text insertion blinks when the edit box is focused]]
	property "BlinkSpeed" { Type = Number }

	__Doc__[[the current cursor position inside edit box]]
	property "CursorPosition" { Type = Number }

	__Doc__[[the maximum number of bytes of text allowed in the edit box, default is 0(Infinite)]]
	property "MaxBytes" { Type = Number }

	__Doc__[[the maximum number of text characters allowed in the edit box]]
	property "MaxLetters" { Type = Number }

	__Doc__[[the contents of the edit box as a number]]
	property "Number" { Type = Number }

	__Doc__[[the edit box's text contents]]
	property "Text" { Type = String }

	__Doc__[[the insets from the edit box's edges which determine its interactive text area]]
	property "TextInsets" {
		Set = function(self, RectInset)
			self:SetTextInsets(RectInset.left, RectInset.right, RectInset.top, RectInset.bottom)
		end,

		Get = function(self)
			return Inset(self:GetTextInsets())
		end,

		Type = Inset,
	}

	__Doc__[[true if the edit box is editable]]
	property "Editable" {
		Set = function(self, flag)
			self.MouseEnabled = flag
			self.__Text.MouseEnabled = flag
			if not flag then
				self.__Text.AutoFocus = false
				if self.__Text:HasFocus() then
					self.__Text:ClearFocus()
				end
			end
		end,

		Get = function(self)
			return self.__Text.MouseEnabled
		end,

		Type = Boolean,
	}

	__Doc__[[Whether show line number or not]]
	property "ShowLineNumber" {
		Set = function(self, flag)
			self.__LineNum.Visible = flag
			self.__Margin.Visible = flag

			Ajust4Font(self)
		end,

		Get = function(self)
			return self.__LineNum.Visible
		end,

		Type = Boolean,
	}

	__Doc__[[Return the x-margin whether the ShowLineNumber is set]]
	property "MarginX" { Get = function (self)
		return self.__Margin.Visible and self.__Margin.Width or 0
	end }

	__Doc__[[The tab's width]]
	property "TabWidth" { Type = Number, Default = _TabWidth }

	__Doc__[[The current operation]]
	property "CurrentOperation" {
		Get = function (self) return self.__OperationOnLine end,
		Type = Operation,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function Frame_OnMouseUp(self)
		if not self.__Text:HasFocus() then
			self.__Text:SetFocus()
		end
	end

    local function Margin_OnMouseDown(self)
		local l, b, w, h = self:GetRect()
		local e = self:GetEffectiveScale()

		self = self.__Container

		self.__MarginMouseDown = true

		local x, y, offsetX, offsetY, line, startp, endp
		local lineHeight = self.__LineNum.Font.height + self.__LineNum.Spacing
		local prevLine = nil

		local startLinep, endLinep, startLine

		while self.__MarginMouseDown do
			-- check if need select line
			x, y = _GetCursorPosition()

			x, y = x / e, y /e
			x = x - l

			offsetY = self.__LineNum:GetTop() -  y

			line = floor(offsetY  / lineHeight + 1)

			if x >= 0 and x <= w and y >= b and y <= b+h and self.__LineNum.Lines and self.__LineNum.Lines[line] then
				if not prevLine then
					first = false

					EndPrevKey(self)

					SaveOperation(self)
				end

				while self.__LineNum.Lines[line] == "" and line > 1 do
					line = line - 1
				end

				if line ~= prevLine then
					startp, endp = GetLines4Line(self, self.__LineNum.Lines[line])

					if not prevLine then
						self:SetFocus()

						startLine = line
						startLinep, endLinep = startp, endp
					end

					self.__HighlightTextStart, self.__HighlightTextEnd = nil, nil

					if line >= startLine then
						self.__MouseDownCur = startLinep
						self.CursorPosition = endp
					else
						self.__MouseDownCur = endLinep
						self.CursorPosition = startp
					end

					prevLine = line
				end
			end

			Threading.Sleep(0.1)
		end
    end

    local function Margin_OnMouseUp(self)
		self = self.__Container

		self.__MarginMouseDown = nil
    end

    local function OnCursorChanged(self, x, y, w, h)
		self = self.__Container

		-- Scroll
		if y and h then
			y = -y

			local value = y + 2*h - self.Height

			if y < self.Value then
				self.Value = y > 0 and y or 0
			elseif value > self.Value then
				if self:GetVerticalScrollRange() + h < value then
					self:ThreadCall(Thread_GoLastLine4Enter, value, h)
				else
					self.Value = value
				end
			end
		end

		self:Fire("OnCursorChanged", x, y, w, h)

		-- Cusotm part
		if self.__InCharComposition then return end

		local cursorPos = self.CursorPosition

		if cursorPos == self.__OldCursorPosition and self.__OperationOnLine ~= _Operation.CUT then
			return
		end

		self.__OldCursorPosition = cursorPos

		if self.__InPasting then
			self.__InPasting = nil
			local startp, endp = self.__HighlightTextStart, cursorPos
			self:HighlightText(cursorPos, cursorPos)

			return self:Fire("OnPasting", startp, endp)
		--[[elseif self.__DBLCLKSELTEXT then
			local str = self.__Text.Text
			local startp, endp = GetWord(str, cursorPos)

			if startp and endp then
				self:HighlightText(startp - 1, endp)
			end

			self.__DBLCLKSELTEXT = nil--]]
		elseif self.__MouseDownShift == false then
			-- First CursorChanged after mouse down if not press shift
			self:HighlightText(cursorPos, cursorPos)

			self.__MouseDownCur = cursorPos
			self.__MouseDownShift = nil
		elseif self.__MouseDownCur then
			if self.__MouseDownCur ~= cursorPos then
				-- Hightlight all
				if self.__HighlightTextStart and self.__HighlightTextEnd and self.__HighlightTextStart ~= self.__HighlightTextEnd then
					if self.__HighlightTextStart == self.__MouseDownCur then
						self:HighlightText(cursorPos, self.__HighlightTextEnd)
					elseif self.__HighlightTextEnd == self.__MouseDownCur then
						self:HighlightText(cursorPos, self.__HighlightTextStart)
					else
						self:HighlightText(self.__MouseDownCur, cursorPos)
					end
				else
					self:HighlightText(self.__MouseDownCur, cursorPos)
				end

				self.__MouseDownCur = cursorPos
			end
		elseif self.__BACKSPACE then

		elseif self.__DELETE then

		elseif self.__SKIPCURCHG then
			if tonumber(self.__SKIPCURCHG) then
				if self.__HighlightTextStart and self.__HighlightTextEnd and self.__HighlightTextStart ~= self.__HighlightTextEnd then
					if self.__HighlightTextStart == self.__SKIPCURCHG then
						self:HighlightText(cursorPos, self.__HighlightTextEnd)
					elseif self.__HighlightTextEnd == self.__SKIPCURCHG then
						self:HighlightText(cursorPos, self.__HighlightTextStart)
					else
						self:HighlightText(self.__SKIPCURCHG, cursorPos)
					end
				else
					self:HighlightText(self.__SKIPCURCHG, cursorPos)
				end
			end

			if not self.__SKIPCURCHGARROW then
				self.__SKIPCURCHG = nil
			else
				self.__SKIPCURCHG = cursorPos
			end
		else
			self:HighlightText(cursorPos, cursorPos)
		end

		if self.__OperationOnLine == _Operation.CUT then
			self:Fire("OnCut", self.__OperationStartOnLine, self.__OperationEndOnLine, self.__OperationBackUpOnLine:sub(self.__OperationStartOnLine, self.__OperationEndOnLine))
			SaveOperation(self)
		end

		return
    end

	local function OnMouseDown(self, ...)
		self = self.__Container

		EndPrevKey(self)

		SaveOperation(self)

		self.__MouseDownCur = self.CursorPosition

		if IsShiftKeyDown() then
			self.__MouseDownShift = true
			self.__MouseDownTime = nil
		else
			self.__MouseDownShift = false
			if self.__MouseDownTime and GetTime() - self.__MouseDownTime < _DBL_CLK_CHK then
				-- mean double click
				self.__DBLCLKSELTEXT = true
				self.__OldCursorPosition = nil

				local str = self.__Text.Text
				local startp, endp = GetWord(str, self.CursorPosition)

				if startp and endp then
					Task.NextCall(HighlightText, self, startp-1, endp)
					--self:HighlightText(startp - 1, endp)
				end

				self.__DBLCLKSELTEXT = nil
			else
				self.__MouseDownTime = GetTime()
			end
		end

		return self:Fire("OnMouseDown", ...)
	end

	local function OnMouseUp(self, ...)
		self = self.__Container

		self.__MouseDownCur = nil
		self.__MouseDownShift = nil

		if self.__MouseDownTime and GetTime() - self.__MouseDownTime < _DBL_CLK_CHK then
			self.__MouseDownTime = GetTime()
		else
			self.__MouseDownTime = nil
		end

		return self:Fire("OnMouseUp", ...)
	end

	_EscapeEventArgs = EventArgs()

    local function OnEscapePressed(self, ...)
    	_EscapeEventArgs.Cancel = false
    	_EscapeEventArgs.Handled = false
    	self.__Container:Fire("OnEscapePressed", _EscapeEventArgs)

    	if _EscapeEventArgs.Handled or _EscapeEventArgs.Cancel then return end

        self:ClearFocus()
    end

    local function OnTextChanged(self, ...)
		self = self.__Container

		return self:Fire("OnTextChanged", ...)
	end

	local function OnSizeChanged(self)
		self = self.__Container
		UpdateLineNum(self)
		return self.ScrollChild:UpdateSize()
	end

    local function OnEditFocusGained(self, ...)
		self = self.__Container

		if _KeyScan.FocusEditor then
			EndPrevKey(_KeyScan.FocusEditor)
		end

		_KeyScan.FocusEditor = self
		_KeyScan.Visible = true

		Task.NoCombatCall(BlockShortKey)

		return self:Fire("OnEditFocusGained", ...)
	end

    local function OnEditFocusLost(self, ...)
		self = self.__Container

		if _KeyScan.FocusEditor == self then
			EndPrevKey(self)
			_KeyScan.FocusEditor = nil
			_KeyScan.Visible = false

			Task.NoCombatCall(UnblockShortKey)
		end

		return self:Fire("OnEditFocusLost", ...)
	end

	_EnterEventArgs = EventArgs()

    local function OnEnterPressed(self, ...)
    	_EnterEventArgs.Cancel = false
    	_EnterEventArgs.Handled = false
    	self.__Container:Fire("OnEnterPressed", _EnterEventArgs)
    	if _EnterEventArgs.Cancel or _EnterEventArgs.Handled then return end

    	if not IsControlKeyDown() then
			self:Insert("\n")
		else
			local _, endp = GetLines(self.Text, self.CursorPosition)
			AdjustCursorPosition(self.__Container, endp)
			self:Insert("\n")
		end

		self = self.__Container

		return self:Fire("OnNewLine")
	end

    local function OnInputLanguageChanged(self, ...)
		self = self.__Container
		return self:Fire("OnInputLanguageChanged", ...)
	end

    local function OnSpacePressed(self, ...)
		self = self.__Container
		return self:Fire("OnSpacePressed", ...)
	end

    local function OnTabPressed(self, ...)
		self = self.__Container

		local text = self.__Text.Text

		if self.__HighlightTextStart == 0 and self.__HighlightTextStart ~= self.__HighlightTextEnd and self.__HighlightTextEnd == self.__Text.Text:len() then
			-- just reload text
			self:SetText(self:GetText())
			return AdjustCursorPosition(self, 0)
		end

		local args = EventArgs()
		self:Fire("OnTabPressed", args)
		if args.Handled or args.Cancel then return end

		local startp, endp, str, lineBreak
		local shiftDown = IsShiftKeyDown()
		local cursorPos = self.CursorPosition

		if self.__HighlightTextStart and self.__HighlightTextEnd and self.__HighlightTextEnd > self.__HighlightTextStart then
			startp, endp, str = GetLines(text, self.__HighlightTextStart, self.__HighlightTextEnd)

			if str:find("\n") then
				lineBreak = "\n"
			elseif str:find("\r") then
				lineBreak = "\r"
			else
				lineBreak = false
			end

			if lineBreak then
				if shiftDown then
					str = str:gsub("[^".. lineBreak .."]+", _ShiftIndentFunc[self.TabWidth])
				else
					str = str:gsub("[^".. lineBreak .."]+", _IndentFunc[self.TabWidth])
				end

				self.__Text.Text = ReplaceBlock(text, startp, endp, str)

				AdjustCursorPosition(self, startp + str:len() - 1)

				self:HighlightText(startp - 1, startp + str:len() - 1)
			else
				if shiftDown then
					cursorPos = startp - 1 + floor((cursorPos - startp) / self.TabWidth) * self.TabWidth

					AdjustCursorPosition(self, cursorPos)
				else
					cursorPos = self.TabWidth - (self.__HighlightTextStart - startp) % self.TabWidth

					str = str:sub(1, self.__HighlightTextStart - startp) .. strrep(" ", cursorPos) .. str:sub(self.__HighlightTextEnd + 2 - startp, -1)

					self.__Text.Text = ReplaceBlock(text, startp, endp, str)

					cursorPos = self.__HighlightTextStart + cursorPos - 1

					AdjustCursorPosition(self, cursorPos)
				end
			end
		else
			startp, endp, str = GetLines(text, cursorPos)

			if shiftDown then
				local _, len = str:find("^%s+")

				if len and len > 0 then
					if startp + len - 1 >= cursorPos then
						str = strrep(" ", len - self.TabWidth) .. str:sub(len + 1, -1)

						self.__Text.Text = ReplaceBlock(text, startp, endp, str)

						if cursorPos - self.TabWidth >= startp - 1 then
							AdjustCursorPosition(self, cursorPos - self.TabWidth)
						else
							AdjustCursorPosition(self, startp - 1)
						end
					else
						cursorPos = startp - 1 + floor((cursorPos - startp) / self.TabWidth) * self.TabWidth

						AdjustCursorPosition(self, cursorPos)
					end
				end
			else
				local byte = strbyte(text, cursorPos + 1)

				if byte == _Byte.RIGHTBRACKET or byte == _Byte.RIGHTPAREN then
					SaveOperation(self)

					AdjustCursorPosition(self, cursorPos + 1)
				else
					local len = self.TabWidth - (cursorPos - startp + 1) % self.TabWidth

					str = str:sub(1, cursorPos - startp + 1) .. strrep(" ", len) .. str:sub(cursorPos - startp + 2, -1)

					self.__Text.Text = ReplaceBlock(text, startp, endp, str)

					AdjustCursorPosition(self, cursorPos + len)
				end
			end
		end
	end

    local function OnTextSet(self, ...)
		self = self.__Container
		return self:Fire("OnTextSet", ...)
	end

	local function OnChar(self, ...)
		self = self.__Container

		if self.__InPasting or not self:HasFocus() then
			return true
		end

		-- Auto paris
		local char = ...

		if char and _AutoPairs[strbyte(char)] ~= nil then
			local text = self.__Text.Text
			local cursorPos = self.CursorPosition

			local startp, endp, str = GetLines(text, cursorPos)

			-- Check if in string
			local pos = 1
			local byte = strbyte(str, pos)
			local cPos = cursorPos - startp + 1
			local isString = 0
			local preEscape = false

			while byte do
				if pos == cPos then
					break
				end

				if not preEscape then
					if byte == _Byte.SINGLE_QUOTE then
						if isString == 0 then
							isString = 1
						elseif isString == 1 then
							isString = 0
						end
					elseif byte == _Byte.DOUBLE_QUOTE then
						if isString == 0 then
							isString = 2
						elseif isString == 2 then
							isString = 0
						end
					end
				end

				if byte == _Byte.BACKSLASH then
					preEscape = not preEscape
				else
					preEscape = false
				end

				pos = pos + 1
				byte = strbyte(str,  pos)
			end

			startp, endp, str = GetWord(text, cursorPos)

			if str and str ~= "" then
				local header = str:sub(1, cursorPos + 1 - startp)
				local tail = str:sub(cursorPos + 2  - startp, -1)

				header = RemoveColor(header) or ""
				tail = RemoveColor(tail) or ""

				if header and header ~= "" then
					local byte = strbyte(char)
					local tbyte = tail ~= "" and strbyte(tail, 1) or 0

					if _AutoPairs[byte] == false then
						-- end pairs like ] ) }
						if isString == 0 and tail and tail ~= "" and tail:sub(1, 1) == char then
							str = header:sub(1, -2) .. tail

							self.__Text.Text = ReplaceBlock(text, startp, endp, str)
							AdjustCursorPosition(self, startp + header:len() - 1)
						end
					elseif _AutoPairs[byte] == true then
						-- ' "
						if tail and tail ~= "" and tail:sub(1, 1) == char then
							str = header:sub(1, -2) .. tail

							self.__Text.Text = ReplaceBlock(text, startp, endp, str)
							AdjustCursorPosition(self, startp + header:len() - 1)
						elseif isString == 0 and tail == "" or tbyte == _Byte.SPACE or tbyte == _Byte.TAB or (_AutoPairs[tbyte] == false) then
							str = header .. char .. tail

							self.__Text.Text =  ReplaceBlock(text, startp, endp, str)
							AdjustCursorPosition(self, startp + header:len() - 1)
						end
					else
						if tail == "" or tbyte == _Byte.SPACE or tbyte == _Byte.TAB or (_AutoPairs[tbyte] == false) then
							str = header .. strchar(_AutoPairs[byte]) .. tail

							self.__Text.Text = ReplaceBlock(text, startp, endp, str)
							AdjustCursorPosition(self, startp + header:len() - 1)
						end
					end
				end
			end
		end

		self.__InCharComposition = nil

		return self:Fire("OnChar", ...)
	end

	local function OnCharComposition(self, ...)
		self = self.__Container

		self.__InCharComposition = true

		return self:Fire("OnCharComposition", ...)
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function MultiLineTextBox(self, name, parent, ...)
    	Super(self, name, parent, ...)

		local container = self.ScrollChild

		local editbox = EditBox("Text", container)
		editbox:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
		editbox:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)
		editbox:SetMultiLine(true)
		editbox:SetTextInsets(5, 5, 3, 3)
		editbox:EnableMouse(true)
		editbox:SetAutoFocus(false)
		editbox:SetFontObject("GameFontNormal")
		editbox.Text = ""
		editbox:ClearFocus()

		local lineNum = FontString("LineNum", container)
		lineNum:SetPoint("LEFT", container, "LEFT", 0, 0)
		lineNum:SetPoint("TOP", editbox, "TOP", 0, 0)
		lineNum.Visible = false
		lineNum.JustifyV = "TOP"
		lineNum.JustifyH = "CENTER"

		local margin = Frame("Margin", self)
		margin:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5)
		margin:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 5, 5)
		margin:SetPoint("RIGHT", lineNum, "RIGHT")
		margin.MouseEnabled = true
		margin.Visible = false

		local texture = Texture("LineNumBack", margin)
		texture:SetAllPoints(margin)
		texture.Color = ColorType(0.12, 0.12, 0.12, 0.8)
		texture.BlendMode = "ADD"

		margin.FrameStrata = "FULLSCREEN"

		self.__LineNum = lineNum
        self.__Text = editbox
		self.__Margin = margin
        editbox.__Container = self
        margin.__Container = self

		-- Operation Keep List
		self.__Operation = {}

		self.__OperationStart = {}
		self.__OperationEnd = {}
		self.__OperationBackUp = {}

		self.__OperationFinalStart = {}
		self.__OperationFinalEnd = {}
		self.__OperationData = {}

		self.__OperationIndex = 0
		self.__MaxOperationIndex = 0

		-- Settings
		Ajust4Font(self)

		self.OnMouseUp = self.OnMouseUp + Frame_OnMouseUp

		margin:ActiveThread("OnMouseUp", "OnMouseDown")
		margin.OnMouseDown = Margin_OnMouseDown
		margin.OnMouseUp = Margin_OnMouseUp

		editbox.OnEscapePressed = editbox.OnEscapePressed + OnEscapePressed
		editbox.OnTextChanged = editbox.OnTextChanged + OnTextChanged
	    editbox.OnCursorChanged = editbox.OnCursorChanged + OnCursorChanged
	    editbox.OnEditFocusGained = editbox.OnEditFocusGained + OnEditFocusGained
	    editbox.OnEditFocusLost = editbox.OnEditFocusLost + OnEditFocusLost
	    editbox.OnEnterPressed = editbox.OnEnterPressed + OnEnterPressed
		editbox.OnSizeChanged = editbox.OnSizeChanged + OnSizeChanged
	    editbox.OnInputLanguageChanged = editbox.OnInputLanguageChanged + OnInputLanguageChanged
	    editbox.OnSpacePressed = editbox.OnSpacePressed + OnSpacePressed
	    editbox.OnTabPressed = editbox.OnTabPressed + OnTabPressed
	    editbox.OnTextSet = editbox.OnTextSet + OnTextSet
		editbox.OnCharComposition = editbox.OnCharComposition + OnCharComposition
		editbox.OnChar = editbox.OnChar + OnChar
		editbox.OnMouseDown = editbox.OnMouseDown + OnMouseDown
		editbox.OnMouseUp = editbox.OnMouseUp + OnMouseUp

		container:UpdateSize()
	end
endclass "MultiLineTextBox"
