extends Reference

const BodyRites = preload("res://src/core/body_rites.gd")

#mana a level asks for when its data names no mana_cost: a point per this much capacity
const MANA_PER_CAPACITY = 5


static func items():
	var res = []
	for id in ResourceScripts.game_res.items:
		var item = ResourceScripts.game_res.items[id]
		if item.amount > 0 and item.get_e_capacity_max() > 0:
			res.append(id)
	return res


static func item(id):
	return ResourceScripts.game_res.items.get(id)


static func wearer(item):
	return item.get_owner() if item.owner != null else null


static func away(item):
	var person = wearer(item)
	return person != null and !BodyRites.is_present(person)


static func codes_for(item):
	var res = []
	for code in Items.enchantments:
		var data = Items.enchantments[code]
		if !data.has('reqs') or item.check_reqs(data.reqs):
			res.append(code)
	return res


static func top_level(code):
	return Items.enchantments[code].levels.size()


static func level(item, code):
	return int(item.enchants.get(code, 0))


static func capacity_at(code, lvl):
	return 0 if lvl <= 0 else int(Items.enchantments[code].levels[lvl].cap_cost)


static func mana_at(code, lvl):
	if lvl <= 0:
		return 0
	var entry = Items.enchantments[code].levels[lvl]
	return int(entry.get('mana_cost', int(entry.cap_cost) / MANA_PER_CAPACITY))


static func gold_at(code, lvl):
	return 0 if lvl <= 0 else int(Items.enchantments[code].levels[lvl].gold_cost)


static func raises(item, targets):
	var res = {}
	for code in targets:
		if int(targets[code]) > level(item, code):
			res[code] = int(targets[code])
	return res


static func cost(item, targets):
	var res = {capacity = 0, mana = 0, gold = 0}
	var picked = raises(item, targets)
	for code in picked:
		var from = level(item, code)
		res.capacity += capacity_at(code, picked[code]) - capacity_at(code, from)
		res.mana += mana_at(code, picked[code]) - mana_at(code, from)
		#a raised level costs its full gold, as Item.can_upgrade_enchant charges it
		res.gold += gold_at(code, picked[code])
	return res


static func can_curse(item):
	return item.curse == null


static func capacity(item, curse = ''):
	if curse == '' or !can_curse(item):
		return item.get_e_capacity_max()
	var copy = item.clone()
	copy.add_curse('stub_' + curse)
	return copy.get_e_capacity_max()


static func used_capacity(item):
	return item.get_e_capacity_max() - item.get_e_capacity()


#the stub curse only adds capacity: the real one is rolled by the rite and stays hidden until worn
static func preview(item, targets, curse = ''):
	var copy = item.clone()
	if curse != '' and can_curse(item):
		copy.add_curse('stub_' + curse)
	var picked = raises(item, targets)
	for code in picked:
		copy.add_enchant(code, picked[code], true)
	return copy


static func donors():
	return BodyRites.subjects()


static func valid_donors(donor_ids):
	return BodyRites.valid_donors(null, donor_ids)


static func problems(item, targets, curse, donor_ids):
	var res = []
	if away(item):
		res.append('away')
	if raises(item, targets).empty():
		res.append('nothing')
	var price = cost(item, targets)
	if used_capacity(item) + price.capacity > capacity(item, curse):
		res.append('capacity')
	if ResourceScripts.game_res.money < price.gold:
		res.append('gold')
	if BodyRites.collected(BodyRites.mana_shares(price.mana, valid_donors(donor_ids))) < price.mana:
		res.append('mana')
	return res


static func perform(item, targets, curse, donor_ids):
	var donors = valid_donors(donor_ids)
	if !problems(item, targets, curse, donors).empty():
		return null
	var price = cost(item, targets)
	var picked = raises(item, targets)
	var shares = BodyRites.mana_shares(price.mana, donors)
	var person = wearer(item)
	if item.amount > 1:
		item.amount -= 1
		item = item.clone()
		globals.AddItemToInventory(item, false)
	if person != null:
		person.unequip(item, false)
	if curse != '' and can_curse(item):
		item.apply_random_curse(curse)
	for code in picked:
		item.add_enchant(code, picked[code], true)
	ResourceScripts.game_res.money -= price.gold
	for id in shares:
		if shares[id] > 0:
			BodyRites.character(id).mana_update(-shares[id])
	if person != null and item.curse == null:
		person.equip(item)
	return item
