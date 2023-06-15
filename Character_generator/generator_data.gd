extends Node

var stats_to_look = [
'sex', 'race',
'horns', 'ears', 'eyeshape', 'eye_tex', 'eye_color', 'eyebrows', 'lips', 'wings', 'tail', 'penis_type', 'chin', 'nose', 'pregnancy_status', 'tits_size', 
'body_color_skin', 'skin_coverage', 
'body_color_wings','body_color_tail', 'body_color_horns', 'body_color_animal',
'hair_base', 'hair_assist', 
'hair_back', 
'hair_base_color_1', 'hair_back_color_1', 'hair_assist_color_1', 'hair_base_color_2', 
'hair_back_color_2', 'hair_assist_color_2', 'hair_base_lenght', 'hair_back_lenght', 'hair_assist_lenght',
'height'
]


var itemparts = {}


var texture_sets = {
	default_male = [
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/01_body_nude_male/HandR1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/01_body_nude_male/ArmR1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/01_body_nude_male/ShoulderR_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/01_body_nude_male/HandL1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_tex', texture = "res://Character_generator/images/01_body_nude_male/ArmL1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_tex', texture = "res://Character_generator/images/01_body_nude_male/ShoulderL_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_tex2', texture = "res://Character_generator/images/01_body_nude_male/torso_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_tex', texture = "res://Character_generator/images/01_body_nude_male/LegL_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_tex', texture = "res://Character_generator/images/01_body_nude_male/LegR_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_tex', texture = "res://Character_generator/images/01_body_nude_male/taz_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_human_up.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_human.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_normal.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/01_heads/head_skull.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_male.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face_m4.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_default.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_human.png" },
	],
	beastkin_male = [
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/HandR1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ArmR1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ShoulderR_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/HandL1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ArmL1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ShoulderL_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_tex2', texture = "res://Character_generator/images/15_beastkin_body_nude_male/torso_bestkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/LegL_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/LegR_bestkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/taz_beastkin_m.png"}, 
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_mesh', texture = null},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face_m4.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = null},
	],
	default_female = [
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/00_body_nude/HandR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/00_body_nude/ArmR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/00_body_nude/ShoulderR.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/00_body_nude/HandL1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_tex', texture = "res://Character_generator/images/00_body_nude/ArmL1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_tex', texture = "res://Character_generator/images/00_body_nude/ShoulderL.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_tex2', texture = "res://Character_generator/images/00_body_nude/torso.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_tex', texture = "res://Character_generator/images/00_body_nude/LegL.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_tex', texture = "res://Character_generator/images/00_body_nude/LegR.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_tex', texture = "res://Character_generator/images/00_body_nude/taz.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_human_up.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_human.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/01_heads/head_skull.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_default.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_default.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_human.png" },
		
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Belly_default_tex', texture = "res://Character_generator/images/00_body_nude/default_belly.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex', texture = "res://Character_generator/images/00_body_nude/pregnancy_belly_mid.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex2', texture = "res://Character_generator/images/00_body_nude/pregnancy_belly_big.png"},
		
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Nipples_mesh', texture = "res://Character_generator/images/00_body_nude/tits_nipples_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_normal.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Nipples_mesh', texture = "res://Character_generator/images/00_body_nude/tits_nipples_normal.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_small.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Nipples_mesh', texture = "res://Character_generator/images/00_body_nude/tits_nipples_small.png"},
	],
	beastkin_female = [
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_ArmR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_ShoulderR.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandL1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_ArmL1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_ShoulderL.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_tex2', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_torso1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_LegL1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_LegR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_taz1.png"}, #or 2
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face4.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Belly_default_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_belly1.png"},
		
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_pregnancy_belly_mid1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex2', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_pregnancy_belly_big1.png"},
		
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Nipples_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_nipples_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_normal.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Nipples_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_nipples.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_small.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Nipples_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_nipples_small.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = null},
	],
}

