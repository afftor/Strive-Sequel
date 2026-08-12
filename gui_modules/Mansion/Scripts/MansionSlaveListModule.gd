extends Panel

var active_person
onready var SlaveModule = get_parent().SlaveModule
onready var CardContainer = $ScrollContainer/CardContainer
onready var RowContainer = $ScrollContainer/RowContainer
onready var EntryContentTemplate = $ScrollContainer/VBoxContainer/Button
var SlaveContainer
onready var LocationsList = $TravelsContainerPanel/TravelsContainer/HBoxContainer
onready var LocationsPanel = $TravelsContainerPanel
onready var header = $HBoxContainer
onready var modes = $modes
onready var CharacterContextMenu = $CharacterContextMenu
onready var SortButton = $SortButton
onready var SortMenu = $SortMenu
onready var ListFoldButton = $ListFoldButton
onready var ListFoldTween = $ListFoldTween
onready var ExpandedCharacter = $ExpandedCharacter
onready var ExpandedTween = $ExpandedCharacter/Tween
onready var ExpandedCardSlot = $ExpandedCharacter/CardSlot
onready var ExpandedExtra = $ExpandedCharacter/Extra
onready var ExpandedDetails = $ExpandedCharacter/Extra/Details
onready var ExpandedSocialPanel = $ExpandedCharacter/Extra/SocialPanel
onready var ExpandedSocialSkills = $ExpandedCharacter/Extra/SocialPanel/Margin/Content/SocialSkills
onready var ExpandedRuleButtons = $ExpandedCharacter/Extra/RulesPanel/Margin/Content/Rules
onready var ExpandedBodyPreview = $ExpandedBodyPreview
onready var ExpandedBodyImage = $ExpandedBodyPreview/StoredImage
onready var ExpandedPaperdoll = $ExpandedBodyPreview/Paperdoll
onready var ExpandedBodyTween = $ExpandedBodyPreview/Tween

var populatedlocations = []
var default_locations = ["show_all", "mansion"]
var selected_location = "aliron"
var prev_selected_location = "show_all"
var visible_persons = []

const BUTTON_HEIGHT = 64
const CARD_ROOT = "CardLayout/Margin/Rows"
const CARD_BODY = CARD_ROOT + "/Body"
const CARD_PORTRAIT_ROOT = CARD_BODY + "/Portrait"
const CARD_PORTRAIT = CARD_PORTRAIT_ROOT + "/Image"
const CARD_LOCATION_BACKDROP = CARD_PORTRAIT_ROOT + "/Location"
const CARD_HP_BAR = CARD_PORTRAIT_ROOT + "/HP"
const CARD_MP_BAR = CARD_PORTRAIT_ROOT + "/MP"
const CARD_LUST_BAR = CARD_PORTRAIT_ROOT + "/Lust"
const CARD_SEX = CARD_PORTRAIT_ROOT + "/Sex"
const CARD_RACE = CARD_PORTRAIT_ROOT + "/Race"
const CARD_LEVELUP_INDICATOR = CARD_PORTRAIT_ROOT + "/LevelUpIndicator"
const CARD_STATUS = CARD_ROOT + "/Header/SlaveType"
const CARD_INFO_STRIPS = CARD_BODY + "/InfoStrips"
const CARD_WORK_STRIP = CARD_INFO_STRIPS + "/Work"
const CARD_WORK_TYPE = CARD_WORK_STRIP + "/Content/Icon"
const CARD_WORK_LABEL = CARD_WORK_STRIP + "/Content/Label"
const CARD_LOCATION_STRIP = CARD_INFO_STRIPS + "/Location"
const CARD_LOCATION_ICON = CARD_LOCATION_STRIP + "/Content/Icon"
const CARD_ACTIONS = CARD_ROOT + "/Actions"

const TEX_ROW_NORMAL = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars.png")
const TEX_ROW_HOVER = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_hover.png")
const TEX_ROW_HOVER2 = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_hover2.png")
const TEX_ROW_PRESSED = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_pressed.png")
const TEX_ROW_DISABLED = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_disabled.png")
const TEX_ROW_AVAIL = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_avail.png")
const TEX_TRAVEL_SMALL = preload("res://assets/Textures_v2/MANSION/icon_travel_small.png")
const TEX_NO = preload("res://assets/Textures_v2/MANSION/no.png")
const TEX_YES = preload("res://assets/Textures_v2/MANSION/yes.png")
const TEX_FOOD_STARVING = preload("res://assets/images/iconsitems/food_old.png")
const CARD_ACTION_DISABLED_MATERIAL = preload("res://assets/sfx/bw_shader.tres")
const SKILL_EMPTY_TEXTURE = preload("res://assets/Textures_v2/MANSION/Skills/Buttons/buttonskill_empty.png")
const SKILL_NO_IMAGE_TEXTURE = preload("res://assets/images/gui/panels/noimage.png")
const EXPANDED_ANIMATION_TIME = 0.24
const LIST_FOLD_ANIMATION_TIME = 0.18
const LIST_FOLDED_HEIGHT = 60.0
const EXPANDED_WORK_RULES = [
	"lock",
	"ration",
	"shifts",
	"luxury",
	"contraceptive",
	"nudity",
	"personality_lock",
	"relationship",
]

var expanded_card
var expanded_card_visual
var expanded_card_blocker
var expanded_card_original_modulate = Color(1, 1, 1, 1)
var expanded_pending_card
var expanded_target_rect = Rect2()
var expanded_origin_rect = Rect2()
var expanded_animation_state = ""
var expanded_skill_position = 0
var expanded_build_person
var expanded_build_stage = -1
var expanded_details_ready = false
var expanded_geometry_ready = false
var expanded_body_build_token = 0
var expanded_body_pending_person
var expanded_body_build_state
var expanded_paperdoll_cache_person_id = ""
var expanded_paperdoll_cache_clothed = true
var list_folded = false
var list_unfolded_size = Vector2()

var mode = 'default'
#var mode = 'food'


const JOB_COLOR_DEFAULT = "k_gray"
const JOB_COLOR_REST = "yellow"
const JOB_COLOR_TRAVEL = "factor5"
const JOB_COLOR_SERVICE = "green"
const JOB_COLOR_GATHER = "factor2"
const JOB_COLOR_CRAFT = "aqua"

const JOB_SERVICE_MODS = ['mod_pros', 'mod_service']
const JOB_GATHER_MODS = ['mod_collect', 'mod_hunt', 'mod_fish', 'mod_farm']
const JOB_CRAFT_MODS = ['mod_build', 'mod_cook', 'mod_tailor', 'mod_smith', 'mod_alchemy']

var mass_rule_list = []
var mass_service_list = []
var mass_select_press_effect = false

#sorting is a view-only reorder: character_order keeps the manual (drag) order, so dropping the
#sort - or coming back to the mansion screen - puts every row back where the player left it.
#name and sex sit in every mode, the rest only exist while the default columns are on screen
const SORT_COLUMNS = {
	sex = {node = 'sex_sort', icon = false},
	name = {node = 'name_sort', icon = false},
	occupation = {node = 'job', icon = false},
	exp = {node = 'explabel', icon = false},
	date = {node = 'icon2', icon = true},
	sexact = {node = 'icon3', icon = true},
	train = {node = 'icon4', icon = true},
	type = {node = 'state2', icon = false},
}
const SORT_SEX_ORDER = ['male', 'female', 'futa']
const SORT_CLASS_ORDER = ['master', 'spouse', 'heir', 'servant', 'servant_notax', 'slave_trained', 'slave']
const SORT_COLOR_IDLE = Color(0.878431, 0.878431, 0.878431)
const SORT_COLOR_HOVER = Color(1, 1, 1)
const SORT_MENU_KEYS = ['', 'name', 'occupation', 'train_available', 'date_available', 'levelup']
const SORT_MENU_LABELS = ['MSLMSORTDEFAULT', 'MSLMSORTNAME', 'MSLMSORTWORK', 'MSLMSORTTRAINABLE', 'MSLMSORTDATEABLE', 'MSLMSORTLEVELUP']

var sort_key = ''
var sort_desc = false
var sort_hovered = ''

func _apply_task_color(job_label, mod_value):
	if typeof(mod_value) != TYPE_STRING or mod_value == "":
		return
	if JOB_SERVICE_MODS.has(mod_value):
		_set_job_label_color_from_key(job_label, JOB_COLOR_SERVICE)
	elif JOB_GATHER_MODS.has(mod_value):
		_set_job_label_color_from_key(job_label, JOB_COLOR_GATHER)
	elif JOB_CRAFT_MODS.has(mod_value):
		_set_job_label_color_from_key(job_label, JOB_COLOR_CRAFT)


func _set_job_label_color_from_key(job_label, color_key):
	if variables.hexcolordict.has(color_key):
		job_label.set("custom_colors/font_color", Color(variables.hexcolordict[color_key]))
	elif variables.hexcolordict.has(JOB_COLOR_DEFAULT):
		job_label.set("custom_colors/font_color", Color(variables.hexcolordict[JOB_COLOR_DEFAULT]))


func _ready():
	list_unfolded_size = rect_size
	expanded_target_rect = Rect2(ExpandedCharacter.rect_position, ExpandedCharacter.rect_size)
	#The embedded ragdoll scene defaults to an always-updating Viewport. It is only a
	#preview here, so keep that Viewport disabled until an expanded character needs it.
	_clear_expanded_body_preview()
	ExpandedTween.connect("tween_all_completed", self, "_on_expanded_animation_finished")
	ListFoldTween.connect("tween_all_completed", self, "_on_list_fold_animation_finished")
	ExpandedDetails.connect("info_requested", self, "_open_character_info")
	ExpandedDetails.connect("inventory_requested", self, "OpenInventory")
	set_process_input(false)
	set_process(false)
	_initialize_entry_templates()
	_select_slave_container()
	input_handler.slave_list_node = self
	input_handler.connect('PortraitUpdate', self, 'refresh_portraits')
	globals.connect("slave_added", self, "queue_rebuild")
	globals.connect("task_removed", self, "queue_task_refresh")
	globals.connect("hour_tick", self, "update_dislocations")
	globals.connecttexttooltip($BedroomIcon, tr("BEDROOMTOOLTIP"))
	globals.connecttexttooltip($DateIcon, tr("DATETOOLTIP"))
	globals.connecttexttooltip($SexIcon, tr("SEXTOOLTIP"))
	for nd in modes.get_children():
		nd.connect('pressed', self, 'set_mode', [nd.name])
#	for rl in ['lock', 'ration', 'shifts', 'constrain', 'luxury', 'contraceptive', 'nudity', 'personality_lock', 'relationship', 'masturbation']:
#		globals.connecttexttooltip(header.get_node('rule_' + rl), tr('WORKRULE%sDESCRIPT' % rl.to_upper()))
#	for rl in ['waitress', 'hostess', 'dancer', 'stripper', 'males', 'females', 'futa', 'petting', 'oral', 'anal', 'pussy', 'group', 'sextoy']:
#		globals.connecttexttooltip(header.get_node('brothel_' + rl), tr('BROTHEL%sDESCRIPT' % rl.to_upper()))
	for rl in ['meat', 'fish', 'grain', 'vegetables', 'bread', 'meatsoup', 'curry', 'friedfish', 'fishcakes']:
		globals.connecttexttooltip(header.get_node('food_' + rl),
			tr('MATERIAL%sDESCRIPT' % rl.to_upper()) + globals.get_food_info_text(Items.materiallist[rl]))
#	globals.connecttexttooltip(header.get_node('food_state'),
#		"[center]" + tr("FOODSTATEHEADER") + "[/center]\n" + tr("FOODSTATEHEADERDESCRIPT"))
	input_handler.connect("mass_select_in_act", self, "off_mass_select_effect")
	input_handler.register_btn_source("slave_2_line", self, "tut_get_slave_line", self, 'tut_get_slave_line_rect')
	input_handler.register_btn_source("daisy_line", self, "tut_get_daisy_line", self, 'tut_get_daisy_line_rect')
	input_handler.register_btn_source("ff_meat", self, "tut_get_ff_meat")
#	input_handler.register_btn_source("ff_vegetables", self, "tut_get_ff_vegetables")#delete with time(29.01.26)
	input_handler.register_btn_source("daisy_waitress", self, "tut_get_daisy_waitress")
	input_handler.register_btn_source("default_mode", self, "tut_get_default_mode")
	input_handler.register_btn_source("service_mode", self, "tut_get_service_mode")
	ListFoldButton.connect('pressed', self, '_toggle_slave_list')
	set_slave_list_folded(false, false)
	_setup_sort_menu()
	build_sort_headers()
	get_parent().connect("visibility_changed", self, "on_mansion_shown")


func _input(event):
	if expanded_card == null or !(event is InputEventMouseButton):
		return
	if event.button_index == BUTTON_RIGHT and event.pressed:
		close_expanded_character()
		get_viewport().set_input_as_handled()


#the mansion screen coming back (from a character panel, the city, a scene) is a fresh start
#for the list, so it always reappears in the order the player arranged themselves
func on_mansion_shown():
	if get_parent().visible:
		expanded_paperdoll_cache_person_id = ""
		_close_expanded_character_immediate()
		reset_sorting()


