extends Control

#Training used to be a tab buried in the character info window. It opens straight off the
#mansion card now, and it carries every route a character can take: the master's own upgrade
#tree, a servant's negotiated unlocks, a slave's training under a trainer, the rewards a
#finished slave can buy, the succubus thrall tree, and the minor trainings everybody shares.
#Which page a character lands on is decided by slave_class, the same way the old tab selector
#decided which of its four panels to show.
#
#The window is not one fixed size: each page asks for the room it needs, so a servant's five
#unlock rows do not sit in a window built for a slave's six action sections.

const TAB_PAGES = {
	"trainings": "Training",
	"master_upg": "MasterUpg",
	"minor_upg": "MinorUpg",
	"succubus": "Succubus",
}
#the classes that have a training route at all - a spouse has none, and the master has a tree
#of their own instead
const TRAINING_CLASSES = ["slave", "slave_trained", "servant", "servant_notax", "heir"]

#the trainings page varies with the character's situation, so it reports its own size
const PAGE_SIZES = {
	"master_upg": Vector2(760, 780),
	"minor_upg": Vector2(760, 1000),
	"succubus": Vector2(1040, 900),
}
const DEFAULT_SIZE = Vector2(860, 880)
#The character is not part of the panel: they stand full height down the right of the screen
#and the window is centred in what is left, so the two never overlap. The band is as wide as
#the slave list's own body preview so the figure is framed the same way, and it is held off
#the screen edge so the character sits in the empty space rather than against the border.
const PORTRAIT_BAND = 600.0
const PORTRAIT_EDGE_INSET = 50.0

onready var pages = $Popup/Pages
onready var tab_rail = $Popup/TabRail
onready var portrait_slot = $Portrait
onready var portrait_image = $Portrait/StoredImage
onready var portrait_doll = $Portrait/Paperdoll
onready var training_page = $Popup/Pages/Training
onready var master_page = $Popup/Pages/MasterUpg/UpgradesList2
onready var minor_page = $Popup/Pages/MinorUpg/UpgradesList3
onready var succubus_page = $Popup/Pages/Succubus

var person
var current_tab = ""
var current_size = DEFAULT_SIZE
var clock_was_visible = false
var popup_target_position = Vector2.ZERO
var pages_target_position = Vector2.ZERO
var open_sequence = 0
#rebuilding the doll is the expensive part of opening, so it is skipped when nothing changed
var doll_cache_person_id = ""
var doll_cache_clothed = true
#the doll fits itself to its rect only while being rebuilt, and the rect moves with the window
var doll_cache_size = Vector2.ZERO


func _ready():
	$Popup/CloseButton.connect("pressed", self, "close")
	for tab in TAB_PAGES:
		tab_rail.get_node(tab).connect("pressed", self, "open_tab", [tab])
	pages_target_position = pages.rect_position
	training_page.root = self
	master_page.root = self
	minor_page.root = self
	succubus_page.root = self
	globals.connecttexttooltip(tab_rail.get_node("master_upg"), tr("SIBLINGMODULETRAININGSMASTER"))
	globals.connecttexttooltip(tab_rail.get_node("succubus"), tr("SIBLINGMODULESUCCUBUS"))
	globals.connecttexttooltip(tab_rail.get_node("trainings"), tr("SIBLINGMODULETRAININGS"))
	globals.connecttexttooltip(tab_rail.get_node("minor_upg"), tr("SIBLINGMODULEMINORTRAINING"))
	apply_popup_size(current_size)
	_reset_popup_visuals()
	hide()
	#the tutorial used to reach these through the character info window
	input_handler.register_btn_source("minor_upg", self, "tut_get_minor_upg")
	input_handler.register_btn_source("training_tab", self, "tut_get_training_tab")
	#the tutorial ends its training chapter in this window, so this is the one it teaches
	#the player to close - it used to be the character window's cross
	input_handler.register_btn_source("training_close_button", self, "tut_get_close_button")


