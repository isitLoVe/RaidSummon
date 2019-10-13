RaidSummon = LibStub("AceAddon-3.0"):NewAddon("RaidSummon", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RaidSummon", true)

--set options
local options = {
    name = "RaidSummon",
    handler = RaidSummon,
    type = "group",
    args = {
        headeroptions = {
            type = "header",
            name = L["OptionHeaderOptionsName"],
			order = 1,
        },
        whisper = {
            type = "toggle",
            name = L["OptionWhisperName"],
            desc = L["OptionWhisperDesc"],
            get = "GetOptionWhisper",
            set = "SetOptionWhisper",
			order = 2,
        },
        zone = {
            type = "toggle",
            name = L["OptionZoneName"],
            desc = L["OptionZoneDesc"],
            get = "GetOptionZone",
            set = "SetOptionZone",
			order = 3,
        },
        toggle = {
            type = "execute",
            name = L["OptionToggleName"],
            desc = L["OptionToggleDesc"],
			func = "ExecuteToggle",
			order = 4,
        },
        list = {
            type = "execute",
            name = L["OptionListName"],
            desc = L["OptionListDesc"],
			func = "ExecuteList",
			order = 5,
        },
        clear = {
            type = "execute",
            name = L["OptionClearName"],
            desc = L["OptionClearDesc"],
			func = "ExecuteClear",
			order = 6,
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
        },
        headerprofile = {
            type = "header",
            name = L["OptionHeaderProfileName"],
			order = -1,
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
end

function RaidSummon:OnDisable()
	self:Print(L["AddonDisabled"])
	RaidSummonSyncDB = {}
end

function RaidSummon:OnInitialize()

	self.db = LibStub("AceDB-3.0"):New("RaidSummonOptionsDB", defaults, true)

	LibStub("AceConfig-3.0"):RegisterOptionsTable("RaidSummon", options)
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	--self:RegisterModuleOptions("Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), "Profiles")
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RaidSummon", "RaidSummon")
	self:RegisterChatCommand("rs", "ChatCommand")
	self:RegisterChatCommand("raidsummon", "ChatCommand")
	print(string.format("RaidSummon version %s by %s", GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")))
	
	--load version in RaidSummon Frame
	RaidSummon_RequestFrameHeader:SetText(L["FrameHeader"](GetAddOnMetadata("RaidSummon", "Version")))

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
function RaidSummon:NameListButton_PreClick(source, button)

	local buttonname = source:GetName()
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
		
		if RaidSummon_RaidMembersDB then

			if GetZoneText() == "" then
				zonetext = nil
			else
				zonetext = GetZoneText()
			end
			
			if GetSubZoneText() == "" then
				subzonetext = nil
			else
				subzonetext = GetSubZoneText()
			end
			
			if self.db.profile.zone and self.db.profile.whisper and zonetext and subzonetext then
				SendChatMessage(L["SummonAnnounceRZS"](targetname, zonetext, subzonetext), "RAID")
				SendChatMessage(L["SummonAnnounceWZS"](zonetext, subzonetext), "WHISPER", nil, targetname)
			elseif self.db.profile.zone and self.db.profile.whisper and zonetext and not subzonetext then
				SendChatMessage(L["SummonAnnounceRZ"](targetname, zonetext), "RAID")
				SendChatMessage(L["SummonAnnounceWZ"](zonetext), "WHISPER", nil, targetname)
			elseif self.db.profile.zone and not self.db.profile.whisper and zonetext and subzonetext then
				SendChatMessage(L["SummonAnnounceRZS"](targetname, zonetext, subzonetext), "RAID")
			elseif self.db.profile.zone and not self.db.profile.whisper and zonetext and not subzonetext then
				SendChatMessage(L["SummonAnnounceRZ"](targetname, zonetext), "RAID")
			elseif not self.db.profile.zone and self.db.profile.whisper then
				SendChatMessage(L["SummonAnnounceR"](targetname), "RAID")
				SendChatMessage(L["SummonAnnounceW"], "WHISPER", nil, targetname)
			elseif not self.db.profile.zone and not self.db.profile.whisper then
				SendChatMessage(L["SummonAnnounceR"](targetname), "RAID")
			else
				print(L["SummonAnnounceError"])
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

	--only Update and show if Player is Warlock
	 if (UnitClass("player") == L["PlayerClassWarlock"]) then

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
				
				--Shamans are pink (like paladins) in Classic, we need to fix that, thanks to Molimo-Lucifron for testing
				if RaidSummon_BrowseDB[i].rfileName == "SHAMAN" then
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(0.00, 0.44, 0.87, 1)
				else
					local r,g,b,img = GetClassColor(RaidSummon_BrowseDB[i].rfileName)
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(r, g, b, 1)
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
		self:ExecuteHelp()
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
	if value == true then
		print(L["OptionWhisperEnabled"])
	else
		print(L["OptionWhisperDisabled"])
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

--Execute Option Functions
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
	if RaidSummon_RequestFrame:IsVisible() then
		RaidSummon_RequestFrame:Hide()
	else
		RaidSummon:UpdateList()
		ShowUIPanel(RaidSummon_RequestFrame, 1)
	end
end
