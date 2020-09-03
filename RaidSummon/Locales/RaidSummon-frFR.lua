local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "frFR", true, true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Language"] = "French"
L["AddonEnabled"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r version ' .. X .. ' by ' .. Y .. ' chargé'
end
L["AddonDisabled"] = "RaidSummon désactivé"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end
L["Lockdown"] = "|cff9482c9RaidSummon:|r Vous êtes en combat, action abandonnée"
L["noRaid"] = "|cff9482c9RaidSummon:|r Aucun raid trouvé, vous n'êtes pas en Raid"
L["MemberRemoved"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Suppression du joueur' .. X .. ' de la liste des invocations , comme demandé par ' .. Y
end
L["MemberAdded"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Adding player ' .. X .. ' de la liste des invocations par ' .. Y
end
L["AddAllMessage"] = "|cff9482c9RaidSummon:|r Ajout de tous les joueurs"

--Options
L["OptionZoneName"] = "Zone"
L["OptionZoneDesc"] = "activer zone (ex Orgrimmar) et subzone (ex Valley of Wisdom) dans les mantions d'annonce."
L["OptionWhisperName"] = "Chuchotement /w"
L["OptionWhisperDesc"] = "Activez l'avertissment en /w sur la cible invoquée"
L["OptionHelpName"] = "Aide"
L["OptionHelpDesc"] = "Affiche la liste des commandes et options prises en charge."
L["OptionConfigName"] = "Configuration"
L["OptionConfigDesc"] = "Ouvrir le menue de configuration."
L["OptionGroupOptionsName"] = "Options"
L["OptionGroupCommandsName"] = "Commandes"
L["OptionHeaderProfileName"] = "Ace3 profiles"
L["OptionListName"] = "Liste"
L["OptionListDesc"] = "affiche la liste des joueurs qui ont demandé une invocation."
L["OptionClearName"] = "Efface"
L["OptionClearDesc"] = "Efface la liste des invocations."
L["OptionToggleName"] = "Basculer"
L["OptionToggleDesc"] = "Bascule la visibilité du cadre d'invocation."
L["OptionAddName"] = "Ajouter un Joueur"
L["OptionAddDesc"] = "Ajoute un joueur à la liste d'invocation (sensible à la casse)."
L["OptionRemoveName"] = "Enlever Joueur"
L["OptionRemoveDesc"] = "Enlever un joueur à la liste d'invocation (sensible à la casse)."
L["OptionAddAllName"] = "Tout ajouter"
L["OptionAddAllDesc"] = "Ajoutez tous les joueurs ne se trouvant pas dans la zone actuelle au cadre d'invocation."
L["OptionGroupKeywordsName"] = "Mots clés pour les invocations"
L["OptionKWListName"] = "Liste des mots clés"
L["OptionKWListDesc"] = "Liste des mots clés."
L["OptionKWAddName"] = "Ajout Mot clé"
L["OptionKWAddDesc"] = "Ajoute un mot-clé pour les invocations. "
L["OptionKWRemoveName"] = "Enlève un mot clés"
L["OptionKWRemoveDesc"] = "Supprime un mot clé d'invocation."
L["OptionKWDescription"] =  [[|cffff0000Les mots clés sont des expressions régulières, à utiliser avec précaution!|r
Les mots clés sont mis en correspondance via le chat say / yell / raid / party / whisper. Seul l'expéditeur du message de discussion sera ajouté à la liste d'invocation. Pour réinitialiser les mots clés, vous pouvez utiliser le gestionnaire de profils Ace3 et réinitialiser votre profil.
Basic examples:
|cff9482c9^tp|r - Will match "summon" as the first word of a chat message
|cff9482c9tp|r - Will match "summon" à n'importe quelle position d'un message de discussion, même à l'intérieur de mots comme
|cff9482c9^tp$|r - correspondra que si un seul mot "tp" est reçu
]]

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Option whisper |cff00ff00enabled|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Option whisper |cffff0000disabled|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Option zone |cff00ff00enabled|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Option zone |cffff0000disabled|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon usage:|r
/rs or /raidsummon { clear | config | help | list | add | addall | remove | toggle | whisper | zone | kwlist | kwadd | kwremove }
 - | cff9482c9clear | r: efface la liste d'invocation.
 - | cff9482c9config | r: ouvre le menu de configuration.
 - | cff9482c9help | r: affiche une liste des options prises en charge.
 - | cff9482c9list | r: affiche une liste des joueurs qui ont demandé une invocation.
 - | cff9482c9add | r: ajoute un lecteur au cadre d'invocation (sensible à la casse).
 - | cff9482c9addall | r: ajoute tous les joueurs ne se trouvant pas dans la zone actuelle au cadre d'invocation.
 - | cff9482c9remove | r: supprime un joueur du cadre d'invocation (sensible à la casse).
 - | cff9482c9toggle | r: bascule la visibilité de la trame d'invocation.
 - | cff9482c9whisper | r: permet de chuchoter à la cible invoquée.
 - | cff9482c9zone | r: active la mention de zone dans les annonces.
 - | cff9482c9kwlist | r: répertorie tous les mots clés d'invocation actifs.
 - | cff9482c9kwadd | r: ajoute un mot-clé d'invocation.
 - | cff9482c9kwremove | r: supprime un mot-clé d'invocation.
Vous pouvez faire glisser le cadre avec le bouton SHIFT + GAUCHE de la souris.
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r La liste est vide"
L["OptionList"] = "|cff9482c9RaidSummon:|r Membres du raid qui ont demandé une assignation:"
L["OptionClear"] = "|cff9482c9RaidSummon:|r Effacé la liste d'invocation"

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["SummonAnnounceRZS"] = function(T,Z,S)
	return 'RaidSummon: Invocation ' .. T .. ' à ' .. Z .. ' - ' .. S
end
L["SummonAnnounceWZS"] = function(Z,S)
	return 'RaidSummon: Invocation à ' .. Z .. ' - ' .. S
end
L["SummonAnnounceRZ"] = function(T,Z,S)
	return 'RaidSummon: Invocation ' .. T .. ' à ' .. Z
end
L["SummonAnnounceWZ"] = function(Z,S)
	return 'RaidSummon: Invocation en cours à ' .. Z
end
L["SummonAnnounceR"] = function(T)
	return 'RaidSummon: Invocation ' .. T
end
L["SummonAnnounceW"] = "RaidSummon: Invocation en cours"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Announce error"
L["NotEnoughMana"] = "|cff9482c9RaidSummon:|r Pas assez de Mana!"
L["TargetMissmatch"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Invocation Annulée. Votre cible ' .. X .. ' ne correspond pas au nom sur lequel vous avez cliqué ' .. Y
end
L["OptionKWList"] = "|cff9482c9RaidSummon:|r Invocation Mots clés liste:"
L["OptionKWAddDuplicate"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword dupliqué: ' .. V
end
L["OptionKWAddAdded"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword ajouté ' .. V
end
L["OptionKWRemoveRemoved"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword supprimé: ' .. V
end
L["OptionKWRemoveNF"] = function(V)
	return '|cff9482c9RaidSummon:|r Keyword non trouvé: ' .. V
end
