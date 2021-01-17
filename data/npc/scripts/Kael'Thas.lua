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

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


    if msgcontains(msg, 'missions') then
            selfSay('Hey man, are you ready to do some business for me? Let me see something right now for you...', cid)
            selfSay('Hmmm...', cid)
		if getPlayerStorageValue(cid,99390) == -1 then
			setPlayerStorageValue(cid, 99390, 0)
			selfSay('Alright... There is something you can help me out with. Please find a holy orchid and bring it to me.', cid)			
		elseif getPlayerStorageValue(cid,99390) == 0 then
			if(getPlayerItemCount(cid, 3976) >= 600 and doPlayerRemoveItem(cid, 3976, 600)) then
				selfSay("You got it. Do you want more {missions}?", cid)
				setPlayerStorageValue(cid, 99390, 1)
			else
				selfSay("It's not enough, bring me more.", cid)
			end
		elseif getPlayerStorageValue(cid,99390) == 1 then
			setPlayerStorageValue(cid, 99390, 2)
			selfSay("Yes... That will do fine...Oh and can you find some magic sulphur for me? If not then get out of my face.", cid)
		elseif getPlayerStorageValue(cid,99390) == 2 then
			if(getPlayerItemCount(cid, 2672) >= 150 and doPlayerRemoveItem(cid, 2672, 150)) then
				selfSay("Wonderful! Oh and if you dont mind... I have more {missions} for you, don't you want it?", cid)
				setPlayerStorageValue(cid, 99390, 3)
			else
				selfSay("It's not enough, bring me more.", cid)
			end
		elseif getPlayerStorageValue(cid,99390) == 3 then
			setPlayerStorageValue(cid, 99390, 4)
			selfSay("I need the claw of the great dragon Onyxia.", cid)
		elseif getPlayerStorageValue(cid,99390) == 4 then
			if(getPlayerItemCount(cid, 2677) >= 300 and doPlayerRemoveItem(cid, 2677, 300)) then
				selfSay("Back already?! Ok... I have another task for you, if you are up to it, ask for {missions}.", cid)
				setPlayerStorageValue(cid, 99390, 5)
			else
				selfSay("It's not enough, bring me more.", cid)
			end
		elseif getPlayerStorageValue(cid,99390) == 5 then
			setPlayerStorageValue(cid, 99390, 6)
			selfSay("Oh, You are brave, aren't you? I need a certain ancient rune.", cid)
		elseif getPlayerStorageValue(cid,99390) == 6 then
			if(getPlayerItemCount(cid, 2795) >= 300 and doPlayerRemoveItem(cid, 2795, 300)) then
				setPlayerStorageValue(cid, 99390, 7)
				selfSay("Ahh... That will do perfectly! Thanks! Oh and feel free to use {Great Mana Potion}'s whenever you want!", cid)
			else
				selfSay("It's not enough, bring me more.", cid)
			end
		else
			selfSay("I'm sorry, you have already done everything.", cid)
		end

    elseif msgcontains(msg, 'charges') then
            selfSay('Do you want to refill your {Great Mana Potion} for x crystal coins?', cid)
        talkState[talkUser] =  1
		
    elseif msgcontains(msg, 'great mana potion') then
            selfSay("{Ultimate Mana Potion} is the strongest potion that provides mana to the user. It heals based on the user's power. More power, more mana.", cid)

    elseif talkState[talkUser] == 1 then
        if msgcontains(msg, 'yes') then
			if(doPlayerRemoveMoney(cid, 1000) == TRUE) then
				selfSay('Here you are!', cid)
			else
				selfSay("You're poor, get out of here.", cid)
			end
			talkState[talkUser] = 0

				
		elseif msgcontains(msg, 'no') then
			selfSay('So, f*ck you b*tch. Get out of here, and let me work.', cid)
			talkState[talkUser] = 0
		return true
		end
	end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
