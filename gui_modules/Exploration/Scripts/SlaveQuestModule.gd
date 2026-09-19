extends Panel
#The slave market's Quests tab: the slaver rank, the quest table, the details and the hand-over list.

const RANKS = ['D', 'C', 'B', 'A', 'S']
const FIT_STATES = ['Met', 'Train', 'No']
const FIT_STATE_OF = {met = 'Met', train = 'No', no = 'No'}
const FIT_TINTS = {met = Color(1, 1, 1), train = Color(1, 0.45, 0.45, 0.8), no = Color(1, 0.45, 0.45, 0.8)}
const FIT_FADES = {met = Color(1, 1, 1), train = Color(1, 1, 1, 0.45), no = Color(1, 1, 1, 0.45)}

var cur_quest_id = null
var pending_character = null

var rank_node
var list
var details
var candidates
var hide_unfit


func _ready():
	rank_node = _find(self, "Rank")
	list = _find(self, "List")
	details = _find(self, "Details")
	candidates = _find(self, "Candidates")
	hide_unfit = _find(self, "HideUnfit")
	if hide_unfit is BaseButton:
		hide_unfit.toggle_mode = true
		hide_unfit.connect("toggled", self, "_on_hide_unfit_toggled")
	ResourceScripts.slave_quests.connect("quests_changed", self, "_on_quests_changed")
	ResourceScripts.slave_quests.connect("rank_changed", self, "_on_quests_changed")
	ResourceScripts.slave_quests.connect("tokens_changed", self, "_on_tokens_changed")
	input_handler.connect("portrait_taken", self, "_on_portrait_taken")


func open():
	ResourceScripts.slave_quests.fill_quests()
	rebuild()
	show()


func rebuild():
	build_rank_header()
	build_quest_list()
	var sq = ResourceScripts.slave_quests
	if sq.has_quest(cur_quest_id) and sq.is_quest_open_for_delivery(sq.get_quest(cur_quest_id)):
		show_quest(cur_quest_id)
	else:
		select_first()


#--------------header--------------

func build_rank_header():
	if rank_node == null:
		return
	var sq = ResourceScripts.slave_quests
	var help = _find(rank_node, "Help")
	if help != null:
		globals.connecttexttooltip(help, sq.rank_help_text())
	var rank = sq.get_rank()
	_put_text(rank_node, "RankLetter", rank)
	_put_text(rank_node, "RankLabel", globals._report_text("SQ_RANK_LABEL", [rank]))
	for code in RANKS:
		_show(rank_node, "Rank" + code, code == rank)
	var top = sq.is_max_rank()
	if !top:
		_put_text(rank_node, "NextRank", globals._report_text("SQ_NEXT_RANK", [sq.quest_data.ranks[sq.get_rank_index() + 1].code]))
	_show(rank_node, "NextRank", !top)

	var xp_max = 1 if top else sq.xp_threshold()
	var xp = 1 if top else sq.get_rank_xp()
	_put_range(rank_node, "XpBar", xp_max, xp)
	_put_text(rank_node, "XpText", tr("SQ_RANK_XP_MAX") if top else "")
	_put_text(rank_node, "XpLabel", tr("SQ_RANK_XP_MAX") if top else tr("SQ_XP_HEADING"))

	_put_text(rank_node, "Tokens", str(sq.get_tokens()))
	var token_icon = _find(rank_node, "TokenIcon")
	if token_icon is TextureRect:
		token_icon.texture = sq.token_icon()
	var token_box = _find(rank_node, "TokenBox")
	if token_box != null:
		globals.connecttexttooltip(token_box, tr("SQ_TOKENS_TOOLTIP"))

	var target = sq.sales_target()
	var sold = sq.get_rank_sales()
	if top:
		target = int(sq.quest_data.tokens.top_sales.every)
		sold = int(sq.get_progress().get('top_sales', 0))
		_put_text(rank_node, "SalesHeading", globals._report_text("SQ_SALES_HEADING_TOP", [target, sq.quest_data.tokens.top_sales.tokens]))
	else:
		_put_text(rank_node, "SalesHeading", tr("SQ_SALES_HEADING"))
	for node_name in ["SalesBar", "SalesText", "SalesLabel", "SalesBox"]:
		_show(rank_node, node_name, true)
	_put_range(rank_node, "SalesBar", target, sold)
	_put_text(rank_node, "SalesText", "%d/%d" % [sold, target])
	_put_text(rank_node, "SalesLabel", globals._report_text("SQ_RANK_SALES", [sold, target]))
	var pips = _find(rank_node, "SalesPips")
	if pips is Container and pips.has_node("Pip"):
		input_handler.ClearContainer(pips, ['Pip'])
		for i in range(target):
			var pip = input_handler.DuplicateContainerTemplate(pips, 'Pip')
			var on = pip.get_node_or_null("On")
			if on != null:
				on.visible = i < sold


