news = {"Server News:\n-------------------------------------------------"}
function onSay(cid, words, param)
local str = ""
        local t = string.explode(param, ",")
        if t[1] == "add" then
		if (getPlayerGroupId(cid) == 10) then
			db.query("INSERT INTO `collapser_news`(`title`, `creator`, `date`, `text`, `html`) VALUES ('"..t[2].."','"..getPlayerName(cid).."', now(), '"..t[3].."',0);");
		end
        else
		local res = db.getResult("SELECT `title`, `text`, `creator` FROM `collapser_news` ORDER BY `date` DESC LIMIT 10;")	
                if res:getID() ~= -1 then
			repeat	
				str = str .. res:getDataString("title") .. "\n" .. res:getDataString("text") .."\nWritten by: ".. res:getDataString("creator") .."\n------------------------------------------------"
			until not res:next()
		end
                doShowTextDialog(cid, 2580, str)
        end
return true
end

