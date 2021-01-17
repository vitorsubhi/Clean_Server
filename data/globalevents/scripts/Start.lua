function onStartup()
	--db.query("UPDATE `players` SET `online` = 0 WHERE `world_id` = " .. getConfigValue('worldId') .. ";")
	
	--local res = db.getResult("select * from `fishing_monsters`;")
	--	if res:getID() ~= -1 then
	--	repeat
	--		getpos = {x = res:getDataInt("pos_x"), y =  res:getDataInt("pos_y"), z = res:getDataInt("pos_z")}
	--		monsterx = doCreateMonster(res:getDataString("name"), getpos)
	--		setCreatureMaxHealth(monsterx, res:getDataInt("maxhealth"))
	--		doCreatureAddHealth(monsterx, -getCreatureMaxHealth(monsterx)+res:getDataInt("health"))
	--		doCreatureSetStorage(monsterx, 3301, 1)
	--	until not res:next()
	--	end
	--return true
	--db.query("DELETE FROM `guild_wars` WHERE `status` = 0 AND `begin` < " .. (os.time() - 2 * 86400) .. ";")
	--db.query("UPDATE `guild_wars` SET `status` = 5, `end` = " .. os.time() .. " WHERE `status` = 1 AND `end` > 0 AND `end` < " .. os.time() .. ";")
end
