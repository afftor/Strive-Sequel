extends Reference
class_name Item

var name = ""
var id
var itembase
var code
var icon
var description = ''
var stackable = false
#var inventory

#Useable data
var amount = 1 setget amount_set
var useeffects
var useskill

#Gear Data
var type
var itemtype
var toolcategory
var geartype
var subtype
var durability
var maxdurability
var price
var bonusstats = {} setget , get_bonusstats#bonus stats apply to chars
var parts = {}
var effects = []
var reqs = []
var task
var owner = null
var partcolororder
var broken = false
var tags = []
var materials = []
var weaponrange
var multislots = []
var slots = []
var hitsound
var interaction_use = false

var enchants = {}
var curse = null
var curse_known = false

var quality = ''


func clone():
	var res = dict2inst(inst2dict(self))
	res.id = null
	res.owner = null
	res.amount = 1
	res.enchants = enchants.duplicate()
	res.effects = effects.duplicate()
	return res


func check_reqs(arg):
	if typeof(arg) == TYPE_ARRAY:
		var check = true
		for i in arg:
			if i.has('orflag'):
				check = check or valuecheck(i)
			else:
				check = check and valuecheck(i)
		return check
	else:
		return valuecheck(arg)


func valuecheck(req):
	var i = req.duplicate()
	match i.code:
		'false':
			return false
		'stat':
#			if typeof(i.value) == TYPE_ARRAY: 
#				i.value = calculate_number_from_string_array(i.value)
			return input_handler.operate(i.operant, get(i.stat), i.value) == i.check
		'stat_in_set':
			return i.value.has(get(i.stat)) == i.check
		'stat_index':
#			if typeof(i.value) == TYPE_ARRAY: 
#				i.value = calculate_number_from_string_array(i.value)
			return input_handler.operate(i.operant, get(i.stat)[i.index], i.value) == i.check


func CreateUsable(ItemName = '', number = 1):
	type = 'usable'
	itembase = ItemName
	code = ItemName
	stackable = true
	amount = number
	var itemtemplate = Items.itemlist[ItemName]
	if itemtemplate.icon != null:
		icon = itemtemplate.icon.get_path()
	name = itemtemplate.name
	if itemtemplate.has("interaction_effect"):
		interaction_use = true
	itemtype = 'usable'
	description = itemtemplate.descript
	#itemtype = itemtemplate.itemtype
#	useeffects = itemtemplate.useeffects
#	useskill = itemtemplate.useskill
#	description = itemtemplate.description

func amount_set(value):
	amount = value
	if amount <= 0:
#		ResourceScripts.game_res.items.erase(id)
		ResourceScripts.game_res.call_deferred('remove_item_id', id)

func UseItem(user = null, target = null):
	var finaltarget
	for i in effects:
		var effect = Effectdata.effects[i]
		if i.taker == 'caster':
			if user == null:
				return
			finaltarget = user
		elif i.taker == 'target':
			if target == null:
				return
			finaltarget = target
		Effectdata.call(effect.effect, finaltarget, effect.value)


func build_quality_weighthes(diffdata = {boost = 0, prof = false, shop = false}):
	var res = {
		poor = 10000,
		average = 5000,
		good = 2500,
		epic = 500,
		legendary = 10
	}
	if !diffdata.has('prof'):
		diffdata.prof = false
	if !diffdata.has('shop'):
		diffdata.shop = false
	if !diffdata.has('boost'):
		diffdata.boost = 0
	
	res.poor -= 500 * diffdata.boost
	res.average -= 200 * diffdata.boost
	res.good += 300 * diffdata.boost
	res.epic += 100 * diffdata.boost
	res.legendary += 5 * diffdata.boost
	if res.poor < 100:
		res.poor = 100
	if res.average < 200:
		res.average = 200
	
	if  diffdata.prof:
		res.poor = 0
		
	if  diffdata.shop:
		res.good = 0
		res.epic = 0
		res.legendary = 0
	
	return res


