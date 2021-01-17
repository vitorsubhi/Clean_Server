local config = {
	showGamemasters = getBooleanFromString(getConfigValue('displayGamemastersWithOnlineCommand'))
}

function onSay(cid, words, param, channel)
	local vocation = {
		[0] = {online = 0},
		[1] = {online = 0},
		[2] = {online = 0},
		[3] = {online = 0},
		[4] = {online = 0}
	}

	local group = {
		[7] = {online = 0},
		[8] = {online = 0},
		[9] = {online = 0},
		[10] = {online = 0}
	}
	
	local players = getPlayersOnline()
	local strings = {""}
	local strings2 = {""}

	local k = 1
	local i, position = 1, 1
	local added = false
	
	param = string.lower(param)
	if (param == '') then
		for _, pid in ipairs(players) do
			if((true or config.showGamemasters or getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES) or not getPlayerCustomFlagValue(pid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES)) and (not isPlayerGhost(pid) or getPlayerGhostAccess(cid) >= getPlayerGhostAccess(pid))) then
				i = i + 1
				if(getPlayerGroupId(pid) >= 7) then
					strings[position] = strings[position] .. getCreatureName(pid) .. " [" .. (getGroupInfo(getPlayerGroupId(pid)).name):gsub("^%l", string.upper) .. "]\n"
					k = k + 1
					i = i - 1
				else
					strings[position] = strings[position] .. getCreatureName(pid) .. " [" .. getPlayerLevel(pid) .. "]\n"
					--vocation[getPlayerVocation(pid)].online = vocation[getPlayerVocation(pid)].online + 1
				end
				added = true
			else
				added = false
			end
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED,"There are ".. (i - 1) .. " player(s), and ".. (k - 1) .." Staff Member(s) online in Collapser Server. ")
		strn = ""
		for i, str in ipairs(strings) do
			strn = strn .. "               List of Player(s) Online:\n\n"
			strn = strn .. str .. "-----------------------------\nSorcerers ["..vocation[1].online.."]\nDruids ["..vocation[2].online.."]\nPaladins ["..vocation[3].online.."]\nKnights ["..vocation[4].online.."]"
			doShowTextDialog(cid, 1950, strn)
		end
		return true
	elseif (param == 'staff') then
		for _, pid in ipairs(players) do
			if((true or config.showGamemasters or getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES) or not getPlayerCustomFlagValue(pid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES)) and (not isPlayerGhost(pid) or getPlayerGhostAccess(cid) >= getPlayerGhostAccess(pid))) then
				if(getPlayerGroupId(pid) >= 7) then
					strings[position] = strings[position] .. getCreatureName(pid) .. " [" .. (getGroupInfo(getPlayerGroupId(pid)).name):gsub("^%l", string.upper) .. "]\n"
					k = k + 1
					group[getPlayerGroupId(pid)].online = group[getPlayerGroupId(pid)].online + 1
				end
				added = true
			else
				added = false
			end

		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED,"There are ".. (k - 1) .." Staff Member(s) online in Collapser Server. ")
		strn = ""
		for i, str in ipairs(strings) do
			strn = strn .. "           List of Staff Member(s) Online:\n\n"
			strn = strn .. str .. "----------------------------\nAdministrators ["..group[10].online.."]\nModerators ["..group[9].online.."]\nCommunity Managers ["..group[8].online.."]\nGamemasters ["..group[7].online.."]"
			doShowTextDialog(cid, 1950, strn)
		end
		return true
	elseif (param == 'druid' or param == 'knight' or param == 'sorcerer' or param =='paladin') then
		for _, pid in ipairs(players) do
			if((true or config.showGamemasters or getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES) or not getPlayerCustomFlagValue(pid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES)) and (not isPlayerGhost(pid) or getPlayerGhostAccess(cid) >= getPlayerGhostAccess(pid))) then
				if (string.lower(getPlayerVocationName(pid)) == param) then
					i = i + 1
					strings[position] = strings[position] .. getCreatureName(pid) .. " [" .. getPlayerLevel(pid) .. "]\n"
					vocation[getPlayerVocation(pid)].online = vocation[getPlayerVocation(pid)].online + 1
					added = true
				end
			else
				added = false
			end
		end
		strn = ""
		for i, str in ipairs(strings) do
			strn = strn .. "               List of ".. (param):gsub("^%l", string.upper) .."(s) Online:\n\n"
			strn = strn .. str
			doShowTextDialog(cid, 1950, strn)
		end
		return true
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED,"Wrong parameters.")
		return true
	end
end
