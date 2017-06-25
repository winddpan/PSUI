local GetAddOnMetadata = GetAddOnMetadata

local L = LibStub("AceLocale-3.0"):GetLocale("XentiTargets")

XentiTargets.defaults = {
	profile = {
		locked = false,
		frameScale = 1,
		barWidth = 190,
		useGlobalFontSize = true,
		globalFontSize = 12,
		globalFont = "Arialn",
		showRealm = true
	},
}

local function getOption(option)
	return option.arg and XentiTargets.dbi.profile[option.arg] or XentiTargets.dbi.profile[option[#option]]
end

local function setOption(option, value)
	local key = option[#option]

	XentiTargets.dbi.profile[key] = value

	option = option.arg and option.arg or option[1]
	if option == 'general' then
		XentiTargets:UpdateFrame()
	else
		XentiTargets:UpdateFrame(option)
	end
end

function XentiTargets:SetupOptions()
	self.options = {
		type = "group",
		name = "XentiTargets " .. GetAddOnMetadata("XentiTargetsDR", "Version"),
		plugins = {},
		get = getOption,
		set = setOption,
		args = {
			general = {
				type = "group",
				name = L["UI_General"],
				desc = L["UI_General settings"],
				order = 1,
				args = {
					general = {
						type = "group",
						name = L["UI_General"],
						desc = L["UI_General settings"],
						inline = true,
						order = 1,
						args = {
							locked = {
								type = "toggle",
								name = L["UI_Lock frame"],
								desc = L["UI_Toggle if the frame can be moved"],
								order = 1,
							},
							showRealm = {
								type = "toggle",
								name = L["UI_Show realm"],
								desc = L["UI_Toggle if the name should contain the realm"],
								order = 2,
							},
						}
					},
					size = {
						type = "group",
						name = L["UI_Size"],
						desc = L["UI_Size settings"],
						inline = true,
						order = 3,
						args = {
							barWidth = {
								type = "range",
								name = L["UI_Bar width"],
								desc = L["UI_Width of the bars"],
								min = 10,
								max = 500,
								step = 1,
								order = 1,
							},
							frameScale = {
								type = "range",
								name = L["UI_Frame scale"],
								desc = L["UI_Scale of the frame"],
								min = 0.1,
								max = 2,
								step = 0.1,
								order = 5,
							},
						},
					},
					font = {
						type = "group",
						name = L["UI_Font"],
						desc = L["UI_Font settings"],
						inline = true,
						order = 4,
						args = {
							globalFont = {
								type = "select",
								name = L["UI_Global Font"],
								desc = L["UI_Global Font"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								order = 1,
							},
							globalFontSize = {
								type = "range",
								name = L["UI_Global Font Size"],
								desc = L["UI_Global Font Size desc"],
								disabled = function()
									return not self.db.useGlobalFontSize
								end,
								min = 1,
								max = 20,
								step = 1,
								order = 5,
							},
							sep = {
								type = "description",
								name = "",
								width = "full",
								order = 7,
							},
							useGlobalFontSize = {
								type = "toggle",
								name = L["UI_Use Global Font Size"],
								desc = L["UI_Toggle if you want to use the global font size"],
								order = 10,
							},
						},
					},
				}
			}
		}
	}

	self.options.plugins.profiles = {profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.dbi)}
	LibStub("AceConfig-3.0"):RegisterOptionsTable("XentiTargets", self.options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("XentiTargets", "XentiTargets")
end

SLASH_XENTITARGETS1, SLASH_XENTITARGETS2, SLASH_XENTITARGETS3 = "/xentitargets", "/xt", "/XentiTargets"
SlashCmdList["XENTITARGETS"] = function(msg)
	if msg:find("test") and not XentiTargets.test then

	else
		AceDialog = AceDialog or LibStub("AceConfigDialog-3.0")
		AceRegistry = AceRegistry or LibStub("AceConfigRegistry-3.0")
		if not XentiTargets.options then
			XentiTargets:SetupOptions()
			AceDialog:SetDefaultSize("XentiTargets", 830, 530)
		end
		AceDialog:Open("XentiTargets")
	end
end