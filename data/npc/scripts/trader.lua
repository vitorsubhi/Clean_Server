local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)            npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)            npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                    npcHandler:onThink()                    end

function creatureSayCallback(cid, type, msg) 
	if(not npcHandler:isFocused(cid)) then 
		return false 
	end 
	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
	local shopWindow = {}
	local t = {
	[2195] = 1,
	[2493] = 25,
	[2361] = 30,
	[8851] = 20,
	[8925] = 30,
	[2640] = 50,
	[2494] = 100,
	[9932] = 50,
	[2472] = 70,
	[8931] = 100
	}
	local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
		if t[item] and getAccountPoints(cid) < t[item] or getPlayerMoney(cid) < t[item] then
			selfSay("You need "..t[item].." Collapser Orbs and 1 gold coin to buy this item.", cid)
		else
			doAccountRemovePoints(cid, t[item])
			doPlayerAddItem(cid, item)
			selfSay("Here your item!", cid)
		end
		return true
	end

	if (msgcontains(msg, 'trade'))then
		for var, ret in pairs(t) do
			table.insert(shopWindow, {id = var, subType = 0, buy = 1, sell = 0, name = getItemNameById(var) .. ": " .. ret .. " orbs"})
		end
		openShopWindow(cid, shopWindow, onBuy, onSell)
	elseif (msgcontains(msg, 'orb'))then
		selfSay("Collaper Orbs is a donate reward, that you can use to improve your equipments.",cid)
	elseif (msgcontains(msg, 'power')) then
		selfSay("So, do you wanna power?", cid)
		selfSay("{Teleport}, it is an power provided by GOD that allows caster to teleport.",cid)
		selfSay("{Promote}, it is an power provided by GOD that amplifies the caster power.",cid)
	elseif (msgcontains(msg, 'teleport')) then
		selfSay("Do you want to learn {teleport} for 2 Collapser Orbs?", cid)
		talkState[talkUser] =  1		
	elseif (msgcontains(msg, 'yes')) then
		if (getAccountPoints(cid) >= 2) then
			if (getPlayerStorageValue(cid, 1) == -1) then
				doAccountRemovePoints(cid, 2)	
				setPlayerStorageValue(cid, 1, 1)
				selfSay("Here you are, now you can teleport", cid)
			else
				selfSay("You already knows how to {teleport}.", cid)
			end
			
		else
			selfSay("You need 2 Collapser Orbs to learn {teleport}.", cid)
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
