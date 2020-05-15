extends Node

var backgrounds = {
	#backgrounds
	Null = null,
	dungeon = load("res://assets/images/backgrounds/dungeon.png"),
	aliron = load("res://assets/images/backgrounds/Aliron.png"),
	elf_capital = load("res://assets/images/backgrounds/elf_capital.png"),
	
	cave_1 = load("res://assets/images/backgrounds/cave1.png"),
	cave_2 = load("res://assets/images/backgrounds/cave2.png"),
	cave_3 = load("res://assets/images/backgrounds/cave3.png"),
	
	village = load("res://assets/images/backgrounds/village.png"),
	#scenes
	}

var scenes = {
	no_image = load("res://assets/images/scenes/image_wip.png"),
	abuse = load("res://assets/images/scenes/abuse.png"),
	bosscapturefemale = load("res://assets/images/scenes/bosscapturefemale.png"),
	bosscapturemale = load("res://assets/images/scenes/bosscapturemale.png"),
	cell = load("res://assets/images/scenes/cell.png"),
	charm = load("res://assets/images/scenes/charm.png"),
	chest = load("res://assets/images/scenes/chest.png"),
	childbirth = load("res://assets/images/scenes/childbirth.png"),
	daisyconfess = load("res://assets/images/scenes/daisyconfession.png"),
	daisyevent = load("res://assets/images/scenes/daisyevent.png"),
	daisystart = load("res://assets/images/scenes/daisystart.png"),
	dungeonclear = load("res://assets/images/scenes/dungeonclear.png"),
	execution = load("res://assets/images/scenes/execution.png"),
	exotic_slaver = load("res://assets/images/scenes/exotic_slaver.png"),
	fear = load("res://assets/images/scenes/fear.png"),
	locationpurchase = load("res://assets/images/scenes/locationpurchase.png"),
	mindcontrol = load("res://assets/images/scenes/mindcontrol.png"),
	noevent = load("res://assets/images/scenes/noevent.png"),
	pot = load("res://assets/images/scenes/pot.png"),
	potmaj = load("res://assets/images/scenes/potmaj.png"),
	potmin = load("res://assets/images/scenes/potmin.png"),
	potused = load("res://assets/images/scenes/potused.png"),
	praise = load("res://assets/images/scenes/praise.png"),
	public_punish = load("res://assets/images/scenes/public_punish.png"),
	public_sex = load("res://assets/images/scenes/public_sex.png"),
	punish = load("res://assets/images/scenes/punish.png"),
	rebels_furry = load("res://assets/images/scenes/rebels_furry.png"),
	recruit = load("res://assets/images/scenes/recruit.png"),
	sedation = load("res://assets/images/scenes/sedation.png"),
	seduce = load("res://assets/images/scenes/seduce.png"),
	serve = load("res://assets/images/scenes/serve.png"),
	sexreward = load("res://assets/images/scenes/sexreward.png"),
	shackles = load("res://assets/images/scenes/shackles.png"),
	slaveescape = load("res://assets/images/scenes/slaveescape.png"),
	slavers_elf = load("res://assets/images/scenes/slavers_elf.png"),
	slave_decision = load("res://assets/images/scenes/slave_decision.png"),
	souleat = load("res://assets/images/scenes/souleat.png"),
	succubuslust = load("res://assets/images/scenes/succubuslust.png"),
	trap = load("res://assets/images/scenes/trap.png"),
	warn = load("res://assets/images/scenes/warn.png"),
	wolves_skirmish = load("res://assets/images/scenes/wolves_skirmish.png"),
}

var sprites = {
	amelia = load("res://assets/images/sprites/amelia.png"),
	duncan = load("res://assets/images/sprites/duncan.png"),
	sigmund = load("res://assets/images/sprites/sigmund.png"),
	myr = load("res://assets/images/sprites/myr.png"),
	anastasia = load("res://assets/images/sprites/anastasia.png"),
	aire = load("res://assets/images/sprites/aire.png"),
	}

var dynamic_backgrounds = {
	aliron = load("res://assets/dynamic_backgrounds/aliron.ogv"),
	elf_capital = load("res://assets/dynamic_backgrounds/elf_capital.ogv"),
	furry_capital = load("res://assets/dynamic_backgrounds/furry_camp.ogv"),
}

var portraits = {
	daisy = 'res://assets/images/portraits/daisy.png'
}

var gui = {
	norm_back = load("res://assets/images/gui/text scene/textfieldpanel.png"),
	alt_back = load("res://assets/images/gui/text scene/textfieldpanel.png"), #stub
};


