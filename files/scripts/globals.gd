extends Node

const gameversion = 'pre-demo-test 0.1'

#const worker = preload("res://files/scripts/worker.gd");
#const Item = preload("res://src/ItemClass.gd")
#const combatant = preload ('res://src/combatant.gd')

var start_new_game = false

var SpriteDict = {}
var TranslationData = {}
var CurrentScene #holds reference to instanced scene

var EventList #= events.checks

var scenedict = {
	menu = "res://files/Menu.tscn",
	mansion = "res://src/Mansion.tscn"
	
}
var rng := RandomNumberGenerator.new()

#var items
#var TownData
var workersdict
#var enemydata
var randomgroups

var enemylist
var upgradelist
#var skillsdata
#var effectdata

#var combatantdata = load("res://files/CombatantClass.gd").new()

#var classes = combatantdata.classlist
#var characters = combatantdata.charlist
var skills
var effects
var combateffects
var explorationares 

var combat_node = null

var system_messages = {
	no_resources = "MESSAGE_NORESOURCE",
	no_crafting_item = "MESSAGE_NOCRAFTINGITEM",
	
}

var longtails = ['fox','cat','wolf','dragon','demon','tanuki','fish','lizard']

var impregnation_compatibility = ['Human','Elf','DarkElf','Beastkin','Halfkin'] #the rest is only for same race
var inheritedassets = ['ears','eye_color','eye_shape', 'hair_color', 'horns', 'tail', 'wings', 'skin_coverage', 'arms', 'legs', 'body_shape']
var inheritedstats = ['growth_factor','magic_factor','physics_factor','wits_factor','charm_factor','sexuals_factor']

var sexicons = {
	male = load("res://assets/images/sexicons/male.png"),
	female = load("res://assets/images/sexicons/female.png"),
	futa = load("res://assets/images/sexicons/futa.png"),
}


var descriptions = load("res://assets/data/descriptions.gd").new()
var custom_effects = load("res://src/custom_effects.gd").new()

