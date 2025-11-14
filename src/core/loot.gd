extends Reference

var data = preload('res://assets/data/loot_data.gd').new()

#loot output type
enum {LOUT_REWARD, LOUT_SHOP}


var loot_tables = data.loot_tables
var locks_data = data.locks_data

func get_rewards_template():
	return {gold = 0, materials = {}, items = []}

func get_quest_reward(table_name, quest) -> Dictionary:
	var features = {quest = quest}
	return process_loottable(table_name, LOUT_REWARD, features)

func get_reward(table_name, mul = 1) -> Dictionary:
	var features = {}
	if mul != 1: features.mul = mul
	return process_loottable(table_name, LOUT_REWARD, features)

func get_shop_list(table_name, mul = 1) -> Dictionary:
	var features = {}
	if mul != 1: features.mul = mul
	return process_loottable(table_name, LOUT_SHOP, features)

func merge_reward_dict(rewarddict, add):
	if add.has('gold'):
		rewarddict.gold += add.gold
	
	if add.has('materials'):
		for key in rewarddict.materials:
			if add.materials.has(key):
				rewarddict.materials[key] += add.materials[key]
		for key in add.materials:
			if !rewarddict.materials.has(key):
				rewarddict.materials[key] = add.materials[key]
	
	if add.has('items'):
		rewarddict.items.append_array(add.items)
	
	if add.has('spec_rules'):
		if !rewarddict.has('spec_rules'):
			rewarddict.spec_rules = []
		rewarddict.spec_rules.append_array(add.spec_rules)

func merge_shop_dict(shopdict, add):
	for key in shopdict:
		if add.has(key):
			if shopdict[key] is Array:
				if !(add[key] is Array):
					push_error("shop list trying to merge parts with no array. Item: %s, adding: %s" % [key, add[key]])
				shopdict[key].append_array(add[key])
			else:
				shopdict[key] += add[key]
	for key in add:
		if !shopdict.has(key):
			shopdict[key] = add[key]

func is_record_restricted(record) -> bool:
	return (record.has('reqs') and !globals.checkreqs(record.reqs))

func is_record_unlucky(record) -> bool:
	return (record.has('chance') and randf() > record.chance)

func process_loottable(table_name, output_type, features = {}) -> Dictionary:
	if !(table_name is String):
		assert(false, "process_loottable() error: All incoming loot params should be string from now on!")
		push_error("process_loottable() error: All incoming loot params should be string from now on!")
		return {}
	
	if table_name.empty():
#		print('warning: empty loottable')
		return {}
	
	if !loot_tables.has(table_name):
		print('error: wrong loottable %s' % table_name)
		return {}
	
	return process_loottable_record(loot_tables[table_name], output_type, features)


func process_loottable_record(record, output_type, features = {}) -> Dictionary:
	var output
	var merge_func
	var generate_func
	if output_type == LOUT_REWARD:
		output = get_rewards_template()
		merge_func = 'merge_reward_dict'
		generate_func = 'generate_reward'
	elif output_type == LOUT_SHOP:
		output = {}# "item_code : amount" or "item_code : {part's dict}"
		merge_func = 'merge_shop_dict'
		generate_func = 'generate_shop'
	
	#restrictions
	if is_record_restricted(record):
		return output
	
	if is_record_unlucky(record):
		return output
	
	#recursive rules
	var new_features = features
	var repeat = 0
	for recur_param in ['list', 'loot_table', 'selector']:
		if record.has(recur_param):
			
			#define repeat
			repeat = 1
			var repeat_min
			var repeat_max
			var repeat_omitted = true
			if record.has('repeat'):
				repeat = record.repeat
				repeat_omitted = false
			elif record.has('repeat_min') and record.has('repeat_max'):
				repeat_min = record.repeat_min
				repeat_max = record.repeat_max
				repeat_omitted = false
			var override
			if features.has("override"):
				override = features.override
			elif repeat_omitted and features.has("propagate"):
				override = features.propagate
			if override != null:
				repeat_min = null
				repeat_max = null
				if override.has('repeat'):
					repeat = override.repeat
				elif override.has('repeat_min') and override.has('repeat_max'):
					repeat_min = override.repeat_min
					repeat_max = override.repeat_max
			if repeat_min != null:
				repeat = globals.rng.randi_range(repeat_min, repeat_max)
			
			#register override
			var override_name
			if record.has('override'):
				override_name = 'override'
			elif record.has('propagate'):
				override_name = 'propagate'
			if override_name != null:
				new_features = features.duplicate()
				if new_features.has(override_name):
					new_features[override_name] = features[override_name].duplicate()
				else:
					new_features[override_name] = {}
				for key in record[override_name]:
					new_features[override_name][key] = record[override_name][key]
			
			break
	
	if record.has('list'):
		for i in range(repeat):
			for rec in record.list:
				var add_output = process_loottable_record(rec, output_type, new_features)
				call(merge_func, output, add_output)
		return output
	
	if record.has('loot_table'):
		for i in range(repeat):
			var add_output = process_loottable(record.loot_table, output_type, new_features)
			call(merge_func, output, add_output)
		return output
	
	if record.has('selector'):
		for i in range(repeat):
			var array = []
			for num in range(record.selector.size()):
				var subrecord = record.selector[num]
				if is_record_restricted(subrecord):
					continue
				if is_record_unlucky(subrecord):
					continue
				var weight = 1
				if subrecord.has('weight'):
					weight = subrecord.weight
				array.append([num, weight])
			if array.empty():
				continue
			
			var number = input_handler.weightedrandom(array)
			var subrecord = record.selector[number]
			if subrecord.has('chance'):
				subrecord = subrecord.duplicate(true)
				subrecord.erase('chance')
			var add_output = process_loottable_record(subrecord, output_type, new_features)
			call(merge_func, output, add_output)
		return output
	
	#define amount
	var amount = 1
	var amount_min
	var amount_max
	var amount_omitted = true
	if record.has('amount'):
		amount = record.amount
		amount_omitted = false
	elif record.has('min') and record.has('max'):
		amount_min = record.min
		amount_max = record.max
		amount_omitted = false
	var override
	if features.has("override"):
		override = features.override
	elif amount_omitted and features.has("propagate"):
		override = features.propagate
	if override != null:
		amount_min = null
		amount_max = null
		if override.has('amount'):
			amount = override.amount
		elif override.has('min') and override.has('max'):
			amount_min = override.min
			amount_max = override.max
	if amount_min != null:
		amount = globals.rng.randi_range(amount_min, amount_max)
	
	if record.has('chance_per_unit'):
		var nominal = amount
		amount = 0
		for i in range(nominal):
			if randf() <= record.chance_per_unit:
				amount += 1
	if amount == 0:
		return output
	
	if features.has('mul'):
		amount *= features.mul
	
	#content generation
	var main_output = call(generate_func, record, amount, features)
	call(merge_func, output, main_output)
	
	return output

