local config = {
	shallow = false
}

function prepareSave(minutes)
	if(minutes == 0) then
		doSaveServer(config.shallow)
		doBroadcastMessage("Server successfully saved.")
	elseif(minutes > 0) then
		if(minutes == 1) then
			doBroadcastMessage("Server save in " .. minutes .. " minute, it may freeze.")
		else
			doBroadcastMessage("Server save in " .. minutes .. " minutes.")
		end

		saveEvent = addEvent(prepareSave, 60000, minutes - 1)
	end
end

function onTime()
	addEvent(prepareSave, 1, 3)
	return true
end
