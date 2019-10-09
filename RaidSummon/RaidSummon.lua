function RaidSummon_Initialize()

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
end

function RaidSummon_EventFrame_OnLoad()

	print(string.format("RaidSummon version %s by %s", GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")))
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

function RaidSummon_EventFrame_OnEvent(self,event,...)
	if event == "ADDON_LOADED" then
		RaidSummon_Initialize()
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
			print("RS Prefix "..prefix.." text "..text.." sender "..sender)
			if not RaidSummon_hasValue(RaidSummonDB, text) then
				print("RS add to table - "..text)
				table.insert(RaidSummonDB, text)
				RaidSummon_UpdateList()
			end
		elseif prefix == MSG_PREFIX_REMOVE then
			if RaidSummon_hasValue(RaidSummonDB, text) then
				for i, v in ipairs (RaidSummonDB) do
					if v == text then
						table.remove(RaidSummonDB, i)
						RaidSummon_UpdateList()
					end
				end
			end
		end
	end
end

--GUI
function RaidSummon_NameListButton_PostClick(id)

	local name = _G[id.."TextName"]:GetText()
	buttonName = GetMouseButtonClicked()
	local targetname, targetrealm = UnitName("target")

	if buttonName == "RightButton" and targetname ~= nil then
		RaidSummon_getRaidMembers()
		
		if RaidSummon_RaidMembersDB then
		
			for i, v in ipairs (RaidSummon_RaidMembersDB) do
				if v.rName == name then
					raidIndex = "raid"..v.rIndex
				end
			end
			
			if raidIndex then
				if RaidSummonOptions.zone and RaidSummonOptions.whisper then
				
					if GetSubZoneText() == "" then
						SendChatMessage("RS - Summoning ".. name .. " to "..GetZoneText(), "RAID")
						SendChatMessage("RS - Summoning you to "..GetZoneText(), "WHISPER", nil, name)
					else
						SendChatMessage("RS - Summoning ".. name .. " to "..GetZoneText() .. " - " .. GetSubZoneText(), "RAID")
						SendChatMessage("RS - Summoning you to "..GetZoneText() .. " - " .. GetSubZoneText(), "WHISPER", nil, name)
					end
				elseif RaidSummonOptions.zone and not RaidSummonOptions.whisper then
					if GetSubZoneText() == "" then
						SendChatMessage("RS - Summoning ".. name .. " to "..GetZoneText(), "RAID")
					else
						SendChatMessage("RS - Summoning ".. name .. " to "..GetZoneText() .. " - " .. GetSubZoneText(), "RAID")
					end
				elseif not RaidSummonOptions.zone and RaidSummonOptions.whisper then
					SendChatMessage("RS - Summoning ".. name, "RAID")
					SendChatMessage("RS - Summoning you", "WHISPER", nil, name)
				elseif not RaidSummonOptions.zone and not RaidSummonOptions.whisper then
					SendChatMessage("RS - Summoning ".. name, "RAID")
				end
				for i, v in ipairs (RaidSummonDB) do
					if v == name then
						C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, name, "RAID")
					end
				end
			else
				print("RaidSummon Error - Player " .. tostring(name) .. " not found in raid. raidIndex: " .. tostring(raidIndex))
				C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, name, "RAID")
				--RaidSummon_UpdateList()
			end
		else
			print("RaidSummon Error - no raid found")
		end
	elseif buttonName == "LeftButton" and not IsControlKeyDown() then
		for i, v in ipairs (RaidSummonDB) do
			if v == name then
				C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, name, "RAID")
				table.remove(RaidSummonDB, i)
				--RaidSummon_UpdateList()
			end
		end
	end
			
	RaidSummon_UpdateList()
end

function RaidSummon_UpdateList()
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
							
							if RaidMembersDBvalue.rfileName == "WARLOCK" then --localization
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
				print("Load Frame "..RaidSummon_BrowseDB[i].rName)
				_G["RaidSummon_NameList"..i.."TextName"]:SetText(RaidSummon_BrowseDB[i].rName)
				
				--Secure Button Attributes
				--Target Raid Member Left Click type1
				_G["RaidSummon_NameList"..i]:SetAttribute("type1", "target")
				_G["RaidSummon_NameList"..i]:SetAttribute("target", "raid"..RaidSummon_BrowseDB[i].rName)

				--Cast Spell Right Click type2
				_G["RaidSummon_NameList"..i]:SetAttribute("type2", "spell")
				--_G["RaidSummon_NameList"..i..]:SetAttribute("spell", "Ritual of Summoning") --localization?
				_G["RaidSummon_NameList"..i]:SetAttribute("spell", "698") --localization?
				--_G["RaidSummon_NameList"..i]:SetAttribute("spellid", "698") --localization?
				--_G["RaidSummon_NameList"..i]:SetAttribute("spellid", 698) --localization?
				_G["RaidSummon_NameList"..i]:SetAttribute("target", "raid"..RaidSummon_BrowseDB[i].rName)
							
				--set class color localization
				if RaidSummon_BrowseDB[i].rClass == "Druid" then
					local c = RaidSummon_GetClassColour("DRUID")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Hunter" then
					local c = RaidSummon_GetClassColour("HUNTER")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Mage" then
					local c = RaidSummon_GetClassColour("MAGE")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Paladin" then
					local c = RaidSummon_GetClassColour("PALADIN")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Priest" then
					local c = RaidSummon_GetClassColour("PRIEST")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Rogue" then
					local c = RaidSummon_GetClassColour("ROGUE")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Shaman" then
					local c = RaidSummon_GetClassColour("SHAMAN")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Warlock" then
					local c = RaidSummon_GetClassColour("WARLOCK")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Warrior" then
					local c = RaidSummon_GetClassColour("WARRIOR")
					_G["RaidSummon_NameList"..i.."TextName"]:SetTextColor(c.r, c.g, c.b, 1)
				end				
				
				_G["RaidSummon_NameList"..i]:Show()
			else
				_G["RaidSummon_NameList"..i]:Hide()
			end
		end
		
		if not RaidSummonDB[1] then
			if RaidSummon_RequestFrame:IsVisible() then
				RaidSummon_RequestFrame:Hide()
			end
		else
			ShowUIPanel(RaidSummon_RequestFrame, 1)
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
		RaidSummon_UpdateList
	else
	
		if RaidSummon_RequestFrame:IsVisible() then
			RaidSummon_RequestFrame:Hide()
		else
			RaidSummon_UpdateList()
			ShowUIPanel(RaidSummon_RequestFrame, 1)
		end
	
	end
	
end

--class color
function RaidSummon_GetClassColour(class)
	if (class) then
		local color = RAID_CLASS_COLORS[class]
		if (color) then
			return color
		end
	end
	return {r = 0.5, g = 0.5, b = 1}
end

--raid member
function RaidSummon_getRaidMembers()

	--classic fix
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

function RaidSummon_hasValue (tab, val)
	for i, v in ipairs (tab) do
		if v == val then
			return true
		end
	end
	return false
end
