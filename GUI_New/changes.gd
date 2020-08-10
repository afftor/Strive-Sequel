# NumberSelection.gd
extends Panel

# globals.gd
func _init():
	#for logging purposes
	print("Game Version: " + str(gameversion))
	print("OS: " +  OS.get_name()) 
	
	if dir.dir_exists(variables.userfolder + 'saves') == false:
		dir.make_dir(variables.userfolder + 'saves')

	if !dir.dir_exists(variables.userfolder + 'savedcharacters'):
		dir.make_dir(variables.userfolder + 'savedcharacters')
	
	for i in input_handler.dir_contents('res://src/actions'):
		if i.find('.remap') >= 0:
			continue
		var newaction = load(i).new()
		sex_actions_dict[newaction.code] = newaction
	
	for i in input_handler.dir_contents("res://assets/data/events"):
		if i.find('.gd') < 0:
			continue
		var newscript  = load(i).new()
		for k in newscript.data:
			if scenedata.scenedict.has(k) == false:
				scenedata.scenedict[k] = newscript.data[k]
			else:
				print("Error: Scene data key already exists: " + k)
				
# globals.gd func common_effects
# replace
'update_guild':
input_handler.exploration_node.City.enter_guild(input_handler.active_faction)


# leveling.gd 
func assign_to_task(taskcode, taskproduct, iterations = -1):
	#remove existing work
	remove_from_task()
	if taskcode == '':
		work = ''
		return
	var gatherable = Items.materiallist.has(taskcode)
	var task
	if !gatherable:
		task = races.tasklist[taskcode]
	else:
		task = Items.materiallist[taskcode]
	#check if task is existing and add slave to it if it does
	var taskexisted = false
	var task_location = parent.get_location()
	for i in ResourceScripts.game_party.active_tasks:
		if i.code == taskcode && i.product == taskproduct:
			taskexisted = true
			i.workers.append(parent.id)
			i.workers_count += 1
			work = i.code
	
	workproduct = taskproduct
	if taskexisted:
		return
	#make new task if it didn't exist
	var dict
	if !gatherable:
		dict = {code = taskcode, product = taskproduct, progress = 0, threshhold = task.production[taskproduct].progress_per_item, workers = [], workers_count = 1, task_location = task_location, iterations = iterations, messages = [], mod = task.mod}
	else:
		dict = {code = taskcode, product = taskproduct, progress = 0, threshhold = task.progress_per_item, workers = [], workers_count = 1, task_location = task_location, iterations = iterations, messages = [], mod = ""}
	dict.workers.append(parent.id)
	work = taskcode
	ResourceScripts.game_party.active_tasks.append(dict)
	globals.emit_signal("task_added")


func remove_from_task(remember = false):
	if work != '':
		for i in ResourceScripts.game_party.active_tasks:
			if i.code == work:
				i.workers.erase(parent.id)
				i.workers_count -= 1
	if remember && work != 'travel':
		previous_work = work
	work = ''
	

