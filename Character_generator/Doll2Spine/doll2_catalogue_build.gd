tool
extends EditorScript

# Rebuilds doll2_catalogue_gen.gd from the Spine export and doll2_overrides.gd.
# Open this file in the script editor and run it with File > Run (Ctrl+Shift+X).
# The full validation report is printed to Output and copied to
# user://doll2_catalogue_report.txt.
#
# Set UPDATE_CONTRACT to true only when a new export is meant to redefine the
# skeleton contract in universal/doll_contract.gd.  Leave it false so a changed
# bone or slot list is reported as drift instead of silently accepted.

const BUILDER = preload("res://Character_generator/Doll2Spine/doll2_catalogue_builder.gd")
const UPDATE_CONTRACT = false


func _run():
	var result = BUILDER.new().build({"update_contract": UPDATE_CONTRACT})
	print(result.report)
	if !result.ok:
		push_warning("Doll2 catalogue: the build reported problems, see Output.")
