local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "ptBR", true, true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Language"] = "Português Brasileiro"
L["AddonEnabled"] = function(X,Y)
    return '|cff9482c9RaidSummon:|r versão ' .. X .. ' por ' .. Y .. ' carregado'
end
L["AddonDisabled"] = "RaidSummon desabilitado"
L["FrameHeader"] = function(X)
    return 'RaidSummon v' .. X
end
L["Lockdown"] = "|cff9482c9RaidSummon:|r Você está em combate, ação interrompida"
L["noRaid"] = "|cff9482c9RaidSummon:|r Nenhuma raid encontrada."
L["MemberRemoved"] = function(X,Y)
    return '|cff9482c9RaidSummon:|r Removendo jogador ' .. X .. ' do quadro de invocação, conforme solicitado por ' .. Y
end
L["MemberAdded"] = function(X,Y)
    return '|cff9482c9RaidSummon:|r Adicionando jogador ' .. X .. ' ao quadro de invocação, conforme solicitado por ' .. Y
end
L["AddAllMessage"] = "|cff9482c9RaidSummon:|r Adicionando todos os jogadores"

--Options
L["OptionZoneName"] = "Zone"
L["OptionZoneDesc"] = "Ative a zona (Ex.: Orgrimmar) e a subzona (Ex.: Vale da Sabedoria) mencionadas nos anúncios."
L["OptionWhisperName"] = "Sussuro"
L["OptionWhisperDesc"] = "Ative o sussurro para o alvo invocado."
L["OptionHelpName"] = "Ajuda"
L["OptionHelpDesc"] = "Mostra uma lista de comandos e opções suportados."
L["OptionConfigName"] = "Config"
L["OptionConfigDesc"] = "Abre o menu de configuração."
L["OptionGroupOptionsName"] = "Opções"
L["OptionGroupCommandsName"] = "Comandos"
L["OptionHeaderProfileName"] = "Perfis Ace3"
L["OptionListName"] = "Lista"
L["OptionListDesc"] = "Mostra uma lista de jogadores que solicitaram uma convocação."
L["OptionClearName"] = "Limpar"
L["OptionClearDesc"] = "Limpa a lista de convocação."
L["OptionToggleName"] = "Arternar"
L["OptionToggleDesc"] = "Alterne a visibilidade do quadro de convocação."
L["OptionAddName"] = "Adicionar jogador"
L["OptionAddDesc"] = "Adiciona um jogador ao quadro de convocação (diferencia maiúsculas de minúsculas)."
L["OptionRemoveName"] = "Remover jogador"
L["OptionRemoveDesc"] = "Remove um jogador do quadro de convocação (diferencia maiúsculas de minúsculas)."
L["OptionAddAllName"] = "Adicionar tudo"
L["OptionAddAllDesc"] = "Adicione todos os jogadores que não estão na zona atual ao quadro de convocação."
L["OptionGroupKeywordsName"] = "Invocar por palavras-chave"
L["OptionKWListName"] = "Lista de palavras-chave"
L["OptionKWListDesc"] = "Lista todas as palavras-chave de invocação ativas."
L["OptionKWAddName"] = "Add palavra-chave"
L["OptionKWAddDesc"] = "Adiciona uma palavra-chave de invocação."
L["OptionKWRemoveName"] = "Remover palavra-chave"
L["OptionKWRemoveDesc"] = "Remove uma palavra-chave de invocação."
L["OptionKWDescription"] =  [[|cffff0000Palavras-chave são expressões regulares, use com cuidado!|r

As palavras-chave são correspondidas por meio do bate-papo say/yell/raid/party/whisper. Somente o remetente da mensagem de bate-papo será adicionado à lista de convocação. Para redefinir palavras-chave, você pode usar o gerenciador de perfis do Ace3 e redefinir seu perfil.

Exemplos básicos:
|cff9482c9^summon|r - Corresponderá "summon" como a primeira palavra de uma mensagem de bate-papo
|cff9482c9summon|r - Combina "summon" em qualquer posição de uma mensagem de bate-papo, mesmo dentro de palavras como asdfsummonasdf
|cff9482c9^summon$|r - Só corresponderá se uma única palavra "summon" for recebida
]]

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Opção de sussurro |cff00ff00enabled|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Opção de sussurro |cffff0000disabled|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Opção de zona |cff00ff00enabled|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Opção de zona |cffff0000disabled|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon usage:|r
/rs or /raidsummon { clear | config | help | list | add | addall | remove | toggle | whisper | zone | kwlist | kwadd | kwremove }
 - |cff9482c9clear|r: Lista de invocação limpa.
 - |cff9482c9config|r: Abre o menu de configuração.
 - |cff9482c9help|r: Mostra uma lista de opções suportadas.
 - |cff9482c9list|r: Mostra uma lista de jogadores que solicitaram uma invocação.
 - |cff9482c9add|r: Adiciona um jogador ao quadro de invocação (diferencia maiúsculas de minúsculas).
 - |cff9482c9addall|r: Adicione todos os jogadores que não estão na zona atual ao quadro de invocação.
 - |cff9482c9remove|r: Remove um jogador do quadro de invocação (diferencia maiúsculas de minúsculas).
 - |cff9482c9toggle|r: Alterna a visibilidade do quadro de invocação.
 - |cff9482c9whisper|r: Habilita sussurros para o alvo invocado.
 - |cff9482c9zone|r: Ativar zona mencionada em anúncios.
 - |cff9482c9kwlist|r: Lista todas as palavras-chave de invocação ativas.
 - |cff9482c9kwadd|r: Adiciona uma palavra-chave de convocação.
 - |cff9482c9kwremove|r: Remove uma palavra-chave de convocação.
 Você pode arrastar o quadro com o botão Shift+Botão esquerdo do mouse.
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r A lista está vazia"
L["OptionList"] = "|cff9482c9RaidSummon:|r Membros da raid que solicitaram uma invocação:"
L["OptionClear"] = "|cff9482c9RaidSummon:|r Limpou a lista de invocação"

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["SummonAnnounceRZS"] = function(T,Z,S)
    return 'RaidSummon: Invocando ' .. T .. ' para ' .. Z .. ' - ' .. S
