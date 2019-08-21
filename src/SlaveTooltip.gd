extends Panel

var parentnode
var shutoff = false
var prevnode
onready var textnode = $RichTextLabel


func _process(delta):
	if parentnode != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
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
	
	var text = person.get_short_name() + person.translate(" [race] [male] [age]")
	
	$icon.texture = person.get_icon()
	$RichTextLabel.bbcode_text = text
	$exp.text = str(floor(person.base_exp))
	for i in ['physics','wits','charm','sexuals']:
		get_node(i).text = str(floor(person[i] + person[i+'_bonus'])) + '/' + str(person[i+'_factor']*20) 
	for i in ['obedience','fear']:
		get_node("VBoxContainer/"+ i + '/bar').value = person[i]
		if i == 'lust':
			get_node("VBoxContainer/"+ i + '/bar').max_value = person.lustmax
		get_node("VBoxContainer/"+ i + '/Label').text = str(floor(person[i])) + "/" + str(get_node("VBoxContainer/"+ i + '/bar').max_value)
	
	for i in ['hp','energy','mp','lust']:
		get_node("VBoxContainer/"+ i ).max_value = person.get_stat(i+'max')
		get_node("VBoxContainer/"+ i ).value = person.get_stat(i)
		get_node("VBoxContainer/"+ i + '/Label').text = str(floor(person.get_stat(i))) + "/" + str(floor(person.get_stat(i+'max')))
	text = ''
	if person.is_players_character == true:
		if person.work != '':
			text = "Occupation: " + races.tasklist[person.work].name
		else:
			text = "Occupation: None"
		text += '\nCurrent State: ' + person.last_tick_assignement
	$job.text = text 
	
	
	globals.ClearContainer($GridContainer)
	for i in person.professions:
		var newnode = globals.DuplicateContainerTemplate($GridContainer)
		newnode.texture = Skilldata.professions[i].icon
		newnode.get_node("Label").text = Skilldata.professions[i].name
	
	globals.ClearContainer($Sextraits)
	for i in person.sex_traits:
		var trait = Traitdata.sex_traits[i]
		var newbutton = globals.DuplicateContainerTemplate($Sextraits)
		newbutton.text = trait.name
	
	$VBoxContainer.visible = person.is_players_character
	if person.professions.has('master') || person.is_players_character == false:
		if person.is_players_character == false:
			$VBoxContainer/lust.hide()
		$VBoxContainer/fear.hide()
		$VBoxContainer/obedience.hide()
	else:
		$VBoxContainer/lust.show()
		$VBoxContainer/fear.show()
		$VBoxContainer/obedience.show()
	
	
	if $VBoxContainer/obedience.visible:
		if person.obedience > 50:
			$VBoxContainer/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.green)
		elif person.obedience > person.brave_factor*7:
			$VBoxContainer/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.yellow)
		else:
			if person.check_escape_chance() == true:
				$VBoxContainer/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.red)
			else:
				$VBoxContainer/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.gray)
		if person.fear > 50:
			$VBoxContainer/fear/Label.set("custom_colors/font_color",globals.hexcolordict.green)
		elif person.fear > person.brave_factor*7:
			$VBoxContainer/fear/Label.set("custom_colors/font_color",globals.hexcolordict.yellow)
		else:
			if person.check_escape_chance() == true:
				$VBoxContainer/fear/Label.set("custom_colors/font_color",globals.hexcolordict.red)
			else:
				$VBoxContainer/fear/Label.set("custom_colors/font_color",globals.hexcolordict.gray)
	
	globals.ClearContainer($buffs)
	
	for i in person.get_all_buffs():
		var newnode = globals.DuplicateContainerTemplate($buffs)
		newnode.texture = i.icon
		if i.get_duration() >= 0:
			newnode.get_node("Label").text = str(i.get_duration())
		else:
			newnode.get_node("Label").hide()
	
	
	prevnode = parentnode
	
	input_handler.GetTweenNode(self).stop_all()
	self.modulate.a = 1
	
	show()
	
	var pos = node.get_global_rect()
	pos = Vector2(pos.position.x, pos.end.y + 10)
	self.set_global_position(pos)
	
	
	if get_rect().end.x > screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if node.get_rect().end.y > screen.size.y:
		rect_global_position.y -= get_rect().end.y - screen.size.y
	
	set_process(true)

func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false

func hide():
	parentnode = null
	set_process(false)
	input_handler.FadeAnimation(self, 0.2)