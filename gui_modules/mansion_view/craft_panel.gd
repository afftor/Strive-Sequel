extends Panel

#The mansion's workshop: what the estate's craft rooms make and improve, who works in them, and the
#order they work it in. A craft room's card opens it on that room's trade. Every trade keeps one
#queue (game_res.crafting_lists) that all its rooms work from the top; recipe orders and gear
#improvements stand in it together - see game_res.add_recipe_task() and add_improve_task().

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")
const Improving = preload("res://src/core/item_improving.gd")

const GOLD = Color(0.976471, 0.882353, 0.505882, 1)
const GREY = Color(0.752941, 0.72549, 0.67451, 1)
const GOOD = Color(0.541176, 0.85098, 0.541176, 1)
const WARNING = Color(0.976471, 0.670588, 0.352941, 1)
const BAD = Color(0.85098, 0.505882, 0.458824, 1)
const WHITE = Color(1, 1, 1, 1)
const DIM = Color(1, 1, 1, 0.55)
const LINE = Color(0.431373, 0.352941, 0.211765, 0.92)
const LINE_ON = Color(0.996078, 0.784314, 0.321569, 1)
const QUALITY_COLORS = {
	poor = Color(0.74, 0.72, 0.69, 1), average = Color(0.53, 0.85, 0.5, 1), good = Color(0.38, 0.7, 0.96, 1),
	epic = Color(0.75, 0.53, 0.96, 1), legendary = Color(0.97, 0.65, 0.31, 1),
}

const JOBS = ['smith', 'tailor', 'alchemy', 'cooking']
const FILTERS = {All = 'all', Materials = 'materials', Gear = 'gear', Costume = 'costume', Usables = 'usables'}
const ITEM_FILTERS = {All = 'all', Weapons = 'weapons', Armor = 'armor'}
const ARMOR_TYPES = ['heavy', 'medium', 'cloth']
const AMOUNT_MODES = {Batch = 'batch', Keep = 'keep', Endless = 'endless'}
const MAX_AMOUNT = 99999
#the order's numbers the player can type; each is AmountRow/<Field>/Value
const AMOUNT_FIELDS = ['runs', 'low', 'high']
#where the lines from the item card meet before they drop to the slots
const WIRE_BUS = 14.0
const WIRE_WIDTH = 2.0
#the tallest the description block grows before it scrolls instead
const DESCRIPTION_MAX = 132
#past this many stat lines the card shows them in two columns, if the lines fit in half the width
const STATS_ONE_COLUMN = 4
#a material slot's least height, and the width its box loses to the side margins
const SLOT_HEIGHT = 198
const SLOT_SIDES = 16
#below this width a slot shows what is needed without what is in store, and keeps narrower margins
const SLOT_COMPACT = 130
const SLOT_SIDES_COMPACT = 6
#the code gold goes by among the stock helpers; no material is called this
const GOLD_STOCK = 'gold'

var view = null
var job = 'smith'
var mode = 'craft'
var filter = 'all'
var item_filter = 'all'
#what was last looked at on each trade, so coming back to a tab finds it where it was left
var picked_recipe = {}
var picked_item = {}
var targets = {}
#materials chosen for a recipe's parts, and which part the picker below the slots is for
var parts = {}
var active_part = {}
var amount = {mode = 'batch', runs = 1, low = 10, high = 40}
#the queued order whose amount is being changed, the room a crafter is being picked for, and the
#order whose removal is being asked about
var editing = null
var picking = null
var confirming = null
var tabs = {}
#the stat lines on the card, kept plain until fit_stats knows how wide the card came out
var stat_lines = []


func setup(view_node):
	view = view_node
	$CloseButton.connect("pressed", view, "close_crafting")
	var title_tabs = $Body/TitleRow/Tabs
	for code in JOBS:
		var tab = input_handler.DuplicateContainerTemplate(title_tabs, 'Tab')
		tab.get_node("Icon").texture = images.get_icon(code)
		tab.connect("pressed", self, "set_job", [code])
		tabs[code] = tab
	var recipes = $Body/Columns/Recipes
	recipes.get_node("Modes/Craft").connect("pressed", self, "set_mode", ['craft'])
	recipes.get_node("Modes/Improve").connect("pressed", self, "set_mode", ['improve'])
	for button in recipes.get_node("Filters").get_children():
		button.connect("pressed", self, "set_filter", [FILTERS[button.name]])
		globals.connecttexttooltip(button, tr("CRAFTPANEL_FILTER_" + button.name.to_upper()), false, tooltip_node())
	for button in recipes.get_node("ItemFilters").get_children():
		button.connect("pressed", self, "set_item_filter", [ITEM_FILTERS[button.name]])
	recipes.get_node("Search").connect("text_changed", self, "search_changed")
	$Body/Columns/Crafters/PickRow/Back.connect("pressed", self, "cancel_pick")
	var bench = $Body/Columns/Bench
	var order = order_box()
	bench.get_node("EditBar/Row/Leave").connect("pressed", self, "leave_order")
	for code in AMOUNT_MODES:
		order.get_node("OrderRow/" + code).connect("pressed", self, "set_amount_mode", [AMOUNT_MODES[code]])
	var row = order.get_node("AmountRow")
	row.get_node("Runs/Minus10").connect("pressed", self, "change_amount", ['runs', -10])
	row.get_node("Runs/Minus").connect("pressed", self, "change_amount", ['runs', -1])
	row.get_node("Runs/Plus").connect("pressed", self, "change_amount", ['runs', 1])
	row.get_node("Runs/Plus10").connect("pressed", self, "change_amount", ['runs', 10])
	row.get_node("Low/Minus").connect("pressed", self, "change_amount", ['low', -1])
	row.get_node("Low/Plus").connect("pressed", self, "change_amount", ['low', 1])
	row.get_node("High/Minus").connect("pressed", self, "change_amount", ['high', -1])
	row.get_node("High/Plus").connect("pressed", self, "change_amount", ['high', 1])
	for field in AMOUNT_FIELDS:
		var input = amount_input(field)
		input.max_length = str(MAX_AMOUNT).length()
		input.connect("text_changed", self, "amount_typed", [field])
		input.connect("text_entered", self, "amount_entered", [field])
		input.connect("focus_exited", self, "amount_left", [field])
	order.get_node("Perform").connect("pressed", self, "perform")
	var content = bench.get_node("Scroll/Content")
	content.get_node("Wire").connect("draw", self, "draw_wire", [content.get_node("Wire")])
	content.get_node("Wire2").connect("draw", self, "draw_wire", [content.get_node("Wire2")])
	content.get_node("Track").connect("draw", self, "draw_track")
	globals.connecttexttooltip($Body/Columns/Crafters/HeaderRow/Help, tr("CRAFTPANEL_CRAFTERS_HELP"), false, tooltip_node())
	globals.connecttexttooltip(order.get_node("OrderRow/Help"), tr("CRAFTPANEL_ORDER_HELP"), false, tooltip_node())
	globals.connecttexttooltip($Body/Columns/Queue/HeaderRow/Help, tr("CRAFTPANEL_QUEUE_HELP"), false, tooltip_node())
	set_static_texts()
	register_tutorial_buttons()
	visible = false


func set_static_texts():
	$Body/TitleRow/Title.text = tr("CRAFTPANEL_TITLE")
	for code in JOBS:
		tabs[code].get_node("Name").text = tr("CRAFTPANEL_JOB_" + code.to_upper())
	$Body/Columns/Crafters/HeaderRow/Title.text = tr("CRAFTPANEL_CRAFTERS")
	$Body/Columns/Crafters/PickRow/Back.text = tr("CRAFTPANEL_BACK")
	var recipes = $Body/Columns/Recipes
	recipes.get_node("Modes/Craft").text = tr("CRAFTPANEL_MODE_RECIPES")
	recipes.get_node("Modes/Improve").text = tr("CRAFTPANEL_MODE_IMPROVE")
	for button in recipes.get_node("ItemFilters").get_children():
		button.text = tr("CRAFTPANEL_ITEMS_" + button.name.to_upper())
	var bench = $Body/Columns/Bench
	var order = order_box()
	bench.get_node("EditBar/Row/Leave").text = tr("CRAFTPANEL_NEW_ORDER")
	for code in AMOUNT_MODES:
		order.get_node("OrderRow/" + code).text = tr("CRAFTPANEL_AMOUNT_" + code.to_upper())
	order.get_node("AmountRow/RunsLabel").text = tr("CRAFTPANEL_RUNS")
	order.get_node("AmountRow/LowLabel").text = tr("CRAFTPANEL_FROM")
	order.get_node("AmountRow/HighLabel").text = tr("CRAFTPANEL_TO")
	order.get_node("AmountRow/EndlessLabel").text = tr("CRAFTPANEL_UNTIL_REMOVED")
	bench.get_node("Scroll/Content/Picker/Box/Head/Hint").text = tr("CRAFTPANEL_CHOOSE_MATERIAL")
	$Body/Columns/Queue/HeaderRow/Title.text = tr("CRAFTPANEL_QUEUE")


#The order controls stand under the queue they add to: kind of order, how much, and the button.
func order_box():
	return $Body/Columns/Queue


#What the bench says about the thing on it: the description, between the card and the materials.
func info_box():
	return $Body/Columns/Bench/Scroll/Content


#### the hard tutorial ####

#The rooms chapter gives the kitchen its orders and its cook on this panel. Every list here is
#built again on each change, and ClearContainer only hides the old rows until the frame ends, so
#each of these is a search through the rows really shown rather than a node kept from the last
#build. A search that comes up empty answers null, which the tutorial reads as "not built yet" and
#asks again on the next frame - that is how a step can wait for the row its last click put there.
func register_tutorial_buttons():
	input_handler.register_btn_source('craftpanel_recipe_bread', self, 'tut_get_bread_recipe')
	input_handler.register_btn_source('craftpanel_recipe_meatsoup', self, 'tut_get_meatsoup_recipe')
	input_handler.register_btn_source('craftpanel_runs_plus10', self, 'tut_get_runs_plus10')
	input_handler.register_btn_source('craftpanel_add', self, 'tut_get_add')
	input_handler.register_btn_source('craftpanel_order_meatsoup', self, 'tut_get_meatsoup_order')
	input_handler.register_btn_source('craftpanel_order_remove', self, 'tut_get_meatsoup_remove')
	input_handler.register_btn_source('craftpanel_remove_yes', self, 'tut_get_meatsoup_remove_yes')
	input_handler.register_btn_source('craftpanel_add_crafter', self, 'tut_get_free_place')
	input_handler.register_btn_source('craftpanel_crafter_daisy', self, 'tut_get_daisy')
	input_handler.register_btn_source('craftpanel_close', self, 'tut_get_close')


