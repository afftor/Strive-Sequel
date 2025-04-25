extends Reference

var parent: WeakRef = null

var statlist = Statlist_init.template_direct.duplicate(true) 
var exterior = Statlist_init.sex_binded_exterior.duplicate(true) 
var exterior_alt = {}
var sexexp = Statlist_init.sexexp.duplicate(true)
var sex_skills = Statlist_init.sex_skills.duplicate(true)
var metrics = Statlist_init.metrics.duplicate(true)
var piercing = Statlist_init.piercing.duplicate(true)
var armor_color = Statlist_init.armor_color.duplicate(true)
var sex_traits = {}
var negative_sex_traits = {}
var unlocked_sex_traits = []
var pregnancy = Statlist_init.pregnancy.duplicate()
var tattoo = Statlist_init.tattoo.duplicate()

func _init():
	pass


func deserialize(savedict):
	sex_traits = savedict.sex_traits.duplicate()
	negative_sex_traits = savedict.negative_sex_traits.duplicate()
	unlocked_sex_traits = savedict.unlocked_sex_traits.duplicate()
	pregnancy = savedict.pregnancy.duplicate()
	tattoo = savedict.tattoo.duplicate()
	for stat in statlist:
		if savedict.statlist.has(stat):
			statlist[stat] = savedict.statlist[stat]
	for stat in ['physics_factor', 'magic_factor', 'wits_factor', 'authority_factor', 'tame_factor', 'sexuals_factor', 'charm_factor']:
		update_stat(stat, statlist[stat], 'set')
	for stat in exterior:
		if savedict.exterior.has(stat):
			exterior[stat] = savedict.exterior[stat]
		elif savedict.statlist.has(stat):
			exterior[stat] = savedict.statlist[stat]
	if !savedict.exterior_alt.empty():
		exterior_alt = exterior.duplicate(true)
		for stat in exterior_alt:
			if savedict.exterior_alt.has(stat):
				exterior_alt[stat] = savedict.exterior_alt[stat]
			elif savedict.statlist.has(stat):
				exterior_alt[stat] = savedict.statlist[stat]
	for stat in sexexp:
		if savedict.sexexp.has(stat):
			sexexp[stat] = savedict.sexexp[stat].duplicate(true)
	for stat in sex_skills:
		if savedict.sex_skills.has(stat):
			sex_skills[stat] = savedict.sex_skills[stat] 
	for stat in metrics:
		if savedict.metrics.has(stat):
			if savedict.metrics[stat] is Array:
				metrics[stat] = savedict.metrics[stat].duplicate(true)
			else:
				metrics[stat] = savedict.metrics[stat] 
	for stat in piercing:
		if savedict.piercing.has(stat):
			piercing[stat] = savedict.piercing[stat]
	for stat in armor_color:
		if savedict.armor_color.has(stat):
			armor_color[stat] = savedict.armor_color[stat]


func fix_import():
	if statlist.unique != null and !ResourceScripts.game_world.easter_egg_characters_acquired.has(statlist.unique):
		ResourceScripts.game_world.easter_egg_characters_acquired.append(statlist.unique)


func fix_serialize():
	for tr in sex_traits.duplicate():
		if Traitdata.sex_traits.has(tr): 
			continue
		sex_traits.erase(tr)
	for tr in unlocked_sex_traits.duplicate():
		if Traitdata.sex_traits.has(tr): 
			continue
		unlocked_sex_traits.erase(tr)
	for st in ['personality_bold', 'personality_kind',]:
		statlist[st] = int(statlist[st])
	statlist.consent = min(get_stat('consent'), 6)
	if parent.get_ref().is_master():
		statlist.consent = 100


func swap_alternate_exterior(): #only on sex change due to current implementation of recreate method
	var tmp = exterior
	if exterior_alt.empty():
		exterior_alt = tmp.duplicate(true)
		recreate_exterior()
	else:
		exterior = exterior_alt
		exterior_alt = tmp


func recreate_exterior(): #only on sex change
	var sex = statlist.sex
	var data = ResourceScripts.descriptions.bodypartsdata.sex[sex].bodychanges
	for line in data:
		if !line.code in (exterior.keys() + Statlist_init.exterior_stats_composite):
			continue
		if !parent.get_ref().checkreqs(line.reqs):
			continue
		var value = input_handler.weightedrandom(line.value)
		if line.code in exterior:
			exterior[line.code] = value
		else:
			update_stat(line.code, value)

#getters
func get_stat(stat):
	var data = statdata.statdata[stat]
	if !data.direct:
		print ("error: wrong stat data - %s is not direct" % stat)
		return
	var tres
	if data.tags.has('custom_getter'):
		tres = call('get_' + stat)
	elif data.tags.has('obsolete'):
		tres = get_stat_old(stat)
	else:
		var container = statlist
		if data.has('container'):
			match data.container:
				'exterior':
					container = exterior
				'sexexp':
					print ("warning - accessing sexexp the wrong way")
					container = sexexp
				'sex_skills':
					container = sex_skills
				'metrics':
					container = metrics
				'piercing':
					container = piercing
				'armor_color':
					container = armor_color
				'pregnancy':
					container = pregnancy
				'tattoo':
					container = tattoo
		if !container.has(stat):
			print ("error: no %s in container" % stat)
			return null
		tres = container[stat]
	if data.tags.has('cap_up'):
		var stat_cap
		if data.cap_up is String:
			stat_cap = parent.get_ref().get_stat(data.cap_up)
		else:
			stat_cap = data.cap_up
		if tres > stat_cap:
			tres = stat_cap
			update_stat(stat, tres)
	if data.tags.has('cap_low'):
		var stat_cap
		if data.cap_low is String:
			stat_cap = parent.get_ref().get_stat(data.cap_low)
		else:
			stat_cap = data.cap_low
		if tres < stat_cap:
			tres = stat_cap
			update_stat(stat, tres)
	if data.tags.has('integer'):
		tres = int(tres)
	return tres


func get_consent():
	var res = statlist.consent
	if parent.get_ref().has_status('alcohol'):
		res += 1
	return res


func get_sexuals():
	var array = sex_skills.values()
	array.sort()
	array.invert()
	return (array[0] + array[1] + array[2])/3


func get_short_name():
	var text = ''
	if statlist.nickname == '':
		text = tr(statlist.name)
	else:
		text = statlist.nickname
	return text

func get_full_name():
	var text = ''
	if statlist.nickname == '':
		text = tr(statlist.name)
	else:
		text = tr(statlist.name) + ' "' + statlist.nickname + '"'
	if statlist.surname != '':
		text += " " + statlist.surname
	return tr(text)


func get_personality():
	if abs(statlist.personality_bold) <= 30 and abs(statlist.personality_kind) <= 30:
		return 'neutral'
	if abs(statlist.personality_bold) > abs(statlist.personality_kind):
		if statlist.personality_bold > 0:
			return 'bold'
		else:
			return 'shy'
	else:
		if statlist.personality_kind > 0:
			return 'kind'
		else:
			return 'serious'


