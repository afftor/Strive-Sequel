extends Panel

var parentnode
var shutoff = false
var prevnode


func _process(delta):
	if parentnode != null && weakref(parentnode).get_ref() != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide()

func _init():
	set_process(false)
	#connect("popup_hide", self, 'cooldown')

func showup(node, person):
	parentnode = node
	
	var screen = get_viewport().get_visible_rect()
	if shutoff == true && prevnode == parentnode:
		return
	
	var text = person.get_short_name() + person.translate(" [race] [age]")
	
	$sex.texture = globals.sexicons[person.sex]
	
	$icon.texture = person.get_icon()
	$RichTextLabel.bbcode_text = text
	$exp.text = str(floor(person.base_exp))
	
	var exp_color = Color(1,1,1)
	if person.get_next_class_exp() <= person.base_exp:
		exp_color = Color(0.2,1,0.2)
	$exp.set("custom_colors/font_color", exp_color)
	
	for i in ['physics','wits','charm','sexuals']:
		if i != 'sexuals':
			get_node(i).text = str(floor(person[i] + person[i+'_bonus'])) 
			get_node(i+'2').text = str(person[i+'_factor']*20)
		else:
			get_node(i).text = str(floor(person[i] + person[i+'_bonus']))
			get_node(i+'2').text = '100'
#	for i in ['loyalty','submission']:
#		get_node("VBoxContainer/"+ i + '/bar').value = person[i]
#		if i == 'lust':
#			get_node("VBoxContainer/"+ i + '/bar').max_value = person.lustmax
#		get_node("VBoxContainer/"+ i + '/Label').text = str(floor(person[i])) + "/" + str(get_node("VBoxContainer/"+ i + '/bar').max_value)
	
	for i in ['hp','mp','lust']:
		get_node("VBoxContainer/"+ i ).max_value = person.get_stat(i+'max')
		get_node("VBoxContainer/"+ i ).value = person.get_stat(i)
		get_node("VBoxContainer/"+ i + '/Label').text = str(floor(person.get_stat(i))) + "/" + str(floor(person.get_stat(i+'max')))
	text = "Type: [color=yellow]" + person.translate(globals.slave_class_names[person.slave_class]) + "[/color]\n"
	if person.is_players_character == true:
		if person.work != '':
			text += "Occupation: " + races.tasklist[person.work].name
		else:
			text += "Occupation: None"
		text += "\n"
		if state.get_master() != person:
			if person.obedience > 0 || person.loyalty >= 100 || person.submission >= 100:
				text += "{color=green|Obedience: " 
			else:
				text += "{color=red|Obedience: " 
			if person.loyalty < 100 && person.submission < 100:
				text += str(ceil(person.obedience)) + "}"
			else:
				text += "∞}"
	$job.bbcode_text = globals.TextEncoder(text) 
	
	
	globals.ClearContainer($GridContainer)
	if person.professions.size() > 5:
		$GridContainer/Button.rect_min_size = Vector2(50,50)
		$GridContainer/Button/Label.hide()
	else:
		$GridContainer/Button.rect_min_size = Vector2(100,100)
		$GridContainer/Button/Label.show()
	for i in person.professions:
		var newnode = globals.DuplicateContainerTemplate($GridContainer)
		newnode.texture = Skilldata.professions[i].icon
		newnode.get_node("Label").text = Skilldata.professions[i].name
	
	
	$VBoxContainer.visible = person.is_players_character
	$rightclick.visible = !person.is_players_character
	if person.professions.has('master') || person.is_players_character == false:
		if person.is_players_character == false:
			$VBoxContainer/lust.hide()
	else:
		$VBoxContainer/lust.show()
	
	
	
	globals.ClearContainer($buffs)
	
	for i in person.get_mansion_buffs():
		var newnode = globals.DuplicateContainerTemplate($buffs)
		newnode.texture = i.icon
		if i.get_duration() != null and i.get_duration() >= 0:
			newnode.get_node("Label").text = str(i.get_duration())
		else:
			newnode.get_node("Label").hide()
	
	
	prevnode = parentnode
	
	input_handler.GetTweenNode(self).stop_all()
	self.modulate.a = 1
	
	show()
	
	var pos = node.get_global_rect()
	pos = Vector2(pos.end.x + 10, pos.position.y)
	self.set_global_position(pos)
	
	
	if get_rect().end.x+100 > screen.size.x:
		rect_global_position.x -= get_rect().end.x+100 - screen.size.x
	if get_rect().end.y+125 > screen.size.y:
		rect_global_position.y -= get_rect().end.y+125 - screen.size.y
	
	set_process(true)

func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false

func hide():
	parentnode = null
	set_process(false)
	input_handler.FadeAnimation(self, 0.2)
