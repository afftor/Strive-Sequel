extends Control


onready var CharList = $CharsScroll/VBoxContainer
onready var RightSide = $RightSide/VBoxContainer
onready var LeftSide = $LeftSide/VBoxContainer


var cheat_dict = {
	"max_factors": "Maximize all factors",
	"max_stats": "Maximize all stats",
	"max_loyal_auth": "Maximize affection, respect",
	"max_sex_skills": "Maximize sex skills",
	"unlock_all_sex_traits": "Unlock all sex traits",
	"unlock_classes": "Unlock classes",
	"change_race": "Change Race",
	'add_mastery': "Add mastery points",
}

var cheats = [
	'instant_travel',
	'skip_combat',
	'free_upgrades',
	'instant_upgrades',
	'invincible_player',
	'show_enemy_hp',
	'social_skill_unlimited_charges',
	'unlimited_date_sex',
	'plus_100k_of_gold',
	'plus_10k_of_guild_reputation',
	'unlock_all_classes',
	'add_new_character',
	'add_material',
	'unlock_all_scenes',
	'unlock_extra_floors',
	'slaver_rank_up',
	'regen_slave_quests',
	'plus_50_slaver_tokens',
]

#Pressed once and done, rather than switched on and left on.
var action_cheats = ["instant_upgrades", "plus_100k_of_gold", "plus_10k_of_guild_reputation", "add_new_character", "add_material", 'unlock_all_scenes', 'unlock_extra_floors', 'slaver_rank_up', 'regen_slave_quests', 'plus_50_slaver_tokens']

func _ready():
	gui_controller.add_close_button(self)
	gui_controller.add_close_button($AddItem)
	gui_controller.add_close_button($ClassesModule)



