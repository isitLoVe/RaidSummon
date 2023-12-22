local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "esES", false, true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Language"] = "Español"
L["AddonEnabled"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r versión ' .. X .. ' por ' .. Y .. ' cargado. Traducido por |cffADFF2FThorien-Mandokir|r.'
end
L["AddonDisabled"] = "RaidSummon desactivado"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end
L["Lockdown"] = "|cff9482c9RaidSummon:|r Estás en combate, acción abortada."
L["noRaid"] = "|cff9482c9RaidSummon:|r Raid no encontrada."
L["MemberRemoved"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Eliminando jugador ' .. X .. ' de la lista de invocaciones. Solicitado por ' .. Y
end
L["MemberAdded"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Añadiendo jugador ' .. X .. ' a la lista de invocaciones. Solicitado por ' .. Y
end
L["AddAllMessage"] = "|cff9482c9RaidSummon:|r Añadiendo todos los jugadores"

--Options
L["OptionZoneName"] = "Zona"
L["OptionZoneDesc"] = "Activar mención de zona (ej. Orgrimmar) y subzona (ej. Valle de la Sabiduría) en los anuncios."
L["OptionWhisperName"] = "Susurro"
L["OptionWhisperDesc"] = "Activar susurros al objetivo invocado."
L["OptionFlashwindowName"] = "Iluminar Ventana"
L["OptionFlashwindowDesc"] = "La ventana se ilumina cuando alguien solicita invocación."
L["OptionHelpName"] = "Ayuda"
L["OptionHelpDesc"] = "Mostrar lista de comandos y opciones soportadas."
L["OptionConfigName"] = "Config"
L["OptionConfigDesc"] = "Abre el menú de configuración."
L["OptionGroupOptionsName"] = "Opciones"
L["OptionGroupCommandsName"] = "Comandos"
L["OptionHeaderProfileName"] = "Perfiles Ace3"
L["OptionListName"] = "Lista"
L["OptionListDesc"] = "Muestra una lista de jugadores que han solicitado invocación."
L["OptionClearName"] = "Limpiar"
L["OptionClearDesc"] = "Limpia la lista de invocación."
L["OptionToggleName"] = "Habilitar"
L["OptionToggleDesc"] = "Deshabilita la visibilidad de la lista de invocación."
L["OptionAddName"] = "Añadir jugador"
L["OptionAddDesc"] = "Añadir jugador a la lista de invocación (sensible a los signos)."
L["OptionRemoveName"] = "Eliminar jugador"
L["OptionRemoveDesc"] = "Elimina un jugador de la dista de invocación (sensible a los signos)."
L["OptionAddAllName"] = "Añadir todos"
L["OptionAddAllDesc"] = "Añade todos los jugadores que no estén en la zona actual a la lista de invocación."
L["OptionGroupKeywordsName"] = "Palabras clave para invocación"
L["OptionKWListName"] = "Lista de palabras clave"
L["OptionKWListDesc"] = "Lista de todas las palabras clave activas para invocaciones."
L["OptionKWAddName"] = "Añadir palabra clave"
L["OptionKWAddDesc"] = "Añade una palabra clave para invocaciones."
L["OptionKWRemoveName"] = "Eliminar palabra clave"
L["OptionKWRemoveDesc"] = "Elimina una palabra clave de la lista de invocaciones."
L["OptionKWDescription"] =  [[|cffff0000Las palabras clave son expresiones comunes ¡Úsalas con cautela!|r

Las palabras clave se detectarán por los chats decir/gritar/banda/grupo/susurro. Para reiniciar una palabra clave puedes usar el gestor de perfiles de Ace3 y reiniciar tu perfil.

Ejemplos básicos:
|cff9482c9^summon|r - Detectará "summon" como la primera palabra en un mensaje de chat
|cff9482c9summon|r - Detectará "summon" en cualquier posición en un mensaje de chat, incluso dentro de palabras compuestas como asdfsummonasdf
|cff9482c9^summon$|r - Solo detectará la palabra si "summon" es la única palabra recibida en ese mensaje de chat
]]

--Opciones de comando rápido
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Opción de susurro |cff00ff00enabled|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Opción de susurro |cffff0000disabled|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Opción de zona |cff00ff00enabled|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Opción de zona |cffff0000disabled|r"
L["OptionFlashwindowEnabled"] = "|cff9482c9RaidSummon:|r Opción de iluminar la ventana |cff00ff00activada|r"
L["OptionFlashwindowDisabled"] = "|cff9482c9RaidSummon:|r Opción de iluminar la ventana |cffff0000desactivada|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon usage:|r
/rs or /raidsummon { clear | config | help | list | add | addall | remove | toggle | whisper | zone | kwlist | kwadd | kwremove }
 - |cff9482c9clear|r: Limpia la lista de invocación.
 - |cff9482c9config|r: Abre el menú de configuración.
 - |cff9482c9help|r: Muestra una lista de opciones soportadas.
 - |cff9482c9list|r: Muestra una lista de jugadores que han solicitado invocación.
 - |cff9482c9add|r: Añade un jugador a la lista de invocación (sensible a signos).
 - |cff9482c9addall|r: Añade todos los jugadores que no estén en la zona actual.
 - |cff9482c9remove|r: Elimina un jugador de la lista de invocación (sensible a signos).
 - |cff9482c9toggle|r: Habilita la visibilidad de la lista de invocación.
 - |cff9482c9whisper|r: Activa susurros al objetivo invocado.
 - |cff9482c9zone|r: Activa la mención de zona en los anuncios.
 - |cff9482c9kwlist|r: Listado de todas las palabras clave para invocaciones.
 - |cff9482c9kwadd|r: Añade una palabra clave para invocaciones.
 - |cff9482c9kwremove|r: Elimina una palabra clave para invocaciones.
Puedes mover la lista con SHIFT + Ratón IZQ.
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r La lista está vacía"
L["OptionList"] = "|cff9482c9RaidSummon:|r Jugadores que han solicitado invocación:"
L["OptionClear"] = "|cff9482c9RaidSummon:|r Lista de invocación limpiada"

--Anuncio de invocación
--W=Susurro/R=Banda Z=Zona S=Subzona T=Jugador Objetivo
L["SummonAnnounceRZS"] = function(T,Z,S)
	return '{rt3}Invocando a ' .. T .. ' hacia ' .. Z .. ' - ' .. S .. '{rt3}'
end
L["SummonAnnounceWZS"] = function(Z,S)
	return '{rt3}Invocándote hacia ' .. Z .. ' - ' .. S .. '{rt3}'
end
L["SummonAnnounceRZ"] = function(T,Z,S)
	return '{rt3}Invocando a ' .. T .. ' hacia ' .. Z .. '{rt3}'
end
L["SummonAnnounceWZ"] = function(Z,S)
	return '{rt3}Invocándote hacia ' .. Z .. '{rt3}'
end
L["SummonAnnounceR"] = function(T)
	return '{rt3}Invocando a ' .. T .. '{rt3}'
end
L["SummonAnnounceW"] = "{rt3}Comenzando invocación{rt3}"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Se ha interrumpido"
L["TargetMissmatch"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Invocación abortada. Tu objetivo ' .. X .. ' no coincide con el nombre que has pinchado ' .. Y
end
L["OptionKWList"] = "|cff9482c9RaidSummon:|r Lista de palabras clave para invocaciones:"
L["OptionKWAddDuplicate"] = function(V)
	return '|cff9482c9RaidSummon:|r Palabra clave duplicada: ' .. V
end
L["OptionKWAddAdded"] = function(V)
	return '|cff9482c9RaidSummon:|r Palabra clave añadida: ' .. V
end
L["OptionKWRemoveRemoved"] = function(V)
	return '|cff9482c9RaidSummon:|r Palabra clave eliminada: ' .. V
end
L["OptionKWRemoveNF"] = function(V)
	return '|cff9482c9RaidSummon:|r Palabra clave no encontrada: ' .. V
end
