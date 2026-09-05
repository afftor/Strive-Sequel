extends Button
#One piece of work at another location, drawn as a room so the screen reads the same way
#everywhere: a thing with places in it that people are dropped into.
#
#Dungeon seams are the exception the spec calls for - they take as many hands as you send,
#so they show what is left in the ground instead of a row of places to fill. They still
#draw whoever is digging, because a person who cannot be seen cannot be called back.

const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")

var view = null
var entry = null
#set instead of "entry" when this card stands for a plot on the estate grounds
var plot = ''


#Where the row of places ends. Service takes as many people as are sent to it, so the grid
#can be several times taller than the card - it lives in a scroll now, and the scroll has to
#stop at the foot of the card rather than run out the bottom of it.
const PEOPLE_BOTTOM = 156.0


#Output and remaining/worker counts each get a full line. Cards without the second line pull
#their portraits up into that space, so ordinary estate jobs stay compact while dungeon and
#service cards can say both things without truncating either one.
func show_count(value):
	$count.visible = value
	var top = 104.0 if value else 78.0
	$PeopleScroll.rect_position.y = top
	$PeopleScroll.rect_size.y = max(0.0, PEOPLE_BOTTOM - top)


func set_card_icon(texture):
	$icon.texture = texture
	$icon.visible = texture != null
	$name.rect_position.x = 54.0 if $icon.visible else 8.0
	$name.rect_size.x = rect_size.x - $name.rect_position.x - 8.0
	$name.align = Label.ALIGN_LEFT if $icon.visible else Label.ALIGN_CENTER


func setup(view_node, task_entry):
	view = view_node
	entry = task_entry
	set_meta('task', task_entry.id)
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	refresh()


#A plot on the estate grounds. What stands on it is an ordinary room of the layout, so this
#card only has to name it and hand the click on to the room card, which already knows how to
#raise, improve and pull down anything.
func setup_plot(view_node, slot_code):
	view = view_node
	entry = null
	plot = slot_code
	set_meta('plot', slot_code)
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	refresh_plot()


func refresh_plot():
	var room = MansionLayout.get_room(view.grounds_floor(), plot)
	var build = MansionLayout.get_build(view.grounds_floor(), plot)
	show_count(false)
	$PeopleScroll.visible = false
	$Progress.visible = false
	input_handler.ClearContainer($PeopleScroll/People)
	#Set again below if what stands here is worked for something. Cleared first so a building
	#that has just come down stops taking people onto the job it used to do.
	entry = null
	#Only a plot with nothing on it yet is drawn as scaffolding. Improving a building that is
	#already standing keeps its own face and wears a bar, the way the mansion draws it - the
	#card used to be replaced wholesale, so an upgrade took away the slots people were in.
	if build != null and room == null:
		modulate = Color(1, 1, 1, 1)
		set_card_icon(null)
		$name.text = view.build_label(build)
		$output.text = view.build_eta_text(build)
		#Scaffolding needs hands, and this card is the only place they can be put: the grounds
		#are never drawn as a floor plan, so the plan's builder places never appear for them.
		#Without this a barn was paid for and then stood half-built for ever.
		build_plot_places(build)
		show_progress(build)
		globals.connecttexttooltip(self, view.build_eta_text(build), true)
		return
	if room == null:
		#dimmed because it is empty, not disabled: a plot that cannot be clicked reads as
		#broken rather than as somewhere to build
		modulate = Color(1, 1, 1, 0.7)
		set_card_icon(null)
		$name.text = tr("MANSIONVIEW_EMPTYPLOT")
		$output.text = ""
		globals.connecttexttooltip(self, tr("MANSIONVIEW_BUILDHERE"), true)
		return
	modulate = Color(1, 1, 1, 1)
	var data = RoomTypes.get_type(room.type)
	set_card_icon(images.upgrade_icons[data.icon] if images.upgrade_icons.has(data.icon) else null)
	$name.text = tr(RoomTypes.get_name_key(room.type))
	#A building raised to gather something is where that gathering is now done: its places
	#are the job's places, so the card is filled the same way every other piece of work is.
	#A farm holds its own hands in its own room task, the way a mine does, but what they give
	#is decided by their bodies rather than by the building - so there is no one figure to
	#print, and the tooltip lists the materials instead.
	if room.type == 'farm':
		var farm_task = room.task_id
		if farm_task != null and ResourceScripts.game_res.tasks_progresses.has(farm_task):
			entry = LocationTasks.entry_for(farm_task)
			var farm_workers = LocationTasks.workers_of(farm_task)
			$output.text = ""
			build_places(farm_workers, entry.max_workers)
			append_builder_places(build)
			show_progress(build)
			var note = build_tooltip(farm_workers)
			for row in LocationTasks.farm_yield_table(farm_task):
				note += "\n%s +%.1f" % [tr(Items.materiallist[row[0]].name), row[1]]
			globals.connecttexttooltip(self, note, true)
			return
	var gather = LocationTasks.gather_entry_for_room(room.type, plot)
	if gather != null:
		entry = gather
		var workers = LocationTasks.workers_of(gather.id)
		$output.text = LocationTasks.production_text(gather.id)
		build_places(workers, gather.max_workers)
		append_builder_places(build)
		show_progress(build)
		globals.connecttexttooltip(self,
			"%s\n%s" % [build_tooltip(workers), yield_lines(gather.id)], true)
		return
	$output.text = "%s %d" % [tr("MANSIONVIEW_WORKPLACES"),
		MansionLayout.slot_capacity(room, 'work')]
	input_handler.ClearContainer($PeopleScroll/People)
	append_builder_places(build)
	show_progress(build)
	globals.connecttexttooltip(self, tr(RoomTypes.get_descript_key(room.type)), true)