func tut_get_bread_recipe():
	return tut_get_recipe_row('bread')


func tut_get_meatsoup_recipe():
	return tut_get_recipe_row('meatsoup')


func tut_get_recipe_row(code):
	if !visible or mode != 'craft':
		return null
	for row in shown_children($Body/Columns/Recipes/Scroll/List, 'Button'):
		if row.get_meta("recipe", "") == code:
			return row
	return null


#The order box stands whatever is on the bench, so a button of it only counts while it is drawn.
func tut_get_order_button(path):
	var button = order_box().get_node(path)
	return button if visible and button.is_visible_in_tree() else null


func tut_get_runs_plus10():
	return tut_get_order_button("AmountRow/Runs/Plus10")


func tut_get_add():
	return tut_get_order_button("Perform")


#A queued order is found by what it makes rather than by where it stands in the queue.
func tut_get_order_row(code):
	if !visible:
		return null
	for row in shown_children($Body/Columns/Queue/Scroll/List, 'Order'):
		var task = game_res().tasks_progresses.get(row.arraydata, null)
		if task != null and !game_res().is_improve_task(task) and task.id == code:
			return row
	return null


func tut_get_meatsoup_order():
	return tut_get_order_row('meatsoup')


#The row's own buttons are only shown on the order that is open, and the question only once asked.
func tut_get_meatsoup_remove():
	var row = tut_get_order_row('meatsoup')
	if row == null or !row.get_node("Actions").visible:
		return null
	return row.get_node("Actions/Remove")


func tut_get_meatsoup_remove_yes():
	var row = tut_get_order_row('meatsoup')
	if row == null or !row.get_node("Confirm").visible:
		return null
	return row.get_node("Confirm/Yes")


#The first free place in the trade's rooms - the tutorial household has the one kitchen. The
#column mixes room headers, crafters and free places, so the place is told by its mark.
func tut_get_free_place():
	if !visible or picking != null:
		return null
	for row in shown_children($Body/Columns/Crafters/Scroll/List, 'Free'):
		if row.has_meta("free_place"):
			return row
	return null


#Daisy among the people offered for that place. The list is sorted by skill, so she is found by
#who she is rather than by where she lands in it.
func tut_get_daisy():
	if !visible or picking == null:
		return null
	for row in shown_children($Body/Columns/Crafters/Scroll/List, 'Worker'):
		if !row.has_meta("char_id"):
			continue
		var character = person(row.get_meta("char_id"))
		if character != null and character.get_stat('unique') == 'daisy':
			return row
	return null


func tut_get_close():
	return $CloseButton if visible else null


func open(code = null):
	if code != null and JOBS.has(code):
		job = code
	elif trade_rooms(job).empty():
		for other in JOBS:
			if !trade_rooms(other).empty():
				job = other
				break
	editing = null
	picking = null
	confirming = null
	if job == 'cooking':
		mode = 'craft'
	$Body/Columns/Recipes/Search.text = ""
	visible = true
	for column in ["Crafters", "Recipes", "Bench", "Queue"]:
		get_node("Body/Columns/%s/Scroll" % column).scroll_vertical = 0
	rebuild()


func close():
	visible = false
	picking = null
	confirming = null


func tooltip_node():
	return view.get_node("Overlay/TextTooltip")


func item_tooltip_node():
	return view.get_node("Overlay/ItemTooltip")


func game_res():
	return ResourceScripts.game_res


func rebuild():
	if !visible:
		return
	build_tabs()
	build_crafters()
	var improving = mode == 'improve'
	$Body/Columns/Recipes/Filters.visible = !improving
	$Body/Columns/Recipes/ItemFilters.visible = improving
	$Body/Columns/Recipes/Modes/Craft.pressed = !improving
	$Body/Columns/Recipes/Modes/Improve.pressed = improving
	$Body/Columns/Recipes/Modes/Improve.disabled = job == 'cooking'
	if improving:
		build_items()
		build_improve_bench()
	else:
		build_recipes()
		build_bench()
	build_queue()
	call_deferred("refresh_wires")


#### numbers ####

func fmt(value):
	var x = stepify(float(value), 0.1)
	if is_equal_approx(x, round(x)):
		return str(int(round(x)))
	return str(x)


func turns_text(turns):
	return tr("CRAFTPANEL_TURN") % turns if turns == 1 else tr("CRAFTPANEL_TURNS") % turns


#Gold stands in a slot or a chip the way a material does: improvements are paid in it.
func stock_of(code):
	if code == GOLD_STOCK:
		return int(game_res().money)
	if Items.materiallist.has(code):
		return int(game_res().materials.get(code, 0))
	return int(game_res().get_item_amount(code, true))


func stock_name(code):
	if code == GOLD_STOCK:
		return tr("GOLD")
	if Items.materiallist.has(code):
		return tr(Items.materiallist[code].name)
	if Items.itemlist.has(code):
		return tr(Items.itemlist[code].name)
	return code


func stock_icon(code):
	if code == GOLD_STOCK:
		return images.get_icon('quest_gold')
	var data = Items.materiallist.get(code, Items.itemlist.get(code, null))
	if data == null:
		return null
	return input_handler.loadimage(data.icon) if data.icon is String else data.icon


func connect_stock_tooltip(node, code):
	if Items.materiallist.has(code):
		globals.connectmaterialtooltip(node, Items.materiallist[code], '', null, item_tooltip_node())
	elif Items.itemlist.has(code):
		globals.connecttempitemtooltip(node, Items.itemlist[code], 'geartemplate', item_tooltip_node())


#### rooms and the people in them ####

func trade_rooms(code = null):
	var res = []
	var wanted = job if code == null else code
	for entry in MansionLayout.each_room(game_res().mansion_layout):
		if RoomTypes.get_work_job(entry.room.type) == wanted and entry.room.task_id != null:
			res.append(entry)
	return res


func room_title(entry, rooms):
	var name = tr(RoomTypes.get_name_key(entry.room.type))
	var same = 0
	var place = 0
	for other in rooms:
		if other.room.type == entry.room.type:
			same += 1
			if other == entry:
				place = same
	if same > 1:
		name += " " + input_handler.roman_number_converter(place)
	return name


func room_workers(room):
	return MansionLayout.get_room_workers(room, game_res().tasks_progresses)


func person(id):
	return characters_pool.get_char_by_id(id)


func worker_yield(character, room):
	return character.get_job_value(job, false) * MansionLayout.craft_modifier(room)


#What the trade's rooms put into its queue in a turn: the same figure process_rooms() spends.
func power(code = null):
	var res = 0.0
	var wanted = job if code == null else code
	for entry in trade_rooms(wanted):
		for id in room_workers(entry.room):
			var character = person(id)
			if character != null:
				res += character.get_job_value(wanted, false) * MansionLayout.craft_modifier(entry.room)
	return res


#Who could be put on a place in this trade's rooms: everyone who works and is at the mansion, apart
#from those already in one of these rooms. Somebody busy elsewhere is offered too - choosing them
#moves them, the way dragging them on the plan does.
func candidates():
	var here = []
	for entry in trade_rooms():
		here += room_workers(entry.room)
	var res = []
	for id in ResourceScripts.game_party.characters:
		var character = person(id)
		if character == null or here.has(id) or !character.is_worker():
			continue
		if character.is_on_quest() or character.is_unavaliable() or !view.is_present(character):
			continue
		res.append(id)
	res.sort_custom(self, "by_skill")
	return res


func by_skill(first, second):
	return person(first).get_job_value(job, false) > person(second).get_job_value(job, false)


#### title ####

#A trade the estate has no room for has no tab: there is nobody to work it and nothing it could make.
func build_tabs():
	for code in JOBS:
		var tab = tabs[code]
		var has_rooms = !trade_rooms(code).empty()
		tab.visible = has_rooms or code == job
		tab.pressed = code == job
		var orders = game_res().crafting_lists.get(code, []).size()
		tab.get_node("Count").text = str(orders) if orders > 0 else ""
		tab.get_node("Alert").visible = has_rooms and orders > 0 and power(code) <= 0
		globals.connecttexttooltip(tab, tr("CRAFTPANEL_TAB_HINT") % [fmt(power(code)), orders], false, tooltip_node())


#### crafters ####

func build_crafters():
	var column = $Body/Columns/Crafters
	var list = column.get_node("Scroll/List")
	input_handler.ClearContainer(list, ['Room', 'Worker', 'Free'])
	column.get_node("HeaderRow/Power").text = tr("CRAFTPANEL_PER_TURN") % fmt(power())
	var rooms = trade_rooms()
	var pick_entry = null
	for entry in rooms:
		if picking != null and entry.floor == picking.floor and entry.slot == picking.slot:
			pick_entry = entry
	if pick_entry == null:
		picking = null
	column.get_node("PickRow").visible = pick_entry != null
	if pick_entry != null:
		build_candidates(list, pick_entry, rooms)
		return
	if rooms.empty():
		var head = input_handler.DuplicateContainerTemplate(list, 'Room')
		head.get_node("Name").text = tr("CRAFTPANEL_NO_ROOM")
		head.get_node("Name").set("custom_colors/font_color", GREY)
		head.get_node("Mod").visible = false
		head.get_node("Count").visible = false
		return
	for entry in rooms:
		var workers = room_workers(entry.room)
		var places = MansionLayout.work_capacity(entry.room)
		var head = input_handler.DuplicateContainerTemplate(list, 'Room')
		head.get_node("Name").text = room_title(entry, rooms)
		var modifier = MansionLayout.craft_modifier(entry.room)
		head.get_node("Mod").visible = !is_equal_approx(modifier, 1.0)
		head.get_node("Mod").text = "×" + fmt(modifier)
		globals.connecttexttooltip(head.get_node("Mod"), tr("CRAFTPANEL_TOOLS_HINT") % fmt(modifier), false, tooltip_node())
		head.get_node("Count").text = "%d/%d" % [workers.size(), places]
		for id in workers:
			var character = person(id)
			if character == null:
				continue
			var sub = tr("CRAFTPANEL_SKILL") % [tr("CRAFTPANEL_JOB_" + job.to_upper()), fmt(character.get_job_value(job, false))]
			if !is_equal_approx(modifier, 1.0):
				sub += " ×" + fmt(modifier)
			var row = build_worker_row(list, character, worker_yield(character, entry.room), sub)
			row.pressed = true
			row.get_node("Remove").visible = true
			globals.connecttexttooltip(row, tr("CRAFTPANEL_TAKE_OFF") % character.get_short_name(), false, tooltip_node())
			row.connect("pressed", self, "take_off", [id])
		for i in range(max(0, places - workers.size())):
			var free = input_handler.DuplicateContainerTemplate(list, 'Free')
			free.set_meta("free_place", true)
			free.text = tr("CRAFTPANEL_ADD_CRAFTER")
			free.connect("pressed", self, "start_pick", [entry.floor, entry.slot])