func _on_card_expand_requested(card):
	if get_parent().mansion_state != "default" or mode != "default":
		return
	if !is_instance_valid(card) or card.disabled:
		return
	if expanded_card == card:
		return
	if expanded_card != null:
		expanded_pending_card = card
		close_expanded_character()
		return
	open_expanded_character(card)


func open_expanded_character(card):
	if !is_instance_valid(card) or card.get_parent() != CardContainer:
		return
	var person = card.get_meta("slave", null)
	if person == null:
		return
	expanded_card = card
	expanded_origin_rect = _expanded_rect_for_global_rect(card.get_global_rect())
	#Keep the source card in its container. Moving it out made GridContainer rebuild the
	#visible order twice per animation. A visual copy can move while the real slot stays put.
	expanded_card_original_modulate = card.self_modulate
	card.self_modulate.a = 0.0
	card.drag_enabled = false
	expanded_card_blocker = Control.new()
	expanded_card_blocker.name = "ExpandedCardInputBlocker"
	expanded_card_blocker.anchor_right = 1.0
	expanded_card_blocker.anchor_bottom = 1.0
	expanded_card_blocker.mouse_filter = MOUSE_FILTER_STOP
	card.add_child(expanded_card_blocker)
	expanded_card_blocker.raise()
	_create_expanded_card_visual()

	#Build one section per frame while the geometry is moving. Previously the entire
	#detail pane landed on the animation's last frame and caused a visible hitch there.
	ExpandedExtra.modulate.a = 0.0
	#Keep the transparent detail tree active so its containers finish layout during the
	#staged build instead of all recalculating on the reveal frame.
	ExpandedExtra.show()
	ExpandedSocialPanel.hide()
	ExpandedBodyPreview.show()
	ExpandedBodyPreview.modulate.a = 0.0
	_cancel_expanded_body_preview_build()
	_clear_expanded_body_preview()
	expanded_body_pending_person = person
	ExpandedCharacter.rect_position = expanded_origin_rect.position
	ExpandedCharacter.rect_size = expanded_origin_rect.size
	ExpandedCharacter.show()
	ExpandedCharacter.raise()
	set_process_input(true)
	expanded_animation_state = "opening"
	expanded_build_person = person
	ExpandedDetails.prepare_expanded_person(person)
	expanded_build_stage = 0
	expanded_details_ready = false
	expanded_geometry_ready = false
	set_process(true)
	_play_expanded_geometry(expanded_target_rect)


func close_expanded_character():
	if expanded_card == null or expanded_animation_state == "closing":
		return
	var close_rect = expanded_origin_rect
	if is_instance_valid(expanded_card):
		close_rect = _expanded_rect_for_global_rect(expanded_card.get_global_rect())
	expanded_build_stage = -1
	expanded_build_person = null
	_cancel_expanded_body_preview_build()
	set_process(false)
	ExpandedExtra.hide()
	ExpandedBodyPreview.hide()
	expanded_animation_state = "closing"
	_play_expanded_geometry(close_rect)


func _close_expanded_character_immediate():
	expanded_pending_card = null
	_cancel_expanded_body_preview_build()
	if expanded_card == null:
		return
	ExpandedTween.stop_all()
	ExpandedTween.remove_all()
	_restore_expanded_card()
	ExpandedCharacter.hide()
	ExpandedExtra.hide()
	ExpandedExtra.modulate.a = 0.0
	ExpandedBodyPreview.hide()
	ExpandedBodyPreview.modulate.a = 0.0
	_clear_expanded_body_preview()
	expanded_animation_state = ""
	expanded_build_stage = -1
	expanded_build_person = null
	set_process(false)
	set_process_input(false)


