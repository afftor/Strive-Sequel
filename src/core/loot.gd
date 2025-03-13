extends Reference

var data = preload('res://assets/data/loot_data.gd').new()

#loot output type
enum {LOUT_REWARD, LOUT_SHOP}


var loot_tables = data.loot_tables
var locks_data = data.locks_data


func get_reward(table_name, mul = 1) -> Dictionary:
	return process_loottable(table_name, LOUT_REWARD, mul)

func get_shop_list(table_name, mul = 1) -> Dictionary:
	return process_loottable(table_name, LOUT_SHOP, mul)

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

func merge_shop_dict(shopdict, add):
	for key in shopdict:
		if add.has(key):
			if shopdict[key] is Dictionary:
				#print("warning: shop list rewrites part's record for %s!" % key)
				if !(add[key] is Dictionary):
					assert(false, "and doing so with no Dict!")
					push_error("and doing so with no Dict!")
				shopdict[key] = add[key]
			else:
				shopdict[key] += add[key]
	for key in add:
		if !shopdict.has(key):
			shopdict[key] = add[key]

func is_record_restricted(record) -> bool:
	return (record.has('reqs') and !globals.checkreqs(record.reqs))

func is_record_unlucky(record) -> bool:
	return (record.has('chance') and randf() > record.chance)

func process_loottable(table_name, output_type, mul) -> Dictionary:
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
	
	return process_loottable_record(loot_tables[table_name], output_type, mul)


func process_loottable_record(record, output_type, mul) -> Dictionary:
	var output
	var merge_func
	var generate_func
	if output_type == LOUT_REWARD:
		output = {gold = 0, materials = {}, items = []}
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
	
	#recursive rules (amount-ignorant)
	if record.has('list'):
		for rec in record.list:
			var add_output = process_loottable_record(rec, output_type, mul)
			call(merge_func, output, add_output)
		return output
	
	if record.has('loot_table'):
		return process_loottable(record.loot_table, output_type, mul)
	
	#define amount
	var amount = 1
	if record.has('amount'):
		amount = record.amount
	elif record.has('min') and record.has('max'):
		amount = globals.rng.randi_range(record.min, record.max)
	amount *= mul
	
	if record.has('chance_per_unit'):
		var nominal = amount
		amount = 0
		for i in range(nominal):
			if randf() <= record.chance_per_unit:
				amount += 1
	
	if amount == 0:
		return output
	
	#recursive rules (amount-wise)
	if record.has('selector'):
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
			return output
		for i in range(amount):
			var number = input_handler.weightedrandom(array)
			var add_output = process_loottable_record(record.selector[number], output_type, 1)
			call(merge_func, output, add_output)
		return output
	
	#content generation
	var main_output = call(generate_func, record, amount)
	call(merge_func, output, main_output)
	
	return output

func generate_reward(record, amount) -> Dictionary:
	var output = {gold = 0, materials = {}, items = []}
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
				if record.has('by_quality'):#chests were working like this
					var newitem
					var quality = 'poor'
					if record.has('quality'):
						quality = record.quality
					if record.has('parts'):
						#not quite sure if it works correctly. There is an issue with quality assigning
						newitem = globals.CreateGearItemQuality(record.item, record.parts, quality)
					else:
						newitem = globals.CreateGearItem(record.item, {})
					output.items.append(newitem)
				else:#loot from enemies were working like this
					var parts
					if i_template.crafttype == 'basic':
						parts = {}
					elif record.has('parts'):
						parts = record.parts
					else: #shortcut - modular gear from defaut materials
						parts = ResourceScripts.game_progress.get_default_materials()
					output.items.append(globals.CreateGearItemLoot(record.item, parts))
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
				output.items.append(globals.CreateGearItemLoot(selected, mat_grade))
	return output

func generate_shop(record, amount) -> Dictionary:
	var output = {}
	if record.has('material'):
		output[record.material] = amount
	elif record.has('item'):
		var i_template = Items.itemlist[record.item]
		if i_template.has('parts'):
			if amount > 1:
				print("warning: shop list must creat more then one item with parts for %s!" % record.item)
			var materials = ResourceScripts.game_progress.get_default_materials()
			var parts = Items.get_materials_by_grade(materials, i_template.code)
			output[i_template.code] = parts
		elif i_template.type == 'gear':
			if !i_template.tags.has('recipe'): #either shouldn't happen yet
				output[record.item] = amount
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