func build_candidates(list, entry, rooms):
	$Body/Columns/Crafters/PickRow/Text.text = tr("CRAFTPANEL_PICK_FOR") % room_title(entry, rooms)
	var ids = candidates()
	if ids.empty():
		var head = input_handler.DuplicateContainerTemplate(list, 'Room')
		head.get_node("Name").text = tr("CRAFTPANEL_NOBODY_FREE")
		head.get_node("Name").set("custom_colors/font_color", GREY)
		head.get_node("Mod").visible = false
		head.get_node("Count").visible = false
		return
	for id in ids:
		var character = person(id)
		var doing = view.assignment_of(id)
		var sub = tr("CRAFTPANEL_IDLE")
		if doing != null and doing.text != "":
			sub = tr("CRAFTPANEL_NOW") % doing.text
		var row = build_worker_row(list, character, worker_yield(character, entry.room), sub)
		row.set_meta("char_id", id)
		row.connect("pressed", self, "put_on", [id, entry.floor, entry.slot])


func build_worker_row(list, character, value, sub):
	var row = input_handler.DuplicateContainerTemplate(list, 'Worker')
	row.get_node("Portrait").texture = portrait_for(character)
	row.get_node("Name").text = character.get_short_name()
	row.get_node("Value").text = "+" + fmt(value)
	row.get_node("Sub").text = sub
	return row


func portrait_for(character):
	var portrait = character.get_icon()
	if portrait == null:
		portrait = character.get_class_icon()
	input_handler.queue_portrait(character)
	return portrait


func start_pick(floor_index, slot_code):
	picking = {floor = floor_index, slot = slot_code}
	$Body/Columns/Crafters/Scroll.scroll_vertical = 0
	rebuild()


func cancel_pick():
	picking = null
	rebuild()


func put_on(id, floor_index, slot_code):
	var room = MansionLayout.get_room(game_res().mansion_layout.floors[floor_index], slot_code)
	picking = null
	if room != null:
		view.assign_worker_to_room(room, id)
	rebuild()


func take_off(id):
	view.unassign_worker(id)
	rebuild()


#### recipes ####

func recipe(code):
	return Items.recipes.get(code, null)


#How far the trade's best room has to be expanded for the recipe, or null when something other than
#the room keeps it back (a quest's own recipe) - those stay hidden until they are offered.
func room_level_needed(data):
	var level = 0
	for req in data.unlockreqs:
		if req.get('type') != 'has_craft_room':
			return null
		level = max(level, int(req.get('value', 1)))
	return level


func recipe_category(data):
	if data.resultitemtype == 'material':
		return 'materials'
	var item = Items.itemlist.get(data.resultitem, null)
	if item == null:
		return 'gear'
	if item.type == 'usable':
		return 'usables'
	if item.get('geartype', null) == 'costume':
		return 'costume'
	return 'gear'


func recipe_offered(data):
	if data.worktype != job or data.get('unique', false):
		return false
	return globals.checkreqs(data.unlockreqs) or room_level_needed(data) != null


func recipe_locked(data):
	return !globals.checkreqs(data.unlockreqs)


func recipe_name(data):
	return stock_name(data.resultitem)


func result_stock(data):
	return stock_of(data.resultitem)


func chosen_parts(data):
	if !parts.has(data.code):
		parts[data.code] = {}
	return parts[data.code]


#One run's worth of what a recipe takes, by material or item code.
func run_needs(data):
	var res = {}
	if data.crafttype == 'modular':
		var template = Items.itemlist[data.resultitem]
		var chosen = chosen_parts(data)
		for part in template.parts:
			if chosen.has(part):
				res[chosen[part]] = res.get(chosen[part], 0) + template.parts[part]
		return res
	for code in data.materials:
		res[code] = res.get(code, 0) + data.materials[code]
	for code in data.items:
		res[code] = res.get(code, 0) + data.items[code]
	return res


func all_parts_chosen(data):
	if data.crafttype != 'modular':
		return true
	var chosen = chosen_parts(data)
	for part in Items.itemlist[data.resultitem].parts:
		if !chosen.has(part):
			return false
	return true


func recipe_work_text(data):
	if !all_parts_chosen(data):
		return '—'
	return fmt(Items.get_recipe_workunits(data.code, chosen_parts(data) if data.crafttype == 'modular' else {}))


func short_of(needs, runs = 1):
	var res = []
	for code in needs:
		if stock_of(code) < needs[code] * runs:
			res.append(code)
	return res


func materials_for_part(part):
	var res = []
	for code in Items.materiallist:
		var data = Items.materiallist[code]
		if data.has('parts') and data.parts.has(part):
			res.append(code)
	res.sort_custom(self, "by_stock")
	return res


func by_stock(first, second):
	return (stock_of(first) > 0) and !(stock_of(second) > 0)


func queued_recipes():
	var res = []
	for id in game_res().crafting_lists.get(job, []):
		var task = game_res().tasks_progresses.get(id, null)
		if task != null and !game_res().is_improve_task(task):
			res.append(task.id)
	return res


func build_recipes():
	var column = $Body/Columns/Recipes
	var list = column.get_node("Scroll/List")
	input_handler.ClearContainer(list, ['Button'])
	var present = []
	var codes = []
	var query = column.get_node("Search").text.strip_edges().to_lower()
	for code in Items.recipes:
		var data = Items.recipes[code]
		if !recipe_offered(data):
			continue
		if !present.has(recipe_category(data)):
			present.append(recipe_category(data))
		if filter != 'all' and recipe_category(data) != filter:
			continue
		if query != "" and recipe_name(data).to_lower().find(query) < 0:
			continue
		codes.append(code)
	codes.sort_custom(self, "by_recipe_order")
	for button in column.get_node("Filters").get_children():
		button.visible = button.name == 'All' or present.has(FILTERS[button.name])
		button.pressed = FILTERS[button.name] == filter
	#a trade opened for the first time starts on the top recipe rather than on an empty bench
	if !picked_recipe.has(job) and !codes.empty():
		pick_recipe(codes[0], false)
	var queued = queued_recipes()
	for code in codes:
		build_recipe_row(list, Items.recipes[code], queued.has(code))
	column.get_node("Empty").text = tr("CRAFTPANEL_NO_RECIPES")
	column.get_node("Empty").visible = codes.empty()
	column.get_node("Scroll").visible = !codes.empty()


func by_recipe_order(first, second):
	var a = Items.recipes[first]
	var b = Items.recipes[second]
	if recipe_locked(a) != recipe_locked(b):
		return !recipe_locked(a)
	return recipe_name(a) < recipe_name(b)


func build_recipe_row(list, data, queued):
	var row = input_handler.DuplicateContainerTemplate(list, 'Button')
	row.pressed = picked_recipe.get(job) == data.code
	row.set_meta("recipe", data.code)
	var icon = row.get_node("Quality/Item")
	icon.texture = stock_icon(data.resultitem)
	icon.material = load("res://assets/ItemShader.tres").duplicate() if data.crafttype == 'modular' else null
	if data.resultitemtype == 'material':
		globals.connectmaterialtooltip(icon, Items.materiallist[data.resultitem], '', null, item_tooltip_node())
	else:
		globals.connecttempitemtooltip(icon, Items.itemlist[data.resultitem], 'geartemplate', item_tooltip_node())
	row.get_node("Quality/Count").visible = data.resultamount > 1
	row.get_node("Quality/Count").text = str(data.resultamount)
	row.get_node("Name").text = recipe_name(data)
	row.get_node("Work/Icon").texture = images.get_icon(job)
	row.get_node("Work/Value").text = recipe_work_text(data)
	row.get_node("Work/Queued").visible = queued
	if queued:
		globals.connecttexttooltip(row.get_node("Work/Queued"), tr("CRAFTPANEL_IN_QUEUE"), false, tooltip_node())
	var locked = recipe_locked(data)
	row.get_node("Chips").visible = !locked
	row.get_node("Status").visible = locked
	row.modulate = DIM if locked else WHITE
	if locked:
		row.get_node("Status").text = tr("CRAFTPANEL_NEEDS_EXPANSION") % input_handler.roman_number_converter(max(1, room_level_needed(data) - 1))
		row.get_node("Status").set("custom_colors/font_color", BAD)
	else:
		build_recipe_chips(row.get_node("Chips"), data)
	row.connect("pressed", self, "pick_recipe", [data.code])


#What one run takes, on the row itself: the materials and items of a fixed recipe, or each part of a
#made-to-order one. The parts stay parts whatever has been chosen for them on the bench - the list
#says what the recipe is made of, the bench what this order will be made of.
func build_recipe_chips(box, data):
	input_handler.ClearContainer(box, ['Chip'])
	if data.crafttype == 'modular':
		var template = Items.itemlist[data.resultitem]
		for part in template.parts:
			var chip = input_handler.DuplicateContainerTemplate(box, 'Chip')
			chip.get_node("Value").text = str(template.parts[part])
			chip.get_node("Icon").texture = Items.Parts[part].icon
			globals.connecttexttooltip(chip.get_node("Icon"), tr("CRAFTPANEL_ANY_MATERIAL") % tr(Items.Parts[part].name), false, tooltip_node())
		return
	var needs = run_needs(data)
	for code in needs:
		var chip = input_handler.DuplicateContainerTemplate(box, 'Chip')
		chip.get_node("Icon").texture = stock_icon(code)
		chip.get_node("Value").text = str(needs[code])
		set_short_color(chip.get_node("Value"), stock_of(code) < needs[code])
		connect_stock_tooltip(chip.get_node("Icon"), code)


func set_short_color(label, short):
	label.set("custom_colors/font_color", WARNING if short else WHITE)


