extends Node

const MAX_ISSUES_IN_SUMMARY = 200
const TRANSLATE_TAGS = [
	"master_translate",
	"active_character_translate",
	"scene_character_translate",
	"few_scene_characters_translate",
]

var _bracket_variable_regex = null

var dialogue_builtin_codes = {
	"close": true,
	"leave": true,
	"fight_skirmish": true,
	"continue": true,
	"recruit": true,
	"recruit_from_scene": true,
	"cancel_skill_usage": true,
	"repeat": true,
	"add_to_captured": true,
	"capture_from_scene": true,
	"capture": true,
	"create_location_recruit": true,
	"execute": true,
	"inspect_active_character": true,
	"inspect_character_child": true,
	"keepbaby": true,
	"removebaby": true,
	"open_chest": true,
	"good_event": true,
	"evil_event": true,
	"quest_fight": true,
	"quest_fight_duel": true,
}

var common_effect_codes = {
	"money_change": true,
	"material_change": true,
	"make_story_character": true,
	"add_timed_event": true,
	"remove_timed_events": true,
	"unique_character_changes": true,
	"start_event": true,
	"spend_money_for_scene_character": true,
	"bool_scene_characters": true,
	"affect_scene_characters": true,
	"real_affect_scene_characters": true,
	"affect_one_scene_character": true,
	"change_type_scene_characters": true,
	"active_character_switch": true,
	"affect_active_character": true,
	"affect_master": true,
	"make_loot": true,
	"open_loot": true,
	"make_scene_character": true,
	"update_guild": true,
	"update_city": true,
	"update_party": true,
	"update_prts": true,
	"rewrite_save": true,
	"background_noise": true,
	"update_location": true,
	"advance_location": true,
	"open_location": true,
	"open_city": true,
	"create_character": true,
	"progress_quest": true,
	"complete_quest": true,
	"complete_active_location": true,
	"set_completed_active_location": true,
	"remove_active_location": true,
	"reputation": true,
	"decision": true,
	"remove_decision": true,
	"screen_black_transition": true,
	"screen_shake": true,
	"start_combat": true,
	"start_quest_combat": true,
	"make_quest_location": true,
	"remove_quest_location": true,
	"return_characters_from_location": true,
	"set_music": true,
	"play_sound": true,
	"lose_game": true,
	"complete_active_location_quests": true,
	"affect_active_party": true,
	"affect_unique_character": true,
	"progress_active_location": true,
	"dialogue_counter": true,
	"unlock_class": true,
	"reset_day_count": true,
	"teleport_active_character": true,
	"teleport_active_location": true,
	"teleport_active_location_all": true,
	"teleport_location": true,
	"return_to_mansion": true,
	"update_mansion": true,
	"set_location_param": true,
	"yes_or_no_panel": true,
	"close_guild_window": true,
	"add_item": true,
	"remove_item": true,
	"unlock_asset": true,
	"set_spouse": true,
	"complete_wedding": true,
	"after_wedding_event": true,
	"hide_dialogue": true,
	"plan_mansion_event": true,
	"plan_loc_event": true,
	"add_special_task_for_location": true,
	"remove_special_task_for_location": true,
	"add_hireling_to_location": true,
	"finish_worktask": true,
	"pay_loan": true,
	"election_finish": true,
	"plan_loan_event": true,
	"add_master_points": true,
	"pay_stamina": true,
	"add_stamina": true,
	"clear_subroom": true,
	"unlock_subroom": true,
	"unlock_combat": true,
	"deny_combat": true,
	"add_subroom_res": true,
	"reveal_active_dungeon": true,
	"alter_combat": true,
	"unlock_upgrade": true,
	"change_relationship": true,
	"change_relationship_precise": true,
	"open_arena": true,
	"try_breakdown_scene_characters": true,
	"check_masters_story_fame": true,
	"set_faction_factor": true,
	"achievement": true,
}

