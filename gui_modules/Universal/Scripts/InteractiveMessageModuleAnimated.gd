extends Control

var previousscene
var dialogue_enemy
var current_scene
var hold_selection = false #pause for scene to load
var previous_dialogue_option = 0
var previous_text = ''
var base_text_size
var base_text_position
var doing_transition = false
const type_trans_time_default = 0.5
var type_trans_time = type_trans_time_default
var next_dialogue_type = 1
var dialogue_window_type = 1
var is_just_started = true

onready var bg_T1 = $BackgroundT1
onready var bg_T2 = $BackgroundT2
onready var text_label_T1 = $BackgroundT1/RichTextLabel
onready var text_label_T2 = $BackgroundT2/RichTextLabel
var cur_text_label
onready var opt_cont_T1 = $BackgroundT1/ScrollContainer/VBoxContainer
onready var opt_cont_T2 = $BackgroundT2/ScrollContainer/VBoxContainer
var cur_opt_cont

func _ready():
	$BackgroundT2/BackgroundT2/HideButton.connect("pressed", self, "hide_dialogue")
	$ShowPanel/ShowButton.connect("pressed", self, "hide_dialogue", ["show"])
	$CharacterImage.material = load("res://assets/silouette_shader.tres").duplicate()
	if get_node_or_null("CharacterImage2") != null:
		$CharacterImage2.material = load("res://assets/silouette_shader.tres").duplicate()
	base_text_size = text_label_T1.rect_size
	base_text_position = text_label_T1.rect_position
	cur_text_label = text_label_T1
	cur_opt_cont = opt_cont_T1
	#$BackgroundT2/UnhideButton.connect('pressed', self, 'hide_dialogue', ['unhide'])
	

#should be used only at dialogue_window_type==2
func hide_dialogue(action = "hide"):
	$BackgroundT2.visible = action != "hide"
	$ShowPanel.visible = action == "hide"

func open(scene):
	if gui_controller.dialogue == null:
		gui_controller.dialogue = self
	if scene.has("variations"):
		select_scene_variation_based_on_data(scene)
		return
#	if get_tree().get_root().get_node_or_null("ANIMLoot") && get_tree().get_root().get_node("ANIMLoot").is_visible():
#		get_tree().get_root().get_node("ANIMLoot").raise()
	input_handler.PlaySound("speech")
	if is_just_started:
		hide()
		var preset_type = 1
		if scene.has("dialogue_type"):
			preset_type = scene.dialogue_type
		preset_dialogue_type(preset_type)
		next_dialogue_type = preset_type
		cur_text_label.bbcode_text = ''
		previous_text = ''
	
	get_tree().get_root().set_disable_input(true)
	if scene.has("save_scene_to_gallery") && scene.save_scene_to_gallery:
		save_scene_to_gallery(scene)
	
	if scene.has("dialogue_type"):
		next_dialogue_type = scene.dialogue_type
	
	var new_text_label
	var new_background
	var old_background
	var is_type_changing = (dialogue_window_type != next_dialogue_type)
	if is_type_changing:
		dialogue_window_type = next_dialogue_type
		match dialogue_window_type:
			1:
				old_background = $BackgroundT2
				new_text_label = text_label_T1
				new_background = $BackgroundT1
				cur_opt_cont = opt_cont_T1
			2:
				old_background = $BackgroundT1
				new_text_label = text_label_T2
				new_background = $BackgroundT2
				cur_opt_cont = opt_cont_T2
		if cur_text_label != new_text_label:#should probably always be true
			new_text_label.bbcode_text = cur_text_label.bbcode_text
			cur_text_label = new_text_label
	
	if input_handler.CurrentScreen != 'scene': previousscene = input_handler.CurrentScreen
	input_handler.CurrentScreen = 'scene'
	current_scene = scene
	hold_selection = true
	raise()
	if get_tree().get_root().get_node_or_null("ANIMLoot") && get_tree().get_root().get_node("ANIMLoot").is_visible():
		get_tree().get_root().get_node("ANIMLoot").raise()
	#common_effects was here
	if typeof(scene.text) == TYPE_STRING:
		scene.text = [{text = scene.text, reqs = []}]
	#MIND! From current code's point of view starting dialogue_option is 0, so
	#"previous_dialogue_option = 0" in event dict should be enough, BUT there is
	#standalone event editor, which kills all dialogue_option 0-params outright,
	#so start_dialogue_option had been added to bypass this.
	if scene.has('start_dialogue_option') and previous_dialogue_option == 0:
		previous_dialogue_option = scene.start_dialogue_option
	
	#handle transition
	var opt_scroll = cur_opt_cont.get_parent()
	if is_just_started:
		cur_text_label.modulate.a = 0
		opt_scroll.modulate.a = 0
	else:
		cur_text_label.modulate.a = 1
		opt_scroll.modulate.a = 1
	var no_screen_transition = false
	if scene.tags.has("blackscreen_transition_common"):
		ResourceScripts.core_animations.BlackScreenTransition(1)
		doing_transition = true
		yield(get_tree().create_timer(1), "timeout")
	elif scene.tags.has("whitescreen_transition_common"):
		ResourceScripts.core_animations.WhiteScreenTransition(1)
		doing_transition = true
		yield(get_tree().create_timer(1), "timeout")
	elif scene.tags.has("blackscreen_transition_slow"):
		ResourceScripts.core_animations.BlackScreenTransition(2)
		doing_transition = true
		yield(get_tree().create_timer(2), "timeout")
	else:
		no_screen_transition = true
	if is_type_changing:
		if no_screen_transition:
			ResourceScripts.core_animations.FadeAnimation(old_background, type_trans_time)
			try_hide_scene_backgrounds(scene, type_trans_time)
			yield(get_tree().create_timer(type_trans_time), "timeout")
		else:
			try_hide_scene_backgrounds(scene, 0.0)
		old_background.hide()
	if !is_visible():
		show()
		ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)
#		yield(get_tree().create_timer(0.2), "timeout")#preparations should undergo befor Unfade
	doing_transition = false
	
	#prepare screen while (if) in dark
	if is_type_changing:
		new_background.show()
		if no_screen_transition:
			new_background.modulate.a = 0
			ResourceScripts.core_animations.UnfadeAnimation(new_background, type_trans_time)
		else:
			new_background.modulate.a = 1
	if scene.has("common_effects"):
		globals.common_effects(scene.common_effects)
	clear_character_images()
	$BackgroundT1/ImagePanel.hide()
	handle_scene_backgrounds(scene)
	handle_characters_sprites(scene)
	handle_loots(scene)
	update_scene_characters()
	generate_scene_text(scene)
	set_enemy(scene)
	handle_scene_options()
	
	yield(get_tree().create_timer(0.5), "timeout")
	if ResourceScripts.core_animations.BeingAnimated.has(self):
		ResourceScripts.core_animations.BeingAnimated.erase(self)
	hold_selection = false
	show_buttons()
	is_just_started = false
	type_trans_time = type_trans_time_default
	if get_tree().get_root().get_node_or_null("lootwindow") && get_tree().get_root().get_node("lootwindow").is_visible():
		get_tree().get_root().get_node("lootwindow").raise()
	if get_tree().get_root().get_node_or_null("ANIMTaskAquared") && get_tree().get_root().get_node("ANIMTaskAquared").is_visible():
		get_tree().get_root().get_node("ANIMTaskAquared").raise()
	
	show()

