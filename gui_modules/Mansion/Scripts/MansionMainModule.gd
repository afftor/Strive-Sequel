extends Control

# VARIABLES
# Modules
onready var SlaveListModule = $MansionSlaveListModule
onready var RoomsModule = $MansionRoomsModule
onready var SkillModule = $MansionSkillsModule
onready var SlaveModule = $MansionSlaveModule
onready var TaskModule = $MansionTaskInfoModule
onready var MenuModule = $MansionBottomLeftModule
#onready var UpgradesModule = $MansionUpgradesModule
#onready var NavModule = $NavigationModule
onready var CraftModule = $MansionCraftModule
onready var JobModule = $MansionJobModule2
onready var SexSelect = $SexSelectMenu
onready var Journal = $MansionJournalModule
onready var TurnProductionOverlay = $TurnProductionOverlay
onready var LocalTasksButton = $LocalTasksButton
onready var LocalTasksShimmer = $LocalTasksButton/QuestAttentionShimmer
#How fast the sheen sweeps and how long it rests between passes live in the shader itself -
#see quest_attention_shimmer.shader. Nothing here drives it; this only turns it on and off.
#Assigned in code rather than left to the scene: an open scene in the Godot editor is written
#back from memory when it saves, which quietly undoes edits made to the .tscn on disk. The
#shader lives in its own file, so tuning the sheen always takes.
const SHIMMER_SHADER = preload("res://gui_modules/Mansion/Modules/quest_attention_shimmer.shader")
onready var submodules = []

export var test_mode = false
export(bool) var show_legacy_character_panels = false


signal tut_option_selected
signal initialization_finished

#Skills
var skill_source
var skill_target
var chars_for_skill = []

# Travels
var travels_defaults = {code = 'default'}
var selected_travel_characters = []
var is_travel_selected
var selected_destination
var selected_location


# Upgrades
var select_chars_mode = false
var selected_upgrade
var chars_for_upgrades = []

# Craft
var craft_state = "default"

# Sex
var sex_participants = []


onready var active_person = ResourceScripts.game_party.get_master()
var hovered_person = null
var is_entered = false


var mansion_state = "" setget mansion_state_set
var mansion_prev_state


var prev_selected_travel

var always_show = [
	"BGHolder",
	#the floorplan is the mansion's floor, not a panel opened over it - it lies under
	#everything else and stays there. Its own input asks whether anything is drawn on top of
	#the cursor before it claims the wheel, so it cannot steal scrolling from the panels above.
	"MansionRoomsModule",
	"LocalTasksButton",
	"TestButton",
	"MansionTaskInfoModule",
	"MansionClockModule",
	"MansionBottomLeftModule",
	"MansionSlaveModule",
	"MansionSlaveListModule",
	"MansionLogModule",
	"NavigationModule",
	"TurnProductionOverlay",
	"map_test"
]

const LEGACY_CHARACTER_PANELS = [
	"MansionSkillsModule",
	"MansionSlaveModule",
]

const TURN_PRODUCT_FLY_TIME = 0.46
const TURN_PRODUCT_STAGGER = 0.035
const TURN_PRODUCT_MAX_STAGGER = 0.35

var newgame_bonuses

var in_test_mode = false
var loading_progress_node
var loading_progress_range = [70.0, 90.0]
var local_tasks_attention = false

func _ready():
	if !show_legacy_character_panels:
		$MansionSkillsModule.hide()
		$MansionSlaveModule.hide()
#	input_handler.CurrentScene = self
	if test_mode && OS.has_feature('editor'):
		modding_core.handle_test_mode()
		test_mode()
		in_test_mode = true
		mansion_state_set("default")
	add_season_events()
	var is_new_game = false
#	globals.connect('slave_arrived', $NavigationModule, "build_accessible_locations")
#	globals.connect('slave_departed', $NavigationModule, "build_accessible_locations")
	if globals.start_new_game == true:
		if gui_controller.clock != null:
			gui_controller.clock.hide()
		globals.start_new_game = false
		self.visible = false
		is_new_game = true
		var newgame_node = Node.new()
#		add_child(newgame_node)
		newgame_node.set_script(ResourceScripts.scriptdict.gamestart)
		newgame_node.start()
		input_handler.GameStartNode = newgame_node
		yield(input_handler, "StartingSequenceComplete")
		var got_back = input_handler.GameStartNode.got_back
		input_handler.GameStartNode.queue_free()
		
		if got_back: return
		
		show()
		input_handler.ActivateTutorial("TUTORIALLIST1")
		globals.apply_starting_preset()
		if newgame_bonuses != null:#can be set externally
			input_handler.achievements.prepare_bonuses(newgame_bonuses)
			newgame_bonuses = null
		
		ResourceScripts.game_globals.reset_limits()
		#the onready init ran before the starting sequence, when the party was still empty
		active_person = ResourceScripts.game_party.get_master()
		SlaveListModule.rebuild()
		#The floorplan's own _ready ran before any of this, against an empty party - and the
		#starting preset seats nobody, because it does not add its people through add_slave.
		#This is the first moment the household is final, so it is where everyone gets a bed.
		ResourceScripts.game_res.ensure_mansion_layout()
		RoomsModule.refresh()
#		SlaveListModule.build_locations_list()
		#a window closing during the starting sequence can already have pushed the mansion
		#into 'default' (gui_controller.close_window does), and the setter bails out on an
		#unchanged state - so lay the panels out directly in that case
		if mansion_state == "default":
			match_state()
		else:
			mansion_state_set("default")
