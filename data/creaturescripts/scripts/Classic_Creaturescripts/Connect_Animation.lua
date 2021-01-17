function onLogin(cid)
	playerpos = getPlayerPosition(cid)
	if(not isPlayerGhost(cid)) then
		doSendAnimatedText(playerpos, "Welcome!", TEXTCOLOR_YELLOW)
	end
	return TRUE
end
