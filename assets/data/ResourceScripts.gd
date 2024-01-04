extends Node

var scenedict = {
	menu = "res://gui_modules/Universal/Modules/Menu.tscn",
	mansion = "res://gui_modules/Mansion/Modules/MansionMainModule.tscn",
	loadscreen = "res://src/LoadScreen.tscn",
	combat = "res://gui_modules/Universal/Modules/CombatV2Animated.tscn",
	itemselect = "res://gui_modules/Universal/Modules/ItemSelect.tscn",
	black = "res://assets/sfx/BlackScreen.tscn",
	white = "res://assets/sfx/WhiteScreen.tscn",
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
	ch_statlist = "res://src/character/ch_stats.gd",
	ch_leveling = "res://src/character/ch_leveling.gd",
	ch_equipment = "res://src/character/ch_equip.gd",
	ch_skills = "res://src/character/ch_skills.gd",
	ch_travel = "res://src/character/ch_travelling.gd",
	ch_effects = "res://src/character/ch_effects.gd",
	ch_food = "res://src/character/ch_food.gd",
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
#	slavelistmodule = "res://GUI_New/Mansion/MansionSlaveListModule.gd",
	fighternode = "res://src/combat/FighterNode.gd",
	closingpanel = "res://src/scenes/ClosingPanel.gd",
	gamestart = "res://src/GameStart.gd",
	rclickbutton = "res://src/scenes/RightClickReactButton.gd",
	gallery = "res://src/core/gallery.gd",
	rnd_portrait = "res://src/randomportraits/portrait.gd",
	rnd_main = "res://src/randomportraits/randomportraits.gd",
	sex_scenes = "res://assets/data/SexScenes.gd"
	}