func get_pose():
	var st = get_stat('personality')
	if st == 'neutral':
		st = get_stat('old_personality')
	match st:
		'shy':
			match get_stat('sex'):
				'male':
					return 'pose5'
				'female', 'futa':
					return 'shy'
		'kind':
			match get_stat('sex'):
				'male':
					return 'pose5'
				'female', 'futa':
					return 'kind'
		'serious':
			match get_stat('sex'):
				'male':
					return 'pose6'
				'female', 'futa':
					return 'pose4'
		'bold':
			match get_stat('sex'):
				'male':
					return 'pose6'
				'female', 'futa':
					return 'bold'
	return 'default' #temporal stub


func get_hair_facial_color():
	if statlist.hair_facial_color != '':
		return statlist.hair_facial_color
	else:
		return get_stat('hair_base_color_1')


func get_body_color_ears():
	match statlist.ears: 
		'cat', 'fox', 'tanuki', 'wolf', 'mouse', 'bunny', 'bunny_standing', 'bunny_dropping', 'cow':
			var res = get_hairs_data().hair_base_color_1
			if statlist.hair_base_color_1 != "":
				res = statlist.hair_base_color_1
			res = res.replace('_', '')
			if statlist.skin_coverage.begins_with('fur'):
				match statlist.skin_coverage:
					'fur_orange':
						return 'orange3'
					'fur_orange_white':
						return 'orange2'
					'fur_striped':
						return 'orange3'
					'fur_white':
						return 'white2'
					'fur_grey':
						return 'white3'
					'fur_brown':
						return 'brown3'
					'fur_black':
						return 'dark3'
			return res
		'fish': 
			return 'blue1'
		_: 
			return 'yellow2'


func get_body_color_animal(): #2move to bodychanges
	if statlist.body_color_animal != "":
		return statlist.body_color_animal
	match statlist.body_lower: #feel free to change values and stat
		'horse':
			return 'red3'
		'avian':
			return 'blue1'
		'snake':
			return 'green2'
		'spider':
			return 'pink3'
		'tentacle':
			return 'purple3'
		'avian':
			return 'blue3'
		_:
			return 'white2'


func get_portrait_update():
	var res = statlist.portrait_update
	if !res:
		return !parent.get_ref().check_portrait()
	return res


#setters
func update_stat(stat, value, operant = 'set'):
	if !statdata.check_compatibility_operant(stat, operant):
		print("error: wrong operant %s for %s" % [operant, stat])
		return
	var data = statdata.statdata[stat]
	if !data.direct:
		print ("error: wrong stat data - %s is not direct" % stat)
		return
	parent.get_ref().reset_rebuild()
	if data.tags.has('custom_setter'):
		call('update_' + stat, value, operant)
	elif data.tags.has('obsolete'):
		set_hair_stat(stat, value)
	else:
		var container = statlist
		if data.has('container'):
			match data.container:
				'exterior':
					container = exterior
				'sexexp':
					print ("warning - accessing sexexp the wrong way")
					container = sexexp
				'sex_skills':
					container = sex_skills
				'metrics':
					container = metrics
				'piercing':
					container = piercing
				'armor_color':
					container = armor_color
				'pregnancy':
					container = pregnancy
				'tattoo':
					container = tattoo
		if !container.has(stat):
			print ("error: no %s in container" % stat)
			return 
		
		match operant:
			'set':
				if value is Array:
					container[stat] = value.duplicate(true)
				elif value is Dictionary:
					container[stat] = value.duplicate(true)
				else:
					container[stat] = value
			'add':
				container[stat] += value
			'mul':
				container[stat] *= value
			'add_part':
				container[stat] *= (1.0 + value)
			'append':
				container[stat].push_back(value)
			'remove':
				container[stat].erase(value)
		if data.tags.has('update_portrait'):
			statlist.portrait_update = true
		if data.tags.has('cap_up'):
			var stat_cap
			if data.cap_up is String:
				stat_cap = parent.get_ref().get_stat(data.cap_up)
			else:
				stat_cap = data.cap_up
			if value > stat_cap:
				value = stat_cap
				container[stat] = value
		if data.tags.has('cap_low'):
			var stat_cap
			if data.cap_low is String:
				stat_cap = parent.get_ref().get_stat(data.cap_low)
			else:
				stat_cap = data.cap_low
			if value < stat_cap:
				value = stat_cap
				container[stat] = value
	if stat.begins_with('hair_'): #compat
		set_hair_stat(stat, value)
	parent.get_ref().reset_rebuild()


func update_personality(value):
	match value:
		'neutral':
			statlist.personality_bold = globals.rng.randi_range(-10, 10)
			statlist.personality_kind = globals.rng.randi_range(-10, 10)
		'bold':
			statlist.personality_bold = globals.rng.randi_range(65, 85)
			statlist.personality_kind = globals.rng.randi_range(-10, 10)
		'shy':
			statlist.personality_bold = -globals.rng.randi_range(65, 85)
			statlist.personality_kind = globals.rng.randi_range(-10, 10)
		'kind':
			statlist.personality_bold = globals.rng.randi_range(-10, 10)
			statlist.personality_kind = globals.rng.randi_range(65, 85)
		'serious':
			statlist.personality_bold = globals.rng.randi_range(-10, 10)
			statlist.personality_kind = -globals.rng.randi_range(65, 85)
	check_old_personality()
	parent.get_ref().update_prt()
	parent.get_ref().reset_rebuild()


func update_skin(value, operant = 'set'):
	match value: #feel free to change values
		'pale':
			statlist.body_color_skin = 'human1'
		'grey':
			statlist.body_color_skin = 'grey2'
		'fair':
			statlist.body_color_skin = 'human3'
		'olive':
			statlist.body_color_skin = 'human4'
		'tan':
			statlist.body_color_skin = 'human4'
		'brown':
			statlist.body_color_skin = 'human5'
		'dark':
			statlist.body_color_skin = 'human5'
		'slime':
			statlist.body_color_skin = 'green1'
		'blue':
			statlist.body_color_skin = 'blue3'
		'paleblue':
			statlist.body_color_skin = 'blue1'
		'green':
			statlist.body_color_skin = 'green3'
		'red':
			statlist.body_color_skin = 'red3'
		'purple':
			statlist.body_color_skin = 'purple3'
		'teal':
			statlist.body_color_skin = 'blue2'
		_:
			statlist.body_color_skin = 'human2'


func update_name(value, operant = 'set'):
	statlist.name = value
	if ResourceScripts.game_party.relativesdata.has(parent.get_ref().id):
		ResourceScripts.game_party.relativesdata[parent.get_ref().id].name = get_full_name()
	parent.get_ref().reset_rebuild()

#other stuff
func check_old_personality():
	if get_personality() != 'neutral':
		statlist.old_personality = get_personality()


func predict_preg_time():
	if pregnancy.pregnancy_duration > 0 && pregnancy.pregnancy_baby != null:
		return pregnancy.pregnancy_duration
	else: 
		return null


func get_stat_gain_rate(statname): #basestats only
	var res = 1
	if statlist[statname] >= 90: res = 0.25
	elif statlist[statname] >= 60: res = 0.5
	elif statlist[statname] >= 40: res = 0.75
	
	res *= variables.basestats_factor_mod[get_stat(statname + '_factor')]
	return res


func has_status(status):
	for tr in sex_traits:
		var traitdata = Traitdata.sex_traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(status):
			return true
	for tr in negative_sex_traits:
		var traitdata = Traitdata.sex_traits[tr]
		if traitdata.has('tags') and traitdata.tags.has(status):
			return true
	return false


