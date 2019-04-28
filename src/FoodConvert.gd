extends "res://files/Close Panel Button/ClosingPanel.gd"

var ItemsToConvert = {}

func _ready():
#warning-ignore:return_value_discarded
	$Exchange.connect("pressed", self, 'exchange')

func open():
	show()
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	
	for i in state.items.values():
		if i.foodvalue != null && i.foodvalue > 0:
			var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.get_node("Name").text = i.name
			newbutton.texture = load(i.icon)
			newbutton.get_node("Number").text = str(i.amount)
			newbutton.get_node("Value").text = str(i.foodvalue)
			newbutton.get_node("Left").connect("pressed",self,"Reduce", [i])
			newbutton.get_node("Right").connect("pressed",self,"Increase", [i, newbutton])
	update()

func Reduce(item):
	if ItemsToConvert.has(item.code) == false:
		return
	ItemsToConvert[item.code].amount -= 1
	if ItemsToConvert[item.code].amount <= 0:
		ItemsToConvert.erase(item.code)
	update()

func Increase(item, node):
	if ItemsToConvert.has(item.code):
		if ItemsToConvert[item.code].amount < item.amount:
			ItemsToConvert[item.code].amount += 1
	else:
		ItemsToConvert[item.code] = {item = item, amount = 1, node = node}
	update()

func update():
	$CurFood.text = tr("CURRENTFOOD") + ": " + str(state.food)
	var endfood = 0
	for i in ItemsToConvert.values():
		endfood += i.item.foodvalue*i.amount
		i.node.get_node("Amount").text = str(i.amount)
	$EndFood.text = tr("GAINFOOD") + ": " + str(endfood)
	

func exchange():
	for i in ItemsToConvert.values():
		state.food += i.item.foodvalue*i.amount
		i.item.amount -= i.amount
	ItemsToConvert.clear()
	open()
