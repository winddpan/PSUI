local addon = LibStub("AceAddon-3.0"):GetAddon("RCLootCouncil")
local EU = addon:GetModule("RCExtraUtilities")
local L = LibStub("AceLocale-3.0"):GetLocale("RCLootCouncil")
local LE = LibStub("AceLocale-3.0"):GetLocale("RCExtraUtilities")

------ Options ------
function EU:OptionsTable()
   local addon_db = addon:Getdb()
   local options = {
      name = "Extra Utilities",
      order = 1,
      type = "group",
      childGroups = "tab",
      args = {
         desc = {
            name = format(LE["extra_util_desc"], self.version),
            order = 1,
            type = "description",
         },
         general = {
            name = L.General,
            order = 1,
            type = "group",
            args = {
               columns = {
                  name = LE["Extra Utilities Columns"],
                  order = 2,
                  type = "group",
                  inline = true,
                  handler = EU,
                  set = "ColSet",
                  get = "ColGet",
                  args = {
                     pawn = {
                        name = "Pawn",
                        order = 1,
                        type = "toggle",
                        desc = LE["opt_pawn_desc"],
                        tristate = true,
                     },
                     traits = {
                        name = LE["Artifact Traits"],
                        order = 2,
                        type = "toggle",
                        desc = LE["opt_traits_desc"],
                     },
                     upgrades = {
                        name = LE["Upgrades"],
                        order = 3,
                        type = "toggle",
                        desc = LE["opt_upgrades_desc"],
                     },
                     sockets = {
                        name = LE["Sockets"],
                        order = 4,
                        type = "toggle",
                        desc = LE["opt_sockets_desc"],
                     },
                     --[[setPieces = {
                        name = LE["Set Pieces"],
                        order = 5,
                        type = "toggle",
                        desc = LE["opt_setpieces_desc"],
                     },]]
                     titanforged = {
                        name = LE["Forged"],
                        order = 6,
                        type = "toggle",
                        desc = LE["opt_forged_desc"],
                     },
                     legendaries = {
                        name = LE["Legendaries"],
                        order = 7,
                        type = "toggle",
                        desc = LE["opt_legendaries_desc"],
                     },
                     ilvlUpgrade = {
                        name = LE["ilvl Upgrades"],
                        order = 8,
                        type = "toggle",
                        desc = LE["opt_ilvlupgrades_desc"],
                     },
                     spec = {
                        name = LE["Spec Icon"],
                        order = 9,
                        type = "toggle",
                        desc = LE["opt_specIcon_desc"],
                     },
                     bonus = {
                        name = LE["Bonus Rolls"],
                        order = 10,
                        type = "toggle",
                        desc = LE["opt_bonusRoll_desc"],
                     },
                     ep = {
                        name = "EP",
                        order = 11,
                        type = "toggle",
                        desc = LE["opt_ep_desc"],
                        tristate = true,
                     },
                     gp = {
                        name = "GP",
                        order = 12,
                        type = "toggle",
                        desc = LE["opt_gp_desc"],
                        tristate = true,
                     },
                     pr = {
                        name = "PR",
                        order = 13,
                        type = "toggle",
                        desc = LE["opt_pr_desc"],
                        tristate = true,
                     },
                     guildNotes = {
                        name = LE["Guild Notes"],
                        order = 14,
                        type = "toggle",
                        desc = LE["opt_guildNotes_desc"],
                     },
                     header = {
                        order = -1,
                        name = "",
                        type = "header",
                     },
                     reset = {
                        name = L["Reset to default"],
                        order = -1,
                        --width = "full",
                        type = "execute",
                        confirm = true,
                        func = function()
                           if self.votingFrame.frame and self.votingFrame.frame:IsVisible() then return addon:Print(LE["You can't change these settings while the voting frame is showing."]) end
                           for k in pairs(self.db.columns) do
                              self.db.columns[k] = self.defaults.profile.columns[k]
                              -- Now apply the changes
                              self:UpdateColumn(k, self.db.columns[k].enabled)
                           end
                        end,
                     },
                  },
               },
               normalColumns = {
                  name = LE["RCLootCouncil Columns"],
                  order = 3,
                  type = "group",
                  inline = true,
                  args = {
                     -- Created further down
                     header = {
                        name = "",
                        order = -1,
                        type = "header",
                     },
                     reset = {
                        name = L["Reset to default"],
                        order = -1,
                        --width = "full",
                        type = "execute",
                        confirm = true,
                        func = function()
                           if self.votingFrame.frame and self.votingFrame.frame:IsVisible() then return addon:Print(LE["You can't change these settings while the voting frame is showing."]) end
                           for k in pairs(self.db.normalColumns) do
                              self.db.normalColumns[k] = self.defaults.profile.normalColumns[k]
                              -- Now apply the changes
                              self:UpdateColumn(k, self.db.normalColumns[k].enabled)
                           end
                        end,
                     },
                  },
               },

               otherOptions = {
                  name = LE["Other"],
                  order = 5,
                  type = "group",
                  inline = true,
                  args = {
                     decimals = {
                        name = LE["ilvl Decimals"],
                        order = 1,
                        type = "toggle",
                        desc = LE["opt_ilvldecimals_desc"],
                        get = function() return addon_db.iLvlDecimal end,
                        set = function(_, val) addon_db.iLvlDecimal = val end,
                     },
                  },
               }
            },
         },
         pawnOptions = {
            order = 2,
            type = "group",
            name = "Pawn",
            desc = LE["Pawn specific options"],
            disabled = function() return not PawnVersion end,
            childGroups = "tab",
            args = {
               acceptPawn = {
                  order = 1,
                  name = LE["Accept Pawn"],
                  desc = LE["opt_acceptPawn_desc"],
                  type = "toggle",
                  set = function() self.db.acceptPawn = not self.db.acceptPawn end,
                  get = function() return self.db.acceptPawn end,
               },
               pawnNormalMode = {
                  order = 2,
                  name = LE["Score Mode"],
                  desc = LE["opt_pawnMode_desc"],
                  type = "toggle",
                  set = function() self.db.pawnNormalMode = not self.db.pawnNormalMode end,
                  get = function() return self.db.pawnNormalMode end,
               },
               scalesGroup = {
                  order = 3,
                  type = "group",
                  --inline = true,
                  name = LE["Scales"],
                  childGroups = "tree",
                  args = {
                     desc = {
                        name = LE["opt_scalesGroup_desc"],
                        type = "description",
                        order = 0,
                     },
                  },
               },
            },
         },
         widthOptions = {
            order = 3,
            type = "group",
            name = LE["Advanced"],
            childGroups = "tab",
            args = {
               subGroup = {
                  order = 1,
                  type = "group",
                  name = " ",
                  inline = true,
                  args = {
                     open = {
                        order = 1,
                        name = LE["Open Voting Frame"],
                        type = "execute",
                        func = function() addon:Test(2) end,
                     },
                     reset = {
                        order = 2,
                        type = "execute",
                        name = L["Reset to default"],
                        desc = LE["opt_advReset_desc"],
                        confirm = true,
                        func = function()
                           for name in pairs(self.db.columns) do
                              self.db.columns[name].pos = self.defaults.profile.columns[name].pos
                              self.db.columns[name].width = self.defaults.profile.columns[name].width
                           end
                           for name in pairs(self.db.normalColumns) do
                              self.db.normalColumns[name].width = self.defaults.profile.normalColumns[name].width
                              self.db.normalColumns[name].pos = nil
                           end
                           self:SetupColumns()
                           if self.votingFrame.frame then
                              self.votingFrame.frame.UpdateSt()
                           end
                        end,
                     },
                  },
               },
               columns = {
                  order = -1,
                  name = LE["Extra Utilities Columns"],
                  type = "group",
                  args = {
                     -- Made further down
                     desc = {
                        order = 0,
                        name = LE["opt_advanced_desc"],
                        type = "description",
                        width = "full",
                     },
                  },
               },
               normalColumns = {
                  order = -1,
                  name = LE["RCLootCouncil Columns"],
                  type = "group",
                  args = {
                     -- Made further down
                  },
               },
            },
         },
      },
   }
   -- Create the normalColumns
   local i = 0
   for _, name in ipairs(self.optionsNormalColOrder) do
      local entry = self.db.normalColumns[name]
      i = i + 1
      -- Enabledness
      if type(entry.enabled) == "boolean" then -- Don't allow certain things to be turned off
         options.args.general.args.normalColumns.args[name] = {
            order = i,
            name = entry.name,
            type = "toggle",
            desc = format(LE["opt_normalcolumn_desc"], entry.name),
            set = function()
               if self.votingFrame.frame and self.votingFrame.frame:IsVisible() then return addon:Print(LE["You can't change these settings while the voting frame is showing."]) end
               entry.enabled = not entry.enabled
               self:UpdateColumn(name, entry.enabled)
            end,
            get = function() return entry.enabled end
         }
      end
      -- Position
      options.args.widthOptions.args.normalColumns.args[name.."Pos"] = {
         order = i,
         name = entry.name,
         desc = format(LE["opt_position_desc"], entry.name),
         type = "input",
         pattern = "%d",
         usage = LE["opt_position_usage"],
         get = function() return tostring(entry.pos or self:GetScrollColIndexFromName(name)) end,
         set = function(info, txt)
            entry.pos = tonumber(txt)
            self:UpdateColumnPosition(name, tonumber(txt))
         end,
      }
      -- Width
      options.args.widthOptions.args.normalColumns.args[name.."Width"] = {
         order = i + 0.1,
         name = entry.name,
         desc = format(LE["column_width_desc"], entry.name),
         type = "range",
         width = "double",
         min = 10,
         max = 300,
         step = 1,
         get = function() return entry.width or self.originalCols[name].width end,
         set = function(_, val)
            entry.width = val
            self:UpdateColumnWidth(name, val)
         end,
      }
   end
   -- Create width slider for the EU cols
   i = 0
   for _, name in ipairs(self.optionsColOrder) do
      local entry = self.db.columns[name]
      i = i + 1 * 2
      options.args.widthOptions.args.columns.args[name.."Pos"] = {
         order = i,
         name = name == "spec" and "Spec" or entry.name, -- Special case with spec
         desc = format(LE["opt_position_desc"], entry.name),
         type = "input",
         pattern = "%d",
         usage = LE["opt_position_usage"],
         get = function() return tostring(entry.pos) end,
         set = function(info, txt)
            entry.pos = tonumber(txt)
            self:UpdateColumnPosition(name, tonumber(txt))
         end,
      }
      options.args.widthOptions.args.columns.args[name.."Width"] = {
         order = i + 1,
         name = name == "spec" and "Spec" or entry.name, -- Special case with spec
         desc = format(LE["column_width_desc"], entry.name),
         type = "range",
         width = "double",
         min = 10,
         max = 300,
         step = 1,
         get = function() return entry.width end,
         set = function(_, val)
            entry.width = val
            self:UpdateColumnWidth(name, val)
         end,
      }
   end

   options = self:CreatePawnScaleOptions(options)

   LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("RCLootCouncil - Extra Utilities", options)
   self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RCLootCouncil - Extra Utilities", "Extra Utilities", "RCLootCouncil")
