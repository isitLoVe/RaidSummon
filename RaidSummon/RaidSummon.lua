RaidSummon = LibStub("AceAddon-3.0"):NewAddon("RaidSummon", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RaidSummon", true)

--set options
local options = {
    name = "RaidSummon",
    handler = RaidSummon,
    type = "group",
    args = {
        whisper = {
            type = "toggle",
            name = L["OptionWhisperName"],
            desc = L["OptionWhisperDesc"],
            get = "GetOptionWhisper",
            set = "SetOptionWhisper",
        },
        zone = {
            type = "toggle",
            name = L["OptionZoneName"],
            desc = L["OptionZoneDesc"],
            get = "GetOptionZone",
            set = "SetOptionZone",
        },
    },
}

--set default options
local defaults = {
	profile = {
		whisper = true,
		zone = true,
	}
}

function RaidSummon:OnEnable()
	self:Print(L["AddonEnabled"](GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")))
	self:RegisterEvent("CHAT_MSG_ADDON")
	self:RegisterEvent("CHAT_MSG_RAID", "msgParser")
	self:RegisterEvent("CHAT_MSG_RAID_LEADER", "msgParser")
	self:RegisterEvent("CHAT_MSG_SAY", "msgParser")
	self:RegisterEvent("CHAT_MSG_YELL", "msgParser")
	self:RegisterEvent("CHAT_MSG_WHISPER", "msgParser")
	
	--load header in RaidSummon Frame self:?
	RaidSummon_RequestFrameHeader = L["FrameHeader"](GetAddOnMetadata("RaidSummon", "Version"))
end

function RaidSummon:OnDisable()
	self:Print(L["AddonDisabled"])
	RaidSummonSyncDB = {}
end

function RaidSummon:OnInitialize()

	self.db = LibStub("AceDB-3.0"):New("RaidSummonOptionsDB", defaults, true)

	LibStub("AceConfig-3.0"):RegisterOptionsTable("RaidSummon", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RaidSummon", "RaidSummon")
	self:RegisterChatCommand("rs", "ChatCommand")
	self:RegisterChatCommand("raidsummon", "ChatCommand")

	print(string.format("RaidSummon version %s by %s", GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")))
	
	MSG_PREFIX_ADD	= "RSAdd"
	MSG_PREFIX_REMOVE	= "RSRemove"
	RaidSummonSyncDB = {}
	
end

--Handle CHAT_MSG Events here
function RaidSummon:msgParser(eventName,...)
	if eventName == "CHAT_MSG_SAY" or eventName == "CHAT_MSG_RAID" or eventName == "CHAT_MSG_RAID_LEADER" or eventName == "CHAT_MSG_YELL" or eventName == "CHAT_MSG_WHISPER" then
		local msg, authorrealm = ...
		local author, realm = strsplit("-", authorrealm, 2)
		if string.find(msg, "^123") or string.find(msg, "^summon") or string.find(msg, "^sum") or string.find(msg, "^port") then
			C_ChatInfo.SendAddonMessage(MSG_PREFIX_ADD, author, "RAID")
		end
	end
end

--handle MSG_ADDON here
function RaidSummon:CHAT_MSG_ADDON(eventName,...)
	if eventName == "CHAT_MSG_ADDON" then
		local prefix, text, channel, sender = ...
		if prefix == MSG_PREFIX_ADD then
			if not RaidSummon:hasValue(RaidSummonSyncDB, text) then
				table.insert(RaidSummonSyncDB, text)
				RaidSummon:UpdateList()
			end
		elseif prefix == MSG_PREFIX_REMOVE then
			if RaidSummon:hasValue(RaidSummonSyncDB, text) then
				for i, v in ipairs (RaidSummonSyncDB) do
					if v == text then
						table.remove(RaidSummonSyncDB, i)
						RaidSummon:UpdateList()
					end
				end
			end
		end
	end
end

--GUI
function RaidSummon:NameListButton_PreClick(self, button)

	local buttonname = self:GetName()
	local name = _G[buttonname.."TextName"]:GetText()
	local buttonName = GetMouseButtonClicked()
	local targetname, targetrealm = UnitName("target")

	RaidSummon:getRaidMembers()
	
	if RaidSummon_RaidMembersDB then
		for i, v in ipairs (RaidSummon_RaidMembersDB) do
			if v.rName == name then
				raidIndex = "raid"..v.rIndex
			end
		end

		if raidIndex then
			--set target when not in combat (securetemplate)
			if not InCombatLockdown() then
				if RaidSummon_RaidMembersDB then
					self:SetAttribute("type1", "target")
					self:SetAttribute("unit", raidIndex)
				end
				self:SetAttribute("type2", "spell")
				self:SetAttribute("spell", "698") --698 - Ritual of Summoning
			else
				print("RS Error - in combat")
			end
		end
	end

	if buttonName == "RightButton" and targetname ~= nil and not InCombatLockdown() then
		
		if RaidSummon_RaidMembersDB then
		
			if self.db.profile.zone and self.db.profile.whisper then
			
				if GetSubZoneText() == "" then
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText(), "RAID")
					SendChatMessage("RS - Summoning you to "..GetZoneText(), "WHISPER", nil, targetname)
				else
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText() .. " - " .. GetSubZoneText(), "RAID")
					SendChatMessage("RS - Summoning you to "..GetZoneText() .. " - " .. GetSubZoneText(), "WHISPER", nil, targetname)
				end
			elseif self.db.profile.zone and not self.db.profile.whisper then
				if GetSubZoneText() == "" then
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText(), "RAID")
				else
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText() .. " - " .. GetSubZoneText(), "RAID")
				end
			elseif not self.db.profile.zone and self.db.profile.whisper then
				SendChatMessage("RS - Summoning ".. targetname, "RAID")
				SendChatMessage("RS - Summoning you", "WHISPER", nil, targetname)
			elseif not self.db.profile.zone and not self.db.profile.whisper then
				SendChatMessage("RS - Summoning ".. targetname, "RAID")
			end
			for i, v in ipairs (RaidSummonSyncDB) do
				if v == targetname then
					C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, targetname, "RAID")
				end
			end
		else
			print("RaidSummon Error - no raid found")
		end
	elseif buttonName == "LeftButton" and IsControlKeyDown() then
		for i, v in ipairs (RaidSummonSyncDB) do
			if v == name then
				C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, name, "RAID")
			end
		end
	end
			
	RaidSummon:UpdateList()
