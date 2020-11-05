extends Control


var lootdata

func _ready():
	$Confirm.connect("pressed", gui_controller, "close_scene", [self])

func open(loot): #, message):
	show()
	$AnimationPlayer.play("Loot")

	lootdata = loot
	# $Panel/RichTextLabel.bbcode_text = message
	input_handler.ClearContainer($ScrollContainer/GridContainer)
	var newbutton
	yield(get_tree().create_timer(1.5), "timeout")
	for i in loot.items:
		newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		i.set_icon(newbutton.get_node("TextureRect"))
		newbutton.get_node("AnimationPlayer").play("LootButton")
		yield(get_tree().create_timer(0.3), "timeout")
		newbutton.get_node("Label").text = str(i.amount)
		# if i.amount <= 1:
		# 	newbutton.get_node("Label").hide()
		globals.connectitemtooltip(newbutton, i)
		globals.AddItemToInventory(i)
	for i in loot.materials:
		newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
		newbutton.get_node("AnimationPlayer").play("LootButton")
		yield(get_tree().create_timer(0.3), "timeout")
		newbutton.get_node("Label").text = str(loot.materials[i])
		globals.connectmaterialtooltip(newbutton, Items.materiallist[i])
		ResourceScripts.game_res.materials[i] += loot.materials[i]
