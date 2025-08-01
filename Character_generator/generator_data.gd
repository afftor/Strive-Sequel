extends Node

var stats_to_look = [
'pose',
'sex', 'race',
'horns', 'eyeshape', 'eye_tex', 'eye_color', 'eyebrows', 'lips', 'wings', 'penis_type', 'chin', 'nose', 'pregnancy_status', 'tits_size', 'multiple_tits_developed',
'body_color_wings', 'body_color_horns', 'body_color_animal', 'body_color_tail', 'body_color_ears', 'body_color_lips',
'hair_base', 'hair_assist', 
'hair_back', 'hair_fringe',
'hair_base_color_1', 'hair_fringe_color_1', 'hair_back_color_1', 'hair_assist_color_1', 'hair_base_color_2', 'hair_fringe_color_2', 
'hair_back_color_2', 'hair_assist_color_2', 'hair_base_length', 'hair_fringe_length', 'hair_back_length', 'hair_assist_length',
'beard', 'hair_facial_color',
'body_color_skin', 'skin_coverage',
'ears', 'tail',
'height', 'ass_size',
]

var stats_links = {
	height = ['full'],
	body_color_skin = ['body_color_skin', 'skin_coverage'],
	hair_base_color_1 = ['hair_base_color_1', 'hair_fringe_color_1', 'body_color_ears'],
	hair_base_color_2 = ['hair_base_color_2', 'hair_fringe_color_2'],
	personality = ['pose'],
	skin_coverage = ['body_color_ears', 'skin_coverage'],
}

var itemparts = {}


var texture_sets = {
	default_male = [
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/01_body_nude_male/HandR1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_tex', texture = "res://Character_generator/images/01_body_nude_male/HandR2_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/01_body_nude_male/ArmR1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/01_body_nude_male/ShoulderR_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/01_body_nude_male/HandL1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_tex', texture = "res://Character_generator/images/01_body_nude_male/HandL2_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_tex', texture = "res://Character_generator/images/01_body_nude_male/ArmL1_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_tex', texture = "res://Character_generator/images/01_body_nude_male/ShoulderL_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_tex2', texture = "res://Character_generator/images/01_body_nude_male/torso_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_tex', texture = "res://Character_generator/images/01_body_nude_male/LegL_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_tex', texture = "res://Character_generator/images/01_body_nude_male/LegR_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_tex', texture = "res://Character_generator/images/01_body_nude_male/taz_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_human_up.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_human.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_normal.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_nipple_tex', texture = "res://Character_generator/images/01_body_nude_male/nipples_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/01_heads/head_skull.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_male.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/02_faces/face_m4.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_default.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_human.png" },
	],
	beastkin_male = [
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/HandR1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/Beastkin_HandR2_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ArmR1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ShoulderR_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/HandL1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/Beastkin_HandL2_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ArmL1_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/ShoulderL_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_tex2', texture = "res://Character_generator/images/15_beastkin_body_nude_male/torso_bestkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/LegL_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/LegR_bestkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/taz_beastkin_m.png"}, 
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_nipple_tex', texture = "res://Character_generator/images/15_beastkin_body_nude_male/nipples_beastkin_m.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Tits/Tits_mesh', texture = null},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Face_tex', texture = "res://Character_generator/images/17_beastkin_faces/beastkin_face_m4.png"},
		{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_skull.png"},
	],
	default_female = [
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/00_body_nude/HandR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_tex', texture = "res://Character_generator/images/00_body_nude/HandR2.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_tex', texture = "res://Character_generator/images/00_body_nude/HandR3.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/00_body_nude/ArmR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/00_body_nude/ShoulderR.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/00_body_nude/HandL1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_tex', texture = "res://Character_generator/images/00_body_nude/HandL2.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_tex', texture = "res://Character_generator/images/00_body_nude/HandL3.png"},
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
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/Belly_pregnancy_tex2', texture = "res://Character_generator/images/00_body_nude/pregnancy_belly_big.png"},
		
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Nipples_mesh', texture = "res://Character_generator/images/00_body_nude/tits_nipples_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_large.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Nipples_mesh', texture = "res://Character_generator/images/00_body_nude/tits_nipples_large.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_normal.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Nipples_mesh', texture = "res://Character_generator/images/00_body_nude/tits_nipples_normal.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_mesh', texture = "res://Character_generator/images/00_body_nude/tits_small.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Nipples_mesh', texture = "res://Character_generator/images/00_body_nude/tits_nipples_small.png"},
	],
	beastkin_female = [
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandR2.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandR3.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_ArmR1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_ShoulderR.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandL1.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandL2.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_tex', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_HandL3.png"},
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
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/Belly_pregnancy_tex2', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_pregnancy_belly_big1.png"},
		
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Nipples_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_nipples_big.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_large.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Nipples_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_nipples_large.png"}, 
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_normal.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Nipples_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_nipples.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_small.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Nipples_mesh', texture = "res://Character_generator/images/15_beastkin_body_nude/beastkin_tits_nipples_small.png"},
		{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_skull.png"},
	],
}

var transforms = {
	cloth = {
		true:[
			{type = 'node_group_attr', group = 'cloth', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'z_index', value = 6},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy2', attr = 'z_index', value = 6},
		],
		false:[
			{type = 'node_group_attr', group = 'cloth', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy2', attr = 'z_index', value = 0},
		]
	},
	
	sex = {
		male = [
			{type = 'node_group_select', group = 'sex', select = 'male_pose'},
			{type = 'offset', value_x = 0.0, value_y = 30},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = true}
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
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_shoulderR.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_shoulderL.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_body.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_legR.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_elven.png" },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_shoulderR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_shoulderL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_body.png"}, # or not
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = "res://Character_generator/images/20_dryad/dryad_legR.png"},
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
			{type = 'node_group_attr', group = 'dragon', attr = 'visible', value = true},
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
		Taurus = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
		],
		Ratkin = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
		],
		#half support for harpies - mb no tail, no legs, no ears
		Slime = [ #don't think that shoulder additional parts are positioned correctly
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
			{type = 'node_group_attr', group = 'slime', attr = 'visible', value = true},
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
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_cat.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_cat.png"},
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
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_wolf.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_wolf.png"},
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
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_fox.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_fox.png"},
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
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_rabbit.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_rabbit.png"},
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
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_tanuki.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/16_beastkin_heads_new/beastkin_chin_tanuki.png"},
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
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
		],
		HalfkinWolf = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
		],
		HalfkinFox = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
		],
		HalfkinBunny = [ #move ears to separate dir
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
		],
		HalfkinTanuki = [
			{type = 'node_group_attr', group = 'human', attr = 'visible', value = true},
			{type = 'node_group_attr', group = 'nonhuman', attr = 'visible', value = false},
#			{type = 'import_recolor_group', group = 'skin_main', material = "remove_racial_masks", ids = []}, non-existed material
			{type = 'texture_set', set = 'default_male'},
			{type = 'texture_set', set = 'default_female'},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
		],
	},
	
	ears = { 
		cat = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_cat.png"},
		],
		fox = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_fox.png"},
		],
		wolf = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_wolf.png"},
		],
		tanuki = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_tanuk.png"},
		],
		rat = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_mouse.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_mouse.png"},
		],
		bunny = [#not used
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit.png"},
		],
		bunny_standing = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit3.png"},
		],
		bunny_drooping = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_rabbit2.png"},
		],
		elven = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_humanoid_tex_long'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
		],
		demon = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_humanoid_tex_long'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
		],
		feathered = [ #mb another texture
			{type = 'node_group_select', group = 'ears', select = 'Ears_humanoid_tex_long'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_elven.png"},
		],
		cow = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_taurus.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_taurus.png"},
		],
		goblin = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_humanoid_tex_long'}, #or not
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_goblin.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_goblin.png"},
		],
		orcish = [
			{type = 'node_group_select', group = 'ears', select = 'Ears_humanoid_tex_long'}, #or not
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_orc.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_orc.png"},
		],
		normal = [ #human
			{type = 'node_group_select', group = 'ears', select = 'Ears_humanoid_tex'},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_human.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex', texture = "res://Character_generator/images/03_ears/ears_human.png"},
		],
		fish = [ #nereid
#			{type = 'node_group_select', group = 'ears', select = 'Ears_humanoid_tex_long'},
			{type = 'node_group_select', group = 'ears', select = 'Ears_furry_tex'},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_humanoid_tex_long', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', texture = "res://Character_generator/images/03_ears/ears_nereid.png"},
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
		grey = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_grey.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_grey.tres"},
		],
		black = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Eyes_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
		],
	},
	
	body_color_lips = { #maybe there should be ids = [1] in every transform
		blue = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_blue.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_blue.tres"},
		],
		cyan = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_bluelight.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_bluelight.tres"},
		],
		brown = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_brown.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_brown.tres"},
		],
		green = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_green.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_green.tres"},
		],
		pink = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_pink.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_pink.tres"},
		],
		purple = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_purple.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_purple.tres"},
		],
		red = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_red.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_red.tres"},
		],
		yellow = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_yellow.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_yellow.tres"},
		],
		grey = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_grey.tres"},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_eyes/eyes_grey.tres"},
		],
		black = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
		],
	},
	
	horns = {
		"": [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = false},
		],
		null: [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = false},
		],
		short = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_top.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_top.png"},
		],
		curved = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_up.png"},
		],
		straight = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_diagonal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/Horn_straight_diagonal.png"},
		],
		dragon = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_dragon2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_dragon2.png"},
		],
		#stub types
		curved_top = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_top.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_top.png"},
		],
		curved_down = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_down.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_curve_down.png"},
		],
