extends Reference

var parent: WeakRef


#food
#'fed' is how many turns of food the character has left. it drops by 1 every turn they
#are around, and a meal tops it up by the food item's food_value. hitting 0 makes them
#eat - and starve if there is nothing they are allowed to eat
var fed = 0
#basic / refined / premium. derived from fame and value, see update_demand()
var food_demand = 'basic'
var food_love = ''
#food item code -> bool. false means the player forbade that item for this character
var food_filter = {}
var starvation = false
#code of the last meal and whether it fell short of the demand, used by the tooltips
var last_meal = ''
var last_meal_type = ''
var last_meal_poor = false


func get_racial_features(race):
	var race_template = races.racelist[race]
	var array = []
	for i in race_template.diet_love:
		array.append([i, race_template.diet_love[i]])
	food_love = input_handler.weightedrandom(array)


func process_chardata(data):
	get_racial_features(data.race)
	#advanced generation
	if data.has('diet_love'):
		var array = []
		for i in data.diet_love:
			array.append([i, data.diet_love[i]])
		food_love = input_handler.weightedrandom(array)
	#simple data processing
	if data.has('food_like'):
		food_love = data.food_like
	create()


func create():
	#everything edible is allowed until the player says otherwise
	food_filter.clear()
	for i in Items.materiallist.values():
		if i.type == 'food':
			food_filter[i.code] = true
	update_demand()


#old saves store the four-way priority filter and a hated food list, neither of which
#exist anymore. the toggles keep the one decision that still translates: forbidden food
func fix_old_save():
	if food_filter.has('disable') and food_filter.has('high'):
		var forbidden = []
		if food_filter.disable is Array:
			forbidden = food_filter.disable.duplicate()
		food_filter.clear()
		for i in Items.materiallist.values():
			if i.type == 'food':
				food_filter[i.code] = !forbidden.has(i.code)
	#food items added after the save was made
	for i in Items.materiallist.values():
		if i.type == 'food' and !food_filter.has(i.code):
			food_filter[i.code] = true
	for code in food_filter.keys():
		if !Items.materiallist.has(code) or Items.materiallist[code].type != 'food':
			food_filter.erase(code)
	if !(fed is int) or fed < 0:
		fed = 0
	#no update_demand() here - the stat containers are still mid-load. the first meal
	#after loading recomputes it anyway


#demand
func update_demand():
	var person = parent.get_ref()
	if person == null:
		return
	var res = 'basic'
	var fame = person.get_stat('fame')
	var value = person.get_stat('price')
	for tier in variables.food_demand_order:
		if variables.food_demand_by_fame.has(tier) and fame >= variables.food_demand_by_fame[tier]:
			res = tier
		if variables.food_demand_by_value.has(tier) and value > variables.food_demand_by_value[tier]:
			res = tier
	food_demand = res


#demand only actually matters at meal time, so tick() does not pay for it. ui that shows
#it for a single character refreshes it here instead - update_demand() reads 'price',
#which is far too expensive to recompute for every character every turn
func get_demand():
	update_demand()
	return food_demand


func get_demand_rank():
	return variables.food_demand_order.find(food_demand)


func get_food_rank(code):
	return variables.food_demand_order.find(Items.materiallist[code].demand)


func is_liked(code):
	if food_love == null or food_love == '':
		return false
	return Items.materiallist[code].tags.has(food_love)


#slaves eat what they are given
func ignores_demand():
	return parent.get_ref().get_stat('slave_class') in ['slave', 'slave_trained']


#does this meal fall short of what the character expects? refreshes the demand first, so
#it is safe to call from ui and one-off interactions
func is_below_demand(code):
	if ignores_demand():
		return false
	update_demand()
	return get_food_rank(code) < get_demand_rank()


#lower is better. demand is the main priority, liked food types the secondary one, and
#between two equally good options the cheaper tier wins
func get_food_priority(code, demand_rank, ignore_demand):
	var rank = get_food_rank(code)
	var res = rank
	if rank < demand_rank and !ignore_demand:
		res += 40
	if !is_liked(code):
		res += 20
	return res


func sort_meals(first, second):
	if first[1] != second[1]:
		return first[1] < second[1]
	return first[0] < second[0]


#allowed food, best choice first. priorities are worked out once per item rather than
#per comparison - this runs on every meal for every character
func build_meal_order():
	var demand_rank = get_demand_rank()
	var ignore_demand = ignores_demand()
	var scored = []
	for code in food_filter:
		if !food_filter[code]:
			continue
		if !Items.materiallist.has(code):
			continue
		scored.push_back([code, get_food_priority(code, demand_rank, ignore_demand)])
	scored.sort_custom(self, 'sort_meals')
	var res = []
	for rec in scored:
		res.push_back(rec[0])
	return res


