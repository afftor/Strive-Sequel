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
		newbutton.get_node("Label").text = str(i.amount)
		# if i.amount <= 1:
		# 	newbutton.get_node("Label").hide()
		globals.connectitemtooltip_v2(newbutton, i)
		globals.AddItemToInventory(i)
		yield(get_tree().create_timer(0.2), "timeout")
	for i in loot.materials:
		if loot.materials[i] <= 0:
			continue
		newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
		newbutton.get_node("AnimationPlayer").play("LootButton")
		newbutton.get_node("Label").text = str(loot.materials[i])
		globals.connectmaterialtooltip(newbutton, Items.materiallist[i])
		ResourceScripts.game_res.materials[i] += loot.materials[i]
		yield(get_tree().create_timer(0.2), "timeout")
	if loot.gold > 0:
		newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.get_node("TextureRect").texture = load("res://assets/images/iconsitems/gold.png")
		newbutton.get_node("AnimationPlayer").play("LootButton")
		newbutton.get_node("Label").text = str(loot.gold)
		globals.connecttexttooltip(newbutton, 'Gold')
		ResourceScripts.game_res.update_money('+', loot.gold)
		yield(get_tree().create_timer(0.2), "timeout")