#		remove_child(newgame_node)
	
	input_handler.CurrentScreen = 'mansion'
	gui_controller.mansion = self
	gui_controller.current_screen = self
	yield(get_tree(),'idle_frame')
	gui_controller.clock = input_handler.get_spec_node(input_handler.NODE_CLOCK)
	if is_instance_valid(loading_progress_node):
		gui_controller.clock.hide()
	else:
		gui_controller.clock.show()
	gui_controller.clock.update_labels()
	$TutorialButton.connect('pressed', self, 'show_tutorial')
	var sheen = ShaderMaterial.new()
	sheen.shader = SHIMMER_SHADER
	LocalTasksShimmer.material = sheen
	LocalTasksButton.text = tr("MANSIONVIEW_LOCALTASKS")
	LocalTasksButton.connect('pressed', self, 'toggle_local_tasks')
	RoomsModule.connect('place_changed', self, 'sync_local_tasks_button')
	sync_local_tasks_button(RoomsModule.place)
	globals.connecttexttooltip(LocalTasksButton, tr("MANSIONVIEW_LOCALTASKSHINT"))
	hotkeys.connect("bindings_changed", self, "build_tutorial_tooltip")
	build_tutorial_tooltip()
#	$tutorialpanel/Button.connect('pressed',$tutorialpanel,'hide')
	slave_list_manager()
	globals.mansion_activity_log_node = $MansionLogModule
	input_handler.SetMusicRandom("mansion")
	SlaveListModule.update_dislocations()
	if is_instance_valid(loading_progress_node):
		yield(SlaveListModule.rebuild_for_loading(
			loading_progress_node,
			loading_progress_range[0],
			loading_progress_range[1]
		), "completed")
		loading_progress_node = null
	else:
		SlaveListModule.rebuild()
	#same reason on both paths: this screen is built once per session, so its floorplan was
	#laid out against whatever the layout looked like before the save was applied
	ResourceScripts.game_res.ensure_mansion_layout()
	RoomsModule.refresh()
#	SlaveListModule.build_locations_list()
	if !ResourceScripts.game_progress.intro_tutorial_seen:
		$TutorialIntro.show()
	set_active_person(ResourceScripts.game_party.get_master())
	$NavigationModule.tut_register_aliron_btn()
	Journal.tut_register_minor()
	Journal.tut_register_first_quest()
	Journal.tut_register_complete()
	emit_signal("initialization_finished")


#Work assignment has no global changed signal: the embedded task view refreshes itself after
#a drop. This tiny fallback only walks the short quest-id array, while normal mansion refreshes
#also call the same edge-triggered update directly.
func _process(delta):
	refresh_local_tasks_attention()
	if !local_tasks_attention:
		return
	#the sweep keeps its own time inside the shader now, so there is nothing to advance here


#Only quests waiting at the estate. The button opens the estate and nothing else - it calls
#RoomsModule.set_local_tasks(true), which pins the screen to the mansion - and that screen
#lists a special task only when its location matches. A quest in some other town is reachable
#from the bar along the top once the screen is open, but lighting the button for it would
#promise something the first click does not deliver.
func has_unstaffed_quest_task():
	return ResourceScripts.game_res.unstaffed_quest_locations().has(
		RoomsModule.LocationTasks.MANSION_CODE)


func refresh_local_tasks_attention():
	var needs_attention = has_unstaffed_quest_task()
	if needs_attention == local_tasks_attention:
		return
	local_tasks_attention = needs_attention
	LocalTasksShimmer.visible = needs_attention


func loading_screen_finished():
	if is_instance_valid(gui_controller.clock):
		gui_controller.clock.show()