func preset_dialogue_type(new_type):
	var old_background
	var new_background
	if new_type == 1:
		old_background = $BackgroundT2
		cur_text_label = text_label_T1
		new_background = $BackgroundT1
		cur_opt_cont = opt_cont_T1
	elif new_type == 2:
		old_background = $BackgroundT1
		cur_text_label = text_label_T2
		new_background = $BackgroundT2
		cur_opt_cont = opt_cont_T2
	old_background.hide()
	new_background.modulate.a = 1
	new_background.show()
	$CustomBackground.hide()#if new_type == 2, BG will be switched on in handle_scene_backgrounds()


func show_buttons():
	get_tree().get_root().set_disable_input(true)
	for button in cur_opt_cont.get_children():
		if button.name == "Button":
			continue
		ResourceScripts.core_animations.UnfadeAnimation(button, 0.3)
		yield(get_tree().create_timer(0.3), "timeout")
		button.set("modulate", Color(1, 1, 1, 1))
	get_tree().get_root().set_disable_input(false)

func complete_skirmish():
	hold_selection = true
#	globals.complete_location(input_handler.active_location.id)
#	globals.remove_location(input_handler.active_location.id)
	close()

func update_scene_characters():
	input_handler.ClearContainer($EventCharacters/VBoxContainer)
	input_handler.ClearContainer($PlayerCharacters/VBoxContainer)
	for i in input_handler.scene_characters:
		var newbutton = input_handler.DuplicateContainerTemplate($EventCharacters/VBoxContainer)
		newbutton.get_node("Label").text = i.get_short_name()
		newbutton.get_node('icon').texture = i.get_icon()
		globals.connectslavetooltip(newbutton, i)
		newbutton.indialog = true
#		if i.is_players_character == false:
#			newbutton.connect('signal_RMB_release',self, 'show_full_info', [i])
		newbutton.connect('signal_RMB_release',self, 'show_full_info', [i])


# Temporary
func show_full_info(person):
	gui_controller.close_all_closeable_windows()
	var FullSlaveInfo = input_handler.get_spec_node(input_handler.NODE_EXPLORE_SLAVEINFO)
	gui_controller.explore_slaveinfo = FullSlaveInfo
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.explore_slaveinfo
	FullSlaveInfo.show()
	FullSlaveInfo.from_dialogue = true
	FullSlaveInfo.show_summary(person)
	FullSlaveInfo.get_node("PurchaseButton").hide()
	FullSlaveInfo.get_node("Price").hide()
	FullSlaveInfo.get_node("TextureRect").hide()
#	FullSlaveInfo.update_purchase_btn()


var stored_scene

func dialogue_next(code, argument, args = {}):
	hold_selection = true
	previous_dialogue_option = argument
	input_handler.interactive_message_follow(code, '', args)


func chest_mimic_force_open():
	hold_selection = true
	var chest_data = input_handler.scene_loot
	match chest_data.lock.type:
		'mimic':
			input_handler.interactive_message_follow("chest_is_mimic_trapped", "story_event", {})
		'mimic_erotic':
			input_handler.interactive_message_follow("chest_is_erotic_mimic_trapped", "story_event", {})

func add_chest_options(scene):
	var chest_data = input_handler.scene_loot
	var text = ""
	var engineer
	for i in input_handler.get_location_characters():
		if i.check_trait("trap_analyze"):
			engineer = i
			break

	if engineer != null:
		var lock_read = false
		if engineer.lockpick_chance() > rand_range(0.5,2)*chest_data.lock.difficulty:
			lock_read = true

		text += "\n\n[Engineer]: "
		if lock_read == false:
			text += "[name] wasn't able to determine chest's lock mechanism and its potential danger."
		else:
			match chest_data.lock.type:
				'normal':
					text += "[name] concludes this chest is locked with a {color=aqua|mechanic lock} and has no additional danger."
				'none':
					text += "[name] concludes this chest is {color=aqua|unlocked} and safe to use."
				'bomb':
					text += "[name] concludes this chest is rigged with a {color=aqua|bomb trap}."
				'gas':
					text += "[name] concludes this chest is rigged with a {color=aqua|gas trap}."
				'mimic','mimic_erotic':
					text += "[name] wasn't able to determine chest's lock mechanism and its potential danger."
				'alarm':
					text += "[name] notices a hidden alarm mechanism tied to a lock, which wil llikely cause an uproar if triggered."

		text = globals.TextEncoder(engineer.translate(text))

	 #= "\n\nChest Lock: " +  str(chest_data.lock.type)
#	if chest_data.lock.type != 'none':
#		text += "\nDifficulty: " + ResourceScripts.custom_text.lock_difficulty(chest_data.lock.difficulty)

	scene.text.append({text = text, reqs = []})
	scene.options.insert(0,{code = 'lockpick_attempt', select_person = true, reqs = [], text = "DIALOGUECHESTLOCKPICK"})


func add_recruit_option(scene):
	if input_handler.scene_characters.empty():
		input_handler.scene_characters.push_back(input_handler.active_character)
		input_handler.active_character = null
	var char_to_recruit = input_handler.scene_characters[0]
	if char_to_recruit == null:
		print("error - no char")
		return
	var state = char_to_recruit.src
	if state == 'random_combat':
		scene.options.insert(1,{code = 'recruit_option_safe', reqs = [], text = "DIALOGUERECRUITFORCEATTEMPT"})
	var char2 = input_handler.active_character
	if char2 != null:
		scene.options.insert(1,{code = 'recruit_option', reqs = [], text = "DIALOGUERECRUITATTEMPT"})
		if char2.has_profession("succubus") || char2.has_profession("true_succubus"):
			scene.options.insert(1, {code = 'recruit_succubus', reqs = [{type = 'active_character_checks', value = [{code = 'has_any_profession', value = ['succubus','true_succubus']}, {code = 'stat', stat = 'mp', operant = 'gte', value = 30}]}], text = "DIALOGUERECRUITSUCCUBUS"})
		elif char2.has_profession("succubus") || char2.has_profession("true_succubus") && char2.get_stat('mp') < 30:
			scene.options.insert(1, {code = 'recruit_succubus', disabled = true, reqs = [], text = "DIALOGUERECRUITSUCCUBUS"})

