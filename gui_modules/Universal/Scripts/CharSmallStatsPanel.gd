extends Panel

onready var class_cont = $abilities/ScrollContainer/VBoxContainer/class_scroll/class_container
onready var class_list_node = $abilities/ScrollContainer/VBoxContainer/class_scroll
onready var abilities_node = $abilities
onready var abilities_cont = $abilities/ScrollContainer/VBoxContainer

const abilities_node_short_y = 220
enum {TAB_GEN, TAB_ABIL}
var cur_tab = TAB_GEN

func _ready():
	$CloseButton.connect("pressed", self, "hide")
	for i in variables.resists_list:
		if i == 'all': continue
		var newlabel = $resists/Label.duplicate()
		var newvalue = $resists/Value.duplicate()
		$resists.add_child(newlabel)
		$resists.add_child(newvalue)
		newlabel.text = i.capitalize() + ":"
		newvalue.name = i
		newlabel.show()
		newvalue.show()
	for i in $"base stats".get_children():
		if statdata.statdata.has(i.name.replace("label_","")):
			globals.connecttexttooltip(i, statdata.statdata[i.name.replace("label_", "")].descript)
	$abilities_tab.connect("pressed", self, "abilities_node_on")
	$general_tab.connect("pressed", self, "abilities_node_off")

func open(character = ResourceScripts.scriptdict.class_slave.new("temp_char_stats")):
	$name.text = character.get_short_name()
	$Portrait.texture = character.get_icon()
	if character.is_players_character:
		$Background.texture = load("res://assets/Textures_v2/BATTLE/Panels/panel_battle_charinfo_l.png")
	else:
		$Background.texture = load("res://assets/Textures_v2/BATTLE/Panels/panel_battle_charinfo_r.png")
	for i in ['hp','mp']:
		$VBoxContainer.get_node(i).text = str(floor(character.get_stat(i))) + "/" + str(floor(character.get_stat(i+"max")))
	
	for i in variables.fighter_stats_list:
		if !i in ['hpmax', 'mpmax','critmod', 'speed']:
			$"base stats".get_node(i).text = str(floor(character.get_stat(i)))
		elif i == 'critmod':
			$"base stats".get_node(i).text = str(floor(character.get_stat(i)*100)) + '%'
		elif i == 'speed':
			$"base stats".get_node(i).text = str(floor(character.get_stat(i)[0]))
	
	for i in $resists.get_children():
		if !statdata.statdata.has('resist_' + i.name):
			continue
		var tmp = character.get_stat('resist_' + i.name)
		i.text = str(tmp)
		if tmp > 0:
			i.set("custom_colors/font_color", variables.hexcolordict.yellow)
		elif tmp < 0:
			i.set("custom_colors/font_color", variables.hexcolordict.green)
		else:
			i.set("custom_colors/font_color", variables.hexcolordict.white)
	
	globals.build_buffs_for_char(character, $buffscontainer, 'all')
	
	#second tab
	if cur_tab == TAB_ABIL:
		abilities_node_on()
	else:#cur_tab == TAB_GEN
		abilities_node_off()
	abilities_node.get_node("name").text = character.get_short_name()
	input_handler.ClearContainer(class_cont, ['icon'])
	var class_list = character.get_professions()
	class_list_node.visible = !class_list.empty()
	for i in class_list:
		var newnode = input_handler.DuplicateContainerTemplate(class_cont, 'icon')
		var prof = classesdata.professions[i]
		newnode.texture = prof.icon
		globals.connectclasstooltip(newnode, character, i)
	
	input_handler.ClearContainer(abilities_cont, ['class_scroll', 'entry'])
	var abilities_empty = true
	if character.combatgroup == 'enemy':
		var abilities = globals.get_traitlist_for_char(character)
		#skills
		for i in character.get_combat_skills():
			if i in ["attack", "ranged_attack"]: continue
			var skill = Skilldata.get_template_combat(i, character)
			var entry = {
				is_skill = true,
				name = tr(skill.name),
				text = skill.descript
			}
			if (skill.has("tags")
					and skill.tags.has("need_to_see")
					and !ResourceScripts.game_progress.have_seen_skill(i)):
				entry.icon = load("res://assets/Textures_v2/icon_question_small.png")
				entry.text = tr("NEEDTOSEESKILL")
				entry.name = tr("TRAITUNKNOWN")
			else:
				entry.icon = skill.icon
				entry.skill_tooltip = true
				entry.code = skill.code
				entry.character = weakref(character)
			abilities.append(entry)
		for entry in abilities:
			var newnode = input_handler.DuplicateContainerTemplate(abilities_cont, 'entry')
			newnode.set_entry(entry)
		abilities_empty = abilities.empty()
	
#	$abilities_tab.visible = !class_list.empty() or !abilities_empty
	if abilities_empty:
		abilities_node.rect_size.y = abilities_node_short_y
	else:
		abilities_node.rect_size.y = rect_size.y

func abilities_node_on():
	abilities_node.show()
	$general_tab.pressed = false
	$abilities_tab.pressed = true
	cur_tab = TAB_ABIL
func abilities_node_off():
	abilities_node.hide()
	$general_tab.pressed = true
	$abilities_tab.pressed = false
	cur_tab = TAB_GEN


