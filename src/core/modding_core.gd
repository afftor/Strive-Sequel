extends Node

var version = '4.0'

var modconfig_path = "user://mods.ini"
var modfolder_path = "user://mods"

var debug = false

var mods_list = [] #name, data_file, config_file
var modules = {} #children of modding_core
var gui_nodes = [] #tmp ResourceScripts.node_data instances
var scripts = [] #initial scriptdict resources

var mod_tables = {} #table, mod
var tables = {} #table, parsed content 

var current_mod = ""


signal before_mods_loaded

signal data_loaded
signal translations_loaded
signal patches_loaded
signal modules_loaded
signal script_extensions_loaded
signal script_extensions_applied
signal core_extensions_loaded
signal node_extensions_loaded

signal after_mods_loaded
signal after_data_fixed

var test_mode_enabled = false


func _ready():
	pass

#EP globals._ready()
#process_translation_mods called from globals._ready()
#process_data_mods called from globals._ready()
func load_mods():
	print("Mod Loader: ", version)
	get_mods_list()
	emit_signal("before_mods_loaded")
	#load scriptdict replacements
	process_patches_mods()
	#load .gd modules (_init + _ready)
	process_modules_mods()
	#run load_translation on .gd modules
	modding_core.process_translation_mods()
	#load CEScripts, extend scripts in ResourceScripts.scriptdict
	process_script_extensions_mods()
	#wait for an idle frame to edit nodes
	yield(get_tree(), 'idle_frame')
	#core script mods won't work in test mode
	if test_mode_enabled:
		return
	#handle extensions of globals/input_handler
	process_core_extensions_mods()
	#run extend_nodes() on chosen modules
	process_node_extensions_mods()
	#run load_tables on .gd modules and load tables from .json files
	modding_core.process_data_mods()
	emit_signal("after_mods_loaded")
	modding_core.fix_main_data()
	globals.reset_roll_data()

func handle_test_mode():
	modding_core.fix_main_data()
	globals.reset_roll_data()
	test_mode_enabled = true

func process_modules_mods():
	for m in mods_list:
		var mconf = m.config
		if !mconf.has_section('Modules'): continue
		process_modules_init(m)
	process_modules_ready()
	emit_signal("modules_loaded")

func process_data_mods():
	for m in mods_list:
		var mconf = m.config
		if !mconf.has_section('Data'): continue
		process_data_mod(m)
	emit_signal("data_loaded")

func process_translation_mods():
	var activetranslation = Translation.new()
	var translationscript = load(input_handler.TranslationData[input_handler.globalsettings.ActiveLocalization]).new()
	
	#locale (en only rn)
	activetranslation.set_locale(input_handler.globalsettings.ActiveLocalization)
	
	#Reload main.gd
	for i in translationscript.TranslationDict:
		activetranslation.add_message(i, translationscript.TranslationDict[i])
	
	for m in mods_list:
		var mconf = m.config
		if !mconf.has_section('Translations'): continue
		process_translation_mod(m, activetranslation)
		
	TranslationServer.clear()
	TranslationServer.add_translation(activetranslation)
	
	emit_signal("translations_loaded")

func process_patches_mods():
	for m in mods_list:
		var mconf = m.config
		if !mconf.has_section('Patches'): continue
		process_patches(m)
	emit_signal("patches_loaded")


var extensions_queue = {}
func process_script_extensions_mods():
	for m in mods_list:
		var mconf = m.config
		if !mconf.has_section('CEScripts'): continue
		process_script_extensions(m)
	emit_signal("script_extensions_loaded")
	#rename last extension, to alleviate serialization issues
	var dir = Directory.new()
	for name in extensions_queue:
		var old_filepath = extensions_queue[name]
		var new_filepath = old_filepath.get_base_dir() + '/modded_' + name + '.gd'
		dir.rename(old_filepath, new_filepath)
		ResourceScripts.scriptdict[name] = load(new_filepath)
	#redo singletones
	for name in extensions_queue:
		if name in ResourceScripts.singletones + ResourceScripts.gamestate:
			var oldc = ResourceScripts.get(name)
			var newc = ResourceScripts.scriptdict[name].new()
			if oldc is Node:
				ResourceScripts.remove_child(oldc)
				oldc.free()
			ResourceScripts.set(name, newc)
			if newc is Node:
				ResourceScripts.add_child(newc)
			if name == "game_world":
				input_handler.disconnect("EnemyKilled", oldc, "quest_kill_receiver")
				input_handler.connect("EnemyKilled", newc, "quest_kill_receiver")	
	extensions_queue.clear()
	emit_signal("script_extensions_applied")
	
		