func CreateGear(ItemName = '', dictparts = {}, diffdata = {boost = 0, prof = false, shop = false}):
	var mode = 'normal'
	if dictparts.size() == 0:
		mode = 'simple'
	itembase = ItemName
	bonusstats = {}
	stackable = false
	type = 'gear'
	var itemtemplate = Items.itemlist[ItemName]
	var tempname = itemtemplate.name

	geartype = itemtemplate.geartype
	if itemtemplate.has('weaponrange'):
		weaponrange = itemtemplate.weaponrange
	itemtype = itemtemplate.itemtype
	if itemtemplate.tags.has('tool'):
		toolcategory = itemtemplate.tool_category

	for i in itemtemplate.basestats:
		if bonusstats.has(i):
			bonusstats[i] += itemtemplate.basestats[i]
		else:
			bonusstats[i] = itemtemplate.basestats[i]

	if itemtemplate.has('effects'):
		for e in itemtemplate.effects:
			effects.push_back(e)

	reqs = itemtemplate.reqs.duplicate()
	tags = itemtemplate.tags.duplicate()
	if itemtemplate.has('multislots'):
		multislots = itemtemplate.multislots
	if itemtemplate.has('hitsound'):
		hitsound = itemtemplate.hitsound
	slots = itemtemplate.slots
	if mode == 'normal':
		parts = dictparts.duplicate()
		#durability = itemtemplate.basedurability
		partcolororder = itemtemplate.partcolororder

		var parteffectdict = {enchant_capacity_mod = 1.0}
		for i in parts:
			var material = Items.materiallist[parts[i]]
			var materialeffects = material['parts'][i].duplicate(true)
			
			for j in materialeffects:
#				if j == 'enchant_capacity_mod':
#					materialeffects[j] -= 1.0
				if itemtemplate.itemtype == 'armor':
					materialeffects[j] = float(materialeffects[j] * itemtemplate.statmod)
			
			materials.append(material.code)
			input_handler.AddOrIncrementDict(parteffectdict, materialeffects)
#		if parteffectdict.has('durabilitymod'):
#			durability *= parteffectdict.durabilitymod
		for i in parteffectdict:
			if i == 'enchant_capacity_mod' and bonusstats.has('enchant_capacity'):
				bonusstats.enchant_capacity *= parteffectdict[i]
			elif self.get(i) != null && i != 'effects':
				#self[i] += parteffectdict[i]
				set(i, get(i)+parteffectdict[i])
			elif bonusstats.has(i):
				bonusstats[i] += parteffectdict[i]
			elif i == 'effects':
				for k in parteffectdict[i]:
					effects.append(k)
			else:
				bonusstats[i] = parteffectdict[i]
		for i in itemtemplate.basemods:
			if bonusstats.has(i):
				bonusstats[i] *= itemtemplate.basemods[i]

	if itemtemplate.icon != null:
		if itemtemplate.has("alticons"):
			var alticon = false
			for i in itemtemplate.alticons.values():
				if i.materials.has(parts[i.part]):
					icon = i.icon.get_path()
					if i.has('altname'):
						tempname = i.altname
					alticon = true
			if alticon == false:
				icon = itemtemplate.icon.get_path()
		else:
			icon = itemtemplate.icon.get_path()

	if mode == 'normal':
		#durability = round(durability)
		#maxdurability = round(durability)
		if dictparts.size() == itemtemplate.parts.size():
			name = Items.materiallist[dictparts[itemtemplate.partmaterialname]].adjective.capitalize() + ' ' + tempname
		else:
			name = tempname
		quality = input_handler.weightedrandom_dict(build_quality_weighthes(diffdata))
	
	if bonusstats.has('atk') && get_bonusstats().has('damagemod'):
		bonusstats.atk = ceil(bonusstats.atk + (bonusstats.atk * get_bonusstats().damagemod))
		bonusstats.erase('damagemod')

	if mode == 'simple':
		name = itemtemplate.name
		description = itemtemplate.descript
	else:
		if parts.has(itemtemplate.partmaterialname):

			name = Items.materiallist[parts[itemtemplate.partmaterialname]].adjective + " " +itemtemplate.name
		else:
			name = itemtemplate.name
		#name = itemtemplate.partmaterialname
	
	if tags.has('enchantable') and (!diffdata.has('no_enchant') or !diffdata.no_enchant):
		roll_enchants()