var icons = {
	food = "res://assets/images/gui/inventory/icon_food1.png",
	material = "res://assets/images/gui/inventory/icon_res1.png",
	'tool' : "res://assets/images/gui/inventory/icon_craft1.png",
	weapon = "res://assets/images/gui/inventory/icon_weap1.png",
	armor = "res://assets/images/gui/inventory/icon_armor1.png",
	costume = "res://assets/images/gui/inventory/icon_cosm1.png",
	usable = "res://assets/images/gui/inventory/icon_potion1.png",
	
	quest_dungeon = load('res://assets/images/gui/quest_dungeon.png'),
	quest_char = load("res://assets/images/gui/quest_char.png"),
	quest_encounter = load("res://assets/images/gui/quest_encounter.png"),
	quest_enemy = load("res://assets/images/gui/quest_enemy.png"),
	quest_reputation = load("res://assets/images/gui/quest_reputation.png"),
	
	upgrade_farm = 'res://assets/images/buildings/upgrade_farm.png',
	
	stat_exp = "res://assets/images/gui/gui icons/base_exp.png",
	stat_gf = "res://assets/images/gui/gui icons/growth_factor.png",
	stat_pf = "res://assets/images/gui/gui icons/physics_factor.png",
	stat_wit = "res://assets/images/gui/gui icons/wit.png",
	stat_charm = "res://assets/images/gui/gui icons/charm.png",
	stat_sf = "res://assets/images/gui/gui icons/sex.png", 
	stat_mf = "res://assets/images/gui/gui icons/magic_factor.png",
	stat_tf = "res://assets/images/gui/gui icons/tame_factor.png",
	stat_df = "res://assets/images/gui/gui icons/timid_factor.png",
	stat_bf = "res://assets/images/gui/gui icons/brave_factor.png",
	stat_obed = "res://assets/images/gui/obed_good.png",
	stat_fear = "res://assets/images/gui/fear_good.png",
	stat_cf = "res://assets/images/gui/gui icons/charm_factor.png",
	stat_food = "res://assets/images/gui/gui icons/food.png",
	obed_good = "res://assets/images/gui/obed_good.png",
	obed_bad = "res://assets/images/gui/obed_bad.png",
	
	food_love = "res://assets/images/gui/gui icons/food_love.png",
	food_hate = "res://assets/images/gui/gui icons/food_hate.png",
	meat = "res://assets/images/gui/gui icons/icon_meat.png",
	fish = "res://assets/images/gui/gui icons/icon_fish.png",
	vege = "res://assets/images/gui/gui icons/icon_veg.png",
	grain = "res://assets/images/gui/gui icons/icon_grain.png",
	
	fear1 = "res://assets/images/gui/gui icons/fear1.png",
	fear2 = "res://assets/images/gui/gui icons/fear2.png",
	fear3 = "res://assets/images/gui/gui icons/fear3.png",
	obed1 = "res://assets/images/gui/gui icons/obedience1.png",
	obed2 = "res://assets/images/gui/gui icons/obedience2.png",
	obed3 = "res://assets/images/gui/gui icons/obedience3.png",
	
	class_master = "res://assets/images/gui/gui icons/icon_master.png",
	class_servant = "res://assets/images/gui/gui icons/icon_servant.png",
	class_slave = "res://assets/images/gui/gui icons/icon_slave.png",
	
	quest_slave_delivery = "res://assets/images/gui/slavepanel/charm.png",
	quest_gold = 'res://assets/images/iconsitems/gold.png',
	complete_location = "res://assets/images/gui/quest_encounter.png",
	complete_dungeon = "res://assets/images/gui/quest_dungeon.png",
	reputation = "res://assets/images/gui/quest_reputation.png",
	
	craft_time = "res://assets/images/gui/craftgui/Time.png",
	
	work = 'res://assets/images/gui/gui icons/workicon.png',
	rest = 'res://assets/images/gui/gui icons/sleepicon.png',
	joy = 'res://assets/images/gui/gui icons/joyicon.png',
	
	male = load("res://assets/images/sexicons/male.png"),
	female = load("res://assets/images/sexicons/female.png"),
	futa = load("res://assets/images/sexicons/futa.png"),
#	TO COMPLETE AND USE IN DATA TABLES
#	NEED TO GET RID OF ALL LOAD FUNCTIONS
#	skill_abuse = "res://assets/images/iconsskills/abuse.png",
#	"res://assets/images/iconsskills/Acid-spit.png",
#	"res://assets/images/iconsskills/AcidBomb.png",
#	"res://assets/images/iconsskills/Aimed-strike.png",
#	"res://assets/images/iconsskills/arrowshower.png",
#	"res://assets/images/iconsskills/Attack.png",
#	skill_attract = "res://assets/images/iconsskills/Attract.png",
#	skill_authority = "res://assets/images/iconsskills/Authority.png",
#	"res://assets/images/iconsskills/Barrier.png",
#	"res://assets/images/iconsskills/BloodMagic.png",
#	skill_charm = "res://assets/images/iconsskills/Charm.png",
#	skill_double_attack = "res://assets/images/iconsskills/comboattack.png",
#	skill_command = "res://assets/images/iconsskills/Command.png",
#	"res://assets/images/iconsskills/cripple.png",
#	"res://assets/images/iconsskills/Debilitate.png",
#	skill_attack = "res://assets/images/iconsskills/defaultattack.png",
#	skill_discipline = "res://assets/images/iconsskills/Discipline2.png",
#	skill_hardwork = "res://assets/images/iconsskills/Discipline.png",
#	skill_distract = "res://assets/images/iconsskills/distract.png",
#	skill_dragon_might = "res://assets/images/iconsskills/Drain.png",
#	"res://assets/images/iconsskills/Escape.png",
#	skill_publicexecution = "res://assets/images/iconsskills/Execution.png",
#	skill_fear = "res://assets/images/iconsskills/Fear.png",
#	"res://assets/images/iconsskills/firebolt.png",
#	"res://assets/images/iconsskills/FireBomb.png",
#	"res://assets/images/iconsskills/firestorm.png",
#	skill_greatseduce = "res://assets/images/iconsskills/Great_Seduce.png",
#	skill_lesser_heal = "res://assets/images/iconsskills/Heal.png",
#	skill_first_aid = "res://assets/images/iconsskills/HealBandage.png",
#	"res://assets/images/iconsskills/Heavy-Strike.png",
#	skill_ranged_attack = "res://assets/images/iconsskills/heavyshot.png",
#	skill_rserrated_shot = "res://assets/images/iconsskills/heavyshot.png",
#	"res://assets/images/iconsskills/icon_arrow_explode.png",
#	"res://assets/images/iconsskills/icon_dark.png",
#	"res://assets/images/iconsskills/icon_earth.png",
#	"res://assets/images/iconsskills/icon_eyes.png",
#	"res://assets/images/iconsskills/icon_ice.png",
#	"res://assets/images/iconsskills/icon_light.png",
#	"res://assets/images/iconsskills/icon_lightning.png",
#	"res://assets/images/iconsskills/icon_plant.png",
#	"res://assets/images/iconsskills/icon_tiny.png",
#	skill_innervate = "res://assets/images/iconsskills/Innervate.png",
#	skill_inspire = "res://assets/images/iconsskills/Inspire.png",
#	skill_mass_lesser_heal = "res://assets/images/iconsskills/lesserheal.png",
#	"res://assets/images/iconsskills/Lich-strike.png",
#	skill_drain = "res://assets/images/iconsskills/LifeDrain.png",
#	skill_shackles = "res://assets/images/iconsskills/Magic Shackles.png",
#	skill_drain_mana = "res://assets/images/iconsskills/ManaDrain.png",
#	"res://assets/images/iconsskills/meditate.png",
#	"res://assets/images/iconsskills/Mindblast.png",
#	"res://assets/images/iconsskills/Mindread.png",
#	skill_mindcontrol = "res://assets/images/iconsskills/Mind_Control.png",
#	skill_praise = "res://assets/images/iconsskills/Praise.png",
#	skill_protect = "res://assets/images/iconsskills/Protect.png",
#	skill_publichumiliation = "res://assets/images/iconsskills/PublicPunish.png",
#	skill_publicsexhumiliation = "res://assets/images/iconsskills/PublicSex.png",
#	skill_punish = "res://assets/images/iconsskills/Punish.png",
#	skill_stopmindcontrol = "res://assets/images/iconsskills/RemoveMindcontrol.png",
#	skill_reward = "res://assets/images/iconsskills/Reward.png",
#	skill_rewardsex = "res://assets/images/iconsskills/Reward_with_sex 3.png",
#	skill_sedate = "res://assets/images/iconsskills/Sedate.png",
#	"res://assets/images/iconsskills/Sedation.png",
#	skill_seduce = "res://assets/images/iconsskills/Seduce.png",
#	skill_serve = "res://assets/images/iconsskills/Serve2.png",
#	"res://assets/images/iconsskills/Serve.png",
#	skill_slash = "res://assets/images/iconsskills/Shackle.png",
#	"res://assets/images/iconsskills/slash.png",
#	skill_consume_soul = "res://assets/images/iconsskills/soulconsume.png",
#	skill_greatshavkles = "res://assets/images/iconsskills/Strong Magic Shackles.png",
#	skill_fire_attack = "res://assets/images/iconsskills/strongattack.png",
#	"res://assets/images/iconsskills/tackle.png",
#	"res://assets/images/iconsskills/taunt.png",
#	skill_trap = "res://assets/images/iconsskills/Trap.png",
#	skill_make_undead = "res://assets/images/iconsskills/TurnUndead.png",
#	skill_warn = "res://assets/images/iconsskills/Warn.png",
#	skill_weaponrefine = "res://assets/images/iconsskills/WeaponRefine.png",
#	"res://assets/images/iconsskills/windarrow.png"
}

