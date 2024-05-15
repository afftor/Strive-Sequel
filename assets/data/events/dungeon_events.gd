extends Node

var data = {
	event_locked_door = {text = tr("DIALOUELOCKEDDOOR"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_lock_discount', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOUELOCKEDDOORSELECT")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}], bonus_effects = [{code = 'pay_stamina', value = 10}, {code = 'unlock_subroom'}], text = tr("DIALOUELOCKEDDOORBREAK")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_lock_discount = {text = tr("DIALOUELOCKEDDOORPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	
	event_blocked_path = {text = tr("DIALOGUEBLOCKEDPATH"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_blocked_path', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEBLOCKEDPATHSELECT")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}], bonus_effects = [{code = 'pay_stamina', value = 10}, {code = 'unlock_subroom'}], text = tr("DIALOGUEBLOCKEDPATHBREAK")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_blocked_path = {text = tr("DIALOGUEBLOCKEDPATHPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	
	event_magic_barrier = {text = tr("DIALOGUEMAGICBARRIER"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_magic_barrier', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEMAGICBARRIERSELECT")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}], bonus_effects = [{code = 'pay_stamina', value = 10}, {code = 'unlock_subroom'}], text = tr("DIALOGUEMAGICBARRIERBREAK")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_magic_barrier = {text = tr("DIALOGUEMAGICBARRIERPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	event_high_cliff = {text = tr("DIALOGUEHIGHCLIFF"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_high_cliff', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEHIGHCLIFFSELECT")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}, {code = 'unlock_subroom'}], bonus_effects = [{code = 'pay_stamina', value = 10}], text = tr("DIALOGUEHIGHCLIFFBREAK")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_high_cliff = {text = tr("DIALOGUEHIGHCLIFFPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	event_small_crack = {text = tr("DIALOGUESMALLCRACK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_small_crack', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUESMALLCRACKSELECT")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}, {code = 'unlock_subroom'}], bonus_effects = [{code = 'pay_stamina', value = 10}], text = tr("DIALOGUESMALLCRACKBREAK")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_small_crack = {text = tr("DIALOGUESMALLCRACKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
	event_ancient_lock = {text = tr("DIALOGUEANCIENTLOCK"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'pass_ancient_lock', select_person = true, reqs = [{type = 'has_stamina', value = 3}], text = tr("DIALOGUEANCIENTLOCKSELECT")},
	{code = 'close', reqs = [{type = 'has_stamina', value = 10}, {code = 'unlock_subroom'}], bonus_effects = [{code = 'pay_stamina', value = 10}], text = tr("DIALOGUEANCIENTLOCKBREAK")},
	{code = 'close', reqs = [], text = tr("DIALOGUECANCEL")},
	]
	},
	
	pass_ancient_lock = {text = tr("DIALOGUEANCIENTLOCKPASS"),
	tags = ['linked_event'],
	default_event_type = "trap",
	image = 'trap',
	options = [
	{code = 'close', reqs = [], bonus_effects = [{code = 'pay_stamina', value = 3}, {code = 'unlock_subroom'}], text = tr("DIALOGUECLOSE")},
	]
	},
	
}