func add_season_events():
#	if test_mode == true:
#		return
	var date = OS.get_date().day + OS.get_date().month * 30
	if OS.get_date().month == 1:
		date = OS.get_date().day + 13 * 30
	for i in scenedata.season_events_range.values():
		
		# removing all season events from timed_events
		var to_rem = []
		for e in ResourceScripts.game_progress.stored_events.timed_events:
			if e.code is String and e.code == i.event:
				to_rem.append(e)
		for r in to_rem:
			ResourceScripts.game_progress.stored_events.timed_events.erase(r)
		
		if !ResourceScripts.game_progress.seen_events.has(i.event) && date >= i.start[0] + i.start[1]*30 && date <= i.end[0] + i.end[1]*30:
			globals.common_effects([{code = 'add_timed_event', value = i.event, args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])

func build_tutorial_tooltip():
	globals.connecttexttooltip($TutorialButton, hotkeys.get_tooltip_text("TUTORIALS", 'mansion_tutorial'))


func show_tutorial():
	if gui_controller.mansion_tutorial_panel == null:
		gui_controller.mansion_tutorial_panel = input_handler.get_spec_node(input_handler.NODE_TUTORIAL_PANEL)
	if !gui_controller.windows_opened.has(gui_controller.mansion_tutorial_panel):
		gui_controller.windows_opened.append(gui_controller.mansion_tutorial_panel)
	gui_controller.mansion_tutorial_panel.open()
	gui_controller.mansion_tutorial_panel.raise()

func show_menu():
	gui_controller.game_menu = input_handler.get_spec_node(input_handler.NODE_GAMEMENU)
	gui_controller.game_menu.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.game_menu
	gui_controller.update_modules()


func set_active_person(person):
	input_handler.interacted_character = person
	active_person = input_handler.interacted_character
	SlaveListModule.prev_selected_location = SlaveListModule.selected_location
	slave_list_manager()


func hide():
	.hide()
	mansion_state_set("hidden")


func mansion_state_set(state):
	# input_handler.CurrentScene = self
	if state == mansion_state:
		return
	if mansion_state != 'hidden': mansion_prev_state = mansion_state
	mansion_state = state
	if mansion_state == 'hidden': return
	#Every state but the default one asks the player to pick somebody out of the list, and a
	#list folded down to its title bar has nobody to pick. Only the default view shares its
	#space with the floorplan below it.
	if SlaveListModule != null:
		SlaveListModule.apply_state_fold(mansion_state == "default")
	match_state()
	slave_list_manager()
	get_node("TutorialButton").show()

func reset_vars():
#	input_handler.interacted_character = null
#	SlaveListModule.active_person = null
#	SlaveModule.person = null
	if mansion_state != mansion_prev_state:
		select_chars_mode = false
		selected_upgrade = null
		chars_for_upgrades.clear()
		submodules.clear()
	if active_person == null or !active_person.is_active:
		active_person = ResourceScripts.game_party.get_master()
	if active_person == null or !active_person.is_active:
		active_person = null
	Journal.hide()

# Handles state visibility
func handle_test():
	for nd in get_tree().get_nodes_in_group('test'):
		nd.visible = in_test_mode
	for nd in get_tree().get_nodes_in_group('test_obsolete'):
		nd.visible = false


func match_state():
	refresh_local_tasks_attention()
	handle_test()
	if gui_controller.clock != null and visible and mansion_state != 'craft':
		gui_controller.clock.show()
		gui_controller.clock.raise()
	gui_controller.nav_panel = $NavigationModule
	gui_controller.nav_panel.build_accessible_locations()
	Journal.visible = MenuModule.get_node("VBoxContainer/Journal").is_pressed()
	for node in get_children():
		if node.get_class() == "Tween":
			continue
		if !show_legacy_character_panels and node.name in LEGACY_CHARACTER_PANELS:
			node.hide()
			continue
		if node.name.findn(mansion_state) == -1 and ! node.name in always_show:
			node.hide()
	var menu_buttons = MenuModule.get_node("VBoxContainer")
	for button in menu_buttons.get_children():
		button.pressed = false
	match mansion_state:
		"default":
			reset_vars()
			SlaveListModule.show()
			SlaveListModule.mode = 'default'
			if show_legacy_character_panels:
				$MansionSkillsModule.show()
			if active_person == null:
				return
			if mansion_state != mansion_prev_state && mansion_prev_state != "skill":
				if show_legacy_character_panels:
					ResourceScripts.core_animations.UnfadeAnimation($MansionSkillsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
				$MansionJobModule2.close_job_pannel()
				
				
		"skill":
			$MansionSlaveListModule.show()
			$MansionSlaveListModule.rebuild()
			if mansion_state != mansion_prev_state:
				if show_legacy_character_panels:
					ResourceScripts.core_animations.UnfadeAnimation($MansionSkillsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
				$MansionJobModule2.close_job_pannel()
		"travels":
			$map.open()
		"occupation":
			$MansionSlaveListModule.rebuild()
			if mansion_state != mansion_prev_state:
				$MansionJobModule2.show()
				$MansionJobModule2.rebuild()
				ResourceScripts.core_animations.UnfadeAnimation($MansionJobModule2, 0.3)
				gui_controller.clock.hide()
				ResourceScripts.core_animations.FadeAnimation(gui_controller.clock, 0.3)
		"char_info":
			open_char_info()
		"craft":
			CraftModule.open()
			CraftModule.get_node("MaterialSetupPanel").hide()
			CraftModule.update()
			# CraftModule.get_node("filter").hide()
			ResourceScripts.core_animations.UnfadeAnimation(CraftModule, 0.3)
			ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
			menu_buttons.get_node("CraftButton").pressed = true
		"sex":
			SlaveListModule.show()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation(SexSelect, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
			SexSelect.show()
			sex_handler()
			menu_buttons.get_node("SexButton").pressed = true
	
	rebuild_task_info()


func open_char_info():
	gui_controller.slavepanel = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	gui_controller.slavepanel.set_state("default")
	gui_controller.slavepanel.SummaryModule.show_summary()
	gui_controller.slavepanel.show()
	gui_controller.previous_screen = gui_controller.mansion
	gui_controller.previous_screen.hide()
	gui_controller.current_screen = gui_controller.slavepanel
	gui_controller.close_all_closeable_windows()
	gui_controller.slavepanel.update()
	gui_controller.emit_signal("screen_changed")
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.slavepanel, 0.3)

func rebuild_mansion():
	refresh_local_tasks_attention()
	$MansionSlaveListModule.update()
	RoomsModule.queue_refresh()
	if show_legacy_character_panels:
		$MansionSkillsModule.build_skill_panel()
	CraftModule.rebuild_scheldue()
	#UpgradesModule.open_queue()
	update_legacy_slave_panel()
	$TutorialButton.show()

#same work as rebuild_mansion, but split over frames so a turn does not stall the game.
#day_extras covers what advance_day used to rebuild on a day change
func rebuild_after_turn(day_extras):
	yield(get_tree(), 'idle_frame') #always a coroutine, callers yield on 'completed'
	yield(SlaveListModule.refresh_after_turn(true), 'completed')
	yield(get_tree(), 'idle_frame')
	#the floorplan gets its own slice rather than riding on the list's
	rooms_after_turn()
	yield(get_tree(), 'idle_frame')
	if show_legacy_character_panels:
		$MansionSkillsModule.build_skill_panel()
	if !day_extras:
		return
	yield(get_tree(), 'idle_frame')
	CraftModule.rebuild_scheldue()
	yield(get_tree(), 'idle_frame')
	update_legacy_slave_panel()
	$TutorialButton.show()


#What a passed turn does to the floorplan. A turn advances builds, finishes tasks and can
#leave somebody without a bed, so it is redrawn - and it comes back to work while it is at it,
#because beds are arranged in a sitting and then done with, and a new day is about who is
#working. Its own function so the self test can ask for it without sitting through the whole
#staggered rebuild around it.
#The estate has two faces: the floorplan is the building, local tasks is the work the estate
#itself offers. Same place, two things to arrange, so this swaps what the backdrop is drawing
#rather than opening a screen over it - the slave list and the strip of portraits stay put,
#which is what people are dragged onto the work from.
func toggle_local_tasks():
	if !RoomsModule.in_mansion():
		sync_local_tasks_button(RoomsModule.place)
		return
	#The local tasks screen fills the space the list would occupy, so opening it with the
	#list standing up leaves the two overlapping. Folding is remembered as the player's own
	#choice, so the list stays down until they put it back up themselves.
	if SlaveListModule != null and SlaveListModule.list_fold_state != SlaveListModule.FOLD_FOLDED:
		SlaveListModule.set_slave_list_fold(SlaveListModule.FOLD_FOLDED, true, true)
	RoomsModule.set_local_tasks(LocalTasksButton.pressed)


func sync_local_tasks_button(_place = null):
	var at_mansion = RoomsModule.in_mansion()
	LocalTasksButton.visible = at_mansion
	LocalTasksButton.pressed = RoomsModule.local_tasks if at_mansion else false
	refresh_local_tasks_attention()


func rooms_after_turn():
	RoomsModule.mode = 'work'
	RoomsModule.refresh()
	refresh_local_tasks_attention()


func _turn_product_texture(value):
	if value is String:
		return load(value)
	return value


#Capture coordinates before the simulation. Completed tasks can remove and rebuild their
#rows during managed tick yields; retaining positions keeps every icon aimed at its own row.
func capture_turn_production_layout():
	var layout = {sources = {}, targets = {}}
	if !is_visible_in_tree() or !TaskModule.is_visible_in_tree():
		return layout
	layout.targets = TaskModule.get_turn_animation_targets()
	for person_id in ResourceScripts.game_party.character_order:
		var source = SlaveListModule.get_turn_animation_source(person_id)
		if source != null:
			layout.sources[str(person_id)] = source.get_global_rect().get_center()
	return layout


func play_turn_production_animations(layout, production_events):
	#Always yield once so ClockModule can safely await this even when no route is visible.
	yield(get_tree(), "idle_frame")
	if production_events.empty() or !is_visible_in_tree():
		return
	var routes = []
	for event in production_events:
		var person_id = str(event.person_id)
		var task_id = str(event.task_id)
		if !layout.sources.has(person_id) or !layout.targets.has(task_id):
			continue
		var texture = _turn_product_texture(event.texture)
		if texture == null:
			continue
		routes.append({
			texture = texture,
			start = layout.sources[person_id],
			target = layout.targets[task_id],
		})
	if routes.empty():
		return
	input_handler.ClearContainer(TurnProductionOverlay)
	TurnProductionOverlay.raise()
	var inverse_canvas = TurnProductionOverlay.get_global_transform_with_canvas().affine_inverse()
	var max_delay = 0.0
	var index = 0
	for route in routes:
		if route.texture == null:
			continue
		var fly_icon = input_handler.DuplicateContainerTemplate(TurnProductionOverlay)
		fly_icon.get_node("Icon").texture = route.texture
		var half_size = fly_icon.rect_size * 0.5
		var start_position = inverse_canvas.xform(route.start) - half_size
		var target_position = inverse_canvas.xform(route.target) - half_size
		var delay = min(index * TURN_PRODUCT_STAGGER, TURN_PRODUCT_MAX_STAGGER)
		max_delay = max(max_delay, delay)
		fly_icon.rect_position = start_position
		fly_icon.rect_scale = Vector2(0.72, 0.72)
		fly_icon.modulate = Color(1, 1, 1, 0)
		var tween = fly_icon.get_node("Tween")
		tween.interpolate_property(fly_icon, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1),
			0.08, Tween.TRANS_QUAD, Tween.EASE_OUT, delay)
		tween.interpolate_property(fly_icon, "rect_position", start_position, target_position,
			TURN_PRODUCT_FLY_TIME, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, delay)
		tween.interpolate_property(fly_icon, "rect_scale", Vector2(0.72, 0.72), Vector2(1.08, 1.08),
			TURN_PRODUCT_FLY_TIME * 0.55, Tween.TRANS_BACK, Tween.EASE_OUT, delay)
		tween.interpolate_property(fly_icon, "rect_scale", Vector2(1.08, 1.08), Vector2(0.45, 0.45),
			TURN_PRODUCT_FLY_TIME * 0.45, Tween.TRANS_QUAD, Tween.EASE_IN, delay + TURN_PRODUCT_FLY_TIME * 0.55)
		tween.interpolate_property(fly_icon, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0),
			0.12, Tween.TRANS_QUAD, Tween.EASE_IN, delay + TURN_PRODUCT_FLY_TIME - 0.12)
		tween.interpolate_callback(fly_icon, delay + TURN_PRODUCT_FLY_TIME, "hide")
		tween.start()
		index += 1
	if index == 0:
		return
	yield(get_tree().create_timer(max_delay + TURN_PRODUCT_FLY_TIME + 0.02), "timeout")
	input_handler.ClearContainer(TurnProductionOverlay)

func try_rebuild_slave_list():
	if gui_controller.current_screen != self: return
	SlaveListModule.rebuild()

func rebuild_task_info():
	var char_on_quest = false
	for ch in ResourceScripts.game_party.characters.values():
		if ch.is_on_quest():
			char_on_quest = true
			break
	if ResourceScripts.game_res.tasks_progresses.empty() && !char_on_quest:
		TaskModule.visible = false
		if TaskModule.is_visible():
			ResourceScripts.core_animations.FadeAnimation(TaskModule, 0.3)
		return
	for id in ResourceScripts.game_res.tasks_progresses:
		var i = ResourceScripts.game_res.tasks_progresses[id]
		if !i.has('workers'):
			continue
		if !i.workers.empty() || char_on_quest:
			if !TaskModule.is_visible():
				ResourceScripts.core_animations.UnfadeAnimation(TaskModule, 0.3)
			TaskModule.visible = true
			break
		else:
			TaskModule.visible = false
			if TaskModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(TaskModule, 0.3)
	TaskModule.show_task_info()

### State Managers ###
# Action Handlers for Modules
func sex_handler():
	if mansion_prev_state != mansion_state:
		active_person = null
		sex_participants.clear()
		mansion_prev_state = mansion_state


func upgrades_manager():
	SlaveListModule.rebuild()

func skill_manager():
	mansion_state = "skill"
	SlaveListModule.rebuild()

func slave_list_manager():
	refresh_local_tasks_attention()
	match mansion_state:
		'default':
			if mansion_prev_state == "skill" || mansion_prev_state == "sex":
				mansion_prev_state = null
				active_person = skill_source
				hovered_person = null
				SlaveListModule.rebuild()
			else:
				skill_source = active_person
			SlaveListModule.update_buttons()
			if active_person == null:
				return
			if show_legacy_character_panels:
				SkillModule.build_skill_panel()
			update_legacy_slave_panel()
		'skill':
			if active_person.is_on_quest():
				return
			if active_person in chars_for_skill:
				SkillModule.use_skill(active_person)
			set_active_person(skill_source)
			if show_legacy_character_panels:
				SkillModule.build_skill_panel()
			SlaveListModule.rebuild()
		'travels':
			if is_travel_selected:
				if active_person in selected_travel_characters:
					self.selected_travel_characters.erase(active_person)
				else:
					self.selected_travel_characters.append(active_person)
			#	TravelsModule.update_character_dislocation()
			SlaveListModule.rebuild()
#			TravelsModule.update_buttons()
		'upgrades':
			if !select_chars_mode:
				update_legacy_slave_panel()
				SlaveListModule.rebuild()
				return
			if chars_for_upgrades.has(active_person):
				chars_for_upgrades.erase(active_person)
			else:
				chars_for_upgrades.append(active_person)
			SlaveListModule.rebuild()
			#UpgradesModule.open_queue()
		'occupation':
			pass
			#$MansionSlaveListModule.rebuild()
#			$MansionJobModule.open_jobs_window()
		'sex':
			if !sex_participants.has(active_person) && active_person != null:
				sex_participants.append(active_person)
			else:
				sex_participants.erase(active_person)
			SlaveListModule.rebuild()
			update_sex_date_buttons()
	update_legacy_slave_panel()


func update_legacy_slave_panel():
	if show_legacy_character_panels:
		SlaveModule.show_slave_info()

func update_sex_date_buttons():
	SexSelect.get_node("SexButton").hint_tooltip = ""
	if ResourceScripts.game_globals.unlimited_date_sex:
		if sex_participants.has(ResourceScripts.game_party.get_master()):
			SexSelect.get_node("DateButton").disabled = true
		else:
			SexSelect.get_node("DateButton").disabled = false
		SexSelect.get_node("SexButton").disabled = false
	if ResourceScripts.game_globals.weekly_sex_left > 0:
		SexSelect.get_node("SexButton").disabled = sex_participants.size() < 2 || sex_participants.size() > SlaveListModule.calculate_sex_limits()
	else:
		SexSelect.get_node("SexButton").disabled = true
	
	for i in sex_participants:
		if i.has_status("no_sex"):
			SexSelect.get_node("SexButton").disabled = true
			SexSelect.get_node("SexButton").hint_tooltip = "One of unique characters has not proceeded their questline yet"
	
	if sex_participants.size() > 2 or sex_participants.size() == 0: 
		SexSelect.get_node("DateButton").disabled = true
	elif ResourceScripts.game_globals.weekly_dates_left <= 0: 
		SexSelect.get_node("DateButton").disabled = true
	elif ResourceScripts.game_party.get_master().travel.location != ResourceScripts.game_world.mansion_location: 
		SexSelect.get_node("DateButton").disabled = true
	elif sex_participants.size() > 1 and !sex_participants.has(ResourceScripts.game_party.get_master()):
		SexSelect.get_node("DateButton").disabled = true
	elif sex_participants.size() == 1 and sex_participants.has(ResourceScripts.game_party.get_master()):
		SexSelect.get_node("DateButton").disabled = true
	else:
		SexSelect.get_node("DateButton").disabled = false
	
	for i in sex_participants:
		if i.is_master(): continue
		if i.has_status("no_date") or (i.get_stat('slave_class') in ['servant', 'servant_notax', 'heir'] and !i.has_status("relation")) or (i.tags.has("no_date_day") and !ResourceScripts.game_globals.unlimited_date_sex):
			SexSelect.get_node("DateButton").disabled = true

func set_hovered_person(node, person):
	hovered_person = person
	update_legacy_slave_panel()

func remove_hovered_person():
#	if SlaveListModule.is_in_area():
#		return
	hovered_person = null
	update_legacy_slave_panel()


func _on_TestButton_pressed():
	# print(ResourceScripts.game_progress.seen_dialogues)
	input_handler.PlaySound("avalanche")
	# print(Traitdata.get_tat_list_for_slot("arms"))
#	get_node("DisassembleModule").build_list()
#	get_node("DisassembleModule").show()


func show_map():
	$map.open()


func test_mode():
	input_handler.CurrentScene = self
	gui_controller.mansion = self
	ResourceScripts.game_globals.allow_skip_fights = true
	variables.allow_remote_intereaction = true
	ResourceScripts.game_world.make_world()
	if true:
		ResourceScripts.game_progress.seen_dialogues.append("PRIESTESS_SWORD_TALK_1_1")
		ResourceScripts.game_progress.seen_dialogues.append("ALIRONCHURCHFIRSTCOME")
		ResourceScripts.game_progress.unlocked_classes.append('alchemist')
		ResourceScripts.game_progress.unlocked_classes.append('paladin')
		ResourceScripts.game_progress.unlocked_classes.append('smith')
		var character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Demon', 'male', 'random')
		character.fill_boosters()
		character.unlock_class("master")
		characters_pool.move_to_state(character.id)
		ResourceScripts.game_res.upgrades.alchemy = 3
		ResourceScripts.game_res.upgrades.tailor = 3
		#the old 'rooms' upgrade stood here; test mode wants a few bedrooms standing, not a
		#floor filled edge to edge with them
		ResourceScripts.game_res.ensure_mansion_layout()
		#the master's room already widened, so beds mode opens with the one room whose rule is
		#peculiar - his own bed is held for him however many are added - showing more than one
		ResourceScripts.game_res.max_out_master_room()
		#the estate's gathering used to be a row of 'resource_gather_*' upgrades handed out
		#here; it comes out of the buildings on the grounds now
		ResourceScripts.game_res.build_test_grounds()
		ResourceScripts.game_res.bedrooms_at_least(5)
		ResourceScripts.game_res.upgrades.forge = 3
		ResourceScripts.game_res.upgrades.resting = 1
		ResourceScripts.game_res.upgrades.buildertools = 3
		ResourceScripts.game_res.fix_tax()
		#A quest waiting at the estate with nobody on it, so the Local tasks button has
		#something to call attention to. Shaped like the ones the questlines add through the
		#'add_special_task_for_location' effect - see act4_sebastian_railroad.gd.
		ResourceScripts.game_res.add_special_job({
			location = 'aliron',
			amount = 4,
			name = "MANSIONVIEW_TESTQUEST",
			descript = "MANSIONVIEW_TESTQUESTDESCRIPT",
			max_workers = 2,
			workstat = 'wits',
			icon = "res://assets/Textures_v2/MANSION/quest_task.png",
			args = [],
		})
		#and a second one somewhere that is not home, so the navigation strip has a place to
		#light up. The world is generated fresh here, so the settlement is picked out of it
		#rather than named - codes like 'L3' are not stable between worlds.
		var away = null
		for area in ResourceScripts.game_world.areas.values():
			for location in area.locations.values():
				if location.has('id') and location.type != 'capital':
					away = location.id
					break
			if away != null:
				break
		if away != null:
			ResourceScripts.game_res.add_special_job({
				location = away,
				amount = 8,
				name = "MANSIONVIEW_TESTQUESTAWAY",
				descript = "MANSIONVIEW_TESTQUESTAWAYDESCRIPT",
				max_workers = 2,
				workstat = 'wits',
				icon = "res://assets/Textures_v2/MANSION/quest_task.png",
				args = [],
			})
		else:
			print_debug("test mode: no settlement found to place the away quest in")
		
#		ResourceScripts.game_res.upgrades.tattoo_set = 1
		var item = globals.CreateGearItem("strapon", {})
		globals.AddItemToInventory(item)
		character.equip(item)
		character.set_stat('charm', 100)
		character.set_stat('wits', 100)
	#	character.add_stat('wits', 100)
		character.add_stat('hpmax', 100)
		character.set_stat('eye_color','green')
		character.unlock_class("master")
		character.unlock_class("worker")
		character.unlock_class("templar")
#		character.unlock_class("assassin")
		character.unlock_class("knight")
		character.set_stat('height', 'average')
		character.xp_module.base_exp = 1500
#		character.add_stat('abil_exp', 1500)
		# character.unlock_class("ruler")
		# character.unlock_claiss("watchdog")
		# character.unlock_class("director")
		# character.unlock_class("trainer")
		# character.unlock_class("thief") 
		# character.unlock_class("engineer")
		# character.unlock_class("scholar")
		# character.travel.location = 'L4'
		character.travel.area = 'plains'
#		character.add_stat('resist_normal', 50)
#		character.add_stat('damage_reduction', 50)
		character.add_stat('mastery_point_universal', 90)
		character.set_stat('personality_kind', 100)
		character.set_stat('personality_bold', 50)
		#variables.dungeon_encounter_chance = 1
		var bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'poor', false)
		globals.AddItemToInventory(bow)
		bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'average', false)
		globals.AddItemToInventory(bow)
		bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'legendary', false)
		globals.AddItemToInventory(bow)
		#character.equip(bow)
		character.set_slave_category('master')
		character.statlist.negative_sex_traits = {dislike_missionary = true}
		character.statlist.unlocked_sex_traits = [
			'submissive',
			'pushover',
			'bottle_fairy',
			'dominant',
			'sadist',
			'desired',
			'curious',
			'life_power'
		]
		character.get_random_traits()
		#character.armor = 135
		#character.set_stat('wits', 20)
		character.set_stat('consent', 5)
		character.set_stat('charm_factor', 6)
		character.set_stat('physics_factor', 6)
		character.set_stat('sexuals_factor', 6)
		character.set_stat('authority_factor', 5)
		#character.set_stat('wits_factor', 5)
		character.set_stat('food_love', "meat")
		character.set_stat('lactation', true)
		#character.unlock_class("worker")
