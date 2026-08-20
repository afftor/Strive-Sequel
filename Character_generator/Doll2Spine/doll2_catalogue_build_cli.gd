extends SceneTree

# Command-line entry point for the catalogue build, for use without the editor:
#
#   godot --path <project> -s res://Character_generator/Doll2Spine/doll2_catalogue_build_cli.gd
#
# Every doll in doll2_dolls.gd is built, because they share the shared overrides
# and a change there has to be checked against both exports.  Name one to build
# only that one: `--doll male`.
#
# Flags: --update-contract rewrites the contract files, --dry-run runs the
# validation and prints the report without touching any file.
# Exits with 1 when a report contains problems, so it can gate a re-export.

const BUILDER = preload("res://Character_generator/Doll2Spine/doll2_catalogue_builder.gd")
const DOLLS = preload("res://Character_generator/Doll2Spine/doll2_dolls.gd")


func _initialize():
	var options = {}
	var only = ""
	var arguments = OS.get_cmdline_args()
	for index in range(arguments.size()):
		var argument = arguments[index]
		if argument == "--update-contract":
			options["update_contract"] = true
		elif argument == "--dry-run":
			options["dry_run"] = true
		elif argument == "--doll" and index + 1 < arguments.size():
			only = arguments[index + 1]
	var ok = true
	for doll_id in DOLLS.ORDER:
		if only != "" and only != doll_id:
			continue
		var doll = DOLLS.DOLLS[doll_id]
		var doll_options = options.duplicate()
		doll_options["overrides"] = doll.overrides
		doll_options["json_path"] = doll.json
		doll_options["atlas_path"] = doll.atlas
		doll_options["gen_path"] = doll.gen_path
		doll_options["contract_path"] = doll.contract_path
		doll_options["contract_id"] = doll.contract_id
		print("========== %s ==========" % doll_id.to_upper())
		var result = BUILDER.new().build(doll_options)
		print(result.report)
		ok = ok and result.ok
	quit(0 if ok else 1)
