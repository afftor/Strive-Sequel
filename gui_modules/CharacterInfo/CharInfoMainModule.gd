extends Panel

var active_person
var char_module_state

onready var ClassesModule = $SlaveClassesModule
onready var DetailsModule = $SlaveDetailsModule
onready var SummaryModule = $SlaveSummaryModule
onready var SlaveSiblingsModule = $SlaveSiblingsModule
onready var BodyModule = $SlaveBodyModule
onready var SlaveInfo = $SlaveInfoModule
onready var submodules = []
var inventory_scene

func _ready():
	gui_controller.add_close_button(self, "add_offset")
#	for module in self.get_children():
#		module.update()
#	update()
	$TalkButton.connect("pressed", self, 'talk', [])
	$SlaveBodyModule/StatsButton.connect('pressed', self, 'displaymetrics',[])

var unique_dict = { #shows available talk characters. Scenes go in order from higher priority and reqs to lower. No scenes isn't supported yet
	kurdan = {
	code = 'kurdan', 
	scenes = [
		{code = 'kurdan_dialogue_start', reqs = []}
		]
	},
	
	zephyra = {
	code = 'zephyra', 
	scenes = [
		{code = 'zephyra_dialogue_start', reqs = []}
		]
	},
	
	anastasia = {
	code = 'anastasia', 
	scenes = [
		{code = 'anastasia_dialogue_start', reqs = []}
	]
	},
	
	daisy = {
	code = 'daisy', 
	scenes = [
		{code = 'daisy_dialogue_start', reqs = []}
	]
	},
	
	
	aire = {
	code = 'aire', 
	scenes = [
		{code = 'gryphon_aire_start', reqs = [
				{type = 'decision', value = 'mindbreak_completed', check = false},
				{code = 'value_check', type = 'dialogue_seen', check = false, value = 'GRYPHON_AIRE_START'},
				{type = 'unique_character_checks', name = 'anastasia', value = [{code = 'is_dead', check = false}]}
			]
		},
		{code = 'aire_dialogue_start', reqs = []}
	]
	},
	cali = {
	code = 'cali', 
	scenes = [
		{code = 'cali_dialogue_start', reqs = []}
	]
	},
	
	lilia = {
	code = 'lilia', 
	scenes = [
		{code = 'lilia_dialogue_start', reqs = []}
	]
	},
	
}


func talk():
	input_handler.active_character = active_person
	var unique = active_person.get_stat('unique')
	if unique_dict.has(unique):
		gui_controller.close_scene(self)
		var scene 
		for i in unique_dict[unique].scenes:
			if globals.checkreqs(i.reqs):
				scene = i.code
				break
				
		if scene != null:
			input_handler.interactive_message(scene)

func update():
	# active_person = gui_controller.mansion.active_person if SummaryModule.selected_person == null else SummaryModule.selected_person
	active_person = input_handler.interacted_character
	SummaryModule.show_summary()
	SlaveInfo.update()
	BodyModule.update()
	ClassesModule.update()
	SlaveSiblingsModule.update()
	$SlaveBodyModule/StatsPanel.hide()
	$TalkButton.visible = unique_dict.has(active_person.get_stat('unique'))
	if char_module_state == "siblings" or char_module_state == "skills":
		$TalkButton.hide()

func set_state(state):
	if state == char_module_state:
		gui_controller.windows_opened.clear()
		char_module_state = "default"
	else:
		char_module_state = state
	match_state()

func match_state():
	update()
	$CloseButton.visible = !ClassesModule.get_node("ClassPanel").is_visible_in_tree() #currently this is not required at all - due to similar effect of both closebuttons
	for b in SummaryModule.get_node("GridContainer").get_children():
		b.set_pressed(false)
	match char_module_state:
		"default":
			#gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
			#gui_controller.inventory.hide()
	
			DetailsModule.hide()
			ClassesModule.hide()
			SlaveSiblingsModule.hide()
			BodyModule.show()
			SlaveInfo.show()
			$TalkButton.show()
			$SlaveBodyModule/Body.show()
			$SlaveBodyModule/buffscontainer.show()
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 255
		"skills":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(ClassesModule)
			DetailsModule.hide()
			SlaveSiblingsModule.hide()
			ClassesModule.get_node('stats_upgrade').hide()
			ClassesModule.class_category("all")
			ClassesModule.show()
			ClassesModule.open(active_person)
			$SlaveBodyModule/Body.hide()
			$SlaveBodyModule/buffscontainer.hide()
			SummaryModule.get_node("GridContainer/SkillsButton").set_pressed(true)
			$SlaveBodyModule/buffscontainer.hide()
			#BodyModule.hide()
		"details":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(DetailsModule)
			ClassesModule.hide()
			SlaveSiblingsModule.hide()
			DetailsModule.unpress_buttons()
			DetailsModule.custom_description_open()
			DetailsModule.show()
			SummaryModule.get_node("GridContainer/DetailsButton").set_pressed(true)
			$TalkButton.show()
			$SlaveBodyModule/Body.show()
			$SlaveBodyModule/buffscontainer.show() #or hide? it's all good @Sphinx
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 255
		"gear":
			#char_module_state = "default"
			gui_controller.windows_opened.clear()
			$SlaveBodyModule/buffscontainer.hide()
			open_gear()
		"siblings":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(SlaveSiblingsModule)
			$TalkButton.hide()
			$SlaveBodyModule/buffscontainer.hide()
			$SlaveBodyModule/Body.hide()
			$SlaveBodyModule/buffscontainer.hide()
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 0
			SlaveInfo.hide()
			DetailsModule.hide()
			ClassesModule.hide()
			SummaryModule.get_node("GridContainer/SiblingsButton").set_pressed(true)
			SlaveSiblingsModule.show()
			SlaveSiblingsModule.DietModule.open_diet_window()
			SlaveSiblingsModule.update()
			#BodyModule.hide()
	