#		fibule = [
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_seraph_fibule.png"},
#			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_seraph_fibule.png"},
#		],
		spiral = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral.png"},
		],
		spiral_2 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', texture = "res://Character_generator/images/08_horns/horn_spiral 2.png"},
		],
	},
	
	wings = {
		null: [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = false},
		],
		"": [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = false},
		],
		demon = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/wings_demon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/wings_demon.png"},
		],
		dragon = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_dragon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_dragon.png"},
		],
		fairy = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_fairy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_fairy.png"},
		],
		seraph = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Wings_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_seraph.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Wings_tex', texture = "res://Character_generator/images/09_wings/Wings_seraph.png"},
		],
	},
	
	tail = { #there is some misplacing for sure
		#pls fix duplicating between 06_tails and 07_tails and pathes
		null: [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = false},
		],
		"": [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = false},
		],
		cat = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_cat.png"},
		],
		demon = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_demon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_demon.png"},
		],
		dragon = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon.png"},
		],
		dragon2 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_dragon2.png"},
		],
		cow = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/tail_cow.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/tail_cow.png"},
		],
		fox = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_fox.png"},
		],
		rat = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_mouse.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_mouse.png"},
		],
		tanuki = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_tanuk.png"},
		],
		wolf = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_wolf.png"},
		],
		kobold = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/Kobold_tail.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/06_tails/Kobold_tail.png"},
		],
		fish = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tail_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_nereid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tail_tex', texture = "res://Character_generator/images/07_tails/tail_nereid.png"},
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
		feline = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
		],
		canine = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_furry_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_furry.png"},
		],
		equine = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_horse_up.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_horse.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Penis_tex', texture = "res://Character_generator/images/13_dicks/Dick_horse_up.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex', texture = "res://Character_generator/images/13_dicks/Testicle_horse.png"},
		],
	},
	
	pregnancy_status = {
		no = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy2', attr = 'visible', value = false}
		],
		early = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy2', attr = 'visible', value = false},
		],
		heavy = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy2', attr = 'visible', value = true},
		],
	},
	
	multiple_tits_developed = {
		true:[
			{type = 'node_group_attr', group = 'multitits', attr = 'visible', value = true},
		],
		false:[
			{type = 'node_group_attr', group = 'multitits', attr = 'visible', value = false},
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
			{type = 'import_deform_group', group = 'tits_big', material = "res://Character_generator/shaders/shaders_deform_tits/Female_large_tits_normal.tres"}
		],
		big_high = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_big'},
			{type = 'import_deform_group', group = 'tits_big', material = "res://Character_generator/shaders/shaders_deform_tits/Female_large_tits_high.tres"}
		],
		big_narrow = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_big'},
			{type = 'import_deform_group', group = 'tits_big', material = "res://Character_generator/shaders/shaders_deform_tits/Female_large_tits_narrow.tres"}
		],
		huge = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_huge'},
			{type = 'import_deform_group', group = 'tits_huge', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_normal.tres"}
		],
		huge_high = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_huge'},
			{type = 'import_deform_group', group = 'tits_huge', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_high.tres"}
		],
		huge_narrow = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_huge'},
			{type = 'import_deform_group', group = 'tits_huge', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_narrow.tres"}
		],
		huge_wide = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_huge'},
			{type = 'import_deform_group', group = 'tits_huge', material = "res://Character_generator/shaders/shaders_deform_tits/Female_big_tits_wide.tres"}
		],
		masculine = [
			{type = 'node_group_select', group = 'tits', select = 'Tits_small'}, #actually not needed - for it do not use female ragdoll
		],
	},
	
	skin_coverage = {
		null : [
			{type = 'import_recolor_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/recolor_none.tres"}
		], #clear mask without removing color change 
		"" : [
			{type = 'import_recolor_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/recolor_none.tres"}
		],
		#old ones 2fix
		feathers = [ #obviosly incomplete
			{type = 'import_recolor_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/recolor_none.tres"}
		],
		plant = [ #obviosly incomplete, mb not needed
			{type = 'import_recolor_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/recolor_none.tres"}
		],
		fur_orange = [ 
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1, 2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin 2 ext.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [2], material = null},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin 2.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [3], material = null},
		],
		fur_orange_white = [ 
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1, 2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin 2 ext.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [2], material = null},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin 2.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [3], material = null},
		],
		fur_striped = [ 
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1, 2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
#			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = null},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_cat 2.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_cat2 2 ext.png"},
		],
		#old ones normal
		fur_white = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1, 2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin 2 ext.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [2], material = null},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin 2.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [3], material = null},
		],
		fur_grey = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1, 2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin 2 ext.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [2], material = null},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin 2.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [3], material = null},
		],
		fur_brown = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1, 2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin 2 ext.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [2], material = null},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin 2.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [3], material = null},
		],
		fur_black = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1, 2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin 2 ext.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [2], material = null},
			{type = 'import_mask_group_path', group = 'fur_mask', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin 2.png"},
			{type = 'import_mask_group_path', group = 'fur_nonmask', ids = [3], material = null},
		],
		#new ones
		scale = [
			{type = 'import_recolor_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/recolor_none.tres"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_races_tex', texture = "res://Character_generator/images/23_dragon_male/ArmR1_dragon.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = "res://Character_generator/images/23_dragon_male/ShoulderR_m_dragon.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_races_tex', texture = "res://Character_generator/images/23_dragon_male/ArmL1_dragon.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = "res://Character_generator/images/23_dragon_male/ShoulderL_m_dragon.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/23_dragon_male/dragon_torso_m.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_races_hair', texture = "res://Character_generator/images/23_dragon_male/LegL_m_dragon.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = "res://Character_generator/images/23_dragon_male/LegR_m_dragon.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_races_hair', texture = "res://Character_generator/images/23_dragon_male/dragon_taz_m.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_races_tex', texture = "res://Character_generator/images/23_dragon_male/head_m_dragon.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_races_tex', texture = "res://Character_generator/images/23_dragon_female/dragon_armR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_shoulderR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_races_tex', texture = "res://Character_generator/images/23_dragon_female/dragon_armL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_shoulderL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_body.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_LegL.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_LegR.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_taz.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_races_tex', texture = "res://Character_generator/images/23_dragon_female/head_dragon_mask.png"},
		],
		scale2 = [
			{type = 'import_recolor_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/recolor_none.tres"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_races_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_races_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/23_dragon_male/dragon_torso_m2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_races_hair', texture = "res://Character_generator/images/23_dragon_male/LegL_m_dragon2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = "res://Character_generator/images/23_dragon_male/LegR_m_dragon2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_races_tex', texture = "res://Character_generator/images/23_dragon_male/head_m_dragon2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_races_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_races_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_body 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_LegL 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_LegR 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_taz 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_races_tex', texture = "res://Character_generator/images/23_dragon_female/head_dragon_mask 2.png"},
		],
		scale3 = [
			{type = 'import_recolor_group', group = 'skin_main', ids = [3], material = "res://Character_generator/shaders/recolor_none.tres"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_races_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_races_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/23_dragon_male/dragon_torso_m3.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_races_hair', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_races_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_races_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_races_hair', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_races_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_races_hair', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_races_hair', texture = "res://Character_generator/images/23_dragon_female/dragon_body3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_races_hair', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_races_hair', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_races_hair', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_races_tex', texture = null},
		],
		kobold = [
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_kobold.png"}
		],
		fur_tricolor = [ 
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [1], material = "res://Character_generator/images/98_masks/mask_besatkin cat_tricolor_black.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [2], material = "res://Character_generator/images/98_masks/mask_besatkin cat_tricolor_white.png"},
			{type = 'import_mask_group_path', group = 'skin_main', ids = [3], material = "res://Character_generator/images/98_masks/mask_besatkin cat_tricolor_yellow.png"},
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
		grey1 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/grey/skin_grey1.tres"},
		],
		grey2 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/grey/skin_grey2.tres"},
		],
		grey3 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/grey/skin_grey3.tres"},
		],
		grey4 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/grey/skin_grey4.tres"},
		],
		grey5 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/grey/skin_grey5.tres"},
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
		human6 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/human/skin_human6.tres"},
		],
		human7 = [
			{type = 'import_recolor_group', group = 'skin_main', material = "res://Character_generator/shaders/shaders_color_human_skin/human/skin_human7.tres"},
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
		brown1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
		],
		brown2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
		],
		brown3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
		],
		orange1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
		],
		orange2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
		],
		orange3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Wings_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
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
	
	body_color_ears = {
		blue1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
		],
		blue2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
		],
		blue3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
		],
		brown1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
		],
		brown2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
		],
		brown3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
		],
		orange1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
		],
		orange2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
		],
		orange3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
		],
		dark1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
		],
		dark2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
		],
		dark3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
		],
		green1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
		],
		green2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
		],
		green3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
		],
		cyan1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
		],
		cyan2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
		],
		cyan3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
		],
		pink1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
		],
		pink2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
		],
		pink3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
		],
		purple1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
		],
		purple2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
		],
		purple3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
		],
		red1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
		],
		red2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
		],
		red3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
		],
		white1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
		],
		white2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
		],
		white3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
		],
		yellow1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
		],
		yellow2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
		],
		yellow3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Ears_furry_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
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
		orange1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
		],
		orange2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
		],
		orange3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
		],
		brown1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
		],
		brown2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
		],
		brown3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Tail_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
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
		orange1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
		],
		orange2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
		],
		orange3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
		],
		brown1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
		],
		brown2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
		],
		brown3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Animal_body', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
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
		brown1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
		],
		brown2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
		],
		brown3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
		],
		orange1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
		],
		orange2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
		],
		orange3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Horns_tex', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
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
	
	beard = {
		no = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = null},
			],
