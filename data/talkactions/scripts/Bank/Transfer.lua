function onSay(cid, words, param)

	local config = {
		bankSystemEnabled = getBooleanFromString(getConfigInfo('bankSystem')),
		playerIsFighting = hasCondition(cid, CONDITION_INFIGHT)
	}

	if config.bankSystemEnabled == true then
		if config.playerIsFighting == false then
			if(param == "") then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Tutorial: /transfer (nick), (amount) or /transfer (nick), all")
				return true
			end

			local t = string.explode(param, ",")
			if (string.lower(t[2]) == "all") then
				m = getPlayerBalance(cid)
			else
				m = math.abs(tonumber(t[2]))
			end
			if(not m) then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "No money specified.")
				return true
			end

			if m <= getPlayerBalance(cid) then
				if playerExists(t[1]) then
					doPlayerTransferMoneyTo(cid, t[1], m)
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You have transferred " .. m .. " gold to " .. t[1] .. ". Your account balance is " .. getPlayerBalance(cid) .. " gold.")

				else
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Player " .. t[1] .. " does not exist.")
				end
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "There is not enough gold on your account. Your account balance is " .. getPlayerBalance(cid) .. ". Please tell the amount of gold coins you would like to transfer.")
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