func roll_enchants():
	if randf() > variables.enchantment_chance:
		return
	if randf() <= variables.curse_chance:
		if randf() <= variables.majorcurse_chance:
			apply_random_curse('major')
		else:
			apply_random_curse('minor')
	
	var used_points = get_e_capacity_max()
	used_points *= globals.rng.randf_range(0.2, 0.9)
	used_points = int(used_points)
	
	apply_random_enchantment(used_points, 1)


func apply_random_curse(mode = 'any'):
	var pool = []
	for id in Items.curses:
		if id.begins_with('stub_'):
			continue
		if id.ends_with('_minor') and mode != 'major':
			pool.push_back(id)
		if id.ends_with('_major') and mode != 'minor':
			pool.push_back(id)
	add_curse(input_handler.random_from_array(pool))


func apply_random_enchantment(limit, number):
	if number > 3:
		return
	if number == 3 and randf() > variables.enchantment_chance_3:
		return
	if number == 2 and randf() > variables.enchantment_chance_2:
		return
	var pool = build_possible_enchants(limit)
	if pool.empty():
		if number > 1:
			return
		pool = build_possible_enchants(get_e_capacity_max())
		if pool.empty():
			print('possible error in enchantments template - limit is too low')
			return
	
	var tmp = input_handler.weightedrandom(pool)
	var enchdata = Items.enchantments[tmp[0]].levels[tmp[1]]
	add_enchant(tmp[0], tmp[1], true)
	apply_random_enchantment(limit - enchdata.cap_cost, number + 1)


func build_possible_enchants(limit):
	var res = []
	for ench_id in Items.enchantments:
		if enchants.has(ench_id):
			continue
		var enchdata = Items.enchantments[ench_id]
		if !check_reqs(enchdata.reqs):
			continue
		for lv in enchdata.levels:
			if enchdata.levels[lv].cap_cost > limit:
				break
			var tmp = [[ench_id, lv], 100]
			if enchdata.levels[lv].has('weight'):
				tmp[1] = enchdata.levels[lv].weight
			res.push_back(tmp)
	return res


func fix_gear():
	var template = Items.itemlist[itembase]
	reqs = template.reqs.duplicate()
	
	for id in enchants:
		enchants[id] = int(enchants[id])
	if !bonusstats.has('enchant_capacity') and template.basestats.has('enchant_capacity'):
		bonusstats['enchant_capacity'] = template.basestats['enchant_capacity']
	if !tags.has('enchantable') and template.tags.has('enchantable'):
		tags.push_back('enchantable')
	


func substractitemcost():
	var itemtemplate = Items.itemlist[itembase]
	for i in parts:
		ResourceScripts.game_res.materials[parts[i]] -= itemtemplate.parts[i]

func set_icon(node):
	var icon_texture = input_handler.loadimage(icon)
#	if ResourcePreloader.new().has_resource(icon) == false:
#		icon_texture = input_handler.loadimage(icon)
#	else:
#		icon_texture = load(icon)

	if node.get_class() == "TextureButton":
		node.texture_normal = icon_texture
	else:
		node.texture = icon_texture
	node.material = null
	if parts.size() > 0:
		var shader = load("res://assets/ItemShader.tres").duplicate()
		if node.material != shader:
			node.material = shader
		else:
			shader = node.material
		for i in parts:
			var part = 'part' +  str(partcolororder[i]) + 'color'
			var color = Items.materiallist[parts[i]].color
			node.material.set_shader_param(part, color)


func color_ragdoll_parts(ragdoll_root):
	var nodes = GeneratorData.itemparts[itembase]
	for path in nodes:
		var node = ragdoll_root.get_node(path)
		node.material = null
		if parts.size() > 0:
			var shader = load("res://assets/ItemShader.tres").duplicate()
			if node.material != shader:
				node.material = shader
			else:
				shader = node.material
			for i in parts:
				var part = 'part' +  str(partcolororder[i]) + 'color'
				var color = Items.materiallist[parts[i]].color
				node.material.set_shader_param(part, color)


