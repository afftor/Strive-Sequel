extends Panel

var item_category := "all"
var active_shop := {}
var tempitems := []
var purchase_item
var current_pressed_area_btn setget set_area_btn_pressed
onready var search_filter: LineEdit = $SearchFilter


func _ready():
	for button in $ItemFilter.get_children():
		button.connect("pressed", self, "selectcategory", [button])
#	for button in $BuyFilter.get_children():
#		button.connect("pressed", self, "selectcategory", [button, "buy"])
	search_filter.connect("text_changed", self, "filter_changed")
	gui_controller.add_close_button(self)
	globals.connect("update_clock", self, "update_gold")
	input_handler.connect("update_itemlist", self, "update_sell_list")
	update_gold()


func open_shop(pressed: bool, pressed_button: Node, shop_data: Dictionary = {}):
	update_gold()
	$NumberSelection.hide()
	gui_controller.win_btn_connections_handler(pressed, self, pressed_button)
	current_pressed_area_btn = pressed_button
	if !(shop_data is Dictionary):
		print("warning: active_shop is not a Dictionary!")
		active_shop = {}
	else:
		active_shop = shop_data
	item_category = "all"
	$ItemFilter.get_child(0).pressed = true
	search_filter.text = ""
	update_sell_list()
	update_buy_list()
	if pressed:
		unfade(self)
	else:
		fade(self)


func selectcategory(button):
	var type = button.name
	for i in $ItemFilter.get_children():
		i.pressed = i == button
	item_category = type
	update_sell_list()
	update_buy_list()


func unfade(window: Control, time := 0.5):
	window.set("modulate", Color(1, 1, 1, 0))
	window.show()
	ResourceScripts.core_animations.UnfadeAnimation(window, time)
	yield(get_tree().create_timer(time), "timeout")
	window.set("modulate", Color(1, 1, 1, 1))


func fade(window: Control, time := 0.5):
	ResourceScripts.core_animations.FadeAnimation(window, time)
	yield(get_tree().create_timer(time), "timeout")
	window.hide()


func get_item_category(item):
	var type
	if Items.materiallist.has(item.code):
		if item.type == "food":
			type = "food"
		else:
			type = "material"
	else:
		if item.itemtype == "tool":
			type = "tool"
		elif item.itemtype == "weapon":
			type = "weapon"
		elif item.itemtype == "armor":
			if item.geartype == "costume":
				type = "costume"
			else:
				type = "armor"
		else:
			type = "usable"
	return type


func matches_filter(item, text: String) -> bool:
	if text == "":
		return true
	text = text.to_lower()
	var name := ""
	var description := ""
	var extra := ""
	match typeof(item):
		TYPE_DICTIONARY:
			name = str(item.name)
			description = str(item.get("descript", ""))
			extra = str(item.get("adjective", ""))
		TYPE_OBJECT:
			name = str(item.name)
			description = str(item.get("description"))
			extra = str(item.get("itembase"))
	return name.to_lower().find(text) >= 0 || description.to_lower().find(text) >= 0 || extra.to_lower().find(text) >= 0


func filter_changed(_text := ""):
	update_sell_list()
	update_buy_list()