var shades = {
	arachna_m = load("res://assets/images/raceshades/Arachna_M.png"),
	arachna_f = load("res://assets/images/raceshades/Arachna_F.png"),
	beastkinbunny_m = load("res://assets/images/raceshades/Beastkin-Bunny_M.png"),
	beastkinbunny_f = load("res://assets/images/raceshades/Beastkin-Bunny_F.png"),
	beastkincat_m = load("res://assets/images/raceshades/Beastkin-Cat_M.png"),
	beastkincat_f = load("res://assets/images/raceshades/Beastkin-Cat_F.png"),
	beastkinfox_m = load("res://assets/images/raceshades/Beastkin-Fox_M.png"),
	beastkinfox_f = load("res://assets/images/raceshades/Beastkin-Fox_F.png"),
	beastkintanuki_m = load("res://assets/images/raceshades/Beastkin-Tanuki_M.png"),
	beastkintanuki_f = load("res://assets/images/raceshades/Beastkin-Tanuki_F.png"),
	beastkinwolf_m = load("res://assets/images/raceshades/Beastkin-Wolf_M.png"),
	beastkinwolf_f = load("res://assets/images/raceshades/Beastkin-Wolf_F.png"),
	centaur_m = load("res://assets/images/raceshades/Centaur_M.png"),
	centaur_f = load("res://assets/images/raceshades/Centaur_F.png"),
	demon_m = load("res://assets/images/raceshades/Demon_M.png"),
	demon_f = load("res://assets/images/raceshades/Demon_F.png"),
	dragonkin_m = load("res://assets/images/raceshades/Dragonkin_M.png"),
	dragonkin_f = load("res://assets/images/raceshades/Dragonkin_F.png"),
	dryad_m = load("res://assets/images/raceshades/Dryad_M.png"),
	dryad_f = load("res://assets/images/raceshades/Dryad_F.png"),
	elf_m = load("res://assets/images/raceshades/Elf_M.png"),
	elf_f = load("res://assets/images/raceshades/Elf_F.png"),
	darkelf_m = load("res://assets/images/raceshades/Elf_M.png"),
	darkelf_f = load("res://assets/images/raceshades/Elf_F.png"),
	drow_m = load("res://assets/images/raceshades/Elf_M.png"),
	drow_f = load("res://assets/images/raceshades/Elf_F.png"),
	fairy_m = load("res://assets/images/raceshades/Fairy_M.png"),
	fairy_f = load("res://assets/images/raceshades/Fairy_F.png"),
	gnome_m = load("res://assets/images/raceshades/Gnome_M.png"),
	gnome_f = load("res://assets/images/raceshades/Gnome_F.png"),
	dwarf_m = load("res://assets/images/raceshades/Dwarf_M.png"),
	dwarf_f = load("res://assets/images/raceshades/Dwarf_F.png"),
	goblin_m = load("res://assets/images/raceshades/Goblin_M.png"),
	goblin_f = load("res://assets/images/raceshades/Goblin_F.png"),
	harpy_m = load("res://assets/images/raceshades/Harpy_M.png"),
	harpy_f = load("res://assets/images/raceshades/Harpy_F.png"),
	human_m = load("res://assets/images/raceshades/Human_M.png"),
	human_f = load("res://assets/images/raceshades/Human_F.png"),
	lamia_m = load("res://assets/images/raceshades/Lamia_M.png"),
	lamia_f = load("res://assets/images/raceshades/Lamia_F.png"),
	nereid_m = load("res://assets/images/raceshades/Nereid_M.png"),
	nereid_f = load("res://assets/images/raceshades/Nereid_F.png"),
	orc_m = load("res://assets/images/raceshades/Orc_M.png"),
	orc_f = load("res://assets/images/raceshades/Orc_F.png"),
	scylla_m = load("res://assets/images/raceshades/Scylla_M.png"),
	scylla_f = load("res://assets/images/raceshades/Scylla_F.png"),
	seraph_m = load("res://assets/images/raceshades/Seraph_M.png"),
	seraph_f = load("res://assets/images/raceshades/Seraph_F.png"),
	slime_m = load("res://assets/images/raceshades/Slime_M.png"),
	slime_f = load("res://assets/images/raceshades/Slime_F.png"),
	taurus_m = load("res://assets/images/raceshades/Taurus_M.png"),
	taurus_f = load("res://assets/images/raceshades/Taurus_F.png"),
	kobold_m = load("res://assets/images/raceshades/Kobold_M.png"),
	kobold_f = load("res://assets/images/raceshades/Kobold_F.png"),
	
}

