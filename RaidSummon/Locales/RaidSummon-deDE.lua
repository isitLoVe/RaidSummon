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
L["OptionZoneName"] = "Zone"
L["OptionZoneDesc"] = "Enable Zone mentioning in Raid and Whisper announcments."
L["OptionWhisperName"] = "Whisper"
L["OptionWhisperDesc"] = "Enable whispering to the summoning target."
