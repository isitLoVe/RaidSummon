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

	DEFAULT_CHAT_FRAME:AddMessage(string.format("RaidSummon version %s by %s", GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")))
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
	elseif event == "CHAT_MSG_SAY" or event == "CHAT_MSG_RAID"  or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_YELL" or event == "CHAT_MSG_WHISPER" then
		local msg, author = ...
		if string.find(msg, "^123") or string.find(msg, "^summon") or string.find(msg, "^sum") or string.find(msg, "^port") then
			C_ChatInfo.SendAddonMessage(MSG_PREFIX_ADD, author, "RAID")
		end
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, text, channel, sender = ...
		if prefix == MSG_PREFIX_ADD then
			print("RS "..prefix..text..sender)
			if not RaidSummon_hasValue(RaidSummonDB, text) then
				print("RS add to table")
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
function RaidSummon_NameListButton_OnClick(button)

	local name = getglobal(RaidSummon_NameListButton:GetName().."TextName"):GetText()

	if button  == "LeftButton" and IsControlKeyDown() then
	
		RaidSummon_getRaidMembers()
		
		if RaidSummon_UnitIDDB then
		
			for i, v in ipairs (RaidSummon_UnitIDDB) do
				if v.rName == name then
					UnitID = "raid"..v.rIndex
				end
			end
		
			if UnitID then
				TargetUnit(UnitID)
			end
			
		else
			DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - no raid found")
		end
		
	elseif button == "LeftButton" and not IsControlKeyDown() then
	
		RaidSummon_getRaidMembers()
		
		if RaidSummon_UnitIDDB then
		
			for i, v in ipairs (RaidSummon_UnitIDDB) do
				if v.rName == name then
					UnitID = "raid"..v.rIndex
				end
			end
		
			if UnitID then
				playercombat = UnitAffectingCombat("player")
				targetcombat = UnitAffectingCombat(UnitID)
			
				if not playercombat and not targetcombat then
					TargetUnit(UnitID)
					CastSpellByName("Ritual of Summoning")
					
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
					DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - Player is in combat")
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - Player " .. tostring(name) .. " not found in raid. UnitID: " .. tostring(UnitID))
				C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, name, "RAID")
				RaidSummon_UpdateList()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - no raid found")
		end
	elseif button == "RightButton" then
		for i, v in ipairs (RaidSummonDB) do
			if v == name then
				C_ChatInfo.SendAddonMessage(MSG_PREFIX_REMOVE, name, "RAID")
				table.remove(RaidSummonDB, i)
				RaidSummon_UpdateList()
			end
		end
	end
			
	RaidSummon_UpdateList()
end

function RaidSummon_UpdateList()
	local RaidSummon_BrowseDB = {}

	--only Update and show if Player is Warlock
	 if (UnitClass("player") == "Warlock") then

	 --classic fix
		if IsInGroup() then 
			--get raid member data
			local raidnum = GetNumGroupMembers()

			for raidmember = 1, raidnum do
				local rName, rRank, rSubgroup, rLevel, rClass = GetRaidRosterInfo(raidmember)

				--check raid data for RaidSummon data
				for i, v in ipairs (RaidSummonDB) do 
				
					--if player is found fill BrowseDB
					if v == rName then
						print(v)
						RaidSummon_BrowseDB[i] = {}
						RaidSummon_BrowseDB[i].rName = rName
						RaidSummon_BrowseDB[i].rClass = rClass
						RaidSummon_BrowseDB[i].rIndex = i --needed?
						
						if rClass == "Warlock" then
							RaidSummon_BrowseDB[i].rVIP = true
						else
							RaidSummon_BrowseDB[i].rVIP = false
						end
					end
				end
			end

			--sort warlocks first
			table.sort(RaidSummon_BrowseDB, function(a,b) return tostring(a.rVIP) > tostring(b.rVIP) end)

		end
		
		for i=1,10 do
			if RaidSummon_BrowseDB[i] then
				print(tostring(RaidSummon_BrowseDB[i].rName))
				getglobal("RaidSummon_NameList"..i.."TextName"):SetText(RaidSummon_BrowseDB[i].rName)
				
				--set class color
				if RaidSummon_BrowseDB[i].rClass == "Druid" then
					local c = RaidSummon_GetClassColour("DRUID")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Hunter" then
					local c = RaidSummon_GetClassColour("HUNTER")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Mage" then
					local c = RaidSummon_GetClassColour("MAGE")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Paladin" then
					local c = RaidSummon_GetClassColour("PALADIN")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Priest" then
					local c = RaidSummon_GetClassColour("PRIEST")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Rogue" then
					local c = RaidSummon_GetClassColour("ROGUE")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Shaman" then
					local c = RaidSummon_GetClassColour("SHAMAN")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Warlock" then
					local c = RaidSummon_GetClassColour("WARLOCK")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				elseif RaidSummon_BrowseDB[i].rClass == "Warrior" then
					local c = RaidSummon_GetClassColour("WARRIOR")
					getglobal("RaidSummon_NameList"..i.."TextName"):SetTextColor(c.r, c.g, c.b, 1)
				end				
				
				getglobal("RaidSummon_NameList"..i):Show()
			else
				getglobal("RaidSummon_NameList"..i):Hide()
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
		DEFAULT_CHAT_FRAME:AddMessage("RaidSummon usage:")
		DEFAULT_CHAT_FRAME:AddMessage("/rs or /raidsummon { help | show | zone | whisper }")
		DEFAULT_CHAT_FRAME:AddMessage(" - |cff9482c9help|r: prints out this help")
		DEFAULT_CHAT_FRAME:AddMessage(" - |cff9482c9show|r: shows the current summon list")
		DEFAULT_CHAT_FRAME:AddMessage(" - |cff9482c9zone|r: toggles zoneinfo in /ra and /w")
		DEFAULT_CHAT_FRAME:AddMessage(" - |cff9482c9whisper|r: toggles the usage of /w")
		DEFAULT_CHAT_FRAME:AddMessage("To drag the frame use shift + left mouse button")
	elseif msg == "show" then
		--show msg if list is empty
		if next(RaidSummonDB) == nil then
			DEFAULT_CHAT_FRAME:AddMessage("|cffff0000RaidSummon list is empty|r")
		end		
		for i, v in ipairs(RaidSummonDB) do
			DEFAULT_CHAT_FRAME:AddMessage(tostring(v))
		end
	elseif msg == "zone" then
		if RaidSummonOptions["zone"] == true then
			RaidSummonOptions["zone"] = false
			DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - zoneinfo: |cffff0000disabled|r")
		elseif RaidSummonOptions["zone"] == false then
			RaidSummonOptions["zone"] = true
			DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - zoneinfo: |cff00ff00enabled|r")
		end
	elseif msg == "whisper" then
		if RaidSummonOptions["whisper"] == true then
			RaidSummonOptions["whisper"] = false
			DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - whisper: |cffff0000disabled|r")
		elseif RaidSummonOptions["whisper"] == false then
			RaidSummonOptions["whisper"] = true
			DEFAULT_CHAT_FRAME:AddMessage("RaidSummon - whisper: |cff00ff00enabled|r")
		end
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
	if IsInGroup() then 

		local raidnum = GetNumGroupMembers()

		if (raidnum > 0) then
		RaidSummon_UnitIDDB = {}

		for i = 1, raidnum do
			local rName, rRank, rSubgroup, rLevel, rClass = GetRaidRosterInfo(i)

			RaidSummon_UnitIDDB[i] = {}
			if (not rName) then 
				rName = "unknown"..i
			end
			
			RaidSummon_UnitIDDB[i].rName    = rName
			RaidSummon_UnitIDDB[i].rClass    = rClass
			RaidSummon_UnitIDDB[i].rIndex   = i
			
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
