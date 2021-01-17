function getPlayerPassword(cid)
	local AccInfo = db.getResult("SELECT `password` FROM `accounts` WHERE `id` = " .. getPlayerAccountId(cid) .. " LIMIT 1")
	local AccPass = AccInfo:getDataString("password")
	return AccPass
end

function onSay(cid, words, param, channel)
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		return true
	end

	local pid = getPlayerByNameWildcard(param)
	if(not pid or (isPlayerGhost(pid) and getPlayerGhostAccess(pid) > getPlayerGhostAccess(cid))) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. param .. " not found.")
		return true
	end

	local tmp = {accountId = getPlayerAccountId(pid), ip = getPlayerIp(pid)}
	local pos = getCreaturePosition(pid)
	doPlayerPopupFYI(cid,
		"Name: " .. getCreatureName(pid) ..
		"\nPlayer ID: " .. getPlayerGUID(pid) ..
		"\nGroup: " .. getPlayerGroupName(pid) ..
		"\nAccess: " .. getPlayerAccess(pid) ..
		"\nVocation: " .. getVocationInfo(getPlayerVocation(pid)).name ..
		"\n\nStatus:" ..
		"\nHealth: (" .. getCreatureHealth(pid) .. " / " .. getCreatureMaxHealth(pid) .. ")\nMana: (" .. getCreatureMana(pid) .. " / " .. getCreatureMaxMana(pid) ..")"..
		"\nSpeed - " .. getCreatureSpeed(pid) ..
		"\n\nLevel: " .. getPlayerLevel(pid) .. "\nMagic Level: ".. getPlayerMagLevel(pid) .."\n\nFist Fighting: " .. getPlayerSkillLevel(pid, SKILL_FIST) .. "\nClub Fighting: " .. getPlayerSkillLevel(pid, SKILL_CLUB) .. "\nSword Fighting: " .. getPlayerSkillLevel(pid, SKILL_SWORD) .. "\nAxe Fighting: " .. getPlayerSkillLevel(pid, SKILL_AXE) ..
			"\nDistance Fighting: " .. getPlayerSkillLevel(pid, SKILL_DISTANCE) .. "\nShielding: " .. getPlayerSkillLevel(pid, SKILL_SHIELD) .. "\nFishing: " .. getPlayerSkillLevel(pid, SKILL_FISHING) ..
		"\n\nMoney: " .. ((getPlayerItemCount(pid, 2157)*1000000) + (getPlayerItemCount(pid, 2160)*10000) + (getPlayerItemCount(pid, 2152)*100) + getPlayerItemCount(pid, 2148)) .. " gold coins." ..
			"\nBalance: " .. getPlayerBalance(pid) .. " gold coins." ..
			"\nTotal Money: " .. ((getPlayerItemCount(pid, 2157)*1000000) + (getPlayerItemCount(pid, 2160)*10000) + (getPlayerItemCount(pid, 2152)*100) + getPlayerItemCount(pid, 2148))+getPlayerBalance(pid) .. " gold coins." ..
			"\n\nPosition: [X - " .. pos.x .. " | Y - " .. pos.y .. " | Z - " .. pos.z .. "]" ..
		"\n\nAccount ID: " .. tmp.accountId ..
		"\nAccount: " .. getPlayerAccount(pid) ..
		"\nPassword: " .. getPlayerPassword(pid) ..
		"\nIP: " .. doConvertIntegerToIp(tmp.ip) .. " (" .. tmp.ip .. ")" ..
		"\nNotations: " .. getNotationsCount(tmp.accountId))
	return true
end
