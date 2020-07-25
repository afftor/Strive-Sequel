extends Panel


var sell_category = 'all'
var buy_category = 'all'
var is_shop_opened = false

onready var SlaveMarket = get_parent().get_node("ExploreHireModule")
onready var Quests = get_parent().get_node("QuestBoardModule")


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in $SellFilter.get_children():
		i.connect('pressed',self,'selectcategory', [i, "sell"])
	for i in $BuyFilter.get_children():
		i.connect('pressed',self,'selectcategory', [i, "buy"])

func selectcategory(button, list):
	var type = button.name
	if list == "sell":
		for i in $SellFilter.get_children():
			i.pressed = i == button
		sell_category = type
		update_sell_list()
	else:
		for i in $BuyFilter.get_children():
			i.pressed = i == button
		buy_category = type
		update_buy_list()


func open_shop(shop):
	get_parent().clear_submodules()
	get_parent().submodules.append(self)
	SlaveMarket.is_slave_market_opened = false
	Quests.is_quest_board_opened = false
	get_parent().City.Guild.hide()
	get_parent().City.get_node("GuildMenuBG").hide()
	get_parent().City.opened_guild = {code = ""}
	get_parent().City.update_buttons("shop")
	is_shop_opened = !is_shop_opened
	if !is_shop_opened:
		hide()
		return
	show()
	match shop:
		'area':
			get_parent().active_shop = get_parent().active_area.shop
		'location':
			get_parent().active_shop = get_parent().active_location.shop
	sell_category = 'all'
	buy_category = 'all'
	$SellFilter.get_child(0).pressed = true
	$BuyFilter.get_child(0).pressed = true
	update_sell_list()
	update_buy_list()

func get_item_category(item):
	var type
	if Items.materiallist.has(item.code):
		if item.type == 'food':
			type = 'food'
		else:
			type = 'material'
	else:
		if item.itemtype == 'tool':
			type = 'tool'
		elif item.itemtype == 'weapon':
			type = 'weapon'
		elif item.itemtype == 'armor':
			if item.geartype == 'costume':
				type = 'costume'
			else:
				type = 'armor'
		else:
			type = 'usable'
	return type

var tempitems = []

