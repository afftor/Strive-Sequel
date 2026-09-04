extends Reference

const MansionLayout = preload("res://src/core/mansion_layout.gd")

#Which room of the house the work chapter is taught on. It starts under rubble on the ground
#floor (assets/data/mansion_floor_plans.gd), is cleared out, and then has the kitchen raised
#on it - one slot carries the whole lesson so every step can point at the same place.
const TUTORIAL_SLOT = 'c2'
#The plot on the estate grounds the kitchen garden stands on. Put there by
#prepare_mansion_for_tut(), because the gathering lesson is about manning work that already
#exists rather than about raising another building.
const TUTORIAL_PLOT = 'g1'
#The house's ground floor. The rubble the chapter clears is down here on purpose: clearing
#takes two turns at this level instead of three (MansionLayout.repair_turns).
const TUTORIAL_FLOOR = 0

var active_btns = {
#	name = btn
}
var temp_active_btns

#var btns = {
#	#name = {source, get_btn_func, rect_obj, rect_func}
#}
var prepare_tutorial_funcs = {
	training = ['prepare_general_tut'],
	work = ['prepare_general_tut', 'prepare_work_tut'],
	leveling = ['prepare_general_tut'],
	quest_and_combat = ['prepare_general_tut', 'prepare_combat_tut']
}

var tutorial_sequence = [
	'training', 'work_intermedia', 'work',
	'leveling_intermedia', 'leveling',
	'quest_and_combat_intermedia', 'quest_and_combat']

