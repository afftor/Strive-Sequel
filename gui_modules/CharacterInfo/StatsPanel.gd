extends Control

var stats_to_show = {}
onready var search_filter = $SearchFilter
onready var container = $ScrollContainer/VBoxContainer
onready var info_node = $InfoLabel
var person
var pressed_btn

var categories = {
	combat = "SHOWSTAT_CAT_COMBAT",
	non_combat = "SHOWSTAT_CAT_NON_COMBAT",
}

func _ready():
	gui_controller.add_close_button(self, "add_offset")
	search_filter.connect("text_changed", self, 'filter_changed')
	
	var stats_to_sort = {}
	for category in categories:
		stats_to_sort[category] = []
		stats_to_show[category] = []
	for stat in statdata.statdata:
		var st_data = statdata.statdata[stat]
		if st_data.has('show_info'):
			stats_to_sort[st_data.show_info.category].append([st_data.name, stat])
	
	for category in stats_to_sort:
		stats_to_sort[category].sort_custom(self, '_sort_stats')
		for stat in stats_to_sort[category]:
			stats_to_show[category].append(stat[1])


func show():
	.show()
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)


func _sort_stats(a, b):
	if a[0] < b[0]:
		return true
	return false

func filter_changed(text):
	if text.empty():
		for btn in container.get_children():
			btn.visible = btn.has_meta("stat_name")
		return
	for btn in container.get_children():
		if !btn.has_meta("stat_name"):
			btn.visible = false
			continue
		var stat_name = btn.get_meta("stat_name")
		btn.visible = (stat_name.findn(text) != -1
			or stat_name == "_cat"
		)

func make_stats(person_input):
	info_node.bbcode_text = ""
	person = person_input
	input_handler.ClearContainer(container, ['Button', 'Label'])
	
	for category in stats_to_show:
		var new_label = input_handler.DuplicateContainerTemplate(container, 'Label')
		new_label.text = tr(categories[category])
		new_label.set_meta("stat_name", "_cat")#for filter_changed()
		for stat in stats_to_show[category]:
			var st_data = statdata.statdata[stat]
			var value = person.get_stat(stat)
			if value == 0 and st_data.show_info.has("hide_if_0"):
				continue
			if value == 1 and st_data.show_info.has("hide_if_1"):
				continue
			
			var new_button = input_handler.DuplicateContainerTemplate(container, 'Button')
			new_button.text = "   %s: %s" % [st_data.name, value]
			new_button.set_meta("stat_name", st_data.name)
			new_button.connect("pressed", self, "select_stat", [stat, new_button])
	
	if !search_filter.text.empty():
		filter_changed(search_filter.text)
	
	make_metrics()

#func form_bonus_text(bonus_type, src_type, src_value, value_raw):
#	var color = "green|+"
#	if value_raw < 0:
#		color = "red|"
#	var format
#	var value = value_raw
#	if bonus_type in ['add', 'add2']:
#		format = '\n%s: {color=%s%s}'
#	elif bonus_type in ['add_part', 'add_part2']:
#		format = '\n%s: {color=%s%s%%}'
#		value *= 100
#	elif bonus_type in ['mul', 'mul2']:
#		color = "green|*"
#		if value_raw < 1:
#			color = "red|*"
#		format = '\n%s: {color=%s%s}'
#	return format % [globals.get_tr_src(src_type, src_value)[1], color, value]

func add_to_temp_dict(dict, bonus_type, src_type, src_value, value):
	if !dict.has(src_type):
		dict[src_type] = {}
	if !dict[src_type].has(src_value):
		dict[src_type][src_value] = value
	elif bonus_type == 'mul':
		dict[src_type][src_value] *= value
	else:
		dict[src_type][src_value] += value

func select_stat(stat, btn):
	if pressed_btn and is_instance_valid(pressed_btn):
		pressed_btn.pressed = false
	pressed_btn = btn
	pressed_btn.pressed = true
	
	var st_data = statdata.statdata[stat]
	var value = person.get_stat(stat, false, true)
	var compo_dict = person.get_stat_composition_dict()
#	print(stat, " ", compo_dict)
	
	var order = ['add', 'add_part', 'mul', 'set', 'maxcap', 'mincap']
	if st_data.has('custom_order'):
		order = st_data.custom_order
	var temp_text = ""
	for bonus_type in order:
		if bonus_type in ['maxcap', 'mincap']:
			continue#still not sure how to process this
		if compo_dict.bonuses.has(bonus_type):
			var dict_to_add = {}
			for rec in compo_dict.bonuses[bonus_type]:
				if rec.value == 0:
					continue
				add_to_temp_dict(dict_to_add, bonus_type, rec.src_type, rec.src_value, rec.value)
			for src_type in dict_to_add:
				for src_value in dict_to_add[src_type]:
					var tr_src = globals.get_tr_src(src_type, src_value)
					var src_cat = tr_src[0]
					if !src_cat.empty():
						src_cat = "{color=yellow|%s} - " % src_cat
					temp_text += "\n%s%s: %s" % [
						src_cat, tr_src[1],
						globals.make_bonus_value_string(bonus_type,
							st_data,
							dict_to_add[src_type][src_value]
						)
					]
	
	var text = "%s\n\n%s: %s" % [person.translate(st_data.descript),
		tr("ARMORBASE"), compo_dict.base_value
	]
	if !temp_text.empty():
		text += "%s\n%s: %s" % [temp_text, tr("SHOWSTAT_FINAL"), value]
	info_node.bbcode_text = globals.TextEncoder(text)