func update_sell_list():
	input_handler.ClearContainer($SellBlock/ScrollContainer/VBoxContainer)
	tempitems.clear()
	for i in ResourceScripts.game_res.materials:
		if ResourceScripts.game_res.materials[i] <= 0:
			continue
		var item = Items.materiallist[i]
		var type = get_item_category(item)
		var newbutton = input_handler.DuplicateContainerTemplate($SellBlock/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = item.name
		newbutton.get_node("icon").texture = item.icon
		newbutton.get_node("price").text = str(item.price)
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(ResourceScripts.game_res.materials[i])
		newbutton.set_meta('type', type)
		newbutton.connect("pressed",self,"item_sell", [item])
		newbutton.visible = (newbutton.get_meta("type") == sell_category) || sell_category == "all"
		globals.connectmaterialtooltip(newbutton, item)
	for item in ResourceScripts.game_res.items.values():
		var type = get_item_category(item)
		if item.owner != null:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($SellBlock/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = item.name
		item.set_icon(newbutton.get_node("icon"))#.texture = item.get_icon()
		newbutton.get_node("price").text = str(item.calculateprice()/2)
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(item.amount)
		newbutton.set_meta('type', type)
		newbutton.connect("pressed",self,"item_sell", [item])
		newbutton.visible = (newbutton.get_meta("type") == sell_category) || sell_category == "all"
		globals.connectitemtooltip(newbutton, item)


func update_buy_list():
	var active_shop = get_parent().active_shop
	input_handler.ClearContainer($BuyBlock/ScrollContainer/VBoxContainer)
	tempitems.clear()
	for i in active_shop:
		if Items.materiallist.has(i):
			var item = Items.materiallist[i]
			var amount = -1
			if typeof(active_shop) == TYPE_DICTIONARY:
				amount = active_shop[i]
			if amount == 0:
				continue
			var type = get_item_category(item)
			var newbutton = input_handler.DuplicateContainerTemplate($BuyBlock/ScrollContainer/VBoxContainer)
			newbutton.get_node("name").text = item.name
			newbutton.get_node("icon").texture = item.icon
			newbutton.get_node("price").text = str(item.price)
			newbutton.set_meta('type', type)
			newbutton.connect("pressed",self,"item_purchase", [item, amount])
			newbutton.visible = (newbutton.get_meta("type") == buy_category) || buy_category == "all"
			globals.connectmaterialtooltip(newbutton, item, 'material')
			if amount > 0:
				newbutton.get_node("amount").text = str(amount)
				newbutton.get_node("amount").show()
		elif Items.itemlist.has(i):
			var item = Items.itemlist[i]
			var amount = -1
			if item.has('parts'):
				amount = 1
			else:
				amount = active_shop[i]
				if amount == 0:
					continue
			var type = get_item_category(item)
			var newbutton = input_handler.DuplicateContainerTemplate($BuyBlock/ScrollContainer/VBoxContainer)
			newbutton.get_node("name").text = item.name
			newbutton.get_node("icon").texture = item.icon
			newbutton.get_node("price").text = str(item.price)
			newbutton.set_meta('type', type)
			newbutton.visible = (newbutton.get_meta("type") == buy_category) || buy_category == "all"
			if item.has('parts'):
				var newitem = globals.CreateGearItem(i, active_shop[i], {}, null)
				newitem.set_icon(newbutton.get_node('icon'))
				newbutton.get_node("name").text = newitem.name
				tempitems.append(newitem)
				globals.connectitemtooltip(newbutton, newitem)
				newbutton.get_node("price").text = str(newitem.calculateprice())
				newbutton.connect('pressed', self, "item_purchase", [newitem, amount])
			else:
				globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
				newbutton.connect('pressed', self, "item_purchase", [item, amount])
			if amount > 0:
				newbutton.get_node("amount").text = str(amount)
				newbutton.get_node("amount").show()


var purchase_item
func item_purchase(item, amount):#(targetnode = null, targetfunction = null, text = '', cost = 0, minvalue = 0, maxvalue = 100, requiregold = false)
	purchase_item = item
	if amount < 0:
		amount = 100
	var price = 0
	if typeof(item) == TYPE_OBJECT:
		price = item.calculateprice()
	else:
		price = item.price
	$NumberSelection.open(self, 'item_puchase_confirm', "Purchase $n " + item.name + "? Total cost: $m", price, 0, amount, true)


# func select_shop_category(category):
# 	for i in $HBoxContainer.get_children():
# 		i.pressed = i.name == category
# 	$NumberSelection.hide()
# 	get_parent().shopcategory = category
# 	update_sell_list()


func item_puchase_confirm(value):
	var active_shop = get_parent().active_shop
	input_handler.PlaySound("money_spend")
	if typeof(purchase_item) == TYPE_OBJECT:
		globals.AddItemToInventory(purchase_item)
		ResourceScripts.game_res.money -= purchase_item.calculateprice()
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
		for i in active_shop:
			if purchase_item.itembase == i && str(purchase_item.parts) == str(active_shop[i]):
				active_shop.erase(i)
				break
		update_sell_list()
		update_buy_list()
	else:
		if Items.materiallist.has(purchase_item.code):
			ResourceScripts.game_res.set_material(purchase_item.code, '+', value)
			ResourceScripts.game_res.money -= purchase_item.price*value
			if typeof(active_shop) == TYPE_DICTIONARY:
				active_shop[purchase_item.code] -= value
		elif Items.itemlist.has(purchase_item.code):
			ResourceScripts.game_res.money -= purchase_item.price*value
			if typeof(active_shop) == TYPE_DICTIONARY:
				active_shop[purchase_item.code] -= value
			while value > 0:
				match purchase_item.type:
					'usable':
						globals.AddItemToInventory(globals.CreateUsableItem(purchase_item.code))
					'gear':
						globals.AddItemToInventory(globals.CreateGearItem(purchase_item.code, {}))
				value -= 1
		update_sell_list()
		update_buy_list()


func item_sell(item):
	purchase_item = item
	var price = item.price
	var sellingamount
	if Items.materiallist.has(item.code) == false:
		price = item.calculateprice()/2
		sellingamount = item.amount
	else:
		sellingamount = ResourceScripts.game_res.materials[item.code]
	$NumberSelection.open(self, 'item_sell_confirm', "Sell $n " + item.name + "? Gained gold: $m", price, 0, sellingamount, false)

func item_sell_confirm(value):
	input_handler.PlaySound("money_spend")
	var price = purchase_item.price
	if Items.materiallist.has(purchase_item.code):
		ResourceScripts.game_res.set_material(purchase_item.code, '-', value)
	else:
		price = round(purchase_item.calculateprice()/2)
		purchase_item.amount -= value
	ResourceScripts.game_res.money += price*value
	update_sell_list()
	update_buy_list()
