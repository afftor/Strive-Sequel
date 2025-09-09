extends Panel

onready var quest_panel = $QuestPanel
onready var quest_cont = $ScrollContainer/VBoxContainer
onready var take_btn = $TakeButton
#onready var cancel_btn = $CancelButton

var cur_quest_id

func _ready():
	take_btn.connect("pressed", self, "take_quest")
#	cancel_btn.connect("pressed", self, "cancel_quest")
	take_btn.hide()
#	cancel_btn.hide()
	quest_panel.hide_all()
	ResourceScripts.slave_quests.connect("quests_regened", self, "build_quest_list")

#func open():
#	build_quest_list()
#	show()

func build_quest_list():
	var slave_quests = ResourceScripts.slave_quests
	var quest_pool = slave_quests.get_quest_pool()
	if quest_pool.empty():
		slave_quests.regen_quests()
		return#build_quest_list() will be recalled by signal
	input_handler.ClearContainer(quest_cont)
	quest_panel.hide_all()
	take_btn.hide()
	for quest_id in quest_pool:
		if !slave_quests.is_quest_open(quest_id):
			continue
		var quest = quest_pool[quest_id]
		var new_node = input_handler.DuplicateContainerTemplate(quest_cont)
		slave_quests.process_faction_icon(new_node.get_node('fact'), quest.faction)
		var btn = new_node.get_node('btn')
		btn.text = quest.name
		btn.connect("pressed", self, "show_quest", [quest_id])


func show_quest(quest_id):
	quest_panel.show()
	var slave_quests = ResourceScripts.slave_quests
	cur_quest_id = quest_id
	var quest = slave_quests.get_quest(quest_id)
	quest_panel.show_info(quest)
	take_btn.visible = slave_quests.is_quest_open(quest_id)
#	cancel_btn.visible = slave_quests.is_quest_active(quest_id)

func take_quest():
	var slave_quests = ResourceScripts.slave_quests
	if !slave_quests.if_can_take_quest():
		return
	slave_quests.activate_quest(cur_quest_id)
	var quest = slave_quests.get_quest(cur_quest_id)
	var args = {}
	args["label"] = tr("QUESTTASKACQ")
	args["info"] = tr(quest.name)
	args["sound"] = "quest_aquired"
	input_handler.play_animation("quest", args)
	build_quest_list()

#func cancel_quest():
#	ResourceScripts.slave_quests.fail_quest(cur_quest_id)
#	quest_panel.hide()
#	build_quest_list()


