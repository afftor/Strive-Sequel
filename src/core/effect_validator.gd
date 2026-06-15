extends Node

const MAX_ISSUES_IN_SUMMARY = 200

var effect_types = {
	"simple": true,
	"base": true,
	"static": true,
	"trigger": true,
	"oneshot": true,
	"temp_s": true,
	"temp_global": true,
}

var atomic_types = {
	"damage": true,
	"damage_percent": true,
	"heal": true,
	"mana": true,
	"damage_mana_percent": true,
	"stat": true,
	"stat_add": true,
	"stat_set": true,
	"stat_add_p": true,
	"stat_mul": true,
	"signal": true,
	"event": true,
	"resurrect": true,
	"kill": true,
	"use_combat_skill": true,
	"use_social_skill": true,
	"end_turn": true,
	"transform_into": true,
	"sfx": true,
	"effect": true,
	"remove_effect": true,
	"remove_all_effects": true,
	"teleport": true,
	"set_availability": true,
	"set_as_spouse": true,
	"escape": true,
	"remove_trait": true,
	"add_trait": true,
	"unlock_trait": true,
	"add_sex_trait": true,
	"unlock_sex_trait": true,
	"add_class": true,
	"remove_class": true,
	"set_tutelage": true,
	"add_counter": true,
	"add_tag": true,
	"clone": true,
	"setup_instant": true,
	"make_status_effect": true,
	"dungeon_effect": true,
	"location_effect": true,
	"reset_cooldowns": true,
	"add_combat_log": true,
}

var req_codes = {
	"stat": true,
	"trait": true,
	"has_status": true,
	"tags": true,
	"is_master": true,
	"skill": true,
	"caster": true,
	"target": true,
	"gear_equiped": true,
	"has_relationship": true,
	"location": true,
	"check": true,
	"has_profession": true,
	"global_profession_limit": true,
	"class_unlocked": true,
}

var known_stats = {}
var ignored_skill_ids = {}
var known_sfx_codes = {}
var known_loot_tables = {}


func validate_effects(print_to_output := true):
	known_stats = _build_known_stats()
	ignored_skill_ids = _build_ignored_skill_ids()
	known_sfx_codes = _build_known_sfx_codes()
	known_loot_tables = _build_known_loot_tables()
	var issues = []
	_validate_traits(issues)
	_validate_sex_traits(issues)
	_validate_effect_table(issues)
	_validate_atomic_table(issues)
	_validate_buffs_table(issues)
	_validate_stacks(issues)
	_validate_skill_effect_refs(issues)
	_validate_classes(issues)
	_validate_masteries(issues)
	_validate_enemydata(issues)
	_validate_static_trait_refs(issues)
	_validate_event_trait_and_effect_refs(issues)
	var summary = _format_summary(issues)
	if print_to_output:
		print(summary)
		for issue in issues:
			push_warning(issue)
	return summary