func pick_recipe(code, redraw = true):
	var data = recipe(code)
	if data == null:
		return
	var changed = picked_recipe.get(job) != code
	picked_recipe[job] = code
	if editing != null and changed:
		editing = null
	if changed:
		fill_parts(data)
		var have = result_stock(data)
		amount = {mode = 'batch', runs = 1, low = clamp_amount('low', max(data.resultamount, round(have / 2.0))), high = clamp_amount('high', max(have + data.resultamount * 5, 20))}
		$Body/Columns/Bench/Scroll.scroll_vertical = 0
	if redraw:
		rebuild()


#A made-to-order recipe opens with the materials there is most of for each part, so it can be
#queued as it stands; the player changes what they want changed.
func fill_parts(data):
	if data.crafttype != 'modular':
		return
	var chosen = chosen_parts(data)
	var template = Items.itemlist[data.resultitem]
	for part in template.parts:
		if chosen.has(part):
			continue
		var best = null
		for code in materials_for_part(part):
			if stock_of(code) < template.parts[part]:
				continue
			if best == null or stock_of(code) > stock_of(best):
				best = code
		if best != null:
			chosen[part] = best


#### the bench: one recipe ####

func current_recipe():
	var data = recipe(picked_recipe.get(job, ''))
	if data == null or !recipe_offered(data):
		return null
	return data


func editing_task():
	if editing == null:
		return null
	var task = game_res().tasks_progresses.get(editing, null)
	if task == null or !game_res().crafting_lists.get(job, []).has(editing):
		editing = null
		return null
	return task


func runs_wanted(data):
	match amount.mode:
		'batch':
			return amount.runs
		'keep':
			return int(max(1, ceil((amount.high - result_stock(data)) / float(data.resultamount))))
	return 1


func build_bench():
	var bench = $Body/Columns/Bench
	var content = bench.get_node("Scroll/Content")
	var data = current_recipe()
	content.visible = data != null
	for part in ["OrderDivider", "OrderRow", "AmountRow", "Summary", "Perform"]:
		order_box().get_node(part).visible = data != null
	content.get_node("Track").visible = false
	content.get_node("Wire2").visible = false
	var task = editing_task()
	bench.get_node("EditBar").visible = task != null
	bench.get_node("EditBar/Row/Text").text = tr("CRAFTPANEL_EDITING")
	if data == null:
		return
	var locked = recipe_locked(data)
	var modular = data.crafttype == 'modular'
	build_recipe_card(content.get_node("Card/Row"), data)
	var runs = runs_wanted(data)
	var slots = content.get_node("Slots")
	input_handler.ClearContainer(slots, ['Slot'])
	if modular:
		var template = Items.itemlist[data.resultitem]
		var chosen = chosen_parts(data)
		var focus = active_part.get(data.code, null)
		if focus == null or !template.parts.has(focus):
			focus = null
			for part in template.parts:
				if focus == null or (chosen.has(focus) and !chosen.has(part)):
					focus = part
			active_part[data.code] = focus
		for part in template.parts:
			var slot = build_slot(slots, chosen.get(part, null), template.parts[part], runs)
			slot.get_node("Box/Head/PartIcon").texture = Items.Parts[part].icon
			slot.get_node("Box/Head/PartName").text = tr(Items.Parts[part].name)
			slot.pressed = part == focus and task == null and !locked
			slot.disabled = task != null or locked
			slot.connect("pressed", self, "focus_part", [part])
			if chosen.has(part):
				var lines = part_bonus_lines(chosen[part], part)
				set_slot_bonus(slot, lines if !lines.empty() else [tr("CRAFTPANEL_NO_BONUS")])
				globals.connectmaterialtooltip(slot, Items.materiallist[chosen[part]], "\n\n" + part_bonus_text(chosen[part], part), null, item_tooltip_node())
			else:
				set_slot_bonus(slot, [tr("CRAFTPANEL_PICK_BELOW")])
		build_picker(content.get_node("Picker"), data, focus, task == null and !locked)
	else:
		var needs = run_needs(data)
		for code in needs:
			var slot = build_slot(slots, code, needs[code], runs)
			slot.get_node("Box/Head/PartIcon").visible = false
			slot.get_node("Box/Head/PartName").visible = false
			slot.get_node("Box/Bonus").visible = false
			slot.disabled = true
			connect_stock_tooltip(slot, code)
		content.get_node("Picker").visible = false
	content.get_node("Wire").visible = fit_slots(slots) > 0
	build_duration(content.get_node("Duration"), data)
	build_order_row(data, locked)
	build_summary(data, locked, task)


#How much work a run of the recipe takes, written large under the materials that decide it, after
#what the trade's crafters put in a turn; with nobody at work that is shown as a warning.
func build_duration(row, data):
	row.visible = true
	row.get_node("Icon").texture = images.get_icon(job)
	var rate = power()
	row.get_node("Power").text = tr("CRAFTPANEL_PER_TURN") % fmt(rate)
	row.get_node("Power").set("custom_colors/font_color", WARNING if rate <= 0 else GREY)
	row.get_node("Text").text = tr("CRAFTPANEL_TO_CRAFT") % recipe_work_text(data)


#The card's picture is one node whatever the bench shows, and each tooltip helper drops only its
#own kind of binding: a made item's text tooltip followed by a recipe's item tooltip left both on
#it, and hovering opened the two at once - one of them still about the recipe before.
func clear_tooltips(node):
	for link in node.get_signal_connection_list("mouse_entered"):
		node.disconnect(link.signal, link.target, link.method)


func build_recipe_card(card, data):
	card.get_node("Frame").visible = true
	card.get_node("Pair").visible = false
	var icon = card.get_node("Frame/Quality/Item")
	clear_tooltips(icon)
	card.get_node("Frame/Quality").texture = null
	card.get_node("Frame/Quality").material = null
	icon.material = null
	var stats = null
	var description = ""
	if data.resultitemtype == 'material':
		var material = Items.materiallist[data.resultitem]
		icon.texture = stock_icon(data.resultitem)
		description = tr(material.descript) + globals.get_food_info_text(material)
		globals.connectmaterialtooltip(icon, material, '', null, item_tooltip_node())
	else:
		var item = Items.itemlist[data.resultitem]
		description = tr(item.get('descript', ''))
		if data.crafttype == 'modular' and all_parts_chosen(data):
			var made = globals.CreateGearItemQuality(data.resultitem, chosen_parts(data), '')
			made.set_icon(icon)
			stats = made.get_bonusstats()
			globals.connecttexttooltip(icon, made.tooltiptext(), false, tooltip_node())
			card.get_node("Words/Name").text = made.name
		else:
			icon.texture = stock_icon(data.resultitem)
			if data.crafttype == 'modular':
				icon.material = load("res://assets/ItemShader.tres").duplicate()
			globals.connecttempitemtooltip(icon, item, 'geartemplate', item_tooltip_node())
			if item.get('basestats', null) is Dictionary:
				stats = item.basestats
	if !(data.crafttype == 'modular' and all_parts_chosen(data)):
		card.get_node("Words/Name").text = recipe_name(data)
	card.get_node("Frame/Count").visible = data.resultamount > 1
	card.get_node("Frame/Count").text = str(data.resultamount)
	card.get_node("Words/Meta/Text").text = tr("CRAFTPANEL_CARD_META") % result_stock(data)
	var stats_text = ""
	if stats != null and !stats.empty():
		stats_text = bonus_lines(stats)
	fill_info(description, tr("CRAFTPANEL_STATS_POOR") if data.crafttype == 'modular' else tr("CRAFTPANEL_STATS"), stats_text)


#The description goes in its block over the materials, the stats into the card by the icon; either is
#left out when it has nothing to say. Stats come as plain lines, so a long list can be split in two
#columns without cutting a colour mark in half.
func fill_info(description, stats_title, stats_text):
	var box = info_box()
	var desc = box.get_node("About/Desc")
	desc.bbcode_text = globals.TextEncoder(description.strip_edges())
	desc.scroll_to_line(0)
	box.get_node("About").visible = description.strip_edges() != ""
	box.get_node("Gap").visible = box.get_node("About").visible
	var words = $Body/Columns/Bench/Scroll/Content/Card/Row/Words
	stat_lines = []
	for line in stats_text.split("\n", false):
		if line.strip_edges() != "":
			stat_lines.append(line.strip_edges())
	words.get_node("StatsTitle").text = stats_title
	words.get_node("StatsTitle").visible = !stat_lines.empty()
	words.get_node("StatsCols").visible = !stat_lines.empty()
	fill_stats(false)
	call_deferred("fit_description")
	call_deferred("fit_stats")


#The description block is as tall as its text, up to a point; past that it scrolls.
func fit_description():
	var desc = info_box().get_node("About/Desc")
	desc.rect_min_size.y = clamp(desc.get_content_height() + 4, 24, DESCRIPTION_MAX)


#A long list of stats goes in two columns, unless a line would have to wrap in half the card (the
#improve card writes each stat as "before → after").
func fit_stats():
	var cols = $Body/Columns/Bench/Scroll/Content/Card/Row/Words/StatsCols
	if stat_lines.size() <= STATS_ONE_COLUMN:
		return
	var font = cols.get_node("Stats1").get_font("normal_font")
	#the card's words column is laid out by now; the columns inside it may not be yet
	var half = (cols.get_parent().rect_size.x - cols.get_constant("separation")) / 2.0
	for line in stat_lines:
		if line_width(line, font) > half:
			return
	fill_stats(true)


func fill_stats(split):
	var cols = $Body/Columns/Bench/Scroll/Content/Card/Row/Words/StatsCols
	var first = int(ceil(stat_lines.size() / 2.0)) if split else stat_lines.size()
	var left = stat_lines.slice(0, first - 1) if first > 0 else []
	var right = stat_lines.slice(first, stat_lines.size() - 1) if split else []
	cols.get_node("Stats1").bbcode_text = globals.TextEncoder(PoolStringArray(left).join("\n"))
	cols.get_node("Stats2").bbcode_text = globals.TextEncoder(PoolStringArray(right).join("\n"))
	cols.get_node("Stats2").visible = split


func build_slot(slots, code, need, runs):
	var slot = input_handler.DuplicateContainerTemplate(slots, 'Slot')
	slot.get_node("Box/Head/Need").text = "×" + str(need)
	var empty = code == null
	slot.get_node("Box/Mat/Empty").visible = empty
	slot.get_node("Box/Mat/Icon").texture = null if empty else stock_icon(code)
	slot.get_node("Box/Name").text = tr("CRAFTPANEL_CHOOSE") if empty else stock_name(code)
	slot.get_node("Box/Name").set("custom_colors/font_color", WARNING if empty else GOLD)
	slot.get_node("Box/Count").visible = !empty
	if !empty:
		var total = need * runs
		var have = stock_of(code)
		slot.set_meta("need", total)
		slot.get_node("Box/Count").text = "%d / %d" % [total, have]
		slot.get_node("Box/Count").set("custom_colors/font_color", WARNING if have < total else WHITE)
	return slot