#		beard1 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards/beard1.png"},
#			],
#		beard2 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards/beard2.png"},
#			],
#		beard3 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards/beard3.png"},
#			],
#		beard4 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards/beard4.png"},
#			],
		style1 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = null},
			],
		style2 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = null},
			],
		style3 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard3.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = null},
			],
		style4 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard4.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = null},
			],
		style5 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache1.png"},
			],
		style6 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache2.png"},
			],
		style7 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache3.png"},
			],
		style8 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache4.png"},
			],
		style9 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache1.png"},
			],
		style10 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache2.png"},
			],
		style11 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard3.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache3.png"},
			],
		style12 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Beard', texture = "res://Character_generator/images/05_beards_moustaches/beard4.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache4.png"},
			],
	},
	
	
#	moustache = {
#		no = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = null},
#			],
#		moustache1 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache1.png"},
#			],
#		moustache2 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache2.png"},
#			],
#		moustache3 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache3.png"},
#			],
#		moustache4 = [
#			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Moustache', texture = "res://Character_generator/images/05_beards_moustaches/moustache4.png"},
#			],
#	},
	
	hair_facial_color = {
		blue_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
		],
		blue_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
		],
		blue_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
		],
		
		brown_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
		],
		brown_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
		],
		brown_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
		],
		
		orange_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
		],
		orange_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
		],
		orange_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
		],
		
		dark_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
		],
		dark_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
		],
		dark_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
		],
		
		green_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
		],
		green_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
		],
		green_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
		],
		
		cyan_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
		],
		cyan_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
		],
		cyan_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
		],
		
		pink_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
		],
		pink_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
		],
		pink_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
		],
		
		purple_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
		],
		purple_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
		],
		purple_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
		],
		
		red_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
		],
		red_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
		],
		red_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
		],
		
		white_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
		],
		white_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
		],
		white_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
		],
		
		yellow_1 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
		],
		yellow_2 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
		],
		yellow_3 = [
			{type = 'import_recolor_group', group = 'hair_facial', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
		],
	},
	#hair part, possible backward compat errors
	hair_base = { #mb put bald here as in other hair nodes, but currently it is handled with length
		#pls, do check, remove and fix pathes with all that duplicates in dir
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
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_dopple.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_dopple.png"},
		],
		fringe = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_fringe.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_fringe.png"},
		],
		fringe2 = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_fringe 2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_fringe 2.png"},
		],
		irokez = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_irokez.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_irokez.png"},
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
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_parting.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_parting.png"},
		],
		'slave' : [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_slave.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_slave.png"},
		],
		straight = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_straight.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hair_base_straight.png"},
		],
		undercut = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_undercut.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', texture = "res://Character_generator/images/04_hairs_base/hairs_base_undercut.png"},
		],
	},
	
	hair_fringe = {
		dopple = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_dopple.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_dopple.png"},
		],
		irokez = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_irokez.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_irokez.png"},
		],
		lion = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_lion.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_lion.png"},
		],
		parting = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_parting.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_parting.png"},
		],
		'slave': [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_slave.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_slave.png"},
		],
		undercut = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_undercut.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hairs_fringe_undercut.png"},
		],
		back = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_back.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_back.png"},
		],
		braids = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_braids.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_braids.png"},
		],
		default = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_default.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_default.png"},
		],
		fringe = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_fringe.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_fringe.png"},
		],
		kare = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_kare.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_kare.png"},
		],
		lamb = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture ="res://Character_generator/images/04_hairs_fringe/hair_fringe_lamb.png" },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_lamb.png"},
		],
		straight = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_straight.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', texture = "res://Character_generator/images/04_hairs_fringe/hair_fringe_straight.png"},
		],
	},
	
	hair_assist = { #pls, do check, remove and fix pathes with all that duplicates in dir
		'no': [
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
		ponytail_2 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/ponytail_2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/ponytail_2.png"},
		],
		ponytail_3 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/ponytail_3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/ponytail_3.png"},
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
		twin_tails_3 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/twin_tails.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/twin_tails.png"},
		],
		twin_tails_4 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/Twin_tails_2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/Twin_tails_2.png"},
		],
		twin_tails_5 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/twin_tails 3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', texture = "res://Character_generator/images/05_hairs_assist/twin_tails 3.png"},
		],
	},
	
	hair_back = { #pls, do check, remove and fix pathes with all that duplicates in dir and inbetween them
		'no': [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
		],
		care = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_care.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_care.png"},
		],
		dishevel = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_dishevel.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_dishevel.png"},
		],
		double_tail = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_double_tail_long.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_double_tail_long.png"},
		],
		ponytail_long = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_ponytail_long.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_ponytail_long.png"},
		],
		spiral = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_spiral.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_spiral.png"},
		],
		straight = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_straight.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_straight.png"},
		],
		twin_braids = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_twin braids.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_twin braids.png"},
		],
		wave = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_wawe.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_wawe.png"},
		],
		very_long = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_straight.png"}, #mb not
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', texture = "res://Character_generator/images/06_hairs_back/hair_back_verylong1.png"},
		],
	},
	
	hair_base_color_1 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1]},
		],
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1]},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1]},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1]},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1]},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1]},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor_group', group = 'hair_additional', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1]},
		],
	},
	
	hair_fringe_color_1 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
		],
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
		],
	},
	
	hair_back_color_1 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [2]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [2]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [2]},
		],
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [2]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [2]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [2]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [2]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [2]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [2]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [2]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [2]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [2]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [2]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [2]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [2]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [2]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [2]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [2]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [2]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [2]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [2]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [2]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [2]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [2]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [2]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [2]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [2]},
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
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [2]},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [2]},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [2]},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [2]},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [2]},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [2]},
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
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
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
	
	hair_fringe_color_2 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
		],
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
		],
	},
	
	hair_back_color_2 = {
		blue_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		blue_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		blue_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/blue/Hair_blue_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		dark_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		dark_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		dark_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/dark/Hair_dark_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		green_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		green_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		green_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/green/Hair_green_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		cyan_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		cyan_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		cyan_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/lightblue/Hair_lightblue_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		pink_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		pink_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		pink_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/pink/Hair_pink_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		purple_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		purple_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		purple_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/purple/Hair_purple_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		red_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		red_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		red_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/red/Hair_red_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		white_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		white_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		white_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/white/Hair_white_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		
		yellow_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		yellow_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_2.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
		],
		yellow_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/yellow/Hair_yellow_3.tres", ids = [1, 3]},
			{type = 'import_mask_path', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', ids = [1], material = "res://Character_generator/images/98_masks/mask_tale1.png"},
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
		
		brown_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown.tres", ids = [3]},
		],
		brown_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_2.tres", ids = [3]},
		],
		brown_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/brown/Hair_brown_3.tres", ids = [3]},
		],
		
		orange_1 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange.tres", ids = [3]},
		],
		orange_2 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_2.tres", ids = [3]},
		],
		orange_3 = [
			{type = 'import_recolor', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
			{type = 'import_recolor', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_color_hairs_ears_tails_horns_wings_animals_beastkins/orange/Hair_orange_3.tres", ids = [3]},
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
	
	hair_base_length = {
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
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
		],
		middle = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
		],
		short = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
		],
	},
	
	hair_fringe_length = {
		bald = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = false},
		],
		default = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
		],
		middle = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
		],
		long = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
		],
		short = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', attr = 'visible', value = true},
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_fringe_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
		],
	},
	
	hair_back_length = {
		default = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
		],
		middle = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
		],
		long = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
		],
		short = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
		],
	},
	
	hair_assist_length = {
		default = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_default.tres"},
		],
		middle = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_long.tres"},
		],
		long = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_middle.tres"},
		],
		short = [
			{type = 'import_deform', node = 'male_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
			{type = 'import_deform', node = 'Female_pose/HumanF1/Spine/Head/Hair/Hairs_assist_mesh', material = "res://Character_generator/shaders/shaders_deform_hair_length/hair_lengh_short.tres"},
		],
	},
	
	#base version
	#looks weird