var tutorials = {
	training = [
		{
			#The mansion opens on the household list, which is where this chapter happens, so the
			#screen is already the way a first-time player finds it and there is nothing to set up.
			buttons = [],
			text = "TUTORIAL_TRAINING1",
			panel_pos = Vector2(733,456)
		},
		#1
		{
			#Named rather than pointed at: the only thing worth framing here would be the fold
			#handle, and pressing that would fold away the very list the next step reads a row out
			#of. What the handle is for is taught in the rooms chapter, which is where it is wanted.
			buttons = [],
			text = "TUTORIAL_TRAINING1_0",
			panel_pos = Vector2(660,430)
		},{
			#a fold the player drives is tweened, unlike the scripted one, so the rows only reach
			#their places a fraction of a second later
			buttons = ['master_line'],
			text = "TUTORIAL_TRAINING1_1",
			panel_pos = Vector2(1100,250),
			delay = 0.3
		},{
			#the expanded card is built over several frames and then tweened into place
			buttons = ['mentor_skill_btn'],
			text = "TUTORIAL_TRAINING2",
			panel_pos = Vector2(1100,780),
			delay = 1.0
		},{
			#the target picker is a separate window over the mansion
			buttons = ['slave_select'],
			text = "TUTORIAL_TRAINING3",
			panel_pos = Vector2(100,150)
		},{
			buttons = ['event_opt_1'],
			text = "TUTORIAL_TRAINING4",
			panel_pos = Vector2(50,850),
			delay = 1.0
		},
		#2
		#food is managed on the expanded card now, the character sheet is not involved
		{
			buttons = [],
			text = "TUTORIAL_TRAINING5",
			panel_pos = Vector2(1250,150)
		},{
			buttons = ['food_filter_btn'],
			text = "TUTORIAL_TRAINING6",
			panel_pos = Vector2(1250,150)
		},
		#3
		{
			#the filter panel is built over the card, so it needs a frame to appear
			buttons = ['food_preference_meat'],
			text = "TUTORIAL_TRAINING7",
			panel_pos = Vector2(1250,150),
			delay = 0.5
		},{
			buttons = ['food_filter_close'],
			text = "TUTORIAL_TRAINING8",
			panel_pos = Vector2(1250,150)
		},{
			#the unfolded card covers the list, so it has to be folded back before another
			#character can be picked. the step also folds it for players who use the panel button
			buttons = [],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			additional_func = 'close_expanded_card',
			text = "TUTORIAL_TRAINING8_1",
			panel_pos = Vector2(1250,150)
		},{
			buttons = ['daisy_line'],
			text = "TUTORIAL_TRAINING9",
			panel_pos = Vector2(1250,150),
			delay = 0.6
		},{
			#training is its own popup off the card now - the character window is no longer
			#on the way to it
			buttons = ['training_btn'],
			text = "TUTORIAL_TRAINING10",
			panel_pos = Vector2(1100,500),
			delay = 1.0
		},{
			#the trainer picker opens on its own for a slave who has none, so there is no
			#separate step for reaching it any more. it is still translating and scaling into
			#place a moment after it appears - framed without this wait the frame lands about
			#(26, 33) px down and to the right of the entry and cuts across the next one
			buttons = ['trainer_select_btn'],
			text = "TUTORIAL_TRAINING12",
			panel_pos = Vector2(880,760),
			delay = 0.5
		},{
			buttons = ['praise_btn'],
			text = "TUTORIAL_TRAINING13",
			panel_pos = Vector2(880,780)
		},{
			buttons = ['event_opt_1'],
			text = "TUTORIAL_TRAINING14",
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['event_opt_1'],
			text = "TUTORIAL_TRAINING14_1",
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['training_bonus_btn'],
			text = "TUTORIAL_TRAINING15",
			panel_pos = Vector2(40,760)
		},{
			buttons = ['alert_panel_yes'],
			text = "TUTORIAL_TRAINING16",
			panel_pos = Vector2(40,760)
		},{
			buttons = ['minor_upg'],
			text = "TUTORIAL_TRAINING17",
			panel_pos = Vector2(40,760),
			delay = 3.0
		},{
			#the proficiency grid settles about 15 px upwards after the tab is built, so the
			#frame is drawn low without this wait
			buttons = ['etiquette'],
			text = "TUTORIAL_TRAINING18",
			panel_pos = Vector2(40,760),
			delay = 0.3
		},{
			buttons = ['alert_panel_yes'],
			text = "TUTORIAL_TRAINING19",
			panel_pos = Vector2(40,760)
		}
	],
	work_intermedia = [
		{
			#the training chapter now ends in the training popup, not the character window
			buttons = ['training_close_button'],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			text = "TUTORIAL_WORK0",
			panel_pos = Vector2(733,150)
		}
	],
	work = [
		#### clearing a room out ####
		{
			buttons = [],
			text = "TUTORIAL_WORK_ROOM1",
			panel_pos = Vector2(660, 430)
		},{
			#This chapter cannot start without it: the list the mansion opens on covers the
			#floorplan outright and takes the idle strip with it (set_slave_list_fold ->
			#rooms.set_hud_visible), so there would be nobody to pick up and nowhere to put them.
			#Two gestures do it - the row of view buttons down the left, and the handle on the
			#list's own bar - so both are framed and either one lets the step through.
			buttons = ['mansion_mode_work_btn', 'slave_list_fold_btn'],
			highlight = ['mansion_mode_work_btn', 'slave_list_fold_btn'],
			text = "TUTORIAL_WORK_ROOM1_1",
			panel_pos = Vector2(660, 430)
		},{
			#the floorplan and its counters are uncovered by a tween, so the slot settles a few
			#frames after the click
			buttons = ['mansion_tut_slot'],
			text = "TUTORIAL_WORK_ROOM2",
			panel_pos = Vector2(1330, 200),
			delay = 0.4
		},{
			#the card is built and then fitted to its contents over a couple of frames
			buttons = ['mansion_repair_btn'],
			text = "TUTORIAL_WORK_ROOM3",
			panel_pos = Vector2(1330, 200),
			delay = 0.5
		},{
			#start_repair closes the card itself, so the grid is already back
			buttons = ['mansion_rest_daisy'],
			text = "TUTORIAL_WORK_ROOM4",
			panel_pos = Vector2(660, 500),
			delay = 0.4
		},{
			buttons = ['mansion_build_place'],
			text = "TUTORIAL_WORK_ROOM5",
			panel_pos = Vector2(1330, 300)
		},{
			buttons = ['finish_turn'],
			text = "TUTORIAL_WORK_ROOM6",
			panel_pos = Vector2(1150, 640)
		},{
			#the turn plays out before the screen is worth pointing at again
			buttons = ['finish_turn'],
			text = "TUTORIAL_WORK_ROOM7",
			panel_pos = Vector2(1150, 640),
			delay = 1.0
		},
		#### raising a room ####
		{
			buttons = ['mansion_tut_slot'],
			text = "TUTORIAL_WORK_ROOM8",
			panel_pos = Vector2(1330, 200),
			delay = 1.0
		},{
			#the catalogue card is nearly the width of the screen, so the text goes above it
			buttons = ['mansion_build_kitchen'],
			text = "TUTORIAL_WORK_ROOM9",
			panel_pos = Vector2(60, 40),
			delay = 0.5
		},{
			buttons = ['mansion_rest_daisy'],
			text = "TUTORIAL_WORK_ROOM10",
			panel_pos = Vector2(660, 500),
			delay = 0.4
		},{
			buttons = ['mansion_build_place'],
			text = "TUTORIAL_WORK_ROOM11",
			panel_pos = Vector2(1330, 300)
		},{
			#A kitchen is 25 work units, which is five to ten turns of one builder - too long to
			#sit through here, so the scaffolding is put within one turn of done as this step
			#opens. Said on the Finish Turn step rather than on a page of its own: a step whose
			#only button is "next" is a click that does nothing.
			buttons = ['finish_turn'],
			tut_func = 'rush_current_build',
			text = "TUTORIAL_WORK_ROOM12",
			panel_pos = Vector2(1150, 640)
		},
		#### crafting, given out of the room that does it ####
		{
			buttons = ['mansion_tut_slot'],
			text = "TUTORIAL_WORK_ROOM14",
			panel_pos = Vector2(1330, 200),
			delay = 1.0
		},{
			buttons = ['mansion_card_craft_btn'],
			text = "TUTORIAL_WORK_ROOM15",
			panel_pos = Vector2(1330, 200),
			delay = 0.5
		},{
			#the craft screen opens on the room's own discipline
			buttons = ['bread_button'],
			text = "TUTORIAL_WORK_ROOM16",
			panel_pos = Vector2(733, 50),
			delay = 0.5
		},{
			buttons = ['craft_confirm_button'],
			text = "TUTORIAL_WORK_ROOM17",
			panel_pos = Vector2(733, 50)
		},{
			buttons = ['craft_plus_button'],
			text = "TUTORIAL_WORK_ROOM18",
			panel_pos = Vector2(733, 50)
		},{
			buttons = ['craft_confirm2_button'],
			text = "TUTORIAL_WORK_ROOM19",
			panel_pos = Vector2(733, 50)
		},{
			buttons = ['meatsoup_button'],
			text = "TUTORIAL_WORK_ROOM20",
			panel_pos = Vector2(733, 50)
		},{
			buttons = ['craft_confirm_button'],
			text = "TUTORIAL_WORK_ROOM21",
			panel_pos = Vector2(733, 50)
		},{
			buttons = ['craft_confirm2_button'],
			text = "TUTORIAL_WORK_ROOM22",
			panel_pos = Vector2(733, 50)
		},{
			buttons = ['meatsoup_delete'],
			text = "TUTORIAL_WORK_ROOM23",
			panel_pos = Vector2(733, 50)
		},{
			buttons = ['alert_panel_yes'],
			text = "TUTORIAL_WORK_ROOM24",
			panel_pos = Vector2(733, 50)
		},{
			#every mansion state but 'default' wants the whole slave list back
			#(MansionSlaveListModule.apply_state_fold), and coming back to 'default' during a
			#hard tutorial deliberately leaves it as it is - so the strip has to be folded away
			#again here or the next step would have nobody to pick up
			buttons = ['craft_back_button'],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			additional_func = 'fold_slave_list',
			text = "TUTORIAL_WORK_ROOM25",
			panel_pos = Vector2(733, 50)
		},{
			#an order is only a plan until somebody stands in the room: game_res.process_rooms()
			#walks the rooms that have workers and no others
			buttons = ['mansion_rest_daisy'],
			text = "TUTORIAL_WORK_ROOM26",
			panel_pos = Vector2(660, 500),
			delay = 0.6
		},{
			buttons = ['mansion_work_place'],
			text = "TUTORIAL_WORK_ROOM27",
			panel_pos = Vector2(1330, 300)
		},{
			buttons = ['finish_turn'],
			text = "TUTORIAL_WORK_ROOM28",
			panel_pos = Vector2(1150, 640)
		},
		#### the work that happens outside the house ####
		{
			buttons = ['mansion_local_tasks_btn'],
			text = "TUTORIAL_WORK_ROOM29",
			panel_pos = Vector2(660, 300),
			delay = 1.0
		},{
			buttons = ['mansion_rest_servant'],
			text = "TUTORIAL_WORK_ROOM30",
			panel_pos = Vector2(660, 500),
			delay = 0.5
		},{
			buttons = ['mansion_garden_place'],
			text = "TUTORIAL_WORK_ROOM31",
			panel_pos = Vector2(1330, 300)
		},{
			buttons = ['finish_turn'],
			text = "TUTORIAL_WORK_ROOM32",
			panel_pos = Vector2(1150, 640)
		},{
			buttons = ['mansion_scope_btn'],
			text = "TUTORIAL_WORK_ROOM33",
			panel_pos = Vector2(660, 300),
			delay = 1.0
		},
		#### where the household sleeps ####
		{
			#The estate seats everybody by itself as they arrive (game_res.autohouse_character),
			#so a tutorial household has nowhere for this lesson to happen - Daisy is turned out
			#of her bed as the step opens, which is also the state the player meets it in: a
			#room short, and somebody in the strip with nowhere to go.
			buttons = ['mansion_mode_beds_btn'],
			tut_func = 'open_bed_lesson',
			text = "TUTORIAL_WORK_BED1",
			panel_pos = Vector2(400, 430),
			delay = 0.4
		},{
			#the plan redraws every room when the mode changes, so the strip settles a few
			#frames after the button
			buttons = ['mansion_rest_daisy'],
			text = "TUTORIAL_WORK_BED2",
			panel_pos = Vector2(660, 500),
			delay = 0.5
		},{
			buttons = ['mansion_bed_place'],
			text = "TUTORIAL_WORK_BED3",
			panel_pos = Vector2(660, 620)
		},{
			buttons = ['mansion_mode_work_btn'],
			text = "TUTORIAL_WORK_BED4",
			panel_pos = Vector2(400, 430),
			delay = 0.4
		}
	],
	leveling_intermedia = [
		{
			#The rooms chapter ends on the mansion screen with nothing open over it, so this is a
			#hand-over rather than a window to close. It is also where the slave list is put back:
			#the rooms chapter folds it away to reach the idle strip underneath, and every chapter
			#after this one points at rows inside the list instead.
			buttons = [],
			tut_func = 'unfold_slave_list',
			text = "TUTORIAL_LEVELING0",
			panel_pos = Vector2(660, 430)
		}
	],
	leveling = [
		#4
		{
			#the chest is kept in the store room now, and the room is under the slave list -
			#which the chapter before this one puts back up
			buttons = ['mansion_store_slot'],
			tut_func = 'fold_slave_list',
			text = "TUTORIAL_LEVELING1_0",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['mansion_card_inventory_btn'],
			text = "TUTORIAL_LEVELING1",
			panel_pos = Vector2(733,150)
		},{
			buttons = ['inv_master_line'],
			text = "TUTORIAL_LEVELING2",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['inv_exp_scroll'],
			text = "TUTORIAL_LEVELING3",
			panel_pos = Vector2(733,50)
		},{
			buttons = ['event_opt_1'],
			text = "TUTORIAL_LEVELING4",
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['inv_close_button'],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			text = "TUTORIAL_LEVELING5",
			panel_pos = Vector2(733,150)
		},{
			#returning to the mansion collapses the expanded card, so it has to be reopened -
			#and the list itself was folded away to reach the store room
			buttons = ['master_line'],
			tut_func = 'unfold_slave_list',
			text = "TUTORIAL_LEVELING5_1",
			panel_pos = Vector2(1100,250)
		},{
			#classes and masteries live in their own popup now, opened straight from the card
			buttons = ['progression_btn'],
			text = "TUTORIAL_LEVELING6",
			panel_pos = Vector2(1100,500),
			delay = 1.0
		},{
			#the popup fades in over several frames. it is centered and wide, so the tutorial
			#text sits to the right of it from here on
			buttons = ['class_fighter'],
			text = "TUTORIAL_LEVELING8",
			panel_pos = Vector2(1400,200),
			delay = 0.5
		},{
			buttons = ['class_unlock'],
			text = "TUTORIAL_LEVELING9",
			panel_pos = Vector2(1400,400)
		},{
			#unlocking plays the class acquired animation before the popup is usable again
			buttons = ['progression_masteries_tab'],
			text = "TUTORIAL_LEVELING10",
			panel_pos = Vector2(1400,200),
			delay = 1.5
		},{
			#the tab switch is tweened, so the button rect settles a few frames later
			buttons = ['mastery_leadership'],
			text = "TUTORIAL_LEVELING11",
			panel_pos = Vector2(1400,300),
			delay = 0.5
		},{
			buttons = ['mastery_add_point', 'mastery_add_point2'],
			highlight = ['mastery_add_point_highlight'],
			text = "TUTORIAL_LEVELING12",
			panel_pos = Vector2(1400,300)
		},{
			buttons = ['alert_panel_yes'],
			text = "TUTORIAL_LEVELING13",
			panel_pos = Vector2(1400,500)
		}
	],
	quest_and_combat_intermedia = [
		{
			#the leveling part ends in the progression popup, not in the character panel
			buttons = ['progression_close_button'],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			text = 'TUTORIAL_COMBAT0',
			panel_pos = Vector2(1400,200),
			delay = 1.5
		}
	],
	quest_and_combat = [
		#### the short way round, taught on the way out of the house ####
		{
			#Taught on the strip of portraits rather than on a row of the household list: the
			#strip's menu is the whole of what can be done with somebody, where a row offers two
			#entries. The list has been open since the chapter before pointed at rows inside it,
			#and the strip lives under it (set_slave_list_fold -> rooms.set_hud_visible), so it
			#has to be folded away again before there is anything here to point at.
			#Right click only: the portrait is framed because it is the thing to point at, and
			#barred because a left click picks the character up to be carried somewhere, which
			#is a different lesson entirely. A ban is read on the left button alone, so the
			#gesture being taught still goes through.
			buttons = ['mansion_rest_master'],
			dont_listen = ['mansion_rest_master'],
			ban_buttons = ['mansion_rest_master'],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			tut_func = 'fold_slave_list',
			text = "TUTORIAL_RMB_MENU1",
			panel_pos = Vector2(560,330),
			#the strip is laid out a frame or two after the fold uncovers it
			delay = 0.4
		},{
			#The menu is a popup and takes the next click for itself whatever it lands on, so
			#this one is ended by the same gesture that opened it - the panel's own button is
			#still there for anyone who reaches for it instead, and either way the menu is put
			#away before the lesson moves on.
			buttons = [],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			additional_func = 'close_char_context_menu',
			text = "TUTORIAL_RMB_MENU2",
			#beside the menu it is about rather than across the screen from it: the menu opens
			#off the right-hand edge of the portrait the step before framed
			panel_pos = Vector2(700,300)
		},
		#5
		{
			buttons = ['aliron_btn'],
			text = 'TUTORIAL_COMBAT1',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['quest_board'],
			text = 'TUTORIAL_COMBAT2',
			panel_pos = Vector2(733,150),
			delay = 0.5
		},{
			buttons = ['quest_btn'],
			text = 'TUTORIAL_COMBAT3',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['quest_accept'],
			text = 'TUTORIAL_COMBAT4',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['quest_close'],
			text = 'TUTORIAL_COMBAT5',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_btn'],
			text = 'TUTORIAL_COMBAT5',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_master', 'travel_servant'],
			highlight = ['travel_chars_highlight'],
			condition_func = "check_travel_select",
			ban_mass_select = true,
			text = 'TUTORIAL_COMBAT6',
			panel_pos = Vector2(733,150)
#		},{
#			buttons = ['travel_send'],
#			ban_mass_select = true,
#			text = 'TUTORIAL_COMBAT7',
#			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_to_loc'],
			ban_mass_select = true,
			text = 'TUTORIAL_COMBAT8',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_confirm'],
			ban_mass_select = true,
			text = 'TUTORIAL_COMBAT9',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['travel_back'],
			ban_mass_select = true,
			text = 'TUTORIAL_COMBAT10',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['finish_turn'],
			text = 'TUTORIAL_COMBAT11',
			panel_pos = Vector2(733,150),
			delay = 0.5
		},{
			#the strip's button has no press of its own: hovering it turns it into a Work and
			#an Explore, and Explore is what goes to the place. Pressing the picture used to
			#carry the lesson forward while the player was still standing in the mansion.
			#Work is barred rather than left out: it sits inside the framed picture, and
			#pressing it staffs the place from the mansion - which walks the player off this
			#screen and leaves the lesson pointing at a strip they are no longer looking at
			buttons = ['quest_loc_nav_btn', 'quest_loc_nav_explore_btn', 'quest_loc_nav_work_btn'],
			dont_listen = ['quest_loc_nav_btn', 'quest_loc_nav_work_btn'],
			ban_buttons = ['quest_loc_nav_work_btn'],
			highlight = ['quest_loc_nav_btn'],
			text = 'TUTORIAL_COMBAT12',
			panel_pos = Vector2(733,150),
			delay = 0.5
		},{
			buttons = ['location_master', 'location_front_pos1', 'location_front_pos2', 'location_front_pos3'],
			dont_listen = ['location_master'],
			block_event = {location_master = ['released']},
			highlight = ['location_master', 'location_front_highlight'],
			text = 'TUTORIAL_COMBAT13',
			panel_pos = Vector2(733,150),
			delay = 1.0
		},{
			buttons = ['location_servent', 'location_back_pos1', 'location_back_pos2', 'location_back_pos3'],
			dont_listen = ['location_servent'],
			block_event = {location_servent = ['released']},
			highlight = ['location_servent', 'location_back_highlight'],
			text = 'TUTORIAL_COMBAT14',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['location_servent_pos'],
			text = 'TUTORIAL_COMBAT14_1',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['location_reju_btn'],
			text = 'TUTORIAL_COMBAT14_2',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['location_master_pos'],
			text = 'TUTORIAL_COMBAT14_3',
			panel_pos = Vector2(733,150)
		},{
			buttons = [],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			text = 'TUTORIAL_COMBAT14_4',
			additional_func = 'stop_use_state',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['location_proceed'],
			text = 'TUTORIAL_COMBAT15',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['event_opt_1'],
			text = 'TUTORIAL_COMBAT16',
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['pos_select_confirm'],
			text = 'TUTORIAL_COMBAT17',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['tut_full_screen'],
			dont_listen = ['tut_full_screen'],
			listen = ['combat_turn_signal'],
			no_highlight = true,
			condition_func = "check_turn_master",
			panel_pos = Vector2(100,50)
		},{
			buttons = ['combat_skill_1'],
			text = 'TUTORIAL_COMBAT19',
			panel_pos = Vector2(733,50),
			delay = 0.5
		},{
			buttons = ['combat_enemy'],
			text = 'TUTORIAL_COMBAT20',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['tut_full_screen'],
			dont_listen = ['tut_full_screen'],
			listen = ['combat_turn_signal'],
			no_highlight = true,
			condition_func = "check_turn_servent",
			panel_pos = Vector2(100,50)
		},{
			buttons = ['combat_skill_2'],
			text = 'TUTORIAL_COMBAT22',
			panel_pos = Vector2(733,50),
			delay = 0.8
		},{
			buttons = ['combat_ally'],
			text = 'TUTORIAL_COMBAT22',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['tut_full_screen'],
			dont_listen = ['tut_full_screen'],
			listen = ['combat_finished_signal'],
			no_highlight = true,
			text = 'TUTORIAL_COMBAT24',
			panel_pos = Vector2(100,50)
		},{
			buttons = ['tut_full_screen'],
			dont_listen = ['tut_full_screen'],
			listen = ['combat_rewards_signal'],
			no_highlight = true,
			tut_func = "add_combat_reward_char",
			panel_pos = Vector2(100,50)
		},{
			buttons = ['combat_close'],
			text = 'TUTORIAL_COMBAT26',
			panel_pos = Vector2(733,50),
			delay = 1.0
		},{
			buttons = ['first_recruit_char'],
			text = 'TUTORIAL_COMBAT27',
			panel_pos = Vector2(733,50),
			delay = 0.5
		},{
			buttons = ['slave_info_close_button'],
			listen = ['close_by_RMB_sig'],
			pass_RMB = true,
			text = 'TUTORIAL_COMBAT28',
			panel_pos = Vector2(733,50),
			delay = 2.0
		},{
			buttons = ['first_recruit'],
			text = 'TUTORIAL_COMBAT29',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['event_opt_1'],
			text = 'TUTORIAL_COMBAT30',
			panel_pos = Vector2(50,850),
			delay = 1.5
		},{
			buttons = ['slave_select'],
			text = 'TUTORIAL_COMBAT31',
			panel_pos = Vector2(50,850)
		},{
			buttons = ['event_opt_2'],
			text = 'TUTORIAL_COMBAT32',
			panel_pos = Vector2(50,850),
			delay = 1.7
		},{
			buttons = ['event_opt_1'],
			text = 'TUTORIAL_COMBAT33',
			panel_pos = Vector2(50,850),
			delay = 1.0
		},{
			buttons = ['mansion_btn'],
			text = 'TUTORIAL_COMBAT34',
			panel_pos = Vector2(733,150)
		},{
			buttons = ['journal_button'],
			text = 'TUTORIAL_COMBAT35',
			panel_pos = Vector2(733,150),
			delay = 1.0
		},{
			buttons = ['journal_minor'],
			text = 'TUTORIAL_COMBAT36',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['journal_first_quest'],
			text = 'TUTORIAL_COMBAT37',
			panel_pos = Vector2(733,50)
		},{
			buttons = ['journal_complete'],
			text = 'TUTORIAL_COMBAT38',
			panel_pos = Vector2(733,50)
		},{
			buttons = [],
			text = "TUTORIAL_COMBAT39",
			panel_pos = Vector2(733,456)
		},
	]
}
var cur_tut
var cur_step = -1
var cur_dont_listen
var temp_cur_dont_listen
var tut_panel
var tut_menu
var listeners = [
	#{source, sig, fun}
]
var remembered_soft_tutorial_state = false
signal close_by_RMB