func tooltiptext():
	var text = ''
	# text += '[center]{color=k_yellow|' + name + '}[/center]\n'
	if geartype != null:
		text += tr('TYPE_LABEL') + ': ' + geartype + "\n"
	else:
		text += tr("TYPE_USABLE_LABEL") + "\n"

	if slots.size() > 0:
		text += tr("SLOTS_LABEL") + ": "
		for i in slots:
			text += tr("ITEMSLOT"+i.to_upper()) + ", "
		text = text.substr(0, text.length() -2) + "\n"

	if toolcategory != null:
		text += tr("TOOLWORKCATEGORY") + ": "
		for i in toolcategory:
			text += statdata.worktoolnames[i] +", "
		text = text.substr(0, text.length()-2)
	if description != null:
		text += description
	if !reqs.empty():
		var tempslave = ResourceScripts.scriptdict.class_slave.new("temp_tooltip_item")
		text += "\n" + tempslave.decipher_reqs(reqs)
	if itemtype in ['armor','weapon','tool']:
		text += "\n"
		var t_bonusstats = get_bonusstats()
		for i in t_bonusstats:
			if t_bonusstats[i] != 0:
				var value = t_bonusstats[i]
				var change = ''
				if statdata.statdata[i].percent:
					value = value*100
				text += statdata.statdata[i].name + ': {color='
				if value > 0:
					change = '+'
					text += 'k_green|' + change
				else:
					text += 'k_red|'
				value = str(value)
				if statdata.statdata[i].percent:
					value = value + '%'
				text += value + '}\n'
		text += tooltipeffects()
	elif itemtype == 'usable':
		text += '\n' + tr("INPOSESSION") + ': ' + str(amount)

	text = globals.TextEncoder(text)
	return text


func tooltiptext_1():
	var text = ''
	
	if quality != "": text += tr("STATQUALITY") + ": {color=" + "quality_"+quality +"|" + str(tr("QUALITY"+quality.to_upper())) + "}\n"
	
	if geartype != null:
		text += tr('TYPE_LABEL') + ': ' + geartype + "\n"
	else:
		text += tr("TYPE_USABLE_LABEL") + "\n"

	if slots.size() > 0:
		text += tr("SLOTS_LABEL") + ": "
		for i in slots:
			text += tr("ITEMSLOT"+i.to_upper()) + ", "
		text = text.substr(0, text.length() -2) + "\n"

	if toolcategory != null:
		text += tr("TOOLWORKCATEGORY") + ": "
		for i in toolcategory:
			text += statdata.worktoolnames[i] +", "
		text = text.substr(0, text.length()-2)
	if !reqs.empty():
		var tempslave = ResourceScripts.scriptdict.class_slave.new("temp_tooltip_item_1")
		text += tempslave.decipher_reqs(reqs)
	
	if get_e_capacity_max() > 0:
		text +=  "\n" + tr("STATENCHCAP")+": " + str(get_e_capacity()) + "/" + str(get_e_capacity_max())
	
	text = globals.TextEncoder(text)
	return text


func tooltiptext_2():
	var text = ''
	if description != null:
		text += description
	if text.length() > 0:
		text += "\n\n"

	if itemtype in ['armor','weapon','tool']:
		text += globals.build_desc_for_bonusstats(get_bonusstats())
		text += tooltipeffects()
	elif itemtype == 'usable':
		text += tr("INPOSESSION") + ': ' + str(amount)

	text = globals.TextEncoder(text)
	return text


func tooltiptext_light():
	var text = ''
	# text += '[center]{color=k_yellow|' + name + '}[/center]\n'
	if itemtype in ['armor','weapon','tool']:
		# text += "\n"
		var t_bonusstats = get_bonusstats()
		for i in t_bonusstats:
			if t_bonusstats[i] != 0:
				var value = t_bonusstats[i]
				var change = ''
				if statdata.statdata[i].percent:
					value = value*100
				text += statdata.statdata[i].name + ': {color='
				if value > 0:
					change = '+'
					text += 'k_green|' + change
				else:
					text += 'k_red|'
				value = str(value)
				if statdata.statdata[i].percent:
					value = value + '%'
				text += value + '}\n'
		text += tooltipeffects()
	elif itemtype == 'usable':
		text += '\n' + tr("INPOSESSION") + ': ' + str(amount)

	text = globals.TextEncoder(text)
	return text

