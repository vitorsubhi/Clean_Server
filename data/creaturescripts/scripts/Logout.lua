local config = {
	loginMessage = getConfigValue('loginMessage'),
	useFragHandler = getBooleanFromString(getConfigValue('useFragHandler'))
}

function onLogout(cid)
	db.query("UPDATE `players` SET `online` = '0' WHERE `name` = \"" .. getPlayerName(cid) .. "\"")
	return true
end

