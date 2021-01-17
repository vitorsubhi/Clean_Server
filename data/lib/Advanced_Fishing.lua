_Lib_Monsters_Info = {
	water = {
		{'Water Elemental', storage = 90901, onlySpear = false, chance = 8000, mlevel = 300, fishing = 75, broadcast = false},
		{'Tyria', storage = 90902, onlySpear = false, chance = 5500, mlevel = 1000, fishing = 100, broadcast = false},
		{'Hydros', storage = 90903, onlySpear = false, chance = 6000, mlevel = 1000, fishing = 100, broadcast = false},
		{'Doctor Octagonapus', storage = 90904, onlySpear = false, chance = 5000, mlevel = 1000, fishing = 100, broadcast = false},
		{'Kingler', storage = 90905, onlySpear = false, chance = 4500, mlevel = 1000, fishing = 120, broadcast = false},
		{'Triton', storage = 90906, onlySpear = false, chance = 3000, mlevel = 2000, fishing = 120, broadcast = true},
		{'Jaws', storage = 90907, onlySpear = false, chance = 2000, mlevel = 3000, fishing = 130, broadcast = true},
		{'Kratos', storage = 90908, onlySpear = true, chance = 3000, mlevel = 3500, fishing = 140, broadcast = true},
		{'Aegaeus', storage = 90909, onlySpear = true, chance = 1000, mlevel = 4000, fishing = 145, broadcast = true},
		{'Aekre', storage = 90910, onlySpear = true, chance = 800, mlevel = 5000, fishing = 150, broadcast = true},
		{'Sobek', storage = 90911, onlySpear = true, chance = 500, mlevel = 6000, fishing = 160, broadcast = true},
		{'Blastoise', storage = 90912, onlySpear = true, chance = 250, mlevel = 7000, fishing = 165, broadcast = true}
	},
	lava = {
		{'Fire Elemental', storage = 6666, onlySpear = true, chance = 8000, mlevel = 1000, fishing = 100, broadcast = false},
		{'Fire Devil', storage = 6666, onlySpear = true, chance = 5500, mlevel = 1000, fishing = 100, broadcast = false},
		{'Priton', storage = 6666, onlySpear = true, chance = 3000, mlevel = 1000, fishing = 120, broadcast = true},
		{'Fyria', storage = 6666, onlySpear = true, chance = 5500, mlevel = 1000, fishing = 120, broadcast = true},
		{'Pyria', storage = 6666, onlySpear = true, chance = 3000, mlevel = 4000, fishing = 140, broadcast = true},
		{'Krakatoa', storage = 6666, onlySpear = true, chance = 800, mlevel = 4500, fishing = 150, broadcast = true},
		{'Montoise', storage = 6666, onlySpear = true, chance = 250, mlevel = 7000, fishing = 165, broadcast = true}
	}
}

_Lib_Fishing_Config = {
	number = 100000,
	rateSkill = getConfigValue("rateSkill"),
	allowFromPz = false,
	useBait = false,
	fishes = true,
	maxfishes = 3,
	exhausted = false,
	exStorage = 6666,
	exTime = 3,
	broadcastAll = false,
	item = {
		rod = 2580,
		spear = 3964
	}
}

function subrange(t, first, last)
  local sub = {}
  for i=first,last do
    sub[#sub + 1] = t[i]
  end
  return sub
end

function getMaxWater(cid, item)
	for anmonster in ipairs(_Lib_Monsters_Info.water) do
		if (getPlayerSkill(cid, SKILL_FISHING) < _Lib_Monsters_Info.water[anmonster].fishing) or (getPlayerLevel(cid) < _Lib_Monsters_Info.water[anmonster].mlevel) or ((_Lib_Monsters_Info.water[anmonster].onlySpear) and (item ~= _Lib_Fishing_Config.item.spear)) then
			return (anmonster-1)
		end
	end
	return table.getn(_Lib_Monsters_Info.water)
end

function getFishingWater(xyz)
	if xyz == 0 then
		return 0
	end
	local nchance = 0
	for anmonster in ipairs(subrange(_Lib_Monsters_Info.water, 1, xyz)) do
		nchance = nchance + _Lib_Monsters_Info.water[anmonster].chance
	end
	local auxpc = math.random(1, nchance)
	for anmonster in ipairs(_Lib_Monsters_Info.water) do
		auxpc = auxpc - _Lib_Monsters_Info.water[anmonster].chance
		if auxpc <= 0 then
			return anmonster
		end
	end
end

function getMaxLava(cid, item)
	for anmonster in ipairs(_Lib_Monsters_Info.lava) do
		if (getPlayerSkill(cid, SKILL_FISHING) < _Lib_Monsters_Info.lava[anmonster].fishing) or (getPlayerLevel(cid) < _Lib_Monsters_Info.lava[anmonster].mlevel) or ((_Lib_Monsters_Info.lava[anmonster].onlySpear) and (item ~= _Lib_Fishing_Config.item.spear)) then
			return (anmonster-1)
		end
	end
	return table.getn(_Lib_Monsters_Info.lava)
end

function getFishingLava(xyz)
	if xyz == 0 then
		return 0
	end
	local nchance = 0
	for anmonster in ipairs(subrange(_Lib_Monsters_Info.lava, 1, xyz)) do
		nchance = nchance + _Lib_Monsters_Info.lava[anmonster].chance
	end
	local auxpc = math.random(1, nchance)
	for anmonster in ipairs(_Lib_Monsters_Info.lava) do
		auxpc = auxpc - _Lib_Monsters_Info.lava[anmonster].chance
		if auxpc <= 0 then
			return anmonster
		end	
	end
end
