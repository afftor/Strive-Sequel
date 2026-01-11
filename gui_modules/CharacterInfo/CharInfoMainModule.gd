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



