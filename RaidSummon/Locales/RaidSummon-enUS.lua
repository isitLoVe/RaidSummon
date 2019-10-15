local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "enUS", true)
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

--Options
L["OptionZoneName"] = "Zone"
L["OptionZoneDesc"] = "Enable zone (e.g. Orgrimmar) and subzone (e.g. Valley of Wisdom) mentioning in announcements."
L["OptionWhisperName"] = "Whisper"
L["OptionWhisperDesc"] = "Enable whispering to the summoned target."
L["OptionHelpName"] = "Help"
L["OptionHelpDesc"] = "Shows a list of supported commands and options."
L["OptionConfigName"] = "Config"
L["OptionConfigDesc"] = "Opens the configuration menu."
L["OptionGroupOptionsName"] = "Options"
L["OptionGroupCommandsName"] = "Commands"
L["OptionHeaderProfileName"] = "ACE3 profiles"
L["OptionListName"] = "List"
L["OptionListDesc"] = "Shows a list of raid members that requested a summon."
L["OptionClearName"] = "Clear"
L["OptionClearDesc"] = "Clears the summoning list."
L["OptionToggleName"] = "Toggle"
L["OptionToggleDesc"] = "Toggles the visiblity of the summoning frame."

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Option whisper |cff00ff00enabled|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Option whisper |cffff0000disabled|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Option zone |cff00ff00enabled|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Option zone |cffff0000disabled|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon usage:|r
/rs or /raidsummon { clear | config | help | list | toggle | whisper | zone }
 - |cff9482c9clear|r: Clears the summoning list.
 - |cff9482c9config|r: Opens the configuration menu.
 - |cff9482c9help|r: Shows a list of supported options.
 - |cff9482c9list|r: Shows a list of raid members that requested a summon.
 - |cff9482c9toggle|r: Toggles the visiblity of the summoning frame.
 - |cff9482c9whisper|r: Enable whispering to the summoned target.
 - |cff9482c9zone|r: Enable zone mentioning in announcements.
You can drag the frame with SHIFT + LEFT mouse button.
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r List is empty"
L["OptionList"] = "|cff9482c9RaidSummon:|r Raid members that requested a summon:"
L["OptionClear"] = "|cff9482c9RaidSummon:|r Cleared the summon list"

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["SummonAnnounceRZS"] = function(T,Z,S)
	return 'RaidSummon: Summoning ' .. T .. ' to ' .. Z .. ' - ' .. S
end
L["SummonAnnounceWZS"] = function(Z,S)
	return 'RaidSummon: Summoning you to ' .. Z .. ' - ' .. S
end
L["SummonAnnounceRZ"] = function(T,Z,S)
	return 'RaidSummon: Summoning ' .. T .. ' to ' .. Z
end
L["SummonAnnounceWZ"] = function(Z,S)
	return 'RaidSummon: Summoning you to ' .. Z
end
L["SummonAnnounceR"] = function(T)
	return 'RaidSummon: Summoning ' .. T
end
L["SummonAnnounceW"] = "RaidSummon: Summoning you"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Announce error"