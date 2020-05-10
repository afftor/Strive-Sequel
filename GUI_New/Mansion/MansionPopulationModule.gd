extends Panel

var population

func _ready():
	population = $population
	print(population.text)

func _on_population_changed():
	print("Population changed!")
	# get_node("population").text = "Population: "+ str(state.characters.size()) +"/" + str(state.get_pop_cap())
