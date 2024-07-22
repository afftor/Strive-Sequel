extends ItemList
class_name table_display

var tables_arr = [worlddata.lands, worlddata.locations, worlddata.factiondata, worlddata.questdata, DungeonData.dungeons, races.racelist, classesdata.professions, worlddata.pregen_characters, Skilldata.Skilllist, Effectdata.effect_table, Effectdata.atomic, Effectdata.buffs]
var tables_mod_arr = ['w_lands', 'w_locations', 'w_factions', 'w_quests', 'w_dungeons', 'races', 'classes', 'w_characters', 'skills', 'effects', 'atomic_effects', 'buffs']
var editors_arr = [editor_core.land_scene, editor_core.location_scene, editor_core.factiondata_scene, editor_core.questdata_scene, editor_core.dungeons_scene, editor_core.race_scene, editor_core.professions_scene, editor_core.pregen_c_scene, editor_core.skil_scene, editor_core.effect_scene, editor_core.atomic_scene, editor_core.buff_scene]
enum Tables {Lands, Locations, FactionData, QuestData, Dundeons, Races, Professions, Character, Skills, Effects, AtomicEffects, EffectsVisuals}
export(Tables) var type

var table
var table_mod

func _ready():
	table = tables_arr[type]
	setup_tables()
	rebuild_list()

func setup_tables():
	if editor_core.current_table != null and  modding_core.tables[editor_core.current_table].has(tables_mod_arr[type]):
		table_mod = modding_core.tables[editor_core.current_table][tables_mod_arr[type]]
	else: table_mod = {}

func rebuild_list():
	unselect_all()
	clear()
	for key in table: add_item(key)
	for i in range(get_item_count()):
		var tmp = get_item_text(i)
		if table_mod.has(tmp):
			set_item_custom_fg_color(i, Color(1, 1, 0, 1))
		else:
			set_item_custom_fg_color(i, Color(0, 1, 0, 1))

func get_selected():
	if get_selected_items().size() != 1: return null
	return get_selected_items()[0]

func get_selected_data():
	var pos = get_selected()
	if pos == null: return null
	return table[get_item_text(pos)]

func get_selected_text():
	var pos = get_selected()
	if pos == null: return null
	return get_item_text(pos)

func get_editor_scene():
	return editors_arr[type]

func get_subtable_name():
	return tables_mod_arr[type]