end

function EU:ColSet(info, val)
   if self.votingFrame.frame and self.votingFrame.frame:IsVisible() then return addon:Print(LE["You can't change these settings while the voting frame is showing."]) end
   if info.option.tristate then
      if info[#info] == "pawn" then
         if not PawnVersion then return addon:Print(info.option.name, LE["opt_addon_requirement"]) end
      else
         if not EPGP then return addon:Print("EPGP", LE["opt_addon_requirement"]) end
      end
   end
   -- v0.5.0: we can't use val anymore as we have tristates, so just invert stuff
   self.db.columns[info[#info]].enabled = not self.db.columns[info[#info]].enabled
   self:UpdateColumn(info[#info], val)
end

function EU:ColGet(info)
   if info.option.tristate then
      if info[#info] == "pawn" then
         if not PawnVersion then return nil end
      else
         if not EPGP then return nil end
      end
   end
   return self.db.columns[info[#info]].enabled
end

-- Seperate Pawn scales for sanity
function EU:CreatePawnScaleOptions(options)
   if not PawnVersion then return options end -- Just in case
   local scales = {}
   for k in pairs(PawnCommon.Scales) do
      scales[k] = k
   end
   local i = 1
   for class, opt in pairs(self.db.pawn) do
      local c = addon:GetClassColor(class)
      local hex = "|cFF"..addon:RGBToHex(c.r,c.g,c.b)
      options.args.pawnOptions.args.scalesGroup.args[class] = {
         order = i,
         type = "group",
         name = hex..LOCALIZED_CLASS_NAMES_MALE[class],
         args = {},
      }
      local j = 0
      for specID, scale in pairs(opt) do
         local _, name, description, icon = GetSpecializationInfoByID(specID)
         options.args.pawnOptions.args.scalesGroup.args[class].args[""..specID] = {
            order = j * 2 + 1,
            name = hex..name,
            type = "description",
            fontSize = "large",
            image = icon,
            imageWidth = 26,
            imageHeight = 26,
         }
         options.args.pawnOptions.args.scalesGroup.args[class].args[specID.."scale"] = {
            order = j * 2 + 2,
            type = "select",
            name = "",
            style = "dropdown",
            width = "full",
            values = scales,
            get = function() return self.db.pawn[class][specID] end,
            set = function(info, key) self.db.pawn[class][specID] = key end,
         }
         j = j + 1
      end
      i = i + 1
   end




   return options
end