func recruit_option_safe():
	var char_to_recruit = input_handler.scene_characters[0]
	if char_to_recruit == null:
		print("error - no char")
		return
	var state = char_to_recruit.src
	input_handler.interactive_message_follow("recruit_captured_enslave", "story_event", {})
	input_handler.active_location.captured_characters.erase(char_to_recruit.id)
	input_handler.emit_signal("LocationSlavesUpdate")

func recruit_succubus():
	var char_to_recruit = input_handler.scene_characters[0]
	if char_to_recruit == null:
		print("error - no char")
		return
	var state = char_to_recruit.src
	var char2 = input_handler.active_character
	if state == 'random_combat':
		input_handler.interactive_message_follow("recruit_captured_success_seduce", "story_event", {})
	else:
		input_handler.interactive_message_follow("recruit_meet_success_seduce", "story_event", {})
	
	char2.add_stat('lust', -30)
	input_handler.active_location.captured_characters.erase(char_to_recruit.id)
	input_handler.emit_signal("LocationSlavesUpdate")

func recruit_option():
	var char_to_recruit = input_handler.scene_characters[0]
	if char_to_recruit == null:
		print("error - no char")
		return
	var state = char_to_recruit.src
	var char2 = input_handler.active_character
	var val1 = char_to_recruit.get_stat('wits_factor')
	var val2 = char2.get_stat('charm') * 0.30
	if state == 'random_combat':
		if 30 + val2 > randf()*110 + (val1 * 5):
			input_handler.interactive_message_follow("recruit_captured_success", "story_event", {})
		else:
			input_handler.interactive_message_follow("recruit_captured_fail", "story_event", {})
	else:
		if 40 + val2 > randf()*100 + (val1 * 5):
			input_handler.interactive_message_follow("recruit_meet_success", "story_event", {})
		else:
			input_handler.interactive_message_follow("recruit_meet_fail", "story_event", {})
	
	char2.add_stat('charm', globals.rng.randi_range(1, 3))
	input_handler.active_location.captured_characters.erase(char_to_recruit.id)
	input_handler.emit_signal("LocationSlavesUpdate")


func add_harvest_options(scene):
	if gui_controller.exploration_dungeon == null:
		scene.options.insert(0,{code = 'close', reqs = [], text = "DIALOGUECLOSE"})
	else:
		var data = gui_controller.exploration_dungeon.get_subroom_data()
		scene.options.insert(0,{code = 'close', reqs = [], text = "Leave for later", bonus_effects = [{code = "add_subroom_res"}]})
		scene.options.insert(0,{code = 'close', reqs = [{type = 'has_stamina', value = data.stamina_cost}], text = "Gather %d %s" % [int(data.amount) / 2, tr(Items.materiallist[data.resource].name)] , bonus_effects = [{code = "material_change", operant = '+', value = int(data.amount) / 2, material = data.resource}, {code = 'pay_stamina', value = data.stamina_cost}, {code = 'clear_subroom'}]})



func add_shrine_options(scene):
	var shrineoptions = Enemydata.shrines[scene.shrine].options
	var array = shrineoptions.keys()
	array.invert()
	for i in array:
		match shrineoptions[i].input:
			'material':
				scene.options.insert(0,{code = 'shrine_option', args = ['select_material'], reqs = [], text = "DIALOGUESHRINEITEM"})
			'character': #this can cause lock if called at empty combat party
				scene.options.insert(0,{code = 'shrine_option', args = ['character'], active_char_translate = true, reqs = [], text = "DIALOGUESHRINECHARACTER"})
			'destroy':
				scene.options.insert(0,{code = 'shrine_option', args = ['destroy'], reqs = [], text = "DIALOGUESHRINEDESTROY"})
			'item':
				scene.options.insert(0,{code = 'shrine_option', args = ['select_item'], reqs = [], text = "DIALOGUESHRINEEQUIP"})


func shrine_option(option):
	match option:
		'select_material':
			globals.ItemSelect(self, 'material', 'shrine_mat_select')
		'select_item':
			globals.ItemSelect(self, 'gear', 'shrine_item_select')
		"character":
			input_handler.scene_characters.append(input_handler.active_character)
			update_scene_characters()
			Enemydata.call(Enemydata.shrines[current_scene.shrine].options['character'].output, input_handler.active_character) 
		'destroy':
			Enemydata.call(Enemydata.shrines[current_scene.shrine].options['destroy'].output, input_handler.active_character)
		'material_selected':
			Enemydata.call(Enemydata.shrines[current_scene.shrine].options['material'].output, selected_item)
		'item_selected':
			Enemydata.call(Enemydata.shrines[current_scene.shrine].options['item'].output, selected_item)

var selected_item

func shrine_mat_select(item):
	selected_item = item
	shrine_option('material_selected')

func shrine_item_select(item):
	selected_item = item
	shrine_option('item_selected')


func add_loot_options(scene):
	scene.options.insert(0,{code = 'open_chest', reqs = [], text = "DIALOGUETAKELOOT", bonus_effects = [{code = 'advance_location'}]})


#func add_location_resource_info(): #not used, reworked
#	var text = '\nAfter defeating last enemies your party investigated the location and found a resources you can harvest:'
#	var location = input_handler.active_location
#	for i in location.gather_limit_resources:
#		text += "\n" + Items.materiallist[i].name + ": " + str(location.gather_limit_resources[i])
#	text += '\n\nHarvest speed modifier: ' + str(round(location.gather_mod*100)) + "%"
#	return text


func add_location_resource_info():
	if gui_controller.exploration_dungeon == null:
		return "" 
	var data = gui_controller.exploration_dungeon.get_subroom_data()
	data.resource = tr(Items.materiallist[data.resource].name)
	var text = tr("DIALOGUEEVENTDUNGEONRESOURCE").format(data)
	return text