#	height = {
#		tiny = [
#			{type = 'scale', value = 0.69},
#			{type = 'offset', value_x = 0.0, value_y = 120},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.68, 0.68)},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.32, 1.32)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.68, 0.68)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.32, 1.32)},
#		],
#		petite = [
#			{type = 'scale', value = 0.75},
#			{type = 'offset', value_x = 0.0, value_y = 80},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.68, 0.68)},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.32, 1.32)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.68, 0.68)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.32, 1.32)},
#		],
#		short = [
#			{type = 'scale', value = 0.88},
#			{type = 'offset', value_x = 0.0, value_y = 30},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.76, 0.76)},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.24, 1.24)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.76, 0.76)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.24, 1.24)},
#		],
#		average = [
#			{type = 'scale', value = 1.0},
#			{type = 'offset', value_x = 0.0, value_y = 0},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.84, 0.84)},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.16, 1.16)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.84, 0.84)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.16, 1.16)},
#		],
#		tall = [
#			{type = 'scale', value = 1.13},
#			{type = 'offset', value_x = 0.0, value_y = -20},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.92, 0.92)},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.08, 1.08)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(0.92, 0.92)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.08, 1.08)},
#		],
#		towering = [
#			{type = 'scale', value = 1.2},
#			{type = 'offset', value_x = 0.0, value_y = -50},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.0, 1.0)},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.0, 1.0)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.0, 1.0)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.0, 1.0)},
#		],
#	},
#
	#adv version
	#i corrected values to add sixth value
	#overall height and head scale are wrong
	height = {
		tiny = [
			{type = 'scale', value = 0.75},
			{type = 'offset', value_x = 0.0, value_y = 60},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'scale', value = Vector2(1.25, 1.25)},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'position', value = Vector2(-560, 545)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.25, 1.25)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-415, 9)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.25, 1.25)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-415, 9)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_huge', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_big', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_normal', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_small', attr = 'scale', value = Vector2(1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_zero', attr = 'scale', value = Vector2(1, 1)},
		],
		petite = [
			{type = 'scale', value = 0.85},
			{type = 'offset', value_x = 0.0, value_y = 50},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'scale', value = Vector2(1.1, 1.07)},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'position', value = Vector2(-520, 480)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.025, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.15, 1.15)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-400, 9)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.07, 1.1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.025, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(1.15, 1.15)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-400, 9)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_huge', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_big', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_normal', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_small', attr = 'scale', value = Vector2(0.975, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_zero', attr = 'scale', value = Vector2(0.975, 1)},
		],
		short = [
			{type = 'scale', value = 1},
			{type = 'offset', value_x = 0.0, value_y = 40},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'scale', value = Vector2(1, 0.95)},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'position', value = Vector2(-505, 438)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.05, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-355, 9)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.05, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-355, 9)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_huge', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_big', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_normal', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_small', attr = 'scale', value = Vector2(0.95, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_zero', attr = 'scale', value = Vector2(0.95, 1)},
		],
		average = [
			{type = 'scale', value = 1.1},
			{type = 'offset', value_x = 0.0, value_y = 30},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'scale', value = Vector2(1, 0.925)},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'position', value = Vector2(-495, 438)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.075, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-352, 9)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.075, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-352, 9)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_huge', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_big', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_normal', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_small', attr = 'scale', value = Vector2(0.925, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_zero', attr = 'scale', value = Vector2(0.925, 1)},
		],
		tall = [
			{type = 'scale', value = 1.2},
			{type = 'offset', value_x = 0.0, value_y = 0},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'scale', value = Vector2(1, 0.9)},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'position', value = Vector2(-475, 438)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.1, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-349, 9)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.1, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-349, 9)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_huge', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_big', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_normal', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_small', attr = 'scale', value = Vector2(0.9, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_zero', attr = 'scale', value = Vector2(0.9, 1)},
		],
		towering = [
			{type = 'scale', value = 1.3},
			{type = 'offset', value_x = 0.0, value_y = -30},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.125, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.85, 0.9)},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'scale', value = Vector2(0.9, 0.79)},