#--------------list--------------

#a completed quest leaves the table at once but stays in the pool until the daily tick
func build_quest_list():
	var sq = ResourceScripts.slave_quests
	var quests = []
	for quest in sq.get_sorted_quests():
		if sq.is_quest_open_for_delivery(quest):
			quests.append(quest)
	if list is Container and list.has_node("Row"):
		input_handler.ClearContainer(list, ['Row'])
		for quest in quests:
			var row = input_handler.DuplicateContainerTemplate(list, 'Row')
			row.set_meta("quest_id", quest.id)
			fill_quest_fields(row, quest)
			var name_label = _find(row, "Name")
			if name_label != null:
				_put_text(row, "Name", tr(quest.name))
				if name_label is Label and sq.has_ready_candidate(quest):
					name_label.add_color_override("font_color", Color(variables.hexcolordict.green))
			elif row is Button:
				row.text = tr(quest.name)
			_put_text(row, "Info", sq.quest_list_info(quest))
			_show(row, "Selected", quest.id == cur_quest_id)
			if row is BaseButton:
				if row.toggle_mode:
					row.pressed = quest.id == cur_quest_id
				row.connect("pressed", self, "show_quest", [quest.id])
	_show(self, "Empty", quests.empty())


func fill_quest_fields(root, quest):
	var sq = ResourceScripts.slave_quests
	var req = quest.requirements[0]
	var count = int(req.value)
	var crest = _find(root, "Crest")
	if crest is TextureRect:
		sq.process_faction_icon(crest, quest.faction)
	var icons = _find(root, "ReqIcons")
	if icons is Container and icons.has_node("ReqIcon"):
		input_handler.ClearContainer(icons, ['ReqIcon'])
		for entry in sq.requirement_icons(quest):
			var icon = input_handler.DuplicateContainerTemplate(icons, 'ReqIcon')
			icon.texture = entry.texture
			globals.connecttexttooltip(icon, entry.tooltip)
			if entry.textures.size() > 1:
				cycle_icon(icon, entry.textures)
	_put_text(root, "Gold", str(sq.quest_total_gold(quest)))
	_put_text(root, "GoldPer", globals._report_text("SQ_GOLD_PER_SLAVE", [sq.next_payment(quest)]))
	_show(root, "GoldPerRow", count > 1 and sq.is_quest_open_for_delivery(quest))
	_put_text(root, "Days", "%d %s" % [int(quest.time_limit), tr("QUESTDAYSLEFT")])
	_put_text(root, "DaysNumber", str(int(quest.time_limit)))
	_put_text(root, "Count", "%d/%d" % [int(req.delivered_slaves), count])
	_show(root, "CountRow", count > 1)


#--------------details--------------

func show_quest(quest_id):
	var sq = ResourceScripts.slave_quests
	if !sq.has_quest(quest_id):
		return
	cur_quest_id = quest_id
	if list != null:
		for row in list.get_children():
			if !row.has_meta("quest_id"):
				continue
			var selected = row.get_meta("quest_id") == quest_id
			_show(row, "Selected", selected)
			if row is BaseButton and row.toggle_mode:
				row.pressed = selected
	var quest = sq.get_quest(quest_id)
	fill_details(quest)
	build_candidates(quest)