func process_core_extensions_mods():
	for m in mods_list:
		var mconf = m.config
		if !mconf.has_section('CoreScripts'): continue
		process_core_extensions(m)
	emit_signal("core_extensions_loaded")

func process_node_extensions_mods():
	for m in mods_list:
		var mconf = m.config
		if !mconf.has_section('NodeScripts'): continue
		process_node_extensions(m)
	emit_signal("node_extensions_loaded")

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
	var new_mods_list = []
	check_avail()
	for mod in mods_list:
		var mconf := ConfigFile.new()
		mconf.load(mod.path)
		#rereading data from config file in case some of it changed
		var temp = fill_mod_data(mconf, mod.path)
		new_mods_list.push_back(temp)
		print(mod.name)
	mods_list = new_mods_list

func save_mod_list():
	check_avail()
	var tlist = mods_list.duplicate()
	for f in tlist:
		f.erase('config')
	var f:= File.new()
	f.open(modconfig_path, File.WRITE)
	f.store_line(to_json(tlist))
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
	
	var all_files = input_handler.dir_contents(modfolder_path)
	var mod_config_files = []
	
	#loading module config and _init
	for configpath in all_files:
		if configpath.ends_with('mod_config.ini'):
			mod_config_files.append(configpath)
		
	for configpath in mod_config_files:
		var mconf := ConfigFile.new()
		mconf.load(configpath)
		
		#mod template
		var temp = fill_mod_data(mconf, configpath)

		res.push_back(temp)
	return res

func fill_mod_data(mconf, configpath):
	var temp = {
		config = mconf,
		name = mconf.get_value('General','Name'), 
		path = configpath, 
		dir = configpath.get_base_dir(),
		desc = 'No description', 
		extendedMethods = {}, 
		replacedMethods = {}, 
		required = [], 
		optional = []
	}
	#load description
	if mconf.has_section_key('General','Description'): 
		temp.desc = mconf.get_value('General','Description')
	
	#load Conflicts
	if mconf.has_section('ReplacedMethods'): 
		for key in mconf.get_section_keys('ReplacedMethods'):
			temp.replacedMethods[key] = mconf.get_value('ReplacedMethods',key)
	if mconf.has_section('ExtendedMethods'): 
		for key in mconf.get_section_keys('ExtendedMethods'):
			temp.extendedMethods[key] = mconf.get_value('ExtendedMethods',key)
			
	#load dependencies
	if mconf.has_section_key('Dependencies', 'Required'):
		temp.required = mconf.get_value('Dependencies', 'Required')
	if mconf.has_section_key('Dependencies', 'Optional'):
		temp.optional = mconf.get_value('Dependencies', 'Optional')
	return temp
	

