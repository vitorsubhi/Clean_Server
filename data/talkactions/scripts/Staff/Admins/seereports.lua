--- Script by esK~---
--- Notice System 0.1 Beta ---
function onSay(cid, words, param)
file = io.open('data/reports.txt','r')
notice = file:read(-1)
doShowTextDialog(cid,7528,notice)
file:close()
return true
end