func generate_reward(record, amount, features = {}) -> Dictionary:
	var output = get_rewards_template()
	if record.has('gold'):
		output.gold = amount
	if record.has('material'):
		output.materials[record.material] = amount
	elif record.has('item'):
		var i_template = Items.itemlist[record.item]
		if i_template.type == 'usable':
			output.items.append(globals.CreateUsableItem(record.item, amount))
		elif i_template.type == 'gear':
			for i in range(amount):
				var parts
				if i_template.has('crafttype') and i_template.crafttype == 'basic':
					parts = {}#mind, in this case no quality generated by default
				elif record.has('parts'):
					parts = record.parts
					if parts is Array:
						parts = input_handler.weightedrandom(parts)
				else: #shortcut - modular gear from defaut materials
					parts = ResourceScripts.game_progress.get_default_materials()
				var newitem
				if record.has('autoassign_quality'):
					#probably legacy code for chests
					#CreateGearItem() uses autoassign_quality() for quality
					#and has no_enchant by default
					newitem = globals.CreateGearItem(record.item, {})
				elif record.has('quality'):
					#CreateGearItemQuality() no_enchant is true by default
					newitem = globals.CreateGearItemQuality(record.item, parts, record.quality)
				elif features.has('quest'):
					newitem = globals.CreateGearItemQuest(record.item, parts, features.quest)
				else:
					newitem = globals.CreateGearItemLoot(record.item, parts, null,
						record.has('no_enchant') and record.no_enchant)
				output.items.append(newitem)
				#old double logic (record.by_quality for chests, and else for loot)
#				if record.has('by_quality'):#chests were working like this
#					var newitem
#					var quality = 'poor'
#					if record.has('quality'):
#						quality = record.quality
#					if record.has('parts'):
#						newitem = globals.CreateGearItemQuality(record.item, record.parts, quality)
#					else:
#						newitem = globals.CreateGearItem(record.item, {})
#					output.items.append(newitem)
#				else:#loot from enemies were working like this
#					var parts
#					if i_template.crafttype == 'basic':
#						parts = {}
#					elif record.has('parts'):
#						parts = record.parts
#					else: #shortcut - modular gear from defaut materials
#						parts = ResourceScripts.game_progress.get_default_materials()
#					output.items.append(globals.CreateGearItemLoot(record.item, parts))
		else:
			print('error: wrong itemtype at %s' % record.item)
	elif record.has('random'):
		if record.random == 'material':
			var material_name
			#-----old loot system
			if record.has('from_location'):
				var loc_res = input_handler.active_location.resources
				if loc_res is Array:
					material_name = input_handler.random_from_array(loc_res)
