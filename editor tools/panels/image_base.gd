extends PanelContainer

var newrec = false
var parent = null
var path = ""
var id
var stat
var index
var indexed = false
var dir = 'icons'

func _ready():
	#setup mode
	for n in $VBoxContainer.get_children():
		if n.is_in_group('edit'):
			if newrec: n.visible = false
			else: n.visible = true
		if n.is_in_group('load'):
			if newrec: n.visible = true
			else: n.visible = false
	#fill idsel
	fill_list()
	#connects
	
func update_res():
	fill_list()

func fill_list():
	$VBoxContainer/idsel.clear()
	for i in images[dir]:
#		$VBoxContainer/idsel.add_icon_item(images[dir][i], i)
		$VBoxContainer/idsel.add_item(i)

func setpath(p):
	path = p
	$VBoxContainer/pathsel.text = path
	var temp = input_handler.loadimage(path)
	$VBoxContainer/HBoxContainer/prew.texture = temp
	if parent != null and !newrec:
		if indexed:
			parent.tres[stat][index] = path
		else:
			parent.tres[stat] = path
		parent.update_res()
	if newrec: 
		id = null

func setid(pid = null):
	var pos = $VBoxContainer/idsel.get_selected_id()
	if pos == null: return
	id = $VBoxContainer/idsel.get_item_text(pos)
	var temp = images[dir][id]
	$VBoxContainer/HBoxContainer/prew.texture = temp
	if parent != null:
		if indexed:
			parent.tres[stat][index] = id
		else:
			parent.tres[stat] = id
		parent.update_res()

func commit():
	if path == "": return
	if $VBoxContainer/idedit.text == "": return
	images[dir][$VBoxContainer/idedit.text] = input_handler.loadimage(path) #temp, to add mode eiting here
	if parent != null: parent.update_res()
	get_parent().hide()

func revert():
	get_parent().hide()

func addrec():
	for n in $buf/addrecdiag.get_children(): n.free()
	var tmp = load(editor_core.image_base).instance()
	tmp.parent = self
	tmp.newrec = true
	tmp.dir = dir
	$buf/addrecdiag.add_child(tmp)
	$buf/addrecdiag.popup()
	print($buf/addrecdiag.rect_size)
	$buf/addrecdiag.set_size(Vector2(285, 405))
	print($buf/addrecdiag.rect_size)

func editpath():
	$buf/FileDialog.popup()