func _init():
	tut_panel = input_handler.get_spec_node(input_handler.NODE_HARD_TUTORIAL_PANEL)
	tut_panel.close_panel()
	input_handler.register_btn_source('close_by_RMB_sig', self, null, null, null, 'close_by_RMB')

func _notification(what):
	if what == NOTIFICATION_PREDELETE and is_instance_valid(tut_panel):
		tut_panel.queue_free()

func get_btns():
	return input_handler.hard_tutorial_btns

#a button that cannot be resolved yet is kept as a null entry, so validate_btn retries it
#every frame - the panel it lives in may still be building
func activate_btn(btn_name):
	var btns = get_btns()
	if !btns.has(btn_name):
		push_error("tutorial button %s is not registered" % btn_name)
		active_btns[btn_name] = null
		return false
	var btn = btns[btn_name]
	var source = btn.source.get_ref()
	if source == null or !is_instance_valid(source):
		push_error("tutorial button %s lost its source" % btn_name)
		active_btns[btn_name] = null
		return false
	active_btns[btn_name] = source.call(btn.get_btn_func)
	if active_btns[btn_name] == null:
		push_error("no tutorial button %s" % btn_name)
		return false
	if cur_dont_listen == null or !(btn_name in cur_dont_listen):
		set_listener(active_btns[btn_name], get_btns_signal(btn_name), "btn_truly_pressed")
	return true