func work_tick():
	var currenttask
	for i in ResourceScripts.game_party.active_tasks:
		if i.workers.has(parent.id):
			currenttask = i
	
	if currenttask == null:
		work = ''
		parent.rest_tick()
		return
	
	if parent.statlist.is_uncontrollable() && !parent.has_profession('master'):
		if !messages.has("refusedwork"):
			globals.text_log_add('work', parent.get_short_name() + ": Refused to work")
			messages.append("refusedwork")
		return
	if parent.get_stat('obedience') > 0: #new work stat. If <= 0 and loyal/sub < 100, refuse to work
		parent.add_stat('obedience', -1)
		messages.erase("refusedwork")
	
	if parent.get_static_effect_by_code("work_rule_ration") != null:
		parent.food.food_consumption_rations = true

	if ['smith','alchemy','tailor','cooking'].has(currenttask.product) && currenttask.code != 'building':
		if ResourceScripts.game_res.craftinglists[currenttask.product].size() <= 0:
			if currenttask.messages.has('notask') == false:
				globals.text_log_add('crafting', parent.get_short_name() + ": No craft task for " + currenttask.product.capitalize() + ". ")
				currenttask.messages.append('notask')
			parent.rest_tick()
			return
		else:
			var craftingitem = ResourceScripts.game_res.craftinglists[currenttask.product][0]
			currenttask.messages.erase("notask")
			if craftingitem.resources_taken == false:
				if globals.check_recipe_resources(craftingitem) == false:
					if currenttask.messages.has('noresources') == false:
						globals.text_log_add('crafting', parent.get_short_name() + ": Not Enough Resources for craft. ")
						currenttask.messages.append("noresources")
					parent.rest_tick()
					return
				else:
					globals.spend_resources(craftingitem)
					currenttask.messages.erase("noresources")
			work_tick_values(currenttask)
			craftingitem.workunits += get_progress_task(currenttask.code, currenttask.product)#
			make_item_sequence(currenttask, craftingitem)
	
	elif currenttask.code == 'building':
		var upgrades_queue = ResourceScripts.game_res.upgrades_queue
		if upgrades_queue.size() == 0:
			self.assign_to_task('', '')
			parent.rest_tick()
			if messages.has("noupgrade") == false:
				globals.text_log_add('upgrades',parent.get_short_name() + ": No task or upgrade selected for building. ")
				messages.append("noupgrade")
			return
		else:
			messages.erase('noupgrade')
			work_tick_values(currenttask)
			if !ResourceScripts.game_res.upgrade_progresses.has(upgrades_queue[0]):
				var currentupgradelevel
				if ResourceScripts.game_res.upgrades.has(upgrades_queue[0]):
					currentupgradelevel = ResourceScripts.game_res.upgrades[upgrades_queue[0]] + 1
					ResourceScripts.game_res.upgrade_progresses[upgrades_queue[0]] = {level = currentupgradelevel, progress = 0}
			ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].progress += get_progress_task(currenttask.code, currenttask.product, true)#*(productivity/100)
			if ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].progress >= upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]].levels[ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].level].taskprogress:
				if ResourceScripts.game_res.upgrades.has(ResourceScripts.game_res.upgrades_queue[0]):
					ResourceScripts.game_res.upgrades[ResourceScripts.game_res.upgrades_queue[0]] += 1
				else:
					ResourceScripts.game_res.upgrades[ResourceScripts.game_res.upgrades_queue[0]] = 1
				input_handler.emit_signal("UpgradeUnlocked", upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]])
				globals.text_log_add('upgrades',"Upgrade finished: " + upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]].name)
				ResourceScripts.game_res.upgrade_progresses.erase(ResourceScripts.game_res.upgrades_queue[0])
				ResourceScripts.game_res.upgrades_queue.erase(ResourceScripts.game_res.upgrades_queue[0])
	else:
		var gatherable = Items.materiallist.has(currenttask.code)
		work_tick_values(currenttask, gatherable)
		if !gatherable:
			currenttask.progress += get_progress_task(currenttask.code, currenttask.product, true)#*(get_stat('productivity')*get_stat(currenttask.mod)/100)
		else:
			currenttask.progress += get_progress_resource(currenttask.code, true)
		while currenttask.threshhold <= currenttask.progress:
			currenttask.progress -= currenttask.threshhold
			if !gatherable:
				if races.tasklist[currenttask.code].production[currenttask.product].item == 'gold':
					ResourceScripts.game_res.money += 1
				else:
					ResourceScripts.game_res.materials[races.tasklist[currenttask.code].production[currenttask.product].item] += 1
			else:
				ResourceScripts.game_res.materials[currenttask.code] += 1
				var person_location = parent.get_location()
				var location = ResourceScripts.world_gen.get_location_from_code(person_location)
				if person_location != "Aliron" && location.type == "dungeon":
					if ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources[currenttask.code] == 0:
						remove_from_task()
						if ResourceScripts.game_party.active_tasks != []:
							for task in ResourceScripts.game_party.active_tasks:
								if task.code == currenttask.code && task.task_location == location.id:
									ResourceScripts.game_party.active_tasks.erase(task)
					else:
						ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources[currenttask.code] -= 1


# main.gd
# replace
NEXTCLASSEXP = "Experience required for next class.",    

# ResourceScripts.gd

var scenedict = {
	menu = "res://src/Menu.tscn",
#	mansion = "res://src/main/Mansion.tscn",
	mansion = "res://GUI_New/GUIWorld.tscn",
	loadscreen = "res://src/LoadScreen.tscn",
	combat = "res://src/combat/combat.tscn",
	itemselect = "res://ItemSelect.tscn",
	black = "res://assets/sfx/BlackScreen.tscn",
	close = "res://src/scenes/CloseButton.tscn",
	interaction = "res://src/interactionpanel.tscn",
}