#func _on_Button_pressed():
		# pass


func open_gear():
	self.hide()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.inventory, 0.3)
	gui_controller.inventory.show()
	gui_controller.inventory.get_node("GridContainer/GearButton").set_pressed(true)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(active_person)
	gui_controller.emit_signal("screen_changed")


var sources = {
	brothel_customer = "a customer of a brothel",
	guild_trainer = "a guild trainer",
	
}

func displaymetrics():
	$SlaveBodyModule/StatsPanel.visible = !$SlaveBodyModule/StatsPanel.visible
	
	if !$SlaveBodyModule/StatsPanel.visible: return
	
	var text = ""
	var person = active_person
	if person.is_players_character:
		text += "[name] has been a part of your household for {color=yellow|%d} weeks and {color=yellow|%d} days." % ResourceScripts.game_globals.get_week_and_day_custom(ResourceScripts.game_globals.date - person.get_stat('metrics_ownership'))
	
	text += "\n\n[He] went on dates with you {color=yellow|%d} time(s) and engaged in sex activities {color=yellow|%d} time(s)." % [person.get_stat('metrics_dates'), person.get_stat('metrics_sex')]
	var partner_number = person.get_stat('metrics_partners').size() + person.get_stat('metrics_randompartners')
	var no_sex = false
	if partner_number == 0:
		text += "[He] didn't appear to engage into sexual activity with anyone so far... "
		no_sex = true
	elif partner_number == 1:
		text += "[He] only had a {color=yellow|single partner} for all this time. "
	else:
		text += "Overall [he] had sex with {color=yellow|%d} partners during all this time. " % partner_number
	
	if no_sex == false:
		text += "\n"
		if person.get_stat('has_womb') == true:
			text += "[He] was impregnated {color=yellow|%d} time(s) which ended in child birth {color=yellow|%d} time(s)" % [person.get_stat('metrics_pregnancy'), person.get_stat('metrics_birth')]
		if person.get_stat('penis_size') != '':
			text += "[He] had impregnated {color=yellow|%d} time(s). " % [person.get_stat('metrics_impregnation')]
	
	
		
		
		if person.get_stat('vaginal_virgin_lost').source != null:
			if person.get_stat('vaginal_virgin_lost').source.begins_with('hid'):
				var source = ResourceScripts.game_party.relativesdata[person.get_stat('vaginal_virgin_lost').source]
				
				if source.id == ResourceScripts.game_party.get_master().id:
					text += "\n[He] lost [his] vaginal virginity to {color=yellow|you}."
				else:
					text += "\n[He] lost [his] vaginal virginity to {color=yellow|}" + source.name + "}."
			else:
				text += "\n[He] lost [his] vaginal virginity to {color=yellow|" + sources[person.get_stat('vaginal_virgin_lost').source] + "}."
		
		if person.get_stat('anal_virgin_lost').source != null:
			if person.get_stat('anal_virgin_lost').source.begins_with('hid'):
				var source = ResourceScripts.game_party.relativesdata[person.get_stat('anal_virgin_lost').source]
				
				if source.id == ResourceScripts.game_party.get_master().id:
					text += "\n[His] first experience with anal penetration was with {color=yellow|you}."
				else:
					text += "\n[His] first experience with anal penetration was with  {color=yellow|" + source.name + "}."
			else:
				text += "\n[His] first experience with anal penetration was with  {color=yellow|" + sources[person.get_stat('anal_virgin_lost').source] + "}."
	
	
	text += '\n\n[He] earned {color=yellow|%d} gold, gathered {color=yellow|%d} food and {color=yellow|%d} materials while working on you. ' % [person.get_stat("metrics_goldearn"), person.get_stat("metrics_foodearn"),person.get_stat("metrics_materialearn")]
	
	text += "\n\n[He] engaged in {color=yellow|%d} battles and defeated {color=yellow|%d} enemies." % [person.get_stat("metrics_win"), person.get_stat("metrics_kills"),]
	
	text = person.translate(globals.TextEncoder(text))
	
	$SlaveBodyModule/StatsPanel/RichTextLabel.bbcode_text = text
#	if person.get_stat('anal_virgin_lost').source != null:
#		text += "\n[He] lost his anal virginity to " + person.get_stat('anal_virgin_lost').source


