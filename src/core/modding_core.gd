extends Node
#3.1 version for data modding
#script modding to be added in 3.2 version 

var modconfig_path = "user://mods.ini"
var modfolder_path = "user://mods"

var mods_list = [] #name, data_file, config_file
var mod_tables = {} #table, mod
var tables = {} #table, parsed content 

var current_mod = ""
var data_loaded = false

#never really filled, only format
var avaliable_modes_list = [] #name, data_file, desc

func _ready():
	get_mods_list()
	process_pathes_mods()
	process_extensions_mods()
	process_script_mods()
	ResourceScripts.load_scripts()

func process_data_mods():
	if data_loaded: return
	for m in mods_list:
		current_mod = m.name
		process_mod(m)
	data_loaded = true

func process_script_mods():
	for m in mods_list:
		process_pack(m)

func process_pathes_mods():
	for m in mods_list:
		process_pathes(m)

func process_extensions_mods():
	for m in mods_list:
		process_extensions(m)

func get_mods_list():
	var f := File.new()
	if !f.file_exists(modconfig_path) : 
		f.open(modconfig_path, File.WRITE)
		var tres = []
		f.store_line(to_json(tres))
		f.close()
		mods_list.clear()
		return
	f.open(modconfig_path, File.READ)
	var tres = f.get_as_text()
	f.close()
	mods_list = parse_json(tres)
	check_avail()
	for f in mods_list:
		var mconf := ConfigFile.new()
		mconf.load(f.path)
		f.config = mconf

func save_mod_list():
	check_avail()
	for f in mods_list:
		f.erase('config')
	var f:= File.new()
	f.open(modconfig_path, File.WRITE)
	f.store_line(to_json(mods_list))
	f.close()

func check_avail():
	var to_del = []
	for i in range(mods_list.size()):
		if !File.new().file_exists(mods_list[i].path) : to_del.push_front(i)
	for i in to_del: mods_list.remove(i)

func get_avail_mods():
	var res = []
	var d := Directory.new()
	if !d.dir_exists(modfolder_path): 
		d.make_dir(modfolder_path)
		return res
	d.open(modfolder_path)
	d.list_dir_begin(true, true)
	var temppath = d.get_next()
	while temppath != "":
		if d.current_is_dir(): 
			var moddir := Directory.new()
			moddir.open(d.get_current_dir() + '/' + temppath)
			if moddir.file_exists("mod_config.ini"):
				var cfgpath = moddir.get_current_dir() + "/mod_config.ini"
				var mconf := ConfigFile.new()
				mconf.load(cfgpath)
				var temp = {name = mconf.get_value('General','Name'), path = cfgpath, desc = 'No description'}
				if mconf.has_section_key('General','Description'): temp.desc = mconf.get_value('General','Description')
				res.push_back(temp)
		temppath = d.get_next()
	return res

func process_mod(data):
	var mconf = data.config
#	mconf.load(path)
	print("processing data tables from mod %s" % mconf.get_value('General','Name'))
	if !mconf.has_section('Data'): return
	var datafiles = mconf.get_section_keys('Data')
	var dir = data.path.get_base_dir()
	for table in datafiles:
		process_data_file(dir, mconf.get_value('Data', table), table)

func process_pathes(data):
	var mconf = data.config
