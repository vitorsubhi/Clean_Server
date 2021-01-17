local config = {
	loginMessage = getConfigValue('loginMessage'),
	useFragHandler = getBooleanFromString(getConfigValue('useFragHandler'))
}

function onLogin(cid)
	local loss = getConfigValue('deathLostPercent')
	if(loss ~= nil) then
		doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, loss * 10)
	end

	db.query("UPDATE `players` SET `online` = '1' WHERE `name` = \"" .. getPlayerName(cid) .. "\"")

	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
	end
	
	if(getPlayerStamina(cid) < 1) then
		setPlayerStamina(cid, 1)
	end
	
	if(config.useFragHandler) then
		registerCreatureEvent(cid, "Skull_Check")
	end

	local accountManager = getPlayerAccountManager(cid)
	if(accountManager == MANAGER_NONE) then
		local lastLogin, str = getPlayerLastLoginSaved(cid), config.loginMessage
		if(lastLogin > 0) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
			str = "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. "."
		else
			str = str .. " Please choose your outfit."
			doPlayerSendOutfitWindow(cid)
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
	elseif(accountManager == MANAGER_NAMELOCK) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Hello, it appears that your character has been namelocked, what would you like as your new name?")
	elseif(accountManager == MANAGER_ACCOUNT) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Hello, type 'account' to manage your account and if you want to start over then type cancel'.")
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Hello, type 'account' to create an account or type 'recover' to recover an account.")
	end
	registerCreatureEvent(cid, "Player_Logout")

	registerCreatureEvent(cid, "Guild_Motd")
	registerCreatureEvent(cid, "Mail")
	registerCreatureEvent(cid, "Save_Report_Bug")
	registerCreatureEvent(cid, "Idle")
	registerCreatureEvent(cid, "Skull_Check")
	registerCreatureEvent(cid, "Advance_Save")
	
	registerCreatureEvent(cid, "Points_Trade")
	registerCreatureEvent(cid, "Trade_Check")
	
	
	registerCreatureEvent(cid, "Stamina")

	registerCreatureEvent(cid, "FlyMove")
	registerCreatureEvent(cid, "FlyLogout")
	registerCreatureEvent(cid, "FlyAttack")
	

	registerCreatureEvent(cid, "PvP_Channel")
	
	--registerCreatureEvent(cid, "Vip_Exp")
	--registerCreatureEvent(cid, "End_Vip")
	
	--registerCreatureEvent(cid, VipReceive)
	--registerCreatureEvent(cid, "PlayerKill")
	--registerCreatureEvent(cid, "tradeCheck")
	return true
end

