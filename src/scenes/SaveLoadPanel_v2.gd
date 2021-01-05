extends Panel


var saveloadmode

func _ready():
#warning-ignore:return_value_discarded
	$LineEdit.connect("text_entered",self,'PressSaveGame')
	$DetailsPanel/MasterIcon.hide()
	$Update.connect("pressed", self, "update_save_file")

func ResetSavePanel():
	match saveloadmode:
		'save':
			SavePanelOpen()
		'load':
			LoadPanelOpen()

var savedata = {}

func update_save_file():
	$UpdatePanel.show()
	input_handler.ClearContainer($UpdatePanel/VBoxContainer)
	for i in input_handler.dir_contents(variables.userfolder + 'saves'):
		var savename = SaveNameTransform(i)
		if i.ends_with(".dat") == true:
			var config = ConfigFile.new()
			config.load(i)
			var details = config.get_section_keys('details')
			savedata[savename] = {}
			for ii in details:
				savedata[savename][ii] = config.get_value("details", ii, null)
		if i.ends_with('.sav') == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($UpdatePanel/VBoxContainer)
		newbutton.get_node("Update").connect("pressed", self, 'update_file', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'update_file', [savename])
		newbutton.connect("mouse_entered", self, "show_save_details", [savename])
		if savedata.has(savename):
			newbutton.get_node("Date").show()
			newbutton.get_node("Date").text = get_date_time(savedata[savename])


func update_file(filename):	
	if filename == '':
		return
	file_to_update = filename
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'update_file_action', tr("UPDATEFILE")])


var file_to_update
func update_file_action():
	var file = File.new()
	file.open(variables.userfolder + 'saves/' + file_to_update + '.sav', file.READ)
	var text = file.get_as_text()
	var parse_result
	parse_result = JSON.parse(text)
	var loaded_file = parse_result.result
	file.close()
	var temp_chars = loaded_file.charpool
	for character in temp_chars.values():
		character.travel.location = "aliron"

	ResourceScripts.game_world.make_world()
	loaded_file.charpool = temp_chars
	loaded_file.game_world = ResourceScripts.get("game_world").serialize()
	var new_file_name = file_to_update + "_updated"
	file = File.new()
	file.open(variables.userfolder + 'saves/' + new_file_name + '.sav', file.WRITE)
	text = JSON.print(loaded_file)
	file.store_string(text)
	file.close()

	var dir = Directory.new()
	dir.copy(variables.userfolder + 'saves/' + file_to_update + '.dat', variables.userfolder + 'saves/' + new_file_name + '.dat')
	



func SavePanelOpen():
#	show()
	saveloadmode = 'save'
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	$LineEdit.editable = true
	for i in input_handler.dir_contents(variables.userfolder + 'saves'):
		var savename = SaveNameTransform(i)
		if i.ends_with(".dat") == true:
			var config = ConfigFile.new()
			config.load(i)
			var details = config.get_section_keys('details')
			savedata[savename] = {}
			for detail in details:
				savedata[savename][detail] = config.get_value("details", detail, null)
		if i.ends_with('.sav') == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Delete").connect("pressed", self, 'DeleteSaveGame', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'PressSaveGame', [savename])
		newbutton.connect("mouse_entered", self, "show_save_details", [savename])
		if savedata.has(savename):
			newbutton.get_node("Date").show()
			newbutton.get_node("Date").text = get_date_time(savedata[savename])



func LoadPanelOpen():
#	show()
	saveloadmode = 'load'
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	$LineEdit.editable = false
	$LineEdit.text = ''
	for i in input_handler.dir_contents(variables.userfolder + 'saves'):
		var savename = SaveNameTransform(i)
		if i.ends_with(".dat") == true:
			var config = ConfigFile.new()
			config.load(i)
			var details = config.get_section_keys('details')
			savedata[savename] = {}
			for detail in details:
				savedata[savename][detail] = config.get_value("details", detail, null)
		if i.ends_with('.sav') == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Delete").connect("pressed", self, 'DeleteSaveGame', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'PressLoadGame', [savename])
		newbutton.connect("mouse_entered", self, "show_save_details", [savename])
		if savedata.has(savename):
			newbutton.get_node("Date").show()
			newbutton.get_node("Date").text = get_date_time(savedata[savename])



