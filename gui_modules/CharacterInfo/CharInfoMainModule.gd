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
	input_handler.register_btn_source('char_close_button', self, 'tut_get_close_button')

func tut_get_close_button():
	return $CloseButton


func remove():
	#gui_controller.close_scene(self)
	input_handler.active_character = active_person
	input_handler.interactive_message('slave_remove')

var sex_training_progress = {
	novice = 0,
	skilled = 50,
	mastered = 100,
}

var mastery_required = {
	penetration = [["missionary", "missionaryanal"], ["doggy", "doggyanal"], ["lotus", "lotusanal"], ["revlotus", "revlotusanal"], ["ontop", "ontopanal"]],
	pussy = [["missionary"], ["doggy"], ["lotus"], ["revlotus"], ["ontop"]],
	anal = [["missionaryanal"], ["doggyanal"], ["lotusanal"], ["revlotusanal"], ["ontopanal"]],
	petting = [["caress"], ["fondletits"], ["titjob"], ["handjob"], ["massagefoot"], ["footjob"], ["fingering", "assfingering"], ["fisting", "analfisting"]],
	oral = [["kiss"], ["sucknipples"], ["rimjob"], ["cunnilingus", "blowjob"]],
	tail = [["tailjob"], ["inserttailv"], ["inserttaila"]],
}

var mastery_action_keys = {
	missionary = "SEXACTION_MISSIONARY",
	missionaryanal = "SEXACTION_MISSIONARY_ANAL",
	doggy = "SEXACTION_DOGGY_STYLE",
	doggyanal = "SEXACTION_DOGGY_ANAL",
	lotus = "SEXACTION_LOTUS",
	lotusanal = "SEXACTION_LOTUS_ANAL",
	revlotus = "SEXACTION_REVLOTUS",
	revlotusanal = "SEXACTION_REVLOTUSANAL",
	ontop = "SEXACTION_ON_TOP",
	ontopanal = "SEXACTION_ON_TOP_ANAL",
	inserttailv = "SEXACTION_INSERT_TAIL_PUSSY",
	inserttaila = "SEXACTION_INSERT_TAIL_ASS",
	caress = "SEXACTION_CARESS",
	assfingering = "SEXACTION_ASS_FINGERING",
	fingering = "SEXACTION_FINGERING",
	fondletits = "SEXACTION_FONDLE_CHEST",
	footjob = "SEXACTION_FOOTJOB",
	titjob = "SEXACTION_TITJOB",
	handjob = "SEXACTION_HANDJOB",
	frottage = "SEXACTION_FROTTAGE",
	analfisting = "SEXACTION_ANAL_FISTING",
	fisting = "SEXACTION_FISTING",
	massagefoot = "SEXACTION_MASSAGE_WITH_FOOT",
	rimjob = "SEXACTION_RIMJOB",
	cunnilingus = "SEXACTION_CUNNILINGUS",
	blowjob = "SEXACTION_BLOWJOB",
	kiss = "SEXACTION_KISS",
	sucknipples = "SEXACTION_NIPPLE_SUCKING",
	tailjob = "SEXACTION_TAILJOB",
}

func get_sex_training_label(state):
	match state:
		'novice': return tr("SEX_TRAINING_LEVEL_NOVICE")
		'skilled': return tr("SEX_TRAINING_LEVEL_SKILLED")
		'mastered': return tr("SEX_TRAINING_LEVEL_MASTERED")
	return str(state).capitalize()

func update():
	if !is_visible_in_tree():
		return
	active_person = input_handler.interacted_character
	if active_person == null:
		return
	active_person.update_prt()
	SummaryModule.show_summary()
	SummaryModule.update_buttons()
	SlaveInfo.update()
	BodyModule.update()
	ClassesModule.update()
	SlaveSiblingsModule.update()
	
	if active_person != null:
		input_handler.ClearContainer($SlaveInfoModule/SexSkillsContainer/VBoxContainer)
		var s_skills = active_person.get_sex_training()
		for ii in s_skills:
			var state = s_skills[ii]
			if ii == 'sex_training_tail' and state == 'novice':
				continue
			if ii == 'sex_training_penetration' and state == 'novice' and active_person.get_stat('penis_size') == '':
				continue
			if ii == 'sex_training_pussy' and state == 'novice' and active_person.get_stat('sex') == 'male':
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($SlaveInfoModule/SexSkillsContainer/VBoxContainer)
			var state_label = get_sex_training_label(state)
			newbutton.get_node("Label").text = tr("CHARINFO_" + ii.to_upper())
			newbutton.get_node("ProgressBar").value = sex_training_progress.get(state, 0)
			newbutton.get_node("ProgressBar/Label").text = state_label
			var tooltip_text = active_person.translate(tr("STAT" + ii.to_upper() + "DESCRIPT")) + "\n" + tr("CUR_LEVEL_LABEL") + ": " + state_label
			var skill_name = ii.replace('sex_training_', '')
			if state == 'novice':
				tooltip_text += "\n\n" + tr("MASTERY_HINT_NOVICE")
			if state == 'skilled' and mastery_required.has(skill_name):
				var progress = active_person.statlist.sex_mastery_progress.get(skill_name, [])
				tooltip_text += "\n\n" + tr("MASTERY_HINT_SKILLED")
				for group in mastery_required[skill_name]:
					var labels = []
					var group_done = false
					for action in group:
						labels.append(tr(mastery_action_keys.get(action, "SEXACTION_" + action.to_upper())))
						if action in progress:
							group_done = true
					var group_label = PoolStringArray(labels).join(" / ")
					if group_done:
						tooltip_text += "\n{color=green|" + group_label + "}"
					else:
						tooltip_text += "\n{color=gray|" + group_label + "}"
			globals.connecttexttooltip(newbutton, tooltip_text)
		$SlaveInfoModule/SexstaminaLabel.text = tr("STATSEX_STAMINA") + ": " + str(active_person.get_stat('sex_stamina'))
		globals.connecttexttooltip($SlaveInfoModule/SexstaminaLabel, "[center]" + tr("STATSEX_STAMINA") + "[/center]\n" + tr("STATSEX_STAMINADESCRIPT"))
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