onready var node_data = {
	input_handler.NODE_CLASSINFO : {name = 'classinfo', mode = 'scene', scene = preload("res://src/scenes/ClassInformationPanel.tscn")},
	input_handler.NODE_CHAT : {name = 'chatwindow', mode = 'scene', scene = preload("res://src/scenes/ChatNode.tscn")},
	input_handler.NODE_TUTORIAL : {name = 'tutorial_node', mode = 'scene', scene = preload("res://src/scenes/TutorialNode.tscn")},
	input_handler.NODE_LOOTTABLE : {name = 'lootwindow', mode = 'scene', scene = preload("res://src/scenes/LootWindow.tscn")},
	input_handler.NODE_DIALOGUE : {name = 'dialogue', mode = 'scene', scene = preload("res://GUI_New/Universal/InteractiveMessageModule.tscn")},
	# input_handler.NODE_DIALOGUE : {name = 'dialogue', mode = 'scene', scene = preload("res://src/scenes/InteractiveMessage.tscn")},
	input_handler.NODE_INVENTORY : {name = 'inventory', mode = 'scene', scene = preload("res://src/main/Inventory.tscn"), calls = 'open'},
	input_handler.NODE_POPUP : {name = 'PopupPanel', mode = 'scene', scene = preload("res://src/scenes/PopupPanel.tscn"), calls = 'open'},
	input_handler.NODE_CONFIRMPANEL : {name = 'ConfirmPanel', mode = 'scene', scene = preload("res://src/scenes/ConfirmPanel.tscn"), calls = 'Show'},
	input_handler.NODE_SLAVESELECT : {name = 'SlaveSelectMenu', mode = 'scene', scene = preload("res://src/scenes/SlaveSelectMenu.tscn")},
	input_handler.NODE_SKILLSELECT : {name = 'SelectSkillMenu', mode = 'scene', scene = preload("res://src/scenes/SkillSelectMenu.tscn")},
	#NODE_EVENT : {name = 'EventNode', mode = 'scene', scene = preload("res://src/scenes/TextSystem.tscn")},
	input_handler.NODE_MUSIC : {name = 'music', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Music"}},
	input_handler.NODE_SOUND : {name = 'sound', mode = 'node', no_return = true, node = AudioStreamPlayer, args = {'bus':"Sound"}},
	input_handler.NODE_BACKGROUND_SOUND : {name = 'BGSound', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Sound"}},
	input_handler.NODE_TEXTEDIT : {name = 'texteditnode', mode = 'scene', scene = preload("res://src/scenes/TextEditField.tscn")},
	input_handler.NODE_SLAVETOOLTIP : {name = 'slavetooltip', mode = 'scene', scene = preload("res://src/scenes/SlaveTooltip.tscn")},
	input_handler.NODE_SKILLTOOLTIP : {name = 'skilltooltip', mode = 'scene', scene = preload("res://src/scenes/SkillToolTip.tscn")},
	input_handler.NODE_ITEMTOOLTIP : {name = 'itemtooltip', mode = 'scene', scene = preload("res://src/scenes/Imagetooltip.tscn")},
	input_handler.NODE_TEXTTOOLTIP : {name = 'texttooltip', mode = 'scene', scene = preload("res://src/scenes/TextTooltipPanel.tscn")},
	# input_handler.NODE_CHARCREATE : {name = 'charcreationpanel', mode = 'scene', scene = preload("res://src/scenes/CharacterCreationPanel.tscn"), calls = 'open'},
	input_handler.NODE_CHARCREATE : {name = 'charcreationpanel', mode = 'scene', scene = preload("res://GUI_New/CharacterCreation/CharacterCreationMainModule.tscn"), calls = 'open'},
	input_handler.NODE_SLAVEPANEL : {name = 'slavepanel', mode = 'scene', scene = preload("res://src/scenes/SlavePanel.tscn")},
	input_handler.NODE_COMBATPOSITIONS : {name = 'combatpositions', mode = 'scene', scene = preload("res://src/scenes/PositionSelectMenu.tscn"), calls = 'open'},
	input_handler.NODE_SYSMESSAGE : {name = 'SysMessage', mode = 'scene', scene = preload("res://src/scenes/SysMessage.tscn") },
	input_handler.NODE_SLAVEMODULE : {name = 'slavemodule', mode = 'scene', scene = preload("res://GUI_New/CharacterInfo/CharInfoMainModule.tscn") },
	input_handler.NODE_INVENTORY_NEW : {name = 'inventory_new', mode = 'scene', scene = preload("res://GUI_New/Inventory/InventoryMainModule.tscn") },
	input_handler.NODE_MANSION_NEW : {name = 'mansion', mode = 'scene', scene = preload("res://GUI_New/Mansion/MansionMainModule.tscn") },
	input_handler.NODE_GUI_WORLD : {name = 'GUIWorld', mode = 'scene', scene = preload("res://GUI_New/GUIWorld.tscn") },
}

# ResourceImages.gd

var icons = {
	food = "res://assets/images/gui/inventory/icon_food1.png",
	material = "res://assets/images/gui/inventory/icon_res1.png",
	'tool' : "res://assets/images/gui/inventory/icon_craft1.png",
	weapon = "res://assets/images/gui/inventory/icon_weap1.png",
	armor = "res://assets/images/gui/inventory/icon_armor1.png",
	costume = "res://assets/images/gui/inventory/icon_cosm1.png",
	usable = "res://assets/images/gui/inventory/icon_potion1.png",
	
	quest_dungeon = load('res://assets/images/gui/quest_dungeon.png'),
	quest_char = load("res://assets/images/gui/quest_char.png"),
	quest_encounter = load("res://assets/images/gui/quest_encounter.png"),
	quest_enemy = load("res://assets/images/gui/quest_enemy.png"),
	quest_reputation = load("res://assets/images/gui/quest_reputation.png"),
	
	upgrade_farm = 'res://assets/images/buildings/upgrade_farm.png',
	
	stat_exp = "res://assets/images/gui/gui icons/base_exp.png",
	stat_gf = "res://assets/images/gui/gui icons/growth_factor.png",
	stat_pf = "res://assets/images/gui/gui icons/physics_factor.png",
	stat_wit = "res://assets/images/gui/gui icons/wit.png",
	stat_charm = "res://assets/images/gui/gui icons/charm.png",
	stat_sf = "res://assets/images/gui/gui icons/sex.png", 
	stat_mf = "res://assets/images/gui/gui icons/magic_factor.png",
	stat_tf = "res://assets/images/gui/gui icons/tame_factor.png",
	stat_df = "res://assets/images/gui/gui icons/timid_factor.png",
	stat_bf = "res://assets/images/gui/gui icons/brave_factor.png",
	stat_obed = "res://assets/images/gui/obed_good.png",
	stat_fear = "res://assets/images/gui/fear_good.png",
	stat_cf = "res://assets/images/gui/gui icons/charm_factor.png",
	stat_food = "res://assets/images/gui/gui icons/food.png",
	obed_good = "res://assets/images/gui/obed_good.png",
	obed_bad = "res://assets/images/gui/obed_bad.png",
	
	food_love = "res://assets/images/gui/gui icons/food_love.png",
	food_hate = "res://assets/images/gui/gui icons/food_hate.png",
	meat = "res://assets/images/gui/gui icons/icon_meat.png",
	fish = "res://assets/images/gui/gui icons/icon_fish.png",
	vege = "res://assets/images/gui/gui icons/icon_veg.png",
	grain = "res://assets/images/gui/gui icons/icon_grain.png",
	
	fear1 = "res://assets/images/gui/gui icons/fear1.png",
	fear2 = "res://assets/images/gui/gui icons/fear2.png",
	fear3 = "res://assets/images/gui/gui icons/fear3.png",
	obed1 = "res://assets/images/gui/gui icons/obedience1.png",
	obed2 = "res://assets/images/gui/gui icons/obedience2.png",
	obed3 = "res://assets/images/gui/gui icons/obedience3.png",
	
	class_master = "res://assets/Textures_v2/MANSION/icon_master.png",
	class_servant = "res://assets/images/gui/gui icons/icon_servant.png",
	class_slave = "res://assets/Textures_v2/MANSION/icon_slave.png",
	
	quest_slave_delivery = "res://assets/images/gui/slavepanel/charm.png",
	quest_gold = 'res://assets/images/iconsitems/gold.png',
	complete_location = "res://assets/images/gui/quest_encounter.png",
	complete_dungeon = "res://assets/images/gui/quest_dungeon.png",
	reputation = "res://assets/images/gui/quest_reputation.png",
	
	craft_time = "res://assets/images/gui/craftgui/Time.png",
	
	work = 'res://assets/images/gui/gui icons/workicon.png',
	rest = 'res://assets/images/gui/gui icons/sleepicon.png',
	joy = 'res://assets/images/gui/gui icons/joyicon.png',
	
	male = load("res://assets/Textures_v2/Universal/Icons/icon_male.png"),
	female = load("res://assets/Textures_v2//Universal/Icons/icon_female.png"),
	futa = load("res://assets/images/sexicons/futa.png"),
