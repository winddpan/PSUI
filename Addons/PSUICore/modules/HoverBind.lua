local bind, localmacros = CreateFrame("Frame", "DuffedUIHoverBind", UIParent), 0

-- SLASH COMMAND
SlashCmdList.MOUSEOVERBIND = function()
	if InCombatLockdown() then print("不能在战斗中绑定快捷键！") return end
	if not bind.loaded then
		local find = string.find
		local _G = getfenv(0)

		bind:SetFrameStrata("DIALOG")
		bind:EnableMouse(true)
		bind:EnableKeyboard(true)
		bind:EnableMouseWheel(true)
		bind.texture = bind:CreateTexture()
		bind.texture:SetAllPoints(bind)
		bind.texture:SetTexture(0, 0, 0, .5)
		bind:Hide()

		local elapsed = 0
		GameTooltip:HookScript("OnUpdate", function(self, e)
			elapsed = elapsed + e
			if elapsed < .2 then return else elapsed = 0 end
			if (not self.comparing and IsModifiedClick("COMPAREITEMS")) then
				GameTooltip_ShowCompareItem(self)
				self.comparing = true
			elseif ( self.comparing and not IsModifiedClick("COMPAREITEMS")) then
				for _, frame in pairs(self.shoppingTooltips) do frame:Hide() end
				self.comparing = false
			end
		end)
		hooksecurefunc(GameTooltip, "Hide", function(self) for _, tt in pairs(self.shoppingTooltips) do tt:Hide() end end)

		bind:SetScript("OnEvent", function(self) self:Deactivate(false) end)
		bind:SetScript("OnLeave", function(self) self:HideFrame() end)
		bind:SetScript("OnKeyUp", function(self, key) self:Listener(key) end)
		bind:SetScript("OnMouseUp", function(self, key) self:Listener(key) end)
		bind:SetScript("OnMouseWheel", function(self, delta) if delta>0 then self:Listener("MOUSEWHEELUP") else self:Listener("MOUSEWHEELDOWN") end end)

		function bind:Update(b, spellmacro)
			if not self.enabled or InCombatLockdown() then return end
			self.button = b
			self.spellmacro = spellmacro

			self:ClearAllPoints()
			self:SetAllPoints(b)
			self:Show()

			ShoppingTooltip1:Hide()

			if spellmacro == "SPELL" then
				self.button.id = SpellBook_GetSpellBookSlot(self.button)
				self.button.name = GetSpellBookItemName(self.button.id, SpellBookFrame.bookType)

				GameTooltip:AddLine("Trigger")
				GameTooltip:Show()
				GameTooltip:SetScript("OnHide", function(self)
					self:SetOwner(bind, "ANCHOR_TOP")
					self:SetPoint("BOTTOM", bind, "TOP", 0, 1)
					self:AddLine(bind.button.name, 1, 1, 1)
					bind.button.bindings = {GetBindingKey(spellmacro.." "..bind.button.name)}
					if #bind.button.bindings == 0 then
						self:AddLine("没有快捷键", .6, .6, .6)
					else
						self:AddDoubleLine("Binding", "Key", .6, .6, .6, .6, .6, .6)
						for i = 1, #bind.button.bindings do self:AddDoubleLine(i, bind.button.bindings[i]) end
					end
					self:Show()
					self:SetScript("OnHide", nil)
				end)
			elseif spellmacro == "MACRO" then
				self.button.id = self.button:GetID()

				if localmacros==1 then self.button.id = self.button.id + 36 end

				self.button.name = GetMacroInfo(self.button.id)

				GameTooltip:SetOwner(bind, "ANCHOR_TOP")
				GameTooltip:SetPoint("BOTTOM", bind, "TOP", 0, 1)
				GameTooltip:AddLine(bind.button.name, 1, 1, 1)

				bind.button.bindings = {GetBindingKey(spellmacro.." "..bind.button.name)}
					if #bind.button.bindings == 0 then
						GameTooltip:AddLine(EMPTY, .6, .6, .6)
					else
						GameTooltip:AddDoubleLine("Binding", "Key", .6, .6, .6, .6, .6, .6)
						for i = 1, #bind.button.bindings do GameTooltip:AddDoubleLine("Binding"..i, bind.button.bindings[i], 1, 1, 1) end
					end
				GameTooltip:Show()
			elseif spellmacro == "STANCE" or spellmacro == "PET" then
				self.button.id = tonumber(b:GetID())
				self.button.name = b:GetName()

				if not self.button.name then return end

				if not self.button.id or self.button.id < 1 or self.button.id > (spellmacro=="STANCE" and 10 or 12) then
					self.button.bindstring = "CLICK "..self.button.name..":LeftButton"
				else
					self.button.bindstring = (spellmacro=="STANCE" and "SHAPESHIFTBUTTON" or "BONUSACTIONBUTTON")..self.button.id
				end

				GameTooltip:AddLine("Trigger")
				GameTooltip:Show()
				GameTooltip:SetScript("OnHide", function(self)
					self:SetOwner(bind, "ANCHOR_TOP")
					self:SetPoint("BOTTOM", bind, "TOP", 0, 1)
					self:AddLine(bind.button.name, 1, 1, 1)
					bind.button.bindings = {GetBindingKey(bind.button.bindstring)}
					if #bind.button.bindings == 0 then
						self:AddLine(EMPTY, .6, .6, .6)
					else
						self:AddDoubleLine(KEY_BINDING, "Key", .6, .6, .6, .6, .6, .6)
						for i = 1, #bind.button.bindings do self:AddDoubleLine(i, bind.button.bindings[i]) end
					end
					self:Show()
					self:SetScript("OnHide", nil)
				end)
			else
				self.button.action = tonumber(b.action)
				self.button.name = b:GetName()

				if not self.button.name then return end

				if not self.button.action or self.button.action < 1 or self.button.action > 132 and not self.button.keyBoundTarget then
					self.button.bindstring = "CLICK "..self.button.name..":LeftButton"
				elseif self.button.keyBoundTarget then
					self.button.bindstring = self.button.keyBoundTarget
				else
					local modact = 1+(self.button.action-1)%12
					if self.button.action < 25 or self.button.action > 72 then
						self.button.bindstring = "ACTIONBUTTON"..modact
					elseif self.button.action < 73 and self.button.action > 60 then
						self.button.bindstring = "MULTIACTIONBAR1BUTTON"..modact
					elseif self.button.action < 61 and self.button.action > 48 then
						self.button.bindstring = "MULTIACTIONBAR2BUTTON"..modact
					elseif self.button.action < 49 and self.button.action > 36 then
						self.button.bindstring = "MULTIACTIONBAR4BUTTON"..modact
					elseif self.button.action < 37 and self.button.action > 24 then
						self.button.bindstring = "MULTIACTIONBAR3BUTTON"..modact
					end
				end

				GameTooltip:AddLine("Trigger")
				GameTooltip:Show()
				GameTooltip:SetScript("OnHide", function(self)
					self:SetOwner(bind, "ANCHOR_TOP")
					self:SetPoint("BOTTOM", bind, "TOP", 0, 1)
					self:AddLine(bind.button.name, 1, 1, 1)
					bind.button.bindings = {GetBindingKey(bind.button.bindstring)}
					if #bind.button.bindings == 0 then
						self:AddLine("没有快捷键", .6, .6, .6)
					else
						self:AddDoubleLine(KEY_BINDING, "Key", .6, .6, .6, .6, .6, .6)
						for i = 1, #bind.button.bindings do self:AddDoubleLine(i, bind.button.bindings[i]) end
					end
					self:Show()
					self:SetScript("OnHide", nil)
				end)
			end
		end

		function bind:Listener(key)
			if key == "ESCAPE" or key == "RightButton" then
				for i = 1, #self.button.bindings do SetBinding(self.button.bindings[i]) end
				print("|cff00ff00"..self.button.name.." 快捷键已清除|r.")
				self:Update(self.button, self.spellmacro)
				if self.spellmacro~="MACRO" then GameTooltip:Hide() end
				return
			end

			if key == "LSHIFT"
			or key == "RSHIFT"
			or key == "LCTRL"
			or key == "RCTRL"
			or key == "LALT"
			or key == "RALT"
			or key == "UNKNOWN"
			or key == "LeftButton"
			then return end

			if key == "MiddleButton" then key = "BUTTON3" end
			if key:find('Button%d') then key = key:upper() end

			local alt = IsAltKeyDown() and "ALT-" or ""
			local ctrl = IsControlKeyDown() and "CTRL-" or ""
			local shift = IsShiftKeyDown() and "SHIFT-" or ""

			if not self.spellmacro or self.spellmacro == "PET" or self.spellmacro == "STANCE" then
				SetBinding(alt..ctrl..shift..key, self.button.bindstring)
			else
				SetBinding(alt..ctrl..shift..key, self.spellmacro.." "..self.button.name)
			end
			print(alt..ctrl..shift..key.." |cff00ff00已绑定到 |r"..self.button.name..".")
			self:Update(self.button, self.spellmacro)
			if self.spellmacro ~= "MACRO" then GameTooltip:Hide() end
		end
		function bind:HideFrame()
			self:ClearAllPoints()
			self:Hide()
			GameTooltip:Hide()
		end
		function bind:Activate()
			self.enabled = true
			self:RegisterEvent("PLAYER_REGEN_DISABLED")
		end
		function bind:Deactivate(save)
			if save then
				SaveBindings(2)
				print("所有快捷键设置已经保存！")
			else
				LoadBindings(2)
				print("取消保存快捷键设置！")
			end
			self.enabled = false
			self:HideFrame()
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
			StaticPopup_Hide("KEYBIND_MODE")
		end

		StaticPopupDialogs.KEYBIND_MODE = {
			text = "将鼠标移到动作条上绑定快捷键， 按ESC或者鼠标右键清除快捷键设置。",
			button1 = APPLY,
			button2 = CANCEL,
			OnAccept = function() bind:Deactivate(true) end,
			OnCancel = function() bind:Deactivate(false) end,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = true,
			preferredIndex = 5,
		}

		-- REGISTERING
		local stance = StanceButton1:GetScript("OnClick")
		local pet = PetActionButton1:GetScript("OnClick")
		local button = ActionButton1:GetScript("OnClick")

		local function register(val, override)
			if val.IsProtected and val.GetObjectType and val.GetScript and val:GetObjectType() == "CheckButton" and val:IsProtected() then
				local script = val:GetScript("OnClick")
				if script == button or override then
					val:HookScript("OnEnter", function(self) bind:Update(self) end)
				elseif script == stance then
					val:HookScript("OnEnter", function(self) bind:Update(self, "STANCE") end)
				elseif script == pet then
					val:HookScript("OnEnter", function(self) bind:Update(self, "PET") end)
				end
			end
		end

		local val = EnumerateFrames()
		while val do
			register(val)
			val = EnumerateFrames(val)
		end

		for i = 1, 12 do
			local b = _G["SpellButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self, "SPELL") end)
		end
		
		local function registermacro()
			for i = 1, 36 do
				local b = _G["MacroButton"..i]
				b:HookScript("OnEnter", function(self) bind:Update(self, "MACRO") end)
			end
			MacroFrameTab1:HookScript("OnMouseUp", function() localmacros = 0 end)
			MacroFrameTab2:HookScript("OnMouseUp", function() localmacros = 1 end)
		end
		
		if not IsAddOnLoaded("Blizzard_MacroUI") then
			hooksecurefunc("LoadAddOn", function(addon)
				if addon == "Blizzard_MacroUI" then registermacro() end
			end)
		else
			registermacro()
		end
		bind.loaded = 1
	end
	if not bind.enabled then
		bind:Activate()
		StaticPopup_Show("KEYBIND_MODE")
		local stance = StanceButton1:GetScript("OnClick")
		local pet = PetActionButton1:GetScript("OnClick")
		local button = SecureActionButton_OnClick
		local focus = GetMouseFocus()
		if focus.IsProtected and focus.GetObjectType and focus.GetScript and focus:GetObjectType() == "CheckButton" and focus:IsProtected() then
			local script = focus:GetScript("OnClick")
			if script == button then
				bind:Update(focus)
			elseif script == stance then
				bind:Update(focus, "STANCE")
			elseif script == pet then
				bind:Update(focus, "PET")
			end
		end
	end
end
SLASH_MOUSEOVERBIND1 = "/kb"
SLASH_MOUSEOVERBIND2 = "/hb"