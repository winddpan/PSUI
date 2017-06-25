local mod = _G.WQA
local L = LibStub("AceLocale-3.0"):GetLocale("WorldQuestAssistant")

local options = {
  type = "group",
  args = {
    config = {
      name = L["Behavior"],
      type = "group",
      order = 50,
      args = {
        keybindings = {
          type = "group",
          name = L["Keybindings"],
          args = {
            keybinding = {
              type = "keybinding",
              name = L["Automation Keybind"],
              desc = L["Automation Keybind Help"],
              order = 10,
              width = "double",
              get = function()
                return GetBindingKey("WQA_AUTOMATE")
              end,
              set = function(info, v)
                local old = GetBindingKey("WQA_AUTOMATE")
                if old then
                  SetBinding(old)
                end
                SetBinding(v, "WQA_AUTOMATE")
                SaveBindings(GetCurrentBindingSet())
              end
            },
            cancelAutoLeaveKeybinding = {
              type = "keybinding",
              name = L["Cancel group leave"],
              desc = L["Cancel group leave help"],
              order = 11,
              width = "double",
              get = function()
                return GetBindingKey("WQA_ABORT_PARTY_LEAVE")
              end,
              set = function(info, v)
                local old = GetBindingKey("WQA_ABORT_PARTY_LEAVE")
                if old then
                  SetBinding(old)
                end
                SetBinding(v, "WQA_ABORT_PARTY_LEAVE")
                SaveBindings(GetCurrentBindingSet())
              end
            },
            newGroupKeybinding = {
              type = "keybinding",
              name = L["Create a new group"],
              desc = L["Create a new group help"],
              width = "double",
              order = 12,
              get = function()
                return GetBindingKey("WQA_NEW_PARTY")
              end,
              set = function(info, v)
                local old = GetBindingKey("WQA_NEW_PARTY")
                if old then
                  SetBinding(old)
                end
                SetBinding(v, "WQA_NEW_PARTY")
                SaveBindings(GetCurrentBindingSet())
              end
            },
          }
        },
        onStart = {
          type = "group",
          name = L["Starting Quests"],
          order = 50,
          inline = true,
          args = {
            join = {
              name = L["Ask to join or start a group when starting a world quest"],
              desc = L["Ask To Join - Description"],
              type = "toggle",
              width = "full",
              get = function()
                return mod.db.profile.usePopups.joinGroup
              end,
              set = function(info, v)
                mod.db.profile.usePopups.joinGroup = v
              end
            },
            createGroup = {
              name = L["Prompt to start a new group if no groups can be found"],
              desc = L["Prompt to start a new group - Description"],
              type = "toggle",
              width = "full",
              get = function()
                return mod.db.profile.usePopups.createGroup
              end,
              set = function(info, v)
                mod.db.profile.usePopups.createGroup = v
              end
            },
            joinPVP = {
              name = L["Join groups on PVP realms"],
              desc = L["Join groups on PVP realms - Description"],
              type = "toggle",
              width = "full",
              get = function()
                return mod.db.profile.joinPVP
              end,
              set = function(info, v)
                mod.db.profile.joinPVP = v
              end
            },
            preferHome = {
              name = L["Prefer groups on home realm"],
              desc = L["Prefer groups on home realm - Description"],
              type = "toggle",
              width = "full",
              get = function(info)
                return mod.db.profile.preferHome
              end,
              set = function(info, v)
                mod.db.profile.preferHome = v
              end
            }
          }
        },
        onFinish = {
          type = "group",
          name = L["Finishing Quests"],
          order = 55,
          inline = true,
          args = {
            action = {
              name = L["When a quest is complete"],
              type = "select",
              values = {
                ask = L["Ask to leave the group"],
                leave = L["Automatically leave after a delay"],
                leaveWhenFlying = L["Automatically leave once you're flying"],
                none = L["Do nothing"]
              },
              order = 105,
              width = "full",
              get = function()
                return mod.db.profile.doneBehavior
              end,
              set = function(info, v)
                mod.db.profile.doneBehavior = v
              end
            },
            leaveDelay = {
              name = L["Seconds to wait before automatically leaving the group"],
              order = 110,
              type = "range",
              min = 0,
              max = 120,
              step = 1,
              bigStep = 5,
              get = function(info)
                return mod.db.profile.leaveDelay
              end,
              set = function(info, v)
                mod.db.profile.leaveDelay = v
              end,
              hidden = function()
                return mod.db.profile.doneBehavior ~= "leave"
              end
            },
            alertDone = {
              name = L["Alert party when quest is complete"],
              desc = L["Alert party when quest is complete - Description"],
              type = "toggle",
              width = "full",
              get = function()
                return mod.db.profile.alertComplete
              end,
              set = function(info, v)
                mod.db.profile.alertComplete = v
              end
            }
          }
        },
        advanced = {
          type = "group",
          inline = true,
          order = 60,
          name = L["Advanced"],
          args = {
            allowGroupingInGroups = {
              type = "toggle",
              name = L["Allow group queueing"],
              desc = L["Allow group queueing help"],
              get = function() return mod.db.profile.permitGroupQueueing end,
              set = function(info, v)
                mod.db.profile.permitGroupQueueing = v
              end,
            },
            showQuestLogButtons = {
              type = "toggle",
              name = L["Show tracker buttons"],
              desc = L["Show tracker buttons help"],
              get = function() return mod.db.profile.showUI end,
              set = function(info, v)
                mod.db.profile.showUI = v
                mod.UI:SetupTrackerBlocks()
              end,
            },
            searchByQuestID = {
              type = "toggle",
              name = L["Search by quest ID"],
              desc = L["Perform searches by quest ID rather than name. Will only find groups created by WQA/WQGF, but may work better cross-region."],
              get = function() return mod.db.profile.searchByID end,
              set = function(info, v)
                mod.db.profile.searchByID = v
              end
            }
          },
        },
        filters = {
          type = "group",
          name = L["Quest Filters"],
          args = {
            petBattles = {
              type = "toggle",
              name = L["Pet Battle Quests"],
              desc = L["Pet Battles Filter Description"],
              width = "full",
              descStyle = "inline",
              get = function() return mod.db.profile.filters.petBattles end,
              set = function(info, v) mod.db.profile.filters.petBattles = v end
            },
            tradeskills = {
              type = "toggle",
              name = L["Tradeskill Quests"],
              desc = L["Tradeskills Filter Description"],
              width = "full",
              descStyle = "inline",
              get = function() return mod.db.profile.filters.tradeskills end,
              set = function(info, v) mod.db.profile.filters.tradeskills = v end
            },
            pvp = {
              type = "toggle",
              name = L["PVP Quests"],
              desc = L["PVP Filter Description"],
              width = "full",
              descStyle = "inline",
              get = function() return mod.db.profile.filters.pvp end,
              set = function(info, v) mod.db.profile.filters.pvp = v end
            },
            nonElite = {
              type = "toggle",
              name = L["Non-Elite Quests"],
              desc = L["Non-Elite Filter Description"],
              width = "full",
              descStyle = "inline",
              get = function() return mod.db.profile.filters.nonElite end,
              set = function(info, v) mod.db.profile.filters.nonElite = v end
            }
          }
        },
      }
    },
    credits = {
      type = "group",
      name = L["Credits"],
      order = 999,
      args = {
        header = {
          type = "header",
          name = "World Quest Assistant",
          order = 1,
        },
        credits = {
          type = "description",
          order = 10,
          name = [[
Originally inspiried by World Quest Group Finder and its brief death during the Great Group Finder Function Breakage of '17

Author: Antiarc (Adrine@Cenarion Circle)

Translation Credits

deDE: Sparky

Many thanks to all the early testers and bug reporters!
]]
        }
      }
    }
  }
}
mod.options = options
