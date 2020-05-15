extends Node

var scenedict = {
	menu = "res://src/Menu.tscn",
	mansion = "res://src/main/Mansion.tscn",
	loadscreen = "res://src/LoadScreen.tscn",
	combat = "res://src/combat/combat.tscn",
	itemselect = "res://ItemSelect.tscn",
	black = "res://assets/sfx/BlackScreen.tscn",
	close = "res://src/scenes/CloseButton.tscn",
	interaction = "res://src/interactionpanel.tscn",
}

var scriptdict = {
	descriptions = "res://assets/data/descriptions.gd",
	custom_effects = "res://src/core/custom_effects.gd",
	core_animations = "res://src/core/core_animations.gd",
	game_globals = "res://src/core/game_globals.gd",
	game_party = "res://src/core/game_party.gd",
	game_progress = "res://src/core/game_progress.gd",
	game_res = "res://src/core/game_res.gd",
	game_world = "res://src/core/game_world.gd",
	ch_statlist = "res://src/character/stats.gd",
	ch_xp_module = "res://src/character/leveling.gd",
	ch_equipment = "res://src/character/equip.gd",
	ch_skills = "res://src/character/skills.gd",
	ch_travel = "res://src/character/travelling.gd",
	ch_effects = "res://src/character/effects.gd",
	ch_food = "res://src/character/food.gd",
	combat_animation = "res://src/combat/CombatAnimations.gd",
	sexinteraction_parser = "res://src/sexdescriptions.gd",
	sexinteraction_member = "res://src/interaction_member.gd",
	sexinteraction_sexdict = "res://src/newsexdictionary.gd",
	class_slave = "res://src/character/CharacterClass.gd",
	class_sskill = "res://src/classes/short_skill_new.gd",
	class_sskill_legacy = "res://src/classes/short_skill.gd",
	class_sskill_value = "res://src/classes/short_skill_value.gd",
	class_ai_base = "res://src/classes/AI_base.gd",
	world_gen = "res://src/core/world_gen.gd",
	custom_text = "res://src/core/custom_text.gd",
	slavelistmodule = "res://GUI_New/Mansion/MansionSlaveListModule.gd",
	fighternode = "res://src/combat/FighterNode.gd",
	closingpanel = "res://src/scenes/ClosingPanel.gd",
	gamestart = "res://src/GameStart.gd",
	rclickbutton = "res://src/scenes/RightClickReactButton.gd",
	}

onready var node_data = {
	input_handler.NODE_CLASSINFO : {name = 'classinfo', mode = 'scene', scene = preload("res://src/scenes/ClassInformationPanel.tscn")},
	input_handler.NODE_CHAT : {name = 'chatwindow', mode = 'scene', scene = preload("res://src/scenes/ChatNode.tscn")},
	input_handler.NODE_TUTORIAL : {name = 'tutorial_node', mode = 'scene', scene = preload("res://src/scenes/TutorialNode.tscn")},
	input_handler.NODE_LOOTTABLE : {name = 'lootwindow', mode = 'scene', scene = preload("res://src/scenes/LootWindow.tscn")},
	input_handler.NODE_DIALOGUE : {name = 'dialogue', mode = 'scene', scene = preload("res://src/scenes/InteractiveMessage.tscn")},
	input_handler.NODE_INVENTORY : {name = 'inventory', mode = 'scene', scene = preload("res://src/main/Inventory.tscn"), calls = 'open'},
	input_handler.NODE_POPUP : {name = 'PopupPanel', mode = 'scene', scene = preload("res://src/scenes/PopupPanel.tscn"), calls = 'open'},
	input_handler.NODE_CONFIRMPANEL : {name = 'ConfirmPanel', mode = 'scene', scene = preload("res://src/scenes/ConfirmPanel.tscn"), calls = 'Show'},
	input_handler.NODE_SLAVESELECT : {name = 'SlaveSelectMenu', mode = 'scene', scene = preload("res://src/scenes/SlaveSelectMenu.tscn")},
	input_handler.NODE_SKILLSELECT : {name = 'SelectSkillMenu', mode = 'scene', scene = preload("res://src/scenes/SkillSelectMenu.tscn")},
	#NODE_EVENT : {name = 'EventNode', mode = 'scene', scene = preload("res://src/scenes/TextSystem.tscn")},
	input_handler.NODE_MUSIC : {name = 'music', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Music"}},
	input_handler.NODE_SOUND : {name = 'sound', mode = 'node', no_return = true, node = AudioStreamPlayer, args = {'bus':"Sound"}},
	input_handler.NODE_BACKGROUND_SOUND : {name = 'BGSound', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Sound"}},
	input_handler.NODE_TEXTEDIT : {name = 'texteditnode', mode = 'scene', scene = preload("res://src/scenes/TextEditField.tscn")},
	input_handler.NODE_SLAVETOOLTIP : {name = 'slavetooltip', mode = 'scene', scene = preload("res://src/scenes/SlaveTooltip.tscn")},
	input_handler.NODE_SKILLTOOLTIP : {name = 'skilltooltip', mode = 'scene', scene = preload("res://src/scenes/SkillToolTip.tscn")},
	input_handler.NODE_ITEMTOOLTIP : {name = 'itemtooltip', mode = 'scene', scene = preload("res://src/scenes/Imagetooltip.tscn")},
	input_handler.NODE_TEXTTOOLTIP : {name = 'texttooltip', mode = 'scene', scene = preload("res://src/scenes/TextTooltipPanel.tscn")},
	input_handler.NODE_CHARCREATE : {name = 'charcreationpanel', mode = 'scene', scene = preload("res://src/scenes/CharacterCreationPanel.tscn"), calls = 'open'},
	input_handler.NODE_SLAVEPANEL : {name = 'slavepanel', mode = 'scene', scene = preload("res://src/scenes/SlavePanel.tscn")},
	input_handler.NODE_COMBATPOSITIONS : {name = 'combatpositions', mode = 'scene', scene = preload("res://src/scenes/PositionSelectMenu.tscn"), calls = 'open'},
	input_handler.NODE_SYSMESSAGE : {name = 'SysMessage', mode = 'scene', scene = preload("res://src/scenes/SysMessage.tscn") }, 
}

var singletones = ['descriptions','custom_effects', "core_animations", "world_gen", "custom_text"]
#singletones
var descriptions
var custom_effects
var core_animations
var world_gen
var custom_text

var gamestate = ['game_globals', 'game_party', 'game_progress', 'game_res', 'game_world']
#gamestate
var game_globals
var game_party
var game_progress
var game_res
var game_world

func load_scripts():
	for s in scriptdict:
		scriptdict[s] = load(scriptdict[s])

func recreate_singletons():
	for n in get_children():
		remove_child(n)
		n.free()
	for s in singletones:
		set(s, scriptdict[s].new())
		add_child(get(s))

func revert_gamestate():
	for s in gamestate:
		set(s, scriptdict[s].new())