#The rows a list really shows: ClearContainer only hides the old ones until the frame ends, and the
#template is always there.
func shown_children(container, template):
	var res = []
	for child in container.get_children():
		if child.visible and child.name != template and !child.is_queued_for_deletion():
			res.append(child)
	return res


#Three slots fit side by side at full width; a fourth makes them all narrower, and more than that -
#a unique piece raised several steps asks for gold and a handful of materials - share the bench's
#width, too narrow then to say how much is in store as well: the colour still says when it is short.
#A slot grows to fit the bonus under its material, a stat to a line, and the row takes the height
#of its tallest slot.
func fit_slots(slots):
	var shown = shown_children(slots, 'Slot')
	var width = 176 if shown.size() <= 3 else 146
	if shown.size() > 3:
		#the bench's least width, not its laid-out one: that is not settled yet on the first build
		var room = slots.get_parent().rect_min_size.x
		width = int(min(width, floor((room - slots.get_constant("separation") * (shown.size() - 1)) / shown.size())))
	var compact = width < SLOT_COMPACT
	var sides = SLOT_SIDES_COMPACT if compact else SLOT_SIDES
	for slot in shown:
		slot.rect_min_size.x = width
		slot.get_node("Box").margin_left = sides / 2.0
		slot.get_node("Box").margin_right = -sides / 2.0
		if compact and slot.has_meta("need"):
			slot.get_node("Box/Count").text = str(slot.get_meta("need"))
			#the name in the smaller hand of the part's name above it, so a long word is not broken
			slot.get_node("Box/Name").add_font_override("font", slot.get_node("Box/Head/PartName").get_font("font"))
		var bonus = slot.get_node("Box/Bonus")
		if bonus.visible:
			var font = bonus.get_font("normal_font")
			var room = width - sides
			var rows = 0
			for line in slot.get_meta("bonus_lines") if slot.has_meta("bonus_lines") else []:
				rows += max(1, ceil(line_width(line, font) / room))
			bonus.rect_min_size.y = rows * (font.get_height() + bonus.get_constant("line_separation"))
		slot.rect_min_size.y = max(SLOT_HEIGHT, slot_height(slot, width - sides))
	return shown.size()


#What a slot's box needs, added up by hand: a new slot's name label has not been given its width yet,
#so its own minimum size would count every word on a line of its own.
func slot_height(slot, room):
	var box = slot.get_node("Box")
	var height = box.margin_top - box.margin_bottom
	var parts_shown = 0
	for child in box.get_children():
		if !child.visible:
			continue
		parts_shown += 1
		if child.name == 'Name':
			var font = child.get_font("font")
			var lines = 1 if font.get_string_size(child.text).x <= room else child.max_lines_visible
			height += lines * (font.get_height() + child.get_constant("line_spacing"))
		else:
			height += child.get_combined_minimum_size().y
	return height + max(0, parts_shown - 1) * box.get_constant("separation")


#What a material gives its part, a stat to a line in its colour; the line count is kept for fit_slots.
func set_slot_bonus(slot, lines):
	slot.set_meta("bonus_lines", lines)
	slot.get_node("Box/Bonus").bbcode_text = "[center]" + globals.TextEncoder(PoolStringArray(lines).join("\n")) + "[/center]"


#The same words without the colour marks globals.make_bonus_value_string() puts in them, for measuring
#how wide a line comes out; tooltips keep the marks and show the colours.
func plain(text):
	var marks = RegEx.new()
	marks.compile("\\{color=[^|}]*\\|([^}]*)\\}")
	return marks.sub(text, "$1", true)


#What a material gives the part it is put in, a stat to a line, as the craft screen has always worded
#it; the values carry the colour marks globals.make_bonus_value_string() puts on them.
func part_bonus_lines(code, part):
	var data = Items.materiallist[code]
	var lines = []
	for stat in data.parts[part]:
		var value = data.parts[part][stat]
		if stat == 'enchant_capacity_mod':
			var percent = int(round(value * 100))
			if percent != 0:
				lines.append(tr("CRAFTPANEL_CAPACITY_BONUS") % ("{color=%s|%s%d%%}" % ['green' if percent > 0 else 'red', '+' if percent > 0 else '', percent]))
			continue
		if value is Array or value is String:
			continue
		if value == 0 or !statdata.statdata.has(stat):
			continue
		var stat_data = statdata.statdata[stat]
		var bonus = stat_data.default_bonus
		lines.append((globals.get_bonus_name_string(bonus, stat_data, value) + globals.make_bonus_value_string(bonus, stat_data, value)).strip_edges())
	return lines


#An item's stats a line each, for the card, as globals.build_desc_for_bonusstats() words them, with the
#enchant capacity it leaves out put last, under the stats the item fights with.
func bonus_lines(stats):
	var text = globals.build_desc_for_bonusstats(stats).strip_edges()
	var capacity = stats.get('enchant_capacity', 0)
	if (capacity is int or capacity is float) and capacity != 0:
		var data = statdata.statdata.enchant_capacity
		text += "\n" + globals.get_bonus_name_string(data.default_bonus, data, capacity) + globals.make_bonus_value_string(data.default_bonus, data, capacity)
	return text


#How wide a line comes out, without the colour marks.
func line_width(line, font):
	return font.get_string_size(plain(line)).x


func part_bonus_text(code, part):
	var lines = part_bonus_lines(code, part)
	return PoolStringArray(lines).join(" · ") if !lines.empty() else tr("CRAFTPANEL_NO_BONUS")


func build_picker(picker, data, part, open):
	picker.visible = open and part != null
	if !picker.visible:
		return
	var template = Items.itemlist[data.resultitem]
	var need = template.parts[part]
	var chosen = chosen_parts(data)
	picker.get_node("Box/Head/Part").text = tr(Items.Parts[part].name)
	picker.get_node("Box/Head/Need").text = "×" + str(need)
	var grid = picker.get_node("Box/Mats")
	input_handler.ClearContainer(grid, ['Mat'])
	for code in materials_for_part(part):
		var button = input_handler.DuplicateContainerTemplate(grid, 'Mat')
		var have = stock_of(code)
		button.get_node("Icon").texture = stock_icon(code)
		button.get_node("Count").text = str(have)
		button.get_node("Count").set("custom_colors/font_color", WARNING if have < need else WHITE)
		button.modulate = WHITE if have > 0 else Color(1, 1, 1, 0.4)
		button.pressed = chosen.get(part) == code
		globals.connectmaterialtooltip(button, Items.materiallist[code], "\n\n" + part_bonus_text(code, part), null, item_tooltip_node())
		button.connect("pressed", self, "choose_material", [part, code])


func focus_part(part):
	var data = current_recipe()
	if data != null:
		active_part[data.code] = part
	rebuild()


#After a choice the picker moves on to the next part still without a material, so an order can be
#put together in as many clicks as it has parts.
func choose_material(part, code):
	var data = current_recipe()
	if data == null or editing != null:
		return
	var chosen = chosen_parts(data)
	chosen[part] = code
	for other in Items.itemlist[data.resultitem].parts:
		if !chosen.has(other):
			active_part[data.code] = other
			break
	rebuild()


#### the order ####

#The order's kind on one row and how much of it on the row under it: the stock limits of Keep in
#stock do not fit beside the three buttons.
func build_order_row(data, locked):
	var modes = order_box().get_node("OrderRow")
	for code in AMOUNT_MODES:
		var button = modes.get_node(code)
		button.visible = true
		button.pressed = AMOUNT_MODES[code] == amount.mode
		button.disabled = locked
	modes.visible = true
	modes.get_node("Help").visible = true
	modes.get_node("Notes").visible = false
	var row = order_box().get_node("AmountRow")
	row.visible = true
	row.get_node("RunsLabel").visible = amount.mode == 'batch'
	row.get_node("Runs").visible = amount.mode == 'batch'
	for part in ['LowLabel', 'Low', 'HighLabel', 'High']:
		row.get_node(part).visible = amount.mode == 'keep'
	row.get_node("EndlessLabel").visible = amount.mode == 'endless'
	for field in AMOUNT_FIELDS:
		show_amount(field)
		amount_input(field).editable = !locked
		for button in row.get_node(field.capitalize()).get_children():
			if button is BaseButton:
				button.disabled = locked


func amount_input(field):
	return order_box().get_node("AmountRow/" + field.capitalize() + "/Value")


#A number the player is still typing is left as typed; anything else that changed the amount is
#written in. Writing only on a difference also keeps a text_changed from the write from looping.
func show_amount(field):
	var input = amount_input(field)
	if input.has_focus() and input.text != "" and int(input.text) == amount[field]:
		return
	if input.text != str(amount[field]):
		input.text = str(amount[field])
		input.caret_position = input.text.length()


#Beside the button only what holds the order back is said; how it is getting on is the queue's to show.
func build_summary(data, locked, task):
	var summary = order_box().get_node("Summary")
	var perform = order_box().get_node("Perform")
	var warning = ""
	if locked:
		warning = "[color=#d98175]" + tr("CRAFTPANEL_NEEDS_EXPANSION") % input_handler.roman_number_converter(max(1, room_level_needed(data) - 1)) + "[/color]"
	elif !all_parts_chosen(data):
		warning = "[color=#f9ab5a]" + tr("CRAFTPANEL_CHOOSE_FOR") % missing_part_names(data) + "[/color]"
	elif task == null and !short_of(run_needs(data)).empty():
		warning = "[color=#f9ab5a]" + tr("CRAFTPANEL_SHORT_OF") % names_of(short_of(run_needs(data))) + "[/color]"
	summary.bbcode_text = warning
	summary.visible = warning != ""
	perform.text = tr("CRAFTPANEL_SAVE") if task != null else tr("CRAFTPANEL_ADD")
	perform.disabled = locked or !all_parts_chosen(data)


func missing_part_names(data):
	var names = []
	var chosen = chosen_parts(data)
	for part in Items.itemlist[data.resultitem].parts:
		if !chosen.has(part):
			names.append(tr(Items.Parts[part].name))
	return PoolStringArray(names).join(", ")


func names_of(codes):
	var names = []
	for code in codes:
		names.append(stock_name(code))
	return PoolStringArray(names).join(", ")


