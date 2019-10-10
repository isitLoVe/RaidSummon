RaidSummon = LibStub("AceAddon-3.0"):NewAddon("RaidSummon", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RaidSummon", true)

function RaidSummon:Initialize()

	local RaidSummonOptions_DefaultSettings = {
		whisper = true,
		zone = true
	}

	if not RaidSummonOptions then
		RaidSummonOptions = {}
	end

	for k, v in pairs (RaidSummonOptions_DefaultSettings) do
		if (RaidSummonOptions[k] == nil) then
			RaidSummonOptions[k] = v
		end
	end
	
	print(string.format("RaidSummon version %s by %s", GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")))
	
end

function RaidSummon:EventFrameOnLoad()

	RaidSummon_EventFrame:RegisterEvent("ADDON_LOADED")
	RaidSummon_EventFrame:RegisterEvent("CHAT_MSG_ADDON")
	RaidSummon_EventFrame:RegisterEvent("CHAT_MSG_RAID")
	RaidSummon_EventFrame:RegisterEvent("CHAT_MSG_RAID_LEADER")
	RaidSummon_EventFrame:RegisterEvent("CHAT_MSG_SAY")
	RaidSummon_EventFrame:RegisterEvent("CHAT_MSG_YELL")
	RaidSummon_EventFrame:RegisterEvent("CHAT_MSG_WHISPER")

	SlashCmdList["RAIDSUMMON"] = RaidSummon_SlashCommand
	SLASH_RAIDSUMMON1 = "/raidsummon"
	SLASH_RAIDSUMMON2 = "/rs"
	
	MSG_PREFIX_ADD	= "RSAdd"
	MSG_PREFIX_REMOVE	= "RSRemove"
	RaidSummonDB = {}
	
	--localization
	RaidSummonLoc_Header = "RaidSummon v" .. GetAddOnMetadata("RaidSummon", "Version")
end

function RaidSummon:EventFrameOnEvent(self,event,...)
	if event == "ADDON_LOADED" then
		RaidSummon:Initialize()
		RaidSummon_EventFrame:UnregisterEvent("ADDON_LOADED")
	elseif event == "CHAT_MSG_SAY" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_YELL" or event == "CHAT_MSG_WHISPER" then
		--CHAT_MSG returns Playername-Realm in Classic, we sync this so it could be used later when cross realm Play is implementet, hopfully NEVER
		local msg, authorrealm = ...
		local author, realm = strsplit("-", authorrealm, 2)
		if string.find(msg, "^123") or string.find(msg, "^summon") or string.find(msg, "^sum") or string.find(msg, "^port") then
			C_ChatInfo.SendAddonMessage(MSG_PREFIX_ADD, author, "RAID")
		end
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, text, channel, sender = ...
		if prefix == MSG_PREFIX_ADD then
			if not RaidSummon_hasValue(RaidSummonDB, text) then
				table.insert(RaidSummonDB, text)
				RaidSummon:UpdateList()
			end
		elseif prefix == MSG_PREFIX_REMOVE then
			if RaidSummon_hasValue(RaidSummonDB, text) then
				for i, v in ipairs (RaidSummonDB) do
					if v == text then
						table.remove(RaidSummonDB, i)
						RaidSummon:UpdateList()
					end
				end
			end
		end
	end
end

--GUI
function RaidSummon_NameListButton_PreClick(self, button)

	local buttonname = self:GetName()
	local name = _G[buttonname.."TextName"]:GetText()
	local buttonName = GetMouseButtonClicked()
	local targetname, targetrealm = UnitName("target")

	RaidSummon_getRaidMembers()
	
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
		
			if RaidSummonOptions.zone and RaidSummonOptions.whisper then
			
				if GetSubZoneText() == "" then
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText(), "RAID")
					SendChatMessage("RS - Summoning you to "..GetZoneText(), "WHISPER", nil, targetname)
				else
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText() .. " - " .. GetSubZoneText(), "RAID")
					SendChatMessage("RS - Summoning you to "..GetZoneText() .. " - " .. GetSubZoneText(), "WHISPER", nil, targetname)
				end
			elseif RaidSummonOptions.zone and not RaidSummonOptions.whisper then
				if GetSubZoneText() == "" then
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText(), "RAID")
				else
					SendChatMessage("RS - Summoning ".. targetname .. " to "..GetZoneText() .. " - " .. GetSubZoneText(), "RAID")
				end
			elseif not RaidSummonOptions.zone and RaidSummonOptions.whisper then
				SendChatMessage("RS - Summoning ".. targetname, "RAID")
				SendChatMessage("RS - Summoning you", "WHISPER", nil, targetname)
			elseif not RaidSummonOptions.zone and not RaidSummonOptions.whisper then
				SendChatMessage("RS - Summoning ".. targetname, "RAID")
			end
			for i, v in ipairs (RaidSummonDB) do
				if v == targetname then
					C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, targetname, "RAID")
				end
			end
		else
			print("RaidSummon Error - no raid found")
		end
	elseif buttonName == "LeftButton" and IsControlKeyDown() then
		for i, v in ipairs (RaidSummonDB) do
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
			RaidSummon_getRaidMembers()
			if RaidSummon_RaidMembersDB then

				for RaidMembersDBindex, RaidMembersDBvalue in ipairs (RaidSummon_RaidMembersDB) do

					--check raid data for RaidSummon data
					for RaidSummonDBindex, RaidSummonDBvalue in ipairs (RaidSummonDB) do 
				
						--if player is found fill BrowseDB
						if RaidSummonDBvalue == RaidMembersDBvalue.rName then
							RaidSummon_BrowseDB[RaidSummonDBindex] = {}
							RaidSummon_BrowseDB[RaidSummonDBindex].rIndex = RaidMembersDBindex
							RaidSummon_BrowseDB[RaidSummonDBindex].rName = RaidMembersDBvalue.rName
							RaidSummon_BrowseDB[RaidSummonDBindex].rClass = RaidMembersDBvalue.rClass
							RaidSummon_BrowseDB[RaidSummonDBindex].rfileName = RaidMembersDBvalue.rfileName
							
							if RaidMembersDBvalue.rfileName == "WARLOCK" then
								RaidSummon_BrowseDB[RaidSummonDBindex].rVIP = true
							else
								RaidSummon_BrowseDB[RaidSummonDBindex].rVIP = false
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
		
			if not RaidSummonDB[1] then
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
		if next(RaidSummonDB) == nil then
			print("RaidSummon - list is empty")
		end		
		for i, v in ipairs(RaidSummonDB) do
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
		RaidSummonDB = {}
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
function RaidSummon_getRaidMembers()

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
function RaidSummon_hasValue (tab, val)
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