func tooltipeffects():
	var text = ''
	for id in enchants:
		text += "{color=yellow|%s %s}\n" % [tr(Items.enchantments[id].name), input_handler.roman_number_converter(enchants[id])]
	if curse != null:
		if !curse_known:
			text += "{color=red|Unknown curse}"
		else:
			text += "{color=red|%s}" % [tr(Items.curses[curse].name)]
	for i in effects:
		if !Effectdata.effect_table[i].has('descript'):
			pass
#			text += tr(i) + '\n'
		elif Effectdata.effect_table[i].descript != '':
			text += tr(Effectdata.effect_table[i].descript) + "\n"
#		text += "{color=" + Effectdata.effects[i].textcolor + '|' + Effectdata.effects[i].descript
#		text += '}\n'
	if text != "":
		text = "\n" + text
	return text


func tooltip(targetnode):
	var node = input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP) #input_handler.GetItemTooltip()
	var data = {text = tooltiptext(), icon = input_handler.loadimage(icon, 'icons'), item = self, price = str(calculateprice())}
	node.showup(targetnode, data, 'gear')


func tooltip_v2(targetnode):
	var node = input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP) #input_handler.GetItemTooltip()
	var data = {title = name, text = tooltiptext(), icon = input_handler.loadimage(icon, 'icons'), item = self, price = str(calculateprice())}
	node.showup(targetnode, data, 'gear')

func calculatematerials():
	var itemtemplate = Items.itemlist[itembase] #item base for item parts amount
	var materialsdict = {} #total materials used in creation
	#collecting parts info
	for i in parts:
		if materialsdict.has(parts[i]):
			materialsdict[parts[i]] += itemtemplate.parts[i]
		else:
			materialsdict[parts[i]] = itemtemplate.parts[i]
	return materialsdict

func calculateprice():
	var price = 0
	if itemtype == 'usable' || Items.itemlist[itembase].crafttype == 'basic':
		price = Items.itemlist[itembase].price
	else:
		var materialsdict = calculatematerials()
		for i in materialsdict:
			price += Items.materiallist[i].price*materialsdict[i]
		price += round(Items.recipes[itembase].workunits * 5)
		if quality != "":
			price = price*(variables.itemquality_multiplier[quality]*0.66)
		if enchants.size() > 0:
			price = price * (1 + enchants.size() * 0.15)
		if curse != null:
			price = price * 0.60
	return price

func use_explore(character, caller = null):
	var itemskill = Items.itemlist[itembase].explor_effect
	var skill = Skilldata.Skilllist[itemskill]
	if skill.tags.has('use_as_combat') and caller!= null:
		caller.use_e_combat_skill(character, character, skill)
	else:
		character.use_social_skill(itemskill, character)


func get_e_capacity_max():
#	var res = 0
#	var template = Items.itemlist[itembase]
#	if template.has('enchant_capacity'):
#		res = template.enchant_capacity
#	res *= variables.itemquality_multiplier[quality]
#	if curse != null:
#		var cursetemplate = Items.curses[curse]
#		if cursetemplate.has('capacity_multiplyer'):
#			res *= cursetemplate.capacity_multiplyer
#	return res
	var tmp = get_bonusstats()
	if !tmp.has('enchant_capacity'):
		return 0
	return int ( floor(tmp.enchant_capacity))


func get_e_capacity():
	var res = get_e_capacity_max()
	for e_id in enchants:
		var ench_template = Items.enchantments[e_id]
		res -= ench_template.levels[enchants[e_id]].cap_cost
	return res


