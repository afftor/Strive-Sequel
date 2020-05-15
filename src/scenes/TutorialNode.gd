extends Control
# warning-ignore-all:return_value_discarded

var current_tutorial

var tutorial_themes = {
	introduction = {name = "Introduction", text = "This is your Mansion Screen. At the right side you can see your {color=yellow|Character List}. At the left side is your {color=yellow|Task list}. Make yourself familiar with your characters by clicking on them."},
	slavetab = {name = "Character Tab", text = "This is the character panel. It contains most of the character's information and allows you to control it. Your characters are your main possessions.\nCharacters consume food every day, which is represented by Food Consumption stat on the left. Different characters require different amount of it, which, similar to other stats, often tied to race. Characters can be assigned to work by selecting Job menu. This way you can start utilizing them. "},
	tasklist = {name = "Task List", text = "Task list shows up ongoing tasks. Once progress bar is filled, you receive an item to your storage. You can hover over the task to see what workers are assigned to it. Progress speed can be increased by {color=yellow|Productivity}, some stats, classes and tools related to the task."},
	crafting = {name = "Crafting", text = "To craft an item, select the number of desired items, then assign a worker to task, responsible for production. Resources will be consumed when each new item starts its production. You can unlock more crafts by making upgrades and finding new recipes."},
	upgrades = {name = "Upgrades", text = "After selecting an upgrade, make sure to assign a character to work on it. Physics and Wits, as well as certain classes can improve upgrading speed. It is recommended to start with either {color=yellow|Tailor Workshop or Forge} as those buildings will unlock more crafting recipes. "},
	skills = {name = 'Skills & Obedience', text = "At the bottom of Character's Tab you can see their {color=yellow|Ability Panel}. Social abilities can be used in mansion and most importantly, provide tools to make your chacters Obedient. {color=green|Obedience} is required for characters to work and consumed every work hour. {color=green|Loyal or Submission}, once maxed out, will allow character to work indefinitely. "},
	exploration = {name = 'Exploration Group', text = "To assign characters to active combat party, drag and drop them to corresponding slots. Melee attacks can't target back row until front row is defeated and only do half of the damage when performed from back row normally. "},
	exploration_items = {name = 'Exploration Items&Spells', text = "Healing items and spells can be used in and out of combat. To use them out of combat drag and drop them on characters. Spells will require caster to have sufficient resources and catalysts. Managing your health and resources is essential to successful exploration."},
	levelup = {name = "Leveling", text = "Once character accumulates enough experience, they can unlock a new {color=yellow|Class}. A character can unlock as many classes as needed, as long as they have enough experience for it. Each new class will provide new bonuses to character, but will also increase the amount of required experience for next class."},
	combat = {name = 'Combat', text = "Your goal is to defeat all enemies while taking the least damage possible. Turn order is defined by Speed stat. \n\nEvery ability is either a skill, or spell. Skills are affected by DEF and boosted by Physics, while spells are affected by MDEF and boosted by Wits. Every ability also has an element, which is affected by enemy's resists. To see enemy's stats and resists, hold Right Mouse Button while hovering over them."},
}


func _ready():
	rebuild()
	for i in tutorial_themes:
		tutorial_themes[i].code = i
	$Panel/HBoxContainer/Hide.connect("pressed", self, "hide_text_window")
	$Panel/HBoxContainer/Dismiss.connect("pressed",self, "confirm_message")
	$Panel/HBoxContainer/Stop.connect("pressed",self,'stop_tutorial')

func rebuild():
	if ResourceScripts.game_progress.show_tutorial == false:
		hide_node()
		return
	input_handler.ClearContainerForced($Container)
	for i in ResourceScripts.game_progress.active_tutorials:
		if !tutorial_themes.has(i):
			continue
		var tut_data = tutorial_themes[i]
		var newbutton = input_handler.DuplicateContainerTemplate($Container)
		newbutton.text = tut_data.name
		newbutton.connect('pressed', self, 'show_tutorial_window', [i])
	if $Container.get_child_count() <= 1:
		hide_node()
	else:
		if self.visible == false:
			ResourceScripts.core_animations.UnfadeAnimation(self, 0.3)
			yield(get_tree().create_timer(0.3), 'timeout')
			show()
	
	yield(get_tree().create_timer(0.3), 'timeout')
	raise()

func show_tutorial_window(data):
	current_tutorial = data
	
	$Panel.show()
	$Panel/RichTextLabel.bbcode_text = globals.TextEncoder(tutorial_themes[data].text)

func hide_node():
	ResourceScripts.core_animations.FadeAnimation(self, 0.3)
	yield(get_tree().create_timer(0.3), 'timeout')
	hide()

func hide_text_window():
	$Panel.hide()

func confirm_message():
	hide_text_window()
	ResourceScripts.game_progress.seen_tutorials.append(current_tutorial)
	ResourceScripts.game_progress.active_tutorials.erase(current_tutorial)
	rebuild()

func stop_tutorial():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'stop_tutorial_confirm', "Disable Tutorial Tips?"])
	#input_handler.ShowConfirmPanel(self, 'stop_tutorial_confirm', "Disable Tutorial Tips?")

func stop_tutorial_confirm():
	ResourceScripts.game_progress.show_tutorial = false
	rebuild()