#Asked before every click is judged. A dead entry is resolved again, and so is a live one that
#is no longer the button its source answers with: the same panel exists on more than one screen
#(the navigation strip is on all of them), and the copy a step resolved stays alive - and deaf -
#when the screen holding it is merely hidden. Left alone, the frame keeps sitting on the right
#coordinates while every click lands on a different set of nodes.
func validate_btn(btn_name):
	if !active_btns.has(btn_name) or !is_instance_valid(active_btns[btn_name]):
		activate_btn(btn_name)
		return
	var btns = get_btns()
	if !btns.has(btn_name) or btns[btn_name].get_btn_func == null:
		return
	var source = btns[btn_name].source.get_ref()
	if source == null or !is_instance_valid(source):
		return
	var current = source.call(btns[btn_name].get_btn_func)
	#a panel caught mid-rebuild answers with nothing; the one already in hand is the better
	#guess until it does
	if current == null or !is_instance_valid(current) or current == active_btns[btn_name]:
		return
	active_btns[btn_name] = current
	relisten_btn(btn_name, current)


#The listening half of activate_btn, on its own so a button that was replaced under the step
#can be picked up again without re-running the resolution that already found it. Steps that
#name a button only to frame it (dont_listen) are left alone here as well.
func relisten_btn(btn_name, node):
	if cur_dont_listen != null and btn_name in cur_dont_listen:
		return
	set_listener(node, get_btns_signal(btn_name), "btn_truly_pressed")