func fill_details(quest):
	if details == null:
		return
	var sq = ResourceScripts.slave_quests
	details.show()
	fill_quest_fields(details, quest)
	var faction = sq.get_faction(quest.faction)
	_put_text(details, "Title", tr(quest.name))
	var description = _find(details, "Description")
	if description != null:
		var text = tr(quest.descript)
		if description is RichTextLabel:
			var color = description.get_meta("faction_color") if description.has_meta("faction_color") else "#8fd18f"
			text = text.replace("[factionname]", "[color=%s]%s[/color]" % [color, tr(faction.name)])
		else:
			text = text.replace("[factionname]", tr(faction.name))
		_put_text(details, "Description", text)
	var lines = sq.requirement_lines(quest)
	if lines.basic.empty():
		lines.basic.append(tr("SQ_REQS_ANY"))
	var combined = _find(details, "Requirements")
	if combined != null:
		var text = _header(combined, tr("QUESTSLAVEREQUIRED")) + "\n" + _bullets(combined, lines.basic)
		if !lines.advanced.empty():
			text += "\n" + _header(combined, tr("SQ_REQS_ADVANCED")) + "\n" + _bullets(combined, lines.advanced)
		_put_text(details, "Requirements", text)
	var basic_box = _find(details, "ReqBasic")
	if basic_box != null:
		_put_text(details, "ReqBasic", _bullets(basic_box, lines.basic))
	var advanced_box = _find(details, "ReqAdvanced")
	if advanced_box != null:
		_put_text(details, "ReqAdvanced", _bullets(advanced_box, lines.advanced))
	_show(details, "ReqAdvancedBox", !lines.advanced.empty())


func select_first():
	cur_quest_id = null
	var sq = ResourceScripts.slave_quests
	for quest in sq.get_sorted_quests():
		if sq.is_quest_open_for_delivery(quest):
			show_quest(quest.id)
			return
	if details != null:
		details.hide()
	build_candidates(null)


#--------------hand-over--------------

func build_candidates(quest):
	if !(candidates is Container) or !candidates.has_node("Candidate"):
		return
	var sq = ResourceScripts.slave_quests
	input_handler.ClearContainer(candidates, ['Candidate'])
	var entries = []
	if quest != null and sq.is_quest_open_for_delivery(quest):
		entries = sq.delivery_candidates(quest)
	var only_fit = hide_unfit is BaseButton and hide_unfit.pressed
	var shown = 0
	for entry in entries:
		if only_fit and entry.status != 'green':
			continue
		var node = input_handler.DuplicateContainerTemplate(candidates, 'Candidate')
		fill_candidate(node, entry)
		shown += 1
	_show(self, "CandidatesEmpty", quest != null and shown == 0)


func fill_candidate(node, entry):
	var character = entry.character
	node.set_meta("character_id", character.id)
	var portrait = _find(node, "Portrait")
	if portrait is TextureRect:
		portrait.texture = character.get_icon_small()
		input_handler.queue_portrait(character)
	_put_text(node, "Name", character.get_short_name())
	var name_label = _find(node, "Name")
	if name_label is Label:
		name_label.add_color_override("font_color", Color(variables.hexcolordict[entry.status]))
	var icons = _find(node, "FitIcons")
	if icons is Container and icons.has_node("FitIcon"):
		input_handler.ClearContainer(icons, ['FitIcon'])
		for icon_data in entry.icons:
			var icon = input_handler.DuplicateContainerTemplate(icons, 'FitIcon')
			icon.texture = icon_data.texture
			var has_marks = false
			for state in FIT_STATES:
				var mark = icon.get_node_or_null(state)
				if mark is CanvasItem:
					has_marks = true
					mark.visible = state == FIT_STATE_OF[icon_data.state]
			icon.self_modulate = FIT_FADES[icon_data.state] if has_marks else FIT_TINTS[icon_data.state]
			globals.connecttexttooltip(icon, icon_data.tooltip)
	var button = _find(node, "HandOver")
	if button is BaseButton:
		button.disabled = entry.status != 'green'
		button.connect("pressed", self, "slave_selected", [character])
		if entry.status != 'green':
			globals.connecttexttooltip(button, tr("SQ_CAND_" + entry.status.to_upper()))


