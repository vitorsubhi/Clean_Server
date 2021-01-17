local LIQUID_CONTAINERS = {1775, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015, 2023, 2031, 2032, 2033}
local OVENS = {1786, 1788, 1790, 1792}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.itemid == 2692 and isInArray(LIQUID_CONTAINERS, itemEx.itemid) and itemEx.type == 1) then
		doChangeTypeItem(item.uid, item.type - 1)
		doPlayerAddItem(cid, 2693, 1)
		doChangeTypeItem(itemEx.uid, item.type - item.type)
	elseif(itemEx.itemid == 1381) then
		doChangeTypeItem(item.uid, item.type - 1)
		doPlayerAddItem(cid, 2692, 1)
	elseif(itemEx.itemid == 2692) then
		doChangeTypeItem(item.uid, item.type - 1)
		doPlayerAddItem(cid, 2689, 1)
	else
		return false
	end

	return true
end
