extends "res://files/Close Panel Button/ClosingPanel.gd"


var saveloadmode

func _ready():
#warning-ignore:return_value_discarded
	$LineEdit.connect("text_entered",self,'PressSaveGame')

func ResetSavePanel():
	match saveloadmode:
		'save':
			SavePanelOpen()
		'load':
			LoadPanelOpen()

var savedata = {}

func SavePanelOpen():
	show()
	saveloadmode = 'save'
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	$LineEdit.editable = true
	for i in globals.dir_contents(globals.userfolder + 'saves'):
		var savename = SaveNameTransform(i)
		if i.ends_with(".dat") == true:
			var config = ConfigFile.new()
			config.load(i)
			var details = config.get_section_keys('details')
			savedata[savename] = {}
			for i in details:
				savedata[savename][i] = config.get_value("details", i, null)
		if i.ends_with('.sav') == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Delete").connect("pressed", self, 'DeleteSaveGame', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'PressSaveGame', [savename])
		newbutton.connect("mouse_entered", self, "show_save_details", [savename])
		if savedata.has(savename):
			newbutton.get_node("Date").show()
			newbutton.get_node("Date").text = get_date_time(savedata[savename])

func LoadPanelOpen():
	show()
	saveloadmode = 'load'
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	$LineEdit.editable = false
	$LineEdit.text = ''
	for i in globals.dir_contents(globals.userfolder + 'saves'):
		var savename = SaveNameTransform(i)
		if i.ends_with(".dat") == true:
			var config = ConfigFile.new()
			config.load(i)
			var details = config.get_section_keys('details')
			savedata[savename] = {}
			for i in details:
				savedata[savename][i] = config.get_value("details", i, null)
		if i.ends_with('.sav') == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Delete").connect("pressed", self, 'DeleteSaveGame', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'PressLoadGame', [savename])
		newbutton.connect("mouse_entered", self, "show_save_details", [savename])
		if savedata.has(savename):
			newbutton.get_node("Date").show()
			newbutton.get_node("Date").text = get_date_time(savedata[savename])

func PressLoadGame(savename):
	$LineEdit.text = savename
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'LoadGame', tr("LOADCONFIRM")])
	#input_handler.ShowConfirmPanel(self, 'LoadGame',tr("LOADCONFIRM"))

func PressSaveGame(savename):
	if savename == null:
		savename = $LineEdit.text
	else:
		$LineEdit.text = savename
	
	if savename == '':
		return
	
	var file = File.new()
	if file.file_exists(globals.userfolder + 'saves/' + savename + '.sav'):
		input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'SaveGame', tr("OVERWRITECONFIRM")])
		#input_handler.ShowConfirmPanel(self, 'SaveGame',tr("OVERWRITECONFIRM"))
	else:
		SaveGame()

func DeleteSaveGame(savename):
	$LineEdit.text = savename
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'DeleteSave', tr("DELETECONFIRM")])
	#input_handler.ShowConfirmPanel(self, 'DeleteSave',tr("DELETECONFIRM"))

func DeleteSave():
	var savename = $LineEdit.text
	var dir = Directory.new()
	dir.remove(globals.userfolder + 'saves/' + savename + '.sav')
	ResetSavePanel()

func SaveGame():
	globals.SaveGame($LineEdit.text)
	ResetSavePanel()
	hide()
	get_parent().hide()
	input_handler.SystemMessage("Game Saved")

func LoadGame():
	globals.LoadGame($LineEdit.text)

func SaveNameTransform(path):
	return path.replace(globals.userfolder + 'saves/',"").replace('.sav', '').replace('.dat','')

func show_save_details(save):
	if savedata.has(save):
		save = savedata[save]
	else:
		$DetailsPanel.hide()
		return
	var text = '[center]Mode: ' + starting_presets.preset_data[save.preset].name + "\nMaster: " + save.master_name + "\nDay: " + str(save.day) + " Hour: " + str(save.hour)+ "\nGold: " + str(save.gold) + "\nPopulation: " + str(save.population)
	text += "\n\n\nVersion: " + save.version
	if save.version != globals.gameversion:
		text += "{color=red| (Outdated)}"
	text += "[/center]\n\n" 
	text += get_date_time(save)
#	text += add_zeros(save.time.hour) + ":" + add_zeros(save.time.minute) 
#	text += " - " + str(save.time.month) + "/" + str(save.time.day) + "/" + str(save.time.year).substr(2, 4)
	$DetailsPanel/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	$DetailsPanel.show()
	$DetailsPanel/MasterIcon.texture = globals.loadimage(save.master_icon)

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