func _validate_traits(issues):
	for trait_id in Traitdata.traits:
		var trait = Traitdata.traits[trait_id]
		var context = "trait '%s'" % str(trait_id)
		if !(trait is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if !trait.has("effects"):
			_add_issue(issues, "%s has no effects array." % context)
		elif !(trait.effects is Array):
			_add_issue(issues, "%s.effects is not an Array." % context)
		else:
			for idx in range(trait.effects.size()):
				_validate_effect_ref(trait.effects[idx], "%s.effects[%d]" % [context, idx], issues)
		if trait.has("bonusstats"):
			_validate_stat_map(trait.bonusstats, context + ".bonusstats", issues)
		if trait.has("reqs"):
			_validate_reqs(trait.reqs, context + ".reqs", issues)
		if trait.has("conflicts"):
			for idx in range(trait.conflicts.size()):
				_validate_trait_ref(trait.conflicts[idx], "%s.conflicts[%d]" % [context, idx], issues)
		if trait.has("icon") and _is_non_empty_string(trait.icon):
			_validate_resource_path(trait.icon, context + ".icon", "trait icon", issues)


func _validate_sex_traits(issues):
	if Traitdata.get("sex_traits") == null:
		return
	for trait_id in Traitdata.sex_traits:
		var trait = Traitdata.sex_traits[trait_id]
		var context = "sex_trait '%s'" % str(trait_id)
		if !(trait is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if trait.has("icon") and _is_non_empty_string(trait.icon):
			_validate_resource_path(trait.icon, context + ".icon", "sex trait icon", issues)
		if trait.has("reqs"):
			_validate_reqs(trait.reqs, context + ".reqs", issues)


func _validate_effect_table(issues):
	for effect_id in Effectdata.effect_table:
		var effect = Effectdata.effect_table[effect_id]
		_validate_effect_template(effect, "effect '%s'" % str(effect_id), issues)


func _validate_effect_template(effect, context, issues):
	if !(effect is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
	if !effect.has("type"):
		_add_issue(issues, "%s has no type." % context)
		return
	if !effect_types.has(effect.type):
		_add_issue(issues, "%s has unknown type '%s'." % [context, str(effect.type)])
	if effect.has("stack") and _effect_uses_named_stack(effect) and !Effectdata.stacks.has(effect.stack):
		_add_issue(issues, "%s references missing stack '%s'." % [context, str(effect.stack)])
	if effect.has("statchanges"):
		_validate_stat_map(effect.statchanges, context + ".statchanges", issues)
	if effect.has("conditions"):
		_validate_reqs(effect.conditions, context + ".conditions", issues)
	if effect.has("reqs"):
		_validate_reqs(effect.reqs, context + ".reqs", issues)
	if effect.has("buffs"):
		_validate_buff_list(effect.buffs, context + ".buffs", issues)
	if effect.has("sub_effects"):
		_validate_sub_effects(effect.sub_effects, context + ".sub_effects", issues)
	if effect.has("modal_sub_effects"):
		_validate_sub_effects(effect.modal_sub_effects, context + ".modal_sub_effects", issues)
	if effect.has("atomic"):
		_validate_atomic_list(effect.atomic, context + ".atomic", issues)
	if effect.has("trigger"):
		_validate_event_list(effect.trigger, context + ".trigger", issues)
	if effect.has("tick_event"):
		_validate_event_list(effect.tick_event, context + ".tick_event", issues)
	if effect.has("rem_event"):
		_validate_event_list(effect.rem_event, context + ".rem_event", issues)
	if effect.has("args"):
		_validate_effect_args(effect.args, context + ".args", issues)
	match effect.get("type", ""):
		"temp_s":
			_validate_temp_simple(effect, context, issues)
		"temp_global":
			_validate_temp_global(effect, context, issues)
		"trigger":
			if !effect.has("trigger") or _is_empty_event_list(effect.trigger):
				_add_issue(issues, "%s trigger effect has no trigger events." % context)


func _validate_sub_effects(sub_effects, context, issues):
	if !(sub_effects is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(sub_effects.size()):
		var sub_effect = sub_effects[idx]
		var sub_context = "%s[%d]" % [context, idx]
		if sub_effect is String:
			_validate_effect_ref(sub_effect, sub_context, issues)
		elif sub_effect is Dictionary:
			_validate_effect_template(sub_effect, sub_context, issues)
		else:
			_add_issue(issues, "%s is neither an effect id nor an effect template." % sub_context)


func _validate_temp_simple(effect, context, issues):
	if effect.has("duration"):
		if !effect.has("tick_event") or _is_empty_event_list(effect.tick_event):
			_add_issue(issues, "%s has duration but no tick_event, so duration will not count down." % context)
		if !(effect.duration is int) and !(effect.duration is String) and !(effect.duration is Array):
			_add_issue(issues, "%s has unsupported duration value '%s'." % [context, str(effect.duration)])
	elif (!effect.has("rem_event") or _is_empty_event_list(effect.rem_event)) and !_has_tag(effect, "duration_none"):
		_add_issue(issues, "%s has no duration, rem_event, or duration_none tag; it may never remove." % context)


func _effect_uses_named_stack(effect):
	if !effect.has("type"):
		return true
	return effect.type in ["base", "trigger", "temp_s"]


func _validate_temp_global(effect, context, issues):
	if !effect.has("timers") or !(effect.timers is Array):
		if !_has_tag(effect, "duration_none"):
			_add_issue(issues, "%s has no timers array; it may never remove." % context)
		return
	if effect.timers.empty() and !_has_tag(effect, "duration_none"):
		_add_issue(issues, "%s has empty timers array; it may never remove." % context)
	for idx in range(effect.timers.size()):
		var timer = effect.timers[idx]
		var timer_context = "%s.timers[%d]" % [context, idx]
		if !(timer is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % timer_context)
			continue
		if !timer.has("events"):
			_add_issue(issues, "%s has no events." % timer_context)
		else:
			_validate_event_list(timer.events, timer_context + ".events", issues)
		if !timer.has("timer"):
			_add_issue(issues, "%s has no timer count." % timer_context)
		elif !_is_number(timer.timer) or timer.timer <= 0:
			_add_issue(issues, "%s has invalid timer count '%s'." % [timer_context, str(timer.timer)])
		if !timer.has("objects"):
			_add_issue(issues, "%s has no objects target." % timer_context)


func _validate_atomic_table(issues):
	for atomic_id in Effectdata.atomic:
		_validate_atomic(Effectdata.atomic[atomic_id], "atomic '%s'" % str(atomic_id), issues)


func _validate_atomic_list(atomics, context, issues):
	if !(atomics is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(atomics.size()):
		var atomic = atomics[idx]
		var atomic_context = "%s[%d]" % [context, idx]
		if atomic is String:
			if !Effectdata.atomic.has(atomic):
				_add_issue(issues, "%s references missing atomic '%s'." % [atomic_context, str(atomic)])
		elif atomic is Dictionary:
			_validate_atomic(atomic, atomic_context, issues)
		else:
			_add_issue(issues, "%s is neither an atomic id nor an atomic template." % atomic_context)


func _validate_atomic(atomic, context, issues):
	if !(atomic is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
	if !atomic.has("type"):
		_add_issue(issues, "%s has no type." % context)
		return
	if !atomic_types.has(atomic.type):
		_add_issue(issues, "%s has unknown atomic type '%s'." % [context, str(atomic.type)])
	if atomic.has("stat"):
		_validate_stat_ref(atomic.stat, context + ".stat", issues)
	match atomic.type:
		"effect":
			_validate_effect_ref(atomic.get("value", null), context + ".value", issues)
		"remove_effect", "remove_all_effects":
			_validate_removable_effect_tag(atomic.get("value", null), context + ".value", issues)
		"add_trait", "remove_trait", "unlock_trait":
			_validate_trait_ref(atomic.get("trait", null), context + ".trait", issues)
		"add_sex_trait", "unlock_sex_trait":
			_validate_sex_trait_ref(atomic.get("trait", null), context + ".trait", issues)
		"use_combat_skill":
			_validate_skill_ref(atomic.get("skill", null), context + ".skill", issues)
		"sfx":
			_validate_sfx_ref(atomic.get("value", null), context + ".value", issues)


func _validate_buffs_table(issues):
	for buff_id in Effectdata.buffs:
		_validate_buff_template(Effectdata.buffs[buff_id], "buff '%s'" % str(buff_id), issues)


func _validate_buff_list(buffs, context, issues):
	if !(buffs is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(buffs.size()):
		var buff = buffs[idx]
		var buff_context = "%s[%d]" % [context, idx]
		if buff is String:
			if !Effectdata.buffs.has(buff):
				_add_issue(issues, "%s references missing buff '%s'." % [buff_context, str(buff)])
		elif buff is Dictionary:
			_validate_buff_template(buff, buff_context, issues)
		else:
			_add_issue(issues, "%s is neither a buff id nor a buff template." % buff_context)


func _validate_buff_template(buff, context, issues):
	if !(buff is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
		if buff.has("icon") and _is_non_empty_string(buff.icon):
			_validate_resource_path(buff.icon, context + ".icon", "buff icon", issues)
	if buff.has("stats"):
		_validate_stat_map(buff.stats, context + ".stats", issues)
	if buff.has("statchanges"):
		_validate_stat_map(buff.statchanges, context + ".statchanges", issues)


func _validate_stacks(issues):
	for stack_id in Effectdata.stacks:
		var stack = Effectdata.stacks[stack_id]
		var context = "stack '%s'" % str(stack_id)
		if !(stack is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if stack.has("buff") and !Effectdata.buffs.has(stack.buff):
			_add_issue(issues, "%s references missing buff '%s'." % [context, str(stack.buff)])


func _validate_skill_effect_refs(issues):
	for skill_id in Skilldata.Skilllist:
		if ignored_skill_ids.has(skill_id):
			continue
		var skill = Skilldata.Skilllist[skill_id]
		var context = "skill '%s'" % str(skill_id)
		if !(skill is Dictionary):
			continue
		if skill.has("effects"):
			for idx in range(skill.effects.size()):
				_validate_skill_effect_entry(skill.effects[idx], "%s.effects[%d]" % [context, idx], issues)
		if skill.has("variations"):
			_validate_skill_variations(skill.variations, context + ".variations", issues)


func _validate_skill_effect_entry(entry, context, issues):
	if entry is String:
		_validate_effect_ref(entry, context, issues)
	elif entry is Dictionary:
		_validate_effect_template(entry, context, issues)
	else:
		_add_issue(issues, "%s is neither an effect id nor an effect template." % context)


func _validate_skill_variations(variations, context, issues):
	if !(variations is Array):
		return
	for idx in range(variations.size()):
		var variation = variations[idx]
		if !(variation is Dictionary):
			continue
		var variation_context = "%s[%d]" % [context, idx]
		if variation.has("reqs"):
			_validate_reqs(variation.reqs, variation_context + ".reqs", issues)
		if variation.has("set") and variation.set is Dictionary and variation.set.has("effects"):
			for e_idx in range(variation.set.effects.size()):
				_validate_skill_effect_entry(variation.set.effects[e_idx], "%s.set.effects[%d]" % [variation_context, e_idx], issues)


func _validate_static_trait_refs(issues):
	_validate_trait_list_container(races.get("racelist"), "races.racelist", "traits", issues)
	_validate_trait_list_container(worlddata.get("pregen_characters"), "worlddata.pregen_characters", "traits", issues)
	if worlddata.get("pregen_characters") != null:
		_validate_trait_list_container(worlddata.pregen_characters, "worlddata.pregen_characters", "sex_traits", issues, true)
	if worlddata.get("lands") != null:
		_validate_data_tree_for_traits(worlddata.lands, "worlddata.lands", issues)


func _validate_classes(issues):
	var professions = classesdata.get("professions")
	if !(professions is Dictionary):
		_add_issue(issues, "classesdata.professions is not a Dictionary.")
		return
	for class_id in professions:
		var prof = professions[class_id]
		var context = "class '%s'" % str(class_id)
		if !(prof is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if prof.has("code") and prof.code != class_id:
			_add_issue(issues, "%s has mismatched code '%s'." % [context, str(prof.code)])
		if prof.has("traits"):
			_validate_trait_list(prof.traits, context + ".traits", issues)
		if prof.has("skills"):
			_validate_skill_list(prof.skills, context + ".skills", issues)
		if prof.has("combatskills"):
			_validate_skill_list(prof.combatskills, context + ".combatskills", issues)
		if prof.has("exploreskills"):
			_validate_skill_list(prof.exploreskills, context + ".exploreskills", issues)
		if prof.has("persistent_effects"):
			_validate_effect_list(prof.persistent_effects, context + ".persistent_effects", issues)
		if prof.has("statchanges"):
			_validate_class_statchanges(prof.statchanges, context + ".statchanges", issues)
		if prof.has("conflict_classes"):
			_validate_profession_list(prof.conflict_classes, context + ".conflict_classes", issues)
		if prof.has("reqs"):
			_validate_reqs(prof.reqs, context + ".reqs", issues)
		if prof.has("showupreqs"):
			_validate_reqs(prof.showupreqs, context + ".showupreqs", issues)
		if prof.has("altnamereqs"):
			_validate_reqs(prof.altnamereqs, context + ".altnamereqs", issues)


func _validate_masteries(issues):
	if !(Skilldata.masteries is Dictionary):
		_add_issue(issues, "Skilldata.masteries is not a Dictionary.")
		return
	for mastery_id in Skilldata.masteries:
		var mastery = Skilldata.masteries[mastery_id]
		var context = "mastery '%s'" % str(mastery_id)
		if !(mastery is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if mastery.has("passive"):
			_validate_stat_map(mastery.passive, context + ".passive", issues)
		for key in mastery:
			if !(key is String) or !key.begins_with("level"):
				continue
			var level = mastery[key]
			var level_context = "%s.%s" % [context, key]
			if !(level is Dictionary):
				_add_issue(issues, "%s is not a Dictionary." % level_context)
				continue
			if level.has("combat_skills"):
				_validate_skill_list(level.combat_skills, level_context + ".combat_skills", issues)
			if level.has("explore_skills"):
				_validate_skill_list(level.explore_skills, level_context + ".explore_skills", issues)
			if level.has("traits"):
				_validate_trait_list(level.traits, level_context + ".traits", issues)


func _validate_enemydata(issues):
	_validate_enemies(issues)
	_validate_enemy_groups(issues)
	_validate_predetermined_enemy_groups(issues)
	_validate_enemy_encounters(issues)
	_validate_enemy_summons(issues)


func _validate_enemies(issues):
	if !(Enemydata.enemies is Dictionary):
		_add_issue(issues, "Enemydata.enemies is not a Dictionary.")
		return
	for enemy_id in Enemydata.enemies:
		var enemy = Enemydata.enemies[enemy_id]
		var context = "enemy '%s'" % str(enemy_id)
		if !(enemy is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if enemy.has("skills"):
			_validate_skill_list(enemy.skills, context + ".skills", issues)
		if enemy.has("traits"):
			_validate_trait_list(enemy.traits, context + ".traits", issues)
		if enemy.has("allowed_mastery"):
			_validate_mastery_list(enemy.allowed_mastery, context + ".allowed_mastery", issues)
		if enemy.has("preset_masteries"):
			_validate_mastery_map(enemy.preset_masteries, context + ".preset_masteries", issues)
		if enemy.has("loot"):
			_validate_loot_ref(enemy.loot, context + ".loot", issues)
		if enemy.has("icon") and _is_non_empty_string(enemy.icon):
			_validate_resource_path(enemy.icon, context + ".icon", "enemy icon", issues)


func _validate_enemy_groups(issues):
	if !(Enemydata.enemygroups is Dictionary):
		_add_issue(issues, "Enemydata.enemygroups is not a Dictionary.")
		return
	for group_id in Enemydata.enemygroups:
		var group = Enemydata.enemygroups[group_id]
		var context = "enemy group '%s'" % str(group_id)
		if !(group is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if group.has("units"):
			_validate_enemy_unit_map(group.units, context + ".units", issues)


func _validate_predetermined_enemy_groups(issues):
	if !(Enemydata.predeterminatedgroups is Dictionary):
		_add_issue(issues, "Enemydata.predeterminatedgroups is not a Dictionary.")
		return
	for group_id in Enemydata.predeterminatedgroups:
		var group = Enemydata.predeterminatedgroups[group_id]
		var context = "predetermined enemy group '%s'" % str(group_id)
		if !(group is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if group.has("group"):
			_validate_enemy_refs_in_value(group.group, context + ".group", issues)


func _validate_enemy_encounters(issues):
	if !(Enemydata.encounters is Dictionary):
		_add_issue(issues, "Enemydata.encounters is not a Dictionary.")
		return
	for encounter_id in Enemydata.encounters:
		var encounter = Enemydata.encounters[encounter_id]
		var context = "enemy encounter '%s'" % str(encounter_id)
		if !(encounter is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if encounter.get("unittype", "") == "randomgroup":
			_validate_enemy_group_ref(encounter.get("unitcode", null), context + ".unitcode", issues)


func _validate_enemy_summons(issues):
	if !(Enemydata.summons is Dictionary):
		_add_issue(issues, "Enemydata.summons is not a Dictionary.")
		return
	for summon_id in Enemydata.summons:
		var summon = Enemydata.summons[summon_id]
		var context = "enemy summon '%s'" % str(summon_id)
		if !(summon is Dictionary):
			_add_issue(issues, "%s is not a Dictionary." % context)
			continue
		if summon.has("summon"):
			_validate_enemy_refs_in_value(summon.summon, context + ".summon", issues, true)


func _validate_trait_list_container(container, context, key, issues, sex_trait := false):
	if container == null:
		return
	if container is Dictionary:
		for id in container:
			var value = container[id]
			if value is Dictionary and value.has(key):
				_validate_trait_list(value[key], "%s.%s.%s" % [context, str(id), key], issues, sex_trait)
	elif container is Array:
		for idx in range(container.size()):
			var value = container[idx]
			if value is Dictionary and value.has(key):
				_validate_trait_list(value[key], "%s[%d].%s" % [context, idx, key], issues, sex_trait)


func _validate_trait_list(list, context, issues, sex_trait := false):
	if !(list is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(list.size()):
		if sex_trait:
			_validate_sex_trait_ref(list[idx], "%s[%d]" % [context, idx], issues)
		else:
			_validate_trait_ref(list[idx], "%s[%d]" % [context, idx], issues)


func _validate_event_trait_and_effect_refs(issues):
	_validate_data_tree_for_traits(scenedata.scenedict, "scenedata.scenedict", issues)
	_validate_data_tree_for_traits(scenedata.quests, "scenedata.quests", issues)


func _validate_data_tree_for_traits(value, context, issues):
	if value is Dictionary:
		if _dict_string_equals(value, "code", "trait") and value.has("trait"):
			_validate_trait_ref(value.trait, context + ".trait", issues)
		if _dict_string_in(value, "code", ["add_trait", "remove_trait", "unlock_trait"]):
			_validate_trait_ref(value.get("trait", null), context + ".trait", issues)
		if _dict_string_in(value, "type", ["add_trait", "remove_trait", "unlock_trait"]):
			_validate_trait_ref(value.get("trait", null), context + ".trait", issues)
		if _dict_string_equals(value, "code", "sextrait"):
			_validate_sex_trait_ref(value.get("value", null), context + ".value", issues)
		if _dict_string_in(value, "type", ["effect", "remove_effect", "remove_all_effects"]):
			_validate_character_effect_ref(value, context, issues)
		if _dict_string_in(value, "code", ["affect_active_character", "affect_master", "affect_one_scene_character", "affect_scene_characters", "real_affect_scene_characters"]):
			_validate_character_effect_ref(value, context, issues)
		if value.has("args"):
			_validate_data_tree_for_traits(value.args, context + ".args", issues)
		if value.has("bonus_effects"):
			_validate_data_tree_for_traits(value.bonus_effects, context + ".bonus_effects", issues)
		if value.has("common_effects"):
			_validate_data_tree_for_traits(value.common_effects, context + ".common_effects", issues)
		if value.has("reqs"):
			_validate_reqs(value.reqs, context + ".reqs", issues)
		for key in value:
			if key in ["args", "bonus_effects", "common_effects", "reqs"]:
				continue
			_validate_data_tree_for_traits(value[key], "%s.%s" % [context, str(key)], issues)
	elif value is Array:
		for idx in range(value.size()):
			_validate_data_tree_for_traits(value[idx], "%s[%d]" % [context, idx], issues)


func _validate_character_effect_ref(value, context, issues):
	if !value.has("type"):
		return
	match value.type:
		"effect":
			_validate_effect_ref(value.get("value", null), context + ".value", issues)
		"remove_effect", "remove_all_effects":
			_validate_removable_effect_tag(value.get("value", null), context + ".value", issues)
		"stat", "stat_add", "stat_set", "stat_add_p", "stat_mul":
			_validate_stat_ref(value.get("stat", null), context + ".stat", issues)


func _validate_effect_ref(effect_id, context, issues):
	if _is_empty_id(effect_id):
		_add_issue(issues, "%s references empty effect id." % context)
		return
	if !(effect_id is String):
		_add_issue(issues, "%s uses non-string effect id '%s'." % [context, str(effect_id)])
		return
	var resolved = Effectdata.get_effect_for_status(effect_id)
	if !Effectdata.effect_table.has(resolved):
		_add_issue(issues, "%s references missing effect '%s'." % [context, str(effect_id)])


func _validate_removable_effect_tag(effect_id, context, issues):
	if _is_empty_id(effect_id):
		_add_issue(issues, "%s references empty removable effect/status." % context)
		return
	if !(effect_id is String):
		_add_issue(issues, "%s uses non-string removable effect/status '%s'." % [context, str(effect_id)])
		return
	if Effectdata.effect_table.has(effect_id):
		return
	var resolved = Effectdata.get_effect_for_status(effect_id)
	if Effectdata.effect_table.has(resolved):
		return
	if !_tag_exists_on_any_effect(effect_id):
		_add_issue(issues, "%s removes unknown effect/status tag '%s'." % [context, str(effect_id)])


func _validate_status_ref(status, context, issues):
	if _is_empty_id(status):
		_add_issue(issues, "%s references empty status." % context)
		return
	if !(status is String):
		_add_issue(issues, "%s uses non-string status '%s'." % [context, str(status)])
		return
	if Effectdata.effect_table.has(status):
		return
	var resolved = Effectdata.get_effect_for_status(status)
	if Effectdata.effect_table.has(resolved):
		return
	if _tag_exists_on_any_effect(status) or _tag_exists_on_any_trait(status):
		return
	_add_issue(issues, "%s references unknown status '%s'." % [context, str(status)])


func _tag_exists_on_any_effect(tag):
	for effect_id in Effectdata.effect_table:
		var effect = Effectdata.effect_table[effect_id]
		if effect is Dictionary and effect.has("tags") and effect.tags.has(tag):
			return true
	return false


func _tag_exists_on_any_trait(tag):
	for trait_id in Traitdata.traits:
		var trait = Traitdata.traits[trait_id]
		if trait is Dictionary and trait.has("tags") and trait.tags.has(tag):
			return true
	for trait_id in Traitdata.sex_traits:
		var trait = Traitdata.sex_traits[trait_id]
		if trait is Dictionary and trait.has("tags") and trait.tags.has(tag):
			return true
	return false


func _validate_trait_ref(trait_id, context, issues):
	if _is_empty_id(trait_id):
		_add_issue(issues, "%s references empty trait id." % context)
		return
	if !(trait_id is String):
		_add_issue(issues, "%s uses non-string trait id '%s'." % [context, str(trait_id)])
		return
	if !Traitdata.traits.has(trait_id):
		_add_issue(issues, "%s references missing trait '%s'." % [context, str(trait_id)])


func _validate_trait_or_sex_trait_ref(trait_id, context, issues):
	if _is_empty_id(trait_id):
		_add_issue(issues, "%s references empty trait id." % context)
		return
	if !(trait_id is String):
		_add_issue(issues, "%s uses non-string trait id '%s'." % [context, str(trait_id)])
		return
	if Traitdata.traits.has(trait_id) or Traitdata.sex_traits.has(trait_id) or _tag_exists_on_any_trait(trait_id):
		return
	_add_issue(issues, "%s references missing trait, sex trait, or trait tag '%s'." % [context, str(trait_id)])


func _validate_sex_trait_ref(trait_id, context, issues):
	if _is_empty_id(trait_id):
		_add_issue(issues, "%s references empty sex trait id." % context)
		return
	if !(trait_id is String):
		_add_issue(issues, "%s uses non-string sex trait id '%s'." % [context, str(trait_id)])
		return
	if !Traitdata.sex_traits.has(trait_id):
		_add_issue(issues, "%s references missing sex trait '%s'." % [context, str(trait_id)])


func _validate_skill_ref(skill_id, context, issues):
	if skill_id == null:
		return
	if skill_id is Array:
		for idx in range(skill_id.size()):
			_validate_skill_ref(skill_id[idx], "%s[%d]" % [context, idx], issues)
		return
	if !(skill_id is String):
		return
	if !Skilldata.Skilllist.has(skill_id):
		_add_issue(issues, "%s references missing skill '%s'." % [context, str(skill_id)])


func _validate_skill_list(list, context, issues):
	if !(list is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(list.size()):
		_validate_skill_ref(list[idx], "%s[%d]" % [context, idx], issues)


func _validate_effect_list(list, context, issues):
	if !(list is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(list.size()):
		_validate_effect_ref(list[idx], "%s[%d]" % [context, idx], issues)


func _validate_profession_ref(profession_id, context, issues):
	if _is_empty_id(profession_id):
		_add_issue(issues, "%s references empty class/profession id." % context)
		return
	if !(profession_id is String):
		_add_issue(issues, "%s uses non-string class/profession id '%s'." % [context, str(profession_id)])
		return
	if !classesdata.professions.has(profession_id):
		_add_issue(issues, "%s references missing class/profession '%s'." % [context, str(profession_id)])


func _validate_profession_list(list, context, issues):
	if !(list is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(list.size()):
		_validate_profession_ref(list[idx], "%s[%d]" % [context, idx], issues)


func _validate_class_statchanges(statchanges, context, issues):
	if !(statchanges is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
	for stat in statchanges:
		if stat == "disabled_masteries" or stat == "enabled_masteries":
			_validate_mastery_list(statchanges[stat], "%s.%s" % [context, str(stat)], issues)
		else:
			_validate_stat_ref(stat, "%s.%s" % [context, str(stat)], issues)


func _validate_mastery_ref(mastery_id, context, issues):
	if _is_empty_id(mastery_id):
		_add_issue(issues, "%s references empty mastery id." % context)
		return
	if !(mastery_id is String):
		_add_issue(issues, "%s uses non-string mastery id '%s'." % [context, str(mastery_id)])
		return
	if !Skilldata.masteries.has(mastery_id):
		_add_issue(issues, "%s references missing mastery '%s'." % [context, str(mastery_id)])


func _validate_mastery_list(list, context, issues):
	if !(list is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(list.size()):
		_validate_mastery_ref(list[idx], "%s[%d]" % [context, idx], issues)


func _validate_mastery_map(map, context, issues):
	if !(map is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
	for mastery_id in map:
		_validate_mastery_ref(mastery_id, "%s.%s" % [context, str(mastery_id)], issues)


func _validate_enemy_unit_map(units, context, issues):
	if !(units is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
	for enemy_id in units:
		_validate_enemy_ref(enemy_id, "%s.%s" % [context, str(enemy_id)], issues)


func _validate_enemy_refs_in_value(value, context, issues, allow_null := false):
	if value == null:
		if !allow_null:
			_add_issue(issues, "%s references empty enemy id." % context)
		return
	if value is String:
		_validate_enemy_ref(value, context, issues)
	elif value is Dictionary:
		for key in value:
			_validate_enemy_refs_in_value(value[key], "%s.%s" % [context, str(key)], issues, allow_null)
	elif value is Array:
		for idx in range(value.size()):
			_validate_enemy_refs_in_value(value[idx], "%s[%d]" % [context, idx], issues, allow_null)


func _validate_enemy_ref(enemy_id, context, issues):
	if _is_empty_id(enemy_id):
		_add_issue(issues, "%s references empty enemy id." % context)
		return
	if !(enemy_id is String):
		_add_issue(issues, "%s uses non-string enemy id '%s'." % [context, str(enemy_id)])
		return
	if !_enemy_ref_exists(enemy_id):
		_add_issue(issues, "%s references missing enemy '%s'." % [context, str(enemy_id)])


func _enemy_ref_exists(enemy_id):
	if Enemydata.enemies.has(enemy_id):
		return true
	for suffix in ["_rare", "_miniboss"]:
		if enemy_id.ends_with(suffix):
			var base_id = enemy_id.substr(0, enemy_id.length() - suffix.length())
			if Enemydata.enemies.has(base_id):
				return true
	return false


func _validate_enemy_group_ref(group_id, context, issues):
	if _is_empty_id(group_id):
		_add_issue(issues, "%s references empty enemy group id." % context)
		return
	if !(group_id is String):
		_add_issue(issues, "%s uses non-string enemy group id '%s'." % [context, str(group_id)])
		return
	if Enemydata.enemygroups.has(group_id) or Enemydata.predeterminatedgroups.has(group_id):
		return
	_add_issue(issues, "%s references missing enemy group '%s'." % [context, str(group_id)])


func _validate_loot_ref(loot_id, context, issues):
	if _is_empty_id(loot_id):
		return
	if !(loot_id is String):
		_add_issue(issues, "%s uses non-string loot table id '%s'." % [context, str(loot_id)])
		return
	if !known_loot_tables.has(loot_id):
		_add_issue(issues, "%s references missing loot table '%s'." % [context, str(loot_id)])


func _validate_sfx_ref(sfx_id, context, issues):
	if _is_empty_id(sfx_id):
		_add_issue(issues, "%s references empty sound/sfx id." % context)
		return
	if !(sfx_id is String):
		_add_issue(issues, "%s uses non-string sound/sfx id '%s'." % [context, str(sfx_id)])
		return
	if known_sfx_codes.has(sfx_id):
		return
	_add_issue(issues, "%s references missing sound/sfx '%s'." % [context, str(sfx_id)])


func _validate_reqs(reqs, context, issues):
	if !(reqs is Array):
		_add_issue(issues, "%s is not an Array." % context)
		return
	for idx in range(reqs.size()):
		var req = reqs[idx]
		var req_context = "%s[%d]" % [context, idx]
		if !(req is Dictionary):
			if !(req is Array):
				_add_issue(issues, "%s is not a Dictionary or positional condition Array." % req_context)
			continue
		var code = req.get("code", req.get("type", null))
		if code == null:
			continue
		if !req_codes.has(code):
			continue
		match code:
			"stat":
				_validate_stat_ref(req.get("stat", null), req_context + ".stat", issues)
			"trait":
				_validate_trait_or_sex_trait_ref(req.get("trait", null), req_context + ".trait", issues)
			"has_status":
				_validate_status_ref(req.get("status", null), req_context + ".status", issues)
			"skill":
				if req.has("skill"):
					_validate_skill_ref(req.skill, req_context + ".skill", issues)
			"has_profession", "global_profession_limit":
				if req.has("profession"):
					_validate_profession_ref(req.profession, req_context + ".profession", issues)
			"class_unlocked":
				if req.has("class"):
					_validate_profession_ref(req.class, req_context + ".class", issues)
			"caster", "target":
				if req.has("value"):
					_validate_reqs(req.value, req_context + ".value", issues)


func _validate_stat_map(stats, context, issues):
	if !(stats is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
	for stat in stats:
		_validate_stat_ref(stat, "%s.%s" % [context, str(stat)], issues)


func _validate_stat_ref(stat, context, issues):
	if _is_empty_id(stat):
		_add_issue(issues, "%s references empty stat." % context)
		return
	if !(stat is String):
		return
	if _is_known_stat(stat):
		return
	_add_issue(issues, "%s references unknown stat '%s'." % [context, stat])


func _is_known_stat(stat):
	if known_stats.has(stat):
		return true
	var suffixes = [
		"_set",
		"_add",
		"_add_part",
		"_mul",
		"_bonus",
		"_cap",
		"_max",
		"_mod",
	]
	for suffix in suffixes:
		if stat.ends_with(suffix):
			var base = stat.substr(0, stat.length() - suffix.length())
			if known_stats.has(base):
				return true
	var prefixes = ["mastery_", "mod_", "chg_", "resist_", "damage_mod_", "manacost_mod_", "task_efficiency_", "task_crit_"]
	for prefix in prefixes:
		if stat.begins_with(prefix):
			return true
	return false


func _build_known_stats():
	var stats = {}
	for key in statdata.statdata:
		stats[key] = true
	for source in [
		Statlist_init.template_direct,
		Statlist_init.template_dynamic,
		Statlist_init.sexexp,
		Statlist_init.sex_skills,
		Statlist_init.sex_training,
		Statlist_init.metrics,
		Statlist_init.piercing,
		Statlist_init.armor_color,
		Statlist_init.pregnancy,
		Statlist_init.tattoo,
		Statlist_init.manacost_mods,
		Statlist_init.resists,
		Statlist_init.damage_mods,
		Statlist_init.task_efficiency,
		Statlist_init.task_crit,
	]:
		for key in source:
			stats[key] = true
	for key in ["value", "chance", "repeat", "follow_up", "target", "hit_res", "is_drain", "shield", "shieldtype", "src", "base", "mod", "mod_2", "amount", "index", "combatgroup", "combat_position", "id", "armor_p", "alt_form"]:
		stats[key] = true
	return stats


func _build_ignored_skill_ids():
	var result = {}
	var unused_script = load("res://assets/data/skilldata/unused.gd")
	if unused_script == null:
		return result
	var unused_data = unused_script.new()
	for skill_id in unused_data.skills:
		result[skill_id] = true
	return result


func _build_known_sfx_codes():
	var result = {}
	for sound_id in audio.sounds:
		result[sound_id] = true
	for sfx_id in images.GFX_video:
		result[sfx_id] = true
	for sfx_id in images.GFX_sprites:
		result[sfx_id] = true
	for sfx_id in images.GFX_particles:
		result[sfx_id] = true
	var combat_animations_script = load("res://src/combat/CombatAnimations.gd")
	if combat_animations_script != null:
		var combat_animations = combat_animations_script.new()
		for method in combat_animations.get_method_list():
			result[method.name] = true
	return result


func _build_known_loot_tables():
	var result = {}
	var loot_script = load("res://assets/data/loot_data.gd")
	if loot_script == null:
		return result
	var loot_data = loot_script.new()
	if loot_data == null or !(loot_data.loot_tables is Dictionary):
		return result
	for loot_id in loot_data.loot_tables:
		result[loot_id] = true
	return result


func _validate_effect_args(args, context, issues):
	if !(args is Dictionary):
		_add_issue(issues, "%s is not a Dictionary." % context)
		return
	for arg_id in args:
		var arg = args[arg_id]
		if !(arg is Dictionary):
			continue
		if arg.has("stat"):
			_validate_stat_ref(arg.stat, "%s.%s.stat" % [context, str(arg_id)], issues)


func _validate_event_list(value, context, issues):
	if value is int:
		return
	if value is Array:
		for idx in range(value.size()):
			if !(value[idx] is int):
				_add_issue(issues, "%s[%d] uses non-integer event '%s'." % [context, idx, str(value[idx])])
	else:
		_add_issue(issues, "%s is not an int or Array of ints." % context)


func _is_empty_event_list(value):
	if value == null:
		return true
	if value is Array:
		return value.empty()
	return false


func _has_tag(effect, tag):
	return effect.has("tags") and effect.tags is Array and effect.tags.has(tag)


func _is_number(value):
	return typeof(value) == TYPE_INT or typeof(value) == TYPE_REAL


func _is_empty_id(value):
	return value == null or (value is String and value == "")


func _is_non_empty_string(value):
	return value is String and value != ""


func _dict_string_equals(dict, key, expected):
	return dict.has(key) and dict[key] is String and dict[key] == expected


func _dict_string_in(dict, key, values):
	return dict.has(key) and dict[key] is String and values.has(dict[key])


func _validate_resource_path(path, context, label, issues):
	if !(path is String):
		_add_issue(issues, "%s uses non-string %s path '%s'." % [context, label, str(path)])
		return
	if !path.begins_with("res://"):
		return
	if !ResourceLoader.exists(path):
		_add_issue(issues, "%s references missing %s '%s'." % [context, label, path])


func _add_issue(issues, text):
	issues.append(text)


func _format_summary(issues):
	var lines = []
	lines.append("Effect validation complete: %d issue(s)." % issues.size())
	var limit = min(issues.size(), MAX_ISSUES_IN_SUMMARY)
	for idx in range(limit):
		lines.append("%d. %s" % [idx + 1, issues[idx]])
	if issues.size() > limit:
		lines.append("... %d more issue(s) hidden from console output." % (issues.size() - limit))
	return PoolStringArray(lines).join("\n")
