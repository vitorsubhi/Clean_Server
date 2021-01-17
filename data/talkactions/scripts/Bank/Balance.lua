function onSay(cid, words, param)

	local config = {
		bankSystemEnabled = getBooleanFromString(getConfigInfo('bankSystem')),
		playerIsFighting = hasCondition(cid, CONDITION_INFIGHT)
	}

	if config.bankSystemEnabled == true then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Your account balance is " .. getPlayerBalance(cid) .. ".")
		return true
	else
		return false
	end
end 