func tut_get_minor_upg():
	return tab_rail.get_node("minor_upg")


func tut_get_training_tab():
	return tab_rail.get_node("trainings")


func tut_get_close_button():
	return $Popup/CloseButton


func has_training_page(t_person):
	return t_person.get_stat('slave_class') in TRAINING_CLASSES and !t_person.is_master()


func available_tabs():
	if person == null:
		return []
	var list = []
	if person.is_master():
		list.append("master_upg")
	if has_training_page(person):
		list.append("trainings")
	if person.check_trait("succubus"):
		list.append("succubus")
	list.append("minor_upg")
	return list


func default_tab():
	#same order the character info window used: the master's tree wins, then the thrall tree,
	#then plain training
	var tabs = available_tabs()
	for tab in ["master_upg", "succubus", "trainings", "minor_upg"]:
		if tab in tabs:
			return tab
	return "minor_upg"


func open(t_person, tab = null):
	if t_person == null:
		return
	person = t_person
	input_handler.interacted_character = person
	open_sequence += 1
	var sequence = open_sequence
	_build_header()
	show()
	raise()
	_hide_clock()
	portrait_slot.show()
	if tab == null or !(tab in available_tabs()):
		tab = default_tab()
	open_tab(tab, false)
	call_deferred("build_portrait")
	call_deferred("_play_open_animation", sequence)
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)


func close():
	open_sequence += 1
	$Popup/Tween.stop_all()
	$Popup/Tween.remove_all()
	_reset_popup_visuals()
	hide()
	portrait_slot.hide()
	set_process(false)
	gui_controller.windows_opened.erase(self)
	_restore_clock()


func _custom_gui_controller_close():
	close()


#the succubus tree lets the player click through to a thrall, which means swapping the whole
#popup over to that character rather than only redrawing the page
func switch_character(newchar):
	if newchar == null:
		return
	input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP).hide()
	open(newchar, current_tab)


func open_tab(tab, animate = true):
	if person == null:
		return
	if !(tab in available_tabs()):
		tab = default_tab()
	current_tab = tab
	for id in TAB_PAGES:
		tab_rail.get_node(id).pressed = id == tab
		pages.get_node(TAB_PAGES[id]).visible = id == tab
	match tab:
		"trainings":
			training_page.person = person
			training_page.match_state()
		"master_upg":
			master_page.update_upgrades_tree()
		"minor_upg":
			minor_page.set_person(person)
			minor_page.update_upgrades_tree()
		"succubus":
			succubus_page.set_person(person)
	update_footer()
	refresh_size()
	if animate and visible:
		_play_tab_animation()


#Every page asks for its own window size - the trainings page even varies by state, since a
#servant's unlock list needs a fraction of the room a slave's action grid does.
func desired_size():
	if current_tab == "trainings":
		return training_page.desired_size()
	if PAGE_SIZES.has(current_tab):
		return PAGE_SIZES[current_tab]
	return DEFAULT_SIZE


func refresh_size():
	apply_popup_size(desired_size())


func apply_popup_size(size):
	var changed = current_size != size
	current_size = size
	#The window is pushed up against the character rather than floating in the middle of what is
	#left over: its right edge meets the left edge of the portrait band, and the band does not
	#move. Popup is anchored to the right of the screen, so this holds whatever size it takes.
	$Popup.margin_right = -(PORTRAIT_BAND + PORTRAIT_EDGE_INSET)
	$Popup.margin_left = $Popup.margin_right - size.x
	$Popup.margin_top = -size.y * 0.5
	$Popup.margin_bottom = size.y * 0.5
	$Popup.rect_pivot_offset = size * 0.5
	#rect_position only catches up on the next layout pass, and the open animation reads this
	#straight away - so work it out from the anchors instead of asking for it back
	popup_target_position = Vector2(
		rect_size.x + $Popup.margin_left,
		rect_size.y * 0.5 + $Popup.margin_top
	)
	#the portrait column just changed shape, and the doll only refits while it is rebuilt
	if changed and visible and person != null:
		call_deferred("build_portrait")