func lockpick_attempt(person):
	globals.common_effects([{code = 'clear_subroom'}])
	var lock = input_handler.scene_loot.lock.difficulty
	var type = input_handler.scene_loot.lock.type
	var nonlocked = false
	var lockpickskill = person.lockpick_chance()
	if type == 'none':
		lock = 0
		nonlocked = true
	elif type in ['mimic','mimic_erotic']:
		lock = lock * randf()*2
	var open = lockpickskill >= lock
	if !type in ['none','mimic','mimic_erotic']:
		person.add_stat('wits', rand_range(2,3))

	if type in ['mimic','mimic_erotic'] && open == true:
		input_handler.interactive_message_follow("chest_is_mimic_discovered", "story_event", {})
	elif type in ['mimic']:
		input_handler.interactive_message_follow("chest_is_mimic_trapped", "story_event", {})
	elif type in ["mimic_erotic"]:
		input_handler.interactive_message_follow("chest_is_erotic_mimic_trapped", "story_event", {})
	elif type in ['alarm']:
		input_handler.interactive_message_follow("lockpick_alarm_failure", "story_event", {})
	elif type == 'none':
		input_handler.interactive_message_follow("lockpick_chest_free", "story_event", {})
	elif open == true:
		input_handler.interactive_message_follow("lockpick_chest_success", "story_event", {})
		input_handler.add_random_chat_message(person, 'lockpick_success')
	else:
		match type:
			'normal':
				input_handler.interactive_message_follow("lockpick_chest_failure", "story_event", {})
			'bomb':
				input_handler.interactive_message_follow("lockpick_chest_bomb_failure", "story_event", {})
			'gas':
				input_handler.interactive_message_follow("lockpick_chest_gas_failure", "story_event", {})
		input_handler.add_random_chat_message(person, 'lockpick_failure')

func select_person_for_next_event(option): #needs a rework
	var reqs
	var code = option.code
	if option.has('person_reqs'):
		reqs = option.person_reqs
	elif code.find('marriage')!= -1:
		reqs = [
			{code = 'stat', stat = 'agreed_to_marry', operant = 'eq', value = true}
		]
	elif code.find('trap') != -1 or code.find('shrine') != -1: #imho there should be also a lockpicking events
		reqs = [
			{code = 'is_at_location', value = input_handler.active_location.id, check = true},
			{code = 'in_combat_party', value = true}
			]
	elif code.find('savra_talk_5') != -1:
		reqs = [
			{code = 'stat', stat = 'magic_factor', operant = 'gte', value = 5}
		]
	elif code.find('temple_1') != -1:
		reqs = [
			{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 5}
		]
	elif code.find('lira_encounter_5_1_1') != -1:
		reqs = [ 
			{code = 'stat', stat = 'race', operant = 'eq', value = "TribalElf"},
#			{code = 'is_master', check = false}
		]
	elif code.find('cali_william_9') != -1:
		reqs = [ 
			{code = 'stat', stat = 'unique', operant = 'neq', value = "cali"},
			{code = 'is_master', check = false}
		]
	elif code in ['pass_lock_discount','pass_blocked_path','pass_magic_barrier','pass_ancient_lock','pass_enemy_strength_scare','pass_enemy_dexterity_sneak','pass_enemy_charm_damage','pass_enemy_charm_avoid']:
		reqs = [
			{code = 'is_at_location', value = gui_controller.exploration_dungeon.active_location.id, check = true},
			{code = 'in_combat_party', value = true},
			]
	elif code == 'pass_fallen_bridge':
		reqs = [
			{code = 'is_at_location', value = gui_controller.exploration_dungeon.active_location.id, check = true},
			{code = 'in_combat_party', value = true},
			{code = 'stat', stat = 'wings', operant = 'neq', value = ''}
			]
	elif code == 'pass_small_crack':
		reqs = [
			{code = 'is_at_location', value = gui_controller.exploration_dungeon.active_location.id, check = true},
			{code = 'in_combat_party', value = true},
			{code = 'is_shortstack', check = true}
			]
	else:
		reqs = [
			{code = 'is_at_location', value = input_handler.active_location.id, check = true},
#			{code = 'in_combat_party', value = true}
			]
	stored_scene = code
	var challenge = null
	if option.has('challenge'):
		challenge = option.challenge
	
	input_handler.ShowSlaveSelectPanel(self, 'event_person_selected', reqs, false, challenge)

func remove_person(code):
	var reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'remove_selected', reqs)

func remove_non_master(code):
	var reqs = [{code = 'is_at_location', value = input_handler.active_location.id, check = true}, {code = 'is_master', check = false}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'remove_selected', reqs)

func remove_servant(code):
	var reqs = [{code = 'stat', stat = 'slave_class', value = 'servant', check = true}]
	stored_scene = code
	input_handler.ShowSlaveSelectPanel(self, 'remove_selected', reqs)

func remove_selected(person):
	input_handler.active_character = person
	ResourceScripts.game_party.add_fate(person.id, tr("LOST"))
	ResourceScripts.game_party.remove_slave(person)
	input_handler.slave_list_node.rebuild()

	var event_type = 'story_event'
	if scenedata.scenedict[stored_scene].has('default_event_type'):
		event_type = scenedata.scenedict[stored_scene].default_event_type
	input_handler.interactive_message_follow(stored_scene, event_type, {})

func event_person_selected(person):
	input_handler.active_character = person
	if stored_scene == 'lockpick_attempt':
		lockpick_attempt(person)
		return
	var data = scenedata.scenedict[stored_scene]
	var event_type = 'story_event'
	if scenedata.scenedict[stored_scene].has('default_event_type'):
		event_type = scenedata.scenedict[stored_scene].default_event_type
	input_handler.interactive_message_follow(stored_scene, event_type, {})


func close(args = {}):
	hold_selection = true
	if !args.has('transition'):
		args.transition = false 
	if !args.has('finish_scene'):
		args.finish_scene = true
	hold_selection = true
	ch1 = null
	ch2 = null
	previous_dialogue_option = 0
	if dialogue_window_type == 2:
#		previous_text = ""
		dialogue_window_type = 1
		var screen_duration = 1.0
		if args.has('screen_duration'):
			screen_duration = args.screen_duration
		var transition_duration = screen_duration * 0.5
		if args.has('transition_duration'):
			transition_duration = args.transition_duration
		if screen_duration <= 0.001:
			ResourceScripts.core_animations.FadeAnimation(self, 0.2)
			yield(get_tree().create_timer(0.2), "timeout")
		else:
			ResourceScripts.core_animations.FadeAnimation(self, transition_duration, screen_duration * 0.25)
			ResourceScripts.core_animations.BlackScreenTransition(screen_duration * 0.5)
			yield(get_tree().create_timer(transition_duration + screen_duration * 0.25), "timeout")
		cur_text_label.bbcode_text = ''
	else:
		if !args.has("hold_scene"):
			ResourceScripts.core_animations.FadeAnimation(self, 0.2)
			yield(get_tree().create_timer(0.2), "timeout")
	hold_selection = false
	if !args.has("hold_scene"):
		hide()
	if args.transition == false:
		input_handler.scene_characters.clear()
	input_handler.CurrentScreen = previousscene
	if args.finish_scene: input_handler.emit_signal("EventFinished")
	input_handler.event_finished()
	is_just_started = true


func cancel_skill_usage():
	input_handler.active_character.restore_skill_charge(gui_controller.mansion.SkillModule.active_skill)
	input_handler.scene_characters.pop_back()
	close()

