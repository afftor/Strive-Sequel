extends Node

var data = {
	event_locked_door = {text = tr("DIALOUELOCK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_lock_discount', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEACTIVATETRAP")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}], bonus_effects = [{code = 'pay_stamina', value = 10}, {code = 'unlock_subroom'}], text = tr("DIALOGUEPASSTRAP")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_lock_discount = {text = tr("DIALOUELOCKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	
	event_blocked_path = {text = tr("DIALOUELOCK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_blocked_path', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEACTIVATETRAP")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}], bonus_effects = [{code = 'pay_stamina', value = 10}, {code = 'unlock_subroom'}], text = tr("DIALOGUEPASSTRAP")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_blocked_path = {text = tr("DIALOUELOCKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	
	event_magic_barrier = {text = tr("DIALOUELOCK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_magic_barrier', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEACTIVATETRAP")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}], bonus_effects = [{code = 'pay_stamina', value = 10}, {code = 'unlock_subroom'}], text = tr("DIALOGUEPASSTRAP")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_magic_barrier = {text = tr("DIALOUELOCKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	event_high_cliff = {text = tr("DIALOUELOCK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_high_cliff', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEACTIVATETRAP")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}, {code = 'unlock_subroom'}], bonus_effects = [{code = 'pay_stamina', value = 10}], text = tr("DIALOGUEPASSTRAP")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_high_cliff = {text = tr("DIALOUELOCKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	event_small_crack = {text = tr("DIALOUELOCK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_small_crack', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEACTIVATETRAP")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}, {code = 'unlock_subroom'}], bonus_effects = [{code = 'pay_stamina', value = 10}], text = tr("DIALOGUEPASSTRAP")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_small_crack = {text = tr("DIALOUELOCKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	event_ancient_lock = {text = tr("DIALOUELOCK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_ancient_lock', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEACTIVATETRAP")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}, {code = 'unlock_subroom'}], bonus_effects = [{code = 'pay_stamina', value = 10}], text = tr("DIALOGUEPASSTRAP")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_ancient_lock = {text = tr("DIALOUELOCKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
}