func set_amount_mode(value):
	amount.mode = value
	rebuild()


func change_amount(field, step):
	amount[field] = clamp_amount(field, amount[field] + step)
	keep_limits_apart(field)
	rebuild()


#Runs and the top of the stock start at one, its bottom at nothing; the bottom stops one short of
#MAX_AMOUNT so the top still fits above it.
func clamp_amount(field, value):
	if field == 'low':
		return int(clamp(value, 0, MAX_AMOUNT - 1))
	return int(clamp(value, 1, MAX_AMOUNT))


#The stock's top must stay above its bottom; the limit just changed wins and the other one moves.
func keep_limits_apart(field):
	if field == 'runs' or amount.high > amount.low:
		return
	if field == 'high':
		amount.low = amount.high - 1
	else:
		amount.high = amount.low + 1


#Typing changes the order as it goes, so the bench follows the number. The stock limits are put
#apart only once the player leaves the field: a "to" typed digit by digit would otherwise drag
#"from" down to its first digit.
func amount_typed(text, field):
	var input = amount_input(field)
	var digits = ""
	var caret = 0
	for i in range(text.length()):
		if text[i] >= '0' and text[i] <= '9':
			digits += text[i]
			if i < input.caret_position:
				caret += 1
	if digits != text:
		input.text = digits
		input.caret_position = caret
	if digits == "":
		return
	amount[field] = clamp_amount(field, int(digits))
	rebuild()


func amount_entered(_text, field):
	amount_input(field).release_focus()


func amount_left(field):
	var low = amount.low
	var high = amount.high
	keep_limits_apart(field)
	if amount.low != low or amount.high != high:
		rebuild()
	else:
		show_amount(field)


#Godot keeps the caret in a field until another control takes the focus, and no button on this
#panel takes it, so a click anywhere off the field being typed in finishes the number. _input runs
#before the click reaches its button, which then sees the number already in order.
func _input(event):
	if !(event is InputEventMouseButton) or !event.pressed or !is_visible_in_tree():
		return
	if event.button_index != BUTTON_LEFT and event.button_index != BUTTON_RIGHT:
		return
	for field in AMOUNT_FIELDS:
		var input = amount_input(field)
		if input.has_focus() and !input.get_global_rect().has_point(event.position):
			input.release_focus()


func amount_order():
	match amount.mode:
		'keep':
			return {min = amount.low, max = amount.high}
		'endless':
			return {continuous = true}
	return {fixed = amount.runs}


func perform():
	if mode == 'improve':
		send_to_improve()
		return
	var data = current_recipe()
	if data == null or recipe_locked(data) or !all_parts_chosen(data):
		return
	var task = editing_task()
	if task != null:
		save_order(task)
		return
	game_res().add_recipe_task(data.code, chosen_parts(data).duplicate() if data.crafttype == 'modular' else {}, amount_order())
	editing = null
	rebuild()


#The same three shapes MansionCraftModule.confirm_craft_edit() writes, so the queue reads them
#the same way whichever screen changed them.
func save_order(task):
	task.erase('repeat')
	task.erase('continuous')
	task.erase('cap_up')
	task.erase('cap_low')
	match amount.mode:
		'batch':
			task.repeat = amount.runs
		'keep':
			task.cap_up = amount.high
			task.cap_low = amount.low
		'endless':
			task.continuous = true
	if task.status in ['stopped', 'completed']:
		task.status = 'init'
	editing = null
	rebuild()


func leave_order():
	editing = null
	rebuild()


#### improving ####

func improvable_ids():
	var res = []
	var query = $Body/Columns/Recipes/Search.text.strip_edges().to_lower()
	for id in Improving.items_for(job):
		var item = game_res().items[id]
		if item_filter == 'weapons' and (item.itemtype != 'weapon'):
			continue
		if item_filter == 'armor' and !ARMOR_TYPES.has(str(item.geartype)):
			continue
		if query != "" and item.name.to_lower().find(query) < 0:
			continue
		res.append(id)
	res.sort_custom(self, "by_item_order")
	return res


func by_item_order(first, second):
	var a = game_res().items[first]
	var b = game_res().items[second]
	var top_a = Improving.next_quality(a) == null
	var top_b = Improving.next_quality(b) == null
	if top_a != top_b:
		return !top_a
	return a.name < b.name


func build_items():
	var column = $Body/Columns/Recipes
	var list = column.get_node("Scroll/List")
	input_handler.ClearContainer(list, ['Button'])
	for button in column.get_node("ItemFilters").get_children():
		button.pressed = ITEM_FILTERS[button.name] == item_filter
	var ids = improvable_ids()
	var on_bench = improve_orders()
	if picked_item.get(job) == null and !ids.empty() and editing == null:
		picked_item[job] = ids[0]
	for task_id in on_bench:
		build_bench_row(list, task_id)
	for id in ids:
		build_item_row(list, id)
	column.get_node("Empty").text = tr("CRAFTPANEL_NO_ITEMS")
	column.get_node("Empty").visible = ids.empty() and on_bench.empty()
	column.get_node("Scroll").visible = !column.get_node("Empty").visible


func improve_orders():
	var res = []
	for id in game_res().crafting_lists.get(job, []):
		if game_res().is_improve_task(game_res().tasks_progresses.get(id, null)):
			res.append(id)
	return res


func fill_item_icon(holder, item, quality = null):
	holder.texture = variables.quality_colors.get(Improving.current(item) if quality == null else quality)
	item.set_icon(holder.get_node("Item"))


func build_item_row(list, id):
	var item = game_res().items[id]
	var row = input_handler.DuplicateContainerTemplate(list, 'Button')
	row.pressed = picked_item.get(job) == id
	fill_item_icon(row.get_node("Quality"), item)
	globals.connectitemtooltip_v2(row.get_node("Quality/Item"), item, item_tooltip_node())
	row.get_node("Quality/Count").visible = item.amount > 1
	row.get_node("Quality/Count").text = str(item.amount)
	row.get_node("Name").text = item.name
	var quality = Improving.current(item)
	row.get_node("Work/Icon").visible = false
	row.get_node("Work/Value").text = tr("QUALITY" + quality.to_upper())
	row.get_node("Work/Value").set("custom_colors/font_color", QUALITY_COLORS.get(quality, GREY))
	var next = Improving.next_quality(item)
	row.get_node("Chips").visible = next != null
	row.get_node("Status").visible = next == null
	if next == null:
		row.get_node("Status").text = tr("CRAFTPANEL_HIGHEST")
		row.get_node("Status").set("custom_colors/font_color", GREY)
		row.modulate = DIM
	else:
		var cost = Improving.step_cost(item, next)
		var box = row.get_node("Chips")
		input_handler.ClearContainer(box, ['Chip'])
		var gold = input_handler.DuplicateContainerTemplate(box, 'Chip')
		gold.get_node("Icon").texture = stock_icon(GOLD_STOCK)
		gold.get_node("Value").text = str(cost.gold)
		set_short_color(gold.get_node("Value"), stock_of(GOLD_STOCK) < cost.gold)
		globals.connecttexttooltip(gold.get_node("Icon"), tr("CRAFTPANEL_STEP_GOLD"), false, tooltip_node())
		for code in cost.materials:
			var chip = input_handler.DuplicateContainerTemplate(box, 'Chip')
			chip.get_node("Icon").texture = stock_icon(code)
			chip.get_node("Value").text = str(cost.materials[code])
			set_short_color(chip.get_node("Value"), stock_of(code) < cost.materials[code])
			connect_stock_tooltip(chip.get_node("Icon"), code)
		var work = input_handler.DuplicateContainerTemplate(box, 'Chip')
		work.get_node("Icon").texture = images.get_icon(job)
		work.get_node("Value").text = fmt(cost.work)
		globals.connecttexttooltip(work.get_node("Icon"), tr("CRAFTPANEL_STEP_WORK"), false, tooltip_node())
	var wearer = row.get_node("Wearer")
	var owner = item.get_owner()
	wearer.visible = owner != null
	if owner != null:
		row.get_node("Chips").margin_right = -40
		wearer.texture = portrait_for(owner)
		globals.connecttexttooltip(wearer, tr("CRAFTPANEL_WORN_BY") % owner.get_short_name(), false, tooltip_node())
	row.connect("pressed", self, "pick_item", [id])


#A piece already on the bench is listed above the rest, with how far its order has got.
func build_bench_row(list, task_id):
	var task = game_res().tasks_progresses[task_id]
	var item = game_res().workshop_item(task_id)
	if item == null:
		return
	var row = input_handler.DuplicateContainerTemplate(list, 'Button')
	row.pressed = editing == task_id
	fill_item_icon(row.get_node("Quality"), item)
	row.get_node("Name").text = item.name
	row.get_node("Work/Icon").visible = false
	var quality = Improving.current(item)
	row.get_node("Work/Value").text = tr("QUALITY" + quality.to_upper())
	row.get_node("Work/Value").set("custom_colors/font_color", QUALITY_COLORS.get(quality, GREY))
	row.get_node("Chips").visible = false
	row.get_node("Status").visible = true
	var text = tr("CRAFTPANEL_ON_BENCH")
	if task.steps.size() > 1:
		text += " · " + tr("CRAFTPANEL_STEP_OF") % [task.step + 1, task.steps.size()]
	row.get_node("Status").text = text
	row.get_node("Status").set("custom_colors/font_color", WARNING)
	row.connect("pressed", self, "pick_order", [task_id])


func pick_item(id):
	if picked_item.get(job) != id:
		$Body/Columns/Bench/Scroll.scroll_vertical = 0
	picked_item[job] = id
	editing = null
	rebuild()


func current_item():
	var id = picked_item.get(job)
	if id == null or !game_res().items.has(id):
		return null
	var item = game_res().items[id]
	if !Improving.improvable(item) or Improving.job_of(item) != job:
		return null
	return item


func current_target(item):
	var steps = Improving.ladder(item)
	var at = steps.find(Improving.current(item))
	var wanted = targets.get(item.id)
	if wanted != null and steps.find(wanted) > at:
		return wanted
	return Improving.next_quality(item)


