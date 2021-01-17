tournament_list = {}

function onThink(interval, lastExecution)
	local tp = doCreateItem(1387, 1, _Lib_Tournament_Info.tpPos)
	doItemSetAttribute(tp, "aid", 45000)
	CheckEvent(_Lib_Tournament_Info.limit_Time)
	doBroadcastMessage("[Event: Tournament] It's Tournament time. We are waiting for 8 players.")
	return setGlobalStorageValue(_Lib_Battle_Info.storage_count, tb.players)
end
