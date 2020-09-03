local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "ruRU", false, true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Language"] = "Russian"
L["AddonEnabled"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r версия ' .. X .. ' по ' .. Y .. ' загрузка'
end
L["AddonDisabled"] = "RaidSummon отключен"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end
L["Lockdown"] = "|cff9482c9RaidSummon:|r Вы в бою, действие отменено"
L["noRaid"] = "|cff9482c9RaidSummon:|r Рейд не найден."

--Options
L["OptionZoneName"] = "Локация"
L["OptionZoneDesc"] = "Включите объявление локаций (например, Оргриммар) и мест (например, Долина Мудрости)."
L["OptionWhisperName"] = "Шепот"
L["OptionWhisperDesc"] = "Разрешить шептать выбранной цели."
L["OptionHelpName"] = "Помощь"
L["OptionHelpDesc"] = "Показывает список поддерживаемых команд и опций."
L["OptionConfigName"] = "Конфигурация"
L["OptionConfigDesc"] = "Открывает меню конфигурации."
L["OptionGroupOptionsName"] = "Настройки"
L["OptionGroupCommandsName"] = "Команды"
L["OptionHeaderProfileName"] = "ACE3 профиль"
L["OptionListName"] = "Список"
L["OptionListDesc"] = "Показывает список участников рейда, которые запросили призыв."
L["OptionClearName"] = "Очистить"
L["OptionClearDesc"] = "Очищает список призыва."
L["OptionToggleName"] = "Окно призыва"
L["OptionToggleDesc"] = "Переключает видимость окна призыва."

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Настройки шепота |cff00ff00включено|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Настройки шепота |cffff0000отключено|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Настройки локации |cff00ff00включено|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Настройки локации |cffff0000отключено|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon использование:|r
/rs or /raidsummon { clear | config | help | list | add | toggle | whisper | zone }
 - |cff9482c9clear|r: Очищает список призыва.
 - |cff9482c9config|r: Открывает меню конфигурации.
 - |cff9482c9help|r: Показывает список поддерживаемых опций.
 - |cff9482c9list|r: Показывает список участников рейда, которые запросили призыв.
 - |cff9482c9add|r: Manually adds a raid member to the summoning frame.
 - |cff9482c9toggle|r: Переключает видимость окна призыва.
 - |cff9482c9whisper|r: Разрешить шептать выбранной цели.
 - |cff9482c9zone|r: Включить упоминание локации в объявлениях.
Вы можете перетащить окно с помощью кнопки SHIFT + ЛКМ.
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r Список пуст"
L["OptionList"] = "|cff9482c9RaidSummon:|r Участники рейда, которые запросили призыв:"
L["OptionClear"] = "|cff9482c9RaidSummon:|r Очистить список призыва"

L["NotEnoughMana"] = "|cff9482c9RaidSummon:|r недостаточно маны"

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["SummonAnnounceRZS"] = function(T,Z,S)
	return 'RaidSummon: Призыв ' .. T .. ' в ' .. Z .. ' - ' .. S
end
L["SummonAnnounceWZS"] = function(Z,S)
	return 'RaidSummon: Призываю вас ' .. Z .. ' - ' .. S
end
L["SummonAnnounceRZ"] = function(T,Z,S)
	return 'RaidSummon: Призыв ' .. T .. ' в ' .. Z
end
L["SummonAnnounceWZ"] = function(Z,S)
	return 'RaidSummon: Призываю вас ' .. Z
end
L["SummonAnnounceR"] = function(T)
	return 'RaidSummon: Призыв ' .. T
end
L["SummonAnnounceW"] = "RaidSummon: Призываю тебя"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Сообщить об ошибке"