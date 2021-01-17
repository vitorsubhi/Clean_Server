local premio = {
	[1] = {item = 2160, count = 10}
}

local configs = {
        hours = 2,
        winners = 1
}

function onThink(interval, lastExecution)
	local p = getPlayersOnline()
	local winners = configs.winners

	if #p < winners then
		winners = #p
	end

	for i = 1, winners do
		local p = getPlayersOnline()
		local c, w = #p, #premio
		local d, e = math.random(c), math.random(w)
		local playerwin = p[d]
		doPlayerAddItem(playerwin, premio[e].item, premio[e].count)
		doBroadcastMessage("[" .. i .. "] Winner: " .. getCreatureName(playerwin) .. ", Reward: " .. premio[e].count .. "x " .. getItemNameById(premio[e].item) .. ", Congratulations!")
		if i == winners then
			doBroadcastMessage("[Lottery] Next lottery start in " .. configs.hours .. " hours.")
		end
		doSendMagicEffect(getThingPos(playerwin), 13)
	end

	return true
end
