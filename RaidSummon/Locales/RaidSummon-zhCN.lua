local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "zhCN", false, true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Language"] = "简体中文"
L["AddonEnabled"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r version ' .. X .. ' by ' .. Y .. ' loaded'
end
L["AddonDisabled"] = "禁用RaidSummon"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end
L["Lockdown"] = "|cff9482c9RaidSummon:|r 进入战斗，动作取消。"
L["noRaid"] = "|cff9482c9RaidSummon:|r 不在团队中"
L["MemberRemoved"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Removing player ' .. X .. ' from the summoning frame as requested by ' .. Y
end
L["MemberAdded"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Adding player ' .. X .. ' to the summoning frame as requested by ' .. Y
end
L["AddAllMessage"] = "|cff9482c9RaidSummon:|r 添加所有玩家"

--Options
L["OptionZoneName"] = "区域通知"
L["OptionZoneDesc"] = "在通知中启用区域（例如：奥格瑞玛）及次级区域（例如：智慧谷）。"
L["OptionWhisperName"] = "密语通知"
L["OptionWhisperDesc"] = "使用密语通知被召唤玩家。"
L["OptionFlashwindowName"] = "窗口闪烁"
L["OptionFlashwindowDesc"] = "当有玩家请求召唤时闪烁游戏窗口。"
L["OptionHelpName"] = "帮助"
L["OptionHelpDesc"] = "显示可用的命令及设置选项。"
L["OptionConfigName"] = "设置"
L["OptionConfigDesc"] = "打开设置窗口。"
L["OptionGroupOptionsName"] = "选项"
L["OptionGroupCommandsName"] = "命令"
L["OptionHeaderProfileName"] = "Ace3 profiles"
L["OptionListName"] = "列表"
L["OptionListDesc"] = "显示已请求召唤的玩家列表。"
L["OptionClearName"] = "清除"
L["OptionClearDesc"] = "清除召唤列表。"
L["OptionToggleName"] = "开关列表"
L["OptionToggleDesc"] = "打开/关闭召唤列表。"
L["OptionAddName"] = "添加玩家"
L["OptionAddDesc"] = "将玩家添加到召唤列表（名字必须完全一致）。"
L["OptionRemoveName"] = "移除玩家"
L["OptionRemoveDesc"] = "将玩家从召唤列表中移除（名字必须完全一致）。"
L["OptionAddAllName"] = "添加全部"
L["OptionAddAllDesc"] = "将团队中不在当前区域的玩家全部添加到召唤列表中。"
L["OptionGroupKeywordsName"] = "关键字"
L["OptionKWListName"] = "关键字列表"
L["OptionKWListDesc"] = "列出正在使用的召唤请求关键字。"
L["OptionKWAddName"] = "添加关键字"
L["OptionKWAddDesc"] = "添加一个召唤请求关键字。"
L["OptionKWRemoveName"] = "移除关键字"
L["OptionKWRemoveDesc"] = "移除一个召唤请求关键字。"
L["OptionKWDescription"] =  [[|cffff0000请注意关键字匹配说明！|r

插件将搜寻匹配“说/大喊/团队/小队/密语”这些聊天中的关键字。仅当消息中包含有关键字的发送人会被添加到召唤列表。如果需要重置关键字列表，你可以使用Ace3配置管理器重置你的配置文件。

例如:
|cff9482c9^summon|r - 匹配第一个词为 "summon" 的聊天消息
|cff9482c9summon|r - 匹配任意位置含有 "summon" 的聊天消息
|cff9482c9^summon$|r - 精确匹配 "summon" 
]]

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r 密语通知 |cff00ff00enabled|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r 密语通知 |cffff0000disabled|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r 区域通知 |cff00ff00enabled|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r 区域通知 |cffff0000disabled|r"
L["OptionFlashwindowEnabled"] = "|cff9482c9RaidSummon:|r 窗口闪烁 |cff00ff00enabled|r"
L["OptionFlashwindowDisabled"] = "|cff9482c9RaidSummon:|r 窗口闪烁 |cffff0000disabled|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon 命令:|r
/rs or /raidsummon { clear | config | help | list | add | addall | remove | toggle | whisper | zone | kwlist | kwadd | kwremove }
 - |cff9482c9clear|r: 清除召唤列表。
 - |cff9482c9config|r: 打开设置窗口。
 - |cff9482c9help|r: 显示可用的设置选项。
 - |cff9482c9list|r: 显示已请求召唤的玩家列表。
 - |cff9482c9add|r: 将玩家添加到召唤列表（名字必须完全一致）。
 - |cff9482c9addall|r: 将团队中不在当前区域的玩家全部添加到召唤列表中。
 - |cff9482c9remove|r: 将玩家从召唤列表中移除（名字必须完全一致）。
 - |cff9482c9toggle|r: 打开/关闭召唤列表。
 - |cff9482c9whisper|r: 使用密语通知被召唤玩家。
 - |cff9482c9zone|r: 在通知中启用区域及次级区域。
 - |cff9482c9kwlist|r: 列出正在使用的召唤请求关键字。
 - |cff9482c9kwadd|r: 添加一个召唤请求关键字。
 - |cff9482c9kwremove|r: 移除一个召唤请求关键字。
你可以使用SHIFT + 鼠标左键拖动召唤列表窗口。
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r 召唤列表是空的"
L["OptionList"] = "|cff9482c9RaidSummon:|r 已发出召唤请求的团队成员："
L["OptionClear"] = "|cff9482c9RaidSummon:|r 召唤列表已清空"

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["SummonAnnounceRZS"] = function(T,Z,S)
	return 'RaidSummon: 正在召唤 ' .. T .. ' 到 ' .. Z .. ' - ' .. S
end
L["SummonAnnounceWZS"] = function(Z,S)
	return 'RaidSummon: 正将你召唤到 ' .. Z .. ' - ' .. S
end
L["SummonAnnounceRZ"] = function(T,Z,S)
	return 'RaidSummon: 正在召唤 ' .. T .. ' 到 ' .. Z
end
L["SummonAnnounceWZ"] = function(Z,S)
	return 'RaidSummon: 正将你召唤到 ' .. Z
end
L["SummonAnnounceR"] = function(T)
	return 'RaidSummon: 正在召唤 ' .. T
end
L["SummonAnnounceW"] = "RaidSummon: 正在召唤你"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r 召唤通知错误"
L["TargetMissmatch"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r 召唤已取消。当前目标 ' .. X .. ' 与你在列表中点击的目标不匹配 ' .. Y
end
L["OptionKWList"] = "|cff9482c9RaidSummon:|r 关键字列表："
L["OptionKWAddDuplicate"] = function(V)
	return '|cff9482c9RaidSummon:|r 关键字重复： ' .. V
end
L["OptionKWAddAdded"] = function(V)
	return '|cff9482c9RaidSummon:|r 关键字已添加： ' .. V
end
L["OptionKWRemoveRemoved"] = function(V)
	return '|cff9482c9RaidSummon:|r 关键字已移除： ' .. V
end
L["OptionKWRemoveNF"] = function(V)
	return '|cff9482c9RaidSummon:|r 未找到关键字： ' .. V
end