end
L["SummonAnnounceWZS"] = function(Z,S)
    return 'RaidSummon: Invocando você para ' .. Z .. ' - ' .. S
end
L["SummonAnnounceRZ"] = function(T,Z,S)
    return 'RaidSummon: Invocando ' .. T .. ' para ' .. Z
end
L["SummonAnnounceWZ"] = function(Z,S)
    return 'RaidSummon: Invocando você para ' .. Z
end
L["SummonAnnounceR"] = function(T)
    return 'RaidSummon: Invocando ' .. T
end
L["SummonAnnounceW"] = "RaidSummon: Invocando você"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Anunciar erro"
L["NotEnoughMana"] = "|cff9482c9RaidSummon:|r Não é suficiente Mana!"
L["TargetMissmatch"] = function(X,Y)
    return '|cff9482c9RaidSummon:|r Invocação cancelada. Seu alvo ' .. X .. ' não corresponde ao nome em que você clicou ' .. Y
end
L["OptionKWList"] = "|cff9482c9RaidSummon:|r Invocando lista de palavras-chave:"
L["OptionKWAddDuplicate"] = function(V)
    return '|cff9482c9RaidSummon:|r Keyword duplicado: ' .. V
end
L["OptionKWAddAdded"] = function(V)
    return '|cff9482c9RaidSummon:|r Keyword adicionado: ' .. V
end
L["OptionKWRemoveRemoved"] = function(V)
    return '|cff9482c9RaidSummon:|r Keyword removido: ' .. V
end
L["OptionKWRemoveNF"] = function(V)
    return '|cff9482c9RaidSummon:|r Palavra-chave não encontrada: ' .. V
end