#	mconf.load(path)
	print("processing pathes from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('Pathes')
	for script in datafiles:
		var tpath =  mconf.get_value('Pathes', script)
		if tpath.ends_with('.gd'):
			ResourceScripts.scriptdict[script] = tpath
		if tpath.ends_with('.tscn'):
			ResourceScripts.scenedict[script] = tpath

func process_extensions(data):
	var mconf = data.config
#	mconf.load(path)
	print("processing parametrized extension scripts from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('CEScripts')
	for script in datafiles:
		process_script_extend(script, mconf.get_value('CEScripts', script))

func process_pack(data):
	var mconf = data.config
#	mconf.load(path)
	print("processing packages from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('Packages')
	var dir = data.path.get_base_dir()
	for table in datafiles:
		print("processing package %s" % table)
		ProjectSettings.load_resource_pack(dir + '/' + mconf.get_value('Packages', table))

func process_data_file(path : String, file: String, tablename : String):
	if mod_tables.has(tablename): 
		print("table %s has been already loaded" % tablename)
		return #the same table in different mods do not load
	var f := File.new()
	if !f.file_exists(path + "/" + file):
		print('ERROR in %s table path' % tablename)
		return
	print("processing table %s" % tablename)
	f.open(path + "/" + file, File.READ)
	var tmp = f.get_as_text()
	f.close()
	var tmp1 = parse_json(tmp)
	if tmp1 == null or typeof(tmp1) != TYPE_DICTIONARY:
		print('ERROR in %s table content' % tablename)
		return
	mod_tables[tablename] = current_mod
	tables[tablename] = tmp1.duplicate()
	fix_indexes_dict(tables[tablename])
	
	process_dir(tablename, 'effects', Effectdata.effect_table)
	process_dir(tablename, 'atomic_effects', Effectdata.atomic)
	process_dir(tablename, 'buffs', Effectdata.buffs)
	process_dir(tablename, 'item_materials', Items.materiallist)
	process_dir(tablename, 'items', Items.itemlist)
	process_dir(tablename, 'recipes', Items.recipes)
	process_dir(tablename, 'skills', Skilldata.Skilllist)
	process_dir(tablename, 'traits', Traitdata.traits)
	process_dir(tablename, 'sex_traits', Traitdata.sex_traits)
	process_dir(tablename, 'enemy_events', Enemydata.encounters)
	process_dir(tablename, 'enemies', Enemydata.enemies)
	process_dir(tablename, 'enemy_randomgroups', Enemydata.enemygroups)
	process_dir(tablename, 'loot_chests', Enemydata.loot_chests_data)
	process_dir(tablename, 'loot_enemy', Enemydata.loottables)
	process_dir(tablename, 'enemy_groups', Enemydata.predeterminatedgroups)
	#tasks are not moddable through data because they are linked to functors
	process_dir(tablename, 'races', races.racelist)
	process_dir(tablename, 'scenedata', scenedata.scenedict)
	process_dir(tablename, 'dialogues', scenedata.dialogue_inits)
	process_dir(tablename, 'scene_quests',scenedata.quests)
	process_dir(tablename, 'classes', classesdata.professions)
	process_dir(tablename, 'tasklist', races.tasklist)
	process_dir(tablename, 'upgrades', upgradedata.upgradelist)
	process_dir(tablename, 'classes', classesdata.professions)
	
	process_images_dir(tablename, 'i_backgrounds', images.backgrounds)
#	process_images_dir(tablename, 'i_circleportaits', images.circleportraits)
#	process_images_dir(tablename, 'i_combatfullpictures', images.combatfullpictures)
#	process_images_dir(tablename, 'i_combatportraits', images.combatportraits)
#	process_images_dir(tablename, 'i_gui', images.gui)
	process_dir(tablename, 'i_icons', images.icons)
	process_dir(tablename, 'i_portraits', images.portraits)
	process_dir(tablename, 'i_scenes', images.scenes)
	process_dir(tablename, 'i_bodyportraits', images.shades)
	process_dir(tablename, 'i_sprites', images.sprites)
	process_dir(tablename, 'i_cursors',images.cursors)
	process_dir(tablename, 'i_GFX',images.GFX)
	process_dir(tablename, 'i_GFX_particles', images.GFX_particles)
	process_dir(tablename, 'i_GFX_sprites', images.GFX_sprites)
	#adding audio data is not added
	#until runtime loading of audio would be tested and fixed
	process_dir(tablename, 'statdata', statdata.statdata)
	#tutorial data is not avaliable for now
	#process_dir(tablename, 'effects', .effect_table)
	process_dir(tablename, 'w_factions', worlddata.factiondata)
	process_dir(tablename, 'w_guilds', worlddata.guild_upgrades)
	process_dir(tablename, 'w_lands', worlddata.lands)
	process_dir(tablename, 'w_locations', worlddata.locations)
	process_dir(tablename, 'w_locationnames', worlddata.locationnames)
	process_dir(tablename, 'w_quests', worlddata.questdata)
	process_dir(tablename, 'w_dungeons', worlddata.dungeons)
	process_dir(tablename, 'w_characters', worlddata.pregen_characters)
	
	process_dir(tablename, 'statlist', Statlist_init.template)
	
	#incomplete

func fix_main_data_preload():#fixing incomplete data in core files, mostly moved from globals
	for i in classesdata.professions.values():
		i.name = tr("PROF" + i.code.to_upper())
		i.descript = tr("PROF" + i.code.to_upper()+"DESCRIPT")
		if i.has('altname'):
			i.altname = tr("PROF"+i.code.to_upper()+"ALT")
	
	for i in Items.materiallist.values():
		i.name = tr("MATERIAL" + i.code.to_upper())
		i.descript = tr("MATERIAL" + i.code.to_upper()+"DESCRIPT")
		i.adjective = tr("MATERIAL" + i.code.to_upper() + "ADJ")
	
	for i in Items.itemlist.values():
		i.name = tr("ITEM" + i.code.to_upper())
		i.descript = tr("ITEM" + i.code.to_upper()+"DESCRIPT")
	
	for i in Skilldata.Skilllist.values():
		if !i.has('name'):
			i.name = tr("SKILL" + i.code.to_upper())
		i.descript = tr("SKILL" + i.code.to_upper()+"DESCRIPT")
		if i.has('dialogue_text'):
			i.dialogue_text = tr("DIALOGUE" +i.code.to_upper() + "TEXT")
		if i.has('dialogue_report'):
			i.dialogue_report = tr("DIALOGUE" + i.code.to_upper() + "REPORT")
	
	for i in races.racelist.values():
		i.name = tr("RACE" + i.code.to_upper())
		i.descript = tr("RACE" + i.code.to_upper() + 'DESCRIPT')
		i.adjective = tr("RACE" + i.code.to_upper() + "ADJ")
	
	for i in races.tasklist.values():
		i.name = tr("TASK" + i.code.to_upper())
		i.descript = tr("TASK" + i.code.to_upper() + "DESCRIPT")
	
	for i in Traitdata.sex_traits.values():
		i.name = tr("SEXTRAIT" + i.code.to_upper())
		i.descript = tr("SEXTRAIT" + i.code.to_upper() + "DESCRIPT")
	
	for i in Traitdata.traits.values():
		i.name = tr("TRAIT" + i.code.to_upper())
		i.descript = tr("TRAIT" + i.code.to_upper() + "DESCRIPT")
	
	for i in worlddata.dungeons.values():
		i.classname = tr("LOCATIONNAME" + i.code.to_upper())
	
	for i in worlddata.locations.values():
		i.classname = tr(i.code.to_upper())
	
	for i in Enemydata.enemies.values():
		i.name = tr("ENEMY" + i.code.to_upper())
	
	#fix skills format
	for s in Skilldata.Skilllist:
		var tmp = Skilldata.Skilllist[s]
		if tmp.has('new_syntax') and tmp.new_syntax == true: continue
		var ss = ResourceScripts.scriptdict.class_sskill_legacy.new()
		ss.createfromskill(s)
		Skilldata.Skilllist[s] = ss.convert_to_new_template()

func fix_main_data_postload():#fixing incomplete data in core files, mostly moved from globals
	images.loadimages()
	
	for i in classesdata.professions.values():
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
	
	for i in Skilldata.Skilllist.values():
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
		if i.has('charges') and typeof(i.charges) == TYPE_REAL: i.charges = int(i.charges)
	
	for i in races.racelist.values():
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
	
	for i in Traitdata.traits.values():
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
	
	for i in statdata.statdata.values():
		if !i.has('baseicon'): continue
		if typeof(i.baseicon) == TYPE_STRING:
			i.baseicon = input_handler.loadimage(i.baseicon, 'icons')
	
	for i in Enemydata.enemies.values():
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'portraits')


func fix_indexes_array(arr: Array):
	if arr.size() == 0: return
	if typeof(arr[0])== TYPE_STRING and (arr[0] == 'parent_args' or arr[0] == 'parent_arg_get'): 
		arr[1] = int(arr[1])
		return
	if arr.size() > 2 and typeof(arr[1])== TYPE_STRING and arr[1] == 'mask': 
		arr[2] = int(arr[2])
		return
	for item in arr:
		if typeof(item) == TYPE_ARRAY: fix_indexes_array(item)
		if typeof(item) == TYPE_DICTIONARY: fix_indexes_dict(item)

func fix_indexes_dict(dict: Dictionary):
	if dict.has('index'): dict.index = int(dict.index)
	if dict.has('param') and typeof(dict.param) == TYPE_REAL: dict.param = int(dict.param)
	for val in dict.values():
		if typeof(val) == TYPE_ARRAY: fix_indexes_array(val)
		if typeof(val) == TYPE_DICTIONARY: fix_indexes_dict(val)

func process_dir(table_name, dir_name, location_dir):
	var table = tables[table_name]
	if !table.has(dir_name): return
	var dir = table[dir_name]
	for key in dir.keys(): 
		var patch = dir[key]
		if patch == null:
			location_dir.erase(key)
		elif typeof(patch) == TYPE_DICTIONARY:
			for k in patch: location_dir[key][k] = patch[k]
		else:
			location_dir[key] = patch

func process_images_dir(table_name, dir_name, location_dir):
	var table = tables[table_name]
	if !table.has(dir_name): return
	var dir = table[dir_name]
	for key in dir.keys(): location_dir[key] = input_handler.load_image_from_path(dir[key])

func save_mod(mod_name):
	var path = mod_tables[mod_name]
	var mconf := ConfigFile.new()
	mconf.load(path)
	var datafiles = mconf.get_section_keys('Data')
	var dir = path.get_base_dir()
	for table in datafiles:
		var f := File.new()
		f.open(dir + "/" + datafiles.get_value('Data', table), File.WRITE)
		f.store_line(to_json(tables[table]))
		f.close()

func process_script_extend(name, path):
	var file = File.new()
	if !file.file_exists(path):
		print('ERROR: no file at path %s' % path)
		return
	if !path.begins_with('user:'):
		print('WARNING: possibility of access denial to %s' % path)
	file.open(path, File.READ_WRITE)
	var tmp = file.get_as_text()
	var pars = tmp.split('/n')
	if pars[0].begins_with("extends"):
		pars[0] = 'extends "%s"' % ResourceScripts.scriptdict[name]
	else: file.store_line('extends "%s"' % ResourceScripts.scriptdict[name])
	for s in pars:
		file.store_line(s)
	file.close()
	ResourceScripts.scriptdict[name] = path