var transforms = {
	cloth = {
		true:[
			{type = 'node_group_attr', group = 'cloth', attr = 'visible', value = true},
		],
		false:[
			{type = 'node_group_attr', group = 'cloth', attr = 'visible', value = false},
		]
	},
	
	sex = {
		male = [
			{type = 'node_group_select', group = 'sex', select = 'male_pose'},
			{type = 'offset', value_x = 0.0, value_y = 30},
		],
		female = [
			{type = 'node_group_select', group = 'sex', select = 'Female_pose'},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false}
		],
		futa = [
			{type = 'node_group_select', group = 'sex', select = 'Female_pose'},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = true}
		],
	},
	
	race = {
		Human = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
		],
		Elf = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
		],
		TribalElf = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
		],
		DarkElf = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
		],
		Orc = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_orc.png" },
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_orc.png" },
		],
		Goblin = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_orc.png" },
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_orc.png" },
		],
		Kobold = [ #horns are set in horns
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'kobold', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/dragon_tail.png"},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_kobold.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/dragon_tail.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_kobold.png"},
		],
		Gnome = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
		],
		Dwarf = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_dwarf.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_dwarf.png"},
		],
		Fairy = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'fairy', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_fairy.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_fairy.png"},
		],
		Dryad = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'dryad', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_over', texture = "res://Character_generator/images/20_dryad/dryad_shoulderR.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_over', texture = "res://Character_generator/images/20_dryad/dryad_shoulderL.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_races', texture = "res://Character_generator/images/20_dryad/dryad_body.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_races_over', texture = "res://Character_generator/images/20_dryad/dryad_legR.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_over', texture = "res://Character_generator/images/20_dryad/dryad_shoulderR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_over', texture = "res://Character_generator/images/20_dryad/dryad_shoulderL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_races', texture = "res://Character_generator/images/20_dryad/dryad_body.png"}, # or not
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_races_over', texture = "res://Character_generator/images/20_dryad/dryad_legR.png"},
		],
		Demon = [ #horns are set in horns
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'demon', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" }, #no demon ears
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_demon.png"},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/wings_demon.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" }, #no demon ears
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_demon.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/wings_demon.png"},
		],
		Seraph = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'fairy', attr = 'visible', value = true}, #the same wings only
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_seraph.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_seraph.png"},
		],
		Dragonkin = [ #horns are set in horns
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'demon', attr = 'visible', value = true}, #the same tail + horns + wings
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" }, 
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon.png"},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_dragon.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" }, 
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_dragon.png"},
		],
		Centaur = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body_alter', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/kentaur_body.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/kentaur_body.png"},
		],
		Harpy = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'hands', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body_alter', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/harpia_body.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/harpia_body.png"},
		],
		#zero support for taurus race
		#half support for harpies - mb no tail, no legs, no ears
		Slime = [ #don't think that shoulder additional parts are positioned correctly
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'dryad', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_over', texture = "res://Character_generator/images/22_slime/slime_armR.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_over', texture = "res://Character_generator/images/22_slime/slime_armL.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_races', texture = "res://Character_generator/images/22_slime/slime_body.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_races', texture = "res://Character_generator/images/22_slime/slime_taz.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_races_over', texture = "res://Character_generator/images/22_slime/slime_legR.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_races_over', texture = "res://Character_generator/images/22_slime/slime_legL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_over', texture = "res://Character_generator/images/22_slime/slime_armR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_over', texture = "res://Character_generator/images/22_slime/slime_armL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_races', texture = "res://Character_generator/images/22_slime/slime_body.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_races', texture = "res://Character_generator/images/22_slime/slime_taz.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_races_over', texture = "res://Character_generator/images/22_slime/slime_legR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_races_over', texture = "res://Character_generator/images/22_slime/slime_legL.png"},
		],
		#male variants of animal low-body have no genitals (or there supposed to be centaurus with it)
		Lamia = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body_alter', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" }, 
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/lamia_body.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_taz', texture = "res://Character_generator/images/14_animals_body/lamia_taz.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" }, 
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/lamia_body.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_taz', texture = "res://Character_generator/images/14_animals_body/lamia_taz.png"},
		],
		Arachna = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = true},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" }, 
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/arachna_body.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_taz', texture =  "res://Character_generator/images/01_body_nude_male/taz_m.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_body_assist', texture = "res://Character_generator/images/14_animals_body/arachna_helicere.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/arachna_body.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_taz', texture = "res://Character_generator/images/14_animals_body/arachna_taz.png" },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_body_assist', texture = "res://Character_generator/images/14_animals_body/arachna_helicere.png"},
		],
		Scylla = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'l_body_alter', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_taz', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body/Animal_body_assist', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/scylla_body.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Animal_body', texture = "res://Character_generator/images/14_animals_body/scylla_body.png"},
		],
		Nereid = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'nereid', attr = 'visible', value = true},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_races', texture = "res://Character_generator/images/21_nereid/nereid_armR.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_races', texture = "res://Character_generator/images/21_nereid/Nereid_armL.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_races', texture = "res://Character_generator/images/21_nereid/nereid_LegR.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_races', texture = "res://Character_generator/images/21_nereid/nereid_LegL.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_races', texture = "res://Character_generator/images/21_nereid/nereid_armR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_races', texture = "res://Character_generator/images/21_nereid/Nereid_armL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_races', texture = "res://Character_generator/images/21_nereid/nereid_LegR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_races', texture = "res://Character_generator/images/21_nereid/nereid_LegL.png"},
		],
		BeastkinCat = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'beastkin_male'},
			{type = 'texture_set', set = 'beastkin_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_cat.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
		],
		BeastkinWolf = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'beastkin_male'},
			{type = 'texture_set', set = 'beastkin_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_wolf.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
		],
		BeastkinFox = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'beastkin_male'},
			{type = 'texture_set', set = 'beastkin_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_fox.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
		],
		BeastkinBunny = [ #move ears to separate dir
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'beastkin_male'},
			{type = 'texture_set', set = 'beastkin_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_rabbit.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_rabbit.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit.png"},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
		],
		BeastkinTanuki = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'beastkin_male'},
			{type = 'texture_set', set = 'beastkin_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_tanuki.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads/beastkin_head_tanuki.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', attr = 'visible', value = true},
		],
		HalfkinCat = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
		],
		HalfkinWolf = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
		],
		HalfkinFox = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
		],
		HalfkinBunny = [ #move ears to separate dir
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
		],
		HalfkinTanuki = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
		],
	},
	
	ears = { #mb fix to match visibility to type, no cow, demon and feathered
		cat = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
		],
		fox = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
		],
		wolf = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
		],
		tanuki = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
		],
		mouse = [#not used
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_mouse.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_mouse.png"},
		],
		bunny = [#not used
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit.png"},
		],
		bunny_standing = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit3.png"},
		],
		bunny_drooping = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit2.png"},
		],
		elven = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
		],
		goblin = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_goblin.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_goblin.png"},
		],
		orc = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_orc.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_orc.png"},
		],
		normal = [ #human
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_human.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_human.png"},
		],
		fish = [ #nereid
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
		],
	},
	
	eye_tex = {
		eyes1 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes1.png" },
		],
		eyes2 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes2.png"},
		],
		eyes3 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes3.png"},
		],
		eyes4 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes4.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes4.png"},
		],
		eyes5 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes5.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes5.png"},
		],
		eyes1m = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m1.png"},
		],
		eyes2m = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m2.png"},
		],
		eyes3m = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m3.png"},
		],
		eyes4m = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m4.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m4.png"},
		],
		eyes5m = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m5.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', texture = "res://Character_generator/images/10_eyes/eyes_m5.png"},
		],
	},
	
	eye_color = { #maybe there should be ids = [1] in every transform
		blue = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_blue.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_blue.tres"},
		],
		cyan = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_bluelight.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_bluelight.tres"},
		],
		brown = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_brown.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_brown.tres"},
		],
		green = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_green.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_green.tres"},
		],
		pink = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_pink.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_pink.tres"},
		],
		purple = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_purple.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_purple.tres"},
		],
		red = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_red.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_red.tres"},
		],
		yellow = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_yellow.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_yellow.tres"},
		],
	},
	
	horns = {
		"": [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = null},
		],
		null: [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = null},
		],
		short = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_top.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_top.png"},
		],
		curved = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_up.png"},
		],
		staright = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_diagonal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_diagonal.png"},
		],
		#stub types
		curved_top = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_top.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_top.png"},
		],
		curved_down = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_down.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_down.png"},
		],
		fibule = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_seraph_fibule.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_seraph_fibule.png"},
		],
		spiral = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral.png"},
		],
		spiral_2 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral 2.png"},
		],
	},
	
	wings = {
		null: [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = null},
		],
		"": [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = null},
		],
		demon = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/wings_demon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/wings_demon.png"},
		],
		dragon = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_dragon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_dragon.png"},
		],
		fairy = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_fairy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_fairy.png"},
		],
		seraph = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_seraph.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_seraph.png"},
		],
	},
	
	tail = { #there is some misplacing for sure
		null: [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = null},
		],
		"": [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = null},
		],
		cat = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
		],
		demon = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_demon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_demon.png"},
		],
		dragon = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon.png"},
		],
		fox = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
		],
		mouse = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_mouse.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_mouse.png"},
		],
		tanuki = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
		],
		wolf = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
		],
		kobold = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/Kobold_tail.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/Kobold_tail.png"},
		],
	},
	
	penis_type = {
		null:[
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = null},
		],
		"":[
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = null},
		],
		human = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_human_up.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_human.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_human_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_human.png"},
		],
		furry = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
		],
		horse = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_horse_up.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_horse.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_horse_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_horse.png"},
		],
	},
	
	pregnancy_status = {
		no = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'visible', value = false}
		],
		early = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex2', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', attr = 'visible', value = false},
		],
		heavy = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/Belly_pregnancy_tex2', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', attr = 'visible', value = true},
		],
	},
	
	tits_size = { #some values may be for backward compat only
		flat = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_zero'},
		],
		small = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_small'},
		],
		average = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_normal'},
			{type = 'import_deform_group', group = 'tits_normal', material = "res://Character_generator/shaders/shaders_deform_tits/Female_normal_tits_normal.tres"}
		],
		average_high = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_normal'},
			{type = 'import_deform_group', group = 'tits_normal', material = "res://Character_generator/shaders/shaders_deform_tits/Female_normal_tits_high.tres"}
		],
		average_narrow = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_normal'},
			{type = 'import_deform_group', group = 'tits_normal', material = "res://Character_generator/shaders/shaders_deform_tits/Female_normal_tits_narrow.tres"}
		],
		average_wide = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_normal'},
			{type = 'import_deform_group', group = 'tits_normal', material = "res://Character_generator/shaders/shaders_deform_tits/Female_normal_tits_wide.tres"}
		],
		big = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_big'},
			{type = 'import_deform_group', group = 'tits_big', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_normal.tres"}
		],
		big_high = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_big'},
			{type = 'import_deform_group', group = 'tits_big', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_high.tres"}
		],
		big_narrow = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_big'},
			{type = 'import_deform_group', group = 'tits_big', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_narrow.tres"}
		],
		big_wide = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_big'},
			{type = 'import_deform_group', group = 'tits_big', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_wide.tres"}
		],
		huge = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_big'},
		],
		masculine = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_small'}, #actually not needed - for it do not use female ragdoll
		],
	},
	
	skin_coverage = {
		null : [
			{type = 'import_mask_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/shaders_color_human_skin/skin_shader.tres"}
		], #clear mask without removing color change 
		"" : [
			{type = 'import_mask_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/shaders_color_human_skin/skin_shader.tres"}
		],
		#old ones 2fix
		feathers = [
			{type = 'import_mask_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/shaders_color_human_skin/skin_shader.tres"}
		],
		plant = [
			{type = 'import_mask_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/shaders_color_human_skin/skin_shader.tres"}
		],
		fur_orange = [ #wrong colors
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin_ext.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin.png"},
		],
		fur_orange_white = [ #the same
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin_ext.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin.png"},
		],
		fur_striped = [ #same as + wrong masks (no stripes masks)
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin_ext.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin.png"},
		],
		#old ones normal
		scale = [
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_skales.png"}
		],
		fur_white = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin_ext.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin.png"},
		],
		fur_grey = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin_ext.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin.png"},
		],
		fur_brown = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin_ext.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin.png"},
		],
		fur_black = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin_ext.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin.png"},
		],
		#new ones
		scale2 = [
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_scales2.png"}
		],
		kobold = [
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_kobold.png"}
		],
	},
	
	body_color_skin = {
		blue1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/blue/skin_blue1.tres"},
		],
		blue2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/blue/skin_blue2.tres"},
		],
		blue3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/blue/skin_blue3.tres"},
		],
		blue4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/blue/skin_blue4.tres"},
		],
		blue5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/blue/skin_blue5.tres"},
		],
		green1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/green/skin_green1.tres"},
		],
		green2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/green/skin_green2.tres"},
		],
		green3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/green/skin_green3.tres"},
		],
		green4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/green/skin_green4.tres"},
		],
		green5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/green/skin_green5.tres"},
		],
		human1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/human/skin_human1.tres"},
		],
		human2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/human/skin_human2.tres"},
		],
		human3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/human/skin_human3.tres"},
		],
		human4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/human/skin_human4.tres"},
		],
		human5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/human/skin_human5.tres"},
		],
		pink1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/pink/skin_pink1.tres"},
		],
		pink2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/pink/skin_pink2.tres"},
		],
		pink3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/pink/skin_pink3.tres"},
		],
		pink4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/pink/skin_pink4.tres"},
		],
		pink5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/pink/skin_pink5.tres"},
		],
		purple1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/purple/skin_purple1.tres"},
		],
		purple2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/purple/skin_purple2.tres"},
		],
		purple3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/purple/skin_purple3.tres"},
		],
		purple4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/purple/skin_purple4.tres"},
		],
		purple5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/purple/skin_purple5.tres"},
		],
		red1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/red/skin_red1.tres"},
		],
		red2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/red/skin_red2.tres"},
		],
		red3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/red/skin_red3.tres"},
		],
		red4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/red/skin_red4.tres"},
		],
		red5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/red/skin_red5.tres"},
		],
		yellow1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/yellow/skin_yellow1.tres"},
		],
		yellow2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/yellow/skin_yellow2.tres"},
		],
		yellow3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/yellow/skin_yellow3.tres"},
		],
		yellow4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/yellow/skin_yellow4.tres"},
		],
		yellow5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/yellow/skin_yellow5.tres"},
		],
	},
	
	#next ones should be adjusted properly - for now i have no idea which way
	body_color_wings = {
		blue1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
		],
		blue2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
		],
		blue3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
		],
		dark1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
		],
		dark2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
		],
		dark3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
		],
		green1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
		],
		green2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
		],
		green3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
		],
		cyan1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
		],
		cyan2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
		],
		cyan3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
		],
		pink1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
		],
		pink2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
		],
		pink3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
		],
		purple1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
		],
		purple2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
		],
		purple3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
		],
		red1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
		],
		red2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
		],
		red3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
		],
		white1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
		],
		white2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
		],
		white3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
		],
		yellow1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
		],
		yellow2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
		],
		yellow3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
		],
	},
	
	body_color_tail = {
		blue1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
		],
		blue2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
		],
		blue3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
		],
		dark1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
		],
		dark2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
		],
		dark3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
		],
		green1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
		],
		green2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
		],
		green3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
		],
		cyan1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
		],
		cyan2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
		],
		cyan3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
		],
		pink1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
		],
		pink2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
		],
		pink3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
		],
		purple1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
		],
		purple2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
		],
		purple3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
		],
		red1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
		],
		red2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
		],
		red3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
		],
		white1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
		],
		white2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
		],
		white3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
		],
		yellow1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
		],
		yellow2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
		],
		yellow3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
		],
	},
	
	body_color_animal = {
		blue1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
		],
		blue2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
		],
		blue3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
		],
		dark1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
		],
		dark2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
		],
		dark3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
		],
		green1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
		],
		green2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
		],
		green3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
		],
		cyan1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
		],
		cyan2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
		],
		cyan3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
		],
		pink1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
		],
		pink2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
		],
		pink3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
		],
		purple1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
		],
		purple2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
		],
		purple3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
		],
		red1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
		],
		red2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
		],
		red3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
		],
		white1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
		],
		white2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
		],
		white3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
		],
		yellow1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
		],
		yellow2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
		],
		yellow3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
		],
	},
	
	body_color_horns = {
		blue1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
		],
		blue2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
		],
		blue3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
		],
		dark1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
		],
		dark2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
		],
		dark3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
		],
		green1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
		],
		green2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
		],
		green3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
		],
		cyan1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
		],
		cyan2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
		],
		cyan3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
		],
		pink1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
		],
		pink2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
		],
		pink3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
		],
		purple1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
		],
		purple2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
		],
		purple3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
		],
		red1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
		],
		red2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
		],
		red3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
		],
		white1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
		],
		white2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
		],
		white3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
		],
		yellow1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
		],
		yellow2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
		],
		yellow3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
		],
	},
	
	#hair part, possible backward compat errors
	hair_base = { #mb put bald here as in other hair nodes, but currently it is handled with length
		lion = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_lion.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_lion.png"},
		],
		back = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_back.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_back.png"},
		],
		braids = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_braids.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_braids.png"},
		],
		default = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_default.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_default.png"},
		],
		dopple = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_dopple.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_dopple.png"},
		],
		fringe = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_fringe.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_fringe.png"},
		],
		irokez = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_irokez.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_irokez.png"},
		],
		kare = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_kare.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_kare.png"},
		],
		lamb = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_lamb.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_lamb.png"},
		],
		parting = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_parting.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_parting.png"},
		],
		'slave' : [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_slave.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_slave.png"},
		],
		straight = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_straight.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_straight.png"},
		],
		undercut = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_undercut.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_undercut.png"},
		],
	},
	
	hair_assist = { 
		'': [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = false},
		],
		braid = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_braid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_braid.png"},
		],
		bun = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_bun.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_bun.png"},
		],
		pigtails = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_pigtails.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_pigtails.png"},
		],
		ponytail = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_ponytail.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_ponytail.png"},
		],
		twin_tails = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_twin_tails.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_twin_tails.png"},
		],
		twin_tails_2 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_twin_tails 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/hair_assist_twin_tails 2.png"},
		],
	},
	
	hair_back = {
		'': [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = false},
		],
		care = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_care.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_care.png"},
		],
		dishevel = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_dishevel.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_dishevel.png"},
		],
		spiral = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_spiral.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_spiral.png"},
		],
		straight = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_straight.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_straight.png"},
		],
		twin_braids = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_twin braids.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_twin braids.png"},
		],
		wave = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_wawe.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_wawe.png"},
		],
		very_long = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_straight.png"}, #mb not
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_verylong1.png"},
		],
	},
	
	hair_base_color_1 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
		],
	},
	
	hair_back_color_1 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
		],
	},
	
	hair_assist_color_1 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
		],
	},
	
	hair_base_color_2 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
		],
	},
	
	hair_back_color_2 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
		],
	},
	
	hair_assist_color_2 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
		],
	},
	
	hair_base_lenght = {
		bald = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = false},
		],
		default = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
		],
		long = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
		],
		middle = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
		],
		short = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
		],
	},
	
	hair_back_lenght = {
		default = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
		],
		long = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
		],
		middle = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
		],
		short = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
		],
	},
	
	hair_assist_lenght = {
		default = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
		],
		long = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
		],
		middle = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
		],
		short = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
		],
	},
	
	height = {
		tiny = [
			{type = 'scale', value = 0.69},
			{type = 'offset', value_x = 0.0, value_y = 50},
		],
		petite = [
			{type = 'scale', value = 0.81},
			{type = 'offset', value_x = 0.0, value_y = 30},
		],
		short = [
			{type = 'scale', value = 0.88},
			{type = 'offset', value_x = 0.0, value_y = 30},
		],
		average = [
			{type = 'scale', value = 1.0},
			{type = 'offset', value_x = 0.0, value_y = 0},
		],
		tall = [
			{type = 'scale', value = 1.13},
			{type = 'offset', value_x = 0.0, value_y = -20},
		],
		towering = [
			{type = 'scale', value = 1.25},
			{type = 'offset', value_x = 0.0, value_y = -70},
		],
	},
	
	
	#other new parts
	chin = { 
		default = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_default.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_default.png"},
		],
		curve = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_curve.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_curve.png"},
		],
		kobold = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_kobold2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_kobold2.png"},
		],
		loli = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_loli.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_loli.png"},
		],
		skinny = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_long_skinny.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_long_skinny.png"},
		],
		male = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_male.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_male.png"},
		],
		muscle = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_muscle.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_muscle.png"},
		],
		short = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_short.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_short.png"},
		],
		beastkin = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = null},
		],
	},
	
	eyeshape = { #mixed styles due to similaruty
		face1 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face_m2.png"}, #definetely missed
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face1.png"},
		],
		face2 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face_m2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face_m2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face2.png"},
		],
		face3 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face_m3.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face_m3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face3.png"},
		],
		face4 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face_m4.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face_m4.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face4.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face4.png"},
		],
		face5 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face_m5.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face_m5.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face5.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Face_tex_furry', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face5.png"},
		],
	},
	
	nose = {
		default = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_default.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_default.png"},
		],
		dwarf = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_dwarf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_dwarf.png"},
		],
		kobold = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_kobold.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_kobold.png"},
		],
		loli = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_loli.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_loli.png"},
		],
		staright = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_straight.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_straight.png"},
		],
	},
	
	eyebrows = { #male and female styles are separate for the sake of sanity with descryptions except default style1 - free to change styles here to match 
		style1 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows1.png"},
		],
		style2 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows2.png"},
		],
		style3 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows3.png"},
		],
		style4 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows4.png"},
		],
		style5 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows5.png"},
		],
		style6 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows_m2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = null},
		],
		style7 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = "res://Character_generator/images/11_eyebrows/eyebrows_m3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyebrows_tex', texture = null},
		],
	},
	
	lips = { #misplaced files, single male style
		style1 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips1.png"},
		],
		style2 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips2.png"},
		],
		style3 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips3.png"},
		],
		style4 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips4.png"},
		],
		style5 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/12_lips/lips5.png"},
		],
		orcish = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/02_faces_eyes/lips_orc.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/02_faces_eyes/lips_orc.png"},
		],
	},
	
	#armor
	#those are built based on allanheil's table
	armor_base = {
		null: [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = null},
		],
		servant = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ArmR1_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ShoulderR_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ArmL1_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ShoulderL_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/100_armory_set_servant_male/torso_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand1_armorR1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Arm_armorR1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Shoulder_armorR1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand1_armorL1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Arm_armorL1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Shoulder_armorL1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/99_armory_set_maidu/bluza.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = "res://Character_generator/images/99_armory_set_maidu/hair_armor_maid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/99_armory_set_maidu/Pregnancy_maidu_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = "res://Character_generator/images/99_armory_set_maidu/Pregnancy_maidu_big.png"},
		],
		chest_base_cloth = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/ShoulderR_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/ShoulderL_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/torso_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorR_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorL_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/torso_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_big.png"},
		],
		chest_adv_cloth = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/ShoulderR_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/ShoulderL_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/torso_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorR_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorL_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/torso_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_big.png"},
		],
		chest_base_leather = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/torso_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorR_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorL_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/torso_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_leather.png"},
		],
		chest_adv_leather = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/torso_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorR_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorL_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/torso_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_leather.png"},
		],
		chest_base_metal = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/torso_armor_plate2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorR_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorL_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/torso_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_big.png"},
		],
		chest_adv_metal = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/torso_armor_plate2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorR_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorL_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/torso_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex2', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_big.png"},
		],
	},
	
	armor_lower = {
		null: [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = null},
		],
		servant = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/LegL_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/LegR_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/taz_armor_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/LegL_armor1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/LegR_armor1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/99_armory_set_maidu/yubka.png"},
		],
		legs_base_cloth = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegL_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegR_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/taz_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/taz_armor_cloth.png"},
		],
		legs_adv_cloth = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegL_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegR_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/taz_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/taz_armor_cloth.png"},
		],
		legs_base_leather = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/taz_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegL_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegR_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/taz_armor_leather.png"},
		],
		legs_adv_leather = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/taz_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegL_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegR_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/taz_armor_leather.png"},
		],
		legs_base_metal = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/taz_armor_plate2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegL_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegR_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/taz_armor_plate.png"},
		],
		legs_adv_metal = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/taz_armor_plate2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegL_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegR_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/taz_armor_plate.png"},
		],
	}
}

#func _ready():
#	fix_data()
#
#func fix_data():
#	var shader = load("res://assets/ItemShader.tres").duplicate()
