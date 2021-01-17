local config = {
	infinitePotions = "yes",
	removeOnUse = "yes",
	usableOnTarget = "yes", -- can be used on target? (fe. healing friend)
	splashable = "no",
	realAnimation = "no", -- make text effect visible only for players in range 1x1
	healthMultiplier = 1.0,
	manaMultiplier = 1.0
}

config.removeOnUse = getBooleanFromString(config.removeOnUse)
config.usableOnTarget = getBooleanFromString(config.usableOnTarget)
config.splashable = getBooleanFromString(config.splashable)
config.realAnimation = getBooleanFromString(config.realAnimation)

local POTIONS = {
	[8704] = {empty = 7636, splash = 2, health = {50, 100}}, -- small health potion
	[7618] = {empty = 7636, splash = 2, health = {100, 200}}, -- health potion
	[7588] = {empty = 7634, splash = 2, health = {200, 400}, level = 50, vocations = {3, 4, 7, 8, 11, 12}, vocStr = "knights and paladins"}, -- strong health potion
	[7591] = {empty = 7635, splash = 2, health = {450, 550}, level = 80, vocations = {4, 8, 12}, vocStr = "knights"}, -- great health potion
	[8473] = {empty = 7635, splash = 2, health = {860, 890}, level = 130, vocations = {4, 8, 12}, vocStr = "knights"}, -- ultimate health potion

	[7620] = {empty = 7636, splash = 7, mana = {2, 3}},--{70, 130}}, -- mana potion
	[7589] = {empty = 7634, splash = 7, mana = {4, 5}},--mana = {110, 190}, level = 50, vocations = {1, 2, 3, 5, 6, 7, 9, 10, 11}, vocStr = "sorcerers, druids and paladins"}, -- strong mana potion
	[7590] = {empty = 7635, splash = 7, mana = {6, 7}},--mana = {350, 410}, level = 80,, vocations = {1, 2, 5, 6, 9, 10}, vocStr = "sorcerers and druids"}, -- great mana potion

	[8472] = {empty = 7635, splash = 3, health = {360, 450}, mana = {350, 390}, level = 80, vocations = {3, 7, 11}, vocStr = "paladins"} -- great spirit potion
}

local exhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, (getConfigInfo('timeBetweenExActions') - 100))

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local potion = POTIONS[item.itemid]
	if(not potion) then
		return false
	end

	if(not isPlayer(itemEx.uid) or (not config.usableOnTarget and cid ~= itemEx.uid)) then
		if(not config.splashable) then
			return false
		end

		if(toPosition.x == CONTAINER_POSITION) then
			toPosition = getThingPos(item.uid)
		end

		doDecayItem(doCreateItem(2016, potion.splash, toPosition))
		doTransformItem(item.uid, potion.empty)
		return true
	end

	if(hasCondition(cid, CONDITION_EXHAUST_HEAL)) then
		doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
		return true
	end

	if(((potion.level and getPlayerLevel(cid) < potion.level) or (potion.vocations and not isInArray(potion.vocations, getPlayerVocation(cid)))) and
		not getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES))
	then
		doCreatureSay(itemEx.uid, "Only " .. potion.vocStr .. (potion.level and (" of level " .. potion.level) or "") .. " or above may drink this fluid.", TALKTYPE_ORANGE_1)
		return true
	end

	local health = potion.health
	if(health) then
		local healing = math.ceil(math.random(health[1], health[2]) * config.healthMultiplier)
		doCreatureAddHealth(itemEx.uid, healing)
		doSendAnimatedText(getPlayerPosition(itemEx.uid),"+"..healing.."", TEXTCOLOR_GREEN)
	end

	local mana = potion.mana
	if (mana) then
		local healing = math.ceil(math.random(getPlayerMaxMana(cid)*(mana[1]/100)+(mana[1]*3),getPlayerMaxMana(cid)*(mana[2]/100)+(mana[2]*3))* config.manaMultiplier)
		doCreatureAddMana(itemEx.uid, healing)
		doSendAnimatedText(getPlayerPosition(itemEx.uid),"+"..healing.."", TEXTCOLOR_PURPLE)
	end
	doSendMagicEffect(getThingPos(itemEx.uid), CONST_ME_MAGIC_BLUE)

	doAddCondition(cid, exhaust)
	if(not potion.empty or config.removeOnUse) then
		if (not config.infinitePotions) then
			doRemoveItem(item.uid, 1)
		end
		return true
	end
	doRemoveItem(item.uid, 1)
     	doPlayerAddItem(cid, potion.empty, 1)
	return true
end
