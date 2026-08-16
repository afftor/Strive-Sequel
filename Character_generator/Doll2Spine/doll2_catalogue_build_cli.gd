extends SceneTree

# Command-line entry point for the catalogue build, for use without the editor:
#
#   godot --path <project> -s res://Character_generator/Doll2Spine/doll2_catalogue_build_cli.gd
#
# Flags: --update-contract rewrites universal/doll_contract.gd, --dry-run runs
# the validation and prints the report without touching any file.
# Exits with 1 when the report contains problems, so it can gate a re-export.

const BUILDER = preload("res://Character_generator/Doll2Spine/doll2_catalogue_builder.gd")


func _initialize():
	var options = {}
	for argument in OS.get_cmdline_args():
		if argument == "--update-contract":
			options["update_contract"] = true
		elif argument == "--dry-run":
			options["dry_run"] = true
	var result = BUILDER.new().build(options)
	print(result.report)
	quit(0 if result.ok else 1)