var sources = {
	brothel_customer = tr("METRICS_SOURCE_BROTHEL_CUSTOMER"),
	guild_trainer = tr("METRICS_SOURCE_GUILD_TRAINER") ,
	william = tr("METRICS_SOURCE_WILLIAM"),
	unknown = tr("METRICS_SOURCE_UNKNOWN"),
}


func make_metrics():
	var text = ""
	if person.is_players_character:
		if person.is_master():
			text += tr("METRICS_BASE_YOU") % ResourceScripts.game_globals.get_week_and_day_custom(ResourceScripts.game_globals.date - person.get_stat('metrics_ownership'))
		else:
			text += tr("METRICS_BASE") % ResourceScripts.game_globals.get_week_and_day_custom(ResourceScripts.game_globals.date - person.get_stat('metrics_ownership'))
	if person.is_master():
		text += "\n\n" + tr("METRICS_DATES_MASTER") % [person.get_stat('metrics_dates'), person.get_stat('metrics_sex')] + " "
	else:
		text += "\n\n" + tr("METRICS_DATES") % [person.get_stat('metrics_dates'), person.get_stat('metrics_sex')] + " "
	var partner_number = person.get_stat('metrics_partners').size() + person.get_stat('metrics_randompartners')
	var no_sex = false
	if partner_number == 0:
		text += tr("METRICS_PARTNERS_NONE")
		no_sex = true
	elif partner_number == 1:
		text += tr("METRICS_PARTNERS_ONE")
	else:
		text += tr("METRICS_PARTNERS") % partner_number
	
	if no_sex == false:
		text += "\n"
		if person.get_stat('has_womb') == true:
			text += tr("METRICS_IMPREGS") % [person.get_stat('metrics_pregnancy'), person.get_stat('metrics_birth')]
		if person.get_stat('penis_size') != '':
			text += tr("METRICS_PREGNANCIES") % [person.get_stat('metrics_impregnation')]
	
		if person.get_stat('vaginal_virgin_lost') != null:
			if person.get_stat('vaginal_virgin_lost').begins_with('hid'):
				var source = ResourceScripts.game_party.relativesdata[person.get_stat('vaginal_virgin_lost')]
				
				if source.id == ResourceScripts.game_party.get_master().id:
					text += "\n" + tr("METRICS_VIRGINITY_YOU")
				else:
					text += "\n" +  tr("METRICS_VIRGINITY_OTHER") % source.name# + source.name + "}. "
			else:
				var source_str = person.get_stat('vaginal_virgin_lost')
				if source_str != 'unknown':
					if !sources.has(source_str):
						push_error("No name for source of vaginal_virgin_lost: %s" % source_str)
						source_str = 'unknown'
					text += "\n" + tr("METRICS_VIRGINITY_OTHER") % sources[source_str]
		
		if person.get_stat('anal_virgin_lost') != null:
			if person.get_stat('anal_virgin_lost').begins_with('hid'):
				var source = ResourceScripts.game_party.relativesdata[person.get_stat('anal_virgin_lost')]
				
				if source.id == ResourceScripts.game_party.get_master().id:
					text += "\n" + tr("METRICS_ANAL_VIRGINITY_YOU")
				else:
					text += "\n" + tr("METRICS_ANAL_VIRGINITY_OTHER") % source.name 
			else:
				var source_str = person.get_stat('anal_virgin_lost')
				if source_str != 'unknown':
					if !sources.has(source_str):
						push_error("No name for source of anal_virgin_lost: %s" % source_str)
						source_str = 'unknown'
					text += "\n"+ tr("METRICS_ANAL_VIRGINITY_OTHER") % sources[source_str]
	
	text += '\n\n' + tr("METRICS_EARNED") % [person.get_stat("metrics_goldearn"), person.get_stat("metrics_foodearn"),person.get_stat("metrics_materialearn")]
	text += "\n\n" + tr("METRICS_COMBAT") % [person.get_stat("metrics_win"), person.get_stat("metrics_kills"),]
	text = person.translate(globals.TextEncoder(text))
	
	$MetricsPanel/RichTextLabel.bbcode_text = text