func get_true_rect(btn_name):
	var btns = get_btns()
	if !btns.has(btn_name):
		return Rect2()
	var btn_info = btns[btn_name]
	if btn_info.has('rect_obj'):
		var rect_source = btn_info.rect_obj.get_ref()
		if rect_source == null or !is_instance_valid(rect_source):
			return Rect2()
		var custom_rect = rect_source.call(btn_info.rect_func)
		return custom_rect if custom_rect != null else Rect2()
	var node = active_btns.get(btn_name)
	#a screen that rebuilt its buttons handed us a node that no longer exists - ask again where
	#that button is now rather than framing thin air
	if node == null or !is_instance_valid(node):
		var source = btn_info.source.get_ref()
		if source == null or !is_instance_valid(source):
			return Rect2()
		node = source.call(btn_info.get_btn_func)
		active_btns[btn_name] = node
		#and listen to the button that is there now. The old one was connected before the
		#panel rebuilt itself, and this is the only place that notices it went: validate_btn
		#re-activates a *missing* entry, and filling this one in silently would leave a step
		#framing a live button that no longer carries it forward - the click lands, the game
		#does the thing, and the tutorial sits there.
		if node != null and is_instance_valid(node):
			relisten_btn(btn_name, node)
	if node == null or !is_instance_valid(node):
		return Rect2()
	var true_rect = node.get_global_rect()
	true_rect.size *= node.get_global_transform().get_scale()
	return true_rect