#compat getter - stub
func set_hair_stat(st, value):
	if st in ['hair_base_color_1', 'hair_base_color_2' ]:
		statlist[st] = value
		statlist[st.replace('base', 'fringe')] = value
	if st in ['hair_length','hair_style']: #legacy stub
		statlist[st] = value
		var tdata = get_hairs_data()
		for h_stat in ['hair_base', 'hair_assist', 'hair_back', 'hair_fringe', 'hair_base_length', 'hair_fringe_length', 'hair_back_length', 'hair_assist_length',]:
			statlist[h_stat] = tdata[h_stat]
	if st in ['hair_color']: #legacy stub
		statlist[st] = value
		var tdata = get_hairs_data()
		for h_stat in ['hair_base_color_1', 'hair_fringe_color_1', 'hair_back_color_1', 'hair_assist_color_1', 'hair_base_color_2', 'hair_fringe_color_2', 'hair_back_color_2', 'hair_assist_color_2']:
			statlist[h_stat] = tdata[h_stat]


func get_combined_hairs_data():
	var res = {
		hair_color ='',
		hair_style = '',
		hair_length = '',
	}
	var lenghthes = ['bald', 'ear', 'neck', 'shoulder', 'waist', 'hips' ]
	var color_parts = ['hair_fringe_color_1', 'hair_back_color_2', 'hair_assist_color_1']
	var length = 0
	match statlist.hair_fringe: #adjust as you see fit, length is not reverse-compartible with presets autoset
	#i hate this conversion to older constants, but we are using those - until descriptions are totally rewritten we need this
		'braids' :
			res.hair_style = 'multibraids'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 1))
				'middle':
					length = int(max(length, 1))
				'short', 'default':
					length = int(max(length, 1))
		'dopple', 'lion', 'parting', 'default', 'fringe':
			res.hair_style = 'straight'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 2))
				'middle':
					length = int(max(length, 1))
				'short', 'default':
					length = int(max(length, 1))
		'back':
			res.hair_style = 'straight'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 1))
				'middle':
					length = int(max(length, 1))
				'short', 'default':
					length = int(max(length, 1))
		'straight' :
			res.hair_style = 'straight'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 3))
					color_parts.push_back('hair_fringe_color_2')
				'middle':
					length = int(max(length, 3))
					color_parts.push_back('hair_fringe_color_2')
				'short', 'default':
					length = int(max(length, 2))
		'irokez':
			res.hair_style = 'irokez'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 1))
				'middle':
					length = int(max(length, 1))
				'short', 'default':
					length = int(max(length, 1))
		'kare':
			res.hair_style = 'kare'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 2))
				'middle':
					length = int(max(length, 2))
				'short', 'default':
					length = int(max(length, 2))
		'lamb':
			res.hair_style = 'curved'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 2))
				'middle':
					length = int(max(length, 2))
				'short', 'default':
					length = int(max(length, 2))
		'slave':
			res.hair_style = 'shaved'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 1))
				'middle':
					length = int(max(length, 1))
				'short', 'default':
					length = int(max(length, 1))
		'undercut':
			res.hair_style = 'undercut'
			match exterior.hair_fringe_length:
				'long':
					length = int(max(length, 1))
				'middle':
					length = int(max(length, 1))
				'short', 'default':
					length = int(max(length, 1))
	
	match statlist.hair_assist:
		'braid':
			res.hair_style = 'braid'
			match exterior.hair_assist_length:
				'long':
					length = int(max(length, 4))
					color_parts.push_back('hair_assist_color_2')
				'middle':
					length = int(max(length, 3))
					color_parts.push_back('hair_assist_color_2')
				'short', 'default':
					length = int(max(length, 3))
		'bun':
			res.hair_style = 'bun'
		'pigtails':
			res.hair_style = 'pigtails'
		'ponytail': 
			res.hair_style = 'ponytail'
			color_parts.push_back('hair_assist_color_2')
			match exterior.hair_assist_length:
				'long':
					length = int(max(length, 5))
				'middle':
					length = int(max(length, 4))
				'short', 'default':
					length = int(max(length, 3))
		'ponytail_2', 'ponytail_3': 
			res.hair_style = 'ponytail'
		'twin_tails', 'twin_tails_3':
			res.hair_style = 'twinbraids'
			match exterior.hair_assist_length:
				'long':
					length = int(max(length, 3))
					color_parts.push_back('hair_assist_color_2')
				'middle':
					length = int(max(length, 3))
					color_parts.push_back('hair_assist_color_2')
				'short', 'default':
					length = int(max(length, 2))
		'twin_tails_2', 'twin_tails_4', 'twin_tails_5':
			res.hair_style = 'twinbraids'
		_:
			color_parts.erase('hair_assist_color_1')
	
	match statlist.hair_back: 
		'very_long':
			length = 5
		'double_tail', 'ponytail_long' :
			color_parts.push_back('hair_back_color_1')
			match exterior.hair_back_length:
				'long':
					length = int(max(length, 5))
				'middle':
					length = int(max(length, 4))
				'short', 'default':
					length = int(max(length, 3))
		'twin_braids':
			color_parts.push_back('hair_back_color_1')
			match exterior.hair_back_length:
				'long':
					length = int(max(length, 3))
				'middle':
					length = int(max(length, 2))
				'short', 'default':
					length = int(max(length, 2))
		'spiral', 'straight', 'wave' :
			match exterior.hair_back_length:
				'long':
					length = int(max(length, 3))
				'middle':
					length = int(max(length, 2))
				'short', 'default':
					length = int(max(length, 2))
		'dishevel':
			match exterior.hair_back_length:
				'long':
					length = int(max(length, 2))
				'middle':
					length = int(max(length, 1))
				'short', 'default':
					length = int(max(length, 1))
		_:
			color_parts.erase('hair_back_color_2')
	var colors = []
	for st in color_parts:
		var tcolor = statlist[st].split('_')[0]
		if !colors.has(tcolor):
			colors.push_back(tcolor)
	if colors.size() > 1: #this is NOT reverse-compatible with preset colors autoassign, auburn preset set colors to different bases. and most base colors do not have translation records. feel free to fix this
		res.hair_color = 'gradient'
	else:
		res.hair_color = colors[0] 
	
	res.hair_length = lenghthes[length]
	
	return res