var cursors = {
	default = load("res://assets/images/gui/universal/cursordefault.png"),
	attack = load("res://assets/images/gui/universal/cursorfight.png"),
	support = load("res://assets/images/gui/universal/cursorsupport.png"),
}

var GFX = {
	slash = load("res://assets/images/gfx/slash-effect.png"),
	fire = load("res://assets/sfx/fire_effect.png"),
}

var GFX_sprites = {
	strike = 'res://assets/sfx/hit_animation/strike.tscn',
	arrow = 'res://assets/sfx/arrow.tscn',
	water_attack = 'res://assets/sfx/water_attack.tscn',
	firebolt = 'res://assets/sfx/hit_animation/firebolt.tscn',
	flame = 'res://assets/sfx/hit_animation/flame.tscn',
	earth_spike = "res://assets/sfx/hit_animation/earth_spike.tscn",
	decay = "res://assets/sfx/hit_animation/DecayEffect.tscn",
	}

var GFX_particles = {
	heal = "res://assets/sfx/HealEffect.tscn",
}

func loadimages():
	for i in icons:
		icons[i] = input_handler.loadimage(icons[i])
	for i in backgrounds:
		backgrounds[i] = input_handler.loadimage(backgrounds[i])
	for i in scenes:
		scenes[i] = input_handler.loadimage(scenes[i])
	for i in shades:
		shades[i] = input_handler.loadimage(shades[i])
	for i in portraits:
		portraits[i] = input_handler.loadimage(portraits[i])
	for i in sprites:
		sprites[i] = input_handler.loadimage(sprites[i])
	for i in cursors:
		cursors[i] = input_handler.loadimage(cursors[i])
	for i in GFX:
		GFX[i] = input_handler.loadimage(GFX[i])