var req_types = {
	"no_check": true,
	"false": true,
	"has_money": true,
	"has_loan_money": true,
	"unique_available": true,
	"has_material": true,
	"date": true,
	"hour": true,
	"gamestart": true,
	"has_upgrade": true,
	"area_progress": true,
	"decision": true,
	"has_multiple_decisions": true,
	"quest_completed": true,
	"has_items": true,
	"has_free_items": true,
	"disabled": true,
	"has_spouse": true,
	"master_check": true,
	"spouse_check": true,
	"spouse_has_event": true,
	"active_character_checks": true,
	"scene_character_checks": true,
	"unique_character_checks": true,
	"master_is_beast": true,
	"unique_character_at_mansion": true,
	"has_money_for_scene_slave": true,
	"random": true,
	"dialogue_seen": true,
	"dialogue_selected": true,
	"event_seen": true,
	"real_date_range": true,
	"active_quest_stage": true,
	"any_quest_stage": true,
	"has_active_quest": true,
	"faction_reputation": true,
	"group_size": true,
	"location_exists": true,
	"location_has_specific_slaves": true,
	"class_unlocked": true,
	"timed_option": true,
	"current_guild": true,
	"has_faction_upgrade": true,
	"local_counter": true,
	"master_factor_check": true,
	"sex_filter": true,
	"has_stamina": true,
	"location_party_check": true,
	"location_chars_check": true,
	"update_prts": true,
	"captured_number": true,
	"difficulty": true,
	"capital_closed": true,
	"global_settings": true,
	"or_list": true,
	"has_item_with_tag": true,
}


func validate_events(print_to_output := true):
	var issues = []
	_validate_quests(issues)
	_validate_scenedata(issues)
	_validate_comic_events(issues)
	_validate_worlddata(issues)
	var summary = _format_summary(issues)
	if print_to_output:
		print(summary)
		for issue in issues:
			push_warning(issue)
	return summary


func _validate_scenedata(issues):
	for event_id in scenedata.scenedict:
		var event = scenedata.scenedict[event_id]
		if !(event is Dictionary):
			_add_issue(issues, "Event '%s' is not a Dictionary." % str(event_id))
			continue
		_validate_event(event_id, event, issues)