func build_improve_bench():
	var bench = $Body/Columns/Bench
	var content = bench.get_node("Scroll/Content")
	var task = editing_task()
	var item = null
	if task != null and game_res().is_improve_task(task):
		item = game_res().workshop_item(editing)
	else:
		task = null
		item = current_item()
	content.visible = item != null
	for part in ["OrderDivider", "OrderRow", "Summary", "Perform"]:
		order_box().get_node(part).visible = item != null
	#an improvement has no amount to choose
	order_box().get_node("AmountRow").visible = false
	bench.get_node("EditBar").visible = task != null
	bench.get_node("EditBar/Row/Text").text = tr("CRAFTPANEL_ON_BENCH_NOW")
	content.get_node("Picker").visible = false
	#the work of each step is written on the quality track instead
	content.get_node("Duration").visible = false
	if item == null:
		return
	var steps = []
	var target = null
	if task != null:
		steps = task.steps.slice(task.step, task.steps.size() - 1)
		target = task.steps[task.steps.size() - 1]
	else:
		target = current_target(item)
		if target != null:
			steps = Improving.steps_to(item, target)
	var cost = Improving.total_cost(item, steps)
	if task != null:
		cost.work = max(0.0, cost.work - task.progress)
	build_improve_card(content.get_node("Card/Row"), item, target)
	build_track(content, item, target, task)
	var slots = content.get_node("Slots")
	input_handler.ClearContainer(slots, ['Slot'])
	content.get_node("Wire").visible = true
	#what is still to pay: a step on the bench was paid for when it started
	var unpaid = steps.duplicate()
	if task != null and task.status == 'active' and !unpaid.empty():
		unpaid.pop_front()
	var price = Improving.total_cost(item, unpaid)
	content.get_node("Wire2").visible = price.gold > 0 or !price.materials.empty()
	if price.gold > 0:
		var slot = build_price_slot(slots, GOLD_STOCK, price.gold)
		var split = []
		for quality in unpaid:
			split.append("%s: %d" % [tr("QUALITY" + quality.to_upper()), Improving.step_cost(item, quality).gold])
		globals.connecttexttooltip(slot, tr("CRAFTPANEL_GOLD_BY_STEP") + "\n" + PoolStringArray(split).join("\n"), false, tooltip_node())
	for code in price.materials:
		var slot = build_price_slot(slots, code, price.materials[code])
		var split = []
		for quality in unpaid:
			var each = Improving.step_cost(item, quality).materials.get(code, 0)
			if each > 0:
				split.append("%s: %d" % [tr("QUALITY" + quality.to_upper()), each])
		globals.connectmaterialtooltip(slot, Items.materiallist[code], "\n\n" + tr("CRAFTPANEL_MATERIAL_BY_STEP") + "\n" + PoolStringArray(split).join("\n"), null, item_tooltip_node())
	fit_slots(slots)
	build_improve_order(item, task, target, steps, cost)


#One thing an improvement is paid in, gold or a material, shown the way a recipe's ingredient is.
func build_price_slot(slots, code, need):
	var slot = build_slot(slots, code, need, 1)
	slot.get_node("Box/Head").visible = false
	slot.get_node("Box/Bonus").visible = false
	slot.disabled = true
	return slot


func build_improve_card(card, item, target):
	card.get_node("Frame").visible = false
	card.get_node("Pair").visible = true
	fill_item_icon(card.get_node("Pair/From"), item)
	globals.connectitemtooltip_v2(card.get_node("Pair/From/Item"), item, item_tooltip_node())
	card.get_node("Pair/Arrow").visible = target != null
	card.get_node("Pair/To").visible = target != null
	if target != null:
		fill_item_icon(card.get_node("Pair/To"), item, target)
	card.get_node("Words/Name").text = item.name
	var quality = Improving.current(item)
	var meta = tr("QUALITY" + quality.to_upper())
	if target != null:
		meta += " → " + tr("QUALITY" + target.to_upper())
	else:
		meta += " · " + tr("CRAFTPANEL_HIGHEST")
	card.get_node("Words/Meta/Text").text = meta
	var lines = []
	var owner = item.get_owner()
	if owner != null:
		lines.append(tr("CRAFTPANEL_WORN_BY") % owner.get_short_name())
	if !item.enchants.empty() or item.curse != null:
		var names = []
		for code in item.enchants:
			names.append(tr(Items.enchantments[code].name) + " " + input_handler.roman_number_converter(item.enchants[code]))
		if !names.empty():
			lines.append("{color=k_yellow|" + PoolStringArray(names).join(", ") + "}")
	var data = Items.itemlist.get(item.itembase, null)
	if data != null and data.get('descript', '') != '':
		lines.append(tr(data.descript))
	var before = item.get_bonusstats()
	var after = before if target == null else Improving.stats_at(item, target)
	fill_info(PoolStringArray(lines).join("\n"), tr("CRAFTPANEL_STATS"), stats_text(before, after))


#Each stat as it stands and as it will be, the way the enchanting panel writes its preview.
func stats_text(before, after):
	var codes = before.keys()
	for code in after:
		if !codes.has(code):
			codes.append(code)
	#the enchant capacity goes last, as on the recipe card
	if codes.has('enchant_capacity'):
		codes.erase('enchant_capacity')
		codes.append('enchant_capacity')
	var text = ""
	for code in codes:
		if code == 'enchant_capacity_mod':
			continue
		var now = before.get(code)
		var then = after.get(code, now)
		if !statdata.statdata.has(code) or !(then is int or then is float) or (now != null and !(now is int or now is float)):
			continue
		var data = statdata.statdata[code]
		if data.tags.has('hidden'):
			continue
		var bonus = data.default_bonus
		text += globals.get_bonus_name_string(bonus, data, then)
		text += globals.make_bonus_value_string(bonus, data, now) if now != null else "—"
		if now == null or !is_equal_approx(float(now), float(then)):
			text += " → " + globals.make_bonus_value_string(bonus, data, then)
		text += "\n"
	return text


#The qualities the piece can climb, worst to best, under its card. A higher one is the target;
#everything between is worked on the way.
func build_track(content, item, target, task):
	var track = content.get_node("Track")
	track.visible = true
	input_handler.ClearContainer(track, ['Node'])
	var ladder = Improving.ladder(item)
	var at = ladder.find(Improving.current(item))
	var to = ladder.find(target) if target != null else at
	for i in range(ladder.size()):
		var quality = ladder[i]
		var node = input_handler.DuplicateContainerTemplate(track, 'Node')
		node.get_node("Frame").texture = variables.quality_colors.get(quality)
		item.set_icon(node.get_node("Frame/Item"))
		node.get_node("Frame").material = null
		node.get_node("Frame/Current").visible = i == at
		node.get_node("Frame/Chosen").visible = i > at and i <= to
		node.get_node("Name").text = tr("QUALITY" + quality.to_upper())
		node.get_node("Name").set("custom_colors/font_color", QUALITY_COLORS.get(quality, GREY))
		node.modulate = DIM if i < at else WHITE
		#a step still to come shows its work under the trade's hammer, as the list's chips do
		node.get_node("Hint/Icon").visible = i > at
		node.get_node("Hint/Icon").texture = images.get_icon(job)
		if i == at:
			node.get_node("Hint/Text").text = tr("CRAFTPANEL_NOW_QUALITY")
		elif i > at:
			node.get_node("Hint/Text").text = fmt(Improving.step_cost(item, quality).work)
		else:
			node.get_node("Hint/Text").text = ""
		node.disabled = i <= at or task != null
		node.connect("pressed", self, "set_target", [item.id, quality])
	track.set_meta("span", [at, to])
	track.update()


func set_target(id, quality):
	targets[id] = quality
	rebuild()


func build_improve_order(item, task, target, steps, cost):
	#an improvement has no kind of order to choose, and keeps the piece's enchantments: nothing to say
	var row = order_box().get_node("OrderRow")
	for part in row.get_children():
		part.visible = false
	row.visible = false
	var summary = order_box().get_node("Summary")
	var perform = order_box().get_node("Perform")
	if target == null:
		summary.bbcode_text = tr("CRAFTPANEL_AT_BEST")
		summary.visible = true
		perform.text = tr("CRAFTPANEL_SEND") % tr(RoomTypes.get_name_key(trade_room_type()))
		perform.disabled = true
		return
	var warning = ""
	if task == null:
		var short = Improving.short_of(Improving.step_cost(item, steps[0]))
		if !short.empty():
			warning = "[color=#f9ab5a]" + tr("CRAFTPANEL_SHORT_FIRST_STEP") % names_of(short) + "[/color]"
	summary.bbcode_text = warning
	summary.visible = warning != ""
	if task != null:
		perform.text = tr("CRAFTPANEL_STEP_OF") % [task.step + 1, task.steps.size()]
		perform.disabled = true
	else:
		perform.text = tr("CRAFTPANEL_SEND") % tr(RoomTypes.get_name_key(trade_room_type()))
		perform.disabled = false


func trade_room_type():
	var rooms = trade_rooms()
	if !rooms.empty():
		return rooms[0].room.type
	return {smith = 'forge', tailor = 'tailor_workshop', alchemy = 'alchemy_room', cooking = 'kitchen'}.get(job, 'forge')


func send_to_improve():
	var item = current_item()
	if item == null:
		return
	var target = current_target(item)
	if target == null:
		return
	var id = game_res().add_improve_task(item.id, target)
	if id == null:
		return
	targets.erase(item.id)
	picked_item.erase(job)
	editing = id
	input_handler.PlaySound("itemcreate")
	rebuild()


#### the queue ####

#How each order stands with the turn: being worked, waiting its turn, short of materials, kept in
#stock already, or held back by an endless order above it - and in how many days it is done. The
#same walk process_rooms() takes, top down, skipping what cannot start.
func queue_timeline():
	var res = {orders = {}, acc = 0.0, blocked = false}
	var pw = power()
	var first = true
	for id in game_res().crafting_lists.get(job, []):
		var task = game_res().tasks_progresses.get(id, null)
		if task == null:
			continue
		var state = {status = 'waiting', days = null}
		if task.status == 'stopped':
			state.status = 'stocked'
		elif task.status == 'no_resources' or (task.status == 'init' and game_res().check_recipe_amount(task) <= 0):
			state.status = wait_status(task)
		elif pw <= 0:
			state.status = 'noworkers'
		elif res.blocked:
			state.status = 'held'
		else:
			state.status = 'working' if first else 'waiting'
			first = false
			var left = order_work_left(task)
			if left < 0:
				res.blocked = true
				state.days = -1
			else:
				res.acc += left
				state.days = int(max(1, ceil(res.acc / pw - 0.0001)))
		res.orders[id] = state
	return res


#What an order that cannot start waits for: a recipe for its materials, an improvement for gold
#unless it is short of a material as well.
func wait_status(task):
	if !game_res().is_improve_task(task):
		return 'nomat'
	var cost = game_res().improve_step_cost(task)
	if cost == null:
		return 'nomat'
	return 'nogold' if Improving.short_of(cost) == [GOLD_STOCK] else 'nomat'