func repeat():
	input_handler.repeat_social_skill()
	# input_handler.update_slave_panel()

func recruit_from_scene(order = 0):
	input_handler.active_character = input_handler.scene_characters[order]
	recruit()

func capture_from_scene(order = 0):
	input_handler.active_character = input_handler.scene_characters[order]
	recruit(true)


func recruit(capture = false):
	hold_selection = true
#	if ResourceScripts.game_party.characters.size() >= ResourceScripts.game_res.get_pop_cap():
#		if ResourceScripts.game_res.get_pop_cap() < variables.max_population_cap:
#			input_handler.SystemMessage("You don't have enough rooms")
#		else:
#			input_handler.SystemMessage("Population limit reached")
#		hold_selection = false
#		return
	input_handler.active_character.recruit(capture)
	close()

func create_location_recruit(args):
	var newchar = ResourceScripts.scriptdict.class_slave.new("location_recruit")
	input_handler.active_character = newchar
	newchar.generate_random_character_from_data(input_handler.active_location.races)
	cur_text_label.bbcode_text = newchar.translate(cur_text_label.bbcode_text)

func execute():
	close()

func inspect_active_character():
	input_handler.ShowSlavePanel(input_handler.active_character)

func inspect_character_child():
	input_handler.ShowSlavePanel(ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby])

func keepbaby():
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	var person = ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby]
	person.statlist.get_random_name(true)
#	input_handler.active_character.get_stat('pregnancy', true).baby = null
	node.open(self, 'set_baby_name', person.get_stat('name'))
	

func removebaby():
	ResourceScripts.game_party.add_fate(input_handler.active_character.get_stat('pregnancy').baby, tr("KEEPNOT"))
#	if (int(ResourceScripts.game_globals.date) % input_handler.globalsettings.autosave_frequency == 0) and int(ResourceScripts.game_globals.hour) == 1:
#		globals.autosave(true)
	close()
	ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby].is_active = false
	ResourceScripts.game_party.babies.erase(input_handler.active_character.get_stat('pregnancy').baby)
	input_handler.active_character.get_stat('pregnancy', true).baby = null

func set_baby_name(text):
	var person = ResourceScripts.game_party.babies[input_handler.active_character.get_stat('pregnancy').baby]
#	person.baby_transform()
	input_handler.active_character.get_stat('pregnancy', true).baby = null
	person.set_stat('name', text)
	person.setup_as_heir()
	ResourceScripts.game_party.add_slave(person, true)
	input_handler.interactive_message_follow('select_tutelage', '', '')
#	if (int(ResourceScripts.game_globals.date) % input_handler.globalsettings.autosave_frequency == 0) and int(ResourceScripts.game_globals.hour) == 1:
#		globals.autosave(true)
#	close()

func open_chest():
	hold_selection = true
	var loot_win = input_handler.get_spec_node(input_handler.ANIM_LOOT)
	if !gui_controller.windows_opened.has(loot_win):
		gui_controller.windows_opened.append(loot_win)
	loot_win.open(input_handler.scene_loot)
	loot_win.raise()
	# input_handler.get_spec_node(input_handler.NODE_LOOTTABLE).open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
	# var loot_win = input_handler.get_spec_node(input_handler.ANIM_LOOT)
	# loot_win.get_node("AnimationPlayer").play("Loot")
	#input_handler.get_loot_node().open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
	close()

func good_event():
	var eventlist = input_handler.active_location.event_pool
	var array = []
	for i in eventlist:
		if scenedata.scenedict[i[0]].has('tags') && scenedata.scenedict[i[0]].tags.has('good'):
			array.append(i)

	if array.size() == 0:
		print("no correct good event: " + input_handler.active_location.events)
		return
	var event = input_handler.weightedrandom(array)
	var eventtype = "event_selection"
	var dict = {}
	if scenedata.scenedict[event].has("default_event_type"):
		eventtype = scenedata.scenedict[event].default_event_type
	if scenedata.scenedict[event].has('bonus_args'):
		dict = scenedata.scenedict[event].bonus_args
	input_handler.interactive_message(event, eventtype, dict)

func evil_event():
	input_handler.SystemMessage("This feature is not implemented yet")

func leave():
	hold_selection = true
	close()

func fight_skirmish():
	globals.char_roll_data.no_roll = true
	if current_scene.has("winscene"):
		input_handler.encounter_win_script = current_scene.winscene
	globals.current_enemy_group = dialogue_enemy
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
	#close(true)

func quest_fight(code):
	globals.char_roll_data.no_roll = true
	globals.current_enemy_group = code
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
	#close(true)



func save_scene_to_gallery(scene):
	if scene.has("unlocked_gallery_seq"):
		input_handler.update_progress_data("gallery_seq", scene.unlocked_gallery_seq)
#i was forced to add this field to correctly bound unlock event with gallery object
#with this new syntax it unlocks a full gallery sequence and so it reqires to make some changes into scenes
#i still can add an option to unlock a sequences per scene
#but it will still force us to make a changes into scenes to correctly pass data (scenes ids)
	if scene.has("scene_type"):
		var progress_field
		if scene.scene_type == "story_scene":
			progress_field = "story_scenes"
		elif scene.scene_type == "ero_scene":
			progress_field = "ero_scenes"
		if progress_field != null:
			input_handler.update_progress_data(progress_field, scene.custom_background)
			if scene.has("additionally_open"):
				for addition in scene.additionally_open:
					input_handler.update_progress_data(progress_field, addition)


func select_scene_variation_based_on_data(scene):
	for i in scene.variations:
		if globals.checkreqs(i.reqs):
			open(i)
			break

func clear_character_images():
	$CharacterImage.hide()
	$CharacterImage2.hide()

func handle_scene_backgrounds(scene):
	var node = $CustomBackground
	if scene.has("custom_background"):
		var newtexture = images.get_background(scene.custom_background)
		if !node.visible:
			node.texture = newtexture
			node.modulate.a = 0
			node.show()
			ResourceScripts.core_animations.UnfadeAnimation(node, type_trans_time)
		elif node.texture != newtexture:
			ResourceScripts.core_animations.SmoothTextureChange(node, newtexture, 1)
	try_hide_scene_backgrounds(scene, type_trans_time)

func try_hide_scene_backgrounds(scene, time):
	var node = $CustomBackground
	if !node.visible or node.get_meta("fading", false): return
	if !scene.has("custom_background") && dialogue_window_type == 1:
		if time > 0:
			ResourceScripts.core_animations.FadeAnimation(node, time)
			node.set_meta("fading", true)
			yield(get_tree().create_timer(time), "timeout")
			node.set_meta("fading", false)
		node.hide()

var ch1 = null
var ch2 = null
var ch1_shade = false
var ch2_shade = false


