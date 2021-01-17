local config = {
	maxLevel = getConfigInfo('maximumDoorLevel')
}

local checkCreature = {isPlayer, isMonster, isNpc}
local function pushBack(cid, position, fromPosition, displayMessage)
	doTeleportThing(cid, fromPosition, false)
	doSendMagicEffect(position, CONST_ME_MAGIC_BLUE)
	if(displayMessage) then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The tile seems to be protected against unwanted intruders.")
	end
end

function onStepIn(cid, item, position, fromPosition)
	if(getTileInfo(position).protection) then
		local depotPos, depot = getCreatureLookPosition(cid), {}
		depotPos.stackpos = STACKPOS_GROUND
		while(true) do
			if(not getTileInfo(depotPos).depot) then
				break
			end

			depotPos.stackpos = depotPos.stackpos + 1
			depot = getThingFromPos(depotPos)
			if(depot.uid == 0) then
				break
			end
			local tmp = getThingfromPos({x=position.x, y=position.y, z=position.z, stackpos = 253})
			if (tmp > 0) then
				pushBack(cid, position, fromPosition, false)
			end
			if(isInArray(depots, depot.itemid)) then
				local depotItems = getPlayerDepotItems(cid, getDepotId(depot.uid))
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "Your depot contains " .. depotItems .. " item" .. (depotItems > 1 and "s" or "") .. ".")
				break
			end
		end

		return true
	end
	return false
end