func open():
	$AddItem/NumberSelection3.hide()
	$AddItem.hide()
	$ClassesModule.hide()
	ResourceScripts.core_animations.UnfadeAnimation(self, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	show()
	list_cheats()
	list_characters()
	set_cheat()


func list_cheats():
	input_handler.ClearContainer(LeftSide)
	for cheat in cheats:
		var newbutton = input_handler.DuplicateContainerTemplate(LeftSide)
		newbutton.get_node("Label").text = cheat.capitalize()
		newbutton.connect("pressed", self, "set_cheat", [cheat, newbutton])
		newbutton.set_meta("cheat", cheat)
		if cheat == "instant_upgrades":
			newbutton.get_node("Label").text = "Unlock All Upgrades"
		if cheat == "unlock_all_scenes":
			newbutton.get_node("Label").text = "Unlock All Scenes"
		var font = input_handler.font_size_calculator(newbutton.get_node("Label"))
		newbutton.get_node("Label").set("custom_fonts/font", font)


func set_cheat(cheat = null, btn = null):
	if cheat != null && btn != null && !cheat in action_cheats:
		ResourceScripts.game_globals[cheat] = btn.is_pressed()
	match cheat:
		"instant_upgrades":
			ResourceScripts.game_globals.instant_upgrades = true
			max_all_upgrades()
		"plus_100k_of_gold":
			plus_100k_of_gold()
		"plus_10k_of_guild_reputation":
			plus_10k_of_guild_reputation()
		"add_new_character":
			add_new_character()
		"add_material":
			add_material()
		'unlock_all_scenes':
			unlock_all()
		'unlock_extra_floors':
			unlock_extra_floors()
		'slaver_rank_up':
			slaver_rank_up()
		'regen_slave_quests':
			regen_slave_quests()
		'plus_50_slaver_tokens':
			ResourceScripts.slave_quests.add_tokens(50)
			input_handler.SystemMessage("Tokens of Recognition: %d" % ResourceScripts.slave_quests.get_tokens())
	for button in LeftSide.get_children():
		if button.name == "Button" || button.get_meta("cheat") in action_cheats:
			continue
		button.toggle_mode = !button.get_meta("cheat") in action_cheats # this means 'true' i think
		button.pressed = ResourceScripts.game_globals[button.get_meta("cheat")]


func list_characters():
	input_handler.ClearContainer(CharList)
	for ch in ResourceScripts.game_party.characters.values():
		var newbutton = input_handler.DuplicateContainerTemplate(CharList)
		newbutton.get_node("Name").text = ch.get_full_name()
		newbutton.get_node("Icon").texture = ch.get_icon_small()
		newbutton.connect("pressed", self, "list_character_cheats", [ch, newbutton])

var selected_person

func list_character_cheats(person, button):
	selected_person = person
	$RightSide.show()
	input_handler.ClearContainer(RightSide)
	for cheat in cheat_dict:
		var target_func = cheat
		var newbutton = input_handler.DuplicateContainerTemplate(RightSide)
		newbutton.get_node("Name").text = cheat_dict[cheat]
		newbutton.connect("pressed", self, target_func)
		var font = input_handler.font_size_calculator(newbutton.get_node("Name"))
		newbutton.get_node("Name").set("custom_fonts/font", font)
	for btn in CharList.get_children():
		if btn.name == "Button":
			continue
		btn.pressed = btn == button


var factors_list = [
		"physics_factor",
		"magic_factor",
		"tame_factor",
		"authority_factor",
		"growth_factor",
		"charm_factor",
		"wits_factor",
		"sexuals_factor",
]


func max_factors():
	for factor in factors_list:
		selected_person.set_stat(factor, 6)
	input_handler.SystemMessage("All factors set to maximum")
	gui_controller.mansion.SlaveModule.show_slave_info()


func max_stats():
	var max_stat = 0
	for stat in ['physics','wits','charm']:
		max_stat = selected_person.get_stat(stat+'_factor') * 20
		selected_person.set_stat(stat, max_stat)
	input_handler.SystemMessage("All stats set to maximum")
	gui_controller.mansion.SlaveModule.show_slave_info()


func max_sex_skills():
	for skill in Statlist_init.sex_skills:
		selected_person.set_stat(skill, 100)
	input_handler.SystemMessage("All sex skills set to maximum")
	gui_controller.mansion.SlaveModule.show_slave_info()


func add_mastery():
	selected_person.add_stat('mastery_point_universal', 100)
	input_handler.SystemMessage("100 mastery points added")
	gui_controller.mansion.SlaveModule.show_slave_info()


func max_loyal_auth():
	selected_person.set_stat("affection", 100)
	selected_person.set_stat("respect", 100)
	input_handler.SystemMessage("Affection and respect set to maximum")
	gui_controller.mansion.SlaveModule.show_slave_info()


func unlock_all_sex_traits():
	for trait in Traitdata.sex_traits:
		if Traitdata.sex_traits[trait].get('negative', false):
			continue
		selected_person.add_sex_trait(str(trait), true)
	input_handler.SystemMessage("All sex traits unlocked")
	gui_controller.mansion.SlaveModule.show_slave_info()


func unlock_classes():
	gui_controller.windows_opened.append($ClassesModule)
	$ClassesModule.open(selected_person)


func change_race():
	$CheatRaceChange.select_race(selected_person)
	gui_controller.mansion.SlaveModule.show_slave_info()


func add_material():
	gui_controller.windows_opened.append($AddItem)
	$AddItem.show()
	input_handler.ClearContainer($AddItem/ScrollContainer/VBoxContainer)
	for m in Items.materiallist:
		var item = Items.materiallist[m]
		var newbutton = input_handler.DuplicateContainerTemplate(
			$AddItem/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("Title").text = item.name
		newbutton.get_node("Icon").texture = item.icon
		newbutton.connect("pressed", self, "item_purchase", [item, newbutton])
		globals.connectmaterialtooltip(newbutton, item, 'material')


var purchase_item
var tempitems = []
func item_purchase(item, btn, amount = 10000):
	$AddItem/NumberSelection3.show()
	purchase_item = item
	if amount < 0:
		amount = 100
	var price = 0
	$AddItem/NumberSelection3.open(
		self,
		'add_material_confirm',
		"Add " + str(item.name),
		price,
		1,
		amount,
		true,
		item.icon
	)
	for button in $AddItem/ScrollContainer/VBoxContainer.get_children():
		if button.name == "Button":
			continue
		button.pressed = button == btn

func add_material_confirm(value):
	if Items.materiallist.has(purchase_item.code):
		ResourceScripts.game_res.set_material(purchase_item.code, '+', value)
	elif Items.itemlist.has(purchase_item.code):
		while value > 0:
			match purchase_item.type:
				'usable':
					globals.AddItemToInventory(globals.CreateUsableItem(purchase_item.code))
				'gear':
					globals.AddItemToInventoryShop(globals.CreateGearItem(purchase_item.code, {}))
			value -= 1


func max_all_upgrades():
	for upgrade in upgradedata.upgradelist:
		ResourceScripts.game_res.upgrades[upgrade] = upgradedata.upgradelist[upgrade].levels.keys().back()
	input_handler.SystemMessage("All upgrades set to maximum")
	gui_controller.mansion.SlaveModule.show_slave_info()


func plus_100k_of_gold():
	ResourceScripts.game_res.money += 100000
	input_handler.SystemMessage("100k of gold added")


func plus_10k_of_guild_reputation():
	for i in ResourceScripts.game_world.areas.plains.factions.values():
		i.reputation += 10000
	input_handler.SystemMessage("10k of factions reputation added")

func add_new_character():
	input_handler.get_spec_node(input_handler.NODE_CHARCREATE).open("slave", "none", true)

func unlock_all(): #temporal solution - for unlocks are not gamestate-related
	Gallery.unlock_all()


func unlock_extra_floors():
	var opened = ResourceScripts.game_res.unlock_floors()
	if opened == 0:
		input_handler.SystemMessage("The extra mansion floors are already unlocked")
		return
	ResourceScripts.game_res.rooms_changed()
	input_handler.SystemMessage("%d more mansion floors unlocked" % opened)


func slaver_rank_up():
	var slave_quests = ResourceScripts.slave_quests
	if slave_quests.is_max_rank():
		input_handler.SystemMessage("The slaver rank is already at its highest")
		return
	var progress = slave_quests.get_progress()
	progress.rank_xp = slave_quests.xp_threshold()
	progress.rank_sales = slave_quests.sales_target()
	slave_quests.try_rank_up()
	input_handler.SystemMessage("Slaver rank raised to %s" % slave_quests.get_rank())


func regen_slave_quests():
	var slave_quests = ResourceScripts.slave_quests
	slave_quests.get_quest_pool().clear()
	slave_quests.fill_quests()
	input_handler.SystemMessage("Slave market quests regenerated")
