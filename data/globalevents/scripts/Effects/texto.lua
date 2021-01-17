local config = {
    positions = {
        ["Coll Citys"] = { x = 75, y = 473, z = 12 },
        ["Ice Town"] = { x = 71, y = 473, z = 12 },
        ["Canoe Isl"] = { x = 67, y = 473, z = 12 },
        ["2.5kQuest"] = { x = 63, y = 473, z = 12 },
        ["Inf Point"] = { x = 56, y = 477, z = 12 },
        ["Depot"] = { x = 56, y = 481, z = 12 },
        ["Zaran"] = { x = 59, y = 488, z = 12 },
        ["Bosses"] = { x = 63, y = 488, z = 12 },
        ["Hellhound"] = { x = 67, y = 488, z = 12 },
        ["Hill"] = { x = 71, y = 488, z = 12 },
        ["Castle Twn"] = { x = 75, y = 488, z = 12 },
        ["Quest Coll"] = { x = 59, y = 473, z = 12 },
        ["Borea"] = { x = 56, y = 485, z = 12 }
    }
}

function onThink(cid, interval, lastExecution)
    for text, pos in pairs(config.positions) do
        doSendAnimatedText(pos, text, math.random(1, 255))
    end
    
    return true
end  