func refresh():
	if plot != '':
		refresh_plot()
		return
	$Progress.visible = false
	if entry == null:
		return
	modulate = target_modulate()
	#service is arranged on a screen of its own, so the card is a door rather than a row of
	#places: it says how many are on it and opens when clicked
	if entry.own_screen:
		set_card_icon(load(entry.icon) if entry.icon != '' else null)
		$name.text = tr(entry.name)
		$output.text = ""
		show_count(true)
		$count.text = "%s %d" % [tr("MANSIONVIEW_WORKERS"),
			LocationTasks.workers_of(entry.id).size()]
		build_places(LocationTasks.workers_of(entry.id), 0)
		globals.connecttexttooltip(self, "%s\n%s" % [tr(entry.descript),
			tr("MANSIONVIEW_SERVICEOPENHINT")], true)
		return
	set_card_icon(load(entry.icon) if entry.icon != '' else null)
	$name.text = tr(entry.name)
	var workers = LocationTasks.workers_of(entry.id)
	$output.text = LocationTasks.production_text(entry.id)
	show_count(entry.unlimited)
	if entry.unlimited:
		#what matters on a seam is how much is left, not how many more can dig
		$count.text = "%s %d" % [tr("MANSIONVIEW_REMAINING"), int(entry.remaining)]
	build_places(workers, 0 if entry.unlimited else entry.max_workers)
	show_quest_progress()
	globals.connecttexttooltip(self, build_tooltip(workers), true)


#A quest makes nothing, so its output line has always been blank and there was no way to see
#how far along it was - only that it was still there. It gets the same bar a building under
#construction gets, and the line above it says what a turn's work will add.
func show_quest_progress():
	if entry == null or !entry.get('quest', false) or entry.progress_limit <= 0:
		return
	$Progress.visible = true
	$Progress.max_value = entry.progress_limit
	$Progress.value = entry.progress
	$Progress/Label.text = "%d/%d" % [int(entry.progress), int(entry.progress_limit)]
	var per_turn = LocationTasks.quest_per_turn(entry.id)
	$output.text = "" if per_turn < 0 else "%s +%s" % [tr("MANSIONVIEW_PERTURN"),
		str(stepify(per_turn, 0.1))]
	#the row of places stops short of the bar rather than running under it
	$PeopleScroll.rect_size = Vector2($PeopleScroll.rect_size.x,
		max(0.0, $Progress.rect_position.y - $PeopleScroll.rect_position.y - 6.0))


#What is being built or improved here, shown the way the mansion's own plan shows it: a bar
#across the foot of the card rather than a card that says something else instead.
func show_progress(build):
	$Progress.visible = build != null
	if build == null:
		return
	$Progress.max_value = build.limit
	$Progress.value = build.progress
	$Progress/Label.text = "%s %d%%" % [view.build_label(build),
		int(build.progress * 100.0 / max(1.0, build.limit))]


#The builders' places on a plot under construction. The cells are the same ones the plan uses,
#told which floor their plot is on - the local tasks screen leaves the plan standing on a floor
#of the house behind it, and a place that did not say so was refused every builder.
func build_plot_places(build):
	input_handler.ClearContainer($PeopleScroll/People)
	append_builder_places(build)


#Scaffolding needs hands whether the plot is bare or already has a building on it, so its
#places are added on top of whatever else the card is showing rather than instead of it -
#the way the mansion's plan appends builders to a room's own row. Improving a building out
#here drew no builders at all, so an upgrade could be paid for and then had nobody to do it.
func append_builder_places(build):
	if build == null:
		return
	var workers = view.build_workers(build)
	var capacity = MansionLayout.build_capacity(MansionLayout.get_room(view.grounds_floor(), plot),
		ResourceScripts.game_res.extra_builder_slots())
	var grounds = MansionLayout.grounds_floor(view.layout())
	$PeopleScroll.visible = true
	for char_id in workers:
		var cell = input_handler.DuplicateContainerTemplate($PeopleScroll/People)
		cell.setup(view, 'build', plot, char_id, grounds)
	for _i in range(max(0, capacity - workers.size())):
		var cell = input_handler.DuplicateContainerTemplate($PeopleScroll/People)
		cell.setup(view, 'build', plot, null, grounds)


