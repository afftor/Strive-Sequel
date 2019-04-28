extends "res://files/Close Panel Button/ClosingPanel.gd"

var selectedworker

func _ready():
#warning-ignore:return_value_discarded
	$ButtonPanel/PurchaseButton.connect("pressed", self, "purchase")
#warning-ignore:return_value_discarded
	$ButtonPanel/SellButton.connect('pressed', self, 'shop')
	globals.AddPanelOpenCloseAnimation($PurchaseMenu)

func open():
	show()
	input_handler.emit_signal("BuildingEntered", 'market')
	$PurchaseMenu.hide()

func shop():
	globals.CurrentScene.openinventorytrade()

func purchase():
	$PurchaseMenu.show()
	$PurchaseMenu/Label.text = tr("TOTALWORKERS") + ": " + str(state.workers.size()) + '/' + str(state.GetWorkerLimit())
	globals.ClearContainer($PurchaseMenu/ScrollContainer/VBoxContainer)
	for i in TownData.workersdict.values():
		if state.checkreqs(i.unlockreqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($PurchaseMenu/ScrollContainer/VBoxContainer)
		newbutton.get_node("Icon").texture = i.icon
		newbutton.get_node("Label").text = i.name
		newbutton.get_node("Cost").text = str(i.price)
		newbutton.connect("pressed", self, "PurchaseSlave", [i])

func PurchaseSlave(worker):
	if state.workers.size() >= state.GetWorkerLimit():
		input_handler.SystemMessage(tr("WORKERLIMITREACHER"))
		return
	elif state.money < worker.price:
		input_handler.SystemMessage(tr("NOTENOUGHGOLD"))
		return
	selectedworker = worker
	input_handler.ShowConfirmPanel(self, "HireConfirm", "Hire this worker for " + str(worker.price) + "?")

func HireConfirm():
	var newworker = worker.new()
	state.money -= selectedworker.price
	newworker.create(selectedworker)

func show():
	state.CurBuild = "Market"
	.show()

func hide():
	state.CurBuild = ""
	.hide()