#not used
#keep as reminder

extends Node

func revert():
	#globals._ready()
	input_handler.encounter_win_script = null
	input_handler.encounter_lose_scripts.clear()
	

func _ready():
	postinit()

func postinit():
	#call_deferred('revert')
	pass


#never used
#func if_has_property(prop, value):
#	var tmp = get(prop)
#	if tmp == null: 
#		print ("ERROR: NO PROPERTY IN GAMESTATE %s\n", prop)
#		return false
#	return (tmp >= value)



func serialize():
	var tmp = {}
#	#to add serializing
#	tmp['characters'] = characters_pool.serialize()
#	tmp['state'] = inst2dict(self)
#	#tmp['state']['items'].clear()
#	#tmp['state']['characters'].clear()
#	tmp['items'] = {}
#	tmp['heroes'] = {}
#	tmp['babies'] = {}
#	for i in items:
#		tmp['items'][i] = inst2dict(items[i])
#	for h in characters:
#		tmp['heroes'][h] = inst2dict(characters[h])
#		characters[h].fix_serialize(tmp['heroes'][h])
#	for h in babies:
#		tmp['babies'][h] = inst2dict(babies[h])
#		babies[h].fix_serialize(tmp['babies'][h])
#	tmp['effects'] = effects_pool.serialize()
	return tmp

func deserialize(tmp:Dictionary):
	characters_pool.deserialize(tmp['characters'])
#	var tempstate = dict2inst(tmp['state'])
#	var prlist = tempstate.get_property_list()
#	#set('date', tempstate.get('date'))
#	for v in prlist:
#		if !(v.usage & PROPERTY_USAGE_SCRIPT_VARIABLE) : continue
#		set(v.name, tempstate.get(v.name))
#	selected_upgrade.level = int(selected_upgrade.level)
#	items.clear()
#	for i in tmp['items']:
#		items[i] = dict2inst(tmp['items'][i])
#		items[i].inventory = items
#	characters.clear()
#	for h in tmp['heroes']:
#		characters[h] = dict2inst(tmp['heroes'][h])
#		#fixing saved skill shortcuts
#		var ssp = characters[h].social_skill_panel.duplicate()
#		characters[h].social_skill_panel.clear()
#		for i in ssp:
#			if Skilldata.Skilllist.has(ssp[i]):
#				characters[h].social_skill_panel[int(i)] = ssp[i]
#		ssp = characters[h].combat_skill_panel.duplicate()
#		characters[h].combat_skill_panel.clear()
#		for i in ssp:
#			if Skilldata.Skilllist.has(ssp[i]):
#				characters[h].combat_skill_panel[int(i)] = ssp[i]
#		var cleararray = []
#		for i in [characters[h].social_skills, characters[h].combat_skills]:
#			for k in i:
#				if Skilldata.Skilllist.has(k) == false:
#					cleararray.append(k)
#		for i in cleararray:
#			for k in [characters[h].social_skills, characters[h].combat_skills]:
#				k.erase(i)
	
#	if tmp.has('babies'):
#		for h in tmp['babies']:
#			babies[h] = dict2inst(tmp['babies'][h])
#			#fixing saved skill shortcuts
#			var ssp = babies[h].social_skill_panel.duplicate()
#			babies[h].social_skill_panel.clear()
#			for i in ssp:
#				if Skilldata.Skilllist.has(ssp[i]):
#					babies[h].social_skill_panel[int(i)] = ssp[i]
#			ssp = babies[h].combat_skill_panel.duplicate()
#			babies[h].combat_skill_panel.clear()
#			for i in ssp:
#				if Skilldata.Skilllist.has(ssp[i]):
#					babies[h].combat_skill_panel[int(i)] = ssp[i]
#			var cleararray = []
#			for i in [babies[h].social_skills, babies[h].combat_skills]:
#				for k in i:
#					if Skilldata.Skilllist.has(k) == false:
#						cleararray.append(k)
#			for i in cleararray:
#				for k in [babies[h].social_skills, babies[h].combat_skills]:
#					k.erase(i)
#
#	tempstate.free()
#	effects_pool.deserialize(tmp['effects'])
#	#fastfix for broken saves
#	characters_pool.cleanup()
#	effects_pool.cleanup()
	
#	for i in Items.materiallist:
#		if materials.has(i) == false:
#			materials[i] = 0
	