func get_spouse_sprite():
	var spousechar = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
	if spousechar == null: return null
	else:
		match spousechar.get_stat('unique'):
			'anastasia': return 'anastasia'
			'daisy': return 'daisy_maid'
			#2add
			_: return null

func handle_characters_sprites(scene):
	#--i do not understand conditions and sequencing of most of code in cases of characters do exist
	#--so i think that there are some logical errors here
	#reworked with additional functional
	var scene_char = null
	var char_shade = false
	var image_panel = $BackgroundT1/ImagePanel
	var for_gallery
	var for_gallery2
	
	if !scene.has("character") and !scene.has("character2"):
		$CharacterImage2.hide()
		$CharacterImage.hide()
		if scene.has('image') && scene.image != '' && scene.image != null:
			image_panel.show()
			image_panel.get_node("SceneImage").texture = images.get_scene(scene.image)
			input_handler.update_progress_data("monochrome", scene.image)
			if dialogue_window_type == 1:
				hide_long_text()
		else:
			image_panel.hide()
			if dialogue_window_type == 1:
				show_long_text()
	else:
		image_panel.hide()
		if dialogue_window_type == 1:
			show_long_text()

		if scene.has("character"):
			if scene.character.ends_with('_shade'):
				scene_char = scene.character.trim_suffix('_shade')
				char_shade = true
			else:
				scene_char = scene.character
				char_shade = false
				if scene_char == 'spouse':
					scene_char = get_spouse_sprite()
			if scene_char != null and ch1 != scene_char:
				# test if it's a different char and not just a variation
				var unique_name_char: String = "unique_char"
				var unique_name_ch1: String = "ch1"
				if ch1 and ch1.find('_') != -1 and scene_char.find('_') != -1:
					unique_name_ch1 = ch1.left(ch1.find('_'))
					unique_name_char = scene_char.left(scene_char.find('_'))
				if not unique_name_char == unique_name_ch1:
					ResourceScripts.core_animations.UnfadeAnimation($CharacterImage, type_trans_time)
				
				$CharacterImage.texture = images.get_sprite(scene_char)
				for_gallery = scene_char
				if char_shade:
					$CharacterImage.material.set_shader_param('opacity', 1.0)
					ch1_shade = true
				else:
					$CharacterImage.material.set_shader_param('opacity', 0.0)
					ch1_shade = false
				ch1 = scene_char
				$CharacterImage.show()
			elif scene_char != null:
				if char_shade != ch1_shade:
					if char_shade: ResourceScripts.core_animations.ShadeAnimation($CharacterImage, type_trans_time)
					else: ResourceScripts.core_animations.UnshadeAnimation($CharacterImage, type_trans_time)
					ch1_shade = char_shade
				$CharacterImage.show()
			else:
				$CharacterImage.hide()
#			$CharacterImage.show()
		if scene.has("character2"):
			if scene.character2.ends_with('_shade'):
				scene_char = scene.character2.trim_suffix('_shade')
				char_shade = true
			else:
				scene_char = scene.character2
				char_shade = false
				if scene_char == 'spouse':
					scene_char = get_spouse_sprite()
			if scene_char != null and ch2 != scene_char:
				ResourceScripts.core_animations.UnfadeAnimation($CharacterImage2, type_trans_time)
				$CharacterImage2.texture = images.get_sprite(scene_char)
				for_gallery2 = scene_char
				if char_shade:
					$CharacterImage2.material.set_shader_param('opacity', 1.0)
					ch2_shade = true
				else:
					$CharacterImage2.material.set_shader_param('opacity', 0.0)
					ch2_shade = false
				ch2 = scene_char
				$CharacterImage2.show()
			elif scene_char != null:
				if char_shade != ch2_shade:
					if char_shade: ResourceScripts.core_animations.ShadeAnimation($CharacterImage2, type_trans_time)
					else: ResourceScripts.core_animations.UnshadeAnimation($CharacterImage2, type_trans_time)
					ch2_shade = char_shade
				$CharacterImage2.show()
			else:
				$CharacterImage2.hide()
#			$CharacterImage2.show()
	
	#handle modulation
#	$CharacterImage.self_modulate.a = 255
#	$CharacterImage2.self_modulate.a = 255
#	if scene.has("character_alpha"):
#		$CharacterImage.self_modulate.a = scene.character_alpha
#	if scene.has("character2_alpha"):
#		$CharacterImage2.self_modulate.a = scene.character2_alpha
	
	# setting nude versions here
	if scene.has("character"):
		scene_char = scene.character
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if scene_char != null && person.get_stat("unique") == scene_char && person.has_work_rule('nudity') && worlddata.pregen_character_sprites[scene_char].has("nude"):
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
	#			var image = input_handler.loadimage(images.sprites[non_body], 'shades')
#				var image = images.get_sprite(worlddata.pregen_character_sprites[scene_char].nude.path.replace("_body", ""))
				var image = images.get_sprite(non_body)
				if image != null:
					$CharacterImage.texture = image
					for_gallery = non_body
				else:
					$CharacterImage.texture = person.get_body_image()
				ch1 = person.get_stat("unique").to_lower()
	if scene.has("character2"):
		scene_char = scene.character2
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if scene_char != null && person.get_stat("unique") == scene_char && person.has_work_rule('nudity') && worlddata.pregen_character_sprites[scene_char].has("nude"):
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
	#			var image = input_handler.loadimage(images.sprites[non_body], 'shades')
