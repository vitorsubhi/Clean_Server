dofile("./_woe.lua")

function onSay(cid, words, param)
	if not Woe.isRegistered(cid) then
		if getPlayerGuildId(cid) > 0 then
			setPlayerStorageValue(cid, stor.register, 1)
		else
			doPlayerSendCancel(cid, "No guild.")
		end
	else
		doPlayerSendCancel(cid, "Already registered.")
	end
	return true
end
