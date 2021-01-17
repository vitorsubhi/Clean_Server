local _Lib_Hill_Config = {
	pos = {x=1327, y=1927, z=6},
	points = 2000,
	Guild_Storage = 9939,
	Points_Storage = 9940,
	Hill_Storage = 9941,
	Hill_Time = 4 * 60 * 60 * 1000
}

function restartHill()
	doBroadcastMessage("[HILL] The Hill event, will start now!")
	setGlobalStorageValue(_Lib_Hill_Config.Hill_Storage, 1)
	cleanHill()
	return true
end

function cleanHill()
	setGlobalStorageValue(_Lib_Hill_Config.Guild_Storage, 0)
	setGlobalStorageValue(_Lib_Hill_Config.Points_Storage, 0)
end

function checkHill(cid, pos)
	if(getGlobalStorageValue(9942) > os.time()) then
		return false
	elseif isInRange(getCreaturePosition(cid), _Lib_Hill_Config.pos, _Lib_Hill_Config.pos) then
		if(getGlobalStorageValue(_Lib_Hill_Config.Guild_Storage) == getPlayerGuildId(cid)) then
			if (getGlobalStorageValue(_Lib_Hill_Config.Points_Storage) == _Lib_Hill_Config.points) then
				doBroadcastMessage("[HILL] The Guild "..getPlayerGuildName(cid).." got ".._Lib_Hill_Config.points.." points, and Won the Event.", MESSAGE_EVENT_ADVANCE)
				setGlobalStorageValue(_Lib_Hill_Config.Hill_Storage, 0)
				setGlobalStorageValue(9942, os.time())
				addEvent(restartHill, _Lib_Hill_Config.Hill_Time)
				return true
			end
			setGlobalStorageValue(9940, getGlobalStorageValue(9940)+1)
			setGlobalStorageValue(9942, os.time()+1)
			doSendAnimatedText(_Lib_Hill_Config.pos, getGlobalStorageValue(9940), 151)
			addEvent(checkHill, 1000, cid, pos)
		else
			doSendAnimatedText(pos, "1", 151)
			setGlobalStorageValue(9940, 1)
			setGlobalStorageValue(_Lib_Hill_Config.Guild_Storage, getPlayerGuildId(cid))
			addEvent(checkHill, 1000, cid, pos)
		end
	end
	return false
end
local hill = {}
function onStepIn(cid, item, pos)
	if (getGlobalStorageValue(_Lib_Hill_Config.Hill_Storage) == 1) then
		addEvent(checkHill, 1000, cid, pos)
	end
	return true
end