#eating
func get_drain():
	#extra rations burn through food faster in exchange for productivity
	if parent.get_ref().has_work_rule('ration'):
		return variables.food_ration_drain
	return 1


func tick():
	var person = parent.get_ref()
	if person.check_trait('undead'):
		return
	#characters that are not around do not eat and do not get hungry
	if person.is_unavaliable():
		return
	fed -= get_drain()
	if fed > 0:
		return
	fed = 0
	get_food()
	person.reset_rebuild()


func get_food():
	var person = parent.get_ref()
	if person.check_trait('undead'):
		return
	update_demand()
	#a forager feeds themselves off the land, without touching the storage
	var forager = person.check_trait('forager')
	var meal = null
	for code in build_meal_order():
		if forager or ResourceScripts.game_res.materials[code] >= 1:
			meal = code
			break
	if meal == null:
		starve()
		return
	if !forager:
		ResourceScripts.game_res.materials[meal] -= 1
	consume(meal)


func consume(code):
	var person = parent.get_ref()
	var item = Items.materiallist[code]
	var value = item.food_value
	if is_liked(code):
		value = int(ceil(value * variables.food_liked_value_mod))

	fed += value
	last_meal = code
	last_meal_poor = get_food_rank(code) < get_demand_rank() and !ignores_demand()
	starvation = false
	#effects tick once per turn while 'fed' drops by get_drain(), so the meal is worth
	#fewer turns than its food_value whenever the character is on extra rations
#	var turns = int(ceil(float(value) / float(get_drain())))
	#a meal replaces whatever the previous one left behind
#	person.remove_all_temp_effects_tag('starvation')
#	person.remove_all_temp_effects_tag('food_buff')
#	person.remove_all_temp_effects_tag('food_demand_unmet')

	if item.has('food_buff'):
		last_meal_type = item.food_buff
#		person.apply_effect_code(item.food_buff, {duration = turns})
	else:
		last_meal_type = ''

	if last_meal_poor:
		#get_food() already refreshed the demand, so no need for is_below_demand() here
#		person.apply_effect_code('e_food_demand', {duration = turns})
		person.add_stat('respect', globals.rng.randi_range(
			variables.food_demand_respect[0], variables.food_demand_respect[1]))
		globals.text_log_add('char', tr("FOODLOGBELOWDEMAND") % [person.get_short_name(), item.name])


func starve():
	var person = parent.get_ref()
	starvation = true
#	person.remove_all_temp_effects_tag('starvation')
#	person.apply_effect_code('e_starve')
	person.add_stat('respect', variables.food_starve_respect)
	person.add_stat('affection', variables.food_starve_affection)
	globals.text_log_add('char', tr("FOODLOGSTARVE") % person.get_short_name())


#prediction / ui
#what the character's stomach currently looks like, for the slave list column. reads only
#stored state, so it is cheap enough to call for every row on every update
#	'undead'   - never eats
#	'starving' - failed to eat
#	'none'     - has not eaten yet, will take a meal on their next turn
#	'poor'     - fed, but the last meal was below their demand
#	'fed'      - fed on something acceptable
func get_state():
	if parent.get_ref().check_trait('undead'):
		return {state = 'undead', fed = 0, meal = ''}
	if starvation:
		return {state = 'starving', fed = 0, meal = last_meal}
	if fed <= 0 or !Items.materiallist.has(last_meal):
		return {state = 'none', fed = fed, meal = ''}
	return {state = 'poor' if last_meal_poor else 'fed', fed = fed, meal = last_meal}


func predict_food():
	if parent.get_ref().check_trait('undead'):
		return {}
	if parent.get_ref().check_trait('forager'):
		return {}
	var order = build_meal_order()
	if order.empty():
		return {}
	var code = order[0]
	var value = Items.materiallist[code].food_value
	if is_liked(code):
		value = int(ceil(value * variables.food_liked_value_mod))
	var res = {}
	res[code] = float(variables.HoursPerDay * get_drain()) / float(value)
	return res


func toggle_food(foodcode):
	if !food_filter.has(foodcode):
		food_filter[foodcode] = true
	food_filter[foodcode] = !food_filter[foodcode]


func get_filter_for_food(code):
	if !food_filter.has(code):
		return true
	return food_filter[code]
