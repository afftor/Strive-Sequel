extends Control


var tutorials = [
	"introduction",
	# "levelup",
	# "character_list",
	"crafting",
	"traveling",
	"job",
	"quest",
	"exploration",
	"skills"
]

var introduction_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/start_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/start_2.png"),
	2: load("res://assets/Textures_v2/MANSION/Tutorial/start_3.png"),
}

var introduction_text = {
	0: "INTRODUCTIONTUTORIAL1",
	1: "INTRODUCTIONTUTORIAL2",
	2: "INTRODUCTIONTUTORIAL3",
}

var exploration_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/explore_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/explore_2.png"),
	2: load("res://assets/Textures_v2/MANSION/Tutorial/explore_3.png")
}

var exploration_text = {
	0: "EXPLORATIONTUTORIAL1",
	1: "EXPLORATIONTUTORIAL2",
	2: "EXPLORATIONTUTORIAL3"
}


var traveling_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/travel_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/travel_2.png"),
	2: load("res://assets/Textures_v2/MANSION/Tutorial/travel_3.png"),
	3: load("res://assets/Textures_v2/MANSION/Tutorial/travel_4.png"),
	# 4: load("res://assets/Textures_v2/MANSION/Tutorial/travel_5.png"),
}

var traveling_text = {
	0: "TRAVELINGTUTORIAL1",
	1: "TRAVELINGTUTORIAL2",
	2: "TRAVELINGTUTORIAL3",
	3: "TRAVELINGTUTORIAL4",
	# 4: "TRAVELINGTUTORIAL4"
}

var skills_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/skills_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/skills_2.png"),
	2: load("res://assets/Textures_v2/MANSION/Tutorial/skills_3.png"),
	3: load("res://assets/Textures_v2/MANSION/Tutorial/skills_4.png"),
}

var skills_text = {
	0: "SKILLSTUTORIAL1",
	1: "SKILLSTUTORIAL2",
	2: "SKILLSTUTORIAL3",
	3: "SKILLSTUTORIAL4",
}

var craft_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/craft_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/craft_2.png"),
	2: load("res://assets/Textures_v2/MANSION/Tutorial/craft_3.png"),
	3: load("res://assets/Textures_v2/MANSION/Tutorial/craft_4.png"),
	4: load("res://assets/Textures_v2/MANSION/Tutorial/craft_5.png"),
	5: load("res://assets/Textures_v2/MANSION/Tutorial/craft_6.png"),
	6: load("res://assets/Textures_v2/MANSION/Tutorial/craft_7.png"),
	7: load("res://assets/Textures_v2/MANSION/Tutorial/craft_8.png")
}

var craft_text = {
	0: "CRAFTTUTORIAL1",
	1: "CRAFTTUTORIAL2",
	2: "CRAFTTUTORIAL3",
	3: "CRAFTTUTORIAL4",
	4: "CRAFTTUTORIAL5",
	5: "CRAFTTUTORIAL6",
	6: "CRAFTTUTORIAL7",
	7: "CRAFTTUTORIAL8",
}

var job_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/job_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/job_2.png")
}

var job_text = {
	0: "JOBTUTORIAL1",
	1: "JOBTUTORIAL2"
}

var quest_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/quests_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/quests_2.png"),
	2: load("res://assets/Textures_v2/MANSION/Tutorial/quests_3.png"),
}

var quest_text = {
	0: "QUESTTUTORIAL1",
	1: "QUESTTUTORIAL2",
	2: "QUESTTUTORIAL3",
}

onready var TutList = $TutList/VBoxContainer


func _ready():
	gui_controller.add_close_button(self)
	$Back.connect("pressed", self, "change_index", [-1])
	$Forward.connect("pressed", self, "change_index", [1])
	$Hide.connect("pressed", self, "hide")

func open(tutorial = null):
	self.raise()
	$TutorialImage.hide()
	$TutorialText.hide()
	unfade(self)
	yield(get_tree().create_timer(0.5), "timeout")

	input_handler.ClearContainer(TutList)
	for tut in tutorials:
		if ResourceScripts.game_progress.show_tutorial:
			if !tut in ResourceScripts.game_progress.active_tutorials:
				continue
		var newbutton = input_handler.DuplicateContainerTemplate(TutList)
		# newbutton.hide()
		# unfade(newbutton, 0.3)
		newbutton.get_node("Label").text = tut.capitalize()
		newbutton.set_meta("tut", tut)
		newbutton.connect("pressed", self, "show_tutorial_list", [tut])
	if tutorial != null:
		show_tutorial_list(tutorial)


func show_tutorial_list(tut):
	for b in TutList.get_children():
		if !b.has_meta("tut"):
			continue
		b.pressed = b.get_meta("tut") == tut
	# TODO Unnecessary variables dicts etc
	# TODO Optimize match section (delete it to make code more compact)
	var img = {}
	var size = 0
	match tut:
		"introduction":
			img = introduction_images
			size = introduction_images.size() - 1
			text_dict = introduction_text
		"crafting":
			img = craft_images
			size = craft_images.size() - 1
			text_dict = craft_text
		"traveling":
			img = traveling_images
			size = traveling_images.size() - 1
			text_dict = traveling_text
		"job":
			img = job_images
			size = job_images.size() - 1
			text_dict = job_text
		"quest":
			img = quest_images
			size = quest_images.size() - 1
			text_dict = quest_text
		"exploration":
			img = exploration_images
			size = exploration_images.size() - 1
			text_dict = exploration_text
		"skills":
			img = skills_images
			size = skills_images.size() - 1
			text_dict = skills_text
	img_index = 0
	if !ResourceScripts.game_progress.seen_tutorials.has(tut):
		ResourceScripts.game_progress.seen_tutorials.append(tut)
	show_tutorial(img, size)

var img_index = 0
var img_dict = {}
var img_dict_size = 0
var text_dict = {}

func show_tutorial(img, size, idx = 0):
	$TutorialImage.show()
	$TutorialText.show()
	# unfade($TutorialImage, 0.3)
	# TODO This is temporary patch while not all tuts has images
	img_dict = img
	img_dict_size = size
	if img.size() == 0:
		return
	$Back.disabled = idx == 0
	$Forward.disabled = idx == size
	$TutorialImage.texture = img[idx]
	$TutorialText.text = globals.TextEncoder(tr(text_dict[idx]))

func change_index(value):
	img_index += value
	show_tutorial(img_dict, img_dict_size, img_index)



func unfade(window, time = 0.5):
	window.set("modulate", Color(1, 1, 1, 0))
	window.show()
	ResourceScripts.core_animations.UnfadeAnimation(window, time)
	yield(get_tree().create_timer(time), "timeout")
	window.set("modulate", Color(1, 1, 1, 1))

func fade(window):
	# window.set("modulate", Color(1, 1, 1, 1))
	ResourceScripts.core_animations.FadeAnimation(window, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	window.hide()
	# window.set("modulate", Color(1, 1, 1, 0))

