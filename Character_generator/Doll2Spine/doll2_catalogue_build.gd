tool
extends EditorScript

# Rebuilds every doll's catalogue from its Spine export and its overrides.
# Open this file in the script editor and run it with File > Run (Ctrl+Shift+X).
# The full validation report is printed to Output and copied to
# user://doll2_catalogue_report.txt.
#
# Set UPDATE_CONTRACT to true only when a new export is meant to redefine a
# skeleton contract in universal/.  Leave it false so a changed bone or slot list
# is reported as drift instead of silently accepted.

const BUILDER = preload("res://Character_generator/Doll2Spine/doll2_catalogue_builder.gd")
const DOLLS = preload("res://Character_generator/Doll2Spine/doll2_dolls.gd")
const UPDATE_CONTRACT = false


func _run():
	for doll_id in DOLLS.ORDER:
		var doll = DOLLS.DOLLS[doll_id]
		print("========== %s ==========" % doll_id.to_upper())
		var result = BUILDER.new().build({
			"update_contract": UPDATE_CONTRACT,
			"overrides": doll.overrides,
			"json_path": doll.json,
			"atlas_path": doll.atlas,
			"gen_path": doll.gen_path,
			"contract_path": doll.contract_path,
			"contract_id": doll.contract_id,
		})
		print(result.report)
		if !result.ok:
			push_warning("Doll2 catalogue (%s): the build reported problems, see Output." % doll_id)