func process_data_mod(data):
	var mconf = data.config
	
	var datatype = "json"
	if mconf.has_section_key('General','DataType'): datatype = mconf.get_value('General','DataType')
	
	if debug: print("process_data_mod from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('Data')
	var dir = data.dir
	for table in datafiles:
		var tpath = mconf.get_value('Data', table)
		if not tpath.begins_with('user://'): tpath = data.dir + '/' + tpath
		match datatype:
			"json":
				process_json_data_file(tpath, table)
			"gd":
				process_gd_data_file(tpath, table)

func process_modules_init(data):
	var mconf = data.config
	var modulenames = mconf.get_section_keys('Modules')
	for mname in modulenames:
		var tpath = mconf.get_value('Modules', mname)
		if not tpath.begins_with('user://'): tpath = data.dir + '/' + tpath
		modules[mname] = load(tpath).new()

func process_modules_ready():
	for module in modules.values():
		add_child(module)

func process_translation_mod(data, activetranslation):
	var mconf = data.config
	if debug: print("process_translation_mod from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('Translations')
	var dir = data.dir
	for alias in datafiles:
		var tpath = mconf.get_value('Translations', alias)
		if not tpath.begins_with('user://'): tpath = data.dir + '/' + tpath
		process_translation_data_file(tpath, activetranslation)

func process_patches(data):
	var mconf = data.config
	if debug: print("process_patches from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('Patches')
	for script in datafiles:
		var tpath =  mconf.get_value('Patches', script)
		if not tpath.begins_with('user://'): tpath = data.dir + '/' + tpath
		if tpath.ends_with('.gd'):
			ResourceScripts.scriptdict[script] = load(tpath).new()
		if tpath.ends_with('.tscn'):
			ResourceScripts.scenedict[script] = load(tpath).new()

func process_script_extensions(data):
	var mconf = data.config
	if debug: print("process_script_extensions from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('CEScripts')
	for script in datafiles:
		var tpath =  mconf.get_value('CEScripts', script)
		if not tpath.begins_with('user://'): tpath = data.dir + '/' + tpath
		process_script_extend(script, tpath)

		
func process_core_extensions(data):
	var mconf = data.config
	if debug: print("process_core_extensions from mod %s" % mconf.get_value('General','Name'))
	var datafiles = mconf.get_section_keys('CoreScripts')
	for corefile in datafiles:
		var tpath =  mconf.get_value('CoreScripts', corefile)
		if not tpath.begins_with('user://'): tpath = data.dir + '/' + tpath
		process_core_extend(tpath, corefile)
		
func process_node_extensions(data):
	var mconf = data.config
	if debug: print("process_node_extensions from mod %s" % mconf.get_value('General','Name'))
	var modulenames = mconf.get_section_keys('NodeScripts')
	for m in modulenames:
		modules[m].extend_nodes()

func make_desc(mod):
	var ret = "Description: %s\n" % mod.desc
	var str_conflicts = ""
	
	if !mod.replacedMethods.empty() || !mod.extendedMethods.empty():
		ret += "\nConflicts:\n%s"
		if !mod.replacedMethods.empty():
			str_conflicts += " Replacements:\n"
			for rm in mod.replacedMethods:
				str_conflicts += "  " + rm + ":" +  str(mod.replacedMethods[rm])
			str_conflicts += "\n"
		if !mod.extendedMethods.empty():
			str_conflicts += " Extensions:\n"
			for em in mod.extendedMethods:
				str_conflicts += "  " + em + ":" + str(mod.extendedMethods[em])
			str_conflicts += "\n"
		ret = ret % str_conflicts
	
	if !mod.required.empty() || !mod.optional.empty():
		ret += "\nDependecies:\n"
		if !mod.required.empty():
			ret += "Required:%s" % str(mod.required)
		if !mod.optional.empty():
			ret += "\n Optional%s" % str(mod.optional)
	return ret

func process_json_data_file(filepath : String, tablename : String):
	if mod_tables.has(tablename): 
		print("ERROR: table %s has been already loaded" % tablename)
		return #the same table in different mods do not load
	var f := File.new()
	if !f.file_exists(filepath):
		print('ERROR: in %s table path' % tablename)
		return
	if debug: print("processing table %s" % tablename)
	f.open(filepath, File.READ)
	var tmp = f.get_as_text()
	f.close()
	var tmp1 = parse_json(tmp)
	if tmp1 == null or typeof(tmp1) != TYPE_DICTIONARY:
		print('ERROR: in %s table content' % tablename)
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
	process_dir(tablename, 'loot_chests', Enemydata.loot_variants_data)
	process_dir(tablename, 'loot_enemy', Enemydata.loottables)
	process_dir(tablename, 'enemy_groups', Enemydata.predeterminatedgroups)
	#tasks are not moddable through data because they are linked to functors
	process_dir(tablename, 'races', races.racelist) #
	process_dir(tablename, 'scenedata', scenedata.scenedict)
	process_dir(tablename, 'dialogues', scenedata.dialogue_inits)
	process_dir(tablename, 'scene_quests',scenedata.quests)
	process_dir(tablename, 'classes', classesdata.professions) #
	process_dir(tablename, 'tasklist', races.tasklist)
	process_dir(tablename, 'upgrades', upgradedata.upgradelist)
#	process_dir(tablename, 'classes', classesdata.professions) #
	
	process_images_dir(tablename, 'i_backgrounds', images.backgrounds)
#	process_images_dir(tablename, 'i_circleportaits', images.circleportraits)
#	process_images_dir(tablename, 'i_combatfullpictures', images.combatfullpictures)
#	process_images_dir(tablename, 'i_combatportraits', images.combatportraits)
#	process_images_dir(tablename, 'i_gui', images.gui)
	process_dir(tablename, 'i_icons', images.icons) #
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
	process_dir(tablename, 'w_factions', worlddata.factiondata) #
	process_dir(tablename, 'w_guilds', worlddata.guild_upgrades)
	process_dir(tablename, 'w_lands', worlddata.lands) #
	process_dir(tablename, 'w_locations', worlddata.locations) #
#	process_dir(tablename, 'w_locationnames', worlddata.locationnames)
	process_dir(tablename, 'w_quests', worlddata.questdata) #
	process_dir(tablename, 'w_dungeons', worlddata.dungeons) #
	process_dir(tablename, 'w_characters', worlddata.pregen_characters) #
	
	process_dir(tablename, 'statlist', Statlist_init.template)
	
	#incomplete

func process_translation_data_file(filepath, activetranslation):
	var script = load(filepath)
	for module in modules.values():
		#if module uses this loadpath just call the module
		if module.get_script().get_path() == script.resource_path:
			module.load_translations(activetranslation)
			return
	script.new().load_translations(activetranslation)

func process_gd_data_file(filepath: String, alias : String):
	var script = load(filepath)
	for module in modules.values():
		#if module uses this loadpath just call the module
		if module.get_script().get_path() == script.resource_path:
			module.load_tables()
			return
	script.new().load_tables()

func fix_main_data():
	#load images
	images.loadimages()
	
	#fix racegroups
	races.fill_racegroups()

	#fix skills
	for i in Skilldata.Skilllist.values():
		if !i.has('name'):
			i.name = tr("SKILL" + i.code.to_upper())
		i.descript = tr("SKILL" + i.code.to_upper()+"DESCRIPT")
		if i.has('dialogue_text'):
			i.dialogue_text = tr("DIALOGUE" +i.code.to_upper() + "TEXT")
		if i.has('dialogue_report'):
			i.dialogue_report = tr("DIALOGUE" + i.code.to_upper() + "REPORT")
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
		#type fix
		if i.has('charges') and typeof(i.charges) == TYPE_REAL: i.charges = int(i.charges)
		
	#fix skills format
	for s in Skilldata.Skilllist:
		var tmp = Skilldata.Skilllist[s]
		if tmp.has('new_syntax') and tmp.new_syntax == true: continue
		var ss = ResourceScripts.scriptdict.class_sskill_legacy.new()
		ss.createfromskill(s)
		Skilldata.Skilllist[s] = ss.convert_to_new_template()

	#load proffessions
	for i in classesdata.professions.values():
		i.name = tr("PROF" + i.code.to_upper())
		i.descript = tr("PROF" + i.code.to_upper()+"DESCRIPT")
		if i.has('altname'):
			i.altname = tr("PROF"+i.code.to_upper()+"ALT")
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
		#statchange fix
		if i.has('statchanges'):
			for j in i.statchanges:
				if typeof(i.statchanges[j]) == TYPE_STRING:
					if i.statchanges[j].is_valid_integer():
						i.statchanges[j] = int(i.statchanges[j])
					elif i.statchanges[j].is_valid_float():
						i.statchanges[j] = float(i.statchanges[j])

	#fix statdata
	for val in statdata.statdata.values():
		if !val.has('percent'): val.percent = false
		if !val.has('default_bonus'): val.default_bonus = 'add'
		if !val.has('direct'): val.direct = false
		if !val.has('custom_get'): val.custom_get = false
		if !val.has('skip_process'): val.skip_process = false
		if !val.has('is_negative'): val.is_negative = false
		if !val.has('hidden'): val.hidden = false

	
	#fix worlddata, dungeons
	for i in worlddata.dungeons.values():
		i.classname = tr("LOCATIONNAME" + i.code.to_upper())
		#purchase fix
		if !i.has('purchase_area'):
			i.purchase_area = 'plains'
	#guild fix
	worlddata.update_guilds_data()

	#fix game_res
	for i in upgradedata.upgradelist.keys():
		ResourceScripts.game_res.upgrades[i] = 0
	for i in Items.materiallist:
		ResourceScripts.game_res.materials[i] = 0

	#fix items
	for i in Items.itemlist.values():
		i.name = tr("ITEM" + i.code.to_upper())
		i.descript = tr("ITEM" + i.code.to_upper()+"DESCRIPT")
		
	#Stuff to make sure items and parts added by mods get loaded poperly (due to Items _init)
	for i in Items.partmaterials:
		for k in Items.partmaterials[i]:
			Items.materiallist[k].parts[i] = Items.partmaterials[i][k].duplicate()

	#fix races
	for i in races.racelist.values():
		i.name = tr("RACE" + i.code.to_upper())
		i.descript = tr("RACE" + i.code.to_upper() + 'DESCRIPT')
		i.adjective = tr("RACE" + i.code.to_upper() + "ADJ")
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
	
	
	#fix tasks
	for i in races.tasklist.values():
		i.name = tr("TASK" + i.code.to_upper())
		i.descript = tr("TASK" + i.code.to_upper() + "DESCRIPT")

	#fix sex_traits
	for i in Traitdata.sex_traits.values():
		i.name = tr("SEXTRAIT" + i.code.to_upper())
		i.descript = tr("SEXTRAIT" + i.code.to_upper() + "DESCRIPT")

	#fix traits
	for i in Traitdata.traits.values():
		i.name = tr("TRAIT" + i.code.to_upper())
		i.descript = tr("TRAIT" + i.code.to_upper() + "DESCRIPT")
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'icons')
	
	#fix statdata
	for i in statdata.statdata.values():
		if !i.has('baseicon'): continue
		if typeof(i.baseicon) == TYPE_STRING:
			i.baseicon = input_handler.loadimage(i.baseicon, 'icons')
		if !i.has('name') or i.name == '': i.name = tr("STAT" + i.code.to_upper())
		else: i.name = tr(i.name)
		if !i.has('descript') or i.descript == '': i.descript = tr("STAT" + i.code.to_upper() + "DESCRIPT")
		else: i.descript = tr(i.descript)
	
	#fix enemies
	for i in Enemydata.enemies.values():
		i.name = tr("ENEMY" + i.code.to_upper())
		if typeof(i.icon) == TYPE_STRING:
			i.icon = input_handler.loadimage(i.icon, 'portraits')
	
	#fix descriptions bodypartsdata
	for i in ResourceScripts.descriptions.bodypartsdata:
		for k in ResourceScripts.descriptions.bodypartsdata[i].values():
			k.name = tr("BODYPART" + i.to_upper() + k.code.to_upper())
			k.chardescript = tr("BODYPART" + i.to_upper() + k.code.to_upper() + "DESCRIPT")
		
	#fix locations
	for i in worlddata.locations.values():
		i.classname = tr(i.code.to_upper())
	
	#fix materials
	for i in Items.materiallist.values():
		i.name = tr("MATERIAL" + i.code.to_upper())
		i.descript = tr("MATERIAL" + i.code.to_upper()+"DESCRIPT")
		i.adjective = tr("MATERIAL" + i.code.to_upper() + "ADJ")
		#fix item tiers, to make sure mod items work properly
		if i.has('tier') && i.tier != '':
			if !(i.code in Items.materials_by_tiers[i.tier]):
				Items.materials_by_tiers[i.tier].append(i.code)

	#fix statdata
	for i in statdata.statdata.values():
		if !i.has('name') or i.name == '': i.name = tr("STAT" + i.code.to_upper())
		else: i.name = tr(i.name)
		if !i.has('descript') or i.descript == '': i.descript = tr("STAT" + i.code.to_upper() + "DESCRIPT")
		else: i.descript = tr(i.descript)

	#fix upgrades
	for i in upgradedata.upgradelist.values():
		i.name = tr("UPGRADE" + i.code.to_upper())
		i.descript = tr("UPGRADE" + i.code.to_upper() + "DESCRIPT")

	#fix tools
	for i in statdata.worktoolnames:
		statdata.worktoolnames[i] = tr("WORKTOOL" + i.to_upper())
	emit_signal("after_data_fixed")


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
		elif typeof(patch) == TYPE_DICTIONARY and location_dir.has(key):
			for k in patch: location_dir[key][k] = patch[k]
		else:
			location_dir[key] = patch

func process_images_dir(table_name, dir_name, location_dir):
	var table = tables[table_name]
	if !table.has(dir_name): return
	var dir = table[dir_name]
	for key in dir.keys(): location_dir[key] = input_handler.load_image_from_path(dir[key])

#func save_mod(mod_name):
#	var path = mod_tables[mod_name]
#	var mconf := ConfigFile.new()
#	mconf.load(path)
#	var datafiles = mconf.get_section_keys('Data')
#	var dir = path.get_base_dir()
#	for table in datafiles:
#		var f := File.new()
#		f.open(dir + "/" + datafiles.get_value('Data', table), File.WRITE)
#		f.store_line(to_json(tables[table]))
#		f.close()

func save_table(t_name):
	var m_name = mod_tables[t_name]
	var cfg
	var path
	for i in mods_list:
		if i.name == m_name: 
			cfg = i.config
			path = i.path.get_base_dir()
	path += '/'
	path += cfg.get_value('Data', t_name)
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(tables[t_name]))
	file.close()

func process_script_extend(name, path):
	var file = File.new()
	if !file.file_exists(path):
		print('ERROR: no file at path %s' % path)
		return
	if !path.begins_with('user:'):
		print('WARNING: possibility of access denial to %s' % path)
		
	#runtime injections hack
	if !extensions_queue.has(name):
		var tmp_res = tmp_save_script(ResourceScripts.scriptdict[name])
		ResourceScripts.scriptdict[name] = load(tmp_res)
	
	path = tmp_save_file(path)
	
	file.open(path, File.READ)
	var tmp = file.get_as_text()
	var pars = tmp.split('\n')
	file.close()
	file.open(path, File.WRITE)
	
	#set extension target
	var extension = ''
	if extensions_queue.has(name): 
		extension = ResourceScripts.scriptdict[name].resource_path
	else: 
		extension = ResourceScripts.scriptdict[name]
		scripts.append(extension)
	
	if pars[0].begins_with("extends"):
		pars[0] = 'extends "%s"' % ResourceScripts.scriptdict[name].resource_path
	else: pars.append('extends "%s"' % ResourceScripts.scriptdict[name])
	file.store_string(pars.join('\n'))
	file.close()
	ResourceScripts.scriptdict[name] = load(path)
	
	extensions_queue[name] = path
	

func process_core_extend(path, core):
	match core:
		"globals":
			extend_node(globals, path)
		"input_handler":
			extend_node(input_handler, path)

func create_empty_mod():
	#create mod location
	var dir := Directory.new()
	dir.open(modfolder_path)
	var n = globals.rng.randi_range(0, 100000)
	while dir.dir_exists( "emptymod_%d" % n) :
		n = globals.rng.randi_range(0, 100000)
	var modname = "emptymod_%d" % n
	dir.make_dir(modname)
	dir.change_dir(modname)
	#create empty table
	var t = globals.rng.randi_range(0, 100000)
	while tables.has("table_%d" % t): 
		t = globals.rng.randi_range(0, 100000)
	var temp = {}
	var tablename = "table_%d" % t
	tables[tablename] = temp
	mod_tables[tablename] = modname
	var tfile = File.new()
	tfile.open("%s/%s.json" % [dir.get_current_dir(), tablename], File.WRITE)
	tfile.store_line('{}')
	tfile.close()
	#create mod config
	var tempcfg = ConfigFile.new()
	tempcfg.set_value('General', 'Name', modname)
	tempcfg.set_value('Data', tablename, '%s.json' % tablename)
	tempcfg.save('%s/mod_config.ini' % dir.get_current_dir())
	#store mod in mod_table
	var record = {}
	record.name = modname
	record.path = '%s/mod_config.ini' % dir.get_current_dir()
	record.config = tempcfg
	mods_list.push_back(record)
#	save_mod_list()

func get_spec_node(type):
	#return node from gui_nodes if possible
	var nodename = ResourceScripts.node_data[type].name
	for n in gui_nodes:
		if n.name == nodename:
			return n
	#otherwise make an instance and return that
	var node = ResourceScripts.node_data[type].scene.instance()
	node.name = nodename
	gui_nodes.append(node)
	return node

func replace_node(dst, src):
	var par = dst.get_parent()
	if par == null:
		print("ERROR: CANNOT REPLACE AN ORPHAN NODE")
		return
	var pos = dst.get_index()
	src.name = dst.name
	par.remove_child(dst)
	par.add_child(src)
	par.move_child(src,pos)
	dst.queue_free()

func extend_node(node, script, no_ext = false):
	var source
	var fstream = File.new()
	#load new script to source
	fstream.open(script,File.READ) 
	source = fstream.get_as_text().split('\n')
	fstream.close()
	#add extends to new script
	var old_script = node.get_script()
	source[0] = 'extends "%s"' % old_script.resource_path #should be dynn... dunno why it fails tho i'll change that later
	#don't save if flag is set
	if !no_ext:
		fstream.open(script,File.WRITE)
		fstream.store_string(source.join('\n'))
		fstream.close()
	#set new script on node, _init will run on each inheritance level
	var newscript = GDScript.new()
	newscript.source_code = source.join('\n')
	newscript.reload()
	if !no_ext:
		newscript.resource_path = script
	node.set_script(newscript)
	
func load_translation(src, activetranslation):	
	for i in src:
		activetranslation.erase_message(i)
		activetranslation.add_message(i, src[i])

func load_table(dst,src):
	for e in src:
		if dst.has(e) && typeof(dst[e]) == TYPE_DICTIONARY && typeof(src[e]) == TYPE_DICTIONARY:
			load_table(dst[e],src[e])
		else:
			dst[e] = src[e]

func runtime_injection(script,data,reload = true):
	#dprint("!rti: " + script.resource_path.get_file())
	#setup
	#works but far from perfect
	var src = script.source_code.split('\n')
	src.remove(src.size()-1)
	var opcs = data.operations.split(' ')
	var inj = data.injection.split('\n')
	inj.invert()
	var point = -1
	var indent = data.indent
	
	for n in src.size():
		var line = src[n]
		if line.find(data.site) >= 0:
			point = n
			break

	#search for site failed
	if point == -1:
		print("ERROR: INJECTION SITE NOT FOUND")
		return
	
	#move the point(CURSOR)/ process opcodes
	for opc in opcs:
		opc = opc.split('=')
		if opc.size() == 1:
			opc = [opc[0], 1]
		else:
			opc = [opc[0],int(opc[1])]
		match opc[0]:
			'j':
				point += opc[1]
			'k':
				point -= opc[1]
			'd':
				for n in range(opc[1]):
					src.remove(point)
			'p':
				for n in range(opc[1]):
					src.insert(point,"\t".repeat(indent) + inj[ inj.size() - opc[1] + n])
				for n in range(opc[1]):
					inj.pop_back()
	
	#join script and reload
	for line in inj:
		src.insert(point,"\t".repeat(indent) + line)
		
	script.source_code = src.join('\n')
	if reload:
		script.reload()

func tmp_save_file(filepath):
	#check dir
	var tmp_path = 'res://tmp'
	var dir = Directory.new()
	if dir.open(tmp_path) != OK:
		dir.make_dir(tmp_path)
	#get text from old file
	var f = File.new()
	f.open(filepath, File.READ)
	var old_text = f.get_as_text()
	f.close()
	#get new filepath
	var filebase = filepath.get_base_dir()
	var tmp_file_path = filepath.replace(filebase, tmp_path)
	#save new file
	f.open(tmp_file_path, File.WRITE)
	f.store_string(old_text)
	f.close()
	return tmp_file_path

func tmp_save_script(script):
	var filepath = script.resource_path
	#check dir
	var tmp_path = 'res://tmp'
	var dir = Directory.new()
	if dir.open(tmp_path) != OK:
		dir.make_dir(tmp_path)
	#get source from script
	var old_text = script.source_code
	#get new filepath
	var filebase = filepath.get_base_dir()
	var tmp_file_path = filepath.replace(filebase, tmp_path)
	#save new file
	var f = File.new()
	f.open(tmp_file_path, File.WRITE)
	f.store_string(old_text)
	f.close()
	return tmp_file_path
	
