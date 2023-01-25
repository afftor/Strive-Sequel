extends Control
# warning-ignore-all:return_value_discarded

func _init():
	build_lines()

func _ready():
	$Button.connect("mouse_entered", self, "show_log")

func show_log():
	print(storedlines)

var storedlines = []

func add_new_chatter(character, line):
	var newnode = input_handler.DuplicateContainerTemplate($VBoxContainer)
	var data = {name = character.get_short_name(), text = character.translate(line), time = str(ResourceScripts.game_globals.date) + "-" + str(ResourceScripts.game_globals.hour) + ":00"}
	newnode.get_node("Icon").texture = character.get_icon_small()
	newnode.get_node("Text").text = data.text
	newnode.get_node("Name").text = data.name
	ResourceScripts.core_animations.UnfadeAnimation(newnode,0.3)
	input_handler.PlaySound("chat_click")
	storedlines.append(data)
	yield(get_tree().create_timer(10),"timeout")
	ResourceScripts.core_animations.FadeAnimation(newnode, 1)
	yield(get_tree().create_timer(1),"timeout")
	newnode.hide()


var personalities = {
	shy = {},
	bold = {},
	kind = {},
	serious = {},
}

var lines = {
}

var individual_lines = {
#	hire_line1 = {text = "...Pleased to meet you, [Master].", events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},#tags: oneshot (1 time use per game), outweight (will always be presented if is in pool)
	hire_line1 = {text = tr("HIRE_LINE1"), events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line2 = {text = tr("HIRE_LINE2"), events = ['hire'], personalities = ['shy', 'serious', 'kind'], reqs = [], weight = 1, tags = []},
	hire_line3 = {text = tr("HIRE_LINE3"), events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line4 = {text = tr("HIRE_LINE4"), events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line5 = {text = tr("HIRE_LINE5"), events = ['hire'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	hire_line6 = {text = tr("HIRE_LINE6"), events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line7 = {text = tr("HIRE_LINE7"), events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line8 = {text = tr("HIRE_LINE8"), events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line9 = {text = tr("HIRE_LINE9"), events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line10 = {text = tr("HIRE_LINE10"), events = ['hire'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	hire_line11 = {text = tr("HIRE_LINE11"), events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line12 = {text = tr("HIRE_LINE12"), events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line13 = {text = tr("HIRE_LINE13"), events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line14 = {text = tr("HIRE_LINE14"), events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line15 = {text = tr("HIRE_LINE15"), events = ['hire'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	hire_line16 = {text = tr("HIRE_LINE16"), events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line17 = {text = tr("HIRE_LINE17"), events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line18 = {text = tr("HIRE_LINE18"), events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line19 = {text = tr("HIRE_LINE19"), events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line20 = {text = tr("HIRE_LINE20"), events = ['hire'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	hire_line21 = {text = tr("HIRE_LINE21"), events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line22 = {text = tr("HIRE_LINE22"), events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line23 = {text = tr("HIRE_LINE23"), events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line24 = {text = tr("HIRE_LINE24"), events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	hire_line25 = {text = tr("HIRE_LINE25"), events = ['hire'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	slavery_line1 = {text = tr("SLAVERY_LINE1"), events = ['enslave'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	slavery_line2 = {text = tr("SLAVERY_LINE2"), events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line3 = {text = tr("SLAVERY_LINE3"), events = ['enslave'], personalities = ['shy','kind','serious'], reqs = [], weight = 1, tags = []},
	slavery_line4 = {text = tr("SLAVERY_LINE4"), events = ['enslave'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	slavery_line5 = {text = tr("SLAVERY_LINE5"), events = ['enslave'], personalities = ['serious','bold','kind','shy'], reqs = [], weight = 0.5, tags = []},
	slavery_line6 = {text = tr("SLAVERY_LINE6"), events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line7 = {text = tr("SLAVERY_LINE7"), events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line8 = {text = tr("SLAVERY_LINE8"), events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line9 = {text = tr("SLAVERY_LINE9"), events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line10 = {text = tr("SLAVERY_LINE10"), events = ['enslave'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	slavery_line11 = {text = tr("SLAVERY_LINE11"), events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line12 = {text = tr("SLAVERY_LINE12"), events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line13 = {text = tr("SLAVERY_LINE13"), events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line14 = {text = tr("SLAVERY_LINE14"), events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line15 = {text = tr("SLAVERY_LINE15"), events = ['enslave'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	slavery_line16 = {text = tr("SLAVERY_LINE16"), events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line17 = {text = tr("SLAVERY_LINE17"), events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line18 = {text = tr("SLAVERY_LINE18"), events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line19 = {text = tr("SLAVERY_LINE19"), events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line20 = {text = tr("SLAVERY_LINE20"), events = ['enslave'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	slavery_line21 = {text = tr("SLAVERY_LINE21"), events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line22 = {text = tr("SLAVERY_LINE22"), events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line23 = {text = tr("SLAVERY_LINE23"), events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line24 = {text = tr("SLAVERY_LINE24"), events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	slavery_line25 = {text = tr("SLAVERY_LINE25"), events = ['enslave'], personalities = ['bold'], reqs = [], weight = 1, tags = []},

	experience_line1 = {text = tr("EXPERIENCE_LINE1"), events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line2 = {text = tr("EXPERIENCE_LINE2"), events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line3 = {text = tr("EXPERIENCE_LINE3"), events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line5 = {text = tr("EXPERIENCE_LINE5"), events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line6 = {text = tr("EXPERIENCE_LINE6"), events = ['exp_for_level'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	experience_line61 = {text = tr("EXPERIENCE_LINE61"), events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line7 = {text = tr("EXPERIENCE_LINE7"), events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line8 = {text = tr("EXPERIENCE_LINE8"), events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line9 = {text = tr("EXPERIENCE_LINE9"), events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line10 = {text = tr("EXPERIENCE_LINE10"), events = ['exp_for_level'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	experience_line11 = {text = tr("EXPERIENCE_LINE11"), events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line12 = {text = tr("EXPERIENCE_LINE12"), events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line13 = {text = tr("EXPERIENCE_LINE13"), events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line14 = {text = tr("EXPERIENCE_LINE14"), events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line15 = {text = tr("EXPERIENCE_LINE15"), events = ['exp_for_level'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	experience_line16 = {text = tr("EXPERIENCE_LINE16"), events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line17 = {text = tr("EXPERIENCE_LINE17"), events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line18 = {text = tr("EXPERIENCE_LINE18"), events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line19 = {text = tr("EXPERIENCE_LINE19"), events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line20 = {text = tr("EXPERIENCE_LINE20"), events = ['exp_for_level'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	experience_line21 = {text = tr("EXPERIENCE_LINE21"), events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line22 = {text = tr("EXPERIENCE_LINE22"), events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line23 = {text = tr("EXPERIENCE_LINE23"), events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line24 = {text = tr("EXPERIENCE_LINE24"), events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	experience_line25 = {text = tr("EXPERIENCE_LINE25"), events = ['exp_for_level'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	item_created_line1 = {text = tr("ITEM_CREATED_LINE1"), events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line2 = {text = tr("ITEM_CREATED_LINE2"), events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line3 = {text = tr("ITEM_CREATED_LINE3"), events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line4 = {text = tr("ITEM_CREATED_LINE4"), events = ['item_created'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	item_created_line5 = {text = tr("ITEM_CREATED_LINE5"), events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line6 = {text = tr("ITEM_CREATED_LINE6"), events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line7 = {text = tr("ITEM_CREATED_LINE7"), events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line8 = {text = tr("ITEM_CREATED_LINE8"), events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line9 = {text = tr("ITEM_CREATED_LINE9"), events = ['item_created'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	item_created_line10 = {text = tr("ITEM_CREATED_LINE10"), events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line11 = {text = tr("ITEM_CREATED_LINE11"), events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line12 = {text = tr("ITEM_CREATED_LINE12"), events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line13 = {text = tr("ITEM_CREATED_LINE13"), events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line14 = {text = tr("ITEM_CREATED_LINE14"), events = ['item_created'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	item_created_line15 = {text = tr("ITEM_CREATED_LINE15"), events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line16 = {text = tr("ITEM_CREATED_LINE16"), events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line17 = {text = tr("ITEM_CREATED_LINE17"), events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line18 = {text = tr("ITEM_CREATED_LINE18"), events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line19 = {text = tr("ITEM_CREATED_LINE19"), events = ['item_created'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	item_created_line20 = {text = tr("ITEM_CREATED_LINE20"), events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line21 = {text = tr("ITEM_CREATED_LINE21"), events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line22 = {text = tr("ITEM_CREATED_LINE22"), events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line23 = {text = tr("ITEM_CREATED_LINE23"), events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	item_created_line24 = {text = tr("ITEM_CREATED_LINE24"), events = ['item_created'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	combat_win_line1 = {text = tr("COMBAT_WIN_LINE1"), events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line2 = {text = tr("COMBAT_WIN_LINE2"), events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line3 = {text = tr("COMBAT_WIN_LINE3"), events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line4 = {text = tr("COMBAT_WIN_LINE4"), events = ['combat_won'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	combat_win_line5 = {text = tr("COMBAT_WIN_LINE5"), events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line6 = {text = tr("COMBAT_WIN_LINE6"), events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line7 = {text = tr("COMBAT_WIN_LINE7"), events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line8 = {text = tr("COMBAT_WIN_LINE8"), events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line9 = {text = tr("COMBAT_WIN_LINE9"), events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line10 = {text = tr("COMBAT_WIN_LINE10"), events = ['combat_won'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	combat_win_line11 = {text = tr("COMBAT_WIN_LINE11"), events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line12 = {text = tr("COMBAT_WIN_LINE12"), events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line13 = {text = tr("COMBAT_WIN_LINE13"), events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line14 = {text = tr("COMBAT_WIN_LINE14"), events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line15 = {text = tr("COMBAT_WIN_LINE15"), events = ['combat_won'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	combat_win_line16 = {text = tr("COMBAT_WIN_LINE16"), events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line17 = {text = tr("COMBAT_WIN_LINE17"), events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line18 = {text = tr("COMBAT_WIN_LINE18"), events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line19 = {text = tr("COMBAT_WIN_LINE19"), events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line20 = {text = tr("COMBAT_WIN_LINE20"), events = ['combat_won'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	combat_win_line21 = {text = tr("COMBAT_WIN_LINE21"), events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line22 = {text = tr("COMBAT_WIN_LINE22"), events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line23 = {text = tr("COMBAT_WIN_LINE23"), events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line24 = {text = tr("COMBAT_WIN_LINE24"), events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	combat_win_line25 = {text = tr("COMBAT_WIN_LINE25"), events = ['combat_won'], personalities = ['kind'], reqs = [], weight = 1, tags = []},

	sex_start_line1 = {text = tr("SEX_START_LINE1"), events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line2 = {text = tr("SEX_START_LINE2"), events = ['sex_start'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_start_line3 = {text = tr("SEX_START_LINE3"), events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line4 = {text = tr("SEX_START_LINE4"), events = ['sex_start'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_start_line5 = {text = tr("SEX_START_LINE5"), events = ['sex_start'], personalities = ['bold','serious','kind'], reqs = [], weight = 1, tags = []},
	sex_start_line6 = {text = tr("SEX_START_LINE6"), events = ['sex_start','sex_finish'], personalities = ['bold','kind','serious','shy'], reqs = [], weight = 5, tags = [], arg_reqs = ['partner_is_master']},
	sex_start_line7 = {text = tr("SEX_START_LINE7"), events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line8 = {text = tr("SEX_START_LINE8"), events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line9 = {text = tr("SEX_START_LINE9"), events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line10 = {text = tr("SEX_START_LINE10"), events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line11 = {text = tr("SEX_START_LINE11"), events = ['sex_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_start_line12 = {text = tr("SEX_START_LINE12"), events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line13 = {text = tr("SEX_START_LINE13"), events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line14 = {text = tr("SEX_START_LINE14"), events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line15 = {text = tr("SEX_START_LINE15"), events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line16 = {text = tr("SEX_START_LINE16"), events = ['sex_start'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_start_line17 = {text = tr("SEX_START_LINE17"), events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line18 = {text = tr("SEX_START_LINE18"), events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line19 = {text = tr("SEX_START_LINE19"), events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line20 = {text = tr("SEX_START_LINE20"), events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line21 = {text = tr("SEX_START_LINE21"), events = ['sex_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_start_line22 = {text = tr("SEX_START_LINE22"), events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line23 = {text = tr("SEX_START_LINE23"), events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line24 = {text = tr("SEX_START_LINE24"), events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line25 = {text = tr("SEX_START_LINE25"), events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_start_line26 = {text = tr("SEX_START_LINE26"), events = ['sex_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	sex_finish_line1 = {text = tr("SEX_FINISH_LINE1"), events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line3 = {text = tr("SEX_FINISH_LINE3"), events = ['sex_finish'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line4 = {text = tr("SEX_FINISH_LINE4"), events = ['sex_finish'], personalities = ['serious','shy','kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line5 = {text = tr("SEX_FINISH_LINE5"), events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line6 = {text = tr("SEX_FINISH_LINE6"), events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line7 = {text = tr("SEX_FINISH_LINE7"), events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line8 = {text = tr("SEX_FINISH_LINE8"), events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line9 = {text = tr("SEX_FINISH_LINE9"), events = ['sex_finish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_finish_line10 = {text = tr("SEX_FINISH_LINE10"), events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line11 = {text = tr("SEX_FINISH_LINE11"), events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line12 = {text = tr("SEX_FINISH_LINE12"), events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line13 = {text = tr("SEX_FINISH_LINE13"), events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line14 = {text = tr("SEX_FINISH_LINE14"), events = ['sex_finish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_finish_line15 = {text = tr("SEX_FINISH_LINE15"), events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line16 = {text = tr("SEX_FINISH_LINE16"), events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line17 = {text = tr("SEX_FINISH_LINE17"), events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line18 = {text = tr("SEX_FINISH_LINE18"), events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line19 = {text = tr("SEX_FINISH_LINE19"), events = ['sex_finish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_finish_line20 = {text = tr("SEX_FINISH_LINE20"), events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line21 = {text = tr("SEX_FINISH_LINE21"), events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line22 = {text = tr("SEX_FINISH_LINE22"), events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line23 = {text = tr("SEX_FINISH_LINE23"), events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_finish_line24 = {text = tr("SEX_FINISH_LINE24"), events = ['sex_finish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	master_praise_line1 = {text = tr("MASTER_PRAISE_LINE1"), events = ['master_praise'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_praise_line2 = {text = tr("MASTER_PRAISE_LINE2"), events = ['master_praise'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	master_praise_line3 = {text = tr("MASTER_PRAISE_LINE3"), events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line4 = {text = tr("MASTER_PRAISE_LINE4"), events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line5 = {text = tr("MASTER_PRAISE_LINE5"), events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line6 = {text = tr("MASTER_PRAISE_LINE6"), events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line7 = {text = tr("MASTER_PRAISE_LINE7"), events = ['master_praise'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_praise_line8 = {text = tr("MASTER_PRAISE_LINE8"), events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line9 = {text = tr("MASTER_PRAISE_LINE9"), events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line10 = {text = tr("MASTER_PRAISE_LINE10"), events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line11 = {text = tr("MASTER_PRAISE_LINE11"), events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line12 = {text = tr("MASTER_PRAISE_LINE12"), events = ['master_praise'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_praise_line13 = {text = tr("MASTER_PRAISE_LINE13"), events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line14 = {text = tr("MASTER_PRAISE_LINE14"), events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line15 = {text = tr("MASTER_PRAISE_LINE15"), events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line16 = {text = tr("MASTER_PRAISE_LINE16"), events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line17 = {text = tr("MASTER_PRAISE_LINE17"), events = ['master_praise'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_praise_line18 = {text = tr("MASTER_PRAISE_LINE18"), events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line19 = {text = tr("MASTER_PRAISE_LINE19"), events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line20 = {text = tr("MASTER_PRAISE_LINE20"), events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line21 = {text = tr("MASTER_PRAISE_LINE21"), events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_praise_line22 = {text = tr("MASTER_PRAISE_LINE22"), events = ['master_praise'], personalities = ['kind'], reqs = [], weight = 1, tags = []},

	master_punish_line1 = {text = tr("MASTER_PUNISH_LINE1"), events = ['master_punish','date_punish_light','date_punish_heavy'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line2 = {text = tr("MASTER_PUNISH_LINE2"), events = ['master_punish','date_punish_light','date_punish_heavy'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_punish_line3 = {text = tr("MASTER_PUNISH_LINE3"), events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line4 = {text = tr("MASTER_PUNISH_LINE4"), events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line5 = {text = tr("MASTER_PUNISH_LINE5"), events = ['master_punish'], personalities = ['bold','kind','serious','shy'], reqs = [{code = 'one_of_races', value = ['HalfkinCat','BeastkinCat']}], weight = 0.01, tags = []},
	master_punish_line6 = {text = tr("MASTER_PUNISH_LINE6"), events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line7 = {text = tr("MASTER_PUNISH_LINE7"), events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line8 = {text = tr("MASTER_PUNISH_LINE8"), events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line9 = {text = tr("MASTER_PUNISH_LINE9"), events = ['master_punish'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line10 = {text = tr("MASTER_PUNISH_LINE10"), events = ['master_punish','date_punish_light'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_punish_line11 = {text = tr("MASTER_PUNISH_LINE11"), events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line12 = {text = tr("MASTER_PUNISH_LINE12"), events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line13 = {text = tr("MASTER_PUNISH_LINE13"), events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line14 = {text = tr("MASTER_PUNISH_LINE14"), events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line15 = {text = tr("MASTER_PUNISH_LINE15"), events = ['master_punish'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_punish_line16 = {text = tr("MASTER_PUNISH_LINE16"), events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line17 = {text = tr("MASTER_PUNISH_LINE17"), events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line18 = {text = tr("MASTER_PUNISH_LINE18"), events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line19 = {text = tr("MASTER_PUNISH_LINE19"), events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line20 = {text = tr("MASTER_PUNISH_LINE20"), events = ['master_punish'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_punish_line21 = {text = tr("MASTER_PUNISH_LINE21"), events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line22 = {text = tr("MASTER_PUNISH_LINE22"), events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line23 = {text = tr("MASTER_PUNISH_LINE23"), events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line24 = {text = tr("MASTER_PUNISH_LINE24"), events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_punish_line25 = {text = tr("MASTER_PUNISH_LINE25"), events = ['master_punish'], personalities = ['serious'], reqs = [], weight = 1, tags = []},

	master_abuse_line1 = {text = tr("MASTER_ABUSE_LINE1"), events = ['abuse','date_punish_light'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line2 = {text = tr("MASTER_ABUSE_LINE2"), events = ['abuse'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line3 = {text = tr("MASTER_ABUSE_LINE3"), events = ['abuse'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line4 = {text = tr("MASTER_ABUSE_LINE4"), events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['bold','serious','shy','kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line5 = {text = tr("MASTER_ABUSE_LINE5"), events = ['abuse','date_punish_heavy'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line6 = {text = tr("MASTER_ABUSE_LINE6"), events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line7 = {text = tr("MASTER_ABUSE_LINE7"), events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line8 = {text = tr("MASTER_ABUSE_LINE8"), events = ['abuse'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line9 = {text = tr("MASTER_ABUSE_LINE9"), events = ['abuse'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	master_abuse_line10 = {text = tr("MASTER_ABUSE_LINE10"), events = ['abuse','date_punish_light'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line11 = {text = tr("MASTER_ABUSE_LINE11"), events = ['abuse'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line12 = {text = tr("MASTER_ABUSE_LINE12"), events = ['abuse','date_punish_light','date_punish_heavy'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line13 = {text = tr("MASTER_ABUSE_LINE13"), events = ['abuse'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line14 = {text = tr("MASTER_ABUSE_LINE14"), events = ['abuse'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	master_abuse_line15 = {text = tr("MASTER_ABUSE_LINE15"), events = ['abuse','date_punish_light'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line16 = {text = tr("MASTER_ABUSE_LINE16"), events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line17 = {text = tr("MASTER_ABUSE_LINE17"), events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line18 = {text = tr("MASTER_ABUSE_LINE18"), events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line19 = {text = tr("MASTER_ABUSE_LINE19"), events = ['abuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	master_abuse_line20 = {text = tr("MASTER_ABUSE_LINE20"), events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line21 = {text = tr("MASTER_ABUSE_LINE21"), events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line22 = {text = tr("MASTER_ABUSE_LINE22"), events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line23 = {text = tr("MASTER_ABUSE_LINE23"), events = ['abuse'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	master_abuse_line24 = {text = tr("MASTER_ABUSE_LINE24"), events = ['abuse','date_punish_light'], personalities = ['serious'], reqs = [], weight = 1, tags = []},

	sex_reward_line1 = {text = tr("SEX_REWARD_LINE1"), events = ['sexreward'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line2 = {text = tr("SEX_REWARD_LINE2"), events = ['sexreward'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line3 = {text = tr("SEX_REWARD_LINE3"), events = ['sexreward'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line4 = {text = tr("SEX_REWARD_LINE4"), events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line5 = {text = tr("SEX_REWARD_LINE5"), events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line6 = {text = tr("SEX_REWARD_LINE6"), events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line7 = {text = tr("SEX_REWARD_LINE7"), events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line8 = {text = tr("SEX_REWARD_LINE8"), events = ['sexreward'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	sex_reward_line9 = {text = tr("SEX_REWARD_LINE9"), events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line10 = {text = tr("SEX_REWARD_LINE10"), events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line11 = {text = tr("SEX_REWARD_LINE11"), events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line12 = {text = tr("SEX_REWARD_LINE12"), events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line13 = {text = tr("SEX_REWARD_LINE13"), events = ['sexreward'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	sex_reward_line14 = {text = tr("SEX_REWARD_LINE14"), events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line15 = {text = tr("SEX_REWARD_LINE15"), events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line16 = {text = tr("SEX_REWARD_LINE16"), events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line17 = {text = tr("SEX_REWARD_LINE17"), events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line18 = {text = tr("SEX_REWARD_LINE18"), events = ['sexreward'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	sex_reward_line19 = {text = tr("SEX_REWARD_LINE19"), events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line20 = {text = tr("SEX_REWARD_LINE20"), events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line21 = {text = tr("SEX_REWARD_LINE21"), events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line22 = {text = tr("SEX_REWARD_LINE22"), events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	sex_reward_line23 = {text = tr("SEX_REWARD_LINE23"), events = ['sexreward'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	loyalty_line1 = {text = tr("LOYALTY_LINE1"), events = ['loyalty'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line2 = {text = tr("LOYALTY_LINE2"), events = ['loyalty'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line3 = {text = tr("LOYALTY_LINE3"), events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line4 = {text = tr("LOYALTY_LINE4"), events = ['loyalty'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_line5 = {text = tr("LOYALTY_LINE5"), events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line6 = {text = tr("LOYALTY_LINE6"), events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line7 = {text = tr("LOYALTY_LINE7"), events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line8 = {text = tr("LOYALTY_LINE8"), events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line9 = {text = tr("LOYALTY_LINE9"), events = ['loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_line10 = {text = tr("LOYALTY_LINE10"), events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line11 = {text = tr("LOYALTY_LINE11"), events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line12 = {text = tr("LOYALTY_LINE12"), events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line13 = {text = tr("LOYALTY_LINE13"), events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line14 = {text = tr("LOYALTY_LINE14"), events = ['loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_line15 = {text = tr("LOYALTY_LINE15"), events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line16 = {text = tr("LOYALTY_LINE16"), events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line17 = {text = tr("LOYALTY_LINE17"), events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line18 = {text = tr("LOYALTY_LINE18"), events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line19 = {text = tr("LOYALTY_LINE19"), events = ['loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_line20 = {text = tr("LOYALTY_LINE20"), events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line21 = {text = tr("LOYALTY_LINE21"), events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line22 = {text = tr("LOYALTY_LINE22"), events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line23 = {text = tr("LOYALTY_LINE23"), events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_line24 = {text = tr("LOYALTY_LINE24"), events = ['loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	submission_line1 = {text = tr("SUBMISSION_LINE1"), events = ['submission'], personalities = ['shy','bold','serious','kind'], reqs = [], weight = 1, tags = []},
	submission_line2 = {text = tr("SUBMISSION_LINE2"), events = ['submission'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	submission_line3 = {text = tr("SUBMISSION_LINE3"), events = ['submission'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	submission_line4 = {text = tr("SUBMISSION_LINE4"), events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line5 = {text = tr("SUBMISSION_LINE5"), events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line6 = {text = tr("SUBMISSION_LINE6"), events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line7 = {text = tr("SUBMISSION_LINE7"), events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line8 = {text = tr("SUBMISSION_LINE8"), events = ['submission'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	submission_line9 = {text = tr("SUBMISSION_LINE9"), events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line10 = {text = tr("SUBMISSION_LINE10"), events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line11 = {text = tr("SUBMISSION_LINE11"), events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line12 = {text = tr("SUBMISSION_LINE12"), events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line13 = {text = tr("SUBMISSION_LINE13"), events = ['submission'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	submission_line14 = {text = tr("SUBMISSION_LINE14"), events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line15 = {text = tr("SUBMISSION_LINE15"), events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line16 = {text = tr("SUBMISSION_LINE16"), events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line17 = {text = tr("SUBMISSION_LINE17"), events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line18 = {text = tr("SUBMISSION_LINE18"), events = ['submission'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	submission_line19 = {text = tr("SUBMISSION_LINE19"), events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line20 = {text = tr("SUBMISSION_LINE20"), events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line21 = {text = tr("SUBMISSION_LINE21"), events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line22 = {text = tr("SUBMISSION_LINE22"), events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	submission_line23 = {text = tr("SUBMISSION_LINE23"), events = ['submission'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	loyalty_submission_line1 = {text = "[Master]... I understand, I will do as you want.", events = ['submission_loyalty'], personalities = ['shy','bold','serious','kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line2 = {text = "This feels crazy, but I'm ready to do anything for you.", events = ['submission_loyalty'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line3 = {text = "...I-I understand, I will do everything for you.", events = ['submission_loyalty'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line4 = {text = "I understand, [Master]... I just hope I can be of use to you...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line5 = {text = "I-I will devote everything to you, [Master]...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line6 = {text = "I-I'll do anything you ask, [Master]... Honest!", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line7 = {text = "M-my new life with [Master] begins today...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line8 = {text = "This is all I could have ever hoped for...", events = ['submission_loyalty'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line9 = {text = "I just want to do everything for you, [Master]!", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line10 = {text = "[Master] is the greatest! I never ever want to leave.", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line11 = {text = "I truly wish to be nothing but the best for you, [Master]", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line12 = {text = "I can't see myself anywhere else, but at [Master]'s side.", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line13 = {text = "If only others could see how truly wonderful you are, [Master].", events = ['submission_loyalty'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line14 = {text = "I pledge my eternal loyalty to you, [Master].", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line15 = {text = "You needn't ask, [Master]. Your will shall be done.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line16 = {text = "I knew I made the right choice in coming here.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line17 = {text = "A true [Master] know when to use charm as well as an iron fist.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line18 = {text = "Will that be all? You can always count on me to do your bidding.", events = ['submission_loyalty'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line19 = {text = "Yeah! I'll do anything you say!", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line20 = {text = "I knew you would want to keep me around [Master]!", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line21 = {text = "Leave it to me, [Master]! I won't let you down.", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line22 = {text = "Surprisingly enough... I'm okay with you being my [Master].", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	loyalty_submission_line23 = {text = "Gah! Fine! I'll do anything you want, [Master].", events = ['submission_loyalty'], personalities = ['bold'], reqs = [], weight = 1, tags = []},

	writ_success1 = {text = "...This is very kind of you, [Master], but please allow me to stay by your side.", events = ['writ_success'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	writ_success2 = {text = "Wow, are you serious about this? But I can't leave you alone, can I. ", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success3 = {text = "I appreciate this gesture, but my place is at your side, [Master]. ", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success4 = {text = "I... I don't think I can make it out on my own... Please let me stay, [Master]...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success5 = {text = "C-can I stay here? Please...?", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success6 = {text = "R-really? Me? are you sure? I just want to be with you...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success7 = {text = "I-I can't see myself anywhere except by your side, [Master]...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success8 = {text = "Please... Let me stay here with you...", events = ['writ_success'], personalities = ['Shy'], reqs = [], weight = 1, tags = []},
	writ_success9 = {text = "Freedom means nothing if I can't be with you, [Master].", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success10 = {text = "So nice of you to do this for me, but... I want to stay.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success11 = {text = "That's so nice of you, but I want to stay here.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success12 = {text = "I like it here, [Master]. I don't want to leave your side.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success13 = {text = "Your heart is in the right place, and so am I. I'll stay here with you.", events = ['writ_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_success14 = {text = "Thank you, [Master], but my place is here with you.", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success15 = {text = "Freedom? What makes you think my being here isn't enjoyed?", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success16 = {text = "I see... Never the less. I belong here.", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success17 = {text = "Fate brought us together, and though you grant me freedom. My place is here.", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success18 = {text = "My staying here would benefit us both, no?", events = ['writ_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_success19 = {text = "No way! I'm staying right here!", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success20 = {text = "Setting me free? Not going to happen. you need me!", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success21 = {text = "What!? Freeing me? What's the big idea!? I'm staying put!", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success22 = {text = "Just don't think I owe you anything, but I'll stay with you", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_success23 = {text = "If this is some sort of trick... I'm keeping a close eye on you...", events = ['writ_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},

	writ_fail1 = {text = "I... Thank you, but I must go.", events = ['writ_failure'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	writ_fail2 = {text = "Thanks, I guess... I must go now.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail3 = {text = "This is unexpected... You have my gratitude, but I'm afraid, it won't include my service.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail4 = {text = "...I'm sorry. ", events = ['writ_failure'], personalities = ['shy','bold','kind','serious'], reqs = [], weight = 1, tags = []},
	writ_fail5 = {text = "Though I do appreciate what you've done for me.. I must part ways.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail6 = {text = "Thank you. Do take care of yourself.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail7 = {text = "I see. Perhaps we will meet again...", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail8 = {text = "I owe you a great debt. One that I can't repay with my service.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail9 = {text = "I'm overjoyed, but... this isn't where I belong.", events = ['writ_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	writ_fail10 = {text = "Thanks, but I've got better places to be.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail11 = {text = "Freeing me are you? Guess you're not too bad after all. See you later.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail12 = {text = "Oh? Don't think for a second That I'm staying here with you.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail13 = {text = "Yeah yeah... Thanks, but I'm gone.", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail14 = {text = "Ha! Guess I'm finally free from all this!", events = ['writ_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	writ_fail15 = {text = "T-thank you, but my family must be really worried. I have to go...", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail16 = {text = "I-I'm sorry... you've been so nice, but I have to go.", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail17 = {text = "D-don't take it personally... I'm just not ready to stay here.", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail18 = {text = "Oh... So I can go then? Thank you...", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail19 = {text = "Phew... I guess I can finally leave...", events = ['writ_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	writ_fail20 = {text = "Thank you so much for this! I'll pay you back someday!", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail21 = {text = "Such a kind heart, but I can't stay.", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail22 = {text = "I'm so greatful! I'll miss you greatly!", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail23 = {text = "How wonderful! Please understand that I have to leave your side...", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	writ_fail24 = {text = "Ahh! I'm so happy! I'll be sure to write you once in awhile!", events = ['writ_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},

	recruit_success5 = {text = "I-if you would have me....", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success6 = {text = "R-really? Me? are you sure? Okay...", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success7 = {text = "I don't know how much help I'll be, but... I'll join you.", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success8 = {text = "M-maybe... this is for the best?", events = ['recruit_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_success9 = {text = "You want me to join you? I would be delighted!", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success10 = {text = "I only hope to serve you well.", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success11 = {text = "Guess it's my turn to help you now, [Master]!", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success12 = {text = "I'll pack my things as soon as possible.", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success13 = {text = "Oh! I'm so excited to see my new home!", events = ['recruit_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_success14 = {text = "I suppose this should prove advantageous for the both of us.", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success15 = {text = "I can't see a reason to decline.", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success16 = {text = "Let us part this place together, [Master].", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success17 = {text = "Seems that fate has brought us together for a reason.", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success18 = {text = "Might as well join forces. Would benefit us both, no?", events = ['recruit_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_success19 = {text = "Fine, but only because you seem strong enough.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success20 = {text = "Saw the potential in me did you? let's go.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success21 = {text = "I hope you exceed my expectations.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success22 = {text = "Just don't think I owe you anything, but I'll join you.", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_success23 = {text = "Ha! I knew you would need someone like me!", events = ['recruit_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},



	recruit_fail5 = {text = "Though I do appreciate the offer. I must respectfully decline... Do take care of yourself.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail6 = {text = "I don't think I'm quite ready to make such a commitment.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail7 = {text = "Sorry. I don't think I can join you at this time.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail8 = {text = "Perhaps you should seek aid elsewhere?", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail9 = {text = "Apologies. I can't join your cause.", events = ['recruit_fail'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	recruit_fail10 = {text = "What? No way! why would I ever join you?", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail11 = {text = "There's no way I'd join someone on a whim.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail12 = {text = "Oh please... Like I would leave my home behind for you.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail13 = {text = "Don't even think about it. I'm leaving.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail14 = {text = "Thanks, but no thanks. I'm fine on my own.", events = ['recruit_fail'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	recruit_fail15 = {text = "Uhm... I'm sorry... I just can't.", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail16 = {text = "I-I don't really trust you... sorry...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail17 = {text = "D-don't take it personally... I'm just not ready for this...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail18 = {text = "Y-you can find someone better. I know it...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail19 = {text = "P-please. I don't want to go with you...", events = ['recruit_fail'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	recruit_fail20 = {text = "You seem really nice, but I just can't. Sorry.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail21 = {text = "There's too much I have to do. Please understand.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail22 = {text = "A tempting offer, but I just can't.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail23 = {text = "I wish you luck on your travels, but I can't come with you.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	recruit_fail24 = {text = "Maybe if we meet again, but not right now.", events = ['recruit_fail'], personalities = ['kind'], reqs = [], weight = 1, tags = []},

	aphrodisiac1 = {text = "Ah... What's going on... It feels so hot...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac2 = {text = "My body... is getting hotter...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac3 = {text = "AAhhh... What is this... Feeling...", events = ['aphrodisiac'], personalities = ['shy','kind','bold','serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac4 = {text = "Hnnn... you better take responsibility for this...", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac5 = {text = "How dare you do this to me... But hey. Feels kinda nice.", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac6 = {text = "Ugh. My whole body is burning up!", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac7 = {text = "Gah! I really need to take care of this.", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac8 = {text = "I can't control myself. What did you do to me?", events = ['aphrodisiac'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	aphrodisiac9 = {text = "Ahh... It would seem I crave a bit of relief...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac10 = {text = "Such an odd concoction...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac11 = {text = "Perhaps this feeling of lust isn't so bad...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac12 = {text = "Trying to get me in a mood hmm? It's working.", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac13 = {text = "My mind is swarmed with thoughts of pleasure...", events = ['aphrodisiac'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	aphrodisiac14 = {text = "M-my body's getting warmer.", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac15 = {text = "O-oh no... I can't stop myself from...", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac16 = {text = "It feels so good... please don't let it end...", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac17 = {text = "S-so hard to resist...", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac18 = {text = "W-why have you done this to me...?", events = ['aphrodisiac'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	aphrodisiac19 = {text = "In a mood are we? So am I.", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac20 = {text = "Ahh... you know just what to do.", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac21 = {text = "Are we about to have some fun?", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac22 = {text = "Does this mean I can please you?", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	aphrodisiac23 = {text = "I'm getting so excited!", events = ['aphrodisiac'], personalities = ['kind'], reqs = [], weight = 1, tags = []},

	lockpick_success1 = {text = "I did it, [Master]. Let's see what's inside.", events = ['lockpick_success'], personalities = ['bold','serious','kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_success2 = {text = "Hmph, piece of cake.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success3 = {text = "I-I did it.", events = ['lockpick_success'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_success4 = {text = "It's done.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success5 = {text = "This lock is no match for me.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success6 = {text = "Is it... Okay to do this? It's open...", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success7 = {text = "O-oh! I actually did it!", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success8 = {text = "W-wow... I wonder what's inside?", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success9 = {text = "Ahh! Oh? I actually got it open?", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success10 = {text = "I-I can't believe I actually did it...", events = ['lockpick_success'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_success11 = {text = "I did it! Now we can get what's inside.", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success12 = {text = "I sure hope no one misses this...", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success13 = {text = "We can use this treasure to make everyone happy!", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success14 = {text = "Looks like I have a great teacher!", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success15 = {text = "If only it was always this easy.", events = ['lockpick_success'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_success16 = {text = "A trivial matter for the likes of me.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success17 = {text = "A twist, and turn, and there you have it.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success18 = {text = "Hmm? Was that all this lock could muster?", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success19 = {text = "It would seem I have gotten better at this.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success20 = {text = "The treasure is ours to claim.", events = ['lockpick_success'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_success21 = {text = "No lock can beat me!", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success22 = {text = "This loot better be worth it.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success23 = {text = "Ugh. Really? That was too easy!", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success24 = {text = "We could have just smashed it you know, but I got it.", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_success25 = {text = "This is why you need someone like me!", events = ['lockpick_success'], personalities = ['bold'], reqs = [], weight = 1, tags = []},

	lockpick_failure1 = {text = "Oh, uh... I'm sorry.", events = ['lockpick_failure'], personalities = ['bold','serious','kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure2 = {text = "T-this can't be my fault.", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure3 = {text = "I'm sorry!", events = ['lockpick_failure'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure4 = {text = "...This can't be helped.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure5 = {text = "This stupid lock... I'll get it next time", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure6 = {text = "Stupid lock! I can't get it open!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure7 = {text = "It broke my pick!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure8 = {text = "Whatever! I bet the treasure wasn't even worth it.", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure9 = {text = "I failed!? No way!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure10 = {text = "Gah! It's too hard for me!", events = ['lockpick_failure'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	lockpick_failure11 = {text = "It would seem I have failed.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure12 = {text = "The lock is too complex for the likes of me.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure13 = {text = "A shame. I wanted to see what was inside.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure14 = {text = "Perhaps this is outside of my talents?", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure15 = {text = "I can't get it to open.", events = ['lockpick_failure'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	lockpick_failure16 = {text = "I'm sorry. This is too hard.", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure17 = {text = "Oh no. My pick broke.", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure18 = {text = "Darn. I thought I had it too...", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure19 = {text = "Aww... I bet it was something good too...", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure20 = {text = "I'll get it next time!", events = ['lockpick_failure'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	lockpick_failure21 = {text = "I-I knew I couldn't do it...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure22 = {text = "S-sorry. It's too hard...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure23 = {text = "O-oh. I guess I'm not good enough...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure24 = {text = "P-please forgive me. I failed...", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	lockpick_failure25 = {text = "T-this is too much... I can't handle it.", events = ['lockpick_failure'], personalities = ['shy'], reqs = [], weight = 1, tags = []},


	greeting_line_positive1 = {text = "[Master] would like to spend time {^together:with me}...?", events = ['date_greet_positive'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	greeting_line_positive2 = {text = "It's my pleasure to accompany you, [Master].", events = ['date_greet_positive'], personalities = ['kind', 'serious'], reqs = [], weight = 1, tags = []},
	greeting_line_positive3 = {text = "Let's have some fun together, [Master]!", events = ['date_greet_positive'], personalities = ['bold'], reqs = [], weight = 1, tags = []},

	greeting_line_cautious1 = {text = "Yes, [Master], what do you want me for?", events = ['date_greet_cautious'], personalities = ['serious','shy','bold','kind'], reqs = [], weight = 1, tags = []},
	greeting_line_cautious2 = {text = "I still have a work today, can we get over it quickly?", events = ['date_greet_cautious'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	greeting_line_cautious3 = {text = "What do you want of me? *grumble*", events = ['date_greet_cautious'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	greeting_line_cautious4 = {text = "Y-yes, [Master]. What can I do for you?", events = ['date_greet_cautious'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},

	punish_line_light1 = {text = "Ouch! It hurts!", events = ['date_punish_light'], personalities = ['bold','kind','serious','shy'], reqs = [], weight = 100, tags = []},
	punish_line_light2 = {text = "What was that for!?", events = ['date_punish_light'], personalities = ['bold','kind','serious'], reqs = [], weight = 1, tags = []},
	punish_line_light3 = {text = "Ugh!... You...", events = ['date_punish_light'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	punish_line_light4 = {text = "No! Stop...", events = ['date_punish_light'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},

	punish_line_heavy1 = {text = "Ouch! Please stop!", events = ['date_punish_heavy'], personalities = ['bold','kind','serious'], reqs = [], weight = 1, tags = []},

	public_line1 = {text = "N-no way, please don't do this in front of everyone...", events = ['date_public'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	public_line2 = {text = "Wha... Why you brought everyone here!?", events = ['date_public'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	public_line3 = {text = "This... is going to be humiliating.", events = ['date_public'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	public_line4 = {text = "Are you trying to scare me like this? See if I care.", events = ['date_public'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	public_line5 = {text = "P-please, [Master], I don't like being watched.", events = ['date_public'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	public_line6 = {text = "W-why everyone is here? I don't...", events = ['date_public'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	public_line7 = {text = "N-no... No! please...", events = ['date_public'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},

	#[2* in next cases will automatically translate from dated person
	public_observe_line1 = {text = "[Master] is going to punish you, [2name]...?", events = ['date_public_observe'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	public_observe_line2 = {text = "Hmph, serves you right.", events = ['date_public_observe'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	public_observe_line3 = {text = "Looks like [2name] is being punished. At least I get a break from work.", events = ['date_public_observe'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	public_observe_line4 = {text = "Please accept this with dignity.", events = ['date_public_observe'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	public_observe_line5 = {text = "......", events = ['date_public_observe'], personalities = ['shy','kind','serious'], reqs = [], weight = 1, tags = []},
	public_observe_line6 = {text = "If [he] dies, I call dibs on [his] stuff.", events = ['date_public_observe'], personalities = ['bold'], reqs = [], weight = 1, tags = ['second_character_translation']},
	public_observe_line7 = {text = "Looks like you will be getting a good lesson, [2name]. ", events = ['date_public_observe'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	
	marry_propose_agree1 = {text = "A-are you serious?.. I can't believe it, of course i will, [Master]!", events = ['marry_proposal_agree'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	marry_propose_agree2 = {text = "Wa... You are not kidding, right? I agree!", events = ['marry_proposal_agree'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	marry_propose_agree3 = {text = "Y-Yes, of course I agree!", events = ['marry_proposal_agree'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	
	marry_proposal_agreed_before1 = {text = "Didn't I already gave my agreement..?", events = ['marry_proposal_agreed_before'], personalities = ['shy','kind','serious','bold'], reqs = [], weight = 1, tags = []},
	marry_proposal_agreed_before2 = {text = "Y-yes, we have discussed it and I agreed...", events = ['marry_proposal_agreed_before'], personalities = ['shy','kind','serious','bold'], reqs = [], weight = 1, tags = []},
	
	marry_propose_refuse1 = {text = "T-that's... really sudden... I'm sorry, I can't agree to this.", events = ['marry_proposal_refuse'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	marry_propose_refuse2 = {text = "Y-You what? No way. Don't joke like that, [Master]", events = ['marry_proposal_refuse'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	marry_propose_refuse3 = {text = "I'm sorry, I can't agree to this!", events = ['marry_proposal_refuse'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	
	
	date_propose_agree1 = {text = "I-I would like to get closer with you, [Master]. ", events = ['date_proposal_agree'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	date_propose_agree2 = {text = "Well, your charm worked this time on me. ", events = ['date_proposal_agree'], personalities = ['serious','bold'], reqs = [], weight = 1, tags = []},
	date_propose_agree3 = {text = "Okay, why not be naughty?", events = ['date_proposal_agree'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_propose_agree4 = {text = "This is to help our bodily needs, correct?", events = ['date_proposal_agree'], personalities = ['serious','kind'], reqs = [], weight = 1, tags = []},
	date_propose_agree5 = {text = "W-well, if you don't mind someone like me...", events = ['date_proposal_agree'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_propose_agree6 = {text = "It's a pleasure you feel the same way.", events = ['date_proposal_agree'], personalities = ['kind'], reqs = [], weight = 1, tags = []},

	date_propose_refuse1 = {text = "Sorry, I don't feel about you in same way.", events = ['date_proposal_refuse'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	date_propose_refuse2 = {text = "P-please, maybe some other time...", events = ['date_proposal_refuse'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	date_propose_refuse3 = {text = "I'd rather not.", events = ['date_proposal_refuse'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	date_propose_refuse4 = {text = "Uh, no. This is awkward.", events = ['date_proposal_refuse'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_propose_refuse5 = {text = "I'm sure there's someone better than me.", events = ['date_proposal_refuse'], personalities = ['kind','shy','serious'], reqs = [], weight = 1, tags = []},


	date_propose_had_sex1 = {text = "Don't be silly, didn't we do it already?", events = ['date_proposal_had_sex'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	date_propose_had_sex2 = {text = "Sure, if you want me to confirm it officially...", events = ['date_proposal_had_sex'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	date_propose_had_sex3 = {text = "...But didn't we already do that?", events = ['date_proposal_had_sex'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},

	date_propose_was_forced1 = {text = "You didn't really give me much of a choice last time, why bother now?", events = ['date_proposal_was_forced'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	date_propose_was_forced2 = {text = "Why didn't you ask me before? What's the point now...", events = ['date_proposal_was_forced'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	date_propose_was_forced3 = {text = "Do as you wish. You've already did, though. ", events = ['date_proposal_was_forced'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	date_propose_was_forced4 = {text = "Just getting this out of the way now? Fine. ", events = ['date_proposal_was_forced'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},

	date_sex_offer1 = {text = "...[Master]? I'd like to continue this affair.", events = ['date_sex_offer'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	date_sex_offer2 = {text = "Uhm, [Master], we could do, you know, lewd stuff... If you don't mind.", events = ['date_sex_offer'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_sex_offer3 = {text = "Hey, you are not going to leave me just now?", events = ['date_sex_offer'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_sex_offer4 = {text = "Hey, would you mind keeping me company for little longer?", events = ['date_sex_offer'], personalities = ['bold','serious'], reqs = [], weight = 1, tags = []},
	date_sex_offer5 = {text = "My body feels like... It could use some more attention.", events = ['date_sex_offer'], personalities = ['bold','serious','kind'], reqs = [], weight = 1, tags = []},
	date_sex_offer6 = {text = "Uhm, can we continue this? I don't want to leave you. ", events = ['date_sex_offer'], personalities = ['shy'], reqs = [], weight = 1, tags = []},

	date_affection1 = {text = "This... Feels nice.", events = ['date_affection'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	date_affection2 = {text = "I might get used to it.", events = ['date_affection'], personalities = ['kind','serious','bold'], reqs = [], weight = 1, tags = []},
	date_affection3 = {text = "You will spoil me like this, [Master].", events = ['date_affection'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	date_affection4 = {text = "Please, I didn't... Deserve it... [Master].", events = ['date_affection'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_affection5 = {text = "You are being too nice to me.", events = ['date_affection'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	date_affection6 = {text = "I don't mind you praising me some more.", events = ['date_affection'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_affection7 = {text = "Your affection is appreciated, [Master].", events = ['date_affection'], personalities = ['serious'], reqs = [], weight = 1, tags = []},

	date_scold1 = {text = "I'm sorry [Master]. ", events = ['date_scold'], personalities = ['kind','serious','shy'], reqs = [], weight = 1, tags = []},
	date_scold2 = {text = "You don't have to yell at me. ", events = ['date_scold'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_scold3 = {text = "I'm sorry, please don't be angry. ", events = ['date_scold'], personalities = ['kind','shy'], reqs = [], weight = 1, tags = []},
	date_scold4 = {text = "Stop, I didn't deserve this! ", events = ['date_scold'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_scold5 = {text = "I'm sorry you feel this way.", events = ['date_scold'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},

	mimic_eat1 = {text = "Oh no! It's alive!", events = ['mimic_eat'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_eat2 = {text = "Noo! It's got me! Help!", events = ['mimic_eat','mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_eat3 = {text = "Ugh, I can't get out!", events = ['mimic_eat','mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},


	mimic_molest1 = {text = "Agh... It's touching me all over!", events = ['mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_molest2 = {text = "What's the... Ah! Stop!", events = ['mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_molest3 = {text = "N-no, stop! No there!", events = ['mimic_rape'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},

	mimic_leave1 = {text = "N-no, stop! You can't leave me!", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_leave2 = {text = "Please, wait! Help me!", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_leave3 = {text = "No! *sob* Please, I beg...", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_leave4 = {text = "Wait, I don't wanna die!", events = ['mimic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},

	mimic_erotic_leave1 = {text = "Y-you gonna leave me- Ah!.. Like this?", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = []},
	mimic_erotic_leave2 = {text = "No, I hate it! Please help!", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = false }]},
	mimic_erotic_leave3 = {text = "Noooo! This feels gross!", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = false }]},
	mimic_erotic_leave4 = {text = "Agh, why you don't help me?!", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = false }]},

	mimic_erotic_leave5 = {text = "Ooh! I starting to... Like this...", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = true }]},
	mimic_erotic_leave6 = {text = "Ah.. This... Is not too bad...", events = ['mimic_erotic_leave'], personalities = ['kind','serious','shy','bold'], reqs = [], weight = 1, tags = [{code = 'trait', trait = 'deviant', check = true }]},

	praise_reject1 = {text = "You think you can tame me like this!?", events = ['praise_reject'], personalities = ['kind','serious','bold'], reqs = [], weight = 1, tags = []},
	praise_reject2 = {text = "Please, stop this farce.", events = ['praise_reject'], personalities = ['serious','shy','kind'], reqs = [], weight = 1, tags = []},
	praise_reject3 = {text = "You've got to be kidding. ", events = ['praise_reject'], personalities = ['serious','shy','bold','kind'], reqs = [], weight = 1, tags = []},

	date_start1 = {text = "I'm glad to accompany you, [Master]. ", events = ['date_start'], personalities = ['serious','shy','bold','kind'], reqs = [], weight = 1, tags = []},
	date_start2 = {text = "What do you want me for, [Master]? ", events = ['date_start'], personalities = ['serious','shy','bold','kind'], reqs = [], weight = 1, tags = []},
	date_start3 = {text = "[Master], this... Makes me a bit nervous. ", events = ['date_start'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	date_start4 = {text = "Me, together with [Master]... ", events = ['date_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_start5 = {text = "So, what do we do now, [Master]?", events = ['date_start'], personalities = ['bold','serious','kind'], reqs = [], weight = 1, tags = []},
	date_start6 = {text = "As long as I get a break from the work...", events = ['date_start'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_start7 = {text = "Uhm... I'm sorry for not being a very good company for [Master].", events = ['date_start'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_start8 = {text = "You called for me, [Master]?", events = ['date_start'], personalities = ['kind','serious'], reqs = [], weight = 1, tags = []},
	date_start9 = {text = "I'll accompany you to my best capability, [Master].", events = ['date_start'], personalities = ['serious'], reqs = [], weight = 1, tags = []},

	date_start_happy1 = {text = "Finally, I was thinking you'd never ask!", events = ['date_start_happy'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_start_happy2 = {text = "Hey, how were you doing, [Master]?", events = ['date_start_happy'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_start_happy3 = {text = "Hehe, want me to tell you how I spent my day?", events = ['date_start_happy'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_start_happy4 = {text = "I'm glad to be together with you, [Master]. ", events = ['date_start_happy'], personalities = ['shy','kind'], reqs = [], weight = 1, tags = []},
	date_start_happy5 = {text = "I hope others won't get jealous of us...", events = ['date_start_happy'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_start_happy6 = {text = "T-thank you for choosing me, [Master]!", events = ['date_start_happy'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_start_happy7 = {text = "It is a pleasure to be with you, [Master].", events = ['date_start_happy'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	date_start_happy8 = {text = "It's a pleasure to be in your company, [Master].", events = ['date_start_happy'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	date_start_happy9 = {text = "It's a honor to be your chosen, [Master].", events = ['date_start_happy'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	date_start_happy10 = {text = "It makes me happy you've called me, [Master].", events = ['date_start_happy'], personalities = ['serious','kind'], reqs = [], weight = 1, tags = []},
	date_start_happy11 = {text = "He-he, only you and me now, [Master].", events = ['date_start_happy'], personalities = ['bold'], reqs = [], weight = 1, tags = []},

	date_start_angry1 = {text = "Don't think you can make me like you now!", events = ['date_start_angry'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_start_angry2 = {text = "Hmph, you think you can talk your way out of what you've done to me?", events = ['date_start_angry'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_start_angry3 = {text = "Just make it quick, you bastard.", events = ['date_start_angry'], personalities = ['bold'], reqs = [], weight = 1, tags = []},
	date_start_angry4 = {text = "I don't want to do this.", events = ['date_start_angry'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	date_start_angry5 = {text = "Please, just let me go on my own.", events = ['date_start_angry'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	date_start_angry6 = {text = "You are a horrible person, I don't want to be here.", events = ['date_start_angry'], personalities = ['kind'], reqs = [], weight = 1, tags = []},
	date_start_angry7 = {text = "Please, let me go!", events = ['date_start_angry'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_start_angry8 = {text = "I'll do what you ask, j-just let me go...", events = ['date_start_angry'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_start_angry9 = {text = "Why can't you let me be fre... *sob*", events = ['date_start_angry'], personalities = ['shy'], reqs = [], weight = 1, tags = []},
	date_start_angry10 = {text = "Your efforts are futile.", events = ['date_start_angry'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	date_start_angry11 = {text = "What's this? Are you trying to make me like you..?", events = ['date_start_angry'], personalities = ['serious'], reqs = [], weight = 1, tags = []},
	date_start_angry12 = {text = "Do what you want, this will change nothing.", events = ['date_start_angry'], personalities = ['serious'], reqs = [], weight = 1, tags = []},

	treat_food_resist1 = {text = "You trying to buy my disposition with something like that? Pathetic.", events = ['treat_food_resist'], personalities = ['serious','kind','bold','shy'], reqs = [], weight = 1, tags = []},
	treat_food_like1 = {text = "Wow, how did you know this is my favorite?", events = ['treat_food_like'], personalities = ['serious','kind','bold','shy'], reqs = [], weight = 1, tags = []},
	treat_food_hate1 = {text = "Sorry, I can't stomach this.", events = ['treat_food_hate'], personalities = ['serious','kind','bold','shy'], reqs = [], weight = 1, tags = []},
	treat_food_neutral1 = {text = "Thank you, [master], I'll accept this.", events = ['treat_food_neutral'], personalities = ['serious','kind','bold','shy'], reqs = [], weight = 1, tags = []},

}

func build_lines():
	for i in individual_lines.values():
		for k in i.events:
			if !lines.has(k):
				lines[k] = []
			lines[k].append(i.duplicate(true))
#
#	var dict = {
#		shy = 0,
#		kind = 0,
#		serious = 0,
#		bold = 0,
#	}
#	for i in lines['date_punish_heavy']: #+ lines['date_punish_heavy']:
#		for k in i.personalities:
#			dict[k] += 1
#	print(dict)

func return_chat_line(character, event):
	var array = []
	for i in lines[event]:
		if i.personalities.has(character.get_stat('personality')) && character.checkreqs(i.reqs) == true:
			if i.has('arg_reqs'):
				var check = false
				for k in i.arg_reqs:
					match k:
						'partner_is_master':
							if gui_controller.sex_panel.has_master():
								check = true

				if check == false:
					continue
			array.append([i.text, i.weight])
	if array.size() > 0:
		var line = character.translate(input_handler.weightedrandom(array))
		if character.get_stat('race') in ['BeastkinCat','HalfkinCat'] && input_handler.globalsettings.meowing == true:
			line = process_meowing(line)
		return line

func show_chat_line(character, event):
	var line = return_chat_line(character, event)
	add_new_chatter(character, line)



func rebuild_text(words):
	var res := ''
	for w in words:
		res = res + ' ' + w
	if words.size() > 0:
		res = res.substr(1)
	return res

func process_stutter(text:String, num = 1, mlen = 3, esc_list = []):
	var words = text.split(' ')

	var buf = []
	for i in range(words.size()):
		var w = words[i]
		if w in esc_list: continue
		if w.length() < mlen: continue
		buf.push_back(i)

	for i in range(num):
		if buf.empty(): break
		var tmp = randi() % buf.size()
		words[tmp] = words[tmp][0] + '-' + words[tmp]

	return rebuild_text(words)

var meowing_replacements = {
	ma = ['mya'],
	mo = ['myo'],
	mi = ['meow'],
	na = ['nya'],
	no = ['nyo'],
	ni = ['neow'],

}

func process_drunk(text: String, insert:Array, num = 1):
	var res = ' ' + text + ' '
	for i in range(num):
		var count = res.count(' ')
		var pos = randi() % count
		var tpos = res.find(' ')
		for ii in range(pos):
			tpos = res.find(' ', tpos + 1)
		var word = insert[randi() % insert.size()]
		res = res.insert(tpos, ' ' + word)
	return res.trim_prefix(' ').trim_suffix(' ')



func process_meowing(text: String, num = 1):
	var words = text.split(' ')

	var buf = []
	for i in range(words.size()):
		var w = words[i]
		if w.begins_with('[') or w.ends_with(']'): continue
		for k in meowing_replacements.keys():
			if w.findn(k) >= 0:
				var pos = w.findn(k)
				var word = w.substr(pos, pos + k.length())
				var replace_word = meowing_replacements[k][randi()%meowing_replacements[k].size()]
				replace_word = case_compare(word, replace_word)
				w = w.insert(w.findn(k), '#').replacen('#' + k, replace_word)
				words[i] = w
				break

	return rebuild_text(words)

func case_compare(word1, word2):
	if word1 == word1.to_upper():
		word2 = word2.to_upper()
	if word1 == word1.capitalize():
		word2 = word2.capitalize()
	return word2