func get_btns_signal(btn_name):
	var btns = get_btns()
	if btns[btn_name].has('conf_signal'):
		return btns[btn_name].conf_signal
	else:
		return 'pressed'

func btn_truly_pressed():
	var step_info = tutorials[cur_tut][cur_step]
	if step_info.has('condition_func'):
		if !self.call(step_info.condition_func):
			return
	if step_info.has('additional_func'):
		self.call(step_info.additional_func)
	free_listeners()
	active_btns.clear()
	tut_panel.highlight_off()
	yield(input_handler.get_tree(), 'idle_frame')#buttens can be rearranged after activation
	next_tut_step()

func is_action_pass(btn_name, action):
	if is_tut_active():
		var step_info = tutorials[cur_tut][cur_step]
		if (step_info.has('block_event')
				and step_info.block_event.has(btn_name)
				and action in step_info.block_event[btn_name]):
			return false
	return true


#A button named by the step only to be barred for the length of it. Different from block_event,
#which merely declines to open the gate: a click is let through when *any* framed button covers
#it, so a small button sitting inside a framed one could never be stopped that way. A ban wins
#over every other rect covering the same point.
func is_btn_banned(btn_name):
	if !is_tut_active():
		return false
	var step_info = tutorials[cur_tut][cur_step]
	if !step_info.has('ban_buttons') or !(btn_name in step_info.ban_buttons):
		return false
	#And only while it is really on screen. A hidden panel keeps the rect the scene shipped it
	#with, and vetoing on that would swallow clicks meant for whatever is drawn there instead.
	var node = active_btns.get(btn_name)
	if node == null or !is_instance_valid(node):
		return false
	if node is CanvasItem and !node.is_visible_in_tree():
		return false
	return true


func start_tutorial(tut_name):
	cur_tut = tut_name
	cur_step = -1
	btn_truly_pressed()

func stop_tut():
	cur_tut = null
	cur_step = -1
	active_btns.clear()
	tut_panel.close_panel()

func next_tut_step():
	cur_step += 1
	if tutorials[cur_tut].size() <= cur_step:
		for i in range(tutorial_sequence.size()-1):
			if tutorial_sequence[i] == cur_tut:
#				stop_tut()
				start_tutorial(tutorial_sequence[i+1])
				return
		abort_tutorial()
		return
	var step_info = tutorials[cur_tut][cur_step]
	active_btns.clear()
	if step_info.has('delay'):
		yield(input_handler.get_tree().create_timer(step_info.delay), "timeout")
	if step_info.has('dont_listen'):#strictly befor activate_btn()!
		cur_dont_listen = step_info.dont_listen
	else:
		cur_dont_listen = null
	#Also strictly before activate_btn(). What a tut_func does is put the screen the way this
	#step needs it - fold the household list away so the strip of portraits underneath is on
	#screen, raise the scaffolding the step is about. Run afterwards, the step went looking for
	#its button on the screen it was about to change, found nothing, and drew no frame at all.
	if step_info.has("tut_func"):
		self.call(step_info.tut_func)
	var has_custom_highlight = step_info.has('highlight')
	var has_no_highlight = step_info.has('no_highlight')
	var btns_to_activate = step_info.buttons
	var waits_for_next_btn = btns_to_activate.empty()
	if waits_for_next_btn:
		btns_to_activate = ["tut_panel_next"]
		#the panel has not moved to its step position yet, so this one is framed after show_tut
		has_no_highlight = true
		tut_panel.next_btn_on()
	else:
		tut_panel.next_btn_off()
	for btn_name in btns_to_activate:
		if !activate_btn(btn_name):
			continue
		if !has_custom_highlight and !has_no_highlight:
			tut_panel.follow_rects(self, [btn_name])
	if has_custom_highlight:
		tut_panel.follow_rects(self, step_info.highlight)
	elif has_no_highlight:
		tut_panel.stop_following()
	if step_info.has('text'):
		tut_panel.show_tut(tr(step_info.text), step_info.panel_pos)
	else:
		tut_panel.hide_text()
	if step_info.has('listen'):
		for sig_btn_name in step_info.listen:
			set_listener(get_btns()[sig_btn_name].source.get_ref(), get_btns_signal(sig_btn_name), "btn_truly_pressed")
	if waits_for_next_btn and step_info.has('text'):
		#the button lives inside the text panel, so its rect is only final one layout pass
		#after the panel was moved to this step's position
		yield(input_handler.get_tree(), 'idle_frame')
		if cur_step >= 0 and is_instance_valid(tut_panel):
			tut_panel.highlight_next_btn(get_true_rect("tut_panel_next"))

#in-tutorial funcs
func add_combat_reward_char():
	var newslave = ResourceScripts.scriptdict.class_slave.new("random_combat")
	newslave.generate_random_character_from_data('random', null, 1)
	newslave.is_active = true
#	newslave.set_slave_category('servant')
	input_handler.combat_node.set_external_reward_chars([newslave.id])

func check_turn_master():
	return input_handler.combat_node.get_current_actor().is_master()
func check_turn_servent():
	return input_handler.combat_node.get_current_actor().get_stat('unique') == 'tutorial_servant'

func check_travel_select():
	return (active_btns['travel_master'].pressed and active_btns['travel_servant'].pressed)

#--------------