func PressLoadGame(savename):
	# var file = File.new()
	# if !file.file_exists(variables.userfolder+'saves/'+ savename + '.sav') :
	# 	print("no file %s" % (variables.userfolder+'saves/'+ savename + '.sav'))
	# 	return
	# file.open(variables.userfolder+'saves/'+ savename + '.sav', File.READ)
	# var savedict = parse_json(file.get_as_text())
	# file.close()

	# for faction in savedict.game_world.areas.plains.factions.values():
	# 	if !faction.has("bonus_actions"):
	# 		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'LoadGame', tr("NOTCOMPATIBLE")])
	# 		return

	gui_controller.close_all_closeable_windows()
	gui_controller.windows_opened.clear()
	$LineEdit.text = savename
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'LoadGame', tr("LOADCONFIRM")])
	#input_handler.ShowConfirmPanel(self, 'LoadGame',tr("LOADCONFIRM"))

func PressSaveGame(savename):
	if savename == null:
		savename = $LineEdit.text
	else:
		$LineEdit.text = savename
	
	if savename == '':
		return
	
	var file = File.new()
	if file.file_exists(variables.userfolder + 'saves/' + savename + '.sav'):
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'SaveGame', tr("OVERWRITECONFIRM")])
		#input_handler.ShowConfirmPanel(self, 'SaveGame',tr("OVERWRITECONFIRM"))
	else:
		SaveGame()

func DeleteSaveGame(savename):
	$LineEdit.text = savename
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'DeleteSave', tr("DELETECONFIRM")])
	#input_handler.ShowConfirmPanel(self, 'DeleteSave',tr("DELETECONFIRM"))

func DeleteSave():
	var savename = $LineEdit.text
	var dir = Directory.new()
	dir.remove(variables.userfolder + 'saves/' + savename + '.sav')
	ResetSavePanel()

func SaveGame():
	gui_controller.close_all_closeable_windows()
	globals.SaveGame($LineEdit.text)
	ResetSavePanel()
	yield(get_tree(), "idle_frame")
	if gui_controller.game_menu != null:
		gui_controller.game_menu.hide()
	gui_controller.current_screen = gui_controller.mansion
	input_handler.SystemMessage("Game Saved")

func LoadGame():
	globals.LoadGame($LineEdit.text)
	yield(get_tree(), "idle_frame")
	if gui_controller.game_menu != null:
		gui_controller.game_menu.hide()
	gui_controller.close_all_closeable_windows()

func SaveNameTransform(path):
	return path.replace(variables.userfolder + 'saves/',"").replace('.sav', '').replace('.dat','')

func show_save_details(save):
	if savedata.has(save):
		save = savedata[save]
	else:
		$DetailsPanel.hide()
		return
	# var text = 'Mode: ' + starting_presets.preset_data[save.preset].name + "\nMaster: " + save.master_name + "\tVersion: " + save.version + "\tGold: " + str(save.gold) + "\nDay: " + str(save.day) + " Hour: " + str(save.hour) + "\t" + get_date_time(save) + "\tPopulation: " + str(save.population)
	var text = "Gold: " + str(save.gold) + "\nPopulation: " + str(save.population) + "\nMaster: " + save.master_name + "\nDay: " + str(save.day) + " Hour: " + str(save.hour)
	var text2 = "Mode: " + starting_presets.preset_data[save.preset].name + "\nVersion: " + save.version + "\n" + get_date_time(save)
	# text += "\n\n\nVersion: " + save.version
	if save.version != globals.gameversion:
		text += "{color=red| (Outdated)}"
	text += "\n" 
	# text += get_date_time(save)
#	text += add_zeros(save.time.hour) + ":" + add_zeros(save.time.minute) 
#	text += " - " + str(save.time.month) + "/" + str(save.time.day) + "/" + str(save.time.year).substr(2, 4)
	$DetailsPanel/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	$DetailsPanel/RichTextLabel2.bbcode_text = globals.TextEncoder(text2)
	$DetailsPanel.show()
	$DetailsPanel/MasterIcon.visible = input_handler.loadimage(save.master_icon) != null
	$DetailsPanel/MasterIcon.texture = input_handler.loadimage(save.master_icon)

func add_zeros(number):
	if number > 9:
		return str(number)
	else:
		return '0' + str(number)

func get_date_time(save):
	var text = ""
	
	text += add_zeros(save.time.hour) + ":" + add_zeros(save.time.minute) 
	text += " - " + str(save.time.month) + "/" + str(save.time.day) + "/" + str(save.time.year).substr(2, 4)
	return text