#			#---------------
			if material_name == null:
				var tier
				if record.has('from_location'):
					tier = input_handler.active_location.resources
				elif record.has('tier'):
					tier = record.tier
				else:
					tier = ResourceScripts.game_progress.get_default_materials()
				if !Items.material_tiers.has(tier):
					print("warning: insufficient tier '%s' in '%s'" % [tier, record])
					tier = ResourceScripts.game_progress.get_default_materials()
				material_name = input_handler.weightedrandom_dict(Items.material_tiers[tier])
			output.materials[material_name] = amount
		elif record.random == 'usable':
			var array = []
			for item in Items.itemlist.values():
				if (record.tiers.has(item.tier)
						&& item.type == 'usable'
						&& !item.tags.has('no_random')):
					array.append(item.code)
			var selected = input_handler.random_from_array(array)
			output.items.append(globals.CreateUsableItem(selected, amount))
		elif record.random == 'static_gear':
			var array = []
			for item in Items.itemlist.values():
				if (record.tiers.has(item.tier)
						&& item.has('geartype')
						&& item.geartype == 'costume'
						&& !item.tags.has('no_random')):
					array.append(item.code)
			for i in range(amount):
				var selected = input_handler.random_from_array(array)
				#CreateGearItem() has no_enchant by default
				output.items.append(globals.CreateGearItem(selected, {}))
		elif record.random in ['gear', 'weapon', 'armor']:
			var itemtype_list
			if record.random == 'gear':
				itemtype_list = ['weapon', 'armor']
			else:
				itemtype_list = [record.random]
			
			var array = []
			for item in Items.itemlist.values():
				if (record.tiers.has(item.tier)
						&& item.type == 'gear'
						&& item.itemtype in itemtype_list
						&& item.geartype != 'costume'
						&& !item.tags.has('no_random')):
					array.append(item.code)
			for i in range(amount):
				var mat_grade
				if record.has('material_tiers'):
					mat_grade = input_handler.weightedrandom(record.material_tiers)
				elif record.has('from_location'):
					mat_grade = input_handler.active_location.resources
				else:
					mat_grade = ResourceScripts.game_progress.get_default_materials()
				var selected = input_handler.random_from_array(array)
				output.items.append(globals.CreateGearItemLoot(selected, mat_grade, null,
					record.has('no_enchant') and record.no_enchant))
	elif record.has('spec_rule'):
		#output.spec_rules not added to template for now, due to rarity
		match record.spec_rule:
			'item_based_gold':
				output.spec_rules = [{
					rule = 'item_based_gold',
					mul = rand_range(record.range[0], record.range[1])
					}]
			_:
				push_error("unknown spec_rule in loot.gd for %s" % String(record))
	return output

func generate_shop(record, amount,  features = {}) -> Dictionary:
	var output = {}
	if record.has('material'):
		output[record.material] = amount
	elif record.has('item'):
		var i_template = Items.itemlist[record.item]
		if i_template.has('parts'):
			output[record.item] = []
			for i in range(amount):
				var materials = ResourceScripts.game_progress.get_default_materials()
				var parts = Items.get_materials_by_grade(materials, i_template.code)
				output[record.item].append(parts)
		elif i_template.type == 'gear':
			if !i_template.tags.has('recipe'):#"either shouldn't happen yet" - was here befor loot refactor
				output[record.item] = amount
			else:
				print("warning: shop list trying to creat item of 'gear' type, but with recipe for %s" % record.item)
		elif i_template.type == 'usable':
			output[record.item] = amount
	return output

func get_gather_mod(gather_set, mat):
	var res = get_gather_setting(gather_set, mat, 'mod')
	if res is Array:
		return globals.rng.randf_range(res[0], res[1])
	return res

func get_gather_stamina(gather_set, mat):
	var res = get_gather_setting(gather_set, mat, 'stamina')
	if res is Array:
		return globals.rng.randi_range(res[0], res[1])
	return res

func get_gather_setting(gather_set, mat, setting):
	if !data.gather_settings.has(gather_set):
		print("error in loot.gd: no such gather_set as %s" % gather_set)
		return [0,0]
	if !data.gather_settings[gather_set].has(mat):
		return data.gather_settings[gather_set]['_default'][setting]
	return data.gather_settings[gather_set][mat][setting]

func get_gather_mod_from_loc(loc, mat):
	#dict check very possibly is redundant
	if loc.gatherable_resources is Dictionary:#old loot system
		print("warning: gatherable_resources is Dictionary!")
		return loc.gatherable_resources[mat].gather_mod
	else:#(is String)
		return loc.gather_mods[mat]

#14 march 2025. Making this fix for old save games.
#In theory, with first update_area_shop() savegame will be fixed for good,
#thus this func is ought to become useless in few months after corresponding update
func try_fix_old_shop_parts(shop_dict, key):
	if shop_dict[key] is Array:
		return
	shop_dict[key] = [shop_dict[key]]


