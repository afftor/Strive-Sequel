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

func SavePanelOpen():
	show()
	saveloadmode = 'save'
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	$LineEdit.editable = true
	for i in globals.dir_contents(globals.userfolder + 'saves'):
		if i.ends_with('.sav') == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		var savename = SaveNameTransform(i)
		newbutton.get_node("Delete").connect("pressed", self, 'DeleteSaveGame', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'PressSaveGame', [savename])

func LoadPanelOpen():
	show()
	saveloadmode = 'load'
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	$LineEdit.editable = false
	$LineEdit.text = ''
	for i in globals.dir_contents(globals.userfolder + 'saves'):
		if i.ends_with('.sav') == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		var savename = SaveNameTransform(i)
		newbutton.get_node("Delete").connect("pressed", self, 'DeleteSaveGame', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'PressLoadGame', [savename])

func PressLoadGame(savename):
	$LineEdit.text = savename
	input_handler.ShowConfirmPanel(self, 'LoadGame',tr("LOADCONFIRM"))

func PressSaveGame(savename):
	if savename == null:
		savename = $LineEdit.text
	else:
		$LineEdit.text = savename
	
	if savename == '':
		return
	
	var file = File.new()
	if file.file_exists(globals.userfolder + 'saves/' + savename + '.sav'):
		input_handler.ShowConfirmPanel(self, 'SaveGame',tr("OVERWRITECONFIRM"))
	else:
		SaveGame()

func DeleteSaveGame(savename):
	$LineEdit.text = savename
	input_handler.ShowConfirmPanel(self, 'DeleteSave',tr("DELETECONFIRM"))

func DeleteSave():
	var savename = $LineEdit.text
	var dir = Directory.new()
	dir.remove(globals.userfolder + 'saves/' + savename + '.sav')
	ResetSavePanel()

func SaveGame():
	globals.SaveGame($LineEdit.text)
	ResetSavePanel()

func LoadGame():
	globals.LoadGame($LineEdit.text)

func SaveNameTransform(path):
	return path.replace(globals.userfolder + 'saves/',"").replace('.sav', '')