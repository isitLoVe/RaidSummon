local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "enUS", true, true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Language"] = "English"
L["AddonEnabled"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r version ' .. X .. ' by ' .. Y .. ' loaded'
end
L["AddonDisabled"] = "RaidSummon disabled"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end
L["Lockdown"] = "|cff9482c9RaidSummon:|r You are in combat, action aborted"
L["noRaid"] = "|cff9482c9RaidSummon:|r No raid found."
L["MemberRemoved"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Removing player ' .. X .. ' from the summoning frame as requested by ' .. Y
end
L["MemberAdded"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Adding player ' .. X .. ' to the summoning frame as requested by ' .. Y
end
L["AddAllMessage"] = "|cff9482c9RaidSummon:|r Adding all players"

--Options
L["OptionZoneName"] = "Zone"
L["OptionZoneDesc"] = "Enable zone (e.g. Orgrimmar) and subzone (e.g. Valley of Wisdom) mentioning in announcements."
L["OptionWhisperName"] = "Whisper"
L["OptionWhisperDesc"] = "Enable whispering to the summoned target."
L["OptionWhisperTextName"] = "Whisper Text"
L["OptionWhisperTextDesc"] = "Custom whisper text. Use :t to indicate target name. Use :z to indicate zone/subzone. If blank, default whisper text will be used."
L["OptionRaidName"] = "Raid"
L["OptionRaidDesc"] = "Enable raid message with the summoning target."
L["OptionRaidTextName"] = "Raid Text"
L["OptionRaidTextDesc"] = "Custom raid text. Use :t to indicate target name. Use :z to indicate zone/subzone. If blank, default raid text will be used."
L["OptionSayName"] = "Say"
L["OptionSayDesc"] = "Enable say message with the summoning target."
L["OptionSayTextName"] = "Say Text"
L["OptionSayTextDesc"] = "Custom say text. Use :t to indicate target name. Use :z to indicate zone/subzone. If blank, default raid text will be used."
L["OptionFlashwindowName"] = "Flash Window"
L["OptionFlashwindowDesc"] = "Flashes the Windows when someone requests a summon."
L["OptionHelpName"] = "Help"
L["OptionHelpDesc"] = "Shows a list of supported commands and options."
L["OptionConfigName"] = "Config"
L["OptionConfigDesc"] = "Opens the configuration menu."
L["OptionGroupOptionsName"] = "Options"
L["OptionGroupWhisperName"] = "Whisper Text Options"
L["OptionGroupRaidName"] = "Raid Text Options"
L["OptionGroupSayName"] = "Raid Text Options"
L["OptionGroupTidbitsName"] = "Random Tidbit Options"
L["OptionGroupCommandsName"] = "Commands"
L["OptionHeaderProfileName"] = "Ace3 profiles"
L["OptionListName"] = "List"
L["OptionListDesc"] = "Shows a list of players that requested a summon."
L["OptionClearName"] = "Clear"
L["OptionClearDesc"] = "Clears the summoning list."
L["OptionToggleName"] = "Toggle"
L["OptionToggleDesc"] = "Toggles the visiblity of the summoning frame."
L["OptionAddName"] = "Add Player"
L["OptionAddDesc"] = "Adds a player to the summoning frame (case sensitive)."
L["OptionRemoveName"] = "Remove Player"
L["OptionRemoveDesc"] = "Removes a player from the summoning frame (case sensitive)."
L["OptionAddAllName"] = "Add All"
L["OptionAddAllDesc"] = "Add all players not in the current zone to the summoning frame."
L["OptionGroupKeywordsName"] = "Summoning keywords"
L["OptionKWListName"] = "List keywords"
L["OptionKWListDesc"] = "Lists all active summoning keywords."
L["OptionKWAddName"] = "Add keyword"
L["OptionKWAddDesc"] = "Adds a summoning keyword."
L["OptionKWRemoveName"] = "Remove keyword"
L["OptionKWRemoveDesc"] = "Removes a summoning keyword."
L["OptionKWDescription"] =  [[|cffff0000Keywords are regular expressions, use carefully!|r

Keywords are matched via say/yell/raid/party/whisper chat. Only the sender of the chat message will be added to the summoning list. To reset keywords you can use the Ace3 profile manager and reset your profile.

Basic examples:
|cff9482c9^summon|r - Will match "summon" as the first word of a chat message
|cff9482c9summon|r - Will match "summon" at any position of a chat message even inside words like asdfsummonasdf
|cff9482c9^summon$|r - Will only match if a single word "summon" is received
]]
L["OptionTidbitsDescription"] = "Tidbits are random blurbs that can be added to custom chat message texts with the :r tag.  A random phrase from the list will be inserted each time the chat message is executed."
L["OptionTidbitsAddName"] = "Add Tidbit"
L["OptionTidbitsAddDesc"] = "Adds a tidbit phrase."
L["OptionTidbitsRemoveName"] = "Remove Tidbit"
L["OptionTidbitsRemoveDesc"] = "Removes a tidbit phrase."

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Option whisper |cff00ff00enabled|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Option whisper |cffff0000disabled|r"
L["OptionRaidEnabled"] = "|cff9482c9RaidSummon:|r Option raid |cff00ff00enabled|r"
L["OptionRaidDisabled"] = "|cff9482c9RaidSummon:|r Option raid |cffff0000disabled|r"
L["OptionSayEnabled"] = "|cff9482c9RaidSummon:|r Option say |cff00ff00enabled|r"
L["OptionSayDisabled"] = "|cff9482c9RaidSummon:|r Option say |cffff0000disabled|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Option zone |cff00ff00enabled|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Option zone |cffff0000disabled|r"
L["OptionFlashwindowEnabled"] = "|cff9482c9RaidSummon:|r Option flash window |cff00ff00enabled|r"
L["OptionFlashwindowDisabled"] = "|cff9482c9RaidSummon:|r Option flash window |cffff0000disabled|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon usage:|r
/rs or /raidsummon { clear | config | help | list | add | addall | remove | toggle | whisper | zone | kwlist | kwadd | kwremove }
 - |cff9482c9clear|r: Clears the summoning list.
 - |cff9482c9config|r: Opens the configuration menu.
 - |cff9482c9help|r: Shows a list of supported options.
 - |cff9482c9list|r: Shows a list of players that requested a summon.
 - |cff9482c9add|r: Adds a player to the summoning frame (case sensitive).
 - |cff9482c9addall|r: Add all players not in the current zone to the summoning frame.
 - |cff9482c9remove|r: Removes a player from the summoning frame (case sensitive).
 - |cff9482c9toggle|r: Toggles the visiblity of the summoning frame.
 - |cff9482c9whisper|r: Enable whispering to the summoned target.
 - |cff9482c9zone|r: Enable zone mentioning in announcements.
 - |cff9482c9kwlist|r: Lists all active summoning keywords.
 - |cff9482c9kwadd|r: Adds a summoning keyword.
 - |cff9482c9kwremove|r: Removes a summoning keyword.
You can drag the frame with SHIFT + LEFT mouse button.
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r List is empty"
L["OptionList"] = "|cff9482c9RaidSummon:|r Raid members that requested a summon:"
L["OptionClear"] = "|cff9482c9RaidSummon:|r Cleared the summon list"

--Tidbits
L["slightPinch"] = "You may feel a slight pinch..."
L["notLiable"] = "Not liable for lost limbs."

--Filters
L["filter"] = "Filter"
L["filterCleared"] = "|cff9482c9RaidSummon:|r Filter cleared."
L["filterSet"] = function(v)
	return "|cff9482c9RaidSummon:|r Filter set to " .. v .. "."
end
L["filterTitle"] = function(v)
	return "Filter: " .. v
end

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["you"] = "you"
L["locationUnknown"] = "Unknown Location"
L["SummonAnnounceR"] = function(T,Z,S)
	if Z and S then
		return 'RaidSummon: Summoning ' .. T .. ' to ' .. Z .. ' - ' .. S
	elseif Z and not S then
		return 'RaidSummon: Summoning ' .. T .. ' to ' .. Z
	else
		return 'RaidSummon: Summoning ' .. T
	end
end
L["SummonAnnounceW"] = function(Z,S)
	if Z and S then
		return 'RaidSummon: Summoning you to ' .. Z .. ' - ' .. S
	elseif Z and not S then
		return 'RaidSummon: Summoning you to ' .. Z
	else
		return "RaidSummon: Summoning you"
	end
end
L["SummonAnnounceS"] = function(T,Z,S)
	if Z and S then
		return 'RaidSummon: Summoning ' .. T .. ' to ' .. Z .. ' - ' .. S
	elseif Z and not S then
		return 'RaidSummon: Summoning ' .. T .. ' to ' .. Z
	else
		return 'RaidSummon: Summoning ' .. T
	end
end
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Announce error"
L["TargetMissmatch"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Summoning aborted. Your target ' .. X .. ' does not match the name you clicked ' .. Y
end
L["OptionKWList"] = "|cff9482c9RaidSummon:|r Summoning keyword list:"
L["OptionKWAddDuplicate"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword duplicate: ' .. V
end
L["OptionKWAddAdded"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword added: ' .. V
end
L["OptionKWRemoveRemoved"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword removed: ' .. V
end
L["OptionKWRemoveNF"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword not found: ' .. V
end
