extends Control


var tutorials = [
	"introduction",
	"levelup",
	"character_list",
	"crafting",
	"traveling",
	"job",
	"quest",
	"exploration"

]

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

var job_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/job_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/job_2.png")
}

var quest_images = {
	0: load("res://assets/Textures_v2/MANSION/Tutorial/quests_1.png"),
	1: load("res://assets/Textures_v2/MANSION/Tutorial/quests_2.png"),
	2: load("res://assets/Textures_v2/MANSION/Tutorial/quests_3.png"),
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
	unfade(self)
	yield(get_tree().create_timer(0.5), "timeout")

	input_handler.ClearContainer(TutList)
	for tut in tutorials:
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

	var img = {}
	var size = 0
	match tut:
		"character_list":
			pass
		"crafting":
			img = craft_images
			size = craft_images.size() - 1
		"traveling":
			pass
		"job":
			img = job_images
			size = job_images.size() - 1
		"quest":
			img = quest_images
			size = quest_images.size() - 1
	img_index = 0
	show_tutorial(img, size)

var img_index = 0
var img_dict = {}
var img_dict_size = 0

func show_tutorial(img, size, idx = 0):
	unfade($TutorialImage, 0.3)
	# TODO This is temporary patch while not all tuts has images
	if img.size() == 0:
		return
	img_dict = img
	img_dict_size = size
	$Back.disabled = idx == 0
	$Forward.disabled = idx == size
	$TutorialImage.texture = img[idx]
	$TutorialText.text = str(img[idx]) #TODO Temporary

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

