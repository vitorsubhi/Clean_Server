function onThink(interval, lastExecution)
	local name_of_monster = 'Training Kid'   ---  here put monster name or any npc name
	local texts = {	 
	-- text              pos                effects            
	["Depot (Main City)"] = {{x=1764, y=2257, z=7}, 23},
	["Temple"] = {{x=151, y=46, z=6}, 23},
	["Shop"] = {{x=164, y=46, z=6}, 23},
	["Ice Town"] = {{x=71, y=473, z=12}, 23},
	["Quest LvL 2.5k"] = {{x=63, y=473, z=12}, 23},	
	["Canoe Island"] = {{x=67, y=473, z=12}, 23}	
	}

	for text, param in pairs(texts) do
		doCreatureSay(getCreatureByName(name_of_monster),text,TALKTYPE_ORANGE_1, false, 0,param[1])
	end
	return TRUE
end
