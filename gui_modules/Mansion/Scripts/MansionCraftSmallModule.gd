extends Panel

func _ready():
	$ButtonConfirm.connect("pressed", self, "assign_person_to_task")
	$ButtonBack.connect("pressed", self, "return_to_craft")

func update():
	for i in $categories2.get_children():
		i.pressed = i.name == (get_parent().selected_craft_task)
	$ButtonConfirm.disabled = (get_parent().persons_for_craft == [])

func assign_person_to_task():
	var craft = get_parent().selected_craft_task
	for person in get_parent().persons_for_craft:
		person.assign_to_task(craft, craft)
	get_parent().craft_state = "default"
	get_parent().is_craft_selected = false
	get_parent().match_state()
	# get_parent().CraftModule.get_node("SelectCharacters").disabled = true
	get_parent().persons_for_craft.clear()
	hide()

func return_to_craft():
	hide()
	get_parent().CraftModule.show()