#		character.unlock_class("necromancer")
		#character.hp = 1
	#		character.unlock_class("caster")
		for i in Skilldata.Skilllist:
			if Skilldata.Skilllist[i].type != 'social':
				continue
			character.learn_skill(i)
		character.is_players_character = true
#		globals.impregnate(character, character)
		character.set_stat('pregnancy_duration', 2)
		#globals.common_effects([{code = 'unlock_class', name = 'healer', operant = 'eq', value = true}])
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Centaur', 'male', 'random')
		character.fill_boosters()
		character.set_stat('height', 'tiny')
		character.set_stat('skin', 'grey')
		character.add_stat('loyalty', 95)
		character.is_players_character = true
		characters_pool.move_to_state(character.id)
		character.process_training_metrics({physical = 10, magic = 5, positive = 20}) #example of testing
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Orc', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'petite')
		character.is_players_character = true
		character.unlock_class("berserker")
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Elf', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'short')
		character.is_players_character = true
		characters_pool.move_to_state(character.id)
		character.unlock_class("berserker")
		character.unlock_class("druid")
		character.unlock_class("valkyrie")
		character.unlock_class("empyrian")
		character.unlock_class("battlesmith")
		character.unlock_class("dragonknight")
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Goblin', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'average')
		character.set_slave_category('servant')
		character.is_players_character = true
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Goblin', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'tall')
		character.is_players_character = true
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Ratkin', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'towering')
		characters_pool.move_to_state(character.id)
		# character.assign_to_quest_and_make_unavalible()
		#character.unlock_class("attendant")
		character.add_trait('core_trait')
