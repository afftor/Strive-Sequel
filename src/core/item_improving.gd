extends Reference

#Raising a piece of gear to a better quality. It used to be paid for on the spot with more gear of
#the same kind; it is a workshop order now, paid for in gold and in the work of whoever stands in
#the workshop that makes such gear, one quality at a time (game_res.add_improve_task). Unique
#pieces ask for materials as well. The numbers below are the whole price list.

const QUALITIES = ['poor', 'average', 'good', 'epic', 'legendary']
#Gear made to a recipe pays each step: how much the step raises the price multiplier
#(Items.ModularEconomy.PRICE_QUALITY_MULTIPLIERS - 0.15, 0.10, 0.20, 0.30) x what its materials are
#worth x GOLD_K. The price that step adds is the same rise x the piece's price, which grows faster
#than its materials do (price = materials x (1 + materials / 200)), so a step pays for itself at
#materials worth 200 x (GOLD_K - 1) and gains more, for each unit of work, the finer the piece.
const GOLD_K = 2.0
#Each step's gold for a unique piece, as a share of its list price.
const UNIQUE_STEP_GOLD = {average = 0.3, good = 0.5, epic = 0.8, legendary = 1.2}
#What each step of a unique piece asks for in materials on top of its gold and work lives beside the
#stats it reaches: Items.fixed_quality_stats[piece][quality].improve_materials. Gear made to a recipe
#is paid in gold alone, and a level without that key costs no materials. A piece's lowest quality is
#only ever a step for one that came without any quality.
const MATERIALS_KEY = 'improve_materials'
#A step's work, in multiples of what making the item takes - for modular gear that is the work its
#own materials ask for (Items.get_recipe_workunits), so a mithril blade takes longer than an iron one.
const STEP_WORK = {average = 1.0, good = 1.25, epic = 1.5, legendary = 2}
#The least a recipe counts as when its work is multiplied, so a dagger is not reforged in an hour.
const MIN_RECIPE_WORK = 3.0
#Pieces nobody can make have no recipe to be measured by: their work is this, scaled by STEP_WORK.
const UNIQUE_WORK = 12.0
#The workshop for a piece with no recipe of its own, by the kind of gear it is.
const GEARTYPE_JOB = {
	sword = 'smith', spear = 'smith', axe = 'smith', mace = 'smith', dagger = 'smith', heavy = 'smith', tool = 'smith',
	medium = 'tailor', cloth = 'tailor', bow = 'tailor', staff = 'alchemy',
}


#The same rule the old improve screen kept: crafted gear, and the unique pieces that carry a stat
#table per quality. Legendary gear is listed too - it is shown as finished rather than hidden.
static func improvable(item):
	if item == null or item.type != 'gear' or item.amount <= 0:
		return false
	if Items.fixed_quality_stats.has(item.itembase):
		return true
	return item.tags.has('recipe')


static func items_for(job):
	var res = []
	for id in ResourceScripts.game_res.items:
		var item = ResourceScripts.game_res.items[id]
		if improvable(item) and job_of(item) == job:
			res.append(id)
	return res


#The workshop that improves a piece is the one that makes it: a sword goes to the forge, a robe or a
#bow to the tailor, a staff to the alchemist.
static func job_of(item):
	if Items.recipes.has(item.itembase):
		return Items.recipes[item.itembase].worktype
	return GEARTYPE_JOB.get(str(item.geartype), 'smith')


static func ladder(item):
	if !Items.fixed_quality_stats.has(item.itembase):
		return QUALITIES.duplicate()
	var res = []
	var table = Items.fixed_quality_stats[item.itembase]
	for quality in QUALITIES:
		if table.has(quality) and !table[quality].empty():
			res.append(quality)
	return res


#Gear made before qualities existed has none; it stands where Poor stands.
static func current(item):
	return 'poor' if item.quality in ['', null] else item.quality


static func next_quality(item):
	var steps = ladder(item)
	var at = steps.find(current(item))
	if at < 0 or at + 1 >= steps.size():
		return null
	return steps[at + 1]


static func steps_to(item, target):
	var steps = ladder(item)
	var from = steps.find(current(item))
	var to = steps.find(target)
	if to <= from:
		return []
	return steps.slice(from + 1, to)


static func step_cost(item, quality):
	var work = UNIQUE_WORK * STEP_WORK.get(quality, 1.0)
	var gold = float(Items.itemlist[item.itembase].get('price', 0)) * UNIQUE_STEP_GOLD.get(quality, 0.5)
	if Items.recipes.has(item.itembase):
		work = max(MIN_RECIPE_WORK, float(Items.get_recipe_workunits(item.itembase, priced_parts(item)))) * STEP_WORK.get(quality, 1.0)
		gold = price_rise(quality) * material_value(item) * GOLD_K
	var materials = {}
	if Items.fixed_quality_stats.has(item.itembase):
		materials = Items.fixed_quality_stats[item.itembase].get(quality, {}).get(MATERIALS_KEY, {}).duplicate()
	return {gold = int(max(1, ceil(gold))), materials = materials, work = stepify(work, 0.1)}


#How much a step raises the price multiplier of crafted gear: from the quality below it.
static func price_rise(quality):
	var at = QUALITIES.find(quality)
	if at <= 0:
		return 0.0
	var multipliers = Items.ModularEconomy.PRICE_QUALITY_MULTIPLIERS
	return float(multipliers[quality] - multipliers[QUALITIES[at - 1]])


#What the materials of a crafted piece are worth: its parts for modular gear, the recipe's
#ingredients for gear made to a fixed recipe.
static func material_value(item):
	var recipe = Items.recipes[item.itembase]
	if recipe.crafttype == 'modular':
		return float(Items.get_modular_material_cost(item.itembase, priced_parts(item)))
	var res = 0.0
	for code in recipe.materials:
		res += Items.materiallist[code].price * recipe.materials[code]
	return res


#The materials a modular piece is priced and worked by. Gear handed out whole - loot, rewards, a
#starting kit (globals.CreateGearItem with no parts) - has none, and would cost next to nothing to
#improve; it counts as made of the cheapest material each of its parts takes.
static func priced_parts(item):
	if item.parts is Dictionary and !item.parts.empty():
		return item.parts
	var res = {}
	var template = Items.itemlist[item.itembase]
	for part in template.get('parts', {}):
		var best = null
		for code in Items.partmaterials.get(part, {}):
			if !Items.materiallist.has(code):
				continue
			if best == null or Items.materiallist[code].price < Items.materiallist[best].price:
				best = code
		if best != null:
			res[part] = best
	return res


static func total_cost(item, steps):
	var res = {gold = 0, materials = {}, work = 0.0}
	for quality in steps:
		var cost = step_cost(item, quality)
		res.gold += cost.gold
		res.work += cost.work
		for code in cost.materials:
			res.materials[code] = res.materials.get(code, 0) + cost.materials[code]
	return res


static func can_pay(cost):
	return short_of(cost).empty()


#What the estate lacks to pay a step: 'gold', then the codes of the materials it has too little of.
static func short_of(cost):
	var res = []
	if ResourceScripts.game_res.money < cost.gold:
		res.append('gold')
	for code in cost.get('materials', {}):
		if ResourceScripts.game_res.materials.get(code, 0) < cost.materials[code]:
			res.append(code)
	return res


#The piece's stats at another quality, read off a copy so the real one is not touched.
static func stats_at(item, quality):
	if quality == current(item):
		return item.get_bonusstats()
	var copy = item.clone()
	copy.set_quality_level(quality)
	return copy.get_bonusstats()
