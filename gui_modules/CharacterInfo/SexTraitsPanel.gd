extends Control

onready var parent = get_parent()
var person


func _ready():
	gui_controller.add_close_button_simple(self)


func hide():
	.hide()
	parent.get_node("panel4").pressed = false

func build_sex_traits():
	person = parent.person
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	#$SexTraitsPanel/TraitsNotLearned.bbcode_text = person.translate(tr("NOTALLTRAITSLEARNED"))
	var array = []
	array = person.get_all_sex_traits()#.keys()
	
	var all_traits_known = true
	for i in array:
		if !array[i]:
			all_traits_known = false
			break
	if all_traits_known:
		array = person.get_unlocked_sex_traits()#.keys()
#		array.sort_custom(self, 'sort_traits')
		
		for i in array:
			var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.pressed = person.check_trait(i)
			newbutton.text = Traitdata.sex_traits[i].name
			globals.connecttexttooltip(newbutton, person.translate(Traitdata.sex_traits[i].descript))
			newbutton.connect("toggled", self, 'toggle_trait', [i])
	#$SexTraitsPanel/TraitsNotLearned.visible = !all_traits_known
	
	update_trait_capacity()
	rebuild_traits()


func rebuild_traits():
	var traits = person.get_all_sex_traits()
	var h1 = person.get_unlocked_sex_traits()
	var all_traits_known = true
	for i in traits:
		if !traits[i]:
			all_traits_known = false
			break
	if all_traits_known:
		for i in h1:
			if traits.keys().has(i):
				if traits[i]:
					traits.erase(i)
	for i in traits:
		var trait = Traitdata.sex_traits[i]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newnode.set_meta("always_disabled", true)
		$ScrollContainer/VBoxContainer.move_child(newnode, 0)
		if traits[i] == true:#trait is known
			newnode.text = trait.name
			var traittext = person.translate(trait.descript)
			for j in trait.reqs:
				if j.has('code') && j.code == 'action_type':
					traittext += "\n\n" + tr("DISLIKED_ACTIONS_LABEL") + ":[color=aqua] "
					for k in j.value:
						globals.sex_actions_dict[k].givers = []
						globals.sex_actions_dict[k].takers = []
						traittext += globals.sex_actions_dict[k].getname() + ", "
					traittext = traittext.substr(0, traittext.length() - 2) + ".[/color]"
			globals.connecttexttooltip(newnode, traittext)
			if !all_traits_known and !("Dislike" in trait.name):
				newnode.disabled = false
			else:
				newnode.disabled = true
			var font = input_handler.font_size_calculator(newnode)
			newnode.set("custom_fonts/font", font)
		else:
			newnode.text = tr("TRAITUNKNOWN")
			globals.connecttexttooltip(newnode, person.translate(tr("TRAITUNKNOWNTOOLTIP")))
			newnode.disabled = true
			var font = input_handler.font_size_calculator(newnode)
			newnode.set("custom_fonts/font", font)


func update_trait_capacity():
	person = input_handler.interacted_character
	var text = tr("SIBLINGMODULECURRENTCAPACITY")+': ' + str(person.get_sex_traits().size()) + "/" + str(person.get_stat('sexuals_factor') + 1)
	$TraitCapacity.text = text
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.has_meta("always_disabled") && i.get_meta("always_disabled") == true:
			continue
		i.disabled = person.get_stat('sexuals_factor') + 1 - person.get_sex_traits().size() <= 0 && i.pressed == false


func toggle_trait(trait_status, trait):
	match trait_status:
		true:
			if !person.check_trait(trait):
				person.add_sex_trait(trait, true)
		false:
			if person.check_trait(trait):
				person.remove_sex_trait(trait, false)
	update_trait_capacity()
	#get_parent().SlaveInfo.rebuild_traits()
