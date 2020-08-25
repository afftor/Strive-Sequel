# ExplorationMainModule (Replace)

func return_character_confirm():
	selectedperson.remove_from_task()
	selectedperson.return_to_mansion()
    build_location_group()
    

# MansionSlaveListModule  
# Replace Part in rebuild()

match get_parent().mansion_state:
    "travels":
        newbutton.get_node("job").set_disabled(true)
        build_for_travel(person, newbutton)
    "skill":
        newbutton.get_node("job").set_disabled(true)
        build_for_skills(person, newbutton)		
    "upgrades":
        build_for_upgrades(person, newbutton)
    "default":
        continue
    "occupation":
        build_for_ocupation(person, newbutton)
    "craft":
        build_for_craft(person, newbutton)
    "sex":
        build_sex_selection(person, newbutton)

# Add new

func build_for_ocupation(person, newbutton):
	if person.travel.location == "travel":
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true