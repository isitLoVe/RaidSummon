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
	
	local MSG_PREFIX = "RaidSummon"
	SummonDB = {}
end

function RaidSummon_EventFrame_OnEvent()

	if event == "CHAT_MSG_SAY" or event == "CHAT_MSG_RAID"  or event == "CHAT_MSG_RAID_LEADER" then

		if string.find(arg1, "123") then
		DEFAULT_CHAT_FRAME:AddMessage("sum req ".. arg2)
			if not RaidSummon_hasValue(SummonDB, arg2) then
				table.insert(SummonDB, arg2)
				SendAddonMessage(MSG_PREFIX, arg2, "RAID")
			end
		end
	elseif event == "CHAT_MSG_ADDON" then
		if arg1 == MSG_PREFIX then
			if not RaidSummon_hasValue(SummonDB, arg2) then
				table.insert(SummonDB, arg2)
			end
		end
	end
end

function RaidSummon_SlashCommand( msg )

	if msg == "help" then
		DEFAULT_CHAT_FRAME:AddMessage("no help available yet")
	
	elseif msg == "show" then
		for i,v in pairs(SummonDB) do
			DEFAULT_CHAT_FRAME:AddMessage(tostring(v))
		end
	else
	
		if RaidSummon_RequestFrame:IsVisible() then
			RaidSummon_RequestFrame:Hide()
		else
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
function RaidSummon_NameListButton_OnClick()

	local name = getglobal(this:GetName().."RaidSummon_NameListButton"):GetText();
	getglobal("LootTracker_RaidIDBox"):SetText(raidid_browse)
	
	HideUIPanel(LootTracker_RaidIDFrame, 1)
	LootTracker_ListScrollFrame_Update()
	
end


function LootTracker_RaidIDScrollFrame_Update()

	LootTracker_RaidIDBrowseTable = {}
		
	for k in pairs(LootTrackerDB) do
		table.insert(LootTracker_RaidIDBrowseTable, k)
	end

	local maxlines = getn(LootTracker_RaidIDBrowseTable)
	local line; -- 1 through 10 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
   
	 -- maxlines is max entries, 1 is number of lines, 16 is pixel height of each line
	FauxScrollFrame_Update(LootTracker_RaidIDScrollFrame, maxlines, 1, 16)

	--sort table
	table.sort(LootTracker_RaidIDBrowseTable, function(a, b) return a > b end)
	--table.sort(LootTracker_RaidIDBrowseTable)

	for line=1,10 do
		 lineplusoffset = line + FauxScrollFrame_GetOffset(LootTracker_RaidIDScrollFrame);
		 if lineplusoffset <= maxlines then
			getglobal("LootTracker_RaidIDList"..line.."TextRaidID"):SetText(LootTracker_RaidIDBrowseTable[lineplusoffset])
			getglobal("LootTracker_RaidIDList"..line):Show()
		 else
			getglobal("LootTracker_RaidIDList"..line):Hide()
		 end
   end
end

