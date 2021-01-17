function onSay(cid, words, param)
	local config = {
		bankSystemEnabled = getBooleanFromString(getConfigInfo('bankSystem')),
		playerIsFighting = hasCondition(cid, CONDITION_INFIGHT)
	}

	if config.bankSystemEnabled == true then
		if config.playerIsFighting == false then
			local m = tonumber(param)
			if(string.lower(param) == "all") then
				m = getPlayerBalance(cid)
			elseif(param == "") then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Tutorial: /withdraw (amount) or /withdraw all")
				return true
			end
			if(not m) then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Tutorial: /withdraw (amount) or /withdraw all")
				return true
			end

			m = math.abs(m)
			if m <= getPlayerBalance(cid) then
				doPlayerWithdrawMoney(cid, m)
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Here you are, " .. m .. " gold. Your account balance is " .. getPlayerBalance(cid) .. ".")

			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "There is not enough gold on your account.")
			end
			return true
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Bank can not be used in fight.")
			return true
		end
	else
		return false
	end
end 