func tutorial_menu():
	if tut_menu == null:
		tut_menu = input_handler.get_spec_node(input_handler.NODE_HARD_TUTORIAL_LIST)
	tut_menu.raise()
	tut_menu.show()
	temp_active_btns = active_btns.duplicate()
	temp_cur_dont_listen = cur_dont_listen
	active_btns.clear()
	free_listeners()
	var menu_btns = ['tut_menu_yes', 'tut_menu_no', "tut_menu_training", "tut_menu_work",
		"tut_menu_leveling", "tut_menu_quest", "tut_menu_abort", "tut_menu_back"]
	cur_dont_listen = menu_btns
	for btn in menu_btns:
		activate_btn(btn)

func abort_tutorial():
	stop_tut()
	yield(prepare_save_exit(), "completed")
	globals.return_to_main_menu()
	input_handler.deactivate_hard_tutorial()

func on_tutorial_menu_hide(got_back = false):
	active_btns.clear()
	free_listeners()
	cur_dont_listen = null
	if temp_active_btns != null and got_back:
		cur_dont_listen = temp_cur_dont_listen
		for btn in temp_active_btns:
			activate_btn(btn)
	temp_active_btns = null
	temp_cur_dont_listen = null
	

func can_open_menu():
	if tut_menu != null and tut_menu.visible:
		return false
	if ("alert_panel_yes" in active_btns.keys()
			or "alert_panel_no" in active_btns.keys()):
		return false
	return true

