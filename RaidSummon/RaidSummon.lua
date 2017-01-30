function RaidSummon_EventFrame_OnLoad()

	DEFAULT_CHAT_FRAME:AddMessage(string.format("RaidSummon version %s by %s", GetAddOnMetadata("RaidSummon", "Version"), GetAddOnMetadata("RaidSummon", "Author")));
    this:RegisterEvent("ADDON_LOADED")
    this:RegisterEvent("CHAT_MSG_ADDON")
    this:RegisterEvent("CHAT_MSG_RAID")
	this:RegisterEvent("CHAT_MSG_RAID_LEADER")
    this:RegisterEvent("CHAT_MSG_SAY")
    
	SlashCmdList["RAIDSUMMON"] = RaidSummon_SlashCommand;
	SLASH_RAIDSUMMON1 = "/raidsummon";
	SLASH_RAIDSUMMON2 = "/rs";
	
	MSG_PREFIX_ADD	= "RSAdd"
	MSG_PREFIX_REMOVE	= "RSRemove"
	RaidSummonDB = {}
	
end

function RaidSummon_EventFrame_OnEvent()

	if event == "CHAT_MSG_SAY" or event == "CHAT_MSG_RAID"  or event == "CHAT_MSG_RAID_LEADER" then
		if string.find(arg1, "123") then
			SendAddonMessage(MSG_PREFIX_ADD, arg2, "RAID")
		end
	elseif event == "CHAT_MSG_ADDON" then
		if arg1 == MSG_PREFIX_ADD then
			if not RaidSummon_hasValue(RaidSummonDB, arg2) then
				table.insert(RaidSummonDB, arg2)
				RaidSummon_RequestFrameScrollFrame_Update()
			end
		elseif arg1 == MSG_PREFIX_REMOVE then
			if RaidSummon_hasValue(RaidSummonDB, arg2) then
				for i, v in ipairs (RaidSummonDB) do
					if v == arg2 then
						table.remove(RaidSummonDB, i)
						RaidSummon_RequestFrameScrollFrame_Update()
					end
				end
			end
		end
	end
end

function RaidSummon_SlashCommand( msg )

	if msg == "help" then
		DEFAULT_CHAT_FRAME:AddMessage("no help available yet")
	
	elseif msg == "show" then
		for i,v in pairs(RaidSummonDB) do
			DEFAULT_CHAT_FRAME:AddMessage(tostring(v))
		end
	else
	
		if RaidSummon_RequestFrame:IsVisible() then
			RaidSummon_RequestFrame:Hide()
		else
			RaidSummon_RequestFrameScrollFrame_Update()
			ShowUIPanel(RaidSummon_RequestFrame, 1)
		end
	
	end
	
end

function RaidSummon_hasValue (tab, val)
    for i, v in ipairs (tab) do
        if v == val then
            return true
        end
    end
    return false
end


--GUI
function RaidSummon_NameListButton_OnClick(button)

	local name = getglobal(this:GetName().."TextName"):GetText();

	if button == "LeftButton" then
	
		RaidSummon_getRaidMembers()
		
		for i, v in ipairs (RaidSummon_UnitIDDB) do
			if v.rName == name then
				UnitID = "raid"..v.rIndex
			end
		end
			
		TargetUnit(UnitID)
		CastSpellByName("Ritual of Summoning")
		
		SendChatMessage("RS - Summoning ".. name .. " to "..GetZoneText() .. " - " .. GetSubZoneText(), "RAID")
		SendChatMessage("RS - Summoning you to "..GetZoneText() .. " - " .. GetSubZoneText(), "WHISPER", nil, name)

	elseif button == "RightButton" then

	end
	for i, v in ipairs (RaidSummonDB) do
		if v == name then
			SendAddonMessage(MSG_PREFIX_REMOVE, name, "RAID")
		end
	end
	
		
			
	--HideUIPanel(RaidSummon_RequestFrame, 1)
	RaidSummon_RequestFrameScrollFrame_Update()
end

function RaidSummon_getRaidMembers()
    local raidnum = GetNumRaidMembers();

    if ( raidnum > 0 ) then
	RaidSummon_UnitIDDB = {}; 

	for i = 1, raidnum do
	    local rName = GetRaidRosterInfo(i);

		RaidSummon_UnitIDDB[i] = {};
		if (not rName) then 
		    rName = "unknown"..i;
		end
		
		RaidSummon_UnitIDDB[i].rName    = rName;
		RaidSummon_UnitIDDB[i].rIndex   = i; 
		
	    end
	end
end

function RaidSummon_RequestFrameScrollFrame_Update()


	RaidSummon_NameBrowseTable = {}
		
	for k,v in pairs(RaidSummonDB) do
		table.insert(RaidSummon_NameBrowseTable, v)
	end

	local maxlines = getn(RaidSummon_NameBrowseTable)
	local line; -- 1 through 10 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
   
	 -- maxlines is max entries, 1 is number of lines, 16 is pixel height of each line
	FauxScrollFrame_Update(RaidSummon_RequestFrameScrollFrame, maxlines, 1, 16)

	--sort table
	--table.sort(RaidSummon_NameBrowseTable, function(a, b) return a > b end)
	--table.sort(RaidSummon_NameBrowseTable)

	for line=1,10 do
		 lineplusoffset = line + FauxScrollFrame_GetOffset(RaidSummon_RequestFrameScrollFrame);
		 if lineplusoffset <= maxlines then
			getglobal("RaidSummon_NameList"..line.."TextName"):SetText(RaidSummon_NameBrowseTable[lineplusoffset])
			getglobal("RaidSummon_NameList"..line):Show()
		 else
			getglobal("RaidSummon_NameList"..line):Hide()
		 end
   end
end