#				var image = images.sprites[worlddata.pregen_character_sprites[scene_char].nude.path.replace("_body", "")]
				var image = images.get_sprite(non_body)
				if image != null:
					$CharacterImage2.texture = image
					for_gallery2 = non_body
				else:
					$CharacterImage2.texture = person.get_body_image()
				ch1 = person.get_stat("unique").to_lower()
			
	# setting wed versions here
	if scene.has("character"):
		scene_char = scene.character
		if ResourceScripts.game_progress.spouse != null && globals.valuecheck({type = 'has_spouse', check = true}) and !ResourceScripts.game_progress.marriage_completed:
			# set wed sprite here
			var spouse_person = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
			var spouse_unique_name = spouse_person.get_stat('unique')
			if scene_char == spouse_unique_name and worlddata.pregen_character_sprites[scene_char].has("wed"):
				var image_name = worlddata.pregen_character_sprites[scene_char].wed.path
				$CharacterImage.texture = images.get_sprite(image_name)
				for_gallery = image_name
	
	
	#handle unique character script
	if scene.has("unique_character"):
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if person.get_stat("unique") == scene.unique_character:
				$CharacterImage.show()
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
				var image = input_handler.loadimage(images.sprites[non_body], 'shades') #needs testing, idk if this is still in use
				if $CharacterImage.texture != image:
					ResourceScripts.core_animations.UnfadeAnimation($CharacterImage, type_trans_time)
				if images.sprites.has(non_body):
					$CharacterImage.texture = image
				else:
					$CharacterImage.texture = person.get_body_image()
				$CharacterImage.material.set_shader_param('opacity', 0.0)
				ch1_shade = false
				ch1 = person.get_stat("unique").to_lower()
				return
	if scene.has("unique_character2"):
		for i in ResourceScripts.game_party.characters: 
			var person = ResourceScripts.game_party.characters[i]
			if person.get_stat("unique") == scene.unique_character2:
				$CharacterImage2.show()
				var non_body = person.statlist.statlist.body_image.replace("_body", "")
				var image = input_handler.loadimage(images.sprites[non_body], 'shades') #the same as above
				if $CharacterImage2.texture != image:
					ResourceScripts.core_animations.UnfadeAnimation($CharacterImage2, type_trans_time)
				if images.sprites.has(non_body):
					$CharacterImage2.texture = image
				else:
					$CharacterImage2.texture = person.get_body_image()
				$CharacterImage2.material.set_shader_param('opacity', 0.0)
				ch2_shade = false
				ch2 = person.get_stat("unique")
				return
	
	if for_gallery != null:
		input_handler.update_progress_data("characters", for_gallery)
	if for_gallery2 != null:
		input_handler.update_progress_data("characters", for_gallery2)
#	if !scene.has("character"):
#		$ImagePanel.show()
#		$CharacterImage.hide()
#		if scene.image != '' && scene.image != null:
#			$ImagePanel/SceneImage.texture = images.scenes[scene.image]
#		else:
#			$ImagePanel.hide()
#			#$ImagePanel/SceneImage.texture = load("res://assets/images/scenes/image_wip.png")
#	else:
#		if !($CharacterImage.texture == images.sprites[scene.character]):
#			ResourceScripts.core_animations.UnfadeAnimation($CharacterImage,0.5)
#		$ImagePanel.hide()
#		$CharacterImage.texture = images.sprites[scene.character]
#		$CharacterImage.show()
#	if !scene.has("character2"):
#		$ImagePanel.show()
#		if get_node_or_null("CharacterImage2"):
#			$CharacterImage2.hide()
#		if scene.image != '' && scene.image != null:
#			$ImagePanel/SceneImage.texture = images.scenes[scene.image]
#		else:
#			$ImagePanel.hide()
#			#$ImagePanel/SceneImage.texture = load("res://assets/images/scenes/image_wip.png")
#	else:
#		if !($CharacterImage2.texture == images.sprites[scene.character2]):
#			ResourceScripts.core_animations.UnfadeAnimation($CharacterImage2,0.5)
#		$ImagePanel.hide()
#		$CharacterImage2.texture = images.sprites[scene.character2]
#		$CharacterImage2.show()

#long_text needed only for dialogue_window_type==1
func show_long_text():
	var options_background = $BackgroundT1/OptionsBackground
	var dialogue_BG = $BackgroundT1/DialogueBG
	var long_frame = $BackgroundT1/LongFrame
	bg_T1.get_stylebox("panel", "").modulate_color.a = 0
	long_frame.show()
	dialogue_BG.rect_size.y = long_frame.rect_size.y - options_background.rect_size.y
	dialogue_BG.rect_position.y = long_frame.rect_position.y
	cur_text_label.rect_size.y = long_frame.rect_size.y - 249 - 50
	cur_text_label.rect_position.y = long_frame.rect_position.y + 46#($ScrollContainer.rect_size.y * 0.5)

func hide_long_text():
	var options_background = $BackgroundT1/OptionsBackground
	var dialogue_BG = $BackgroundT1/DialogueBG
	var long_frame = $BackgroundT1/LongFrame
	bg_T1.get_stylebox("panel", "").modulate_color.a = 255
	long_frame.hide()
	dialogue_BG.rect_size.y = bg_T1.rect_size.y - options_background.rect_size.y
	dialogue_BG.rect_position.y = 0
	cur_text_label.rect_size = base_text_size
	cur_text_label.rect_position = base_text_position


func handle_loots(scene):
	if scene.tags.has('locked_chest'):
		add_chest_options(scene)
	if scene.tags.has("shrine"):
		add_shrine_options(scene)
	if scene.tags.has("recruit"):
		add_recruit_option(scene)
	if scene.tags.has("free_loot"):
		add_loot_options(scene)
	if scene.tags.has("location_resource_info"):
		add_harvest_options(scene)


func generate_scene_text(scene):
	var scenetext = scene.text
	var newtext = ''
	for i in scenetext:
		if i.has("previous_dialogue_option") && typeof(i.previous_dialogue_option) != TYPE_ARRAY:
			i.previous_dialogue_option = [i.previous_dialogue_option]
		if (i.has("previous_dialogue_option") && !(previous_dialogue_option in i.previous_dialogue_option)) || !globals.checkreqs(i.reqs):
			continue
		# if ResourceScripts.game_progress.seen_dialogues.has(i.text) == false && is_should_save == false:
		if input_handler.if_translation_key(i.text):
			ResourceScripts.game_progress.seen_dialogues.append(i.text)
		if i.has("bonus_effects"):
			globals.common_effects(i.bonus_effects)
		newtext += tr(i.text)
	scenetext = newtext
	scenetext = tr(scenetext)
	if scene.has('bonus_effects'):
		globals.common_effects(scene.bonus_effects)

	if scenetext.find("[locationname]") >= 0:
		scenetext = scenetext.replace("[locationname]", input_handler.selected_location.name)
		scenetext = scenetext.replace("[areaname]", input_handler.selected_area.name)
		scenetext = scenetext.replace("[locationtypename]", input_handler.selected_location.classname)
	if scene.tags.has("master_translate"):
		if ResourceScripts.game_party.get_master() == null:
			print("Error: Master not found")