func update_sell_list():
	input_handler.ClearContainer($SellBlock/ScrollContainer/VBoxContainer)
	tempitems.clear()
	var filter_text = search_filter.text
	for i in ResourceScripts.game_res.materials:
		if ResourceScripts.game_res.materials[i] <= 0 || Items.materiallist[i].type == "quest":
			continue
		var item = Items.materiallist[i]
		var type = get_item_category(item)
		var newbutton = input_handler.DuplicateContainerTemplate($SellBlock/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = item.name
		newbutton.get_node("icon").texture = item.icon
		newbutton.get_node("price").text = str(ceil(item.price * variables.material_sell_multiplier))
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(ResourceScripts.game_res.materials[i])
		newbutton.set_meta("type", type)
		newbutton.set_meta("item", item.name)
		newbutton.connect("pressed", self, "item_sell", [newbutton, item])
		globals.connectmaterialtooltip(newbutton, item, "", "material")
		newbutton.visible = (((newbutton.get_meta("type") == item_category) || item_category == "all")
			&& matches_filter(item, filter_text))
	for item in ResourceScripts.game_res.items.values():
		if item.amount <= 0 || item.tags.has('unsellable'):
			continue
		var type = get_item_category(item)
		if item.owner != null:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate(
			$SellBlock/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = item.name
		item.set_icon(newbutton.get_node("icon"))  #.texture = item.get_icon()
		if item.quality != "":
			newbutton.get_node("quality_color").show()
			newbutton.get_node("quality_color").texture = variables.quality_colors[item.quality]
		else:
			newbutton.get_node("quality_color").hide()
		newbutton.get_node("price").text = str(ceil(item.calculateprice() * variables.item_sell_multiplier))
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(item.amount)
		newbutton.set_meta('type', type)
		newbutton.set_meta('item', item.name)
		newbutton.set_meta('exploration', true) #while not reqired as it is now
		newbutton.connect("pressed", self, "item_sell", [newbutton, item])
		newbutton.visible = ((newbutton.get_meta("type") == item_category || item_category == "all")
			&& matches_filter(item, filter_text))
		globals.connectitemtooltip_v2(newbutton, item)



func update_buy_list():
	input_handler.ClearContainer($BuyBlock/ScrollContainer/VBoxContainer)
	tempitems.clear()
	var filter_text = search_filter.text
	if !(active_shop is Dictionary) or active_shop.empty():
		return
	var array = []
	for i in active_shop:
		if Items.materiallist.has(i):
			var item = Items.materiallist[i]
			if active_shop[i] == 0:
				continue
			array.append(i)
	array.sort_custom(self, "sort_mats")
	for i in array:
		var item = Items.materiallist[i]
		var amount = active_shop[i]
		var type = get_item_category(item)
		var newbutton = input_handler.DuplicateContainerTemplate($BuyBlock/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = item.name
		newbutton.get_node("icon").texture = item.icon
		if item.has("quality") and item.quality != "":
			newbutton.get_node("quality_color").show()
			newbutton.get_node("quality_color").texture = variables.quality_colors[item.quality]
		else:
			newbutton.get_node("quality_color").hide()
		newbutton.get_node("price").text = str(item.price)
		newbutton.set_meta("type", type)
		newbutton.set_meta("item", item.name)
		newbutton.set_meta("exploration", true)
		newbutton.connect("pressed", self, "item_purchase", [newbutton, item, amount])
		newbutton.visible = (((newbutton.get_meta("type") == item_category) || item_category == "all")
			&& matches_filter(item, filter_text))
		globals.connectmaterialtooltip(newbutton, item, "", "material")
		if amount > 0:
			newbutton.get_node("amount").text = str(amount)
			newbutton.get_node("amount").show()

	for i in active_shop:
		if !Items.itemlist.has(i):
			continue
		var item = Items.itemlist[i]
		if item.has("parts"):
			Items.get_loot().try_fix_old_shop_parts(active_shop, i)
			for record in active_shop[i]:
				var type = get_item_category(item)
				var newbutton = input_handler.DuplicateContainerTemplate($BuyBlock/ScrollContainer/VBoxContainer)
				newbutton.get_node("icon").texture = item.icon
				newbutton.set_meta("type", type)
				newbutton.set_meta("item", item.name)
				newbutton.set_meta("exploration", true)
				var newitem
				if record.has("quality"):
					var parts = record.duplicate()
					parts.erase("quality")
					newitem = globals.CreateGearItemQuality(i, parts, record.quality)
				else:
					newitem = globals.CreateGearItemShop(i, record)
					record.quality = newitem.quality
				newitem.set_icon(newbutton.get_node("icon"))
				if newitem.quality != "":
					newbutton.get_node("quality_color").show()
					newbutton.get_node("quality_color").texture = variables.quality_colors[newitem.quality]
				else:
					newbutton.get_node("quality_color").hide()
				newbutton.get_node("name").text = newitem.name
				tempitems.append(newitem)
				globals.connectitemtooltip_v2(newbutton, newitem)
				newbutton.get_node("price").text = str(newitem.calculateprice())
				newbutton.connect("pressed", self, "item_purchase", [newbutton, newitem, 1])
				newbutton.visible = (((newbutton.get_meta("type") == item_category) || item_category == "all")
					&& matches_filter(newitem, filter_text))
				newbutton.get_node("amount").text = "1"
				newbutton.get_node("amount").show()
		else:
			var amount = active_shop[i]
			if amount == 0:
				continue
			var type = get_item_category(item)
			var newbutton = input_handler.DuplicateContainerTemplate($BuyBlock/ScrollContainer/VBoxContainer)
			newbutton.get_node("name").text = item.name
			newbutton.get_node("icon").texture = item.icon
			if item.has("quality") and item.quality != "":
				newbutton.get_node("quality_color").show()
				newbutton.get_node("quality_color").texture = variables.quality_colors[item.quality]
			else:
				newbutton.get_node("quality_color").hide()
			newbutton.get_node("price").text = str(item.price)
			newbutton.set_meta("type", type)
			newbutton.set_meta("item", item.name)
			newbutton.set_meta("exploration", true)
			newbutton.visible = (((newbutton.get_meta("type") == item_category) || item_category == "all")
				&& matches_filter(item, filter_text))
			globals.connecttempitemtooltip(newbutton, item, "geartemplate")
			newbutton.connect("pressed", self, "item_purchase", [newbutton, item, amount])
			if amount > 0:
				newbutton.get_node("amount").text = str(amount)
				newbutton.get_node("amount").show()


func sort_mats(first, second):
	if Items.materiallist[first].type != Items.materiallist[second].type:
		return Items.materiallist[first].type < Items.materiallist[second].type
	else:
		return Items.materiallist[first].price > Items.materiallist[second].price


func item_purchase(button: Button, item, amount):
	for btn in $SellBlock/ScrollContainer/VBoxContainer.get_children():
		btn.pressed = false
	for btn in $BuyBlock/ScrollContainer/VBoxContainer.get_children():
		if !btn.has_meta("item"):
			continue
		btn.pressed = btn == button
	purchase_item = item
	if amount < 0:
		amount = 100
	var price = 0
	var icon = null
	if typeof(item) == TYPE_OBJECT:
		price = item.calculateprice()
	else:
		if item.type == "material":
			price = ceil(item.price * variables.material_sell_multiplier)
		else:
			price = item.price
	if typeof(item) == TYPE_OBJECT:
		icon = item.icon
	else:
		icon = item.icon
	if price == null:
		price = 0
	var maxvalue = amount
	$NumberSelection.open(self, "item_purchase_confirm",  tr("BUY") + " " + str(item.name), price, 1, maxvalue, true, icon, item)


func item_purchase_confirm(value):
	input_handler.PlaySound("money_spend")
	if typeof(purchase_item) == TYPE_OBJECT:
		globals.AddItemToInventory(purchase_item)
		ResourceScripts.game_res.money -= purchase_item.calculateprice()
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
		for i in active_shop:
			if !(active_shop[i] is Array):
				continue
			var to_erase
			for j in range(active_shop[i].size()):
				if globals.check_shop_record(purchase_item, i, active_shop[i][j]):
					to_erase = j
					break
			if to_erase == null:
				continue
			active_shop[i].remove(to_erase)
			if active_shop[i].empty():
				active_shop.erase(i)
			break
		update_sell_list()
		update_buy_list()
	else:
		active_shop[purchase_item.code] -= value
		if Items.materiallist.has(purchase_item.code):
			ResourceScripts.game_res.set_material(purchase_item.code, "+", value)
		elif Items.itemlist.has(purchase_item.code):
			for i in range(value):
				match purchase_item.type:
					"usable":
						globals.AddItemToInventory(globals.CreateUsableItem(purchase_item.code))
					"gear":
						globals.AddItemToInventory(globals.CreateGearItemShop(purchase_item.code, {}))
		ResourceScripts.game_res.money -= purchase_item.price * value
		update_sell_list()
		update_buy_list()


func item_sell(button: Button, item):
	for btn in $BuyBlock/ScrollContainer/VBoxContainer.get_children():
		btn.pressed = false
	for btn in $SellBlock/ScrollContainer/VBoxContainer.get_children():
		if !btn.has_meta("item"):
			continue
		btn.pressed = btn == button
	purchase_item = item
	var price
	if item.price:
		price = ceil(item.price * variables.material_sell_multiplier)
	else:
		price = ceil(item.calculateprice() * variables.item_sell_multiplier)
	var sellingamount
	if !Items.materiallist.has(item.code):
		price = ceil(item.calculateprice() * variables.item_sell_multiplier)
		sellingamount = item.amount
	else:
		sellingamount = ResourceScripts.game_res.materials[item.code]
	$NumberSelection.open(self, "item_sell_confirm", tr("SELL") + " " + str(item.name), price, 1, sellingamount, false, item.icon, item)


func item_sell_confirm(value):
	input_handler.PlaySound("money_spend")
	var price
	if purchase_item.price:
		price = ceil(purchase_item.price * variables.material_sell_multiplier)
	else:
		price = ceil(purchase_item.calculateprice() * variables.item_sell_multiplier)

	if Items.materiallist.has(purchase_item.code):
		ResourceScripts.game_res.set_material(purchase_item.code, "-", value)
	else:
		price = ceil(purchase_item.calculateprice() * variables.item_sell_multiplier)
		purchase_item.amount -= value
	ResourceScripts.game_res.money += price * value
	update_sell_list()
	update_buy_list()


func set_area_btn_pressed(value):
	if !is_instance_valid(current_pressed_area_btn):
		current_pressed_area_btn = value
		return
	if value != current_pressed_area_btn:
		current_pressed_area_btn.pressed = false
		current_pressed_area_btn = value


func update_gold():
	$Label2.text = str(int(ResourceScripts.game_res.money))
