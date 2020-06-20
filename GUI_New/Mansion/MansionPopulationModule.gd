extends Panel

var population

func _ready():
	population = $population

func _on_population_changed():
	pass
	# get_node("population").text = "Population: "+ str(state.characters.size()) +"/" + str(state.get_pop_cap())