func _validate_quests(issues):
	for quest_id in scenedata.quests:
		var quest = scenedata.quests[quest_id]
		var context = "quest '%s'" % str(quest_id)
		if !(quest is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if quest.has("code") and quest.code != quest_id:
			_add_issue(issues, "%s has mismatched code '%s'." % [context, str(quest.code)])
		if !quest.has("stages") or !(quest.stages is Dictionary):
			_add_issue(issues, "%s has no stages Dictionary." % context)
			continue
		if quest.stages.empty():
			_add_issue(issues, "%s has no stages." % context)
		for stage_id in quest.stages:
			var stage = quest.stages[stage_id]
			var stage_context = "%s.stage '%s'" % [context, str(stage_id)]
			if !(stage is Dictionary):
				_add_issue(issues, "%s is not a Dictionary." % stage_context)
				continue
			if !stage.has("name"):
				_add_issue(issues, "%s has no name." % stage_context)
			if !stage.has("descript"):
				_add_issue(issues, "%s has no descript." % stage_context)


func _validate_comic_events(issues):
	for comic_id in scenedata.comic_events:
		_validate_comic_node(scenedata.comic_events[comic_id], "comic_event '%s'" % str(comic_id), issues)


func _validate_comic_node(value, context, issues):
	if value is Array:
		for idx in range(value.size()):
			_validate_comic_node(value[idx], "%s[%d]" % [context, idx], issues)
	elif value is Dictionary:
		if !value.has("type"):
			return
		match value.type:
			"frame":
				if !value.has("image"):
					_add_issue(issues, "%s frame has no image." % context)
				else:
					_validate_direct_resource_path(value.image, context + ".image", "comic frame image", issues)
			"sound":
				_validate_sound_ref(value.get("value", null), context + ".value", issues)
			"play_noise":
				_validate_background_noise_ref(value.get("sound", null), context + ".sound", issues)


func _validate_direct_resource_path(path, context, label, issues):
	if path == null or path == "":
		return
	if !(path is String):
		_add_issue(issues, "%s uses non-string %s path '%s'." % [context, label, str(path)])
		return
	if !ResourceLoader.exists(path):
		_add_issue(issues, "%s references missing %s path: %s." % [context, label, path])


func _validate_event(event_id, event, issues):
	var context = "event '%s'" % str(event_id)
	_validate_event_assets(event, context, issues)
	_validate_event_text_translation(event, context, issues)
	if event.has("reqs"):
		_validate_reqs(event.reqs, context + ".reqs", issues)
	if event.has("common_effects"):
		_validate_effects(event.common_effects, context + ".common_effects", issues)
	if event.has("bonus_effects"):
		_validate_effects(event.bonus_effects, context + ".bonus_effects", issues)
	if event.has("text") and event.text is Array:
		for idx in range(event.text.size()):
			var line = event.text[idx]
			if !(line is Dictionary):
				continue
			if line.has("reqs"):
				_validate_reqs(line.reqs, "%s.text[%d].reqs" % [context, idx], issues)
			if line.has("bonus_effects"):
				_validate_effects(line.bonus_effects, "%s.text[%d].bonus_effects" % [context, idx], issues)
	if event.has("options"):
		if !(event.options is Array):
			_add_issue(issues, "%s.options is not an Array." % context)
		else:
			for idx in range(event.options.size()):
				var option = event.options[idx]
				if !(option is Dictionary):
					_add_issue(issues, "%s.options[%d] is not a Dictionary." % [context, idx])
					continue
				_validate_option_text_translation(event, option, "%s.options[%d]" % [context, idx], issues)
				_validate_option(event_id, option, idx, issues)


func _validate_event_text_translation(event, context, issues):
	var has_translate_tag = _has_translate_tag(event)
	if !event.has("text"):
		return
	if event.text is String:
		_validate_text_value_translation(event.text, context + ".text", has_translate_tag, issues)
	elif event.text is Array:
		for idx in range(event.text.size()):
			var line = event.text[idx]
			if line is Dictionary and line.has("text"):
				_validate_text_value_translation(line.text, "%s.text[%d].text" % [context, idx], has_translate_tag, issues)
			elif line is String:
				_validate_text_value_translation(line, "%s.text[%d]" % [context, idx], has_translate_tag, issues)


func _validate_option_text_translation(event, option, context, issues):
	if !option.has("text"):
		return
	var has_translate_tag = _has_option_translate_tag(event, option)
	_validate_text_value_translation(option.text, context + ".text", has_translate_tag, issues)


func _validate_text_value_translation(text_value, context, has_translate_tag, issues):
	if !(text_value is String):
		return
	var variable = _find_character_text_variable(text_value)
	if variable == "":
		var translated_text = tr(text_value)
		if translated_text != text_value:
			variable = _find_character_text_variable(translated_text)
	if variable != "" and !has_translate_tag:
		_add_issue(issues, "%s contains character variable %s but has no translate tag." % [context, variable])


func _has_option_translate_tag(event, option):
	if _has_translate_tag(option):
		return true
	# The option renderer applies this event tag to option text with numbered scene-character variables.
	return _has_tag(event, "few_scene_characters_translate")


func _has_translate_tag(value):
	if !(value is Dictionary):
		return false
	for tag in TRANSLATE_TAGS:
		if _has_tag(value, tag):
			return true
	for tag in ["master_translate", "active_char_translate"]:
		if value.has(tag) and value[tag]:
			return true
	return false


func _has_tag(value, tag):
	return value.has("tags") and value.tags is Array and value.tags.has(tag)


func _find_character_text_variable(text):
	var regex = _get_bracket_variable_regex()
	for result in regex.search_all(text):
		var variable_name = result.get_string("variable")
		if variables.text_pronouns.has(variable_name):
			return result.get_string()
	return ""


func _get_bracket_variable_regex():
	if _bracket_variable_regex == null:
		_bracket_variable_regex = RegEx.new()
		_bracket_variable_regex.compile("\\[(?<variable>[A-Za-z_]+)([0-9]*)\\]")
	return _bracket_variable_regex


func _validate_option(event_id, option, idx, issues):
	var context = "event '%s'.options[%d]" % [str(event_id), idx]
	if !option.has("reqs"):
		_add_issue(issues, "%s has no reqs Array." % context)
	else:
		_validate_reqs(option.reqs, context + ".reqs", issues)
	if option.has("bonus_effects"):
		_validate_effects(option.bonus_effects, context + ".bonus_effects", issues)
	if option.has("code") and option.code in ["quest_fight", "quest_fight_duel"]:
		_validate_encounter_ref(option.get("args", null), context, issues)
	elif option.has("type") and option.type == "next_dialogue":
		if !option.has("code"):
			_add_issue(issues, "%s is next_dialogue but has no code." % context)
		elif !dialogue_builtin_codes.has(option.code) and !scenedata.scenedict.has(option.code):
			_add_issue(issues, "%s points to missing event '%s'." % [context, str(option.code)])


func _validate_effects(effects, context, issues):
	if !(effects is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(effects.size()):
		var effect = effects[idx]
		if !(effect is Dictionary):
			_add_issue(issues, "%s[%d] is not a Dictionary." % [context, idx])
			continue
		if !effect.has("code"):
			_add_issue(issues, "%s[%d] has no code." % [context, idx])
			continue
		if !common_effect_codes.has(effect.code):
			_add_issue(issues, "%s[%d] has unknown effect code '%s'." % [context, idx, str(effect.code)])
			continue
		_validate_effect_reference(effect, "%s[%d]" % [context, idx], issues)


func _validate_effect_reference(effect, context, issues):
	match effect.code:
		"start_event":
			if effect.has("data") and !scenedata.scenedict.has(effect.data):
				_add_issue(issues, "%s starts missing event '%s'." % [context, str(effect.data)])
		"add_timed_event":
			if !_effect_uses_action_to_date(effect) and effect.has("value") and effect.value is String and !scenedata.scenedict.has(effect.value):
				_add_issue(issues, "%s schedules missing timed event '%s'." % [context, str(effect.value)])
		"background_noise":
			if effect.get("value", "") == "start":
				_validate_background_noise_ref(effect.get("sound", null), context + ".sound", issues)
		"plan_mansion_event":
			if effect.has("value") and !scenedata.scenedict.has(effect.value):
				_add_issue(issues, "%s plans missing mansion event '%s'." % [context, str(effect.value)])
		"plan_loc_event":
			if effect.has("event") and !scenedata.scenedict.has(effect.event):
				_add_issue(issues, "%s plans missing location event '%s'." % [context, str(effect.event)])
		"progress_quest":
			_validate_quest_stage_ref(effect.get("value", null), effect.get("stage", null), context, issues)
		"complete_quest":
			if effect.has("value") and !scenedata.quests.has(effect.value):
				_add_issue(issues, "%s completes missing quest '%s'." % [context, str(effect.value)])
		"start_quest_combat":
			_validate_encounter_ref(effect.get("value", null), context, issues)
		"set_music":
			_validate_music_ref(effect.get("value", null), context + ".value", issues)
		"play_sound":
			_validate_sound_ref(effect.get("value", null), context + ".value", issues)
		"make_quest_location":
			_validate_quest_location_ref(effect.get("value", null), context + ".value", issues)
		"remove_quest_location":
			_validate_known_location_ref(effect.get("value", null), context + ".value", issues)
		"open_location":
			_validate_known_location_ref(effect.get("location", null), context + ".location", issues)
		"add_special_task_for_location":
			_validate_special_task_effect(effect, context, issues)
		"remove_special_task_for_location":
			_validate_remove_special_task_effect(effect, context, issues)


func _validate_event_assets(event, context, issues):
	if event.has("image"):
		_validate_scene_image_ref(event.image, context + ".image", issues)
	if event.has("custom_background"):
		_validate_background_ref(event.custom_background, context + ".custom_background", issues)
	if event.has("music"):
		_validate_music_ref(event.music, context + ".music", issues)


func _validate_encounter_ref(encounter_id, context, issues):
	if encounter_id == null:
		_add_issue(issues, "%s starts quest_fight but has no encounter id." % context)
		return
	if !(encounter_id is String):
		_add_issue(issues, "%s starts quest_fight with non-string encounter id '%s'." % [context, str(encounter_id)])
		return
	if !Enemydata.encounters.has(encounter_id):
		_add_issue(issues, "%s starts missing encounter '%s'." % [context, str(encounter_id)])
		return
	var encounter = Enemydata.encounters[encounter_id]
	if encounter.has("bg") and encounter.bg != "default":
		_validate_background_ref(encounter.bg, "%s encounter '%s'.bg" % [context, str(encounter_id)], issues)
	if encounter.has("bgm") and encounter.bgm != "default":
		_validate_music_ref(encounter.bgm, "%s encounter '%s'.bgm" % [context, str(encounter_id)], issues)
	if encounter.has("win_effects"):
		_validate_effects(encounter.win_effects, "%s encounter '%s'.win_effects" % [context, str(encounter_id)], issues)
	if encounter.has("lose_effects"):
		_validate_effects(encounter.lose_effects, "%s encounter '%s'.lose_effects" % [context, str(encounter_id)], issues)


func _validate_scene_image_ref(image_id, context, issues):
	if image_id == null or image_id == "":
		return
	if !(image_id is String):
		_add_issue(issues, "%s uses non-string scene image id '%s'." % [context, str(image_id)])
		return
	if !images.scenes.has(image_id):
		_add_issue(issues, "%s references missing scene image '%s'." % [context, str(image_id)])
		return
	_validate_resource_value(images.scenes[image_id], context, "scene image '%s'" % str(image_id), issues)


func _validate_background_ref(background_id, context, issues):
	if background_id == null or background_id == "":
		return
	if !(background_id is String):
		_add_issue(issues, "%s uses non-string background id '%s'." % [context, str(background_id)])
		return
	if !images.backgrounds.has(background_id):
		_add_issue(issues, "%s references missing background '%s'." % [context, str(background_id)])
		return
	_validate_resource_value(images.backgrounds[background_id], context, "background '%s'" % str(background_id), issues)


func _validate_music_ref(music_id, context, issues):
	if music_id == null or music_id == "":
		return
	if !(music_id is String):
		_add_issue(issues, "%s uses non-string music id '%s'." % [context, str(music_id)])
		return
	if music_id == "stop":
		return
	if !audio.music.has(music_id):
		_add_issue(issues, "%s references missing music '%s'." % [context, str(music_id)])
		return
	_validate_resource_value(audio.music[music_id], context, "music '%s'" % str(music_id), issues)


func _validate_sound_ref(sound_id, context, issues):
	if sound_id == null or sound_id == "":
		return
	if !(sound_id is String):
		_add_issue(issues, "%s uses non-string sound id '%s'." % [context, str(sound_id)])
		return
	if !audio.sounds.has(sound_id):
		_add_issue(issues, "%s references missing sound '%s'." % [context, str(sound_id)])
		return
	_validate_resource_value(audio.sounds[sound_id], context, "sound '%s'" % str(sound_id), issues)


func _validate_background_noise_ref(sound_id, context, issues):
	if sound_id == null or sound_id == "":
		return
	if !(sound_id is String):
		_add_issue(issues, "%s uses non-string background noise id '%s'." % [context, str(sound_id)])
		return
	if !audio.background_noise.has(sound_id):
		_add_issue(issues, "%s references missing background noise '%s'." % [context, str(sound_id)])
		return
	_validate_resource_value(audio.background_noise[sound_id], context, "background noise '%s'" % str(sound_id), issues)


func _validate_resource_value(value, context, label, issues):
	if value == null:
		_add_issue(issues, "%s references %s but its resource is null." % [context, label])
	elif value is String and !ResourceLoader.exists(value):
		_add_issue(issues, "%s references %s but resource path does not exist: %s." % [context, label, value])


func _validate_quest_location_ref(location_id, context, issues):
	if location_id == null:
		_add_issue(issues, "%s has no quest location id." % context)
		return
	if !(location_id is String):
		_add_issue(issues, "%s uses non-string quest location id '%s'." % [context, str(location_id)])
		return
	if !DungeonData.dungeons.has(location_id):
		_add_issue(issues, "%s references missing quest location template '%s'." % [context, str(location_id)])


func _validate_known_location_ref(location_id, context, issues):
	if location_id == null or location_id == "":
		return
	if !(location_id is String):
		_add_issue(issues, "%s uses non-string location id '%s'." % [context, str(location_id)])
		return
	if !_is_known_location_id(location_id):
		_add_issue(issues, "%s references unknown location '%s'." % [context, str(location_id)])


func _is_known_location_id(location_id):
	if DungeonData.dungeons.has(location_id):
		return true
	var location_id_lower = location_id.to_lower()
	for dungeon_id in DungeonData.dungeons:
		if str(dungeon_id).to_lower() == location_id_lower:
			return true
		var dungeon = DungeonData.dungeons[dungeon_id]
		if dungeon is Dictionary and dungeon.has("code") and str(dungeon.code).to_lower() == location_id_lower:
			return true
	if worlddata.get("lands") != null:
		for area_id in worlddata.lands:
			var area = worlddata.lands[area_id]
			if area.has("capital_code") and str(area.capital_code).to_lower() == location_id_lower:
				return true
			if area.has("start_settlements_number") and area.start_settlements_number.has(location_id):
				return true
			if area.has("start_settlements_number"):
				for settlement_id in area.start_settlements_number:
					if str(settlement_id).to_lower() == location_id_lower:
						return true
			for list_key in ["starting_locations", "locationpool"]:
				if area.has(list_key) and area[list_key].has(location_id):
					return true
				if area.has(list_key):
					for loc in area[list_key]:
						if str(loc).to_lower() == location_id_lower:
							return true
	return false


func _validate_special_task_effect(effect, context, issues):
	if !effect.has("location"):
		_add_issue(issues, "%s adds special task without location." % context)
	else:
		_validate_known_location_ref(effect.location, context + ".location", issues)
	if effect.has("template") and !tasks.tasklist.has(effect.template):
		_add_issue(issues, "%s references missing task template '%s'." % [context, str(effect.template)])
	if effect.has("amount") and (!_is_number(effect.amount) or effect.amount <= 0):
		_add_issue(issues, "%s has invalid task amount '%s'." % [context, str(effect.amount)])
	if effect.has("max_workers") and (!_is_number(effect.max_workers) or effect.max_workers <= 0):
		_add_issue(issues, "%s has invalid max_workers '%s'." % [context, str(effect.max_workers)])
	if effect.has("icon"):
		_validate_direct_resource_path(effect.icon, context + ".icon", "task icon", issues)
	if effect.has("args"):
		_validate_effects(effect.args, context + ".args", issues)
	else:
		_add_issue(issues, "%s adds special task without completion args." % context)


func _validate_remove_special_task_effect(effect, context, issues):
	if !effect.has("location"):
		_add_issue(issues, "%s removes special task without location." % context)
	else:
		_validate_known_location_ref(effect.location, context + ".location", issues)
	if effect.has("event") and !scenedata.scenedict.has(effect.event):
		_add_issue(issues, "%s removes special task for missing event '%s'." % [context, str(effect.event)])


func _is_number(value):
	return typeof(value) == TYPE_INT or typeof(value) == TYPE_REAL


func _effect_uses_action_to_date(effect):
	if !effect.has("args") or !(effect.args is Array):
		return false
	for arg in effect.args:
		if arg is Dictionary and arg.get("type", "") == "action_to_date":
			return true
	return false


func _validate_reqs(reqs, context, issues):
	if !(reqs is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(reqs.size()):
		var req = reqs[idx]
		if !(req is Dictionary):
			_add_issue(issues, "%s[%d] is not a Dictionary." % [context, idx])
			continue
		if !req.has("type"):
			continue
		if !req_types.has(req.type):
			_add_issue(issues, "%s[%d] has unknown req type '%s'." % [context, idx, str(req.type)])
			continue
		_validate_req_reference(req, "%s[%d]" % [context, idx], issues)


func _validate_req_reference(req, context, issues):
	match req.type:
		"active_quest_stage":
			_validate_quest_stage_ref(req.get("value", null), req.get("stage", null), context, issues)
		"any_quest_stage":
			if !scenedata.quests.has(req.get("value", null)):
				_add_issue(issues, "%s references missing quest '%s'." % [context, str(req.get("value", null))])
			elif req.has("stages"):
				for stage in req.stages:
					if !scenedata.quests[req.value].stages.has(stage):
						_add_issue(issues, "%s references missing stage '%s' on quest '%s'." % [context, str(stage), str(req.value)])
		"quest_completed":
			if req.has("name") and !scenedata.quests.has(req.name):
				_add_issue(issues, "%s references missing completed quest '%s'." % [context, str(req.name)])
		"has_active_quest":
			if req.has("name") and !scenedata.quests.has(req.name):
				_add_issue(issues, "%s references missing active quest '%s'." % [context, str(req.name)])
		"or_list":
			if req.has("or_list"):
				_validate_reqs(req.or_list, context + ".or_list", issues)


func _validate_quest_stage_ref(quest_id, stage_id, context, issues):
	if quest_id == null:
		_add_issue(issues, "%s references a quest but has no quest id." % context)
		return
	if !scenedata.quests.has(quest_id):
		_add_issue(issues, "%s references missing quest '%s'." % [context, str(quest_id)])
		return
	if stage_id == null:
		return
	if !scenedata.quests[quest_id].stages.has(stage_id):
		_add_issue(issues, "%s references missing stage '%s' on quest '%s'." % [context, str(stage_id), str(quest_id)])


func _validate_worlddata(issues):
	if worlddata.get("fixed_location_events") != null:
		_validate_data_tree(worlddata.fixed_location_events, "worlddata.fixed_location_events", issues)
	if worlddata.get("lands") != null:
		_validate_data_tree(worlddata.lands, "worlddata.lands", issues)
	if worlddata.get("random_dungeon_events") != null:
		_validate_data_tree(worlddata.random_dungeon_events, "worlddata.random_dungeon_events", issues)
	if worlddata.get("infinite_dungeon_events") != null:
		_validate_data_tree(worlddata.infinite_dungeon_events, "worlddata.infinite_dungeon_events", issues)


func _validate_data_tree(value, context, issues):
	if value is Dictionary:
		if value.has("reqs"):
			_validate_reqs(value.reqs, context + ".reqs", issues)
		if value.has("args"):
			_validate_effects(value.args, context + ".args", issues)
		if value.has("event") and value.event is String and !scenedata.scenedict.has(value.event):
			_add_issue(issues, "%s references missing event '%s'." % [context + ".event", str(value.event)])
		for key in value:
			if key in ["reqs", "args"]:
				continue
			_validate_data_tree(value[key], "%s.%s" % [context, str(key)], issues)
	elif value is Array:
		for idx in range(value.size()):
			_validate_data_tree(value[idx], "%s[%d]" % [context, idx], issues)


func _add_issue(issues, text):
	issues.append(text)


func _format_summary(issues):
	var lines = []
	lines.append("Event validation complete: %d issue(s)." % issues.size())
	var limit = min(issues.size(), MAX_ISSUES_IN_SUMMARY)
	for idx in range(limit):
		lines.append("%d. %s" % [idx + 1, issues[idx]])
	if issues.size() > limit:
		lines.append("... %d more issue(s) hidden from console output." % (issues.size() - limit))
	return PoolStringArray(lines).join("\n")
