local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)

local arr = {
{1, 1, 1},
{1, 3, 1},
{1, 1, 1},
{0, 0, 0},
{0, 0, 0},
{0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