func get_hairs_data():
	var res = {
		hair_base = 'dopple', 
		hair_fringe = 'dopple', 
		hair_assist = 'bun', 
		hair_back = 'very_long', 
		hair_base_color_1 = 'blue_2', 
		hair_fringe_color_1 = 'blue_2', 
		hair_back_color_1 = 'blue_2', 
		hair_assist_color_1 = 'blue_2', 
		hair_base_color_2 = 'blue_2', 
		hair_fringe_color_2 = 'blue_2', 
		hair_back_color_2 = 'blue_2', 
		hair_assist_color_2 = 'blue_2', 
		hair_base_length = 'long', 
		hair_fringe_length = 'long', 
		hair_back_length = 'long', 
		hair_assist_length = 'long',
	}
	match statlist.hair_color:
		'blond':
			res.hair_back_color_1 = 'yellow_2'
			res.hair_back_color_2 = 'yellow_1'
			res.hair_assist_color_1 = 'yellow_2'
			res.hair_assist_color_2 = 'yellow_1'
			res.hair_base_color_1 = 'yellow_2'
			res.hair_base_color_2 = 'yellow_1'
		'green':
			res.hair_back_color_1 = 'green_2'
			res.hair_back_color_2 = 'green_1'
			res.hair_assist_color_1 = 'green_2'
			res.hair_assist_color_2 = 'green_1'
			res.hair_base_color_1 = 'green_2'
			res.hair_base_color_2 = 'green_1'
		'brown':
			res.hair_back_color_1 = 'brown_2'
			res.hair_back_color_2 = 'brown_3'
			res.hair_assist_color_1 = 'brown_2'
			res.hair_assist_color_2 = 'brown_3'
			res.hair_base_color_1 = 'brown_2'
			res.hair_base_color_2 = 'brown_3'
		'white':
			res.hair_back_color_1 = 'white_2'
			res.hair_back_color_2 = 'white_1'
			res.hair_assist_color_1 = 'white_2'
			res.hair_assist_color_2 = 'white_1'
			res.hair_base_color_1 = 'white_2'
			res.hair_base_color_2 = 'white_1'
		'red':
			res.hair_back_color_1 = 'red_3'
			res.hair_back_color_2 = 'red_2'
			res.hair_assist_color_1 = 'red_3'
			res.hair_assist_color_2 = 'red_2'
			res.hair_base_color_1 = 'red_3'
			res.hair_base_color_2 = 'red_2'
		'orange':
			res.hair_back_color_2 = 'orange_1'
			res.hair_back_color_1 = 'orange_2'
			res.hair_assist_color_2 = 'orange_1'
			res.hair_assist_color_1 = 'orange_2'
			res.hair_base_color_2 = 'orange_1'
			res.hair_base_color_1 = 'orange_2'
		'auburn':
			res.hair_back_color_1 = 'orange_3'
			res.hair_back_color_2 = 'brown_2'
			res.hair_assist_color_1 = 'orange_3'
			res.hair_assist_color_2 = 'brown_2'
			res.hair_base_color_1 = 'orange_3'
			res.hair_base_color_2 = 'brown_2'
		'black':
			res.hair_back_color_1 = 'dark_3'
			res.hair_back_color_2 = 'dark_3'
			res.hair_assist_color_1 = 'dark_3'
			res.hair_assist_color_2 = 'dark_3'
			res.hair_base_color_1 = 'dark_3'
			res.hair_base_color_2 = 'dark_3'
		'purple':
			res.hair_back_color_1 = 'purple_2'
			res.hair_back_color_2 = 'purple_3'
			res.hair_assist_color_1 = 'purple_2'
			res.hair_assist_color_2 = 'purple_3'
			res.hair_base_color_1 = 'purple_2'
			res.hair_base_color_2 = 'purple_3'
		'green':
			res.hair_back_color_1 = 'green_3'
			res.hair_back_color_2 = 'green_1'
			res.hair_assist_color_1 = 'green_3'
			res.hair_assist_color_2 = 'green_1'
			res.hair_base_color_1 = 'green_3'
			res.hair_base_color_2 = 'green_1'
		'gradient':
			res.hair_back_color_1 = 'red_1'
			res.hair_back_color_2 = 'green_2'
			res.hair_assist_color_1 = 'red_2'
			res.hair_assist_color_2 = 'blue_3'
			res.hair_base_color_1 = 'red_3'
			res.hair_base_color_2 = 'purple_1'
		_:
			res.hair_back_color_1 = 'blue_1'
			res.hair_back_color_2 = 'blue_1'
			res.hair_assist_color_1 = 'blue_1'
			res.hair_assist_color_2 = 'blue_1'
			res.hair_base_color_1 = 'blue_1'
			res.hair_base_color_2 = 'blue_1'
	if statlist.hair_length == 'bald':
		res.hair_base_length = 'bald'
		res.hair_assist = ''
		res.hair_back = ''
	else:
		match statlist.hair_style:
			'straight':
				match statlist.hair_length:
					'ear':
						res.hair_base = 'undercut'
						res.hair_assist = 'no'
						res.hair_back = 'care'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'neck':
						res.hair_base = 'dopple'
						res.hair_assist = 'no'
						res.hair_back = 'straight'
						res.hair_base_length = 'middle'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'shoulder':
						res.hair_base = 'default'
						res.hair_assist = 'no'
						res.hair_back = 'straight'
						res.hair_base_length = 'middle'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'waist':
						res.hair_base = 'default'
						res.hair_assist = 'no'
						res.hair_back = 'straight'
						res.hair_base_length = 'long'
						res.hair_assist_length = 'middle'
						res.hair_back_length = 'middle'
					'hips':
						res.hair_base = 'straight'
						res.hair_assist = 'no'
						res.hair_back = 'very_long'
						res.hair_base_length = 'long'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					_:
						res.hair_base = 'undercut'
						res.hair_assist = 'no'
						res.hair_back = 'no'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
			'ponytail':
				res.hair_base = 'back'
				match statlist.hair_length:
					'ear':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'neck':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'shoulder':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'waist':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'middle'
						res.hair_back_length = 'middle'
					'hips':
						res.hair_assist = 'ponytail'
						res.hair_back = 'no'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					_:
						res.hair_assist = 'no'
						res.hair_back = 'no'
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
			'pigtails':
				res.hair_base = 'lamb'
				res.hair_assist = 'pigtails'
				res.hair_back = 'no'
				match statlist.hair_length:
					'ear':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'neck':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'shoulder':
						res.hair_base_length = 'middle'
						res.hair_assist_length = 'middle'
						res.hair_back_length = 'middle'
					'waist':
						res.hair_base_length = 'long'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					'hips':
						res.hair_base_length = 'long'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					_:
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
			'braid':
				res.hair_base = 'back'
				res.hair_assist = 'braid'
				res.hair_back = 'no'
				match statlist.hair_length:
					'ear':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'neck':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'shoulder':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'middle'
						res.hair_back_length = 'middle'
					'waist':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					'hips':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					_:
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
			'twinbraids':
				res.hair_base = 'braids'
				res.hair_assist = 'no'
				res.hair_back = 'twin_braids'
				match statlist.hair_length:
					'ear':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'neck':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
					'shoulder':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'middle'
						res.hair_back_length = 'middle'
					'waist':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					'hips':
						res.hair_base_length = 'short'
						res.hair_assist_length = 'long'
						res.hair_back_length = 'long'
					_:
						res.hair_base_length = 'short'
						res.hair_assist_length = 'short'
						res.hair_back_length = 'short'
			'bun':
				res.hair_base = 'back'
				res.hair_assist = 'bun'
				res.hair_back = 'no'
				res.hair_base_length = 'short'
				res.hair_assist_length = 'short'
				res.hair_back_length = 'short'
	res.hair_fringe = res.hair_base #temp, 2fix
	res.hair_fringe_length = res.hair_base_length #possibly 2fix
	res.hair_fringe_color_1 = res.hair_base_color_1 #keep this
	res.hair_fringe_color_2 = res.hair_base_color_2 #keep this
	return res


func set_hairs(): #temporal solution
	var data = get_hairs_data()
	for stat in data:
		update_stat(stat, data[stat])


