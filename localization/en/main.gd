extends Reference
var TranslationDict = {
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
	MATERIALMYTHRIL = "Mythril",
	MATERIALMYTHRILDESCRIPT = "A very rare and strong magic alloy. Produced by crafting.",
	MATERIALINK_BRANDING = "Ink: Branding",
	MATERIALINK_MAKEUP = "Ink: Permanent Makeup",
	MATERIALINK_LUST = "Ink: Passion",
	MATERIALINK_HP = "Ink: Nature",
	MATERIALINK_MP = "Ink: Spiritual",
	MATERIALINK_TRIBAL = "Ink: Power",
	MATERIALINK_BRANDINGDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. Initially implemented by graziers and tamers, branding was adopted by slavery societies to establish dominance over the conquered. Tattoos are not nearly as painful to apply but nethertheless just as degrading, featuring the name of the owner.\n\nApplied to: {color=yellow|Neck, Ass, Crotch}\n\nReduce Obedience drain by 25%.\nCan only be applied once.",
	MATERIALINK_MAKEUPDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. While makeup might not be enough to turn the Beast into the Beauty, its a favorable option for the lazy.\n\nApplied to: {color=yellow|Face}\n\nCharm: +10.",
	MATERIALINK_LUSTDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. An obscene crest causing the owner to grow lewder, even against their will...\n\nApplied to: {color=yellow|Crotch, Chest, Ass}\n\nLust Growth: +10%; +20% if applied to Crotch.",
	MATERIALINK_HPDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. An ancient being signatures which strengthening life force.\n\nApplied to: {color=yellow|Arms, Legs, Waist}\n\nHealth Regeneration: +20%.",
	MATERIALINK_MPDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. Energy to supply magic is generally scarce, but this unknown signia will resupply the bearer with some additional traces from the air.\n\nApplied to: {color=yellow|Arms, Legs, Waist}\n\nMana Regeneration: +10%.",
	MATERIALINK_TRIBALDESCRIPT = "A set of tools and ink allowing to apply a certain magical signature on the subject. The technique of this special ink has been salvaged from the clan of fierce warriors. \n\nApplied to: {color=yellow|Face, Chest, Arms, Legs}\n\nWhen applied to Face: +5 Health\nOtherwise: +3 Physics",
	
	TATTOOBRANDDESCRIPT = "A sign of your ownership. Reduce Obedience drain by 25%",
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
	ITEMTAIL_PLUGDESCRIPT = "A tail resembling a cat's, generally associated with beast kind, however it's responsibility is lacking, unless pulled...",
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
	ITEMALCOHOLDESCRIPT = "A simple strong beverage produced from various grains. \n\nImproves obedience and reduces submission when consumed normally. Improves horniness and sensitivity during sex interactions but can be rejected by a weaker body.",
	ITEMBEER = "Beer",
	ITEMBEERDESCRIPT = "A nectar of the gods. \n\nImproves obedience and reduces submission when consumed normally. Improves horniness and sensitivity during sex interactions.",
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
	ITEMWRIT_OF_EXEMPTIONDESCRIPT = "An official paper holding all the necessities to grant a person freedom from slavery. It has all the required seals and is only missing a name...",
	ITEMSTRONG_PHEROMONES = "Strong Pheromones",
	ITEMSTRONG_PHEROMONESDESCRIPT = "A popular drug used on bestial races. Inhaling causes a great surge of euphoria and lust in an individual, making them accept just about any treatment they usually would be too shy to consider. Ineffective for non-bestial species and often banned in affected communities. ",
	
	ITEMSENSITIVITY_POT = "Sensintivity Drug",
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
	SKILLATTACKDESCRIPT = "Attacks target with equipped weapon. ",
	SKILLRANGED_ATTACK = "Attack (ranged)",
	SKILLFIREBOLT = "Firebolt",
	SKILLFIREBOLTDESCRIPT = "Launches a fire spell at target. Deal %d Fire damage to all targets in same row.",
	SKILLWINDARROW = "Wind Arrow",
	SKILLWINDARROWDESCRIPT = "Imbues the arrow with Wind element and deal %d damage. Must have a bow equipped.",
	SKILLSLASH = "Slash",
	SKILLSLASHDESCRIPT = "Deals %d Weapon damage to all targets in nearby column. Must have a weapon equipped.",
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
	SKILLCOMMANDDESCRIPT = "Increase target's damage by 25% for 3 turns.",
	SKILLTRAP = "Trap",
	SKILLTRAPDESCRIPT = "Sets trap under enemy. After using Skill it will be stunned for 2 turns. Requires 1 Trap component.",
	SKILLWEAPON_REFINE = "Weapon Refine",
	SKILLWEAPON_REFINEDESCRIPT = "Buffs ally's ATK by 30% until end of combat.",
	SKILLACIDBOMB = "Acid Bomb",
	SKILLACIDBOMBDESCRIPT = "Throws Acid bomb at target, dealing high Earth magic damage and reducing target's armor by 40 for 4 turns. Requires 1 Unstable Concoction.",
	SKILLFIREBOMB = "Fire Bomb",
	SKILLFIREBOMBDESCRIPT = "Throws Fire bomb at target row, dealing high Fire magic damage and causing target to burn for 2 turns. Requires 1 Unstable Concoction.",
	SKILLDISTRACT = "Distract",
	SKILLDISTRACTDESCRIPT = "Reduces target's Hitrate and Evasion by 30 for 2 turns.",
	SKILLATTRACT = "Attract",
	SKILLATTRACTDESCRIPT = "Charms Target for 2 turns. Charm breaks if damage is taken",
	SKILLENTHRAL = "Enthrall",
	SKILLENTHRALDESCRIPT = "Stuns target and self for 3 turns or until either are damaged. Only works on humanoids.",
	SKILLFIRE_ATTACK = "Fire Attack",
	SKILLFIRE_ATTACKDESCRIPT = "Deal 120% physical Fire damage.",
	SKILLDRAGONMIGHT = "Dragon's Might",
	SKILLDRAGONMIGHTDESCRIPT = "Increases damage and DEF by 25% until end of battle. Only usable once in 2 days.",
	SKILLLESSER_HEAL = "Lesser Heal",
	SKILLLESSER_HEALDESCRIPT = "Heals target ally for a 120% of MATK.",
	SKILLFAIRY_HEAL = "Fairy Grace",
	SKILLFAIRY_HEALDESCRIPT = "Heals target ally for a 50% of their maximum health. Only usable once in a day.",
	SKILLENTANGLE = "Entangle",
	SKILLENTANGLEDESCRIPT = "Deals Earth spell damage and stuns target for 1 turn. Only usable twice in a day.",
	SKILLSERRATED_SHOT = "Serrated Shot",
	SKILLSERRATED_SHOTDESCRIPT = "Deals 100% physical weapon damage and causes target to bleed for 4 turns.",
	SKILLMASS_LESSER_HEAL = "Mass Lesser Heal",
	SKILLMASS_LESSER_HEALDESCRIPT = "Restores some health to all allies.",
	SKILLBLIZZARD = "Blizzard",
	SKILLBLIZZARDDESCRIPT = "Deals 70% water magic damage to all enemies. Reduces speed by 20. 50% chance to Freeze target for 2 turns.",
	SKILLBLESS = "Bless",
	SKILLBLESSDESCRIPT = "Increase ATK by 25% for 3 turns.",
	SKILLBLOOD_MAGIC = "Blood Magic",
	SKILLBLOOD_MAGICDESCRIPT = "Sacrifice 10% of your health to convert it into mana.",
	SKILLBLOOD_EXPLOSION = "Blood Explosion",
	SKILLBLOOD_EXPLOSIONDESCRIPT = "Sacrifice 20% of your health to deal 3x weapon type magic damage to all enemies. ",
	
	SKILLEARTH_ATK = "Earth Attack",
	SKILLEARTH_ATKDESCRIPT = "Deals Earth physical damage and has 30% chance to Stun target for 1 turn",
	SKILLWIND_ATK = "Wind Attack",
	SKILLWIND_ATKDESCRIPT = "Deals Air physical damage to two random targets.",
	SKILLWATER_ATK = "Water Attack",
	SKILLWATER_ATKDESCRIPT = "Deals Water physical damage and causes target to bleed for 2 turns.",
	SKILLHOLY_ATK = "Holy Attack",
	SKILLHOLY_ATKDESCRIPT = "Deals Holy physical damage and has 20% chance to Confuse target.",
	SKILLFIRE_CLEAVE = "Fire Cleave",
	SKILLFIRE_CLEAVEDESCRIPT = "Deals Fire physical damage to a row and has 20% chance to cause Burn for 2 turns.",
	SKILLEARTH_SHATTER = "Earth Shatter",
	SKILLEARTH_SHATTERDESCRIPT = "Deals Earth physical damage to all targets. Reduces evasion by 25 for 2 turns.",
	SKILLREVENGE = "Revenge",
	SKILLREVENGEDESCRIPT = "Deals high weapon damage based on health missing.",
	SKILLFIRE_BURST = "Fire Burst",
	SKILLFIRE_BURSTDESCRIPT = "Deals Fire magic damage to all targets. Reduces target's hit chance by 20 for 3 turns.",
	SKILLAIR_CUTTER = "Air Cutter",
	SKILLAIR_CUTTERDESCRIPT = "Deals Air physical damage to 3 random targets. 50% chance to cause target to bleed for 2 turns.",
	SKILLHOLY_LANCE = "Holy Lance",
	SKILLHOLY_LANCEDESCRIPT = "Hits 2 targets with Holy physical damage.",
	SKILLSWIPE = "Swipe",
	SKILLSWIPEDESCRIPT = "Deals Wind physical damage to 3 targets. 30% chance to reduce target's DEF by 20 for 2 turns.",
	SKILLARROWRAIN = "Arrow Rain",
	SKILLARROWRAINDESCRIPT = "Deals Water physical damage to a row. 30% chance to reduce target's MDEF by 20 for 2 turns.",
	SKILLEXPLOSIVEARR = "Explosive Arrow",
	SKILLEXPLOSIVEARRDESCRIPT = "Deals Fire physical damage to a target. Burns target for 2 turns.",
	SKILLSHADOWSTRIKE = "Shadow Strike",
	SKILLSHADOWSTRIKEDESCRIPT = "Deals Dark physical damage to a target. Reduces ATK by 20 for 2 turns.",
	SKILLFIREARR = "Fire Arrow",
	SKILLFIREARRDESCRIPT = "Deals Fire magic damage to a target. 50% chance to burn target for 2 turns.",
	SKILLLIGHTNING = "Lightning",
	SKILLLIGHTNINGDESCRIPT = "Deals Air magic damage to a target. Stuns target for 1 turn.",
	SKILLMINDBLAST = "Mind Blast",
	SKILLMINDBLASTDESCRIPT = "Deals Mind magic damage to a target.",
	SKILLPSYCHICBLAST = "Psychic Blast",
	SKILLPSYCHICBLASTDESCRIPT = "Deals Mind magic damage to a line.",
	SKILLRESURRECT = "Resurrect",
	SKILLRESURRECTDESCRIPT = "Resurrects target ally at 40% of maximum health.",
	SKILLDECAY = "Decay",
	SKILLDECAYDESCRIPT = "Deals Dark magic damage to all enemies.",
	SKILLOVERGROWTH = "Overgrowth",
	SKILLOVERGROWTHDESCRIPT = "Deals Earth magic damage to all enemies.",
	SKILLFIRST_AID = "First Aid",
	SKILLFIRST_AIDDESCRIPT = "Heals ally for 30% of maximum health.",
	
	SKILLENDURE = "Endure",
	SKILLENDUREDESCRIPT = "Increase all resistances by 20% for 2 turns.",
	SKILLMIRROR_IMAGE = "Mirror Image",
	SKILLMIRROR_IMAGEDESCRIPT = "Buff All Ally: 25% chance to avoid any Ability damage for 2 turns (except Mind). Replaces Energy Field.",
	SKILLENERGY_FIELD = "Energy Field",
	SKILLENERGY_FIELDDESCRIPT = "Buff All Ally: When taking damage, deals low Air damage to attacker based on Caster's MATK. Replaces Mirror Image.",
	SKILLPROTECTIVE_SHELL = "Protective Shell",
	SKILLPROTECTIVE_SHELLDESCRIPT = "Buff Ally Row: Reduce incoming damage by 35% for next 3 attacks.",
	SKILLHAMMERFALL = "Hammerfall",
	SKILLHAMMERFALLDESCRIPT = "Deals 1.5 Neutral damage to target, stuns target for 2 turns. ",
	SKILLPURGE = "Purge",
	SKILLPURGEDESCRIPT = "Remove all negative buffs from Ally target.",
	SKILLRIGHTEOUS_FIRE = "Righteous Fire",
	SKILLRIGHTEOUS_FIREDESCRIPT = "Deals 1.0 fire Spell damage to any enemy. Silences target for 2 turns",
	SKILLELEMENTAL_WEAKNESS = "Elemental Weakness",
	SKILLELEMENTAL_WEAKNESSDESCRIPT = "Target enemy receive -40 Fire, Air, Earth and Water resists for 3 turns.",
	SKILLELEMENTAL_PROTECTION = "Elemental Protection",
	SKILLELEMENTAL_PROTECTIONDECRIPT = "Buff Ally Row: +25 Fire, Air, Earth and Water resists for 3 turns.",
	SKILLTAUNT = "Taunt",
	SKILLTAUNTDESCRIPT = "Forces all enemies to focus on caster.",
	SKILLCAMOUFLAGE = "Camouflage",
	SKILLCAMOUFLAGEDESCRIPT = "Buff All Ally: +20 Evasion for 2 turns. ",
	SKILLREINCARNATE = "Reincarnate",
	SKILLREINCARNATEDESCRIPT = "Reinforce Spirit of an Ally. When HP reach zero, restore it to full.",
	SKILLHUNTERSMARK = "Hunters Mark",
	SKILLHUNTERSMARKDESCRIPT = "Target enemy takes 15% more damage for 3 turns.",
	SKILLBARD1 = "Hymn",
	SKILLBARD1DESCRIPT = "Buff Ally Row: Increase Hitrate, Evasion and Speed by 20 for 4 turns. Cancel other Song Effects.",
	SKILLBARD2 = "Soothe",
	SKILLBARD2DESCRIPT = "Buff Ally Row: Increase DEF and MDEF by 15, dispel 1 negative effect every turn. Lasts 4 turns. Cancel other Song Effects. ",
	SKILLBARD3 = "Warmarch",
	SKILLBARD3DESCRIPT = "Buff Ally Row: Increase ATK and MATK by 20% for 4 turns. Cancel other Song Effects. ",
	SKILLSPIRIT1 = "Spirit: Hare",
	SKILLSPIRIT1DESCRIPT = "Buff Ally Target: +30 speed, +25 evasion until end of combat. Cancel other Spirit Effects.",
	SKILLSPIRIT2 = "Spirit: Turtle",
	SKILLSPIRIT2DESCRIPT = "Buff Ally Target: -25% Skill Damage taken, -15% Spell Damage taken until end of combat. Cancel other Spirit Effects.",
	SKILLSPIRIT3 = "Spirit: Eagle",
	SKILLSPIRIT3DESCRIPT = "Buff Ally Target: +20% Skill Damage dealt, +30 Hitrate until end of combat. Cancel other Spirit Effects.",
	SKILLDEVOURSPIRIT = "Devour Spirit",
	SKILLDEVOURSPIRITDESCRIPT = "Debuff Enemy Target: When Target dies, restore 20% of max MP to Caster.",
	SKILLEARTHQUAKE = "Earthquake",
	SKILLEARTHQUAKEDESCRIPT = "Deals Earth Spell Damage to all enemies for 3 turns.",
	SKILLEARTHQUAKE_GLOB = "Earthquake",
	SKILLL_ORB = "Lightning Orb",
	SKILLL_ORBDESCRIPT = "Deals high Air Damage to enemy Target. If Target survives, jumps for another random enemy for half of the damage. ",
	
	SKILLMIMIC_ATTACK = "Sticky Grab",
	
	WORKTOOL = "Work Tool",
	WORKTOOLAXE = "Lumber Axe",
	WORKTOOLROD = "Fishing Tools",
	WORKTOOLPICKAXE = "Pickaxe",
	WORKTOOLHAMMER = "Hammer",
	WORKTOOLBOW = "Hunting Bow",
	WORKTOOLSICKLE = "Sickle",
	WORKTOOLHUNT_KNIFE = "Hunting Knife",
	
	
	CORRECTTOOLEQUIPPED = "Correct Tool equipped: its bonus will apply. ",
	
	
	TASKHUNTING = "Hunt",
	TASKHUNTINGDESCRIPT = "Track down native wildlife for related resources.",
	TASKFISHING = "Fishing",
	TASKFISHINGDESCRIPT = "Fishing in nearby waters for aquatic resources.",
	TASKWOODCUTTING = "Wood cutting",
	TASKWOODCUTTINGDESCRIPT = "Work in forests to gather wood materials.",
	TASKMINING = "Mining",
	TASKMININGDESCRIPT = "Use mines to gather rocks and metal.",
	TASKFARMING = "Farming",
	TASKFARMINGDESCRIPT = "Produce crops at your farm.",
	TASKPROSTITUTION = "Prostitution",
	TASKPROSTITUTIONDESCRIPT = "Earn some gold by selling your body.",
	TASKCOOKING = "Cooking",
	TASKCOOKINGDESCRIPT = "Craft food items. Must have chosen a recipe to cook. ",
	TASKTAILOR = "Tailor",
	TASKTAILORDESCRIPT = "Craft cloth and leather items and gear. Must have chosen the items to craft. ",
	TASKSMITH = "Smith",
	TASKSMITHDESCRIPT = "Craft forge and metal items and gear. Must have chosen the items to craft. ",
	TASKALCHEMY = "Alchemy",
	TASKALCHEMYDESCRIPT = "Craft alchemical potions and items. Must have chosen the items to craft. ",
	TASKBUILDING = "Upgrading",
	TASKBUILDINGDESCRIPT = "Work on the current upgrade. ",
	TASKTRAVEL = "Travel",
	TASKREST = "Rest",
	
	TASKMAINSTAT = "Main characteristic",
	
	
	JOBPROSTITUTEGOLDDESCRIPT = "Earn gold by prostitution.",
	JOBCOOKINGCRAFTDESCRIPT = "Cook food in kitchen.",
	JOBBUILDINGCRAFTDESCRIPT = "Work on the current upgrade.",
	JOBSMITHCRAFTDESCRIPT = "Craft item at the forge.",
	JOBTAILORCRAFTDESCRIPT = "Craft item in tailor workshop.",
	JOBALCHEMYCRAFTDESCRIPT = "Craft item in alchemy workshop.",
	
	
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
	
	SLAVECLASSDESCRIPT = "Slaves are considered to be property. Their life solely belongs to their master and in case of escape they are treated as criminals effectively negating their rights.\n\n[color=aqua]Slaves suffer 10% damage reduction, but their obedience drains 10% slower and they have higher consent on sexual interactions. Slaves have +10% bonus to Collection, Farming and Prostitution tasks, but -15% to Smith, Tailor and Alchemy. [/color]",
	SERVANTCLASSDESCRIPT = "Peons are generally purchased to be taken care of but otherwise have similar rights to others. Peons generally have the same rights of others, but are purchased to serve a Master. Many folks end up as peons as a way to pay their, or their family's debt, or otherwise gain a stable living condition. However, if they escape, peons can often continue their life with only minor penalties. Therefore, they gain no penalties or benefits compared to slaves. They also cannot be forced to participate in sexual activities.",

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
	STATOBEDIENCEDESCRIPT = "Obedience is required for a character to work for you. When at zero, the character might attempt an escape. Obedience is gained by using social skills and lost while performing tasks. ",
	STATLOYALTY = "Loyalty",
	STATLOYALTYDESCRIPT = "Loyalty is built with positive skills and behavior. Loyalty reduce Obedience Drain and improve some interactions. Loyalty can be built on dates.",
	STATSUBMISSION = "Submission",
	STATSUBMISSIONDESCRIPT = "Submission is built with punishing skills. It will decrease with time unless maxed out. Maxed out Submission will no longer require Obedience for work and stops escapes.",
	STATAUTHORITY = "Authority",
	STATAUTHORITYDESCRIPT = "Authority represents a character's respect for you. Authority is built by punishments and dates, and determines how quickly Loyalty is built. Low authority and obedience makes possible for character to attempt escape.",
	STATLUST = "Lust",
	STATLUSTDESCRIPT = "Lust increases with time and allows the use of specific skills. Lust can be a powerful control and resource tool when utilized correctly.",
	STATPRODUCTIVITY = "Productivity",
	STATPRODUCTIVITYDESCRIPT = "Affects all productive tasks. Total productivity applies to all occupations, while efficiency will boost specific tasks.",
	STATCONSENT = "Consent",
	STATCONSENTDESCRIPT = "Affects consent for actions during sex interactions. Each action has different consent based on traits, partners and other factors. This number represents only the unaltered value. Basic consent grows when having positive results, trying new actions and partners. Also slightly increased from discipline skills. ",
	
	STATLOYALTY_GAIN_MOD = "Loyalty Gain",
	STATLUSTTICK = "Lust Growth",
	
	STATMOD_BUILD = "Upgrading Task Efficiency",
	STATMOD_COLLECT = "Collection Task Efficiency",
	STATMOD_HUNT = "Hunt Task Efficiency",
	STATMOD_FISH = "Fish Task Efficiency",
	STATMOD_COOK = "Cook Task Efficiency",
	STATMOD_SMITH = "Smith Task Efficiency",
	STATMOD_TAILOR = "Tailor Task Efficiency",
	STATMOD_ALCHEMY = "Alchemy Task Efficiency",
	STATMOD_FARM = "Farm Task Efficiency",
	STATMOD_PROS = "Prostitution Task Efficiency",
	
	STATRESIST_NORMAL = "Normal Resist",
	STATRESIST_FIRE = "Fire Resist",
	STATRESIST_AIR = "Air Resist",
	STATRESIST_EARTH = "Earth Resist", 
	STATRESIST_WATER = "Water Resist",
	STATRESIST_LIGHT = "Light Resist",
	STATRESIST_DARK = "Dark Resist",
	STATRESIST_MIND = "Mind Resist",
	
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
	
	STATGROWTH_FACTORDESCRIPT = "Growth factor represents how easy it is for the character to acquire a new class. The higher it is, the less experience it will take to unlock a new class until the soft cap limit.",
	STATPHYSICS_FACTORDESCRIPT = "Physics factor represents physical potential of the character. It limits [color=aqua]Physical[/color] growth and influences melee combat.",
	STATMAGIC_FACTORDESCRIPT = "Magic factor represents character's magic affinity. The higher it is, the more mana you have and the stronger magic classes you can unlock. Also affects mana regeneration. ",
	STATTAME_FACTORDESCRIPT = "Tame factor represents how easy it is to befriend the character. The higher it is, the greater the Obedience gained from positive skills. ", 
	STATTIMID_FACTORDESCRIPT = "Timid factor represents how easily the character can be influenced by punishments and abuse. The higher it is, the greater the Obedience gained from negative skills. ",
	STATWITS_FACTORDESCRIPT = "Wits factor represents the character's mind potential. It limits [color=aqua]Wits[/color] growth.",
	STATCHARM_FACTORDESCRIPT = "Charm factor represents character's appeal potential. It limits [color=aqua]Charm[/color] growth. Master's charm also increases gold and reputation rewards from repeatable quests.",
	STATSEXUALS_FACTORDESCRIPT = "Sex factor represents character's sex development potential. It speeds sexual skills acquirement and occasionally boosts sexual options in events.",
	
	
	STATFOOD_LOVE = "Loved Food",
	STATFOOD_HATE = "Hated Food",
	STATFOOD_LOVEDESCRIPT = "When a favorite food is eaten, it gives a minor boost to Productivity for the next day. Food made of both loved and hated ingredients will be considered as neutral and give no bonus or penalty. ",
	STATFOOD_HATEDESCRIPT = "When hated food is eaten, it will reduce Obedience and lower Productivity for the next day. Food made of both loved and hated ingredients will be considered as neutral and give no bonus or penalty.",
	
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
	RACEDARKELFDESCRIPT = "A rare subspecies of elves propagated and trained for combat. Their bluish skin and rare eye colors make them very noticeable and force them to hide their bodies in clothes. Being adepts in both physical techniques and magic, they often happen to be trained assassins, combatants and sellswords. However, they are not able to breed with other species and having no real society they must desperately seek out each other for the purpose of procreation. Due to it, their sexual activity is the highest among all elves. ",
	RACEORCDESCRIPT = "Orcs are a semi-sapient race of brutes inhabiting many desert and badland regions. Orcs resemble large, greenish humanoids with strong bodies and bad tempers. Despite that, some orcs are rather capable of fitting into normal society to work as simple bodyguards and soldiers. \n\nCommonly orcs form tribes and aren't above killing each other or any stray groups they deem dangerous. They are also rather fond of forcefully using members of other races for sex but aren't capable of interbreeding with them. ",
	RACEGOBLINDESCRIPT = "Goblins are short humanoids often occupying caves and dungeons. Most goblins are outright hostile to all outsiders and prefer to stick to groups as their individual power is fairly low. A certain number of goblins have abandoned their initial groups and strive to live with other races. Sometimes they even become known adventurers, but more often they are used for crude work, since they are hardly remarkable at anything except for their libido. ",
	RACEKOBOLDDESCRIPT = "Kobolds are a short, lizard-like race distinctively related to dragons. They generally live underground or in forests and aren't very friendly to other races often seen as pests. Certain individuals have managed to find acceptance among other racial groups. ",
	RACEGNOMEDESCRIPT = "Gnomes are a rare species of short, intelligent humanoids. Their poor physical strength makes them rather poor workers or fighters. They possess some magical capabilities, a good amount of charisma and have aneasy time connecting with other races. Many gnomes find their place as traders or entertainers, but a good amount are pretty happy to serve in more lewd occupations... assuming they can find the demand. ",
	RACEDWARFDESCRIPT = "Dwarves are a short, stout humanoid race that prefer to live by a strict set of rules in an enclosed underground society. Dwarves are rather physically strong, can be quick to anger, and are rarely fit for magic tasks. ",
	RACEDRYADDESCRIPT = "Dryads are a rare species of forest humanoids possessing green skin and being covered in plant matter. They rarely engage in communication with other races and generally prefer to stick to their home. Despite that, they are quite capable of fighting and using magic.",
	RACEFAIRYDESCRIPT = "Fairies are curious children of the forests. Looking like half-sized humanoids with a pair of insect wings on their back, fairies possess little physical threat, but their natural magic affinity is incredibly high. Their magic nature even allows them to occasionally heal wounds.\n\n Thankfully they rarely use it aggressively, preferring to instead just have fun and be quick to flee. Despite their childish temper, fairies are very proactive or even omnivorous when it comes down to bodily pleasures not unlike their cave counterparts— Goblins.",
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
	SKILLPRAISEDESCRIPT = "Category: {color=green|Gracious}\nA basic tool for inspiring your workers. Improved by Charm. \nBasic Effects: \nObedience: 20",
	SKILLWARN = "Warn",
	SKILLWARNDESCRIPT = "Category: {color=red|Mean}\nA basic tool to instigate fear. Improved by Charm.\nBasic Effects: \nObedience: 30, Authority: 4",
	SKILLPUNISH = "Punish",
	SKILLPUNISHDESCRIPT = "Category: {color=red|Mean}\nPhysically punishes target. Improved by Physics.\nBasic Effects: \nObedience: 45, Authority: 10",
	SKILLREWARD = "Reward",
	SKILLREWARDDESCRIPT = "Category: {color=green|Gracious}\nBuying their respect might seem like an easy solution... as long as you have enough coin. Increases obedience greatly.",
	SKILLREWARDSEX = "Reward with sex",
	SKILLREWARDSEXDESCRIPT = "Category: {color=pink|Lewd}\nRelieves a character's lust to improve their behavior. Target must have at least 25 Lust. Improved by Sexual Proficiency.\nBasic Effects: \nObedience: 36.",
	SKILLSEDUCE = "Seduce",
	SKILLSEDUCEDESCRIPT = "Category: {color=pink|Lewd}\nImproves Obedienc and prevents escape attempts for 2 days. Improved by Charm. \nBasic Effects: \nObedience: 40, Consent: 8.",
	SKILLGREATSEDUCE = "Great Seduce",
	SKILLGREATSEDUCEDESCRIPT = "Category: {color=pink|Lewd}\nImproves Obedience, prevents escape attempts and increases Lust growth by 50% for 2 days. Improved by Charm. \nBasic Effects: \nObedience: 50, Consent: 15.",
	SKILLDRAIN = "Drain",
	SKILLDRAINDESCRIPT = "Restores some fatigue, mana and energy by draining it from target.",
	SKILLDRAIN_MANA = "Drain Mana",
	SKILLDRAIN_MANADESCRIPT = "Steal up to 35% of mana from target. ",
	SKILLCONSUME_SOUL = "Consume Soul",
	SKILLCONSUME_SOULDESCRIPT = "Kills target and receives their experience.",
	SKILLSERVE = "Serve",
	SKILLSERVEDESCRIPT = "Provide a care service for another person. Improves Obedience and reduce Obedience drain by 25% for 1 day. Requires 20 lust. Improved by Charm. \nBasic Effects: \nObedience: 30, Loyalty: 4. ",
	SKILLDISCIPLINE = "Discipline",
	SKILLDISCIPLINEDESCRIPT = "Boosts target's manual labor performance. ",
	SKILLSEDATE = "Sedate",
	SKILLSEDATEDESCRIPT = "Category: {color=green|Gracious}\nPuts target's mind at ease and makes them more cooperative. Improved by Wits.\nBasic Effects: \nObedience: 40.",
	SKILLFEAR = "Fear",
	SKILLFEARDESCRIPT = "Category: {color=red|Mean}\nStrikes fear into target's mind. Improved by Wits.\nBasic Effects: \nObedience: 65, Authority: 10.",
	SKILLINNERVATE = "Innervate",
	SKILLINNERVATEDESCRIPT = "Restores target's energy. Effect grows with Wits. ",
	SKILLSHACKLES = "Shackle",
	SKILLSHACKLESDESCRIPT = "Creates magic shackles around target. As long as they persist it will be impossible to escape. Shackles can be dispelled with time if target's magic resistance is high. ",
	SKILLGREATSHACKLES = "Great Shackle",
	SKILLGREATSHACKLESDESCRIPT = "Creates a stronger version of magical shackles which are far more difficult to break.",
	SKILLMINDCONTROL = "Mind Control",
	SKILLMINDCONTROLDESCRIPT = "Overwhelms target's mind forcing nearly complete submission.\nBasic Effects: \nAuthority: 150, Loyalty: 30, Consent: 100",
	SKILLSTOPMINDCONTROL = "Remove Mind Control",
	SKILLSTOPMINDCONTROLDESCRIPT = "Removes Mind Control from the target, giving them back their free will.",
	SKILLABUSE = "Abuse",
	SKILLABUSEDESCRIPT = "Category: {color=red|Mean}\nTake your anger out on someone else. Improves Caster's and Target's obedience at the cost of target's Loyalty. \nBasic Effects: \nObedience: 36, Authority: 8, Obedience (self): 40.",
	SKILLMASTER_LUST_SKILL = "Lust Relief",
	SKILLMASTER_LUST_SKILLDESCRIPT = "Uses up target's Lust to provide them with specific benefits. Target must have at least 50 Lust.",
	SKILLHARDWORK = "Hard Work",
	SKILLHARDWORKDESCRIPT = "Increases productivity by 50% for 1 day for all characters on the current location. ",
	SKILLPUBLICHUMILIATION = "Public Humiliation",
	SKILLPUBLICHUMILIATIONDESCRIPT = "Category: {color=red|Mean}\nSet up a public humiliation for selected target. Greatly improves target's behavior and slightly affects audience.\nBasic Effects: \nObedience: 40, Authority: 12, Obedience (public): 30.",
	SKILLPUBLICSEXHUMILIATION = "Public Sex Humiliation",
	SKILLPUBLICSEXHUMILIATIONDESCRIPT = "Category: {color=pink|Lewd}\nSet up a public sex humiliation for the selected target, increasing Submission and a bit of Lust for all observants. \nBasic Effects: \nObedience: 50, Authority: 6, Obedience (public): 24.",
	SKILLPUBLICEXECUTION = "Public Execution",
	SKILLPUBLICEXECUTIONDESCRIPT = "Category: {color=red|Mean}\nExecutes selected character. Greatly improves Obedience, and Authority, but reduces Loyalty for everyone present. \nBasic Effects: \nObedience (public): 96, Authority (public): 25.",
	SKILLALLURE = "Allure",
	SKILLALLUREDESCRIPT = "Category: {color=green|Gracious}\nEntices the target, increasing their Obedience and reducing Obedience drain by 20% for 2 days, improved by Charm.\nBasic Effects: \nObedience: 36.",
	SKILLSUPREMACY = "Supremacy",
	SKILLSUPREMACYDESCRIPT = "Category: {color=green|Gracious}\nOverwhelms target with awe and respect for caster. Greatly increases Authority.\nBasic Effects: \nObedience: 48, Authority: 75, Loyalty: 20.",
	SKILLINSPIRE = "Inspire",
	SKILLINSPIREDESCRIPT = "Buffs whole team, increasing damage, DEF and MDEF by 20% for 1 combat.",
	SKILLHIDE = "Hide",
	SKILLHIDEDESCRIPT = "Makes user untargetable. Has no effect when is only possible target. Must have no Heavy or Medium Armor pieces.",
	SKILLBARRIER = "Barrier",
	SKILLBARRIERDESCRIPT = "Provides a magical shield that absorbs 100 damage. Shield lasts for 3 turns.",
	SKILLASSASSINATE = "Assassinate",
	SKILLASSASSINATEDESCRIPT = "Assaults target for 400% damage. Must be hidden to execute. ",
	SKILLPROTECT = "Protect",
	SKILLPROTECTDESCRIPT = "Protects target from damage.",
	SKILLSHAREDTOY = "Shared Toy",
	SKILLSHAREDTOYDESCRIPT = "Category: {color=pink|Lewd}\nBecome everyone's pleasure and relief for a time. Improves everyone's obedience. Only usable once in 3 days. Improved by Sexual Proficiency. Requires 75 Lust.\nBasic Effects: \nObedience: 45",
	SKILLPERFORMANCE = "Performance",
	SKILLPERFORMANCEDESCRIPT = "Category: {color=green|Gracious}\nProvide a small rest and entertainment for your other servants. Improves with Charm.\nBasic Effects: \nObedience: 24, Loyalty: 5.",
	
	DIALOGUEMASTER_LUST_SKILLTEXT = "Before approaching [targetname] you should decide what's [targethis] accumulated Lust is going to be used for.\n\n1. Convert it into Experience\n2. Restore Health and Mana, Improve Authority and Obedience\n3. Improve Productivity by 20% for 3 days for 50 Lust\n4. Increase ATK and MATK by 15% for 2 days for 50 Lust.",
	
	DIALOGUEMASTER_LUST_EXPREPORT = "You use [targetname]'s lust to provide [targethim] with experience.",
	DIALOGUEMASTER_LUST_BUFFREPORT = "You use [targetname]'s lust to provide [targethim] with a productivity boost.",
	DIALOGUEMASTER_LUST_HPREPORT = "You use [targetname]'s lust to restore [targethis] Health and Mana.",
	DIALOGUEMASTER_LUST_OBEDREPORT = "You use [targetname]'s lust to restore [targethis] obedience.",
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
	DIALOGUEPURCHASEDUNGEONLOCATION = "You purchase a location for a new dungeon and mark it on your map.\n\nNew location at [areaname] unlocked: [locationname]— [locationtypename].",
	
	DIALOGUESHAREDTOYREPORT = "[name] takes on a duty to please your other servants with [his] body...\n\nBy the end of it, it seems even your meeker servants have been left satisfied.",
	DIALOGUEPERFORMANCEREPORT = "[name] sets a staged dance gathering everyone around to watch and relax. People seem to be quite pleased with [his] performance. ",
	
	DIALOGUEQUESTACCEPT = "You take a quest note from the board and put it into your pocket. Once you can meet its conditions, you can complete it from your Mansion. ",
	
	DIALOGUEPRAISEREPORT = "[name] has praised [targetname] for [targethis] efforts.\n\n{color=aqua|[targetname]}— {random_chat=0|master_praise}",
	DIALOGUEWARNREPORT = "[name] has given a serious warning to [targetname] making [targethim] more aware of [targethis] behavior.",
	DIALOGUESERVEREPORT = "[name] has approached [targetname] and provided [targethim] with [his] sincerest affection.",
	DIALOGUESEDUCEREPORT = "[name] has approached [targetname] and after a couple moments left [targethim] wondering. Despite visual calmness, [targetname] has clearly become enamoured by [him].",
	DIALOGUEGREATSEDUCEREPORT = "[name] has approached [targetname] and after a couple moments left [targethim] wondering. [targetHis] mind has been overtaken by strong desire, making him quite docile.",
	DIALOGUEALLUREREPORT = "[name] has given [targetname] a small private encouragement.",
	DIALOGUEABUSEREPORT = "[name] has pushed [targetname] into a corner and took out some of [his] anger on [targethim].\n\n{color=aqua|[targetname]}— {random_chat=0|abuse}",
	DIALOGUEREWARDREPORT = "[name] has provided [targetname] with a small amount of gold for [targethis] good behavior.",
	DIALOGUEREWARDSEXREPORT = "[name] has taken care of [targetname]'s needs as a reward for [targethis] good deeds.",
	DIALOGUEPUNISHREPORT = "[name] has taken [targetname] into a private torture room and gave [targethim] a good lesson of discipline [targethe] won't forget for a while. \n\n{color=aqua|[targetname]}— {random_chat=0|master_punish}",
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
	DIALOGUECONSUME_SOULREPORT = "[name] annihilates [targetname] and consumes [targethis] soul, learning form [targethis] experience. ",
	DIALOGUEMAKE_UNDEADREPORT = "With a lengthy ritual, [name] murders and reanimates [targetname] turning [targethim] into a tireless undead.",
	DIALOGUEALCOHOLREPORT = "[name] uses a bottle of liquor for relaxation.",
	DIALOGUEAPHRODISIACREPORT = "[name] consumes an aphrodisiac, feeling a potent surge of lust.",
	DIALOGUETAMEDRUGREPORT = "After consuming the drug, [name] seems to have become a lot more docile. ",
	DIALOGUERAGEDRUGREPORT = "After consuming the drug, [name] seems to become more brutish.",
	DIALOGUESEXDRGUREPORT = "After consuming the drug, [name]'s mind becomes fixated on lewd things...",
	DIALOGUEEXP_SCROLLREPORT = "[name] reads the scroll. New knowledge fill [his] mind...",
	
	DIALOGUEENSLAVETEXT = "You find an official, who is ready to help with your task. After payment you receive a paper of ownership over [name], who reacts quite disturbingly to it.\n\n{color=aqua|[name]}— {random_chat=0|enslave}",
	DIALOGUEHIRETEXT = "After signing the papers and parting with your money, [name] comes bowing before you.\n\n{color=aqua|[name]}— {random_chat=0|hire}",#\n\n— Pleased to meet you, [master], I am in your care.
	
	SKILLPET_LUST_SKILL = "Lust Serve",
	SKILLPET_LUST_SKILLDESCRIPT = "Utilizes personal Lust to provide target with a specific bonus. Requires at least 50 lust.",
	DIALOGUEPET_LUST_SKILLTEXT = "Before approaching [targetname] you should decide what [name]'s accumulated Lust is going to be used for.\n\n1. Restore full Obedience for 50 Lust\n2. Convert it into Experience\n3. Restore Health and Mana",
	
	TRAITMASTERDESCRIPT = "Social skills build targets Authority 50% faster. \nIsn't affected by Authority, Obedience, Loyalty and Submission. Will not resist work or attempt escapes. ",
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
	TRAITDIRECTORDESCRIPT = "Social skills build targets Authority 50% faster. ",
	TRAITVALKYRIE_SPEARDESCRIPT = "+10 Speed while equipped with Spear.",
	TRAITAUTOHIDE = "Conceal.",
	TRAITAUTOHIDEDESCRIPT = "Starts combat in Hide if no Heavy or Medium Armor is equipped.",
	
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
	PROFHEALER = "Healer",
	PROFHEALERDESCRIPT = "Support magic users specializing in tending to others and keep their body stronger than you usually would expect.",
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
	
	TRAITRENOWN = "Renown",
	TRAITRENOWNDESCRIPT = "Loyalty and Obedience from Gracious skills 50% more effective. ",
	
	SKILLWINDWALL = "Wind Wall",
	SKILLWINDWALLDESCRIPT = "Reduces ally line received ranged damage by 50% for 4 turns. ",
	SKILLTAKE_POSITION = "Take Position",
	SKILLTAKE_POSITIONDESCRIPT = "Increases armor penetration by 50, damage by 20% for 2 turns. Instant.",
	
	NEXTCLASSEXP = "Experience required for next class.",
	
	UPGRADEPREVBONUS = "Previous bonus: ",
	UPGRADENEXTBONUS = "Upgrade bonus: ",
	
	UPGRADERESOURCE_GATHER_VEGES = "Farm: Vegetables",
	UPGRADERESOURCE_GATHER_VEGESDESCRIPT = "Farm task upgrade",
	UPGRADEFARMVEGEBONUS = "Allows gathering of Vegetables in mansion",
	UPGRADERESOURCE_GATHER_GRAINS = "Farm: Grains",
	UPGRADERESOURCE_GATHER_GRAINSDESCRIPT = "Farm task upgrade",
	UPGRADERESOURCE_GATHER_CLOTH = "Farm: Cloth",
	UPGRADERESOURCE_GATHER_CLOTHDESCRIPT = "Farm task upgrade",
	UPGRADERESOURCE_GATHER_WOODMAGIC = "Woodcutting: Magic Wood",
	UPGRADERESOURCE_GATHER_WOODMAGICDESCRIPT = "Woodcutting task upgrade",
	UPGRADERESOURCE_GATHER_WOODIRON = "Woodcutting: Iron Wood",
	UPGRADERESOURCE_GATHER_WOODIRONDESCRIPT = "Woodcutting task upgrade",
	UPGRADEFARMGRAINSBONUS = "Allows gathering of Grains at mansion",
	UPGRADETAILOR = "Tailor Workshop",
	UPGRADETAILORDESCRIPT = "Allows production of cloth and leather gear",
	UPGRADETAILORBONUS1 = "Unlocks crafting of: Leather Collar, Animal Ears, Animal Gloves, Maid Headband, Handcuffs, Worker Outfit, Base Cloth Armor.",
	UPGRADETAILORBONUS2 = "Unlocks crafting of: Magic Cloth, Maid Dress, Craftsman Suit, Lacy Underwear, Strapon, Chastity Belt, Anal Plug, Tail Plug, Anal Beads, Base Leather Armor.",
	UPGRADETAILORBONUS3 = "Unlocks crafting of: Ethereal Cloth, See-through Underwear, Stimulative Underwear, Pet Suit, Elegant Choker, Latex Suit.",
	UPGRADEFORGE = "Forge",
	UPGRADEFORGEDESCRIPT = "Allows production of metal parts and gear",
	UPGRADEFORGEBONUS1 = "Unlocks basic metal tools and weapon recipes. Unlocks Steel production.",
	UPGRADEFORGEBONUS2 = "Unlocks advanced metal tools and weapon recipes.",
	UPGRADEFORGEBONUS3 = "Not currently used for anything",
	
	UPGRADETORTURE_ROOM = "Torture Room",
	UPGRADETORTURE_ROOMDESCRIPT = "Adds torture options during Meeting activity.",
	UPGRADETORTUREROOMBONUS = "Unlocks advanced Punishments during Meeting activity including bringing others to watch.",
	
	UPGRADEALCHEMY = "Alchemy",
	UPGRADEALCHEMYDESCRIPT = "Allows production of potions and advanced resources",
	UPGRADEALCHEMYBONUS1 = "Unlocks basic alchemical and healing item recipes.",
	UPGRADEALCHEMYBONUS2 = "Unlocks advanced alchemical and healing item recipes. Unlocks recipes for Enchanted Wood and Adamantine.",
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
	UPGRADELUXURY_ROOMSDESCRIPT = "Increases maximum number of available Luxury Rooms. Luxury Rooms will reduce Obedience Drain to its residents. ",
	UPGRADELUXURY_ROOMSBONUS1 = "Increases maximum number of avilable Luxury Rooms to 2.",
	UPGRADELUXURY_ROOMSBONUS2 = "Increases maximum number of avilable Luxury Rooms to 3.",
	UPGRADELUXURY_ROOMSBONUS3 = "Increases maximum number of avilable Luxury Rooms to 4.",
	UPGRADELUXURY_ROOMSBONUS4 = "Increases maximum number of avilable Luxury Rooms to 5.",
	
	
	UPGRADEMASTERBEDROOMBONUS1 = 'Increases number of participants in sex interactions to 3',
	UPGRADEMASTERBEDROOMBONUS2 = 'Increases number of participants in sex interactions to 4',
	UPGRADEMASTERBEDROOMBONUS3 = 'Increases number of participants in sex interactions to 5',
	
	UPGRADESTABLES = "Stables",
	UPGRADESTABLESDESCRIPT = "Makes traveling faster",
	UPGRADESTABLESBONUS1 = "Increases character traveling speed by 20%",
	UPGRADESTABLESBONUS2 = "Increases character traveling speed by 40%",
	UPGRADESTABLESBONUS3 = "Increases character traveling speed by 60%",
	
	UPGRADEFORGEWORKSHOP = "Forge Tools",
	UPGRADEFORGEWORKSHOPDESCRIPT = "Improves the speed of Smithing and Upgrading tasks.",
	UPGRADEFORGEWORKBONUS1 = "Improves the speed by 25%",
	UPGRADEFORGEWORKBONUS2 = "Improves the speed by 50%",
	
	
	UPGRADEMINE_RESOURCE = "Mine: Resources",
	UPGRADEMINE_RESOURCEDESCRIPT = "Allows harvesting of additional resources from Mining",
	UPGRADEWOOD_RESOURCE = "Wood: Resources",
	UPGRADEWOOD_RESOURCEDESCRIPT = "Allows harvesting of additional resources from Wood Cutting",
	
	INTERACTIONSNOSEXTAG = "[name]'s personal story has not progressed to the point of allowing [him] to participate in these kinds of actions.",
	
	NOSEXDETAILSDESCRIPT = "{color=green|Unfortunately, you are unable to check on [his] private parts.}",
	
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
	
	
	BODYPARTANAL_VIRGINTRUEDESCRIPT = "[His] asshole has not been [color=yellow]claimed[/color] by anyone.",
	BODYPARTANAL_VIRGINFALSEDESCRIPT = "[His] asshole is trained enough for penetration.",
	
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
	
	
	BODYPARTHAIR_STYLESTRAIGHTDESCRIPT = "It [color=aqua]hangs freely[/color] from [his] head.",
	BODYPARTHAIR_STYLEPONYTAILDESCRIPT = "It is tied in a [color=aqua]high ponytail[/color].",
	BODYPARTHAIR_STYLEPIGTAILSDESCRIPT = "It is managed in girly [color=aqua]twin-tails[/color].",
	BODYPARTHAIR_STYLEBRAIDDESCRIPT = "It is combed into a single [color=aqua]braid[/color].",
	BODYPARTHAIR_STYLETWINBRAIDSDESCRIPT = "It is combed into [color=aqua]two braids[/color].",
	BODYPARTHAIR_STYLEBUNDESCRIPT = "It is tied into a neat [color=aqua]bun[/color].",
	
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
	SEXTRAITDISLIKE_TAILDESCRIPT = "[name] expresses dislike for certain lewd actions. [his] consent and the effect of received actions are lowered for [him]. ",
	
	
	
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
	
	DIALOGUECLOSE = "Close",
	DIALOGUECONFIRM = "Confirm",
	DIALOGUECONTINUE = "Continue",
	DIALOGUECANCEL = "Cancel",
	
	DIALOGUECHILDBIRTHTEXT = "[name] has given birth to a healthy child. Do you wish to keep it?",
	DIALOGUEKEEPBABY = "Keep baby",
	DIALOGUEINSPECTBABY = "Inspect future baby",
	DIALOGUEREMOVEBABY = "Leave it at an orphanage",
	
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
	DIALOGUECHESTMIMICTRAPPED = "As [name] leans on the chest, [he] quickly realizes that it's not a chest, but a Mimic, which is about to devour [him]. Being stuck in his mucous, [he] won't be able to escape, unless helped. \n\n{color=aqua|[name]}— {random_chat_active|mimic_eat}\n\n[He] will certainly be eaten if left in this state.",
	DIALOGUECHESTEROTICMIMICTRAPPED = "As [name] leans on the chest, [he] quickly realizes that it's not a chest, but a Mimic, which is about to devour [him]. However, Mimic does not seem to be harming [him], rather seizing its pray and getting under [his] clothes. With no outside help Mimic will surely have its way with [name]...\n\n{color=aqua|[name]}— {random_chat_active|mimic_rape}\n\nLeaving [him] in this state won't likely kill [him], but...",
	DIALOGUECHESTMIMICTRAPPEDLEAVE = "You decide it's too dangerous to challenge the Mimic and leaving [name] to him is an acceptable price...\n\n{color=aqua|[name]}— {random_chat_active|mimic_leave}",
	DIALOGUECHESTMIMICEROTICTRAPPEDLEAVE = "You decide it's too dangerous to challenge the Mimic and leaving [name] to him is an acceptable price...\n\n{color=aqua|[name]}— {random_chat_active|mimic_erotic_leave}\n\nAfter about an hour of erotic moans and pleads [name] manages to free [him]self and escape.",
	DIALOGUECHESTLOCKPICKSUCCESS = "[name] has skillfully picked the chest's lock and its contents belong to you now. ",
	
	DIALOGUECHESTMIMICFIGHT = "Fight Mimic",
	DIALOGUECHESTMIMICLEAVE = "Leave Mimic alone",
	
	DIALOGUEEVENTTRAP = "You come across a trapped hallway. Someone will have to disarm it, by skill or their well-being...",
	
	DIALOGUEWOLVES_SKIRMISH_START = "You find the location of the wolves which were reported by the locals. ",
	DIALOGUEFIGHTOPTION = "Fight",
	DIALOGUEREBELS_SKIRMISH_START = "You find the group of rebels which has been reported by locals. It seems they are ready to fight you.",
	DIALOGUEGOBLINS_SKIRMISH_START = "You find the group of goblins which has been reported by locals. It seems they are ready to fight you.",
	DIALOGUEOGRE_SKIRMISH_START = "",
	DIALOGUETROLL_SKIRMISH_START = "",
	
	DIALOGUESHRINECELENA = "You come across a religious structure: a small shrine made of light metal. It seems to be rather weary, but you can make out a symbol of moon engraved on a side of it. Despite being located at such place, you still feel a faint power around it. ",
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
	
	DIALOGUEEVENTGOBLINFRIENDLY = "As you make your way through the caves you find an isolated room. As you barge in, a lone goblin [boy] jumps in scare. \n\n— Wait, wait, please don't kill me! I'm not wanna fight, I'm only here accidently. I won't tell anyone I've seen you, I promise.\n\nSurprised by the fact [he] knows common speech and is civilized unlike others you consider what to do with [him].",
	DIALOGUEEVENTGOBLINRECRUIT = "Attempt to recruit",
	DIALOGUEEVENTGOBLINBRINGTOLEADER = "Request getting you to the leader",
	DIALOGUEEVENTGOBLINKILL = "Kill",
	DIALOGUEEVENTGOBLINCAPTURE = "Capture",
	DIALOGUEEVENTGOBLINLEAVE = "Let go",
	DIALOGUEEVENTGOBLINRECRUITSUCCESS = "[center]{color=green|Success!}[/center]\n— Eh?.. You want me to work for you? Well, I can't refuse someone big and strong like you, can I? I mean, I'll gladly take your offer! This place is a big ass dump after all.\n\nAfter [name] received instructios, [he] quickly disappeared in the way of your mansion.",
	DIALOGUEEVENTGOBLINRECRUITFAILURE = "[center]{color=red|Failure!}[/center]\n— Eh?.. I... don't think this is a good idea, we don't take betreyals nicely, ya know. Now, if you excuse me...\n\nBefore you can react, the goblin [boy] disappears from sight in one of the tunnels you didn't notice on entrance.",
	DIALOGUEEVENTGOBLINBRINGTOLEADERSUCCESS = "[center]{color=green|Success!}[/center]\n— You actually serious?! I-I guess someone like you can do that... Okay, fine, I'll show you the way, but after this you won't see me anywhere close to it. You got me? \n\nAfter a few minutes of getting through cave maze, you end up before the entrance of the room which seems to lead to the local goblin leader. Before you can notice, the goblin is already disapparead from sight.",
	DIALOGUEEVENTGOBLINBRINGTOLEADERFAILURE = "[center]{color=red|Failure!}[/center]\n— This... This is unreasonable ya know, I'm not out of my mind yet. If you are so willing to die, don't drag me in. \n\nAs [he] was talking [he] moved to the position and darted from the room before you could react. ",
	DIALOGUEEVENTGOBLINCAPTUREREPLY = "You figure that civilized goblin can be a useful tool or net some profit on the market. Without giving [him] a second chance, you seize [him].\n\n— Hey, what the {^fuck|hell} are you {^doing|thinking}?! Let me go!.. You bastards!",
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
	
	
	SPRINGTEXT = "You find a small clearing with a spring. It might be a good time to take a break and rest.",
	SPRING_HEAL = "Your group rests and restores some health.",
	SPRING_HEAL_OPTION = "Rest",
	SPRING_LOOT_OPTION = "Search around",
	DIALOGUE_SPRING_LOOT = "After searching around you find a small burried stash. You decide to take its contests for yourself.",
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
	LOCATIONNAMEDUNGEON_QUEST_MINES = "quest_mine_type",
	
	SETTLEMENT = "Settlement",
	SETTLEMENT_SMALL = "Village",
	SETTLEMENT_LARGE = "Town",
	SETTLEMENT_PLAINS1 = "Settlement",
	
	DUNGEONDIFFICULTY = "Difficulty",
	DUNGEONDIFFICULTYEASY = "Easy",
	DUNGEONDIFFICULTYMEDIUM = "Medium",
	DUNGEONDIFFICULTYHARD = "Hard",
	
	ENEMYBANDIT_MELEE = "Bandit",
	ENEMYBANDIT_ARCHER = "Ranged Bandit",
	ENEMYBANDIT_MAGE = "Bandit Mage",
	ENEMYBANDIT_BOSS = "Bandit Boss",
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
	ENEMYBANDINT_ASSASSIN = "Bandit Asssassin",
	
	ENEMYDEMONESS = "Demoness",
	ENEMYGREG = "Greg",
	ENEMYAIRE = "Aire",
	ENEMYKURDAN = "kurdan",
	
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
	SCENEDAISY_PURCHASE_OPTION2 = "Purchase",
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

	TUTORIAL_MAINSCREEN = "The center of your Mansion is the list of available characters before you. Click once to see details and skills available to selected character. You can view detailed info about them by double clicking or selecting \"Character Info\" in the left bottom corner. You can assign them to task by clicking on Occupation button. You can use their skills by selecting them at the bottom of the screen. ",
	
	
	TUTORIAL_SLAVEBASICS = "Characters are the centerpiece of the game, as they do all the work and fighting. All characters require food daily to sustain themselves, and they also have food preferences often related to their race. \n\nAll characters, besides the Master, must be constantly disciplined. If both Fear and Obedience drop too low, they will be less productive or might even attempt an escape. Fear and Obedience can be increased via social skills. Fear and Obedience slowly decrease based on the Character's Tame Factor and Timid Factor.",
	TUTORIAL_LUST = "Lust is a special stat used by every character and is more akin to a resource like Mana. It slowly grows every day and can be utilized by certain skills to provide unusual effects. Some classes, like the Succubus/Incubus are focused on manipulating this resource. Besides growing naturally, Lust can be increased from sexual interactions, based on the number of orgasms reached.",
	TUTORIAL_SLAVEPANEL = "This is the character's detailed screen. Here you can see all of the visible stats and details.\n\nEvery character consists of a number of stats, some of which can be seen on the left. You can hover over them at any time to see details on them. \n\nAt the bottom left you can select items, unlock new classes and configure additional details like imported image.",
	TUTORIAL_CLASSES_AND_SKILLS = "Every character has access to multiple classes they can unlock. After a class is unlocked, a character receives its bonuses and can use its skills. Skills can be either social or combat, with social skills helping to manage characters' behavior. Many skills have no other cost than daily charges, so feel free to use them as often as needed. ",
	TUTORIAL_CHARACTER_SELECT = "After selecting skills or some other actions you will be able to select a target of said action, sometimes allowed to select multiple targets. Locations on the bottom of Slave List allows you to filter only characters in specific places.",
	TUTORIAL_TRAVELING_AND_LOCATIONS = "At the top of the screen you can see the list of locations your characters are currently dislocated in. Click on them to see their details. \n\n\"Travels\" menu allow you to select other locations and make characters travel to them. Travelling takes time but many resources can only be gathered from outside of town. ",
	TUTORIAL_LOCATIONS_RESOURCES = "Other locations allow to gather resources presented on them. Settlement type locations allow to gather resources infinitely, but have a limit on how many characters can gather it at once. Combat locations allow to gather a limited amount of resources after they've been cleared. ",
	TUTORIAL_TATTOO_1 = "Once you've unlocked Beauty Parlor, you can apply tattoos to your characters. Tattoos provide permanent bonuses and require ink crafted at Alchemy tab. To access Tattoo menu use the corresponding button at inventory screen.",
	TUTORIAL_TATTOO_2 = "Each tattoo type has certain bonuses, require special ink and apply to only selected bodyparts. Some might also have additional requirements. Tattoos can be removed or replaced but the ink is not refunded.",


	ITEMHAIRDYE = "Hair Dye",
	ITEMHAIRDYEDESCRIPT = "Allow you to change a person's hair color.",
	
	
	ITEMMINORUS_POTION = "Minorus Potion",
	ITEMMINORUS_POTIONDESCRIPT = "A special potion, which can be used to reduce a person's specific body part size. Can be used on Breasts, Butts, Penises and Balls.",
	ITEMMAJORUS_POTION = "Majorus Potion",
	ITEMMAJORUS_POTIONDESCRIPT = "A special potion, which can be used to grow a person's specific body part size. Can be used on Breasts, Butts, Penises and Balls.",
	ITEMEXP_SCROLL = "Scroll of Knowledge",
	ITEMEXP_SCROLLDESCRIPT = "Grants 100 experience to the user.",
	
	
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
	DIALOGUEWRIT_SUCCESS = "[name] can't believe [his] eyes as [he] receive proof of [his] freedom from you. After a pause, [he] declares [his] willingness to continue to serve under your rule. \n\n{color=aqua|[name]}— {random_chat=0|writ_success}",
	DIALOGUEWRIT_FAILURE = "[name] can't believe [his] eyes as [he] receives proof of [his] freedom from you. However, after a long pause [he] takes this chance and decides to leave your retinue. \n\n{color=aqua|[name]}— {random_chat=0|writ_failure}",
	
	DIALOGUETITSSELECT = "Breasts",
	DIALOGUEASSSELECT = "Rear",
	DIALOGUEBALLSSELECT = "Balls",
	DIALOGUEPENISSELECT = "Penis",
	
	WORKRULERATION = "Extra Rations",
	WORKRULERATIONDESCRIPT = "Increases Food Consumption by 3. Boosts Productivity by 15%.",
	WORKRULESHIFTS = "Longer Shifts",
	WORKRULESHIFTSDESCRIPT = "Character overperforms at their finest capability at the cost of future improvements. \nBoosts Productivity by 25%. Character won't gain Experience or Work Stats(Physical, etc) while working. ",
	WORKRULECONSTRAIN = "Coerced Labor",
	WORKRULECONSTRAINDESCRIPT = "Character is forced to work at their best via strict regulations. Boosts productivity by 15%. Obedience Drain is increased by 50%.",
	WORKRULELUXURY =  "Private Room",
	WORKRULELUXURYDESCRIPT = "Character will have a personal room to live at. Globally reduce Obedience Drain by 25%. If Loyalty is maxed out, Obedience won't decrease anymore.",
	
	SERVICEENSLAVE = "Enslave",
	SERVICEENSLAVEDESCRIPT = "Makes chosen character into a Slave.\n\n[color=aqua]Slaves suffer 10% damage reduction and 10% productivity reduction, but their obedience drains 10% slower and they have higher consent on sexual interactions.[/color]",
	
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
	SERVANTSQUESTIONREPLY1 = "So basically all you do is operate an elaborated sex service?",
	SERVANTSQUESTIONREPLY2 = "How exactly am I useful to you?",
	SERVANTSQUESTIONREPLY3 = "Can you give me some tips?",
	SERVANTSINTRODUCTION1REPLY3 = "I'll side with you",
	SERVANTSINTRODUCTION1REPLY4 = "I'll come back later",
	SERVANTSQUESTIONS_1 = "— Absolutely! What would you like to know?",
	SERVANTSQUESTIONS_2 = "— Hahaha, you underestimate how important an elaborate sex service can be. We don't provide 'only' sex service, we train diligent trainees which can do anything you might want. Cleaning, escort, massage, entertainment... But serving their master's carnal desires is where our trainees excel. You want them begging, screaming, moaning, silent, or dominating; we find the best suited personality and appearance for the task and turn them into a toy of your dreams. Or, in case you are more romantically inclined, we are also ready to get you a love of your life.\n\nOh, sorry, I've got carried away. We also help to find new connections and support many artists and street performers, but landowners rarely care about these things. Still we appreciate good art and entertainment, even if it's not very profitable.",
	SERVANTSQUESTIONS_3 = "— Oh, nobody has explained it to you, I suppose. You see, the landowners are the only ones, who can become a part of the city's government and it's you who make the most use of people and profits. Every guild has distinct groups following them and every new person means more power for us. On the other hand, it's guilds which present and vote for the candidates, so it's a mutual benefit. \n\nYou aren't tied to a specific guild though and are free to deal with others, but we aren't obligated to stick to you either. Just consider it a sign of good will.",
	SERVANTSQUESTIONS_4 = "— You must be interested in managing your subordinates, right? Firstly, you'll be using your skills to Praise and Punish them. Depending on the subordinate they will be more responsive to one or another. Without it, they will refuse to work for you. Taking them on the private dates is a great way to build Loyalty and Authority with them. Higher Loyalty will make their Obedience drain slower, while Authority will increase potential Obedience they can store from abilitites. \n\n— Controlling your servants is just as important as feeding them. If you have problems with it, there's classes and items suited for it. You can teach other servants to help you with discipline. Some abilities can be really powerful and affect multiple targets.",
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
	LICHENCTALK5REPLY3 = "No, you will release her *Intimidate*",
	LICHENCTALK6 = "— Curses... Fine. You can have her. I'm not willing to stay here anymore.\n\n The Lich leaves with his army, leaving you with another Skull and a beaten girl.",
	LICHENCTALK6_1 = "— You are trying your luck too far, mortal. This woman is no one to you. I will not let her go.",
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
	LICHAIRETALK2 = "— I'm sorry, but… this I cannot say. My Master rescued me from slavers, and I swore my loyalty for it.",
	LICHAIRETALK2REPLY1 = "Your Master is a fool sending you here alone.",
	LICHAIRETALK2REPLY2 = "Don't you think you should reward me for your rescue?",
	LICHAIRETALK2REPLY3 = "You better not end up in a similar spot next time, take care.",
	LICHAIRETALK3 = "— But I don't have anything on me!... Unless you mean... But this would be indecent. \n\n Aire blushes heavily and looks down.",
	LICHAIRETALK3REPLY1 = "Your company would please me greatly *Seduce*",
	LICHAIRETALK3REPLY2 = "Nevermind, you can go",
	LICHAIRETALK4 = "— I-if that's so, we can find a more secluded place then? \n\n ... \n\n After a pleasant affair Aire thanks you again and leaves in an unknown direction. You decide it's time to move on as well.",
	LICHAIRETALK4_1 = "— I'm sorry, I can't do that. And there's nothing else I can offer.",
	LICHAIRETALK4_1REPLY1 = "Nevermind, it's good you are safe, take care",
	LICHAIRETALK4_1REPLY2 = "*Push down and rape*",
	LICHAIRETALK5 = "— You will not speak badly of my Master! Even if you saved me, I won't allow it. Moreover, it was my fault for charging in here without scouting.",
	LICHAIRETALK5REPLY1 = "Don't you think you should reward me for your rescue?",
	LICHAIRETALK5REPLY2 = "You better not end up in a similar spot next time, take care.",
	LICHAIRETALK5REPLY3 = "You know, I find it very satisfying to defile someone else's property (rape)",
	LICHAIRETALK6 = "— Wha?… No!! \n\n You easily subdue Aire and have your way with her body as she sobs and endures it. \n\n ... \n\n After you satisfy yourself, you find her lying on the ground barely moving.",
	LICHAIRETALK6REPLY1 = "Kill her",
	LICHAIRETALK6REPLY2 = "Leave her",
	LICHAIRETALK7 = "You slit her throat, ending her life. There's nothing else to do here and you decide to leave.",
	LICHAIRELEAVE = "You part ways with Aire and prepare to head back with your trophy.",
	
	
	FIGHTERSELECTION5 = "— Oh ho… Not bad for someone like you. Alright, you've proven your worth and we will give you our support. Try not to abuse it.",
	FIGHTERSELECTIONREPLY1 = "And here I was hoping to start a personal crusade…",
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
	REIMENCOUNTER = "With some luck you find Reim at one of the back alleys. A young, dull looking guy who shows little concern until you mention how you came on the Workers Guild behalf. \n\n— That's… Uh, you see, I have a girl I really like. Her name is Lucy. She needs money and I wanna help her out. You see, she's real nice, even though she works as a harlot... She's been real nice to me, and she needs money right now.",
	REIMENCOUNTERREPLY1 = "Why should I care?",
	REIMENCOUNTERREPLY2 = "What do you want?",
	REIMENCOUNTERREPLY3 = "Can't you find a less needy whore?",
	REIMENCOUNTER2 = "— Please, help me out. Can you return the cash to Duncan in my regard? There's 150 gold to be paid still. Just tell him that I couldn't make it. He will understand and send someone else. I will be banished if they find out I took money for personal needs.",
	REIMENCOUNTER2REPLY1 = "Is she really that special?",
	REIMENCOUNTER2REPLY2 = "You shouldn't risk your life just for some whore, she's likely just using you (persuade)",
	REIMENCOUNTER2REPLY3 = "I'm not going to pay for your whims from my pocket",
	REIMENCOUNTER2REPLY4 = "I will consider it",
	REIMENCOUNTER3_1 = "— This… I guess you are right… *sigh* You can tell Duncan this will be taken care of right away.",
	REIMENCOUNTER3_1REPLY1 = "Good. I'll be going then.",
	REIMENCOUNTER3_2 = "— No, you don't understand! She's not just some whore. Look, you must help me out here...",
	REIMENCOUNTER3_2REPLY1 = "I'm not going to pay for your whims from my pocket",
	REIMENCOUNTER3_2REPLY2 = "I will consider it",
	REIMENCOUNTER4_1 = "— I understand… Just do what you must. In the end our love will beat all.",
	REIMENCOUNTER4_2 = "— Thank you! I… probably should hurry now. I'll try to return you this favor one day.",
	REIMENCOUNTER5 = "— Lucy is not like other girls. She's kind, nice and… She's even cooked for me, can you imagine?",
	REIMENCOUNTER5REPLY1 = "I'm not going to pay for your whims from my pocket",
	REIMENCOUNTER5REPLY2 = "I will consider it",
	WORKERSELECTIONCONTINUE1 = "— You are back? Have you found him?",
	WORKERSELECTIONCONTINUE1REPLY1 = "He seems to be… busy. Here's 150 gold on his behalf.",
	WORKERSELECTIONCONTINUE1REPLY2 = "He has wasted the money on a hooker",
	WORKERSELECTIONCONTINUE1REPLY3 = "I need some more time",
	WORKERSELECTIONCONTINUE2_1 = "— Huh… I see. I'll find another courier then. Thank you for your time. You can report back to Sigmund.",
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
	XARIENCOUNTER4_1 = "— Lies! Filthy elf sibling lies. So she wants her books then? She can have them. How dare she call me a thief. I will return them, alright?",
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
	SERVANTSELECTIONFINISH8 = "Before anyone could react, the square was covered by a magic sphere, blocking any potential avenues for retreat or assistance. However, nobody from the invaders showed any unnecessary hostility. \n\n The girl spoke. \n\n— People of Aliron, the Human Lands. I'm Anastasia, Daughter of King Alber. My father was mercilessly killed 12 years ago. I swear to avenge him, defeat his enemies and return our kingdom to its former rule. Those who fight for our cause will be rewarded. Please stay strong and help us defeat the wrongdoers. Come seek us and together we will stop this unholy regime." ,
	SERVANTSELECTIONFINISH9 = "A few moments after she finished a bright flash covered the square to hide a magic portal that Anastasia used to escape. The magic barrier fell and people stood dumbstruck at what just happened.",
	STARTFINALE = "Thank you for playing the alpha version of Strive: Conquest. This project wouldn't be possible without the support of patrons.\n\nYou can keep playing indefinitely",
	
	LOAN_EVENT = "By the morning the bank loaners has visited the mansion. ",
	LOAN_SUCCESS1 = "They took 1000 gold and departed quickly. Your next payment is expected by 28th day and will be requiring 3000 gold.",
	LOAN_SUCCESS2 = "They took 3000 gold and departed quickly. Your next payment is expected by 50th day and will be requiring 10000 gold... Unless something else can be done about it.",
	LOAN_SUCCESS3 = "They took 10000 gold and departed quickly. Your next payment is expected by 100th day and will be requiring 86000 gold... Unless something else can be done about it.",
	LOAN_SUCCESS4 = "They took 86000 gold and departed quickly. This was your last payment and now you are free to do what you want...",
	LOAN_FAILURE = "However, you had no cash available. You've failed to complete the requirements and bank takes away your property, leaving you on the streets. ",
	
	SEXTRAITHELP = "Sex Traits can provide special effects during sex interactions. Traits have a chance to be unlocked in sex interaction by performing specific actions related to it. After unlock Traits can be toggled on and off. Maximum number of traits which can be active in same time is decided by {color=yellow|Sexuals Factor}. It also increase chance to unlock a trait. ",
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

	ALIRONCHURCHLEAVE = "Please come again!",

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

	SKILLSTUTORIAL1 = "At the bottom of the screen you can see abilities available to the currently selected character. Abilities are acquired from Classes and can be used on characters in the same location as caster. Social abilities are important for keeping obedience high, which is important to make characters work and travel. However, many of them will have a subtype. {color=green|Generous} subtype will vary based on target's Tame Factor, while {color=red|Mean} subtype will depend on the Timid Factor.",
	SKILLSTUTORIAL2 = "Choosing a proper approach for each character will make them obedient for a longer time. Some characters, like Master, won't require any obedience at all. To change assigned ability, right click on it.",
	SKILLSTUTORIAL3 = "After selecting an ability you'll have to select a target for it. Remember that only targets from the same location are viable. As working will consume obedience it's better to keep a character, who can provide discipline in the same location.",
	SKILLSTUTORIAL4 = "At the right side you can switch to combat abilities set up. While you can't use them outside of combat, you can still check their descriptions and prepare yourself before it.",

	EXPLORATIONTUTORIAL1 = "While browsing non-city locations you'll have access to the list of presented characters and a combat party setup. Drag and drop characters onto the party setup to assign them to it.",
	EXPLORATIONTUTORIAL2 = "Do note, that melee attacks can't be performed by back row while front row is present, and back row also can't be targeted by melee attacks at the same time. On the right of the combat team you can find available items. They can be used by dragging and dropping on active characters.",
	EXPLORATIONTUTORIAL3 = "You can also use spells to heal while in preparation, but keep an eye at mana levels or catalyst requirements.",

	TRAVELINGTUTORIAL1 = "In the Travel menu, at the top you can see available regions. More distant regions will take longer to travel. ",
	TRAVELINGTUTORIAL2 = "There are 4 types of locations: Capital, settlements, dungeons and events. Capitals generally will feature events and services. Settlements provide shops and constant resource gathering. Dungeons can be explored for combat and rewards, while also providing some resources to gather on completion. Event locations are usually one and expire once the event is cleared. Refer 'Information' tab for further details.",
	TRAVELINGTUTORIAL3 = "Once a location is selected, click on the 'Location Select' to hide the Locations window and select the characters to send.",
	TRAVELINGTUTORIAL4 = "Select characters from the list. You can sort them by locations at the bottom. Once done, confirm it to start travelling. The actual travel will require time progress.",

	CRAFTTUTORIAL1 = "While in the Craft Menu, select the crafting category from the top of the screen.",
	CRAFTTUTORIAL2 = "You need specific materials to craft an item displayed next to it. Modular items are crafted differently from standard items. Instead of specific materials they take material types for each different part of the item.",
	CRAFTTUTORIAL3 = "To select a material for the part of the modular item click on the empty slot.",
	CRAFTTUTORIAL4 = "At the top you can see how many of a material is needed. Different materials will provide different effects to the end item.",
	CRAFTTUTORIAL5 = "Once finished you can select how many times the item should be crafted and confirm the order.",
	CRAFTTUTORIAL6 = "Each item has its own required production time. To process any craft, you need to assign a character to it. You can do so from their occupation menu, or right from the Craft screen. Only characters at the mansion can craft.",
	CRAFTTUTORIAL7 = "If you decide to assign crafters from the Craft screen, select characters to be assigned, then click confirm.You can also select them from the occupation menu.",
	CRAFTTUTORIAL8 = "Once you are done, at the left side of the screen you'll see new progress for the items being worked on.",

	JOBTUTORIAL1 = "At your slave list you can change your character's job. Different locations have different occupation options based on the present resources and activities.",
	JOBTUTORIAL2 = "Select an occupation from the list to see its details. Some occupations have different outputs which have to be selected in such cases. You can also adjust working conditions to modify the output.",
	JOBTUTORIAL3 = "Production is based on the Total Productivity modifier. Different tasks have different additional modifiers, i.e. Stone or Iron Mining will also be affected by \"Collect Efficiency\". Productivity can be viewed at the character's info panel when hovering over.",

	NOSLAVESINMARKET = "No Slaves Avalible.",
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

	ALIRONELECTIONSFINISH_LINE1 = """A few hours later, an emergency meeting of the four major guilds was assembled. The leaders and landlords entered a fierce discussion on the current situation.
	
{color=aqua|Duncan:— This is ridiculous. Now every peasant will know King Alber's heir is alive. Today of all days, HOW did a large rebel group enter the city undetected? Your guild's duty is specifically to prevent such things, Myr. How do you explain this sabotage?}

{color=yellow|Myr:— How dare you accuse us of betrayal? I remember it was your duty to dispose of the royal family,and yet here we have a princess still very much alive, all grown up, and rallying the rebels against us.}""",

	ALIRONELECTIONSFINISH_LINE2 = """{color=aqua|Sigmund:— Are ya sure she's actually da princess? Might be she's an imposter. Pretty common tactic fo' dwarven disputes.} 
	
{color=yellow|Amelia:— We are almost sure she's the real deal. Her appearance correlates to the youngest child and her aura is undeniably of the royal bloodline. What we don't know is who is backing her. If the empire has a hand in this...}""",

	ALIRONELECTIONSFINISH_LINE3 = """{color=aqua|Duncan:— Our scouts have been reporting increased activity from the rebels in past months. Sympathizers and rebel forces are advancing as we speak. I'm forced to declare a state of emergency.}

The crowd of landowners bursts into a hubbub.

{color=yellow|Sigmund:— Settle lads, he's right. We can't afford to lose any of da vital points or trade routes.}""",

	ALIRONELECTIONSFINISH_LINE4 = """{color=yellow|Myr:— Mhph, so you're going to declare yourself leader now? How long do you expect the rest of the guilds to support you given your credibility after the appearance of a living heir?} 
	
{color=aqua|Duncan:— I don't expect your compliance, and I won't need your help to deal with them. Once we identify the traitor, there will be no mercy. You better prepare for it.} 

{color=yellow|Myr:— We?! Why? No, how would the Mage Guild benefit from this rebel stunt?} 

{color=aqua|Duncan:— Regardless, we will find the culprit and all accomplices will be dealt with thoroughly. Be it you, the Servants, or even one of ours.}""",

	ALIRONELECTIONSFINISH_LINE5 = """Once the meeting ended, you approach Amelia to discuss what will happen next.

— Oh, this is horrible. Now the Fighters will rule with an iron fist until the riots are quelled. For you, the bad news is the election is naturally put on hold. The good news is so is your debt. Looks like the Servants  have been benched. Me especially.""",

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

You do your best to muffle your footfalls as you explore deeper into the cave and come across the steel barred door of a prison cell carved into the stone. You sneak a look inside and notice Fred tied up with  a group of armed men, almost certainly sellswords, standing over him.""",

	FINDFRED2 = """{color=aqua|Merc:— See? He's not going anywhere.  I'm bored and it's hella cold here. Let's go already.}

{color=yellow|Merc 2:— Stop being such a whiny little bitch. They said to get rid of this guy if they don't return by evening.} 

{color=aqua|Merc:— Screw it, I wanna get drunk already. You don't really expect them to cough up extra pay do ya?}""",
	
	FINDFRED_OPTION1 = "Talk",
	FINDFRED_OPTION2 = "Attack",

	FINDFRED_TALK1 = "You decide to approach the mercs peacefully and talk to them.\n\nMerc:— Huh? Who the hell are you?",
	FINDFRED_TALK1_QUESTION1 = "I've come with a message, your services are no longer needed.",
	FINDFRED_TALK1_QUESTION2 = "I'm interested in your prisoner, maybe we could work something out.",
	FINDFRED_TALK1_QUESTION3 = "Sorry, it seems I'm lost, I better go.",
	FINDFRED_TALK1_QUESTION4 = "This is a waste of time... *attack*",

	FINDFRED_TALK1_ANSWER1 = """The merc leader gives you a skeptic look.
	
— Huh, really? Who are you trying to fool here?""",

	FINDFRED_TALK1_ANSWER1_1 = """— Huh, really? Who are you trying to fool here?""",

	FINDFRED_TALK1_QUESTION5 = "Taking me for an imposter would be a dumb move.",
	FINDFRED_TALK1_QUESTION6 = "Hey, I'm being serious here. Let's not jump to conclusions.",
	FINDFRED_TALK1_QUESTION7 = "Aren't you skittish for someone who's already received your payment?",
	FINDFRED_TALK1_QUESTION8 = "Was worth a try. I guess we'll do it the hard way.",

	FINDFRED_TALK1_ELSE = """The mercs look relieved by the thought of being freed from guard duty, but the leader gives you a doubtful look.
	
Merc Leader:— Look we all want to punch out early, but just to make sure you're on the level, what's the name of our contractor?""",

	FINDFRED_TALK1_CONTRACTOR_DUNCAN = "Duncan",
	FINDFRED_TALK1_CONTRACTOR_GREG = "Greg",
	FINDFRED_TALK1_CONTRACTOR_FRED = "Fred",
	FINDFRED_TALK1_CONTRACTOR_AVERMIK = "Avermik",

	FINDFRED_TALK1_IF_GREG1 = "Merc Leader:— Huh, alright then. Let's get the hell outta this hole in the ground boys. And you... you make sure and report back we didn't neglect our mission. Will be glad if we got hired again ‘suming the pay is good. See ya.",
	FINDFRED_TALK1_IF_GREG2 = "As the mercs leave, you move to Fred still bound on the rough stone floor and remove his gag, letting him speak.\n\n— W-who are you? Are you from the guild? Would you mind untying me?",    

	FINDFRED_ATTACK = "Deciding there's no point in negotiations you prepare to attack the mercs.",

	FINDFRED_AFTERWIN = """After the last sellsword falls, you move to Fred still bound on the rough stone floor and remove his gag, letting him speak.
	
— W-who are you? Are you from the guild? Would you mind untying me?""",

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

	
	FINDFRED_TALK1_ANSWER10 = """Mercs give you a doubtful look and after a couple of phrases the leader speaks.
	
— Alright, 300 gold and you can have him.""",

	FINDFRED_BRIBE_TAKEN = """You pass them the money and they prepare to leave.
	
Merc Leader:— Nice working with you. Oh, uh just in case someone else shows up, there's no need to mention our little deal.""",

	FINDFRED_BRIBE_REFUSED = """Merc Leader:— Well, that's a shame because we can't just let you leave after finding us here.""",

	FINFRED_BRIBE_OPTION1 = "Agree",
	FINFRED_BRIBE_OPTION2 = "Refuse",

	FINDFRED_LINE_END_KILL2 = "You cut off further protests by stuffing the gag back in Fred's mouth and lead him out of the cave.",

	FINDFRED_TALK_FAIL = "Merc Leader:— Yea', I don't think so. You'll have to tell us who you are after we beat the shit out of you.",

	# *Intermission scene— starts 1 hour after deleting location, black screen transition; greg and demoness as sprites

	INTERMISSIONINTRO1 = """Hiding from others' eyes one of the rebel leaders has been meeting the previously recruited helper.
	
{color=aqua|Greg:— You've got your fancy sword. I trust we are even now.}
	
{color=yellow|Demon:— I can't complain, enabling you to pull off that mass teleportation performance serves our interests as well.}""",

	INTERMISSIONINTRO2 = """{color=aqua|Greg:— Perfect, then get lost. I would prefer us not being seen together, especially by the princess.}
	
{color=yellow|Demon:— Now, don't be so harsh. The cult offered its assistance not just for the sake of the artifact. We could do more, you know.}

{color=aqua|Greg:— I'm not giving you anything else, we don't need your help anymore.}

{color=yellow|Demon:— Hmph, as you wish.}""",

	INTERMISSIONINTRO3 = """As Greg left the scene, Demon thought to herself.
	
{color=yellow|Demon:— Still, there's more to be gained here. I think I'll stay for a bit.}""",

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

	RETURNTODUNCAN_ANSWER1 = """— Greg... Well I'll be damned, he was one of the older knights back in the day, but he went missing during the coup. I thought he was killed but it seems I was wrong. I have no clue who the demon woman might be though...""",
	
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
	
{color=yellow|Anastasia:— Uncle! Why didn't you let me talk to them before attacking?!}

{color=aqua|Greg:— Those were guilds' trained soldiers.}

{color=yellow|Anastasia:— They had asked to see me in person though. We could've avoided all of this death and destruction.}""",

	INTERMISSION2INTRO2 = """Despite his unwillingness to answer at all, Greg had to answer carefully since Anastasia had made her protest in the presence of so many rebel soldiers...
	
{color=aqua|Greg:— You are too naive, Princess. There could have been assassins amongst them sent simply for your head. Our enemies are treacherous opportunists, this is how they work.}

{color=yellow|Anastasia:— ... it's not supposed to be like this. What good is it to free the people from tyranny if they die in the process of being liberated? We must avoid harming innocents and such needless losses.}""",

	INTERMISSION2INTRO3 = """{color=yellow|Anastasia:— I've decided. Release the survivors so they can return home.}
	
{color=aqua|Greg:— What!?}

{color=yellow|Anastasia:— This is the minimum we can do now to show our good will and noble intentions.}

{color=aqua|Greg:— ...Fine, but don't fool yourself. You will not retake the throne through mercy or kindness.}""",

	INTERMISSION2_IF_AIRE_DEAD = """{color=yellow|Anastasia:— Is there any news from Aire? She's still not back?}
	
{color=aqua|Attendant:— I'm afraid not your highness. She has yet to return.}

{color=yellow|Anastasia:— Ah... Aire, I could really use your company right about now. I hope you are safe.}""",

	INTERMISSION2_IF_AIRE_ALIVE = """{color=yellow|Anastasia:— Do you think I was wrong to demand their release?}
	
{color=aqua|Aire:— I'm sorry, It's not my place to judge you, your highness.}

{color=yellow|Anastasia:— Aire, please.}

{color=aqua|Aire:— I'm just your tool, your highness. Your will is all that matters to me.}

Noticing the princess's angry stare Aire quickly adds.

{color=aqua|Aire:— But, I guess, I would prefer to be able to return home if I were in their place.}""",

	INTERMISSION2_IF_AIRE_RAPED1 = """{color=yellow|Anastasia:— I didn't get a chance to ask, but how did your last assignment go? You've been sullen ever since you returned. Did something bad happen?
	
The princess notices Aire tensing up in response to the question.	

{color=aqua|Aire:— ... It's nothing worth mentioning to you.}""",

	INTERMISSION2_IF_AIRE_RAPED2 = """{color=yellow|Anastasia:— You didn't get injured again, did you?}
	
{color=aqua|Aire:— I'm fine, as long as I can continue to serve you.}

{color=yellow|Anastasia:— Hmm... I wonder if all elves are like this.}""",

	INTERMISSION2_IF_AIRE_NOT_RAPED1 = """{color=yellow|Anastasia:— I didn't get a chance to ask, but how did your last assignment go? You've been very lively ever since you returned, and I could use a bit of good news just about now.}
	
{color=aqua|Aire:— Oh, yes. Actually I got in just slightly over my head this time.}""",
###
	INTERMISSION2_IF_AIRE_NOT_RAPED2 = """{color=yellow|Anastasia:— Aire! You said you would be careful. You said— wait, why have you been so cheerful then?}
	
{color=aqua|Aire:— I… Well I was rescued.}

{color=yellow|Anastasia:— A rescuer? Do tell.}

{color=aqua|Aire:— I don't really know much about [him], I believe [his] name was [name]. [He] seemed like a... well a good person I think.}""",
###
	INTERMISSION2_IF_AIRE_NOT_RAPED3 = """{color=yellow|Anastasia:— [name]? We should properly reward [him], once this whole mess is over.}
	
	{color=aqua|Aire:— Ana, you really don't need to do that.}
	
	{color=yellow|Anastasia:— Don't be silly, I owe [him] my gratitude at the very least. You've been my friend for so long after all. What would I have done if you hadn't returned?}
	
	{color=aqua|Aire:— ...}""",

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
	STATAUTHORITY_MOD = "Authority Growth",
	
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
	WEAPONECN = "Encrustment",
	
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
	MATERIALEARTH_SHARDDECRIPT = "A rare gem storing some magic power which can be utilized in craft.",
	
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
	NO_FIGHT_LOW_OBED = "[name] refuses to participate in a fight (low obedience).",
	CHAR_NO_COMBAT = "[name] has sustained a grave injury and is unable to participate in fights.",
	SENDCHARTOQUESTCONFIRM = "Send this character to quest?",
	
	SKILLPOISON_BITE = "Poison Bite",
	SKILLENEMY_ENTANGLE = "Entangle",
	SKILLSHRED = "Shred",
	
	
	AIRE_AMELIA1 = """
Amelia entered Aire's cell with a neat black satchel and a smile on her face.

Amelia:— Hello darling. Aire, if I'm correct? I hope the jailers weren't too harsh with you. It seems our little investigation isn't going fast enough, so I was asked to apply my skills to loosen your tongue. 

At her words Aire glanced at the bag imagining all manner of blades and hooks that must be inside and then looked to the cat woman in her revealing attire with confusion. 

Aire:— I won't reveal anything, not to you or anyone else no matter what you do. 

Amelia:— That's cute. I believe you are a capable fighter and can withstand physical abuse, but I have my own ways of doing things. """,

	AIRE_AMELIA2 = """
Amelia retrieved a small flask of honey colored liquid which she upended against a handkerchief for a moment before stoppering it. Aire stood to her feet to struggle as best she could rather than be poisoned, but none of her training was of any use bound as she was. Amelia twisted her by her restraints and collar roughly before wrapping an arm around her and forcing the handkerchief over her nose and mouth.

Amelia:— Just breath in deeply. It won't harm you.""",

	AIRE_AMELIA3 = """
Aire held her breath for over a minute. She struggled the whole time as Amelia held her firmly while chatting to her casually as if they were friends, but the burning in her lungs became too much and she desperately gulped breaths laced with the drug. Amelia held her like that until her breathing became steady and her body started to relax.

Amelia:— Now, I understand you've heard some nasty rumors about my colleagues and I, but we can be quite generous with our partners. For instance, the drug I've just shared with you can't normally be found here at any price. They say one of the ingredients is actual Alruane nectar.

Aire's heart had begun pounding and her body grew unbearably sensitive. Amelia idly fondled her trussed breasts and periodically pinched her nipples, eliciting jerks and squeals from the elf that gradually became shudders and moans.

Amelia:— I see your voice has become more excited. Why won't you tell us what we want to know? To continue resisting like this... you must be quite fond of your master? Perhaps, even share a more intimate bond.""",

	AIRE_AMELIA4 = """
Aire:— It's not… like… that

Amelia squeezed her breasts against Aire, leaning against her in such a way that Aire would fall unless she widened her stance and arched her back. Amelia's soft finely furred tail felt like it was made of pins and needles as it slid along Aire's leg slowly upward.

Amelia:— Ah, another innocent elf maiden! I almost miss training the newcomers personally. 

Amelia's tail had made its way to Aire's panty clad sex and twitched from side to side, stimulating her now swollen clit through the material. She just couldn't think.

Amelia:— Look at you, all wet and shaking. It's pains me to torture a cute girl like that. And you must be really eager for me to end this.""",

	AIRE_AMELIA5 =  """
Aire:— Yes…

Aire's eyes teared up with humiliation as she couldn't fight the overwhelming pleasure anymore.

Amelia:— So we both want the same thing. You know how this can be done, tell me where Anastasia is.

Amelia slid a hand down from Aire's chest to pull her panties to the side, and gently traced her fingers up and down her slick slit. Under the influence of the intense aphrodisiac Aire's hips thrusted at the digits without and against her conscious thought. 

She pooled all of her will into one last attempt to twist away, but Amelia held her in place thrusting two fingers inside her and using her pussy as a handhold. Aire melted and began to tremble violently, but Amelia slipped her fingers back out and resumed teasing Aire's slit, keeping her on the edge.

Aire:— Ah, p-please… """,

	AIRE_AMELIA6 = """

Amelia:— One word and you'll get what you want. 

Aire:— ...F-fine.

Aire turned her head and whispered. Amelia's ear twitched as the elf breathed heavily into it and she beamed.

Amelia:— Good girl. Now, here's your reward.

Amelia snaked her long tail back up Aire's leg, wriggling it back and forth, finally working it into her drooling honeypot. Aire moaned and bucked futilely against Amelia's hips on pure carnal instinct, but Amelia delivered a slow deliberate pace. Aire inhaled and just as she was about to cum, Amelia began thrusting into her without as much force as a man might have but much faster. 

The sudden stimulation was overwhelming in the poor elf's hypersensitive state. She clenched and shook so wildly she stopped breathing and her eyes rolled back. One orgasm overlapped with another over minutes as Amelia pistoned her tail into the young elf until she blacked out.

Amelia lowered the spasming girl to the floor gently and retrieved her satchel after cleaning off. 

Amelia:— See, was that so hard? Hope we'll meet again in better circumstances. 

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

Rebel:— Hey, you traitorous bit-..

— Silence, putzes. 

Demon's voice shook the air and her underling froze in place.""",
	PRE_FINAL_BOSS_4 = """— I believe this is a good deal for you. After all, these people are mere peasants, what's the point in risking your life for them? I'm sure your employers will be able to replace them.

The prisoners overhearing your conversation closely observed your reaction in fear.""",
	PRE_FINAL_BOSS_OPTION_4 = """Agree""",
	PRE_FINAL_BOSS_OPTION_5 = """Refuse""",
	PRE_FINAL_BOSS_5 = """— Hah, now that's my kind of hero. A smart choice. We'll be leaving shortly then.

You observe as the demon leaves taking the frightened miners with her.""",
	PRE_FINAL_BOSS_6 = """— This wasn't the most principled of outcomes, but you are in your right to do so. I'm sorry, [name], but I'll be leaving here.

Kurdan leaves following the demon's path.""",
	PRE_FINAL_BOSS_7 = """You turn to the remaining rebels but realizing they won't be getting a pardon, they do not show signs of surrender.

— Screw that demon bitch, you won't take us alive!""",
	PRE_FINAL_BOSS_8 = """Demon:— So trying to play it all the way to the end, eh? And what do you think about it... Kurdan, if I'm correct? Haven't you come here for enlightenment?
		
Kurdan:— It seems I've been misguided. I'll have to side with [name] here.
		
Demon:— Is that so... How unfortunate. Oh well, I still could use an extra hand now, you did kept your invitation sigil, right?""",
	PRE_FINAL_BOSS_9 = """The bracelet on the Kurdan's hand erupted in dim purple glow as the demon mumbled a spell. Before you could react, Kurdan's posture and movements changed. He steadily went to the demon's side preparing for battle.
		
Demon:— You should be useful in this dispute. Now, let's see if you are even worth our time, [name].""",
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
	AFTER_MINES_DUNCAN_7 = """— I'll tell you what it means to me. There will be no tolerance for cooperation with our foes. I'll leave it to your imagination  what will happen if we find out there's some deeper connection between you and that rebel helping demon.""",
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
	AFTER_MINES_DUNCAN_10 = """— It's time. We've been preparing to siege [townname] which has been captured by rebels at the firsts days of rebellion. Now we finally have enough forces for a full fledged siege.

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
	AFTER_MINES_CONVOY_5 = """Your convoy leaves the forest. As [townname] gets closer, you spot a small group of peasants closing on you from the front. You order to be ready for another ambush but as they get closer you notice it's only a couple of families. None of them are reasonably armed. Once in range one of men kneels before you.

— Your highness, I beg you to spare us some food. The war has been ruthless to us and soldiers took nearly all of our stocks. After that we were attacked by goblins and had to migrate. Our children are starving!""",
	AFTER_MINES_CONVOY_OPTION_2 = """This is awful, you can take as much as you need""",
	AFTER_MINES_CONVOY_OPTION_3 = """We can spare you a half of what we have""",
	AFTER_MINES_CONVOY_OPTION_4 = """It's none of my business""",
	AFTER_MINES_CONVOY_6 = """— We can't thank you enough for this, [Sir]. 

After some time you are left alone with only a tenth of the original provisions. Duncan will surely not like this but there's nothing that can be done now. Perhaps at least your deed will earn you some recognition among the commonfolk...""",
	AFTER_MINES_CONVOY_7 = """You order your men to unload half of the provision and allow refugees to take it. 

— Thank you, [Sir]! We will be praying for your safety.

You part ways pondering how you are going to explain this to Duncan...""",
	AFTER_MINES_CONVOY_8 = """You refuse to give the refugees any supplies. With no other option they miserably see you off.""",
	DUNCAN_NOT_FOUND = """You've tried to find Duncan, but it seems he's not around. You'll have to join him during the siege.""",
	AFTER_MINES_CONVOY_9 = """After another couple of hours your convoy finally makes it to the siege camps a few miles away from the town. A large tent camp has been set up by the guilds' united forces. Following the directions you find Duncan, debating the course of the upcoming battle. In the far corner you spot Myr quietly leaning against the wall.
""",
	AFTER_MINES_CONVOY_10 = """— You've finally arrived, [name]. I've received a report that you're missing a considerable amount of the provisions you've been requested to bring. Explain yourself.""",
	AFTER_MINES_CONVOY_OPTION_5 = """I met a group of refugees who needed them""",
	AFTER_MINES_CONVOY_OPTION_6 = """Bandits attacked us and stole it in the confusion (lie)""",
	AFTER_MINES_CONVOY_11 = """— You had clear instructions, yet deliberately disobeyed. I'm disappointed in you, [name], and you will be penalized once we return back to Aliron. For now, get ready for battle.
	""",
	AFTER_MINES_CONVOY_12 = """— A failure is a failure. I'm disappointed in you, [name], and you will be penalized once we return back to Aliron. For now, get ready for battle.""",
	AFTER_MINES_CONVOY_13 = """— Greetings, [name]. I see you've completed your mission successfully. I'm pleased to have a capable subordinate for once.""",
	AFTER_MINES_CONVOY_14 = """Inside the settlement walls, rebels have been fortifying their defence in preparation for the upcoming battle. 

Aire:— The guilds forces are preparing an assault. There's roughly two thousand troops. These are trained soldiers and mages. Even in our current position I doubt we can withstand for long.

Greg:— You are not in a position to doubt anything. Take your place and get ready for battle. We have enough forces to protect this shady town and if anything I have a couple of trump cards of my own.

Aire: -... Yes Sir.""",
	AFTER_MINES_CONVOY_15 = """A few hundred feet away from town's walls Duncan parlayed with Anastasia as is customary prior to battle. 

Anastasia:— It pains me to see how the people suffer because of our actions, but we won't lay down our arms. 

Duncan:— I shall thank you after our victory. It's been too long since my last battle.""",
	AFTER_MINES_CONVOY_16 = """Anastasia threw an angry glance at Duncan.

Anastasia:— That's all you're gonna say now? After killing my father?

Duncan:— I have nothing else to say to a juvenile here and now. Let's get this over with.""",
	AFTER_MINES_CONVOY_17 = """Despite her irritation Anastasia managed to collect herself and demonstrate her royal upbringing with a calm answer. 

Anastasia:— Very well. The gods shall find the just. 

Duncan:— The gods shall find the just.""",
	
	
	# betrayal confirmed
	BETRAYAL_CONFIRMED_ADVANCE = """The battlefield was filled with sounds of clashing blades as numerous arrows whistled through the air. Before long an enemy group has charged at your flank.""",
	BETRAYAL_CONFIRMED_1 = """After slicing down another enemy knight Duncan surveyed the battlefield. His group had pushed deep as the enemy gave ground, nearly reaching the leading enemy unit and now he could see their commander clearly. He already knew from the reports that Greg was with the rebels, but now he had confirmed it with his own eyes.""",
	BETRAYAL_CONFIRMED_2 = """Greg:— Long time no see.

Duncan:— I wish it would have stayed that way. 

Greg:— You look tired, did safe living make you soft?

Duncan:— I'm still collected enough to end you and this pitiful revolt.""",
	BETRAYAL_CONFIRMED_3 = """Greg:— Heh, we'll see about that. I didn't expect you to come to the front lines, but I guess we're in luck.

Duncan:— What are you talking about?

Greg:— What do you expect your army to do it if you are taken down? 

Duncan: ...

Now Duncan realized that there was another group of rebel reinforcements approaching their flank. Their group would be outnumbered by at least two to one. Regardless, he readied his sword.""",
	BETRAYAL_CONFIRMED_4 = """As you deal with the rebels you are ordered to advance. From your perspective it seems the Guilds' army is slowly coming out on top.""",
	BETRAYAL_CONFIRMED_5 = """Myr observed the battlefield from the nearby hill a few hundred feet away. Most of the lower mages were drafted to support the fighting forces but she had a different mission. Being the strongest caster in all Aliron or perhaps the whole country, she was reserved for more than simple healing and spellslinging. 

She patiently observed the battlefield, as the guilds troops advanced toward the town. """,
	BETRAYAL_CONFIRMED_6 = """Duncan:— Strategy was always your strong side. 

Greg:— Hmph.

As more groups were approaching Duncan he and his unit dwindled as it grew fatigued.""",
	BETRAYAL_CONFIRMED_7 = """Greg:— It was your mistake to rush in, even more so to lead the charge personally. 

Duncan:— Who else would it do? 

Greg:— Perhaps it's time for you to surrender. 

Duncan:— Not interested.

Greg:— Hmph, you always were all brawn and no brains. So be it.""",
	BETRAYAL_CONFIRMED_8 = """Myr:— These damn fools...

Without delay Myr started chanting a powerful spell. In a few moments a large earthquake hit the rebel reinforcements approaching Duncan's unit. A few other mages under her command joined in, casting long range magic on the separated rebel groups. """,
	
	BETRAYAL_CONFIRMED_9 = """The spell produced a powerful shockwave near Duncan and when he turned to the side he found the approaching enemy formation  crumbled under the magical barrage.

Duncan:— Damn you, Myr. Who asked you to interrupt?

Duncan muttered to himself. However, Greg was far more surprised by this. He realized he just lost his tactical advantage, and quickly withdrew from the fight.

Greg:— Cursed sorcerers. Retreat to the town's walls!

Following the command, the rebel forces withdrew, however the Guilds' army quickly took the initiative and moved in.""",
	BETRAYAL_CONFIRMED_10 = """However, before the bulk of the guild forces were able to enter the town, a gigantic white dome had enveloped the rebels' refuge. Magic on a scale they'd never seen completely blocked any advance or attack from the guilds' army. 

Dumbfounded, the guilds' forces were forced to halt and regroup.""",
	BETRAYAL_CONFIRMED_11 = """The army's leaders gathered together to discuss the situation.
	
	Duncan:— What's this thing about? Why can't we pass through?

Myr:— Looks like a Divine Influence to me. This is not really our speciality.

Duncan:— What are you talking about?

Myr:— It's a special kind of magic, the source of which is higher beings. But it's so rare I've only observed it a couple of times. We can't really do anything about it with our relatively marginal power.""",
	BETRAYAL_CONFIRMED_12 = """Duncan:— Dammit, to think rebels would have something like this...

Myr:— I would imagine the princess could pull of something unusual, but not on this scale. 

Duncan:— How long will this thing persist?

Myr:— I'd not expect it to go down on its own. The divine doesn't always follow the same rules as normal magic.

Duncan:— Damnit...""",
	BETRAYAL_CONFIRMED_13 = """Duncan:— Listen here, [name]. You've shown your resourcefulness earlier. I want you to find a way to remove the barrier. Without it we can finish this battle and liberate [townname]. 

Myr:— We will be keeping our forces ready in case they decide the rebels launch a counterattack.""",
	BETRAYAL_CONFIRMED_OPTION_1 = """I have no idea what to do either""",
	BETRAYAL_CONFIRMED_OPTION_2 = """Do you have any suggestions as to where I should start?""",
	BETRAYAL_CONFIRMED_14 = """Myr:— Hmm, my only idea would be to try asking a religious institution. Those usually are more familiar with Divine Influences and how to deal with them.""",
	BETRAYAL_CONFIRMED_OPTION_3 = """I'll try my best""",
	BETRAYAL_CONFIRMED_OPTION_4 = """You really make me work""",
	BETRAYAL_CONFIRMED_OPTION_5 = """Alright, I'll ask for a votive candle on your behalf""",
	
	DIVINE_SYMBOL_OPTION_1 = """Can you tell me anything about Divine Influence?""",
	DIVINE_SYMBOL_1 = """— We've had some teaching and  records about it. What exactly would you like to know?""",
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
	DIVINE_SYMBOL_7 = """Duncan:— You are back. What is the news?""",
	DIVINE_SYMBOL_OPTION_8 = """I've found a way to enter the barrier""",
	DIVINE_SYMBOL_OPTION_9 = """I'm ready to go""",
	DIVINE_SYMBOL_8 = """Duncan:— So, with this you will be able to enter the barrier and get rid of that "Champion". Fine, I approve of it. Once you enter it we will get ready for the assault.

Myr:— Judging from the looks of it, I'd expect the culprit to be at the center of Dome, likely protected too. 

Duncan:— Whoever it is, gather your best followers and prepare for a hard fight. I would prefer to accompany you, but the army can't be left without a commander.""",
	DIVINE_SYMBOL_9 = """Duncan:— Good, let's not waste time. This battle's outcome is in your hands. 

Myr:— There's a spot from which you can enter unnoticed from the hill side, I'll show you.""",
	DIVINE_SYMBOL_10 = """You finish your preparations and at nightfall you enter the barrier where Myr showed you. As you make your way to the streets you only spot the occasional rebel patrol and  they seem fairly lax. By staying in the shadows you manage to eavesdrop on them.

First Sentry:— Why are we even doing this? It's not like those bastards can get in. 

Second Sentry:— Yah, I know. We've been at this for days and nothing. I'd rather grab a beer and a pair of tits instead of a fuckin' spear. 

As they pass you continue to move on.""",
	DIVINE_SYMBOL_11 = """As you slowly make your way into the town center, you notice your position is being approached by another patrol. You’re about to be cut off, and won't be able to retreat unnoticed.""",
	DIVINE_SYMBOL_OPTION_10 = """Make a run for it (Physics Check)""",
	DIVINE_SYMBOL_12 = """{color=green|Success}

Thanks to your quick reaction, you've managed to nimbly avoid the patrol.""",
	DIVINE_SYMBOL_13 = """{color=red|Failure}

You've tried, but after taking a corner too wildly you crash into a pile of crates. The patrol has noticed the noise you've made and now you have no other option but to fight.""",
	DIVINE_SYMBOL_14 = """You've managed to defeat the patrol relatively quietly. Hoping not be discovered again, you leave the place.""",
	DIVINE_SYMBOL_15 = """You arrive at a small square where your target should be. However, there are multiple buildings anyone of which could be it.""",
	DIVINE_SYMBOL_OPTION_11 = """Search (Wits Factor Check)""",
	DIVINE_SYMBOL_16 = """{color=red|Failure}

You've entered the wrong building. A few rebels recognize you as an intruder and arm themselves.""",
	DIVINE_SYMBOL_17 = """You finish the rebels as silently as possible and return to the square.""",
	DIVINE_SYMBOL_18 = """{color=green|Success}

You enter a small hallway with doors guarded by an armed group of rebels. 

First Guard:— Why can't we stay inside?

Second Guard:— She requested to be left alone. That's for the better if you ask me.""",
	DIVINE_SYMBOL_18_1 = """First Guard:— Hmm? Why, you dislike her?

Second Guard:— She's of beast blood, she acts like lunatic and looks like a brat. Greg finds her useful, but I'd rather side with a troll.""",

	DIVINE_SYMBOL_19 = """First Guard:— Yeah, in terms of brains you would find common ground.

Second Guard:— You shut yo-

The guards stop halfway noticing your approach. They give you a warring look waiting for your further actions.""",
	DIVINE_SYMBOL_OPTION_12 = """Greg called for me to pay him a visit (Charm Factor Check)""",
	DIVINE_SYMBOL_OPTION_13 = """Attack them""",
	DIVINE_SYMBOL_20_1 = """Second Guard:— Damnit, what does he want now? 

First Guard:— Probably figured you've been sleeping during the last watch.

Second Guard:— You didn't tell him that, did you? Fuck, lets go. 

They leave the building, leaving the door unguarded.""",
	DIVINE_SYMBOL_20_2 = "Second Guard:— Bullshit, they're intruders. Get them!",
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
	DIVINE_SYMBOL_45 = """Greg:— What the hell... Shit, what happened to the barrier!?

Aire:— It seems they somehow made it inside. Their main army has been waiting for this. I'm afraid we won't hold for long.

Greg:— Goddamnit. Order the retreat. And make sure the princess is safe. Curses on that useless champion, she better not make it out of this alive.""",
	DIVINE_SYMBOL_46 = """Myr:— Huh, [he] really managed to pull it off. Are you not going to lead the assault?

Duncan:— No, it's over and there's no challenge. I've set outriders to keep watch out for any potential escape so the princess should be ours shortly. 

Myr:— Hmph, she's too smart to get caught by you. 

At this moment a messenger approached Duncan.""",
	DIVINE_SYMBOL_47 = """Messenger:— Sir, [name] has returned and asks for an audience. 

Duncan:— Bring [him].

As you come out you notice how Duncan's stoic face shows a hint of respect. 

Duncan:— A splendid job. You are going down in history with what you've pulled out here. Also managed to do what those mages couldn't.

Myr:— Screw you.""",
	DIVINE_SYMBOL_OPTION_33 = """That wasn't too hard""",
	DIVINE_SYMBOL_OPTION_34 = """I thought I wasn't gonna make it""",
	DIVINE_SYMBOL_48 = """Duncan:— Either way the town will be ours by tomorrow morning. You can go and rest until then.""",
	DIVINE_SYMBOL_49 = """A few hours later

Soldier:— We have captured the town, but there has been no sign of Greg or the princess.

Duncan:— Damnit, they must've had some hidden escape routes we had no idea about. Nevertheless, the town is ours and the rebel forces have been defeated.

Duncan:— [name], you can return to Aliron now. We shall plan out our next moves.""",


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

	FINAL_OPERATON_WORKERS_1 = """— Ach, have ya no mind to what pressure we're under? Entire guild is tied up supporting the fighters spat with the rebels. Got none free ta take on some outside job at the moment.""",
	FINAL_OPERATON_SERVANTS_1 = """— Came to us for Duncan's little raid? Please, [name], I thought you knew that we don't deal in any violence. Sorry… But to cheer you up, here's a little tip from me: ask Myr. Mages are certainly more capable in what you're looking for.""",
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

	INITIATE_HIDEOUT_ATTACK_1 = """You arrive at the location Duncan marked for you, a forested area close to the hideout. Duncan is in the midst of the group from the Fighters Guild talking with a few of them. Though as he sees you he waves them off and waves you over to him.

— Alright let's not waste time. Prepare your men and we will begin.""",
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
{color=aqua|Greg:— We are under attack. The guilds have found us.}
{color=yellow|Anastasia:— So soon!? What do we do?}
{color=aqua|Greg:— You need to escape.}""",
	GUILD_ATTACK_ON_HIDEOUT_2 = """{color=yellow|Anastasia:— Run away? No, I-I can't...}
{color=aqua|Greg:— There's no other choice. If you get captured you'll end up on the gallows. Moreover, without you there are no other heirs to the throne.}
{color=yellow|Anastasia:— This is wrong, I can't leave everyone behind.}
{color=aqua|Greg:— Enough, we are wasting time. Aire! Send the princess off and return to me immediately.}""",
	GUILD_ATTACK_ON_HIDEOUT_3 = """{color=yellow|Aire:— ... I understand. Over here, your Highness.}
{color=aqua|Anastasia:— No, what am I gonna do after that?}
{color=yellow|Aire:— Don't worry, we've planned your escape for such occasions... Once we defeat the intruders we will reunite and get you back.}
{color=green|Greg:— You've heard her, Ana, now move.}
{color=aqua|Anastasia:— ...}""",
	GUILD_ATTACK_ON_HIDEOUT_4_1 = """{color=yellow|Aire:— It is done.} 
{color=aqua|Greg:— Good, you've finally done something useful at least. Now get your weapon and prepare to defend.} 
{color=yellow|Aire:— ...Understood.} 
{color=aqua|Greg:— Damnit, this whole plan has gone downhill rapidly.}""",
	GUILD_ATTACK_ON_HIDEOUT_4_2 = """{color=yellow|Aire:— It is done.} 
{color=aqua|Greg:— Good, you've finally done something useful at least. Now get your weapon and prepare to defend.} 
{color=yellow|Aire:— ...Understood.} 
{color=aqua|Greg:— Damnit, this whole plan has gone downhill rapidly.
In the deeper rooms of rebel hideout Greg barges into a room occupied by Anastasia.} 
{color=aqua|Greg:— We are under attack. The guilds have found us.}
{color=green|Anastasia:— So soon!? What do we do?}
{color=aqua|Greg:— You will have to escape. Use the route your elf has prepared for you.}""",
	GUILD_ATTACK_ON_HIDEOUT_4_3 = """{color=yellow|Anastasia:— Run away? No, I-I can't...}
{color=aqua|Greg:— They must be targeting you and without you there's no revolution.}
{color=yellow|Anastasia:— This is wrong, I can't leave everyone behind.}
{color=aqua|Greg:— This is not up for debate. You'll be executed if you end up in their hands. Now go, we'll hold them back so they can't chase after you.}
{color=yellow|Anastasia:— ...}""",

	FINAL_BOSS_1 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.""",

	FINAL_BOSS_2 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.
Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the center of the room is an elf. She quickly adopts a fighting stance.

-We've got company. To arms!""",

	FINAL_BOSS_3 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.
Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the center of the room however is someone you recognize, an elf. She notices you and quickly adopts a fighting stance.
It's the elf girl you had your fun with before. Her eyes narrow at you with clear hatred.

-You… I'd never expect to get my revenge on you here of all places. To arms!""",

	FINAL_BOSS_4 = """Fighting your way down the long tunnelway you come to an archway and quickly walk through. You enter a decent sized room, perhaps it could have been a storeroom at some point.
Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the center of the room however is someone you recognize, an elf. She notices you and quickly adopts a fighting stance.
It's the elf you saved from the lich. Her stance falters as she recognises you. She shakes her head and returns to her combat stance.

-This isn't exactly how I'd imagined I'd meet you again. I'm sorry but I won't let you get to Anastasia. To arms!""",

	AIRE_COMBAT_ON_WIN_2 = """The elf collapses in exhaustion and pain as you finish your fight looking around you're just in time to see Duncan's group charge in from a secondary entrance. 

{color=yellow|-Duncan: Nice work out there. But I'm afraid there's nobody else here, including the princess. Though this bitch should know something for sure.}""",

	AIRE_COMBAT_ON_WIN_3 = """{color=yellow|-Aire: Damn you… You won't get her!}
{color=aqua|-Duncan: Shut it, elf. You've failed to protect this place and you've failed to protect your princess. She'll get what's coming to her just as you will.}
{color=yellow|-Aire: Bastard… Agh-}

Before she can say anything else Duncan's men seize her and gag her mouth.""",

	AIRE_COMBAT_ON_WIN_3_1 = """{color=yellow|-Aire: Damn you… You won't get her!}
{color=aqua|-Duncan: Shut it, elf. You've failed to protect this place and you've failed to protect your princess. She'll get what's coming to her just as you will.}
{color=yellow|-Aire: Bastard… Agh-}

Before she can say anything else Duncan's men seize her and gag her mouth.
Quickly taking stock of your surroundings there's a few rebels carrying crates in a hurry. Near the back of the room a man oversees the activities of the rebels.

-Ah, it seems we have company. All of you form up, stop the guild scum.""",


	GREG_COMBAT_ON_WIN_1 = """The man staggers back as breathing heavily. You look around to see Duncan cut down a rebel behind you. stepping up beside you as the both of you confront the apparent ringleader of this hideout.

{color=aqua|-Duncan: Greg, stand down and surrender. This pathetic rebellion is over.}
{color=yellow|-Greg: Ah, Duncan. I could have expected you'd show up here, too bad for you though, Anastasia is already far away from here.}
{color=aqua|-Duncan: We'll see about that, my men have already surrounded the area. Now drop your w-}

Before Duncan can even finish speaking the man throws something against the ground. Light suddenly envelops your vision as a horrid ringing sound plays in your ear. You stumble around blindly for a moment, quickly blinking to clear your vision. The ringing fades a bit as you look around the room to find the man gone.""",

	GREG_COMBAT_ON_WIN_2 = """-I should have expected no less cowardice from a rebel. At least it seems like you can handle yourself, just watch your flank in the future.

Duncan turns to speak with you. The guild members begin to handcuff the rebels that aren't already dead.

— You've shown considerable skill here today.""",

	GREG_COMBAT_ON_WIN_3 = """Duncan turns to speak with you. The guild members begin to handcuff the rebels that aren't already dead.

— You've shown considerable skill here today.""",

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
	GREG_COMBAT_ON_WIN_6 = """{color=aqua|-Duncan: Her? Same as the rest of them, they'll be imprisoned and interrogated.}

The elf struggles slightly against her bindings, as she huffs in defiance.""",

	GREG_COMBAT_ON_WIN_7 = """-They'll be imprisoned and interrogated for any information about the princess, she's still our primary focus.""",

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
	SEARCH_FIGHTERS_4 = """— Hmm… Tell me more about it.""",
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

— I'm sure you can get her talking being such a charming individual yourself. Though if she proves… difficult I could always try some of my methods.""",
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
	SEARCH_DUNGEON_8_1 = """— I won't be telling you where Anastasia is, not to you, nor anyone else in this city. Other than that, I don't mind some company. (if met previously) And I know you aren't a bad person at least.""",
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
	LOOKING_FOR_PRINCESS_1 = """— Many of the rebel forces now lie dead or reside in our prison. Unfortunately we missed the princess in our raid and we’ve got no leads as to where she may have gone. Our interrogation of the prisoners hasn’t turned up much.""",
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

Amelia:— Well, fine work. This certainly belonged to the royal family. The engraving was addressed to the youngest daughter.

Myr:— Well then, let's get this over with. 

Myr takes a small medallion out of her desk. As she chants the spell, the medallion in her hand starts glowing. After about a minute she finishes and turns back to you.""",
	LOOKING_FOR_PRINCESS_20 = """Myr:— Alright, this will point in the previous owner's direction. Hold it in your hand and you'll feel slight vibrations.

Amelia:— Neat. Now you'll be able to track down our little problem. Heh, I wonder if it will keep vibrating in her presence as well...

Myr:— Leave your professional quirks out of this unless you want to be thrown out.

Amelia:— Alright, alright, I should be going anyway. Good luck [name], I'm waiting for your success.""",
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

The priestess gave orders to the guards to get the princess out.
""",
	LOOKING_FOR_PRINCESS_29 = """As Anastasia saw you, she realized what she was brought for and her face became pale.

Anastasia:— No... What the hell?! You can't do this to me!

Priestess:— Cease your childish behavior, human, if you are truly royalty, act like it.""",
	LOOKING_FOR_PRINCESS_OPTION_26 = """An honor to meet you, princess""",
	LOOKING_FOR_PRINCESS_OPTION_27 = """Now, now, there's no need to make a scene""",
	LOOKING_FOR_PRINCESS_OPTION_28 = """I've been waiting to get my hands on you""",
	LOOKING_FOR_PRINCESS_30 = """The princess paid little attention to your words and continued to lash out at the priestess, who seemed to grow more and more irritated.

Anastasia:— They will kill me, like they killed my dad. And you betrayed me. I thought I could trust you!""",
	LOOKING_FOR_PRINCESS_OPTION_29 = """*Remain silent*""",
	LOOKING_FOR_PRINCESS_OPTION_30 = """*Slap the princess and shut her mouth* (Physics Factor check)""",
	LOOKING_FOR_PRINCESS_OPTION_31 = """Lets not jump to conclusions, surely we can discuss this""",
	LOOKING_FOR_PRINCESS_31 = """{color=green|Success}
	
Before she could say any more, you've leapt at Anastasia and delivered a loud slap to her face. Not expecting this she fell in shock to the ground. You seize the moment to subdue her, plugging her mouth and excusing yourself to the priestess.

Priestess:— I'll excuse this unseemly display for now. Now leave and remember our agency in future. 

Saying this the priestess has left the hall and guards lead you to the exit. Speechless and bound, Anastasia had no option but to let you drag her away. """,
	LOOKING_FOR_PRINCESS_32_f = """{color=red|Failure}

""",
	LOOKING_FOR_PRINCESS_32 = """Anastasia:— Traitorous bastards, you are worse than these people! You and your rotten Freya should've been-

*Slap*

Before you managed to reach Anastasia, the priestess herself gave her a loud slap which made her fall to the ground in shock.""",
	LOOKING_FOR_PRINCESS_OPTION_32 = """There's no need to get violent""",
	LOOKING_FOR_PRINCESS_OPTION_33 = """Can't say I wouldn't do the same""",
	LOOKING_FOR_PRINCESS_OPTION_34 = """Alright, this is enough""",
	LOOKING_FOR_PRINCESS_33 = """Priestess:— Silence, [race]!
	
Her sudden outburst made you back off.

""",
	LOOKING_FOR_PRINCESS_34 = """The princess sat on the ground covering her cheek with a hand as the priestess glared at her,clearly enraged.

Priestess:— I could excuse your insults, fool human, if only you kept it to us, but insult of the Goddess in this temple is a grave offence. If you were an elf commoner you would have had your tongue cut out already. 

Anastasia:— ...""",
	LOOKING_FOR_PRINCESS_35 = """Priestess:— You, however, will have to answer for your crime with your life. Guards!

Anastasia:— What? No...

Following the order, the guards seized Anastasia and also blocked your way from interfering. Still in shock from sudden turn of events, the princess couldn't believe this was happening to her.""",
	LOOKING_FOR_PRINCESS_OPTION_35 = """*Oppose*""",
	LOOKING_FOR_PRINCESS_OPTION_36 = """*Let her be executed*""",
	LOOKING_FOR_PRINCESS_36 = """You tell the priestess that you will need the princess alive no matter what. After observing the shocked princess she seemed to be more calm, yet unbendable. 

Priestess:— She shall be executed regardless of your needs. This is the law and we can't pardon it despite your or her status. Once her spirit is redeemed by the tree you can have her corpse. I presume this should suffice for your masters.""",
	LOOKING_FOR_PRINCESS_OPTION_37 = """That's barbaric""",
	LOOKING_FOR_PRINCESS_OPTION_38 = """She's just a spoiled child, surely you could overlook this""",
	LOOKING_FOR_PRINCESS_OPTION_39 = """Her death by your hands could pose more danger for your lands""",
	LOOKING_FOR_PRINCESS_37 = """Priestess:— I'm well aware of what she is, but this is the law and it will not be waived.
	
""",
	LOOKING_FOR_PRINCESS_38 = """Priestess:— Watch your tongue [race], or you might join her. The law is final and not debatable.
	
""",
	LOOKING_FOR_PRINCESS_39 = """Priestess:— We care not for petty threats. The traditional punishment will be delivered as always.

""",
	LOOKING_FOR_PRINCESS_40 = """You notice that Zephyra cautiously signals you to let her negotiate on your behalf.""",
	LOOKING_FOR_PRINCESS_OPTION_40 = """As her guardian I request to take punishment for her""",
	LOOKING_FOR_PRINCESS_OPTION_41 = """*Allow Zephyra to negotiate*""",
	LOOKING_FOR_PRINCESS_OPTION_42 = """There's no helping it""",
	LOOKING_FOR_PRINCESS_41 = """Priestess makes a long pause while glaring at you. 

Priestess:— It is true that the guardian can be punished in a minor's stead. Though you must be aware that I can't simply execute the peaceful messenger of a foreign nation. Yet, our tradition demands blood. 

The priestess takes another long pause to contemplate the situation and finally answers.""",
	LOOKING_FOR_PRINCESS_42 = """Priestess:— Very well, I'll allow you to take her punishment by sacrificing one of your followers.""",
	LOOKING_FOR_PRINCESS_OPTION_43 = """*Accept*""",
	LOOKING_FOR_PRINCESS_OPTION_44 = """*Refuse* """,
	LOOKING_FOR_PRINCESS_43 = """You've chosen the sacrifice to take the place of Anastasia. As you part with [name], you don't expect to see [him] again.
	
Priestess:— Leave now and tell your masters that we still stand by the agreement.
	
Anastasia quietly observes as [name] being taken away, perhaps blaming herself for another death.""",
	LOOKING_FOR_PRINCESS_44 = """Priestess:— Then we will proceed as decided.
	
""",
	LOOKING_FOR_PRINCESS_45 = """With your approval, Zephyra walks forward. The Priestess observes her thoughtfully.

Zephyra:— The ancient traditions are important, but... quite problematic. 

Priestess:— What do you dare to suggest?

Zephyra:— Once I heard a story about a young elven lass who was fortunate enough to fall in love. It must've been very emboldening for her. But unfortunately she had fallen in love with a human male. A thing which could happen to any of us.

Priestess:— You... You have no idea what you are talking about.
""",
	LOOKING_FOR_PRINCESS_46 = """Guard:— (whispering) Huh... What's this about?
	
Zephyra:— Ah, right, I remembered the man's name was Ansfrid, I can't quite recall the girl's though.

You've noticed how the stone cold priestess visibly twitched when hearing that. The elven guards seemed to be puzzled over the whole situation.

Priestess:— Enough. We've reached a decision. You can take your noble with you. The merciful Freya pardons her misdeed.""",
	LOOKING_FOR_PRINCESS_47 = """By this order the princess is handed over to you and you give your thanks to the priestess.

Zephyra:— Isn't Freya's graciousness truly moving? I'm sure this decision will be to the benefit of all in the end.
	
Priestess:— Sure, whatever. Leave and take your foul vixen with you.
	
Zephyra:— *sniff* Hey, [name], I'm not foul, am I?""",
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

— You've done what few people dreamed to achieve, not only have you ended the war, but captured the princess herself. You've earned your future position. Once the princess' fate is ealed we will  you the winner. Speaking of which, I've arranged the meeting for tomorrow. You should participate.
""",
	PRE_ANASTASIA_EXECUTION_OPTION_4 = """What is going to happen to her?""",
	PRE_ANASTASIA_EXECUTION_OPTION_5 = """I'll join for sure""",
	PRE_ANASTASIA_EXECUTION_OPTION_6 = """More paperwork than actual fighting""",
	PRE_ANASTASIA_EXECUTION_6 = """— This is what we will decide tomorrow, but I'm positive her head will roll… or perhaps grace the gallows.""",
	PRE_ANASTASIA_EXECUTION_OPTION_7 = """She deserved it""",
	PRE_ANASTASIA_EXECUTION_OPTION_8 = """Seems like a waste to kill such a pretty girl""",
	PRE_ANASTASIA_EXECUTION_7 = """— I on't care what she deserves, she's dangerous and what has happened proves it. We get rid of her and move on.""",
	PRE_ANASTASIA_EXECUTION_8 = """— If she was not the Deranged King's daughter, I would agree with you, however she has proven too dangerous to be left alive.""",
	PRE_ANASTASIA_EXECUTION_9 = """— Until later then.""",
	PRE_ANASTASIA_EXECUTION_10 = """— Agreed, yet we can't simply finish her off and be done with it. Not on our own at least. Do come.""",
	PRE_ANASTASIA_EXECUTION_11 = """The guilds and landlords once again have gathered, now mostly to celebrate the upcoming finale of the war now that it has been won. 

Duncan:— As many have already heard, the rebellious princess has finally been captured by [name], who will be taking office as the next city mayor in light of [his] achievements. Today we, the guild leaders, decide the princess's fate. 

Myr:— As all know, she instigated the civil war which led to many losses, in lives as well as in property...""",
	PRE_ANASTASIA_EXECUTION_12 = """Sigmund:— Really care 'bout yar magic toys, huh. Were mages always dat mercantile? 

Myr:— It's hardly the time, besides you weren't the ones on the frontlines, exhausting your supplies for this pointless war. 

Sigmund:— Hmph.""",
	PRE_ANASTASIA_EXECUTION_13 = """Duncan:— Her war weakened us, we're lucky the empire didn't make a move.

Amelia:— Hmm, according to my sources she and the rebels were mostly controlled by Gregor. A king's knight.

Duncan:— ...This does not excuse her involvement.

Amelia:— She might be not quite as dangerous as you try to present her to be though. Is she not simply misguided?""",
	PRE_ANASTASIA_EXECUTION_14 = """Duncan:— Nonsense. Without her existence there would be no rebellion. This is why we will sentence her to execution today.

Amelia:— And I presume, you wish her dead?

Duncan:— Certainly.""",
	PRE_ANASTASIA_EXECUTION_15 = """Myr:— I agree. The girl is nothing but a liability. The sooner we end this, the better.

Sigmund:— I can't say I like dat, but wat are da options we 'ave?

Myr:— Indeed, for once your dwarf brain gets it.

Sigmund didn't seem to realize the insult or maybe didn't pay it attention.""",
	PRE_ANASTASIA_EXECUTION_16 = """Amelia:— Ah, how tragic. Does our vote hold no power?

Duncan:— It does not, since three of us already agreed.

Amelia:— A grim fate to fall on the young maiden, and there's really nothing that can be done...?
""",
	PRE_ANASTASIA_EXECUTION_OPTION_9 = """I wish her to live""",
	PRE_ANASTASIA_EXECUTION_OPTION_10 = """*Stay silent*""",
	PRE_ANASTASIA_EXECUTION_19 = """All guild leaders except for Amelia turn and raise an eyebrow at you. 

Amelia:— Isn't it refreshing that our future mayor is so merciful?

Duncan:— What are you saying? We can't risk keeping her alive and you know that. What is your goal?""",
	PRE_ANASTASIA_EXECUTION_OPTION_11 = """I will make her my wife""",
	PRE_ANASTASIA_EXECUTION_OPTION_12 = """I want to make her my slave""",
	PRE_ANASTASIA_EXECUTION_20 = """This outrageous statement even made Amelia look surprised. 

Duncan:— You can't be serious...

Myr:— I can't believe this either.""",
	PRE_ANASTASIA_EXECUTION_21 = """Amelia:— A true man, both a conqueror and a lover. Bards would sing of this and so many women would swoon over the tale. 

Duncan:— Enough of your nonsense, you might've earned reputation enough to become mayor, but marrying a former rebel princess is ridiculous. 

Amelia:— I actually don't think so.

Duncan:— What?

Amelia:— Consider the following, what if we have the princess marry our mayor and publicly acknowledge our regime? Won't she be more useful this way than having her executed? Moreover, many rebels would consider her as a legitimate co-ruler, while of course she would have none of the power. 

Duncan:— That's... Never going to happen.""",
	PRE_ANASTASIA_EXECUTION_22 = """Amelia:— Well, you never know where a girl's heart might stray. I think it's better than to doom such a young beauty to death.

The meeting descended into an uproar as people started arguing over the new idea.""",
	PRE_ANASTASIA_EXECUTION_23 = """Myr:— Hmph, if it's [name], [he] might manage it, I suppose. 

Sigmund:— I say it's okay if ya think so, we trust [name].""",
	PRE_ANASTASIA_EXECUTION_24 = """Being left in minority Duncan remained silent for some time, as the room mostly came to the conclusion that your proposal is sound.

Duncan:— Very well. If [name] can indeed convince the princess to publicly acknowledge our regime there's no harm in keeping her around, provided her status will be that of a slave. Even as... [his] wife. 

Amelia:— I suspect it's not going to be easy at all, [name]. But I'm sure you'll figure something out. 

Duncan:— If you fail, she will be executed as planned. Until either happens your election will be put on hold. 

Duncan:— With this the meeting is over.""",
	PRE_ANASTASIA_EXECUTION_25 = """Amelia:— A [man] of high standing should also pursue lofty goals, eh? A former princess as a personal slave is not something you see on just any day.

Duncan:— I admire your ambition, but this is too much even for you. If she manages to escape, her status will allow her to lead another rebellion, even more fierce.

Amelia:— I see where you are coming from, but think about it, if she's to declare her acceptance of our institution and asks rebels to disband it would be even better for us.

Duncan:— She has shown no willingness to cooperate, so I find it hard to believe.

Amelia:— I believe our future mayor has proven [he]'s capable of great things. So why don't we try it?""",
	PRE_ANASTASIA_EXECUTION_26 = """Myr:— Hmph, if it's [name], [he] might manage it, I suppose. 

Sigmund:— Yah, I agree. There's no point rushin' either.""",
	PRE_ANASTASIA_EXECUTION_27 = """Duncan:— ...Very well. You can attempt to persuade her. But if you fail she will be executed as planned. Until either happens your election will be put on hold.""",
	PRE_ANASTASIA_EXECUTION_28 = """Duncan:— Then, we've decided. The execution will be held next week. After that we will appoint the mayor. Thank you for your work.""",
	
	MIND_CONTROL_1 = """— Well, who would've thought you would be so ambitious as to get your hands on the princess herself. But I assure you this shall not be easy. Duncan did not lie when he said she's completely unwilling to cooperate as she sees us as nothing but evil.

— You'll have to do your best in order to persuade her. I'll give you a little tip. Play on her naivety and sense of duty. She still holds a strong conviction that she's responsible for everyone's wellbeing.""",
	MIND_CONTROL_OPTION_1 = """Another way?""",
	MIND_CONTROL_OPTION_2 = """You mean torture""",
	MIND_CONTROL_2 = """— No-no, the torture wouldn't work on her, if anything, it would probably make things worse, she might become even more recalcitrant leading up to her death.""",
	MIND_CONTROL_3 = """— There exist some practices of enforced control. I've observed a magic technique which completely bends a target's mind to another's will. Then the master could issue any orders, precious little was left of the slave's own personality in the end though.

— I guess it's up to you if you wish to use something like this. I'm sure if you ask nicely enough Myr could point you in the right direction.""",
	MIND_CONTROL_OPTION_3 = """Thanks for the tip""",
	MIND_CONTROL_OPTION_4 = """I wouldn't want to do something like this""",
	MIND_CONTROL_4 = """— It's my pleasure. I wish you success in whatever you are planning.""",
	MIND_CONTROL_5 = """— Neither would I,  a willing servant is always best after all. I just want to make sure you know it's an option. Use this information as you see fit.""",
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

— I am in desperate need of gold right now, but this kind of magic it's too exhausting and I don't feel right doing it so… I can do it for you for 5000 gold. But this will be the only time and that's my price. Take it or leave it.""",
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
	
	
	
	ANASTASIA_EXECUTION_1 = """A week later. The citizens of Aliron gathered for Anastasia's execution in the main square. A curtain hangs between posts surrounding around a raised  platform that has been prepared for the occasion. Despite being emotionally conflicted, Amelia has invited you over. 


— Hey, isn't it a nice day? Maybe a bit too nice for such a sad occurrence. But cheer up, you are going to become the mayor soon after all. And it is important for your image to be seen in public.""",
	ANASTASIA_EXECUTION_OPTION_1 = """I don't think I should be cheerful at someone's execution""",
	ANASTASIA_EXECUTION_OPTION_2 = """I'm fine, at least this is over""",
	ANASTASIA_EXECUTION_2 = """— Well, maybe it won't be that bad after all. 

Amelia smiled at you mysteriously.""",
	ANASTASIA_EXECUTION_3 = """— That's the spirit. After all, we got the best spots so we can easily leave if bored.""",
	ANASTASIA_EXECUTION_4 = """
	
Oh, look, it's about to begin.""",
	ANASTASIA_EXECUTION_5 = """As the curtain is taken down from around the platformthe crowds begin to raise their voices. In the center, a fully naked Anastasia is entrapped in a set of wooden stocks. Her face quickly turns an angry red as hundreds of eyes fix on her. A herald next to her declares her crimes at length, going on for a full minute. 

Herald:— ...for these crimes, rebel Princess Anastasia is subjected...

He pauses dramatically for effect..

Herald:— To a prolonged public humiliation. She will pay for her crimes with her body. Everyone should use her as they seem fit as long as she's not grievously harmed. 

Anastasia:— Wha..?

Princess could not decide if she should be happy to be alive or if  execution would be preferable to her imminent degradation.""",
	ANASTASIA_EXECUTION_6 = """The crowd grew even more excited as many men shouldered forward quickly forming a line. Anastasia was quickly mounted without warning from behind by the first of them with guards keeping the rest at bay.

Citizen:— Take this, you bitch! My brother died in the war because of you.

Anastasia:— I'm sorry... Please, it hurts... Stop...

However, the princess's pleading fell on deaf ears. Angry and horny citizens alike reveled in their debauchery.""",
	ANASTASIA_EXECUTION_7 = """Amelia:— He-he, isn't this much nicer than a dead body? I'm actually quite proud of myself. Don't look so surprised, I've managed to convince Duncan and others that after this nobody will ever see her as royalty, so she'll be safe. Physically anyway… can't guarantee what state her mind will be left in.""",
	ANASTASIA_EXECUTION_OPTION_3 = """Clever move""",
	ANASTASIA_EXECUTION_OPTION_4 = """This is even worse, remind me never to piss you off""",
	ANASTASIA_EXECUTION_OPTION_5 = """That doesn't sound very convincing""",
	ANASTASIA_EXECUTION_8 = """Amelia:— I did say I pity her, didn't I? And this is much more fun to watch too.""",
	ANASTASIA_EXECUTION_9 = """Amelia:— *giggle* Well, I can't take all the credit. Ever thought about how many of the landlords, the wealthy and the nobles would like to have their way with the one and only princess? After that thought took root in their minds, we managed to bring the matter to a vote in record time. These first guys in the line could do a much better job of disguising themselves, though.""",
	ANASTASIA_EXECUTION_10 = """Amelia:— Surely you don't believe that, do you? Even so, this was actually her choice. Yesterday, I informed her she would be irreparably humiliated instead of executed and I offered her a way to end her life painlessly, but she didn't take it, not that I expected her to. Moreover, I know more than one woman who wouldn't mind taking her place, provided there would be no consequences.""",
	ANASTASIA_EXECUTION_11 = """
	
Amelia:— But anyway, if you plan to take part in it, I'd recommend doing so before she becomes too much of a mess. """,
	ANASTASIA_EXECUTION_12 = """After a few hours Anastasia only barely resembled her former feisty self and was heavily covered in semen, yet the line seemed to have no end. Her pleads and cries gave way entirely to sobs and faint moans. 

The former princess kept being used by the citizenry for the whole of the next week until eventually disappearing from the main square.""",
	ANASTASIA_EXECUTION_13 = """A crowd gathered in the square waiting for the announcement of the war's conclusion. Duncan stood on the balcony of the government building. He declared how the rebel leaders were finally defeated and punished accordingly. The people rejoiced. 

— None can deny how instrumental the efforts of [sir] [name] [surname] were in securing our victory. For [his] achievements he has been awarded the office of Mayor of Aliron.""",
	
	
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
	ANASTASIA_PERSUASION_15 = """Anastasia visibly blushed. She had expected to be married off for political purposes as dictated by her status eventually, but the possibility that such a situation could be an option now  had never occurred to her. 

— T-This is ridiculous. Why would I marry my captor?""",
	ANASTASIA_PERSUASION_OPTION_17 = """My feelings are sincere""",
	ANASTASIA_PERSUASION_OPTION_18 = """You could do worse,  have I not at least proven myself capable already?""",
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

Amelia:— Allow me, I can explain as long as you are willing to take my word for it. King Alber was ruthless and cruel.

Anastasia:— You lie! Father was always kind to me.

Amelia:— I have no reason to lie, he was gone long before I was of an age to be able to benefit from his demise. He might've been kind to his kin, but not to his subjects. 

Anastasia:— ...""",
	ANASTASIA_PERSUASION_28 = """Amelia:— Have you heard of the Broderick family? Lee Broderick was a successful merchant, but one day he delivered a book to the king as a gift. Upon reading the book, the king decided that it was meant as a hidden insult, or perhaps even a curse. His family and his children were sentenced to hang one by one. Some managed to flee, but were caught, and their accomplices hanged as well.

Anastasia:— ...

Amelia:— There was a small religious sect that was commanded to abandon their beliefs or leave the city. They refused and were burned alive at the city square. Let's not forget the unlucky harlots being whipped to death about every few months. That, I've personally seen with my own eyes on two occasions.""",
	ANASTASIA_PERSUASION_29 = """Anastasia:— Enough...

Amelia:— Didn't "Uncle" Greg tell you about these? 

Anastasia:— No.

Anastasia lowered her eyes emanating an aura of depression.

Amelia:— I don't blame you, every child wants to be proud of their parents, but it shouldn't blind you.

Anastasia:— If I was wrong all along... What's the point of this struggle? I've always believed I was doing my best for the people.""",
	ANASTASIA_PERSUASION_OPTION_26 = """You've tried to do what you thought was right""",
	ANASTASIA_PERSUASION_OPTION_27 = """You were mistaken, and it's time to make up for it""",
	ANASTASIA_PERSUASION_OPTION_28 = """Stop your useless whining""",
	ANASTASIA_PERSUASION_30 = """Anastasia:— I don't feel like I have any right to make choices for anyone now.""",
	ANASTASIA_PERSUASION_OPTION_29 = """If anything, you would still be able to help people instead of dying""",
	ANASTASIA_PERSUASION_OPTION_30 = """It's your fault, but you can redeem yourself by helping us. All you must do is submit and acknowledge our rule""",
	ANASTASIA_PERSUASION_OPTION_31 = """Your crimes can still be pardoned if you cooperate""",
	ANASTASIA_PERSUASION_31 = """Anastasia:— .....I'm sorry, please leave me alone for now, I need some time to think.

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
	ANASTASIA_PERSUASION_OPTION_36 = """I wish you reunite you with your friend (Call Aire)""",
	ANASTASIA_PERSUASION_OPTION_37 = """I wanted to return something of yours""",
	ANASTASIA_PERSUASION_OPTION_38 = """Eventually we'll have to come to an agreement""",
	ANASTASIA_PERSUASION_OPTION_39 = """I'll come later""",
	ANASTASIA_PERSUASION_43 = """Anastasia gives you a puzzled look. A few moments later the guards escort the elven girl to the cell at Amelia's orders. 

Anastasia:— Aire..? You're alive!

Aire:— Ana...

The two girls hug weeping softly for the next couple of seconds. However both realize their reunion will not last long.

Anastasia:— You look... worn.

Aire:— Don't worry, I'm fine. I've been through worse.""",
	ANASTASIA_PERSUASION_44 = """Aire turns to you and you can still spot the hatred in her eyes.

Aire:— I'm sorry, but this [man] has no honor. You should never fall into [his] hands. 

Anastasia:— Wha... why? 

Aire:— I'm sorry, but please believe me. [He]'s but a beast. I don't believe [he] will treat you with any sort of respect.

Anastasia kept silent, analyzing her friend's words. Looks like her trust for you has taken a big hit.

After a few more exchanges Aire is taken away by the guards. The princess gathered her composure, forcing away the hope and sadness that had taken over her features.""",
	ANASTASIA_PERSUASION_45 = """Anastasia remained silent as Aire left the room.""",
	ANASTASIA_PERSUASION_46 = """Aire turns to you. Her face displays a mix of confusion and respect for you.

Anastasia:— Aire... I-I've been persuaded. I mean this [man] has proposed that I become [his] property in exchange for my life.

Aire:— So that's how it turned out... 

Aire sighed deeply in contemplation.""",
	ANASTASIA_PERSUASION_47 = """Aire:— I'd ask you to save yourself. This [man], while once our enemy, has been one of the few truly honorable persons I've known. If [he] managed to negotiate for your life I think you should accept the opportunity.

Anastasia:— It's unusual for you to endorse someone like this.

Aire:— Yes, but... you can't die now. You are the kindest person I've ever known.""",
	ANASTASIA_PERSUASION_48 = """Aire:— I can't say I vouch for this [man], but [he] has treated me fairly so far. If [he] managed to negotiate for your life I think you should accept the opportunity.""",
	ANASTASIA_PERSUASION_49 = """Anastasia:— Aire, but you know, I've never… what if I can't be what [he] asks?

Aire:— I-I think you will be alright, you are very graceful and beautiful after all.

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

— Rejected, huh. Too bad. I guess we don't have that many options now. Well, you know where to find me if you need anything.
""",
	ANASTASIA_PERSUASION_56 = """— I-I will accept your demand. I will announce whatever support the guilds want of me and I'll become... yours. After all you were right, it's my duty to continue serving the people, even if I won't be royalty anymore.""",
	ANASTASIA_PERSUASION_57 = """— But I have one condition. Could you ask your guild leader girl to come?""",
	ANASTASIA_PERSUASION_58 = """Soon after she said it, the cell door opens and Amelia walks in. Looks like she had lingered, awaiting the outcome of your discussion.

Amelia:— How may I be of service? 

Anastasia:— I want you to promise me Aire's safety. No, wait, I want you to let us meet occasionally as well.

Amelia:— Done, we can move your little elf friend to [name]'s service for that matter. I presume you won't deny another servant, right?

Anastasia:— ...This would be very much to my liking.""",
	
	
	
	
	
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
	ANASTASIA_PERSUASION_2_MARRY2_OPTION2 = "We can work on it once things are set out (Sexuals Factor)",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION3 = "I have little interest in your feelings, as long as I can get your body",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION4 = "I understand, it would be a lot of pressure for anyone, but you can do it",

	ANASTASIA_PERSUASION_2_ENSLAVE1 = "— I have to ask, what plans exactly do you have for me?",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION1 = "I'm sure your charisma and experience can help with management",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION2 = "You will make a good house servant",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION3 = "You will have to become trained in physical work or maybe fighting",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION4 = "A bed warmer seems like an ideal place for you",

	ANASTASIA_PERSUASION_2_ENSLAVE2_1 = "— Is that so... So you plan to also use me in a... intimate way?",
	ANASTASIA_PERSUASION_2_ENSLAVE2 = "— So, I will have to become your property. I assume, that also mean in a... intimate way?",

	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION1 = "Naturally, but I can promise you won't regret it. (Sexuals Factor)",
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

— I'm no longer the rebel leader. I know some of you still believe it is my birth right to rule, but I am no longer eligible. Instead, from now on I will be supporting the newly elected mayor of Aliron, [sir] [name] [surname]. I will be at [his] mercy while doing my best for the sake of the people. 

Upon hearing your name you come out of the shadows, delivering a quick bow and hugging Anastasia around the waist. The crowd is energized, as the rumors have been spread for some time of your deeds and how you're going to become the next ruler. Spontaneous applause breaks out.""",
	ANASTASIA_DECLARATION_3 = """Male Citizen 1:— It's finally over.

Male Citizen 2:— She's really quite a beauty.

Female Citizen:— They make a nice pair""",
	ANASTASIA_DECLARATION_OPTION_1 = """Wave to the crowd""",
	ANASTASIA_DECLARATION_OPTION_2 = """Fondle Anastasia's butt""",
	ANASTASIA_DECLARATION_4 = """You spend some more time greeting the citizens as Anastasia finishes her speech. Soon enough the announcement is declared to be over and you walk back inside the building.""",
	ANASTASIA_DECLARATION_5 = """As Anastasia continues her speech your hand, which she's become only a little accustomed to, moves lower and lands on her butt, making her to noticeably stutter and blush. Her discipline allows her to finish the speech without any terrible mistakes though and you walk back inside the building together.""",
	ANASTASIA_DECLARATION_1MC = """Today is your inauguration. With the civil war coming to an end, the people gather expecting a declaration of the victory. The central square is packed with nearly every citizen capable of attending, all in anticipation of the event.

Anastasia steps out onto the balcony of the government building and the crowd's mumbling gives way to silence awaiting her words. You hand her the guild's prepared statement and instruct her to speak.

— People of the Aliron. I am Anastasia. The former princess and leader of the rebels. I remember being at this square. When I made my announcement before. You are right to detest me. For the war was indeed all my fault. So I am here. To beg for your forgiveness. 

The crowd seems satisfied with her words, not noticing her halting oration or perhaps not remembering her more eloquent speech so many days ago. """,
	ANASTASIA_DECLARATION_2MC = """— My ways were wrong. And I've led many people to their demise. I deeply regret it. And I wish for this war to stop. This is why I ask. For those who are still out there. Fighting for my sake. To stop and surrender.

— I'm no longer the rebel leader. Some of you believe it is my birth right to rule. I renounce all claims to rule. From now on I support. The newly elected mayor of Aliron. [sir] [name] [surname]. I will be at [his] mercy. I am now willingly [his] slave.

Upon hearing your name you come out of the shadows, delivering a quick bow and hugging Anastasia around the waist. The crowd is energized, as the rumors have been spread for some time of your deeds and how you're going to become the next ruler. Spontaneous applause breaks out.""",

ANASTASIA_DECLARATION_4MC = """You spend some more time greeting the citizens as Anastasia reads aloud the rest of her speech. With that the announcement is declared to be over and you walk back inside the building. It seems like the crowd did not sense or perhaps care that there was anything amiss with the princess.""",
	ANASTASIA_DECLARATION_5MC = """As Anastasia continues reading the speech aloud you slip your hand under her skirt and knead her rump. She delivers her lines as steadily as before though a distinct blush becomes visible on her face. She finishes without any terrible mistakes and you walk back inside the building. It seems like the crowd did not sense or perhaps care that there was anything amiss with the princess.""",
	
	
	
	FINAL_WORDS_1 = """Duncan:— Congratulations, you finally made it. The rebel forces won't die out just yet, but they should never be able to unite again.

Sigmund:— Dis's good ‘nuf, as long as dey won't be takin' towns. 

Duncan:— So now you're officially mayor. 

Sigmund:— Let's get to da feast already.""",
	FINAL_WORDS_OPTION_1 = """Thank you""",
	FINAL_WORDS_OPTION_2 = """I will miss the thrill""",
	FINAL_WORDS_2 = """The end of the First Act. Thank you for playing.""",
	
	
	
	AFTER_ELECTION_PRINCESS_1 = """After the feast you find Anastasia nervously waiting for you.""",
	AFTER_ELECTION_PRINCESS_2 = """— [name]... So, what are you going to do with me now? You did say that you fancied me. Was it the truth, or are you planning to just use me however you feel like now?""",
	AFTER_ELECTION_PRINCESS_3 = """— So, I'm your slave now... What are you planning to do with me?""",
	AFTER_ELECTION_PRINCESS_OPTION_1 = """I have feelings for you""",
	AFTER_ELECTION_PRINCESS_OPTION_2 = """I'm not really interested in you""",
	AFTER_ELECTION_PRINCESS_OPTION_3 = """You are just a fine trophy""",
	AFTER_ELECTION_PRINCESS_OPTION_4 = """You'll be a great plaything""",
	AFTER_ELECTION_PRINCESS_OPTION_5 = """I haven't decided yet""",
	AFTER_ELECTION_PRINCESS_4 = """Anastasia blushed fiercely upon hearing that, still not used to the situation and being in a submissive role.

— That's so? Then you must wish to lay with me. I'm... not entirely against it""",
	AFTER_ELECTION_PRINCESS_5 = """Embrace her""",
	AFTER_ELECTION_PRINCESS_6 = """Not today""",
	AFTER_ELECTION_PRINCESS_7 = """You chivalrously carry Anastasia to your bedroom. 

— I'm sorry, this is my first time with a man.""",
	AFTER_ELECTION_PRINCESS_8 = """After she removes her clothes, the princess lies down on the bed at your instruction. Her well proportioned body lies before you.""",
	AFTER_ELECTION_PRINCESS_9 = """With some preparation Anastasia manages to become wet enough for you to penetrate her relatively painlessly. She endures the initial discomfort as you savor the feel of her unused pussy.""",
	AFTER_ELECTION_PRINCESS_10 = """In a few moments you both climax. Her  eyes roll up into her head in bliss as your seed fills her.""",
	AFTER_ELECTION_PRINCESS_11 = """— I-I'm not sure what to say. I guess I didn't expect it to feel this good. I'm glad my first time was with you.""",
	AFTER_ELECTION_PRINCESS_12 = """The princess's face becomes slightly more relaxed but also uncertain as she hears your words. Deciding she'll be useful for some tasks or barter later on you decide to leave it at this for now.""",
	AFTER_ELECTION_PRINCESS_13 = """Anastasia frowned upon hearing that but had no choice, but to comply.

— I see... I guess I'm at your mercy now.""",
	AFTER_ELECTION_PRINCESS_OPTION_6 = """I will claim my prize today""",
	AFTER_ELECTION_PRINCESS_OPTION_7 = """I don't feel like doing it """,
	AFTER_ELECTION_PRINCESS_14 = """You order the princess to join you in your bedroom, deciding it shall be a great way to end the evening.""",
	AFTER_ELECTION_PRINCESS_15 = """At your command, Anastasia removes her clothes and you position her on the bed on all fours. Deciding it's a suitable position to complete your conquest of her, you quickly mount her from behind claiming the girl's virginity. Despite her sobs she does not plead for you to stop, stoically enduring the pain and humiliation for the rest of the night.""",
	AFTER_ELECTION_PRINCESS_16 = """Anastasia looks puzzled by your answer but does not protest. However, she seems nervous. Events are not playing out as she expected.""",
	AFTER_ELECTION_PRINCESS_17 = """After the feast you've found your mindbroken Anastasia, who seems to patiently wait for you with a somewhat vacant look to her eyes.""",
	AFTER_ELECTION_PRINCESS_OPTION_8 = """Put her to use""",
	AFTER_ELECTION_PRINCESS_OPTION_9 = """Maybe another time""",
	AFTER_ELECTION_PRINCESS_18 = """By your order Anastasia removes her clothes and you drop her on the bed on all fours. Deciding it's a suitable position to complete your conquest of her, you quickly mount her from behind claiming broken girl's virginity. Despite her state, she offers a nice warmth and tightness so you have a fairly satisfying night.""",
	
	
	
	
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
	
	ITEMANASTASIA_BRACELET = "Anastasia's Bracelet",
	ITEMANASTASIA_BRACELETDESCRIPT = "An expensive bracelet belonging to former princess Anastasia and was gifted by her parents. Understandably, she treats it with care. \n\n{color=yellow|Only equippable by Anastasia}",
	

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

— For some reason, I’ve never been that interested in what came before that, so there it is. """,

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
	AMELIA_BONUS_QUESTION_REPLYALL = "— Well, I will not hold you any longer, good luck with your mission. ",


	
	
	
	
	
	#           QUESTS           #
	MAIN_QUEST_LOAN_SUMMARY = "Your mansion comes with a loan. You must find a money to pay to the bank or you'll be thrown out of your newly acquired home.",
	MAIN_QUEST_LOAN_NAME = "The Loan",
	MAIN_QUEST_LOAN_STAGE0 = "You must have over 1000 gold by 14th day.",
	MAIN_QUEST_LOAN_STAGE1 = "By 28th day have at least 3000 gold.",
	MAIN_QUEST_LOAN_STAGE2 = "By 50th day have at least 10000 gold.",
	MAIN_QUEST_LOAN_STAGE3 = "By 100th day have at least 86000 gold.",
	
	GUILDS_INTRODUCTION_SUMMARY = "You must get to know the most powerful establishments of Aliron. Those are the four guilds you must get closer to those.",
	GUILDS_INTRODUCTION_NAME1 = "The Four Guilds",
	GUILDS_INTRODUCTION_NAME2 = "First Step",
	GUILDS_INTRODUCTION_NAME3 = "New Friends",
	GUILDS_INTRODUCTION_STAGE0 = "Visit Four Aliron Guilds: Fighters, Servants, Workers, Mages; and choose one to join.",
	GUILDS_INTRODUCTION_STAGE1 = "Now, that you got accostumed with Aliron's order, you should start making progress with your standing. Earn at least 300 reputation with one of the main guilds. You can do so by completing quests from the city's notice board.",
	GUILDS_INTRODUCTION_STAGE1_5 = "You've earned enough reputation with one of the factions. Wait for a few days.",
	GUILDS_INTRODUCTION_STAGE2 = "An unexpected letter came last morning. It suggests you to visit Servants guild and meet their leader.",
}