onready var node_data = {
	input_handler.NODE_CLASSINFO : {name = 'classinfo', mode = 'scene', scene = preload("res://src/scenes/ClassInformationPanel.tscn")},
	input_handler.NODE_CHAT : {name = 'chatwindow', mode = 'scene', scene = preload("res://src/scenes/ChatNode.tscn")},
	input_handler.NODE_LOOTTABLE : {name = 'lootwindow', mode = 'scene', scene = preload("res://src/scenes/LootWindow.tscn")},
	input_handler.NODE_DIALOGUE : {name = 'dialogue', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/InteractiveMessageModuleAnimated.tscn")},
	input_handler.NODE_DIALOGUE_T2 : {name = 'dialogue_t2', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/QuestDialogue.tscn")},
	# input_handler.NODE_INVENTORY : {name = 'inventory', mode = 'scene', scene = preload("res://src/main/Inventory.tscn"), calls = 'open'},
	input_handler.NODE_POPUP : {name = 'PopupPanel', mode = 'scene', scene = preload("res://src/scenes/PopupPanel.tscn"), calls = 'open'},
	input_handler.NODE_ALERT_PANEL : {name = 'AlertPanel', mode = 'scene', scene = preload("res://src/scenes/AlertPanel.tscn"), calls = 'Show'},
	input_handler.NODE_CONFIRMPANEL : {name = 'AlertPanel', mode = 'scene', scene = preload("res://src/scenes/AlertPanel.tscn"), calls = 'ShowConfirmCancel'},
	input_handler.NODE_YESNOPANEL : {name = 'AlertPanel', mode = 'scene', scene = preload("res://src/scenes/AlertPanel.tscn"), calls = 'ShowYesNo'},
	input_handler.NODE_YESORNOPANEL : {name = 'AlertPanel', mode = 'scene', scene = preload("res://src/scenes/AlertPanel.tscn"), calls = 'ShowYesOrNo'},
	input_handler.NODE_SLAVESELECT : {name = 'SlaveSelectMenu', mode = 'scene', scene = preload("res://src/scenes/SlaveSelectMenu.tscn")},
	input_handler.NODE_SKILLSELECT : {name = 'SelectSkillMenu', mode = 'scene', scene = preload("res://src/scenes/SkillSelectMenu.tscn")},
	input_handler.NODE_MUSIC : {name = 'music', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Music"}},
	input_handler.NODE_SOUND : {name = 'sound', mode = 'node', no_return = true, node = AudioStreamPlayer, args = {'bus':"Sound"}},
	input_handler.NODE_BACKGROUND_SOUND : {name = 'BGSound', mode = 'node', node = AudioStreamPlayer, args = {'bus':"Sound"}},
	input_handler.NODE_TEXTEDIT : {name = 'texteditnode', mode = 'scene', scene = preload("res://src/scenes/TextEditField.tscn")},
	input_handler.NODE_SLAVETOOLTIP : {name = 'slavetooltip', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/SlaveTooltip.tscn")},
	input_handler.NODE_SKILLTOOLTIP : {name = 'skilltooltip', mode = 'scene', scene = preload("res://src/scenes/SkillToolTip.tscn")},
#	input_handler.NODE_ITEMTOOLTIP : {name = 'itemtooltip', mode = 'scene', scene = preload("res://src/scenes/Imagetooltip.tscn")},
#	input_handler.NODE_ITEMTOOLTIP_V2 : {name = 'itemtooltip_v2', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/ItemTooltip.tscn")},
#	input_handler.NODE_ITEMTOOLTIP_V2 : {name = 'itemtooltip_v2', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/ItemTooltipV3.tscn")},
	input_handler.NODE_ITEMTOOLTIP : {name = 'itemtooltip', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/ItemTooltipV3.tscn")},
	input_handler.NODE_TEXTTOOLTIP : {name = 'texttooltip', mode = 'scene', scene = preload("res://src/scenes/TextTooltipPanel.tscn")},
	input_handler.NODE_GALLERYTOOLTIP : {name = 'gallerytooltip', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/GalleryTooltip.tscn")},
	input_handler.NODE_CHARCREATE : {name = 'charcreationpanel', mode = 'scene', scene = preload("res://gui_modules/CharacterCreation/CharacterCreationMainModule.tscn"), calls = 'open'},
	input_handler.NODE_CHAREDIT : {name = 'charcreationpanel', mode = 'scene', scene = preload("res://gui_modules/CharacterCreation/CharacterCreationMainModule.tscn"), calls = 'open_freemode'},
	input_handler.NODE_COMBATPOSITIONS : {name = 'combatpositions', mode = 'scene', scene = preload("res://src/scenes/PositionSelectMenu.tscn"), calls = 'open'},
	input_handler.NODE_SYSMESSAGE : {name = 'SysMessage', mode = 'scene', scene = preload("res://src/scenes/SysMessage.tscn") },
	input_handler.NODE_SLAVEMODULE : {name = 'slavemodule', mode = 'scene', scene = preload("res://gui_modules/CharacterInfo/CharInfoMainModule.tscn") },
	input_handler.NODE_INVENTORY_NEW : {name = 'inventory_new', mode = 'scene', scene = preload("res://gui_modules/Inventory/Modules/InventoryMainModule.tscn") },
	input_handler.NODE_MANSION_NEW : {name = 'mansion', mode = 'scene', scene = preload("res://gui_modules/Mansion/Modules/MansionMainModule.tscn") },
	input_handler.NODE_CLOCK : {name = 'clock', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/ClockModule.tscn") },
	input_handler.NODE_EXPLORATION : {name = 'exploration', mode = 'scene', scene = preload("res://gui_modules/Exploration/Modules/ExplorationModule.tscn") },
	input_handler.NODE_EXPLORE_SLAVEINFO : {name = 'explore_slaveinfo', mode = 'scene', scene = preload("res://gui_modules/Exploration/Modules/ExploreFullSlaveInfo.tscn") },
	input_handler.NODE_GAMEMENU : {name = 'gamemenu', mode = 'scene', scene = preload("res://gui_modules/Universal/Modules/GameMenuPanel.tscn") },
	input_handler.NODE_SEX : {name = 'sex_panel', mode = 'scene', scene = preload("res://gui_modules/Interaction/Modules/InteractionMainModule.tscn") },
	input_handler.NODE_DATE : {name = 'date_panel', mode = 'scene', scene = preload("res://gui_modules/Interaction/Modules/date.tscn") },
	input_handler.NODE_TUTORIAL_PANEL : {name = 'tutorial_panel', mode = 'scene', scene = preload("res://gui_modules/Mansion/Modules/Tutorial.tscn") },
	input_handler.NODE_TRAIREM_PANEL : {name = 'trait_removal', mode = 'scene', scene = preload("res://gui_modules/Inventory/Modules/TraitRemovePanel.tscn") },
	#Animations
	input_handler.ANIM_TASK_AQUARED : {name = 'ANIMTaskAquared', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_task_aquired.tscn") },
	input_handler.ANIM_BATTLE_START : {name = 'ANIMBattleStart', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_battle_start.tscn") },
	input_handler.ANIM_BATTLE_DEFEAT : {name = 'ANIMBattleDefeat', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_defeated.tscn") },
	input_handler.ANIM_BATTLE_RUNAWAY : {name = 'ANIMBattleRunaway', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_runaway.tscn") },
	input_handler.ANIM_CLASS_ACHIEVED : {name = 'ANIMClassAchieved', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_class_achieved.tscn") },
	input_handler.ANIM_CLASS_UNLOCKED : {name = 'ANIMTaskAquared', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_class_unlocked.tscn") },
	input_handler.ANIM_TASK_COMPLETED : {name = 'ANIMTaskCompleted', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_task_completed.tscn") },
	input_handler.ANIM_LOOT : {name = 'ANIMLoot', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_loot.tscn") },
	input_handler.ANIM_SKILL_UNLOCKED : {name = 'ANIMSkillUnlocked', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_ability_unlocked.tscn") },
	input_handler.ANIM_GROWTHF : {name = 'ANIMGrowthFactor', mode = 'scene', scene = preload("res://gui_modules/Animations/Animation_growth_factor.tscn") },
}


var singletones = ['descriptions','custom_effects', "core_animations", "world_gen", "custom_text", "gallery", 'rnd_main']
#singletones
var descriptions
var custom_effects
var core_animations
var world_gen
var custom_text
var gallery
var rnd_main

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
	characters_pool.cleanup(true)
	for s in gamestate:
		set(s, scriptdict[s].new())
	input_handler.connect("EnemyKilled", game_world, "quest_kill_receiver")