#		character.set_slave_category('heir')
#		character.set_stat('obedience', 0)
		character.set_stat('lust', 50)
		character.set_stat('charm_factor', 2)
		character.unlock_class("apprentice")
		character.get_random_traits()
		character.is_players_character = true
		ResourceScripts.game_globals.date = 7
		ResourceScripts.game_globals.hour = 1
#		character.set_stat('obedience', 50)
		character.unlock_class("apprentice")
		#character.fear = 25
		#character.base_exp = 99
		character.set_stat('charm_factor', 5)
		character.set_stat('physics_factor', 5)
		character.set_stat('wits_factor', 5)
		character.set_stat('sexuals_factor', 5)
		character.set_stat('charm', 100)
		character.set_stat('physics', 100)
		character.set_stat('wits', 100)
		character.set_stat('consent', 5)
		#A body the farm has plenty of use for: milk wants lactation, seed wants the parts, and
		#blood, scales and skin all want a Dragonkin - so one card opens on a full produce list
		#and the growth factor that caps how many at once actually bites.
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Dragonkin', 'female', 'random')
		character.fill_boosters()
		character.set_stat('lactation', true)
		character.set_stat('growth_factor', 5)
		character.is_players_character = true
		characters_pool.move_to_state(character.id)
		#already at work, so the farm's card has somebody to show without one being placed first
		ResourceScripts.game_res.sync_room_tasks()
		var farm_task = ResourceScripts.game_res.first_free_farm_task()
		if farm_task != null:
			character.assign_to_task(farm_task)
		var text = ''
		var base_price = 0
		var output_price = 0
		for i in Items.recipes.values():
			base_price = 0
			output_price = 0
			for k in i.materials:
				base_price += Items.materiallist[k].price * i.materials[k]
			for k in i.items:
				base_price += Items.itemlist[k].price * i.items[k]

			if Items.materiallist.has(i.resultitem):
				output_price = Items.materiallist[i.resultitem].price * i.resultamount
				if base_price != 0:
					text += (
						Items.materiallist[i.resultitem].name
						+ ": Cost - "
						+ str(base_price)
						+ ", Return - "
						+ str(output_price)
						+ "\n"
					)
			else:
				output_price = Items.itemlist[i.resultitem].price * i.resultamount
				if base_price != 0:
					text += (
						Items.itemlist[i.resultitem].name
						+ ": Cost - "
						+ str(base_price)
						+ ", Return - "
						+ str(output_price)
						+ "\n"
					)