func get_bonusstats():
	var res = bonusstats.duplicate()
	var mul = variables.itemquality_multiplier[quality]
	for st in res:
		res[st] *= mul
	if curse != null:
		var cursetemplate = Items.curses[curse]
		if cursetemplate.has('statmods'):
			for st in cursetemplate.statmods:
				if !st.ends_with('_mul'):
					continue
				var _st = st.trim_suffix('_mul') 
				if res.has(_st):
					res[_st] *= cursetemplate.statmods[st]
	for bless in enchants:
		var enchtemplate = Items.enchantments[bless].levels[enchants[bless]]
		if enchtemplate.has('statmods'):
			for st in enchtemplate.statmods:
				if !st.ends_with('_mul'):
					continue
				var _st = st.trim_suffix('_mul') 
				if res.has(_st):
					res[_st] *= enchtemplate.statmods[st]
	if curse != null:
		var cursetemplate = Items.curses[curse]
		if cursetemplate.has('statmods'):
			for st in cursetemplate.statmods:
				if !st.ends_with('_add'):
					continue
				var _st = st.trim_suffix('_add') 
				if res.has(_st):
					res[_st] += cursetemplate.statmods[st]
				else:
					res[_st] = cursetemplate.statmods[st]
	for bless in enchants:
		var enchtemplate = Items.enchantments[bless].levels[enchants[bless]]
		if enchtemplate.has('statmods'):
			for st in enchtemplate.statmods:
				if !st.ends_with('_add'):
					continue
				var _st = st.trim_suffix('_add') 
				if res.has(_st):
					res[_st] += enchtemplate.statmods[st]
				else:
					res[_st] = enchtemplate.statmods[st]
	return res


func add_curse (c_id):
	if curse != null:
		return
	
#	var tmp = null
	if owner != null:
#		tmp = owner
		characters_pool.get_char_by_id(owner).unequip(self)
	
	curse = c_id
	var cursetemplate = Items.curses[c_id]
	if cursetemplate.has('effects'):
		for eff in cursetemplate.effects:
			effects.push_back(eff)
	
#	if tmp != null:
#		characters_pool.get_char_by_id(tmp).equip(self)


func can_add_enchant(e_id, lvl):
	if enchants.has(e_id):
		return can_upgrade_enchant(e_id, lvl)
	var enchdata = Items.enchantments[e_id]
	var newcost = enchdata.levels[lvl].cap_cost
	var goldcost = enchdata.levels[lvl].gold_cost
	if goldcost > ResourceScripts.game_res.money:
		return false
	return get_e_capacity() >= newcost


func can_upgrade_enchant(e_id, lvl):
	if !enchants.has(e_id):
		return false
	if enchants[e_id] >= lvl:
		return false
	var enchdata = Items.enchantments[e_id]
	var oldcost = enchdata.levels[enchants[e_id]].cap_cost
	var newcost = enchdata.levels[lvl].cap_cost
	var goldcost = enchdata.levels[lvl].gold_cost
	if goldcost > ResourceScripts.game_res.money:
		return false
	return get_e_capacity() >= newcost - oldcost


func _remove_enchant(e_id): #internal
	if owner != null:
		print('e_remove_failed')
		return
	if !enchants.has(e_id):
		return
	var enchdata = Items.enchantments[e_id].levels[enchants[e_id]]
	if enchdata.has('effects'):
		for eff in enchdata.effects:
			effects.erase(eff)


func add_enchant(e_id, lvl, is_free = false):
	if !is_free and !can_add_enchant(e_id, lvl):
		return
	
#	var tmp = null
	if owner != null:
#		tmp = owner
		characters_pool.get_char_by_id(owner).unequip(self)
	
	_remove_enchant(e_id)
	enchants[e_id] = lvl
	var enchdata = Items.enchantments[e_id].levels[lvl]
	if !is_free:
		var goldcost = enchdata.gold_cost
		ResourceScripts.game_res.money -= goldcost
	if enchdata.has('effects'):
		for eff in enchdata.effects:
			effects.push_back(eff)
	
#	if tmp != null:
#		characters_pool.get_char_by_id(tmp).equip(self)


func identify():
	curse_known = true


func destroy():
	if owner != null:
		characters_pool.get_char_by_id(owner).unequip(self)
	globals.remove_item(self)
