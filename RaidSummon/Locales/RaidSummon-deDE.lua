local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "deDE", true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Version"] = "Version"
L["Language"] = "Deutsch"
L["AddonEnabled"] = function(X,Y)
	return 'RaidSummon Version ' .. X .. ' von ' .. Y .. ' geladen'
end
L["AddonDisabled"] = "RaidSummon deaktiviert"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end

--Options
L["OptionZoneName"] = "Zone"
L["OptionZoneDesc"] = "Schaltet die Ankündigung von Zonen ein."
L["OptionWhisperName"] = "Flüstern"
L["OptionWhisperDesc"] = "Schaltet die Flüsterfunktion beim Beschwören ein."
L["OptionHelpName"] = "Hilfe"
L["OptionHelpDesc"] = "Zeigt eine Liste der möglichen Optionen an."
L["OptionConfigName"] = "Konfiguration"
L["OptionConfigDesc"] = "Öffnet das Konfigurationsmenü"
L["OptionHeaderOptionsName"] = "Optionen"
L["OptionHeaderProfileName"] = "ACE3 Profile"
L["OptionListName"] = "list"
L["OptionListDesc"] = "Shows a list of raid members that requested a summon."

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Option flüstern |cff00ff00eingeschaltet|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Option flüstern |cffff0000ausgeschaltet|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Option Zone |cff00ff00eingeschaltet|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Option Zone |cffff0000ausgeschaltet|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon:|r
/rs or /raidsummon { help | show | zone | whisper }
 - |cff9482c9help|r: Zeigt diese Hilfe an
 - |cff9482c9clear|r: Löscht die Beschörungsliste
 - |cff9482c9list|r: Zeigt alle Leute in der Beschörungsliste an
 - |cff9482c9whisper|r: Schaltet die Flüsteroption ein/aus
 - |cff9482c9zone|r: Schaltet die Zonen Ankündigung in /w und /ra ein/aus
To drag the frame use SHIFT + LEFT mouse button
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r List is empty"
L["OptionList"] = "|cff9482c9RaidSummon:|r raid members that need a summon:"

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["SummonAnnounceRZS"] = function(T,Z,S)
	return '|cff9482c9RaidSummon:|r summoning ' .. T .. ' to ' .. Z .. ' - ' .. S
end
L["SummonAnnounceWZS"] = function(Z,S)
	return '|cff9482c9RaidSummon:|r summoning you to ' .. Z .. ' - ' .. S
end
L["SummonAnnounceRZ"] = function(T,Z,S)
	return '|cff9482c9RaidSummon:|r summoning ' .. T .. ' to ' .. Z
end
L["SummonAnnounceWZ"] = function(Z,S)
	return '|cff9482c9RaidSummon:|r summoning you to ' .. Z
end
L["SummonAnnounceR"] = function(T)
	return '|cff9482c9RaidSummon:|r summoning ' .. T
end
L["SummonAnnounceW"] = "|cff9482c9RaidSummon:|r summoning you"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Announce error"