#legacy
func get_stat_old(statname):
	if statname.begins_with('hair_'): 
		return get_combined_hairs_data()[statname]
	if statname.ends_with('virgin'):
		return (statlist[statname + '_lost'] == null)


func set_stat_old(st, value): #possibly obsolete
	parent.get_ref().reset_rebuild()
#	if st in ['physics', 'wits', 'charm']: 
#		statlist[st] = min(value, get_stat(st + '_cap'))
#	else: statlist[st] = value
#	if st.ends_with('_factor'):
#		statlist[st] = clamp(statlist[st], variables.minimum_factor_value, variables.maximum_factor_value)
#	if st.begins_with('chg_'):
#		statlist[st] = int(max(0, statlist[st]))
#	if st == 'lust':
#		statlist.lust = clamp(value, 0, get_stat('lustmax'))

#sex stuff
#can move them to another component - along with sex-related stats
func access_sexexp(): # I DO NO LIKE TO DO SO - but incapsulating all of them in reasonable time is impassible
	return sexexp


func get_sex_skills(): # I DO NO LIKE TO DO SO - but incapsulating all of them in reasonable time is impassible
	return sex_skills


func get_sex_traits():
	return sex_traits.keys()


func get_negative_sex_traits():
	return negative_sex_traits


func get_unlocked_sex_traits():
	return unlocked_sex_traits


func make_trait_known(trait):
	if sex_traits.has(trait):
		sex_traits[trait] = true
	if negative_sex_traits.has(trait):
		negative_sex_traits[trait] = true


func remove_negative_sex_trait(code):
	negative_sex_traits.erase(code)


func add_sex_trait(code, known = false):
	if parent.get_ref().has_status("no_sex_traits"): 
		return
	var trait = Traitdata.sex_traits[code]
	if trait.negative == true:
		negative_sex_traits[code] = known
	else:
		if !unlocked_sex_traits.has(code):
			unlocked_sex_traits.push_back(code)
		if !sex_traits.has(code):
			sex_traits[code] = known
			if parent.get_ref().is_players_character:
				var text = get_short_name() + ": " + "New Sexual Trait Acquired - " + Traitdata.sex_traits[code].name
				globals.text_log_add('char', text)


func remove_sex_trait(code, absolute = true):
	if absolute: 
		unlocked_sex_traits.erase(code)
	sex_traits.erase(code)


func unlock_sex_trait(code):
	if parent.get_ref().has_status("no_sex_traits"): 
		return
	unlocked_sex_traits.push_back(code)


func create_s_trait_select(trait_id):
#	if sex_traits.has(trait_id):
#		sex_traits.erase(trait_id)
#		unlocked_sex_traits.erase(trait_id)
#	else:
	sex_traits.clear()
	unlocked_sex_traits.clear()
	sex_traits[trait_id] = true
	unlocked_sex_traits.push_back(trait_id)


var skill_shortcuts = {
	vaginal_virgin = 'pussy',
	anal_virgin = "anal",
	mouth_virgin = 'oral',
	penis_virgin = 'penetration',
}

func get_sex_features():
	match statlist.sex:
		'female':
			if globals.rng.randi_range(0, 100) >= variables.female_vagina_virgin_default_chance:
				statlist.vaginal_virgin_lost = 'unknown'
			if globals.rng.randi_range(0, 100) >= variables.female_ass_virgin_default_chance:
				statlist.anal_virgin_lost = 'unknown'
		'male':
			if globals.rng.randi_range(0, 100) >= variables.male_penis_virgin_default_chance:
				statlist.penis_virgin_lost = 'unknown'
			if globals.rng.randi_range(0, 100) >= variables.male_ass_virgin_default_chance:
				statlist.anal_virgin_lost = 'unknown'
		'futa':
			if globals.rng.randi_range(0, 100) >= variables.male_penis_virgin_default_chance:
				statlist.penis_virgin_lost = 'unknown'
			if globals.rng.randi_range(0, 100) >= variables.female_vagina_virgin_default_chance:
				statlist.vaginal_virgin_lost = 'unknown'
			if globals.rng.randi_range(0, 100) >= variables.female_ass_virgin_default_chance:
				statlist.anal_virgin_lost = 'unknown'
	
	if statlist.anal_virgin_lost != null:
		statlist.mouth_virgin_lost = statlist.anal_virgin_lost
	if statlist.vaginal_virgin_lost != null:
		statlist.mouth_virgin_lost = statlist.vaginal_virgin_lost
	
	for i in ['vaginal_virgin', 'anal_virgin', 'mouth_virgin','penis_virgin']:
		if statlist[i + '_lost'] != null:
			sex_skills[skill_shortcuts[i]] = rand_range(1,10)
	set_virginity_data()


func set_virginity_data():
	for i in ['vaginal_virgin', 'anal_virgin', 'mouth_virgin','penis_virgin']:
		if statlist[i+'_lost'] == 'master':
			statlist[i+'_lost'] = ResourceScripts.game_party.get_master().id
			metrics.metrics_partners.append(ResourceScripts.game_party.get_master().id)


func add_random_sex_skill():
	var array = ['sex_skills_petting']
	for i in ['vaginal_virgin', 'anal_virgin', 'mouth_virgin','penis_virgin']:
		if statlist[i + '_lost'] != null:
			array.append(skill_shortcuts[i])
	
	if get_stat('penis_size') != '':
		array.append('sex_skills_penetration')
	if get_stat('tail') in variables.longtails:
		array.append('sex_skills_tail')
	
	array = input_handler.random_from_array(array)
	sex_skills[array] += rand_range(3,8)


#generating char stuff
func fill_masternoun():
	if parent.get_ref().has_profession('master'):
		if statlist.sex == 'male':
			statlist.masternoun = tr('PROFMASTER').to_lower()
		else:
			statlist.masternoun = tr('PROFMASTERALT').to_lower()
	elif ResourceScripts.game_party.get_master().get_stat('sex') == 'male':
		statlist.masternoun = tr('PROFMASTER').to_lower()
	else:
		statlist.masternoun = tr('PROFMASTERALT').to_lower()


func process_chardata(chardata, unique = false):
	if unique:
		 statlist.unique = chardata.code
	for i in chardata:
		if !(i in ['code', 'slave_class', 'tags','sex_traits', 'sex_skills', 'personality', 'training_disposition', 'blocked_training_traits', 'traits', 'food_like', 'food_hate', 'classes', 'skills']):
			var st_data = statdata.statdata[i]
			if st_data.direct:
				update_stat(i, chardata[i], 'set')
	if chardata.has("sex_traits"):
		for i in chardata.sex_traits:
			add_sex_trait(i)
	if chardata.has("sex_skills"):
		for skill in chardata.sex_skills:
			sex_skills[skill] = chardata.sex_skills[skill]
	if chardata.has('icon_image'):
		statlist.dynamic_portrait = false
	if chardata.has('personality'):
		update_personality(chardata.personality)
	set_virginity_data()


func update_chardata(chardata):
	#possible 2do remove of innate effects
	statlist.unique = chardata.code
	for i in chardata:
		if !(i in variables.personal_stats):
			continue
		update_stat(i, chardata[i], 'set')
