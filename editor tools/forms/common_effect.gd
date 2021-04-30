extends "res://editor tools/classes/record_panel.gd"

var stat
var id
var newrec = true

onready var typesel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/type
onready var descedit = $MarginContainer/VBoxContainer/HBoxContainer/desc_panel/VBoxContainer/desc

var condtypes = [
		'money_change',
		'material_change',
		'make_story_character',
		'add_timed_event',
		'remove_timed_events',
		'unique_character_changes',
		'start_event',
		'spend_money_for_scene_character',
		'affect_scene_characters',
#		'change_type_scene_characters',
		'active_character_switch',
		'affect_active_character_damage',
		'affect_active_character_stat_set',
		'affect_active_character_stat_add',
		'make_loot',
		'open_loot',
		'update_guild',
		'create_character',
		'main_progress',
		'progress_quest',
		'complete_quest',
		'complete_active_location',
		'reputation',
		'decision',
		'screen_black_transition',
		'start_combat',
		'start_quest_combat',
		'make_quest_location',
		'remove_quest_location',
		'set_music',
		'lose_game',]
var types_desc = [
		'money_change',
		'material_change',
		'make_story_character',
		'add_timed_event',
		'remove_timed_events',
		'unique_character_changes',
		'start_event',
		'spend_money_for_scene_character',
		'affect_scene_characters',
#		'change_type_scene_characters',
		'active_character_switch',
		'affect_active_character - damage',
		'affect_active_character - stat set',
		'affect_active_character - stat add',
		'make_loot',
		'open_loot',
		'update_guild',
		'create_character',
		'main_progress',
		'progress_quest',
		'complete_quest',
		'complete_active_location',
		'reputation',
		'decision',
		'screen_black_transition',
		'start_combat',
		'start_quest_combat',
		'make_quest_location',
		'remove_quest_location',
		'set_music',
		'lose_game',]



func _init():
	tres = {description = ""}
	panel_data = [
		{
			type = editor_core.PANEL_NUM,
			stat = 'value',
			container = 0,
			groups = ['money_change','material_change', 'affect_scene_characters', 'affect_active_character_damage', 'affect_active_character_stat_add', 'affect_active_character_stat_set', 'main_progress', 'reputation', 'screen_black_transition'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'operant',
			container = 0,
			groups = ['money_change','material_change', 'main_progress', 'reputation'],
			rlist = ['+', '-', '='],
			dlist = ['+', '-', '='],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'material',
			container = 0,
			groups = ['material_change'],
			rlist = Items.materiallist.keys(),
			dlist = editor_core.get_list( Items.materiallist, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'value',
			container = 0,
			groups = ['make_story_character', 'unique_character_changes'],
			rlist = worlddata.pregen_characters.keys() + worlddata.easter_egg_characters.keys(),
			dlist = editor_core.get_list(worlddata.pregen_characters, 'name', 'code') + editor_core.get_list(worlddata.easter_egg_characters, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'value',
			container = 0,
			groups = ['add_timed_event'],
			rlist = scenedata.scenedict.keys(),
			dlist = scenedata.scenedict.keys(),
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'args',
			container = 0,
			groups = ['add_timed_event'],
			script = "res://editor tools/panels/add_event_args.gd"
		},
		{
			type = editor_core.PANEL_SELECT,
			stat = 'value',
			container = 0,
			groups = ['remove_timed_events'],
			rlist = scenedata.scenedict.keys(),
			dlist = scenedata.scenedict.keys(),
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'args',
			container = 0,
			groups = ['unique_character_changes'],
			script = "res://editor tools/panels/char_changes_args.gd"
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'data',
			container = 0,
			groups = ['start_event'],
			rlist = scenedata.scenedict.keys(),
			dlist = scenedata.scenedict.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'args',
			container = 0,
			groups = ['start_event'],
			rlist = [[]],
			dlist = ['[]'],
		},
		{
			type = editor_core.PANEL_INT,
			stat = 'value',
			container = 0,
			groups = ['spend_money_for_scene_character', 'active_character_switch'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = ['affect_scene_characters', ],
			rlist = ['all'],
			dlist = ['all'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'stat',
			container = 0,
			groups = ['affect_scene_characters', 'affect_active_character_stat_add', 'affect_active_character_stat_set'],
			rlist = ['hp', 'mp', 'shield', 'base_exp'] + Statlist_init.template.keys(),
			dlist = ['hp', 'mp', 'shield', 'base_exp'] + Statlist_init.template.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = ['affect_active_character_damage', ],
			rlist = ['damage'],
			dlist = ['damage'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = ['affect_active_character_stat_set', ],
			rlist = ['stat_set'],
			dlist = ['stat_set'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = ['affect_active_character_stat_add', ],
			rlist = ['stat_add'],
			dlist = ['stat_add'],
		},
		{
			type = editor_core.PANEL_EDIT,
			stat = 'pool',
			container = 0,
			groups = ['make_loot'],
			script = "res://editor tools/panels/rewards_e.gd"
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'type',
			container = 0,
			groups = ['create_character'],
			rlist = variables.slave_class_list,
			dlist = variables.slave_class_list
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'value',
			container = 0,
			groups = ['progress_quest', 'complete_quest'],
			rlist = scenedata.quests.keys(),
			dlist = editor_core.get_list(scenedata.quests, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'stage',
			container = 0,
			groups = ['progress_quest'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'name',
			container = 0,
			groups = ['reputation'],
			rlist = variables.guild_order,
			dlist = variables.guild_order,
		},
		{
			type = editor_core.PANEL_STRING,
			stat = 'value',
			container = 0,
			groups = ['decision'],
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'value',
			container = 0,
			groups = ['start_combat'],
			rlist = Enemydata.enemygroups.keys(),
			dlist = Enemydata.enemygroups.keys(),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'value',
			container = 0,
			groups = ['make_quest_location', 'remove_quest_location'],
			rlist = worlddata.dungeons.keys(),
			dlist = editor_core.get_list(worlddata.dungeons, 'name', 'code'),
		},
		{
			type = editor_core.PANEL_OPTION,
			stat = 'value',
			container = 0,
			groups = ['set_music'],
			rlist = audio.music.keys(),
			dlist = audio.music.keys(),
		},
	]



func _ready():
	col_containers.push_back($MarginContainer/VBoxContainer/HBoxContainer)
	prew_node = $MarginContainer/VBoxContainer/Label
	build_panels()
	descedit.connect("text_entered", self, 'change_description')
	key = null
	select_code('money_change')

func build_panels():
	for type in types_desc:
		typesel.add_item(type)
	.build_panels()

func get_data(dir = null):
	var data = parent.tres[id].duplicate(true)
	if dir != null: data = dir.duplicate()
	select_code(data.code)
	key = null
	.get_data(data)

func commit():
	tres = parse_json(prew_node.text)
	if tres == null: return
	if tres.has('description') and tres.description == "": tres.erase('description')
	if newrec:
		parent.tres.push_back(tres)
	else:
		parent.tres[id] = tres
	parent.update_val()
	.commit()

func select_code(code):
	tres.clear()
	tres.code = code
	if code.begins_with('affect_active_character'): tres.code = 'affect_active_character'
	for pan in panel_nodes:
		if pan.is_in_group(code): pan.visible = true
		else: pan.visible = false
	update_res()

func select_type(id):
	select_code(condtypes[id])


func change_description(newtext):
	tres.description = newtext
	if newtext == "": tres.erase('description')
	update_res()