#			return
		else:
			scenetext = ResourceScripts.game_party.get_master().translate(scenetext)
	if scene.tags.has("active_character_translate"):
		if input_handler.active_character != null:
			scenetext = input_handler.active_character.translate(scenetext)
	if scene.tags.has("scene_character_translate"):
		scenetext = input_handler.scene_characters[0].translate(scenetext.replace("[scnchar","["))
	if scene.tags.has("location_resource_info"):
		scenetext = add_location_resource_info()
	if is_just_started:
		ResourceScripts.core_animations.UnfadeAnimation(cur_text_label,1)
		ResourceScripts.core_animations.UnfadeAnimation(cur_opt_cont.get_parent(),1)
	input_handler.ClearContainer(cur_opt_cont)
	if scene.tags.has("scene_characters_sell"):#
		var counter = 0
		var text = ''
		for i in input_handler.scene_characters:
			text += i.get_short_name() + " " + i.get_stat('sex') + " - " + races.racelist[i.get_stat('race')].name + ": " + str(i.calculate_price(true)) + " gold\n"
			scene.options.append({code = 'recruit_from_scene', args = counter, reqs = [{type = "has_money_for_scene_slave", value = counter}], not_hide = true, text = tr("DIALOGUESLAVERSPURCHASE") + " - " + i.get_short_name() + ": " + str(i.calculate_price(true)) + " Gold", bonus_effects = [{code = 'spend_money_for_scene_character', value = counter}]})
			counter += 1
		scenetext += "\n\n" + text

	if cur_text_label.bbcode_text != '':
		cur_text_label.bbcode_text += "\n\n[color=yellow]"+previous_text+"[/color]\n\n" + globals.TextEncoder(scenetext)
	else:
		cur_text_label.bbcode_text = globals.TextEncoder(scenetext)


func set_enemy(scene):
	if scene.has("set_enemy"):
		dialogue_enemy = scene.set_enemy


func handle_scene_options():
	var option_number = 1
	var options = current_scene.options
	for id in range(options.size()):
		var i = options[id]
		if i.has("previous_dialogue_option") && typeof(i.previous_dialogue_option) != TYPE_ARRAY:
			i.previous_dialogue_option = [i.previous_dialogue_option]
		if (i.has("previous_dialogue_option") && !(previous_dialogue_option in i.previous_dialogue_option)):
			continue
		if i.has('remove_after_first_use') && ResourceScripts.game_progress.selected_dialogues.has(i.text):
			continue
		var disable = false
		if globals.checkreqs(i.reqs) == false:
			if i.has('not_hide') == true:
				disable = true
			else:
				continue
		if i.has("repeat_next_day"):
			var cont = false
			for d in ResourceScripts.game_progress.daily_dialogues:
				if d.option == i.code:
					if d.last_activation >= ResourceScripts.game_globals.date:
						cont = true
						break
			if cont:
				continue
		
		var newbutton = input_handler.DuplicateContainerTemplate(cur_opt_cont)
		newbutton.set_meta("id", id)
		newbutton.set("modulate", Color(1, 1, 1, 0))
		i.text_key = i.text
		i.text = tr(i.text)
		if i.has('active_char_translate'):
			i.text = input_handler.active_character.translate(tr(i.text))
		elif i.has('master_translate'):
			i.text = ResourceScripts.game_party.get_master().translate(i.text)
		newbutton.get_node("Label").bbcode_text = i.text
		newbutton.hotkey = option_number
		yield(get_tree(), 'idle_frame')
		newbutton.get_node("Label").rect_size.y += 8
		newbutton.rect_min_size.y = newbutton.get_node("Label").rect_size.y
		newbutton.connect("pressed",self,'select_option', [option_number - 1])
		
		
		if ResourceScripts.game_progress.selected_dialogues.has(i.text_key):
			newbutton.status = 'seen'
		if i.has('type'):
			match i.type:
				'next_dialogue':
					newbutton.status = 'next_dialogue'
		
		if i.has('disabled') && i.disabled == true:
			newbutton.status = 'disabled'
			disable = true
		if disable:
			newbutton.disabled = true
			newbutton.status = 'disabled'
		option_number += 1


func select_option(number):
#	if cur_opt_cont.get_children().size() >= number && hold_selection == false:
#		var button = cur_opt_cont.get_child(number-1)
#		if button.disabled == false && button.visible == true:
#			button.toggle_mode = true
#			button.pressed = true
#			hold_selection = true
#			yield(get_tree().create_timer(0.2), "timeout")
#			button.emit_signal("pressed")
	if hold_selection: 
		return
	if cur_opt_cont.get_child_count() <= number: return
	var button = cur_opt_cont.get_child(number)
	if button.disabled or !button.visible: 
		return
	button.toggle_mode = true
	button.pressed = true
#	hold_selection = true
	var options = current_scene.options
	var option = options[button.get_meta("id")]
	var code = option.code
	if option.has("repeat_next_day"):
		var dup = false
		for i in ResourceScripts.game_progress.daily_dialogues:
			if i.option == option.code:
				i.last_activation = ResourceScripts.game_globals.date
				dup = true
		if !dup:
			ResourceScripts.game_progress.daily_dialogues.append({
				option = option.code,
				last_activation = ResourceScripts.game_globals.date
			})
	
	if option.has("change_dialogue_type"):
		next_dialogue_type = option.change_dialogue_type
		#MIND! that all close_speed mechanics needed for normal work of blackscreen transition.
		#Since last refactor transitions works correctly without close_speed, so it's useless now.
		#I am leaving this mechanics just in case, if standalone editor would use it or for some
		#other legecy problems.
		if option.has("close_speed"):
			type_trans_time = option.close_speed
	
	if option.has('active_char_translate'):
		previous_text = input_handler.active_character.translate(tr(option.text))
	else:
		previous_text = tr(option.text)
	if !ResourceScripts.game_progress.selected_dialogues.has(option.text_key):
		ResourceScripts.game_progress.selected_dialogues.append(option.text_key)
	
	if option.has('bonus_effects'):
		globals.common_effects(option.bonus_effects)
	
	if option.has('select_person'):
		select_person_for_next_event(option)
	elif option.has('remove_person'):
		remove_person(code)
	elif option.has('remove_non_master'):
		remove_non_master(code)
	elif code == 'shrine_option':
		shrine_option(option.args[0])
	elif option.code == 'chest_mimic_force_open':
		chest_mimic_force_open()
	elif current_scene.tags.has('linked_event') && !code in ['close','leave', 'fight_skirmish','continue','recruit','recruit_from_scene']:
		hold_selection = true
		var event_type = 'story_event'
		if scenedata.scenedict[code].has('default_event_type'):
			event_type = scenedata.scenedict[code].default_event_type
		input_handler.interactive_message_follow(code, event_type, {})
	elif current_scene.tags.has("skill_event"):
		if !code == 'cancel_skill_usage':
			input_handler.active_character.use_social_skill(code, input_handler.target_character)
		elif code == 'cancel_skill_usage':
			cancel_skill_usage()
	elif current_scene.tags.has("custom_effect"):
		ResourceScripts.custom_effects.call(code) #controvertial moment cause most of those methods have a different signature
	elif current_scene.tags.has("dialogue_scene") && !(code in ['close','quest_fight']):
		
		hold_selection = true
		if option.has('dialogue_argument') == false:
			option.dialogue_argument = 0
		dialogue_next(code, option.dialogue_argument)
	else:
		var args
		if option.has('args'): args = option.args
		if args != null:
			call(code, args)
		else:
			call(code)