#			{type = 'node_group_attr', group = 'hairs_back', attr = 'position', value = Vector2(-445, 395)},
#			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'position', value = Vector2(-490, 355)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_mesh', attr = 'position', value = Vector2(-445, 395)},
#			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head/Hairs_back_long_mesh', attr = 'position', value = Vector2(-445, 395)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-316, 9)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'scale', value = Vector2(1.125, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'scale', value = Vector2(0.85, 0.9)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Head', attr = 'position', value = Vector2(-316, 9)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_huge', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_big', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_normal', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_small', attr = 'scale', value = Vector2(0.875, 1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_zero', attr = 'scale', value = Vector2(0.875, 1)},
		],
	},
	
	ass_size = {
		flat = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.0)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.0)},
		],
		small = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.04)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.04)},
		],
		average = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.08)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.08)},
		],
		big = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.12)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.12)},
		],
		huge = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.15)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.15)},
		],
		masculine = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.0)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'scale', value = Vector2(1.0, 1.0)},
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
		small = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Chin_tex', texture = "res://Character_generator/images/01_heads/head_chin_small.png"},
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
		beastkin = [],
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
		beastkin = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = null},
		],
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
		small = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Nose_tex', texture = "res://Character_generator/images/03_noses/nose_small.png"},
		],
		straight = [
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
		beastkin_cry = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/17_beastkin_lips/beastkin_lips_cry.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/17_beastkin_lips/beastkin_lips_cry.png"},
		],
		beastkin_open = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/17_beastkin_lips/beastkin_lips_open.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/17_beastkin_lips/beastkin_lips_open.png"},
		],
		beastkin_smile = [
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/17_beastkin_lips/beastkin_lips_smile.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Face/Lips_tex', texture = "res://Character_generator/images/17_beastkin_lips/beastkin_lips_smile.png"},
		],
	},
	
	#armor
	#those are built based on allanheil's table
	armor_base = {
		null: [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.0},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = null},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		underwear = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/104_armory_set_slave_female/tits_slave_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/104_armory_set_slave_female/tits_slave_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/104_armory_set_slave_female/tits_slave_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/104_armory_set_slave_female/tits_slave_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/104_armory_set_slave_female/tits_slave_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/104_armory_set_slave_female/pregnancy_slave_mid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/104_armory_set_slave_female/Pregnancy_slave_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		lacy_underwear = [ #for test
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/105_armory_set_gipure1_female/torso_armor_gipure1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/105_armory_set_gipure1_female/tits_gipure1_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/105_armory_set_gipure1_female/tits_gipure1_normal.png"},#2fix
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/105_armory_set_gipure1_female/tits_gipure1_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/105_armory_set_gipure1_female/tits_gipure1_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/105_armory_set_gipure1_female/tits_gipure1_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/105_armory_set_gipure1_female/Pregnancy_gipure1_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/105_armory_set_gipure1_female/Pregnancy_gipure1_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		seethrough_underwear = [ #for test
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = null},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/106_armory_set_gipure2_female/tirso_armor_gipure2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/106_armory_set_gipure2_female/tits_gipure2_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/106_armory_set_gipure2_female/tits_gipure2_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/106_armory_set_gipure2_female/tits_gipure2_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/106_armory_set_gipure2_female/tits_gipure2_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/106_armory_set_gipure2_female/tits_gipure2_o.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/106_armory_set_gipure2_female/Pregnancy_gipure2_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/106_armory_set_gipure2_female/Pregnancy_gipure2_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		servant = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.0},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ArmR1_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ShoulderR_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ArmL1_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/ShoulderL_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/100_armory_set_servant_male/torso_armor_m1.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand1_armorR1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand2_armorR2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand_armorR3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Arm_armorR1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Shoulder_armorR1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand1_armorL1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand2_armorL2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Hand_armorL3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Arm_armorL1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/Shoulder_armorL1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/99_armory_set_maidu/bluza.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/99_armory_set_maidu/tits_armor1_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = "res://Character_generator/images/99_armory_set_maidu/hair_armor_maid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/99_armory_set_maidu/Pregnancy_maidu_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/99_armory_set_maidu/Pregnancy_maidu_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 0},
		],
		jacket = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/125_armory_set_jacket_male/torso_armor_m_jacket.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/107_armory_set_jacket_female/torso_armor_jacket.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/107_armory_set_jacket_female/tits_jacket_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/107_armory_set_jacket_female/tits_jacket_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/107_armory_set_jacket_female/tits_jacket_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/107_armory_set_jacket_female/tits_jacket_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/107_armory_set_jacket_female/tits_jacket_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/107_armory_set_jacket_female/pregnancy_jacket_mid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/107_armory_set_jacket_female/Pregnancy_jacket_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		latex_suit = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.0},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/HandR1_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/HandR2_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/ArmR1_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/ShoulderR_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture ="res://Character_generator/images/124_armory_set_latex_male/HandL1_m_latex.png" },
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/HandL2_m_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/ArmL1_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/ShoulderL_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/124_armory_set_latex_male/torso_armor_m_latex.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/HandR1_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/HandR2_latex2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/HandR_armor_latex3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/Arm_armorR_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/Shoulder_armorR_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/HandL1_armor_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/HandL2_latex2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/HandL_armor_latex3.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/Arm_armorL_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/Shoulder_armorL_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/108_armory_set_latex_female/torso_armor_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/108_armory_set_latex_female/tits_latex_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/108_armory_set_latex_female/tits_large_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/108_armory_set_latex_female/tits_normal_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/108_armory_set_latex_female/tits_small_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/108_armory_set_latex_female/tits_small_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/108_armory_set_latex_female/pregnancy_latex_mid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/108_armory_set_latex_female/pregnancy_latex_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		service_suit = [ #male part is waiter - may change to any other colorable male set
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/HandR1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/ArmR1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/SoulderR_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/HandL1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/ArmL1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/SoulderL_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/124_armory_set_waiter_male/torso_armor_m_waiter.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/HandR1_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/HandR2_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/HandR3_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/ArmR1_armorR_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/Shoulder_armorR_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/HandL1_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/HandL2_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/HandL3_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/ArmL1_armorL_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/Shoulder_armorL_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/112_armory_set_playboy_female/torso_armor_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/112_armory_set_playboy_female/tits_playboy_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/112_armory_set_playboy_female/tits_playboy_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/112_armory_set_playboy_female/tits_playboy_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/112_armory_set_playboy_female/tits_playboy_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/112_armory_set_playboy_female/tits_playboy_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/112_armory_set_playboy_female/pregnancy_playboy_mid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/112_armory_set_playboy_female/pregnancy_playboy_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		
		worker_outfit = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/HandR1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/ArmR1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/SoulderR_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/HandL1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/ArmL1_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/SoulderL_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/124_armory_set_waiter_male/torso_armor_m_waiter.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/109_armory_set_waitress_female/waitress_back.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/109_armory_set_waitress_female/Shoulder_armorR_waitress.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/109_armory_set_waitress_female/Shoulder_armorL_waitress.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/109_armory_set_waitress_female/torso_armor_waitress.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/109_armory_set_waitress_female/tits_waitress_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/109_armory_set_waitress_female/tits_waitress_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/109_armory_set_waitress_female/tits_waitress_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/109_armory_set_waitress_female/tits_waitress_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/109_armory_set_waitress_female/tits_waitress_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = "res://Character_generator/images/109_armory_set_waitress_female/hair_armor_waitress.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/109_armory_set_waitress_female/pregnancy_waitress_mid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/109_armory_set_waitress_female/pregnancy_waitress_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		craftsman_suit = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/123_armory_set_smith_male/ArmR1_armor_smith.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/123_armory_set_smith_male/ArmL1_armor_smith.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/123_armory_set_smith_male/torso_armor_m_smith.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/110_armory_set_smith_female/Arm_armorR_smith.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/110_armory_set_smith_female/Arm_armorL_smith.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/110_armory_set_smith_female/torso_armor_smith.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/110_armory_set_smith_female/tits_smith_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/110_armory_set_smith_female/tits_smith_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/110_armory_set_smith_female/tits_smith_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/110_armory_set_smith_female/tits_smith_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/110_armory_set_smith_female/tits_smith_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/110_armory_set_smith_female/pregnancy_smith_mid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/110_armory_set_smith_female/pregnancy_smith_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		tentacle_suit = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/125_armory_set_tentackle_male/torso_armor_m_tentacke.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/111_armory_set_tentackle_female/torso_armor_tentackle.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/111_armory_set_tentackle_female/tits_tentacle_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/111_armory_set_tentackle_female/tits_tentackle_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/111_armory_set_tentackle_female/tits_tentackle_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/111_armory_set_tentackle_female/tits_small_tentackle.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/111_armory_set_tentackle_female/tits_small_tentackle.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/111_armory_set_tentackle_female/pregnancy_belly_mid.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/111_armory_set_tentackle_female/pregnancy_tentackle_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		
		chest_base_cloth = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/torso_armor_cloth3.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorR_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorL_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/torso_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		chest_adv_cloth = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/121_armory_set_cloth_male/torso_armor_cloth3.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null },
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorR_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/Shoulder_armorL_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/torso_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/101_armory_set_cloth_female/tits_cloth_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/101_armory_set_cloth_female/Pregnancy_cloth_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		chest_base_leather = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandR2_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandL2_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/torso_armor_leather.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorR_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorL_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/torso_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_leather.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		chest_adv_leather = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandR2_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmR1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/HandL2_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ArmL1_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/ShoulderL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/122_armory_set_leather_male/torso_armor_leather.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorR_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/Arm_armorL_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/torso_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/102_armory_set_leather_female/tits_leather_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/102_armory_set_leather_female/Pregnancy_skin_leather.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		chest_base_metal = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandR2_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandL2_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/torso_armor_plate2.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorR_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorL_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/torso_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
		chest_adv_metal = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/raincoat_cloth2.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmR1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/HandL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ArmL1_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/ShoulderL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/123_armory_set_plate_male/torso_armor_plate2.png"},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Tits/Tits_armor_mesh2', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Raincoat_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/raincoat_cloth2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3/HandR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorR_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderR/ShoulderR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3/HandL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/Arm_armorL_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/ShoulderL/ShoulderL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/torso_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_huge/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_big/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_large.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_normal/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_normal.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_small/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Tits_zero/Tits_armor_mesh2', texture = "res://Character_generator/images/103_armory_set_plate_female/tits_plate_0.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Head/Head_armor_tex', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy/pregnancy_armor_tex', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_small.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Pregnancy2/pregnancy_armor_tex2', texture = "res://Character_generator/images/103_armory_set_plate_female/Pregnancy_plate_big.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/ArmR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/ArmL_armor', attr = 'z_index', value = 1},
		],
	},
	
	armor_lower = {
		null: [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Pregnancy2', attr = 'z_index', value = 0},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.0},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = null},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		underwear = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/LegL_armor_slave.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/LegR_armor_slave.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/taz_armor_slave.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/104_armory_set_slave_female/taz_armor_slave.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		lacy_underwear = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/LegL_armor_slave.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/LegR_armor_slave.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/taz_armor_slave.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/105_armory_set_gipure1_female/LegL_armor_gipure1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/105_armory_set_gipure1_female/LegR_armor_gipure1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/105_armory_set_gipure1_female/taz_armor_gipure1.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		seethrough_underwear = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/LegL_armor_slave.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/LegR_armor_slave.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/104_armory_set_slave_male/taz_armor_slave.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/106_armory_set_gipure2_female/taz_armor_gipure2.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		servant = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.0},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/LegL_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/LegR_armor_m1.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/100_armory_set_servant_male/taz_armor_m1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/99_armory_set_maidu/LegL_armor1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/99_armory_set_maidu/LegR_armor1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/99_armory_set_maidu/yubka.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		jacket = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/125_armory_set_jacket_male/LegL_armor_jacket.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/125_armory_set_jacket_male/LegR_armor_jacket.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/125_armory_set_jacket_male/taz_armor_m_jacket.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/107_armory_set_jacket_female/LegL_armor_jacket.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/107_armory_set_jacket_female/LegR_armor_jacket.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/107_armory_set_jacket_female/taz_armor_jacket.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		latex_suit = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.0},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/LegL_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/LegR_armor_latex.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/124_armory_set_latex_male/taz_armor_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/LegL_armor_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/LegR_armor_latex.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/108_armory_set_latex_female/taz_armor_latex.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		worker_outfit = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/LegL_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/LegR_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/taz_armor_m_waiter.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/109_armory_set_waitress_female/taz_armor_waitress.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		service_suit  = [ #same as top
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/LegL_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/LegR_armor_waiter.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/124_armory_set_waiter_male/taz_armor_m_waiter.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/LegL_armor_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/LegR_armor_playboy.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/112_armory_set_playboy_female/taz_armor_playboy.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		craftsman_suit = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/123_armory_set_smith_male/LegL_armor_smith.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/123_armory_set_smith_male/LegR_armor_smith.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/123_armory_set_smith_male/taz_armor_m_smith.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/110_armory_set_smith_female/LegL_armor_smith.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/110_armory_set_smith_female/LegR_armor_smith.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/110_armory_set_smith_female/taz_armor_smith.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 6},
		],
		tentacle_suit = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/125_armory_set_tentackle_male/taz_armor_tentackle.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/111_armory_set_tentackle_female/taz_armor_tentackle.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		legs_base_cloth = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegL_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegR_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/taz_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/taz_armor_cloth.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		legs_adv_cloth = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegL_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/LegR_armor_cloth.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/121_armory_set_cloth_male/taz_armor_cloth.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = null},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/101_armory_set_cloth_female/taz_armor_cloth.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		legs_base_leather = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/taz_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegL_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegR_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/taz_armor_leather.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		legs_adv_leather = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegL_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/LegR_armor_leather.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/122_armory_set_leather_male/taz_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegL_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/LegR_armor_leather.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/102_armory_set_leather_female/taz_armor_leather.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		legs_base_metal = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/taz_armor_plate2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegL_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegR_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/taz_armor_plate.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
		legs_adv_metal = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'visible', value = false},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'range', color = 0.1},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegL_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/LegR_armor_plate.png"},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/123_armory_set_plate_male/taz_armor_plate2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegL_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/LegR_armor_plate.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', texture = "res://Character_generator/images/103_armory_set_plate_female/taz_armor_plate.png"},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL/LegL_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR/LegR_armor', attr = 'z_index', value = 1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Taz_armor', attr = 'z_index', value = 1},
		],
	},
	armor_collar = {
		null: [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = false},
		],
		amulet_of_recognition = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = false},
		],
		leather_collar = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/126_armory_acces_collars_male/collar_leather_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/150_armory_acces_collars/collar_leather.png"},
		],
		elegant_choker  = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/126_armory_acces_collars_male/collar_heart_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/150_armory_acces_collars/collar_heart.png"},
		],
		steel_collar  = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/126_armory_acces_collars_male/collar_steel_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/150_armory_acces_collars/collar_steel.png"},
		],
		pet_suit  = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/126_armory_acces_collars_male/collar_leather_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/150_armory_acces_collars/collar_leather.png"},
		],
		enslaving_collar  = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/126_armory_acces_collars_male/collar_steel_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/150_armory_acces_collars/collar_steel.png"},
		],
		bell_collar  = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/126_armory_acces_collars_male/collar_bell_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/150_armory_acces_collars/collar_bell.png"},
		],
		service_suit = [ #male version still copied
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', attr = 'visible', value = true},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/126_armory_acces_collars_male/collar_heart_big.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Torso_collar_tex', texture = "res://Character_generator/images/112_armory_set_playboy_female/collar_playboy.png"},
		],
	},
	
	armor_weapon = { #textures added in orded, you can change variants
		null: [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
		],
		cali_heirloom = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
		],
		cali_heirloom_active = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
		],
		holy_sword = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
		],
		sword = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword.png"},
		],
		swordadv = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_sword2.png"},
		],
		dagger = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_dagger.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_dagger.png"},
		],
		club = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_bat.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_bat.png"},
		],
		mace = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_mace.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_belt', texture = "res://Character_generator/images/200_weapon_belt/weapon_belt_mace.png"},
		],
		
		holy_spear = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_spear.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_spear.png"},
		],
		spearadv = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_spear.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_spear.png"},
		],
		spear = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_spear2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_spear2.png"},
		],
		aire_bow = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_bow2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_bow2.png"},
		],
		bowadv = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_bow2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_bow2.png"},
		],
		bow = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_bow.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_bow.png"},
		],
		staff = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_stick2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_stick2.png"},
		],
		staffadv = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_stick.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_stick.png"},
		],
		battleaxe = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_axe1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_axe1.png"},
		],
		battleaxeadv  = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_axe2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_axe2.png"},
		],
		maceadv = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_mace2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_mace2.png"},
		],
		crossbow = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_crossbow1.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_crossbow1.png"},
		],
		crossbowadv = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_belt', attr = 'visible', value = false},
			{type = 'texture', node = 'male_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_crossbow2.png"},
			{type = 'texture', node = 'Female_pose/HumanF1/Spine/Weapon_back', texture = "res://Character_generator/images/201_weapon_back/weapon_back_crossbow2.png"},
		],
	},
	
	armor_color = {
		default = [ #cloth
			{type = 'item_recolor_group', group = 'cloth', part = 'part1color', color = Color('989898')},
			{type = 'item_recolor_group', group = 'cloth', part = 'part2color', color = Color('795293')},
		],
		default_leather = [ #leather
			{type = 'item_recolor_group', group = 'cloth', part = 'part1color', color = Color('b89836')},
			{type = 'item_recolor_group', group = 'cloth', part = 'part2color', color = Color('98B8C6')},
		],
		
		default_metal = [ #metal
			{type = 'item_recolor_group', group = 'cloth', part = 'part1color', color = Color('506079')},
			{type = 'item_recolor_group', group = 'cloth', part = 'part2color', color = Color('6e2424')},
		],
		default_underwear = [
			{type = 'item_recolor_group', group = 'cloth', part = 'part1color', color = Color('654a3e')},
			{type = 'item_recolor_group', group = 'cloth', part = 'part2color', color = Color('98B8C6')},
		],
	},
	
	#2change part3color in ALL templates!!
	armor_color_base = {
		default = [ #cloth
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part1color', color = Color('989898')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part2color', color = Color('795293')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part3color', color = Color('795293')},
		],
		default_leather = [ #leather
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part1color', color = Color('b89836')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part3color', color = Color('98B8C6')},
		],
		
		default_metal = [ #metal
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part1color', color = Color('506079')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part2color', color = Color('6e2424')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part3color', color = Color('6e2424')},
		],
		default_underwear = [
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part1color', color = Color('654a3e')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'cloth_top', part = 'part3color', color = Color('98B8C6')},
		],
	},
	
	armor_color_lower = {
		default = [ #cloth
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part1color', color = Color('989898')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part2color', color = Color('795293')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part3color', color = Color('795293')},
		],
		default_leather = [ #leather
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part1color', color = Color('b89836')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part3color', color = Color('98B8C6')},
		],
		
		default_metal = [ #metal
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part1color', color = Color('506079')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part2color', color = Color('6e2424')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part3color', color = Color('6e2424')},
		],
		default_underwear = [
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part1color', color = Color('654a3e')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'cloth_bottom', part = 'part3color', color = Color('98B8C6')},
		],
	},
	
	armor_color_collar = {
		default = [ #cloth
			{type = 'item_recolor_group', group = 'collar', part = 'part1color', color = Color('989898')},
			{type = 'item_recolor_group', group = 'collar', part = 'part2color', color = Color('b07007')},
			{type = 'item_recolor_group', group = 'collar', part = 'part3color', color = Color('b07007')},
		],
		default_leather = [ #leather
			{type = 'item_recolor_group', group = 'collar', part = 'part1color', color = Color('b89836')},
			{type = 'item_recolor_group', group = 'collar', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'collar', part = 'part3color', color = Color('98B8C6')},
		],
		
		default_metal = [ #metal
			{type = 'item_recolor_group', group = 'collar', part = 'part1color', color = Color('506079')},
			{type = 'item_recolor_group', group = 'collar', part = 'part2color', color = Color('6e2424')},
			{type = 'item_recolor_group', group = 'collar', part = 'part3color', color = Color('6e2424')},
		],
		default_underwear = [
			{type = 'item_recolor_group', group = 'collar', part = 'part1color', color = Color('654a3e')},
			{type = 'item_recolor_group', group = 'collar', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'collar', part = 'part3color', color = Color('98B8C6')},
		],
	},
	
	armor_color_weapon = { #copied from above
		default = [ #cloth
			{type = 'item_recolor_group', group = 'weapon', part = 'part1color', color = Color('989898')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part2color', color = Color('7a6748')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part3color', color = Color('7a6748')},
		],
		default_leather = [ #leather
			{type = 'item_recolor_group', group = 'weapon', part = 'part1color', color = Color('b89836')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part3color', color = Color('98B8C6')},
		],
		
		default_metal = [ #metal
			{type = 'item_recolor_group', group = 'weapon', part = 'part1color', color = Color('506079')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part2color', color = Color('6e2424')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part3color', color = Color('6e2424')},
		],
		default_underwear = [
			{type = 'item_recolor_group', group = 'weapon', part = 'part1color', color = Color('654a3e')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part2color', color = Color('98B8C6')},
			{type = 'item_recolor_group', group = 'weapon', part = 'part3color', color = Color('98B8C6')},
		],
	},
	
	pose = {
		kind = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'rotation_degrees', value = 90},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'rotation_degrees', value = 8.8},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'position', value = Vector2(-105, -101)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'position', value = Vector2(220, -11)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'position', value = Vector2(147, -34)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'position', value = Vector2(147, -34)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'position', value = Vector2(147, -34)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'position', value = Vector2(-95, 106)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'position', value = Vector2(225.3, -7.3)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'position', value = Vector2(134.8, 21)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'position', value = Vector2(134.8, 21)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'position', value = Vector2(134.8, 21)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'position', value = Vector2(206.4, -2.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'position', value = Vector2(94.4, 82.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'position', value = Vector2(96.9, -45.6)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'position', value = Vector2(54.9, 2)},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body', attr = 'z_index', value = -4},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'z_index', value = -4},
			
			{type = 'node_group_select', group = 'hand_l', select = 'HandL'},
			{type = 'node_group_select', group = 'hand_r', select = 'HandR'},
		],
		shy = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'rotation_degrees', value = 94.6},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'rotation_degrees', value = 3.2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'rotation_degrees', value = -8.8},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'rotation_degrees', value = -8.8},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'rotation_degrees', value = -2.4},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'rotation_degrees', value = 4.3},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'rotation_degrees', value = 8.8},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'position', value = Vector2(-105, -101)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'position', value = Vector2(220, -11)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'position', value = Vector2(147, -34)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'position', value = Vector2(147, -34)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'position', value = Vector2(147, -34)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'position', value = Vector2(-95, 106)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'position', value = Vector2(225.3, -7.4)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'position', value = Vector2(136.8, 21.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'position', value = Vector2(136.8, 21.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'position', value = Vector2(136.8, 21.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'position', value = Vector2(206.4, -5.4)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'position', value = Vector2(94.4, 80.7)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'position', value = Vector2(96.9, -44.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'position', value = Vector2(54.9, 2.1)},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body', attr = 'z_index', value = -4},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'z_index', value = -4},
			
			{type = 'node_group_select', group = 'hand_l', select = 'HandL'},
			{type = 'node_group_select', group = 'hand_r', select = 'HandR'},
		],
		bold = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'rotation_degrees', value = 90},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'rotation_degrees', value = -44.9},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'rotation_degrees', value = 107.2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'rotation_degrees', value = -7.3},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'rotation_degrees', value = -7.3},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'rotation_degrees', value = -7.3},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'rotation_degrees', value = 50.3},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'rotation_degrees', value = -105.4},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'rotation_degrees', value = 8.4},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'rotation_degrees', value = -7.5},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'rotation_degrees', value = -23.9},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'rotation_degrees', value = -8.4},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'position', value = Vector2(-93, -80)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'position', value = Vector2(220, -11)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'position', value = Vector2(138.3, -33.2)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'position', value = Vector2(138.3, -33.2)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'position', value = Vector2(138.3, -33.2)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'position', value = Vector2(-97, 88)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'position', value = Vector2(198.4, -1.4)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'position', value = Vector2(136.8, 21.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'position', value = Vector2(136.8, 21.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'position', value = Vector2(136.8, 21.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'position', value = Vector2(206, 5)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'position', value = Vector2(93.4, 77.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'position', value = Vector2(88.3, -45.4)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'position', value = Vector2(61.2, 9.9)},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body', attr = 'z_index', value = -4},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'z_index', value = -4},
			
			{type = 'node_group_select', group = 'hand_l', select = 'HandL3'},
			{type = 'node_group_select', group = 'hand_r', select = 'HandR3'},
		],
		pose4 = [
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine', attr = 'rotation_degrees', value = 90},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'rotation_degrees', value = 0.8},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'rotation_degrees', value = 17.1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'rotation_degrees', value = -8},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'rotation_degrees', value = -8},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'rotation_degrees', value = -8},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'rotation_degrees', value = -3.4},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'rotation_degrees', value = -96},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'rotation_degrees', value = 2.5},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'rotation_degrees', value = 2.5},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'rotation_degrees', value = 2.5},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'rotation_degrees', value = -6},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'rotation_degrees', value = 5.1},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'rotation_degrees', value = -8.4},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR', attr = 'position', value = Vector2(-105, -101)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'position', value = Vector2(215, -8)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'position', value = Vector2(140, -34.3)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'position', value = Vector2(140, -34.3)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR/HandR3', attr = 'position', value = Vector2(140, -34.3)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL', attr = 'position', value = Vector2(-95, 106)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'position', value = Vector2(201, -7.4)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'position', value = Vector2(140.1, 18.7)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'position', value = Vector2(140.1, 18.7)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL/HandL3', attr = 'position', value = Vector2(140.1, 18.7)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz', attr = 'position', value = Vector2(206.4, -2.1)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegL', attr = 'position', value = Vector2(92.6, 77.8)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/LegR', attr = 'position', value = Vector2(96.6, -44.6)},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Taz/Dick', attr = 'position', value = Vector2(61.2, 9.9)},
			
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'z_index', value = 14},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'z_index', value = 6},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Animal_body', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'Female_pose/HumanF1/Spine/Weapon_back', attr = 'z_index', value = -2},
			
			{type = 'node_group_select', group = 'hand_l', select = 'HandL2'},
			{type = 'node_group_select', group = 'hand_r', select = 'HandR3'},
		],
		pose5 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'rotation_degrees', value = 90},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegR', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'rotation_degrees', value = 9},
			
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'position', value = Vector2(-89.5, -143)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'position', value = Vector2(220, -11)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'position', value = Vector2(179, -35)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'position', value = Vector2(179, -35)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'position', value = Vector2(-87.5, 124.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'position', value = Vector2(225, 9.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'position', value = Vector2(189, 27.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'position', value = Vector2(189, 27.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'position', value = Vector2(225, 0)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegL', attr = 'position', value = Vector2(94.5, 77.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegR', attr = 'position', value = Vector2(97, -45.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'position', value = Vector2(55, 2)},
			
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body', attr = 'z_index', value = -4},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'z_index', value = -4},
			{type = 'node_group_select', group = 'hand_l', select = 'HandL'},
			{type = 'node_group_select', group = 'hand_r', select = 'HandR'},
			
		],
		pose6 = [
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine', attr = 'rotation_degrees', value = 90},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'rotation_degrees', value = -40.5},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'rotation_degrees', value = 88.5},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'rotation_degrees', value = -10},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'rotation_degrees', value = -10},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'rotation_degrees', value = -9.5},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'rotation_degrees', value = 9},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'rotation_degrees', value = 9},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'rotation_degrees', value = 0},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegL', attr = 'rotation_degrees', value = -2.5},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegR', attr = 'rotation_degrees', value = -6},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'rotation_degrees', value = 9},
			
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR', attr = 'position', value = Vector2(-81, -116.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'position', value = Vector2(194, -27)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR', attr = 'position', value = Vector2(199.5, -38)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR/HandR2', attr = 'position', value = Vector2(199.5, -38)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL', attr = 'position', value = Vector2(-89.5, 122.5)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'position', value = Vector2(211.5, 3)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL', attr = 'position', value = Vector2(200, 36)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL/HandL2', attr = 'position', value = Vector2(200, 36)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz', attr = 'position', value = Vector2(222.5, 0)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegL', attr = 'position', value = Vector2(107.5, 77)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/LegR', attr = 'position', value = Vector2(100, -49)},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Taz/Dick', attr = 'position', value = Vector2(55, 2)},
			
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderL/ArmL', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/ShoulderR/ArmR', attr = 'z_index', value = -2},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Animal_body', attr = 'z_index', value = -4},
			{type = 'node_attr', node = 'male_pose/HumanF1/Spine/Weapon_back', attr = 'z_index', value = -4},
			{type = 'node_group_select', group = 'hand_l', select = 'HandL'},
			{type = 'node_group_select', group = 'hand_r', select = 'HandR2'},
			
		],
	},
}

#func _ready():
#	fix_data()
#
#func fix_data():
#	var shader = load("res://assets/ItemShader.tres").duplicate()
