local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "enUS", true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Version"] = "Version"
L["Language"] = "English"
L["AddonEnabled"] = function(X,Y)
	return 'RaidSummon version ' .. X .. ' by ' .. Y .. ' loaded'
end
L["AddonDisabled"] = "RaidSummon disabled"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end
L["OptionZoneName"] = "Zone"
L["OptionZoneDesc"] = "Enable Zone mentioning in Raid and Whisper announcments."
L["OptionWhisperName"] = "Whisper"
L["OptionWhisperDesc"] = "Enable whispering to the summoning target."