var statdata = {
	base_exp = {
		code = 'base_exp',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/growth_factor.png"),
		type = 'misc',
	},
	growth_factor = {
		code = 'growth_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/growth_factor.png"),
		type = 'factor',
	},
	physics_factor = {
		code = 'physics_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/physics_factor.png"),
		type = 'factor',
	},
	wits_factor = {
		code = 'wits_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/wit.png"),
		type = 'factor',
	},
	charm_factor = {
		code = 'charm_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/charm.png"),
		type = 'factor',
	},
	sexuals_factor = {
		code = 'sexuals_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/sex.png"),
		type = 'factor',
	},
	
	magic_factor = {
		code = 'magic_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/magic_factor.png"),
		type = 'factor',
	},
	
	tame_factor = {
		code = 'tame_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/tame_factor.png"),
		type = 'factor',
	},
	brave_factor = {
		code = 'brave_factor',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/brave_factor.png"),
		type = 'factor',
	},
	
	physics = { 
		code = 'physics',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/brave_factor.png"),
		type = 'primal',
	},
	wits = { 
		code = 'wits',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/brave_factor.png"),
		type = 'primal',
	},
	charm = { 
		code = 'charm',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/brave_factor.png"),
		type = 'primal',
	},
	sexuals = { 
		code = 'sexuals',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/brave_factor.png"),
		type = 'primal',
	},
	
	
	
	obedience = {
		code = 'obedience',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/obed_good.png"),
		type = 'mental_stat',
	},
	fear = {
		code = 'fear',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/fear_good.png"),
		type = 'mental_stat',
	},
	lust = {
		code = 'lust',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/charm_factor.png"),
		type = 'mental_stat',
	},
	loyal = {
		code = 'loyal',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/charm_factor.png"),
		type = 'mental_stat',
	},
	food_consumption = {
		code = 'food_consumption',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food.png"),
		type = 'misc',
	},
	
	food_hate = {
		code = 'food_hate',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_hate.png"),
		type = 'misc',
	},
	food_love = {
		code = 'food_love',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	
	hp = {
		code = 'hp',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	hpmax = {
		code = 'hpmax',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	hpmaxmod = {
		code = 'hpmaxmod',
		name = '',
		descript = '',
		percent = true,
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	hpfactor = {
		code = 'hpfactor',
		name = '',
		descript = '',
		percent = true,
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	mp = {
		code = 'mp',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	mpmax = {
		code = 'mpmax',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	mpmaxmod = {
		code = 'mpmaxmod',
		name = '',
		descript = '',
		percent = true,
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	hitrate = {
		code = 'hitrate',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	evasion = {
		code = 'evasion',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	speed = {
		code = 'speed',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	energy = {
		code = 'energy',
		name = '',
		descript = '',
		baseicon = load("res://assets/images/gui/gui icons/food_love.png"),
		type = 'misc',
	},
	fatigue = {
		code = 'fatigue',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	exhaustion = {
		code = 'exhaustion',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	atk = {
		code = 'atk',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	matk = {
		code = 'matk',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	armor = {
		code = 'armor',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mdef = {
		code = 'mdef',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	armorpenetration = {
		code = 'armorpenetration',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	critchance = {
		code = 'critchance',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	critmod = {
		code = 'critmod',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	
	physics_bonus = {
		code = 'physics_bonus',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	wits_bonus = {
		code = 'wits_bonus',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	charm_bonus = {
		code = 'charm_bonus',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	sexuals_bonus = {
		code = 'sexuals_bonus',
		name = '',
		descript = '',
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	productivity = {
		code = 'productivity',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_collect = {
		code = 'mod_collect',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_build = {
		code = 'mod_build',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_hunt = {
		code = 'mod_hunt',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_fish = {
		code = 'mod_fish',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_cook = {
		code = 'mod_cook',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_smith = {
		code = 'mod_smith',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_tailor = {
		code = 'mod_tailor',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_alchemy = {
		code = 'mod_alchemy',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_farm = {
		code = 'mod_farm',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	mod_pros = {
		code = 'mod_pros',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	task_energy_tool = {
		code = 'task_energy_tool',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
	task_efficiency_tool = {
		code = 'task_efficiency_tool',
		name = '',
		descript = '',
		percent = true,
		basicon = load("res://assets/images/gui/gui icons/food_love.png"),
	},
}

var worktoolnames = {
	bow = '',
	axe = '',
	pickaxe = '',
	rod = '',
	sickle = '',
	hammer = '',
}

var gearlist = ['chest', 'gloves', 'boots', 'rhand', 'lhand', 'neck', 'ring1', 'ring2']

var file = File.new()
var dir = Directory.new()

var LocalizationFolder = "res://localization/"
#var state

var userfolder = 'user://'

#var images = load("res://files/scripts/ResourceImages.gd").new()
#var audio = load("res://files/scripts/ResourceAudio.gd").new()
var scenes = {}

var hexcolordict = {
	red = '#ff5e5e',
	yellow = "#ffff00",
	brown = "#8B572A",
	gray = "#4B4B4B",
	green = '#00b700',
	white = '#ffffff',
	factor1 = '#ff5e5e',
	factor2 = '#f6922a',
	factor3 = '#4dff83',
	factor4 = '#13a40d',
	factor5 = '#25b8ff',
	factor6 = '#bc53ff',
}
var textcodedict = {
	color = {start = '[color=', end = '[/color]'},
	url = {start = '[url=',end = '[/url]'}
}

var quest_icons = {
	eventlocation = load("res://assets/images/gui/panels/noimage.png"),
	dungeon = load("res://assets/images/gui/panels/noimage.png"),
	reputation = load("res://assets/images/gui/panels/noimage.png"),
	
}

var globalsettings = { 
	ActiveLocalization = 'en',
	mastervol = -15,
	mastermute = false,
	musicvol = -20,
	musicmute = false,
	soundvol = -15,
	soundmute = false,
	
	#Window settings
	fullscreen = true,
	window_size = Vector2(1366,768),
	window_pos = Vector2(0,0),
	
	factors_as_words = true,
	
	textspeed = 60,
	skipread = false,
	textmonocolor = false,
	warnseen = false,
	disabletips = false,
	
	futa = true,
	furry = true,
	furry_multiple_nipples = true,
	futa_balls = true,
	futachance = 10,
	malechance = 50,
	#user_folders_settings
	portrait_folder = 'user://portraits/',
	body_folder = 'user://bodies/',
	mod_folder = 'user://mods/',
	
	
	guilds_any_race = true,
	
	
} setget settings_save

func settings_load():
	var config = ConfigFile.new()
	if file.file_exists(userfolder + "Settings.ini") == false:
		settings_save(globalsettings)
	config.load(userfolder + "Settings.ini")
	var settings = config.get_section_keys("settings") 
	for i in settings:
		globalsettings[i] = config.get_value("settings", i, null)
	
	#updatevolume
	var counter = 0
	for i in ['master','music','sound']:
		AudioServer.set_bus_mute(counter, globalsettings[i+'mute'])
		AudioServer.set_bus_volume_db(counter, globalsettings[i+'vol'])
		counter += 1
	

func settings_save(value):
	globalsettings = value
	var config = ConfigFile.new()
	config.load(userfolder + "Settings.ini")
	for i in globalsettings:
		config.set_value('settings', i, globalsettings[i])
	config.save(userfolder + "Settings.ini")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		globalsettings.window_size = OS.window_size
		globalsettings.window_pos = OS.window_position
		settings_save(globalsettings)
		get_tree().quit()

func _init():
	if dir.dir_exists(userfolder + 'saves') == false:
		dir.make_dir(userfolder + 'saves')
	
	
	#Storing available translations
	for i in scanfolder(LocalizationFolder):
		for ifile in dir_contents(i):
			TranslationData[i.replace(LocalizationFolder, '')] = ifile
#			file.open(ifile, File.READ)
#			var data = file.get_as_text()
#	for i in dir_contents(LocalizationFolder):
#		TranslationData[i.replace(LocalizationFolder + '/', '').replace('.gd','')] = i
	
	
	#Applying active translation
	var activetranslation = Translation.new()
	var translationscript = load(TranslationData[globalsettings.ActiveLocalization]).new()
	activetranslation.set_locale(globalsettings.ActiveLocalization)
	for i in translationscript.TranslationDict:
		activetranslation.add_message(i, translationscript.TranslationDict[i])
	TranslationServer.add_translation(activetranslation)

func _ready():
	OS.window_size = globalsettings.window_size
	OS.window_position = globalsettings.window_pos
	randomize() #for legacy code sake
	rng.randomize()
	#Settings and folders
	settings_load()
	explorationares = load("res://assets/data/explorationareasdata.gd").new().areas

	upgradelist = load("res://assets/data/upgradedata.gd").new().upgradelist
	
	for i in Skilldata.professions.values():
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
	
	for i in variables.resists_list:
		statdata['resist'+i] = {code = "resist"+i}
	
	for i in globals.statdata.values():
		i.name = tr("STAT" + i.code.to_upper())
		i.descript = tr("STAT" + i.code.to_upper() + "DESCRIPT")
	
	for i in races.racelist.values():
		i.name = tr("RACE" + i.code.to_upper())
		i.descript = tr("RACE" + i.code.to_upper() + 'DESCRIPT')
		i.adjective = tr("RACE" + i.code.to_upper() + "ADJ")
	
	for i in races.tasklist.values():
		i.name = tr("TASK" + i.code.to_upper())
		i.descript = tr("TASK" + i.code.to_upper() + "DESCRIPT")
	
	for i in upgradelist.values():
		i.name = tr("UPGRADE" + i.code.to_upper())
		i.descript = tr("UPGRADE" + i.code.to_upper() + "DESCRIPT")
	
	for i in Traitdata.sex_traits.values():
		i.name = tr("SEXTRAIT" + i.code.to_upper())
		i.descript = tr("SEXTRAIT" + i.code.to_upper() + "DESCRIPT")
	
	for i in Traitdata.traits.values():
		i.name = tr("TRAIT" + i.code.to_upper())
		i.descript = tr("TRAIT" + i.code.to_upper() + "DESCRIPT")
		
	
	for i in worktoolnames:
		worktoolnames[i] = tr("WORKTOOL" + i.to_upper())
	

	for i in world_gen.dungeons.values():
		i.classname = tr("LOCATIONNAME" + i.code.to_upper())
	
	for i in world_gen.locations.values():
		i.classname = tr(i.code.to_upper())
	
	for i in Enemydata.enemies.values():
		i.name = tr("ENEMY" + i.code.to_upper())
	
	
	for i in descriptions.bodypartsdata:
		for k in descriptions.bodypartsdata[i].values():
			k.name = tr("BODYPART" + i.to_upper() + k.code.to_upper())
#			text += k.name + ' = "' + k.code + '",\n'
			k.chardescript = tr("BODYPART" + i.to_upper() + k.code.to_upper() + "DESCRIPT")
	

	#LoadEventData()
#	if globalsettings.fullscreen == true:
#		OS.window_fullscreen = true
	#===Necessary to apply translation===

	#Items = load("res://files/Items.gd").new()
	#Enemydata = load("res://assets/data/enemydata.gd").new()
	#Skillsdata = load("res://assets/data/Skills.gd").new()
	#Effectdata = load("res://assets/data/Effects.gd").new()
	#TownData = load("res://files/TownData.gd").new()
	#Traitdata = load("res://assets/data/Traits.gd").new()
	#combatantdata = load("res://files/CombatantClass.gd").new()

	#====================================
	
	for i in Items.materiallist.keys():
		state.materials[i] = 0
	
	for i in upgradelist.keys():
		state.upgrades[i] = 0
	
	#randomgroups = Enemydata.randomgroups
	#enemylist = Enemydata.enemylist
	#effects = Effectdata.effects
	#combateffects = Effectdata.combateffects
	#skills = Skillsdata.skilllist
	
	#workersdict = TownData.workersdict
	
#	for i in Items.materiallist:
#		state.materials[i] = 100
	state.money = 500

func logupdate(text):
	state.logupdate(text)




#warning-ignore:unused_signal
signal scene_changed

func ChangeScene(name):
	input_handler.CloseableWindowsArray.clear()
	var loadscreen = load("res://files/LoadScreen.tscn").instance()
	get_tree().get_root().add_child(loadscreen)
	loadscreen.goto_scene(scenedict[name])


func EventCheck():
	if state.CurEvent != "": return;
	for s in get_tree().get_nodes_in_group('char_sprite'):
		s.set_active_val();
	for event in EventList.keys():
		if SimpleEventCheck(event, false):
			StartEventScene(event);
			break;

func SimpleEventCheck(event, skip = true):
	#var tmp_d = {global = 'skip'};
	if state.OldEvents.has(event):
		return false
	for check in EventList[event]:
		if check.size() == 0:
			if skip:
				continue
			else:
				return false
		if !state.valuecheck(check): 
			return false
	return true

func LoadEvent(name):
	var dict
	
	if file.file_exists("res://assets/data/events/"+ name + '.json'):
		file.open("res://assets/data/events/"+ name + '.json', File.READ)
		dict = parse_json(file.get_as_text())
		file.close()
	else:
		print('Event not found: ' + name)
	return dict

func StartEventScene(name, debug = false, line = 0):
	state.CurEvent = name;
	scenes[name] = LoadEvent(name)
	var scene = input_handler.GetEventNode()
	scene.visible = true
	scene.Start(scenes[name], debug, line)

func CreateGearItem(item, parts, bonus = {}, newname = null):
	var newitem = Item.new()
	newitem.CreateGear(item, parts, bonus)
	if newname != null:
		newitem.name = newname
	return newitem

func CreateUsableItem(item, amount = 1):
	var newitem = Item.new()
	newitem.CreateUsable(item, amount)
	return newitem

func AddItemToInventory(item):
	item.inventory = state.items
	if item.stackable == false:
		item.id = "i" + str(state.itemcounter)
		state.items[item.id] = item
		state.itemcounter += 1
	else:
		var id = get_item_id_by_code(item.itembase)
		if id != null:
			state.items[id].amount += item.amount
		else:
			item.id = "i" + str(state.itemcounter)
			state.items[item.id] = item
			state.itemcounter += 1
		

func get_item_id_by_code(itembase):
	for item in state.items.values():
		if item.itembase == itembase:
			return item.id
	
	return null

func dir_contents(target):
	var dir = Directory.new()
	var array = []
	if dir.open(target) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				array.append(target + "/" + file_name)
			elif !file_name in ['.','..', null] && dir.current_is_dir():
				array += dir_contents(target + "/" + file_name)
			file_name = dir.get_next()
		return array
	else:
		print("An error occurred when trying to access the path.")

func evaluate(input): #used to read strings as conditions when needed
	var script = GDScript.new()
	script.set_source_code("var active_slave\nfunc eval():\n\treturn " + input)
	script.reload()
	var obj = Reference.new()
	obj.set_script(script)
	obj.active_slave = input_handler.scene_character
	return obj.eval()



func ClearContainer(container):
	for i in container.get_children():
		if i.name != 'Button':
			i.hide()
			i.queue_free()

func ClearContainerForced(container):
	for i in container.get_children():
		if i.name != 'Button':
			i.hide()
			i.free()

func DuplicateContainerTemplate(container):
	var newbutton = container.get_node('Button').duplicate()
	newbutton.show()
	container.add_child(newbutton)
	container.move_child(container.get_node('Button'), newbutton.get_position_in_parent())
	return newbutton

func connecttexttooltip(node, text):
	if node.is_connected("mouse_entered",self,'showtexttooltip'):
		node.disconnect("mouse_entered",self,'showtexttooltip')
	node.connect("mouse_entered",self,'showtexttooltip', [node, text])

func showtexttooltip(node, text):
	var texttooltip = input_handler.GetTextTooltip()
	texttooltip.showup(node, text)

func connectitemtooltip(node, item):
	if node.is_connected("mouse_entered",item,'tooltip'):
		node.disconnect("mouse_entered",item,'tooltip')
	node.connect("mouse_entered",item,'tooltip', [node])

func connecttempitemtooltip(node, item, mode):
	if node.is_connected("mouse_entered",self,'tempitemtooltip'):
		node.disconnect("mouse_entered",self,'tempitemtooltip')
	node.connect("mouse_entered",self,'tempitemtooltip', [node, item, mode])

func tempitemtooltip(targetnode, item, mode):
	var node = input_handler.GetItemTooltip()
	var data = {}
	var text = '[center]' + item.name + '[/center]\n' + item.descript
	data.text = text
	data.item = item
	data.icon = item.icon
	data.price = str(item.price)
	node.showup(targetnode, data, mode)

func connectskilltooltip(node, skill, character):
	if node.is_connected("mouse_entered",self,'showskilltooltip'):
		node.disconnect("mouse_entered",self,'showskilltooltip')
	node.connect("mouse_entered",self,'showskilltooltip', [skill,node,character])

func showskilltooltip(skill, node, character):
	var skilltooltip = input_handler.GetSkillTooltip()
	skilltooltip.character = character
	skilltooltip.showup(node, skill)

func closeskilltooltip():
	var skilltooltip = input_handler.GetSkillTooltip()
	skilltooltip.set_process(false)
	skilltooltip.hide()

#func disconnectitemtooltip(node, item):
#	if node.is_connected("mouse_entered",item,'tooltip'):
#		node.disconnect("mouse_entered",item,'tooltip')

func connectmaterialtooltip(node, material, bonustext = ''):
	if node.is_connected("mouse_entered",self,'mattooltip'):
		node.disconnect("mouse_entered",self,'mattooltip')
	node.connect("mouse_entered",self,'mattooltip', [node, material, bonustext])

func connectslavetooltip(node, person):
	if node.is_connected("mouse_entered",self,'slavetooltip'):
		node.disconnect("mouse_entered",self,'slavetooltip')
	node.connect("mouse_entered",self,'slavetooltip', [node, person])

func slavetooltip(targetnode, person):
	var node = input_handler.GetSlaveTooltip()
	node.showup(targetnode, person)

func mattooltip(targetnode, material, bonustext = '', type = 'materialowned'):
	var image
	var node = input_handler.GetItemTooltip()
	var data = {}
	var text = '[center]' + material.name + '[/center]\n' + material.descript
	data.text = text + bonustext
	data.item = material
	data.icon = material.icon
	data.price = str(material.price)
	if state.materials[material.code] > 0:
		data.amount = state.materials[material.code]
	
	node.showup(targetnode, data, type)

func loadimage(path):
	#var file = File.new()
	if typeof(path) == TYPE_OBJECT:
		return path
	if path == null:
		return
	if path.find('res:') >= 0:
		return load(path)
	var image = Image.new()
	if File.new().file_exists(path):
		image.load(path)
	var temptexture = ImageTexture.new()
	temptexture.create_from_image(image)
	return temptexture



func RomanNumberConvert(value):
	var rval = ''
	match value:
		1:
			rval = 'I'
		2:
			rval = 'II'
		3:
			rval = 'III'
		4:
			rval = 'IV'
		5:
			rval = 'V'
		6:
			rval = 'VI'
		7:
			rval = 'VII'
		8:
			rval = 'VIII' 
		9:
			rval = 'IX'
		10:
			rval = 'X'

func AddPanelOpenCloseAnimation(node):
	if node.get_script() == null:
		node.set_script(load("res://files/Close Panel Button/ClosingPanel.gd"))
	node._ready()

func TextEncoder(text, node = null):
	var tooltiparray = []
	var counter = 0
	while text.find("{") != -1:
		var newtext = text.substr(text.find("{"), text.find("}") - text.find("{")+1)
		var newtextarray = newtext.split("|")
		var originaltext = newtextarray[newtextarray.size()-1].replace("}",'')
		newtextarray.remove(newtextarray.size()-1)
		var startcode = ''
		var endcode = ''
		for data in newtextarray:
			data = data.replace('{','').split("=")
			
			match data[0]:
				'color':
					startcode += '[color=' + hexcolordict[data[1]] + ']'
					endcode = '[/color]' + endcode
				'url':
					tooltiparray.append(data[1])
					startcode += '[url=' + str(counter) + ']'
					endcode = '[/url]' + endcode
					counter += 1
				'check':
					if evaluate(data[1]) == false:
						originaltext = ''
		
		
		text = text.replace(newtext, startcode + originaltext + endcode)
	if node != null:
		node.bbcode_text = text
		if tooltiparray.size() != 0:
			node.set_meta('tooltips', tooltiparray)
			if node.is_connected("meta_hover_started", self, "BBCodeTooltip") == false:
				node.connect("meta_hover_started", self, "BBCodeTooltip", [node])
				node.connect("meta_hover_ended",self, 'hidetooltip')
	else:
		return text

func BBCodeTooltip(meta, node):
	var text = node.get_meta('tooltips')[int(meta)]
	#showtooltip(text, node)

func ItemSelect(targetscript, type, function, requirements = true):
	var node 
	if get_tree().get_root().has_node("ItemSelect"):
		node = get_tree().get_root().get_node("ItemSelect")
		get_tree().get_root().remove_child(node)
		get_tree().get_root().add_child(node)
	else:
		node = load("res://ItemSelect.tscn").instance()
		get_tree().get_root().add_child(node)
		AddPanelOpenCloseAnimation(node)
		node.name = 'ItemSelect'
	
	
	node.show()
	
	ClearContainer(node.get_node("ScrollContainer/GridContainer"))
	
	var array = []
	if type == 'gear':
		for i in state.items.values():
			if i.geartype == requirements && i.task == null && i.owner == null && i.durability > 0:
				array.append(i)
	elif type == 'repairable':
		for i in state.items.values():
			if i.durability < i.maxdurability:
				array.append(i)
	elif type == 'sex_use':
		for i in state.items.values():
			if i.interaction_use == true:
				array.append(i)
	
	for i in array:
		var newnode = DuplicateContainerTemplate(node.get_node("ScrollContainer/GridContainer"))
		match type:
			'gear':
				i.set_icon(newnode.get_node("icon"))
				newnode.get_node("Percent").show()
				newnode.get_node("Percent").text = str(calculatepercent(i.durability, i.maxdurability)) + '%'
				connectitemtooltip(newnode, i)
			'sex_use':
				i.set_icon(newnode.get_node("icon"))
				newnode.get_node("Percent").show()
				newnode.get_node('name').text = i.name
				newnode.get_node("Percent").text = str(i.amount)
				connectitemtooltip(newnode, i)
		newnode.connect('pressed', targetscript, function, [i])
		newnode.connect('pressed',self,'CloseSelection', [node])

func CloseSelection(panel):
	panel.hide()

func calculatepercent(value1, value2):
	return value1*100/max(value2,1)

func AddOrIncrementDict(dict, newdict):
	for i in newdict:
		if dict.has(i):
			dict[i] += newdict[i]
		else:
			dict[i] = newdict[i]

func MergeDicts(dict1, dict2, overwrite = false):
	var returndict = dict1
	for i in dict2:
		if returndict.has(i) && overwrite == false:
			returndict[i] += dict2[i]
		else:
			returndict[i] = dict2[i]
	
	return returndict

func scanfolder(path): #makes an array of all folders in modfolder
	var dir = Directory.new()
	var array = []
	if dir.dir_exists(path) == false:
		dir.make_dir(path)
	if dir.open(path) == OK:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() && !file_name in ['.','..',null]:
				array.append(path + file_name)
			file_name = dir.get_next()
		return array

func QuickSave():
	SaveGame('QuickSave')




func SaveGame(name):
#	approach 1, not compatrible with sigletones + still  need reworking
#	var savedict = {state = null, heroes = [], items = [], workers = []}
#	savedict.state = inst2dict(state)
#	for i in state.heroes.values():
#		savedict.heroes.append(inst2dict(i))
#	for i in state.items.values():
#		savedict.items.append(inst2dict(i))
#	for i in state.workers.values():
#		savedict.workers.append(inst2dict(i))
	#approach 2
	var savedict = state.serialize(); 
	file.open(userfolder + 'saves/' + name + '.sav', File.WRITE)
	file.store_line(to_json(savedict))
	file.close()

func LoadGame(filename):
	if !file.file_exists(userfolder+'saves/'+ filename + '.sav') :
		print("no file %s" % (userfolder+'saves/'+ filename + '.sav'))
		return
	
	input_handler.BlackScreenTransition(1)
	yield(get_tree().create_timer(1), 'timeout')
	input_handler.CloseableWindowsArray.clear()
	#approach 1
	#state = load("res://src/gamestate.gd").new()
	#state._ready()
	
	
	file.open(userfolder+'saves/'+ filename + '.sav', File.READ)
	var savedict = parse_json(file.get_as_text())
	file.close()
	
	state.deserialize(savedict)
	
	#current approach
	CurrentScene.queue_free()
	ChangeScene('mansion');
	yield(self, "scene_changed")

	
	#state = dict2inst(savedict.state)
	#state.heroes.clear()
	#state.items.clear()
	#state.workers.clear()
#	for i in savedict.heroes:
#		var t = combatant.new()
#		t = dict2inst(i)
#		state.heroes[t.id] = t
#	for i in savedict.items:
#		var t = Item.new()
#		t = dict2inst(i)
#		t.inventory = state.items #no other inventories currently exist
#		state.items[t.id] = t
#	for i in savedict.workers:
#		var t = worker.new()
#		t = dict2inst(i)
#		state.workers[t.id] = t
	
	#converting floats to ints
	
#	var tempdict = {}
#	for i in state.combatparty.keys():
#		tempdict[int(i)] = state.combatparty[i]
#	state.combatparty = tempdict.duplicate()
#	tempdict.clear()
	
#	for i in state.areaprogress.keys():
#		tempdict[i] = int(state.areaprogress[i])
#	state.areaprogress = tempdict.duplicate()
#	tempdict.clear()
	
#	for i in state.townupgrades.keys():
#		tempdict[i] = int(state.townupgrades[i])
#	state.townupgrades = tempdict.duplicate()
#	tempdict.clear()
#	WE NEED BUILDSCREEN IN MANSION!!! (at least to rebuild slavelist)
#	CurrentScene.buildscreen()
#	for i in state.tasks:
#		CurrentScene.buildcounter(i)
#
#	if state.CurBuild != '' and state.CurBuild != null:
#		CurrentScene.get_node(state.CurBuild).show()
#	#opentextscene
#	if state.CurEvent != "":
#		StartEventScene(state.CurEvent, false, state.CurrentLine);
#	else:
#		call_deferred('EventCheck');

func datetime_comp(a, b):
	if a.year > b.year: return true
	if a.month > b.month: return true
	if a.day > b.day: return true
	if a.hour > b.hour: return true
	if a.minute > b.minute: return true
	if a.second > b.second: return true
	return false
	

func get_last_save():
	var dir = dir_contents(userfolder + 'saves')
	var dated_dir = {}
	var tmp = File.new()
	for i in dir_contents(userfolder + 'saves'):
		if i.ends_with('.sav') == false:
			continue
		dated_dir[i] = OS.get_datetime_from_unix_time(tmp.get_modified_time(i))
	if dated_dir.size() == 0: return null
	var b = dated_dir.keys()[0]
	for i in range(dated_dir.keys().size()):
		if datetime_comp(dated_dir[dated_dir.keys()[i]], dated_dir[b]):
			b = dated_dir.keys()[i]
	return b

func fastif(value, result1, result2):
	if value:
		return result1
	else:
		return result2



func addrelations(person, person2, value):
	if person.professions.has("master") || person2.professions.has("master") || person == person2:
		return
	if person.relations.has(person2.id) == false:
		person.relations[person2.id] = 0
	if person2.relations.has(person.id) == false:
		person2.relations[person.id] = 0
	if person.relations[person2.id] > 500 && value > 0 && checkifrelatives(person, person2):
		value = value/1.5
	elif person.relations[person2.id] < -500 && value < 0 && checkifrelatives(person,person2):
		value = value/1.5
	person.relations[person2.id] += value
	person.relations[person2.id] = clamp(person.relations[person2.id], -1000, 1000)
	person2.relations[person.id] = person.relations[person2.id]
	if person.relations[person2.id] < -200 && value < 0:
		person.stress += rand_range(4,8)
		person2.stress += rand_range(4,8)

func connectrelatives(person1, person2, way):
	if person1 == null || person2 == null:
		return
	if state.relativesdata.has(person1.id) == false:
		createrelativesdata(person1)
	if state.relativesdata.has(person2.id) == false:
		createrelativesdata(person2)
	if way in ['mother','father']:
		var entry = state.relativesdata[person1.id]
		entry.children.append(person2.id)
		for i in entry.children:
			if i != person2.id:
				var entry2 = state.relativesdata[i]
				connectrelatives(person2, entry2, 'sibling')
		entry = state.relativesdata[person2.id]
		entry[way] = person1.id
		if typeof(person1) != TYPE_DICTIONARY && typeof(person2) != TYPE_DICTIONARY:
			addrelations(person1, person2, 200)
	elif way == 'sibling':
		var entry = state.relativesdata[person1.id]
		var entry2 = state.relativesdata[person2.id]
		if entry.siblings.has(entry2.id) == false: entry.siblings.append(entry2.id)
		if entry2.siblings.has(entry.id) == false: entry2.siblings.append(entry.id)
		for i in entry.siblings + entry2.siblings:
			if !state.relativesdata[i].siblings.has(entry.id) && i != entry.id:
				state.relativesdata[i].siblings.append(entry.id)
			if !state.relativesdata[i].siblings.has(entry2.id) && i != entry2.id:
				state.relativesdata[i].siblings.append(entry2.id)
			if !entry.siblings.has(i) && i != entry.id:
				entry.siblings.append(i)
			if !entry2.siblings.has(i) && i != entry2.id:
				entry2.siblings.append(i)
		
		if typeof(person1) != TYPE_DICTIONARY && typeof(person2) != TYPE_DICTIONARY:
			addrelations(person1, person2, 0)


func createrelativesdata(person):
	var newdata = {name = person.get_full_name(), id = person.id, race = person.race, sex = person.sex, mother = -1, father = -1, siblings = [], halfsiblings = [], children = []}
	state.relativesdata[person.id] = newdata

func clearrelativesdata(id):
	var entry
	if state.relativesdata.has(id):
		entry = state.relativesdata[id]
		
		for i in ['mother','father']:
			if state.relativesdata.has(entry[i]):
				var entry2 = state.relativesdata[entry[i]]
				entry2.children.erase(id)
		for i in entry.siblings:
			if state.relativesdata.has(i):
				var entry2 = state.relativesdata[i]
				entry2.siblings.erase(id)
		
	
	state.relativesdata.erase(id)

func checkifrelatives(person, person2):
	var result = false
	var data1 
	var data2
	if state.relativesdata.has(person.id):
		data1 = state.relativesdata[person.id]
	else:
		createrelativesdata(person)
		data1 = state.relativesdata[person.id]
	if state.relativesdata.has(person2.id):
		data2 = state.relativesdata[person2.id]
	else:
		createrelativesdata(person2)
		data2 = state.relativesdata[person2.id]
	for i in ['mother','father']:
		if str(data1[i]) == str(data2.id) || str(data2[i]) == str(data1.id):
			result = true
	for i in [data1, data2]:
		if i.siblings.has(data1.id) || i.siblings.has(data2.id):
			result = true
	
	
	return result

func getrelativename(person, person2):
	var result = null
	var data1 
	var data2
	if state.relativesdata.has(person.id):
		data1 = state.relativesdata[person.id]
	else:
		createrelativesdata(person)
		data1 = state.relativesdata[person.id]
	if state.relativesdata.has(person2.id):
		data2 = state.relativesdata[person2.id]
	else:
		createrelativesdata(person2)
		data2 = state.relativesdata[person2.id]
	
	#print(data1, data2)
	for i in ['mother','father']:
		if str(data1[i]) == str(data2.id):
			result = '$parent'
		elif str(data2[i]) == str(data1.id):
			result = '$son'
	for i in [data1, data2]:
		if i.siblings.has(data1.id) || i.siblings.has(data2.id):
			result = '$sibling'
	if result != null:
		result = person2.dictionary(result)
	return result

func impregnate(father, mother):
	if mother.has_womb == false:
		return
	var check = true
	if father.race != mother.race:
		for i in [father, mother]:
			var race = i.race
			if race.find("Beastkin") >= 0:
				race = 'Beastkin'
			elif race.find('Halfkin') >= 0:
				race = "Halfkin"
			
			if impregnation_compatibility.has(race) == false:
				check = false
	if check == false && mother.professions.has('breeder') == false:
		return #incompatible races
	
	var baby = Slave.new()
	if randf() >= 0.5:
		baby.race = mother.race
	else:
		baby.race = father.race
	if father.race.find('Beastkin') >= 0 && mother.race.find("Beastkin") < 0:
		baby.race = father.race.replace("Beastkin", "Halfkin")
	elif mother.race.find('Beastkin') >= 0 && father.race.find("Beastkin") < 0:
		baby.race = mother.race.replace("Beastkin", "Halfkin")
	baby.create(baby.race, 'random', 'teen')
	for i in inheritedassets:
		if randf() >= 0.5:
			baby.set(i, father[i])
		else:
			baby.set(i, mother[i])
	
	for i in inheritedstats:
		if randf() >= 0.5 || mother.professions.has("breeder"):
			baby.set(i, mother[i])
		else:
			baby.set(i, father[i])
	baby.relatives.mother = mother.id
	baby.relatives.father = father.id
	baby.baby_transform()
	mother.pregnancy.baby = baby.id
	mother.pregnancy.duration = variables.pregduration
	state.babies[baby.id] = baby


var punishcategories = ['spanking','whipping','nippleclap','clitclap','nosehook','mashshow','facesit','afacesit','grovel']