end

function RaidSummon:UpdateList()

	local RaidSummon_BrowseDB = {}

	--only Update and show if Player is Warlock localization
	 if (UnitClass("player") == "Warlock") then

	 --classic fix
		if IsInRaid() then 
		
			--get raid member data
			RaidSummon:getRaidMembers()
			if RaidSummon_RaidMembersDB then

				for RaidMembersDBindex, RaidMembersDBvalue in ipairs (RaidSummon_RaidMembersDB) do

					--check raid data for RaidSummon data
					for RaidSummonSyncDBindex, RaidSummonSyncDBvalue in ipairs (RaidSummonSyncDB) do 
				
						--if player is found fill BrowseDB
						if RaidSummonSyncDBvalue == RaidMembersDBvalue.rName then
							RaidSummon_BrowseDB[RaidSummonSyncDBindex] = {}
							RaidSummon_BrowseDB[RaidSummonSyncDBindex].rIndex = RaidMembersDBindex
							RaidSummon_BrowseDB[RaidSummonSyncDBindex].rName = RaidMembersDBvalue.rName
							RaidSummon_BrowseDB[RaidSummonSyncDBindex].rClass = RaidMembersDBvalue.rClass
							RaidSummon_BrowseDB[RaidSummonSyncDBindex].rfileName = RaidMembersDBvalue.rfileName
							
							if RaidMembersDBvalue.rfileName == "WARLOCK" then
								RaidSummon_BrowseDB[RaidSummonSyncDBindex].rVIP = true
							else
								RaidSummon_BrowseDB[RaidSummonSyncDBindex].rVIP = false
							end
						end
					end
				end
			end

			--sort warlocks first
			table.sort(RaidSummon_BrowseDB, function(a,b) return tostring(a.rVIP) > tostring(b.rVIP) end)

		end
		
		for i=1,10 do
			if RaidSummon_BrowseDB[i] then
				_G["RaidSummon_NameList"..i.."TextName"]:SetText(RaidSummon_BrowseDB[i].rName)

				if RaidSummon_BrowseDB[i].rfileName == "DRUID" then
					local c = RaidSummon_GetClassColour("DRUID")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "HUNTER" then
					local c = RaidSummon_GetClassColour("HUNTER")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "MAGE" then
					local c = RaidSummon_GetClassColour("MAGE")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "PALADIN" then
					local c = RaidSummon_GetClassColour("PALADIN")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "PRIEST" then
					local c = RaidSummon_GetClassColour("PRIEST")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "ROGUE" then
					local c = RaidSummon_GetClassColour("ROGUE")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "SHAMAN" then
					local c = RaidSummon_GetClassColour("SHAMAN")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "WARLOCK" then
					local c = RaidSummon_GetClassColour("WARLOCK")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rfileName == "WARRIOR" then
					local c = RaidSummon_GetClassColour("WARRIOR")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				end				
				
				if not InCombatLockdown() then
					_G["RaidSummon_NameList"..i]:Show()
				else
					RaidSummon:UpdateListCombatCheck()
				end
			else
				if not InCombatLockdown() then
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

