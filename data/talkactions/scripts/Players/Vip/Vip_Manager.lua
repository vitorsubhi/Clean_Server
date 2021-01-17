function onSay(cid, words, param)
	if param == "" then
		return  doPlayerPopupFYI(cid,"---------------------\nAdd Vip: /vipmanager add days Name\n---------------------\nDelete Vip: /vipmanager del Name\n---------------------\nSee Vip: /vipmanager see Name\n---------------------")
	end

	if param:lower():find('add') == 1 and 3 then
		local _,_,id,name = param:lower():find('add (%d+) (.+)')
		name = name or ""
		id = tonumber(id or 1) or 1
		if tonumber(id) == nil or getPlayerByName(name) == false then
		   return doPlayerSendTextMessage(cid,25,"Add Vip: /vipmanager add days Name")
		end  
		if isPlayer(getPlayerByName(name)) == TRUE then
			vip.addVipByAccount(getPlayerAccount(getPlayerByName(name)) ,vip.getDays(id))
			doPlayerSendTextMessage(cid,25,"You have added "..tonumber(id).." vip day(s) to "..name..".")
			doPlayerSendTextMessage(getPlayerByName(name),25,"You received "..tonumber(id).." vip day(s).")
		else
			doPlayerSendTextMessage(cid,25, "A player with this name is not online, or not exists.")
		end
	elseif param:lower():find('del') == 1 and 3 then
		local _,_,name = param:lower():find('del (.+)')
		if getPlayerByName(name) == false then
			return doPlayerSendTextMessage(cid,25,"Delete Vip: /vipmanager del Name")
		end

		vip.setVipByAccount(getPlayerAccount(getPlayerByName(name)),-os.time())
		doPlayerSendTextMessage(cid,25,"You had removed "..name.."'s Vip.")                                                                                                                                               
	elseif param:lower():find('see') == 1 and 3 then
		local _,_,name = param:lower():find('see (.+)')
		name = name or ""
		if getPlayerByName(name) == false then
			return doPlayerSendTextMessage(cid,25,"See Vip: /vipmanager see Name")
		end
			
		local ret_ = vip.getVip(getPlayerByName(name))
		if ret_ == 0 then
			return doPlayerPopupFYI(cid,"A player with this name does not have Vip.")
		else
			return doPlayerPopupFYI(cid, "The vip ends in "..os.date("%d %B %Y %X ",ret_))
		end
	end
	return true
end