func _on_portrait_taken(id):
	if !(candidates is Container):
		return
	for node in candidates.get_children():
		if !node.has_meta("character_id") or node.get_meta("character_id") != id:
			continue
		var portrait = _find(node, "Portrait")
		var character = characters_pool.get_char_by_id(id)
		if portrait is TextureRect and character != null:
			portrait.texture = character.get_icon_small()


func _on_hide_unfit_toggled(_pressed):
	var sq = ResourceScripts.slave_quests
	build_candidates(sq.get_quest(cur_quest_id) if sq.has_quest(cur_quest_id) else null)


func slave_selected(character):
	var sq = ResourceScripts.slave_quests
	if !sq.can_deliver(character) or !sq.has_quest(cur_quest_id):
		return
	pending_character = character
	var text = globals._report_text("SQ_DELIVER_CONFIRM", [sq.next_payment(sq.get_quest(cur_quest_id))])
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'deliver_confirm', character.translate(text)])


func deliver_confirm():
	var sq = ResourceScripts.slave_quests
	var character = pending_character
	pending_character = null
	if character == null or !sq.has_quest(cur_quest_id):
		return
	var res = sq.deliver(cur_quest_id, character)
	if res.paid > 0:
		input_handler.PlaySound("money_spend")


func _on_quests_changed():
	if is_visible_in_tree():
		rebuild()


func _on_tokens_changed():
	if is_visible_in_tree():
		build_rank_header()


#--------------choice icons--------------

const CROSSFADE = preload("res://gui_modules/Exploration/Modules/icon_crossfade.shader")
const CYCLE_HOLD = 1.6
const CYCLE_FADE = 0.9

var cycling = []
var cycle_time = 0.0


func cycle_icon(icon, textures):
	var material = ShaderMaterial.new()
	material.shader = CROSSFADE
	icon.material = material
	var entry = {icon = icon, textures = textures, shown = -1}
	cycling.append(entry)
	_show_cycle(entry)
	set_process(true)


func _process(delta):
	cycle_time += delta
	var alive = []
	for entry in cycling:
		if is_instance_valid(entry.icon) and entry.icon.is_inside_tree():
			alive.append(entry)
			if is_visible_in_tree():
				_show_cycle(entry)
	cycling = alive
	if cycling.empty():
		set_process(false)


func _show_cycle(entry):
	var period = CYCLE_HOLD + CYCLE_FADE
	var count = entry.textures.size()
	var index = int(floor(cycle_time / period)) % count
	var material = entry.icon.material
	if entry.shown != index:
		entry.shown = index
		entry.icon.texture = entry.textures[index]
		material.set_shader_param("next_texture", entry.textures[(index + 1) % count])
	var fading = fmod(cycle_time, period) - CYCLE_HOLD
	material.set_shader_param("blend", smoothstep(0.0, CYCLE_FADE, fading) if fading > 0 else 0.0)


#--------------helpers--------------

func _find(root, node_name):
	if root == null:
		return null
	return root.find_node(node_name, true, false)


func _put_text(root, node_name, text):
	var node = _find(root, node_name)
	if node is RichTextLabel:
		node.bbcode_enabled = true
		node.bbcode_text = text
	elif node is Label or node is Button:
		node.text = text


func _put_range(root, node_name, max_value, value):
	var node = _find(root, node_name)
	if node is Range:
		node.min_value = 0
		node.max_value = max(1, max_value)
		node.value = value


func _show(root, node_name, shown):
	var node = _find(root, node_name)
	if node is CanvasItem:
		node.visible = shown


func _header(node, text):
	var color = node.get_meta("header_color") if node.has_meta("header_color") else ""
	if color == "" or !(node is RichTextLabel):
		return text
	return "[color=%s]%s[/color]" % [color, text]


func _bullets(node, lines):
	var bullet = node.get_meta("bullet") if node.has_meta("bullet") else ""
	var text = ""
	for line in lines:
		if text != "":
			text += "\n"
		text += bullet + line
	return text
