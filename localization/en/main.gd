extends Reference
var TranslationDict = {
	#test string
	TESTNAMELOCALIZATION = "en_test",
	#Time
	NIGHT = "Night",
	MORNING = "Morning",
	NOON = "Noon",
	EVENING = "Evening",
	#Buildings
	MANSION = "Aliron (Mansion)",
	RETURNTOMANSION = "Return to Mansion",
	WORKERMARKET = "Market",
	PURCHASE = "Purchase",
	SELL = "Sell",
	TASKS = "Tasks",

	LABELDISLOCATION = "Dislocation",
	LABELDESTINATION = "Destination",
	#Materials
	STARTINGADJ = "Starting",

	FOODTYPEMEAT = "Meat",
	FOODTYPEFISH = "Fish",
	FOODTYPEGRAIN = "Grains",
	FOODTYPEVEGE = "Vegetables",


	CURRENTLYINPOSSESSION = "Currently in possession",


	MATERIALCATEGORYFOOD = "Food",
	MATERIALCATEGORYSTONE = "Stone",
	MATERIALCATEGORYWOOD = "Wood",
	MATERIALCATEGORYCLOTH = "Cloth",
	MATERIALCATEGORYLEATHER = "Leather",
	MATERIALCATEGORYMETAL = "Metal",
	MATERIALCATEGORYPLANT = "Plant",
	MATERIALCATEGORYBONE = "Bone",
	MATERIALCATEGORYCOMPONENT = "Consumable",

	MATERIALMEAT = "Meat",
	MATERIALMEATDESCRIPT = "A rich source of nutrients. Acquired from hunting. ",
	MATERIALFISH = "Fish",
	MATERIALFISHDESCRIPT = "A common source of food. Acquired from fishing. ",
	MATERIALVEGETABLES = "Vegetables",
	MATERIALVEGETABLESDESCRIPT = "A commonly grown food. Harvested from a farm. ",
	MATERIALGRAIN = "Grains",
	MATERIALGRAINDESCRIPT = "A commonly grown food. Harvested from a farm. Must be cooked before consumption. ",
	MATERIALBREAD = "Bread",
	MATERIALBREADDESCRIPT = "A staple food baked from grains. Produced by cooking.\nFood type: Grains",
	MATERIALMEATSOUP = "Meat Soup",
	MATERIALMEATSOUPDESCRIPT = "A combination of water and meat. Produced by cooking.\nFood type: Meat, Vegetables.",
	MATERIALFISHCAKES = "Fish Cakes",
	MATERIALFISHCAKESDESCRIPT = "A baked dough filled with fish paste. Especially liked by Cat folk. Produced by cooking.\nFood type: Fish, Grains.",
	MATERIALSTONE = "Rough Stone",
	MATERIALSTONEADJ = "Stone",
	MATERIALSTONEDESCRIPT = "Stone comes in many forms and shapes. It can serve as a good building material or even low quality tools. Acquired from mining. ",
	MATERIALOBSIDIAN = "Obsidian",
	MATERIALOBSIDIANADJ = "Obsidian",
	MATERIALOBSIDIANDESCRIPT = "A glossy black stone found near active volcanoes. It can serve as a high quality ornament in many a construction, jewelry, or Quality tools.",
	MATERIALWOOD = "Rough Wood",
	MATERIALWOODADJ = "Wooden",
	MATERIALWOODDESCRIPT = "Sturdy wood for general building and furnishing purposes. Acquired from wood cutting. ",
	MATERIALWOODMAGIC = "Magic Wood",
	MATERIALWOODMAGICADJ = "Magic",
	MATERIALWOODMAGICDESCRIPT = "An unusual wood imbued with traces of magic power.",
	MATERIALWOODIRON = "Iron Wood",
	MATERIALWOODIRONADJ = "Heavy Wooden",
	MATERIALWOODIRONDESCRIPT = "A dense and sturdy piece of wood suitable even for defensive purposes.",
	MATERIALWOODANCIENT = "Ancient Wood",
	MATERIALWOODANCIENTADJ = "Ancient",
	MATERIALWOODANCIENTDESCRIPT = "A wood of an ancient plant. Its perseverance over the ages showcases its strong properties.",
	MATERIALLEATHER = "Leather",
	MATERIALLEATHERADJ = "Leather",
	MATERIALLEATHERDESCRIPT = "A common animal leather. Can be used for light armor and accessories. Produced by hunting and killing weak monsters. ",
	MATERIALLEATHERTHICK = "Thick Leather",
	MATERIALLEATHERTHICKADJ = "Thick",
	MATERIALLEATHERTHICKDESCRIPT = "A thicker and sturdier leather which can provide additional defense. Acquired from strong monsters. ",
	MATERIALLEATHERMYTHIC = "Mythic Leather",
	MATERIALLEATHERMYTHICADJ = "Mythic",
	MATERIALLEATHERMYTHICDESCRIPT = "A leather belonging to the rare mythic beasts possessing unusual properties. Acquired from strong and rare monsters. ",
	MATERIALLEATHERDRAGON = "Dragon Leather",
	MATERIALLEATHERDRAGONADJ = "Draconic",
	MATERIALLEATHERDRAGONDESCRIPT = "Dragon leather is extremely rare and hard to work with. Acquired from dragons.",
	MATERIALBONE = "Bone",
	MATERIALBONEADJ = "Bone",
	MATERIALBONEDESCRIPT = "A common animal bone. With the right technique it can provide some interesting properties. Acquired from monsters. ",
	MATERIALBONEANCIENT = "Ancient Bone",
	MATERIALBONEANCIENTADJ = "Ancient",
	MATERIALBONEANCIENTDESCRIPT = "A bone from creatures of myths. Its properties are on par with metal. Acquired from monsters. ",
	MATERIALBONEDRAGON = "Dragon Bone",
	MATERIALBONEDRAGONADJ = "Draconic",
	MATERIALBONEDRAGONDESCRIPT = "Dragon bones are rare and expensive material. Acquired from dragons.",
	MATERIALCLOTH = "Cloth",
	MATERIALCLOTHADJ = "Cloth",
	MATERIALCLOTHDESCRIPT = "A fiber for simple clothes and armor. Produced by farming. ",
	MATERIALCLOTHSILK = "Silk",
	MATERIALCLOTHSILKADJ = "Silk",
	MATERIALCLOTHSILKDESCRIPT = "A fine cloth material. Acquired from monsters.",
	MATERIALCLOTHMAGIC = "Magic Cloth",
	MATERIALCLOTHMAGICADJ = "Magic",
	MATERIALCLOTHMAGICDESCRIPT = "A cloth material with magic properties. Produced by crafting.",
	MATERIALCLOTHETHEREAL = "Ethereal Cloth",
	MATERIALCLOTHETHEREALADJ = "Ethereal",
	MATERIALCLOTHETHEREALDESCRIPT = "A cloth material with rare magic properties. Acquired from monsters.",
	MATERIALIRON = "Iron",
	MATERIALIRONADJ = "Iron",
	MATERIALIRONDESCRIPT = "A common metal suitable for weapons and armor. Acquired from mining. ",
	MATERIALSTEEL = "Steel",
	MATERIALSTEELADJ = "Steel",
	MATERIALSTEELDESCRIPT = "A strong metal alloy of carbon and iron. Produced by crafting",
	MATERIALMITHRIL = "Mythril",
	MATERIALMITHRILADJ = "Mythril",
	MATERIALMITHRILDESCRIPT = "A mythical silvery metal with strong magic properties. Acquired from mining.",
	MATERIALADAMANTINE = "Adamantine",
	MATERIALADAMANTINEADJ = "Adamantine",
	MATERIALADAMANTINEDESCRIPT = "A very rare and strong magic alloy. Produced by crafting. ",
	MATERIALBLUE_MOSS = "Blue Moss",
	MATERIALBLUE_MOSSDESCRIPT = "A rare plant with magical properties.",
	MATERIALSALVIA = "Salvia",
	MATERIALSALVIADESCRIPT = "An uncommon plant with mind influencing properties. ",
	MATERIALTRAP = "Trap Component",
	MATERIALTRAPDESCRIPT = "A mechanical trap to hold targets in place. Required for certain skills. ",
	MATERIALROPE = "Rope",
	MATERIALROPEDESCRIPT = "A cord of sturdy rope, generally used for tying things and people. ",
	MATERIALUNSTABLE_CONCOCTION = "Unstable Concoction",
	MATERIALUNSTABLE_CONCOCTIONDESCRIPT = "A potent alchemical mixture. Required for certain skills.",
	MATERIALBANDAGE = "Bandages",
	MATERIALBANDAGEDESCRIPT = "A pack of bandages required for healing with the First Aid skill.",
	MATERIALLICH_SKULL = "Lich's Skull",
	MATERIALLICH_SKULLDESCRIPT = "Once belonged to a Lich, still holds faint traces of powerful magic in it. ",
	MATERIALINK_BRANDING = "Ink: Branding",
	MATERIALINK_MAKEUP = "Ink: Permanent Makeup",
	MATERIALINK_LUST = "Ink: Passion",
	MATERIALINK_HP = "Ink: Nature",
	MATERIALINK_MP = "Ink: Spiritual",
	MATERIALHERBS = "",
	MATERIALHERBSDESCRIPT = "",
	MATERIALINK_TRIBAL = "Ink: Power",
	MATERIALINK_BRANDINGDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. Initially implemented by graziers and tamers, branding was adopted by slavery societies to establish dominance over the conquered. Tattoos are not nearly as painful to apply but nethertheless just as degrading, featuring the name of the owner.\n\nApplied to: {color=yellow|Neck, Ass, Crotch}\n\nObedience Drain -2, Loyalty Gain +1.\nCan only be applied once.",
	MATERIALINK_MAKEUPDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. While makeup might not be enough to turn the Beast into the Beauty, its a favorable option for the lazy.\n\nApplied to: {color=yellow|Face}\n\nCharm: +10.",
	MATERIALINK_LUSTDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. An obscene crest causing the owner to grow lewder, even against their will...\n\nApplied to: {color=yellow|Crotch, Chest, Ass}\n\nLust Growth: +10%; +20% if applied to Crotch.",
	MATERIALINK_HPDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. An ancient being signatures which strengthening life force.\n\nApplied to: {color=yellow|Arms, Legs, Waist}\n\nHealth Regeneration: +20%.",
	MATERIALINK_MPDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. Energy to supply magic is generally scarce, but this unknown signia will resupply the bearer with some additional traces from the air.\n\nApplied to: {color=yellow|Arms, Legs, Waist}\n\nMana Regeneration: +10%.",
	MATERIALINK_TRIBALDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. The technique of this special ink has been salvaged from the clan of fierce warriors. \n\nApplied to: {color=yellow|Face, Chest, Arms, Legs}\n\nWhen applied to Face: +5 Health\nOtherwise: +3 Physics",

	TATTOOBRANDDESCRIPT = "A sign of your ownership. Reduce Obedience drain by 2 and increase Loyalty Growth by 1.",
	TATTOOLUSTDESCRIPT = "Lust Growth: +10%",
	TATTOOLUST2DESCRIPT = "Lust Growth: +20%",
	TATTOOMAKEUPDESCRIPT = "Charm: +10",
	TATTOOHPDESCRIPT = "Health Regeneration: +20%",
	TATTOOMPDESCRIPT = "Mana Regeneration: +10%",
	TATTOOTRIBALDESCRIPT = "Physics: +3",
	TATTOOTRIBAL2DESCRIPT = "Max Health: +5",
	

	ITEMSLOTHEAD = "Head",
	ITEMSLOTCHEST = "Chest",
	ITEMSLOTLEGS = "Legs",
	ITEMSLOTHANDS = "Hands",
	ITEMSLOTCROTCH = "Crotch",
	ITEMSLOTASS = "Rear",
	ITEMSLOTUNDERWEAR = "Underwear",
	ITEMSLOTLHAND = "Left Hand",
	ITEMSLOTRHAND = "Right Hand",
	ITEMSLOTNECK = "Neck",
	ITEMSLOTTOOL = "Tool",

	ITEMLEATHER_COLLAR = "Leather Collar",
	ITEMLEATHER_COLLARDESCRIPT = "A simple leather collar that signifies ownership.",
	ITEMELEGANT_CHOKER = "Elegant Choker",
	ITEMELEGANT_CHOKERDESCRIPT = "A good sign of your ownership.",
	ITEMSTEEL_COLLAR = "Steel Collar",
	ITEMSTEEL_COLLARDESCRIPT = "A cold, uncomfortable metal collar often used to punish one's slaves..",
	ITEMAMULET_OF_RECOGNITION = "Amulet of Recognition",
	ITEMAMULET_OF_RECOGNITIONDESCRIPT = "A proof of the Guilds' recognition which was gifted by Amelia. ",
	ITEMANIMAL_EARS = "Animal Ears",
	ITEMANIMAL_EARSDESCRIPT = "Shaped after certain beastkin feature, a pair of these can trick an inexperienced viewer. While these aren't really moving as you'd expect to, its the second pair which is usually a dead giveaway.",
	ITEMTAIL_PLUG = "Tail Plug",
	ITEMTAIL_PLUGDESCRIPT = "A tail resembling a cat's, generally associated with beast kind, however it's responsiveness is lacking, unless pulled...",
	ITEMANIMAL_GLOVES = "Animal Gloves",
	ITEMANIMAL_GLOVESDESCRIPT = "A pair of gloves that look like paws. Greatly inconvenient in manual labor but somehow still popular among certain enthusiasts.",
	ITEMPET_SUIT = "Pet Suit",
	ITEMPET_SUITDESCRIPT = "A pet suit often used for intimate play. Makes the wearer cuter at the cost of maneuverability.",
	ITEMSHACKLES = "Shackles",
	ITEMSHACKLESDESCRIPT = "Heavy chains for dangerous individuals.",
	ITEMCHASTITY_BELT = "Chastity Belt",
	ITEMCHASTITY_BELTDESCRIPT = "A tool designed to keep wearer's genitalia untouched.",
	ITEMSTIMULATIVE_UNDERWEAR = 'Stimulating Underwear',
	ITEMSTIMULATIVE_UNDERWEARDESCRIPT = "Specially designed underwear to arouse the wearer and make them hornier.",
	ITEMTENTACLE_SUIT = 'Tentacle Suit',
	ITEMTENTACLE_SUITDESCRIPT = "Living clothes stimulating the wearer from the inside.",
	ITEMANAL_BEADS = "Anal Beads",
	ITEMANAL_BEADSDESCRIPT = "A string of balls. Designed for rear usage.",
	ITEMANAL_PLUG = "Anal Plug",
	ITEMANAL_PLUGDESCRIPT = "A plug shaped piece of wood. Designed for rear usage. ",
	ITEMSTRAPON = "Strapon",
	ITEMSTRAPONDESCRIPT = "Allows girls to pass for boys, but only in bed. ",

	ITEMAPHRODISIAC = "Aphrodisiac",
	ITEMAPHRODISIACDESCRIPT = "A strong potion bringing out a person's inner lust. \n\nTurns character Horny during sex interactions. ",
	ITEMALCOHOL = "Whiskey",
	ITEMALCOHOLDESCRIPT = "A simple strong beverage produced from various grains. \n\nImproves obedience when consumed normally. Improves horniness and sensitivity during sex interactions but can be rejected by a weaker body.",
	ITEMBEER = "Beer",
	ITEMBEERDESCRIPT = "A nectar of the gods. \n\nImproves obedience when consumed normally. Improves horniness and sensitivity during sex interactions.",
	ITEMTAMEDRUG = "Tame Drug",
	ITEMTAMEDRUGDESCRIPT = "Tame Factor +1-2. Timid Factor +1-2. Wits Factor -1.",
	ITEMRAGEDRUG = "Rage Drug",
	ITEMRAGEDRUGDESCRIPT = "Tame Factor -1-2. Wits Factor -1-2. Physics Factor +1.",
	ITEMSEXDRUG = "Sex Drug",
	ITEMSEXDRUGDESCRIPT = "Physics Factor -1. Wits Factor -1. Sex Factor set to 6. Lust Maximized.",

	ITEMHEALPOT = "Health Potion",
	ITEMHEALPOTDESCRIPT = "Restores some health. Can be used in combat.",
	ITEMMANAPOT = "Mana Potion",
	ITEMMANAPOTDESCRIPT = "Restores some mana. Can be used in combat.",

	ITEMLIFESHARD = "Shard of Life",
	ITEMLIFESHARDDESCRIPT = "A stone possessing healing properties. Heals 20-25 life on use.",
	ITEMLIFEGEM = "Gem of Life",
	ITEMLIFEGEMDESCRIPT = "A valuable stone possessing healing properties. Heals 45-55 life on use.",
	ITEMENERGYSHARD = "Shard of Energy",
	ITEMENERGYSHARDDESCRIPT = "A piece of stone imbued with magical energies. Restores 20-25 mana on use.",
	ITEMENERGYGEM = "Gem of Energy",
	ITEMENERGYGEMDESCRIPT = "A stone brimming with magical power. Restores 50-65 mana on use.",
	ITEMSPARKLINGPOWDER = "Sparkling Powder",
	ITEMSPARKLINGPOWDERDESCRIPT = "A pinch of dust composed mainly of life shards. Heals 25-35 life to all party members.",
	ITEMREVITALIZER = "Revitalizer",
	ITEMREVITALIZERDESCRIPT = "A strong essence possessing a large amount of life energy. Resurrects fallen characters with 20% of their maximum health.",
	ITEMWRIT_OF_EXEMPTION = "Writ Of Exemption",
	ITEMWRIT_OF_EXEMPTIONDESCRIPT = "An official paper holding all the necessities to grant a person freedom from slavery. It has all the required seals and is only missing a name...\n\nCan't be applied to unique characters.",
	ITEMSTRONG_PHEROMONES = "Strong Pheromones",
	ITEMSTRONG_PHEROMONESDESCRIPT = "A popular drug used on bestial races. Inhaling causes a great surge of euphoria and lust in an individual, making them accept just about any treatment they usually would be too shy to consider. Ineffective for non-bestial species and often banned in affected communities. ",
	ITEMSOUL_STONE = "Soul Stone",
	ITEMSOUL_STONEDESCRIPT = "Allows to remove one inherent character trait.",
	
	ITEMSENSITIVITY_POT = "Sensitivity Drug",
	ITEMSENSITIVITY_POTDESCRIPT = "Increases sensitivity during sexual interactions.",
	ITEMOBLIVION_POTION = "Oblivion Potion",
	ITEMOBLIVION_POTIONDESCRIPT = "Remove all learned classes.",
	ITEMMAID_DRESS = "Maid Dress",
	ITEMMAID_DRESSDESCRIPT = "A common servant dress for females. Inspires obedience and is appealing to the eye.",
	ITEMMAID_HEADBAND = "Maid Headband",
	ITEMMAID_HEADBANDDESCRIPT = "A simple headgear to keep their hair in shape, commonly worn by lower servants.",
	ITEMLACY_UNDERWEAR = "Lacy Underwear",
	ITEMLACY_UNDERWEARDESCRIPT = "Fancy looking underwear, often associated with ladies of higher class.",
	ITEMSEETHROUGH_UNDERWEAR = "See Through Lingerie",
	ITEMSEETHROUGH_UNDERWEARDESCRIPT = "An expensive piece of clothing fairly popular in lewd activities. Being woven from magic cloth provides not only great feel on touch but also outstanding durability.",
	ITEMWORKER_OUTFIT = "Worker's Outfit",
	ITEMWORKER_OUTFITDESCRIPT = "Common work clothes which do not restrain movement and keep the wearer warm.",
	ITEMCRAFTSMAN_SUIT = "Craftsman Suit",
	ITEMCRAFTSMAN_SUITDESCRIPT = "Advanced clothes, designed to help with crafting materials.",
	ITEMHANDCUFFS = "Handcuffs",
	ITEMHANDCUFFSDESCRIPT = "A pair of leather handcuffs designed to limit the wearer's movement. Despite their purpose, they can even be considered somewhat comfortable to wear. ",

	ITEMWORKER_GLOVES = "Worker Gloves",
	ITEMGAUNTLETS = "Gauntlets",
	ITEMCIRCLET = "Circlet",
	ITEMCROWN = "Pale Crown",
	ITEMBELL_COLLAR = "Belled Collar",
	ITEMRIBBON = "Ribbon",
	ITEMWORKER_GLOVESDESCRIPT = "A pair of thick gloves suited for hard labor. Better take these off before the bedroom",
	ITEMGAUNTLETSDESCRIPT = "A gloves made of sturdy metal designed for hand protection. Generally not suited for erotic roleplay",
	ITEMCIRCLETDESCRIPT = "A well crafted metal ornament boosting wearer's magic power.",
	ITEMCROWNDESCRIPT = "An old crown of unknown origin",
	ITEMBELL_COLLARDESCRIPT = "Despite its nature, this collar considered more of an object of fashion came from distant land.",
	ITEMRIBBONDESCRIPT = "A bright red ribbon of unknown nature. ",
	
	
	ITEMJACKET = "Jacket",
	ITEMJACKETDESCRIPT = "A lightweight clothing which offers no protecting.",
	ITEMENSLAVING_COLLAR = "Enslaving Collar",
	ITEMENSLAVING_COLLARDESCRIPT = "Magical slave collar which slowly mends will of the wearer.",
	ITEMEARRINGS = "Earrings", 
	ITEMEARRINGSDESCRIPT = "A pair of fancy jewelry.", 
	ITEMAIRE_BOW = "Aire's Bow",
	ITEMAIRE_BOWDESCRIPT = "A strong archer bow seemingly of elvish origin.",
	ITEMWITCH_HAT = "Witch Hat",
	ITEMWITCH_HATDESCRIPT = "A canonical hat with magic powers.",
	
	
	#Items
	ITEMAXE = "Axe",
	ITEMPICKAXE = "Pickaxe",
	ITEMSWORD = 'Sword',
	ITEMDAGGER = 'Dagger',
	ITEMCLUB = "Club",
	ITEMSPEAR = "Spear",
	ITEMBOW = "Bow",
	ITEMSTAFF = "Staff",
	ITEMSICKLE = "Sickle",
	ITEMFISHINGTOOLS = "Fishing Tools",
	ITEMHAMMER = "Forge Hammer",
	ITEMHUNT_KNIFE = "Hunting Knife",


	ITEMAXEDESCRIPT = 'Axe can be used for cutting wood and combat.',
	ITEMSWORDDESCRIPT = "Good damage vs unarmored enemies.",
	ITEMDAGGERDESCRIPT = "Easily hidden, cheap weapon which can be used by anyone.",
	ITEMCLUBDESCRIPT = "A weapon of your ancestors. Not outstanding, but easy to make and can be held by anyone.",
	ITEMSPEARDESCRIPT = "One of the earliest weapons known to man. Not as flexible as a sword, but it has its strengths... Mostly in cost.",
	ITEMPICKAXEDESCRIPT = "An irreplaceable tool for miners.",
	ITEMBOWDESCRIPT = "Simple weapon for ranged fighters.",
	ITEMSTAFFDESCRIPT = "A simple tool for magic users.",
	ITEMSICKLEDESCRIPT = "A tool, used for crop harvest.",
	ITEMFISHINGTOOLSDESCRIPT = "A set of tools used by fishermen.",
	ITEMHAMMERDESCRIPT = "A handy tool for smiths and builders.",
	ITEMHUNT_KNIFEDESCRIPT = "A set of tools to be utilized by seekers of game.",

	ITEMBASICCHEST = "Chestplate",
	ITEMROBE = "Robe",
	ITEMHOOD = "Hood",
	ITEMSHOES = "Shoes",
	ITEMBASICCHESTDESCRIPT = "Offers basic body protection.",
	ITEMBASICHELM = "Helmet",
	ITEMBASICHELMDESCRIPT = "Offers basic head protection.",
	ITEMBASICBOOTS = "Boots",
	ITEMBASICBOOTSDESCRIPT = "Offers basic foot protection",
	ITEMBASICGLOVES = "Gloves",
	ITEMBASICGLOVESDESCRIPT = "Offers basic hand protection",

	ITEMCHEST_BASE_CLOTH = "Robe",
	ITEMCHEST_BASE_LEATHER = "Medium Armor",
	ITEMCHEST_BASE_METAL = "Plate Armor",
	ITEMLEGS_BASE_CLOTH = "Pants",
	ITEMLEGS_BASE_LEATHER = "Medium Lower Armor",
	ITEMLEGS_BASE_METAL = "Plate Lower Armor",

	ITEMCHEST_BASE_CLOTHDESCRIPT = "A light armor which can be worn by anyone. Provides reasonable protection from spell type damage.",
	ITEMCHEST_BASE_LEATHERDESCRIPT = "An armor assembled from bones or leather, requires some training for comfortable usage.",
	ITEMCHEST_BASE_METALDESCRIPT = "A heavy armor generally made of metal. Provides great protection from skill type damage.",
	ITEMLEGS_BASE_CLOTHDESCRIPT = "A light lower armor which can be worn by anyone. Provides reasonable protection from spell type damage.",
	ITEMLEGS_BASE_LEATHERDESCRIPT = "A lower armor assembled from bones or leather, requires some training for comfortable usage.",
	ITEMLEGS_BASE_METALDESCRIPT = "A heavy lower armor generally made of metal. Provides great protection from skill type damage.",

	#gearclasses
	GEARSWORD = "Swords",
	GEARAXE = "Axes",
	GEARSTAFF = "Staves",
	GEARBOW = "Bows",
	GEARPICKAXE = "Pickaxes",

	#Stats
	DAMAGE = 'ATK',
	DAMAGEMOD = "ATK Mult.",
	ARMOR = 'DEF',
	MDEF = "MDEF",
	EVASION = 'Evasion',
	HITRATE = 'Hit Chance',
	HEALTH = 'Health',
	DURABILITY = "Durability",
	DURABILITYMOD = "Dur. Factor",
	ARMORPENETRATION = "Armor Pen.",
	RESISTFIRE = "Fire Res.",
	RESISTEARTH = "Earth Res.",
	RESISTAIR = "Air Res.",
	RESISTWATER = "Water Res.",
	HEALTHPERCENT = "Max. Health",
	MANAPERCENT = "Max. Mana",
	CRITICAL = "Critical",
	CRITCHANCE = "Crit. Chance",
	CRITMOD = "Crit. Mod",
	LEVELUP = "Level up",
	MAXLEVEL = "Maximum Level",
	LEVELUPTEXT = " has just acquired a level. Select a new trait to unlock",
	TASKCRITCHANCE = "Work Crit Chance",
	TASKEFFICIENCYTOOL = "Work Efficiency Bonus",
	TOOLWORKCATEGORY = "Tool",

	#stat tooltips
	TOOLTIPDAMAGE = "Defines damage output of skills and spells",
	TOOLTIPARMOR = "Reduces skill damage taken by this percent",
	TOOLTIPMDEF = "Reduces spell damage taken by this percent",
	TOOLTIPCRIT = "Percent chance to crit for extra damage. \nFirst value is a chance. Second value is a modifier.",
	TOOLTIPHITRATE = "Percent chance to hit target. \nReduced by enemy's evasion",
	TOOLTIPARMORPEN = "Reduces enemy armor by this value",
	TOOLTIPEVASION = "Reduces enemy hit chance by this value",
	TOOLTIPSPEED = "Improves your odds to act before other characters",
	TOOLTIPRESISTS = "Reduces elemental damage by relative resist",

	TOOLTIPFOODCONSUMPTION = "Daily Food Consumption",
	TOOLTIPPOPULATION = "Population",
	TOOLTIPPROGRESSREQUIRED = "Work Units required",
	TOOLTIPSAVECHARACTER = "Save Character Template",
	TOOLTIPLOADCHARACTER = "Load Character Template",
	
	
	TOOLTIPSKILLPOINTS = "Skill Points are earned from battles and are used to purchase new combat skills.",

	SAVENAME = "Save Name",
	SAVETEMPLATEDESCRIPT = "You can save existing character template for the repeated use.",

	#Item Parts
	TOOLHANDLE = 'Tool Handle',
	WEAPONHANDLE = 'Weapon Handle',
	BLADE = 'Blade',
	TOOLBLADE = "Tool Blade",
	TOOLCLOTHWORK = "Clothwork",
	ROD = 'Knub',
	BOWBASE = 'Bow Limb',
	ARMORBASE = 'Base',
	ARMORPLATE = 'Plate',
	ARMORTRIM = 'Trim',
	JEWELRYGEM = 'Gem',
	WEAPONMACE = "Weapon Head",



	#Menu
	NEWGAME = "New Game",
	LOAD = 'Load',
	OPTIONS = 'Options',
	QUIT = 'Quit',
	CLOSE = "Close",
	PROCEED = "Proceed",
	SELECTHERO = "Select Hero",
	SOUND = "Sound",
	MUSIC = "Music",
	MASTERSOUND = "Master Volume",
	MUTE = "Mute",
	AUDIO = "Audio",

	TEXTSPEED = "Text Speed",
	SKIPREAD = "Skip Read",

	CURRENTFOOD = "Current Food",
	GAINFOOD = "Food Value",
	FOODCONVERT = "Convert Food",

	#System
	CONFIRM = "Confirm",
	FRONT = "Front",
	BACK = "Back",
	CANCEL = "Cancel",
	YES = "Yes",
	NO = "No",
	REMOVE = "Remove",
	NONE = "None",
	SPEED = "Speed",
	DAY = "Day",
	ENERGY = "Energy",
	TIME = "Time",
	CRAFT = "Craft",
	BLACKSMITH = "Blacksmith",
	PROGRESS = "Progress",
	REPAIR = "Repair",
	REPAIRALL = "Repair All",
	WORKERNOENERGY = " has no energy left and stopped working.",
	TOOLBROKEN = " has broken.",
	CURRENTTASK = "Current Task",
	REQUIREDMATERIAL = "Required Material",
	REQUIREDMATERIALS = "Required Materials",
	SELECTREPAIR = "Select Item(s) to Repair",
	TOTALPRICE = "Total Price",
	SELECTMATERIAL = "Select materials for all parts.",
	INPOSESSION = "In Possession",
	BASECHANCE = "Base Chance",
	CANTREPAIREFFECT = "This item can't be repaired.",
	NOTENOUGH = "Not enough",
	ITEMCREATED = "Item Created",
	UPGRADEUNLOCKED = "Upgrade Unlocked",
	MAINQUEST = "Main Quest",
	SIDEQUESTS = "Side quests",
	MAINQUESTUPDATED = "Main Quest Updated",
	QUESTLOG = "Quest Log",
	NOACTIVEQUESTS = "You have no active quests.",
	CLASSREQS = "Requirements",
	INVALIDREQS = "Requirements are unmet.",
	REQSNONE = "None",
	NOTENOUGHGOLD = "Not enough gold",
	PURCHASETHISTRAIT = "Purchase this trait",
	TRAITPOINTSCOST = "Trait Points",
	TRAITPOINTS = "Trait Points used",
	GOLDPRICE = "Gold Cost",
	CLASSBONUS = "Bonuses",
	EXPREQUIRED = "Experience required",
	NOFITTINGITEMS = "You have no fitting items",
	TRAITUNKNOWN = "Unknown",
	TRAITUNKNOWNTOOLTIP = "You don't know this trait yet. Get to know [name] better to learn [his] preferences.",
	NOTALLTRAITSLEARNED = "You don't know all [name]'s preferences. Learn them before being able to assign active ones.",
	SYSNOFOOD = "Work canceled: No food",
	SYSNOWORKERENERGY = "Work canceled: No energy",
	DIALOGUEREPEATACTION = "Repeat",
	CHAR_UNAVALIABLE = "Unavailable",
	NO_FREE_SLOTS = "This task has no available slots left",

	LOGREPORTPREGNANCY = "[name] tells you, that [he] seems to be pregnant.",
	LOGREPORTPREGNANCYMASTER = "It seems, that you([name]) are pregnant.",

	SELECT = "Select",
	SELECTTOOL = "Select Tool",
	SELECTWORKER = "Select Worker",
	SELECTITEM = "Select Item",
	WORKERLIMITREACHER = "Worker Limit Reached: Upgrade Houses to increase",
	TOTALWORKERS = "Total Workers",

	TUTORIAL = "Tutorial",
	TRAITS = "Traits",
	CLASSINFO = "Class Details",
	CLASSSTATCHANGES = "Stat Changes",

	INVENTORY = "Inventory",
	WORKERLIST = "Worker List",
	HEROLIST = "Hero List",
	OPTIONMENU = "Options",

	INVENTORYALL = "All items",
	INVENTORYWEAPON = "Weapons",
	INVENTORYARMOR = "Armor",
	INVENTORYMATERIAL = "Materials",
	INVENTORYCOSTUME = "Costumes",
	INVENTORYUSE = "Consumables",
	INVENTORYTOOL = "Tools",
	INVENTORYQUEST = "Misc",
	SELLCONFIRM = "Sell",
	RAWPRICE = "Raw Price",
	FOODDESCRIPT = "Food is used to feed workers. ",
	MONEYDESCRIPT = "Money is used to purchase goods and workers.",

	AREAISENDLESS = "This area has no progression",
	TOWNRETURN = "Return",
	RETURN = "Return",

	#Confirms

	LEAVECONFIRM = "Leave to Main Menu? Unsaved progress will be lost. ",
	LOADCONFIRM = "Load this save file?",
	OVERWRITECONFIRM = "Overwrite this save file?",
	DELETECONFIRM = "Delete this save file?",
	STOPTASKCONFIRM = "Stop this job?",
	SLAVEREMOVECONFIRM = "Expel this worker?",

	OVERWRITETEMPLATECONFIRM = "Overwrite this template?",
	DELETETEMPLATECONFIRM = "Delete this template?",
	LOADTEMPLATECONFIRM = "Load this template? Current settings will be lost.",

	#Inbuilt Tooltips
	PAUSEBUTTONTOOLTIP = 'Pause\nHotkey: 1',
	NORMALBUTTONTOOLTIP = 'Normal Speed\nHotkey: 2',
	FASTBUTTONTOOLTIP = 'Fast Speed\nHotkey: 3',




	#Skills
	SKILLATTACK = "Attack",
	SKILLATTACKDESCRIPT = "Attacks target with equipped weapon.",
	SKILLRANGED_ATTACK = "Attack (ranged)",
	SKILLFIREBOLT = "Firebolt",
	SKILLFIREBOLTDESCRIPT = "Launches a fire spell at target. Deal %d Fire damage to all targets in same row.",
	SKILLWINDARROW = "Wind Arrow",
	SKILLWINDARROWDESCRIPT = "Imbues the arrow with Wind element and deal %d damage. Must have a bow equipped.",
	SKILLENEMY_SLASH = "Slash",
	SKILLENEMY_SLASHDESCRIPT = "Deals %d Weapon damage to all targets in nearby column. Must have a weapon equipped.",
	SKILLMINORHEAL = "Minor Heal",
	SKILLMINORHEALDESCRIPT = "Restore %d health of the target.",
	SKILLCONCENTRATE = "Concentrate",
	SKILLCONCENTRATEDESCRIPT = "Restore %d of your mana.",
	SKILLFIRESTORM = "Fire Storm",
	SKILLFIRESTORMDESCRIPT = "Deals %d fire damage to all enemies.",
	SKILLSTRONGSHOT = "Strong Shot",
	SKILLSTRONGSHOTDESCRIPT = "Deals %d Weapon damage to target enemy and stuns for 1 turn. Must have a bow equipped.",
	SKILLARROWSHOWER = "Arrow Shower",
	SKILLARROWSHOWERDESCRIPT = "Deals %d Weapon damage to all enemies.",
	SKILLTACKLE = "Tackle",
	SKILLTACKLEDESCRIPT = "Deals %d Physical damage and stuns target for 1 turn.",
	SKILLCRIPPLE = "Cripple",
	SKILLCRIPPLEDESCRIPT = "Deals %d Weapon damage and reduces target's damage by 33%% for 3 turns.",
	SKILLCOMBOATTACK = "Combo Attack",
	SKILLCOMBOATTACKDESCRIPT = "Deals 3 consecutive hits for %d Weapon damage to target.",
	SKILLDOUBLEATTACK = "Double Attack",
	SKILLDOUBLEATTACKDESCRIPT= "Attacks for %d damage twice.",

	SKILLCOMMAND = "Command",
	SKILLCOMMANDDESCRIPT = "Increases target's ATK and MATK by 50% for 3 turns.",
	SKILLRESTORATION = "Restoration",
	SKILLRESTORATIONDESCRIPT = "Heals a target for 250% of MATK. Reduces damage taken by 20% for 2 turns.",
	SKILLREJUVENATION = "Rejuvination",
	SKILLREJUVENATIONDESCRIPT = "Heals a row for 100% of MATK. Regenerates 60% of MATK each turn for 2 turns.",
	SKILLSANCTUARY = "Sanctuary",
	SKILLSANCTUARYDESCRIPT = "Heals all allies for 80% of MATK. Regenerates 120% of MATK each turn for 3 turns.",
	SKILLTRAP = "Trap",
	SKILLTRAPDESCRIPT = "Sets trap under enemy, stunning target for 2 turns. Requires 1 Trap component.",
	SKILLWEAPON_REFINE = "Weapon Refine",
	SKILLWEAPON_REFINEDESCRIPT = "Increases target's ATK by 30% until end of combat.",
	SKILLACIDBOMB = "Acid Bomb",
	SKILLACIDBOMBDESCRIPT = "Throws Acid Bomb at a target, dealing 250% of MATK as Water damage and reducing target's armor by 25 for 4 turns. Requires 1 Unstable Concoction.",
	SKILLFIREBOMB = "Fire Bomb",
	SKILLFIREBOMBDESCRIPT = "Throws Fire Bomb at a column, dealing 200% of MATK as Fire damage. Burns targets for 2 turns, dealing damage (50% of MATK) every turn. Requires 1 Unstable Concoction.",
	SKILLDISTRACT = "Distract",
	SKILLDISTRACTDESCRIPT = "Reduces target's Hitrate and Evasion by 30 for 2 turns.",
	SKILLATTRACT = "Attract",
	SKILLATTRACTDESCRIPT = "Charms target for 2 turns. Charm breaks if damage is taken.",
	SKILLENTHRAL = "Enthrall",
	SKILLENTHRALDESCRIPT = "Stuns target and self for 3 turns or until either are damaged. Only works on humanoids.",
	SKILLFIRE_ATTACK = "Fire Attack",
	SKILLFIRE_ATTACKDESCRIPT = "Deals 120% of ATK as Fire damage.",
	SKILLDRAGONMIGHT = "Dragon's Might",
	SKILLDRAGONMIGHTDESCRIPT = "Increases Damage and DEF by 25% until end of battle.",
	SKILLLESSER_HEAL = "Lesser Heal",
	SKILLLESSER_HEALDESCRIPT = "Heals target for 130% of MATK.",
	SKILLFAIRY_HEAL = "Fairy Grace",
	SKILLFAIRY_HEALDESCRIPT = "Heals target for 50% of their maximum health.",
	SKILLENTANGLE = "Entangle",
	SKILLENTANGLEDESCRIPT = "Deals 130% of MATK as Earth damage and stuns target for 1 turn.",
	SKILLSERRATED_SHOT = "Serrated Shot",
	SKILLSERRATED_SHOTDESCRIPT = "Deals 90% of ATK as physical damage. Causes target to bleed for 3 turns, dealing damage (90% of ATK) every turn.",
	SKILLMASS_LESSER_HEAL = "Mass Lesser Heal",
	SKILLMASS_LESSER_HEALDESCRIPT = "Heals a column for 100% of MATK.",
	SKILLBLIZZARD = "Blizzard",
	SKILLBLIZZARDDESCRIPT = "Deals 45% of MATK as Water damage to all enemies. Has 30% chance to reduce target's speed by 20. Has 50% chance to freeze target for 2 turns.",
	SKILLBLESS = "Bless",
	SKILLBLESSDESCRIPT = "Increases target's ATK by 25% for 3 turns.",
	SKILLMENTAL_BLESS = "Mental Bless",
	SKILLMENTAL_BLESSDESCRIPT = "Increases target's MATK by 25% for 3 turns.",
	SKILLBLOOD_MAGIC = "Blood Magic",
	SKILLBLOOD_MAGICDESCRIPT = "Sacrifices 10% of your health to convert it into mana.",
	SKILLBLOOD_EXPLOSION = "Blood Explosion",
	SKILLBLOOD_EXPLOSIONDESCRIPT = "Damages target for 300% of MATK, damages other enemies for 50% of MATK.",

	SKILLEARTH_ATK = "Earth Strike",
	SKILLEARTH_ATKDESCRIPT = "Deals 125% of ATK as Earth damage. Has 30% chance to Stun target for 1 turn.",
	SKILLWIND_ATK = "Wind Flurry",
	SKILLWIND_ATKDESCRIPT = "Deals 80% of ATK as Air damage to one target and random enemy.",
	SKILLWATER_ATK = "Water Blade",
	SKILLWATER_ATKDESCRIPT = "Deals 110% of ATK as Water damage. Causes target to bleed for 2 turns, dealing damage (30% of ATK) every turn.",
	SKILLHOLY_ATK = "Holy Attack",
	SKILLHOLY_ATKDESCRIPT = "Deals 120% of ATK as Light damage. Has 20% chance to Confuse target.",
	SKILLFIRE_CLEAVE = "Fire Cleave",
	SKILLFIRE_CLEAVEDESCRIPT = "Deals 70% of ATK as Fire damage to a column. Has 20% chance to burn target for 2 turns, dealing damage (20% of ATK) every turn.",
	SKILLEARTH_SHATTER = "Earth Shatter",
	SKILLEARTH_SHATTERDESCRIPT = "Deals 60% of ATK as Earth damage to all enemies. Reduces evasion by 25 for 2 turns.",
	SKILLREVENGE = "Revenge",
	SKILLREVENGEDESCRIPT = "Deals high physical damage based on missing health.",
	SKILLFIRE_BURST = "Fire Burst",
	SKILLFIRE_BURSTDESCRIPT = "Deals 50% of MATK as Fire damage to all enemies. Reduces target's hit chance by 20 for 3 turns.",
	SKILLAIR_CUTTER = "Air Cutter",
	SKILLAIR_CUTTERDESCRIPT = "Deals 85% of ATK as Air damage to one target and 2 random enemies. Has 50% chance to cause targets to bleed for 2 turns, dealing damage (20% of ATK) every turn.",
	SKILLHOLY_LANCE = "Holy Lance",
	SKILLHOLY_LANCEDESCRIPT = "Deals 100% of ATK as Light damage to a row.",
	SKILLSWIPE = "Swipe",
	SKILLSWIPE_EN = "Swipe",
	SKILLSWIPEDESCRIPT = "Deals 70% of ATK as Air damage to a column. Has 30% chance to reduce target's DEF by 20 for 2 turns.",
	SKILLARROWRAIN = "Arrow Rain",
	SKILLARROWRAINDESCRIPT = "Deals 65% of ATK as Water damage to a column. Has 30% chance to reduce target's MDEF by 20 for 2 turns.",
	SKILLEXPLOSIVEARR = "Explosive Arrow",
	SKILLEXPLOSIVEARRDESCRIPT = "Deals 130% of ATK as Fire damage to a target. Burns target for 2 turns, dealing damage (25% of ATK) every turn.",
	SKILLSHADOWSTRIKE = "Shadow Strike",
	SKILLSHADOWSTRIKEDESCRIPT = "Deals 130% of ATK as Dark damage to a target. Reduces target's ATK and MATK by 20 for 2 turns.",
	SKILLFIREARR = "Fire Arrow",
	SKILLFIREARRDESCRIPT = "Deals 120% of ATK as Fire damage. Has 50% chance to burn target for 2 turns, dealing damage (20% of MATK) every turn.",
	SKILLLIGHTNING = "Lightning",
	SKILLLIGHTNINGDESCRIPT = "Deals 125% of MATK as Air damage to a target. Stuns target for 1 turn.",
	SKILLMINDBLAST = "Mind Blast",
	SKILLMINDBLASTDESCRIPT = "Deals 120% of MATK as Mind damage to a target.",
	SKILLPSYCHICBLAST = "Psychic Blast",
	SKILLPSYCHICBLASTDESCRIPT = "Deals 65% of MATK as Mind damage to a column.",
	SKILLRESURRECT = "Resurrect",
	SKILLRESURRECTDESCRIPT = "Resurrects target ally at 40% of maximum health.",
	SKILLDECAY = "Decay",
	SKILLDECAYDESCRIPT = "Deals 65% of MATK as Dark damage to all enemies.",
	SKILLOVERGROWTH = "Overgrowth",
	SKILLOVERGROWTHDESCRIPT = "Deals 45% of MATK as Earth damage to all enemies.",
	SKILLFIRST_AID = "First Aid",
	SKILLFIRST_AIDDESCRIPT = "Heals ally for 30% of maximum health. Requires 1 Bandage to use.",
	SKILLLIGHT_SPELL = "Holy Light",
	SKILLLIGHT_SPELLDESCRIPT = "Deals 100% of MATK as Light damage to a target",
	SKILLLIGHT_SPELL_AOE = "Divine Radiance",
	SKILLLIGHT_SPELL_AOEDESCRIPT = "Deals 30% of MATK as Light damage to all enemies. Reduces MDEF by 20 for 3 turns.",

	SKILLENDURE = "Endure",
	SKILLENDUREDESCRIPT = "Increases all resistances by 20% for 2 turns.",
	SKILLMIRROR_IMAGE = "Mirror Image",
	SKILLMIRROR_IMAGEDESCRIPT = "Buffs All Allies: 25% chance to avoid any ability damage for 2 turns (except Mind). Replaces Energy Field.",
	SKILLENERGY_FIELD = "Energy Field",
	SKILLENERGY_FIELDDESCRIPT = "Buffs All Allies: When taking damage, deals 40% of caster's MATK as Air damage to attacker. Replaces Mirror Image.",
	SKILLPROTECTIVE_SHELL = "Protective Shell",
	SKILLPROTECTIVE_SHELLDESCRIPT = "Buffs Ally column: Reduce incoming damage by 35% for next 3 attacks.",
	SKILLHAMMERFALL = "Hammerfall",
	SKILLHAMMERFALLDESCRIPT = "Deals 150% of ATK as physical damage to a target. Stuns target for 2 turns. ",
	SKILLPURGE = "Purge",
	SKILLPURGEDESCRIPT = "Removes all negative buffs from target.",
	SKILLRIGHTEOUS_FIRE = "Righteous Fire",
	SKILLRIGHTEOUS_FIREDESCRIPT = "Deals 75% of MATK as Fire damage. Silences target for 2 turns",
	SKILLELEMENTAL_WEAKNESS = "Elemental Weakness",
	SKILLELEMENTAL_WEAKNESSDESCRIPT = "Reduces target's Fire, Air, Earth and Water resists by 40 for 3 turns.",
	SKILLELEMENTAL_PROTECTION = "Elemental Protection",
	SKILLELEMENTAL_PROTECTIONDESCRIPT = "Increases target's Fire, Air, Earth and Water resists by 25 for 3 turns.",
	SKILLTAUNT = "Taunt",
	SKILLTAUNTDESCRIPT = "Forces all enemies to focus on caster.",
	SKILLCAMOUFLAGE = "Camouflage",
	SKILLCAMOUFLAGEDESCRIPT = "Buffs All Allies: +20 Evasion for 2 turns.",
	SKILLREINCARNATE = "Reincarnate",
	SKILLREINCARNATEDESCRIPT = "Reinforces Spirit of an Ally. When HP reach zero, restore it to full.",
	SKILLHUNTERSMARK = "Hunter's Mark",
	SKILLHUNTERSMARKDESCRIPT = "Marked enemy takes 15% more damage for 3 turns.",
	SKILLBARD1 = "Hymn",
	SKILLBARD1DESCRIPT = "Buffs ally row: Increase Hitrate, Evasion and Speed by 20 for 4 turns. Cancels other Song Effects.",
	SKILLBARD2 = "Soothe",
	SKILLBARD2DESCRIPT = "Buffs ally row: Increase DEF and MDEF by 15, dispel 1 negative effect every turn. Lasts 4 turns. Cancels other Song Effects.",
	SKILLBARD3 = "Warmarch",
	SKILLBARD3DESCRIPT = "Buffs ally row: Increase ATK and MATK by 20% for 4 turns. Cancels other Song Effects.",
	SKILLSPIRIT1 = "Spirit: Hare",
	SKILLSPIRIT1DESCRIPT = "Buffs ally target: +30 speed, +25 evasion until end of combat. Cancels other Spirit Effects.",
	SKILLSPIRIT2 = "Spirit: Turtle",
	SKILLSPIRIT2DESCRIPT = "Buffs ally target: -25% Skill Damage taken, -15% Spell Damage taken until end of combat. Cancels other Spirit Effects.",
	SKILLSPIRIT3 = "Spirit: Eagle",
	SKILLSPIRIT3DESCRIPT = "Buffs ally target: +20% Skill Damage dealt, +30 Hitrate until end of combat. Cancels other Spirit Effects.",
	SKILLDEVOUR = "Devour Spirit",
	SKILLDEVOURDESCRIPT = "Debuffs enemy target: when target dies, caster restores 20% of max MP.",
	SKILLEARTHQUAKE = "Earthquake",
	SKILLEARTHQUAKEDESCRIPT = "Deals 40% of MATK as Earth damage to all enemies for 3 turns.",
	SKILLEARTHQUAKE_GLOB = "Earthquake",
	SKILLL_ORB = "Lightning Orb",
	SKILLL_ORBDESCRIPT = "Deals 250% of MATK as Air damage to a target. If target survives, deals half of the damage to random enemy.",
	
	SKILLFLY_EVASION = "Flight",
	SKILLFLY_EVASIONDESCRIPT = "Increases Evasion by 65 for 3 turns.",
	
	
	SKILLMIMIC_ATTACK = "Sticky Grab",

	WORKTOOL = "Work Tool",
	WORKTOOLAXE = "Lumber Axe",
	WORKTOOLROD = "Fishing Tools",
	WORKTOOLPICKAXE = "Pickaxe",
	WORKTOOLHAMMER = "Hammer",
	WORKTOOLBOW = "Hunting Bow",
	WORKTOOLSICKLE = "Sickle",
	WORKTOOLHUNT_KNIFE = "Hunting Knife",

	MAXIMUM_WORKERS = "Maximum workers",
	REQUIRED_UPGRADE_NAME = "Upgrade name",
	WORKERS_PER_UPGRADE = "Workers per upgrade",

	CORRECTTOOLEQUIPPED = "Correct Tool equipped: its bonus will apply. ",

	
	TASKHUNTING = "Meat",
	TASKHUNTINGDESCRIPT = "Track down native wildlife for related resources.",
	TASKFISHING = "Fish",
	TASKFISHINGDESCRIPT = "Fishing in nearby waters for aquatic resources.",
	TASKGATHERING_WOOD = "Wood",
	TASKGATHERING_WOODDESCRIPT = "Work in forest to gather Wood materials. Wood is widely used in constructions but can also serve as tool material.",
	TASKMINING_STONE = "Stone",
	TASKMINING_STONEDESCRIPT = "Work at mines for gathering Stones. Stones are heavily used in constructions but can also serve as some material parts.",
	TASKPROSTITUTION = "Prostitution",
	TASKPROSTITUTIONDESCRIPT = "Providing sexual services to public in order to earn gold.",
	TASKBROTHEL = "Service",
	TASKBROTHELDESCRIPT = "Provides entertainment or sexual service in exchange for gold.",
	TASKCOOKING = "Cooking",
	TASKCOOKINGDESCRIPT = "Craft food items. Must have chosen a recipe to cook. ",
	TASKTAILOR = "Tailor",
	TASKTAILORDESCRIPT = "Craft cloth and leather items and gear. Must have chosen the items to craft. ",
	TASKSMITH = "Smith",
	TASKSMITHDESCRIPT = "Craft forge and metal items and gear. Must have chosen the items to craft. ",
	TASKALCHEMY = "Alchemy",
	TASKALCHEMYDESCRIPT = "Craft alchemical potions and items. Must have chosen the items to craft. ",
	TASKBUILDING = "Upgrading",
	TASKBUILDINGDESCRIPT = "Work on the current upgrade. Upgrade must be set in Upgrades menu. ",
	TASKTRAVEL = "Travel",
	TASKREST = "Rest",
	TASKRESTSERVICE = "Rest/Service",
	TASKRESTDESCRIPT = "Resting improves injury healing and health recovery. Will not do any work while resting.",
	TASKFARMING_VEGES = "Vegetables",
	TASKFARMING_VEGESDESCRIPT = "Work at farm, raising vegetables. Vegetables are a food staple for many races.",
	TASKFARMING_GRAINS = "Grains",
	TASKFARMING_GRAINSDESCRIPT = "Work at farm, raising grains. Grains can be cooked into food items.",
	TASKFARMING_COTTON = "Cotton",
	TASKFARMING_COTTONDESCRIPT = "Work at farm, raising cotton. Cotton is then processed into cloth and can be used for armor.",
	TASKFARMING_CLOTH_SILK = "Silk",
	TASKFARMING_CLOTH_SILKDESCRIPT = "Gathering Silk from insect farms. Silk is a sturdy and smooth cloth material which has many uses.",
	TASKGATHERING_WOOD_MAGIC = "Magic Wood",
	TASKGATHERING_WOOD_MAGICDESCRIPT = "Work in forest to gather Magic Wood. Special property wood can be utilized in many ways.",
	TASKGATHERING_WOOD_IRON = "Iron Wood",
	TASKGATHERING_WOOD_IRONDESCRIPT = "Work in forest to gather Iron Wood. Iron wood is sturdier and heavier than normal.",
	TASKMINING_IRON = "Iron",
	TASKMINING_IRONDESCRIPT = "Work at mines for gathering Iron. Iron is widely used in metal tools, constructions and armor.",
	TASKMINING_MITHRIL = "Mythril",
	TASKMINING_MITHRILDESCRIPT = "Work at mines for gathering Mythril — a potent magic alloy recognized for its outstanding quality.",
	TASKMINING_OBSIDIAN = "Obsidian",
	TASKMINING_OBSIDIANDESCRIPT = "Work at mines for gathering Obsidian. Obsidian is recognized for its rarity and certain magical properties.",
	TASKRECRUIT_EASY = "Search for recruits",
	TASKRECRUIT_EASYDESCRIPT = "Search for recruits at current location. After its finished you'll be able to talk them into joing you if succesful.",
	TASKRECRUIT_HARD = "Search for recruits",
	TASKRECRUIT_HARDDESCRIPT = "Search for recruits at current location. After its finished you'll be able to talk them into joing you if succesful.",
	TASKMISSION = "Mission",
	TASKRONMISSIONCOMPLETE = "When this task is finished receive your reward from Journal.",
	
	BEDROOMTOOLTIP = "Available number of characters for sexual interactions. Increases with Bedroom Upgrade",
	DATETOOLTIP = "Dates left this week. Increases with Master's Charm Factor and resets at the start of a week.",
	SEXTOOLTIP = "Sexual Interactions left this week. Increases with Master's Sexual Factor and resets at the start of a week.",
	
	TOOLTIPLOYALTYOBEDIENCE = "Loyalty points are gained every turn based on Tame Factor. You can unlock new actions and passives with it.\n\nObedience Drain is based on Timid Factor and character training. If Obedience falls to 0 the character will attempt to escape. Unlock new options and use proper gear to reduce Obedience Drain and make it more manageble. ",
	TOOLTIPVALUE = "Character's value means their market price. It's based on their Growth Factor, Race, Training and certain features. Higher value characters will earn more money when providing services and prostitution.",
	
	TASKMAINSTAT = "Main characteristic",
	
	JOBPROSTITUTEGOLDDESCRIPT = "Earn gold by prostitution.",
	JOBCOOKINGCRAFTDESCRIPT = "Cook food in kitchen.",
	JOBBUILDINGCRAFTDESCRIPT = "Work on the current upgrade.",
	JOBSMITHCRAFTDESCRIPT = "Craft item at the forge.",
	JOBTAILORCRAFTDESCRIPT = "Craft item in tailor workshop.",
	JOBALCHEMYCRAFTDESCRIPT = "Craft item in alchemy workshop.",
	
	BROTHELTOOLTIP = "You can select which tasks the character will be allowed to perform while working at brothel. By toggling specific tasks only those will be allowed. Client sexes only affect sexual tasks.\nHigher character Value increases earnings, higher Charm increases likelyhood of being requested for sex.\nDifferent tasks improve and scale from different stats.\nService is a global modifier for this assignment.",
	
	CAPTURETOOLTIP = "These characters have been found by your team and can be recruited into your mansion or sold for quick cash as if you were selling them manually. If location has been forgotten, all characters are sold automatically.",
	CAPTURESELLTOOLTIP = "Quicksell this character for %d gold. This is equal to selling character to market but won't let you buyback them. ",
	CAPTUREADDTOOLTIP = "Add this character to roster. You won't be able to finish turn if your total number of characters is bigger than available number of rooms. ",
	CAPTURERECRUITTOOLTIP = "Attempt to recruit this character. You won't be able to finish turn if your total number of characters is bigger than available number of rooms.",
	CAPTUREDISMISSTOOLTIP = "Dismiss this character.",
	
	FACTOR_INCREASE_TOOLTIP = "By sacrificing unneeded characters you can boost factors of other characters as long as donor character's stat is higher than receiver's. Growth Factor only can be increased by 1 per donor. End price is defined by receiver's value.",
	COMBAT_CHARACTER_CAPTURED = "Character",
	BROTHELWAITRESS = "Waitress",
	BROTHELWAITRESSDESCRIPT = "[name] will work as waitress and serve customers with food and drinks. One of the most innocent assignements out there. Scales with Charm",
	BROTHELWAITRESSALT = "Waiter",
	BROTHELHOSTESS = "Hostess",
	BROTHELHOSTESSALT = "Host",
	BROTHELHOSTESSDESCRIPT = "[name] will entertain customers with chatting and flirt. Scales with Wits",
	BROTHELDANCER = "Dancer",
	BROTHELDANCERDESCRIPT = "[name] will stage dances and performances in front of auditory. Scales with Physics",
	BROTHELSTRIPPER = "Stripper",
	BROTHELSTRIPPERDESCRIPT = "[name] will flash [his] privates and perfrom private shows without going all the way. Scales with Charm",
	
	BROTHELPETTING = "Non-penetrative",
	BROTHELPETTINGDESCRIPT = "[name] will provide sex service without allowing penetrative actions saving potential virginity and preventing impregnation.",
	BROTHELORAL = "Oral",
	BROTHELORALDESCRIPT = "[name] will perform oral sex for clients.",
	BROTHELPUSSY = "Vaginal",
	BROTHELPUSSYDESCRIPT = "[name] will allow clients to use [his] vagina potentially leading to impregnation.",
	BROTHELPENETRATION = "Penetration",
	BROTHELPENETRATIONDESCRIPT = "[name] will satisfy clients with using [his] penis.",
	BROTHELANAL = "Anal",
	BROTHELANALDESCRIPT = "[name] will serve clients with [his] ass.",
	BROTHELGROUP = "Group",
	BROTHELGROUPDESCRIPT = "[name] will serve multiple clients at once.",
	BROTHELSEXTOY = "Sextoy",
	BROTHELSEXTOYDESCRIPT = "[name] will willingly oblidge to any sexual activity the clients may ask from [him].",
	
	BROTHELMALES = "Males",
	BROTHELMALESDESCRIPT = "[name] will serve male customers. This can lead to pregnancy. Toggle to disable.",
	BROTHELFEMALES = "Females",
	BROTHELFEMALESDESCRIPT = "[name] will serve female customers. Toggle to disable.",
	BROTHELFUTA = "Futas",
	BROTHELFUTADESCRIPT = "[name] will serve futanari customers. This can lead to pregnancy. Toggle to disable.",
	
	
	BUTTONCLASS = "Classes and Skills",
	BUTTONTRAINING = "Training and Rules",
	BUTTONGEAR = "Gear",
	BUTTONCUSTOMIZATION = "Customization",

	SLAVEPARTNAME = "Name",
	SLAVEPARTSURNAME = "Surname",
	SLAVEPARTNICKNAME = "Nickname",
	SLAVEPARTRACE = "Race",
	SLAVEPARTAGE = "Age",
	SLAVEPARTSEX = "Sex",
	SLAVEPARTSKIN = "Skin Color",
	SLAVEPARTHAIR_COLOR = "Hair Color",
	SLAVEPARTHAIR_LENGTH = "Hair Length",
	SLAVEPARTHAIR_STYLE = "Hair Style",
	SLAVEPARTEARS = "Ears",
	SLAVEPARTEYE_COLOR = "Eye Color",
	SLAVEPARTEYE_SHAPE = "Eye Shape",
	SLAVEPARTTAIL = "Tail",
	SLAVEPARTHORNS = "Horns",
	SLAVEPARTWINGS = "Wings",
	SLAVEPARTHEIGHT = "Height",
	SLAVEPARTARMS = "Arms",
	SLAVEPARTLEGS = "Legs",
	SLAVEPARTPENIS_SIZE = 'Penis Size',
	SLAVEPARTPENIS_TYPE = 'Penis Shape',
	SLAVEPARTBALLS_SIZE = "Testicle Size",
	SLAVEPARTASS_SIZE = "Butt Size",
	SLAVEPARTTITS_SIZE = "Breast Size",
	SLAVEPARTVAGINAL_VIRGIN = "Vaginal Virgin",
	SLAVEPARTANAL_VIRGIN = "Anal Virgin",
	SLAVEPARTPENIS_VIRGIN = "Penis Virgin",
	SLAVEPARTSEXTRAIT = "Sexual Trait",
	SLAVEPARTPERSONALITY = "Personality",

	SLAVEPARTPERSONALITYDESCRIPT = "Personality defines character's speech patterns and has no gameplay effects.",

	SLAVEDIET = "Food Preferences",
	SLAVESTARTINGCLASS = "Starting Class",
	#Bodyparts

	SIZETINY = "Tiny",
	SIZEPETITE = "Petite",
	SIZESHORT = "Short",
	SIZEAVERAGE = "Average",
	SIZETALL = "Tall",
	SIZETOWERING = "Towering",
	SIZESMALL = "Small",
	SIZEBIG = "Big",

	SLAVESEXMALE = "Male",
	SLAVESEXFEMALE = "Female",
	SLAVESEXFUTA = "Futa",
	SLAVEAGETEEN = "Teen",
	SLAVEAGEADULT = "Young Adult",
	SLAVEAGEMATURE = "Mature",

	SLAVECLASSDESCRIPT = "Slaves are considered to be property. Their life solely belongs to their master and in case of escape they are treated as criminals effectively negating their rights.\n\n[color=aqua]Slaves suffer 10% damage reduction, but they gain Loyalty faster by 30%. Slaves have +10% bonus to Collection, Farming and Prostitution tasks, but -15% to Smith, Tailor and Alchemy. Slaves can be forced into sexual service for gold without training but at reduced efficiency.[/color]",
	SERVANTCLASSDESCRIPT = "Peons generally have the same rights of others, but are purchased to serve a Master. Many folks end up as peons as a way to pay their, or their family's debt, or otherwise gain a stable living condition. However, if they escape, peons can often continue their life with only minor penalties. Therefore, they gain no penalties or benefits compared to slaves. They also cannot be forced to participate in sexual activities.",
	HEIRCLASSDESCRIPT = "Mansion's heir are children born of [master] and their spouse.\n\n[color=aqua]Heir's Obedience drain 50% slower and Loyalty is 50% faster. Heir has 20% penalty to Collection, Farming and Fishing.[/color] ",

	SLAVETYPE = "Type",

	SLAVEBODYHUMANOID = "Humanoid",
	SLAVEBODYBESTIAL = "Bestial",
	SLAVEBODYSHORTSTACK = "Shortstack",
	SLAVEBODYJELLY = "Jelly",
	SLAVEBODYHALFBIRD = "Half-bird",
	SLAVEBODYHALFSNAKE = "Half-snake",
	SLAVEBODYHALFFISH = "Half-fish",
	SLAVEBODYHALFSPIDER = "Half-spider",
	SLAVEBODYHALFHORSE = "Half-horse",
	SLAVEBODYHALFSQUID = "Half-squid",

	SLAVEBODYHUMANOIDDESCRIPT = "",
	SLAVEBODYBESTIALDESCRIPT = "",
	SLAVEBODYSHORTSTACKDESCRIPT = "[His] body is rather [color=yellow]petite[/color], about half the size of the average human.",
	SLAVEBODYJELLYDESCRIPT = "[His] body is [color=yellow]jelly-like[/color] and partly transparent.",
	SLAVEBODYHALFBIRDDESCRIPT = "[His] body has [color=yellow]wings for arms and avian legs[/color] making everyday tasks difficult.",
	SLAVEBODYHALFSNAKEDESCRIPT = "The lower portion of [his] body consists of a long-winding [color=yellow]snake's tail[/color].",
	SLAVEBODYHALFFISHDESCRIPT = "[His] body is [color=yellow]scaly and sleek[/color], possessing fins and webbed digits.",
	SLAVEBODYHALFSPIDERDESCRIPT = "The lower portion of [his] body consists of a [color=yellow]spider's legs and abdomen[/color].",
	SLAVEBODYHALFHORSEDESCRIPT = "While [his] upper body is human, [his] lower body is [color=yellow]equine[/color] in nature.",
	SLAVEBODYHALFSQUIDDESCRIPT = "The lower portion of [his] body consists of a [color=yellow]number of tentacular appendages[/color], similar to those of an octopus.",




	CLASSRIGHTCLICKDETAILS = "Right click for details",

	TOOLTIPSEXTRAITS = "Sexual traits are special bonuses which provide benefits during the interaction sequence. ",
	TOOLTIPTAX = "Taxes is a gold you pay at the start of each week. Getting better upgrades will increase your tax value. If your gold goes negative, you lose. ",
	
	
	STATHP = "Health",
	STATHPDESCRIPT = "Health decreases in combat and from some skills and events. Once health is reduced to 0, character dies.",
	STATENERGY = "Energy",
	STATENERGYDESCRIPT = "Energy is restored during sleep and is required for task production. When character is forced to work with no energy left, they accumulate Exhaustion. ",
	STATHPMAX = "Max. Health",
	STATHPFACTOR = "Health Factor",
	STATHPFACTORDESCRIPT = "Determines health bonuses acquired in most ways. A high health factor can greatly increase survivability. ",

	STATHPMAXMOD = "Max. Health",

	STATMP = "Mana",
	STATMPDESCRIPT = "Mana is used for casting spells and using some abilities.",
	STATMPMAX = "Max. Mana",
	STATMPMAXMOD = "Max. Mana",
	STATHITRATE = "Hit chance",
	STATHITRATEDESCRIPT = "Chance to hit enemy. Reduced by target's evasion.",
	STATEVASION = "Evasion",
	STATEVASIONDESCRIPT = "Chance to dodge enemy attacks.",
	STATSPEED = "Speed",
	STATSPEEDDESCRIPT = "Increases chance to attack before others.",
	STATARMOR = "DEF",
	STATARMORDESCRIPT = "Reduces physical damage taken.",
	STATMDEF = "MDEF",
	STATMDEFDESCRIPT = "Reduces magical damage taken.",
	STATATK = "ATK",
	STATATKDESCRIPT = "Defines physical damage values.",
	STATMATK = "MATK",
	STATMATKDESCRIPT = "Defines magical damage values.",
	STATCRITCHANCE = "Crit Chance",
	STATCRITCHANCEDESCRIPT = "Defines chance of a critical hit.",
	STATCRITMOD = "Crit Mod",
	STATCRITMODDESCRIPT = "Defines bonus damage of critical hits.",
	STATRESIST = "Resist",
	STATRESISTDESCRIPT = "Reduces damage from specific element.",
	STATDAMAGEMOD = "Damage Mult.",
	STATDAMAGEMODDESCRIPT = "Increases all damage by value",
	STATARMORPENETRATION = "Armor Pen.",
	STATARMORPENETRATIONDESCRIPT = "Ignores value of enemy's armor. ",
	STATMODMELEE = "Melee Dam.",
	STATMODRANGED = "Ranged Dam.",
	STATDAMAGE_MOD_SKILL = "Physical Damage",


	STATFATIGUE = "Fatigue",
	STATEXHAUSTION = "Exhaustion",
	STATFATIGUEDESCRIPT = "Mental fatigue of the character. Fatigue reduces productivity. Restores when focusing on Joy.",
	STATEXHAUSTIONDESCRIPT = "Physical exhaustion of the character. Reduces productivity and may cause other health issues. Restores while sleeping. ",


	STATBASE_EXP = "Experience",
	STATBASE_EXPDESCRIPT = "Experience is acquired by combat and work. Experience is used to unlock new classes.",

	STATPHYSICS = "Physics",
	STATWITS = "Wits",
	STATCHARM = "Charm",
	STATSEXUALS = "Sexual Proficiency",

	STATPHYSICSDESCRIPT = "Physical representation of character's muscles and reflexes. The higher it is, the more effective the character is at combat and manual labor tasks. Grows with physical labor and by using Skill type abilities in combat.",
	STATWITSDESCRIPT = "Wits represent character's quickness of mind and intelligence. High Wits is mandatory for stronger Mage classes and crafters. Grows with some crafting labors and by using Spell type abilities in combat.",
	STATCHARMDESCRIPT = "Charm represents character's appeal and appearance. High Charm makes social oriented works and skills a lot more effective. Grows from using social abilities.",
	STATSEXUALSDESCRIPT = "Sexual Proficiency represents character's skills in body pleasures. It is calculated by sum of 3 highest sexual skills and affects certain tasks and abilities.",

	STATGROWTH_FACTOR = "Growth",
	STATMAGIC_FACTOR = "Magic Affinity",
	STATPHYSICS_FACTOR = "Physics Factor",
	STATWITS_FACTOR = "Wits Factor",
	STATCHARM_FACTOR = "Charm Factor",
	STATSEXUALS_FACTOR = "Sex Factor",
	STATTAME_FACTOR = "Tame Factor",
	STATTIMID_FACTOR = "Timid Factor",

	STATPHYSICS_BONUS = "Physics",
	STATWITS_BONUS = "Wits",
	STATCHARM_BONUS = "Charm",
	STATSEXUALS_BONUS = "Sexuals",

	STATOBEDIENCE = "Obedience",
	STATOBEDIENCEDESCRIPT = "Obedience is a character's willingness to obey your orders. Obedience is gained by using social skills. When depleted character can escape and will be lost in case that happens. ",
	STATLOYALTY = "Loyalty",
	STATLOYALTYDESCRIPT = "Loyalty points allow you to unlock new abilities for your servants. Loyalty is gained passively based on character's Tame Factor but can also be improved on dates and usage of social skills.",
	STATSUBMISSION = "Submission",#Obsolete
	STATSUBMISSIONDESCRIPT = "Submission is built with punishing skills. It will decrease with time unless maxed out. Maxed out Submission will no longer require Obedience for work and stops escapes.",
	STATAUTHORITY = "Authority",#Obsolete
	STATAUTHORITYDESCRIPT = "Authority represents a character's respect for you. Authority is built by punishments and dates, and determines how quickly Loyalty is built. Low authority and obedience makes possible for character to attempt escape.",
	STATLUST = "Lust",
	STATLUSTDESCRIPT = "Lust increases with time and allows the use of specific skills. Lust can be a powerful control and resource tool when utilized correctly.",
	STATPRODUCTIVITY = "Productivity",
	STATPRODUCTIVITYDESCRIPT = "Affects all productive tasks. Total productivity applies to all occupations, while efficiency will boost specific tasks.",
	STATCONSENT = "Consent",
	STATCONSENTDESCRIPT = "Affects consent for actions during sex interactions. Each action has different consent based on traits, partners and other factors. This number represents only the unaltered value. Basic consent grows when having positive results, trying new actions and partners. Also slightly increased from discipline skills. ",

	STATLOYALTY_GAIN_MOD = "Loyalty Gain",
	STATLOYALTY_GAIN = "Loyalty Gain",
	STATLUSTTICK = "Lust Growth",
	STATOBEDIENCE_DRAIN = "Obedience Drain",

	STATMOD_BUILD = "Upgrading",
	STATMOD_COLLECT = "Collection",
	STATMOD_HUNT = "Hunt",
	STATMOD_FISH = "Fish",
	STATMOD_COOK = "Cook",
	STATMOD_SMITH = "Smith",
	STATMOD_TAILOR = "Tailor",
	STATMOD_ALCHEMY = "Alchemy",
	STATMOD_FARM = "Farming",
	STATMOD_PROS = "Service",
	STATMOD_TASK_EFFICIECNY = "Task Effciency",
	STATMOD_WAITRESS = "Waitress Income",
	STATMOD_HOSTESS = "Hostess Income",
	STATMOD_DANCER = "Dancer Income",
	STATMOD_STRIP = "Stripper Income",

	STATRESIST_NORMAL = "Normal Resist",
	STATRESIST_FIRE = "Fire Resist",
	STATRESIST_AIR = "Air Resist",
	STATRESIST_EARTH = "Earth Resist",
	STATRESIST_WATER = "Water Resist",
	STATRESIST_LIGHT = "Light Resist",
	STATRESIST_DARK = "Dark Resist",
	STATRESIST_MIND = "Mind Resist",
	
	STATPRICE = "Value",
	
	STATFOOD_CONSUMPTION = "Food Consumption",
	STATFOOD_CONSUMPTIONDESCRIPT = "Amount of food items a person requires every day. Lack of food leads to starvation, exhaustion and eventual death.",

	TOOLTIPENERGY = "Energy is restored during sleep and is required for tasks. When a character is forced to work with no energy left, their Exhaustion increases. ",
	TOOLTIPFATIGUE = "Fatigue increases with time and dissipates with entertainment. When unmanaged it may cause a performance penalty.",
	TOOLTIPEXHAUSTION = "Exhaustion grows when a character is forced to work with no energy left. Exhaustion causes penalties to maximum health and production, and can lead to death if not taken care of for a long time.",

	TOOLTIPSIMPLEBEHAVIOR = "While having Simple Behavior active, character will work until they run out of energy, Rest until energy is full and seek Joy until Fatigue is gone. Recommended for beginners.",
	TOOLTIPPBASEPRODUCTIVITY = "Base Productivity. Reduced by Fatigue and Exhaustion.",

	TOOLTIPGOLD = "Owned gold. Gold is used for buying slaves and items and can be obtained from selling items, completing quests and some tasks.",
	TOOLTIPFOOD = "Owned Food items / food consumed per day. Food is used by every character and can be obtained from some tasks and increased with cooking. Lack of food will lead to exhaustion and eventual death. ",
	
	
	
	INFOFOODFILTER = "Food filter allows to restrict or prioritize food which character will consume. Higher priority food consumed first. Keep in mind that some food may be hated by a character.",
	INFOSEX_SKILLS = "Sex Skills refer to character's performance during sex. The higher they are, the quicker they can make thier partner to orgasm with related actions. Character's Sexual Proficiency is based on average of 3 highest skills.\nConsent represents character's general acceptance of various sexual actions, but it is also heavily affected by partners and situtation.",
	INFOSEX_TRAITS = "Sex Traits provide additional effects during sexual interaction. They can be learned, activated and deactivated. Maximum number of activatale traits is based on Sex Factor.",
	INFORULES_CONDS = "Conditions and rules can be toggled on character, affecting some of their stats and behavior.",
	
	
	INFOHOLDSHIFT = "Hold shift for details",
	
	STATGROWTH_FACTORDESCRIPT = "Growth is character's affinity to getting stronger. As character acquire more classes all their stats increase. Every point of growth increases the number of classes which will increase its stats. It also greatly affects character's Value. \n\n{color=green|Affected stats are: Productivity, Physics, Wits, Charm, Max Health, Max Mana, Speed, Hitrate, Evasion, ATK, MATK, DEF, MDEF.} ",
	STATPHYSICS_FACTORDESCRIPT = "Physics factor represents physical potential of the character. It increases [color=aqua]Physical[/color] growth and influences melee combat.\n\n{color=green|Maxed Physics Factor increases natural Health Regeneration.}",
	STATMAGIC_FACTORDESCRIPT = "Magic factor represents character's magic affinity. The higher it is, the more mana you have and the stronger magic classes you can unlock. Also affects mana regeneration.\n{color=green|Maxed Magic Factor provides MATK bonus.}",
	STATTAME_FACTORDESCRIPT = "Tame factor represents how easy it is to befriend the character. The higher it is, the more Loyalty character will gain passively and from Gracious and Lewd social skills.\n\n{color=green|Maxed Tame Factor increases Loyalty Gain.}",
	STATTIMID_FACTORDESCRIPT = "Timid factor represents how easily the character can be influenced by punishments and abuse. The higher it is, the more effective Mean Social Skills are for building loyalty and lower Obedience Drain.\n\n{color=green|Maxed Timid Factor reduces Damage Taken.}",
	STATWITS_FACTORDESCRIPT = "Wits factor represents the character's mind potential. It increases [color=aqua]Wits[/color] growth.\n\n{color=green|Maxed Wits Factor increases experience gain.}",
	STATCHARM_FACTORDESCRIPT = "Charm factor represents character's appeal potential. It increases [color=aqua]Charm[/color] growth. Master's charm also increases gold and reputation rewards from repeatable quests and number of dates per week.\n\n{color=green|Maxed Charm Factor furtherly increases social skill efficiency.}",
	STATSEXUALS_FACTORDESCRIPT = "Sex factor represents character's sex development potential. It speeds sexual skills acquirement and occasionally boosts sexual options in events. Master's Sex factor also increases number of sex interactions per week.\n\n{color=green|Maxed Sex Factor provides Speed bonus}.",
	
	
	PHYSICS_FACTORBONUSDESCRIPT = "Physics Factor: Health Regeneration: x2",
	WITS_FACTORBONUSDESCRIPT = "Wits Factor: Experience gain: +20%%",
	CHARM_FACTORBONUSDESCRIPT = "Charm Factor: Social Skills Efficiency +20%%",
	SEXUALS_FACTORBONUSDESCRIPT = "Sex Factor: Speed: +10",
	MAGIC_FACTORBONUSDESCRIPT = "Magic Factor: MATK: +10%%",
	TAME_FACTORBONUSDESCRIPT = "Tame Factor: Loyalty Gain: +25%%",
	TIMID_FACTORBONUSDESCRIPT = "Timid Factor: Damage taken: -15%%",
	

	STATFOOD_LOVE = "Loved Food",
	STATFOOD_HATE = "Hated Food",
	STATFOOD_LOVEDESCRIPT = "When a favorite food is eaten, it gives a minor boost to Productivity and Obedience for the next day. Food made of both loved and hated ingredients will be considered as neutral and give no bonus or penalty. ",
	STATFOOD_HATEDESCRIPT = "When hated food is eaten, it will lower Productivity for the next day. Food made of both loved and hated ingredients will be considered as neutral and give no bonus or penalty.",

	STATTASK_EFFICIENCY_TOOL = "Task Efficiency Bonus",
	STATTASK_CRIT_CHANCE = "Task Crit Chance",




	RACEHUMAN = "Human",
	RACEHUMANADJ = "Human",
	RACEELF = "Elf",
	RACEELFADJ = "Elven",
	RACETRIBALELF = "Tribal Elf",
	RACETRIBALELFADJ = "Tribal Elven",
	RACEDARKELF = "Dark Elf",
	RACEDARKELFADJ = "Dark Elf",
	RACEORC = "Orc",
	RACEORCADJ = "Orc",
	RACEGOBLIN = "Goblin",
	RACEGOBLINADJ = "Goblin",
	RACEKOBOLD = "Kobold",
	RACEKOBOLDADJ = "Kobold",
	RACEDWARF = "Dwarf",
	RACEDWARFADJ = "Dwarven",
	RACEGNOME = "Gnome",
	RACEGNOMEADJ = "Gnome",
	RACEFAIRY = "Fairy",
	RACEFAIRYADJ = "Fairy",
	RACEDRYAD = "Dryad",
	RACEDRYADADJ = "Dryad",
	RACEDEMON = "Demon",
	RACEDEMONADJ = "Demon",
	RACESERAPH = "Seraph",
	RACESERAPHADJ = "Seraph",
	RACEDRAGONKIN = "Dragonkin",
	RACEDRAGONKINADJ = "Dragonkin",
	RACECENTAUR = "Centaur",
	RACECENTAURADJ = "Centaur",
	RACETAURUS = "Taurus",
	RACETAURUSADJ = "Taurus",
	RACEHARPY = "Harpy",
	RACEHARPYADJ = "Harpy",
	RACESLIME = "Slime",
	RACESLIMEADJ = "Slime",
	RACELAMIA = "Lamia",
	RACELAMIAADJ = "Lamia",
	RACEARACHNA = "Arachna",
	RACEARACHNAADJ = "Arachna",
	RACESCYLLA = "Scylla",
	RACESCYLLAADJ = "Scylla",
	RACENEREID = "Nereid",
	RACENEREIDADJ = "Nereid",

	RACEBEASTKINCAT = "Beast Cat",
	RACEBEASTKINCATADJ = "Beast Cat",
	RACEBEASTKINWOLF = "Beast Wolf",
	RACEBEASTKINWOLFADJ = "Beast Wolf",
	RACEBEASTKINFOX = "Beast Fox",
	RACEBEASTKINFOXADJ = "Beast Fox",
	RACEBEASTKINBUNNY = "Beast Bunny",
	RACEBEASTKINBUNNYADJ = "Beast Bunny",
	RACEBEASTKINTANUKI = "Beast Tanuki",
	RACEBEASTKINTANUKIADJ = "Beast Tanuki",

	RACEHALFKINCAT = "Half-Breed Cat",
	RACEHALFKINCATADJ = "Half-Breed Cat",
	RACEHALFKINWOLF = "Half-Breed Wolf",
	RACEHALFKINWOLFADJ = "Half-Breed Wolf",
	RACEHALFKINFOX = "Half-Breed Fox",
	RACEHALFKINFOXADJ = "Half-Breed Fox",
	RACEHALFKINBUNNY = "Half-Breed Bunny",
	RACEHALFKINBUNNYADJ = "Half-Breed Bunny",
	RACEHALFKINTANUKI = "Half-Breed Tanuki",
	RACEHALFKINTANUKIADJ = "Half-Breed Tanuki",

	RACEHUMANDESCRIPT = "Humans are one of the most common races. Their strength comes in their numbers and flexibility, but they generally are rather weak in magic and have low potential growth. Only a few exceptional humans have shown outstanding feats. \n\nHuman society is rather open to others but also quick to anger and start wars even among themselves. While some might act prudish, especially in public, humans in general are very sexually active and do not stray from other humanoid races. ",
	RACEELFDESCRIPT = "Elves prefer living in the forest and being close to nature with other naturistic races like Dryads and Fairies. They are adept in magic, but their physical strength is fairly mediocre. \n\nElven society is fairly secluded but isn't above contact and trading with other races. Elves rarely show an active interset in sex outside of their social group, often preferring life-long relationships. Still they are considered very appealing and attractive by other races making them in popular demand as slaves.",
	RACETRIBALELFDESCRIPT = "A rarer version of elves with distinct dark skin. Tribal elves mostly inhabit southern regions and show numerous differences to their common counterparts. They are less prone to magic but possess stronger bodies.\n\nHowever, their society (often separated into tribes) is more secluded and hostile to outsiders, but they are also more open to sex than normal elves.",
	RACEDARKELFDESCRIPT = "A rare subspecies of elves propagated and trained for combat. Their bluish skin and rare eye colors make them very noticeable and force them to hide their bodies in clothes. Being adepts in both physical techniques and magic, they often happen to be trained assassins, combatants and sellswords. ",
	RACEORCDESCRIPT = "Orcs are a semi-sapient race of brutes inhabiting many desert and badland regions. Orcs resemble large, greenish humanoids with strong bodies and bad tempers. Despite that, some orcs are rather capable of fitting into normal society to work as simple bodyguards and soldiers. \n\nCommonly orcs form tribes and aren't above killing each other or any stray groups they deem dangerous. They are also rather fond of forcefully using members of other races for sex but aren't capable of interbreeding with them. ",
	RACEGOBLINDESCRIPT = "Goblins are short humanoids often occupying caves and dungeons. Most goblins are outright hostile to all outsiders and prefer to stick to groups as their individual power is fairly low. A certain number of goblins have abandoned their initial groups and strive to live with other races. Sometimes they even become known adventurers, but more often they are used for crude work, since they are hardly remarkable at anything except for their libido. ",
	RACEKOBOLDDESCRIPT = "Kobolds are a short, lizard-like race distinctively related to dragons. They generally live underground or in forests and aren't very friendly to other races often seen as pests. Certain individuals have managed to find acceptance among other racial groups. ",
	RACEGNOMEDESCRIPT = "Gnomes are a rare species of short, intelligent humanoids. Their poor physical strength makes them rather poor workers or fighters. They possess some magical capabilities, a good amount of charisma and have an easy time connecting with other races. Many gnomes find their place as traders or entertainers, but a good amount are pretty happy to serve in more lewd occupations... assuming they can find the demand. ",
	RACEDWARFDESCRIPT = "Dwarves are a short, stout humanoid race that prefer to live by a strict set of rules in an enclosed underground society. Dwarves are rather physically strong, can be quick to anger, and are rarely fit for magic tasks. ",
	RACEDRYADDESCRIPT = "Dryads are a rare species of forest humanoids possessing green skin and being covered in plant matter. They rarely engage in communication with other races and generally prefer to stick to their home. Despite that, they are quite capable of fighting and using magic.",
	RACEFAIRYDESCRIPT = "Fairies are curious children of the forests. Looking like half-sized humanoids with a pair of insect wings on their back, fairies possess little physical threat, but their natural magic affinity is incredibly high. Their magic nature even allows them to occasionally heal wounds.\n\n Thankfully they rarely use it aggressively, preferring to instead just have fun and be quick to flee. Despite their childish temper, fairies are very proactive or even omnivorous when it comes down to bodily pleasures not unlike their cave counterparts — Goblins.",
	RACEDEMONDESCRIPT = "Demons are a humanoid race that came from outer planes. They can be easily distinguished by their horns, leathery wings and animalistic eyes. Their magical and physical powers are both capable of reaching unusual height when compared to mortals and their temper is on par with it. Demons can be either a dangerous enemy or a mighty ally in case you actually manage to tame one. ",
	RACESERAPHDESCRIPT = "Seraphs are angel-like beings, possessing a pair of white wings. Their characters match their pure appearance. While their strength is not very high, they are quite capable of magic. ",
	RACEDRAGONKINDESCRIPT = "An extremely rare breed of humanoid and dragon. Their dragon ancestry provides them with great strength and magic powers. Like their draconic predecessor they prefer to spend their time in solitude upon the mountains.",
	RACETAURUSDESCRIPT = "Taurus are a humanoid race with cow-like features. They excel in raw strength but are subpar in other fields. Most commonly found on the flat plains these creatures have found common acceptance in farming communities for their strength and docile nature.",
	RACECENTAURDESCRIPT = "The Centaur race is somewhat distant, yet not unheard of in southern regions. Some individuals have made it very far by adopting a nomadic lifestyle, making the race common enough to be recognized by most. The Centauri population is relatively small, due to dealing with territorial oppression from humanoid races.",
	RACEHARPYDESCRIPT = "Harpies are human-bird hybrids with easily recognizable features, such as their feathered arms and avian lower quarters. Commonly seen as monsters, they have existed since time immemorial. Wild harpies generally inhabit mountain regions and are relatively aggressive. They have a wide range of intelligence, and people have had some success making them into slave-pets.",
	RACESLIMEDESCRIPT = "Some slimes have managed to evolve beyond their usual state and are capable of holding the soul of living beings. Taking on a humanoid appearance they are even able to develop speech and eventually acquire personality. Their bodies are still capable of unusual properties but they are considerably better at controlling it at will. ",
	RACELAMIADESCRIPT = "Lamias are easily recognized as from the waist down their body becomes a serpentine tail. They tend to be timid in their interactions rarely showing themselves to the majority of the population. Their population has been severely reduced by hunting and extermination expeditions launched by different races. Lamias are surprisingly intelligent, as the few captured and studied samples have shown.",
	RACESCYLLADESCRIPT = "Scylla are rather unusual in appearance, possessing a number of tentacle-like appendages they use in the place of legs. They generally prefer damp and aquatic regions. In general, their behavior and capabilities are not much different from lamia. Their appearance is extremely rare to the point of being treated as mere myth or drunken fancy by some.",
	RACEARACHNADESCRIPT = "Having a humanoid head and torso with the abdomen of a spider it is difficult to mistake an Arachna even though seeing one is rare. Arachna live in isolation and tend to choose caves and other underground locations as their homes. While not being especially aggressive, they are fearsome hunters and have been reported for rare night attacks on both cattle and humans.",
	RACENEREIDDESCRIPT = "Nereid are considered to be another subspecies of the humanoid races, yet they likely split from another race in the distant past. They adapted to an aquatic lifestyle having a fish tail. Nereids are often seen by sailors and fishermen, but they tend to be hesitant in making contact with humans, likely viewing them as a threat.",
	RACEBEASTKINDESCRIPT = "Beastkin is a term referring to multiple humanoid-animal races usually of mammalian origins. They tend to be covered in fur and have a slightly more bestial body structure. However their height and behavior is that of a human. Somehow they are able to breed with humans and elves resulting in halfkin hybrids. ",
	RACEHALFKINDESCRIPT = "Halfkin are Beastkin's hybrids which keep some of their parent's animalistic features but appear much more human, lacking fur and having a more human body. Halfkins are often rejected by their Beastkin parent's race, but often manage to fit into the society of the other one. Despite that, they still tend to inherit some of their Beastkin race's talents, usually being rather different from normal members of the society they are accepted into. ",
	RACEBEASTKINCATDESCRIPT = "Cat folk are an unusually social breed of Beastkin having no known settlements of their own and living quite openly in populous towns and cities. They have a great deal of popularity among certain crowds for their lush appearance and lascivious nature.",
	RACEBEASTKINWOLFDESCRIPT = "Unlike other Beastkin Wolves are not viewed as simple novelties but are treated as the powerful, agile pack hunters they are. Though they rarely show hostility towards outsiders unless threatened, great caution should be taken when dealing with them.",
	RACEBEASTKINFOXDESCRIPT = "Fox folk are a rare and relatively mysterious breed of Beastkin. They display high intelligence, a tendency towards lifelong monogamy, and congregate in small, close-knit communities.",
	RACEBEASTKINBUNNYDESCRIPT = "Bunnies are one of the least self-sufficient, but nonetheless common beast races. They are not aggressive and can be quite timid. They are quite well liked due to their comforting appearance and their natural lewdness which make them a popular choice for slave pets.",
	RACEBEASTKINTANUKIDESCRIPT = "The Tanuki are a rare beast race possessing raccoon features. It's hard to pinpoint any specific mental differences between them and the majority of the humanoid races. Some say that their behavior and attitudes are much like that of the average human.",
	RACEHALFKINCATDESCRIPT = "Cat folk are an unusually social breed of Beastkin having no known settlements of their own and living quite openly in populous towns and cities. They have a great deal of popularity among certain crowds for their lush appearance and lascivious nature.",
	RACEHALFKINWOLFDESCRIPT = "Unlike other Beastkin Wolves are not viewed as simple novelties but are treated as the powerful, agile pack hunters they are. Though they rarely show hostility towards outsiders unless threatened, great caution should be taken when dealing with them.",
	RACEHALFKINFOXDESCRIPT = "Fox folk are a rare and relatively mysterious breed of Beastkin. They display high intelligence, a tendency towards lifelong monogamy, and congregate in small, close-knit communities.",
	RACEHALFKINBUNNYDESCRIPT = "Bunnies are one of the least self-sufficient, but nonetheless common beast races. They are not aggressive and can be quite timid. They are quite well liked due to their comforting appearance and their natural lewdness which make them a popular choice for slave pets.",
	RACEHALFKINTANUKIDESCRIPT = "The Tanuki are a rare beast race possessing raccoon features. It's hard to pinpoint any specific mental differences between them and the majority of the humanoid races. Some say that their behavior and attitudes are much like that of the average human.",

	SKILLPRAISE = "Praise",
	SKILLPRAISEDESCRIPT = "Category: {color=green|Gracious}\nA basic tool for inspiring your workers. Improved by Charm Factor. \nBasic Effects: \nLoyalty +5, Maxes Obedience.",
	SKILLWARN = "Warn",
	SKILLWARNDESCRIPT = "Category: {color=red|Mean}\nA basic tool to instigate fear.\nBasic Effects: \nLoyalty +5, Maxes Obedience.",
	SKILLPUNISH = "Punish",
	SKILLPUNISHDESCRIPT = "Category: {color=red|Mean}\nPhysically punishes target.\nBasic Effects: \nLoyalty +10, Maxes Obedience.",
	SKILLREWARD = "Reward", #obsolete?
	SKILLREWARDDESCRIPT = "Category: {color=green|Gracious}\nBuying their respect might seem like an easy solution... as long as you have enough coin. Increases obedience greatly.",
	SKILLREWARDSEX = "Reward with sex",
	SKILLREWARDSEXDESCRIPT = "Category: {color=pink|Lewd}\nRelieves a character's lust to improve their behavior. Target must have at least 25 Lust. Improved by Charm and Sex Factors.\nBasic Effects: \nLoyalty +5, Maxes Obedience.",
	SKILLSEDUCE = "Seduce",
	SKILLSEDUCEDESCRIPT = "Category: {color=pink|Lewd}\nImproves Obedience and reduces Obedience drain. Improved by Charm Factor. \nBasic Effects: \nObedience Drain -7 for 5 days, Loyalty: +10, Maxes Obedience.",
	SKILLGREATSEDUCE = "Great Seduce",
	SKILLGREATSEDUCEDESCRIPT = "Category: {color=pink|Lewd}\nImproves Obedience, reduces Obedience drain, prevents escape attempts and increases Lust growth by 50%. Improved by Charm Factor. \nBasic Effects:\n Obedience Drain -9 for 5 days, Loyalty +15, Maxes Obedience.",
	SKILLDRAIN = "Drain",
	SKILLDRAINDESCRIPT = "Restores some fatigue, mana and energy by draining it from target.",
	SKILLDRAIN_MANA = "Drain Mana",
	SKILLDRAIN_MANADESCRIPT = "Steal up to 35% of mana from target.",
	SKILLCONSUME_SOUL = "Consume Soul",
	SKILLCONSUME_SOULDESCRIPT = "Kills target and receives their experience.",
	SKILLSERVE = "Serve",
	SKILLSERVEDESCRIPT = "Category: {color=green|Gracious}\nProvide a care service for another person. Improves Obedience and increases Loyalty gain. Requires 20 lust. \nBasic Effects: \nLoyalty Gain: +1 for 5 days, Maxes Obedience.",
	SKILLDISCIPLINE = "Discipline",
	SKILLDISCIPLINEDESCRIPT = "Boosts target's manual labor performance. \nBasic Effects: \nLabor and craft efficiencies are increased by 50% for 5 days.",
	SKILLSEDATE = "Sedate",
	SKILLSEDATEDESCRIPT = "Category: {color=green|Gracious}\nPuts target's mind at ease and makes them more cooperative. Improved by Charm Factor.\nBasic Effects: \nObedience Drain: -10 for 2 days, Loyalty: +4, Maxes Obedience.",
	SKILLFEAR = "Fear",
	SKILLFEARDESCRIPT = "Category: {color=red|Mean}\nStrikes fear into target's mind. \nBasic Effects: \nObedience Drain: -6 for 4 days, Loyalty Gain: -1 for 4 days, Maxes Obedience.",
	SKILLINNERVATE = "Innervate",
	SKILLINNERVATEDESCRIPT = "Restores target's energy. Effect grows with Wits.",
	SKILLSHACKLES = "Shackle",
	SKILLSHACKLESDESCRIPT = "Creates magic shackles around target. As long as they persist it will be impossible to escape. Shackles can be dispelled with time if target's magic resistance is high.\nBasic Effects: \nObedience Drain: -6, Loyalty Gain: -3, Maxes Obedience.",
	SKILLGREATSHACKLES = "Great Shackle",
	SKILLGREATSHACKLESDESCRIPT = "Creates a stronger version of magical shackles which are far more difficult to break. \nBasic Effects: \nObedience Drain: -10, Loyalty Gain: -3, Maxes Obedience.",
	SKILLMINDCONTROL = "Mind Control",
	SKILLMINDCONTROLDESCRIPT = "Overwhelms target's mind forcing nearly complete submission.Improved by Charm Factor. \nBasic Effects: \nLoyalty: +50, Maxes Obedience.",
	SKILLSTOPMINDCONTROL = "Remove Mind Control",
	SKILLSTOPMINDCONTROLDESCRIPT = "Removes Mind Control from the target, giving them back their free will.",
	SKILLABUSE = "Abuse",
	SKILLABUSEDESCRIPT = "Category: {color=red|Mean}\nTake your anger out on someone else. Improves Caster's and Target's obedience. \nBasic Effects: \nObedience: +50 (self), Maxes target's Obedience, Loyalty: +5 (both).",
	SKILLMASTER_LUST_SKILL = "Lust Relief",
	SKILLMASTER_LUST_SKILLDESCRIPT = "Uses up target's Lust to provide them with specific benefits. Target must have at least 50 Lust.",
	SKILLHARDWORK = "Hard Work",
	SKILLHARDWORKDESCRIPT = "Increases productivity by 50% for 3 days for all characters on the current location.",
	SKILLPUBLICHUMILIATION = "Public Humiliation",
	SKILLPUBLICHUMILIATIONDESCRIPT = "Category: {color=red|Mean}\nSet up a public humiliation for selected target. Greatly improves target's behavior and slightly affects audience.\nBasic Effects: \nLoyalty: +10 (half for viewers), Maxes Obedience.",
	SKILLPUBLICSEXHUMILIATION = "Public Sex Humiliation",
	SKILLPUBLICSEXHUMILIATIONDESCRIPT = "Category: {color=pink|Lewd}\nSet up a public sex humiliation for the selected target, improving behavior of the target and viewers and providing a bit of Lust for all observants. \nBasic Effects: \nLoyalty: +10 (half for viewers), Lust: +15, Maxes Obedience.",
	SKILLPUBLICEXECUTION = "Public Execution",
	SKILLPUBLICEXECUTIONDESCRIPT = "Category: {color=red|Mean}\nExecutes selected character. Greatly improves obedience of everyone involved. \nBasic Effects: \nLoyalty: +25, Maxes Obedience.",
	SKILLALLURE = "Allure",
	SKILLALLUREDESCRIPT = "Category: {color=green|Gracious}\nEntices the target, increasing their Obedience and reducing Obedience drain. Improved by Charm Factor. \nBasic Effects: \nObedience Drain -5 and Loyalty Gain + 1 for 5 days, Maxes Obedience.",
	SKILLSUPREMACY = "Supremacy",
	SKILLSUPREMACYDESCRIPT = "Category: {color=green|Gracious}\nOverwhelms target with awe and respect for caster. Greatly increases Loyalty. Improved by Charm Factor. \nBasic Effects: \nLoyalty: +25, Maxes Obedience.",
	SKILLINSPIRE = "Inspire",
	SKILLINSPIREDESCRIPT = "Buffs whole team, increasing damage, DEF and MDEF by 20% for 1 combat.",
	SKILLHIDE = "Hide",
	SKILLHIDEDESCRIPT = "Makes user untargetable. Has no effect when is only possible target. Must have no Heavy or Medium Armor equipped.",
	SKILLBARRIER = "Barrier",
	SKILLBARRIERDESCRIPT = "Provides a magical shield that absorbs 100 damage. Shield lasts for 3 turns.",
	SKILLASSASSINATE = "Assassinate",
	SKILLASSASSINATEDESCRIPT = "Deals 400% of ATK as Dark damage. Must be hidden to execute.",
	SKILLPROTECT = "Protect",
	SKILLPROTECTDESCRIPT = "Takes damage from ally for 2 turns.",
	SKILLSHAREDTOY = "Shared Toy",
	SKILLSHAREDTOYDESCRIPT = "Category: {color=pink|Lewd}\nBecome everyone's pleasure and relief for a time. Improves everyone's obedience. Improved by Charm Factor. \nBasic Effects: \nLoyalty +10, Maxes Obedience",
	SKILLPERFORMANCE = "Performance",
	SKILLPERFORMANCEDESCRIPT = "Category: {color=green|Gracious}\nProvide a small rest and entertainment for your other servants. Improved by Charm Factor. \nBasic Effects: \nLoyalty +5, Maxes Obedience.",

	DIALOGUEMASTER_LUST_SKILLTEXT = "Before approaching [targetname] you should decide what's [targethis] accumulated Lust is going to be used for.\n\n1. Convert it into Experience\n2. Restore Health and Mana, Improve Authority and Obedience\n3. Improve Productivity by 20% for 3 days for 50 Lust\n4. Increase ATK and MATK by 15% for 2 days for 50 Lust.",

	DIALOGUEMASTER_LUST_EXPREPORT = "You use [targetname]'s lust to provide [targethim] with experience.",
	DIALOGUEMASTER_LUST_BUFFREPORT = "You use [targetname]'s lust to provide [targethim] with a productivity boost.",
	DIALOGUEMASTER_LUST_HPREPORT = "You use [targetname]'s lust to restore [targethis] Health and Mana.",
	DIALOGUEMASTER_LUST_OBEDREPORT = "You use [targetname]'s lust to improve [targethis] loyalty.",
	DIALOGUEMASTER_LUST_COMBAT_BUFFREPORT = "You use [targetname]'s lust to enhance [targethis] combat proficiency.",

	DIALOGUESUCCUBUS_LUST_XP_CONVERTREPORT = "[name] consumes [targetname]'s lust and receives experience from it. ",
	DIALOGUESUCCUBUS_LUST_HP_CONVERTREPORT = "[name] consumes [targetname]'s lust and recovers [his] health and mana from it. ",
	DIALOGUESUCCUBUS_LUST_OBED_CONVERTREPORT = "[name] consumes [targetname]'s lust and becomes quite content from it. ",
	DIALOGUESUCCUBUS_LUST_COMBAT_BUFFREPORT = "[name] consumes [targetname]'s lust and enhances [his] combat proficiency. ",

	SKILLSUCCUBUS_LUST_SKILL = "Lust Drain",
	SKILLSUCCUBUS_LUST_SKILLDESCRIPT = "Utilizes target's Lust for self-benefit. Target must have at least 50 lust.",
	DIALOGUESUCCUBUS_LUST_SKILLTEXT = "Before approaching [targetname] you should decide what's [targethis] accumulated Lust is going to be used for.\n\n1. Convert it into Experience\n2. Restore Health and Mana\n3. Gain Obedience and Loyalty\n4. Increase Atk and Matk by 25% for 2 days for 50 lust.",

	DIALOGUEPUBLICHUMILIATIONREPORT = "[name] brings [targetname] to the large room where everyone has been gathered. In the following display [targethe]'s being punished as the audience hears [targethis] cries. By the end of it not only has [targetname] learned [targethis] lesson, but the observers have seemed to become more docile. ",
	DIALOGUEPUBLICSEXHUMILIATIONREPORT = "[name] brings [targetname] to the large room where everyone has been gathered. In the following show [targethe]'s sexual punishment is clearly exposed to the audience. By the end of it not only do the observers get more docile, but they also have shown some hints of excitement. ",

	DIALOGUEPUBLICEXECUTIONTEXT = "As [targetname] hears about your decision, [he] quickly drops on the floor begging you to spare [targethis] life, promising to do anything and never disappoint you again. ",
	DIALOGUEPUBLICEXECUTIONREPORT = "You used [targetname] as an example to everyone in your mansion by ending [targethis] life in front of their eyes. This seems to be rather effective, albeit unnecessarily cruel for some.",
	DIALOGUEPURCHASEDUNGEONLOCATION = "You purchase a location for a new dungeon and mark it on your map.\n\nNew location at [areaname] unlocked: [locationname] — [locationtypename].",

	DIALOGUESHAREDTOYREPORT = "[name] takes on a duty to please your other servants with [his] body...\n\nBy the end of it, it seems even your meeker servants have been left satisfied.",
	DIALOGUEPERFORMANCEREPORT = "[name] sets a staged dance gathering everyone around to watch and relax. People seem to be quite pleased with [his] performance. ",

	DIALOGUEQUESTACCEPT = "You take a quest note from the board and put it into your pocket. Once you can meet its conditions, you can complete it from your Mansion. ",

	DIALOGUEPRAISEREPORT = "[name] has praised [targetname] for [targethis] efforts.\n\n{color=aqua|[targetname]} — {random_chat=0|master_praise}",
	DIALOGUEWARNREPORT = "[name] has given a serious warning to [targetname] making [targethim] more aware of [targethis] behavior.",
	DIALOGUESERVEREPORT = "[name] has approached [targetname] and provided [targethim] with [his] sincerest affection.",
	DIALOGUESEDUCEREPORT = "[name] has approached [targetname] and after a couple moments left [targethim] wondering. Despite visual calmness, [targetname] has clearly become enamoured by [him].",
	DIALOGUEGREATSEDUCEREPORT = "[name] has approached [targetname] and after a couple moments left [targethim] wondering. [targetHis] mind has been overtaken by strong desire, making [him] quite docile.",
	DIALOGUEALLUREREPORT = "[name] has given [targetname] a small private encouragement.",
	DIALOGUEABUSEREPORT = "[name] has pushed [targetname] into a corner and took out some of [his] anger on [targethim].\n\n{color=aqua|[targetname]} — {random_chat=0|abuse}",
	DIALOGUEREWARDREPORT = "[name] has provided [targetname] with a small amount of gold for [targethis] good behavior.",
	DIALOGUEREWARDSEXREPORT = "[name] has taken care of [targetname]'s needs as a reward for [targethis] good deeds.",
	DIALOGUEPUNISHREPORT = "[name] has taken [targetname] into a private torture room and gave [targethim] a good lesson of discipline [targethe] won't forget for a while. \n\n{color=aqua|[targetname]} — {random_chat=0|master_punish}",
	DIALOGUESEDATEREPORT = "[name] puts a Sedation spell on [targetname], calming [targethis] mind and making [targethe] more docile.",
	DIALOGUEFEARREPORT = "[name] puts a Fear spell on [targetname] as a serious warning. After coming to his senses, [targetname] seems to be much more respectful towards others and especially you.",
	DIALOGUEINNERVATEREPORT = "[name] uses an Innervate spell on [targetname] restoring some of [targethis] energy.",
	DIALOGUESHACKLESREPORT = "[name] conjures magical shackles on [targetname] which will prevent [targethim] from escaping. Timid Factor: +2",
	DIALOGUEGREATSHACKLESREPORT = "[name] conjures strong magical shackles on [targetname] which will prevent [targethim] from escaping.",
	DIALOGUEMINDCONTROLREPORT = "[name] dominates [targetname]'s mind with a powerful magic, turning [targethim] into an obedient puppet. ",
	DIALOGUESTOPMINDCONTROLREPORT = "[name] removes the spell from [targetname] allowing [targethim]independent thought again.",
	DIALOGUEHARDWORKREPORT = "[name] inspires [targetname] to work harder.",
	DIALOGUEDISCIPLINEREPORT = "[name] disciplines [targetname] to work harder.",
	DIALOGUEAUTHORITYREPORT = "[name] uses [his] authority, making [targetname] work harder.",
	DIALOGUECONSUME_SOULREPORT = "[name] annihilates [targetname] and consumes [targethis] soul, learning from [targethis] experience. ",
	DIALOGUEMAKE_UNDEADREPORT = "[name] prepares unknowing [targetname] for the ritual. After being drugged unconcious, the magic spell forces life to leave [targetname]'s body stopping [targethis] heartbeat but trapping [targethis] soul inside. As [targethe] returns to concious and realizes [targethis] new state, the shock of realization that [targethe] never can go back leaves [targethim] speechless.",
	DIALOGUEALCOHOLREPORT = "[name] uses a bottle of liquor for relaxation.",
	DIALOGUEAPHRODISIACREPORT = "[name] consumes an aphrodisiac, feeling a potent surge of lust.",
	DIALOGUETAMEDRUGREPORT = "After consuming the drug, [name] seems to have become a lot more docile. ",
	DIALOGUERAGEDRUGREPORT = "After consuming the drug, [name] seems to become more brutish.",
	DIALOGUESEXDRGUREPORT = "After consuming the drug, [name]'s mind becomes fixated on lewd things...",
	DIALOGUEEXP_SCROLLREPORT = "[name] reads the scroll. New knowledge fill [his] mind...",

	DIALOGUEENSLAVETEXT = "You find an official, who is ready to help with your task. After payment you receive a paper of ownership over [name], who reacts quite disturbingly to it.\n\n{color=aqua|[name]} — {random_chat=0|enslave}",
	DIALOGUEHIRETEXT = "After signing the papers and parting with your money, [name] comes bowing before you.\n\n{color=aqua|[name]} — {random_chat=0|hire}",#\n\n— Pleased to meet you, [master], I am in your care.

	SKILLPET_LUST_SKILL = "Lust Serve",
	SKILLPET_LUST_SKILLDESCRIPT = "Utilizes personal Lust to provide target with a specific bonus. Requires at least 50 lust.",
	SKILLMAKE_UNDEAD = "Turn Undead",
	SKILLMAKE_UNDEADDESCRIPT = "Makes selected charcter into Undead. Undead's charm is reduced by 100, food consumption is set to 0. Undead can't impregnate or get pregnant. Undead have increased Dark resist and reduced Light resist. \n\nCan't be used on Unique Characters.",
	
	DIALOGUEPET_LUST_SKILLTEXT = "Before approaching [targetname] you should decide what [name]'s accumulated Lust is going to be used for.\n\n1. Restore full Obedience and gain some Loyalty\n2. Convert it into Experience\n3. Restore Health and Mana",

	TRAITMASTERDESCRIPT = "Social skills build targets Loyalty 30% faster. \nIsn't affected by Obedience or Loyalty. Will not resist work or attempt escapes.",
	TRAITWORKERDESCRIPT = "Woodcutting and Mining are 50% more efficient.",
	TRAITFOREMANDESCRIPT = "Woodcutting and Mining are 33% more efficient",
	TRAITHUNTERDESCRIPT = "Fishing and Hunting are 50% more efficient.",
	TRAITSMITHDESCRIPT = "Craft Smith and Tailor items 100% faster.",
	TRAITENGINEERDESCRIPT = "Upgrading is 100% faster.",
	TRAITCHEFDESCRIPT = "Cooking is 100% faster.",
	TRAITATTENDANTDESCRIPT = "Once per combat turn [name] can use an item without using a turn.",
	TRAITALCHEMISTDESCRIPT = "Crafts alchemical products 100% faster.\nHealing items are 25% more effective in combat.",
	TRAITFARMERDESCRIPT = "Farming is 50% more efficient. ",
	TRAITBREEDERDESCRIPT = "Allows breeding with any race.\nPregnancy Debuffs are weaker\nOffspring will inherit only this parent's stats.",
	TRAITHARLOTDESCRIPT = "Prostitution is 50% more efficient.",
	TRAITSUCCUBUSDESCRIPT = "Sex activities provide 50% more experience.",
	TRAITPETDESCRIPT = "Prostitution is 25% more efficient.",
	TRAITSEXTOYDESCRIPT = "Prostitution is 50% more efficient.",
	TRAITWITCRITDESCRIPT = "Increases critical strike chance by 3% per Wits Factor.",
	TRAITDIRECTORDESCRIPT = "Social skills are 50% more efficient. ",
	TRAITVALKYRIE_SPEARDESCRIPT = "+10 Speed while equipped with Spear.",
	TRAITAUTOHIDE = "Conceal.",
	TRAITAUTOHIDEDESCRIPT = "Starts combat in Hide if no Heavy or Medium Armor is equipped.",
	
	TRAITBASIC_COMBAT = "Basic Combat",
	TRAITADVANCED_COMBAT = "Advanced Combat",
	TRAITBASIC_SPELLS = "Basic Spellcasting",
	TRAITADVANCED_SPELLS = "Advanced Spellcasting",
	TRAITBASIC_COMBATDESCRIPT = "Allows to learn basic combat skills and weapons",
	TRAITADVANCED_COMBATDESCRIPT = "Allows to learn advanced combat skills and weapons",
	TRAITBASIC_SPELLSDESCRIPT = "Allows to learn basic combat spells and staves",
	TRAITADVANCED_SPELLSDESCRIPT = "Allows to learn advanced combat spells and staves",
	
	TRAITHUNTER_DAMAGEDESCRIPT = "Damage vs Beasts: +15%",
	TRAITBISHOPDESCRIPT = "Light Magic damage: +40%",
	TRAITDRUIDDESCRIPT = "Earth Spell damage: +20%",
	TRAITBERSERKERDESCRIPT = "Fire and Earth Physical damage: +20%",
	TRAITSNIPERDESCRIPT = "Single Target Physical damage: +25%",
	
	TRAITHEALER1 = "Healer:Novice",
	TRAITHEALER1DESCRIPT = "Healing spells are 25% more effective.",
	TRAITHEALER2 = "Healer:Expert",
	TRAITHEALER2DESCRIPT = "Healing spells are 25% more effective.",
	
	
	
	TRAITWEAPON_MASTERY = "Weapon Mastery",
	TRAITMEDIUM_ARMOR = "Medium Armor",
	TRAITHEAVY_ARMOR = "Heavy Armor",
	TRAITRANGED_WEAPON_MASTERY = "Ranged Weapon Mastery",
	TRAITMAGIC_TOOLS = "Magic Tools",
	TRAITMEDIUM_ARMORDESCRIPT = "Allows the usage of Medium Armor.",
	TRAITHEAVY_ARMORDESCRIPT = "Allows the usage of Heavy Armor.",
	TRAITLOCKPICKINGDESCRIPT = "Greatly increases the chance to pick locks.",
	TRAITTRAP_DETECTIONDESCRIPT = "Increases a chance to disarm traps.",
	TRAITTRAP_ANALYZEDESCRIPT = "Gives a chance to discover trap's nature and slightly increase a chance to disarm traps.",
	TRAITWEAPON_MASTERYDESCRIPT = "Allows the use of Melee Weapons",
	TRAITRANGED_WEAPON_MASTERYDESCRIPT = "Allows the use of Ranged Weapons.",
	TRAITMAGIC_TOOLSDESCRIPT = "Allows the use of magic tools such as staves.",
	
	TRAITUNDEADDESCRIPT = "[name] is no longer a living being. Food consumption is set to 0; Charm is reduced by 100; Light Resist -50; Dark Resist +50; Dark Damage +20%%; Can't impregnate or get pregnant.",
	TRAITSPOUSE = "Spouse",
	TRAITSPOUSEDESCRIPT = "Future children between Master and Spouse recieve Heir status instead of Slave or Peon. ",
	
	TRAITPRODIGY = "Prodigy",
	TRAITPASSIVE = "Passive",
	TRAITNIMBLE = "Nimble",
	TRAITQUICK = "Quick",
	TRAITHANDY = "Handy",
	TRAITDEADLY = "Deadly",
	TRAITLIVELY = "Lively",
	TRAITMVORTEX = "Magic Vortex",
	TRAITGIFTED = "Gifted",
	TRAITBELLIGERENT = "Belligerent",
	TRAITHIDDENPOWERS = "Hidden Powers",
	TRAITHEALTHY = "Healthy",
	TRAITDIM = "Dim",
	TRAITREBEL = "Rebellious",
	TRAITSLOW = "Slow",
	TRAITCLUMSY = "Clumsy",
	TRAITINEPT = "Inept",
	TRAITSICKY = "Sickly",
	TRAITMAGICMUTT = "Magic Mutt",
	TRAITBLUNDERING = "Blundering",
	TRAITCRUDE = "Crude",
	TRAITCHASTE = "Chaste",
	TRAITPACIFIST = "Pacifist",
	TRAITWHIMP = "Wimp",
	TRAITM_INEPT = "Magically Inept",
	TRAITSELFISH = "Selfish",
	TRAITCOWARD = "Coward",
	TRAITFRIGID = "Frigid",
	TRAITBAWDY = "Bawdy",
	TRAITFORAGER = "Forager",
	TRAITTALENTED = "Talented",
	TRAITMENIAL = "Menial",
	TRAITSTURDY = "Sturdy",
	TRAITFRAIL = "Frail",
	
	
	TRAITPRODIGYDESCRIPT = "Gain 25% more EXP points.",
	TRAITPASSIVEDESCRIPT = "Obedience Drain -5.",
	TRAITNIMBLEDESCRIPT = "Speed is increased by 10.",
	TRAITQUICKDESCRIPT = "Collection modifier +20%.",
	TRAITHANDYDESCRIPT = "Craft modifier +20%.",
	TRAITDEADLYDESCRIPT = "Crit Chance +9%.",
	TRAITLIVELYDESCRIPT = "+3 Health Regen",
	TRAITMVORTEXDESCRIPT = "+1 Mana Regen",
	TRAITGIFTEDDESCRIPT = "Maximum Mana +100%.",
	TRAITBELLIGERENTDESCRIPT = "ATK +15%.",
	TRAITHIDDENPOWERSDESCRIPT = "MATK +10%.",
	TRAITHEALTHYDESCRIPT = "+10 Max Health.",
	TRAITDIMDESCRIPT = "Gain 25% less EXP points.",
	TRAITREBELDESCRIPT = "Obedience Drain +5.",
	TRAITSLOWDESCRIPT = "Speed is reduced by 10.",
	TRAITCLUMSYDESCRIPT = "Collection modifier -80%.",
	TRAITINEPTDESCRIPT = "Craft modifier -80%.",
	TRAITSICKYDESCRIPT = "-3 Health Regen",
	TRAITMAGICMUTTDESCRIPT = "Maximum mana -50%.",
	TRAITBLUNDERINGDESCRIPT = "Collection, Fishing, Farming tasks -80% efficiency.",
	TRAITCRUDEDESCRIPT = "Tailor, Smith, Alchemy tasks -80% efficiency.",
	TRAITCHASTEDESCRIPT = "Prositution Task -80% efficiency.",
	TRAITPACIFISTDESCRIPT = "ATK -50%.",
	TRAITWHIMPDESCRIPT = "HP MAX -40%.",
	TRAITM_INEPTDESCRIPT = "MATK -50%.",
	TRAITSELFISHDESCRIPT = "Can't use combat supporting Abilities.",
	TRAITCOWARDDESCRIPT = "Hit Rate -50.",
	TRAITFRIGIDDESCRIPT = "Can't acquire new sex traits. Maximum lust is reduced by 50%.",
	TRAITBAWDYDESCRIPT = "Service Mod +25%.",
	TRAITFORAGERDESCRIPT = "30% Chance to not consume any food on day end.",
	TRAITTALENTEDDESCRIPT = "Task Crit chance +15%.",
	TRAITMENIALDESCRIPT = "Task Crit chance is set to 0.",
	TRAITSTURDYDESCRIPT = "+10 DEF.",
	TRAITFRAILDESCRIPT = "-10 DEF.",
	TRAITLOYALTY_BASIC_SERVITUDE = "Basic Servitude",
	TRAITLOYALTY_BASIC_SERVITUDEDESCRIPT = "{color=green|Allows to assign to occupations}\n\nComplete control starts with the smallest of steps. Mannerisms, protocol, and etiquette must be established to reap their rewards. ",
	TRAITLOYALTY_DATING = "Dating",
	TRAITLOYALTY_DATINGDESCRIPT = "{color=green|Unlocks Dating}\n\nA timeless tradition repurposed for your needs. A kind word, a subtle innuendo, and social comforts go a long way towards establishing a useful bond.",
	TRAITLOYALTY_COMBATANT = "Combatant",
	TRAITLOYALTY_COMBATANTDESCRIPT = "{color=green|Unlocks Combat Assignment}\n\nSlaves in chains have few uses. Those who've earned their masters trust and defend them are far more valuable.",
	TRAITLOYALTY_DRESS_LEWD = "Lewd Clothes",
	TRAITLOYALTY_DRESS_LEWDDESCRIPT = "{color=green|Unlocks equipment of more extravagant gear}\n\nAmple skin, soft cloth, and eager display of their assets all for their masters' benefit. A fine slave can be a work of art physically, this one knows that.\n\nRequires: Basic Servitude" ,
	TRAITLOYALTY_DRESS_WORK = "Work Clothes",
	TRAITLOYALTY_DRESS_WORKDESCRIPT = "{color=green|Unlocks equipment of work oriented gear}\n\nGloves, boots, protective aprons, and goggles are just a few of the things a slave might wear during work. A slave is an investment afterall.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_BODMOD = "Body Modifications",
	TRAITLOYALTY_BODMODDESCRIPT = "{color=green|Unlocks body tattoos and modifications}\n\nSlave can give many things to a master, some more than others. This one in particular will even change their very form to that desire.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_ADV_SERVITUDE = "Advanced Servitude",
	TRAITLOYALTY_ADV_SERVITUDEDESCRIPT = "\nBefore service was demanded, now service is often there before you've realized it's needed. This slave knows a masters needs and fulfills them aptly.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_CALLMASTER = "Master Acknowledgment",
	TRAITLOYALTY_CALLMASTERDESCRIPT = "{color=green|Allows to set Master pronouns}\n\nA title might seem like little to those who are unaware, but those that are 'Master' is the highest honor. This slave awknowleges the role you both will play.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_SWEAR = "Swear Loyalty",
	TRAITLOYALTY_SWEARDESCRIPT = "\nCoercion is no longer needed. Through deed or fear this slave has pledged their loyalty to you alone.\n\nRequires: Advanced Servitude, Master Acknowledgement",
	TRAITLOYALTY_SOULBIND = "Soulbind",
	TRAITLOYALTY_SOULBINDDESCRIPT = "{color=green|Obedience Drain: 0\nLoyalty Gain: 0}\n\nThe mind is such a fickle thing, a proper mage can exploit this as has been shown in this now exceptionally obedient specimen.\n\nRequires: Dominator Class on Master",
	TRAITLOYALTY_EXHIBITIONISM = "Exhibitionism",
	TRAITLOYALTY_EXHIBITIONISMDESCRIPT = "\nObserve and enjoy. This slave is eager to show others their prowress at their masters command.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_PROSTITUTION = "Prostitution",
	TRAITLOYALTY_PROSTITUTIONDESCRIPT = "{color=green|Unlocks Prostitution Occupation}\n\nCarnel pleasures for coin. Pleasure or not matters little when the alternative is an empty stomach.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_SEX_BASIC = "Sex:Basics",
	TRAITLOYALTY_SEX_BASICDESCRIPT = "{color=green|Unlocks sex interactions and basic sex actions}\n\nIt didn't take long for the first slave owners to realize there was much more enjoyable uses for a slave other than labor.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_SEX_ORAL = "Sex:Oral",
	TRAITLOYALTY_SEX_ORALDESCRIPT = "{color=green|Unlocks oral sex actions during sex interactions}\n\nA long day after managing a manor can be made all the better with a few minutes of one sided pleasure. After all a happy master tends to be a kind master.\n\nRequires: Sex:Basics",
	TRAITLOYALTY_SEX_ANAL = "Sex:Anal",
	TRAITLOYALTY_SEX_ANALDESCRIPT = "{color=green|Unlocks anal sex actions during sex interactions}\n\nRequires: Sex:Basics",
	TRAITLOYALTY_SEX_ADV = "Sex:Advanced",
	TRAITLOYALTY_SEX_ADVDESCRIPT = "{color=green|Unlocks advanced sex actions during sex interactions}\n\nAfter serving their master repeatedly in the bedroom this slave has learned, and their owner can only benefit.\n\nRequires: Sex:Basics",
	TRAITLOYALTY_SEX_PERV = "Sex:Perverse",
	TRAITLOYALTY_SEX_PERVDESCRIPT = "{color=green|Unlocks perverted sex actions during sex interactions}\n\nWhen ones duties revolve around use of their bodies, standard use can seem...vanilla. Often times slaves are more than willing to spice things up a bit.\n\nRequires: Sex:Advanced",
	TRAITLOYALTY_SEX_GROUP = "Sex:Group",
	TRAITLOYALTY_SEX_GROUPDESCRIPT = "{color=green|Unlocks group sex actions and multiple partners during sex interactions}\n\nIf one source of pleasure can drive this slave to pleasure, what might two? For that matter what might three or more?\n\nRequires: Sex:Basics",
	TRAITLOYALTY_PREGNANCY = "Pregnancy",
	TRAITLOYALTY_PREGNANCYDESCRIPT = "{color=green|Unlocks an option to keep character's Baby on birth.}\n\nRequires: Sex:Basics",
	TRAITLOYALTY_INTERBREED = "Pregnancy:Interbreed",
	TRAITLOYALTY_INTERBREEDDESCRIPT = "{color=green|Allows character to impregnate or be impregnated by usually incompatible race partner}\n\nRequires: Sex:Advanced",

	
	
	PROFMASTER = "Master",
	PROFMASTERALT = "Mistress",
	PROFMASTERDESCRIPT = "The sole ruler of a domain. [His] power strikes fear and respect not only in newcomers, but even in seasoned servants.",
	PROFRULER = "Ruler",
	PROFRULERDESCRIPT = "A step above being just a [master]. A ruler is the ultimate person, not only having complete authority, but also inspiring others to greater deeds.",
	PROFDIRECTOR = "Director",
	PROFDIRECTORDESCRIPT = "Director can issue a higher tier of discipline on servants in the name of the [master]. ",
	PROFSADIST = "Sadist",
	PROFSADISTDESCRIPT = "Sadists take pleasure in abusing others and are useful for little else. Still, they can be a boon when you aim to rule with fear. ",
	PROFWATCHDOG = "Watchdog",
	PROFWATCHDOGDESCRIPT = "The servants who've proven their loyalty to their master are allowed to act in his name to ensure obedience and fear in others.",
	PROFHEADGIRL = "Headgirl",
	PROFHEADGIRLALT = "Butler",
	PROFHEADGIRLDESCRIPT = "A servant with higher authority that is allowed to direct multiple lower servants at once.",
	PROFTRAINER = "Trainer",
	PROFTRAINERDESCRIPT = "Trainers can dramatically change the attitude of a very rebellious slave. ",
	PROFWORKER = "Worker",
	PROFWORKERDESCRIPT = "Workers are great manual laborers for your everyday needs. They gather resources much faster than others.",
	PROFFOREMAN = "Foreman",
	PROFFOREMANDESCRIPT = "A seasoned worker is not only more proficient, but also can boost productivity of other workers.",
	PROFHUNTER = "Hunter",
	PROFHUNTERDESCRIPT = "Hunters specialize in tracking and killing game.",
	PROFSMITH = "Blacksmith",
	PROFSMITHDESCRIPT = "Smiths are master craftsmen, able to work with all sorts of materials.",
	PROFCHEF = "Chef",
	PROFCHEFDESCRIPT = "A skilled cook is always a valuable addition to any household.",
	PROFATTENDANT = "Attendant",
	PROFATTENDANTDESCRIPT = "Attendants help out other characters while in the battlefield and learn to serve efficiently.",
	PROFALCHEMIST = "Alchemist",
	PROFALCHEMISTDESCRIPT = "Alchemists specialize in brewing processes which are invaluable for a steady supply of potions.",
	PROFFARMER = "Farmer",
	PROFFARMERDESCRIPT = "Farmers are trained to work with crops. ",
	PROFBREEDER = "Breed Sow",
	PROFBREEDERDESCRIPT = "One who finds purpose in bringing a new generation into being. They can accept any partner, but their children will carry on their lineage.",
	PROFHARLOT = "Harlot",
	PROFHARLOTDESCRIPT = "The oldest profession might not seem like much, but so far it's always in demand.",
	PROFGEISHA = "Geisha",
	PROFGEISHADESCRIPT = "Consummate entertainers that entertain patrons through song, dance, and conversation.",
	PROFDANCER = "Dancer",
	PROFDANCERDESCRIPT = "Dancers can entice with their looks and moves. Effective for entertainment. ",
	PROFSUCCUBUS = "Succubus",
	PROFSUCCUBUSALT = "Incubus",
	PROFSUCCUBUSDESCRIPT = "Carnal pleasures turned into an art. They learned not only to please others but use their lust for their own benefits.",
	PROFTRUE_SUCCUBUS = "True Succubus",
	PROFTRUE_SUCCUBUSALT = "True Incubus",
	PROFTRUE_SUCCUBUSDESCRIPT = "Carnal pleasures turned into an art. They learned not only to please others, but use their lust for their own benefits.",
	PROFPET = "Pet",
	PROFPETDESCRIPT = "Apparently, giving up your personal rights is not the worst thing in the world. Besides keeping a low profile, pets can cheer up other residents when they are in need of companionship. ",
	PROFPETBEAST = "Natural Pet",
	PROFPETBEASTDESCRIPT = "Apparently, giving up your personal rights is not the worst thing in the world. Besides keeping a low profile, pets can cheer up other residents when they are in need of companionship. ",
	PROFSEXTOY = "Sex toy",
	PROFSEXTOYDESCRIPT = "The art of being an object of desire for others.",
	PROFFIGHTER = "Fighter",
	PROFFIGHTERDESCRIPT = "Fighters are basic melee soldiers capable of dealing and taking damage in combat.",
	PROFKNIGHT = "Knight",
	PROFKNIGHTDESCRIPT = "A noble fighter ready to serve [his] [master]. [He] performs [his] duties on the frontline of the battlefield with honor. ",
	PROFAPPRENTICE = "Apprentice",
	PROFAPPRENTICEDESCRIPT = "Apprenticeship is a road for many starting mages. Apprentices focus on social spells, which can help greatly with putting others in line. ",
	PROFSCHOLAR = "Scholar",
	PROFSCHOLARDESCRIPT = "Scholars are mages taught to specialize in combat. While their arsenal isn't great, they can be irreplaceable due to their utility. ",
	PROFCASTER = "Caster",
	PROFCASTERDESCRIPT = "Mastering powers of the arcane produces fruit: casters are able to seriously turn the battle in their favor and have a couple additional tricks up their sleeves. ",
	PROFDOMINATOR = "Dominator",
	PROFDOMINATORDESCRIPT = "A Dominator specializes in mind influencing magic to bend others to their will. ",
	PROFBLOODMAGE = "Blood Mage",
	PROFBLOODMAGEDESCRIPT = "Practitioners of arcane arts sometimes go a long way to gain more power. Blood Mages can tap into their own health to restore some of their mana.",

	PROFMAID = "Maid",
	PROFMAIDALT = "Lackey",
	PROFMAIDDESCRIPT = "A trained servant not only knows their place but is more appealing to the eye.",
	PROFDRAGONKNIGHT = "Dragon Knight",
	PROFDRAGONKNIGHTDESCRIPT = "The dragon blood flowing in their veins allow them to become fearsome warriors resistant to fire.",
	PROFBERSERKER = "Berserker",
	PROFBERSERKERDESCRIPT = "The fiercest orcs can become Berserkers and boost their combat prowess.",
	PROFDRUID = "Druid",
	PROFDRUIDDESCRIPT = "Druids specialize in nature's magic, allowing them to heal and neutralize enemies.",
	PROFVALKYRIE = "Valkyrie",
	PROFVALKYRIEDESCRIPT = "Female winged warriors excelling in swift and deadly combat.",
	PROFSOULEATER = "Soul Eater",
	PROFSOULEATERDESCRIPT = "Sometimes magic proficiency can get you so far you are not only able to control others, but consume their souls to obtain their knowledge.",
	PROFNECROMANCER = "Necromancer",
	PROFNECROMANCERDESCRIPT = "A vile sorcerer with power over the dead. ",
	PROFARCHER = "Archer",
	PROFARCHERDESCRIPT = "Archers specialize in using bows for ranged combat.",
	PROFSNIPER = "Sniper",
	PROFSNIPERDESCRIPT = "Snipers are deadly ranged fighters capable of quickly taking down unarmored targets.",
	PROFROGUE = "Rogue",
	PROFROGUEDESCRIPT = "A dirty fighter who knows how to move fast and camouflage [him]self.",
	PROFTHIEF = "Thief",
	PROFTHIEFDESCRIPT = "A dexterous character often utilized for picking locks and disarming traps.",
	PROFASSASSIN = "Assassin",
	PROFASSASSINDESCRIPT = "A stealthy assassin is capable of bringing down even high armored targets.",
	PROFENGINEER = "Engineer",
	PROFENGINEERDESCRIPT = "A skilled professional often employed for building development and gadget inventions.",
	PROFTEMPLAR = "Templar",
	PROFTEMPLARDESCRIPT = "Devoted warriors who aim to clash with mages and repel mind influencing skills.",
	PROFPALADIN = "Paladin",
	PROFPALADINDESCRIPT = "Fighters who focus on protecting their party and use holy attacks to fight evil.",
	PROFSHAMAN = "Shaman",
	PROFSHAMANDESCRIPT = "Mediums of spirits and nature forces often tied to animalistic origins. ",
	PROFRANGER = "Ranger",
	PROFRANGERDESCRIPT = "A skilled hunter and tracker, proficient with traps. ",
	PROFBARD = "Bard",
	PROFBARDDESCRIPT = "Magic of music is capable to lifting allies' spirit.",
	PROFARCHMAGE = "Archmage",
	PROFARCHMAGEDESCRIPT = "A master of magics capable of bringing elemental destruction on the enemies.",
	PROFBATTLESMITH = "Battle Smith",
	PROFBATTLESMITHDESCRIPT = "Dwarven smiths are able to reach the level of craftsmanship to utilize their skills right on the battlefield. ",
	PROFTECHNOMANCER = "Technomancer",
	PROFTECHNOMANCERDESCRIPT = "By merging magic and technology these specialists are capable of producing very unique results.",

	PROFALIOS_CHAMPION = "Champion of Alios",
	PROFALIOS_CHAMPIONDESCRIPT = "A lone girl with mysterious powers and the past. One thing is clear, her divine affiliation is real. ",
	PROFRENOWN_ROYALTY = "Renown Royalty",
	PROFRENOWN_ROYALTYDESCRIPT = "The royal blood is a boon in itself, even more so when recognized by others. ",
	PROFBROKEN_ROYALTY = "Broken Royalty",
	PROFBROKEN_ROYALTYDESCRIPT = "Once a famous royalty, now a mind broken individual capable of very little... At least her body is still in high demand.",
	
	
	PROFACOLYTE = "Acolyte",
	PROFACOLYTEDESCRIPT = "Individuals have devoted their life to mending to others. ",
	PROFPRIEST = "Priest",
	PROFPRIESTDESCRIPT = "Devoted to their faith and helping others, priests are strong healers capable of meding to serious wounds.",
	PROFMONK = "Monk",
	PROFMONKDESCRIPT = "Religious fighters who utilize their spiritual training to deal with the enemies.",
	PROFBISHOP = "Bishop",
	PROFBISHOPDESCRIPT = "Only selected few manage to reach this rank. Highest members of the church capable of unleashing divine powers.",
	PROFSPOUSE = "Husband",
	PROFSPOUSEALT = "Wife",
	PROFSPOUSEDESCRIPT = "An officially engaged spouse of Mansion's [Master]. Obedience Drain is 0. Loyalty Gain +3.",
	
	PROFFREYAS_PRIESTESS = "Former Freya's Priestess",
	PROFFREYAS_PRIESTESSDESCRIPT = "Once a high priestess of elves, now this title hold more bluster than power.",
	
	TRAITRENOWN = "Renown",
	TRAITRENOWNDESCRIPT = "Gracious skills provide 50% more Loyalty. ",
	
	SKILLWINDWALL = "Wind Wall",
	SKILLWINDWALLDESCRIPT = "Reduces ally line received ranged damage by 50% for 4 turns.",
	SKILLTAKE_POSITION = "Take Position",
	SKILLTAKE_POSITIONDESCRIPT = "Increases armor penetration by 50, damage by 20% for 2 turns. Instant.",

	NEXTCLASSEXP = "Experience required for next class.",

	UPGRADEPREVBONUS = "Previous bonus: ",
	UPGRADENEXTBONUS = "Upgrade bonus: ",
	
	
	
	UPGRADERESOURCE_GATHER_FISH = "Fishing",
	UPGRADERESOURCE_GATHER_FISHDESCRIPT = "Increase available slots for Fishing.",
	UPGRADERESOURCE_GATHER_MEAT = "Hunting",
	UPGRADERESOURCE_GATHER_MEATDESCRIPT = "Increase available slots for Hunting.",
	UPGRADERESOURCE_GATHER_VEGES = "Farming: Vegetables",
	UPGRADERESOURCE_GATHER_VEGESDESCRIPT = "Increase available slots for Vegetable Farming.",
	UPGRADERESOURCE_GATHER_GRAIN = "Farming: Grains",
	UPGRADERESOURCE_GATHER_GRAINDESCRIPT = "Unlocks gathering of Grains from Mansion",
	UPGRADERESOURCE_GATHER_CLOTH = "Farming: Cloth",
	UPGRADERESOURCE_GATHER_CLOTH_SILK = "Farming: Silk",
	UPGRADERESOURCE_GATHER_CLOTHDESCRIPT = "Unlocks gathering of Cloth from Mansion",
	UPGRADERESOURCE_GATHER_CLOTH_SILKDESCRIPT = "Unlocks gathering of Silk from Mansion",
	UPGRADERESOURCE_GATHER_WOOD = "Woodcutting: Wood",
	UPGRADERESOURCE_GATHER_WOODDESCRIPT = "Unlocks gathering of Wood from Mansion",
	UPGRADERESOURCE_GATHER_WOOD_MAGIC = "Woodcutting: Magic Wood",
	UPGRADERESOURCE_GATHER_WOOD_MAGICDESCRIPT = "Unlocks gathering of Magic Wood from Mansion",
	UPGRADERESOURCE_GATHER_WOOD_IRON = "Woodcutting: Iron Wood",
	UPGRADERESOURCE_GATHER_WOOD_IRONDESCRIPT = "Unlocks gathering of Iron Wood from Mansion",
	UPGRADERESOURCE_GATHER_STONE = "Mining: Stone",
	UPGRADERESOURCE_GATHER_STONEDESCRIPT = "Unlocks gathering of Stone from Mansion",
	UPGRADERESOURCE_GATHER_OBSIDIAN = "Mining: Obsidian",
	UPGRADERESOURCE_GATHER_OBSIDIANDESCRIPT = "Unlocks gathering of Obsidian from Mansion",
	UPGRADERESOURCE_GATHER_IRON = "Mining: Iron",
	UPGRADERESOURCE_GATHER_IRONDESCRIPT = "Unlocks gathering of Iron from Mansion",
	UPGRADERESOURCE_GATHER_MITHRIL = "Mining: Mythril",
	UPGRADERESOURCE_GATHER_MITHRILDESCRIPT = "Unlocks gathering of Mythril from Mansion",
	
	UPGRADERESOURCE_MAXIMUM1 = "Increase available slots for this resource by 1 per upgrade level.",
	UPGRADERESOURCE_MAXIMUM2 = "Increase available slots for this resource by 2 per upgrade level.",
	
	
	UPGRADEFARMGRAINSBONUS = "Allows gathering of Grains at mansion",
	UPGRADETAILOR = "Tailor Workshop",
	UPGRADETAILORDESCRIPT = "Allows production of cloth and leather gear",
	UPGRADETAILORBONUS1 = "Unlocks crafting of: Leather Collar, Animal Ears, Animal Gloves, Maid Headband, Handcuffs, Worker Outfit, Base Cloth Armor. ",
	UPGRADETAILORBONUS2 = "Unlocks crafting of: Magic Cloth, Maid Dress, Craftsman Suit, Lacy Underwear, Strapon, Chastity Belt, Anal Plug, Tail Plug, Anal Beads, Base Leather Armor. Increase number of assignable characters to 2",
	UPGRADETAILORBONUS3 = "Unlocks crafting of: Ethereal Cloth, See-through Underwear, Stimulative Underwear, Pet Suit, Elegant Choker, Latex Suit. Increase number of assignable characters to 3",
	UPGRADEFORGE = "Forge",
	UPGRADEFORGEDESCRIPT = "Allows production of metal parts and gear",
	UPGRADEFORGEBONUS1 = "Unlocks basic metal tools and weapon recipes. Unlocks Steel production.",
	UPGRADEFORGEBONUS2 = "Unlocks advanced metal tools and new gear recipes.",
	UPGRADEFORGEBONUS3 = "Unlocks advanced weapon and armor recipes",
	UPGRADEFARMING_MAX_WORKERS = "Farming: Maximum workers",
	UPGRADEFISHING_MAX_WORKERS = "Fishing: Maximum workers",
	UPGRADECOOKING_MAX_WORKERS = "Cooking: Maximum workers",
	UPGRADEPROSTITUTION_MAX_WORKERS = "Prostitution: Maximum workers",
	UPGRADEFARMING_MAX_WORKERSDESCRIPT = "Farming maximum workers upgrade",
	UPGRADEFISHING_MAX_WORKERSDESCRIPT = "Fishing maximum workers upgrade",
	UPGRADECOOKING_MAX_WORKERSDESCRIPT = "Cooking maximum workers upgrade",
	UPGRADEPROSTITUTION_MAX_WORKERSDESCRIPT = "Prostitution maximum workers upgrade",

	UPGRADETORTURE_ROOM = "Torture Room",
	UPGRADETORTURE_ROOMDESCRIPT = "Adds torture options during Meeting activity.",
	UPGRADETORTUREROOMBONUS = "Unlocks advanced Punishments during Meeting activity including bringing others to watch.",

	UPGRADEALCHEMY = "Alchemy",
	UPGRADEALCHEMYDESCRIPT = "Allows production of potions and advanced resources",
	UPGRADEALCHEMYBONUS1 = "Unlocks basic alchemical and healing item recipes.",
	UPGRADEALCHEMYBONUS2 = "Unlocks advanced alchemical and healing item recipes. Unlocks recipes for Enchanted Wood and Adamantine. Increase number of assignable characters to 2",
	UPGRADEALCHEMYBONUS3 = "Unlocks Advanced Staff and some advanced ink recipes. Increase number of assignable characters to 3",
	UPGRADEMASTER_BEDROOM = "Master's Bedroom",
	UPGRADEMASTER_BEDROOMDESCRIPT = "Master's Bedroom upgrade",
	UPGRADERESOURCE_GATHER_LEATHER = "Leather Gathering",
	UPGRADERESOURCE_GATHER_LEATHERDESCRIPT = "Hunting task upgrade",
	UPGRADELEATHERBONUS1 = "Allows gathering of Thick Leather",
	UPGRADELEATHERBONUS2 = "Allows gathering of Mythic Leather",
	UPGRADEGATHERCLOTHBONUS = "Allows gathering of Cloth in mansion",
	UPGRADEGATHERWOODIRONBONUS = "Allows gathering of Iron Wood",
	UPGRADEGATHERWOODMAGICBONUS = "Allows gathering of Magic Wood",
	UPGRADEGATHERIRONBONUS = "Allows gathering of Iron",
	UPGRADEGATHERMITHRILBONUS = "Allows gathering of Mithril",
	UPGRADEROOMS = "Mansion Rooms",
	UPGRADEROOMSDESCRIPT = "Increases maximum number of hosted characters.",
	UPGRADEROOMSBONUS1 = "Increases maximum number of hosted characters to 10.",
	UPGRADEROOMSBONUS2 = "Increases maximum number of hosted characters to 15.",
	UPGRADEROOMSBONUS3 = "Increases maximum number of hosted characters to 20.",
	UPGRADEROOMSBONUS4 = "Increases maximum number of hosted characters to 25.",
	UPGRADEROOMSBONUS5 = "Increases maximum number of hosted characters to 30.",
	UPGRADELUXURY_ROOMS = "Luxury Rooms",
	UPGRADELUXURY_ROOMSDESCRIPT = "Increases maximum number of available Luxury Rooms. Luxury Rooms will reduce Obedience Drain and increase Loyalty Gain to its residents. ",
	UPGRADELUXURYROOMSBONUS1 = "Increases maximum number of available Luxury Rooms to 2.",
	UPGRADELUXURYROOMSBONUS2 = "Increases maximum number of available Luxury Rooms to 3.",
	UPGRADELUXURYROOMSBONUS3 = "Increases maximum number of available Luxury Rooms to 4.",
	UPGRADELUXURYROOMSBONUS4 = "Increases maximum number of available Luxury Rooms to 5.",
	UPGRADELUXURYROOMSBONUS5 = "Increases maximum number of available Luxury Rooms to 6.",
	UPGRADELUXURYROOMSBONUS6 = "Increases maximum number of available Luxury Rooms to 7.",
	UPGRADELUXURYROOMSBONUS7 = "Increases maximum number of available Luxury Rooms to 8.",


	UPGRADEMASTERBEDROOMBONUS1 = 'Increases number of participants in sex interactions to 3',
	UPGRADEMASTERBEDROOMBONUS2 = 'Increases number of participants in sex interactions to 4',
	UPGRADEMASTERBEDROOMBONUS3 = 'Increases number of participants in sex interactions to 5',

	UPGRADESTABLES = "Stables",
	UPGRADESTABLESDESCRIPT = "Makes traveling faster",
	UPGRADESTABLESBONUS1 = "Reduce time periods required to travel to another location by 1 (can't be lower than 1)",
	UPGRADESTABLESBONUS2 = "Reduce time periods required to travel to another location by 2 (can't be lower than 1)",

	UPGRADEFORGEWORKSHOP = "Forge Tools",
	UPGRADEFORGEWORKSHOPDESCRIPT = "Improves the speed of Smithing and Upgrading tasks.",
	UPGRADEFORGEWORKBONUS1 = "Improves the speed by 25%",
	UPGRADEFORGEWORKBONUS2 = "Improves the speed by 50%",
	
	UPGRADEBUILDERTOOLS = "Builder Tools",
	UPGRADEBUILDERTOOLSDESCRIPT = "Increase number of characters which can be assigned to Upgrading at once.",
	UPGRADEBUILDERTOOLSBONUS1 = "Maximum number of Upgrading slots: 2",
	UPGRADEBUILDERTOOLSBONUS2 = "Maximum number of Upgrading slots: 3",
	UPGRADEBUILDERTOOLSBONUS3 = "Maximum number of Upgrading slots: 4",
	
	
	INTERACTIONSNOSEXTAG = "[name]'s personal story has not progressed to the point of allowing [him] to participate in these kinds of actions.",

	NOSEXDETAILSDESCRIPT = "{color=green|Unfortunately, you are unable to check on [his] private parts.}",

	UPGRADEEXOTIC_TRADER = "Exotic Trader",
	UPGRADEEXOTIC_TRADERDESCRIPT = "Improves slaves offered by Exotic Slave Trader.",
	UPGRADEEXOTICBONUS = "Slaves from Exotic Slave Trader Avermik will have higher base stats and more classes.",
	UPGRADESEX_TIMES = "Bedroom Endurance",
	UPGRADESEX_TIMESDESCRIPT = "Increase number of times you can do sex interactions per day.",
	UPGRADESEX_TIMEBONUS1 = "Increase daily sex interactions to 2",
	UPGRADESEX_TIMEBONUS2 = "Increase daily sex interactions to 3",
	UPGRADERESTING = "Bath",
	UPGRADERESTINGDESCRIPT = "Characters resting at Mansion will will deplete their Obedience at half speed.",
	UPGRADERESTINGBONUS1 = "",
	UPGRADEACADEMY = "Academy",
	UPGRADEACADEMYDESCRIPT = "Allows to send newborn children for Academy training.",

	BODYPARTAGETEEN = "teen",
	BODYPARTAGEADULT = "adult",
	BODYPARTAGEMATURE = "mature",
	BODYPARTBODY_SHAPEHUMANOID = "humanoid",
	BODYPARTBODY_SHAPEBESTIAL = "bestial",
	BODYPARTBODY_SHAPESHORTSTACK = "shortstack",
	BODYPARTBODY_SHAPEJELLY = "jelly",
	BODYPARTBODY_SHAPEHALFBIRD = "half-bird",
	BODYPARTBODY_SHAPEHALFSNAKE = "half-snake",
	BODYPARTBODY_SHAPEHALFFISH = "half-fish",
	BODYPARTBODY_SHAPEHALFSPIDER = "half-spider",
	BODYPARTBODY_SHAPEHALFHORSE = "half-horse",
	BODYPARTBODY_SHAPEHALFSQUID = "half-squid",
	BODYPARTHAIR_LENGTHBALD = "bald",
	BODYPARTHAIR_LENGTHEAR = "ear",
	BODYPARTHAIR_LENGTHNECK = "neck",
	BODYPARTHAIR_LENGTHSHOULDER = "shoulder",
	BODYPARTHAIR_LENGTHWAIST = "waist",
	BODYPARTHAIR_LENGTHHIPS = "hips",
	BODYPARTHAIR_STYLESTRAIGHT = "straight",
	BODYPARTHAIR_STYLEPONYTAIL = "ponytail",
	BODYPARTHAIR_STYLEPIGTAILS = "pigtails",
	BODYPARTHAIR_STYLEBRAID = "braid",
	BODYPARTHAIR_STYLETWINBRAIDS = "twin braids",
	BODYPARTHAIR_STYLEBUN = "bun",
	BODYPARTEYE_COLORDEFAULT = "default",
	BODYPARTEYE_SHAPENORMAL = "normal",
	BODYPARTEYE_SHAPESLIT = "slit",
	BODYPARTHORNSSHORT = "short",
	BODYPARTHORNSSTRAIGHT = "straight",
	BODYPARTHORNSCURVED = "curved",
	BODYPARTEARSHUMAN = "human",
	BODYPARTEARSELVEN = "elven",
	BODYPARTEARSORCISH = "orcish",
	BODYPARTEARSCAT = "cat",
	BODYPARTEARSWOLF = "wolf",
	BODYPARTEARSFOX = "fox",
	BODYPARTEARSBUNNY_STANDING = "bunny standing",
	BODYPARTEARSBUNNY_DROOPING = "bunny drooping",
	BODYPARTEARSTANUKI = "tanuki",
	BODYPARTEARSDEMON = "demon",
	BODYPARTEARSCOW = "cow",
	BODYPARTEARSFEATHERED = "feathered",
	BODYPARTEARSFISH = "fish",
	BODYPARTSKINPALE = "pale",
	BODYPARTSKINGREY = "grey",
	BODYPARTSKINFAIR = "fair",
	BODYPARTSKINOLIVE = "olive",
	BODYPARTSKINTAN = "tan",
	BODYPARTSKINBROWN = "brown",
	BODYPARTSKINDARK = "dark",
	BODYPARTSKINSLIME = "slime",
	BODYPARTSKINBLUE = "blue",
	BODYPARTSKINPALEBLUE = "paleblue",
	BODYPARTSKINGREEN = "green",
	BODYPARTSKINRED = "red",
	BODYPARTSKINPURPLE = "purple",
	BODYPARTSKINTEAL = "teal",
	BODYPARTSKIN_COVERAGEPLANT = "plant",
	BODYPARTSKIN_COVERAGESCALE = "scale",
	BODYPARTSKIN_COVERAGEFEATHERS = "feathers",
	BODYPARTSKIN_COVERAGEFUR_WHITE = "white fur",
	BODYPARTSKIN_COVERAGEFUR_GREY = "grey fur",
	BODYPARTSKIN_COVERAGEFUR_BROWN = "brown fur",
	BODYPARTSKIN_COVERAGEFUR_STRIPED = "striped fur",
	BODYPARTSKIN_COVERAGEFUR_BLACK = "black fur",
	BODYPARTSKIN_COVERAGEFUR_ORANGE = "orange fur",
	BODYPARTSKIN_COVERAGEFUR_ORANGE_WHITE = "fox fur",
	BODYPARTWINGSFEATHERED_BLACK = "black feathered",
	BODYPARTWINGSSERAPH = "seraph",
	BODYPARTWINGSFEATHERED_BROWN = "brown feathered",
	BODYPARTWINGSFAIRY = "fairy",
	BODYPARTWINGSDEMON = "demon",
	BODYPARTWINGSDRAGON = "dragon",
	BODYPARTWINGSLEATHER_BLACK = "black leather",
	BODYPARTWINGSLEATHER_RED = "red leather",
	BODYPARTTAILCAT = "cat",
	BODYPARTTAILFOX = "fox",
	BODYPARTTAILWOLF = "wolf",
	BODYPARTTAILBUNNY = "bunny",
	BODYPARTTAILTANUKI = "tanuki",
	BODYPARTTAILCOW = "cow",
	BODYPARTTAILDEMON = "demon",
	BODYPARTTAILDRAGON = "dragon",
	BODYPARTTAILAVIAN = "avian",
	BODYPARTTAILFISH = "fish",
	BODYPARTTAILSNAKE = "snake",
	BODYPARTTAILTENTACLES = "tentacles",
	BODYPARTTAILHORSE = "horse",
	BODYPARTTAILSPIDER = "spider",
	BODYPARTHEIGHTTINY = "tiny",
	BODYPARTHEIGHTPETITE = "petite",
	BODYPARTHEIGHTSHORT = "short",
	BODYPARTHEIGHTAVERAGE = "average",
	BODYPARTHEIGHTTALL = "tall",
	BODYPARTHEIGHTTOWERING = "towering",
	BODYPARTTITS_SIZEFLAT = "flat",
	BODYPARTTITS_SIZESMALL = "small",
	BODYPARTTITS_SIZEAVERAGE = "average",
	BODYPARTTITS_SIZEBIG = "big",
	BODYPARTTITS_SIZEHUGE = "huge",
	BODYPARTTITS_SIZEMASCULINE = "masculine",
	BODYPARTASS_SIZEFLAT = "flat",
	BODYPARTASS_SIZESMALL = "small",
	BODYPARTASS_SIZEAVERAGE = "average",
	BODYPARTASS_SIZEBIG = "big",
	BODYPARTASS_SIZEHUGE = "huge",
	BODYPARTASS_SIZEMASCULINE = "masculine",
	BODYPARTBALLS_SIZESMALL = "small",
	BODYPARTBALLS_SIZEAVERAGE = "average",
	BODYPARTBALLS_SIZEBIG = "big",
	BODYPARTPENIS_TYPEHUMAN = "human",
	BODYPARTPENIS_TYPECANINE = "canine",
	BODYPARTPENIS_TYPEFELINE = "feline",
	BODYPARTPENIS_TYPEEQUINE = "equine",
	BODYPARTPENIS_SIZEHUMAN_SMALL = "human_small",
	BODYPARTPENIS_SIZEHUMAN_AVERAGE = "human_average",
	BODYPARTPENIS_SIZEHUMAN_BIG = "human_big",
	BODYPARTPENIS_SIZECANINE_SMALL = "canine_small",
	BODYPARTPENIS_SIZECANINE_AVERAGE = "canine_average",
	BODYPARTPENIS_SIZECANINE_BIG = "canine_big",
	BODYPARTPENIS_SIZEFELINE_SMALL = "feline_small",
	BODYPARTPENIS_SIZEFELINE_AVERAGE = "feline_average",
	BODYPARTPENIS_SIZEFELINE_BIG = "feline_big",
	BODYPARTPENIS_SIZEEQUINE_SMALL = "equine_small",
	BODYPARTPENIS_SIZEEQUINE_AVERAGE = "equine_average",
	BODYPARTPENIS_SIZEEQUINE_BIG = "equine_big",
	BODYPARTHAS_PUSSYTRUE = "has pussy",
	BODYPARTHAS_PUSSYFALSE = " ",
	BODYPARTVAGINAL_VIRGINTRUE_TRUE = "is a virgin",
	BODYPARTVAGINAL_VIRGINTRUE_FALSE = "is not a virgin",


	BODYPARTANAL_VIRGINTRUEDESCRIPT = "[His] {color=yellow|anal virginity} has not been claimed by anyone yet.",
	BODYPARTANAL_VIRGINFALSEDESCRIPT = "[His] ass is trained enough for penetration.",

	BODYPARTPENIS_SIZEHUMAN_SMALLDESCRIPT = 'Below [his] waist dangles a [color=yellow]tiny humanish{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} dick[/color], small enough that it could be called cute.',
	BODYPARTPENIS_SIZEHUMAN_AVERAGEDESCRIPT ='[He] has an [color=yellow]ordinary humanish{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} penis[/color] below [his] waist, more than enough to make most men proud.',
	BODYPARTPENIS_SIZEHUMAN_BIGDESCRIPT = 'A [color=yellow]huge humanish{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} cock[/color] swings heavily from [his] groin, big enough to give even the most veteran whore pause.',
	BODYPARTPENIS_SIZECANINE_SMALLDESCRIPT = 'A slender, pointed[color=yellow]{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} canine dick[/color] hangs below [his] waist, so small that its knot is barely noticeable.',
	BODYPARTPENIS_SIZECANINE_AVERAGEDESCRIPT = "[He] has a knobby, red,[color=yellow]{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} canine cock[/color] of respectable size below [his] waist, which wouldn't look out of place on a large dog.",
	BODYPARTPENIS_SIZECANINE_BIGDESCRIPT = 'Growing from [his] crotch is a [color=yellow]massive{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} canine dick[/color], red-skinned and sporting a thick knot near the base.',
	BODYPARTPENIS_SIZEFELINE_SMALLDESCRIPT = 'A [color=yellow]tiny{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} feline penis[/color] dangles below [his] waist, so small you can barely see the barbs.',
	BODYPARTPENIS_SIZEFELINE_AVERAGEDESCRIPT = '[He] has a barbed[color=yellow]{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} cat dick[/color] growing from [his] crotch, big enough to rival an average human.',
	BODYPARTPENIS_SIZEFELINE_BIGDESCRIPT = 'There is a frighteningly [color=yellow]large{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} feline cock[/color] hanging between [his] thighs, its sizable barbs make it somewhat intimidating.',
	BODYPARTPENIS_SIZEEQUINE_SMALLDESCRIPT = 'Below [his] waist hangs a [color=yellow]smallish{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} equine cock[/color], which is still respectable compared to the average man.',
	BODYPARTPENIS_SIZEEQUINE_AVERAGEDESCRIPT = 'A [color=yellow]sizable{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} equine cock[/color] grows from [his] nethers which, while small on a horse, is still thicker and heavier than the average human tool.',
	BODYPARTPENIS_SIZEEQUINE_BIGDESCRIPT = 'A [color=yellow]massive{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} equine cock[/color] hangs heavily below [his] waist, its mottled texture not quite matching the rest of [his] skin. The size of the package gives most partners pause.',

	BODYPARTAGETEENDESCRIPT = "[He]'s a [color=aqua]teenage [boygirlfuta][/color] of the [url=race][color=yellow][raceadj] race[/color][/url].",
	BODYPARTAGEADULTDESCRIPT = "[He]'s a [color=aqua]young adult [male][/color] of the [url=race][color=yellow][raceadj] race[/color][/url].",
	BODYPARTAGEMATUREDESCRIPT = "[He]'s a [color=aqua]mature [male][/color] of the [url=race][color=yellow][raceadj] race[/color][/url].",

	BODYPARTBODY_SHAPEHUMANOIDDESCRIPT = " ",
	BODYPARTBODY_SHAPEBESTIALDESCRIPT = " ",
	BODYPARTBODY_SHAPESHORTSTACKDESCRIPT = "[His] body is rather [color=yellow]petite[/color], about half the size of the average person.",
	BODYPARTBODY_SHAPEJELLYDESCRIPT = "[His] body is [color=yellow]jelly-like[/color] and partly transparent.",
	BODYPARTBODY_SHAPEHALFBIRDDESCRIPT = "[His] body has [color=yellow]wings for arms and avian legs[/color] making everyday tasks difficult.",
	BODYPARTBODY_SHAPEHALFSNAKEDESCRIPT = "The lower portion of [his] body consists of a long-winding [color=yellow]snake's tail[/color].",
	BODYPARTBODY_SHAPEHALFFISHDESCRIPT = "[His] body is [color=yellow]scaly and sleek[/color], possessing fins and webbed digits.",
	BODYPARTBODY_SHAPEHALFSPIDERDESCRIPT = "The lower portion of [his] body consists of a [color=yellow]spider's legs and abdomen[/color].",
	BODYPARTBODY_SHAPEHALFHORSEDESCRIPT = "While [his] upper body is human, [his] lower body is [color=yellow]equine[/color] in nature.",
	BODYPARTBODY_SHAPEHALFSQUIDDESCRIPT = "The lower portion of [his] body consists of a [color=yellow]number of tentacle appendages[/color], similar to those of an octopus.",

	BODYPARTHAIR_LENGTHBALDDESCRIPT = "[He] [color=aqua]lacks[/color] any visible hair on [his] head.",

	BODYPARTHAIR_LENGTHEARDESCRIPT = "[His] [color=aqua][hair_color][/color] hair is cut [color=aqua]short[/color].",
	BODYPARTHAIR_LENGTHNECKDESCRIPT = "[His] [color=aqua][hair_color][/color] hair falls down to just [color=aqua]below [his] neck[/color].",
	BODYPARTHAIR_LENGTHSHOULDERDESCRIPT = "[His] wavy [color=aqua][hair_color][/color] hair is [color=aqua]shoulder length[/color].",
	BODYPARTHAIR_LENGTHWAISTDESCRIPT = "[His] gorgeous [color=aqua][hair_color][/color] hair [color=aqua]sways down to [his] waist[/color].",
	BODYPARTHAIR_LENGTHHIPSDESCRIPT = "[His] [color=aqua][hair_color][/color] hair cascades down, [color=aqua]reaching [his] hips[/color].",


	BODYPARTHAIR_STYLESTRAIGHTDESCRIPT = "It [url=hair][color=aqua]hangs freely[/color][/url] from [his] head.",
	BODYPARTHAIR_STYLEPONYTAILDESCRIPT = "It is tied in a [url=hair][color=aqua]high ponytail[/color][/url].",
	BODYPARTHAIR_STYLEPIGTAILSDESCRIPT = "It is managed in girly [url=hair][color=aqua]twin-tails[/color][/url].",
	BODYPARTHAIR_STYLEBRAIDDESCRIPT = "It is combed into a single [url=hair][color=aqua]braid[/color][/url].",
	BODYPARTHAIR_STYLETWINBRAIDSDESCRIPT = "It is combed into [url=hair][color=aqua]two braids[/color][/url].",
	BODYPARTHAIR_STYLEBUNDESCRIPT = "It is tied into a neat [url=hair][color=aqua]bun[/color][/url].",

	BODYPARTEYE_COLORDEFAULTDESCRIPT = "[His] eyes are [color=aqua][eye_color][/color].",
	BODYPARTEYE_SHAPENORMALDESCRIPT = ' ',
	BODYPARTEYE_SHAPESLITDESCRIPT = "[He] has [color=aqua]vertical, animalistic pupils[/color].",

	BODYPARTHORNSSHORTDESCRIPT = "There is a pair of [color=aqua]tiny, pointed horns[/color] on top of [his] head.",
	BODYPARTHORNSSTRAIGHTDESCRIPT = "[He] has a pair of [color=aqua]long, bull-like horns[/color].",
	BODYPARTHORNSCURVEDDESCRIPT = "There are [color=aqua]curved horns[/color] coiling around [his] head.",

	BODYPARTEARSHUMANDESCRIPT = " ",
	BODYPARTEARSELVENDESCRIPT = "[He] has straight long [color=aqua]pointed[/color] ears.",
	BODYPARTEARSORCISHDESCRIPT = "[He] has [color=aqua]stubby pointed[/color] ears.",
	BODYPARTEARSCATDESCRIPT = "[He] has a pair of perky [color=aqua]cat[/color] ears.",
	BODYPARTEARSWOLFDESCRIPT = "[He] has a pair of stubby [color=aqua]wolf[/color] ears.",
	BODYPARTEARSFOXDESCRIPT = "[He] has a pair of long expressive [color=aqua]fox[/color] ears.",
	BODYPARTEARSBUNNY_STANDINGDESCRIPT = "[He] has a pair of [color=aqua]standing bunny ears[/color] rising above [his] head.",
	BODYPARTEARSBUNNY_DROOPINGDESCRIPT = "[He] has a pair of [color=aqua]droopy, bunny ears[/color] on [his] head.",
	BODYPARTEARSTANUKIDESCRIPT = "[He] has a pair of rounded [color=aqua]raccoon[/color] ears.",
	BODYPARTEARSDEMONDESCRIPT = "[He] has a pair of [color=aqua]demonic[/color] ears.",
	BODYPARTEARSCOWDESCRIPT = "[He] has a pair of fluffy [color=aqua]cow[/color] ears.",
	BODYPARTEARSFEATHEREDDESCRIPT = "There's a pair of clutched [color=aqua]feathery ears[/color] on the sides of [His] head.",
	BODYPARTEARSFISHDESCRIPT = "[His] ears look like a pair of [color=aqua]fins[/color].",

	BODYPARTSKINPALEDESCRIPT = "[His] skin is a [color=aqua]pale[/color] white.",
	BODYPARTSKINGREYDESCRIPT = "[His] skin is a stone [color=aqua]grey[/color].",
	BODYPARTSKINFAIRDESCRIPT = "[His] skin is healthy and [color=aqua]fair[/color] color.",
	BODYPARTSKINOLIVEDESCRIPT = "[His] skin is of an unusual [color=aqua]olive[/color] tone.",
	BODYPARTSKINTANDESCRIPT = "[His] skin is a [color=aqua]tanned[/color] bronze color.",
	BODYPARTSKINBROWNDESCRIPT = "[His] skin is a mixed [color=aqua]brown[/color] color.",
	BODYPARTSKINDARKDESCRIPT = "[His] skin is deep and[color=aqua]dark[/color].",
	BODYPARTSKINSLIMEDESCRIPT = "[His] skin is [color=aqua]semi-transparent and jelly-like[/color].",
	BODYPARTSKINBLUEDESCRIPT = "[His] skin is dark [color=aqua]blue[/color].",
	BODYPARTSKINPALE_BLUEDESCRIPT = "[His] skin is [color=aqua]light pale blue[/color].",
	BODYPARTSKINGREENDESCRIPT = "[His] skin is [color=aqua]green[/color].",
	BODYPARTSKINREDDESCRIPT = "[His] skin is bright [color=aqua]red[/color].",
	BODYPARTSKINPURPLEDESCRIPT = "[His] skin is [color=aqua]purple[/color].",
	BODYPARTSKINTEALDESCRIPT = "[His] skin is [color=aqua]teal[/color].",

	BODYPARTSKIN_COVERAGEPLANTDESCRIPT = "Various leaves and bits of [color=aqua]plant matter[/color] cover parts of [his] body.",
	BODYPARTSKIN_COVERAGESCALEDESCRIPT = "[His] skin is partly covered with [color=aqua]scales[/color].",
	BODYPARTSKIN_COVERAGEFEATHERSDESCRIPT = "[His] body is covered in [color=aqua]bird-like feathers[/color] in many places.",
	BODYPARTSKIN_COVERAGEFUR_WHITEDESCRIPT = "[His] body is covered in thick, soft [color=aqua]fur of marble color[/color].",
	BODYPARTSKIN_COVERAGEFUR_GREYDESCRIPT = "[His] body is covered in thick, soft [color=aqua]fur of gray color[/color].",
	BODYPARTSKIN_COVERAGEFUR_BROWNDESCRIPT = "[His] body is covered in thick, soft [color=aqua]fur of light-brown tone[/color].",
	BODYPARTSKIN_COVERAGEFUR_STRIPEDDESCRIPT = "[His] body is covered in thick, soft [color=aqua]striped fur[/color].",
	BODYPARTSKIN_COVERAGEFUR_BLACKDESCRIPT = "[His] body is covered in thick, soft [color=aqua]fur of jet-black color[/color].",
	BODYPARTSKIN_COVERAGEFUR_ORANGEDESCRIPT = "[His] body is covered in thick, soft [color=aqua]fur of common fox pattern[/color].",
	BODYPARTSKIN_COVERAGEFUR_ORANGE_WHITEDESCRIPT = "[His] body is covered in thick, soft [color=aqua]fur of orange-white pattern[/color].",

	BODYPARTWINGSFEATHERED_BLACKDESCRIPT ="On [his] back, [he] has folded, [color=aqua]black, feathery wings[/color].",
	BODYPARTWINGSSERAPHDESCRIPT = "On [his] back, [he] has folded, [color=aqua]white, feathery wings[/color].",
	BODYPARTWINGSFEATHERED_BROWNDESCRIPT = "On [his] back, [he] has folded, [color=aqua]brown, feathery wings[/color].",
	BODYPARTWINGSFAIRYDESCRIPT = "On [his] back rests translucent [color=aqua]fairy wings[/color].",
	BODYPARTWINGSDEMONDESCRIPT = "Hidden on [his] back is a pair of bat-like, [color=aqua]demon wings[/color].",
	BODYPARTWINGSDRAGONDESCRIPT = "Hidden on [his] back is a pair of thick, [color=aqua]dragon wings[/color].",
	BODYPARTWINGSLEATHER_BLACKDESCRIPT = "Hidden on [his] back is a pair of bat-like, [color=aqua]black leather wings[/color].",
	BODYPARTWINGSLEATHER_REDDESCRIPT = "Hidden on [his] back is a pair of bat-like, [color=aqua]red leather wings[/color].",

	BODYPARTTAILCATDESCRIPT = 'Below [his] waist, you spot a slim [color=aqua]cat tail[/color] covered with fur.',
	BODYPARTTAILFOXDESCRIPT = '[He] has a large, fluffy [color=aqua]fox tail[/color].',
	BODYPARTTAILWOLFDESCRIPT = "Below [his] waist there's a short, fluffy, [color=aqua]wolf tail[/color].",
	BODYPARTTAILBUNNYDESCRIPT = '[He] has a [color=aqua]small ball of fluff[/color] behind [his] rear.',
	BODYPARTTAILTANUKIDESCRIPT = '[He] has a plump, fluffy [color=aqua]raccoon tail[/color].',
	BODYPARTTAILCOWDESCRIPT = 'Behind [his] back you notice a long tail covered in a thin layer of fur which ends in a [color=aqua]scruffy brush[/color].',
	BODYPARTTAILDEMONDESCRIPT = '[He] has a long, thin, [color=aqua]demonic tail[/color] ending in a pointed tip.',
	BODYPARTTAILDRAGONDESCRIPT = 'Trailing somewhat behind [his] back is a [color=aqua]scaled tail[/color].',
	BODYPARTTAILAVIANDESCRIPT = '[He] has a [color=aqua]feathery bird tail[/color] on [his] rear.',
	BODYPARTTAILFISHDESCRIPT = '[His] rear ends in a long, sleek [color=aqua]fish tail[/color].',
	BODYPARTTAILSNAKEDESCRIPT = " ",
	BODYPARTTAILTENTACLESDESCRIPT = " ",
	BODYPARTTAILHORSEDESCRIPT = " ",
	BODYPARTTAILSPIDERDESCRIPT = " ",

	BODYPARTHEIGHTTINYDESCRIPT = "[His] stature is [color=aqua]extremely small[/color], barely half the size of a normal person.",
	BODYPARTHEIGHTPETITEDESCRIPT = "[His] stature is quite [color=aqua]petite[/color].",
	BODYPARTHEIGHTSHORTDESCRIPT ="[His] height is quite [color=aqua]short[/color].",
	BODYPARTHEIGHTAVERAGEDESCRIPT ="[He] is of [color=aqua]average[/color] height.",
	BODYPARTHEIGHTTALLDESCRIPT = "[He] is quite [color=aqua]tall[/color] compared to the average person.",
	BODYPARTHEIGHTTOWERINGDESCRIPT = "[He] is unusually tall, [color=aqua]towering[/color] over others.",

	BODYPARTTITS_SIZEFLATDESCRIPT = "[His] chest is barely visible and nearly [color=yellow]flat[/color].",
	BODYPARTTITS_SIZESMALLDESCRIPT = "[He] has [color=yellow]small[/color], round boobs.",
	BODYPARTTITS_SIZEAVERAGEDESCRIPT = "[His] nice, [color=yellow]perky[/color] breasts are firm and inviting.",
	BODYPARTTITS_SIZEBIGDESCRIPT = "[His] [color=yellow]big[/color] tits are pleasantly soft, but still have a nice spring to them.",
	BODYPARTTITS_SIZEHUGEDESCRIPT = "[His] [color=yellow]giant[/color] tits are mind-blowingly big.",
	BODYPARTTITS_SIZEMASCULINEDESCRIPT = "[His] chest is of definitive [color=yellow]masculine[/color] shape.",

	BODYPARTASS_SIZEFLATDESCRIPT = "[His] butt is skinny and [color=yellow]flat[/color].",
	BODYPARTASS_SIZESMALLDESCRIPT = "[He] has a [color=yellow]small[/color], firm butt.",
	BODYPARTASS_SIZEAVERAGEDESCRIPT = "[He] has a nice, [color=yellow]pert[/color] ass you could bounce a coin off.",
	BODYPARTASS_SIZEBIGDESCRIPT = "[He] has a pleasantly [color=yellow]plump[/color], heart-shaped ass that jiggles enticingly with each step.",
	BODYPARTASS_SIZEHUGEDESCRIPT = "[He] has a [color=yellow]huge[/color], attention-grabbing ass.",
	BODYPARTASS_SIZEMASCULINEDESCRIPT = "[His] ass definitively has a [color=yellow]masculine[/color] shape.",

	BODYPARTBALLS_SIZESMALLDESCRIPT = "[He] has a pair of [color=yellow]tiny[/color] balls.",
	BODYPARTBALLS_SIZEAVERAGEDESCRIPT = "[He] has an [color=yellow]average-sized[/color] ballsack.",
	BODYPARTBALLS_SIZEBIGDESCRIPT = "[He] has a [color=yellow]huge[/color] pair of balls weighing down [his] scrotum.",

	BODYPARTVAGINAL_VIRGINTRUE_TRUEDESCRIPT = '[He] has a tight, [color=yellow]virgin pussy[/color].',
	BODYPARTVAGINAL_VIRGINTRUE_FALSEDESCRIPT = "[He] has a [color=yellow]normal pussy[/color] below [his] waist.",
	BODYPARTHAS_PUSSYFALSEDESCRIPT = " ",

	BODYPARTPREGLINELATE = "[His] {color=yellow|unborn} child forces [his] belly to protrude massively; [he] will give birth soon.",
	BODYPARTPREGLINEEARLY = "[His] {color=yellow|unborn fetus} causes [his] belly to bulge slightly. ",

	SEXTRAITORAL = "Oral Lover",
	SEXTRAITLIKES_SHORTSTACKS = "Shortstack Enthusiast",
	SEXTRAITLIKES_BEASTS = "Likes them beasty",
	SEXTRAITBISEXUAL = "Bisexual",
	SEXTRAITOPEN_MINDED = "Open-minded",
	SEXTRAITDEVIANT = "Deviant",
	SEXTRAITGROUP = "Company Lover",
	SEXTRAITSHAMELESS = "Shameless",
	SEXTRAITANAL = "Anal Lover",
	SEXTRAITBREASTS = "Tits Lover",
	SEXTRAITMASOCHIST = "Masochist",
	SEXTRAITSADIST = "Sadist",
	SEXTRAITDOORMAT = "Doormat",
	SEXTRAITSUBMISSIVE = "Submissive",
	SEXTRAITDOMINANT = "Dominant",
	SEXTRAITNYMPHOMANIA = "Nymphomania",
	SEXTRAITHYPERSENSITIVE = "Hypersensitive",
	SEXTRAITLEWDNESS_AURA = "Perverse Aura",
	SEXTRAITBOTTLE_FAIRY = "Bottle Fairy",
	SEXTRAITIRRESISTIBLE = "Irresistible",
	SEXTRAITBEDROOM_PRODIDGY = "Bedroom Prodigy",
	SEXTRAITPUSHOVER = "Pushover",
	SEXTRAITTEACHER = "Teacher",
	SEXTRAITDESIRED = "Desired",
	SEXTRAITCURIOUS = "Curious",
	SEXTRAITLIFE_POWER = "Life Power",

	SEXSKILLSDESCRIPT = "Sex skills improve character's performance while interacting and affect the Sexuals stat. Higher Sex Skill will make a partner more aroused from Character's actions. \n\nSex skills are increased when performing related action and their growth is dependent on Sex Factor.",
	SEXSKILLORAL = "Oral",
	SEXSKILLANAL = "Anal",
	SEXSKILLPETTING = "Petting",
	SEXSKILLPENETRATION = "Penetration",
	SEXSKILLTAIL = "Tail",
	SEXSKILLPUSSY = "Pussy",
	SEXSKILLORALDESCRIPT = "Increases effect of actions performed with mouth.",
	SEXSKILLANALDESCRIPT = "Increases effect of actions performed with rear.",
	SEXSKILLPETTINGDESCRIPT = "Increases effect of petting actions.",
	SEXSKILLPENETRATIONDESCRIPT = "Increases effect of actions involving penetration and thrusts.",
	SEXSKILLTAILDESCRIPT = "Increases effect of actions performed with tail.",
	SEXSKILLPUSSYDESCRIPT = "Increases effect of actions when [name]'s vagina is penetrated.",

	SEXTRAITDISLIKE_PETTING = "Dislikes Petting",
	SEXTRAITDISLIKE_FINGERING = "Dislike Fingering",
	SEXTRAITDISLIKE_TITS = "Dislike Breasts",
	SEXTRAITDISLIKE_ORAL = "Dislike Oral",
	SEXTRAITDISLIKE_MISSIONARY = "Dislike Missionary Positions",
	SEXTRAITDISLIKE_DOGGY = "Dislike Doggy Positions",
	SEXTRAITDISLIKE_SITTING = "Dislike Sitting Positions",
	SEXTRAITDISLIKE_RIDING = "Dislike Riding Positions",
	SEXTRAITDISLIKE_GROUP = "Dislike Group Sex",
	SEXTRAITDISLIKE_BDSM = "Dislike Harsh Sex",
	SEXTRAITDISLIKE_TAIL = "Dislike Perverted Actions",

	SEXTRAITDISLIKE_PETTINGDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_FINGERINGDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_TITSDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_ORALDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_MISSIONARYDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_DOGGYDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_SITTINGDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_RIDINGDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_GROUPDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_BDSMDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	SEXTRAITDISLIKE_TAILDESCRIPT = "[name] expresses dislike for certain lewd actions. [His] consent and the effect of received actions are lowered for [him]. ",



	SEXTRAITBISEXUALDESCRIPT = "[name] does not mind having sex with people of [his] gender. Removes consent penalty from same-sex partners.",
	SEXTRAITOPEN_MINDEDDESCRIPT = "[name] is rather accepting of [his] partners, having no issues with them having different body structures. Removes consent penalty from different body shape partners.",
	SEXTRAITDEVIANTDESCRIPT = "[name] has some deviant tastes, having no problem from engaging in lewd actions with animals and even undead. Removes consent penalty from animal and undead partners.",
	SEXTRAITGROUPDESCRIPT = "[name] accepts having multiple partners at once as a natural thing. Removes consent penalty from group actions.",
	SEXTRAITSHAMELESSDESCRIPT = "[name] does not mind being observed by others while having sex. Removes consent penalty from being observed. Makes intimate actions during dating acceptable outside of bedroom. ",
	SEXTRAITANALDESCRIPT = "[name] does not experience prejudice or disgust from anal sex. Removes consent penalty from anal actions.",
	SEXTRAITBREASTSDESCRIPT = "[name] experience additional pleasure from actions involving breasts. Breast related actions: +50% Lust and Arousal.",
	SEXTRAITMASOCHISTDESCRIPT = "[name] experience unusual pleasure from being punished. Arousal from receiving punishments is increased by 50%. ",
	SEXTRAITSADISTDESCRIPT = "[name] experience unusual pleasure from punishing others. Arousal from giving punishments is increased by 50%. ",
	SEXTRAITSUBMISSIVEDESCRIPT = "[name] finds pleasure and comfort in being forced into things by others. Submissive positions arousal is increased by 20% ",
	SEXTRAITDOORMATDESCRIPT = "[name] is very poor when dealing with sexual advances. Lack of consent does not reduce Obedience and won't make [name] fight back.",
	SEXTRAITDOMINANTDESCRIPT = "[name] enjoys being in a leading role. Dominating positions arousal is increased by 20%.",
	SEXTRAITNYMPHOMANIADESCRIPT = "[name] is perpetually horny, always ready for sex, even if it is not in [his] interest... Starts in Horny state.",
	SEXTRAITHYPERSENSITIVEDESCRIPT = "[name]'s body is unreasonably sensitive. Can orgasm from any physical action. ",
	SEXTRAITLEWDNESS_AURADESCRIPT = "[name] has an unusual aura around [him], making everyone participating slightly more aroused every turn. ",
	SEXTRAITBOTTLE_FAIRYDESCRIPT = "[name] has a taste for alcoholic beverages. While Drunk or Tipsy all Arousal is increased by 30%.",
	SEXTRAITIRRESISTIBLEDESCRIPT = "[name] is adored by anyone around [him]. Increases Consent for all [his] partners.",
	SEXTRAITBEDROOM_PRODIDGYDESCRIPT = "[name] is an excellent learner when it comes to sex practices. Sex Skill gain is increased by 50%. ",
	SEXTRAITPUSHOVERDESCRIPT = "[name] is a coward in nature and easily learns to do what [he] is told. Consent gain after sex is increased by 50%. ",
	SEXTRAITTEACHERDESCRIPT = "[name] has a talent to make [his] partners develop their sex skills faster. Partners' Sex Skill gain is increased by 50% (does not stack)",
	SEXTRAITDESIREDDESCRIPT = "[name] is extremely attractive, making [his] partners more excited. Partners' Arousal is increased by 25%.",
	SEXTRAITCURIOUSDESCRIPT = "While [name] is interested in sex, [he]'s actually learning more than just it. Sex Encounters give 25% more experience.",
	SEXTRAITLIFE_POWERDESCRIPT = "Sex is refreshing to [name]. Recovers 10 health per orgasm after sex interaction. ",


#	SEXTRAITGROUPDESCRIPT = "[name] likes handling multiple partners at once. Group actions give 33% more lust and arousal. ",
#	SEXTRAITLIKES_SHORTSTACKSDESCRIPT = "[name] prefers shorter partners. Actions with Petite or smaller characters give 25% more Arousal and Lust.",
#	SEXTRAITLIKES_BEASTSDESCRIPT = "[name] prefers beasty partners. Actions with beastkin or halfkin races give 25% more Arousal and Lust.",
#	SEXTRAITLEWDNESS_AURADESCRIPT = "[name] has an unusual aura around [him], making everyone participating slightly more aroused every turn. ",
#	SEXTRAITBISEXUALDESCRIPT = "[name] has fully accepted drowning in sexual pleasure with any gender. Removes penalty from same-sex actions.",
#	SEXTRAITDEVIANTDESCRIPT = "[name] is ready to go to the lengths normal people wouldn't usually go. Removes penalty from actions with animals and undead. ",


	DIALOGUEESCAPETEXT = "[name] has escaped from your custody. Perhaps you should have focused on their loyalty or behavior more.",
	DIALOGUEESCAPECLOSE = "This is unfortunate",
	LOSE_MESSAGE = "Sadly, it seems that your reign is over.",
	LOSE_MONEY_MESSAGE = "You've ran out of gold. Sadly, it seems that your reign is over.",

	DIALOGUECLOSE = "Close",
	DIALOGUECONFIRM = "Confirm",
	DIALOGUECONTINUE = "Continue",
	DIALOGUECANCEL = "Cancel",

	DIALOGUECHILDBIRTHTEXT = "[name] has given birth to a healthy child. Do you wish to keep it?",
	DIALOGUEKEEPBABY = "Keep baby",
	DIALOGUEINSPECTBABY = "Inspect future baby",
	DIALOGUEREMOVEBABY = "Leave it at an orphanage",

	DIALOGUERECRUIT = "You stand before [name], who was captured and now awaits for [his] destiny. You can try to persuade [him] to join you willingly or simply turn [him] into slave.",
	DIALOGUERECRUITCHOOSEPERSON = "Choose Negotiator",
	DIALOGUERECRUITENSLAVE = "You decide to not endorse into any negotiations and simply make [him] your slave against [his] will.",
	DIALOGUERECRUITGOOD = "Your entrusted servant successfully managed to persuade [name] into serving you.",
	DIALOGUERECRUITGOODSLAVE = "Make Slave",
	DIALOGUERECRUITGOODSERVANT = "Make Peon",
	DIALOGUERECRUITFORCEATTEMPT = "Enslave",
	DIALOGUERECRUITATTEMPT = "Attempt to Recruit",
	
	DIALOGUERECRUITBAD = "Your entrusted servant failed to persuade [name] into serving you... With no other option you enslave [him] resisting.",
	
	
	DIALOGUEMEET = "Your servants have found a potential recruitee, [name], who seems to be interested in joining your household. ",
	DIALOGUEMEETBAD = "You've failed to persuade [name] and [he] bids you a farewell.",
	DIALOGUEMEETGOOD = "After a discussion [name] agrees to become your follower. ",
	DIALOGUEMEETGOODDEFAULT = "Add to roster as Peon",
	DIALOGUEMEETGOODHIRELING = "",
	
	
	
	DIALOGUERANDOMBOSSDEFEAT = "The defeated [name] lies before you. Recruiting [him] does not seem very realistic, so you will have to enslave [him]...",
	DIALOGUERECRUITBOSSOPTION = "Take into custody",
	DIALOGUEEXECUTEOPTION = "Execute",
	DIALOGUEDUNGEONQUESTCOMPLETE = "You have completed your mission on clearing [dungeonname]. Claim your reward at Mansion Quest Panel. ",
	DIALOGUELOCATIONQUESTCOMPLETE = "You have solved the requested issue. Claim your reward at Mansion Quest Panel. ",

	DIALOGUELOCATIONEVENT = "You can scout the settlement for opportunities. This action can only be done once a day. Your reputation will change depending on your actions and can alter the outcome. ",

	DIALOGUELOCATIONEVENTGOOD = "Lawful",
	DIALOGUELOCATIONEVENTEVIL = "Misbehave",

	DIALOGUEATTACKMIMIC = "Attack Mimic",
	DIALOGUEMIMICOPENANYWAY = "Open Anyway",

	DIALOGUEMISSIONCOMPLETE = 'Your group have completed the task and returns to mansion. ',

	
	SPECIAL_ACTION_CLASS = "Special Action (requires unknown class)",
	DIALOGUECHARINSPECT = "Inspect",
	DIALOGUERECRUITCHARACTEROPTION = "Recruit",
	DIALOGUELEAVE = "Leave",
	DIALOGUELEAVERECRUITOPTION = "Cancel (abandons recruit)",
	DIALOGUEEVENTNOTHING = "After searching around you weren't able to find anything of interest...",
	DIALOGUEEVENTGOODRECRUIT = "After scouting through [locationname], you've heard the rumors of a person, willing to join you. After a couple of moments you find [name], [age] [raceadj], who seems willing to leave this place. ",
	DIALOGUEEVENTGOODLOOT = "After searching surroundings, you find a small locked cache. ",
	DIALOGUECHESTOPEN = "Open",
	DIALOGUETAKELOOT = "Take",
	DIALOGUEAPPROACHSHRINE = "Approach Shrine",
	DIALOGUESHRINECHOOSEPERSON = "Select another character",
	DIALOGUESHRINEITEM = "Make an offering",
	DIALOGUESHRINECHARACTER = "Offer [name] to altar",
	DIALOGUESHRINEDESTROY = "Demolish Shrine",
	DIALOGUECHESTLOCKPICK = "Attempt to Lockpick",
	DIALOGUECHESTLOCKPICKFAILURE = "[name] has failed to pick lock's chest and the mechanism has jammed. There's no other option, but to leave it now...",
	DIALOGUELOCKPICKALARMFAILURE = "[name] has failed to pick the lock and caused the alarm to go off. In a few moments enemies charge at your position.",
	DIALOGUECHESTLOCKPICKBOMBFAILURE = "[name] has triggered the bomb trap mechanism causing an explosion and damaging everyone in the room. The chest is destroyed with its contents...",
	DIALOGUECHESTLOCKPICKGASFAILURE = "[name] has triggered the trap mechanism. The room fills with poisonous gas and the group quickly retreats from it. However, [name] has still inhaled too much of a gas due to being too close to the chest...",
	DIALOGUECHESTMIMICDISCOVERED = "As [name] approaches the chest in the last moment [he] spots something unusual about it. After another moment [he] informs that this is most likely to be not a chest, but Mimic. ",
	DIALOGUECHESTMIMICTRAPPED = "As [name] leans on the chest, [he] quickly realizes that it's not a chest, but a Mimic, which is about to devour [him]. Being stuck in his mucous, [he] won't be able to escape, unless helped. \n\n{color=aqua|[name]} — {random_chat_active|mimic_eat}\n\n[He] will certainly be eaten if left in this state.",
	DIALOGUECHESTEROTICMIMICTRAPPED = "As [name] leans on the chest, [he] quickly realizes that it's not a chest, but a Mimic, which is about to devour [him]. However, the Mimic does not seem to be harming [him], rather seizing its prey and getting under [his] clothes. With no outside help Mimic will surely have its way with [name]...\n\n{color=aqua|[name]} — {random_chat_active|mimic_rape}\n\nLeaving [him] in this state won't likely kill [him], but...",
	DIALOGUECHESTMIMICTRAPPEDLEAVE = "You decide it's too dangerous to challenge the Mimic and leaving [name] to him is an acceptable price...\n\n{color=aqua|[name]} — {random_chat_active|mimic_leave}",
	DIALOGUECHESTMIMICEROTICTRAPPEDLEAVE = "You decide it's too dangerous to challenge the Mimic and leaving [name] to him is an acceptable price...\n\n{color=aqua|[name]} — {random_chat_active|mimic_erotic_leave}\n\nAfter about an hour of erotic moans and pleads [name] manages to free [him]self and escape.",
	DIALOGUECHESTLOCKPICKSUCCESS = "[name] has skillfully picked the chest's lock and its contents belong to you now. ",

	DIALOGUECHESTMIMICFIGHT = "Fight Mimic",
	DIALOGUECHESTMIMICLEAVE = "Leave Mimic alone",

	DIALOGUEEVENTTRAP = "You come across a trapped hallway. Someone will have to disarm it, by skill or their well-being...",

	DIALOGUEWOLVES_SKIRMISH_START = "You find the location of the wolves which were reported by the locals. ",
	DIALOGUEFIGHTOPTION = "Fight",
	DIALOGUEREBELS_SKIRMISH_START = "You find the group of rebels which has been reported by locals. It seems they are ready to fight you.",
	DIALOGUEGOBLINS_SKIRMISH_START = "You find the group of goblins which has been reported by locals. It seems they are ready to fight you.",
	DIALOGUEOGRE_SKIRMISH_START = "You find the ogre report by local. It has companions",
	DIALOGUETROLL_SKIRMISH_START = "You find the troll reported by locals",

	DIALOGUESHRINECELENA = "You come across a religious structure: a small shrine made of light metal. It seems to be rather worn, but you can make out a symbol of moon engraved on a side of it. Despite being located at such place, you still feel a faint power around it. ",
	DIALOGUESHRINEEREBUS = "You come across an unsual assemblence of stones: a small uneven pyramid which has a sizable hole on top. Despite its rough appearance, you can feel a faint power around it.",
	DIALOGUESHRINEFREYA = "You find an unusual wooden structure: a beautiful female figure. What especially stands out, is it seems it wasn't carved but rather has grown into such shape. You can feel a faint power around it. ",


	DIALOGUESLAVERPURCHASE = "Purchase",
	DIALOGUEEVENTGOODSLAVERS = "You come across a group of slavers returning from the elven lands. With them you spot a captured [age] [male] [race] to be sold later at the local market. \n\nThey are ready to part with [him] for a reasonable price of [price] gold. \n\nThe [race] gives you a desperate look. ",
	DIALOGUEEVENTGOODSLAVERSACQUIRED = "Now you're left alone with the [race_short] [boy]. Still uncertain about [his] future, [he] pleads for your mercy. ",
	DIALOGUESLAVERSPURCHASE = "Purchase",
	DIALOGUEREQUESTSLAVE = "Lie to convince the merchants to forfeit the slave to you",
	DIALOGUEEVENTSLAVERSNEGOTIATESUCCESS = "[center]{color=green|Success!}[/center]\n[name] tells them that slave trafficking from the Elven lands is outlawed and they will have to be arrested for it. After a small pause the slavers leave the captured [race] behind and quickly retreat. ",
	DIALOGUEEVENTSLAVERSNEGOTIATEFAILURE = "[center]{color=red|Failure!}[/center]\n[name] wasn't able to trick theslavers into leaving the slave to you. They leave in a hurry.",
	DIALOGUEKEEPSLAVEPERSON = "Keep as slave",
	DIALOGUESETFREEPERSON = "Set free",
	DIALOGUEEVENTPERSONFREE = "You've set [name] free. [He] expresses [his] gratitude and wishes to repay you one day. ",
	DIALOGUEEVENTEXOTICTRADER = "You find an exotic slave trader with a large group of guards. Exotic race slaves are rare and expensive, so you should consider yourself lucky. After greetings he presents you his belongings.",


	DIALOGUEALIRONEXOTICTRADER = "This morning you've received a message that today Avermik came to town. An mysterious slave trader which deals with rare and exotic races. They seem to recurringly visit Aliron and might provide a reliable way to seize on an unusual slave. \n\nIf you have enough cash...",

	DIALOGUEPERSONASKTOJOIN = "Offer to join",
	DIALOGUERECRUITSUCCESS = "[center]{color=green|Success!}[/center]\n[name] was able to convince [scncharname] to join you.",
	DIALOGUERECRUITFAILURE = "[center]{color=red|Failure!}[/center]\n[name] wasn't able to convince [scncharname] to join you.",

	DIALOGUEEVENTTRAPSUCCESS = "[center]{color=green|Success!}[/center]\n[name] skillfully disarms the trap.",
	DIALOGUEEVENTTRAPFAILURE = "[center]{color=red|Failure!}[/center]\n[name] has disarmed the trap in a rough manner, suffering damage in the process.",
	DIALOGUEACTIVATETRAP = "Deactivate Trap",

	DIALOGUEDUNGEONCHEST = "You find a locked chest. ",
	DIALOGUEDUNGEONARMORY = "You find a locked armory, which might have something useful in it.",
	DIALOGUEEVENTDUNGEONLOOT = "After making into the last room, you find the main storage with the most prized possessions. ",

	DIALOGUEGROVEWOOD = "You find a stash of prepared wood likely abandoned by some lumberjacks. ",
	DIALOGUEGROVELEATHER = "You find a stash of hidden leather probably left by poachers. ",
	DIALOGUECRYPTBONES = "You find a pile of perfectly preserved bones. ",

	DIALOGUEEVENTDUNGEONPRISONER = "You come across a jail room holding a bound [race] [male], likely held by the bandits for ransom or mockery. At your approach [he] tells you [his] name is [name] and begs you for help.",
	DIALOGUETAKESLAVE = "Capture and enslave",
	DIALOGUEEVENTDUNGEONPRISONERSENSLAVE = "You release [name] from [his] cell, only to turn [him] into your slave. As [he]'s escorted back to your mansion, your team continues on. ",

	DIALOGUEEVENTDUNGEONPRISONERFREE1 = "You release and unbind [name], much to [his] relief. As [he] thanks you, [he] shows you a small cache of resources near [his] cell as thanks for [his] rescue. After explaining to [him] how to get out, you are ready to continue on your way.",
	DIALOGUEEVENTDUNGEONPRISONERFREE2 = "You release and unbind [name], much to [his] relief. As [he] thanks you, [he] shows you a secret item [he] has hidden in [his] cell as thanks for [his] rescue. After explaining to [him] how to get out, you are ready to continue on your way.",

	DIALOGUEEVENTGOBLINFRIENDLY = "As you make your way through the caves you find an isolated room. As you barge in, a lone goblin [boy] jumps in fear. \n\n— Wait, wait, please don't kill me! I'm not wanna fight, I'm only here accidently. I won't tell anyone I've seen you, I promise.\n\nSurprised by the fact [he] knows common speech and is civilized unlike others you consider what to do with [him].",
	DIALOGUEEVENTGOBLINRECRUIT = "Attempt to recruit",
	DIALOGUEEVENTGOBLINBRINGTOLEADER = "Request getting you to the leader",
	DIALOGUEEVENTGOBLINKILL = "Kill",
	DIALOGUEEVENTGOBLINCAPTURE = "Capture",
	DIALOGUEEVENTGOBLINLEAVE = "Let go",
	DIALOGUEEVENTGOBLINRECRUITSUCCESS = "[center]{color=green|Success!}[/center]\n— Eh?.. You want me to work for you? Well, I can't refuse someone big and strong like you, can I? I mean, I'll gladly take your offer! This place is a big ass dump after all.\n\nAfter [name] received instructions, [he] quickly disappeared in the way of your mansion.",
	DIALOGUEEVENTGOBLINRECRUITFAILURE = "[center]{color=red|Failure!}[/center]\n— Eh?.. I... don't think this is a good idea, we don't take betreyals nicely, ya know. Now, if you excuse me...\n\nBefore you can react, the goblin [boy] disappears from sight in one of the tunnels you didn't notice on entrance.",
	DIALOGUEEVENTGOBLINBRINGTOLEADERSUCCESS = "[center]{color=green|Success!}[/center]\n— You actually serious?! I-I guess someone like you can do that... Okay, fine, I'll show you the way, but after this you won't see me anywhere close to it. You got me? \n\nAfter a few minutes of getting through cave maze, you end up before the entrance of the room which seems to lead to the local goblin leader. Before you can notice, the goblin is already disapparead from sight.",
	DIALOGUEEVENTGOBLINBRINGTOLEADERFAILURE = "[center]{color=red|Failure!}[/center]\n— This... This is unreasonable ya know, I'm not out of my mind yet. If you are so willing to die, don't drag me in. \n\nAs [he] was talking [he] moved to the position and darted from the room before you could react. ",
	DIALOGUEEVENTGOBLINCAPTUREREPLY = "You figure that civilized goblin can be a useful tool or net some profit on the market. Without giving [him] a second chance, you seize [him].\n\n— Hey, what the {^fuck:hell} are you {^doing:thinking}?! Let me go!.. You bastards!",
	DIALOGUEEVENTGOBLINKILLREPLY = "You can't risk any suspicious goblin leave, let alone warn others. Before [he] can react, your group strike [him] down. Unfortunately, there's nothing else of interest here.",
	DIALOGUEEVENTGOBLINLEAVEREPLY = "There's no need to dispose of a friendly goblin even at a place like this. You allow [him] to go free which brings a relief on [his] face.\n\n— That's great! I'll see myself off. Best of luck to you, guys!",
	DIALOGUEEVENTFAIRYFRIENDLY = "As you make it through the woods, a lone Fairy jumps in front of you. [He] seems to be curious from meeting someone [he] never seen before. \n\n— Hey, what are you doing here? I've never seen you before... \n\n[He] seems to be willing to stick with you out of boredom or curiosity at least for a chat.",
	DIALOGUEEVENTFAIRYRECRUIT = "Attempt to recruit",
	DIALOGUEEVENTFAIRYCAPTURE = "Capture",
	DIALOGUEEVENTFAIRYASKHEAL = "Ask for heal",
	DIALOGUEEVENTFAIRYLEAVE = "Leave",
	DIALOGUEEVENTFAIRYRECRUITSUCCESS = "[center]{color=green|Success!}[/center]\n— Adventures?... This sounds fun. Okay, I like you, I wanna see the world!\n\n[scncharname] decides to join your team.",
	DIALOGUEEVENTFAIRYRECRUITFAILURE = "[center]{color=red|Failure!}[/center]\n— Sorry, I don't understand. I think I better go now, bye!\n\nUnfortunately, [name] wasn't able to convince the fairy to join you. Perhaps [he] needs more practice... The fairy quickly disappared in the woods.",
	DIALOGUEEVENTFAIRYASKHEALREPLY = "— Oooh, you are wounded? Sure, I'll help you!\n\n[His] magic recovers some wounds of your group and [he] happily leaves after receiving your thanks.\n\nAll party recovers 35% HP.",
	DIALOGUEEVENTFAIRYCAPTUREREPLY = "Before [he] can react, your group quickly pins [him] down.\n\n— Hey, wha-. Stop! What are you doing!? Let me go!!\n\nAs the [boy] is made your slave, [he] can be a very useful addition to your roost or net a good sum from the collectors.",
	DIALOGUEVENTFAIRYLEAVEREPLY = "After chatting for a bit you part your ways with fairy. ",
	
	
	DIALOGUETUTELAGETEXT = "You decided to keep the newborn child, however you have to decide on its future education which might improve or correct their potential. In either way growing up will take 2 weeks.\n\n{color=aqua|No Training}— {color=yellow|No cost}, but has chance to obtain a new negative trait;\n{color=aqua|Slave Training}— {color=yellow|500 gold}, provides a large boost to Loyalty with a chance to improve Tame or Timid factors;\n{color=aqua|Academy}— {color=yellow|1500 gold}, provides a boost to Physics and Wits and a good amount of EXP;\n{color=aqua|Heir Education} (only for potential Heirs)— {color=yellow|5000 gold}, provides boost to all stats and factors, large amount of EXP and 1 random positive trait.",
	
	DIALOGUETUTNOTHING = "No Training (free)",
	DIALOGUETUTSLAVE = "Slave Training (500 Gold)",
	DIALOGUETUTACADEMY = "Academy (1500 Gold)",
	DIALOGUETUTHEIR = "Heir Education (5000 Gold)",
	
	SPRINGTEXT = "You find a small clearing with a spring. It might be a good time to take a break and rest.",
	SPRING_HEAL = "Your group rests and restores some health.",
	SPRING_HEAL_OPTION = "Rest",
	SPRING_LOOT_OPTION = "Search around",
	DIALOGUE_SPRING_LOOT = "After searching around you find a small buried stash. You decide to take its contents for yourself.",
	DIALOGUE_SPRING_NO_LOOT = "You search around but weren't able to find anything useful.",
	TRIBALELVES = "You find yourself surrounded by a group of local tribal elves. It seems they consider you an intruder on their territory and preparing for attack...",
	TRIBALELVES_WIN = "As you defeat the attackers, they hastily retreat, yet one of them was left behind and your party manages to subdue them.",


	DIALOGUEEVENTGOODREBELSBEAST = "You come across a small group of rebels, who have caught a [race] [male] that likely strayed from their homelands. Given the rebels' attitude towards [him] it's easy to see they are up to no good...",
	DIALOGUEEVENTREBELSBEASTINTIMIDATESUCCES = "[center]{color=green|Success!}[/center]\n[name] has successfully intimidated a group of rebels into fleeing, leaving their victim behind.", #to rework
	DIALOGUEEVENTREBELSBEASTINTIMIDATEFAILURE = "[center]{color=red|Failure!}[/center]\n[name] hasn't managed to intimidate the rebels and they are preparing to attack you. ",

	DIALOGUEINTIMIDATE = "Intimidate",


	LOCAL_SHOP = "Shop",
	LOCAL_EVENTS_SEARCH = "Search",

	RETURNTOMANSIONBUTTON = "Send character back to the Mansion",
	RETURNCHARACTERCONFIRM = "Order [name] to return to the mansion immediately?",


	LOCATIONNAMESKIRMISH_BANDIT_CAMP = "Bandit Camp",
	LOCATIONNAMESKIRMISH_FOREST_WOLVES = "Forest",
	LOCATIONNAMEDUNGEON_BANDIT_DEN = "Bandit Den",
	LOCATIONNAMEDUNGEON_BANDIT_FORT = "Bandit Fort",
	LOCATIONNAMEDUNGEON_GROVE = "Grove",
	LOCATIONNAMEDUNGEON_GOBLIN_CAVE = "Goblin Cave",
	LOCATIONNAMEDUNGEON_UNDEAD_CRYPT = "Crypt",
	LOCATIONNAMEDUNGEON_MOUNTAINS = "Mountain Cave",
	LOCATIONNAMEDUNGEON_VOLCANO = "Volcanic Cave",
	LOCATIONNAMEDUNGEON_CITY = "Ruined City",
	LOCATIONNAMEBASIC_THREAT_WOLVES = "Skirmish",
	LOCATIONNAMEDUNGEON_ANCIENT_JUNGLES = "Ancient Jungles",
	LOCATIONNAMEDUNGEON_FIRE_DEPTHS = "Fire Depths",
	LOCATIONNAMEDUNGEON_FROZEN_DOMAIN = "Frozen Domain",
	LOCATIONNAMEDUNGEON_DRAGON_NEST = "Dragon Nest",
	LOCATIONNAMEDUNGEON_QUEST_MINES_DUNGEON = "Mines",
	LOCATIONNAMEQUEST_FINAL_OPERATION_LOCATION = "Rebels' Hideout",
	LOCATIONNAMEQUEST_GRYPHON_FOREST_LOCATION = "Gryphon Thicket",
	LOCATIONNAMEQUEST_GRYPHON_LAIR_LOCATION = "Elder Grypho Lair",
	LOCATIONNAMEQUEST_RITUAL_LOCATION = "Herbs Field",
	LOCATIONNAMEQUEST_LEON_FOREST = "Leon's location",
	LOCATIONNAMEQUEST_LEON_FOREST_2 = "Leon's location",
	LOCATIONNAMEQUEST_CALI_BANDITS_LOCATION = "Bandits' Hideout",
	LOCATIONNAMEQUEST_MINES_DUNGEON = "Mines",

	SETTLEMENT = "Settlement",
	SETTLEMENT_SMALL = "Village",
	SETTLEMENT_LARGE = "Town",
	SETTLEMENT_PLAINS1 = "Settlement",
	SETTLEMENT_PLAINS2 = "Settlement",
	SETTLEMENT_PLAINS3 = "Settlement",
	SETTLEMENT_PLAINS4 = "Settlement",

	DUNGEONDIFFICULTY = "Difficulty",
	DUNGEONDIFFICULTYEASY = "Easy",
	DUNGEONDIFFICULTYMEDIUM = "Medium",
	DUNGEONDIFFICULTYHARD = "Hard",

	ENEMYBANDIT_MELEE = "Bandit",
	ENEMYBANDIT_ARCHER = "Ranged Bandit",
	ENEMYBANDIT_MAGE = "Bandit Mage",
	ENEMYBANDIT_BOSS = "Bandit Boss",
	ENEMYRAMONT_BOSS = "Ramont",
	ENEMYHECTOR_BOSS = "Hector",
	ENEMYREBEL_RECRUIT = "Rebel Recruit",
	ENEMYREBEL_KNIGHT = "Rebel Knight",
	ENEMYREBEL_MAGE = "Rebel Mage",
	ENEMYREBEL_HEALER = "Rebel Healer",
	ENEMYCAVE_GOBLIN_MELEE = "Cave Goblin",
	ENEMYCAVE_GOBLIN_ARCHER = "Cave Goblin Archer",
	ENEMYCAVE_GOBLIN_MAGE = "Cave Goblin Mage",
	ENEMYCAVE_GOBLIN_BOSS = "Cave Goblin Boss",
	ENEMYOGRE_MELEE = "Ogre",
	ENEMYOGRE_MAGE = "Ogre Mage",
	ENEMYGRYPHON = "Gryphon",
	ENEMYELDER_GRYPHON_BOSS = "Elder Gryphon",
	ENEMYWOLF = "Wolf",
	ENEMYRAT = "Rat",
	ENEMYSPIDER = "Spider",
	ENEMYTRAINED_DOG = "Trained Dog",
	ENEMYTRAINED_BEAR = "Trained Bear",
	ENEMYTRAINED_RAPTOR = "Trained Raptor",
	ENEMYGUARDIAN_GOLEM = "Guardian Golem",
	ENEMYZOMBIE = "Zombie",
	ENEMYSKELETON_MELEE = "Skeleton",
	ENEMYSKELETON_ARCHER = "Skeleton Archer",
	ENEMYLICH_QUEST = "Lich",
	ENEMYUNDEAD_LICH = "Lich",
	ENEMYMIMIC = "Mimic",
	ENEMYBALLISTA = "Ballista",
	ENEMYTROLL = "Troll",
	ENEMYBANDIT_ASSASSIN = "Bandit Assassin",

	ENEMYDEMONESS = "Demoness",
	ENEMYGREG = "Greg",
	ENEMYAIRE = "Aire",
	ENEMYKURDAN = "Kurdan",
	
	ENEMYLEON = "Leon",
	ENEMYWHITE_STAG = "White Stag",
	ENEMYWHITE_STAG_HUMAN = "Mysterious Person",
	ENEMYELF_SPECTER = "Elf Specter",
	ENEMYELF_SOLDIER = "Elven Soldier",

	FOODFILTERHIGH = "High",
	FOODFILTERMED = "Med",
	FOODFILTERLOW = "Low",
	FOODFILTERDISABLE = "Forbid",

	USABLE = "Usable",

	SWITCHSTATS = "Individual Stats",
	SWITCHLIST = "Character List",

	SCENEDAISY_MEET_TEXT = "As you walk around the town, you hear some arguing. A large man yells at a crying young halfkin bunny girl sitting near some pottery shards.\n\n— You clumsy dumbass! This was the third time. I'm selling you to the brothel now, At least this way you will be useful at something.\n\nThe girl does not seem to be suited for manual labor, but is fairly appealing. ",
	SCENEDAISY_MEET_OPTION1 = "Offer to purchase the girl",
	SCENEDAISY_MEET_OPTION2 = "Demand the girl as your kinsman",
	SCENEDAISY_MEET_OPTION3 = "Ignore",
	SCENEDAISY_CLAIM_KINSHIPTEXT = "You tell the man that the girl is your kinsman and his behavior is unacceptable\n\nTaken aback by your interruption, he quickly falls back and passes her to you.\n\nThe girl seems relieved even though she saw through your lie. \n\nShe tells you that her name is Daisy and she will try her best for you. ",
	SCENEDAISY_PURCHASE_TEXT = "You offer to purchase the poor girl from the man. \n\nAfter some negotiations he offers you the price of 200 gold for her. ",
	SCENEDAISY_PURCHASE_OPTION1 = "Ask for a discount",
	SCENEDAISY_PURCHASE_OPTION2 = "Purchase (200 gold)",
	SCENEDAISY_PURCHASE_OPTION2_1 = "Purchase (100 gold)",
	SCENEDAISY_PURCHASE_OPTION3 = "Refuse",
	SCENEDAISY_PURCHASE_NEGOTIATE_TEXT1 = "With some additional haggling you manage to make the man drop his demand to 100 gold. But this is his final offer.",
	SCENEDAISY_PURCHASE_NEGOTIATE_TEXT2 = "Your further attempts to bring the girl's price down have failed and the man asks for 200 gold or tells you to bugger off.",
	SCENEDAISY_PURCHASE_CONFIRM_TEXT = "You pay the price and the bunny girl moves warily to your side. You learn that her name is Daisy.\n\nShe promises to do her best, but you can see she is clearly forcing herself to look up at you. ",
	SCENEDAISY_PURCHASE_LEAVE_TEXT = "You refuse the man's price and walk away from the scene.",
	SCENEDAISY_IGNORE_TEXT = "You continue your way without paying any further attention to them.",
	SCENEDAISY_FIRST_EVENT_TEXT = "You hear the crash and soon find Daisy, who seems to have destroyed a piece of tableware.\n\nTeary eyed she looks up at you waiting for your punishment. ",
	SCENEDAISY_FIRST_EVENT_OPTION1 = "Reassure her",
	SCENEDAISY_FIRST_EVENT_OPTION2 = "Discipline her",
	SCENEDAISY_FIRST_EVENT_REASSURE = "You help and encourage her to do better next time.\n\nTaken aback by your kindness, Daisy's expression poorly hides her inner happiness.",
	SCENEDAISY_FIRST_EVENT_DISCIPLINE = "You take a shivering Daisy into a private room.\n\nStarting with some pain and humiliation you gradually provide her body with new sensations.\n\nHer cries of pain slowly obtain new notes.\n\nAnd her teared eyes reflect not only a fear, but a drunk bliss.\n\nAfterwards you make sure she learned her lesson and she responds with respectful eagerness.",
	SCENEDAISY_CONFESS_EVENT_TEXT = "As you walk around the mansion, you notice Daisy looking depressed.\n\nYou approach her and ask what happened, but she worryingly dodges the question.\n\nAfter ordering her to tell you what's wrong she finally cracks up. \n\n— I... I love [master], but there's no way [he] will ever love someone useless like me. ",
	SCENEDAISY_CONFESS_EVENT_OPTION1 = "Accept her feelings",
	SCENEDAISY_CONFESS_EVENT_OPTION2 = "Refuse her",
	SCENEDAISY_CONFESS_ACCEPT_TEXT = "— N..No way! You feel the same?! I can't believe it...\n\nYou press your lips to Daisy and she gives in into your embrace.\n\nShe's hoping to spend this night with you.",
	SCENEDAISY_CONFESS_REFUSE_TEXT = "You politely refuse Daisy's proposal.\n\n— I see... But if that's too much for you, I could be your... night servant.\n\nIt seems Daisy still has some leftover hope to eventually win you over. ",

	SCENEDAISY_PURCHASE_WORKER_OPTION1 = "Point out her lack of strength will greatly impact her performance (Worker)",
	SCENEDAISY_PURCHASE_WORKER1 = "The owner begrudgingly agrees with your remark and cuts the price in half.",

	TUTORIAL_MAINSCREEN = "The center of your Mansion is the list of available characters before you. Click once to see details and skills available to selected character. You can view detailed info about them by double clicking or selecting \"Character Info\" in the left bottom corner. You can assign them to task by clicking on Occupation button. You can use their skills by selecting them at the bottom of the screen. ",


	TUTORIAL_SLAVEBASICS = "Characters are the centerpiece of the game, as they do all the work and fighting. All characters require food daily to sustain themselves, and they also have food preferences often related to their race. \n\nAll characters, besides the Master, must be constantly monitored. If character's Obedience drops to 0, they leave you and you lose them forever. To prevent that you can use social skills on them. The characters will also gain Loyalty with time which can be used to unlock vital bonuses and reduce Obedience drain.",
	TUTORIAL_LUST = "Lust is a special stat used by every character and is more akin to a resource like Mana. It slowly grows every day and can be utilized by certain skills to provide unusual effects. Some classes, like the Succubus/Incubus are focused on manipulating this resource. Besides growing naturally, Lust can be increased from sexual interactions, based on the number of orgasms reached.",
	TUTORIAL_SLAVEPANEL = "This is the character's detailed screen. Here you can see all of the visible stats and details.\n\nEvery character consists of a number of stats, some of which can be seen on the left. You can hover over them at any time to see details on them. \n\nAt the bottom left you can select items, unlock new classes and configure additional details like imported image.",
	TUTORIAL_CLASSES_AND_SKILLS = "Every character has access to multiple classes they can unlock. After a class is unlocked, a character receives its bonuses and can use its skills. Skills can be either social or combat, with social skills helping to manage characters' behavior. Many skills have no other cost than daily charges, so feel free to use them as often as needed. ",
	TUTORIAL_CHARACTER_SELECT = "After selecting skills or some other actions you will be able to select a target of said action, sometimes allowed to select multiple targets. Locations on the bottom of Slave List allows you to filter only characters in specific places.",
	TUTORIAL_TRAVELING_AND_LOCATIONS = "At the top of the screen you can see the list of locations your characters are currently dislocated in. Click on them to see their details. \n\n\"Travels\" menu allow you to select other locations and make characters travel to them. Travelling takes time but many resources can only be gathered from outside of town. ",
	TUTORIAL_LOCATIONS_RESOURCES = "Other locations allow to gather resources presented on them. Settlement type locations allow to gather resources infinitely, but have a limit on how many characters can gather it at once. Combat locations allow to gather a limited amount of resources after they've been cleared. ",
	TUTORIAL_TATTOO_1 = "Once you've unlocked Beauty Parlor, you can apply tattoos to your characters. Tattoos provide permanent bonuses and require ink crafted at Alchemy tab. To access Tattoo menu use the corresponding button at inventory screen.",
	TUTORIAL_TATTOO_2 = "Each tattoo type has certain bonuses, require special ink and apply to only selected bodyparts. Some might also have additional requirements. Tattoos can be removed or replaced but the ink is not refunded.",
	TRAVELINGTUTORIAL1 = "To travel to different locations select the location on the central list. You can limit the area of the locations at the dropdown menu. Different locations have different options for them.",
	TRAVELINGTUTORIAL2 = "On the right side you can see location details: villages allow trade and gather resources while dungeons can be explored for fights. After the dungeon is complete it also usually has resources to gather.",
	TRAVELINGTUTORIAL3 = "On the left side you can select the location which has your characters and serves as a starting point. Hit 'Confirm' after selecting the characters you've sent. ",
	JOBTUTORIAL1 = "At Occupations you can assign characters to various tasks which can be seen near the location image. At the top you can select other locations you have characters at.",
	JOBTUTORIAL2 = "At the bottom you can see occupation description and details. Hover over them to see more information.",
	JOBTUTORIAL3 = "On the right you can see the list of characters available at the present location. By clicking on them they will be assigned to the selected task.",
	
	
	TRAINTUTORIAL1 = "Every character besides Master will have to be trained with Loyalty Points. Loyalty points are acquired passively or by using social skills.",
	TRAINTUTORIAL2 = "Some traits make the management easier while other unlock new abilities. Every purchased trait will increase amount of Loyatly required for next purchase so consider your path.",
	
	COMBATSKILLSTUTORIAL = "Some combat skills can be learned automatically after purchasing certain classes. Besides that, they can be unlocked with Skill Points. Skill Points are obtained from combat. Many skills will require certain specilizations, which are obtained from classes.",
	MARRYTUTORIAL = "After resolving the civil war, you are able to marry one of your subordinates. Firstly, you'll have to get their agreement during the date. Then, proceed with wedding preparations from church. ",
	MARRY2TUTORIAL = "Your spouse will receive a new class. Their growth will be set to maximum and their obedience will no longer drain. Also your mutual children will be of status [color=aqua]Heir[/color], which will have them slower Obedience Drain and higher Loyalty Gain, however they receive penalty on Collection, Farming and Fishing. ",
	
	
	
	ITEMHAIRDYE = "Hair Dye",
	ITEMHAIRDYEDESCRIPT = "Allow you to change a person's hair color.",


	ITEMMINORUS_POTION = "Minorus Potion",
	ITEMMINORUS_POTIONDESCRIPT = "A special potion, which can be used to reduce a person's specific body part size. Can be used on Breasts, Butts, Penises and Balls.",
	ITEMMAJORUS_POTION = "Majorus Potion",
	ITEMMAJORUS_POTIONDESCRIPT = "A special potion, which can be used to grow a person's specific body part size. Can be used on Breasts, Butts, Penises and Balls.",
	ITEMEXP_SCROLL = "Scroll of Knowledge",
	ITEMEXP_SCROLLDESCRIPT = "Grants 100 points of experience to the user.",


	DIALOGUEEVENTMINORUSSELECT = "Select which body part of [name] should be reduced.",
	DIALOGUEEVENTMAJORUSSELECT = "Select which body part of [name] should grow.",
	DIALOGUEPOTIONNOEFFECT = "Unfortunately, this potion was entirely ineffective.",

	DIALOGUEMINORUSPOTTITS = "After Minorus Potion has been applied to [name]'s breasts, they reduce in size.",
	DIALOGUEMINORUSPOTASS = " After Minorus Potion has been applied to [name]'s butt, it reduces in size.",
	DIALOGUEMINORUSPOTPENIS = " After Minorus Potion has been applied to [name]'s penis, it reduces in size.",
	DIALOGUEMINORUSPOTBALLS = " After Minorus Potion has been applied to [name]'s balls, they reduce in size.",
	DIALOGUEMAJORUSPOTTITS = " After Majorus Potion has been applied to [name]'s breasts, they increase in size.",
	DIALOGUEMAJORUSPOTASS = " After Majorus Potion has been applied to [name]'s butt, it increases in size.",
	DIALOGUEMAJORUSPOTPENIS = " After Majorus Potion has been applied to [name]'s penis, it increases in size.",
	DIALOGUEMAJORUSPOTBALLS = " After Majorus Potion has been applied to [name]'s balls, they increase in size.",

	DIALOGUEOBLIVIONPOTUSE = "[name] gulps down on the Oblivion Potion. [He] staggers as previous memories leave [his] mind.",
	DIALOGUEPHEROMONESSELF_SUCCESS = "As [name] absorb the pheromones, a strong lust quickly overwhelms you.",
	DIALOGUEPHEROMONESSELF_FAIL = "Pheromones did not affected you in the slightest. ",
	DIALOGUEPHEROMONES_SUCCESS = "As [name] absorbs the pheromones, a strong lust quickly overwhelms [him]. Not sure what to do about it, [he] gives you a pleading look.\n\n{color=aqua|[name]}— {random_chat_active|aphrodisiac}",
	DIALOGUEPHEROMONES_FAIL = "[name] seems to be completely unaffected by pheromones. This seems to be a waste.",

	DIALOGUEWRIT_CONFIRM = "Using this Writ will liberate [name] from slavery, making [him] a peon. This, however, will allow [him] to leave your possession, if [he] wishes so.",
	DIALOGUEWRIT_SUCCESS = "[name] can't believe [his] eyes as [he] receive proof of [his] freedom from you. After a pause, [he] declares [his] willingness to continue to serve under your rule. \n\n{color=aqua|[name]} — {random_chat=0|writ_success}",
	DIALOGUEWRIT_FAILURE = "[name] can't believe [his] eyes as [he] receives proof of [his] freedom from you. However, after a long pause [he] takes this chance and decides to leave your retinue. \n\n{color=aqua|[name]} — {random_chat=0|writ_failure}",

	DIALOGUETITSSELECT = "Breasts",
	DIALOGUEASSSELECT = "Rear",
	DIALOGUEBALLSSELECT = "Balls",
	DIALOGUEPENISSELECT = "Penis",

	WORKRULERATION = "Extra Rations",
	WORKRULERATIONDESCRIPT = "Increases Food Consumption by 3. Boosts Productivity by 15%.",
	WORKRULESHIFTS = "Longer Shifts",
	WORKRULESHIFTSDESCRIPT = "Character overperforms at their finest capability at the cost of future improvements. \nBoosts Productivity by 25%. Character won't gain Experience or Work Stats(Physical, etc) while working. ",
	WORKRULECONSTRAIN = "Coerced Labor",
	WORKRULECONSTRAINDESCRIPT = "Character is forced to work at their best via strict regulations. Boosts productivity by 15%. Obedience Drain is increased by 6.",
	WORKRULELUXURY = "Private Room",
	WORKRULELUXURYDESCRIPT = "Character will have a personal room to live at. Obedience Drain -3, Loyalty Gain +0.5",
	
	WORKRULECONTRACEPTIVE = "Contraceptive",
	WORKRULECONTRACEPTIVEDESCRIPT = "Prevents pregnancy and impregnation for selected character.",
	
	SERVICEENSLAVE = "Enslave",
	SERVICEENSLAVEDESCRIPT = "Makes chosen character into a Slave.\n\n[color=aqua]Slaves suffer 10% damage reduction but gain various collection bonuses and but their Loyalty can be increased by punishing skills.[/color]",

	NEWGAMESETTINGINFO = "These settings can be changed in Options at any point in future",

	SETTINGFUTA_NAME = "Futa",
	SETTINGFUTA_DESCRIPT = "Allows random generation of futanari (dickgirl) characters.",
	SETTINGFURRY_NAME = "Furry",
	SETTINGFURRY_DESCRIPT = "Allows random generation of beastkin characters (replaced with halfkin otherwise if applicable).",
	SETTINGFUTA_BALLS_NAME = "Futa Balls",
	SETTINGFUTA_BALLS_DESCRIPT = "Defines if futa characters will have testicles when generated.",
	SETTINGFURRY_MULTIPLE_NIPPLES_NAME = "Extra Nipples for beastkin",
	SETTINGFURRY_MULTIPLE_NIPPLES_DESCRIPT = "Defines if furry characters will have extra non-developed breasts.",
	SETTINGFUTACHANCE_NAME = "Futa Chance",
	SETTINGFUTACHANCE_DESCRIPT = "Sets a chance that a randomly generated female will be a futanari.",
	SETTINGMALECHANCE_NAME = "Male Chance",
	SETTINGMALECHANCE_DESCRIPT = "Sets a chance that a character with no preset gender will become a male instead of female.",
	SETTINGMEOWING_NAME = "Meowing",
	SETTINGMEOWING_DESCRIPT = "Beastkin and Halfkin Cat characters will have slightly different speech patterns.",
	SETTINGTURN_BASED_TIME_FLOW_NAME = "Turn Based \nTime Flow",
	SETTINGTURN_BASED_TIME_FLOW_DESCRIPT = "Makes time flow into hour long turns.",


	#dialogues
	INTRODIALOGUE = "Twelve years have passed since the human kingdom was reformed into the Rousseu Republic. Free of the previous reign, its capital Aliron has become a center of society and cultural life, giving even the lowest a chance to become a person of power and influence assuming they are capable... \n\nYou are one of the people who managed to get there just in time to secure an estate recently freed from old ownership. The only issue is that its sale price is beyond your capability. With no other option to start a new life, you've taken a gigantic loan to achieve your goal. You've became an owner of a small piece of land with a dilapidated mansion on it.",

	STARTINGDIALOGUE0 = "Just as you finished moving in, the bank assistant appears at your doorstep to check on you.\n\n— Good morning, [Sir] [surname]. How do you like your new estate?",
	STARTINGDIALOGUE0REPLY1 = "It's great",
	STARTINGDIALOGUE0REPLY2 = "What a slum",
	STARTINGDIALOGUE0REPLY3 = "Just get to the point",
	STARTINGDILOGUE1_1 = "— I'm glad you like it.\n\n",
	STARTINGDILOGUE1_2 = "— It surely is.\n\n",
	STARTINGDILOGUE1_3 = "— Oh, a [man] of business? I like it.\n\n",
	STARTINGDILOGUE1_4 = "— I'm here to deliver the plan by which you will be paying your loan. In total, you owe the bank 100.000 gold which you will be required to pay in the next 100 days. As a handicap, your first payment will be consisting of 1.000 gold and is due in 2 weeks.",
	STARTINGDIALOGUE1REPLY1 = "Understood",
	STARTINGDIALOGUE1REPLY2 = "Are you seriously expecting me to make this much?",
	STARTINGDIALOGUE2_1 = "— Good. ",
	STARTINGDIALOGUE2_2 = "— No, we don't. We expect to get the land back once you go bankrupt, but as we don't have the resources to work on it yet, we can try something different. \n\n— ",
	STARTINGDIALOGUE2_3 = "If you have no more questions, I'll be off.",
	STARTINGDIALOGUE2REPLY1 = "How do I even make this much money?",
	STARTINGDIALOGUE2REPLY2 = "Is there something special about owning the land?",
	STARTINGDIALOGUE2REPLY3 = "What are the Guilds?",
	STARTINGDIALOGUE2REPLY4 = "I'm fine",
	STARTINGDIALOGUE3_1 = "— Certainly not by yourself. As a landowner you hold the right to employ others to work for you. I'd recommend sticking to one of the city's guilds at first. Each has its own trades and benefits so you can choose what you like. They pay well if you manage to complete their tasks. You will also be able to hire more people there, or you can try your luck at the slave market.",
	STARTINGDIALOGUE3_2 = "— Oh, you don't know? Twelve years ago, after the revolution happened and the Monarchy was overthrown, all of the land became public property to buy or sell. Since nobles no longer held exclusive right of land possession, lots of it was sold to the rich. Now the Guilds hold the greatest amount of wealth and political power as they are closely tied with the landowners.",
	STARTINGDIALOGUE3_3 = "— The Guilds are the establishments which provide connections for business partners, buyers, requests and so on. There are Fighters, Mages, Workers and Servants, each specialize in different aspects. You can learn more once you go meet them.",
	STARTINGDIALOGUE3REPLY1 = "How do I even make this much money?",
	STARTINGDIALOGUE3REPLY2 = "Is there something special about owning the land?",
	STARTINGDIALOGUE3REPLY3 = "What are the Guilds?",
	STARTINGDIALOGUE3REPLY4 = "I'm fine",
	STARTINGDIALOGUE4_1 = "— I will return in two weeks then.",
	FIGHTERSINTRODUCTION1 = "A large man equipped in heavy armor gives you a disinterested look. \n\n— What is it? If you are looking for work, you'll have to register as a combatant first. I don't deal with recruits. ",
	FIGHTERSINTRODUCTION1REPLY1 = "You are mistaken, I'm not a recruit",
	FIGHTERSINTRODUCTION1REPLY2 = "I'm a new landowner, show some respect",
	FIGHTERSINTRODUCTION2_1 = "— Oh, excuse me then. Landowners usually look... Not quite like this.\n\n",
	FIGHTERSINTRODUCTION2_2 = "— Hmph, is that so?.. Fine, pardon my rudeness.\n\n",
	FIGHTERSINTRODUCTION2_3 = "— So you are new one? Name's Duncan. You must be interested in fighting along with us then. That's a smart decision. Our core has been formed from the mightiest of the Black Knights there is no one better suited for combat. \n\nCombat, guard duty, peacekeeping, dealing with monsters or rebels, we do it all. ",
	FIGHTERSINTRODUCTION2_3_1 = "And naturally we offer our best fighters for hire. Since you are a new landowner, we offer you a free recruit if you side with us first.",
	FIGHTERSINTRODUCTION2_4 = "— You are back. So, what have you decided?",
	FIGHTERSINTRODUCTION2_5 = "— You are back. Has something happened?",
	FIGHTERSINTRODUCTION2_6 = "— If there's nothing else, I'll have to return to my business.",
	FIGHTERSQUESTIONREPLY1 = "What are the Black Knights?",
	FIGHTERSQUESTIONREPLY2 = "What are those rebels?",
	FIGHTERSQUESTIONREPLY3 = "Can you give me some tips?",
	FIGHTERSINTRODUCTION2REPLY1 = "I'll side with you",
	FIGHTERSINTRODUCTION2REPLY2 = "I'll come back later",
	FIGHTERSQUESTIONS_1 = "— What is it?",
	FIGHTERSQUESTIONS_2 = "— Black Knights were the kingdom's elite troops at the time... when there was a kingdom. We served it with honor until the very end, but as the kingdom was reformed, we also reformed into a more national force. Most of us, anyway.",
	FIGHTERSQUESTIONS_3 = "— Despite 12 years having passed, there are still some sprouts of rebellion by the sympathizers of the Deranged King. Those fools aren't formidable in any way, yet they tend to cause problems here and there. Their efforts are foolish if you ask me. The royal family has been executed, so it's impossible for them to return to the old ways anyway.",
	FIGHTERSQUESTIONS_4 = "— Hmm... If you aren't strong enough, make sure to bring extra people with you. Dungeons can be a great source of wealth but can be deadly when approached unprepared. Make sure you have some healing options with you, be it mages or items. Gear is also a must when dealing with anyone stronger than a couple of rats. \n\nMost importantly, learn your enemy's weakness and try to match it. Even beginner Fighters have some elemental attacks which can deal a lot more damage.",
	FIGHTERSJOIN = "— Great. My helper will show you our best recruits. ",
	FIGHTERSCLOSE1 = "— Understood. You know where you can find us, once you make up your mind. ",
	FIGHTERSCLOSE2 = "— ...Tread carefully. ",
	FIGHTERSASKQUESTIONS = "Can I ask some questions?",
	FIGHTERSASKQUESTIONSRETURN = "That's all",
	FIGHTERSINTRODUCTION2REPLY5 = "*Present Skull to Duncan*",
	FIGHTERSINTRODUCTION2REPLY6 = "About Reim...",
	FIGHTERSINTRODUCTION2REPLY7 = "Sigmund sent me...",
	WORKERSINTRODUCTION1REPLY6 = "Duncan promised to provide the payment asap",
	SERVANTSINTRODUCTION1REPLY5 = "I'm ready for elections",


	SERVANTSINTRODUCTION1 = "A lithe young-looking catgirl approaches you as if she figured your intentions.\n\n— Welcome, [Sir] [name]. My name is Amelia. How do you enjoy our institution? Please, don't be so surprised, we are well aware that you've just become a landowner and are looking for our future cooperation. Here at the Servants Guild we are ready to provide you with finest and prettiest toys in all of the Republic. We also are in touch with many rich and powerful people of the city. ",
	SERVANTSINTRODUCTION1_1 = "As a newcomer we would be happy to provide you with one free servant of your choice if you side with us.",
	SERVANTSQUESTIONREPLY1 = "So basically all you do is operate an elaborate sex service?",
	SERVANTSQUESTIONREPLY2 = "How exactly am I useful to you?",
	SERVANTSQUESTIONREPLY3 = "Can you give me some tips?",
	SERVANTSINTRODUCTION1REPLY3 = "I'll side with you",
	SERVANTSINTRODUCTION1REPLY4 = "I'll come back later",
	SERVANTSQUESTIONS_1 = "— Absolutely! What would you like to know?",
	SERVANTSQUESTIONS_2 = "— Hahaha, you underestimate how important an elaborate sex service can be. We don't provide 'only' sex service, we train diligent trainees which can do anything you might want. Cleaning, escort, massage, entertainment... But serving their master's carnal desires is where our trainees excel. You want them begging, screaming, moaning, silent, or dominating; we find the best suited personality and appearance for the task and turn them into a toy of your dreams. Or, in case you are more romantically inclined, we are also ready to get you a love of your life.\n\nOh, sorry, I've got carried away. We also help to find new connections and support many artists and street performers, but landowners rarely care about these things. Still we appreciate good art and entertainment, even if it's not very profitable.",
	SERVANTSQUESTIONS_3 = "— Oh, nobody has explained it to you, I suppose. You see, the landowners are the only ones, who can become a part of the city's government and it's you who make the most use of people and profits. Every guild has distinct groups following them and every new person means more power for us. On the other hand, it's guilds which present and vote for the candidates, so it's a mutual benefit. \n\nYou aren't tied to a specific guild though and are free to deal with others, but we aren't obligated to stick to you either. Just consider it a sign of good will.",
	SERVANTSQUESTIONS_4 = "— You must be interested in managing your subordinates, right? Firstly, you'll be using your skills to Praise and Punish them. Depending on the subordinate they will be more responsive to one or another. Without it keeping them in check they can escape. Taking them on the private dates is a great way to build their Loyalty. With said Loyalty you can make them lose their obedience slower. \n\n— Controlling your servants is just as important as feeding them. If you have problems with it, there's classes and items suited for it. You can teach other servants to help you with discipline. Some abilities can be really powerful and affect multiple targets.",
	SERVANTSINTRODUCTION1_2 = "— Welcome back, [Sir] [name]. Have you made up your mind yet?",
	SERVANTSINTRODUCTION1_3 = "— Welcome back, [Sir] [name]. How can I please you?",
	SERVANTSINTRODUCTION1_4 = "— Let me know if you need anything else. ",
	SERVANTSJOIN = "— This makes me happy. You won't regret it. Let me help you find someone to your taste.",
	SERVANTSCLOSE1 = "— Sure. We will be waiting for your response.",
	SERVANTSCLOSE2 = "— Take care. ",
	SERVANTSASKQUESTIONS = "Can I ask some questions?",
	SERVANTSASKQUESTIONSRETURN = "That's all",

	WORKERSINTRODUCTION1 = "You meet a short muscular dwarf who resembles a foreman in his attire and mannerism. \n\n— Aye pal, haven't seen ya around yet. Name's Sigmund. Are ya looking for work?",
	WORKERSINTRODUCTION1_1 = "If ya are still decidin' who ya gonna side with, we are going to provide ya with the best worker for your needs. ",
	WORKERSINTRODUCTIONREPLY1 = "I'm a new landowner around here",
	WORKERSINTRODUCTIONREPLY2 = "Who would let a dwarf become a guild leader?",
	WORKERSINTRODUCTION2_1 = "— Woah, dat's an unexpected one. My honor meeting ya.",
	WORKERSINTRODUCTION2_2 = "— Now, watch ya tongue, [boy]. You might've missed a couple o' years, since when all sentients were accepted equally by law here, right after the revolution. Dat's when I came 'ere to make my career. Ya are a landowner, aren't ya?",
	WORKERSINTRODUCTION2_3 = "— I bet you came to learn more about us. I's not much to say really, we be the arms and legs o' the country. We build, farm, craft and forge. Can you imagine if no one would take care of it? Me neither. We take craftin' orders from customers and other guilds. Ya have no idea how much stuff Fighters need us to reforge every month.",
	WORKERSINTRODUCTION2_4 = "— Oh, it's ya again. Gonna join us now?",
	WORKERSINTRODUCTION2_5 = "— Oh, it's ya again. How's it going?",
	WORKERSINTRODUCTION2_6 = "— That's it? I should get back to work.",
	WORKERSQUESTIONREPLY1 = "What's going on in the Dwarves' Kingdom?",
	WORKERSQUESTIONREPLY3 = "Can you give me some tips?",
	WORKERSINTRODUCTION1REPLY3 = "I'll side with you",
	WORKERSINTRODUCTION1REPLY4 = "I'll come back later",
	WORKERSQUESTIONS_1 = "— Yah, what is it?",
	WORKERSQUESTIONS_2 = "— Don't know, don't care. If I did, I wouldna come here in the first place. Don't take me for an outcast though. I just ain't happy with all the endless gold rush. I'd rather say nah more. Bad for business.",
	WORKERSQUESTIONS_4 = "— Hints, huh? No matter what ya do, food should be your first priority. Every pal out there has its own demands, and no food will quickly turn them hostile and starving. Thankfully, ya can buy it 'swell as produce it yourself. Cooking can be used to make raw ingredients more nutritious.\n\nIf ya planning to create your own stuff, you gonna need workshops for dat. Tailors can create cloth and leather armor, and smiths can forge weapon and metal armor. A skilled person can produce things much faster, so its best ya train 'em. Both crafting and gathering resources can be turned into profit, once ya sell your stuff at the local markets. ",

	WORKERSJOIN = "— Great! Alright, let's find ya a good healthy helper for you. ",
	WORKERSCLOSE1 = "— Alright, I'll be around here in case you change your mind.",
	WORKERSCLOSE2 = "— See ya. ",
	WORKERSASKQUESTIONS = "Can I ask some questions?",
	WORKERSASKQUESTIONSRETURN = "That's all",

	MAGESINTRODUCTION1 = "You find a female dark elf, who seems to be in a strained mood.\n\n— Hey, you brought the wine? ",
	MAGESINTRODUCTION1REPLY = "No...",
	MAGESINTRODUCTION2 = "— Gods, why are you so useless... Whatever. What do you want?",
	MAGESINTRODUCTION2REPLY = "I'm a new landowner",
	MAGESINTRODUCTION3_1 = "— Huh? I thought you were another initiate candidate. Well, that's funny, I had no idea they allow just about anyone to become landowners now. Don't take that personally, I accept that not everyone is born rich. Name is Myr by the way.",
	MAGESINTRODUCTION3_2 = "— Oh, It's you again. What do you want?",
	MAGESINTRODUCTION3_3 = "— Okay then.",
	MAGESINTRODUCTION3REPLY2 = "I'll side with you",
	MAGESINTRODUCTION3REPLY3 = "I'll come back later",
	MAGESINTRODUCTION2REPLY2 = "I want to request your support for Mayor election",
	MAGESINTRODUCTION2REPLY3 = "I've got the books you asked for",
	MAGESQUESTIONS_1 = "— Go on.",
	MAGESQUESTIONS_2 = "— With all due respect that I've nearly lost, you don't seem to possess any real wealth or power. I'm afraid nothing is going to change for us if you join us or not. So, I'm a bit unenthusiastic. \n\nBut I guess we can spare a recruit in case you'd actually want to stick around.",
	MAGESQUESTIONS_3 = "— Imagine that. You see, to become a sorcerer you will need two things: magic affinity and enough patience to learn. Both are somewhat uncommon and the combination in the same person especially so. We aren't scared, though. You can't get very far without sorcery anyway. There's just no alternative to us in case of emergency.",
	MAGESQUESTIONS_4 = "— There's two schools of thought. Or three, if you take pacifist maniacs into account. First is focusing on combat magic. Healing spells are cheap and fast alternatives to potions, while destructive spells can vaporize your enemies from a safe distance. Second group prefers conspiracy. Magic allows you to influence, read and dominate others' minds making it pretty useful in many social situations. ",
	MAGESQUESTIONS_5 = "— The pacifists? They are just nutcases who insist that magic should only be used for healing. They used to have some standing before the revolution when magic was more strictly regulated by the King's court. Pacifists had an easier time moving around after willingly sealing their magic. Now it seems more like a weird religious practice. ",
	MAGESQUESTIONREPLY1 = "You seem to be not very interested in new landowners",
	MAGESQUESTIONREPLY2 = "The Mage's guild seems a bit isolated",
	MAGESQUESTIONREPLY3 = "What are the mages good for?",
	MAGESQUESTIONREPLY4 = "What about the third group?",
	MAGESJOIN = "— Weird. I wouldn't expect you to. Not complaining, though. *sigh* Let's find you some poor soul to procure. ",

	MAGESCLOSE1 = "— Sure, we aren't going anywhere, anyway.",
	MAGESCLOSE2 = "— See ya, I guess.",
	MAGESASKQUESTIONS = "Can I ask some questions?",
	MAGESASKQUESTIONSRETURN = "That's all.",



	DIALOGUEINTRODUCTIONLETTER = 'Early in the morning your mansion is visited by a messenger, who passes you an officially sealed letter. After a quick examination you figure out that it is sent by the Servants Guild. \n\n"Dear [name], your recent activity has caught our interest and we would like to invite you for a private meeting." \n\nDespite a rather short message, the letter itself looks rather fancy and uses high quality paper and ink. ',

	ELECTIONSTART1 = "— [Sir] [name], it's wonderful you came! So you must be curious why we invited you. Not to sound suspicious, but we know about your monetary situation and relationship with the bank. \n\n— This is a situation I'd never prefer to be in. To tell you the truth, it's almost guaranteed you won't be able to pay them back in time. But, that's not exactly what I summoned you for. Say, do you know about the Mayor's position here?",
	ELECTIONSTARTREPLY1_1 = "Not really",
	ELECTIONSTARTREPLY1_2 = "It had something to do with being a landowner?",
	ELECTIONSTART2 = "— The city's Mayor is elected by the guilds majority every few years, but the catch is only a landowner can become one. Furthermore, the Mayor can't have his property overtaken even in case of loans, so that will let you get off the hook, as long as you manage to get elected. ",
	ELECTIONSTARTREPLY2_1 = "Are you proposing that I become mayor?",
	ELECTIONSTARTREPLY2_2 = "That seems nice, but it can't be that easy",
	ELECTIONSTART3 = "— Yes, as I said, you will need support of the majority of the guilds, which means at least 3. We aren't exactly good at cooperating with each other when it comes to power, so every guild usually has their own supported candidates. Good news is, as a new landowner, everyone is curious about your performance. So, as long as you make a good impression, it's very possible to request our support. ",
	ELECTIONSTARTREPLY3_1 = "Why are you telling me all this?",
	ELECTIONSTARTREPLY3_2 = "You are not sharing everything?",
	ELECTIONSTARTREPLY3_3 = "So what should I do",
	ELECTIONPERSUADE1 = "— We have our reasons. \n\nAmelia slyly smiled showing her attempt to not elaborate on the subject.",
	ELECTIONPERSUADESUCCESS = "— Oh, I assure, it's nothing for you to worry about. Let's say we can benefit from the bank losing some of its possessions. I guess you can say we have mutual interests. ",
	ELECTIONPERSUADEFAILURE = "— Sorry, we aren't quite sure we can share such information to you yet. Have no worries, you won't be losing anything anyway.",
	ELECTIONSTART4 = "— You're gonna to have to build a reputation with at least three guilds, but this should be done in two weeks, as after that the election period starts and you will have to register as a candidate. Don't let that scare you though, I'm sure you will manage. \n\n— After performing enough tasks for them, you will have to request elective support from their leaders. ",
	ELECTIONSTART4_1 = "\n\n— And since you've been favoring us, I'll happily give you my approval right now. ",
	ELECTIONSTART4_2 = "\n\n— After you get enough support, visit me and we will settle on your public image. ",
	ELECTIONSTARTREPLY4_1 = "This seems a bit suspicious, but I guess there's no harm in trying",
	ELECTIONSTARTREPLY4_2 = "Thank you, Amelia, I'll return once I do that",
	ELECTIONSTART5_1 = "— There surely is not. We'll hope for your success.",
	ELECTIONSTART5_2 = "— My pleasure. We'll hope for your success.",

	FIGHTERSREQUESTELECTIONSUPPORT = "I want your support in the Mayor Election",
	WORKERSREQUESTELECTIONSUPPORT = "I want your support in the Mayor Election",
	SERVANTSREQUESTELECTIONSUPPORT = "I want your support in the Mayor Election",
	MAGESREQUESTELECTIONSUPPORT = "I want your support in the Mayor Election",

	SERVANTSELECTIONCONFIRM = "— Oh, you've completed our requests? Nice work! With this I'll be able to convince others this is a good idea. Return to me once you have support from two other guilds.",

	FIGHTERSELECTIONSTART1 = "— Hmh... You've certainly done a lot for a newbie. So, you want to become the next Mayor? Admirable, but we do not provide our support lightly. ",
	FIGHTERSELECTIONSTARTREPLY1_1 = "Why not?",
	FIGHTERSELECTIONSTARTREPLY1_2 = "Haven't I done enough?",
	FIGHTERSELECTIONSTART2 = "— The guild's most important members are honorable warriors. We would not agree to give our votes for a mere commoner. In other words, you would have to prove yourself worthy. For that matter, we use an old Black Knights tradition of slaying a mage. However, at this age, you won't find those for slaying easily available, as they aren't persecuted for practicing magic anymore.",
	FIGHTERSELECTIONSTARTREPLY2_1 = "This doesn't sound very nice to mages",
	FIGHTERSELECTIONSTARTREPLY2_2 = "But what do you want then?",
	FIGHTERSELECTIONSTART2_1 = "— Back in the old days only a few King approved mages and their subordinates were allowed to practice any serious magic. We regularly used to hunt down those who practiced illegally, so it was a bit like sport, since their skills proved a nice challenge.",
	FIGHTERSELECTIONSTART3 = "— With no better option, we settled on taking down a Lich. Thankfully, those aren't protected by law, so you will have to get us a skull of one, as proof of your strength.",
	FIGHTERSELECTIONSTARTREPLY3_1 = "What's a Lich",
	FIGHTERSELECTIONSTARTREPLY3_2 = "Where do I find one?",
	FIGHTERSELECTIONSTART4_1 = "— A Lich is a mage, who managed to become undead. Many are quite stupid compare to normal mages. I guess transition does something to their brains. Yet, their powers are enough to stand on their own, and they generally utilize other undead as their minions. ",
	FIGHTERSELECTIONSTART4_2 = "— There's actually no shortage of the sneaky bastards. We've recently received a report of one not very far from the city. I'll mark the location on your map. Return once you have a skull, then we'll give you our support. ",
	FIGHTERSELECTIONSTART5 = "— Huh, you did it? Must say I'm surprised. Fine, we will give you our support for the next election. I believe this will be beneficial for both our sides.",

#	===Fighter's quests, to proofread later===

	LICHENCINITIATE = "You enter the small hideout filled with the stench of death. As you make your way forward you hear sounds of combat. Once in a fairly open room, you find the Lich you are looking for, surrounded by a small group of undead. On the other side of the room you see an elven girl dressed in leather armor. She's losing the battle against them.",
	LICHENCINITIATEREPLY1 = "Use girl as a distraction to attack at best opportunity",
	LICHENCINITIATEREPLY2 = "*Call out to Undead*",
	LICH_ENC_SCHOLAR_OPTION = "Launch a light missle (Scholar)",
	LICH_ENC_FIGHT_SCHOLAR = "You launch a light missle, which shines over the Lich's group and briefly disctracts him, allowing your group to take care of some of the minions who didn't fight back. Now, it's time to finish the weakened undeads.",
	LICHENCFIGHT = "You take your time to set an ambush but as you do so, the elven girl is struck down and does not move anymore.",
	LICHENCTALK1 = "You make an appearance, preparing to strike and catch the attention of the Lich, who seems to be quite agitated. The elven girl gets subdued by the undead around her, but is still alive.",
	LICHENCTALK1REPLY1 = "Die, monster! *Attack*",
	LICHENCTALK1REPLY2 = "A friendly undead? That's a new one",
	LICHENCTALK1REPLY3 = "Oh, now it talks",
	LICHENCTALK2 = "— My brain may be rotten, but I'm not too stupid to see how things are going. Say what you want stranger so we can settle it without needless bloodshed.",
	LICHENCTALK2REPLY1 = "I've changed my mind, I'll kill you! *Attack*",
	LICHENCTALK2REPLY2 = "I'm in need a Lich's skull, seems like you have one",
	LICHENCTALK2REPLY3 = "I'm only interested in destroying your kind",
	LICHENCTALK3 = "— A proving test... I understand. This would be unfortunate for me to lose my skull, haha. Say, would you take a skull I have from... another Lich I happened to have here? And then I'll leave this place shortly.",
	LICHENCTALK3REPLY1 = "I've changed my mind, I'll kill you! *Attack*",
	LICHENCTALK3REPLY2 = "That's it? Don't you think your life is worth a bit more?",
	LICHENCTALK3REPLY3 = "I accept it",
	LICHENCTALK3REPLY4 = "What happens to this girl?",
	LICHENCTALK4 = "— You are right. I'll add some magic ingredients from the undead, these will be worth something, won't they?",
	LICHENCTALK4REPLY1 = "I've changed my mind, I will kill you! *Attack*",
	LICHENCTALK4REPLY2 = "I accept it",
	LICHENCTALK4REPLY3 = "What happens to this girl?",
	LICHENCTALK5 = "— She's not for you to care about. She will have to pay for the damage she has done to me.\n\n As the girl hears it, her face goes pale. Before she can say anything coherent, her mouth is plugged by one of the zombies",
	LICHENCILLKILLYOU = "I've changed my mind, I kill you! *Attack*",
	LICHENCFINE = "I accept it",
	LICHENCTALK5REPLY3 = "No, you will release her{Physics Factor}",
	LICHENCTALK6 = "{color=green|Success}\n\n— Curses... Fine. You can have her. I'm not willing to stay here anymore.\n\n The Lich leaves with his army, leaving you with another Skull and a beaten girl.",
	LICHENCTALK6_1 = "{color=red|Failure}\n\n— You are trying your luck too far, mortal. This woman is no one to you. I will not let her go.",
	LICHENCTALK6REPLY1 = "Then I will kill you! *Attack*",
	LICHENCTALK6REPLY2 = "You can keep her",
	LICHENCCONLUSION = "— Good. Here's your skull. We will be leaving shortly, so don't bother to come here again.\n\n You leave the Lich's hideout, wondering what fate was left to the girl.",
	LICHENCWINAIRENOTDEAD = "Talk to the girl",
	LICHENCWINAIRE = "As you defeat the Lich and take his skull, the elf girl observes you cautiously.",
	LICHENCWINELSE = "You take the Lich's skull but can't find anything else worthwhile.",
	LICHAIRETALK1 = "You strike down the Lich and take its skull. The elf girl observes you with a mix of relief and caution. \n\n— I... Thank you for the help. My name is Aire. My master has sent me here to deal with the undead who disturbed nearby peasants, but it didn't go well.",
	LICHAIRETALK1_DEAL_WITH_LICH = "The elf girl observes you with a mix of relief and caution. \n\n— I... Thank you for the help. My name is Aire. My master has sent me here to deal with the undead who disturbed nearby peasants, but it didn't go well.",
	LICHAIRETALK1REPLY1 = "What kind of Master would send an elf fighter on their own around here?",
	LICHAIRETALK1REPLY2 = "I'm glad you are safe, take care",
	LICHAIRETALK1REPLY3 = "Don't you think you should reward me for your rescue?",
	LICHAIRETALK1REPLY4 = "*Push down and rape*",
	LICHAIRETALK2 = "— I'm sorry, but... this I cannot say. My Master rescued me from slavers, and I swore my loyalty for it.",
	LICHAIRETALK2REPLY1 = "Your Master is a fool sending you here alone.",
	LICHAIRETALK2REPLY2 = "Don't you think you should reward me for your rescue?",
	LICHAIRETALK2REPLY3 = "You better not end up in a similar spot next time, take care.",
	LICHAIRETALK3 = "— But I don't have anything on me!... Unless you mean... But this would be indecent. \n\n Aire blushes heavily and looks down.",
	LICHAIRETALK3REPLY1 = "Your company would please me greatly (Sex Factor)",
	LICHAIRETALK3REPLY2 = "Nevermind, you can go",
	LICHAIRETALK4 = """The elf girl twists a lock of orange hair around her finger nervously. 

{color=yellow|Aire: — Can we at least find somewhere a little more comfortable than this... dusty tomb?}

You both go outside and Aire starts looking for a suitable place while you follow, enchanted by the dainty wiggle of her ass. After a few minutes of searching outside the crypt, she leads you through a gap in the rocks where you stop her. Your patience is growing short and you gesture to the bare stony ground. 

{color=yellow|Aire: — Here? Oh... I guess we could...}""",
	LICHAIRETALK4_BAD = "{color=red|Failure}\n\n— I'm sorry, I can't do that. And there's nothing else I can offer.",
	LICHAIRETALK4_BADREPLY1 = "Nevermind, it's good you are safe, take care",
	LICHAIRETALK4_BADREPLY2 = "*Push down and rape*",
	LICHAIRETALK4_1 = """You beckon Aire closer. Her lip quivers as you draw her into an embrace with her firm breasts pressing against your chest. With one finger you gently lift her chin until you are looking directly into beautiful amber eyes. 

{color=yellow|Aire: — I-I'm very grateful, you know. You saved my life, I just... I'm sorry, I'm not very experienced at... this.}

You catch a lock of hair hanging over Aire's face, and tuck it behind her pointed ear. On the way, your fingertip traces a line along the ear and her face flushes with arousal. She leans in to kiss, and you press your tongue between her lips, tasting strawberries. Your hands find her round ass, which tenses as you take hold of it, but then relaxes.""",
	LICHAIRETALK4_2 = """You take the edges of her shirt and lift it until Aire's breasts are exposed, creamy and white. Your thumb circles one areola softly and the nipple immediately hardens to your touch. Leaning down, you squeeze her breast gently while you lick the nipple and suck it into your mouth. Aire moans while her hands pluck weakly at your clothes.

You tug her belt from its buckle. The leather shorts slide down her slender thighs to reveal fine silk panties. You unbuckle your own belt too, letting your cock spring free. She bites her lip and gasps softly as you guide her hands to your shaft. You slip your free hand inside her panties and cup her pussy, teasing the slit with your middle finger. 

{color=yellow|Aire: — Oh! Oh, that's... that feels... good.}""",
	LICHAIRETALK4_3 = """You pull the silk panties down her slim legs as she continues to stroke your cock. Aire gazes at you, desire bright in her eyes. 

{color=yellow|Aire: — Are we going to-},

You answer the question by pushing Aire backwards until she is lying on her cloak. Blushing, she spreads her legs wide to present her wet pussy to you. You take a moment to enjoy the sight before mounting her. She cries out in ecstasy as your penis prods against her swollen pussy and then thrusts inside. Her back arches sharply as your cock stretches her tight cunt. 

You fuck her hard on the stony ground, gripping her thighs as you pound her lithe body against the rock. Aire cums quickly, her pussy spasming around your cock and her ripe tits bouncing as you ride. You feel your own orgasm building as the pretty elf girl rocks her hips to coax your cock deeper. Suddenly she opens her eyes and looks at you.

{color=yellow|Aire: — Wait! Please, not inside!}""",
	LICHAIRETALK4_4 = """Aire's eyes are wide as your cock drives urgently into her pussy. Taking hold of her splayed knees, you fold her legs up high and fuck her until you cannot hold the orgasm any longer. Pulling your cock out, you spurt hot cum across her tits and belly. She sighs in pleasure and relief.

{color=yellow|Aire: — Oh, thank you!}

She swivels and brings your cock to her mouth again, licking at it eagerly.

{color=yellow|Aire: — You saved me, and I owe you, whoever you are. Thank you for everything, and I mean everything... Will we meet again, or is this just... I mean, it was fun either way... right?}

You stand and buckle your pants. Aire pulls the cloak around her naked body and looks for her scattered clothes. In a minute she is dressed and slips away into the wilderness, a coy smile on her face. You decide it's time to get going too.""",
	
	LICHAIRETALK5 = "— You will not speak badly of my Master! Even if you saved me, I won't allow it. Moreover, it was my fault for charging in here without scouting.",
	LICHAIRETALK5REPLY1 = "Don't you think you should reward me for your rescue?",
	LICHAIRETALK5REPLY2 = "You better not end up in a similar spot next time, take care.",
	LICHAIRETALK5REPLY3 = "You know, I find it very satisfying to defile someone else's property (rape)",
	LICHAIRETALK6_1 = """Seeing the cruel grin spread across your face, Aire tries to run but the fight with the lich has drained her strength. You catch hold of a wrist and pull her lithe body close. 

{color=yellow|Aire: — N-No! How dare you! }

Pinning her wrists with one hand, your other explores her delicate elven figure, roughly groping and pinching her thighs and ass before peeling the armor away and ripping her shirt open. Aire struggles weakly, but her firm breasts are soon exposed and their pink nipples begin to harden, quivering in the cold. 

She blushes deeply, the bloom spreading from the cheeks, up her pointed ears and down her neck. The elf girl's breath is hot against your face as you tug her belt free and pull down first the leather shorts and then her silk panties to reveal smooth fair skin; a taut ass with a neat pussy between her slim thighs.

{color=yellow|Aire: — Please, no! Let me go! You have no right! My master will be furious! }""",
	LICHAIRETALK6_2 = """Keeping her naked body clasped against you, you take some time to get familiar with her curves as Aire sobs pitifully. She cries out when your fingers find the clit, her shudders making her perky tits tremble. You stoop and catch one of the nubile breasts in your mouth, sucking and biting the tender nipple as you fondle her slit. 

You rub the clit for a minute and then forcefully press your middle finger up into her tight elven pussy. Aire squeezes her thighs together around your hand and moans helplessly. Wrists pinned, you pull her upper body back so you can look into those tearful amber eyes as your finger stirs the hot little honey-pot between her legs.

{color=yellow|Aire: — Nnnnn— no! That's not yours! You're not allow-aaaah! }""",
	LICHAIRETALK6_3 = """You draw your finger slowly out of Aire's pussy to find it slick with juices, then force your hand into her open mouth to silence the wails, gripping her jaw firmly. 

Letting go of the wrists, you pull her across you and lay a dozen hard spanks on the creamy skin of her tits and ass until they start to redden. She yelps and tries to cover herself but you shove her down backwards onto the floor and release your cock from your pants.

{color=yellow|Aire: — Y-you bastard! I don't want this! I don't want you! }""",
	LICHAIRETALK6_4 = """You laugh as you fall on top of Aire's struggling body, your erect cock pressing against the soft flesh of her inner thigh. Forcing your knee between her legs, you pry her slender thighs apart until they are spread wide. Shaky hands claw at your chest as you line up your cock with her glistening cunt. 

Aire's perfect tits heave as she writhes, trying to escape. Savoring the moment, you thrust your hips forward, ramming your cock deep into her hole. You swat away the flailing hands and seize hold of her tits, gripping them like handles while you fuck her vulnerable elf pussy raw.""",
	LICHAIRETALK6_5 = """Aire's struggles gradually grow weaker as you pound her against the cold stone floor of the tomb. You feel your orgasm begin to build and lower yourself to lay on top of her, your penis sliding freely in and out as she gasps at each powerful lunge. Her eyes are closed, tears staining her face, but you grasp a handful of soft orange hair at the back of her head and pull hard, forcing a plaintive squeal. 

Your lips close over hers and your tongue shoves roughly into her mouth while your hips grind relentlessly between her splayed thighs, driving your cock urgently into her spasming pussy. She tastes faintly of strawberries. Her resistance is already crushed as you deliver one final thrust, shooting hot cum deep inside her svelte elven body.""",
	LICHAIRETALK6_6 = """You use the tight grip of her pussy to milk the cum from your cock before pulling out. Standing, you buckle your pants, leaving Aire naked, spreadeagled, and leaking semen onto the ancient flagstones of the lich's crypt. A sheen of sweat sticks the dust of the tomb to her pale skin, and she is panting for breath as her shining amber eyes stare up at you in fear and anger.

Lust satisfied, you look at her lying there exhausted, broken and defenceless on the ground but still brimming with fury and injured pride.""",
	LICHAIRETALK6REPLY1 = "Kill her",
	LICHAIRETALK6REPLY2 = "Leave her",
	LICHAIRETALK7 = "You slit her throat, ending her life. There's nothing else to do here and you decide to leave.",
	LICHAIRELEAVE = "You part ways with Aire and prepare to head back with your trophy.",


	FIGHTERSELECTION5 = "— Oh ho... Not bad for someone like you. Alright, you've proven your worth and we will give you our support. Try not to abuse it.",
	FIGHTERSELECTIONREPLY1 = "And here I was hoping to start a personal crusade...",
	FIGHTERSELECTIONTHANKS = "Thanks",
	WORKERSELECTIONINITIATE1 = "— Elections, huh? Ya rich folk always have somethin' in mind. I don't mind. But before that, there's a thing I wanna ask.",
	WORKERSELECTIONINITIATE1REPLY1 = "This better not be another errand",
	WORKERSELECTIONINITIATE1REPLY2 = "How can I help?",
	WORKERSELECTIONINITIATE2_1 = "— Some time ago we struck a deal with the Fighters to supply them with a fresh set of armor. Thing is, we still didn't get the payment. I'd send someone else, but there's a shortage of workers at this moment. Here's the letter with the details, pass it to their leader. Sort this out and we will support ya, alright.",
	WORKERSELECTIONINITIATE2_1REPLY1 = "Investigate money disappearance. I can do that.",
	WORKERSELECTIONINITIATE2_1REPLY2 = "A dwarf is interested in getting his cash, hah. Have it your way.",
	WORKERSELECTIONINITIATE2_2 = "— Hmm? Let me see it. Huh..?",
	WORKERSELECTIONINITIATE2_2REPLY1 = "*Remain silent*",
	WORKERSELECTIONINITIATE2_2REPLY2 = "Something is wrong?",
	WORKERSELECTIONINITIATE3 = "— We have sent payment for that order some time ago, but somehow it didn't reach. Can you find our courier Reim and figure out what went wrong? He generally hangs out near the side alley bars. Let me know what's going on.",
	REIMENCOUNTER = "With some luck you find Reim at one of the back alleys. A young, dull looking guy who shows little concern until you mention how you came on the Workers Guild behalf. \n\n— That's... Uh, you see, I have a girl I really like. Her name is Lucy. She needs money and I wanna help her out. You see, she's real nice, even though she works as a harlot... She's been real nice to me, and she needs money right now.",
	REIMENCOUNTERREPLY1 = "Why should I care?",
	REIMENCOUNTERREPLY2 = "What do you want?",
	REIMENCOUNTERREPLY3 = "Can't you find a less needy whore?",
	REIMENCOUNTER2 = "— Please, help me out. Can you return the cash to Duncan in my regard? There's 150 gold to be paid still. Just tell him that I couldn't make it. He will understand and send someone else. I will be banished if they find out I took money for personal needs.",
	REIMENCOUNTER2REPLY1 = "Is she really that special?",
	REIMENCOUNTER2REPLY2 = "You shouldn't risk your life just for some whore, she's likely just using you (persuade)",
	REIMENCOUNTER2REPLY3 = "I'm not going to pay for your whims from my pocket",
	REIMENCOUNTER2REPLY4 = "I will consider it",
	REIMENCOUNTER3_1 = "— This... I guess you are right... *sigh* You can tell Duncan this will be taken care of right away.",
	REIMENCOUNTER3_1REPLY1 = "Good. I'll be going then.",
	REIMENCOUNTER3_2 = "— No, you don't understand! She's not just some whore. Look, you must help me out here...",
	REIMENCOUNTER3_2REPLY1 = "I'm not going to pay for your whims from my pocket",
	REIMENCOUNTER3_2REPLY2 = "I will consider it",
	REIMENCOUNTER4_1 = "— I understand... Just do what you must. In the end our love will beat all.",
	REIMENCOUNTER4_2 = "— Thank you! I... probably should hurry now. I'll try to return you this favor one day.",
	REIMENCOUNTER5 = "— Lucy is not like other girls. She's kind, nice and... She's even cooked for me, can you imagine?",
	REIMENCOUNTER5REPLY1 = "I'm not going to pay for your whims from my pocket",
	REIMENCOUNTER5REPLY2 = "I will consider it",
	WORKERSELECTIONCONTINUE1 = "— You are back? Have you found him?",
	WORKERSELECTIONCONTINUE1REPLY1 = "He seems to be... busy. Here's 150 gold on his behalf.",
	WORKERSELECTIONCONTINUE1REPLY2 = "He has wasted the money on a hooker",
	WORKERSELECTIONCONTINUE1REPLY3 = "I need some more time",
	WORKERSELECTIONCONTINUE2_1 = "— Huh... I see. I'll find another courier then. Thank you for your time. You can report back to Sigmund.",
	WORKERSELECTIONCONTINUE2_2 = "— ...Is that so? I guess you have no reason to lie. We will look into it. You can tell Sigmund, the payment will be delivered today.",
	WORKERSELECTIONINITIATE5 = "— Is dat so? Alright then. Thanks for helping out. While ya were out I made sure there's no objections among the guild. Ya have our support for your election thingie.",
	WORKERSELECTIONINITIATE5REPLY1 = "It's about time",
	WORKERSELECTIONINITIATE5REPLY2 = "Thank you",

	MAGESELECTION1 = "— Hmm... Is that so?.. This is Amelia's idea, I presume?",
	MAGESELECTION1REPLY1 = "Yes.",
	MAGESELECTION1REPLY2 = "How did you know?",
	MAGESELECTION2_1 = "— Figured as much.",
	MAGESELECTION2_2 = "— Haven't I told you, you must have some brains to be a mage?",
	MAGESELECTION2_ANY = "— Fine, I guess, why not. I'm going to have you do something for me first, though. I want you to visit my sister, Xari, and reclaim the books she has stolen. She's living not far from Aliron.",
	MAGESELECTION2REPLY1 = "So, should I beat her?",
	MAGESELECTION2REPLY2 = "Why would your sister not live here?",
	MAGESELECTION3_1 = "— No... Maybe. Do what you want, I guess... Actually no, don't harm her.",
	MAGESELECTION3_2 = "— She hates crowds and is not fond of surface cities, I guess. Can't say I'm much different, just more resilient. Things aren't so bad around the Mages Guild.",
	MAGESELECTION3_ANY = "Relatives always make things complicated. I'll give you a letter of invitation with the list of things to get from her.",
	XARIENCOUNTER1 = "Before you are able to look inside the hut, which looks more like a cave, a young, excited dark elf girl comes to you. \n\n— A guest! I haven't had any bandits visit me for a long time. Do you want to burn in fire or be eaten by trolls?",
	XARIENCOUNTER1REPLY1 = "I've actually came from your sister",
	XARIENCOUNTER1REPLY2 = "*Show letter*",
	XARIENCOUNTER2_1 = "— Ah, even better then! Living alone is great and all, but it's been a while since I had any guests to talk to. Aside from crows.",
	XARIENCOUNTER2_2 = "— Eh? So Myr sent you? Even better then! Living alone is great and all, but it's been a while since I had any guests to talk to. Aside from crows. ",
	XARIENCOUNTER2REPLY1 = "You can talk to crows?",
	XARIENCOUNTER2REPLY2 = "I get it you were bored",
	XARIENCOUNTER2REPLY3 = "I'd rather do my business and continue on my way",
	XARIENCOUNTER3_1 = "— Anyone can, they rarely reply back though. But spill it, what has Myr sent you for?",
	XARIENCOUNTER3_2 = "— Yeah, just a bit. I knew I should've found myself a sentient familiar before leaving the city. A cat would do nice... Or a human. So, stranger, what brought you to me?",
	XARIENCOUNTER3_3 = "— Jeez, you are no fun. Okay, what does Myr want from me now?",
	XARIENCOUNTER3REPLY1 = "She called you a thief",
	XARIENCOUNTER3REPLY2 = "She wants her books back",
	XARIENCOUNTER3REPLY3 = "I think she's feeling lonely",
	XARIENCOUNTER4_1 = "— Lies! Filthy elven sibling lies. So she wants her books then? She can have them. How dare she call me a thief. I will return them, alright?",
	XARIENCOUNTER4_2 = "— Huh... Makes sense I guess. Must be really stuck in that damn tower to not even visit her sister herself. Fine, I don't really need them anymore.",
	XARIENCOUNTER4_3 = "— Ahaha, that's a funny joke. Dark elves don't feel lonely. I think elves don't feel lonely in general, given how stuck-up they act. You can trust me, I've experienced it firsthand. So, I presume she wants her books back, so she sent a courier. Alright, I don't really need them anymore.",
	XARIENCOUNTER4REPLY1 = "So you will give them to me?",
	XARIENCOUNTER4REPLY2 = "But there's a catch?",
	XARIENCOUNTER4REPLY3 = "I'd rather be on my way from here, can you hurry?",
	XARIENCOUNTER5_1 = "— I will, but I'd like you to do something for me too.",
	XARIENCOUNTER5_2 = "— Exactly.",
	XARIENCOUNTER5_3 = "— Not so fast, friend. I'd like you to help me with one thing.",
	XARIENCOUNTER5_ANY = "— I have no idea when a new guy will drop by and it's been quite lonely on my own here. I know you have lots of nice elf boys around the city so bring me one for a couple of hours and you can have your books then.",
	XARIENCOUNTER5REPLY1 = "I thought you said dark elves don't feel lonely",
	XARIENCOUNTER5REPLY2 = "Why wait for some unknown boy when I'm right here?",
	XARIENCOUNTER5REPLY3 = "I'll be back then.",
	XARIENCOUNTER6 = "— And you would believe what a dark elf said? Huge mistake. Well, it's not exactly that, I guess it's also the boredom.",
	XARIENCOUNTER6REPLY1 = "Why wait for some unknown boy when I'm right here?",
	XARIENCOUNTER6REPLY2 = "I'll be back then.",
	XARIENCOUNTER7 = "— Ooh, you are willing to risk it with a wild witch like me? That's brave.",
	XARIENCOUNTER7_1 = "— Alright, I'll accept your sacrifice. But don't expect any mercy!",
	XARIENCOUNTER7_2 = "— Hm.. I'm actually very shy with other races, but I feel like this is a good time for a new experience.",
	XARIENCOUNTER7_3 = "— Sorry, I'm not really into girls. Yeah, I shouldn't be picky in my situation, but it's just gross. Bring me an elf boy and then you'll have what you came for. ",
	XARIENCOUNTER7_4 = "— But sorry, you aren't really of my taste. Bring me an elf boy and then you'll have what you came for.",
	XARIENCOUNTER8_1 = "— Wow, you are much better than you look. Haha, I'm kidding, you look better than a troll. That was great. Take your books and drop by sometime again.",
	XARIENCOUNTER8_2 = "— You aren't half bad, but could use some training... I'm just kidding. Thanks for your time, take your books, you've earned them.",
	XARIENCOUNTER8_3 = "\n\nYou leave Xari with the bundle of books requested by Myr. As you make distance from the hut, you feel like someone's watching your back closely.",
	XARIENCOUNTER9 = "— You are back. Got something for me?",
	XARIENCOUNTER9REPLY1 = "I've brought the elf you requested",
	XARIENCOUNTER9REPLY2 = "Not yet, I'll be back",
	XARI_ENCOUNTER_APPRENTICE_OPTION = "I don't think Myr or Mages' Guild would like me wasting time for this (Apprentice)",
	XARI_ENCOUNTER_APPRENTICE = "— Gods, you are no fun at all. Fine, I don't want those geezers anywhere around here, so take your books and leave.",
	XARIENCOUNTER10 = "— Hmm not bad, I'll take it. Now, if you excuse me... Oh, I guess you can take your books and go. Don't worry, I'll send this lad back right after we are done. \n\n [name] gives you a worried look as they disappear behind the locked door. \n\n After a few hours [name] returns back with an expression of exhausted bliss on [his] face.",
	MAGESELECTION4_1 = "— You di... You've slept with her!?",
	MAGESELECTION4_1REPLY1 = "Was my grin too wide?",
	MAGESELECTION4_1REPLY2 = "...No. Well, maybe",
	MAGESELECTION4_1REPLY3 = "I hope you aren't jealous",
	MAGESELECTION4_2 = "— Finally. So how was she doing? Don't tell me. she must be fine, since you got them without saying anything... Alright, thanks for the favor. You can tell Amelia you have our support or whatever. Have fun.",
	MAGESELECTION5 = "— Oh, Gods... Can't believe she would... \n\n— Ah, whatever, why do I care. You got the books intact. Tell Amelia it's fine. We will support you. Oh, yeah, I'd keep this information secret if I were you. ",
	SERVANTSELECTIONFINISH1 = "— Ah, you've got the support? Wonderful! ",
	SERVANTSELECTIONFINISH1_2 = "And since you really went for it and got them all, I've prepared a reward for you. *Amelia passes you a shiny necklace*\n— ",
	SERVANTSELECTIONFINISH1_3 = "Now all that is left is to prepare for the debate. But don't worry, I have the best image makers in the city to help you out.",
	SERVANTSELECTIONFINISH1REPLY1 = "I will need to debate? I thought I'd already got the support",
	SERVANTSELECTIONFINISH1REPLY2 = "I don't quite get the point of this.",
	SERVANTSELECTIONFINISH2_1 = "— Yes, but it's more complicated than that.",
	SERVANTSELECTIONFINISH2_2 = "There will surely be other contenders, even if they didn't make as many connections as you did. More importantly, you are supposed to show the voters that you are a good, respectable executive or leader that reflects their interests. Finally, every Mayor must keep their public image on a great level. Even if commoners won't be deciding if you pass or not, their discontent can't be ignored by others.",
	SERVANTSELECTIONFINISH2REPLY1 = "You are not going to make me do something shady once I win the election, are you?",
	SERVANTSELECTIONFINISH2REPLY2 = "So be adequate, reasonable, and liked. Understood",
	SERVANTSELECTIONFINISH2REPLY3 = "I'll try my best, but no promises",
	SERVANTSELECTIONFINISH3 = "— Don't be silly. I might ask for a thing or two, but aren't we in this together, [name]? Don't worry, if we didn't expect you to agree to what we might offer, we wouldn't suggest you become Mayor. After all, it's not like you can't reject guilds' demands.",
	SERVANTSELECTIONFINISH3REPLY1 = "So be adequate, reasonable, and liked. Understood",
	SERVANTSELECTIONFINISH3REPLY2 = "I'll try my best, but no promises",
	SERVANTSELECTIONFINISH4_1 = "— Exactly! Much shorter list than what we expect from our members, hehe.",
	SERVANTSELECTIONFINISH4_2 = "— That's cute. Don't worry, we got your back.",
	SERVANTSELECTIONFINISH4REPLY1 = "Alright, this sounds exciting",
	SERVANTSELECTIONFINISH4REPLY2 = "Ugh, let's just get this over with",
	SERVANTSELECTIONFINISH5_1 = "— Yes, this is a big event. I'm eager to see you in action!",
	SERVANTSELECTIONFINISH5_2 = "— Just try not to show this sort of attitude at the debates. Don't worry, I'm sure you will do great.",
	SERVANTSELECTIONFINISH6 = "The debate day starts, and a huge crowd gathers at the main square. As another candidate makes his entrance, you watch from behind with Amelia, waiting for your turn. \n\n— Hmph, silly amateurs. At least the crowd is entertained. Hey, don't sweat over it, you look great.",
	SERVANTSELECTIONFINISH6REPLY1 = "You seem to be enjoying yourself",
	SERVANTSELECTIONFINISH6REPLY2 = "I'm nervous, what do I even do?",
	SERVANTSELECTIONFINISH6REPLY3 = "I could use a drink now",
	SERVANTSELECTIONFINISH7_1 = "— What's not to enjoy? Lots of people are hopeful for the future of the city. Lots of opportunities to profit and grow. This is like a great test for me.",
	SERVANTSELECTIONFINISH7_2 = "— Don't worry. We have a speaker who will make you look like you are the only reason the city hasn't collapsed in the past week. Just smile and look confident.",
	SERVANTSELECTIONFINISH7_3 = "— Haha, just wait until it's over, I'll keep you company then.",
	SERVANTSELECTIONFINISH7_ANY = "— It seems this one is done. You'll be up in ten minutes and... \n\n Before Amelia could answer, a deafening blast erupted from the podium, and a group of people materialized there. Led by a young blonde girl adorned in shiny armor and luxurious clothes.",
	SERVANTSELECTIONFINISH8 = "Before anyone could react, the square was covered by a magic sphere, blocking any potential avenues for retreat or assistance. However, none of the invaders showed any apparent hostility. \n\n The girl spoke. \n\n— People of Aliron, the Human Lands. I'm Anastasia, Daughter of King Alber. My father was mercilessly killed 12 years ago. I swear to avenge him, defeat his enemies and return our kingdom to its former rule. Those who fight for our cause will be rewarded. Please stay strong and help us defeat the wrongdoers. Come seek us and together we will stop this unholy regime." ,
	SERVANTSELECTIONFINISH9 = "A few moments after she finished a bright flash covered the square to hide a magic portal that Anastasia used to escape. The magic barrier fell and people stood dumbstruck at what just happened.",
	STARTFINALE = "Thank you for playing the alpha version of Strive: Conquest. This project wouldn't be possible without the support of patrons.\n\nYou can keep playing indefinitely",

	LOAN_EVENT = "By the morning the bank loaners has visited the mansion. ",
	LOAN_SUCCESS1 = "They took 1000 gold and departed quickly. Your next payment is expected by 28th day and will be requiring 3000 gold.",
	LOAN_SUCCESS2 = "They took 3000 gold and departed quickly. Your next payment is expected by 50th day and will be requiring 10000 gold... Unless something else can be done about it.",
	LOAN_SUCCESS3 = "They took 10000 gold and departed quickly. Your next payment is expected by 100th day and will be requiring 86000 gold... Unless something else can be done about it.",
	LOAN_SUCCESS4 = "They took 86000 gold and departed quickly. This was your last payment and now you are free to do what you want...",
	LOAN_FAILURE = "However, you had no cash available. You've failed to complete the requirements and bank takes away your property, leaving you on the streets. ",

	SEXTRAITHELP = "Sex Traits can provide special effects during sex interactions. Traits have a chance to be unlocked in sex interaction by performing specific actions related to it. After unlock Traits can be toggled on and off. Maximum number of traits which can be active in same time is decided by {color=yellow|Sex Factor}. It also increase chance to unlock a trait. ",
	SEXTRAITDISLIKES = "Dislike traits are character's natural preferences over certain actions. They can't be toggled off, but they can be removed by some effort and luck. ",

	# Aliron Church
	GINNYVISIT = "In the morning your mansion has a visitor. As you open the door, you see a young girl in a nun outfit.\n\n— Hello, [Sir]. I'm Ginny. I've heard you just moved here and I was hoping to catch your interest as I work at the church of Celena.",
	GINNYVISITREPLY1 = "Alright, but make it quick",
	GINNYVISITREPLY2 = "Why don't you come inside?",
	GINNYVISITREPLY3 = "Not interested in whatever you're selling",

	GINNYVISIT2_1 = "— Ah, I won't take your time, just wanted to say that we are open to any new visitors. Celena wishes to help anyone in need and I hope to build a stable, kind community. I'd be happy if you decide to learn more and drop by at some point. Now, I won't be taking anymore of your time. Goodbye!",
	GINNYVISIT2_2 = "— I'm sorry, but I can't stay for long. Plus I've been told not to trust land owners as they often kidnap and enslave strangers... I mean I don't think you do that, but still. Anyway, if you wish to know more, feel free to see us, I'm always happy to get new visitors. Goodbye!",
	GINNYVISIT2_3 = "— Sorry to distract you! I just wanted to tell you since you are new, you can visit our church if you are interested... I'm sorry, goodbye. ",

	ALIRONCHURCHFIRSTCOME = "You enter a small local church. The building seems not very spacious but fairly clean and cozy. As your entrance is spotted, Ginny rushes to greet you.\n\n— Welcome, [Sir]. I'm glad you came after all, with Celena's help. Are you seeking guidance or maybe you want to become a member?",
	ALIRONCHURCHFIRSTCOMEREPLY1 = "I'm just wandering around",
	ALIRONCHURCHFIRSTCOMEREPLY2 = "I'd like to learn more about your religion",
	ALIRONCHURCHFIRSTCOMEREPLY3 = "I think I'll come in another time",

	ALIRONCHURCHINTRODUCTION1 = "— Oh, this is great! It's always a pleasure to get to know new people who come to the city. Some complain about it being overcrowded but we are able to get more members too. This is a Church of Celena. I know, it does not look like much, but we are the biggest religious establishment around the city. Since Aliron is not very pious, we don't get much of an offertory to afford a better place.",
	ALIRONCHURCHINTRODUCTION2 = "— Wonderful! This is a Church of Celena. I know, it does not look like much, but we are the biggest religious establishment around the city. Granted, Aliron is not very pious, but still. We worship the Goddess Celena and help others in need. ",

	ALIRONCHURCHINTRODUCTIONREPLY1 = "Can you tell me more about Celena?",
	ALIRONCHURCHINTRODUCTIONREPLY2 = "Is there some way I could help?",
	ALIRONCHURCHINTRODUCTIONREPLY3 = "Leave",

	ALIRONCHURCHLEAVE = "— Please come again!",

	ALIRONCHURCHCELENA = "— Gladly. Celena is the Goddess who's associated with us humans. She's the embodiment of compassion and always watches out for those in trouble. She's also the goddess of life and harvest so if you come across her shrine, you can offer it some food. ",
	ALIRONCHURCHCELENAREPLY1 = "Are gods even real? Do you have any proof?",
	ALIRONCHURCHCELENAREPLY2 = "There are other deities?",
	ALIRONCHURCHCELENAREPLY3 = "Tell me about shrines",
	ALIRONCHURCHCELENAREPLY4 = "I've learned enough",

	ALIRONCHURCHCELENAANSWER_1 = "It's true you might doubt their existence, but it's apparent after some time. You can ask Celena for help or a blessing, and you will often be able to receive it in some form. Yes, it might not be as epic as their status suggests, but it's an undeniable proof that they still watch over us.",
	ALIRONCHURCHCELENAANSWER_2 = "— Naturally! Most other races don't recognize Celena and have their own gods who respond to their prayers. I know the forest elves worship Freya and their trees, but how can they compare to Celena's omnipresent love? ",
	ALIRONCHURCHCELENAANSWER_3 = "— Most of the shrines you might find around these lands will be of Celena. By making an offer you may receive a blessing or some other gift. But different deities have different preferences, they say. I'm not sure, I've only been devoted to Celena for my whole life.",

	ALIRONCHURCHENTER1 = "As you enter the church, Ginny greets you as usual.\n\n— Welcome, [name]! What can I do for you?",
	ALIRONCHURCHENTER2 = "— Is there something else I can help you with, [Sir] [name]?",

	ALIRONCHURCHENTERREPLY1 = "Tell me more about your work",
	ALIRONCHURCHENTERREPLY2 = "I've brought the food you've asked for",

	ALIRONCHURCHQUESTSTART = "— We are mostly doing fine, but we also have to feed the poor and homeless. It would be great if you can get us {color=aqua|25 meat soups} as we don't always have enough. You can cook them from raw resources. I'm sure Celena will be very pleased. ",
	ALIRONCHURCHQUESTSTARTREPLY1 = "I don't suppose there will be a reward?",
	ALIRONCHURCHQUESTSTARTREPLY2 = "I'll be glad to help",
	ALIRONCHURCHQUESTSTARTREPLY3 = "No promises, I'll see what I can do",

	ALIRONCHURCHQUESTSTART1_1 = "— Isn't virtue it's own reward? I will try to assemble something, but you can see we don't have much.",
	ALIRONCHURCHQUESTSTART1_2 = "— That's wonderful, I'll be praying to Celena for your safety.",
	ALIRONCHURCHQUESTSTART1_3 = "— Thank you, we will appreciate it. If you need anything else, let me know.",

	ALIRONCHURCHQUESTCOMPLETE1 = "— This is wonderful! For your help I'd like to present you with a holy text on teaching healing magic. I'm sure this will be of some use to you. Oh, and take some of these healing shards. You can break them down to heal your injuries even in dire situations.\n\n— Oh, also we can always use more food for poor. If you bring it to us once a week, we'll provide you with more shards.",
	ALIRONCHURCHQUESTCOMPLETE2 = "— This is wonderful! I know it's not much, but I can spare you some life shards. These are Celena's gift to us, so you can use them in your adventures.",

	# Tutorials
	INTRODUCTIONTUTORIAL1 = "This is the main Mansion screen. At the center you can see the list of all your possessed characters.",
	INTRODUCTIONTUTORIAL2 = "Main actions can be found at the bottom left corner.",
	INTRODUCTIONTUTORIAL3 = "At the top of the screen you can find a navigation panel, which will list available locations to visit and interact with. Click on the Aliron to go to town.",

	QUESTTUTORIAL1 = "Repeatable quests can be obtained from the city's Notice Board. Use them to earn money and guild reputation. Different guilds offer different quests. Reputation can be used to unlock exclusive classes and purchase guild exclusive items.",
	QUESTTUTORIAL2 = "Once you've completed a quest, or procured the required items, you can submit it and receive your reward from the Journal tab.",
	QUESTTUTORIAL3 = "Select \"Complete\" when on the selected quest to finish it.",

	SKILLSTUTORIAL1 = "At the bottom of the screen you can see abilities available to the currently selected character. Abilities are acquired from Classes and can be used on characters in the same location as caster. Social abilities are important for keeping obedience high, which is necessary to prevent them from escapes. However, many of them will have a subtype. {color=green|Generous} subtype is more effective on targets with high Tame Factor, while {color=red|Mean} is more effective on targets with high Timid Factor.",
	SKILLSTUTORIAL2 = "Loyalty can be used to make their respect for you stronger and reduce their Obedience Drain while also unlock new abilities.",
	SKILLSTUTORIAL3 = "After selecting an ability you'll have to select a target for it. Remember that only targets from the same location are viable.",
	SKILLSTUTORIAL4 = "At the right side you can switch to combat abilities set up. While you can't use them outside of combat, you can still check their descriptions and prepare yourself before it.",

	EXPLORATIONTUTORIAL1 = "While browsing non-city locations you'll have access to the list of presented characters and a combat party setup. Drag and drop characters onto the party setup to assign them to it.",
	EXPLORATIONTUTORIAL2 = "Do note, that melee attacks can't be performed by back row while front row is present, and back row also can't be targeted by melee attacks at the same time. On the right of the combat team you can find available items. They can be used by dragging and dropping on active characters.",
	EXPLORATIONTUTORIAL3 = "You can also use spells to heal while in preparation, but keep an eye at mana levels or catalyst requirements.",



	CRAFTTUTORIAL1 = "While in the Craft Menu, select the crafting category from the top of the screen.",
	CRAFTTUTORIAL2 = "You need specific materials to craft an item displayed next to it. Modular items are crafted differently from standard items. Instead of specific materials they take material types for each different part of the item.",
	CRAFTTUTORIAL3 = "To select a material for the part of the modular item click on the empty slot.",
	CRAFTTUTORIAL4 = "At the top you can see how many of a material is needed. Different materials will provide different effects to the end item.",
	CRAFTTUTORIAL5 = "Once finished you can select how many times the item should be crafted and confirm the order.",
	CRAFTTUTORIAL6 = "Each item has its own required production time. To process any craft, you need to assign a character to it. You can do so from their occupation menu, or right from the Craft screen. Only characters at the mansion can craft.",
	CRAFTTUTORIAL7 = "If you decide to assign crafters from the Craft screen, select characters to be assigned, then click confirm.You can also select them from the occupation menu.",
	CRAFTTUTORIAL8 = "Once you are done, at the left side of the screen you'll see new progress for the items being worked on.",

	NOSLAVESINMARKET = "No Slaves Avaliable.",
	RESETLOADCHARPROFESSION = "Class doesn't match current guild.\nStarting class will be reseted.",
	TEMPLATETYPENOTMATCH = "Can't use this template. Types doesn't match.",

	REMOVETATTOO = "Are you sure you want to remove this tattoo?",
	ADDTATTOO = "Add tattoo?",
	CHOOSETATTOO = "Choose a tattoo first.",
	SAMETATTOO = "You already have the same tattoo in this slot.",
	REPLACETATTOO = "Replace this tattoo?",

	NOTCOMPATIBLE = "This save file is not compatible with the current version of the game.\nHowever, you can update the file.\nWARNING! All characters will be returned to Mansion. Some progress might be lost.\nProceed? (original save file will stay untouched, but won't work with the current version)",
	CREATECHARQUESTION = "Create this character?",
	RETURNTOMAINMENUQUESTION = "Return to Main Menu?",
	FORGETLOCATIONQUESTION = "Forget this location? All present characters will be sent back to Mansion. This action can't be undone.",

	SENDCHARBACKQUESTION = "Send [name] back?",
	SENDCHARBACKTOMANSIONQUESTION = "Send [name] back to Mansion?",

	RETURNALLCHARSTOMANSIONQUESTION = "Return all character back to Mansion?",
	CANCELTASKQUESTION = "Cancel this task?",
	FORFEITQUESTQUESTION = "Forfeit This Quest?",

	REMOVEUPGRADEFROMQUEUEQUESTION = "Remove this upgrade from the queue?",

	STARTTHISGAME = "Start this Game?",
	UPDATEFILE = "Update this file?",

	# after finishing election-princess-meeting sequence

	QUESTLOG_AFTERELECTIONOPTION1 = "Visit Myr to know how you can help",
	QUESTLOG_AFTERELECTIONOPTION2 = "Visit Fred's dormitory at Aliron to learn about his whereabouts",
	QUESTLOG_AFTERELECTIONOPTION3 = "Find Fred's meeting spot outside of Aliron",
	QUESTLOG_AFTERELECTIONOPTION4 = "Return to Myr with the news",
	QUESTLOG_AFTERELECTIONOPTION5 = "Visit Duncan",
	QUESTLOG_AFTERELECTIONOPTION6 = "Visit Sigmund to help him with the recent rebel takeover",

	# Aliron elections finish

	ALIRONELECTIONSFINISH_LINE1 = """A few hours later, an emergency meeting of the four major guilds was assembled. The leaders and landlords entered into a fierce discussion on the current situation.

{color=aqua|Duncan: — This is ridiculous. Now every peasant will know King Alber's heir is alive. Today of all days, HOW did a large rebel group enter the city undetected? Your guild's duty is specifically to prevent such things, Myr. How do you explain this sabotage?}

{color=yellow|Myr: — How dare you accuse us of betrayal? I remember it was your duty to dispose of the royal family, and yet here we have a princess still very much alive, all grown up, and rallying the rebels against us.}""",

	ALIRONELECTIONSFINISH_LINE2 = """{color=aqua|Sigmund: — Are ya sure she's actually da princess? Might be she's an imposter. Pretty common tactic fo' dwarven disputes.}

{color=yellow|Amelia: — We are almost sure she's the real deal. Her appearance correlates to the youngest child and her aura is undeniably of the royal bloodline. What we don't know is who is backing her. If the empire has a hand in this...}""",

	ALIRONELECTIONSFINISH_LINE3 = """{color=aqua|Duncan: — Our scouts have been reporting increased activity from the rebels in past months. Sympathizers and rebel forces are advancing as we speak. I'm forced to declare a state of emergency.}

The crowd of landowners bursts into a hubbub.

{color=yellow|Sigmund: — Settle lads, he's right. We can't afford to lose any of da vital points or trade routes.}""",

	ALIRONELECTIONSFINISH_LINE4 = """{color=yellow|Myr: — Mhph, so you're going to declare yourself leader now? How long do you expect the rest of the guilds to support you given your credibility after the appearance of a living heir?}

{color=aqua|Duncan: — I don't expect your compliance, and I won't need your help to deal with them. Once we identify the traitor, there will be no mercy. You better prepare for it.}

{color=yellow|Myr: — We?! Why? No, how would the Mage Guild benefit from this rebel stunt?}

{color=aqua|Duncan: — Regardless, we will find the culprit and all accomplices will be dealt with thoroughly. Be it you, the Servants, or even one of ours.}""",

	ALIRONELECTIONSFINISH_LINE5 = """Once the meeting ended, you approach Amelia to discuss what will happen next.

— Oh, this is horrible. Now the Fighters will rule with an iron fist until the riots are quelled. For you, the bad news is the election is naturally put on hold. The good news is so is your debt. Looks like the Servants have been benched. Me especially.""",

	ALIRONELECTIONSFINISH_QUESTION1 = "Why can't you do anything?",
	ALIRONELECTIONSFINISH_QUESTION2 = "It seemed to me the guilds were fighting each other.",

	ALIRONELECTIONSFINISH_ANSWER1 = """— The Servants have no role in warfare. We don't train soldiers, possess magic, or even produce supplies.
As such we barely have any influence while Aliron is under martial law.
I guess all we can do is stick around 'till it's over and hope there will be something left for us afterwards.

— You know, it's going to take Duncan weeks to find out what's really going on, and until then the air around here will be tense.
You could obviously jump straight into the fight with the rebels, but I feel like we would do better to uncover the perpetrators and clear suspicion within the guilds first. What do you think?""",


	ALIRONELECTIONSFINISH_ANSWER2 = """— Sure, that's what we always do. The stakes are higher this time though with one of our own betraying us to the rebellion.
The Mages are in charge of any large scale teleportations, so this shouldn't have been possible short of infiltration and sabotage.

— You know, it's going to take Duncan weeks to find out what's really going on, and until then the air around here will be tense.
You could obviously jump straight into the fight with the rebels, but I feel like we would do better to uncover the perpetrators and clear suspicion within the guilds first. What do you think?""",

	ALIRONELECTIONSFINISH_QUESTION3 = "Actually, I was about to offer my assistance to Duncan personally.",
	ALIRONELECTIONSFINISH_QUESTION4 = "That sounds like something a perpetrator would say to use me for their benefit.",
	ALIRONELECTIONSFINISH_QUESTION5 = "I'm not sure, what if I get in the way?",

	ALIRONELECTIONSFINISH_ANSWER3 = """— Quite enthusiastic, aren't you? This is all the better, but don't act prematurely.

	— Anyway, take this writ of inquisition. It proves your investigation is guild sanctioned and you'll be able to ask around.
I suggest starting with the mage guild. If they haven't figured it out already, they should be able to determine how our princess got in.""",

	ALIRONELECTIONSFINISH_ANSWER4 = """— Hah, that's the spirit. Trust no one. This is why I've chosen you. Well, since you've realized that and if that was the case, we won't be able to fool you, right?

— Anyway, take this writ of inquisition. It proves your investigation is guild sanctioned and you'll be able to ask around.
I suggest starting with the mage guild. If they haven't figured it out already, they should be able to determine how our princess got in.""",

	ALIRONELECTIONSFINISH_ANSWER5 = """— Come on now. Someone aiming for a position of mayor should display more confidence. Don't worry, if something happens I'll cover for you.

— Anyway, take this writ of inquisition. It proves your investigation is guild sanctioned and you'll be able to ask around.
I suggest starting with the mage guild. If they haven't figured it out already, they should be able to determine how our princess got in.""",

	#==============Mages guild line================= (triggers when meeting mage leader)

	MAGESAFTERELLECTION1 = """You enter Myr's office to find her distressed, much unlike her usually calm state.

— I thought I made it clear I am not to be disturbed... Oh, it's you. What do you want?""",

	MAGESAFTERELLECTION1_QUESTION1 = "Just dropped to say \"Hi\".",
	MAGESAFTERELLECTION1_QUESTION2 = "I'm investigating what's been going on around here.",

	MAGESAFTERELLECTION1_ANSWER1 = """— Yeah, right, like hell you did. Did the Fighters send you? Or, more likely, it's Amelia's idea, right?

— Fucking hell. They can't finish off one brat, don't even realize it until it's too late, and now it's all our fault. Like I care. So you wanna find out what actually happened?""",

	MAGESAFTERELLECTION1_ANSWER2 = """— Fucking hell. They can't finish off one brat, don't even realize it until it's too late, and now it's all our fault. Like I care. So you wanna find out what actually happened?""",

	MAGESAFTERELLECTION1_QUESTION3 = "Hoped you'd tell me",
	MAGESAFTERELLECTION1_QUESTION4 = "I guess you don't know either",
	MAGESAFTERELLECTION1_QUESTION5 = "...",

	MAGESAFTERELLECTION1_ANSWER3 = """— The city is protected from unauthorized teleportation by a crystal sphere designed to dampen magic crossing a projected threshold. The device can have very different applications but what's important is that for this purpose, it requires a power source. This power source was stolen right before the... event.

— Cutting to the chase, there are only a few guild members allowed access, and one of those has just happened to have gone missing on the day of the incident.
Name's Fred. You can find him and confirm if he disabled the device on his own accord. If he indeed sided with the rebels or the empire it's best if you take him down immediately.

— I'll give you his home address, you might find some clues about his whereabouts there.""",

	MAGESAFTERELLECTION1_QUESTION6 = "What's that power source which was stolen?",
	MAGESAFTERELLECTION1_QUESTION7 = "You suspect he's dead?",
	MAGESAFTERELLECTION1_QUESTION8 = "I'll let you know once I learn something.",

	MAGESAFTERELLECTION1_ANSWER4 = """— It's an artifact, a sword of a former king Nicolas. Technically, it belonged to the royal family, but since the revolution the guilds have decided to utilize it for the good of everyone.""",
	MAGESAFTERELLECTION1_ANSWER5 = """— I'd prefer to be dead if I was him. Otherwise, the death that Duncan will gladly prescribe will be a slow one. He does not take betrayal lightly.""",
	MAGESAFTERELLECTION1_ANSWER6 = """— Find him, or what's left of him. If he's still alive, I'd not expect him to be happy to see you, so feel free to take him down if needed... or even if not.""",

	# Visit Fred's home

	VISITFREDSHOMEINTRO = """You enter a dormitory in one of the poorer districts of the city.

Fred's room is rather small and unclean with thin walls letting you hear the neighbors. After some time searching you find a hidden note implying Fred was planning to secretly meet with someone named Greg on the outskirts of town.

After asking around with the other residents, you decide it's the most likely place to find him.""",

	VISITFREDSHOME_IF_BRIBE = """You return to Fred's room. After a few minutes of searching you discover the hidden stash, proving Fred didn't lie to you. The sum makes you wonder how quickly Fred would be burgled by his neighbors if they knew about it.

After securing the money you leave the dormitory.

{color=green|Earned 500 Gold}""",

	FINDFRED1 = """You find the rendezvous point from the letter in Fred's room easily enough. It's marked by a large oak tree standing just off of a muddy farm road. No Fred here, but there are many presumably human footprints left in the soft earth and signs that someone was dragged away into a copse of trees a short distance away.

The men didn't make any effort to hide their tracks and you soon find a cave's mouth on the side of a rocky outcrop hidden in the trees.

You do your best to muffle your footfalls as you explore deeper into the cave and come across the steel barred door of a prison cell carved into the stone. You sneak a look inside and notice Fred tied up with a group of three armed men resembling bandits, standing over him.""",

	FINDFRED2 = """{color=aqua|Fat Bandit: — See? He's not going anywhere. I'm bored and it's hella cold here. Let's go already.}

{color=yellow|Small Bandit: — Yeah, I haven't cleared my throat for three days straight. Boss, come on.}

{color=aqua|Boss: — We aren't going anywhere just yet, you idiots. This is an opportunity to earn some extra cash and favor.}""",

	FINDFRED_OPTION1 = "Talk",
	FINDFRED_OPTION2 = "Attack",

	FINDFRED_TALK1 = "You decide to approach the mercs peacefully and talk to them.\n\n{color=yellow|Fat Bandit: — Huh? Who are you?}",
	FINDFRED_TALK1_QUESTION1 = "I've come with a message, your services are no longer needed.",
	FINDFRED_TALK1_QUESTION2 = "I'm interested in your prisoner, maybe we could work something out.",
	FINDFRED_TALK1_QUESTION3 = "Sorry, it seems I'm lost, I better go.",
	FINDFRED_TALK1_QUESTION4 = "This is a waste of time... *attack*",
	FINDFRED_ROGUE_OPTION = "You fuckers were sold out, the city militia is already on this way here (Rogue)",
	FINDFRED_ROGUE = """{color=aqua|Fat Bandit: — Huh? What is going on?}

{color=yellow|Small Bandit: — I knew these bastards could not be trusted!}

{color=aqua|Boss: — Damn it... We retreat now, forget about this guy.}

The trio quickly escape without realizing your bluff, leaving you with their prisoner.""",
	FINDFRED_TALK1_ANSWER1 = """The boss of trio gives you a skeptic look.

{color=aqua|Boss: — Huh, really? Who are you trying to fool here?}""",

	FINDFRED_TALK1_ANSWER1_1 = """{color=aqua|Boss— Huh, really? Who are you trying to fool here?}""",

	FINDFRED_TALK1_QUESTION5 = "Taking me for an imposter would be a dumb move.",
	FINDFRED_TALK1_QUESTION6 = "Hey, I'm being serious here. Let's not jump to conclusions.",
	FINDFRED_TALK1_QUESTION7 = "Aren't you skittish for someone who's already received your payment?",
	FINDFRED_TALK1_QUESTION8 = "Was worth a try. I guess we'll do it the hard way.",

	FINDFRED_TALK1_ELSE = """{color=yellow|Small Bandit: — Finally! I can't wait to get out of this shithole.}

{color=aqua|Boss: — Very well, we all one be done with it anyway, but just to make sure you're on the level, what's the name of our contractor?}""",

	FINDFRED_TALK1_CONTRACTOR_DUNCAN = "Duncan",
	FINDFRED_TALK1_CONTRACTOR_GREG = "Greg",
	FINDFRED_TALK1_CONTRACTOR_FRED = "Fred",
	FINDFRED_TALK1_CONTRACTOR_AVERMIK = "Avermik",

	FINDFRED_TALK1_IF_GREG1 = "{color=aqua|Boss: — Huh, alright then. Let's get the hell outta this hole in the ground boys. And you... you make sure and report back we didn't neglect our mission. Will be glad if we got hired again 'suming the pay is good. See ya.}",
	FINDFRED_TALK1_IF_GREG2 = "As the bandits leave, you move to Fred still bound on the rough stone floor and remove his gag, letting him speak.\n\n— W-who are you? Are you from the guild? Would you mind untying me?",

	FINDFRED_ATTACK = """Deciding there's no point in negotiations you prepare to attack the bandits.
	
{color=aqua|Fat Bandit: — Huh, you think you are so tough? Bring it on!}

{color=yellow|Small Bandit: — Yah, show 'em fatso. }""",

	FINDFRED_AFTERWIN = """{color=yellow|Small Bandit: — Screw it! They are too strong!}

{color=aqua|Boss: — I'm afraid to admit it, but we'll have to retreat now. We'll get you next time!}""",

	FINDFRED_START = """After the strange trio runs for their lives, you move to Fred still bound on the rough stone floor and remove his gag, letting him speak.

{color=yellow|Fred: — W-who are you? Are you from the guild? Would you mind untying me?}""",

	FINDFRED_AFTERWIN_QUESTION1 = "Not until you explain yourself.",
	FINDFRED_AFTERWIN_QUESTION2 = "Where's the artifact you've stolen?",

	FINDFRED_TALK1_ANSWER2 = """— *Sigh* I don't have much of a choice, do I? They offered me a good coin if I brought them the sword, but then they double-crossed and imprisoned me!
I don't know what they wanted it for. It's just some old relic nobody cares about anyway. Damned Greg and that demon bitch...""",

	FINDFRED_AFTERWIN_QUESTION3 = "Why did you cooperate with the rebels?",
	FINDFRED_AFTERWIN_QUESTION4 = "What can you tell me about them?",
	FINDFRED_AFTERWIN_QUESTION5 = "I'll bring you back to guilds to face justice for aiding the rebellion.",
	FINDFRED_AFTERWIN_QUESTION6 = "I've heard enough, traitors deserve death.",

	FINDFRED_TALK1_ANSWER3 = """— They took it. It's just some old relic nobody cares about anyway and they offered me a nice sum to bring it to them. Then they double-crossed me and had those men drag me off here. Damned Greg and that demon bitch...""",
	FINDFRED_TALK1_ANSWER4 = """— Rebels? Look, I had no idea who they were. You've seen my place, it's a dump! Ok, so I fucked up, but who wouldn't consider the opportunity?""",
	FINDFRED_TALK1_ANSWER5 = """— I dunno, Greg's one shady backstabber? He told me to get the sword, I got it. After I handed it over, he passed it to some demon chick. Then they tied me up and left me to these guys. I really don't know much else.""",

	FINDFRED_TALK1_ANSWER6 = """— No, please, I'll be executed for treason! You gotta believe me, I didn't know. Look, I can't go back, but if you let me go, you can have the first half of what I got paid. Five hundred gold just to look the other way, what do you say?""",

	FINDFRED_AFTERWIN_QUESTION7 = "This is not about gold, you will have to answer for your betrayal.",
	FINDFRED_AFTERWIN_QUESTION8 = "I guess I could say that you escaped, but what would you do then?",

	FINDFRED_TALK1_ANSWER7 = """— No, please! You gotta believe me, I didn't know. Look, I can't go back, but if you let me go, you can have the first half of what I got paid. Five hundred gold just to look the other way, what do you say?""",

	FINDFRED_AFTERWIN_QUESTION9 = "Funny of you to expect you could buy me *kill*",

	FINDFRED_LINE_END = "Despite Fred's protests, you decide to take him back to Duncan.",
	FINDFRED_LINE_END_KILL = "Fred continues pleading, but you're not listening anymore. You strike him down and go to work collecting proof you'd completed your task. You exit the cave a little while later with Fred's head in the same sack he'd likely concealed the sword in earlier.",

	FINDFRED_TALK1_ANSWER8 = """— I... I don't really know. I guess I'll have to get out of the country. I don't think I'd be safe with either the rebels or the guilds now. Maybe I'll be able to get through the border.""",

	FINDFRED_AFTERWIN_QUESTION10 = "Alright, I believe you.",
	FINDFRED_AFTERWIN_QUESTION11 = "Fine, the money can serve to repair some of the damage you've done at least.",
	FINDFRED_AFTERWIN_QUESTION12 = "Forget it, you'll answer for your treachery.",
	FINDFRED_AFTERWIN_QUESTION13 = "Forget it, you die here.",

	FINDFRED_TALK1_ANSWER9 = """— Thank you! I left the money back in my room. There's a stash under the loose floorboard near the window.
You release Fred and let him go on his way then get ready to depart.""",


		FINDFRED_TALK1_ANSWER10 = """Bandits give you a doubtful look.

{color=aqua|Small Bandit: — Hey, why won't we take it?}

{color=yellow|Fat Bandit: — Yea, I don't wanna be here anymore.}

{color=aqua|Boss: — Fine, fine, 300 gold and you can have him.}""",

	FINDFRED_BRIBE_TAKEN = """You pass them the money and they prepare to leave.

{color=aqua|Boss: — Nice working with you. Oh, uh just in case someone else shows up, there's no need to mention our little deal.}""",

	FINDFRED_BRIBE_REFUSED = """{color=aqua|Boss: — Well, that's a shame because we can't just let you leave after finding us here.}""",

	FINFRED_BRIBE_OPTION1 = "Agree",
	FINFRED_BRIBE_OPTION2 = "Refuse",

	FINDFRED_LINE_END_KILL2 = "You cut off further protests by stuffing the gag back in Fred's mouth and lead him out of the cave.",

	FINDFRED_TALK_FAIL = "{color=aqua|Boss: — Yea', I don't think so. You'll have to tell us who you are after we beat the shit out of you.}",

	# *Intermission scene— starts 1 hour after deleting location, black screen transition; greg and demoness as sprites

	INTERMISSIONINTRO1 = """Hiding from others' eyes one of the rebel leaders has been meeting the previously recruited helper.

{color=aqua|Greg: — You've got your fancy sword. I trust we are even now.}

{color=yellow|Demon: — I can't complain, enabling you to pull off that mass teleportation performance serves our interests as well.}""",

	INTERMISSIONINTRO2 = """{color=aqua|Greg: — Perfect, then get lost. I would prefer us not being seen together, especially by the princess.}

{color=yellow|Demon: — Now, don't be so harsh. The cult offered its assistance not just for the sake of the artifact. We could do more, you know.}

{color=aqua|Greg: — I'm not giving you anything else, we don't need your help anymore.}

{color=yellow|Demon: — Hmph, as you wish.}""",

	INTERMISSIONINTRO3 = """As Greg left the scene, Demon thought to herself.

{color=yellow|Demon: — Still, there's more to be gained here. I think I'll stay for a bit.}""",

	RETURNTOMYR_IF_FRED = """— So you found him. Nice work, I've already sent him to Duncan along with your report.
This should ease tensions between the guilds, until something new comes up. Here, consider this a tip from me, and go report to Duncan next.""",

	RETURNTOMYR_IF_NOT_FRED = """— So you found him and took care of him. Good, I've already sent a note to Duncan.
This should ease tensions between the guilds, until something new comes up. Here, consider this a tip from me, and go report to Duncan next.""",

	FREDQUESTREPORT = "About Fred...",
	FREDFIGHTERSQUESTREPORT = "About the mages issue...",
	PRINCESS_SEARCH_INITIATE = "How does your search goes?",

	RETURNTOMYR = """— So it was him after all, and we've lost the artifact as well... I expected as much. Here, take this report and get it to Duncan, I need to make some... arrangements if you'll excuse me.""",

	RETURNTODUNCAN_IF_FRED = """— Good work finding the culprit, we've taken him to the jail where he will be awaiting punishment.""",
	RETURNTODUNCAN_IF_FRED_QUESTION1 = "Tell what you learned",
	RETURNTODUNCAN_IF_NOT_FRED = "— So the traitor is dead. Allow me to ask, was there no other choice but to kill him?",

	RETURNTODUNCAN_IF_NOT_FRED_QUESTION1 = "I had to defend myself.",
	RETURNTODUNCAN_IF_NOT_FRED_QUESTION2 = "It was my decision.",

	RETURNTODUNCAN1 = "— Just a report, huh? I take it you didn't find the actual culprit then.",
	RETURNTODUNCAN2 = "— So that's how it was. I'd have preferred to have questioned him first, but what's done is done.",

	RETURNTODUNCAN_ANSWER1 = """{color=aqua|— Greg... Well I'll be damned, he was one of the older knights back in the day, but he went missing during the coup. I thought he was killed but it seems I was wrong. I have no clue who the demon woman might be though...}""",

	RETURNTODUNCAN_TOWNCAPTURE = """Before Duncan could finish, a messenger barged in the room with a panic shown on his face.

— Sir, the rebels have captured Millford! """,
	RETURNTODUNCAN_ANSWER1_1 = """

— Curses.. They were this prepared for it.— Duncan took a deep breath and resumed like it was nothing.

— Anyway, good work, but we have more immediate problems now. The rebels have taken other key sites including one of the forts and are using it as a base of operations to launch attacks on our trade and supply routes. They'll expect us to try to take back the town, but it's not clear if they've realized how important one of the other sites they took is to us. The Workers can provide you with more information on this critical disruption. I'm short-handed. When you can manage it, go see Sigmund and take care of it.""",

	RETURNTODUNCAN_QUESTION1 = "I'll see what I can do.",
	RETURNTODUNCAN_QUESTION2 = "Of course, I have nothing better to do...",

	RETURNTODUNCAN_ANSWER2 = "— Better not delay, every moment counts for us now.",

	RETURNTODUNCAN_EXTRA1 = """— This is obviously Mages' fault. Myr should know who's the one responsible. Once you find him, we will not hesitate with the proper punishment.""",

	#Intermission scene 2

	INTERMISSION2INTRO1 = """The rebel army stood in front of a small settlement recently turned into a battlefield.

{color=yellow|Anastasia: — Uncle! Why didn't you let me talk to them before attacking?!}

{color=aqua|Greg: — Those were guilds' trained soldiers.}

{color=yellow|Anastasia: — They had asked to see me in person though. We could've avoided all of this death and destruction.}""",

	INTERMISSION2INTRO2 = """Despite his unwillingness to answer at all, Greg had to answer carefully since Anastasia had made her protest in the presence of so many rebel soldiers...

{color=aqua|Greg: — You are too naive, Princess. There could have been assassins amongst them sent simply for your head. Our enemies are treacherous opportunists, this is how they work.}

{color=yellow|Anastasia: — ... it's not supposed to be like this. What good is it to free the people from tyranny if they die in the process of being liberated? We must avoid harming innocents and such needless losses.}""",

	INTERMISSION2INTRO3 = """{color=yellow|Anastasia: — I've decided. Release the survivors so they can return home.}

{color=aqua|Greg: — What!?}

{color=yellow|Anastasia: — This is the minimum we can do now to show our good will and noble intentions.}

{color=aqua|Greg: — ...Fine, but don't fool yourself. You will not retake the throne through mercy or kindness.}""",

	INTERMISSION2_IF_AIRE_DEAD = """{color=yellow|Anastasia: — Is there any news from Aire? She's still not back?}

{color=aqua|Attendant: — I'm afraid not your highness. She has yet to return.}

{color=yellow|Anastasia: — Ah... Aire, I could really use your company right about now. I hope you are safe.}""",

	INTERMISSION2_IF_AIRE_ALIVE = """{color=yellow|Anastasia: — Do you think I was wrong to demand their release?}

{color=aqua|Aire: — I'm sorry, It's not my place to judge you, your highness.}

{color=yellow|Anastasia: — Aire, please.}

{color=aqua|Aire: — I'm just your tool, your highness. Your will is all that matters to me.}

Noticing the princess's angry stare Aire quickly adds.

{color=aqua|Aire: — But, I guess, I would prefer to be able to return home if I were in their place.}""",

	INTERMISSION2_IF_AIRE_RAPED1 = """{color=yellow|Anastasia: — I didn't get a chance to ask, but how did your last assignment go? You've been sullen ever since you returned. Did something bad happen?

The princess notices Aire tensing up in response to the question.

{color=aqua|Aire: — ... It's nothing worth mentioning to you.}""",

	INTERMISSION2_IF_AIRE_RAPED2 = """{color=yellow|Anastasia: — You didn't get injured again, did you?}

{color=aqua|Aire: — I'm fine, as long as I can continue to serve you.}

{color=yellow|Anastasia: — Hmm... I wonder if all elves are like this.}""",

	INTERMISSION2_IF_AIRE_NOT_RAPED1 = """{color=yellow|Anastasia: — I didn't get a chance to ask, but how did your last assignment go? You've been very lively ever since you returned, and I could use a bit of good news just about now.}

{color=aqua|Aire: — Oh, yes. Actually I got in just slightly over my head this time.}""",
###
	INTERMISSION2_IF_AIRE_NOT_RAPED2 = """{color=yellow|Anastasia: — Aire! You said you would be careful. You said— wait, why have you been so cheerful then?}

{color=aqua|Aire: — I... Well I was rescued.}

{color=yellow|Anastasia: — A rescuer? Do tell.}

{color=aqua|Aire: — I don't really know much about [him], I believe [his] name was [name]. [He] seemed like a... well a good person I think.}""",
###
	INTERMISSION2_IF_AIRE_NOT_RAPED3 = """{color=yellow|Anastasia: — [name]? We should properly reward [him], once this whole mess is over.}

{color=aqua|Aire: — Ana, you really don't need to do that.}

{color=yellow|Anastasia: — Don't be silly, I owe [him] my gratitude at the very least. You've been my friend for so long after all. What would I have done if you hadn't returned?}

{color=aqua|Aire: — ...}""",

	SIGMUNDOPTION = "— Aye? That's a relief to 'ear. I guess ya came for da details? One of our mines 'ave been overtaken by rebels.",

	SIGMUND_QUESTION1 = "One shouldn't be a problem, should it?",
	SIGMUND_QUESTION2 = "Something special about this one?",

	SIGMUND_ANSWER1 = "— It's not yet, but it's actually da major one for the magic ore used for enchantable alloys. Dis is not widely known information, but it seems da rebels knew where to strike. In a couple weeks, we'll run out and hafta turn to inferior metals. It might not seem like much, but while da rebels hold it, they can make use of the ore instead.",

	SIGMUND_QUESTION3 = "I'll be glad to help.",
	SIGMUND_QUESTION4 = "Anything goes as long as I get to beat more rebels.",
	SIGMUND_QUESTION5 = "Surely with such high stakes I'll be due some reward for my efforts.",

	SIGMUND_ANSWER2 = """— Yah, it wouldn't be da problem, but it's actually da major one for the magic ore used for enchantable alloys.
Dis is not a wide known information, but it seems da rebels knew where to strike.""",

	SIGMUND_ANSWER3 = "— Great, I'll mark it on ya map.",
	SIGMUND_ANSWER4 = "— Argh, darn, fine, as long as you deal with it.",

	SIGMUND_EXTRA1 = """— Ya know, I wasn't around at da time of king's death. Yah, non-humans weren't allowed to take any major posts. I dun really like the whole war business, but obviously ya won't see me siding with fans of those times.""",


	STATOBDRAINREDUCTION = "Obedience Drain Decrease",
	STATOBDRAININCREASE = "Obedience Drain Increase",
#	STATAUTHORITY_MOD = "Authority Growth",

	ITEMCHEST_ADV_CLOTH = "Coat",
	ITEMLEGS_ADV_CLOTH = "Mantle",
	ITEMCHEST_ADV_LEATHER = "Advanced Medium Armor",
	ITEMLEGS_ADV_LEATHER = "Advanced Medium Pants",
	ITEMCHEST_ADV_METAL = "Advanced Heavy Armor",
	ITEMLEGS_ADV_METAL = "Advanced Heavy Pants",
	ITEMCHEST_ADV_CLOTHDESCRIPT = "Advanced mage armor besides protection provides boost to wearer's powers, however requires additional materials. ",
	ITEMLEGS_ADV_CLOTHDESCRIPT = "Advanced mage armor besides protection provides boost to wearer's powers, however requires additional materials. ",
	ITEMCHEST_ADV_LEATHERDESCRIPT = "A more complex medium armor usually made of lighter materials, yet providing reasonable defense. ",
	ITEMLEGS_ADV_LEATHERDESCRIPT = "A more complex medium armor usually made of lighter materials, yet providing reasonable defense. ",
	ITEMCHEST_ADV_METALDESCRIPT = "A heavy metal armor of higher craftsmanship shown by using additional materials. ",
	ITEMLEGS_ADV_METALDESCRIPT = "A heavy metal armor of higher craftsmanship shown by using additional materials. ",

	ITEMSWORDADV = "Heavy Sword",
	ITEMSTAFFADV = "Master Staff",
	ITEMSPEARADV = "Great Spear",
	ITEMBOWADV = "Longbow",
	ITEMSWORDADVDESCRIPT = "A masterful weapon forged with inclusion of additional materials.",
	ITEMSTAFFADVDESCRIPT = "A masterful weapon forged with inclusion of additional materials.",
	ITEMSPEARADVDESCRIPT = "A masterful weapon forged with inclusion of additional materials.",
	ITEMBOWADVDESCRIPT = "A masterful weapon forged with inclusion of additional materials.",

	ARMORENC = "Encrustment",
	WEAPONENC = "Encrustment",

	ITEMLATEX_SUIT = "Latex Suit",
	ITEMLATEX_SUITDESCRIPT = "A tight clothing accentuating curves of the body.",

	MATERIALTROLL_BLOOD = "Troll Blood",
	MATERIALTROLL_BLOODDESCRIPT = "A vial of red fluid obtained from defeating trolls.",
	MATERIALINK_BASE = "Ink Base",
	MATERIALINK_BASEDESCRIPT = "A special ink suited for being imbued with magic. Serves as a basis for tattos. ",
	MATERIALICE_CRYSTAL = "Eternal Ice",
	MATERIALICE_CRYSTALADJ = "Ice",
	MATERIALICE_CRYSTALDESCRIPT = "A rare crystal holding some magic properties which can be used in craft.",
	MATERIALFIRE_RUBY = "Fire Ruby",
	MATERIALFIRE_RUBYADJ = "Fire",
	MATERIALFIRE_RUBYDESCRIPT = "A rare gem storing some magic power which can be utilized in craft.",
	MATERIALLIZARD_SKIN = "Lizard Scales",
	MATERIALLIZARD_SKINADJ = "Scale",
	MATERIALLIZARD_SKINDESCRIPT = "Lizard skin with some magic properties which can be used in craft.",
	MATERIALINSECT_CHITIN = "Chitin",
	MATERIALINSECT_CHITINADJ = "Chitin",
	MATERIALINSECT_CHITINDESCRIPT = "An insect exoskeleton which can be used in craft.",
	MATERIALOGRE_TEETH = "Ogre Teeth",
	MATERIALOGRE_TEETHADJ = "Ogre",
	MATERIALOGRE_TEETHDESCRIPT = "Sharp fangs of a monster often considered a potential alchemy ingredient and holding medical properties.",
	MATERIALCRYSTALIZED_ETHER = "Crystalized Ether",
	MATERIALCRYSTALIZED_ETHERADJ = "Air",
	MATERIALCRYSTALIZED_ETHERDESCRIPT = "Dull round gems possessing the element of Air. Can be used in craft",
	MATERIALEARTH_SHARD = "Earth Shard",
	MATERIALEARTH_SHARDEARTH = "Earth",
	MATERIALEARTH_SHARDDESCRIPT = "A rare gem storing some magic power which can be utilized in craft.",

	QUESTREQSCOMPLETE = "Quest subtask complete",

	ENEMYTYPEBANDITS = "Bandits",
	ENEMYTYPEWOLVES = "Wolves",
	ENEMYTYPEUNDEAD = "Undeads",
	ENEMYTYPEGOBLIN = "Goblins",

	UPGRADETATTOO_SET = "Beauty Parlor",
	UPGRADETATTOO_SETDESCRIPT = "An upgrade unlocking new interactions",
	UPGRADETATTOOBONUS = "Unlocks application of tattoos.",

	TATTOOFACE = "Face",
	TATTOONECK = "Neck",
	TATTOOCHEST = "Chest",
	TATTOOARMS = "Arms",
	TATTOOWAIST = "Waist",
	TATTOOASS = "Ass",
	TATTOOCROTCH = "Crotch",
	TATTOOLEGS = "Legs",

	STATDAMAGE_MOD_FIRE = "Fire Damage",
	STATDAMAGE_MOD_WATER = "Water Damage",
	STATDAMAGE_MOD_AIR = "Air Damage",
	STATDAMAGE_MOD_EARTH = "Earth Damage",
	STATDAMAGE_MOD_LIGHT = "Light Damage",
	STATDAMAGE_MOD_DARK = "Dark Damage",
	STATDAMAGE_MOD_MIND = "Mind Damage",
	STATDAMAGE_MOD_MELEE = "Melee Damage",

	ENEMYMANEATER_PLANT = "Maneater Plant",
	ENEMYCENTIPEDE = "Centipede",
	ENEMYOGRE_ALPHA = "Ogre Alpha",
	ENEMYROCK_THROWER = "Rockthrower",
	ENEMYGIANT_ANT = "Giant Ant",
	ENEMYSALAMANDER = "Salamander",
	ENEMYGREAT_VIPER = "Great Viper",
	ENEMYIFRIT = "Ifrit",
	ENEMYANTHROPOID = "Anthropoid",
	ENEMYMAGMA_BEAST = "Magma Beast",
	ENEMYEREBUS_STONE = "Erebus Stone",
	ENEMYWILD_RAPTOR = "Raptor",
	NO_FIGHT_LOW_OBED = "[name] refuses to participate in a fight. (Combatant must be unlocked)",
	CHAR_NO_COMBAT = "[name] has sustained a grave injury and is unable to participate in fights.",
	SENDCHARTOQUESTCONFIRM = "Send this character to quest?",

	SKILLPOISON_BITE = "Poison Bite",
	SKILLENTANGLE_ENEMY = "Entangle",
	SKILLSHRED = "Shred",


	AIRE_AMELIA1 = """
Amelia entered Aire's cell with a neat black satchel and a smile on her face.

{color=aqua|Amelia: — Hello darling. Aire, if I'm correct? I hope the jailers weren't too harsh with you. It seems our little investigation isn't going fast enough, so I was asked to apply my skills to loosen your tongue. }

At her words Aire glanced at the bag imagining all manner of blades and hooks that must be inside and then looked to the cat woman in her revealing attire with confusion.

{color=yellow|Aire: — I won't reveal anything, not to you or anyone else no matter what you do. }

{color=aqua|Amelia: — That's cute. I believe you are a capable fighter and can withstand physical abuse, but I have my own ways of doing things. }""",

	AIRE_AMELIA2 = """
Amelia retrieved a small flask of honey colored liquid which she upended against a handkerchief for a moment before stoppering it. Aire stood to her feet to struggle as best she could rather than be poisoned, but none of her training was of any use bound as she was. Amelia twisted her by her restraints and collar roughly before wrapping an arm around her and forcing the handkerchief over her nose and mouth.

{color=aqua|Amelia: — Just breath in deeply. It won't harm you.}""",

	AIRE_AMELIA3 = """
Aire held her breath for over a minute. She struggled the whole time as Amelia held her firmly while chatting to her casually as if they were friends, but the burning in her lungs became too much and she desperately gulped breaths laced with the drug. Amelia held her like that until her breathing became steady and her body started to relax.

{color=aqua|Amelia: — Now, I understand you've heard some nasty rumors about my colleagues and I, but we can be quite generous with our partners. For instance, the drug I've just shared with you can't normally be found here at any price. They say one of the ingredients is actual Alruane nectar.}

Aire's heart had begun pounding and her body grew unbearably sensitive. Amelia idly fondled her trussed breasts and periodically pinched her nipples, eliciting jerks and squeals from the elf that gradually became shudders and moans.

{color=aqua|Amelia: — I see your voice has become more excited. Why won't you tell us what we want to know? To continue resisting like this... you must be quite fond of your master? Perhaps, even share a more intimate bond.}""",

	AIRE_AMELIA4 = """
{color=yellow|Aire: — It's not... like... that}

Amelia squeezed her breasts against Aire, leaning against her in such a way that Aire would fall unless she widened her stance and arched her back. Amelia's soft finely furred tail felt like it was made of pins and needles as it slid along Aire's leg slowly upward.

{color=aqua|Amelia: — Ah, another innocent elf maiden! I almost miss training the newcomers personally. }

Amelia's tail had made its way to Aire's panty clad sex and twitched from side to side, stimulating her now swollen clit through the material. She just couldn't think.

{color=aqua|Amelia: — Look at you, all wet and shaking. It's pains me to torture a cute girl like that. And you must be really eager for me to end this.}""",

	AIRE_AMELIA5 = """
{color=yellow|Aire: — Yes...}

Aire's eyes teared up with humiliation as she couldn't fight the overwhelming pleasure anymore.

{color=aqua|Amelia: — So we both want the same thing. You know how this can be done, tell me where Anastasia is.}

Amelia slid a hand down from Aire's chest to pull her panties to the side, and gently traced her fingers up and down her slick slit. Under the influence of the intense aphrodisiac Aire's hips thrusted at the digits without and against her conscious thought.

She pooled all of her will into one last attempt to twist away, but Amelia held her in place thrusting two fingers inside her and using her pussy as a handhold. Aire melted and began to tremble violently, but Amelia slipped her fingers back out and resumed teasing Aire's slit, keeping her on the edge.

{color=yellow|Aire: — Ah, p-please... }""",

	AIRE_AMELIA6 = """

{color=aqua|Amelia: — One word and you'll get what you want. }

{color=yellow|Aire: — ...F-fine.}

Aire turned her head and whispered. Amelia's ear twitched as the elf breathed heavily into it and she beamed.

{color=aqua|Amelia: — Good girl. Now, here's your reward.}

Amelia snaked her long tail back up Aire's leg, wriggling it back and forth, finally working it into her drooling honeypot. Aire moaned and bucked futilely against Amelia's hips on pure carnal instinct, but Amelia delivered a slow deliberate pace. Aire inhaled and just as she was about to cum, Amelia began thrusting into her without as much force as a man might have but much faster.

The sudden stimulation was overwhelming in the poor elf's hypersensitive state. She clenched and shook so wildly she stopped breathing and her eyes rolled back. One orgasm overlapped with another over minutes as Amelia pistoned her tail into the young elf until she blacked out.

Amelia lowered the spasming girl to the floor gently and retrieved her satchel after cleaning off.

{color=aqua|Amelia: — See, was that so hard? Hope we'll meet again in better circumstances. }

She purred to herself and put a little sway into her hips on her way out as she gave orders to the jailers and went to deliver the good news.""",



	# HELP SIGMUND
	HELP_SIGMUND_OPTION_0 = """I've been asked to help you""",

	HELP_SIGMUND_START = """— Aye? That's a relief to 'ear. I guess ya came for da details? One of our mines 'ave been overtaken by rebels.""",
	HELP_SIGMUND_OPTION_1 = """One shouldn't be a problem, should it?""",
	HELP_SIGMUND_OPTION_2 = """Something special about this one?""",
	HELP_SIGMUND_1 = """— It's not, but it's actually da major one for the special ore used for enchantable alloys. Dis is not widely known information, but it seems da rebels knew where to strike.""",
	HELP_SIGMUND_OPTION_3 = """Will be glad to help""",
	HELP_SIGMUND_OPTION_4 = """Anything goes as long as I get to beat more rebels""",
	HELP_SIGMUND_OPTION_5 = """Hope I'll be rewarded for it.""",
	HELP_SIGMUND_2 = """— Yah, it wouldn't be da problem, but it's actually da major one for the special ore used for enchantable alloys. Dis is not widely known information, but it seems da rebels knew where to strike.""",
	HELP_SIGMUND_3 = """— Great, I'll mark it on ya map.""",
	HELP_SIGMUND_4 = """— Argh, darn, fine, as long as you deal with it.""",

	# MINES ARRIVAL
	MINES_ARRIVAL_START = """A few hundreds feet away from it you find a half-abandoned post. As you approach it you are met by one of the men, who appears to be a local miner and seems relieved to meet you.

— Hello, [Sir]! You must've been sent by the guild. I'm sorry, but the mine was overtaken by rebels a few days ago and we were driven out with a few people who refused to leave taken as prisoners.""",
	MINES_ARRIVAL_OPTION_1 = """What can you tell me about the mines?""",
	MINES_ARRIVAL_OPTION_2 = """What did the rebels come for?""",
	MINES_ARRIVAL_OPTION_3 = """I'll deal with it, you can stay back""",
	MINES_ARRIVAL_1 = """— I've only been working here for a few months. Seems to be quite old and deep but I was mostly working at the upper floors.""",
	MINES_ARRIVAL_2 = """— I dunno, it's not like they had to explain themselves. I've seen some weird folks leaving the mine after loading crates onto cartsthough""",
	MINES_ARRIVAL_OPTION_4 = """What was so weird about it?""",
	MINES_ARRIVAL_OPTION_5 = """Who was leading them?""",
	MINES_ARRIVAL_OPTION_6 = """That's enough about them""",
	MINES_ARRIVAL_3 = """— It was during the night and they looked like they were trying to stay hidden, didn't light any torches or lamps.""",
	MINES_ARRIVAL_4 = """— It was some guy in a robe with a large hood. He was only ordering others around and it felt like he didn't want to show his face otherwise. I think even the rebels were somewhat afraid of him.""",
	MINES_ARRIVAL_5 = """— Yeah, the faster you deal with them, the better.""",
	MINES_ARRIVAL_6 = """— That's great, I knew we could rely on you. I'll let the others know, if you don't mind.

The man disappears in the opposite direction and you proceed to the mine's entrance.""",

	# HALF DUNGEON EXPLORED
	HALF_DUNGEON_EXPLORED_START = """As you walk through the shaft you suddenly realize that someone is coming from behind. As you lay in ambush to meet the new enemy a lone orc casually walks by seeming very out of place.

— Oh, Hello. I'm not an enemy, my name is Kurdan. Pleasure to meet you stranger. I seem a bit lost, would you mind giving me directions?""",
	HALF_DUNGEON_EXPLORED_OPTION_1 = """You look suspicious""",
	HALF_DUNGEON_EXPLORED_OPTION_2 = """What are you doing here""",
	HALF_DUNGEON_EXPLORED_1 = """— I've been invited to a gathering for Erebus followers and those who are interested. Look...

He shows you a dull, uncommon metal bracelet hanging from his wrist.

— This is both proof of invitation and my involvement. I thought I might give it a try since it's been difficult to survive as an arcane practitioner in our lands recently, but it seems this country has some complex issues as well.""",

	HALF_DUNGEON_EXPLORED_OPTION_3 = """What's been going on in your lands?""",
	HALF_DUNGEON_EXPLORED_OPTION_4 = """Is practicing magic really worth leaving your country?""",
	HALF_DUNGEON_EXPLORED_OPTION_5 = """I know nothing about this""",
	HALF_DUNGEON_EXPLORED_2 = """— Huh, I guess the word hasn't spread yet. The practice of magic is no longer welcome by the orcish authorities. It's because of the ongoing war against the Thoth. Anyone practicing sorcery is viewed as a threat. Most unfortunate circumstances.""",
	HALF_DUNGEON_EXPLORED_3 = """— It's not about magic... Not entirely at least. You see, learning magic gave me great insight as to the nature of the world. Some aim to use it for everyday purposes or adventures, but by tapping into magical energies you also get closer to understanding the underlying principles of existence itself. """,
	HALF_DUNGEON_EXPLORED_4 = """— I see... Well, I should continue my small pilgrimage in this case. Since I've left my homeland I'm in a tight spot here unless I can find shelter.""",
	HALF_DUNGEON_EXPLORED_OPTION_6 = """I'm performing an investigation on behalf of the guilds and I'd prefer you leave this place""",
	HALF_DUNGEON_EXPLORED_OPTION_7 = """I could use a magic user. You could join me and stay at my mansion""",
	HALF_DUNGEON_EXPLORED_OPTION_8 = """Since I'm going to clear all rebels out of here you could join me until then""",
	HALF_DUNGEON_EXPLORED_5 = """— Oh... Hmm, I see, this is unfortunate. Perhaps I'll visit at a different time then. Adieu.""",
	HALF_DUNGEON_EXPLORED_6 = """— Well, this is a generous offer in my book. Are you sure about this? I might not be able to refuse.""",
	HALF_DUNGEON_EXPLORED_OPTION_9 = """I'm sure""",
	HALF_DUNGEON_EXPLORED_OPTION_10 = """On second thought...""",
	HALF_DUNGEON_EXPLORED_7 = """— I'm sorry, I think I'm obliged to attend the meeting I came to attend. But thank you for the invitation, I'll consider it in future.""",
	HALF_DUNGEON_EXPLORED_8 = """— Alright then, I'll accept rather than putting myself in danger around here.

You explain to Kurdan how to get to Aliron and find your place after which he leaves""",
	HALF_DUNGEON_EXPLORED_9 = """— Yes, this will work for me. Alright then, allow me to accompany you on this journey.""",

	# PRE_FINAL BOSS
	PRE_FINAL_BOSS_START = """As you reach the final room you are met by a group of rebels lead by a woman of demonic origin.

— Well, if it ain't a knight in shining armor. I guess the guilds finally got here. Too bad we are already done and I won't be staying with you for long.""",
	PRE_FINAL_BOSS_OPTION_1 = """And who exactly are you?""",
	PRE_FINAL_BOSS_OPTION_2 = """I thought the rebel leader was male""",
	PRE_FINAL_BOSS_OPTION_3 = """You better surrender now if you wanna live""",
	PRE_FINAL_BOSS_1 = """— That's not really important, I'm only here for an errand, but it seems I'll get dragged into it at this point.""",
	PRE_FINAL_BOSS_2_1 = """— Male, female, who really cares, all these names are so meaningless after all.""",
	PRE_FINAL_BOSS_2_2 = """— Male, female, who really cares, all these names are so meaningless after all.

The demon turns to Kurdan who was quietly observing what's been going on so far.

— Don't you agree with me, orc?""",
	PRE_FINAL_BOSS_3 = """— Please, I'm shaking all over here.

— I presume you've come here to restore the mine's to production, and you've been unfortunate enough to find me here. However, I have an offer for you. I do not wish to fight yet so if you let me take the miners we kept as prisoners I'll leave in peace so you can do with the rest of these rebels however you want.

{color=aqua|Rebel: — Hey, you traitorous bit-..}

— Silence, putzes.

Demon's voice shook the air and her underling froze in place.""",
	PRE_FINAL_BOSS_4 = """— I believe this is a good deal for you. After all, these people are mere peasants, what's the point in risking your life for them? I'm sure your employers will be able to replace them.

The prisoners overhearing your conversation closely observed your reaction in fear.""",
	PRE_FINAL_BOSS_OPTION_4 = """This is a reasonable offer""",
	PRE_FINAL_BOSS_OPTION_5 = """No deal, you demon""",
	PRE_FINAL_BOSS_5 = """— Hah, now that's my kind of hero. A smart choice. We'll be leaving shortly then.

You observe as the demon leaves taking the frightened miners with her.""",
	PRE_FINAL_BOSS_6 = """— This wasn't the most principled of outcomes, but you are in your right to do so. I'm sorry, [name], but I'll be leaving here.

Kurdan leaves following the demon's path.""",
	PRE_FINAL_BOSS_7 = """You turn to the remaining rebels but realizing they won't be getting a pardon, they do not show signs of surrender.

— Screw that demon bitch, you won't take us alive!""",
	PRE_FINAL_BOSS_8 = """{color=aqua|Demon: — So trying to play it all the way to the end, eh? And what do you think about it... Kurdan, if I'm correct? Haven't you come here for enlightenment?}

{color=yellow|Kurdan: — It seems I've been misguided. I'll have to side with [name] here.}

{color=aqua|Demon: — Is that so... How unfortunate. Oh well, I still could use an extra hand now, you did kept your invitation sigil, right?}""",
	PRE_FINAL_BOSS_PALADIN_OPTION = """I'd never accept such a foul offering, I'll protect the innocent (Paladin)""",
	PRE_FINAL_BOSS_KNIGHT_OPTION = """I'd never accept such a foul offering, I'll protect the innocent (Knight)""",
	PRE_FINAL_BOSS_PALADIN_KNIGHT = """{color=aqua|Demon: — ... I can't believe you are this old fashioned. Very well, I'll make you regret your charade. Hey, you-}

{color=yellow|Kurdan: — I'm not going to help your cause, Demon. This [man]'s dedication has moved me and I want to see [him] in action.}

{color=aqua|Demon: — Hmph, whatever, I don't need your powers to do it.}
""",

	PRE_FINAL_BOSS_PALADIN_KNIGHT_WIN_KURDAN = "",

	PRE_FINAL_BOSS_9 = """The bracelet on the Kurdan's hand erupted in dim purple glow as the demon mumbled a spell. Before you could react, Kurdan's posture and movements changed. He steadily went to the demon's side preparing for battle.

{color=aqua|Demon: — You should be useful in this dispute. Now, let's see if you are even worth our time, [name].}""",
	PRE_FINAL_BOSS_10 = """— So trying to play it all the way to the end, eh? Fine, let's see if you are even worth considering.""",
	PRE_FINAL_BOSS_11 = """After you defeat the last rebels there's nothing left at the mines and you can report back to the Workers Guild.""",
	PRE_FINAL_BOSS_12 = """— Must admit, you aren't half bad. Well, I'm done for today, this place is no fun after all. Let us meet again, hero.

Before you can stop her, she chants a quick spell and disappears in a magic vortex.""",
	PRE_FINAL_BOSS_13 = """As the demon leaves, Kurdan falls to the ground regaining his senses.

— Uugh... Dammit. I'm terribly sorry for this. I couldn't control myself. Looks like I was fooled into coming here. How can I atone for my transgressions?""",
	PRE_FINAL_BOSS_OPTION_6 = """You can join me""",
	PRE_FINAL_BOSS_OPTION_7 = """I'll bring you to the authorities""",
	PRE_FINAL_BOSS_OPTION_8 = """You should leave""",
	PRE_FINAL_BOSS_14 = """— Hmmh, so be it. If I can repay you this way, I'll do it.""",
	PRE_FINAL_BOSS_15 = """— I-I understand. So be it, I will entrust myself to your authorities.""",
	PRE_FINAL_BOSS_16 = """Kurdan nods in agreement and slowly leaves the hall.""",
	PRE_FINAL_BOSS_17 = """You release the imprisoned miners and receive their gratitude.

— Thank you, [Sir]! We don't know how to repay you for this.""",
	PRE_FINAL_BOSS_OPTION_9 = """No payment is needed, just get back to work""",
	PRE_FINAL_BOSS_OPTION_10 = """Well, I could use some payment since you offered.""",
	PRE_FINAL_BOSS_18 = """— You truly are generous. We will report to the guild once we are ready to get back to mining.

Saying goodbye you leave the mines and head back to Aliron.""",
	PRE_FINAL_BOSS_19 = """— It isn't much, but we have some ore left. You can take it.

You take the foreman's reward and head back to Aliron.""",

	#After mines
	AFTER_MINES_WORKERS_OPTION_1 = """I've solved the issue with the mines""",
	AFTER_MINES_SIGMUND_START = """— That's great news. I've already made da preparations so we will resume da work as soon as possible. Ya've earned yar reward.

Sigmund passes you the pouch with some gold in it.

{color=green|Received 300 gold}""",
	AFTER_MINES_SIGMUND_OPTION_1 = """Thanks, if there's nothing else I'll be going""",
	AFTER_MINES_SIGMUND_OPTION_2 = """There was somebody unusual among the rebels""",
	AFTER_MINES_SIGMUND_1 = """— Go on, I think Duncan will be interested to hear dat ya done.""",
	AFTER_MINES_SIGMUND_2 = """— Ya? Well, it ain't our problem, better report about it to Duncan.""",
	AFTER_MINES_WORKERS_OPTION_2 = """I've solved the issue with the mines, but there were some casualties""",
	AFTER_MINES_SIGMUND_3 = """— Ya' I've received some reports. It seems some of da workers were taken after yer operation. We can't do a proper investigation right now, and I can't give you any extra reward. Ya should go see Duncan.""",

	AFTER_MINES_FIGHTERS_OPTION_1 = """I'm done with the Workers' issues""",
	AFTER_MINES_DUNCAN_1 = """— That's so. I've been getting some reports on the subject. Can you add anything?""",
	AFTER_MINES_DUNCAN_OPTION_1 = """There was an Orc traveller at the mines""",
	AFTER_MINES_DUNCAN_OPTION_2 = """I've ran into a female demon out there""",
	AFTER_MINES_DUNCAN_OPTION_3 = """Nothing else really worth mentioning""",
	AFTER_MINES_DUNCAN_2 = """— An orc? Huh, that's unusual for them to walk into our lands. But a lone orc is not something worthy of attention, if they were going to make a move we would know about it already, but they haven't been heard from for decades.""",
	AFTER_MINES_DUNCAN_3 = """— So, it might have been the demon you've mentioned earlier. From the way you say it, she was up to something, but it shouldn't hinder us. It's a shame to lose the relic to them, but demons are too few and scarce to present any real threat.""",
	AFTER_MINES_DUNCAN_4 = """— But I've also heard you let that demon go without a fight, and she took some workers with her. Explain yourself.""",
	AFTER_MINES_DUNCAN_3_4 = """— So, it might have been the demon you've mentioned earlier. From the way you say it, she was up to something, but it shouldn't hinder us. It's a shame to lose the relic to them, but demons are too few and scarce to present any real threat.

— But I've also heard you let that demon go without a fight, and she took some workers with her. Explain yourself.""",
	AFTER_MINES_DUNCAN_OPTION_4 = """I was outnumbered and had no choice""",
	AFTER_MINES_DUNCAN_OPTION_5 = """The miners couldn't have been saved in that moment""",
	AFTER_MINES_DUNCAN_OPTION_6 = """What's it to you? We still got the mine back up and running""",
	AFTER_MINES_DUNCAN_5 = """— You were outnumbered, but she just left? I find it hard to believe. We'll drop this for now, but know that you won't be pardoned if some deeper connection between you and that rebel helping demon comes to light.""",
	AFTER_MINES_DUNCAN_6 = """— Hmmh. Fine, I'll believe you. But know, you won't be pardoned if some deeper connection between you and that rebel helping demon comes to light.""",
	AFTER_MINES_DUNCAN_7 = """— I'll tell you what it means to me. There will be no tolerance for cooperation with our foes. I'll leave it to your imagination what will happen if we find out there's some deeper connection between you and that rebel helping demon.""",
	AFTER_MINES_DUNCAN_8 = """— So that was about it, the mine is back in production and your mission is finished. However, the timing of this is too inconvenient to think of it as of coincidence. I shall ask you, do you think the Workers might have planned this?""",
	AFTER_MINES_DUNCAN_OPTION_7 = """There might be some connection""",
	AFTER_MINES_DUNCAN_OPTION_8 = """I don't think so""",
	AFTER_MINES_DUNCAN_OPTION_9 = """I'd rather not draw any conclusions""",
	AFTER_MINES_DUNCAN_9 = """— I see. We plan for a large scale operation, so be on a standby in the next few days. I'll send you a messenger once I need you. You can go now.""",
	AFTER_MINES_DUNCAN_OPTION_10 = """I'll be waiting for it then""",
	AFTER_MINES_DUNCAN_OPTION_11 = """What a pain... I hope it's over soon""",
	AFTER_MINES_DUNCAN_OPTION_12 = """Great, finally some free time""",
	AFTER_MINES_MESSAGE = """In the morning you receive a messenger from Duncan who declares you're expected to visit him.""",
	AFTER_MINES_DUNCAN_OPTION_13 = """I've received the message""",
	AFTER_MINES_DUNCAN_10 = """— It's time. We've been preparing to siege Millford which has been captured by rebels at the firsts days of rebellion. Now we finally have enough forces for a full fledged siege.

— I'll be leading it and I have a mission for you. There's a convoy carrying additional food supplies necessary for the operation. You'll have to escort it there. After that, your forces will join the siege""",
	AFTER_MINES_DUNCAN_OPTION_14 = """This shouldn't be hard""",
	AFTER_MINES_DUNCAN_OPTION_15 = """Can't believe I have to play delivery [boy] now of all times""",
	AFTER_MINES_DUNCAN_11 = """— Don't take for granted this will be easy, there might still be rebel or bandit ambushes along the way .

— Now, we shall meet on the battlefield and put an end to this war.""",
	AFTER_MINES_DUNCAN_12 = """— We all have to make our contributions for the cause. The guilds will not forget your participation once this is over and the mayor election will resume.

— Now, we shall meet on the battlefield and put an end to this war.""",
	AFTER_MINES_CONVOY_1 = """You find the supplies you are supposed to deliver at the depot already prepared and packed on a few mules, so all you've left to do is to set out with your team.""",
	AFTER_MINES_CONVOY_OPTION_1 = """Move""",
	AFTER_MINES_CONVOY_2 = """You order to finish preparations and move out with the convoy.""",
	AFTER_MINES_CONVOY_3 = """A few hours after you've left town you enter the forest. Eventually you find the thin road among the trees blocked by a fallen log. You order the men to clear it but when they reach it a large group of rebels jump out of the woods in an attempt to stop your mission before it can begin.""",
	AFTER_MINES_CONVOY_4 = """As you strike down the leader, the remnants of the rebel group quickly retreat into the woods. You've taught them a good lesson and they shouldn't give you any more problems as you continue on your mission.""",
	AFTER_MINES_CONVOY_5 = """Your convoy leaves the forest. As Millford gets closer, you spot a small group of peasants closing on you from the front. You order to be ready for another ambush but as they get closer you notice it's only a couple of families. None of them are reasonably armed. Once in range one of men kneels before you.

— Your highness, I beg you to spare us some food. The war has been ruthless to us and soldiers took nearly all of our stocks. After that we were attacked by goblins and had to migrate. Our children are starving!""",
	AFTER_MINES_CONVOY_OPTION_2 = """This is awful, you can take as much as you need""",
	AFTER_MINES_CONVOY_OPTION_3 = """We can spare you a half of what we have""",
	AFTER_MINES_CONVOY_OPTION_4 = """It's none of my business""",
	AFTER_MINES_CONVOY_HUNTER_OPTION = """""",
	AFTER_MINES_CONVOY_HUNTER = """""",
	AFTER_MINES_CONVOY_6 = """— We can't thank you enough for this, [Sir].

After some time you are left alone with only a tenth of the original provisions. Duncan will surely not like this but there's nothing that can be done now. Perhaps at least your deed will earn you some recognition among the commonfolk...""",
	AFTER_MINES_CONVOY_7 = """You order your men to unload half of the provision and allow refugees to take it.

— Thank you, [Sir]! We will be praying for your safety.

You part ways pondering how you are going to explain this to Duncan...""",
	AFTER_MINES_CONVOY_8 = """You refuse to give the refugees any supplies. With no other option they miserably see you off.""",
	DUNCAN_NOT_FOUND = """You've tried to find Duncan, but it seems he's not around. You'll have to join him during the siege.""",
	AFTER_MINES_CONVOY_9 = """After another couple of hours your convoy finally makes it to the siege camps a few miles away from the town. A large tent camp has been set up by the guilds' united forces. Following the directions you find Duncan, debating the course of the upcoming battle. In the far corner you spot Myr quietly leaning against the wall.""",
	AFTER_MINES_CONVOY_10 = """— You've finally arrived, [name]. I've received a report that you're missing a considerable amount of the provisions you've been requested to bring. Explain yourself.""",
	AFTER_MINES_CONVOY_OPTION_5 = """I met a group of refugees who needed them""",
	AFTER_MINES_CONVOY_OPTION_6 = """Bandits attacked us and stole it in the confusion (lie)""",
	AFTER_MINES_CONVOY_11 = """— You had clear instructions, yet deliberately disobeyed. I'm disappointed in you, [name], and you will be penalized once we return back to Aliron. For now, get ready for battle.""",
	AFTER_MINES_CONVOY_12 = """— A failure is a failure. I'm disappointed in you, [name], and you will be penalized once we return back to Aliron. For now, get ready for battle.""",
	AFTER_MINES_CONVOY_13 = """— Greetings, [name]. I see you've completed your mission successfully. I'm pleased to have a capable subordinate for once.""",
	AFTER_MINES_CONVOY_14 = """Inside the settlement walls, rebels have been fortifying their defence in preparation for the upcoming battle.

{color=yellow|Aire: — The guilds forces are preparing an assault. There's roughly two thousand troops. These are trained soldiers and mages. Even in our current position I doubt we can withstand for long.}

{color=aqua|Greg: — You are not in a position to doubt anything. Take your place and get ready for battle. We have enough forces to protect this shady town and if anything I have a couple of trump cards of my own.}

{color=yellow|Aire: -... Yes Sir.}""",
	AFTER_MINES_CONVOY_15 = """A few hundred feet away from town's walls Duncan parlayed with Anastasia as is customary prior to battle.

{color=aqua|Anastasia: — It pains me to see how the people suffer because of our actions, but we won't lay down our arms. }

{color=yellow|Duncan: — I shall thank you after our victory. It's been too long since my last battle.}""",
	AFTER_MINES_CONVOY_16 = """Anastasia threw an angry glance at Duncan.

{color=aqua|Anastasia: — That's all you're gonna say now? After killing my father?}

{color=yellow|Duncan: — I have nothing else to say to a juvenile here and now. Let's get this over with.}""",
	AFTER_MINES_CONVOY_17 = """Despite her irritation Anastasia managed to collect herself and demonstrate her royal upbringing with a calm answer.

{color=aqua|Anastasia: — Very well. The gods shall find the just. }

{color=yellow|Duncan: — The gods shall find the just.}""",


	# betrayal confirmed
	BETRAYAL_CONFIRMED_ADVANCE = """The battlefield was filled with sounds of clashing blades as numerous arrows whistled through the air. Before long an enemy group has charged at your flank.""",
	BETRAYAL_CONFIRMED_1 = """After slicing down another enemy knight Duncan surveyed the battlefield. His group had pushed deep as the enemy gave ground, nearly reaching the leading enemy unit and now he could see their commander clearly. He already knew from the reports that Greg was with the rebels, but now he had confirmed it with his own eyes.""",
	BETRAYAL_CONFIRMED_2 = """{color=aqua|Greg: — Long time no see.}

{color=yellow|Duncan: — I wish it would have stayed that way. }

{color=aqua|Greg: — You look tired, did safe living make you soft?}

{color=yellow|Duncan: — I'm still collected enough to end you and this pitiful revolt.}""",
	BETRAYAL_CONFIRMED_3 = """{color=aqua|Greg: — Heh, we'll see about that. I didn't expect you to come to the front lines, but I guess we're in luck.}

{color=yellow|Duncan: — What are you talking about?}

{color=aqua|Greg: — What do you expect your army to do it if you are taken down? }

{color=yellow|Duncan: ...}

Now Duncan realized that there was another group of rebel reinforcements approaching their flank. Their group would be outnumbered by at least two to one. Regardless, he readied his sword.""",
	BETRAYAL_CONFIRMED_4 = """As you deal with the rebels you are ordered to advance. From your perspective it seems the Guilds' army is slowly coming out on top.""",
	BETRAYAL_CONFIRMED_5 = """Myr observed the battlefield from the nearby hill a few hundred feet away. Most of the lower mages were drafted to support the fighting forces but she had a different mission. Being the strongest caster in all Aliron or perhaps the whole country, she was reserved for more than simple healing and spellslinging.

She patiently observed the battlefield, as the guilds troops advanced toward the town. """,
	BETRAYAL_CONFIRMED_6 = """{color=yellow|Duncan: — Strategy was always your strong side. }

{color=aqua|Greg: — Hmph.}

As more groups were approaching Duncan he and his unit dwindled as it grew fatigued.""",
	BETRAYAL_CONFIRMED_7 = """{color=aqua|Greg: — It was your mistake to rush in, even more so to lead the charge personally. }

{color=yellow|Duncan: — Who else would it do? }

{color=aqua|Greg: — Perhaps it's time for you to surrender. }

{color=yellow|Duncan: — Not interested.}

{color=aqua|Greg: — Hmph, you always were all brawn and no brains. So be it.}""",
	BETRAYAL_CONFIRMED_8 = """{color=aqua|Myr: — These damn fools...}

Without delay Myr started chanting a powerful spell. In a few moments a large earthquake hit the rebel reinforcements approaching Duncan's unit. A few other mages under her command joined in, casting long range magic on the separated rebel groups. """,

	BETRAYAL_CONFIRMED_9 = """The spell produced a powerful shockwave near Duncan and when he turned to the side he found the approaching enemy formation crumbled under the magical barrage.

{color=aqua|Duncan: — Damn you, Myr. Who asked you to interrupt?}

Duncan muttered to himself. However, Greg was far more surprised by this. He realized he just lost his tactical advantage, and quickly withdrew from the fight.

{color=yellow|Greg: — Cursed sorcerers. Retreat to the town's walls!}

Following the command, the rebel forces withdrew, however the Guilds' army quickly took the initiative and moved in.""",
	BETRAYAL_CONFIRMED_10 = """However, before the bulk of the guild forces were able to enter the town, a gigantic white dome had enveloped the rebels' refuge. Magic on a scale they'd never seen completely blocked any advance or attack from the guilds' army.

Dumbfounded, the guilds' forces were forced to halt and regroup.""",
	BETRAYAL_CONFIRMED_11 = """The army's leaders gathered together to discuss the situation.

{color=aqua|Duncan: — What's this thing about? Why can't we pass through?}

{color=yellow|Myr: — Looks like a Divine Influence to me. This is not really our speciality.}

{color=aqua|Duncan: — What are you talking about?}

{color=yellow|Myr: — It's a special kind of magic, the source of which is higher beings. But it's so rare I've only observed it a couple of times. We can't really do anything about it with our relatively marginal power.}""",
	BETRAYAL_CONFIRMED_12 = """{color=aqua|Duncan: — Dammit, to think rebels would have something like this...}

{color=yellow|Myr: — I would imagine the princess could pull of something unusual, but not on this scale. }

{color=aqua|Duncan: — How long will this thing persist?}

{color=yellow|Myr: — I'd not expect it to go down on its own. The divine doesn't always follow the same rules as normal magic.}

{color=aqua|Duncan: — Damnit...}""",
	BETRAYAL_CONFIRMED_13 = """{color=aqua|Duncan: — Listen here, [name]. You've shown your resourcefulness earlier. I want you to find a way to remove the barrier. Without it we can finish this battle and liberate Millford. }

{color=yellow|Myr: — We will be keeping our forces ready in case they decide the rebels launch a counterattack.}""",
	BETRAYAL_CONFIRMED_OPTION_1 = """I have no idea what to do either""",
	BETRAYAL_CONFIRMED_OPTION_2 = """Do you have any suggestions as to where I should start?""",
	BETRAYAL_CONFIRMED_14 = """Myr: — Hmm, my only idea would be to try asking a religious institution. Those usually are more familiar with Divine Influences and how to deal with them.""",
	BETRAYAL_CONFIRMED_OPTION_3 = """I'll try my best""",
	BETRAYAL_CONFIRMED_OPTION_4 = """You really make me work""",
	BETRAYAL_CONFIRMED_OPTION_5 = """Alright, I'll ask for a votive candle on your behalf""",

	DIVINE_SYMBOL_OPTION_1 = """Can you tell me anything about Divine Influence?""",
	DIVINE_SYMBOL_1 = """— We've had some teaching and records about it. What exactly would you like to know?""",
	DIVINE_SYMBOL_OPTION_2 = """*Describe situation*""",
	DIVINE_SYMBOL_2 = """— Well, it seems to be a Champion's doing.""",
	DIVINE_SYMBOL_OPTION_3 = """What's a Champion?""",
	DIVINE_SYMBOL_OPTION_4 = """Can something be done about it?""",
	DIVINE_SYMBOL_3 = """— Champions are individuals chosen by Gods who are able to invoke their diety's power. In turn they are believed to follow their god's instructions. Actually they are so rare we only know a handful from thousands of years of history. Ah, I would love to meet Celena's Champion one day. """,
	DIVINE_SYMBOL_4 = """— Hmm, I think there's a way. If another god conjures a medium you should be able to neutralize the powers of this god. Then you'll be able to pass that barrier, although for removing it completely you'll have to defeat the champion.""",
	DIVINE_SYMBOL_OPTION_5 = """What do I need to do?""",
	DIVINE_SYMBOL_OPTION_6 = """You can conjure such a thing?""",
	DIVINE_SYMBOL_5 = """— If you bring me the divine symbol I can bless it with Celena's power. I'll give you the recipe. Please come back once you've made it.""",
	DIVINE_SYMBOL_OPTION_7 = """I've brought the symbol you asked for""",
	DIVINE_SYMBOL_6 = """— Ah, you have it? A beautiful work! Please, give me some time.

Ginny leaves you for a few minutes, eventually returning to you with the symbol you've passed her, now giving off a barely noticeable light.

— Here, this should let you create a momentary breech in the barrier. Please, be careful out there [Sir] [name].""",
	DIVINE_SYMBOL_7 = """{color=aqua|Duncan: — You are back. What is the news?}""",
	DIVINE_SYMBOL_OPTION_8 = """I've found a way to enter the barrier""",
	DIVINE_SYMBOL_OPTION_9 = """I'm ready to go""",
	DIVINE_SYMBOL_8 = """{color=aqua|Duncan: — So, with this you will be able to enter the barrier and get rid of that "Champion". Fine, I approve of it. Once you enter it we will get ready for the assault.}

{color=yellow|Myr: — Judging from the looks of it, I'd expect the culprit to be at the center of Dome, likely protected too. }

{color=aqua|Duncan: — Whoever it is, gather your best followers and prepare for a hard fight. I would prefer to accompany you, but the army can't be left without a commander.}""",
	DIVINE_SYMBOL_9 = """{color=aqua|Duncan: — Good, let's not waste time. This battle's outcome is in your hands. }

{color=yellow|Myr: — There's a spot from which you can enter unnoticed from the hill side, I'll show you.}""",
	DIVINE_SYMBOL_10 = """You finish your preparations and at nightfall you enter the barrier where Myr showed you. As you make your way to the streets you only spot the occasional rebel patrol and they seem fairly lax. By staying in the shadows you manage to eavesdrop on them.

{color=aqua|First Sentry: — Why are we even doing this? It's not like those bastards can get in. }

{color=yellow|Second Sentry: — Yah, I know. We've been at this for days and nothing. I'd rather grab a beer and a pair of tits instead of a fuckin' spear.}

As they pass you continue to move on.""",
	DIVINE_SYMBOL_11 = """As you slowly make your way into the town center, you notice your position is being approached by another patrol. You're about to be cut off, and won't be able to retreat unnoticed.""",
	DIVINE_SYMBOL_OPTION_10 = """Make a run for it (Physics)""",
	DIVINE_SYMBOL_12 = """{color=green|Success}

Thanks to your quick reaction, you've managed to nimbly avoid the patrol.""",
	DIVINE_SYMBOL_ASSASSIN = "Stealthly Dash (Assassin)",
	DIVINE_SYMBOL12_1 = "{color=green|Success}\n\nYou nimbly dash through the street without raising any noise thanks to your skills. ",
	DIVINE_SYMBOL_13 = """{color=red|Failure}

You've tried, but after taking a corner too wildly you crash into a pile of crates. The patrol has noticed the noise you've made and now you have no other option but to fight.""",
	DIVINE_SYMBOL_14 = """You've managed to defeat the patrol relatively quietly. Hoping not be discovered again, you leave the place.""",
	DIVINE_SYMBOL_15 = """You arrive at a small square where your target should be. However, there are multiple buildings anyone of which could be it.""",
	DIVINE_SYMBOL_OPTION_11 = """Search (Wits Factor)""",
	DIVINE_SYMBOL_16 = """{color=red|Failure}

You've entered the wrong building. A few rebels recognize you as an intruder and arm themselves.""",
	DIVINE_SYMBOL_17 = """You finish the rebels as silently as possible and return to the square.""",
	DIVINE_SYMBOL_18 = """{color=green|Success}

You enter a small hallway with doors guarded by an armed group of rebels.

{color=yellow|First Guard: — Why can't we stay inside?}

{color=aqua|Second Guard: — She requested to be left alone. That's for the better if you ask me.}""",
	DIVINE_SYMBOL_18_1 = """{color=yellow|First Guard: — Hmm? Why, you dislike her?}

{color=aqua|Second Guard: — She's of beast blood, she acts like lunatic and looks like a brat. Greg finds her useful, but I'd rather side with a troll.}""",

	DIVINE_SYMBOL_19 = """{color=yellow|First Guard: — Yeah, in terms of brains you would find common ground.}

{color=aqua|Second Guard: — You shut yo-}

The guards stop halfway noticing your approach. They give you a warring look waiting for your further actions.""",
	DIVINE_SYMBOL_OPTION_12 = """Greg called for me to pay him a visit (Charm Factor)""",
	DIVINE_SYMBOL_OPTION_13 = """Attack them""",
	DIVINE_SYMBOL_20_1 = """{color=green|Success}

{color=aqua|Second Guard: — Damnit, what does he want now? }

{color=yellow|First Guard: — Probably figured you've been sleeping during the last watch.}

{color=aqua|Second Guard: — You didn't tell him that, did you? Fuck, lets go. }

They leave the building, leaving the door unguarded.""",
	DIVINE_SYMBOL_20_2 = """{color=red|Failure}

{color=aqua|Second Guard: — Bullshit, they're intruders. Get them!}""",
	DIVINE_SYMBOL_21 = """Deciding there's no room for negotiation, you prepare for a fight.""",
	DIVINE_SYMBOL_22 = """As you knock out the guards you are finally able to approach the doors.""",
	DIVINE_SYMBOL_23 = """You enter a sumptuous though dimly lit room. A small figure on the other side turns at you.

— Well, it took you a while and now you don't even knock. How rude. I like it.

The miniature girl reacted to your appearance unexpectedly nonchalantly.

— Zephyra.

Zephyra briefly bowed down to you after you spoke her name.""",
	DIVINE_SYMBOL_24 = """— Before I forget... Here, an acquaintance gift.

She passes you a roll of paper she took from the pile on a small table. As you unfold it you see a rough but somewhat talented sketch of a [man]'s portrait. On a second look you notice how this person vaguely resembles you. Seeing the look on your face, Zephyra shines with excitement.

— Do you like it?""",
	DIVINE_SYMBOL_OPTION_14 = """Can't say I don't""",
	DIVINE_SYMBOL_OPTION_15 = """How did you do that?""",
	DIVINE_SYMBOL_OPTION_16 = """Are you a stalker?""",
	DIVINE_SYMBOL_25 = """— Finally someone is admiring my artwork. Hold onto your flattery though, that's my speciality.""",
	DIVINE_SYMBOL_26 = """— I drew it, silly. Oh, you mean how did I know what you look like? I didn't. You know how sometimes you dream of something which hasn't happened yet, but then it happens after some time? Maybe it's something like this.""",
	DIVINE_SYMBOL_27 = """— Ah-ha, no, if I were one I wouldn't be waiting for you here, would I?""",
	DIVINE_SYMBOL_28 = """

— So, are you going to take it?""",
	DIVINE_SYMBOL_OPTION_18 = """*Accept*""",
	DIVINE_SYMBOL_OPTION_19 = """*Refuse*""",
	DIVINE_SYMBOL_29 = """You thank Zephyra for the drawing and put it away. She smiles at you, making you temporarily to forget the reason why you've come here.

— But you must desire something else of me. Perhaps something to do with the barrier?""",
	DIVINE_SYMBOL_30 = """You return the drawing with a stern look.

— So, you must've come because of the barrier, right?""",
	DIVINE_SYMBOL_OPTION_20 = """If I ask you to remove it nicely, will you?""",
	DIVINE_SYMBOL_OPTION_21 = """You'll have to remove it, or else""",
	DIVINE_SYMBOL_31 = """— Why, of course, but firstly I have a request if you don't mind. Ahem. Allow me to join you.""",
	DIVINE_SYMBOL_OPTION_22 = """Why do you want to join me?""",
	DIVINE_SYMBOL_OPTION_23 = """You must have some really good reason for that""",
	DIVINE_SYMBOL_32 = """— I guess, I have to explain. I've set this whole thing up in order to find you. Well, not specifically you, but someone capable enough to pass through and find me. And you managed pretty well.""",
	DIVINE_SYMBOL_OPTION_24 = """Why would you need someone like that?""",
	DIVINE_SYMBOL_OPTION_25 = """That's a rather bold plan""",
	DIVINE_SYMBOL_OPTION_26 = """What's the task you need me for?""", #after 24 and 25 seen
	DIVINE_SYMBOL_33 = """— You are probably aware I'm the Champion of Alios. We have this compulsion when our benefactor gives us orders. My mission was to find and join you... or someone like you? Nah, I guess that's rude, I've found you already after all.""",
	DIVINE_SYMBOL_34 = """— What better way to find a strong crafty person than to interrupt a huge contest? One way or another your leaders would be forced to find a way in and would seek assistance to do so. So I offered a bit of help to the losing side. And now I found you.""",
	DIVINE_SYMBOL_35 = """— Alios isn't really clear in his intentions, but if you ask me, the world must be in a great danger. Maybe we'll come up with something later. So, will you allow me to join you? I'm sure this will be a fruitful cooperation.""",
	DIVINE_SYMBOL_OPTION_27 = """Alright, why not""",
	DIVINE_SYMBOL_OPTION_28 = """No, I can't trust you""",
	DIVINE_SYMBOL_OPTION_29 = """I do not cooperate, only dominate""",
	DIVINE_SYMBOL_36 = """Zephyra takes a long pause contemplating you and your words. Just as you think she's not going to say anything, she kneels down before you.

— Fine, I'll become your subordinate if you wish so. """,
	DIVINE_SYMBOL_OPTION_30 = """I'll take care of you """,
	DIVINE_SYMBOL_OPTION_31 = """That was a joke, you can join me""",
	DIVINE_SYMBOL_OPTION_32 = """No, after all I can't trust you""",
	DIVINE_SYMBOL_37 = """— Do I get to call you [master]? Hehe, now let me dispel the barrier, then we can continue once this is over.""",
	DIVINE_SYMBOL_38 = """— Hehe, glad we worked this out. Alright, hold on, I'll dispel the barrier. We can discuss other things once this is over.""",
	DIVINE_SYMBOL_39 = """— You idiot! Making me do something so embarrassing... Oh well, let's get this over with, we can discuss other things once this is over.""",
	DIVINE_SYMBOL_40 = """— Ha-ah, that's a downer. Well, let's get this over with then, I'll remove the barrier in a moment. Was nice to meet you.""",
	DIVINE_SYMBOL_41 = """Zephyra closed her eyes and her figure was enveloped in dim light in proof of her divine connection. At the same time through the window you observe the barrier slowly begin to dissipate.""",
	DIVINE_SYMBOL_42 = """

— Well, here you go. Let us meet again, then.""",
	DIVINE_SYMBOL_43 = """

— Here we go, happy? Hey, do you mind giving me a piggyback ride? My brains really hurt after all this work, you know.""",
	DIVINE_SYMBOL_44 = """As the barrier fell, Duncan ordered an immediate attack. Many of the rebel troops were caught off guard resting and unable to rally a quick response. As the guilds' army slowly advanced into town no one took much notice of your small group, allowing you to escape easily.""",
	DIVINE_SYMBOL_45 = """{color=aqua|Greg: — What the hell... Shit, what happened to the barrier!?}

{color=yellow|Aire: — It seems they somehow made it inside. Their main army has been waiting for this. I'm afraid we won't hold for long.}

{color=aqua|Greg: — Goddamnit. Order the retreat. And make sure the princess is safe. Curses on that useless champion, she better not make it out of this alive.}""",
	DIVINE_SYMBOL_46 = """{color=aqua|Myr: — Huh, [he] really managed to pull it off. Are you not going to lead the assault?}

{color=yellow|Duncan: — No, it's over and there's no challenge. I've set outriders to keep watch out for any potential escape so the princess should be ours shortly. }

{color=aqua|Myr: — Hmph, she's too smart to get caught by you. }

At this moment a messenger approached Duncan.""",
	DIVINE_SYMBOL_47 = """{color=aqua|Messenger: — Sir, [name] has returned and asks for an audience. }

{color=yellow|Duncan: — Bring [him].}

As you come out you notice how Duncan's stoic face shows a hint of respect.

{color=aqua|Duncan: — A splendid job. You are going down in history with what you've pulled out here. Also managed to do what those mages couldn't.}

{color=yellow|Myr: — Screw you.}""",
	DIVINE_SYMBOL_OPTION_33 = """That wasn't too hard""",
	DIVINE_SYMBOL_OPTION_34 = """I thought I wasn't gonna make it""",
	DIVINE_SYMBOL_48 = """{color=aqua|Duncan: — Either way the town will be ours by tomorrow morning. You can go and rest until then.}""",
	DIVINE_SYMBOL_49 = """A few hours later

{color=yellow|Soldier: — We have captured the town, but there has been no sign of Greg or the princess.}

{color=aqua|Duncan: — Damnit, they must've had some hidden escape routes we had no idea about. Nevertheless, the town is ours and the rebel forces have been defeated.

Duncan: — [name], you can return to Aliron now. We shall plan out our next moves.}""",


	FINAL_OPERATON_START = "-Hello [name]. I need to ask for your help in a matter that should stay between us.",
	FINAL_OPERATON_START_OPTION_1 = "I would be glad to help",
	FINAL_OPERATON_START_OPTION_2 = "Depends on what it is",

	FINAL_OPERATON_1 = """— I'll be brief, we've discovered a major rebel hideout and we believe the princess will be there. We're gathering a raiding party to pay them a surprise visit.

— Given your performance in the last battle and overall help I'd say that more than proves your capability in combat. This is also in your best interest, considering this will be the best chance we've had to capture the princess thus far.

— Off the record I think you are the best candidate for the mayor position as you've proven how much you're capable of. If the princess is indeed at this hideout, you will be the one to capture her. Are you ready for this?""",
	FINAL_OPERATON_2 = """— I'll be brief, we've discovered a major rebel hideout and we believe the princess will be there. We're gathering a raiding party to pay them a surprise visit.

— Given your performance in the last battle and overall help I'd say that more than proves your capability in combat. This is also in your best interest, considering this will be the best chance we've had to capture the princess thus far.

— Off the record I think you are the best candidate for the mayor position as you've proven how much you're capable of. If the princess is indeed at this hideout, you will be the one to capture her. Are you ready for this?""",
	FINAL_OPERATON_OPTION_1 = "What kind of fight can I expect from this?",
	FINAL_OPERATON_OPTION_2 = "Sounds like fun, I'll be there",
	FINAL_OPERATON_OPTION_3 = "I guess there's no better chance",
	FINAL_OPERATON_3 = """— Hmm, for one the location is an abandoned mineshaft, it'll be an enclosed space but should still have plenty of open room for fighting the enemy. The rebels will likely be well fortified they'll have numbers but we'll have skill.""",
	FINAL_OPERATON_4 = """— The longer it takes you the more time the enemy has to prepare,so try not to keep us waiting too long. I'll mark the location on your map.

— Don't mention this to the other guilds. We still aren't sure if Greg was the only traitor in our midst and we can't risk the princess getting away because a spy gave her forewarning. That being said, if you can recruit help from them without revealing the raid, do so.""",
	FINAL_OPERATON_WORKERS_OPTION_1 = "Ask for Help",
	FINAL_OPERATON_WORKERS_1 = """— Ach, have ya no mind to what pressure we're under? Entire guild is tied up supporting the fighters spat with the rebels. Got none free ta take on some outside job at the moment.""",
	FINAL_OPERATON_SERVANTS_1 = """— Came to us for Duncan's little raid? Please, [name], I thought you knew that we don't deal in any violence. Sorry... But to cheer you up, here's a little tip from me: ask Myr. Mages are certainly more capable in what you're looking for.""",
	FINAL_OPERATON_MAGES_1 = """— A job? I don't see why I would care, but for the sake of my own amusement let's hear it. What exactly do you want?""",
	FINAL_OPERATON_MAGES_1_OPTION_1 = """Let's call it a favor and leave it at that.""",
	FINAL_OPERATON_MAGES_1_OPTION_2 = """I'm helping the Fighters Guild with a raid""",
	FINAL_OPERATON_MAGES_2 = """— You'll have to elaborate on this favor you want. Surely you can't expect our help on some whim of yours, especially with what's been going on.""",
	FINAL_OPERATON_MAGES_2_OPTION_1 = """Hey now, I've done a lot of work for the guild.""",
	FINAL_OPERATON_MAGES_2_OPTION_2 = """Look, it's important. I helped with Fred didn't I?""",
	FINAL_OPERATON_MAGES_2_OPTION_3 = """Please Myr, this is important, remember back when I got your books for you?""",
	FINAL_OPERATON_MAGES_3_1 = """— Ugh, fine, whatever, but this is a one-time deal. I have a few spares you can use for your business, I guess. Just make sure they return intact, the paperwork gets tiresome.""",
	FINAL_OPERATON_MAGES_3_2 = """— Ugh, fine, I don't like being left in the dark but this will cost you. I can find some volunteers for three hundred gold.""",
	FINAL_OPERATON_MAGES_3_OPTION_1 = """Sure. [remove 300 gold]""",
	FINAL_OPERATON_MAGES_3_OPTION_2 = """I don't have the money.""",
	FINAL_OPERATON_MAGES_4 = """— What, do you expect us to work for free? Get out of here I've got actual business to take care of.""",
	FINAL_OPERATON_MAGES_5_1 = """— Oh, don't even start trying to get pity points for that one. I think you already got more than enough for that job. Now get out of here I've got more important things to do.""",
	FINAL_OPERATON_MAGES_5_2 = """— Ugh, fine, I don't like being left in the dark but this will cost you. I can find some volunteers for three hundred gold.""",
	FINAL_OPERATON_MAGES_5_3 = """Myr disappears into the guild as you sit and wait for her. It doesn't take too long before a small group of mages shuffle into the room followed by Myr.

— There are your volunteers. Now all of you get going I have business to attend to.

You lead your new entourage out the door. Opening your map you show the group the place Duncan designated. Telling them to wait there and if anyone asks they're with you.""",
	FINAL_OPERATON_MAGES_5_4 = """— I have zero interest in helping with anything related to the Fighters. Why don't you go ask them for help, it's their job or whatever. Now if you'll excuse me I've got actual business to attend to, see yourself out.""",

	INITIATE_HIDEOUT_ATTACK_1 = """You arrive at the location Duncan marked for you, a forested area close to the hideout. Duncan is in the midst of the group from the Fighters Guild talking with a few of them. Though as he sees you he waves them off and waves you over to him.""",
	INITIATE_HIDEOUT_ATTACK_2 = """You arrive at the location Duncan marked for you, a forested area close to the hideout. Duncan is in the midst of the group from the Fighters Guild talking with a few of them. Though as he sees you he waves them off and waves you over to him.

You also notice your small group of mages, one waves to you as you pass.

— Good, you're here. And it seems you followed my advice. Though I trust you didn't tell Myr the details?""",
	INITIATE_HIDEOUT_ATTACK_6 = """— Alright let's not waste time. Prepare your men and we will begin.""",
	INITIATE_HIDEOUT_ATTACK_OFCOURSE = """Of course""",
	INITIATE_HIDEOUT_ATTACK_OPTION_1 = "I want to be on the frontline",
	INITIATE_HIDEOUT_ATTACK_OPTION_2 = "We should all go in at once",
	INITIATE_HIDEOUT_ATTACK_3 = "...Are you sure you can handle that? It won't be easy, but I'm not going to stop you.",
	INITIATE_HIDEOUT_ATTACK_3_OPTION_1 = "I like the challenge",
	INITIATE_HIDEOUT_ATTACK_3_OPTION_2 = "There's no glory being in back rows",
	INITIATE_HIDEOUT_ATTACK_3_OPTION_3 = "On second thought we should go in all at once",
	INITIATE_HIDEOUT_ATTACK_4 = """— I'm impressed. But don't underestimate the enemy, they can use that against you.

— Go prepare yourself for the fight, we move in five minutes.

You prepare yourself and your group for the upcoming fight. Duncan can be seen moving between the groups informing them of the plan. You move near the front of the gathering with your group as Duncan raises an arm before bringing it down pointing at the hideout. """,
	INITIATE_HIDEOUT_ATTACK_5 = """— Go prepare yourself for the fight, we move in five minutes.

You prepare yourself and your group for the upcoming fight. Duncan can be seen moving between the groups informing them of the plan. You move near the front of the gathering with your group as Duncan raises an arm before bringing it down pointing at the hideout. """,

	GUILD_ATTACK_ON_HIDEOUT_1 = """In the deeper rooms of the rebel hideout Greg barges into a room occupied by Aire and Anastasia.

{color=aqua|Greg: — We are under attack. The guilds have found us.}

{color=yellow|Anastasia: — So soon!? What do we do?}

{color=aqua|Greg: — You need to escape.}""",
	GUILD_ATTACK_ON_HIDEOUT_2 = """{color=yellow|Anastasia: — Run away? No, I-I can't...}

{color=aqua|Greg: — There's no other choice. If you get captured you'll end up on the gallows. Moreover, without you there are no other heirs to the throne.}

{color=yellow|Anastasia: — This is wrong, I can't leave everyone behind.}

{color=aqua|Greg: — Enough, we are wasting time. Aire! Send the princess off and return to me immediately.}""",
	GUILD_ATTACK_ON_HIDEOUT_3 = """{color=yellow|Aire: — ... I understand. Over here, your Highness.}

{color=aqua|Anastasia: — No, what am I gonna do after that?}

{color=yellow|Aire: — Don't worry, we've planned your escape for such occasions... Once we defeat the intruders we will reunite and get you back.}

{color=green|Greg: — You've heard her, Ana, now move.}

{color=aqua|Anastasia: — ...}""",
	GUILD_ATTACK_ON_HIDEOUT_4_1 = """{color=yellow|Aire: — It is done.}

{color=aqua|Greg: — Good, you've finally done something useful at least. Now get your weapon and prepare to defend.}

{color=yellow|Aire: — ...Understood.}

{color=aqua|Greg: — Damnit, this whole plan has gone downhill rapidly.}""",

GUILD_ATTACK_ON_HIDEOUT_4_2 = """In the deeper rooms of the rebel hideout Greg barges into a room occupied by Anastasia.

{color=aqua|Greg: — We are under attack. The guilds have found us.}

{color=green|Anastasia: — So soon!? What do we do?}

{color=aqua|Greg: — You will have to escape. Use the route your elf has prepared for you.}""",
	GUILD_ATTACK_ON_HIDEOUT_4_3 = """{color=yellow|Anastasia: — Run away? No, I-I can't...}

{color=aqua|Greg: — They must be targeting you and without you there's no revolution.}

{color=yellow|Anastasia: — This is wrong, I can't leave everyone behind.}

{color=aqua|Greg: — This is not up for debate. You'll be executed if you end up in their hands. Now go, we'll hold them back so they can't chase after you.}

{color=yellow|Anastasia: — ...}""",

	FINAL_BOSS_1 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.

Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the back of the room a man oversees the activities of the rebels.

— Ah, it seems we have company. All of you form up, stop the guild scum.""",

	FINAL_BOSS_2 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.

Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the center of the room is an elf. She quickly adopts a fighting stance.

— We've got company. To arms!""",

	FINAL_BOSS_3 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.

Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the center of the room however is someone you recognize, an elf. She notices you and quickly adopts a fighting stance.

It's the elf girl you had your fun with before. Her eyes narrow at you with clear hatred.

— You... I'd never expect to get my revenge on you here of all places. To arms!""",

	FINAL_BOSS_4 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.

Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the center of the room however is someone you recognize, an elf. She notices you and quickly adopts a fighting stance.

It's the elf you saved from the lich. Her stance falters as she recognises you. She shakes her head and returns to her combat stance.

— This isn't exactly how I'd imagined I'd meet you again. I'm sorry but I won't let you get to Anastasia. To arms!""",

	AIRE_COMBAT_ON_WIN_2 = """The elf collapses in exhaustion and pain as you finish your fight looking around you're just in time to see Duncan's group charge in from a secondary entrance.

{color=yellow|Duncan: — Nice work out there. But I'm afraid there's nobody else here, including the princess. Though this bitch should know something for sure.}""",

	AIRE_COMBAT_ON_WIN_3 = """{color=yellow|Aire: — Damn you... You won't get her!}

{color=aqua|Duncan: — Shut it, elf. You've failed to protect this place and you've failed to protect your princess. She'll get what's coming to her just as you will.}

{color=yellow|Aire: — Bastard... Agh-}

Before she can say anything else Duncan's men seize her and gag her mouth.""",

	AIRE_COMBAT_ON_WIN_3_1 = """{color=yellow|Aire: — Damn you... You won't get her!}

{color=aqua|Duncan: — Shut it, elf. You've failed to protect this place and you've failed to protect your princess. She'll get what's coming to her just as you will.}

{color=yellow|Aire: — Bastard... Agh-}

Before she can say anything else Duncan's men seize her and gag her mouth.""",


	GREG_COMBAT_ON_WIN_1 = """The man staggers back as breathing heavily. You look around to see Duncan cut down a rebel behind you. stepping up beside you as the both of you confront the apparent ringleader of this hideout.

{color=aqua|Duncan: — Greg, stand down and surrender. This pathetic rebellion is over.}

{color=yellow|Greg: — Ah, Duncan. I could have expected you'd show up here, too bad for you though, Anastasia is already far away from here.}

{color=aqua|Duncan: — We'll see about that, my men have already surrounded the area. Now drop your w-}

Before Duncan can even finish speaking the man throws something against the ground. Light suddenly envelops your vision as a horrid ringing sound plays in your ear. You stumble around blindly for a moment, quickly blinking to clear your vision. The ringing fades a bit as you look around the room to find the man gone.""",

	GREG_COMBAT_ON_WIN_2 = """— I should have expected no less cowardice from a rebel. At least it seems like you can handle yourself, just watch your flank in the future.

Duncan turns to speak with you. The guild members begin to handcuff the rebels that aren't already dead.

— You've shown considerable skill here today.""",

	GREG_COMBAT_ON_WIN_3 = """Duncan turns to speak with you. The guild members begin to handcuff the rebels that aren't already dead.

— You've shown considerable skill here today.""", # never should be used

	GREG_COMBAT_ON_WIN_4 = """Duncan turns to speak with you. The guild members begin to handcuff the rebels that aren't already dead.

— You've shown considerable skill here today.

— I would have been here sooner, but Greg engaged us, then managed to escape.""",

	GREG_COMBAT_OPTION_1 = """What do we do now?""",
	GREG_COMBAT_OPTION_2 = """Sorry, I should have been faster getting here.""",
	GREG_COMBAT_OPTION_3 = """What will be done with the elf girl?""",
	GREG_COMBAT_OPTION_4 = """What will be done with the rebels?""",
	GREG_COMBAT_OPTION_5 = """How about a reward for my help?""",
	GREG_COMBAT_OPTION_6 = """Thanks for letting me bash some rebel heads in.""",

	GREG_COMBAT_ON_WIN_5 = """— While the outcome is disappointing, it's only a matter of time until she runs out of places to hide.""",
	GREG_COMBAT_ON_WIN_6 = """{color=aqua|Duncan: — Her? Same as the rest of them, they'll be imprisoned and interrogated.}

The elf struggles slightly against her bindings, as she huffs in defiance.""",

	GREG_COMBAT_ON_WIN_7 = """— They'll be imprisoned and interrogated for any information about the princess, she's still our primary focus.""",

	GREG_COMBAT_ON_WIN_8 = """— You don't need to worry about that, you'll get your reward. The fighters still have a lot of work to settle here, once that's done we can worry about rewards.""",
	GREG_COMBAT_ON_WIN_9 = """— Go home. We'll clean everything up here. Come see me later and we'll decide what to do from there.""",
	COMBAT_ON_WIN_FRONTLINE = """— Many of the rebel forces now lie dead or reside in our prison. Unfortunately we missed the princess in our raid and we've got no leads as to where she may have gone. Our interrogation of the prisoners hasn't turned up much.

— Don't think I've forgotten your bravery in the raid. Here, your reward. I trust I can continue to count on you, you've proven yourself to be very capable.

— We still have to secure the princess.""",

	COMBAT_ON_WIN_NOT_FRONTLINE = """— Many of the rebel forces now lie dead or reside in our prison. Unfortunately we missed the princess in our raid and we've got no leads as to where she may have gone. Our interrogation of the prisoners hasn't turned up much.

— Oh, and here, your reward for your help in the raid. you've proven yourself to be very capable.

— We still have to secure the princess.""",

	COMBAT_ON_WIN_OPTION_1 = """I'm eager to get to her myself.""",
	COMBAT_ON_WIN_OPTION_2 = """I currently have other issues to deal with.""",

#search for princess
	SEARCH_FIGHTERS_1 = """— Now then, we haven't had any luck with our interrogations. These idiots are fanatically dedicated to their rebellion.""",
	SEARCH_FIGHTERS_OPTION_1 = """Any reason you haven't found the princess yet?""",
	SEARCH_FIGHTERS_1_1 = """— With the mass influx of rebel prisoners along with us keeping the peace in the city we don't have the manpower to do much about finding her on our own.""",
	SEARCH_FIGHTERS_OPTION_2 = """Can I get any help from the Fighters Guild?""",
	SEARCH_FIGHTERS_1_2 = """— As it stands I can offer you little more than guaranteeing you'll be the first to know if one of the rebels talks. Though as it stands that's likely to take weeks, or even longer.""",
	SEARCH_FIGHTERS_OPTION_3 = """I'll get to it then.""",
	SEARCH_FIGHTERS_2 = """— Come back as soon as you have the location of the princess and we can plan out what to do. The other guilds may have some ideas.

— Considering your objective it may be worth paying Amelia a visit to see if she can offer any advice.""",
	SEARCH_FIGHTERS_OPTION_4 = """I want to speak to the elf girl.""",
	SEARCH_FIGHTERS_3 = """— Her? We haven't gotten anything out of her. If anything she's even more fanatical than the rest of them.""",
	SEARCH_FIGHTERS_OPTION_5 = """I've met her before. Maybe I can get some information from her.""",
	SEARCH_FIGHTERS_OPTION_6 = """An elf is rare to see, one fighting for a human rebellion is even more-so.""",
	SEARCH_FIGHTERS_4 = """— Hmm... Tell me more about it.""",
	SEARCH_FIGHTERS_OPTION_7 = """When you had me go after the lich she was there too. I didn't know she was with the rebels though.""",
	SEARCH_FIGHTERS_OPTION_8 = """I spared her life once.""",
	SEARCH_FIGHTERS_5_1 = """— That's true, she definitely knows more than the other rebels. I suppose there's nothing to lose in letting you try to get her talking.""",
	SEARCH_FIGHTERS_5_2 = """— Strange circumstance, but I've heard wilder stories that turned out true. I suppose you've got the best chance out of any of us to get her talking, go ahead.""",
	SEARCH_FIGHTERS_5_3 = """— Interesting, well if you can use that leverage to get her talking then it'll have been worth letting her live. I suppose you've got the best chance out of any of us at least.""",
	SEARCH_FIGHTERS_5 = """— You'll find her in the city's dungeon. I'll send word to the guards so they'll let you pass.""",
	SEARCH_FIGHTERS_6_INIT = """ """,
	SEARCH_FIGHTERS_6 = """ """,#no phrases here in this scene, mb error, mb _6 scene is not reqired
	SEARCH_FIGHTERS_7_INIT = """Can I speak with you?""",
	SEARCH_FIGHTERS_7 = """— I've heard you were working with the mages to track the princess, do you need me for something?""",
	SEARCH_FIGHTERS_OPTION_9 = """I was hoping to talk to the elf girl.""",
	SEARCH_FIGHTERS_8 = """— Well I've got no reason to deny that request. She's in the dungeons, I'll send word to the guards.""",
	SEARCH_SERVANTS_OPTION_INIT = """Would you have any ideas on how to track the princess?""",
	SEARCH_SERVANTS_1 = """— Mmm, perhaps ask Duncan if you could speak with the elf girl. She looked different than the other rebels they brought in, special.

— Though if you're not the talking type the Mages Guild might be able to help in other ways. Magic has quite a lot of applications.""",
	SEARCH_SERVANTS_2 = """— Well none of the rebels the fighters brought in look to be more than a peon. I don't suspect they'll get much information out of them if any at all.

— Then again you might ask Myr for some help. Magic has quite the variety of uses.""",
	SEARCH_SERVANTS_OPTION = """Thanks, I'll get to it.""",
	SEARCH_DUNGEON_1 = """You walk to the entrance of the dungeons. The guards give you the key and point you in the direction of the cell which holds Aire.

To your surprise standing outside of the cell is Amelia, she notices you and makes her way over.""",
	SEARCH_DUNGEON_OPTION_1 = """Amelia? What are you doing here?""",
	SEARCH_DUNGEON_2_1 = """— Oh, just following up on my suggestion to you. Glad to see at least someone takes my advice seriously.""",
	SEARCH_DUNGEON_2_2 = """— A little bird told me you were visiting one of our new guests. I thought perhaps I could come share some advice.""",
	SEARCH_DUNGEON_2_3 = """— Her name is Aire if you didn't know. It does seem like she should know exactly what we need.

— I'm sure you can get her talking being such a charming individual yourself. Though if she proves... difficult I could always try some of my methods.""",
	SEARCH_DUNGEON_OPTION_2 = """I'll think about it.""",
	SEARCH_DUNGEON_OPTION_3 = """Let's hope that won't be necessary.""",
	SEARCH_DUNGEON_3_1 = """As you walk into Aire's cell you feel her sharp gaze as she recognizes you. The elf girl sitting in the corner of the cold wall with hands cuffed behind her.

— It's you again. Think you can get anything out of me?""",
	SEARCH_DUNGEON_OPTION_4 = """So you still remember me""",
	SEARCH_DUNGEON_4_1 = """— There's not many bastards like you out there. """,
	SEARCH_DUNGEON_OPTION_5 = """I take it it's too late to ask for forgiveness?""",
	SEARCH_DUNGEON_4_2 = """— Who are you trying to fool? You've already shown your true face.""",
	SEARCH_DUNGEON_OPTION_6 = """This place seems just about right for you""",
	SEARCH_DUNGEON_4_3 = """— ...Fuck off.""",
	SEARCH_DUNGEON_OPTION_7 = """We want to know where the princess escaped to""",
	SEARCH_DUNGEON_OPTION_8 = """You must know where has your master has gone to""",
	SEARCH_DUNGEON_OPTION_9 = """Don't you think you should cooperate and make things better for you?""",
	SEARCH_DUNGEON_5_1 = """— You really think I'd ever cooperate with you?""",
	SEARCH_DUNGEON_OPTION_10 = """Why not? What makes you so loyal?""",
	SEARCH_DUNGEON_5_2 = """— ...You wouldn't understand, nor will I waste my breath telling you.""",
	SEARCH_DUNGEON_OPTION_11 = """Who knows what could happen to you if you don't cooperate""",
	SEARCH_DUNGEON_5_3 = """— Give me your worst. I'd rather die than help your kind.""",
	SEARCH_DUNGEON_OPTION_12 = """The princess will have it better if you cooperate""",
	SEARCH_DUNGEON_5_4 = """— Oh, I'm sure she'd be better anywhere else instead.""",
	SEARCH_DUNGEON_OPTION_13 = """This is going nowhere""",
	SEARCH_DUNGEON_6_1 = """I told you, you'll never get anything out of me. Go ahead and keep wasting your time.""",
	SEARCH_DUNGEON_OPTION_14 = """Once I get to her, you'll wish you'd have been more cooperative.""",
	SEARCH_DUNGEON_6_2 = """— If you dare to even touch her, I'll hunt you down to the ends of the earth.""",
	SEARCH_DUNGEON_OPTION_15 = """Fine. Enjoy rotting in this cell then""",
	SEARCH_DUNGEON_6_3 = """Aire does not react to your words, but somehow she seems content with your irritation.""",
	SEARCH_DUNGEON_OPTION_16 = """*Hit her*""",
	SEARCH_DUNGEON_6_4 = """*Smack*
You hand makes a hard slap on Aire's cheek which turns red, yet her expression does not change.

— Hmph, as expected from a lowly [man] like you.""",
	SEARCH_DUNGEON_OPTION_LEAVE = """Leave""",
	SEARCH_DUNGEON_3_2 = """You find the elf girl in the corner of her cell, sitting with hands cuffed behind her back. Despite the tired look in her eyes, they are filled with dignity. As you open the door she ostentatiously looks away.

— ... If you think you'll be getting anything out of me, you're wasting your time. """,
	SEARCH_DUNGEON_OPTION_17 = """Greet her""",
	SEARCH_DUNGEON_7_1 = """Aire turns to you with a curious look. As she recognizes your face, her tone becomes slightly nervous.

— ...Oh, it's you. Come to gloat?""",
	SEARCH_DUNGEON_OPTION_18 = """Stay quiet""",
	SEARCH_DUNGEON_7_2 = """After a few moments the curiosity gets the better of the elf girl and she turns to you.

— ...Oh, it's you. Come to gloat?""",
	SEARCH_DUNGEON_OPTION_19 = """Actually I wanted to ask a few questions.""",
	SEARCH_DUNGEON_OPTION_20 = """Let's cut to the chase, tell us where the princess is hiding.""",
	SEARCH_DUNGEON_OPTION_21 = """I have to go""",
	SEARCH_DUNGEON_8_1 = """— I won't be telling you where Anastasia is, not to you, nor anyone else in this city. Other than that, I don't mind some company.""",
	SEARCH_DUNGEON_8_1_IF_MET = """— I won't be telling you where Anastasia is, not to you, nor anyone else in this city. Other than that, I don't mind some company. And I know you aren't a bad person at least.""",
	SEARCH_DUNGEON_OPTION_22 = """Why are you so loyal to the princess?""",
	SEARCH_DUNGEON_OPTION_23 = """What's your role in the rebellion?""",
	SEARCH_DUNGEON_OPTION_24 = """What do you think about me?""",
	SEARCH_DUNGEON_8_7_1 = """— Well, I'd lie if I say I don't find you attractive. And I suppose you've proven yourself to be better in combat as well. I wish you were by Ana's side instead of Greg, things might've been very different.""",
	SEARCH_DUNGEON_8_7_2 = """You certainly can hold your own in battle, and you don't seem to be as bad as others we've been told about from the guilds. Maybe we could've become friends if things had been different.""",
	SEARCH_DUNGEON_OPTION_25 = """That's all for now""",
	SEARCH_DUNGEON_7_3 = """ """, #no line in doc
	SEARCH_DUNGEON_9 = """— She saved me when I was a child. Well, kind of, she was a child too mind you.

— My parents had been killed by bandits and I was captured and brought to their camp. Then the bandits were raided in turn by Ana's men. I was freed but I had nowhere left to go.

— So she offered to let me serve her. Her guards looked like they disagreed, but with the way she carried herself it seemed they could only abide by her decision. I tried to not get in the way and to just perform my duties, but she checked on me often and treated me like a little sister even though I'm just a commoner, an elf, not to mention her servant. Since then I've sworn my loyalty to her. I'm ready to sacrifice my life for her.""",
	SEARCH_DUNGEON_OPTION_26 = """I'm sorry for your loss""",
	SEARCH_DUNGEON_8_2 = """— Don't be, I've got over it a long time ago, I'm so very different than I was back then.""",
	SEARCH_DUNGEON_OPTION_27 = """Your devotion is admirable""",
	SEARCH_DUNGEON_8_3 = """— I wouldn't expect you to fully understand, but thanks.""",
	SEARCH_DUNGEON_OPTION_28 = """You could've done better on your own""",
	SEARCH_DUNGEON_8_4 = """— No, you don't understand.. I shouldn't have told you, I guess.""",
	SEARCH_DUNGEON_10 = """— I'm just serving Ana. I couldn't care less about human politics. To me you lot are enemies only due to killing Ana's father, regardless of who he was. """,
	SEARCH_DUNGEON_OPTION_29 = """You realize you can be executed for plotting against the guilds?""",
	SEARCH_DUNGEON_8_5 = """— Even if so, I do not care. There are always reasons someone will want you dead, regardless of what or where.""",
	SEARCH_DUNGEON_OPTION_30 = """I wish we hadn't ended up on opposing sides""",
	SEARCH_DUNGEON_8_6 = """— That makes two of us, but we can't really change it now. But enough of pointless sentiments, I'm sure you aren't here for that.""",
	SEARCH_DUNGEON_11 = """— This again? I thought I made myself clear there's no way I'm telling any of you anything.""",
	SEARCH_DUNGEON_OPTION_31 = """Aren't you worried about her wellbeing?""",
	SEARCH_DUNGEON_12_1 = """— I am, but... I have a hard time imagining her being in a worse place than in the hands of the guilds.""",
	SEARCH_DUNGEON_OPTION_32 = """Your cooperation could earn you better living conditions, or even a pardon""",
	SEARCH_DUNGEON_12_2 = """— This isn't about me, you idiot. I know very well the guilds are going to execute her once she's found, and I'm not going to help you hasten that.""",
	SEARCH_DUNGEON_OPTION_33 = """Stop being foolish, the rebellion is over and it's only a matter of time until we find her""",
	SEARCH_DUNGEON_12_3 = """— If so, then you don't need my help, things will work out for you on their own.""",
	SEARCH_DUNGEON_OPTION_34 = """If you won't play along I'm sure the other interrogators won't be as nice...""",
	SEARCH_DUNGEON_12_4 = """— Try me. I'm not going to betray her trust no matter what you or anyone else threatens to do to me.""",
	SEARCH_DUNGEON_OPTION_35 = """I can promise you that I'll pledge for Anastasia's safety""",
	SEARCH_DUNGEON_13 = """Aire pauses, considering your words for a long while.

— Surely your word would hold some weight and it seems you have certain privileges around here, but can I really trust you? What reason would you possibly have to help her?""",
	SEARCH_DUNGEON_OPTION_36 = """I'm actually on your side, if you help me out I'll help her stay alive""",
	SEARCH_DUNGEON_7_4 = """— Sorry, I'm not going to believe such an obvious lie.""",
	SEARCH_DUNGEON_OPTION_37 = """We could return you to the elven lands""",
	SEARCH_DUNGEON_7_5 = """— Nonsense, not only would I be abandoning my duty, I also don't want to be there after all this.""",
	SEARCH_DUNGEON_OPTION_38 = """We can charge you with hiding a criminal""",
	SEARCH_DUNGEON_7_6 = """— I can live with that, if anything it would prove the worth of my loyalty even more.""",
	SEARCH_DUNGEON_OPTION_39 = """I don't need any more reason than to make you feel better""",
	SEARCH_DUNGEON_14_1 = """— Those are some cheap words given my position. You really expect me to believe that?""",
	SEARCH_DUNGEON_OPTION_40 = """I believe we should do our best to make people less miserable""",
	SEARCH_DUNGEON_14_2 = """— You really think this way?.. That's what she believes in too. It sounds overly idealistic to me, though.""",
	SEARCH_DUNGEON_OPTION_41 = """She could provide some value on the political side of things""",
	SEARCH_DUNGEON_14_3 = """— No way. Her existence is a danger to the guilds and we both know it. She will be dealt with as soon as they get their hands on her.""",
	SEARCH_DUNGEON_OPTION_42 = """She'd make a wonderful addition to my harem""",
	SEARCH_DUNGEON_14_4 = """Aire bursts into laughter.

— Is that a lame attempt at a joke? If you're serious that is some terrible motivation, I don't know which would be worse in that case, her with you or the guilds. """,
	SEARCH_DUNGEON_7_7 = """— I'm sorry, I don't think I can trust you after all. Ana will be better off away from here even if she continues her life on the run, even in poverty.""",
	SEARCH_DUNGEON_15 = """Aire spends some time in silence during which conflicting emotions play across her face. Finally she lets out a long sigh.

— Fine, I'll trust you. If there's anyone from here who can act in her interest, it would be you. She's escaped to the elven lands. I've managed to secure a spot for her thanks to my heritage. You'd be able to find out more from the high priestess, assuming she'll let you meet her, but at this point I suspect it shouldn't be much of a problem for you.""",
	SEARCH_DUNGEON_16 = """You see Amelia still waiting near the entrance to the cells as you exit the dungeons, she beckons you over to her.

-How'd it go?""",
	SEARCH_DUNGEON_OPTION_43 = """I got the princess' location.""",
	SEARCH_DUNGEON_17 = """— Wow, really? I knew you had a silver tongue in you, great work. Duncan will want to know as soon as you're ready to deliver the information to him, don't worry I won't steal your spotlight if you want to wait a bit.""",
	SEARCH_DUNGEON_OPTION_44_1 = """I wasn't able to get any information on the princess.""",
	SEARCH_DUNGEON_18 = """— Aw, that's ok though, it was worth a try. I could tell by looking at her she'd be a tough one to crack. So.. have you considered my offer? I could try to get her talking if you want.""",
	SEARCH_DUNGEON_OPTION_44_2 = """This girl is a tough nut to crack""",
	SEARCH_DUNGEON_OPTION_45 = """Go ahead, it couldn't hurt.""",
	SEARCH_DUNGEON_19_1 = """— Don't worry, I'm sure I'll get something out of her, but it may take some time. I'll be sure to personally deliver the information to you when I get it.""",
	SEARCH_DUNGEON_OPTION_46 = """No, I think I'll find another way.""",
	SEARCH_DUNGEON_19_2 = """— Alright, I understand, just come talk to me if you want to reconsider.""",
	SEARCH_DUNGEON_OPTION_47 = """Actually I just wanted to talk with her, I've already got another way of finding the princess.""",
	SEARCH_DUNGEON_19_3 = """— Oh? Well if you just wanted to see an elf chained up you could've just come by whenever, we get those in from time to time. Well, the offer is still open if you change your mind, come visit me if you do.""",
	SEARCH_DUNGEON_OPTION_48 = """Thanks Amelia""",



	FINAL_OPERATION_MESSAGE = """In the morning you receive a messenger who asks you to meet Duncan. It seems fairly urgent and he should have a new mission for you.""",
	LOOKING_FOR_PRINCESS_1 = """— Many of the rebel forces now lie dead or reside in our prison. Unfortunately we missed the princess in our raid and we've got no leads as to where she may have gone. Our interrogation of the prisoners hasn't turned up much.""",
	LOOKING_FOR_PRINCESS_2 = """

— Don't think I've forgotten your bravery in the raid. Here, your reward. I trust I can continue to count on you, you've proven yourself to be very capable.""",
	LOOKING_FOR_PRINCESS_3 = """

— Oh, and here, your reward for your help in the raid, you've proven yourself to be very capable.""",
	LOOKING_FOR_PRINCESS_4 = """

— We still have to secure the princess.""",
	LOOKING_FOR_PRINCESS_OPTION_1 = """Let's get right into it, I'm eager to get to her myself.""",
	LOOKING_FOR_PRINCESS_OPTION_2 = """I currently have other issues to deal with.""",
	LOOKING_FOR_PRINCESS_OPTION_3 = """How goes the search?""",
	LOOKING_FOR_PRINCESS_5 = """-We've had no further leads on her location so far. So far no one has come forward with any new information.""",
	LOOKING_FOR_PRINCESS_OPTION_4 = """I'll track her down.""",
	LOOKING_FOR_PRINCESS_OPTION_5 = """I'll come back later.""",
	LOOKING_FOR_PRINCESS_6 = """As you search through the now empty halls and traces of recent battle you struggle to find anything useful. It seems the guilds' mercenaries and scavengers didn't waste any time. However after another half hour you notice a smaller scavenger.

The lone kobold is going through the rummage seemingly unaware of your presence. Having acquired a decent collection already you spot an uncharacteristically elegant silver bracelet on his hand. """,
	LOOKING_FOR_PRINCESS_OPTION_6 = """*Greet him*""",
	LOOKING_FOR_PRINCESS_OPTION_7 = """*Approach*""",
	LOOKING_FOR_PRINCESS_7 = """As you move closer he spots you and jumps up, backing off a bit.

— Hey, what do you want?

The kobold tediously looked you over.""",
	LOOKING_FOR_PRINCESS_OPTION_8 = """What are you doing here?""",
	LOOKING_FOR_PRINCESS_OPTION_9 = """That's a nice bracelet you have there""",
	LOOKING_FOR_PRINCESS_8 = """— Same as you. Trying to survive. Or you gonna insist you're not here to scavenge yourself?""",
	LOOKING_FOR_PRINCESS_9 = """— Of course it's nice since I've found it. You look like you want it yourself, eh? Hah, I can see when someone is after something. Just for you I'm ready to sell it. Only 500 gold and it's yours.""",
	LOOKING_FOR_PRINCESS_OPTION_10 = """That's rather expensive for something so simple""",
	LOOKING_FOR_PRINCESS_OPTION_11 = """I'd rather just take it by force""",
	LOOKING_FOR_PRINCESS_OPTION_FINE = """Fine, take the gold""",
	LOOKING_FOR_PRINCESS_OPTION_FINE_500 = """Fine, take the gold (500 gold)""",
	LOOKING_FOR_PRINCESS_OPTION_FINE_1000 = """Fine, take the gold (1000 gold)""",
	LOOKING_FOR_PRINCESS_OPTION_FINE_1500 = """Fine, take the gold (1500 gold)""",
	LOOKING_FOR_PRINCESS_OPTION_13 = """I'll consider it and return then""",
	LOOKING_FOR_PRINCESS_10 = """— Hah, trying to take me for a fool? I don't know how simple it is, but I can see you want it, and I bet you have the means to pay. Take it or leave it""",
	LOOKING_FOR_PRINCESS_11 = """Before you are able to make a move, the kobold swiftly escapes in a small hole in the ground taking his possessions with him. There's no way for you to follow him like this. You should probably return another day.""",
	LOOKING_FOR_PRINCESS_12 = """After some time you find the same kobold with the bracelet.

— Hey, made up your mind yet?""",
	LOOKING_FOR_PRINCESS_OPTION_14 = """Purchase""",
	LOOKING_FOR_PRINCESS_OPTION_14_500 = """Purchase (500 gold)""",
	LOOKING_FOR_PRINCESS_OPTION_14_1000 = """Purchase (1000 gold)""",
	LOOKING_FOR_PRINCESS_OPTION_14_1500 = """Purchase (1500 gold)""",
	LOOKING_FOR_PRINCESS_13 = """After some time you find the same kobold with a bracelet who seems to have returned to the same spot.

— It's the brute again. You better not try to give me shit again. I'm feeling generous so I'll still sell you the bracelet you want... for 1000 gold.""",
	LOOKING_FOR_PRINCESS_OPTION_15 = """It was 500 gold last time""",
	LOOKING_FOR_PRINCESS_OPTION_THINK = """I'll think about""",
	LOOKING_FOR_PRINCESS_OPTION_17 = """Trying to rip me off, you little bastard *attack*""",
	LOOKING_FOR_PRINCESS_14 = """— Yeah, no shit, consider this retribution for attacking me. Take it or leave, I don't care.""",
	LOOKING_FOR_PRINCESS_15 = """Same as the last time the kobold quickly disappears into one of the small holes leaving you with nothing. You should probably return another day.""",
	LOOKING_FOR_PRINCESS_16 = """After some time you find the same kobold with a bracelet who seems to have returned to the same spot.

— It's the same brute again. Must be hard not knowing when to learn. But I'm merciful, I'll still sell you the bracelet you want for 1500 gold.""",
	LOOKING_FOR_PRINCESS_OPTION_18 = """A beating will be your payment *attack*""",
	LOOKING_FOR_PRINCESS_17 = """This time you lunged slightly ahead of the kobold. He was still quick enough to spin away from your grasp at the last moment but he tumbled on his way, almost falling. You curse as he regains his composure and escapes. Then you notice he dropped the bracelet in his haste.

Unable to retrieve it without leaving the safety of his burrow, he only could swear back at you.

After closer inspection you confirm that it must belong to the royal family so it's time to take it to Myr.""",
	LOOKING_FOR_PRINCESS_18 = """As you pass the gold to the kobold, he gives away the bracelet and quickly disappears with the money. After closer inspection you confirm that it must belong to the royal family so it's time to take it to Myr.""",
	LOOKING_FOR_PRINCESS_OPTION_19 = """I've bought the bracelet""",
	LOOKING_FOR_PRINCESS_19 = """You've presented the bracelet to Amelia who closely inspected it for a few moments.

{color=yellow|Amelia: — Well, fine work. This certainly belonged to the royal family. The engraving was addressed to the youngest daughter.}

{color=aqua|Myr: — Well then, let's get this over with. }

Myr takes a small medallion out of her desk. As she chants the spell, the medallion in her hand starts glowing. After about a minute she finishes and turns back to you.""",
	LOOKING_FOR_PRINCESS_20 = """{color=aqua|Myr: — Alright, this will point in the previous owner's direction. Hold it in your hand and you'll feel slight vibrations.}

{color=yellow|Amelia: — Neat. Now you'll be able to track down our little problem. Heh, I wonder if it will keep vibrating in her presence as well...}

{color=aqua|Myr: — Leave your professional quirks out of this unless you want to be thrown out.}

{color=yellow|Amelia: — Alright, alright, I should be going anyway. Good luck [name], I'm waiting for your success.}""",
	LOOKING_FOR_PRINCESS_21 = """After testing the medallion you decide it points toward the Elven forests. Your goal should be visiting them now.""",
	LOOKING_FOR_PRINCESS_22 = """You ask for an audience with the elven High Priestess, who seems to act as the prime ruler of the elven capital. Despite a natural distaste for outsiders, your status forced the elves to accept your request for an audience.""",
	LOOKING_FOR_PRINCESS_23 = """The medallion kept pointing at the elven capital so you were left no other option but to meet the High Priestess, who acts as the prime ruler of the elven capital. Despite natural distaste for outsiders, your status forced the elves to accept your request for an audience.""",
	LOOKING_FOR_PRINCESS_24 = """You've been brought to a large room with a few guards in it and you're told to wait there. After a minute an elven woman appeared from the opposite side to approach you. Her stature and the guards' reactions clearly indicate her superior position.

— Usually we do not welcome outsiders in our lands, but we've made a promise to receive ambassadors from the human lands. State your business, stranger.""",
	LOOKING_FOR_PRINCESS_OPTION_20 = """You should show more respect to your guests""",
	LOOKING_FOR_PRINCESS_OPTION_21 = """I'm looking for a certain woman""",
	LOOKING_FOR_PRINCESS_OPTION_22 = """We didn't mean to offend you""",
	LOOKING_FOR_PRINCESS_25 = """— You are talking to Freya's High Priestess. There's no higher respect you could receive from us, [race]. Consider this Freya's benevolence, you'll receive the woman you want.""",
	LOOKING_FOR_PRINCESS_26 = """— We know what you are here for. Consider this Freya's benevolence, you'll receive the woman you want.""",
	LOOKING_FOR_PRINCESS_27 = """— Cease your useless banter. Consider this Freya's benevolence, you'll receive the woman you want.""",
	LOOKING_FOR_PRINCESS_OPTION_23 = """Easy as that?""",
	LOOKING_FOR_PRINCESS_OPTION_24 = """Why would you do that?""",
	LOOKING_FOR_PRINCESS_OPTION_25 = """Well, I'm not going to complain""",
	LOOKING_FOR_PRINCESS_28 = """— We have no interest in your human disputes. This woman came seeking refuge, but we are no charity. Once you take the woman I expect you to leave this place.

The priestess gave orders to the guards to get the princess out.""",
	LOOKING_FOR_PRINCESS_29 = """As Anastasia saw you, she realized what she was brought for and her face became pale.

{color=aqua|Anastasia: — No... What the hell?! You can't do this to me!}

{color=yellow|Priestess: — Cease your childish behavior, human, if you are truly royalty, act like it.}""",
	LOOKING_FOR_PRINCESS_OPTION_26 = """An honor to meet you, princess""",
	LOOKING_FOR_PRINCESS_OPTION_27 = """Now, now, there's no need to make a scene""",
	LOOKING_FOR_PRINCESS_OPTION_28 = """I've been waiting to get my hands on you""",
	LOOKING_FOR_PRINCESS_30 = """The princess paid little attention to your words and continued to lash out at the priestess, who seemed to grow more and more irritated.

{color=aqua|Anastasia: — They will kill me, like they killed my dad. And you betrayed me. I thought I could trust you!}""",
	LOOKING_FOR_PRINCESS_OPTION_29 = """*Remain silent*""",
	LOOKING_FOR_PRINCESS_OPTION_30 = """*Slap the princess and shut her mouth* (Physics Factor)""",
	LOOKING_FOR_PRINCESS_OPTION_31 = """Lets not jump to conclusions, surely we can discuss this""",
	LOOKING_FOR_PRINCESS_31 = """{color=green|Success}

Before she could say any more, you've leapt at Anastasia and delivered a loud slap to her face. Not expecting this she fell in shock to the ground. You seize the moment to subdue her, plugging her mouth and excusing yourself to the priestess.

{color=aqua|Priestess: — I'll excuse this unseemly display for now. Now leave and remember our agency in future. }

Saying this the priestess has left the hall and guards lead you to the exit. Speechless and bound, Anastasia had no option but to let you drag her away. """,
	LOOKING_FOR_PRINCESS_32_f = """{color=red|Failure}

""",
	LOOKING_FOR_PRINCESS_32 = """{color=aqua|Anastasia: — Traitorous bastards, you are worse than these people! You and your rotten Freya should've been-}

*Slap*

Before you managed to reach Anastasia, the priestess herself gave her a loud slap which made her fall to the ground in shock.""",
	LOOKING_FOR_PRINCESS_OPTION_32 = """There's no need to get violent""",
	LOOKING_FOR_PRINCESS_OPTION_33 = """Can't say I wouldn't do the same""",
	LOOKING_FOR_PRINCESS_OPTION_34 = """Alright, this is enough""",
	LOOKING_FOR_PRINCESS_33 = """{color=aqua|Priestess: — Silence, [race]!}

Her sudden outburst made you back off.

""",
	LOOKING_FOR_PRINCESS_34 = """The princess sat on the ground covering her cheek with a hand as the priestess glared at her,clearly enraged.

{color=aqua|Priestess: — I could excuse your insults, fool human, if only you kept it to us, but insult of the Goddess in this temple is a grave offence. If you were an elf commoner you would have had your tongue cut out already. }

{color=yellow|Anastasia: — ...}""",
	LOOKING_FOR_PRINCESS_35 = """{color=aqua|Priestess: — You, however, will have to answer for your crime with your life. Guards!}

{color=yellow|Anastasia: — What? No...}

Following the order, the guards seized Anastasia and also blocked your way from interfering. Still in shock from sudden turn of events, the princess couldn't believe this was happening to her.""",
	LOOKING_FOR_PRINCESS_OPTION_35 = """*Oppose*""",
	LOOKING_FOR_PRINCESS_OPTION_36 = """*Let her be executed*""",
	LOOKING_FOR_PRINCESS_36 = """You tell the priestess that you will need the princess alive no matter what. After observing the shocked princess she seemed to be more calm, yet unbendable.

{color=aqua|Priestess: — She shall be executed regardless of your needs. This is the law and we can't pardon it despite your or her status. Once her spirit is redeemed by the tree you can have her corpse. I presume this should suffice for your masters.}""",
	LOOKING_FOR_PRINCESS_OPTION_37 = """That's barbaric""",
	LOOKING_FOR_PRINCESS_OPTION_38 = """She's just a spoiled child, surely you could overlook this""",
	LOOKING_FOR_PRINCESS_OPTION_39 = """Her death by your hands could pose more danger for your lands""",
	LOOKING_FOR_PRINCESS_37 = """{color=aqua|Priestess: — I'm well aware of what she is, but this is the law and it will not be waived.}

""",
	LOOKING_FOR_PRINCESS_38 = """{color=aqua|Priestess: — Watch your tongue [race], or you might join her. The law is final and not debatable.}

""",
	LOOKING_FOR_PRINCESS_39 = """{color=aqua|Priestess: — We care not for petty threats. The traditional punishment will be delivered as always.}

""",
	LOOKING_FOR_PRINCESS_40 = """You notice that Zephyra cautiously signals you to let her negotiate on your behalf.""",
	LOOKING_FOR_PRINCESS_OPTION_40 = """As her guardian I request to take punishment for her""",
	LOOKING_FOR_PRINCESS_OPTION_41 = """*Allow Zephyra to negotiate*""",
	LOOKING_FOR_PRINCESS_OPTION_42 = """There's no helping it""",
	LOOKING_FOR_PRINCESS_41 = """Priestess makes a long pause while glaring at you.

{color=aqua|Priestess: — It is true that the guardian can be punished in a minor's stead. Though you must be aware that I can't simply execute the peaceful messenger of a foreign nation. Yet, our tradition demands blood. }

The priestess takes another long pause to contemplate the situation and finally answers.""",
	LOOKING_FOR_PRINCESS_42 = """{color=aqua|Priestess: — Very well, I'll allow you to take her punishment by sacrificing one of your followers.}""",
	LOOKING_FOR_PRINCESS_OPTION_43 = """*Accept*""",
	LOOKING_FOR_PRINCESS_OPTION_44 = """*Refuse* """,
	LOOKING_FOR_PRINCESS_43 = """You've chosen the sacrifice to take the place of Anastasia. As you part with [name], you don't expect to see [him] again.

{color=aqua|Priestess: — Leave now and tell your masters that we still stand by the agreement.}

Anastasia quietly observes as [name] being taken away, perhaps blaming herself for another death.""",
	LOOKING_FOR_PRINCESS_44 = """{color=aqua|Priestess: — Then we will proceed as decided.}

""",
	LOOKING_FOR_PRINCESS_45 = """With your approval, Zephyra walks forward. The Priestess observes her thoughtfully.

{color=aqua|Zephyra: — The ancient traditions are important, but... quite problematic. }

{color=yellow|Priestess: — What do you dare to suggest?}

{color=aqua|Zephyra: — Once I heard a story about a young elven lass who was fortunate enough to fall in love. It must've been very emboldening for her. But unfortunately she had fallen in love with a human male. A thing which could happen to any of us.}

{color=yellow|Priestess: — You... You have no idea what you are talking about.}""",
	LOOKING_FOR_PRINCESS_46 = """{color=yellow|Guard: — (whispering) Huh... What's this about?}

{color=aqua|Zephyra: — Ah, right, I remembered the man's name was Ansfrid, I can't quite recall the girl's though.}

You've noticed how the stone cold priestess visibly twitched when hearing that. The elven guards seemed to be puzzled over the whole situation.

{color=yellow|Priestess: — Enough. We've reached a decision. You can take your noble with you. The merciful Freya pardons her misdeed.}""",
	LOOKING_FOR_PRINCESS_47 = """By this order the princess is handed over to you and you give your thanks to the priestess.

{color=aqua|Zephyra: — Isn't Freya's graciousness truly moving? I'm sure this decision will be to the benefit of all in the end.}

{color=yellow|Priestess: — Sure, whatever. Leave and take your foul vixen with you.}

{color=aqua|Zephyra: — *sniff* Hey, [name], I'm not foul, am I?}""",
	LOOKING_FOR_PRINCESS_48 = """Once outside with the now silent princess, you ask Zephyra to explain what happened.

— Oh, well, a long time ago Alios had turned into a human male named Ansfrid and got up to some mischief. Or maybe possessed him... Anyway, did you know that Freya's high priestess can never engage in relationships with men? Worse yet non-elven men? Ah, please forget I said anything, haha.""",
	LOOKING_FOR_PRINCESS_OPTION_45 = """That sounds pretty sad""",
	LOOKING_FOR_PRINCESS_OPTION_46 = """So, she's a compelled lesbian?""",
	LOOKING_FOR_PRINCESS_OPTION_47 = """You were unexpectedly helpful""",
	LOOKING_FOR_PRINCESS_49 = """— Indeed, why are people so uptight? Don't you think it's awesome that Alios is so relaxed concerning such mundane things? Ah, sorry, I didn't mean to preach.""",
	LOOKING_FOR_PRINCESS_50 = """— I dunno, maybe she's chaste. She did look pretty frigid during that whole ordeal just now, but maybe it's all an act. Perhaps we'll never know.""",
	LOOKING_FOR_PRINCESS_51 = """— Why, thank you! Wait, what did you mean unexpectedly? If you're gonna tease me and treat me like a kid, I'll be acting more like one, you know. Surely you wouldn't want that?""",
	LOOKING_FOR_PRINCESS_52 = """Without wasting much time the guards have tied Anastasia to the large tree at the center of the sanctum. Before the ceremony started you've been forced to leave, which spared you from gazing on the princess's pleading face. After about half an hour her pale corpse is delivered.

It's time to return home.""",

	PRE_ANASTASIA_EXECUTION_1 = """As you show Duncan the Princess's corpse he makes a pained grimace. After you explained to him what happened he looked disappointed but accepting.

— A shame this happened, but I believe you did what you could. Finally this is over, so be prepared to step up to being the mayor, you deserve it.""",
	PRE_ANASTASIA_EXECUTION_OPTION_1 = """I want her elf servant""",
	PRE_ANASTASIA_EXECUTION_OPTION_2 = """That's an honor""",
	PRE_ANASTASIA_EXECUTION_OPTION_3 = """Pleasure doing business with you""",
	PRE_ANASTASIA_EXECUTION_2 = """— No can do. Need I remind you of all the important provisions you lost before the siege? This shall be your compensation to us.""",
	PRE_ANASTASIA_EXECUTION_3 = """— Hmm, fine, we have no use for her at this point, but do not expect her to be friendly, especially after the princess's death.""",
	PRE_ANASTASIA_EXECUTION_4 = """— We shall declare your succession in a week, until then you can rest.""",
	PRE_ANASTASIA_EXECUTION_5 = """You successfully deliver the princess to a prison cell and make your way to Duncan who seems to be aware of your success.

— You've done what few people dreamed to achieve, not only have you ended the war, but captured the princess herself. You've earned your future position. Once the princess' fate is decided we will let you become the mayor. Speaking of which, I've arranged the meeting for tomorrow. You should participate.""",
	PRE_ANASTASIA_EXECUTION_OPTION_4 = """What is going to happen to her?""",
	PRE_ANASTASIA_EXECUTION_OPTION_5 = """I'll join for sure""",
	PRE_ANASTASIA_EXECUTION_OPTION_6 = """More paperwork than actual fighting""",
	PRE_ANASTASIA_EXECUTION_6 = """— This is what we will decide tomorrow, but I'm positive her head will roll... or perhaps grace the gallows.""",
	PRE_ANASTASIA_EXECUTION_OPTION_7 = """She deserved it""",
	PRE_ANASTASIA_EXECUTION_OPTION_8 = """Seems like a waste to kill such a pretty girl""",
	PRE_ANASTASIA_EXECUTION_7 = """— I don't care what she deserves, she's dangerous and what has happened proves it. We get rid of her and move on.""",
	PRE_ANASTASIA_EXECUTION_8 = """— If she was not the Deranged King's daughter, I would agree with you, however she has proven too dangerous to be left alive.""",
	PRE_ANASTASIA_EXECUTION_9 = """— Until later then.""",
	PRE_ANASTASIA_EXECUTION_10 = """— Agreed, yet we can't simply finish her off and be done with it. Not on our own at least. Do come.""",
	PRE_ANASTASIA_EXECUTION_11 = """The guilds and landlords once again have gathered, now mostly to celebrate the upcoming finale of the war now that it has been won.

{color=aqua|Duncan: — As many have already heard, the rebellious princess has finally been captured by [name], who will be taking office as the next city mayor in light of [his] achievements. Today we, the guild leaders, decide the princess's fate. }

{color=yellow|Myr: — As all know, she instigated the civil war which led to many losses, in lives as well as in property...}""",
	PRE_ANASTASIA_EXECUTION_12 = """{color=aqua|Sigmund: — Really care 'bout yar magic toys, huh. Were mages always dat mercantile? }

{color=yellow|Myr: — It's hardly the time, besides you weren't the ones on the frontlines, exhausting your supplies for this pointless war. }

{color=aqua|Sigmund: — Hmph.}""",
	PRE_ANASTASIA_EXECUTION_13 = """{color=aqua|Duncan: — Her war weakened us, we're lucky the empire didn't make a move.}

{color=yellow|Amelia: — Hmm, according to my sources she and the rebels were mostly controlled by Gregor. A king's knight.}

{color=aqua|Duncan: — ...This does not excuse her involvement.}

{color=yellow|Amelia: — She might be not quite as dangerous as you try to present her to be though. Is she not simply misguided?}""",
	PRE_ANASTASIA_EXECUTION_14 = """{color=aqua|Duncan: — Nonsense. Without her existence there would be no rebellion. This is why we will sentence her to execution today.}

{color=yellow|Amelia: — And I presume, you wish her dead?}

{color=aqua|Duncan: — Certainly.}""",
	PRE_ANASTASIA_EXECUTION_15 = """{color=aqua|Myr: — I agree. The girl is nothing but a liability. The sooner we end this, the better.}

{color=yellow|Sigmund: — I can't say I like dat, but wat are da options we 'ave?}

{color=aqua|Myr: — Indeed, for once your dwarf brain gets it.}

Sigmund didn't seem to realize the insult or maybe didn't pay it attention.""",
	PRE_ANASTASIA_EXECUTION_16 = """{color=aqua|Amelia: — Ah, how tragic. Does our vote hold no power?}

{color=yellow|Duncan: — It does not, since three of us already agreed.}

{color=aqua|Amelia: — A grim fate to fall on the young maiden, and there's really nothing that can be done...?}""",
	PRE_ANASTASIA_EXECUTION_OPTION_9 = """I wish her to live""",
	PRE_ANASTASIA_EXECUTION_OPTION_10 = """*Stay silent*""",
	PRE_ANASTASIA_EXECUTION_19 = """All guild leaders except for Amelia turn and raise an eyebrow at you.

{color=aqua|Amelia: — Isn't it refreshing that our future mayor is so merciful?}

{color=yellow|Duncan: — What are you saying? We can't risk keeping her alive and you know that. What is your goal?}""",
	PRE_ANASTASIA_EXECUTION_OPTION_11 = """I will make her my wife""",
	PRE_ANASTASIA_EXECUTION_OPTION_12 = """I want to make her my slave""",
	PRE_ANASTASIA_EXECUTION_20 = """This outrageous statement even made Amelia look surprised.

{color=aqua|Duncan: — You can't be serious...}

{color=yellow|Myr: — I can't believe this either.}""",
	PRE_ANASTASIA_EXECUTION_21 = """{color=aqua|Amelia: — A true man, both a conqueror and a lover. Bards would sing of this and so many women would swoon over the tale. }

{color=yellow|Duncan: — Enough of your nonsense, you might've earned reputation enough to become mayor, but marrying a former rebel princess is ridiculous. }

{color=aqua|Amelia: — I actually don't think so.}

{color=yellow|Duncan: — What?}

{color=aqua|Amelia: — Consider the following, what if we have the princess marry our mayor and publicly acknowledge our regime? Won't she be more useful this way than having her executed? Moreover, many rebels would consider her as a legitimate co-ruler, while of course she would have none of the power. }

{color=yellow|Duncan: — That's... Never going to happen.}""",
	PRE_ANASTASIA_EXECUTION_22 = """{color=aqua|Amelia: — Well, you never know where a girl's heart might stray. I think it's better than to doom such a young beauty to death.}

The meeting descended into an uproar as people started arguing over the new idea.""",
	PRE_ANASTASIA_EXECUTION_23 = """{color=aqua|Myr: — Hmph, if it's [name], [he] might manage it, I suppose. }

{color=yellow|Sigmund: — I say it's okay if ya think so, we trust [name].}""",
	PRE_ANASTASIA_EXECUTION_24 = """Being left in minority Duncan remained silent for some time, as the room mostly came to the conclusion that your proposal is sound.

{color=aqua|Duncan: — Very well. If [name] can indeed convince the princess to publicly acknowledge our regime there's no harm in keeping her around, provided her status will be that of a slave. Even as... [his] wife. }

{color=yellow|Amelia: — I suspect it's not going to be easy at all, [name]. But I'm sure you'll figure something out. }

{color=aqua|Duncan: — If you fail, she will be executed as planned. Until either happens your election will be put on hold.

Duncan: — With this the meeting is over.}""",
	PRE_ANASTASIA_EXECUTION_25 = """{color=aqua|Amelia: — A [man] of high standing should also pursue lofty goals, eh? A former princess as a personal slave is not something you see on just any day.}

{color=yellow|Duncan: — I admire your ambition, but this is too much even for you. If she manages to escape, her status will allow her to lead another rebellion, even more fierce.}

{color=aqua|Amelia: — I see where you are coming from, but think about it, if she's to declare her acceptance of our institution and asks rebels to disband it would be even better for us.}

{color=yellow|Duncan: — She has shown no willingness to cooperate, so I find it hard to believe.}

{color=aqua|Amelia: — I believe our future mayor has proven [he]'s capable of great things. So why don't we try it?}""",
	PRE_ANASTASIA_EXECUTION_26 = """{color=aqua|Myr: — Hmph, if it's [name], [he] might manage it, I suppose. }

{color=yellow|Sigmund: — Yah, I agree. There's no point rushin' either.}""",
	PRE_ANASTASIA_EXECUTION_27 = """{color=aqua|Duncan: — ...Very well. You can attempt to persuade her. But if you fail she will be executed as planned. Until either happens your election will be put on hold.}""",
	PRE_ANASTASIA_EXECUTION_28 = """{color=aqua|Duncan: — Then, we've decided. The execution will be held next week. After that we will appoint the mayor. Thank you for your work.}""",

	MIND_CONTROL_1 = """— Well, who would've thought you would be so ambitious as to get your hands on the princess herself. But I assure you this shall not be easy. Duncan did not lie when he said she's completely unwilling to cooperate as she sees us as nothing but evil.

— You'll have to do your best in order to persuade her. I'll give you a little tip. Play on her naivety and sense of duty. She still holds a strong conviction that she's responsible for everyone's wellbeing. But if you aren't sure of yourself, you could try a less sophisticated ways.""",
	MIND_CONTROL_OPTION_1 = """What ways?""",
	MIND_CONTROL_OPTION_2 = """You mean torture""",
	MIND_CONTROL_2 = """— No-no, the torture wouldn't work on her, if anything, it would probably make things worse, she might become even more recalcitrant leading up to her death.""",
	MIND_CONTROL_3 = """— There exist some practices of enforced control. I've observed a magic technique which completely bends a target's mind to another's will. Then the master could issue any orders, precious little was left of the slave's own personality in the end though.

— I guess it's up to you if you wish to use something like this. I'm sure if you ask nicely enough Myr could point you in the right direction.""",
	MIND_CONTROL_OPTION_3 = """Thanks for the tip""",
	MIND_CONTROL_OPTION_4 = """I wouldn't want to do something like this""",
	MIND_CONTROL_4 = """— It's my pleasure. I wish you success in whatever you are planning.""",
	MIND_CONTROL_5 = """— Neither would I, a willing servant is always best after all. I just want to make sure you know it's an option. Use this information as you see fit.""",
	MIND_CONTROL_OPTION_5 = """About the princess...""",
	MIND_CONTROL_6 = """— Yes, how'd your negotiations go?""",
	MIND_CONTROL_OPTION_6 = """I've decided it's not worth it""",
	MIND_CONTROL_OPTION_7 = """I'm still on it""",
	MIND_CONTROL_7 = """— So you agree to her execution?""",
	MIND_CONTROL_8 = """— Shame you didn't succeed. The execution will be held in a week.""",
	MIND_CONTROL_OPTION_8 = """Ask about the mind control technique""",
	MIND_CONTROL_9 = """— Mind control? We aren't really that interested in it. It's a method that would be more popular for the sly puss and her company.""",
	MIND_CONTROL_OPTION_9 = """But you must know something""",
	MIND_CONTROL_OPTION_10 = """Your help would be invaluable""",
	MIND_CONTROL_10 = """— *Sigh* Try Xari, I believe she's been dabbling in it. Just don't get any weird ideas about other applications.""",
	MIND_CONTROL_11 = """— Hey, [name], what's up?""",
	MIND_CONTROL_12 = """I've been told you can help me with a mind control technique""",
	MIND_CONTROL_13 = """Just dropped to say hi *Leave*""",
	MIND_CONTROL_14 = """— Eeh? I haven't been asked about this in a long while.

Xari takes a long pause thinking about your request.

— I am in desperate need of gold right now, but this kind of magic it's too exhausting and I don't feel right doing it so... I can do it for you for 5000 gold. But this will be the only time and that's my price. Take it or leave it.""",
	MIND_CONTROL_OPTION_11 = """*Pay*""",
	MIND_CONTROL_OPTION_12 = """I'll think about it """,
	MIND_CONTROL_15 = """You pass Xari the huge sum which she stores away.

— Alright, let me prepare it.""",
	MIND_CONTROL_16 = """After a couple of hours Xari comes out with a small vial of bright pink liquid.

— Finally done. This potion will suppress the will of its target irreversibly. One last thing, you'll need a medium to act as the control device.""",
	MIND_CONTROL_OPTION_13 = """*Give her bracelet*""",
	MIND_CONTROL_17 = """You pass Xari the princess's bracelet which helped to locate her.

— Oh, this one must be expensive. Alright.

She chants a control spell as the bracelet and potion glows with a dark aura.""",
	MIND_CONTROL_18 = """— Done. Make your victim drink this, then put the bracelet on them, this way you'll also be able to command them. And one more time, their mind will be permanently broken. Don't ask me then to fix it, I can't.""",
	MIND_CONTROL_OPTION_14 = """Thanks""",
	MIND_CONTROL_OPTION_15 = """Noted""",
	MIND_CONTROL_19 = """— Alright, hold on.

Xari fishes a small ring out of her stash. As she chants the control spell, the ring and the potion glow with a dark aura.""",
	MIND_CONTROL_20 = """— Done. Make your victim drink this, then put the ring on them, this way you'll also be able to command them. And one more time, their mind will be permanently broken. Don't ask me then to fix it, I can't.""",



	ANASTASIA_EXECUTION_1 = """A week later. The citizens of Aliron gathered for Anastasia's execution in the main square. A curtain hangs between posts surrounding around a raised platform that has been prepared for the occasion. Despite being emotionally conflicted, Amelia has invited you over.


— Hey, isn't it a nice day? Maybe a bit too nice for such a sad occurrence. But cheer up, you are going to become the mayor soon after all. And it is important for your image to be seen in public.""",
	ANASTASIA_EXECUTION_OPTION_1 = """I don't think I should be cheerful at someone's execution""",
	ANASTASIA_EXECUTION_OPTION_2 = """I'm fine, at least this is over""",
	ANASTASIA_EXECUTION_2 = """— Well, maybe it won't be that bad after all.

Amelia smiled at you mysteriously.""",
	ANASTASIA_EXECUTION_3 = """— That's the spirit. After all, we got the best spots so we can easily leave if bored.""",
	ANASTASIA_EXECUTION_4 = """

Oh, look, it's about to begin.""",
	ANASTASIA_EXECUTION_5 = """In the main square of Aliron, a large platform has been constructed with a curtain hung around it. A crowd of citizens begins to gather early in the day and there is much excited speculation about the method of Anastasia's execution.

The guild leaders arrive, taking their seats next to you, and an expectant hush settles over the crowd. The curtain around the central platform is dropped and shouts rise up from the gathered citizens at the sight of a fully naked Anastasia bent over with her head and hands trapped in a set of wooden stocks. Her heavy breasts swing freely in the cool morning air.

The princess's face flushes deep red as hundreds of eyes fix on her, inspecting every inch of her naked and defenceless body. A herald stands next to her with a long scroll and begins the process of declaring her many crimes in detail, going on for several minutes as the princess squirms helplessly. """,
	ANASTASIA_EXECUTION_6 = """{color=yellow|Herald: — ...and having been found guilty of these manifold wicked crimes, the rebel Princess Anastasia is sentenced to...}

The herald pauses for dramatic effect.

{color=yellow|Herald: — ... A prolonged public humiliation. She will pay for her crimes against our fair city with the innocence of her virginal body. Every citizen should use her as they see fit. Our healers stand ready in case grievous physical injury is inflicted.}

{color=yellow|Anastasia: — Whaa...?}

The princess's face is a picture of fear and confusion, trying to decide if she should be happy her life is being spared, or if she would prefer execution to her imminent brutal degradation. Tears form in her eyes as a chorus of perverted cheers ring out from the crowd

A long and unruly line begins to form at the foot of the platform, with the city's men jostling and shouldering each other to get to the front. The city guards are hard-pressed to maintain order and stop them charging the platform.""",
	ANASTASIA_EXECUTION_7 = """Beside you, Amelia purrs and giggles at the spectacle of the princess's subjugation. 

{color=yellow|Amelia: — Well, isn't this much more entertaining than a boring old beheading? You know, I'm rather proud of myself.}

You turn to Amelia in surprise, momentarily distracted from the plight of the naked princess.

{color=yellow|Amelia: — Don't look so shocked! I simply convinced Duncan and the others that after this nobody will accept her as royalty again. She'll be neutralized, safe. Physically anyway, no guarantee what state her mind will be left in after getting fucked by every cock in the city...}

On the platform, the first man has climbed the stairs and is examining the princess's virgin cunt with his dirty fingers as the crowd catcalls and jeers. Anastasia squeezes her thighs together in a doomed effort to stop the man's crude inspection of her unused pussy. The man forcefully shoves a finger into her asshole instead, making the princess scream in pain.""",
	ANASTASIA_EXECUTION_OPTION_3 = """Clever move""",
	ANASTASIA_EXECUTION_OPTION_4 = """This is even worse, remind me never to piss you off""",
	ANASTASIA_EXECUTION_OPTION_5 = """That doesn't sound very convincing""",
	ANASTASIA_EXECUTION_8 = """{color=aqua|Amelia: — I did say I pity her, didn't I? And this is much more fun to watch too.}""",
	ANASTASIA_EXECUTION_9 = """{color=aqua|Amelia: — *giggle* Well, I can't take all the credit. Ever thought about how many of the landlords, the wealthy and the nobles would like to have their way with the one and only princess? After that thought took root in their minds, we managed to bring the matter to a vote in record time. These first guys in the line could do a much better job of disguising themselves, though.}""",
	ANASTASIA_EXECUTION_10 = """{color=aqua|Amelia: — Surely you don't believe that, do you? Even so, this was actually her choice. Yesterday, I informed her she would be irreparably humiliated instead of executed and I offered her a way to end her life painlessly, but she didn't take it, not that I expected her to. Moreover, I know more than one woman who wouldn't mind taking her place, provided there would be no consequences.}""",
	ANASTASIA_EXECUTION_11 = """With his grubby finger still inside Anastasia's ass the man roughly kicks her legs apart, spreading her wide. The princess wails and wriggles in the stocks, humiliated by the intrusion into her clenched sphincter The crowd roars in anticipation as the man pulls his sizable cock out of his pants and begins to rub it against her soft thighs. 

{color=yellow|Citizen: — You fucking bitch. My brother died in the war you started! 

{color=yellow|Anastasia: — I'm sorry! Please, don't! Don't hurt me!}

{color=yellow|Citizen: — It's too fucking late for that, princess cunt. Time for you to get what you deserve.}

The man beats Anastasia's round ass savagely until her asscheeks are red and raw. She cries out, her rear end writhing desperately to escape his cruel blows, exciting the laughing crowd further.

{color=yellow|Citizen: — There. That's got you nice and hot, don't it? Ready for your dishonouring?}

{color=yellow|Anastasia: — No... Please... I'm still a virgin!}

Lecherous laughter rings out from the square as the princess pleads desperately. """,
	ANASTASIA_EXECUTION_12 = """{color=yellow|Citizen: — No use begging now, princess cunt. Not every day a commoner like me gets to deflower a nubile virgin of the royal blood. Another hundred men waiting to do it if I don't, so best you get used to the idea.}

The man grabs Anastasia by her asscheeks, his fingernails sinking cruelly into her tender flesh as he spreads her pussy open. He spits onto her cunt, drawing another roar from the crowd. Anastasia's head twists in the stocks, trying to see the face of the man behind her, but her long blonde hair gets in the way. The man presses his cock against her pussy, holding it there.

{color=yellow|Citizen: — This is for my brother Harald, you cunt, I hope he's watching, somewhere.}

The man forces his cock into her, bursting her hymen open as the princess screams at her violation. The crowd hollers in debauched euphoria as the burly commoner takes the virginity of the princess, violently raping her bleeding pussy while she howls in agony and disgrace. """,
	DUNCANS_DECLARATION_START = """A crowd gathered in the square waiting for the announcement of the war's conclusion. Duncan stood on the balcony of the government building. He declared how the rebel leaders were finally defeated and punished accordingly. The people rejoiced.

— None can deny how instrumental the efforts of [Sir] [name] [surname] were in securing our victory. For [his] achievements he has been awarded the office of Mayor of Aliron.""",
	ANASTASIA_EXECUTION_13 = """It doesn't take long for the man to cum, gripping her slim waist and thrusting his penis deep as his seed pumps into her. He turns to the crowd and bows, eliciting another raucous cheer from the mob as his cum trickles down Anastasia's legs.. 

{color=yellow|Amelia: — Did I mention I pity her? I do, you know, poor thing. But this is so much more fun to watch.}

You turn to see Amelia has one hand up her dress and between her legs. Her arm is twitching rhythmically.

{color=yellow|Amelia: — You know, if you plan to take part, you might want to get in there before she gets too badly messed up. I don't think she'll be much fun after the first hour or so.}

A second man has climbed the platform. He walks around to look at the princess, grabs her hair and pulls her head up. 

{color=yellow|Citizen 2: — Hello princess, why don't we use this pretty mouth of yours as well? You've got a lot of work to do till you satisfy us all.}""",
	ANASTASIA_EXECUTION_14 = """Anastasia does not find any words to object, being at the mercy of the perverts from the crowd.

The man tugs his limp cock from his pants and pushes it in Anastasia's face. She quickly takes it in her mouth, eagerly licking and sucking on him to the delight of the crowd. She gags briefly at the smell of the peasant's unwashed penis but his cock is soon stiff and cramming into her throat as he grips her hair.

He pulls his cock out of her sucking mouth as she looks at him bewildered. He walks around behind her... """,
	ANASTASIA_EXECUTION_15 = """After a few hours, Anastasia barely resembles the feisty and spirited princess who so nearly toppled the guilds of Aliron. Her once-smooth skin has been whipped and beaten until it is bruised and torn, and her whole body is coated in the mingled semen of dozens of the city's men. The healers have stepped in several times to save her from shock or unconsciousness.

The line to abuse her has hardly shrunk at all, with several of those who have already had their pleasure rejoining for a second turn. Anastasia's cries and pleading have given way to ragged sobs and the occasional agonized moan as another man penetrates her ruined pussy or ass. The cheers of the crowd settle down into a regular rhythm.

Anastasia is displayed in the main square for a week, during which time there is never a break from the cocks defiling her holes. She is used by every man in the city as an example to any who would challenge the guilds. Eventually, her beaten and violated body disappears from the stocks. """,

	ANASTASIA_PERSUASION_1 = """You walk into a rather comfortable jail cell where a single unbound prisoner is held: the former leader of the rebellion, princess Anastasia. Despite her state she observes you with a sharp glare, yet remains silent. It seems she wasn't really tortured or interrogated since her arrival, but there would be little need for that.""",
	ANASTASIA_PERSUASION_OPTION_1 = """Recruit""",
	ANASTASIA_PERSUASION_OPTION_2 = """Mindbreak""",
	ANASTASIA_PERSUASION_2 = """You take the Xari's potion out of your pouch and forcefully pour it into Anastasia's mouth before she can realize what's going on. While she struggles, you hold her down, covering her mouth and nose to make sure she swallows it. Her build is too slight to resist much less fight back.

As you finish, she drops to the ground coughing heavily and clinging to her throat. For the last time her eyes display fear and hatred towards you, still not fully realizing what's happening to her. A moment later she loses consciousness.
""",
	ANASTASIA_PERSUASION_3 = """You put the enchanted bracelet over her wrist, the same one she'd treasured and lost some time ago. The bracelet shines for a moment then shrinks such that it cannot be removed.""",
	ANASTASIA_PERSUASION_4 = """You put the enchanted ring over her finger. The ring gives off a dim light, then tightly secures itself such that it can never be removed.""",
	ANASTASIA_PERSUASION_5 = """After another minute the princess starts moving and slowly rises up. Her eyes are devoid of consciousness and she only barely manages to focus on you standing before her. As you give her a couple of simple orders and she follows them, you decide the work is finished.""",
	ANASTASIA_PERSUASION_OPTION_3 = """Greetings, princess""",
	ANASTASIA_PERSUASION_OPTION_4 = """Don't give me such a hostile look, I'm your friend""",
	ANASTASIA_PERSUASION_OPTION_5 = """That room is too nice for scum like you""",
	ANASTASIA_PERSUASION_6 = """— ...What do you want?""",
	ANASTASIA_PERSUASION_7 = """— If your friendship is genuine, then you have to let me out of here.""",
	ANASTASIA_PERSUASION_8 = """— Hmph. I did not choose this room. Put me wherever you want, it changes nothing.""",
	ANASTASIA_PERSUASION_9 = """— I know I will be executed soon no matter what I do, what is it you want? """,
	ANASTASIA_PERSUASION_OPTION_6 = """I wish to save you""",
	ANASTASIA_PERSUASION_OPTION_7 = """Are you really ready to part with your life?""",
	ANASTASIA_PERSUASION_OPTION_8 = """Your sentence isn't final""",
	ANASTASIA_PERSUASION_10 = """A spark of hope appeared in Anastasia's eyes despite her effort to deny the possibility. She might've presented herself as being ready to die, but after all she wanted to live.

— I-i know you are lying. What other fate could there be for me now?""",
	ANASTASIA_PERSUASION_11 = """— My readiness can't change this situation. Why have you come?""",
	ANASTASIA_PERSUASION_12 = """— My execution was planned since the day my father was executed himself. Do you take me for a fool?""",
	ANASTASIA_PERSUASION_OPTION_9 = """There's a way to save you""",
	ANASTASIA_PERSUASION_OPTION_10 = """I have negotiated for your pardon""",
	ANASTASIA_PERSUASION_13 = """You tell the princess that to be saved she must comply with the guilds and publicly support them. However, her reaction is entirely exasperated at the thought.

— This is nonsense, these people have been after my life since I was seven. And now you say I can be pardoned. Who are you that I should take your word on it?""",
	ANASTASIA_PERSUASION_OPTION_11 = """I'm the next mayor of this city""",
	ANASTASIA_PERSUASION_OPTION_12 = """I've done a great number of deeds, including delivering you to them""",
	ANASTASIA_PERSUASION_14 = """Anastasia fell silent upon hearing that. She had no reason to doubt you, but she was still hesitant to hope.

— This can't be the only thing they actually expect of me, there's more isn't there?""",
	ANASTASIA_PERSUASION_OPTION_13 = """I will ask your hand, but you won't really have the option to refuse me""",
	ANASTASIA_PERSUASION_OPTION_14 = """You'll have to marry me """,
	ANASTASIA_PERSUASION_OPTION_15 = """You will also become my property""",
	ANASTASIA_PERSUASION_OPTION_16 = """Your destiny will be in my hands""",
	ANASTASIA_PERSUASION_15 = """Anastasia visibly blushed. She had expected to be married off for political purposes as dictated by her status eventually, but the possibility that such a situation could be an option now had never occurred to her.

— T-This is ridiculous. Why would I marry my captor?""",
	ANASTASIA_PERSUASION_OPTION_17 = """My feelings are sincere""",
	ANASTASIA_PERSUASION_OPTION_18 = """You could do worse, have I not at least proven myself capable already?""",
	ANASTASIA_PERSUASION_OPTION_19 = """Do you really have any other choice?""",
	ANASTASIA_PERSUASION_16 = """Anastasia blushed even harder, clearly having little experience dealing with such situations, yet she maintained a royal countenance.

— Even if this is true, I have no reason to accept the demands of my father's killers.""",
	ANASTASIA_PERSUASION_17 = """Anastasia paused to evaluate and reevaluate you and your statements. However, she wasn't ready to compromise and maintained a royal bearing .

— Regardless, I have no reason to accept the demands of my father's killers.""",
	ANASTASIA_PERSUASION_18 = """— Hmph, I have no reason to accept the demands of my father's killers.""",
	ANASTASIA_PERSUASION_19 = """— Hmph, turned into a plaything. Why would I accept such a fate?""",
	ANASTASIA_PERSUASION_OPTION_20 = """I promise to treat you fairly""",
	ANASTASIA_PERSUASION_OPTION_21 = """You'd prefer to die instead?""",
	ANASTASIA_PERSUASION_OPTION_22 = """It's the best option you have left""",
	ANASTASIA_PERSUASION_20 = """Anastasia went silent for about half a minute. Sadness and fatigue warred on her face faintly, but it seemed like she wasn't completely opposed to the possibility.""",
	ANASTASIA_PERSUASION_21 = """

— Don't they say it's better to die standing than to live on your knees?""",
	ANASTASIA_PERSUASION_22 = """

— Regardless, I have no reason to accept the demands of my father's killers""",
	ANASTASIA_PERSUASION_OPTION_23 = """I'm sorry for your loss, but you have to think of yourself now""",
	ANASTASIA_PERSUASION_OPTION_24 = """Do you have some sort of father complex?""",
	ANASTASIA_PERSUASION_OPTION_25 = """Being stubborn will not benefit you now""",
	ANASTASIA_PERSUASION_23 = """— If that's true, then you'll understand why I cannot pardon my father's murderers.""",
	ANASTASIA_PERSUASION_24 = """— Shut up!""",
	ANASTASIA_PERSUASION_25 = """— You don't understand it.""",
	ANASTASIA_PERSUASION_26 = """After my father was killed, I've been forced to live constantly on the run and in fear. What did we do to deserve this?""",
	ANASTASIA_PERSUASION_27 = """Amelia appeared in the room nearly soundless giving you a sign that she's out to help you.

{color=yellow|Amelia: — Allow me, I can explain as long as you are willing to take my word for it. King Alber was ruthless and cruel.}

{color=aqua|Anastasia: — You lie! Father was always kind to me.}

{color=yellow|Amelia: — I have no reason to lie, he was gone long before I was of an age to be able to benefit from his demise. He might've been kind to his kin, but not to his subjects. }

{color=aqua|Anastasia: — ...}""",
	ANASTASIA_PERSUASION_28 = """{color=yellow|Amelia: — Have you heard of the Broderick family? Lee Broderick was a successful merchant, but one day he delivered a book to the king as a gift. Upon reading the book, the king decided that it was meant as a hidden insult, or perhaps even a curse. His family and his children were sentenced to hang one by one. Some managed to flee, but were caught, and their accomplices hanged as well.}

{color=aqua|Anastasia: — ...}

{color=yellow|Amelia: — There was a small religious sect that was commanded to abandon their beliefs or leave the city. They refused and were burned alive at the city square. Let's not forget the unlucky harlots being whipped to death about every few months. That, I've personally seen with my own eyes on two occasions.}""",
	ANASTASIA_PERSUASION_29 = """{color=aqua|Anastasia: — Enough...}

{color=yellow|Amelia: — Didn't "Uncle" Greg tell you about these? }

{color=aqua|Anastasia: — No.}

Anastasia lowered her eyes emanating an aura of depression.

{color=yellow|Amelia: — I don't blame you, every child wants to be proud of their parents, but it shouldn't blind you.}

{color=aqua|Anastasia: — If I was wrong all along... What's the point of this struggle? I've always believed I was doing my best for the people.}""",
	ANASTASIA_PERSUASION_OPTION_26 = """You've tried to do what you thought was right""",
	ANASTASIA_PERSUASION_OPTION_27 = """You were mistaken, and it's time to make up for it""",
	ANASTASIA_PERSUASION_OPTION_28 = """Stop your useless whining""",
	ANASTASIA_PERSUASION_30 = """{color=aqua|Anastasia: — I don't feel like I have any right to make choices for anyone now.}""",
	ANASTASIA_PERSUASION_OPTION_29 = """If anything, you would still be able to help people instead of dying""",
	ANASTASIA_PERSUASION_OPTION_30 = """It's your fault, but you can redeem yourself by helping us. All you must do is submit and acknowledge our rule""",
	ANASTASIA_PERSUASION_OPTION_31 = """Your crimes can still be pardoned if you cooperate""",
	ANASTASIA_PERSUASION_31 = """{color=aqua|Anastasia: — .....I'm sorry, please leave me alone for now, I need some time to think.}

Amelia gives you a sign to comply with this request and you both leave the room.""",
	ANASTASIA_PERSUASION_32 = """— Her facade is broken, but we will only find out if you managed to persuade her tomorrow.""",
	ANASTASIA_PERSUASION_OPTION_32 = """Thanks for the help""",
	ANASTASIA_PERSUASION_OPTION_33 = """You are really impressive with stuff like this""",
	ANASTASIA_PERSUASION_33 = """— You are quite welcome, I've been having a lot of fun with this myself.""",
	ANASTASIA_PERSUASION_34 = """— He-he, of course I am and who do you take me for? I didn't earn my position in the servant's guild just by having a pair of great tits.""",
	ANASTASIA_PERSUASION_35 = """

— We still have her elf servant Aire in captivity. We could arrange their meeting next time if you think it may help our cause.""",
	ANASTASIA_PERSUASION_OPTION_34 = """Sure, this could get her thinking beyond herself""",
	ANASTASIA_PERSUASION_OPTION_35 = """No, that'll probably just make things more difficult""",
	ANASTASIA_PERSUASION_36 = """— Alright, I'll see what can be done. Let's hope you didn't piss her off too badly or she might become a nuisance.""",
	ANASTASIA_PERSUASION_37 = """

— Your call, you'll probably have to do something about her at some point anyway though.""",
	ANASTASIA_PERSUASION_38 = """

— Until then.

Amelia gives you a playful smile and leaves to go about her business""",
	ANASTASIA_PERSUASION_39 = """You enter the princess's cell. She seems in better spirits than you left her in. She must've made up her mind.""",
	ANASTASIA_PERSUASION_40 = """— Hello, [name]. I've made my decision. I'm sorry, but after thinking about it, I can't side with the guilds no matter what. I'll accept my fate with honor.

You realize there's nothing you can say to change Anastasia's mind at this point, so your only option is to leave.""",
	ANASTASIA_PERSUASION_41 = """You leave the jail cell and find Amelia waiting for you.

— Reject, huh. Too bad. I guess we don't have that many options now. Well, you'll know where to find me.""",
	ANASTASIA_PERSUASION_42 = """

— Hello, [name]... I've been thinking a lot about this. I think you're right. I shouldn't throw my life away. I... I think I can acknowledge the guilds and beg mercy for my actions, but I'm still unsure if I should become yours.""",
	ANASTASIA_PERSUASION_OPTION_36 = """I wish to reunite you with your friend (Call Aire)""",
	ANASTASIA_PERSUASION_OPTION_37 = """I wanted to return something of yours""",
	ANASTASIA_PERSUASION_OPTION_38 = """Eventually we'll have to come to an agreement""",
	ANASTASIA_PERSUASION_OPTION_39 = """I'll come later""",
	ANASTASIA_PERSUASION_43 = """Anastasia gives you a puzzled look. A few moments later the guards escort the elven girl to the cell at Amelia's orders.

{color=aqua|Anastasia: — Aire..? You're alive!}

{color=yellow|Aire: — Ana...}

The two girls hug weeping softly for the next couple of seconds. However both realize their reunion will not last long.

{color=aqua|Anastasia: — You look... worn.}

{color=yellow|Aire: — Don't worry, I'm fine. I've been through worse.}""",
	ANASTASIA_PERSUASION_44 = """Aire turns to you and you can still spot the hatred in her eyes.

{color=yellow|Aire: — I'm sorry, but this [man] has no honor. You should never fall into [his] hands. }

{color=aqua|Anastasia: — Wha... why? }

{color=yellow|Aire: — I'm sorry, but please believe me. [He]'s but a beast. I don't believe [he] will treat you with any sort of respect.}

Anastasia kept silent, analyzing her friend's words. Looks like her trust for you has taken a big hit.

After a few more exchanges Aire is taken away by the guards. The princess gathered her composure, forcing away the hope and sadness that had taken over her features.""",
	ANASTASIA_PERSUASION_45 = """Anastasia remained silent as Aire left the room.""",
	ANASTASIA_PERSUASION_46 = """Aire turns to you. Her face displays a mix of confusion and respect for you.

{color=aqua|Anastasia: — Aire... I-I've been persuaded. I mean this [man] has proposed that I become [his] property in exchange for my life.}

{color=yellow|Aire: — So that's how it turned out... }

Aire sighed deeply in contemplation.""",
	ANASTASIA_PERSUASION_47 = """{color=yellow|Aire: — I'd ask you to save yourself. This [man], while once our enemy, has been one of the few truly honorable persons I've known. If [he] managed to negotiate for your life I think you should accept the opportunity.}

{color=aqua|Anastasia: — It's unusual for you to endorse someone like this.}

{color=yellow|Aire: — Yes, but... you can't die now. You are the kindest person I've ever known.}""",
	ANASTASIA_PERSUASION_48 = """

{color=yellow|Aire: — I can't say I vouch for this [man], but [he] has treated me fairly so far. If [he] managed to negotiate for your life I think you should accept the opportunity.}""",
	ANASTASIA_PERSUASION_49 = """

{color=aqua|Anastasia: — Aire, but you know, I've never... what if I can't be what [he] asks?}

{color=yellow|Aire: — I-I think you will be alright, you are very graceful and beautiful after all.}

...After a few more minutes of chatting, Aire is finally taken away.""",
	ANASTASIA_PERSUASION_50 = """— Thank you for letting me meet with her, that was generous of you.""",
	ANASTASIA_PERSUASION_51 = """You pass Anastasia the bracelet you've found at the abandoned base.

— This is... I thought I'd lost it. Where did you get it? You went all the way back to the hideout...

— Thank you. This bracelet was a gift from my father. I understand, he wasn't a good king, but... It has been my only memento for all these years.""",
	ANASTASIA_PERSUASION_52 = """— I know that, but I don't really know if I can trust you.""",
	ANASTASIA_PERSUASION_OPTION_40 = """I will shower you with love""",
	ANASTASIA_PERSUASION_OPTION_41 = """I promise to treat you with dignity""",
	ANASTASIA_PERSUASION_OPTION_42 = """Your needs will be met, what more can you ask?""",
	ANASTASIA_PERSUASION_53 = """Anastasia stared at the wall, weighing your words.""",
	ANASTASIA_PERSUASION_54 = """

— I'm sorry, I can't agree to your proposal. I won't be able to make myself accept you as my [master]. Now go, I know what is waiting for me and I am prepared.""",
	ANASTASIA_PERSUASION_55 = """You leave the jail cell and find Amelia waiting for you.

— Rejected, huh. Too bad. I guess we don't have that many options now. Well, you know where to find me if you need anything.""",
	ANASTASIA_PERSUASION_56 = """— I-I will accept your demand. I will announce whatever support the guilds want of me and I'll become... yours. After all you were right, it's my duty to continue serving the people, even if I won't be royalty anymore.""",
	ANASTASIA_PERSUASION_57 = """— But I have one condition. Could you ask your guild leader girl to come?""",
	ANASTASIA_PERSUASION_58 = """Soon after she said it, the cell door opens and Amelia walks in. Looks like she had lingered, awaiting the outcome of your discussion.

{color=aqua|Amelia: — How may I be of service? }

{color=yellow|Anastasia: — I want you to promise me Aire's safety. No, wait, I want you to let us meet occasionally as well.}

{color=aqua|Amelia: — Done, we can move your little elf friend to [name]'s service for that matter. I presume you won't deny another servant, right?}

{color=yellow|Anastasia: — ...This would be very much to my liking.}""",





	ANASTASIA_PERSUASION_59 = """— Well, well, looks like you've done it. You've managed to persuade the haughty princess herself. I'm very impressed. We'll prepare her for the speech, and then we'll stage an announcement.""",
	ANASTASIA_PERSUASION_OPTION_43 = """I couldn't have done it without you""",
	ANASTASIA_PERSUASION_OPTION_44 = """She must be smitten with me""",
	ANASTASIA_PERSUASION_OPTION_45 = """Can't wait for this to be finally over""",
	ANASTASIA_PERSUASION_60 = """— No need for flattery, you sealed the deal.""",
	ANASTASIA_PERSUASION_61 = """— Haha, I wonder. How will you handle a pure maiden's heart though?""",
	ANASTASIA_PERSUASION_62 = """— Don't worry, now comes the best part.""",
	ANASTASIA_PERSUASION_63 = """— Anyway, I'll let you know in about 3 days. Have fun until then.""",


	ANASTASIA_PERSUASION_2_MARRY1 = "— But tell me, I wanna know, why would you choose me?",

	ANASTASIA_PERSUASION_2_MARRY1_OPTION1 = "I've fell in love with first sight (Charm Factor)",
	ANASTASIA_PERSUASION_2_MARRY1_OPTION2 = "I can't stop imagining you naked (Sex Factor)",
	ANASTASIA_PERSUASION_2_MARRY1_OPTION3 = "How could anyone pass on a girl like you?",
	ANASTASIA_PERSUASION_2_MARRY1_OPTION4 = "Well, technically you still are a princess",

	ANASTASIA_PERSUASION_2_MARRY2_1 = "\n\nAnastasia blushes heavily and looks away at your remark, but does not seem to doubt it.",
	ANASTASIA_PERSUASION_2_MARRY2 = "— I-I don't know if I can answer your feelings here, this is too much pressure for me.",

	ANASTASIA_PERSUASION_2_MARRY2_OPTION1 = "You can take it at your own pace (Charm Factor)",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION2 = "We can work on it once things are set out (Sex Factor)",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION3 = "I have little interest in your feelings, as long as I can get your body",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION4 = "I understand, it would be a lot of pressure for anyone, but you can do it",

	ANASTASIA_PERSUASION_2_ENSLAVE1 = "— I have to ask, what plans exactly do you have for me?",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION1 = "I'm sure your charisma and experience can help with management",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION2 = "You will make a good house servant",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION3 = "You will have to become trained in physical work or maybe fighting",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION4 = "A bed warmer seems like an ideal place for you",

	ANASTASIA_PERSUASION_2_ENSLAVE2_1 = "— Is that so... So you plan to also use me in a... intimate way?",
	ANASTASIA_PERSUASION_2_ENSLAVE2 = "— So, I will have to become your property. I assume, that also mean in a... intimate way?",

	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION1 = "Naturally, but I can promise you won't regret it. (Sex Factor)",
	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION2 = "To be frank, I'd not be able to pass on a beauty like you. (Charm Factor)",
	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION3 = "Well, this would happen sooner or later.",
	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION4 = "I don't really have such interest in you",

	ANASTASIA_ACCEPT_MARRY = """

— I-I will accept your offer. I will announce whatever support the guilds want of me and I'll become... yours. I can't believe this is where I would end up, but I'll try to accept you as my consort.""",
	ANASTASIA_ACCEPT_ENSLAVE = """

— I-I will accept your demand. I will announce whatever support the guilds want of me and I'll become... yours. After all you were right, it's my duty to continue serving the people, even if I won't be royalty anymore.""",


	ANASTASIA_PERSUASION_NEXTDAY = "By this time Anastasia must have decided if she's willing to accept your proposal. It's a good idea to visit her again.",


	ANASTASIA_DECLARATION_1 = """Today is your inauguration. With the civil war coming to an end, the people gather expecting a declaration of the victory. The central square is packed with nearly every citizen capable of attending, all in anticipation of the event.

Anastasia steps out onto the balcony of the government building and the crowd's mumbling gives way to silence awaiting for her words.

— People of the Aliron. I am Anastasia, the former princess and leader of the rebels. I remember being at this square when I made my announcement before. I know that many of you detest me for the conflict I brought on, but I am here to... ask for your forgiveness.

Upon hearing this the crowd seemed to beam with enthusiasm, while Anastasia mustered her resolve.""",
	ANASTASIA_DECLARATION_2 = """— My ways were wrong and I've led many people to their demise. I deeply regret it and I wish nothing else but for this war to stop. This is why I ask for those who are still out there fighting for my sake, to stop and surrender.

— I'm no longer the rebel leader. I know some of you still believe it is my birth right to rule, but I am no longer eligible. Instead, from now on I will be supporting the newly elected mayor of Aliron, [Sir] [name] [surname]. I will be at [his] mercy while doing my best for the sake of the people.

Upon hearing your name you come out of the shadows, delivering a quick bow and hugging Anastasia around the waist. The crowd is energized, as the rumors have been spread for some time of your deeds and how you're going to become the next ruler. Spontaneous applause breaks out.""",
	ANASTASIA_DECLARATION_3 = """{color=aqua|Male Citizen 1: — It's finally over.}

{color=yellow|Male Citizen 2: — She's really quite a beauty.}

{color=aqua|Female Citizen: — They make a nice pair}""",
	ANASTASIA_DECLARATION_OPTION_1 = """Wave to the crowd""",
	ANASTASIA_DECLARATION_OPTION_2 = """Fondle Anastasia's butt""",
	ANASTASIA_DECLARATION_4 = """You spend some more time greeting the citizens as Anastasia finishes her speech. Soon enough the announcement is declared to be over and you walk back inside the building.""",
	ANASTASIA_DECLARATION_5 = """As Anastasia continues her speech your hand, which she's become only a little accustomed to, moves lower and lands on her butt, making her to noticeably stutter and blush. Her discipline allows her to finish the speech without any terrible mistakes though and you walk back inside the building together.""",
	ANASTASIA_DECLARATION_1MC = """Today is your inauguration. With the civil war coming to an end, the people gather expecting a declaration of the victory. The central square is packed with nearly every citizen capable of attending, all in anticipation of the event.

Anastasia steps out onto the balcony of the government building and the crowd's mumbling gives way to silence awaiting her words. You hand her the guild's prepared statement and instruct her to speak.

— People of the Aliron. I am Anastasia. The former princess and leader of the rebels. I remember being at this square. When I made my announcement before. You are right to detest me. For the war was indeed all my fault. So I am here. To beg for your forgiveness.

The crowd seems satisfied with her words, not noticing her halting oration or perhaps not remembering her more eloquent speech so many days ago. """,
	ANASTASIA_DECLARATION_2MC = """— My ways were wrong. And I've led many people to their demise. I deeply regret it. And I wish for this war to stop. This is why I ask. For those who are still out there. Fighting for my sake. To stop and surrender.

— I'm no longer the rebel leader. Some of you believe it is my birth right to rule. I renounce all claims to rule. From now on I support. The newly elected mayor of Aliron. [Sir] [name] [surname]. I will be at [his] mercy. I am now willingly [his] slave.

Upon hearing your name you come out of the shadows, delivering a quick bow and hugging Anastasia around the waist. The crowd is energized, as the rumors have been spread for some time of your deeds and how you're going to become the next ruler. Spontaneous applause breaks out.""",

ANASTASIA_DECLARATION_4MC = """You spend some more time greeting the citizens as Anastasia reads aloud the rest of her speech. With that the announcement is declared to be over and you walk back inside the building. It seems like the crowd did not sense or perhaps care that there was anything amiss with the princess.""",
	ANASTASIA_DECLARATION_5MC = """As Anastasia continues reading the speech aloud you slip your hand under her skirt and knead her rump. She delivers her lines as steadily as before though a distinct blush becomes visible on her face. She finishes without any terrible mistakes and you walk back inside the building. It seems like the crowd did not sense or perhaps care that there was anything amiss with the princess.""",



	FINAL_WORDS_1 = """{color=aqua|Duncan: — Congratulations, you finally made it. The rebel forces won't die out just yet, but they should never be able to unite again.}

{color=yellow|Sigmund: — Dis's good 'nuf, as long as dey won't be takin' towns.}

{color=aqua|Duncan: — So now you're officially mayor.}

{color=yellow|Sigmund: — Let's get to da feast already.}""",
	FINAL_WORDS_OPTION_1 = """Thank you""",
	FINAL_WORDS_OPTION_2 = """I will miss the thrill""",
	FINAL_WORDS_2 = """The end of the First Act. Thank you for playing.""",



	AFTER_ELECTION_PRINCESS_1 = """After the feast you find Anastasia nervously waiting for you.""",
	AFTER_ELECTION_PRINCESS_2 = """

— [name]... So, what are you going to do with me now? You did say that you fancied me. Was it the truth, or are you planning to just use me however you feel like now?""",
	AFTER_ELECTION_PRINCESS_3 = """

— So, I'm your slave now... What are you planning to do with me?""",
	AFTER_ELECTION_PRINCESS_OPTION_1 = """I have feelings for you""",
	AFTER_ELECTION_PRINCESS_OPTION_2 = """I'm not really interested in you""",
	AFTER_ELECTION_PRINCESS_OPTION_3 = """You are just a fine trophy""",
	AFTER_ELECTION_PRINCESS_OPTION_4 = """You'll be a great plaything""",
	AFTER_ELECTION_PRINCESS_OPTION_5 = """I haven't decided yet""",
	AFTER_ELECTION_PRINCESS_4 = """Anastasia blushed fiercely upon hearing that, still not used to the situation and being in a submissive role.

— That's so? Then you must wish to lay with me. I'm... not entirely against it""",
	AFTER_ELECTION_PRINCESS_5 = """Embrace her""",
	AFTER_ELECTION_PRINCESS_6 = """Not today""",
#	AFTER_ELECTION_PRINCESS_7 = """You chivalrously carry Anastasia to your bedroom.
#
#— I'm sorry, this is my first time with a man.""",
#	AFTER_ELECTION_PRINCESS_8 = """After she removes her clothes, the princess lies down on the bed at your instruction. Her well proportioned body lies before you.""",
#	AFTER_ELECTION_PRINCESS_9 = """With some preparation Anastasia manages to become wet enough for you to penetrate her relatively painlessly. She endures the initial discomfort as you savor the feel of her unused pussy.""",
#	AFTER_ELECTION_PRINCESS_10 = """In a few moments you both climax. Her eyes roll up into her head in bliss as your seed fills her.""",
#	AFTER_ELECTION_PRINCESS_11 = """— I-I'm not sure what to say. I guess I didn't expect it to feel this good. I'm glad my first time was with you.""",
	AFTER_ELECTION_PRINCESS_7 = """Smiling, you take the princess by the hand and lead her to your bedroom.""",
	AFTER_ELECTION_PRINCESS_CONSENT_1 = """In the bedroom, you close the door behind Anastasia and enclose her in a tight embrace that lifts her off her feet. 

You set the princess back down, holding her head in your hands and kissing her deeply, your tongue tasting her full lips and exploring her uncertain mouth. Your hands run through her hair and down to her shapely butt, where you give a firm squeeze that makes her gasp with surprise.

Drawing back you tell Anastasia how you have waited long for this moment, and you will not wait anymore. She blushes and asks what you expect of her. 

You grin, and explain that the first step is to remove her clothing.""",
	AFTER_ELECTION_PRINCESS_CONSENT_2 = """Anastasia begins to undress reluctantly, unbuckling the knee-high boots and slipping them off her stockinged legs. She shrugs the blue cloak off her shoulders and hands it to you, then loosens the girdle around her waist and slips it off. She hesitates for a moment.

{color=yellow|Anastasia: — I— I usually have Aire to help me with my dress. If it won't trouble you, could you assist me?}

Anastasia turns around and lifts her long blonde hair off her shoulders. Tossing her cloak aside, you stand close behind and begin to unfasten the tiny hooks that keep the corset part of her dress in place. The scent of her hair is sweetly fragrant, like honeysuckle, as you finish unclipping the dress. She looks at you nervously over her bare shoulder.""",
	AFTER_ELECTION_PRINCESS_CONSENT_3 = """You help Anastasia to free herself of the top part of the dress, letting it fall to expose her beautiful ripe breasts. She blushes at the sudden nakedness and you embrace her from behind, your teeth finding the smooth skin of her neck as your hands slide gently up her taut belly to cup her tits. You feel her delicate nipples harden under the pressure of your fingertips.

You squeeze her breasts then transfer your hands to her waist where you peel the dress over her hips and let it fall to the floor. She stands nude but for stockings and silk panties as you turn her around to face you. She is a vision of beauty, her fair skin flawless and hair like spun gold in the warm glow of the lantern-light. She cover hers breasts with her hands, embarrassed.""",
	AFTER_ELECTION_PRINCESS_CONSENT_4 = """You take her wrists and move them away so you can admire her voluptuous breasts, then pull Anastasia's perfect figure against you, circling her waist and sliding your hands inside her panties. Your hands lift and part her butt-cheeks and your middle finger traces a line down the center of her ass into the cleft between her legs. She yelps softly into your shoulder, trembling.

You slip the silk panties over her round ass and let them fall around her ankles. You tug your shirt over your head so her naked breasts are pressing against your bare chest. You caress her nude body greedily and she whispers in your ear, her voice tense with unwilling arousal. 

{color=yellow|Anastasia: — Um... What would you... have me... do?}""",
	AFTER_ELECTION_PRINCESS_CONSENT_5 = """You bring Anastasia to the bed and lay her down, then watch as she carefully rolls the hosiery down over her sleek thighs. Still blushing, she plays to your intent gaze, pulling the stockings slowly from her toes and casting them away. You unbuckle your belt and let your pants drop, revealing your stiff cock. The princess's blue eyes widen as she bites her lip and instinctively presses her thighs tight.

{color=yellow|Anastasia: — Oh! That's... It's... You're...}

You climb onto the satin sheets and lay beside Anastasia, fondling her finely-proportioned curves. Your fingers press in between her legs and you begin to tease her slit, feeling its tightness as your thumb glides across her clit. Her virgin pussy quickly grows slick with arousal as you finger her, and her hands brush against your penis as you bite gently on her ear and neck.""",
	AFTER_ELECTION_PRINCESS_CONSENT_6 = """With one hand, you spread Anastasia's legs wide and her breath catches as you swing your body up over hers. You hold yourself there for a moment, pinning her wrists to the bed. She looks up into your eyes and you see desire mingling with the fear. You stoop to kiss her again and the shaft of your cock presses against her clit. She gasps breathlessly as your tongue slides into her mouth.

{color=yellow|Anastasia: — W-wait, I'm not-.}

Anastasia cries out as your thick cock bursts through her hymen and fills her pussy. Her wetness lessens the discomfort as your penis thrusts into her, stretching her unused cunt as you drive yourself deep. A thin smear of virginal blood coats your shaft as you pull out, before plunging back in between her pussy lips. Mouth hanging open, arms pinned, Anastasia moans helplessly while you fuck her.""",
	AFTER_ELECTION_PRINCESS_CONSENT_7 = """Anastasia's eyes roll back and her body shudders as an orgasm overwhelms the young princess. Penetrating her tight pussy again and again, your own orgasm begins to build as her slim legs curl around your waist. You hold her down on the bed as your powerful cock pounds into her, and when your cum explodes inside her, you fall on top of her.

Your tongue fills Anastasia's mouth as her pussy convulses around your orgasming cock, milking the cum from you. She sighs bodily and collapses back on the pillows, your penis still gripped inside her pussy. Her breasts and belly heave wildly as she pants for breath. A sheen of sweat sticks a lock of hair to her cheek and makes her skin shine in the lamplight. A shy look spreads across the princess's gorgeous face.

{color=yellow|Anastasia: — I didn't know this would feel so good. D-Did I do well?}""",
	AFTER_ELECTION_PRINCESS_CONSENT_OPTION_1 = """You did majestically""",
	AFTER_ELECTION_PRINCESS_CONSENT_OPTION_2 = """Not bad for a first time""",
	AFTER_ELECTION_PRINCESS_CONSENT_OPTION_3 = """Passable, but you'll get better with more practice""",
	AFTER_ELECTION_PRINCESS_CONSENT_REPLY_1 = """{color=yellow|Anastasia: — Thank you... Wait, are you mocking me?}

{color=yellow|Anastasia: — For some reason I feel at peace with you. My first night with a man wasn't so bad after all. C-Can I sleep next to you until the morning?..}""",
	AFTER_ELECTION_PRINCESS_CONSENT_REPLY_2 = """{color=yellow|Anastasia: — T-Thanks, I guess I can't compete with you?}

{color=yellow|Anastasia: — For some reason I feel at peace with you. My first night with a man wasn't so bad after all. C-Can I sleep next to you until the morning?..}""",
	AFTER_ELECTION_PRINCESS_CONSENT_REPLY_3 = """Anastasia shies away slightly offended, but quickly snaps out of it.

{color=yellow|Anastasia: — For some reason I feel at peace with you. My first night with a man wasn't so bad after all. C-Can I sleep next to you until the morning?..}""",

	# Idk part
	AFTER_ELECTION_PRINCESS_12 = """The princess's face becomes slightly more relaxed but also uncertain as she hears your words. Deciding she'll be useful for some tasks or barter later on you decide to leave it at this for now.""",
	AFTER_ELECTION_PRINCESS_13 = """Anastasia frowned upon hearing that but had no choice, but to comply.

— I see... I guess I'm at your mercy now.""",
	AFTER_ELECTION_PRINCESS_OPTION_6 = """I will claim my prize today""",
	AFTER_ELECTION_PRINCESS_OPTION_7 = """I don't feel like doing it """,
#	AFTER_ELECTION_PRINCESS_14 = """You order the princess to join you in your bedroom, deciding it shall be a great way to end the evening.""",
#	AFTER_ELECTION_PRINCESS_15 = """At your command, Anastasia removes her clothes and you position her on the bed on all fours. Deciding it's a suitable position to complete your conquest of her, you quickly mount her from behind claiming the girl's virginity. Despite her sobs she does not plead for you to stop, stoically enduring the pain and humiliation for the rest of the night.""",
#	AFTER_ELECTION_PRINCESS_16 = """Anastasia looks puzzled by your answer but does not protest. However, she seems nervous. Events are not playing out as she expected.""",
	AFTER_ELECTION_PRINCESS_16_OLD = """Anastasia looks puzzled by your answer but does not protest. However, she seems nervous. Events are not playing out as she expected.""",
#	AFTER_ELECTION_PRINCESS_17 = """After the feast you've found your mindbroken Anastasia, who seems to patiently wait for you with a somewhat vacant look to her eyes.""",
	AFTER_ELECTION_PRINCESS_OPTION_8 = """Put her to use""",
	AFTER_ELECTION_PRINCESS_OPTION_9 = """Maybe another time""",
#	AFTER_ELECTION_PRINCESS_18 = """By your order Anastasia removes her clothes and you drop her on the bed on all fours. Deciding it's a suitable position to complete your conquest of her, you quickly mount her from behind claiming broken girl's virginity. Despite her state, she offers a nice warmth and tightness so you have a fairly satisfying night.""",
	AFTER_ELECTION_PRINCESS_PRE_14 = "You order the princess to take your hand and you lead her to the bedroom.",
	AFTER_ELECTION_PRINCESS_14 = """Inside the bedroom, you order Anastasia to close the door and then stand in front of you. You lay down some ground rules. As your slave she will have to call you the Master at all times, and do whatever you demand. 

Anastasia nods mutely, making you reprimand her gently. 

{color=yellow|Anastasia: — I mean, yes. Yes, M... Master. As you say.}

You walk around her, inspecting your new property closely. You lift her dress at the back and run the palm of your hand inside her lace petticoats, up her inner thigh, and into the cleft of her tense ass. Anastasia trembles but does not protest. You reach over her shoulder and into the top of her blouse, where you take the weight of one breast in your cupped hand. """,
	AFTER_ELECTION_PRINCESS_15 = """Standing behind her with your hand down her cleavage, lightly pinching a nipple, you instruct her to relax.

{color=yellow|Anastasia: — I-I'm sorry, M-Master. I'm trying, I'm just nervous}

You pinch her nipple harder for a second and she squeals. You explain that excuses for failure will not be tolerated. Releasing her breast, you come around in front. Anastasia looks at you reproachfully, unable to shake off a lifetime of expected deference so easily. 

{color=yellow|Anastasia: — There's no need to hurt me, I'll do whatev-}

You cut her off with a quick, casual slap across the face and instruct her not to speak unless spoken to. Her cheek reddens from the blow but she is silent, her bright blue eyes wary.

You explain that you are disappointed with her rebelliousness, and that she will have to earn your trust if she wishes not to have a worse fate happen to her. It is in her interests, you tell Anastasia, that she learns to please you first in all things. With that, you order her to disrobe.""",
	AFTER_ELECTION_PRINCESS_16 = """Anastasia blushes deeply at your order to undress and looks as if she will argue, so you warn her that she can keep her fancy clothes if she undresses herself. If she makes you strip her, the clothes will be gone. 

{color=yellow|Anastasia: — Yes, master. I will do it myself.}

Anastasia begins to disrobe, unbuckling her knee-high boots and slipping them off. She sheds her blue cloak and lays it over an armchair. She begins to peel off her stockings but you stop her and gesture that she should remove the dress first. Anastasia struggles to unfasten the back of her dress and you raise an eyebrow at the delay.

{color=yellow|Anastasia: — I'm sorry, Master. I'm used to having Aire to help me.}

Smirking, you order her to turn around. Standing in her stockinged feet, she holds her long blonde hair up and you unclip the hooks holding her dress in place at the back. She loosens the girdle around her waist as you move back around in front of her and the dress begins to fall open at the top, her soft, heavy tits spilling out.""",
	#gets naked here
	AFTER_ELECTION_PRINCESS_17 = """Her face scarlet with shame, Anastasia wiggles her hips to slide the dress over them and it falls to the floor. Her large breasts hang, swaying as she frees her arms from the puffy blue sleeves. She slides the metal arm-guards over her wrists and drops them on the dress. You watch as she returns to her stockings, rolling them carefully down her sleek thighs to her toes. Finally, she slips off her silk panties, letting them fall around her ankles. 

Anastasia steps out of the panties and stands naked, her hands reflexively covering her pussy and tits.You order her to lift her hair off her shoulders with both hands as she did a moment ago, and though she hesitates, she complies. You take a moment to enjoy the sight of your naked, compliant princess and instruct her to turn around slowly so you can examine her whole body.

Her skin is smoother than the common girls, her hair more lustrous. Despite the hard time she must've had during all these years, she still seemingly led a fairly luxurious life.""",
	AFTER_ELECTION_PRINCESS_18 = """With Anastasia naked and obedient, you begin a more thorough inspection of your property. Your hands roam across her body, exploring her ripe breasts, slender belly, and soft round ass. She whimpers slightly as you press her thighs apart to reveal her pussy, but you pretend not to notice. Your fingers stroke her slit and then probe between her tidy labia to check her hymen. 

{color=yellow|Anastasia: — W-what are you doing? You shouldn't touch...!}

You ignore Anastasia's pleas as she has no right to protest, being your slave now. Neither is her weak body capable of resisting you. She sobs as your fingers roughly explore her tight virgin holes though she has no alternative in the end but to tolerate your intimate assault.""",
	AFTER_ELECTION_PRINCESS_19 = """You order the naked, weeping princess to lie on the bed and she obeys without a fight. You climb on top and seize her wrists, dragging them up over her head where you handcuff her to the headboard. New tears flow from Anastasia's eyes as you unbuckle your pants and your cock springs out. You rub your hard penis between her juicy tits and instruct her to spread her legs for you. 

She splays her legs wide, thighs trembling. You order her to beg for your cock, to beg for you to take her virginity. Her wide blue eyes are still wet with tears as she complies.

With a satisfied grunt you guide your cock to her virginal pussy, pressing it until you feel the resistance of her hymen. You look her in the eye and she bites her lip. One solid thrust, a short sharp cry of pain, and Anastasia is a maiden no longer. As you pound her tight cunt, a little blood smears around her clit.""",
	AFTER_ELECTION_PRINCESS_20 = """You fuck Anastasia for most of an hour, your thick cock railing her tight pussy again and again. After a while she cums, her unwilling orgasm making her whole body shudder. You keep fucking her through it, driving home the message that she will never be in charge of her own body again.

By the time your own orgasm shoots your cum deep inside her, Anastasia gives in moaning and squirming. Her pussy spasms around your spurting cock, and you hold the princess down on the bed as your cum pumps into her, her resistance totally broken.

As the princess is your property now you'll be looking forward to more nights like this one. """,
	AFTER_ELECTION_PRINCESS_MINDBREAK_0 = "After the feast you summon your mindbroken princess. Anastasia arrives and waits patiently for your attention with a vacant look in her eyes.",
	AFTER_ELECTION_PRINCESS_MINDBREAK_1 = """Seizing the princess by the wrist you lead her to your bedroom. Anastasia's face remains expressionless as you close the door and move her to the middle of the room. Standing before her, you lift the front of her dress and casually slip your hand into her silk panties. She doesn't react as you finger her virgin pussy but gives a yelp when you pinch her clit.

You withdraw your hand and grab her by the breasts, squeezing them roughly through the blue dress. A frown passes over her pretty features but otherwise she remains impassive. As you slap her once, hard, across the face her blue eyes begin to tear but she doesn't offer any resistance. """,
	AFTER_ELECTION_PRINCESS_MINDBREAK_2 = """Satisfied by Anastasia's total obedience, you drag her to your desk and bend her over. Lifting her dress and petticoats, you expose her shapely ass. You give her a firm smack and tug the silk panties down to her knees so you can inspect her pussy. Her thighs are slender, the skin creamy white, and they tremble slightly as you run your hands across her neat pussylips and firm round behind.

Not sure how well the princess will even understand your words, you tell her she has made a lot of trouble and you are going to enjoy punishing her. You pinch the soft flesh of her inner thigh cruelly, marking the pale skin red as she gives a soft cry of pain. You explain that she will be a slave for your cock, a plaything to be fucked and abused at your whim. You ask if she understands.""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_3 = """Bent over and pressed down on the table as your hand rudely explores between her legs, the princess replies in a flat voice devoid of emotion.

{color=yellow|Anastasia: — Yes, master.}

Surprised at Anastasia's level of comprehension you mutter your approval, unbuckling your belt to free your cock. You walk around the desk until you are in front of her and grabbing a fistful of her long blonde hair you pull her pretty face up to look at you. Her expression is still vacuous, as though mesmerized, as you hold your cock in front of her and tell her to suck on it. 

Anastasia nods obediently and wraps her full lips around the head of your penis, sucking greedily as you push her head down with your grip on her hair.""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_4 = """As the princess sucks you off, you keep a tight hold of her head and reach over the table to pull up her dress so you can spank her lily-white ass. Her yelps are muffled by the cock filling her throat, as she struggles to keep her feet on the floor. The sight of her smooth ass bouncing and twitching is delightful and you decide it's time to switch things up. 

You pull your cock out of Anastasia's mouth and walk quickly around the desk. Her panties have slipped down to her ankles and you kick them away. Flipping her petticoats back up, you grab her slender waist and roughly spread her legs with your knee. Your penis is still slick with her saliva and you spit on her puckered sphincter as you line up your hips.""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_5 = """Using your finger, you massage your spit into her anus, probing the princess's tight ass as she groans in discomfort at the intrusion. Pulling Anastasia's hair towards you, you lift her upper body off the table so your erect penis presses into her asshole. She screams and shudders as you force yourself into her tight rectum, impaling her perfect ass with your cock. 

With her hair gathered into a ponytail clamped behind her head by your fist, you have no difficulty dominating the princess's nubile body. You brutally fuck her unused ass over the table, spanking her as she wails and cries. After a few minutes her wailing stops and you feel her sphincter relax as your cock rams home. """,
	AFTER_ELECTION_PRINCESS_MINDBREAK_6 = """You slide your penis slowly out of her ass and, using her hair, haul her away from the desk. Anastasia is still wearing her fine blue dress as you march her to the wall and shove her up against it. Your hands grab the top of the dress, at her cleavage, and you violently rip it open. Her pale breasts spill out of the torn corset as you yank the dress downwards. 

Anastasia shivers, her blue eyes gazing at you blankly as you wrench the dress apart at her hips and toss it to the floor. Grabbing her wrists in one hand you pin them above her head as your other hand grabs one of her tits. Squeezing her breast savagely you pull it up to your mouth and bite her nipple. She screams again as your teeth close on her delicate flesh.
 
With her tit held fast by your mouth, your free hand drops to the princess's virgin pussy, where you start rubbing her sensitive clit. She tries to press her legs together but you force them apart easily with your knee.""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_7 = """You feel Anastasia's virginal pussy start to grow slick under the relentless assault of your fingers. You release her bruised nipple from your mouth and look her in the eyes, which only show a glimpse of sentience. 

You push Anastasia to the floor and she spreads her legs wide for you. You mount her and thrust your cock inside her, breaching her hymen in a thin smear of blood and filling her pussy with your meat. She gasps at the loss of her virginity, but you pin her arms to the floor and pound her slim body into the wooden boards while her tits bounce around wildly.""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_8 = """It doesn't take you long, and as your hot cum fills her pussy, Anastasia moans faintly. You release her exhausted body and pull out, your cock trailing cum across her belly and breasts before you throw her out of your bedroom so you can rest. She stands silently outside your door, cum trickling down her legs, waiting patiently for your next instruction.""",


	##################################################New
	AIREAMELIAREPORT = "In the morning you receive a brief missive from Amelia stating that she learned the location of princess and inviting you to visit her.",
	AIREAMELIAMEETOPTION = "I got your message, you have new information?",
	AIREAMELIAMEET1 = "— Yes, I have a lead on the princess's location, and I'm willing to share provided you agree to do me a favor in the future. That's a nice trade since this could very well be the last hurdle on your path to becoming the next mayor. So, you scratch my back and I'll scratch yours?",
	AIREAMELIAMEET1_OPTION1 = "Sure, you've done a lot for me",
	AIREAMELIAMEET1_OPTION2 = "I can't agree to do you a favor without knowing what it is",
	AIREAMELIAMEET2 = "I'm pleased to hear that. According to the elf lass, Anastasia is hiding in the elven lands. You should meet their leader to find out more. If I'm not mistaken, this should be their high priestess. I hope to hear news of your success.",
	AIREAMELIAMEET2_1 = "I see. Well, I'll be waiting till you change your mind.",


	AMELIAFINDPRINCESSOPTION = "I've been wondering if you could give me any advice on how to find someone...",
	AMELIAFINDPRINCESS1_1 = """— You've been aiming to find our princess, I take it? I've heard you captured her little elven friend. It might be a good idea to try questioning her, if you haven't already.

— Alternatively, we might rely on our friends in the mage guild to find her if you can get a hold of some of her belongings. They have a trick to track down... those less willing to be found. You can check the last place she's been. If you find something useful there, bring it back to me.""",
	AMELIAFINDPRINCESS1_2 = """— You've been aiming to find our princess, I take it? Well, if you've given up on the imprisoned elf, I have an alternative suggestion.

— We can rely on our friends in the mage guild to find her if you can get a hold of some of her belongings. They have a trick to track down... those less willing to be found. You can check the last place she's been. If you find something useful there, bring it back to me.""",
	AMELIAFINDPRINCESS2 = "— You've been aiming to find our princess, I take it? There aren't a lot of leads at hand, are there? Well, for such cases we can utilize our friends in the mage guild, as long as you can provide them with something belonging to the one we seek. They have a trick to track down... those less willing to be found. You can check the last place she's been. If you find something useful there, bring it back to me. ",

	AMELIAFINDPRINCESSOPTION1 = "Thanks for the advice",
	AMELIAFINDPRINCESSOPTION2 = "I'll be back once I've found something",
	AMELIAFINDPRINCESSOPTION3 = "What exactly am I looking for?",
	AMELIAFINDPRINCESS2_1 = "— See you soon, dear.",
	AMELIAFINDPRINCESS2_2 = "— You're asking me? I can't do everything for you. You just need something of hers.. Don't sweat it, I'm sure you'll manage.",
	MATERIALPRINCESS_BRACELET = "Unusual Bracelet",
	MATERIALPRINCESS_BRACELETDESCRIPT = """An unusual silver bracelet you've acquired at the rebels' hideout. On the inner side you can spot a small engraving: "To my beloved daughter". """,
	MATERIALDIVINE_SYMBOL = "Divine Symbol",
	MATERIALDIVINE_SYMBOLDESCRIPT = "A small coin shaped piece of metal, which can act as a medium for certain arts. Despite its simple look, it shows a considerable craftsmanship.",
	MATERIALBLESSED_DIVINE_SYMBOL = "Blessed Divine Symbol",
	MATERIALBLESSED_DIVINE_SYMBOLDESCRIPT = "A small coin shaped piece of metal giving off a faint light.",

	UNIQUECLASS = "Can't be acquired normally",

	ITEMANASTASIA_BRACELET = "Anastasia's Bracelet",
	ITEMANASTASIA_BRACELETDESCRIPT = "An expensive bracelet belonging to former princess Anastasia and was gifted by her parents. Understandably, she treats it with care. \n\n{color=yellow|Only equippable by Anastasia}",
	ITEMANASTASIA_BROKEN_BRACELET = "Anastasia's Bracelet",
	ITEMANASTASIA_BROKEN_BRACELETDESCRIPT = "An expensive bracelet belonging to former princess Anastasia and was gifted by her parents. Understandably, she treats it with care. \n\n{color=yellow|Only equippable by Anastasia}",

	ITEMDAISY_DRESS = "Daisy's Dress",
	ITEMDAISY_DRESSDESCRIPT = "A custom-tailored uniform designed specifically for a bunny girl in your possession. It is uncommonly durable and accentuates her stronger points.\n\n{color=yellow|Only equippable by Daisy} ",
	ITEMDAISY_DRESS_LEWD = "Daisy's Dress (Lewd)",
	ITEMDAISY_DRESS_LEWDDESCRIPT = "A custom-tailored uniform designed specifically for a bunny girl in your possession. Depsite it fairly normal appearance, it can be quickly switched to reveal her private parts, while also stimulating her body.\n\n{color=yellow|Only equippable by Daisy} ",
	
	
	
	
	ITEMCALI_HEIRLOOM = "Heirloom Sword",
	ITEMCALI_HEIRLOOMDESCRIPT = "A Heirloom Sword which belongs to Cali. According to her, it's rather useless but the fine smith work and mysterious aura suggests otherwise.\n\n{color=yellow|Only equippable by Cali} ",
	ITEMCALI_HEIRLOOM_ACTIVE = "Cali's Heirloom Sword",
	ITEMCALI_HEIRLOOM_ACTIVEDESCRIPT = "A Heirloom Sword which belongs to Cali. Due to certain events she managed to use it to its better potential.\n\n{color=yellow|Only equippable by Cali} ",

	ITEMCALI_COLLAR = "Cali's Collar",
	ITEMCALI_COLLARDESCRIPT = "A collar made specifically for your slave, Cali.\n\n{color=yellow|Only equippable by Cali} ",
	ITEMCALI_EXQUISITE_COLLAR = "Cali's Exquisite Collar",
	ITEMCALI_EXQUISITE_COLLARDESCRIPT = "A fancy collar made specifically for your slave, Cali.\n\n{color=yellow|Only equippable by Cali} ",
	
	ITEMCALI_COLLAR_ENCHANTED = "Cali's Enchanted Collar",
	ITEMCALI_COLLAR_ENCHANTEDDESCRIPT = "A collar made specifically for your slave, Cali. It was enchanted with a magic which will make her more likely to comply to your orders.\n\n{color=yellow|Only equippable by Cali}",
	
	
	ITEMCALI_COLLAR_ENCHANTED_2 = "Cali's Ex. Enchanted Collar",
	ITEMCALI_COLLAR_ENCHANTED_2DESCRIPT = "A fancy collar made specifically for your slave, Cali. It was enchanted with a magic which will make her more likely to comply to your orders.\n\n{color=yellow|Only equippable by Cali}",
	
	ITEMHOLY_SWORD = "Sword from the stone",
	ITEMHOLY_SWORDDESCRIPT = "A holy sword obtained from the stone. Required titanic strength to obtain.",
	
	SCENEWIP = "Sorry! This scene is currently WIP. ",

	AMELIASCENEOPTION = "I wonder if you could repay me for my work...",

	UNIQUE_CLASS = "Can't be learned normally",
	UNIQUE_FINAL_OPERATION_DUNGEON = "Rebel's Hideout",

	ZEPHYRA_EXTRA_GREET = "— You wanted to see me, [name]? You must have some questions, I suppose. Well, ask away.",
	ZEPHYRA_EXTRA_GREET2 = "— Hello, [master]. How can I serve you? You must want to ask me some questions?",
	ZEPHYRA_EXTRA_OPTION1 = "How do you like it here?",
	ZEPHYRA_EXTRA_REPLY1_1 = "— It's quite interesting, but I don't have any choice at this point now, do I? I'm not complaining though, since that's what I've agreed to. ",
	ZEPHYRA_EXTRA_REPLY1_2 = "— Not shabby at all. It could use a woman's touch though. Maybe add some flowers and ribbons, make it a bit more homey, you know. ",

	ZEPHYRA_EXTRA_OPTION2 = "Tell me more about...",
	ZEPHYRA_EXTRA_OPTION2_1 = "Alios",
	ZEPHYRA_EXTRA_REPLY2_1 = """— Alios is a deity of the winds. I'm not surprised you haven't heard of him, he does not seem very interested in being worshipped, so only a very few people bother with him.

— Me? Of course it's impossible for me to not worship him. Once you become a champion it's ingrained in you, it's a thing affecting your every step in some way. """,
	ZEPHYRA_EXTRA_OPTION2_1_1 = "You seem rather casual about it",
	ZEPHYRA_EXTRA_OPTION2_1_2 = "I'd hate to be in a such a position, I value my independence",
	ZEPHYRA_EXTRA_OPTION2_1_3 = "So you both are good-for-nothing loners",

	ZEPHYRA_EXTRA_REPLY2_1_1 = "— Hehe, I guess you just get used to it after some time. Alios wouldn't like me to feel special because of it.",
	ZEPHYRA_EXTRA_REPLY2_1_2 = "— Hmmm, that's too bad, even if Alios is a god of winds, freedom is only appealing when it outweighs the benefits gained through accepting being bound anyway. ",
	ZEPHYRA_EXTRA_REPLY2_1_3 = "— Hey, not true, I can also draw quite well! I mean, we aren't as fancy as Celena or Freya, but you take what you can get. ",
	ZEPHYRA_EXTRA_OPTION2_2 = "Your Past",
	ZEPHYRA_EXTRA_REPLY2_2 = """— What I was doing prior to becoming a champion? To tell you the truth, I don't remember. One day I was up in the middle of a forest, at that moment I was already a champion. Mysterious right?

— For some reason, I've never been that interested in what came before that, so there it is. """,

	ZEPHYRA_EXTRA_OPTION2_3 = "Princess",
	ZEPHYRA_EXTRA_REPLY2_3 = """— So you are hunting that princess to stop the rebellion? Huh, it must be nice to be a princess, I wish I could be one, then I could live a rich boring life and marry a prince. Isn't that like every girl's dream?""",
	ZEPHYRA_EXTRA_OPTION3 = "So what is your plan exactly?",
	ZEPHYRA_EXTRA_REPLY3 = """— You should continue with your business, and don't worry about me. Sorry I can't point you in the right direction, I don't really have one either. Once the situation presents itself we'll probably recognize it.

— Oh and I'm afraid I won't be able to perform another barrier trick for a while. You don't get to use miracles casually. That does make our meeting fateful though, right? """,

	KURDAN_EXTRA_GREET = "— Greetings, [name]. Do you have some questions for me?",
	KURDAN_EXTRA_OPTION1 = "How do you like it here",
	KURDAN_EXTRA_REPLY1 = "— You have quite a home. I must admit, it's not like in my homeland, but I did agree to this, didn't I? Well, there's some good in not having to worry about where to sleep and what to eat.",
	KURDAN_EXTRA_OPTION2 = "About magic",
	KURDAN_EXTRA_REPLY2 = "— I've been studying magic since I was a juvenile. My father was an experienced practitioner, so I guess it runs in the family. Some see it as a tool, just a means to an end, but I'm a lot more curious about the underlying mechanics of how it operates and what role it has in the world. I still have much to learn, though. ",
	KURDAN_EXTRA_OPTION3 = "About orcs",
	KURDAN_EXTRA_REPLY3 = "— Those who united my homelands decided to outlaw the practice of magic altogether. They are in a difficult position today after being ruled for so long with an iron fist by the cult of Thoth. Now the cult is persecuted, and we... they have replaced magic with technology as the foundation of their power. I think it's unavoidable that you will encounter them some day.",

	AMELIA_BONUS_QUESTION = "— [name], I have a question for you and please answer honestly. Who would you find more attractive between me and the princess? She seems only slightly younger than me and I can't deny her beauty, that alone must make her quite appealing.",
	AMELIA_BONUS_QUESTION_OPTION1 = "Princess",
	AMELIA_BONUS_QUESTION_OPTION2 = "Amelia",
	AMELIA_BONUS_QUESTION_OPTION3 = "This is a tough choice...",
	AMELIA_BONUS_QUESTION_OPTION4 = "I'm actually into men",

	AMELIA_BONUS_QUESTION_REPLY1 = """— A-ha, I see. I can't really compete with a genuine ex-princess, can I?

— Just take care not to fall for her, you won't be able to switch sides and turn on us. """,
	AMELIA_BONUS_QUESTION_REPLY2 = """— Oh my, aren't you a flatterer? You would really prefer this mutt cat to royal blood? How silly. To tell you the truth, for most of my life I was just another servant. I expect I have been one since birth. And now I don't even have a proper Master. Would you be up to the challenge?.. I'm just kidding. But be sure I appreciate your company.""",
	AMELIA_BONUS_QUESTION_REPLY3 = "— He-he, is it so? Fine. Next time you can just lie to earn some extra favor points, but I wouldn't advise getting your hopes up about her, she'll always be a liability to us. ",
	AMELIA_BONUS_QUESTION_REPLY4 = "— Oh, is that so? That's quite convenient. I guess we won't have to worry about the influence of her charms on you.",
	AMELIA_BONUS_QUESTION_REPLYALL = """

— Well, I will not hold you any longer, good luck with your mission. """,



	# DAISY QUESTLINE
	DAISY_RECRUITMENT_START = """As you bring Daisy to your mansion she looks at it in awe. It seems she didn't actually expect you to be a land owner. As soon as you make it inside she gives you a deep bow.

— Uhm, thank you, [master]. I-I will do my best to serve you! """,
	DAISY_RECRUITMENT_OPTION_1 = "You don't have to be so formal",
	DAISY_RECRUITMENT_OPTION_2 = "I'll not expect less from you",
	DAISY_RECRUITMENT_OPTION_3 = "I'm sure you will *Fondle her butt*",
	DAISY_RECRUITMENT_REPLY_1 = "Daisy seems to brighten up a bit at your words. It seems she's happy to have a gentle master.",
	DAISY_RECRUITMENT_REPLY_2 = "Daisy bows again and proceeds to her newly acquired duties.",
	DAISY_RECRUITMENT_REPLY_3 = "Daisy's cheeks turn red as she feels your hand on her butt. She's clearly uncomfortable with your move, but does not dare to protest. After a few moments you let her proceed to her duty.",


	DAISY_CLOTHES_START = """During the morning you are met by Daisy, the recently acquired bunny girl who now belongs to you. It seems she's eager to tell you something.

— Good morning, [master]. I wanted to express my gratitude for your kindness. You've brought me to your home and treated me kindly all this time, but...

You see Daisy is very hesitant to state her request. """,
	DAISY_CLOTHES_OPTION_1_1 = "What do you want?",
	DAISY_CLOTHES_OPTION_1_2 = "Just say it",
	DAISY_CLOTHES_OPTION_1_3 = "Has the cat got your tongue?",
	DAISY_CLOTHES_REPLY_1 = """— I-I'm sorry, but I feel that I don't look good enough for your household. I only wear these rags and I might make your estate look worse...""",
	DAISY_CLOTHES_OPTION_2_1 = "I don't really care",
	DAISY_CLOTHES_OPTION_2_2 = "Fair enough, you do need better clothes",
	DAISY_CLOTHES_OPTION_2_3 = "Aren't you a bit too demanding for a slave?",
	DAISY_CLOTHES_REPLY_2_1 = """— Ah, well, then, as long as [master] is ok with it, I won't mind either...

As she leaves the room you give a second thought and decide if it might be a decent idea to get her new clothes at some point...""",
	DAISY_CLOTHES_OPTION_2_1_1 = "She's a hard worker and I do care for her after all",
	DAISY_CLOTHES_OPTION_2_1_2 = "She's not worth the effort",
	DAISY_CLOTHES_REPLY_2_1_1 = "After all, even if you said you don't mind, it's not a bad idea to get her new clothes. You make a note to get a new dress for Daisy. You could go meet Sigmund for high quality clothes, or perhaps Amelia could offer something more... extravagant.",
	DAISY_CLOTHES_REPLY_2_1_2 = "You decide you don't want to put any more money into her. You might get rid of her soon, so there's no point in making any additional investments.",
	DAISY_CLOTHES_REPLY_2_2 = """— I-I'm very grateful to you for this, [master]! Please, don't let this bother you more than necessary.

Daisy bows to you with all the respect she's able to demonstrate. You make a note on getting a new dress for Daisy. You could go meet Sigmund for high quality clothes, or perhaps Amelia could offer something more... extravagant. """,
	DAISY_CLOTHES_REPLY_2_3 = "— I-I'm very sorry, [master]! I just thought that you would also prefer me to look less messy.",

	DAISY_CLOTHES_SIGMUND_OPTION_1 = "I'm looking for a custom-made dress",
	DAISY_CLOTHES_SIGMUND_REPLY_1 = """You explain to Sigmund that one of your slaves needs a change of clothes.

— Aye, we make work clothes, but from what ya described I think servants could suit ya needs betta. We don't really do girly stuff.""",
	DAISY_CLOTHES_SIGMUND_OPTION_2 = "Thanks for the tip",

	DAISY_CLOTHES_AMELIA_OPTION_1 = "I'm looking for a custom-made dress",
	DAISY_CLOTHES_AMELIA_REPLY_1 = """You explain to Amelia that one of your slaves needs a change of clothes.

— Why, yes, proper servants' attire is one of our specialties. You know, the right clothes make a big difference even for less ideal bodies, naturally we have tailors who can adjust for any required body type. But what are you looking for, anyway?""",
	DAISY_CLOTHES_AMELIA_OPTION_2_1 = "I want a normal servant dress",
	DAISY_CLOTHES_AMELIA_OPTION_2_2 = "I want something lewder",
	DAISY_CLOTHES_AMELIA_OPTION_2_3 = "I've changed my mind",
	DAISY_CLOTHES_AMELIA_REPLY_2_1 = """— Fair enough, we can tailor something fitting for a well-to-do land owner's servant. It will be durable and resilient to wash. We'll also provide a spare in case of any accidents. This will cost you 150 gold. """,
	DAISY_CLOTHES_AMELIA_OPTION_2_1_1 = "Deal (150 gold)",
	DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE = "Refuse",
	DAISY_CLOTHES_AMELIA_REPLY_2_2 = """— Then you've come to the right place. We can make a servant dress which will appear normal, but will allow easy access to the servant's more private areas. Moreover, the fabric will subtly stimulating the servant's erogenous zones, so they will become and remain aroused while at work. This would be more to your liking? I'll only ask you 250 gold for it.""",
	DAISY_CLOTHES_AMELIA_OPTION_2_2_1 = "Deal (250 gold)",
	DAISY_CLOTHES_AMELIA_REPLY_3_150 = "You pass 150 gold to Amelia and arrange Daisy's meeting with the tailor, after which you make your way out.",
	DAISY_CLOTHES_AMELIA_REPLY_3_250 = "You pass 250 gold to Amelia and arrange Daisy's meeting with the tailor, after which you make your way out.",

	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0 = """Daisy stands before you in her new dress, shining with happiness. Her clothes can't be compared to her old rags and she has begun to feel even more dedicated to you.

— You've really done it, [master]. I never imagined this dress would be so nice.\n\n{color=green|Daisy:Growth Factor +1\nDaisy:Coward Trait Lost}""",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_1 = "I'm glad you like it",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2 = "I think you should express your gratitude in a way that fits your position (Sexuals Factor)",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_3 = "It's not for you, I can't have you walking around my mansion in rags",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_1 = "Daisy smiles at you and with your approval returns to her tasks. It seems her spirit have risen a bit.",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_3 = """— O-ofcourse, I understand. But still, thank you.

Daisy politely smiles at you and, with your approval, returns to her tasks.""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_0 = """Daisy blushes and her gaze drops to your groin, where a noticeable bulge is pressing against the front of your pants. 

{color=yellow|Daisy: — Oh! Of course, Master. How should I...}

She squirms as she stands before you in her smart new dress, her hands clasped in front of her waist and twisting nervously. You look at her steadily, expectantly. """,
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_BAD = """{color=red|Failure}

Daisy manages to overcome her shyness and gives you a little kiss then quickly turns away. You consider taking it further, but are too slow and she's already returned to her duties.""",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_1 = "What are we gonna do about this?",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_2 = "That's your fault, so it's only right for you to correct this",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_3 = "*Push her head down*",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_1 = """Without another word, Daisy sinks gracefully to her knees, her instinct to serve you taking over. She looks up at you with reverence, waiting with her mouth obediently open and hair held back, as you unbuckle your belt and pull your cock out. 

{color=yellow|Daisy: — Oh M-Master, you are too good to me, I don't deserve this.}

You lay your cock across her pretty face and she licks your balls at your instruction. You stroke her long fluffy ears gently as her quick tongue laps at the base of your shaft and she moans softly with desire.""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_2 = """Daisy's clear blue eyes gaze up at you longingly as she plants little licks and kisses along your cock. Her oral skills are amateurish at best, but her eagerness to please you makes up for her lack of technique. There will be plenty of time to teach her how to use her lips and tongue properly.

You look down at her and smile indulgently. Her left hand has dropped down between her thighs, and you can see how she touches her pussy when she thinks you won't notice. Her breath against your penis grows quicker as you nod your approval for her to continue.""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_3 = """Daisy's tongue licks all the way from the base of your shaft to the swollen head of your penis and she looks up at you adoringly as her lips part to take you into her grateful mouth. Her other hand comes up and begins to work your shaft as her head bobs up and down on your cock, never breaking eye contact with you as her tongue coils around your member. 

You run your hands around her head, through her soft brown hair, and up to her long bunny ears, where you take a firm hold. She squeaks softly at the sensation as you pull her head gently but firmly down onto your penis, pressing the head of your cock into her delicate throat.""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_4 = """As you push your cock deeper into her mouth, Daisy's eyes tear up involuntarily. She moans around the thick penis filling her throat as you use her ears to force yourself deeper into her. Still her gaze never leaves yours as you press her lips up against your pubic hair and cram your whole length into her face.

She shudders at the unexpected intrusion, but listens to your voice and keeps her throat relaxed to avoid gagging. Having opened the way, you fuck her mouth more vigorously, using her ears to keep her head in place as your cock rams into her narrow throat. Feeling your orgasm build, you draw your penis slowly out of her.""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_5 = """Daisy's voice sounds different and she is panting for breath after the stretching of her throat.

{color=yellow|Daisy: — D-Does this please you, Master?}

One of her hands returns to pump your shaft while the other rubs at her wet pussy excitedly. You release her ears and she goes to work eagerly sucking and licking your penis. 

Your orgasm arrives like a steam train, spraying thick strings of cum over Daisy's cheeks and brow, and into her waiting mouth. She sighs in pleasure as your seed coats her face and she licks the sticky mess from her lips to swallow it. She takes your cock in her mouth again and sucks gently until the cum is drained from your balls. 

You buckle your pants and look down at her cum-smeared face, her eyes still gazing obediently up at you. You order her to clean herself up and give her an hour of free time as a reward.""",


	DAISY_DRESS_ACQUIRED_LEWD_REPLY_0 = """Daisy stands before you in her new dress. While appearing normal at a glance, both of you know her dress is not as simple as it appears. Daisy nervously tries to avoid eye contact, but you can easily see her blush.

— T-thank you for the gift, [master]. I hope you like my new look.\n\n{color=green|Daisy:Growth Factor +1\nDaisy:Coward Trait Lost}""",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_1 = "You look great",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2 = "Not quite, but we can fix it (reveal her body)",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_1 = """Daisy lightly smiles at your words.""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2 = """You move closer to Daisy, and pull on the couple of strings, hidden in her dress folds. Her bra drops down, revealing her ample breasts. Her lower skirt drops as well, presenting obscene underwear not quite hiding her private parts from potential observers.

Daisy gasps in shame as you savor her beauty.

— T-this is embarrassing. I don't mind if it's [master] who is looking, but...""",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_1 = "Well, you better overcome your embarrassment and properly thank me",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_2 = "This emphasizes your body's natural beauty nicely",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_3 = "It's proper apparel for a whore like you",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_1 = """Daisy blushes and her gaze drops to your groin, where a noticeable bulge is pressing against the front of your pants. 

{color=yellow|Daisy: — Oh! M-Master... Can I bring you some refreshments?}

She squirms as she stands uncomfortably before you with her breasts exposed. Her hands are clasped in front of her waist, twisting nervously. Her nipples are hard and a wave of goosebumps runs over her naked tits. You look at her steadily, expectantly, then unbuckle your belt and pull your cock out. 

{color=yellow|Daisy: — That is... I don't... What are you doing?}""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_2 = """You beckon Daisy forward and place your hands on her slender shoulders. She is trembling faintly. With one hand you casually fondle her exposed tits, your finger and thumb pinching her nipples gently until they start to grow hard. She gasps softly and bites her lip. 

You explain that you went to a lot of expense for her dress, and she needs to show her gratitude. You take her wrists and guide her hands to your stiff cock. Weakly, she strokes your shaft, ashamed and unwilling. 

You order Daisy down to her knees and she complies reluctantly. Her sleek tits quiver in the cool air. She stares at the floor.""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_3 = """You order Daisy to look at you and her blue eyes turn to gaze up at you imploringly. 

{color=yellow|Daisy: — P-Please, master. Isn't there something else...}

Curtly, you order Daisy to open her mouth and after a moment of insubordinate hesitation she does. Her full lips form a perfect 'O' framing her small red tongue. Your cock twitches in anticipation and she flinches.

You explain to the kneeling, half-naked bunny girl how you are going to use her mouth until you cum. She cowers a little and looks away, while not daring to remove her hands from your cock.""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_4 = """You order Daisy to look at you again, and not to take her eyes from yours until she feels your cum on her skin. As she strokes your penis you step a little closer so your cock is pressing up against her pretty face. 

You instruct her to touch herself while she serves you. Without breaking eye contact, her hand slips between her thighs and she starts to massage her clit through the panties. 

Maneuvering your hips, you line your cock up with her mouth and prod it between her soft lips. You order her to use her tongue to pleasure you and she begins to lick small circles around the head of your penis inside her mouth. You can see the stress in her eyes as she sucks you off from her knees, working your shaft with her free hand.""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_5 = """You run your hands around Daisy's head, through her soft brown hair, and up to her long bunny ears, where you take a firm hold. She squeals in protest as you pull her head firmly down onto your penis, pressing the head of your cock into her delicate throat.

As you push your cock all the way into her mouth, Daisy's eyes tear up. She moans pitifully around the thick penis filling her throat while you use her ears as leverage to force yourself deeper. You press her lips up against your pubic hair and cram your whole length into her face.

Daisy shudders at the unwanted intrusion, and gags until you tell her to relax her throat. Having prepared the way, you fuck her mouth more vigorously, using your grip on both ears to keep her head still as your cock rams into her narrow throat. Each time it slides out, her lips suck tight around your shaft before you shove it back in and she has to swallow your member again.""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_6 = """After several minutes of throat-fucking you feel your orgasm building, and draw your penis slowly out of her. You order the kneeling Daisy to beg for your cum. Her voice sounds different after the stretching of her throat and she is panting for breath.

{color=yellow|Daisy: — M-master... Will you cum on me? Please?}

One hand is pumping your shaft while the other rubs her wet panties. You release her ears and let her suck on the head of your penis while she jerks you off. 

Your orgasm hits, spraying thick strings of cum over Daisy's cheeks and brow and into her open mouth. She sighs as your seed coats her face and tongue. At your order, she takes your cock in her mouth again and sucks gently until the cum is drained from your balls. 

You buckle your pants and look down at her cum-smeared face, her eyes still gazing obediently up at you. You tell her to clean herself up and give her an hour of free time as a reward.""",
	
	DAISY_TRAINING_REPLY_0 = """While you were holding a small meeting with a couple other land owners, you noticed that Daisy, although pretty and catching a lot of attention, didn't quite present herself in a manner befitting a trained servant. She messed up a guest's order and offered a stuttering apology. Perhaps, it might be a good idea to put her through proper training. """,
	DAISY_TRAINING_OPTION_1 = "I want to have my servant trained...",
	DAISY_TRAINING_REPLY_1 = """You explain to Amelia how you think Daisy could benefit from training to become more professional.

— Ah, yes, your timid bunny girl. I remember her, she's really suited to being your servant, isn't she? Of course we have training which would improve her performance, depending on what you'd like.""",
	DAISY_TRAINING_OPTION_2_1 = "I want her to be trained normally (200 gold)",
	DAISY_TRAINING_OPTION_2_2 = "What other options are there?",
	DAISY_TRAINING_OPTION_2_3 = "There's something else?",
	DAISY_TRAINING_OPTION_2_4 = "I want her to be trained normally and sexually (300 gold)",
	DAISY_TRAINING_OPTION_2_5 = "I want to turn her into a fucktoy (400 gold)",
	DAISY_TRAINING_OPTION_2_6 = "I'll return later",
	DAISY_TRAINING_REPLY_2_2 = "— Well, I'd expect you'd want her to be trained to clean, serve, know proper etiquette and so on. We can do that, or additionally teach her to serve with her body. Nothing too exotic, a bit of assertiveness, oral skills, being a bit more honest in her needs, you know. In case you are wondering, she would keep her chastity for the most part, as this training will not include any real intercourse. ",
	DAISY_TRAINING_REPLY_2_3 = "— He-he, since you asked, if you think she'd be better suited for something completely.... different, we can train her especially to be a plaything. She'd be able to serve many men at once, perform degrading actions and enjoy herself while at it. That's a bit more difficult, but I'm sure she's more than predisposed to it. She would be constantly used by other people during the training, I'm sure you understand.",
	DAISY_TRAINING_REPLY_2_1 = """— A splendid choice. Glad to do business with you, [name]. I vow you'll be happy with the results.

You arrange a time for Daisy's training and leave. """,
	DAISY_TRAINING_REPLY_2_4 = """— A splendid choice. Glad to do business with you, [name]. I vow you'll be happy with the results.

You fill out a small form denoting which actions should be excluded from her training and set up a time for Daisy to attend.""",
	DAISY_TRAINING_REPLY_2_5 = """— A splendid choice. Glad to do business with you, [name]. I vow you'll be happy with the results.

You fill out a small form denoting which actions should be excluded from her training and set up a time for Daisy to attend.""",
	DAISY_TRAINING_INTERMISSION_1 = """The room is decorated with expensive furniture, its walls hung with exquisitely designed drapes. A lantern burns in each corner, shedding bright light throughout the space. In the center of the room, Daisy hangs suspended by fine silk ropes tied around her naked body. Her arms and legs are spread out and secured by ropes that run to the upper corners of the room. 

Daisy's blindfold is wet with tears that have soaked through it, and her mouth is filled with a fat cock around which she moans as she gasps for breath. Unseen men walk around her, inspecting and groping her exposed tits and ass. One pokes a finger into her pussy to check how wet she is.""",
	DAISY_TRAINING_INTERMISSION_2 = """For the first few days, Daisy couldn't understand why her master had done this to her. Hadn't she been willing enough? Hadn't she tried her best to please him? She had swallowed his cum like an obedient slave and been grateful for it. How could he have sent her to this awful place?

She had been here a week now and such thoughts were long forgotten. This was what she deserved. This was all she deserved. She was three holes that begged to be filled with cock, and that was all she would ever be. She accepted it now, and did her best to adapt to her new role. She slurped eagerly at the cock in her mouth, desperate to please.""",
	DAISY_TRAINING_INTERMISSION_3 = """The man with his cock in her mouth held Daisy by the ears as he fucked her throat. Another man was lubricating her asshole, and she knew what that meant.

{color=yellow|Trainer 1: — Well, this one didn't take long. Loves the cock. She's stopped whining already.}

{color=yellow|Trainer 2: — Oh yeah, she's a natural submissive. Practically begging to be dominated. Look how wet her cunt is.}

Daisy squirms with pleasure as the man digs two fingers into her slick pussy and draws them out for a moment before going back to lubing her ass.

{color=yellow|Trainer 1: — Damn. Well she is a half-bunny. I'd buy one of these for myself if they weren't such dumb useless sluts otherwise. Isn't that right, slut? You're a dumb cunt whose only value is your holes?}

Daisy tries to nod and agree but it's hard with the huge cock shoved into her mouth and the man's tight grip on her sensitive ears. The man behind her laughs. 

{color=yellow|Trainer 2: — Aww, look at that! She knows it. Good bunny!}""",
	DAISY_TRAINING_INTERMISSION_4 = """The man behind her pushes first one, then two, then three fingers into Daisy's slippery ass, working them in and out to stretch her sphincter. Her hips twitch in arousal as he fingers her.

{color=yellow|Trainer 2: — Tight little holes on this one, be sorry to see her go home.}

{color=yellow|Trainer 1: — Yeah, she's a bit special ain't she? I mean, she's basically trained and ready to go now. Lucky us, we got her for another week.}

{color=yellow|Trainer 2: — Oh yeah, plenty of time to enjoy this premium piece of ass, make sure she's learned her lessons well.}

With that the man behind her pulls his fingers out, grabs hold of her butt-cheeks, and rams his big cock into Daisy's responsive and well-trained ass. She can feel his fingernails digging into the soft skin of her behind as he ruts on her. 

The man in front is nearing his orgasm, she guesses, because he releases her ears and reaches down to grip her by the breasts while his cock slams into her throat with increasing urgency.""",
	DAISY_TRAINING_INTERMISSION_5 = """The cock in her ass was hurting her, too big and drilling into her too hard and fast. Daisy had learned that the best way to please was to take the pain eagerly and make her trainers cum quickly to get it over with. She flexes her sphincter, squeezing her asshole around the big cock impaling her and is rewarded when the man spanks her exposed ass in delight.

At the same time, the man with his cock in her mouth starts to cum. Hot sticky mess sprays into her throat and she has to gulp it down quickly to avoid choking and spluttering, which could earn her a slap, or a whipping, depending on the trainer. She hears him groan with pleasure as her skilled lips suck every drop of cum from his cock while he squeezes and twists her hanging tits like the udders of a taurus girl.""",
	DAISY_TRAINING_INTERMISSION_6 = """The big cock behind her continues to pound into her tender asshole mercilessly and Daisy concentrates on using her muscle control to pleasure him. Her pussy feels hot and swollen with her own arousal and she can feel tears on her face again from the violent assault on her ass. 

The man behind slides his hand underneath her and slips his thumb into the bunny-girl's soaking pussy. He holds her there like a bowling ball as his cock thrusts forcefully into her ass again and again. The pressure on her clit is enough to make her cum almost immediately, which she hopes is what he wanted, and she arches her back, bucking wildly on the cock buried inside her. """,
	DAISY_TRAINING_INTERMISSION_7 = """Daisy feels the man behind her go tense and a moment later he gives one last powerful thrust and his seed floods her asshole. The man grunts and tugs his cock out of her ass, laying it between her butt-cheeks so she can feel cum spurting on to her back. 

{color=yellow|Trainer 2: — Fuck! That's a horny bunny-slut! Her ass almost broke my cock off!}

{color=yellow|Trainer 1: — Haha, that'd be you out of a job, mate. Ah well, good progress anyway. Recommend you take her hungry little mouth next time.} 

{color=yellow|Trainer 2: — Maybe I will. Fuck. What's your plans now? Want to get an ale?}

{color=yellow|Trainer 1: — Yeah, sounds good. Don't worry slut, we'll send the next shift in.}

Daisy hears the two men leave the room, laughing. She feels the cum trickling slowly from her abused mouth and ass onto the floor as another two men come into the room and begin unbuckling their belts.""",
	
	TRAINING_COMPLETE_SERVE_REPLY_0 = """You meet Daisy as she's brought back to you. You notice that her demeanor is now more composed and mature. Her usual clumsiness is nearly unnoticeable.

— [Master], thank you for investing in me, during this time I've learned a lot and I hope to provide you with better service.""",
	TRAINING_COMPLETE_SERVE_OPTION_1_1 = "I'm glad you're back",
	TRAINING_COMPLETE_SERVE_OPTION_1_2 = "Finally, get back to work",
	TRAINING_COMPLETE_SERVE_REPLY_1_1 = "— Thank you. I'm fine, we were treated nicely there... I'm glad I was able to learn how to hold myself better for your sake, [Master].",
	TRAINING_COMPLETE_SERVE_REPLY_1_2 = """— R-right away, [master]...

Somewhat disappointed by your response, Daisy returns to her duty.""",

	TRAINING_COMPLETE_SEX_REPLY_0 = """You meet Daisy as she's brought back to you. You notice that her demeanor is now more composed and mature. Her usual clumsiness is nearly unnoticeable.

— [Master], thank you for investing in me, during this time I've learned a lot and I hope to provide you with better service.""",
	TRAINING_COMPLETE_SEX_OPTION_1_1 = "Why don't you demonstrate it?",
	TRAINING_COMPLETE_SEX_OPTION_1_2 = "I'm glad you liked it",
	TRAINING_COMPLETE_SEX_REPLY_1_1 = """Daisy noticeably blushes but nods in response to your request and drops to her knees before you. As she gently retrieves your cock from your pants, her usual nervousness is barely apparent. Only a little touching is enough to make you hard.

— I'm glad to be able to repay your kindness, [Master].

Daisy takes your cock into her mouth, carefully coiling her tongue around it. As she diligently works on your cock, she closes her eyes and does not forget to also caress your balls. As she moans softly, her proficiency quickly brings you to orgasm, and she makes sure none of your seed escapes her mouth. As she obediently gulps down your seed, she opens her eyes and looks back at you.

— Did I do well, [Master]?

Her eyes show sincere concern. """,
	TRAINING_COMPLETE_SEX_OPTION_1_1_1 = "That felt great",
	TRAINING_COMPLETE_SEX_OPTION_1_1_2 = "You were also trained to swallow?",
	TRAINING_COMPLETE_SEX_OPTION_1_1_3 = "I guess even you're good for something",
	TRAINING_COMPLETE_SEX_REPLY_1_1_1 = """Daisy shines with a big smile in response to your praise.

— Thank you, [Master]. I will be able to serve you even better now.""",
	TRAINING_COMPLETE_SEX_REPLY_1_1_2 = """— Uhm, yes. We were using pumps at the training with a rice jelly and a helper in case we choked on it... It was actually kinda fun. """,
	TRAINING_COMPLETE_SEX_REPLY_1_1_3 = """— Thank you, [Master]. I will be able to serve you even better now.""",
	TRAINING_COMPLETE_SEX_REPLY_1_1_all = """

You send Daisy off, proud of your selection for her training.""",
	TRAINING_COMPLETE_SEX_REPLY_1_2_1 = "— Uhm... [Master], I believe I should repay your kindness now, if you don't mind.",
	TRAINING_COMPLETE_SEX_OPTION_1_2_1 = "Very well, go ahead.",
	TRAINING_COMPLETE_SEX_OPTION_1_2_2 = "Sorry, I'm not in the mood",
	TRAINING_COMPLETE_SEX_REPLY_1_2_2 = """— Ah, is that so? As you wish, [master].

Daisy looks somewhat disappointed, but still respectfully bows to you before retreating from sight.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_0 = """You meet Daisy as she's brought back to you. Despite your expectations she does not show any signs of a grudge and her demeanor has improved.

— Hello, [Master]. I'm ready to be of your service. Any service you wish for.

You pause for a moment, considering if you want to test her training out right away or not. """,
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1 = "Let's go for a walk",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_2 = "I don't have any orders for now",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1 = """Looking Daisy up and down you abruptly order her to strip. She obeys instantly, and is fully naked in seconds as she shrugs off her clothes. You place a collar around her neck and attach a leash to it. Daisy waits demurely and obediently while you prepare her for public exhibition. 

As you bring her outside you notice that she shows no shame at her public nudity. You lead Daisy by the leash through the town and she obediently follows by your side. A few passers-by gawp and point at the gorgeous naked bunny-girl being led like an animal, which makes Daisy smile and blush, her nipples hardening in arousal. You ponder how to put her to use.""",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_1 = "Fuck her",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_2 = "Find a group of willing strangers",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_3 = "A stray dog",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_4 = "Return",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_1 = """You lead Daisy by the leash to one of the classier suburbs of Aliron. Large houses stand around leafy parks and many attractive servants can be seen on the streets running errands for their masters. In the parks, the wealthy elites of Aliron take picnics and play sports. Daisy follows you obediently to a small hill in the center of one of these parks. 

Once you are sure you have attracted some public attention, and the envious glances of numerous minor nobles, you push Daisy to her knees. She complies without hesitation as you unbuckle your belt and pull your cock out. In the distance you can hear people cheering, or exclaiming in surprise and outrage.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_2 = """Without further delay, you press Daisy down on to all fours and mount her, taking her from behind like an animal while you yank back on her leash. She makes no protest at all, spreading her hips to give your penis easier access to her pussy. As you rut on her, she moves her ass sensuously in unison with your thrusts.

{color=yellow|Daisy: — D-Does my pussy feel good, Master?}

With your cock thrust deep inside her, Daisy shakes her ass delicately from side to side to pleasure you. By now a small crowd has gathered at the foot of the hill, but she pays no attention to their catcalls. She is focused only on you, and your penis moving inside her. """,
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_3 = """You order Daisy to cum, and to make a performance out of it. A few moments later she does so, arching her back and moaning loudly as her body trembles with a powerful orgasm. Her expert pussy grips your cock as you pound her from behind and you feel your own orgasm approaching fast.

You pull out and stand, ordering Daisy to turn around. She kneels before you, gazing up at you with her mouth obediently open as she jerks you off to completion. Your cum splatters over her pretty face and onto her tongue. Taking you in her mouth she sucks the last few drops of cum from your penis before you buckle your pants again. """,
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_4 = """You take Daisy's chin in your hand and tilt her head up to look at you. She is a little breathless but she looks happy and proud with your cum coating her cheeks and brow. 
 
{color=yellow|Daisy: — Did I do good, Master? Daisy was a good girl?}

You jerk her leash and Daisy gets to her feet, face still glazed with your cum. You lead her down the hill and past the crowd that has gathered, who stand in stunned silence as you pass. You return to the mansion with your leashed and naked bunny-girl, her eyes bright and a sly smile on her face.""",
	
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_1 = """You lead Daisy naked and leashed through the streets of Aliron towards some of the Capital's poorer neighbourhoods. Peasants and servants walk the streets between the many beggars and the merchants selling basic goods. On a few corners slave prostitutes look jealously at Daisy, but none of the riff-raff dare to approach you.

Heading deeper into the slums of the city, you encounter a gang of half a dozen teenage boys and young men. They are mostly street thugs, tough lads who have learned to stick together to survive in a world that has little use for them. They leer and catcall at Daisy who ignores them, but you beckon them over.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_2 = """As the men approach, they are staring lecherously at Daisy's naked body but she makes no attempt to hide or cower from them, trusting completely in your power. You get their attention when you ask if they would like to spend some time fucking your toy. Their leader, a scarred young man a few years older than the others, grins and assures you they would.

You ask the leader what it would be worth to him and his friends to get their dicks wet in a high-class bunny-girl today. After a hurried conference they present you with a pouch of gold. It's not a lot of money, but that's hardly the point.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_3 = """You pass Daisy's leash to the scarred man and tell her to be an obedient slut for these young gentlemen. She nods and turns to the leader. Not believing their luck, the other men crowd around, rudely groping her breasts and ass. Calloused hands press roughly between her thighs to finger her pussy. They drag the bunny-girl to a small garden square nearby, and surround her. 

You watch as Daisy is pushed down on all fours, and her head is forced down by the ears on the leader's veiny cock. She eagerly sucks him into her mouth as another two guys put their cocks in her hands to be jerked off. A larger man moves behind her and mounts her doggy-style, fucking her sweet pussy with his outsized penis.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_4 = """Daisy is worked hard for over an hour by the gang, who each take their turn to fuck her ass, mouth, and pussy. Passers-by stop to watch the free show and cheer on the young lads. By the end, Daisy's whole body is coated in a layer of sticky cum and her holes are red and sore. 

The group of men are exhausted, drained of their lust, and you move over to collect your slave before things can turn nasty. You order the trembling Daisy to show some gratitude to the young men for fucking her like the dumb slut she is. She stands unsteadily and curtseys as cum runs down her thighs.

{color=yellow|Daisy: — Thank you all for fucking my dirty holes raw. It was my pleasure to be used as your cum-slut.}

The young men only wave, laughing. Daisy turns to you for approval and you nod. You jerk her leash and lead her limping back through the busy streets to the mansion where you order her to wash before resuming her duties.""",
	
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_1 = """You lead Daisy naked and leashed towards the outskirts of Aliron, where the city streets meet the surrounding countryside. Few people are on the streets this far from the center of town, just the occasional farmer or guard patrol watching for escaped slaves. 

As you walk along quiet tree-lined streets, Daisy is quiet. She only speaks when spoken to but her body betrays her continuous sexual arousal. There is something almost animalistic about her behaviour and that gives you an idea.

You see a large stray hound that is rooting among the bushes for something to eat. After you throw him some food, he approaches you warily. Daisy watches you, uncertainty on her face, so you snap her leash and order her closer.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_2 = """The stray dog sniffs at her naked pussy and her ass as you smile at her discomfort. Daisy frowns slightly as you order to get down on her hands and knees and hoist her ass in the air. At your instruction she begins to shake and wiggle her rear end enticingly at the dog, but her face cannot entirely hide her nervousness. 

The dog sniffs around Daisy curiously and then evidently decides this is too good an opportunity to pass up. The hound mounts her forcefully, its erect knotted penis plunging into the bunny-girl's trained pussy. Daisy yelps in surprise and pain at a sensation that her extensive training had not prepared her for.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_3 = """As the dog humps Daisy's obedient pussy, the surprise fades from her face and her instincts and training take over. She squirms and whines, pushing her ass backwards rhythmically into the hound's frantic thrusts. The dog's forepaws scrabble for purchase on her back as he ruts on her with animal ferocity, his tongue lolling out.

The dog yowls suddenly and Daisy wails, the tears rolling from her eyes down her scarlet cheeks as the dog climaxes, filling her abused pussy with its seed. The hound's penis is trapped inside Daisy for several long minutes as she weeps in shame, until its knot deflates and it slips out. """,
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_4 = """The dog sniffs at Daisy a few more times and licks at the tears streaming down her face before you chase it off. Still on her hands and knees, Daisy is sobbing at the humiliation you have forced on her. She looks up at you with fear and sorrow in her eyes as the hound's dirty seed trickles down her thighs..

{color=yellow|Daisy: — Th-thank you, Master. I deserved this.}

You order Daisy to masturbate and with one hand on her bruised and oozing pussy she is soon gasping between sobs as she brings herself to a tearful orgasm. With a jerk of the leash you force Daisy to her feet and parade the crying, violated bunny-girl back through town to the mansion.""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_4 = """You decide it's not the right time and return to the mansion.""",

	DAISY_ADMIRER_MESSAGE = """In the morning you receive a letter from a person you haven't met previously. After reading through it you discover that a landowner named Ramont is requesting that you sell Daisy to him. Apparently, he finds her to be a valuable sub breed that he wishes to experiment on.

He offers a generous sum of 2.500 gold which easily covers your expenses to date for her training and labor. Since Daisy is your property you wonder if you favor her over this offer.""",
	DAISY_ADMIRER_MESSAGE_OPTION_1_1 = "Sell her",
	DAISY_ADMIRER_MESSAGE_OPTION_1_2 = "Give away",
	DAISY_ADMIRER_MESSAGE_OPTION_1_3 = "Refuse",
	DAISY_ADMIRER_MESSAGE_REPLY_1_1 = "You decide that, after all, the money will be more useful than she is. You summon Daisy and inform her of your decision.",
	DAISY_ADMIRER_MESSAGE_REPLY_1_1_1 = """— I-I see... I understand. Thank you, for taking care of me, [master].

You feel slightly down about dealing with her in this way, but you are sure the gold will fix that.""",
	DAISY_ADMIRER_MESSAGE_REPLY_1_2 = "You decide that you have no use for Daisy and don't really care about the money. You give her away, waiving the offered payment, much to Ramont's joy.",
	DAISY_ADMIRER_MESSAGE_REPLY_1_2_1 = """— I-I see... I understand. Thank you, for taking care of me, [master].

As Daisy leaves your care and you feel a bit sad.""",
	DAISY_ADMIRER_MESSAGE_REPLY_1_3 = "Surely the huge sum would cover Daisy's market price many times over, but for some reason you refuse this proposal on the spot. Perhaps, you've grown too attached to her.",

	DAISY_ADMIRER_FIRST_EVENT_REPLY_0 = """Today Daisy is serving you. As you observe her toiling about, it occurs to you how much more relaxed she is around you now. She notices your attention and turns to you.

— Am I doing something wrong, [Master]?""",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1 = "Not really",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_2 = "I was just thinking how much you've changed",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_3 = "You have a splendid ass",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2 = """— We have been together for a long time, haven't we, [Master]? I-I know I'm in no position to say this, but I've thought about you like a family I never really had since the day you saved me and took care of me. That must seem silly to you...""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_3 = """""", # Not implemented > You have a splendid ass
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_1 = "I admire your efforts",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_2 = "I've been thinking of you as part of my family as well",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_3 = "Indeed, you are a slave and better remember your place",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_1 = """Daisy smiles at hearing that before returning to her task. """,
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_2 = """— T-that's... That's embarrassing. Well, let's look after each other then, okay?

Daisy visibly blushes and looks away.""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_3 = """-R-right, I'm sorry, [Master].

Daisy looks away, but you notice how her mood notably darkens.""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_2 = """As Daisy cleans around the mansion, she stumbles into one of the decorative vases, causing it to fall and break. Perhaps it was caused by her exhaustion, yet she looks at you with fear filled eyes.

— I-I'm deeply sorry, [Master]!""",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_2_1 = """I'm not angry. You must be tired.""",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_2_2 = """\"Sorry\" is not going to save you here *Punish*""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_2_1 = """Daisy looks at you not fully sure if you mean it. It seems she was rather certain you would be angry, but your mercy appears to have improved her opinion of you.

— T-thank you, [Master]. I'll clean this up right away...""",

	DAISY_LOST_MESSAGE = """This evening you notice that your slave Daisy hasn't returned from her tasks as usual. You're not sure what, but something is definitely wrong. Daisy is gone and you should start searching for her as soon as possible. Perhaps, the Servants Guild might have ideas on how to find her.""",
	DAISY_LOST_AMELIA_OPTION_0 = "I've lost someone...",
	DAISY_LOST_AMELIA_REPLY_0 = """— That's a grim situation, we certainly condemn kidnapping, even when it happens to a slave. I remember the girl, you did send her for our training, right? There was a landowner who seemed rather interested in her and asked after her owner. His name was Ramont... not quite one of ours.""",
	DAISY_LOST_AMELIA_OPTION_1_1 = "I might have received a letter from him",
	DAISY_LOST_AMELIA_OPTION_1_2 = "How could you give him my information like that?",
	DAISY_LOST_AMELIA_REPLY_1_1 = """— He offered to purchase her from you? It seems he'd be our prime suspect then. He lives aways from town. You better be prepared before going to meet him.""",
	DAISY_LOST_AMELIA_REPLY_1_2 = """— Relax, a slave's owner is a matter of general record. I know how you feel right now, but trust me I'm on your side here. Anyway, it seems he'd be our prime suspect then. He lives aways from town. You better be prepared before going to meet him.""",

	DAISY_LOST_APPROACH_REPLY_0_1 = """As you approach the estate of the supposed kidnapper, you see a group of armed mercenaries who notice you and move in for a fight. """,
	DAISY_LOST_APPROACH_REPLY_0_2 = """After defeating the mercs, you see a man who must be Ramont himself coming out.

Ramont: — Stop this, there's no need for further violence.""",
	DAISY_LOST_APPROACH_OPTION_1_1 = "You have something of mine and I'm going to take her back.",
	DAISY_LOST_APPROACH_OPTION_1_2 = "Where's Daisy? What have you done to her?",
	DAISY_LOST_APPROACH_OPTION_1_3 = "Give my slave back right now.",
	DAISY_LOST_APPROACH_REPLY_1 = """Ramont: — Don't be so rash, Daisy is fine, but please listen to me. A few weeks ago I saw her attending Servants' classes by herself. She acted so gracious, so timid and dedicated. I couldn't help it, I fell in love.

Ramont: — I sent you that message about wanting her for experiments, but it was a lie to cover my true feelings. Regardless, you refused to give her away despite my willingness to pay. I couldn't hold back and now I've expressed my feelings to her and treat her with care.""",
	DAISY_LOST_APPROACH_REPLY_2 = """Ramont: — I know she still technically belongs to you, but I offer you a bet. I want to give her a chance to decide if she wants to be with me or with you, and if she chooses you out of her free will, I will give up on her. But if she chooses me, she will stay with me and I will treat her like no other.

The chances are, Daisy has tasted the good will of Ramont and the promise of a better life. Making her choose you over him is a risky decision...""",
	DAISY_LOST_APPROACH_OPTION_FIGHT = "Don't be ridiculous, she's my property and I'll take her by force if I must",
	DAISY_LOST_APPROACH_OPTION_3_2 = "Very well, let's see what she thinks",
	DAISY_LOST_APPROACH_OPTION_3_3 = "I can't oppose this dedication of yours, you can have her",
	DAISY_LOST_APPROACH_REPLY_FIGHT_1 = "Ramont: — So it comes to this... On guard!",
	DAISY_LOST_APPROACH_REPLY_FIGHT_2 = "After finally managing to knockout Ramont, you quickly rush through his mansion until finding Daisy behind one of the locked doors. You bash it in, and Daisy looks at you in awe.",
	DAISY_LOST_APPROACH_REPLY_FIGHT_3 = """— [Master]?! W-What are you doing here? You've come for me? I'm sorry I went missing, I didn't mean to...""",
	DAISY_LOST_APPROACH_OPTION_FIGHT_4_1 = "I've been worried senseless about you",
	DAISY_LOST_APPROACH_OPTION_FIGHT_4_2 = "It's all good, we can work this out with a bit of discipline later on",
	DAISY_LOST_APPROACH_OPTION_FIGHT_4_3 = "Don't give me excuses you worthless slut",
	DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_good = """— M-[Master] [name]... I love you! I've been so scared I wouldn't see you again.

Daisy rushes and hugs you with all her might. As you share a kiss her face brightens with the happiest smile you've ever seen on her.

As you are done here, you leave Ramont's mansion and return home.""",
	DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_bad = """— You were...? I'm sorry, this won't happen again.

Daisy looks troubled and unsure how to respond to your remark. Deciding there's no point staying there any longer you leave and return home.""",
	DAISY_LOST_APPROACH_REPLY_FIGHT_4_3 = """Hearing your insults Daisy visually shrinks and clutches at her ears in fear.

— I'm sorry, I'm so sorry, [Master], please don't be angry...

As you finish your outburst you grab Daisy and leave Ramont's estate, returning to the mansion.""",
	DAISY_LOST_APPROACH_REPLY_3_2 = """After a couple of minutes Daisy is brought to you and the situation is explained to her. She seems terribly puzzled and stands in silence, racking her brain to remember the last time she was required or allowed to stand up for herself much less make a meaningful decision concerning her future.""",
	DAISY_LOST_APPROACH_REPLY_3_2_good = """

Daisy: — [Master], for all you've done for me, I could never abandon you. I'm sorry, Sir Ramont, but I belong to my [Master], [name]. I can't return your feelings.

Ramont: — I see... I understand. It was a pleasure to spend at least a bit of time with you. [name], I truly envy you, but I wish you both happiness.

With that, Ramont turns and leaves.""",
	DAISY_LOST_APPROACH_REPLY_3_2_bad = """

Daisy: — I-I... want to thank you, [master], but I'd prefer to stay with Sir Ramont. I'm sorry...

It seems Daisy has chosen to leave you, perhaps you weren't very nice to her. Accepting your defeat, you leave the estate all alone.""",
	DAISY_LOST_APPROACH_REPLY_3_3_1 = """Initially Ramont does not seem like he can believe your words, but after you repeat it, he bows to you in respect. """,
	DAISY_LOST_APPROACH_REPLY_3_3_2 = """Daisy meets you for the last time. Despite her composed look she seems like she's ready to burst into tears at any time, either because she's happy or because you've given her up... Soon after you wish happiness to Ramont and leave his estate.""",
	DAISY_CONSENSUAL_1 = """Daisy stands waiting obediently in her maid outfit as you finish some paperwork. Rising, you spend a minute inspecting her, running your hands over her body and gently squeezing her breasts. You inquire whether she is happy to be back at your mansion.

{color=yellow|Daisy: — Y-yes, [Master]. I'm happy to be of use to you.}

You nod and lift the hem of the maid dress, then slowly peel her panties down over her thighs to let them fall around her ankles. Daisy's breath hitches as arousal stirs her and she steps daintily out of her discarded underwear.""",
	DAISY_CONSENSUAL_2 = """You continue your inspection, exposing her breasts and slipping a hand between her thighs to check her pussy. Her bare cunt is noticeably warm to the touch and as you press a finger into her slit, her slick pussy-lips part readily. Daisy gasps in pleasure as your finger probes deep into her hot little hole and you feel her trained internal muscles tighten.

{color=yellow|Daisy: — Oh! Oh, [Master]! Your fingers feel so good inside me... You are too kind to me, master...}

There are tears in her eyes as she trembles with need.""",
	DAISY_CONSENSUAL_3_SERVE = """{color=yellow|Daisy: — Of course, [Master].}
	
Daisy obediently lowers to pull her panties down to ease your access to her privates. Once she's done you authoritatively push her onto the table. 
	
You lift Daisy's dress up over the top of her stockings, exposing her bare rear. Daisy wiggles her ass enticingly, her soft butt-cheeks pressing against your hard cock. You draw your hips back and the head of your penis finds her pussy. She sighs deeply as you enter her, her vagina pulsing helplessly around your thick shaft.""",
	DAISY_CONSENSUAL_3 = """You lift Daisy's dress up over the top of her stockings, exposing her bare ass. She strokes your shaft lovingly, pressing the head of your cock between her quivering thighs as your fingers tease her hard nipples. 

Your hand circles Daisy's neck and pulls her head down to the desk. Her hands can't reach your penis anymore, so she uses them to spread the cheeks of her ass apart. With your grip on her throat you pull her head back up a little while keeping her belly pressed down on the table. Her wet pussy grinds against your penis as she moans in desire.

Daisy wiggles her ass enticingly, her soft butt-cheeks pressing against your hard cock. You draw your hips back and the head of your penis finds her pussy. Bent low over the desk, she sighs deeply as you enter her, her vagina pulsing helplessly around your thick shaft.""",
	DAISY_CONSENSUAL_4 = """You rail Daisy hard over the table, banging her hips against its wooden surface as your cock plunges into her wet and obedient pussy. She yelps in pleasure as you repeatedly drive your penis deep inside her, her rabbit-tail bobbing up and down in excitement while her nipples graze the tabletop.

{color=yellow|Daisy: — Aa-ah, [Master]... You are too rough!..}

Daisy's pussy clamps tightly around your cock as her whole body shudders in orgasm. You keep pounding her, your own orgasm approaching fast as her silky cunt spasms around your thrusting meat. You release her throat so you can grab her hips and fuck her harder.

Daisy looks back at you imploringly as you bury your cock in her up to the hilt. Her ass bucks against your hips, trying to take you deeper and you feel the head of your penis pressing on her womb.""",
	DAISY_CONSENSUAL_5 = """{color=yellow|Daisy: — [Master]!... I'm about to... I'm cumming!}

Your orgasm hits and you pump a load of thick semen deep into Daisy's compliant cunt. The inner muscles of her pussy clench around your cock as she rocks back into you, drawing every drop of sperm into her. She is breathless and flushed as she looks back at you.

Casually, you spank her a few times and pinch the springy flesh of her ass as it reddens. You slide your cock out of her hole and your cum begins to leak from her pussy, trickling slowly down her bare thighs and into her stockings.

{color=yellow|Daisy: — Thank you, [Master]... I love you.}""",


	
	DAISY_EXTRA_STRATUP = "— H-hello, [Master]. How can I serve you?",
	DAISY_EXTRA_OPTION_1_1 = "Why don't we have you use your dress' better form?",
	DAISY_EXTRA_OPTION_1_2 = "You can cover yourself ",
	DAISY_EXTRA_REPLY_1_1_NO = """— I-if you wish so, [master]. 

Daisy looks worried but does not dare to object to your request. With a simple move her uniform reveals her private parts to your delight.""",
	DAISY_EXTRA_REPLY_1_1_YES = """— Please, enjoy the sight of my body, [Master]. 

Daisy unabashedly obeys your request. With a simple move her uniform reveals her private parts to your delight.""",
	DAISY_EXTRA_REPLY_1_2_NO = """— Thank goodness...

Daisy looks relieved as she fixes her clothes to a more concealed shape. """,
	DAISY_EXTRA_REPLY_1_2_YES = """— As you wish, [Master]. 

Daisy nonchalantly fixes her dress and awaits your further orders.""",
	
	AMELIA_SILK_STARTUP = """— I've noticed you were doing quite a lot for us recently. But we are having a minor issue I'd be glad if you could help with. One of our wealthy customers has made a request for special costumes. 

— However, we lack the resources to produce those. If you could get us 50 pieces of Silk we'd be glad to purchase it for 2.000 gold and a spare costume. I'm sure it's no sweat for you.""",
	AMELIA_SILK_OPTION_START = "I've got the silk you need",
	AMELIA_SILK_REPLY_START = "— I knew I could rely on you, [name]. Here's the reward I've promised. You know, since you are so resourceful, I'd like to provide you with an additional reward for this. How does a special massage sounds to you?",
	AMELIA_SILK_OPTION_1_1 = "Sure, why not",
	AMELIA_SILK_OPTION_1_2 = "I think I gonna refuse",
	AMELIA_SILK_REPLY_1_2 = """Amelia looks somewhat disappointed at your response.

— That's too bad. Alright then, good luck with your day.""",
	AMELIA_SILK_REPLY_1_1_1 = """Amelia leads you to a private room in the Servants' Guild with a sly smile on her face. The room is softly lit with candles and a faint sweet fragrance hangs in the warm air. In the center stands a comfortable cushioned table.

{color=yellow|Amelia: — Hmmm, why don't you slip your shirt off and lay down? I'll prepare the oils.}

Amelia purrs softly as you strip the clothes from your upper body and get comfortable. 

{color=yellow|Amelia: — You know, I had thought about bringing my top student in for you, a talented young vixen with wonderfully skilled hands. But then I thought, where's the fun in that?}

She approaches the table, her tail swishing from side to side.""",
	AMELIA_SILK_REPLY_1_1_2 = """{color=yellow|Amelia: — Oh my, aren't you a handsome man? Look at these powerful muscles!}

Amelia's delicate fingers stroke softly from your neck to your waist, where they linger for a moment. She applies the citrus and coconut-scented oils to her hands and begins the massage. 

You feel your body relaxing as Amelia's hands trace slow firm caresses across your back. Her fingers feather the large muscles in your shoulders and down your sides. Her small fists drum gently, hitting your body in quick sequences of soft thumps that release tension you didn't know you were holding.""",
	AMELIA_SILK_REPLY_1_1_3 = """Amelia leans over you as she rubs the soothing oil deep into the skin of your back and down your arms. Her slim hips are near your face and as she stoops to apply pressure you feel her soft breasts graze your side. 

The massage continues for several minutes, the elegant catgirl's hands bringing you to a state of deep relaxation as her body brushes lightly across your own. Even in your tranquility, you can feel the pressure of your growing erection against the table. 

{color=yellow|Amelia: — Why don't you roll over, sir, and I can tend to your chest?} """,
	AMELIA_SILK_REPLY_1_1_4 = """You roll on to your back, your erection clearly visible through your pants. Amelia purrs softly as she leans over you, gently running her slippery hands from your hips to your shoulders, her large breasts momentarily squashing against your stiffening cock.

{color=yellow|Amelia: — Massage is such a wonderful technique for helping a person to relax and relieve their stress, but it would surely be a waste if that was all one used it for.}

Amelia's voice grows softer and silkier as she begins to touch you in a different way. A soft pressure here, a firm stroke there. As if enchanted by her caresses, you feel your arousal provoked into powerful lust. Amelia's hands run down your sides to your hips and over your bulging groin. She giggles seductively as she feels the hardness in your pants.

{color=yellow|Amelia: — Oh, I see you are enjoying this little treat. It is a great honor to be served by the guild leader herself, don't you know?}""",
	AMELIA_SILK_REPLY_1_1_5 = """You lift your hips and slide your pants down your legs to reveal your fully erect penis standing proud. Amelia purrs with undisguised pleasure.

{color=yellow|Amelia: — Oh, just as impressive as the rest of you! That's a fine and feisty manhood you have. It will be a pleasure to serve you, sir.}

Amelia slowly unbuttons the front of her satin shirt to bare her voluptuous breasts. She traces oily fingers in small circles around her hard nipples and gracefully arches her back as she leans down towards your cock. 

{color=yellow|Amelia: — If it pleases you, my lord?}

Without waiting for a reply Amelia cups her heavy tits in her hands and presses them together around the shaft of your cock. Moving from the hips, she squeezes her breasts together to massage your penis. Oil smears across her smooth skin as she bounces lightly up and down with your cock embraced by her cleavage.""",
	AMELIA_SILK_REPLY_1_1_6 = """Amelia tucks her chin down and begins to lick around the head of your penis as it slides between her breasts. With each bounce her tongue comes closer until your cock reaches her eager lips and she sucks it into her mouth. She sucks you expertly as she continues to massage your shaft with her tits.

Despite Amelia's elevated status as guild leader, you can feel her deep desire to serve a strong master as she delivers the most consummately skillful blowjob you have ever had. Her virtuoso lips and tongue tease your cock to a hardness you have never experienced before and your toes curl as your hips twitch upwards, trying to press deeper into her talented mouth. """,
	AMELIA_SILK_REPLY_1_1_7 = """Your imminent orgasm is building to a level that you have never imagined and you grip the sides of the table as Amelia slides your cock out of her mouth and looks you in the eye with the tip of her tongue curled against your throbbing shaft.

You can't hold any longer and with a grunt you ejaculate in a thick spray that rains down on Amelia's face and outstretched tongue. Your penis continues to spurt as she works your shaft and, as though in a trance, you can only watch as Amelia's tongue meticulously licks the sticky droplets from your aching cock.

{color=yellow|Amelia: — By the gods, that's a lot of cum. All over my face! Such a strong and distinct musk to it too. You found my massage pleasing then, [name]?}

You nod wordlessly, your wits far from your reach at this moment.""",
	AMELIA_SILK_REPLY_1_1_8 = """As you return to the reception desk of the Servants' Guild, Amelia's smile looks different — warmer, and more personal.

{color=yellow|Amelia: — Thank you for providing me with so much... silk. I hope that this experience will fortify our business relationship for the future? I certainly look forward to further private meetings.}""",
	
	AMELIA_SILK_OPTION_2_1 = "Your business acumen has blown me... away",
	AMELIA_SILK_OPTION_2_2 = "It was an enormous pleasure doing \"business\" with you, Amelia",
	AMELIA_SILK_OPTION_2_3 = "Perhaps we could schedule another meeting like this one?",
	AMELIA_SILK_REPLY_2_1AND2 = "I assure you the feeling is mutual. Now, if you will excuse me, there are things I really must get to. Please do come again.",
	AMELIA_SILK_REPLY_2_3 = "O-ho, aren't you a daring one? Very well, I promise to think about asking my secretary to check my diary. She'll be in touch. For now though, I have some other business that urgently needs to be taken care of.",
	
	AIRE_RECRUITMENT_OPTION_1 = "I want the elf girl",
	AIRE_RECRUITMENT_REPLY_1 = "— Oh, the princess servant? Fine, we have no further use for her.",
	AIRE_RECRUITMENT_REPLY_BAD_START = "— You think you can make me serve you after all you've done?",
	AIRE_RECRUITMENT_OPTION_BAD_1 = "It's never too late to try fix things up",
	AIRE_RECRUITMENT_OPTION_BAD_2 = "It does not matter what I think, you will submit",
	AIRE_RECRUITMENT_OPTION_BAD_3 = "Maybe I just want to torture you personally",
	AIRE_RECRUITMENT_REPLY_BAD_1 = """Aire gives you a look which does not give any hint that she buys it. 

— I'm not a fool you are taking me for. One way or another I'll make you pay """,
	AIRE_RECRUITMENT_REPLY_BAD_1_ANA = """and will rescue Ana from you. """,
	AIRE_RECRUITMENT_REPLY_BAD_2 = """Aire falls silent upon hearing your dismissal. Without further discussion you take her away.""",
	AIRE_RECRUITMENT_REPLY_BAD_3 = """— Having you around is a torture on it's own. 

Aire seems unimpressed by your remark and quietly follows your orders.""",
	AIRE_RECRUITMENT_REPLY_GOOD_START = """— You've really done it... I guess I have no choice but to join you now?""",
	AIRE_RECRUITMENT_OPTION_GOOD_1 = """I'd not force you against your will""",
	AIRE_RECRUITMENT_OPTION_GOOD_2 = "You'd prefer to stay at the dungeon instead?",
	AIRE_RECRUITMENT_OPTION_GOOD_3 = "That's right, you better be obedient like a good dog",
	AIRE_RECRUITMENT_REPLY_GOOD_1 = "— I appreciate it. Anyway, I'd rather not sit on my ass anymore.",
	AIRE_RECRUITMENT_REPLY_GOOD_2 = "— Touché. Very well, I can't wait to check on Ana.",
	AIRE_RECRUITMENT_REPLY_GOOD_3 = "Aire stays quiet and your words but her face shows that she doubts her initial opinion about you.",



	AMELIA_HERBS_LETTER = "In the morning you receive a small note from the Servants Guild asking you to see the leader.",
	AMELIA_HERBS_OPTION_START = "I've received your letter...",
	AMELIA_HERBS_REPLY_START = "— Glad to see you are eager as ever, [name]. How's your mayorhood?",
	AMELIA_HERBS_OPTION_1_1 = "Can't complain, it's good to be in power",
	AMELIA_HERBS_OPTION_1_2 = "Nothing special, you aren't letting me do anything anyway",
	AMELIA_HERBS_OPTION_1_3 = "Just get to the point",
	AMELIA_HERBS_REPLY_1_1 = "— I'm glad you are enjoying it, after all, your happiness is our reassurance.",
	AMELIA_HERBS_REPLY_1_2 = "— Ha-ha, I guess this is somewhat true, but this is fine, I'm not able to do much at my position either, you know. Nobody would let us get here if this provided any meaningful powers. But at least we can enjoy the luxury of this life.",
	AMELIA_HERBS_REPLY_1_3 = "— Oh come on, don't be so uptight. Do you really dislike my company this much?",
	AMELIA_HERBS_REPLY_2 = """— There's a task at my hands I believe you'll have most success at doing, given your previous experience with the Elven Forests. You see, near the great trees the elves worship one particular plant that can grow— Manna Whiff. Some of our patrons wish to pay a quite high price for it. Actually, a really high price. 

— We have a supplier from there, but our courier has gotten sick and might not be able to take care of it any time soon. I want you to go there and get the merchandise. They should've already received the payment for the next delivery, so you'll only have to find them. """,
	AMELIA_HERBS_REPLY_3 = """— You should know elven officials aren't very fond of trading with us in general, moreover in such unusual circumstances. Try to keep it low profile. Anyway, here's the note with the description of who you have to find. I believe you'll manage.""",
	
	AMELIA_HERBS_ELF_OPTION_START = "Look for smuggler",
	AMELIA_HERBS_ELF_REPLY_START_1 = "After searching around for some time, you've managed to find a person fitting the description: a young tribal elf priestess. As she sees you, she subtly gives you a sign to meet her where no one is around. You follow her, dragging no additional attention.",
	AMELIA_HERBS_ELF_REPLY_START_2 = """You pass her the note and explain what you are doing here, however her response is of reject.

— I'm sorry, I can't do this anymore. I won't be doing this.""",
	AMELIA_HERBS_ELF_OPTION_1_1 = "Look, you can't do this",
	AMELIA_HERBS_ELF_OPTION_1_2 = "I don't get it, why not?",
	AMELIA_HERBS_ELF_OPTION_1_3 = "Are you out of your mind backing out now?",
	AMELIA_HERBS_ELF_REPLY_1 = """— I can't do this anymore, I was desperate at the time, but if I get caught it will be over for me. And I'm already a suspect. As I'm not originally born here, I will be punished severely for it... So you have to understand, I won't do this anymore. I can't return the payment yet, but I'll do something about it soon.""",
	AMELIA_HERBS_ELF_OPTION_2_1 = "I guess, it can't be helped then...",
	AMELIA_HERBS_ELF_OPTION_2_2 = "Look, I really need to make this delivery (Charm Check)",
	AMELIA_HERBS_ELF_OPTION_2_3 = "I could pay you some more, but I really need it (300 gold)",
	AMELIA_HERBS_ELF_OPTION_2_4 = "In that case, I'll tell to the guards that you have indeed been a smuggler",
	AMELIA_HERBS_ELF_REPLY_2_1 = """— Thank you for understanding and goodbye.

The elf girl silently returns to her duty leaving you to think on how to tell Amelia about it.""",
	AMELIA_HERBS_ELF_REPLY_2_2_GOOD = """{color=green|Success}

The elf girl hesitates for some time but eventually gives in to your request.

— Fine, but I beg you, don't come for this ever again. 

She leaves and after a few minutes she returns with the package. """,
	AMELIA_HERBS_ELF_OPTION_2_2_DONE = """Thank you and good bye""",
	AMELIA_HERBS_ELF_REPLY_2_2_BAD = """{color=red|Failure}

— Sorry, you'll have to find some other way. """,
	AMELIA_HERBS_ELF_REPLY_2_3 = """As you whip out a purse of gold, the elven girl seems to give up and do as you want from her.

— Fine, but I beg you, don't come for this ever again. 

As she hides the gold in her clothes, she returns to you in a few minutes, passing the carriage and quickly retreating.""",
	AMELIA_HERBS_ELF_REPLY_2_4_1 = """As the girl hears your words, her face fills with fear. 

— No, please... You wouldn't dare.

Realizing your seriousness she drops her head.

— You win, please wait here...""",
	AMELIA_HERBS_ELF_REPLY_2_4_2 = """After a couple minutes she returns and passes you the carriage 

— Here. But I beg you, do not come here again, I won't be doing this anymore.""",
	AMELIA_HERBS_ELF_OPTION_2_4_2 = "Thanks, good bye.",
	
	AMELIA_HERBS_ELFQUEST1_START = """After reading the description you realize that it's your old acquaintance. As you meet her

— Oh that thing? Right, here you can have it. But please tell Amelia I'll not be doing this anymore. """,
	
	AMELIA_HERBS_ELFQUEST2_START_1 = """After looking for a possible smuggler, you realize that you've been found out by the guards who followed you around. As they approach you, they ask you to follow them.""",
	AMELIA_HERBS_ELFQUEST2_START_2 = "— It's you again. We know what you are here for this time. An illegal smuggling of our holy herbs. The other culprit was already caught and punished. Given your previous merits, we will turn a blind eye on this, but don't ever try doing this again.",
	
	AMELIA_HERBS_END_OPTION_START = "About the delivery",
	AMELIA_HERBS_END_REPLY_START = """As you pass the carriage to Amelia you notice how her ears perk up in surprise.

— I knew I could rely on you! I've already had no faith to get it this time. Must say, our cooperation has been one of the best partnerships in my life. But, anyway, you must be very impatient for your reward. Here's 500 gold for your troubles.

— I want to say, you are one kind of Masters. Strong, capable, decisive... This is really rare at our times. I'm not offering this lightly, but would you like to join me at my home this evening? This isn't something you would be offered on any day.""",
	AMELIA_HERBS_END_OPTION_1_1 = "Sorry, I'll be busy",
	AMELIA_HERBS_END_OPTION_1_2 = "I was afraid you wouldn't ask",
	AMELIA_HERBS_END_REPLY_1_1 = """Amelia seems visibly disappointed but quickly masks her emotions as usual. 

— That's so... I see then, wish you luck with whatever you are doing then.""",
	AMELIA_HERBS_END_REPLY_1_2_1 = """— I knew we were on the same wave. Now, I'll need some time to prepare. I didn't get guests for a long time.

After receiving the instructions, you leave Amelia's office.""",
	AMELIA_HERBS_END_REPLY_1_2_2 = """As evening comes, you find yourself at the gates of Amelia's estate. A couple of junior servants let you in and eye you warily but are immediately dismissed by Amelia.""",

#— You are sharp as ever, [name]. Hope you didn't cut anyone on your way here, he-he. 

#You hold a minor chit chat as Amelia serves you one of the highest grade wines. """,
	AMELIA_HERBS_END_REPLY_1_2_3 = """— You know, I wasn't very sincere with you... Not any more with anyone else, I suppose. But I'd like you to hear me out. Before becoming the guild leader I was a servant too. I heard not many guild leaders happened to be the servants and not the masters, but I guess I got lucky. 

— I had a master, and a pretty strict one at that, but I'd be lying if I said that I didn't like it. It was an easy, careless time I sometimes wish to return to. I think that cats need a master, you know. An owner...""",
	AMELIA_HERBS_END_REPLY_1_2_4 = """— And I think you are just the right person who could help me to... relive those feelings.

Getting caught in the moment you see no other option but to nod in agreement.

— You are always so eager to help me. Well then, please give me a few minutes to prepare.

Saying that, Amelia leaves you alone wondering what she's up to.""",
	AMELIA_HERBS_END_REPLY_1_2_5 = "In a few moments you hear her calling you to enter the bedroom.",
	AMELIA_BONDAGE_1 = """{color=yellow|Amelia: — Punctual as always, I see. A little sharp, even. Hope you didn't cut anyone on your way here.}

Amelia giggles at her joke. She welcomes you into a sumptuously appointed parlour and bids you get comfortable on a long sofa. She brings a bottle of the finest wine in Aliron and serves you a brimming goblet.

You make small talk for a while, chatting about the weather, about the guilds. Amelia has a quick mind and is an entertaining companion. As you talk, she shuffles closer to you on the sofa until her knees are touching yours. You lay your hand on her thigh and she purrs. Amelia puts her wine down and turns to you, a serious look on her face. 

{color=yellow|Amelia: — I have a confession to make, [name]. I have been less than entirely honest with you. No less than with anyone else, of course, but there's something I want to tell you.}

You sip your wine and gesture to her to continue.""",
	AMELIA_BONDAGE_2 = """{color=yellow|Amelia: — Before I became guild leader, I was a servant. Not many guild leaders come from the servant class, most are drawn from among the masters. I guess you could say I was lucky.}

You raise your goblet to her luck.

{color=yellow|Amelia: — As a servant, naturally, I had a master. A very strict master. He could be harsh with his discipline, but I'd be lying if I said that I didn't enjoy it.}

You raise an eyebrow at her confession, wondering where this is leading. 

{color=yellow|Amelia: — Despite the... discipline, being a servant girl was a carefree time for me. Sometimes I wish I could return to it, to escape the duties and responsibility of guild leadership.}

Amelia places her hand on your arm and strokes slowly down to where your hand rests on her stockinged thigh.

{color=yellow|Amelia: — I think that cats need a strong master. Someone to take care of them, and... chastise them occasionally?}""",
	AMELIA_BONDAGE_3 = """The gorgeous catgirl looks up at you, biting her lip as she draws your hand further up her thigh.
0
{color=yellow|Amelia: — A dominant owner, who they can look up to and depend upon, whose authority they trust. Who knows how to treat them firmly.} 

Amelia parts her knees and encourages your hand to slip under her dress. You feel the heat of her bare thighs and your fingers discover she is not wearing any panties. Her pussy is warm and wet. She sighs softly as you caress her slit.

{color=yellow|Amelia: — I hope that... you might be just the person to help me relive those days. Recapture the feeling of being a submissive pet to a powerful man.}

You have no other thought but to agree. Amelia purrs.

{color=yellow|Amelia: — You are always so kind to me, [name]. Please, give me a moment to prepare and then come to my chambers.} 

Amelia hops up and disappears through a doorway, throwing you a coquettish grin over her shoulder""",
	AMELIA_BONDAGE_4 = """A minute later you hear Amelia calling you to her bedroom. 

As you swing open the door you see a large four-poster bed and a plush purple armchair. A leather harness hangs from a pulley in the centre of the room and Amelia has laid out a number of ropes, paddles, whips, cuffs, and clamps on the bed.

The slender catgirl stands in the centre, below the pulley, wearing only stockings and an open-topped corset that displays her voluptuous breasts.

{color=yellow|Amelia: — Oh master, there you are. I- I've been such a bad girl. I should be punished.}

Amelia's feline eyes are wide and she is flushed with desire, her long tail whipping side to side. 

You cross the room and grab a handful of hair, yanking her head back. A smile crosses her pretty face as she moans at your sudden forcefulness. Your other hand reaches around behind her to grab an ass-cheek, squeezing it hard enough to hurt.

{color=yellow|Amelia: — Yes, master, teach me a lesson I won't forget. Show me what discipline means.}""",
	AMELIA_BONDAGE_5 = """Amelia writhes provocatively against you, rubbing her breasts and clit on your muscular frame. Gripping her by the hair you drag her to the bed. You take the handcuffs and bend Amelia over, pulling her arms behind to snap the cuffs over her wrists. She rubs her naked ass into your groin, her tail flicking back and forth across the bulge in your pants. 

You grab a coil of fine silk rope and tow Amelia into the centre of the room. Pulling the harness down, you slip its leather loops over her upper body. Amelia begins to pant in uncontrollable arousal as you bind her. 

You lash rope around her midriff, running it tight around each of her heaving breasts, and then around her collarbone, pinning her arms to her sides. Hauling on the pulley jerks Amelia upright. 

You grab her calf and lift one leg, bending it until the knee almost touches her face. You tie it in place, strapping the foot tight against her buttock. She whimpers excitedly as you stand back to admire your ropework.""",
	AMELIA_BONDAGE_6 = """With Amelia's wet pussy at your mercy, you unleash your cock. She groans lewdly at the sight of your erect penis, raw lust in her eyes. You ask if she is ready to be punish-fucked like the wayward slut that she is. 

{color=yellow|Amelia: — Oh yes, master. Use me however pleases you, master. Make me submit.} 

You fondle her vulnerable body, kneading her breasts and pinching the soft flesh of her ass. Your shaft grinds against wet pussy-lips and Amelia keens needily. You take hold, one hand grabbing a tit, one gripping her hair, and slowly enter her slick pussy. She tries to twitch her hips to urge you deeper but she can hardly move. 

As your thick cock penetrates deep, Amelia sighs in ecstasy. Her eyes roll back and her tight cunt convulses around you. She cums again with each slow and deliberate thrust, her pussy spasming wildly for several minutes. You pinch her nipples as you bury your meat in her, whispering filth into her ear while she gasps for breath.""",
	AMELIA_BONDAGE_7 = """{color=yellow|Amelia: — Oh master... Break me, master...}

Your thrusts pick up speed and you pound Amelia's pussy remorselessly. You use your grip on her breast and hair to slam yourself into her cunt hard enough to bruise the soft flesh. Amelia screams in wild abandon as you hammer her, until you cover her mouth with your hand to muffle the cries. 

Once her screams subside, you grab her narrow waist with both hands so you can fuck her harder. Both your bodies are covered in a fine sheen of sweat. Amelia is panting loud as your penis rams violently into her pussy. You feel your orgasm approaching fast. 

{color=yellow|Amelia: — Cum inside me master, please cum in my disobedient little cunt!}

Your final powerful thrust lifts her off the floor. Impaled on your cock. She hangs from the harness as your cum shoots into her bruised pussy. Amelia yowls, back arched, while your semen pumps into her and then mewls longingly when you pull out.""",
	AMELIA_BONDAGE_8 = """Amelia croons softly as she stands on one leg, cum trickling from her swollen pussy down over her stockings. You ask if she has learned her lesson, or if she requires further discipline.

{color=yellow|Amelia: — Oh yes, master, I've learned so well. I remember what I am now.}

You cup her leaking cunt and smear a handful of cum into her face and hair. You untie her raised leg so she stands on both feet, then loosen the ropes and remove the harness. She sways unsteadily, still handcuffed, her thighs parted to ease the soreness in her tender pussy. You sit on the armchair and pull her over your knee. 

You had planned to unlock the cuffs right away but her trembling ass is too great a temptation. You spank her roughly and she cries out at each smack. 

{color=yellow|Amelia: — Thank you, master... I deserve this.}

You thrash her into another orgasm while her rope-burned tits rub against your cock. Only then do you uncuff her. Sobbing, she climbs into your lap and embraces you, her fine body shivering in overwhelmed gratitude.""",
	AMELIA_BONDAGE_9 = """Back in the parlour half an hour later, Amelia clears the wine goblets away. She steps gingerly to the door, pauses, and looks over her shoulder at where you lounge on the sofa.

{color=yellow|Amelia: — Well, you are quite the gentleman, [name]. You really know how to show a girl a good time. I haven't been so... satisfied since the day I was made guild leader. They say that all good things must come to an end, but I hope we'll have a chance to do this again, some day.}

The catgirl walks awkwardly through to her room and disappears. You let yourself out and return to the mansion.""",
#	AMELIA_BONDAGE_10 = "The gorgeous cat-girl walks awkwardly through to her kitchen and disappears. You let yourself out and return to the mansion.",
#
#	AMELIA_BONDAGE_OPTION_1 = """I'll be waiting for the next time""",
#	AMELIA_BONDAGE_OPTION_2 = """That's a time I won't forget""",
	AMELIA_HERBS_END_REPLY_START_FAIL = """— Oh my, that's a real shame. I already anticipated it, though. Well, I guess I'll have to look for another supplier now. Now, if you excuse me...

Amelia leaves you for her business, leaving you alone.""",
	
	MARRIAGE_CHURCH_CORE = """I'd like to arrange a marriage""",
	MARRIAGE_CHURCH_FINISH_CORE = """I'm ready for the wedding""",
	MARRIAGE_CHURCH_DEFAULT = """— I'm terribly sorry, but we aren't currently able to provide such service due to the ongoing conflict. Let's hope it will be over soon.""",
	MARRIAGE_CHURCH_TEXT_1 = """— Ah, you wish to be betrothed? That's great! The mayor's wedding won't be simple to host though. May I know who's your chosen one?""",
	MARRIAGE_CHURCH_TEXT_2 = """— I see, I see, I'm glad you found someone dear to your heart. I'm allowed to marry the two of you, but the service is going to cost 500 gold.""",
	PAY = """Pay.""",
	MARRIAGE_CHURCH_TEXT_3 = """— Thank you very much. I believe you will need a few things set up first. Firstly, you should prepare enough food and drinks for the wedding and party as well as organizing your deliveries and your guest list. The Servants guild can usually help with this. Secondly, you shall need wedding costumes for you and your [spousehusband]. I believe Workers guild manufacture those. Lastly, as a Mayor, you will require a special insignia for your engagement.""",
	MARRIAGE_CHURCH_TEXT_4 = """— Once you have prepared everything, let me know and we can start the ceremony.""",
	MARRIAGE_CHURCH_CLOSE_OPTION = """Thanks for the directions""",
	MARRIAGE_SERVANTS_INIT = "I'm holding a wedding...",
	MARRIAGE_SERVANTS_1_1 = """— Finally going to seal the deal with our little princess? That's great news. """,
	MARRIAGE_SERVANTS_1_2 = """— Ooh? Well, that's amazing news, I'm very happy for you, Mayor. """,
	MARRIAGE_SERVANTS_1_3 = """So you want us to prepare everything for your wedding? A person of your caliber can't have a simple wedding, after all. We will likely need at least a couple hundred of each foodstuff to start with. As for the drinks we can get away with 10 whiskey and 25 beers, the rest we'll be able to sell to the guests from a couple of local suppliers I know.""",
	MARRIAGE_SERVANTS_2 = """— Lastly, I'm gonna need 3,000 gold from you for the performers and couriers. I'm sure you understand. Also, I'd like you to provide a list of guests you wish to see, and I won't get upset if you add me to it, hehe. Once you have everything, let me know and we'll start the preparations right away.""",
	MARRIAGE_SERVANTS_COMPLETE_OPTION = """I've prepared everything for the wedding""",
	MARRIAGE_SERVANTS_COMPLETE_1 = """— Splendid, I hope you've prepared the other stuff as well. Before you go, there's one more thing I want to ask.""",
	MARRIAGE_SERVANTS_COMPLETE_2 = """— There's one more thing I want ask you about the guests if you'll pardon me. There's a certain category of... indecent people, who will surely seek to appear at the Mayor's wedding. While it might seem to you like a completely abhorrent thing, they are also quite rich and are known to be very generous if certain services are rendered by the bride.""",
	MARRIAGE_SERVANTS_COMPLETE_3 = """— In no way am I suggesting you should compromise your wedding. So let me know if you want them to be invited at all.""",
	MARRIAGE_SERVANTS_OPTION_1 = """Invite them""",
	MARRIAGE_SERVANTS_OPTION_2 = """Refuse""",
	MARRIAGE_SERVANTS_COMPLETE_4 = """— Understood. With that set, I hope to see you soon and wish you a very happy wedding, [name].""",
	MARRIAGE_WORKERS_INIT = "I'm holding a wedding and need costumes for it",
	MARRIAGE_WORKERS_1 = """— Oh ya? My congratulations to ya. Let me introduce ya to our tailors. """,
	MARRIAGE_WORKERS_2 = "Sigmund takes you to a couple of tailors who inform you of the materials they will require to prepare your costumes. For the highest quality dresses they will need 150 Silk Cloth, and 50 Magic Cloth. The work itself is going to cost you an additional 1000 gold.",
	MARRIAGE_WORKERS_COMPLETE_OPTION = """I have everything needed""",
	MARRIAGE_WORKERS_COMPLETE_1 = "As you set the deal with the tailors, they take measurements from you and immediately send a helper for your partner. They promise to finish the work as quick as they can.",
	MARRIAGE_FINAL_INIT = """— Beautiful! In that case, we'll start tomorrow. """,
	MARRIAGE_FINAL_1 = """The next morning you start receiving couriers and guests. Various musicians and a few artists provided by Amelia bring their tools and wait for the party to start. Large trays of exquisite fresh food and ingredients are stocked in the kitchen. The first guests make their attempts to get in your good books by delivering their presents early. As noon draws closer, you move to the church.""",
	MARRIAGE_ANASTASIA_1 = """Anastasia is preparing for the upcoming ceremony as Aire tries to support her.
{color=yellow|Aire: — You are too red, Ana.}

{color=aqua|Anastasia: — Of course I am! Don't you realize how frightening all of this is?}

{color=yellow|Aire: — Less frightening than being hunted by the Guilds' army.}""",
	MARRIAGE_ANASTASIA_2 = """{color=aqua|Anastasia: — ...Does it suit me? It's so weird to wear something this glamorous after all these years as a fugitive.}

{color=yellow|Aire: — You look beautiful. I never thought I'd actually see you in a wedding dress, though.} 

{color=aqua|Anastasia: — One day you might end up in one too, you know.}

{color=yellow|Aire: — Hmph, I doubt [name] is ever gonna allow me such liberty.} 

{color=aqua|Anastasia: — Hey, don't speak badly of [him].}""",
	MARRIAGE_FINAL_2 = """Given the fairly humble size of the church, only a selected few of your many guests have been allowed inside. The building has been newlydecorated for your wedding, and Ginny is all set to play the role of minister.""",
	MARRIAGE_FINAL_3 = """As [spousename] is brought to the church, [spousehe] looks somewhat nervous, but still returns your wink with a smile. As [spousehe] makes it to the altar, Ginny starts the ceremony.

{color=yellow|Ginny: — Celena thanks you all for coming here today...}""",
	MARRIAGE_FINAL_4 = """{color=yellow|Ginny: — [name], do you agree to take this [spousename] as your [spousehusband]?}""",
	MARRIAGE_FINAL_4_OPTION_1 = """Yes""",
	MARRIAGE_FINAL_4_OPTION_2 = """Absolutely""",
	MARRIAGE_FINAL_4_OPTION_3 = """What's the point in going through all of this otherwise?""",
	MARRIAGE_FINAL_5 = """{color=yellow|Ginny: — Now you can kiss the [groom].}

[spousename] leans to you as you seal [spousehis] lips with yours. As guests cheer you on, you enjoy the moment, finally breaking away after a couple of minutes to grin at the crowd. 

{color=aqua|[spousename]: — Thank you, [name], this is the best day of my life...}""",
	MARRIAGE_FINAL_6 = """Leaving the church, you return to the mansion. Many new guests wait for you over there and a raucous, high-spirited party breaks out. While you are making new connections and receiving wedding presents from other landlords and authorities, you notice how [spousename] glances at you coyly from time to time.""",
	MARRIAGE_FINAL_7 = """As the party stretches into the evening, one of your servants approaches and passes you a note from a small group of guests— the wealthy people mentioned by Amelia. The note mentions how much they are enjoying the party and says they are ready to pay a large sum of 5,000 gold for a night of fun with the mayor's newlywed wife.""",
	MARRIAGE_FINAL_7_OPTION_1 = """Order to throw them out""",
	MARRIAGE_FINAL_7_OPTION_2 = """Just ignore them""",
	MARRIAGE_FINAL_7_OPTION_3 = """Invite them to the bedroom""",
	MARRIAGE_FINAL_8_1 = """You order the rich bastards thrown out of your wedding party. Recovering your mood, you return to [spousename] and spend some more time with her until night falls.""",
	MARRIAGE_FINAL_8_2 = """You decide to ignore the proposition and return to spending time with your wife as night falls. Despite your concerns, the group make no further requests.""",
	MARRIAGE_NIGHT_GROUP_1_1 = """With night falling and guests starting to leave, you approach [spousename] and lead [spouseher] to your bedroom. As you enter, you find the group of men waiting, whose deal you accepted.
[spousename] shouts in surprise, but after looking at you, realizes this is no coincidence.""",
	MARRIAGE_NIGHT_GROUP_1_2 = """As you order [spousehim] to serve these men, [spousehe] seems rather agreeable to it.""",
	MARRIAGE_NIGHT_GROUP_1_3 = """You order [spousename] to serve these men, and [spousehe/she(?)] looks at you with disbelief and horror. However, realizing there's no way for her to escape this now, [she] resentfully nods.""",
	MARRIAGE_NIGHT_GROUP_1_4 = """Now all that's left is to choose what you're gonna do...""",
	MARRIAGE_NIGHT_GROUP_OPTION_1 = """Join""",
	MARRIAGE_NIGHT_GROUP_OPTION_2 = """Leave""",
	MARRIAGE_NIGHT_GROUP_2_1 = """As a [husband] you get the first turn on your [spousehusband] pussy, as [spousename] uses [spousehis] mouth to serve your guests. You unload into [spousehis] womb, and let one of the waiting rich men take over while [spousename] cleans your shaft with her mouth. While the guests continue to use your wife's body, you order one of the servant girls into the room, to have some fun while you are watching.

After a few hours every guest in the room has had a round with [spousename] and is completely exhausted. As they finally leave, the last one passes you the money they promised.""",
	MARRIAGE_NIGHT_GROUP_2_2 = """You decide to leave your [spousehusband] and go for a stroll. After a couple of hours one of the men finds you and informs you how well it went, passing you the promised payment. As they leave, you order the servants to take care of the leftover mess and call it a day.""",
	MARRIAGE_NIGHT_1 = """As party moves to the closure and guests leave, your [spousehusband] approaches you in expectation.

— [Master]... Should I use my darling now? This seems to be quite late, and if you are not tired...""",
	MARRIAGE_NIGHT_OPTION_1 = """Let's get to the bedroom""",
	MARRIAGE_NIGHT_OPTION_2 = """I guess I am tired""",
	MARRIAGE_NIGHT_2_1= """You take [spousename]'s hand and go to the bedroom, leaving the rest of the mess to the servants.""",
	MARRIAGE_NIGHT_2_2 = """[spousename] returns you a saddened look but nods in agreement. You decide to go to sleep and call it a day.""",
	
	DAISY_SERVE_OPTION_START = "Serve me",
	DAISY_SERVE_START_1 = "— Of course, [Master]. What part of my body would you like to use?",
	DAISY_SERVE_START_2 = """— O-Of course, [Master]... How can I serve you best..?

Daisy awkwardly avoids eye contact, waiting for you to finish.""",
	DAISY_SERVE_OPTION_1_1 = "Use your mouth",
	DAISY_SERVE_OPTION_1_2 = "Bend over",
	DAISY_SERVE_OPTION_1_3 = "Nevermind",
	
	
	CALI_SERVE_START_1 = "— ...You mean like naughty stuff? Okay, I don't mind if it's with you, [Master]. ",
	CALI_SERVE_START_2 = """— What can I do for you, [Master]?

It seems Cali's training has paid off and she does not hesitate answering.""",
	CALI_SERVE_OPTION_1_1 = "Use your mouth",
	CALI_SERVE_OPTION_1_2 = "We do it standing",
	CALI_SERVE_OPTION_1_3 = "Nevermind",
	
	
	
	
	
	GRYPHON_AIRE_START = """As you walk through the grounds of your mansion one morning, you notice a young elf girl, Aire, diligently training with her bow and arrows at the makeshift archery range. You watch her for some time, noticing how firm her concentration is.

After another couple of precise shots she turns to you questioningly . 

— Can I do something for you?""",
	GRYPHON_AIRE_START_OPTION_1 = "Your skills are admirable ",
	GRYPHON_AIRE_START_OPTION_2 = "I don't remember giving you an order to train",
	GRYPHON_AIRE_1_1 = "— Thank you. I can't let my skills go rusty even in this state. I'm glad there's still opportunity to train at this time.",
	GRYPHON_AIRE_1_2 = "— There was no other work at this time, so I went to train my skills so they won't get rusty. I hope this is permitted.",
	GRYPHON_AIRE_1_OPTION_1 = "Why are you training so hard?",
	GRYPHON_AIRE_1_OPTION_2 = "You seem a little too enthusiastic about this",
	GRYPHON_AIRE_2 = """— I've sworn to protect the princess with my life and this is not a task I can accomplish without training. I know I must obey your orders, but even then I'll be ready to put my life on the line in case something threatens Ana.""",
	GRYPHON_AIRE_2_OPTION_1 = "You should really take it easy, the war is over",
	GRYPHON_AIRE_2_OPTION_2 = "There's no point in this anymore, I'll protect her",
	GRYPHON_AIRE_2_OPTION_3 = "What makes you think you are better than me, her [master]?",
	GRYPHON_AIRE_3_1 = """— War or not, I have to stay focused. This is how I express my gratitude to her. I'm sorry, but I can't trust you in something so crucial.""",
	GRYPHON_AIRE_3_2 = """Aire's face shows slight sneer at your words, but she quickly turns away to hide it.

— Is that so? How can I trust you with her life? She's little more than a toy to you. But even if not, I don't believe you are any better than me.""",
	GRYPHON_AIRE_3_3 = """— I know that I can't rely on you, or anyone, in such a crucial task. I'm not trying to offend, but I have doubts that you are better than me.""",
	GRYPHON_AIRE_3_OPTION_1 = "What if I prove to you I'm capable?",
	GRYPHON_AIRE_3_OPTION_2 = "Now I'll have to prove it to show you who's the [master] here",
	GRYPHON_AIRE_4_1 = """— Hmph, you can ask me whatever you want then. If you prove to me that you are ready to take care of Ana like I can't, I'll do anything you want. You must be thinking of something lewd, aren't you? If you prove your worth to me, I'll become your lapdog if that is what you wish.""",
	GRYPHON_AIRE_4_2 = """— I'll see if you can. If you prove to me that you are ready to take care of Ana like I can't, I'll do anything you want. You must be thinking of something lewd, aren't you? If you prove your worth to me, I'll become your lapdog if that is what you wish. """,
	GRYPHON_AIRE_4_OPTION_1 = "You really know how to motivate a man",
	GRYPHON_AIRE_4_OPTION_2 = "You must be really sure of yourself",
	GRYPHON_AIRE_4_OPTION_3 = "You'll regret these words",
	GRYPHON_AIRE_5 = """— Don't start drooling before it's done. Fine, if you want to prove it, I'll accept no less than defeating an Elder Gryphon. This is a rare fierce kind of gryphon, one that even elves won't dare to approach. If you can get one, I'll accept that you will suffice as Anastasia's protector.""",
	GRYPHON_AIRE_5_OPTION_1 = "Prepare for your loss",
	GRYPHON_AIRE_5_OPTION_2 = "This doesn't sound too hard",
	GRYPHON_AIRE_6 = """— ...Just don't get yourself killed. Not that I care, but we gonna be in trouble if that happens.""",
	
	GRYPHON_WORKERS_START_OPTION = "I'm looking for an Elder Gryphon...",
	GRYPHON_WORKERS_START = """— Hmm, I dunno de details, ya'd want to get some experienced hunters who's brave enough to go into de elven woods at least. I think I can show ya a few.

Sigmund tells you how to find a hunter veteran named Derek who can give you the directions to track down the Elder Gryphon.""",
	GRYPHON_HUNTER_START = """You find Derek, veteran hunter who Sigmund told you about. After telling him what you want, he looks amused.

— That's a dangerous task, pal, but I like it. Ya know, given your status, we could probably recruit a few other experienced hunters for it. The forests are dense so bringing too many people will do us more harm than good. 

— That's quite a bold achievement you are aiming at, mayor. Not a dragon slaying, but still can go down in history. What would you want to do it for?""",
	GRYPHON_HUNTER_START_OPTION_1 = "That beast's body can be quite valuable",
	GRYPHON_HUNTER_START_OPTION_2 = "What's life without the thrill of conquest?",
	GRYPHON_HUNTER_START_OPTION_3 = "Just trying to impress a girl",
	GRYPHON_HUNTER_1_1 = """— Huh, so some rich stuff then. Well, none of my business then.

I have some information on where one of those beasts was seen last time, not too far from the forest's border. I suggest going there so we can start e to track it down.""",
	GRYPHON_HUNTER_1_2 = """— I had no idea our mayor is that adventurous, I can respect that.

I have some information on where one of those beasts was seen last time, not too far from the forest's border. I suggest going there so we can start to track it down.""",
	GRYPHON_HUNTER_1_3 = """You notice how Aire frowns and gives you a judging look.

— Haha, you are quite a kidder. Well, you must have your reasons.

I have some information on where one of those beasts was seen last time, not too far from the forest's border. I suggest going there so we can start to track it down.""",
	GRYPHON_HUNTER_1_OPTION_1 = "That's the plan then",
	GRYPHON_HUNTER_1_OPTION_2 = "Let's not waste any more time",
	GRYPHON_FOREST_START = """You approach a denser part of the forest, where you have heard you might find an Elder Gryphon. Aire by your side stays silent, but the frown on her pretty face hints at judging your decisiveness. A few other hunters have come here from the city and agreed to follow your orders.""",
	GRYPHON_FOREST_1 = """As you defeat the minor gryphon, you let the hunters search the surroundings for the tracks of the elder. While waiting, Aire approaches you.

— I don't like doing this, this is too dangerous.""",
	GRYPHON_FOREST_1_OPTION_1 = "Would be a waste not to finish it now",
	GRYPHON_FOREST_1_OPTION_2 = "Ready to admit your defeat then?",
	GRYPHON_FOREST_1_1 = """Aire prepares to say something but at the last moment bites her lip and stays quiet. Realizing it was her idea in the first place, she's unable to bring herself to accept defeat. 

Finally Derek comes to you with good news. The hunters were able to find evidence that the Elder Gryphon must be somewhere nearby. One of them has seen a large cave near the river on your way here and it seems to be the most likely spot. Hearing this you give the order to move out.""",
	GRYPHON_FOREST_1_2 = """— Hmph, don't make me laugh. See if you die, I don't care. 

Finally Derek comes to you with good news. The hunters were able to find evidence that the Elder Gryphon must be somewhere nearby. One of them has seen a large cave near the river on your way here and it seems to be the most likely spot. Hearing this you give the order to move out.""",
	GRYPHON_CAVE_START = """With your group of hired hunters and Aire you enter the spacious cave. Almost by the entrance you spot large feathers indicating that the hunters' guess was correct. After another hundredfeet you hear the screeching roar of an angry beast. The whole group quicky retreats from the cave as you are followed out by a gigantic gryphon, larger than any you've ever seen before.""",
	GRYPHON_CAVE_1 = """As the Elder Gryphon is on its last breath, you notice how it focuses its attention on Aire, who is still within the reach of its massive talons. Unexpectedly to everyone, the Elder Gryphon bellows another fierce roar and makes a dash in her direction.""",
	GRYPHON_CAVE_1_OPTION_1 = "Try to block it",
	GRYPHON_CAVE_1_OPTION_2 = "Do nothing",
	GRYPHON_CAVE_BAD = """Aire's eyes widen as a giant gryphon's claw tears through her stomach. In a mere swipe her slender body is torn apart by it. As one of the hunters strikes on the gryphon's exposed neck, it finally falls down. You rush to Aire, but it's too late to do anything for her. She musters the last of her breath aimed at you.

— P-please, protect... Ana...

The gryphon lies defeated, but there's little meaning left in it.""",
	GRYPHON_CAVE_2 = """You jump in front of Aire, blocking the incoming attack with your weapon. The massive force pushes you back into Aire, who looks at you with shock and disbelief. Your weapon breaks under the pressure of the attack and you feel the gryphon's claw enter your chest. The first impact pushes you back, so the claw does not cut as deep as it could have, yet you feel like at least one of your ribs was broken.

Thankfully, the attack opened an opportunity for one of the hunters to deeply wound the gryphon's neck, which finally made it fall. With no strength left you slump to the ground. Aire hastily drops to her knees beside you, her eyes watering. """,
	GRYPHON_CAVE_3 = """— You've... Why? Why did you protect me?! You have to protect Ana!.. You can't die now!

You only manage to give Aire a small smile before losing consciousness.""",
	GRYPHON_CAVE_4 = """You wake up in a small tent positioned close to the gryphon's lair. You don't feel too great, but it seems one of the healers has patched you up and your life is in no danger. Next to your bed you observe a familiar elven girl.

— [name]! Never do something like this again! What were you thinking!?""",
	GRYPHON_CAVE_4_OPTION_1 = "It was more of an instinct",
	GRYPHON_CAVE_4_OPTION_2 = "That's what a hero must do",
	GRYPHON_CAVE_4_OPTION_3 = "How much I'm gonna bang your sweet ass for this",
	GRYPHON_CAVE_5 = """— You are an idiot, aren't you? Look what nearly happened... I'm sorry I made you do that, I didn't think you'd actually try to bring down that beast... And thank you for saving me. For the second time. I guess I am obliged to do anything you want of me now. I mean, once your wounds are healed.""",
	GRYPHON_CAVE_5_OPTION_1 = "That's what I wanted to hear",
	GRYPHON_CAVE_5_OPTION_2 = "I'm glad you are safe as well",
	AIRE_GREET = """— What do you want of me?""",
	GRYPHON_AIRE_SEX_START_OPTION_INIT = "About your promise...",
	GRYPHON_AIRE_SEX_START = "— Y-yes? What do you have for me?",
	GRYPHON_AIRE_SEX_START_OPTION_1 = "I want to have a threesome with you and Anastasia",
	GRYPHON_AIRE_SEX_START_OPTION_2 = "I haven't decided yet",
	GRYPHON_AIRE_SEX_1 = """Aire becomes silent for some time and just as you think she's going to make you regret saying that, she responds.

— I'm not against it, but never thought about doing something like that with Ana. I mean, she deserves you more than me. But if it is your order, we will both obey. So you want me to prepare her for it then? Not that I have any experience with another girl, but I guess I can do that.""",
	GRYPHON_AIRE_SEX_1_OPTION_1 = "That's settled then",
	GRYPHON_AIRE_SEX_1_OPTION_2 = "I've changed my mind",
	GRYPHON_AIRE_SEX_2 = "Aire nods in response and you set a plan for the upcoming event.",
	GRYPHON_ANA_SEX_OPTION_INIT = "Tonight we are gonna do something special...",
	

GRYPHON_ANA_SEX_START = """By your invitation Anastasia enters your room clad in erotic lingerie. Her eyes widen as she sees her elven friend standing there in her underwear.

Anastasia: — A-aire? What are you doing here?

Aire: — I've been invited to join you, by our [Master]'s command.""",


	GRYPHON_ANA_SEX_1 = """Anastasia: — That's...

Aire: — Are you unhappy to have me here?

Anastasia: — That's not it, I'm just embarrassed.

Aire: — Me too, but that's what our protector wants, so I think it's not too big of a deal? Besides, it's not like I don't want to get closer to the two most important people in my life.

Anastasia had no answer for that and Aire led her to the bed.""",


GRYPHON_ANA_SEX_2 = """Aire: — So, let's do our best to please our [master] and find some joy in the act — not just as friends but also as women. 

The princess nodded as they both lowered to their knees before you. Aire stripped away the last bits of her underwear and Anastasia followed her closely. 

Aire: — Wow, Ana, I noticed you hide your breasts, but they seem larger than mine. Must be because of your royal blood.

Anastasia: — W-what are you saying!? They aren't that much bigger... You don't think they are too big, right [name]?""",
	GRYPHON_ANA_SEX_2_OPTION_1 = "They are perfect",
	GRYPHON_ANA_SEX_2_OPTION_2 = "There's no such thing as \"too big\"",
	GRYPHON_ANA_SEX_2_OPTION_3 = "You should be more accepting of your body",
	
	GRYPHON_ANA_SEX_3 = """Anastasia blushes and looks away, as Aire moves her closer to you. 

Aire: — Come on, [name] worked really hard for this moment, we should reward him.

Aire positions herself in front of Anastasia, embracing her across your hips with your fully erect dick between them. Aire strokes your shaft and presses it between Anastasia's firm breasts, pressing her own tits against the princess's to keep it there.

Aire: — Is this to your liking, [Master]?
	
You grunt in approval as the two girls obediently squeeze their breasts together around your cock.
	
Anastasia: — This is... This feels good...""",

GRYPHON_ANA_SEX_4 = """The elf girl and the princess bob gently up and down, your penis sliding between their firm breasts. You groan in pleasure as you watch them both tending to your shaft. Aire seems more eager for this than you had expected, holding eye contact with you as she presses your hard cock tightly between her tits.

Anastasia still seems ashamed, blushing deep red as she scoops her large breasts together around your dick, using them to massage your shaft as Aire bounces more vigorously up and down. The princess looks at Aire, then to you, her big blue eyes full of uncertainty and arousal.

The girls' nipples glide over and press against each other as they work your cock with their tits and you can see them growing more visibly aroused as they continue. In a few minutes they are both sheened with perspiration from their efforts and your penis slips more easily in between their slick breasts.""",
	
	GRYPHON_ANA_SEX_5 = """	
After some time, you can feel your orgasm beginning to build. Your hips twitch reflexively, thrusting in between the elf girl and the princess as they service you.

You have to resist the urge to grab the two girls by the hair and press their chattering mouths against your cock. But your orgasm arrives like a charging bull, shooting cum into the air and all over the faces and bodies of the two women kneeling before you. """,

	GRYPHON_ANA_SEX_6 = """
Anastasia looks first alarmed and then ashamed as a spray of thick semen spatters across her face and into her soft cleavage. A glob of cum lands in Aire's eye and she closes it quickly, sperm leaking from her eyelid and running down her cheek..

Aire: — Hah! By the gods, that's a lot of cum, [Master]. Enough for two, even!

Using her fingers, Aire wipes some of the cum from Anastasia's face and holds her hand out to the princess. 

Anastasia: — A-are you sure?

In reply, Aire runs a finger over her own breasts, gathering some of the cum there, and then sucks the finger into her mouth to clean it. Seeing this, Anastasia hesitantly opens her mouth to lick your cum from Aire's other hand.

Aire looks back at you expectantly.

Aire: — Was this everything you imagined it would be, [Master]? Or was there anything else you wanted? 

She looks back at Anastasia suggestively, who blushes again. """,

	GRYPHON_ANA_SEX_7 = """You smile wolfishly and tell them that you're only getting started.

You order the two naked girls off the floor. Aire rises and takes Anastasia by the hand, leading her towards your bed. You follow close behind, admiring their pert asses. Aire lays down on her back on top of the bedcovers, spreading her slender elven legs. Anastasia looks back at you over her shoulder for a moment, as if unsure, but Aire pulls on her hand and draws the reluctant princess down until she is laying on top of the excited elf.""",

	GRYPHON_ANA_SEX_8 = """Their plump breasts press together and they both watch you as you approach, your penis already stiffening again at the delightful sight of the naked princess straddling her aroused serving-girl. 

Your hand runs over the smooth curve of Anastasia's round ass, before slipping down between her legs. Her pussy is warm and wet with her own juices and she gasps softly in pleasure as your fingers enter her, her back arching when you stroke her clit.

Your fingers move lower, probing Aire's tight slit and finding it hot to the touch as it opens easily under the pressure of your fingertips. Aire moans with desire. You move around and mount the bed behind Anastasia

Aire: — Ana, I — I'm glad I can serve you and the [Master] in this way.

Anastasia: — Stop saying silly things like this...

Using both hands, you press Anastasia down on top of Aire and spread her legs wider. Their pussies stacked on top of each other, you penetrate Aire first, squeezing Anastasia between you as your cock pushes firmly into the elf girl's willing pussy. Aire cries out as you shove yourself all the way into her, stretching her tight cunt with your rock-hard penis.""",

	GRYPHON_ANA_SEX_9 = """After a few strokes you pull out and enter Anastasia, who trembles with arousal as your shaft, slick with Aire's juices, slips easily into her wet hole. The two girls stare into each other's eyes as you fuck the princess doggy-style on top of her serving-girl. You fuck Anastasia hard while gripping her hips, making her yelp as you grind roughly against her smooth ass.

You feel Anastasia's pussy grip your cock as she approaches orgasm and you pull out. The princess whines softly as you plunge your cock back into Aire, fucking her tight elven pussy hard as you use Anastasia's naked body to pin her to the bed.. 

Aire clings to Anastasia as you fuck her to the edge of orgasm and then withdraw. She whimpers as your meat slips out of her, pussy twitching helplessly. When you thrust into Anastasia this time she presses her ass back into you, begging urgently to be fucked.""",


	GRYPHON_ANA_SEX_10 = """You take your time, fucking each girl in turn over the next couple of hours until they are both exhausted and pleading for the release of orgasm. 

You decide to cum inside Aire first as a reward for her obedience and as your final thrusts push her spasming pussy over the edge, you roughly shove your fingers inside Anastasia's pulsing cunt. The three of you reach orgasm together, both girls shaking and moaning, clasping each other tightly while you fill Aire's aching pussy with your cum. 
The two girls lie in a tangled heap of slender limbs, flushed and panting for breath as you pull out of Aire. Your cum trickles from her as she lies underneath Anastasia. 

Aire: — Oh, master... I never dreamed... I... thank you...

Anastasia can barely speak and slumps heavily on top of Aire. Her perfect ass rises and falls as she gasps for breath, pussy hot and glistening with her own juices. You feel your cock stiffening again and you cram it into the princess's exposed cunt.

You fuck Anastasia roughly, fingers sinking into the soft flesh of her ass as you pound her. Underneath, Aire squeezes the princess's breasts while you thrust savagely into Anastasia's wet pussy. Anastasia cries out, caught between pain and pleasure as your cock ploughs relentlessly into her.

In a few minutes you cum again, shooting your seed into Anastasia's throbbing cunt as she is overwhelmed by a tearful orgasm. Aire cums again too, fingering her own leaking hole frantically as you fuck her beloved princess on top of her. Your cum spills from Anastasia's pussy over Aire's hands.

Casually, you inform both girls that whenever they are ready there is work to be done.""",

	
	ZEPHYRA_RECRUITMENT_LETTER = "In the morning you receive a letter from Ginny from the local church, asking you to visit her.",
	ZEPHYRA_RECRUITMENT_1 = """— Welcome, [name]! I heard you've become a Mayor now? Congratulations!

— I'm glad you've visited us. You must've received the message? I wouldn't dare to address you normally, but there was a person who wished to see you. I take it she's your acquaintance?""",
	ZEPHYRA_RECRUITMENT_2 = """{color=yellow|Ginny: — I've allowed her to stay at the church as it's an honor to me. Even if she's not a follower of Celena, she is very respectful — as a Champion ought to be.}

{color=aqua|Zephyra: — Hey, [name]. It's been a while. Ah, it was so cruel of you to leave me all alone back then. And in such scary times too. Can you imagine what all those desperate bandits could do to someone like me? }

{color=aqua|Zephyra: — Well, I see you've settled this war for good. I was right about you after all.}""",
	ZEPHYRA_RECRUITMENT_2_OPTION_1 = """You really are full of surprises""",
	ZEPHYRA_RECRUITMENT_2_OPTION_2 = """I'm surprised you're still following me""",
	ZEPHYRA_RECRUITMENT_2_OPTION_3 = """I don't have time for this""",
	ZEPHYRA_RECRUITMENT_3_1 = """{color=aqua|Zephyra: — Please, you are flattering me. It's just a mission I have to perform.

Zephyra: — Now, that you are a Mayor you will have more support and resources at your disposal which can only be a good thing, but there's a serious danger to this land, and, perhaps, the world. It seems that this is my deity's intention for me.

Zephyra: — Do you know what an Artifact is? It's an item from a deity, which can hold enormous powers, or have some hidden attributes. These artifacts are all connected to deities in some way. I believe there was an ancient sword belonging to this land and its monarch.}""",
	ZEPHYRA_RECRUITMENT_3_2 = """{color=aqua|Zephyra: — There's a mission I have to perform, so we're here now.

Zephyra: — Now, that you are a Mayor you will have more support and resources at your disposal which can only be a good thing, but there's a serious danger to this land, and, perhaps, the world. It seems that this is my deity's intention for me.

Zephyra: — Do you know what an Artifact is? It's an item from deity, which can hold enormous powers, or have some hidden attributes. These artifacts are all connected to deities in some way. I believe there was an ancient sword belonging to this land and its monarch.}""",
	ZEPHYRA_RECRUITMENT_3_3 = """{color=aqua|Zephyra: — It's sad to hear it, but I won't be able to talk you into cooperation after all... 

Zephyra: — If you tell me, I won't be bothering you anymore then.}""",
	ZEPHYRA_RECRUITMENT_3_3_OPTION_1 = """Yes, I want you to leave me alone""",
	ZEPHYRA_RECRUITMENT_3_3_OPTION_2 = """I've changed my mind""",
	ZEPHYRA_RECRUITMENT_3_OPTION_1 = "There might be a problem with this...",
	ZEPHYRA_RECRUITMENT_3_OPTION_2 = "This sword is no longer in our possession",
	ZEPHYRA_RECRUITMENT_4 = """You explain to Zephyra what has happened during the earlier days of civil war.

{color=aqua|Zephyra: — Hmm, this is troublesome. A demon took the sword at the start of the war? This might be the danger I was warned about. A great shame, but it only makes it more urgent that we focus on collecting other artifacts. 

Zephyra: — The artifacts don't possess much power as they currently are, but being connected to deities, they can become very dangerous. I believe we must secure them before that demon gets to them. The next closest one must be kept by the forest elves.}""",
	ZEPHYRA_RECRUITMENT_4_OPTION_1 = "How do I know your goals are good?",
	ZEPHYRA_RECRUITMENT_4_OPTION_2 = "So how do you propose for me to get to it?",
	ZEPHYRA_RECRUITMENT_5_1 = """{color=aqua|Zephyra: — Hmm, indeed, you can't. Trust me, I guess? If you trust me I promise you to do my best to help you. How about it?

Zephyra: — Well, you are the Mayor, so one way or another you'll be able to get to the elven artifact before that demon chick will. No need to rush it, but you should look it up.

Zephyra: — So, did I convince you? I'm looking forward to working with you... As long as you don't mind.}""",
	ZEPHYRA_RECRUITMENT_5_2 = """{color=aqua|Zephyra: — Well, you are the Mayor, so one way or another you'll be able to get to the elven artifact before that demon chick will. No need to rush it, but you should look it up.

Zephyra: — So, did I convince you? I'm looking forward to working with you... As long as you don't mind.}""",
	ZEPHYRA_RECRUITMENT_5_OPTION_1 = "Very well, you can join me",
	ZEPHYRA_RECRUITMENT_5_OPTION_2 = "I'm not going to bother with it after all",
	ZEPHYRA_RECRUITMENT_6_GOOD = """{color=aqua|Zephyra: — Jeez, finally. You really played this hard to get, didn't you? I'm glad we can be friends from now on at least. Don't mind me too much, please.}""",
	ZEPHYRA_RECRUITMENT_6_BAD = """{color=aqua|Zephyra: — Ah, that's so? It's a shame, really. Well, I can only wish that you won't end up drowning in a sewer. Farewell, [name].}

Zephyra leaves the church without giving you a second glance.""",
	ZEPHYRA_SWORD_1 = """— You've done it, [name]. Not something just anyone can brag about. I'm glad my decision to join your side was the correct one after all.

— Now that you are a Mayor you will have more support and resources at your disposal which can only be a good thing, but there's a serious danger to this land, and, perhaps, the world. It seems that this is my deity's intention for me.

— You know what an Artifact is? It's an item from deity, which can hold enormous powers, or have some hidden attributes. These artifacts are all connected to deities in some way. I believe there was an ancient sword belonging to this land and its monarch.""",
	ZEPHYRA_SWORD_1_OPTION_1 = "There might be a problem with this...",
	ZEPHYRA_SWORD_1_OPTION_2 = "This sword is no longer in our possession",
	ZEPHYRA_SWORD_2 = """You explain to Zephyra what has happened during the earlier days of the civil war.

— Hmm, this is troublesome. A demon took the sword at the start of the war? This might be the danger I was warned about. A great shame, but it only makes it more urgent that we focus on collecting other artifacts. 

— The artifacts don't possess much power as they currently are, but being connected to deities, they can become very dangerous. I believe we must secure them before that demon gets to them. The next closest one must be kept by the forest elves.""",
	ZEPHYRA_SWORD_2_OPTION_1 = "I doubt that they will simply give it to us",
	ZEPHYRA_SWORD_2_OPTION_2 = "What's gonna happen after we gather all the artifacts?",
	ZEPHYRA_SWORD_3_1 = """— Me too. Well, you are the Mayor, I believe you'll get an opportunity one way or the other eventually. Until then I'll be staying by your side, if you don't mind.""",
	ZEPHYRA_SWORD_3_2 = """— No idea. I'm sorry, but I can only vaguely interpret the general idea of what we are expected to do. I hope that doesn't disappoint you too much? Until we make more progress I hope to stay by your side.""",
	PRIESTESS_SWORD_TALK_1_1 = """After making an appointment, you are able to find an audience with the High Priestess. 

— Just so you know, I'm only receiving you because of your high status. What do you need?""",
	PRIESTESS_SWORD_TALK_1_2 = """The priestess gives you a scornful look.

— Cease your human banter, as Freya's chosen I have no time for such things. Even if we had some common ground in the past it means nothing.""",
	PRIESTESS_SWORD_TALK_1_OPTION_1 = "Are you doing well?",
	PRIESTESS_SWORD_TALK_1_OPTION_2 = "I'm actually seeking for specific artifacts...",
	PRIESTESS_SWORD_TALK_2 = """You explain everything you know about the artifacts and the demon woman who seems to be after them. Contrary to your expectations, the High Priestess does not seem impressed.

— What you say hardly concerns me. Naturally there's no way this will happen. You are not allowed to get anywhere close to the Sacred Bowl. As for the demon you mentioned, we know nothing about it. If there's nothing else, I'll ask you not to bother me anymore. """,
	PRIESTESS_SWORD_TALK_2_OPTION_1 = "But this might be crucial for you too",
	PRIESTESS_SWORD_TALK_2_OPTION_2 = "Is there nothing that can change your mind?",
	PRIESTESS_SWORD_TALK_2_OPTION_3 = "You might regret this decision",
	PRIESTESS_SWORD_TALK_2_OPTION_4 = "*Leave*",
	PRIESTESS_SWORD_TALK_3_123 = "The priestess ignores your response and calls a guard to show you the way out.",
	PRIESTESS_SWORD_TALK_3_4 = "You decide there's nothing to be done and it's time to go.",
	PRIESTESS_SWORD_TALK_4_0 = """You leave the High Priestess's chambers and walk away, but after a few hundred feet a couple guards stop you and ask you to follow them. They bring you to what seems to be the military's headquarters and a tall elf man greets you.

— Hello, [name]. Please, don't be alarmed, I only ordered my men to bring you in for a chat. """,
	PRIESTESS_SWORD_TALK_4_1 = """— I'm Erlen, the current military commander. It's not as impressive a title as you might imagine, since we are direct subordinates of the High Priestess. Freya's High Priestess is our governor and she also defines our laws. Not every elf is happy about that, though.""",
	PRIESTESS_SWORD_TALK_4_2 = """— Yes, you might find it unusual, we prefer to remain civil and use underhand tactics inside of our society. There are many other etiquette and religious rules I'm not going to bother you with, as these are not relevant to the reason you are here.""",
	PRIESTESS_SWORD_TALK_4_OPTION_1 = "Who are you?",
	PRIESTESS_SWORD_TALK_4_OPTION_2 = "You elves have some shady ways of doing things",
	PRIESTESS_SWORD_TALK_4_OPTION_3 = "What do you want?",
	PRIESTESS_SWORD_TALK_5 = """— I've heard you are looking for a Sacred Bowl. Your story raises some questions but my sources suggest your information is credible. I can talk the High Priestess into giving you a chance to claim the Sacred Bowl.""",
	PRIESTESS_SWORD_TALK_5_OPTION_1 = "Why would you be so generous?",
	PRIESTESS_SWORD_TALK_5_OPTION_2 = "This won't be for free I bet?",
	PRIESTESS_SWORD_TALK_6 = """— First I need you to do something in return. On the edge of our forests there's a large beastkin tribe. I want you to travel there and deliver a message I'm going to pass to you, then return with an answer. The message will be sealed so only the receiver will be able to read it. I want you to deliver to the tribe's chieftain.""",
	PRIESTESS_SWORD_TALK_6_OPTION_1 = "Do you dislike those Beastkin?",
	PRIESTESS_SWORD_TALK_6_OPTION_2 = "Why won't you go yourself?",
	PRIESTESS_SWORD_TALK_6_OPTION_3 = "Very well, I'll do it",
	PRIESTESS_SWORD_TALK_7_1 = """— Elves have a... complicated relationship with the beastkin. They don't worship Freya, instead they worship Rundas. They don't quite respect nature and great trees as we do. They live in the wild, following their primal instincts. To be frank, we see them as hardly more than savages, but we have agreed to tolerate them, as long as they are secluded.""",
	PRIESTESS_SWORD_TALK_7_2 = """— I'm obviously not allowed to go just anywhere on my own, and I can't really send any of my regular soldiers on such a delicate mission. That's why I contacted you. Yes, for that matter, I will need you to stay quiet about this mission.""",
	PRIESTESS_SWORD_TALK_7_3 = """Erlon smiles for the first time in your talk.

— I'm glad to hear that. Here's the message I have prepared. I'll mark their location on your map. You should have little trouble getting there. Once you bring me their answer, I'll do what I can to persuade the High Priestess to help with your goal.""",
	CHIEFTAIN_MEETING_1 = """You manage to arrive at the tribe's settlement without any notable problems, in fact you were surprised to find that nobody stopped you on your way in. Most of the various beastkin and some halfkin walking around paid you little serious attention, though a few observed you closely and even made ambiguous gestures. 

You've noticed they seem unusually carefree and even frivolous, including the way they dress and talk. This notion was reinforced when a few times you've came across barely hidden couples having sex right out in the open in the middle of the day, and your appearance didn't seem to bother them. As you made your way past one such couple, an older beastkin woman called out to you.

— Aah, we have a new visitor. It's been a while since the last one. Do you require some help, perhaps?""",
	CHIEFTAIN_MEETING_1_OPTION_1 = "Who are you?",
	CHIEFTAIN_MEETING_1_OPTION_2 = "A new visitor?",
	CHIEFTAIN_MEETING_1_OPTION_3 = "I'm looking for the chieftain of the village",
	CHIEFTAIN_MEETING_2_1 = """— I'm Savra, the tribe's shaman. You can think of me as an elder who guides our younger kinsmen. """,
	CHIEFTAIN_MEETING_2_2 = """— Yes. Owing to the remoteness of our location, there are not many other settlements around here besides the elves, who don't think very highly of us. New visitors are a rare sight.""",
	CHIEFTAIN_MEETING_2_3 = """— Our Chieftain is Leon, you'll find him by the large hut near the cave. Now, if you'll excuse me, I have some business to attend to, we'll meet again later.""",
	CHIEFTAIN_MEETING_3_1 = """In a spacious hut you find Leon, the tribe's chieftain. 

— Greetings, traveler. I welcome you to the home of our tribe, as long as you stay civil and tolerant. We are happy to have to accept another among our kin, if this interests you.

— I have already heard that you were looking for me. We are ever-mindful of guests but if you have some sort of business to present I'm obliged to hear it.""",
	CHIEFTAIN_MEETING_3_2 = """In a spacious hut you find Leon, tribe's chieftain. 

— Greetings, traveler. I welcome you to the home of our tribe, as long as you stay civil and tolerant. You might not be of our kin, but you don't have to worry about your safety here.

— I have already heard that you were looking for me. We are ever-mindful of guests but if you have some sort of business to present I'm obliged to hear it.""",
	CHIEFTAIN_MEETING_3_OPTION_1 = "I have a message from the elves",
	CHIEFTAIN_MEETING_3_OPTION_2 = "Erlen sent me",
	CHIEFTAIN_MEETING_4 = """You pass Leon the sealed letter, which opens in his paws. As he reads through it, you notice how his face frowns, yet he remains silent until he finishes reading. After thinking it through, he finally speaks.

— I take it you will need my answer. I'm not sure what reason you have to travel here, but we have our needs too. You'll have to do something for us, then you'll get my answer.""",
	CHIEFTAIN_MEETING_4_OPTION_1 = "Why me?",
	CHIEFTAIN_MEETING_4_OPTION_2 = "What do you want?",
	CHIEFTAIN_MEETING_4_OPTION_3 = "I guess there's no choice",
	CHIEFTAIN_MEETING_5 = """— We have certain customs and rituals we are required to carry by Rundas. You are the first visitor in the last couple of months and you can help us with that. There's one ritual which we need an outsider to perform and if you wish to carry my answer back to the elves, I will require you to participate in it. It's nothing dangerous for you, in case you are concerned.

— Find Savra, she'll tell you the details, she must be already excited about your arrival.""",
	MAE_MEETING_1 = """As you enter the lodge, a young surprised tanuki girl appears before you, dressed in skimpy clothing. Her demeanor is unusually peculiar compared to the other villagers, though she is also visibly nervous.""",
	MAE_MEETING_1_1 = """— Ah! H-hello! I haven't seen you around before. You are an outsider, right?.. I mean, of course you are. U-hm, I'm Mae, pleased to meet you. You must be looking for Savra? She's in the far room. N-now, please, excuse me.

Before Mae finally leaves the room, she gives you another curious yet slightly frightened look. """,
	MAE_MEETING_2 = """— Hello, again, outsider. It's a pleasure to see a new visitor these days. I suspect you've been led here by the words of the long-eared. That matters little to me, as this is just another whim of the gods. The only question is if it's the whim of Rundas or not. And so far I tend to believe it is. Say, what do you think about us?""",
	MAE_MEETING_2_OPTION_1 = """I've seen some things on the way here...""",
	MAE_MEETING_2_OPTION_2 = """I haven't noticed anything unusual, if anything everyone should be as open""",
	MAE_MEETING_2_OPTION_3 = """I'm not too fond of this lifestyle""",
	MAE_MEETING_2_1 = """— You aren't too familiar with our customs. We are descended from Rundas, the creator of the wilds and animals. As his children, we accept the nature of consequenceless mating and love. Those who reach adolescence in this tribe learn the way of sharing their feelings with others through the language of the body. The new young are adopted and raised by the whole tribe.""",
	MAE_MEETING_2_1_OPTION_1 = """What about those who refuse?""",
	MAE_MEETING_2_1_OPTION_2 = """This is barbaric to me""",
	MAE_MEETING_2_1_OPTION_3 = """That's a nice custom""",
	MAE_MEETING_2_1_1 = """— They aren't forced to, naturally. They can even leave, though they'll have to make their way through the elven guards to make it to the less dangerous part of the continent. But this happens quite rarely.

— You've come at the right time, as the date of the annual ritual is approaching. Actually, I was waiting for someone like you.

— You have met Mae on the way here, haven't you? A nice pure city girl who joined us only a couple months ago. She'll make an ideal sacrifice for Rundas.""",
	MAE_MEETING_2_1_2 = """— I know that some outsiders often think that, but others don't seem to mind and even choose to participate. Though, there's been very few of you lately.

— You've come at the right time, as the date of the annual ritual is approaching. Actually, I was waiting for someone like you.

— You have met Mae on the way here, haven't you? A nice pure city girl who joined us only a couple months ago. She'll make an ideal sacrifice for Rundas.""",
	MAE_MEETING_2_1_3 = """— Then you should find our company pleasant. Not mine, though, I'm a bit out of shape as you can see.

— You've come at the right time, as the date of the annual ritual is approaching. Actually, I was waiting for someone like you.

— You have met Mae on the way here, haven't you? A nice pure city girl who joined us only a couple months ago. She'll make an ideal sacrifice for Rundas.""",
	MAE_MEETING_2_2AND3 = """— You've come at the right time, as the date of the annual ritual is approaching. Actually, I was waiting for someone like you.

— You have met Mae on the way here, haven't you? A nice pure city girl who joined us only a couple months ago. She'll make an ideal sacrifice for Rundas.""",
	MAE_MEETING_3_OPTION_1 = """Are you going to kill her?!""",
	MAE_MEETING_3_OPTION_2 = """What are you talking about?""",
	MAE_MEETING_3_OPTION_3 = """I'm not sure I need to know that""",
	MAE_MEETING_3_1 = """— Kill? No way. Do you really think of us as savages? She'll be going through shaman initiation. As my future successor, she'll have to copulate with an outsider — that will be your duty. 

— I've been teaching her to be the next shaman and I have high faith in her. For the next Rundas' medium, she has a good state of mind and a plump healthy body. Somewhat out of shape, but since she's not going to be a hunter, it's not a problem. 

— If she becomes pregnant it shall be a bountiful sign. A new blood nourished by the medium is invaluable for the tribe.""",
	MAE_MEETING_3_2AND3 = """— I've been teaching her to be the next shaman and I have high faith in her. For the next Rundas' medium, she has a good state of mind and a plump healthy body. Somewhat out of shape, but since she's not going to be a hunter, it's not a problem. 

— If she becomes pregnant it shall be a bountiful sign. A new blood nourished by the medium is invaluable for the tribe.""", 
	MAE_MEETING_3_1_OPTION_1 = "Copulate?",
	MAE_MEETING_3_1_OPTION_2 = "Is she really fine with this?",
	MAE_MEETING_3_1_OPTION_3 = "Why do you want me to do it?",
	MAE_MEETING_3_1_OPTION_4 = "Alright, I'll do it",
	MAE_MEETING_3_1_OPTION_5 = "I won't do this",
	MAE_MEETING_4_1 = """— Yes. She's going to have sex with a male outsider to become the next Rundas medium. Your energy will draw the blessing of Rundas to both of you and this is a requirement for a future Shaman. And, since it's her first time, it will make her offering even stronger.""",
	MAE_MEETING_4_2 = """— Naturally. You can talk to her if you wish. She's shy, but that's natural for someone of her age who still hasn't taken a single man. Given that she joined us willingly though, I'm certain her mind is already set.""",
	MAE_MEETING_4_3 = """— You are the only outsider we've welcomed to the village in months, and you do look like a strong male. There are no other requirements. I wish I was somewhat younger myself...""",
	MAE_MEETING_4_4 = """— Good, good. Leon will be pleased and we'll start the preparations. The end of this week will be perfect for the ritual. Visit me tomorrow and we'll settle on the details.""",
	MAE_MEETING_4_5 = """Savra grumps looking at you, but seeing you are not going to change your mind, she gives an exasperated sigh.

— Fine. I guess we can work something out some different way then. 

After pondering for some time she turns to you with her request.

— If you bring us enough supplies for a long time we can set a deal and I'll vouch for you for Leon. Bring us 2,000 Meat and Fish, with that we will have ample stores in reserve in case of misfortune.""",
	SAVRA_SUPPLIES_START = """""", # TODO add text. Savra greeting.
	SAVRA_SUPPLIES_START_OPTION = "I've brought the supplies you've asked for",
	SAVRA_SUPPLIES_1 = """— Woah, you really did. That's a lot of food for the tribe. You've kept your word and I'll keep mine, I'll vouch for your case, whatever it is. Shame we couldn't hold the ritual yet.""",
	SAVRA_RITUAL_START = """You enter Shaman's hut and find Savra at the same place, working on some herb mixtures. As she turns around as sees you, she waves at you.

— It's you, [name]. Good thing you came. I'm actually still in preparations right now. If you don't mind, you can go and help Mae, as she's currently gathering herbs outside of the village. I'll tell you where it is...""",
	SAVRA_RITUAL_START_OPTION_1 = "I'll go to her then",
	SAVRA_RITUAL_START_OPTION_2 = "Fine, I have to finish this sooner",
	PRE_RITUAL_1 = """You come to the spot where Mae should be, but you find no one. You thought it could be a wrong place, but after searching you find traces of a fight and a basket similar to those you've seen at settlement. 

Your attempt to track meets with little success. As you decide to return back and report on your findings, you hear a rustle from one of the nearby bushes. As you move closer, a small weasel quickly runs away from it. As you give a sigh and prepare to walk away, you notice that the small animal hasn't disappeared from sight as you would normally expect it to.

Somehow, it carefully looks at you without moving, as if requiring your attention. [color=lime]You must follow it.[/color] Without any good reason to follow it, you still decide to do it.""",
	PRE_RITUAL_2_1 = """As you follow the weasel through the forest, soon it brings you to its goal: a small human camp. A couple of cages and furniture make clear that it belongs to slavers. As you are scouting the camp, you realize that your guide has swiftly disappeared, but that doesn't bother you anymore, as in one of the cages you observe a familiar silhouette which likely belongs to the girl you are looking for.""",
	PRE_RITUAL_2_2 = """A couple of patrolling slavers went by your hiding spot.

{color=yellow|Slaver: — So far only one beastkin for a whole day. Shitty luck.

Slaver2: — At least she's young and fresh, will surely net us some gold.

Slaver: — Hmph, she's fat and weak. Can't even sell her for labor.}""",
	PRE_RITUAL_3 = """{color=yellow|Slaver2: — But she's kinda cute.

Slaver: — Only sick bastards like you would find her cute. By the way, don't you dare fuck her while we're sleeping, her virginity might be her only redeeming quality.

Slaver2: — Crap... I could do her in the ass instead then?}

The patrol have continued on their way, leaving you wondering what to do.""",
	PRE_RITUAL_3_OPTION_1 = """Try to deal with them""",
	PRE_RITUAL_3_OPTION_2 = """Sneak (Physics Check)""",
	PRE_RITUAL_3_OPTION_3 = """Attack""",
	PRE_RITUAL_4_1_1_100 = """You approach the patrolling slavers. Initially alarmed, you inform them you are interested in one of their freshly caught slaves. They seem rather pleased with an option to get some quick cash without having to do more work than needed. After negotiating for some time the slavers name their last price: 100 gold.

As they wait for you decision, you realize that if you can't agree a deal, they are not going to let you go away and tell on them....""",
	PRE_RITUAL_4_1_1_300 = """You approach the patrolling slavers. Initially alarmed, you inform them you are interested in one of their freshly caught slaves. They seem rather pleased with an option to get some quick cash without having to do more work than needed. After negotiating for some time the slavers name their last price: 300 gold.

As they wait for you decision, you realize that if you can't agree a deal, they are not going to let you go away and tell on them....""",
	PRE_RITUAL_4_1_1_500 = """You approach the patrolling slavers. Initially alarmed, you inform them you are interested in one of their freshly caught slaves. They seem rather pleased with an option to get some quick cash without having to do more work than needed. After negotiating for some time the slavers name their last price: 500 gold.

As they wait for you decision, you realize that if you can't agree a deal, they are not going to let you go away and tell on them....""",
	PRE_RITUAL_4_1_1_OPTION_1 = """Pay""",
	PRE_RITUAL_4_1_1_OPTION_2 = """Fight""",
	PRE_RITUAL_4_1_2 = """You pass the money to the smirking slavers as they bring you the captured girl. You decided not to tempt the fight and quickly lead her away from the camp.""",
	PRE_RITUAL_4_2_1 = """{color=green|Success}

You successfully sneak by the patrols and get to the cage with Mae in it. Fortunately, the keys to the cage are just a couple of feet away, allowing you to silently unlock it. Making as little sound as possible, you lead Mae away from the slavers' camp.""",
	PRE_RITUAL_4_2_2 = """{color=red|Failure}

As you try to sneak by the patrols, you trip on a tree root and fall on the ground, making a loud noise. As the slavers make their way towards you, you realize there's no option but to fight.""",
	PRE_RITUAL_4_3 = "You decide that there's no better option but to strike now before they know you are there. With that, you fiercely charge.",
	PRE_RITUAL_5 = """As you defeat the nearby slavers, you walk to the cage with Mae in it and get her out. Luckily, she seemed to be the only person who was caught so far. As you help her to regain her bearings, you decide to leave this camp before someone else shows up.""",
	PRE_RITUAL_6 = """As you get on the safer distance from the slavers' camp, Mae looks at you with a sight of reverence and relief. 

— Thank you. I was only gathering herbs when they came from behind and seized me. It was so scary... I dunno what could've happened to me if not for you. 

— I wonder if that's really some kind of fate that we...""",
	PRE_RITUAL_6_OPTION_1 = "I'm glad you are safe",
	PRE_RITUAL_6_OPTION_2 = "You should be more careful",
	PRE_RITUAL_6_OPTION_3 = "I think you could thank me for this (sexuals check)",
	PRE_RITUAL_6_OPTION_4 = "Don't mention it",
	PRE_RITUAL_7_1AND2AND4 = """— Y-yes. I'm really grateful. Now, I gotta collect the herbs we need again before we return, if you don't mind.""",
	PRE_RITUAL_7_1AND2AND4_BAD = """{color=red|Failure}

— Y-yes. I'm really grateful. Now, I gotta collect the herbs we need again before we return, if you don't mind.""",
	PRE_RITUAL_7_3_1 = """{color=green|Success}

As Mae realizes what you are suggesting, she gives you a nervous look. 

— It's not that I don't like you, but... I can't. I have to remain a virgin for the ritual, you must understand.""",
	PRE_RITUAL_7_3_1_OPTION_1 = "I can settle for a blowjob",
	PRE_RITUAL_7_3_1_OPTION_2 = "Use your mouth then",
	PRE_RITUAL_BLOW_1 = """— You did risk your life for me... Okay, I can do it. But, please, excuse my inexperience, I've never done this before.

You can feel Mae's nervous energy as she kneels before you, her soft fur brushing against your legs. She takes a deep breath before reaching for your belt, her fingers fumbling with the buckle. Finally, she manages to free your cock from its confines, and she gasps at the sight of it. You can't help but smirk at her reaction.

- Can... Can I touch it?""",
	PRE_RITUAL_BLOW_2 = """You nod, giving her permission to explore your hard, throbbing member. She wraps her fingers around it tentatively, and you can feel her gentle touch send shivers down your spine. You can't help but moan as she starts to stroke you, her touch growing bolder with each passing moment.

As she continues to pleasure you, you can't help but get lost in the sensation. Your eyes close, and you let out a soft sigh. But you know this isn't enough. You want more and ask her to show you her tits.""",
	PRE_RITUAL_BLOW_3 = """She pauses for a moment, a hint of nervousness in her eyes. But she knows what you want, and she slowly pulls her bra, revealing her ample, busty curves. You can't help but savor her luxurious chest. She's a little bit chubby, but that only makes her more attractive in your eyes.

As you continue to gaze at her, Mae takes the hint and lowers her head, taking your cock into her mouth. You moan as she begins to lick and suck, her tongue running over the length of your shaft. Even though it's likely her first time, she's surprisingly talented. You can feel yourself getting harder and harder, your body responding to her touch.

- Mmh, this is... Not as difficult as I imagined...""",
	PRE_RITUAL_BLOW_4 = """You reach out and run your hands over her soft fur, pulling her closer to you as she continues to pleasure you. And soon enough, you can't hold back any longer. With a final moan, you release your load all over her face, filling her mouth with your cum. 

She's slightly taken aback at first, but quickly recovers and licks her lips, savoring the taste of you. You stand up, feeling satisfied and fulfilled. Mae looks up at you with a hint of pride in her eyes, realizing that she's managed to satisfy your request. You clean up and continue on your way.""",
	PRE_RITUAL_7_3_3 = """— Thank you again. I hope you weren't disappointed? That was a bit scary at first, but I guess it's good practice. """,
	PRE_RITUAL_8 = """You help Mae to gather the required plants and you head back to the tribe. 

— So... uhm... You will be my Taker. You've come since you want to know me better? """,
	PRE_RITUAL_8_OPTION_1 = "You don't appear very local to me",
	PRE_RITUAL_8_OPTION_2 = "Are you okay doing this ritual?",
	PRE_RITUAL_8_OPTION_3 = "Let's go then",
	PRE_RITUAL_9_1 = """— I ran away from an empire town. After my parents died I would have soon become a slave. I heard about this tribe of people like me who would allow me to live with them. They were surprisingly friendly and accepting to me, and as you can see I have become the shaman's apprentice.

— I'm not entirely used to how open they are about... you know, but since they have never tried to force me, I think they want me to fully accept it by myself.""",
	PRE_RITUAL_9_2 = """— Yes, I've made up my mind to do what is required of me since the moment I arrived here. It just so happens you are going to become... m-my first. D-don't think I'm trying to say that I don't like you or anything! I think you are very brave and... at-attractive... 

Mae blushes and looks away realizing she might've said something embarrassing.""",
	PRE_RITUAL_10 = """As you are getting closer to the settlement, Mae stops in place.

— As tomorrow we gonna participate in a ritual, I want to ask you something. I don't wanna get pregnant, but there's little I can do. Before the ritual I'll have to drink a mixture which should dim my mind and make me more willing for my first time. This mixture helps initiates like me to have an easier time.

— But, it will also enhance my ovulation to the point even contraceptives won't stop me from getting pregnant. I have prepared a powder which will negate that effect, but I won't be able to reach it before the ritual. 

— You aren't going to stay here after the ritual, so it's nothing to you, but, please, do this for me, I'm too scared of becoming a mother yet. If you get an opportunity, just drop the powder into my bowl so no one sees it. 

You take the small pouch with powder Mae passes to you and put it away. As you enter the tribe Mae gives you a bow and leaves you for her delivery.""",
	RITUAL_START = """After the sun sets, the tribe lights some incense you haven't seen before. You realize that the familiar scent of aphrodisiacs is supposed to make everyone more relaxed and aroused, including you. """,
	RITUAL_START_OPTION_1 = "Put Mae's powder into bowl",
	RITUAL_START_OPTION_2 = "Don't put Mae's powder into bowl",
	RITUAL_1_1_GOOD = """— You've been quite curious about this bowl, haven't you? Why don't you move to the altar and prepare yourself, [name]? 

{color=green|Success}

Making sure nobody sees, you quickly drop the powder that Mae gave you into the bowl prepared for her.

You made your way to the altar placed in the center of the village, where you caught sight of the robed figure of Mae. She steadily makes her way to the bowl of brew, served to her by Savra.

After taking a breath, Mae brings the bowl to her face with both hands and forcefully gulps down its contents. You can't make out her expression as she closes her eyes, but once she's done you don't notice any visible look of disgust on her face.""",
	RITUAL_1_1_BAD = """— You've been quite curious about this bowl, haven't you? Why don't you move to the altar and prepare yourself, [name]?

{color=red|Failure}

It seems you've failed to spoil Mae's ritual drink and now will have to go through it. 

You made your way to the altar placed in the center of the village, where you caught sight of the robed figure of Mae. She steadily makes her way to the bowl of brew, served to her by Savra.

After taking a breath, Mae brings the bowl to her face with both hands and forcefully gulps down its contents. You can't make out her expression as she closes her eyes, but once she's done you don't notice any visible look of disgust on her face.""",
	RITUAL_1_2 = """You decided not to risk it and not do as she asked you. Perhaps you will be able to tell her you had no chance to do so later. 

You made your way to the altar placed in the center of the village, where you caught sight of the robed figure of Mae. She steadily makes her way to the bowl of brew, served to her by Savra.

After taking a breath, Mae brings the bowl to her face with both hands and forcefully gulps down its contents. You can't make out her expression as she closes her eyes, but once she's done you don't notice any visible look of disgust on her face.""",
	RITUAL_2 = """According to the rules of the ceremony, Mae loses her robe and lets it fall to the ground, revealing her fully naked body daubed with wide lines of the ritual paint. 

After a few moments her eyes become unfocused and her movements get sluggish. Before she can lose her balance, Savra catches her by the arm and leads to the altar. As Mae falls into your arms Savra contentedly retreats and invites you to do your part.

— [name]... I can't wait anymore...

Mae's voice is aimless, yet very sensual. As you help her to lay down before you, you start to notice the observing tribe members getting into making out with each other.""",
	RITUAL_3 = """Mae's slit is completely drenched, proving that she's fully ready to become a woman by your actions. The narcotic haze has completely removed any will to resist or escape from her, ideal for the ritual. A small trail of blood has painted the fur around her pussy red.

As you pummel into Mae's pussy, your field of view narrows and vision blurs, although you feel Mae in front of you keener than ever. You are the Taker this time, but it's not important. You want more power, and that's a noble thing, but not for everyone. Yet, power defines everything, and anyone accepting it will receive my blessing.""",
	RITUAL_4 = """Even though these people switched to less ferocious ways of living, their mating habits have so much life and power in it. Your dominance over this girl, and her acceptance of it makes both of you the perfect exemplars. Even more so as neither of you are natives. 

Fill it. Fill her womb with your seed. Have her accept it. Have her body experience it. This is what she was made for. This is what you were made for. The endless cycle of giving and taking...""",
	RITUAL_5 = """You raise speed, realizing you are getting closer to orgasm. Mae, despite looking lost in delirium, seems to quickly pick up on your intentions. Nothing distracts you anymore and you thrust for the last time, filling Mae with your hot seed, making her scream with pleasure.

However, this does not seem enough for either of you, and you resume moving again. Even though Mae shows some signs of exhaustion, she does not seem to be willing to stop either. As you continue working on the poor girl's sensitive pussy, a couple of the male beastkin approached you.

— Hey, you don't mind if we also do some bonding with our future shaman, do you?

You realize Mae wouldn't be able to answer anything coherent to this and turn your eyes to Savra.

— We'll do as you say, [name]. You are the Taker and we'll respect your decision.""",
	RITUAL_5_OPTION_1 = """Allow""",
	RITUAL_5_OPTION_2 = """Refuse""",
	RITUAL_6_1_1 = """A few beastkin males approach Mae from the head, presenting their erect cocks to her face. The formerly shy girl obediently takes hold of their members and begins to serve them with her mouth and hands like it was the most natural thing in the world.""",
	 RITUAL_6_1_2 = """As Mae's body was overwhelmed with every new orgasm, males at her top have also been made to cum by her, spraying over her head and breasts. New males replaced them, so that she was covered with more and more semen. However, this didn't bother her, as she hungrily sucked and served every new cock in turn.

— Her front is for the Taker only. If you really need to, you can use her ass.

Mae only gave another pleasant moan as her butt was penetrated for the first time. It felt like almost the whole adult male half of the tribe was served by her tonight...""",
	RITUAL_6_2 = """You decide that Mae wouldn't like things to go that far and reject the men's demand. The males look annoyed but retreat to find some comfort from other willing women. Despite Mae's delirious face, you can read some hints of gratitude from her, as you return to working on her quivering body. It feels like you spend the whole night doing this, until eventually your memory blacks out...""",
	AFTER_RITUAL_START = """Next morning you find yourself resting alone at one of the lodges. Judging from the sun it's already somewhat late and you decide to go outside. You are met by Leon and Savra, who seemed to be waiting for you. 

{color=yellow|Leon: — A fine performance, [name]. Hope you aren't too sore from last night.}

{color=aqua|Savra: — Yes, that indeed was very good. I feel that Rundas is greatly pleased by you and us. We'll be blessed for a long while.}""",
	AFTER_RITUAL_START_OPTION_1 = "How's Mae?",
	AFTER_RITUAL_START_OPTION_2 = "So you're gonna help me now?",
	AFTER_RITUAL_1_1 = """{color=aqua|Savra: — She's been resting after yesterday like you, but you seemed to be more experienced at such things. In case you're worried about her mental state, I can assure you she's all good. }

{color=yellow|Leon: — She's a darn fine woman. A great addition to the tribe with a good sense of responsibility.}""",
	AFTER_RITUAL_1_2 = """{color=yellow|Leon: — You've done your part of the deal, so I'll keep mine. I'll go prepare the response. You can visit me tomorrow to collect it.}""", 
	AFTER_RITUAL_2 = """Mae leaves the tent and after seeing you noticeably blushes. 

— ...G-good morning. Are you feeling well?""",
	AFTER_RITUAL_2_OPTION_1 = """Yes""",
	AFTER_RITUAL_2_OPTION_2 = """What about you?""",
	AFTER_RITUAL_3 = """— I'm still feeling a bit dizzy. Not remembering things very clearly from yesterday. At least I'm glad this is done with. """, 
	AFTER_RITUAL_3_OPTION_1 = "It was fun, wasn't it?",
	AFTER_RITUAL_3_OPTION_2 = "Yeah, good thing we are done with it",
	AFTER_RITUAL_3_OPTION_3 = "You did well for your first time",
	AFTER_RITUAL_4 = """— I feel like you've become very important to me just from these couple of days. After all, you've saved me from those slavers.""",
	AFTER_RITUAL_4_OPTION_1 = "My reward was worth it",
	AFTER_RITUAL_4_OPTION_2 = "You should watch out for yourself and not get caught next time",
	AFTER_RITUAL_4_OPTION_3 = "It's good nothing bad happened to you in the end",
	AFTER_RITUAL_4_OPTION_4 = "You can't deny It was an unusual experience",
	AFTER_RITUAL_5_1 = """— Hope that wasn't the only reason you saved me, though.""",
	AFTER_RITUAL_5_2AND3 = """— Y-yeah, I guess I'm still kinda clumsy about such things. Thanks again. """,
	AFTER_RITUAL_5_4 = """— Heh, I guess you could say that, yeah. Not sure I'd like to be in that situation again, though.""",
	AFTER_RITUAL_GROUP_1 = """— During the ritual... I remember that you allowed others to use me, while I was in trance. I can't believe you did something like that, and during my first time too.""",
	AFTER_RITUAL_GROUP_1_OPTION_1 = "But you seemed to quite enjoy it",
	AFTER_RITUAL_GROUP_1_OPTION_2 = "That was a worthy experience for your new position",
	AFTER_RITUAL_GROUP_1_OPTION_3 = "I couldn't reject such a sincere requests",
	AFTER_RITUAL_GROUP_1_OPTION_4 = "It's a crime to keep your body from others",
	AFTER_RITUAL_GROUP_2_1 = """— T-that's only because I wasn't thinking straight and you know it! The only reason I'm not dying from shame is that I hardly recall anything that happened.""",
	AFTER_RITUAL_GROUP_2_2 = """— That's not something for you to decide, I surely could do it without such experience.""",
	AFTER_RITUAL_GROUP_2_3 = """— Hmph, my friend was right, you men are all the same, can't be trusted with any decency. """,
	AFTER_RITUAL_GROUP_2_4 = """Mae makes a long pause trying to approach your words, but it seems your flattery has calmed her distress.

— E-even if you say so, that's not something you should do with a girl without her consent. """,
	AFTER_RITUAL_GROUP_2_OPTION_1 = "I'm sorry, let's just forget it",
	AFTER_RITUAL_GROUP_2_OPTION_2 = "But you seemed to enjoy it...",
	AFTER_RITUAL_GROUP_3_1 = """— Okay, let's forget it.""",
	AFTER_RITUAL_GROUP_3_2 = """— T-that was unusual for me. I never imagined something like this would happen, but now that I think about it... Nevermind! Let's just forget it, okay?""",
	AFTER_RITUAL_POWDER_1 = """— Savra said I got pregnant and we both can feel it... Why didn't you add a neutralizer to the mixture as I asked you? I really begged you. I'm not ready to become a mother.""",
	AFTER_RITUAL_POWDER_1_OPTION_1 = "Well there's not much we can do about it now",
	AFTER_RITUAL_POWDER_1_OPTION_2 = "I had no good opportunity to do it, so it's hardly my fault",
	AFTER_RITUAL_POWDER_1_OPTION_3 = "We should take care of our future child now",
	AFTER_RITUAL_POWDER_1_OPTION_4 = "I just really wanted to knock you up with my child",
	AFTER_RITUAL_POWDER_2_1AND2AND4 = """Mae sighs in exasperation as if she knows she shouldn't have trusted you in the first place. 

— ...Forget it. """,
	AFTER_RITUAL_POWDER_2_3 = """Mae gives you a puzzled look, as if trying to measure how reliable your words are. 

— W-well, yeah. I guess that's what we should do now once it's born. I hope you are not going to leave me completely alone then?.. Thanks. """,
	AFTER_RITUAL_6 = """— Say, I never really asked, but what are you actually doing? What do you plan to do from now on?""",
	AFTER_RITUAL_6_OPTION_1 = "I have an important state mission to fulfill",
	AFTER_RITUAL_6_OPTION_2 = "I'm just an adventurer with some extra entitlement",
	AFTER_RITUAL_6_OPTION_3 = "I'm probably on a mission to save the world",
	AFTER_RITUAL_6_OPTION_4 = "I just go where I have to and do what I must",
	AFTER_RITUAL_GOOD_1 = """— Y-you know, I wish I would be able to join you for some more time. Not that I dislike it here, but... I guess I feel like that because of yesterday's thing.""",
	AFTER_RITUAL_GOOD_1_OPTION_1 = "Your company would certainly be appreciated",
	AFTER_RITUAL_GOOD_1_OPTION_2 = "I can't really take you with me",
	AFTER_RITUAL_GOOD_2_1_1 = """A flicker of excitement jumps across Mae's face which goes away as she looks down.

— B-but that's... I'm not sure if I'll be able to leave here now. """,
	AFTER_RITUAL_GOOD_2_1_2 = """{color=aqua|Savra: — No, it's fine, it might be a good thing for you to go out and get more experience with the outer world. }

{color=aqua|Mae: — Really? I thought I was gonna be a complete tribe's shaman now.}

{color=yellow|Savra: — Don't be silly, I'm still alive and kicking, you know. Go out and have fun with [name], I'm sure [he]'s a great match for you.}

Mae blushes severely thinking of all that happened just yesterday, but nods in agreement.

{color=aqua|Mae: — Uhm... Please take care of me.}""",
	AFTER_RITUAL_GOOD_2_2 = "— Right, and I have to be a tribe's shaman now. Still, thank you for this. Hope you'll visit us again.",
	AFTER_RITUAL_BAD_1_1 = """— Well, it was nice to meet you, and thanks again for treating me kindly. Maybe you'll come again at some time.""",
	AFTER_RITUAL_BAD_1_2 = """— Well, it was nice to meet you, and thanks again for treating me kindly. Maybe you'll come again at some time.

— Don't forget that your child will be here.""",
	LEON_VISIT_START = """You enter the chieftain's hut but Leon is nowhere to be found. You decide to find Savra to figure out where he went.""",
	LEON_VISIT_1_1 = """— Leon's missing? That is unlike him. I haven't seen him since yesterday evening but maybe you should ask around. """,
	LEON_VISIT_1_2 = """You should search for Leon as it seems he's gone missing.""",
	ASK_AROUND = """You ask a few watchmen if they've seen Leon, and one of them says that he saw Leon leave slightly before the sunrise. After learning the direction he supposedly went to, you mark the location on your map.""",
	LEON_FIGHT_1 = """As you search through the area, you come across some fresh tracks. After calling out, you detect some movements short in front of you. As you approach the bush, Leon jumps on you as if you were his prey. In the spur of the moment you barely manage to block his attack with your weapon.""",
	LEON_FIGHT_1_OPTION_1 = "*Yell at him*",
	LEON_FIGHT_1_OPTION_2 = "*Push forward*",
	LEON_FIGHT_2_1 = """Leon completely ignores your words and keeps pushing forward with animalistic frenzy. As you struggle against him, you see no flicker of conscience on his face. Finally you manage to break away from him, but the fight is not over...""",
	LEON_FIGHT_2_2 = """Despite your best efforts you can't hope to move him by even an inch. As you struggle against him, you see no flicker of conscience on his face. Finally you manage to break away from him, but the fight is not over...""",
	LEON_FIGHT_3 = """After getting the best of him, you notice that Leon seems considerably exhausted and is panting heavily. To your surprise, he seems to regain some of his personality as he mumbles some words.

— [name]... Tell Savra... The White Stag.. Has... 

Before finishing the line he seemed to return to his savage state and quickly escaped into the woods. There's little hope in catching him now so you decide to return to Savra.""",
	SAVRA_TALK = """— You are back? Do you need something from me?""",
	SAVRA_TALK_OPTION_1 = """About Leon...""",
	SAVRA_TALK_1 = """Savra listens to your story as her mood grows gloomy. 

— So that's what happened... This is a problem. We'll have to save Leon, for which we're gonna need to prepare for the ritual to free his mind. I'll ask you to prepare some materials for it. """,
	SAVRA_TALK_1_OPTION_1 = "What's going on?",
	SAVRA_TALK_1_OPTION_2 = "What materials do you need?",
	SAVRA_TALK_2_1 = """— The White Stag is a magical beast which appears in our lands every few years. When it's here, it drives people crazy, making them go into the wilderness and become beasts themselves. Usually it affects the weak but this time our chieftain was cursed of all people. Until he's back I'll be leading in his role.""",
	SAVRA_TALK_2_2 = """— Saving someone from the Stag's curse isn't easy until it's defeated. Here's the list of the stuff I'll require, don't take too long. 

Savra passes you a small parchment with the ingredients.

— 50 Magic Wood
— 25 Iron Wood
— 15 Mythic Leather""",
	SAVRA_TALK_2_OPTION_1 = "Seems easy enough",
	SAVRA_TALK_2_OPTION_2 = "That might take some time",
	SAVRA_TALK_2_OPTION_3 = "I better get to it then",
	SAVRA_TALK_3 = """— Very well, visit me again once you have it. Oh, and one more thing. I'll need someone with decent magical powers to help. Someone with a high magic affinity. Find someone suitable for it.""",
	SAVRA_TALK_OPTION_2 = "I've brought the ingredients",
	SAVRA_TALK_4 = "— Good, good, talk to me again once you have someone for the ritual.",
	SAVRA_TALK_OPTION_3 = "I've brought the suitable helper",
	SAVRA_TALK_5 = "— Yes, this is very good. Let's not waste any time then, we'll start the ritual.",
	SAVRA_TALK_6 = """After about two hours Savra and [name] come out of the sealed ritual hut and Savra passes you a carven wooden figure vaguely resembling Leon but with large horns on its head. As you look closer, you notice a faint glow coming from it, but after breaking the gaze it's no longer there.

— It is done. Here's the totem. Now you'll have to find Leon and this should clear his mind from the curse. """,
	SAVRA_TALK_6_OPTION_1 = "Can't you do it yourself?",
	SAVRA_TALK_6_OPTION_2 = "How exactly does this work?",
	SAVRA_TALK_6_OPTION_3 = "I'll get to it",
	SAVRA_TALK_7_1 = """— No, as I said, I must act in place of a chieftain as the current one is missing. I trust you to deal with it.""",
	SAVRA_TALK_7_2 = """— Find Leon, bring the totem to him. The rest will be obvious.""",
	LEON_ENCOUNTER_START = """As you were actively searching for Leon this time you manage to find him before he spots you. You spring at him, preparing for a fight.""",
	LEON_ENCOUNTER_1 = """Before Leon manages to escape once again, you pull out the totem and it shines your hand. A bright flash blinds you as it disappears and Leon falls on the ground. You decide to carry him back to the tribe without further delay.""",
	LEON_ENCOUNTER_2 = """A few hours pass after you deliver the unconscious Leon to Savra. Finally he emerges,looking more lively than you'd expect.

 — I wish I could properly thank you for my rescue, [name], but I'm afraid, as we speak, the White Stag threatens the very wellbeing of the tribe, meaning we can't waste any time. Until this is dealt with I can't give you a final answer to the question you came here with. """,
	LEON_ENCOUNTER_2_OPTION_1 = "So what are you planning to do now?",
	LEON_ENCOUNTER_2_OPTION_2 = "Is there anything I can help with?",
	LEON_ENCOUNTER_3 = """ — We are going to hunt the stag and kill it, like we always did in the past. It's a dangerous activity, but that's what we do. I can't ask for your help, but this issue must be taken care of.""",
	LEON_ENCOUNTER_3_OPTION_1 = "What are you planning?",
	LEON_ENCOUNTER_3_OPTION_2 = "I'll let you a hand",
	LEON_ENCOUNTER_3_OPTION_3 = "This sounds like it could be fun",
	LEON_ENCOUNTER_4_1 = """ — We'll set up a hunting party with the most experienced hunters and warriors to track and defeat the stag. It's not my first time hunting it, though it did slow us down. It's painful to admit I was taken by its curse.""",
	LEON_ENCOUNTER_4_2 = """ — It'll be an honor to have your help. You must understand that this is not a normal skirmish or hunt. The White Stag is a beast unlike any other. Not only is it able to induce madness by its mere presence, it possesses other fearsome powers. You can ask Savra about them, she could explain it better than me.

 — Meet us in the wilds, where we begin the hunt.""",
	SAVRA_STAG_QUESTION = """Ask about the White Stag""",
	SAVRA_STAG_ANSWER = """ — White Stag is a being of mysterious nature. Even though we consider it evil I'm more inclined to believe for it to be a challenge. Rundas must be testing our strength hence why it was never really defeated. As a spiritual leader I can't ignore my duty and ask you to show it at least some respect. """,
	WHITE_STAG_ENCOUNTER_1 = """You come to the previously established location and find a fairly large group of beastkin, ready for the hunt. Standing off to the side you spot Leon and call out to him.

 — You've come at a good time, we are ready to follow its trail. Look here.

Leon points at a small trampled bush. On a closer look you notice a faint glow coming from it. 

 — Must have been about an hour at most.""",
	WHITE_STAG_ENCOUNTER_1_OPTION_1 = "You seem to know your trade",
	WHITE_STAG_ENCOUNTER_1_OPTION_2 = "Let's not waste any time then",
	WHITE_STAG_ENCOUNTER_2_1 = """ — Three years ago I faced the beast before. That's my duty as a chieftain, and so I must carry it out. We should move now.""",
	WHITE_STAG_ENCOUNTER_2_2 = """Leon nods and you move out. """,
	WHITE_STAG_ENCOUNTER_3 = """After about a half hour of scouting you find the clearing enveloped in a thick gray mist, unusual for the current time of a day. Beastkin hunters slowly encircle it. You enter the mist and carefully move forward in eerie silence as all other sound seems to fade away from the surrounding forest.

Before you realize that Leon is yelling at you to be careful, you see the beast which you have been looking for: a majestic yet alien and ominous White Stag, looking right into your eyes, as time seems to grind to a halt.""",
	WHITE_STAG_ENCOUNTER_3_OPTION_1 = "Try moving",
	WHITE_STAG_ENCOUNTER_3_OPTION_2 = "Call for help",
	WHITE_STAG_ENCOUNTER_4 = """Feeling lost in the beast's aura, you are unable to do anything. You realize you don't know where you are, and a figure materializes before you.

 — So you are the one, They call [name].""",
	WHITE_STAG_ENCOUNTER_4_OPTION_1 = "*Stay Silent*",
	WHITE_STAG_ENCOUNTER_4_OPTION_2 = "What's going on here..?",
	WHITE_STAG_ENCOUNTER_5 = """ — A mortal stranger like you dares to stick their nose into this realm. How despicable. Have you no fear for your life? What have you come here for?""",
	WHITE_STAG_ENCOUNTER_5_OPTION_1 = "I'm only here to get to the elven high priestess",
	WHITE_STAG_ENCOUNTER_5_OPTION_2 = "I came to help these lands",
	WHITE_STAG_ENCOUNTER_5_OPTION_3 = "That's none of your business, demon",
	WHITE_STAG_ENCOUNTER_6_1 = """ — Preposterous. How has Freya not smitten your foul body yet?

Your mere presence defiles these grounds and all traces of it must be annihilated. Then we can return to our confrontation once again.""",
	WHITE_STAG_ENCOUNTER_6_2 = """ — Help? There's nothing to help here.

Your mere presence defiles these grounds and all traces of it must be annihilated. Then we can return to our confrontation once again.""",
	WHITE_STAG_ENCOUNTER_6_3 = " — You dare to call me a Demon? Clearly you are out of your mind. Futile. I'll not only take your life, but your very soul will be trampled. We will see what is left of it when I am done.",
	WHITE_STAG_ENCOUNTER_6_OPTION_1 = "I won't let you kill me",
	WHITE_STAG_ENCOUNTER_6_OPTION_2 = "It's you who will die here",
	WHITE_STAG_ENCOUNTER_6_OPTION_3 = "Maybe we shouldn't be in so much of a hurry",
	WHITE_STAG_ENCOUNTER_7_1AND2 = """You prepare yourself as best you can for the upcoming challenge. It seems the White Stag is going to keep you in this realm until one of you dies. With no help from Leon or others, this will be a tough fight.""",
	WHITE_STAG_ENCOUNTER_7_3 = """ — What are you trying to tell us? Are you shivering in fear?""",
	WHITE_STAG_ENCOUNTER_7_OPTION_1 = "I have an important mission to finish",
	WHITE_STAG_ENCOUNTER_7_OPTION_2 = "We could settle this in a more civil way",
	WHITE_STAG_ENCOUNTER_7_OPTION_3 = "I just can't stop adoring your majesty right now",
	WHITE_STAG_ENCOUNTER_7_OPTION_4 = "I could just leave in peace",
	WHITE_STAG_ENCOUNTER_8_1AND2AND4 = """ — Enough of your childish games. Now you will pay for your insolence!""",
	WHITE_STAG_ENCOUNTER_8_3 = """The deer woman takes an unusually long pause. You can't read her emotions until she finally replies back.

 — Your admiration is understandable, but your empty words are not going to earn my pardon.""",
	WHITE_STAG_ENCOUNTER_8_3_OPTION_1 = "Maybe I could prove my sincerity",
	WHITE_STAG_ENCOUNTER_8_3_OPTION_2 = "I would kill to have a woman like you",
	WHITE_STAG_ENCOUNTER_8_3_OPTION_3 = "Maybe we could strike some mutual agreement?",
	WHITE_STAG_ENCOUNTER_9_2AND3 = """ — Hmph. You have had your chance and wasted it. Let us finish this now.""",
	WHITE_STAG_ENCOUNTER_9_1 = """ — Really, now. What could a mortal possibly do that would interest me?""",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_1 = "I can smith your image into a beautiful piece of jewelry (Smith)",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_2 = "I want to dedicate a song to you (Bard)",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_3 = "I will slay any foe or beast you request (Knight)",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_4 = "...",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_5 = "I'm... not sure how I could do that",
	WHITE_STAG_ENCOUNTER_10_4 = """You notice that Zephyra is willing to lend you a hand in this situation.

{color=aqua|Zephyra: — Ah, yes, I can make a fine painting which will reflect on your godlike nature.}""",
	WHITE_STAG_ENCOUNTER_10_1AND2AND3AND4 = """ — Hmmh. Very well, mortal, I feel the sincerity in your words. This time you get to keep your soul. That said, there is still one more score left to settle, while I'm here. We will meet again.""",
	WHITE_STAG_ENCOUNTER_10_5_1 = """ — Hmph. You have had your chance and wasted it. Let us finish this now.""",
	WHITE_STAG_ENCOUNTER_10_5_2 = """ — Kh... You are not so bad for mortals. Fine, this time you will be permitted to live, as we are running out of time. 

Before you are able to answer, the woman's figure is enveloped in a bright light, blinding you.""",
	WHITE_STAG_ENCOUNTER_11 = """As the mist disperses, you find yourself returned to the familiar woods. You see the White Stag back in its animal form as the battle with the tribe begins.""",
	WHITE_STAG_ENCOUNTER_12 = " — Now, don't let it get away! You too, [name], prepare for a fierce fight.",
	WHITE_STAG_ENCOUNTER_13 = """With your combined efforts you've dealt enough damage to the White Stag. With a deafening scream its form slowly vanishes in the air. Seeing this, Leon and his party roar in triumph. Once again the tribe has triumphed over the threat...""",
	WHITE_STAG_ENCOUNTER_14 = """You return to the tribe's settlement and after getting some rest met with Leon once again.

{color=yellow|Leon: — A mighty fight, [name]. We can't praise you enough for your work, but there's a reason why you came in first place. Here's my answer to the elves for the question you've been required to deliver. Because of their magic you won't be able to read it though. }

{color=aqua|Savra: — Drop by sometime in future, your visit will be welcome.}""",
	PRIESTESS_TALK_START = """You go to Erlen's quarters but find it locked. As you make it through the hallway, one attendant comes to you and asks you to follow her to meet the high priestess at her quarters. As there's no better option apparent, you follow her obediently.""",
	PRIESTESS_TALK_1 = """As you enter the room, you notice that the High Priestess seems to be more friendly than usual, though only barely. 

 — [name], correct? It's a good thing you've dropped by. I have heard you went to the beastkin tribe for some reason. Not that we forbid such activity, but it makes me curious to know what would lead you to go there.""",
	PRIESTESS_TALK_1_OPTION_1 = "I'm only an adventurer, I was curious about such a place",
	PRIESTESS_TALK_1_OPTION_2 = "Erlen asked me to deliver something",
	PRIESTESS_TALK_1_OPTION_3 = "I can't really disclose it",
	PRIESTESS_TALK_2_1 = """ — Oh, is that so? I had not considered that any cultured person would be interested in those savages. 

 — You are an outsider so you might not be fully aware of how things are in our lands. As the chosen of Freya, I am honored with the duty of keeping our people in peace and order by providing everyone their rightful place. The Mother's laws are absolute to us, and despite my status even I am not able to challenge them.

 — But, let's get down to why you are here. You have proven yourself to be an unusual individual and I have a personal task for you while you are waiting for Erlen. I want you to go to the ancient temple and fetch us some holy water for the upcoming ceremony. Usually this challenge would be done by our army leader, but as you can see, he's not currently around.""",
	PRIESTESS_TALK_2_2 = """ — That's so? Well, that's not of my concern then. 

 — You are an outsider so you might not be fully aware of how things are in our lands. As the chosen of Freya, I am honored with the duty of keeping our people in peace and order by providing everyone their rightful place. The Mother's laws are absolute to us, and despite my status even I am not able to challenge them.

 — But, let's get down to why you are here. You have proven yourself to be an unusual individual and I have a personal task for you while you are waiting for Erlen. I want you to go to the ancient temple and fetch us some holy water for the upcoming ceremony. Usually this challenge would be done by our army's leader, but as you can see, he's not currently around.""",
	PRIESTESS_TALK_2_3 = """The High Priestess frowns, but quickly changes her expression as it is of no real interest to her.

 — You are an outsider so you might not be fully aware of how things are in our lands. As the chosen of Freya, I am honored with the duty of keeping our people in peace and order by providing everyone their rightful place. The Mother's laws are absolute to us, and despite my status even I am not able to challenge them.

 — But, let's get down to why you are here. You have proven yourself to be an unusual individual and I have a personal task for you while you are waiting for Erlen. I want you to go to the ancient temple and fetch us some holy water for the upcoming ceremony. Usually this challenge would be done by our army's leader, but as you can see, he's not currently around.""",
	PRIESTESS_TALK_2_OPTION_1 = "Why are you asking me now?",
	PRIESTESS_TALK_2_OPTION_2 = "What is this ceremony you need the holy water for?",
	PRIESTESS_TALK_2_OPTION_3 = "What's in it for me?",
	PRIESTESS_TALK_3_1 = """ — As I said, you have proven yourself very adventurous, have you not? Only a very few select elves are allowed to go there. As a stranger to these lands, such a restriction would not apply to you.""",
	PRIESTESS_TALK_3_2 = """ — As an outsider, this is nothing you should really care about. It's a regular ritual which we have to perform in Freya's name.

 — Here is the phial which will grant you access to the inside of the temple. You will use it to deliver the water in. It is not far from here, so once you are back we can settle on whatever demands you had. """,
	PRIESTESS_TALK_3_3 = """ — Ah, silly me, I had almost forgotten. I have been thinking about what you said before. There might be a tiny lick of sense in that. I think we can come to an agreement on your access to the Sacred Bowl if you do this for me. This is your goal, is it not? 

 — Here is the phial which will grant you access to the inside of the temple. You will use it to deliver the water in. It is not far from here, so once you are back we can settle on whatever demands you had.""",
	PRIESTESS_TALK_3_OPTION_1 = "This shall be an honor for me",
	PRIESTESS_TALK_3_OPTION_2 = "Fine, if you keep your end of bargain",
	TEMPLE_START = """You come to the place you were told about by the High Priestess and after searching around you manage to find a ruined entrance to the supposed temple. However, it is blocked by a large stone slate. It seems you will need someone exceptionally powerful to move it...""",
	TEMPLE_START_OPTION_1 = "Attempt to move",
	TEMPLE_START_OPTION_2 = "Use Acid Bomb",
	TEMPLE_START_OPTION_3 = "Leave",
	TEMPLE_1_1_1 = """[name] uses [his] strength and pushes the slate out of the way, allowing you to move into the temple.""",
	TEMPLE_1_1_2 = """You apply your muscles to the slate and it slowly moves away, allowing you pass through.""",
	TEMPLE_1_2 = """You throw an unstable catalyst at the slate and it melts the stone away to the point you are able to pass through. It might prevent the stone from keeping out other intruders in future, but it's too late to think about that now.""",
	TEMPLE_2_1 = """As you walk into the large hall, you hear the sound of a group approaching the entrance. The group looks familiar to you, but they don't seem to recognize you. 
	
Small Bandit: — Look boss, this fools have opened it for us.

Fat Bandit: — These guys look kinda familiar...

Boss: — Shut it you idiots. Greetings, stranger. This is quite a place you've found here. How about you let us take some of the things inside? Collectors will pay a good price for ancient elven art and stuff. Say, 1,000 gold and you let us take whatever you leave behind?""",
	TEMPLE_2_2 = """As you walk into the large hall, you hear the sound of a group approaching the entrance. The group looks familiar to you, but they don't seem to recognize you. 
	
Small Bandit: — Look boss, this fools have opened it for us.

Fat Bandit: — These guys look kinda familiar...

Boss: — Shut it you idiots. Greetings, stranger. This is quite a place you've found here. How about you let us take some of the things inside? Collectors will pay a good price for ancient elven art and stuff. Say, 1,000 gold and you let us take whatever you leave behind?

Aire: — This isn't right, you can't just let anyone vandalize sacred places like this.""",
	TEMPLE_2_OPTION_1 = "Deal",
	TEMPLE_2_OPTION_2 = "Treasure like this should certainly be worth more than that (Charm Factor Check)",
	TEMPLE_2_OPTION_3 = "No deal",
	TEMPLE_3_1_1 = """{color=green|Success}
Small Bandit: — You are kidding, right?

Boss: — Hmh, fine, I guess we can pay you 1,500 gold in this case, but this is our final """,
	TEMPLE_3_1_2 = """ {color=red|Failure}

Boss: — No can do, pal, we aren't that rich yet. A thousand is a good price for this already.""",
	TEMPLE_3_2 = """Boss: — That's too bad. We aren't going to let this chance slip by. Get 'em, boys. 

The group draws their weapons and prepare for a fight.""",
	TEMPLE_4_1 = """Aire gives you a big frown but does not dare to say anything.

The leader of the bandits smiles pleasantly. 

Boss: — Good, very good. Here you can have this gold as promised. I'm sure this place is a treasure in itself.

He passes you the large sum of gold and you part ways, moving forward into the temple.""",
	TEMPLE_4_2 = """The leader of the bandits smiles pleasantly. 

Boss: — Good, very good. Here you can have this gold as promised. I'm sure this place is a treasure in itself.

He passes you the large sum of gold and you part ways, moving forward into the temple.""",
	TEMPLE_5 = """Boss: — Damn you, bastards. You win this time!
	
As you make them flee from the scene, you can safely advance deeper into temple.""",
	TEMPLE_6_1 = """Walking through the ancient temple with its walls lying in ruins, you end up before a set of large doors which seem to be what you are looking for. However, as you get closer, a group of specters resembling elven soldiers appear before you and speak some unknown language. It seems to be either another trial or a defense system.""",
	TEMPLE_6_2 = """Walking through the ancient temple with its walls lying in ruins, you end up before a set of large doors which seem to be what you are looking for. However, as you get closer, a group of specters resembling elven soldiers appear before you and speak some unknown language. It seems to be either another trial or a defense system.

 — Hold on, these guardians must be summoned by some energy source...

Aire searches the surroundings for some time until she finally spots a lone crystal on the ceiling. With a well landed shot she breaks the crystal and the elven specters disappear from sight.""",
	TEMPLE_6_2_OPTION_1 = "Nice work, Aire",
	TEMPLE_6_2_OPTION_2 = "Next time ask me before doing it",
	TEMPLE_7_1 = """ — It's nothing special, I've come across similar things in the past. Makes me a bit worried that this place is not going to be protected anymore.""",
	TEMPLE_7_2 = """ — ...Sorry. I didn't think this through. We can pass safely now anyway.""",
	TEMPLE_8 = """You enter a small room with an ancient elven altar at the center, which is seemingly intact. The water flows down upon it from above, disappearing under the cracks of the floor. You scoop some of the water up with the bottle provided by the High Priestess and leave the place.""",
	AFTER_TEMPLE_PRIESTESS_1 = " — Yes? Did you bring what I asked for?",
	AFTER_TEMPLE_PRIESTESS_1_OPTION_1 = "No",
	AFTER_TEMPLE_PRIESTESS_2 = " — Then you shouldn't test my patience. Return, once you have it..",
	AFTER_TEMPLE_PRIESTESS_3 = """The priestess accepts your request unexpectedly quickly. As you make it into her chambers, she looks nearly blissful as you pass her the filled phial of holy water.

 — You have actually done it, [name]. Exceptional work, for an outsider... I guess I am no longer allowed to call you a simple outsider, am I? Speaking of which, my true name is Heleviel, which you are now allowed to use. At last we can finally hold the ceremony... """,
	AFTER_TEMPLE_PRIESTESS_3_OPTION_1 = "What about our agreement?",
	AFTER_TEMPLE_PRIESTESS_3_OPTION_2 = "I believe you owe me something",
	AFTER_TEMPLE_PRIESTESS_4 = """ — Yes, indeed, I have not forgotten, but the ceremony is currently of a higher priority for us. Once it's done, I swear on Freya's honor to help out with your task. Until then, you should see yourself as my honored guest. """,
	AFTER_TEMPLE_PRIESTESS_4_OPTION_1 = "Maybe you could thank me in some other way until then",
	AFTER_TEMPLE_PRIESTESS_4_OPTION_2 = "I guess I have no other choice",
	AFTER_TEMPLE_PRIESTESS_4_OPTION_3 = "I'll wait until then",
	AFTER_TEMPLE_PRIESTESS_5_1_1 = """Heleviel gives you a more intimate look as she appraises your appearance, after which her face brightens with a rare faint smile.

 — You know, maybe I could. You know, Freya's high priestess is not allowed to be tainted by man's touch, so if you were a male, I'd have to refuse. But with no men here...

Heleviel seductively moves to the fine bed while she keeps her eyes on you. Slowly, she removes her elegant dress.""",
	AFTER_TEMPLE_PRIESTESS_5_1_2 = """— Does it make you happy that you'll get what many men can only dream of? Come, take your reward.
	
	Not one to pass up such an opportunity you do indeed take your reward. Realizing as you slide up onto the bed how soft it is, impressed, only to be impressed more as you make contact with her. Her skin is soft, a soft silken touch only possible by those far from the rigorous labors you endure. 
	
	You take your time moving up her, hands sliding up her hips as you give into temptation, your face sliding over her hip, a soft nuzzle of the skin before lightly biting at the skin. Heleviel's response to your nibbling is less than enthused, a glare being shot your way before she spoke.""",
	AFTER_TEMPLE_PRIESTESS_5_1_3 = """— Do not mark me.

	Her rebuke showed no anger, only a single determined remark showing an expectation that it'd be obeyed. With that "order" in mind you still bite at her, though only light enough to cause her to jolt and again attempt a rebuke, only for it to be lost amidst a soft groan once you found her throat. Her skin was delicious, a soft texture with a honeyed scent. After a time with her neck you would slide up further onto the bed knee resting between her thighs as you pull her closer.

	Now entwined the two of you press, thighs rubbing as you continue to sample the skin of her neck and shoulders, rewarded by her nails marking your back and shoulders, and occasional deep mark due to a particularly well positioned grind causing her to seize up. For her credit you also end up failing at her “order" of not marking her a few times due to her doing the same to you.

— I-I said!-""", 
	AFTER_TEMPLE_PRIESTESS_5_1_4 = """You cut off her protests by taking her lips with your own, the elf shaking now as your hands slide up from her hips to her breast, a soft rubbing followed by a single finger sliding over her nipple soon causing that attention to occupy her mind, not anything else.

	Minutes later the kiss is broken to you both panting, your mouth traveling down her as you explore, tasting along her until she's lifted higher upon the bed, her knees lifted to your shoulders as you look up at her now, A few moments of anticipation are awarded with a soft pleasure as you start to slowly glide your tongue over the elven woman's entrance, not spreading her petals yet, your tongue only tracing the edges of her smooth womanhood.

	Heleviel for her part in this regained her composure quickly, her face still flushed as she looked down at you in thought; what thoughts you'd never know but the moment your tongue slipped between her lips and found her sensitive clit the sounds and looks she made were of pure pleasure. A few moments of tasting her soon turned into nuzzling her inner leg again, a soft nip following before you resumed your gathering of your reward.
""", 
	AFTER_TEMPLE_PRIESTESS_5_1_5 = """Heleviel's composure to her credit was kept for some time, her hips shaking as she would look down at you with as much dignity as was normally plastered on her face, though a shadow of pleasure hung over her eyes. The secrets to driving her on weren't difficult to find, but her reactions were subtle until you glided your tongue directly over her clit one last time, her hand shooting down to grab at your hair, a hungry groan escaping her throat.	

Understanding you'd resume licking her there, her hips rolling in your grip as she panted and moaned now, soon the sounds no longer subtle as you felt her tense now, her hips shaking as she started to cum. 
""", 
	AFTER_TEMPLE_PRIESTESS_5_1_6 = """Heleviel lays there for a few moments before releasing your hair, just panting now as she looks down at you then relaxes. After a few seconds you realize that this isn't going to be a mutually beneficial arrangement and stand up as you start to redress, eyes moving over her the entire time.

 — The guards will...escort you out. 

	The guards do indeed escort you out, though the entire time the silent men have a look in their eyes hovering between admiration and fear. Disciplined yes but you can't help but notice it looked like the younger of the two was moments from throwing himself at your feet.""", 
	AFTER_TEMPLE_PRIESTESS_5_1_1_BAD = """— I'm afraid this is not possible. Freya's High Priestess shall not be tainted by man's touch. """,
	AFTER_TEMPLE_PRIESTESS_5_1AND2 = """As you make your way out of the priestess' chambers, you are called out to by some hooded soldier. After confirming your identity, he informs you that Erlen wants to see you in the woods on the outskirts. After relaying his location to you, the soldier leaves quietly.""",
	ERLERN_ENCOUNTER_START = """After scouting through the location, you can't find any signs of activity and start to wonder if you've come to the wrong place. Suddenly a couple of elven soldiers appear before you, taking you by surprise. As they inspect you, they tell you to follow them to meet Erlen.""",
	ERLERN_ENCOUNTER_1 = """Erlen meets you at the makeshift camp among the trees. You'd probably not recognize it as a camp if you didn't know it was there. Erlen's face remains impassive until you pass him the letter from Leon. After reading it, his expression grows more pessimistic.

 — I see... That's troublesome. 

After taking a long pause and pondering the letter, he finally speaks up. 

 — They have stated that in any case of emergency, they'll support the one person who has earned their trust there. Basically, that makes you their representative here. I'm forced to let you know some of the details and I will require your further help. Say, how much do you actually know about our society?""",
	ERLERN_ENCOUNTER_1_OPTION_1 = "Not all that much besides what you've told",
	ERLERN_ENCOUNTER_1_OPTION_2 = "Don't really know anything",
	ERLERN_ENCOUNTER_1_OPTION_3 = "I don't really care",
	ERLERN_ENCOUNTER_2_1AND2 = """ — As you are already aware, Freya's High Priestess is the elven leader. While my position is certainly not low, during times of peace I'm little more than a special forces commander. I'm directly subordinate to the High Priestess.

 — While I'm not doubting Freya's guidance, I'm concerned about Heleviel's rule. Moreover, my forces and I have been stationed here for no reason besides removing me from the capital. I sent you to the beastkin as they have some indirect influence over our politics and can play some role too. Heleviel wasn't kind to them either, however, her reign isn't inevitable. 

 — But it seems things are getting more complicated. My purpose is still firm but it seems I'm gonna need more work done to fulfill it. Can I ask you for another favor?""", 
	ERLERN_ENCOUNTER_2_3 = """Erlen decided to ignore your remark and still explain himself. 

 — As you are already aware, Freya's High Priestess is the elven leader. While my position is certainly not low, during times of peace I'm little more than a special forces commander. I'm directly subordinate to the High Priestess.

 — While I'm not doubting Freya's guidance, I'm concerned about Heleviel's rule. Moreover, my forces and I have been stationed here for no reason besides removing me from the capital. I sent you to the beastkin as they have some indirect influence over our politics and can play some role too. Heleviel wasn't kind to them either, however, her reign isn't inevitable. 

 — But it seems things are getting more complicated. My purpose is still firm, but it seems I'm gonna need more work done to fulfill it. Can I ask you for another favor?""",
	ERLERN_ENCOUNTER_2_OPTION_1 = "Yes",
	ERLERN_ENCOUNTER_2_OPTION_2 = "No",
	ERLERN_ENCOUNTER_3_1 = """ — Very good. As I'm stuck here, I need you to bring another person from the capital to me. There's another young, but bright, priestess of Freya, who you'll be able to find at the temple grounds. I want you to bring her to me, as she's a possible candidate for the next High Priestess. 

 — You shouldn't waste any more time, just get her here, no matter what.""",
	ERLERN_ENCOUNTER_3_2 = """""", # TODO add text
	LIRA_ENCOUNTER_1 = """After searching around, you manage to find the priestess Erlen asked you for. You bring her to an isolated place and explain that Erlen wants her to come to him.

 — E-Erlen wants me to come? I'm afraid this is going to be difficult. Recently we've been forbidden to leave temple's grounds. I can't risk it, as I already stand out because of my heritage.""",
	LIRA_ENCOUNTER_1_OPTION_1 = "Surely there might be some way",
	LIRA_ENCOUNTER_1_OPTION_2 = "I can't leave without you",
	LIRA_ENCOUNTER_2 = """Lira pauses for a long moment, thinking through the possibilities, then offers her own proposal.

 — I might be able to get out if there's someone to take my place during the muster. If you can find someone who looks similar to me, another Tribal Elf, then we might trick the temple watch.""",
	LIRA_ENCOUNTER_2_OPTION_1 = "Maybe we could think of some other way... (Wits Factor Check)",
	LIRA_ENCOUNTER_2_OPTION_2 = "I'll be back once I have someone then",
	LIRA_ENCOUNTER_3_1_GOOD = """{color=green|Success}

 — Now that I think about it... I might be able to bribe the guards with some drink. If you bring me 10 whiskey, that should be enough to make them let me go.""",
	LIRA_ENCOUNTER_3_1_GOOD_OPTION_1 = "I'll be back once I get one of those",
	LIRA_ENCOUNTER_3_1_BAD = """{color=red|Failure}

 — N-no, nothing really comes to mind. I'm sorry, I'm not good at this kind of thing.""",
	LIRA_ENCOUNTER_3_1_BAD_OPTION_1 = "I'll be back once I have someone then",
	LIRA_ENCOUNTER_4 = """You find Lira who seems to be waiting eagerly in anticipation of your progress.""",
	LIRA_ENCOUNTER_4_OPTION_1 = "I've brought another Tribal Elf to stand in for you",
	LIRA_ENCOUNTER_4_OPTION_2 = "I've brought the whiskey you've asked for",
	LIRA_ENCOUNTER_4_OPTION_3 = "*Leave*",
	LIRA_ENCOUNTER_5_1_1 = " — Alright, we'll have to swap our clothes then. Please, give me a moment or two to change...",
	LIRA_ENCOUNTER_5_1_2 = "After some time you manage to sneak Lira away from the temple's grounds. She's ready to meet with Erlen.",
	LIRA_ENCOUNTER_5_2_1 = " — Alright... Give it to me, I'll mix it with some herbs to make it more authentic. ",
	LIRA_ENCOUNTER_5_2_2 = "After a while Lira gets through the guards by bribing them. She's ready to go and meet with Erlen.",
	ERLEN_LIRA_1 = "You decide it's not worth returning to Erlen without Lira.",
	ERLEN_LIRA_2 = """As Lira sees Erlen you notice how the Tribal Elf girl's expression changes to become even more nervous than before. 

{color=yellow|Lira: — Pleasure to meet you, commander Erlen.}

{color=aqua|Erlen: — You've made it. You aren't hurt?}

{color=yellow|Lira: — N-no, nothing like that.}""",
	ERLEN_LIRA_2_OPTION_1 = "It was somewhat difficult, but we succeeded",
	ERLEN_LIRA_2_OPTION_2 = "That was too easy, maybe you need tighter security",
	ERLEN_LIRA_2_OPTION_3 = "What now?",
	ERLEN_LIRA_3_1 = """{color=aqua|Erlen: — Good work, now tell me what's been going on.}""",
	ERLEN_LIRA_3_2 = """{color=aqua|Erlen: — If it were my personal corps, I assure you, I wouldn't be so easy on them, but good work anyway.}""",
	ERLEN_LIRA_3_3 = """{color=aqua|Erlen: — Firstly, I want to know what's been going on. Lira, can you explain?}""",
	ERLEN_LIRA_4 = """Lira explains how she was put into curfew. The news makes Erlen grow even more tense. 

{color=aqua|Erlen: — Shit, so we really are out of time now... The High Priestess must be planning to perform the Becoming Ritual in the next few days or maybe any moment.}""",
	ERLEN_LIRA_4_OPTION_1 = "Becoming Ritual?",
	ERLEN_LIRA_4_OPTION_2 = "Why did she send you away?",
	ERLEN_LIRA_4_OPTION_3 = "Do we actually have any chance of stopping her then?",
	ERLEN_LIRA_5_1 = """{color=aqua|Erlen: — I must explain. The High Priestess is not an eternal ruler, nor is she selected by council. The High Priestess is chosen by Freya every few years. To summon the goddess the ritual is performed, which brings her spirit into the temple to temporarily inhabit a mortal body and deliver her decision.

Erlen: — Naturally, she will only select a person who's present in the temple at the time, so only devoted followers are usually allowed. More often than not she selects the current priestess who will keep her rule, but if Freya wills it, a new priestess can be chosen.

Erlen: — This time, however, the High Priestess feels the discontent caused by her rules, among myself and many others. Hence why I was sent away and the lower-ranked acolytes were locked down. This is to ensure her position does not change.}""",
	ERLEN_LIRA_5_2 = """{color=aqua|Erlen: — The ritual requires the participation of a male leader to provide a counterweight to our female-dominated society. For this reason the strongest male elves have to obtain the primordial water from the ancient temple. That would be me, however I'm uncertain how her plan might unfold, knowing that I won't help her.}""",
	ERLEN_LIRA_5_2_OPTION_1 = "I might have got this water for her...",
	ERLEN_LIRA_5_2_OPTION_2 = "I can't tell how, but she probably got it some way",
	ERLEN_LIRA_5_2_1 = """{color=aqua|Erlen: — Y-you did? Damn it... I guess we really are out of time in that case. Don't blame yourself too much,I believe she would've found some other way regardless.}""",
	ERLEN_LIRA_5_2_2 = """{color=aqua|Erlen: — Yes, it would make sense to make our final preparations then. We really are out of time now.}""",
	ERLEN_LIRA_5_3 = """{color=aqua|Erlen: — Not entirely. But I want to ask for your help... No, in fact I need your help. }

You and Lira both give Erlen a puzzled look.

{color=aqua|Erlen: — I guess I finally have to explain. When I sent you to the beastkin tribe, the letter you carried contained the request for Leon to support this coup and made him some offers to secure his help. While the beastkin are subdued by us, they can still pose a significant threat. However, their response...}""",
	ERLEN_LIRA_5_3_OPTION_1 = "What was it?",
	ERLEN_LIRA_5_3_OPTION_2 = "They refused?",
	ERLEN_LIRA_5_3_OPTION_3 = "Must have requested my participation somehow",
	ERLEN_LIRA_6_1 = """{color=aqua|Erlen: — Leon expressed that if they're gonna be dragged into this, they will only follow someone who has earned their respect. Whatever you've done, it's not something any of us would likely have achieved. }""",
	ERLEN_LIRA_6_2 = """{color=aqua|Erlen: — No, not directly at least. Leon expressed that if they were gonna be dragged into this, they will only follow someone who has earned their respect. Whatever you've done, it's not something any of us would likely have achieved.}""",
	ERLEN_LIRA_6_3 = """{color=aqua|Erlen: — Hmph, so you've guessed it? Yes, Leon expressed that if they're gonna be dragged into this, they will only follow someone who has earned their respect. Whatever you've done, it's not something any of us would likely have achieved. }""",
	ERLEN_LIRA_6_OPTION_1 = "So, this is why you need my help",
	ERLEN_LIRA_6_OPTION_2 = "I'm not sure I'm suitable for such responsibility",
	ERLEN_LIRA_7_1 = """{color=aqua|Erlen: — Precisely. I hope you will help us after all of this. 

Erlen: — I've already sent the messengers to Leon in your name so they should be moving into the direction of the capital. This is bold, but with you on our side we should avoid any serious complications.}""",
	ERLEN_LIRA_7_2 = """{color=aqua|Erlen: — I don't have the whole story on how you convinced Leon and the tribe to accept you, but if the beastkin chose you, you must be capable.

Erlen: — I've already sent the messengers to Leon in your name so they should be moving into the direction of the capital. This is bold, but with you on our side we should avoid any serious complications.}""",
	ERLEN_LIRA_7_OPTION_1 = "I didn't quite grasp the goal, what are you fighting for?",
	ERLEN_LIRA_7_OPTION_2 = "Very well, so what's the plan?",
	ERLEN_LIRA_8_1_1 = """Erlen takes a long pause to collect his thoughts before finally speaking up.

{color=aqua|Erlen: — I don't believe in the way that we elves are going as a nation. In recent decades the segregation of males and females has been growing faster than ever before. Most males are treated as servants at best and as outcasts at worst. Freya's acolytes aren't allowed to engage with them and there's often animosity between us. 

Erlen: — Heleviel is very much in favor of continuing this policy but a new High Priestess could push for real changes. Something to give us more breathing room and alleviate the friction. This is why I made you bring Lira here.}""",
	ERLEN_LIRA_8_1_2 = """{color=yellow|Lira: — I-I appreciate your faith in me, but I'm still not sure about something big like this. I was accepted at the temple only out of goodwill. I'm not even native, and now you propose that I should become the next High Priestess? Even with my feelings towards you, this is a bit too much...}

{color=aqua|Erlen: — Your own feelings are of little importance. If Freya considers you worthy, then you can do it. I'm tired of this state and I'm willing to bet everything on my faith in you. }""",
	ERLEN_LIRA_8_2 = """{color=aqua|Erlen: — Given our current situation, there's only one thing we can do. We must break through right at the peak moment of the ritual. While you were away I've already prepared everything. Wait two more days and then come to the elven capital, Leon should make it by that time as well. Until then it's better to stay away from there.}""",
	ERLEN_LIRA_8_OPTION_1 = "I hope you aren't forgetting our deal",
	ERLEN_LIRA_8_OPTION_2 = "I might ask for something more for this kind of risk",
	ERLEN_LIRA_9_1 = """{color=aqua|Erlen: — If we succeed, you'll get any help you might request from me, be it access to the Sacred Bowl or anything else.} """,
	ERLEN_LIRA_9_2 = """{color=aqua|Erlen: — I... Can promise you more, but these promises will be empty if we won't actually succeed. I suggest we leave this talk until later.}""",
	ERLEN_LEON_1 = """Erlen's group has met up with Leon and you. 

{color=aqua|Erlen: — I'm grateful that you've come.}

{color=yellow|Leon: — Hmph, so you can be polite when you need something from us. Keep in mind we are only here because of [name], we'll follow his orders, not yours. }

Erlen decided to ignore Leon's remark and proceeded.

{color=aqua|Erlen: — My informant has reported that they're holding the ritual today. We must move swiftly, the temple will be sealed for half an hour before the start. From that point, nobody can leave or cancel the ritual.}""",
	ERLEN_LEON_1_OPTION_1 = """What are we gonna do?""",
	ERLEN_LEON_1_OPTION_2 = """We'd better not waste time chatting then""",
	ERLEN_LEON_2 = """{color=aqua|Erlen: — We'll have to break through. Most soldiers should be positioned away from the capital at this moment, but those which are left will all be drafted to protect the ritual.}

{color=yellow|Leon: — Sounds easy. What's the catch?}

{color=aqua|Erlen: — We have to get Lira inside the temple before the ceremony is over. We'll be leading the infiltration.}""",
	ERLEN_LEON_3 = """As you make your way through the back streets led by Erlen, who knows the capital like the back of his own hand, you manage to avoid any patrols. Your group is fairly small, consisting of both elven and beastkin leaders and your personal team. As you make it closer to the main temple, you are forced to come out of hiding to cross the bridge that leads to the temple gates. 

However, the bridge is guarded. As your group is spotted the soldiers rush towards you. Erlen goes out in front of them.

{color=aqua|Erlen: — At ease. These people are coming with me. }

{color=yellow|Guard: — My apologies, commander, but we have been instructed to stop you by the High Priestess.}

{color=aqua|Erlen: — Damn it. We'll have to fight.}""",
	ERLEN_LEON_4 = """You successfully defeat the patrol and cross the bridge. However, as you get closer to the doors, you spot a larger formation of troops approaching you from behind. 

{color=yellow|Leon: — You should go or you'll never make it. We'll hold them back.}

{color=aqua|Erlen: — My men will stay as well. Quick, [name], there's very little time left!}""",
	CEREMONY_1 = """The ceremony has been going on for some time when one of the acolytes rushes to Heleviel to inform her about the ongoing assault. She doesn't show any emotion and just gives the order to continue with the ritual. It seems she thinks the rear guards should be able to hold Erlen long enough for her to complete her plan. 

Heleviel has also heard something about beastkin making their move, but decides that it can wait until her status as High Priestess is confirmed.""",
	CEREMONY_2 = """As your team barges in, you realize that the ritual has been launched. The room is filled with a white light. You've made it here in the last possible moment.""",
	CEREMONY_3 = """Interesting. Nothing like this has happened for a very long time. How impudent for an outsider to involve himself with elven affairs. Very well, why don't you amuse me in this case? Tell me, who would you choose to become the next High Priestess?""",
	CEREMONY_3_OPTION_1 = "Heleviel",
	CEREMONY_3_OPTION_2 = "Lira",
	CEREMONY_HELEVIEL_1 = """As you spell out your answer, the white fog disperses around you and you find yourself in the middle of the temple. It seems you were the real messenger of Freya and now Heleviel is going to be the High Priestess once more. 

 — You've all heard it for yourself. Freya has chosen me once more. Even with the ritual being nearly aborted.

 — As for you, [name], it seems you must have earned the favor of the Goddess herself in order to become her herald, so we will excuse your presence here.""",
	CEREMONY_HELEVIEL_2 = """Heleviel turns to face Erlen and Lira who have both been captured by her guards.

 — As for these trespassers, Erlen will be executed for betraying the trust that our nation placed in him as a military commander. 

Erlen hangs his head in a defeated posture, not saying anything. Lira tries to protest but the guards quickly silence her.

 — This priestess has also proven to be a traitor, despite our best intentions in allowing her to serve Freya as any other. She shall serve an example for others who might think of straying from the path. I guess you should be glad to share the same faith.""",
	CEREMONY_HELEVIEL_2_OPTION_1 = "I think you are being too harsh and they could be pardoned",
	CEREMONY_HELEVIEL_2_OPTION_2 = "It's your choice",
	CEREMONY_HELEVIEL_3_1 = """ — Nonsense. Erlen is obviously too dangerous for us, he can't even be allowed to live after his attempt to ruin the ritual. I could see the priestess being his tool, but she can't be trusted either after this.""",
	CEREMONY_HELEVIEL_3_1_OPTION_1 = "You could at least exile her then",
	CEREMONY_HELEVIEL_3_1_OPTION_2 = "Give her to me",
	CEREMONY_HELEVIEL_3_1_OPTION_3 = "You've convinced me",
	CEREMONY_HELEVIEL_3_1_1 = """Heleviel takes a short pause, and decides to play along.

 — Very well, she'll be exiled from our forests forever. Thank [name] for the gift of your life.""",
	CEREMONY_HELEVIEL_3_1_2 = """Heleviel smirks at your request.

 — Very well, you may have her as long as you keep her in your domain. We don't care what she'll be doing if it's outside of our lands.""",
	CEREMONY_HELEVIEL_3_2 = """As things are settled you go out and explain to Leon that this is over. He accepts your command and retreats along with the beastkin warriors he brought here. As you return to Heleviel, she settles things up and invites you to her chambers.""",
	CEREMONY_HELEVIEL_4 = """ — I must thank you for your participation I suppose. Despite your helping Erlen to try to seize power from me, this has worked out well in the end and I have finally got rid of him. I know, you are waiting for your artifact, and as I promised, you can have it. After all, you are the first outsider I know to become Freya's chosen, so I have no reason to oppose you. Take the Sacred Bowl, I trust that this will serve Freya's interests in the end. 

 — Oh, and one more thing I must tell you. It seems that the demon woman of yours is indeed plotting something. She appeared as you described. """,
	CEREMONY_HELEVIEL_4_OPTION_1 = "Was a pleasure working with you",
	CEREMONY_HELEVIEL_4_OPTION_2 = "Until the next time we meet",
	CEREMONY_LIRA_1 = """As you spell out your answer, the white fog disperses around you and you find yourself in the middle of the temple. It seems you were the real messenger of Freya and now Lira is going to be the High Priestess instead of Heleviel. 

{color=yellow|Heleviel: — N-no way. This can't be!}

{color=aqua|Erlen: — You heard it. Heleviel, you will be seized for trying to subvert the assignment of Freya's next High Priestess.}

{color=yellow|Heleviel: — No, you traitors! This was all staged, you can't do this to me!}""",
	CEREMONY_LIRA_2 = """The guards follow Erlen and Lira's orders and take Heleviel away from the temple. You tell Leon that the battle is over and he retreats with his warriors, after which you meet with Erlen once again.""",
	CEREMONY_LIRA_3 = """ — It's hard to believe this has actually happened, but because of you Lira is the High Priestess now. As promised, I grant you the Sacred Bowl. This is the least I can repay you with.""",
	CEREMONY_LIRA_3_OPTION_1 = "What's going to happen to Heleviel",
	CEREMONY_LIRA_3_OPTION_2 = "Glad it worked out for you",
	CEREMONY_LIRA_4_1 = """ — She will likely be executed or secluded forever. Trying to prevent Freya's will from happening is the gravest possible offense in our society.""",
	CEREMONY_LIRA_4_1_OPTION_1 = "Give her to me",
	CEREMONY_LIRA_4_1_OPTION_2 = "It's up to you then",
	CEREMONY_LIRA_4_1_1 = """Erlen considers it for a bit and nods.

 — Very well, obviously I would not allow anyone else to ask for it, but you've done too much for us here. You can have her, as long as she will spend the rest of her life as a slave. I warn you that she's not going to cooperate, though.""",
	CEREMONY_LIRA_4_1_1_OPTION = "Thank you",
	CEREMONY_LIRA_4_2 = """ — I wish you luck on your journey. We have a lot of work to do, but we will be glad to receive you some time again soon.""",
	DEMON_PRIESTESS_1 = """The High Priestess of Freya finished her business and went to her private chamber to rest, but this time she found that she was not alone. 

{color=yellow|High Priestess: — So, it was true something shady has been going on. }

{color=aqua|Demoness: — How unpleasant. I'd only like to offer some cooperation.}""",
	DEMON_PRIESTESS_2 = """{color=yellow|High Priestess: — Preposterous. Nobody here would cooperate with your kind.}

{color=aqua|Demoness: — Should you really be so dismissive now? Even your status will not save you from the consequences of what is to come. }

{color=yellow|High Priestess: — I don't know how you got in here, but it's your last chance to leave before I call the guards.}

{color=aqua|Demoness: — Hmph, so be it. Don't come crawling to me if you regret this later.}""",
	DEMON_PRIESTESS_3 = """As the demoness disappears with a teleportation spell, the High Priestess lets out a sigh and sits on the bed recalling the hardships she faced to secure her position.""",
	
	
	JEAN_INTRO = """As you are about to enter, you hear an unfamiliar female voice from the other side of the door that sounds rather agitated. 

{color=yellow|Unfamiliar Voice: — Watcha means there's no available job for a single person?!}

{color=aqua|Myr: — What I said. What happened to your previous team anyway?}

{color=yellow|Unfamiliar Voice: — Who cares, I'm free now!}""",
	JEAN_INTRO_1 = """You decide to enter and observe a young human girl who measures you with a sharp look.

{color=aqua|Myr: — Oh, it's you, [name]. Nice timing. Why don't you take this magnificent sorceress who's dying for some real work? }

Out of Myr's deadpan voice you can't make out if she's serious or not.""",
	JEAN_INTRO_2 = """{color=yellow|Girl: — You are a new landowner. What makes you think I will be working for you!? }

{color=aqua|Myr: — You are out of options, Jean, and your dormitory payment is due. }

{color=yellow|Girl: — Kh...}

{color=aqua|Myr: — As you can see, her temperament is atrocious, but she's one of the most skilled students I have ever had. Please relieve me of her presence.}""",
	JEAN_INTRO_2_OPTION_1 = "I guess I have some free space left",
	JEAN_INTRO_2_OPTION_2 = "No way",
	JEAN_INTRO_BAD = """{color=aqua|Myr: — Goddamnit... Give me some more time then.}

You leave the room and wait for them to finish.""",
	JEAN_INTRO_3 = """{color=yellow|Jean: — Hey, what the heck makes you think you can decide without me? }

{color=aqua|Myr: — Excellent. I'm sure [he]'ll have some suitable work for you. Maybe you'll also find a man and stop being such a pain in the ass. Adios.}

{color=yellow|Jean: — Wait, I haven't finished!}

Before Jean could protest, the strong magical force has pushed you both out of Myr's office.""",
	JEAN_INTRO_4 = """ — Darn that hag!.. Crap... 

Realizing the hopelessness of her situation Jean finally acknowledges your presence and turns to face you.

 — Well, pleased to meet you, I guess. You must have some work for me, right? As you can guess I'm not good with housework, so I hope you aren't just sitting on your ass all day.""",
	JEAN_INTRO_4_OPTION_1 = "I fight a lot",
	JEAN_INTRO_4_OPTION_2 = "It seems you don't talk to people too often ",
	JEAN_INTRO_4_OPTION_3 = "No, but I wouldn't mind sitting on your ass from time to time",
	JEAN_INTRO_5_1 = """ — Hmph, that's good then. Fine, point me in the direction of where I'll be sleeping and we can meet there.

You give Jean the directions to your mansion and leave her to it.""",
	JEAN_INTRO_5_2 = """ — Whatever. Fine, point me in the direction of where I'll be sleeping and we can meet there.

You give Jean the directions to your mansion and leave her to it.""",
	JEAN_INTRO_5_3 = """Blushing fiercely, Jean slaps your face making a sound so loud you wonder if Myr is going to come out of her office to check on you. 

 — That's what you are thinking about? Pervert! I'll let you know I won't be doing any of the sort of 'service' that you are dreaming of! Now tell me where I sleep from now on and bug off.

You give Jean the directions to your mansion and leave her to it.""",


	LILIA_INTRO = """As you move through the village with occasional elves and fae observing you, you notice that most residents stay very cautious and turn away once you look in their direction. That is, except for one very curious fairy with long red hair. After she realizes that she has caught your attention, she dashes at you, completely ignoring any formalities.

 — Hi! I'm Lilia. What's your name? Are you an adventurer? You are so big! We don't get people like you here often. What brought you here?""",
	LILIA_INTRO_OPTION_1 = "Nice to meet you, I'm [name].",
	LILIA_INTRO_OPTION_2 = "Woah, not so fast",
	LILIA_INTRO_OPTION_3 = "You really know no manners, do you?",
	LILIA_INTRO_2 = """ — Ah, sorry, this is just so exciting and rare to meet someone like you. You look so big and strong, it makes me feel all tingly *chuckle*

 — Say, can I join you? Please? """,
	LILIA_INTRO_2_OPTION_1 = "Agree",
	LILIA_INTRO_2_OPTION_2 = "Refuse",
	LILIA_INTRO_3_1 = " — Thanks! Looking forward to living at your place.",
	LILIA_INTRO_3_2 = " — Aww... Let me know if you change your mind!",
	
	CALI_INTRO = """As you make your way through the fort, you find a short note from some slavers who seem to be in contact with local bandits. It identifies a small cave at a nearby location which is used as a safe house and describes how the slavers are forced to stay there for now. You write this information down and move on.""",
	CALI_INTRO_1 = """You come across a small group of slavers who greet you.

{color=aqua|Slaver: — Hey, it seems we have a guest. We don't wanna fight, actually we wanna get rid of some leftover merchandise and get on with it. You seem like a respectable gentleman. }

The slaver leads you to another room.""",
	CALI_INTRO_2 = """Lying on the floor you see a young girl. Her ears and tail give away her origin as a halfkin wolf. Despite being bound, her spirit seems to not be anywhere near broken yet.

{color=yellow|Slaver: — Name's Sally, or something like that.}

{color=aqua|Girl: — It's Cali! I'm of proud wolf race and I'd kick your ass if not for these ropes!}

{color=yellow|Slaver: — This little shit just won't shut up. Why didn't we discipline her again?

Slaver 2: — Because the buyer we had lined up was the guy who loved them feisty. I'm too lazy to do it now, just gag her mouth again.}""",
	CALI_INTRO_2_OPTION_1 = "Is she still a virgin?",
	CALI_INTRO_2_OPTION_2 = "Where did you get her?",
	CALI_INTRO_2_OPTION_3 = "I'd like to purchase her",
	CALI_INTRO_2_OPTION_4 = "I'll take her from you", # go to fight
	CALI_INTRO_3_1 = """The girl blushes a deep scarlet color at your question.

{color=aqua|Cali: — Of course I am! What are you planning to do, you perverts!? Don't even think about it!}

The men smirk at her reaction.

{color=yellow|Slaver: — Well, that's what she says.}""",
	CALI_INTRO_3_2 = """{color=yellow|Slaver: — She was traveling all alone, by dangerous roads. Looks like she ran away from home or something. }""",
	CALI_INTRO_3_3 = """The leader strokes his chin for a few seconds. 

{color=yellow|Slaver: — I knew we could have a productive relationship with you, [Sir]. It would be annoying to keep her around once we leave, so we will happily part with her here.}

{color=aqua|Cali: — Bastards, stop discussing me like I agreed to this!}

{color=yellow|Slaver: — Given her healthy physique and appearance I believe she is worth at least 1,000 gold.}""",
	CALI_INTRO_3_OPTION_1 = "She does not seem all that pretty to me (Charm Check)",
	CALI_INTRO_3_OPTION_2 = "I'll think about it",
	CALI_INTRO_3_OPTION_3 = "Deal",
	CALI_INTRO_3_OPTION_4 = "No deal, I'll take her by force",
	CALI_INTRO_4_1_1 = """{color=aqua|Cali: — Like I care how I seem to you!}

{color=yellow|Slaver: — I suppose, a thousand might be too much, but we can't drop the price lower than 750 gold. We have had to cover the costs of keeping her alive and safe. }

{color=aqua|Cali: — You feed me with pig food here!}""",
	CALI_INTRO_4_1_2 = """{color=aqua|Cali: — Like I care how I seem to you!}

{color=yellow|Slaver: — Even so, we must cover the expenses for having kept her alive and safe. }

{color=aqua|Cali: — You feed me with pig food here!}""",
	CALI_INTRO_4_2 = """{color=yellow|Slaver: — Alright, but don't take too long. There might be a new customer for her by the time you make your mind up. He-he.}""",
	CALI_INTRO_4_3 = """The slaver smirks as you pass them the money and leave the cave. You turn to the still bound Cali.""",
	CALI_INTRO_4_4 = """{color=yellow|Slaver: — Oh, is that so? You can try!}""",
	GOT_CALI_1_1 = """The bound wolf girl sits before you, looking up at you with defiance and a hint of fear.

 — So? What are you going to do with me now?""",
	GOT_CALI_1_2 = """The bound wolf girl quietly sits before you. Her composed expression betrays hints of fear and wonder that she's trying to hide.

 — W-what are you looking at? What are you going to do with me? """,
	GOT_CALI_1_OPTION_1 = "*Rape her*",
	GOT_CALI_1_OPTION_2 = "I'll free you",
	GOT_CALI_2_1 = """You decide there's really no point in any further chatting and you should savor your new acquisition right here. """,
	FORCE_CALI_1 = """To Cali's shock, you shove her down flat on the ground and stand over her. With her hands tied behind her back and her knees bound tightly together, the halfkin wolf girl can do little to resist your superior strength. 

She tries to squirm away, wailing miserably, but you easily grab hold of her tail and hold her in place. Her short skirt rides up to expose her cute round ass. Wriggling frantically, Cali does her best to resist you as you push her skirt up around her waist and feast your eyes on her helpless body. Securely bound as she is, her struggles only exhaust herself.""",
	FORCE_CALI_2 = """Pressing the bound Cali firmly against the ground, your hand explores her soft vulnerable ass.

 — W-what are you doing! Stop it, you bastard!

Grabbing hold of the sheer fabric of Cali's stockings you tug sharply, ripping them open to get a better look at her white cotton panties.

 — Monster! You'll regret this!

Chuckling softly, you run your finger over her panties, along the soft cleft between her thighs. Cali shudders as your fingertip prods roughly at her clit through the fabric.

 — N-no! Please, don't do this! I'm not... I've never...

You pull the crotch of her panties to one side, revealing Cali's tight pink pussy. """,
	FORCE_CALI_3 = """With the halfkin wolf girl's pussy exposed, her tone changes and she starts trying to bargain desperately with you.

 — Please, [sir], I can offer you something! What do you want? I don't mind being a servant, I just... please... stop... Ooohhh!

You begin to tease Cali's clit with your finger, letting your thumb slip gradually between the pussylips until it's pressing against her hymen. It doesn't take long before her pussy starts to grow warm to the touch, her labia turning slick with her involuntary arousal. Cali strains against the ropes binding her, jerking her upper body as her thighs helplessly twist against your probing fingers. Her small firm ass quivers with the tension of keeping her slim legs clamped together. Using your free hand, you force her legs to bend at the hip.and then unbuckle your belt. 

 — N-no, please! Aaah! Please, [sir], please stop this! """,
	FORCE_CALI_4 = """With the girl's bound legs bent, you plant your hand firmly in the small of her back and pin her against the cold ground. You can see the hard nipples on her small tits pressing through the fabric of her shirt as she is forced down. Her ass and pussy stick into the air, where your hand fondles them, preparing her to become a woman. 

 — Oh, gods, no! Don't do it! I don't want it! I'm not ready!

Cali's wet slit tells a different story and without further ceremony you ignore her whining, pull out your stiff cock and plunge it into her vulnerable pussy, bursting through her hymen.

 — AAAAaaiiieeehhh!

Cali screws her eyes shut tightly, as if she could make it stop by not watching, but your cock plows hard and deep inside her sensitive virgin cunt as you claim her for your property. 

 — Y-you bastard! I'll — I'll never forgive you for this!

Hot tears run from the wolf girl's closed eyes as she weeps while your penis pounds into her refreshingly tight pussy.""",
	FORCE_CALI_5 = """Sensing the futility of further resistance, Cali's struggles grow weaker. As your penis rams rhythmically into her, the sound of her cries begins to change. She gasps as you slowly sink your whole length in her pussy, your balls resting against her swollen clit. The tension in her yields a little and she lets out a ragged sigh as her pussy pulses and quivers around the shaft of your cock. 

Cali's eyes open part-way as you draw your penis out of her inch by inch. She cannot suppress a soft moan as you push down and penetrate her again, your penis stretching her virgin hole to its limits as you fill her with your rock-hard meat. 

 — Ahh! Ow! Please! You don't have to hurt me!

The girl watches you, holding your gaze as you pump in and out of her. She no longer fights against her bonds, instead arching her back and holding her ass up for you while you fuck her.

You feel Cali's bruised pussy begin to tighten and grip your cock as you pick up speed again, thrusting faster and harder as you feel your orgasm fast approaching. """,
	FORCE_CALI_6 = """Gripping Cali's narrow hips, you fuck the young wolf-girl with renewed vigor as she tries in vain to control her involuntary response. 

 — Aahh! No, please, I'm... I-

Fresh tears streak her face as an unwilling orgasm courses through her, shaking her whole body. You sink your fingers into the firm muscle of her ass and, gripping her hard enough to bruise, you pound her helpless pussy until she screams in pain.

 — Aaggh! No! Not inside me! I beg you!

A moment later and your cum shoots deep into her writhing form, filling her young pussy to overflowing with your hot sticky seed. Cali wails, crying again as the semen flowing out of her hole mingles with the blood of her recent virginity.

You take a minute to savor your power over the girl and then with a quick slap on her bare ass you pull out. 

Cali lies there for a minute or two, sobbing as cum trickles onto her thighs. Then you hoist her up and throw her over your shoulder. Satisfied you have established your authority over the wolf girl, you return to the mansion with your newly acquired toy.""",
	GOT_CALI_2_2 = """The wolf girl looks at you with something like disbelief as you release her from her binds and help her to stand up. Despite her numb muscles and small figure, her liveliness is something to be envied. 

 — W-well, thank you, I guess. I'm glad you aren't like those creeps. 

She takes a long pause, rubbing her sore wrists, before she is willing to continue.

 — Say... You are some big shot I suppose? Right now I don't really have anywhere to go. Maybe I could do some work for you? You look like a good guy.""",
	GOT_CALI_2_OPTION_1 = "What sort of work can you do?",
	GOT_CALI_2_OPTION_2 = "I could find some use for you",
	GOT_CALI_2_OPTION_3 = "Not interested",
	GOT_CALI_3_1 = """ — I might not look like it, but I'm pretty tough, I'm of the wolves after all. 

Cali proudly puffs her chest.

 — I can do some menial work or I could cover your back. But I'd rather not do anything, you know, bawdy...""",
	GOT_CALI_3_2 = """ — Great! I promise I'll do my best. 

You leave the cave and lead Cali back to your mansion.""",
	GOT_CALI_3_3 = """— A-aha... Alright, I guess I'll be on my way then. 
	
Cali looks surprisingly disappointed but decides not to tempt her fate and leaves.""",
	
	CALI_SIDEQUEST_1 = """At noon you are approached by one of your residents: Cali. She looks at you with a slightly worried face.

- Hey, [name]. You know, It's been a while since I started to live here. I was thinking that I wanna do something big.""",
	CALI_SIDEQUEST_1_OPTION_1 = "That's an admirable attitude",
	CALI_SIDEQUEST_1_OPTION_2 = "You would still have to start somewhere small",
	CALI_SIDEQUEST_1_OPTION_3 = "You don't have to worry about this, you can stay as long as you want",
	CALI_SIDEQUEST_1_1 = """- Hmph, no need for flattery, that's what a proud wolf should do — not simply rely on the good will of others. """,
	CALI_SIDEQUEST_1_2 = """- You... Aren't wrong about this. But I still have to.""",
	CALI_SIDEQUEST_1_3 = """- No, no, this is wrong. I must give my best and repay you as well.""",
	CALI_SIDEQUEST_1_ADDITIONAL = """

- So, I've heard about those guilds here. I bet if I join one it will help me get stronger. You must know something about it, right? Which one do you think will suit me better?""",
	CALI_SIDEQUEST_2_OPTION_1 = "Fighters guild would suit you quite well",
	CALI_SIDEQUEST_2_OPTION_2 = "Maybe you can do some magic for the Mages guild?",
	CALI_SIDEQUEST_2_OPTION_3 = "You could join Workers for some fair labor",
	CALI_SIDEQUEST_2_OPTION_4 = "Servants might be a good fit for a girl",
	CALI_SIDEQUEST_3_1 = """- Hmm.. Yeah, I like that! Being an adventurer, fighting bad guys and monsters. 

- So, you think I can go there and become a fighter? I can also be more useful to you if I get stronger, right? Let's go there!""",
	CALI_SIDEQUEST_2_2 = """- No, I hate studying and I heard you need to do that a lot to become a mage. It does not really suit me, don't you think?""",
	CALI_SIDEQUEST_2_3 = """- Ugh, boring. I'd rather do something more active.""",
	CALI_SIDEQUEST_2_4 = """- Oh, come on, you are talking just like my mom! I may be a girl, but I'm not really good with that girly stuff. There must be something better.""",
	CALI_FIGHTERS_INIT_OPTION = "Cali",
	CALI_FIGHTERS_1 = """As you walk inside the guild with Cali, she's staring around in awe. After a couple of seconds getting used to the surroundings, you locate the register table and make your way to it. As the wolf girl starts enthusiastically requesting her registration, the receptionist looks less than enthusiastic about it.

{color=yellow|Receptionist: — You look quite young and inexperienced. This isn't a playground, you know.}

{color=aqua|Cali: — H-hey, I know that! So what if I have no experience?} 

{color=yellow|Receptionist: — We can't vouch for your safety. At the very least bring your legal guardian with you.}

{color=aqua|Cali: — W-well... Then, what about [him]?! [He]'s mine...}

Cali gives you a troubled look.""",
	CALI_FIGHTERS_1_OPTION_1 = "[Master]",
	CALI_FIGHTERS_1_OPTION_2F = "Father",
	CALI_FIGHTERS_1_OPTION_2M = "Mother",
	CALI_FIGHTERS_1_OPTION_2SF = "Stepfather",
	CALI_FIGHTERS_1_OPTION_2SM = "Stepmother",
	CALI_FIGHTERS_1_OPTION_3 = "Just a good friend",
	CALI_FIGHTERS_2_1AND3 = "{color=aqua|Cali: — That's it! If [he] allows me then it's fine, right?}",
	CALI_FIGHTERS_2_2 = """Cali looks slightly disturbed by your response but quickly realizes she has to play along.

{color=aqua|Cali: — Y-yeah, that works for you, right?}""",
	CALI_FIGHTERS_2_ADDITIONAL = """

Receptionist gives you a tired look but decides to give it a pass.

{color=yellow|Receptionist: — Fine. You are a landowner so we can hold you responsible I guess. }

{color=aqua|Cali: — Yes!.. — Cali nearly jumped upon hearing it.}

{color=yellow|Receptionist: — However, as I said, this is not a playground. Before you become a member there will be a test for you to prove your capability.}""",
	CALI_FIGHTERS_3 = """Receptionist scrambled the papers on his desk until found one of the requests.

{color=yellow|Receptionist: — Here. A simple task for a member of the Fighters' Guild. A group of goblins have been raiding one of the local villages. If you can drive them away you will be accepted.}

Cali enthusiastically took the note and turned to you. 

{color=aqua|Cali: — Easy-peasy. What stupid goblins can even do? We will finish with them before the evening. Let's go!}""",
	CALI_FIGHTERS_3_OPTION_1 = "Sure, right behind you",
	CALI_FIGHTERS_3_OPTION_2 = "Let's be careful",
	CALI_FIGHTERS_4 = """You and Cali walk out of the Fighter's guild and observe the map for the required location.""",
	CALI_GOBLINS_NO_CALI = """You decide it's not wise not to bring Cali on this quest.""",
	CALI_GOBLINS_1 = """Full of spirit, Cali quickly jumps to the village and learns about the raiding goblins' location. After another twenty minutes you approach what seems to be a small forest encampment with a couple of goblin watchers who haven't spotted you yet. However, despite your best effort to not alarm them, Cali brashly comes out of the bushes and quickly grasps the attention of your enemies. 

With multiple goblins coming out of the camp there's no other choice but to fight them now.""",
	CALI_GOBLINS_2 = """As you defeat the multitude of goblins, you notice how a few from the back start running away deeper into the camp. Cali, who seems to be enjoying herself, notices this as well and before you can stop her, charges after them. """,
	CALI_GOBLINS_3 = """As the wolf girl rushes after the goblins she fails to spot a trap laid under the leaves. As she trips on it, a couple of goblins jump from behind in ambush, one of which manages to latch on her back. 

- Get off me!... Now!

As she struggles to get him off her, more goblins slowly move closer, surrounding Cali as she eventually breaks free. 

- Uh, oh... [name]... Where are you..?

Realizing her position, Cali looks frightened but does not try to run away yet. 

As you make it closer to her, you make a decision...""",
	CALI_GOBLINS_3_OPTION_1 = "Push in and save her",
	CALI_GOBLINS_3_OPTION_2 = "Let her deal with it",
	CALI_GOBLINS_4_1 = """You courageously rush in and drag Cali from danger. However, before she can thank you, more goblins come in and force you into a fight.""",
	CALI_GOBLINS_4_2 = """You decide to stay back and give Cali a lesson. With no other option she's forced to fight in an uneven battle.

As you strike down a few goblins caught on the back, you notice that Cali, while still fighting back and keeping distance, seems to suffer some wounds and might not make it without your interference. You decide it's time to help her out.""",
	CALI_GOBLINS_5 = """As you finally manage to make the rest of the goblins flee in terror, you and Cali catch the breath and she speaks up to you.

- I'm sorry... I shouldn't have ran carelessly after them. Thanks for helping me.""",
	CALI_GOBLINS_5_OPTION_1 = "As long as you've learned your lesson",
	CALI_GOBLINS_5_OPTION_2 = "Don't act without my permission next time",
	CALI_GOBLINS_5_OPTION_3 = "If you do this again, I'll leave you to them if this happens again",
	CALI_GOBLINS_6_1 = """- Yeah! In the end we did it, right?

Cali seems relieved with your words and grabs your hand as you return to the village.""",
	CALI_GOBLINS_6_2AND3 = """- Sorry... I promise I'll be more careful next time.

Cali seems somewhat upset with your words as you return to the village""",
	CALI_GOBLINS_7 = """You report on your success to the village elder and leave successfully completing the mission. Cali seems rather happy with the results.

- We did it nicely. Thanks for helping me out with this.""",
	CALI_GOBLINS_7_OPTION_1 = "You managed great as well",
	CALI_GOBLINS_7_OPTION_2 = "It was only a bunch of goblins, no big deal",
	CALI_GOBLINS_7_OPTION_3 = "Are you sure it's what you wanna do?",
	CALI_GOBLINS_8_1 = """- Ha-ha, you think so? I'm sure our future adventures will be even better!""",
	CALI_GOBLINS_8_2 = """- Maybe for you, but it was pretty thrilling for my first time.""",
	CALI_GOBLINS_8_3 = """- Of course! This is only the beginning.""",
	CALI_GOBLINS_8_ADDITIONAL = """

Despite everything, Cali does not let her spirit down and you leave to home""",
	CALI_SEX_1_1 = """As you walk in the evening through the mansion, you come across one slightly opened door leading to a halfkin wolf girl you recently recruited — Cali. As you hear some noise coming from there, you decide to take a look. 

You see Cali lying on the bed with bare bottom and her legs spread as she meekly explores her itching crotch breathing softly. """,
	CALI_SEX_1_2 = """- I'm feeling strange... Thinking about [him]...

As she turns to you, she realizes you've been looking at her for some time. Her face is rich with blush and she's unsure how to react.

- [Master]?! This is...""",
	CALI_SEX_1_OPTION_1 = "This feels good isn't it?",
	CALI_SEX_1_OPTION_2 = "You should lock the door next time",
	CALI_SEX_1_OPTION_3 = "*Leave quietly*",
	CALI_SEX_2_3 = """You decide to ignore it and close the door...""",
	CALI_SEX_2_3_OPTION_1 = "This isn't the time...",
	CALI_SEX_2_3_OPTION_2 = "I'd rather not at all.",
	CALI_SEX_2_1AND2 = """Seeing your reaction, Cali relaxes a bit but still cowers her private parts from you.

- I'm... um... not sure what to say now.""",
	CALI_SEX_2_1AND2_OPTION_1 = "I'd like to see you continue",
	CALI_SEX_2_1AND2_OPTION_2 = "Don't mind if I watch?",
	CALI_SEX_3_1 = """Cali pauses for a moment, but her lust takes over and she stops covering herself, revealing her pussy to you again. 

- You are a pervert, Master. 

Her playful tone catches up as her hand starts rubbing her snatch.

- But... I don't dislike being watched by you...""",
	CALI_SEX_3_2 = """As her voice gets more passionate, she ogles at you and your bulge, however refraining from anything bigger. In less than a minute her voice gets higher and her body jerks as she reaches orgasm, touching herself. As she goes limp on a bed her face is filled with a smile. Soon after she starts wrapping in a blanket

- Wow... I never felt like this before.""",
	CALI_SEX_3_OPTION_1 = "That was a joy to watch",
	CALI_SEX_3_OPTION_2 = "Don't you wanna let me help?",
	
	CALI_SEX_4_1 = """- Y-yeah, that was a bit crazy. Sorry, I'd like to stay alone for a bit.""",
	CALI_SEX_4_2 = """- Yeah, sorry, maybe some other time. I'd like to rest for a bit.""",
	CALI_SEX_4_ADDITIONAL = """

Cali makes sure you realize that it's time to leave and you close the door.""",
	CALI_FIGHTERS_FINISH_OPTION = "Cali's assignment",
	CALI_SIDEQUEST_4 = """Cali reports the completion to the receptionist who seems to be rather skeptical about it.

{color=aqua|Cali: — We did it so now you'll accept me, right?}

{color=yellow|Receptionist: — So you were helped I'm assuming?}

{color=aqua|Cali: — N-no? I worked with an esteemed adventurer. Besides that's not against the rules is it?} """,
	CALI_SIDEQUEST_5 = """The receptionist decides not to argue any further and stamps the contract's completion. Cali shines showing you the stamped paper. 

{color=aqua|Cali: — See? I'm not just some stray anymore! I'm Cali the goblin slayer!} """,
	CALI_SIDEQUEST_5_OPTION_1 = "Excellent work, I'm happy for you.",
	CALI_SIDEQUEST_5_OPTION_2 = "Oh? Planning to leave us mere mortals behind and set off on a grand adventure?",
	CALI_SIDEQUEST_6_1 = "{color=aqua|Cali: — Hey, I Couldn't have done that without you. Thanks, [name]. I hope there's more adventures to be had for us.}",
	CALI_SIDEQUEST_6_2 = "{color=aqua|Cali: — Don't be silly, I still owe you a great debt? And I've a feeling there's more adventure to be found in your company.}",
	CALI_SIDEQUEST_7 = """One morning you come upon Cali. Though normally full of cheer and causing chaos in the training yard, now the girl looks to be standing in the main hall in quiet contemplation. She seems to be speaking to herself, working out some sort of problem aloud before looking down at her clothing, sighing and shaking her head, her eyes clearly worried about something.

Making note of your approach the girl immediately walks over to you, her normal demeanor gone as she looks at you sheepishly.

Cali: — Oh, [Master]... Sorry. Um, Can I ask you something? Do you think I'm feminine? I mean I'm a girl but, feminine I'm not so sure about.""",
	CALI_SIDEQUEST_7_OPTION_1 = "You are more than feminine enough.",
	CALI_SIDEQUEST_7_OPTION_2 = "Well, not in particular",
	CALI_SIDEQUEST_7_OPTION_3 = "Why would it matter?",
	CALI_SIDEQUEST_8_1 = """Cali's ears droop on your response as she speaks.

Cali: — Heh, what's up with that? Are you trying to comfort me? I'm asking you a serious question here [master].""",
	CALI_SIDEQUEST_8_2 = "Cali: — Yeah, I thought so. Thanks for being honest.",
	CALI_SIDEQUEST_8 = "- I'm a girl, you know. Many people mention that I'm not very girly and it's been getting to me lately. I know I'm not usually acting like most girls, I'm pretty active and like games and adventurous stuff. I'm not sure what to do...",
	CALI_SIDEQUEST_8_OPTION_1 = "You can learn to be more feminine if you want to",
	CALI_SIDEQUEST_8_OPTION_2 = "I don't mind you acting like a tomboy.",
	CALI_SIDEQUEST_8_OPTION_2_alt = "You should try more 'manly' stuff to get your mind ",
	CALI_SIDEQUEST_9_1 = """- You think so..? I guess I want to. He-he, I've never really been good with stuff like dresses and etiquette. I guess, maybe it's time for me to try it. It may be fun for all we know. 

After thinking about it, you decide it might be a good idea to visit the Servants Guild for some ideas on making Cali more feminine.""",
	CALI_SIDEQUEST_9_2 = """- Y-you really think so? I mean I guess I'd like to, but I've never really been good with this stuff. Although for you I suppose I could try. 

After thinking about it, you decide it might be a good idea to visit the Servants Guild for some ideas on making Cali more feminine.""",
	CALI_SIDEQUEST_9_2_alt = """- Hmm, if you say so I'll believe you. I'm not sure where to start, though. Do you have something on your mind? 

After thinking about it, you decide it might be a good idea to visit Workers Guild for some ideas.""", #currentlyis meaningless due to no workers root
	CALI_SERVANTS_START_OPTION = "Ask on Cali's beneficence",
	CALI_SERVANTS_1 = """You approach ask around the guild helpers and they direct you to a general training for female servants. Basic skills of sewing, cooking and etiquette which will be a good spot for any girl to start with.

With a hint of doubt, Cali agrees to try these activities. 

- Huh, I'm not sure I'm good with this stuff...""",
	CALI_SERVANTS_1_OPTION_1 = "Don't worry, you can do it",
	CALI_SERVANTS_1_OPTION_2 = "There's first time for everything, you won't know until you try",
	CALI_SERVANTS_1_OPTION_3 = "You shouldn't get discouraged right as we started",
	CALI_SERVANTS_2 = """- Okay, okay, I'm gonna try it. 

After discussing it with the helpers, you are explained about general training for future servant girls which starts with figuring out the most talented aspects, dressing up, signing and formal language. Cali agrees to try this out.""",
	CALI_SERVANTS_3 = """As Cali is trying on a new long dress, she does not seem particularly comfortable in it, nor does it seem to suit her sharp features. Despite that she still undergoes etiquette lessons which visually tires her. """,
	CALI_SERVANTS_4 = """As she goes on a break, Cali spots a small cat moving through the backyard. Forgetting everything about the conduct, she tries to sprint to it but trips and falls due to her attire.

- O...Ouch... Crap!

Also forgetting to watch her tongue, she realized that her dress was torn because of the fall. Sadly, you'll have to pay for it. You decide to call it a day and make the wolf girl change back.""",
	CALI_SERVANTS_5 = """Cali seems to be in a sorry state as she comes back to you.

- Sorry, for some reason it's really hard for me to act like normal girls. And having to dress like this is so frustrating... Maybe I should forget about this. """,
	CALI_SERVANTS_5_OPTION_1 = "You shouldn't give up just yet",
	CALI_SERVANTS_5_OPTION_2 = "Maybe it isn't for you after all",
	CALI_SERVANTS_6 = """{color=yellow|Amelia: — I saw your training, Cali is it? Nice to meet you.}

{color=aqua|Cali: — Hello... Who are you?}

{color=yellow|Amelia: — Consider me a humble person who would like to give advice. I'm sorry these ears seem to eavesdrop on your conversation, but in truth I think you've taken a slightly wrong approach.}

{color=aqua|Cali: — What do you mean?}""",
	CALI_SERVANTS_7 = """{color=yellow|Amelia: — You are a girl and you want to look more like one, am I correct? However, as you've noticed, you aren't quite like other girls.}

Cali gets visually discouraged hearing this, but Amelia does not stop there.

{color=yellow|Amelia: — This does not mean you should give up, though. If some things don't work for you, others might.}

{color=aqua|Cali: — I still don't really understand.}

{color=yellow|Amelia: — Do you mind me taking some of your time? It won't cost you anything. I would not feel right if you left us unsatisfied.}""",
	CALI_SERVANTS_8 = """After a moment Cali agrees and Amelia takes her away from you. As you wait for about half an hour, Cali reappears before you and seems to be in a quite better mood than when she left. You can't quite make out what changed about her, but somehow she grabs your subconscious attention as she moves towards you. 

{color=aqua|Cali: — [Master]! Sorry for taking time...}

As she observes your reaction she starts smiling even more. """,
	CALI_SERVANTS_8_OPTION_1 = "You look pretty",
	CALI_SERVANTS_8_OPTION_2 = "What was it?",
	CALI_SERVANTS_8_OPTION_3 = "You seem somewhat different",
	CALI_SERVANTS_9 = """{color=yellow|Amelia: — He-he, so you notice it now? You don't need a complete attire change or a full makeup to emphasize your beauty. Some pose and expression training look a lot more natural for you. Well, that and a couple small woman secrets.}

You notice how Cali now looks at Amelia with respect. In the end, encouraged with the results, Cali agrees to occasionally visit and learn from Amelia. As she walks outside, Amelia speaks to you.

{color=yellow|Amelia: — She's a good girl, you better not betray her trust in you.}

Not waiting for your reply she disappears from sight as nonchalantly as she appeared. \n\n{color=green|Cali: Charm Factor +1\nCali:Charm +10}""",
	CALI_SEX_5 = """Near midday, you're engrossed in one form or another in the main hall. Cali trots up to you, the energy in her step identifying her long before she comes into view. Stopping short of you a respectful distance, she looked to you intently awaiting you to acknowledge her. After you look up at her she finally blurts out in an excited tone.

- [Master]! Hey [Master] that food cart is back in front of the mansion. Their meat dumplings smell so good! A-and I was wondering if you could buy us some...

You notice how Cali slightly lowered her voice, her hands slipping behind her back as a result of her training with Amelia. The posture was distracting to say the least.""",
	CALI_SEX_5_OPTION_1 = "Since you asked so nicely, here is the coin. Get enough for everyone. (-100 Gold)",
	CALI_SEX_5_OPTION_2 = "Sorry, we can't afford it right now. Perhaps next time",
	CALI_SEX_5_1 = """Cali gives you a small pout but refrains from protest.

- I see, well, another time then.""",
	CALI_SEX_6 = """You hand Cali the money and after a few moments she returns with a tray of dumplings. The smell is exactly as she mentioned. Passing them out to the other servants, she soon is sitting beside you after handing you one as well. 

The two of you eat in silence as you mull over the treat. Warm, soft, and expertly cooked you muse for a few moments about going outside yourself and seeing if you and the merchant can come to an agreement about deliveries of these treats.""",
	CALI_SEX_7 = """Cali finishes her treat soon after you. She would look up, peering around the main hall. She notices that the two of you are alone. Taking the wrapper from your treats, she looks up at you now with a grateful, excited look.

- Thanks [Master]. It was tasty. 

The girl's face reddens a bit as she again looks around the room, she looks nervous before she speaks.

- Amelia has been giving me tips and I was thinking about doing something for you in turn...""",
	CALI_SEX_8 = """Cali takes one more nervous look around before she looks back up to you with a mischievous look. Saying nothing more for now the girl soon slipped down to her knees in front of you. Taking a steadying breath she'd move to your trousers as she undid them easily, hand finding and wrapping around your shaft as she pulled it free.""",
	CALI_SEX_9 = """Cali stares up at you with a smile on her lips as she starts to gently squeeze your shaft. Her hand was unsure at first, before she'd start to intently pump your shaft. 

- Wow, I've never seen one this close before... It's warm.

The girl continues to stroke your member, obviously having greatly benefited from Amelia's tutelage. After a few moments of this you find yourself almost rocking back and forth, the girl's hand working you like she's far more experienced than she is.

- You seem to like this...

The girl would slowly pick up the speed she stroked you, until finally she leaned down, her mouth enveloping the head of your shaft.""",
	CALI_SEX_10 = """Cali leaned down doing her best to take in your member, the girl only getting a few inches inside of her small mouth before she'd have to back off, looking up at you with a blush.

- Huh, It's really big, jeez. I wonder if I can...

Cali would now start to envelope the head of your shaft again, this time using her hand to still pump the base as she sucked on the head, occasionally pumping her mouth just a bit deeper. It was an amazing feeling as you just laid there, calming yourself as you put a mental note to thank Amelia for this. """,
	CALI_SEX_11 = """Working without complaint, and making the most sensual noises you'd heard come from the girl, you did your best to hold on. Fighting the building urge of release before finally hitching your breath as you start to cum.""",
	CALI_SEX_12 = """To her credit even without much warning Cali keeps her lips sealed tightly around the head of your shaft. Her eyes surprised but her grip firm as you nearly came out of the seat. Soon panting in your position, you look down at the girl; her mouth slowly pulling off the head of your shaft as she keeps the cum there in her mouth. 

She looks up into your eyes a bit surprised now, the girl soon resolving herself and swallowing it all, letting out a little sigh before quickly returning a smile back at you.""",
	CALI_SEX_13 = """- W-well, hope that pleased you, [Master].

As she confirms your reaction she quickly retreats from sight to her duties. """,
	
	#needs addition of color tags
	CALI_HEIRLOOM_1 = """In the morning you look over a request for an audience: One in regards to your servant, Cali. After calling her over to you, you prepare to meet the visitor. """,
	CALI_HEIRLOOM_2 = """Cali becomes quiet on seeing the visitor, a middle aged human male.

{color=aqua|Visitor: — So this is where you've been, Cali. }

{color=yellow|Cali: — Uncle...}

{color=aqua|Visitor: — I'd heard rumors that you'd taken residence inside one of the city's mansions.. I've come to return you home.}""",
	CALI_HEIRLOOM_3 = """{color=yellow|Cali: — No, I like it in [name]'s service.}

{color=aqua|Uncle: — Have you ever considered your mother? She's been quite troubled since your disappearance.}

{color=yellow|Cali: — ...}""",
	CALI_HEIRLOOM_3_OPTION_1 = "I'm going to need an explanation",
	CALI_HEIRLOOM_3_OPTION_2 = "If your mother misses you that much, you should go home",
	CALI_HEIRLOOM_4_1 = """{color=aqua|Uncle: — Pardon me, Cali is the daughter of my sister. A few weeks ago she ran away from home. It seems you've offered her refuge, for that I thank you..

Uncle: — She's at that phase where she causes strife within the clan. I don't personally blame her for it.}

{color=yellow|Cali: — It's not a phase! I'm not going back to the clan, Uncle. I'd rather join bandits.} """,
	CALI_HEIRLOOM_4_2 = """{color=yellow|Cali: — No, you don't understand. They don't need me there. They only want me because of the stupid traditions. 
}
{color=aqua|Uncle: — They're not "stupid" traditions, this is quite serious and you know it. }

{color=yellow|Cali: — No, I'm staying here... I mean, if [name] is not against it.}""",
	CALI_HEIRLOOM_4_OPTION_1 = "You can stay if you want to.",
	CALI_HEIRLOOM_4_OPTION_2 = "I'm sorry but I'm not going against your family",
	CALI_HEIRLOOM_FINISH = """{color=yellow|Cali: — T-that... Damn it! If you don't want me here, I'll just leave then. 
}
{color=aqua|Uncle: — I thank you for your cooperation. Then we will be on our way. }

Cali soon leaves, never crossing your path again. Either from her being missing or not willing to let you find her.""",
	CALI_HEIRLOOM_5 = """{color=aqua|Uncle: — I see... Perhaps it's really no use trying to convince you to return then. Very well, in that case return the heirloom sword you've stolen and I'll leave you be.
}
Cali's protest sinks abruptly upon hearing it.

{color=yellow|Cali: — O-oh... Uh, can you give me some time? I don't have it right now...}

{color=aqua|Uncle: — I see. Very well, but I hope you do realize its importance to us. I'll be waiting until then.}""",
	CALI_HEIRLOOM_6_INIT = """As Cali's uncle leaves, you ask her what's been going on.

- Yeah, I ran away from home and I took a family heirloom with me. I thought it would be useful to me, you know? It's a weapon and I needed it for protection, or to become a warrior, you know? However, it didn't work out. When I met a group of bandits they easily disarmed me, then their boss got it. After that I was planning to be sold. The rest you know, since you found me.

- I haven't really considered getting it back. Honestly, I think it's fake, or at least it doesn't work for me. Maybe it's because I'm a girl, or because I never really fit in there... Regardless, now I need to return it. It's my fault for taking it. """,
	CALI_HEIRLOOM_6_OPTION_1 = "Everyone makes mistakes",
	CALI_HEIRLOOM_6_OPTION_2 = "Why did you decide to run away?",
	CALI_HEIRLOOM_6_OPTION_3 = "Why is this heirloom important?",
	CALI_HEIRLOOM_6_OPTION_4 = "Do you have any idea where it could be?",
	CALI_HEIRLOOM_6_1 = """- Ha-ha, right. Thanks for trying to cheer me up, but it's better to wait until I solve this.""",
	CALI_HEIRLOOM_6_2 = """Cali takes a long pause before she finally speaks up.

- I'm not sure I belong within the clan at all, and I thought this would be better for me and them. I don't feel comfortable talking more about it yet.""",
	CALI_HEIRLOOM_6_3 = """- I don't really know. The adults said it's a gift to our clan from the gods and will serve the next hero being born or something stupid like this. It didn't do a thing for me as I said. """,
	CALI_HEIRLOOM_7 = """- Yes, the bandits that captured me were near a village. I can at least recognize the place. The locals might have an idea where the bandits migrated to.""",
	CALI_HEIRLOOM_7_OPTION_1 = "Let's get your clan's sword then",
	CALI_HEIRLOOM_7_OPTION_2 = "Hope you don't mind some company",
	CALI_HEIRLOOM_8_1 = """- You don't have to come with me, but I appreciate it. I'll feel safer knowing you'll be watching my back.""",
	CALI_HEIRLOOM_8_2 = """Cali furiously shakes her head.

- Of course not! I'm happy you're still on my side. Hopefully one day I'll be able to pay you back for this.""",
	CALI_HEIRLOOM_8 = """Cali recalls the location where she believes the old bandit camp was and you realize it was near [settlement_name].""", # TODO ask about name
	CALI_FARMER_1 = """As you walk around searching for potential witnesses, one of the farmers spots you.

{color=aqua|Farmer: — Bandits! A bandit scout!}

You look puzzled as you realize that he points at Cali, who does not take it without objection.""",
	CALI_FARMER_2 = """{color=yellow|Cali: — Hey, I'm not a bandit!}

{color=aqua|Farmer: — You think I'd trust a bandit?! Call the guards!}""",
	CALI_FARMER_2_OPTION_1 = "Why do you say she is a bandit?",
	CALI_FARMER_2_OPTION_2 = "This is my servant I can vouch for her",
	CALI_FARMER_3 = """{color=aqua|Farmer: — She's a half-beast. In our lands most of them are either bandits, that or slaves and I see no leash on her. }

{color=yellow|Cali: — I'm telling you, I'm not a bandit, I'm a good girl!}

The farmer gives her a long, measuring look before finally calming down.

{color=aqua|Farmer: — Fine, but I'm gonna tell everyone about you. So if the raiders come after you leave, you'll make it into wanted lists. }""",
	CALI_FARMER_3_OPTION_1 = "We are actually hunting for a certain bandit group",
	CALI_FARMER_3_OPTION_2 = "If you've no love for bandits, perhaps you could help us",
	CALI_FARMER_4_2 = """As you explain to the farmer about the bandits you are looking for, he seems to tolerate Cali a bit more but does not warm up by much.

{color=aqua|Farmer: — Yeah, bandits are a plague alright. What do I get from helping you? They are nowhere around here. You know what? Since their last raid, my fence was ruined! How about you help me out?}

{color=yellow|Cali: — Help you? After calling me a bandit?!}

The farmer ignores Cali's remark and continues trying to persuade you into helping him.

{color=aqua|Farmer: — I need some lumber to repair it. You get me 200 Wood. I'll tell you where you can find them, since I overheard where they said they were headed off to.}""",
	CALI_FARMER_4_OPTION_1 = "You can have the wood for your fence (-200 Wood)",
	CALI_FARMER_4_OPTION_1_1 = "You can have the wood for your fence (-100 Wood)",
	CALI_FARMER_4_OPTION_2 = "Your fence doesn't seem *that* bad. (Worker)",
	CALI_FARMER_4_OPTION_3 = "We don't quite have that right now",
	CALI_FARMER_4_3 = """The farmer gives you a scrutinizing look realizing that he wasn't able to fool you. 

{color=aqua|Farmer: — Damn, fine, I thought a city [boy] like you would have no idea... I'll manage with 100 pieces of wood. }

You notice that Cali is looking at you with greater respect.""",
	CALI_FARMER_4_1 = """You find the Farmer you met before. His mood seems to be as bad as ever.""",
	CALI_FARMER_5 = """{color=aqua|Farmer: — Good, good...}

{color=yellow|Cali: — Are you gonna tell us now?}

{color=aqua|Farmer: — Yeah, yeah... The bandits were here around the time you asked. They made camp in the forest but after some time, the soldiers' patrols spooked them. They retreated to the hidden cave down the river. They have been laying low recently from what I gather. }

With the help of a farmer you mark location on your map and finally move on. It's safe to assume the bandits will try to put up a fight so you better be prepared.""",
	CALI_FARMER_6 = """{color=aqua|Farmer: — Then don't waste my time. I know you city folk have enough money on you. You help me, I help you. Until then.}""",
	CALI_BANDITS_1 = """- I think these are the ones. They passed me onto those slavers that you rescued me from. Can't wait to settle the score!""",
	CALI_BANDITS_1_OPTION_1 = "This shouldn't take long",
	CALI_BANDITS_1_OPTION_2 = "Don't rush ahead, it might be dangerous",
	CALI_BANDITS_1_OPTION_3 = "They'll be punished for hurting you",
	CALI_BANDITS_2_1 = "- Let's finish this and I'll finally be free.",
	CALI_BANDITS_2_2 = "- Right, sorry, I learned my lesson last time.",
	CALI_BANDITS_2_3 = """Cali visibly blushes at your protective statement but only nods in agreement.

- Y-yeah, let's do it...""",
	CALI_BANDITS_3 = """As the group leader collapses to the ground, you tie him up to start the interrogation. 

{color=aqua|Group Leader: — What have you cunts come here for?? What do you need from me?}

{color=aqua|Cali: — Remember me?}

{color=aqua|Group Leader: — Why would I remember some half-beast bitch?}""",
	CALI_BANDITS_4 = """Cali angrily kicks the bound bandit in the stomach eliciting a groan.

{color=yellow|Cali: — You sold me to slavers! After taking my things too. }

{color=aqua|Group Leader: — So what? Weren't you the one who jumped us? Yelling about how you're gonna become a famous hero.}

{color=yellow|Cali: — T-that's not the point! I want my stuff back. The sword you took from me!}

{color=aqua|Group Leader: — And I want the rebel princess to suck me off.}""",
	CALI_BANDITS_4_OPTION_1 = "Kick him a few more times, he's earned it",
	CALI_BANDITS_4_OPTION_2 = "You better not make her angry or I'm not going to protect you",
	CALI_BANDITS_5_1 = """Cali happily complies to your request, until the bandit starts begging her to stop..""",
	CALI_BANDITS_5_2 = """Cali prepares to continue with her justice when the leader decides to give in.""",
	CALI_BANDITS_5 = """{color=aqua|Group Leader: — Alright, fine, that's enough! I don't have it anyway! Some collector from Aliron paid more than enough coin for it!}

{color=yellow|Cali: — Dammit... Who was it?}

{color=aqua|Group Leader: — No clue, but he surely was rich. Maybe the richest fucker out there; had a beard and like a dozen bodyguards... That's all I know. That's all you came for?}""",
	CALI_BANDITS_5_OPTION_1 = "We can go now",
	CALI_BANDITS_5_OPTION_2 = "Cali, you can have some more fun",
	CALI_BANDITS_5_OPTION_3 = "We'll bring you to justice",
	CALI_BANDITS_6_1 = """You leave the tied bandit who stays silent as he likely expects to eventually untie himself.""",
	CALI_BANDITS_6_2 = """{color=yellow|Cali: — Oh yeah, I do think I earned some payback...}

Cali proceeds to exact her revenge on the helpless bandit for a few more minutes until his face is nearly unrecognizable. Slightly tired, Cali, joins you as you leave.""",
	CALI_BANDITS_6_3 = """{color=aqua|Group Leader: — No, wait, we can talk about this!}

{color=yellow|Cali: — Right. He's gotta answer for what I went through!}

Ignoring the bandit's pleas, you gag his mouth and deliver him to a nearby settlement's local guards..""",
	CALI_BANDITS_7 = """{color=yellow|Cali: — Can we even find it? I was sure they would have it but now...}""",
	CALI_BANDITS_7_OPTION_1 = "We'll go to the city and see what we can do.",
	CALI_BANDITS_7_OPTION_2 = "There shouldn't be so many rich collectors that we can't find it",
	CALI_BANDITS_8 = """{color=yellow|Cali: — Right, I shouldn't give up yet.}""",
	CALI_WILLIAM_INIT_OPTION = "Search for Collector", 
	CALI_WILLIAM_INIT = """After asking around, you have some luck learning that the most likely person to be the collector you are looking for, would be William. The man was one of the noble houses and retained his position even after the coup.

{color=yellow|Cali: — Let's go visit this guy, hopefully he still has it.}""",
	CALI_WILLIAM_OPTION = "Visit William's Mansion", 
	CALI_WILLIAM_REFUSE = """Your attempt to set up a visit with William has failed. The servants hinted at you being too insignificant to spend their Master's time on you. Perhaps, you'll have to gain more renown before returning...""",
	CALI_WILLIAM_1 = """You make your way inside the man's estate. Right as you make it inside, the wealth is so apparent that it makes you wonder if you could even dream of achieving something similar. Rows of servants politely greet you and guide you to the owner. 

After a brief acquaintance, you get to the business and explain what you came for. 

{color=aqua|William: — I'm glad you've visited, Mayor. What do I owe to this? }""",
	CALI_WILLIAM_1_OPTION_1 = "I heard you've purchased something that belongs to my servant",
	CALI_WILLIAM_1_OPTION_2 = "There was an item sold to you by bandits.", 
	CALI_WILLIAM_2 = """Cali timidly retells the events she went through. You can notice that she's rather intimidated by the splendor of this manor. 

{color=aqua|William: — Ah, yes, that sword. It has exquisite artwork but is of poor quality. It's true, I purchased it with the goal of trading it up at some point. And since you've come for it, my offer will be 5,000 gold. }

{color=yellow|Cali: — You're kidding me!? That price is insane!}

Cali blurts out in anger but the owner doesn't seem startled in the slightest.""",
	CALI_WILLIAM_2_OPTION_1 = "Cali's right, it is too expensive",
	CALI_WILLIAM_2_OPTION_2 = "That's for seller to decide", 
	CALI_WILLIAM_3 = """- Indeed it is priced at a premium, but there's no other quite like it, is there? I'm also in no real need for money so I can be patient enough to get the best offer for it.

{color=aqua|William: — But if you aren't able to provide such a sum... I guess I could show some mercy. This girl, Cali, right? I could agree to let her be my servant for a week.}

William accentuates the word 'Servant' making it clear that the service itself will have little to do with labor. 

{color=aqua|William: — You can be sure she'll be treated quite well. After all, you can see that my home is something worthy of a king's residence.}

As Cali is speechless to the proposition, But as her master it falls to you to decide.""",
	CALI_WILLIAM_3_1 = """Once again you and Cali visit the man's mansion to trade for Cali's heirloom. 

{color=aqua|William: — Let's skip the pleasantries this time. You've brought the money? Or will the girl be staying at my place? }""",
	CALI_WILLIAM_3_OPTION_1 = "We could discuss it",
	CALI_WILLIAM_3_OPTION_2 = "I'd rather pay", 
	CALI_WILLIAM_3_OPTION_3 = "I shall return later", 
	CALI_WILLIAM_4 = """William stays quiet, waiting for your proposal.""", 
	CALI_WILLIAM_4_OPTION_1 = "She is not really worth it. I might offer you a much better servant in exchange.",
	CALI_WILLIAM_4_OPTION_2 = "Cali is of a much higher caliber than you think.", 
	CALI_WILLIAM_4_OPTION_3 = "Cali will do this.", 
	CALI_WILLIAM_4_OPTION_4 = "Maybe this is too early to decide on just yet...", 
	CALI_WILLIAM_5 = """William considers the proposal for a moment then nods.

{color=aqua|William: — Very well, she does not seem all that refined I suppose.}

Cali's face is soon one of anger, but she wisely keeps quiet..

{color=aqua|William: — Then, I'd like to know of the servant you will be trading in her place. }""", 
	CALI_WILLIAM_5_OPTION_2 = "*Reconsider*", 
	CALI_WILLIAM_6 = """- Fine by me. It will be waiting for you unless another makes an offer. """, 
	CALI_WILLIAM_7 = """As you make it out of the mansion, Cali stops you. Her voice is low and she's clearly uncomfortable with the situation.

{color=yellow|Cali: — H-hey, I can't ask you for that much, and this is my fault in the first place... I think I should take the deal, it's just a week after all. }""",
	CALI_WILLIAM_7_OPTION_1 = "I'll consider it",
	CALI_WILLIAM_7_OPTION_2 = "I won't let him lay a hand on you even if you are okay with it", 
	CALI_WILLIAM_8_1 = """Cali nods and you quietly continue on your way back home.""",
	CALI_WILLIAM_8_2 = """- Hey now, you do care for me. I'm not really used to this... but thanks.

Cali blushes to your sudden protective statement, her opinion of you notably improves.""",
	CALI_WILLIAM_9 = """{color=aqua|William: — Very well, this will suffice. In this case, pleasure doing business with you.}""",
	CALI_REPLACEMENT_RETURNS = """At the arranged date, the [name], which you sent to William returns back to your mansion. """, 
	CALI_WILLIAM_10 = """Cali meekly nods at your decision and as you prepare the papers. She will stay at William's manor for now while you return home.""", 
	CALI_RETURNS = """At the arranged date, Cali returns back to your mansion. Even though she has brought her heirloom back, she profusely refuses to talk about anything that happened during her stay.""", 
	CALI_WILLIAM_11_1 = """The man takes another long look at Cali as she catches on to the implication, doing her best to appear femininely attractive. 

{color=aqua|William: — That... Might be true now that you point it out. Why would you bring this up now exactly?}""", 
	CALI_WILLIAM_11_2 = """William takes another long look at Cali but she does not seem to catch on with your intent, giving him a hostile look.

{color=aqua|William: — I'm not sure I can agree with you. 7 days or 5,000 gold, my offer stays unchanged.}""", 
	CALI_WILLIAM_11_1_OPTION_1 = "I want the sword and 3,000 gold for a week with her.",
	CALI_WILLIAM_11_1_OPTION_2 = "She shall only stay for 3 days",
	CALI_WILLIAM_12 = """The man stays quiet for some time as he deliberately inspects the wolf-girl. Finally he relents.

{color=aqua|William: — Very well, if your assessment is correct of her and her skills this will be well worth it.}

You take Cali aside and explain to her that this is her duty for now. 

{color=yellow|Cali: — Dammit! Why do I have to serve this guy! Ugh, if it wasn't for those bastards... }

In the end she accepted that she had to deal with the consequences of her own actions.""", 
	CALI_WILLIAM_13 = """As you sign the papers, Cali somewhat reluctantly leaves with William for the agreed term.""", 
	CALI_GRAT_BAD = """At the arranged date, Cali returns back to your mansion. Even though she has brought her heirloom back, she profusely refuses to talk about anything that happened during her stay. """,
	CALI_GRAT_1 = """As you return to the Mansion, Cali looks at you with reverence.

- I can't believe you really got it back! With this I'll be completely free.

- Uhm... Can I have it back? Please?""",
	CALI_GRAT_1_OPTION_1 = "Sure, this was for you after all",
	CALI_GRAT_1_OPTION_2 = "I think, you owe me something in return", 
	CALI_GRAT_1_OPTION_3 = "I've decided I'm going to keep it for myself", 
	CALI_GRAT_2 = """- Thank you! You've done so much for me...

After a moment of consideration Cali moves in closer to you and speaks with a hint of flirt in her voice. 

- Say, [Master], Maybe I could do something in return for you? It's not really comparable, but I want to return the favor.""",
	CALI_GRAT_2_OPTION_1 = "I surely can't turn down such an offer.",
	CALI_GRAT_2_OPTION_2 = "I'm not really interested.", 
	CALI_GRAT_3 = """- Aah, is that so? That's a shame.

Cali is visibly disappointed but does not insist. She takes the heirloom and after thanking you once again leaves to her room for preparations.""",
	CALI_GRAT_4 = """Cali quickly realizes your intention and smiles.

- Y-yeah, I'm not sure I'll be able to pay it all back, but I gotta start somewhere...?""",
	CALI_GRAT_5 = """Cali looks at you shocked, her words tinged with disbelief.

- No way, you aren't serious? You can't be...""",
	CALI_GRAT_5_OPTION_1 = "I'm just kidding",
	CALI_GRAT_5_OPTION_2 = "I'm serious", 
	CALI_GRAT_6 = """Cali looks like she's about to burst into tears but at the last moment she grits her teeth.

- Screw you! Idiot! I don't need you or this damn thing! 

Before you are able to do anything she bursts out of the mansion disappearing into the streets. It seems you aren't likely to see her again """,
	CALI_GRAT_7 = """- That was amazing.

As Cali lies next to you, she turns her head and asks with a somewhat nervous voice much unlike her.

- [Master]... I wanna ask you, what do you think of me?.. What am I to you?

As she looks into your eyes you realize that she's waiting for an answer.""",
	CALI_GRAT_7_OPTION_1 = "Lover",
	CALI_GRAT_7_OPTION_2 = "Friend", 
	CALI_GRAT_7_OPTION_3 = "Daughter", 
	CALI_GRAT_8_1 = """- I... I love you too, [Master]. Feels a bit weird to announce it now after we just did it... But I'm happy I did it with you. Oh, and that you feel the same.

Cali buries her face into your side and you decide to let her rest for today.""",
	CALI_GRAT_8_2 = """- A friend, huh... I thought this was more than a friendship.

Cali falls silent, apparently disappointed with your answer. After a couple minutes you quietly dress up and she leaves for future preparations.""",
	CALI_GRAT_8_3 = """Cali's eyes widened in surprise. However she finds your response amusing.

- R-really?! Ahaha. No way! Are you a pervert, [Master]? No, maybe I should call you "Daddy" then? I always thought that my father would be strict with me, but you're quite the opposite. 

The wolf-girl affectionately savors your new nickname for a few moments. 

- Daddy, did you know that wolves have lots of stamina? I wanna do it again...""",
	CALI_SWORD_RETURN_INIT = "Let's return your sword",
	CALI_SWORD_RETURN_1 = """- Right. I've tried it but it still feels like a big useless lump of iron. 

By the look of it, Cali was completely right. The heirloom sword did not feel like a proper weapon and could pass as a ritual tool at best.""",
	CALI_SWORD_RETURN_1_OPTION_1 = "Perhaps it's just not time yet",
	CALI_SWORD_RETURN_1_OPTION_2 = "It does look like a fraud",
	CALI_SWORD_RETURN_2 = """Cali shrugs in defeat and puts it away.

- Well, let's return it and this will be over. My uncle should be staying in a nearby tavern.""",
	CALI_SWORD_RETURN_3 = """You find Cali's uncle alone in a tavern room. The man looks troubled but becomes more active when he sees you.

{color=yellow|Cali: — I've got the heirloom. It wasn't easy but I managed.}

{color=aqua|Uncle: — 'Good, but I have bad news... Soon after I reported back that I found you, I received a message. It seems Hector has seized the power over the current head and he took your mother hostage. }

{color=yellow|Cali: — Wha-}

Cali freezes in place not knowing what to do. """,
	CALI_SWORD_RETURN_3_OPTION_1 = "Who's Hector?",
	CALI_SWORD_RETURN_3_OPTION_2 = "What exactly is going on?",
	CALI_SWORD_RETURN_4 = """{color=aqua|Uncle: — I guess I should explain. You see, in our clan there's a hereditary line of heroic leaders, blessed by gods. Those who are born into the line are expected to lead and protect it. Cali's mother belonged to it and she had to give birth to the next heir. However...}

{color=yellow|Cali: — I was born, — Cali proclaimed with unhindered reproach.}

{color=aqua|Uncle: — Yes, Cali was born out of wedlock. Her mother refused to give up on her and we never learned who her father could be. Still, she was accepted into the clan, but of course not everyone was happy about it. Her mother was expected to marry and have her next child become an heir, however she could not conceive again and her husband abandoned them before eventually disappearing. 

Uncle: — So after that, it was decided that Cali is needed to fulfill that role and give us the next heir. It was a difficult decision, especially given her nature, but this is preferable to having no heir at all and ultimately this is a fate decided by gods.}""",
	CALI_SWORD_RETURN_5 = """{color=aqua|Uncle: — Hector, her expected partner, comes from the second family which is in line to become clan leaders themselves. So it was decided upon...}

{color=yellow|Cali: — Me, becoming his wife, so our child would be the next worthy heir or something stupid like that.}

{color=aqua|Uncle: — Yes, that was the idea. But now he just wants to have the sword for himself, it seems.}""",
	CALI_SWORD_RETURN_5_OPTION_1 = "Maybe there was a misunderstanding",
	CALI_SWORD_RETURN_5_OPTION_2 = "Not a good idea to give it to him",
	CALI_SWORD_RETURN_6 = """Cali gives off a troubled vibe, clearly the situation has put a strain on her.

{color=aqua|Uncle: — Now that your mother is a hostage, there's no option but to return the heirloom to him. Even though I hate it, what option do we really have left?}

{color=yellow|Cali: — ...I should go. Even if we weren't close, she's still my mother.}

{color=aqua|Uncle: — At least have him go with you, he looks capable..}""",
	CALI_SWORD_RETURN_6_OPTION_1 = "Don't worry, I'll come with you",
	CALI_SWORD_RETURN_6_OPTION_2 = "Since there's nothing better to do I'll tag along ",
	CALI_SWORD_RETURN_7 = """Cali looks warmly at you and nods. 

{color=aqua|Uncle: — Okay, make yourself preparations and we'll depart to our home shortly.}""",
	CALI_HECTOR_INIT = "Follow Cali",
	CALI_HECTOR_1 = """As you come to the Clan's village, you follow Cali from behind as she carries her sword holding it close to the chest. Your visit has been anticipated and many people start to gather observing from a distance. 

Soon a group of armed men come out in an attempt to greet you. Judging from Cali's reaction, it is headed by Hector. A bit behind them you spot a lone woman being watched over by a couple of other guards realizing that it should be Cali's mother.""",
	CALI_HECTOR_2 = """As Cali moves ahead, you are being stopped by a few guards.

{color=aqua|Hector: — Look who returned home. I thought you were long dead, Cali.}

{color=yellow|Cali: — You can see I'm quite fine.}""",
	CALI_HECTOR_3 = """{color=aqua|Hector: — Not that I care. You've brought what you've stolen?}

{color=yellow|Cali: — I didn't steal it. It belonged to me. }

{color=aqua|Hector: — Hmph. Now pass it.}

Cali tensed, being reluctant to part with the sword.""",
	CALI_HECTOR_4 = """{color=yellow|Cali: — First let my mother go!}

{color=aqua|Hector: — You dare to make demands of me? The clan's leader?}

{color=yellow|Cali: — You are no leader! A leader wouldn't hold a helpless woman hostage!}

{color=aqua|Hector: — Enough!}""",
	CALI_HECTOR_5 = """As Hector moved closer to Cali, she moved away from him, but there was no escape as the place was surrounded by Hector's men. Hector soon laid hands on the sword, tugging at it to force it from her grasp

To his surprise, Cali refused to let it go. Instead she was stubbornly holding fast against the much larger man.

{color=aqua|Hector: — You little bitch, who do you think you are!}

{color=yellow|Cali: — I won't surrender it to an evil man like you!}""",
	CALI_HECTOR_6 = """Despite everything going on, no one attempts to intervene; unsure if this is also the will of a higher being. Enraged by her words, Hector uses his free hand to draw his sword as Cali's eyes widen in surprise. 

As his blade is brought down, Cali is unable to escape as she's holding on to her own sword, the blade useless. """,
	CALI_HECTOR_7 = """*Slash*

Cali instinctively closed her eyes only to realize she was unharmed. Her mother however fell beside her, cut down by Hector's blade..

To everyone's shock, she dashed in to stop Hector who now backed away, enraged at the intervention.

{color=aqua|Hector: — Dumb bitch! This is all your fault. }

Cali is speechless as her emotions take hold of her. The sword acted as a natural extension in her hand as she attacked Hector in retribution. Despite her training she still was far from a capable fencer, yet her sword shined brightly as she pressed the attack. """,
	CALI_HECTOR_8 = """Sorely pressed, Hector addressed the soldiers loyal to him in a feeble attempt to bring the situation under control.

{color=aqua|Hector: — What are you waiting for? Cut her down!}

With Cali being outnumbered it falls to you to even the odds.""",
	CALI_FINALE_1 = """With his men defeated, Hector raises his sword in defense as Cali strikes. The block is useless as his sword shatters on contact like another miracle. Still enraged, Cali delivers another blow that cleaves through the man's armor, making him fall in defeat;a terrified look showing over his face.

However, the girl's eyes show no intention of relenting...""",
	CALI_FINALE_1_OPTION_1 = "Stop her",
	CALI_FINALE_1_OPTION_2 = "Let her kill him",
	CALI_FINALE_2_1 = """You call out to Cali before she deals the finishing blow. You see her shaking as the edge of the sword rests mere inches from his neck. Slowly she regains her senses, moving away from Hector as he loses consciousness.""",
	CALI_FINALE_2_2 = """You decide it's not your place to interfere as Cali deals the finishing blow; the sword tumbling out of her hands a moment later. """,
	CALI_FINALE_3 = """With the battle over, Cali quickly moves to her mother's body. To her surprise she's still breathing, but the size of her wound leaves no question about the lethality of her injury.

{color=yellow|Cali: — Mother!.. Mom! Please, you can't die!}

{color=aqua|Mother: — Cali, you've really grown up... I knew... What I was doing... What would happen to me...But I'm glad you're safe... }

{color=yellow|Cali: — ..Glad? What are you talking about?} """,
	CALI_FINALE_4 = """{color=aqua|Mother: — Don't you... see it? You *are* one of the chosen... So it was fate all along... I've made many mistakes... in my lifetime... But protecting you was not one of them... }

Cali had no words to reply as tears welled up in her eyes. With a single stroke, her mother brushed her cheek.""",
	CALI_FINALE_5 = """After a few days of grieving, Cali seems ready to return with you. She refused to take her place as the next clan leader and after all that has happened it's probably for the best. 

- You know, [Master], I think I understood what mom meant by that. I never really thought of her as a caring parent, but getting rid of me would have been a lot easier for her... 

- But I'd never come to that conclusion without you, [Master]. I want to thank you for that... Now that I'm truly free. You don't mind having me around, right?""",
	CALI_FINALE_5_OPTION_1 = "Don't get so serious now, it's unlike you",
	CALI_FINALE_5_OPTION_2 = "You've surely matured",
	CALI_FINALE_5_OPTION_3 = "It's been a mutual benefit",
	CALI_FINALE_6_1 = """- Ha-ha, you think? I guess I better go punish some bandits to relax. I mean, we...""",
	CALI_FINALE_6_3 = """- W-what are you thinking about? You know, you should be careful, as I'm still in line to be the next heir's mother... although, somehow I feel a lot less stressed about it.""",
	
	CALI_GRAT_SEX_1 = """Cali trembles as you lift her up now, her small frame easy to carry as you position her now over your shaft, eyes locking with hers. There is a slight tremble to her, a panting motion of her figure as you grasp tightly on the female's hips now, soon starting to press at her. 

Ever a tight partner the girls entrance though damp still isn't accommodating, driving you to have to grind her on you now, her figure still shuddering, little moans escaping her as she's soon looking intently up at you.

- [Master]...

With her help you soon start to press into her, the teens tight entrance squeezing you firmly as each inch stretches her out further. Cali doesn't complain, instead letting gravity take over as she loosens her grip on you slightly, sliding her body down fully onto your shaft nearly instantly, a soft whimper coming from her mouth as she looks up at you now.
""",
	CALI_GRAT_SEX_2 = """The sight of the girl looking up at you wanting, panting drives you on as you start to easily bounce her on you now, taking her deep as her tight entrance threatens to expel you just from her clenching, only gravity and a somewhat rough pace keeping you inside the tight female as she continually clenched.

With time the girl would relax more, being more pliable in your hands as you continued your thrusting into her, her eyes staying locked on you as she squeezed tighter with her legs, her body shaking slightly from the stimulation.

- P-please... [Master]... Aaah-ah...""",
	CALI_GRAT_SEX_3 = """The wolf girl half pleads for it now, her hips writhing on you after only a few moments longer, her eyes hazing as she tightens up around you, her ankles locking tight as you feel the tell tell sign of her climax starting now. 

You could slow down and take your time, enjoy her a bit longer now, but her whimpers and soft moans soon urge you to join her, the two of you finding yourselves grinding hungrily against each other, an eruption of mess between the two of you as Cali squeezes her eyes shut, shaking in your grasp.""",
	
	CALI_GRAT_SEX_ALTER_1 = """Cali is shaking as you lift her up now, her eyes moving to yours before looking away, a blush obvious on her face.  That blush she wears turns even darker as she feels the warmth of your shaft resting between her legs, the head gliding between her petals.  

You take your time with this, soft whimpers coming from Cali's mouth, though it's obvious she's trying to suppress them.  As you continue your grinding it's clear by her shaking that she's nervous, the gulp the girl makes audible as she looks up at you, her eyes wide. 

- [Master] I'm... ok I'm ready...

You feel a bit of pride swell in you as the girl is being so brave for you, serving your needs even with her own fears.  After a few more minutes of grinding both of you are panting, your eyes locking for a brief moment as you start to press now, drawing louder whimpers from the half-wolf as you start to press into her body, her eyes closed as you take her slowly. """,
	CALI_GRAT_SEX_ALTER_2 = """Cali's legs squeeze tight around you as you find yourself half inside of her now, her eyes closed as she's clenched around your shaft like a vice.  The squeezing only would drive you on as you grip her hips, pushing deep into her until your hips and hers were pressed against each other, the whimpers from the teens mouth clearly audible.

- Aah-hah... It's not... as bad as I imagined.

Her body was well worth the wait. The female's body light in your hands as you began your driving into her, her hole squeezing firmly in protest of the intrusion, but unable to stop it either way.  Cali for her own part either by embarrassment or in an attempt to appear brave for you bites down on her lip to quiet herself, with mixed results.""",
	CALI_GRAT_SEX_ALTER_3 = """
Cali's whimpers were cute, arousing even as the girl allowed her body to serve whatever needs you had now.  Your hands were quite tight on her figure as you pumped into her, no protests coming from the virgin girl as you drove deep into her womanhood.  Soon enough you'd find yourself buried to the base of your shaft inside of her, Cali taking you fully on her first time as she squeezes you naturally, only adding to your pleasure.

After such an effort on her part it'd be an understatement to say you were pleased with her performance, your hips pumping hungrily into the teen as she continues to try to stifle her whimpers. Eventually she loses the struggle as she gasps out, her eyes going wide for a few moments as you fill her. Your cum shoots deep into her body as she goes rigid, her back arching hard as you leave every single drop in her.""",
	CALI_GRAT_SEX_ALTER_4 = """
Everything is quiet for a few moments as you hold her there, her breath coming out in ragged pants before she sneaks a look at you.  

- I'm... glad it was you [Master].""",
	
	CALI_AMELIA_1 = """As is usual today Cali has been attending her lessons with Amelia at the Servant's Guild. This time however Amelia can't help but notice the girl is distracted, her effort far from her usual.

{color=aqua|Amelia: — Cali, tell me, is there something bothering you?}

Cali would snap her head up while being deep in thought, looking at Amelia with a somewhat surprised look on her face.

{color=yellow|Cali: — Ah, no, it's nothing.}

{color=yellow|Amelia: — It's alright Cali, you can trust me. If not as your mentor, at least as your friend.}""",
	CALI_AMELIA_2 = """Cali thinks for a long moment before taking a slow breath.

{color=yellow|Cali: — I've been trying to get [master]'s attention here lately. But it's not working. It's like [he] doesn't notice me at all...}

{color=aqua|Amelia: — I see. Yes, that would be disheartening. }

Cali looks down now quiet, but nodding in agreement to her mentor's words.

{color=aqua|Amelia: — But, stressed and distressed as you are, your lessons might not be particularly effective today. I think for now rest would suit you better. Perhaps a massage.}""",
	CALI_AMELIA_3 = """Cali would mull it over for a few moments before relenting and nodding. The girl was in no place to argue about a chance to relax. Amelia for her part was an expert in this sort of fare, her hands sliding over the girls shoulders now as she'd start to work the tension out of the girls shoulders. Moments later Cali's only sounds were pleased moans and sighs as Amelia demonstrated her expertise in massage. The contact was needed for the girl as she'd soon lean into the contact pressing against Amelia now.

Cali's breathing would pick up as she pulled herself closer to Amelia now, the girl nearly in her lap as Cali looked over at her now, giving into the sensations as she leaned closer. It was unexpected for Amelia, Cali as well as the two of them kissed now, bodies pressing against one another as their kiss deepened. Hands that were massaging her before were now exploring, grasping lightly at Cali's body, only to be interested as a few loud bangs could be heard close by, both ladies jumping a bit and distancing themselves slightly.""",

	CALI_AMELIA_3_1 = """{color=yellow|Cali: — Ah... Uhh... I'm not...}

{color=aqua|Amelia: — I apologize, Cali, that was...nice. It seems both of us are plenty up currently. }

Amelia would place her hand on her chin thinking before continuing as she looked Cali over. 

{color=aqua|Amelia: — Though, if that wasn't to your distaste, I've a room where we won't be interrupted.}

As Cali averts her blushed gaze, she still responds with a willing nod.""",
	CALI_AMELIA_4 = """Cali followed Amelia deeper into the Guild's quarters now finding herself in a dimly lit room, soft scents wafting through the air as she was led to a rather large bed.

{color=aqua|Amelia: — It's been some time since I've had company here.}

Cali was still looking the room over, standing at the entrance as Amelia guided her onto the bed now, hand resting on her lower back as the wolf-girl was turned, resting against the edge as Amelia joined her.

{color=yellow|Cali: — I'm... not sure what to do...it's nice here.}

{color=aqua|Amelia: — Just enjoy yourself Cali, you are my guest after all.}""",
CALI_AMELIA_4_1 = """Cali would distract herself in the small talk as Amelia pulled the girl closer, her legs straddling just one of Cali's, moving closer as she just smiled.

{color=aqua|Amelia: — I know that it can be frustrating not catching the eye of the man you desire, but for today we've no need to worry about that.}

Cali would begin to respond but instead let a soft little moan as Amelia slipped the girls' top up, her hand grasping the girl's soft breasts. They weren't large, but her youthful body was so lovely that Amelia couldn't help but explore them. """,
	CALI_AMELIA_5 = """A few moments later the two were kissing again, uninterrupted as soon as their tongues would meet. Amelia's hips softly rubbing over her bare leg now. After breath demanded them break the kiss, Cali's face was a deep shade of red as Amelia's hand slipped lower, moving her panties aside.

{color=yellow|Cali: — A-ah!}

Cali would speak in a dazed panic before devolving her protests into a needy groan as the woman gently started to rub. Protests now stifled Amelia would continue to do what was needed. A few moments into the girl's stimulation, Amelia would move her hand now up to her dress, pulling it down to expose her breasts for the girl.""",
	CALI_AMELIA_6 = """Cali would soon lean in kissing Amelia again now, the kisses needy and desperate as the girl's desire grew more. The soft sounds of lips and tongues intertwined would soon be interrupted by a throaty moan now, Amelia having slipped her fingers into the girl.

The younger girl was panting into the kisses now, aroused and desperate to please, to be acknowledged. She could feel the heat of Amelia's womanhood as the woman grinded her hips over her thigh now, just adding to her arousal.

Eventually breath again demanded the kiss broken as Cali was panting, squirming from arousal and stimulation. 

{color=yellow|Cali: — I-I'm a-almost-}

She was cut off by another kiss now, her body contracting on the woman's fingers as she started to climax, her hips rolling as she did all that she could to extend the sensation.""",
	CALI_AMELIA_7 = """Eventually the two just sat there, Amelia rubbing the girl's shoulders again as she softly groaned.

{color=aqua|Amelia: — Now, do you feel better?}

Cali was shy now realizing what she had just done and nodded now, still blushing hard.

{color=yellow|Cali: — Was this...?}

{color=aqua|Amelia: — Don't fret over it, a couple of girls can have a bit of private fun once in a while. You should focus on working harder towards your goal instead.}""",
	
	LILIA_PRELUDE1 = """As you walk through the streets, you eavesdrop an uncommon conversation apparently from one of adventurers. 

{color=yellow|Citizen A: — I'm telling you, After I ended up at that village, there was some crazy red haired fairy. She was observing me from the distance like I'm some sort of exotic animal.}

{color=aqua|Citizen B: — That's like for all of them, no? }

{color=yellow|Citizen A: — Yeah, but the others simply scattered away and paid me no attention. I couldn't bring myself to call her out...}""",
	LILIA_PRELUDE2 = "You decide to make a note about this and perhaps visit it next time you go to elven forests.",
	
	LILIA_STARTING_1 = """As you move through the village with occasional elves and fae observing you, you notice that most residents stay very cautious and turn away once your gaze falls upon them. That is, except for one very curious fairy with long red hair. After she realizes that she has caught your attention, she dashes at you, completely ignoring any formalities as the releases and rapid torrent of questions.

 — Hi! I'm Lilia. What's your name? Are you an adventurer? You are so big! We don't get people like you here often. What brought you here?""",
	LILIA_STARTING_1_OPTION_1 = "Nice to meet you, I'm [name].",
	LILIA_STARTING_1_OPTION_2 = "Woah, not so fast",
	LILIA_STARTING_1_OPTION_3 = "You really know no manners, do you?",
	LILIA_STARTING_2_1 = """ — Ah, sorry, it's just so exciting and rare to meet someone like you! You look so big and strong!

- Hey, hey, what did you come for? 

Unlike most other locals, Lilia is quite friendly towards you.. """,
	LILIA_STARTING_2_2 = """- Hey, hey, what did you come for? 

Unlike most other locals, Lilia is quite friendly towards you..""",
	LILIA_STARTING_2_3 = """- I like it, alright. But I've lived here for all I can remember. It can get reeeaal boring you know.""",
	LILIA_STARTING_2_OPTION_1 = "Do you wanna go somewhere more private?",
	LILIA_STARTING_2_OPTION_2 = "Do you wanna join me?",
	LILIA_STARTING_2_OPTION_3 = "How do you like it here?",
	LILIA_STARTING_2_OPTION_4 = "I should go now, see you another time",
	LILIA_SEDUCTION_1 = """Lilia gives you a contemplative look but it seems she catches on to your intentions, though she doesn't immediately reject the proposal.

- You're strange. I dunno, I have no experience in such things...""",
	LILIA_SEDUCTION_1_OPTION_1 = "I can see you're practically shaking near me though (Sex Factor)",
	LILIA_SEDUCTION_1_OPTION_2 = "I have plenty of experience",
	LILIA_SEDUCTION_1_OPTION_3 = "I could give you something nice",
	LILIA_SEDUCTION_1_OPTION_4 = "But you must be curious what it is like",
	LILIA_SEDUCTION_2_2AND3 = "- Sorry, I don't think I wanna just yet.",
	LILIA_SEDUCTION_2_4 = "- He-he, other girls have been talking a lot about it, but I'm still not sure. You are so big and stuff...",
	LILIA_SEDUCTION_2_4_OPTION_1 = "But isn't that what interests you?",
	LILIA_SEDUCTION_2_4_OPTION_2 = "I can be very gentle",
	LILIA_SEDUCTION_2_4_OPTION_3 = "If something goes wrong we can always patch things up",
	LILIA_SEDUCTION_2_4_2AND3 = "Lilia acts as if this talk didn't happen and falls silent.",
#	LILIA_SEX_SCENE_1_1 = """- I guess... 
#
#Lilia falls silent as if conflicted, but finally looks like she lost any patience. 
#
#- Ah, fine, who knows when there will be another chance like this?
#
#The fairy takes a quick look around if anyone is paying attention, then grabs your hand pulling you into a nearby bush.""",
	LILIA_SEX_SCENE_0 = """As Lilia hears your suggestion, her lips turn into a mischievous smile. 

- Sure! I was afraid you wouldn't ask.""",
	LILIA_SEX_SCENE_1 = """The fae approaches, staring up at you, due to the large size difference. A few moments later, she reaches up grasping your hand after looking around the forest. It doesn't take her long to guide you just a bit deeper into a nice shaded alcove. 

The fairy darts around now, a literal bundle of energy moving this and that, even adjusting branches as you're not quite sure what she's doing at first, but soon realizes she's setting her stage; making everything perfect, at least in her eyes. Finally having everything settled Lilia turns to you looking at you expectantly. 

- Ok! Everything is perfect!""",


	LILIA_SEX_SCENE_1_1 = """Lilia finishes that phrase as one of the branches she so carefully moved to hide just a bit of the sun readjusted with a pop, landing with a thud at her side now. After a few seconds she sighs and acknowledges it before moving over to put it back only to be caught by her hand now, pulled back until her back is against you.

- Oh! I mean if you insist we can leave it there...

The girl seems to shiver a bit by either fear or excitement as your hand slides up her side, undoing the broach on her dress to expose her chest now, two small but soft mounds. A soft sigh from the female answers your question before as she grinds her hips back against you, likely without even realizing it.

You two stay like this for a few moments, her panting and softly moaning as you move aside the delicate cloth, her breast soft in your hand as finally your hand slides over the heat of her sex, only to find her soaked, the tiny hole easily stretching to allow your fingers. 

- T-that's so much better than my fingers... take me [name]. Please...""",
	LILIA_SEX_SCENE_2 = """Your trousers are open moments later, the tiny fair easily held up in front of you now as you start to grind on that lovely little hole. Lilia makes a soft little moan during and then a much louder shrill one as you start to press into her, stretching and breaking the small fae's hymen around your shaft.

You take things slow, hips pumping into hers before realizing it's just easier to bounce her back against your shaft, nearly bottoming out easier than expected. Lilia for her part continued to let lewd noises slip from her mouth that you'd scarcely believe came from her, only driving you on to taking her further, harder now.

She wasn't an experienced lover, but her tightness and willingness to please helped make up for it. Occasionally you'd have to stop as the girl shuddered hard on your shaft, making you unsure if she was cumming, or just shaking from how deep you were in her body. Each time Lilia had to stop this way she'd soon urge you on, telling you to take her harder now.""",
	LILIA_SEX_SCENE_3 = """The mating continued on for a while before you started to pulse inside of her, the girl already panting hard, giving pleasured little sounds before making an ecstatic sound as you started to cum inside of her, soaking her inner walls and filling her womb. She stayed there for a few moments, her hips shaking as she was literally clamped down on your cock, her stomach slightly inflated as she panted out.

- ...Amazing! Let's do this again some other time, okay?'""",
	LILIA_RECRUIT_1_1 = """- Eh? I dunno, I don't think I know you well enough, [name].""",
	LILIA_RECRUIT_1_2 = """- Going with you..? Huh, I'm not sure, I never left the forests. I heard humans are pretty scary.""",
	LILIA_RECRUIT_1_OPTION_1 = "I'd love to have you at my place (Charm Factor)",
	LILIA_RECRUIT_1_OPTION_2 = "Eventually you get used to it",
	LILIA_RECRUIT_1_OPTION_3 = "Humans can be pretty bad, but you'll be under my protection",
	LILIA_RECRUIT_1_OPTION_4 = "You aren't scared of me though",
	LILIA_RECRUIT_NO = "- I think I'll pass on it, I'm not ready to leave my home just yet.",
	LILIA_RECRUIT_NO_RED = """{color=red|Failure}

- I think I'll pass on it, I'm not ready to leave my home just yet.""",
	LILIA_RECRUITED = """Lilia hesitates for a bit but her attitude towards you eventually sways her choice.

- Fine, I'd hate to wait for your next visit. Let me grab a few of my things!""",
	LILIA_RECRUITED_GREEN = """{color=green|Success}

Lilia hesitates for a bit but her attitude towards you eventually sways her choice.

- Fine, I'd hate to wait for your next visit. Let me grab a few of my things!""",
	LILIA_RECRUIT_1_4 = """- He-he, that's true, you aren't scary at all. But what am I gonna do there?""",
	LILIA_RECRUIT_1_4_OPTION_1 = """You could be a performer""",
	LILIA_RECRUIT_1_4_OPTION_2 = """I wouldn't ask from you for more than what we were already doing""",
	LILIA_RECRUIT_1_4_OPTION_3 = """There's a lot of possibilities for adventure""",
	
	SICK_LILIA_START = """After a few days since Lilia moved in with you, one morning you find her in bed extremely weakened.

- [name]... I don't feel... so well... Can I... Please, rest for today?

Your fear settles in as you realize that she must be sick. Your concerns are growing worse as your attempts with magic or regular medicine seems unable to improve her condition. As you let her rest, you decide that you should visit someone who might know what's going on. Out of all your acquaintances, Myr seems to be the most logical choice.""",
	SICK_LILIA_1 = """You explain to Myr the events behind Lilia's sickness hoping she would be able to help. To this she reacts as disinterested as ever. 

- A wild fae is unsuited for living in the city, their kind is more reliant on natural energies, making this place like living in the desert without water for you and I. She'll need time for her body to adjust to these harsh conditions. Obviously fairies raised in captivity are already adapted and don't experience such issues.""",
	SICK_LILIA_1_OPTION_1 = "So she's going to be alright?",
	SICK_LILIA_1_OPTION_2 = "Is there anything I could do to help her?",
	SICK_LILIA_2_1 = """- It's hard to tell if her body will be able to deal with it naturally at this point.

- There's a brew which will make it easier for her to rebuild her mana reserves without her home forest. Let me write down a recipe for you.""",
	SICK_LILIA_2_2 = """- There's a brew which will make it easier for her to rebuild her mana reserves without her home forest. Let me write down a recipe for you.""",
	SICK_LILIA_2_OPTION_1 = "I don't have to pay?",
	SICK_LILIA_2_OPTION_2 = "Thanks a lot, you are a true savior",
	SICK_LILIA_3_1 = """- I only wrote you a formula, you're the one who will need to produce it. It also gets you out of my hair.

- One more thing... I hope you'll have the decency to not sexually abuse her while she's in this state.""",
	SICK_LILIA_3_2 = """Myr stays oblivious to your praises and passes you the paper sheet. 

- One more thing... I hope you'll have the decency to not sexually abuse her while she's in this state.""",
	SICK_LILIA_3_OPTION_1 = "I'd never do that.",
	SICK_LILIA_3_OPTION_2 = "What do you take me for!?",
	SICK_LILIA_4_1 = """- I hope so. But your reputation is not as flawless as you imply so I felt it necessary. Now that we are done, leave me be.""",
	SICK_LILIA_4_2 = """- A sexual deviant who dragged a pure wild fairy from the forest because those things are sexual addicts.""",
	SICK_LILIA_4_2_OPTION_1 = "It's not like that, it's purely coincidental and she wanted to come on her own",
	SICK_LILIA_4_2_OPTION_2 = "Hey, you can't blame me, that's what any man would do",
	SICK_LILIA_5 = """Myr sighs heavily while making a gesture for you to leave as this discussion is finished. With no other choice you leave her office.""",
	SICK_LILIA_6 = """As you make your way out of Myr's office and read through her notes you spot the line which directs you to go to "my crook of a sister", realizing you'll have to visit Xari for that. """,
	
	XARI_CLOTHES_1 = """- Hey, [name]. It's been a while. Did Myr sent you on some errand again?""",
	XARI_CLOTHES_1_OPTION_1 = "I have this note here...",
	XARI_CLOTHES_1_OPTION_2 = "Not quite",
	XARI_CLOTHES_2 = """As Xari reads through the paper note, you explain that you need a certain medicine. She quickly grasps on that.

- Yeah, I can brew this, no problem. Good thing you came here since in the city you wouldn't be able to make such a pure substance. That'll be 500 gold.""",
	XARI_CLOTHES_2_OPTION_1 = "Pay (500 Gold)",
	XARI_CLOTHES_2_OPTION_2 = "I don't have the money yet...",
	XARI_CLOTHES_3_1 = """- Great, let me start my preparations...""",
	XARI_CLOTHES_3_2 = """- Well then, I'll be right here. It shouldn't take you long after all.""",
	XARI_CLOTHES_4 = """As you pass money to Xari, she begins searching through her cluttered shelves. 

- You know... You are curing a fairy, am I right? Since this is gonna take some time anyway, how about you do something for me and I'll make it a tad more special?

- A few days ago there was a troll who stole some of my clothes which I was drying. I was planning to go teach him a lesson but you could do that, couldn't you? Then I can make this brew a bit more effective.

- With fairies' natural affinity to magic it's pretty easy to give them a boost every once in a while. I can make her smarter, more loyal or a tad lewder.""",
	XARI_CLOTHES_4_OPTION_1 = "I'd rather pass on this task",
	XARI_CLOTHES_4_OPTION_2 = "Okay, make her smarter (+Wit Factor, +Magic Factor)",
	XARI_CLOTHES_4_OPTION_3 = "Okay, make her more loyal (+Tame Factor)",
	XARI_CLOTHES_4_OPTION_4 = "Okay, make her lewder (+Sex Factor) ",
	XARI_CLOTHES_5_1 = """- Fine, I'll get them myself then. Hold on then, this won't take long...""",
	XARI_CLOTHES_6 = """- Done. Just don't give it to her all at once. She should improve after a couple days.

Xari passes you a small phial filled with fluid and sends you off.""",
	XARI_CLOTHES_5_2AND3AND4 = """- Alright, it's not far from here. I'll likely be done when you return so go and teach that brute a lesson.""",
	
	TROLL_CLOTHES_1 = """As you get to the cave as instructed by Xari, you quickly spot its dweller who does not attack you just yet.

- You... come... Rags...

Out of his poor attempt to speak the common tongue you realize that he knows what you've come for. It's known trolls have a great smell so he likely knows you've visited Xari's place. 

- Trade... Food...

Looks like the troll is willing to part with his loot in exchange for something edible.""",
	TROLL_CLOTHES_1_OPTION_1 = "Give him 50 meat (-50 Meat)",
	TROLL_CLOTHES_1_OPTION_2 = "Tell him about a deer's grazing spot you found on your way here (Hunter)",
	TROLL_CLOTHES_1_OPTION_3 = "I don't trade with filthy monsters (Fight)",
	TROLL_CLOTHES_1_OPTION_4 = "Leave",
	TROLL_CLOTHES_2_1 = """You manage to trade for Xari's clothes, which seem much less clean than what they would have been before drying. Hoping this won't disappoint her too much, you leave the troll alone.""",
	TROLL_CLOTHES_2_2 = """You manage to barely explain yourself so the troll understood you. With some doubt he let you have the clothes leaving for the spot you told him. Perhaps it was luck that he wasn't lied to by others all too often.""",
	TROLL_CLOTHES_2_3 = """After you defeat the troll you manage to find Xari's clothes which are in much worse condition than expected. But since you defeated the troll at least she should be happy it won't happen again.""",
	
	XARI_CLOTHES_7 = """As you pass Xari her clothes she looks less than impressed. Yet she proceeds with her part of the deal as agreed.

- Here. Just don't give it to her all at once. She should improve after a couple days.

She passes you a small phial filled with fluid and sends you off.""",
	
	LILIA_MANSION_1 = """You finally manage to bring Lilia the potion that took you the entire evening to acquire. Looking at her she doesn't appear to have had her condition worsen or improve while you were gone. The girl is too weak to object as you administer the potion to her, the taste obviously foul.""",
	LILIA_MANSION_2 = """The situation now dealt with, you finally are able to get some rest yourself.

Hours pass now as you sleep restfully there in your chambers, though deep in your rest you feel that your legs are now cold. This thought is at the forefront as you open your eyes to see Lilia start sliding her panties down now, moving her body up onto you.

- [Master], sorry for being a bit selfish but I really miss this...""",
	LILIA_MANSION_3 = """Not fully awake, you're not sure what to make of this as the small fae starts to grind herself upon you now. It took mere moments of her petals rubbing up and down your shaft to have the girl slick and ready, panting between pleased little groans. You're impressed and then then curious as the little fairy seems not to be fatigued by her ordeal, if anything she seems thirsty. 

A few moments later her noises picked up in pitch as she lifted herself up, sliding her warm body down onto your shaft. A gentle shifting of her hips followed by a pleased purr and the fairy would stop and look at you, cooing as she started to slowly bounce her hips, becoming more aggressive with time. You begin to wonder if you'd overreacted, surely she couldn't have been so ill before and be able to ride you this aggressively.

Lilia's moans are unrestrained, the sounds adding to the sensuality of the sex as she served you so well; making it difficult to fight against your need of release.""",
	LILIA_MANSION_4 = """Sweat on her body starts to show after a few minutes of exertion while your hands rest firmly on her legs for just a moment as you fight the need to release. Although after a few moments you're unable to stop yourself. The little fae was now pinning herself down, holding herself firmly onto your cock as you filled every crevice of her womb.

- A-ah... This feels too good...[Master]! I'm going to cum!

Lilia almost shrieks as you feel her clamp down your shaft now, her eyes hazing over as the small fae cums hard on you; her legs practically vibrating during her release. Melting down to lay against your chest, small aftershocks hitting her as she'd coo and shake.""",
	LILIA_MANSION_5 = """Lilia sits there for a few moments just breathing in bliss now, her small body shuddering before she just falls forward onto your chest. The little fairy is obviously exhausted as she just lies there trying to catch her breath.

After a few minutes you notice the small female is asleep, lying there as she would still occasionally shudder. Noting that keeping her warm might be in her best interest, you lay her down next to you as you decide to let her sleep with you tonight.""",
	
	CALI_ACT1_1 = """Visiting your captive, Cali you stand there in silence, the girl looking up at you with a tired rage behind her eyes now.

- W-what do you want now!?... Haven't you done enough?! Let me go!

Staring her down you take a good look at her. Slender and bruised, her body isn't suited for labor, but she has to earn her keep.

- You think I'll work for you? After what you've done?""",
	CALI_ACT1_1_OPTION_1 = "Whomever does not work shall not eat.",
	CALI_ACT1_1_OPTION_2 = "Surely you don't want to be sold to the slavers? Your new Master's will be far less kind.",
	CALI_ACT1_1_OPTION_3 = "Perhaps you need another reminder like the one at caves?",
	CALI_ACT1_2_1 = """Cali looks at you with her ears lowered as she averts her gaze. Her eyes look around the building now, taking in everything as she seems to submit for now. 

- Whatever, fine...""",
	CALI_ACT1_2_2 = """Cali's eyes turn cold as she seems to look through you. Nodding after you finish telling her, she says nothing for the remainder of the day as her new duties begin.""",
	CALI_ACT1_2_3 = """The girl lunges at you as you catch her by the throat, pinning her back firmly to the wall of the room. Tears pour from the girl's eyes as she looks at you with fury, her arms flailing at you in rage.

- You fucking bastard! I'm not your whore!""",
	CALI_ACT1_2_3_OPTION_1 = """You can certainly be treated like one, or you can work.""",
	CALI_ACT1_2_3_OPTION_2 = """Serve with your labor, or serve with your body, Cali.""",
	CALI_ACT1_3 = """The girl's eyes well with tears as she nods. For now she doesn't fight you as she's put to her new duties.""",
	
	CALI_ACT2_GONE = """You awake one morning to find your manor's back door open. Your confusion is short-lived as you go down to check on Cali, finding her room empty. Finding the door's lock picked, you curse aloud as it seems in her desperation she was able to escape.""",
	CALI_ACT2_1 = """You're going through your daily tasks as you check on your mansion. Checking on Cali's work now, her task is an arduous one. The girl is sweating profusely, her white shirt all but see-through now, the view of her breasts quite nice considering.

The girl seeing you looks far from pleased, her eyes unfocusing as she can't even seem to look at you.

- What are you looking at, huh?! Did you not see enough already?!""",
	CALI_ACT2_1_OPTION_1 = "I look where I please, slave.",
	CALI_ACT2_1_OPTION_2 = "Keep up the hostility, Cali, it'll make it all the sweeter when I take you again.",
	CALI_ACT2_1_OPTION_3 = "I simply enjoy the view.",
	CALI_ACT2_2_1 = """Cali growls at you now, her eyes showing a hatred that was rare to find.

- You bastard! I'm not some dog on a leash!

As you leave her be for now, you can't help but muse at the thought “dog on a leash.”""",
	CALI_ACT2_2_2 = """The girl turns her nose up at you defiantly instead focusing on her work now.

- I'm not some mindless pet, asshole!

You leave her to her work, thinking intently about making her into that very pet that she seemed so scared to become.""",
	CALI_ACT2_2_3 = """Cali wasn't expecting that reply as her face turned blood red. Trying to hide it by getting back the girl was only partially successful.

You decide to leave her alone for now. Perhaps something could make her more pliable to your will?""",
	CALI_ACT2_3 = """Your thoughts have been increasingly focused on taming your new slave, Cali. Cali has been difficult, the girl intent on refusing you. After careful deliberation you come to the conclusion that just calling her your property is one thing, but she should look the part as well.

A collar seems the most logical first step but a regular collar seems insufficient. You decide it might be a better idea to head to the Workers Guild and ask Sigmund if he can point you in the direction of a specialist.""",
	CALI_ACT2_WORKERS_OPTION_1 = "Ask Sigmund about a specialist",
	CALI_ACT2_WORKERS_1 = """{color=yellow|Sigmund: — Wha? Someone to make a collar? Are the ones at the market not good enough?}

You explain to the dwarf that the ones in the market are indeed fine, but what you're looking for is a custom piece. The burly male thinks for a few moments while scratching his beard before nodding.

{color=yellow|Sigmund: — Limnrov is who you'd want to find. Ask up at the front for him, the receptionist can take you to 'em.}

With nothing else to ask Sigmund, you leave him to continue running the Guild's affairs.""",
	CALI_ACT2_WORKERS_2 = """Once you bring up the name of the craftsman with the receptionist, it's not long before you're standing in a backroom that smells strongly of the tradesman's craft. Limnrov himself, is an older Dark Elf, his eyes sharp as he looks up at you from the excellent piece he's currently working on.

{color=aqua|Limnrov: — I'd not sent for the courier yet. Master William can wait a few hours longer on this repair.}""",
	CALI_ACT2_WORKERS_2_OPTION_1 = "I'm not a courier, I'm a customer.",
	CALI_ACT2_WORKERS_2_OPTION_2 = "I'm here to hire you for your services.",
	CALI_ACT2_WORKERS_3 = """The Dark Elf looks you up and down for a few more moments before giving a nod.

{color=aqua|Limnrov: — Ah, my mistake. What can I do for you?}

You explain to Limnrov your desire to commission a custom piece for a recently acquired slave. After asking you details he will need, the elf gives a stoic nod before looking at you. Two sketches are then laid out before you.

{color=aqua|Limnrov: — I've two designs I might suggest. The former is your standard affair, however the engravings on the outside would leave no question as to the Master of your slave. The latter however, I've been eager to create. A far more refined piece that would be sure to turn a few heads.}""",
	CALI_ACT2_WORKERS_3_OPTION_1 = "What will you need to produce the simple collar?",
	CALI_ACT2_WORKERS_3_OPTION_2 = "What will you need to produce the extravagant collar?",
	CALI_ACT2_WORKERS_3_OPTION_3 = "I need some time to think on this",
	CALI_ACT2_WORKERS_4_1 = """Limrov starts to jot down a list of items that he will need you to procure before handing it over to you: 10 Thick Leather""",
	CALI_ACT2_WORKERS_4_2 = """Limrov starts to jot down a list of items that he will need you to procure before handing it over to you: 10 Thick Leather, 10 Silk""",
#	CALI_ACT2_WORKERS_4_2 = """Limrov looks rather excited as he produces a list of items, most notable of all being a large gem and hands it over to you.""",
	CALI_ACT2_WORKERS_4_1_OPTION_1 = "Here are the materials for the Simple collar",
	CALI_ACT2_WORKERS_4_2_OPTION_1 = "Here are the materials for the Extravagant collar",
	CALI_ACT2_WORKERS_4_3 = """{color=aqua|Limnrov: — Very well, I'll be here.}

Limnrov accompanies you to the entrance of the Guild.""",
	CALI_ACT2_WORKERS_5_1 = """Limrov looks the materials and payment over intently before nodding. 

{color=aqua|Limnrov: — Ah yes, this will do. Give me a few days and I'll have it delivered by courier.}""",
	CALI_ACT2_WORKERS_5_2 = """Limnrov is intent as he checks over every detail of the materials. Eventually satisfied, the man takes the coin and components needed before looking at you with a grin. 

{color=aqua|Limnrov: — Excellent, most excellent. Very well, I'll make sure your slave has a collar all others will pale compared to. Give me a few days and I'll have a courier deliver it.}""",
	CALI_ACT2_WORKERS_6_1 = """As he promised, Limnrov's courier is at your home early in the morning on the appointed day. Looking over the package you examine the simple collar. Though its design lacks much ornamentation the quality of the craftsmanship is masterful. At a minimum it should be comfortable.""",
#	CALI_ACT2_WORKERS_6_2 = """As he promised, Limnrov's courier is at your home early in the morning on the appointed day. Looking over the package you examine the exquisite collar. Limnrov has created a masterpiece with this collar. The curves and details flawless, each detail applied with fine care. The centerpiece of his creation, the large gem, is polished to a mirror and gleams back to you.""",
	CALI_ACT2_WORKERS_6_2 = """As he promised, Limnrov's courier is at your home early in the morning on the appointed day. Looking over the package you examine the exquisite collar. Limnrov has created a masterpiece with this collar. The curves and details flawless, each detail applied with fine care.""",
	CALI_ACT2_LIMNROV = """{color=aqua|Limnrov: — I've two designs I might suggest. The former is your standard affair, however the engravings on the outside would leave no question as to the Master of your slave. The latter however, I've been eager to create. A far more refined piece that would be sure to turn a few heads.}""",
	CALI_ACT2_SIMPLE_COLLAR_1 = """You call Cali to you the next morning, the girl is quiet, but staring at you with more than a little distaste.

- What do you want? I've been behaving, [name].

You pull the simple collar out, showing it to the girl. Cali's eyes initially show hints of fear, then denial as the girl shakes her head now vigorously, moving away from you now. 

- Are you serious? Y-you want me to wear this!?""",
	CALI_ACT2_SIMPLE_COLLAR_1_OPTION_1 = "There's nothing to fear, Cali, it's a common sign of ownership.",
	CALI_ACT2_SIMPLE_COLLAR_1_OPTION_2 = "I'm not asking, slave. Now do as you're told before I need to get creative.",
	CALI_ACT2_SIMPLE_COLLAR_2_1 = """Cali sits there frozen for a moment before taking a long, steadying breath. Her posture relaxes somewhat and she doesn't fight you as you put the collar on her. After a few moments, your hand rests on the top of her head as she shudders uncomfortably.

- You think I'm some kind of a pet!?""",
	CALI_ACT2_SIMPLE_COLLAR_2_1_OPTION_1 = "Pets are looked after, are they not?",
	CALI_ACT2_SIMPLE_COLLAR_2_1_OPTION_2 = "Pet or slave, which one sounds better?",
	CALI_ACT2_SIMPLE_COLLAR_3 = """Cali fails to find a proper response and stays quiet. Finally you dismiss the girl for the day and carry on with your work.""",
	CALI_ACT2_SIMPLE_COLLAR_2_2 = """Cali shudders as fresh tears hit the floor. The girl's posture seems to relax, her eyes staring ahead as she shakes now. The girl doesn't fight you, but it's clear from her body language that if she thought she could get away from you she would bolt in an instant.

Once the collar is around her neck, Cali looks at you, her face blank but her body shaking. Eventually you dismiss the girl so you can carry on with your work.""",
	CALI_ACT2_EXQUISITE_COLLAR_1_1 = """You call Cali to you the next morning, the girl is quiet, but staring at you with more than a little distaste.

- What do you want? I've been behaving, [name].

When you pull out the collar Cali's eyes light up for the faintest moment. The girl's eyes tracking the item as she looked it over. 

- It's pretty...""",
	CALI_ACT2_EXQUISITE_COLLAR_1_2 = """Looking as if she might bolt once you get behind her, she stops herself upon realizing it was meant for her.

- This is for me..? I don't dislike it, but you really think this is enough after what you've done...

As you place the collar around Cali's neck, the girl's hand instinctively rests upon the jewel for a moment. Though she doesn't run, her body still goes rigid as you rest your hand atop of her head.""",
	CALI_ACT2_EXQUISITE_COLLAR_1_OPTION_1 = "Here there are no bandits. No one to lay a hand on you, save me.",
	CALI_ACT2_EXQUISITE_COLLAR_1_OPTION_2 = "You're far better off than when I found you.",
	CALI_ACT2_EXQUISITE_COLLAR_2 = """Cali opens her mouth as if to argue against what you've said but stops. She eventually concedes the point with a soft shrug. With that settled you dismiss the girl for the day, leaving her to her duties.""",
	
	CALI_ACT3_MAGIC_1 = """Your slave, Cali, has relented and no longer fights your orders. You can't help but feel the girl and you are at an impasse. Cali remains unbroken through it all, willful as ever.

One morning Cali approaches you now, clearly tired. 

- [name], I was wondering if I could have a break today.

The girl does look worn out. Clearly life working at the mansion is more strenuous than she is used to. After considering it for a moment you decide that you could let her take a break for today, but now seems like a good time to have her loosen up a bit for you in exchange.""",
	CALI_ACT3_MAGIC_1_OPTION_1 = "Sure, but I want you to lift up your shirt in exchange.",
	CALI_ACT3_MAGIC_1_OPTION_2 = "Maybe if you let me feel you up.",
	CALI_ACT3_MAGIC_1_OPTION_3 = "Very well, just for today.",
	CALI_ACT3_MAGIC_2_1AND2 = """Cali looks at you deadpan for a few seconds before her face scrunches up in disgust. 

- You really are a fucking pervert! 

Before you can respond, the girl leaves half-slamming the door as she gets to work. Clearly deciding that would be a better alternative than giving into your base needs.""",
	CALI_ACT3_MAGIC_2_3 = """Cali looks relieved at you before nodding.

{color=yellow|Cali: Ok then, um... thank you.}""",
	CALI_ACT3_MAGIC_3_1 = """Thinking about the situation, your mind wanders. You could force the girl into bed. It wouldn't be hard, but seems far less satisfying. You eventually decide there must be something you can do to sway her. You think about the dominators you've heard of mages who can influence the mind of others. Perhaps a mage might be able to assist you in this endeavor.""",
	CALI_ACT3_MAGIC_3_2 = """Thinking about the situation, your mind wanders. You could of course use a spell to break her mind, to make her a puppet of your will, but your pride demands otherwise. Knowing magics are wide and varied though you decide to ask another mage. Perhaps they have some knowledge you're lacking.""",
	CALI_ACT3_JEAN_START_OPTION = "Approach Jean about the issue",
	CALI_ACT3_JEAN_1 = """Talking to Jean, you explain the issue in depth to her. The girl's nose scrunching up as if she's going to tell you to do something impolite with your issue, before instead realizing who she works for.

Jean goes to respond to you multiple times before finally asking you a question

{color=aqua|Jean: — Why not get another one then? It's not like she's anything special, just a half-wolf.}""",
	CALI_ACT3_JEAN_1_OPTION_1 = "I've grown rather fond of her.",
	CALI_ACT3_JEAN_1_OPTION_2 = "I'm rather enjoying the challenge.",
	CALI_ACT3_JEAN_2_1 = """Jean scrunches her nose up before shaking her head.

Jean gives you a partial look of disgust. Obviously she was about to say something before she decides it's better Cali, than her.

The girl considers your answer for a moment before finally giving you an answer. 

{color=aqua|Jean: — Why don't you just have the beast's collar enchanted?}

You stop for a moment considering that. True you'd not considered having her collar enchanted, but enchantments lay well outside your field of expertise. Jean watching you finally huffs out a sigh, looking at you.

{color=aqua|Jean: — You're hopeless, [name]. You could ask Mages Guild for help, you know... I guess I could do something like that, but you'll have to get something for me. I'm gonna need a rare magical essence. There's one spot where you can collect some water for it. It's in the elven woods, but there shouldn't be an issue for you.}""",
	CALI_ACT3_JEAN_2_2 = """Jean sighs, then gives you a knowing nod.

{color=aqua|Jean: — Of course you'd say that. Pervert.}

The girl considers your answer for a moment before finally giving you an answer. 

{color=aqua|Jean: — Why don't you just have the beast's collar enchanted?}

You stop for a moment considering that. True you'd not considered having her collar enchanted, but enchantments lay well outside your field of expertise. Jean watching you finally huffs out a sigh, looking at you.	

{color=aqua|Jean: — You're hopeless, [name]. You could ask Mages Guild for help, you know... I guess I could do something like that, but you'll have to get something for me. I'm gonna need a rare magical essence. There's one spot where you can collect some water for it. It's in the elven woods, but there shouldn't be an issue for you.}""",
	CALI_ACT3_JEAN_3 = """You get to the spot which was marked by Jean and find a dimly glowing water spring. You scoop some water from it which should be enough to provide Jean with what she needs.""",
	CALI_ACT3_JEAN_3_OPTION_1 = "Give Rare Magical Essence",
	CALI_ACT3_JEAN_4 = """Upon successfully delivering the reagent(s) required, Jean gets to work. After you retrieve Cali's collar under the guise of the article needing to be cleaned, Jean makes quick work of applying the enchantment to it.

{color=aqua|Jean: — There, done. Whatever vile things you are planning to do with this, this won't make the wearer obey you on command. It will only make them more willing...}""",
	CALI_ACT3_JEAN_5 = """Taking the collar back to Cali, the girl gives no complaint as you put her collar back on her once again.""",
	CALI_ACT3_MAGES_OPTION_INIT = "Ask about mind altering spells",
	CALI_ACT3_MAGES_1 = """Myr isn't available for your request today it seems. After inquiring around the guild you eventually find an apprentice wearing a bored expression on his face to make your inquiry to.

{color=aqua|Apprentice: — Magical assistance in taming a slave? And she's quite keen on resisting your advances. Ah yes, we could help with that. Perhaps an enchantment for her collar? We could do something like that for you, but Guild Master Myr has been charging a premium on the service.}""",
	CALI_ACT3_MAGES_1_OPTION_1 = "I'm sure I can afford it.",
	CALI_ACT3_MAGES_1_OPTION_2 = "What's the rate?",
	CALI_ACT3_MAGES_2 = """The young mage pulls out a large chart, looking it over before telling you the service will be 500 gold.""",
	CALI_ACT3_MAGES_2_OPTION_1 = "Fine, if I've no other choice (500 Gold)",
	CALI_ACT3_MAGES_2_OPTION_2 = "Is there any way to earn a discount?",
	CALI_ACT3_MAGES_2_OPTION_3 = "I'll come back later.",
	CALI_ACT3_MAGES_3_1 = """After you retrieve Cali's collar under the guise of the article needing to be cleaned, the apprentice makes quick work of applying the enchantment to it all while taking a heavy amount of your coin.

{color=aqua|Apprentice: — Good it's done. Do know this won't make her blindly obedient, only more willing to do what you ask...}

Taking the collar back to Cali, the girl gives no complaint as you put her collar back on her once again""",
	CALI_ACT3_MAGES_3_2 = """The young mage shakes his head.

{color=aqua|Apprentice: — Absolutely not, Guildmaster Myr would have my head!}""",
	CALI_ACT3_MAGES_3_3 = """{color=aqua|Apprentice: — Very well, I'll be here when you return.}""",
	CALI_ACT3_MAGES_4 = """{color=aqua|Apprentice: Welcome back, you have the fee I trust?}""",
	CALI_ACT3_BLOW_OPTION_INIT = "Talk to Cali",
	CALI_ACT3_BLOW_1 = """Cali has been quiet for the last few days, though you've caught her sneaking glances at you whenever she gets the chance. Unbeknownst to her the enchantment seems to be doing it's job quite well, the girl's resolve slowly weakening.

Eventually, you confront the girl about her peeking upon you, only for her face to turn a dark shade of red.

- What? No! I wasn't staring at you. I just don't like having you in the same room as me.

You say nothing for now, just letting the girl talk. Your eyes locked on her as she continued to blush, her frustration evident.

- I'm on a break right now! What do you even want from me?!""",
	CALI_ACT3_BLOW_2 = """Cali looks nervously at you after your confrontation, moving a bit too eagerly as you motion her to get to the floor. Each step seems conflicted, but needy as the girl is down on her knees in front of you.

As you open your pants in front of her, she gulps now, shaking as she speaks.

- F-fine... You damn pervert... Just this once!""",
	CALI_ACT3_BLOW_3 = """Cali doesn't say anything at first as she gets down on her knees, looking up at you now. Her face is a mask of an embarrassed blush. Despite this she doesn't complain now as she undoes your trousers, her face darkening even more as she sees your member.

- Wha...it's bigger than I remember.""",
	CALI_ACT3_BLOW_4 = """Cali seeing the lewd look on your face after commenting on the size rolls her eyes a bit.

- It just is! Don't take that as a compliment.""",
	CALI_ACT3_BLOW_5 = """The girl would wrap her hand around your shaft now, gently pumping her fingers around the base as she looked down at it. Once it showed a dot of precum on the tip, she'd wince; almost as if expecting you to cum right there as her inexperience showed.

You consider telling the girl to hurry up, but relent now, watching her as she finally opens her mouth. She started suckling quite nicely on just the head, her hand pumping up and down before she looked up at you gauging your reaction.""",
	CALI_ACT3_BLOW_6 = """Cali only hesitates for a moment longer before pushing her face back down deeper onto your shaft now, a few pumps before she'd resume just pumping on your member with her hand. Her mouth sucking on the head.""",
	CALI_ACT3_BLOW_7 = """Cali seems eager as she repeats this process now, her hips swaying back and forth for a moment before she stops herself. Pumping her hands faster on your length now, she notices the base pulsing as you get closer. Although the girl doesn't pull away, pushing you over the edge as you start to cum soon. """,
	CALI_ACT3_BLOW_8 = """Cali lets a surprised little squeak as you start to cum into the girl's mouth, her eyes wide as you finish. To your surprise, she doesn't pull away. Swallowing every drop though her face shows a mask of embarrassment at the act.

The two of you sit there for a few moments now. Cali said nothing before standing up abruptly now, looking away from you; her face red now. """,
	CALI_ACT3_BLOW_9 = """- I...I'm going to go back to my break...

Cali doesn't give you any time to respond. She was practically running out of the room as you sat there quite impressed with the work she did.""",
	CALI_ACT4_MERCHANT_START = """The enchantment has proven to be of excellent quality, yet you can't help but wonder if there is more that could be done. Cali has been willing to offer her mouth at least, but the resistance is still there. 

Thinking over your predicament, you decide to muse over the idea while doing some shopping in town. Perhaps one of the merchants will have something that can assist you?""",
	CALI_ACT4_MERCHANT_1 = """Rows of toys, food, and exotic luxuries line the isles of Aliron's Market, but none seem quite suited to your needs currently. While you lunch at one of the stalls, a bookseller across from the food cart catches your eye. 

The merchant is quick to spot one eyeing his wares. He waves to you, calling out.

Merchant: — Greetings, good sir! I see you've an eye for quality. Perhaps you'd like a tome on how to enjoy a Seraph's curves or -

It seems the merchant will prattle on forever if you don't stop him.""",
	CALI_ACT4_MERCHANT_1_OPTION_1 = "I'm just browsing",
	CALI_ACT4_MERCHANT_1_OPTION_2 = "Do you have any books relating to Wolfkin? Or the half-breeds?",
	CALI_ACT4_MERCHANT_2_1 = """The merchant looks at you with a knowing smile, shaking his head. 

{color=yellow|Merchant: — Ah, but that is not the look of a man who is just browsing. Tell me, what do you need sir?}""",
	CALI_ACT4_MERCHANT_3 = """Relenting, you tell the merchant you're in the market for a book on Wolfkin, or their half-breeds.

{color=yellow|Merchant: — Ah, yes yes I do have something of its like. }

The man reaches onto one of the shelves in the cart and hands you a small tome, no thicker than your thumb. A quick glance at its contents shows you that this is a book on wolfkin mating habits. 

Though the book itself is not that large, the information is extensive. There are pro taming arguments listed, illustrations of sexual positions her kind would be suited best for, and even a section of best practices.

The price tag on the book states it costs a measly 50 gold.""",
	CALI_ACT4_MERCHANT_3_OPTION_1 = "Here is the coin (50 Gold)",
	CALI_ACT4_MERCHANT_3_OPTION_2 = "I'm not quite sure yet",
	CALI_ACT4_MERCHANT_4_1 = """The merchant takes your coin with a smile. Leaving the man to manage his cart, you head home now. Eager to see how this will unfold.""",
	CALI_ACT4_MERCHANT_4_2 = """The man nods before turning to another customer as you leave.""",
	CALI_ACT4_MERCHANT_5 = """The man welcomes you eagerly now, hammering you with questions and suggestions as you pick the book on Wolfkin off the shelf.""",
	CALI_ACT4_MERCHANT_6 = """Returning home, you leave the book in Cali's room. Perhaps some inspiration into her kind's mating habits will soften her to the idea.""",
	CALI_ACT4_MAST_1 = """Deciding to check on Cali, you move down to her room, hearing soft sighs through the door.""",
	CALI_ACT4_MAST_2 = """Moving closer you stay as silent as possible, though the only noise one could hear now is the softly growling and moaning sounds coming from her room. Moving closer you can indeed make out Cali's voice, a tremble to it as the girl is laid there on her bed, the book beside her as she looks down at it.

Whatever image in the book sparked her need seems to reignite it now as you're able to hear the girl's voice, her words accompanied with a pant.

- Why am I doing this...

Cali continued to try for a few moments, eventually eliciting a soft moan as she touched herself again. Her hips bucking up just a bit as she's forced to cover her mouth to prevent a loud moan. Eventually she looks over at the page again, adjusts herself and proceeds to increase the speed she rubs herself; her hips rolling now. """,
	CALI_ACT4_MAST_3 = """- I might have liked it...

Cali continues to masturbate, occasionally looking at the book as she panted and moaned softly. Eventually she would seize up as she came, her face buried in her pillow as she let out a little scream.""",
	CALI_ACT4_MAST_3_OPTION_1 = "Walk in",
	CALI_ACT4_MAST_4_LEAVE = """You quietly leave, allowing her to bask in the afterglow of her orgasm admiring her change in behavior. It would seem Cali's resistance is starting to wane, her natural urges starting to take over.""",
	CALI_ACT4_MAST_4 = """As you walk in Cali makes an embarrassed squeak, her face turning blood red.

- [name]! W-what are you doing here!

You don't say anything for now, only giving Cali a knowing smile. Letting her stumble over her words as it became clear to her she'd been caught in the act.

- Pervert...

Cali looks away from you now, embarrassed more than angry. Her face still blushing hard.""",
	CALI_ACT4_MAST_4_OPTION_1 = "Everyone in the mansion would have been able to hear you, Cali.",
	CALI_ACT4_MAST_4_OPTION_2 = "Is that any way to act Cali? Why don't you show me what you were doing?",
	CALI_ACT4_MAST_5 = """Cali's blush darkens as she soon wraps herself up in her blankets now, not even her face visible as she mumbles out a barely audible reply.

- I can't help it...

The girl only blushes more as you move towards her on the bed now. Looking away as her face is a solid sheet of red, whimpers are heard from her as you toss her blankets aside, leaving her exposed figure under you.

- W-wait I'm not...

The girl's eyes go wide seeing your length as you open your pants now, pushing her bared figure back down. A small squeak is heard as you lift up her shirt, exposing her small breasts.""",
	CALI_ACT4_FUCK_1 = """Cali says nothing as your shaft rubs against the girl's tight entrance, only moaning as a reply as you push into her.  Eyes rolling back all the girl can do is moan and whimper as you press deep into her figure again and again. Her body shaking as her need was quite apparent.

The sight of the teen squirming around as you pumped into her was perfect as she served you willingly, eagerly now.  Soon the matting became rougher as you naturally escalated with her, your grip tight on her hips as you thrust into her.  """,
	CALI_ACT4_FUCK_2 = """- R-right there...

The girl's body would eventually go rigid on you as she climaxes, a seductive little moan bubbling out of her throat as you soon join her. Cali doesn't protest as you bury yourself deep into her body, your cum filling her.

Cali stay quiet as you pull out of her afterward, the girl left laying there as you look her body over, a smirk on your lips as you make sure to close the door behind you.""",
	CALI_ACT4_MAST_6 = """Cali's face is red still as she looks at you, then the book. It's quite obvious what she was masterbating to, the illustration of a male of your face inserted into a half wolf from behind is quite well drawn. She snaps the book closed now, stuffing it under her pillow as she says nothing for now.

Looking at you, then where she hid the book she finally relented, moving the cover aside and showing you, her pussy soaked from her recent orgasm. 

- T-there! Happy? You're not getting anymore to-""",
	CALI_ACT4_MAST_7 = """Her words were cut off as you moved onto the bed with her, her little body pressed down fully. Cali doesn't fight you to position her now, if anything the girl willingly moves where you want her. 

- W-wait I'm not...

The girl's eyes go wide seeing your length as you open your pants, pushing her bared figure back down. A small squeak is heard as you lift up her shirt, exposing her small breasts.""",
	CALI_ACT5_PET_START = """Cali has been surprisingly tolerant as of late. Though not eager to serve, the girl's training has gone well even if you've been mostly subtle about it. Despite this though, she still has not turned into a proper pet, something you desire to remedy.

You consider your options, and though she might very well just accept your orders now, you decide that it is time to move onto the next step.

This resolution in hand you leave the manor that afternoon to search for the proper accessories for your “pet”.""",
	CALI_ACT5_PET_1 = """The shop smells like... well, animals. You're not quite sure what you expected as you pass rows of items ranging from large dog collars, to hand made treats. One sight catches your eye as you turn a corner, an employee and dog are walking down the aisle. The dog stops on command, sits on command, and even seems eager. Eventually the hounds' work is rewarded with food, a dog dish is placed down that the beast eagerly eats from.""",
	CALI_ACT5_PET_2 = """The obedience of the dog is impressive, so much so you decide to ask the employee about it.

Employee: — How did I get him to behave so well? Well, look for yourself now.

The dog is hungry, though obviously not starved as the beast has ample meat on its bones.

Employee: — He knows that if he does what he's told he gets to eat. Food is the great motivator after all.

You thank the employee for his insight. Heading back to your mansion to put the newfound knowledge to use.""",
	CALI_ACT5_PET_3 = """Breakfast and lunch today have been sparse for Cali. In addition to that, the girl's labor was especially strenuous today; a perfect mix for a strong appetite. Going about your day as normal you eventually call for Cali right before dinner is to be started.

The girl comes as told now, though she looks far from pleased by the prospect. 

- Can this wait, [name]? It's dinner time and I'm starving...

After a moment, you sit her dinner in a dog bowl beside you. Her eyes traveled up to you with a look of frustration, but it was obvious her hunger was winning as she stared down at the food in the bowl. """,
	CALI_ACT5_PET_3_OPTION_1 = "I have your food right here.",
	CALI_ACT5_PET_3_OPTION_2 = "Because I think you should be eating right here, Cali. Like a good girl.",
	CALI_ACT5_PET_4 = """Cali looks up at you with a mild shock, then resignation. It is clear the girl might have expected you were using her food to coerce her into something.

- I... no. Why? I'd look like an animal... This is weird!""",
	CALI_ACT5_PET_4_OPTION_1 = "Why are you so worried about what you look like?",
	CALI_ACT5_PET_4_OPTION_2 = "I think the ears and tail add more to that than how you eat.",
	CALI_ACT5_PET_4_OPTION_3 = "It's this or you go hungry Cali, make your choice.",
	CALI_ACT5_PET_5_1 = """- I feel like I'm losing myself... just becoming what you want me to be...""",
	CALI_ACT5_PET_5_2 = """Cali looks at you with an embarrassed expression, her ears drooping lower.

- Hey, it's not like it's my fault...""",
	CALI_ACT5_PET_5_3 = """Cali takes a long look at the bowl now, your ultimatum obviously hitting a nerve with her. Chin sticking up the girl soon turns right around and walks out. Perhaps you should try again later.""",
	CALI_ACT5_PET_6 = """Cali unbeknownst to her while she refuted you, has stepped closer to the bowl now. Her stomach obviously has a vote on this issue.""",
	CALI_ACT5_PET_6_OPTION_1 = "Aren't you hungry?",
	CALI_ACT5_PET_6_OPTION_2 = "You might just like it if you try.",
	CALI_ACT5_PET_6_OPTION_3 = "You ungrateful little bitch, do as you're told..NOW!",
	CALI_ACT5_PET_7_GONE = """Cali's face turns cold to you as she moves over to the bowl, getting down to eat out of it like she was told. You were just thinking to yourself on how you finally might have broken the girl when you catch a glimpse of something coming towards you, a loud crash as the food bowl bounces off your forehead.

- I am NOT your bitch, you monster!

Dazed from the object colliding with your face, by the time you realize what has happened, the girl has your keys in hand. Escaping through the mansion's front door.

Perhaps it was too much for her...""",
	CALI_ACT5_PET_7 = """Cali looks at you for a few moments, shaking before hunger wins out. The girl goes to pick up the bowl looking at you, realizing she'd have to eat out of it like an animal. 

Kneeling down, the girl soon was on all fours. Her ass slightly in the air as she tasted the food. Soon, she gives in as she starts to eat.""",
	CALI_ACT5_PET_8 = """Her panties were visibly wet as she ate now. A grunt was heard from her as your hand finds them now, sliding over her backside while you sit beside your feeding pet.  Cali stops her eating now, looking back with dark blush creeping over her face.

Cali: — [Name], what are you doing?

A light touch to her chin is all the girl would receive in answer, a silent reminder to finish her meal.  Cali tries visibly to keep her composure, but between the stroking of her crotch and the already established arousal she’s unable to focus on her meal for much longer.

Cali: — W-wait not th-""",
	CALI_ACT5_PET_9_1 = """The girl's words are cut off with a low moan as your hand slides into her panties, easily finding her soaked clit as your fingers continue to explore her further, to stimulate her.  Face darker with each passing moment it wasn’t long before she’d lose her focus entirely, her hips practically buzzing as she was fast approaching her release. 

Cali: — Nhhh...

The girl withdrew her protests giving into your caress, finally buckling as her legs closed hard around your hand as he soaked her panties, a shrill cry coming from her throat as she nearly collapsed onto her bowl, her eyes looking ahead a bit dazed now.   

- Why... doesn't this feel wrong...? """,
	CALI_ACT5_PET_9_2 = """Cali seems conflicted before sighing, her body relaxing now there on the floor as your hand slides through her hair. It seems she has completely forgotten her initial grudge despite everything.

The girl doesn't fight you as you slide your hands over her back and shoulders, her head hanging down in contemplation as you barely can hear what she whispers.

- I liked it... """,
	CALI_ACT5_PET_9_OPTION_1 = """That wasn't so hard, was it?""",
	CALI_ACT5_PET_9_OPTION_2 = """Good girl. Now sit.""",
	CALI_ACT5_PET_10_1 = """Cali shakes her head, her face a blood red blush as she just sat there now. Your hand sliding over the top of her head, petting her. Spending the evening just stroking her, she eagerly leans into the petting, relaxing.""",
	CALI_ACT5_PET_10_2 = """Cali sits without even realizing it at first, her expression somewhat shocked as she dares not to move as your hand slides over the top of her head, petting her for now. Spending the evening just stroking her, she soon leans into your petting, relaxing before being dismissed for the day.""",
	CALI_ACT6_NAKED_1 = """Just as the day before, today Cali meets you in your chambers. This time the girl seems more relaxed, the meal yesterday did much to lift her spirits.

- I have been a good pet today...

The girl states, looking at you expectantly, then down at the bowl. Her eyes widen as she sees even more has been added to it this time.""",
	CALI_ACT6_NAKED_1_OPTION_1 = "You've been a good girl Cali, but you can be even better. I want you to undress while you eat today.",
	CALI_ACT6_NAKED_1_OPTION_2 = "A good pet doesn't wear clothing, do they Cali?",
	CALI_ACT6_NAKED_1_OPTION_3 = "Not good enough Cali, I want you nude while you eat this time to make up for it. ",
	CALI_ACT6_NAKED_2_1 = """Cali hesitates for a single moment, but her resolve is in shreds. The girl undresses now as she moves down to eat beside you.""",
	CALI_ACT6_NAKED_2_2 = """Cali looks at you then her clothing. She goes to argue but stops, considering it before stripping herself of her garments. The girl still blushes, but doesn't further object as she kneels down to eat beside you.""",
	CALI_ACT6_NAKED_2_3 = """Cali's eyes show a hint of tears as you chastise her now. 

- Nothing's ever good enough for you...

Cali leaves you there now, it is quite clear you've hurt her feelings with your statement.""",
	CALI_ACT6_NAKED_3 = """Eating there, the girl gives no complaints to your eyes moving over her. Though it is quite clear her entrance is soaked, getting even wetter as her ass is lifted invitingly into the air, whether she's aware of it or not.""",
	CALI_ACT6_NAKED_4 = """When the girl is getting close to the end of her meal, you decide now is the time that she shows you how grateful she is for the food.

Hand sliding down her bare backside, you say nothing, but the soft squeak followed by a light moan is all you need to hear. As your hand slides lower, rubbing her warm petals, the slickness invites you to enjoy more than just a touch.

Cali's eyes widen as you move around fully behind her, undoing your pants as you grip her hip tightly now.""",
	CALI_ACT6_NAKED_5 = """- W-what are you doi-

The girl's question is cut short as you slide deep into her body, your shaft pressing down into the tight pussy. Not fighting you, Cali just lets out a long moan, her body shaking under your grip as you begin to pump into her. 

Soon the thrusting of your member was joined by Cali needily pumping her hips back into yours. Her unfulfilled need taking over as she wordlessly begged you to take her harder, needing the release as you feel yourself getting close soon.""",
	CALI_ACT6_NAKED_6 = """Finally filling the girl, you pin your shaft deep inside of her as she openly moans. Both of you cumming together while she clamps down on your shaft. The half-wolf refuses, or is unable to release her hold as she takes every drop eagerly. 

- I... ugh... I'll be a good girl...

You remind her as you're still deep inside of her that she should call you what you are. Your hand is still tight on her hip as she shudders under you.

- [Master]... I'll be a good girl, [Master]...""",
	CALI_ACT6_NAKED_7 = """With your training complete, Cali sitting down beside you like before. Her eyes observe you with a blind acceptance.""",
	CALI_ACT6_NAKED_7_OPTION_1 = "Good girl",
	
	HALLOWEEN_EVENT_INTRO = """{color=magenta|Zephyra: — Welcome, [Master]. This is our new... Show, I guess? A small play to keep you entertained at such time and day. And I was chosen to narrate it. So, relax and enjoy our little story. }

{color=magenta|Zephyra: — Today I'll be telling the story of a young girl wearing a red hood and her tragic story.}""",
	HALLOWEEN_EVENT1 = """{color=magenta|Zephyra: — A young girl was going through the forest. A deep, dark, forest carrying a basket with meat buns for her sickly grandmother. }

{color=aqua|Anastasia: — This is really embarrassing, I shouldn't have agreed to this... }

{color=magenta|Zephyra: — Even though she was young and frightened she still bravely embarked on this task. Little did she know what danger was awaiting her.}""",
	HALLOWEEN_EVENT2 = """{color=aqua|Anastasia: — Isn't it that story about a girl being eaten by a wolf?! Why me of all people...}

{color=magenta|Zephyra: — Her naivety would certainly play a role here if she met some wrongdoers. And to her misfortune she indeed came across them. A couple of bandits saw her walking alone through the woods and readily approached her.}""",
	HALLOWEEN_EVENT3 = """{color=gray_text_dialogue|Bandit: — Well there, pretty, where are you heading?}

{color=aqua|Anastasia: *Gulp* — I'm going to my sickly grandma, I'm bringing her meat buns...}

{color=gray_text_dialogue|Bandit: — Wow, did you hear that? A woman and food delivery for us, two in one! You must have heard of us coming here dressed like this?}

{color=aqua|Anastasia: — I-I don't understand what you mean. Please, let me go...}

{color=gray_text_dialogue|Bandit: — No, this clearly won't do. We shall consider it if you do something for us. How about showing your giant breasts?}""",
	HALLOWEEN_EVENT4 = """{color=aqua|Anastasia: — No, let me go, get your hands away from me! What even is this set up?!}

{color=gray_text_dialogue|Bandit: — Stay quiet silly girl, none can help you in these dark woods!}

{color=magenta|Zephyra: — Such a sorrowful sight would make any hero rush to save her, but the help came from a source she wouldn't expect.}""",
	HALLOWEEN_EVENT5 = """{color=yellow|Cali: — Watcha doing you bastards!? I, bandit punisher, Ca-I mean, Big Good Wolf will not let you go unpunished for this!}

{color=yellow|Cali: — Ryaaaaa!}

{color=gray_text_dialogue|Bandit: — Wha- Aaarrgh! Noo, don't kill us!}

{color=magenta|Zephyra: — As a true beast, the wolf jumped at the bandits which ran in fear of being eaten. }""",
	HALLOWEEN_EVENT6 = """{color=aqua|Anastasia: — Woah, you really have no shame wearing that?.. }

{color=yellow|Cali: — Whatcha mean? I'm a wolf and this is what I look like. }

{color=aqua|Anastasia: — Maybe I'm too self-conscious...}

{color=yellow|Cali: — No matter, human girl. Say, what business do you have in my woods?}""",
	HALLOWEEN_EVENT7 = """{color=magenta|Zephyra: — The wolf showed interest in the girl she never saw before. For better or worse, the girl had been sincere.}

{color=aqua|Anastasia: — I've been traveling to my grandma.}

{color=yellow|Cali: — Why would you do that? It's dangerous for young girls to travel alone. }

{color=aqua|Anastasia: — I understand, however my duty was to bring her some meat buns.}

{color=yellow|Cali: — No way, meat buns!? Ho-oh, now that's something I can not overlook!}""",
	HALLOWEEN_EVENT8 = """{color=yellow|Cali: — Those meat buns, they must be really tasty, right? Show me, I wanna see!}

{color=aqua|Anastasia: — ...Well they are in this basket... }

{color=aqua|Anastasia: — Huh, it's empty... Did the bandits take them while I was not looking?}

{color=yellow|Cali: — I said I wanna see the meat buns, I can smell them. Are you trying to trick the Big Good Wolf?}

{color=yellow|Cali: — Then, I'll have to search you to find them! }""",

	HALLOWEEN_EVENT9 = """{color=aqua|Anastasia: — No, wait! Aah-}

{color=yellow|Cali: — Hmm, could you be hiding them here? What's up with your chest, it's huge! I'm jealous...}

{color=aqua|Anastasia: — D-don't squeeze them... So roughly...}

{color=yellow|Cali: — Haah, they do feel nice on touch. Not exactly like meat buns... But somehow very captivating...}""",
	HALLOWEEN_EVENT10 = """{color=aqua|Anastasia: — Ngh... Please... Let them go...}

{color=yellow|Cali: — Let them go? So these were the 'meat buns' you were talking about? I knew it, they smell differently, but still nice.}

{color=yellow|Cali: — Hu-huh, I guess with no other option I shall taste them! }

{color=aqua|Anastasia: — Wait, this is wron-... Stop-sto-Ah-h haa.... }""",
	HALLOWEEN_EVENT11 = """{color=magenta|Zephyra: — Sadly, no one could hear her pleas for help in the dark woods.}

{color=magenta|Zephyra: — That dreadful night the red riding hood was eaten by the wolf.}""",
	HALLOWEEN_EVENT12 = """{color=aqua|Anastasia: — Did that story really go like this?}

{color=yellow|Cali: — I dunno, it felt kinda natural. }

{color=aqua|Anastasia: — At least I got a less skimpy costume...}

{color=yellow|Cali: — Ah, you know we get to keep them though? I hope [Master] is going to like this. }

{color=aqua|Anastasia: — W-well, as long as [Master] likes it, I don't mind wearing it I suppose...}""",

	HELEVIEL_MANSION_1 = """Where as you might take a newly acquired slave to their room, or yours for that matter Heleviel's behavior makes another approach seem needed. You allow her to spit her vitriol at you and your servants as you decide to instead take her below the rooms, stairs narrow as you drag the fallen priestess along to your dungeon.

Reaching the bottom of the stairs you're not quite sure what she was expecting, but the sight of a dungeon so well equipped for the usage of slaves seemed to be far removed from what she perceived as a reality.

{color=yellow|Heleviel: Stop! I am not some toy for a mere Male I am a priestess of-}""",
	HELEVIEL_MANSION_2 = """The stone walls echo as you silence her with a backhand sending her to the floor.  There is a long silence as the only sound coming from the torch lit room is that of her chain being lifted by your hand. She tries to hide her shock, and would have done well to most but you've seen better actresses than her make an attempt.

Heleviell continues to struggle in vain as she's pulled over to a large metal ring in the wall, her eyes wide as she renews her fight, only to receive another backhand for her trouble, then a third. Left there she no longer struggles as you attach her chain to the ring, trapping the troublesome slave.""",
	HELEVIEL_MANSION_3 = """{color=yellow|Heleviel: I-I am not-}

The elf stammers, denial taking hold as you grasp her throat, making her look into your eyes, the hint of tears starting to show. As she's just starting to regain her composure your hand finds her thigh, squeezing tightly as she squirms, her thrashing doubling in effort as your hand finds her silken panties, you almost almost feel a tinge of regret for destroying such magnificent craftsmanship, but dismiss that as you tear them from her pale skin the sound of them ripping covered by her scream of desperation.""",
	HELEVIEL_MANSION_4 = """You let those words sink in as her eyes fill with shock, renewing her panic as you reach down, tearing the chest of her dress open to expose her.  Her breasts are ample, still perky and youthful as you take a possessive grip upon one to inspect your new acquisition.  She tries to protest but only stammers out a cry as you take hold of her nipple and twist.  Whimpers now openly sound as you grip her hair, Heleviel struggles in vain as you allow this so she might wear herself out.  """,
	HELEVIEL_MANSION_5 = """Her body limited in motion she can only watch as you pull the hip of her dress away to expose the flawless skin underneath, her sweat from the long road shining on her. Her struggles become weaker now as you grip her, squeezing as she squirmed helplessly in the chains.

{color=yellow|Heleviel: I-I'm not...}

Heleviel stammers to herself, unable to cope with the situation as you undo your trousers in front of her, her eyes at first going from disbelief, to horror, and finally resignation as you pulse before the elf. Precum is dotting the tip of your shaft as you regrip her hair tightly, strands snapping between your fingers as you pull her towards your member.  

Heleviel struggles and thrashes her head about for a few moments, tears openly flowing from her eyes as her last protest from her mouth is shut up, a cry silenced as you push your girth into her mouth now at the moment she parted her lips. The shock of that moment clearly kept her teeth at bay.  

{color=yellow|Heleviel: Mmmrff I mrrf.}""",
	HELEVIEL_MANSION_6 = """A stern look at her as a warning was all that was needed to break the rest of her resolve, her dignity crumbling as you push down her throat now, forcing the elf to choke on your member, her body squirming as you deny her of even air for her behavior. Legs kicking and her body thrashing didn't dislodge you as you kept yourself deep in her throat, letting her vision start to haze, her body going nearly limp before you pull out just enough to allow her to breathe desperate breaths through her nose, her eyes pouring tears as she coughed and squirmed around in her bindings.  

Heleviel turned her gaze upward in panic again as you pushed back into her throat the moment she was fully lucid, pumping in and out of her throat, not allowing her air enough for comfort as you pleasure yourself at her expense. After she again hit her limit you would once more pull out just enough, the elf's drool hanging down her chin as you then repeated this process constantly, each time pushing her to her limits only to pull back and give her the hope that it had ended. """,
	HELEVIEL_MANSION_7 = """Shaft pulsing on her tongue and in her throat you continue this punishment until finally you grip her hair tighter, her body pliable as she no longer fights. Tears poured from her eyes as the once proud priestess of Freya was trapped there, unable to stop you as you pull back, cum starting to release into her mouth, the woman's eyes hazed over as you finally end her torment, leaving her there with your shaft still in her mouth until she'd swallow like was expected of a slave.

It took her a few moments to obey, her eyes closing as she shuddered, swallowing your cum, her eyes hazed over from tears and exhaustion as you pulled out of her hanging mouth, her jaw too fatigued to even close fully as you left her mouth empty for the first time in the better part of an hour.""",
	HELEVIEL_MANSION_8 = """Heleviel would cough, her head hanging, her eyes still dripping tears as you stand over the female now, your eyes looking down at her on the ground at your feet, where she belonged.  Eventually you'd lean down grasping her hair again, her eyes made to meet yours as you just smile down at the defeated Priestess. Behind her gaze something was smoldering, a rage at her situation. Fury enveloped her tearstained face as she broke the stare first, eyes watering over once again as her voice cracked.

{color=yellow|Heleviel: N-no more.. No m-more.  Stop you m-monster...}

Heleviel repeated her mantra between gasping and choked breaths, her eyes glazed over as she seemed to slump down lower on the floor. Her body continued to hang there as exhaustion overtook her, rasping protests fading into exhausted mumbles.  You continue to stand over her for a few minutes, admiring your work before turning to leave her there, making a mental note that she might take a bit longer to break than your other servants.  """,
	LIRA_MANSION_1 = """Lira follows you on the end of her tether quietly, her head hanging down as she hides her face in the hood of her cloak.  Though normally quiet in your mansion now there is a bustle of movement, the servants attending to their daily tasks in one of the few busy times of the day.  Shyness apparent, she more than once jerks her head to avoid the looks of an occasional servant as you lead her further into your home.  

{color=yellow|Lira: w-where are we going?}


Lira asks you as she continues to try to hide herself, occasionally taking frightened looks around now, her eyes tracking every bit of movement intently as if some monster hid around every corner. You stop her finally in front of a hand carved wooden door, intricate in its design as she stops to stare at it.  """,
	LIRA_MANSION_2 = """You move in behind her soon, your hand resting on her neck as she instantly seizes, starting to shake like a frightened rabbit. Her throat clenches a few times, her hips squirming as she seems ready to try to fight, to bolt at any moment, before she notices more than a few of your servants stop what they're doing as you hold her there, her face turning blood red. Turning her easily, she soon is facing the group of onlookers.

{color=yellow|Lira: Wh-what are you doing!? I-I'm not.}

Her words turn into a shrill cry as you jerk down the lower part of her robe now, her breasts spilling out as she froze, her eyes wide. Servants watching, she squirms left and right, unable to free herself from your grasp as her panties soon join the dress in pooling at her feet, her skin hot to the touch as she practically vibrates with embarrassment. After a few moments she chokes out a response as you fondle her chest idly on display now, rather impressed with how soft the priestess' skin is.

{color=yellow|Lira: [name]..Please...n-not like this. }""",
	LIRA_MANSION_3 = """You continue to fondle her as your servants onlook now, the elf so embarrassed that she can barely even move, her shyness paralzying her. Soon you would turn only a bit now, opening the door to the room before taking her lead again, a sharp tug on it making her stumble as she was made to follow you into the room.

{color=yellow|Lira: Ack! You don't need to — }

Her eyes go wide as you grasp her neck again, tighter this time as she shook now, your hand leaning her head back until her hood fell down, her ear by your lips as you speak""",
	LIRA_MANSION_3_OPTION_1 = """If you keep squirming we're going to do this in the town square.""",
	LIRA_MANSION_3_OPTION_2 = """I'd think you'd be more grateful, I could have let Heleviel hurt you.""",
	LIRA_MANSION_4_1 = """Lira visibly wilted at your words, her body still shaking as she stopped her squirming now.  She was pliable now as you guided her to the bed, firmly pulling her up into your lap and having the elf lay over you. Lira doesn't fight your touch further as you reach down and pull your shaft free under her. """,
	LIRA_MANSION_4_2 = """Lira stopped moving for a few moments as she gathered herself.  Eventually she relaxed somewhat in your grip making it easy to guide her to the new bed.  She still squirmed sheepishly as you pulled your shaft free, the heat of her sex warm against the base as you position her.""",
	LIRA_MANSION_4 = """
{color=yellow|Lira: I-is that?! I've n-never seen one...}""",
	LIRA_MANSION_5 = """You smack Lira's bottom firmly now, a reminder to show respect as you push her down just a bit towards the base, the elf starting to pant now as the top of your shaft rubs against her exposed entrance. Lira feels damp now, a realization coming over you that under all of that shame and embarrassment, her body was betraying her.  

{color=yellow|Lira: It's so warm...i-is it warm in here?}


Lira speaks out in a half dazed voice, occasionally trying to pull away from you.  Your hands resting tight on her ass as you pull her back to you, her holes stretched out a bit from the tight grip as Lira protests. Moments later the young elf freezes as the head of your shaft slipped over her entrance.  

{color=yellow|Lira: N-no! You shouldn't!}""",
	LIRA_MANSION_6 = """Lira thrashes until with your grip firm you force the slave down onto you. Her eyes went wide as she yelped and clenched tight, making her first penetration all the tighter. After a few moments of her squirming around in soft protest you grasp her hair, pulling her to look at you.  

{color=yellow|Lira: T-thats...no...}

Inch by inch you push into the tight elf, the entire time she thrashes and squirms on your lap.  After a few moments she pants now, fully impaled onto you. Eventually you start to pump the elf onto your member, the tightness perfect as she whimpers above you, her hands gripping tightly onto the sheets on your side as she abandons her resistance, unable to stop you anyways.  

You continue to use Lira for a few minutes like this, her virgin blood showing on your member as she's grinded up and down, her entrance pulsing and twitching around your member. Lira for her part said nothing, her face obscured soon by her hood, treating it like a security blanket as you claim the tight little entrance for your needs. Again you pull down the cloth covering her face as she makes a protesting squeak, the slipperiness of her entrance soon catching your attention. """,
	LIRA_MANSION_7 = """As you relax your grip on her preparing to change positions, you're greeted by the welcome surprise of Lira starting to ride on you herself now. The pace is slow, but deliberate as she rides your shaft, looking away as more than once she tries to pull her hood up to hide her face, protesting with a whine each time you stop her.  

{color=yellow|Lira: [name], P-please don't look at me...} 

Lira soon is riding you harder, surrendering if not in obedience, but in blind need as she pumps her hips down onto your cock, the deliberate pace causing a cascade of little mewling sounds to come from her as she finds her pleasure in the act, her entrance causing you to have to fight the urge to cum. Holding out as long as you can, Lira seems to pick up on this, her hips rocking faster as she refuses to look at you, her face in profile blood red from embarrassment. Her shameful face soon turns to shock as she feels your cock convulsing inside of her, hot lines of semen pumping up into the elven virgin's body, claiming her for yourself.""",
	LIRA_MANSION_8 = """Lira continued to clench as embarrassment took hold of her face, moments later this was discarded as the girl seized up now, the hot cum soaking her inner walls driving her over the edge as she orgasmed now, an almost happy sound slipping out as she collapsed. There was a moment of relaxed bliss before her eyes shot wide now, looking at you as she still managed to have her face turn even redder.

{color=yellow|Lira: Did you- I-inside?}

Lira seems to panic for a few moments, squirming hard around your shaft before she dismounts. A few moments later she gave you a quick bow and scampered off to the bathroom you'd passed enroute to her room. You remind yourself that obedience training is going to have to be a daily thing at this rate with her.""",
	LIRA_MANSION_9 = """Lira returns to the room a few moments later fully dressed. Makes absolutely no sense. It occurs to you that her dress had been kicked into the room once you'd removed it. Despite this though you don't recall seeing her pick it up. After giving a wary look to Lira, she has a small glint in her eye now as she realizes you knew even as she turned to look away, her cheeks still blood red.  

{color=yellow|Lira: Will that be all for tonight... [master]?}

The last word comes out of her mouth now sounding like an attempt to placate your curiosity.  You consider inquiring just when the girl had grabbed the robe but finally dismissed it, instead deeming it a good idea to make sure that inventory was done a bit more frequently in the mansion. If Lira was as good at taking items unnoticed it seemed she might be of more use to you than you thought.""",
	
	EXCALIBUR_QUEST_1 = """You come across a small clearing with a large rock in the center of it. As you take a closer look you realize it has a sword handle sticking out of it being buried in stone. Despite its state, the sword looks in a respectable state. However pulling it does not seem to be easy...""",
	EXCALIBUR_QUEST_1_OPTION_1 = "Pull it",
	EXCALIBUR_QUEST_GOOD = """With incredible effort you manage to pull the sword out of stone! As it's finally free you can feel a potent magic residing in it. Adoring your acquirement you leave the lone clearing. """,
	EXCALIBUR_QUEST_BAD = """You give your best spending a few minutes grabbing the sword with no success. It does not even bulge, neither stone seems to be affected by all your efforts. Praising the fact that nobody seen your pathetic struggles, you decide to leave the sword alone for now.""",
	
	CHRISTMAS_EVENT_PRE_INTRO = """{color=aqua|Zephyra: — At this merry time of year, I hope you are doing great, [Master]. 

Zephyra: — This day we'll be telling you a story about a lonesome girl whose only wish was a bit of happiness... Please, enjoy it. }""",
	CHRISTMAS_EVENT_INTRO = """One young poor girl has been staying on the streets in the winter. Being left alone she was trying to make living by selling some life shards.

{color=yellow|Daisy: — Please... Purchase these shiny stones...}

{color=aqua|Stranger: — Don't you know? The market for these things crashed due to overabundance. }

{color=yellow|Daisy: — Uuuuh... No way... I've spent my last money in hope of reselling them...}""",
	CHRISTMAS_EVENT_1 = """It was Christmas Eve but her hopes to make some money at least for a roof for tonight have been left in vain. 

With teary eyes she crouched down, lighting those shards and observing them closely in an attempt to shrug away the coldness. She has been recalling her memories in that faint light...""",
	CHRISTMAS_EVENT_2 = """{color=aqua|Rudolph: — Hey, are you actually trying to throw your life away? This won't work, these are healing shards, you know.}

{color=yellow|Daisy: — W-Who are you? }

{color=aqua|Rudolph: — I'm this scenarios' invited guest... Ah, you meant literally. You can see me as a holiday spirit. I'm here to offer you a job. }

{color=yellow|Daisy: — B-But, I'm not that kind of girl...}

{color=aqua|Rudolph: — I'm not a pimp, you doofus. It's a standard job. Come on, you don't want to spend your night here, do you?}""",
	CHRISTMAS_EVENT_3 = """{color=aqua|Rudolph: — Come here, I have something for you. Oh yeah, and take off your clothes.}

{color=yellow|Daisy: — W-wait, my clothes?! But you said...}

{color=aqua|Rudolph: — Shut up and come already.}""",
	CHRISTMAS_EVENT_4 = """{color=yellow|Daisy: — W-w-what are these clothes? }

{color=aqua|Rudolph: — You know how they say it, sometimes you have to become what you needed in the first place.}

{color=yellow|Daisy: — But... This skirt is way too short, and there's no underwear!}

{color=aqua|Rudolph: — That's an established uniform for these days, not much I can do about it. Don't sweat about it though, you look just fine.}""",
	CHRISTMAS_EVENT_5 = """{color=yellow|Daisy: — But what am I to do now?..}

{color=aqua|Rudolph: — Didn't I tell you? You gotta do some santa’s work yourself. Now take this bag and come after me.}

{color=yellow|Daisy: — Eeeeh?...}

Dropping her protests, the girl obediently went after her new employer.""",
	CHRISTMAS_EVENT_6 = """The girl was surprised when she had to visit numerous houses of a common folk varying degrees of poverty. As parents and kids were greeting her she found it a fresh experience.

Finally by the end of the day she came to an orphanage.

{color=aqua|Child: — Santa! Is it a real Santa?}

{color=yellow|Daisy: — I-I'm not real Santa, but he's busy so I'm helping out.}""",
	CHRISTMAS_EVENT_7 = """Happy children gathered around the girl who was surprised by the sudden treatment she rarely could experience elsewhere. She spent some time playing with children.

 A at couple of moments she was dangerously close to being discovered by a bunch of older boys but in the end somehow it worked out.""",
	CHRISTMAS_EVENT_8 = """{color=aqua|Younger child: — Thanks for visiting us, Santa's Helper!}

{color=yellow|Daisy: — Ha-ah... Well, it's finally over?}

{color=aqua|Rudolph: — Thanks for your hard work. Now that you've done it so well, here's your present. Believe it or not, I know what you have wanted for Christmas. }

{color=yellow|Daisy: — Y-you did?}""",
	CHRISTMAS_EVENT_9 = """For her work Daisy received a colorful box as a small present. Without further waiting she unwrapped it.

{color=yellow|Daisy: — This is... a collar?}

{color=aqua|Rudolph: — Now you will have a home and a [Master]. This is what you actually wanted, isn't it? I'm sure you'll have a lot of happy memories together. }

Not sure how to reply, the girl still managed to thank her back.""",
	CHRISTMAS_EVENT_10 = """Rudolph: — Even though it might be hard, you should still try your best. 

{color=yellow|Daisy: — Things could be against us, but we can adore these moments of peace and happiness.}

{color=aqua|Rudolph: — Well said, child. I see you've gone quite a path to get here. }

{color=yellow|Daisy: — W-We all want to wish you all Merry Christmas and Happy holidays!}""",
	
	ZCEVENT_1 = """As you walk through the Mansion you notice two of your residents, Zephyra and Cali talking to each other.

{color=aqua|Zephyra: — You know, I haven't noticed before, but we have a lot in common.}

Cali thinks for a moment, noticing the similarities in their origin, tones and appearance.

{color=yellow|Cali: — True... Haha, we could pass for sisters.}

{color=aqua|Zephyra: — He-heh, Perhaps our [Master] has particular interest in girls like us?}""",
	ZCEVENT_2 = """{color=aqua|Zephyra: — Do you want to hang around today? I'm sure [Master] can take us somewhere nice.}

{color=yellow|Cali: — Sure, why not!}

With no choice left, today you are forced to take your cute residents for a small appointment.""",
	ZCEVENT_3 = """{color=aqua|Zephyra: — This tavern is really nice, just as they were saying it in that book...}

{color=yellow|Cali: — I read no stupid books.}

{color=aqua|Zephyra: — Hmmm... This indeed shows. }

{color=yellow|Cali: — What do you mean by that?}""",
	ZCEVENT_4 = """{color=aqua|Zephyra: — You seem to take pride in that statement. }

{color=yellow|Cali: — So what? Who needs books anyway? If anything, bookworms make more trouble for normal people.}

Despite her sour expression, Zephyra decides to drop this topic. 

{color=aqua|Zephyra: — What do you do for fun then?}""",
	ZCEVENT_5 = """{color=yellow|Cali: — Ah, I like adventuring with [Master]. And sometimes I play with kids when there's no work.}

{color=aqua|Zephyra: — Playing with kids...? Aren't you too old for this? Or perhaps that suits your image.}

{color=yellow|Cali: — Hey, shut up, you are even shorter than me! Did all your growth go into that stupid tail of yours? }

{color=aqua|Zephyra: — W-w...}

Before it's too late you silence both girls and order them to stay silent which they do with a clear indication of hatred to each other.""",
	ZCEVENT_6 = """As you take a breath outside, one of the waiter girls approaches you and privately informs you that she has seen the tension between your company and advises you of one of their popular soft wine brands popular among beastkin and halfkin. With no better idea you figure out it may help to calm down the girls.""",
	ZCEVENT_7 = """You return to girls who clearly aren't in a great mood. As you present them the wine you obtained, their curiosity picks up. 

{color=aqua|Zephyra: — This seems rather a delightful drink. Cali, you can handle this at least?}

{color=yellow|Cali: — Of course I can drink! If you can do it, you think I won't be able to?}

After digesting the drink you ordered, your and the girls' mood has slightly improved. The girls seemingly became less tense despite their previous quarrel and  With time their conversation went into a relatively peaceful direction. 

After a bit you get a call from one of your acquaintances from the guilds, having to retreat from the girls for a while.""",
	ZCEVENT_8 = """{color=aqua|Zephyra: — I think regardless of all our differences we can agree on one thing.}

{color=yellow|Cali: — Whatcha mean?}

{color=aqua|Zephyra: — We both are here because of one [man] we really care for. }

{color=yellow|Cali: — ...I guess you have a point.}

{color=aqua|Zephyra: — Hey, you know what...}""",
	ZCEVENT_9 = """After some time you come back to the room seeing two girls moved close to each other and acting slightly suspicious.

{color=yellow|Cali: — [Master]...}

{color=aqua|Zephyra: — You are always taking care of us and doing such a great job..}

{color=yellow|Cali: — We agreed that we wanna thank you for it.}

{color=aqua|Zephyra: — *Giggle* It was her idea...}""",
	ZCEVENT_10 = """Despite being in a public place the girls shifted their clothes laughing mischievously. Perhaps it is due to the recent alcohol they have ingested...

{color=aqua|Zephyra: — Which one do you like more? He-he...}

{color=yellow|Cali: — Mines are a bit bigger!}

{color=aqua|Zephyra: — That's because they are erect. Did you get excited mentally preparing yourself?}""",
	ZCEVENT_11 = """You are at a loss of words but thankfully nobody else seems to pay attention to this little prank.

However girls seem to catch your concerns and with more giggling cover themselves back. 

{color=yellow|Cali: — Your face was so stupid. }

{color=aqua|Zephyra: — Hey, don't call [Master] stupid, that's rude. *giggle*}""",
	ZCEVENT_12 = """You leave back to the mansion with girls seemingly getting along and weighing on you like a pair of clingy animals. 

You feel relieved it all turned out well. The girls went to rest soon after you arrived home.""",
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#   QUESTS   #
	MAIN_QUEST_LOAN_NAME = "The Loan",
	MAIN_QUEST_LOAN_SUMMARY = "Your mansion comes with a loan. You must find enough money to pay off the bank or you'll be thrown out of your newly acquired home. Or, perhaps find some other way to deal with it...",
	MAIN_QUEST_LOAN_STAGE0 = "You must have over 1000 gold by Week 3 Day 1.",
	MAIN_QUEST_LOAN_STAGE1 = "You must have over 3000 gold by Week 5 Day 1.",
	MAIN_QUEST_LOAN_STAGE2 = "You must have over 10000 gold by Week 8 Day 1.",
	MAIN_QUEST_LOAN_STAGE3 = "You must have over 86000 gold by Week 15 Day 1.",

	GUILDS_INTRODUCTION_NAME1 = "The Four Guilds",
	GUILDS_INTRODUCTION_NAME2 = "First Step",
	GUILDS_INTRODUCTION_NAME3 = "New Friends",
	GUILDS_INTRODUCTION_SUMMARY = "You must get to know the most powerful establishments of Aliron. Those are the four guilds. You must earn their trust and loyalty.",
	GUILDS_INTRODUCTION_STAGE0 = "Visit the Four Aliron Guilds: Fighters, Servants, Workers, Mages; and choose one to join.",
	GUILDS_INTRODUCTION_STAGE1 = "Now, that you are accustomed with Aliron's order, you should start making progress with your standing. Earn at least 300 reputation with one of the four guilds. You can do so by completing quests from the city's notice board.",
	GUILDS_INTRODUCTION_STAGE1_5 = "You've earned enough reputation with one of the factions. Wait for a few days.",
	GUILDS_INTRODUCTION_STAGE2 = "An unexpected letter came this morning. It suggests you visit the Servants Guild and meet their leader.",

	DAISY_CLOTHES_NAME = "Daisy: New Outfit",
	DAISY_CLOTHES_SUMMARY = "Your slave, Daisy, could use a new set of clothes.",
	DAISY_CLOTHES_STAGE_1 = "Speak to Sigmund about a new set of clothes for Daisy. ",
	DAISY_CLOTHES_STAGE_2 = "Speak to Amelia about a new set of clothes for Daisy",
	DAISY_CLOTHES_STAGE_3 = "Wait, until Daisy's new clothes are finished. ",

	DAISY_TRAINING_NAME = "Daisy: Training",
	DAISY_TRAINING_SUMMARY = "Your slave, Daisy, could use some training as a proper servant.",
	DAISY_TRAINING_STAGE_1 = "Speak to Amelia and choose the specific training for Daisy.",
	DAISY_TRAINING_STAGE_2 = "Wait, until Daisy's training is complete. ",

	DAISY_LOST_NAME = "Daisy: Disappearance",
	DAISY_LOST_SUMMARY = "Your slave, Daisy, has gone missing. You should get her back before its too late.",
	DAISY_LOST_STAGE_1 = "Visit Amelia to find out what could have happened to Daisy",
	DAISY_LOST_STAGE_2 = "Find Daisy, who should be at Ramont's Estate",
	
	AMELIA_SILK_NAME = "Amelia: Request",
	AMELIA_SILK_SUMMARY = "After proving yourself useful to the Servants Guild, Amelia has given you a task.",
	AMELIA_SILK_STAGE_1 = "Deliver 50 Silk to Amelia at the Servants Guild.",
	
	AMELIA_HERBS_NAME = "Amelia: Elven Botany",
	AMELIA_HERBS_SUMMARY = "After helping her out, Amelia gave you a new task to earn her favor.",
	AMELIA_HERBS_STAGE_1 = "Visit Amelia at the Servants Guild", # go to Amelia and ask her what is up
	AMELIA_HERBS_STAGE_2 = "Travel to the Elven Capital and find the supplier Amelia told you about.", # Get the herbs
	AMELIA_HERBS_STAGE_3 = "Return to Amelia at the Servants Guild", # return to Amelia
	
	MARRIAGE_MAIN_NAME = "Marriage",
	MARRIAGE_MAIN_SUMMARY = "Marriage",
	MARRIAGE_MAIN_STAGE_1 = "Pay 500 gold to Aliron's church to set up a wedding ceremony.",
	MARRIAGE_MAIN_STAGE_2 = "Finish preparations with the Servants Guild and the Workers Guild, then visit the Church to start the wedding",
	MARRIAGE_SERVANTS_SUMMARY = "Marriage: Bread and Circuses",
	MARRIAGE_SERVANTS_NAME = "Marriage: Bread and Circuses",
	MARRIAGE_SERVANTS_STAGE_1 = "Deliver 200 of Fish, Meat, Vegetables and Grains, 10 Whiskey, 25 Beer and 3,000 gold to Amelia at the Servants Guild.",
	MARRIAGE_WORKERS_SUMMARY = "Marriage: A nice suit",
	MARRIAGE_WORKERS_NAME = "Marriage: A nice suit",
	MARRIAGE_WORKERS_STAGE_1 = "Deliver 150 Silk, 50 Magic Cloth and 1,000 gold to the Workers Guild tailor.",
	
	GRYPHON_QUEST_NAME = "Aire: Proof of Strength",
	GRYPHON_QUEST_SUMMARY = "You decided to prove yourself to Aire so she could relax about Anastasia's safety",
	GRYPHON_QUEST_STAGE_1 = "Talk to Sigmund about the possible location of Elder Gryphon",
	GRYPHON_QUEST_STAGE_2 = "Talk to Derek at Aliron",
	GRYPHON_QUEST_STAGE_3 = "Search through Gryphon Thicket to find Elder Gryphon's tracks",
	GRYPHON_QUEST_STAGE_4 = "Hunt down Elder Gryphon at Elder Gryphon Lair",
	
	PRE_SWORD_ARTIFACT_QUEST_NAME = "Champion's return",
	PRE_SWORD_ARTIFACT_QUEST_SUMMARY = "It seems someone wishes for your audience at Aliron's church",
	PRE_SWORD_ARTIFACT_QUEST_STAGE_1 = "Visit Aliron's church to find out who summoned you.",
	
	SWORD_ARTIFACT_QUEST_NAME = "Forests and Beasts",
	SWORD_ARTIFACT_QUEST_SUMMARY = "Even though the Civil War is over, it seems there might be greater issues in your future. Zephyra told you to gather an ancient artifacts. It seems the next one can be found at elven lands.",
	SWORD_ARTIFACT_QUEST_STAGE_1 = "Visit Ginny at Aliron's church",
	SWORD_ARTIFACT_QUEST_STAGE_2 = "Talk with the High Priestess at Elven Capital",
	SWORD_ARTIFACT_QUEST_STAGE_3 = "Visit Beastkin Tribe",
	SWORD_ARTIFACT_QUEST_STAGE_4 = "Visit Lodge at Beastkin Tribe",
	SWORD_ARTIFACT_QUEST_STAGE_5 = "Bring 2000 Meat and Fish to Savra",
	SWORD_ARTIFACT_QUEST_STAGE_6 = "Return to Beastkin Tribe after 1 day",
	SWORD_ARTIFACT_QUEST_STAGE_7 = "Visit Beastkin Tribe",
	SWORD_ARTIFACT_QUEST_STAGE_77 = "Perform the ritual with Mae",
	SWORD_ARTIFACT_QUEST_STAGE_8 = "Search for Leon at Beastkin Tribe",
	SWORD_ARTIFACT_QUEST_STAGE_9 = "Search for Leon at forest location",
	SWORD_ARTIFACT_QUEST_STAGE_10 = "Talk to Savra about breaking Leon's madness",
	SWORD_ARTIFACT_QUEST_STAGE_11 = "Deliver 50 Magic Wood, 25 Iron Wood and 15 Mythic Leather to Savra",
	SWORD_ARTIFACT_QUEST_STAGE_12 = "Find a helper for Savra's work",
	SWORD_ARTIFACT_QUEST_STAGE_13 = "Return to Leon once more",
	SWORD_ARTIFACT_QUEST_STAGE_14 = "Track down the White Stag",
	SWORD_ARTIFACT_QUEST_STAGE_15 = "Talk with Erlen at Elven Capital",
	
	TEMPLE_QUEST_NAME = "Ancient Elven Temple",
	TEMPLE_QUEST_SUMMARY = "Freya's High Priestess, Heleviel, asked you to bring here some sacred water required for the ritual.",
	TEMPLE_QUEST_STAGE_1 = "Visit Ancient Elven Temple to obtain Sacred Water",
	TEMPLE_QUEST_STAGE_2 = "Return to Heleviel with Sacred Water",
	
	GETTING_LIRA_QUEST_NAME = "Revelation",
	GETTING_LIRA_QUEST_SUMMARY = "With all things set you have to make your move together with Erlen in attempt to deal with Heleviel. ",
	GETTING_LIRA_QUEST_STAGE_1 = "Search for Erlen",
	GETTING_LIRA_QUEST_STAGE_2 = "Find a way to get young priestess from Elven Capital to Erlen",
	GETTING_LIRA_QUEST_STAGE_3 = "Get 10 Whiskey to get Lira out of the temple",
	GETTING_LIRA_QUEST_STAGE_4 = "Return to Erlen with Lira",
	GETTING_LIRA_QUEST_STAGE_5 = "Meet Erlen at Elven Capital",
	
	CALI_FIGHTERS_QUEST_NAME = "Cali: Small and Brave",
	CALI_FIGHTERS_QUEST_SUMMARY = "Your member, Cali, wants to be more useful and decided to join fighters guild",
	CALI_FIGHTERS_QUEST_STAGE_1 = "Visit fighters guild to registrate Cali",
	CALI_FIGHTERS_QUEST_STAGE_2 = "Go to the village to help Cali get rid of goblins",
	CALI_FIGHTERS_QUEST_STAGE_3 = "Report back to Fighters Guild",
	CALI_SERVANTS_QUEST_SUMMARY = "Your member, Cali, wants to get more feminine and wishes to attend Servants classes.",
	CALI_SERVANTS_QUEST_NAME = "Cali is a Girl",
	CALI_SERVANTS_QUEST_STAGE_1 = "Visit Servants guild on Cali's behalf",
	CALI_HEIRLOOM_QUEST_SUMMARY = "Cali's past finally caught up with her. You'll have to help her sort it out if you want to keep her at your side...",
	CALI_HEIRLOOM_QUEST_NAME = "Cali: Pariah",
	CALI_HEIRLOOM_QUEST_STAGE_1 = "Visit Village ",
	CALI_HEIRLOOM_QUEST_STAGE_2 = "Bring 200 Rough Wood to Peasant",
	CALI_HEIRLOOM_QUEST_STAGE_2_1 = "Bring 100 Rough Wood to Peasant",
	CALI_HEIRLOOM_QUEST_STAGE_3 = "Search For Bandits",
	CALI_HEIRLOOM_QUEST_STAGE_4 = "Ask about Collector at streets of Aliron",
	CALI_HEIRLOOM_QUEST_STAGE_5 = "It seems you won't be able to meet William just yet... Perhaps you'll have to do something esle for now.",
	CALI_HEIRLOOM_QUEST_STAGE_5_1 = "Visit William at Aliron City",
	CALI_HEIRLOOM_QUEST_STAGE_6 = "Get Cali's heirloom sword from William",
	CALI_HEIRLOOM_QUEST_STAGE_7 = "Wait for Cali to return",
	CALI_HEIRLOOM_QUEST_STAGE_8 = "Wait for some time",
	CALI_HEIRLOOM_QUEST_STAGE_9 = "Speak with Cali",
	CALI_HEIRLOOM_QUEST_STAGE_10 = "Visit Cali's home",
	
	LILIA_MEET_QUEST_NAME = "Lilia: Fairy Unusual",
	LILIA_MEET_QUEST_SUMMARY = "You've learned about an extraordinary fairy which resides in one of forest settlements. Perhaps its worth investigating",
	LILIA_MEET_QUEST_STAGE_1 = "Find a fairy you've heard about in one of forest settlements",
	LILIA_MEET_QUEST_STAGE_2 = "Persuade Lilia to join you",
	
	SICK_LILIA_QUEST_NAME = "Lilia: Homesick",
	SICK_LILIA_QUEST_SUMMARY = "Lilia has fallen ill. It's up to you to help her now.",
	SICK_LILIA_QUEST_STAGE_1 = "Ask Myr for help",
	SICK_LILIA_QUEST_STAGE_2 = "Visit Xari",
	SICK_LILIA_QUEST_STAGE_3 = "Find troll which stole Xari's clothes",
	SICK_LILIA_QUEST_STAGE_35 = "Get Xari's clothes from troll",
	SICK_LILIA_QUEST_STAGE_4 = "Return to Xari with her clothes",
	SICK_LILIA_QUEST_STAGE_5 = "Cure Lilia",
	
	CALI_TAMING_QUEST_NAME = "Cali: Beast Taming",
	CALI_TAMING_QUEST_SUMMARY = "You've decided to play rough with a wolf girl you met before taking her with you. However, this demands your further attention.",
	CALI_TAMING_QUEST_STAGE_1 = "Visit Workers' Guild on behalf of Cali's new accessory",
	CALI_TAMING_QUEST_STAGE_2 = "Find Limrov in Aliron and ask about collar",
	CALI_TAMING_QUEST_STAGE_3 = "Return with materials for the collar",
	CALI_TAMING_QUEST_STAGE_4 = "Wait until collar is finished",
	CALI_TAMING_QUEST_STAGE_5 = "Wait for a bit",
	CALI_TAMING_QUEST_STAGE_6 = "Find a mage to help you",
	CALI_TAMING_QUEST_STAGE_7 = "Return to Jean with needed materials",
	CALI_TAMING_QUEST_STAGE_8 = "Return to Mages Guild",
	CALI_TAMING_QUEST_STAGE_9 = "Wait for a bit",
	CALI_TAMING_QUEST_STAGE_10 = "Talk to Cali",
	CALI_TAMING_QUEST_STAGE_11 = "Wait a little",
	CALI_TAMING_QUEST_STAGE_12 = "Search Aliron for new discoveries",
	CALI_TAMING_QUEST_STAGE_13 = "Return to Merchant",
	CALI_TAMING_QUEST_STAGE_14 = "Wait for a bit",
	CALI_TAMING_QUEST_STAGE_15 = "Visit Aliron's pet shop",
	CALI_TAMING_QUEST_STAGE_16 = "Talk to Cali",
	CALI_TAMING_QUEST_STAGE_17 = "Talk to Cali",
	
	DIALOGUEANAINITIATELP = "Anastasia greets you with a shy face. It seems she's not really accustomed to this new role.\n\n- “H-hello, [Master]... How was your day?",
	DIALOGUEANAINITIATELN = "Anastasia visits you with a grim look. Perhaps you will have to work on her motivation. She stays silent having no words for you.\n\n- ......",
	DIALOGUEANAINITIATEHP = "Anastasia greets you with a smile. Even though she does not show it, she looks rather content.\n\n- “[Master]. Are you feeling well? What can I do for you?",
	DIALOGUEANAINITIATEHN = "Anastasia greets you with a submissive demeanor. It seems she finally gave up on her old life and accepted this role.\n\n- “[Master]! How can I s-serve you?",
	DIALOGUEANAINITIATEM = "Your wife, Anastasia smiles warmly at you.\n\n- “Dear, You called for me?",
	DIALOGUEANAINITIATEB = "As Anastasia responds to your summon her eyes are nearly blank.\n\n- “What is your order, [Master]?",
	DIALOGUEAIREINITIATELN = "Your elven slave Aire whom was left alone in your custody, looks at you in silence and disgust. Her pose emanates protest.",
	DIALOGUEAIREINITIATEHN = "Your elven slave Aire has submitted to your ownership and now patiently waits for your commands.\n\n- “What do you order, master?“",
	DIALOGUEAIREINITIATELP = "Your elven slave Aire stands before you, not quite hostile but still cautious.\n\n- “You wanted to see me? Is Ana doing well?",
	DIALOGUEAIREINITIATEHP = "Your elven slave Aire comes at your call. It seems despite her official status she's grown quite trustful to you.\n\n- “[Master]. You wanted to see me? I hope you are treating Ana with respect.",
	DIALOGUEZEPHINITIATEL = "Mysterious as always Zephyra appears in front of you almost imperceptibly.\n\n- “Greetings, [Master]. Are you looking for my company?",
	DIALOGUEZEPHINITIATEH = "The fox-girl Zephyra appears in front of you nonchalantly.\n\n- [Master]. What are you doing this evening? How about a tea party?\n\nIt seems she ignores the fact it was you who summoned her.",
	DIALOGUEZEPHINITIATEM = "Your wife, the ever eccentric fox-girl Zephyra appears and quickly closes distance with you, grasping your hand.\n\n- Darling! Have you missed me?\n\nShe affectionately entwines her tail with your leg..",
	DIALOGUEDAISYINITIATEL = "Your recent acquisition: a shy bunny-girl, Daisy appears as you summon her.\n\n- Y-yes, [Master]. What can I-I do?\n\nYou feel like she almost has to force herself from hiding from you.",
	DIALOGUEDAISYINITIATEH = "The bunny-girl Daisy appears before you. It seems she has grown used to serving you.\n\n- [Master], how's your day been? What can I do for you?",
	DIALOGUEDAISYINITIATEM = "Your wife and slave Daisy stands before you.\n\n- [Master], how's been your day? Would you like dinner, a bath, or me...? Sorry, someone told me it's a good way to greet you like this!",
	DIALOGUECALIINITIATELP = "The wolf-girl Cali quickly appears showing no hints of fear or shyness.\n\n- Heya, what's up?!",
	DIALOGUECALIINITIATELN = "The wolf-girl Cali reluctantly comes as you summon her. She barely keeps her tongue in cheek.\n\n- W-What do you want?",
	DIALOGUECALIINITIATEHP = "Cali appears in front of you eagerly begging for your attention ,her tail wagging.\n\n- [Master]! What are we doing today? Wanna go somewhere together? I've heard of a really nice meat stall...",
	DIALOGUECALIINITIATEHN = "Cali submissively appears on your command with her ears lowered. Her old boldness has finally been uprooted as she obediently obeys your command.\n\n- W-what can I do for you, [Master]?",
	DIALOGUECALIINITIATEM = "Your young wife, Cali, jumps at you as you visit her. It seems her marital status hasn't really affected her character.\n\n- [Master]! What are we doing today? Wanna play something together?",
	DIALOGUELILIAINITIATEL = "Lilia appears before you cheerfully smiling.\n\n- [Master]? Whatcha doin'? Did you came to play with me?",
	DIALOGUELILIAINITIATEH = "The small fairy impatiently jumps at you as you summon her. \n\n- It's been so lonely without you, [Master]! Are you gonna cheer me up?",
	DIALOGUELILIAINITIATEM = "Your extravagant wife, Lilia, passionately greets you barely hiding her excitement.\n\n- [Master], you've been missing Lilia? Let's go to bed already!",
	DIALOGUEJEANINITIATEM = "",
	
	
	
	
	
	METRICS_BASE = "[name] has been a part of your household for {color=yellow|%d} weeks and {color=yellow|%d} days.",
	METRICS_DATES_MASTER = "[He] went on dates {color=yellow|%d} time(s) and engaged in sex activities {color=yellow|%d} time(s).",
	METRICS_DATES = "[He] went on dates with you {color=yellow|%d} time(s) and engaged in sex activities {color=yellow|%d} time(s).",
	METRICS_PARTNERS = "Overall [he] had sex with {color=yellow|%d} partners during all this time. ",
	METRICS_PARTNERS_ONE = "[He] only had a {color=yellow|single partner} for all this time. ",
	METRICS_PARTNERS_NONE = "[He] didn't appear to engage into sexual activity with anyone so far... ",
	METRICS_IMPREGS = "[He] was impregnated {color=yellow|%d} time(s) which ended in child birth {color=yellow|%d} time(s). ",
	METRICS_PEGNANCIES = "[He] had impregnated {color=yellow|%d} time(s). ",
	METRICS_VIRGINITY_YOU = "[He] lost [his] vaginal virginity to {color=yellow|you}. ",
	METRICS_VIRGINITY_OTHER = "[He] lost [his] vaginal virginity to {color=yellow|%s}. ",
	METRICS_ANAL_VIRGINITY_YOU = "[His] first experience with anal penetration was with {color=yellow|you}. ",
	METRICS_ANAL_VIRGINITY_OTHER = "[His] first experience with anal penetration was with {color=yellow|%s}. ",
	METRICS_EARNED = "[He] earned {color=yellow|%d} gold, gathered {color=yellow|%d} food and {color=yellow|%d} materials while working on you. ",
	METRICS_COMBAT = "[He] engaged in {color=yellow|%d} battles and defeated {color=yellow|%d} enemies. ",
	
	
	METRICS_SOURCE_BROTHEL_CUSTOMER = "a customer of a brothel",
	METRICS_SOURCE_GUILD_TRAINER = "a guild trainer, during sex toy training",
	METRICS_SOURCE_WILLIAM = "William, Aliron's famous collector",
	
	
	
	# DATING
	
	ANASTASIA_MARRIAGE_AGREED_TEXT = """As by our agreement... I'm ready to become your wife.""",
	ANASTASIA_MARRIAGE_AGREED_DESCRIPTION = """Anastasia reddens a bit, but managed to compose herself like a lady before answering.""",
	ANASTASIA_ENSLAVEMENT_AGREED_TEXT = """Sorry, this is not going to happen, even if you say so, I'm not allowed to marry you.""",
	ANASTASIA_ENSLAVEMENT_AGREED_DESCRIPTION = """Even though Anastasia clearly surprised by your words, she keeps her face mostly calm.""",
	AIRE_ANA_ALIVE_TEXT = """Regardless of my feelings towards you, I can't agree to it. You must marry Ana, not me.""",
	AIRE_ANA_ALIVE_DESCRIPTION = """Aire looks completely deadpan to your proposal.""",
	AIRE_ANA_DEAD_TEXT = """Don't waste your time. I will never agree to this after what happened to Ana.""",
	AIRE_ANA_DEAD_DESCRIPTION = """Aire looks completely deadpan to your proposal.""",
	DAISY_QUEST_FINISHED_TEXT = """A-are you for real, [Master]?.. I-if you find me worthy... Of course I agree!""",
	DAISY_QUEST_FINISHED_DESCRIPTION = """Daisy's eyes widen hearing your proposal. Barely holding back her tears of joy, she slowly replies.""",
	DAISY_QUEST_UNFINISHED_TEXT = """I-I'm sorry, [Master], I think this is a bit too sudden...""",
	DAISY_QUEST_UNFINISHED_DESCRIPTION = """Daisy looks troubled and averts her eyes.""",
	CALI_QUEST_FINISHED_TEXT = """Really!? Of course I will. Nobody ever done so much for me... I love you, [Master]!""",
	CALI_QUEST_FINISHED_DESCRIPTION = """Cali turns ecstatic on hearing your words. After going through so much with you, her answer is obvious.""",
	CALI_QUEST_UNFINISHED_TEXT = """That's really weird thing for you to say... Sorry, I don't think I'm ready yet.""",
	CALI_QUEST_UNFINISHED_DESCRIPTION = """Cali gives you a troubled look, trying to joke it off.""",
	CALI_BAD_ROUTE_FINISHED_TEXT = """I-if [Master] desires me to become [his] wife, I will be happy to do it!""",
	CALI_BAD_ROUTE_FINISHED_DESCRIPTION = """Cali dumbfoundedly looks up at you. After being trained in such lengths, she can only find joy in such recognition from you.""",
	CALI_BAD_ROUTE_UNFINISHED_TEXT = """Are you kidding me?! Who would ever marry a horrible person like you?""",
	CALI_BAD_ROUTE_UNFINISHED_DESCRIPTION = """Cali looks clearly agitated by your proposal. It seems you haven't fully bended her yet.""",

	#ChatNode
	
	HIRE_LINE1 = "...Pleased to meet you, [Master].",
	HIRE_LINE2 = "Please, take care of me, [Master].",
	HIRE_LINE3 = "So you are my new [Master]! Pleased to meet you!",
	HIRE_LINE4 = "I hope you aren't taking me just for lewd affairs.",
	HIRE_LINE5 = "Ah, yes... I-it's a pleasure to meet you, [Master]!",
	HIRE_LINE6 = "So you're my new [Master] huh? You don't look that impressive to me.",
	HIRE_LINE7 = "Great. Let's get out of here. Can't wait to see my new place!",
	HIRE_LINE8 = "You look like a lot of fun. Let's get going, [Master]. My talents are wasted here anyways.",
	HIRE_LINE9 = "We going, or what, [Master]?",
	HIRE_LINE10 = "About time! Thought I'd never get out of here. Let's go, [Master]!",
	HIRE_LINE11 = "Oh my... I'm so honored to be of service, [Master]. I hope to serve you well.",
	HIRE_LINE12 = "I will gladly entrust myself to you, [Master].",
	HIRE_LINE13 = "I'm so excited! I can't wait to show what I can do for you,[Master]!",
	HIRE_LINE14 = "Secretly... I hoped you would pick me. I won't disappoint you, [Master].",
	HIRE_LINE15 = "I shall take good care of you, [Master]. If you would do the same?",
	HIRE_LINE16 = "Indeed. A wise choice, [Master]. Let us take our leave.",
	HIRE_LINE17 = "Oh? I suppose this will be a learning experience. Wouldn't you agree, [Master]?",
	HIRE_LINE18 = "I see they sent someone worthy of my talents. Let us quit this place [Master].",
	HIRE_LINE19 = "Hmm? Ahh... Sorry. You're my new [Master] correct? Please do not use me for your perversions.",
	HIRE_LINE20 = "I suppose it can't be helped. My skills are yours, [Master].",
	HIRE_LINE21 = "M-me? I mean... if you're sure about this, [Master]...",
	HIRE_LINE22 = "O-oh! I thought no one would take me... I'll do my best...",
	HIRE_LINE23 = "Pleased to meet you. I hope I don't get in your way, [Master]...",
	HIRE_LINE24 = "W-wow... You look really strong, [Master]... Please look after me.",
	HIRE_LINE25 = "Y-you're not going to take advantage of me... Are you [Master]?",
	
	SLAVERY_LINE1 = "You... made me into a slave? No... *sob*",
	SLAVERY_LINE2 = "Why have you done this!?",
	SLAVERY_LINE3 = "Why...? *sob*",
	SLAVERY_LINE4 = "This is despicable! I'll not take it!",
	SLAVERY_LINE5 = "How could you?! I hate you!",
	SLAVERY_LINE6 = "I-I see... Maybe it's better this way...?",
	SLAVERY_LINE7 = "I knew this would happen to me...",
	SLAVERY_LINE8 = "Why did I ever trust you!?",
	SLAVERY_LINE9 = "Was it something I did? Please... How could you?",
	SLAVERY_LINE10 = "I-I guess this was my true purpose after all...",
	SLAVERY_LINE11 = "Though I'm not quite happy about this. I shall serve you like I always have...",
	SLAVERY_LINE12 = "Was I not good enough for you...?",
	SLAVERY_LINE13 = "Please Tell me you're not serious... why...?",
	SLAVERY_LINE14 = "Just when I was growing fond of you...",
	SLAVERY_LINE15 = "I suppose... this is still better than parting...",
	SLAVERY_LINE16 = "I knew you had lecherousintentions the moment I laid my eyes on you.",
	SLAVERY_LINE17 = "How utterly revolting.",
	SLAVERY_LINE18 = "Have you no sense of decency?",
	SLAVERY_LINE19 = "To think my life lead to this...",
	SLAVERY_LINE20 = "Tsk. I won't forgive you for this.",
	SLAVERY_LINE21 = "How dare you do this to me!?",
	SLAVERY_LINE22 = "You jerk! If only I was stronger!",
	SLAVERY_LINE23 = "I don't like this, or you!",
	SLAVERY_LINE24 = "You think you're so tough now huh!?",
	SLAVERY_LINE25 = "So cruel! I won't do anything for you!",

	EXPERIENCE_LINE1 = "I've learned so much recently... I think I'm ready for bigger things!",
	EXPERIENCE_LINE2 = "My skills have grown. ",
	EXPERIENCE_LINE3 = "I feel like I've learned a lot... what do you think, [Master]?",
	EXPERIENCE_LINE5 = "Um, [Master], I think I can learn something new to be useful to you...",
	EXPERIENCE_LINE6 = "[Master], with all experience I got, I'm sure I can be more useful to you.",
	EXPERIENCE_LINE61 = "Isn't this wonderful [Master]? I hope to make myself even better for you.",
	EXPERIENCE_LINE7 = "[Master]! I've learned a lot from you. Maybe it's time to learn new things?",
	EXPERIENCE_LINE8 = "Oh! I think I have the hang of this! Thank you for teaching me!",
	EXPERIENCE_LINE9 = "Wow! I feel so energized! I'm ready to learn even more!",
	EXPERIENCE_LINE10 = "Thank you for being so patient with me [Master]! I feel stronger already!",
	EXPERIENCE_LINE11 = "Hmm? I suppose I should dabble in other skills.",
	EXPERIENCE_LINE12 = "Already? Seems I'm quite the natural.",
	EXPERIENCE_LINE13 = "Ahh... I think it's time to learn new things.",
	EXPERIENCE_LINE14 = "It's only natural for me to progress so elegantly.",
	EXPERIENCE_LINE15 = "Oh. [Master]. I have aquired new talents.",
	EXPERIENCE_LINE16 = "Getting better, and better every day!",
	EXPERIENCE_LINE17 = "You see this, [Master]? Aren't I great?",
	EXPERIENCE_LINE18 = "Ha! pretty soon I'll be stronger than you, [Master]",
	EXPERIENCE_LINE19 = "Yeah... I'm pretty great, but I'm about to be even greater!",
	EXPERIENCE_LINE20 = "Looks like I'm ready to learn even more!",
	EXPERIENCE_LINE21 = "O-oh... [Master]. I think I'm ready to learn new things...",
	EXPERIENCE_LINE22 = "I-I see... I think I can learn more now...",
	EXPERIENCE_LINE23 = "[Master]. I think my skills are improving...",
	EXPERIENCE_LINE24 = "So that's how it's done... I think I get it now...",
	EXPERIENCE_LINE25 = "Right... maybe I am getting better?",
	
	ITEM_CREATED_LINE1 = "That's finally done...",
	ITEM_CREATED_LINE2 = "I've done it, [Master].",
	ITEM_CREATED_LINE3 = "That thing you asked to make, [Master]...",
	ITEM_CREATED_LINE4 = "Here, [Master], I've done my best.",
	ITEM_CREATED_LINE5 = "Seriously, [Master]? Can you give me a real challenge?",
	ITEM_CREATED_LINE6 = "Yeah Yeah... It's done.",
	ITEM_CREATED_LINE7 = "This is too easy!",
	ITEM_CREATED_LINE8 = "I could do this all day!",
	ITEM_CREATED_LINE9 = "Another one for the collection!",
	ITEM_CREATED_LINE10 = "Flawless... As usual.",
	ITEM_CREATED_LINE11 = "Finished with this one, [Master].",
	ITEM_CREATED_LINE12 = "Here we are... Finished.",
	ITEM_CREATED_LINE13 = "Ahh. Such a simple design.",
	ITEM_CREATED_LINE14 = "Hmm? I suppose it's ready.",
	ITEM_CREATED_LINE15 = "Look, [Master]! It's finished!",
	ITEM_CREATED_LINE16 = "Such fun! It came out great!",
	ITEM_CREATED_LINE17 = "Here you go. All done!",
	ITEM_CREATED_LINE18 = "This will make, [Master] happy! ",
	ITEM_CREATED_LINE19 = "Finished just in time!",
	ITEM_CREATED_LINE20 = "I-I hope it came out okay...",
	ITEM_CREATED_LINE21 = "I-It's finished, [Master]...",
	ITEM_CREATED_LINE22 = "Oh... That was really hard to make.",
	ITEM_CREATED_LINE23 = "H-how did I manage it...?",
	ITEM_CREATED_LINE24 = "All done...",
	
	
	COMBAT_WIN_LINE1 = "Phew, we did it, [Master]...",
	COMBAT_WIN_LINE2 = "Hah, piece of cake. Who's next?",
	COMBAT_WIN_LINE3 = "Well fought. Lets move on, [Master]. ",
	COMBAT_WIN_LINE4 = "I'm glad we won, but let's keep cautious. ",
	COMBAT_WIN_LINE5 = "Hah, I didn't even break a sweat.",
	COMBAT_WIN_LINE6 = "That was really scary. I hope there's not more of them...",
	COMBAT_WIN_LINE7 = "I... Can't believe we won...",
	COMBAT_WIN_LINE8 = "A-and don't come back...",
	COMBAT_WIN_LINE9 = "I hope I helped...",
	COMBAT_WIN_LINE10 = "T-they made us do it...",
	COMBAT_WIN_LINE11 = "We've dealt a decisive blow.",
	COMBAT_WIN_LINE12 = "Was that all they could muster?",
	COMBAT_WIN_LINE13 = "A feeble struggle. Barely worth the effort.",
	COMBAT_WIN_LINE14 = "Let's move on.",
	COMBAT_WIN_LINE15 = "A fight barely worth mentioning.",
	COMBAT_WIN_LINE16 = "That's what you get!",
	COMBAT_WIN_LINE17 = "Shouldn't have challenged me!",
	COMBAT_WIN_LINE18 = "Done already!?",
	COMBAT_WIN_LINE19 = "Damn! I wanted to fight some more.",
	COMBAT_WIN_LINE20 = "Pathetic. Why even bother attacking?",
	COMBAT_WIN_LINE21 = "I hope they're okay...",
	COMBAT_WIN_LINE22 = "Is everyone alright?",
	COMBAT_WIN_LINE23 = "Why did we have to fight?",
	COMBAT_WIN_LINE24 = "We couldn't talk this out...?",
	COMBAT_WIN_LINE25 = "Let's hope we don't have to fight again...",
	
	SEX_START_LINE1 = "Um... you really want me to do this? I'm not sure I'm ready...",
	SEX_START_LINE2 = "You want me for lewd things, [Master]...",
	SEX_START_LINE3 = "I'm not too eager for this, but if you insist.",
	SEX_START_LINE4 = "Hmh, leering over my body, [Master]?",
	SEX_START_LINE5 = "Alright, if you want me...",
	SEX_START_LINE6 = "I...like being with you, [Master]...",
	SEX_START_LINE7 = "Ugh... Really? Fine, but you better not be gentle!",
	SEX_START_LINE8 = "I knew you were lusting over me!",
	SEX_START_LINE9 = "Don't think I'm easy, or anything. I need relief too you know.",
	SEX_START_LINE10 = "What's the hold up? Let's get to it!",
	SEX_START_LINE11 = "Looks like we were both thinking the same thing!",
	SEX_START_LINE12 = "Let me tend to your every need.",
	SEX_START_LINE13 = "I've been waiting for you.",
	SEX_START_LINE14 = "Let's make this fun for the both of us.",
	SEX_START_LINE15 = "Oh my... I can hardly contain myself!",
	SEX_START_LINE16 = "These intimate moments make it all the better.",
	SEX_START_LINE17 = "Hmm? I suppose we could use a break.",
	SEX_START_LINE18 = "Ahh... Indulging yourself with me are you?",
	SEX_START_LINE19 = "You've chosen me have you?",
	SEX_START_LINE20 = "I have been thinking about this all day...",
	SEX_START_LINE21 = "Keeping composure around you is... difficult.",
	SEX_START_LINE22 = "M-me? I hope I can sate your desires...",
	SEX_START_LINE23 = "P-please spend time with me. I'll do anything...",
	SEX_START_LINE24 = "O-oh? You want me for your... needs?",
	SEX_START_LINE25 = "I-I'll do my best to serve you...",
	SEX_START_LINE26 = "M-my body is yours... Please be gentle...",

	SEX_FINISH_LINE1 = "...I-I'm not against doing it again.",
	SEX_FINISH_LINE3 = "Ahh, it feels like a waste to work after this.",
	SEX_FINISH_LINE4 = "Uh, my body is all sweaty now... Can I take a bath, [Master]?",
	SEX_FINISH_LINE5 = "I'll be sore for awhile, but it was worth it.",
	SEX_FINISH_LINE6 = "Done already!? I wanted to go all night!",
	SEX_FINISH_LINE7 = "That's exactly what I needed!",
	SEX_FINISH_LINE8 = "Don't think for a second that this means I like you.",
	SEX_FINISH_LINE9 = "What a workout!",
	SEX_FINISH_LINE10 = "That was wonderful.",
	SEX_FINISH_LINE11 = "I've never felt such pleasure.",
	SEX_FINISH_LINE12 = "Was it good for you?",
	SEX_FINISH_LINE13 = "We should do this more often.",
	SEX_FINISH_LINE14 = "I want to stay in bed longer with you.",
	SEX_FINISH_LINE15 = "Such primitive pleasures...",
	SEX_FINISH_LINE16 = "Hnn... Perhaps this is better than I thought.",
	SEX_FINISH_LINE17 = "My my... quite the capable lover aren't you?",
	SEX_FINISH_LINE18 = "Perhaps we should do this again sometime...",
	SEX_FINISH_LINE19 = "That was... pleasant to say the least...",
	SEX_FINISH_LINE20 = "Could we... do this again sometime?",
	SEX_FINISH_LINE21 = "Can we cuddle a bit...?",
	SEX_FINISH_LINE22 = "That felt... really good.",
	SEX_FINISH_LINE23 = "O-oh... it's over?",
	SEX_FINISH_LINE24 = "I-I hope that I was okay...",
	
	MASTER_PRAISE_LINE1 = "I've got praised by [Master]... It makes me happy",
	MASTER_PRAISE_LINE2 = "I've earned it, haven't I, [Master]?",
	MASTER_PRAISE_LINE3 = "O-oh! Thank you, [Master]. I'm glad I could make you happy...",
	MASTER_PRAISE_LINE4 = "I.... I did do good... right, [Master]?",
	MASTER_PRAISE_LINE5 = "B-being praised by [Master]... ",
	MASTER_PRAISE_LINE6 = "T-thank you. I've been trying my best, [Master].",
	MASTER_PRAISE_LINE7 = "It was nothing... really...",
	MASTER_PRAISE_LINE8 = "About time I got recognized!",
	MASTER_PRAISE_LINE9 = "Yeah yeah... I know I'm great.",
	MASTER_PRAISE_LINE10 = "Please. It was nothing, [Master].",
	MASTER_PRAISE_LINE11 = "Keep the praises coming, [Master]!",
	MASTER_PRAISE_LINE12 = "Who's the best? I'm the best!",
	MASTER_PRAISE_LINE13 = "It's nice to be noticed once in awhile.",
	MASTER_PRAISE_LINE14 = "Hmm? Oh. You're quite welcome, [Master].",
	MASTER_PRAISE_LINE15 = "Are you trying to butter me up, [Master]?",
	MASTER_PRAISE_LINE16 = "Ahh... it was nothing. ",
	MASTER_PRAISE_LINE17 = "Honeyed words won't sway me, [Master]... But thank you.",
	MASTER_PRAISE_LINE18 = "I'm glad to be of service!",
	MASTER_PRAISE_LINE19 = "Thank you, [Master]! I won't disappoint you!",
	MASTER_PRAISE_LINE20 = "Stop it , [Master]. You're making me blush.",
	MASTER_PRAISE_LINE21 = "Wow! I didn't think you thought so highly of me!",
	MASTER_PRAISE_LINE22 = "I'll make sure to keep this up! Just for you, [Master].",
	
	
	MASTER_PUNISH_LINE1 = "Sorry, I'll be good, [Master]...",
	MASTER_PUNISH_LINE2= "Ugh... it really hurts, [Master].",
	MASTER_PUNISH_LINE3 = "I understand... this is for the order.",
	MASTER_PUNISH_LINE4 = "Hmh! Just so you know, it didn't hurt at all!",
	MASTER_PUNISH_LINE5 = "No... Take pity of a kitty!",
	MASTER_PUNISH_LINE6 = "I'm so sorry... I know I can do better, [Master]...",
	MASTER_PUNISH_LINE7 = "I didn't mean to upset you. I'm sorry [Master].",
	MASTER_PUNISH_LINE8 = "[Master]? Is this really necessary?",
	MASTER_PUNISH_LINE9 = "If this is to make me better... than I accept, [Master].",
	MASTER_PUNISH_LINE10 = "Ow... Why are you doing this to me, [Master]?",
	MASTER_PUNISH_LINE11 = "Like I need you to tell me I screwed up, [Master].",
	MASTER_PUNISH_LINE12 = "Why am I letting this happen?",
	MASTER_PUNISH_LINE13 = "I'll remember this...",
	MASTER_PUNISH_LINE14 = "Almost felt good for a second there, [Master].",
	MASTER_PUNISH_LINE15 = "Really? is that all you got, [Master]?",
	MASTER_PUNISH_LINE16 = "D-did I do something wrong, [Master]?",
	MASTER_PUNISH_LINE17 = "I-it's all my fault... isn't it?",
	MASTER_PUNISH_LINE18 = "I-I should have done better... Sorry...",
	MASTER_PUNISH_LINE19 = "T-that sort of felt... good...",
	MASTER_PUNISH_LINE20 = "I w-wont do it again. I promise, [Master]...",
	MASTER_PUNISH_LINE21 = "I see you're not above primitive punishments...",
	MASTER_PUNISH_LINE22 = "Really? For what, [Master]?",
	MASTER_PUNISH_LINE23 = "I suppose this is the right course for my failures...",
	MASTER_PUNISH_LINE24 = "[Master]? Ahh I see... It will be a lesson not soon forgotten...",
	MASTER_PUNISH_LINE25 = "I'll feel that sting for quite awhile...",
	
	MASTER_ABUSE_LINE1 = "Why... *sob*",
	MASTER_ABUSE_LINE2 = "This is horrible... You are horrible!",
	MASTER_ABUSE_LINE3 = "Ah! Please, not the ears!",
	MASTER_ABUSE_LINE4 = "Please... no more...",
	MASTER_ABUSE_LINE5 = "What have I done to deserve this, [Master]? *sob*",
	MASTER_ABUSE_LINE6 = "No! Stop! That really hurts!",
	MASTER_ABUSE_LINE7 = "Why are you so mean to me!?",
	MASTER_ABUSE_LINE8 = "Why do I even try to please you!?",
	MASTER_ABUSE_LINE9 = "*sobs* That's okay... I know you still care, [Master]...",
	MASTER_ABUSE_LINE10 = "W-why are you so mean, [Master]...?",
	MASTER_ABUSE_LINE11 = "S-should I... just accept this?",
	MASTER_ABUSE_LINE12 = "I-it hurts so much...",
	MASTER_ABUSE_LINE13 = "I-I guess this is all I'm good for...",
	MASTER_ABUSE_LINE14 = "P-please don't let anyone see this...",
	MASTER_ABUSE_LINE15 = "How dare you!? Let me go!",
	MASTER_ABUSE_LINE16 = "One of these days I'll get you back for this!",
	MASTER_ABUSE_LINE17 = "Damn! my cheeks stings so much...",
	MASTER_ABUSE_LINE18 = "You're lucky you're not the one in this position...",
	MASTER_ABUSE_LINE19 = "Gah! don't think you've bested me..",
	MASTER_ABUSE_LINE20 = "Careful... This is too much, [Master]...",
	MASTER_ABUSE_LINE21 = "This has simply gone out of hand.",
	MASTER_ABUSE_LINE22 = "How dare you do this to me?" ,
	MASTER_ABUSE_LINE23 = "Ow... I'll be feeling that for weeks...",
	MASTER_ABUSE_LINE24 = "I should have known you have a temper...",
	
	SEX_REWARD_LINE1 = "Such reward? There's no... Ah...",
	SEX_REWARD_LINE2 = "[Master]? *gulp* I haven't really asked for this...",
	SEX_REWARD_LINE3 = "A lewd reward?.. Huh, fine, I could use a break.",
	SEX_REWARD_LINE4 = "Finally! It's about time you take care of my needs.",
	SEX_REWARD_LINE5 = "Ugh. I guess I did need a bit of relief.",
	SEX_REWARD_LINE6 = "This just some excuse for you to have your way with me?",
	SEX_REWARD_LINE7 = "Fine... Guess I did kind of need this right now.",
	SEX_REWARD_LINE8 = "Guess we're both in a mood huh?",
	SEX_REWARD_LINE9 = "Ahh. I quite needed that. Thank you.",
	SEX_REWARD_LINE10 = "If you would be so kind. I have been feeling in need...",
	SEX_REWARD_LINE11 = "I suppose I have been tense lately...",
	SEX_REWARD_LINE12 = "Oh my... I will gladly enjoy this.",
	SEX_REWARD_LINE13 = "Don't tell the others of this...",
	SEX_REWARD_LINE14 = "Please? I really need this...",
	SEX_REWARD_LINE15 = "Thank you so much! I knew I could rely on you for this.",
	SEX_REWARD_LINE16 = "I was just thinking about you, and got all excited...",
	SEX_REWARD_LINE17 = "Great, but you better let me take care of you after...",
	SEX_REWARD_LINE18 = "You're the best! I really wanted help with this...",
	SEX_REWARD_LINE19 = "M-me? Really? Okay...",
	SEX_REWARD_LINE20 = "I-I didn't want anyone to notice...",
	SEX_REWARD_LINE21 = "P-please don't tell anyone...",
	SEX_REWARD_LINE22 = "Haaaa... I can't resist you...",
	SEX_REWARD_LINE23 = "O-oh... D-do I have to beg?",
	
	LOYALTY_LINE1 = "I... could I pledge my loyalty to [Master]? For all good you've done to me...",
	LOYALTY_LINE2 = "My body and soul both belong to you, [Master].",
	LOYALTY_LINE3 = "[Master]...? P-please, let me stay by your side... ",
	LOYALTY_LINE4 = "What's this feeling... I want to stay with [Master]? ",
	LOYALTY_LINE5 = "Don't get any funny ideas. I just like it here is all!",
	LOYALTY_LINE6 = "You're not so bad after all, [Master]!",
	LOYALTY_LINE7 = "Ha! Guess I need you just as much as you need me.",
	LOYALTY_LINE8 = "I guess following your orders isn't so bad after all!",
	LOYALTY_LINE9 = "You must have done something to me! There's no way I should like you this much.",
	LOYALTY_LINE10 = "A worthy [Master] to serve. It's a pleasure.",
	LOYALTY_LINE11 = "It would seem I've grown fond of you, [Master].",
	LOYALTY_LINE12 = "I knew this day was to come. I can't find any reason to leave.",
	LOYALTY_LINE13 = "I wish to continue serving you, [Master]. Indefinitely.",
	LOYALTY_LINE14 = "My mind is filled with nothing but thoughts of serving you. A strange feeling indeed.",
	LOYALTY_LINE15 = "I just knew I would love it here, [Master]!",
	LOYALTY_LINE16 = "Please don't let this be a dream. I really like you, [Master]!",
	LOYALTY_LINE17 = "I get to stay with [Master], and serve them!",
	LOYALTY_LINE18 = "I'm so glad I can serve you, [Master]!",
	LOYALTY_LINE19 = "No way... Could it be that I've fallen for you, [Master]?",
	LOYALTY_LINE20 = "Please don't ever make me leave... I really want to stay here, [Master]...",
	LOYALTY_LINE21 = "I-I want to do the best I can to serve [Master]...",
	LOYALTY_LINE22 = "O-oh... I just feel so safe around you, [Master]...",
	LOYALTY_LINE23 = "Hmm? Why do I feel so... compelled to serve [Master]?",
	LOYALTY_LINE24 = "Ahh... I j-just want to say that I'm here for you, [Master]",
	
	SUBMISSION_LINE1 = "I yield, [Master]. Please, I'll do anything...",
	SUBMISSION_LINE2 = "N-no, please, no more punishments... *sob*",
	SUBMISSION_LINE3 = "I give up... You win... [Master]...",
	SUBMISSION_LINE4 = "Damn it... Fine... I'll obey you, [Master].",
	SUBMISSION_LINE5 = "Okay! no more! I'll be good.",
	SUBMISSION_LINE6 = "I don't have enough strength to defy you anymore... [Master]",
	SUBMISSION_LINE7 = "So this is my life now huh?",
	SUBMISSION_LINE8 = "You've won. I can't fight you anymore, [Master].",
	SUBMISSION_LINE9 = "Such vulgar discipline. Though I can't fight it any longer...",
	SUBMISSION_LINE10 = "As you wish. I won't challenge your words any longer, [Master].",
	SUBMISSION_LINE11 = "There's not an ounce of strength left in me. I submit.",
	SUBMISSION_LINE12 = "You have broken my will, along with my body, [Master]. I yield.",
	SUBMISSION_LINE13 = "To think I once thought I would have a much brighter future...",
	SUBMISSION_LINE14 = "Though you treated me poorly... I will serve you as always, [Master]",
	SUBMISSION_LINE15 = "I simply wished to serve you, but... not like this...",
	SUBMISSION_LINE16 = "Deep down I know you're a nice person, [Master]...",
	SUBMISSION_LINE17 = "I can't bare this torture any longer. I'll do anything you want, [Master]",
	SUBMISSION_LINE18 = "I'll do my best... to stay on your good side, [Master]...",
	SUBMISSION_LINE19 = "I-I guess this is all someone like me could ever hope for.",
	SUBMISSION_LINE20 = "If only I were better... Maybe It wouldn't be like this.",
	SUBMISSION_LINE21 = "M-maybe this is better? Just to follow my [Master]'s orders...",
	SUBMISSION_LINE22 = "O-oh... I guess this is better than nothing...",
	SUBMISSION_LINE23 = "O-odly enough. This is... comforting? ",
	
	LOYALTY_SUBMISSION_LINE1 = "[Master]... I understand, I will do as you want.",
	LOYALTY_SUBMISSION_LINE2 = "This feels crazy, but I'm ready to do anything for you.",
	LOYALTY_SUBMISSION_LINE3 = "...I-I understand, I will do everything for you.",
	LOYALTY_SUBMISSION_LINE4 = "I understand, [Master]... I just hope I can be of use to you...",
	LOYALTY_SUBMISSION_LINE5 = "I-I will devote everything to you, [Master]...",
	LOYALTY_SUBMISSION_LINE6 = "I-I'll do anything you ask, [Master]... Honest!",
	LOYALTY_SUBMISSION_LINE7 = "M-my new life with [Master] begins today...",
	LOYALTY_SUBMISSION_LINE8 = "This is all I could have ever hoped for...",
	LOYALTY_SUBMISSION_LINE9 = "I just want to do everything for you, [Master]!",
	LOYALTY_SUBMISSION_LINE10 = "[Master] is the greatest! I never ever want to leave.",
	LOYALTY_SUBMISSION_LINE11 = "I truly wish to be nothing but the best for you, [Master]",
	LOYALTY_SUBMISSION_LINE12 = "I can't see myself anywhere else, but at [Master]'s side.",
	LOYALTY_SUBMISSION_LINE13 = "If only others could see how truly wonderful you are, [Master].",
	LOYALTY_SUBMISSION_LINE14 = "I pledge my eternal loyalty to you, [Master].",
	LOYALTY_SUBMISSION_LINE15 = "You needn't ask, [Master]. Your will shall be done.",
	LOYALTY_SUBMISSION_LINE16 = "I knew I made the right choice in coming here.",
	LOYALTY_SUBMISSION_LINE17 = "A true [Master] know when to use charm as well as an iron fist.",
	LOYALTY_SUBMISSION_LINE18 = "Will that be all? You can always count on me to do your bidding.",
	LOYALTY_SUBMISSION_LINE19 = "Yeah! I'll do anything you say!",
	LOYALTY_SUBMISSION_LINE20 = "I knew you would want to keep me around [Master]!",
	LOYALTY_SUBMISSION_LINE21 = "Leave it to me, [Master]! I won't let you down.",
	LOYALTY_SUBMISSION_LINE22 = "Surprisingly enough... I'm okay with you being my [Master].",
	LOYALTY_SUBMISSION_LINE23 = "Gah! Fine! I'll do anything you want, [Master].",
	
	WRIT_SUCCESS1 = "...This is very kind of you, [Master], but please allow me to stay by your side.",
	WRIT_SUCCESS2 = "Wow, are you serious about this? But I can't leave you alone, can I. ",
	WRIT_SUCCESS3 = "I appreciate this gesture, but my place is at your side, [Master]. ",
	WRIT_SUCCESS4 = "I... I don't think I can make it out on my own... Please let me stay, [Master]...",
	WRIT_SUCCESS5 = "C-can I stay here? Please...?",
	WRIT_SUCCESS6 = "R-really? Me? are you sure? I just want to be with you...",
	WRIT_SUCCESS7 = "I-I can't see myself anywhere except by your side, [Master]...",
	WRIT_SUCCESS8 = "Please... Let me stay here with you...",
	WRIT_SUCCESS9 = "Freedom means nothing if I can't be with you, [Master].",
	WRIT_SUCCESS10 = "So nice of you to do this for me, but... I want to stay.",
	WRIT_SUCCESS11 = "That's so nice of you, but I want to stay here.",
	WRIT_SUCCESS12 = "I like it here, [Master]. I don't want to leave your side.",
	WRIT_SUCCESS13 = "Your heart is in the right place, and so am I. I'll stay here with you.",
	WRIT_SUCCESS14 = "Thank you, [Master], but my place is here with you.",
	WRIT_SUCCESS15 = "Freedom? What makes you think my being here isn't enjoyed?",
	WRIT_SUCCESS16 = "I see... Never the less. I belong here.",
	WRIT_SUCCESS17 = "Fate brought us together, and though you grant me freedom. My place is here.",
	WRIT_SUCCESS18 = "My staying here would benefit us both, no?",
	WRIT_SUCCESS19 = "No way! I'm staying right here!",
	WRIT_SUCCESS20 = "Setting me free? Not going to happen. you need me!",
	WRIT_SUCCESS21 = "What!? Freeing me? What's the big idea!? I'm staying put!",
	WRIT_SUCCESS22 = "Just don't think I owe you anything, but I'll stay with you",
	WRIT_SUCCESS23 = "If this is some sort of trick... I'm keeping a close eye on you...",
	
	WRIT_FAIL1 = "I... Thank you, but I must go.",
	WRIT_FAIL2 = "Thanks, I guess... I must go now.",
	WRIT_FAIL3 = "This is unexpected... You have my gratitude, but I'm afraid, it won't include my service.",
	WRIT_FAIL4 = "...I'm sorry. ",
	WRIT_FAIL5 = "Though I do appreciate what you've done for me.. I must part ways.",
	WRIT_FAIL6 = "Thank you. Do take care of yourself.",
	WRIT_FAIL7 = "I see. Perhaps we will meet again...",
	WRIT_FAIL8 = "I owe you a great debt. One that I can't repay with my service.",
	WRIT_FAIL9 = "I'm overjoyed, but... this isn't where I belong.",
	WRIT_FAIL10 = "Thanks, but I've got better places to be.",
	WRIT_FAIL11 = "Freeing me are you? Guess you're not too bad after all. See you later.",
	WRIT_FAIL12 = "Oh? Don't think for a second That I'm staying here with you.",
	WRIT_FAIL13 = "Yeah yeah... Thanks, but I'm gone.",
	WRIT_FAIL14 = "Ha! Guess I'm finally free from all this!",
	WRIT_FAIL15 = "T-thank you, but my family must be really worried. I have to go...",
	WRIT_FAIL16 = "I-I'm sorry... you've been so nice, but I have to go.",
	WRIT_FAIL17 = "D-don't take it personally... I'm just not ready to stay here.",
	WRIT_FAIL18 = "Oh... So I can go then? Thank you...",
	WRIT_FAIL19 = "Phew... I guess I can finally leave...",
	WRIT_FAIL20 = "Thank you so much for this! I'll pay you back someday!",
	WRIT_FAIL21 = "Such a kind heart, but I can't stay.",
	WRIT_FAIL22 = "I'm so greatful! I'll miss you greatly!",
	WRIT_FAIL23 = "How wonderful! Please understand that I have to leave your side...",
	WRIT_FAIL24 = "Ahh! I'm so happy! I'll be sure to write you once in awhile!",
	
	RECRUIT_SUCCESS5 = "I-if you would have me...." ,
	RECRUIT_SUCCESS6 = "R-really? Me? are you sure? Okay...",
	RECRUIT_SUCCESS7 = "I don't know how much help I'll be, but... I'll join you.",
	RECRUIT_SUCCESS8 = "M-maybe... this is for the best?",
	RECRUIT_SUCCESS9 = "You want me to join you? I would be delighted!",
	RECRUIT_SUCCESS10 = "I only hope to serve you well.",
	RECRUIT_SUCCESS11 = "Guess it's my turn to help you now, [Master]!",
	RECRUIT_SUCCESS12 = "I'll pack my things as soon as possible.",
	RECRUIT_SUCCESS13 = "Oh! I'm so excited to see my new home!",
	RECRUIT_SUCCESS14 = "I suppose this should prove advantageous for the both of us.",
	RECRUIT_SUCCESS15 = "I can't see a reason to decline.",
	RECRUIT_SUCCESS16 = "Let us part this place together, [Master].",
	RECRUIT_SUCCESS17 = "Seems that fate has brought us together for a reason.",
	RECRUIT_SUCCESS18 = "Might as well join forces. Would benefit us both, no?",
	RECRUIT_SUCCESS19 = "Fine, but only because you seem strong enough.",
	RECRUIT_SUCCESS20 = "Saw the potential in me did you? let's go.",
	RECRUIT_SUCCESS21 = "I hope you exceed my expectations.",
	RECRUIT_SUCCESS22 = "Just don't think I owe you anything, but I'll join you.",
	RECRUIT_SUCCESS23 = "Ha! I knew you would need someone like me!",
	
	RECRUIT_FAIL5 = "Though I do appreciate the offer. I must respectfully decline... Do take care of yourself.",
	RECRUIT_FAIL6 = "I don't think I'm quite ready to make such a commitment.",
	RECRUIT_FAIL7 = "Sorry. I don't think I can join you at this time.",
	RECRUIT_FAIL8 = "Perhaps you should seek aid elsewhere?",
	RECRUIT_FAIL9 = "Apologies. I can't join your cause.",
	RECRUIT_FAIL10 = "What? No way! why would I ever join you?",
	RECRUIT_FAIL11 = "There's no way I'd join someone on a whim.",
	RECRUIT_FAIL12 = "Oh please... Like I would leave my home behind for you.",
	RECRUIT_FAIL13 = "Don't even think about it. I'm leaving.",
	RECRUIT_FAIL14 = "Thanks, but no thanks. I'm fine on my own.",
	RECRUIT_FAIL15 = "Uhm... I'm sorry... I just can't.",
	RECRUIT_FAIL16 = "I-I don't really trust you... sorry...",
	RECRUIT_FAIL17 = "D-don't take it personally... I'm just not ready for this...",
	RECRUIT_FAIL18 = "Y-you can find someone better. I know it...",
	RECRUIT_FAIL19 = "P-please. I don't want to go with you...",
	RECRUIT_FAIL20 = "You seem really nice, but I just can't. Sorry.",
	RECRUIT_FAIL21 = "There's too much I have to do. Please understand.",
	RECRUIT_FAIL22 = "A tempting offer, but I just can't.",
	RECRUIT_FAIL23 = "I wish you luck on your travels, but I can't come with you.",
	RECRUIT_FAIL24 = "Maybe if we meet again, but not right now.",
	
	APHRODISIAC1 = "Ah... What's going on... It feels so hot...",
	APHRODISIAC2 = "My body... is getting hotter...",
	APHRODISIAC3 = "AAhhh... What is this... Feeling...",
	APHRODISIAC4 = "Hnnn... you better take responsibility for this...",
	APHRODISIAC5 = "How dare you do this to me... But hey. Feels kinda nice.",
	APHRODISIAC6 = "Ugh. My whole body is burning up!",
	APHRODISIAC7 = "Gah! I really need to take care of this.",
	APHRODISIAC8 = "I can't control myself. What did you do to me?",
	APHRODISIAC9 = "Ahh... It would seem I crave a bit of relief...",
	APHRODISIAC10 = "Such an odd concoction...",
	APHRODISIAC11 = "Perhaps this feeling of lust isn't so bad...",
	APHRODISIAC12 = "Trying to get me in a mood hmm? It's working.",
	APHRODISIAC13 = "My mind is swarmed with thoughts of pleasure...",
	APHRODISIAC14 = "M-my body's getting warmer.",
	APHRODISIAC15 = "O-oh no... I can't stop myself from...",
	APHRODISIAC16 = "It feels so good... please don't let it end...",
	APHRODISIAC17 = "S-so hard to resist...",
	APHRODISIAC18 = "W-why have you done this to me...?",
	APHRODISIAC19 = "In a mood are we? So am I.",
	APHRODISIAC20 = "Ahh... you know just what to do.",
	APHRODISIAC21 = "Are we about to have some fun?",
	APHRODISIAC22 = "Does this mean I can please you?",
	APHRODISIAC23 = "I'm getting so excited!",
	
	LOCKPICK_SUCCESS1 = "I did it, [Master]. Let's see what's inside.",
	LOCKPICK_SUCCESS2 = "Hmph, piece of cake.",
	LOCKPICK_SUCCESS3 = "I-I did it.",
	LOCKPICK_SUCCESS4 = "It's done.",
	LOCKPICK_SUCCESS5 = "This lock is no match for me.",
	LOCKPICK_SUCCESS6 = "Is it... Okay to do this? It's open...",
	LOCKPICK_SUCCESS7 = "O-oh! I actually did it!",
	LOCKPICK_SUCCESS8 = "W-wow... I wonder what's inside?",
	LOCKPICK_SUCCESS9 = "Ahh! Oh? I actually got it open?",
	LOCKPICK_SUCCESS10 = "I-I can't believe I actually did it...",
	LOCKPICK_SUCCESS11 = "I did it! Now we can get what's inside.",
	LOCKPICK_SUCCESS12 = "I sure hope no one misses this...",
	LOCKPICK_SUCCESS13 = "We can use this treasure to make everyone happy!",
	LOCKPICK_SUCCESS14 = "Looks like I have a great teacher!",
	LOCKPICK_SUCCESS15 = "If only it was always this easy.",
	LOCKPICK_SUCCESS16 = "A trivial matter for the likes of me.",
	LOCKPICK_SUCCESS17 = "A twist, and turn, and there you have it.",
	LOCKPICK_SUCCESS18 = "Hmm? Was that all this lock could muster?",
	LOCKPICK_SUCCESS19 = "It would seem I have gotten better at this.",
	LOCKPICK_SUCCESS20 = "The treasure is ours to claim.",
	LOCKPICK_SUCCESS21 = "No lock can beat me!",
	LOCKPICK_SUCCESS22 = "This loot better be worth it.",
	LOCKPICK_SUCCESS23 = "Ugh. Really? That was too easy!",
	LOCKPICK_SUCCESS24 = "We could have just smashed it you know, but I got it.",
	LOCKPICK_SUCCESS25 = "This is why you need someone like me!",
	
	LOCKPICK_FAILURE1 = "Oh, uh... I'm sorry.",
	LOCKPICK_FAILURE2 = "T-this can't be my fault.",
	LOCKPICK_FAILURE3 = "I'm sorry!",
	LOCKPICK_FAILURE4 = "...This can't be helped.",
	LOCKPICK_FAILURE5 = "This stupid lock... I'll get it next time",
	LOCKPICK_FAILURE6 = "Stupid lock! I can't get it open!",
	LOCKPICK_FAILURE7 = "It broke my pick!",
	LOCKPICK_FAILURE8 = "Whatever! I bet the treasure wasn't even worth it.",
	LOCKPICK_FAILURE9 = "I failed!? No way!",
	LOCKPICK_FAILURE10 = "Gah! It's too hard for me!",
	LOCKPICK_FAILURE11 = "It would seem I have failed.",
	LOCKPICK_FAILURE12 = "The lock is too complex for the likes of me.",
	LOCKPICK_FAILURE13 = "A shame. I wanted to see what was inside.",
	LOCKPICK_FAILURE14 = "Perhaps this is outside of my talents?",
	LOCKPICK_FAILURE15 = "I can't get it to open.",
	LOCKPICK_FAILURE16 = "I'm sorry. This is too hard.",
	LOCKPICK_FAILURE17 = "Oh no. My pick broke.",
	LOCKPICK_FAILURE18 = "Darn. I thought I had it too...",
	LOCKPICK_FAILURE19 = "Aww... I bet it was something good too...",
	LOCKPICK_FAILURE20 = "I'll get it next time!",
	LOCKPICK_FAILURE21 = "I-I knew I couldn't do it...",
	LOCKPICK_FAILURE22 = "S-sorry. It's too hard...",
	LOCKPICK_FAILURE23 = "O-oh. I guess I'm not good enough...",
	LOCKPICK_FAILURE24 = "P-please forgive me. I failed...",
	LOCKPICK_FAILURE25 = "T-this is too much... I can't handle it.",
	
	GREETING_LINE_POSITIVE1 = "[Master] would like to spend time {^together:with me}...?",
	GREETING_LINE_POSITIVE2 = "It's my pleasure to accompany you, [Master].",
	GREETING_LINE_POSITIVE3 = "Let's have some fun together, [Master]!",
	
	GREETING_LINE_CAUTIOUS1 = "Yes, [Master], what do you want me for?",
	GREETING_LINE_CAUTIOUS2 = "I still have a work today, can we get over it quickly?",
	GREETING_LINE_CAUTIOUS3 = "What do you want of me? *grumble*",
	GREETING_LINE_CAUTIOUS4 = "Y-yes, [Master]. What can I do for you?",
	
	PUNISH_LINE_LIGHT1 = "Ouch! It hurts!",
	PUNISH_LINE_LIGHT2 = "What was that for!?",
	PUNISH_LINE_LIGHT3 = "Ugh!... You...",
	PUNISH_LINE_LIGHT4 = "No! Stop...",
	
	PUNISH_LINE_HEAVY1 = "Ouch! Please stop!",
	
	PUBLIC_LINE1 = "N-no way, please don't do this in front of everyone...",
	PUBLIC_LINE2 = "Wha... Why you brought everyone here!?",
	PUBLIC_LINE3 = "This... is going to be humiliating.",
	PUBLIC_LINE4 = "Are you trying to scare me like this? See if I care.",
	PUBLIC_LINE5 = "P-please, [Master], I don't like being watched.",
	PUBLIC_LINE6 = "W-why everyone is here? I don't...",
	PUBLIC_LINE7 = "N-no... No! please...",
	
	PUBLIC_OBSERVE_LINE1 = "[Master] is going to punish you, [2name]...?",
	PUBLIC_OBSERVE_LINE2 = "Hmph, serves you right.",
	PUBLIC_OBSERVE_LINE3 = "Looks like [2name] is being punished. At least I get a break from work.",
	PUBLIC_OBSERVE_LINE4 = "Please accept this with dignity.",
	PUBLIC_OBSERVE_LINE5 = "......",
	PUBLIC_OBSERVE_LINE6 = "If [he] dies, I call dibs on [his] stuff.", 
	PUBLIC_OBSERVE_LINE7 = "Looks like you will be getting a good lesson, [2name]. ",
	
	MARRY_PROPOSE_AGREE1 = "A-are you serious?.. I can't believe it, of course i will, [Master]!",
	MARRY_PROPOSE_AGREE2 = "Wa... You are not kidding, right? I agree!",
	MARRY_PROPOSE_AGREE3 = "Y-Yes, of course I agree!",
	
	MARRY_PROPOSAL_AGREED_BEFORE1 = "Didn't I already gave my agreement..?", 
	MARRY_PROPOSAL_AGREED_BEFORE2 = "Y-yes, we have discussed it and I agreed...",
	
	MARRY_PROPOSE_REFUSE1 = "T-that's... really sudden... I'm sorry, I can't agree to this.",
	MARRY_PROPOSE_REFUSE2 = "Y-You what? No way. Don't joke like that, [Master]",
	MARRY_PROPOSE_REFUSE3 = "I'm sorry, I can't agree to this!",
	
	DATE_PROPOSE_AGREE1 = "I-I would like to get closer with you, [Master]. ",
	DATE_PROPOSE_AGREE2 = "Well, your charm worked this time on me. ",
	DATE_PROPOSE_AGREE3 = "Okay, why not be naughty?",
	DATE_PROPOSE_AGREE4 = "This is to help our bodily needs, correct?",
	DATE_PROPOSE_AGREE5 = "W-well, if you don't mind someone like me...",
	DATE_PROPOSE_AGREE6 = "It's a pleasure you feel the same way.",
	
	DATE_PROPOSE_REFUSE1 = "Sorry, I don't feel about you in same way.",
	DATE_PROPOSE_REFUSE2 = "P-please, maybe some other time...",
	DATE_PROPOSE_REFUSE3 = "I'd rather not.",
	DATE_PROPOSE_REFUSE4 = "Uh, no. This is awkward.",
	DATE_PROPOSE_REFUSE5 = "I'm sure there's someone better than me.",
	
	DATE_PROPOSE_HAD_SEX1 = "Don't be silly, didn't we do it already?",
	DATE_PROPOSE_HAD_SEX2 = "Sure, if you want me to confirm it officially...",
	DATE_PROPOSE_HAD_SEX3 = "...But didn't we already do that?",
	
	DATE_PROPOSE_WAS_FORCED1 = "You didn't really give me much of a choice last time, why bother now?",
	DATE_PROPOSE_WAS_FORCED2 = "Why didn't you ask me before? What's the point now...",
	DATE_PROPOSE_WAS_FORCED3 = "Do as you wish. You've already did, though. ",
	DATE_PROPOSE_WAS_FORCED4 = "Just getting this out of the way now? Fine. ",
	
	DATE_SEX_OFFER1 = "...[Master]? I'd like to continue this affair.",
	DATE_SEX_OFFER2 = "Uhm, [Master], we could do, you know, lewd stuff... If you don't mind.",
	DATE_SEX_OFFER3 = "Hey, you are not going to leave me just now?",
	DATE_SEX_OFFER4 = "Hey, would you mind keeping me company for little longer?",
	DATE_SEX_OFFER5 = "My body feels like... It could use some more attention.",
	DATE_SEX_OFFER6 = "Uhm, can we continue this? I don't want to leave you. ",
	
	DATE_AFFECTION1 = "This... Feels nice.",
	DATE_AFFECTION2 = "I might get used to it.",
	DATE_AFFECTION3 = "You will spoil me like this, [Master].",
	DATE_AFFECTION4 = "Please, I didn't... Deserve it... [Master].",
	DATE_AFFECTION5 = "You are being too nice to me.",
	DATE_AFFECTION6 = "I don't mind you praising me some more.",
	DATE_AFFECTION7 = "Your affection is appreciated, [Master].",
	
	DATE_SCOLD1 = "I'm sorry [Master]. ",
	DATE_SCOLD2 = "You don't have to yell at me. ",
	DATE_SCOLD3 = "I'm sorry, please don't be angry. ",
	DATE_SCOLD4 = "Stop, I didn't deserve this! ",
	DATE_SCOLD5 = "I'm sorry you feel this way.",
	
	MIMIC_EAT1 = "Oh no! It's alive!",
	MIMIC_EAT2 = "Noo! It's got me! Help!",
	MIMIC_EAT3 = "Ugh, I can't get out!",
	
	MIMIC_MOLEST1 = "Agh... It's touching me all over!",
	MIMIC_MOLEST2 = "What's the... Ah! Stop!",
	MIMIC_MOLEST3 = "N-no, stop! No there!",
	
	MIMIC_LEAVE1 = "N-no, stop! You can't leave me!",
	MIMIC_LEAVE2 = "Please, wait! Help me!",
	MIMIC_LEAVE3 = "No! *sob* Please, I beg...",
	MIMIC_LEAVE4 = "Wait, I don't wanna die!",
	
	MIMIC_EROTIC_LEAVE1 = "Y-you gonna leave me- Ah!.. Like this?",
	MIMIC_EROTIC_LEAVE2 = "No, I hate it! Please help!",
	MIMIC_EROTIC_LEAVE3 = "Noooo! This feels gross!",
	MIMIC_EROTIC_LEAVE4 = "Agh, why you don't help me?!",
	
	MIMIC_EROTIC_LEAVE5 = "Ooh! I starting to... Like this...",
	MIMIC_EROTIC_LEAVE6 = "Ah.. This... Is not too bad...",
	
	PRAISE_REJECT1 = "You think you can tame me like this!?",
	PRAISE_REJECT2 = "Please, stop this farce.",
	PRAISE_REJECT3 = "You've got to be kidding. ",
	
	DATE_START1 = "I'm glad to accompany you, [Master]. ",
	DATE_START2 = "What do you want me for, [Master]? ",
	DATE_START3 = "[Master], this... Makes me a bit nervous. ",
	DATE_START4 = "Me, together with [Master]... ",
	DATE_START5 = "So, what do we do now, [Master]?",
	DATE_START6 = "As long as I get a break from the work...",
	DATE_START7 = "Uhm... I'm sorry for not being a very good company for [Master].",
	DATE_START8 = "You called for me, [Master]?",
	DATE_START9 = "I'll accompany you to my best capability,",
	
	DATE_START_HAPPY1 = "Finally, I was thinking you'd never ask!",
	DATE_START_HAPPY2 = "Hey, how were you doing, [Master]?",
	DATE_START_HAPPY3 = "Hehe, want me to tell you how I spent my day?",
	DATE_START_HAPPY4 = "I'm glad to be together with you, [Master]. ",
	DATE_START_HAPPY5 = "I hope others won't get jealous of us...",
	DATE_START_HAPPY6 = "T-thank you for choosing me, [Master]!",
	DATE_START_HAPPY7 = "It is a pleasure to be with you, [Master].",
	DATE_START_HAPPY8 = "It's a pleasure to be in your company, [Master].",
	DATE_START_HAPPY9 = "It's a honor to be your chosen, [Master].",
	DATE_START_HAPPY10 = "It makes me happy you've called me, [Master].",
	DATE_START_HAPPY11 = "He-he, only you and me now, [Master].",
	
	DATE_START_ANGRY1 = "Don't think you can make me like you now!",
	DATE_START_ANGRY2 = "Hmph, you think you can talk your way out of what you've done to me?",
	DATE_START_ANGRY3 = "Just make it quick, you bastard.",
	DATE_START_ANGRY4 = "I don't want to do this.",
	DATE_START_ANGRY5 = "Please, just let me go on my own.",
	DATE_START_ANGRY6 = "You are a horrible person, I don't want to be here.",
	DATE_START_ANGRY7 = "Please, let me go!",
	DATE_START_ANGRY8 = "I'll do what you ask, j-just let me go...",
	DATE_START_ANGRY9 = "Why can't you let me be fre... *sob*",
	DATE_START_ANGRY10 = "Your efforts are futile.",
	DATE_START_ANGRY11 = "What's this? Are you trying to make me like you..?",
	DATE_START_ANGRY12 = "Do what you want, this will change nothing.",
	
	TREAT_FOOD_RESIST1 = "You trying to buy my disposition with something like that? Pathetic.",
	TREAT_FOOD_LIKE1 = "Wow, how did you know this is my favorite?",
	TREAT_FOOD_HATE1 = "Sorry, I can't stomach this.",
	TREAT_FOOD_NEUTRAL1 = "Thank you, [master], I'll accept this.",
}





