extends Reference

# Every Doll 2 skeleton the project ships.
#
# A doll is a Spine export plus the three files that give it meaning: the
# overrides it is built from, the catalogue that build produced, and the skeleton
# contract everything in universal/ is keyed to.  Nothing else in the codebase
# names an export file, so adding a third doll is an entry here plus a build.
#
# The male and female rigs are not interchangeable - 231 of their bones match,
# but the male renames the collarbones and the thighs and has no breast chain -
# so they carry different contract ids and poses written for one can never be
# applied to the other by accident.

const BASE = "res://Character_generator/Doll2Spine/"

const DOLLS = {
	"female": {
		"label": "DOLL2_PREVIEW_DOLL_FEMALE",
		"json": BASE + "Doll2_spine4.2_female.json",
		"atlas": BASE + "Doll2_spine4.2_female.atlas",
		"pages": {
			"Doll2_spine4.2_female.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_female.png"),
			"Doll2_spine4.2_female_2.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_female_2.png"),
			"Doll2_spine4.2_female_3.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_female_3.png"),
		},
		"overrides": preload("res://Character_generator/Doll2Spine/doll2_overrides.gd"),
		"catalogue": preload("res://Character_generator/Doll2Spine/doll2_catalogue_gen.gd"),
		"contract": preload("res://Character_generator/Doll2Spine/universal/doll_contract.gd"),
		"contract_id": "doll2_v1",
		"default_animation": "idle1",
		"gen_path": BASE + "doll2_catalogue_gen.gd",
		"contract_path": BASE + "universal/doll_contract.gd",
	},
	"male": {
		"label": "DOLL2_PREVIEW_DOLL_MALE",
		"json": BASE + "Doll2_spine4.2_male.json",
		"atlas": BASE + "Doll2_spine4.2_male.atlas",
		"pages": {
			"Doll2_spine4.2_male.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_male.png"),
			"Doll2_spine4.2_male_2.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_male_2.png"),
			"Doll2_spine4.2_male_3.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_male_3.png"),
		},
		"overrides": preload("res://Character_generator/Doll2Spine/doll2_overrides_male.gd"),
		"catalogue": preload("res://Character_generator/Doll2Spine/doll2_catalogue_gen_male.gd"),
		"contract": preload("res://Character_generator/Doll2Spine/universal/doll_contract_male.gd"),
		"contract_id": "doll2_male_v1",
		"default_animation": "idle2",
		"gen_path": BASE + "doll2_catalogue_gen_male.gd",
		"contract_path": BASE + "universal/doll_contract_male.gd",
	},
}

const ORDER = ["female", "male"]
const DEFAULT_DOLL = "female"


static func doll(doll_id):
	return DOLLS.get(doll_id, DOLLS[DEFAULT_DOLL])