#the contract the pages call as root.update() after they spend a currency
func update():
	if person == null or !visible:
		return
	if !person.is_active:
		close()
		return
	_build_header()
	open_tab(current_tab, false)
	call_deferred("build_portrait")


#the contract custom_effects.negotiation_refresh_panel() and the pages call to redraw the
#training state without rebuilding the rest of the popup
func match_state():
	if person == null or !visible:
		return
	if current_tab == "trainings":
		training_page.match_state()
	update_footer()
	refresh_size()


func _build_header():
	$Popup/Header/CharacterName.text = person.get_full_name()
	$Popup/Header/ClassIcon.texture = person.get_class_icon()
	globals.connecttexttooltip($Popup/Header/ClassIcon, _class_tooltip())
	var tabs = available_tabs()
	for id in TAB_PAGES:
		tab_rail.get_node(id).visible = id in tabs


#The full-height picture beside the pages. Same source order the mansion card uses: a stored
#body image wins, then the doll, then the plain silhouette, with a unique character's own
#sprite overriding all of it.
func build_portrait():
	if person == null:
		return
	portrait_image.visible = false
	portrait_doll.visible = false
	var texture = person.get_stored_body_image()
	var unique_code = person.get_stat("unique")
	if person.uses_paperdoll(): #switched to the doll, so none of their own sprites apply
		unique_code = null
	if unique_code != null and worlddata.pregen_character_sprites.has(unique_code):
		var sprite_data = worlddata.pregen_character_sprites[unique_code]
		if person.has_work_rule("nudity") and sprite_data.has("nude"):
			texture = images.get_sprite(sprite_data.nude.path)
		if ResourceScripts.game_progress.spouse != null and !ResourceScripts.game_progress.marriage_completed:
			var spouse_person = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
			if spouse_person != null and spouse_person.get_stat("unique") == unique_code and sprite_data.has("wed"):
				texture = images.get_sprite(sprite_data.wed.path)
	if texture != null:
		portrait_image.texture = texture
		_fit_sprite_to_band(texture)
		portrait_image.visible = true
		return
	if !input_handler.globalsettings.disable_paperdoll:
		var clothed = !person.has_work_rule("nudity")
		portrait_doll.visible = true
		portrait_doll.test_mode = false
		if doll_cache_person_id != str(person.id) or doll_cache_clothed != clothed \
				or doll_cache_size != portrait_slot.rect_size or portrait_doll.character != person:
			portrait_doll.rebuild(person)
			portrait_doll.rebuild_cloth(clothed)
			doll_cache_person_id = str(person.id)
			doll_cache_clothed = clothed
			doll_cache_size = portrait_slot.rect_size
		return
	var silhouette = person.get_body_image()
	if silhouette != null:
		portrait_image.texture = silhouette
		_fit_sprite_to_band(silhouette)
		portrait_image.visible = true


#A drawn sprite has no doll to stand itself on the floor, so it is fitted to the band by hand:
#scaled to whichever edge it meets first, centred across, and pinned to the bottom.
func _fit_sprite_to_band(texture):
	var band = portrait_slot.rect_size
	var source = texture.get_size()
	if source.x <= 0 or source.y <= 0 or band.x <= 0 or band.y <= 0:
		return
	var fit = min(band.x / source.x, band.y / source.y)
	var shown = source * fit
	var side = (band.x - shown.x) * 0.5
	portrait_image.margin_left = side
	portrait_image.margin_right = -side
	portrait_image.margin_top = band.y - shown.y
	portrait_image.margin_bottom = 0


func _class_tooltip():
	var code = "CHARTYPE" + person.get_stat('slave_class').to_upper()
	var title = code
	if person.get_stat('sex') != 'male':
		title += "F"
	return "[center]{color=yellow|" + tr(title) + "}[/center]\n" + person.translate(tr(code + "DESCRIPT"))


