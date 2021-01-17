function onSay(cid, words, param)
	local config = {
		bankSystemEnabled = getBooleanFromString(getConfigInfo('bankSystem')),
		playerIsFighting = hasCondition(cid, CONDITION_INFIGHT)
	}

	if config.bankSystemEnabled == true then
		if config.playerIsFighting == false then
			local m = tonumber(param)
			if(string.lower(param) == "all") then
				m = getPlayerMoney(cid)
			elseif(param == "") then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Tutorial: /deposit (amount) or /deposit all")
				return true
			end

			if(not m) then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Tutorial: /deposit (amount) or /deposit all")
				return true
			end
			
			m = math.abs(m)
			if m <= getPlayerMoney(cid) then
				doPlayerDepositMoney(cid, m)
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Alright, you have added the amount of " .. m .. " gold to your balance. You can withdraw your money anytime you want to. Your account balance is " .. getPlayerBalance(cid) .. ".")
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You do not have enough money.")
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
