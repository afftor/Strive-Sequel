extends "res://files/Close Panel Button/ClosingPanel.gd"

#warning-ignore-all:return_value_discarded

var person

func _ready():
	#setting tooltips
	for i in $progress.get_children():
		i.connect("mouse_entered", self, "show_progress_tooltip", [i])
	for i in $factors.get_children():
		i.hint_tooltip = tr("TOOLTIP" + i.name.replace("_", "").to_upper())
	for i in $mentality.get_children():
		i.hint_tooltip = tr("TOOLTIP" + i.name.to_upper())
	
	for i in ['restup', 'workup', 'joyup', 'restdown', 'workdown', 'joydown']:
		get_node("job_panel/"+i).connect("pressed", self, "change_hours", [i])
	
	###############
	
	$ClassButton.connect("pressed",self,'open_class_window')
	globals.AddPanelOpenCloseAnimation($job_panel)
	globals.AddPanelOpenCloseAnimation($class_learn)
	
	$JobButton.connect("pressed", self, "open_jobs_window")
	
	
	for i in $class_learn/categories.get_children():
		i.connect("pressed",self,'class_category', [i.name])
	
	$class_learn/CheckBox.connect("pressed", self, "checkbox_locked")


func change_hours(stat):
	var freepoints = 24 - (person.workhours + person.resthours + person.joyhours)
	if stat.find('up') >= 0:
		if freepoints <= 0:
			return
		else:
			var statcode = stat.substr(0,stat.length()-2) + "hours"
			person.set(statcode, person.get(statcode) + 1)
	else:
		var statcode = stat.substr(0,stat.length()-4) + "hours"
		if person.get(statcode) == 0:
			return
		person.set(statcode, person.get(statcode) - 1)
	
	
	update_hours()

func update_hours():
	$job_panel/worklabel.text = str(person.workhours)
	$job_panel/restlabel.text = str(person.resthours)
	$job_panel/joylabel.text = str(person.joyhours)
	$job_panel/totallabel.text = "Free hours left: " + str(24 - (person.workhours + person.resthours + person.joyhours))
	if currentjob != null:
		show_job_details(currentjob)
	

func open(tempperson):
	var text = ''
	show()
	person = tempperson
	$name.text = person.get_short_name()
	if person.icon == null:
		$Portrait.texture = null
	else:
		$Portrait.texture = load(person.icon)
	if person.body == null:
		$Body.texture = null
	else:
		$Body.texture = load(person.body)
	$RichTextLabel.bbcode_text = person.make_description()
	$currentwork.text = person.work
	#$exp.text = str(person.base_exp)
	
	for i in $progress.get_children():
		i.text = str(floor(person.get(i.name) + person.get(i.name+'_bonus'))) + '/' + str(person.get(i.name +"_factor")*20)
	
	for i in $factors.get_children():
		i.get_node("Label").text = str(floor(person.get(i.name)))
	for i in $job.get_children():
		i.value = person.get(i.name)
		i.get_node("Label").text = str(floor(person.get(i.name))) + "/" + '100'
	for i in $base_stats.get_children():
		i.value = person.get(i.name)
		i.max_value = person.get(i.name+'max')
		i.get_node("Label").text = str(floor(person.get(i.name))) + "/" + str(floor(person.get(i.name+'max')))
	
	$mentality/loyal.value = person.loyal
	$mentality/loyal/Label.text = str(floor(person.loyal)) + '/' + '100'
	$mentality/obedience.value = person.obedience
	$mentality/obedience/Label.text = str(floor(person.obedience)) + '/' + '100'
	$mentality/fear.value = person.fear
	$mentality/fear/Label.text = str(floor(person.fear)) + '/' + '100'
	$mentality/lust.value = person.lust
	$mentality/lust.max_value = person.lustmax
	$mentality/lust/Label.text = str(floor(person.lust)) + '/' + str(person.lustmax)
	
	$mentality/food_love/Label.text = person.food_love
	for i in person.food_hate:
		text += i + ", "
	text = text.substr(0, text.length()-2)
	$mentality/food_hate/Label.text =  text
	
	globals.ClearContainer($professions)
	for i in person.professions:
		var newnode = globals.DuplicateContainerTemplate($professions)
		var prof = Skilldata.professions[i]
		newnode.texture = prof.icon
	
	globals.ClearContainer($traits)
	for i in person.traits:
		var newnode = globals.DuplicateContainerTemplate($traits)
		var trait
		newnode.text = i


func open_jobs_window():
	$job_panel.show()
	globals.ClearContainer($job_panel/ScrollContainer/VBoxContainer)
	currentjob = null
	update_hours()
	for i in races.tasklist.values():
		var newbutton = globals.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		#newbutton.connect('pressed', self, 'select_job', [i.code])
		newbutton.connect('pressed', self, 'show_job_details', [i])

var currentjob

func show_job_details(job):
	currentjob = job
	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
		i.pressed = i.text == job.name
	$job_panel/RichTextLabel.bbcode_text = "[center]" + job.name + '[/center]\n' + job.descript
	globals.ClearContainer($job_panel/ResourceOptions)
	for i in job.production.values():
		var newbutton = globals.DuplicateContainerTemplate($job_panel/ResourceOptions)
		if Items.materiallist.has(i.item):
			var number = stepify(person.workhours*races.call(i.progress_function, person)/i.progress_per_item,0.1)
			newbutton.get_node("icon").texture = Items.materiallist[i.item].icon
			newbutton.get_node("number").text = str(number)
			globals.connectmaterialtooltip(newbutton, Items.materiallist[i.item], "\n[color=yellow]Expected gain per work day: "+str(number) + "[/color]")
		else:
			#add craft items + tooltips
			pass
		newbutton.connect('pressed', self, 'select_job', [job, i.code])

func select_job(job, production):
	person.assign_to_task(job.code, production)
	for i in person.current_day_spent.values():
		i = 0
	$job_panel.hide()
	open(person)
	

var category = 'all'

func open_class_window():
	$class_learn.show()
	globals.ClearContainer($class_learn/ScrollContainer/GridContainer)
	
	for i in Skilldata.professions.values():
		if (!i.categories.has(category) && category != 'all') || !person.checkreqs(i.showupreqs):
			continue
		if !$class_learn/CheckBox.pressed && person.checkreqs(i.reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($class_learn/ScrollContainer/GridContainer)
		#newbutton.get_node('icon').texture = i.icon
		newbutton.get_node('name').text = i.name
		newbutton.connect('pressed',self,"unlock_class", [i.code])

func checkbox_locked():
	open_class_window()

func class_category(name):
	category = name
	for i in $class_learn/categories.get_children():
		i.pressed = i.name == category
	open_class_window()

func show_progress_tooltip(node):
	pass

func unlock_class(i):
	$class_learn/ClassPanel.selectedcharacter = person
	$class_learn/ClassPanel.open(i)


