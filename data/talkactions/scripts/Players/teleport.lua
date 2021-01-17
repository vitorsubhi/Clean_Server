local teleport_list = {
	["temple"] = {x=1758, y=2258, z=7},
	["depot"] = {x=158, y=49, z=6}
}

function onSay(cid, words, param, channel)
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		return true
	end
	if(getPlayerStorageValue(cid, 1) == -1)then
		return doPlayerSendTextMessage(cid, 21, "You do not have this power, please talk with Pumin.")
	end

	local t = string.explode(param, ",")

	if (not getTileInfo(getThingPosition(cid)).protection) then
		doPlayerSendTextMessage(cid, 21, "You cannot teleport outside a protection zone.")
		return true
	end

	if param == "house" then
		local house = getHouseByPlayerGUID(getPlayerGUID(cid))
		if(not house) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You do not have any House.")
			return true
		end

		local houseInfo = getHouseInfo(house)
		doTeleportThing(cid, houseInfo.entry)
	elseif param == "list" then
		local str = ""
		for name in pairs(teleport_list) do
			str = str .. (name):gsub("^%l", string.upper)  .. "\n"
		end
		doShowTextDialog(cid, 2580, str)
		return true
	else
		doTeleportThing(cid, teleport_list[param])
	end
	return true
end