#Work still to do on an order, or -1 for one that never ends.
func order_work_left(task):
	if game_res().is_improve_task(task):
		var item = game_res().workshop_item(task.bench)
		if item == null:
			return 0.0
		var left = 0.0
		for i in range(task.step, task.steps.size()):
			left += Improving.step_cost(item, task.steps[i]).work
		return max(0.0, left - task.progress)
	var data = recipe(task.id)
	if data == null:
		return 0.0
	if task.has('continuous'):
		return -1.0
	if task.has('repeat'):
		return max(0.0, task.repeat * float(task.progress_limit) - task.progress)
	if task.has('cap_up'):
		var runs = ceil(max(0, task.cap_up - game_res().crafted_amount(task)) / float(task.resultamount))
		return max(0.0, runs * float(task.progress_limit) - task.progress)
	return 0.0


func build_queue():
	var column = $Body/Columns/Queue
	var list = column.get_node("Scroll/List")
	input_handler.ClearContainer(list, ['Order'])
	var queue = game_res().crafting_lists.get(job, [])
	var timeline = queue_timeline()
	column.get_node("HeaderRow/Power").text = tr("CRAFTPANEL_PER_TURN") % fmt(power())
	for i in range(queue.size()):
		build_queue_row(list, queue, queue[i], i, timeline.orders.get(queue[i], {status = 'waiting', days = null}))
	column.get_node("Empty").text = tr("CRAFTPANEL_QUEUE_EMPTY")
	column.get_node("Empty").visible = queue.empty()


func build_queue_row(list, queue, id, index, state):
	var task = game_res().tasks_progresses.get(id, null)
	if task == null:
		return
	var row = input_handler.DuplicateContainerTemplate(list, 'Order')
	row.pressed = editing == id
	row.arraydata = id
	row.parentnodearray = queue
	row.target_node = self
	row.target_function = 'rebuild'
	var icon = row.get_node("Quality/Item")
	var improve = game_res().is_improve_task(task)
	row.get_node("Up").visible = improve
	var work = float(task.progress_limit)
	if improve:
		var item = game_res().workshop_item(id)
		if item != null:
			row.get_node("Quality").texture = variables.quality_colors.get(task.steps[min(task.step, task.steps.size() - 1)])
			item.set_icon(icon)
			row.get_node("Name").text = item.name
		var sub = tr("QUALITY" + task.from.to_upper()) + " → " + tr("QUALITY" + task.steps[task.steps.size() - 1].to_upper())
		if task.steps.size() > 1:
			sub += " · %d/%d" % [task.step + 1, task.steps.size()]
		row.get_node("Sub").text = sub
	else:
		var data = recipe(task.id)
		row.get_node("Quality").texture = null
		icon.texture = stock_icon(data.resultitem)
		icon.material = null
		if data.crafttype == 'modular' and !task.partdict.empty():
			var made = globals.CreateGearItemQuality(data.resultitem, task.partdict, '')
			made.set_icon(icon)
			row.get_node("Name").text = made.name
		else:
			row.get_node("Name").text = recipe_name(data)
		if task.has('repeat'):
			row.get_node("Sub").text = tr("CRAFTPANEL_ORDER_LEFT") % task.repeat
		elif task.has('continuous'):
			row.get_node("Sub").text = tr("CRAFTPANEL_ORDER_ENDLESS")
		elif task.has('cap_up'):
			row.get_node("Sub").text = tr("CRAFTPANEL_ORDER_KEEP") % [task.cap_low, task.cap_up, game_res().crafted_amount(task)]
	var status = row.get_node("Status")
	status.text = tr("CRAFTPANEL_STATUS_" + state.status.to_upper())
	status.set("custom_colors/font_color", {working = GOOD, nomat = WARNING, nogold = WARNING, noworkers = BAD}.get(state.status, GREY))
	var eta = row.get_node("Eta")
	eta.text = ""
	if state.days != null:
		eta.text = tr("CRAFTPANEL_ONGOING") if state.days < 0 else "≈ " + turns_text(state.days)
	var started = task.status == 'active' or task.progress > 0
	row.get_node("Bar").visible = started and work > 0
	row.get_node("Bar/Fill").anchor_right = clamp(task.progress / max(work, 0.001), 0.0, 1.0)
	var chosen = editing == id
	row.get_node("Actions").visible = chosen
	status.visible = !chosen
	row.get_node("Actions/MoveUp").disabled = index == 0
	row.get_node("Actions/MoveDown").disabled = index == queue.size() - 1
	row.get_node("Actions/MoveUp").connect("pressed", self, "move_order", [id, -1])
	row.get_node("Actions/MoveDown").connect("pressed", self, "move_order", [id, 1])
	row.get_node("Actions/Remove").connect("pressed", self, "ask_remove", [id])
	var confirm = row.get_node("Confirm")
	confirm.visible = confirming == id
	confirm.get_node("Text").text = tr("CRAFTPANEL_STOP_IMPROVE") if improve else tr("CRAFTPANEL_REMOVE_ORDER")
	confirm.get_node("Yes").text = tr("CRAFTPANEL_REMOVE")
	confirm.get_node("No").text = tr("CRAFTPANEL_KEEP")
	confirm.get_node("Yes").connect("pressed", self, "remove_order", [id])
	confirm.get_node("No").connect("pressed", self, "ask_remove", [null])
	row.connect("pressed", self, "pick_order", [id])


#Picking an order on the queue opens it on the bench: a recipe order to change how much of it is
#wanted (its materials were fixed when it was placed), an improvement to see how far it has got.
func pick_order(id):
	var task = game_res().tasks_progresses.get(id, null)
	if task == null:
		return
	confirming = null
	if editing == id:
		editing = null
		rebuild()
		return
	editing = id
	if game_res().is_improve_task(task):
		mode = 'improve'
	else:
		mode = 'craft'
		picked_recipe[job] = task.id
		var data = recipe(task.id)
		if data != null and data.crafttype == 'modular':
			parts[task.id] = task.partdict.duplicate()
		amount = {mode = 'batch', runs = 1, low = 10, high = 40}
		if task.has('repeat'):
			amount.runs = clamp_amount('runs', task.repeat)
		elif task.has('continuous'):
			amount.mode = 'endless'
		elif task.has('cap_up'):
			amount.mode = 'keep'
			amount.low = clamp_amount('low', task.cap_low)
			amount.high = clamp_amount('high', task.cap_up)
			keep_limits_apart('high')
	rebuild()


func move_order(id, step):
	var queue = game_res().crafting_lists.get(job, [])
	var at = queue.find(id)
	var to = at + step
	if at < 0 or to < 0 or to >= queue.size():
		return
	queue.remove(at)
	queue.insert(to, id)
	rebuild()


func ask_remove(id):
	confirming = id
	rebuild()


func remove_order(id):
	confirming = null
	if editing == id:
		editing = null
	if game_res().tasks_progresses.has(id):
		game_res().clean_task(id)
	rebuild()


#### choices ####

func set_job(code):
	if !JOBS.has(code):
		return
	job = code
	editing = null
	picking = null
	confirming = null
	if job == 'cooking':
		mode = 'craft'
	$Body/Columns/Recipes/Search.text = ""
	for column in ["Recipes", "Bench", "Queue", "Crafters"]:
		get_node("Body/Columns/%s/Scroll" % column).scroll_vertical = 0
	rebuild()


func set_mode(value):
	if value == 'improve' and job == 'cooking':
		value = 'craft'
	mode = value
	editing = null
	$Body/Columns/Recipes/Search.text = ""
	$Body/Columns/Recipes/Scroll.scroll_vertical = 0
	rebuild()


func set_filter(value):
	filter = value
	rebuild()


func set_item_filter(value):
	item_filter = value
	rebuild()


func search_changed(_text):
	rebuild()


#### the wires ####

#The lines from the card down to the slots under it: one drop from the card's middle to a bus, one
#drop from the bus to each slot. Drawn after the containers have placed everything.
func refresh_wires():
	var content = $Body/Columns/Bench/Scroll/Content
	content.get_node("Wire").update()
	content.get_node("Wire2").update()
	content.get_node("Track").update()


func draw_wire(wire):
	var content = $Body/Columns/Bench/Scroll/Content
	var slots = content.get_node("Slots")
	var centers = []
	var active = -1
	for slot in shown_children(slots, 'Slot'):
		if slot.pressed:
			active = centers.size()
		centers.append(slot.rect_position.x + slot.rect_size.x / 2.0 + slots.rect_position.x - wire.rect_position.x)
	var middle = wire.rect_size.x / 2.0
	var bottom = wire.rect_size.y
	var to_slots = wire.name == 'Wire2' or (wire.name == 'Wire' and !content.get_node("Track").visible)
	if !to_slots or centers.empty():
		wire.draw_line(Vector2(middle, 0), Vector2(middle, bottom), LINE, WIRE_WIDTH)
		return
	wire.draw_line(Vector2(middle, 0), Vector2(middle, WIRE_BUS), LINE, WIRE_WIDTH)
	var left = min(middle, centers.min())
	var right = max(middle, centers.max())
	wire.draw_line(Vector2(left, WIRE_BUS), Vector2(right, WIRE_BUS), LINE, WIRE_WIDTH)
	for i in range(centers.size()):
		wire.draw_line(Vector2(centers[i], WIRE_BUS), Vector2(centers[i], bottom), LINE_ON if i == active else LINE, WIRE_WIDTH)


func draw_track():
	var track = $Body/Columns/Bench/Scroll/Content/Track
	var nodes = shown_children(track, 'Node')
	if nodes.size() < 2:
		return
	var y = 34.0
	var first = nodes[0].rect_position.x + nodes[0].rect_size.x / 2.0
	var last = nodes[nodes.size() - 1].rect_position.x + nodes[nodes.size() - 1].rect_size.x / 2.0
	track.draw_line(Vector2(first, y), Vector2(last, y), LINE, 3.0)
	var span = track.get_meta("span") if track.has_meta("span") else [0, 0]
	if span[1] > span[0] and span[1] < nodes.size():
		var from = nodes[span[0]].rect_position.x + nodes[span[0]].rect_size.x / 2.0
		var to = nodes[span[1]].rect_position.x + nodes[span[1]].rect_size.x / 2.0
		track.draw_line(Vector2(from, y), Vector2(to, y), LINE_ON, 3.0)