#	if chardata.has("traits"):
#		for i in chardata.traits:
#			add_trait(i)
	if chardata.has("sex_skills"):
		for skill in chardata.sex_skills:
			sex_skills[skill] = chardata.sex_skills[skill]
	if chardata.has('icon_image'):
		statlist.dynamic_portrait = false


func roll_growth(diff):
	var weight = {}
	weight[1] = 100 - (diff - 1) * 100.0/14.0
	weight[4] = 5 + (diff - 1) * 10.0/14.0
	weight[5] = 2 + (diff - 1) * 7.0/14.0
	weight[6] = 0.7 + (diff - 1) * 4.0/14.0
	if diff <= 3:
		weight[2] = 40 + (diff - 1) * 10.0/2.0
	else:
		weight[2] = 50 - (diff - 3) * 45.0/12.0
	if diff <= 5:
		weight[3] = 25 + (diff - 1) * 35.0/4.0
	else:
		weight[3] = 60 - (diff - 5) * 25.0/10.0
	var tmp = input_handler.weightedrandom_dict(weight)
	update_stat('growth_factor', tmp, 'set')


func generate_random_character_from_data(races, desired_class = null, adjust_difficulty = 0):
	adjust_difficulty = min(adjust_difficulty, 15)
	var gendata = {race = '', sex = 'random', age = 'random'}

	if typeof(races) == TYPE_STRING && races == 'random':
		gendata.race = races.get_random_race()
	elif typeof(races) == TYPE_STRING:
		gendata.race = races
	else:
		gendata.race = input_handler.random_from_array(races)
	parent.get_ref().create(gendata.race, gendata.sex, gendata.age)
	
	roll_growth(adjust_difficulty)
	
	var slaveclass = desired_class
	if slaveclass == null:
		slaveclass = input_handler.weightedrandom([['combat', 1],['magic', 1],['social', 1],['sexual',1], ['labor',1]])
	
	if slaveclass == 'magic' && statlist.magic_factor == 1: #prevents finding no class as there's no magic base classes which allow magic factor < 2
		statlist.magic_factor = 2
	
	var difficulty = int(round(adjust_difficulty))
	var classcounter = round(rand_range(variables.slave_classes_per_difficulty[difficulty][0], variables.slave_classes_per_difficulty[difficulty][1]))
	
	#Add extra stats for harder characters
	var bonus_counter = 0
	while difficulty > 0 && bonus_counter < 10:
		var array = []
		array = ['physics_factor', 'magic_factor', 'wits_factor','sexuals_factor', 'charm_factor']
		array = input_handler.random_from_array(array)
		if randf() >= 0.2:
			update_stat(array, round(rand_range(0,2)), 'add')
		if randf() >= 0.5:
			update_stat(input_handler.random_from_array(['tame_factor','authority_factor']), round(rand_range(-1,1)), 'add')
		difficulty -= 1
		bonus_counter += 1
	
	difficulty = adjust_difficulty / 2
	while difficulty > -1:
		var array = []
		array = ['physics', 'wits','sexuals', 'charm']
		array = input_handler.random_from_array(array)
		if randf() >= 0.7:
			if array == 'sexuals':
				add_random_sex_skill()
			else:
				update_stat(array, rand_range(1,15), 'add')
		difficulty -= 1

	#assign classes
	while classcounter > 0:
		if randf() > 0.65:
			classcounter -= 1
			continue
		var classarray = []
		if randf() >= 0.85:
			classarray = parent.get_ref().get_class_list('any', parent.get_ref())
		else:
			classarray = parent.get_ref().get_class_list(slaveclass, parent.get_ref())
		if classarray != null && classarray.size() > 0:
			parent.get_ref().unlock_class(input_handler.random_from_array(classarray).code, true)
		classcounter -= 1

	var traitarray = []
	#assign sex traits
	for i in Traitdata.sex_traits.values():
		if i.negative == true && i.random_generation == true && parent.get_ref().checkreqs(i.acquire_reqs) == true:
			traitarray.append(i)
	var rolls = 2
	while rolls > 0:
		var newtrait = input_handler.random_from_array(traitarray)
		add_sex_trait(newtrait.code)
		traitarray.erase(newtrait)
		rolls -= 1
	traitarray.clear()
	rolls = 1
	for i in Traitdata.sex_traits.values():
		if i.negative == false && i.random_generation == true && parent.get_ref().checkreqs(i.acquire_reqs) == true:
			traitarray.append(i)
	while rolls > 0:
		var newtrait = input_handler.random_from_array(traitarray)
		add_sex_trait(newtrait.code)
		traitarray.erase(newtrait)
		rolls -= 1
#	get_random_traits(trait_blacklist)


func generate_simple_fighter(data):
	statlist.icon_image = data.icon
	statlist.xpreward = data.xpreward
	statlist.loottable = data.loot
	statlist.name = data.name
	statlist.race = ""
	statlist.racegroup = data.race


func create(temp_race, temp_gender, temp_age):
	if temp_race == 'halfbreeds':
		temp_race = 'halfbeast'
	statlist.race = temp_race
	statlist.sex = temp_gender
	statlist.age = temp_age
	
	if temp_race == 'random':
		statlist.race = races.get_random_race()
	elif races.race_groups.has(temp_race):
		statlist.race = input_handler.random_from_array(races.race_groups[temp_race])
	if temp_gender == 'random':
		statlist.sex = get_random_sex()
	if temp_age == 'random':
		statlist.age = get_random_age()
	
	get_sex_features()
	
	if input_handler.globalsettings.furry == false && statlist.race.find("Beastkin") >= 0:
		statlist.race = statlist.race.replace("Beastkin","Halfkin")
	
	update_personality(input_handler.random_from_array(variables.personality_array))
	
	get_racial_features()
	get_random_name()
	get_random_colors()
	random_icon()
	
	for i in ResourceScripts.descriptions.bodypartsdata:
		var tval = get_stat(i)
		if ResourceScripts.descriptions.bodypartsdata[i].has(tval):
			if ResourceScripts.descriptions.bodypartsdata[i][tval].bodychanges.size() > 0:
				apply_custom_bodychange(i, tval)
	set_hairs() #temporal, remove this later!!
	parent.get_ref().set_slave_category('slave')
	if input_handler.globalsettings.generate_portraits:
		make_random_portrait()


func get_racial_features():
	var race_template = races.racelist[statlist.race]
	for i in race_template.basestats:
		parent.get_ref().set_stat(i, round(rand_range(race_template.basestats[i][0], race_template.basestats[i][1]))) 
	parent.get_ref().training.setup_dispositions(statlist.race)
	for i in races.racelist.Human.bodyparts:
		if races.racelist.Human.bodyparts[i].empty():
			continue
		if typeof(races.racelist.Human.bodyparts[i][0]) in [TYPE_STRING, TYPE_BOOL, TYPE_INT]:
			update_stat(i, input_handler.random_from_array(races.racelist.Human.bodyparts[i]), 'set')
		else:
			update_stat(i, input_handler.weightedrandom(races.racelist.Human.bodyparts[i]), 'set')
	if statlist.race != 'Human':
		for i in race_template.bodyparts:
			if typeof(race_template.bodyparts[i][0]) in [TYPE_STRING, TYPE_BOOL, TYPE_INT]:
				update_stat(i, input_handler.random_from_array(race_template.bodyparts[i]), 'set')
			else:
				update_stat(i, input_handler.weightedrandom(race_template.bodyparts[i]), 'set')
	
	if race_template.tags.has("multibreasts") && input_handler.globalsettings.furry_multiple_nipples == true:
		statlist.multiple_tits = variables.furry_multiple_nipples_number
	
	if race_template.has("combat_skills"):
		for i in race_template.combat_skills:
			parent.get_ref().learn_c_skill(i)
	
	parent.get_ref().food.get_racial_features(statlist.race)
	
	var array = []
	if race_template.has('personality'):
		for i in race_template.personality:
			array.append([i, race_template.personality[i]])
		update_personality(input_handler.weightedrandom(array))


