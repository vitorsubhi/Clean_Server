function onSay(cid, words, param)
         if vip.hasVip(cid) == TRUE then
            doPlayerSendTextMessage(cid, 22, "Your Vip ends in "..os.date("%d %B %Y %X ",vip.getVip(cid)))
         else
             if vip.getVip(cid) ~= 0 then
                doPlayerSendTextMessage(cid, 22, "You're not a Vip anymore. Your Vip has finished in "..os.date("%d %B %Y %X ", vip.getVip(cid)))
             else
                doPlayerSendTextMessage(cid, 22, "You're not a Vip Player.")
             end
         end
         return TRUE
end