--Slash Handler
function RaidSummon_SlashCommand( msg )

	if msg == "help" then
		print("RaidSummon usage:")
		print("/rs or /raidsummon { help | show | zone | whisper }")
		print(" - |cff9482c9help|r: prints out this help")
		print(" - |cff9482c9show|r: shows the current summon list")
		print(" - |cff9482c9clear|r: clears the summon list")
		print(" - |cff9482c9zone|r: toggles zoneinfo in /ra and /w")
		print(" - |cff9482c9whisper|r: toggles the usage of /w")
		print("To drag the frame use shift + left mouse button")
	elseif msg == "show" then
		--show msg if list is empty
		if next(RaidSummonSyncDB) == nil then
			print("RaidSummon - list is empty")
		end		
		for i, v in ipairs(RaidSummonSyncDB) do
			print("RaidSummon - raid members that need a summon:")
			print(tostring(v))
		end
	elseif msg == "zone" then
		if RaidSummonOptions["zone"] == true then
			RaidSummonOptions["zone"] = false
			print("RaidSummon - zoneinfo: |cffff0000disabled|r")
		elseif RaidSummonOptions["zone"] == false then
			RaidSummonOptions["zone"] = true
			print("RaidSummon - zoneinfo: |cff00ff00enabled|r")
		end
	elseif msg == "whisper" then
		if RaidSummonOptions["whisper"] == true then
			RaidSummonOptions["whisper"] = false
			print("RaidSummon - whisper: |cffff0000disabled|r")
		elseif RaidSummonOptions["whisper"] == false then
			RaidSummonOptions["whisper"] = true
			print("RaidSummon - whisper: |cff00ff00enabled|r")
		end
	elseif msg == "clear" then
		RaidSummonSyncDB = {}
		RaidSummon:UpdateList()
	elseif msg == "test" then
		print(L["Language"])
	else
	
		if RaidSummon_RequestFrame:IsVisible() then
			RaidSummon_RequestFrame:Hide()
		else
			RaidSummon:UpdateList()
			ShowUIPanel(RaidSummon_RequestFrame, 1)
		end
	
	end
	
end

--returns class color
function RaidSummon_GetClassColour(class)
	if (class) then
		local color = RAID_CLASS_COLORS[class]
		if (color) then
			return color
		end
	end
	return {r = 0.5, g = 0.5, b = 1}
end

--collects raid member information to RaidSummon_RaidMembersDB
function RaidSummon:getRaidMembers()

	if IsInRaid() then 

		local members = GetNumGroupMembers()

		if (members > 0) then
		RaidSummon_RaidMembersDB = {}

		for i = 1, members do
			local rName, rRank, rSubgroup, rLevel, rClass, rfileName = GetRaidRosterInfo(i)

			RaidSummon_RaidMembersDB[i] = {}
			if (not rName) then
				print("RaidSummon Error - raid member with index "..i.." not found")
				rName = "unknown"..i
			end
			
			RaidSummon_RaidMembersDB[i].rIndex = i
			RaidSummon_RaidMembersDB[i].rName = rName
			RaidSummon_RaidMembersDB[i].rClass = rClass
			RaidSummon_RaidMembersDB[i].rfileName = rfileName
			
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
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("rs", "RaidSummon", input)
    end
end

--Get Option Functions
function RaidSummon:GetOptionWhisper(info)
	return self.db.profile.whisper
end

function RaidSummon:GetOptionZone(info)
	return self.db.profile.zone
end

--Set Option Functions
function RaidSummon:SetOptionWhisper(info, value)
	self.db.profile.whisper = value
end

function RaidSummon:SetOptionZone(info, value)
	self.db.profile.zone = value
end