func apply_custom_bodychange(target, part):
	update_stat(target, part, 'set')
	for i in ResourceScripts.descriptions.bodypartsdata[target][part].bodychanges:
		if parent.get_ref().checkreqs(i.reqs) == true:
			var newvalue = i.value
			if typeof(newvalue) == TYPE_ARRAY:
				if typeof(newvalue[0]) == TYPE_ARRAY:
					newvalue = input_handler.weightedrandom(newvalue)
				else:
					newvalue = input_handler.random_from_array(newvalue)
			update_stat(i.code, newvalue, 'set')


func get_random_sex():
	if randf()*100 <= input_handler.globalsettings.malechance:
		return 'male'
	elif randf()*100 <= input_handler.globalsettings.futachance && input_handler.globalsettings.futa == true:
		return 'futa'
	else:
		return 'female'


func get_random_age():
	var array = []
	for i in ['teen','adult','mature']:
		array.append([i, variables.get(i+"_age_weight")])
	return input_handler.weightedrandom(array)


func get_random_name(keep_surname = false):
	var text = statlist.race.to_lower() + statlist.sex.replace("futa",'female')
	if !Namedata.namelist.has(text):
		text = 'human'+ statlist.sex.replace("futa",'female')
	statlist.name = Namedata.namelist[text][randi() % Namedata.namelist[text].size()]
	if keep_surname and statlist.surname != '': 
		return
	if Namedata.namelist.has(statlist.race.to_lower() + 'surname'):
		statlist.surname = Namedata.namelist[statlist.race.to_lower() + "surname"][randi() % Namedata.namelist[statlist.race.to_lower() + "surname"].size()]
	elif statlist.race.find("Halfkin") >= 0 || statlist.race.find("Beastkin") >= 0:
		statlist.surname = Namedata.getRandomFurrySurname()


func get_random_colors():
#	statlist.armor_color = {}
#	for base in Items.armor_colors:
#		statlist.armor_color[base] = input_handler.random_from_array(Items.armor_colors[base])
	for base in armor_color:
		armor_color[base] = input_handler.random_from_array(Items.color_presets)


func random_icon():
	var array = []
	var racenames = statlist.race.split(" ")
#commented because runtame error, need not fixing here
#	for i in globals.dir_contents(globals.globalsettings.portrait_folder):
#		for k in racenames:
#			if i.findn(k) >= 0:
#				array.append(i)
#				continue
	if array.size() > 0:
		statlist.icon_image = input_handler.random_from_array(array)
		statlist.dynamic_portrait = false

func get_icon():
	if statlist.icon_image in ['', null]:
		return null
	if statlist.icon_image is String:
		return input_handler.loadimage(statlist.icon_image, 'portraits')
	else:
		return statlist.icon_image


func get_icon_path():
	if typeof(statlist.icon_image) != TYPE_STRING:
		return null
	if statlist.icon_image in ['', null]:
		return ""
	return statlist.icon_image


func get_stored_body_image(): 
	var tmp 
	if images.sprites.has(statlist.body_image):
		tmp = input_handler.loadimage(images.sprites[statlist.body_image], 'shades')
	else:
		tmp = input_handler.loadimage(statlist.body_image, 'shades')
	return tmp


func get_body_image(): 
	var tmp = get_stored_body_image()
	if tmp != null:
		return tmp
	else:
		var text = statlist.race.to_lower().replace('halfkin','beastkin')
		if statlist.sex == 'male':
			text += "_m"
		else:
			text += "_f"
		if images.shades.has(text):
			return images.get_shade(text)
		else:
			return null
	return load(statlist.body_image)#can't be returned?


func get_all_sex_traits():
	var return_traits = {}
	for i in sex_traits:
		return_traits[i] = sex_traits[i]
	for i in negative_sex_traits:
		return_traits[i] = negative_sex_traits[i]
	return return_traits


func baby_transform(mother):
#	var mother = characters_pool.get_char_by_id(statlist.relatives.mother) #ResourceScripts.game_party.characters[statlist.relatives.mother]
	statlist.name = 'Child of ' + mother.get_short_name()
	statlist.surname = mother.get_stat('surname')
	if statlist.surname != '':
		statlist.name += " " + statlist.surname
	statlist.anal_virgin_lost = null
	statlist.mouth_virgin_lost = null
	statlist.penis_virgin_lost = null
	statlist.vaginal_virgin_lost = null


#routine
func tick():
	update_stat('lust', parent.get_ref().get_stat('lusttick'), 'add')
	if pregnancy.pregnancy_duration > 0 && pregnancy.pregnancy_baby != null:
		var is_breeder = parent.get_ref().check_trait('breeder')
		pregnancy.pregnancy_duration -= 1
		if pregnancy.pregnancy_duration * 3 <= variables.pregduration * 2 and !parent.get_ref().has_status('pregnant'):
			if !pregnancy.pregnancy_reported:
				var text = tr("LOGREPORTPREGNANCY")
				if parent.get_ref().has_profession('master'): text = tr('LOGREPORTPREGNANCYMASTER')
				pregnancy.pregnancy_reported = true
				globals.text_log_add('char', translate(text))
#			if !is_breeder:
#				var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_pregnancy)
#				parent.get_ref().apply_effect(effects_pool.add_effect(eff))
		if pregnancy.pregnancy_duration * 3 <= variables.pregduration:
#			if is_breeder and !parent.get_ref().has_status('pregnant') or !is_breeder and !parent.get_ref().has_status('heavy_pregnant'):
#				var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_pregnancy)
#				parent.get_ref().apply_effect(effects_pool.add_effect(eff))
			if !get_stat('lactation') && get_stat('tits_size') != 'masculine':
				update_stat('lactation', true, 'set')
		if pregnancy.pregnancy_duration == 0:
			pregnancy.pregnancy_reported = false
			if true: #has_status('relation'): #or another
				input_handler.interactive_message('childbirth', 'childbirth', {pregchar = parent.get_ref()})
			else:
				input_handler.interactive_message('childbirth_alt', 'childbirth', {pregchar = parent.get_ref()})

var sex_nouns = {male = tr("PRONOUNSEX"), female = tr("PRONOUNSEXF"), futa = tr("PRONOUNSEXH")}

