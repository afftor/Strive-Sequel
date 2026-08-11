extends Node
#Scripted run of a test combat, so animations can be checked without anybody
#driving the game by hand. Started from the command line:
#
#   Godot.exe --path . --anim-plan C:/tmp/plan.json
#
#The plan is JSON and lives outside the project:
#
#   {
#     "group": "bandits",        # enemy group code, optional
#     "level": 4,                # 1..4, optional
#     "settle": 3.0,             # extra seconds of trace after the last step
#     "steps": [
#       {"caster": 2, "target": 10, "skill": "execution", "wait": 4.0}
#     ]
#   }
#
#It forces the sandbox and the trace on, so nothing dies, no turn is spent, and
#every frame lands in stdout. Without the argument this script does nothing.

const ARG = '--anim-plan'
const BOOT_TIMEOUT = 30.0

var plan = null


static func plan_path():
	var args = OS.get_cmdline_args()
	for i in range(args.size()):
		var a = args[i]
		if a == ARG and i + 1 < args.size():
			return args[i + 1]
		if a.begins_with(ARG + '='):
			return a.substr(ARG.length() + 1)
	return null


func setup(path):
	var file = File.new()
	if file.open(path, File.READ) != OK:
		print('[autopilot] cannot open plan: %s' % path)
		return false
	var parsed = JSON.parse(file.get_as_text())
	file.close()
	if parsed.error != OK or !(parsed.result is Dictionary):
		print('[autopilot] plan is not valid JSON: %s' % path)
		return false
	plan = parsed.result
	variables.anim_sandbox = true
	variables.anim_trace = true
	print('[autopilot] plan loaded: %s' % path)
	call_deferred('run')
	return true


func wait(seconds):
	yield(get_tree().create_timer(seconds), 'timeout')


#Poll until the check passes, or give up. Always yields at least once: a function
#that returns without ever yielding is not a coroutine, and yield(...,'completed')
#on its plain return value fails.
func wait_for(object, method, timeout = BOOT_TIMEOUT):
	var spent = 0.0
	while spent < timeout:
		yield(get_tree().create_timer(0.1), 'timeout')
		spent += 0.1
		if call(method, object): return true
	print('[autopilot] timed out waiting for %s' % method)
	return false


func has_combat(_ignored):
	return input_handler.combat_node != null


func has_actor(_ignored):
	var combat = input_handler.combat_node
	return combat != null and combat.activecharacter != null


func idle(_ignored):
	var combat = input_handler.combat_node
	if combat == null: return true
	if combat.ActionQueue == null: return true
	return combat.ActionQueue.is_empty()


func run():
	#Let the main menu finish booting first. Swapping the scene out from under a
	#_ready() that is still mid-yield kills it halfway through.
	yield(wait(2.0), 'completed')
	get_tree().change_scene('res://test_combat.tscn')
	yield(wait(0.5), 'completed')

	var scene = get_tree().current_scene
	if scene == null or !scene.has_node('selector'):
		print('[autopilot] test_combat did not load')
		get_tree().quit()
		return

	if plan.has('group'):
		var picker = scene.get_node('selector')
		for i in range(picker.get_item_count()):
			if picker.get_item_text(i) == plan.group:
				picker.selected = i
				break
	if plan.has('level'):
		scene.get_node('selector2').selected = int(plan.level) - 1
	scene.get_node('sandbox').pressed = true
	scene.get_node('trace').pressed = true

	print('[autopilot] starting combat')
	scene.run_test()

	#run_test stops at the position-select screen, which normally waits for the
	#player to press confirm. Press it.
	yield(wait(0.5), 'completed')
	var picker = get_tree().get_root().get_node_or_null('combatpositions')
	if picker == null:
		print('[autopilot] position select did not open')
		get_tree().quit()
		return
	picker.on_confirm()

	if !(yield(wait_for(self, 'has_combat'), 'completed')):
		get_tree().quit()
		return
	if !(yield(wait_for(self, 'has_actor'), 'completed')):
		get_tree().quit()
		return
	yield(wait(1.0), 'completed')
	report_roster(input_handler.combat_node)

	var steps = plan.steps if plan.has('steps') else []
	for step in steps:
		yield(play_step(step), 'completed')

	yield(wait(float(plan.settle) if plan.has('settle') else 2.0), 'completed')
	print('[autopilot] done')
	get_tree().quit()


#Save the rendered frame. This is the only way to actually look at an animation
#without a person watching: the numbers in the trace say where a card is, not
#what the effect looks like.
func capture(path):
	yield(VisualServer, 'frame_post_draw')
	var tex = get_viewport().get_texture()
	if tex == null: return
	var img = tex.get_data()
	if img == null:
		print('[autopilot] no frame data')
		return
	img.flip_y()
	var err = img.save_png(path)
	print('[autopilot] shot %s%s' % [path, '' if err == OK else ' FAILED %d' % err])


func first_on_other_side(combat, cpos):
	var range_start = 7 if cpos < 7 else 1
	for pos in range(range_start, range_start + 6):
		var ch = combat.get_char_by_pos(pos)
		if ch != null and !ch.defeated: return ch
	return null


func report_roster(combat):
	var names = []
	for pos in range(1, 13):
		var ch = combat.get_char_by_pos(pos)
		if ch != null: names.push_back('%d:%s' % [pos, ch.get_short_name()])
	print('[autopilot] roster %s' % PoolStringArray(names).join('  '))


func play_step(step):
	var combat = input_handler.combat_node
	var cpos = int(step.caster) if step.has('caster') else 1
	var tpos = int(step.target) if step.has('target') else 7
	var caster = combat.get_char_by_pos(cpos)
	if caster == null:
		print('[autopilot] no fighter at caster position %d' % cpos)
		return
	var target = combat.get_char_by_pos(tpos)
	if target == null:
		#rosters are rolled per run, so a fixed position can come up empty
		target = first_on_other_side(combat, cpos)
		if target != null:
			print('[autopilot] position %d empty, targeting %s at %d'
				% [tpos, target.get_short_name(), target.position])
	if target == null: target = caster

	#same handover the sandbox panel does: the turn belongs to whoever casts
	combat.currentactor = cpos
	combat.activecharacter = caster
	var code = str(step.skill)
	if !Skilldata.Skilllist.has(code):
		print('[autopilot] unknown skill %s' % code)
		return
	var template = Skilldata.get_template_combat(code, caster)
	combat.UpdateSkillTargets(caster, template, true)
	print('[autopilot] cast %s: %s -> %s' % [code, caster.get_short_name(), target.get_short_name()])
	combat.use_skill(code, caster, target)

	if step.has('shots') and step.has('shot_dir'):
		var count = int(step.shots)
		var gap = float(step.shot_interval) if step.has('shot_interval') else 0.10
		var lead = float(step.shot_lead) if step.has('shot_lead') else 0.0
		if lead > 0: yield(wait(lead), 'completed')
		for i in range(count):
			yield(wait(gap), 'completed')
			yield(capture('%s/shot_%02d.png' % [str(step.shot_dir), i]), 'completed')

	yield(wait(float(step.wait) if step.has('wait') else 4.0), 'completed')
	#the queue can outlive the wait on long skills
	yield(wait_for(self, 'idle', 10.0), 'completed')