#tutorial prepare funcs
func prepare_general_tut():
	globals.common_effects([{code = 'make_story_character', value = 'tutorial_master'}])
	var character = ResourceScripts.game_party.get_unique_slave('tutorial_master')
	globals.equip_char(character, 'club', {WeaponMace = 'wood'})
	globals.equip_char(character, 'chest_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
	globals.equip_char(character, 'legs_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
	character.xp_module.base_exp = 150
	character.add_trait('literacy')
	globals.common_effects([{code = 'make_story_character', value = 'tutorial_servant'}])
	character = ResourceScripts.game_party.get_unique_slave('tutorial_servant')
	globals.equip_char(character, 'staff', 't1')
	globals.equip_char(character, 'chest_base_cloth', 't1')
	globals.equip_char(character, 'legs_base_cloth', 't1')
	#The rooms chapter puts her on the kitchen garden, and a servant counts as one of the
	#household's workers only once she has been trained to work - is_worker() reads that off
	#the trait's 'worker' tag. Without it the garden refuses her and the step she belongs to
	#could never be finished.
	character.add_trait('training_s_working')
	globals.common_effects([{code = 'make_story_character', value = 'Daisy'}])
	character = ResourceScripts.game_party.get_unique_slave('daisy')
	character.remove_trait('training_obedience')
	character.add_trait('untrained')#Rebellious
	character.training.acquired_turn = -1 #tutorial trains her right away, skip the settling in block
	character.add_stat('loyalty', 99)
	character.add_stat('training_points', 40)
	character.set_brothel_rule('waitress', false)
	ResourceScripts.game_res.money = 800
	#enough to raise a kitchen (wood 70, stone 30) and still have something in hand, which is
	#what the rooms chapter spends them on
	ResourceScripts.game_res.materials['wood'] = 140
	ResourceScripts.game_res.materials['stone'] = 90
	ResourceScripts.game_res.materials['iron'] = 20
	ResourceScripts.game_res.materials['meat'] = 20
	ResourceScripts.game_res.materials['fish'] = 20
	ResourceScripts.game_res.materials['bread'] = 20
	ResourceScripts.game_res.materials['vegetables'] = 20
	ResourceScripts.game_res.materials['grain'] = 20
	globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll", 1))
#	var has_tut_quest = false
#	for quest_id in ResourceScripts.game_world.areas['plains'].quests.factions['workers']:
#		if ResourceScripts.game_world.areas['plains'].quests.factions['workers'][quest_id].code == 'workers_threat_easy':
#			has_tut_quest = true
#			break
#	if !has_tut_quest:
	var newquest = ResourceScripts.world_gen.make_quest('tutorial_threat_easy', {
		source = 'workers', area = 'plains',
		travel_time = 1, difficulty = 'easy'
	})
	ResourceScripts.game_world.areas[newquest.area].quests.factions[newquest.source][newquest.id] = newquest
	
	prepare_mansion_for_tut()
	gui_controller.mansion.try_rebuild_slave_list()
	gui_controller.mansion.mansion_state_set("default")


#What the rooms chapter needs standing before it opens. The estate itself is the lesson now,
#so the tutorial has to be sure of the room it is going to point at and of what is already
#out on the grounds.
func prepare_mansion_for_tut():
	#Also where the three of them get their beds: this runs after the story characters are
	#made, and autohouse_household() inside it is what keeps the chapter's Finish Turn steps
	#from being refused for somebody having nowhere to sleep.
	ResourceScripts.game_res.ensure_mansion_layout()
	var layout = ResourceScripts.game_res.mansion_layout
	var slot = MansionLayout.get_slot(MansionLayout.get_floor(layout, TUTORIAL_FLOOR), TUTORIAL_SLOT)
	if slot != null:
		#It has to still be under rubble whatever a loaded save or a reshuffled plan did with
		#it, and it must not be one of the rooms hiding a find: a find opens its own event and
		#then the loot window, neither of which is a registered tutorial button - every click
		#on them would be swallowed and the chapter would stop dead. The finds in the other
		#derelict rooms are left where the shuffle put them.
		slot.broken = true
		slot.room = null
		slot.build = null
		slot.find = null
	#The gathering lesson is about manning work that already exists, so the kitchen garden is
	#standing before the chapter opens rather than raised during it.
	var grounds = MansionLayout.grounds_floor(layout)
	if grounds >= 0 and MansionLayout.get_room(MansionLayout.get_floor(layout, grounds), TUTORIAL_PLOT) == null:
		MansionLayout.build_room(layout, grounds, TUTORIAL_PLOT, 'garden')
	ResourceScripts.game_res.sync_room_tasks()
	ResourceScripts.game_res.rooms_changed()

func prepare_combat_tut():
	var character = ResourceScripts.game_party.get_unique_slave('tutorial_master')
	character.unlock_class("fighter")
	character.upgrade_mastery('leadership', true)

func prepare_work_tut():
	var master_ch = ResourceScripts.game_party.get_unique_slave('tutorial_master')
	var character = ResourceScripts.game_party.get_unique_slave('daisy')
	master_ch.add_trainee(character.id)
	

#---------------------

func set_listener(source, sig, fun):
	if source.is_connected(sig, self, fun):
		return
	source.connect(sig, self, fun)
	listeners.append({source = source, sig = sig, fun = fun})

func free_listeners():
	for listener in listeners:
		if (listener.source != null
				and is_instance_valid(listener.source)
				and listener.source.is_connected(listener.sig, self, listener.fun)):
			listener.source.disconnect(listener.sig, self, listener.fun)
	listeners.clear()

func prepare_tutorial(tut_name):
	if !input_handler.globalsettings.tutorial_prompt_seen:
		input_handler.globalsettings.tutorial_prompt_seen = true
	if input_handler.CurrentScene.name == "MansionMainModule":#should remake it somehow
		yield(prepare_save_exit(), "completed")
		globals.preexit_clear_up()
	ResourceScripts.game_world.make_world()
	ResourceScripts.game_globals.original_version = globals.gameversion
	ResourceScripts.game_progress.intro_tutorial_seen = true
#	get_node("/root").remove_child(self)
	input_handler.ChangeScene('mansion')
	yield(globals, 'scene_changed')
	gui_controller.windows_opened.clear()
#	self.queue_free()
	
	if prepare_tutorial_funcs.has(tut_name):
		for prepare_func in prepare_tutorial_funcs[tut_name]:
			call(prepare_func)
	start_tutorial(tut_name)

func is_tut_active():
	return cur_tut != null

func is_RMB_pass():
	if is_tut_active():
		var step_info = tutorials[cur_tut][cur_step]
		if step_info.has('pass_RMB'):
			return step_info.pass_RMB
	return false

#additional funcs
#The idle strip is the lower half of the slave list's bar, and an unfolded list takes the
#whole column: MansionSlaveListModule.set_slave_list_fold() hides the mansion's HUD outright
#while the list is open. Every step that picks somebody up needs the strip on screen, and the
#list is deliberately forced open while a hard tutorial runs (apply_default_fold), so this has
#to be asked for rather than assumed.
#Not remembered: which way the player likes their list is their own setting, and a scripted
#lesson has no business rewriting it.
func fold_slave_list():
	set_slave_list_folded(true)


#The other half of fold_slave_list. The mansion opens on the list and apply_state_fold() leaves
#the fold alone while a tutorial runs - so nothing puts it back on its own, and the rooms
#chapter has to hand it over the way it found it.
func unfold_slave_list():
	set_slave_list_folded(false)


func set_slave_list_folded(folded):
	if gui_controller.mansion == null or !is_instance_valid(gui_controller.mansion):
		return
	var list = gui_controller.mansion.SlaveListModule
	if list == null:
		return
	var wanted = list.FOLD_FOLDED if folded else list.FOLD_FULL
	if list.list_fold_state == wanted:
		return
	list.set_slave_list_fold(wanted, false)


#The scaffolding on the tutorial's own slot, put within one turn of finished. A kitchen is 25
#work units and one builder is worth a few of them a turn, so raising it honestly is five to
#ten turns - too long to sit through here. Clearing out is not touched: that job is measured
#in turns rather than in work and takes two of them, which is itself the lesson.
func rush_current_build():
	var build = MansionLayout.get_build(
		MansionLayout.get_floor(ResourceScripts.game_res.mansion_layout, TUTORIAL_FLOOR),
		TUTORIAL_SLOT)
	if build == null or build.get('fixed', false):
		return
	build.progress = max(float(build.progress), float(build.limit) - 0.5)
	if gui_controller.mansion != null and is_instance_valid(gui_controller.mansion):
		gui_controller.mansion.RoomsModule.refresh()


func close_expanded_card():
	if gui_controller.mansion == null or !is_instance_valid(gui_controller.mansion):
		return
	gui_controller.mansion.SlaveListModule.close_expanded_character()


#The menu a right click on a portrait puts up. It is a popup, so it would go away on its own
#with the next click - but the step it belongs to can also be ended from the panel's own button,
#and that click is taken by the popup rather than reaching anything of ours. Put away by hand so
#the lesson never carries on with it still hanging over the screen. Both menus are asked: the
#strip's and the household list's, which is the same gesture on the other set of portraits.
func close_char_context_menu():
	if gui_controller.mansion == null or !is_instance_valid(gui_controller.mansion):
		return
	for menu in [gui_controller.mansion.RoomsModule.get_node_or_null("Overlay/CharMenu"),
			gui_controller.mansion.SlaveListModule.get_node_or_null("CharacterContextMenu")]:
		if menu != null and is_instance_valid(menu):
			menu.hide()


#What the beds lesson needs standing before it opens. Two things the rooms chapter left the
#other way round: the strip of portraits is under the slave list, which the crafting steps put
#back up, and there is nobody to house - the estate seats every arrival itself, so a tutorial
#household is always fully bedded. Daisy gives her bed up for the length of the lesson and
#takes it straight back at the end of it; being without one costs a night's rest and nothing
#else (game_res.mark_slept_rough), and the chapter has no turn left to end.
func open_bed_lesson():
	set_slave_list_folded(true)
	var character = ResourceScripts.game_party.get_unique_slave('daisy')
	if character == null:
		return
	ResourceScripts.game_res.unhouse_character(character.id)
	if gui_controller.mansion != null and is_instance_valid(gui_controller.mansion):
		gui_controller.mansion.RoomsModule.refresh()


func stop_use_state():
	if gui_controller.exploration != null:
		gui_controller.exploration.try_stop_use_state()
#--------------


func prepare_save_exit():
	yield(input_handler.get_tree(), "idle_frame")
	if input_handler.event_is_active:
		gui_controller.dialogue.close()
		yield(input_handler, "EventFinished")
	if input_handler.combat_node != null:
		input_handler.combat_node.run()
		yield(input_handler.combat_node, "combat_cleaned_up")

func is_mass_select_banned():
	var step_info = tutorials[cur_tut][cur_step]
	return step_info.has("ban_mass_select")