func update_footer():
	var points = ""
	var hint = ""
	match current_tab:
		"master_upg":
			points = "%s: %d" % [tr("MASTER_POINTS"), ResourceScripts.game_progress.master_points]
		"minor_upg":
			points = "%s: %d/%d    %s: %d" % [
				tr("SIBLINGMODULEAVAILABLE"),
				person.get_minor_training_count(), person.get_minor_training_max(),
				tr("UPGRADELIST_UNLOCK_GOLD"), ResourceScripts.game_res.money
			]
		"succubus":
			points = "%s: %d" % [tr(statdata.statdata.thrall_points.name), person.get_stat('thrall_points')]
		_:
			if person.training.is_servant():
				points = tr("SIBLINGMODULETRAININGSSERVANTS")
			else:
				points = tr("TRAININGLABELLOYALTY") % [
					floor(person.get_stat('training_points')),
					person.training.get_training_points_cap()
				]
			hint = _training_hint()
	$Popup/Footer/Points.text = points
	$Popup/Footer/Hint.text = hint
	globals.connecttexttooltip($Popup/Footer/Points, _footer_tooltip())


func _footer_tooltip():
	match current_tab:
		"master_upg":
			return tr("TOOLTIPMASTERTRAINING")
		"minor_upg":
			return tr("SIBLINGMODULEAVAILABLETOOLTIP")
		"succubus":
			return person.translate(tr("TOOLTIPSUCCUBUS"))
		_:
			return tr("TRAININGPOINTSTOOLTIP")


#a short note on why nothing can be done today - the same reasons the card's Training button
#reports, said once here instead of on every greyed-out action
func _training_hint():
	#the page owns the rules; asking it keeps the note and the greyed-out buttons in step
	return training_page.blocking_note()


func _play_open_animation(sequence):
	if !visible or sequence != open_sequence:
		return
	var popup = $Popup
	var tween = $Popup/Tween
	tween.stop_all()
	tween.remove_all()
	var target_position = popup_target_position
	popup.rect_position = target_position + Vector2(0, 24)
	popup.rect_scale = Vector2(0.94, 0.94)
	popup.modulate = Color(1, 1, 1, 0)
	$Dim.modulate = Color(1, 1, 1, 0)
	portrait_slot.modulate = Color(1, 1, 1, 0)
	tween.interpolate_property(portrait_slot, "modulate:a", 0.0, 1.0, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(popup, "rect_position", popup.rect_position, target_position, 0.28, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(popup, "rect_scale", popup.rect_scale, Vector2(1, 1), 0.28, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(popup, "modulate:a", 0.0, 1.0, 0.22, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property($Dim, "modulate:a", 0.0, 1.0, 0.22, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()


func _play_tab_animation():
	var tween = $Popup/TabTween
	tween.stop_all()
	tween.remove_all()
	pages.rect_position = pages_target_position + Vector2(0, 18)
	pages.modulate = Color(1, 1, 1, 0)
	tween.interpolate_property(pages, "rect_position", pages.rect_position, pages_target_position, 0.24, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(pages, "modulate:a", 0.0, 1.0, 0.18, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()


func _reset_popup_visuals():
	$Popup/TabTween.stop_all()
	$Popup/TabTween.remove_all()
	apply_popup_size(current_size)
	$Popup.rect_scale = Vector2.ONE
	$Popup.modulate = Color.white
	$Dim.modulate = Color.white
	portrait_slot.modulate = Color.white
	pages.rect_position = pages_target_position
	pages.modulate = Color.white


func _hide_clock():
	clock_was_visible = gui_controller.clock != null and gui_controller.clock.visible
	if gui_controller.clock != null:
		gui_controller.clock.hide()
	set_process(true)


func _restore_clock():
	if clock_was_visible and gui_controller.clock != null:
		gui_controller.clock.show()
	clock_was_visible = false


func _process(_delta):
	if visible and gui_controller.clock != null and gui_controller.clock.visible:
		gui_controller.clock.hide()
