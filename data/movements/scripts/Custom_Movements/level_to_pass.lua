function onStepIn(cid, item, position, fromPosition, toPosition)
	local teleport = {
		[42670] = {min_level = 1, max_level = 500},
		[42671] = {min_level = 1, max_level=500}
	}

	if(getPlayerLevel(cid) >= teleport[item.uid].min_level and getPlayerLevel(cid) <= teleport[item.uid].max_level) then
		doSendMagicEffect(getPlayerPosition(cid), 12)
	else
		doPlayerSendTextMessage(cid, 25, "Only players from level ".. teleport[item.uid].min_level .." to level ".. teleport[item.uid].max_level .." can pass here.")
		doTeleportThing(cid, fromPosition, true)
		return false
	end
	return true
end