func _play_expanded_geometry(target_rect):
	ExpandedTween.stop_all()
	ExpandedTween.remove_all()
	ExpandedTween.interpolate_property(
		ExpandedCharacter, "rect_position", ExpandedCharacter.rect_position, target_rect.position,
		EXPANDED_ANIMATION_TIME, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	ExpandedTween.interpolate_property(
		ExpandedCharacter, "rect_size", ExpandedCharacter.rect_size, target_rect.size,
		EXPANDED_ANIMATION_TIME, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	ExpandedTween.start()


func _on_expanded_animation_finished():
	if expanded_animation_state == "opening":
		expanded_geometry_ready = true
		expanded_animation_state = "waiting_details"
		_try_reveal_expanded_character()
		return
	if expanded_animation_state == "revealing":
		expanded_animation_state = "open"
		_start_expanded_body_preview_build()
		return
	if expanded_animation_state != "closing":
		return
	_restore_expanded_card()
	ExpandedCharacter.hide()
	ExpandedExtra.hide()
	ExpandedExtra.modulate.a = 0.0
	expanded_animation_state = ""
	set_process_input(false)
	var next_card = expanded_pending_card
	expanded_pending_card = null
	if is_instance_valid(next_card) and next_card.get_parent() == CardContainer:
		open_expanded_character(next_card)


func _process(_delta):
	if expanded_build_stage < 0:
		set_process(false)
		return
	if !is_instance_valid(expanded_card) or expanded_build_person == null:
		_close_expanded_character_immediate()
		return
	if expanded_card.get_meta("slave", null) != expanded_build_person:
		_close_expanded_character_immediate()
		return
	match expanded_build_stage:
		0:
			ExpandedDetails.build_professions()
		1:
			ExpandedDetails.build_overview()
		2:
			ExpandedDetails.build_expanded_character_info()
		3:
			ExpandedDetails.build_relationships()
		4:
			ExpandedDetails.build_equipment()
		5:
			ExpandedDetails.build_traits()
		6:
			ExpandedDetails.build_buffs()
		7:
			#The ragdoll is intentionally assembled after the geometry tween. Its full material
			#pass is too expensive to share a frame with the opening animation.
			expanded_body_pending_person = expanded_build_person
		8:
			build_expanded_social_skills(expanded_build_person)
		9:
			build_expanded_rules(expanded_build_person)
			expanded_build_stage = -1
			expanded_details_ready = true
			expanded_build_person = null
			set_process(false)
			_try_reveal_expanded_character()
			return
	expanded_build_stage += 1


func _try_reveal_expanded_character():
	if !expanded_details_ready or !expanded_geometry_ready:
		return
	if expanded_animation_state != "waiting_details":
		return
	ExpandedExtra.modulate.a = 0.0
	ExpandedExtra.show()
	ExpandedBodyPreview.hide()
	expanded_animation_state = "revealing"
	ExpandedTween.stop_all()
	ExpandedTween.remove_all()
	ExpandedTween.interpolate_property(
		ExpandedExtra, "modulate:a", 0.0, 1.0,
		0.1, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	ExpandedTween.start()


func _clear_expanded_body_preview():
	ExpandedBodyImage.texture = null
	ExpandedBodyImage.hide()
	ExpandedPaperdoll.modulate.a = 1.0
	ExpandedPaperdoll.hide()
	var viewport = ExpandedPaperdoll.get_node_or_null("VPC/VP")
	if viewport != null:
		viewport.render_target_update_mode = Viewport.UPDATE_DISABLED


func _cancel_expanded_body_preview_build():
	expanded_body_build_token += 1
	expanded_body_pending_person = null
	expanded_body_build_state = null
	if is_instance_valid(ExpandedBodyTween):
		ExpandedBodyTween.stop_all()
		ExpandedBodyTween.remove_all()


func _start_expanded_body_preview_build():
	var person = expanded_body_pending_person
	if person == null or expanded_animation_state != "open":
		return
	expanded_body_build_token += 1
	var token = expanded_body_build_token
	expanded_body_build_state = _build_expanded_body_preview_deferred(person, token)


func _expanded_body_build_is_current(person, token):
	return token == expanded_body_build_token \
		and expanded_animation_state == "open" \
		and is_instance_valid(expanded_card) \
		and expanded_card.get_meta("slave", null) == person


func _build_expanded_body_preview_deferred(person, token):
	#Let the final tween frame draw before doing the expensive ragdoll material pass.
	yield(get_tree(), "idle_frame")
	if !_expanded_body_build_is_current(person, token):
		return
	ExpandedBodyPreview.modulate.a = 0.0
	ExpandedBodyPreview.show()
	ExpandedBodyPreview.raise()
	_build_expanded_body_preview(person)
	#The Viewport is UPDATE_ONCE; wait until that frame exists before fading it in.
	yield(get_tree(), "idle_frame")
	if !_expanded_body_build_is_current(person, token):
		return
	expanded_body_pending_person = null
	ExpandedBodyTween.stop_all()
	ExpandedBodyTween.remove_all()
	ExpandedBodyTween.interpolate_property(
		ExpandedBodyPreview, "modulate:a", 0.0, 1.0,
		0.12, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	ExpandedBodyTween.start()
	expanded_body_build_state = null


func _build_expanded_body_preview(person, force_paperdoll = false):
	_clear_expanded_body_preview()
	if person == null:
		return
	var stored_image = person.get_stored_body_image()
	if stored_image != null:
		ExpandedBodyImage.texture = stored_image
		ExpandedBodyImage.show()
	elif !input_handler.globalsettings.disable_paperdoll:
		ExpandedPaperdoll.show()
		ExpandedPaperdoll.test_mode = false
		var clothed = !person.has_work_rule("nudity")
		var cache_matches = expanded_paperdoll_cache_person_id == str(person.id) \
			and expanded_paperdoll_cache_clothed == clothed \
			and ExpandedPaperdoll.character == person
		if force_paperdoll or !cache_matches:
			ExpandedPaperdoll.rebuild(person)
			ExpandedPaperdoll.rebuild_cloth(clothed)
			expanded_paperdoll_cache_person_id = str(person.id)
			expanded_paperdoll_cache_clothed = clothed
		else:
			var viewport = ExpandedPaperdoll.get_node_or_null("VPC/VP")
			if viewport != null:
				viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	else:
		var silhouette = person.get_body_image()
		if silhouette != null:
			ExpandedBodyImage.texture = silhouette
			ExpandedBodyImage.show()
	# Keep the same sprite-selection order as CharacterInfo: a unique nude sprite
	# replaces the stored body image when the nudity rule is active, while the
	# marriage sprite (when applicable) has final priority.
	var unique_code = person.get_stat("unique")
	if unique_code != null and worlddata.pregen_character_sprites.has(unique_code):
		var sprite_data = worlddata.pregen_character_sprites[unique_code]
		if person.has_work_rule("nudity") and sprite_data.has("nude"):
			ExpandedBodyImage.texture = images.get_sprite(sprite_data.nude.path)
		if ResourceScripts.game_progress.spouse != null and globals.valuecheck({type = "has_spouse", check = true}) and !ResourceScripts.game_progress.marriage_completed:
			var spouse_person = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
			if spouse_person != null and spouse_person.get_stat("unique") == unique_code and sprite_data.has("wed"):
				ExpandedBodyImage.texture = images.get_sprite(sprite_data.wed.path)


func _create_expanded_card_visual():
	if is_instance_valid(expanded_card_visual):
		if expanded_card_visual.get_parent() == ExpandedCardSlot:
			ExpandedCardSlot.remove_child(expanded_card_visual)
		expanded_card_visual.queue_free()
	expanded_card_visual = null
	if !is_instance_valid(expanded_card) or !expanded_card.has_node("CardLayout"):
		return
	var source_layout = expanded_card.get_node("CardLayout")
	#Runtime tooltip/action connections are external to CardLayout and are not reliably
	#remapped by duplicate(). Copy the visual tree without signals, then bind it to the
	#same person explicitly so the enlarged card remains fully interactive.
	expanded_card_visual = source_layout.duplicate(14)
	expanded_card_visual.name = "ExpandedCardVisual"
	#The source layout delegates input to its outer card button. The expanded copy has no
	#such parent, so let its root receive double-clicks from the portrait/background.
	expanded_card_visual.mouse_filter = MOUSE_FILTER_STOP
	ExpandedCardSlot.add_child(expanded_card_visual)
	_copy_card_tooltips(source_layout, expanded_card_visual)
	_connect_expanded_card_actions(expanded_card_visual, expanded_card.get_meta("slave"))
	_connect_expanded_card_doubleclicks(expanded_card_visual, expanded_card.get_meta("slave"))


func _connect_expanded_card_actions(layout, person):
	var actions = layout.get_node("Margin/Rows/Actions")
	actions.get_node("Progression").connect("pressed", self, "OpenProgression", [person])
	actions.get_node("Training").connect("pressed", self, "OpenTraining", [person])
	actions.get_node("Inventory").connect("pressed", self, "OpenInventory", [person])
	actions.get_node("Work").connect("pressed", self, "OpenJobModule", [person])
	actions.get_node("Date").connect("pressed", self, "OpenDate", [person])


func _connect_expanded_card_doubleclicks(node, person):
	if node is Control and !(node is BaseButton) and node.mouse_filter != MOUSE_FILTER_IGNORE:
		node.connect("gui_input", self, "_expanded_card_gui_input", [person])
	for child in node.get_children():
		_connect_expanded_card_doubleclicks(child, person)


func _expanded_card_gui_input(event, person):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and event.doubleclick:
		get_tree().set_input_as_handled()
		_open_character_info(person)


func _copy_card_tooltips(source, target):
	for connection in source.get_signal_connection_list("mouse_entered"):
		if connection.target == null or !is_instance_valid(connection.target):
			continue
		var binds = connection.binds.duplicate()
		#Tooltip helpers bind the hovered Control itself for popup positioning. Remap that
		#argument as well, otherwise the tooltip appears beside the transparent source card.
		for index in binds.size():
			if typeof(binds[index]) == TYPE_OBJECT and binds[index] == source:
				binds[index] = target
		target.connect("mouse_entered", connection.target, connection.method, binds, connection.flags)
	for source_child in source.get_children():
		if target.has_node(source_child.name):
			_copy_card_tooltips(source_child, target.get_node(source_child.name))


func _restore_expanded_card():
	if expanded_card == null:
		return
	if is_instance_valid(expanded_card):
		expanded_card.self_modulate = expanded_card_original_modulate
		expanded_card.drag_enabled = sort_key == ""
	if is_instance_valid(expanded_card_blocker):
		if is_instance_valid(expanded_card) and expanded_card_blocker.get_parent() == expanded_card:
			expanded_card.remove_child(expanded_card_blocker)
		expanded_card_blocker.queue_free()
	expanded_card_blocker = null
	#Keep the last visual under the now-hidden overlay. Destroying its whole card tree in
	#the closing callback caused one last-frame spike; it is replaced before the next open.
	expanded_card = null


func _expanded_rect_for_global_rect(global_rect):
	var inverse = get_global_transform_with_canvas().affine_inverse()
	var local_position = inverse.xform(global_rect.position)
	var local_end = inverse.xform(global_rect.position + global_rect.size)
	var slot_offset = ExpandedCardSlot.rect_position
	return Rect2(local_position - slot_offset, local_end - local_position + slot_offset * 2.0)


func build_expanded_social_skills(person):
	input_handler.ClearContainer(ExpandedSocialSkills)
	person.rebuild_skills()
	var source = person.skills.social_skill_panel
	var has_social_skills = !person.skills.social_skills.empty()
	ExpandedSocialPanel.visible = has_social_skills
	if !has_social_skills:
		return
	for position in range(1, 7):
		var button = input_handler.DuplicateContainerTemplate(ExpandedSocialSkills)
		button.get_node("icon").texture = SKILL_EMPTY_TEXTURE
		button.get_node("icon").material = null
		button.get_node("charges").hide()
		button.get_node("cooldown").hide()
		button.get_node("manacost").hide()
		button.get_node("energycost").hide()
		button.disabled = false
		if !source.has(position):
			button.connect("pressed", self, "_select_expanded_social_position", [position])
			continue
		var skill = Skilldata.get_template(source[position], person)
		button.set_meta("skill", skill.code)
		button.get_node("icon").texture = skill.icon if skill.icon != null else SKILL_NO_IMAGE_TEXTURE
		if skill.cost.has("mp"):
			button.get_node("manacost").text = str(int(skill.cost.mp))
			button.get_node("manacost").show()
		if skill.cost.has("energy"):
			button.get_node("energycost").text = str(int(skill.cost.energy))
			button.get_node("energycost").show()
		var used_charges = person.skills.social_skills_charges.get(skill.code, 0)
		var charges_left = skill.charges - used_charges
		button.get_node("charges").text = str(charges_left) + "/" + str(skill.charges)
		button.get_node("charges").show()
		if charges_left <= 0:
			button.disabled = true
			var cooldown = person.skills.social_cooldowns.get(skill.code, person.skills.daily_cooldowns.get(skill.code, null))
			if cooldown != null:
				button.get_node("cooldown").text = str(cooldown)
				button.get_node("cooldown").show()
		if !person.check_cost(skill.cost) or !person.checkreqs(skill.reqs) or person.has_status("no_social_skills") or person.get_work() == "disabled":
			button.disabled = true
		if button.disabled:
			button.get_node("icon").material = CARD_ACTION_DISABLED_MATERIAL
		globals.connectskilltooltip(button, skill.code, person)
		button.connect("pressed", self, "_select_expanded_social_skill", [skill.code])


func build_expanded_rules(person):
	input_handler.ClearContainer(ExpandedRuleButtons)
	if person == null:
		return
	luxury_rooms_taken = globals.calculate_lux_rooms()
	for code in EXPANDED_WORK_RULES:
		if !_expanded_rule_is_visible(person, code):
			continue
		var button = input_handler.DuplicateContainerTemplate(ExpandedRuleButtons)
		button.name = code
		button.get_node("Label").text = tr("WORKRULE" + code.to_upper())
		button.pressed = person.check_work_rule(code)
		button.disabled = _expanded_rule_is_disabled(person, code)
		_refresh_expanded_rule_button(button)
		var tooltip = "[center]" + tr("WORKRULE" + code.to_upper()) + "[/center]\n"
		tooltip += person.translate(tr("WORKRULE" + code.to_upper() + "DESCRIPT"))
		if code == "luxury":
			tooltip += "\n" + tr("MSLMROOMSUSED") % [
				luxury_rooms_taken,
				ResourceScripts.game_res.upgrades.luxury_rooms + 1,
			]
		globals.connecttexttooltip(button, tooltip)
		button.connect("pressed", self, "_toggle_expanded_rule", [person, code])


func _refresh_expanded_rule_button(button):
	button.get_node("Mark").visible = !button.pressed and !button.disabled
	button.get_node("Checked").visible = button.pressed and !button.disabled
	button.get_node("Disabled").visible = !button.pressed and button.disabled
	button.get_node("CheckedDisabled").visible = button.pressed and button.disabled


func _expanded_rule_is_visible(person, code):
	if person.is_master() and code in ["luxury", "relationship"]:
		return false
	if person.check_trait("undead") and code in ["contraceptive", "ration"]:
		return false
	return true


func _expanded_rule_is_disabled(person, code):
	match code:
		"luxury":
			return ((luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1)
				and !person.check_work_rule("luxury")) or person.is_master()
		"relationship":
			return person.is_master()
		"nudity":
			return !person.has_status("sexservice")
		"contraceptive", "ration":
			return person.check_trait("undead")
	return false


func _toggle_expanded_rule(person, code):
	if person == null:
		return
	person.set_work_rule(code, !person.check_work_rule(code))
	ExpandedDetails.build_overview()
	build_expanded_rules(person)
	if is_instance_valid(expanded_card):
		update_entry_availability(expanded_card, person)
	if code == "nudity":
		if ExpandedPaperdoll.visible:
			var clothed = !person.has_work_rule("nudity")
			ExpandedPaperdoll.rebuild_cloth(clothed)
			expanded_paperdoll_cache_person_id = str(person.id)
			expanded_paperdoll_cache_clothed = clothed
		else:
			_build_expanded_body_preview(person, true)
			ExpandedBodyPreview.visible = ExpandedBodyImage.visible or ExpandedPaperdoll.visible


func _select_expanded_social_skill(skill_code):
	if expanded_card == null:
		return
	var person = expanded_card.get_meta("slave", null)
	if person == null:
		return
	get_parent().skill_source = person
	get_parent().SkillModule.person = person
	get_parent().SkillModule.select_skill_target(skill_code)


func _select_expanded_social_position(position):
	if expanded_card == null:
		return
	var person = expanded_card.get_meta("slave", null)
	if person == null:
		return
	expanded_skill_position = position
	input_handler.ShowSkillSelectPanel(person, variables.PANEL_SOC, self, "_expanded_social_skill_selected")


func _expanded_social_skill_selected(skill):
	if expanded_card == null:
		return
	var person = expanded_card.get_meta("slave", null)
	if person == null:
		return
	if skill == null:
		person.skills.social_skill_panel.erase(expanded_skill_position)
	else:
		person.skills.social_skill_panel[expanded_skill_position] = skill
	build_expanded_social_skills(person)


func _setup_sort_menu():
	SortMenu.clear()
	for i in SORT_MENU_KEYS.size():
		SortMenu.add_item(tr(SORT_MENU_LABELS[i]), i)
		SortMenu.set_item_as_radio_checkable(i, true)
	SortButton.connect('pressed', self, '_open_sort_menu')
	SortMenu.connect('id_pressed', self, '_select_sort_option')
	_sync_sort_menu()


func _open_sort_menu():
	var button_rect = SortButton.get_global_rect()
	var popup_position = button_rect.position + Vector2(0, button_rect.size.y)
	SortMenu.hide()
	SortMenu.set_as_toplevel(true)
	SortMenu.rect_global_position = popup_position
	SortMenu.popup()
	SortMenu.set_as_minsize()
	SortMenu.rect_size.x = max(SortMenu.rect_size.x, button_rect.size.x)


func _select_sort_option(id):
	if id < 0 or id >= SORT_MENU_KEYS.size():
		return
	_close_expanded_character_immediate()
	sort_key = SORT_MENU_KEYS[id]
	sort_desc = false
	apply_sorting()
	_sync_sort_menu()


func _sync_sort_menu():
	var selected_index = SORT_MENU_KEYS.find(sort_key)
	if selected_index < 0:
		selected_index = 0
	for i in SORT_MENU_KEYS.size():
		SortMenu.set_item_checked(i, i == selected_index)
	SortButton.get_node('Label').text = tr(SORT_MENU_LABELS[selected_index])


func _toggle_slave_list():
	_close_expanded_character_immediate()
	SortMenu.hide()
	set_slave_list_folded(!list_folded)


func set_slave_list_folded(folded, animated = true):
	list_folded = folded
	ListFoldTween.stop_all()
	ListFoldTween.remove_all()
	rect_clip_content = true
	var target_size = list_unfolded_size
	if folded:
		target_size.y = LIST_FOLDED_HEIGHT
	ListFoldButton.get_node("Label").text = "v" if folded else "^"
	globals.connecttexttooltip(ListFoldButton, tr("MSLMUNFOLDLIST" if folded else "MSLMFOLDLIST"))
	$ScrollContainer.mouse_filter = MOUSE_FILTER_IGNORE if folded else MOUSE_FILTER_STOP
	if !animated:
		rect_size = target_size
		rect_clip_content = folded
		return
	ListFoldTween.interpolate_property(self, "rect_size", rect_size, target_size,
		LIST_FOLD_ANIMATION_TIME, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	ListFoldTween.start()


func _on_list_fold_animation_finished():
	rect_clip_content = list_folded

func tut_get_slave_line():
	for line in SlaveContainer.get_children():
		if !line.has_meta("slave"):
			continue
		if line.get_meta('slave').get_stat('slave_class') == 'servant':
			return line
func tut_get_slave_line_rect():
	var check_rect
	for line in SlaveContainer.get_children():
		if !line.has_meta("slave"):
			continue
		if line.get_meta('slave').get_stat('slave_class') == 'servant':
			check_rect = line.get_global_rect()
			break
	check_rect.size.x = 300
	return check_rect
func tut_get_daisy_line():
	for line in SlaveContainer.get_children():
		if !line.has_meta("slave"):
			continue
		if line.get_meta('slave').get_stat('unique') == 'daisy':
			return line
func tut_get_daisy_line_rect():
	var check_rect
	for line in SlaveContainer.get_children():
		if !line.has_meta("slave"):
			continue
		if line.get_meta('slave').get_stat('unique') == 'daisy':
			check_rect = line.get_global_rect()
			break
	check_rect.size.x = 300
	return check_rect

func tut_get_ff_meat():
	return SlaveContainer.get_children()[0].get_node("ff_meat")
#func tut_get_ff_vegetables():
#	return SlaveContainer.get_children()[0].get_node("ff_vegetables")
func tut_get_daisy_waitress():
	var line = tut_get_daisy_line()
	return line.get_node("rule_waitress")

func tut_get_default_mode():
	return modes.get_node("default")
func tut_get_service_mode():
	return modes.get_node("brothel")

func off_mass_select_effect():
	mass_select_press_effect = null

func OpenJobModule(person = null):
	_close_expanded_character_immediate()
	input_handler.ActivateTutorial('TUTORIALLIST4')
	if person != null:
		get_parent().get_node("MansionJobModule2").selected_location = person.get_location()
		get_parent().active_person = person
	get_parent().remove_hovered_person()
	get_parent().mansion_state_set("occupation")
	get_parent().get_node("MansionJobModule2").focus_on_person_task(person)


func OpenInventory(person = null):
	_close_expanded_character_immediate()
	get_parent().remove_hovered_person()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.inventory, 0.3)
	gui_controller.inventory.show()
	#gui_controller.inventory.get_node("GridContainer/GearButton").set_pressed(true)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(person)
	gui_controller.emit_signal("screen_changed")


func OpenProgression(person):
	_open_character_info(person)
	if gui_controller.slavepanel != null:
		gui_controller.slavepanel.set_state("skills")


func OpenTraining(person):
	_open_character_info(person)
	if gui_controller.slavepanel != null:
		gui_controller.slavepanel.SlaveInfo.open_upgrade_tab(_get_training_tab(person))


func OpenDate(person):
	_open_character_info(person)
	if gui_controller.slavepanel != null:
		gui_controller.slavepanel.SummaryModule.date()


func _open_character_info(person):
	_close_expanded_character_immediate()
	get_parent().set_active_person(person)
	get_parent().mansion_state_set("char_info")


func OpenSpells(person = null):
	_close_expanded_character_immediate()
	get_parent().remove_hovered_person()
	gui_controller.spells = input_handler.get_spec_node(input_handler.NODE_SPELLS)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.spells, 0.3)
	gui_controller.spells.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.spells
	gui_controller.spells.open(person)
	gui_controller.emit_signal("screen_changed")

func update_buttons():
	for i in SlaveContainer.get_children():
		if i.has_meta("slave"):
			var should_be_pressed = get_parent().active_person == i.get_meta('slave')
			if i.pressed != should_be_pressed:
				i.pressed = should_be_pressed
				_refresh_card_visual(i)


func _select_slave_container():
	var use_cards = mode == 'default'
	CardContainer.visible = use_cards
	RowContainer.visible = !use_cards
	SlaveContainer = CardContainer if use_cards else RowContainer


func _initialize_entry_templates():
	#The card view must not carry the entire hidden legacy row. With a large roster those
	#dozens of extra Controls per card make every idle frame and layout pass expensive.
	for container in [CardContainer, RowContainer]:
		var container_template = container.get_node("Button")
		if container_template.get_child_count() > 0:
			continue
		for template_child in EntryContentTemplate.get_children():
			if container == CardContainer and template_child.name != "CardLayout":
				continue
			container_template.add_child(template_child.duplicate())
		container_template.get_parent().set_meta("built_rows_signature", "")


func _ensure_selected_container_entries():
	var signature = build_rows_signature()
	if SlaveContainer.get_meta("built_rows_signature", "") == signature:
		return
	input_handler.ClearContainer(SlaveContainer)
	if SlaveContainer == RowContainer:
		mass_rule_list.clear()
		mass_service_list.clear()
	for person_id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[person_id]
		if SlaveContainer == CardContainer:
			_build_card_entry(person, person_id)
		else:
			_build_row_entry(person, person_id)
	SlaveContainer.set_meta("built_rows_signature", signature)


func _setup_card(newbutton, person):
	newbutton.get_node(CARD_ACTIONS + "/Progression").connect("pressed", self, "OpenProgression", [person])
	newbutton.get_node(CARD_ACTIONS + "/Training").connect("pressed", self, "OpenTraining", [person])
	newbutton.get_node(CARD_ACTIONS + "/Inventory").connect("pressed", self, "OpenInventory", [person])
	newbutton.get_node(CARD_ACTIONS + "/Work").connect("pressed", self, "OpenJobModule", [person])
	newbutton.get_node(CARD_ACTIONS + "/Date").connect("pressed", self, "OpenDate", [person])
	_set_card_text_tooltip(newbutton.get_node(CARD_ACTIONS + "/Progression"), tr("BTNLEVELING"))
	_set_card_text_tooltip(newbutton.get_node(CARD_ACTIONS + "/Training"), tr("SIBLINGMODULETRAININGS"))
	_set_card_text_tooltip(newbutton.get_node(CARD_ACTIONS + "/Inventory"), tr("LMMINVENTORY"))
	_set_card_text_tooltip(newbutton.get_node(CARD_ACTIONS + "/Work"), tr("LMMWORK"))
	_set_card_text_tooltip(newbutton.get_node(CARD_ACTIONS + "/Date"), tr("BTNDATE"))


func _set_card_text_tooltip(node, tooltip_text, move_right = false):
	var signature = str(move_right) + "|" + str(tooltip_text)
	if node.has_meta("card_tooltip_signature") and node.get_meta("card_tooltip_signature") == signature:
		return
	if tooltip_text == "":
		globals.disconnect_text_tooltip(node)
	else:
		globals.connecttexttooltip(node, tooltip_text, move_right)
	node.set_meta("card_tooltip_signature", signature)


func _get_date_availability(person):
	if person.is_on_quest():
		return [false, "ONQUESTLABEL"]
	if person.is_master():
		return [false, "NODATEMASTER"]
	if person.has_status("no_date"):
		return [false, "NODATEUNIQUE"]
	if person.get_stat('slave_class') in ['servant', 'servant_notax', 'heir'] and !person.has_status("relation"):
		return [false, "NODATERELATION"]
	if person.tags.has("no_date_day") and !ResourceScripts.game_globals.unlimited_date_sex:
		return [false, "NODATETODAY"]
	if ResourceScripts.game_globals.weekly_dates_left <= 0:
		return [false, "NODATEWEEK"]
	return [true, ""]


func _get_training_availability(person):
	if person.is_on_quest():
		return [false, person.translate(tr("ONQUESTLABEL"))]
	#Servants and heirs use trait training, while masters use their general upgrade tree;
	#neither route requires an assigned slave trainer.
	if !person.training.is_slave():
		return [true, ""]
	#Finished slave training opens the post-training trait/reward screen.
	if !person.training.enable:
		return [true, ""]
	if person.training.trainer == null:
		return [false, person.translate(tr("TRAINNOTRAINER"))]
	if person.training.is_rebel_blocked():
		return [false, tr("ACTIONREBELBLOCKED")]
	if !person.training.has_category_not_in_cd():
		var cooldown_days = 999
		for category in person.training.cooldown:
			cooldown_days = min(cooldown_days, int(ceil(person.training.cooldown[category])))
		return [false, tr("TRAINCOOLDOWN") % max(cooldown_days, 1)]
	return [true, ""]


func _get_training_tab(person):
	if person.is_master():
		return "master_upg"
	if person.get_stat('slave_class') in ['slave', 'slave_trained', 'servant', 'servant_notax', 'heir']:
		return "trainings"
	return "minor_upg"


func _get_training_title(person):
	match _get_training_tab(person):
		"master_upg":
			return tr("SIBLINGMODULETRAININGSMASTER")
		"minor_upg":
			return tr("SIBLINGMODULEMINORTRAINING")
		_:
			return tr("SIBLINGMODULETRAININGS")


func _can_progress_person(person):
	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		return true
	for mastery in Skilldata.masteries:
		if person.can_upgrade_mastery(mastery) or person.can_upgrade_mastery(mastery, true):
			return true
	return false


func _get_character_type_tooltip(person):
	var class_code = person.get_stat('slave_class')
	if class_code == 'servant_notax':
		class_code = 'servant'
	var base_key = "CHARTYPE" + class_code.to_upper()
	var name_key = base_key
	if person.get_stat('sex') != 'male':
		name_key += "F"
	var result = "[center]{color=yellow|" + tr(name_key) + "}[/center]"
	var description_key = base_key + "DESCRIPT"
	var description = tr(description_key)
	if description != description_key:
		result += "\n\n" + person.translate(description)
	return result


func _work_icon_texture(value):
	if value is String:
		return load(value)
	return value


func _get_card_work_output(person, job_text):
	var result = {texture = null, tooltip = ""}
	var work_code = person.get_work()
	if work_code in ['', 'learning', 'travel'] or person.is_on_quest():
		return result
	if work_code == 'crafting':
		var task_id = person.predict_active_task()
		if task_id == null or !ResourceScripts.game_res.tasks_progresses.has(task_id):
			return result
		var craft_task = ResourceScripts.game_res.tasks_progresses[task_id]
		if craft_task.job == 'building':
			if upgradedata.upgradelist.has(task_id):
				var upgrade = upgradedata.upgradelist[task_id]
				result.texture = images.upgrade_icons[upgrade.icon]
				result.tooltip = "[center]" + job_text + "[/center]\n" + tr(upgrade.name)
			return result
		if !Items.recipes.has(craft_task.id):
			return result
		var recipe = Items.recipes[craft_task.id]
		var item_data = Items.materiallist.get(recipe.resultitem) if recipe.resultitemtype == 'material' else Items.itemlist.get(recipe.resultitem)
		if item_data != null:
			result.texture = _work_icon_texture(item_data.icon)
			result.tooltip = "[center]" + job_text + "[/center]\n" + tr(item_data.name)
		return result
	if work_code == 'farming':
		var farm_outputs = person.get_farming_rules()
		var output_names = []
		for output_code in farm_outputs:
			if !Items.materiallist.has(output_code):
				continue
			var material = Items.materiallist[output_code]
			if result.texture == null:
				result.texture = _work_icon_texture(material.icon)
			output_names.append(tr(material.name))
		if !output_names.empty():
			result.tooltip = "[center]" + job_text + "[/center]\n" + PoolStringArray(output_names).join(", ")
		return result
	var task = person.find_worktask()
	if task == null:
		return result
	if task.has('job') and Items.materiallist.has(task.job):
		var material = Items.materiallist[task.job]
		result.texture = _work_icon_texture(material.icon)
		result.tooltip = "[center]" + job_text + "[/center]\n" + tr(material.name)
	elif task.has('icon') and task.icon != null:
		result.texture = _work_icon_texture(task.icon)
		result.tooltip = "[center]" + job_text + "[/center]"
	return result


func _update_card_work_type(newbutton, person, job_text):
	var work_icon = newbutton.get_node(CARD_WORK_TYPE)
	var work_label = newbutton.get_node(CARD_WORK_LABEL)
	var work_strip = newbutton.get_node(CARD_WORK_STRIP)
	var output = _get_card_work_output(person, job_text)
	work_icon.texture = output.texture
	work_icon.visible = output.texture != null
	work_label.text = job_text
	var tooltip = output.tooltip
	if tooltip == "":
		tooltip = "[center]" + job_text + "[/center]"
	_set_card_text_tooltip(work_strip, tooltip)


func _reset_card_location_strip(newbutton):
	newbutton.get_node(CARD_LOCATION_ICON).texture = null
	_set_card_text_tooltip(newbutton.get_node(CARD_LOCATION_STRIP), "")
	_set_card_location_backdrop(newbutton, null)


func _get_card_location_backdrop(location_code):
	#the strip carries small icons, the backdrop behind the portrait wants the location art
	#itself. Capitals have no background of their own, but their icon id doubles as one
	if location_code in ["Mansion", "mansion"]:
		return images.get_card_background("mansion")
	var location_data = ResourceScripts.world_gen.get_location_from_code(location_code)
	if location_data == null:
		return null
	if location_data.type == "capital":
		return images.get_card_background(worlddata.lands[location_data.area].capital_icon)
	if !location_data.has('background'):
		return null
	return images.get_card_background(location_data.background)


func _set_card_location_backdrop(newbutton, location_code):
	var backdrop = newbutton.get_node_or_null(CARD_LOCATION_BACKDROP)
	if backdrop == null: #row layouts have no portrait card to put it behind
		return
	backdrop.texture = null if location_code == null else _get_card_location_backdrop(location_code)


func _refresh_entry_portrait(entry, person):
	if person == null:
		return
	if entry.has_node(CARD_PORTRAIT):
		entry.get_node(CARD_PORTRAIT).texture = person.get_icon()
	if entry.has_node("icon"):
		entry.get_node("icon").texture = person.get_icon_small()


#a regenerated portrait lands a couple of frames after whatever triggered it, long after
#the list drew itself, and nothing here listened for it - the card kept the old picture
#until the next full rebuild. Re-reading is a cached lookup now, so every entry just takes
#its own again rather than the signal carrying who changed
func refresh_portraits():
	if SlaveContainer != null:
		for entry in SlaveContainer.get_children():
			if !is_instance_valid(entry) or entry.is_queued_for_deletion() or !entry.has_meta('slave'):
				continue
			_refresh_entry_portrait(entry, entry.get_meta('slave'))
	if !is_instance_valid(expanded_card) or !is_instance_valid(expanded_card_visual):
		return
	var portrait_path = CARD_PORTRAIT.trim_prefix("CardLayout/")
	var expanded_person = expanded_card.get_meta("slave", null)
	if expanded_person != null and expanded_card_visual.has_node(portrait_path):
		expanded_card_visual.get_node(portrait_path).texture = expanded_person.get_icon()


func _get_navigation_location_texture(location_code):
	#Keep the card thumbnail identical to the one produced by NavigationModule.
	if location_code in ["Mansion", "mansion"]:
		return images.get_background("mansion")
	if location_code == "Infinite":
		return images.get_icon("tower")
	var location_data = ResourceScripts.world_gen.get_location_from_code(location_code)
	if location_data == null:
		return null
	if location_data.type == "capital":
		return images.get_icon(worlddata.lands[location_data.area].capital_icon)
	return images.get_background(location_data.background)


func _set_card_location_strip(newbutton, texture, label, tooltip = ""):
	newbutton.get_node(CARD_LOCATION_ICON).texture = texture
	_set_card_text_tooltip(newbutton.get_node(CARD_LOCATION_STRIP), tooltip if tooltip != "" else label)


func _set_card_action_available(button, available):
	button.disabled = !available
	button.material = null if available else CARD_ACTION_DISABLED_MATERIAL


func _update_card_action_states(newbutton, person):
	newbutton.get_node(CARD_LEVELUP_INDICATOR).visible = person.get_stat('base_exp') >= person.get_next_class_exp()
	var training_availability = _get_training_availability(person)
	var training_button = newbutton.get_node(CARD_ACTIONS + "/Training")
	_set_card_action_available(training_button, training_availability[0])
	var training_tooltip = _get_training_title(person)
	if training_availability[0]:
		training_tooltip += "\n" + tr("TRAINTOOLTIP")
	else:
		training_tooltip += "\n" + training_availability[1]
	_set_card_text_tooltip(training_button, training_tooltip)
	var date_availability = _get_date_availability(person)
	var date_button = newbutton.get_node(CARD_ACTIONS + "/Date")
	date_button.visible = !person.is_master()
	_set_card_action_available(date_button, date_availability[0])
	var date_tooltip = tr("BTNDATE")
	if !date_availability[0]:
		date_tooltip += "\n" + person.translate(tr(date_availability[1]))
	_set_card_text_tooltip(date_button, date_tooltip)
	var inventory_button = newbutton.get_node(CARD_ACTIONS + "/Inventory")
	_set_card_action_available(inventory_button, !person.is_on_quest())
	var inventory_tooltip = tr("LMMINVENTORY")
	if inventory_button.disabled:
		inventory_tooltip += "\n" + person.translate(tr("ONQUESTLABEL"))
	_set_card_text_tooltip(inventory_button, inventory_tooltip)


func _get_job_color_key(mod_value):
	if typeof(mod_value) != TYPE_STRING or mod_value == "":
		return JOB_COLOR_DEFAULT
	if JOB_SERVICE_MODS.has(mod_value):
		return JOB_COLOR_SERVICE
	if JOB_GATHER_MODS.has(mod_value):
		return JOB_COLOR_GATHER
	if JOB_CRAFT_MODS.has(mod_value):
		return JOB_COLOR_CRAFT
	return JOB_COLOR_DEFAULT


#The card view used to refresh every hidden legacy column as well. Keep the display
#calculation independent so the normal mansion screen only touches controls it can draw.
func _get_card_job_display(person):
	var result = {text = tr("TASKREST"), color = JOB_COLOR_DEFAULT}
	var work_code = person.get_work()
	var is_traveling = person.travel.location == "travel" || person.check_location('travel') || work_code == 'travel'
	if is_traveling:
		result.text = tr("TASKTRAVEL")
		result.color = JOB_COLOR_TRAVEL
	elif work_code == '' or !person.is_avaliable():
		if person.is_on_quest():
			var time_left = int(person.get_quest_time_remains())
			if time_left > 0:
				var time_left_string = ''
				if time_left == 1:
					time_left = 4 - ResourceScripts.game_globals.hour
					time_left_string = str(time_left) + " turns"
				else:
					time_left_string = str(time_left) + " d."
				result.text = "On Quest: " + time_left_string
			else:
				result.text = person.get_unaval_string()
		else:
			result.color = JOB_COLOR_REST
	elif work_code == 'learning':
		result.text = tr("SIBLINGMODULETRAININGS")
	elif work_code == 'crafting':
		var predict_task_id = person.predict_active_task()
		if predict_task_id == null or !ResourceScripts.game_res.tasks_progresses.has(predict_task_id):
			result.text = tr('TASKREST')
		else:
			var predict_task = ResourceScripts.game_res.tasks_progresses[predict_task_id]
			var predict_task_cat = predict_task.job
			if predict_task_cat != 'building':
				predict_task_cat = predict_task_cat.trim_suffix('_item')
				predict_task_cat = predict_task_cat.trim_suffix('_material')
			if tasks.tasklist.has(predict_task_cat):
				var predict_job = tasks.tasklist[predict_task_cat]
				result.text = tr(predict_job.name)
				if predict_job.has('mod'):
					result.color = _get_job_color_key(predict_job.mod)
	else:
		var task = person.find_worktask()
		if task != null:
			result.text = tr(task.name)
			if task.has('mod'):
				result.color = _get_job_color_key(task.mod)
	if !person.is_worker():
		result.color = 'red'
	return result


func _update_card_location(newbutton, person):
	if !person.is_avaliable():
		_set_card_location_strip(newbutton, null, person.get_unaval_string())
		_set_card_location_backdrop(newbutton, null)
		return
	if person.check_location('travel'):
		var tooltip = tr("MSLMRELOC") + ": " + tr("MSLMRE") + " " + str(ceil(person.travel.travel_time / person.travel_per_tick())) + tr("MSLMTURN") + ". "
		var texture = _get_navigation_location_texture(person.travel.travel_target.location)
		if texture == null:
			texture = TEX_TRAVEL_SMALL
		_set_card_location_strip(newbutton, texture, tr("TASKTRAVEL"), tooltip)
		#on the road the strip already points at where they are headed, so does the backdrop
		_set_card_location_backdrop(newbutton, person.travel.travel_target.location)
		return
	if person.check_location('aliron') || person.get_location() == "mansion":
		_set_card_location_strip(newbutton, _get_navigation_location_texture("mansion"), tr("MANSION_LABEL"))
		_set_card_location_backdrop(newbutton, "mansion")
		return
	var location_code = person.get_location()
	var location = ResourceScripts.world_gen.get_location_from_code(location_code)
	if location != null:
		_set_card_location_strip(newbutton, _get_navigation_location_texture(location_code), tr(location.name))
		_set_card_location_backdrop(newbutton, location_code)
	else:
		_set_card_location_strip(newbutton, null, "")
		_set_card_location_backdrop(newbutton, null)


func _update_card_static_content(newbutton, person):
	var sex = person.get_stat('sex')
	var race = person.get_stat('race')
	var slave_class = person.get_stat('slave_class')
	var signature = "%s|%s|%s|%s|%s" % [
		person.get_short_name(),
		sex,
		race,
		slave_class,
		str(person.get_stat('unique')),
	]
	if newbutton.has_meta("card_static_signature") and newbutton.get_meta("card_static_signature") == signature:
		return
	newbutton.set_meta("card_static_signature", signature)
	newbutton.get_node(CARD_ROOT + "/Header/Name").text = person.get_short_name()
	newbutton.get_node(CARD_STATUS).texture = person.get_class_icon()
	newbutton.get_node(CARD_SEX).texture = images.get_icon(sex)
	var race_icon = races.racelist[race].icon
	if race_icon is String:
		race_icon = load(race_icon)
	newbutton.get_node(CARD_RACE).texture = race_icon
	var name_color = Color(variables.hexcolordict.unique) if person.is_master() or person.is_unique() else Color(0.878431, 0.878431, 0.878431)
	newbutton.get_node(CARD_ROOT + "/Header/Name").set("custom_colors/font_color", name_color)
	_set_card_text_tooltip(newbutton.get_node(CARD_SEX), tr("MSLMSex") + ": " + tr("SLAVESEX" + sex.to_upper()))
	_set_card_text_tooltip(newbutton.get_node(CARD_STATUS), _get_character_type_tooltip(person))
	_set_card_text_tooltip(newbutton.get_node(CARD_RACE), "[center]{color=green|" + races.racelist[race].name + "}[/center]\n\n" + person.show_race_description())


func _update_card_button(newbutton, person):
	newbutton.get_node(CARD_PORTRAIT).texture = person.get_icon()
	input_handler.queue_portrait(person) #most of a mansion never had a shot taken at all
	_update_card_static_content(newbutton, person)
	_update_card_progress(newbutton.get_node(CARD_HP_BAR), tr("STATHP"), person.hp, person.get_stat('hpmax'))
	_update_card_progress(newbutton.get_node(CARD_MP_BAR), tr("STATMP"), person.mp, person.get_stat('mpmax'))
	var lust_bar = newbutton.get_node(CARD_LUST_BAR)
	lust_bar.visible = person.check_trait('succubus')
	if lust_bar.visible:
		_update_card_progress(lust_bar, tr("STATLUST"), person.get_stat('lust'), person.get_stat('lustmax'))
	var job_display = _get_card_job_display(person)
	newbutton.set_meta("card_job_text", job_display.text)
	_update_card_work_type(newbutton, person, job_display.text)
	_set_job_label_color_from_key(newbutton.get_node(CARD_WORK_LABEL), job_display.color)
	_update_card_location(newbutton, person)
	var card_work = newbutton.get_node(CARD_ACTIONS + "/Work")
	var work_available = person.is_worker() and person.travel.location != "travel" and !person.is_on_quest()
	_set_card_action_available(card_work, work_available)
	var work_tooltip = tr("LMMWORK") + ": " + job_display.text
	if !work_available:
		if person.is_on_quest():
			work_tooltip += "\n" + person.translate(tr("ONQUESTLABEL"))
		elif person.travel.location == "travel":
			work_tooltip += "\n" + tr("TASKTRAVEL")
		elif person.get_stat('slave_class') == 'slave':
			work_tooltip += "\n" + person.translate(tr("TRAINNOTRAINER"))
		else:
			work_tooltip += "\n" + person.translate(tr("TRAINNOWORKTRAIT"))
	_set_card_text_tooltip(card_work, work_tooltip)
	_refresh_card_visual(newbutton)


func get_turn_animation_source(person_id):
	if is_instance_valid(expanded_card) and is_instance_valid(expanded_card_visual):
		var expanded_person = expanded_card.get_meta("slave", null)
		var portrait_path = CARD_PORTRAIT.trim_prefix("CardLayout/")
		if expanded_person != null and str(expanded_person.id) == str(person_id) and expanded_card_visual.has_node(portrait_path):
			return expanded_card_visual.get_node(portrait_path)
	for card in CardContainer.get_children():
		var person = card.get_meta("slave", null)
		if person == null or str(person.id) != str(person_id) or !card.has_node(CARD_PORTRAIT):
			continue
		var portrait = card.get_node(CARD_PORTRAIT)
		if !$ScrollContainer.get_global_rect().intersects(portrait.get_global_rect()):
			return null
		return portrait
	return null


func _set_card_hover(newbutton, hovered):
	newbutton.set_meta("card_hovered", hovered)
	_refresh_card_visual(newbutton)


func _on_card_toggled(pressed, newbutton):
	_refresh_card_visual(newbutton)


func _refresh_card_visual(newbutton):
	if !newbutton.has_node("CardLayout"):
		return
	var color = Color(1, 1, 1)
	if newbutton.disabled:
		color = Color(0.55, 0.55, 0.55)
	elif newbutton.pressed:
		color = Color(1.18, 1.06, 0.72)
	elif newbutton.get_meta("card_hovered", false):
		color = Color(1.12, 1.08, 1.02)
	newbutton.get_node("CardLayout").self_modulate = color

func rebuild():
	task_refresh_queued = false
	_close_expanded_character_immediate()
	_select_slave_container()
	#update_button reads this for the luxury rule, and rebuild can run before the first
	#update()/refresh_after_turn() - on a fresh game the queued rebuild is the very first call
	luxury_rooms_taken = globals.calculate_lux_rooms()
	update_dislocations()
#	build_locations_list()
	#LocationsPanel.visible = (get_parent().mansion_state != "sex")
#	$population.visible = LocationsPanel.is_visible()
#	$food_consumption.visible = LocationsPanel.is_visible()
#	$BedroomLimit.visible = !LocationsPanel.is_visible()
#	$BedroomIcon.visible = !LocationsPanel.is_visible()
#	$SexLimit.visible = !LocationsPanel.is_visible()
#	$SexIcon.visible = !LocationsPanel.is_visible()
#	$DateLimit.visible = !LocationsPanel.is_visible()
#	$DateIcon.visible = !LocationsPanel.is_visible()
	$population.text = str(ResourceScripts.game_party.characters.size()) +"/" + str(ResourceScripts.game_res.get_pop_cap())

	$food_consumption.text = str(ResourceScripts.game_party.get_food_consumption()) + "/" + tr("MSLMDAY")
	input_handler.ClearContainer(CardContainer)
	input_handler.ClearContainer(RowContainer)
	CardContainer.set_meta("built_rows_signature", "")
	RowContainer.set_meta("built_rows_signature", "")
	mass_rule_list.clear()
	mass_service_list.clear()
	_select_slave_container()
	_ensure_selected_container_entries()
	apply_sorting()
	rows_signature = build_rows_signature()
	show_location_characters()
	update_description()
	update_header()


func _setup_entry_common(newbutton, person, person_id):
	newbutton.pressed = get_parent().active_person == person
	newbutton.set_meta('slave', person)
	newbutton.target_node = self
	newbutton.target_function = 'apply_manual_order'
	newbutton.arraydata = person_id
	newbutton.parentnodearray = ResourceScripts.game_party.character_order
	newbutton.connect('pressed', get_parent(), 'set_active_person', [person])
	newbutton.connect('gui_input', self, 'double_clicked', [newbutton])
	newbutton.connect('mouse_entered', get_parent(), 'set_hovered_person', [newbutton, person])
	newbutton.connect('mouse_exited_custom', get_parent(), 'remove_hovered_person')


func _apply_mansion_state_to_entry(person, newbutton):
	if newbutton.get_parent() == CardContainer:
		return
	match get_parent().mansion_state:
		"skill":
			build_for_skills(person, newbutton)
			newbutton.get_node("job").set_disabled(true)
			newbutton.get_node("job").set_mouse_filter(MOUSE_FILTER_IGNORE)
		"sex":
			build_for_sex(person, newbutton)


func _build_card_entry(person, person_id):
	var newbutton = input_handler.DuplicateContainerTemplate(CardContainer)
	_setup_entry_common(newbutton, person, person_id)
	newbutton.connect('pressed', self, '_on_card_expand_requested', [newbutton])
	_setup_card(newbutton, person)
	newbutton.connect('mouse_entered', self, '_set_card_hover', [newbutton, true])
	newbutton.connect('mouse_exited_custom', self, '_set_card_hover', [newbutton, false])
	newbutton.connect('toggled', self, '_on_card_toggled', [newbutton])
	update_entry_availability(newbutton, person, false)
	update_button(newbutton, 'default')
	_apply_mansion_state_to_entry(person, newbutton)


func _build_row_entry(person, person_id):
	var newbutton = input_handler.DuplicateContainerTemplate(RowContainer)
	_setup_entry_common(newbutton, person, person_id)
	for slot in ['rhand', 'lhand', 'chest', 'legs']:
		newbutton.get_node(slot).connect("pressed", self, 'OpenInventory', [person])
	newbutton.get_node("SpellIcon").connect("pressed", self, 'OpenSpells', [person])
	newbutton.get_node("SpellIcon").visible = false
	newbutton.get_node("job").connect("pressed", self, 'OpenJobModule', [person])
	for rl in ['lock', 'ration', 'shifts', 'constrain', 'luxury', 'contraceptive', 'nudity', 'personality_lock', 'relationship', 'masturbation']:
		var true_btn = newbutton.get_node('rule_' + rl)
		true_btn.connect('pressed', self, 'toggle_rules', [newbutton, rl])
		if rl != 'luxury':
			globals.connecttexttooltip(true_btn, "[center]" + tr("WORKRULE" + rl.to_upper()) + "[/center]\n" + person.translate(tr('WORKRULE%sDESCRIPT' % rl.to_upper())))
		mass_rule_list.append({
			btn_node = true_btn,
			act_func = 'toggle_rules_mass',
			act_args = [weakref(newbutton), rl]
		})
	for rl in ['waitress', 'hostess', 'dancer', 'stripper', 'males', 'females', 'futa', 'petting', 'oral', 'anal', 'pussy', 'group', 'sextoy']:
		var true_btn = newbutton.get_node('rule_' + rl)
		true_btn.connect('pressed', self, 'toggle_service', [newbutton, rl])
		globals.connecttexttooltip(true_btn, "[center]" + tr("BROTHEL" + rl.to_upper()) + "[/center]\n" + person.translate(tr('BROTHEL%sDESCRIPT' % rl.to_upper())))
		mass_service_list.append({
			btn_node = true_btn,
			act_func = 'toggle_service_mass',
			act_args = [weakref(newbutton), rl]
		})
	for f_id in ['meat', 'fish', 'grain', 'vegetables', 'bread', 'meatsoup', 'curry', 'friedfish', 'fishcakes']:
		newbutton.get_node('ff_' + f_id).connect('pressed', self, 'press_food', [newbutton, f_id])
	update_entry_availability(newbutton, person, false)
	update_button(newbutton, mode)
	_apply_mansion_state_to_entry(person, newbutton)


func update_entry_availability(newbutton, person, refresh_visual = true):
	var card_inventory = newbutton.get_node(CARD_ACTIONS + "/Inventory")
	if newbutton.get_parent() == CardContainer:
		newbutton.disabled = person.is_on_quest()
		card_inventory.disabled = person.is_on_quest()
		_update_card_action_states(newbutton, person)
		if refresh_visual:
			_refresh_card_visual(newbutton)
		return
	if person.is_on_quest():
		newbutton.disabled = true
		for slot in ['rhand', 'lhand', 'chest', 'legs']:
			newbutton.get_node(slot).disabled = true
		card_inventory.disabled = true
	else:
		newbutton.disabled = false
		if newbutton.get_parent() == RowContainer:
			newbutton.texture_normal = TEX_ROW_NORMAL
			newbutton.texture_hover = TEX_ROW_HOVER
		for slot in ['rhand', 'lhand', 'chest', 'legs']:
			newbutton.get_node(slot).disabled = false
		card_inventory.disabled = false
	_update_card_action_states(newbutton, person)
	if refresh_visual:
		_refresh_card_visual(newbutton)


var rows_signature = ""
var rebuild_queued = false
var task_refresh_queued = false


#task_removed is emitted once per deleted task, and ending a turn from the job panel
#deletes every unstaffed temporal job in one go - a dozen signals, a dozen full rebuilds,
#all inside the same frame. Fold a burst into a single rebuild.
#call_deferred is the engine's own batching primitive for this: the message queue is
#flushed once at the end of the frame, so the guard collapses N signals into one rebuild
#that still lands before anything is drawn, and there is no per-frame cost while idle.
#Direct rebuild() callers are untouched and stay synchronous.
func queue_rebuild():
	if rebuild_queued:
		return
	task_refresh_queued = false
	rebuild_queued = true
	call_deferred("flush_queued_rebuild")


func flush_queued_rebuild():
	rebuild_queued = false
	rebuild()


#Removing a job changes work labels and availability, not the roster or the entry tree.
#During a turn the normal post-turn refresh is already guaranteed, so avoid doing the same
#work once in the deferred signal flush and again before input is unlocked.
func queue_task_refresh():
	if task_refresh_queued or rebuild_queued:
		return
	task_refresh_queued = true
	call_deferred("flush_queued_task_refresh")


func flush_queued_task_refresh():
	if !task_refresh_queued:
		return
	task_refresh_queued = false
	if rebuild_queued:
		return
	if gui_controller.clock != null and is_instance_valid(gui_controller.clock) and gui_controller.clock.turn_in_progress:
		return
	if build_rows_signature() != rows_signature:
		rebuild()
	else:
		update()


#Covers everything that changes the cached entries themselves. The view mode only changes
#which already-built container and columns are visible, so it deliberately is not included.
func build_rows_signature():
	var res = str(get_parent().mansion_state)
	for id in ResourceScripts.game_party.character_order:
		res += "|" + str(id)
	return res


#Post-turn refresh keeps both cached views. Recreate them only when the roster or mansion
#state changed; ordinary mode switches and stat changes update the existing controls.
func refresh_after_turn(spread = false):
	if spread: #always a coroutine when asked for, so callers can yield on 'completed'
		yield(get_tree(), 'idle_frame')
	#A turn can change equipment and body state even while the preview is closed.
	expanded_paperdoll_cache_person_id = ""
	#The old non-default-mode clause forced a full unsliced rebuild every time a turn ended
	#from the job or craft panel; the cached lists only need their values refreshed.
	if build_rows_signature() != rows_signature:
		rebuild()
		return
	luxury_rooms_taken = globals.calculate_lux_rooms()
	update_dislocations()
	if spread:
		yield(get_tree(), 'idle_frame')
	var slice = OS.get_ticks_msec()
	for i in SlaveContainer.get_children():
		#a rebuild landing between chunks frees these nodes out from under us
		if !is_instance_valid(i) or i.is_queued_for_deletion() or !i.has_meta('slave'):
			continue
		update_entry_availability(i, i.get_meta('slave'), false)
		update_button(i)
		if spread and OS.get_ticks_msec() - slice >= variables.turn_frame_budget_msec:
			yield(get_tree(), 'idle_frame')
			slice = OS.get_ticks_msec()
	if is_instance_valid(expanded_card) and expanded_animation_state == "open":
		var expanded_person = expanded_card.get_meta("slave")
		ExpandedDetails.set_person(expanded_person)
		_build_expanded_body_preview(expanded_person, true)
		build_expanded_social_skills(expanded_person)
		build_expanded_rules(expanded_person)
		_create_expanded_card_visual()
	if spread:
		yield(get_tree(), 'idle_frame')
	apply_sorting() #occupations and exp moved on, so the sorted view has to follow
	show_location_characters()
	update_description()
	update_header()


func double_clicked(event, button):
	if !(event is InputEventMouseButton):
		return
	if event.button_index == BUTTON_RIGHT and event.pressed and !event.doubleclick:
		if expanded_card != null:
			close_expanded_character()
			return
		if button.disabled:
			return
#		event.accept_event()
		_show_character_context_menu(button)
		return
	if event.button_index == BUTTON_LEFT and event.doubleclick:
		if button.disabled:
			return
		get_parent().set_active_person(button.get_meta("slave"))
		get_parent().mansion_state = "char_info"


func _show_character_context_menu(button):
	if CharacterContextMenu == null:
		return
	var person = button.get_meta("slave")
	if person == null:
		return
	var actions = [
		{
			"label": tr("MSLMCONTEXT_OPEN"),
			"callback": funcref(self, "_context_open_person"),
			"args": [person]
		},
		{
			"label": tr("MSLMCONTEXT_INVENTORY"),
			"callback": funcref(self, "_context_open_with_inventory"),
			"args": [person]
		}
	]
	CharacterContextMenu.open_with_actions(person.get_short_name(), actions, get_viewport().get_mouse_position())


func _context_open_person(person):
	if get_parent() == null or !is_instance_valid(get_parent()):
		return
	get_parent().set_active_person(person)
	get_parent().mansion_state = "char_info"


func _context_open_with_inventory(person):
	get_parent().set_active_person(person)
	OpenInventory(person)


var locations_signature = ""

#runs on every hour_tick. The button list only has to be rebuilt when the set of populated
#locations actually changed, which is rare - otherwise just resync the pressed state
func update_dislocations():
	var temparray = []
	var has_training = false
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in ['mansion','travel'] && !temparray.has(person.travel.location):
			temparray.append(person.travel.location)
		if !has_training and person.get_work() == 'learning':
			has_training = true
	temparray.sort()
	populatedlocations = temparray
	var new_signature = str(has_training)
	for loca in temparray:
		new_signature += "|" + str(loca)
	if new_signature == locations_signature and LocationsList.get_child_count() > 1:
		update_location_buttons()
		return
	locations_signature = new_signature
	build_locations_list(has_training)


func build_locations_list(has_training = null):
	input_handler.ClearContainer(LocationsList)
	var newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
	newbutton.set_meta("location", "show_all")
	newbutton.text = tr("MSLMSHOWALL")
	newbutton.connect("pressed", self, "show_location_characters", [newbutton])
	var newseparator = $TravelsContainerPanel/VSeparator.duplicate()
	LocationsList.add_child(newseparator)
	newseparator.visible = true
	var sorted_locations = sort_locations()
	for loca in sorted_locations:
		if loca == null:
			continue
		newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
		if loca == 'aliron':
			newbutton.text = tr("MSLMMANSION")
		else:
			newbutton.text = ResourceScripts.world_gen.get_location_from_code(loca).name
		newbutton.set_meta("location", loca)
		newbutton.connect("pressed", self, "show_location_characters", [newbutton])
		newseparator = $TravelsContainerPanel/VSeparator.duplicate()
		LocationsList.add_child(newseparator)
		newseparator.visible = true
	
	var f = has_training
	if f == null: #called directly - work it out ourselves
		f = false
		for i in ResourceScripts.game_party.character_order:
			var person = ResourceScripts.game_party.characters[i]
			if person.get_work() == 'learning':
				f = true
				break

	if f:
		newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
		newbutton.text = "Training"
		newbutton.set_meta("location", 'training')
		newbutton.connect("pressed", self, "show_location_characters", [newbutton])
	else:
		LocationsList.get_children().back().queue_free()
	
	update_location_buttons()


func sort_locations():
	var capitals = []
	var settlements = []
	var dungeons = []
	var quest_locations = []
	var locations_array = populatedlocations
	for loca in locations_array:
		if loca == null:
			locations_array.erase(null)
			continue
		if loca in ["mansion", "travel", "show_all"]: continue
		match ResourceScripts.world_gen.get_location_from_code(loca).type:
			"capital":
				capitals.append(loca)
			"settlement":
				settlements.append(loca)
			"dungeon","encounter":
				dungeons.append(loca)
			"quest_location":
				quest_locations.append(loca)
	return capitals + settlements + dungeons + quest_locations


func build_for_sex(person, newbutton):
	var limit = calculate_sex_limits()
	var sex_participants = get_parent().sex_participants
	
	if mode != 'default':
		newbutton.texture_disabled = TEX_ROW_DISABLED
	
	if sex_participants.has(person):
		newbutton.pressed = true
	else:
		newbutton.pressed = false
		if sex_participants.size() >= limit:
			newbutton.disabled = true


func update_description():
	var sex_participants = get_parent().sex_participants
	$BedroomLimit.text = str(sex_participants.size()) +  '/' + str(calculate_sex_limits())
	$DateLimit.text = str(ResourceScripts.game_globals.weekly_dates_left) + "/" + str(ResourceScripts.game_globals.weekly_dates_max)
	$SexLimit.text = str(ResourceScripts.game_globals.weekly_sex_left) + "/" + str(ResourceScripts.game_globals.weekly_sex_max)


func calculate_sex_limits():
	if get_parent() != null && get_parent().get("in_test_mode") == true:
		return ResourceScripts.game_party.character_order.size()
	var slavelimit = 2
	if ResourceScripts.game_res.upgrades.has('master_bedroom'):
		slavelimit += ResourceScripts.game_res.upgrades.master_bedroom
	return slavelimit


func show_location_characters(button = null):
	if button != null:
		_close_expanded_character_immediate()
	if button != null:
		prev_selected_location = selected_location
		selected_location = button.get_meta("location")
#	update_location_buttons()
	visible_persons.clear()
	for person in SlaveContainer.get_children():
		if !person.has_meta('slave'):
			continue
		var person_reference = person.get_meta("slave")
		if person_reference == null:
			continue
		if selected_location == 'training':
			if person_reference.get_work() == 'learning':
				person.visible = true
			else:
				person.visible = false
		else:
			if person_reference.get_work() == 'learning':
				person.visible = false
				continue
#			if get_parent().mansion_state != 'sex': 
#				build_for_default(person_reference, person)
			var person_location = person_reference.travel.location
			if selected_location == "show_all":
				person.visible = true
			elif selected_location == "mansion" || selected_location == "aliron":
				if person_location == "mansion": person_location = "aliron"
				person.visible = person_location == "aliron"
			else:
				person.visible = (person_location == selected_location)
		if person.is_visible():
			visible_persons.append(person)
			if prev_selected_location != selected_location:
				for visible_person in visible_persons:
					visible_person.pressed = false
				get_parent().active_person = null
				if get_parent().mansion_state in ["default", "skills"]:
					get_parent().set_active_person(visible_persons[0].get_meta("slave"))
		if get_parent().mansion_state == "sex":
			person.visible = person_reference.travel.location == ResourceScripts.game_world.mansion_location
	
	if visible_persons.size() < 1 and selected_location != "show_all":
		selected_location = "show_all"
		show_location_characters()
	update_location_buttons()


func update_location_buttons():
	for i in LocationsList.get_children():
		if i == LocationsList.get_child(LocationsList.get_children().size()-1) || !i.has_meta('location'):
			continue
		i.pressed = selected_location == i.get_meta("location")


func build_for_skills(person, newbutton):
	if person == get_parent().skill_source:
		if mode != 'default':
			newbutton.texture_disabled = TEX_ROW_PRESSED
		newbutton.disabled = true
	if !person in get_parent().chars_for_skill:
		if mode != 'default':
			newbutton.texture_disabled = TEX_ROW_DISABLED
		newbutton.disabled = true
	else:
		if mode != 'default':
			newbutton.texture_normal = TEX_ROW_AVAIL
			newbutton.texture_hover = TEX_ROW_HOVER2
	newbutton.get_node("job").disabled = true
	_refresh_card_visual(newbutton)


var training_types = {
	nothing = 'No Training',
	slave_training = "Slave Training",
	slave_training_workforce = "Slave Training",
	slave_training_warrior = "Slave Training",
	slave_training_service = "Slave Training",
	academy = 'Academy',
	heir = 'Heir Education',
}


func remove_from_travel(person):
	get_parent().persons_for_travel.erase(person)
	rebuild()

var luxury_rooms_taken = 0
func update():
	luxury_rooms_taken = globals.calculate_lux_rooms()
	update_dislocations()
	_select_slave_container()
	_ensure_selected_container_entries()
#	get_parent().NavModule.build_accessible_locations()
	for i in SlaveContainer.get_children():
		if !i.has_meta('slave'):
			continue
		update_entry_availability(i, i.get_meta('slave'), false)
		update_button(i)
	if is_instance_valid(expanded_card) and expanded_animation_state == "open":
		var expanded_person = expanded_card.get_meta("slave")
		ExpandedDetails.set_person(expanded_person)
		_build_expanded_body_preview(expanded_person, true)
		build_expanded_social_skills(expanded_person)
		build_expanded_rules(expanded_person)
		_create_expanded_card_visual()
	apply_sorting()
	update_buttons()
	show_location_characters()
	update_description()
	update_header()
	match_mode()
	if mode == 'rules':
		input_handler.start_mass_select(self, mass_rule_list)
	elif mode == 'brothel':
		input_handler.start_mass_select(self, mass_service_list)
	else:
		input_handler.stop_mass_select()


func update_button(newbutton, t_mode = mode):
	var person_location
	if newbutton.name == 'Button':
		return
	var person = newbutton.get_meta('slave')
	if newbutton.get_parent() == CardContainer:
		_update_card_button(newbutton, person)
		return
	if person.get_work() == 'learning':
		newbutton.get_node('progress').value = variables.tutduration - person.get_quest_time_remains()
		newbutton.get_node('progress').max_value = variables.tutduration
	newbutton.get_node("icon").texture = person.get_icon_small()
	newbutton.get_node("name").text = person.get_short_name()
	newbutton.get_node(CARD_PORTRAIT).texture = person.get_icon()
	input_handler.queue_portrait(person) #most of a mansion never had a shot taken at all
	newbutton.get_node(CARD_ROOT + "/Header/Name").text = person.get_short_name()
	newbutton.get_node(CARD_SEX).texture = images.get_icon(person.get_stat('sex'))
	var race_icon = races.racelist[person.get_stat('race')].icon
	if race_icon is String:
		race_icon = load(race_icon)
	newbutton.get_node(CARD_RACE).texture = race_icon
	if person.is_master() or person.is_unique():
		newbutton.get_node("name").set("custom_colors/font_color", variables.hexcolordict.unique)
		newbutton.get_node(CARD_ROOT + "/Header/Name").set("custom_colors/font_color", variables.hexcolordict.unique)
	else:
		newbutton.get_node(CARD_ROOT + "/Header/Name").set("custom_colors/font_color", Color(0.878431, 0.878431, 0.878431))
	newbutton.get_node("sex").texture = images.get_icon(person.get_stat('sex'))
	var job_label = newbutton.get_node("job/Label")
	_set_job_label_color_from_key(job_label, JOB_COLOR_DEFAULT)
	var work_code = person.get_work()
	var is_traveling = person.travel.location == "travel" || person.check_location('travel') || work_code == 'travel'
	
	newbutton.get_node("stats/hp").max_value = person.get_stat('hpmax')
	newbutton.get_node("stats/hp").value = person.hp
	newbutton.get_node("stats/mp").max_value = person.get_stat('mpmax')
	newbutton.get_node("stats/mp").value = person.mp
	newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
	newbutton.get_node("explabel").text = str(floor(person.get_stat('base_exp')))
	_update_card_progress(newbutton.get_node(CARD_HP_BAR), tr("STATHP"), person.hp, person.get_stat('hpmax'))
	_update_card_progress(newbutton.get_node(CARD_MP_BAR), tr("STATMP"), person.mp, person.get_stat('mpmax'))
	var lust_bar = newbutton.get_node(CARD_LUST_BAR)
	lust_bar.visible = person.check_trait('succubus')
	if lust_bar.visible:
		_update_card_progress(lust_bar, tr("STATLUST"), person.get_stat('lust'), person.get_stat('lustmax'))
	if is_traveling:
		job_label.text = tr("TASKTRAVEL")
		_set_job_label_color_from_key(job_label, JOB_COLOR_TRAVEL)
	elif work_code == '' or !person.is_avaliable():
		if person.is_on_quest():
			var time_left = int(person.get_quest_time_remains())
			if time_left > 0:
				var time_left_string = ''
				if time_left == 1:
					time_left = 4 - ResourceScripts.game_globals.hour
					time_left_string = str(time_left) + " turns"
				else:
					time_left_string = str(time_left) + " d."
				job_label.text = "On Quest: " + time_left_string
			else:
				job_label.text = person.get_unaval_string()
		else:
			job_label.text = tr("TASKREST")
			_set_job_label_color_from_key(job_label, JOB_COLOR_REST)
	elif work_code == 'learning':
		newbutton.get_node('progress').value = variables.tutduration - person.get_quest_time_remains()
		job_label.text = tr("SIBLINGMODULETRAININGS")
#	elif work_code == 'special':
#		var task = person.find_worktask()
#		job_label.text = tr("TASKMISSION")
	else:
		var task = person.find_worktask()
		if work_code == 'crafting':
			var predict_task_id = person.predict_active_task()
			if predict_task_id == null:
				job_label.text = tr('TASKREST')
			else:
				var predict_task = ResourceScripts.game_res.tasks_progresses[predict_task_id]
				var predict_task_cat = predict_task.job
				if predict_task_cat != 'building':
					predict_task_cat = predict_task_cat.trim_suffix('_item')
					predict_task_cat = predict_task_cat.trim_suffix('_material')
				var predict_job = tasks.tasklist[predict_task_cat]
				job_label.text = tr(predict_job.name)
				if predict_job.has('mod'):
					_apply_task_color(job_label, predict_job.mod)
		else:
			job_label.text = tr(task.name)
			if task.has('mod'):
				_apply_task_color(job_label, task.mod)
	
	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(1,1,1))
	# if !person.check_location('Aliron'):
	#location
	_reset_card_location_strip(newbutton)
	if !person.is_avaliable():
		newbutton.get_node('LocIcon').texture = null
		_set_card_location_strip(newbutton, null, person.get_unaval_string())
		person_location = null
	elif person.check_location('travel'):
		newbutton.get_node('LocIcon').texture = TEX_TRAVEL_SMALL
		newbutton.get_node('LocIcon').hint_tooltip = tr("MSLMRELOC") + ": " + tr("MSLMRE") + " " + str(ceil(person.travel.travel_time / person.travel_per_tick())) + tr("MSLMTURN") + ". "
		var travel_texture = _get_navigation_location_texture(person.travel.travel_target.location)
		if travel_texture == null:
			travel_texture = TEX_TRAVEL_SMALL
		_set_card_location_strip(newbutton, travel_texture, tr("TASKTRAVEL"), newbutton.get_node('LocIcon').hint_tooltip)
		person_location = null
		
	elif person.check_location('aliron') || person.get_location() == "mansion":
		_set_card_location_strip(
			newbutton,
			_get_navigation_location_texture("mansion"),
			tr("MANSION_LABEL")
		)
		person_location = null
	else:
		person_location = person.get_location()

	if person_location != null:
		var ploc = ResourceScripts.world_gen.get_location_from_code(person_location)
		if ploc != null: 
			match ploc.type:
				'settlement':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_village')
				'dungeon':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_dungeon')
				'capital':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_city')
				'quest_location', 'encounter':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_event')
			newbutton.get_node('LocIcon').hint_tooltip = tr(ploc.name)
			_set_card_location_strip(newbutton, _get_navigation_location_texture(person_location), tr(ploc.name))
			#newbutton.get_node('Location').text = tr(ploc.name)
	#job
	var job_button = newbutton.get_node("job")
	job_button.disabled = false
	if !person.is_worker(): #for conditions for work and combat are the same
		job_button.disabled = true
		_set_job_label_color_from_key(job_label, 'red')
		if person.get_stat('slave_class') == 'slave':
			globals.connecttexttooltip(job_button, person.translate(tr('TRAINNOTRAINER')))
		else:
			globals.connecttexttooltip(job_button, person.translate(tr('TRAINNOWORKTRAIT')))
	elif person.travel.location == "travel" || person.is_on_quest():
		job_button.disabled = true
	#class
	newbutton.get_node("state").texture = person.get_class_icon()
	newbutton.get_node(CARD_STATUS).texture = person.get_class_icon()
	#gear
	for slot in ['rhand', 'lhand', 'chest', 'legs']:
		var titem = person.equipment.gear[slot]
		_update_gear_slot(newbutton.get_node(slot), titem)
	
	#checks
	if ResourceScripts.game_globals.weekly_dates_left <= 0:
		newbutton.get_node("DateIcon").texture = TEX_NO
	elif !person.has_status('relation'):
		newbutton.get_node("DateIcon").texture = TEX_NO
	elif person.tags.has("no_date_day"):
		newbutton.get_node("DateIcon").texture = TEX_NO
	else:
		newbutton.get_node("DateIcon").texture = TEX_YES
	if ResourceScripts.game_globals.weekly_sex_left <= 0:
		newbutton.get_node("SexIcon").texture = TEX_NO
	elif person.has_status('no_sex'):
		newbutton.get_node("SexIcon").texture = TEX_NO
	else:
		newbutton.get_node("SexIcon").texture = TEX_YES
	if !person.can_be_trained():
		newbutton.get_node("TrainIcon").texture = TEX_NO
	else:
		newbutton.get_node("TrainIcon").texture = TEX_YES
	_update_card_action_states(newbutton, person)
	
	#rules
	for rl in ['lock', 'ration', 'shifts', 'constrain', 'luxury', 'contraceptive', 'nudity', 'personality_lock', 'relationship', 'masturbation']:
		newbutton.get_node('rule_' + rl).pressed = person.check_work_rule(rl)
#	newbutton.get_node('rule_luxury').visible = !person.is_master()
	newbutton.get_node('rule_luxury').disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) and !person.check_work_rule("luxury") or person.is_master()
	var text = "[center]"+tr("WORKRULELUXURY") + "[/center]\n" + person.translate(tr('WORKRULELUXURYDESCRIPT'))
	text += "\n"
	text += "Rooms used %d/%d" % [luxury_rooms_taken, ResourceScripts.game_res.upgrades.luxury_rooms + 1]
	globals.connecttexttooltip(newbutton.get_node('rule_luxury'), text)
	newbutton.get_node('rule_relationship').disabled = person.is_master()
	newbutton.get_node('rule_nudity').disabled = !person.has_status('sexservice')
	newbutton.get_node('rule_contraceptive').disabled = person.check_trait('undead')
	newbutton.get_node('rule_ration').disabled = person.check_trait('undead')
	#services
	for rl in ['petting', 'oral', 'anal', 'pussy', 'group', 'sextoy']:
		newbutton.get_node('rule_' + rl).pressed = person.check_brothel_rule(rl)
		if person.is_master() == false:
			if !person.has_status(tasks.gold_tasks_data[rl].req_training):
				if person.get_stat('slave_class') == 'slave':
					newbutton.get_node('rule_' + rl).disabled = true
	for rl in ['waitress', 'hostess', 'dancer', 'stripper', 'males', 'females', 'futa']:
		newbutton.get_node('rule_' + rl).pressed = person.check_brothel_rule(rl)
	#food. the per-character tooltips need a fresh demand, which is expensive, so they are
	#only built while the food column is actually on screen
	if t_mode == 'food':
		person.get_food_demand()
	for f_id in ['meat', 'fish', 'grain', 'vegetables', 'bread', 'meatsoup', 'curry', 'friedfish', 'fishcakes']:
		var allowed = person.get_filter_for_food(f_id)
		var label = newbutton.get_node('ff_%s/Label' % f_id)
		label.text = tr("FOODFILTERALLOWED" if allowed else "FOODFILTERFORBIDDEN")
		label.set("custom_colors/font_color", Color(variables.hexcolordict['green' if allowed else 'gray']))
		if t_mode == 'food':
			globals.connectmaterialtooltip(newbutton.get_node('ff_' + f_id), Items.materiallist[f_id],
				globals.get_food_char_text(Items.materiallist[f_id], person))
	#The card and legacy row trees are cached; only the selected presentation is shown.
	for nd in newbutton.get_children():
		if nd.name == "CardLayout":
			nd.visible = t_mode == 'default'
		elif t_mode == 'default':
			nd.visible = false
		else:
			nd.visible = nd.is_in_group(t_mode)
	
	#postprocess
	if person.is_master():
		newbutton.get_node('DateIcon').visible = false
		newbutton.get_node('rule_luxury').visible = false
		newbutton.get_node('rule_relationship').visible = false
		newbutton.get_node('rule_constrain').visible = false
	if person.check_trait('undead'):
		newbutton.get_node('rule_contraceptive').visible = false
		newbutton.get_node('rule_ration').visible = false
	update_food_icon(newbutton, person)
	_update_card_work_type(newbutton, person, job_label.text)
	newbutton.get_node(CARD_WORK_LABEL).set("custom_colors/font_color", job_label.get("custom_colors/font_color"))
	var card_work = newbutton.get_node(CARD_ACTIONS + "/Work")
	_set_card_action_available(card_work, !newbutton.get_node("job").disabled)
	var work_tooltip = tr("LMMWORK") + ": " + job_label.text
	if card_work.disabled:
		if person.is_on_quest():
			work_tooltip += "\n" + person.translate(tr("ONQUESTLABEL"))
		elif person.travel.location == "travel":
			work_tooltip += "\n" + tr("TASKTRAVEL")
		elif person.get_stat('slave_class') == 'slave':
			work_tooltip += "\n" + person.translate(tr("TRAINNOTRAINER"))
		else:
			work_tooltip += "\n" + person.translate(tr("TRAINNOWORKTRAIT"))
	globals.connecttexttooltip(card_work, work_tooltip)
	globals.connecttexttooltip(newbutton.get_node(CARD_SEX), tr("MSLMSex") + ": " + tr("SLAVESEX" + person.get_stat('sex').to_upper()))
	globals.connecttexttooltip(newbutton.get_node(CARD_STATUS), _get_character_type_tooltip(person))
	globals.connecttexttooltip(newbutton.get_node(CARD_RACE), "[center]{color=green|" + races.racelist[person.get_stat('race')].name + "}[/center]\n\n" + person.show_race_description())
	_refresh_card_visual(newbutton)


func _update_card_progress(bar, label, value, max_value):
	bar.max_value = max(max_value, 1)
	bar.value = value
	_set_card_text_tooltip(bar, "%s %d/%d" % [label, int(round(value)), int(round(max_value))])


func _update_gear_slot(slot_node, item_id):
	if item_id == null:
		slot_node.get_node("icon").texture = null
		slot_node.get_node("quality_color").hide()
		return
	var item = ResourceScripts.game_res.items[item_id]
	item.set_icon(slot_node.get_node("icon"))
	if item.quality != "":
		slot_node.get_node("quality_color").show()
		slot_node.get_node("quality_color").texture = variables.quality_colors[item.quality]
	else:
		slot_node.get_node("quality_color").hide()
	globals.connectitemtooltip_v2(slot_node, item)


#the food column shows what the character is running on right now - the item they last ate,
#tinted red when it was below their demand, or the starvation icon when they went without.
#the cell frame always keeps its place in the row; states with no meal leave it empty
func update_food_icon(newbutton, person):
	var state = person.food.get_state()
	for node in [newbutton.get_node('FoodIcon')]:
		if !node.is_visible_in_tree():
			continue
		var icon = node.get_node('icon')
		icon.visible = true
		icon.modulate = Color(1, 1, 1)
		match state.state:
			'undead', 'none':
				icon.visible = false
			'starving':
				icon.texture = TEX_FOOD_STARVING
			'poor':
				icon.texture = Items.materiallist[state.meal].icon
				icon.modulate = Color(1, 0.5, 0.5)
			_:
				icon.texture = Items.materiallist[state.meal].icon
		globals.connecttexttooltip(node, globals.get_food_state_tooltip(person))


func set_mode(newmode):
	_close_expanded_character_immediate()
	mode = newmode
	update()


func update_header ():
	header.visible = mode != 'default'
	for nd in header.get_children():
		nd.visible = nd.is_in_group(mode)


### Sorting ###

func build_sort_headers():
	for key in SORT_COLUMNS:
		var nd = header.get_node(SORT_COLUMNS[key].node)
		nd.mouse_filter = MOUSE_FILTER_STOP
		nd.mouse_default_cursor_shape = CURSOR_POINTING_HAND
		nd.connect('gui_input', self, 'sort_header_input', [key])
		nd.connect('mouse_entered', self, 'sort_header_hover', [key, true])
		nd.connect('mouse_exited', self, 'sort_header_hover', [key, false])
		if SORT_COLUMNS[key].icon: #those already carry a tooltip explaining the column
			nd.hint_tooltip = tr(nd.hint_tooltip) + "\n" + tr("MSLMSORTHINT")
		else:
			globals.connecttexttooltip(nd, tr("MSLMSORTHINT"))
	update_sort_headers()


#a column cycles through ascending, descending and back to the order the player set by hand
func sort_header_input(event, key):
	if !(event is InputEventMouseButton) or event.button_index != BUTTON_LEFT or !event.pressed:
		return
	if sort_key != key:
		sort_key = key
		sort_desc = false
	elif !sort_desc:
		sort_desc = true
	else:
		sort_key = ''
		sort_desc = false
	apply_sorting()
	update_sort_headers()


func sort_header_hover(key, hovered):
	if hovered:
		sort_hovered = key
	elif sort_hovered == key:
		sort_hovered = ''
	update_sort_header(key)


func update_sort_headers():
	if header == null:
		return
	for key in SORT_COLUMNS:
		update_sort_header(key)


func update_sort_header(key):
	var nd = header.get_node(SORT_COLUMNS[key].node)
	var color = SORT_COLOR_IDLE
	if sort_key == key:
		color = Color(variables.hexcolordict['factor2' if sort_desc else 'k_yellow'])
	elif sort_hovered == key:
		color = SORT_COLOR_HOVER
	if SORT_COLUMNS[key].icon:
		nd.modulate = color
	else:
		nd.set("custom_colors/font_color", color)


#rows are only moved around, never the array behind them. dragging a row would write the visual
#position back into character_order, so it stays off while a column is sorted
func apply_sorting():
	if SlaveContainer == null:
		return
	var entries = []
	for nd in SlaveContainer.get_children():
		if !nd.has_meta('slave'):
			continue
		nd.drag_enabled = sort_key == ''
		entries.append({row = nd, base = get_row_base_index(nd), value = null})
	if sort_key == '':
		entries.sort_custom(self, 'compare_base_rows')
	else:
		for e in entries:
			e.value = get_sort_value(e.row, sort_key)
		entries.sort_custom(self, 'compare_sort_rows')
	for i in entries.size():
		if entries[i].row.get_index() != i:
			SlaveContainer.move_child(entries[i].row, i)


func apply_manual_order():
	if sort_key == '':
		apply_sorting()


func reset_sorting():
	sort_key = SORT_MENU_KEYS[0]
	sort_desc = false
	sort_hovered = ''
	apply_sorting()
	update_sort_headers()
	_sync_sort_menu()


func get_row_base_index(row):
	var idx = ResourceScripts.game_party.character_order.find(row.arraydata)
	return idx if idx >= 0 else ResourceScripts.game_party.character_order.size()


func compare_base_rows(a, b):
	return a.base < b.base


#ties keep the manual order, so rows with the same value never shuffle between sorts
func compare_sort_rows(a, b):
	if a.value != b.value:
		if sort_desc:
			return a.value > b.value
		return a.value < b.value
	return a.base < b.base


#occupation and the availability marks are read back from the row: they are the strings and
#icons update_button just worked out, and recomputing them here would only duplicate that logic
func get_sort_value(row, key):
	var person = row.get_meta('slave')
	match key:
		'sex':
			return get_sort_rank(SORT_SEX_ORDER, person.get_stat('sex'))
		'name':
			return person.get_short_name().to_lower()
		'occupation':
			if row.get_parent() == CardContainer:
				return str(row.get_meta("card_job_text", "")).to_lower()
			return row.get_node("job/Label").text.to_lower()
		'train_available':
			var incomplete_slave_training = person.training.is_slave() and person.training.enable
			return 0 if incomplete_slave_training and _get_training_availability(person)[0] else 1
		'date_available':
			return 0 if _get_date_availability(person)[0] else 1
		'levelup':
			return 0 if _can_progress_person(person) else 1
		'exp':
			return floor(person.get_stat('base_exp'))
		'date':
			return 0 if row.get_node("DateIcon").texture == TEX_YES else 1
		'sexact':
			return 0 if row.get_node("SexIcon").texture == TEX_YES else 1
		'train':
			return 0 if row.get_node("TrainIcon").texture == TEX_YES else 1
		'type':
			return get_sort_rank(SORT_CLASS_ORDER, person.get_stat('slave_class'))
	return 0


func get_sort_rank(order, value):
	var idx = order.find(value)
	return idx if idx >= 0 else order.size()


func toggle_rules(newbutton, code):
	var person = newbutton.get_meta('slave')
	var cvalue = person.check_work_rule(code)
	var nvalue = !cvalue
	person.set_work_rule(code, nvalue)
	update()
#	update_button(newbutton)

func toggle_rules_mass(newbutton_ref, code):
	var newbutton = newbutton_ref.get_ref()
	var true_btn = newbutton.get_node('rule_' + code)
	if (true_btn.disabled
			or (mass_select_press_effect != null and true_btn.pressed == mass_select_press_effect)
		):
		return
	toggle_rules(newbutton, code)
	if mass_select_press_effect == null:
		mass_select_press_effect = true_btn.pressed


func toggle_service(newbutton, code):
	var person = newbutton.get_meta('slave')
	var cvalue = person.check_brothel_rule(code)
	var nvalue = !cvalue
	person.set_brothel_rule(code, nvalue)
	update_button(newbutton)

func toggle_service_mass(newbutton_ref, code):
	var newbutton = newbutton_ref.get_ref()
	var true_btn = newbutton.get_node('rule_' + code)
	if (true_btn.disabled
			or (mass_select_press_effect != null and true_btn.pressed == mass_select_press_effect)
		):
		return
	toggle_service(newbutton, code)
	if mass_select_press_effect == null:
		mass_select_press_effect = true_btn.pressed


func press_food(newbutton, code):
	var person = newbutton.get_meta('slave')
	person.toggle_food(code)
	update_button(newbutton)


func match_mode():
	for nd in modes.get_children():
		nd.pressed = (mode == nd.name)