#		character.set_stat('loyalty', 100)
#		character.set_stat('authority', 100)
#		character.add_stat('loyalty', 95)
		yield(get_tree(),'idle_frame')
		character.xp_module.base_exp = 1000
#		character.mp = 10

		#character.exhaustion = 1000
		character.add_trait('core_trait')
		character.add_stat('lust', 100)
		character.set_stat("tame_factor", 1)
		#character.unlock_class("dancer")
		character.is_players_character = true
		character.set_stat('tattoo_face', 'ink_makeup')
#		character.affect_char({type = 'set_availability', value = false})

		#common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'remove_trait', value = 'coward'},
		#variables.no_obedience_drain = true
		globals.common_effects(
			[
				{code = 'make_story_character', value = 'Daisy'},
				{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
#						{code = 'loyalty', value = 150, operant = "+"},
						{code = 'consent', value = 5, operant = "+"},
#						{code = 'price', value = 3000, operant = "+"},
						{code = 'sexuals_factor', value = 2, operant = "+"},
						{code = 'growth_factor', value = 2, operant = "+"},
						{code = 'sex_skills_oral', operant = "+", value = 100},
						{code = 'sex_skills_petting', operant = "+", value = 100},
						{code = 'sex_skills_pussy', operant = "+", value = 100},
						{code = 'sex_skills_anal', operant = "+", value = 100},
						{code = 'add_profession', profession = 'harlot'},
					]
				},
				{code = 'make_story_character', value = 'Cali'},
				{code = 'make_story_character', value = 'Heleviel'},
				{code = 'make_story_character', value = 'Jean'},
				{code = 'make_story_character', value = 'Zephyra'},
				{code = 'make_story_character', value = 'Mae'},
				{code = 'make_story_character', value = 'Kuro'},
				{code = 'make_story_character', value = 'Lilia'},
				{code = 'make_story_character', value = 'Amelia'},
				{code = 'affect_unique_character', name = 'mae', type = 'add_trait', trait = 'spirit_owl'},
				{code = 'affect_unique_character', name = 'lilia', type = 'turn_into_unique', value = 'Lilith'},
			]
		)

		ResourceScripts.game_res.money = 80000
		#globals.common_effects("add_money")
		for i in Items.materiallist:
			ResourceScripts.game_res.materials[i] = 10000
		globals.AddItemToInventory(globals.CreateGearItem("anastasia_bracelet", {}))
		globals.AddItemToInventory(globals.CreateGearItem("daisy_dress", {}))
		globals.AddItemToInventory(globals.CreateGearItem("daisy_dress_lewd", {}))
		globals.AddItemToInventory(globals.CreateGearItem("pet_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("mask", {}))
		globals.AddItemToInventory(globals.CreateGearItem("foxmask", {}))
		globals.AddItemToInventory(globals.CreateGearItem("service_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("lacy_underwear", {}))
		globals.AddItemToInventory(globals.CreateGearItem("jacket", {}))
		var titem = globals.CreateGearItem("cali_heirloom_test", {})
		titem.set_quality_level('legendary')
		globals.AddItemToInventory(titem) #legendary version
		globals.AddItemToInventory(globals.CreateGearItem("worker_outfit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("leather_collar", {}))
		globals.AddItemToInventory(globals.CreateGearItem("garb_of_forest", {}))
		globals.AddItemToInventory(globals.CreateGearItem("amulet_of_recognition", {}))
		globals.AddItemToInventory(globals.CreateGearItem("handcuffs", {}))
		globals.AddItemToInventory(globals.CreateUsableItem("corruptive_essence"))
		globals.AddItemToInventory(globals.CreateUsableItem("map_bandit_fort", 4))
		globals.AddItemToInventory(globals.CreateUsableItem("writ_of_exemption", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("soul_stone", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("sparklingpowder", 5))
		globals.AddItemToInventory(globals.CreateUsableItem("energyshard", 2))
		globals.AddItemToInventory(globals.CreateUsableItem("alcohol", 7))
		globals.AddItemToInventory(globals.CreateUsableItem("beer", 7))
		globals.AddItemToInventory(globals.CreateUsableItem("wine", 7))
		globals.AddItemToInventory(globals.CreateUsableItem("corruptive_essence", 7))
		globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("sexswap_potion", 10))
		globals.AddItemToInventory(globals.CreateUsableItem("oblivion_potion", 10))
		globals.AddItemToInventory(globals.CreateUsableItem("skillbook_hyperborea", 3))
		globals.AddItemToInventory(
			globals.CreateGearItemShop("axe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(globals.CreateGearItem("club", {WeaponMace = 'stone'}))
		globals.AddItemToInventory(
			globals.CreateGearItemShop("dagger", {WeaponHandle = 'wood', Blade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("pickaxe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("staffadv", {Rod = 'mithril', WeaponHandle = 'wood', WeaponEnc = 'fire_ruby'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("club", {WeaponMace = 'wood'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("club", {WeaponMace = 'stone'})
		)

		globals.AddItemToInventory(
			globals.CreateGearItemShop("fishingtools", {ToolHandle = 'wood', ToolClothwork = 'cloth'})
		)

		globals.AddItemToInventory(
			globals.CreateGearItemShop("hunt_knife", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("legs_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("chest_adv_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood', ArmorEnc = 'stone'})
		)
		
		globals.AddItemToInventory(
			globals.CreateGearItemShop(
				"chest_base_cloth", {ArmorBaseCloth = 'clothsilk', ArmorTrim = 'wood'}
			)
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop(
				"legs_base_cloth", {ArmorBaseCloth = 'clothsilk', ArmorTrim = 'wood'}
			)
		)
		# ResourceScripts.game_progress.show_tutorial = true
		ResourceScripts.game_progress.active_quests.append(
			{code = 'princess_search', stage = 'stage2'}
		)
#		globals.common_effects(
#			[
#				{code = "make_loot", pool = [['hard_boss_chest',1]]},
#				{code = 'open_loot'}
#			]
#		)
		#ResourceScripts.game_party.add_relationship_value(ResourceScripts.game_party.get_unique_slave("cali").id,ResourceScripts.game_party.get_unique_slave("zephyra").id, 100)
		character.mp = 10
		character.add_trait('talented')
		var tmp = {}
		tmp.oral = 70
		tmp.anal = 90
		tmp.petting = 100
		#character.set_stat('sex_skills', tmp)
		yield(get_tree(),'idle_frame')
		if gui_controller.exploration == null:
			gui_controller.exploration = input_handler.get_spec_node(input_handler.NODE_EXPLORATION, null, false, false)
#		gui_controller.open_exploration('beastkin_capital')
#		gui_controller.mansion.hide()
#		gui_controller.exploration.open_city('beastkin_capital')
#		gui_controller.exploration.show()
#		gui_controller.nav_panel.select_location('beastkin_capital')
#		input_handler.active_location = ResourceScripts.game_world.areas.plains.locations[ResourceScripts.game_world.areas.plains.locations.keys()[4]]  #[state.areas.plains.locations.size()-1]]
		input_handler.active_area = ResourceScripts.game_world.areas.plains
		#globals.common_effects([{code = 'update_city'},{code = 'make_quest_location', value = 'quest_erlen_location'}, ])
		#for i in ResourceScripts.game_world.areas['plains'].locations.values():
			#if i.classname == 'settlement_plains1'.to_upper(): # SETTLEMENT_PLAINS1
				#i.captured = true


#		var newslave = ResourceScripts.scriptdict.class_slave.new()
#		newslave.generate_predescribed_character(worlddata.pregen_characters["Zephyra"])
#		newslave.set_slave_category('servant')
#		ResourceScripts.game_party.add_slave(newslave)



#		ResourceScripts.game_res.materials.meat = 0
#		globals.common_effects([{code = 'progress_quest', value = 'election_global_quest', stage = 'stage1'}])


		#globals.common_effects([{code = 'progress_quest', value = 'daisy_clothes', stage = 'stage1'} ])
		ResourceScripts.game_progress.decisions.append("bracelet_found")
		ResourceScripts.game_progress.decisions.append("act4_capital")
		input_handler.active_area = ResourceScripts.game_world.areas.plains

		#input_handler.interactive_message('comic_test_1', '', {})
#		input_handler.interactive_message('halloween_9', '', {})
#		input_handler.interactive_message('force_cali_6', '', {})
		#ResourceScripts.gallery.play_scene(0)
		
#		ResourceScripts.game_progress.decisions.append("mayor_election_finished")
		
		#never do this way - cause crash with oblivion potion!!!
#		ResourceScripts.game_party.get_master().xp_module.professions.append("rogue") 


		ResourceScripts.game_progress.completed_quests.append("princess_search")
		ResourceScripts.game_progress.completed_quests.append("act4_capital")
		ResourceScripts.game_progress.completed_quests.append("visit_dwarfs_quest")
		ResourceScripts.game_progress.decisions.append("act1_finish")
		ResourceScripts.game_progress.decisions.append("act4_start")
		globals.common_effects([{code = 'progress_quest', value = 'act_4_capital', stage = 'enter_capital'}])
		#input_handler.interactive_message('comic_test_1', '', {})

		#ResourceScripts.game_progress.decisions.append("fred_bribe_taken")
		
#		globals.common_effects([{code = 'add_timed_event', value = "aliron_exotic_trader", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
#		globals.common_effects([{code = 'add_timed_event', value = "after_mines_message", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
		
		for i in ResourceScripts.game_world.areas.plains.factions.values():
			i.reputation = 500
			i.totalreputation += 500
		# globals.common_effects([{code = 'progress_quest', value = 'mages_election_quest', stage = 'start'}])
		# globals.common_effects([{code = 'reputation', name = 'fighters', operant = '+', value = 100}])
		
		#example of special tasks adding
#		globals.common_effects(
#			[
#				{code = "add_special_task_for_location", location = 'aliron', amount = 5, desc = "TEST", name = "t1",
#				args = [{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage5'}]},
#				{code = "add_special_task_for_location", location = 'aliron', amount = 5, desc = "TEST2", name = "test", max_workers = 4, icon = 'res://assets/images/gui/explore/Captured Characters/icons/icon_quickly_sell.png', 
#				args = [{code = 'progress_quest', value = 'daisy_clothes', stage = 'stage1'}]},
#			]
#		)
		ResourceScripts.game_globals.reset_limits()
		yield(get_tree(), 'idle_frame')
		#input_handler.add_random_chat_message(character2, 'hire')
		