func get_pronoun_value(pronoun):
	match pronoun:
		"He": return globals.fastif(statlist.sex == 'male', tr('PRONOUNHE'), tr("PRONOUNHEF")) # PRONOUNHE = "He", 
		"he": return globals.fastif(statlist.sex == 'male', tr('PRONOUNHEL'), tr("PRONOUNHELF"))
		"his": return globals.fastif(statlist.sex == 'male', tr('PRONOUNHISL'), tr("PRONOUNHISLF"))
		"him": return globals.fastif(statlist.sex == 'male', tr('PRONOUNHIML'), tr("PRONOUNHIMLF"))
		"His": return globals.fastif(statlist.sex == 'male', tr('PRONOUNHIS'), tr("PRONOUNHISF"))
		"Sir": return globals.fastif(statlist.sex == 'male', tr('PRONOUNSIR'), tr("PRONOUNSIRF"))
		"sir": return globals.fastif(statlist.sex == 'male', tr('PRONOUNSIR'), tr("PRONOUNSIRF"))
		"mister": return globals.fastif(statlist.sex == 'male', tr('PRONOUNMISTER'), tr("PRONOUNMISTERF"))
		"son": return globals.fastif(statlist.sex == 'male', tr('PRONOUNSON'), tr("PRONOUNSONF"))
		"father": return globals.fastif(statlist.sex == 'male', tr('PRONOUNFATHER'), tr("PRONOUNFATHERF"))
		"brother": return globals.fastif(statlist.sex == 'male', tr('PRONOUNBROTHER'), tr("PRONOUNBROTHERF"))
		"gentleman": return globals.fastif(statlist.sex == 'male', tr('PRONOUNGENTLEMAN'), tr("PRONOUNGENTLEMANF"))
		"raceadj": return races.racelist[statlist.race].adjective if statlist.race != "" else ""
		"race": return races.racelist[statlist.race].name if statlist.race != "" else ""
		"race_short": return input_handler.random_from_array(races.short_race_names[races.racelist[statlist.race].code]) if statlist.race != "" else ""
		"name": return get_short_name()
		"surname": return globals.fastif(statlist.surname != '', statlist.surname, get_short_name())
		"age": return statlist.age.capitalize()
		"male": return sex_nouns[statlist.sex]
		"eye_color": return statlist.eye_color
		"hair_color": return tr("HAIRCOLOR_" + get_stat('hair_color').to_upper())
		"man": return globals.fastif(statlist.sex == 'male', tr('PRONOUNMAN'), tr("PRONOUNMANF"))
		"guy": return globals.fastif(statlist.sex == 'male', tr('PRONOUNGUY'), tr("PRONOUNGUYF"))
		"husband": return globals.fastif(statlist.sex == 'male', tr('PRONOUNHUSBAND'), tr("PRONOUNHUSBANDF"))
		"groom": return globals.fastif(statlist.sex == 'male', tr('PRONOUNGROOM'), tr("PRONOUNGROOMF"))
		"master", "Master":
#			var masternoun = 'master'
			var tempmasternoun = statlist.masternoun
			if parent.get_ref() != null:
				if tempmasternoun in ['master','mistress']:
					if input_handler.meowingcondition(parent.get_ref()) == true:
						tempmasternoun = 'myaster'
					if ResourceScripts.game_party.get_master() != null && ResourceScripts.game_party.get_master().get_stat('sex') != 'male':
						if input_handler.meowingcondition(parent.get_ref()) == true:
							tempmasternoun = 'mewstress'
			else:
				print('error in character %s - no root object' % statlist.name)
			if pronoun == "Master":
				return tempmasternoun.capitalize()
			return tempmasternoun
		"boygirlfuta":
			match statlist.sex:
				'male':
					return 'boy'
				'female':
					return 'girl'
				'futa':
					return 'futanari'
		"boy": return globals.fastif(statlist.sex == 'male', 'boy', 'girl')
		"himself": return globals.fastif(statlist.sex == 'male', tr('PRONOUNHIMSELFL'), tr("PRONOUNHIMSELFLF"))

func translate(text, number = -1):
	for pronoun in variables.text_pronouns:
		var number_str = ""
		if number > -1:
			number_str = String(number)
		text = text.replace("[%s%s]" % [pronoun, number_str], get_pronoun_value(pronoun))
	return text


func make_random_portrait():
	statlist.icon_image = ResourceScripts.rnd_main.setrandom(statlist) 
	if statlist != null && statlist.icon_image != null && !statlist.icon_image.empty(): # this if sets the matching body image
		statlist.dynamic_portrait = false
		var fullImagePath = statlist.icon_image.replacen(input_handler.globalsettings.portrait_folder, input_handler.globalsettings.body_folder)
		if File.new().file_exists(fullImagePath):
			statlist.body_image = fullImagePath 


func change_personality_stats(stat, init_value, communicative = false):
	var prim_stat
	var primaxis = ''
	var altaxis = ''
	var value = init_value
	
	if stat == 'bold':
		primaxis = 'personality_bold'
		altaxis = 'personality_kind'
		prim_stat = get_stat("authority_factor")
	else:
		primaxis = 'personality_kind'
		altaxis = 'personality_bold'
		prim_stat = get_stat("tame_factor")
	
	var rebel = false
	
#	value = value*1+rand_range(0.2,-0.2)
	value *= 1 + rand_range(0.2,-0.2)
	
	#if character's factor chance is lower than check, then character goes opposite direction on personality grid
	var backfire_chance = 100 - variables.factor_personality_changes[prim_stat][0]
	if communicative:
		backfire_chance *= 0.5
	if randf() * 100 <= backfire_chance: 
		value = -value
		rebel = true
	
	var secondary_axis_change = 0
	if variables.factor_personality_changes[prim_stat][1] >= randf() * 100: #if character's factor chance is lower than check, thne character's secondary axist fluctate
		secondary_axis_change = value / 2.0
		if randf() >= 0.5:
			 secondary_axis_change = -secondary_axis_change
	
	if communicative:
		value *= 2
	var newvalue = [int(value), int(secondary_axis_change)]
	
	statlist[primaxis] += newvalue[0]
	statlist[altaxis] += newvalue[1]
	check_old_personality()
	
	parent.get_ref().update_prt()
	
	return [newvalue, rebel]

#tattoos
func can_add_tattoo(slot, code):
	if !Traitdata.get_slot_list_for_tat(code).has(slot): 
		return false
	var template = Traitdata.tattoodata[code]
	if tattoo[slot] == code :
		return false
	if template.has('conditions'):
		if !parent.get_ref().checkreqs(template.conditions): 
			return false
	if ResourceScripts.game_res.if_has_material(template.item, 'lt', 1): 
		return false
	if !template.can_repeat:
		for s in tattoo:
			if tattoo[s] == code: 
				return false
	return true


func add_tattoo(slot, code) -> bool:
	if !can_add_tattoo(slot, code): 
		return false
	var template = Traitdata.tattoodata[code]
	if tattoo[slot] != null: 
		remove_tattoo(slot)
	tattoo[slot] = code
	parent.get_ref().reset_rebuild()
	return true


func remove_tattoo(slot):
	if tattoo[slot] == null: 
		return
	var arr = parent.get_ref().find_eff_by_tattoo(slot, tattoo[slot])
	for e in arr:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()
	tattoo[slot] = null
	parent.get_ref().reset_rebuild()


func get_tattoos():
	return tattoo.duplicate()


func get_tattoo(slot):
	if tattoo.has(slot):
		return tattoo[slot]
	return null


func get_filled_tattoos():
	var res = []
	for slot in tattoo:
		if tattoo[slot] != null:
			res.push_back(slot)
	return res
