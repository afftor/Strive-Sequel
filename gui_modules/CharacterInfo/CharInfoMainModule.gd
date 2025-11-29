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
	#$TalkButton.connect("pressed", self, 'talk', [])
	#$RemoveButton.connect('pressed',self,'remove',[])
	input_handler.connect('PortraitUpdate', self, 'update')
	input_handler.connect('SpellUsed', self, 'update')



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


func remove():
	#gui_controller.close_scene(self)
	input_handler.active_character = active_person
	input_handler.interactive_message('slave_remove')

var universal_skills = ['oral','anal','petting']

func update():
	active_person = input_handler.interacted_character
	if active_person == null:
		return
	active_person.update_prt()
	SummaryModule.show_summary()
	SlaveInfo.update()
	BodyModule.update()
	ClassesModule.update()
	SlaveSiblingsModule.update()
	
	if active_person != null:
		input_handler.ClearContainer($SlaveInfoModule/SexSkillsContainer/VBoxContainer)
		var s_skills = active_person.get_sex_skills()
		for ii in s_skills: #bad way, need to move to using proper statdata (and proper translation keys) instead of stubs
			var i = ii.trim_prefix('sex_skills_')
			if s_skills[ii] <= 0 && !universal_skills.has(i):
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($SlaveInfoModule/SexSkillsContainer/VBoxContainer)
			newbutton.get_node("Label").text = tr("SEXSKILL"+i.to_upper())
			newbutton.get_node("ProgressBar").value = s_skills[ii]
			newbutton.get_node("ProgressBar/Label").text = str(floor(s_skills[ii])) + '/100'
			globals.connecttexttooltip(newbutton,  active_person.translate(tr("SEXSKILL"+i.to_upper()+"DESCRIPT")) + "\n" + tr("CUR_LEVEL_LABEL") + ":" + str(floor(s_skills[ii])))
#	$TalkButton.visible = unique_dict.has(active_person.get_stat('unique'))
#	$RemoveButton.visible = !active_person.is_master()
#	if char_module_state == "siblings" or char_module_state == "skills":
#		$TalkButton.hide()
#		$RemoveButton.hide()



func set_state(state):
	if state == char_module_state:
		gui_controller.windows_opened.clear()
		char_module_state = "default"
	else:
		char_module_state = state
	match_state()

func match_state():
#	var tooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP)
#	globals.disconnect_text_tooltip(tooltip.parentnode)
#	tooltip.turnoff()
#	tooltip.hide()
	$CloseButton.visible = !ClassesModule.get_node("ClassPanel").is_visible_in_tree() #currently this is not required at all - due to similar effect of both closebuttons
#	for b in SummaryModule.get_node("GridContainer").get_children():
#		b.set_pressed(false)
	match char_module_state:
		"default":
			#gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
			#gui_controller.inventory.hide()
	
			DetailsModule.hide()
			ClassesModule.hide()
			SlaveSiblingsModule.hide()
			BodyModule.show()
			SlaveInfo.show()
			#$TalkButton.show()
#			$SlaveBodyModule/Body.show()
			$SlaveBodyModule.body_show(true)
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
#			ClassesModule.open(active_person)
#			$SlaveBodyModule/Body.hide()
			$SlaveBodyModule.body_show(false)
			$SlaveBodyModule/buffscontainer.hide()
			#SummaryModule.get_node("GridContainer/SkillsButton").set_pressed(true)
			#BodyModule.hide()
		"details":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(DetailsModule)
			ClassesModule.hide()
			SlaveSiblingsModule.hide()
			DetailsModule.unpress_buttons()
			DetailsModule.custom_description_open()
			DetailsModule.show()
			#SummaryModule.get_node("GridContainer/DetailsButton").set_pressed(true)
			#$TalkButton.show()
#			$SlaveBodyModule/Body.show()
			$SlaveBodyModule.body_show(true)
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
			#$TalkButton.hide()
			$SlaveBodyModule/buffscontainer.show()
#			$SlaveBodyModule/Body.hide()
			$SlaveBodyModule.body_show(true)
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 0
			SlaveInfo.hide()
			DetailsModule.hide()
			ClassesModule.hide()
			#SummaryModule.get_node("GridContainer/SiblingsButton").set_pressed(true)
			SlaveSiblingsModule.show()
#			SlaveSiblingsModule.DietModule.open_diet_window()
			SlaveSiblingsModule.update()
			#BodyModule.hide()
	
	update()


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
			{
				code = 'zephyra_quest_1', 
				reqs = [
					{type = 'decision', value = 'mayor_election_finished', check = true},
					{type = 'dialogue_seen', check = false, value = 'ZEPHYRA_QUEST_2'}
					]
			},
			{code = 'zephyra_dialogue_start', reqs = []}
		]
	},
	
	anastasia = {
		code = 'anastasia', 
		scenes = [
			{
				code = 'ana_travel_initiate', 
				reqs = [
					{type = "active_quest_stage", value = "anastasia_quest_2", stage = "stage9"}
					]
			},
			{
				code = 'anastasia_return_1', 
				reqs = [
					{type = "active_quest_stage", value = "anastasia_quest", stage = "stage6"},
					{type = 'decision', value = 'ana_liora_lie', check = true},
					]
			},
			{
				code = 'anastasia_return_3', 
				reqs = [
					{type = "active_quest_stage", value = "anastasia_quest", stage = "stage6"},
					{type = 'decision', value = 'ana_liora_lie', check = false},
					]
			},
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
	
	lilith = {
		code = 'lilith', 
		scenes = [
			{code = 'lilith_dialogue_start', reqs = []}
		]
	},
	
	
	jean = {
		code = 'jean', 
		scenes = [
			{code = 'jean_dialogue_start', reqs = []}
		]
	},
	
	amelia = {
		code = 'amelia',
		scenes = [
			{code = 'amelia_final_1', reqs = [{type = 'dialogue_seen', check = false, value = 'AMELIA_FINAL_1'},{type = "active_quest_stage", value = "amelia_main_quest", stage = "stage11"}]}, 
			{code = 'amelia_sex_1', reqs = [{type = 'dialogue_seen', check = false, value = 'AMELIA_SEX_1'},{type = 'quest_completed', name = 'amelia_main_quest', check = true}]}, 
			{code = 'amelia_dialogue_start', reqs = []}, #needs adding  
		]
	},
	
	kuro = {
		code = 'kuro',
		scenes = [
			{code = 'kuro3_init_3', reqs = [
				{type = "active_quest_stage", value = "kuro_quest_3", stage = "craft"},
				{type = 'has_material', operant = 'eq', value = 1, material = 'vesperine_cage'}
			]},
			{code = 'kuro_tome_sex', reqs = [{type = "active_quest_stage", value = "kuro_tome_quest", stage = "talk"}]},
			{code = 'kuro_after_tome', reqs = [
				{type = "quest_completed", check = true, name = "kuro_tome_quest"},
				{type = "event_seen", check = false, value = "kuro_after_tome"}
			]},
			{code = 'kuro_dialogue_start', reqs = []}
		]
	},
}


#func _on_Button_pressed():
		# pass


func open_gear():
	self.hide()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.inventory, 0.3)
	gui_controller.inventory.show()
	#gui_controller.inventory.get_node("GridContainer/GearButton").set_pressed(true)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(active_person)
	gui_controller.emit_signal("screen_changed")