#var statsicons = {#not used at all O_o
#lub1 = load("res://assets/images/sexicons/lub1.png"),
#lub2 = load("res://assets/images/sexicons/lub2.png"),
#lub3 = load("res://assets/images/sexicons/lub3.png"),
#lub4 = load("res://assets/images/sexicons/lub4.png"),
#lub5 = load("res://assets/images/sexicons/lub5.png"),
#lust1 = load("res://assets/images/sexicons/lust1.png"),
#lust2 = load("res://assets/images/sexicons/lust2.png"),
#lust3 = load("res://assets/images/sexicons/lust3.png"),
#lust4 = load("res://assets/images/sexicons/lust4.png"),
#lust5 = load("res://assets/images/sexicons/lust5.png"),
#sens1 = load("res://assets/images/sexicons/sens1.png"),
#sens2 = load("res://assets/images/sexicons/sens2.png"),
#sens3 = load("res://assets/images/sexicons/sens3.png"),
#sens4 = load("res://assets/images/sexicons/sens4.png"),
#sens5 = load("res://assets/images/sexicons/sens5.png"),
#stress1 = load("res://assets/images/gui/obed_bad.png"),
#stress2 = load("res://assets/images/gui/obed_med.png"),
#stress3 = load("res://assets/images/gui/obed_good.png")
#}
#var combatfullpictures = { #not used
#	rat = load("res://assets/images/enemies/RatFull.png"),
#	ent = load("res://assets/images/enemies/EntFull.png"),
#	bigent = load("res://assets/images/enemies/BigEntFull.png"),
#	golem = load("res://assets/images/enemies/Golem.png"),
#	golemalt = load("res://assets/images/enemies/GolemAlt.png"),
#	spider = load("res://assets/images/enemies/Spider.png"),
#}
#var combatportraits = {
#	##enemies
#	rat = load("res://assets/images/enemies/RatIcon2.png"),
#	ent = load("res://assets/images/enemies/EntIcon.png"),
#	bigent = load("res://assets/images/enemies/BigEntIcon.png"),
#	golem = load("res://assets/images/enemies/GolemIcon.png"),
#	golemalt = load("res://assets/images/enemies/GolemAltIcon.png"),
#	spider = load("res://assets/images/enemies/SpiderIcon.png"),
#	}
