RaidSummon = LibStub("AceAddon-3.0"):NewAddon("RaidSummon", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0", "AceComm-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RaidSummon", true)

--set options
local options = {
	name = "RaidSummon",
	handler = RaidSummon,
	type = "group",
	args = {
		options = {
			type = "group",
			name = L["OptionGroupOptionsName"],
			order = 10,
			inline = true,
			args = {
				whisperOptions = {
					type = "group",
					name = L["OptionGroupWhisperName"],
					order = 11,
					inline = true,
					args = {
						whisper = {
							type = "toggle",
							name = L["OptionWhisperName"],
							desc = L["OptionWhisperDesc"],
							get = "GetOptionWhisper",
							set = "SetOptionWhisper",
							order = 111,
							width = "full"
						},	
						whisperText = {
							type = "input",
							name = L["OptionWhisperTextName"],
							desc = L["OptionWhisperTextDesc"],
							get = "GetOptionWhisperText",
							set = "SetOptionWhisperText",
							multiline = false,
							order = 112,
							width = "full"
						}
					}
				},
				raidOptions = {
					type = "group",
					name = L["OptionGroupRaidName"],
					order = 12,
					inline = true,
					args = {
						raid = {
							type = "toggle",
							name = L["OptionRaidName"],
							desc = L["OptionRaidDesc"],
							get = "GetOptionRaid",
							set = "SetOptionRaid",
							order = 121,
							width = "full"
						},
						raidText = {
							type = "input",
							name = L["OptionRaidTextName"],
							desc = L["OptionRaidTextDesc"],
							get = "GetOptionRaidText",
							set = "SetOptionRaidText",
							multiline = false,
							order = 122,
							width = "full"
						}
					}
				},
				sayOptions = {
					type = "group",
					name = L["OptionGroupSayName"],
					order = 13,
					inline = true,
					args = {
						say = {
							type = "toggle",
							name = L["OptionSayName"],
							desc = L["OptionSayDesc"],
							get = "GetOptionSay",
							set = "SetOptionSay",
							order = 131,
							width = "full"
						},
						sayText = {
							type = "input",
							name = L["OptionSayTextName"],
							desc = L["OptionSayTextDesc"],
							get = "GetOptionSayText",
							set = "SetOptionSayText",
							multiline = false,
							order = 132,
							width = "full"
						}
					}
				},
				tidBitOptions = {
					type = "group",
					name = L["OptionGroupTidbitsName"],
					order = 14,
					inline = true,
					args = {
						tbdesc = {
							type = "description",
							name = L["OptionTidbitsDescription"],
							order = 141,
						},
						tbadd = {
							type = "input",
							name = L["OptionTidbitsAddName"],
							desc = L["OptionTidbitsAddDesc"],
							set = "SetTidbitsAdd",
							multiline = false,
							order = 142,
							width = "full"
						},
						tbremove = {
							type = "input",
							name = L["OptionTidbitsRemoveName"],
							desc = L["OptionTidbitsRemoveDesc"],
							set = "SetTidbitsRemove",
							order = 143,
							guiHidden = true,
						},
						tbremovesel = {
							type = "select",
							name = L["OptionTidbitsRemoveName"],
							desc = L["OptionTidbitsRemoveDesc"],
							values = "ValuesRandomTidbitSel",
							style = "dropdown",
							set = "SetTidbitsRemoveSel",
							order = 144,
							width = "full"
						}
					}
				},
				zone = {
					type = "toggle",
					name = L["OptionZoneName"],
					desc = L["OptionZoneDesc"],
					get = "GetOptionZone",
					set = "SetOptionZone",
					order = 15,
				},
				flashwindow = {
					type = "toggle",
					name = L["OptionFlashwindowName"],
					desc = L["OptionFlashwindowDesc"],
					get = "GetOptionFlashwindow",
					set = "SetOptionFlashwindow",
					order = 16,
				}
			}
		},
		commands = {
			type = "group",
			name = L["OptionGroupCommandsName"],
			order = 30,
			inline = true,
			args = {
				toggle = {
					type = "execute",
					name = L["OptionToggleName"],
					desc = L["OptionToggleDesc"],
					func = "ExecuteToggle",
					order = 31,
				},
				list = {
					type = "execute",
					name = L["OptionListName"],
					desc = L["OptionListDesc"],
					func = "ExecuteList",
					order = 32,
				},
				clear = {
					type = "execute",
					name = L["OptionClearName"],
					desc = L["OptionClearDesc"],
					func = "ExecuteClear",
					order = 33,
				},
				addall = {
					type = "execute",
					name = L["OptionAddAllName"],
					desc = L["OptionAddAllDesc"],
					func = "ExecuteAddAll",
					order = 34,
				},
				add = {
					type = "input",
					name = L["OptionAddName"],
					desc = L["OptionAddDesc"],
					set = "SetOptionAdd",
					multiline = false,
					order = 35,
				},
				remove = {
					type = "input",
					name = L["OptionRemoveName"],
					desc = L["OptionRemoveDesc"],
					set = "SetOptionRemove",
					multiline = false,
					guiHidden = true,
					order = 36,
				},
				removesel = {
					type = "select",
					name = L["OptionRemoveName"],
					desc = L["OptionRemoveDesc"],
					set = "SetOptionRemove",
					values = "ValuesRemoveSel",
					style = "dropdown",
					order = 37,
				}
			}
		},
		keywords = {
			type = "group",
			name = L["OptionGroupKeywordsName"],
			order = 40,
			inline = true,
			args = {
				kwdescription = {
					type = "description",
					name = L["OptionKWDescription"],
					order = 41,
				},
				kwlist = {
					type = "execute",
					name = L["OptionKWListName"],
					desc = L["OptionKWListDesc"],
					func = "ExecuteKWList",
					order = 42,
				},
				kwadd = {
					type = "input",
					name = L["OptionKWAddName"],
					desc = L["OptionKWAddDesc"],
					set = "SetKWAdd",
					multiline = false,
					order = 43,
				},
				kwremove = {
					type = "input",
					name = L["OptionKWRemoveName"],
					desc = L["OptionKWRemoveDesc"],
					set = "SetKWRemove",
					order = 44,
					guiHidden = true,
				},
				kwremovesel = {
					type = "select",
					name = L["OptionKWRemoveName"],
					desc = L["OptionKWRemoveDesc"],
					values = "ValuesKWRemoveSel",
					style = "dropdown",
					set = "SetKWRemoveSel",
					order = 45,
				}
			}
		},
		help = {
			type = "execute",
			name = L["OptionHelpName"],
			desc = L["OptionHelpDesc"],
			func = "ExecuteHelp",
			guiHidden = true,
		},
		config = {
			type = "execute",
			name = L["OptionConfigName"],
			desc = L["OptionConfigDesc"],
			func = "ExecuteConfig",
			guiHidden = true,
		}
	}
}

--set default options
local defaults = {
	profile = {
		whisper = true,
		whisperText = nil,
		raid = true,
		raidText = nil,
		say = false,
		sayText = nil,
		zone = true,
		flashwindow = true,
		keywordsinit = false,
		tidbitsinit = false
	}
}

function RaidSummon:OnEnable()
	self:Print(L["AddonEnabled"](GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")))
	self:RegisterEvent("GROUP_JOINED", "GroupEvent")
	self:RegisterEvent("GROUP_LEFT", "GroupEvent")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")
	self:RegisterEvent("CHAT_MSG_RAID", "msgParser")
	self:RegisterEvent("CHAT_MSG_PARTY", "msgParser")
	self:RegisterEvent("CHAT_MSG_RAID_LEADER", "msgParser")
	self:RegisterEvent("CHAT_MSG_SAY", "msgParser")
	self:RegisterEvent("CHAT_MSG_YELL", "msgParser")
	self:RegisterEvent("CHAT_MSG_WHISPER", "msgParser")

	--Right Click Hook
	local className, classFilename, classID = UnitClass("player")
	if classFilename == "WARLOCK" then
		self:SecureHook("UnitPopup_ShowMenu")
	end

end

function RaidSummon:OnDisable()
	self:Print(L["AddonDisabled"])
	RaidSummonSyncDB = {}
end

function RaidSummon:OnInitialize()

	self.db = LibStub("AceDB-3.0"):New("RaidSummonOptionsDB", defaults, true)
	self.db.RegisterCallback(self, "OnNewProfile", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

	--frame needed to open it via /rs config
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(L["RaidSummon"], options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["RaidSummon"], L["RaidSummon"])

	--Commands
	--LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("RaidSummonCommands", options.args.commands)
	--LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RaidSummonCommands", options.args.commands.name, "RaidSummon")

	--Profile
	local optionsProfile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(L["RaidSummon"] .. "-Profiles", optionsProfile)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["RaidSummon"]  .."-Profiles", "Profiles", "RaidSummon")

	self:RegisterChatCommand("rs", "ChatCommand")
	self:RegisterChatCommand("raidsummon", "ChatCommand")

	--load version in RaidSummon Frame
	RaidSummon_RequestFrameHeader:SetText(L["FrameHeader"](GetAddOnMetadata("RaidSummon", "Version")))

	MSG_PREFIX_ADD = "RSAdd"
	MSG_PREFIX_ADD_MANUAL = "RSAddManual"
	MSG_PREFIX_REMOVE = "RSRemove"
	MSG_PREFIX_REMOVE_MANUAL = "RSRemoveManual"
	RaidSummonSyncDB = {}

	--Ace3 Comm Channels max 16 chars
	COMM_PREFIX_ADD = "RSADD"
	COMM_PREFIX_ADD_MANUAL = "RSADDM"
	COMM_PREFIX_REMOVE = "RSRM"
	COMM_PREFIX_REMOVE_MANUAL = "RSRMM"
	COMM_PREFIX_ADD_ALL = "RSADDALL"

	--Ace3 Comm Registers
	self:RegisterComm(COMM_PREFIX_ADD) --add via 123 etc
	self:RegisterComm(COMM_PREFIX_ADD_MANUAL) --add via /rs add
	self:RegisterComm(COMM_PREFIX_REMOVE) --remove via summoning / right click
	self:RegisterComm(COMM_PREFIX_REMOVE_MANUAL) --remove via ctrl + click
	self:RegisterComm(COMM_PREFIX_ADD_ALL) --via AddAll function

	--check if keywords have been initialized
	if (not self.db.profile.keywordsinit) then
		self.db.profile.keywords = { "^123$", "^sum", "^port" }
		self.db.profile.keywordsinit = true
	end

	--check if tidbits have been initialized
	if (not self.db.profile.tidbitsinit) then
		self.db.profile.tidbits = {L["slightPinch"], L["notLiable"]}
		self.db.profile.tidbitsinit = true
	end
end

--Handle CHAT_MSG Events here
function RaidSummon:msgParser(eventName,...)
	if eventName == "CHAT_MSG_SAY" or eventName == "CHAT_MSG_RAID" or eventName == "CHAT_MSG_PARTY" or eventName == "CHAT_MSG_RAID_LEADER" or eventName == "CHAT_MSG_YELL" or eventName == "CHAT_MSG_WHISPER" then
		local text, playerName, languageName, channelName, playerName2   = ...

		for i, v in ipairs(self.db.profile.keywords) do
			if string.find(text, v) then
				RaidSummon:SendCommMessage(COMM_PREFIX_ADD, playerName2, "RAID")
			end
		end
	end
end

--Clear the sync db and update the frame when joining or leaving a group/raid
function RaidSummon:GroupEvent(eventName,...)
	RaidSummonSyncDB = {}
	RaidSummon:UpdateList()
end

--Hanlde raid changes and index changes
function RaidSummon:GROUP_ROSTER_UPDATE(eventName,...)
	RaidSummon:getRaidMembers()
	if RaidSummonRaidMembersDB and RaidSummonSyncDB then
		for RaidSummonSyncDBi, RaidSummonSyncDBv in ipairs (RaidSummonSyncDB) do
			if not RaidSummon:hasValueSub(RaidSummonRaidMembersDB, RaidSummonSyncDBv, "rName") then
				table.remove(RaidSummonSyncDB, RaidSummonSyncDBi)
			end
		end
	end
	RaidSummon:UpdateList()
end

--Ace3 Comm
function RaidSummon:OnCommReceived(prefix, message, distribution, sender)
	if (prefix) then
		if prefix == COMM_PREFIX_ADD then
			--print("COMM_PREFIX_ADD "..message)
			--only add player once
			if not RaidSummon:hasValue(RaidSummonSyncDB, message) then
				--check if player is in the raid
				RaidSummon:getRaidMembers()
				if RaidSummonRaidMembersDB then
					for RaidMembersDBindex, RaidMembersDBvalue in ipairs (RaidSummonRaidMembersDB) do
						if message == RaidMembersDBvalue.rName then
							table.insert(RaidSummonSyncDB, message)
							RaidSummon:UpdateList()
							if self.db.profile.flashwindow then
								FlashClientIcon()
							end
						end
					end
				end
			end
		elseif prefix == COMM_PREFIX_ADD_MANUAL then
			--print("COMM_PREFIX_ADD_MANUAL "..message)
			--only add player once
			if not RaidSummon:hasValue(RaidSummonSyncDB, message) then
				--check if player is in the raid
				RaidSummon:getRaidMembers()
				if RaidSummonRaidMembersDB then
					for RaidMembersDBindex, RaidMembersDBvalue in ipairs (RaidSummonRaidMembersDB) do
						if message == RaidMembersDBvalue.rName then
							table.insert(RaidSummonSyncDB, message)
							print(L["MemberAdded"](message,sender))
							RaidSummon:UpdateList()
							if self.db.profile.flashwindow then
								FlashClientIcon()
							end
						end
					end
				end
			end
		elseif prefix == COMM_PREFIX_REMOVE then
			--print("COMM_PREFIX_REMOVE "..message)
			if RaidSummon:hasValue(RaidSummonSyncDB, message) then
				for i, v in ipairs (RaidSummonSyncDB) do
					if v == message then
						table.remove(RaidSummonSyncDB, i)
						RaidSummon:UpdateList()
					end
				end
			end
		elseif prefix == COMM_PREFIX_REMOVE_MANUAL then
			--print("COMM_PREFIX_REMOVE_MANUAL "..message)
			if RaidSummon:hasValue(RaidSummonSyncDB, message) then
				for i, v in ipairs (RaidSummonSyncDB) do
					if v == message then
						table.remove(RaidSummonSyncDB, i)
						print(L["MemberRemoved"](message,sender))
						RaidSummon:UpdateList()
					end
				end
			end
		elseif prefix == COMM_PREFIX_ADD_ALL then
			--print("COMM_PREFIX_ADD_ALL "..message)
			if IsInRaid() then
				local members = GetNumGroupMembers()
				if (members > 0) then

				if GetZoneText() == "" then
					zonetext = nil
				else
					zonetext = GetZoneText()
				end

					for i = 1, members do
						local rName, rRank, rSubgroup, rLevel, rClass, rfileName, rZone = GetRaidRosterInfo(i)

						--only add the player if not in the current zone
						if rName and zonetext ~= rZone then
							if not RaidSummon:hasValue(RaidSummonSyncDB, rName) then
								--check if player is in the raid
								RaidSummon:getRaidMembers()
								if RaidSummonRaidMembersDB then
									for RaidMembersDBindex, RaidMembersDBvalue in ipairs (RaidSummonRaidMembersDB) do
										if rName == RaidMembersDBvalue.rName then
											table.insert(RaidSummonSyncDB, rName)
										end
									end
								end
							end
						end
					end
					RaidSummon:UpdateList()
					print(L["AddAllMessage"])
				end
			end
		end
	end
end

--GUI
function RaidSummon:NameListButton_PreClick(source, button)

	local buttonname = source:GetName()
	local name = _G[buttonname.."TextName"]:GetText()
	local buttonName = GetMouseButtonClicked()
	local targetname, targetrealm = UnitName("target")
	local rText = nil
	local wText = nil
	local sText = nil
	local randomIndex = 1
	local randomTidbit = ""

	RaidSummon:getRaidMembers()

	if RaidSummonRaidMembersDB then
		for i, v in ipairs (RaidSummonRaidMembersDB) do
			if v.rName == name then
				raidIndex = "raid"..v.rIndex
			end
		end

		if raidIndex then
			--set target when not in combat (securetemplate)
			if not InCombatLockdown() then
				if RaidSummonRaidMembersDB then
					source:SetAttribute("type1", "target")
					source:SetAttribute("unit", raidIndex)
				end
				source:SetAttribute("type2", "spell")
				source:SetAttribute("spell", "698") --698 - Ritual of Summoning
			else
				print(L["Lockdown"])
			end
		end
	end

	if buttonName == "RightButton" and targetname ~= nil and not InCombatLockdown() then

		if RaidSummonRaidMembersDB then

			--Summoning does only work when the player has a target
			--check if the clicked name is the current target
			if targetname ~= name then
				print(L["TargetMissmatch"](targetname, name))
				return
			end

			if GetZoneText() == "" then
				zonetext = nil
			else
				if self.db.profile.zone then
					zonetext = GetZoneText()
				else
					zonetext = nil
				end
			end

			if GetSubZoneText() == "" then
				subzonetext = nil
			else
				if self.db.profile.zone then
					subzonetext = GetSubZoneText()
				else
					subzonetext = nil
				end
			end

			if not (next(self.db.profile.tidbits) == nil) then
				math.randomseed(os.time())
				randomIndex = math.random(1, RaidSummon:getTableLength(self.db.profile.tidbits))
				randomTidbit = self.db.profile.tidbits[randomIndex]
			end

			if self.db.profile.raidText then
				rText = self.db.profile.raidText
				rText = rText:gsub(":t", targetname)
				if zonetext and subzonetext then
					rText = rText:gsub(":z", zonetext .. " - " .. subzonetext)
				elseif zonetext then
					rText = rText:gsub(":z", zonetext)
				else
					rText = rText:gsub(":z", L("locationUnknown"))
				end
				rText = rText:gsub(":r", randomTidbit)
			else
				rText = nil
			end

			if self.db.profile.whisperText then
				wText = self.db.profile.whisperText
				wText = wText:gsub(":t", L["you"])
				if zonetext and subzonetext then
					wText = wText:gsub(":z", zonetext .. " - " .. subzonetext)
				elseif zonetext then
					wText = wText:gsub(":z", zonetext)
				else
					wText = wText:gsub(":z", L("locationUnknown"))
				end
				wText = wText:gsub(":r", randomTidbit)
			else
				wText = nil
			end

			if self.db.profile.sayText then
				math.randomseed(os.time())
				sText = self.db.profile.sayText
				sText = sText:gsub(":t", targetname)
				if zonetext and subzonetext then
					sText = sText:gsub(":z", zonetext .. " - " .. subzonetext)
				elseif zonetext then
					sText = sText:gsub(":z", zonetext)
				else
					sText = sText:gsub(":z", L("locationUnknown"))
				end
				sText = sText:gsub(":r", randomTidbit)
			else
				sText = nil
			end


			if self.db.profile.raid then
				if not rText then
					SendChatMessage(L["SummonAnnounceR"](targetname, zonetext, subzonetext), "RAID")
				else
					SendChatMessage(rText, "RAID")
				end
			end
			if self.db.profile.whisper then
				if not wText then
					SendChatMessage(L["SummonAnnounceW"](zonetext, subzonetext), "WHISPER", nil, targetname)
				else
					SendChatMessage(wText, "WHISPER", nil, targetname)
				end
			end
			if self.db.profile.say then
				if not sText then
					SendChatMessage(L["SummonAnnounceS"](targetname, zonetext, subzonetext), "SAY")
				else
					SendChatMessage(sText, "SAY")
				end
			end

			for i, v in ipairs (RaidSummonSyncDB) do
				if v == targetname then
					RaidSummon:SendCommMessage(COMM_PREFIX_REMOVE, targetname, "RAID")
				end
			end
		else
			print(L["noRaid"])
		end
	elseif buttonName == "LeftButton" and IsControlKeyDown() then
		for i, v in ipairs (RaidSummonSyncDB) do
			if v == name then
				RaidSummon:SendCommMessage(COMM_PREFIX_REMOVE_MANUAL, name, "RAID")
			end
		end
	end

	RaidSummon:UpdateList()
end

function RaidSummon:UpdateList()

	local RaidSummonBrowseDB = {}

	--only Update and show if Player is Warlock
	local className, classFilename, classID = UnitClass("player")
	if classFilename == "WARLOCK" then

		if IsInRaid() then

			--get raid member data
			RaidSummon:getRaidMembers()
			if RaidSummonRaidMembersDB then

				for RaidMembersDBindex, RaidMembersDBvalue in ipairs (RaidSummonRaidMembersDB) do

					--check raid data for RaidSummon data
					for RaidSummonSyncDBindex, RaidSummonSyncDBvalue in ipairs (RaidSummonSyncDB) do

						--if player is found fill BrowseDB
						if RaidSummonSyncDBvalue == RaidMembersDBvalue.rName then
							RaidSummonBrowseDB[RaidSummonSyncDBindex] = {}
							RaidSummonBrowseDB[RaidSummonSyncDBindex].rIndex = RaidMembersDBindex
							RaidSummonBrowseDB[RaidSummonSyncDBindex].rName = RaidMembersDBvalue.rName
							RaidSummonBrowseDB[RaidSummonSyncDBindex].rClass = RaidMembersDBvalue.rClass
							RaidSummonBrowseDB[RaidSummonSyncDBindex].rfileName = RaidMembersDBvalue.rfileName

							if RaidMembersDBvalue.rfileName == "WARLOCK" then
								RaidSummonBrowseDB[RaidSummonSyncDBindex].rVIP = true
							else
								RaidSummonBrowseDB[RaidSummonSyncDBindex].rVIP = false
							end
						end
					end
				end
			end

			--sort warlocks first
			table.sort(RaidSummonBrowseDB, function(a,b) return tostring(a.rVIP) > tostring(b.rVIP) end)

		end

		for i=1,10 do
			if RaidSummonBrowseDB[i] then
				_G["RaidSummon_NameList"..i.."TextName"]:SetText(RaidSummonBrowseDB[i].rName)

				--Shamans are pink (like paladins) in Classic, we need to fix that, thanks to Molimo-Lucifron for testing
				if RaidSummonBrowseDB[i].rfileName == "SHAMAN" then
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(0.00, 0.44, 0.87, 1)
				else
					local r,g,b,img = GetClassColor(RaidSummonBrowseDB[i].rfileName)
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(r, g, b, 1)
				end

				if not InCombatLockdown() then
					_G["RaidSummon_NameList"..i]:Show()
				else
					RaidSummon:UpdateListCombatCheck()
				end
			else
				if not InCombatLockdown() then
					_G["RaidSummon_NameList"..i.."TextName"]:SetText("")
					_G["RaidSummon_NameList"..i]:Hide()
				else
					RaidSummon:UpdateListCombatCheck()
				end
			end
		end

		if not InCombatLockdown() then

			if not RaidSummonSyncDB[1] then
				if RaidSummon_RequestFrame:IsVisible() then
					RaidSummon_RequestFrame:Hide()
				end
			else
				ShowUIPanel(RaidSummon_RequestFrame, 1)
			end
		else
			RaidSummon:UpdateListCombatCheck()
		end
	end
end

--collects raid member information to RaidSummonRaidMembersDB
function RaidSummon:getRaidMembers()

	if IsInRaid() then

		local members = GetNumGroupMembers()

		if (members > 0) then
		RaidSummonRaidMembersDB = {}

			for i = 1, members do
				local rName, rRank, rSubgroup, rLevel, rClass, rfileName = GetRaidRosterInfo(i)

				if rName and rClass and rfileName then
					RaidSummonRaidMembersDB[i] = {}
					RaidSummonRaidMembersDB[i].rIndex = i
					RaidSummonRaidMembersDB[i].rName = rName
					RaidSummonRaidMembersDB[i].rClass = rClass
					RaidSummonRaidMembersDB[i].rfileName = rfileName
				end
			end
		end
	end
end

--checks for a value in a table
function RaidSummon:hasValue (tab, val)
	for i, v in ipairs (tab) do
		if v == val then
			return true
		end
	end
	return false
end

--checks for a key in a table with key names and values
function RaidSummon:hasKey (tab, val)
	for k, v in pairs (tab) do
		if k == val then
			return true
		end
	end
	return false
end

--checks for a vlaue in a table with subtables
function RaidSummon:hasValueSub (tab, val)
	for i, v in ipairs (tab) do
		if v.rName == val then
			return true
		end
	end
	return false
end

--finds the index of a value
function RaidSummon:getIndexbyValue (tab, val)
	for i,v in ipairs(tab) do
		if v == val then
			return i
		end
	end
	return nil
end

--finds the number of entries in a table
function RaidSummon:getTableLength (tab)
	local count = 0
	for _ in pairs(tab) do count =  count + 1 end
	return count
end

--checks for combat every 10 seconds and calls RaidSummon:UpdateList
function RaidSummon:UpdateListCombatCheck()
	if InCombatLockdown() then
		--button and frame did not hide while in combat, try again in 10 seconds
		self:ScheduleTimer("UpdateListCombatCheck",10)
		return
	else
		RaidSummon:UpdateList()
	end
end

function RaidSummon:ChatCommand(input)
	if not input or input:trim() == "" then
		self:ExecuteHelp()
	else
		LibStub("AceConfigCmd-3.0"):HandleCommand("rs", "RaidSummon", input)
	end
end

--Option Functions
function RaidSummon:GetOptionWhisper(info)
	return self.db.profile.whisper
end

function RaidSummon:GetOptionWhisperText(info)
	return self.db.profile.whisperText
end

function RaidSummon:GetOptionRaid(info)
	return self.db.profile.raid
end

function RaidSummon:GetOptionRaidText(info)
	return self.db.profile.raidText
end

function RaidSummon:GetOptionSay(info)
	return self.db.profile.say
end

function RaidSummon:GetOptionSayText(info)
	return self.db.profile.sayText
end

function RaidSummon:GetOptionZone(info)
	return self.db.profile.zone
end

function RaidSummon:GetOptionFlashwindow(info)
	return self.db.profile.flashwindow
end

function RaidSummon:SetOptionWhisper(info, value)
	self.db.profile.whisper = value
	if value == true then
		print(L["OptionWhisperEnabled"])
	else
		print(L["OptionWhisperDisabled"])
	end
end

function RaidSummon:SetOptionWhisperText(info, input)
	if (input) then
		self.db.profile.whisperText = input
	else
		self.db.profile.whisperText = nil
	end
end

function RaidSummon:SetOptionRaid(info, value)
	self.db.profile.raid = value
	if value == true then
		print(L["OptionRaidEnabled"])
	else
		print(L["OptionRaidDisabled"])
	end
end

function RaidSummon:SetOptionRaidText(info, input)
	if (input) then
		self.db.profile.raidText = input
	else
		self.db.profile.raidText = nil
	end
end

function RaidSummon:SetOptionSay(info, value)
	self.db.profile.say = value
	if value == true then
		print(L["OptionSayEnabled"])
	else
		print(L["OptionSayDisabled"])
	end
end

function RaidSummon:SetOptionSayText(info, input)
	if (input) then
		self.db.profile.sayText = input
	else
		self.db.profile.sayText = nil
	end
end

function RaidSummon:ValuesRandomTidbitSel(info)
	local tidBitList = {}
	if self.db.profile.tidbits then
		if next(self.db.profile.tidbits) == nil then
			return tidBitList
		else
			for i, v in ipairs(self.db.profile.tidbits) do
				table.insert(tidBitList,v)
			end
			return tidBitList
		end
	end
end

function RaidSummon:SetTidbitsAdd(info, input)
	if (input) then
		if not (RaidSummon:hasValue(self.db.profile.tidbits, input)) then
			table.insert(self.db.profile.tidbits,input)
		end
	end
end

function RaidSummon:SetTidbitsRemove(info, input)
	if (input) then
		if (RaidSummon:hasValue(self.db.profile.tidbits, input)) then
			local index = RaidSummon:getIndexbyValue(self.db.profile.tidbits, input)
			table.remove(self.db.profile.tidbits, index)
		end
	end
end

function RaidSummon:SetTidbitsRemoveSel(info, input)
	--input is the index of a the profile keywords table
	if (input) then
		if not self.db.profile.tidbits then
			return
		else
			table.remove(self.db.profile.tidbits, input)
		end
	end
end

function RaidSummon:SetOptionZone(info, value)
	self.db.profile.zone = value
	if value == true then
		print(L["OptionZoneEnabled"])
	else
		print(L["OptionZoneDisabled"])
	end
end

function RaidSummon:SetOptionFlashwindow(info, value)
	self.db.profile.flashwindow = value
	if value == true then
		print(L["OptionFlashwindowEnabled"])
	else
		print(L["OptionFlashwindowDisabled"])
	end
end

function RaidSummon:ExecuteHelp()
	print(L["OptionHelpPrint"])
end

function RaidSummon:ExecuteConfig()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) --BlizzBugSucks
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

function RaidSummon:ExecuteList()
	--show msg if list is empty
	if next(RaidSummonSyncDB) == nil then
		print(L["OptionListEmpty"])
	else
		for i, v in ipairs(RaidSummonSyncDB) do
			print(L["OptionList"])
			print(tostring(v))
		end
	end
end

function RaidSummon:ExecuteClear()
	RaidSummonSyncDB = {}
	RaidSummon:UpdateList()
	print(L["OptionClear"])
end

function RaidSummon:ExecuteToggle()
	if not InCombatLockdown() then
		if RaidSummon_RequestFrame:IsVisible() then
			RaidSummon_RequestFrame:Hide()
		else
			RaidSummon:UpdateList()
			ShowUIPanel(RaidSummon_RequestFrame, 1)
		end
	else
		print(L["Lockdown"])
	end
end

--Add / Remove Options Functions
function RaidSummon:SetOptionAdd(info, input)
	if (input) then
		RaidSummon:SendCommMessage(COMM_PREFIX_ADD_MANUAL, input, "RAID")
	end
end

function RaidSummon:SetOptionRemove(info, input)
	if (input) then
		RaidSummon:SendCommMessage(COMM_PREFIX_REMOVE_MANUAL, input, "RAID")
	end
end

function RaidSummon:ValuesRemoveSel(info)
	local playerlist = {}
	if RaidSummonSyncDB then
		if next(RaidSummonSyncDB) == nil then
			return playerlist
		else
			for i, v in ipairs(RaidSummonSyncDB) do
				playerlist[v] = v
			end
			return playerlist
		end
	end
end

function RaidSummon:ExecuteAddAll()
	RaidSummon:SendCommMessage(COMM_PREFIX_ADD_ALL, COMM_PREFIX_ADD_ALL, "RAID")
end

--Keyword Options Functions
function RaidSummon:ExecuteKWList()
	if next(self.db.profile.keywords) == nil then
		print(L["OptionListEmpty"])
	else
		print(L["OptionKWList"])
		for i, v in ipairs(self.db.profile.keywords) do
			print(v)
		end
	end
end

function RaidSummon:SetKWAdd(info, input)
	if (input) then
		if (RaidSummon:hasValue(self.db.profile.keywords, input)) then
			print(L["OptionKWAddDuplicate"](input))
		else
			print(L["OptionKWAddAdded"](input))
			table.insert(self.db.profile.keywords,input)
		end
	end
end

function RaidSummon:SetKWRemove(info, input)
	if (input) then
		if (RaidSummon:hasValue(self.db.profile.keywords, input)) then
			print(L["OptionKWRemoveRemoved"](input))
			local index = RaidSummon:getIndexbyValue(self.db.profile.keywords, input)
			table.remove(self.db.profile.keywords, index)
		else
			print(L["OptionKWRemoveNF"](input))
		end
	end
end

function RaidSummon:ValuesKWRemoveSel(info)
	local kwlist = {}
	if self.db.profile.keywords then
		if next(self.db.profile.keywords) == nil then
			return kwlist
		else
			for i, v in ipairs(self.db.profile.keywords) do
				table.insert(kwlist,v)
			end
			return kwlist
		end
	end
end

function RaidSummon:SetKWRemoveSel(info, input)
	--input is the index of a the profile keywords table
	if (input) then
		if not self.db.profile.keywords then
			return
		else
			print(L["OptionKWRemoveRemoved"](self.db.profile.keywords[input]))
			table.remove(self.db.profile.keywords, input)
		end
	end
end


--fill the frame with dummy data for testing
--/script RaidSummon:DummyFill()
function RaidSummon:DummyFill()
	ShowUIPanel(RaidSummon_RequestFrame, 1)

	local RaidSummonDummy = {
		{
			name = "Nyx",
			class = "WARLOCK"
		},
		{
			name = "Zeus",
			class = "SHAMAN"
		},
		{
			name = "Eros",
			class = "PALADIN"
		},
		{
			name = "Hera",
			class = "MAGE"
		},
		{
			name = "Artemis",
			class = "HUNTER"
		},
		{
			name = "Athene",
			class = "PALADIN"
		},
		{
			name = "Demeter",
			class = "DRUID"
		},
		{
			name = "Aphrodite",
			class = "PRIEST"
		},
		{
			name = "Ares",
			class = "ROGUE"
		},
		{
			name = "Kronos",
			class = "WARRIOR"
		},
	}


	for i, v in ipairs(RaidSummonDummy) do
		if v.class == "SHAMAN" then
			r,g,b,img = 0.00, 0.44, 0.87, 1
		else
			r,g,b,img = GetClassColor(v.class)
		end
		_G["RaidSummon_NameList" .. i .. "TextName"]:SetText(v.name)
		_G["RaidSummon_NameList" .. i .. "TextName"]:SetTextColor(r, g, b, 1)
		_G["RaidSummon_NameList".. i]:Show()
	end
end

--Hook Functions
function RaidSummon:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
		return
	end

	--which from BlizzUI UnitPopup.lua UnitPopupMenus
	if (which == "SELF" or which == "PARTY" or which == "RAID_PLAYER") then

		--Seperator
		UIDropDownMenu_AddSeparator(UIDROPDOWNMENU_MENU_LEVEL)

		--Title
		local infotitle = UIDropDownMenu_CreateInfo()
		infotitle.text = L["RaidSummon"]
		infotitle.notCheckable = true
		infotitle.isTitle = true
		UIDropDownMenu_AddButton(infotitle)

		--AddButton
		local addbutton = UIDropDownMenu_CreateInfo()
		addbutton.text = L["OptionAddName"]
		addbutton.owner = which
		addbutton.notCheckable = true
		addbutton.func = RaidSummon.RightClick
		addbutton.colorCode = "|cff9482c9"
		addbutton.value = "RaidSummonAddButton"

		UIDropDownMenu_AddButton(addbutton)

		--RemoveButton
		local removebutton = UIDropDownMenu_CreateInfo()
		removebutton.text = L["OptionRemoveName"]
		removebutton.owner = which
		removebutton.notCheckable = true
		removebutton.func = RaidSummon.RightClick
		removebutton.colorCode = "|cff9482c9"
		removebutton.value = "RaidSummonRemoveButton"

		UIDropDownMenu_AddButton(removebutton)
	end
end

function RaidSummon:RightClick()
	if self.value == "RaidSummonAddButton" then
		local dropdownMenu = _G["UIDROPDOWNMENU_INIT_MENU"]
		if (dropdownMenu.name ~= "") then
			RaidSummon:SetOptionAdd(_, dropdownMenu.name)
		end
	elseif self.value == "RaidSummonRemoveButton" then
		local dropdownMenu = _G["UIDROPDOWNMENU_INIT_MENU"]
		if (dropdownMenu.name ~= "") then
			RaidSummon:SetOptionRemove(_, dropdownMenu.name)
		end
	end
end

function RaidSummon:RefreshConfig()
	if (not self.db.profile.keywordsinit) then
		self.db.profile.keywords = { "^123$", "^sum", "^port" }
		self.db.profile.keywordsinit = true
	end
end
