function prepareClean(minutes)
	if(minutes == 0) then
		doCleanMap()
		doBroadcastMessage("Game map successfully cleaned.")
		doSaveServer(false)
		doBroadcastMessage("Server successfully saved.")
	elseif(minutes > 0) then
		if(minutes == 1) then
			doBroadcastMessage("Server save and map cleaning in " .. minutes .. " minute, please pick up all your items.")
		else
			doBroadcastMessage("Server save and map cleaning in " .. minutes .. " minutes.")
		end

		cleanEvent = addEvent(prepareClean, 60000, minutes - 1)
	end
end

function onTime()
	addEvent(prepareClean, 1, 5)
	return true
end