#A capped task fills its places out with empty ones; a seam has no places to fill out, so
#it draws the diggers alone and nothing when nobody is on it.
func build_places(workers, capacity):
	input_handler.ClearContainer($PeopleScroll/People)
	$PeopleScroll.visible = !workers.empty() or capacity > 0
	for char_id in workers:
		var cell = input_handler.DuplicateContainerTemplate($PeopleScroll/People)
		cell.setup(view, 'task', entry.id, char_id)
	for _i in range(max(0, capacity - workers.size())):
		var cell = input_handler.DuplicateContainerTemplate($PeopleScroll/People)
		cell.setup(view, 'task', entry.id, null)


#What the building turns out, listed under what it is. A certainty is named on its own; a
#chance says how often. What is not listed is what its upgrades have not opened yet.
func yield_lines(task_id):
	var rows = LocationTasks.production_table(task_id)
	if rows.empty():
		return ""
	var text = tr("MANSIONVIEW_YIELDS")
	for row in rows:
		var name = Items.materiallist[row[0]].name if Items.materiallist.has(row[0]) else row[0]
		if row[1] >= 1.0:
			text += "\n  %s" % tr(name)
		else:
			text += "\n  %s  %d%%" % [tr(name), int(round(row[1] * 100))]
	return text


func build_tooltip(workers):
	var text = tr(entry.name)
	if entry.descript != '':
		text += "\n" + tr(entry.descript)
	if entry.unlimited:
		text += "\n%s %d" % [tr("MANSIONVIEW_REMAINING"), int(entry.remaining)]
		text += "\n%s %d" % [tr("MANSIONVIEW_WORKERS"), workers.size()]
	else:
		text += "\n%s %d/%d" % [tr("MANSIONVIEW_WORKPLACES"), workers.size(), entry.max_workers]
	#a quest says how far along it is rather than what it makes, since it makes nothing
	if entry.get('quest', false) and entry.progress_limit > 0:
		text += "\n%s %d/%d" % [tr("MANSIONVIEW_PROGRESS"),
			int(entry.progress), int(entry.progress_limit)]
		var per_turn = LocationTasks.quest_per_turn(entry.id)
		if per_turn >= 0:
			text += "\n%s +%s" % [tr("MANSIONVIEW_PERTURN"), str(stepify(per_turn, 0.1))]
	var output = LocationTasks.production_text(entry.id)
	if output != "":
		text += "\n%s %s" % [tr("MANSIONVIEW_PERTURN"), output]
	return text


#Somebody in hand goes to work here, the same as dropping them on it. With empty hands
#there is nothing to open - a piece of work out here has no card behind it.
func on_pressed():
	if plot != '':
		#with somebody in hand the building is a place to put them, not a card to open
		if view.picked_char != null and entry != null:
			view.drop_carried_on(self)
			return
		view.open_grounds_card(plot)
		return
	if entry == null:
		#an empty plot: it answers, it just has nothing to offer yet
		input_handler.SystemMessage(tr("MANSIONVIEW_LOCALUPGRADEHINT"))
		return
	if view.picked_char == null:
		#ordinary work is filled the way the whole mansion is - people dropped into its
		#places. Only service has a screen behind it, because what its people are allowed to
		#do is a thing to set rather than a place to stand in.
		if entry.own_screen:
			view.open_task_screen(entry)
		return
	view.drop_carried_on(self)


#Whatever will not take the person in hand steps back, the way the mansion's rooms do.
func target_modulate():
	var carried = view.carried_data()
	if carried == null or can_drop_data(Vector2.ZERO, carried):
		return Color(1, 1, 1, 1)
	return Color(0.5, 0.5, 0.5, 1)


#### the carrying protocol ####

#Dropping onto the body rather than onto a particular place puts them in the first free
#one - and a dungeon seam always has room.
func refusal_for(data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return 'MANSIONVIEW_ERR_VOID'
	#A bare plot is somewhere to build, not somewhere to stand, and while scaffolding is up
	#the cells inside take the builders - the card body has nowhere to put anybody either way.
	#A building that gathers is the exception: it carries its job, so it takes people.
	if plot != '' and entry == null:
		return 'MANSIONVIEW_ERR_VOID'
	#an empty plot: it answers, it just has nothing to offer yet
	if entry == null:
		return 'MANSIONVIEW_LOCALUPGRADEHINT'
	#service takes as many as will go, the same as a seam
	if entry.unlimited or entry.own_screen:
		return ''
	if LocationTasks.workers_of(entry.id).size() >= entry.max_workers:
		return 'MANSIONVIEW_ERR_FULL'
	return ''


func take_carried(data):
	return view.place_character('task', entry.id, data.char_id, null)


func can_drop_data(_position, data):
	return refusal_for(data) == ''


func drop_data(_position, data):
	take_carried(data)
