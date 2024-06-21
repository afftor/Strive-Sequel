extends Reference
var TranslationDict = {
	#test string
	TESTNAMELOCALIZATION = "en_test",

	
	VARIABLESTIMEWORDMORNING = "MORNING",
	VARIABLESTIMEWORDNOON = "NOON",
	VARIABLESTIMEWORDEVENING = "EVENING",
	VARIABLESTIMEWORDNIGHT = "NIGHT",
	##UI
	#Menu
	MENUCONTINUE = "Continue",
	MENUNEWGAME = "New game",
	MENULOAD = "Load",
	MENUOPTIONS = "Options",
	MENUCREDITS = "Credits",
	MENUMODS = "Mods",
	MENUGALLERY = "Gallery",
	MENUQUIT = "Quit",
	MENUCHANGELOG = "Change log",
	#Gallery
	GALLERYNAME = "Gallery",
	GALLERYSTORY = "Story",
	GALLERYERO = "Ero",
	GALLERYSCENES = "Scenes",
	GALLERYRETURN = "返回",
	GALLERYTOOLTIPTOP = """Scene Condition:""", # MISSING TRANSLATION
	GALLERYRESETBUTTON = """Reset""", # MISSING TRANSLATION
	GALLERYRESETTEXT = """Are you sure you want to reset ALL gallery progress?""", # MISSING TRANSLATION
	#ModPanel
	MODLOAD = "加载模组",
	MODLOAD1 = "这些模组将应用于游戏，并在下一次游戏开始时在编辑器中可用。",
	MODLIST = "可加载的模组列表",
	MODUP = "上",
	MODDOWN = "下",
	MODOK = "同意",
	MODCLOSE = "关闭",
	MODSORT =  "排序",
	MODOPENEDITOR = "打开编辑器（Alpha版本）",
	#MENUCREDITS
	MENUCREDITSNAME = "Credits",
	MENUCREDITSDESC = """Game design, writing, programming: Maverik /

						Combat and skil programming: ykoc

						GUI programming: Gerakena
						Helper Programming: SphinxKingStone
						Extended modding core/support: zeltop

						Character design: Nightigall
						Character design: @naisk47
						Scene art: Allanheil
						Background art: Laynesis, OMA(Olga Morozova)
						Icon art: Persich

						Writing: ralphomayo
						Writing: plumpjack
						Writing: S[Mutt]

						Proofreading: Dorant, ralphomayo, Khuja

						Also thanks to: negtize724

						Ambient battle noise: swords and shouting - pfranzen
						https://freesound.org/people/pfranzen/sounds/192072/""",
	#Options
	OPTNAME1 = "图像",
	OPTNAME2 = "游戏性",
	OPTNAME3 = "声音",
	OPTNAME4 = "作弊",
	
	OPTOPT = "设置",
	OPTCLOSE = "关闭",
	OPTGAMEPLAYFURRIES = "福瑞",
	OPTGAMEPLAYFURRMULT = "福瑞有多乳头",
	OPTGAMEPLAYFUTA = "扶她有睾丸",
	OPTGAMEPLAYSHOWDETAILES = "显示同意详细信息",
	OPTGAMEPLAYTUTOR = "启用教程",
	OPTGAMEPLAYMALERATE = "男性比例",
	OPTGAMEPLAYFUTARATE = "扶她比例",
	OPTFAMEPLAYAUTOSAVEAMOUNT = "自动保存数",
	OPTGAMEPLAYAUTOSAVETIME = "自动保存间隔天数",
	
	OPTCHANGELANGUAGE = "To change the language, you need to restart the game",
	OPTOK = "Ok",
	
	OPTAUDIOMASTERSOUND = "总音量",
	OPTAUDIOMUSIC = "音乐",
	OPTAUDIOSOUND = "音效",
	OPTAUDIOMUTE = "静音",
	
	OPTGRAPHICFULLSCREEN = "全屏",
	OPTGRAPHICFACTOR = "以文字显示因素等级",
	OPTGRAPHICRANDOMPORTRAIT = "随机肖像",
	OPTGRAPHICDISABLEANIMATIONBACKGROUNDS = "禁用动画背景",
	OPTDISABLEPAPERDOLL = "禁用人物肖像",
	
	OPTCHEATENTERCODE = "输入代码",
	OPTCHEATACTIVATE = "激活",
	OPTCHEATGETCODE = "获取代码",
	OPTCHEATPASSWORD = "密码",
	OPTCHEATCODEACTIVATE = "支持者代码激活",
	OPTCHEATCHEATMENU = "作弊菜单",
	
	#loadsavepanel
	LSPMODE = "Mode",
	LSPVER = "Version",
	LSPGOLD = "Gold",
	LSPPOPULATION = "Population",
	LSPMASTER = "Master",
	LSPDAY = "日期",
	LSPHOUR = " 小时",
	LSPIMPORTMODE = "导入模式",
	LSPSAVENAME = "存储名称",
	LSPUPDATESAVEFILE = "更新保存文件",
	LSPOUTDATED = "{color=red| (过时-使用导入模式)}",
	LSPOUTDATED2 = "{color=red|过时}",
	LSIMPORTTOOLTIP = "当该模式打开时，游戏将重新创建世界，并在加载时重置所有游戏进度，但仍将保留所有角色、物品和库存。使用此模式可以加载过时的保存。",

	PRONOUNHE = "他",
	PRONOUNHEF = "她",
	PRONOUNHEL = "他",
	PRONOUNHELF = "她",
	PRONOUNHIS = "他的",
	PRONOUNHISF = "她的",
	PRONOUNHISL = "他的",
	PRONOUNHISLF = "她的",
	PRONOUNHIML = "他",
	PRONOUNHIMLF = "她",
	PRONOUNSIR = "先生",
	PRONOUNSIRF = "小姐",
	PRONOUNMISTER = "先生",
	PRONOUNMISTERF = "小姐",
	PRONOUNSON = "儿子",
	PRONOUNSONF = "女儿",
	PRONOUNFATHER = "父亲",
	PRONOUNFATHERF = "母亲",
	PRONOUNBROTHER = "兄弟",
	PRONOUNBROTHERF = "姐妹",
	PRONOUNGENTLEMAN = "绅士",
	PRONOUNGENTLEMANF = "女士",
	PRONOUNSEX = "男性",
	PRONOUNSEXF = "女性",
	PRONOUNSEXH = "扶她",
	PRONOUNMAN = "男人",
	PRONOUNMANF = "女人",
	PRONOUNGUY = """guy""", # MISSING TRANSLATION
	PRONOUNGUYF = """gal""", # MISSING TRANSLATION
	PRONOUNHUSBAND = "丈夫",
	PRONOUNHUSBANDF = "妻子",
	PRONOUNGROOM = "新郎",
	PRONOUNGROOMF = "新娘",
	PRONOUNBOY = "男孩", 
	PRONOUNBOYF = "女孩",
	
	
	
	BUTTONMENU = "菜单",
	FINISHTURNBUTTON = "完成此回合",
	EXPLORESHOP = "商店",
	EXPLORBUYDUNGEON = "购买地下城坐标",
	EXPLORENOTICEBOARD = "通告板",
	EXPLOREHIRE = '雇用',
	EXPLORESELLCHR ="出售角色",
	EXPLOREQUESTS = '诉求',
	EXPLOREUPGRADES = "升级",
	EXPLORESERVICE = "接待",
	EXPLOREGUILDSHOP = "公会商店",
	
	SIBLINGMODULESKILLSKILLS = "性技能",
	SIBLINGMODULECONSENT = "Consent: ",
	SIBLINGMODULERULES = "规则和条件",
	SIBLINGMODULESEXTRAITS = "性特征",
	SIBLINGMODULERELATIVES = "Relatives",
	SIBLINGMODULETRAININGS = "Trainings",
	SIBLINGMODULEFOODCONSUMPTION = "每日消费量",
	SIBLINGMODULEMAIN = "Main",
	SIBLINGMODULESEX = "Sex",
	SIBLINGMODULETRAITCAPACITY = "特征容量",
	SIBLINGMODULEFOODFILTER = "食品过滤器",
	SIBLINGMODULEPARENTS = "父母",
	SIBLINGMODULESIBLINGS = "兄弟姐妹",
	SIBLINGMODULECHILDDREN = "孩子",
	SIBLINGMODULECURRENTCAPACITY = "当前容量",
	SIBLINGMODULEPERSONALITY = """Personality""", # MISSING TRANSLATION
	SYSMESSAGEATLEAST1CHAR = "至少选择一个角色进行战斗。",
	
	OPERANTATLEAST = "至少",
	OPERANTATMOST = "至多",
	
	CHARNAMEDAISY = "黛西",
	CHARNAMECALI = "卡莉",
	CHARNAMEZEPHYRA = "西菲拉",
	CHARNAMEAIRE = "艾尔",
	CHARNAMEANASTASIA = "阿纳斯塔西娅",
	CHARNAMEKURDAN = "库尔丹",
	CHARNAMEMAE = "梅",
	CHARNAMELILIA = "莉莉娅",
	CHARNAMELILITH = "莉莉丝",
	CHARNAMEJEAN = "吉恩",
	CHARNAMEHARA = "哈拉",
	CHARNAMEHELEVIEL = "赫利沃尔",
	CHARNAMELIRA = "里拉",
	CHARNAMEAMELIA = "阿米莉亚",
	
	LOCATIONTHE = " ",
	TOTALPRODUCTIVITY = "总生产力",
	
	INVENTORYCHARACTERLIST = "角色列表",
	INVENTORYSTASH = "藏匿",
	INVENTORYFILTER = "过滤器",
	#newgame
	NEWGAMENAME = "新游戏",
	NEWGAMESETTING = "设置",
	NEWGAMESKIPPROL = "Skip prologue",
	NEWGAMESTART = "开始游戏",
	
	PRESETDATADEBUGEASYNAME = "容易",
	PRESETDATADEBUGEASYDIS = "难度越容易，你就从更多的金币和资源开始。顺从的流失减少了。贷款支付减少",
	
	PRESETDATADEBUGNORMALNAME = "普通",
	PRESETDATADEBUGNORMALDIS = "标准难度，适合在管理游戏中有合理把握的玩家。",
	
	PRESETDATADEBUGHARDNAME = "困难",
	PRESETDATADEBUGHARDDIS = "具有挑战性的困难。顺从消耗得更快，战败的角色将永远消失。贷款支付不会随着序章的完成而取消。奴隶市场上的因素无法提升（成长除外）。 ",
	
	PRESETDATADEBUGIMPORTNAME = "导入",
	PRESETDATADEBUGIMPORTDIS = "开始游戏时只有主人 ",
	
	PRESETDATADEBUGADVANCEDNAME = "高级",
	PRESETDATADEBUGADVANCEDDIS = "跳过内战的介绍开始。只推荐给之前完成序章的人。-已淘汰",
	
	NEWGAMEADDITIONAL = "附加角色",
	NEWGAMESETTINGFUTA = "扶她",
	NEWGAMESETTINGFURRY = "福瑞",
	#TutorialInfo
	TUTORIALINFONAME = "介绍",
	TUTORIALINFOQUESTION = "这是你第一次玩《奋斗：征服》吗？",
	TUTORIALINFOEXPLANATION = """你可以随时打开教程，

使用按钮。""",
	TUTORIALINFODISMISS = "不需要",
	TUTORIALINFOENABLE = "启用教程",
	#Tutorial
	TUTORIALNAME = "帮助",
	TUTORIALPREV = "< 上一个",
	TUTORIALNEXT = "下一个 >",
	TUTORIALLIST1 = "介绍",
	TUTORIALLIST2 = "精心制作",
	TUTORIALLIST3 = "同行的",
	TUTORIALLIST4 = "工作",
	TUTORIALLIST5 = "寻找",
	TUTORIALLIST6 = "探索",
	TUTORIALLIST7 = "技能",
	TUTORIALLIST8 = "纹身",
	##Mansion
	#LeftMenuModule
	LMMTRAVEL = "旅行",
	LMMUPGRADES = "升级",
	LMMDATE = "交流",
	LMMINVENTORY = "库存",
	LMMCRAFT = "工艺",
	LMMJOURNAL = "日志",
	#MansionSlaveListModule
	MSLMNAME = "Character List",
	MSLMSex = "Sex",
	MSLMNNAME = "名字 ",
	MSLMSTAT = "HP/MP",
	MSLMOCCU = "Occupation",
	MSLMOB = "服从",
	MSLMEXP = "Exp",
	MSLMLOC = "位置",
	MSLMTYPE = "类型",
	
	MSLMRELOC = "重新部署",
	MSLMRE = "在",
	MSLMTURN = " 回合",
	MSLMMANSION = "Mansion",
	MSLMDAY = "日期",
	MSLMSHOWALL = "Show All",
	#MansionSlaveModule
	MSMNAME = "角色信息",
	MSMEXP = "EXP",
	
	#factor_descripts
	FACTORDESCRIPTS1 = "一窍不通",
	FACTORDESCRIPTS2 = "才疏学浅",
	FACTORDESCRIPTS3 = "平平无奇",
	FACTORDESCRIPTS4 = "手到擒来",
	FACTORDESCRIPTS5 = "出类拔萃",
	FACTORDESCRIPTS6 = "登峰造极",
	
	
	
	REQORHIGHER = "或更高",
	REQORLOWER = "或更低",
	REQHASCLASS = "已学习的课程",
	REQCONFLICTCLASS = "冲突的课程",
	REQHASANYCLASS = "已学习任一课程",
	REQRACE = "比赛",
	REQRACEISBEAST = "仅适用于最佳比赛",
	REQMUSTHAVEGEAR = "必须有",
	REQPROFLIMIT = "只有",
	REQPROFLIMIT2 = "允许",
	REQONEOFRACES = "仅供",
	REQTRAIT = "需要",
	REQPOPULATION = "必须有人口",
	REQSEX = "不允许",
	REQVIRGINFALSE = "不是童贞",
	
	#SlaveInfoModule
	SLAVE = "奴隶",
	MASTER = "主人",
	PEON = "雇工",
	HEIR = """Heir""", # MISSING TRANSLATION
	SLAVEINFOMODULEOBEDIENCE = "服从",
	SIMRESIST = "抵抗",
	SIMLOYALTYGAIN = "Loyalty Gain",
	SIMOBEDIENCEDRAIN = "Obedience Drain",
	SIMATK = "攻击力:",
	SIMDEF = "防御力:",
	SIMHITRATE = "命中率:",
	SIMSPEED = "速度:",
	SIMCRITICAL = "暴击率:",
	SIMMATK = "魔法攻击:",
	SIMMDEF = "魔法防御:",
	SIMEVASION = "闪避:",
	SIMARMORPEN = "护甲穿透:",
	SIMCRITICALMOD = "暴击伤害:",
	
	NORMALRESIST = "普通",
	FIRERESIST = "火",
	EARTHRESIST = "地",
	AIRRESIST = "风",
	WATERRESIST = "水",
	LIGHTRESIST = "光",
	DARKRESIST = "暗",
	MINDRESIST = "精神",
	ALLRESIST = "全部",
	#
	HEALTHP = "健康: ",
	MANAP = "魔力:",
	#mansionjournal 
	JOURNALLABLE = "激活的任务",
	JOURNALMAIN = "主线",
	JOURNALMINOR = "支线",
	
	QBALL = "全部",
	QBREQ = "必要条件",
	QBREW = "报酬",
	QBDAY = " 日期",
	QBLIM = "限制:",
	QBACCEPT = "接受",
	
	MONEYTOOLTIP = "Money in Posession",
	MONEYTOOLTIP2 = "Weekly Taxes",
	
	PAUSEMENUSAVE = "保存",
	PAUSEMENULOAD = "加载",
	PAUSEMENUOPT = "设置",
	PAUSEMENUGALLERY = "画廊",
	PAUSEMENUEXIT = "退出",
	
	UPGRADEUPGR = "Upgrades",
	UPGRADEINFO = "Upgrade info",
	UPGRADESHED = "Upgrade Schedule",
	UPGRADECHAR = "Characters",
	UPGRADECRAFT = "Crafting",
	UPGRADERES = "Resources",
	##
	
	#Time

	OPTIONSWITCHLANGUAGE = "Change Language",
	
	TIPLABEL = "提示",
	LOADINGTIP1 = "有些种族可以获得专属课程",
	LOADINGTIP2 = "角色初始可能的统计数据由种族定义",
	LOADINGTIP3 = "角色价值对服务工作有很大影响",
	LOADINGTIP4 = "你可以在商店购买任务所需的材料和物品。出售过多的原料也是一种赚钱方法",
	LOADINGTIP5 = "一些CG场景需要你尝试你的对话选择",
	LOADINGTIP6 = "地下城是你在短时间内的最佳收入来源",
	LOADINGTIP7 = "为每个敌人选择正确的攻击类型将大大提高你的伤害输出",
	LOADINGTIP8 = "在地牢探索期间，不要犹豫使用治疗物品和法术进行修补",
	LOADINGTIP9 = "受伤的角色在休息时恢复得更快",
	LOADINGTIP10 = "只有少数几个与人类相关的种族可以相互杂交，其余的种族只能在没有调整的情况下与自己的种族杂交",
	LOADINGTIP11 = "婴儿将随机继承他们的父母统计数据",
	LOADINGTIP12 = "与你的角色约会，了解他们的性偏好（特征）",
	LOADINGTIP13 = "在工人行会拆解装备可以让你从中提取稀有资源",
	LOADINGTIP14 = "艾维尔明克每两周在阿利隆贩卖一次外来种族的奴隶。",
	
	
	LOADLORE1NAME = "行会",
	LOADLORE2NAME = "行会领袖",
	LOADLORE3NAME = "疯狂的国王",
	LOADLORE4NAME = "兽化裔和混血裔",
	LOADLORE5NAME = "仙精",
	LOADLORE6NAME = "神眷者",
	LOADLORE7NAME = "土地所有者",
	
	LOADLORE1 = """Guilds are an essential part of the society in the kingdom of Aliron. They serve as governing bodies that oversee and manage various trades and professions, from Fighters to Mages, Workers to Servants. Each guild holds a significant amount of power, as they compete for the support and favor of landowners and work towards gaining dominance over one another.

Guilds often have their own set of rules that members must adhere to, in order to maintain good standing within their respective guild. These rules vary between different guilds but typically revolve around fair conduct in business dealings, respect for other guild members, and loyalty towards the guild's common goals.

As guilds continue to strive for success and dominance in Aliron's capital city, conflicts can arise when opposing interests clash. However, despite these rivalries it's important to note that when faced with danger or threats towards the safety of citizens or stability of the kingdom itself; these powerful organizations stand united against any outside forces aiming to cause harm.""",

	LOADLORE2 = """Guild leaders are the individuals who serve as the head of their respective guild, and hold immense power and responsibility within Aliron's society. They are usually chosen from among the most prominent members of their guild, and have proven themselves capable in both their trade and leadership abilities.

The title of Guild Leader is not only one of honor but also carries with it a heavy burden. These individuals are tasked with managing all aspects of their guild; from resolving internal disputes to establishing alliances with other factions or negotiating contracts with landowners.

Guild Leaders have a reputation for being fierce negotiators, skilled tacticians, and wise rulers. It is said that nothing happens in the capital city without the involvement or approval of at least one Guild Leader. However, despite holding such great power they are still accountable to their members, who can remove them from office should they fail to fulfill their duties as leader.""",

	LOADLORE3 = """The Mad King, whose name is now feared and whispered amongst the people of Aliron, was once the ruler of the kingdom but was eventually overthrown by the guilds. The Mad King's reign was characterized by his unpredictable behavior and madness which led those around him to fear for their lives.

Over the 20 years of his reign, there were rumors that he had set fire to entire communities in fits of rage or ordered for executions without trial. He became widely despised among both commoners and nobles alike due to his frequent outbursts and unprovoked acts of violence.

As discontent with King's rule grew among citizens and even landowners who felt threatened by his unpredictable ways; at that point the four major guilds have united to stop his rule and abdicate the monarchy. It was believed there were no descendants of him surviving until recently...""",

	LOADLORE4 = """Among the many races that populate the world are the Beastkin and Halfkin. Beastkin are humanoid beings with thick fur covering their body, resembling various animals; while Halfkin only possess animal-like features in their ears and tails.

Beastkin are known to exist primarily in tribes outside of urban areas, valuing community and harmony over individualism. They lead a nomadic way of life, often following herds of wild prey and engaging in shamanistic rituals praising local beings. Often viewed as primal or 'less civilized' by other races due to their simpler way of living compared to society within Kingdom's borders.

Halfkins on the other hand are descendants born from a union between Beastkin and other races; primarily humans, therefore more they are considerably more common at large cities. 

In Aliron, however, all races coexist peacefully for the most part, though prejudice is common. Despite these challenges both Beastkins and Halfkins have attained various positions of power within guilds and across the kingdom.""",

	LOADLORE5 = """The Fairies are a peculiar race known for their small size - being about half the height of humans. This, coupled with their wings and natural magic abilities, makes them an enchanting sight to behold. They live primarily in areas of rich magic, such as dense forests or near ancient ruins.

Fairies are characterized by their childlike behavior and curious nature; they possess innocent personalities that often endear them to others but also lead to naivety when dealing with more harsh aspects of reality. 

However, this playful demeanor is accompanied by an extreme sexual drive which Fairies express with little reserve or shame. This makes them one of the most attractive and rare trained slaves among many.""",

	LOADLORE6 = """Gods play an important and influential role in the lives of mortals. These divine entities are worshiped for their power and wisdom, with each God having specific domains they preside over.

To help carry out their wishes within the mortal realm, certain rare individuals are chosen as Champions by these various deities. These Champions are granted exceptional abilities above that of normal humans in order to carry out tasks most believe impossible or beyond comprehension.

Champions can come from any race or background and may be granted powers ranging from control of elements/magic to physical prowess beyond human limits; often referred to as "divine blessings". They're usually called upon directly by their patron god through visions or divinations. This divine guidance is absolute but not without costs for continuous service deed.

There's no shortage of myths surrounding these individuals; often spoken highly because they've been champions for various causes throughout history- both good and bad- either punished or rewarded accordingly depending on how well they fulfill divine instructions.""",

	LOADLORE7 = """Landowners in Aliron hold a considerable deal of wealth and social status within the kingdom. This is due to their ownership of large swaths of land that are used to cultivate crops, mine for resources, or build on in various ways.

In order to maintain these properties in an efficient manner, Landowners frequently employ slaves. These slaves are often treated poorly and viewed as little more than property by those who own them; their freedom denied on account of their servitude.

Despite working under harsh conditions beyond human endurance long hours with minimal rest- they are considered indispensable in keeping the economy running smoothly. Their work productivity allowed control over market prices and competing guilds.

However, while it might seem that Landowners have nothing but contempt for those below them- there have been cases where some have shown unexpected kindness towards their slaves depending on rare compassionate nature or personal beliefs systems not common among majority owner population.""",

	NIGHT = "Night",
	MORNING = "Morning",
	NOON = "Noon",
	EVENING = "Evening",
	#Buildings
	MANSION = "阿利隆（豪宅）",
	RETURNTOMANSION = "返回豪宅",
	WORKERMARKET = "集市",
	PURCHASE = "购买",
	BUY = "买",
	SELL = "卖",
	TASKS = "任务",

	LABELDISLOCATION = "错位",
	LABELDESTINATION = "目的地",
	#Materials
	STARTINGADJ = "开始",

	FOODTYPEMEAT = "Meat",
	FOODTYPEFISH = "Fish",
	FOODTYPEGRAIN = "Grains",
	FOODTYPEVEGE = "Vegetables",


	CURRENTLYINPOSSESSION = "目前持有",


	MATERIALCATEGORYFOOD = "食物",
	MATERIALCATEGORYSTONE = "石材",
	MATERIALCATEGORYWOOD = "木材",
	MATERIALCATEGORYCLOTH = "布料",
	MATERIALCATEGORYLEATHER = "皮革",
	MATERIALCATEGORYMETAL = "金属",
	MATERIALCATEGORYPLANT = "植物",
	MATERIALCATEGORYBONE = "骨骼",
	MATERIALCATEGORYCOMPONENT = "消耗品",

	MATERIALMEAT = "肉类",
	MATERIALMEATDESCRIPT = "营养丰富。狩猎所得。 ",
	MATERIALFISH = "鱼肉",
	MATERIALFISHDESCRIPT = "常见的食物来源。从捕鱼中获得。 ",
	MATERIALVEGETABLES = "蔬菜",
	MATERIALVEGETABLESDESCRIPT = "一种常见的食物。从农场收割的。 ",
	MATERIALGRAIN = "谷物",
	MATERIALGRAINDESCRIPT = "一种常见的食物。从农场收割的。食用前必须煮熟。 ",
	MATERIALBREAD = "面包",
	MATERIALBREADDESCRIPT = "用谷物烤制的主食。烹饪产生的。\n食物类型：谷物",
	MATERIALMEATSOUP = "肉汤",
	MATERIALMEATSOUPDESCRIPT = "水和肉的混合物。烹饪产生的。\n食物类型：肉，蔬菜。",
	MATERIALFISHCAKES = "鱼饼",
	MATERIALFISHCAKESDESCRIPT = "一种用鱼糊做成的烤面团。尤其受到猫族的喜爱。烹饪产生的。\n食物类型：鱼肉、谷物。",
	MATERIALCURRY = """Curry""", # MISSING TRANSLATION
	MATERIALCURRYDESCRIPT = """A bowl of grains and meat rich with a distinct flavor.
Food type: Meat, Grains.""", # MISSING TRANSLATION
	MATERIALFRIEDFISH = """Fried Fish""", # MISSING TRANSLATION
	MATERIALFRIEDFISHDESCRIPT = """A dish of fried fish with vegatables invented to nutrient picky beastgirl eaters.
Food type: Fish, Vegetables.""", # MISSING TRANSLATION
	MATERIALSTONE = "原石",
	MATERIALSTONEADJ = "石材",
	MATERIALSTONEDESCRIPT = "石头有多种形式和形状。它可以作为一种好的建筑材料，甚至可以作为低质量的工具。从采矿业获得。 ",
	MATERIALOBSIDIAN = "黑曜石",
	MATERIALOBSIDIANADJ = "黑曜石",
	MATERIALOBSIDIANDESCRIPT = "活火山附近发现的一种光滑的黑色石头。它可以作为许多建筑、珠宝或优质工具中的高品质装饰品。",
	MATERIALWOOD = "粗木",
	MATERIALWOODADJ = "木材",
	MATERIALWOODDESCRIPT = "用于一般建筑和装饰目的的坚固木材。从木材切割中获得。 ",
	MATERIALWOODMAGIC = "魔力木材",
	MATERIALWOODMAGICADJ = "魔力",
	MATERIALWOODMAGICDESCRIPT = "一种充满魔力痕迹的不同寻常的木头。",
	MATERIALWOODIRON = "铁木",
	MATERIALWOODIRONADJ = "重型木材",
	MATERIALWOODIRONDESCRIPT = "一块致密而结实的木头，甚至适合作防御用途。",
	MATERIALWOODANCIENT = "古木",
	MATERIALWOODANCIENTADJ = "古老",
	MATERIALWOODANCIENTDESCRIPT = "一种古老植物的木材。它经年累月的毅力展示了它强大的特性。",
	MATERIALLEATHER = "皮革",
	MATERIALLEATHERADJ = "皮革",
	MATERIALLEATHERDESCRIPT = "一种常见的动物皮革。可用于轻型装甲和配件。通过猎杀弱小的怪物而产生。 ",
	MATERIALLEATHERTHICK = "厚皮",
	MATERIALLEATHERTHICKADJ = "厚重",
	MATERIALLEATHERTHICKDESCRIPT = "一种更厚更结实的皮革，可以提供额外的防御。从强壮的怪物那里获得。 ",
	MATERIALLEATHERMYTHIC = "神话皮革",
	MATERIALLEATHERMYTHICADJ = "神话",
	MATERIALLEATHERMYTHICDESCRIPT = "一种属于罕见的神秘野兽的皮革，具有不同寻常的特性。从强壮和稀有的怪物那里获得。 ",
	MATERIALLEATHERDRAGON = "龙皮",
	MATERIALLEATHERDRAGONADJ = "龙",
	MATERIALLEATHERDRAGONDESCRIPT = "龙皮是极其罕见的，很难处理。从龙那里获得的。",
	MATERIALBONE = "骨骼",
	MATERIALBONEADJ = "骨骼",
	MATERIALBONEDESCRIPT = "一种常见的动物骨头。通过正确的技术，它可以提供一些有趣的特性。从怪物那里获得。 ",
	MATERIALBONEANCIENT = "古骨",
	MATERIALBONEANCIENTADJ = "古代",
	MATERIALBONEANCIENTDESCRIPT = "来自神话生物的骨头。它的性能与金属不相上下。从怪物那里获得。 ",
	MATERIALBONEDRAGON = "龙骨",
	MATERIALBONEDRAGONADJ = "龙",
	MATERIALBONEDRAGONDESCRIPT = "龙骨是稀有而昂贵的材料。从龙那里获得的。",
	MATERIALCLOTH = "布料",
	MATERIALCLOTHADJ = "布料",
	MATERIALCLOTHDESCRIPT = "一种用于简单衣服和盔甲的纤维。农业生产。 ",
	MATERIALCLOTHSILK = "丝绸",
	MATERIALCLOTHSILKADJ = "丝绸",
	MATERIALCLOTHSILKDESCRIPT = "一种精细的布料。从怪物那里获得。",
	MATERIALCLOTHMAGIC = "魔力布料",
	MATERIALCLOTHMAGICADJ = "魔力",
	MATERIALCLOTHMAGICDESCRIPT = "一种具有神奇特性的布料。手工制作。",
	MATERIALCLOTHETHEREAL = "以太布",
	MATERIALCLOTHETHEREALADJ = "以太",
	MATERIALCLOTHETHEREALDESCRIPT = "一种具有罕见魔力的布料。从怪物那里获得。",
	MATERIALIRON = "铁",
	MATERIALIRONADJ = "铁",
	MATERIALIRONDESCRIPT = "一种适用于武器和盔甲的普通金属。从采矿业获得。 ",
	MATERIALSTEEL = "钢",
	MATERIALSTEELADJ = "钢",
	MATERIALSTEELDESCRIPT = "碳和铁的一种坚固的金属合金。手工制作",
	MATERIALMITHRIL = "秘银",
	MATERIALMITHRILADJ = "秘银",
	MATERIALMITHRILDESCRIPT = "一种神奇的银色金属。从采矿业获得。",
	MATERIALADAMANTINE = "精金",
	MATERIALADAMANTINEADJ = "精金",
	MATERIALADAMANTINEDESCRIPT = "一种非常罕见且坚固的魔法合金。手工制作。 ",
	MATERIALBLUE_MOSS = "蓝苔",
	MATERIALBLUE_MOSSDESCRIPT = "一种具有神奇特性的稀有植物。",
	MATERIALSALVIA = "鼠尾草",
	MATERIALSALVIADESCRIPT = "一种罕见的植物，具有影响精神的特性。 ",
	MATERIALTRAP = "陷阱组件",
	MATERIALTRAPDESCRIPT = "将目标固定到位的机械陷阱。某些技能所必需的。 ",
	MATERIALROPE = "绳",
	MATERIALROPEDESCRIPT = "一种结实的绳子，通常用来绑东西和人。",
	MATERIALUNSTABLE_CONCOCTION = "不稳定化合物",
	MATERIALUNSTABLE_CONCOCTIONDESCRIPT = "一种强效的炼金混合物。某些技能所必需的。",
	MATERIALBANDAGE = "绷带",
	MATERIALBANDAGEDESCRIPT = "使用急救技能进行治疗所需的一包绷带。",
	MATERIALLICH_SKULL = "巫妖的头骨",
	MATERIALLICH_SKULLDESCRIPT = "曾经属于一个巫妖，但仍然有微弱的强大魔法的痕迹。 ",
	MATERIALINK_BRANDING = "墨水：品牌",
	MATERIALINK_MAKEUP = "墨水：永久化妆",
	MATERIALINK_LUST = "墨水：激情",
	MATERIALINK_HP = "墨水：自然",
	MATERIALINK_MP = "墨水：精神",
	MATERIALSPIDER_SILK = "蜘蛛丝",
	MATERIALSPIDER_SILKADJ = "丝绸",
	MATERIALSPIDER_SILKDESCRIPT = "通常从蛛形纲动物中获得的特殊品质的丝绸。 ",
	MATERIALDRACONIC_SCALES = "龙鳞",
	MATERIALDRACONIC_SCALESDESCRIPT = "龙的零件既美观又优质。",
	MATERIALHERBS = "",
	MATERIALHERBSDESCRIPT = "",
	MATERIALINK_TRIBAL = "墨水：力量",
	MATERIALINK_BRANDINGDESCRIPT = "一套工具和墨水，可以在角色身上制造某种神奇的纹身。最初由掠夺者和驯兽师使用，奴隶制社会采用品牌来建立对被征服者的统治地位。纹身并没有那么痛苦，但同样有辱人格，纹身上有主人的名字。\n\n适用于：｛color=yellow|颈部、臀部、胯部｝\n\n服从消耗-2，忠诚度增益+1。\n只能应用一次。",
	MATERIALINK_MAKEUPDESCRIPT = "一套工具和墨水，可以在角色身上制造某种神奇的纹身。虽然化妆可能不足以让野兽变成美女，但它对懒惰的人来说是一个有利的选择。\n\n适用于：｛color=yellow|面部｝\n\n魅力：+10。",
	MATERIALINK_LUSTDESCRIPT = "一套工具和墨水，可以在角色身上制造某种神奇的纹身。一个淫秽的徽章，导致主人变得更加猥亵，甚至违背了他们的意愿...\n\n适用于：｛color=yellow|胯部，胸部，臀部｝\n\n欲望增长：+10%，如果应用于胯部，则为20%。",
	MATERIALINK_HPDESCRIPT = "一套工具和墨水，可以在角色身上制造某种神奇的纹身。一种增强生命力的古老生物标志。\n\n适用于：｛color=yellow |手臂、腿部、腰部｝健康再生：+20%。",
	MATERIALINK_MPDESCRIPT = "一套工具和墨水，可以在角色身上制造某种神奇的纹身。提供魔法的能量通常很稀缺，但这个未知的标志将为持有者提供一些额外的魔力。\n\n适用于：｛color=yellow |手臂、腿部、腰部｝\n\n魔力再生：+10%。",
	MATERIALINK_TRIBALDESCRIPT = "一套工具和墨水，可以在角色身上制造某种神奇的纹身。这种特殊墨水的技术是从凶猛的战士氏族中抢救出来的。\n\n适用于：｛color=yellow |面部、胸部、手臂、腿部｝\n\n适用于面部时：+5健康\n其他：+3物理",

	TATTOOBRANDDESCRIPT = "这是你所有权的象征。减少服从消耗2，增加忠诚度增长1。",
	TATTOOLUSTDESCRIPT = "欲望增长：+10%",
	TATTOOLUST2DESCRIPT = "欲望增长: +20%",
	TATTOOMAKEUPDESCRIPT = "魅力: +10",
	TATTOOHPDESCRIPT = "健康再生: +20%",
	TATTOOMPDESCRIPT = "魔力再生: +10%",
	TATTOOTRIBALDESCRIPT = "物理: +3",
	TATTOOTRIBAL2DESCRIPT = "最大健康: +5",
	

	ITEMSLOTHEAD = "头部",
	ITEMSLOTCHEST = "胸部",
	ITEMSLOTLEGS = "腿部",
	ITEMSLOTHANDS = "手部",
	ITEMSLOTCROTCH = "胯部",
	ITEMSLOTASS = "臀部",
	ITEMSLOTUNDERWEAR = "内衣",
	ITEMSLOTLHAND = "左手",
	ITEMSLOTRHAND = "右手",
	ITEMSLOTNECK = "颈部",
	ITEMSLOTTOOL = "工具",

	ITEMLEATHER_COLLAR = "皮圈",
	ITEMLEATHER_COLLARDESCRIPT = "一个简单的皮革项圈，象征所有权。",
	ITEMELEGANT_CHOKER = "优雅的项链",
	ITEMELEGANT_CHOKERDESCRIPT = "这是一个美丽的关于你的所有权的象征物。",
	ITEMSTEEL_COLLAR = "钢圈",
	ITEMSTEEL_COLLARDESCRIPT = "一种冰冷、不舒服的金属项圈，经常用来惩罚奴隶..",
	ITEMAMULET_OF_RECOGNITION = "认可护身符",
	ITEMAMULET_OF_RECOGNITIONDESCRIPT = "阿米莉亚赠送的行会认可的证明。 ",
	ITEMANIMAL_EARS = "动物耳朵",
	ITEMANIMAL_EARSDESCRIPT = "根据特定的野兽特征塑造，一双这样的耳朵可以欺骗没有经验的观众。虽然它们并不能像你预期的那样移动，但第二对通常会暴露真相。",
	ITEMTAIL_PLUG = "尾塞",
	ITEMTAIL_PLUGDESCRIPT = "一条类似猫的尾巴，通常与野兽类有关，但除非被拉动，否则它缺乏反应能力...",
	ITEMANIMAL_GLOVES = "动物手套",
	ITEMANIMAL_GLOVESDESCRIPT = "一副看起来像爪子的手套。在体力劳动中非常不便，但在某些爱好者中仍然很受欢迎。",
	ITEMPET_SUIT = "宠物套装",
	ITEMPET_SUITDESCRIPT = "一种经常用于亲密游戏的宠物套装。以机动性为代价，让穿着者更可爱。",
	ITEMSHACKLES = "锁链",
	ITEMSHACKLESDESCRIPT = "给危险人员的重型链条。",
	ITEMCHASTITY_BELT = "贞操带",
	ITEMCHASTITY_BELTDESCRIPT = "一种设计用来保持佩戴者生殖器贞洁的工具。",
	ITEMSTIMULATIVE_UNDERWEAR = '性感内衣',
	ITEMSTIMULATIVE_UNDERWEARDESCRIPT = "特别设计的内衣，能唤起穿着者的欲望，使他们更加饥渴。",
	ITEMTENTACLE_SUIT = '触手服',
	ITEMTENTACLE_SUITDESCRIPT = "活体服装，从内部刺激穿着者。",
	ITEMANAL_BEADS = "拉珠",
	ITEMANAL_BEADSDESCRIPT = "一串球。专为后部使用而设计。",
	ITEMANAL_PLUG = "肛门塞",
	ITEMANAL_PLUGDESCRIPT = "一块塞子形状的木头。专为后部使用而设计。 ",
	ITEMSTRAPON = "假阳具",
	ITEMSTRAPONDESCRIPT = "允许女孩冒充男孩，但只能在床上。 ",
	ITEMOFFHAND_BOOK = "魔法书",
	ITEMOFFHAND_BOOKDESCRIPT = "一件稀有而珍贵的魔法物品。它包含强大的魔法和知识，可以极大地帮助任何冒险者进行探索。",

	ITEMAPHRODISIAC = "春药",
	ITEMAPHRODISIACDESCRIPT = "一种能激发人内心欲望的烈性药剂。\n\n在性互动中增强角色性欲。 ",
	ITEMALCOHOL = "威士忌",
	ITEMALCOHOLDESCRIPT = "一种由各种谷物制成的简单的烈性饮料。\n\n在正常消费时提高服从性。改善性交过程中的性欲和敏感度，但会被较弱的身体所排斥。",
	ITEMBEER = "啤酒",
	ITEMBEERDESCRIPT = "众神的甘露。\n\n在正常消费时提高服从性。改善性交过程中的性欲和敏感度。",
	ITEMTAMEDRUG = "驯服药",
	ITEMTAMEDRUGDESCRIPT = "驯服因素+1-2。胆怯因素+1-2。机智因素-1。",
	ITEMRAGEDRUG = "狂怒药",
	ITEMRAGEDRUGDESCRIPT = "驯服因素-1-2。机智因素-1-2。物理因素+1。",
	ITEMSEXDRUG = "性感药",
	ITEMSEXDRUGDESCRIPT = "物理因素-1。机智因素-1。性因素设置为6。欲望最大化。",

	ITEMHEALPOT = "健康药水",
	ITEMHEALPOTDESCRIPT = "恢复一些健康。可以在战斗中使用。",
	ITEMMANAPOT = "魔力药水",
	ITEMMANAPOTDESCRIPT = "恢复一些魔力。可以在战斗中使用。",

	ITEMLIFESHARD = "生命碎片",
	ITEMLIFESHARDDESCRIPT = "一种具有治疗作用的石头。使用后可治愈20-25点的健康。",
	ITEMLIFEGEM = "生命宝石",
	ITEMLIFEGEMDESCRIPT = "一种具有治疗作用的贵重石头。使用后可治愈45-55点的健康。",
	ITEMENERGYSHARD = "能量碎片",
	ITEMENERGYSHARDDESCRIPT = "一块充满神奇能量的石头。使用时恢复20-25点魔力。",
	ITEMENERGYGEM = "能量宝石",
	ITEMENERGYGEMDESCRIPT = "一块充满魔力的石头。使用时恢复50-65的魔力。",
	ITEMSPARKLINGPOWDER = "闪耀尘",
	ITEMSPARKLINGPOWDERDESCRIPT = "主要由生命碎片组成的一小撮灰尘。为所有友方单位治愈25-35点健康。",
	ITEMREVITALIZER = "复苏剂",
	ITEMREVITALIZERDESCRIPT = "具有大量生命能量的强大精华。复活死亡的角色，使其拥有20%的最大健康值。",
	ITEMWRIT_OF_EXEMPTION = "豁免令状",
	ITEMWRIT_OF_EXEMPTIONDESCRIPT = "一份官方文件，其中载有使一个人免于奴役的所有必要条件。它有所有必需的印章，只缺少一个名字...\n\n无法应用于唯一角色。",
	ITEMSTRONG_PHEROMONES = "强信息素",
	ITEMSTRONG_PHEROMONESDESCRIPT = "一种常用于兽人种族的药物。吸气会导致一个人的欣快感和欲望激增，使他们接受任何他们通常会害羞而不敢考虑的对待。对非兽人物种无效，在受影响的群落中经常被禁止。 ",
	ITEMSOUL_STONE = "灵魂石",
	ITEMSOUL_STONEDESCRIPT = "允许删除一个固有的性格特征。",
	ITEMLACTATION_POT = """Nursing Potion""", # MISSING TRANSLATION
	ITEMLACTATION_POTDESCRIPT = """Make the drinker lactate, or reverse lactation if it existed.""", # MISSING TRANSLATION
	ITEMPHYSICS_POT = """Elixir of Ogre's Strength""", # MISSING TRANSLATION
	ITEMPHYSICS_POTDESCRIPT = """Boosts Physics by 80 for 1 time period.""", # MISSING TRANSLATION
	ITEMWITS_POT = """Elixir of Expanded Mind""", # MISSING TRANSLATION
	ITEMWITS_POTDESCRIPT = """Boosts Wits by 80 for 1 time period.""", # MISSING TRANSLATION
	
	ITEMSENSITIVITY_POT = "敏感性药物",
	ITEMSENSITIVITY_POTDESCRIPT = "在性交中提高敏感度。",
	ITEMOBLIVION_POTION = "遗忘药剂",
	ITEMOBLIVION_POTIONDESCRIPT = "删除所有已学习的课程。",
	ITEMMAID_DRESS = "女仆装",
	ITEMMAID_DRESSDESCRIPT = "一种常见的女性仆人服装。激发服从，吸引眼球。",
	ITEMMAID_HEADBAND = "女仆头带",
	ITEMMAID_HEADBANDDESCRIPT = "一种简单的头饰，用来保持头发的形状，通常由下层仆人佩戴。",
	ITEMLACY_UNDERWEAR = "蕾丝内衣",
	ITEMLACY_UNDERWEARDESCRIPT = "漂亮的内衣，常与上流社会女士联系在一起。",
	ITEMSEETHROUGH_UNDERWEAR = "透明内衣",
	ITEMSEETHROUGH_UNDERWEARDESCRIPT = "在猥亵活动中相当流行的一件昂贵的衣服。由魔力布料编织而成，不仅触感极佳，而且经久耐用。",
	ITEMWORKER_OUTFIT = "工人服装",
	ITEMWORKER_OUTFITDESCRIPT = "普通的工作服，不限制运动，为穿着者保暖。",
	ITEMCRAFTSMAN_SUIT = "工匠套装",
	ITEMCRAFTSMAN_SUITDESCRIPT = "高级服装，旨在帮助制作材料。",
	ITEMHANDCUFFS = "手铐",
	ITEMHANDCUFFSDESCRIPT = "一副皮革手铐，用来限制佩戴者的行动。尽管考虑到它们的目的，但仍然可以被认为穿着有些舒适。 ",

	ITEMWORKER_GLOVES = "工人手套",
	ITEMGAUNTLETS = "护手",
	ITEMCIRCLET = "头环",
	ITEMCROWN = "苍白皇冠",
	ITEMBELL_COLLAR = "喇叭口领",
	ITEMRIBBON = "带子",
	ITEMWORKER_GLOVESDESCRIPT = "一副适合艰苦劳动的厚手套。最好在卧室前把这些脱掉",
	ITEMGAUNTLETSDESCRIPT = "一种由坚固的金属制成的手套，用于保护手。通常不适合色情角色扮演",
	ITEMCIRCLETDESCRIPT = "精心制作的金属饰品，增强佩戴者的魔力。",
	ITEMCROWNDESCRIPT = "一顶来历不明的旧王冠",
	ITEMBELL_COLLARDESCRIPT = "尽管它的本质，这种衣领仍然被认为更像是来自遥远国度的时尚对象。",
	ITEMRIBBONDESCRIPT = "一条鲜红色的丝带，性质不明。 ",
	
	ITEMSACRED_BOWL = "圣钵",
	ITEMSACRED_BOWLDESCRIPT = "一种古代的神器，曾经属于精灵王国。",
	
	ITEMJACKET = "夹克",
	ITEMJACKETDESCRIPT = "轻便的衣服，不提供任何保护。",
	ITEMENSLAVING_COLLAR = "奴隶项圈",
	ITEMENSLAVING_COLLARDESCRIPT = "神奇的奴隶项圈，慢慢地修补穿着者的意志。",
	ITEMEARRINGS = "耳环", 
	ITEMEARRINGSDESCRIPT = "一对别致的珠宝。", 
	ITEMAIRE_BOW = "翡翠心弦",
	ITEMAIRE_BOWDESCRIPT = "一把强大的弓箭，似乎是精灵制造的。",
	ITEMWITCH_HAT = "巫师帽",
	ITEMWITCH_HATDESCRIPT = "一顶具有魔力的经典帽子。",
	ITEMZEPHYRA_BRUSH = "狐尾笔",
	ITEMZEPHYRA_BRUSHDESCRIPT = "一把神秘的画笔，它的笔豪有点像狐狸的尾巴...据传狐尾拥有神秘的力量，只需轻轻一弹就可以创造奇迹。\n\n施法有25%的几率再施一次。",
	
	
	#Items
	ITEMAXE = "斧头",
	ITEMPICKAXE = "镐",
	ITEMSWORD = '剑',
	ITEMDAGGER = '匕首',
	ITEMCLUB = "棍棒",
	ITEMMACE = """Mace""", # MISSING TRANSLATION
	ITEMBATTLEAXE = """Battle Axe""", # MISSING TRANSLATION
	ITEMSPEAR = "矛",
	ITEMBOW = "弓",
	ITEMCROSSBOW = """Crossbow""", # MISSING TRANSLATION
	ITEMSTAFF = "杖",
	ITEMSICKLE = "镰刀",
	ITEMFISHINGTOOLS = "渔具",
	ITEMHAMMER = "锻锤",
	ITEMHUNT_KNIFE = "猎刀",
	ITEMSHIELD = "盾",


	ITEMAXEDESCRIPT = '斧头可以用来砍柴和作战。',
	ITEMSWORDDESCRIPT = "适合对付无装甲的敌人。",
	ITEMDAGGERDESCRIPT = "易于隐藏的廉价武器，任何人都可以使用。",
	ITEMCLUBDESCRIPT = "你祖先的武器。不出众，但制作简单，任何人都可以持有。",
	ITEMMACEDESCRIPT = """The club's older brother. A better alternative when have to deal with armored target.""", # MISSING TRANSLATION
	ITEMBATTLEAXEDESCRIPT = """The best weapon to carry if you wanna look intimidating. However its somewhat unwieldy.""", # MISSING TRANSLATION
	ITEMSPEARDESCRIPT = "人类已知的最早的武器之一。没有剑那么灵活，但它有它的优点... 主要是成本。",
	ITEMPICKAXEDESCRIPT = "矿工们不可替代的工具。",
	ITEMBOWDESCRIPT = "适合远距离战斗的简单武器。",
	ITEMCROSSBOWDESCRIPT = """An unrefined mechanical weapon offering better penetration properties than a bow.""", # MISSING TRANSLATION
	ITEMSTAFFDESCRIPT = "一个简单的法术工具。",
	ITEMSICKLEDESCRIPT = "一种用于收割庄稼的工具。",
	ITEMFISHINGTOOLSDESCRIPT = "渔民使用的一套工具。",
	ITEMHAMMERDESCRIPT = "一个为铁匠和建设者设计的工具。",
	ITEMHUNT_KNIFEDESCRIPT = "猎手使用的一套工具。",

	ITEMBASICCHEST = "胸甲",
	ITEMROBE = "长袍",
	ITEMHOOD = "兜帽",
	ITEMSHOES = "鞋子",
	ITEMBASICCHESTDESCRIPT = "提供基本的身体保护。",
	ITEMBASICHELM = "头盔",
	ITEMBASICHELMDESCRIPT = "提供基本的头部保护。",
	ITEMBASICBOOTS = "靴子",
	ITEMBASICBOOTSDESCRIPT = "提供基本足部保护",
	ITEMBASICGLOVES = "手套",
	ITEMBASICGLOVESDESCRIPT = "提供基本的手部保护",

	ITEMCHEST_BASE_CLOTH = "轻型装甲",
	ITEMCHEST_BASE_LEATHER = "中型装甲",
	ITEMCHEST_BASE_METAL = "重型装甲",
	ITEMLEGS_BASE_CLOTH = "轻型腿甲",
	ITEMLEGS_BASE_LEATHER = "中型腿甲",
	ITEMLEGS_BASE_METAL = "重型腿甲",

	ITEMCHEST_BASE_CLOTHDESCRIPT = "任何人都可以穿的轻型盔甲。提供合理的保护抵抗法术类型的伤害。",
	ITEMCHEST_BASE_LEATHERDESCRIPT = "由骨头或皮革组装而成的盔甲，需要经过一些训练才能舒适地使用。",
	ITEMCHEST_BASE_METALDESCRIPT = "一种通常由金属制成的重型盔甲。提供强大的技能伤害保护。",
	ITEMLEGS_BASE_CLOTHDESCRIPT = "一种轻便的腿甲，任何人都可以穿。提供合理的保护抵抗法术类型的伤害。",
	ITEMLEGS_BASE_LEATHERDESCRIPT = "由骨头或皮革组装而成的腿甲，需要经过一些训练才能舒适地使用。",
	ITEMLEGS_BASE_METALDESCRIPT = "一种通常由金属制成的较重的腿甲。提供强大的技能伤害保护。",

	#gearclasses
	GEARSWORD = "剑",
	GEARAXE = "斧子",
	GEARSTAFF = "杖",
	GEARBOW = "弓",
	GEARPICKAXE = "镐",

	#Stats
	DAMAGE = 'ATK',
	DAMAGEMOD = "攻击 Mult.",
	ARMOR = 'DEF',
	MDEF = "MDEF",
	EVASION = '闪避',
	HITRATE = '命中率',
	HEALTH = '健康',
	DURABILITY = "耐久",
	DURABILITYMOD = "坚固因素",
	ARMORPENETRATION = "穿甲",
	RESISTFIRE = "火抗性",
	RESISTEARTH = "地抗性",
	RESISTAIR = "风抗性",
	RESISTWATER = "水抗性",
	HEALTHPERCENT = "最大健康",
	MANAPERCENT = "最大魔力",
	CRITICAL = "临界",
	CRITCHANCE = "暴击率",
	CRITMOD = "暴击伤害",
	LEVELUP = "升级",
	MAXLEVEL = "最大等级",
	DUNGEONLEVEL = """Level""", # MISSING TRANSLATION
	LEVELUPTEXT = " 刚刚获得一个等级。选择一个新特性解锁",
	TASKCRITCHANCE = "工作临界机会",
	TASKEFFICIENCYTOOL = "工作效率奖金",
	TOOLWORKCATEGORY = "工具",
	
	QUESTCOMPLETETASK = "完成一次性任务",
	
	#stat tooltips
	TOOLTIPDAMAGE = "定义技能和法术的伤害输出",
	TOOLTIPARMOR = "减少该百分比的技能伤害",
	TOOLTIPMDEF = "减少该百分比的法术伤害",
	TOOLTIPCRIT = "暴击造成额外伤害的几率百分比。\n第一个值是几率。第二个值是修改值。",
	TOOLTIPHITRATE = "命中目标的几率百分比。\n由于敌人的闪避而减少",
	TOOLTIPARMORPEN = "减少敌人的护甲值",
	TOOLTIPEVASION = "将敌人的命中几率降低此值",
	TOOLTIPSPEED = "提高你在其他角色之前行动的几率",
	TOOLTIPRESISTS = "通过抵抗减少对应元素伤害",
	TOOLTIPSTAMINA = """Stamina is depleted when performing action the character does not agree on. When fully depleted such actions will drain Obedience. Also when fully depleted the character won't be able to improve their Consent. Stamina is replenished with Orgasms but this is affected by diminishing returns.""", # MISSING TRANSLATION
	TOOLTIPSTAMINADUNGEON = """Exploration Stamina is depleted every time you take an exploration action. It will be fully replenished at the start of new day.""", # MISSING TRANSLATION

	TOOLTIPFOODCONSUMPTION = "Daily Food Consumption",
	TOOLTIPPOPULATION = "Population",
	TOOLTIPPROGRESSREQUIRED = "Work Units required",
	TOOLTIPSAVECHARACTER = "Save Character Template",
	TOOLTIPLOADCHARACTER = "Load Character Template",
	TOOLTIPSKIPPROLOGUE = "Skips prologue quests and starts first story arc. The loan mission is disabled. ",
	
	TOOLTIPSKILLPOINTS = "Skill Points are earned from battles and are used to purchase new combat skills.",
	

	SAVENAME = "存档名称",
	SAVETEMPLATEDESCRIPT = "您可以保存现有的角色模板以供重复使用。",

	#Item Parts
	TOOLHANDLE = '工具手柄',
	WEAPONHANDLE = '武器手柄',
	BLADE = '刀片',
	TOOLBLADE = "工具刀片",
	TOOLCLOTHWORK = "布制品",
	ROD = '杆子',
	BOWBASE = '弓肢',
	SHIELDBASE = "底座",
	ARMORBASE = '底座',
	ARMORPLATE = '平板',
	ARMORTRIM = '装饰',
	JEWELRYGEM = '宝石',
	WEAPONMACE = "武器头",



	#Menu
	NEWGAME = "新游戏",
	LOAD = '读取',
	OPTIONS = '设置',
	QUIT = '退出',
	CLOSE = "关闭",
	PROCEED = "继续",
	SELECTHERO = "选择英雄",
	SOUND = "声音",
	MUSIC = "音乐",
	MASTERSOUND = "总音量",
	MUTE = "静音",
	AUDIO = "音效",

	TEXTSPEED = "文本速度",
	SKIPREAD = "跳过读取",

	CURRENTFOOD = "当前食物",
	GAINFOOD = "食物价值",
	FOODCONVERT = "转换食物",

	#System
	CONFIRM = "Confirm",
	FRONT = "正面",
	BACK = "返回",
	CANCEL = "取消",
	UNLOCK = "解锁",
	YES = "是",
	NO = "否",
	REMOVE = "删除",
	NONE = "无",
	SPEED = "速度",
	DAY = "日期",
	ENERGY = "能量",
	TIME = "时间",
	CRAFT = "工艺",
	BLACKSMITH = "铁匠",
	PROGRESS = "进度",
	LEVELS = "等级",
	STAGE = "阶段",
	REPAIR = "修复",
	REPAIRALL = "全部修复",
	WORKERNOENERGY = " 没有剩余能量，已停止工作。",
	TOOLBROKEN = " 已损坏",
	CURRENTTASK = "当前任务",
	REQUIREDMATERIAL = "所需材料",
	REQUIREDMATERIALS = "所需材料",
	SELECTREPAIR = "选择需要修复的项目",
	TOTALPRICE = "总价",
	SELECTMATERIAL = "为所有零件选择材料",
	INPOSESSION = "占有",
	BASECHANCE = "基本机会",
	CANTREPAIREFFECT = "此项目无法修复",
	NOTENOUGH = "不够",
	ITEMCREATED = "已创建项目",
	UPGRADEUNLOCKED = "升级解锁",
	MAINQUEST = "主线任务",
	SIDEQUESTS = "支线任务",
	MAINQUESTUPDATED = "主线任务已更新",
	QUESTLOG = "任务日志",
	NOACTIVEQUESTS = "您没有已激活任务",
	CLASSREQS = "要求",
	INVALIDREQS = "未满足要求",
	REQSNONE = "无",
	NOTENOUGHGOLD = "金币不足",
	PURCHASETHISTRAIT = "购买此特征",
	TRAITPOINTSCOST = "特质点数",
	TRAITPOINTS = "使用的特质点数",
	GOLDPRICE = "金币成本",
	CLASSBONUS = "奖金",
	EXPREQUIRED = "需要经验",
	NOFITTINGITEMS = "您没有配件项目",
	TRAITUNKNOWN = "未知",
	TRAITUNKNOWNTOOLTIP = "你还不知道这个特点。需要更好地了解 [name] 。",
	NOTALLTRAITSLEARNED = "您不知道[name]的所有偏好。在分配活动偏好之前先了解它们。",
	SYSNOFOOD = "工作取消：没有食物",
	SYSNOWORKERENERGY = "工作取消：没有能量",
	DIALOGUEREPEATACTION = "重复",
	CHAR_UNAVALIABLE = "不可用",
	NO_FREE_SLOTS = "此任务已无可用插槽",
	ANOTHERPROFSELECTED = """Can only select one specialization.""", # MISSING TRANSLATION

	LOGREPORTPREGNANCY = "[name] 告诉你，[he]似乎怀孕了。",
	LOGREPORTPREGNANCYMASTER = "看来你([name])怀孕了。",

	SELECT = "选择",
	SELECTTOOL = "选择工具",
	SELECTWORKER = "选择工人",
	SELECTITEM = "选择项目",
	WORKERLIMITREACHER = "达到工人限制：升级房屋以增加",
	TOTALWORKERS = "工人总数",

	TUTORIAL = "教程",
	TRAITS = "特征",
	CLASSINFO = "课程详情",
	CLASSSTATCHANGES = "统计变化",

	INVENTORY = "库存",
	WORKERLIST = "工作人员列表",
	HEROLIST = "英雄名单",
	OPTIONMENU = "设置",

	INVENTORYALL = "所有项目",
	INVENTORYWEAPON = "武器",
	INVENTORYARMOR = "装甲",
	INVENTORYMATERIAL = "材料",
	INVENTORYCOSTUME = "服装",
	INVENTORYUSE = "消耗品",
	INVENTORYTOOL = "工具",
	INVENTORYQUEST = "其他",
	SELLCONFIRM = "卖",
	RAWPRICE = "原始价格",
	FOODDESCRIPT = "食物是用来喂养工人的 ",
	MONEYDESCRIPT = "金钱用于购买商品和工人",

	AREAISENDLESS = "该区域没有进展",
	TOWNRETURN = "返回",
	RETURN = "返回",

	#Confirms

	LEAVECONFIRM = "进入主菜单？未保存的进度将丢失。 ",
	LOADCONFIRM = "是否加载此保存文件？",
	OVERWRITECONFIRM = "是否覆盖此保存文件？",
	DELETECONFIRM = "是否删除此保存文件？",
	STOPTASKCONFIRM = "是否停止此作业？",
	SLAVEREMOVECONFIRM = "是否开除该员工？",

	OVERWRITETEMPLATECONFIRM = "是否覆盖此模板？",
	DELETETEMPLATECONFIRM = "是否删除此模板？",
	LOADTEMPLATECONFIRM = "加载此模板？当前设置将丢失。",
	CURSEUNEQUIPCONFIRM = """Cursed equipment is destroyed when removed.""", # MISSING TRANSLATION

	#Inbuilt Tooltips
	PAUSEBUTTONTOOLTIP = '暂停\n热键：1',
	NORMALBUTTONTOOLTIP = '正常速度\n热键：2',
	FASTBUTTONTOOLTIP = '快速\n热键：3',
	
	
	QUESTPARTREQUIREMENTS = "零件要求",
	QUESTCOMPLETEQUESTLOC = "完成任务地牢",
	QUESTCOMPLETEQUESTLOC2 = "在完成任务地牢",
	QUESTREQUIRED = "必需",
	QUESTSLAVEREQUIRED = "奴隶需求",
	QUESTSTATS = "属性",
	QUESTSEX = "性",
	QUESTWORKDURATION = "工作持续时间",
	QUESTDAYS = "日期",
	QUESTONETIMETASK = "完成一次性任务",
	QUESTGOLDREWARD = "金币奖励将根据最终物品价值确定。",
	QUESTMASTERCHARMBONUS = "主人魅力奖金",
	QUESTGOLD = "金币",
	QUESTREPUTATION = "声誉",
	QUESTTASKACQ = "所需任务",
	REQUIREMENTSARENTMET = "未满足要求",
	NOTENOUGHLOYALTY = "不够忠诚",
	QUESTCOMPLETEMESSAGE = "任务完成",
	QUESTDAYSLEFT = "还剩几天",
	QUESTLOCATION = """Quest Location""", # MISSING TRANSLATION
	
	#Skills
	SKILLATTACK = "Attack 攻击",
	SKILLATTACKDESCRIPT = "Attacks target with equipped weapon.\n用装备的武器攻击目标。",
	SKILLRANGED_ATTACK = "Attack (ranged) 攻击（远程）",
	SKILLFIREBOLT = "Firebolt 火球术",
	SKILLFIREBOLTDESCRIPT = "Launches a fire spell at target. Deal %d Fire damage to all targets in same row.\n向目标发射火法术。对同一行的所有目标造成 %d 点火伤害。",
	SKILLWINDARROW = "Wind Arrow 风箭",
	SKILLWINDARROWDESCRIPT = "Imbues the arrow with Wind element and deal %d damage. Must have a bow equipped.\n将风元素注入箭中并造成 %d 点伤害。必须装备弓。",
	SKILLENEMY_SLASH = "Slash 猛击",
	SKILLASSASSINATEEN = """Assassinate""", # MISSING TRANSLATION
	SKILLENEMY_SLASHDESCRIPT = "Deals %d Weapon damage to all targets in nearby column. Must have a weapon equipped.\n对附近纵队的所有目标造成 %d 武器伤害。必须装备武器。",
	SKILLMINORHEAL = "Minor Heal 次要治疗",
	SKILLMINORHEALDESCRIPT = "Restore %d health of the target.\n恢复目标的 %d 健康状况。",
	SKILLCONCENTRATE = "Concentrate 冥想",
	SKILLCONCENTRATEDESCRIPT = "Restore %d of your mana.\n恢复 %d 的魔力值。",
	SKILLFIRESTORM = "Fire Storm 火焰风暴",
	SKILLFIRESTORMDESCRIPT = "Deals %d fire damage to all enemies.\n对所有敌人造成 %d 点火伤害。",
	SKILLSTRONGSHOT = "Strong Shot 劲射",
	SKILLSTRONGSHOTDESCRIPT = "Deals %d Weapon damage to target enemy and stuns for 1 turn. Must have a bow equipped.\n对目标敌人造成 %d 武器伤害并眩晕1回合。必须装备弓。",
	SKILLARROWSHOWER = "Arrow Shower 箭雨",
	SKILLARROWSHOWERDESCRIPT = "Deals %d Weapon damage to all enemies.\n对所有敌人造成 %d 武器伤害。",
	SKILLTACKLE = "Tackle 抱摔",
	SKILLTACKLEDESCRIPT = "Deals %d Physical damage and stuns target for 1 turn.\n造成 %d 物理伤害并眩晕目标1回合。",
	SKILLCRIPPLE = "Cripple 断筋",
	SKILLCRIPPLEDESCRIPT = "Deals %d Weapon damage and reduces target's damage by 33%% for 3 turns.\n造成 %d 点武器伤害，并在 3 回合内减少目标 33% 的伤害。",
	SKILLCOMBOATTACK = "Combo Attack 组合攻击",
	SKILLCOMBOATTACKDESCRIPT = "Deals 3 consecutive hits for %d Weapon damage to target.\n对目标造成连续3次命中和 %d 武器伤害。",
	SKILLDOUBLEATTACK = "Double Attack 双重攻击",
	SKILLDOUBLEATTACKDESCRIPT= "Attacks for %d damage twice.\n对目标造成两次命中和 %d 武器伤害。",

	SKILLCOMMAND = "Command 命令",
	SKILLCOMMANDDESCRIPT = "Increases target's ATK and MATK by 50% for 3 turns.\n使目标的攻击力和魔法攻击增加 50%，持续 3 回合。",
	SKILLRESTORATION = "Restoration 恢复",
	SKILLRESTORATIONDESCRIPT = "Heals a target for 250% of MATK. Reduces damage taken by 20% for 2 turns.\n以 250% 的魔法攻击治疗目标。在 2 回合内减少 20% 的伤害。",
	SKILLREJUVENATION = "Rejuvination 复兴",
	SKILLREJUVENATIONDESCRIPT = "Heals a row for 100% of MATK. Regenerates 60% of MATK each turn for 2 turns.\n以 100% 的魔法攻击治疗一行。每回合以 60% 的魔法攻击恢复健康，持续2回合。",
	SKILLSANCTUARY = "Sanctuary 避难所",
	SKILLSANCTUARYDESCRIPT = "Heals all allies for 80% of MATK. Regenerates 120% of MATK each turn for 3 turns.\n以 80% 的魔法攻击治疗所有盟友。每回合以 120% 的魔法攻击恢复健康，持续 3 回合。",
	SKILLTRAP = "Trap 陷阱",
	SKILLTRAPDESCRIPT = "Sets trap under enemy, stunning target for 2 turns. Requires 1 Trap component.\n在敌人下方设置陷阱，使目标眩晕 2 回合。需要 1 个陷阱组件。",
	SKILLWEAPON_REFINE = "Weapon Refine 武器精炼",
	SKILLWEAPON_REFINEDESCRIPT = "Increases target's ATK by 30% until end of combat.\n加目标的攻击力 30%，直到战斗结束。",
	SKILLACIDBOMB = "Acid Bomb 酸性炸弹",
	SKILLACIDBOMBDESCRIPT = "Throws Acid Bomb at a target, dealing 250% of MATK as Water damage and reducing target's armor by 25 for 4 turns. Requires 1 Unstable Concoction.\n向目标投掷酸性炸弹，造成  250% 的魔法攻击的水伤害，并在 4 回合内减少目标 25 的护甲。需要 1 个不稳定化合物。",
	SKILLFIREBOMB = "Fire Bomb 火焰炸弹",
	SKILLFIREBOMBDESCRIPT = "Throws Fire Bomb at a column, dealing 200% of MATK as Fire damage. Burns targets for 2 turns, dealing damage (50% of MATK) every turn. Requires 1 Unstable Concoction.\n向一列投掷火弹，造成 200% 的魔法攻击的火焰伤害。燃烧目标 2 回合，每回合造成 50% 的魔法攻击的伤害。需要 1 个不稳定化合物。",
	SKILLDISTRACT = "Distract 分心",
	SKILLDISTRACTDESCRIPT = "Reduces target's Hitrate and Evasion by 30 for 2 turns.\n减少目标的命中率和闪避 30 ，持续 2 回合。",
	SKILLATTRACT = "Attract 吸引",
	SKILLATTRACTDESCRIPT = "Charms target for 2 turns. Charm breaks if damage is taken.\n魅惑目标 2 回合。如果受到伤害，魅惑会被打断。",
	SKILLENTHRAL = "Enthrall 迷惑",
	SKILLENTHRALDESCRIPT = "Stuns target and self for 3 turns or until either are damaged. Only works on humanoids.\n眩晕目标和自身 3 回合或直到其中一个被击败。仅适用于类人。",
	SKILLFIRE_ATTACK = "Fire Attack 火攻击",
	SKILLFIRE_ATTACKDESCRIPT = "Deals 120% of ATK as Fire damage.\n造成 120% 的攻击力的火焰伤害。",
	SKILLDRAGONMIGHT = "Dragon's Might 龙的力量",
	SKILLDRAGONMIGHTDESCRIPT = "Increases Damage and DEF by 25% until end of battle.\n增加 25% 的伤害和防御力直到战斗结束。",
	SKILLLESSER_HEAL = "Lesser Heal 较少治疗",
	SKILLLESSER_HEALDESCRIPT = "Heals target for 130% of MATK.\n以 130% 的魔法攻击治疗目标。",
	SKILLFAIRY_HEAL = "Fairy Grace 仙精的恩典",
	SKILLFAIRY_HEALDESCRIPT = "Heals target for 50% of their maximum health.\n以其最大生命值的 50% 治疗目标。",
	SKILLENTANGLE = "Entangle 缠绕",
	SKILLENTANGLEDESCRIPT = "Deals 130% of MATK as Earth damage and stuns target for 1 turn.\n造成 130% 的魔法攻击的地伤害并眩晕目标 1 回合。",
	SKILLSERRATED_SHOT = "Serrated Shot 锯齿射击",
	SKILLSERRATED_SHOTDESCRIPT = "Deals 90% of ATK as physical damage. Causes target to bleed for 3 turns, dealing damage (90% of ATK) every turn.\n造成 90% 的攻击力的物理伤害。使目标流血3回合，每回合造成 90% 的攻击力的伤害。",
	SKILLMASS_LESSER_HEAL = "Mass Lesser Heal 多重小愈合",
	SKILLMASS_LESSER_HEALDESCRIPT = "Heals a column for 100% of MATK.\n以 100% 的魔法攻击治愈一列。",
	SKILLBLIZZARD = "Blizzard 暴雪",
	SKILLBLIZZARDDESCRIPT = "Deals 45% of MATK as Water damage to all enemies. Has 30% chance to reduce target's speed by 20. Has 50% chance to freeze target for 2 turns.\n对所有敌人造成 45% 的魔法攻击的水伤害。有30%的几率使目标的速度降低 20 。”。有 50% 的几率冻结目标 2 个回合。",
	SKILLBLESS = "Bless 祝福",
	SKILLBLESSDESCRIPT = "Increases target's ATK by 25% for 3 turns.\n使目标的攻击力增加 25% ，持续 3 回合。",
	SKILLMENTAL_BLESS = "Mental Bless 精神祝福",
	SKILLMENTAL_BLESSDESCRIPT = "Increases target's MATK by 25% for 3 turns.\n使目标的魔法攻击增加 25% ，持续 3 回合。",
	SKILLBLOOD_MAGIC = "Blood Magic 血魔法",
	SKILLBLOOD_MAGICDESCRIPT = "Sacrifices 10% of your health to convert it into mana.\n牺牲 10% 的健康值将其转化为魔力值。",
	SKILLBLOOD_EXPLOSION = "Blood Explosion 血爆术",
	SKILLBLOOD_EXPLOSIONDESCRIPT = "Damages target for 300% of MATK, damages other enemies for 50% of MATK.\n以 300% 的魔法攻击伤害目标，并以 50% 的魔法攻击伤害其他目标。",

	SKILLEARTH_ATK = "Earth Strike 大地打击",
	SKILLEARTH_ATKDESCRIPT = "Deals 125% of ATK as Earth damage. Has 30% chance to Stun target for 1 turn.\n造成 125% 的攻击力的地伤害。有 30% 的几率眩晕目标1回合。",
	SKILLWIND_ATK = "Wind Flurry 风乱舞",
	SKILLWIND_ATKDESCRIPT = "Deals 80% of ATK as Air damage to one target and random enemy.\n对一个目标和随机敌人造成 80% 的攻击力的风伤害。",
	SKILLWATER_ATK = "Water Blade 水刀",
	SKILLWATER_ATKDESCRIPT = "Deals 110% of ATK as Water damage. Causes target to bleed for 2 turns, dealing damage (30% of ATK) every turn.\n造成 110% 的攻击力的水伤害。使目标流血 2 回合，每回合造成 30% 的攻击力的伤害。",
	SKILLHOLY_ATK = "Holy Attack 神圣打击",
	SKILLHOLY_ATKDESCRIPT = "Deals 120% of ATK as Light damage. Has 20% chance to Confuse target.\n造成 120% 的攻击力的光伤害。有 20% 的几率迷惑目标。",
	SKILLFIRE_CLEAVE = "Fire Cleave 火切割",
	SKILLFIRE_CLEAVEDESCRIPT = "Deals 70% of ATK as Fire damage to a column. Has 20% chance to burn target for 2 turns, dealing damage (20% of ATK) every turn.\n对一列造成 70% 的攻击力的火焰伤害。有 20% 的机会燃烧目标 2 回合，每回合造成 20% 的攻击力的伤害。",
	SKILLEARTH_SHATTER = "Earth Shatter 大地破碎",
	SKILLEARTH_SHATTERDESCRIPT = "Deals 60% of ATK as Earth damage to all enemies. Reduces evasion by 25 for 2 turns.\n对所有敌人造成 60% 的攻击力的地伤害。减少25点闪避，持续 2 回合。",
	SKILLREVENGE = "Revenge 复仇",
	SKILLREVENGEDESCRIPT = "Deals high physical damage based on missing health.\n基于健康值缺失造成高额物理伤害。",
	SKILLFIRE_BURST = "Fire Burst 火爆炸",
	SKILLFIRE_BURSTDESCRIPT = "Deals 50% of MATK as Fire damage to all enemies. Reduces target's hit chance by 20 for 3 turns.\n对所有敌人造成 50% 的魔法攻击的火焰伤害。减少目标 20 的命中几率，持续 3 回合。",
	SKILLAIR_CUTTER = "Air Cutter 真空斩",
	SKILLAIR_CUTTERDESCRIPT = "Deals 85% of ATK as Air damage to one target and 2 random enemies. Has 50% chance to cause targets to bleed for 2 turns, dealing damage (20% of ATK) every turn.\n对一个目标和两个随机敌人造成 85% 的攻击力的风伤害。有 50% 的机会使目标流血 2 回合，每回合造成 20% 的攻击力的伤害。",
	SKILLHOLY_LANCE = "Holy Lance 圣枪",
	SKILLHOLY_LANCEDESCRIPT = "Deals 100% of ATK as Light damage to a row.\n对一行造成 100% 的攻击力的光伤害。",
	SKILLSWIPE = "Swipe 横扫",
	SKILLSWIPE_EN = "Swipe 横扫",
	SKILLSWIPEDESCRIPT = "Deals 70% of ATK as Air damage to a column. Has 30% chance to reduce target's DEF by 20 for 2 turns.\n对一列造成 70% 的攻击力的风伤害。有 30% 的机会在 2 回合内减少目标的防御力 20 。",
	SKILLARROWRAIN = "Arrow Rain 水箭",
	SKILLARROWRAINDESCRIPT = "Deals 65% of ATK as Water damage to a column. Has 30% chance to reduce target's MDEF by 20 for 2 turns.\n对一列造成 65% 的攻击力的水伤害。有 30% 的机会减少目标的魔法防御 20，持续 2 回合。",
	SKILLEXPLOSIVEARR = "Explosive Arrow 爆炸箭",
	SKILLEXPLOSIVEARRDESCRIPT = "Deals 130% of ATK as Fire damage to a target. Burns target for 2 turns, dealing damage (25% of ATK) every turn.\n对目标造成 130% 的攻击力的火焰伤害。燃烧目标 2 回合，每回合造成 25% 的攻击力的伤害。",
	SKILLSHADOWSTRIKE = "Shadow Strike 暗影突袭",
	SKILLSHADOWSTRIKEDESCRIPT = "Deals 130% of ATK as Dark damage to a target. Reduces target's ATK and MATK by 20 for 2 turns.\n对目标造成 130% 的攻击力的黑暗伤害。减少目标的攻击力和魔法攻击 20 ，持续 2 回合。",
	SKILLFIREARR = "Fire Arrow 火箭",
	SKILLFIREARRDESCRIPT = "Deals 120% of MATK as Fire damage. Has 50% chance to burn target for 2 turns, dealing damage (20% of MATK) every turn.\n造成 120% 的魔法攻击的火焰伤害。有 50% 的机会燃烧目标2回合，每回合造成 20% 的魔法攻击的伤害。",
	SKILLLIGHTNING = "Lightning 闪电",
	SKILLLIGHTNINGDESCRIPT = "Deals 125% of MATK as Air damage to a target. Stuns target for 1 turn.\n对目标造成 125% 的魔法攻击的风伤害。眩晕目标1回合。",
	SKILLMINDBLAST = "Mind Blast 心灵冲击",
	SKILLMINDBLASTDESCRIPT = "Deals 120% of MATK as Mind damage to a target.\n对目标造成 120% 的魔法攻击的精神伤害。",
	SKILLPSYCHICBLAST = "Psychic Blast 精神冲击",
	SKILLPSYCHICBLASTDESCRIPT = "Deals 65% of MATK as Mind damage to a column.\n对一列造成 65% 的魔法攻击的精神伤害。",
	SKILLRESURRECT = "Resurrect 复活",
	SKILLRESURRECTDESCRIPT = "Resurrects target ally at 40% of maximum health.\n以最大健康值的 40% 复活目标盟友。",
	SKILLDECAY = "Decay 衰败",
	SKILLDECAYDESCRIPT = "Deals 65% of MATK as Dark damage to all enemies.\n对所有敌人造成 65% 的魔法攻击的黑暗伤害。",
	SKILLOVERGROWTH = "Overgrowth 过度生长",
	SKILLOVERGROWTHDESCRIPT = "Deals 45% of MATK as Earth damage to all enemies.\n对所有敌人造成 45% 的魔法攻击的地伤害。",
	SKILLFIRST_AID = "First Aid 急救",
	SKILLFIRST_AIDDESCRIPT = "Heals ally for 30% of maximum health. Requires 1 Bandage to use.\n治疗目标最大健康值的 30% 。需要 1 条绷带才能使用。",
	SKILLLIGHT_SPELL = "Holy Light 圣光",
	SKILLLIGHT_SPELLDESCRIPT = "Deals 100% of MATK as Light damage to a target.\n对目标造成 100% 的魔法攻击的光伤害",
	SKILLLIGHT_SPELL_AOE = "Divine Radiance 神圣光辉",
	SKILLLIGHT_SPELL_AOEDESCRIPT = "Deals 30% of MATK as Light damage to all enemies. Reduces MDEF by 20 for 3 turns.\n对所有敌人造成 30% 的魔法攻击的光伤害。减少 20 点魔法防御，持续 3 回合。",

	SKILLENDURE = "Endure 忍耐",
	SKILLENDUREDESCRIPT = "Increases all resistances by 20% for 2 turns.\n将所有抵抗增加 20% ，持续 2 回合。",
	SKILLMIRROR_IMAGE = "Mirror Image 镜像",
	SKILLMIRROR_IMAGEDESCRIPT = "Buffs All Allies: 25% chance to avoid any ability damage for 2 turns (except Mind). Replaces Energy Field.\n增益所有盟友：25% 的几率在 2 回合内避免任何能力伤害（精神除外）。替换能量场。",
	SKILLENERGY_FIELD = "Energy Field 能量场",
	SKILLENERGY_FIELDDESCRIPT = "Buffs All Allies: When taking damage, deals 40% of caster's MATK as Air damage to attacker. Replaces Mirror Image.\n增益所有盟友：受到伤害时，对攻击者造成 40% 的施法者魔法攻击的风伤害。替换镜像。",
	SKILLPROTECTIVE_SHELL = "Protective Shell 保护壳",
	SKILLPROTECTIVE_SHELLDESCRIPT = "Buffs Ally column: Reduce incoming damage by 35% for next 3 attacks.\n增益一列盟友：在接下来的 3 次攻击中减少 35% 的所受伤害。",
	SKILLHAMMERFALL = "Hammerfall 锤击",
	SKILLHAMMERFALLDESCRIPT = "Deals 150% of ATK as physical damage to a target. Stuns target for 2 turns.\n对目标造成 150% 的攻击力的物理伤害。眩晕目标 2 回合。 ",
	SKILLPURGE = "Purge 净化",
	SKILLPURGEDESCRIPT = "Removes all negative buffs from target.\n从目标移除所有减益。",
	SKILLRIGHTEOUS_FIRE = "Righteous Fire 正义之火",
	SKILLRIGHTEOUS_FIREDESCRIPT = "Deals 75% of MATK as Fire damage. Silences target for 2 turns.\n造成 75% 的魔法攻击的火焰伤害。使目标沉默 2 回合",
	SKILLELEMENTAL_WEAKNESS = "Elemental Weakness 元素弱点",
	SKILLELEMENTAL_WEAKNESSDESCRIPT = "Reduces target's Fire, Air, Earth and Water resists by 40 for 3 turns.\n减少目标对火、风、地和水的抵抗力 40，持续 3 回合。",
	SKILLELEMENTAL_PROTECTION = "Elemental Protection 元素保护",
	SKILLELEMENTAL_PROTECTIONDESCRIPT = "Increases target's Fire, Air, Earth and Water resists by 25 for 3 turns.\n增加目标对火、风、地和水的抵抗 25，持续 3 回合。",
	SKILLTAUNT = "Taunt 嘲讽",
	SKILLTAUNTDESCRIPT = "Forces all enemies to focus on caster.\n迫使所有敌人攻击集中在施法者身上。",
	SKILLCAMOUFLAGE = "Camouflage 伪装",
	SKILLCAMOUFLAGEDESCRIPT = "Buffs All Allies: +20 Evasion for 2 turns.\n增益所有盟友：+20 躲避 2 回合。",
	SKILLREINCARNATE = "Reincarnate 转世",
	SKILLREINCARNATEDESCRIPT = "Reinforces Spirit of an Ally. When HP reach zero, restore it to full.\n强化盟友精神。当健康值为零时，将其恢复为满。",
	SKILLHUNTERSMARK = "Hunter's Mark 猎人标记",
	SKILLHUNTERSMARKDESCRIPT = "Marked enemy takes 15% more damage for 3 turns.\n被标记的敌人在 3 回合内受到 15% 的额外伤害。",
	SKILLBARD1 = "Hymn 赞美诗",
	SKILLBARD1DESCRIPT = "Buffs ally row: Increase Hitrate, Evasion and Speed by 20 for 4 turns. Cancels other Song Effects.\n增益一排盟友：增加命中率、闪避和速度 20 ，持续 4 回合。取消其他歌曲效果。",
	SKILLBARD2 = "Soothe 抚慰歌",
	SKILLBARD2DESCRIPT = "Buffs ally row: Increase DEF and MDEF by 15, dispel 1 negative effect every turn. Lasts 4 turns. Cancels other Song Effects.\n增益一排盟友：增加防御力和魔法防御 15，每回合消除 1 个负面效果。持续 4 回合。取消其他歌曲效果。",
	SKILLBARD3 = "Warmarch 行军曲",
	SKILLBARD3DESCRIPT = "Buffs ally row: Increase ATK and MATK by 20% for 4 turns. Cancels other Song Effects.\n增益一排盟友：增加攻击力和魔法攻击 20%，持续 4 回合。取消其他歌曲效果。",
	SKILLSPIRIT1 = "Spirit: Hare 精神：兔子",
	SKILLSPIRIT1DESCRIPT = "Buffs ally target: +30 speed, +25 evasion until end of combat. Cancels other Spirit Effects.\n增益盟友目标：+30 速度，+25 闪避，直到战斗结束。取消其他精神效果。",
	SKILLSPIRIT2 = "Spirit: Turtle 精神：乌龟",
	SKILLSPIRIT2DESCRIPT = "Buffs ally target: -25% Skill Damage taken, -15% Spell Damage taken until end of combat. Cancels other Spirit Effects.\n增益盟友目标：承受-25% 的技能伤害，承受-15% 的法术伤害，直到战斗结束。取消其他精神效果。",
	SKILLSPIRIT3 = "Spirit: Eagle 精神：鹰",
	SKILLSPIRIT3DESCRIPT = "Buffs ally target: +20% Skill Damage dealt, +30 Hitrate until end of combat. Cancels other Spirit Effects.\n增益盟友目标：造成+20% 的技能伤害，+30 命中率，直到战斗结束。取消其他精神效果。",
	SKILLDEVOUR = "Devour Spirit 吞噬灵魂",
	SKILLDEVOURDESCRIPT = "Debuffs enemy target: when target dies, caster restores 20% of max MP.\n减益敌方目标：当目标死亡时，施法者恢复 20% 的最大魔力值。",
	SKILLEARTHQUAKE = "Earthquake 地震",
	SKILLEARTHQUAKEDESCRIPT = "Deals 40% of MATK as Earth damage to all enemies for 3 turns.\n对所有敌人造成 40% 的魔法攻击的地伤害，持续 3 回合。",
	SKILLEARTHQUAKE_GLOB = "Earthquake 地震",
	SKILLL_ORB = "Lightning Orb 球状闪电",
	SKILLL_ORBDESCRIPT = "Deals 250% of MATK as Air damage to a target. If target survives, deals half of the damage to random enemy.\n对目标造成 250% 的魔法攻击的风伤害。如果目标幸存，对随机敌人造成一半的伤害。",
	SKILLSNIPER_SHOT = """Ensnaring Shot""", # MISSING TRANSLATION
	SKILLSNIPER_SHOTDESCRIPT = """Deals 110% of ATK as Earth damage to a target. Apply Ensnared to target for 5 turns. """, # MISSING TRANSLATION
	SKILLSOUL_BIND = """Soul Bind""", # MISSING TRANSLATION
	SKILLSOUL_BINDDESCRIPT = """Bends person's mind to submit to your will. After a day of rest they will follow most of your orders. """, # MISSING TRANSLATION
	
	SKILLFLY_EVASION = "Flight 飞行",
	SKILLFLY_EVASIONDESCRIPT = "Increases Evasion by 65 for 3 turns.\n增加 65 的闪避，持续 3 回合。",
	SKILLEUPHORIA_APPLY = """Euphoria""", # MISSING TRANSLATION
	SKILLEUPHORIA_APPLYDESCRIPT = """When activated increases all damage by your lust. Drains your lust every turn.""", # MISSING TRANSLATION
	SKILLEUPHORIA_REMOVE = """Euphoria""", # MISSING TRANSLATION
	SKILLEUPHORIA_REMOVEDESCRIPT = """Disable Euphoria""", # MISSING TRANSLATION
	
	
	SKILLMIMIC_ATTACK = "粘性抓取",

	WORKTOOL = "作业机具",
	WORKTOOLAXE = "伐木斧",
	WORKTOOLROD = "渔具",
	WORKTOOLPICKAXE = "镐",
	WORKTOOLHAMMER = "锤子",
	WORKTOOLBOW = "猎弓",
	WORKTOOLSICKLE = "镰刀",
	WORKTOOLHUNT_KNIFE = "猎刀",

	MAXIMUM_WORKERS = "最大工人数",
	REQUIRED_UPGRADE_NAME = "升级名称",
	WORKERS_PER_UPGRADE = "每次升级的工人数",

	CORRECTTOOLEQUIPPED = "装备正确的工具：工作效率将会提升。 ",

	
	TASKHUNTING = "狩猎",
	TASKHUNTINGDESCRIPT = "追踪本地野生动物以获取相关资源。",
	TASKFISHING = "捕鱼",
	TASKFISHINGDESCRIPT = "在附近水域捕捞水生资源。",
	TASKGATHERING_WOOD = "伐木",
	TASKGATHERING_WOODDESCRIPT = "在森林中收集木材材料。木材广泛用于建筑，但也可以用作工具材料。",
	TASKMINING_STONE = "采石",
	TASKMINING_STONEDESCRIPT = "在矿山收集石头。石头在建筑中大量使用，但也可以作为一些材料部件。",
	TASKPROSTITUTION = "Prostitution",
	TASKPROSTITUTIONDESCRIPT = "向公众提供性服务以赚取金币。",
	TASKBROTHEL = "Service",
	TASKBROTHELDESCRIPT = "提供娱乐或性服务以换取金币。",
	TASKCOOKING = "Cooking",
	TASKCOOKINGDESCRIPT = "手工制作食物。必须选择烹饪食谱。 ",
	TASKTAILOR = "Tailor",
	TASKTAILORDESCRIPT = "手工制作布料、皮革制品和装备。必须选择要手工制作的物品。 ",
	TASKSMITH = "Smith",
	TASKSMITHDESCRIPT = "锻造和金属制品及装备。必须选择要制作的物品。 ",
	TASKALCHEMY = "Alchemy",
	TASKALCHEMYDESCRIPT = "制作炼金药剂和物品。必须选择要制作的物品。 ",
	TASKBUILDING = "Upgrading",
	TASKBUILDINGDESCRIPT = "处理当前升级。必须在升级菜单中设置升级。",
	TASKTRAVEL = "旅行",
	TASKREST = "Rest",
	TASKRESTSERVICE = "Service",
	TASKRESTDESCRIPT = "角色将在本地设施提供服务，在必要时切换到休息。",
	TASKRESTINFO = "Resting will make wounds heal faster and does not make character drain Obedience but they also not gain Loyalty.",
	TASKFARMING_VEGES = "种菜",
	TASKFARMING_VEGESDESCRIPT = "在农场工作，种植蔬菜。蔬菜是许多种族的主食。",
	TASKFARMING_GRAINS = "种谷物",
	TASKFARMING_GRAINSDESCRIPT = "在农场工作，种植谷物。谷物可以烹饪成食物。",
	TASKFARMING_COTTON = "种棉花",
	TASKFARMING_COTTONDESCRIPT = "在农场工作，种植棉花。然后棉花被加工成布，可以用来制作盔甲。",
	TASKFARMING_CLOTH_SILK = "丝绸",
	TASKFARMING_CLOTH_SILKDESCRIPT = "从昆虫养殖场收集丝绸。丝绸是一种坚固光滑的布料，有很多用途。",
	TASKGATHERING_WOOD_MAGIC = "魔力木材",
	TASKGATHERING_WOOD_MAGICDESCRIPT = "在森林中收集魔法木。特殊性质的木材可以通过多种方式使用。",
	TASKGATHERING_WOOD_IRON = "铁木",
	TASKGATHERING_WOOD_IRONDESCRIPT = "在森林中收集铁木。铁木比正常情况下更坚固、更重。",
	TASKMINING_IRON = "铁",
	TASKMINING_IRONDESCRIPT = "在矿山收集铁。铁广泛用于金属工具、建筑和装甲。",
	TASKMINING_MITHRIL = "秘银",
	TASKMINING_MITHRILDESCRIPT = "在矿场工作，收集秘银——一种因其卓越品质而闻名的强效魔法合金。",
	TASKMINING_OBSIDIAN = "黑曜石",
	TASKMINING_OBSIDIANDESCRIPT = "在矿场采集黑曜石。黑曜石因其稀有性和某些神奇特性而闻名。",
	TASKRECRUIT_EASY = "搜索新兵",
	TASKRECRUIT_EASYDESCRIPT = "Search for recruits at current location. After its finished you'll be able to talk them into joing you if succesful.",
	TASKRECRUIT_HARD = "搜索新兵",
	TASKRECRUIT_HARDDESCRIPT = "Search for recruits at current location. After its finished you'll be able to talk them into joing you if succesful.",
	TASKMISSION = "任务",
	TASKRONMISSIONCOMPLETE = "完成此任务后，从日记中获得奖励。",
	
	TASKPRODUCE = "生产",
	TASKPRODUCEDESCRIPT = "分配生产材料",
	TASKSPECIALDESCRIPT = """""", # MISSING TRANSLATION
	
	BEDROOMTOOLTIP = "Available number of characters for sexual interactions. Increases with Bedroom Upgrade",
	DATETOOLTIP = "Dates left this week. Increases with Master's Charm Factor and resets at the start of a week.",
	SEXTOOLTIP = "Sexual Interactions left this week. Increases with Master's Sexual Factor and resets at the start of a week.",
	
	TOOLTIPLOYALTYOBEDIENCE = "Loyalty points are gained every turn based on Tame Factor. You can unlock new actions and passives with it.\n\nObedience Drain is based on Timid Factor and character training. If Obedience falls to 0 the character will attempt to escape. Unlock new options and use proper gear to reduce Obedience Drain and make it more manageble. ",
	TOOLTIPVALUE = "Character's value means their market price. It's based on their Growth Factor, Race, Training and certain features. Higher value characters will earn more money when providing services and prostitution.",
	
	SERVICEREST = "[name] will rest. Toggle [color=aqua]Rest[/color] to disable.",
	SERVICESEXUALPENETRATIVE = "[name] will entertain clients by serving and sleeping with them if they find [him] appealing.",
	SERVICEPREGNANT = "[He] can lose virginity and get pregnant from penetration.",
	SERVICESEXUALNONPENETRATIVE = "[name] will entertain clients by serving them and provide them with light sexual services not involving penetration.",
	SERVICENOSEX = "[name] will serve and entertain clients but will refuse any sexual services.",
	
	
	TASKMAINSTAT = "主要特征",
	
	JOBPROSTITUTEGOLDDESCRIPT = "通过卖淫赚取金币",
	JOBCOOKINGCRAFTDESCRIPT = "在厨房烹饪食物",
	JOBBUILDINGCRAFTDESCRIPT = "进行当前升级",
	JOBSMITHCRAFTDESCRIPT = "在锻造厂加工物品",
	JOBTAILORCRAFTDESCRIPT = "在裁缝车间手工制作物品",
	JOBALCHEMYCRAFTDESCRIPT = "在炼金车间制作物品",
	EXPLOREUPGRADETIP = """Upgrades effects and quest settings update after some time passed.""", # MISSING TRANSLATION
	LOGLEFTLABEL = """Main""", # MISSING TRANSLATION
	LOGLEFTTTOOLTIP = """Shows main events""", # MISSING TRANSLATION
	LOGRIGHTLABEL = """Service""", # MISSING TRANSLATION
	LOGRIGHTTOOLTIP = """Shows service income""", # MISSING TRANSLATION
	BROTHELLOGSEX = """%s earned %s gold doing %s with a %s""", # MISSING TRANSLATION
	BROTHELLOGNO_SEX = """%s earned %s gold working as a %s""", # MISSING TRANSLATION
	
	BROTHELTOOLTIP = "You can select which tasks the character will be allowed to perform while working at brothel. By toggling specific tasks only those will be allowed. Client sexes only affect sexual tasks.\nHigher character Value increases earnings, higher Charm increases likelyhood of being requested for sex.\nDifferent tasks improve and scale from different stats.\nService is a global modifier for this assignment.",
	BROTHELWARNING = """Sex services won't work if you dont select at least 1 allowed customer""", # MISSING TRANSLATION
	
	CAPTURETOOLTIP = "这些角色已经被你的团队发现，可以被招募到你的豪宅中，也可以像手动出售一样快速变现。如果忘记了位置，所有角色都会自动出售。",
	CAPTURESELLTOOLTIP = "以 %d 金币快速出售此角色。这相当于向市场出售角色，但不允许您回购。 ",
	CAPTUREADDTOOLTIP = "将此角色添加到名册中。如果您的角色总数大于可用房间数，您将无法完成回合。 ",
	CAPTURERECRUITTOOLTIP = "尝试招募此角色。如果您的角色总数大于可用房间数，您将无法完成回合。",
	CAPTUREDISMISSTOOLTIP = "解散此角色",
	
	SERVICEBOOSTTOOLTIP = "You can assign additional item consumption here which will boost service production. These items can be produced at Farm. ",
	FARMTOOLTIP = "You can assign character to farm to produce additional materials which can be used to boost service production or be sold.",
	
	
	FACTOR_INCREASE_TOOLTIP = "通过牺牲不需要的角色，只要施主角色的属性高于接收者的属性，你就可以提高其他角色的因子。每个施主的生长因子只能增加 1 。最终价格由接收者的值定义。",
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

	SLAVEPARTNAME = "名称",
	SLAVEPARTSURNAME = "姓氏",
	SLAVEPARTNICKNAME = "昵称",
	SLAVEPARTRACE = "种族",
	SLAVEPARTAGE = "Age",
	SLAVEPARTSEX = "性别",
	SLAVEPARTSKIN = "肤色",
	SLAVEPARTHAIR_COLOR = "头发颜色",
	SLAVEPARTHAIR_LENGTH = "头发长度",
	SLAVEPARTHAIR_STYLE = "发型",
	SLAVEPARTEARS = "耳朵",
	SLAVEPARTEYE_COLOR = "眼睛颜色",
	SLAVEPARTEYE_SHAPE = "眼睛形状",
	SLAVEPARTTAIL = "尾部",
	SLAVEPARTHORNS = "犄角",
	SLAVEPARTWINGS = "翅膀",
	SLAVEPARTHEIGHT = "身高",
	SLAVEPARTARMS = "手臂",
	SLAVEPARTLEGS = "腿",
	SLAVEPARTPENIS_SIZE = '阴茎大小',
	SLAVEPARTPENIS_TYPE = '阴茎形状',
	SLAVEPARTBALLS_SIZE = "睾丸大小",
	SLAVEPARTASS_SIZE = "屁股尺寸",
	SLAVEPARTTITS_SIZE = "胸部尺寸",
	SLAVEPARTVAGINAL_VIRGIN = "阴道处女",
	SLAVEPARTANAL_VIRGIN = "肛门处女",
	SLAVEPARTPENIS_VIRGIN = "阴茎童贞",
	SLAVEPARTSEXTRAIT = "性特征",
	SLAVEPARTPERSONALITY = "个性",

	SLAVEPARTPERSONALITYDESCRIPT = "个性定义了角色的言语模式，没有游戏效果。",

	SLAVEDIET = "食物偏好",
	SLAVESTARTINGCLASS = "开始上课",
	#Bodyparts
	
	BODYPARTSEXFUTA = "扶她",
	BODYPARTSEXMALE = "男性",
	BODYPARTSEXFEMALE = "女性",
	
	SIZETINY = "微小",
	SIZEPETITE = "娇小",
	SIZESHORT = "矮",
	SIZEAVERAGE = "平均",
	SIZETALL = "高",
	SIZETOWERING = "高耸",
	SIZESMALL = "小",
	SIZEBIG = "大",

	SLAVESEXMALE = "Male",
	SLAVESEXFEMALE = "Female",
	SLAVESEXFUTA = "Futa",
	SLAVEAGETEEN = "Teen",
	SLAVEAGEADULT = "Young Adult",
	SLAVEAGEMATURE = "Mature",

	SLAVECLASSDESCRIPT = "Slaves are considered to be property. Their life solely belongs to their master and in case of escape they are treated as criminals effectively negating their rights.\n\n[color=aqua]Slaves suffer 10% damage reduction, but they gain Loyalty faster by 30%. Slaves have +10% bonus to Collection, Farming and Prostitution tasks, but -15% to Smith, Tailor and Alchemy. Slaves can be forced into sexual service for gold without training but at reduced efficiency.[/color]",
	SERVANTCLASSDESCRIPT = "Peons generally have the same rights of others, but are purchased to serve a Master. Many folks end up as peons as a way to pay their, or their family's debt, or otherwise gain a stable living condition. However, if they escape, peons can often continue their life with only minor penalties. Therefore, they gain no penalties or benefits compared to slaves. They also cannot be forced to participate in sexual activities.",
	HEIRCLASSDESCRIPT = "Mansion's heir are children born of [master] and their spouse.\n\n[color=aqua]Heir's Obedience drain 50% slower and Loyalty is 50% faster. Heir has 20% penalty to Collection, Farming and Fishing.[/color] ",

	SLAVETYPE = "类型",

	SLAVEBODYHUMANOID = "类人",
	SLAVEBODYBESTIAL = "兽人",
	SLAVEBODYSHORTSTACK = "矮小",
	SLAVEBODYJELLY = "果冻",
	SLAVEBODYHALFBIRD = "半鸟",
	SLAVEBODYHALFSNAKE = "半蛇",
	SLAVEBODYHALFFISH = "半鱼",
	SLAVEBODYHALFSPIDER = "半蜘蛛",
	SLAVEBODYHALFHORSE = "半马",
	SLAVEBODYHALFSQUID = "半鱿鱼",

	SLAVEBODYHUMANOIDDESCRIPT = "",
	SLAVEBODYBESTIALDESCRIPT = "",
	SLAVEBODYSHORTSTACKDESCRIPT = "[His] 身体非常 [color=yellow]矮小[/color], 大约是普通人的一半大小。",
	SLAVEBODYJELLYDESCRIPT = "[His] 身体是 [color=yellow]果冻状的[/color] 并且部分透明。",
	SLAVEBODYHALFBIRDDESCRIPT = "[His] 身体有 [color=yellow]翅膀和鸟类的腿[/color] ，这让日常任务变得困难。",
	SLAVEBODYHALFSNAKEDESCRIPT = "[His] 身体的下半部分由一条长而弯曲的 [color=yellow]蛇尾巴[/color]组成，",
	SLAVEBODYHALFFISHDESCRIPT = "[His] 身体有 [color=yellow]光滑鳞片[/color], 有鳍和网状指。",
	SLAVEBODYHALFSPIDERDESCRIPT = "[His] 身体的下半部分由一只 [color=yellow]蜘蛛的腿和腹部[/color]组成。",
	SLAVEBODYHALFHORSEDESCRIPT = "虽然 [his] 上半身是人，但 [his] 下半身在自然界中是 [color=yellow]马[/color] 。",
	SLAVEBODYHALFSQUIDDESCRIPT = "[His] 身体的下半部分由 [color=yellow]多条触手[/color]组成, 类似于章鱼的触手。",
	SLAVECLASSSLAVE = """Slave""", # MISSING TRANSLATION
	SLAVECLASSSERVANT = """Subordinate""", # MISSING TRANSLATION



	
	
	DESCRIPTCLASSSLAVE = "[name] 是你的奴隶，必须服从你的命令。",
	DESCRIPTCLASSSERVANT = "[name] 是你的仆人，必须听从你的命令。",
	DESCRIPTCLASSMERC = "[name] 被你雇佣，花费你金币。",
	DESCRIPTCLASSHEIR = "[name] 是你的继承人",
	
	CLASSDETAILSKILLS = "技能",
	CLASSDETAILCOMBATSKILLS = "战斗技能",
	CLASSRIGHTCLICKDETAILS = "右键单击以获取详细信息",
	
	
	TOOLTIPSEXTRAITS = "Sexual traits are special bonuses which provide benefits during the interaction sequence. ",
	TOOLTIPTAX = "Taxes is a gold you pay at the start of each week. Getting better upgrades will increase your tax value. If your gold goes negative, you lose.",
	
	
	STATHP = "Health",
	STATHPDESCRIPT = "Health decreases in combat and from some skills and events. Once health is reduced to 0, character dies.",
	STATENERGY = "能量",
	STATENERGYDESCRIPT = "能量在睡眠中恢复，是执行任务所必需的。当角色被迫在没有能量的情况下工作时，他们会积累疲惫。 ",
	STATHPMAX = "Max. Health 最大健康",
	STATHPFACTOR = "健康因素",
	STATHPFACTORDESCRIPT = "确定以大多数方式获得的健康值加成。高健康值可以大大提高生存能力。 ",
	STATHP_REG_MOD = """Healing Factor""", # MISSING TRANSLATION
	STATMP_REG_ADD = """Mana Regeneration""", # MISSING TRANSLATION

	STATHPMAXMOD = "最大健康",

	STATMP = "Mana 魔力",
	STATMPDESCRIPT = "Mana is used for casting spells and using some abilities.\n魔力用于施法和使用某些能力",
	STATMPMAX = "Max. Mana 最大魔力",
	STATMPMAXMOD = "Max. Mana 最大魔力",
	STATHITRATE = "Hit chance 命中率",
	STATHITRATEDESCRIPT = "Chance to hit enemy. Reduced by target's evasion.\n命中敌人的几率。因目标的闪避而降低",
	STATEVASION = "Evasion 闪避",
	STATEVASIONDESCRIPT = "Chance to dodge enemy attacks.\n躲避敌人攻击的机会",
	STATSPEED = "Speed 速度",
	STATSPEEDDESCRIPT = "Increases chance to attack before others.\n增加在其他人之前攻击的机会",
	STATARMOR = "DEF 防御",
	STATARMORDESCRIPT = "Reduces physical damage taken.\n减少受到的物理伤害",
	STATMDEF = "MDEF 魔法防御",
	STATMDEFDESCRIPT = "Reduces magical damage taken.\n减少受到的魔法伤害",
	STATATK = "ATK 攻击力",
	STATATKDESCRIPT = "Defines physical damage values.\n定义物理伤害值",
	STATMATK = "MATK 魔法攻击",
	STATMATKDESCRIPT = "Defines magical damage values.\n定义魔法伤害值",
	STATCRITCHANCE = "Crit Chance 暴击率",
	STATCRITCHANCEDESCRIPT = "Defines chance of a critical hit.\n定义暴击几率",
	STATCRITMOD = "Crit Mod 暴击伤害",
	STATCRITMODDESCRIPT = "Defines bonus damage of critical hits.\n定义暴击的额外伤害",
	STATRESIST = "Resist 抗性",
	STATRESISTDESCRIPT = "Reduces damage from specific element.\n减少特定元素造成的伤害",
	STATDAMAGEMOD = "Damage Mult. 伤害倍率",
	STATDAMAGEMODDESCRIPT = "Increases all damage by value\n增加所有伤害值",
	STATARMORPENETRATION = "Armor Pen. 穿甲",
	STATARMORPENETRATIONDESCRIPT = "Ignores value of enemy's armor. \n忽略敌人盔甲的值",
	STATMODMELEE = "Melee Dam. 近战伤害",
	STATMODRANGED = "Ranged Dam. 远程伤害",
	STATDAMAGE_MOD_SKILL = "Physical Damage 物理伤害",


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
	STATMAGIC_FACTOR = "魔力亲和力",
	STATPHYSICS_FACTOR = "物理因素",
	STATWITS_FACTOR = "智慧因素",
	STATCHARM_FACTOR = "Charm Factor 魅力因素",
	STATSEXUALS_FACTOR = "性因素",
	STATTAME_FACTOR = "驯服因素",
	STATTIMID_FACTOR = "胆怯因素",
	STATSLAVE_CLASS = """Type""", # MISSING TRANSLATION

	STATPHYSICS_BONUS = "Physics 物理",
	STATWITS_BONUS = "Wits 智慧",
	STATCHARM_BONUS = "Charm 魅力",
	STATSEXUALS_BONUS = "Sexuals 性能力",

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
	
	STATEXP_GAIN_MOD = "Experience Bonus",
	
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
	STATENCHANT_CAPACITY_MOD = """Enchant Capacity""", # MISSING TRANSLATION
	STATENCHANT_CAPACITY = """Enchant Capacity""", # MISSING TRANSLATION
	STATENCHCAP = """Enchant Capacity""", # MISSING TRANSLATION
	STATQUALITY = """Quality""", # MISSING TRANSLATION
	
	STATPRICE = "Value",
	STATCHG_STRENGTH = """Strength Charges""", # MISSING TRANSLATION
	STATCHG_STRENGTH_MAX = """Maximum Strength Charges""", # MISSING TRANSLATION
	STATCHG_CHARM = """Charm Charges""", # MISSING TRANSLATION
	STATCHG_CHARM_MAX = """Maximum Charm Charges""", # MISSING TRANSLATION
	STATCHG_WISDOM = """Wisdom Charges""", # MISSING TRANSLATION
	STATCHG_WISDOM_MAX = """Maximum Wisdom Charges""", # MISSING TRANSLATION
	STATCHG_DEXTERITY = """Dexterity Charges""", # MISSING TRANSLATION
	STATCHG_DEXTERITY_MAX = """Maximum Dexterity Charges""", # MISSING TRANSLATION
	
	STATFOOD_CONSUMPTION = "Food Consumption",
	STATFOOD_CONSUMPTIONDESCRIPT = "Amount of food items a person requires every day. Lack of food leads to starvation, exhaustion and eventual death.",
	MASTER_POINTS = """Mastery""", # MISSING TRANSLATION

	TOOLTIPENERGY = "Energy is restored during sleep and is required for tasks. When a character is forced to work with no energy left, their Exhaustion increases. ",
	TOOLTIPFATIGUE = "Fatigue increases with time and dissipates with entertainment. When unmanaged it may cause a performance penalty.",
	TOOLTIPEXHAUSTION = "Exhaustion grows when a character is forced to work with no energy left. Exhaustion causes penalties to maximum health and production, and can lead to death if not taken care of for a long time.",

	TOOLTIPSIMPLEBEHAVIOR = "While having Simple Behavior active, character will work until they run out of energy, Rest until energy is full and seek Joy until Fatigue is gone. Recommended for beginners.",
	TOOLTIPPBASEPRODUCTIVITY = "Base Productivity. Reduced by Fatigue and Exhaustion.",

	TOOLTIPGOLD = "Owned gold. Gold is used for buying slaves and items and can be obtained from selling items, completing quests and some tasks.",
	TOOLTIPFOOD = "Owned Food items / food consumed per day. Food is used by every character and can be obtained from some tasks and increased with cooking. Lack of food will lead to exhaustion and eventual death. ",
	TOOLTIPENCHANTSCREEN = """You can apply enchants and curses to an item. Applying curse will increase item's enchantment capacity but the curse will be random and only revealed on equpping the item. """, # MISSING TRANSLATION
	MASTERPOINTTOP = """New Master Point""", # MISSING TRANSLATION
	MASTERPOINTSTOP = """New Master Points""", # MISSING TRANSLATION
	MASTERPOINTBOTTOM = """%d point""", # MISSING TRANSLATION
	MASTERPOINTSBOTTOM = """%d points""", # MISSING TRANSLATION
	
	
	
	INFOFOODFILTER = "Food filter allows to restrict or prioritize food which character will consume. Higher priority food consumed first. Keep in mind that some food may be hated by a character.",
	INFOSEX_SKILLS = "Sex Skills refer to character's performance during sex. The higher they are, the quicker they can make thier partner to orgasm with related actions. Character's Sexual Proficiency is based on average of 3 highest skills.\nConsent represents character's general acceptance of various sexual actions, but it is also heavily affected by partners and situtation.",
	INFOSEX_TRAITS = "Sex Traits provide additional effects during sexual interaction. They can be learned, activated and deactivated. Maximum number of activatale traits is based on Sex Factor.",
	INFORULES_CONDS = "Conditions and rules can be toggled on character, affecting some of their stats and behavior.",
	INFOPERSONALITY = """Character's personality will affect thier banter and provide access to certain traits and bonuses. Personality will be affected by social skills used on character.""", # MISSING TRANSLATION
	INFOPERSONALITYBOLD = """Bold
+25% Skill Damage; -25% MATK""", # MISSING TRANSLATION
	INFOPERSONALITYKIND = """Kind
+50% Healing Spell Efficiency""", # MISSING TRANSLATION
	INFOPERSONALITYSERIOUS = """Serious
+20% Damage Reduction""", # MISSING TRANSLATION
	INFOPERSONALITYSHY = """Shy
+25% MATK, -20% ATK""", # MISSING TRANSLATION
	INFOSLAVE_CLASS = """Character type will define its options and behavior. Slaves can be forced into sexual services without consent and have higher tolerance for lack of consent in sex. Subordinates become loyal faster but can't be sold or given away.""", # MISSING TRANSLATION
	INFOCONSENT = """Consent defines what sexual related actions character will be willing to peform. Consent can be increased by pushing character into new practices by dating and sex options. Consent will affect prostitution related jobs.""", # MISSING TRANSLATION
	INFOCONSENTMASTER = """Consent defines what sexual related actions character will be willing to peform. Consent can be increased by pushing character into new practices by dating and sex options. {color=green|[Master] has no Consent requirements for any actions.}""", # MISSING TRANSLATION
	PERSONALITYNAMEBOLD = """Bold""", # MISSING TRANSLATION
	PERSONALITYNAMEKIND = """Kind""", # MISSING TRANSLATION
	PERSONALITYNAMESERIOUS = """Serious""", # MISSING TRANSLATION
	PERSONALITYNAMESHY = """Shy""", # MISSING TRANSLATION
	PERSONALITYNAMENEUTRAL = """Neutral""", # MISSING TRANSLATION
	PERSONALITYCHANGE = """'s personality changed to: """, # MISSING TRANSLATION
	PERSONALITYSHIFTPERSONALITY_KIND = """[name]'s behavior has shifted to more {color=green|Kind} side.""", # MISSING TRANSLATION
	PERSONALITYSHIFTPERSONALITY_SHY = """[name]'s behavior has shifted to more {color=green|Shy} side.""", # MISSING TRANSLATION
	PERSONALITYSHIFTPERSONALITY_SERIOUS = """[name]'s behavior has shifted to more {color=green|Serious} side.""", # MISSING TRANSLATION
	PERSONALITYSHIFTPERSONALITY_BOLD = """[name]'s behavior has shifted to more {color=green|Bold} side.""", # MISSING TRANSLATION
	PERSONALITYCURRENT = """Current Personality: """, # MISSING TRANSLATION
	PERSONALITYREBEL = """
{color=red|Due to [his] rebellous character, [name] have not accepted this treatment to heart and [his] personality shifted into the opposite direction.} """, # MISSING TRANSLATION
	LOYALTYSPECTOOLTIP = """Can only unlock 1 specialization per character. Stats will increases with every loyalty level. Loyalty required will grow exponentially.""", # MISSING TRANSLATION
	SLAVEPROFNAME_COMBAT = """Spc: Combat""", # MISSING TRANSLATION
	SLAVEPROFNAME_SERVICE = """Spc: Service""", # MISSING TRANSLATION
	SLAVEPROFNAME_PRESTIGE = """Spc: Prestige""", # MISSING TRANSLATION
	SLAVEPROFNAME_MANAGEMENT = """Spc: Defense""", # MISSING TRANSLATION
	SLAVEPROFNAME_MAGE = """Spc: Mage""", # MISSING TRANSLATION
	SLAVEPROFNAME_HEALER = """Spc: Healer""", # MISSING TRANSLATION
	SLAVEPROFDESCRIPT_COMBAT = """Specialization: Combat""", # MISSING TRANSLATION
	SLAVEPROFDESCRIPT_SERVICE = """Specialization: Service""", # MISSING TRANSLATION
	SLAVEPROFDESCRIPT_PRESTIGE = """Specialization: Prestige""", # MISSING TRANSLATION
	SLAVEPROFDESCRIPT_MANAGEMENT = """Specialization: Defense""", # MISSING TRANSLATION
	SLAVEPROFDESCRIPT_MAGE = """Specialization: Mage""", # MISSING TRANSLATION
	SLAVEPROFDESCRIPT_HEALER = """Specialization: Healer""", # MISSING TRANSLATION
	HEALERSLAVETRAITDESCRIPT = """Healing Efficiency: {color=green|+2%}""", # MISSING TRANSLATION
	MANAGERSLAVETRAITDESCRIPT = """Loyalty from skills: +3%""", # MISSING TRANSLATION
	
	
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
	STATMAGIC_FIND = """Magic Find""", # MISSING TRANSLATION




	RACEHUMAN = "Human人类",
	RACEHUMANADJ = "人类",
	RACEELF = "Elf精灵",
	RACEELFADJ = "精灵",
	RACETRIBALELF = "Tribal Elf部落精灵",
	RACETRIBALELFADJ = "部落精灵",
	RACEDARKELF = "Dark Elf黑暗精灵",
	RACEDARKELFADJ = "黑暗精灵",
	RACEORC = "Orc半兽人",
	RACEORCADJ = "半兽人",
	RACEGOBLIN = "Goblin哥布林",
	RACEGOBLINADJ = "哥布林",
	RACEKOBOLD = "Kobold狗头人",
	RACEKOBOLDADJ = "狗头人",
	RACEDWARF = "Dwarf矮人",
	RACEDWARFADJ = "矮人",
	RACEGNOME = "Gnome侏儒",
	RACEGNOMEADJ = "侏儒",
	RACEFAIRY = "Fairy仙精",
	RACEFAIRYADJ = "仙精",
	RACEDRYAD = "Dryad树妖",
	RACEDRYADADJ = "树妖",
	RACEDEMON = "Demon恶魔",
	RACEDEMONADJ = "恶魔",
	RACESERAPH = "Seraph天使",
	RACESERAPHADJ = "天使",
	RACEDRAGONKIN = "Dragonkin龙人",
	RACEDRAGONKINADJ = "龙人",
	RACECENTAUR = "Centaur半人马",
	RACECENTAURADJ = "半人马",
	RACETAURUS = "Taurus牛头人",
	RACETAURUSADJ = "牛头人",
	RACEHARPY = "Harpy哈比",
	RACEHARPYADJ = "哈比",
	RACESLIME = "Slime史莱姆",
	RACESLIMEADJ = "史莱姆",
	RACELAMIA = "Lamia拉米亚",
	RACELAMIAADJ = "拉米亚",
	RACEARACHNA = "Arachna阿拉克尼",
	RACEARACHNAADJ = "阿拉克尼",
	RACESCYLLA = "Scylla斯库拉",
	RACESCYLLAADJ = "斯库拉",
	RACENEREID = "Nereid涅瑞伊得斯",
	RACENEREIDADJ = "涅瑞伊得斯",

	RACEBEASTKINCAT = "Beast Cat兽化猫人",
	RACEBEASTKINCATADJ = "兽化猫人",
	RACEBEASTKINWOLF = "Beast Wolf兽化狼人",
	RACEBEASTKINWOLFADJ = "兽化狼人",
	RACEBEASTKINFOX = "Beast Fox兽化狐人",
	RACEBEASTKINFOXADJ = "兽化狐人",
	RACEBEASTKINBUNNY = "Beast Bunny兽化兔人",
	RACEBEASTKINBUNNYADJ = "兽化兔人",
	RACEBEASTKINTANUKI = "Beast Tanuki兽化狸人",
	RACEBEASTKINTANUKIADJ = "兽化狸人",

	RACEHALFKINCAT = "Half-Breed Cat混血猫人",
	RACEHALFKINCATADJ = "混血猫人",
	RACEHALFKINWOLF = "Half-Breed Wolf混血狼人",
	RACEHALFKINWOLFADJ = "混血狼人",
	RACEHALFKINFOX = "Half-Breed Fox混血狐人",
	RACEHALFKINFOXADJ = "混血狐人",
	RACEHALFKINBUNNY = "Half-Breed Bunny混血兔人",
	RACEHALFKINBUNNYADJ = "混血兔人",
	RACEHALFKINTANUKI = "Half-Breed Tanuki混血狸人",
	RACEHALFKINTANUKIADJ = "混血狸人",
	
	RACERATKIN = "Ratkin鼠人",
	RACERATKINADJ = "鼠人",
	
	
	RACEHUMANDESCRIPT = "Humans are one of the most common races. Their strength comes in their numbers and flexibility, but they generally are rather weak in magic and have low potential growth. Only a few exceptional humans have shown outstanding feats. \n\nHuman society is rather open to others but also quick to anger and start wars even among themselves. While some might act prudish, especially in public, humans in general are very sexually active and do not stray from other humanoid races.\n\n人类是最常见的种族之一。他们的力量来自于他们的数量和灵活性，但他们通常在魔法方面相当弱，增长潜力很低。只有少数杰出的人类表现出非凡的潜力。\n\n人类社会对他人相当开放，但也很容易引发冲突，甚至在自己之间发动战争。虽然有些人可能会表现得拘谨，尤其是在公共场合，但人类通常性行为非常活跃，一般局限于类人种族内。 ",
	RACEELFDESCRIPT = "Elves prefer living in the forest and being close to nature with other naturistic races like Dryads and Fairies. They are adept in magic, but their physical strength is fairly mediocre. \n\nElven society is fairly secluded but isn't above contact and trading with other races. Elves rarely show an active interest in sex outside of their social group, often preferring life-long relationships. Still they are considered very appealing and attractive by other races making them in popular demand as slaves.\n\n精灵喜欢生活在森林里，与其他裸体主义种族如树妖和仙精亲近自然。他们擅长魔法，但体力相当平庸。\n\n精灵社会相当隐蔽，但并不反对与其他种族的接触和交易。精灵很少在社交群体之外对性表现出积极的兴趣，通常更喜欢终身关系。并且他们被其他种族认为非常有吸引力，使他们常常在奴隶市场大受欢迎。",
	RACETRIBALELFDESCRIPT = "A rarer version of elves with distinct dark skin. Tribal elves mostly inhabit southern regions and show numerous differences to their common counterparts. They are less prone to magic but possess stronger bodies.\n\nHowever, their society (often separated into tribes) is more secluded and hostile to outsiders, but they are also more open to sex than normal elves.\n\n一种罕见的深色皮肤精灵。部落精灵大多居住在南部地区，与普通精灵有很多不同。他们不太喜欢魔法，但拥有更强壮的身体。\n\n然而，他们的社会（通常为部落）更隐蔽，更厌恶外来者，但他们也比普通精灵更容易发生性关系。",
	RACEDARKELFDESCRIPT = "A rare subspecies of elves propagated and trained for combat. Their bluish skin and rare eye colors make them very noticeable and force them to hide their bodies in clothes. Being adepts in both physical techniques and magic, they often happen to be trained assassins, combatants and sellswords. \n\n一种罕见的精灵亚种，为战斗而繁殖和训练。他们蓝色的皮肤和罕见的眼睛颜色使他们非常引人注目，并迫使他们把身体藏在衣服里。他们精通冷兵器和魔法，经常是受过训练的刺客、战斗人员和佣兵。",
	RACEORCDESCRIPT = "Orcs are a semi-sapient race of brutes inhabiting many desert and badland regions. Orcs resemble large, greenish humanoids with strong bodies and bad tempers. Despite that, some orcs are rather capable of fitting into normal society to work as simple bodyguards and soldiers. \n\nCommonly orcs form tribes and aren't above killing each other or any stray groups they deem dangerous. They are also rather fond of forcefully using members of other races for sex but aren't capable of interbreeding with them. \n\n半兽人是居住在许多沙漠和荒原地区的半智慧野兽种族。半兽人长得像绿色的大号人类，身体强壮，脾气暴躁。尽管如此，一些半兽人还是很有能力融入正常社会，充当简单的保镖和士兵。\n\n常见的半兽人组成部落，但依然热衷于互相残杀或攻击任何他们认为危险的流浪群体，他们喜欢强行利用其他种族的成员进行性行为，但无法与他们杂交。",
	RACEGOBLINDESCRIPT = "Goblins are short humanoids often occupying caves and dungeons. Most goblins are outright hostile to all outsiders and prefer to stick to groups as their individual power is fairly low. A certain number of goblins have abandoned their initial groups and strive to live with other races. Sometimes they even become known adventurers, but more often they are used for crude work, since they are hardly remarkable at anything except for their libido. \n\n哥布林是矮小的类人种族，经常占据洞穴和地牢。大多数哥布林对所有外族人都充满敌意，他们更喜欢加入团体，因为他们的个人力量相当低。一定数量的哥布林已经放弃了最初的群体，努力与其他种族生活在一起。有时他们甚至成为了众所周知的冒险家，但更多的时候，他们被用于粗糙的工作，因为除了性欲之外，他们在任何方面都不出色。",
	RACEKOBOLDDESCRIPT = "Kobolds are a short, lizard-like race distinctively related to dragons. They generally live underground or in forests and aren't very friendly to other races often seen as pests. Certain individuals have managed to find acceptance among other racial groups.\n\n狗头人是一个矮小的、类似蜥蜴的种族，与龙有着明显的亲缘关系。它们通常生活在地下或森林中，对其他经常被视为害虫的种族不太友好。某些人已经设法在其他种族群体中找到了认可。 ",
	RACEGNOMEDESCRIPT = "Gnomes are a rare species of short, intelligent humanoids. Their poor physical strength makes them rather poor workers or fighters. They possess some magical capabilities, a good amount of charisma and have an easy time connecting with other races. Many gnomes find their place as traders or entertainers, but a good amount are pretty happy to serve in more lewd occupations... assuming they can find the demand. \n\n侏儒是一种罕见的矮而聪明的类人种族。他们可怜的体力使他们成为低水平的工人或战士。他们拥有一些神奇的能力，很有魅力，很容易与其他种族建立联系。许多侏儒找到了自己作为商人或艺人的位置，但相当多的侏儒很乐意从事更淫秽的职业……假设他们能找到工作的话。",
	RACEDWARFDESCRIPT = "Dwarves are a short, stout humanoid race that prefer to live by a strict set of rules in an enclosed underground society. Dwarves are rather physically strong, can be quick to anger, and are rarely fit for magic tasks.\n\n矮人是一个矮小、结实的人形种族，他们更喜欢在封闭的地下社会中按照一套严格的规则生活。矮人身体很强壮，很快就会生气，不适合执行魔法任务。 ",
	RACEDRYADDESCRIPT = "Dryads are a rare species of forest humanoids possessing green skin and being covered in plant matter. They rarely engage in communication with other races and generally prefer to stick to their home. Despite that, they are quite capable of fighting and using magic.\n\n树妖是一种罕见的森林类人，拥有绿色皮肤，身上覆盖着植物。它们很少与其他种族交流，通常更喜欢呆在家里。尽管如此，它们还是很有能力战斗和使用魔法。",
	RACEFAIRYDESCRIPT = "Fairies are curious children of the forests. Looking like half-sized humanoids with a pair of insect wings on their back, fairies possess little physical threat, but their natural magic affinity is incredibly high. Their magic nature even allows them to occasionally heal wounds.\n\n Thankfully they rarely use it aggressively, preferring to instead just have fun and be quick to flee. Despite their childish temper, fairies are very proactive or even omnivorous when it comes down to bodily pleasures not unlike their cave counterparts — Goblins.\n\n仙精是森林里好奇的孩子。仙精看起来像半个人大小的人形，背上有一对昆虫翅膀，几乎没有物理威胁，但它们天生的魔法亲和力非常高。它们的魔法性质甚至让它们偶尔能治愈伤口。\n\n谢天谢地，它们很少激进地使用它，而是喜欢开玩笑，然后迅速逃离。仙精们的脾气很幼稚，但在性行为方面非常积极主动，甚至是杂食性的，这与洞穴中的同类——哥布林没有什么不同。",
	RACEDEMONDESCRIPT = "Demons are a humanoid race that came from outer planes. They can be easily distinguished by their horns, leathery wings and animalistic eyes. Their magical and physical powers are both capable of reaching unusual height when compared to mortals and their temper is on par with it. Demons can be either a dangerous enemy or a mighty ally in case you actually manage to tame one. \n\n恶魔是一个来自外太空的人形种族。他们可以很容易地通过角、坚韧的翅膀和动物般的眼睛来区分。与凡人相比，他们的魔法和体力都能达到不同寻常的高度，他们的脾气也与之相当。恶魔既可以是危险的敌人，也可以是强大的盟友，如果你真的驯服了他们。",
	RACESERAPHDESCRIPT = "Seraphs are angel-like beings, possessing a pair of white wings. Their characters match their pure appearance. While their strength is not very high, they are quite capable of magic. \n\n天使顾名思义，拥有一对白色的翅膀。他们的性格与他们纯洁的外表相匹配。虽然他们的力量不是很高，但他们擅长魔法。",
	RACEDRAGONKINDESCRIPT = "An extremely rare breed of humanoid and dragon. Their dragon ancestry provides them with great strength and magic powers. Like their draconic predecessor they prefer to spend their time in solitude upon the mountains.\n\n一种极其罕见的人形和龙的结合体。他们的龙血统为他们提供了强大的力量和魔力。就像他们的龙祖先一样，他们更喜欢在山上独处。",
	RACETAURUSDESCRIPT = "Taurus are a humanoid race with cow-like features. They excel in raw strength but are subpar in other fields. Most commonly found on the flat plains these creatures have found common acceptance in farming communities for their strength and docile nature.\n\n牛头人是一个具有类似奶牛特征的人形种族。它们在力量方面表现出色，但在其他领域表现不佳。最常见的是在平坦的平原上，这些生物因其力量和温顺的天性而被农业社区普遍接受。",
	RACECENTAURDESCRIPT = "The Centaur race is somewhat distant, yet not unheard of in southern regions. Some individuals have made it very far by adopting a nomadic lifestyle, making the race common enough to be recognized by most. The Centauri population is relatively small, due to dealing with territorial oppression from humanoid races.\n\n半人马族群有点稀少，但在南部地区并非闻所未闻。一些人通过采用游牧生活方式走得很远，使这个种族分布广泛，得到大多数人的认可。半人马座的人口相对较少，这是因为要应对来自类人种族的领土压迫。",
	RACEHARPYDESCRIPT = "Harpies are human-bird hybrids with easily recognizable features, such as their feathered arms and avian lower quarters. Commonly seen as monsters, they have existed since time immemorial. Wild harpies generally inhabit mountain regions and are relatively aggressive. They have a wide range of intelligence, and people have had some success making them into slave-pets.\n\n哈比是人与鸟的杂交种，具有易于识别的特征，如它们长着羽毛的手臂和鸟类的下半身。它们通常被视为怪物，自古以来就存在。野生哈比通常栖息在山区，相对具有攻击性。它们具有广泛的智力，人们已经成功地将它们变成了奴隶宠物。",
	RACESLIMEDESCRIPT = "Some slimes have managed to evolve beyond their usual state and are capable of holding the soul of living beings. Taking on a humanoid appearance they are even able to develop speech and eventually acquire personality. Their bodies are still capable of unusual properties but they are considerably better at controlling it at will. \n\n一些史莱姆已经成功地进化出了超出正常状态的状态，拥有生命的灵魂。呈现出人形的外表，他们甚至能够发展语言并最终获得个性。他们的身体仍然具有不同寻常的特性，但他们更善于随意控制它。",
	RACELAMIADESCRIPT = "Lamias are easily recognized as from the waist down their body becomes a serpentine tail. They tend to be timid in their interactions rarely showing themselves to the majority of the population. Their population has been severely reduced by hunting and extermination expeditions launched by different races. Lamias are surprisingly intelligent, as the few captured and studied samples have shown.\n\n人们很容易认出拉米亚，因为从腰部以下，它们的身体就变成了一条蜿蜒的尾巴。它们在互动中往往很胆小，很少向大多数种群展示自己。由于不同种族发起的狩猎和灭绝探险，它们的种群数量严重减少。正如为数不多的捕获和研究样本所表明的那样，拉米亚斯非常聪明。",
	RACESCYLLADESCRIPT = "Scylla are rather unusual in appearance, possessing a number of tentacle-like appendages they use in the place of legs. They generally prefer damp and aquatic regions. In general, their behavior and capabilities are not much different from lamia. Their appearance is extremely rare to the point of being treated as mere myth or drunken fancy by some.\n\n斯库拉的外表很不寻常，在腿的地方有许多触手状的附属物。它们通常喜欢潮湿和水生的地区。总的来说，它们的行为和能力与拉米亚没有太大区别。它们的外表极为罕见，以至于被一些人视为神话或醉酒的幻想。",
	RACEARACHNADESCRIPT = "Having a humanoid head and torso with the abdomen of a spider it is difficult to mistake an Arachna even though seeing one is rare. Arachna live in isolation and tend to choose caves and other underground locations as their homes. While not being especially aggressive, they are fearsome hunters and have been reported for rare night attacks on both cattle and humans.\n\n拥有蜘蛛腹部的人形头部和躯干，即使很少看到阿拉克尼，也很难将其误认。阿拉克尼在与世隔绝的环境中，倾向于选择洞穴和其他地下地点作为家。虽然它们不是特别好斗，但它们是可怕的猎人，据报道，它们对牛和人类都有罕见的夜间袭击。",
	RACENEREIDDESCRIPT = "Nereid are considered to be another subspecies of the humanoid races, yet they likely split from another race in the distant past. They adapted to an aquatic lifestyle having a fish tail. Nereids are often seen by sailors and fishermen, but they tend to be hesitant in making contact with humans, likely viewing them as a threat.\n\n涅瑞伊得斯被认为是人形种族的另一个亚种，但它们很可能在遥远的过去从另一个种族分裂出来。它们适应了有鱼尾的水生生活方式。水手和渔民经常看到涅瑞伊得斯，但它们在与人类接触时往往犹豫不决，很可能将其视为威胁。",
	RACEBEASTKINDESCRIPT = "Beastkin is a term referring to multiple humanoid-animal races usually of mammalian origins. They tend to be covered in fur and have a slightly more bestial body structure. However their height and behavior is that of a human. Somehow they are able to breed with humans and elves resulting in halfkin hybrids. \n\n兽化裔是一个术语，指的是多个人形动物种族，通常起源于哺乳动物。它们往往全身覆盖着皮毛，身体结构略为兽性。然而，它们的身高和行为与人类相同。不知怎的，它们能够与人类和精灵繁殖，从而形成半亲混血儿。",
	RACEHALFKINDESCRIPT = "Halfkin are Beastkin's hybrids which keep some of their parent's animalistic features but appear much more human, lacking fur and having a more human body. Halfkins are often rejected by their Beastkin parent's race, but often manage to fit into the society of the other one. Despite that, they still tend to inherit some of their Beastkin race's talents, usually being rather different from normal members of the society they are accepted into.\n\n混血裔是兽化裔的混血儿，它们保留了父母的一些动物特征，但看起来更像人，没有皮毛，身体更像人。混血裔经常被兽化裔父母的种族拒绝，并且设法融入另一个种族的社会。尽管如此，它们仍然倾向于继承他们兽化裔种族的一些天赋，通常接纳他们的社会的普通成员不同。 ",
	RACEBEASTKINCATDESCRIPT = "Cat folk are an unusually social breed of Beastkin having no known settlements of their own and living quite openly in populous towns and cities. They have a great deal of popularity among certain crowds for their lush appearance and lascivious nature.\n\n猫族是一种不同寻常的社会性野兽，他们自己没有已知的定居点，在人口众多的城镇中生活得相当公开。他们因其华丽的外表和好色的天性而在某些人群中广受欢迎。",
	RACEBEASTKINWOLFDESCRIPT = "Unlike other Beastkin Wolves are not viewed as simple novelties but are treated as the powerful, agile pack hunters they are. Though they rarely show hostility towards outsiders unless threatened, great caution should be taken when dealing with them.\n\n与其他兽化裔不同，它们不被简单的视为新奇事物，而是被视为强大、敏捷的群体猎人。尽管除非受到威胁，否则它们很少对外来者表现出敌意，但在与它们打交道时应格外小心。",
	RACEBEASTKINFOXDESCRIPT = "Fox folk are a rare and relatively mysterious breed of Beastkin. They display high intelligence, a tendency towards lifelong monogamy, and congregate in small, close-knit communities.\n\n狐人是一种罕见且相对神秘的兽化裔品种。它们表现出高智商，倾向于终身一夫一妻制，并聚集在小而紧密的社区中。",
	RACEBEASTKINBUNNYDESCRIPT = "Bunnies are one of the least self-sufficient, but nonetheless common beast races. They are not aggressive and can be quite timid. They are quite well liked due to their comforting appearance and their natural lewdness which make them a popular choice for slave pets.\n\n兔子是最不自给自足的动物种族之一，但仍然很常见。它们不具攻击性，也很胆小。它们很受欢迎，因为它们令人舒适的外表和天生的色情，这使它们成为奴隶宠物的热门选择。",
	RACEBEASTKINTANUKIDESCRIPT = "The Tanuki are a rare beast race possessing raccoon features. It's hard to pinpoint any specific mental differences between them and the majority of the humanoid races. Some say that their behavior and attitudes are much like that of the average human.\n\n狸人是一个罕见的具有浣熊特征的野兽种族。很难确定他们与大多数人形种族之间的任何具体心理差异。有人说他们的行为和态度很像普通人。",
	RACEHALFKINCATDESCRIPT = "Cat folk are an unusually social breed of Beastkin having no known settlements of their own and living quite openly in populous towns and cities. They have a great deal of popularity among certain crowds for their lush appearance and lascivious nature.\n\n猫族是一种不同寻常的社会性野兽，他们自己没有已知的定居点，在人口众多的城镇中生活得相当公开。他们因其华丽的外表和好色的天性而在某些人群中广受欢迎。",
	RACEHALFKINWOLFDESCRIPT = "Unlike other Beastkin Wolves are not viewed as simple novelties but are treated as the powerful, agile pack hunters they are. Though they rarely show hostility towards outsiders unless threatened, great caution should be taken when dealing with them.\n\n与其他兽化裔不同，它们不被简单的视为新奇事物，而是被视为强大、敏捷的群体猎人。尽管除非受到威胁，否则它们很少对外来者表现出敌意，但在与它们打交道时应格外小心。",
	RACEHALFKINFOXDESCRIPT = "Fox folk are a rare and relatively mysterious breed of Beastkin. They display high intelligence, a tendency towards lifelong monogamy, and congregate in small, close-knit communities.\n\n狐人是一种罕见且相对神秘的兽化裔品种。它们表现出高智商，倾向于终身一夫一妻制，并聚集在小而紧密的社区中。",
	RACEHALFKINBUNNYDESCRIPT = "Bunnies are one of the least self-sufficient, but nonetheless common beast races. They are not aggressive and can be quite timid. They are quite well liked due to their comforting appearance and their natural lewdness which make them a popular choice for slave pets.\n\n兔子是最不自给自足的动物种族之一，但仍然很常见。它们不具攻击性，也很胆小。它们很受欢迎，因为它们令人舒适的外表和天生的色情，这使它们成为奴隶宠物的热门选择。",
	RACEHALFKINTANUKIDESCRIPT = "The Tanuki are a rare beast race possessing raccoon features. It's hard to pinpoint any specific mental differences between them and the majority of the humanoid races. Some say that their behavior and attitudes are much like that of the average human.\n\n狸人是一个罕见的具有浣熊特征的野兽种族。很难确定他们与大多数人形种族之间的任何具体心理差异。有人说他们的行为和态度很像普通人。",
	RACERATKINDESCRIPT = """Ratkin is a race partly related to beastkin and halfkin, being of smaller size with rodentlike features. Their physics allow them to inhabit underground areas, caves and mountains, often contesting other races familiar to such places.""", # MISSING TRANSLATION
	RACERATKINESCRIPT = "Ratkin is a race partly related to beastkin and halfkin, being of smaller size with rodentlike features. Their physics allow them to inhabit underground areas, caves and mountains, often contesting other races familiar to such places.\n\n鼠人是一个与兽化裔和混血裔有部分亲缘关系的种族，体型较小，具有啮齿动物般的特征。它们的物理特性使它们能够栖息在地下区域、洞穴和山脉中，经常与这些地方熟悉的其他种族竞争。 ",
	
	
	SKILLPRAISE = "赞美",
	SKILLPRAISEDESCRIPT = "类别: {color=green|亲切}\n激励下属的基本工具。由魅力因素增强效果。 \n基本效果: \n忠诚 +5, 最大服从。",
	SKILLWARN = "警告",
	SKILLWARNDESCRIPT = "类别: {color=red|刻薄}\n煽动恐惧的基本工具。\n基本效果: \n忠诚 +5, 最大服从。",
	SKILLPUNISH = "惩罚",
	SKILLPUNISHDESCRIPT = "类别: {color=red|刻薄}\n物理惩罚目标。\n基本效果: \n忠诚 +10, 最大服从。",
	SKILLREWARD = "奖励", #obsolete?
	SKILLREWARDDESCRIPT = "类别: {color=green|亲切}\n赢得他们的尊重似乎是一个简单的问题……只要你有足够的硬币。大大提高服从性。",
	SKILLREWARDSEX = "性奖励",
	SKILLREWARDSEXDESCRIPT = "类别: {color=pink|色情}\n释放角色欲望以改善行为。目标必须至少有25欲望。由魅力和性因素提高。\n基本效果: \n忠诚 +5, 最大服从。",
	SKILLMENTOR = """Mentor""", # MISSING TRANSLATION
	SKILLMENTORDESCRIPT = """Category: {color=green|Gracious}
Makes selected character recieve more experience for 1 day under your guidance. """, # MISSING TRANSLATION
	SKILLSEDUCE = "勾引",
	SKILLSEDUCEDESCRIPT = "类别: {color=pink|色情}\n提高服从并减少服从损耗。由魅力因素提高效果。\n基本效果: \n服从损耗-7持续5天，忠诚: +10, 最大服从。",
	SKILLGREATSEDUCE = "高级勾引",
	SKILLGREATSEDUCEDESCRIPT = "类别: {color=pink|色情}\n提高服从，减少服从损耗，防止逃跑尝试，并增加50%的欲望增长。由魅力因素提高效果。\n基本效果:\n 服从损耗-9持续5天，忠诚+15，最大服从。",
	SKILLDRAIN = "吸取",
	SKILLDRAINDESCRIPT = "通过消耗目标的疲劳、法力和能量来恢复。",
	SKILLDRAIN_MANA = "吸取魔力",
	SKILLDRAIN_MANADESCRIPT = "从目标身上窃取高达35%的魔力值。",
	SKILLCONSUME_SOUL = "吞噬灵魂",
	SKILLCONSUME_SOULDESCRIPT = "杀死目标并获得他们的经验。",
	SKILLSERVE = "服务",
	SKILLSERVEDESCRIPT = "类别: {color=green|亲切}\n为他人提供护理服务。提高服从性并增加忠诚度增益。需要20欲望。 \n基本效果: \n忠诚度增益：+1持续5天，最大服从度。",
	SKILLDISCIPLINE = "纪律",
	SKILLDISCIPLINEDESCRIPT = "提高目标的体力劳动表现。 \n基本效果: \n劳动和手工艺效率在5天内提高50%。",
	SKILLSEDATE = "镇静",
	SKILLSEDATEDESCRIPT = "类别: {color=green|亲切}\n让目标的思想放松，让他们更加合作。由魅力因素提高。\n基本效果: \n服从消耗：-10持续2天，忠诚：+4，最大服从度。",
	SKILLFEAR = "恐惧",
	SKILLFEARDESCRIPT = "类别: {color=red|刻薄}\n将恐惧灌输到目标的脑海中。 \n基本效果: \n服从消耗：-6持续4天，忠诚度增益：-1持续4天。最大服从度。",
	SKILLINNERVATE = "支配",
	SKILLINNERVATEDESCRIPT = "恢复目标的能量。效果随着智慧的增长而增长。",
	SKILLSHACKLES = "枷锁",
	SKILLSHACKLESDESCRIPT = "在目标周围制造魔法枷锁。只要它们持续存在，目标就无法逃脱。如果目标的魔法抵抗力很高，枷锁可以随着时间的推移被驱散。\n基本效果: \n服从消耗：-6，忠诚度增益：-3，最大服从。",
	SKILLGREATSHACKLES = "高级枷锁",
	SKILLGREATSHACKLESDESCRIPT = "创造一个更强大的魔法枷锁版本，更难打破。 \n基本效果: \n服从消耗：-10，忠诚度增益：-3，最大服从。",
	SKILLMINDCONTROL = "精神控制",
	SKILLMINDCONTROLDESCRIPT = "压倒目标的思想，迫使其几乎完全屈服。由魅力因素提高效果。 \n基本效果: \n忠诚：+50，最大服从度。",
	SKILLSTOPMINDCONTROL = "移除心灵控制",
	SKILLSTOPMINDCONTROLDESCRIPT = "从目标身上移除心灵控制，赋予他们自由意志。",
	SKILLABUSE = "虐待",
	SKILLABUSEDESCRIPT = "类别: {color=red|刻薄}\n将你的愤怒发泄在别人身上。提高施法者和目标的服从性。 \n基本效果: \n服从：+50（自身），最大目标服从度，忠诚：+5（两者）。",
	SKILLMASTER_LUST_SKILL = "欲望释放",
	SKILLMASTER_LUST_SKILLDESCRIPT = "使用目标的欲望为他们提供特定的好处。目标必须至少有50欲望。",
	SKILLHARDWORK = "努力工作",
	SKILLHARDWORKDESCRIPT = "在3天内将当前位置上所有角色的生产力提高50%。",
	SKILLPUBLICHUMILIATION = "公开羞辱",
	SKILLPUBLICHUMILIATIONDESCRIPT = "类别: {color=red|刻薄}\n为所选目标设置公开羞辱。极大地改善了目标的行为，并略微影响了观众。\n基本效果: \n忠诚：+10（观众一半），最大化服从。",
	SKILLPUBLICSEXHUMILIATION = "公开性羞辱",
	SKILLPUBLICSEXHUMILIATIONDESCRIPT = "类别: {color=pink|色情}\n为所选目标设置公开的性羞辱，改善目标和观众的行为，并为所有观众提供一点欲望。 \n基本效果: \n忠诚：+10（观众一半），欲望：+15，最大化服从。",
	SKILLPUBLICEXECUTION = "公开处决",
	SKILLPUBLICEXECUTIONDESCRIPT = "类别: {color=red|刻薄}\n处决所选角色。极大地提高了所有参与者的服从性。 \n基本效果: \n忠诚：+25，最大服从度。",
	SKILLALLURE = "诱惑",
	SKILLALLUREDESCRIPT = "类别: {color=green|亲切}\n吸引目标，增加他们的服从并减少服从损耗。由魅力因素提高效果。 \n基本效果: \n持续5天的服从消耗-5和忠诚增益+1，最大服从。",
	SKILLSUPREMACY = "至高无上",
	SKILLSUPREMACYDESCRIPT = "类别: {color=green|亲切}\n对施法者充满敬畏和尊重。极大地提高忠诚度。通过魅力因素提高效果。 \n基本效果: \n忠诚：+25，最大服从。",
	SKILLINSPIRE = "灵感",
	SKILLINSPIREDESCRIPT = "对整个团队进行增益，在1场战斗中增加20%的伤害、防御力和魔法防御。",
	SKILLHIDE = "隐藏",
	SKILLHIDEDESCRIPT = "使用户不可成为目标。当它是唯一可能的目标时没有效果。必须没有装备重型或中型装甲。",
	SKILLBARRIER = "屏障",
	SKILLBARRIERDESCRIPT = "提供一个吸收100点伤害的魔法护盾。护盾持续3回合。",
	SKILLASSASSINATE = "Assassinate 暗杀",
	SKILLASSASSINATEDESCRIPT = "造成400%的攻击力的黑暗伤害。必须隐藏才能执行。",
	SKILLPROTECT = "Protect 保护",
	SKILLPROTECTDESCRIPT = "2回合内替代盟友承受伤害。",
	SKILLSHAREDTOY = "共享玩具",
	SKILLSHAREDTOYDESCRIPT = "类别: {color=pink|色情}\n暂时让每个人都感到快乐和放松。提高每个人的服从度。通过魅力因素提高效果。 \n基本效果: \n忠诚+10，最大服从度",
	SKILLPERFORMANCE = "表演",
	SKILLPERFORMANCEDESCRIPT = "类别: {color=green|亲切}\n为您的其他仆人提供一个小的休息和娱乐。通过魅力因素提高效果。 \n基本效果: \n忠诚+5，最大服从。",

	DIALOGUEMASTER_LUST_SKILLTEXT = "在接近[targetname]之前，您应该决定[targethis]累积的欲望将用于什么。\n\n1。将其转化为经验\n2。恢复健康和魔力，提高权威和顺从性\n3。在3天内提高20%的生产力，需要50欲望\n4。增加攻击力和魔法攻击 15%，持续2天，50欲望。",

	DIALOGUEMASTER_LUST_EXPREPORT = "你利用[targetname]的欲望为[targethim]提供经验。",
	DIALOGUEMASTER_LUST_BUFFREPORT = "你利用[targetname]的欲望来提高[targethim]的生产力。",
	DIALOGUEMASTER_LUST_HPREPORT = "你使用[targetname]的欲望来恢复[targethis]健康值和魔力。",
	DIALOGUEMASTER_LUST_OBEDREPORT = "你利用[targetname]的欲望来提高[targethis]的忠诚度。",
	DIALOGUEMASTER_LUST_COMBAT_BUFFREPORT = "你利用[targetname]的欲望来提高[targethis]的战斗熟练度。",

	DIALOGUESUCCUBUS_LUST_XP_CONVERTREPORT = "[name] 消耗 [targetname]的欲望并从中获得经验。 ",
	DIALOGUESUCCUBUS_LUST_HP_CONVERTREPORT = "[name] 消耗 [targetname]的欲望并从中恢复[his]健康值和魔力。 ",
	DIALOGUESUCCUBUS_LUST_OBED_CONVERTREPORT = "[name] 消耗 [targetname]的欲望，并从中变得非常满足。 ",
	DIALOGUESUCCUBUS_LUST_COMBAT_BUFFREPORT = "[name] 消耗 [targetname]的欲望并提高[his]战斗熟练度。 ",

	SKILLSUCCUBUS_LUST_SKILL = "Lust Drain",
	SKILLSUCCUBUS_LUST_SKILLDESCRIPT = "Utilizes target's Lust for self-benefit. Target must have at least 50 lust.",
	DIALOGUESUCCUBUS_LUST_SKILLTEXT = "在接近[targetname]之前，您应该决定[targethis]累积的欲望将用于什么。\n\n1。将其转化为经验\n2。恢复健康值和魔力\n3。获得顺从和忠诚\n4。在2天内增加25%的攻击力和魔法攻击，消耗50点欲望。",

	DIALOGUEPUBLICHUMILIATIONREPORT = "[name]把[targetname]带到了所有人都聚集的大房间。在下面的展示中，当观众听到[targethis]的哭声时，[targethe]受到了惩罚。到最后，[targetname]不仅吸取了[targethis]的教训，而且观众似乎变得更加顺从。 ",
	DIALOGUEPUBLICSEXHUMILIATIONREPORT = "[name]把[targetname]带到了所有人聚集的大房间。在接下来的节目中，[targethe]的性惩罚展现在观众面前。到最后，观察者不仅变得更加顺从，而且还表现出了一些兴奋的迹象。 ",

	DIALOGUEPUBLICEXECUTIONTEXT = "[targetname]听到你的决定后，[he]迅速倒在地板上乞求你饶了[targethis]一命，并承诺做任何事情，永远不会让你失望。 ",
	DIALOGUEPUBLICEXECUTIONREPORT = "你用[targetname]作为你豪宅里每个人的榜样，在他们眼前结束[targethis]的生命。这似乎相当有效，尽管对一些人来说不必要地残忍。",
	DIALOGUEPURCHASEDUNGEONLOCATION = "您购买了一个新地牢的位置，并将其标记在地图上。\n\n在[areaname]解锁的新位置：[locationname]--[locationtypename]。",

	DIALOGUESHAREDTOYREPORT = "[name]肩负着用[his]身体取悦其他仆人的职责……到最后，似乎连你温顺的仆人都满意了。",
	DIALOGUEPERFORMANCEREPORT = "[name] 设置了一个舞台舞蹈，让大家聚在一起观看和放松。人们似乎对[his]表演很满意。",

	DIALOGUEQUESTACCEPT = "你从木板上取一张任务笔记，放进口袋。一旦你能满足它的条件，你就可以在你的豪宅里完成它。 ",

	DIALOGUEPRAISEREPORT = "[name] 赞扬了 [targetname] 的 [targethis] 努力。\n\n{color=aqua|[targetname]} — {random_chat=0|master_praise}",
	DIALOGUEWARNREPORT = "[name] 已向 [targetname] 发出严重警告，使[targethim]更加了解[targethis]的行为。",
	DIALOGUESERVEREPORT = "[name] 已接近 [targetname] ，并向 [targethim] 致以 [his] 最诚挚的爱。",
	DIALOGUEMENTORREPORT = """[name] has began mentoring [targetname] helping [targethim] to learn faster...""", # MISSING TRANSLATION
	DIALOGUESEDUCEREPORT = "[name] 已经接近 [targetname] ，过了几分钟 [targethim] 就想知道了。尽管视觉上很平静， [targetname] 显然已经被 [him]迷住了。",
	DIALOGUEGREATSEDUCEREPORT = "[name] 已经接近 [targetname] ，过了几分钟， [targethim] 感到异常. [targetHis] 思想被强烈的欲望所淹没，让[him]变得相当温顺。",
	DIALOGUEALLUREREPORT = "[name]给了[targetname]一个小小的私人鼓励。",
	DIALOGUEABUSEREPORT = "[name]把[targetname]逼到了角落里，并发泄了[targethim]的一些愤怒。\n\n{color=aqua|[targetname]} — {random_chat=0|abuse}",
	DIALOGUEREWARDREPORT = "[name]为[targethis]的良好行为提供了少量金币。",
	DIALOGUEREWARDSEXREPORT = "[name]照顾了[targetname]的需求，作为对[targethis]善举的奖励。",
	DIALOGUEPUNISHREPORT = "[name]带着[targetname]进入一间私人刑讯室，给[targethim]上了一堂纪律课[targethe]暂时不会忘记。 \n\n{color=aqua|[targetname]} — {random_chat=0|master_punish}",
	DIALOGUESEDATEREPORT = "[name]在[targetname]身上施了一个镇静咒语，使[targethis]平静下来，使[targethe]更加温顺。",
	DIALOGUEFEARREPORT = "[name]在[targetname]身上施了一个恐惧咒语，作为一个严重的警告。在他清醒过来后，[targetname]似乎对他人，尤其是你更加尊重。",
	DIALOGUEINNERVATEREPORT = "[name]在[targetname]上使用咒语来恢复[targethis]的一些能量。",
	DIALOGUESHACKLESREPORT = "[name]在[targetname]身上变出魔法枷锁，阻止[targethim]逃跑。 Timid Factor: +2",
	DIALOGUEGREATSHACKLESREPORT = "[name]对[targetname]施展强大的魔法枷锁，阻止[targethim]逃跑。",
	DIALOGUEMINDCONTROLREPORT = "[name]用强大的魔法主宰[targetname]的头脑，把[targethim]变成一个听话的木偶。",
	DIALOGUESTOPMINDCONTROLREPORT = "[name]从[targetname]脑中删除咒语，允许[targethim]再次独立思考。",
	DIALOGUEHARDWORKREPORT = "[name]激励[targetname]更加努力地工作。",
	DIALOGUEDISCIPLINEREPORT = "[name]训练[targetname]更加努力地工作。",
	DIALOGUEAUTHORITYREPORT = "[name]使用[his]权威，使[targetname]更加努力地工作。",
	DIALOGUECONSUME_SOULREPORT = "[name] 消灭 [targetname] 并吞噬 [targethis] 的灵魂, 汲取 [targethis] 的经验。 ",
	DIALOGUEMAKE_UNDEADREPORT = "[name]在不知不觉中为仪式做准备。在被麻醉后，魔咒迫使生命离开[targetname]的身体，停止[targethis]的心跳，但将[targethis]的灵魂困在体内。当[targethe]恢复清醒并意识到[targethis]的新状态时，意识到[targethe]再也回不去的震惊离开了[targethim]无言以对。",
	DIALOGUEALCOHOLREPORT = "[name] 用一瓶酒放松。",
	DIALOGUEAPHRODISIACREPORT = "[name] 服用春药，感受强烈的性欲。",
	DIALOGUETAMEDRUGREPORT = "吸食毒品后, [name] 似乎变得更加温顺了。 ",
	DIALOGUERAGEDRUGREPORT = "吸食毒品后, [name] 似乎变得更加野蛮了。",
	DIALOGUESEXDRGUREPORT = "吸食毒品后, [name]的大脑会专注于猥亵的事情...",
	DIALOGUEEXP_SCROLLREPORT = "[name] 阅读卷轴。新知识充斥 [his] 脑海...",

	DIALOGUEENSLAVETEXT = "你找到了一位官员，他准备帮助你完成任务。付款后，你收到了一份 [name] 的所有权文件，他对此反应非常不安。\n\n{color=aqua|[name]} — {random_chat=0|enslave}",
	DIALOGUEHIRETEXT = "在签署文件并与您的钱告别后, [name] 来到您面前鞠躬。\n\n{color=aqua|[name]} — {random_chat=0|hire}",#\n\n— 很高兴见到您, [master], 我将为您服务。

	SKILLPET_LUST_SKILL = "Lust Serve",
	SKILLPET_LUST_SKILLDESCRIPT = "Utilizes personal Lust to provide target with a specific bonus. Requires at least 50 lust.",
	SKILLMAKE_UNDEAD = "Turn Undead",
	SKILLMAKE_UNDEADDESCRIPT = "Makes selected charcter into Undead. Undead's charm is reduced by 100, food consumption is set to 0. Undead can't impregnate or get pregnant. Undead have increased Dark resist and reduced Light resist. \n\nCan't be used on Unique Characters.",
	
	DIALOGUEPET_LUST_SKILLTEXT = "在接近[targetname]之前，您应该决定[name]累积的欲望将用于什么。\n\n1。完全恢复服从并获得一些忠诚度\n2。将其转化为经验\n3。恢复健康值和魔力",
	CONSENT0 = """Innocent""", # MISSING TRANSLATION
	CONSENT1 = """Curious""", # MISSING TRANSLATION
	CONSENT2 = """Developing""", # MISSING TRANSLATION
	CONSENT3 = """Willing""", # MISSING TRANSLATION
	CONSENT4 = """Lusty""", # MISSING TRANSLATION
	CONSENT5 = """Kinky""", # MISSING TRANSLATION
	CONSENT6 = """Deviant""", # MISSING TRANSLATION

	TRAITMASTERDESCRIPT = "Social skills build targets Loyalty 30% faster. \nIsn't affected by Obedience or Loyalty. Will not resist work or attempt escapes.\n社交技能的建立目标忠诚度提高30%。\n不受顺从或忠诚度的影响。不会抗拒工作或试图逃跑",
	TRAITWORKERDESCRIPT = "Woodcutting and Mining are 50% more efficient.\n伐木和采矿效率提高50%",
	TRAITFOREMANDESCRIPT = "Woodcutting and Mining are 33% more efficient\n伐木和采矿效率提高33%",
	TRAITHUNTERDESCRIPT = "Fishing and Hunting are 50% more efficient.\n捕鱼和狩猎效率提高50%",
	TRAITSMITHDESCRIPT = "Craft Smith and Tailor items 100% faster.\n锻造和裁缝物品的速度提高100%",
	TRAITENGINEERDESCRIPT = "Upgrading is 100% faster.\n升级速度快100%",
	TRAITCHEFDESCRIPT = "Cooking is 100% faster.\n烹饪速度快100%",
	TRAITATTENDANTDESCRIPT = "Once per combat turn [name] can use an item without using a turn.\n每个战斗回合[name]可以使用一个物品而不使用回合。",
	TRAITALCHEMISTDESCRIPT = "Crafts alchemical products 100% faster.\nHealing items are 25% more effective in combat.\n制作炼金产品的速度提高100%。\n治疗道具在战斗中的效率提高25%。",
	TRAITFARMERDESCRIPT = "Farming is 50% more efficient. \n农业效率提高50%",
	TRAITBREEDERDESCRIPT = "Allows breeding with any race.\nPregnancy Debuffs are weaker\nOffspring will inherit only this parent's stats.\n允许与任何种族繁殖。\n后代出道较弱\n后代将只继承此亲本的统计数据",
	TRAITHARLOTDESCRIPT = "Prostitution is 50% more efficient.\n卖淫的效率提高50%",
	TRAITSUCCUBUSDESCRIPT = "Sex activities provide 50% more experience.\n性活动提供50%额外经验",
	TRAITPETDESCRIPT = "Prostitution is 25% more efficient.\n卖淫的效率提高25%",
	TRAITSEXTOYDESCRIPT = "Prostitution is 50% more efficient.\n卖淫的效率提高50%",
	TRAITWITCRITDESCRIPT = "Increases critical strike chance by 3% per Wits Factor.\n每个智慧因素增加3%的暴击几率",
	TRAITDIRECTORDESCRIPT = "Social skills are 50% more efficient. \n社交技能效率提高50%",
	TRAITVALKYRIE_SPEARDESCRIPT = "+10 Speed while equipped with Spear.\n装备长矛时速度+10",
	TRAITAUTOHIDE = "Conceal.\n概念",
	TRAITAUTOHIDEDESCRIPT = "Starts combat in Hide if no Heavy or Medium Armor is equipped.\n如果没有装备重型或中型装甲，则在隐藏状态下开始战斗",
	TRAITDEATHKNIGHTDESCRIPT = """Dealing a killing blow increases Loyalty.""", # MISSING TRANSLATION
	TRAITNINJADESCRIPT = """Gain evasion based on your MDEF. Minimal chance for evading hit is reduced to 5%.""", # MISSING TRANSLATION
	TRAITWITCHDESCRIPT = """Your critical hits with spells apply random debuff. Healing spells have chance to apply healing over time.""", # MISSING TRANSLATION
	TRAITWARLOCKDESCRIPT = """Single target spells gain 25% increased critical chance and deal 75% bonus critical damage.""", # MISSING TRANSLATION
	TRAITTRUE_SUCCUBUSDESCRIPT = """When taking hit in combat generate some Lust.""", # MISSING TRANSLATION
	
	TRAITBASIC_COMBAT = "Basic Combat 基本战斗",
	TRAITADVANCED_COMBAT = "Advanced Combat 高级战斗",
	TRAITBASIC_SPELLS = "Basic Spellcasting 基本施法",
	TRAITADVANCED_SPELLS = "Advanced Spellcasting 高级施法",
	TRAITBASIC_COMBATDESCRIPT = "Allows to learn basic combat skills and weapons\n允许学习使用基本作战技能和武器",
	TRAITADVANCED_COMBATDESCRIPT = "Allows to learn advanced combat skills and weapons\n允许学习使用先进的作战技能和武器",
	TRAITBASIC_SPELLSDESCRIPT = "Allows to learn basic combat spells and staves\n允许学习使用基本的战斗法术和法杖",
	TRAITADVANCED_SPELLSDESCRIPT = "Allows to learn advanced combat spells and staves\n允许学习使用高级战斗法术和法杖",
	
	TRAITHUNTER_DAMAGEDESCRIPT = "Damage vs Beasts: +15%\n对野兽的伤害：+15%",
	TRAITBISHOPDESCRIPT = "Light Magic damage: +40%\n光魔法伤害：+40%",
	TRAITDRUIDDESCRIPT = "Earth Spell damage: +20%\n地法术伤害：+20%",
	TRAITBERSERKERDESCRIPT = "Fire and Earth Physical damage: +20%\n火和地物理伤害：+20%",
	TRAITSNIPERDESCRIPT = "Single Target Physical damage: +25%\n单目标物理伤害：+25%",
	TRAITPALADINDESCRIPT = """{color=brown|Smite}: Deal 25% more damage and take 15% less damage from Undead and Demon type enemies.""", # MISSING TRANSLATION
	TRAITASSASSINDESCRIPT = """{color=brown|Stealth Mastery}: Hiding can be activated in Medium Armor.""", # MISSING TRANSLATION
	TRAITBLOODMAGEDESCRIPT = """{color=brown|Blood Mastery}: Dealing damage to bleeding targets recovers HP and MP and increases MATK until end of fight.""", # MISSING TRANSLATION
	TRAITNECROMANCERDESCRIPT = """{color=brown|Mastery of the Dead}: Passive Summon: Skeletons. Number skeletons is defined by Magic Factor.""", # MISSING TRANSLATION
	TRAITRANGERDESCRIPT = """{color=brown|Animal Companion}: Passive Summon: Trained Dog""", # MISSING TRANSLATION
	TRAITALIOSDESCRIPT = """{color=brown|Unbound}: When only character is alive in party: gain +50 evasion, +20 speed until end of battle.""", # MISSING TRANSLATION
	TRAITSADISTDESCRIPT = """{color=brown|Open Vein}: Melee physical attacks have 25% chance to cause Bleeding for 2 turns.""", # MISSING TRANSLATION
	
	TRAITHEALER1 = "Healer:Novice 治疗者：新手",
	TRAITHEALER1DESCRIPT = "Healing spells are 25% more effective.\n治疗法术的效果提高25%。",
	TRAITHEALER2 = "Healer:Expert 治疗者：专家",
	TRAITHEALER2DESCRIPT = "Healing spells are 25% more effective.\n治疗法术的效果提高25%。",
	
	
	
	TRAITWEAPON_MASTERY = "Weapon Mastery 武器精通",
	TRAITMEDIUM_ARMOR = "Medium Armor 中型装甲",
	TRAITHEAVY_ARMOR = "Heavy Armor 重型装甲",
	TRAITRANGED_WEAPON_MASTERY = "Ranged Weapon Mastery 远程武器精通",
	TRAITMAGIC_TOOLS = "Magic Tools 魔法工具",
	TRAITMEDIUM_ARMORDESCRIPT = "Allows the usage of Medium Armor. 允许使用中型装甲",
	TRAITHEAVY_ARMORDESCRIPT = "Allows the usage of Heavy Armor. 允许使用重型装甲",
	TRAITLOCKPICKINGDESCRIPT = "Greatly increases the chance to pick locks. 极大地增加了开锁的机会",
	TRAITTRAP_DETECTIONDESCRIPT = "Increases a chance to disarm traps. 增加解除陷阱的几率",
	TRAITTRAP_ANALYZEDESCRIPT = "Gives a chance to discover trap's nature and slightly increase a chance to disarm traps. 有机会发现陷阱的性质，并略微增加解除陷阱的机会",
	TRAITWEAPON_MASTERYDESCRIPT = "Allows the use of Melee Weapons 允许使用近战武器",
	TRAITRANGED_WEAPON_MASTERYDESCRIPT = "Allows the use of Ranged Weapons. 允许使用远程武器",
	TRAITMAGIC_TOOLSDESCRIPT = "Allows the use of magic tools such as staves. 允许使用诸如棍子之类的魔法工具",
	
	TRAITUNDEADDESCRIPT = "[name] is no longer a living being. Food consumption is set to 0; Charm is reduced by 100; Light Resist -50; Dark Resist +50; Dark Damage +20%%; Can't impregnate or get pregnant.\n[name]不再是生物。食物消耗设置为0；魅力减少100；光抗性-50；暗抗性+50；暗伤害+20%%；不能怀孕或使人怀孕。",
	TRAITSPOUSE = "Spouse 配偶",
	TRAITSPOUSEDESCRIPT = "Future children between Master and Spouse recieve Heir status instead of Slave or Peon. \n主人和配偶之间的未来子女获得继承人身份，而不是奴隶或雇工。",
	
	TRAITPRODIGY = "Prodigy 神童",
	TRAITPASSIVE = "Passive 被动",
	TRAITNIMBLE = "Nimble 灵活",
	TRAITQUICK = "Quick 迅捷",
	TRAITHANDY = "Handy 巧手",
	TRAITDEADLY = "Deadly 致命",
	TRAITLIVELY = "Lively 生机勃勃",
	TRAITMVORTEX = "Magic Vortex 魔力漩涡",
	TRAITGIFTED = "Gifted 天赋异禀",
	TRAITBELLIGERENT = "Belligerent 好战",
	TRAITHIDDENPOWERS = "Hidden Powers 隐藏的力量",
	TRAITHEALTHY = "Healthy 健康",
	TRAITDIM = "Dim 愚蠢",
	TRAITREBEL = "Rebellious 叛逆",
	TRAITSLOW = "Slow 缓慢",
	TRAITCLUMSY = "Clumsy 笨拙",
	TRAITINEPT = "Inept 无能",
	TRAITSICKY = "Sickly 病态",
	TRAITMAGICMUTT = "Magic Mutt 魔力失聪",
	TRAITBLUNDERING = "Blundering 浮躁",
	TRAITCRUDE = "Crude 粗鲁",
	TRAITCHASTE = "Chaste 纯洁",
	TRAITPACIFIST = "Pacifist 平和",
	TRAITWHIMP = "Wimp 懦弱",
	TRAITM_INEPT = "Magically Inept 魔力无能",
	TRAITSELFISH = "Selfish 自私",
	TRAITCOWARD = "Coward 胆小鬼",
	TRAITFRIGID = "Frigid 性冷淡",
	TRAITBAWDY = "Bawdy 淫乱",
	TRAITFORAGER = "Forager 觅食者",
	TRAITTALENTED = "Talented 才华横溢",
	TRAITMENIAL = "Menial 才疏学浅",
	TRAITSTURDY = "Sturdy 坚固",
	TRAITFRAIL = "Frail 脆弱",
	
	
	TRAITPRODIGYDESCRIPT = "Gain 25% more EXP points.\n获得25%额外经验值",
	TRAITPASSIVEDESCRIPT = "Obedience Drain -5.\n顺从流失-5",
	TRAITNIMBLEDESCRIPT = "Speed is increased by 10.\n速度增加10",
	TRAITQUICKDESCRIPT = "Collection modifier +20%.\n收集工作效率+20%",
	TRAITHANDYDESCRIPT = "Craft modifier +20%.\n工艺工作效率+20%",
	TRAITDEADLYDESCRIPT = "Crit Chance +9%.\n暴击几率+9%",
	TRAITLIVELYDESCRIPT = "+3 Health Regen\n+3健康恢复",
	TRAITMVORTEXDESCRIPT = "+1 Mana Regen\n+1魔力恢复",
	TRAITGIFTEDDESCRIPT = "Maximum Mana +100%.\n最大魔力+100%",
	TRAITBELLIGERENTDESCRIPT = "ATK +15%.\n攻击力+15%",
	TRAITHIDDENPOWERSDESCRIPT = "MATK +10%.\n魔法攻击+10%",
	TRAITHEALTHYDESCRIPT = "+10 Max Health.\n+10最大生命值",
	TRAITDIMDESCRIPT = "Gain 25% less EXP points.\n经验值获取减少25%",
	TRAITREBELDESCRIPT = "Obedience Drain +5.\n顺从流失+5",
	TRAITSLOWDESCRIPT = "Speed is reduced by 10.\n速度降低10",
	TRAITCLUMSYDESCRIPT = "Collection modifier -80%.\n收集工作效率-80%",
	TRAITINEPTDESCRIPT = "Craft modifier -80%.\n工艺工作效率-80%",
	TRAITSICKYDESCRIPT = "-3 Health Regen\n-3健康再生",
	TRAITMAGICMUTTDESCRIPT = "Maximum mana -50%.\n最大魔力值-50%",
	TRAITBLUNDERINGDESCRIPT = "Collection, Fishing, Farming tasks -80% efficiency.\n收集、捕鱼、耕作任务-80%的效率。",
	TRAITCRUDEDESCRIPT = "Tailor, Smith, Alchemy tasks -80% efficiency.\n裁缝，铸造，炼金任务-80%效率。",
	TRAITCHASTEDESCRIPT = "Prositution Task -80% efficiency.\n卖淫任务-80%的效率",
	TRAITPACIFISTDESCRIPT = "ATK -50%.\n攻击力-50%",
	TRAITWHIMPDESCRIPT = "HP MAX -40%.\nHP最大值-40%",
	TRAITM_INEPTDESCRIPT = "MATK -50%.\n魔法攻击-50%",
	TRAITSELFISHDESCRIPT = "Can't use combat supporting Abilities.\n不能使用战斗支援能力",
	TRAITCOWARDDESCRIPT = "Hit Rate -50.\n命中率-50",
	TRAITFRIGIDDESCRIPT = "Can't acquire new sex traits. Maximum lust is reduced by 50%.\n无法获得新的性特征。最大欲望减少50%",
	TRAITBAWDYDESCRIPT = "Service Mod +25%.\n服务任务效率+25%",
	TRAITFORAGERDESCRIPT = "30% Chance to not consume any food on day end.\n30%的机会在一天结束时不消耗任何食物",
	TRAITTALENTEDDESCRIPT = "Task Crit chance +15%.\n任务暴击几率+15%",
	TRAITMENIALDESCRIPT = "Task Crit chance is set to 0.\n任务暴击机会设置为0",
	TRAITSTURDYDESCRIPT = "+10 DEF.\n+10防御力",
	TRAITFRAILDESCRIPT = "-10 DEF.\n-10防御力",
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
	TRAITLOYALTY_EXHIBITIONISMDESCRIPT = "{color=green|Unlocks Nudity}\n\nObserve and enjoy. This slave is eager to show others their prowress at their masters command.\n\nRequires: Basic Servitude",
	TRAITLOYALTY_PROSTITUTION = "Prostitution",
	TRAITLOYALTY_PROSTITUTIONDESCRIPT = "{color=green|Unlocks Prostitution Occupation}\n\nCarnal pleasures for coin. Pleasure or not matters little when the alternative is an empty stomach.\n\nRequires: Basic Servitude",
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
	TRAITMASTER_MENTOR = """Mentor""", # MISSING TRANSLATION
	TRAITMASTER_MENTORDESCRIPT = """All present and future characters automatically receive Basic Obedience and Combat loyalty traits.""", # MISSING TRANSLATION
	TRAITMASTER_HARLOTRY = """Harlotry""", # MISSING TRANSLATION
	TRAITMASTER_HARLOTRYDESCRIPT = """While in service you still receive Rest benefits.""", # MISSING TRANSLATION
	TRAITMASTER_PROGENECY = """Progenecy""", # MISSING TRANSLATION
	TRAITMASTER_PROGENECYDESCRIPT = """Removes race impregnation restrictions.""", # MISSING TRANSLATION
	TRAITMASTER_COMMUNICATIVE = """Communicative""", # MISSING TRANSLATION
	TRAITMASTER_COMMUNICATIVEDESCRIPT = """Social skills gain 1 additional charge. Personality influences are twice as strong.""", # MISSING TRANSLATION
	TRAITMASTER_RESILENCE = """Resilence""", # MISSING TRANSLATION
	TRAITMASTER_RESILENCEDESCRIPT = """ """, # MISSING TRANSLATION
	TRAITMASTER_FORTUNE = """Fortune""", # MISSING TRANSLATION
	TRAITMASTER_FORTUNEDESCRIPT = """Critical chance is increased by 25%. Slightly increases Magic Find.""", # MISSING TRANSLATION
	TRAITMASTER_INT = """Intelligence""", # MISSING TRANSLATION
	TRAITMASTER_INTDESCRIPT = """Increases Skill Points gain by 50%.""", # MISSING TRANSLATION
	TRAITMASTER_FORTITUDE = """Fortitude""", # MISSING TRANSLATION
	TRAITMASTER_FORTITUDEDESCRIPT = """Grave Injury from being defeated only last 2 turns.""", # MISSING TRANSLATION
	TRAITMASTER_SORCERY = """Sorcery""", # MISSING TRANSLATION
	TRAITMASTER_SORCERYDESCRIPT = """MATK +35%, faster mana recovery speed.""", # MISSING TRANSLATION
	
	
	
	TRAITEFFECTVIRGIN = "[center]{color=yellow|Virginity}[/center]\nAs [name] has a observable virginity, this makes [him] more desirable for certain tasks and individuals. \n{color=yellow|Value is increased by 25%%}",
	TRAITEFFECTRARESTURDY = "Rare: Sturdy\nIncreased Health and Armor Penetration",
	TRAITEFFECTRARENIMBLE = "Rare: Nimble\nIncreased Evasion and Speed",
	TRAITEFFECTRARESTRONG = "Rare: Strong\nIncreased Damage and Maximum Health",
	TRAITEFFECTRAREDEADLY = "Rare: Deadly\nIncreased Damage and Hitrate",
	TRAITEFFECTRAREPRECISE = "Rare: Precise\nIncreased Evasion, Hitrate and MDEF",
	TRAITEFFECTRARETOUGH = "Rare: Tough\nIncreased Health, DEF and MDEF",
	TRAITEFFECTHARDWORK = "Hard Work: +50%% Productivity",
	TRAITEFFECTPHYSBUF = """Elixir of Ogre's Strength: +80 Physics""", # MISSING TRANSLATION
	TRAITEFFECTWITSBUF = """Elixir of Expanded Mind: +80 Wits""", # MISSING TRANSLATION
	TRAITEFFECTFAVFOOD = "Favorite Food: -1 Obedience Drain, +0.5 Loyalty Gain.", 
	TRAITEFFECTHATEDFOOD = "Hated Food: -10%% Productivity.",
	TRAITEFFECTSTARVE = "Starvation: -50%% Productivity, -50%% Damage.",
	TRAITEFFECTGRAVEINJ = "Grave Injury: -25%% Productivity, -50 Sexuals. Can't participate in Combat.",
	TRAITEFFECTDISCIPLINE = "Discipline: +50%% Labor and craft efficiencies.",
	TRAITEFFECTSEDUCE= "Seduce: -7 Obedience drain",
	TRAITEFFECTGREATSEDUCE = "Great Seduce: Prevents escapes; -9 Obedience drain, +50%% Lust growth.",
	TRAITEFFECTALLURE = "Allure: -5 Obedience drain, +1 Loyalty gain.",
	TRAITEFFECTSEDATED = "Sedated: -10 Obedience drain",
	TRAITEFFECTFEAR = "Fear: -6 Obedience drain, -1 Loyalty gain.",
	TRAITEFFECTMINDCONTROLLED = "Mind Controlled",
	TRAITEFFECTINSPIRED = "Inspired: +20%% damage, DEF and MDEF.",
	TRAITEFFECTCOMMANDED = "Commanded: +50%% ATK and MATK.",
	TRAITEFFECTSERVING = "Serving: +1 Loyalty gain.",
	TRAITEFFECTREFINE = "Weapon refined: +30%% ATK.",
	TRAITEFFECTACID = "Acid: -25 DEF.",
	TRAITEFFECTATTRACTED = "Attracted: -30%% Damage",
	TRAITEFFECTPROTECTION = "Protection: +25 DEF.",
	TRAITEFFECTISPROTECTED = "Is protected",
	TRAITEFFECTDRAGONSMIGHT = "Dragon's Might: +25%% Damage and DEF.",
	TRAITEFFECTBARRIER = "Damage-absorbing shield, blocks 100 damage (%d remains)",
	TRAITEFFECTBLIZZARD = "Blizzard: -20 Speed.",
	TRAITEFFECTBLESSED = "Blessed: +25%% ATK.",
	TRAITEFFECTMENTALBLESS = "Mentally Blessed: +25%% MATK.",
	TRAITEFFECTFLY = "Flying: +65 Evasion.",
	TRAITEFFECTSHATTERED = "Shattered: -25 Evasion.",
	TRAITEFFECTFIREBURST = "Fire Burst: -20 Hit Rate.",
	TRAITEFFECTSWIPE = "Swipe: -20 DEF.",
	TRAITEFFECTARROWRAIN = "Arrow Rain: -20 MDEF.",
	TRAITEFFECTSSTRIKE = "-20 ATK and MATK.",
	TRAITEFFECTENDURE = "Endure: +20 All resists.",
	TRAITEFFECTBARD1 = "Hymn: +20 Hit Rate, Evasion and Speed.",
	TRAITEFFECTBARD2 = "Soothe: +15 DEF and MDEF, dispels 1 negative effect every turn",
	TRAITEFFECTBARD3 = "Warmarch: +20%% ATK and MATK.",
	TRAITEFFECTELEMENTALWEAK = "Elemental Weakness: -40 Fire, Earth, Water and Air Resistances.",
	TRAITEFFECTELEMENTALPROTECT = "Elemental Protection: +40 Fire, Earth, Water and Air Resistances.",
	TRAITEFFECTCAMO = "Camouflage: +20 Evasion.",
	TRAITEFFECTHMARK = "Hunter's Mark: Receives 15%% more damage",
	TRAITEFFECTDEVOUR = "Spirit devoured",
	TRAITEFFECTSPIRIT1 = "Spirit - Hare: +30 Speed, +25 Evasion.",
	TRAITEFFECTSPIRIT2 = "Spirit - Turtle: -25%% Skill Damage taken, -15%% Spell Damage taken",
	TRAITEFFECTSPIRIT3 = "Spirit - Eagle: +20%% Skill damage, +30 Hit Rate.",
	TRAITEFFECTHIDE = "Hidden",
	TRAITEFFECTREINCARNATE = "Will be reborn on death",
	TRAITEFFECTHOLY = "Divine Radiance: -20 MDEF.",
	TRAITEFFECTPOSITIONTAKEN = "Position Taken: +50 Armor Penetration; +20%% Damage.",
	TRAITEFFECTWINDWALL = "Wind Wall: -50%% Randged Damage.",
	TRAITEFFECTPETSUIT = "When wearer has Pet class:\nCharm: +10\nSocial skills effect: +10%.",
	TRAITEFFECTWORKEROUTFIT = "Hunting, Fishing and Collecting Tasks: +25%",
	TRAITEFFECTCRAFTSMANSUIT = "Cooking, Smithing, Alchemy, Tailor and Upgrading Tasks: +25%",
	TRAITEFFECTANAL = 'If wearer has "Likes Anal" trait: Lust growth + 15%.',
	TRAITEFFECTHANDCUFFS = 'Prolonged wearing might cause wearer to become Submissive.',
	TRAITEFFECTANALCOUNT = 'Prolonged wearing makes wearer more responsive to Anal.',
	TRAITEFFECTTAILPLUG = 'Increases Lust growth by 10%.',
	TRAITEFFECTTAILPLUGBONUS = 'Increases Charm by 10 if Pet Suit equipped.',
	TRAITEFFECTUNDERWEAR = 'Increases Lust growth by 25%.',
	TRAITEFFECTTENTACLESUIT = 'Increases Lust growth by 100%%.',
	TRAITEFFECTTENTACLESUB = 'Reduces Physics and Wits by 25 if character has less than 5 Sex Factor and no Deviant trait.',
	TRAITEFFECTMASTERCOMBAT = "ATK and MATK are increased by 15%%",
	TRAITEFFECTMASTERPRODUCT = "+20%% Productivity.",
	TRAITEFFECTSATISFIED = "Satisfied: +10%% Productivity.",
	TRAITEFFECTSATISFIED2 = "Satisfied: +20%% Productivity.",
	TRAITEFFECTSUCCOMBAT = "Lust Drained: +25%% ATK and MATK.",
	TRAITEFFECTCELENABLESS = "Celena's Blessing: +30%% All resistances.",
	TRAITEFFECTFREYABLESS ="Freya's Blessing: +30 Armor Penetration, +25 Hit Rate.",
	TRAITEFFECTCELENACURSE = "Celena's Curse: -50%% Max. Health.",
	TRAITEFFECTFREYACURSE = "Freya's Curse: -50 Evasion and Hit Rate.",
	TRAITEFFECTDATEBONUS = "Loyalty gain increased by 0.5.",
	TRAITEFFECTRESISTSTATE = "Resist state: Can't gain obedience from positive abilities. Can't use exploration skills. Positive actions during dates less effective.",
	TRAITEFFECTISPREGNANT = "Is pregnant: -10 Speed, -20 Physics",
	TRAITEFFECTISPREGNANT2 = "Is heavily pregnant: -20 Speed, -40 Physics",
	BUFFDESCRIPTSHACKLES = "Shackles",
	BUFFDESCRIPTGREATSHACKLES = "Great Shackles",
	BUFFDESCRIPTCHARM = "Is charmed. %d hours remains",
	BUFFDESCRIPTSTUN = "Stunned: Cannot act",
	BUFFDESCRIPTCHARM2 = "Charmed: Cannot act",
	BUFFDESCRIPTTRAP = "Trapped: Cannot act",
	BUFFDESCRIPTMIRROR = "Mirror Image: Chance to evade damage from skills",
	BUFFDESCRIPTFIELD = "Energy Field: Chance to deal Air Spell damage to attacker",
	BUFFDESCRIPTSHELL = "Protective Shell: Incoming damage reduced by 35%%",
	BUFFDESCRIPTTAUNT = "Taunted",
	BUFFDESCRIPTDISTRACT = "Distracted: -30 Hit Rate and Evasion",
	BUFFDESCRIPTSILENCE = "Silenced",
	BUFFDESCRIPTFROZEN = "Frozen: Cannot act, receives 100%% more Air damage",
	BUFFDESCRIPTDISARM = "Disarmed: Can't use Skill type abilities",
	BUFFDESCRIPTBANISH = "Banish",
	BUFFDESCRIPTVOID = "Void",
	BUFFDESCRIPTDEFEND = "Defend",
	BUFFDESCRIPTREGEN = "健康再生",
	BUFFDESCRIPTBURNING = "燃烧",
	BUFFDESCRIPTPOISON = "中毒",
	BUFFDESCRIPTBLEEDING = "流血",
	BUFFDESCRIPTCONFUSE = "Confusion",
	BUFFDESCRIPTFREEUSE = "Allows to use an item without taking a turn",
	BUFFDESCRIPTSHRED = "Armor reduced",
	BUFFDESCRIPTGROWL = "Speed and evasion decreased",
	BUFFDESCRIPTCURSEATTACK = "Attack decreased",
	BUFFDESRIPTCURSEATTACKTR = "Attacking this target causes ATK decreased",
	BUFFDESCRIPTMAGICWARD = "Attack and MFED increased",
	BUFFDESCRIPTSLAM = "Healing reduced",
	BUFFDESCRIPTFIRESHIELD = "Fire shield",
	BUFFDESCRIPTATKPAS = "Damage increased",
	BUFFDESCRIPTATTACKPASSSRC = "Increases ATK and MATK of allies by 10 every other turn. Clears when defeated.",
	BUFFDESCRIPTRESTO = "Resting: physical resist increased by 20%%",
	BUFFDESCRIPTCURSE = """""", # MISSING TRANSLATION
	BUFFDESCRIPTENCHANT = """""", # MISSING TRANSLATION
	BUFFDESCRIPTMENTOR = """Experience Gain increased""", # MISSING TRANSLATION
	
	
	
	
	
	
	
	PROFMASTER = "Master 主人",
	PROFMASTERALT = "Mistress 女主人",
	PROFMASTERDESCRIPT = "The sole ruler of a domain. [His] power strikes fear and respect not only in newcomers, but even in seasoned servants.\n一个领域的唯一统治者。[His]权力不仅在新来者身上，甚至在经验丰富的仆人身上都会引起恐惧和尊重",
	PROFRULER = "Ruler 标尺",
	PROFRULERDESCRIPT = "A step above being just a [master]. A ruler is the ultimate person, not only having complete authority, but also inspiring others to greater deeds.\n比成为[master]更伟大。统治者是完美的化身，不仅拥有完全的权威，还激励他人做出更大的贡献",
	PROFDIRECTOR = "Director 主管",
	PROFDIRECTORDESCRIPT = "Director can issue a higher tier of discipline on servants in the name of the [master]. \n主管可以以[master]的名义对仆人进行更高级别的纪律处分",
	PROFSADIST = "Sadist 施虐狂",
	PROFSADISTDESCRIPT = "Sadists take pleasure in abusing others and are useful for little else. Still, they can be a boon when you aim to rule with fear. \n施虐狂以虐待他人为乐，对其他人几乎没有用处。不过，当你打算用恐惧来统治时，他们可能是一个福音",
	PROFWATCHDOG = "Watchdog 看门狗",
	PROFWATCHDOGDESCRIPT = "The servants who've proven their loyalty to their master are allowed to act in his name to ensure obedience and fear in others.\n那些已经证明对主人忠诚的仆人可以以主人的名义行事，以确保他人服从和恐惧",
	PROFHEADGIRL = "Headgirl 女管家",
	PROFHEADGIRLALT = "Butler 管家",
	PROFHEADGIRLDESCRIPT = "A servant with higher authority that is allowed to direct multiple lower servants at once.\n具有更高权限的仆人，可以同时指挥多个下级仆人",
	PROFTRAINER = "Trainer 培训师",
	PROFTRAINERDESCRIPT = "Trainers can dramatically change the attitude of a very rebellious slave.\n 培训师可以极大地改变一个非常叛逆的奴隶的态度",
	PROFWORKER = "Worker 工人",
	PROFWORKERDESCRIPT = "Workers are great manual laborers for your everyday needs. They gather resources much faster than others.\n工人是满足你日常需求的优秀体力劳动者。他们比其他人更快地收集资源",
	PROFFOREMAN = "Foreman 工头",
	PROFFOREMANDESCRIPT = "A seasoned worker is not only more proficient, but also can boost productivity of other workers.\n一个经验丰富的工人不仅更熟练，而且可以提高其他工人的生产力",
	PROFHUNTER = "Hunter 猎人",
	PROFHUNTERDESCRIPT = "Hunters specialize in tracking and killing game.\n猎人专门从事追踪和杀戮游戏",
	PROFSMITH = "Blacksmith 铁匠",
	PROFSMITHDESCRIPT = "Smiths are master craftsmen, able to work with all sorts of materials.\n铁匠是能工巧匠，能够使用各种材料",
	PROFCHEF = "Chef 厨师",
	PROFCHEFDESCRIPT = "A skilled cook is always a valuable addition to any household.\n一个熟练的厨师总是任何家庭的宝贵补充",
	PROFATTENDANT = "Attendant 侍从",
	PROFATTENDANTDESCRIPT = "Attendants help out other characters while in the battlefield and learn to serve efficiently.\n在战场上，侍从帮助其他角色，并学会高效服务",
	PROFALCHEMIST = "Alchemist 炼金术士",
	PROFALCHEMISTDESCRIPT = "Alchemists specialize in brewing processes which are invaluable for a steady supply of potions.\n炼金师专门从事炼金工艺，这对稳定供应药剂来说是非常宝贵的",
	PROFFARMER = "Farmer 农民",
	PROFFARMERDESCRIPT = "Farmers are trained to work with crops. \n农民接受了种植作物的培训",
	PROFBREEDER = "Breed Sow 繁殖者",
	PROFBREEDERDESCRIPT = "One who finds purpose in bringing a new generation into being. They can accept any partner, but their children will carry on their lineage.\n在培养新一代中找到目标的人。他们可以接受任何伴侣，但他们的孩子只会继承繁殖者的血统",
	PROFHARLOT = "Harlot 妓女",
	PROFHARLOTDESCRIPT = "The oldest profession might not seem like much, but so far it's always in demand.\n最古老的职业可能看起来不多，但到目前为止，它总是很受欢迎",
	PROFGEISHA = "Geisha 艺伎",
	PROFGEISHADESCRIPT = "Consummate entertainers that entertain patrons through song, dance, and conversation.\n通过歌曲、舞蹈和对话来娱乐顾客的完美艺人",
	PROFDANCER = "Dancer 舞者",
	PROFDANCERDESCRIPT = "Dancers can entice with their looks and moves. Effective for entertainment. \n舞者可以用他们的外表和动作来吸引人。对娱乐很有效",
	PROFSUCCUBUS = "Succubus 女梦淫妖",
	PROFSUCCUBUSALT = "Incubus 梦淫妖",
	PROFSUCCUBUSDESCRIPT = "Carnal pleasures turned into an art. They learned not only to please others but use their lust for their own benefits.\n狂欢变成了一门艺术。他们不仅学会了取悦他人，还学会了利用自己的欲望为自己谋利",
	PROFTRUE_SUCCUBUS = "True Succubus 高级女梦淫妖",
	PROFTRUE_SUCCUBUSALT = "True Incubus 高级梦淫妖",
	PROFTRUE_SUCCUBUSDESCRIPT = "Carnal pleasures turned into an art. They learned not only to please others, but use their lust for their own benefits.\n狂欢变成了一门艺术。他们不仅学会了取悦他人，还学会了利用自己的欲望为自己谋利",
	PROFPET = "Pet 宠物",
	PROFPETDESCRIPT = "Apparently, giving up your personal rights is not the worst thing in the world. Besides keeping a low profile, pets can cheer up other residents when they are in need of companionship. \n显然，放弃你的个人权利并不是世界上最糟糕的事情。除了保持低调，宠物还可以在其他居民需要陪伴时让他们高兴起来",
	PROFPETBEAST = "Natural Pet 天然宠物",
	PROFPETBEASTDESCRIPT = "Apparently, giving up your personal rights is not the worst thing in the world. Besides keeping a low profile, pets can cheer up other residents when they are in need of companionship. \n显然，放弃你的个人权利并不是世界上最糟糕的事情。除了保持低调，宠物还可以在其他居民需要陪伴时为他们打气",
	PROFSEXTOY = "Sex toy 性玩具",
	PROFSEXTOYDESCRIPT = "The art of being an object of desire for others.\n成为他人渴望的对象的艺术",
	PROFFIGHTER = "Fighter 斗士",
	PROFFIGHTERDESCRIPT = "Fighters are basic melee soldiers capable of dealing and taking damage in combat.\n战斗机是基本的近战士兵，能够在战斗中造成伤害",
	PROFKNIGHT = "Knight 骑士",
	PROFKNIGHTDESCRIPT = "A noble fighter ready to serve [his] [master]. [He] performs [his] duties on the frontline of the battlefield with honor. \n一位准备为[his] [master]服务的崇高战士。[He]在战场前线光荣地履行[his]职责",
	PROFAPPRENTICE = "Apprentice 学徒",
	PROFAPPRENTICEDESCRIPT = "Apprenticeship is a road for many starting mages. Apprentices focus on social spells, which can help greatly with putting others in line. \n学徒制是许多初级法师的一条道路。学徒专注于社交咒语，这可以极大地帮助其他人",
	PROFSCHOLAR = "Scholar 学者",
	PROFSCHOLARDESCRIPT = "Scholars are mages taught to specialize in combat. While their arsenal isn't great, they can be irreplaceable due to their utility.\n学者是被教导专门从事战斗的法师。虽然他们的法术并不强大，但由于他们的实用性，他们可能是不可替代的 ",
	PROFCASTER = "Caster 法师",
	PROFCASTERDESCRIPT = "Mastering powers of the arcane produces fruit: casters are able to seriously turn the battle in their favor and have a couple additional tricks up their sleeves. \n掌握奥术的力量会产生果实：施法者能够认真地将战斗转向对他们有利的方向，并有一些额外的技巧",
	PROFDOMINATOR = "Dominator 支配者",
	PROFDOMINATORDESCRIPT = "A Dominator specializes in mind influencing magic to bend others to their will. \n一个支配者擅长影响心灵的魔法，让他人屈从于他们的意愿",
	PROFBLOODMAGE = "Blood Mage 血法师",
	PROFBLOODMAGEDESCRIPT = "Practitioners of arcane arts sometimes go a long way to gain more power. Blood Mages can tap into their own health to restore some of their mana.\n奥术练习者有时会走很长的路来获得更多的力量。血法师可以利用自己的健康值来恢复一些法力",

	PROFMAID = "Maid 女仆",
	PROFMAIDALT = "Lackey 仆人",
	PROFMAIDDESCRIPT = "A trained servant not only knows their place but is more appealing to the eye.\n一个受过训练的仆人不仅知道自己的位置，而且更吸引眼球",
	PROFDRAGONKNIGHT = "Dragon Knight 龙骑士",
	PROFDRAGONKNIGHTDESCRIPT = "The dragon blood flowing in their veins allow them to become fearsome warriors resistant to fire.\n他们血管中流淌的龙血让他们成为了可怕的抗火战士",
	PROFBERSERKER = "Berserker 狂暴战士",
	PROFBERSERKERDESCRIPT = "The fiercest orcs can become Berserkers and boost their combat prowess.\n最凶猛的兽人可以成为狂暴战士，增强他们的战斗力",
	PROFDRUID = "Druid 德鲁伊",
	PROFDRUIDDESCRIPT = "Druids specialize in nature's magic, allowing them to heal and neutralize enemies.\n德鲁伊专注于大自然的魔法，使他们能够治愈和中和敌人",
	PROFVALKYRIE = "Valkyrie 女武神",
	PROFVALKYRIEDESCRIPT = "Female winged warriors excelling in swift and deadly combat.\n在快速和致命的战斗中表现出色的女战士",
	PROFSOULEATER = "Soul Eater 灵魂吞噬者",
	PROFSOULEATERDESCRIPT = "Sometimes magic proficiency can get you so far you are not only able to control others, but consume their souls to obtain their knowledge.\n有时候，精通魔法可以让你走到这样的地步，你不仅可以控制他人，还可以吞噬他们的灵魂来获得他们的知识",
	PROFNECROMANCER = "Necromancer 亡灵法师",
	PROFNECROMANCERDESCRIPT = "A vile sorcerer with power over the dead.\n一个卑鄙的巫师，拥有对死者的力量 ",
	PROFARCHER = "Archer 弓箭手",
	PROFARCHERDESCRIPT = "Archers specialize in using bows for ranged combat.\n弓箭手擅长在远程战斗中使用弓",
	PROFSNIPER = "Sniper 狙击手",
	PROFSNIPERDESCRIPT = "Snipers are deadly ranged fighters capable of quickly taking down unarmored targets.\n狙击手是一种致命的远程战斗者，能够快速击杀无甲目标",
	PROFROGUE = "Rogue 流氓",
	PROFROGUEDESCRIPT = "A dirty fighter who knows how to move fast and camouflage [him]self.\n一个知道如何快速移动和伪装自己的肮脏战士",
	PROFTHIEF = "Thief 小偷",
	PROFTHIEFDESCRIPT = "A dexterous character often utilized for picking locks and disarming traps.\n一个灵巧的角色，经常用于开锁和解除陷阱",
	PROFASSASSIN = "Assassin 刺客",
	PROFASSASSINDESCRIPT = "A stealthy assassin is capable of bringing down even high armored targets.\n一个隐形刺客甚至能够击杀高装甲目标",
	PROFENGINEER = "Engineer 工程师",
	PROFENGINEERDESCRIPT = "A skilled professional often employed for building development and gadget inventions.\n一位技术娴熟的专业人士，经常受雇于建筑开发和小工具发明",
	PROFTEMPLAR = "Templar 圣殿骑士",
	PROFTEMPLARDESCRIPT = "Devoted warriors who aim to clash with mages and repel mind influencing skills.\n受训于与法师冲突并抵抗影响心智技能的战士",
	PROFPALADIN = "Paladin 圣骑士",
	PROFPALADINDESCRIPT = "Fighters who focus on protecting their party and use holy attacks to fight evil.\n专注于保护自己的政党并使用神圣攻击来对抗邪恶的战士",
	PROFSHAMAN = "Shaman 萨满",
	PROFSHAMANDESCRIPT = "Mediums of spirits and nature forces often tied to animalistic origins. \n精神和自然力量的媒介通常与动物起源有关",
	PROFRANGER = "Ranger 游侠",
	PROFRANGERDESCRIPT = "A skilled hunter and tracker, proficient with traps. \n一个熟练的猎人和追踪者，精通陷阱",
	PROFBARD = "Bard 吟游诗人",
	PROFBARDDESCRIPT = "Magic of music is capable to lifting allies' spirit.\n音乐的魔力能够提升盟友的精神",
	PROFARCHMAGE = "Archmage 大法师",
	PROFARCHMAGEDESCRIPT = "A master of magics capable of bringing elemental destruction on the enemies.\n个能够给敌人带来元素毁灭的魔法大师",
	PROFBATTLESMITH = "Battle Smith 战争铁匠",
	PROFBATTLESMITHDESCRIPT = "Dwarven smiths are able to reach the level of craftsmanship to utilize their skills right on the battlefield. \n矮人铁匠能够达到在战场上使用技能的工艺水平",
	PROFTECHNOMANCER = "Technomancer 机械巫师",
	PROFTECHNOMANCERDESCRIPT = "By merging magic and technology these specialists are capable of producing very unique results.\n通过将魔法和技术相结合，这些专家能够产生非常独特的结果",

	PROFALIOS_CHAMPION = "Champion of Alios 阿利奥斯的神眷者",
	PROFALIOS_CHAMPIONDESCRIPT = "A lone girl with mysterious powers and the past. One thing is clear, her divine affiliation is real. \n一个拥有神秘力量和过去的孤独女孩。有一点很清楚，她的神眷者身份是真实的。",
	PROFRENOWN_ROYALTY = "Renown Royalty 著名王权",
	PROFRENOWN_ROYALTYDESCRIPT = "The royal blood is a boon in itself, even more so when recognized by others. \n皇室血统本身就是一种恩惠，当被他人认可时更是如此。",
	PROFBROKEN_ROYALTY = "Broken Royalty 破碎王权",
	PROFBROKEN_ROYALTYDESCRIPT = "Once a famous royalty, now a mind broken individual capable of very little... At least her body is still in high demand.\n曾经是一个著名的皇室成员，现在是一个精神崩溃的人，能力很差……至少她的身体仍然很受欢迎。",
	
	
	PROFACOLYTE = "Acolyte 侍僧",
	PROFACOLYTEDESCRIPT = "Individuals have devoted their life to mending to others. \n这个人一生致力于修补他人",
	PROFPRIEST = "Priest 牧师",
	PROFPRIESTDESCRIPT = "Devoted to their faith and helping others, priests are strong healers capable of meding to serious wounds.\n牧师忠于自己的信仰并帮助他人，是能够治疗严重创伤的坚强治疗师",
	PROFMONK = "Monk 和尚",
	PROFMONKDESCRIPT = "Religious fighters who utilize their spiritual training to deal with the enemies.\n利用他们的精神训练来对付敌人的宗教战士",
	PROFBISHOP = "Bishop 主教",
	PROFBISHOPDESCRIPT = "Only selected few manage to reach this rank. Highest members of the church capable of unleashing divine powers.\n只有少数人能够达到这个级别。教会中能够释放神圣力量的最高成员",
	PROFSPOUSE = "Husband",
	PROFSPOUSEALT = "Wife",
	PROFSPOUSEDESCRIPT = "An officially engaged spouse of Mansion's [Master]. Obedience Drain is 0. Loyalty Gain +3.",
	
	PROFFREYAS_PRIESTESS = "Former Freya's Priestess 前弗雷娅的女祭司",
	PROFFREYAS_PRIESTESSDESCRIPT = "Once a high priestess of elves, now this title hold more bluster than power.\n曾经是精灵的高级女祭司，现在这个头衔更多的是虚张声势而非权力。",
	PROFDEATHKNIGHT = """Death Knight""", # MISSING TRANSLATION
	PROFDEATHKNIGHTDESCRIPT = """Sworn to their nature or master, undead warriors are able to grow stronger the more they slaughter.""", # MISSING TRANSLATION
	PROFWARLOCK = """Warlock""", # MISSING TRANSLATION
	PROFWARLOCKDESCRIPT = """The most fearsome sorcerors specializing in combat magic are able to incinerate their foes on sight.""", # MISSING TRANSLATION
	PROFWITCH = """Witch""", # MISSING TRANSLATION
	PROFWITCHDESCRIPT = """Female sorceresses specialize in hex magic and alchemy.""", # MISSING TRANSLATION
	PROFNINJA = """Ninja""", # MISSING TRANSLATION
	PROFNINJADESCRIPT = """Especially agile individuals are trained to evade many attacks as well as also resist magic.""", # MISSING TRANSLATION
	
	TRAITRENOWN = "Renown 名声",
	TRAITRENOWNDESCRIPT = "Gracious skills provide 50% more Loyalty.\n 仁慈的技能可提供50%额外忠诚度",
	
	SKILLWINDWALL = "Wind Wall 风墙",
	SKILLWINDWALLDESCRIPT = "Reduces ally line received ranged damage by 50% for 4 turns.\n在4回合内减少己方受到的范围伤害50%",
	SKILLTAKE_POSITION = "Take Position 就位",
	SKILLTAKE_POSITIONDESCRIPT = "Increases armor penetration by 50, damage by 20% for 2 turns. Instant.\n增加护甲穿透50，2回合伤害20%。瞬间",

	NEXTCLASSEXP = "Experience required for next class.下一课程需要的经验",

	UPGRADEPREVBONUS = "Previous bonus 以前的奖金: ",
	UPGRADENEXTBONUS = "Upgrade bonus 升级奖金: ",
	
	
	
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
	
	
	INTERACTIONSNOSEXTAG = "[name]'s personal story has not progressed to the point of allowing [him] to participate in these kinds of actions.\n[name]的个人故事还没有发展到允许[him]参与这些行动的地步",

	NOSEXDETAILSDESCRIPT = "{color=green|Unfortunately, you are unable to check on [his] private parts.}\n很遗憾，您无法检查[his]私处",

	UPGRADEEXOTIC_TRADER = "Exotic Trader",
	UPGRADEEXOTIC_TRADERDESCRIPT = "Improves slaves offered by Exotic Slave Trader.",
	UPGRADEEXOTICBONUS = "Slaves from Exotic Slave Trader Avermik will have higher base stats and more classes.",
	UPGRADESEX_TIMES = "Bedroom Endurance",
	UPGRADESEX_TIMESDESCRIPT = "Increase number of times you can do sex interactions per day.",
	UPGRADESEX_TIMEBONUS1 = "Increase daily sex interactions to 2",
	UPGRADESEX_TIMEBONUS2 = "Increase daily sex interactions to 3",
	UPGRADERESTING = "Bath",
	UPGRADERESTINGDESCRIPT = "Characters resting at Mansion will deplete their Obedience at half speed.",
	UPGRADERESTINGBONUS1 = "",
	UPGRADEACADEMY = "Academy",
	UPGRADEACADEMYDESCRIPT = "Allows to send newborn children for Academy training.",
	
	
	UPGRADETOOL_SWAPPER = "Multitool",
	UPGRADETOOL_SWAPPERDESCRIPT = "When characters harvest materials at dungeons or doing one time tasks their equipped tool will always apply its bonus regardless of type.",
	
	UPGRADEFARM_SLOTS = "Farm slots",
	UPGRADEFARM_SLOTSDESCRIPT = "Provides additional slots for farm produce.",
	
	BODYPARTAGETEEN = "青少年",
	BODYPARTAGEADULT = "成年",
	BODYPARTAGEMATURE = "成熟",
	BODYPARTBODY_SHAPEHUMANOID = "人形",
	BODYPARTBODY_SHAPEBESTIAL = "野兽",
	BODYPARTBODY_SHAPESHORTSTACK = "矮小",
	BODYPARTBODY_SHAPEJELLY = "果冻状",
	BODYPARTBODY_SHAPEHALFBIRD = "半鸟",
	BODYPARTBODY_SHAPEHALFSNAKE = "半蛇",
	BODYPARTBODY_SHAPEHALFFISH = "半鱼",
	BODYPARTBODY_SHAPEHALFSPIDER = "半蜘蛛",
	BODYPARTBODY_SHAPEHALFHORSE = "半马",
	BODYPARTBODY_SHAPEHALFSQUID = "半鱿鱼",
	BODYPARTHAIR_LENGTHBALD = "光头",
	BODYPARTHAIR_LENGTHEAR = "耳朵",
	BODYPARTHAIR_LENGTHNECK = "颈部",
	BODYPARTHAIR_LENGTHSHOULDER = "肩部",
	BODYPARTHAIR_LENGTHWAIST = "腰部",
	BODYPARTHAIR_LENGTHHIPS = "臀部",
	BODYPARTHAIR_STYLESTRAIGHT = "直发",
	BODYPARTHAIR_STYLEPONYTAIL = "马尾辫",
	BODYPARTHAIR_STYLEPIGTAILS = "麻花辫",
	BODYPARTHAIR_STYLEBRAID = "辫子",
	BODYPARTHAIR_STYLETWINBRAIDS = "双辫子",
	BODYPARTHAIR_STYLEBUN = "圆发髻",
	BODYPARTEYE_COLORDEFAULT = "默认",
	BODYPARTEYE_SHAPENORMAL = "正常",
	BODYPARTEYE_SHAPESLIT = "狭缝",
	BODYPARTHORNSSHORT = "短",
	BODYPARTHORNSSTRAIGHT = "直",
	BODYPARTHORNSCURVED = "弯曲",
	BODYPARTEARSHUMAN = "人类",
	BODYPARTEARSELVEN = "精灵",
	BODYPARTEARSORCISH = "半兽人",
	BODYPARTEARSCAT = "猫",
	BODYPARTEARSWOLF = "狼",
	BODYPARTEARSFOX = "狐狸",
	BODYPARTEARSBUNNY_STANDING = "兔子直立",
	BODYPARTEARSBUNNY_DROOPING = "兔子下垂",
	BODYPARTEARSTANUKI = "狸猫",
	BODYPARTEARSDEMON = "恶魔",
	BODYPARTEARSCOW = "牛",
	BODYPARTEARSFEATHERED = "覆盖羽毛",
	BODYPARTEARSFISH = "鱼",
	BODYPARTEARSRAT = "老鼠",
	BODYPARTSKINPALE = "苍白",
	BODYPARTSKINGREY = "灰色",
	BODYPARTSKINFAIR = "浅白",
	BODYPARTSKINOLIVE = "橄榄色",
	BODYPARTSKINTAN = "棕褐色",
	BODYPARTSKINBROWN = "棕色",
	BODYPARTSKINDARK = "黑色",
	BODYPARTSKINSLIME = "黏液",
	BODYPARTSKINBLUE = "蓝色",
	BODYPARTSKINPALEBLUE = "浅蓝色",
	BODYPARTSKINGREEN = "绿色",
	BODYPARTSKINRED = "红色",
	BODYPARTSKINPURPLE = "紫色",
	BODYPARTSKINTEAL = "青色",
	BODYPARTSKIN_COVERAGEPLANT = "植物",
	BODYPARTSKIN_COVERAGESCALE = "刻度",
	BODYPARTSKIN_COVERAGEFEATHERS = "羽毛",
	BODYPARTSKIN_COVERAGEFUR_WHITE = "白色毛皮",
	BODYPARTSKIN_COVERAGEFUR_GREY = "灰色毛皮",
	BODYPARTSKIN_COVERAGEFUR_BROWN = "棕色毛皮",
	BODYPARTSKIN_COVERAGEFUR_STRIPED = "条纹毛皮",
	BODYPARTSKIN_COVERAGEFUR_BLACK = "黑色毛皮",
	BODYPARTSKIN_COVERAGEFUR_ORANGE = "橙色毛皮",
	BODYPARTSKIN_COVERAGEFUR_ORANGE_WHITE = "狐狸毛皮",
	BODYPARTWINGSFEATHERED_BLACK = "黑色羽毛",
	BODYPARTWINGSSERAPH = "撒拉弗",
	BODYPARTWINGSFEATHERED_BROWN = "棕色羽毛",
	BODYPARTWINGSFAIRY = "仙精",
	BODYPARTWINGSDEMON = "恶魔",
	BODYPARTWINGSDRAGON = "龙",
	BODYPARTWINGSLEATHER_BLACK = "黑色皮革",
	BODYPARTWINGSLEATHER_RED = "红色皮革",
	BODYPARTTAILCAT = "猫",
	BODYPARTTAILFOX = "狐狸",
	BODYPARTTAILWOLF = "狼",
	BODYPARTTAILBUNNY = "兔子",
	BODYPARTTAILTANUKI = "狸猫",
	BODYPARTTAILCOW = "牛",
	BODYPARTTAILDEMON = "恶魔",
	BODYPARTTAILDRAGON = "龙",
	BODYPARTTAILAVIAN = "鸟类",
	BODYPARTTAILFISH = "鱼",
	BODYPARTTAILSNAKE = "蛇",
	BODYPARTTAILTENTACLES = "触手",
	BODYPARTTAILHORSE = "马",
	BODYPARTTAILSPIDER = "蜘蛛",
	BODYPARTHEIGHTTINY = "微小",
	BODYPARTHEIGHTPETITE = "娇小",
	BODYPARTHEIGHTSHORT = "矮",
	BODYPARTHEIGHTAVERAGE = "平均",
	BODYPARTHEIGHTTALL = "高",
	BODYPARTHEIGHTTOWERING = "高耸",
	BODYPARTTITS_SIZEFLAT = "平坦",
	BODYPARTTITS_SIZESMALL = "小",
	BODYPARTTITS_SIZEAVERAGE = "平均",
	BODYPARTTITS_SIZEBIG = "大",
	BODYPARTTITS_SIZEHUGE = "巨大",
	BODYPARTTITS_SIZEMASCULINE = "阳刚",
	BODYPARTASS_SIZEFLAT = "平坦",
	BODYPARTASS_SIZESMALL = "小",
	BODYPARTASS_SIZEAVERAGE = "平均",
	BODYPARTASS_SIZEBIG = "大",
	BODYPARTASS_SIZEHUGE = "巨大",
	BODYPARTASS_SIZEMASCULINE = "阳刚",
	BODYPARTBALLS_SIZESMALL = "小",
	BODYPARTBALLS_SIZEAVERAGE = "平均",
	BODYPARTBALLS_SIZEBIG = "大",
	BODYPARTPENIS_TYPEHUMAN = "人类",
	BODYPARTPENIS_TYPECANINE = "犬科动物",
	BODYPARTPENIS_TYPEFELINE = "猫科动物",
	BODYPARTPENIS_TYPEEQUINE = "马科动物",
	BODYPARTPENIS_SIZEHUMAN_SMALL = "人类小",
	BODYPARTPENIS_SIZEHUMAN_AVERAGE = "人类平均",
	BODYPARTPENIS_SIZEHUMAN_BIG = "人类大",
	BODYPARTPENIS_SIZECANINE_SMALL = "犬科动物小",
	BODYPARTPENIS_SIZECANINE_AVERAGE = "犬科动物平均",
	BODYPARTPENIS_SIZECANINE_BIG = "犬科动物大",
	BODYPARTPENIS_SIZEFELINE_SMALL = "猫科动物小",
	BODYPARTPENIS_SIZEFELINE_AVERAGE = "猫科动物平均",
	BODYPARTPENIS_SIZEFELINE_BIG = "猫科动物大",
	BODYPARTPENIS_SIZEEQUINE_SMALL = "马科动物小",
	BODYPARTPENIS_SIZEEQUINE_AVERAGE = "马科动物平均",
	BODYPARTPENIS_SIZEEQUINE_BIG = "马科动物大",
	BODYPARTHAS_PUSSYTRUE = "有女阴",
	BODYPARTHAS_PUSSYFALSE = " ",
	BODYPARTVAGINAL_VIRGINTRUE = "是",
	BODYPARTANAL_VIRGINTRUE = "是",
	BODYPARTPENIS_VIRGINTRUE = "是",
	BODYPARTMOUTH_VIRGINTRUE = "是",
	BODYPARTVAGINAL_VIRGINFALSE = "否",
	BODYPARTANAL_VIRGINFALSE = "否",
	BODYPARTMOUTH_VIRGINFALSE = "否",
	BODYPARTPENIS_VIRGINFALSE = "否",
	BODYPARTVAGINAL_VIRGINTRUE_TRUE = "是童贞",
	BODYPARTVAGINAL_VIRGINTRUE_FALSE = "不是童贞",
	BODYPARTNOSEDEFAULT = "鼻子1",
	BODYPARTNOSESMALL = "鼻子2",
	BODYPARTNOSESTRAIGHT = "鼻子3",
	BODYPARTCHINDEFAULT = "下巴1",
	BODYPARTCHINCURVE = "下巴2",
	BODYPARTCHINSMALL = "下巴3",
	BODYPARTCHINSKINNY = "下巴4",
	BODYPARTCHINSHORT = "下巴5",
	
	BODYPARTANAL_VIRGINTRUEDESCRIPT = "[His] {color=yellow|肛门童贞} 还没有被任何人宣称.",
	BODYPARTANAL_VIRGINFALSEDESCRIPT = "[His] 屁股接受过许多性行为.",

	BODYPARTPENIS_SIZEHUMAN_SMALLDESCRIPT = '在[his]腰下挂着一个[color=yellow]小型人类{check=active_slave.penis_virgin == true| [color=aqua]virgin[/color]} 阴茎[/color]，小到可以称之为可爱。',
	BODYPARTPENIS_SIZEHUMAN_AVERAGEDESCRIPT ='[He]腰部以下有一个[color=yellow]普通人类{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 阴茎[/color]，足以让大多数男人感到骄傲。',
	BODYPARTPENIS_SIZEHUMAN_BIGDESCRIPT = '一只[color=yellow]巨大的人类{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 阴茎[/color] ，在腹股沟摆动，大到足以让最资深的妓女望而生畏。',
	BODYPARTPENIS_SIZECANINE_SMALLDESCRIPT = '一只细长而尖的[color=yellow]{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 犬科阴茎[/color] 悬挂在[his]腰部下方，小到几乎看不到它的结。',
	BODYPARTPENIS_SIZECANINE_AVERAGEDESCRIPT = "[He] 有一只结节状的红色[color=yellow]{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 犬科阴茎[/color] 在[his]腰部以下，尺寸相当大，放在一只大狗身上不会显得格格不入。",
	BODYPARTPENIS_SIZECANINE_BIGDESCRIPT = '从[his]胯部长出一个 [color=yellow]巨大的{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 犬科阴茎[/color]，红色皮肤，在底部附近有一个厚结。',
	BODYPARTPENIS_SIZEFELINE_SMALLDESCRIPT = '一个 [color=yellow]小小的{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 猫科阴茎[/color] 悬挂在[his]腰下，小到几乎看不到倒刺。',
	BODYPARTPENIS_SIZEFELINE_AVERAGEDESCRIPT = '[He] 的胯部长着一个有刺的[color=yellow]{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 猫科阴茎[/color] ，大到足以与普通人匹敌。',
	BODYPARTPENIS_SIZEFELINE_BIGDESCRIPT = '大腿之间挂着一只可怕的 [color=yellow]巨大的{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 猫科阴茎[/color] 它巨大的倒钩让它有点吓人。',
	BODYPARTPENIS_SIZEEQUINE_SMALLDESCRIPT = '[His] 腰部下挂着 [color=yellow]小巧的{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 马科阴茎[/color], 与普通人相比，它仍然是值得尊敬的。',
	BODYPARTPENIS_SIZEEQUINE_AVERAGEDESCRIPT = '一只 [color=yellow]相当大的{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 马科阴茎[/color] 长在[his]下身，虽然在马身上很小，但仍然比普通的人类阴茎更厚、更重。',
	BODYPARTPENIS_SIZEEQUINE_BIGDESCRIPT = '一只 [color=yellow]巨大的{check=active_slave.penis_virgin == true| [color=aqua]童贞[/color]} 马科阴茎[/color] 沉重地挂在[his]腰部下方，其斑驳的质地与他的其他皮肤不太匹配。可怖的规模让大多数性伴侣望而却步。',

	BODYPARTAGETEENDESCRIPT = "[He]是一个 [color=aqua]年轻的 [boygirlfuta][/color]  [url=race][color=yellow][raceadj] [/color][/url].",
	BODYPARTAGEADULTDESCRIPT = "[He]是一个 [color=aqua]成年的 [male][/color]  [url=race][color=yellow][raceadj] [/color][/url].",
	BODYPARTAGEMATUREDESCRIPT = "[He]是一个 [color=aqua]成熟的 [male][/color]  [url=race][color=yellow][raceadj] [/color][/url].",

	BODYPARTBODY_SHAPEHUMANOIDDESCRIPT = " ",
	BODYPARTBODY_SHAPEBESTIALDESCRIPT = " ",
	BODYPARTBODY_SHAPESHORTSTACKDESCRIPT = "[His] 的身体相当 [color=yellow]娇小[/color], 大约是普通人的一半大小。",
	BODYPARTBODY_SHAPEJELLYDESCRIPT = "[His] 的身体是 [color=yellow]果冻状的[/color] ，并且部分透明。",
	BODYPARTBODY_SHAPEHALFBIRDDESCRIPT = "[His] 的身体有 [color=yellow]的翅膀和鸟类的腿[/color] ，这让日常任务变得困难。",
	BODYPARTBODY_SHAPEHALFSNAKEDESCRIPT = "[His]身体的下半部分由一条长长的 [color=yellow]蛇尾巴[/color]组成。",
	BODYPARTBODY_SHAPEHALFFISHDESCRIPT = "[His] 身体 [color=yellow]有鳞，光滑[/color], 有鳍和网状指。",
	BODYPARTBODY_SHAPEHALFSPIDERDESCRIPT = "[His]身体下部由 [color=yellow]蜘蛛的腿和腹部[/color]组成。",
	BODYPARTBODY_SHAPEHALFHORSEDESCRIPT = "虽然 [his] 上半身是人,但 [his] 下半身是自然界中的 [color=yellow]马[/color] 。",
	BODYPARTBODY_SHAPEHALFSQUIDDESCRIPT = "[His]的身体下半部分由 [color=yellow]多条触手[/color]组成，类似于章鱼的触手。",

	BODYPARTHAIR_LENGTHBALDDESCRIPT = "[He] [color=aqua]没有[/color] 任何可见的头发。",

	BODYPARTHAIR_LENGTHEARDESCRIPT = "[His] [color=aqua][hair_color][/color] 头发剪成 [color=aqua]短发[/color].",
	BODYPARTHAIR_LENGTHNECKDESCRIPT = "[His] [color=aqua][hair_color][/color] 头发垂到 [color=aqua] [his] 脖子[/color].",
	BODYPARTHAIR_LENGTHSHOULDERDESCRIPT = "[His] 波浪形 [color=aqua][hair_color][/color] 头发 [color=aqua]齐肩长[/color].",
	BODYPARTHAIR_LENGTHWAISTDESCRIPT = "[His] 华丽的 [color=aqua][hair_color][/color] 头发 [color=aqua]落到 [his] 腰部[/color].",
	BODYPARTHAIR_LENGTHHIPSDESCRIPT = "[His] [color=aqua][hair_color][/color] 头发层叠而下, [color=aqua]直到 [his] 臀部[/color].",


	BODYPARTHAIR_STYLESTRAIGHTDESCRIPT = "它 [url=hair][color=aqua]自由地[/color][/url] 从 [his] 头顶垂落.",
	BODYPARTHAIR_STYLEPONYTAILDESCRIPT = "它被扎成 [url=hair][color=aqua]高马尾[/color][/url].",
	BODYPARTHAIR_STYLEPIGTAILSDESCRIPT = "它是以少女风格 [url=hair][color=aqua]双尾[/color][/url]打理的.",
	BODYPARTHAIR_STYLEBRAIDDESCRIPT = "它被梳成一个 [url=hair][color=aqua]辫子[/color][/url].",
	BODYPARTHAIR_STYLETWINBRAIDSDESCRIPT = "它被梳成一个 [url=hair][color=aqua]双辫子[/color][/url].",
	BODYPARTHAIR_STYLEBUNDESCRIPT = "它被扎成一个整洁的 [url=hair][color=aqua]发髻[/color][/url].",
	HAIRCOLOR_GRADIENT = """colorful""", # MISSING TRANSLATION
	HAIRCOLOR_BROWN = """brown""", # MISSING TRANSLATION
	HAIRCOLOR_ORANGE = """orange""", # MISSING TRANSLATION
	HAIRCOLOR_DARK = """dark""", # MISSING TRANSLATION
	HAIRCOLOR_GREEN = """green""", # MISSING TRANSLATION
	HAIRCOLOR_CYAN = """cyan""", # MISSING TRANSLATION
	HAIRCOLOR_PINK = """pink""", # MISSING TRANSLATION
	HAIRCOLOR_PURPLE = """purple""", # MISSING TRANSLATION
	HAIRCOLOR_RED = """red""", # MISSING TRANSLATION
	HAIRCOLOR_WHITE = """white""", # MISSING TRANSLATION
	HAIRCOLOR_YELLOW = """yellow""", # MISSING TRANSLATION
	HAIRCOLOR_BLUE = """blue""", # MISSING TRANSLATION

	BODYPARTEYE_COLORDEFAULTDESCRIPT = "[His] 的眼睛是 [color=aqua][eye_color][/color].",
	BODYPARTEYE_SHAPENORMALDESCRIPT = ' ',
	BODYPARTEYE_SHAPESLITDESCRIPT = "[He] 有 [color=aqua]垂直的动物瞳孔[/color].",

	BODYPARTHORNSSHORTDESCRIPT = "有一对 [color=aqua]小而尖的[/color] 角在[his] 头顶.",
	BODYPARTHORNSSTRAIGHTDESCRIPT = "[He] 有一对 [color=aqua]长的、像公牛的角[/color].",
	BODYPARTHORNSCURVEDDESCRIPT = "有一对 [color=aqua]弯曲的角[/color] 盘绕在 [his] 头顶.",

	BODYPARTEARSHUMANDESCRIPT = " ",
	BODYPARTEARSELVENDESCRIPT = "[He] 有一对长长的 [color=aqua]尖锐[/color] 耳朵.",
	BODYPARTEARSORCISHDESCRIPT = "[He] 有一对 [color=aqua]短尖[/color] 耳朵.",
	BODYPARTEARSCATDESCRIPT = "[He] 有一对灵动的 [color=aqua]猫[/color] 耳朵.",
	BODYPARTEARSWOLFDESCRIPT = "[He] 有一对短而粗的 [color=aqua]狼[/color] 耳朵.",
	BODYPARTEARSFOXDESCRIPT = "[He] 有一对长长的富有表现力的 [color=aqua]狐狸[/color] 耳朵.",
	BODYPARTEARSBUNNY_STANDINGDESCRIPT = "[He] 有一对 [color=aqua]直立的兔子耳朵[/color] 在 [his] 头上.",
	BODYPARTEARSBUNNY_DROOPINGDESCRIPT = "[He] 有一对 [color=aqua]下垂的兔子耳朵[/color] 在 [his] 头上.",
	BODYPARTEARSTANUKIDESCRIPT = "[He] 有一对圆圆的 [color=aqua]浣熊[/color] 耳朵.",
	BODYPARTEARSDEMONDESCRIPT = "[He] 有一对 [color=aqua]恶魔[/color] 耳朵.",
	BODYPARTEARSCOWDESCRIPT = "[He] 有一对毛茸茸的 [color=aqua]牛[/color] 耳朵.",
	BODYPARTEARSFEATHEREDDESCRIPT = "[His]头部两侧有一对紧贴皮肤的 [color=aqua]羽毛耳朵[/color] 。",
	BODYPARTEARSFISHDESCRIPT = "[His] 耳朵看起来像一对 [color=aqua]鳍[/color].",
	BODYPARTEARSRATDESCRIPT = "[He] 有一对大老鼠一样的耳朵.",

	BODYPARTSKINPALEDESCRIPT = "[His] 皮肤是 [color=aqua]苍白的[/color] 白色.",
	BODYPARTSKINGREYDESCRIPT = "[His] 皮肤是石头一样的 [color=aqua]灰色[/color].",
	BODYPARTSKINFAIRDESCRIPT = "[His] 皮肤健康而 [color=aqua]白皙[/color] .",
	BODYPARTSKINOLIVEDESCRIPT = "[His] 皮肤是不寻常的 [color=aqua]橄榄色[/color] .",
	BODYPARTSKINTANDESCRIPT = "[His] 皮肤是 [color=aqua]棕[/color] 褐色.",
	BODYPARTSKINBROWNDESCRIPT = "[His] 皮肤是混合 [color=aqua]棕色[/color] .",
	BODYPARTSKINDARKDESCRIPT = "[His] 皮肤是深[color=aqua]黑色[/color].",
	BODYPARTSKINSLIMEDESCRIPT = "[His] 皮肤是 [color=aqua]果冻状的半透明[/color].",
	BODYPARTSKINBLUEDESCRIPT = "[His] 皮肤是深 [color=aqua]蓝色[/color].",
	BODYPARTSKINPALE_BLUEDESCRIPT = "[His] 皮肤是 [color=aqua]浅蓝色[/color].",
	BODYPARTSKINGREENDESCRIPT = "[His] 皮肤是 [color=aqua]绿色[/color].",
	BODYPARTSKINREDDESCRIPT = "[His] 皮肤是亮 [color=aqua]红色[/color].",
	BODYPARTSKINPURPLEDESCRIPT = "[His] 皮肤是 [color=aqua]紫色[/color].",
	BODYPARTSKINTEALDESCRIPT = "[His] 皮肤是 [color=aqua]蓝绿色[/color].",

	BODYPARTSKIN_COVERAGEPLANTDESCRIPT = "各种各样的叶子和 [color=aqua]植物物质[/color] 覆盖率 [his] 身体.",
	BODYPARTSKIN_COVERAGESCALEDESCRIPT = "[His] 皮肤部分覆盖着 [color=aqua]鳞片[/color].",
	BODYPARTSKIN_COVERAGEFEATHERSDESCRIPT = "[His] 身体在很多地方都覆盖着 [color=aqua]鸟类的羽毛[/color] .",
	BODYPARTSKIN_COVERAGEFUR_WHITEDESCRIPT = "[His] 身体覆盖着厚厚的、柔软的 [color=aqua]大理石颜色毛皮[/color].",
	BODYPARTSKIN_COVERAGEFUR_GREYDESCRIPT = "[His] 身体覆盖着厚厚的、柔软的 [color=aqua]灰色毛皮[/color].",
	BODYPARTSKIN_COVERAGEFUR_BROWNDESCRIPT = "[His] 身体覆盖着厚厚的、柔软的 [color=aqua]浅棕色毛皮[/color].",
	BODYPARTSKIN_COVERAGEFUR_STRIPEDDESCRIPT = "[His] 身体覆盖着厚厚的、柔软的 [color=aqua]条纹毛皮[/color].",
	BODYPARTSKIN_COVERAGEFUR_BLACKDESCRIPT = "[His] 身体覆盖着厚厚的、柔软的 [color=aqua]乌黑毛皮[/color].",
	BODYPARTSKIN_COVERAGEFUR_ORANGEDESCRIPT = "[His] 身体覆盖着厚厚的、柔软的 [color=aqua]狐狸毛皮[/color].",
	BODYPARTSKIN_COVERAGEFUR_ORANGE_WHITEDESCRIPT = "[His] 身体覆盖着厚厚的、柔软的 [color=aqua]橙白色毛皮[/color].",

	BODYPARTWINGSFEATHERED_BLACKDESCRIPT ="在 [his] 背上, [he] 有已经折叠的, [color=aqua]黑色，羽毛状的翅膀[/color].",
	BODYPARTWINGSSERAPHDESCRIPT = "在 [his] 背上, [he] 有已经折叠的, [color=aqua]白色，羽毛状的翅膀[/color].",
	BODYPARTWINGSFEATHERED_BROWNDESCRIPT = "在 [his] 背上, [he] 有已经折叠的, [color=aqua]棕色，羽毛状的翅膀[/color].",
	BODYPARTWINGSFAIRYDESCRIPT = "在 [his] 背上有半透明 [color=aqua]仙精翅膀[/color].",
	BODYPARTWINGSDEMONDESCRIPT = "[His] 背上藏着一对蝙蝠状的, [color=aqua]恶魔翅膀[/color].",
	BODYPARTWINGSDRAGONDESCRIPT = "[His] 背上藏着一对厚厚的, [color=aqua]龙翅膀[/color].",
	BODYPARTWINGSLEATHER_BLACKDESCRIPT = "[His] 背上藏着一对蝙蝠状的, [color=aqua]黑色皮革翅膀[/color].",
	BODYPARTWINGSLEATHER_REDDESCRIPT = "[His] 背上藏着一对蝙蝠状的, [color=aqua]红色皮革翅膀[/color].",

	BODYPARTTAILCATDESCRIPT = '在 [his] 腰部, 你能看到一条纤细的覆盖着毛皮的 [color=aqua]猫尾巴[/color] .',
	BODYPARTTAILFOXDESCRIPT = '[He] 有一条又大又蓬松的 [color=aqua]狐狸尾巴[/color].',
	BODYPARTTAILWOLFDESCRIPT = "在 [his] 腰部有一条短而蓬松的, [color=aqua]狼尾巴[/color].",
	BODYPARTTAILBUNNYDESCRIPT = '[He] 有一个 [color=aqua]小绒毛球[/color] 在 [his] 腰后面.',
	BODYPARTTAILTANUKIDESCRIPT = '[He] 有一条丰满蓬松的 [color=aqua]浣熊尾巴[/color].',
	BODYPARTTAILCOWDESCRIPT = '在 [his] 后面你会注意到一条长尾巴被一层薄薄的毛皮覆盖，末端是一把 [color=aqua]邋遢刷子[/color].',
	BODYPARTTAILDEMONDESCRIPT = '[He] 有一条细长的, [color=aqua]恶魔尾巴[/color] 以尖头结尾.',
	BODYPARTTAILDRAGONDESCRIPT = '在[his]背部后面有一条 [color=aqua]鳞尾[/color].',
	BODYPARTTAILAVIANDESCRIPT = '[He] 有一条 [color=aqua]羽毛状的鸟尾巴[/color] 在 [his] 背部.',
	BODYPARTTAILFISHDESCRIPT = '[His] 尾部是一条光滑的长 [color=aqua]鱼尾[/color].',
	BODYPARTTAILSNAKEDESCRIPT = " ",
	BODYPARTTAILTENTACLESDESCRIPT = " ",
	BODYPARTTAILHORSEDESCRIPT = " ",
	BODYPARTTAILSPIDERDESCRIPT = " ",

	BODYPARTHEIGHTTINYDESCRIPT = "[His] 身材 [color=aqua]非常小[/color], 只有正常人的一半大.",
	BODYPARTHEIGHTPETITEDESCRIPT = "[His] 身材很 [color=aqua]娇小[/color].",
	BODYPARTHEIGHTSHORTDESCRIPT ="[His] 身高很 [color=aqua]矮[/color].",
	BODYPARTHEIGHTAVERAGEDESCRIPT ="[He] 有一个 [color=aqua]平均[/color] 身高.",
	BODYPARTHEIGHTTALLDESCRIPT = "[He] 与普通人相比，非常 [color=aqua]高[/color].",
	BODYPARTHEIGHTTOWERINGDESCRIPT = "[He] 异常高大,和普通人相比可以称之为 [color=aqua]高耸[/color] .",

	BODYPARTTITS_SIZEFLATDESCRIPT = "[His] 胸部几乎看不见，几乎 [color=yellow]平坦[/color].",
	BODYPARTTITS_SIZESMALLDESCRIPT = "[He] 有 [color=yellow]小巧的[/color], 圆胸.",
	BODYPARTTITS_SIZEAVERAGEDESCRIPT = "[His] 漂亮, [color=yellow]活泼的[/color] 胸部结实诱人.",
	BODYPARTTITS_SIZEBIGDESCRIPT = "[His] [color=yellow]大[/color] 胸柔软宜人，而且仍然挺拔.",
	BODYPARTTITS_SIZEHUGEDESCRIPT = "[His] [color=yellow]巨大的[/color] 就 [his] 身体尺寸而言是惊人的大.",
	BODYPARTTITS_SIZEMASCULINEDESCRIPT = "[His] 胸部是 [color=yellow]阳刚的[/color] .",

	BODYPARTASS_SIZEFLATDESCRIPT = "[His] 屁股很瘦而且 [color=yellow]扁平[/color].",
	BODYPARTASS_SIZESMALLDESCRIPT = "[He] 有一个 [color=yellow]小[/color], 结实的屁股.",
	BODYPARTASS_SIZEAVERAGEDESCRIPT = "[He] 有一个很棒的, [color=yellow]饱满的[/color] 屁股，你可以把硬币弹上去.",
	BODYPARTASS_SIZEBIGDESCRIPT = "[He] 有一个令人愉快的 [color=yellow]丰满的[/color],心形屁股，每走一步都会令人兴奋地抖动.",
	BODYPARTASS_SIZEHUGEDESCRIPT = "[He] 有一个 [color=yellow]巨大的[/color], 引人注目的屁股.",
	BODYPARTASS_SIZEMASCULINEDESCRIPT = "[His] 屁股是 [color=yellow]阳刚的[/color] .",

	BODYPARTBALLS_SIZESMALLDESCRIPT = "[He] 有一对 [color=yellow]小[/color] 睾丸.",
	BODYPARTBALLS_SIZEAVERAGEDESCRIPT = "[He] 有一对 [color=yellow]平均大小的[/color] 睾丸.",
	BODYPARTBALLS_SIZEBIGDESCRIPT = "[He] 有一对 [color=yellow]巨大的[/color] 睾丸压在 [his] 阴囊上.",

	BODYPARTVAGINAL_VIRGINTRUE_TRUEDESCRIPT = '[He] 有一个紧致的, [color=yellow]处女女阴[/color].',
	BODYPARTVAGINAL_VIRGINTRUE_FALSEDESCRIPT = "[He] 有一个 [color=yellow]普通女阴[/color] .",
	BODYPARTHAS_PUSSYFALSEDESCRIPT = " ",

	BODYPARTPREGLINELATE = "[His] {color=yellow|未出生的} 孩子迫使 [his] 腹部大量突出; [he] 即将分娩.",
	BODYPARTPREGLINEEARLY = "[His] {color=yellow|未出生的胎儿} 导致 [his] 腹部轻微隆起. ",

	
	
	DESCRIPTTATOOFACE_MAKEUP = "[His] 脸上有永久的妆容，突出了 [his] 美.",
	DESCRIPTTATOOFACE_TRIBAL = "[His] 脸上画着部落标记.",
	DESCRIPTTATOONECK_BRANDING = "[His] 脖子上有一个印有你名字的奴隶烙印.",
	DESCRIPTTATOOCHEST_LUST = "[His] 胸部装饰着猥亵的痕迹，强调 [his] 乳头.",
	DESCRIPTTATOOCHEST_TRIBAL = "[His] 胸部被部落标记伪装.",
	DESCRIPTTATOOWAIST_HP = "[His] 腰部后面有一个精致的植物纹身.",
	DESCRIPTTATOOWAIST_MP = " [His] 腰部后面装饰着发光的能量线.",
	DESCRIPTTATOOARMS_HP = "[His] 手臂上有优雅的植物纹身.",
	DESCRIPTTATOOARMS_MP = "[His] 手臂有发光的能量线.",
	DESCRIPTTATOOARMS_TRIBAL = "[His] 手臂上画着部落标记.",
	DESCRIPTTATOOASS_BRANDING = "[His] 屁股上有一个印有你名字的奴隶烙印.",
	DESCRIPTTATOOASS_LUST = "[His] 背部装饰着一个淫荡的徽章.",
	DESCRIPTTATOOCROTCH_BRANDING = "[His] 胯部有一个印有你名字的奴隶烙印.",
	DESCRIPTTATOOCROTCH_LUST = "[His] 胯部纹着一个淫荡的徽章.",
	DESCRIPTTATOOLEGS_HP = "[His] 腿上有一个优雅的植物纹身.",
	DESCRIPTTATOOLEGS_MP = "[His] 腿有发光的能量线.",
	DESCRIPTTATOOLEGS_TRIBAL = "[His] 腿上画着部落标记.",

	SEXTRAITORAL = "口交爱好者",
	SEXTRAITLIKES_SHORTSTACKS = "矮小体型爱好者",
	SEXTRAITLIKES_BEASTS = "兽人爱好者",
	SEXTRAITBISEXUAL = "双性恋",
	SEXTRAITOPEN_MINDED = "思想开放",
	SEXTRAITDEVIANT = "离经叛道",
	SEXTRAITGROUP = "群交爱好者",
	SEXTRAITSHAMELESS = "无耻",
	SEXTRAITANAL = "肛交爱好者",
	SEXTRAITBREASTS = "乳交爱好者",
	SEXTRAITMASOCHIST = "受虐狂",
	SEXTRAITSADIST = "施虐狂",
	SEXTRAITDOORMAT = "被动",
	SEXTRAITSUBMISSIVE = "顺从",
	SEXTRAITDOMINANT = "主动",
	SEXTRAITNYMPHOMANIA = "色情狂",
	SEXTRAITHYPERSENSITIVE = "过敏",
	SEXTRAITLEWDNESS_AURA = "变态光环",
	SEXTRAITBOTTLE_FAIRY = "酒仙",
	SEXTRAITIRRESISTIBLE = "不可抗拒",
	SEXTRAITBEDROOM_PRODIDGY = "卧室神童",
	SEXTRAITPUSHOVER = "唯唯诺诺",
	SEXTRAITTEACHER = "教师",
	SEXTRAITDESIRED = "诱人",
	SEXTRAITCURIOUS = "好奇",
	SEXTRAITLIFE_POWER = "生命力量",

	SEXSKILLSDESCRIPT = "Sex skills improve character's performance while interacting and affect the Sexuals stat. Higher Sex Skill will make a partner more aroused from Character's actions. \n\nSex skills are increased when performing related action and their growth is dependent on Sex Factor.",
	SEXSKILLORAL = "口交",
	SEXSKILLANAL = "肛交",
	SEXSKILLPETTING = "爱抚",
	SEXSKILLPENETRATION = "插入",
	SEXSKILLTAIL = "尾巴",
	SEXSKILLPUSSY = "女阴",
	SEXSKILLORALDESCRIPT = "Increases effect of actions performed with mouth.",
	SEXSKILLANALDESCRIPT = "Increases effect of actions performed with rear.",
	SEXSKILLPETTINGDESCRIPT = "Increases effect of petting actions.",
	SEXSKILLPENETRATIONDESCRIPT = "Increases effect of actions involving penetration and thrusts.",
	SEXSKILLTAILDESCRIPT = "Increases effect of actions performed with tail.",
	SEXSKILLPUSSYDESCRIPT = "Increases effect of actions when [name]'s vagina is penetrated.",

	SEXTRAITDISLIKE_PETTING = "不喜欢宠物",
	SEXTRAITDISLIKE_FINGERING = "不喜欢用手指",
	SEXTRAITDISLIKE_TITS = "不喜欢乳交",
	SEXTRAITDISLIKE_ORAL = "不喜欢口交",
	SEXTRAITDISLIKE_MISSIONARY = "不喜欢传教士体位",
	SEXTRAITDISLIKE_DOGGY = "不喜欢狗爬式体位",
	SEXTRAITDISLIKE_SITTING = "不喜欢坐姿",
	SEXTRAITDISLIKE_RIDING = "不喜欢骑乘位",
	SEXTRAITDISLIKE_GROUP = "不喜欢集体性行为",
	SEXTRAITDISLIKE_BDSM = "讨厌粗暴的性爱",
	SEXTRAITDISLIKE_TAIL = "厌恶变态行为",

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


	DIALOGUEESCAPETEXT = "[name] 已经从你的监护下逃脱。也许你应该更多地关注他们的忠诚或行为.",
	DIALOGUEESCAPECLOSE = "这很不幸",
	LOSE_MESSAGE = "遗憾的是，你的统治似乎已经结束了.",
	LOSE_MONEY_MESSAGE = "你的黄金用完了。遗憾的是，你的统治似乎结束了.",
	
	TOOLTIPRIGHTCLICKABILITY = "Right Click to assign another ability",
	TIPLOADFINISHED = "Loading Finished, press any key",
	
	DIALOGUECLOSE = "关闭",
	DIALOGUECONFIRM = "确认",
	DIALOGUECONTINUE = "继续",
	DIALOGUECANCEL = "取消",
	
	DIALOGUEMEETLEADER = "会见领袖",

	DIALOGUECHILDBIRTHTEXT = "[name] 生了一个健康的孩子。你想抚养吗？",
	DIALOGUEKEEPBABY = "抚养孩子",
	DIALOGUEINSPECTBABY = "查看详情",
	DIALOGUEREMOVEBABY = "交给孤儿院",

	DIALOGUERECRUIT = "你站在 [name] 之前, 他被俘虏了，现在正在等待 [his] 命运. 你可以试着说服[him]自愿加入你，也可以把[him]变成奴隶.",
	DIALOGUERECRUITCHOOSEPERSON = "选择谈判者",
	DIALOGUERECRUITENSLAVE = "你决定不支持任何谈判，只是违背[his]意愿让[him]成为你的奴隶.",
	DIALOGUERECRUITGOOD = "您委托的仆人成功说服 [name] 为您服务.",
	DIALOGUERECRUITGOODSEDUCE = """Your entrusted servant successfully seduced [name], who agreed to serve you.""", # MISSING TRANSLATION
	DIALOGUERECRUITGOODSLAVE = "成为奴隶",
	DIALOGUERECRUITGOODSERVANT = "成为雇工",
	DIALOGUERECRUITFORCEATTEMPT = "奴役",
	DIALOGUERECRUITATTEMPT = "尝试招募",
	DIALOGUERECRUITSUCCUBUS = """Seduce (Succubus), 30 Mana""", # MISSING TRANSLATION
	DIALOGUERECRUITSUCCUBUSNOMANA = """Seduce (Succubus), 30 Mana (Not enough mana)""", # MISSING TRANSLATION
	
	DIALOGUERECRUITBAD = "你委托的仆人没能说服[name]为你服务……别无选择，你奴役[him].",
	
	
	DIALOGUEMEET = "你的仆人找到了一位潜在的可招聘人员, [name], 他似乎有兴趣加入你的家庭. ",
	DIALOGUEMEETBAD = "你没能说服 [name] ， [he] 向你道别.",
	DIALOGUEMEETGOOD = "经过讨论[name]同意成为你的追随者. ",
	DIALOGUEMEETGOODSEDUCE = """Being charmed by a lustful intentions, [name] agrees to become your follower. """, # MISSING TRANSLATION
	DIALOGUEMEETGOODDEFAULT = "作为雇工添加到花名册",
	DIALOGUEMEETGOODHIRELING = "",
	
	
	
	DIALOGUERANDOMBOSSDEFEAT = "战败的[name]就在你面前。招募[him]似乎不太现实，所以你将不得不奴役[him]…",
	DIALOGUERECRUITBOSSOPTION = "收押",
	DIALOGUEEXECUTEOPTION = "执行",
	DIALOGUEDUNGEONQUESTCOMPLETE = "你已经完成了清除 [dungeonname]的任务。在豪宅任务面板领取奖励。",
	DIALOGUELOCATIONQUESTCOMPLETE = "您已经解决了请求的问题。在豪宅任务面板领取奖励。 ",

	DIALOGUELOCATIONEVENT = "您可以在结算中寻找机会。此操作每天只能进行一次。您的声誉将根据您的操作而变化，并可能改变结果。 ",

	DIALOGUELOCATIONEVENTGOOD = "合法",
	DIALOGUELOCATIONEVENTEVIL = "行为不端",
	DIALOGUEATTACK = """Attack""", # MISSING TRANSLATION

	DIALOGUEATTACKMIMIC = "模拟攻击",
	DIALOGUEMIMICOPENANYWAY = "想方设法打开",

	DIALOGUEMISSIONCOMPLETE = '您的团队已完成任务并返回豪宅. ',
	DIALOGUESLAVEREMOVETEXT = """You can dismiss and set free [name] from your possession. 

{color=red|This action is final and can't be reverted.}""", # MISSING TRANSLATION
	DIALOGUESLAVEREMOVECONFIRMED = """You've decided to set [name] free.

{color=aqua|[name]} — {random_chat_active|leave}

[He] leaves you forever.""", # MISSING TRANSLATION

	
	SPECIAL_ACTION_CLASS = "特殊操作（需要未知课程）",
	DIALOGUECHARINSPECT = "检查",
	DIALOGUERECRUITCHARACTEROPTION = "招聘",
	DIALOGUELEAVE = "离开",
	DIALOGUELEAVERECRUITOPTION = "取消（放弃招募）",
	DIALOGUEEVENTNOTHING = "在四处搜索后，找不到任何感兴趣的东西…",
	DIALOGUEEVENTGOODRECRUIT = "在搜索[locationname]后，你听到了一个人愿意加入你的传言。过了一会儿，你发现[name], [age] [raceadj]，他似乎愿意离开这个地方。 ",
	DIALOGUEEVENTGOODLOOT = "搜索周围环境后，您发现一个小的上锁宝藏。 ",
	DIALOGUECHESTOPEN = "打开",
	DIALOGUETAKELOOT = "取走",
	DIALOGUEAPPROACHSHRINE = "接近神龛",
	DIALOGUESHRINECHOOSEPERSON = "选择另一个角色",
	DIALOGUESHRINEITEM = "上供",
	DIALOGUESHRINEEQUIP = """Offer a piece of equipment""", # MISSING TRANSLATION
	DIALOGUESHRINECHARACTER = "派遣 [name] 到祭坛",
	DIALOGUESHRINEDESTROY = "拆除神龛",
	DIALOGUECHESTLOCKPICK = "尝试开锁",
	DIALOGUECHESTLOCKPICKFAILURE = "[name] 失败了，机械装置卡住了。别无选择，只能现在离开…",
	DIALOGUELOCKPICKALARMFAILURE = "[name] 未能开锁，导致警报响起。过不了多久，敌人就会向你的位置发起进攻.",
	DIALOGUECHESTLOCKPICKBOMBFAILURE = "[name] 触发了炸弹陷阱机制，引发的爆炸伤害了房间里的所有人。箱子和里面的东西都被毁了…",
	DIALOGUECHESTLOCKPICKGASFAILURE = "[name] 已经触发了陷阱。房间里充满了有毒气体，小队很快就撤退了。然而，由于离箱子太近, [name] 仍然吸入了太多气体…",
	DIALOGUECHESTMIMICDISCOVERED = "当 [name] 在靠近箱子时 [he] 发现了一些不寻常的地方. 过了一会儿 [he] 通知说，这很可能不是箱子，而是拟态. ",
	DIALOGUECHESTMIMICTRAPPED = "当 [name] 在靠近箱子时, [he] 快意识到这不是箱子，而是一个即将吞噬 [him] 的拟态. 由于被困在粘液中, [he] 无法逃脱，除非得到帮助. \n\n{color=aqua|[name]} — {random_chat_active|mimic_eat}\n\n[He] 如果处于这种状态，肯定会被吃掉.",
	DIALOGUECHESTEROTICMIMICTRAPPED = "当 [name] 在靠近箱子时, [he] 快意识到这不是箱子，而是一个即将吞噬 [him] 的拟态. 然而，拟态似乎并没有伤害 [him], 而是抓住猎物，钻到 [his] 衣服下面. 如果没有外界的帮助，拟态肯定会对 [name] 随心所欲...\n\n{color=aqua|[name]} — {random_chat_active|mimic_rape}\n\n让[him]处于这种状态不会杀死[him]，但是...",
	DIALOGUECHESTMIMICTRAPPEDLEAVE = "你认为挑战拟态太危险了，把[name]留给他是可以接受的...\n\n{color=aqua|[name]} — {random_chat_active|mimic_leave}",
	DIALOGUECHESTMIMICEROTICTRAPPEDLEAVE = "你认为挑战拟态太危险了，把[name]留给他是可以接受的...\n\n{color=aqua|[name]} — {random_chat_active|mimic_erotic_leave}\n\n经过大约一个小时的色情呻吟和恳求[name]最终设法逃离.",
	DIALOGUECHESTLOCKPICKFREE = """As [name] attempts to pick a lock of the chest, [he] realize it was not locked in first place. """, # MISSING TRANSLATION
	DIALOGUECHESTLOCKPICKSUCCESS = "[name] 熟练地打开了箱子的锁，里面的东西现在属于你了. ",

	DIALOGUECHESTMIMICFIGHT = "挑战拟态",
	DIALOGUECHESTMIMICLEAVE = "别管拟态",

	DIALOGUEEVENTTRAP = "你遇到一个陷阱走廊。有人必须通过技能或他们的健康来解除它…",

	DIALOGUEWOLVES_SKIRMISH_START = "你可以找到当地人报告的狼的位置. ",
	DIALOGUEFIGHTOPTION = "战斗",
	DIALOGUEREBELS_SKIRMISH_START = "你发现了当地人报告的一群叛军。他们似乎已经准备好与你作战了.",
	DIALOGUEGOBLINS_SKIRMISH_START = "你发现了当地人报告的那群哥布林。他们似乎已经准备好和你战斗了.",
	DIALOGUEOGRE_SKIRMISH_START = "你发现了当地人报告的食人魔。它有同伴",
	DIALOGUETROLL_SKIRMISH_START = "你发现了当地人报告的食人魔。",

	DIALOGUESHRINECELENA = "你遇到一个宗教建筑：一个由轻金属制成的小神龛。它看起来很破旧，但你可以辨认出它的侧面刻着月亮的象征。尽管位于这样的地方，你仍然感觉到它周围有一种微弱的力量. ",
	DIALOGUESHRINEEREBUS = "你遇到一个不起眼的石头堆：一个不平整的小金字塔，顶部有一个相当大的洞。尽管它看起来很粗糙，但你能感觉到它周围有一种微弱的力量.",
	DIALOGUESHRINEFREYA = "你发现一个不同寻常的木结构：一个美丽的女性形象。特别突出的是，它似乎不是雕刻的，而是长成了这样的形状。你可以感觉到它周围有一种微弱的力量. ",


	DIALOGUESLAVERPURCHASE = "购买",
	DIALOGUEEVENTGOODSLAVERS = "你遇到一群从精灵之地回来的奴隶贩子。观察过后，你发现了一个被捕获的[age] [male] [race]，稍后将在当地市场出售。他们准备以合理的[price]黄金出售[him]。\n\n[race]让你绝望地看了一眼. ",
	DIALOGUEEVENTGOODSLAVERSACQUIRED = "现在你和[race_short][boy]单独在一起了。[he]仍然不确定[his]未来，[he]恳求你的宽恕. ",
	DIALOGUESLAVERSPURCHASE = "购买",
	DIALOGUEREQUESTSLAVE = "撒谎以说服商人将奴隶没收给你",
	DIALOGUEEVENTSLAVERSNEGOTIATESUCCESS = "[center]{color=green|成功!}[/center]\n[name] 告诉他们，从精灵之地贩卖奴隶是非法的，他们必须因此被捕。停顿片刻后，奴隶贩子离开被俘虏的 [race] 迅速撤退. ",
	DIALOGUEEVENTSLAVERSNEGOTIATEFAILURE = "[center]{color=red|失败!}[/center]\n[name]没能骗奴隶把奴隶留给你。他们很匆忙地离开了.",
	DIALOGUEKEEPSLAVEPERSON = "保留为奴隶",
	DIALOGUESETFREEPERSON = "释放",
	DIALOGUEEVENTPERSONFREE = "你已经释放了 [name]。[He]表达了[his]感激之情，并希望有一天能回报你。 ",
	DIALOGUEEVENTEXOTICTRADER = "你发现一个带着一大群警卫的异国奴隶贩子。异国奴隶稀有且昂贵，所以你应该认为自己很幸运。问候后，他会把自己的物品送给你.",


	DIALOGUEALIRONEXOTICTRADER = "今天早上你收到一条消息，今天艾维尔明克来到镇上。一个神秘的奴隶贩子，与稀有和奇异的种族打交道。他们似乎经常造访阿利隆，可能会提供一种可靠的方式来抓住一个不寻常的奴隶。\n\n如果你有足够的现金…",

	DIALOGUEPERSONASKTOJOIN = "主动加入",
	DIALOGUERECRUITSUCCESS = "[center]{color=green|成功!}[/center]\n[name] 说服 [scncharname] 加入你.",
	DIALOGUERECRUITFAILURE = "[center]{color=red|失败!}[/center]\n[name] 无法说服 [scncharname] 加入你.",

	DIALOGUEEVENTTRAPSUCCESS = "[center]{color=green|成功!}[/center]\n[name] 巧妙地解除了陷阱.",
	DIALOGUEEVENTTRAPFAILURE = "[center]{color=red|失败!}[/center]\n[name] 粗暴地解除了陷阱，在这个过程中受到了伤害.",
	DIALOGUEACTIVATETRAP = "停用陷阱",

	DIALOGUEDUNGEONCHEST = "你发现一个锁着的箱子. ",
	DIALOGUEDUNGEONARMORY = "你发现一个锁着的军械库，里面可能有有用的东西.",
	DIALOGUEEVENTDUNGEONLOOT = "进入最后一个房间后，你会发现主储藏室里存放着最珍贵的物品. ",
	DIALOUELOCKEDDOOR = """The pass forward ends in a sturdy locked door. It seems to get through it you might need an additional force... or someone who can lockpick.""", # MISSING TRANSLATION
	DIALOUELOCKEDDOORSELECT = """Select character (3 Stamina)""", # MISSING TRANSLATION
	DIALOUELOCKEDDOORBREAK = """Break Through (10 Stamina)""", # MISSING TRANSLATION
	DIALOUELOCKEDDOORPASS = """[name] skillfully unlocks door blocking the pass allowing to proceed. """, # MISSING TRANSLATION
	DIALOGUEBLOCKEDPATH = """The pass ahead is blocked by a collapsed tunnel. It seems it still can be fixed by someone with enough physical fitness relatively quickly.""", # MISSING TRANSLATION
	DIALOGUEBLOCKEDPATHSELECT = """Select character (3 Stamina)""", # MISSING TRANSLATION
	DIALOGUEBLOCKEDPATHBREAK = """Spend time clearing the passage (10 Stamina)""", # MISSING TRANSLATION
	DIALOGUEBLOCKEDPATHPASS = """[name] lifts one of the crushed wooden bars and manages to push it away, clearing the path ahead.""", # MISSING TRANSLATION
	DIALOGUEMAGICBARRIER = """""", # MISSING TRANSLATION
	DIALOGUEMAGICBARRIERSELECT = """""", # MISSING TRANSLATION
	DIALOGUEMAGICBARRIERBREAK = """""", # MISSING TRANSLATION
	DIALOGUEMAGICBARRIERPASS = """""", # MISSING TRANSLATION

	DIALOGUEGROVEWOOD = "你发现一堆准备好的木头，可能被一些伐木工遗弃了. ",
	DIALOGUEGROVELEATHER = "你发现了一堆隐藏的皮革，可能是偷猎者留下的. ",
	DIALOGUECRYPTBONES = "你发现了一堆保存完好的骨头. ",

	DIALOGUEEVENTDUNGEONPRISONER = "你遇到一个牢房，里面关押着一个被捆绑的 [race] [male], 很可能是被强盗勒索或嘲弄的囚犯。在你靠近时 [he] 告诉你 [his] 名字是 [name] 并向你求援.",
	DIALOGUETAKESLAVE = "捕获并奴役",
	DIALOGUEEVENTDUNGEONPRISONERSENSLAVE = "你从[his]牢房里释放[name]，结果却把[he]变成了你的奴隶。当[he]被护送回你的豪宅时，你的团队继续前进. ",

	DIALOGUEEVENTDUNGEONPRISONERFREE1 = "你释放并解除了[name]的束缚，这让[he]松了一口气。[he]感谢你，[He]向你展示了[he]牢房附近的一小部分资源，以感谢对[he]的救援。在向[he]解释了如何离开后，你准备继续前行.",
	DIALOGUEEVENTDUNGEONPRISONERFREE2 = "你释放并解除了[name]的束缚，这让[he]松了一口气。[he]感谢你，[He]向你展示了[he]牢房附近的一件秘密物品，以感谢对[he]的救援。在向[he]解释了如何离开后，你准备继续前行.",
	DIALOGUEEVENTDUNGEONRESOURCE = """There are resources in this room. You can harvest {amount} items of {resource} later or spend {stamina_cost} stamina to get half of that amount now.""", # MISSING TRANSLATION

	DIALOGUEEVENTGOBLINFRIENDLY = "当你穿过洞穴时，你发现了一个与世隔绝的房间。当你闯入时，一个孤独的小哥布林[boy]吓得跳了起来。\n\n-等等，等等，请不要杀了我！我不想打架，我只是偶然来到这里。我保证，我不会告诉任何人我见过你。\n\n[He]懂普通语言，与其他人完全不同，你会考虑如何处置[he].",
	DIALOGUEEVENTGOBLINRECRUIT = "尝试招募",
	DIALOGUEEVENTGOBLINBRINGTOLEADER = "请求把他把你带到首领那里",
	DIALOGUEEVENTGOBLINKILL = "杀死",
	DIALOGUEEVENTGOBLINCAPTURE = "捕获",
	DIALOGUEEVENTGOBLINLEAVE = "让他走",
	DIALOGUEEVENTGOBLINRECRUITSUCCESS = "[center]{color=green|成功!}[/center]\n— 呃？…你想让我为你工作吗？嗯，我不能拒绝像你这样高大强壮的人，是吗？我的意思是，我很乐意接受你的提议！这个地方毕竟太糟糕了。\n\n[name]接到指示后，他很快就消失在前往你的豪宅的路上了.",
	DIALOGUEEVENTGOBLINRECRUITFAILURE = "[center]{color=red|失败!}[/center]\n— 呃？……我……不认为这是个好主意，我们不喜欢吃槟榔，你知道。现在，如果你原谅我……\n\n你还没反应过来，小妖精[boy]就消失在了一个你在入口处没有注意到的隧道里.",
	DIALOGUEEVENTGOBLINBRINGTOLEADERSUCCESS = "[center]{color=green|成功!}[/center]\n— 你真的是认真的吗？！我想像你这样的人可以做到……好吧，好吧，我给你带路，但之后你再也看不到我了。跟上我。\n\n穿过洞穴迷宫几分钟后，你就来到了房间的入口处，房间似乎通向当地的哥布林首领。在你注意到之前，小哥布林已经从视线中消失了.",
	DIALOGUEEVENTGOBLINBRINGTOLEADERFAILURE = "[center]{color=red|失败!}[/center]\n— 这……这太不合理了，你知道，我还没有疯。如果你这么愿意死，就不要把我拖进去。\n\n当[he]说话时，[he]移动到一个奇怪的位置，在你反应过来之前就从房间里冲了出来. ",
	DIALOGUEEVENTGOBLINCAPTUREREPLY = "你认为文明的哥布林可以成为一个有用的工具，也可以在市场上赚取一些利润. 没有给 [him] 第二次机会, 你就抓住了他 [him].\n\n— 嘿，你他妈想干什么?! 放开我！…你们这些混蛋！",
	DIALOGUEEVENTGOBLINKILLREPLY = "你不能冒险让任何可疑的哥布林离开，更不用说警告其他人了。在他做出反应之前，你的团队就把他打倒了。不幸的是，这里没有其他感兴趣的东西.",
	DIALOGUEEVENTGOBLINLEAVEREPLY = "即使在这样的地方，也没有必要处置一个友好的哥布林。你允许[he]自由，这让[he]脸上松了一口气。\n\n--太好了！我会送别的。祝你们好运，伙计们！",
	DIALOGUEEVENTFAIRYFRIENDLY = "当你穿过树林时，一个孤独的仙精跳到你面前。[he]似乎对遇到一个从未见过的人感到好奇。\n\n-嘿，你在这里做什么？我从未见过你…\n\n[he]出于无聊或好奇似乎愿意和你在一起，至少聊一聊。",
	DIALOGUEEVENTFAIRYRECRUIT = "尝试招募",
	DIALOGUEEVENTFAIRYCAPTURE = "捕获",
	DIALOGUEEVENTFAIRYASKHEAL = "请求治疗",
	DIALOGUEEVENTFAIRYLEAVE = "离开",
	DIALOGUEEVENTFAIRYRECRUITSUCCESS = "[center]{color=green|成功!}[/center]\n— 冒险？…听起来很有趣。好吧，我喜欢你，我想看看世界！\n\n[scncharname] 决定加入你的团队.",
	DIALOGUEEVENTFAIRYRECRUITFAILURE = "[center]{color=red|失败!}[/center]\n—对不起，我不明白。我想我最好现在就走，再见！\n\n不幸的是, [name] 没能说服仙精加入你。也许[he]需要更多的练习……仙女很快就消失在了树林里.",
	DIALOGUEEVENTFAIRYASKHEALREPLY = "— 哦，你受伤了？当然，我会帮助你的！\n\n[His] 魔法恢复了你团队的一些伤口 [he] 在收到你的感谢后愉快地离开了。\n\n所有团队恢复35%的生命值。",
	DIALOGUEEVENTFAIRYCAPTUREREPLY = "在 [he] 做出反应之前，你的团队很快就把 [him] 抓住了。嘿，wha-.住手！你在做什么！？让我走！！\n\n当 [boy] 成为你的奴隶时, [he] 可以成为你的豪宅中非常有用的补充，也可以从收藏家那里赚一大笔钱。",
	DIALOGUEVENTFAIRYLEAVEREPLY = "聊了一会儿，你就和仙精分道扬镳了. ",
	
	
	DIALOGUETUTELAGETEXT = "你决定留下新生儿，但你必须决定未来的教育，这可能会提高或纠正他们的潜力。无论哪种方式，成长都需要两周时间。\n\n{color=aqua|无培训}— {color=yellow|无花费}, 但有机会获得新的负面特征;\n{color=aqua|奴隶训练}— {color=yellow|500 金币}, 为忠诚度提供了很大的提升，并有机会提高驯服或胆怯的因素;\n{color=aqua|学院}— {color=yellow|1500 金币}, 提供了物理和智慧的提升以及大量的经验;\n{color=aqua|继承人教育} (仅限继承人)— {color=yellow|5000 金币}, 提供所有统计数据和因素的提升，大量经验和1个随机正面特征.",
	
	DIALOGUETUTNOTHING = "无培训 (free)",
	DIALOGUETUTSLAVE = "奴隶训练 (500 金币)",
	DIALOGUETUTACADEMY = "学院 (1500 金币)",
	DIALOGUETUTHEIR = "继承人教育 (5000 金币)",
	
	SPRINGTEXT = "你发现一个干净的小空地。这可能是休息的好时机.",
	SPRING_HEAL = "您的团队休息并恢复一些健康.",
	SPRING_STAMINA = """Your group rests and recover their energy.""", # MISSING TRANSLATION
	SPRING_HEAL_OPTION = "休息",
	SPRING_STAMINA_OPTION = """Take a rest""", # MISSING TRANSLATION
	SPRING_LOOT_OPTION = "搜索",
	FOUNTAINTEXT = """You find a small fountain still brimming with clear water. You could use it to ease group's exhaustion, but it seems there's also some raw mana available for extraction...""", # MISSING TRANSLATION
	FOUNTAINSTAMINAOPTION = """Take a rest""", # MISSING TRANSLATION
	FOUNTAINMANAOPTION = """Harness magic""", # MISSING TRANSLATION
	FOUNTAIN_MANA = """The group manages to extract mana from the fountain and restore their powers.""", # MISSING TRANSLATION
	FOUNTAIN_STAMINA = """The group takes a rest in the room and recover their energy.""", # MISSING TRANSLATION
	DIALOGUE_SPRING_LOOT = "在四处搜寻后，你发现了一个小藏匿处。你决定自己拿走里面的东西.",
	DIALOGUE_SPRING_NO_LOOT = "您四处搜索，但找不到任何有用的东西.",
	TRIBALELVES = "你发现自己被一群当地部落精灵包围。他们似乎认为你是他们领土上的入侵者，正在准备攻击...",
	TRIBALELVES_WIN = "当你击败攻击者时，他们匆忙撤退，但其中一人被落在了后面，你的团队成功制服了他们.",


	DIALOGUEEVENTGOODREBELSBEAST = "你遇到了一小群反叛分子，他们抓住了一个可能远离家乡的 [race] [male] 考虑到反叛分子对[him]的态度，很容易看出他们做了坏事...",
	DIALOGUEEVENTREBELSBEASTINTIMIDATESUCCES = "[center]{color=green|成功!}[/center]\n[name] 成功地恐吓了一群反叛分子逃离，留下了他们的受害者.", #to rework
	DIALOGUEEVENTREBELSBEASTINTIMIDATEFAILURE = "[center]{color=red|失败!}[/center]\n[name] 未能恐吓叛军，他们正准备攻击你. ",

	DIALOGUEINTIMIDATE = "恐吓",


	LOCAL_SHOP = "商店",
	LOCAL_EVENTS_SEARCH = "搜索",

	RETURNTOMANSIONBUTTON = "将角色送回豪宅",
	RETURNCHARACTERCONFIRM = "命令 [name] 返回豪宅?",
	ITEMMAP_BANDIT_DEN = """Map: Bandit Den""", # MISSING TRANSLATION
	ITEMMAP_BANDIT_FORT = """Map: Bandit Fort""", # MISSING TRANSLATION
	ITEMMAP_GROVE = """Map: Grove""", # MISSING TRANSLATION
	ITEMMAP_GOBLIN_CAVE = """Map: Goblin Cave""", # MISSING TRANSLATION
	ITEMMAP_UNDEAD_CRYPT = """Map: Crypt""", # MISSING TRANSLATION
	ITEMMAP_ANCIENT_JUNGLES = """Map: ncient Jungles""", # MISSING TRANSLATION
	ITEMMAP_FIRE_DEPTHS = """Map: Fire Depths""", # MISSING TRANSLATION
	ITEMMAP_BANDIT_DENDESCRIPT = """A paper filled with clues which can help you locate a hidden location to explore... Or sell to the shop.""", # MISSING TRANSLATION
	ITEMMAP_BANDIT_FORTDESCRIPT = """A paper filled with clues which can help you locate a hidden location to explore... Or sell to the shop.""", # MISSING TRANSLATION
	ITEMMAP_GROVEDESCRIPT = """A paper filled with clues which can help you locate a hidden location to explore... Or sell to the shop.""", # MISSING TRANSLATION
	ITEMMAP_GOBLIN_CAVEDESCRIPT = """A paper filled with clues which can help you locate a hidden location to explore... Or sell to the shop.""", # MISSING TRANSLATION
	ITEMMAP_UNDEAD_CRYPTDESCRIPT = """A paper filled with clues which can help you locate a hidden location to explore... Or sell to the shop.""", # MISSING TRANSLATION
	ITEMMAP_ANCIENT_JUNGLESDESCRIPT = """A paper filled with clues which can help you locate a hidden location to explore... Or sell to the shop.""", # MISSING TRANSLATION
	ITEMMAP_FIRE_DEPTHSDESCRIPT = """A paper filled with clues which can help you locate a hidden location to explore... Or sell to the shop.""", # MISSING TRANSLATION


	LOCATIONNAMESKIRMISH_BANDIT_CAMP = "Bandit Camp 土匪营地",
	LOCATIONNAMESKIRMISH_FOREST_WOLVES = "Forest 森林",
	LOCATIONNAMEDUNGEON_BANDIT_DEN = "Bandit Den 土匪窝",
	LOCATIONNAMEDUNGEON_BANDIT_FORT = "Bandit Fort 土匪堡",
	LOCATIONNAMEDUNGEON_REBEL_REDOUBT = """Rebel Redoubt""", # MISSING TRANSLATION
	LOCATIONNAMEDUNGEON_GROVE = "Grove 树林",
	LOCATIONNAMEDUNGEON_GOBLIN_CAVE = "Goblin Cave 哥布林巢穴",
	LOCATIONNAMEDUNGEON_UNDEAD_CRYPT = "Crypt 地穴",
	LOCATIONNAMEDUNGEON_MOUNTAINS = "Mountain Cave 山洞",
	LOCATIONNAMEDUNGEON_VOLCANO = "Volcanic Cave 火山山洞",
	LOCATIONNAMEDUNGEON_CITY = "Ruined City 城市废墟",
	LOCATIONNAMEBASIC_THREAT_WOLVES = "Skirmish 遭遇战",
	LOCATIONNAMEDUNGEON_ANCIENT_JUNGLES = "Ancient Jungles 古代丛林",
	LOCATIONNAMEDUNGEON_FIRE_DEPTHS = "Fire Depths 火之心",
	LOCATIONNAMEDUNGEON_FROZEN_DOMAIN = "Frozen Domain 寒霜领域",
	LOCATIONNAMEDUNGEON_DRAGON_NEST = "Dragon Nest 龙巢",
	LOCATIONNAMEDUNGEON_QUEST_MINES_DUNGEON = "Mines 矿山",
	LOCATIONNAMEQUEST_FINAL_OPERATION_LOCATION = "Rebels' Hideout 叛军藏身处",
	LOCATIONNAMEQUEST_GRYPHON_FOREST_LOCATION = "Gryphon Thicket 鹰头狮藏身处",
	LOCATIONNAMEQUEST_GRYPHON_LAIR_LOCATION = "Elder Grypho Lair 鹰头狮老巢",
	LOCATIONNAMEQUEST_RITUAL_LOCATION = "Herbs Field 草药田",
	LOCATIONNAMEQUEST_LEON_FOREST = "Leon's location 莱昂的位置",
	LOCATIONNAMEQUEST_LEON_FOREST_2 = "Leon's location 莱昂的位置",
	LOCATIONNAMEQUEST_CALI_BANDITS_LOCATION = "Bandits' Hideout 土匪藏身处",
	LOCATIONNAMEQUEST_MINES_DUNGEON = "Mines 矿山",
	LOCATIONNAMEQUEST_AMELIA_BANDITS_LOCATION = "Amelia's Location 阿米莉亚的位置",
	LOCATIONNAMEQUEST_ANCIENT_JUNGLE_LOCATION = "Ancient Ruins 古代废墟",
	HIRELINGFOUND = "已找到新兵",
	SETTLEMENT = "结算",
	SETTLEMENT_SMALL = "村庄",
	SETTLEMENT_LARGE = "城镇",
	SETTLEMENT_PLAINS1 = "结算",
	SETTLEMENT_PLAINS2 = "结算",
	SETTLEMENT_PLAINS3 = "结算",
	SETTLEMENT_PLAINS4 = "结算",
	SETTLEMENT_FOREST1 = "结算",
	DUNGEONDIFFICULTY = "难度",
	DUNGEONDIFFICULTYEASY = "简单",
	DUNGEONDIFFICULTYMEDIUM = "中等",
	DUNGEONDIFFICULTYHARD = "困难",

	ENEMYBANDIT_MELEE = "土匪",
	ENEMYBANDIT_ARCHER = "土匪射手",
	ENEMYBANDIT_MAGE = "土匪法师",
	ENEMYBANDIT_BOSS_MELEE = "猛兽",
	ENEMYBANDIT_BOSS_ARCHER = "死亡之眼",
	ENEMYBANDIT_BOSS_MAGE = "盗贼魔法师",
	ENEMYRAMONT_BOSS = "拉蒙特",
	ENEMYHECTOR_BOSS = "赫克托",
	ENEMYREBEL_RECRUIT = "叛军新兵",
	ENEMYREBEL_KNIGHT = "叛军骑士",
	ENEMYREBEL_MAGE = "叛军法师",
	ENEMYREBEL_HEALER = "叛军医师",
	ENEMYCAVE_GOBLIN_MELEE = "洞穴哥布林",
	ENEMYCAVE_GOBLIN_ARCHER = "洞穴哥布林射手",
	ENEMYCAVE_GOBLIN_SHAMAN = "洞穴哥布林萨满",
	ENEMYCAVE_GOBLIN_MAGE = """Cave Goblin Mage""", # MISSING TRANSLATION
	ENEMYCAVE_GOBLIN_BOSS = "洞穴哥布林首领",
	ENEMYQUEST_GOBLIN_BOSS = "哥布林暴徒",
	ENEMYQUEST_GOBLIN_SHAMAN = "哥布林法师",
	ENEMYOGRE_MELEE = "食人魔",
	ENEMYOGRE_MAGE = "食人魔法师",
	ENEMYGRYPHON = "鹰头狮",
	ENEMYELDER_GRYPHON_BOSS = "老鹰头狮",
	ENEMYWOLF = "狼",
	ENEMYRAT = "老鼠",
	ENEMYSPIDER = "蜘蛛",
	ENEMYTRAINED_DOG = "训练有素的狗",
	ENEMYTRAINED_BEAR = "训练有素的熊",
	ENEMYTRAINED_RAPTOR = "训练有素的猛禽",
	ENEMYGUARDIAN_GOLEM = "魔像看守",
	ENEMYZOMBIE = "僵尸",
	ENEMYSKELETON_MELEE = "骷髅",
	ENEMYSKELETON_ARCHER = "骷髅射手",
	ENEMYLICH_QUEST = "巫妖",
	ENEMYUNDEAD_LICH = "巫妖",
	ENEMYMIMIC = "拟态",
	ENEMYBALLISTA = "巴利斯塔",
	ENEMYTROLL = "巨魔",
	ENEMYBANDIT_ASSASSIN = "土匪刺客",
	ENEMYSUMMON_DOG = """Trained Dog""", # MISSING TRANSLATION
	ENEMYSUMMON_SKELETON_MELEE = """Skeleton Warrior""", # MISSING TRANSLATION
	ENEMYSUMMON_SKELETON_ARCHER = """Skeleton Archer""", # MISSING TRANSLATION

	ENEMYDEMONESS = "女恶魔",
	ENEMYGREG = "格雷格",
	ENEMYAIRE = "艾尔",
	ENEMYKURDAN = "库尔丹",
	
	ENEMYLEON = "莱昂",
	ENEMYWHITE_STAG = "白色牡鹿",
	ENEMYWHITE_STAG_HUMAN = "神秘人",
	ENEMYELF_SPECTER = "精灵幽魂",
	ENEMYELF_SOLDIER = "精灵战士",

	FOODFILTERHIGH = "高优先级",
	FOODFILTERMED = "中优先级",
	FOODFILTERLOW = "低优先级",
	FOODFILTERDISABLE = "禁止",

	USABLE = "可用",

	SWITCHSTATS = "个人统计",
	SWITCHLIST = "角色列表",

	SCENEDAISY_MEET_TEXT = "当你在镇上走的时候，你听到一些争吵声。一个大个子男人对着坐在陶器碎片附近哭泣的年轻的混血兔人女孩喊道。\n\n--你这个笨拙的蠢蛋！这已经是第三次了。我现在要把你卖给妓院，至少这样你会有点用。\n\n-这个女孩似乎不适合体力劳动，但很有吸引力. ",
	SCENEDAISY_MEET_OPTION1 = "提出购买女孩",
	SCENEDAISY_MEET_OPTION2 = "假装女孩是你的亲人",
	SCENEDAISY_MEET_OPTION3 = "忽略",
	SCENEDAISY_CLAIM_KINSHIPTEXT = "你告诉那个男人，这个女孩是你的亲戚，他的行为是不可接受的\n\n被你的打断吓了一跳，他很快后退，把她递给了你。\n\n这个女孩似乎松了一口气，尽管她识破了你的谎言。\n\n她告诉你，她的名字叫黛西，她会尽力为你服务。 ",
	SCENEDAISY_PURCHASE_TEXT = "你提出从那个男人那里买下这个可怜的女孩。\n\n经过一番谈判，他给你200金币的价格。 ",
	SCENEDAISY_PURCHASE_OPTION1 = "砍价",
	SCENEDAISY_PURCHASE_OPTION2 = "购买 (200 金币)",
	SCENEDAISY_PURCHASE_OPTION2_1 = "购买 (100 金币)",
	SCENEDAISY_PURCHASE_OPTION3 = "拒绝",
	SCENEDAISY_PURCHASE_NEGOTIATE_TEXT1 = "通过一些额外的讨价还价，你设法让这个人把要求降低到100金币。但这是他的最后报价.",
	SCENEDAISY_PURCHASE_NEGOTIATE_TEXT2 = "你进一步降低女孩价格的尝试失败了，男人要200金币或告诉你走开.",
	SCENEDAISY_PURCHASE_CONFIRM_TEXT = "付出了代价，混血兔人女孩小心翼翼地走到你身边。告诉你她叫黛西。\n\n她承诺会尽力，但你可以看到她显然是在强迫自己抬头看你. ",
	SCENEDAISY_PURCHASE_LEAVE_TEXT = "您拒绝了该男子的价格并离开了现场.",
	SCENEDAISY_IGNORE_TEXT = "你继续你的路，没有再注意他们.",
	SCENEDAISY_FIRST_EVENT_TEXT = "你听到了撞击声，很快就找到了黛西，她似乎毁坏了一块餐具。\n\n她瞪大了眼睛，抬头看着你，等待你的惩罚. ",
	SCENEDAISY_FIRST_EVENT_OPTION1 = "让她放心",
	SCENEDAISY_FIRST_EVENT_OPTION2 = "管教她",
	SCENEDAISY_FIRST_EVENT_REASSURE = "你帮助并鼓励她下次做得更好。\n\n被你的善意吓了一跳，黛西的表情很难掩饰她内心的幸福.",
	SCENEDAISY_FIRST_EVENT_DISCIPLINE = "你把一个瑟瑟发抖的黛西带进了一个私人房间。\n\n从一些痛苦和羞辱开始，你逐渐给她的身体提供了新的感觉。\n\n她痛苦的哭泣慢慢地获得了新的音符。\n\n她泪眼婆娑的表情不仅反映了恐惧，还反映了醉酒般后的放松。\n\n之后你要确保她吸取了教训，她会以尊重的渴望做出回应。",
	SCENEDAISY_CONFESS_EVENT_TEXT = "当你在豪宅里走来走去时，你注意到黛西看起来很沮丧。\n\n你走近她，问她发生了什么，但她小心地回避了这个问题。\n\n在命令她告诉你怎么了之后，她终于开口了。\n\n-我…我爱[master]，但[he]永远不会爱像我这样无用的人. ",
	SCENEDAISY_CONFESS_EVENT_OPTION1 = "接受她的感受",
	SCENEDAISY_CONFESS_EVENT_OPTION2 = "拒绝她",
	SCENEDAISY_CONFESS_ACCEPT_TEXT = "— 不，不可能！你也有同样的感觉？！我简直不敢相信……你把嘴唇压在黛西身上，她屈服于你的怀抱。\n\n她希望能和你共度今晚.",
	SCENEDAISY_CONFESS_REFUSE_TEXT = "你礼貌地拒绝了黛西的告白。\n\n-我明白了……但如果这对你来说太过分了，我可以做你的……夜班服务员。\n\n黛西似乎还有一些希望最终赢得你的爱。 ",

	SCENEDAISY_PURCHASE_WORKER_OPTION1 = "指出她的力量不足将极大地影响她的表现（工人）",
	SCENEDAISY_PURCHASE_WORKER1 = "所有者不情愿地同意你的意见，并将价格减半。",

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
	
	
	
	ITEMHAIRDYE = "染发剂",
	ITEMHAIRDYEDESCRIPT = "允许您更改一个人的头发颜色.",


	ITEMMINORUS_POTION = "米诺鲁斯药剂",
	ITEMMINORUS_POTIONDESCRIPT = "一种特殊的药剂，可以用来缩小一个人的特定身体部位。可以用于乳房、臀部、阴茎和睾丸.",
	ITEMMAJORUS_POTION = "马霍尔药剂",
	ITEMMAJORUS_POTIONDESCRIPT = "一种特殊的药剂，可以用来增大一个人的特定身体部位。可以用于乳房、臀部、阴茎和睾丸.",
	ITEMEXP_SCROLL = "知识卷轴",
	ITEMEXP_SCROLLDESCRIPT = "为使用者提供100点经验.",


	DIALOGUEEVENTMINORUSSELECT = "选择 [name] 的哪个身体部位应该缩小.",
	DIALOGUEEVENTMAJORUSSELECT = "选择 [name] 的哪个身体部位应该增大.",
	DIALOGUEPOTIONNOEFFECT = "不幸的是，这种药剂完全无效.",

	DIALOGUEMINORUSPOTTITS = "在 [name]的乳房上涂抹米诺鲁斯药剂后，乳房会缩小.",
	DIALOGUEMINORUSPOTASS = " 在 [name]的屁股上涂上米诺鲁斯药剂后，它的体积缩小了.",
	DIALOGUEMINORUSPOTPENIS = " 在 [name]的阴茎上涂上米诺鲁斯药剂后，它的体积缩小了.",
	DIALOGUEMINORUSPOTBALLS = " 在 [name]的睾丸上涂上米诺鲁斯药剂后，它的体积缩小了.",
	DIALOGUEMAJORUSPOTTITS = " 在 [name]的乳房上涂抹马霍尔药剂后，乳房会增大.",
	DIALOGUEMAJORUSPOTASS = " 在 [name]'的屁股上涂上马霍尔药剂后，它的体积增大了.",
	DIALOGUEMAJORUSPOTPENIS = " 在 [name]的阴茎上涂上马霍尔药剂后，它的体积增大了.",
	DIALOGUEMAJORUSPOTBALLS = " 在 [name]的睾丸上涂上马霍尔药剂后，它的体积增大了.",

	DIALOGUEOBLIVIONPOTUSE = "[name] 大口喝着遗忘药剂. [He] 踉踉跄跄地看着以前的记忆离开 [his] 脑海.",
	DIALOGUEPHEROMONESSELF_SUCCESS = "在 [name] 吸收信息素时，强烈的欲望很快就会压倒你.",
	DIALOGUEPHEROMONESSELF_FAIL = "信息素丝毫没有影响你. ",
	DIALOGUEPHEROMONES_SUCCESS = "在 [name] 吸收信息素时，强烈的欲望很快就会压倒 [him]. 不知道该怎么办, [he] 恳求地看了你一眼.\n\n{color=aqua|[name]}— {random_chat_active|春药}",
	DIALOGUEPHEROMONES_FAIL = "[name] 似乎完全不受信息素的影响。这似乎是浪费.",

	DIALOGUEWRIT_CONFIRM = "使用此令状将[name]从奴隶制中解放出来，使[him]成为雇工。然而，如果[him]愿意，这将允许[he]离开你.",
	DIALOGUEWRIT_SUCCESS = "[name] 不敢相信 [his] 眼睛，因为 [he] 从你那里得到了 [his] 自由的证明. 过了一会, [he] 宣布 [his] 愿意继续在你的统治下服务. \n\n{color=aqua|[name]} — {random_chat=0|writ_success}",
	DIALOGUEWRIT_FAILURE = "[name] 不敢相信 [his] 眼睛，因为 [he] 从你那里得到了 [his] 自由的证明. 然而，在长时间的停顿之后 [he]抓住了这个机会，决定离开你. \n\n{color=aqua|[name]} — {random_chat=0|writ_failure}",
	DIALOGUELACTATION_SUCCESS = """As [name] drinks the potion, [his] chest begins ripening and feeling heavier. [His] nipples start seeping with milk much to [his] shame.""", # MISSING TRANSLATION
	DIALOGUELACTATION_REVERSE = """As [name] drinks the potion, [his] chest seemingly returns to normal, no longer producing any milk. """, # MISSING TRANSLATION

	DIALOGUETITSSELECT = "乳房",
	DIALOGUEASSSELECT = "屁股",
	DIALOGUEBALLSSELECT = "睾丸",
	DIALOGUEPENISSELECT = "阴茎",

	WORKRULERATION = "额外配给",
	WORKRULERATIONDESCRIPT = "Increases Food Consumption by 3. Boosts Productivity by 15%.",
	WORKRULESHIFTS = "长时间轮班",
	WORKRULESHIFTSDESCRIPT = "Character overperforms at their finest capability at the cost of future improvements. \nBoosts Productivity by 25%. Character won't gain Experience or Work Stats(Physical, etc) while working. ",
	WORKRULECONSTRAIN = "强制劳动",
	WORKRULECONSTRAINDESCRIPT = "Character is forced to work at their best via strict regulations. Boosts productivity by 15%. Obedience Drain is increased by 6.",
	WORKRULELUXURY = "私人房间",
	WORKRULELUXURYDESCRIPT = "Character will have a personal room to live at. Obedience Drain -3, Loyalty Gain +0.5",
	
	WORKRULECONTRACEPTIVE = "避孕药",
	WORKRULECONTRACEPTIVEDESCRIPT = "Prevents pregnancy and impregnation for selected character.",
	
	WORKRULENUDITY = "裸体",
	WORKRULENUDITYDESCRIPT = "Forces [name] to stay naked while at mansion (if has corresponding sprite). This effect is cosmetic.",
	WORKRULEPERSONALITY_LOCK = """Lock Personality""", # MISSING TRANSLATION
	WORKRULEPERSONALITY_LOCKDESCRIPT = """[name] will no longer have [his] personality affected by social actions.""", # MISSING TRANSLATION
	
	SERVICEENSLAVE = "奴役",
	SERVICEENSLAVEDESCRIPT = "Makes chosen character into a Slave.\n\n[color=aqua]Slaves suffer 10% damage reduction but gain various collection bonuses and but their Loyalty can be increased by punishing skills.[/color]",

	NEWGAMESETTINGINFO = "These settings can be changed in Options at any point in future",

	SETTINGFUTA_NAME = "扶她",
	SETTINGFUTA_DESCRIPT = "Allows random generation of futanari (dickgirl) characters.",
	SETTINGFURRY_NAME = "福瑞",
	SETTINGFURRY_DESCRIPT = "Allows random generation of beastkin characters (replaced with halfkin otherwise if applicable).",
	SETTINGFUTA_BALLS_NAME = "扶她睾丸",
	SETTINGFUTA_BALLS_DESCRIPT = "Defines if futa characters will have testicles when generated.",
	SETTINGFURRY_MULTIPLE_NIPPLES_NAME = "兽化种副乳",
	SETTINGFURRY_MULTIPLE_NIPPLES_DESCRIPT = "Defines if furry characters will have extra non-developed breasts.",
	SETTINGFUTACHANCE_NAME = "扶她比例",
	SETTINGFUTACHANCE_DESCRIPT = "Sets a chance that a randomly generated female will be a futanari.",
	SETTINGMALECHANCE_NAME = "男性比例",
	SETTINGMALECHANCE_DESCRIPT = "Sets a chance that a character with no preset gender will become a male instead of female.",
	SETTINGMEOWING_NAME = "喵喵叫",
	SETTINGMEOWING_DESCRIPT = "Beastkin and Halfkin Cat characters will have slightly different speech patterns.",
	SETTINGTURN_BASED_TIME_FLOW_NAME = "基于回合\n时间流",
	SETTINGTURN_BASED_TIME_FLOW_DESCRIPT = "Makes time flow into hour long turns.",


	#dialogues
	INTRODIALOGUE = "自从人类王国被改革为卢梭共和国以来，十二年过去了。摆脱了前一次统治，其首都阿利隆已成为社会和文化生活的中心，即使是最底层的人也有机会成为有权力和影响力的人，前提是他们有能力。。。\n\n你是那些设法及时到达那里的人之一，以收购最近摆脱旧所有权的地产。唯一的问题是它的售价超出了你的能力。在没有其他选择开始新生活的情况下，你已经获得了一笔巨额贷款来实现你的目标。你成为了一小块土地的主人，上面有一栋破旧的豪宅。",

	STARTINGDIALOGUE0 = "就在你刚搬完家时，银行助理出现在你家门口查看你的情况。\n\n-早上好，[Sir] [surname]。你觉得你的新房产怎么样？",
	STARTINGDIALOGUE0REPLY1 = "太棒了",
	STARTINGDIALOGUE0REPLY2 = "真是个贫民窟",
	STARTINGDIALOGUE0REPLY3 = "开门见山",
	STARTINGDILOGUE1_1 = "— 很高兴你喜欢它.\n\n",
	STARTINGDILOGUE1_2 = "— 确实如此.\n\n",
	STARTINGDILOGUE1_3 = "— 啊，一个 [man] 商人? 我喜欢.\n\n",
	STARTINGDILOGUE1_4 = "— 我来这里是为了提供您将要支付贷款的计划。您总共欠银行100000金币，您将被要求在未来100天内支付。作为障碍，您的第一笔付款将由 {custom_text_function=GetLoanSum#0|} 金币组成，两周后到期.",
	STARTINGDIALOGUE1REPLY1 = "明白了",
	STARTINGDIALOGUE1REPLY2 = "真的希望我赚这么多吗？",
	STARTINGDIALOGUE2_1 = "— 好. ",
	STARTINGDIALOGUE2_2 = "— 不，我们没有。一旦你破产，我们希望能收回土地，但由于我们还没有资源进行开发，我们可以尝试一些不同的方法. \n\n— ",
	STARTINGDIALOGUE2_3 = "如果你没有更多问题，我就离开.",
	STARTINGDIALOGUE2REPLY1 = "我怎么能赚这么多钱？",
	STARTINGDIALOGUE2REPLY2 = "拥有土地有什么特别的吗？",
	STARTINGDIALOGUE2REPLY3 = "什么是行会？",
	STARTINGDIALOGUE2REPLY4 = "我没问题了",
	STARTINGDIALOGUE3_1 = "— 当然不是你一个人。作为一个土地所有者，你有权雇佣其他人为你工作。我建议你一开始支持这个城市的一个行会。每个行会都有自己的行业和福利，所以你可以选择你喜欢的。如果你能完成他们的任务，他们的报酬很高。你也可以在那里雇佣更多的人，或者你可以在奴隶市场碰碰运气。",
	STARTINGDIALOGUE3_2 = "— 哦，你不知道吗？12年前，革命发生，君主政体被推翻后，所有的土地都变成了可买卖的公共财产。由于贵族不再拥有土地所有权，很多土地都卖给了富人。现在，公会拥有最大的财富和政治权力，因为他们与土地所有者关系密切。",
	STARTINGDIALOGUE3_3 = "— 行会是为商业伙伴、买家、请求等提供联系的机构。有战士、法师、工人和仆人，每个人都擅长不同的方面。一旦你去见他们，你可以学到更多。",
	STARTINGDIALOGUE3REPLY1 = "我怎么能赚这么多钱？",
	STARTINGDIALOGUE3REPLY2 = "拥有土地有什么特别的吗？",
	STARTINGDIALOGUE3REPLY3 = "什么是行会?",
	STARTINGDIALOGUE3REPLY4 = "我没问题了",
	STARTINGDIALOGUE4_1 = "— 我两周后回来。",
	STARTUPGRADEBONUS = """You go for a short trip through the mansion and one of the previously unnoticed rooms on the first floor catches your sight. Inside of it you find...""", # MISSING TRANSLATION
	STARTUPGRADEBONUS1 = """Forge""", # MISSING TRANSLATION
	STARTUPGRADEBONUS2 = """Tailor Worksop""", # MISSING TRANSLATION
	STARTUPGRADEBONUS3 = """Alchemy Room""", # MISSING TRANSLATION
	FIGHTERSINTRODUCTION1 = "一个身披重甲的大个子男人给你一个严厉的眼神。\n\n-你是谁？如果你在找工作，你必须先注册为战斗人员。我不接待新兵。 ",
	FIGHTERSINTRODUCTION1REPLY1 = "你错了，我不是新兵",
	FIGHTERSINTRODUCTION1REPLY2 = "我是新的土地所有者，表示尊重",
	FIGHTERSINTRODUCTION2_1 = "— 哦，对不起。土地所有者通常看起来……不太像这样.\n\n",
	FIGHTERSINTRODUCTION2_2 = "— 嗯，是这样吗？……好吧，请原谅我的粗鲁.\n\n",
	FIGHTERSINTRODUCTION2_3 = "— 你是新来的吗？名字叫邓肯。你一定有兴趣和我们一起战斗。这是一个明智的决定。我们的核心是由最强大的黑骑士组成的，没有人比他更适合战斗了。\n\n战斗、警卫、维和、对付怪物或叛军，我们都能做到。 ",
	FIGHTERSINTRODUCTION2_3_1 = "我们自然会提供我们最好的战士。由于您是新的土地所有者，如果您首先站在我们一边，我们会为您提供免费招募。",
	FIGHTERSINTRODUCTION2_4 = "— 你回来了。那么，你做了什么决定？",
	FIGHTERSINTRODUCTION2_5 = "— 你回来了。发生什么事了吗？",
	FIGHTERSINTRODUCTION2_6 = "— 如果没有其他事情，我将不得不回到我的业务中。",
	FIGHTERSQUESTIONREPLY1 = "什么是黑骑士？",
	FIGHTERSQUESTIONREPLY2 = "那些叛军是什么？",
	FIGHTERSQUESTIONREPLY3 = "你能给我一些提示吗？",
	FIGHTERSINTRODUCTION2REPLY1 = "我支持你",
	FIGHTERSINTRODUCTION2REPLY2 = "我稍后再来",
	FIGHTERSQUESTIONS_1 = "— 这是什么?",
	FIGHTERSQUESTIONS_2 = "— 黑骑士团是当时王国的精锐部队……当有一个王国的时候。我们一直光荣地为它服务到最后，但随着王国的改革，我们也改革成了一支更具国家特色的部队。无论如何，我们大多数人这样做了。",
	FIGHTERSQUESTIONS_3 = "— 尽管12年过去了，但疯狂国王的同情者仍有一些叛乱的萌芽。这些傻瓜在任何方面都不可怕，但他们往往会在这里和那里制造问题。如果你问我，他们的努力是愚蠢的。王室已经被处决，所以他们无论如何都不可能回到过去。",
	FIGHTERSQUESTIONS_4 = "— 嗯……如果你不够强壮，一定要带上额外的人。地下城可能是一个巨大的财富来源，但当你毫无准备地接近时，它可能会致命威胁。确保你有一些治疗选择，无论是法师还是物品。当与比两只老鼠还强壮的人打交道时，装备也是必须的。\n\n最重要的是，了解敌人的弱点，并尝试做相应的准备。”。即使是初学者战士也有一些元素攻击，可以造成更多的伤害。",
	FIGHTERSJOIN = "— 太好了。我的助手将向你展示我们最好的新兵。 ",
	FIGHTERSCLOSE1 = "— 明白了。一旦下定决心，你就知道在哪里可以找到我们。 ",
	FIGHTERSCLOSE2 = "— ...小心踩踏。 ",
	FIGHTERSASKQUESTIONS = "我可以问一些问题吗？",
	FIGHTERSASKQUESTIONSRETURN = "仅此而已",
	FIGHTERSINTRODUCTION2REPLY5 = "*向邓肯赠送头骨*",
	FIGHTERSINTRODUCTION2REPLY6 = "关于雷姆...",
	FIGHTERSINTRODUCTION2REPLY7 = "西格蒙德让我...",
	WORKERSINTRODUCTION1REPLY6 = "邓肯承诺尽快付款",
	SERVANTSINTRODUCTION1REPLY5 = "我准备好参加选举了",


	SERVANTSINTRODUCTION1 = "一个看起来轻盈年轻的猫女走近你，好像她知道你的意图。\n\n--欢迎，[Sir] [name]。我的名字叫阿米莉亚。你觉得我们的机构怎么样？请不要感到惊讶，我们很清楚你刚刚成为一名土地所有者，正在寻求我们未来的合作。在仆人协会，我们随时准备为您提供共和国最好、最漂亮的玩具。我们还与这个城市的许多有钱有势的人保持联系。",
	SERVANTSINTRODUCTION1_1 = "作为一名新人，如果你站在我们一边，我们很乐意为你提供一名免费的仆人。",
	SERVANTSQUESTIONREPLY1 = "所以基本上你所做的就是经营精心制作的性服务？",
	SERVANTSQUESTIONREPLY2 = "我到底对你有多有用？",
	SERVANTSQUESTIONREPLY3 = "你能给我一些提示吗？",
	SERVANTSINTRODUCTION1REPLY3 = "我支持你",
	SERVANTSINTRODUCTION1REPLY4 = "我稍后再来",
	SERVANTSQUESTIONS_1 = "— 当然！你想知道什么？",
	SERVANTSQUESTIONS_2 = "— 哈哈哈，你低估了精心制作的性服务的重要性。我们不提供“唯一”的性服务，我们培训勤奋的学员，他们可以做任何你想做的事。清洁、护送、按摩、娱乐。。。但是，满足主人的肉欲是我们受训者的专长。你希望他们祈求、尖叫、呻吟、沉默或支配；我们会找到最适合这项任务的个性和外表，并将它们变成你梦想中的玩具。或者，如果你更倾向于浪漫，我们也准备为你带来一生的挚爱。\n\n恩，对不起，我太忘乎所以了。我们还帮助寻找新的联系，支持许多艺术家和街头艺人，但土地所有者很少关心这些事情。我们仍然欣赏好的艺术和娱乐，即使它不是很有利可图。",
	SERVANTSQUESTIONS_3 = "— 哦，我想没有人向你解释过。你看，只有土地所有者才能成为城市政府的一部分，而你最能利用人和利润。每个行会都有不同的团体追随他们，每个新人对我们来说都意味着更大的权力。”。另一方面，是公会为候选人投票，所以这是一种互惠互利的关系。\n\n虽然你没有被特定的公会束缚，可以自由地与其他人打交道，但我们也没有义务坚持你。只要认为这是善意的象征。",
	SERVANTSQUESTIONS_4 = "— 你一定对管理下属很感兴趣，对吧？首先，你会用你的技能来表扬和惩罚他们。根据下属的不同，他们会对某个或某个事情更有反应。如果没有它的控制，他们可以逃跑。带他们去私人约会是建立他们忠诚度的好方法。高忠诚度，可以让他们更慢地失去服从。\n\n--控制你的仆人和喂养他们一样重要。如果你有问题，有适合你的课程和项目。你可以教其他仆人帮助你遵守纪律。有些能力非常强大，可以影响多个目标。",
	SERVANTSINTRODUCTION1_2 = "— 欢迎回来，[Sir] [name]。你下定决心了吗？",
	SERVANTSINTRODUCTION1_3 = "— 欢迎回来，[Sir] [name]。我能为您效劳吗？",
	SERVANTSINTRODUCTION1_4 = "— 如果您还需要什么，请告诉我。",
	SERVANTSJOIN = "— 这让我很高兴。你不会后悔的。让我帮你找到一个符合你口味的人。",
	SERVANTSCLOSE1 = "— 当然。我们将等待您的回复。",
	SERVANTSCLOSE2 = "— 小心， ",
	SERVANTSASKQUESTIONS = "我可以问一些问题吗？",
	SERVANTSASKQUESTIONSRETURN = "就这些",

	WORKERSINTRODUCTION1 = "你遇到了一个身材矮小、肌肉发达的矮人，他的穿着和举止都像工头。\n\n-是的，朋友，还没见过你。我叫西格蒙德。你在找工作吗？",
	WORKERSINTRODUCTION1_1 = "如果您仍在思考与谁站在一起，我们将为您提供最适合您需求的员工。",
	WORKERSINTRODUCTIONREPLY1 = "我是这里的新土地所有者",
	WORKERSINTRODUCTIONREPLY2 = "谁会让一个矮人成为行会首领？",
	WORKERSINTRODUCTION2_1 = "— 哇，这真是出乎意料。很荣幸见到你。",
	WORKERSINTRODUCTION2_2 = "— 现在，注意你的舌头, [boy]。你可能已经错过了几年了，从革命后法律平等接受所有有知觉的人开始。那是我来这里谋生的时候。你是土地所有者，不是吗？",
	WORKERSINTRODUCTION2_3 = "— 我敢打赌你是来了解我们的。我真的没什么好说的，我们是国家的支柱。我们建造、耕种、手工和锻造。你能想象如果没有人会照顾它吗？我也一样。我们接受客户和其他公会的手工订单。你不知道战士行会每个月需要我们重新生产多少东西。",
	WORKERSINTRODUCTION2_4 = "— 哦，又是你。现在要加入我们吗？",
	WORKERSINTRODUCTION2_5 = "— 哦，又是你了。进展如何？",
	WORKERSINTRODUCTION2_6 = "— 就这样？我应该回去工作了。",
	WORKERSQUESTIONREPLY1 = "矮人王国发生了什么？",
	WORKERSQUESTIONREPLY3 = "你能给我一些建议吗？",
	WORKERSINTRODUCTION1REPLY3 = "我支持你",
	WORKERSINTRODUCTION1REPLY4 = "我晚点回来",
	WORKERSQUESTIONS_1 = "— 是的，是什么？",
	WORKERSQUESTIONS_2 = "— 不知道，不在乎。如果我在乎，我一开始就不会来这里。不过，不要把我当成一个被排斥的人。我只是对无休止的淘金热不满意。我宁愿不说多。对生意不好。",
	WORKERSQUESTIONS_4 = "— 提示，是吗？不管你做什么，食物都应该是你的首要任务。每个朋友都有自己的需求，没有食物会很快让他们变得敌对和饥饿。谢天谢地，你可以自己生产，也可以自己买。烹饪可以用来让原材料更有营养。\n\n如果你打算自己制作东西，你就需要为之工作。裁缝可以制作布料和盔甲，铁匠可以锻造武器和金属盔甲。一个熟练的人生产东西的速度要快得多，所以最好是训练他们。一旦你在当地市场上出售你的东西，手工制作和收集资源都可以转化为利润。",

	WORKERSJOIN = "— 太好了！好吧，让我们为你找一个健康的好帮手。 ",
	WORKERSCLOSE1 = "— 好吧，我会在这里，以防你改变主意。",
	WORKERSCLOSE2 = "— 再见。 ",
	WORKERSASKQUESTIONS = "我可以问一些问题吗？",
	WORKERSASKQUESTIONSRETURN = "仅此而已",

	MAGESINTRODUCTION1 = "你发现了一个黑暗精灵，她似乎情绪紧张。\n\n--嘿，你带了酒？ ",
	MAGESINTRODUCTION1REPLY = "没...",
	MAGESINTRODUCTION2 = "— 上帝，你为什么这么没用……不管怎样。你想要什么？",
	MAGESINTRODUCTION2REPLY = "我是新的土地所有者",
	MAGESINTRODUCTION3_1 = "— 嗯？我以为你是另一个入会候选人。好吧，这很有趣，我不知道他们现在允许几乎任何人成为土地所有者。不要把这当成个人问题，我承认不是每个人都生来富有。顺便说一句，名字叫梅尔。",
	MAGESINTRODUCTION3_2 = "— 哦，又是你了。你想要什么？",
	MAGESINTRODUCTION3_3 = "— 好吧。",
	MAGESINTRODUCTION3REPLY2 = "我支持你",
	MAGESINTRODUCTION3REPLY3 = "我晚点回来",
	MAGESINTRODUCTION2REPLY2 = "我想请求您支持市长选举",
	MAGESINTRODUCTION2REPLY3 = "我有你要的书",
	MAGESQUESTIONS_1 = "— 继续。",
	MAGESQUESTIONS_2 = "— 恕我直言，你似乎没有任何真正的财富或权力。无论你是否加入我们，恐怕我们都不会改变。所以，我有点不热心。\n\n但我想我们可以腾出一名新兵，以防你真的想留下来。",
	MAGESQUESTIONS_3 = "— 想象一下。你看，要成为一名巫师，你需要两件事：魔法亲和力和足够的耐心来学习。两者都有点罕见，尤其是在同一个人身上。不过，我们并不害怕。无论如何，没有魔法你走不了多远。在紧急情况下，我们别无选择。",
	MAGESQUESTIONS_4 = "— 有两个学派。或者三个学派，如果你考虑到和平主义狂热者的话。第一个学派是专注于战斗魔法。治疗魔法是药剂的廉价快速替代品，而破坏性魔法可以在安全距离内蒸发你的敌人。第二个学派更喜欢阴谋。魔法可以让你影响、阅读和支配他人的思想，这在许多社会场合都很有用 ",
	MAGESQUESTIONS_5 = "— 和平主义者？他们只是疯子，坚持认为魔法只应该用于治疗。在革命之前，当魔法受到国王宫廷更严格的监管时，他们曾经有过一些地位。和平主义者在自愿封印魔法后，更容易四处走动。现在，这似乎更像是一种奇怪的宗教实践。 ",
	MAGESQUESTIONREPLY1 = "你似乎对新的土地所有者不太感兴趣",
	MAGESQUESTIONREPLY2 = "法师的公会似乎有点孤立",
	MAGESQUESTIONREPLY3 = "法师有什么用？",
	MAGESQUESTIONREPLY4 = "第三个呢?",
	MAGESJOIN = "— 奇怪。我没想到你会这样。不过，我没有抱怨。*叹气*让我们给你找个可怜的灵魂来获取。 ",

	MAGESCLOSE1 = "— 当然，无论如何，我们哪儿也不去。",
	MAGESCLOSE2 = "— 呃，再见？",
	MAGESASKQUESTIONS = "我可以问一些问题吗？",
	MAGESASKQUESTIONSRETURN = "仅此而已。",
	
	MAGESSICKFAIRY = "关于仙精...",
	MAGESASKHELP = "寻求帮助",



	DIALOGUEINTRODUCTIONLETTER = '一大早，一位信使来到你的豪宅，递给你一封正式盖章的信。经过快速检查，你会发现它是由仆人行会发送的。\n\n"亲爱的 [name], 你最近的活动引起了我们的兴趣，我们想邀请你参加一次私人会议。”\n\n尽管信息很短，但这封信本身看起来很花哨，而且使用了高质量的纸张和墨水 ',

	ELECTIONSTART1 = "— [Sir] [name],你来了真是太好了！所以你一定很好奇我们为什么邀请你。听起来不可疑，但我们知道你的货币状况以及与银行的关系。\n\n-这是我永远不愿意遇到的情况。”。说实话，几乎可以保证你无法及时偿还。但是，这并不是我召见你的目的。你知道市长的职位吗？",
	ELECTIONSTARTREPLY1_1 = "不清楚",
	ELECTIONSTARTREPLY1_2 = "这与成为土地所有者有关？",
	ELECTIONSTART2 = "— 市长每隔几年由行会多数选举一次，但问题是只有土地所有者才能成为市长。此外，市长的财产即使在贷款的情况下也不能被没收，所以只要你能当选，这就可以让你摆脱困境。",
	ELECTIONSTARTREPLY2_1 = "你想让我竞选市长?",
	ELECTIONSTARTREPLY2_2 = "这看起来不错，但不可能那么容易",
	ELECTIONSTART3 = "— 是的，正如我所说，你需要大多数公会的支持，这意味着至少有3个。在权力面前，我们并不擅长相互合作，所以每个公会通常都有自己支持的候选人。好消息是，作为一个新的土地所有者，每个人都对你的表现感到好奇。所以，只要你给人留下好印象，就有可能请求我们的支持。 ",
	ELECTIONSTARTREPLY3_1 = "为什么和我说这些?",
	ELECTIONSTARTREPLY3_2 = "我想你只说了一半?",
	ELECTIONSTARTREPLY3_3 = "那么我该怎么办",
	ELECTIONPERSUADE1 = "— 我们有自己的理由。\n\n阿米莉亚狡猾地笑了笑，表示她试图不详细说明这个问题。",
	ELECTIONPERSUADESUCCESS = "— 哦，我保证，你没什么好担心的。比方说，我们可以从银行失去一些财产中受益。我想你可以说我们有共同的利益。 ",
	ELECTIONPERSUADEFAILURE = "— 对不起，我们还不确定是否能与您共享此类信息。别担心，无论如何您都不会损失任何东西。",
	ELECTIONSTART4 = "— 你必须在至少三个行会中建立声誉，但这应该在两周内完成，因为在那之后，选举期开始，你必须注册为候选人。不过，不要让这吓到你，我相信你会成功的。\n\n-在为他们完成足够的任务后，你必须向他们的领导人请求选举支持。 ",
	ELECTIONSTART4_1 = "\n\n— 既然你一直支持我们，我很乐意现在就批准你。 ",
	ELECTIONSTART4_2 = "\n\n— 在您获得足够的支持后，请访问我，我们将确定您的公众形象。 ",
	ELECTIONSTARTREPLY4_1 = "这看起来有点可疑，但我想尝试一下没有坏处",
	ELECTIONSTARTREPLY4_2 = "谢谢你，阿米莉亚，我会回来的",
	ELECTIONSTART5_1 = "— 肯定没有。我们希望你能成功。",
	ELECTIONSTART5_2 = "— 很高兴。我们希望你能成功。",

	FIGHTERSREQUESTELECTIONSUPPORT = "我希望在市长选举中得到你的支持",
	WORKERSREQUESTELECTIONSUPPORT = "我希望在市长选举中得到你的支持",
	SERVANTSREQUESTELECTIONSUPPORT = "我希望在市长选举中得到你的支持",
	MAGESREQUESTELECTIONSUPPORT = "我希望在市长选举中得到你的支持",

	SERVANTSELECTIONCONFIRM = "— 哦，你已经完成了我们的请求？干得好！有了这个，我就能说服其他人这是个好主意。一旦你得到其他两个公会的支持，请回复我。",

	FIGHTERSELECTIONSTART1 = "— 嗯……你作为一个新手确实做了很多。所以，你想成为下一任市长吗？令人钦佩，但我们不会轻易提供支持。 ",
	FIGHTERSELECTIONSTARTREPLY1_1 = "为什么不?",
	FIGHTERSELECTIONSTARTREPLY1_2 = "我做的还不够吗?",
	FIGHTERSELECTIONSTART2 = "— 行会最重要的成员是光荣的战士。我们不会同意投票给一个普通人。换句话说，你必须证明自己是有价值的。就这一点而言，我们使用了黑骑士杀害法师的古老传统。然而，在这个年代，你不会发现那些容易被杀害的人，因为他们不再因为练习魔法而受到迫害。",
	FIGHTERSELECTIONSTARTREPLY2_1 = "这对法师来说听起来不太好",
	FIGHTERSELECTIONSTARTREPLY2_2 = "但是你想要什么?",
	FIGHTERSELECTIONSTART2_1 = "— 在过去，只有少数国王认可的法师及其下属被允许练习任何严肃的魔法。我们经常追捕那些非法练习的人，所以这有点像体育运动，因为他们的技能被证明是一个很好的挑战。",
	FIGHTERSELECTIONSTART3 = "— 没有更好的选择了，我们决定拿下一只巫妖。谢天谢地，这些巫妖不受法律保护，所以你必须给我们一个巫妖的头骨，作为你力量的证明。",
	FIGHTERSELECTIONSTARTREPLY3_1 = "巫妖是什么",
	FIGHTERSELECTIONSTARTREPLY3_2 = "怎么找?",
	FIGHTERSELECTIONSTART4_1 = "— 巫妖是一个法师，他成功地变成了不死生物。与普通法师相比，许多巫妖都很愚蠢。我猜转化会对他们的大脑产生影响。然而，他们的力量足以独立存在，他们通常会利用其他不死生物作为他们的仆从。 ",
	FIGHTERSELECTIONSTART4_2 = "— 实际上，这里不乏狡猾的混蛋。我们最近收到一份报告，称有一个离城市不远的混蛋。我会在你的地图上标出位置。一旦你有了头骨，我们就会回来支持你。",
	FIGHTERSELECTIONSTART5 = "— 嗯，你做到了？必须说我很惊讶。好吧，我们会支持你参加下一次选举。我相信这对我们双方都有利。",

#	===Fighter's quests, to proofread later===

	LICHENCINITIATE = "你进入了一个充满死亡恶臭的小藏身处。当你向前走的时候，你听到战斗的声音。在一个相当开阔的房间里，你发现了你正在寻找的巫妖，周围是一小群不死生物。在房间的另一边，你看到一个穿着皮甲的精灵女孩。她在与他们的战斗中失败了。",
	LICHENCINITIATEREPLY1 = "利用女孩作为诱饵，在最佳时机进行攻击",
	LICHENCINITIATEREPLY2 = "*呼唤亡灵*",
	LICH_ENC_SCHOLAR_OPTION = "发射光弹（学者）",
	LICH_ENC_FIGHT_SCHOLAR = "你发射一枚光弹，在巫妖的队伍上闪耀，并短暂地压制他，让你的队伍能够处理一些没有反击的奴仆。现在，是时候干掉被削弱的不死生物了。",
	LICHENCFIGHT = "你慢慢地设置伏击，但当你这样做的时候，精灵女孩被杀死了，再也不能动了。",
	LICHENCTALK1 = "你出现了，准备攻击并引起巫妖的注意，巫妖似乎很激动。精灵女孩被周围的不死生物制服，但仍然活着。",
	LICHENCTALK1REPLY1 = "去死，怪物！*攻击*",
	LICHENCTALK1REPLY2 = "一个友好的不死生物？这是一个新的发现",
	LICHENCTALK1REPLY3 = "哦，现在它在说话",
	LICHENCTALK2 = "— 我的大脑可能已经腐烂了，但我并不愚蠢，看不到事情的发展。说你想干什么，这样我们就可以在不流血的情况下解决问题。",
	LICHENCTALK2REPLY1 = "我改变主意了，我要杀了你！*攻击*",
	LICHENCTALK2REPLY2 = "我需要一个巫妖的头骨，好像你有",
	LICHENCTALK2REPLY3 = "我只想摧毁你的同类",
	LICHENCTALK3 = "— 一个证明测试……我理解。失去我的头骨这件事我来说很不幸，哈哈。你能从……我碰巧在这里的另一个巫妖那里拿走一个头骨吗？然后我很快就会离开这个地方。",
	LICHENCTALK3REPLY1 = "我改变主意了，我要杀了你！*攻击*",
	LICHENCTALK3REPLY2 = "就这样？你不觉得你的生命更有价值吗？",
	LICHENCTALK3REPLY3 = "我接受",
	LICHENCTALK3REPLY4 = "这个女孩怎么了？",
	LICHENCTALK4 = "— 你说得对。我会添加一些不死生物的魔法成分，这些会很有价值，不是吗？",
	LICHENCTALK4REPLY1 = "我改变主意了，我会杀了你！*攻击*",
	LICHENCTALK4REPLY2 = "我接受",
	LICHENCTALK4REPLY3 = "这个女孩怎么了？",
	LICHENCTALK5 = "— 她不是你应该关心的。她必须为她对我造成的伤害付出代价。\n\n女孩听到后，脸色苍白。她还没来得及说出任何连贯的话，她的嘴就被其中一个僵尸堵住了。",
	LICHENCILLKILLYOU = "我改变主意了，我杀了你！*攻击*",
	LICHENCFINE = "我接受",
	LICHENCTALK5REPLY3 = "不，你会释放她的{物理因素}",
	LICHENCTALK6 = "{color=green|成功}\n\n— 诅咒……好吧。你可以拥有她。我不愿意再呆在这里了。\n\n巫妖带着他的军队离开了，留给你的是另一个巫妖头骨和一个被殴打的女孩。",
	LICHENCTALK6_1 = "{color=red|失败}\n\n— 你运气太差了，凡人。这个女人不会是你的。我不会放过她。",
	LICHENCTALK6REPLY1 = "那我就杀了你！*攻击*",
	LICHENCTALK6REPLY2 = "好吧，我放弃",
	LICHENCCONLUSION = "— 好。这是你的头骨。我们很快就要离开了，所以别再来这里了。\n\n你离开了巫妖的藏身处，想知道这个女孩的命运如何。",
	LICHENCWINAIRENOTDEAD = "和女孩交谈",
	LICHENCWINAIRE = "当你打败巫妖并拿走他的头骨时，精灵女孩谨慎地观察你。",
	LICHENCWINELSE = "你拿走了巫妖的头骨，却找不到其他有价值的东西。",
	LICHAIRETALK1 = "你击倒了巫妖，拿走了它的头骨。精灵女孩宽慰而谨慎地观察着你。\n\n-我……谢谢你的帮助。我叫艾尔。我的主人派我来对付扰乱附近农民的亡灵，但进展不顺利。",
	LICHAIRETALK1_DEAL_WITH_LICH = "精灵女孩以宽慰和谨慎的态度观察着你。\n\n-我……谢谢你的帮助。我叫艾尔。我的主人派我来这里处理扰乱附近农民的亡灵，但进展不顺利。",
	LICHAIRETALK1REPLY1 = "什么样的主人会派一个精灵战士到这里？",
	LICHAIRETALK1REPLY2 = "我很高兴你安然无恙，保重",
	LICHAIRETALK1REPLY3 = "你不认为你应该奖励我救你吗？",
	LICHAIRETALK1REPLY4 = "*姦*",
	LICHAIRETALK2 = "— 对不起，但是……我不能这么说。我的主人把我从奴隶贩子手中救了出来，我发誓要为它效忠。",
	LICHAIRETALK2REPLY1 = "你的主人是个傻瓜，把你单独送到这里。",
	LICHAIRETALK2REPLY2 = "你不认为你应该奖励我救你吗？",
	LICHAIRETALK2REPLY3 = "下次你最好不要陷入类似的境地，小心。",
	LICHAIRETALK3 = "— 但我身上没有任何东西！…除非你是说……但这太不雅了。\n\n艾尔脸红了，低头看了看。",
	LICHAIRETALK3REPLY1 = "你的陪伴将抚慰我的心（性因素）",
	LICHAIRETALK3REPLY2 = "没关系，你可以走了",
	LICHAIRETALK4 = """精灵女孩紧张地把一缕橙色的头发缠绕在手指上 

{color=yellow|艾尔: — 我们至少能找到一个比这里更舒适的地方吗。。。尘土飞扬的坟墓}

你们两个都走到外面，艾尔开始寻找一个合适的地方，而你紧随其后，你被她的屁股优美的摆动迷住了。在地穴外搜索了几分钟后，她带你穿过岩石上的一个缺口，在那里你拦住了她。你的耐心越来越少，你对着裸露的石头地面做手势。

{color=yellow|艾尔: — 在这里？哦…我想我们可以…}""",
	LICHAIRETALK4_BAD = "{color=red|Failure}\n\n—对不起，我不能那样做。我没有其他可以提供的。",
	LICHAIRETALK4_BADREPLY1 = "没关系，你很安全，保重",
	LICHAIRETALK4_BADREPLY2 = "*推倒并强奸*",
	LICHAIRETALK4_1 = """你向艾尔招手。当你把她拉入怀抱时，她的嘴唇颤抖着，她结实的乳房紧贴着你的胸部。用一根手指轻轻抬起她的下巴，直到你直视美丽的琥珀色眼睛。 

{color=yellow|艾尔: —我很感激，你知道。你救了我的命，我只是……对不起，我在……这方面不是很有经验}

你抓住艾尔脸上的一缕头发，把它塞到她尖耳朵后面。同时，你的指尖沿着耳朵划出一条线，她的脸因兴奋而潮红。她俯身亲吻，你把舌头夹在她的嘴唇之间，品尝草莓。你的手找到了她的圆屁股，当你抓住它时，它首先紧张，但随后会放松。""",
	LICHAIRETALK4_2 = """你抓住她的衬衫边缘，把它提起，直到艾尔的胸部露出乳白色。你的拇指轻轻地绕着乳晕，乳头立刻变硬。你俯下身子，轻轻地挤压她的乳房，同时舔乳头，把它吸进嘴里。艾尔呻吟着，她的手无力地抓着你的衣服。

你把她的皮带从皮带扣上扯下来。皮短裤从她纤细的大腿上滑落，露出精致的丝绸内裤。你也解开自己的皮带，让你的阴茎自由地跳起来。她咬着嘴唇，当你把她的手放在你的阴茎上时，她轻轻地喘着粗气。你把空闲的手伸进她的内裤里，把她的阴部包起来，用中指拨弄阴唇。

{color=yellow|艾尔: — 哦！哦，那……感觉……很好。}""",
	LICHAIRETALK4_3 = """当她继续抚摸你的阴茎时，你把丝绸内裤从她纤细的腿上拉下来。艾尔凝视着你，眼睛里充满了渴望。

{color=yellow|艾尔: — 我们这是要-},

你的回答是把艾尔向后推，直到她躺在斗篷上。脸红了，她张开腿向你展示她湿漉漉的阴部。在俯身之前，你需要花点时间欣赏这一景象。当你的阴茎戳到她肿胀的阴部，然后往里面推时，她欣喜若狂地叫喊。当你的阴茎扩展她紧绷的阴部时，她的背部急剧拱起。 

你在石头地上狠狠地操她，抓住她的大腿，把她轻盈的身体撞在岩石上。艾儿很快就高潮，她的阴部在你的阴茎周围痉挛，她成熟的乳头在你激烈前后时跳动。当漂亮的精灵女孩摇晃着她的臀部哄你的阴茎更深入时，你会感觉到你自己的高潮即将到来。突然她睁开眼睛看着你。

{color=yellow|艾尔: — 等等！请不要在里面！}""",
	LICHAIRETALK4_4 = """当你的阴茎紧急驶入艾尔的阴部时，艾尔的眼睛睁得很大。你抓住她张开的膝盖，把她的腿叠得很高，然后操她，直到你再也无法阻止高潮。你把阴茎拔出来，在她的乳头和腹部喷出滚烫的精液。她高兴地松了一口气。

{color=yellow|艾尔: — 喔，谢谢!}

她转过身来，又把你的公鸡叼到嘴边，急切地舔着。

{color=yellow|艾尔: — 你救了我，我欠你，不管你是谁。谢谢你所做的一切，我指的是一切。。。我们会再见面吗，还是这只是。。。我的意思是，无论哪种方式都很有趣。。。对吧？}

你站着扣上裤子。艾尔把斗篷披在她赤裸的身体上，寻找她散落的衣服。不一会儿，她穿好衣服，溜进了荒野，脸上带着腼腆的微笑。你也该出发了。""",
	
	LICHAIRETALK5 = "— 你不应该这样说我的主人！即使你救了我，我也不会允许。而且，这是我的错，没有侦察就冲进来了。",
	LICHAIRETALK5REPLY1 = "你不认为你应该奖励我救你吗？",
	LICHAIRETALK5REPLY2 = "下次你最好不要陷入类似的境地，小心。",
	LICHAIRETALK5REPLY3 = "你知道，我觉得玷污别人的财产（姦）很令人满意",
	LICHAIRETALK6_1 = """看到你脸上露出残忍的笑容，艾尔试图逃跑，但与巫妖的搏斗耗尽了她的力量。你抓住她的手腕，将她轻盈的身体拉近。 

{color=yellow|艾尔: — 不-不要啊! 你怎么敢! }

用一只手固定她的手腕，另一只手探索她精致的精灵身材，粗略地摸索和捏她的大腿和屁股，然后剥去盔甲，撕开她的衬衫。艾尔虚弱地挣扎着，但她结实的乳房很快就露了出来，粉红色的乳头开始变硬，在寒冷中颤抖。 

她脸红得很厉害，从脸颊到尖耳朵，再到脖子，宛如花朵绽放。当你解开精灵女孩的皮带，先拉下皮短裤，然后拉下她的丝绸内裤，露出光滑白皙的皮肤时，她的呼吸在你的脸上很热；紧绷的屁股，纤细的大腿之间有一个整洁的阴部。

{color=yellow|艾尔: — 请不要！放我走！你没有权利！我的主人会大发雷霆的! }""",
	LICHAIRETALK6_2 = """艾尔可怜地哭泣，她赤裸的身体紧贴着你，你需要一些时间来熟悉她的曲线。当你的手指找到阴蒂时，她大叫，她的战栗会让她活泼的乳头颤抖。你弯下腰，抓住一个小乳房往嘴里塞，在抚摸她的阴户时吮吸和咬着柔软的乳头。 

你花了一分钟摩擦阴蒂，然后用力将中指向上压入她紧绷的精灵阴部。艾尔把她的大腿紧紧地搂在你的手上，无助地呻吟着。手腕别着，你把她的上半身向后拉，这样你就可以看着她那双泪流满面的琥珀色眼睛，手指在她两腿之间搅动着滚烫的小蜜罐。

{color=yellow|Aire: — 不不不不— 不！那不是你的！你不允许啊啊！ }""",
	LICHAIRETALK6_3 = """你慢慢地把手指从艾尔的阴部拔出来，发现它沾满了汁液，然后把手伸进她张开的嘴里，让哀嚎声安静下来，紧紧地抓住她的下巴。 

放开手腕，你把她拉到你身上，在她的乳头和屁股的奶油色皮肤上狠狠打了十几下，直到它们开始变红。她大叫着，试图挣脱，但你把她向后推到地板上，把你的阴茎从裤子里放了出来。

{color=yellow|艾尔: — 你这个混蛋！我不要这个！我不要你！ }""",
	LICHAIRETALK6_4 = """当你压在艾尔挣扎的身体上时，你露出了笑容，你直立的阴茎紧贴着她大腿内侧柔软的肉。你把膝盖卡在她的两腿之间，把她纤细的大腿撬开，直到它们张开。当你把阴茎和她闪闪发光的阴户物排成一行时，颤抖的手抓着你的胸部。 

艾尔扭动着身体试图逃跑，她完美的乳头隆起了。品尝着这一刻，你将臀部向前推，将你的阴茎深深地撞进她的洞里。你拍开挥舞的手，抓住她的乳头，像把手一样抓着它们，同时激烈前后。""",
	LICHAIRETALK6_5 = """当你把艾儿重重地压在坟墓冰冷的石头地板上时，她的挣扎逐渐减弱。你感觉到你的高潮正在到来，并把自己放低，压在她身上，当她每一次呼吸都喘着粗气时，你的阴茎自由地滑进滑出。她的眼睛闭着，眼泪弄脏了她的脸，但你抓住她后脑勺的一把柔软的橙色头发，用力拉，迫使她发出悲伤的尖叫 

你的嘴唇紧贴着她，舌头粗暴地塞进她的嘴里，而你的臀部在她张开的大腿之间无情地摩擦，把你的阴茎凶猛地推进她痉挛的阴部。她尝起来有点草莓味。当你进行最后一次用力压时，她的抵抗力已经被粉碎，在她苗条的精灵身体深处射出炽热的精液。""",
	LICHAIRETALK6_6 = """在拔出之前，你紧紧抓住她的阴部，从你的阴茎中挤出精液。站着，你扣上裤子，让艾儿一丝不挂，浑身通红，精液泄漏到巫妖墓穴的古老石板上。一层汗光把坟墓的灰尘粘在她苍白的皮肤上，当她闪亮的琥珀色眼睛恐惧和愤怒地盯着你时，她气喘吁吁。

你满足了欲望，看着她疲惫地躺在地上，身无分文，但仍然充满愤怒和受伤的骄傲。""",
	LICHAIRETALK6REPLY1 = "杀了她",
	LICHAIRETALK6REPLY2 = "离开",
	LICHAIRETALK7 = "你割断了她的喉咙，结束了她的生命。这里没有其他事情可做，你决定离开。",
	LICHAIRELEAVE = "你与艾尔分道扬镳，准备带着战利品回去。",


	FIGHTERSELECTION5 = "— 哦，哦……对你这样的人来说还不错。好吧，你已经证明了自己的价值，我们会支持你的。尽量不要滥用它。",
	FIGHTERSELECTIONREPLY1 = "我希望在这里开始一场个人圣战...",
	FIGHTERSELECTIONTHANKS = "谢谢",
	WORKERSELECTIONINITIATE1 = "— 选举，是吗？你们富人总是有想法的。我不介意。但在此之前，我有一件事想问。",
	WORKERSELECTIONINITIATE1REPLY1 = "这最好不要再跑腿了",
	WORKERSELECTIONINITIATE1REPLY2 = "我能提供什么帮助？",
	WORKERSELECTIONINITIATE2_1 = "— 不久前，我们与战士行会达成协议，为他们提供一套新的盔甲。问题是，我们仍然没有收到付款。我会派人去，但目前工人短缺。这是一封记载详细信息的信，交给他们的领导。解决这个问题，我们会支持你的，好吗？",
	WORKERSELECTIONINITIATE2_1REPLY1 = "调查金钱失踪。我能做到。",
	WORKERSELECTIONINITIATE2_1REPLY2 = "一个矮人有兴趣得到他的现金，哈哈。有意思。",
	WORKERSELECTIONINITIATE2_2 = "— 嗯？让我看看。嗯…？",
	WORKERSELECTIONINITIATE2_2REPLY1 = "*保持沉默*",
	WORKERSELECTIONINITIATE2_2REPLY2 = "有什么问题吗?",
	WORKERSELECTIONINITIATE3 = "— 我们不久前已经为该订单付款，但不知怎么没有收到。你能找到我们的快递员雷姆，找出问题所在吗？他通常在小巷酒吧附近闲逛。让我知道发生了什么事。",
	REIMENCOUNTER = "如果运气好的话，你会在一条小巷里找到兰斯。一个年轻、长相迟钝的家伙，在你提到你是如何代表工人协会来的之前，他几乎不关心你. \n\n— 那是。。。嗯，你看，有一个女孩我真的很喜欢。她的名字叫露西。她需要钱，我想帮她。你看，她真的很好，尽管她是妓女。。。她对我很好，现在她需要钱。",
	REIMENCOUNTERREPLY1 = "我为什么要在乎?",
	REIMENCOUNTERREPLY2 = "你想要什么?",
	REIMENCOUNTERREPLY3 = "难道你找不到一个不那么需要帮助的妓女吗？",
	REIMENCOUNTER2 = "— 请帮帮我。你能把现金还给邓肯吗？还有150金币要付。告诉他我做不到。他会理解的，会派人去的。如果他们发现我拿钱是为了个人需要，我会被驱逐的。",
	REIMENCOUNTER2REPLY1 = "她真的那么特别吗?",
	REIMENCOUNTER2REPLY2 = "你不应该为了某个妓女而冒生命危险，她很可能只是在利用你（说服）",
	REIMENCOUNTER2REPLY3 = "我不会从口袋里为你的奇思妙想买单",
	REIMENCOUNTER2REPLY4 = "我会考虑的",
	REIMENCOUNTER3_1 = "— 这个……我想你是对的……*叹气*你可以告诉邓肯这件事会马上解决的。",
	REIMENCOUNTER3_1REPLY1 = "很好。那我就去。",
	REIMENCOUNTER3_2 = "— 不，你不明白！她不仅仅是个妓女。看，你必须帮我...",
	REIMENCOUNTER3_2REPLY1 = "我不会从口袋里为你的奇思妙想买单",
	REIMENCOUNTER3_2REPLY2 = "我会考虑的",
	REIMENCOUNTER4_1 = "— 我理解……只要做你必须做的事。最终我们的爱会打败所有人。",
	REIMENCOUNTER4_2 = "— 谢谢！我……现在可能应该快点了。总有一天我会尽力回报你的。",
	REIMENCOUNTER5 = "— 露西不像其他女孩。她善良、她甚至为我做饭……你能想象吗？",
	REIMENCOUNTER5REPLY1 = "我不会从口袋里为你的奇思妙想买单",
	REIMENCOUNTER5REPLY2 = "我会考虑的",
	WORKERSELECTIONCONTINUE1 = "— 你回来了？找到他了吗?",
	WORKERSELECTIONCONTINUE1REPLY1 = "他似乎…很忙。这是他剩下的150金币。",
	WORKERSELECTIONCONTINUE1REPLY2 = "他把钱浪费在妓女身上了",
	WORKERSELECTIONCONTINUE1REPLY3 = "我还需要一点时间",
	WORKERSELECTIONCONTINUE2_1 = "— 嗯……我明白了。那我再找一个快递员。谢谢你抽出时间。你可以向西格蒙德汇报。",
	WORKERSELECTIONCONTINUE2_2 = "— ...是这样吗？我想你没有理由撒谎。我们会调查的。你可以告诉西格蒙德，付款将于今天送达。",
	WORKERSELECTIONINITIATE5 = "— 是这样吗？好吧。谢谢你的帮助。当你外出时，我确保公会中没有反对意见。我们支持你的选举。",
	WORKERSELECTIONINITIATE5REPLY1 = "时间到了",
	WORKERSELECTIONINITIATE5REPLY2 = "谢谢",

	MAGESELECTION1 = "— 嗯…是这样吗？…我想这是阿米莉亚的主意吧？",
	MAGESELECTION1REPLY1 = "是.",
	MAGESELECTION1REPLY2 = "你怎么知道?",
	MAGESELECTION2_1 = "— 一样多.",
	MAGESELECTION2_2 = "— 我没告诉过你，你必须有头脑才能成为一名法师吗?",
	MAGESELECTION2_ANY = "— 好吧，我想，为什么不呢。不过，我会让你先为我做点什么。我想让你去看望我姐妹扎里，并取回她偷的书。她住在离阿利隆不远的地方.",
	MAGESELECTION2REPLY1 = "那么，我应该打败她吗?",
	MAGESELECTION2REPLY2 = "为什么你姐姐不住在这里?",
	MAGESELECTION3_1 = "— 不……也许。做你想做的事，我想……实际上不，不要伤害她。",
	MAGESELECTION3_2 = "— 我想她讨厌人群，也不喜欢地面城市。不能说我有什么不同，只是更有韧性。法师行会周围的情况并没有那么糟糕。",
	MAGESELECTION3_ANY = "亲戚总是让事情变得复杂。我会给你一封信，里面有她想要的东西。",
	XARIENCOUNTER1 = "你还没来得及看到小屋的内部，它看起来更像一个洞穴，一个年轻、兴奋的黑暗精灵女孩就向你走来了。\n\n--客人！我已经很久没有土匪来找我了。你想在火里烧死还是被巨魔吃掉？",
	XARIENCOUNTER1REPLY1 = "我实际上是从你姐妹那里来的",
	XARIENCOUNTER1REPLY2 = "*展示信件*",
	XARIENCOUNTER2_1 = "— 啊，那就更好了！独自生活很好，但我已经有一段时间没有客人了。除了乌鸦。",
	XARIENCOUNTER2_2 = "— 呃？那是梅尔派你来的？那就更好了！一个人住很好，但我已经有一段时间没有客人了。除了乌鸦。 ",
	XARIENCOUNTER2REPLY1 = "你能和乌鸦说话吗?",
	XARIENCOUNTER2REPLY2 = "我觉得你很无聊",
	XARIENCOUNTER2REPLY3 = "我宁愿做我的事，继续我的路",
	XARIENCOUNTER3_1 = "— 任何人都可以，但他们很少回复。但话说回来，梅尔派你来干什么?",
	XARIENCOUNTER3_2 = "— 是的，只是一点点。我知道在离开城市之前，我应该发现自己是一个有感知力的人。一只猫会做得很好……或者一个人。那么，陌生人，是什么把你带到我这里来的？",
	XARIENCOUNTER3_3 = "— 天哪，你一点都不好玩。好吧，梅尔现在想从我这里得到什么？",
	XARIENCOUNTER3REPLY1 = "她说你是小偷",
	XARIENCOUNTER3REPLY2 = "她想要回她的书",
	XARIENCOUNTER3REPLY3 = "我觉得她很孤独",
	XARIENCOUNTER4_1 = "— 谎言！肮脏的精灵同胞撒谎。那么她想要她的书？她可以拿回去。她怎么敢叫我小偷。我会归还的，好吗？",
	XARIENCOUNTER4_2 = "— 嗯…我想这很有道理。一定是被困在那该死的塔里了，连她姐妹都不去看望她。好吧，我真的不再需要他们了。",
	XARIENCOUNTER4_3 = "— 哈哈，这是一个有趣的笑话。黑暗精灵不会感到孤独。我认为精灵一般不会感到孤独，因为它们的行为很压抑。你可以相信我，我亲身经历过。所以，我想她想要回她的书，所以她派了一个快递员。好吧，我真的不再需要它们了。",
	XARIENCOUNTER4REPLY1 = "那么你会把它们给我吗?",
	XARIENCOUNTER4REPLY2 = "但是?",
	XARIENCOUNTER4REPLY3 = "宁愿在离开这里的路上，你能快点吗?",
	XARIENCOUNTER5_1 = "— 我会的，但我希望你也能为我做点什么。",
	XARIENCOUNTER5_2 = "— 没错。",
	XARIENCOUNTER5_3 = "— 没那么快，朋友。我希望你能帮我做一件事。",
	XARIENCOUNTER5_ANY = "— 我不知道什么时候会有新人来，我一个人在这里很孤独。我知道你们城里有很多不错的精灵男孩，所以给我带一个几个小时，然后你就可以拿到书了。",
	XARIENCOUNTER5REPLY1 = "我记得你说过黑暗精灵不会感到孤独",
	XARIENCOUNTER5REPLY2 = "我在这里，为什么要等一个不知名的男孩？",
	XARIENCOUNTER5REPLY3 = "晚点回来。",
	XARIENCOUNTER6 = "— 你会相信一个黑暗精灵说的话吗？大错特错。嗯，不完全是这样，我想这也是无聊。",
	XARIENCOUNTER6REPLY1 = "我在这里，为什么要等一个不知名的男孩？",
	XARIENCOUNTER6REPLY2 = "我到时候回来。",
	XARIENCOUNTER7 = "— 哦，你愿意和我这样的狂野女巫一起冒险吗？太勇敢了。",
	XARIENCOUNTER7_1 = "— 好吧，我接受你的牺牲。但不要指望任何怜悯！",
	XARIENCOUNTER7_2 = "— 嗯。事实上，我对其他性癖很害羞，但我觉得这是一个新体验的好时机。",
	XARIENCOUNTER7_3 = "— 对不起，我不是很喜欢女孩。是的，在我的情况下，我不应该挑剔，但这太恶心了。给我带一个精灵男孩，然后你就会得到你想要的。 ",
	XARIENCOUNTER7_4 = "— 但对不起，你真的不符合我的口味。给我带来一个精灵男孩，然后你就会得到你想要的。",
	XARIENCOUNTER8_1 = "— 哇，你比你看起来好多了。哈哈，我开玩笑，你看起来比巨魔还好看。太棒了。带上你的书，改天再来吧。",
	XARIENCOUNTER8_2 = "— 你还不错，但需要一些训练……我只是开玩笑。谢谢你抽出时间，拿着你的书，你已经赚到了。",
	XARIENCOUNTER8_3 = "\n\n你带着梅尔要求的那捆书离开了扎里。当你离开小屋时，你感觉有人在密切关注你。",
	XARIENCOUNTER9 = "— 你回来了。有什么要给我的吗?",
	XARIENCOUNTER9REPLY1 = "我把人带来了",
	XARIENCOUNTER9REPLY2 = "还没有，我会回来的",
	XARI_ENCOUNTER_APPRENTICE_OPTION = "我不认为梅尔或法师公会希望我为此浪费时间（学徒）",
	XARI_ENCOUNTER_APPRENTICE = "— 天哪，你一点都不好玩。好吧，我不想让那些家伙在这里，所以带上你的书离开。",
	XARIENCOUNTER10 = "— 嗯，不错，我会接受的。现在，如果你原谅我的话……哦，我想你可以带着你的书走了。别担心，我们结束后我会马上把这个小伙子送回来。 \n\n 当他们消失在锁着的门后时，[name]会忧心忡忡地看着你。\n\n几个小时后[name]回来了，脸上露出疲惫的幸福表情。",
	MAGESELECTION4_1 = "—你…你和她睡过!?",
	MAGESELECTION4_1REPLY1 = "我的笑容太明显了?",
	MAGESELECTION4_1REPLY2 = "...不，嗯，也许。",
	MAGESELECTION4_1REPLY3 = "我希望你没有嫉妒",
	MAGESELECTION4_2 = "— 终于。她怎么样了？别告诉我。她一定很好，因为你什么都没说就抓住了他们……好吧，谢谢你的帮助。你可以告诉阿米莉亚你得到了我们的支持或其他什么。玩得开心。",
	MAGESELECTION5 = "— 哦，上帝……真不敢相信她会……\n\n-啊，不管怎样，我为什么在乎。你把书完好无损。告诉阿米莉亚没关系。我们会支持你的。哦，是的，如果我是你，我会保守这个信息的秘密。 ",
	SERVANTSELECTIONFINISH1 = "— 啊，你得到了支持？太棒了！",
	SERVANTSELECTIONFINISH1_2 = "既然你真的很努力，而且都得到了，我也为你准备了一个奖励。 *阿米莉亚递给你一条闪亮的项链*\n— ",
	SERVANTSELECTIONFINISH1_3 = "现在只剩下为辩论做准备了。但别担心，我有这个城市最好的造型师来帮你。",
	SERVANTSELECTIONFINISH1REPLY1 = "我需要辩论吗？我以为我已经得到了支持",
	SERVANTSELECTIONFINISH1REPLY2 = "我不太明白这一点.",
	SERVANTSELECTIONFINISH2_1 = "— 是的，但比这更复杂。",
	SERVANTSELECTIONFINISH2_2 = "肯定会有其他竞争者，即使他们没有你那么多人脉。更重要的是，你应该向选民表明，你是一位优秀、受人尊敬的行政人员或领导人，反映了他们的利益。最后，每一位市长都必须保持良好的公众形象。即使普通人不会决定你是否通过，他们的不满也不能被其他人忽视。",
	SERVANTSELECTIONFINISH2REPLY1 = "一旦我赢得选举，你不会让我做一些见不得人的事情，吧？",
	SERVANTSELECTIONFINISH2REPLY2 = "所以要足够、合理、受人喜欢。理解",
	SERVANTSELECTIONFINISH2REPLY3 = "我会尽力，但没有承诺",
	SERVANTSELECTIONFINISH3 = "— 别傻了。我可能会要求一两件事，但我们不是一起的吗，[name]？别担心，如果我们会提出你不同意的提议，我们不会建议你成为市长。毕竟，你并不是不能拒绝行会的要求。",
	SERVANTSELECTIONFINISH3REPLY1 = "所以要足够、合理、受人喜欢。理解",
	SERVANTSELECTIONFINISH3REPLY2 = "我会尽力，但没有承诺",
	SERVANTSELECTIONFINISH4_1 = "— 没错！名单比我们对会员的期望要短得多，呵呵。",
	SERVANTSELECTIONFINISH4_2 = "— 太可爱了。别担心，我们支持你。",
	SERVANTSELECTIONFINISH4REPLY1 = "好吧，这听起来很激动人心",
	SERVANTSELECTIONFINISH4REPLY2 = "啊，让我们结束这件事吧",
	SERVANTSELECTIONFINISH5_1 = "— 是的，这是一件大事。我很想看到你的行动！",
	SERVANTSELECTIONFINISH5_2 = "— 尽量不要在辩论中表现出这种态度。别担心，我相信你会做得很好。",
	SERVANTSELECTIONFINISH6 = "辩论日开始了，一大群人聚集在主广场上。当另一位候选人入场时，你和阿米莉亚在后面看着，等着轮到你。\n\n--哼，愚蠢的业余爱好者。至少观众很开心。嘿，别为它担心，你看起来很棒。",
	SERVANTSELECTIONFINISH6REPLY1 = "你似乎玩得很开心",
	SERVANTSELECTIONFINISH6REPLY2 = "我很紧张，我该怎么办？",
	SERVANTSELECTIONFINISH6REPLY3 = "我现在可以喝一杯了",
	SERVANTSELECTIONFINISH7_1 = "— 有什么不值得享受的？很多人对城市的未来充满希望。有很多盈利和发展的机会。这对我来说是一个巨大的考验。",
	SERVANTSELECTIONFINISH7_2 = "— 别担心。我们有一位演讲者，他会让你看起来像是过去一周城市没有崩溃的唯一原因。只要微笑，看起来自信。",
	SERVANTSELECTIONFINISH7_3 = "— 哈哈，等它结束，我会陪你的。",
	SERVANTSELECTIONFINISH7_ANY = "— 似乎该结束了。你十分钟后就要上任了……\n\n在阿米莉亚回答之前，讲台上爆发出震耳欲聋的爆炸声，一群人出现在那里。由一个穿着闪亮盔甲和奢华衣服的年轻金发女孩带领。",
	SERVANTSELECTIONFINISH8 = "在任何人做出反应之前，广场被一个魔法屏障覆盖，挡住了任何潜在的撤退或援助途径。然而，没有一个入侵者表现出任何明显的敌意。 \n\n 那个女孩说话了. \n\n— 我是人类领地阿利隆的人民。我是阿纳斯塔西娅，阿尔伯国王的女儿。我父亲12年前被无情地杀害。我发誓要为他复仇，打败他的敌人，让我们的王国回到从前的统治。那些为我们的事业而战的人将得到奖励。请保持坚强，帮助我们打败作恶者。来找我们，我们将一起阻止这个邪恶的政权。" ,
	SERVANTSELECTIONFINISH9 = "在她离开后不久，一道明亮的闪光覆盖了广场，以隐藏阿纳斯塔西娅用来逃跑的魔法入口。魔法屏障倒塌了，人们对刚刚发生的事情目瞪口呆。",
	STARTFINALE = "感谢您游玩阿尔法版本的《奋斗：征服》。如果没有赞助人的支持，这个项目是不可能的。\n\n您可以无限期地继续游玩",

	LOAN_EVENT = "早上，银行贷款人拜访了这座豪宅。 ",
	LOAN_SUCCESS1 = "他们拿走了 {custom_text_function=GetLoanSum#0|} 金币并迅速离开。您的下一笔付款预计在 {custom_text_function=GetLoanDay#1|}天，需要 {custom_text_function=GetLoanSum#1|} 金币.",
	LOAN_SUCCESS2 = "他们拿走了 {custom_text_function=GetLoanSum#1|} 金币并迅速离开。您的下一笔付款预计在 {custom_text_function=GetLoanDay#2|}天，需要 {custom_text_function=GetLoanSum#2|} 金币…除非对此采取其他措施。",
	LOAN_SUCCESS3 = "他们拿走了 {custom_text_function=GetLoanSum#2|} 金币并迅速离开。您的下一笔付款预计在 {custom_text_function=GetLoanDay#3|}天，需要 {custom_text_function=GetLoanSum#3|} 金币…除非对此采取其他措施。",
	LOAN_SUCCESS4 = "他们拿走了 {custom_text_function=GetLoanSum#3|} 金币并迅速离开。这是您的最后一笔付款，现在您可以随心所欲了…",
	LOAN_FAILURE = "然而，您并没有现金可用。您没有完成要求，银行拿走了您的财产，让您流落街头。 ",

	SEXTRAITHELP = "性特征可以在性互动过程中提供特殊效果。通过执行与之相关的特定动作，特征有机会在性互动中解锁。解锁后，特征可以打开和关闭。可以同时激活的最大特征数量由 {color=yellow|性因素}决定。它还增加了解锁特征的机会。",
	SEXTRAITDISLIKES = "厌恶特征是角色对某些动作的自然偏好。它们不能被关闭，但可以通过一些努力和运气来消除。",

	# Aliron Church
	GINNYVISIT = "早上你的豪宅有客人。当你打开门时，你看到一个穿着修女服的年轻女孩。\n\n— 早上好, [Sir]。 我是金妮。我听说你刚搬到这里，我希望赛琳娜教堂的工作能引起你的兴趣。",
	GINNYVISITREPLY1 = "好吧，但要快一点",
	GINNYVISITREPLY2 = "不进来讲?",
	GINNYVISITREPLY3 = "对你卖的东西不感兴趣",

	GINNYVISIT2_1 = "— 啊，我不会耽误你的时间，我只是想说，我们对任何新访客都开放。赛琳娜希望帮助任何需要帮助的人，我希望建立一个稳定、善良的社区。如果你决定了解更多，并在某个时候来拜访我，我会很高兴。现在，我不会再耽误你了。再见！",
	GINNYVISIT2_2 = "— 很抱歉，但我不能呆太久。此外，我被告知不要相信土地所有者，因为他们经常绑架和奴役陌生人……我的意思是，我不认为你会这么做，但仍然如此。无论如何，如果你想了解更多，请随时来看我们，我总是很高兴有新的访客。再见！",
	GINNYVISIT2_3 = "— 很抱歉打扰你！我只是想告诉你，既然你是新人，如果你有兴趣，你可以参观我们的教堂……对不起，再见。 ",

	ALIRONCHURCHFIRSTCOME = "你进入了当地的一个小教堂。这座建筑看起来不是很宽敞，但相当干净舒适。当你的入口被发现时，金妮冲过来迎接你。\n\n— 欢迎你, [Sir]。我很高兴你毕竟是在赛琳娜的帮助下来的。你是在寻求指导，还是想成为会员？",
	ALIRONCHURCHFIRSTCOMEREPLY1 = "我只是四处闲逛",
	ALIRONCHURCHFIRSTCOMEREPLY2 = "我想了解更多关于你的宗教",
	ALIRONCHURCHFIRSTCOMEREPLY3 = "我想我下次再来",

	ALIRONCHURCHINTRODUCTION1 = "— 哦，这太棒了！认识新来这座城市的人总是一件很愉快的事。有些人抱怨这里太拥挤了，但我们还能容纳更多的成员。这是一座赛琳娜教堂。我知道，它看起来不大，但我们是这座城市最大的宗教机构。由于阿利隆不是很虔诚，我们没有得到太多的捐款来买一个更好的地方。",
	ALIRONCHURCHINTRODUCTION2 = "— 太棒了！这是一座赛琳娜教堂。我知道，它看起来不太大，但我们是这个城市最大的宗教机构。诚然，阿利隆不是很虔诚，但仍然如此。我们崇拜女神赛琳娜，并帮助其他需要帮助的人。 ",

	ALIRONCHURCHINTRODUCTIONREPLY1 = "你能告诉我更多关于赛琳娜的信息吗？",
	ALIRONCHURCHINTRODUCTIONREPLY2 = "有什么我可以帮忙的吗？",
	ALIRONCHURCHINTRODUCTIONREPLY3 = "离开",

	ALIRONCHURCHLEAVE = "— 请再来!",

	ALIRONCHURCHCELENA = "— 太好了。赛琳娜是与我们人类联系在一起的女神。她是同情心的化身，总是照顾那些有麻烦的人。她也是生命和收获的女神，所以如果你遇到她的神龛，你可以给它一些食物。 ",
	ALIRONCHURCHCELENAREPLY1 = "神是真的吗？你有证据吗？",
	ALIRONCHURCHCELENAREPLY2 = "还有其他神吗?",
	ALIRONCHURCHCELENAREPLY3 = "给我讲一讲神龛吧",
	ALIRONCHURCHCELENAREPLY4 = "我已经学够了",

	ALIRONCHURCHCELENAANSWER_1 = "当然，你可能会怀疑他们的存在，但一段时间后这一点就很明显了。你可以向赛琳娜寻求帮助或祝福，你通常能够以某种形式得到它。是的，这可能不像他们的状态所表明的那样史诗般，但这是一个不可否认的证据，证明他们仍然在观察我们。",
	ALIRONCHURCHCELENAANSWER_2 = "— 自然！大多数其他种族都不认识赛琳娜，他们有自己的神来回应他们的祈祷。我知道森林精灵崇拜弗雷娅和他们的树，但他们怎么能与赛琳娜无所不在的爱相比呢？ ",
	ALIRONCHURCHCELENAANSWER_3 = "— 你可能在这些土地上找到的大多数神殿都是赛琳娜的。通过献祭，你可能会得到祝福或其他礼物。但他们说，不同的神有不同的偏好。我不确定，我一生都只忠于赛琳娜。",

	ALIRONCHURCHENTER1 = "当你进入教堂时，金妮像往常一样迎接你。\n\n— 欢迎, [name]! 我能为你做什么?",
	ALIRONCHURCHENTER2 = "— 还有什么我可以帮你的吗, [Sir] [name]?",

	ALIRONCHURCHENTERREPLY1 = "告诉我更多关于你工作的信息",
	ALIRONCHURCHENTERREPLY2 = "我带来了你要的食物",

	ALIRONCHURCHQUESTSTART = "— 我们基本上做得很好，但我们也必须养活穷人和无家可归的人。如果你能给我们提供 {color=aqua|25 肉汤} 就太好了，因为我们并不总是有足够的肉汤。你可以用原材料烹饪。我相信赛琳娜会很高兴的。 ",
	ALIRONCHURCHQUESTSTARTREPLY1 = "我想不会有奖励吧?",
	ALIRONCHURCHQUESTSTARTREPLY2 = "我很乐意帮忙",
	ALIRONCHURCHQUESTSTARTREPLY3 = "没有承诺，我会看看我能做什么",

	ALIRONCHURCHQUESTSTART1_1 = "— 美德不是自己的奖励吗？我会尝试制作一些东西，但你可以看到我们没有多少。",
	ALIRONCHURCHQUESTSTART1_2 = "— 太棒了，我会为你的安全向赛琳娜祈祷。",
	ALIRONCHURCHQUESTSTART1_3 = "— 谢谢，我们将不胜感激。如果您还需要什么，请告诉我。",

	ALIRONCHURCHQUESTCOMPLETE1 = "— 这太棒了！为了答谢你的帮助，我想向你赠送一本关于教授治疗魔法的神圣文本。我相信这对你会有一些用处。哦，拿一些这些治疗碎片。即使在可怕的情况下，你也可以把它们分解来治愈你的创伤。\n\n-哦，我们也可以为穷人使用更多的食物。如果你每周给我们带一次，我们会为你提供更多的碎片。",
	ALIRONCHURCHQUESTCOMPLETE2 = "— 太棒了！我知道不多，但我可以给你一些生命碎片。这些是赛琳娜送给我们的礼物，所以你可以在冒险中使用它们。",

	# Tutorials
	INTRODUCTIONTUTORIAL1 = "This is the main Mansion screen. At the center you can see the list of all your possessed characters.\n这是豪宅的主屏幕。在中央你可以看到所有拥有的角色的列表。",
	INTRODUCTIONTUTORIAL2 = "Main actions can be found at the bottom left corner.\n主要操作可在左下角找到。",
	INTRODUCTIONTUTORIAL3 = "At the top of the screen you can find a navigation panel, which will list available locations to visit and interact with. Click on the Aliron to go to town.\n在屏幕顶部，您可以找到一个导航面板，其中将列出可访问和互动的可用位置。单击阿利隆前往城镇。",

	QUESTTUTORIAL1 = "Repeatable quests can be obtained from the city's Notice Board. Use them to earn money and guild reputation. Different guilds offer different quests. Reputation can be used to unlock exclusive classes and purchase guild exclusive items.\n可重复的任务可以从城市的公告牌上获得。使用它们来赚取金钱和公会声誉。不同的公会提供不同的任务。声誉可以用于解锁专属职业和购买公会专属物品。",
	QUESTTUTORIAL2 = "Once you've completed a quest, or procured the required items, you can submit it and receive your reward from the Journal tab.\n一旦您完成了任务或获得了所需物品，您就可以提交任务并从日记选项卡中获得奖励。",
	QUESTTUTORIAL3 = "Select \"Complete\" when on the selected quest to finish it.\n在所选任务上选择\"完成\" 以完成它。",

	SKILLSTUTORIAL1 = "At the bottom of the screen you can see abilities available to the currently selected character. Abilities are acquired from Classes and can be used on characters in the same location as caster. Social abilities are important for keeping obedience high, which is necessary to prevent them from escapes. However, many of them will have a subtype. {color=green|Generous} subtype is more effective on targets with high Tame Factor, while {color=red|Mean} is more effective on targets with high Timid Factor.\n在屏幕底部，你可以看到当前所选角色可用的能力。这些能力是从职业中获得的，可以用于与施法者相同位置的角色。社交能力对于保持高度服从很重要，这是防止他们逃跑所必需的。然而，其中许多都有一个子类型。{color=green|亲切}亚型对具有高驯服因子的目标更有效，而{color=red|刻薄}对具有高胆怯因子的目标更加有效。",
	SKILLSTUTORIAL2 = "Loyalty can be used to make their respect for you stronger and reduce their Obedience Drain while also unlock new abilities.\n忠诚可以用来增强他们对你的尊重，减少他们的顺从损耗，同时解锁新的能力。",
	SKILLSTUTORIAL3 = "After selecting an ability you'll have to select a target for it. Remember that only targets from the same location are viable.\n选择一种能力后，你必须为其选择一个目标。记住，只有来自同一位置的目标才是可行的。",
	SKILLSTUTORIAL4 = "At the right side you can switch to combat abilities set up. While you can't use them outside of combat, you can still check their descriptions and prepare yourself before it.\n在右侧，你可以切换到战斗能力设置。虽然你不能在战斗之外使用它们，但你仍然可以检查它们的描述，并在此之前做好准备。",

	EXPLORATIONTUTORIAL1 = "While browsing non-city locations you'll have access to the list of presented characters and a combat party setup. Drag and drop characters onto the party setup to assign them to it.\n在浏览非城市位置时，您可以访问呈现的角色列表和战斗小队设置。将角色拖放到战斗方设置上即可将其分配给它",
	EXPLORATIONTUTORIAL2 = "Do note, that melee attacks can't be performed by back row while front row is present, and back row also can't be targeted by melee attacks at the same time. On the right of the combat team you can find available items. They can be used by dragging and dropping on active characters.\n请注意，当前排在场时，后排不能进行近战攻击，后排也不能同时成为近战攻击的目标。在战斗队的右侧，你可以找到可用的物品。它们可以通过拖放至活跃角色来使用。",
	EXPLORATIONTUTORIAL3 = "You can also use spells to heal while in preparation, but keep an eye at mana levels or catalyst requirements.\n你也可以在准备时使用法术进行治疗，但要注意法力水平或使用需求。",



	CRAFTTUTORIAL1 = "While in the Craft Menu, select the crafting category from the top of the screen.\n在工艺菜单中，从屏幕顶部选择工艺类别。",
	CRAFTTUTORIAL2 = "You need specific materials to craft an item displayed next to it. Modular items are crafted differently from standard items. Instead of specific materials they take material types for each different part of the item.\n您需要特定的材料来制作旁边显示的物品。模块化物品的制作方式与标准物品不同。它们为物品的每个不同部分采用不同的材料类型，而不是特定的材料。",
	CRAFTTUTORIAL3 = "To select a material for the part of the modular item click on the empty slot.\n要为模块化项目的零件选择材料，请单击空槽。",
	CRAFTTUTORIAL4 = "At the top you can see how many of a material is needed. Different materials will provide different effects to the end item.\n在顶部，你可以看到需要多少种材料。不同的材料会为最终产品提供不同的效果。",
	CRAFTTUTORIAL5 = "Once finished you can select how many times the item should be crafted and confirm the order.\n完成后，您可以选择该项目的制作次数并确认订单。",
	CRAFTTUTORIAL6 = "Each item has its own required production time. To process any craft, you need to assign a character to it. You can do so from their occupation menu, or right from the Craft screen. Only characters at the mansion can craft.\n每件物品都有自己所需的生产时间。要处理任何工艺，你需要为其分配一个角色。你可以从他们的职业菜单或工艺屏幕上执行此操作。只有豪宅中的角色才能进行工艺。",
	CRAFTTUTORIAL7 = "If you decide to assign crafters from the Craft screen, select characters to be assigned, then click confirm.You can also select them from the occupation menu.\n如果您决定从工艺屏幕分配工艺人员，请选择要分配的角色，然后单击确认。您也可以从职业菜单中选择。",
	CRAFTTUTORIAL8 = "Once you are done, at the left side of the screen you'll see new progress for the items being worked on.\n完成后，在屏幕左侧，您将看到正在处理的项目的新进展。",

	NOSLAVESINMARKET = "No Slaves Avaliable.",
	RESETLOADCHARPROFESSION = "Class doesn't match current guild.\nStarting class will be reseted.",
	TEMPLATETYPENOTMATCH = "Can't use this template. Types doesn't match.",

	REMOVETATTOO = "你确定要删除这个纹身吗?",
	ADDTATTOO = "添加纹身?",
	CHOOSETATTOO = "先选择一个纹身",
	SAMETATTOO = "您已经在这个槽中有了相同的纹身.",
	REPLACETATTOO = "替换这个纹身?",

	NOTCOMPATIBLE = "此保存文件与当前版本的游戏不兼容\n但是，您可以更新文件。\n警告！所有角色都将返回到豪宅。可能会丢失一些进度。\n是否继续？（原始保存文件将保持不变，但与当前版本不兼容）",
	CREATECHARQUESTION = "确认创建此角色？",
	CREATECHARACTERFEMALE = "警告：您选择了一个女性角色。大多数游戏脚本事件都是从男性角度进行的，但无论如何都会显示。确认吗？",
	RETURNTOMAINMENUQUESTION = "返回主菜单?",
	FORGETLOCATIONQUESTION = "忘记这个位置？所有出现的角色都会被送回大厦。这个动作无法撤消。",

	SENDCHARBACKQUESTION = "让 [name] 返回?",
	SENDCHARBACKTOMANSIONQUESTION = "让 [name] 返回豪宅?",

	RETURNALLCHARSTOMANSIONQUESTION = "让所有角色返回大厦？",
	CANCELTASKQUESTION = "是否取消此任务？",
	FORFEITQUESTQUESTION = "放弃这个任务？",

	REMOVEUPGRADEFROMQUEUEQUESTION = "从队列中删除此升级？",

	STARTTHISGAME = "开始游戏?",
	UPDATEFILE = "是否更新此文件？",

	# after finishing election-princess-meeting sequence

	QUESTLOG_AFTERELECTIONOPTION1 = "访问梅尔了解如何提供帮助",
	QUESTLOG_AFTERELECTIONOPTION2 = "访问弗雷德在阿利隆的宿舍了解他的行踪",
	QUESTLOG_AFTERELECTIONOPTION3 = "在阿利隆之外找到弗雷德的会面地点",
	QUESTLOG_AFTERELECTIONOPTION4 = "带着消息返回梅尔",
	QUESTLOG_AFTERELECTIONOPTION5 = "访问邓肯",
	QUESTLOG_AFTERELECTIONOPTION6 = "拜访西格蒙德，帮助他完成最近叛军的接管",

	# Aliron elections finish

	ALIRONELECTIONSFINISH_LINE1 = """几个小时后，四大行会召开了紧急会议。首领和地主们就当前形势展开了激烈的讨论。

{color=aqua|邓肯: — 这太荒谬了。现在每个农民都知道阿尔伯国王的继承人还活着。今天，一个大型反叛组织是如何在未被发现的情况下进入城市的？你的公会的职责是专门防止这种事情发生，梅尔。你如何解释这种破坏行为？}

{color=yellow|梅尔: — 你怎么敢指责我们背叛？我记得处置王室是你的职责，但我们这里有一位公主，她还活着，都长大了，正在召集叛军反对我们。}""",

	ALIRONELECTIONSFINISH_LINE2 = """{color=aqua|西格蒙德: — 你确定她真的是公主吗？可能是个骗子。这是矮人争端的常见策略。}

{color=yellow|阿米莉亚: — 我们几乎可以肯定她是真正的公主。她的外表与当年最小的王室孩子相似，她的气场不可否认是皇室血统。我们不知道谁在支持她。如果帝国参与其中...}""",

	ALIRONELECTIONSFINISH_LINE3 = """{color=aqua|邓肯: — 我们的侦察兵报告说，过去几个月叛军的活动有所增加。同情者和叛军正在推进。我被迫宣布进入紧急状态。}

一群土地所有者爆发出一片喧闹。

{color=yellow|西格蒙德: — 冷静点，伙计们，他是对的。我们不能失去任何关键点或贸易路线。}""",

	ALIRONELECTIONSFINISH_LINE4 = """{color=yellow|梅尔: — 嗯，那么你现在就要宣布自己为领袖了？在一个在世的继承人出现后，考虑到你的信誉，你预计其他行会会支持你多久？}

{color=aqua|邓肯: — 我不指望你顺从，我也不需要你的帮助来对付他们。一旦我们确定了叛徒，就不会手下留情。你最好做好准备。}

{color=yellow|梅尔: — 我们？！为什么？开什么玩笑，法师公会怎么会从这个叛军的特技中受益？}

{color=aqua|邓肯: — 不管怎样，我们都会找到罪魁祸首，所有同谋都会被彻底处理。无论是你、仆人，还是我们的一个人。}""",

	ALIRONELECTIONSFINISH_LINE5 = """会议结束后，您联系阿米莉亚讨论接下来会发生什么。

— 哦，这太可怕了。现在，战士们将以铁腕统治，直到暴乱平息。对你来说，坏消息是选举自然被搁置了。好消息是你的债务也是如此。看来公仆们已经坐上了替补席。尤其是我。""",

	ALIRONELECTIONSFINISH_QUESTION1 = "你什么都不能做?",
	ALIRONELECTIONSFINISH_QUESTION2 = "在我看来，各行会似乎在互相争斗。",

	ALIRONELECTIONSFINISH_ANSWER1 = """— 仆人在战争中没有任何作用。我们不训练士兵，不拥有魔法，甚至不生产补给。

因此，在阿利隆戒严期间，我们几乎没有任何影响力。
我想我们所能做的就是一直呆到一切结束，希望之后会有一些事情留给我们。

— 你知道，邓肯需要几个星期才能知道到底发生了什么，在那之前，这里的气氛会很紧张。
很明显，你可以直接投入到与叛军的战斗中，但我觉得我们最好先揭露肇事者并消除行会内部的怀疑。你觉得怎么样？""",


	ALIRONELECTIONSFINISH_ANSWER2 = """— 当然，这是我们一直在做的。尽管这次我们自己的一个人背叛了我们，但风险更大。

法师负责任何大规模的传送，所以如果没有渗透和破坏，这是不可能的。

— 你知道，邓肯需要几个星期才能知道到底发生了什么，在那之前，这里的气氛会很紧张。
很明显，你可以直接投入到与叛军的战斗中，但我觉得我们最好先揭露肇事者并消除行会内部的怀疑。你觉得怎么样？""",

	ALIRONELECTIONSFINISH_QUESTION3 = "实际上，我正要亲自为邓肯提供帮助。",
	ALIRONELECTIONSFINISH_QUESTION4 = "这听起来像是犯罪者为了他们的利益而利用我的话。",
	ALIRONELECTIONSFINISH_QUESTION5 = "我不确定，如果我挡道了怎么办？",

	ALIRONELECTIONSFINISH_ANSWER3 = """— 你很热情，不是吗？这一切都好了，但不要过早行动。

	— 不管怎样，拿着这份调查令。这证明你的调查是公会批准的，你可以四处询问。
我建议从法师公会开始。他们大概还没有头绪，但他们应该能够确定我们的公主是怎么进来的""",

	ALIRONELECTIONSFINISH_ANSWER4 = """— 哈，这就是要点。不要相信任何人。这就是我选择你的原因。好吧，既然你已经意识到了这一点，如果是这样的话，我们就骗不了你了，对吧？

— 不管怎样，拿着这份调查令。这证明你的调查是公会批准的，你可以四处询问。
我建议从法师公会开始。他们大概还没有头绪，但他们应该能够确定我们的公主是怎么进来的""",

	ALIRONELECTIONSFINISH_ANSWER5 = """— 吧。想要当市长的人应该表现出更多的信心。别担心，如果发生什么事，我会帮你的。

--不管怎样，拿着这份调查令。这证明你的调查是公会批准的，你可以四处询问。
我建议从法师公会开始。如果他们还没有弄清楚，他们应该能够确定我们的公主是怎么进来的""",

	#==============Mages guild line================= (triggers when meeting mage leader)

	MAGESAFTERELLECTION1 = """你走进梅尔的办公室，发现她很痛苦，这与她通常的平静状态大不相同。

— 我想我已经明确表示我不会被打扰。。。哦，是你。你想要什么？""",

	MAGESAFTERELLECTION1_QUESTION1 = "只想说 \"嗨\".",
	MAGESAFTERELLECTION1_QUESTION2 = "我正在调查这里发生的事情。",

	MAGESAFTERELLECTION1_ANSWER1 = """— 是的，对，就像你做的一样。邓肯派你来了吗？或者，更有可能，这是阿米莉亚的主意，对吧？

--他妈的。他们不能干掉一个小淘气，直到为时已晚才意识到，现在都是我们的错。就像我关心的那样。你想知道到底发生了什么吗？""",

	MAGESAFTERELLECTION1_ANSWER2 = """— 该死的。他们不能干掉一个孩子，直到为时已晚才意识到，现在都是我们的错。就像我在乎的一样。所以你想知道到底发生了什么吗？""",

	MAGESAFTERELLECTION1_QUESTION3 = "我等着你说呢",
	MAGESAFTERELLECTION1_QUESTION4 = "我想你也不知道",
	MAGESAFTERELLECTION1_QUESTION5 = "...",

	MAGESAFTERELLECTION1_ANSWER3 = """— 通过一个水晶球来保护城市免受未经授权的传送，该水晶球旨在抑制魔法越过投影阈值。该设备可以有非常多不同的功能，但重要的是，为此，它需要一个电源。该电源在…事件发生前被盗。

— 切入正题，只有少数公会成员被允许进入，其中一人恰好在事件发生当天失踪。
他叫弗雷德。你可以找到他，确认他是否自愿禁用了设备。如果他真的站在叛军或帝国一边，最好你立即把他打倒。

— 我会给你他的家庭地址，你可能会在那里找到一些关于他的下落的线索。""",

	MAGESAFTERELLECTION1_QUESTION6 = "被盗的电源是什么?",
	MAGESAFTERELLECTION1_QUESTION7 = "你怀疑他死了?",
	MAGESAFTERELLECTION1_QUESTION8 = "一旦我找到了什么，我会告诉你的.",

	MAGESAFTERELLECTION1_ANSWER4 = """— 这是一件文物，是前国王尼古拉的一把剑。从技术上讲，它属于王室，但自革命以来，行会决定利用它来造福所有人。""",
	MAGESAFTERELLECTION1_ANSWER5 = """— 如果我是他，我宁愿死。否则，邓肯乐意开出的死亡处方将是缓慢的。他不会对背叛掉以轻心。""",
	MAGESAFTERELLECTION1_ANSWER6 = """— 找到他，或者找到他剩下的东西。如果他还活着，我不希望他很高兴见到你，所以如果需要的话，可以随时把他打倒……甚至不需要。""",

	# Visit Fred's home

	VISITFREDSHOMEINTRO = """你进入的宿舍位于城市的一个贫困地区。

弗雷德的房间很小，很不干净，薄薄的墙壁让你听到邻居的声音。经过一段时间的搜索，你会发现一张隐藏的纸条，暗示弗雷德计划在城郊与一个名叫格雷格的人秘密会面。

在与其他居民四处打听后，你认为这是最有可能找到他的地方。""",

	VISITFREDSHOME_IF_BRIBE = """你回到弗雷德的房间。经过几分钟的搜索，你发现了隐藏的藏匿处，证明弗雷德没有对你撒谎。这个数字让你想知道，如果弗雷德的邻居知道这件事，弗雷德会多快被盗。”。

拿到钱后，你离开宿舍。

{color=green|得到 500 金币}""",

	FINDFRED1 = """你可以很容易地从弗雷德房间里的信中找到集合点。它的标志是一棵大橡树，就在泥泞的农场道路旁。这里没有弗雷德，但在松软的土地上留下了许多可能是人类的脚印，有迹象表明有人被拖到了不远处的一片树林里。

这些人没有努力隐藏他们的踪迹，你很快就在树上一块岩石裸露的侧面发现一个洞穴的洞口。

当你深入洞穴探索时，你会尽最大努力抑制脚步声，穿过刻在石头上的牢房的铁栅栏门。你偷偷看了一眼里面，注意到弗雷德和三个类似土匪的武装人员绑在一起，站在他身边。""",

	FINDFRED2 = """{color=aqua|胖强盗: — 看到了吗？他哪儿也不去。我很无聊，而且这里太冷了。我们走吧。}

{color=yellow|小强盗: — 是的，我已经连续三天没有清嗓子了。老大，来吧。}

{color=aqua|首领: — 我们哪儿也不去，你们这些白痴。这是一个赚外快和人情的机会。}""",

	FINDFRED_OPTION1 = "说话",
	FINDFRED_OPTION2 = "攻击",

	FINDFRED_TALK1 = "你决定平静地接近并与他们交谈.\n\n{color=yellow|胖强盗: — 啊？你是谁？}",
	FINDFRED_TALK1_QUESTION1 = "我收到消息，不再需要你的服务。",
	FINDFRED_TALK1_QUESTION2 = "我对你的囚犯感兴趣，也许我们可以解决一些问题。",
	FINDFRED_TALK1_QUESTION3 = "对不起，我好像迷路了，我还是走吧。",
	FINDFRED_TALK1_QUESTION4 = "这是浪费时间…*攻击*",
	FINDFRED_ROGUE_OPTION = "你们这些混蛋都被出卖了，城市民兵已经在这里了 (流氓)",
	FINDFRED_ROGUE = """{color=aqua|胖强盗: — 啊？怎么回事？}

{color=yellow|小强盗: — 我就知道这些混蛋不可信！}

{color=aqua|首领: — 该死……我们现在撤退，忘掉这家伙。}

三人在没有意识到你的虚张声势的情况下迅速逃跑，把你留在了他们的囚犯身边。""",
	FINDFRED_TALK1_ANSWER1 = """三人组的老大给你一个怀疑的眼神。

{color=aqua|首领: — 啊，真的吗？你想在这里愚弄谁？}""",

	FINDFRED_TALK1_ANSWER1_1 = """{color=aqua|首领— 啊，真的吗？你想在这里愚弄谁？}""",

	FINDFRED_TALK1_QUESTION5 = "把我当成骗子是愚蠢的举动。",
	FINDFRED_TALK1_QUESTION6 = "嘿，我是认真的。我们不要妄下结论。",
	FINDFRED_TALK1_QUESTION7 = "你没有怀疑过你的服务对象？",
	FINDFRED_TALK1_QUESTION8 = "值得一试。我想我们会努力做到的。",

	FINDFRED_TALK1_ELSE = """{color=yellow|小强盗: — 终于！我等不及要离开这个粪坑了。}

{color=aqua|首领: — 很好，不管怎样，我们都已经完成了，但为了确保你不是骗子，我们的雇主叫什么名字？}""",

	FINDFRED_TALK1_CONTRACTOR_DUNCAN = "邓肯",
	FINDFRED_TALK1_CONTRACTOR_GREG = "格雷格",
	FINDFRED_TALK1_CONTRACTOR_FRED = "弗雷德",
	FINDFRED_TALK1_CONTRACTOR_AVERMIK = "艾维尔明克",

	FINDFRED_TALK1_IF_GREG1 = "{color=aqua|首领: — 嗯，好吧。让我们离开这个洞吧，伙计们。你……你确保并报告我们没有忽视我们的任务。如果我们再次被雇佣，我会很高兴的。'薪水很高。再见。}",
	FINDFRED_TALK1_IF_GREG2 = "当匪徒离开时，你走到仍然被绑在粗糙的石头地板上的弗雷德身边，移开他的口塞，让他说话。\n\n-你-你是谁？你是行会的人吗？你介意解开我吗？",

	FINDFRED_ATTACK = """这个谈判没有任何意义，你准备攻击土匪。

{color=aqua|胖强盗: — 啊，拜托？你很弱唉！}

{color=yellow|小强盗: — 呀哈, 胖子给他们点颜色瞧瞧 }""",

	FINDFRED_AFTERWIN = """{color=yellow|小强盗: — 去他妈的！他们太强了！}

{color=aqua|首领: — 我不敢承认，但我们现在必须撤退。我们下次会打赢你的！}""",

	FINDFRED_START = """在奇怪的三人组逃命后，你移动到弗雷德仍然被绑在粗糙的石头地板上，移开他的口塞，让他说话。

{color=yellow|弗雷德: — 你-你是谁？你是公会的吗？你介意解开我吗？}""",

	FINDFRED_AFTERWIN_QUESTION1 = "在你解释自己的行为之前不会.",
	FINDFRED_AFTERWIN_QUESTION2 = "你偷的文物在哪里?",

	FINDFRED_TALK1_ANSWER2 = """— *叹气*我别无选择，是吗？如果我把剑带给他们，他们会给我一大笔钱，但后来他们又出卖了我，把我关了起来！
我不知道他们想要它干什么。这不过是个没人关心的老古董。该死的格雷格和那个婊子...""",

	FINDFRED_AFTERWIN_QUESTION3 = "你为什么与叛军合作?",
	FINDFRED_AFTERWIN_QUESTION4 = "你能告诉我关于它们的什么?",
	FINDFRED_AFTERWIN_QUESTION5 = "我会把你带回公会，让你因协助叛乱而受到审判。",
	FINDFRED_AFTERWIN_QUESTION6 = "我听够了，叛徒该死。",

	FINDFRED_TALK1_ANSWER3 = """— 他们拿走了。这只是一件没人在乎的旧物，他们给了我一大笔钱让我把它带给他们。然后他们出卖了我，让那些人把我拖到这里。该死的格雷格和那个妖婊子...""",
	FINDFRED_TALK1_ANSWER4 = """— 叛军？看，我不知道他们是谁。你见过我的地方，那是个垃圾场！好吧，所以我搞砸了，但谁不考虑这个机会呢?""",
	FINDFRED_TALK1_ANSWER5 = """— 我不知道，格雷格是一个见不得人的阴险小人？他让我拿到剑，我拿到了。我把它交出来后，他把它交给了某个恶魔女孩。然后他们把我绑起来，留给了这些家伙。我真的不知道其他什么。""",

	FINDFRED_TALK1_ANSWER6 = """— 不，求你了，我会以叛国罪被处决的！你必须相信我，我不知道。听着，我不能回去了，但如果你让我走，你可以得到我得到的前一半报酬。五百金币只是一部分，怎么样？""",

	FINDFRED_AFTERWIN_QUESTION7 = "这与金币无关，你必须为你的背叛负责。",
	FINDFRED_AFTERWIN_QUESTION8 = "我想我可以说你逃跑了，但那样你会怎么做？",

	FINDFRED_TALK1_ANSWER7 = """— 不，求你了！你一定要相信我，我不知道。听着，我回不去了，你可以得到我得到的前一半报酬。五百金币只是一部分，怎么样？""",

	FINDFRED_AFTERWIN_QUESTION9 = "你真有趣，居然以为你能收买我*杀*",

	FINDFRED_LINE_END = "尽管弗雷德提出抗议，你还是决定把他带回邓肯身边。",
	FINDFRED_LINE_END_KILL = "弗雷德继续恳求，但你再也不听了。你击倒了他，开始收集你完成任务的证据。过了一会儿，你离开了洞穴，弗雷德的头放在了他之前可能藏剑的袋子里。",

	FINDFRED_TALK1_ANSWER8 = """— 我……我真的不知道。我想我必须离开这个国家。我认为我现在和叛军或行会在一起都不安全。也许我能通过边境。""",

	FINDFRED_AFTERWIN_QUESTION10 = "好吧，我相信你。",
	FINDFRED_AFTERWIN_QUESTION11 = "好吧，这些钱至少可以用来修复你造成的一些损坏。",
	FINDFRED_AFTERWIN_QUESTION12 = "算了，你会为你的背叛负责的。",
	FINDFRED_AFTERWIN_QUESTION13 = "算了，你死在这里吧。",

	FINDFRED_TALK1_ANSWER9 = """— 谢谢！我把钱放回房间了。在窗户附近松动的地板下有一个藏匿处。
你释放弗雷德，让他上路，然后准备离开。""",


		FINDFRED_TALK1_ANSWER10 = """土匪怀疑你。

{color=aqua|小强盗: — 嘿，我们为什么不交易？}

{color=yellow|胖强盗: — 是啊，我不想再呆在这里了。}

{color=aqua|首领: — 好吧，好吧，300金币，你可以拥有他。}""",

	FINDFRED_BRIBE_TAKEN = """你把钱递给他们，他们就准备离开。

{color=aqua|首领: — 很高兴和你交易。哦，呃，万一有人出现，就不用提我们的小交易了。}""",

	FINDFRED_BRIBE_REFUSED = """{color=aqua|首领: — 很遗憾，因为我们不能在这里找到我们后就让你离开。}""",

	FINFRED_BRIBE_OPTION1 = "同意",
	FINFRED_BRIBE_OPTION2 = "拒绝",

	FINDFRED_LINE_END_KILL2 = "你把口塞塞回弗雷德的嘴里，把他带出洞穴，从而阻止了进一步的抗议。",

	FINDFRED_TALK_FAIL = "{color=aqua|首领: — 是的，我不这么认为。在我们把你打得落花流水之后，你必须告诉我们你是谁。}",

	# *Intermission scene— starts 1 hour after deleting location, black screen transition; greg and demoness as sprites

	INTERMISSIONINTRO1 = """一名叛军领导人躲在别人的视线之外，一直在与之前招募的助手会面。

{color=aqua|格雷格: — 你拿到了你那把漂亮的剑。我相信我们现在合作的还不错。}

{color=yellow|恶魔: — 没什么可抱怨的，让你完成大规模传送也符合我们的利益。}""",

	INTERMISSIONINTRO2 = """{color=aqua|格雷格: — 太好了，那就分道扬镳吧。我希望我们不要被人看见在一起，尤其是公主。}

{color=yellow|恶魔: — 现在，不要那么急。邪教提供援助不仅仅是为了神器。我们可以做得更多，你知道的。}

{color=aqua|格雷格: — 我不给你任何其他东西，我们不再需要你的帮助了。}

{color=yellow|恶魔: — 哈哈哈，如你所愿。}""",

	INTERMISSIONINTRO3 = """当格雷格离开现场时，恶魔心想。

{color=yellow|恶魔: — 尽管如此，这里还有更多收获。我想我会呆一段时间。}""",

	RETURNTOMYR_IF_FRED = """— 所以你找到了他。干得好，我已经把他和你的报告一起寄给了邓肯。
这应该会缓解行会之间的紧张关系，直到出现新的情况。在这里，把这看作是我的一个提示，然后去向邓肯报告。""",

	RETURNTOMYR_IF_NOT_FRED = """— 所以你找到了他并照顾了他。很好，我已经给邓肯发了一张纸条。
这应该会缓解行会之间的紧张关系，直到出现新的情况。在这里，把这看作是我的一个提示，然后去向邓肯报告。""",

	FREDQUESTREPORT = "关于弗雷德...",
	FREDFIGHTERSQUESTREPORT = "关于魔法问题...",
	PRINCESS_SEARCH_INITIATE = "您的搜索进展如何?",

	RETURNTOMYR = """— 毕竟是他，我们也丢了这件文物……我也预料到了。来，把这份报告交给邓肯，对不起，我需要做一些……安排。""",

	RETURNTODUNCAN_IF_FRED = """— 很好，你成功找到了罪犯，我们已经把他带到了监狱，他将在那里等待惩罚。""",
	RETURNTODUNCAN_IF_FRED_QUESTION1 = "说出你知道了什么",
	RETURNTODUNCAN_IF_NOT_FRED = "— 所以叛徒死定了。请允许我问，除了杀了他，别无选择吗？",

	RETURNTODUNCAN_IF_NOT_FRED_QUESTION1 = "我不得不为自己辩护。",
	RETURNTODUNCAN_IF_NOT_FRED_QUESTION2 = "这是我的决定。",

	RETURNTODUNCAN1 = "— 只是一份报告，嗯？我想你当时并没有找到真正的罪魁祸首。",
	RETURNTODUNCAN2 = "— 事情就是这样。我本想先问他，但木已成舟。",

	RETURNTODUNCAN_ANSWER1 = """{color=aqua|— 格雷格……我会被诅咒的，他是当时的老骑士之一，但在政变中失踪了。我以为他被杀了，但似乎我错了。不过我不知道这个恶魔女人可能是谁...}""",

	RETURNTODUNCAN_TOWNCAPTURE = """邓肯还没来得及说完，一个信使就闯入了房间，脸上露出了恐慌的表情。

— 长官，叛军已经占领了米尔福德! """,
	RETURNTODUNCAN_ANSWER1_1 = """

— 诅咒...他们已经做好了准备。——邓肯深吸了一口气，继续说，好像什么都没有发生。

— 不管怎样，干得不错，但我们现在有更直接的问题。叛军占领了包括其中一座堡垒在内的其他关键地点，并将其作为对我们的贸易和供应路线发动袭击的行动基地。他们希望我们试图夺回该镇，但尚不清楚他们是否意识到他们占领的其他地点对我们有多重要。工人们可以为您提供有关这一关键破坏的更多信息。我人手不足。当你能应付的时候，去找西格蒙德，看看有什么能做的""",

	RETURNTODUNCAN_QUESTION1 = "我看看我能做些什么.",
	RETURNTODUNCAN_QUESTION2 = "当然，我没有更好的事情可做...",

	RETURNTODUNCAN_ANSWER2 = "— 最好不要拖延，每一刻对我们来说都很重要.",

	RETURNTODUNCAN_EXTRA1 = """— 这显然是法师的错。梅尔应该知道谁应该对此负责。一旦你找到他，我们将毫不犹豫地给予适当的惩罚。""",

	#Intermission scene 2

	INTERMISSION2INTRO1 = """叛军站在一个最近变成战场的小定居点前。

{color=yellow|阿纳斯塔西娅: — 叔叔！你为什么不让我在进攻前和他们谈谈？！}

{color=aqua|格雷格: — 那些是公会训练过的士兵。}

{color=yellow|阿纳斯塔西娅: — 他们要求亲自来看我。我们本可以避免所有的死亡和破坏。}""",

	INTERMISSION2INTRO2 = """尽管格雷格根本不愿意回答，但他必须仔细回答，因为阿纳斯塔西娅在这么多叛军士兵面前提出了抗议...

{color=aqua|格雷格: — 你太天真了，公主。他们中可能有刺客只是为了你的头而被派来的。我们的敌人是背信弃义的机会主义者，这就是他们的工作方式。}

{color=yellow|阿纳斯塔西娅: — ... 不应该是这样。如果人民在被解放的过程中死亡，那么将他们从暴政中解放出来有什么好处？我们必须避免伤害无辜者和这种不必要的损失。}""",

	INTERMISSION2INTRO3 = """{color=yellow|阿纳斯塔西娅: — 我已经决定了。释放幸存者，让他们回家。}

{color=aqua|格雷格: — 啥!?}

{color=yellow|阿纳斯塔西娅: — 这是我们现在能做的最起码的事情，以表明我们的善意和崇高的意图。}

{color=aqua|格雷格: — ...很好，但不要自欺欺人。你不会通过仁慈或仁慈夺回王位。}""",

	INTERMISSION2_IF_AIRE_DEAD = """{color=yellow|阿纳斯塔西娅: — 艾尔有消息吗？她还没回来?}

{color=aqua|侍从: — 恐怕没有殿下，她还没有回来.}

{color=yellow|阿纳斯塔西娅: — 啊…艾尔，我现在真的需要你的陪伴。我希望你安全。}""",

	INTERMISSION2_IF_AIRE_ALIVE = """{color=yellow|阿纳斯塔西娅: — 你认为我要求释放他们是错的吗？}

{color=aqua|艾尔: — 对不起，殿下，我不该评判你.}

{color=yellow|阿纳斯塔西娅: — 艾尔, 别这样.}

{color=aqua|艾尔: — 我只是你的工具，殿下。你的意志对我来说才是最重要的.}

艾尔注意到公主愤怒的凝视，很快补充道.

{color=aqua|艾尔: — 但是，我想，如果我在他们的位置上，我更希望能够回家.}""",

	INTERMISSION2_IF_AIRE_RAPED1 = """{color=yellow|阿纳斯塔西娅: — 我没有机会问，但你上次的任务进展如何？你回来后一直闷闷不乐。有什么不好的事情发生吗？

公主注意到艾尔在回答这个问题时紧张起来。

{color=aqua|艾尔: — ... 对你来说没什么值得一提的.}""",

	INTERMISSION2_IF_AIRE_RAPED2 = """{color=yellow|阿纳斯塔西娅: — 你没有再受伤了，是吗？}

{color=aqua|艾尔: — 我很好，我能继续为你服务.}

{color=yellow|阿纳斯塔西娅: — 嗯……我想知道是不是所有的精灵都是这样的。}""",

	INTERMISSION2_IF_AIRE_NOT_RAPED1 = """{color=yellow|阿纳斯塔西娅: — 我没有机会问，但你的上一次任务进展如何？你回来后一直很活跃，我现在需要一些好消息。}

{color=aqua|艾尔: — 哦，是的。事实上，这次我只是稍微过头了一点。}""",
###
	INTERMISSION2_IF_AIRE_NOT_RAPED2 = """{color=yellow|阿纳斯塔西娅: — 艾尔！你说你会小心的。你说--等等，你为什么那么高兴？}

{color=aqua|艾尔: — 我……我获救了.}

{color=yellow|阿纳斯塔西娅: — 一个救星? 给我讲讲.}

{color=aqua|艾尔: — 我真的不太了解[him]，我相信[his]名字就是[name]。[He]看起来是个……我认为是个好人。}""",
###
	INTERMISSION2_IF_AIRE_NOT_RAPED3 = """{color=yellow|阿纳斯塔西娅: — [name]? 一旦这场混乱结束，我们应该适当地奖励他.}

{color=aqua|艾尔: — 安娜，你真的不需要那样做.}

{color=yellow|阿纳斯塔西娅: — 别傻了，我至少应该感谢他。你毕竟是我的老朋友了。如果你没有回来，我会怎么办?}

{color=aqua|艾尔: — ...}""",

	SIGMUNDOPTION = "— 是吗？这让我松了一口气。我想你是来了解细节的吧？我们的一个矿井已经被叛军占领了.",

	SIGMUND_QUESTION1 = "一个不应该是问题，是吗?",
	SIGMUND_QUESTION2 = "这个有什么特别的地方吗?",

	SIGMUND_ANSWER1 = "— 还没有，但它实际上是用于附魔合金的魔法矿石的一个主要来源。这不是广为人知的信息，但似乎反叛分子知道应该在哪里发动袭击。几周后，我们会耗尽储备，开始使用劣质金属。这看起来可能不多，但当反叛分子占领它时，他们可以利用矿石。",

	SIGMUND_QUESTION3 = "我很乐意帮忙.",
	SIGMUND_QUESTION4 = "只要我能打败更多的叛军，一切都会好起来.",
	SIGMUND_QUESTION5 = "当然，在如此高的风险下，我的努力应该会得到一些回报.",

	SIGMUND_ANSWER2 = """— 是的，这不会是一个问题，但它实际上是用于附魔合金的魔法矿石的一个主要来源。
这不是一个广为人知的信息，但似乎达叛军知道应该在哪里发动袭击。""",

	SIGMUND_ANSWER3 = "— 太好了，我会在地图上标记它.",
	SIGMUND_ANSWER4 = "— 啊，该死，很好，只要你能处理它.",

	SIGMUND_EXTRA1 = """— 你知道，国王去世时我不在身边。是的，非人类不被允许担任任何重要职务。我真的不喜欢整个战争事务，但显然你不会看到我站在那些时代的粉丝一边.""",
	LACKSEXTRAINING = """
{color=red|[name] lacks Prostitution Training to be assigned to this service}""", # MISSING TRANSLATION
	LACKSEXTRAININGSLAVE = """
{color=red|[name] lacks Prostitution Training and will only earn 2/3 of the potential gold from it.}""", # MISSING TRANSLATION


	STATOBDRAINREDUCTION = "服从下降减少",
	STATOBDRAININCREASE = "服从下降增加",
#	STATAUTHORITY_MOD = "权威增长",

	ITEMCHEST_ADV_CLOTH = "法师外套",
	ITEMLEGS_ADV_CLOTH = "法师斗篷",
	ITEMCHEST_ADV_LEATHER = "高级中型装甲",
	ITEMLEGS_ADV_LEATHER = "高级中型腿甲",
	ITEMCHEST_ADV_METAL = "高级重型装甲",
	ITEMLEGS_ADV_METAL = "高级重型腿甲",
	ITEMCHEST_ADV_CLOTHDESCRIPT = "高级法师盔甲除了保护外，还可以增强佩戴者的力量，但需要额外的材料. ",
	ITEMLEGS_ADV_CLOTHDESCRIPT = "除了保护外，高级法师护甲还能增强佩戴者的力量，但需要额外的材料. ",
	ITEMCHEST_ADV_LEATHERDESCRIPT = "一种更复杂的中型装甲，通常由较轻的材料制成，但提供合理的防御. ",
	ITEMLEGS_ADV_LEATHERDESCRIPT = "一种更复杂的中型装甲，通常由较轻的材料制成，但提供合理的防御. ",
	ITEMCHEST_ADV_METALDESCRIPT = "通过使用额外材料来展示更高工艺的重金属盔甲. ",
	ITEMLEGS_ADV_METALDESCRIPT = "通过使用额外材料来展示更高工艺的重金属盔甲. ",

	ITEMSWORDADV = "重剑",
	ITEMSTAFFADV = "大师之杖",
	ITEMSPEARADV = "金精长矛",
	ITEMMACEADV = """Warpick""", # MISSING TRANSLATION
	ITEMBOWADV = "大弓",
	ITEMCROSSBOWADV = """Heavy Crossbow""", # MISSING TRANSLATION
	ITEMBATTLEAXEADV = """Cleaver""", # MISSING TRANSLATION
	ITEMSWORDADVDESCRIPT = "一种包含额外材料的强大武器.",
	ITEMSTAFFADVDESCRIPT = "一种包含额外材料的强大武器.",
	ITEMSPEARADVDESCRIPT = "一种包含额外材料的强大武器.",
	ITEMMACEADVDESCRIPT = """A masterful weapon forged with inclusion of additional materials.""", # MISSING TRANSLATION
	ITEMCROSSBOWADVDESCRIPT = """A masterful weapon forged with inclusion of additional materials.""", # MISSING TRANSLATION
	ITEMBATTLEAXEADVDESCRIPT = """A masterful weapon forged with inclusion of additional materials.""", # MISSING TRANSLATION
	ITEMBOWADVDESCRIPT = "一种包含额外材料的强大武器.",

	ARMORENC = "外壳",
	WEAPONENC = "外壳",

	ITEMLATEX_SUIT = "乳胶套装",
	ITEMLATEX_SUITDESCRIPT = "紧身衣凸显身体曲线.",
	ITEMSERVICE_SUIT = """Bunny Costume""", # MISSING TRANSLATION
	ITEMSERVICE_SUITDESCRIPT = """This costume somehow works wonders on attracting male attention in public places.""", # MISSING TRANSLATION

	MATERIALTROLL_BLOOD = "食人魔血",
	MATERIALTROLL_BLOODDESCRIPT = "一小瓶从击败的食人魔中获得的红色液体.",
	MATERIALINK_BASE = "基本墨水",
	MATERIALINK_BASEDESCRIPT = "一种适合注入魔法的特殊墨水。用作纹身的基础. ",
	MATERIALICE_CRYSTAL = "永恒的冰",
	MATERIALICE_CRYSTALADJ = "冰",
	MATERIALICE_CRYSTALDESCRIPT = "一种稀有的水晶，具有一些魔法特性，可以在工艺中使用。",
	MATERIALFIRE_RUBY = "火焰宝石",
	MATERIALFIRE_RUBYADJ = "火",
	MATERIALFIRE_RUBYDESCRIPT = "一颗罕见的宝石，储存着一些可以在工艺中使用的魔力.",
	MATERIALLIZARD_SKIN = "蜥蜴鳞片",
	MATERIALLIZARD_SKINADJ = "鳞片",
	MATERIALLIZARD_SKINDESCRIPT = "蜥蜴皮肤具有一些魔法特性，可以在工艺中使用.",
	MATERIALINSECT_CHITIN = "几丁质",
	MATERIALINSECT_CHITINADJ = "几丁质",
	MATERIALINSECT_CHITINDESCRIPT = "一种可用于飞行器的昆虫外骨骼.",
	MATERIALOGRE_TEETH = "怪物牙齿",
	MATERIALOGRE_TEETHADJ = "怪物牙齿",
	MATERIALOGRE_TEETHDESCRIPT = "怪物锋利的獠牙通常被认为是一种潜在的炼金术成分，具有医疗功能.",
	MATERIALCRYSTALIZED_ETHER = "以太结晶",
	MATERIALCRYSTALIZED_ETHERADJ = "风",
	MATERIALCRYSTALIZED_ETHERDESCRIPT = "具有风元素的钝圆形宝石。可用于工艺",
	MATERIALEARTH_SHARD = "大地碎片",
	MATERIALEARTH_SHARDADJ = "地",
	MATERIALEARTH_SHARDDESCRIPT = "一颗罕见的宝石，储存着一些可以在工艺中使用的魔力.",
	
	MATERIALMILK = "牛奶", #TODO add descriptions
	MATERIALMILKDESCRIPT = "新鲜榨取的牛奶，好吧其实是人奶。通常在怀孕后从女性身上获得. ",
	MATERIALSEED = "种子",
	MATERIALSEEDDESCRIPT = "男性气概的精华。通常从男性身上获得.",
	MATERIALPHEROMONES = "信息素",
	MATERIALPHEROMONESDESCRIPT = "一小瓶透明液体，常用于化妆品和香水中。通常从兽人那里获得.",
	MATERIALEGGS = "蛋",
	MATERIALEGGSDESCRIPT = "一批未受精的鸡蛋，尺寸比平时稍大。通常从哈比和拉米亚那里获得",
	MATERIALMAGIC_DUST = "魔尘",
	MATERIALMAGIC_DUSTDESCRIPT = "富含魔力的残留物。通常从精灵和仙精那里获得",
	MATERIALREPTILE_BLOOD = "爬行动物血",
	MATERIALREPTILE_BLOODDESCRIPT = "一小瓶来自冷血动物的红色液体。通常从狗头人和龙人那里获得.",
	MATERIALLIGHT_ESSENCE = "耀素",
	MATERIALLIGHT_ESSENCEDESCRIPT = "一种有肥皂味的蓬松物质。通常从天使那里获得.",
	MATERIALDARK_ESSENCE = "黯质",
	MATERIALDARK_ESSENCEDESCRIPT = "通常从魔鬼那里获得.",
	
	
	QUESTREQSCOMPLETE = "附加任务完成",

	ENEMYTYPEBANDITS = "土匪",
	ENEMYTYPEWOLVES = "狼",
	ENEMYTYPEUNDEAD = "未删除",
	ENEMYTYPEGOBLIN = "哥布林",

	UPGRADETATTOO_SET = "Beauty Parlor",
	UPGRADETATTOO_SETDESCRIPT = "An upgrade unlocking new interactions",
	UPGRADETATTOOBONUS = "Unlocks application of tattoos.",

	TATTOOFACE = "面部",
	TATTOONECK = "颈部",
	TATTOOCHEST = "胸部",
	TATTOOARMS = "手臂",
	TATTOOWAIST = "腰部",
	TATTOOASS = "臀部",
	TATTOOCROTCH = "胯部",
	TATTOOLEGS = "腿部",

	STATDAMAGE_MOD_FIRE = "火伤害",
	STATDAMAGE_MOD_WATER = "水伤害",
	STATDAMAGE_MOD_AIR = "风伤害",
	STATDAMAGE_MOD_EARTH = "地伤害",
	STATDAMAGE_MOD_LIGHT = "光伤害",
	STATDAMAGE_MOD_DARK = "暗伤害",
	STATDAMAGE_MOD_MIND = "精神伤害",
	STATDAMAGE_MOD_MELEE = "近战伤害",

	ENEMYMANEATER_PLANT = "食人兽工厂",
	ENEMYCENTIPEDE = "蜈蚣",
	ENEMYOGRE_ALPHA = "食人恶魔阿尔法",
	ENEMYROCK_THROWER = "投掷者",
	ENEMYGIANT_ANT = "巨蚁",
	ENEMYSALAMANDER = "萨拉曼达",
	ENEMYGREAT_VIPER = "大毒蛇",
	ENEMYIFRIT = "伊夫利特",
	ENEMYANTHROPOID = "类人猿",
	ENEMYMAGMA_BEAST = "熔岩兽",
	ENEMYEREBUS_STONE = "埃雷布斯石",
	ENEMYWILD_RAPTOR = "猛禽",
	NO_FIGHT_LOW_OBED = "[name] 拒绝参加战斗。（必须解锁战斗人员）",
	CHAR_NO_COMBAT = "[name] 受重伤，无法参加战斗。",
	SENDCHARTOQUESTCONFIRM = "是否将此角色应用于任务?",

	SKILLPOISON_BITE = "毒咬",
	SKILLENTANGLE_ENEMY = "纠缠",
	SKILLSHRED = "切碎",


	AIRE_AMELIA1 = """
阿米莉亚带着一个整洁的黑色书包走进艾尔的牢房，脸上带着微笑。

{color=aqua|阿米莉亚: — 你好，亲爱的。艾尔，我没说错名字吧？我希望狱警没有对你太苛刻。看来我们的小调查进展不够快，所以我被要求运用我的技能来放松你的舌头。 }

艾尔听了她的话，瞥了一眼袋子，想象着里面一定有各种各样的刀片和钩子，然后困惑地看着穿着暴露服装的猫女。

{color=yellow|艾尔: — 我不会透露任何事情，无论你做什么，我都不会透露给你或其他人。 }

{color=aqua|阿米莉亚: — 太可爱了。我相信你是一个优秀的战士，可以承受身体虐待，那就让我为你而设的节目开始吧。 }""",

	AIRE_AMELIA2 = """
阿米莉亚取回了一小瓶蜂蜜色的液体，她把它倒在手帕上一会儿，然后把它塞了起来。艾尔站起来，尽最大努力挣扎，而不是被毒死，但她的任何训练都没有任何用处。阿米莉亚粗暴地扭动着她的束缚和衣领，然后用一只胳膊搂住她，用手帕捂住她的鼻子和嘴巴。

{color=aqua|阿米莉亚: — 深吸一口气。它不会伤害你。}""",

	AIRE_AMELIA3 = """
艾尔屏住呼吸超过一分钟。当阿米莉亚紧紧地抱着她，像朋友一样随意地和她聊天时，她一直在挣扎，但肺部的灼烧感太大了，她拼命地大口呼吸着掺有药物的东西。阿米莉亚就这样抱着她，直到她的呼吸变得稳定，身体开始放松。

{color=aqua|阿米莉亚: — 现在，我知道你听到了一些关于我和同事的恶意谣言，但我们可以对我们的合作伙伴非常慷慨。例如，我刚刚和你分享的药物通常在这里无论如何都找不到。他们说其中一种成分是真正的阿如安花蜜。}

艾尔的心开始砰砰直跳，她的身体变得敏感得令人难以忍受。阿米莉亚漫不经心地抚摸着她被捆起来的乳房，不时地捏她的乳头，引起小精灵的抽搐和尖叫，逐渐变成了颤抖和呻吟。

{color=aqua|阿米莉亚: — 我听到你的声音变得更激动了。你为什么不告诉我们我们想知道的？要继续这样抵抗……你一定很喜欢你的主人？也许，甚至分享一种更亲密的纽带。}""",

	AIRE_AMELIA4 = """
{color=yellow|艾尔: — 不... 不是... 那样的}

阿米莉亚把她的乳房挤在艾尔身上，靠在她身上，除非她分开双腿，拱起背部站好，否则艾尔就会摔倒。阿米莉亚柔软细毛的尾巴沿着艾尔的腿慢慢向上滑动，感觉就像是钉子和针做成的。

{color=aqua|阿米莉亚: — 啊，又是一个天真的精灵少女！我差点错过亲自训练新人的机会。 }

阿米莉亚的尾巴已经进入艾尔穿着内裤的女阴，左右抽搐，刺激着她现在肿胀的阴蒂。她几乎无法思考。

{color=aqua|阿米莉亚: — 看看你，浑身湿透，浑身发抖。折磨这样一个可爱的女孩让我很痛苦。你一定真的很渴望我结束这一切。}""",

	AIRE_AMELIA5 = """
{color=yellow|艾尔: — 是...}

艾尔的眼睛因羞辱而流泪，因为她再也无法抗拒这种压倒性的快乐了。

{color=aqua|阿米莉亚: — 所以我们都想要同样的东西。你知道怎么做，告诉我阿纳斯塔西娅在哪里。}

阿米莉亚把手从艾尔的胸口伸下来，把内裤拉到一边，轻轻地用手指在光滑的缝隙上下划。在强烈的春药的影响下，艾尔的臀部在没有意识的情况下向手指猛顶。

她把所有的意志都集中到最后一次转身的尝试中，但阿米莉亚把她抱在原地，把两根手指伸进她体内，并用她的阴部作为把手。艾尔融化了，开始剧烈颤抖，但阿米莉亚把手指伸了出来，继续拨弄艾尔的狭缝，让她保持在边缘。

{color=yellow|艾尔: — 啊, 求-求你了... }""",

	AIRE_AMELIA6 = """

{color=aqua|阿米莉亚: — 只要一个字，你就会得到你想要的。 }

{color=yellow|艾尔: — ...女-好.}

艾尔转过头来低声说。当精灵重重地吸气时，阿米莉亚的耳朵抽搐着，她笑了。

{color=aqua|阿米莉亚: — 好女孩。现在，这是您的奖励。}

阿米莉亚把她的长尾蜿蜒回到艾尔的腿上，来回扭动，最后把它放进了她流水的蜜罐里。艾尔呻吟着，纯粹出于肉欲本能，徒劳地蹭向阿米莉亚的臀部，但阿米莉亚缓慢而谨慎地走着。艾尔吸了一口，就在她要发疯的时候，阿米莉亚开始向她猛刺，虽然没有像男人那样用力，但速度要快得多。

在这个可怜的小精灵极度敏感的状态下，突然的刺激是压倒性的。她紧紧抓住，疯狂地摇晃着，停止了呼吸，眼睛向后翻。一次高潮与另一次高潮重叠了几分钟，阿米莉亚用尾巴反复刺激小精灵，直到她昏倒。

阿米莉亚轻轻地把痉挛的女孩放在地板上，清理干净后取回了她的包。

{color=aqua|阿米莉亚: — 看到了吗，一点也不难？希望我们能在更好的情况下再见面。 }

当她向狱警下达命令并去传递好消息时，她自言自语，并在离开的路上稍微摇晃了一下臀部。""",



	# HELP SIGMUND
	HELP_SIGMUND_OPTION_0 = """我被要求帮助你""",

	HELP_SIGMUND_START = """— 是吗？这让我松了一口气。我想你是来了解细节的吧？我们的一个矿井已经被叛军占领了。""",
	HELP_SIGMUND_OPTION_1 = """应该不会有问题吧？""",
	HELP_SIGMUND_OPTION_2 = """这个有什么特别之处吗？""",
	HELP_SIGMUND_1 = """— 不是，但它实际上是用于附魔合金的特殊矿石的主要来源之一。这并不是广为人知的信息，但似乎叛军知道应该在哪里发动袭击。""",
	HELP_SIGMUND_OPTION_3 = """很乐意提供帮助""",
	HELP_SIGMUND_OPTION_4 = """只要我能打败更多的叛军，一切都会好起来""",
	HELP_SIGMUND_OPTION_5 = """希望我能因此得到奖励。""",
	HELP_SIGMUND_2 = """— 这个嘛，它实际上是用于附魔合金的特殊矿石的主要来源之一。这不是广为人知的信息，但似乎叛军知道该在哪里发动袭击。""",
	HELP_SIGMUND_3 = """— 太好了，我会在地图上标记它。""",
	HELP_SIGMUND_4 = """— 啊，该死，好吧，只要你能处理它。""",

	# MINES ARRIVAL
	MINES_ARRIVAL_START = """在离它几百英尺的地方，你发现了一个半废弃的哨所。当你走近它时，你遇到了其中一名男子，他似乎是当地的一名矿工，见到你似乎松了一口气。

— 您好, [Sir]! 你一定是行会派来的。很抱歉，几天前矿井被叛军占领，我们被赶走了，一些拒绝离开的人被当作囚犯带走了。""",
	MINES_ARRIVAL_OPTION_1 = """你能告诉我关于矿井的情况吗?""",
	MINES_ARRIVAL_OPTION_2 = """叛军来干什么?""",
	MINES_ARRIVAL_OPTION_3 = """我来处理，你可以留下来""",
	MINES_ARRIVAL_1 = """— 我在这里工作才几个月。矿井看起来很老很深，但我大部分时间都在浅层工作。""",
	MINES_ARRIVAL_2 = """— 我不知道，他们不必解释自己的行为。我见过一些奇怪的人在把板条箱装到卡车上后离开矿井""",
	MINES_ARRIVAL_OPTION_4 = """它有什么奇怪的?""",
	MINES_ARRIVAL_OPTION_5 = """你见过他们的领导人吗?""",
	MINES_ARRIVAL_OPTION_6 = """够了""",
	MINES_ARRIVAL_3 = """— 那是在晚上，他们看起来像是在试图隐藏起来，没有点燃任何火把或灯。""",
	MINES_ARRIVAL_4 = """— 是一个穿着长袍、头戴大兜帽的人。他只是在命令其他人，感觉他不想以其他方式露面。我想即使是叛军也有点害怕他。""",
	MINES_ARRIVAL_5 = """— 是的，你处理得越快越好。""",
	MINES_ARRIVAL_6 = """— 太好了，我知道我们可以依靠你。如果你不介意的话，我会让其他人知道的。

那个人从相反的方向消失了，你继续向矿井入口走去。""",

	# HALF DUNGEON EXPLORED
	HALF_DUNGEON_EXPLORED_START = """当你穿过竖井时，你突然意识到有人从后面过来。当你埋伏迎接新敌人时，一个孤独的半兽人漫不经心地走过，看起来很不自在。

— 哦，你好。我不是敌人，我的名字叫库尔丹。很高兴认识你这个陌生人。我好像有点迷路了，你介意给我指路吗？""",
	HALF_DUNGEON_EXPLORED_OPTION_1 = """你看起来有点可疑""",
	HALF_DUNGEON_EXPLORED_OPTION_2 = """你在这里干什么""",
	HALF_DUNGEON_EXPLORED_1 = """— 我被邀请参加一个埃雷布斯追随者和感兴趣的人的聚会。看...

他给你看他手腕上挂着一个光泽黯淡而不常见的金属手镯。

— 这既是邀请的证明，也是门票。我想我可以试一试，因为最近在我们的土地上，作为一名魔法从业者很难生存下来，但这个国家似乎也有一些复杂的问题。""",

	HALF_DUNGEON_EXPLORED_OPTION_3 = """你们的土地上发生了什么？""",
	HALF_DUNGEON_EXPLORED_OPTION_4 = """练习魔法真的值得离开你的故乡吗？""",
	HALF_DUNGEON_EXPLORED_OPTION_5 = """我对此一无所知""",
	HALF_DUNGEON_EXPLORED_2 = """— 嗯，我想这个事情还没有传播开来。半兽人当局不再欢迎魔法的练习。这是因为正在进行的对透特的战争。任何练习魔法的人都被视为威胁。真是最不幸的情况啊。""",
	HALF_DUNGEON_EXPLORED_3 = """— 这与魔法无关……至少不完全如此。你看，学习魔法让我对世界的本质有了深刻的了解。有些人的目标是将其用于日常目的或冒险，但通过利用魔法能量，你也更接近于理解存在本身的基本原理。 """,
	HALF_DUNGEON_EXPLORED_4 = """— 我明白了……在这种情况下，我应该继续我的小朝圣。自从我离开了我的祖国，我的处境一直很艰难，除非我能找到避难所。""",
	HALF_DUNGEON_EXPLORED_OPTION_6 = """我代表行会进行调查，我希望你离开这里""",
	HALF_DUNGEON_EXPLORED_OPTION_7 = """我可以雇佣魔法师。你可以加入我，住在我的豪宅里""",
	HALF_DUNGEON_EXPLORED_OPTION_8 = """既然我要清除所有叛军，你可以加入我，直到那时""",
	HALF_DUNGEON_EXPLORED_5 = """— 哦……嗯，我明白了，这太不幸了。也许我会在不同的时间去拜访。再见。""",
	HALF_DUNGEON_EXPLORED_6 = """— 在我看来，这是一个慷慨的提议。你确定吗？我可能无法拒绝。""",
	HALF_DUNGEON_EXPLORED_OPTION_9 = """我确定""",
	HALF_DUNGEON_EXPLORED_OPTION_10 = """我再想想...""",
	HALF_DUNGEON_EXPLORED_7 = """— 很抱歉，我想我有义务参加我来参加的会议。但谢谢你的邀请，我以后会考虑的。""",
	HALF_DUNGEON_EXPLORED_8 = """— 好吧，我愿意接受，而不是在这里把自己置于危险之中。

你向库尔丹解释如何到达阿利隆并找到你的住处，然后他离开""",
	HALF_DUNGEON_EXPLORED_9 = """— 是的，这提议很好。好吧，那么，请允许我陪你走这段旅程。""",

	# PRE_FINAL BOSS
	PRE_FINAL_BOSS_START = """当你到达最后一个房间时，你遇到了一群由一个恶魔女人领导的反叛者。

— 好吧，居然不是一个穿着闪亮盔甲的骑士。我想行会终于来了。可惜我们已经结束了，我不会和你在一起太久了。""",
	PRE_FINAL_BOSS_OPTION_1 = """你到底是谁？""",
	PRE_FINAL_BOSS_OPTION_2 = """我以为叛军首领是男性""",
	PRE_FINAL_BOSS_OPTION_3 = """如果你想活下去，最好现在就投降""",
	PRE_FINAL_BOSS_1 = """— 这其实并不重要，我只是来跑腿的，但此时我似乎会被拖入其中。""",
	PRE_FINAL_BOSS_2_1 = """— 男，女，谁真的在乎，所有这些名字都毫无意义。""",
	PRE_FINAL_BOSS_2_2 = """— 男，女，谁真的在乎，所有这些名字都毫无意义。

恶魔转向库尔丹，他正悄悄地观察着迄今为止发生的事情。

— 你不同意我的观点吗，半兽人？""",
	PRE_FINAL_BOSS_3 = """— 拜托，我浑身发抖。

— 我想你来这里是为了恢复矿山的生产，而你很不幸在这里找到了我。不过，我有一个提议给你。我还不想打架，所以如果你让我把我们作为囚犯关押的矿工带走，我会平静地离开，这样你就可以随心所欲地对付这些叛乱分子。

{color=aqua|叛军: — 嘿，你这个卖国的家伙-..}

— 安静, 傻狗.

恶魔的声音震动了整个空气，她的部下也僵住了。""",
	PRE_FINAL_BOSS_4 = """— 我相信这对你来说是一笔不错的交易。毕竟这些人只是农民，为他们冒着生命危险有什么意义？我相信你的雇主会取代他们的。

无意中听到你谈话的囚犯们在恐惧中仔细观察你的反应。""",
	PRE_FINAL_BOSS_OPTION_4 = """这是一个合理的报价""",
	PRE_FINAL_BOSS_OPTION_5 = """没有交易，你这个恶魔""",
	PRE_FINAL_BOSS_5 = """— 哈哈，这是我心目中的英雄。这是一个明智的选择。我们很快就会离开。

你可以看到恶魔带着吓坏了的矿工离开了。""",
	PRE_FINAL_BOSS_6 = """— 这不是最有原则的结果，但你有权这样做。很抱歉，[name]，但我会离开这里。

库尔丹沿着恶魔的路径离开。""",
	PRE_FINAL_BOSS_7 = """你转向剩下的叛军，但意识到他们不会得到赦免，他们没有投降的迹象。

--去你妈的，你不会活捉我们的！""",
	PRE_FINAL_BOSS_8 = """{color=aqua|恶魔: — 所以试着一直玩到最后，嗯？你怎么看……库尔丹，如果我猜的没错的？你不是来启蒙的吗？}

{color=yellow|库尔丹: — 看来我被误导了。我不得不站在[name]一边。}

{color=aqua|恶魔: — 是这样吗…太不幸了。哦，好吧，我现在还需要一只额外的手下，你确实保留了你的邀请函，对吧？}""",
	PRE_FINAL_BOSS_PALADIN_OPTION = """我永远不会接受这样的犯规提议，我会保护无辜的（圣骑士）""",
	PRE_FINAL_BOSS_KNIGHT_OPTION = """我永远不会接受这样的犯规提议，我会保护无辜的（骑士）""",
	PRE_FINAL_BOSS_PALADIN_KNIGHT = """{color=aqua|恶魔: — ... 我不敢相信你这么老套。很好，我会让你后悔你的把戏。嘿，你-}

{color=yellow|库尔丹: — 我不会帮助你的事业，恶魔。这个人的奉献精神感动了我，我想看到[him]的行动。}

{color=aqua|恶魔: — 哼，不管怎样，我不需要你的同意。}
""",

	PRE_FINAL_BOSS_PALADIN_KNIGHT_WIN_KURDAN = "",

	PRE_FINAL_BOSS_9 = """库尔丹手上的手镯绽放出暗淡的紫色光芒，恶魔喃喃自语。还没来得及反应，库尔丹的姿势和动作就发生了变化。他稳稳地走到恶魔身边准备战斗。

{color=aqua|恶魔: — 你应该会在这场事件中发挥作用。现在，让我们看看你是否值得我们花时间, [name].}""",
	PRE_FINAL_BOSS_10 = """— 所以试着一直玩到最后，嗯？好吧，让我们看看你是否值得考虑。""",
	PRE_FINAL_BOSS_11 = """击败最后一批叛军后，矿井里什么都没有了，你可以向工人行会报告。""",
	PRE_FINAL_BOSS_12 = """— 必须承认，你还不错。好吧，我今天受够了，毕竟这个地方不好玩。让我们再见面吧，英雄。

在你阻止她之前，她快速念了一个咒语，然后消失在一个魔法漩涡中。""",
	PRE_FINAL_BOSS_13 = """当恶魔离开时，库尔丹倒在地上恢复了理智。

— 啊。。。该死。对此我深表歉意。我无法控制自己。看起来我是被愚弄才来到这里的。我该如何赎罪？""",
	PRE_FINAL_BOSS_OPTION_6 = """你可以加入我""",
	PRE_FINAL_BOSS_OPTION_7 = """我会带你去当局""",
	PRE_FINAL_BOSS_OPTION_8 = """你应该离开""",
	PRE_FINAL_BOSS_14 = """— 嗯，就这样吧。如果我能用这种方式报答你，我会的。""",
	PRE_FINAL_BOSS_15 = """— 我理解。所以，我会把自己托付给你的当局。""",
	PRE_FINAL_BOSS_16 = """库尔丹点头表示同意，缓缓离开大厅。""",
	PRE_FINAL_BOSS_17 = """你释放了被监禁的矿工，并得到了他们的感激。

— 谢谢你, [Sir]! 我们不知道该如何报答你。""",
	PRE_FINAL_BOSS_OPTION_9 = """无需报酬，只需返回工作岗位""",
	PRE_FINAL_BOSS_OPTION_10 = """好吧，既然你提出来了，我用得上可以一些报酬。""",
	PRE_FINAL_BOSS_18 = """— 你真的很慷慨。一旦我们准备好重返采矿，我们将向行会报告。

道别之后，你离开矿井，返回阿利隆。""",
	PRE_FINAL_BOSS_19 = """— 虽然不多，但我们还有一些矿石。你可以拿走。

你拿着工头的报酬，返回阿利隆。""",

	#After mines
	AFTER_MINES_WORKERS_OPTION_1 = """我已经解决了矿井的问题""",
	AFTER_MINES_SIGMUND_START = """— 这是个好消息。我已经做好了准备，所以我们会尽快恢复工作。你赢得了一些奖励。

西格蒙德递给你袋子，里面有一些金币。

{color=green|得到 300 gold}""",
	AFTER_MINES_SIGMUND_OPTION_1 = """谢谢，如果没有别的事情，我就走了""",
	AFTER_MINES_SIGMUND_OPTION_2 = """叛军中有人不同寻常""",
	AFTER_MINES_SIGMUND_1 = """— 好，我想邓肯会有兴趣听到你完成的事情。""",
	AFTER_MINES_SIGMUND_2 = """— 是吗？好吧，这不是我们的问题，最好向邓肯报告。""",
	AFTER_MINES_WORKERS_OPTION_2 = """我已经解决了矿井的问题，但有一些人员伤亡""",
	AFTER_MINES_SIGMUND_3 = """— 啊，我收到了一些报告。你的行动后似乎有一些工人被带走了。我们现在无法进行适当的调查，我也不能给你任何额外的奖励。你应该去找邓肯。""",

	AFTER_MINES_FIGHTERS_OPTION_1 = """我处理了工人的问题""",
	AFTER_MINES_DUNCAN_1 = """— 是的。我收到了一些关于这个问题的报告。你能补充什么吗？""",
	AFTER_MINES_DUNCAN_OPTION_1 = """矿井里有一个半兽人旅行者""",
	AFTER_MINES_DUNCAN_OPTION_2 = """我在外面遇到了一个女恶魔""",
	AFTER_MINES_DUNCAN_OPTION_3 = """没有其他真正值得一提的东西""",
	AFTER_MINES_DUNCAN_2 = """— 一个半兽人？啊，他们不常走进我们的土地。但一个孤独的半兽人并不值得关注，如果他们要行动，我们会知道的，但他们已经几十年没有消息了。""",
	AFTER_MINES_DUNCAN_3 = """— 所以，这可能是你之前提到的恶魔。从你说的方式来看，她在做一些事情，但这不应该阻碍我们。把圣物丢给他们是一种耻辱，但恶魔太少，太稀少，无法构成任何真正的威胁。""",
	AFTER_MINES_DUNCAN_4 = """—但我也听说你不打一架就放走了那个恶魔，她还带走了一些工人。你自己解释一下。""",
	AFTER_MINES_DUNCAN_3_4 = """— 所以，这可能是你之前提到的恶魔。从你说的方式来看，她在做一些事情，但这不应该阻碍我们。把圣物丢给他们是一种耻辱，但恶魔太少，太稀少，无法构成任何真正的威胁。

— 但我也听说你不打一架就放走了那个恶魔，她还带走了一些工人。解释一下。""",
	AFTER_MINES_DUNCAN_OPTION_4 = """我寡不敌众，别无选择""",
	AFTER_MINES_DUNCAN_OPTION_5 = """矿工当时无法获救""",
	AFTER_MINES_DUNCAN_OPTION_6 = """你怎么了？我仍然让矿井恢复运行""",
	AFTER_MINES_DUNCAN_5 = """— 你寡不敌众，但她就这么走了？我很难相信。我们现在会放弃追究这件事，但要知道，如果你和那个帮助叛军的恶魔之间有更深层次的联系曝光，你不会被赦免。""",
	AFTER_MINES_DUNCAN_6 = """— 嗯。好吧，我相信你。但要知道，如果你和那个帮助叛军的恶魔之间有更深层次的联系，你不会被赦免。""",
	AFTER_MINES_DUNCAN_7 = """— 我告诉你这对我来说意味着什么。我们不会容忍与敌人合作。如果我们发现你和那个帮助叛军的恶魔之间有更深的联系，会发生什么，我让你想象。""",
	AFTER_MINES_DUNCAN_8 = """— 就这样，矿井已经恢复生产，你的任务已经完成。然而，这件事的时机太不巧了，不能认为是巧合。我想问你，你认为这是工人们计划好的吗？""",
	AFTER_MINES_DUNCAN_OPTION_7 = """可能存在某种联系""",
	AFTER_MINES_DUNCAN_OPTION_8 = """我觉得不是""",
	AFTER_MINES_DUNCAN_OPTION_9 = """我不知道""",
	AFTER_MINES_DUNCAN_9 = """— 我明白了。我们计划进行大规模行动，所以在接下来的几天里做好准备。我需要你时会给你发一个信使。你现在可以走了。""",
	AFTER_MINES_DUNCAN_OPTION_10 = """我会等它的""",
	AFTER_MINES_DUNCAN_OPTION_11 = """真痛苦……我希望很快结束""",
	AFTER_MINES_DUNCAN_OPTION_12 = """太好了，终于有空闲时间了""",
	AFTER_MINES_MESSAGE = """第二天早上，你收到了邓肯的信使，他说你要去拜访他。""",
	AFTER_MINES_DUNCAN_OPTION_13 = """我收到了消息""",
	AFTER_MINES_DUNCAN_10 = """— 时间到了。我们一直在准备围攻米尔福德，米尔福德在叛乱的最初几天就被叛军占领了。现在我们终于有足够的兵力进行全面围攻。

— 我将领导它，我有一个使命给你。有一支车队运送行动所需的额外食品。你必须护送它去那里。之后，你的部队将加入围攻""",
	AFTER_MINES_DUNCAN_OPTION_14 = """应该不难""",
	AFTER_MINES_DUNCAN_OPTION_15 = """真不敢相信我现在是要扮演快递 [boy] """,
	AFTER_MINES_DUNCAN_11 = """— 不要想当然地认为这会很容易，一路上可能还会有叛军或土匪的伏击。

— 现在，让我们在战场上相遇，结束这场战争。""",
	AFTER_MINES_DUNCAN_12 = """— 我们都必须为这项事业做出贡献。一旦这一切结束，市长选举将恢复，行会不会忘记你的参与。

— 现在，让我们在战场上相遇，结束这场战争。""",
	AFTER_MINES_CONVOY_1 = """你发现你应该在仓库里运送的物资已经准备好了，用几匹骡子装好了，所以你所要做的就是和你的团队一起出发。""",
	AFTER_MINES_CONVOY_OPTION_1 = """咳吭，出发！""",
	AFTER_MINES_CONVOY_2 = """您需要完成准备工作并随车队离开。""",
	AFTER_MINES_CONVOY_3 = """离开城镇几个小时后，你进入了森林。最终，你发现树林中的一条小路被倒下的原木挡住了。你命令士兵们清理，但当他们到达时，一大群叛军从树林中跳了出来，试图阻止你的任务。""",
	AFTER_MINES_CONVOY_4 = """当你击倒首领时，反叛组织的残余分子迅速撤退到树林中。你给了他们一个很好的教训，在你继续执行任务时，他们应该不会再给你带来任何问题。""",
	AFTER_MINES_CONVOY_5 = """你的车队离开森林。当米尔福德越来越近时，你发现一小群农民从前线向你逼近。你命令做好再次面对伏击的准备，但当他们越来越近的时候，你注意到只有几个家庭。他们都没有合适的武器。一进入射程，其中一名男子跪在你面前。

— 大人，我恳求您给我们一些食物。战争对我们很残酷，士兵几乎拿走了我们所有的存粮。在那之后，我们遭到了哥布林的袭击，不得不迁移。我们的孩子快饿死了！""",
	AFTER_MINES_CONVOY_OPTION_2 = """这太可怕了，你需要多少就拿多少""",
	AFTER_MINES_CONVOY_OPTION_3 = """我可以给你一半""",
	AFTER_MINES_CONVOY_OPTION_4 = """这不关我的事""",
	AFTER_MINES_CONVOY_HUNTER_OPTION = """""",
	AFTER_MINES_CONVOY_HUNTER = """""",
	AFTER_MINES_CONVOY_6 = """— 非常感谢您, [Sir].

过了一段时间，你手头的粮食只剩下原来的十分之一。邓肯肯定不会喜欢这样，但现在什么都做不了。也许至少你的行为会让你在普通人中获得一些认可...""",
	AFTER_MINES_CONVOY_7 = """你命令你的士兵卸下一半的粮食，让难民拿走。

— 谢谢你, [Sir]! 我们将为你的安全祈祷。

你在思考如何向邓肯解释这件事...""",
	AFTER_MINES_CONVOY_8 = """你拒绝给难民任何补给。别无选择，他们只能悲惨地送别你.""",
	DUNCAN_NOT_FOUND = """你试图找到邓肯，但他似乎不在附近。你必须在围攻期间加入他.""",
	AFTER_MINES_CONVOY_9 = """又过了几个小时，你的车队终于到达了离小镇几英里外的围攻营地。行会的联合部队已经搭建了一个大帐篷营地。按照指示，你找到了邓肯，正在讨论即将到来的战斗。在远处的角落里，你看到梅尔安静地靠在墙上。""",
	AFTER_MINES_CONVOY_10 = """— 你终于来了, [name]. 我收到报告说，你没有带着大量食物。请解释一下。""",
	AFTER_MINES_CONVOY_OPTION_5 = """我遇到了一群需要他们的难民""",
	AFTER_MINES_CONVOY_OPTION_6 = """土匪在混乱中袭击我们并偷走了它（谎言）""",
	AFTER_MINES_CONVOY_11 = """— 你有明确的指示，但故意不服从。我对你很失望, [name], 一旦我们回到阿利隆，你就会受到惩罚。现在，做好战斗准备。""",
	AFTER_MINES_CONVOY_12 = """— 失败就是失败。我对你很失望, [name], 一旦我们回到阿利隆，你就会受到惩罚。现在，做好战斗准备。""",
	AFTER_MINES_CONVOY_13 = """— 很高兴见到你, [name]. 我看到你成功完成了任务。很高兴这一次有了一个能干的下属。""",
	AFTER_MINES_CONVOY_14 = """在定居点墙内，叛军一直在加强防御，为即将到来的战斗做准备。

{color=yellow|艾尔: — 行会部队正在准备进攻。大约有两千人。这些都是受过训练的士兵和法师。即使在我们现在的位置上，我也怀疑我们能支撑多久。}

{color=aqua|格雷格: — 你不能怀疑任何事情。就位，做好战斗准备。我们有足够的部队来保护这个阴暗的城镇，如果有什么意外的话，我有自己的几张王牌。}

{color=yellow|艾尔: -... 是，长官.}""",
	AFTER_MINES_CONVOY_15 = """在离城墙几百英尺的地方，邓肯按照战前的惯例与阿纳斯塔西娅进行了交谈。

{color=aqua|阿纳斯塔西娅: — 看到人们因为我们的行为而受苦，我很痛苦，但我们不会放下武器 }

{color=yellow|邓肯: — 我们获胜后我会感谢你的。距离我上次战斗已经太久了。}""",
	AFTER_MINES_CONVOY_16 = """阿纳斯塔西娅愤怒地瞥了邓肯一眼。

{color=aqua|阿纳斯塔西娅: — 你现在就这么说？在杀了我父亲之后？}

{color=yellow|邓肯: — 我现在没有什么要对一个青少年说的了。让我们结束这件事吧。}""",
	AFTER_MINES_CONVOY_17 = """尽管阿纳斯塔西娅很生气，但她还是冷静地回答，展示了自己的皇室教养。

{color=aqua|阿纳斯塔西娅: — 很好，上帝会找到正义的 }

{color=yellow|邓肯: — 上帝会找到正义的.}""",


	# betrayal confirmed
	BETRAYAL_CONFIRMED_ADVANCE = """战场上充满了刀片碰撞的声音，无数的箭在空中呼啸。不久，一个敌人小队就向你的侧翼发起了冲锋。""",
	BETRAYAL_CONFIRMED_1 = """在砍倒另一名敌方骑士后，邓肯勘察了战场。当敌人让步时，他的团队已经深入推进，几乎陷入包围，现在他可以清楚地看到他们的指挥官。他从报告中已经知道格雷格和叛军在一起，但现在他已经亲眼证实了这一点。""",
	BETRAYAL_CONFIRMED_2 = """{color=aqua|格雷格: — 好久不见.}

{color=yellow|邓肯: — 我希望一直不见. }

{color=aqua|格雷格: — 你看起来很累，安全的生活让你变弱了吗?}

{color=yellow|邓肯: — 我仍然有足够的勇气来结束你和这场可怜的反抗.}""",
	BETRAYAL_CONFIRMED_3 = """{color=aqua|格雷格: — 嘿，我们拭目以待。我没想到你会来到前线，但我想我们很幸运.}

{color=yellow|邓肯: — 你在说什么?}

{color=aqua|格雷格: — 如果你被打倒，你希望你的军队做什么? }

{color=yellow|邓肯: ...}

现在邓肯意识到有另一群叛军增援部队正在向他们的侧翼逼近。他们的人数将至少比他身边的战友多。不管怎样，他准备好了剑。""",
	BETRAYAL_CONFIRMED_4 = """当你与叛军交战时，你被命令前进。从你的角度来看，行会的军队似乎正在慢慢占据上风.""",
	BETRAYAL_CONFIRMED_5 = """梅尔在几百英尺外的附近山丘上观察了战场。大多数下层法师都是为了支持战斗部队而被征召的，但她有着不同的使命。作为整个阿利隆或整个国家最强的施法者，她不仅仅能做简单的治疗和施法。

她耐心地观察着战场，行会的部队正向城镇推进。 """,
	BETRAYAL_CONFIRMED_6 = """{color=yellow|邓肯: — 战略一直是你强大的一面. }

{color=aqua|格雷格: — 嗯.}

随着越来越多的队伍接近邓肯，他和他的队伍越来越疲惫.""",
	BETRAYAL_CONFIRMED_7 = """{color=aqua|格雷格: — 冲进来是你的错误，亲自领导冲锋更是如此. }

{color=yellow|邓肯: — 再来啊！ }

{color=aqua|格雷格: — 也许是你投降的时候了. }

{color=yellow|邓肯: — 不感兴趣.}

{color=aqua|格雷格: — 哼，你总是肌肉发达，没有头脑。就这样吧.}""",
	BETRAYAL_CONFIRMED_8 = """{color=aqua|梅尔: — 这些该死的傻瓜...}

梅尔毫不拖延地开始念咒。几分钟后，一场大地震袭击了接近邓肯部队的叛军增援部队。她指挥下的其他几个法师也加入了进来，对分离的叛军小队施展远程魔法。 """,

	BETRAYAL_CONFIRMED_9 = """这个咒语在邓肯附近产生了强大的冲击波，当他转向另一边时，他发现逼近的敌人队形在魔法的攻击下崩溃了。

{color=aqua|邓肯: — 该死的，梅尔。谁让你动手的？}

邓肯喃喃自语。然而，格雷格对此感到更加惊讶。他意识到自己失去了战术优势，于是迅速退出了战斗。

{color=yellow|格雷格: — 被诅咒的巫师。撤退到城墙上!}

根据命令，叛军撤出，但行会的军队迅速采取主动并进攻.""",
	BETRAYAL_CONFIRMED_10 = """然而，在大部分公会部队进入城镇之前，一个巨大的白色圆顶已经包围了叛军的避难所。他们从未见过的魔法完全阻止了公会军队的任何前进或进攻。

由于不知所措，行会的部队被迫停止并重新集结.""",
	BETRAYAL_CONFIRMED_11 = """军队领导人聚集在一起讨论局势.

{color=aqua|邓肯: — 这是怎么回事？为什么我们不能通过?}

{color=yellow|梅尔: — 对我来说像是一种神术。这不是我们的专长。}

{color=aqua|邓肯: — 你在说什么?}

{color=yellow|梅尔: — 这是一种特殊的魔法，它的来源是高等生物。但它太罕见了，我只观察过几次。以我们目前的力量来说真的无能为力。}""",
	BETRAYAL_CONFIRMED_12 = """{color=aqua|邓肯: — 该死，叛军怎么会有这样的东西...}

{color=yellow|梅尔: — 我想公主会做出一些不同寻常的事情，但不会达到这种程度. }

{color=aqua|邓肯: — 这种情况会持续多久?}

{color=yellow|梅尔: — 我不知道它会不会自己消失。神术并不总是遵循正常魔法的规则.}

{color=aqua|邓肯: — 该死...}""",
	BETRAYAL_CONFIRMED_13 = """{color=aqua|邓肯: — 听好, [name]. 你早些时候表现出了你的足智多谋。我想让你找到一种方法来拆除障碍。没有它，我们可以结束这场战斗，解放米尔福德。. }

{color=yellow|梅尔: — 我们将让我们的部队做好准备，以防他们决定让叛军发动反击}""",
	BETRAYAL_CONFIRMED_OPTION_1 = """我也不知道该怎么办""",
	BETRAYAL_CONFIRMED_OPTION_2 = """你对我应该从哪里开始有什么建议吗?""",
	BETRAYAL_CONFIRMED_14 = """梅尔: — 嗯，我唯一的想法就是试着去问一个宗教机构。那些人通常更熟悉神术以及如何应对它们。""",
	BETRAYAL_CONFIRMED_OPTION_3 = """我尽力""",
	BETRAYAL_CONFIRMED_OPTION_4 = """又要上班了""",
	BETRAYAL_CONFIRMED_OPTION_5 = """好吧，我去代表你要一支许愿蜡烛""",

	DIVINE_SYMBOL_OPTION_1 = """你能告诉我一些关于神术的事情吗？""",
	DIVINE_SYMBOL_1 = """— 我们有一些关于它的教学和记录。你到底想知道什么？""",
	DIVINE_SYMBOL_OPTION_2 = """*描述情况*""",
	DIVINE_SYMBOL_2 = """— 嗯，这似乎是个神眷者.""",
	DIVINE_SYMBOL_OPTION_3 = """神眷者?""",
	DIVINE_SYMBOL_OPTION_4 = """能做点什么吗？""",
	DIVINE_SYMBOL_3 = """— 神眷者是神青睐的人，他们能够调用自己的神的力量。反过来，他们被认为会听从神的指示。事实上，他们是如此罕见，几千年历史我们只记录到少数几个。啊，我很想有一天能见到赛琳娜的神眷者。 """,
	DIVINE_SYMBOL_4 = """— 嗯，我想有办法。如果另一个神通过媒介施加影响，你应该能够中和这个神的力量。然后你就可以通过这个障碍，尽管要彻底消除它，你必须击败神眷者。""",
	DIVINE_SYMBOL_OPTION_5 = """我需要做什么?""",
	DIVINE_SYMBOL_OPTION_6 = """你能变出这样的东西吗?""",
	DIVINE_SYMBOL_5 = """— 如果你给我带来神圣的象征，我可以用赛琳娜的力量祝福它。我会把食谱给你。请你做好后再来。""",
	DIVINE_SYMBOL_OPTION_7 = """我带来了你要的东西""",
	DIVINE_SYMBOL_6 = """— 啊，你有吗？一件漂亮的作品！请给我一些时间。

金妮离开你几分钟，最终带着你经过她的标志回到你身边，现在发出了一道几乎不明显的光。

— 在这里，这应该可以让你在屏障上创造一个短暂的空洞。在外面请小心 [Sir] [name].""",
	DIVINE_SYMBOL_7 = """{color=aqua|邓肯: — 你回来了。有什么消息?}""",
	DIVINE_SYMBOL_OPTION_8 = """我找到了进入屏障的方法""",
	DIVINE_SYMBOL_OPTION_9 = """我准备好了""",
	DIVINE_SYMBOL_8 = """{color=aqua|邓肯: — 所以，有了这个，你就可以进入屏障，搞定那个“神眷者”了。好吧，我同意。一旦你进入，我们就会为进攻做好准备。}

{color=yellow|梅尔: — 从它的外观来看，我认为罪魁祸首应该在圆顶的中心，很可能也受到了保护。 }

{color=aqua|邓肯: — 不管是谁，召集你最好的追随者，准备进行一场艰苦的战斗。我很想陪你一起去，但军队不能没有指挥官。}""",
	DIVINE_SYMBOL_9 = """{color=aqua|邓肯: — 好，我们不要浪费时间。这场战斗的结果掌握在你手中。 }

{color=yellow|梅尔: — 有一个地方，你可以从山边悄悄地进入，我给你看。}""",
	DIVINE_SYMBOL_10 = """你完成了准备工作，在夜幕降临时，你从梅尔指出的地方进入了屏障。当你走上街头时，你只会偶尔看到叛军巡逻队，他们似乎相当松懈。通过呆在阴影中，你设法窃听了他们。

{color=aqua|哨兵1: — 我们为什么要这么做？那些混蛋根本进不来. }

{color=yellow|哨兵2: — 是啊，我也搞不懂。我们已经在这里呆了好几天了，什么都没有。我宁愿喝杯啤酒玩玩女人，而不是他妈的长矛。}

当他们经过时，你继续前进.""",
	DIVINE_SYMBOL_11 = """当你慢慢进入市中心时，你注意到另一支巡逻队正在接近你的位置。你即将被发现，无法在不被注意的情况下撤退.""",
	DIVINE_SYMBOL_OPTION_10 = """跑 (物理)""",
	DIVINE_SYMBOL_12 = """{color=green|成功}

多亏你反应迅速，你才灵活地避开了巡逻队.""",
	DIVINE_SYMBOL_ASSASSIN = "潜行冲刺 (刺客)",
	DIVINE_SYMBOL12_1 = "{color=green|成功}\n\n由于你的技能，你可以灵活地在街上奔跑，不会发出任何噪音. ",
	DIVINE_SYMBOL_13 = """{color=red|失败}

你试过了，但在疯狂地转弯后，你撞上了一堆板条箱。巡逻队注意到了你发出的噪音，现在你别无选择，只能战斗.""",
	DIVINE_SYMBOL_14 = """你已经相对平静地击败了巡逻队。希望不会再次被发现，你离开了这个地方.""",
	DIVINE_SYMBOL_15 = """你到达了一个小广场，目标应该在那里。但是，有多栋建筑，任何一栋都可能是目标.""",
	DIVINE_SYMBOL_OPTION_11 = """搜索 (智慧因素)""",
	DIVINE_SYMBOL_16 = """{color=red|失败}

你进错楼了。一些反叛分子认出你是入侵者并武装起来.""",
	DIVINE_SYMBOL_17 = """你尽可能安静地干掉叛军，然后返回广场.""",
	DIVINE_SYMBOL_18 = """{color=green|成功}

你进入一个小走廊，走廊的门由一群武装叛乱分子把守。

{color=yellow|卫兵1: — 为什么我们不能呆在里面?}

{color=aqua|卫兵2: — 她要求独处。如果你问我的话，我觉得这样挺好.}""",
	DIVINE_SYMBOL_18_1 = """{color=yellow|卫兵1: — 嗯？为什么，你不喜欢她?}

{color=aqua|卫兵2: — 她是兽人，行为像疯子，看起来像个离经叛道的人。格雷格觉得她很有用，但我宁愿站在食人魔一边.}""",

	DIVINE_SYMBOL_19 = """{color=yellow|卫兵1: — 是的，就大脑而言，你会找到共同点。}

{color=aqua|卫兵2: — 你他妈-}

警卫注意到你走近一半就停了下来。它们会给你一个充满敌意的眼神，等待你的进一步行动。""",
	DIVINE_SYMBOL_OPTION_12 = """格雷格叫你们去拜访他（魅力因素）""",
	DIVINE_SYMBOL_OPTION_13 = """攻击""",
	DIVINE_SYMBOL_20_1 = """{color=green|成功}

{color=aqua|卫兵2: — 该死, 他现在想要什么? }

{color=yellow|卫兵1: — 可能以为你上次值班时一直在睡觉.}

{color=aqua|卫兵2: — 你没有告诉他，是吗？操，我们走。 }

他们离开了大楼，门口无人看守.""",
	DIVINE_SYMBOL_20_2 = """{color=red|失败}

{color=aqua|卫兵2: — 胡说八道，他们是入侵者。抓住他们!}""",
	DIVINE_SYMBOL_21 = """恐怕没有谈判的余地，你准备战斗.""",
	DIVINE_SYMBOL_22 = """当你击倒警卫时，你终于可以接近门口了.""",
	DIVINE_SYMBOL_23 = """你进入了一个豪华但灯光昏暗的房间。另一边的一个小小人影转向你.

— 好吧，你花了不少时间，现在你甚至都不敲门了。很粗鲁。我喜欢。

小女孩对你的出现反应出乎意料地漠不关心。

— 西菲拉.

在你说出她的名字后，西菲拉向你鞠了一躬.""",
	DIVINE_SYMBOL_24 = """— 在我忘记之前……这是一份熟人礼物.

她递给你一卷从小桌子上的纸堆里拿出来的纸。当你展开它时，你会看到一幅粗糙但有点神韵的[man]肖像素描。再看一眼，你就会发现这个人有点像你。看到你脸上的表情，西菲拉激动得闪闪发光。

— 喜欢吗?""",
	DIVINE_SYMBOL_OPTION_14 = """无法拒绝""",
	DIVINE_SYMBOL_OPTION_15 = """你是怎么做到的?""",
	DIVINE_SYMBOL_OPTION_16 = """你是跟踪狂吗?""",
	DIVINE_SYMBOL_25 = """— 终于有人在欣赏我的作品了。不过，请继续奉承，这是我的专长.""",
	DIVINE_SYMBOL_26 = """— 我画的，傻瓜。哦，你是说我怎么知道你长什么样的？我没有。你知道有时你会梦见一些还没有发生的事情，但过了一段时间就会发生吗？也许是这样的.""",
	DIVINE_SYMBOL_27 = """— 啊哈，不，如果我是跟踪狂，我就不会在这里等你了，不是吗?""",
	DIVINE_SYMBOL_28 = """

— 那么，你会接受吗?""",
	DIVINE_SYMBOL_OPTION_18 = """*接受*""",
	DIVINE_SYMBOL_OPTION_19 = """*拒绝*""",
	DIVINE_SYMBOL_29 = """你感谢西菲拉的画，然后把它收起来。她对你微笑，让你暂时忘记来这里的原因.

— 但你一定想从我身上得到其他东西。也许和屏障有关?""",
	DIVINE_SYMBOL_30 = """你以严肃的眼光审视了这幅画.

— 所以，你一定是因为屏障而来的，对吧?""",
	DIVINE_SYMBOL_OPTION_20 = """如果我要求你销毁它，你会吗?""",
	DIVINE_SYMBOL_OPTION_21 = """你必须销毁它，否则""",
	DIVINE_SYMBOL_31 = """— 当然，但如果你不介意的话，首先我有一个请求。嗯。允许我加入你.""",
	DIVINE_SYMBOL_OPTION_22 = """为什么要加入我?""",
	DIVINE_SYMBOL_OPTION_23 = """你一定有充分的理由""",
	DIVINE_SYMBOL_32 = """— 我想，我必须解释一下。我把这整件事都安排好了，就是为了找到你。嗯，不是专门针对你，而是一个有能力穿过屏障并找到我的人。你做得很好。""",
	DIVINE_SYMBOL_OPTION_24 = """你为什么需要这样的人?""",
	DIVINE_SYMBOL_OPTION_25 = """这是一个相当大胆的计划""",
	DIVINE_SYMBOL_OPTION_26 = """你需要我做什么任务?""", #after 24 and 25 seen
	DIVINE_SYMBOL_33 = """— 你可能知道我是阿利奥斯的神眷者。当我们的恩人给我们下达命令时，我们会有这种冲动。我的任务是找到并加入你……或者像你这样的人？不，我想这太粗鲁了，毕竟我已经找到你了。""",
	DIVINE_SYMBOL_34 = """— 还有什么比打断一场大型战争更好的方法来找到一个强壮狡猾的人呢？无论如何，你的领导者都会被迫找到一个方法，并寻求帮助。所以我为失败的一方提供了一些帮助。现在我找到了你。""",
	DIVINE_SYMBOL_35 = """— 阿利奥斯的意图并不明确，但如果你问我，世界一定处于巨大的危险之中。也许我们稍后会想出一些办法。那么，你能允许我加入你吗？我相信这将是一次富有成效的合作。""",
	DIVINE_SYMBOL_OPTION_27 = """好吧，为什么不呢""",
	DIVINE_SYMBOL_OPTION_28 = """不，我不能相信你""",
	DIVINE_SYMBOL_OPTION_29 = """我不合作，只领导""",
	DIVINE_SYMBOL_36 = """西菲拉花了很长时间思考你和你的话。就在你以为她什么都不会说的时候，她跪在你面前。

— 好吧，如果你愿意的话，我会成为你的下属. """,
	DIVINE_SYMBOL_OPTION_30 = """我来照顾你 """,
	DIVINE_SYMBOL_OPTION_31 = """那是个笑话，你可以加入我""",
	DIVINE_SYMBOL_OPTION_32 = """不，毕竟我不能信任你""",
	DIVINE_SYMBOL_37 = """— 我可以叫你 [master]吗？呵呵，现在让我消除障碍，这样我们就可以继续了。""",
	DIVINE_SYMBOL_38 = """— 呵呵，很高兴我们解决了这个问题。好吧，等一下，我会消除屏障的。然后我们可以讨论其他事情。""",
	DIVINE_SYMBOL_39 = """— 你这个白痴！让我做了一件很尴尬的事……哦，好吧，让我们结束吧，结束后我们可以讨论其他事情。""",
	DIVINE_SYMBOL_40 = """— 哈哈，太令人沮丧了。好吧，那我们就结束吧，我一会儿就把屏障清除。很高兴见到你。""",
	DIVINE_SYMBOL_41 = """西菲拉闭上眼睛，她的身影笼罩在昏暗的光线中，这证明了她的神圣联系。与此同时，通过窗户，你可以观察到屏障慢慢开始消散。""",
	DIVINE_SYMBOL_42 = """

— 好吧，搞定了。那我们晚点再见面吧。""",
	DIVINE_SYMBOL_43 = """

— 我们搞定了，高兴吗？嘿，你介意载我一程吗？你知道，干了这么多活，我的脑子真的很疼。""",
	DIVINE_SYMBOL_44 = """当屏障倒塌时，邓肯下令立即发动进攻。许多叛军在休息时猝不及防，无法迅速做出反应。当公会的军队慢慢攻占城镇时，没有人注意到你的小队，让你轻松逃脱。""",
	DIVINE_SYMBOL_45 = """{color=aqua|格雷格: — 见鬼……该死的，屏障怎么了!?}

{color=yellow|艾尔: — 看来他们不知怎么钻了进去。他们的主力军一直在准备。恐怕我们撑不了多久了.}

{color=aqua|格雷格: — 该死。命令撤退。确保公主的安全。诅咒那个无用的神眷者，她最好不要活着离开.}""",
	DIVINE_SYMBOL_46 = """{color=aqua|梅尔: — 啊，[he]真的成功了。你不打算领导这次袭击吗?}

{color=yellow|邓肯: — 不，一切都结束了，没有任何挑战。我已经安排了一些小队来提防任何可能的逃跑，所以公主很快就会成为我们的了。 }

{color=aqua|梅尔: — 哼，她太聪明了，不会被你抓住的. }

就在这时，一个信使走近邓肯.""",
	DIVINE_SYMBOL_47 = """{color=aqua|信使: — 先生，[name]回来了，请求接见. }

{color=yellow|邓肯: — 带 [him] 进来.}

当你出来的时候，你会注意到邓肯坚毅的脸上流露出一丝尊重。

{color=aqua|邓肯: — 干得好。你在这里的表现将载入史册。你还做了那些法师做不到的事。}

{color=yellow|梅尔: — 去你的.}""",
	DIVINE_SYMBOL_OPTION_33 = """不太难""",
	DIVINE_SYMBOL_OPTION_34 = """我还以为我死定了""",
	DIVINE_SYMBOL_48 = """{color=aqua|邓肯: — 不管怎样，明天早上这个小镇都会是我们的。你可以去休息。}""",
	DIVINE_SYMBOL_49 = """几小时后

{color=yellow|士兵: — 我们已经占领了小镇，但没有格雷格或公主的踪迹。}

{color=aqua|邓肯: — 该死，他们一定有一些我们不知道的隐蔽的逃跑路线。然而，这个城镇是我们的，叛军已经被击败了。

邓肯: — [name], 你现在可以回到阿利隆了。我们将计划下一步行动}""",


	FINAL_OPERATON_START = "-你好 [name]。 我需要在我们之间的一件事上寻求你的帮助。",
	FINAL_OPERATON_START_OPTION_1 = "我很乐意提供帮助",
	FINAL_OPERATON_START_OPTION_2 = "先说出来",

	FINAL_OPERATON_1 = """— 我简短地说，我们发现了一个隐秘的叛军藏身处，我们相信公主会在那里。我们正在召集一支突击队来突袭他们。

— 考虑到你在上一场战斗中的表现和整体帮助，我认为这不仅仅证明了你在战斗中的能力。这也符合你的最大利益，考虑到这将是迄今为止我们捕获公主的最佳机会。

— 私下里，我认为你是市长职位的最佳候选人，因为你已经证明了自己的能力。如果公主真的在这个藏身处，你会抓住她的。你准备好了吗？""",
	FINAL_OPERATON_2 = """— 我简短地说，我们发现了一个隐秘的叛军藏身处，我们相信公主会在那里。我们正在召集一支突击队来突袭他们。

— 考虑到你在上一场战斗中的表现和整体帮助，我认为这不仅仅证明了你在战斗中的能力。这也符合你的最大利益，考虑到这将是迄今为止我们捕获公主的最佳机会。

— 私下里，我认为你是市长职位的最佳候选人，因为你已经证明了自己的能力。如果公主真的在这个藏身处，你会抓住她的。你准备好了吗？""",
	FINAL_OPERATON_OPTION_1 = "预计会遭到何种程度的抵抗?",
	FINAL_OPERATON_OPTION_2 = "听起来很有趣，我会去的",
	FINAL_OPERATON_OPTION_3 = "我想没有更好的机会了",
	FINAL_OPERATON_3 = """— 嗯，首先，这个位置是一个废弃的矿井，这将是一个封闭的空间，但应该还有足够的空间与敌人作战。叛军可能会得到很好的防御工事，他们会有人数优势，但我们的人更精锐。""",
	FINAL_OPERATON_4 = """— 你花的时间越长，敌人准备的时间就越多，所以尽量不要让我们等太久。我会在你的地图上标出位置。

— 不要向其他行会提起这件事。我们仍然不确定格雷格是否是我们中间唯一的叛徒，我们不能接受因为间谍事先警告公主导致她逃跑这种事。话虽如此，如果你能在不透露突袭行动的情况下向他们寻求帮助，那就去做吧""",
	FINAL_OPERATON_WORKERS_OPTION_1 = "请求帮助",
	FINAL_OPERATON_WORKERS_1 = """— 啊，你不知道我们承受着多大的压力吗？整个行会都在支持与叛军发生战斗的战士。目前没有人可以自由承担一些外来工作。""",
	FINAL_OPERATON_SERVANTS_1 = """— 来找我们是为了邓肯的小突袭吗？拜托，[name]，我以为你知道我们不处理任何暴力事件。对不起……但为了让你高兴起来，我给你一个小提示：问问梅尔。法师在你寻找的东西上肯定更有能力。""",
	FINAL_OPERATON_MAGES_1 = """— 工作？我不明白我为什么会在乎，但为了我自己的娱乐，让我们听听。你到底想要什么？""",
	FINAL_OPERATON_MAGES_1_OPTION_1 = """我只能说帮我""",
	FINAL_OPERATON_MAGES_1_OPTION_2 = """我正在帮助战士行会进行突袭""",
	FINAL_OPERATON_MAGES_2 = """— 你必须详细说明你想要的这个帮助。当然，你不能一时兴起就指望我们的帮助，尤其是在发生的事情上。""",
	FINAL_OPERATON_MAGES_2_OPTION_1 = """嘿，我为公会做了很多工作。""",
	FINAL_OPERATON_MAGES_2_OPTION_2 = """看，这很重要。我帮过弗雷德，不是吗？""",
	FINAL_OPERATON_MAGES_2_OPTION_3 = """求你了，梅尔，这很重要，记得我给你拿书的时候吗？""",
	FINAL_OPERATON_MAGES_3_1 = """— 嗯，好吧，不管怎样，但这是一次性交易。我想我有一些预备队可以用于你的行动。只要确保他们完好无损地返回，那么我们就只需要处理一些乏味的文书工作。""",
	FINAL_OPERATON_MAGES_3_2 = """— 嗯，好吧，我不喜欢被蒙在鼓里，这会让你付出代价。我可以用三百金币找到一些志愿者。""",
	FINAL_OPERATON_MAGES_3_OPTION_1 = """好. [移除 300 金币]""",
	FINAL_OPERATON_MAGES_3_OPTION_2 = """我没有钱.""",
	FINAL_OPERATON_MAGES_4 = """— 什么，你希望我们免费工作吗？离开这里，我有实际业务要处理。""",
	FINAL_OPERATON_MAGES_5_1 = """— 哦，不要给我装可怜。我想你已经足够胜任这份工作了。现在离开这里，我还有更重要的事情要做。""",
	FINAL_OPERATON_MAGES_5_2 = """— 嗯，好吧，我不喜欢被蒙在鼓里，这会让你付出代价。我可以用三百金币找到一些志愿者。""",
	FINAL_OPERATON_MAGES_5_3 = """你坐下并等待，梅尔消失在公会中。没过多久，一小队法师拖着脚步走进房间，梅尔紧随其后。

— 这是你的志愿者。现在你们都该走了，我有事情要处理。

你领着你的新随从出门。打开你的地图，你向团队展示邓肯指定的地方。告诉他们在那里等着，如果有人问他们，就说是你的命令。""",
	FINAL_OPERATON_MAGES_5_4 = """— 我对帮助战士行会的任何事情都没有兴趣。你为什么不去寻求他们的帮助，这是他们的工作或其他什么。现在，如果你不介意的话，我有实际的事要处理，请见谅。""",

	INITIATE_HIDEOUT_ATTACK_1 = """你到达了邓肯为你标记的位置，一个靠近藏身处的森林区域。邓肯在战士行会的小组中与其中一些人交谈。尽管他看到你时挥手示意他们离开，并向你挥手示意。""",
	INITIATE_HIDEOUT_ATTACK_2 = """你到达了邓肯为你标记的位置，一个靠近藏身处的森林区域。邓肯在战士行会的小组中与其中一些人交谈。尽管他看到你时挥手示意他们离开，并向你挥手示意。

你还注意到你的一小队法师，当你经过时，其中一个向你挥手。

— 很好，你来了。看来你听从了我的建议。还有我相信你没有告诉梅尔细节？""",
	INITIATE_HIDEOUT_ATTACK_6 = """— 好吧，我们不要浪费时间。准备好你们的人，我们就开始。""",
	INITIATE_HIDEOUT_ATTACK_OFCOURSE = """当然""",
	INITIATE_HIDEOUT_ATTACK_OPTION_1 = "我想在前线",
	INITIATE_HIDEOUT_ATTACK_OPTION_2 = "我们应该一起进去",
	INITIATE_HIDEOUT_ATTACK_3 = "...你确定你能应付吗？这并不容易，但我不会阻止你。",
	INITIATE_HIDEOUT_ATTACK_3_OPTION_1 = "我喜欢挑战",
	INITIATE_HIDEOUT_ATTACK_3_OPTION_2 = "缩在后面没有荣耀",
	INITIATE_HIDEOUT_ATTACK_3_OPTION_3 = "转念一想，我们应该一起进去",
	INITIATE_HIDEOUT_ATTACK_4 = """— 我印象深刻。但不要低估敌人，他们可以用它来对付你。

— 去准备战斗吧，我们五分钟后出发。

你为即将到来的战斗做好准备。可以看到邓肯在小队之间移动，告知他们该计划。当邓肯举起一只手臂指向隐蔽处时，你和你的小队一起移动到所有人的前面。""",
	INITIATE_HIDEOUT_ATTACK_5 = """— 去准备战斗吧，我们五分钟后出发。

你为即将到来的战斗做好准备。可以看到邓肯在小队之间移动，告知他们该计划。当邓肯举起一只手臂指向隐蔽处时，你和你的小队一起移动到所有人的前面。 """,

	GUILD_ATTACK_ON_HIDEOUT_1 = """在叛军藏身处较深的房间里，格雷格闯入了艾尔和阿纳斯塔西娅占据的房间。

{color=aqua|格雷格: — 我们受到攻击。行会找到了我们。}

{color=yellow|阿纳斯塔西娅: — 这么快！？我们该怎么办？}

{color=aqua|格雷格: — 你需要逃跑.}""",
	GUILD_ATTACK_ON_HIDEOUT_2 = """{color=yellow|阿纳斯塔西娅: — 逃跑？不，我不能...}

{color=aqua|格雷格: — 别无选择。如果你被俘，你将被送上绞刑架。此外，没有你，就没有王位继承人}

{color=yellow|阿纳斯塔西娅: — 这是错误的，我不能把所有人都抛在后面.}

{color=aqua|格雷格: — 够了，我们在浪费时间。艾尔！把公主赶走，马上回到我身边.}""",
	GUILD_ATTACK_ON_HIDEOUT_3 = """{color=yellow|艾尔: — ... 我明白了。这边请，殿下.}

{color=aqua|阿纳斯塔西娅: — 不，那之后我该怎么办?}

{color=yellow|艾尔: — 别担心，我们已经为这种情况计划好了……一旦我们打败入侵者，我们就会重聚并把你带回来。}

{color=green|格雷格: — 你已经听到了，安娜，现在行动起来。}

{color=aqua|阿纳斯塔西娅: — ...}""",
	GUILD_ATTACK_ON_HIDEOUT_4_1 = """{color=yellow|艾尔: — 她已经走了.}

{color=aqua|格雷格: — 很好，你终于做了一些有用的事情。现在拿起武器，准备防守。}

{color=yellow|艾尔: — ...明白。}

{color=aqua|格雷格: — 该死，整个计划很快就要完蛋了。}""",

GUILD_ATTACK_ON_HIDEOUT_4_2 = """在叛军藏身处较深的房间里，格雷格闯入阿纳斯塔西娅占据的房间。

{color=aqua|格雷格: — 我们受到攻击。行会找到了我们。}

{color=green|阿纳斯塔西娅: — 这么快！？我们该怎么办？}

{color=aqua|格雷格: — 你将不得不逃跑。使用你的精灵为你准备的路线。}""",
	GUILD_ATTACK_ON_HIDEOUT_4_3 = """{color=yellow|阿纳斯塔西娅: — 逃跑？不，我不能...}

{color=aqua|格雷格: — 他们一定是针对你的，没有你就没有革命}

{color=yellow|阿纳斯塔西娅: — 这是错误的，我不能把所有人都抛在后面.}

{color=aqua|格雷格: — 这不值得争论。如果你最终落入他们之手，你将被处决。现在走吧，我们会阻止他们，这样他们就不会追你了.}

{color=yellow|阿纳斯塔西娅: — ...}""",

	FINAL_BOSS_1 = """沿着长长的隧道奋力前行，你来到一座拱门前，迅速穿过。你进入了一个相当大的房间，也许在某个时候它可能是一个储藏室。

快速评估你周围的环境，有几个叛军匆忙地拿着板条箱。在房间后面附近，一名男子监视着叛军的活动。

— 啊，看来我们有伴儿了。你们都组织起来，阻止行会的渣滓。""",

	FINAL_BOSS_2 = """沿着长长的隧道奋力前行，你来到一座拱门前，迅速穿过。你进入了一个相当大的房间，也许在某个时候它可能是一个储藏室。”。

快速评估你周围的环境，有几个叛军匆忙地拿着板条箱。房间中央附近有一个小精灵。她很快采取了战斗的姿势。

—我们有伴儿了。武装起来!""",

	FINAL_BOSS_3 = """沿着长长的隧道奋力前行，你来到一座拱门前，迅速穿过。你进入了一个相当大的房间，也许在某个时候它可能是一个储藏室。”。

快速评估你周围的环境，有几个叛军匆忙地拿着板条箱。然而，在房间中央附近有一个你认识的小精灵。她注意到了你，很快采取了战斗的姿势。

这是以前和你玩得很开心的精灵女孩。她带着明显的仇恨眯起眼睛看着你。

— 你... 我从没想过会在这里报复你。武装起来!""",

	FINAL_BOSS_4 = """沿着长长的隧道奋力前行，你来到一座拱门前，迅速穿过。你进入了一个相当大的房间，也许在某个时候它可能是一个储藏室。”。

快速评估你周围的环境，有几个叛军匆忙地拿着板条箱。然而，在房间中央附近有一个你认识的小精灵。她注意到了你，很快采取了战斗的姿势。

这是你从巫妖手中救下的精灵。当她认出你来时，她的立场动摇了。她摇摇头，回到了战斗的姿势。

— 这并不是我想象中的我会再次见到你的方式。对不起，我不让你去找阿纳斯塔西娅。武装起来！""",

	AIRE_COMBAT_ON_WIN_2 = """当你结束战斗时，小精灵在疲惫和痛苦中倒下，环顾四周，正好看到邓肯的小队从第二个入口冲了进来。

{color=yellow|邓肯: — 干得不错。但恐怕这里没有其他人，包括公主。尽管这个婊子应该知道一些事情。}""",

	AIRE_COMBAT_ON_WIN_3 = """{color=yellow|艾尔: — 该死的…你抓不到她！}

{color=aqua|邓肯: — 闭嘴，小精灵。你没能保护这个地方，也没能保护你的公主。她会像你一样得到她应有的下场。}

{color=yellow|艾尔: — 混蛋... 啊-}

她还没来得及说什么，邓肯的手下就抓住了她，堵住了她的嘴。""",

	AIRE_COMBAT_ON_WIN_3_1 = """{color=yellow|艾尔: — Damn you... You won't get her!}

{color=aqua|邓肯: — 闭嘴，小精灵。你没能保护这个地方，也没能保护你的公主。她会像你一样得到她应有的下场。}

{color=yellow|艾尔: — 混蛋... 啊-}

她还没来得及说什么，邓肯的手下就抓住了她，堵住了她的嘴。""",


	GREG_COMBAT_ON_WIN_1 = """男人踉踉跄跄地后退，喘着粗气。你环顾四周，看到邓肯在你身后砍倒了一名叛军。当你们两人面对这个藏身处的头目时，战友走到了你身边。

{color=aqua|邓肯: — 格雷格, 下台投降。这场可悲的叛乱结束了。}

{color=yellow|格雷格: — 啊，邓肯。我猜到你会出现在这里，但对你来说有个坏消息，阿纳斯塔西娅已经离这里很远了。}

{color=aqua|邓肯: — 我们拭目以待，我的人已经包围了这个地区。现在放下你的w-}

邓肯还没来得及说完，他就把东西扔到了地上。当可怕的铃声在你耳边响起时，光线突然笼罩着你的视野。你盲目地踉踉跄跄了一会儿，然后迅速眨眼以恢复视力。当你环顾房间，发现那个人不见了，铃声逐渐减弱。""",

	GREG_COMBAT_ON_WIN_2 = """— 我本应该预料到一个反叛者会有同样的懦弱。至少看起来你可以控制自己，只是在下次注意你的侧翼。

邓肯转身和你说话。行会成员开始给还没死的叛军戴上手铐。

--你今天在这里表现出了相当的技巧。""",

	GREG_COMBAT_ON_WIN_3 = """邓肯转身和你说话。行会成员开始给还没死的叛军戴上手铐。

--你今天在这里表现出了相当的技巧。""", # never should be used

	GREG_COMBAT_ON_WIN_4 = """邓肯转身和你说话。行会成员开始给还没死的叛军戴上手铐。

— 你今天在这里表现出了相当的技巧。

— 我本来会早点到的，但格雷格和我们纠缠了一段时间，然后设法逃跑了。""",

	GREG_COMBAT_OPTION_1 = """我们现在该怎么办？""",
	GREG_COMBAT_OPTION_2 = """对不起，我本来应该更快到达这里的。""",
	GREG_COMBAT_OPTION_3 = """精灵女孩该怎么办？""",
	GREG_COMBAT_OPTION_4 = """将如何处置叛军？""",
	GREG_COMBAT_OPTION_5 = """我的行动能得到奖励吗？""",
	GREG_COMBAT_OPTION_6 = """谢谢你让我把一些叛军的脑袋打进胸腔。""",

	GREG_COMBAT_ON_WIN_5 = """— 虽然结果令人失望，但她没地方躲只是时间问题。""",
	GREG_COMBAT_ON_WIN_6 = """{color=aqua|邓肯: — 她？和其他人一样，他们会被监禁和审问。}

小精灵挣扎着挣脱束缚，愤怒地反抗。""",

	GREG_COMBAT_ON_WIN_7 = """— 他们将被监禁并审问公主的任何信息，她仍然是我们的主要关注点。""",

	GREG_COMBAT_ON_WIN_8 = """— 你不必担心，你会得到奖励的。战士们还有很多工作要做，一旦完成，我们就可以考虑奖励了。""",
	GREG_COMBAT_ON_WIN_9 = """— 回家吧。我们会把这里的一切都清理干净。稍后来找我，我们会讨论能做什么。""",
	COMBAT_ON_WIN_FRONTLINE = """— 许多叛军现在已经死亡或住在我们的监狱里。不幸的是，我们在突袭中错过了公主，也没有线索表明她可能去了哪里。我们对囚犯的审讯没有太多结果。

— 别以为我忘了你在突袭中的勇敢。给你的奖励。我相信我可以继续依靠你，你已经证明了自己非常有能力。

— 我们还得找到公主。""",

	COMBAT_ON_WIN_NOT_FRONTLINE = """— 许多叛军现在已经死亡或住在我们的监狱里。不幸的是，我们在突袭中错过了公主，也没有线索表明她可能去了哪里。我们对囚犯的审讯没有太多结果。

— 哦，这是对你在突袭中提供帮助的奖励。你已经证明了自己很有能力。

— 我们还得找到公主。""",

	COMBAT_ON_WIN_OPTION_1 = """我很想亲自去找她.""",
	COMBAT_ON_WIN_OPTION_2 = """我目前还有其他问题需要处理.""",

#search for princess
	SEARCH_FIGHTERS_1 = """— 现在，我们的审讯进展不佳。这些白痴狂热地致力于他们的叛乱。""",
	SEARCH_FIGHTERS_OPTION_1 = """你为什么还没有找到公主？""",
	SEARCH_FIGHTERS_1_1 = """— 随着叛军囚犯的大规模涌入，以及我们还要维护城市和平，我们没有足够的人力独自寻找她。""",
	SEARCH_FIGHTERS_OPTION_2 = """我能从战士行会得到任何帮助吗？""",
	SEARCH_FIGHTERS_1_2 = """— 就目前情况来看，我只能向你保证，你将是第一个知道其中一名叛军是否进行谈判的人。尽管目前情况可能需要数周甚至更长时间。""",
	SEARCH_FIGHTERS_OPTION_3 = """那我晚点去.""",
	SEARCH_FIGHTERS_2 = """— 找到公主的位置后尽快回来，我们可以计划好该怎么办。其他公会可能会有一些想法。

— 考虑到你的目标，也许值得去拜访阿米莉亚，看看她是否能提供任何建议。""",
	SEARCH_FIGHTERS_OPTION_4 = """我想和精灵女孩说话。""",
	SEARCH_FIGHTERS_3 = """— 她？我们没有从她身上得到任何东西。如果有什么不同的话，就是她比其他人更狂热。""",
	SEARCH_FIGHTERS_OPTION_5 = """我以前见过她。也许我可以从她那里得到一些信息。""",
	SEARCH_FIGHTERS_OPTION_6 = """精灵很少见，为人类叛乱而战的精灵更是如此。""",
	SEARCH_FIGHTERS_4 = """— 嗯…告诉我更多信息。""",
	SEARCH_FIGHTERS_OPTION_7 = """当你让我去追捕巫妖时，她也在那里。不过我不知道她和叛军在一起。""",
	SEARCH_FIGHTERS_OPTION_8 = """我饶了她一次命。""",
	SEARCH_FIGHTERS_5_1 = """— 没错，她肯定比其他叛军知道得更多。我想让你试着让她说话不会有什么损失。""",
	SEARCH_FIGHTERS_5_2 = """— 情况很奇怪，但我听过一些更疯狂的故事，结果都是真的。我想你是我们中最有机会让她说话的人，继续吧。""",
	SEARCH_FIGHTERS_5_3 = """— 有趣的是，如果你能利用这种关系让她说话，那么让她活下去是值得的。我想你应该是最有机会的。""",
	SEARCH_FIGHTERS_5 = """— 你会在城市的地牢里找到她。我会通知警卫，让他们让你通过。""",
	SEARCH_FIGHTERS_6_INIT = """ """,
	SEARCH_FIGHTERS_6 = """ """,#no phrases here in this scene, mb error, mb _6 scene is not reqired
	SEARCH_FIGHTERS_7_INIT = """我能和你谈谈吗？""",
	SEARCH_FIGHTERS_7 = """— 我听说你在和法师一起追踪公主，你需要我帮忙吗？""",
	SEARCH_FIGHTERS_OPTION_9 = """我本来想和精灵女孩谈谈。""",
	SEARCH_FIGHTERS_8 = """— 我没有理由拒绝这个请求。她在地牢里，我会通知警卫的。""",
	SEARCH_SERVANTS_OPTION_INIT = """你对如何追踪公主有什么想法吗？""",
	SEARCH_SERVANTS_1 = """— 嗯，也许问问邓肯你能不能和精灵女孩谈谈。她看起来和他们带来的其他反叛者不一样，很特别。

— 虽然如果你不是那种会说话的类型，法师行会可能会在其他方面提供帮助。魔法有很多应用。""",
	SEARCH_SERVANTS_2 = """— 战士们带来的叛军看起来都不是一个普通人。我不怀疑他们会从他们那里得到太多信息。

— 稍后你可以再次向梅尔寻求帮助。魔法有多种用途。""",
	SEARCH_SERVANTS_OPTION = """谢谢，我马上开始。""",
	SEARCH_DUNGEON_1 = """你走到地牢的入口处。守卫给你钥匙，并指引你指向关押艾尔的牢房。

令你惊讶的是，站在牢房外的是阿米莉亚，她注意到了你，然后走了过去。""",
	SEARCH_DUNGEON_OPTION_1 = """阿米莉亚？你在这里干什么？""",
	SEARCH_DUNGEON_2_1 = """— 哦，只是跟进我给你的建议。很高兴看到至少有人认真对待我的建议。""",
	SEARCH_DUNGEON_2_2 = """— 一只小鸟告诉我你要去拜访我们的一位新客人。我想也许我可以来分享一些建议。""",
	SEARCH_DUNGEON_2_3 = """— 如果你不知道的话，她的名字叫艾尔。看起来她应该确切地知道我们需要什么。

— 我相信你可以让她说你是一个迷人的家伙。不过如果她被证明...比较棘手，我总是可以尝试我的一些方法。""",
	SEARCH_DUNGEON_OPTION_2 = """我会考虑的.""",
	SEARCH_DUNGEON_OPTION_3 = """希望没有必要.""",
	SEARCH_DUNGEON_3_1 = """当你走进艾尔的牢房时，当她认出你时，你感觉到她敏锐的目光。小精灵女孩坐在冰冷的墙壁角落里，双手铐在身后。

— 又是你。你觉得你能从我身上得到什么吗？""",
	SEARCH_DUNGEON_OPTION_4 = """所以你还记得我""",
	SEARCH_DUNGEON_4_1 = """— 像你这样的混蛋不多. """,
	SEARCH_DUNGEON_OPTION_5 = """我想请求原谅已经太晚了?""",
	SEARCH_DUNGEON_4_2 = """— 你想骗谁？你已经暴露了自己的真实面貌.""",
	SEARCH_DUNGEON_OPTION_6 = """这个地方似乎很适合你""",
	SEARCH_DUNGEON_4_3 = """— ...滚.""",
	SEARCH_DUNGEON_OPTION_7 = """我们想知道公主逃到了哪里""",
	SEARCH_DUNGEON_OPTION_8 = """你肯定知道你的主人去了哪里""",
	SEARCH_DUNGEON_OPTION_9 = """你不认为你应该合作，让事情变得更好吗?""",
	SEARCH_DUNGEON_5_1 = """— 你真的认为我会和你合作吗?""",
	SEARCH_DUNGEON_OPTION_10 = """为什么不呢？是什么让你如此忠诚?""",
	SEARCH_DUNGEON_5_2 = """— ...你不会理解，我也不会白费口舌告诉你.""",
	SEARCH_DUNGEON_OPTION_11 = """谁知道如果你不合作会发生什么""",
	SEARCH_DUNGEON_5_3 = """— 我已经看过你最坏的一面。我宁愿死也不愿帮助你的同类。""",
	SEARCH_DUNGEON_OPTION_12 = """如果你合作，公主会更好""",
	SEARCH_DUNGEON_5_4 = """— 哦，我相信她在其他地方会更好.""",
	SEARCH_DUNGEON_OPTION_13 = """这毫无进展""",
	SEARCH_DUNGEON_6_1 = """我告诉过你，你永远不会从我身上得到任何东西。继续吧，继续浪费你的时间。""",
	SEARCH_DUNGEON_OPTION_14 = """一旦我找到她，你会希望你能更加合作。""",
	SEARCH_DUNGEON_6_2 = """— 如果你敢碰她，我会把你追到天涯海角。""",
	SEARCH_DUNGEON_OPTION_15 = """很好。享受在这个牢房里腐烂的乐趣吧""",
	SEARCH_DUNGEON_6_3 = """艾尔对你的话没有反应，但不知怎么的，她似乎对你的愤怒感到满意。""",
	SEARCH_DUNGEON_OPTION_16 = """*打她*""",
	SEARCH_DUNGEON_6_4 = """*拍击*
你的手狠狠地拍了一下艾尔的脸颊，她的脸颊变红了，但她的表情并没有改变。

— 哼，正如你这样一个地位低下的人所期望的那样。""",
	SEARCH_DUNGEON_OPTION_LEAVE = """离开""",
	SEARCH_DUNGEON_3_2 = """你发现小精灵女孩坐在牢房的角落里，双手铐在背后。尽管她的眼睛看起来很疲惫，但却充满了尊严。当你打开门时，她明显地把目光移开。

— ... 如果你认为你会从我身上得到什么，那你就是在浪费时间。 """,
	SEARCH_DUNGEON_OPTION_17 = """问候她""",
	SEARCH_DUNGEON_7_1 = """艾尔带着好奇的目光转向你。当她认出你的脸时，她的语气变得有点紧张。

— ...哦，是你。幸灾乐祸？""",
	SEARCH_DUNGEON_OPTION_18 = """保持安静""",
	SEARCH_DUNGEON_7_2 = """过了一会儿，小精灵女孩的好奇心战胜了她，她转向了你。

— ...哦，是你。幸灾乐祸？""",
	SEARCH_DUNGEON_OPTION_19 = """实际上我想问几个问题。""",
	SEARCH_DUNGEON_OPTION_20 = """让我们切入正题，告诉我们公主藏在哪里。""",
	SEARCH_DUNGEON_OPTION_21 = """我得走了""",
	SEARCH_DUNGEON_8_1 = """— 我不会告诉你阿纳斯塔西娅在哪里，不会告诉你，也不会告诉这个城市的其他人。除此之外，我不介意有人陪伴。""",
	SEARCH_DUNGEON_8_1_IF_MET = """— 我不会告诉你阿纳斯塔西娅在哪里，不会告诉你，也不会告诉这个城市的其他人。除此之外，我不介意有人陪伴。我知道你至少不是坏人。""",
	SEARCH_DUNGEON_OPTION_22 = """你为什么对公主如此忠诚？""",
	SEARCH_DUNGEON_OPTION_23 = """你在叛乱中扮演了什么角色？""",
	SEARCH_DUNGEON_OPTION_24 = """你觉得我怎么样？""",
	SEARCH_DUNGEON_8_7_1 = """— 好吧，如果我说我觉得你没有吸引力，我就是在撒谎。我想你也已经证明了自己在战斗中表现得更好。我希望你在安娜身边，而不是格雷格身边，事情可能会大不相同。""",
	SEARCH_DUNGEON_8_7_2 = """你当然可以在战斗中坚持自己的立场，而且你似乎不像行会传闻中的其他人那样糟糕。如果情况有所不同，也许我们本可以成为朋友。""",
	SEARCH_DUNGEON_OPTION_25 = """目前仅此而已""",
	SEARCH_DUNGEON_7_3 = """ """, #no line in doc
	SEARCH_DUNGEON_9 = """— 她在我小时候救过我。嗯，差不多，她也是个孩子，请注意。

— 我的父母被土匪杀害，我被抓获并带到他们的营地。然后，土匪们被安娜的手下轮流突袭。我被释放了，但我无处可去。

— 所以她主动提出让我为她服务。她的警卫们看起来不同意，但从她的举止来看，他们似乎只能遵守她的决定。我尽量不妨碍她，只履行我的职责，但她经常来看望我，把我当作小妹妹对待，尽管我只是一个平民，一个精灵，更不用说她的仆人了。从那时起，我就向她宣誓效忠。我准备为她牺牲我的生命。""",
	SEARCH_DUNGEON_OPTION_26 = """关于你父母的事情我很遗憾""",
	SEARCH_DUNGEON_8_2 = """— 别这样，我很久以前就克服了，我和当时大不相同了。""",
	SEARCH_DUNGEON_OPTION_27 = """你的奉献精神令人钦佩""",
	SEARCH_DUNGEON_8_3 = """— 我不希望你完全理解，但谢谢。""",
	SEARCH_DUNGEON_OPTION_28 = """你本可以自己过得更好的""",
	SEARCH_DUNGEON_8_4 = """— 不，你不明白。我想我不应该告诉你。""",
	SEARCH_DUNGEON_10 = """— 我只是在为安娜服务。我对人类政治毫不关心。对我来说，你们都是敌人，只是因为杀死了安娜的父亲，不管他是谁。 """,
	SEARCH_DUNGEON_OPTION_29 = """你知道你可以因为密谋反对行会而被处决吗？""",
	SEARCH_DUNGEON_8_5 = """— 即使是这样，我也不在乎。总有人想让你死的原因，不管是什么或在哪里。""",
	SEARCH_DUNGEON_OPTION_30 = """我希望我们没有站在对立的一边""",
	SEARCH_DUNGEON_8_6 = """— 这确实很遗憾，但我们现在真的无法改变。但受够了毫无意义的情绪，我相信你不是来这里的。""",
	SEARCH_DUNGEON_11 = """— 又是这个？我想我已经明确表示了，我不可能告诉你们任何人任何事情。""",
	SEARCH_DUNGEON_OPTION_31 = """又是这个？我想我已经明确表示了，我不可能告诉你们任何人任何事情。""",
	SEARCH_DUNGEON_12_1 = """— 我是，但是……我很难想象她在一个比行会更糟糕的地方。""",
	SEARCH_DUNGEON_OPTION_32 = """你的合作可以为你赢得更好的生活条件，甚至是赦免""",
	SEARCH_DUNGEON_12_2 = """— 这与我无关，你这个白痴。我很清楚，一旦她被发现，行会就会处决她，我不会帮你的。""",
	SEARCH_DUNGEON_OPTION_33 = """别傻了，叛乱已经结束，我们找到她只是时间问题""",
	SEARCH_DUNGEON_12_3 = """— 如果是这样，那么你就不需要我的帮助，事情会自己解决的。""",
	SEARCH_DUNGEON_OPTION_34 = """如果你不配合，我相信其他审讯人员不会那么好...""",
	SEARCH_DUNGEON_12_4 = """— 试试看。无论你或其他人威胁要对我做什么，我都不会辜负她的信任。""",
	SEARCH_DUNGEON_OPTION_35 = """我可以向你保证，我会保证阿纳斯塔西娅的安全""",
	SEARCH_DUNGEON_13 = """艾尔停顿了一下，思考了很长一段时间。

— 你的话肯定会有分量，而且你在这里似乎有一定的特权，但我真的能信任你吗？你为什么要帮助她？""",
	SEARCH_DUNGEON_OPTION_36 = """我其实站在你这边，如果你帮我，我会帮她活下去""",
	SEARCH_DUNGEON_7_4 = """— 对不起，我不会相信这么明显的谎言。""",
	SEARCH_DUNGEON_OPTION_37 = """我们可以把你送回精灵之地""",
	SEARCH_DUNGEON_7_5 = """— 胡说八道，我不仅不会放弃我的职责，而且在这一切之后我也不想去那里。""",
	SEARCH_DUNGEON_OPTION_38 = """我们可以指控你藏匿罪犯""",
	SEARCH_DUNGEON_7_6 = """— 我可以接受，如果有什么不同的话，那将更加证明我忠诚的价值。""",
	SEARCH_DUNGEON_OPTION_39 = """我不需要更多的理由，只需要让你感觉更好""",
	SEARCH_DUNGEON_14_1 = """— 考虑到我的立场，这些都是一些廉价的词。你真的希望我相信吗？""",
	SEARCH_DUNGEON_OPTION_40 = """我认为我们应该尽最大努力让人们不那么痛苦""",
	SEARCH_DUNGEON_14_2 = """— 你真的这么想吗？……这也是她所相信的。不过，这听起来过于理想化了。""",
	SEARCH_DUNGEON_OPTION_41 = """她可以在政治方面提供一些价值""",
	SEARCH_DUNGEON_14_3 = """— 不可能。她的存在对行会来说是一种危险，我们都知道。一旦他们找到她，就会立即处理她。""",
	SEARCH_DUNGEON_OPTION_42 = """她会为我的后宫增添一大笔财富""",
	SEARCH_DUNGEON_14_4 = """艾尔突然大笑起来。

— 这是在开玩笑吗？如果你是认真的，那是一种可怕的动机，我不知道在这种情况下，她和你在一起还是行会更糟糕。 """,
	SEARCH_DUNGEON_7_7 = """— 很抱歉，我想我还是不能相信你。即使安娜继续逃亡，即使在贫困中，她离开这里也会更好。""",
	SEARCH_DUNGEON_15 = """艾尔沉默了一段时间，矛盾的情绪在她脸上闪过。最后，她长长地叹了一口气。

— 好吧，我相信你。如果这里有人能为她的利益行事，那就是你。她逃到精灵之地了。由于我的传统，我设法为她争取到了一个位置。你可以从高级女祭司那里了解更多，假设她会让你见到她，但在这一点上，我认为对你来说应该不是什么大问题。""",
	SEARCH_DUNGEON_16 = """当你离开地牢时，你看到阿米莉亚还在牢房入口处等着，她向你招手。

-进展如何?""",
	SEARCH_DUNGEON_OPTION_43 = """我得到了公主的位置。""",
	SEARCH_DUNGEON_17 = """— 哇，真的吗？我就知道你有一副巧舌如簧的样子，干得好。邓肯会想知道你一准备好向他传递信息，别担心，如果你想等一等，我不会抢了你的风头。""",
	SEARCH_DUNGEON_OPTION_44_1 = """我无法获得公主的任何信息。""",
	SEARCH_DUNGEON_18 = """— 哦，没关系，值得一试。我看她就知道她很难对付。所以……你考虑过我的提议吗？如果你愿意，我可以试着让她谈谈。""",
	SEARCH_DUNGEON_OPTION_44_2 = """这个女孩很难对付""",
	SEARCH_DUNGEON_OPTION_45 = """继续吧，不会有什么坏处。""",
	SEARCH_DUNGEON_19_1 = """— 别担心，我肯定会从她那里得到一些东西，但可能需要一些时间。我一定会在收到信息后亲自将信息传递给你。""",
	SEARCH_DUNGEON_OPTION_46 = """不，我想我会找到另一种方法。""",
	SEARCH_DUNGEON_19_2 = """— 好吧，我理解，如果你想重新考虑，就来和我谈谈。""",
	SEARCH_DUNGEON_OPTION_47 = """其实我只是想和她谈谈，我已经找到了另一种寻找公主的方法。""",
	SEARCH_DUNGEON_19_3 = """— 哦？如果你只是想看到一个小精灵被锁起来的样子，你可以随时来，我们会偶尔收到精灵。好吧，如果你改变主意，这个提议仍然有效，如果你愿意，来找我。""",
	SEARCH_DUNGEON_OPTION_48 = """感谢阿米莉亚""",



	FINAL_OPERATION_MESSAGE = """早上你收到一个信使，他邀请你去见邓肯。这看起来相当紧急，他应该有一个新的任务给你。""",
	LOOKING_FOR_PRINCESS_1 = """— 许多叛军现在已经死亡或住在我们的监狱里。不幸的是，我们在突袭中没抓到公主，也没有线索表明她可能去了哪里。我们对囚犯的审讯没有太多结果。""",
	LOOKING_FOR_PRINCESS_2 = """

— 别以为我忘了你在突袭中的勇敢。这是给你的奖励。我相信我可以继续依靠你，你已经证明了自己非常有能力。""",
	LOOKING_FOR_PRINCESS_3 = """

— 哦，这是对你在突袭中的帮助的奖励，你已经证明了自己非常有能力。""",
	LOOKING_FOR_PRINCESS_4 = """

— 我们还得找到公主.""",
	LOOKING_FOR_PRINCESS_OPTION_1 = """让我们开始吧，我很想亲自去找她。""",
	LOOKING_FOR_PRINCESS_OPTION_2 = """我目前还有其他问题要处理。""",
	LOOKING_FOR_PRINCESS_OPTION_3 = """搜索结果如何？""",
	LOOKING_FOR_PRINCESS_5 = """-到目前为止，我们还没有关于她的位置的进一步线索。到目前为止还没有人提供任何新信息。""",
	LOOKING_FOR_PRINCESS_OPTION_4 = """我会找到她的。""",
	LOOKING_FOR_PRINCESS_OPTION_5 = """我稍后再来。""",
	LOOKING_FOR_PRINCESS_6 = """当你在现在空无一人的大厅和最近战斗的痕迹中搜索时，你很难找到任何有用的东西。似乎行会的雇佣兵和拾荒者没有浪费任何时间。然而，半小时后，你注意到一个较小的拾荒者。

孤独的狗头人正在翻箱倒柜，似乎没有意识到你的存在。你在他的手上发现一个不同寻常的优雅银手镯，看来他是有收获的。 """,
	LOOKING_FOR_PRINCESS_OPTION_6 = """*问候他*""",
	LOOKING_FOR_PRINCESS_OPTION_7 = """*接近*""",
	LOOKING_FOR_PRINCESS_7 = """当你走近时，他发现了你，跳了起来，后退了一点。

--嘿，你想要什么？

狗头人阴翳地打量着你。""",
	LOOKING_FOR_PRINCESS_OPTION_8 = """你在这里干什么？""",
	LOOKING_FOR_PRINCESS_OPTION_9 = """你的手镯很好看""",
	LOOKING_FOR_PRINCESS_8 = """— 和你一样。努力生存。或者你会坚持说你不是来拾荒的？""",
	LOOKING_FOR_PRINCESS_9 = """— 它当然很好看。你看起来想要它，是吗？哈，我能看到有人在追求什么。对于你嘛，我准备卖掉它。只要500金币，这就是你的。""",
	LOOKING_FOR_PRINCESS_OPTION_10 = """太贵了""",
	LOOKING_FOR_PRINCESS_OPTION_11 = """我宁愿强行拿走""",
	LOOKING_FOR_PRINCESS_OPTION_FINE = """好，拿走金币吧""",
	LOOKING_FOR_PRINCESS_OPTION_FINE_500 = """好，拿走金币吧（500金币）""",
	LOOKING_FOR_PRINCESS_OPTION_FINE_1000 = """好，拿走金币吧（1000金币）""",
	LOOKING_FOR_PRINCESS_OPTION_FINE_1500 = """好，拿走金币吧（1500金币）""",
	LOOKING_FOR_PRINCESS_OPTION_13 = """我考虑一下""",
	LOOKING_FOR_PRINCESS_10 = """— 哈，想把我当傻瓜吗？我不知道你想要它干什么，但我看得出来你想要它，我打赌你有能力支付。要么接受，要么放弃。""",
	LOOKING_FOR_PRINCESS_11 = """在你还没来得及行动的时候，狗头人就带着他的财产迅速逃到了地上的一个小洞里。你不可能这样跟着他。你可以改天再回来。""",
	LOOKING_FOR_PRINCESS_12 = """一段时间后，您会发现手镯上有相同的狗头人。

— 嘿，下定决心了吗？""",
	LOOKING_FOR_PRINCESS_OPTION_14 = """购买""",
	LOOKING_FOR_PRINCESS_OPTION_14_500 = """购买（500金币）""",
	LOOKING_FOR_PRINCESS_OPTION_14_1000 = """购买（1000金币）""",
	LOOKING_FOR_PRINCESS_OPTION_14_1500 = """购买（1500金币）""",
	LOOKING_FOR_PRINCESS_13 = """过了一段时间，你会发现同一个戴着手镯的狗头人似乎回到了同一个地方。

— 又是野蛮人。你最好别再给我搞事情了。我觉得我很大方，所以我还是会卖给你你想要的手镯。。。1000金币。""",
	LOOKING_FOR_PRINCESS_OPTION_15 = """上次是500金""",
	LOOKING_FOR_PRINCESS_OPTION_THINK = """我会考虑""",
	LOOKING_FOR_PRINCESS_OPTION_17 = """试图敲诈我，你这个小混蛋*攻击*""",
	LOOKING_FOR_PRINCESS_14 = """— 是的，没关系，考虑一下攻击我的报复。要么接受，要么离开，我不在乎。""",
	LOOKING_FOR_PRINCESS_15 = """与上次一样，狗头人迅速消失在一个小洞中，你一无所有。你可以改天再来。""",
	LOOKING_FOR_PRINCESS_16 = """过了一段时间，你会发现同一个戴着手镯的狗头人似乎回到了同一个地方。

— 又是野蛮人了。不知道何时学习一定很难。但我很仁慈，我还是会以1500金币的价格卖给你你想要的手镯。""",
	LOOKING_FOR_PRINCESS_OPTION_18 = """我用拳头来买好不好？*攻击*""",
	LOOKING_FOR_PRINCESS_17 = """这一次你稍稍冲到了狗头人的前面。他在最后一刻仍然足够快，可以从你的手中逃开，但他在路上摔倒了，几乎摔倒了。当他恢复镇静并继续逃跑时，你诅咒他。然后你注意到他匆忙中掉下了手镯。

他无法在不离开洞穴的情况下取回它，只能对你破口大骂。

经过仔细检查，你确认它一定是皇室的，所以是时候把它带到梅尔那里了。""",
	LOOKING_FOR_PRINCESS_18 = """当你把金子递给狗头人时，他把手镯给你，很快就带着钱消失了。经过仔细检查，你确认它一定是皇室的，所以是时候把它带给梅尔了。""",
	LOOKING_FOR_PRINCESS_OPTION_19_1 = """I've been tasked to find the Princess...""", # MISSING TRANSLATION
	LOOKING_FOR_PRINCESS_19_1 = """You ask Myr for a way to find the Princess. After a short pause she gives you a short response.

— Get some of her personal belongings. Try her last stand, maybe Duncan's goons haven't scrapped it all yet.""", # MISSING TRANSLATION
	LOOKING_FOR_PRINCESS_OPTION_19 = """我买了手镯""",
	LOOKING_FOR_PRINCESS_19 = """您已将手镯赠送给阿米莉亚，阿米莉亚仔细检查了几分钟。

{color=yellow|阿米莉亚: — 好吧，做工精细。这肯定是皇室的。版画是写给最小的女儿的。}

{color=aqua|梅尔: — 好吧，让我们结束这件事吧。 }

梅尔从她的桌子上拿出一个小徽章。当她念咒语时，她手中的徽章开始发光。大约一分钟后，她说完，转身回到你身边。""",
	LOOKING_FOR_PRINCESS_20 = """{color=aqua|梅尔: — 好吧，这会指向前一位主人的方向。拿在手里，你会感觉到轻微的振动。}

{color=yellow|阿米莉亚: — 搞定。现在你可以找到我们的小问题了。嘿，我想知道当着她的面它是否也会继续振动...}

{color=aqua|梅尔: — 除非你想被赶出去，否则别谈你的职业怪癖。}

{color=yellow|阿米莉亚: — 好吧，好吧，我无论如何都应该出去。祝你好运，我在等你的成功。}""",
	LOOKING_FOR_PRINCESS_21 = """测试徽章后，您确定它指向精灵森林。您的目标应该是现在访问它们。""",
	LOOKING_FOR_PRINCESS_22 = """你要求拜访精灵女祭司，她似乎是精灵首都的主要统治者。尽管天生厌恶外来者，但你的身份迫使精灵接受了你的请求。""",
	LOOKING_FOR_PRINCESS_23 = """徽章一直指向精灵之都，所以你别无选择，只能去见精灵之都的首席统治者女祭司。尽管天生厌恶外来者，但你的身份迫使精灵接受了你的请求。""",
	LOOKING_FOR_PRINCESS_24 = """你被带到一个有几个警卫的大房间，被告知在那里等着。过了一分钟，一个精灵女人从对面出现向你靠近。她的身材和警卫的反应清楚地表明了她的优越地位。

— 通常我们不欢迎外来者进入我们的土地，但我们已经承诺接待来自人类土地的大使。说清楚你的事，陌生人。""",
	LOOKING_FOR_PRINCESS_OPTION_20 = """您应该更加尊重您的客人""",
	LOOKING_FOR_PRINCESS_OPTION_21 = """我在找某个女人""",
	LOOKING_FOR_PRINCESS_OPTION_22 = """我们无意冒犯您""",
	LOOKING_FOR_PRINCESS_25 = """— 你在和弗雷娅的女祭司说话。[race]，我们对你的尊重再高不过了。考虑到弗雷娅的仁慈，你会得到你想要的女人的。""",
	LOOKING_FOR_PRINCESS_26 = """— 我们知道你来这里是为了什么。考虑到弗雷娅的仁慈，你会得到你想要的女人。""",
	LOOKING_FOR_PRINCESS_27 = """— 停止你无用的玩笑。考虑到弗雷娅的仁慈，你会得到你想要的女人。""",
	LOOKING_FOR_PRINCESS_OPTION_23 = """就这么简单?""",
	LOOKING_FOR_PRINCESS_OPTION_24 = """你为什么要这么做?""",
	LOOKING_FOR_PRINCESS_OPTION_25 = """好吧，我不会抱怨""",
	LOOKING_FOR_PRINCESS_28 = """— 我们对你们的人类纠纷没有兴趣。这个女人来寻求庇护，但我们不是慈善机构。一旦你带走了这个女人，我希望你离开这个地方。

女祭司命令卫兵把公主弄出来。""",
	LOOKING_FOR_PRINCESS_29 = """当阿纳斯塔西娅看到你时，她意识到自己是来干什么的，脸色变得苍白。

{color=aqua|阿纳斯塔西娅: — 不……到底是什么？！你不能这样对我！}

{color=yellow|女祭司: — 停止你的幼稚行为，人类，如果你是真正的皇室成员，就表现得有点风度。}""",
	LOOKING_FOR_PRINCESS_OPTION_26 = """很荣幸见到你，公主""",
	LOOKING_FOR_PRINCESS_OPTION_27 = """现在，没有必要制造闹剧""",
	LOOKING_FOR_PRINCESS_OPTION_28 = """我一直在找你""",
	LOOKING_FOR_PRINCESS_30 = """公主没有注意你的话，继续猛烈抨击女祭司，女祭司似乎越来越生气。

{color=aqua|阿纳斯塔西娅: — 他们会杀了我，就像他们杀了我爸爸一样。你背叛了我。我以为我可以信任你！}""",
	LOOKING_FOR_PRINCESS_OPTION_29 = """*保持沉默*""",
	LOOKING_FOR_PRINCESS_OPTION_30 = """*拍打公主并闭上她的嘴*（物理因素）""",
	LOOKING_FOR_PRINCESS_OPTION_31 = """我们不要妄下结论，我们当然可以讨论这个""",
	LOOKING_FOR_PRINCESS_31 = """{color=green|成功}

在她还没来得及说更多的话之前，你就已经扑向阿纳斯塔西娅，狠狠地扇了她一耳光。没想到，她吓得倒在了地上。你抓住时机制服她，堵住她的嘴，向女祭司道歉。

{color=aqua|女祭司: — 我暂时原谅这种不体面的表演。现在离开，以后记住我们的仁慈。 }

说完，女祭司已经离开了大厅，警卫把你带到出口。阿纳斯塔西娅无话可说，被束缚，别无选择，只能让你把她拖走。 """,
	LOOKING_FOR_PRINCESS_32_f = """{color=red|失败}

""",
	LOOKING_FOR_PRINCESS_32 = """{color=aqua|阿纳斯塔西娅: — 背叛的混蛋，你比这些人还糟糕！你和你那腐烂的弗雷娅应该是-}

*Slap*

在你设法抓到阿纳斯塔西娅之前，女祭司自己给了她一记响亮的耳光，吓得她摔倒在地。""",
	LOOKING_FOR_PRINCESS_OPTION_32 = """没有必要变得暴力""",
	LOOKING_FOR_PRINCESS_OPTION_33 = """不能说我不会这么做""",
	LOOKING_FOR_PRINCESS_OPTION_34 = """好吧，够了""",
	LOOKING_FOR_PRINCESS_33 = """{color=aqua|女祭司: — 安静, [race]!}

她的突然爆发使你退缩了。

""",
	LOOKING_FOR_PRINCESS_34 = """公主坐在地上，用手捂住脸颊，女祭司怒视着她，显然被激怒了。

{color=aqua|女祭司: — 我可以原谅你的侮辱，愚蠢的人类，只要你对我们保密就好了，但在这座寺庙里侮辱女神是一种严重的冒犯。如果你是一个精灵平民，你早就被割掉了舌头。 }

{color=yellow|阿纳斯塔西娅: — ...}""",
	LOOKING_FOR_PRINCESS_35 = """{color=aqua|女祭司: — 然而，你必须用你的生命来为你的罪行负责。卫兵！}

{color=yellow|阿纳斯塔西娅: — 什么? 不...}

根据命令，警卫抓住了阿纳斯塔西娅，还挡住了你的去路。公主仍然对事态的突然转变感到震惊，不敢相信这会发生在她身上。""",
	LOOKING_FOR_PRINCESS_OPTION_35 = """*反对*""",
	LOOKING_FOR_PRINCESS_OPTION_36 = """*让她被处决*""",
	LOOKING_FOR_PRINCESS_36 = """你告诉女祭司，无论如何你都需要公主活着。在观察到震惊的公主后，她似乎更冷静了，但却无法忍受。

{color=aqua|女祭司: — 不管你的需要，她都会被处决。这是法律，不管你或她的地位如何，我们都不能赦免。一旦她的灵魂被树救赎，你就可以拥有她的尸体。我想这对你的主人来说应该足够了。}""",
	LOOKING_FOR_PRINCESS_OPTION_37 = """太野蛮了""",
	LOOKING_FOR_PRINCESS_OPTION_38 = """她只是一个被宠坏的孩子，你当然可以忽略这一点""",
	LOOKING_FOR_PRINCESS_OPTION_39 = """她死于你之手可能会对你的土地造成更大的危险""",
	LOOKING_FOR_PRINCESS_37 = """{color=aqua|女祭司: — 我很清楚她是什么，但这是法律，不会放弃。}

""",
	LOOKING_FOR_PRINCESS_38 = """{color=aqua|女祭司: — 小心你的舌头[race]，否则你可能会加入她的行列。法律是最终的，没有争议。}

""",
	LOOKING_FOR_PRINCESS_39 = """{color=aqua|女祭司: — 我们不在乎威胁。传统的惩罚将一如既往。}

""",
	LOOKING_FOR_PRINCESS_40 = """您注意到西菲拉谨慎地示意您让她代表您进行谈判。""",
	LOOKING_FOR_PRINCESS_OPTION_40 = """作为她的监护人，我请求替代她接受惩罚""",
	LOOKING_FOR_PRINCESS_OPTION_41 = """*允许西菲拉协商*""",
	LOOKING_FOR_PRINCESS_OPTION_42 = """没办法了""",
	LOOKING_FOR_PRINCESS_41 = """女祭司瞪着你，停顿了很长时间。

{color=aqua|女祭司: — 监护人确实可以代替未成年人受到惩罚。尽管你必须知道，我不能简单地处决外国的使者。然而，我们的传统需要鲜血。 }

女祭司又停顿了很长时间，仔细思考了一下情况，最后回答了。""",
	LOOKING_FOR_PRINCESS_42 = """{color=aqua|女祭司: — 很好，我允许你牺牲一名追随者来惩罚她。}""",
	LOOKING_FOR_PRINCESS_OPTION_43 = """*接受*""",
	LOOKING_FOR_PRINCESS_OPTION_44 = """*拒绝* """,
	LOOKING_FOR_PRINCESS_43 = """你选择了牺牲随从来代替阿纳斯塔西娅。当你与[name]分手时，你不指望再见到[him]。

{color=aqua|女祭司: — 现在离开，告诉你的主人，我们仍然遵守协议。}

阿纳斯塔西娅静静地看着[name]被带走，也许是因为另一次死亡而责怪自己。""",
	LOOKING_FOR_PRINCESS_44 = """{color=aqua|女祭司: — 然后我们将按照决定进行。}

""",
	LOOKING_FOR_PRINCESS_45 = """在你的同意下，西菲拉向前走去。女祭司若有所思地观察着她。

{color=aqua|西菲拉: — 古老的传统很重要，但……相当有问题。 }

{color=yellow|女祭司: — 你敢提什么建议？}

{color=aqua|西菲拉: — 有一次我听说一个故事，讲的是一个年轻的精灵女孩幸运地坠入爱河。这对她来说一定很大胆。但不幸的是，她爱上了一个人类男性。这件事可能发生在我们任何人身上。}

{color=yellow|女祭司: — 你……你根本不知道自己在说什么。}""",
	LOOKING_FOR_PRINCESS_46 = """{color=yellow|卫兵: — 窃窃私语）啊…这是怎么回事？}

{color=aqua|西菲拉: — 啊，对了，我记得那个男人的名字叫安思菲尔德，不过我记不起那个女孩的名字了。}

你已经注意到冰冷的女祭司在听到这些话时明显地抽搐了。精灵守卫们似乎对整个情况感到困惑。

{color=yellow|女祭司: — 够了。我们已经做出了决定。你可以带上你的贵族。仁慈的弗雷娅赦免了她的罪行。}""",
	LOOKING_FOR_PRINCESS_47 = """按照这个命令，公主被移交给你，你向女祭司表示感谢。

{color=aqua|西菲拉: — 弗雷娅的和蔼不是很感人吗？我相信这个决定最终会对所有人都有利。}

{color=yellow|女祭司: — 当然，不管怎样。离开吧，带上你那肮脏的泼妇。}

{color=aqua|西菲拉: — *小声* 嘿, [name], 我没有犯规，是吗？}""",
	LOOKING_FOR_PRINCESS_48 = """现在和沉默的公主站在外面，你请西菲拉解释发生了什么。

— 哦，好吧，很久以前，阿利奥斯变成了一个名叫安思菲尔德的人类雄性，并搞了一些恶作剧。或者可能附身了他。。。不管怎样，你知道弗雷娅的高级女祭司永远不能和男人发生关系吗？更糟糕的是非精灵？啊，请忘了我说过什么，哈哈。""",
	LOOKING_FOR_PRINCESS_OPTION_45 = """听起来令人难过""",
	LOOKING_FOR_PRINCESS_OPTION_46 = """那么，她是一个被迫的女同性恋？""",
	LOOKING_FOR_PRINCESS_OPTION_47 = """你出乎意料地提供了帮助""",
	LOOKING_FOR_PRINCESS_49 = """— 的确，为什么人们如此紧张？你不觉得阿利奥斯对如此平凡的事情如此放松真是太棒了吗？啊，对不起，我不是故意说教的。""",
	LOOKING_FOR_PRINCESS_50 = """— 我不知道，也许她很贞洁。在刚才的那场磨难中，她看起来确实很冷淡，但也许这都是一场表演。也许我们永远不会知道。""",
	LOOKING_FOR_PRINCESS_51 = """— 为什么，谢谢！等等，出乎意料的是什么意思？如果你要取笑我，把我当孩子一样对待，我会表现得更像一个孩子。你肯定不会想要这样吧？""",
	LOOKING_FOR_PRINCESS_52 = """警卫们没有浪费太多时间就把阿纳斯塔西娅绑在了圣地中心的大树上。在仪式开始之前，你被迫离开了，这让你不用盯着公主恳求的脸看。大约半个小时后，她苍白的尸体被送来了。

是时候回家了。""",

	PRE_ANASTASIA_EXECUTION_1 = """当你向邓肯展示公主的尸体时，他痛苦地邹起眉头。在你向他解释了发生的事情后，他看起来很失望，但接受了。

— 很遗憾发生了这种事，但我相信你已经尽力了。最后，这一切都结束了，所以要做好成为市长的准备，你应得的""",
	PRE_ANASTASIA_EXECUTION_OPTION_1 = """我想要她的精灵仆人""",
	PRE_ANASTASIA_EXECUTION_OPTION_2 = """很荣幸""",
	PRE_ANASTASIA_EXECUTION_OPTION_3 = """很高兴与您做生意""",
	PRE_ANASTASIA_EXECUTION_2 = """— 不行。我需要提醒你在围攻前丢失了所有重要物资吗？这将是你对我们的补偿。""",
	PRE_ANASTASIA_EXECUTION_3 = """— 嗯，好吧，在这一点上我们对她没有用，但不要指望她友好，尤其是在公主去世后。""",
	PRE_ANASTASIA_EXECUTION_4 = """— 我们将在一周后宣布您的继任，直到您可以休息。""",
	PRE_ANASTASIA_EXECUTION_5 = """你成功地将公主送到了牢房，并找到了邓肯，邓肯似乎意识到了你的成功。

— 你做了很少有人敢梦想的事，不仅结束了战争，还亲自俘虏了公主。你已经赢得了未来。一旦公主的命运决定了，我们就让你当市长。说到这里，我已经把会议安排在明天了。你应该参加。""",
	PRE_ANASTASIA_EXECUTION_OPTION_4 = """她会怎么样?""",
	PRE_ANASTASIA_EXECUTION_OPTION_5 = """我肯定会参加""",
	PRE_ANASTASIA_EXECUTION_OPTION_6 = """文书工作多于实际战斗""",
	PRE_ANASTASIA_EXECUTION_6 = """— 这是我们明天要做的决定，但我确信她的头会滚动……或者可能会优雅地挂在绞刑架上。""",
	PRE_ANASTASIA_EXECUTION_OPTION_7 = """她活该""",
	PRE_ANASTASIA_EXECUTION_OPTION_8 = """杀死这么漂亮的女孩似乎是浪费""",
	PRE_ANASTASIA_EXECUTION_7 = """— 我不在乎她应该得到什么，她很危险，所发生的一切证明了这一点。我们把她杀掉，继续生活。""",
	PRE_ANASTASIA_EXECUTION_8 = """— 如果她不是精神错乱国王的女儿，我同意你的看法，但事实证明她太危险了，不能活着。""",
	PRE_ANASTASIA_EXECUTION_9 = """— 直到稍后.""",
	PRE_ANASTASIA_EXECUTION_10 = """— 同意，但我们不能简单地把她干掉。至少不能靠我们自己。一定要来。""",
	PRE_ANASTASIA_EXECUTION_11 = """行会领袖和地主们再次聚集在一起，现在主要是为了庆祝即将到来的战争结局，因为战争已经获胜。

{color=aqua|邓肯: — 正如许多人已经听说的那样，叛逆的公主终于被[name]抓住了，根据[his]成就，他将担任下一任市长。今天，我们，行会领袖，决定公主的命运。 }

{color=yellow|梅尔: — 大家都知道，她挑起了内战，导致了许多人的生命和财产损失...}""",
	PRE_ANASTASIA_EXECUTION_12 = """{color=aqua|西格蒙德: — 真的很在乎你的魔法玩具，哈。法师总是那么商业化吗？ }

{color=yellow|梅尔: — 现在不是说这个的时候，而且你不是前线的人，为这场毫无意义的战争耗尽了你的补给。 }

{color=aqua|西格蒙德: — 哈.}""",
	PRE_ANASTASIA_EXECUTION_13 = """{color=aqua|邓肯: — 她发起的战争削弱了我们，我们很幸运，帝国没有采取行动。}

{color=yellow|阿米莉亚: — 嗯，根据我的消息来源，她和叛军大多由国王的骑士格雷格控制。}

{color=aqua|邓肯: — ...这不能成为她参与其中的借口。}

{color=yellow|阿米莉亚: — 不过，她可能并不像你想象的那样危险。她不是被误导了吗？}""",
	PRE_ANASTASIA_EXECUTION_14 = """{color=aqua|邓肯: — 胡说八道。没有她的存在就不会有叛乱。这就是为什么我们今天要判处她死刑。}

{color=yellow|阿米莉亚: — 我想，你希望她死吧？}

{color=aqua|邓肯: — 当然.}""",
	PRE_ANASTASIA_EXECUTION_15 = """{color=aqua|梅尔: — 我同意。这个女孩只是一个累赘。我们越早结束越好。}

{color=yellow|西格蒙德: — 我不能说我喜欢死亡，但我们有什么选择？}

{color=aqua|梅尔: — 哇哦，矮人的石头脑袋开窍了}

西格蒙德似乎没有意识到这种侮辱，或者可能没有注意到。""",
	PRE_ANASTASIA_EXECUTION_16 = """{color=aqua|阿米莉亚: — 啊，太悲惨了。我们的选票没有权力吗？}

{color=yellow|邓肯: — 没有，因为我们三个人已经同意了。}

{color=aqua|阿米莉亚: — 一个残酷的命运降临在年轻的少女身上，真的没有什么可做的…？}""",
	PRE_ANASTASIA_EXECUTION_OPTION_9 = """我希望她活着""",
	PRE_ANASTASIA_EXECUTION_OPTION_10 = """*保持沉默*""",
	PRE_ANASTASIA_EXECUTION_19 = """除阿米莉亚外，所有公会首领都转过身来向你扬起眉毛。

{color=aqua|阿米莉亚: — 我们未来的市长如此仁慈，这不是令人耳目一新吗？}

{color=yellow|邓肯: — 你在说什么？我们不能冒险让她活着，你知道的。你的目标是什么？}""",
	PRE_ANASTASIA_EXECUTION_OPTION_11 = """我会让她成为我的妻子""",
	PRE_ANASTASIA_EXECUTION_OPTION_12 = """我想让她成为我的奴隶""",
	PRE_ANASTASIA_EXECUTION_20 = """这句离谱的话甚至让阿米莉亚看起来很惊讶。

{color=aqua|邓肯: — 你不是认真的吧...}

{color=yellow|梅尔: — 我也不敢相信.}""",
	PRE_ANASTASIA_EXECUTION_21 = """{color=aqua|阿米莉亚: — 一个真正的男人，既是征服者又是情人。吟游诗人会唱这首歌，很多女人都会为这个故事着迷。 }

{color=yellow|邓肯: — 别胡说八道了，你可能已经赢得了足够的声誉，可以成为市长，但嫁给一位前反叛公主是荒谬的。 }

{color=aqua|阿米莉亚: — 实际上我不这么认为。}

{color=yellow|邓肯: — 什么?}

{color=aqua|阿米莉亚: — 考虑一下，如果我们让公主嫁给我们的市长并公开承认我们的政权，会怎么样？这样她不会比处决她更有用吗？此外，许多反叛分子会认为她是合法的共同统治者，而她当然没有权力。}

{color=yellow|邓肯: — 那…永远不会发生。}""",
	PRE_ANASTASIA_EXECUTION_22 = """{color=aqua|阿米莉亚: — 好吧，你永远不知道一个女孩的心会迷失在哪里。我认为总比把这么年轻的美女处死要好。}

当人们开始为这个新想法争论时，会议一片骚动。""",
	PRE_ANASTASIA_EXECUTION_23 = """{color=aqua|梅尔: — 嗯，如果是[name]，我想[he]可能会成功。 }

{color=yellow|西格蒙德: — 我觉得没问题，我们信任[name]。}""",
	PRE_ANASTASIA_EXECUTION_24 = """作为少数派，邓肯沉默了一段时间，因为房间里的大多数人都认为你的提议是合理的。

{color=aqua|邓肯: — 很好。如果[name]真的能说服公主公开承认我们的政权，那么只要她的地位是奴隶，就把她留在身边没有什么害处。即使是作为…[his]妻子。 }

{color=yellow|阿米莉亚: — 我怀疑这一点都不容易，[name]。但我相信你会想到办法的。 }

{color=aqua|邓肯: — 如果你失败了，她将按计划被处决。在这两种情况发生之前，你的选举将被搁置。

邓肯: — 会议到此结束.}""",
	PRE_ANASTASIA_EXECUTION_25 = """{color=aqua|阿米莉亚: — 一个有威望的人也应该追求崇高的目标，是吗？一个前公主作为私人奴隶这种事难得一见。}

{color=yellow|邓肯: — 我钦佩你的雄心，但这对你来说也太过分了。如果她成功逃脱，她的地位将允许她领导另一场叛乱，甚至更激烈。}

{color=aqua|阿米莉亚: — 我知道你担心什么，但想想看，如果她宣布接受我们的机构，并要求叛军解散，对我们来说会更好。}

{color=yellow|邓肯: — 她没有表现出合作的意愿，所以我很难相信。}

{color=aqua|阿米莉亚: — 我相信我们未来的市长已经证明了他有能力做大事。那么我们为什么不试试呢？}""",
	PRE_ANASTASIA_EXECUTION_26 = """{color=aqua|梅尔: — 嗯，如果是[name]，我想[he]可能会成功。 }

{color=yellow|西格蒙德: — 是的，我同意。也没有必要匆忙行事。}""",
	PRE_ANASTASIA_EXECUTION_27 = """{color=aqua|邓肯: — ...很好。你可以试着说服她。但如果你失败了，她将按计划被处决。在这两种情况发生之前，你的选举将被搁置。}""",
	PRE_ANASTASIA_EXECUTION_28 = """{color=aqua|邓肯: — 那么，我们已经决定了。处决将在下周举行。之后我们将任命市长。感谢您的工作。}""",

	MIND_CONTROL_1 = """— 好吧，谁能想到你会如此雄心勃勃，亲自去抓公主呢。但我向你保证，这并不容易。邓肯说她完全不愿意合作，因为她认为我们只是邪恶的。

— 为了说服她，你必须竭尽全力。我给你一点建议。利用她的天真和责任感。她仍然坚信自己对每个人的生活负责。但如果你实在不行，也可以尝试一种不那么复杂的方法。""",
	MIND_CONTROL_OPTION_1 = """有什么方法?""",
	MIND_CONTROL_OPTION_2 = """你的意思是折磨""",
	MIND_CONTROL_2 = """— 不，不，折磨对她没有作用，如果有什么不同的话，那可能会让事情变得更糟，她可能会变得更加顽固，导致死亡。""",
	MIND_CONTROL_3 = """— 有一些强制控制的做法。我观察到一种魔法的技巧，可以让目标的思想完全屈从于另一个人的意愿。然后主人可以发布任何命令，但最终奴隶自己的个性所剩无几。

— 用不用这样的东西嘛，你自己考虑。我相信，如果你客气一点，梅尔会给你指明正确的方向。""",
	MIND_CONTROL_OPTION_3 = """感谢您的提示""",
	MIND_CONTROL_OPTION_4 = """我不想做这样的事情""",
	MIND_CONTROL_4 = """— 祝你在计划中取得成功。""",
	MIND_CONTROL_5 = """— 我也不会，一个心甘情愿的仆人总是最好的。我只是想确保你知道这是一个选择。根据你的意愿使用这些信息。""",
	MIND_CONTROL_OPTION_5 = """关于公主...""",
	MIND_CONTROL_6 = """— 是的，你的谈判进展如何？""",
	MIND_CONTROL_OPTION_6 = """我觉得不值得""",
	MIND_CONTROL_OPTION_7 = """还在尝试""",
	MIND_CONTROL_7 = """— 那么你同意处决她?""",
	MIND_CONTROL_8 = """— 真遗憾你没有成功。处决将在一周后举行。""",
	MIND_CONTROL_OPTION_8 = """询问精神控制技巧""",
	MIND_CONTROL_9 = """— 精神控制？我们对此并不感兴趣。这是一种更受狡猾的猫咪和她的行会欢迎的方法。""",
	MIND_CONTROL_OPTION_9 = """但你肯定知道一些事情""",
	MIND_CONTROL_OPTION_10 = """您的帮助将是无价之宝""",
	MIND_CONTROL_10 = """— *叹气*找扎里试试，我相信她已经涉猎过了。只是不要对其他功能有任何奇怪的想法。""",
	MIND_CONTROL_11 = """— 嘿, [name], 怎么了?""",
	MIND_CONTROL_12 = """有人告诉我，你可以帮助我掌握精神控制技巧""",
	MIND_CONTROL_13 = """只是想打个招呼*离开*""",
	MIND_CONTROL_14 = """— 嗯？我已经很久没有人问过这个了。

扎里花了很长时间思考你的请求。

--我现在急需金币，而且这种施展魔法很辛苦，还有我觉得做这件事不对……我可以为了5000金币做一次。但这将是唯一一次，这是我的报价。要么接受，要么离开""",
	MIND_CONTROL_OPTION_11 = """*支付*""",
	MIND_CONTROL_OPTION_12 = """我会考虑的 """,
	MIND_CONTROL_15 = """你向扎里支付了巨款.

— 好吧，让我准备一下.""",
	MIND_CONTROL_16 = """几个小时后，扎里拿出一小瓶亮粉色液体.

— 终于完成了。这种药剂会不可逆转地压制目标的意志。最后一件事，你需要一个介质来充当控制设备。""",
	MIND_CONTROL_OPTION_13 = """*给她手镯*""",
	MIND_CONTROL_17 = """你交出了公主的手镯，就是用来找到她的那个。.

— 哦，这个一定很贵。好吧.

当手镯和药水散发着黑暗的光环时，她吟唱着一个控制咒语。""",
	MIND_CONTROL_18 = """— 完成了。让受害者喝下这个，然后把手镯戴在他们身上，这样你就可以指挥他们了。重复一次，他们的思想就会永久性崩溃。不要让我来解除效果，我做不到。""",
	MIND_CONTROL_OPTION_14 = """谢谢""",
	MIND_CONTROL_OPTION_15 = """留意""",
	MIND_CONTROL_19 = """— 好的，等一下.

扎里从她的收藏物中取出一个小戒指。当她吟唱控制咒语时，戒指和药剂散发出黑暗的光环。""",
	MIND_CONTROL_20 = """— 完成了。让受害者喝下这个，然后把手镯戴在他们身上，这样你就可以指挥他们了。重复一次，他们的思想就会永久性崩溃。不要让我来解除效果，我做不到。""",



	ANASTASIA_EXECUTION_1 = """一周后。阿利隆的市民聚集在主广场等待阿纳斯塔西娅的处决。一个为这个场合准备的凸起平台周围的柱子之间挂着一块窗帘。尽管情绪矛盾，阿米莉亚还是邀请了你。


— 嘿，今天天气不好吗？对于这样一个悲伤的事件来说，也许有点太好了。但振作起来，你很快就会成为市长。让公众看到你的形象是很重要的。""",
	ANASTASIA_EXECUTION_OPTION_1 = """我认为我不应该对某人的处决感到高兴""",
	ANASTASIA_EXECUTION_OPTION_2 = """我很好，至少已经结束了""",
	ANASTASIA_EXECUTION_2 = """— 好吧，也许情况不会那么糟糕。

阿米莉亚神秘地对你微笑。""",
	ANASTASIA_EXECUTION_3 = """— 这就是气场。毕竟，我们有最好的位置，所以如果无聊的话，我们可以很容易地离开。""",
	ANASTASIA_EXECUTION_4 = """

哦，看，就要开始了。""",
	ANASTASIA_EXECUTION_5 = """在阿利隆的主广场上，一个大平台被搭建起来，周围挂着一块窗帘。一大早，一群市民开始聚集，人们对阿纳斯塔西娅的处决方法有很多兴奋的猜测。

行会领袖们到了，在你旁边就座，人群中弥漫着期待的寂静。平台中央周围的窗帘被拉下，当看到一个全裸的阿纳斯塔西娅弯下腰，头和手被困在一堆木头堆里时，聚集的市民发出了呼喊。她沉重的乳房在早晨凉爽的空气中自由摆动。

当数百只眼睛盯着公主时，公主的脸涨得通红，审视着她赤裸和手无寸铁的身体的每一寸。一个带着长卷的传令员站在她旁边，开始详细宣布她的许多罪行，持续了几分钟，公主无助地扭动着。 """,
	ANASTASIA_EXECUTION_6 = """{color=yellow|传令员: — ...反叛的公主阿纳斯塔西娅被判犯有这些罪行，被判处...}

传令员停顿了一下以达到戏剧性的效果。

{color=yellow|传令员: — ... 一场旷日持久的公开羞辱。她将以她童贞的身体为她对我们美丽城市犯下的罪行付出代价。每个公民都应该在他们认为合适的时候使用她。我们的治疗师随时准备，以防造成严重的身体伤害。}

{color=yellow|阿纳斯塔西娅: — 什么...?}

公主的脸上充满了恐惧和困惑，试图决定她是否应该为自己的生命得以幸免而感到高兴，或者她是否更愿意被处决而不是即将到来的残酷堕落。当一群变态的欢呼声从人群中响起时，她的眼里噙满了泪水

平台脚下开始排起了一条长长的、不守规矩的队伍，城市里的男人们相互推搡，肩并肩地走到最前面。城管很难维持秩序，阻止他们向站台移动。""",
	ANASTASIA_EXECUTION_7 = """在你身边，阿米莉亚对公主被征服的场面咯咯地笑着。

{color=yellow|阿米莉亚: — 嗯，这不是比无聊的斩首更有趣吗？你知道吗，我为自己的天才想法感到骄傲。}

你惊讶地转向阿米莉亚，暂时地从裸体公主上转移了注意力。

{color=yellow|阿米莉亚: — 别看起来那么震惊！我只是说服邓肯和其他人，在这之后，没有人会再接受她为皇室成员。她会被侮辱，安全。无论如何，从身体上来说，不能保证她在被城市里的每一只阴茎性交后会处于什么状态...}

在平台上，第一个男人爬上楼梯，用他肮脏的手指检查公主的处女阴部，人群发出嘘声和嘲笑。阿纳斯塔西娅把大腿挤在一起，这是一次注定要失败的尝试，目的是阻止男人粗暴地检查她未使用的阴部。这名男子强行用一根手指捅了她的肛门，让公主痛苦地尖叫起来。""",
	ANASTASIA_EXECUTION_OPTION_3 = """不错的主意""",
	ANASTASIA_EXECUTION_OPTION_4 = """情况更糟，提醒我永远不要惹你生气""",
	ANASTASIA_EXECUTION_OPTION_5 = """听起来不太令人信服""",
	ANASTASIA_EXECUTION_8 = """{color=aqua|阿米莉亚: — 我确实说过我可怜她，不是吗？这也很有趣。}""",
	ANASTASIA_EXECUTION_9 = """{color=aqua|阿米莉亚: — *咯咯笑*好吧，我不能接受所有的功劳。有没有想过有多少地主、富人和贵族希望与唯一的公主分道扬镳？在这种想法在他们心中扎根后，我们设法在创纪录的时间内将此事付诸表决。不过，这些第一批人本可以更好地伪装自己。}""",
	ANASTASIA_EXECUTION_10 = """{color=aqua|阿米莉亚: — 不相信，是吗？尽管如此，这实际上是她的选择。昨天，我告诉她，她将受到无法弥补的羞辱，而不是被处决，我为她提供了一种无痛地结束生命的方法，但她没有接受，让我有点意外。我知道不止一个女人不介意取代她的位置，前提是不会有任何后果。}""",
	ANASTASIA_EXECUTION_11 = """当他脏兮兮的手指还在阿纳斯塔西娅的体内里时，这个男人粗暴地踢她的腿，迫使她分开腿。公主哭着扭动，因为她紧绷的括约肌被侵犯了。当这个男人把他那只大阴茎从裤子里拔出来，开始用它摩擦她柔软的大腿时，人群期待地咆哮起来。

{color=yellow|公民: — ：你他妈的婊子，我弟弟在你发动的战争中牺牲了！

{color=yellow|阿纳斯塔西娅: — 对不起！求你了，不要！不要伤害我！}

{color=yellow|公民: — 太晚了，婊子养的公主。报应已经到了。}

这个男人野蛮地打着阿纳斯塔西娅的圆屁股，直到她的屁股又红又痛。她大叫一声，屁股拼命扭动以躲避他的残酷打击，这让大笑的人群更加兴奋。

{color=yellow|公民: — 哈，兴奋起来了是吗？为你的耻辱做好准备了吗？}

{color=yellow|阿纳斯塔西娅: — 唏……可以和解吗……我还是处女！}

当公主绝望地恳求时，广场上响起了灿烂的笑声。 """,
	ANASTASIA_EXECUTION_12 = """{color=yellow|公民: — 此时此刻！？婊子养的公主，你不是在说笑吧？。不是每天都有像我这样的平民可以拿下王室血统的贞洁。如果我不这样做，还有一百个人在等着，所以你最好习惯这个想法。}

这名男子抓住阿纳斯塔西娅的屁股，当他打开她的阴部时，他的指甲残忍地陷进了她柔软的肉里。他朝她的婊子吐口水，引来人群的另一声怒吼。阿纳斯塔西娅的头在枷锁里扭来扭去，想看看身后那个男人的脸，但她的金色长发挡住了去路。那个男人把他的阴茎按在她的阴部，把它抵在那里。

{color=yellow|公民: — 这是给我弟弟哈拉尔的，你这个婊子，我希望他在看.}

当公主因为被侵犯而尖叫时，这名男子强行将他的阴茎撞向她，刺穿了她的处女膜。当这位身材魁梧的平民夺走了公主的童贞，暴力强奸了她流血的阴部，而她在痛苦和耻辱中嚎叫时，人群欣喜若狂。 """,
	DUNCANS_DECLARATION_START = """人群聚集在广场上等待战争结束的消息。邓肯站在政府大楼的阳台上。他宣布叛军领导人最终被击败并受到相应的惩罚。人们欢欣鼓舞。

— 没有人能否认 [Sir] [name] [surname] 的努力对确保我们的胜利起到了多么重要的作用。由于[his]成就，他被授予阿利隆市长的职位。""",
	ANASTASIA_EXECUTION_13 = """没过多久，这名男子就即将高潮，抓住她纤细的腰部，在种子喷发的时候把阴茎深深地插了进去。他转向人群鞠躬，随着精液顺着阿纳斯塔西娅的腿流下，引来了暴徒的又一次喧闹欢呼。.. 

{color=yellow|阿米莉亚: — 我有没有说过我可怜她？真的那种？啧啧啧，可怜的家伙。但这比看有趣多了。}

你转身看到阿米莉亚一只手搭在裙子上，夹在两腿之间。她的手臂有节奏地抽搐。

{color=yellow|阿米莉亚: — 你知道，如果你打算参加，你可能想在她被搞得一团糟之前进去。我认为她在第一个小时左右之后不会有多有趣。}

第二个人爬上了平台。他转过身来看着公主，抓住她的头发，抬起她的头。

{color=yellow|公民 2: — 你好，公主，我们为什么不用你漂亮的嘴呢？你还有很多工作要做，直到你让我们都满意为止。}""",
	ANASTASIA_EXECUTION_14 = """阿纳斯塔西娅没有找到任何反对的词语，任由人群中的变态摆布。

这名男子从裤子里拽出他那只无力的阴茎，把它推到阿纳斯塔西娅的脸上。她很快就把它含在嘴里，急切地舔着他，吮吸着他，让观众高兴不已。她一闻到农民未洗阴茎的味道就作呕，但当他抓住她的头发时，他的阴茎很快就僵硬了，塞进了她的喉咙。

当她困惑地看着他时，他把公鸡从她吮吸的嘴里拔了出来。他在她身后走来走去... """,
	ANASTASIA_EXECUTION_15 = """几个小时后，阿纳斯塔西娅几乎不像那个几乎推翻阿利隆行会的精力充沛的公主。她曾经光滑的皮肤被鞭打和殴打，直到遍体鳞伤，全身都沾满了该市数十名男子的混合精液。治疗师多次介入，将她从疯狂或昏迷中拯救出来。

虐待她的队伍几乎没有缩小，其中几个已经很高兴再次加入。阿纳斯塔西娅的哭泣和恳求已经被粗糙的抽泣和偶尔的痛苦呻吟所取代，因为另一个男人穿过了她那被毁坏的阴部或屁股。人群的欢呼声稳定下来，形成了一种规律的节奏。

阿纳斯塔西娅在主广场上展出了一周，在这段时间里，她从来没有休息过。她被这个城市的每一个男人当作任何挑战行会的人的榜样。最终，她被殴打和侵犯的身体从枷锁中消失了。 """,

	ANASTASIA_PERSUASION_1 = """你走进一间相当舒适的牢房，里面关押着一名未受约束的囚犯：叛乱的前领导人阿纳斯塔西娅公主。尽管她的状态很好，但她还是用犀利的目光观察着你，但仍然保持沉默。她到达后似乎并没有受到真正的折磨或审问，但这几乎没有必要。""",
	ANASTASIA_PERSUASION_OPTION_1 = """招募""",
	ANASTASIA_PERSUASION_OPTION_2 = """精神控制""",
	ANASTASIA_PERSUASION_2 = """在阿纳斯塔西娅意识到发生了什么之前，你把扎里的药剂从你的袋子里拿出来，强行倒进她的嘴里。当她挣扎的时候，你按住她，盖住她的口鼻，确保她吞下它。她的身材太小，无法抵抗，更不用说反击了。

当你完事的时候，她倒在地上咳嗽不止，紧紧抓住喉咙。她的眼睛最后一次对你表现出恐惧和仇恨，仍然没有完全意识到她身上发生了什么。过了一会儿，她失去了知觉。
""",
	ANASTASIA_PERSUASION_3 = """你把施了魔法的手镯套在她的手腕上，那是她不久前珍藏并丢失的手镯。手镯亮了一会儿，然后收缩，无法取出。""",
	ANASTASIA_PERSUASION_4 = """你把施了魔法的手镯套在她的手腕上，那是她不久前珍藏并丢失的手镯。手镯亮了一会儿，然后收缩，无法取出。""",
	ANASTASIA_PERSUASION_5 = """过了一分钟，公主开始移动，慢慢地站了起来。她的眼睛失去了意识，她几乎无法把注意力集中在站在她面前的你身上。当你给她几个简单的命令，她照单执行时，你的工作完成了。""",
	ANASTASIA_PERSUASION_OPTION_3 = """您好，公主""",
	ANASTASIA_PERSUASION_OPTION_4 = """别这样敌视我，我是你的朋友""",
	ANASTASIA_PERSUASION_OPTION_5 = """那个房间对你这样的渣滓来说太好了""",
	ANASTASIA_PERSUASION_6 = """— ...你想要什么？""",
	ANASTASIA_PERSUASION_7 = """— 如果你的友谊是真诚的，那么你必须让我离开这里。""",
	ANASTASIA_PERSUASION_8 = """— 嗯。我没有选择这个房间。把我放在你想放的任何地方，我的态度都不会改变。""",
	ANASTASIA_PERSUASION_9 = """— 我知道无论我做什么，我都会很快被处决，你想要什么？ """,
	ANASTASIA_PERSUASION_OPTION_6 = """我想救你""",
	ANASTASIA_PERSUASION_OPTION_7 = """你真的准备好放弃你的生命了吗？""",
	ANASTASIA_PERSUASION_OPTION_8 = """你的判决还未定下来""",
	ANASTASIA_PERSUASION_10 = """尽管阿纳斯塔西娅努力否认这种可能性，但她的眼中还是出现了希望的火花。她可能表现得已经做好了死亡的准备，但毕竟她想活下去。

— 我知道你在撒谎。我现在还有什么别的命运呢？""",
	ANASTASIA_PERSUASION_11 = """— 我的准备无法改变这种情况。你为什么来？""",
	ANASTASIA_PERSUASION_12 = """— 我的处决是从我父亲被处决的那天起就计划好的。你认为我是个傻瓜吗？""",
	ANASTASIA_PERSUASION_OPTION_9 = """有办法拯救你""",
	ANASTASIA_PERSUASION_OPTION_10 = """我已经为你的赦免进行了协商""",
	ANASTASIA_PERSUASION_13 = """你告诉公主，要想获救，她必须遵守行会的规定并公开支持他们。然而，她的反应完全被这个想法激怒了。

— 这是胡说八道，这些人从我七岁起就一直在追杀我。现在你说我可以被赦免。你是谁，我应该相信你的话？""",
	ANASTASIA_PERSUASION_OPTION_11 = """我是这个城市的下一任市长""",
	ANASTASIA_PERSUASION_OPTION_12 = """我做了很多事情，包括把你交给他们""",
	ANASTASIA_PERSUASION_14 = """阿纳斯塔西娅听到后沉默了。她没有理由怀疑你，但她仍然犹豫着是否抱有希望。

— 这不可能是他们对我唯一的期望，还有更多，不是吗？""",
	ANASTASIA_PERSUASION_OPTION_13 = """我会请你帮忙，但你真的没有拒绝我的选择权""",
	ANASTASIA_PERSUASION_OPTION_14 = """你必须嫁给我 """,
	ANASTASIA_PERSUASION_OPTION_15 = """你也将成为我的财产""",
	ANASTASIA_PERSUASION_OPTION_16 = """你的命运将掌握在我手中""",
	ANASTASIA_PERSUASION_15 = """阿纳斯塔西娅明显脸红了。她本以为最终会根据自己的身份出于政治目的而结婚，但她从未想过这种情况会成为一种选择。

— 这太荒谬了。我为什么要嫁给绑架我的人？""",
	ANASTASIA_PERSUASION_OPTION_17 = """我的感情是真诚的""",
	ANASTASIA_PERSUASION_OPTION_18 = """你可能会做得更糟，难道我还没有证明自己有能力吗？""",
	ANASTASIA_PERSUASION_OPTION_19 = """你真的有其他选择吗？""",
	ANASTASIA_PERSUASION_16 = """阿纳斯塔西娅脸红得更厉害了，显然她没有处理这种情况的经验，但她仍然保持着一副皇室的面孔。

— 即使这是真的，我也没有理由接受杀害我父亲的凶手的要求。""",
	ANASTASIA_PERSUASION_17 = """阿纳斯塔西娅停下来评估和重新评估你和你的陈述。然而，她没有准备好妥协，而是保持着皇室的风度。

— 无论如何，我没有理由接受杀害我父亲的凶手的要求。""",
	ANASTASIA_PERSUASION_18 = """— 嗯，我没有理由接受杀害我父亲的凶手的要求。""",
	ANASTASIA_PERSUASION_19 = """— 哼，变成了一个玩物。我为什么要接受这样的命运？""",
	ANASTASIA_PERSUASION_OPTION_20 = """我保证公平对待你""",
	ANASTASIA_PERSUASION_OPTION_21 = """你宁愿死？""",
	ANASTASIA_PERSUASION_OPTION_22 = """这是你剩下的最佳选项""",
	ANASTASIA_PERSUASION_20 = """阿纳斯塔西娅沉默了大约半分钟。悲伤和疲惫在她的脸上隐隐作痛，但她似乎并不完全反对这种可能性。""",
	ANASTASIA_PERSUASION_21 = """

— 他们不是说站着死总比跪着活好吗？""",
	ANASTASIA_PERSUASION_22 = """

— 无论如何，我没有理由接受杀害我父亲的凶手的要求""",
	ANASTASIA_PERSUASION_OPTION_23 = """我对你的损失感到抱歉，但你现在必须为自己着想""",
	ANASTASIA_PERSUASION_OPTION_24 = """你有某种恋父情结吗？""",
	ANASTASIA_PERSUASION_OPTION_25 = """固执现在对你没有好处""",
	ANASTASIA_PERSUASION_23 = """— 如果你真的这么想，那么你就会明白为什么我不能赦免杀害我父亲的凶手。""",
	ANASTASIA_PERSUASION_24 = """— 闭嘴!""",
	ANASTASIA_PERSUASION_25 = """— 你不明白.""",
	ANASTASIA_PERSUASION_26 = """我父亲被杀后，我一直被迫生活在逃亡和恐惧中。我们做了什么值得这样做？""",
	ANASTASIA_PERSUASION_27 = """阿米莉亚几乎无声地出现在房间里，向你示意她要帮助你。

{color=yellow|阿米莉亚: — 请允许我打扰一下，只要你愿意相信我的话，我就可以解释。阿尔贝国王冷酷无情。}

{color=aqua|阿纳斯塔西娅: — 你撒谎！父亲总是对我好}

{color=yellow|阿米莉亚: — 我没有理由撒谎，他早在我还没到可以从他的去世中受益的年龄就已经去世了。他可能对他的亲人很好，但对他的臣民却不好。 }

{color=aqua|阿纳斯塔西娅: — ...}""",
	ANASTASIA_PERSUASION_28 = """{color=yellow|阿米莉亚: — 你听说过布罗德里克家族吗？李·布罗德里克是一个成功的商人，但有一天他把一本书作为礼物送给了国王。国王一读这本书，就认为这是一种隐藏的侮辱，甚至是一种诅咒。他的家人和孩子们被一个接一个地判处绞刑。有些人设法逃跑，但被抓住了，他们的同伙被处以绞刑。}

{color=aqua|阿纳斯塔西娅: — ...}

{color=yellow|阿米莉亚: — 有一个小宗教派别被命令放弃信仰或离开这座城市。他们拒绝了，在城市广场被活活烧死。我们不要忘记那些倒霉的妓女每隔几个月就会被鞭打致死。这一点，我已经亲眼见过两次了}""",
	ANASTASIA_PERSUASION_29 = """{color=aqua|阿纳斯塔西娅: — 够了...}

{color=yellow|阿米莉亚: — “叔叔”格雷格没有告诉你这些吗? }

{color=aqua|阿纳斯塔西娅: — 没有.}

阿纳斯塔西娅低着眼睛，流露出一种忧郁的神情。

{color=yellow|阿米莉亚: — 我不怪你，每个孩子都想为自己的父母感到骄傲，但这不应该让你盲目}

{color=aqua|阿纳斯塔西娅: — 如果我一直都错了……这场战争有什么意义？我一直相信我在为人民尽最大努力。}""",
	ANASTASIA_PERSUASION_OPTION_26 = """您试图做您认为正确的事情""",
	ANASTASIA_PERSUASION_OPTION_27 = """你错了，是时候弥补了""",
	ANASTASIA_PERSUASION_OPTION_28 = """停止无用的抱怨""",
	ANASTASIA_PERSUASION_30 = """{color=aqua|阿纳斯塔西娅: — 我觉得我现在没有任何权利为任何人做出选择。}""",
	ANASTASIA_PERSUASION_OPTION_29 = """如果有什么不同的话，你仍然可以帮助人们而不是死亡""",
	ANASTASIA_PERSUASION_OPTION_30 = """这是你的错，但你可以通过帮助我们来救赎自己。你所要做的就是投降并承认我们的政权""",
	ANASTASIA_PERSUASION_OPTION_31 = """如果您合作，您的罪行仍然可以得到赦免""",
	ANASTASIA_PERSUASION_31 = """{color=aqua|阿纳斯塔西娅: — .....对不起，请暂时别打扰我，我需要一些时间思考。}

阿米莉亚示意你遵守这个要求，然后你们都离开了房间。""",
	ANASTASIA_PERSUASION_32 = """— 她的外壳已经碎裂，但只有你明天设法说服她，我们才会知道结果。""",
	ANASTASIA_PERSUASION_OPTION_32 = """感谢您的帮助""",
	ANASTASIA_PERSUASION_OPTION_33 = """你给人留下了深刻印象""",
	ANASTASIA_PERSUASION_33 = """— 不客气，我自己也玩得很开心。""",
	ANASTASIA_PERSUASION_34 = """— 哈哈，我当然是，你认为我是谁？我不是靠一对大奶头才在仆人行会中获得职位的。""",
	ANASTASIA_PERSUASION_35 = """

— 我们仍然囚禁着她的小精灵仆人艾尔。如果你认为这可能有助于我们的事业，我们可以安排他们下次会面。""",
	ANASTASIA_PERSUASION_OPTION_34 = """当然，这可能会让她的思维不局限于自己""",
	ANASTASIA_PERSUASION_OPTION_35 = """不，这可能只会让事情变得更困难""",
	ANASTASIA_PERSUASION_36 = """— 好吧，我看看能做些什么。希望你不要把她惹得太生气，否则她可能会成为一个讨厌的人。""",
	ANASTASIA_PERSUASION_37 = """

— 你的决定，你可能会在某个时候对她做点什么。""",
	ANASTASIA_PERSUASION_38 = """

— 直到那时。

阿米莉亚给你一个顽皮的微笑，然后离开去做她的事""",
	ANASTASIA_PERSUASION_39 = """你进入公主的牢房。她看起来精神比你把她留在牢房时要好。她一定下定决心了。""",
	ANASTASIA_PERSUASION_40 = """— 你好, [name]。我已经做出了决定。很抱歉，但经过思考，无论如何我都不能站在行会一边。我将光荣地接受我的命运。""",
	ANASTASIA_PERSUASION_40_1 = """
	
你意识到在这一点上你无法改变阿纳斯塔西娅的想法，所以你唯一的选择就是离开。""",
	ANASTASIA_PERSUASION_41 = """你离开牢房，发现阿米莉亚在等你。

— 拒绝，嗯。太糟糕了。我想我们现在没有那么多选择了。好吧，你会知道在哪里可以找到我的""",
	ANASTASIA_PERSUASION_42 = """

— 你好, [name]... 我想了很多。我认为你是对的。我不应该放弃我的生命。我…我想我可以承认行会并为我的行为求饶，但我仍然不确定我是否应该成为你的。""",
	ANASTASIA_PERSUASION_OPTION_36 = """我想让你和你的朋友团聚（呼叫艾尔）""",
	ANASTASIA_PERSUASION_OPTION_37 = """我要把一些东西还你""",
	ANASTASIA_PERSUASION_OPTION_38 = """最终我们必须达成协议""",
	ANASTASIA_PERSUASION_OPTION_39 = """我晚点回来""",
	ANASTASIA_PERSUASION_43 = """阿纳斯塔西娅困惑地看着你。几分钟后，警卫在阿米莉亚的命令下护送精灵女孩到牢房。

{color=aqua|Anastasia: — 艾尔…？你还活着！}

{color=yellow|艾尔: — 安娜...}

在接下来的几秒钟里，两个女孩轻轻地拥抱着哭泣。然而，两人都意识到他们的重聚不会持续太久。

{color=aqua|阿纳斯塔西娅: — 你看起来……疲惫不堪。}

{color=yellow|艾尔: — 别担心，我很好。我经历过更糟糕的事情。}""",
	ANASTASIA_PERSUASION_44 = """艾尔转向你，你仍然可以从她的眼中看到仇恨。

{color=yellow|艾尔: — 对不起，这个人没有荣誉。你永远不应该落入[his]手中。 }

{color=aqua|阿纳斯塔西娅: — 什么……为什么？ }

{color=yellow|艾尔: — 对不起，但请相信我。[he]只是一头野兽。我不相信[he]会对你有任何尊重

阿纳斯塔西娅保持沉默，分析她朋友的话。看来她对你的信任受到了很大的打击。

再交流几次后，艾尔被警卫带走了。公主恢复了镇静，驱散了笼罩在她脸上的希望和悲伤。""",
	ANASTASIA_PERSUASION_45 = """当艾尔离开房间时，阿纳斯塔西娅保持沉默。""",
	ANASTASIA_PERSUASION_46 = """艾尔转向你。她的脸上流露出困惑和对你的尊重。

{color=aqua|阿纳斯塔西娅: — 艾尔……我被说服了。我的意思是这个人提议我成为[his]财产，以换取我的生命。}

{color=yellow|艾尔: — 结果就是这样... }

艾尔沉思着深深地叹了口气。""",
	ANASTASIA_PERSUASION_47 = """{color=yellow|艾尔: — 我请求你自救。这个人虽然曾经是我们的敌人，但却是我认识的为数不多的真正值得尊敬的人之一。如果[he]设法为你的生命进行谈判，我想你应该抓住这个机会。}

{color=aqua|阿纳斯塔西娅: — 你为这样的人背书是不寻常的。}

{color=yellow|艾尔: — 是的，但是。。。你现在不能死。你是我所认识的最善良的人}""",
	ANASTASIA_PERSUASION_48 = """

{color=yellow|艾尔: — 我不能说我为这个人担保，但到目前为止，[he]对我很公平。如果[he]设法为你的生命进行谈判，我认为你应该接受这个机会}""",
	ANASTASIA_PERSUASION_49 = """

{color=aqua|阿纳斯塔西娅: — 艾尔，但你知道，我从来没有。。。如果我不能成为[he]所要求的那样呢？}

{color=yellow|艾尔: — 我想你做得到，毕竟你很优雅漂亮.}

...再聊了几分钟，艾尔终于被带走了.""",
	ANASTASIA_PERSUASION_50 = """— 谢谢你让我和她见面，你太慷慨了。.""",
	ANASTASIA_PERSUASION_51 = """你把在废弃基地找到的手镯递给阿纳斯塔西娅。

— 这是…我以为我丢了。你从哪里得到的？你一路回到藏身处...

— 谢谢。这个手镯是我父亲送给我的礼物。我知道，他不是一个好国王，但是。。。这些年来，它一直是我唯一的纪念品。""",
	ANASTASIA_PERSUASION_52 = """— 我知道，但我真的不知道我是否能信任你。""",
	ANASTASIA_PERSUASION_OPTION_40 = """我保证你会得到爱""",
	ANASTASIA_PERSUASION_OPTION_41 = """我保证会有尊严地对待你""",
	ANASTASIA_PERSUASION_OPTION_42 = """你的需求将得到满足，你还能要求什么？""",
	ANASTASIA_PERSUASION_53 = """阿纳斯塔西娅盯着墙，权衡着你的话。""",
	ANASTASIA_PERSUASION_54 = """

— 对不起，我不能同意你的建议。我不能强迫自己接受你做我的[master]。现在走吧，我知道等待我的是什么，我已经做好了准备。""",
	ANASTASIA_PERSUASION_55 = """你离开牢房，发现阿米莉亚在等你。

— 被拒绝了，嗯。太糟糕了。我想我们现在没有那么多选择了。如果你需要什么，你知道在哪里找我。""",
	ANASTASIA_PERSUASION_56 = """— 我会接受你的要求。我会宣布行会想要我的任何支持，我会成为……你的。毕竟你是对的，我有责任继续为人民服务，即使我不再是皇室成员。""",
	ANASTASIA_PERSUASION_57 = """— 但我有一个条件。你能请你的女行会领袖来吗？""",
	ANASTASIA_PERSUASION_58 = """她说完后不久，牢房门打开，阿米莉亚走了进来。看起来她一直在徘徊，等待你的讨论结果。

{color=aqua|阿米莉亚: — 我能为您服务吗？ }

{color=yellow|阿纳斯塔西娅: — 我希望你向我保证艾尔的安全。不，等等，我希望你也让我们偶尔见面。}

{color=aqua|阿米莉亚: — 好的，我们可以把你的小精灵朋友转移到[name]的名下。我想你不会拒绝另一个仆人的，对吧？}

{color=yellow|阿纳斯塔西娅: — ...这将非常符合我的期望.}""",





	ANASTASIA_PERSUASION_59 = """— 不错，不错，看起来你做到了。你成功说服了傲慢的公主大人。我印象深刻。我们会为她准备演讲，然后我们会发布公告。""",
	ANASTASIA_PERSUASION_OPTION_43 = """没有你我做不到""",
	ANASTASIA_PERSUASION_OPTION_44 = """她一定被我迷住了""",
	ANASTASIA_PERSUASION_OPTION_45 = """我等不及结束这一切了""",
	ANASTASIA_PERSUASION_60 = """— 不需要奉承，你达成了协议。""",
	ANASTASIA_PERSUASION_61 = """— 哈哈，我想知道。你会如何处理一颗纯洁的少女心？""",
	ANASTASIA_PERSUASION_62 = """— 别担心，现在是最好的部分。""",
	ANASTASIA_PERSUASION_63 = """— 无论如何，我会在大约3天后告诉你。在那之前玩得开心。""",


	ANASTASIA_PERSUASION_2_MARRY1 = "— 但告诉我，我想知道，你为什么要选择我？",

	ANASTASIA_PERSUASION_2_MARRY1_OPTION1 = "我一见钟情（魅力因素）",
	ANASTASIA_PERSUASION_2_MARRY1_OPTION2 = "实际丰满，想fvck！（性因素）",
	ANASTASIA_PERSUASION_2_MARRY1_OPTION3 = "怎么会有人放弃你这样的女孩？",
	ANASTASIA_PERSUASION_2_MARRY1_OPTION4 = "嗯，从技术上讲，你仍然是公主",

	ANASTASIA_PERSUASION_2_MARRY2_1 = "\n\n阿纳斯塔西娅脸红了，看着你的话，但似乎并不怀疑。",
	ANASTASIA_PERSUASION_2_MARRY2 = "— 我-我不知道我是否能在这里回答你的感受，这对我来说压力太大了。",

	ANASTASIA_PERSUASION_2_MARRY2_OPTION1 = "你可以按照自己的节奏进行（魅力因素）",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION2 = "一旦事情安排好，我们就可以处理它（性因素）",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION3 = "只要我能得到你的身体，我对你的感受没有什么兴趣",
	ANASTASIA_PERSUASION_2_MARRY2_OPTION4 = "我理解，这对任何人来说都是很大的压力，但你可以做到",

	ANASTASIA_PERSUASION_2_ENSLAVE1 = "— 你到底对我有什么计划？",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION1 = "我相信你的魅力和经验可以帮助我管理豪宅",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION2 = "你会成为一个优秀的家庭仆人",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION3 = "你必须接受体力劳动或战斗训练",
	ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION4 = "暖床似乎是你的理想工作",

	ANASTASIA_PERSUASION_2_ENSLAVE2_1 = "— 是这样吗……所以你也计划以……亲密的方式利用我？",
	ANASTASIA_PERSUASION_2_ENSLAVE2 = "— 所以，我必须成为你的财产。我想，这也意味着……亲密的方式？",

	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION1 = "当然，但我可以保证你不会后悔。（性因素）",
	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION2 = "坦率地说，我不能放弃你这样的美女。（魅力因素）",
	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION3 = "好吧，这迟早会发生。",
	ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION4 = "我真的对你没有兴趣",

	ANASTASIA_ACCEPT_MARRY = """

— 我-我会接受你的提议。我会宣布任何行会想要我的支持，我会成为。。。你的我不敢相信我会在这里结束，但我会努力接受你作为我的配偶。""",
	ANASTASIA_ACCEPT_ENSLAVE = """

— 我-我会接受你的要求。我会宣布任何公会想要我的支持，我会成为。。。你的毕竟你是对的，即使我不再是皇室成员，我也有责任继续为人民服务。""",


	ANASTASIA_PERSUASION_NEXTDAY = "此时，阿纳斯塔西娅一定已经决定是否愿意接受你的求婚。再去看她是个好主意。",


	ANASTASIA_DECLARATION_1 = """今天是你们的就职典礼。随着内战的结束，人们聚集在一起，期待着胜利的宣告。中央广场几乎挤满了每一位有能力参加的公民，所有人都期待着这一活动。

阿纳斯塔西娅走上政府大楼的阳台，人群的喃喃自语被等待她的沉默所取代。

— 阿利隆的人民。我是阿纳斯塔西娅，前公主和叛军领袖。我记得我之前宣布这一消息时就在这个广场上。我知道你们中的许多人因为我引起的冲突而憎恨我，但我在这里……请求你们的原谅。

听到这些，人群似乎热情高涨，而阿纳斯塔西娅则下定决心。""",
	ANASTASIA_DECLARATION_2 = """— 我的方式是错误的，我导致了许多人的死亡。我对此深感遗憾，我只希望这场战争停止。这就是为什么我要求那些仍在为我而战的人停止并投降。

— 我不再是叛军领袖了。我知道你们中的一些人仍然相信统治是我天生的权利，但我不再有资格了。相反，从现在起，我将支持新当选的阿利隆市长[Sir] [name] [surname]。我会听从他的命令，同时为人民尽我所能。

听到你的名字，你就从阴影中走了出来，快速鞠躬，搂着阿纳斯塔西娅的腰。一段时间以来，关于你的行为以及你将如何成为下一任统治者的传言一直在传播，人群充满了活力。自发的掌声响起。""",
	ANASTASIA_DECLARATION_3 = """{color=aqua|男性公民 1: — 终于结束了。}

{color=yellow|男性公民 2: — 她真是个美人。}

{color=aqua|女性公民: — 他们很般配}""",
	ANASTASIA_DECLARATION_OPTION_1 = """向人群挥手""",
	ANASTASIA_DECLARATION_OPTION_2 = """摸阿纳斯塔西娅的屁股""",
	ANASTASIA_DECLARATION_4 = """当阿纳斯塔西娅演讲时，你花了很多的时间问候市民。很快，演讲就宣布结束了，你走回大楼。""",
	ANASTASIA_DECLARATION_5 = """当阿纳斯塔西娅继续她的演讲时，你的手（她已经有点习惯了）向下移动，落在她的屁股上，使她明显口吃和脸红。她的纪律使她能够在没有任何可怕错误的情况下完成演讲，然后你们一起走回大楼。""",
	ANASTASIA_DECLARATION_1MC = """今天是你们的就职典礼。随着内战的结束，人们聚集在一起，期待着胜利的宣告。中心广场几乎挤满了每一位有能力参加的市民，所有人都期待着这一活动。

阿纳斯塔西娅走上政府大楼的阳台，人群的喃喃自语被等待她的沉默所取代。你把行会准备好的声明交给她，让她发言。

— 阿利隆的人民。我是阿纳斯塔西娅。前公主和叛军首领。我记得在这个广场上。当我之前演讲的时候。你们恨我是对的，因为战争确实都是我的错。所以我在这里。乞求你的原谅。

观众似乎对她的话感到满意，没有注意到她断断续续的演讲，也可能不记得这么多天前她更雄辩的演讲。 """,
	ANASTASIA_DECLARATION_2MC = """— 我的方式是错误的。我已经让很多人走向了死亡。我对此深感遗憾。我希望这场战争停止。为了那些仍然在那里的人。为我而战的人们。停下来投降。

— 我不再是叛军领袖了。你们中的一些人认为统治是我天生的权利。但我放弃一切统治权。从现在起我支持。新当选的阿利隆市长。[Sir] [name] [surname]。我将听从[he]的命令。我现在心甘情愿地成为[his]奴隶。

一听到你的名字，你就从阴影中走了出来，快速鞠躬，搂着阿纳斯塔西娅的腰。一段时间以来，关于你的行为以及你将如何成为下一任统治者的传言一直在传播，人群充满了活力。自发的掌声响起。""",

ANASTASIA_DECLARATION_4MC = """当阿纳斯塔西娅大声朗读演讲的其余部分时，你花了很多的时间问候市民。说完，宣布结束，你走回大楼。人群似乎没有感觉到，也可能不在乎公主有什么不对劲。""",
	ANASTASIA_DECLARATION_5MC = """当阿纳斯塔西娅继续大声朗读演讲稿时，你把手伸进她的裙子下面，揉了揉她的屁股。她像以前一样稳定地表达自己的台词，尽管脸上可以看到明显的脸红。她没有犯任何可怕的错误，就结束了演讲，你走回了大楼。人群似乎没有感觉到，也可能不在乎公主有什么问题。""",



	FINAL_WORDS_1 = """{color=aqua|邓肯: — 祝贺你，你终于成功了。叛军还不会消亡，但他们应该再也无法团结起来了。}

{color=yellow|西格蒙德: — 只要塌闷不会占领城镇，窝掘德就很好。（似乎是喝醉了）}

{color=aqua|邓肯: — 所以现在你正式成为市长了。}

{color=yellow|西格蒙德: — 作瞎来参加艳辉吧。}""",
	FINAL_WORDS_OPTION_1 = """谢谢""",
	FINAL_WORDS_OPTION_2 = """我会怀念那种刺激的""",
	FINAL_WORDS_2 = """第一幕结束。感谢您的参与。""",



	AFTER_ELECTION_PRINCESS_1 = """宴会结束后，你发现阿纳斯塔西娅紧张地等着你。""",
	AFTER_ELECTION_PRINCESS_2 = """

— [name]... 那么，你现在打算怎么处置我？你确实说过你喜欢我。这是事实吗，还是一种话术？""",
	AFTER_ELECTION_PRINCESS_3 = """

— 所以，我现在是你的奴隶...你打算怎么处置我？""",
	AFTER_ELECTION_PRINCESS_OPTION_1 = """我对你有感觉""",
	AFTER_ELECTION_PRINCESS_OPTION_2 = """我对你不是很感兴趣""",
	AFTER_ELECTION_PRINCESS_OPTION_3 = """你只是一个很好的战利品""",
	AFTER_ELECTION_PRINCESS_OPTION_4 = """你会成为一个很棒的玩物""",
	AFTER_ELECTION_PRINCESS_OPTION_5 = """我还没决定""",
	AFTER_ELECTION_PRINCESS_4 = """阿纳斯塔西娅听后脸红得厉害，看起来仍然不习惯这种情况，或者说处于顺从的角色。

— 是这样吗？那你一定想和我躺在一起。我... 并非完全反对""",
	AFTER_ELECTION_PRINCESS_5 = """拥抱她""",
	AFTER_ELECTION_PRINCESS_6 = """今天不行""",
#	AFTER_ELECTION_PRINCESS_7 = """你骑士般地把阿纳斯塔西娅抱到你的卧室。
#
#— 对不起，这是我第一次和男人在一起.""",
#	AFTER_ELECTION_PRINCESS_8 = """公主脱下衣服后，按照你的指示躺在床上。她匀称的身体摆在你面前。""",
#	AFTER_ELECTION_PRINCESS_9 = """经过一些准备，阿纳斯塔西娅设法变得足够湿，让你相对无痛地穿透她。当你品尝她未使用的阴部的感觉时，她忍受着最初的不适。""",
#	AFTER_ELECTION_PRINCESS_10 = """过不了多久，你们就达到了高潮。当你的种子充满她时，她幸福地翻了个白眼。""",
#	AFTER_ELECTION_PRINCESS_11 = """— 我-我不知道该说什么。我想我没想到会感觉这么好。很高兴我第一次和你在一起。""",
	AFTER_ELECTION_PRINCESS_7 = """微笑着，你牵着公主的手，把她带到你的卧室。""",
	AFTER_ELECTION_PRINCESS_CONSENT_1 = """在卧室里，你关上阿纳斯塔西娅身后的门，紧紧地拥抱她，然后把她抱起来。 

你把公主放到床上，双手抱着她的头，深深地吻着她，舌头品尝着她丰满的嘴唇，探索着她战栗的嘴巴。你的手穿过她的头发，一直到她匀称的屁股，在那里你用力挤压，让她惊讶地喘着粗气。

回过头来，你告诉阿纳斯塔西娅你已经等了很长时间，你不会再等了。她脸红了，问你对她有什么期望。

你咧嘴一笑，解释说第一步是脱掉她的衣服。""",
	AFTER_ELECTION_PRINCESS_CONSENT_2 = """阿纳斯塔西娅开始小心地脱下衣服，解开及膝长靴的扣子，把它们从她那长筒袜腿上脱下来。她耸耸肩，把蓝色斗篷递给你，然后松开腰上的腰带，把它脱下。她犹豫了一会儿。

{color=yellow|阿纳斯塔西娅: — 我— 我通常有艾尔帮我穿衣服。如果你不介意，你能帮我吗？}

阿纳斯塔西娅转过身来，把她的金色长发从肩上撩开。把她的斗篷扔到一边，你站在她身后，开始解开她衣服紧身胸衣部分的小钩子。当你解开裙子时，她的头发散发出甜甜的香味，就像金银花一样。她光着肩膀紧张地看着你。""",
	AFTER_ELECTION_PRINCESS_CONSENT_3 = """你帮助阿纳斯塔西娅从裙子的上半部分解放出来，让它掉下来，露出她美丽成熟的乳房。她突然裸体，脸都红了，你从背后拥抱她，当你的手轻轻地向她紧绷的腹部滑动，吮吸她的乳头时，你的牙齿贴上了她脖子上光滑的皮肤。你感觉到她娇嫩的乳头在指尖的压力下变硬了。

你挤压她的胸部，然后把手放在她的腰部，在那里你把裙子从她的臀部剥离，然后让它掉到地板上。当你把她转过身来面对你时，她光着身子站着，只为袜子和丝绸内裤。她是一个美丽的视觉，她白皙的皮肤完美无瑕，头发像温暖的灯光下的金色。她尴尬地用手捂住胸部。""",
	AFTER_ELECTION_PRINCESS_CONSENT_4 = """你把她的手腕移开，这样你就可以欣赏她性感的胸部，然后把阿纳斯塔西娅完美的身材拉到你身上，绕着她的腰，把手伸进她的内裤里。你的手抬起并分开她的屁股瓣，你的中指沿着她的屁股中心在她的两腿之间划出一条线。她轻轻地对着你的肩膀尖叫，颤抖着。

你把丝绸内裤从她的圆屁股上脱下，让它们落在她的脚踝上。你把你的衬衫拉过你的头，让她裸露的胸部紧贴着你裸露的胸部。你贪婪地抚摸着她赤裸的身体，她在你耳边低语，她的声音因不情愿的唤起而变得紧张。

{color=yellow|阿纳斯塔西娅: — 嗯……你想让我……做什么？}""",
	AFTER_ELECTION_PRINCESS_CONSENT_5 = """你把阿纳斯塔西娅带到床上，让她躺下，然后看着她小心地把袜子卷在光滑的大腿上。她仍然脸红，对着你专注的目光，慢慢地从脚趾上扯下袜子，把它们扔掉。你解开皮带，让裤子掉下来，露出你僵硬的阴茎。公主咬着嘴唇，本能地按着大腿，蓝眼睛睁大了。

{color=yellow|阿纳斯塔西娅: — 哦！那……是……你的...}

你爬上缎面床单，躺在阿纳斯塔西娅身边，抚摸着她匀称的曲线。你的手指压在她的两腿之间，你开始挑逗她的狭缝，当你的拇指滑过她的阴蒂时，你感觉到它的紧绷。当你用手指抚摸她的时候，她的处女阴道很快就会变得湿润起来，当你轻轻咬她的耳朵和脖子时，她的手碰到你的阴茎。""",
	AFTER_ELECTION_PRINCESS_CONSENT_6 = """用一只手，你把阿纳斯塔西娅的腿张开，当你把身体向上摆动到她的身上时，她的呼吸急促。你享受了一会儿，然后把她的手腕固定在床上。她抬头看着你的眼睛，你看到欲望和恐惧交织在一起。你弯腰再次亲吻她，你的阴茎压在她的阴蒂上。当你的舌头滑进她的嘴里时，她气喘吁吁。

{color=yellow|阿纳斯塔西娅: — 等-等等，我不是-.}

当你的大阴茎冲破她的处女膜，充满她的阴部时，阿纳斯塔西娅大叫起来。当你的阴茎刺入她的身体时，她的湿润减轻了不适感，当你深入她的身体时，拉伸了她未使用过的阴部。当你拔出时，一层薄薄的处女血覆盖在你的阴茎上，然后再插回她的阴唇之间。张开嘴巴，别着胳膊，当你操她的时候，阿纳斯塔西娅无助地呻吟着。""",
	AFTER_ELECTION_PRINCESS_CONSENT_7 = """当性高潮压倒年轻的公主时，阿纳斯塔西娅的眼睛向后翻，她的身体颤抖。你一次又一次地刺入她紧绷的阴部，当她纤细的腿蜷缩在你的腰上时，你自己的性高潮即将到来。然后你强有力的阴茎刺向她，你把她抱在床上，你的精液在她体内爆炸时，你的躯体压在她身上。

你的舌头挤满了阿纳斯塔西娅的口腔，她的阴部在你高潮的阴茎周围抽搐，从你身上挤出精液。她叹了一口气，倒在枕头上，你的阴茎还夹在她的阴部里。她大口大口地喘着粗气，胸部和腹部剧烈起伏。汗水的光泽把一缕头发粘在她的脸颊上，让她的皮肤在灯光下闪闪发光。公主美丽的脸上流露出羞涩的神色。

{color=yellow|阿纳斯塔西娅: — 我不知道这会感觉这么好。呃-我做得好吗？}""",
	AFTER_ELECTION_PRINCESS_CONSENT_OPTION_1 = """你做得很庄严""",
	AFTER_ELECTION_PRINCESS_CONSENT_OPTION_2 = """第一次还不错""",
	AFTER_ELECTION_PRINCESS_CONSENT_OPTION_3 = """及格，但练习越多越好""",
	AFTER_ELECTION_PRINCESS_CONSENT_REPLY_1 = """{color=yellow|Anastasia: — 谢谢…等等，你在嘲笑我吗？}

{color=yellow|阿纳斯塔西娅: — 出于某种原因，我和你在一起很平静。我和一个男人的第一个晚上毕竟没那么糟糕。我能在你旁边睡到第二天早上吗？..}""",
	AFTER_ELECTION_PRINCESS_CONSENT_REPLY_2 = """{color=yellow|Anastasia: — 谢-谢谢，我想我不能和你比？}

{color=yellow|阿纳斯塔西娅: — 出于某种原因，我和你在一起很平静。我和一个男人的第一个晚上毕竟没那么糟糕。我能在你旁边睡到第二天早上吗？..}""",
	AFTER_ELECTION_PRINCESS_CONSENT_REPLY_3 = """阿纳斯塔西娅稍微有点生气，但很快就平静下来了。

{color=yellow|阿纳斯塔西娅: — 出于某种原因，我和你在一起很平静。我和一个男人的第一个晚上毕竟没那么糟糕。我能在你旁边睡到第二天早上吗？..}""",

	# Idk part
	AFTER_ELECTION_PRINCESS_12 = """当公主听到你的话时，她的脸变得稍微放松了一些，但也不确定。决定她以后会对一些任务有用或进行交换时，你决定暂时就这样吧。""",
	AFTER_ELECTION_PRINCESS_13 = """阿纳斯塔西娅听到后皱着眉头，但别无选择，只能顺从。

— 我明白了。。。我想我现在任由你摆布。""",
	AFTER_ELECTION_PRINCESS_OPTION_6 = """我今天要领取战利品了""",
	AFTER_ELECTION_PRINCESS_OPTION_7 = """我不想做 """,
#	AFTER_ELECTION_PRINCESS_14 = """你命令公主和你一起去你的卧室，该好好享受了。""",
#	AFTER_ELECTION_PRINCESS_15 = """在你的命令下，阿纳斯塔西娅脱下衣服，你将她四肢着地放在床上。你认为这是一个合适的姿势来完成对她的征服，于是迅速从背后骑上她，夺取了她的处女。尽管她哭泣，但她没有恳求你停止，坚忍地忍受着痛苦和羞辱，度过了剩下的夜晚。""",
#	AFTER_ELECTION_PRINCESS_16 = """阿纳斯塔西娅看起来对你的回答感到困惑，但没有抗议。然而，她似乎很紧张。事件并没有像她预期的那样发生。""",
	AFTER_ELECTION_PRINCESS_16_OLD = """阿纳斯塔西娅看起来对你的回答感到困惑，但没有抗议。然而，她似乎很紧张。事件并没有像她预期的那样发生。""",
#	AFTER_ELECTION_PRINCESS_17 = """宴会结束后，你发现你精神崩溃的阿纳斯塔西娅，她似乎耐心地等着你，眼神有些茫然。""",
	AFTER_ELECTION_PRINCESS_OPTION_8 = """和她上床""",
	AFTER_ELECTION_PRINCESS_OPTION_9 = """也许改天吧""",
#	AFTER_ELECTION_PRINCESS_18 = """根据你的命令，阿纳斯塔西娅脱下衣服，你把她四肢着地放在床上。你认为这是一个合适的位置来完成对她的征服，于是迅速从后面骑上她，夺取了她的处女。尽管她的状态不好，但她依然温暖和紧绷，所以你度过了一个相当满意的夜晚。""",
	AFTER_ELECTION_PRINCESS_PRE_14 = "你命令公主牵着你的手，把她带到卧室。",
	AFTER_ELECTION_PRINCESS_14 = """在卧室里，你命令阿纳斯塔西娅关上门，然后站在你面前。你制定了一些基本规则。作为你的奴隶，她必须随时称你为主人，并按照你的要求行事。 

阿纳斯塔西娅默默点头，让你温柔地斥责她。 

{color=yellow|阿纳斯塔西娅: — 我的意思是，是的。是的，主……主人。我会听从你的命令。}

你绕着她走，仔细检查你的新资产。你把她的裙子从后面提起，把手掌伸进她的蕾丝衬裙里，伸进她的大腿内侧，伸进她紧张的屁股缝里。阿纳斯塔西娅颤抖着，但没有抗议。你把手伸过她的肩膀，伸进她的上衣，在那里你用杯状的手承受着一个乳房的重量。 """,
	AFTER_ELECTION_PRINCESS_15 = """站在她身后，手放在她的乳沟上，轻轻捏一捏乳头，指示她放松。

{color=yellow|阿纳斯塔西娅: — 对-对不起，主人。我在努力，我只是有点紧张。}

你用力捏她的乳头一秒钟，她小声尖叫。你解释说，失败的借口是不能容忍的。放开她的胸脯，你就站在前面。阿纳斯塔西娅忧愁地看着你，看来是今晚的待遇和往日相比差太远了。 

{color=yellow|阿纳斯塔西娅：没有必要伤害我，我会做任何事的}

你用一记快速、随意的耳光打断了她的话，并指示她在没有人说话的情况下不要说话。她的脸颊因被打而变红，但她沉默了，明亮的蓝眼睛很警惕。

你解释说，你对她的叛逆感到失望，如果她不想让更糟糕的命运发生在她身上，她就必须赢得你的信任。你告诉阿纳斯塔西娅，为了她的利益，她学会了在所有事情上首先取悦你。说完，你命令她脱衣服。""",
	AFTER_ELECTION_PRINCESS_16 = """阿纳斯塔西娅对你的脱衣服命令脸红了，看起来好像要争论，所以你警告她，如果她自己脱衣服，她可以保留她的花哨衣服。如果她让你脱衣服，衣服就不会完整的保存下来了。 

{color=yellow|阿纳斯塔西娅: — 好的，主人。我自己做。}

阿纳斯塔西娅开始脱衣服，解开及膝长靴的扣子，把它们脱了下来。她脱下蓝色斗篷，把它放在扶手椅上。她开始脱袜子，但你拦住她，示意她先脱下裙子。阿纳斯塔西娅挣扎着解开她的裙子后面，你对延迟感到惊讶。

{color=yellow|阿纳斯塔西娅: — 对不起，主人。我习惯了有艾尔来帮助我。}

真是麻烦，你命令她转身，把金色的长发竖起来，你松开把她裙子后面固定住的钩子。当你在她面前向后移动时，她松开了腰上的腰带，裙子的顶部开始敞开，她柔软厚重的乳头露了出来。""",
	#gets naked here
	AFTER_ELECTION_PRINCESS_17 = """她的脸羞愧得通红，阿纳斯塔西娅扭动着臀部，把裙子套在上面，然后裙子掉到了地板上。她的大胸部下垂，当她把手臂从蓬松的蓝色袖子上松开时摇摆不定。她把金属护臂套在手腕上，然后把它们掉在裙子上。你可以看到她把手放到袜子上，小心地把它们从光滑的大腿卷到脚趾。最后，她脱下了袜子。最后她让丝绸内裤落在她的脚踝上。 

阿纳斯塔西娅从内裤里走出来，一丝不挂地站着，双手本能地捂住她的阴部和乳头。你命令她像刚才一样用双手把头发从肩上扯下来，尽管她犹豫了，但她还是照做了。你花点时间欣赏你裸体顺从的公主，并指示她慢慢转身，这样你就可以检查她的整个身体。

她的皮肤比普通女孩光滑，头发更有光泽。尽管这些年来她一定过得很艰难，但她似乎仍然过着相当奢侈的生活。""",
	AFTER_ELECTION_PRINCESS_18 = """阿纳斯塔西娅一丝不挂，百依百顺，你开始对你的财产进行更彻底的检查。你的手在她的身上漫步，探索她成熟的乳房、纤细的腹部和柔软的圆屁股。当你把她的大腿分开露出她的阴部时，她轻轻地呜咽着，但你假装没有注意到。你的手指抚摸她的狭缝，然后在她整洁的阴唇之间探查，检查她的处女膜。

{color=yellow|阿纳斯塔西娅: — 你-你在干什么？你不应该碰...!}

你无视阿纳斯塔西娅的请求，因为她现在是你的奴隶，没有权利抗议。她虚弱的身体也无力抵抗你。当你的手指粗略地探索她紧绷的处女洞时，她哭了——尽管她最终别无选择，只能容忍你的猥亵。""",
	AFTER_ELECTION_PRINCESS_19 = """你命令裸体哭泣的公主躺在床上，她毫不反抗地服从了。你爬到上面抓住她的手腕，把它们拖到她的头上，把她铐在床头板上。当你解开裤子，你的阴茎跳了出来时，阿纳斯塔西娅的眼睛里流出了新的泪水。你在她多汁的乳头之间摩擦你坚硬的阴茎，并指示她为你伸开腿。 

她张开双腿，大腿颤抖。你命令她乞求你的阴茎，乞求你夺走她的童贞。当她顺从时，她那双蓝色的大眼睛仍然被泪水打湿。

用满意的咕哝声，你把你的阴茎引导到她贞洁的阴部，深入它，直到你感觉到她的处女膜的阻力。你看着她的眼睛，她咬着嘴唇。一个坚定的前进，一个短暂而尖锐的痛苦的呼喊，阿纳斯塔西娅不再是少女。当你捶打她紧绷的阴部时，她的阴蒂周围有一点血迹。""",
	AFTER_ELECTION_PRINCESS_20 = """你操了阿纳斯塔西娅差不多一小时，你的厚公鸡一次又一次地进出她紧绷的阴部。过了一段时间，她高潮了，她不情愿的高潮让她全身发抖。你一直在操她，让她明白，她再也不会掌管自己的身体了。

伴随着高潮你把精液射到她内心深处，阿纳斯塔西娅开始呻吟和扭动。她的阴部在你喷射精液的阴茎周围痉挛，你把公主死死抱在床上直到高潮结束，她的抵抗力完全崩溃了。

公主现在是你的财产，你会期待更多这样的夜晚。 """,
	AFTER_ELECTION_PRINCESS_MINDBREAK_0 = "宴会结束后，你召唤了你精神崩溃的公主。阿纳斯塔西娅来了，眼神空洞，耐心等待你的注意。",
	AFTER_ELECTION_PRINCESS_MINDBREAK_1 = """抓住公主的手腕，你把她带到你的卧室。当你关上门，把她移到房间中间时，阿纳斯塔西娅的脸上仍然没有表情。站在她面前，你提起她的裙子前面，随意地把手伸进她的丝绸内裤里。当你用手指指她的处女阴道时，她没有反应，但当你捏她的阴蒂时，她会尖叫。

你把手收起来，抓住她的胸部，粗暴地把它们挤穿蓝色连衣裙。皱着眉头遮住了她美丽的脸庞，但除此之外，她依然无动于衷。当你用力拍打她的脸时，她的蓝眼睛开始流泪，但她没有反抗。 """,
	AFTER_ELECTION_PRINCESS_MINDBREAK_2 = """对阿纳斯塔西娅的完全服从感到满意，你把她拖到你的桌子上，让她弯腰。提起她的裙子和衬裙，露出她匀称的屁股。你狠狠地拍了她一下，把丝绸内裤拖到她的膝盖上，这样你就可以检查她的阴部了。她的大腿修长，皮肤乳白色，当你用手抚摸她整洁的阴唇和后面的圆形时，大腿会微微颤抖。

不知道公主会多么理解你的话，你告诉她她惹了很多麻烦，你会喜欢惩罚她。你残酷地捏着她大腿内侧柔软的肉，当她发出疼痛的轻柔呼喊时，苍白的皮肤变得通红。你解释说她会成为你阴茎的奴隶，是你一时兴起就被操和虐待的玩物。你问她是否理解。""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_3 = """当你的手粗鲁地在她的两腿之间探索时，公主弯下腰，按下桌子，用平淡的声音毫无感情地回答。

{color=yellow|阿纳斯塔西娅: — 是, 主人.}

对阿纳斯塔西娅的思维能力感到惊讶，你喃喃自语表示赞叹，解开腰带松开了你的阴茎。你绕着桌子走，直到你走到她面前，抓住她的一把金色长发，把她漂亮的脸拉起来看着你。当你把你的阴茎举在她面前，让她吮吸时，她的表情仍然空洞，仿佛被迷住了。 

阿纳斯塔西娅顺从地点头，用她丰满的嘴唇搂住你的阴茎头，贪婪地吮吸，你用手抓着她的头发把她的头往下推。""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_4 = """当公主吮吸时，你紧紧抓住她的头，伸手到桌子上拉起她的裙子，这样你就可以打她的白屁股了。当她努力把脚放在地板上时，喉咙里充满了公鸡，她的叫声被抑制住了。看到她光滑的屁股蹦蹦跳跳的样子很令人愉快，你决定是时候改变一下了。

你把你的阴茎从阿纳斯塔西娅嘴里拔出来，快速地绕着桌子走。她的内裤已经滑到脚踝了，你把它们踢开了。你把她的衬裙向后翻，抓住她纤细的腰，用膝盖粗暴地张开她的腿。你的阴茎仍然被她的唾液弄得光滑，当你把臀部排成一行时，你在她褶皱的括约肌上吐口水。""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_5 = """你用手指将唾液按摩到她的肛门，探查公主紧绷的屁股，她对入侵感到不适。你把阿纳斯塔西娅的头发拉向你，把她的上半身从桌子上抬起来，让你勃起的阴茎压在她的屁股里。当你强迫自己进入她紧绷的直肠，用你的阴茎刺穿她完美的屁股时，她尖叫着，颤抖着。 

她的头发被你的拳头夹在脑后，扎成马尾辫，你可以毫不费力地驾驭公主的身材。你残忍地把她那没用过的屁股弄到桌子上，在她哭哭啼啼的时候打她屁股。几分钟后，她的哭声停止了，当你的阴茎接近高潮时时，你感觉到她的括约肌放松了。 """,
	AFTER_ELECTION_PRINCESS_MINDBREAK_6 = """你把你的阴茎慢慢地从她的屁股里滑出来，用她的头发把她从桌子上拖走。当你把阿纳斯塔西娅带到墙上，把她推到墙上时，她仍然穿着她那件漂亮的蓝色连衣裙。”。你的手抓住裙子的顶部，抓住她的乳沟，然后用力把它撕开。当你把裙子往下拉时，她苍白的胸部从撕裂的紧身胸衣中溢出。 

阿纳斯塔西娅颤抖着，当你把裙子从她的臀部拉开并扔到地板上时，她的蓝眼睛茫然地盯着你。你一只手抓住她的手腕，把它们别在她的头上，另一只手抓着她的一只乳头。野蛮地挤压她的乳房，你把它拉到嘴里，咬她的乳头。当你的牙齿咬在她娇嫩的肉上时，她又尖叫起来了。
 
当她的奶头紧紧地夹在你的嘴上时，你的自由的那只手落到公主的处女阴部，在那里你开始摩擦她敏感的阴蒂。她试着把腿压在一起，但你用膝盖很容易把它们分开。""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_7 = """在你手指的无情攻击下，你感觉到阿纳斯塔西娅的处女阴部开始变得光滑。你把她淤青的乳头从嘴里放出来，看着她的眼睛，它们只显示出一点感知力。 

你把阿纳斯塔西娅推到地板上，她为你张开双腿。你骑上她，把你的阴茎插进她体内，在她的处女膜上留下一层薄薄的血迹，用你的阴茎填满她的阴部。她为失去童贞而喘息，但你把她的手臂固定在地板上，把她苗条的身体撞到木板上，而她的乳头则疯狂地弹跳。""",
	AFTER_ELECTION_PRINCESS_MINDBREAK_8 = """这没有花你很长时间，当你的热精液充满她的阴部时，阿纳斯塔西娅微弱地呻吟着。你释放她疲惫的身体，把她拉出来，你的阴茎拖着精液划过她的腹部和胸部，然后你把她扔出卧室，让她休息。她静静地站在你的门外，精液顺着腿流下来，耐心地等待你的下一次指示。""",


	##################################################New
	AIREAMELIAREPORT = "第二天早上，您收到一封来自阿米莉亚的简短信件，信中称她得知了公主的位置，并邀请您去看望她。",
	AIREAMELIAMEETOPTION = "我收到你的信息，你有新信息吗？",
	AIREAMELIAMEET1 = "— 是的，我知道公主的位置，如果你同意在未来帮我一个忙，我愿意分享。这是一笔不错的交易，因为这很可能是你成为下一任市长的最后一个障碍。所以，你帮我，我也帮你？",
	AIREAMELIAMEET1_OPTION1 = "当然，你为我做了很多",
	AIREAMELIAMEET1_OPTION2 = "我不能同意在不知道是什么的情况下帮你一个忙",
	AIREAMELIAMEET2 = "我很高兴听到这个消息。据精灵女孩说，阿纳斯塔西娅躲在精灵的土地上。你应该见见他们的首领，了解更多。如果我没有错的话，这应该是他们的高级女祭司。我希望听到你成功的消息。",
	AIREAMELIAMEET2_1 = "我明白了。好吧，我会一直等到你改变主意。",


	AMELIAFINDPRINCESSOPTION = "我一直想知道你是否能给我一些关于如何找人的建议...",
	AMELIAFINDPRINCESS1_1 = """— 你一直想找到我们的公主，我想是吧？我听说你抓了她的小精灵朋友。如果你还没有，试着审问她可能是个好主意。

— 或者，如果你能找到她的一些物品，我们可以依靠法师公会的朋友来找到她。他们有一个追踪的窍门……用来找那些不太愿意被发现的人。你可以查一下她最后去过的地方。如果你在那里找到有用的东西，就把它还给我""",
	AMELIAFINDPRINCESS1_2 = """— 你一直想找到我们的公主，我想是吧？手头没有很多线索，是吗？好吧，对于这种情况，我们可以利用法师公会中的朋友，只要你能为他们提供属于我们所寻找的人的东西。他们有一个技巧可以追踪……那些不太愿意被发现的人。你可以查看她最后去过的地方。如果你在那里找到有用的东西，带上它给我。

— 如果你能找到她的一些物品，我们可以依靠法师公会的朋友找到她。他们有一个追踪的窍门……用来找那些不太愿意被发现的人。你可以查一下她最后去过的地方。如果你在那里找到有用的东西，就把它给我""",
	AMELIAFINDPRINCESS1_3 = """""", # MISSING TRANSLATION
	AMELIAFINDPRINCESS2 = "— 你一直想找到我们的公主，我想是吧？手头没有很多线索，是吗？好吧，对于这种情况，我们可以利用法师公会中的朋友，只要你能为他们提供属于我们所寻找的人的东西。他们有一个技巧可以追踪……那些不太愿意被发现的人。你可以查看她最后去过的地方。如果你在那里找到有用的东西，带上它还给了我。 ",

	AMELIAFINDPRINCESSOPTION1 = "谢谢你的建议",
	AMELIAFINDPRINCESSOPTION2 = "我找到东西后会回来",
	AMELIAFINDPRINCESSOPTION3 = "我到底在找什么？",
	AMELIAFINDPRINCESS2_1 = "— 再见, 亲爱的.",
	AMELIAFINDPRINCESS2_2 = "— 你在问我？我不能为你做任何事。你只需要她的一些东西。别担心，我相信你会成功的。",
	MATERIALPRINCESS_BRACELET = "不寻常的手镯",
	MATERIALPRINCESS_BRACELETDESCRIPT = """一个你在叛军藏身处获得的不同寻常的银手镯。在内侧，你可以看到一个小雕刻：“致我心爱的女儿”。 """,
	MATERIALDIVINE_SYMBOL = "神圣符号",
	MATERIALDIVINE_SYMBOLDESCRIPT = "一块硬币形状的小金属，可以作为某些艺术的媒介。尽管它看起来很简单，但它展示了相当的工艺。",
	MATERIALBLESSED_DIVINE_SYMBOL = "神圣的祝福符号",
	MATERIALBLESSED_DIVINE_SYMBOLDESCRIPT = "一块发出微弱光线的硬币状金属。",
	ITEMZEPHYRA_UNDERWEAR = """Ripples of Pristine Waters""", # MISSING TRANSLATION
	ITEMZEPHYRA_UNDERWEARDESCRIPT = """Excessively rare item, a one of a kind, or at least a one you've obtained.""", # MISSING TRANSLATION

	UNIQUECLASS = "无法正常获取",

	ITEMANASTASIA_BRACELET = "阿纳斯塔西娅的手镯",
	ITEMANASTASIA_BRACELETDESCRIPT = "一个昂贵的手镯，属于前公主阿纳斯塔西娅，是她的父母送给她的。仔细检查，她保养的很好。 \n\n{color=yellow|仅限阿纳斯塔西娅装备}",
	ITEMANASTASIA_BROKEN_BRACELET = "阿纳斯塔西娅的手镯",
	ITEMANASTASIA_BROKEN_BRACELETDESCRIPT = "一个昂贵的手镯，属于前公主阿纳斯塔西娅，是她的父母送给她的。仔细检查，她保养的很好。 \n\n{color=yellow|仅限阿纳斯塔西娅装备}",

	ITEMDAISY_DRESS = "黛西的连衣裙",
	ITEMDAISY_DRESSDESCRIPT = "专为你拥有的兔子女孩设计的定制制服。它非常耐用，突出了她的优点。\n\n{color=yellow|仅限黛西装备} ",
	ITEMDAISY_DRESS_LEWD = "黛西的连衣裙 (Lewd)",
	ITEMDAISY_DRESS_LEWDDESCRIPT = "专为你拥有的兔子女孩设计的定制制服。掀开它相当普通的外观，可以露出她的私处，同时也能刺激她的身体。\n\n{color=yellow|仅限黛西装备} ",
	
	
	
	
	ITEMCALI_HEIRLOOM = "祖传之剑",
	ITEMCALI_HEIRLOOMDESCRIPT = "一把属于卡利的传家剑。据她说，这把剑很没用，但精细的铁匠工艺和魔法光环表明情况并非如此。\n\n{color=yellow|仅限卡莉装备} ",
	ITEMCALI_HEIRLOOM_ACTIVE = "卡莉的祖传之剑",
	ITEMCALI_HEIRLOOM_ACTIVEDESCRIPT = "一把属于卡利的传家剑。由于某些事件，她设法利用了它更好的潜力。\n\n{color=yellow|仅限卡莉装备} ",

	ITEMCALI_COLLAR = "卡莉的项圈",
	ITEMCALI_COLLARDESCRIPT = "一个专门为你的奴隶卡莉制作的项圈。\n\n{color=yellow|仅限卡莉装备} ",
	ITEMCALI_EXQUISITE_COLLAR = "卡莉的精致项圈",
	ITEMCALI_EXQUISITE_COLLARDESCRIPT = "一个专为你的奴隶卡莉设计的花哨项圈。\n\n{color=yellow|仅限卡莉装备} ",
	
	ITEMCALI_COLLAR_ENCHANTED = "卡莉的魔法项圈",
	ITEMCALI_COLLAR_ENCHANTEDDESCRIPT = "一个专门为你的奴隶卡莉制作的项圈。带有一种魔法，这将使她更有可能遵守你的命令。\n\n{color=yellow|仅限卡莉装备}",
	
	
	ITEMCALI_COLLAR_ENCHANTED_2 = "卡莉的高级魔法项圈",
	ITEMCALI_COLLAR_ENCHANTED_2DESCRIPT = "一个专为你的奴隶卡莉制作的花哨项圈。带有一种魔法，这将使她更有可能遵守你的命令。\n\n{color=yellow|仅限卡莉装备}",
	
	ITEMHOLY_SWORD = "石中剑",
	ITEMHOLY_SWORDDESCRIPT = "从石头中获得的圣剑。需要巨大的力量才能获得。",
	ITEMHOLY_SPEAR = "疾风",
	ITEMHOLY_SPEARDESCRIPT = "一支充满风元素的神矛。来自森林精灵。",
	
	SCENEWIP = "对不起！此场景当前为WIP状态。 ",

	AMELIASCENEOPTION = "我想知道你是否能报答我的工作...",

	UNIQUE_CLASS = "无法正常学习",
	UNIQUE_FINAL_OPERATION_DUNGEON = "叛军的藏身处",

	ZEPHYRA_EXTRA_GREET = "— 你想见我, [name]? 我想你一定有一些问题。问吧。",
	ZEPHYRA_EXTRA_GREET2 = "— 你好, [master]. 我能为你服务吗？你想问我一些问题吗？",
	ZEPHYRA_EXTRA_OPTION1 = "你觉得这里怎么样？",
	ZEPHYRA_EXTRA_REPLY1_1 = "— 这很有趣，但我现在别无选择，是吗？不过我没有抱怨，因为这是我同意的。 ",
	ZEPHYRA_EXTRA_REPLY1_2 = "— 一点也不破旧。不过，它可能需要女人的照料。也许可以加一些花和丝带，让它更有家味，你知道。 ",

	ZEPHYRA_EXTRA_OPTION2 = "告诉我更多关于…的信息",
	ZEPHYRA_EXTRA_OPTION2_1 = "阿利奥斯",
	ZEPHYRA_EXTRA_REPLY2_1 = """— 阿利奥斯是风之神。你没听说过他，我一点也不奇怪，他似乎对被崇拜不太感兴趣，所以只有极少数人会和他在一起。

— 我？当然，我不可能不崇拜他。一旦你成为神眷者，它就会在你心中根深蒂固，在某种程度上影响你的每一步。 """,
	ZEPHYRA_EXTRA_OPTION2_1_1 = "你看起来很自由",
	ZEPHYRA_EXTRA_OPTION2_1_2 = "我不想当神眷者，我重视我的独立性",
	ZEPHYRA_EXTRA_OPTION2_1_3 = "所以你们都是无所事事的孤独者",

	ZEPHYRA_EXTRA_REPLY2_1_1 = "— 呵呵，我想你过一段时间就会习惯了。阿利奥斯不希望我因此而感到特别。",
	ZEPHYRA_EXTRA_REPLY2_1_2 = "— 嗯，这太糟糕了，即使阿利奥斯是风神，但只有当自由超过了接受束缚所带来的好处时，自由才有吸引力。",
	ZEPHYRA_EXTRA_REPLY2_1_3 = "— 嘿，不是真的，我也画得很好！我的意思是，我们没有赛琳娜或弗雷娅那么花哨，但你可以得到你能得到的。",
	ZEPHYRA_EXTRA_OPTION2_2 = "你的过去",
	ZEPHYRA_EXTRA_REPLY2_2 = """— 在成为神眷者之前我在做什么？说实话，我不记得了。有一天我在森林中央，那一刻我已经是神眷者了。很神秘，对吧？

— 出于某种原因，我从来没有对之前发生的事情感兴趣，所以就这样。 """,

	ZEPHYRA_EXTRA_OPTION2_3 = "公主",
	ZEPHYRA_EXTRA_REPLY2_3 = """— 所以你是在追捕那个公主来阻止叛乱？嗯，做公主一定很好，我希望我能成为公主，然后我可以过上富足无聊的生活，嫁给一个王子。这不是每个女孩的梦想吗？""",
	ZEPHYRA_EXTRA_OPTION3 = "那么你的计划到底是什么？",
	ZEPHYRA_EXTRA_REPLY3 = """— 你应该继续你的生意，不要担心我。很抱歉，我不能给你指明正确的方向，我也没有。情况有变再说。

— 哦，我恐怕在一段时间内不能再表演一次屏障神术了。你不能随便使用奇迹。这确实使我们的会面具有决定性，对吧？ """,

	KURDAN_EXTRA_GREET = "— 你好, [name]. 你有什么问题要问我吗？",
	KURDAN_EXTRA_OPTION1 = "你觉得这里怎么样？",
	KURDAN_EXTRA_REPLY1 = "— 你有一个很好的家。我必须承认，虽然这不像在我的祖国，但我确实同意这一点，不是吗？嗯，不用担心在哪里睡觉和吃什么有好处。",
	KURDAN_EXTRA_OPTION2 = "关于魔法",
	KURDAN_EXTRA_REPLY2 = "— 我从小就开始学习魔法。我父亲是一位经验丰富的练习者，所以我想它在家族里流传。有些人把它视为一种工具，只是达到目的的一种手段，但我更好奇它是如何运作的，以及它在世界上扮演什么角色。不过，我还有很多东西要学。",
	KURDAN_EXTRA_OPTION3 = "关于半兽人",
	KURDAN_EXTRA_REPLY3 = "— 那些团结我的祖国的人决定完全禁止魔法的实践。在被透特邪教铁腕统治了这么长时间后，他们今天处境艰难。现在邪教受到迫害，而我们……他们已经用技术取代了魔法，将其作为他们力量的基础。我认为总有一天你会不可避免地遇到他们。",

	AMELIA_BONUS_QUESTION = "— [name], 我有一个问题要问你，请诚实回答。你觉得我和公主谁更有吸引力？她似乎只比我小一点，我不能否认她的美丽，仅凭这一点，她就很有吸引力。",
	AMELIA_BONUS_QUESTION_OPTION1 = "公主",
	AMELIA_BONUS_QUESTION_OPTION2 = "阿米莉亚",
	AMELIA_BONUS_QUESTION_OPTION3 = "这是一个艰难的选择...",
	AMELIA_BONUS_QUESTION_OPTION4 = "我喜欢男人",

	AMELIA_BONUS_QUESTION_REPLY1 = """— 哈-哈哈，我明白了。我不能和一个真正的前公主竞争，是吗？

— 要小心不要爱上她，你不能改变立场，背叛我们. """,
	AMELIA_BONUS_QUESTION_REPLY2 = """— 哦，天哪，你不是一个马屁精吗？你真的更喜欢这只杂种猫而不是皇室血统吗？真傻。说实话，我一生的大部分时间都只是另一个仆人。我想我从出生起就一直是仆人。现在我甚至没有一个合适的主人。你能接受挑战吗？……我只是开玩笑。但一定要感谢你的陪伴。""",
	AMELIA_BONUS_QUESTION_REPLY3 = "— 呵-呵，是这样吗？很好。下次你可以撒谎来赢得一些额外的好感，但我不建议你对她抱有希望，她永远是我们的负担。 ",
	AMELIA_BONUS_QUESTION_REPLY4 = "— 哦，是这样吗？很方便。我想我们不必担心她的魅力对你的影响。",
	AMELIA_BONUS_QUESTION_REPLYALL = """

— 好吧，我不会再打扰你了，祝你任务顺利。 """,



	# DAISY QUESTLINE
	DAISY_RECRUITMENT_START = """当你把黛西带到你的豪宅时，她敬畏地看着它。她似乎真的没想到你会成为一个土地所有者。你一进去，她就深深地向你鞠躬。

— 哇，谢谢你, [master]. 我-我会尽力为你服务的! """,
	DAISY_RECRUITMENT_OPTION_1 = "你不必那么正式",
	DAISY_RECRUITMENT_OPTION_2 = "我对你的期望不会降低",
	DAISY_RECRUITMENT_OPTION_3 = "我相信你会*抚摸她的屁股*",
	DAISY_RECRUITMENT_REPLY_1 = "黛西似乎对你的话感到高兴。她似乎很高兴有一个温柔的主人。",
	DAISY_RECRUITMENT_REPLY_2 = "黛西再次鞠躬，继续履行她新获得的职责。",
	DAISY_RECRUITMENT_REPLY_3 = "当黛西感觉到你的手放在她的屁股上时，她的脸颊变红了。她显然对你的举动感到不舒服，但不敢抗议。过了一会儿，你让她继续履行职责。",


	DAISY_CLOTHES_START = """早上，你遇到了黛西，她是最近获得的兔人女孩，现在属于你。她似乎很想告诉你一些事情。

— 早上好, [master]. 我想对你的好意表示感谢。你把我带到你家，一直对我很好，但是...

你看，黛西很犹豫要不要提出她的要求. """,
	DAISY_CLOTHES_OPTION_1_1 = "你想要什么?",
	DAISY_CLOTHES_OPTION_1_2 = "说呀",
	DAISY_CLOTHES_OPTION_1_3 = "猫咬到你的舌头了吗?",
	DAISY_CLOTHES_REPLY_1 = """— 我-我很抱歉，但我觉得我对你家来说不够好看。我只穿这些破布，可能会让你的庄园看起来更糟...""",
	DAISY_CLOTHES_OPTION_2_1 = "我真的不在乎",
	DAISY_CLOTHES_OPTION_2_2 = "很公平，你确实需要更好的衣服",
	DAISY_CLOTHES_OPTION_2_3 = "奴隶不需要更好的衣服",
	DAISY_CLOTHES_REPLY_2_1 = """— 啊，好吧，那么，只要 [master] 同意，我也不会介意...

当她离开房间时，你会三思而后行，并决定在某个时候给她买新衣服是否是个好主意...""",
	DAISY_CLOTHES_OPTION_2_1_1 = "她工作很努力，我还是很关心她的",
	DAISY_CLOTHES_OPTION_2_1_2 = "她不值得我这么关心",
	DAISY_CLOTHES_REPLY_2_1_1 = "毕竟，即使你说你不介意，给她买新衣服也不是个坏主意。你记下了给黛西买新衣服的笔记。你可以去见西格蒙德买高质量的衣服，或者阿米莉亚可以提供更…奢侈的东西。",
	DAISY_CLOTHES_REPLY_2_1_2 = "你决定不想再给她钱了。你可能很快就会把她赶走，所以没有必要再投资了。.",
	DAISY_CLOTHES_REPLY_2_2 = """— 我-我非常感谢你, [master]! 请不要让这件事困扰你。

黛西以她所能表现出的所有尊重向你鞠躬。你记着要给黛西买一条新裙子。你可以去见西格蒙德买高质量的衣服，或者阿米莉亚可以提供更多…奢侈的 """,
	DAISY_CLOTHES_REPLY_2_3 = "— 我-我很抱歉, [master]! 我只是觉得你也希望我看起来不那么凌乱。",

	DAISY_CLOTHES_SIGMUND_OPTION_1 = "我在找人定制连衣裙",
	DAISY_CLOTHES_SIGMUND_REPLY_1 = """你向西格蒙德解释说你的一个奴隶需要换衣服。

— 是的，我们做工作服，但根据你的描述，我认为仆人行会更适合你，阿米莉亚那边的更好。我们并不经常做女孩子的东西。""",
	DAISY_CLOTHES_SIGMUND_OPTION_2 = "谢谢你的提示",

	DAISY_CLOTHES_AMELIA_OPTION_1 = "我在找人定制连衣裙",
	DAISY_CLOTHES_AMELIA_REPLY_1 = """你向阿米莉亚解释说你的一个奴隶需要换衣服。

— 为什么，是的，得体的仆人服装是我们的专长之一。你知道，即使对于不太理想的身体，合适的衣服也会有很大的不同，当然我们有裁缝可以根据任何需要的体型进行调整。但你到底在找什么？""",
	DAISY_CLOTHES_AMELIA_OPTION_2_1 = "我想要一件普通的仆人礼服",
	DAISY_CLOTHES_AMELIA_OPTION_2_2 = "我想要更淫荡的东西",
	DAISY_CLOTHES_AMELIA_OPTION_2_3 = "我改变主意了",
	DAISY_CLOTHES_AMELIA_REPLY_2_1 = """— 公平地说，我们可以为富裕的土地所有者的仆人量身定制一些合适的东西。它将耐用且耐洗。我们还将提供一个备用的，以防发生任何事故。这将花费你150金币。""",
	DAISY_CLOTHES_AMELIA_OPTION_2_1_1 = "成交 (150 金币)",
	DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE = "拒绝",
	DAISY_CLOTHES_AMELIA_REPLY_2_2 = """— 那么你来对地方了。我们可以做一件看起来很正常的仆人连衣裙，但可以方便地进入仆人更私密的区域。此外，面料会微妙地刺激仆人的性感区域，因此他们在工作时会变得并保持兴奋。这会更符合你的喜好吗？我只要你250金币。""",
	DAISY_CLOTHES_AMELIA_OPTION_2_2_1 = "成交 (250 金币)",
	DAISY_CLOTHES_AMELIA_REPLY_3_150 = "您将150金币交给阿米莉亚，并安排黛西与裁缝会面，然后离开。",
	DAISY_CLOTHES_AMELIA_REPLY_3_250 = "您将250金币交给阿米莉亚，并安排黛西与裁缝会面，然后离开。",
	DAISY_CLOTHES_AMELIA_NEW_LEADER_OPTION_1 = """I'm looking for a custom-made dress.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_REPLY_NEW_LEADER_1 = """You explain to Amelia that one of your slaves needs a change of clothes.
	
— Why, yes, proper servants' attire is one of our specialties. You know, the right clothes make a big difference even for less ideal bodies, naturally we have tailors who can adjust for any required body type. But what are you looking for, anyway?""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_OPTION_2_1 = """I want a normal servant dress.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_OPTION_2_2 = """I want something lewder.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_OPTION_2_3 = """I've changed my mind.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_REPLY_2_1 = """— Fair enough, we can tailor something fitting for a well-to-do landowner's servant. It will be durable and resilient to wash. We'll also provide a spare in case of any accidents. This will cost you 150 gold.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_OPTION_2_1_1 = """Deal. (150 gold)""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_OPTION_2_REFUSE = """Refuse.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_REPLY_2_2 = """— Then you've come to the right place. We can make a servant dress which will appear normal, but will allow easy access to the servant's more private areas. Moreover, the fabric will subtly stimulating the servant's erogenous zones, so they will become and remain aroused while at work. This would be more to your liking? I'll only ask you 250 gold for it.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_OPTION_2_2_1 = """Deal. (250 gold)""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_REPLY_3_150 = """You pass 150 gold to Amelia and arrange Daisy's meeting with the tailor, after which you make your way out.""", # MISSING TRANSLATION
	DAISY_CLOTHES_AMELIA_NEW_LEADER_REPLY_3_250 = """You pass 250 gold to Amelia and arrange Daisy's meeting with the tailor, after which you make your way out.""", # MISSING TRANSLATION

	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0 = """黛西穿着她的新裙子站在你面前，幸福得闪闪发光。她的新衣服远胜旧衣服，她开始对你更加忠诚了。

— 您真的为我做了新衣服, [master]. 我从没想过这条裙子会这么好看\n\n{color=green|黛西:成长因素 +1\n黛西:胆小鬼特质丢失}""",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_1 = "很高兴你喜欢它",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2 = "我认为你应该以适合你的立场的方式表达你的感激之情（性因素）",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_3 = "当然，我不能让你穿着破烂在我的豪宅里走来走去",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_1 = "黛西对你微笑，在你的认可下，她又回到了自己的任务中。她的精神似乎有了一些提升。",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_3 = """— 当-当然，我理解。但还是要谢谢你。

黛西礼貌地对你微笑，在你的同意下，她又回到了自己的任务中。""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_0 = """黛西脸红了，她的目光落在你的腹股沟上，一个明显的凸起压在你的裤子前面。 

{color=yellow|黛西: — 哦！当然，主人。我该怎么...}

她穿着漂亮的新裙子站在你面前，双手紧握在腰前，紧张地扭动着。你坚定地、满怀期待地看着她。 """,
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_BAD = """{color=red|失败}

黛西设法克服了她的害羞，给了你一个小小的吻，然后很快转身离开。你考虑更进一步，但太慢了，她已经回到了自己的岗位。""",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_1 = "我们该怎么办？",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_2 = "那是你的错，所以你应该纠正",
	DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_3 = "*低下头*",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_1 = """黛西二话不说，优雅地跪在地上，她为你服务的本能接管了一切。当你解开腰带，拔出你的阴茎时，她带着崇敬的目光抬头看着你，顺从地张开嘴巴，头发向后梳着。

{color=yellow|黛西: — 噢，主人，你对我太好了，我不配这样。}

你把你的阴茎放在她漂亮的脸上，她按照你的指示舔你的蛋蛋。你轻轻抚摸着她毛茸茸的长耳朵，她敏捷的舌头搭在你的耳朵根部，她渴望地轻声呻吟。""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_2 = """黛西清澈的蓝眼睛渴望地凝视着你，她沿着你的阴茎轻轻地舔舐和亲吻。她的口交技巧充其量是业余的，但她渴望取悦你弥补了她的技巧不足。会有足够的时间教她如何正确使用嘴唇和舌头。

你低头看着她，宽容地微笑。她的左手从大腿之间垂了下来，你可以看到她是如何在她认为你不会注意到的时候触摸她的阴部的。当你点头同意她继续时，她对着你阴茎的呼吸会加快。""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_3 = """黛西的舌头从你的阴茎底部一直舔到你肿胀的阴茎头，当她的嘴唇张开，把你带进她感激的嘴里时，她崇拜地抬头看着你。当她的头在你的阴茎上下摆动时，她的另一只手抬起来，开始抚摸你的阴茎，当她的舌头缠绕在你的身体上时，她从未中断与你的眼神交流。

你用手绕着她的头，穿过她柔软的棕色头发，一直到她长长的兔子耳朵，在那里你紧紧抓住了她。当你轻轻但坚定地把她的头拉到你的阴茎上，把你的公鸡头压到她娇嫩的喉咙里时，她轻轻地尖叫。""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_4 = """你把你的阴茎更深地塞进她的嘴里，黛西的眼睛不由自主地流泪了。当你用她的耳朵强迫自己更深地进入她的喉咙时，她在喉咙里的粗阴茎周围呻吟。然而，当你把她的嘴唇紧贴在你的阴毛上，把你的整个阴茎塞进她的喉咙时，她的目光也没有离开你。

她对突如其来的闯入感到不寒而栗，但她会倾听你的声音，并保持喉咙放松，以免塞住嘴。打开路后，你更用力地操她的嘴，当你的公鸡撞到她狭窄的喉咙时，用她的耳朵固定她的头。感觉你的性高潮到来，你慢慢地把你的阴茎从她喉咙拔出来。""",
	DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_5 = """黛西的声音听起来不一样，她在拉长喉咙后气喘吁吁。

{color=yellow|黛西: — 这-这能让你满意吗，主人?}

她的一只手回来抽你的阴茎，另一只手兴奋地摩擦她湿漉漉的阴部。你放开她的耳朵，她就迫不及待地吮吸和舔舐你的阴茎。

你的高潮就像蒸汽火车一样到达，在黛西的脸颊和眉毛上喷上厚厚的一串串精液，然后喷到她等待的嘴里。当你的种子覆盖在她脸上时，她高兴地叹了口气，舔着嘴唇上的黏糊糊的东西咽了下去。她再次把你的阴茎放进嘴里，轻轻地吮吸，直到你睾丸里的精液排干。 

你扣上裤子，低头看着她那张沾满精液的脸，她的眼睛仍然顺从地向上凝视着你。你命令她打扫卫生，并给她一个小时的空闲时间作为奖励。""",


	DAISY_DRESS_ACQUIRED_LEWD_REPLY_0 = """黛西穿着她的新裙子站在你面前。虽然一眼看上去很正常，但你们都知道她的裙子并不像看上去那么简单。黛西紧张地试图避免眼神交流，但你很容易就能看到她的脸红。

— 谢-谢谢你的礼物, [master]. 我希望你喜欢我的新造型。\n\n{color=green|黛西:成长因素 +1\n黛西：胆小鬼特质丢失}""",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_1 = "你看起来很棒",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2 = "不完全喜欢，但我们可以调整它（露出她的身体）",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_1 = """黛西对你的话微微一笑。""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2 = """你走近黛西，拉上藏在她衣服褶皱里的几根绳子。她的胸罩垂下，露出了她丰满的胸部。她的下裙也垂下，展示了淫秽的内衣，并没有对潜在的观察者完全隐藏她的私处。

当你品尝黛西的美丽时，她羞愧地喘着粗气。

— 这-这太尴尬了。我不介意是不是[master]在看，但是...""",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_1 = "好吧，你最好克服尴尬，好好感谢我",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_2 = "这很好地强调了你身体的自然美",
	DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_3 = "这是适合你这样的妓女的衣服",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_1 = """黛西脸红了，她的目光落在你的腹股沟上，一个明显的凸起压在你的裤子前面。

{color=yellow|黛西: — 喔! 主-主人……我能给你拿些点心吗？}

当她露着胸脯不舒服地站在你面前时，她坐立不安。她的双手紧握在腰前，紧张地扭动着。她的乳头很硬，一股鸡皮疙瘩在她赤裸的乳头上翻腾。你坚定地、满怀期待地看着她，然后解开皮带，拔出你的公鸡。

{color=yellow|黛西: — 那是……我不……你在干什么？}""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_2 = """你向黛西招手，把手放在她纤细的肩膀上。她微微颤抖。你一只手随意抚摸她裸露的乳头，手指和拇指轻轻地捏着她的乳头，直到乳头开始变硬。她轻轻地喘着粗气，咬着嘴唇。 

你解释说你为她的衣服花了很多钱，她需要表达她的感激之情。你抓住她的手腕，把她的手放在你僵硬的阴茎身上。她虚弱地抚摸着你的阴茎，既羞愧又不情愿。 

你命令黛西跪下来，她勉强答应了。她光滑的乳头在凉爽的空气中颤动。她凝视着地板。""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_3 = """你命令黛西看着你，她的蓝眼睛转向上方恳求地凝视着你。 

{color=yellow|黛西1: — 求-求你了, 主人. 难道没有别的东西吗...}

突然，你命令黛西张开嘴，在犹豫了一会儿之后，她照做了。她丰满的嘴唇形成了一个完美的“O”形，勾勒出她小小的红色舌头。你的阴茎在期待中抽搐，她退缩了。

你向跪着、半裸的兔子女孩解释你将如何使用她的嘴。她垂下头，把目光移开，却不敢把手从你的阴茎身上移开。""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_4 = """你命令黛西再看你一眼，在她感觉到你的精液在她的皮肤上之前，不要把她的眼睛从你的眼睛上移开。当她抚摸你的阴茎时，你会走近一点，这样你的阴茎就会压在她漂亮的脸上。

你指示她在为你服务时触摸自己。在没有中断眼神交流的情况下，她的手在大腿之间滑动，开始通过内裤按摩她的阴蒂。

操纵你的臀部，你用她的嘴把对准你的阴茎，然后在她柔软的嘴唇之间戳它。你命令她用舌头取悦你，她开始舔你阴茎头上的小圆圈。你可以从她的眼睛里看到压力，但她依然用她的手爱抚你的阴茎。""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_5 = """你用手搂着黛西的头，穿过她柔软的棕色头发，一直到她长长的兔子耳朵，在那里你紧紧地抓住了她。当你把她的头牢牢地拉到你的阴茎上，把你的阴茎头压到她娇嫩的喉咙里时，她尖叫以示抗议。

当你把你的阴茎一路塞进她的嘴里时，黛西的眼睛都哭了。当你用她的耳朵作为杠杆迫使自己更深时，她可怜地呻吟着喉咙里塞满了厚厚的阴茎。你把她的嘴唇紧贴在你的阴毛上，把你的整个阴茎塞进她的喉咙。

黛西被不必要的刺激吓了一跳，开始挣扎，直到你让她放松喉咙。准备好了之后，你更用力地操她的嘴，当你的阴茎撞到她狭窄的喉咙时，用你的双手抓住她的耳朵，让她的头保持不动。每次它滑出时，在你把它推回之前，她的嘴唇紧紧地吸住你的阴茎，她不得不再次吞下。""",
	DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_6 = """几分钟的喉咙性交后，你感觉到你的性高潮正在到来，然后慢慢地把你的阴茎从她身上拔出来。你命令跪着的黛西乞求你的精液。喉咙拉长后，她的声音听起来不一样了，她气喘吁吁。

{color=yellow|黛西: — 主-主人... 结束了吗？求你了?}

一只手在抽你的内裤，另一只手摩擦她的湿内裤。你放开她的耳朵，让她吮吸你的阴茎头，而她却把你扯下来。

你的性高潮袭来，在黛西的脸颊和眉毛上喷上厚厚的一串串精液，然后喷到她张开的嘴里。当你的种子覆盖着她的脸和舌头时，她叹了口气。根据你的命令，她再次把你的阴茎放进嘴里，轻轻地吮吸，直到你的睾丸里的精液排干。

你扣上裤子，低头看着她那张沾满精液的脸，她的眼睛仍然顺从地向上凝视着你。你告诉她把自己打扫干净，给她一个小时的空闲时间作为奖励。""",
	
	DAISY_TRAINING_REPLY_0 = """当你与其他几位土地所有者举行一个小型会议时，你注意到黛西虽然很漂亮，也很受关注，但她并没有以一种适合受过训练的仆人的方式出现。她扰乱了客人的秩序，结结巴巴地道歉。也许，让她接受适当的训练是个好主意。 """,
	DAISY_TRAINING_OPTION_1 = "我想让我的仆人接受培训...",
	DAISY_TRAINING_REPLY_1 = """你向阿米莉亚解释了你认为黛西如何从培训中受益，从而变得更加专业。

— 啊，是的，你胆小的兔女郎。我记得她，她真的很适合当你的仆人，不是吗？当然，我们有训练可以提高她的表现，这取决于你想要什么。""",
	DAISY_TRAINING_OPTION_2_1 = "我希望她能正常训练 (200 金币)",
	DAISY_TRAINING_OPTION_2_2 = "还有哪些其他选项?",
	DAISY_TRAINING_OPTION_2_3 = "还有别的事吗?",
	DAISY_TRAINING_OPTION_2_4 = "我希望她接受正常的性训练 (300 金币)",
	DAISY_TRAINING_OPTION_2_5 = "我想把她变成一个性玩具 (400 金币)",
	DAISY_TRAINING_OPTION_2_6 = "我稍后回来",
	DAISY_TRAINING_REPLY_2_2 = "— 好吧，我知道你希望她接受清洁、服务、懂得适当礼仪等方面的培训。我们可以这样做，或者另外教她用身体服务。没有什么太奇特的，有点自信，有点口语技巧，对她的需求更诚实，就这些了。如果你想知道，她会在很大程度上保持贞洁，因为这种训练不包括任何真正的性交。 ",
	DAISY_TRAINING_REPLY_2_3 = "— 呵-呵，既然你问了，如果你认为她更适合做一些完全不同的事情……我们可以把她训练成一个玩物。她可以同时为很多男人服务，做出有辱人格的行为，并在这件事上玩得很开心。这有点困难，但我相信她完全有这种倾向。在训练期间，她会经常被其他人利用，我相信你理解。",
	DAISY_TRAINING_REPLY_2_1 = """— 一个不错的选择。很高兴能和你做生意，[name]。我保证你会对结果感到满意。

你安排一个时间给黛西训练然后离开。 """,
	DAISY_TRAINING_REPLY_2_4 = """— 一个不错的选择。很高兴能和你做生意，[name]。我保证你会对结果感到满意。

你填写一个小表格，说明哪些动作应该被排除在她的训练之外，并为黛西安排一个参加的时间。""",
	DAISY_TRAINING_REPLY_2_5 = """— 一个不错的选择。很高兴能和你做生意，[name]。我保证你会对结果感到满意。

你填写一个小表格，说明哪些动作应该被排除在她的训练之外，并为黛西安排一个参加的时间。""",
	DAISY_TRAINING_INTERMISSION_1 = """房间里装饰着昂贵的家具，墙上挂着设计精美的窗帘。每个角落都有一盏灯笼，照亮整个空间。在房间的中心，黛西被绑在她赤裸的身体上的细丝绳悬挂着。她的胳膊和腿张开，用一直延伸到房间上角的绳子固定。

黛西的眼睛被浸透的泪水打湿了，嘴里塞满了一只肥阴茎，她一边喘着粗气，一边围着它呻吟。男人在她周围走来走去，检查和抚摸她裸露的乳头和屁股。其中一人用手指戳她的阴部，检查她有多湿""",
	DAISY_TRAINING_INTERMISSION_2 = """在最初的几天里，黛西不明白主人为什么要对她这样做。难道她不够顺从吗？难道她没有尽力取悦他吗？她像一个顺从的奴隶一样吞下了他的精液，并为此心存感激。他怎么会把她送到这个可怕的地方?

她已经在这里呆了一个星期了，这些念头早已忘记了。这是她应得的。这是她应得的。她有三个洞，乞求被阴茎填满，这就是她将要成为的样子。她现在接受了，并尽最大努力适应她的新角色。她急切地咕咕叫着嘴里的阴茎，拼命想讨人喜欢。""",
	DAISY_TRAINING_INTERMISSION_3 = """嘴里那根阴茎的主人在掐住黛西的喉咙时抓住了她的耳朵。另一个男人正在给她涂润滑油，她知道这意味着什么。

{color=yellow|教练 1: — 好吧，这一次没花多久。她很喜欢这只阴茎。她已经不叫了。}

{color=yellow|教练 2: — 哦，是的，她天生顺从。实际上是在乞求被支配。看看她的女阴有多湿。}

当这个男人把两根手指伸进她光滑的阴部并爱抚一段时间后，黛西高兴地扭动着。

{color=yellow|教练 1: — 该死。她是一只混血兔人。如果不是太蠢了，我会给自己买一只的。对吧，荡妇？你是一个愚蠢的婊子，唯一的价值就是你的洞？}

黛西试图点头表示同意，但这很难，因为巨大的阴茎被塞进了她的嘴里，而男人紧紧抓住了她敏感的耳朵。她身后的男人笑了。 

{color=yellow|教练 2: — 哇，看看！她知道。好兔子！}""",
	DAISY_TRAINING_INTERMISSION_4 = """她身后的男人先用一根手指，然后用两根，然后用三根手指伸进黛西滑溜溜的屁股里，前后移动以拉伸她的括约肌。当他用手指爱抚她时，她的臀部在兴奋中抽搐。

{color=yellow|教练 2: — 这个小洞太紧了，可惜她要回去了。}

{color=yellow|教练 1: — 是的，她有点特别，不是吗？我的意思是，她基本上已经训练好了，现在可以出发了。幸运的是，我们又让她呆了一周。}

{color=yellow|教练 2: — 哦，是的，有足够的时间来享受这个优质的屁股，确保她吸取了教训。}

说着，她身后的男人伸出手指，抓住她的屁股瓣，把他的大阴茎猛撞到黛西反应灵敏、训练有素的屁股上。当他在她身上留下痕迹时，她能感觉到他的指甲在她身后柔软的皮肤上挖。 

她猜测，前面的男人已经接近高潮了，因为他松开了她的耳朵，伸手抓住她的乳房，而他的阴茎越来越紧迫地猛戳她的喉咙。""",
	DAISY_TRAINING_INTERMISSION_5 = """她屁股里的阴茎太大了，钻得又快又大。黛西已经学会了最好的取悦方式是急切地承受疼痛，让她的训练师快速地把它克服。她弯曲括约肌，把她的肉壁挤在刺穿她的大阴茎周围，当男人高兴地打她裸露的屁股时，她感到兴奋。

与此同时，身前的男人开始射精。热黏糊糊的精液喷到她的喉咙里，她必须迅速咽下，以免窒息和飞溅，这可能会给她一记耳光或鞭打，具体取决于教练。她听到他高兴地呻吟着，她熟练的嘴唇吮吸着他阴茎身上的每一滴精液，而他像牛头女的乳房一样挤压和扭曲着她下垂的乳头。""",
	DAISY_TRAINING_INTERMISSION_6 = """身后的大阴茎继续无情地扑向她温柔的女阴，黛西专注于用她的肌肉控制来取悦他。她的阴部因自己的兴奋而感到又热又肿，她能再次感觉到屁股受到暴力袭击时脸上的泪水。

后面的男人把手伸进兔子女孩下面，把拇指伸进兔子女孩湿透的阴部。他像保龄球一样把她抱在那里，他的阴茎一次又一次地有力地刺进她的屁股。肛门上的压力足以让她几乎立刻高潮，她希望这正是他想要的，于是她拱起背，疯狂地扑向埋在她体内的阴茎。 """,
	DAISY_TRAINING_INTERMISSION_7 = """黛西感觉到身后的男人很紧张，过了一会儿，他最后用力一推，他的种子淹没了她的屁股。这个男人咕哝着，把他的公鸡从她的屁股里拽了出来，放在她的屁股脸颊之间，这样她就可以感觉到精液喷到了她的背上。

{color=yellow|教练 2: — 操！好一个色情的兔人荡妇！她的屁股差点把我的阴茎绞断！}

{color=yellow|教练 1: — 哈哈，那你就失业了，伙计。啊，好吧，不管怎样，进步很好。建议你下次带上她饥饿的小嘴。} 

{color=yellow|教练2: — 也许我会的。操。你现在有什么计划？想喝杯啤酒吗？}

{color=yellow|教练1: — 是的，听起来不错。别担心，荡妇，我们会派下一班来的。}

黛西听到两个人笑着离开了房间。当另外两名男子走进房间开始解开皮带时，她感觉到精液从她受虐的嘴巴和屁股慢慢流到地板上。""",
	
	TRAINING_COMPLETE_SERVE_REPLY_0 = """当黛西回到你身边时，你会发现她现在的举止更加沉着和成熟。她平时的笨拙几乎消失了。

— [Master], 感谢您对我的投资，在这段时间里，我学到了很多，希望能为您提供更好的服务。""",
	TRAINING_COMPLETE_SERVE_OPTION_1_1 = "很高兴你回来了",
	TRAINING_COMPLETE_SERVE_OPTION_1_2 = "终于，回去工作吧",
	TRAINING_COMPLETE_SERVE_REPLY_1_1 = "— 谢谢。我很好，我在那里受到了很好的对待……我很高兴为了你，我学会了如何更好地控制自己, [Master].",
	TRAINING_COMPLETE_SERVE_REPLY_1_2 = """— 马-马上, [master]...

黛西对你的回答有些失望，她又回到了自己的岗位上。""",

	TRAINING_COMPLETE_SEX_REPLY_0 = """当黛西回到你身边时，你仔细观察她。你注意到她的举止现在更加沉着和成熟了。她平时的笨拙几乎消失了。

— [Master], 感谢您对我的投资，在这段时间里，我学到了很多，希望能为您提供更好的服务。""",
	TRAINING_COMPLETE_SEX_OPTION_1_1 = "演示一下?",
	TRAINING_COMPLETE_SEX_OPTION_1_2 = "很高兴你喜欢它",
	TRAINING_COMPLETE_SEX_REPLY_1_1 = """黛西明显脸红了，但对你的请求点头回应，然后跪在你面前。当她轻轻地从你的裤子里取出你的阴茎时，她通常的紧张几乎没有表现出来。只要轻轻一碰就足以让你兴奋。

— 我很高兴能够报答你的恩情, [Master].

黛西把你的阴茎放进嘴里，小心地用舌头把它卷起来。当她努力地抚摸你的公鸡时，她闭上眼睛，不忘抚摸你的蛋蛋。当她轻声呻吟时，她的熟练程度很快就会让你达到高潮，她会确保你的种子不会从她的嘴里掉出来。当她顺从地吞下你的种子时，她睁开眼睛，回头看着你。

— 如何, [Master]?

她的眼睛流露出真诚的关心. """,
	TRAINING_COMPLETE_SEX_OPTION_1_1_1 = "感觉很棒",
	TRAINING_COMPLETE_SEX_OPTION_1_1_2 = "你也接受过吞咽训练?",
	TRAINING_COMPLETE_SEX_OPTION_1_1_3 = "我想即使你也擅长某件事",
	TRAINING_COMPLETE_SEX_REPLY_1_1_1 = """黛西对你的赞美报以灿烂的笑容。

— 谢谢你, [Master]. 我现在可以更好地为你服务了.""",
	TRAINING_COMPLETE_SEX_REPLY_1_1_2 = """— 嗯，是的。我们在训练中使用了抽水机，还有一袋米浆和一个助手，以防我们被它呛到……这实际上有点有趣。 """,
	TRAINING_COMPLETE_SEX_REPLY_1_1_3 = """— 谢谢你, [Master]. 我现在可以更好地为你服务了.""",
	TRAINING_COMPLETE_SEX_REPLY_1_1_all = """

你送别了黛西，为你被选中参加她的训练而感到骄傲。""",
	TRAINING_COMPLETE_SEX_REPLY_1_2_1 = "— 嗯... [Master], 如果你不介意的话，我相信我现在应该报答你的好意。",
	TRAINING_COMPLETE_SEX_OPTION_1_2_1 = "好啊，来。",
	TRAINING_COMPLETE_SEX_OPTION_1_2_2 = "对不起，我没有心情",
	TRAINING_COMPLETE_SEX_REPLY_1_2_2 = """— 啊，是这样吗？如你所愿, [master].

黛西看起来有些失望，但在离开视线之前，她仍然恭敬地向你鞠躬。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_0 = """当黛西被带回你身边时，你遇到了她。尽管你有所准备，但她没有表现出任何怨恨的迹象，她的举止也有所改善。

— 您好, [Master]. 我随时准备为您服务。任何您想要的服务。

你停顿了一下，考虑一下你是否想立即测试她的训练。 """,
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1 = "散步去吧。",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_2 = "我现在没什么想法。",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1 = """上下打量着黛西，你突然命令她脱光衣服。她立刻服从了，几秒钟后就一丝不挂了，耸耸肩。你把项圈套在她的脖子上，系上皮带。黛西端庄顺从地等待着，你为她准备公开展览。

当你把她带到外面时，你会注意到她对自己公开裸体并不感到羞耻。你牵着黛西穿过小镇，她顺从地跟在你身边。一些路人呆呆地指着这个漂亮的裸体兔人女孩，她像动物一样被牵着走，这让黛西笑了笑，脸红了，她的乳头在兴奋中变硬了。你在思考如何利用她。""",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_1 = "操她",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_2 = "找到一群愿意的陌生人",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_3 = "流浪狗",
	TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_4 = "返回",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_1 = """你牵着皮带把黛西带到阿里昂一个更优雅的郊区。绿树成荫的公园周围矗立着大房子，街上可以看到许多漂亮的仆人在为主人跑腿。在公园里，阿利隆富有的精英们野餐和运动。黛西顺从地跟着你来到其中一个公园中心的一座小山上。

你确定自己吸引了一些公众的注意，以及无数小贵族羡慕的目光，你把黛西推到膝盖上。当你解开皮带，拔出你的阴茎时，她毫不犹豫地低头了。在远处，你可以听到人们欢呼，或者惊讶和愤怒地惊呼。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_2 = """毫不拖延地，你将黛西按在地上，然后骑上她，像动物一样从后面抓住她，同时你猛拉她的皮带。她一点也不抗议，张开臀部，让你的阴茎更容易接近她的阴部。当你在她身上驰骋时，她会随着你的推力而性感地移动屁股。

{color=yellow|黛西: — 我-我的阴户感觉如何，主人？}

当你的阴茎深深地插在她身上时，黛西小心翼翼地左右摇晃她的屁股，以取悦你。到目前为止，一小群人已经聚集在山脚下，但她并不理会他们的惊叫。她只关注你，你的阴茎在她体内移动。 """,
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_3 = """命令黛西做自慰，并用它来配合。几分钟后，她成功了，拱起背部，大声呻吟，她的身体因强烈的性高潮而颤抖。当你从背后拍打她时，她的专业阴户抓住你的阴茎，你感觉到你自己的性高潮很快就要到来了。

你停下站立，命令黛西转身。她跪在你面前，顺从地张开嘴凝视着你，为你服务到最后。你的精液溅到她漂亮的脸上，溅到她的舌头上。她把你含在嘴里，在你再次扣上裤子之前，她从你的阴茎里吸出最后几滴精液。 """,
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_4 = """你把黛西的下巴放在手里，抬头看着你。她有点喘不过气来，但你的精液覆盖了她的脸颊和眉毛，她看起来很开心和自豪。
 
{color=yellow|黛西: — 我做得好吗，主人？黛西是个好女孩吗？}

你猛拉她的皮带，黛西站了起来，脸上还沾满了你的精液。你领着她下山，经过聚集的人群，当你经过时，他们目瞪口呆地站着。你带着你的系着皮带、赤裸的兔人女孩回到豪宅后，她的眼睛明亮，脸上带着狡猾的微笑。""",
	
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_1 = """你牵着黛西一丝不挂地穿过阿利隆的街道，向首都一些较贫穷的街区走去。农民和仆人在街上走在众多乞丐和出售基本商品的商人之间。在几个角落里，奴隶妓女嫉妒地看着黛西，但没有一个流氓敢靠近你。

深入城市的贫民窟，你会遇到六个十几岁的男孩和年轻人组成的团伙。他们大多是街头暴徒，硬汉，学会了团结在一起，在一个对他们毫无用处的世界里生存。他们斜视着黛西，黛西不理他们，但你却招呼他们过去。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_2 = """当男人们走近时，他们好色地盯着黛西的裸体，但她没有试图躲起来或退缩，完全相信你的力量。当你问他们是否愿意花点时间操你的玩具时，你引起他们的注意。他们的头儿，一个比其他人大几岁、伤痕累累的年轻人，咧嘴笑着向你保证他们会的。

你问头儿，今天在一个高级兔人妓女身上为所欲为对他和他的朋友来说有什么价值。在匆匆忙忙的会议后，他们送给你一袋金子。这不是很多钱，但这不是重点。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_3 = """你把黛西的皮带递给伤痕累累的男人，告诉她要做这些年轻绅士的听话荡妇。她点点头，转向首领。其他男人不相信他们的运气，围了过来，粗鲁地摸她的胸部和屁股。布满老茧的手粗暴地按在她的大腿之间，用手指抚摸她的阴部。他们把娇小的兔人女孩拖到附近的一个小花园广场，把她包围起来。

你可以看到黛西四肢着地被推倒，她的脑袋被头儿的阴茎压了下来。当另外两个男人把他们的阴茎放在她手里时，她急切地把它吸进嘴里。一个更大的男人走到她身后，以小狗式骑上她，用他超大的阴茎操她可爱的阴户。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_4 = """黛西被这帮人辛辛苦苦地操了一个多小时，每个人都轮流操她的屁股、嘴巴和阴部。路人停下来观看免费节目，为年轻小伙子们加油。到最后，黛西的全身涂上了一层黏糊糊的精液，她的洞又红又痛。

这群人已经筋疲力尽，欲望枯竭，在事情变得恶劣之前，你就去回收你的奴隶。你命令颤抖的黛西对那些年轻人表示感谢，因为他们像个愚蠢的荡妇一样操着她。她站得不稳，在精液顺着大腿往下跑时行屈膝礼。

{color=yellow|黛西: — 谢谢你们把我的脏洞弄得一团糟。我很高兴被用作你们的荡妇}

年轻人只是笑着挥手。黛西转向你表示疑问，你点了点头。你拽着她的皮带，领着她一瘸一拐地穿过繁忙的街道回到豪宅，在那里你命令她洗漱，然后再继续她的职责。""",
	
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_1 = """你牵着黛西一丝不挂地向阿里昂郊区走去，那里的城市街道与周围的乡村交汇。离市中心这么远的街道上几乎没有人，只有偶尔的农民或警卫巡逻队在监视逃跑的奴隶。 

当你走在绿树成荫的安静街道上时，黛西很安静。她只在与人交谈时说话，但她的身体暴露了她持续的性唤起。她的行为有点像动物，这给了你一个想法。

你看到一只大型流浪猎犬在灌木丛中寻找食物。你扔给他一些食物后，他小心翼翼地走近你。黛西看着你，脸上带着不确定的表情，所以你解开她的皮带，命令她靠近。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_2 = """当你对它的不适微笑时，这只流浪狗嗅她赤裸的阴户和屁股。当你命令它跪下来，把屁股举到空中时，黛西微微皱了皱眉头。在你的指示下，她开始对着狗兴奋地摇晃和扭动屁股，但她的脸无法完全掩饰她的紧张。

小狗好奇地嗅了嗅黛西，然后显然认为这是一个不容错过的好机会。猎犬有力地骑在她身上，它竖起的打结的阴茎扎进了兔人女孩训练有素的阴部。黛西惊讶而痛苦地大叫，看来她所接受的大量训练并没有让她做好准备。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_3 = """当狗拱起黛西听话的阴户时，惊讶从她的脸上消失了，她的本能和训练接管了她。她扭动着，哀嚎着，有节奏地把屁股向后推，进入猎犬疯狂的猛攻。狗的前爪在她的背上艰难地寻找猎物，它凶猛地在她身上发情，舌头伸出。

狗突然叫了起来，黛西哭了，当狗达到高潮时，眼泪从她的眼睛顺着她猩红的脸颊滚落，把它的种子充满了她受虐的阴部。当黛西羞愧地哭泣时，猎犬的阴茎被困在黛西体内长达几分钟，直到它的结缩小，滑了出来。 """,
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_4 = """在你赶走它之前，这只狗又嗅了黛西几次，舔了舔她脸上流下的眼泪。黛西仍然跪在地上，为你强加给她的羞辱而哭泣。当这只狗的脏种子顺着她的大腿流下时，她抬头看着你，眼中充满恐惧和悲伤..

{color=yellow|Daisy: — 谢-谢谢你，主人，这是我应得的。}

你命令黛西手淫，一只手放在她淤青渗出的阴部，她很快就在哭泣之间喘着粗气，达到了泪流满面的高潮。你猛拉皮带，迫使黛西站起来，带着哭泣的、被侵犯的兔人女孩穿过小镇回到豪宅。""",
	TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_4 = """你认为时机不对，就返回豪宅。""",

	DAISY_ADMIRER_MESSAGE = """第二天早上，你收到了一封从未谋面的人的来信。看完信后，你发现一位名叫拉蒙特的地主要求你把黛西卖给他。显然，他发现黛西是一个很有价值的亚种，他希望对其进行试验。

他慷慨地提供了2.500黄金，这笔钱抵得上你迄今为止为她的培训和生活所花费的费用。但黛西是你的财产，你会同意吗？""",
	DAISY_ADMIRER_MESSAGE_OPTION_1_1 = "出售",
	DAISY_ADMIRER_MESSAGE_OPTION_1_2 = "赠送",
	DAISY_ADMIRER_MESSAGE_OPTION_1_3 = "拒绝",
	DAISY_ADMIRER_MESSAGE_REPLY_1_1 = "你决定出售，毕竟，钱会比她更有用。你传唤黛西并通知她你的决定。",
	DAISY_ADMIRER_MESSAGE_REPLY_1_1_1 = """— 这-这样啊... 我明白了。谢谢你照顾我, [master].

你对以这种方式与她告别感到有点沮丧，但你确信金币会解决这个问题。""",
	DAISY_ADMIRER_MESSAGE_REPLY_1_2 = "你认为黛西没有用，也不在乎钱。你把她送出去了，放弃了提供的付款，这让拉蒙特很高兴。",
	DAISY_ADMIRER_MESSAGE_REPLY_1_2_1 = """— 这-这样啊... 我明白了。谢谢你照顾我, [master].

当黛西离开你时，你感到有点难过。""",
	DAISY_ADMIRER_MESSAGE_REPLY_1_3 = "这笔巨款肯定能比黛西的市场价格高出很多倍，但出于某种原因，你当场拒绝了这个提议。也许，你对她太依恋了。",

	DAISY_ADMIRER_FIRST_EVENT_REPLY_0 = """今天黛西在为你服务。当你看到她辛苦工作时，你会想到她现在在你身边放松了很多。她注意到你的目光，转向你。

— 我做错什么了吗, [Master]?""",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1 = "没事",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_2 = "我只是在想你改变了多少",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_3 = "你的屁股太棒了",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2 = """— 我们在一起很长时间了，不是吗, [Master]? 我-我知道我不能这么说，但从你救了我并照顾我的那一天起，我就把你当成了一个从未真正拥有过的家庭。你一定觉得这很傻...""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_3 = """""", # Not implemented > You have a splendid ass
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_1 = "我钦佩你的努力",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_2 = "我一直把你当作我家庭的一部分",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_3 = "事实上，你是奴隶，最好记住你的位置",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_1 = """黛西听到后笑了笑，然后又回到了她的任务中。 """,
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_2 = """— 那-那…太尴尬了。好吧，让我们跳过这个话题，好吗？

黛西明显脸红了，目光移开。""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_3 = """-啊-对, 我很抱歉, [Master].

黛西把目光移开，但你注意到她的情绪明显变低沉了。""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_2 = """当黛西在豪宅周围打扫时，她跌跌撞撞地撞到了其中一个装饰花瓶，导致花瓶掉落并破裂。也许是因为她筋疲力尽，但她用充满恐惧的眼睛看着你。

— 我-我深感抱歉, [Master]!""",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_2_1 = """我不生气。你一定累了。""",
	DAISY_ADMIRER_FIRST_EVENT_OPTION_2_2 = """\"对不起\" 不能在这里救你*惩罚*""",
	DAISY_ADMIRER_FIRST_EVENT_REPLY_2_1 = """黛西看着你，不完全确定你是不是认真的。她似乎很确定你会生气，但你的仁慈似乎改善了她对你的看法。

— 谢-谢谢你, [Master]. 我马上把它清理干净...""",

	DAISY_LOST_MESSAGE = """今天晚上你注意到你的奴隶黛西没有像往常一样完成任务回来。你不确定是什么，但肯定出了问题。黛西不见了，你应该尽快开始寻找她。也许，仆人行会有办法找到她。""",
	DAISY_LOST_AMELIA_OPTION_0 = "我的人失踪了...",
	DAISY_LOST_AMELIA_REPLY_0 = """— 这是一个严峻的情况，我们谴责绑架，即使绑架发生在奴隶身上。我记得那个女孩，你确实派她去接受我们的训练，对吧？有一个地主似乎对她很感兴趣，并问起了她的主人。他的名字叫拉蒙特……他不完全是我们的人。""",
	DAISY_LOST_AMELIA_OPTION_1_1 = "我可能收到了他的来信",
	DAISY_LOST_AMELIA_OPTION_1_2 = "你怎么能把我的信息这样告诉他？",
	DAISY_LOST_AMELIA_REPLY_1_1 = """— 他提出要把她从你那里买走？看来他是我们的首要嫌疑人。他住在城外。你最好在去见他之前做好准备。""",
	DAISY_LOST_AMELIA_REPLY_1_2 = """— 放松点，奴隶主记录是公开的。我知道你现在的感受，但相信我，我站在你这边。不管怎么说，他似乎是我们的首要嫌疑人。他住在城外。你最好在去见他之前做好准备。""",

	DAISY_LOST_APPROACH_REPLY_0_1 = """当你接近所谓绑架者的庄园时，你会看到一群武装雇佣兵注意到你，并开始战斗。 """,
	DAISY_LOST_APPROACH_REPLY_0_2 = """在击败商人后，你看到一个一定是拉蒙特本人的人出来了。

拉蒙特: — 别这样，没有必要再使用暴力了。""",
	DAISY_LOST_APPROACH_OPTION_1_1 = "你有我的东西，我要把她带回去。",
	DAISY_LOST_APPROACH_OPTION_1_2 = "黛西在哪里？你对她做了什么？",
	DAISY_LOST_APPROACH_OPTION_1_3 = "现在把我的奴隶还给我。",
	DAISY_LOST_APPROACH_REPLY_1 = """拉蒙特: — 别那么鲁莽，黛西很好，但请听我说。几周前，我看到她一个人上仆人的课。她表现得那么亲切，那么胆小，那么敬业。我忍不住，我爱上了她。

拉蒙特: — 我给你发过想要她做实验的信息，但这是一个谎言，掩盖了我的真实感受。不管怎样，尽管我愿意付钱，你还是拒绝把她送人。我忍不住了，现在我已经向她表达了我的感受，并照顾她。""",
	DAISY_LOST_APPROACH_REPLY_2 = """拉蒙特: — 我知道她在理论上仍然属于你，但我给你一个赌注。我想给她一个机会，让她决定是想和我在一起还是和你在一起，如果她自愿选择你，我会放弃她。但如果她选择我，她会留在我身边，我会像对待其他人一样对待她。

很有可能，黛西已经尝到了拉蒙特的善意和美好生活的承诺。让她选择你而不是他是一个冒险的决定...""",
	DAISY_LOST_APPROACH_OPTION_FIGHT = "别傻了，她是我的财产，如果必须的话，我会强行带走她",
	DAISY_LOST_APPROACH_OPTION_3_2 = "很好，让我们看看她是怎么想的",
	DAISY_LOST_APPROACH_OPTION_3_3 = "我不能反对你的奉献，你可以拥有她",
	DAISY_LOST_APPROACH_REPLY_FIGHT_1 = "拉蒙特: — 所以非打不可……来吧！",
	DAISY_LOST_APPROACH_REPLY_FIGHT_2 = "在最终成功击倒拉蒙特之后，你迅速冲进他的豪宅，直到在一扇锁着的门后面找到黛西。你把它砸了进去，黛西敬畏地看着你。",
	DAISY_LOST_APPROACH_REPLY_FIGHT_3 = """— [Master]?! 你-你在这里干什么？你是来找我的？很抱歉我失踪了，我不是故意的...""",
	DAISY_LOST_APPROACH_OPTION_FIGHT_4_1 = "我一直在为你担心",
	DAISY_LOST_APPROACH_OPTION_FIGHT_4_2 = "一切都很好，我们以后可以通过一些训练来解决这个问题",
	DAISY_LOST_APPROACH_OPTION_FIGHT_4_3 = "别给我找借口，你这个没用的荡妇",
	DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_good = """— 主-[Master] [name]... 我爱你！我太害怕了，再也见不到你了。

黛西冲过去，用尽全力拥抱你。当你亲吻她的时候，她的脸上露出了你所见过的最幸福的笑容。

当你在这里完成后，你离开拉蒙特的豪宅，回家。""",
	DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_bad = """— 你是说...? 对不起，这种情况不会再发生了。

黛西看起来很不安，不知道该如何回应你的话。如果你认为再呆在那里也没有意义，你就离开并回家。""",
	DAISY_LOST_APPROACH_REPLY_FIGHT_4_3 = """听到你的侮辱，黛西吓得缩了缩，紧紧抓住耳朵。

— 对不起, 对不起, [Master], 请不要生气...

当你爆发完后，你抓住黛西，离开拉蒙特的庄园，回到豪宅。""",
	DAISY_LOST_APPROACH_REPLY_3_2 = """几分钟后，黛西被带到你面前，并向她解释了情况。她看起来非常困惑，站在那里沉默，绞尽脑汁地想起来她最后一次被要求或允许为自己辩护是什么时候，更不用说对自己的未来做出有意义的决定了。""",
	DAISY_LOST_APPROACH_REPLY_3_2_good = """

黛西: — [Master], 你为我做了这么多，我永远不会抛弃你。对不起，拉蒙特先生，我属于我的 [Master], [name]. 我无法回应你的感受。

拉蒙特: — 我明白了... 我理解。很高兴能和你一起度过至少一段时间。 [name], 我真的很羡慕你，但我祝你们俩幸福。

说完，拉蒙特转身离去。""",
	DAISY_LOST_APPROACH_REPLY_3_2_bad = """

Daisy: — 我-我... 想谢谢你, [master], 但我更愿意和拉蒙特爵士呆在一起。对不起...

黛西似乎选择了离开你，也许你对她不太好。接受了你的失败，你就离开了庄园。""",
	DAISY_LOST_APPROACH_REPLY_3_3_1 = """起初，拉蒙特似乎不相信你的话，但在你重复一遍后，他向你鞠躬表示敬意。 """,
	DAISY_LOST_APPROACH_REPLY_3_3_2 = """随后黛西最后一次和你见面。在你祝拉蒙特幸福并离开他的庄园后不久，尽管她看起来很镇定，但她似乎随时都准备哭出来，要么是因为她很开心，要么是因为你放弃了她……""",
	DAISY_CONSENSUAL_1 = """当你完成一些文书工作时，黛西穿着女仆装顺从地站在那里等待。站起来，你花了一分钟的时间检查她，用手抚摸她的身体，轻轻地挤压她的乳房。你问她是否愿意回到你的豪宅。

{color=yellow|黛西: — 是-是的, [Master]. 我很高兴能对你有用.}

你点点头，提起女仆裙的下摆，然后慢慢地把她的内裤从大腿上剥下来，让它们落在她的脚踝上。黛西的呼吸变得急促，她优雅地走出被丢弃的内衣。""",
	DAISY_CONSENSUAL_2 = """你继续检查，露出她的乳房，把手放在大腿之间检查她的阴部。她裸露的阴部摸起来明显很温暖，当你把手指按进她的狭缝时，她光滑的阴唇很容易分开。当你的手指深入她滚烫的小孔时，黛西高兴地喘着粗气，你感觉到她训练有素的内部肌肉收紧了

{color=yellow|黛西: — 喔! 喔, [Master]! 你的手指在我体内感觉很好……大师，你对我太好了...}

当她因需要而颤抖时，眼里噙着泪水。""",
	DAISY_CONSENSUAL_3_SERVE = """{color=yellow|黛西: — 当然, [Master].}
	
黛西顺从地放下内裤，让你轻松地接近她的私处。她准备好后，你就强硬地把她推到桌子上。
	
你把黛西的裙子从她的长筒袜上提起，露出她裸露的屁股。黛西兴奋地扭动着屁股，柔软的屁股脸颊紧贴着你坚硬的阴茎。你把你的臀部向后拉，你的阴茎头找到了她的阴部。当你进入她的身体时，她深深地叹了一口气，她的阴道无助地在你的粗阴茎周围跳动。""",
	DAISY_CONSENSUAL_3 = """你把黛西的裙子披在她的长筒袜上，露出她裸露的屁股。当你的手指挑逗她坚硬的乳头时，她深情地抚摸着你的阴茎，把你的阴茎头压在她颤抖的大腿之间。

你的手绕着黛西的脖子，把她的头拉到桌子上。她的手再也够不到你的阴茎了，所以她用手把屁股瓣分开。你抓住她的喉咙，把她的头向后拉一点，同时把她的肚子压在桌子上。当她在欲望中呻吟时，她湿漉漉的阴部摩擦着你的阴茎。

黛西兴奋地扭动着屁股，柔软的屁股瓣紧贴着你坚硬的阴茎。你把你的臀部向后拉，你的阴茎头找到了她的阴部。当你进入她的身体时，她低着腰趴在桌子上，深深地叹了一口气，她的阴道无助地绕着你的粗阴茎跳动。""",
	DAISY_CONSENSUAL_4 = """当你的阴茎扎进黛西湿漉漉、听话的阴部时，你把黛西重重地推过桌子，把她的屁股撞在木头表面上。当你反复把你的阴茎深入她体内时，她高兴地尖叫起来，她的兔子尾巴兴奋地上下摆动，而她的乳头擦着桌面。

{color=yellow|黛西: — 啊-啊, [Master]... 你太粗暴了!..}

当黛西的整个身体在高潮中颤抖时，她的阴部紧紧地夹住你的阴茎。你不停地捶打她，你自己的高潮很快就要到来了，因为她丝滑的阴部在你的肉周围痉挛。你放开她的喉咙，这样你就可以抓住她的臀部，更用力地操她。

当你把你的阴茎完全埋在黛西身上时，黛西恳求地回头看着你。她的屁股紧贴着你的臀部，试图把你带得更深，你感觉到你的阴茎头压在她的子宫上。""",
	DAISY_CONSENSUAL_5 = """{color=yellow|黛西: — [Master]!... 我就要……来了！}

你的性高潮袭来，你将大量粘稠的精液深深地注入黛西顺从的阴部。当她摇晃着回到你身上时，她阴部的内部肌肉紧紧抓住你的阴茎，把每一滴精子都吸入她体内。当她回头看你时，她上气不接下气，满脸通红。

随意地，你打她几下屁股，当她屁股变红时，你会捏她屁股上有弹性的肉。你把你的阴茎从她的洞里滑出来，你的精液开始从她的阴部泄漏，慢慢地顺着她裸露的大腿流到她的袜子里。

{color=yellow|黛西: — 谢谢你, [Master]... 我爱你.}""",


	
	DAISY_EXTRA_STRATUP = "— 你-你好, [Master]. 需要我做什么?",
	DAISY_EXTRA_OPTION_1_1 = "为什么我们不改变一下衣服的样式？",
	DAISY_EXTRA_OPTION_1_2 = "你可以遮起来 ",
	DAISY_EXTRA_REPLY_1_1_NO = """— 如-如果你想要, [master]. 

黛西看起来很担心，但不敢反对你的要求。只要一个简单的动作，她的制服就会露出她的私处，让你感到高兴。""",
	DAISY_EXTRA_REPLY_1_1_YES = """— 请欣赏我的身体, [Master]. 

黛西毫不掩饰地服从你的要求。只要一个简单的动作，她的制服就会露出她的私处，让你感到高兴。""",
	DAISY_EXTRA_REPLY_1_2_NO = """— 谢天谢地...

黛西把衣服修成更隐蔽的形状，看起来松了一口气。 """,
	DAISY_EXTRA_REPLY_1_2_YES = """— 如您所愿, [Master]. 

黛西漫不经心地整理着她的裙子，等待着你的进一步指示。""",
	
	AMELIA_SILK_STARTUP = """— 我注意到你最近为我们做了很多工作。但我们有一个小问题，如果你能帮忙，我很高兴。我们的一位富有客户要求提供特殊服装。

— 然而，我们缺乏生产这些产品的资源。如果你能给我们50块丝绸，我们很乐意花2000金币和一套备用服装购买。我相信这对你来说不费吹灰之力。""",
	AMELIA_SILK_OPTION_START = "我有你需要的丝绸",
	AMELIA_SILK_REPLY_START = "— 我就知道我可以依靠你, [name]. 这是我答应的奖励。你知道，既然你足智多谋，我想为你提供额外的奖励。一个特殊的按摩听起来怎么样？",
	AMELIA_SILK_OPTION_1_1 = "当然，我没有理由拒绝",
	AMELIA_SILK_OPTION_1_2 = "我想，我要拒绝",
	AMELIA_SILK_REPLY_1_2 = """阿米莉亚对您的回复有些失望。

— 这太糟糕了。好吧，祝你今天好运。""",
	AMELIA_SILK_REPLY_1_1_1 = """阿米莉亚面带狡诈的微笑，带你来到仆人行会的一间私人房间。房间里烛光柔和，温暖的空气中弥漫着淡淡的甜味。中间放着一张舒适的软垫桌子。

{color=yellow|阿米莉亚: — 嗯，你为什么不把衬衫脱下来躺下？我来准备油。}

当你脱下上半身的衣服，感到舒适时，阿米莉亚轻声呢喃。 

{color=yellow|阿米莉亚: — 你要知道，我曾想过带我的优等生来找你，一个有天赋的年轻荡妇，有着技艺高超的双手。但后来我想，这有什么乐趣？}

她走近桌子，尾巴左右摆动。""",
	AMELIA_SILK_REPLY_1_1_2 = """{color=yellow|阿米莉亚: — 噢，打令，看！你全身都是结实的MUSCLE呀♡...}

阿米莉亚细腻的手指从你的脖子轻轻地抚摸到你的腰部，在那里停留了一会儿。她将柑橘和椰子香味的精油涂抹在手上，开始按摩。

当阿米莉亚的手在你的背上缓慢而有力地抚摸时，你会感觉到你的身体在放松。她的手指抚摸着你肩膀和两侧的大块肌肉。她的小拳头轻轻地打鼓，以一连串的轻柔重击快速击打你的身体，释放出你不知道的紧张感。""",
	AMELIA_SILK_REPLY_1_1_3 = """阿米莉亚靠在你身上，将舒缓的精油深深地涂抹在你的背部皮肤和手臂上。她纤细的臀部靠近你的脸，当她弯腰施加压力时，你会感觉到她柔软的乳房擦伤了你的身体。 

按摩持续几分钟，优雅的猫女的双手将你带到一种深度放松的状态，她的身体轻轻地拂过你自己的身体。即使在你平静的时候，你也能感觉到你靠着桌子越来越勃起的压力。

{color=yellow|阿米莉亚: — 你为什么不翻身，先生，让我按摩你的胸部?} """,
	AMELIA_SILK_REPLY_1_1_4 = """你仰卧，从裤子里可以清楚地看到你的勃起。阿米莉亚靠在你身上，轻声地发出呜呜声，她光滑的手从你的臀部轻轻地伸到你的肩膀，她的大乳房瞬间挤压着你僵硬的阴茎。

{color=yellow|阿米莉亚: — 按摩是一种很好的技巧，可以帮助人们放松和缓解压力，但如果只是用来按摩的话，那肯定是浪费。}

当阿米莉亚开始用不同的方式触摸你时，她的声音变得更柔和、更柔和。这里是柔和的按压，那里是有力的一击。就像被她的爱抚迷住了一样，你感觉到你的欲望正在翻涌。阿米莉亚的手从你的两侧一直伸到臀部，伸到你隆起的腹股沟。当她感觉到你裤子中的坚挺时，她诱惑地咯咯笑着。

{color=yellow|阿米莉亚: — 哦，我看你很享受这一点。能亲自得到行会领袖的服务真是太荣幸了，是吗？}""",
	AMELIA_SILK_REPLY_1_1_5 = """你抬起臀部，把裤子顺着腿往下滑，露出你完全勃起的阴茎，骄傲地挺立着。阿米莉亚发出毫不掩饰的喜悦之声。

{color=yellow|阿米莉亚: — 哦，令人印象深刻！你的男子汉气概很棒，很有活力。很高兴为你服务，先生。}

阿米莉亚慢慢地解开缎面衬衫的扣子，露出性感的胸部。她在坚硬的乳头上用油乎乎的手指画出小圈，当她向你的阴茎倾斜时，优雅地拱起背部。

{color=yellow|阿米莉亚: — 如果你高兴的话，大人？}

不等回答，阿米莉亚就把她那沉重的奶头抱在手里，把它们压在你的公鸡身上。她从臀部开始，挤压乳房，按摩你的阴茎。当她轻轻地上下弹跳，你的阴茎被她的乳沟拥抱时，油涂抹在她光滑的皮肤上。""",
	AMELIA_SILK_REPLY_1_1_6 = """当你的阴茎在胸部之间滑动时，阿米莉亚把下巴收起来，开始舔你的阴茎头。每次弹跳，她的舌头都会越来越近，直到你的阴茎到达她热切的嘴唇，她把它吸进嘴里。她熟练地吮吸你，同时继续用乳头按摩你的阴茎。

尽管阿米莉亚作为行会领袖的地位很高，但你可以感受到她为一位强大的主人服务的强烈愿望，因为她提供了你所经历过的最完美的口技。她精湛的嘴唇和舌头把你的阴茎逗弄得前所未有的坚硬，当你的臀部向上抽搐时，你的脚趾会卷曲，试图更深地压进她那天才的嘴里。 """,
	AMELIA_SILK_REPLY_1_1_7 = """你即将达到的高潮达到了你从未想象过的程度，当阿米莉亚把你的阴茎从嘴里滑出来，用舌尖抵住你悸动的轴看着你的眼睛时，你抓住了桌子的两侧。

你再也忍不住了，咕哝一声，喷出一股混浊的精液，雨点般落在阿米莉亚的脸上和伸出的舌头上。当她在你的阴茎上舔舐时，你的阴茎继续喷出，你只能看着阿米莉亚的舌头小心翼翼地舔着你疼痛的阴茎上的黏糊糊的液滴。

{color=yellow|阿米莉亚: — 天哪，好多精液。我脸上到处都是！还有这么浓的麝香。你觉得我的按摩很愉快, [name]?}

你一声不吭地点头，此时此刻你的智慧已经遥不可及.""",
	AMELIA_SILK_REPLY_1_1_8 = """当你回到仆人协会的前台时，阿米莉亚的笑容看起来不一样了——更温暖，更个性化。

{color=yellow|阿米莉亚: — 谢谢你为我提供这么多…丝绸。我希望这次经历能加强我们未来的业务关系？我当然期待着进一步的私人会面。}""",
	
	AMELIA_SILK_OPTION_2_1 = "你的商业头脑让我大吃一惊",
	AMELIA_SILK_OPTION_2_2 = "很高兴能和你做\"生意\"，阿米莉亚",
	AMELIA_SILK_OPTION_2_3 = "也许我们可以再安排一次这样的会面？",
	AMELIA_SILK_REPLY_2_1AND2 = "我向你保证，这种感觉是相互的。现在，如果你能原谅我，有些事情我真的必须去做。请一定再来。",
	AMELIA_SILK_REPLY_2_3 = "哦-哦，很大胆嘛。很好，我保证会考虑让我的秘书检查我的日程表。她会联系的。不过目前，我还有一些其他事情急需处理。",
	
	AIRE_RECRUITMENT_OPTION_1 = "我想要精灵女孩",
	AIRE_RECRUITMENT_REPLY_1 = "— 哦，公主的仆人？好吧，我们再也不用她了。",
	AIRE_RECRUITMENT_REPLY_BAD_START = "— 你认为你做了这么多之后，我会为你服务吗？",
	AIRE_RECRUITMENT_OPTION_BAD_1 = "尝试解决问题永远不会太迟",
	AIRE_RECRUITMENT_OPTION_BAD_2 = "不管我怎么想，你都有自己的主意",
	AIRE_RECRUITMENT_OPTION_BAD_3 = "也许我只是想亲自折磨你",
	AIRE_RECRUITMENT_REPLY_BAD_1 = """艾尔看了你一眼，眼神中没有肯定的意思。

— 我不是那种傻瓜。无论如何，我会让你付出代价的。 """,
	AIRE_RECRUITMENT_REPLY_BAD_1_ANA = """并将从你手中救出安娜。 """,
	AIRE_RECRUITMENT_REPLY_BAD_2 = """艾尔听到解雇的消息后沉默了。没有进一步的讨论，你就把她带走了。""",
	AIRE_RECRUITMENT_REPLY_BAD_3 = """— 有你在身边本身就是一种折磨。

艾尔似乎对你的话无动于衷，静静地听从你的命令。""",
	AIRE_RECRUITMENT_REPLY_GOOD_START = """— 你真的做到了……我想我别无选择，只能现在加入你？""",
	AIRE_RECRUITMENT_OPTION_GOOD_1 = """我不会违背你的意愿强迫你""",
	AIRE_RECRUITMENT_OPTION_GOOD_2 = "你更喜欢呆在地牢里？",
	AIRE_RECRUITMENT_OPTION_GOOD_3 = "没错，你最好像一只好狗一样听话",
	AIRE_RECRUITMENT_REPLY_GOOD_1 = "— 我很感激。不管怎样，我不想烂在这里。",
	AIRE_RECRUITMENT_REPLY_GOOD_2 = "— 啧。很好，我等不及要去看安娜了。",
	AIRE_RECRUITMENT_REPLY_GOOD_3 = "艾尔对你的话保持沉默，但她的脸表明她怀疑自己对你的最初看法。",



	AMELIA_HERBS_LETTER = "第二天早上，你收到一张来自仆人行会的小纸条，要求你去见领袖。",
	AMELIA_HERBS_OPTION_START = "我收到了你的信...",
	AMELIA_HERBS_REPLY_START = "— 很高兴看到你一如既往, [name]. 新工作如何?",
	AMELIA_HERBS_OPTION_1_1 = "不能抱怨，掌权真好",
	AMELIA_HERBS_OPTION_1_2 = "没什么特别的，你无论如何都不让我做任何事情",
	AMELIA_HERBS_OPTION_1_3 = "开门见山",
	AMELIA_HERBS_REPLY_1_1 = "— 我很高兴你很享受，毕竟我们荣辱与共。",
	AMELIA_HERBS_REPLY_1_2 = "— 哈哈，我想这在一定程度上没错，但这很好，你知道，我在我的职位上也做不了什么。如果这能提供任何有意义的力量，没有人会让我们来到这里。但至少我们可以享受这种生活的奢侈。",
	AMELIA_HERBS_REPLY_1_3 = "— 哦，拜托，别那么紧张。你真的这么不喜欢我的行会吗？",
	AMELIA_HERBS_REPLY_2 = """— 考虑到你之前在精灵森林的经历，我相信你会很成功地完成一项任务。你看，在大树附近，精灵们崇拜一种可以生长的特殊植物——玛娜之息。我们的一些赞助人甚至愿意为此付出高昂的代价。事实上，这个生意非常赚钱。

— 我们有一个供应商，但我们的快递员生病了，可能很快就要辞职了。我想让你去那里拿商品。他们应该已经收到了下一次交货的付款，所以你只需要找到他们。 """,
	AMELIA_HERBS_REPLY_3 = """— 你应该知道，精灵的官员通常不太喜欢与我们进行交易，而且在这种不寻常的情况下也是如此。尽量保持低调。不管怎样，这是一张说明你必须找到谁的纸条。我相信你会成功的。""",
	
	AMELIA_HERBS_ELF_OPTION_START = "寻找走私者",
	AMELIA_HERBS_ELF_REPLY_START_1 = "在四处寻找了一段时间后，你终于找到了一个符合描述的人：一位年轻的部落精灵女祭司。当她看到你时，她巧妙地给了你一个手势，让你在周围没有人的地方与她见面。你跟着她，不需要再多加注意。",
	AMELIA_HERBS_ELF_REPLY_START_2 = """你把纸条递给她，并解释你在这里做什么，但她的回答是拒绝。

— 对不起，我不能再这样了。我不会和你交易。""",
	AMELIA_HERBS_ELF_OPTION_1_1 = "你不能这样",
	AMELIA_HERBS_ELF_OPTION_1_2 = "我不明白，为什么？",
	AMELIA_HERBS_ELF_OPTION_1_3 = "你现在是不是疯了？",
	AMELIA_HERBS_ELF_REPLY_1 = """— 我不能再这样做了，当时我很绝望，但如果我被抓住，一切都会结束的。我已经是一个嫌疑人了。由于我不是土生土长的人，我会因此受到严厉的惩罚……所以你必须明白，我不会再这么做了。我还不能退还货款，但我很快就会采取措施。""",
	AMELIA_HERBS_ELF_OPTION_2_1 = "我想，那就无能为力了...",
	AMELIA_HERBS_ELF_OPTION_2_2 = "看，我真的需要那批货 (魅力检定)",
	AMELIA_HERBS_ELF_OPTION_2_3 = "我可以再付给你一些，但我真的需要它（300金币）",
	AMELIA_HERBS_ELF_OPTION_2_4 = "那样的话，我会告诉警卫你确实是走私犯",
	AMELIA_HERBS_ELF_REPLY_2_1 = """— 感谢您的理解，再见。

精灵女孩默默地回到她的职责中，让你思考如何告诉阿米莉亚这件事。""",
	AMELIA_HERBS_ELF_REPLY_2_2_GOOD = """{color=green|成功}

精灵女孩犹豫了一段时间，但最终还是答应了你的要求。

— 很好，但我恳求你，再也不要来这里了。 

她离开了，几分钟后她带着包裹回来了。 """,
	AMELIA_HERBS_ELF_OPTION_2_2_DONE = """谢谢，再见""",
	AMELIA_HERBS_ELF_REPLY_2_2_BAD = """{color=red|失败}

— 对不起，你得想办法了。 """,
	AMELIA_HERBS_ELF_REPLY_2_3 = """当你拿出一个钱包时，精灵女孩似乎放弃了，按照你的意愿做了。

— 很好，但我恳求你，再也不要来这里了。

当她把金币藏在衣服里时，她几分钟后就回到你身边，经过马车，迅速撤退。""",
	AMELIA_HERBS_ELF_REPLY_2_4_1 = """当女孩听到你的话时，她的脸上充满了恐惧。

— 不，求你了... 别这样。

意识到你的严肃，她低下头。

— 你赢了，请在这里等着...""",
	AMELIA_HERBS_ELF_REPLY_2_4_2 = """几分钟后，她回来把货物递给你

— 给。但我恳求你，不要再来这里，我不会再这样做了。""",
	AMELIA_HERBS_ELF_OPTION_2_4_2 = "谢谢，再见。",
	
	AMELIA_HERBS_ELFQUEST1_START = """读完后，你意识到这是你的老熟人。当你见到她时

— 哦，那个东西？好的，给你。但请告诉阿米莉亚，我不会再这样做了。""",
	
	AMELIA_HERBS_ELFQUEST2_START_1 = """在寻找一名可能的走私犯后，你意识到你被跟踪你的警卫发现了。当他们走近你时，他们要求你跟随他们。""",
	AMELIA_HERBS_ELFQUEST2_START_2 = "— 又是你。我们知道你这次来这里是为了什么。非法走私我们的圣草。另一个罪犯已经被抓获并受到惩罚。鉴于你之前的功绩，我们将对此视而不见，但永远不要再这样做了。",
	
	AMELIA_HERBS_END_OPTION_START = "关于交易",
	AMELIA_HERBS_END_REPLY_START = """当你把货物递给阿米莉亚时，你注意到她的耳朵是如何惊讶地竖起的。

— 我就知道我可以依靠你！这次我已经没有信心拿到它了。必须说，我们的合作是我一生中最好的伙伴关系之一。但是，无论如何，你一定对你的奖励非常期待。这是500金币。

— 我想说，你是一个很棒的地主。坚强、能干、果断。。。这在我们这个时代真的很罕见。我不会轻易提出，但你今晚愿意和我一起去我家吗？这不是任何一天都会提供给你的东西。""",
	AMELIA_HERBS_END_OPTION_1_1 = "对不起，我很忙",
	AMELIA_HERBS_END_OPTION_1_2 = "我还担心你不会问",
	AMELIA_HERBS_END_REPLY_1_1 = """阿米莉亚看起来明显很失望，但很快就像往常一样掩饰了自己的情绪。

— 所以…我明白了，祝你好运，不管你要做什么。""",
	AMELIA_HERBS_END_REPLY_1_2_1 = """— 我就知道我们心灵相通。现在，我需要一些时间来准备。我很长时间没有接待客人了。

收到指示后，你离开阿米莉亚的办公室。""",
	AMELIA_HERBS_END_REPLY_1_2_2 = """夜幕降临，你来到了阿米莉亚庄园的门口。几个下级仆人让你进来，警惕地看着你，但立即被阿米莉亚解散。""",

#— 你一如既往地敏锐, [name]. 希望你在来的路上没有砍伤任何人，呵呵。 

#当阿米莉亚为你供应一款顶级葡萄酒时，你决定聊几句。 """,
	AMELIA_HERBS_END_REPLY_1_2_3 = """— 你知道，我对你不是很真诚……我想对其他人也不是了。但我希望你能听我说完。在成为领袖之前，我也是一名仆人。我听说没有多少领袖碰巧曾经是仆人而不是主人，但我想我很幸运。

— 我有一个主人，而且在这方面非常严格，但如果我说我不喜欢它，那我就是在撒谎。这是一个轻松、粗心的时代，我有时想回到过去。我认为猫需要一个主人。一个所有者...""",
	AMELIA_HERBS_END_REPLY_1_2_4 = """— 我认为你正是能帮助我……重温这些感受的合适人选。

陷入困境的那一刻，你别无选择，只能点头表示同意。

— 你总是那么热心地帮助我。那么，请给我几分钟时间做准备。

阿米莉亚说完离开，你有点想知道她在干什么.""",
	AMELIA_HERBS_END_REPLY_1_2_5 = "过一会儿，你听到她叫你进入卧室。",
	AMELIA_BONDAGE_1 = """{color=yellow|阿米莉亚: — 我明白了，一如既往地准时。甚至有点锋利。希望你在来这里的路上没有割伤任何人。}

阿米莉亚听到她的笑话咯咯笑了起来。她欢迎你进入一间设备豪华的客厅，并让你在一张长沙发上放松。她带来一瓶阿利隆最好的葡萄酒，并为您端上一个盛满酒杯。

你闲聊一会儿，聊聊天气，聊聊行会。阿米莉亚思维敏捷，是个有趣的伙伴。当你说话的时候，她在沙发上慢慢靠近你，直到她的膝盖碰到你的膝盖。你把手放在她的大腿上，她发出呜呜声。阿米莉亚放下酒，转向你，脸上带着严肃的表情。

{color=yellow|阿米莉亚: — 我要坦白, [name]. 我对你不太诚实。当然，对其他人也不一样，但我有件事想告诉你。}

你啜饮着酒，示意她继续。""",
	AMELIA_BONDAGE_2 = """{color=yellow|Amelia: — 在我成为领袖之前，我是一名仆人。仆人阶层的帮主并不多，大多数都是主人出身。我想你可以说我很幸运。}

你举杯祝她好运。

{color=yellow|阿米莉亚: — 作为一个仆人，我自然有一个主人。一个非常严格的主人。他严厉地管教我，但如果我说我不喜欢，那我就是在撒谎。}

你对她的供词竖起眉毛，想知道这会导致什么。

{color=yellow|阿米莉亚: — 尽管有……严肃，但当一个丫鬟对我来说是一段无忧无虑的时光。有时我希望我能回到那时，以逃避行会领袖的职责。}

阿米莉亚把手放在你的手臂上，慢慢地往下划，直到你的手放在她那条长着袜子的大腿上。

{color=yellow|阿米莉亚: — 我认为猫需要一个坚强的主人。有人照顾它们，偶尔惩罚它们？}""",
	AMELIA_BONDAGE_3 = """美丽的猫女抬头看着你，一边咬着嘴唇，一边把你的手拉到大腿上。
0
{color=yellow|阿米莉亚: — 一个占主导地位的主人，他们可以尊敬和依赖他，他们信任他的权威。谁知道如何坚定地对待他们。} 

阿米莉亚分开膝盖，鼓励你把手伸进她的裙子下面。你感觉到她裸露大腿的热量，你的手指发现她没有穿内裤。她的阴部又热又湿。当你抚摸她的狭缝时，她轻轻地叹了口气。

{color=yellow|阿米莉亚: — 我希望……你就是帮助我重温那些日子的人。重新找回对一个强大男人顺从的宠物的感觉。}

你别无选择，只能同意。阿米莉亚发出咕噜声。

{color=yellow|阿米莉亚: — 你总是对我这么好, [name]. 请给我一点准备，然后到我的房间来。} 

阿米莉亚跳起来，从她的肩膀上向你撒娇地咧嘴笑了笑，然后从门口消失了。""",
	AMELIA_BONDAGE_4 = """一分钟后，你听到阿米莉亚把你叫到她的卧室。

当你打开门时，你看到一张四柱大床和一把紫色毛绒扶手椅。房间中央的滑轮上挂着一个皮革背带，阿米莉亚在床上放了一些绳子、球拍、鞭子、袖口和夹子。

这位苗条的猫女站在滑轮下面的中央，只穿着长筒袜和一件露脐紧身胸衣，展示她性感的胸部。

{color=yellow|阿米莉亚: — 噢，主人，你来了。我-我一直是个坏女孩。我应该受到惩罚}

阿米莉亚猫一样的眼睛睁得大大的，欲望使她脸红，长长的尾巴左右摆动。

你穿过房间，抓了一把头发，把她的头往后拉。当她对你突然的强势抱怨时，她美丽的脸上掠过一丝微笑。你的另一只手在她身后伸手抓住屁股的脸颊，用力捏得很疼。

{color=yellow|阿米莉亚: — 是的，主人，给我一个我不会忘记的教训。让我看看纪律意味着什么。}""",
	AMELIA_BONDAGE_5 = """阿米莉亚挑衅地在你身上扭动，摩擦着她的乳房，并在你肌肉发达的身体上斜着。抓住她的头发，你把她拖到床上。你拿起手铐，把阿米莉亚弯过来，把她的手臂拉到后面，把手铐扣在手腕上。她把赤裸的屁股摩擦到你的腹股沟，她的尾巴在你裤子的凸起处来回摆动。

你抓了一卷细丝绳，把阿米莉亚拖到房间中央。拉下安全带，你会把它的皮环套在她的上半身。当你捆绑阿米莉亚时，她开始在无法控制的觉醒中气喘吁吁。

你把绳子绑在她的腹部，紧紧地绑在她隆起的乳房上，然后绑在她的锁骨上，把她的手臂固定在两侧。拉着滑轮，阿米莉亚猛地站了起来。 

你抓住她的小腿，抬起一条腿，弯曲它，直到膝盖几乎碰到她的脸。你把它绑好，把脚紧紧地绑在她的屁股上。当你站在后面欣赏你的绳索时，她激动地呜咽着。""",
	AMELIA_BONDAGE_6 = """在阿米莉亚湿漉漉的阴部任由你摆布的情况下，你放开你的阴茎。她一看到你勃起的阴茎就淫荡地呻吟，眼中充满了原始的欲望。你问她是否准备好像任性的荡妇一样被惩罚。

{color=yellow|阿米莉亚: — 哦，是的，主人。操我吧，主人。让我服从。} 

你抚摸着她脆弱的身体，揉捏着她的乳房，捏着她屁股柔软的肉。你的阴茎摩擦着湿漉漉的阴唇，阿米莉亚愈发敏感。你的手向上移动，一只手抓着乳头，一只手抓着她的头发，慢慢地进入她光滑的阴部。她试着扭动她的臀部来促使你更深，但她几乎无法移动。 

当你的大阴茎深入时，阿米莉亚狂喜地叹了口气。她的眼睛向后翻，她紧绷的阴部在你周围抽搐。每一次缓慢而刻意的用力，她都会再次发抖，她的阴部疯狂地痉挛了几分钟。当你把身体压在她身上时，你捏着她的乳头，当她大口呼吸时，你把淫语悄悄地塞进她的耳朵。""",
	AMELIA_BONDAGE_7 = """{color=yellow|阿米莉亚: — 噢，主人……操死我，主人...}

你更卖力的运动，无情地拍打着阿米莉亚的阴部。你用你的手抓住她的乳房和头发，用力地把自己撞到她的阴部，足以擦伤柔软的肉。当你捶打阿米莉亚时，她疯狂地尖叫，直到你用手捂住她的嘴来压制她的哭声。

一旦她的尖叫声平息，你就用双手抓住她的细腰，这样你就可以更用力地操她了。你的两个身体都被汗水覆盖着。当你的阴茎猛烈地刺进阿米莉亚的阴部时，她大声地喘着粗气。你感觉自己的高潮很快就要到来了。

{color=yellow|阿米莉亚: — 射在我里面，主人，请在射我不听话的小婊子里面！}

你最后有力的顶胯把她抬离了地板。你的阴茎受到了巨大的压力。当你的精液射入她遍体鳞伤的阴部时，她挂在你身上。当你的精液射入阿米莉亚体内时，阿米莉亚低吟着，背拱着，当你退出时，她渴望地叫着。""",
	AMELIA_BONDAGE_8 = """阿米莉亚单腿站立时轻声低吟，精液从她肿胀的阴部顺着袜子往下流。你问她是否吸取了教训，或者她是否需要进一步的训练。

{color=yellow|阿米莉亚: — 哦，是的，主人，我学得很好。我记得我现在是什么样的人。}

你把她红肿的阴部抱起来，在她的脸上和头发上涂一把精液。你解开她抬起的腿，让她双脚站立，然后松开绳子，取下安全带。她摇摇晃晃，仍然戴着手铐，大腿分开，以缓解她柔软的阴部的疼痛。你坐在扶手椅上，把她拉过膝盖。

你本来打算马上解开手铐，但她颤抖的屁股太诱人了。你粗暴地打她屁股，她每次都会大叫。

{color=yellow|阿米莉亚: — 谢谢你，主人……这是我应得的。}

你把她打到另一个高潮，而她被绳子磨伤的乳头摩擦着你的阴茎。最后你解开她的头发。她啜泣着，爬到你的腿上拥抱你，她美丽的身体因感激之情而颤抖。""",
	AMELIA_BONDAGE_9 = """半小时后，回到客厅，阿米莉亚把酒杯清理干净。她小心翼翼地走到门口，停顿了一下，回头看了看你在沙发上休息的地方。

{color=yellow|阿米莉亚: — 嗯，你真是个绅士, [name]。你真的知道如何让一个女孩玩得开心。自从我被任命为领袖的那一天起，我就不那么……开心了。他们说一切美好的事情都必须结束，但我希望有一天我们能有机会再次这样做。}

混血猫人笨拙地走到自己的房间门口，然后消失了。你让自己出去，然后回到豪宅。""",
#	AMELIA_BONDAGE_10 = "漂亮的混血猫人笨拙地走到厨房，然后消失了。你放开自己，回到了豪宅。",
#
#	AMELIA_BONDAGE_OPTION_1 = """我会等下一次""",
#	AMELIA_BONDAGE_OPTION_2 = """那是我不会忘记的时刻""",
	AMELIA_HERBS_END_REPLY_START_FAIL = """— 哦，天哪，真是太遗憾了。不过我早就预料到了。好吧，我想我现在得找另一个供应商了。现在，我要离开了...

阿米莉亚为了她的事离开了你，让你一个人呆着。""",
	
	MARRIAGE_CHURCH_CORE = """我想安排一场婚礼""",
	MARRIAGE_CHURCH_FINISH_CORE = """我准备好参加婚礼了""",
	MARRIAGE_CHURCH_DEFAULT = """— 非常抱歉，由于持续的冲突，我们目前无法提供此类服务。希望很快结束。""",
	MARRIAGE_CHURCH_TEXT_1 = """— 啊，你想订婚吗？太好了！市长的婚礼可不简单。我能知道你选谁吗？""",
	MARRIAGE_CHURCH_TEXT_2 = """— 我明白了，我明白了。我很高兴你找到了一个你心爱的人。我被允许为你们两个主持婚礼，但这项服务要花500金币。""",
	PAY = """支付.""",
	MARRIAGE_CHURCH_TEXT_3 = """— 非常感谢。我相信你首先需要准备一些东西。首先，你应该为婚礼和派对准备足够的食物和饮料，并组织你的送货和客人名单。仆人行会通常可以帮助你。其次，你和你的[spousehusband]需要结婚礼服。我相信工人行会会制造这些。最后，作为市长，你的订婚需要一个特殊的徽章。""",
	MARRIAGE_CHURCH_TEXT_4 = """— 一旦你准备好了一切，请告诉我，我们就可以开始仪式了。""",
	MARRIAGE_CHURCH_CLOSE_OPTION = """感谢您的指导""",
	MARRIAGE_SERVANTS_INIT = "我要举行婚礼...",
	MARRIAGE_SERVANTS_1_1 = """— 终于要和我们的小公主达成协议了？这是个好消息。 """,
	MARRIAGE_SERVANTS_1_2 = """— 哦？好吧，这是个好消息，我为你感到高兴，市长。 """,
	MARRIAGE_SERVANTS_1_3 = """那么你想让我们为你的婚礼准备一切吗？毕竟，像你这样有能力的人不可能举办一场简单的婚礼。我们可能需要为所有种类的食物准备几百份。我们可以用10份威士忌和25份啤酒作为饮料，其余的我们可以从我认识的几家当地供应商那里买给客人。""",
	MARRIAGE_SERVANTS_2 = """— 最后，我需要你给我3000块金币，用来雇佣表演者和快递员。我相信你能理解。此外，我希望你能提供一份你想见的客人名单，如果你把我加入其中，我不会感到不安，呵呵。一旦你有了一切，请告诉我，我们马上开始准备。""",
	MARRIAGE_SERVANTS_COMPLETE_OPTION = """我已经为婚礼准备好了一切""",
	MARRIAGE_SERVANTS_COMPLETE_1 = """— 太棒了，我希望你也准备好了其他的东西。在你走之前，我还有一件事想问。""",
	MARRIAGE_SERVANTS_COMPLETE_2 = """— 抱歉，我还想问你一件关于客人的事。有一类……不雅的人，他们肯定会试图出现在市长的婚礼上。虽然在你看来这可能是一件完全令人憎恶的事，但他们也很富有，而且如果新娘提供某些服务，他们会非常慷慨。""",
	MARRIAGE_SERVANTS_COMPLETE_3 = """— 我绝不建议你在婚礼上妥协。所以，如果你想邀请他们，请告诉我。""",
	MARRIAGE_SERVANTS_OPTION_1 = """邀请他们""",
	MARRIAGE_SERVANTS_OPTION_2 = """拒绝""",
	MARRIAGE_SERVANTS_COMPLETE_4 = """— 理解。有了这些准备，我希望很快见到你，并祝你婚礼快乐, [name].""",
	MARRIAGE_WORKERS_INIT = "我正在举办婚礼，需要服装",
	MARRIAGE_WORKERS_1 = """— 哦，是吗？我祝贺你。让我把你介绍给我们的裁缝。""",
	MARRIAGE_WORKERS_2 = "西格蒙德带你去找几位裁缝，他们会告诉你准备服装所需的材料。要想获得最高质量的连衣裙，他们需要150块丝绸布和50块魔力布。这项工作本身将额外花费你1000金币。",
	MARRIAGE_WORKERS_COMPLETE_OPTION = """我有所需的一切""",
	MARRIAGE_WORKERS_COMPLETE_1 = "当你与裁缝达成协议后，他们帮你量尺寸，并立即派助手帮你的伴侣。他们承诺会尽快完成工作。",
	MARRIAGE_FINAL_INIT = """— 太美了！那样的话，我们明天就开始。 """,
	MARRIAGE_FINAL_1 = """第二天早上，你开始接待快递员和客人。阿米莉亚提供的各种音乐家和一些艺术家带上他们的工具，等待派对开始。厨房里备有大托盘精致的新鲜食物和配料。第一批客人会提前送礼物，试图让你读到好书。随着中午的临近，你要去教堂。""",
	MARRIAGE_ANASTASIA_1 = """阿纳斯塔西娅正在为即将到来的仪式做准备，艾尔试图支持她。
{color=yellow|艾尔: — 万众瞩目啊，安娜。}

{color=aqua|阿纳斯塔西娅: — 当然！但你难道没有意识到这一切有多可怕吗？}

{color=yellow|艾尔: — 比被行会军队追捕还可怕。}""",
	MARRIAGE_ANASTASIA_2 = """{color=aqua|阿纳斯塔西娅: — ...适合我吗？逃亡这么多年了，穿这么迷人的衣服真奇怪。}

{color=yellow|艾尔: — 你看起来很漂亮。不过我从没想过我真的会看到你穿着婚纱。} 

{color=aqua|阿纳斯塔西娅: — 你知道，有一天你可能也会陷入困境。}

{color=yellow|艾尔: — 哼, 我怀疑 [name] 是否会允许我这样的自由。} 

{color=aqua|阿纳斯塔西娅: — 嘿，别说 [him]不好。}""",
	MARRIAGE_FINAL_2 = """考虑到教堂的规模相当小，你的众多客人中只有少数人被允许进入。这座建筑已经为你的婚礼进行了新装修，金妮将扮演牧师的角色。""",
	MARRIAGE_FINAL_3 = """当 [spousename] 被带到教堂时, [spousehe] 看起来有些紧张，但仍然微笑着向你眨眼。当 [spousehe] 走向祭坛时，金妮开始了仪式。

{color=yellow|金妮: — 感谢大家今天来这里...}""",
	MARRIAGE_FINAL_4 = """{color=yellow|金妮: — [name], 你同意与这位[spousename] 结为 [spousehusband]?}""",
	MARRIAGE_FINAL_4_OPTION_1 = """是""",
	MARRIAGE_FINAL_4_OPTION_2 = """母庸置疑""",
	MARRIAGE_FINAL_4_OPTION_3 = """否则经历这一切有什么意义？""",
	MARRIAGE_FINAL_5 = """{color=yellow|金妮: — 现在你可以亲吻 [groom]了。}

当你用你的嘴唇封住[spousehis]嘴唇时，[spousename]向你倾斜。客人为你加油，而你享受这一刻，几分钟后终于挣脱出来，对着人群咧嘴笑。 

{color=aqua|[spousename]: — 谢谢 [name], 这是我一生中最美好的一天...}""",
	MARRIAGE_FINAL_6 = """离开教堂，你回到了豪宅。许多新客人在那里等着你，一场喧闹而热烈的派对爆发了。当你建立新的关系，并从其他地主和当局那里收到结婚礼物时，你注意到[spousename]不时害羞地看着你。""",
	MARRIAGE_FINAL_7 = """当派对持续到晚上时，你的一个仆人走近你，递给你一小群客人的纸条——阿米莉亚提到的富人。纸条上提到他们非常喜欢这个派对，并说他们准备支付5000金币，与市长的新婚妻子共度一晚。""",
	MARRIAGE_FINAL_7_OPTION_1 = """将他们赶出去""",
	MARRIAGE_FINAL_7_OPTION_2 = """忽略""",
	MARRIAGE_FINAL_7_OPTION_3 = """邀请他们到卧室""",
	MARRIAGE_FINAL_8_1 = """你下令把那些有钱的混蛋赶出你的婚礼派对。恢复心情，你回到 [spousename] 花更多的时间陪她，直到夜幕降临。""",
	MARRIAGE_FINAL_8_2 = """你决定忽略这个提议，在夜幕降临时重新与妻子共度时光。尽管你很担心，但团队没有提出进一步的要求。""",
	MARRIAGE_NIGHT_GROUP_1_1 = """夜幕降临，客人开始离开，你走近 [spousename] ，把 [spouseher] 带到你的卧室。当你进入时，你发现一群男人在等着，你接受了他们的交易。
[spousename] 惊讶地喊道，但看了你一眼，意识到这不是巧合。""",
	MARRIAGE_NIGHT_GROUP_1_2 = """当你命令 [spousehim]为这些人服务时, [spousehe] 似乎很乐意。""",
	MARRIAGE_NIGHT_GROUP_1_3 = """当你命令 [spousename] 为这些人服务时， [spousehe] 难以置信地看着你。然而，意识到她现在无法逃脱，[she] 愤怒地点头。""",
	MARRIAGE_NIGHT_GROUP_1_4 = """现在剩下的就是选择你要做什么...""",
	MARRIAGE_NIGHT_GROUP_OPTION_1 = """加入""",
	MARRIAGE_NIGHT_GROUP_OPTION_2 = """离开""",
	MARRIAGE_NIGHT_GROUP_2_1 = """作为一个 [husband] 你首先会对你的 [spousehusband] 阴部动手动脚，因为 [spousename] 会用 [spousehis] 的嘴为客人服务。你把精液射进 [spousehis] 子宫里, 让一个等待的富人接管，而 [spousename] 用她的嘴清洁你的阴茎。当客人继续使用你妻子的身体时，你命令其中一个女仆进入房间，在你观看的时候玩得开心。

几个小时后，房间里的每一位客人都和 [spousename] 玩了一圈，筋疲力尽。当他们最终离开时，最后一个人把他们答应的钱递给你。""",
	MARRIAGE_NIGHT_GROUP_2_2 = """你决定离开你的 [spousehusband] 去散步。几个小时后，其中一个男人找到你，告诉你进展如何，并递给你承诺的付款。当他们离开时，你命令仆人处理剩下的烂摊子，并到此为止。""",
	MARRIAGE_NIGHT_1 = """当派对接近尾声，客人离开时，你的 [spousehusband] 满怀期待地走近你。

— [Master]... 我们现在应该享受一段美好时光吗？现在似乎已经很晚了，如果你不累的话...""",
	MARRIAGE_NIGHT_OPTION_1 = """我们去卧室吧""",
	MARRIAGE_NIGHT_OPTION_2 = """我想我累了""",
	MARRIAGE_NIGHT_2_1= """你拉起 [spousename]的手走进卧室，把剩下的东西留给仆人。""",
	MARRIAGE_NIGHT_2_2 = """[spousename] 悲伤地看了你一眼，但点头表示同意。你决定睡觉，到此为止。""",
	
	DAISY_SERVE_OPTION_START = "为我服务",
	DAISY_SERVE_START_1 = "— 当然, [Master]. 想要我怎么做?",
	DAISY_SERVE_START_2 = """— 当-当然, [Master]... 要我怎么做才好..?

黛西尴尬地避免眼神交流，等着你说完。""",
	DAISY_SERVE_OPTION_1_1 = "用嘴",
	DAISY_SERVE_OPTION_1_2 = "弯腰吧",
	DAISY_SERVE_OPTION_1_3 = "没有关系",
	
	
	CALI_SERVE_START_1 = "— ...你是说下流的东西？好吧，我不介意和你做这些, [Master]. ",
	CALI_SERVE_START_2 = """— 我能为您做些什么, [Master]?

看来卡莉的训练得到了回报，她毫不犹豫地回答。""",
	CALI_SERVE_OPTION_1_1 = "用嘴",
	CALI_SERVE_OPTION_1_2 = "站着做",
	CALI_SERVE_OPTION_1_3 = "没有关系",
	
	
	
	
	
	GRYPHON_AIRE_START = """天早上，当你穿过你的豪宅时，你注意到一个年轻的小精灵女孩艾尔正在临时射箭场勤奋地练习弓箭。你观察了她一段时间，注意到她的注意力是多么集中。

又进行了几次精确射击后，她疑惑地转向你。

— 我能为你做点什么吗？""",
	GRYPHON_AIRE_START_OPTION_1 = "好身手 ",
	GRYPHON_AIRE_START_OPTION_2 = "我不记得给过你训练命令了",
	GRYPHON_AIRE_1_1 = "— 谢谢。即使在这种状态下，我也不能让自己的技术生疏。我很高兴这个时候还有机会训练。",
	GRYPHON_AIRE_1_2 = "— 此时没有其他工作，所以我去训练我的技能，这样它们就不会生锈。我希望这是被允许的。",
	GRYPHON_AIRE_1_OPTION_1 = "你为什么训练这么刻苦？",
	GRYPHON_AIRE_1_OPTION_2 = "你对此似乎有点太热情了",
	GRYPHON_AIRE_2 = """— 我发誓要用我的生命保护公主，这不是我不经过训练就能完成的任务。我知道我必须服从你的命令，但即便如此，我也会准备好冒着生命危险，以防安娜受到威胁。""",
	GRYPHON_AIRE_2_OPTION_1 = "你真的应该放松一点，战争结束了",
	GRYPHON_AIRE_2_OPTION_2 = "这已经没有意义了，我会保护她",
	GRYPHON_AIRE_2_OPTION_3 = "是什么让你觉得你比我更好，比她的 [master]更好?",
	GRYPHON_AIRE_3_1 = """— 不管是不是战争，我都必须保持专注。这就是我对她的感激之情。很抱歉，在这么关键的事情上我不能相信你。""",
	GRYPHON_AIRE_3_2 = """艾儿的脸上对你的话略带冷笑，但她很快转过身来掩饰。

— 是这样吗？我怎么能把她的生命托付给你？对你来说，她不过是个玩具。即使不是，我也不相信你比我强。""",
	GRYPHON_AIRE_3_3 = """— 我知道在这么关键的任务中我不能依赖你或任何人。我不是想冒犯，但我怀疑你是否比我好。""",
	GRYPHON_AIRE_3_OPTION_1 = "如果我向你证明我有能力怎么办？",
	GRYPHON_AIRE_3_OPTION_2 = "现在我必须证明它，向您展示谁是这里的 [master] 。",
	GRYPHON_AIRE_4_1 = """— 嗯，好啊。如果你向我证明你已经准备好像我做不到的那样照顾安娜，我会做你想做的任何事。你一定在想什么下流的事，不是吗？如果你成功了，而且你愿意的话，我会成为你的走狗。""",
	GRYPHON_AIRE_4_2 = """— 我看看你能不能。如果你向我证明你已经准备好像我做不到的那样照顾安娜，我会做任何你想做的事。你一定在想什么下流的事，不是吗？如果你成功了，而且你愿意的话，我会成为你的走狗。 """,
	GRYPHON_AIRE_4_OPTION_1 = "你真的知道如何激励一个男人",
	GRYPHON_AIRE_4_OPTION_2 = "你很勇喔",
	GRYPHON_AIRE_4_OPTION_3 = "你会后悔这些话的",
	GRYPHON_AIRE_5 = """— 在成功之前不要开始流口水。好吧，如果你想证明这一点，那就去击败一只年长的鹰头狮。这是一种罕见的凶猛鹰头狮，即使是精灵也不敢接近。如果你能干掉一只，我会承认你作为阿纳斯塔西娅的保护者就足够了。""",
	GRYPHON_AIRE_5_OPTION_1 = "准备好输了吗？",
	GRYPHON_AIRE_5_OPTION_2 = "听起来不太难",
	GRYPHON_AIRE_6 = """— ...只是不要自杀。我不在乎，但如果发生这种情况，我们会有麻烦的。""",
	
	GRYPHON_WORKERS_START_OPTION = "我在找一只老鹰头狮...",
	GRYPHON_WORKERS_START = """— 嗯，我不懂这个，你应该找一些经验丰富的猎人，他们至少有勇气进入精灵森林。我想我可以给你找一些。

西格蒙德告诉你如何找到一个叫德里克的猎人老兵，他可以告诉你追踪老鹰头狮的方向。""",
	GRYPHON_HUNTER_START = """你找到了德里克，西格蒙德告诉你的资深猎人。告诉他你想要什么后，他看起来很开心。

— 这是一项危险的任务，朋友，但我喜欢。你知道，考虑到你的身份，我们可能会招募一些其他有经验的猎人来完成这项任务。森林很茂密，所以带太多人对我们来说弊大于利。

— 市长，你的目标是取得一项大胆的成就。不是屠龙，但仍然可以载入史册。你想干什么？""",
	GRYPHON_HUNTER_START_OPTION_1 = "那野兽的身体可能很有价值",
	GRYPHON_HUNTER_START_OPTION_2 = "没有征服的刺激生活可不行。",
	GRYPHON_HUNTER_START_OPTION_3 = "只是想给女孩留下深刻印象",
	GRYPHON_HUNTER_1_1 = """— 啊，战利品。嗯，那不关我的事。

我有一些关于上次在哪里看到这些野兽的信息，离森林边界不远。我建议去那里，这样我们就可以开始追踪它了。""",
	GRYPHON_HUNTER_1_2 = """— 我不知道我们的市长这么有冒险精神，我会尊重这一点。

我有一些关于上次在哪里看到这些野兽的信息，离森林边界不远。我建议去那里，这样我们就可以开始追踪它了。""",
	GRYPHON_HUNTER_1_3 = """你注意到艾尔皱着眉头，给了你一个严肃的眼神。

— 哈哈，你真是个孩子。好吧，你一定有你的理由。

我有一些关于上次在哪里看到这些野兽的信息，离森林边界不远。我建议去那里，这样我们就可以开始追踪它了。""",
	GRYPHON_HUNTER_1_OPTION_1 = "那就是计划",
	GRYPHON_HUNTER_1_OPTION_2 = "我们不要再浪费时间了",
	GRYPHON_FOREST_START = """你走近森林中密度较大的地方，听说那里可能会发现一只老鹰头狮。艾尔在你身边保持沉默，但她美丽的脸上的皱眉暗示着你的果断。其他一些猎人已经从城市来到这里，同意听从你的命令。""",
	GRYPHON_FOREST_1 = """当你击败小鹰头狮时，你让猎人在周围搜寻年长者的踪迹。在等待的过程中，艾尔走近了你。

— 我不喜欢这样做，这太危险了。""",
	GRYPHON_FOREST_1_OPTION_1 = "现在放弃就太可惜了",
	GRYPHON_FOREST_1_OPTION_2 = "准备好承认失败了吗？",
	GRYPHON_FOREST_1_1 = """艾尔准备说点什么，但在最后一刻咬着嘴唇保持沉默。意识到这是她的想法，她无法接受失败。

最后德里克带着好消息来找你。猎人们找到了线索，证明老鹰头狮一定在附近的某个地方。在你来的路上，他们中的一个人在河边看到了一个大洞穴，这似乎是最有可能的地方。听到这些，你就下令前进。""",
	GRYPHON_FOREST_1_2 = """— 哼，别逗我笑。想找死就去吧，我不在乎。

最后德里克带着好消息来找你。猎人们找到了线索，证明老鹰头狮一定在附近的某个地方。在你来的路上，他们中的一个人在河边看到了一个大洞穴，这似乎是最有可能的地方。听到这些，你就下令前进。""",
	GRYPHON_CAVE_START = """带着你雇佣的一群猎人和艾尔，你进入了宽敞的洞穴。几乎在入口处，你发现了巨大的羽毛，这表明猎人的猜测是正确的。又过了一百英尺，你听到了愤怒野兽的尖叫声。当你被一只巨大的鹰头狮盯着时，整个团队迅速从洞穴中撤退，这只鹰头狮比你以前见过的任何一只都大。""",
	GRYPHON_CAVE_1 = """当老鹰头狮奄奄一息时，你发觉它将注意力集中在艾尔身上的，艾尔仍然在它巨大的爪子够不到的地方。没想到，老鹰头狮吼了一声，朝她的方向冲去。""",
	GRYPHON_CAVE_1_OPTION_1 = "尝试阻止它",
	GRYPHON_CAVE_1_OPTION_2 = "什么都不做",
	GRYPHON_CAVE_BAD = """艾尔的眼睛睁大了，一只巨大的鹰头狮的爪子撕裂了她的肚子。只需轻轻一扫，她纤细的身体就被它撕裂了。当一名猎人击打鹰头狮裸露的脖子时，它终于倒了下来。你冲向艾尔，但为时已晚。她最后一口气对准了你。

— 请-请, 保护... 安娜...

鹰头狮被打败了，但几乎没有什么意义。""",
	GRYPHON_CAVE_2 = """你跳到艾尔面前，用你的武器挡住来袭的攻击。巨大的力量将你推回艾尔，艾尔震惊而难以置信地看着你。你的武器在攻击的压力下断裂，你感觉到鹰头狮的爪子进入了你的胸部。第一次冲击将你推回，所以爪子没有切得那么深，但你感觉至少有一根肋骨被撕裂了。

值得庆幸的是，这次袭击为其中一名猎人提供了一个机会，让它深深地伤到了鹰头狮的脖子，最终使它摔倒了。你重重地倒在地上。艾尔急忙跪在你身边，眼里噙着泪水。""",
	GRYPHON_CAVE_3 = """— 你…为什么？你为什么要保护我？！你必须保护安娜！…你现在不能死！

在失去意识之前，你只能给艾尔一个小小的微笑。""",
	GRYPHON_CAVE_4 = """你在靠近鹰头狮巢穴的一个小帐篷里醒来。你感觉不太好，但似乎有一位治疗师已经给你包扎好了，你的生命没有危险。在你的床边，你看到一个熟悉的精灵女孩。

— [name]! 再也不要做这样的事了！你在想什么！？""",
	GRYPHON_CAVE_4_OPTION_1 = "这更多的是一种本能",
	GRYPHON_CAVE_4_OPTION_2 = "这是英雄必须做的",
	GRYPHON_CAVE_4_OPTION_3 = "我要为此狠狠地揍你一顿",
	GRYPHON_CAVE_5 = """— 你是个白痴，不是吗？看看差点发生了什么……很抱歉我让你这么做，我没想到你真的会试图打倒那只野兽……谢谢你救了我。这是第二次了。我想我现在必须做你想做的任何事。我的意思是，一旦你的伤口愈合。""",
	GRYPHON_CAVE_5_OPTION_1 = "这就是我想听的",
	GRYPHON_CAVE_5_OPTION_2 = "我很高兴你也很安全",
	AIRE_GREET = """— 你想要我做什么？""",
	GRYPHON_AIRE_SEX_START_OPTION_INIT = "关于你的承诺...",
	GRYPHON_AIRE_SEX_START = "— 是-是的？你有什么想法？",
	GRYPHON_AIRE_SEX_START_OPTION_1 = "我想和你和阿纳斯塔西娅三人行",
	GRYPHON_AIRE_SEX_START_OPTION_2 = "我还没决定",
	GRYPHON_AIRE_SEX_1 = """艾尔沉默了一段时间，就在你认为她会让你后悔的时候，她回应道。

— 我并不反对，但从未想过和安娜做这样的事。我的意思是，她比我更值得你。但如果这是你的命令，我们都会服从。那么你想让我为她做好准备吗？并不是说我有和另一个女孩相处的经验，但我想我能做到。""",
	GRYPHON_AIRE_SEX_1_OPTION_1 = "就这样吧",
	GRYPHON_AIRE_SEX_1_OPTION_2 = "我改变主意了",
	GRYPHON_AIRE_SEX_2 = "艾尔点头回应，你为即将到来的活动制定了计划。",
	GRYPHON_ANA_SEX_OPTION_INIT = "今晚我们要做一些特别的事情...",
	

GRYPHON_ANA_SEX_START = """应你的邀请，阿纳斯塔西娅穿着情趣内衣进入您的房间。当她看到她的精灵朋友穿着内衣站在那里时，她的眼睛睁大了。

阿纳斯塔西娅: — 艾-艾尔? 你在这里干什么？

艾尔: — 我受邀加入你们的行列，是奉我们 [Master]的命令。""",


	GRYPHON_ANA_SEX_1 = """阿纳斯塔西娅: — 这...

艾尔：—你不喜欢我在这儿吗？

阿纳斯塔西娅: — 不是这样，我只是觉得尴尬。

艾尔: — 我也是，但这正是我们的保护者想要的，所以我认为这没什么大不了的？此外，我并不是不想接近我生命中最重要的两个人。

阿纳斯塔西娅没有回答，艾尔把她带到床上。""",


GRYPHON_ANA_SEX_2 = """艾尔: — 所以，让我们尽最大努力取悦我们的 [master] ，并在性爱中找到一些乐趣——不仅是作为朋友，也是作为女性。

公主点了点头，两人都跪在你面前。艾尔剥去内衣的最后一点，阿纳斯塔西娅紧随其后。

艾尔: — 哇，安娜，我注意到你把胸部藏起来了，但它们看起来比我的大。一定是因为你的皇室血统。

阿纳斯塔西娅: — 你-你在说什么！？它们并没有那么大...你不认为它们太大，对吧 [name]?""",
	GRYPHON_ANA_SEX_2_OPTION_1 = "它们是完美的",
	GRYPHON_ANA_SEX_2_OPTION_2 = "没有\"太大\"这回事",
	GRYPHON_ANA_SEX_2_OPTION_3 = "你应该更接受自己的身体",
	
	GRYPHON_ANA_SEX_3 = """当艾尔把阿纳斯塔西娅移近你时，她脸红了，目光移开。 

艾尔: — 来吧, [name] 为了这一刻真的很努力，我们应该奖励他。

艾尔把自己放在阿纳斯塔西娅面前，把她抱在你的臀部，你完全直立的阴茎夹在臀部之间。艾尔抚摸着你的乳房，把它压在阿纳斯塔西娅结实的乳房之间，把自己的乳头压在公主的乳头上，把它保持在那里。

艾尔: — 这是你喜欢的吗, [Master]?
	
当两个女孩顺从地把乳房挤在你的阴茎周围时，你咕哝着表示赞同。
	
阿纳斯塔西娅: — 这是…这感觉很好...""",

GRYPHON_ANA_SEX_4 = """精灵女孩和公主轻轻地上下摆动，你的阴茎在他们坚硬的乳房之间滑动。当你看着他们都在靠近你的阴茎时，你高兴地呻吟。艾尔似乎比你预期的更渴望这一点，她把你的硬阴茎紧紧地夹在乳头之间，与你保持眼神交流。

阿纳斯塔西娅看起来仍然很羞愧，当她把她的大乳房拢在你的阴茎周围时，脸涨得通红，当艾尔更有力地上下弹跳时，用它们按摩你的乳房。公主看着艾尔，然后看着你，她那蓝色的大眼睛充满了不确定性和兴奋。

当女孩们用乳头抚摸你的阴茎时，她们的乳头滑过并相互挤压，你可以看到她们在继续运动时越来越兴奋了。几分钟后，她们都因为努力而汗流浃背，你的阴茎更容易在他们光滑的乳房之间滑动。""",
	
	GRYPHON_ANA_SEX_5 = """	
一段时间后，你可以感觉到你的性高潮开始形成。你的臀部反射性地抽搐，在小精灵女孩和公主为你服务时插入他们之间。

你必须克制住抓住两个女孩的头发，把她们喋喋不休的嘴按在你的阴茎上的冲动。但你的高潮就像一头冲锋的公牛，向空中喷射精液，遍布跪在你面前的两个女人的脸和身体。 """,

	GRYPHON_ANA_SEX_6 = """
阿纳斯塔西娅先是看起来很惊慌，然后又很羞愧，因为一股厚厚的精液溅到了她的脸上和柔软的乳沟里。一团精液落在艾尔的眼睛里，她迅速闭上眼睛，精子从眼睑泄漏，顺着脸颊流下..

艾尔: — 哈！神啊，这太多了, [Master]。 两个人都够了！

艾尔用手指擦去阿纳斯塔西娅脸上的一些精液，然后把手伸向公主。

阿纳斯塔西娅: — 你-你确定吗?

作为回应，艾尔用手指抚摸自己的乳房，在那里收集一些精液，然后把手指吸入嘴里清洗。看到这一点，阿纳斯塔西娅犹豫地张开嘴，从艾尔的另一只手上舔你的精液。

艾尔满怀期待地回头看你。

艾尔: — 这就是你想象中的一切吗, [Master]? 或者你还想要什么? 

她暗示性地回头看了看阿纳斯塔西娅，她又脸红了。 """,

	GRYPHON_ANA_SEX_7 = """你贪婪地笑着告诉他们你才刚刚开始。

你命令两个裸体女孩离开地板。艾尔站起来，拉着阿纳斯塔西娅的手，领她走向你的床。你紧跟在后面，欣赏她们的屁股。艾尔仰卧在床罩上，展开她那细长的精灵腿。阿纳斯塔西娅回头看了你一会儿，好像不确定，但艾尔拉着她的手，把不情愿的公主拉了下来，直到她压在兴奋的小精灵身上。""",

	GRYPHON_ANA_SEX_8 = """他们丰满的乳房压在一起，当你走近时，他们都看着你，看到裸体的公主跨坐在她那兴奋的侍女身上，你的阴茎已经僵硬了。

你的手滑过阿纳斯塔西娅圆屁股的平滑曲线，然后滑到她的两腿之间。她的阴部是温暖的，被她自己的汁液弄湿了，当你的手指进入她时，她高兴地轻轻地喘着粗气，当你抚摸她的阴蒂时，她的背部拱起。

你的手指向下移动，探查艾尔的紧密缝隙，发现它摸起来很热，因为它在指尖的压力下很容易打开。艾尔渴望地呻吟着。你四处走动，爬上阿纳斯塔西娅身后的床

艾尔: — 安娜, 我 — 我很高兴能以这种方式为你和 [Master] 服务.

阿纳斯塔西娅: — 别再说这种傻话了...

你用双手将阿纳斯塔西娅压在艾尔身上，并将她的腿张开。他们的阴部叠在一起，你先穿透艾尔，把阿纳斯塔西娅挤在你中间，你的公鸡紧紧地推进精灵女孩的阴部。当你把自己一路推到艾尔身上，用你坚如磐石的阴茎拉伸她紧绷的阴部时，艾尔大声喊道。""",

	GRYPHON_ANA_SEX_9 = """划动几下后，你拉出并进入阿纳斯塔西娅，当你的阴茎被艾尔的汁液弄得光滑时，她因兴奋而颤抖，很容易滑入她的湿洞。当你在她身上以后入式操公主时，两个女孩凝视着对方的眼睛。你紧紧抓住阿纳斯塔西娅的臀部，让她在你粗暴地摩擦她光滑的屁股时大喊大叫。

当阿纳斯塔西娅接近高潮时，你会感觉到她的阴部抓住了你的阴茎，然后你就退出了。当你把你的公鸡插回艾尔时，公主轻声地哀嚎着，当你用阿纳斯塔西娅的裸体把她钉在床上时，公主狠狠地操了她那紧紧的精灵小猫.. 

艾尔紧紧抓住阿纳斯塔西娅，你把她搞到高潮边缘，然后退出。当你的肉从她身上滑落时，她呜咽着，小猫无助地抽搐着。当你这一次冲向阿纳斯塔西娅时，她把屁股压回你身上，急切地乞求被操。""",


	GRYPHON_ANA_SEX_10 = """你慢慢来，在接下来的几个小时里轮流和每个女孩做爱，直到她们都筋疲力尽，并恳求释放高潮。

你决定先进入艾尔体内，作为对她的服从的奖励，当你最后一次用力将她痉挛的阴部推到边缘时，你粗暴地将手指伸进阿纳斯塔西娅跳动的阴部。你们三个一起达到高潮，两个女孩都在发抖和呻吟，当你用精液填满艾尔疼痛的阴部时，她们紧紧地拥抱在一起。
两个女孩四肢瘫软，当你从艾尔中出来时，她们脸红了，气喘吁吁。她躺在阿纳斯塔西娅下面，你的精液从她身上滴下来。

艾尔: — 噢, 主人... 我做梦也没想到... 我... 谢谢你...

阿纳斯塔西娅几乎说不出话来，重重地倒在艾尔身上。她那完美的屁股忽高忽低，大口大口地喘着粗气，阴部滚烫，闪烁着自己的汁液。你感觉到你的阴茎又僵硬了，你把它塞进公主裸露的阴部。

你粗暴地操阿纳斯塔西娅，你捶打她，手指伸进她柔软的屁股里。在下面，艾尔挤压公主的乳房，而你野蛮地推入阿纳斯塔西娅潮湿的阴部。当你的阴茎无情地向阿纳斯塔西娅猛扑时，她在痛苦和快乐之间挣扎。

几分钟后，当阿纳斯塔西娅泪流满面地被高潮淹没时，你再次将种子射入她悸动的阴部。艾儿又开始了，当你在她身上操她心爱的公主时，她疯狂地用手指着自己漏水的洞。你的精液从阿纳斯塔西娅的阴部溢出到艾尔的手上。

最后，你告诉两个女孩，等到她们休息好了，有工作要做。""",

	
	ZEPHYRA_RECRUITMENT_LETTER = "早上你收到了当地教堂修女金妮的来信，要求你去看望她。",
	ZEPHYRA_RECRUITMENT_1 = """— 欢迎, [name]! 听说你现在当市长了？祝贺你！

— 我很高兴你来拜访我们。你收到消息了吗？我平时不敢跟你说话，但有个人想见你。我想她是你的熟人吧？""",
	ZEPHYRA_RECRUITMENT_2 = """{color=yellow|金妮: — 我允许她留在教堂，因为这是我的荣幸。即使她不是赛琳娜的追随者，她也非常尊贵——神眷者。}

{color=aqua|西菲拉: — 嘿, [name]. 已经有一段时间了。啊，你当时把我一个人留在那里太残忍了。在那样可怕的时刻。你能想象那些绝望的土匪会对我这样的人做什么吗？ }

{color=aqua|西菲拉: — 好吧，我看你已经永远解决了这场战争。毕竟我对你的评价是对的。}""",
	ZEPHYRA_RECRUITMENT_2_OPTION_1 = """你真的充满了惊喜""",
	ZEPHYRA_RECRUITMENT_2_OPTION_2 = """很惊讶你还跟着我""",
	ZEPHYRA_RECRUITMENT_2_OPTION_3 = """我没有时间""",
	ZEPHYRA_RECRUITMENT_3_1 = """{color=aqua|西菲拉: — 拜托，你在奉承我。这只是我必须执行的任务。

西菲拉: — 现在，你是一名市长，你将有更多的支持和资源可供支配，这可能是一件好事，但这对这片土地，也许对世界来说都是一个严重的危险。这似乎是我的神对我的旨意。

西菲拉: — 你知道什么是神器吗？这是神的物品，可以拥有巨大的力量，或者有一些隐藏的属性。这些文物在某种程度上都与神有关。我相信有一把古老的剑属于这片土地和它的君主}""",
	ZEPHYRA_RECRUITMENT_3_2 = """{color=aqua|西菲拉: — 我必须执行一项任务，所以我来到这里。

西菲拉: — 现在，你是一名市长，你将有更多的支持和资源可供支配，这可能是一件好事，但这对这片土地，也许对世界来说都是一个严重的危险。这似乎是我的神对我的旨意。

西菲拉: — 你知道什么是神器吗？这是来自神的物品，可以拥有巨大的力量，或者有一些隐藏的属性。这些文物在某种程度上都与神有关。我相信有一把古老的剑属于这片土地和它的君主}""",
	ZEPHYRA_RECRUITMENT_3_3 = """{color=aqua|西菲拉: — 听到这个消息我很难过，但我毕竟无法说服你合作... 

西菲拉: — 如果你坚持，那我就不会再打扰你了.}""",
	ZEPHYRA_RECRUITMENT_3_3_OPTION_1 = """是的，我想让你别管我""",
	ZEPHYRA_RECRUITMENT_3_3_OPTION_2 = """我改变主意了""",
	ZEPHYRA_RECRUITMENT_3_OPTION_1 = "现在有点问题...",
	ZEPHYRA_RECRUITMENT_3_OPTION_2 = "这把剑已不在我们手中",
	ZEPHYRA_RECRUITMENT_4 = """你向西菲拉解释了内战早期发生的事情。

{color=aqua|西菲拉: — 嗯，这很麻烦。一个恶魔在战争开始时拿走了剑？这是预期中的一种可能。非常遗憾，但这只会使我们更加迫切地需要专注于收集其他文物。

西菲拉: — 这些文物不像现在这样拥有太多的力量，但如果与神相连，它们可能会变得非常危险。我相信我们必须在恶魔接近它们之前保护好它们。下一个最接近的神器由森林精灵保管。}""",
	ZEPHYRA_RECRUITMENT_4_OPTION_1 = "我怎么知道你的目标是好的？",
	ZEPHYRA_RECRUITMENT_4_OPTION_2 = "那么你建议我怎么做呢？",
	ZEPHYRA_RECRUITMENT_5_1 = """{color=aqua|西菲拉: — 嗯，确实不能。相信我吧？如果你相信我，我保证你会尽我所能帮助你。怎么样？

西菲拉: — 好吧，你是市长，所以无论如何，你都能在那只妖妞之前找到精灵神器。没必要着急，但你应该记住。

西菲拉: — 那么，我说服你了吗？我期待着与你合作...只要你不介意。}""",
	ZEPHYRA_RECRUITMENT_5_2 = """{color=aqua|西菲拉: — 好吧，你是市长，所以无论如何，你都能在那只妖妞之前找到精灵神器。没必要着急，但你应该记住。

西菲拉: — 那么，我说服你了吗？我期待着与你合作...只要你不介意。}""",
	ZEPHYRA_RECRUITMENT_5_OPTION_1 = "很好，你可以加入我",
	ZEPHYRA_RECRUITMENT_5_OPTION_2 = "听起来好麻烦，算了",
	ZEPHYRA_RECRUITMENT_6_GOOD = """{color=aqua|西菲拉: — 啊，终于。你真的好顽固，不是吗？我很高兴至少从现在起我们能成为朋友。请不要太介意我}""",
	ZEPHYRA_RECRUITMENT_6_BAD = """{color=aqua|西菲拉: — 啊，是这样吗？真是太可惜了。好吧，我只能希望你不要淹死在下水道里。再见了， [name].}

西菲拉不看你一眼就离开教堂。""",
	ZEPHYRA_SWORD_1 = """— 你做出了正确的决定, [name]. 这不是任何人都能吹嘘的。我很高兴我加入你的团队。

— 既然你是市长，你将有更多的支持和资源可供支配，这可能是一件好事，但这对这片土地，也许对世界来说都是一个严重的危险。这似乎是我的神对我的旨意。

— 你知道什么是神器吗？这是来自神的物品，可以拥有巨大的力量，或者有一些隐藏的属性。这些文物在某种程度上都与神有关。我相信有一把古老的剑属于这片土地和它的君主。""",
	ZEPHYRA_SWORD_1_OPTION_1 = "现在有点问题...",
	ZEPHYRA_SWORD_1_OPTION_2 = "这把剑已不在我们手中",
	ZEPHYRA_SWORD_2 = """你向西菲拉解释了内战早期发生的事情。

— 嗯，这很麻烦。一个恶魔在战争开始时拿走了剑？这是预期中的一种可能。非常遗憾，但这只会使我们更加迫切地需要专注于收集其他文物。

— 这些文物不像现在这样拥有太多的力量，但如果与神相连，它们可能会变得非常危险。我相信我们必须在魔鬼接近他们之前保护好他们。下一个最接近的必须由森林精灵保管。""",
	ZEPHYRA_SWORD_2_OPTION_1 = "我认为他们不会简单地把它给我们",
	ZEPHYRA_SWORD_2_OPTION_2 = "收集完所有神器后会发生什么？",
	ZEPHYRA_SWORD_3_1 = """— 我也是。好吧，你是市长，我相信你最终会有机会的。在那之前，如果你不介意的话，我会一直陪在你身边。""",
	ZEPHYRA_SWORD_3_2 = """— 不知道。很抱歉，我只能含糊地解释我们应该做什么的大致想法。我希望这不会让你太失望？在我们取得更多进展之前，我希望留在你身边。""",
	ZEPHYRA_SWORD_3_2_1 = """[Charm] Are you hiding something from me?""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_2_2 = """[Wits] If you want my help, I want to know more about what we are doing.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_2_3 = """Very well, I'll help you.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_2_4 = """I'll get to it when I have time.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_2_FINISH = """Zephyra nods with her usual smile on her face before leaving you to yourself.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1 = """{color=green|Success}

— I wish I could tell you more, but I barely get anything other than my personal hunch about what's going on. All I'm certain of is that there's an ominous plot being staged beyond our sight, the one threatening everyone. I know it's a weak premise, but I can't do nothing on it. 

— And if you want to know why I think my own actions are so important, let's say I'm not just some random girl of unusual descendancy who got granted a god's power and guidance. Well, after all, nothing in this world is truly accidental, don't you think?""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1_OPTION_1 = """Many things in our lives are purely random.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1_OPTION_2 = """I can't deny the certainty of some seemingly arbitrary actions.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1_1 = """— Don't be harebrained, [name]. Not a single action taken can be replayed after it is unveiled, there's only single chance for everything what happened was certain to happen. The fate is the truth we live by. And this fate is guided by something far greater than your or mine life.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1_1_OPTION1 = """And if this happens to lead you to your death?""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1_1_OPTION2 = """Enough of this talk.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1_1_1 = """— In this case I'll be very sad. Because of my death. But also because it would indicate a severe disaster for the rest of the world. """, # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_1_2 = """— So we are like-minded. That's a relief to know. """, # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_2 = """{color=red|Failure}

	Zephyra looks around with a troubled expression of someone having to answer a childish questions rather than someone being interrogated.

	— *Sigh* Look, if that's still not enough for to convince you, how about I dirty bribe you then? Tell what can I get you.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_2_OPTION_1 = """You could give something valuable as a way of insurance.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_2_OPTION_2 = """Something intimate could prove your sincerity.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_2_OPTION_3 = """Forget about it, I'll trust you.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_2_1 = """Hearing your mundane request, Zephyra reaches her pocket and produces a sizable pouch of gold coins. She puts it before you before stepping back.

— This is about five hundred and this is all I have as my safety measure. So now I'm financially completely in your care. You wonder why? That's the extension of my trust... or stupidity. """, # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_3_2_2 = """Zephyra blushes for a bit, after which she leaves a room. After a few moments of rustling behind the door, she enters again and puts into your hand a still warm piece cloth, which appear to be her undergarment. 

— Happy now, dear Mayor? This way both you get what you want and I could make some scandalous claims if you do something bad. Now, please excuse me, I don't want to keep around here... or anywhere, being that unprotected. 

Zephyra leaves to her room before you get a chance to react. It seems she will take you reaction as an agreement.""", # MISSING TRANSLATION
	ZEPHYRA_SWORD_3_4 = """- Now, have I satisfied your curiosity? What is your answer?""", # MISSING TRANSLATION
	PRIESTESS_SWORD_TALK_1_1 = """预约后，你得到了一个和女祭司会面的机会。

— 你最好知道，我接待你只是因为你的地位很高。你需要什么？""",
	PRIESTESS_SWORD_TALK_1_2 = """女祭司轻蔑地看了你一眼。

— 不要跟我开人类玩笑，我没有时间去听--弗雷娅选择了我！即使我们过去有一些共同点，那也毫无意义。""",
	PRIESTESS_SWORD_TALK_1_OPTION_1 = "兢兢业业?",
	PRIESTESS_SWORD_TALK_1_OPTION_2 = "我实际上在寻找特定的文物...",
	PRIESTESS_SWORD_TALK_2 = """你解释了你所知道的关于这些文物和似乎在寻找它们的恶魔女人的一切。与你的预期相反，女祭司似乎不怎么在乎你的言论。

— 你所说的与我无关。自然不可能发生这种事。你不能靠近圣碗。至于你所说的妖，我们一无所知，如果没有别的，我就请你别再麻烦我了。 """,
	PRIESTESS_SWORD_TALK_2_OPTION_1 = "但这可能对你也很关键",
	PRIESTESS_SWORD_TALK_2_OPTION_2 = "没有什么能改变你的想法吗？",
	PRIESTESS_SWORD_TALK_2_OPTION_3 = "你可能会后悔这个决定",
	PRIESTESS_SWORD_TALK_2_OPTION_4 = "*离开*",
	PRIESTESS_SWORD_TALK_3_123 = "女祭司无视你的回应，叫了一名警卫给你指路。",
	PRIESTESS_SWORD_TALK_3_4 = "你发觉无事可做，该走了。",
	PRIESTESS_SWORD_TALK_4_0 = """你离开了女祭司的房间，然后走开了，但在几百英尺后，一对警卫拦住了你，让你跟着他们。他们把你带到了似乎是军队总部的地方，一个高大的精灵向你打招呼。

— 你好, [name]。请不要惊慌，我只是命令我的人带你进来聊聊。 """,
	PRIESTESS_SWORD_TALK_4_1 = """— 我是现任军事指挥官埃伦。这个头衔并不像你想象的那么令人印象深刻，因为我们是女祭司的下属。弗雷娅的女祭司是我们的总督，她也定义了我们的法律。不过，并不是每个精灵都对此感到高兴。""",
	PRIESTESS_SWORD_TALK_4_2 = """— 是的，你可能会觉得这很不寻常，我们更喜欢保持文明，在我们的社会中使用卑鄙的策略。还有很多其他礼仪和宗教规则我不会打扰你，因为这些与你来这里的原因无关。""",
	PRIESTESS_SWORD_TALK_4_OPTION_1 = "你是谁?",
	PRIESTESS_SWORD_TALK_4_OPTION_2 = "你们这些精灵做事有些见不得人的方式",
	PRIESTESS_SWORD_TALK_4_OPTION_3 = "你想要什么?",
	PRIESTESS_SWORD_TALK_5 = """— 我听说你在寻找圣碗。你的故事引发了一些问题，但我的消息来源表明你的信息是可信的。我可以说服女祭司给你一个机会来获取圣碗。""",
	PRIESTESS_SWORD_TALK_5_OPTION_1 = "这么慷慨?",
	PRIESTESS_SWORD_TALK_5_OPTION_2 = "我打赌这不会是免费的。",
	PRIESTESS_SWORD_TALK_6 = """— 首先我需要你做点什么作为回报。在我们的森林边缘有一个大型兽人部落。我想让你去那里，送个快递，然后带着答案回来。信息将被密封，只有接收者才能阅读。我想你把信息传递给部落首领。""",
	PRIESTESS_SWORD_TALK_6_OPTION_1 = "你不喜欢那些兽化裔?",
	PRIESTESS_SWORD_TALK_6_OPTION_2 = "你为什么不自己去?",
	PRIESTESS_SWORD_TALK_6_OPTION_3 = "很好，我会去的",
	PRIESTESS_SWORD_TALK_7_1 = """— 精灵与兽人有着……复杂的关系。他们不崇拜弗雷娅，而是崇拜冉达斯。他们不像我们那样尊重自然和大树。他们生活在野外，遵循着他们的原始本能。坦率地说，我们认为他们只不过是野蛮人，但我们同意容忍他们，只要他们与世隔绝。""",
	PRIESTESS_SWORD_TALK_7_2 = """— 我显然不被允许独自前往任何地方，而且我真的不能派遣任何一名正规士兵执行如此微妙的任务。这就是我联系你的原因。是的，就这一点而言，我需要你对这次任务保持沉默。""",
	PRIESTESS_SWORD_TALK_7_3 = """埃伦在谈话中第一次微笑。

— 我很高兴听到这个消息。这是我准备的信息。我会在你的地图上标出他们的位置。你到那里应该不会有什么麻烦。一旦你给我答案，我会尽我所能说服女祭司帮助你实现目标。""",
	CHIEFTAIN_MEETING_1 = """你成功地到达了部落的定居点，没有遇到任何明显的问题，事实上，你惊讶地发现，在你进去的路上没有人拦住你。大多数四处走动的兽化裔和一些混血裔几乎没有认真注意你，尽管有一些人密切观察你，甚至做出了模棱两可的手势。

你已经注意到他们看起来异常无忧无虑，甚至轻浮，包括他们的穿着和说话方式。当你几次遇到几乎不隐藏的情侣在中午露天做爱时，这种想法得到了加强，而你的外表似乎并没有困扰他们。当你经过一对这样的夫妇时，一位年长的野兽女向你喊道。

— 啊，我们有了新客人。上一次已经有一段时间了。也许你需要帮助吗？""",
	CHIEFTAIN_MEETING_1_OPTION_1 = "你是谁?",
	CHIEFTAIN_MEETING_1_OPTION_2 = "一个新访客?",
	CHIEFTAIN_MEETING_1_OPTION_3 = "我在找首领",
	CHIEFTAIN_MEETING_2_1 = """— 我是萨夫拉，部落的萨满。你可以把我看作是一个引导我们年轻亲属的长辈。 """,
	CHIEFTAIN_MEETING_2_2 = """— 是的。由于我们的位置偏远，除了精灵之外，这里没有太多其他定居点，他们对我们评价不高。新访客是罕见的景象。""",
	CHIEFTAIN_MEETING_2_3 = """— 我们的首领是莱昂，你会在洞穴附近的大小屋旁找到他。现在，如果你不介意，我有一些事情要处理，我们稍后再见面。""",
	CHIEFTAIN_MEETING_3_1 = """在一间宽敞的小屋里，你可以找到部落首领莱昂。

— 你好，旅行者。我欢迎你来到我们部落的家，只要你保持文明和宽容。如果你感兴趣的话，我们很乐意看见亲属中多一个新成员。

— 我已经听说你在找我。我们一直很关心客人，但如果你有什么事情要介绍，我很乐意听你说。""",
	CHIEFTAIN_MEETING_3_2 = """在一间宽敞的小屋里，你可以找到部落首领莱昂。

— 你好，旅行者。我欢迎你来到我们部落的家，只要你保持文明和宽容。你可能不是我们的亲人，但你在这里不必担心你的安全。

— 我已经听说你在找我。我们一直很关心客人，但如果你有什么事情要介绍，我很乐意听你说。""",
	CHIEFTAIN_MEETING_3_OPTION_1 = "我有精灵送过来的消息",
	CHIEFTAIN_MEETING_3_OPTION_2 = "埃伦的信息",
	CHIEFTAIN_MEETING_4 = """你把密封的信递给莱昂，这封信在他的爪子里打开了。当他读的时候，你注意到他的脸皱着眉头，但他在读完之前一直保持沉默。仔细思考后，他终于开口了。

— 我想你需要我的回答。我不知道你来这里旅行的原因是什么，但我们也有自己的需求。你必须为我们做点什么，然后你就会得到我的答案。""",
	CHIEFTAIN_MEETING_4_OPTION_1 = "为什么是我?",
	CHIEFTAIN_MEETING_4_OPTION_2 = "你想要什么?",
	CHIEFTAIN_MEETING_4_OPTION_3 = "我想我别无选择",
	CHIEFTAIN_MEETING_5 = """— 我们有一些冉达斯要求我们遵守的习俗和仪式。你是过去几个月里的第一个访客，你可以帮助我们。我们需要一个局外人来执行一个仪式，如果你想把我的答案带回精灵，我会要求你参加。这对你来说没有什么危险，以防你担心。

— 找到萨夫拉，她会告诉你细节，她一定已经对你的到来感到兴奋了。""",
	MAE_MEETING_1 = """当你进入小屋时，一个年轻而不安的狸人女孩出现在你面前，她穿着轻薄的衣服。与其他村民相比，她的举止异常奇特，她明显感到紧张。""",
	MAE_MEETING_1_1 = """— 啊！你好！我以前没见过你。你是个外来者，对吧？……我的意思是，你当然是。嗯，我是梅，很高兴见到你。你肯定是在找萨夫拉吧？她在远处的房间里。现在，请原谅我。

在梅最终离开房间之前，她又向你投来了一个好奇但又有点害怕的目光。 """,
	MAE_MEETING_2 = """— 你好，又是一个外来者。很高兴这些天看到一位新访客。我怀疑你是被长耳朵的人的话带到这里的。这对我来说无关紧要，因为这只是神的另一个突发奇想。唯一的问题是这是否是冉达斯的突发奇想？到目前为止，我倾向于相信这是。说，你对我们怎么看？""",
	MAE_MEETING_2_OPTION_1 = """我确实有一些想法...""",
	MAE_MEETING_2_OPTION_2 = """我没有发现任何异常，如果有的话，每个人都应该保持开放""",
	MAE_MEETING_2_OPTION_3 = """我不太喜欢这种生活方式""",
	MAE_MEETING_2_1 = """— 你不太熟悉我们的习俗。我们是冉达斯的后裔，冉达斯是荒野和动物的创造者。作为他的孩子，我们接受了无结果的交配和爱的本质。这个部落中那些进入青春期的人学会了通过身体语言与他人分享情感的方式。新生的孩子被整个部落收养和抚养。""",
	MAE_MEETING_2_1_OPTION_1 = """拒绝接受的人呢?""",
	MAE_MEETING_2_1_OPTION_2 = """这对我来说太野蛮了""",
	MAE_MEETING_2_1_OPTION_3 = """听起来不错""",
	MAE_MEETING_2_1_1 = """— 他们自然不会被迫遵从习俗。他们甚至可以离开，尽管他们必须穿过精灵守卫才能到达大陆上危险性较低的地方。但这种情况很少发生。

— 你来得正是时候，因为一年一度的仪式即将到来。事实上，我在等像你这样的人。

— 你在来的路上见过梅，是吗？一个漂亮纯洁的城市女孩，几个月前才加入我们。她会为冉达斯做出理想的牺牲。""",
	MAE_MEETING_2_1_2 = """— 我知道有些外来者经常这么想，但大部分人似乎并不介意，甚至选择参加。不过，最近外来者很少。

— 你来得正是时候，因为一年一度的仪式即将到来。事实上，我在等像你这样的人。

— 你在来的路上见过梅，是吗？一个漂亮纯洁的城市女孩，几个月前才加入我们。她会为冉达斯做出理想的牺牲。""",
	MAE_MEETING_2_1_3 = """— 那你应该会觉得我们部落很有魅力。但正如你所看到的，我们有点小问题。

— 你来得正是时候，因为一年一度的仪式即将到来。事实上，我在等像你这样的人。

— 你在来的路上见过梅，是吗？一个漂亮纯洁的城市女孩，几个月前才加入我们。她会为冉达斯做出理想的牺牲。""",
	MAE_MEETING_2_2AND3 = """— 你来得正是时候，因为一年一度的仪式即将到来。事实上，我在等像你这样的人。

— 你在来的路上见过梅，是吗？一个漂亮纯洁的城市女孩，几个月前才加入我们。她会为冉达斯做出理想的牺牲。""",
	MAE_MEETING_3_OPTION_1 = """你要杀了她?!""",
	MAE_MEETING_3_OPTION_2 = """你在说什么?""",
	MAE_MEETING_3_OPTION_3 = """我不确定我是否需要知道""",
	MAE_MEETING_3_1 = """— 杀？不可能。你真的认为我们是野蛮人吗？她将接受萨满启蒙。作为我未来的继任者，她将不得不与一个外来者交配——这将是你的职责。

— 我一直在教她成为下一个萨满，我对她很有信心。对于下一个冉达斯的媒介，她有着良好的精神状态和丰满健康的身体。有点走样，但既然她不会成为猎人，那就不是问题了。

— 如果她怀孕了，这将是一个极好的迹象。由这种媒介滋养的新血液对部落来说是无价之宝。""",
	MAE_MEETING_3_2AND3 = """— 我一直在教她成为下一个萨满，我对她很有信心。对于下一个冉达斯的媒介，她有着良好的精神状态和丰满健康的身体。有点走样，但既然她不会成为猎人，那就不是问题了。

— 如果她怀孕了，这将是一个极好的迹象。由这种媒介滋养的新血液对部落来说是无价之宝。""", 
	MAE_MEETING_3_1_OPTION_1 = "交配?",
	MAE_MEETING_3_1_OPTION_2 = "她对此真的很满意吗?",
	MAE_MEETING_3_1_OPTION_3 = "你为什么要我这么做?",
	MAE_MEETING_3_1_OPTION_4 = "好的，我来做",
	MAE_MEETING_3_1_OPTION_5 = "我不会这么做",
	MAE_MEETING_4_1 = """— 是的。她将与一名男性外来者发生性关系，成为下一个冉达斯媒介。你的能量将为你们俩带来冉达斯的祝福，这是成为萨满的条件。而且，由于这是她第一次，这将使她的奉献更加强大。""",
	MAE_MEETING_4_2 = """— 当然。如果你愿意，你可以和她谈谈。她很害羞，但对于像她这样年纪还没有接受过一个男人的人来说，这是很自然的。不过，考虑到她是自愿加入我们的，我相信她已经下定决心了。""",
	MAE_MEETING_4_3 = """— 你是几个月来我们村里唯一欢迎的外来者，而且你看起来确实像个强壮的男人。没有其他要求。我希望我自己年轻一点...""",
	MAE_MEETING_4_4 = """— 很好，很好。莱昂会很高兴的，我们将开始准备工作。本周末将是仪式的完美时间。明天来找我，我们将确定细节。""",
	MAE_MEETING_4_5 = """萨夫拉看着你发脾气，但看到你不会改变主意，她愤怒地叹了一口气。

— 很好。我想我们可以用不同的方法解决一些问题。

思考了一段时间后，她向你提出了她的要求。

— 如果你给我们带来足够的长期供应，我们可以达成协议，我会为你向莱昂担保。给我们带来2000块肉和鱼，这样我们就有充足的储备以备不时之需。""",
	SAVRA_SUPPLIES_START = """""", # TODO add text. Savra greeting.
	SAVRA_SUPPLIES_START_OPTION = "我已经带来了你要求的物资",
	SAVRA_SUPPLIES_1 = """— 哇，你真的做到了。这对部落来说是很多食物。你信守诺言，我也会信守诺言，无论是什么，我都会为你的事情担保。很遗憾我们还不能举行仪式。""",
	SAVRA_RITUAL_START = """你再次进入萨满的小屋，发现萨夫拉在同一个地方，正在制作一些草药混合物。当她看到你时，转身向你挥手。

— 是你啊, [name]。幸好你来了。事实上，我现在还在做准备。如果你不介意，你可以去帮助梅，因为她目前正在村外采集草药。我会告诉你她在哪里...""",
	SAVRA_RITUAL_START_OPTION_1 = "我这就去",
	SAVRA_RITUAL_START_OPTION_2 = "好, 我会尽快",
	PRE_RITUAL_1 = """你来到了梅应该在的地方，但没有找到任何人。你以为这可能是一个错误的地方，但是经过搜索，你发现了打斗的痕迹和一个类似于你在定居点看到的篮子。

你的追踪尝试收效甚微。当你决定回去报告你的发现时，你听到附近灌木丛中传来沙沙声。当你走近时，一只小黄鼠狼迅速逃离。当你叹一口气准备离开时，你注意到这只小动物并没有像你通常预期的那样从视线中消失。

不知怎的，它小心翼翼地看着你，一动不动，好像需要你的注意。 [color=lime]你必须跟着它。[/color] 没有任何充分的理由遵循它，你仍然决定去做。""",
	PRE_RITUAL_2_1 = """当你跟随黄鼠狼穿过森林时，它很快就把你带到了它的目标：一个小的人类营地。几个笼子和家具清楚地表明它属于奴隶主。当你在营地里侦察时，你意识到你的向导很快就消失了，但这不再困扰你，因为在其中一个笼子里，你看到了一个熟悉的身影，很可能属于你要找的女孩。""",
	PRE_RITUAL_2_2 = """几个巡逻的奴隶贩子经过你的藏身之处。

{color=yellow|奴隶贩子: — 到目前为止，一整天只有一只兽化裔。真倒霉。

奴隶贩子2: — 至少她年轻又活力充沛，肯定会给我们带来一些金币。

奴隶贩子: — 哼，她又胖又弱。甚至不能把她卖出去当劳动力。}""",
	PRE_RITUAL_3 = """{color=yellow|奴隶贩子2: — 但她挺可爱的。

奴隶贩子: — 只有像你这样病态的混蛋才会觉得她很可爱。顺便说一句，你别在我们睡觉的时候操她，她的童贞可能是她唯一的价值。

奴隶贩子2: — 操... 那我可以用她的屁股吗?}

巡逻队继续前进，你该决定怎么做了。""",
	PRE_RITUAL_3_OPTION_1 = """尝试交易""",
	PRE_RITUAL_3_OPTION_2 = """潜行 (物理检定)""",
	PRE_RITUAL_3_OPTION_3 = """攻击""",
	PRE_RITUAL_4_1_1_100 = """你走近巡逻的奴隶贩子。起初你很惊慌，告诉他们你对他们刚抓到的一个奴隶感兴趣。他们似乎很高兴能在不需要做更多工作的情况下快速获得一些现金。经过一段时间的谈判，奴隶贩子说出了他们的最后价格：100金币。

当他们等待你的决定时，你意识到，如果你不能达成协议，他们不会让你离开并告发他们....""",
	PRE_RITUAL_4_1_1_300 = """你走近巡逻的奴隶贩子。起初你很惊慌，告诉他们你对他们刚抓到的一个奴隶感兴趣。他们似乎很高兴能在不需要做更多工作的情况下快速获得一些现金。经过一段时间的谈判，奴隶贩子说出了他们的最后价格：300金币。

当他们等待你的决定时，你意识到，如果你不能达成协议，他们不会让你离开并告发他们....""",
	PRE_RITUAL_4_1_1_500 = """你走近巡逻的奴隶贩子。起初你很惊慌，告诉他们你对他们刚抓到的一个奴隶感兴趣。他们似乎很高兴能在不需要做更多工作的情况下快速获得一些现金。经过一段时间的谈判，奴隶贩子说出了他们的最后价格：500金币。

当他们等待你的决定时，你意识到，如果你不能达成协议，他们不会让你离开并告发他们....""",
	PRE_RITUAL_4_1_1_OPTION_1 = """支付""",
	PRE_RITUAL_4_1_1_OPTION_2 = """战斗""",
	PRE_RITUAL_4_1_2 = """你把钱交给傻笑的奴隶贩子，他们把被俘的女孩带到你身边。你决定不挑起这场战斗，并迅速把她带离营地。""",
	PRE_RITUAL_4_2_1 = """{color=green|成功}

你成功地溜过巡逻队，来到梅的笼子外。幸运的是，笼子的钥匙就在几英尺远的地方，让你可以无声地解锁它。你尽可能少地发出声音，把梅带离奴隶营。""",
	PRE_RITUAL_4_2_2 = """{color=red|失败}

当你试图偷偷经过巡逻队时，你被树根绊倒，倒在地上，发出巨大的噪音。当奴隶贩子向你走来时，你意识到别无选择，只能战斗。""",
	PRE_RITUAL_4_3 = "你认为没有更好的选择，只能在他们知道你在哪里之前就发动袭击。下定决心，你猛烈地冲锋。",
	PRE_RITUAL_5 = """当你击败附近的奴隶贩子后，你走到笼子里，梅在里面，把她救了出来。幸运的是，她似乎是迄今为止唯一被抓住的人。当你帮助她恢复自由时，你决定在其他人出现之前离开这个营地。""",
	PRE_RITUAL_6 = """当你从奴隶营走到更安全的距离时，梅带着崇敬和宽慰的目光看着你。

— 谢谢。我正在采药的时候，他们从后面过来抓住了我。太可怕了...如果不是你，我不知道会发生什么。

— 我想知道这是否真的是某种命运，我们...""",
	PRE_RITUAL_6_OPTION_1 = "我很高兴你安全了",
	PRE_RITUAL_6_OPTION_2 = "下次小心",
	PRE_RITUAL_6_OPTION_3 = "我想你可以为此感谢我 (性检定)",
	PRE_RITUAL_6_OPTION_4 = "别在意",
	PRE_RITUAL_7_1AND2AND4 = """— 是-是的。我真的很感激。现在，如果你不介意的话，我必须在我们回来之前再次收集我们需要的草药。""",
	PRE_RITUAL_7_1AND2AND4_BAD = """{color=red|失败}

— 是-是的。我真的很感激。现在，如果你不介意的话，在我们回来之前，我必须再次收集我们需要的草药。""",
	PRE_RITUAL_7_3_1 = """{color=green|成功}

当梅意识到你的建议时，她紧张地看了你一眼。

— 不是我不喜欢你，而是...我不能。你必须明白，为了仪式，我必须保持童贞。""",
	PRE_RITUAL_7_3_1_OPTION_1 = "我可以接受口交",
	PRE_RITUAL_7_3_1_OPTION_2 = "那就用你的嘴",
	PRE_RITUAL_BLOW_1 = """— 你确实为我冒了生命危险……好吧，我可以。但是，请原谅我缺乏经验，我以前从未这样做过。

当梅跪在你面前，柔软的皮毛拂过你的腿时，你可以感觉到她紧张的气场。她深吸一口气，然后伸手去拿你的皮带，手指摸索着皮带扣。最后，她设法把你的阴茎从它的束缚中解放出来，她一看到它就喘着粗气。你忍不住对她的反应傻笑。

— 能... 能让我摸一摸吗?""",
	PRE_RITUAL_BLOW_2 = """你点点头，允许她探索你那坚硬、悸动的身体。她试探性地用手指抱住它，你可以感觉到她的温柔触摸让你的脊椎颤抖。当她开始抚摸你时，你忍不住呻吟，她的触摸一刻比一刻大胆。

当她继续取悦你时，你会不由自主地迷失在这种感觉中。你闭上眼睛，轻轻地叹了一口气。但你知道这还不够。你想要更多，让她给你看她的乳头。""",
	PRE_RITUAL_BLOW_3 = """她停顿了一下，眼神中带着一丝紧张。但她知道你想要什么，她慢慢地拉着胸罩，露出了她丰满的曲线。你忍不住要品尝她奢华的胸部。她有点胖，但这只会让她在你眼中更有吸引力。

当你继续盯着她看时，梅接受了暗示，低下头，把你的阴茎叼进嘴里。当她开始舔舐和吮吸时，你呻吟，她的舌头在你的阴茎上盘旋。尽管这很可能是她第一次，但她的才华令人惊讶。你可以感觉到自己变得越来越兴奋1，你的身体对她的触摸做出了反应。

— 嗯，这…没有我想象的那么难...""",
	PRE_RITUAL_BLOW_4 = """你伸出手来，用手抚摸她柔软的皮毛，在她继续取悦你的同时，把她拉得离你更近。很快，你就再也忍不住了。最后一声呻吟，你压在她的脸上，用你的精液填满她的嘴。

她一开始有点吃惊，但很快就恢复了行动，舔了舔嘴唇，品尝着你的味道。你站起来，感到满足和满足。梅抬头看着你，眼中流露出一丝自豪，意识到她已经满足了你的要求。你收拾行李，继续前行。""",
	PRE_RITUAL_7_3_3 = """— 再次感谢。我希望你没有失望？一开始有点可怕，但我想这是个好做法。 """,
	PRE_RITUAL_8 = """你帮助梅收集所需的植物，然后返回部落。

— 所以…嗯...你将成为我的仪式对象。你是想更了解我才来的？ """,
	PRE_RITUAL_8_OPTION_1 = "你对我来说不是很熟悉",
	PRE_RITUAL_8_OPTION_2 = "你能做这个仪式吗?",
	PRE_RITUAL_8_OPTION_3 = "我们走吧",
	PRE_RITUAL_9_1 = """— 我逃离了一个帝国小镇。我父母去世后，我很快就会成为一名奴隶。我听说了像我这样的部落，他们会允许我和他们一起生活。他们对我出奇地友好和接受，正如你所看到的，我已经成为萨满的学徒。

— 我不完全习惯他们对…的开放程度...你知道，但既然他们从来没有强迫过我，我想他们希望我自己完全接受。""",
	PRE_RITUAL_9_2 = """— 是的，从我来到这里的那一刻起，我就下定决心要做对我来说需要做的事情。碰巧你会成为……我的第一个。不要以为我是在说我不喜欢你或其他什么！我认为你很勇敢……很有吸引力... 

梅脸红了，把目光移开，意识到她可能说了一些尴尬的话。""",
	PRE_RITUAL_10 = """当你离定居点越来越近时，梅停在原地。

— 明天我们要参加一个仪式，我想问你一件事。我不想怀孕，但我无能为力。在仪式之前，我必须喝一种混合物，这会让我的头脑变得模糊，让我第一次更愿意怀孕。这种混合物有助于像我这样的提升者过得更轻松。

— 但是，它也会促进我的排卵，甚至避孕药也不会阻止我怀孕。我准备了一种粉末，可以抵消这种效果，但在仪式之前我无法接触混合物。

— 仪式结束后你不会呆在这里，所以这对你来说没什么，但是，请为我做这件事，我太害怕成为母亲了。如果你有机会，把粉末倒进我的碗里，千万不要让人看到。

你拿着装有粉末的小袋，梅递给你，把它收起来。当你进入部落时，梅向你鞠躬，然后离开你去送她。""",
	RITUAL_START = """日落后，部落点燃了一些你从未见过的香。你意识到，熟悉的春药香味应该会让每个人都更放松和兴奋，包括你。 """,
	RITUAL_START_OPTION_1 = "将梅的粉末放入碗中",
	RITUAL_START_OPTION_2 = "不要把梅的粉末放进碗里",
	RITUAL_1_1_GOOD = """— 你对这个碗很好奇，不是吗？你为什么不走到祭坛前准备一下, [name]? 

{color=green|成功}

为了确保没有人看到，你迅速把梅给你的粉末倒进为她准备的碗里。

你走向村庄中心的祭坛，在那里你看到了身穿长袍的梅。她稳稳地走向萨夫拉端给她的那碗药。

吸了一口气后，梅用双手把碗端到脸上，用力地吞下碗里的东西。当她闭上眼睛时，你看不出她的表情，过了一会儿，你注意到她脸上没有任何明显的厌恶表情。""",
	RITUAL_1_1_BAD = """— 你对这个碗很好奇，不是吗？你为什么不走到祭坛前准备一下, [name]?

{color=red|失败}

看来你没能破坏梅的仪式性药物，现在你必须去参加仪式了。

你走向村庄中心的祭坛，在那里你看到了身穿长袍的梅。她稳稳地走向萨夫拉端给她的那碗药。

吸了一口气后，梅用双手把碗端到脸上，用力地吞下碗里的东西。当她闭上眼睛时，你看不出她的表情，过了一会儿，你注意到她脸上没有任何明显的厌恶表情。""",
	RITUAL_1_2 = """你决定不冒险，也不按照她要求去做。也许你以后可以告诉她你没有机会这么做了。

你走向村庄中心的祭坛，在那里你看到了身穿长袍的梅。她稳稳地走向萨夫拉端给她的那碗药。

吸了一口气后，梅用双手把碗端到脸上，用力地吞下碗里的东西。当她闭上眼睛时，你看不出她的表情，过了一会儿，你注意到她脸上没有任何明显的厌恶表情。""",
	RITUAL_2 = """根据仪式规则，梅丢掉长袍，让它掉在地上，露出全身涂满仪式颜料的宽阔线条。

过了一会儿，她的眼睛变得不集中，动作变得迟缓。在她失去平衡之前，萨夫拉抓住她的手臂，走向祭坛。当梅落入你的怀抱时，萨夫拉满足地后退，并邀请你尽自己的一份力量。

— [name]... 我等不下去了...

梅的声音漫无目的，但又很感性。当你帮她在你面前躺下时，你开始注意到观察的部落成员开始相互亲热。""",
	RITUAL_3 = """梅的狭缝完全湿透了，这证明她已经完全准备好通过你的行动成为一个女人了。麻醉的阴霾已经完全消除了抵抗或逃离她的任何意愿，这是仪式的理想选择。一小股血迹将她阴部周围的皮毛涂成了红色。

当你猛扑到梅的阴部时，你的视野变窄，视野模糊，尽管你觉得梅在你面前比以往任何时候都更敏锐。这一次你是在参加仪式，但这并不重要。你想要更多的权力，这是一件高尚的事情，但不是每个人都想要。然而，权力决定了一切，任何接受它的人都会得到我的祝福。""",
	RITUAL_4 = """尽管这些人转向了不那么凶猛的生活方式，但他们的交配习惯有着巨大的生命力和力量。你对这个女孩的统治力，以及她对它的接受，使你们两个都成为完美的榜样。更重要的是，你们都不是本地人。”。

填满它。用你的种子填满她的子宫。让她接受它。让她的身体体验它。这就是她生来的目的。这就是你的天赋。给予和索取的无尽循环...""",
	RITUAL_5 = """你提高了速度，意识到你离高潮越来越近了。尽管看起来在精神错乱中迷失了方向，但梅似乎很快就明白了你的意图。没有什么能再分散你的注意力了，你最后一次用力推了一下，让梅充满了你的热种子，让她高兴地尖叫。

然而，这对你们任何一个人来说似乎都不够，你们又开始行动了。尽管梅表现出一些疲惫的迹象，但她似乎也不愿意停止。当你们继续享受这个可怜女孩敏感的阴部时，一对雄性兽化裔走近了你们。

—嘿，你不介意我们也和我们未来的萨满建立一些联系，是吗？

你意识到梅无法回答任何与此相关的问题，于是将目光转向萨夫拉。

— 我们听你的, [name]。 我们会尊重你的决定。""",
	RITUAL_5_OPTION_1 = """允许""",
	RITUAL_5_OPTION_2 = """拒绝""",
	RITUAL_6_1_1 = """一些雄性兽化裔从头上靠近梅，将它们直立的阴茎放在她的脸上。这个以前害羞的女孩顺从地抓住它们的成员，开始用嘴和手为它们服务，就像这是世界上最自然的事情一样。""",
	 RITUAL_6_1_2 = """当梅的身体被每一次新的高潮淹没时，她头顶上的雄性也被她弄到射出精液，喷在她的头和胸部。新的雄性取代了他，使她身上覆盖着越来越多的精液。然而，这并没有困扰她，因为她如饥似渴地吮吸并轮流为每只新的阴茎服务。

— 她的阴户只适合外来者。如果你真的需要，你可以用她的屁股。

当她的屁股第一次被刺穿时，梅又发出了一声愉快的呻吟。感觉今晚几乎整个部落的成年男性都由她服务...""",
	RITUAL_6_2 = """你认为梅不想事情发展到那么远，并拒绝了男人的要求。男人们看起来很生气，但却退缩了，从其他愿意的女人那里找到了一些安慰。尽管梅的脸上有点神志不清，但当你回到她颤抖的身体上工作时，你可以从她身上读到一些感激的暗示。感觉就像你花了一整晚的时间在做这件事，直到最终你的意识消失...""",
	AFTER_RITUAL_START = """第二天早上，你发现自己独自一人在其中一个小屋里休息。从太阳的角度来看，已经有点晚了，你决定出门。莱昂和萨夫拉迎接了你，他们似乎在等你。

{color=yellow|莱昂: — 精彩的仪式, [name]。 希望你昨晚没有太疼。}

{color=aqua|萨夫拉: — 是的，那确实很好。我觉得冉达斯为你和我们感到非常高兴。我们将在很长一段时间内受到祝福。}""",
	AFTER_RITUAL_START_OPTION_1 = "梅怎么样?",
	AFTER_RITUAL_START_OPTION_2 = "所以你现在要帮我吗？",
	AFTER_RITUAL_1_1 = """{color=aqua|萨夫拉: — 她和你一样在昨天之后一直在休息，但你似乎在这方面更有经验。如果你担心她的精神状态，我可以向你保证她一切都很好。 }

{color=yellow|莱昂: — 她是一个非常好的女人。是部落中一个很好的补充，有很好的责任感。}""",
	AFTER_RITUAL_1_2 = """{color=yellow|莱昂: — 你已经完成了你的交易，所以我会完成我的。我会去准备回复。你明天可以来找我。}""", 
	AFTER_RITUAL_2 = """梅离开帐篷后，看到你明显脸红了。

— ...早-早上好。你感觉好吗？""",
	AFTER_RITUAL_2_OPTION_1 = """是""",
	AFTER_RITUAL_2_OPTION_2 = """你呢?""",
	AFTER_RITUAL_3 = """— 我还是有点头晕。昨天的事情记不太清楚了。至少我很高兴这件事结束了。 """, 
	AFTER_RITUAL_3_OPTION_1 = "很有趣，不是吗？",
	AFTER_RITUAL_3_OPTION_2 = "是的，很高兴我们完成了它",
	AFTER_RITUAL_3_OPTION_3 = "你第一次做得很好",
	AFTER_RITUAL_4 = """— 就在这几天里，我觉得你对我来说变得非常重要。毕竟，你把我从那些奴隶贩子手中救了出来。""",
	AFTER_RITUAL_4_OPTION_1 = "我的奖励是值得的",
	AFTER_RITUAL_4_OPTION_2 = "你应该小心自己，下次不要被抓住",
	AFTER_RITUAL_4_OPTION_3 = "很好，你最终没有遇到什么坏事",
	AFTER_RITUAL_4_OPTION_4 = "你不能否认这是一次不同寻常的经历",
	AFTER_RITUAL_5_1 = """— 希望这不是你救我的唯一原因。""",
	AFTER_RITUAL_5_2AND3 = """— 是-是的，我想我对这些事情还是有点笨拙。再次感谢。 """,
	AFTER_RITUAL_5_4 = """— 嘿，我想你可以这么说，是的。不过，我不确定我是否想再次陷入那种情况。""",
	AFTER_RITUAL_GROUP_1 = """— 在仪式期间……我记得当我恍惚时，你允许别人利用我。我不敢相信你做了那样的事，甚至是在我第一次做的时候。""",
	AFTER_RITUAL_GROUP_1_OPTION_1 = "但你似乎很喜欢",
	AFTER_RITUAL_GROUP_1_OPTION_2 = "这对你的新职位来说是一次值得的经历",
	AFTER_RITUAL_GROUP_1_OPTION_3 = "我无法拒绝这样真诚的请求",
	AFTER_RITUAL_GROUP_1_OPTION_4 = "将身体与他人隔离是犯罪行为",
	AFTER_RITUAL_GROUP_2_1 = """— 那-那只是因为我没有想清楚，你知道的！我没有因为羞愧而死的唯一原因是我几乎不记得发生过什么。""",
	AFTER_RITUAL_GROUP_2_2 = """— 这不是你决定的，没有这样的经验我肯定能做到。""",
	AFTER_RITUAL_GROUP_2_3 = """— 嗯，我的朋友是对的，你们都一样，不能相信你们有任何礼节。 """,
	AFTER_RITUAL_GROUP_2_4 = """梅停顿了很长时间，试图理解你的话，但你的奉承似乎平息了她的痛苦。

— 即-即使你这么说，未经女孩同意，你也不应该对她这样做。 """,
	AFTER_RITUAL_GROUP_2_OPTION_1 = "对不起，让我们忘记它",
	AFTER_RITUAL_GROUP_2_OPTION_2 = "但你似乎很喜欢...",
	AFTER_RITUAL_GROUP_3_1 = """— 好，我们不谈这个了""",
	AFTER_RITUAL_GROUP_3_2 = """— 这-这对我来说很不寻常。我从未想过会发生这样的事情，但现在我想起来了……永远不会！让我们忘记它，好吗？""",
	AFTER_RITUAL_POWDER_1 = """— 萨夫拉说我怀孕了，我们都能感觉到……你为什么不按照我的要求在混合物中加入中和剂？我真的恳求过你。我还没有准备好成为母亲。""",
	AFTER_RITUAL_POWDER_1_OPTION_1 = "我们现在对此无能为力",
	AFTER_RITUAL_POWDER_1_OPTION_2 = "我没有很好的机会去做，所以这不是我的错",
	AFTER_RITUAL_POWDER_1_OPTION_3 = "我们现在应该照顾我们未来的孩子",
	AFTER_RITUAL_POWDER_1_OPTION_4 = "让你怀孕这个想法太诱人了",
	AFTER_RITUAL_POWDER_2_1AND2AND4 = """梅愤怒地叹了口气，好像她知道自己一开始就不应该信任你。

— ...算了。 """,
	AFTER_RITUAL_POWDER_2_3 = """梅困惑地看着你，好像在试图衡量你的话有多可靠。

— 呃-嗯，是的。我想这就是它诞生后我们现在应该做的。我希望你不要让我一个人呆着？...谢谢 """,
	AFTER_RITUAL_6 = """— 我从来没有真正问过，但你实际上在做什么？从现在起你打算做什么？""",
	AFTER_RITUAL_6_OPTION_1 = "我有一项重要的国家任务要完成",
	AFTER_RITUAL_6_OPTION_2 = "我只是一个有额外权利的冒险家",
	AFTER_RITUAL_6_OPTION_3 = "我可能正在执行拯救世界的任务",
	AFTER_RITUAL_6_OPTION_4 = "我只是去我必须去的地方，做我必须做的事",
	AFTER_RITUAL_GOOD_1 = """— 你-你知道，我希望我能再和你一起呆一段时间。并不是说我不喜欢这里，而是……我想我是因为昨天的事情才有这种感觉的。""",
	AFTER_RITUAL_GOOD_1_OPTION_1 = "我会非常感谢你的陪伴",
	AFTER_RITUAL_GOOD_1_OPTION_2 = "我真的不能带你一起去",
	AFTER_RITUAL_GOOD_2_1_1 = """梅的脸上闪过一丝兴奋，当她往下看时，兴奋消失了。

— 但-但那...我不确定我现在能否离开这里。 """,
	AFTER_RITUAL_GOOD_2_1_2 = """{color=aqua|萨夫拉: — 不，没关系，出去走走，体验更多的外部世界可能是件好事。 }

{color=aqua|梅: — 真的吗？我以为我现在会成为一个完整的部落萨满。}

{color=yellow|萨夫拉: — 别傻了，你知道，我还活着。出去和 [name]一起玩,我信心 [he]很适合你。}

想到昨天发生的一切，梅脸红了，但点头表示同意。

{color=aqua|梅: — 嗯... 请照顾我。}""",
	AFTER_RITUAL_GOOD_2_2 = "— 好的，我现在必须成为部落的萨满。不过，谢谢你。希望你能再次拜访我们。",
	AFTER_RITUAL_BAD_1_1 = """— 很高兴见到你，再次感谢你对我的盛情款待。也许你以后还会来。""",
	AFTER_RITUAL_BAD_1_2 = """— 很高兴见到你，再次感谢你对我的盛情款待。也许你以后还会来。

— 别忘了你的孩子会在这里。""",
	LEON_VISIT_START = """你进入酋长的小屋，但莱昂不见了。你决定找到萨夫拉，看看他去了哪里。""",
	LEON_VISIT_1_1 = """— 莱昂失踪了？那不像他。我从昨天晚上就没见过他，但也许你应该四处打听一下。""",
	LEON_VISIT_1_2 = """你应该去找莱昂，因为他好像失踪了。""",
	ASK_AROUND = """你问几个值班人员是否见过莱昂，其中一人说他看到莱昂在日出前离开。在知道他应该去的方向后，你在地图上标记位置。""",
	LEON_FIGHT_1 = """当你在该地区搜索时，你发现一些新的踪迹。喊出一声后，你发现前方有一些动静。当你靠近灌木丛时，莱昂跳到你身上，就好像你是他的猎物一样。事发突然，你几乎没能用武器挡住他的攻击。""",
	LEON_FIGHT_1_OPTION_1 = "*大喊*",
	LEON_FIGHT_1_OPTION_2 = "*推搡*",
	LEON_FIGHT_2_1 = """莱昂完全无视你的话，继续疯狂地向前推进。当你与他搏斗时，你看不到他脸上有一丝清醒。最后你设法摆脱了他，但战斗还没有结束...""",
	LEON_FIGHT_2_2 = """尽管你尽了最大的努力，你也不可能让他动一寸。当你与他搏斗时，你看不到他脸上有一丝清醒。最后你设法摆脱了他，但战斗还没有结束...""",
	LEON_FIGHT_3 = """在战胜他之后，你会注意到莱昂看起来相当疲惫，气喘吁吁。令你惊讶的是，他在喃喃自语时似乎恢复了一些意识。

— [name]... 告诉萨夫拉... 白色牡鹿.. 有... 

在说完这句话之前，他似乎又回到了野蛮的状态，并迅速逃进了树林。现在几乎没有希望抓住他了，所以你决定回到萨夫拉。""",
	SAVRA_TALK = """— 你回来了？情况怎么样？""",
	SAVRA_TALK_OPTION_1 = """关于莱昂...""",
	SAVRA_TALK_1 = """萨夫拉听着你的故事，心情越来越低沉。

— 所以事情就是这样...这是个问题。我们必须拯救莱昂，为此我们需要为仪式做准备，以解放他的思想。我会让你为它准备一些材料。 """,
	SAVRA_TALK_1_OPTION_1 = "到底发生什么了?",
	SAVRA_TALK_1_OPTION_2 = "你需要什么材料?",
	SAVRA_TALK_2_1 = """— 白鹿是一种神奇的野兽，每隔几年就会出现在我们的土地上。当它出现在这里时，它会让人们发疯，让他们进入荒野，自己变成野兽。通常它会影响弱者，但这次我们的首领被诅咒了所有人。在他回来之前，我将扮演他的角色。""",
	SAVRA_TALK_2_2 = """— 在牡鹿被击败之前，将某人从牡鹿的诅咒中拯救出来并不容易。这是我需要的东西清单，不要花太长时间。

萨夫拉递给你一张小羊皮纸，上面有配料。

— 50 魔力木材
— 25 铁木
— 15 神话皮革""",
	SAVRA_TALK_2_OPTION_1 = "看起来很简单",
	SAVRA_TALK_2_OPTION_2 = "可能需要一些时间",
	SAVRA_TALK_2_OPTION_3 = "我马上去办",
	SAVRA_TALK_3 = """— 很好，一旦你搞定了，再来找我。哦，还有一件事。我需要一个有着不错魔力的人来帮忙。一个有很高魔力的人。找一个适合它的人。""",
	SAVRA_TALK_OPTION_2 = "我带了配料",
	SAVRA_TALK_4 = "— 很好，很好，有人参加仪式后再和我谈谈。",
	SAVRA_TALK_OPTION_3 = "我带来了合适的帮手",
	SAVRA_TALK_5 = "— 是的，这很好。那我们就不要浪费时间了，我们开始仪式。",
	SAVRA_TALK_6 = """大约两个小时后，萨夫拉和 [name] 从密封的仪式小屋里出来，萨夫拉递给你一个雕刻的木人，他有点像莱昂，但头上有大角。当你走近看时，你注意到它发出微弱的光芒，但在你全神贯注后，它就不在了。

— 它完成了。这是图腾。现在你必须找到莱昂，这应该会让他摆脱诅咒。 """,
	SAVRA_TALK_6_OPTION_1 = "你不能自己做吗？",
	SAVRA_TALK_6_OPTION_2 = "这究竟是如何工作的？",
	SAVRA_TALK_6_OPTION_3 = "我来处理",
	SAVRA_TALK_7_1 = """— 不，正如我所说，我必须代替酋长行事，因为现在的酋长不见了。我相信你会处理好的。""",
	SAVRA_TALK_7_2 = """— 找到莱昂，把图腾带给他。剩下的就很简单了。""",
	LEON_ENCOUNTER_START = """当你这次积极寻找莱昂时，你设法在他发现你之前找到了他。你冲向他，准备打架。""",
	LEON_ENCOUNTER_1 = """在莱昂再次逃跑之前，你拔出图腾，它在你的手中发光。当图腾消失时，一道明亮的闪光使你失明，莱昂倒在了地上。你决定毫不拖延地将他带回部落。""",
	LEON_ENCOUNTER_2 = """在你把昏迷的莱昂送到萨夫拉身边几个小时后，他终于出现了，看起来比你想象的更有活力。

 — 我希望我能恰当地感谢你的救援, [name], 但我担心，就在我们说话的时候，白牡鹿威胁到了部落的福祉，这意味着我们不能浪费任何时间。在这个问题解决之前，我无法给你一个关于你来这里的问题的最终答案。 """,
	LEON_ENCOUNTER_2_OPTION_1 = "那么你现在打算做什么？",
	LEON_ENCOUNTER_2_OPTION_2 = "有什么我能帮忙的吗？",
	LEON_ENCOUNTER_3 = """ — 我们要像过去一样猎杀牡鹿。这是一项危险的活动，但我们就是这么做的。我不能请求你的帮助，但这个问题必须解决。""",
	LEON_ENCOUNTER_3_OPTION_1 = "你在计划什么？",
	LEON_ENCOUNTER_3_OPTION_2 = "我来帮忙",
	LEON_ENCOUNTER_3_OPTION_3 = "这听起来很有趣",
	LEON_ENCOUNTER_4_1 = """ — 我们将与最有经验的猎人和勇士组建一支狩猎队，追踪并击败这只牡鹿。这不是我第一次狩猎它，尽管它确实让我们慢了下来。承认我被它的诅咒迷住了，我很痛苦。""",
	LEON_ENCOUNTER_4_2 = """ — 很荣幸能得到你的帮助。你必须明白，这不是一场正常的小规模冲突或狩猎。白鹿是一种不同于其他任何动物的野兽。它不仅能够通过自己的存在引起疯狂，而且还拥有其他可怕的力量。你可以向萨夫拉询问这些，她比我更能解释。

 — 在野外与我们见面，在那里我们开始狩猎。""",
	SAVRA_STAG_QUESTION = """询问关于白牡鹿的情况""",
	SAVRA_STAG_ANSWER = """ — 白鹿是一种神秘的生物。尽管我们部落认为它是邪恶的，但我更倾向于相信它是一种挑战。冉达斯一定在考验我们的力量，因此它从未真正被击败。作为一名精神领袖，我不能忽视我的职责，请你至少尊重它。 """,
	WHITE_STAG_ENCOUNTER_1 = """你来到之前确定的地点，发现有一大群兽化裔准备狩猎。站在一旁，你发现了莱昂，并向他喊道。

 — 你来得正是时候，我们已经做好了追踪它的准备。看这里。

莱昂指着一棵被践踏的小灌木。仔细一看，你会发现它发出微弱的光芒。

 — 肯定最多一个小时左右。""",
	WHITE_STAG_ENCOUNTER_1_OPTION_1 = "很专业啊",
	WHITE_STAG_ENCOUNTER_1_OPTION_2 = "那我们就不要浪费时间了",
	WHITE_STAG_ENCOUNTER_2_1 = """ — 三年前，我曾面对过这头野兽。这是我作为酋长的职责，所以我必须履行。我们现在应该行动了。""",
	WHITE_STAG_ENCOUNTER_2_2 = """莱昂点头并离开 """,
	WHITE_STAG_ENCOUNTER_3 = """经过大约半个小时的侦察，你发现空地被一层厚厚的灰色薄雾笼罩，这在一天中的当前时间是不寻常的。猎兽者慢慢地包围了它。你进入薄雾，周围森林的声音似乎逐渐消失了，你在诡异的寂静中小心地向前移动。

在你意识到莱昂在对你大喊要小心之前，你看到了你一直在寻找的野兽：一只雄伟而陌生、不祥的白牡鹿，正看着你的眼睛，时间似乎在慢慢停止。""",
	WHITE_STAG_ENCOUNTER_3_OPTION_1 = "尝试移动",
	WHITE_STAG_ENCOUNTER_3_OPTION_2 = "呼叫援助",
	WHITE_STAG_ENCOUNTER_4 = """感觉迷失在野兽的光环中，你什么都做不了。你意识到你不知道自己在哪里，一个身影出现在你面前。

 — 所以你就是那个，他们口中的 [name].""",
	WHITE_STAG_ENCOUNTER_4_OPTION_1 = "*保持沉默*",
	WHITE_STAG_ENCOUNTER_4_OPTION_2 = "这里发生了什么..?",
	WHITE_STAG_ENCOUNTER_5 = """ — 像你这样的外来者竟然敢把鼻子伸进这个领域。真狂妄。你不怕失去自己的生命吗？你来这里干什么？""",
	WHITE_STAG_ENCOUNTER_5_OPTION_1 = "我只是来找精灵高级女祭司的",
	WHITE_STAG_ENCOUNTER_5_OPTION_2 = "我来帮助这片土地上的人民",
	WHITE_STAG_ENCOUNTER_5_OPTION_3 = "这不关你的事，恶魔",
	WHITE_STAG_ENCOUNTER_6_1 = """ — 滑稽。弗雷娅怎么还没有撕碎你那肮脏的身体？

你的存在玷污了这些土地，它的所有痕迹都必须被消灭。然后我们可以再次回到我们的对抗。""",
	WHITE_STAG_ENCOUNTER_6_2 = """ — 求救？这里没有任何人能帮你。

你的存在玷污了这些土地，它的所有痕迹都必须被消灭。然后我们可以再次回到我们的对抗。""",
	WHITE_STAG_ENCOUNTER_6_3 = " — 你敢称我为恶魔？很明显，你疯了。软弱。我不仅会夺走你的生命，而且你的灵魂也会被践踏。等我们做完，我们会看看剩下什么。",
	WHITE_STAG_ENCOUNTER_6_OPTION_1 = "我不会让你杀了我",
	WHITE_STAG_ENCOUNTER_6_OPTION_2 = "死在这里的是你",
	WHITE_STAG_ENCOUNTER_6_OPTION_3 = "也许我们不应该这么匆忙",
	WHITE_STAG_ENCOUNTER_7_1AND2 = """你尽最大努力为即将到来的挑战做好准备。看来白鹿会把你留在这个领域，直到你们中的一个人死。如果没有莱昂或其他人的帮助，这将是一场艰苦的战斗。”“""",
	WHITE_STAG_ENCOUNTER_7_3 = """ — 你想告诉我们什么？你害怕得发抖吗？""",
	WHITE_STAG_ENCOUNTER_7_OPTION_1 = "我有一项重要任务要完成",
	WHITE_STAG_ENCOUNTER_7_OPTION_2 = "我们可以用更文明的方式解决这个问题",
	WHITE_STAG_ENCOUNTER_7_OPTION_3 = "我现在无法停止对陛下的崇拜",
	WHITE_STAG_ENCOUNTER_7_OPTION_4 = "我可以平静地离开",
	WHITE_STAG_ENCOUNTER_8_1AND2AND4 = """ — 你的幼稚游戏够了。现在你要为你的傲慢付出代价！""",
	WHITE_STAG_ENCOUNTER_8_3 = """鹿女停顿了很长时间。在她最终回复之前，你无法读懂她的情绪。

 — 你的钦佩是可以理解的，但你的空话不会得到我的原谅。""",
	WHITE_STAG_ENCOUNTER_8_3_OPTION_1 = "也许我可以证明我的诚意",
	WHITE_STAG_ENCOUNTER_8_3_OPTION_2 = "我愿意拥有像你这样的女人",
	WHITE_STAG_ENCOUNTER_8_3_OPTION_3 = "也许我们可以达成一些共同协议？",
	WHITE_STAG_ENCOUNTER_9_2AND3 = """ — 嗯。你已经浪费了机会。让我们现在完成这项工作。""",
	WHITE_STAG_ENCOUNTER_9_1 = """ — 真的，现在。一个凡人可能会做什么让我感兴趣？""",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_1 = "我可以把你的形象打造成一件美丽的珠宝（铁匠）",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_2 = "我想为你（吟游诗人）献上一首歌",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_3 = "我会杀死你要求的任何敌人或野兽（骑士）",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_4 = "...",
	WHITE_STAG_ENCOUNTER_9_1_OPTION_5 = "我……不知道我怎么能做到",
	WHITE_STAG_ENCOUNTER_10_4 = """你注意到西菲拉愿意在这种情况下帮助你。

{color=aqua|西菲拉: — 啊，是的，我能画出一幅反映你神性的好画。}""",
	WHITE_STAG_ENCOUNTER_10_1AND2AND3AND4 = """ — 嗯。很好，凡人，我感觉到你说话的真诚。这一次你可以保留你的灵魂。也就是说，当我在这里的时候，还有一个分数需要解决。我们会再见面的。""",
	WHITE_STAG_ENCOUNTER_10_5_1 = """ — 嗯。你已经浪费了机会。让我们现在完成这项工作。""",
	WHITE_STAG_ENCOUNTER_10_5_2 = """ — 哼... 你在凡人中还不错。好吧，这一次你将被允许活下去，因为我们的时间不多了。

你还没来得及回答，女人的身影就被一道明亮的光笼罩着，让你眼花缭乱。""",
	WHITE_STAG_ENCOUNTER_11 = """随着薄雾消散，你发现自己回到了熟悉的树林。当与部落的战斗开始时，你看到白鹿以动物的形式回来了。""",
	WHITE_STAG_ENCOUNTER_12 = " — 现在，不要让它溜走！你, [name], 也要为激烈的战斗做好准备。",
	WHITE_STAG_ENCOUNTER_13 = """通过你的共同努力，你已经对白鹿造成了足够的伤害。伴随着震耳欲聋的尖叫声，它的形态慢慢消失在空中。看到这一幕，莱昂和他的一行人胜利地咆哮着。部落再次战胜了威胁...""",
	WHITE_STAG_ENCOUNTER_14 = """你回到部落的定居点，休息后再次与莱昂会面。

{color=yellow|莱昂: — 一场伟大的战斗, [name]。我们都对你的战斗赞不绝口，你之所以能排在第一位是有原因的。这是我对精灵们的回答，你可以把信送回去了。但由于他们的魔力，你将无法阅读。}

{color=aqua|萨夫拉: — 以后来拜访，欢迎您的光临。}""",
	PRIESTESS_TALK_START = """你去了埃伦的住处，但发现它锁着。当你穿过走廊时，一名服务员走到你面前，让你跟着她去她住处见高级女祭司。显然没有更好的选择，你顺从地跟着她。""",
	PRIESTESS_TALK_1 = """当你进入房间时，你会注意到大女祭司似乎比平时更友好，尽管只是勉强友好。

 — [name], 对吗？你顺道来是件好事。我听说你因故去了野兽部落。并不是说我们禁止这种活动，但这让我很好奇是什么引导你去那里。""",
	PRIESTESS_TALK_1_OPTION_1 = "我只是一个冒险家，我对这样的地方很好奇",
	PRIESTESS_TALK_1_OPTION_2 = "埃伦让我送信",
	PRIESTESS_TALK_1_OPTION_3 = "我真的不能透露",
	PRIESTESS_TALK_2_1 = """ — 哦，是这样吗？我没想到任何有教养的人会对那些野蛮人感兴趣。

 — 你是一个外来者，所以你可能不完全了解我们土地上的情况。作为弗雷娅的选民，我有责任通过为每个人提供合法的地位来维护我们人民的和平与秩序。母亲的律法对我们来说是绝对的，尽管我有这样的地位，但我无法挑战它们。

 — 但是，让我们来谈谈你为什么来这里。你已经证明了自己是一个不同寻常的人，在你等待Erlen的时候，我有一项个人任务要给你。我想让你去古庙给我们取一些圣水，为即将到来的仪式准备。通常情况下，这项挑战将由我们的军队领导人完成，但正如你所看到的，他目前不在这边。""",
	PRIESTESS_TALK_2_2 = """ — 是这样吗？好吧，那不是我关心的问题。

 — 你是一个外来者，所以你可能不完全了解我们土地上的情况。作为弗雷娅的选民，我有责任通过为每个人提供合法的地位来维护我们人民的和平与秩序。母亲的律法对我们来说是绝对的，尽管我有这样的地位，但我无法挑战它们。

 — 但是，让我们来谈谈你为什么来这里。你已经证明了自己是一个不同寻常的人，在你等待埃伦的时候，我有一项个人任务要给你。我想让你去古庙给我们取一些圣水，为即将到来的仪式准备。通常情况下，这项挑战将由我们军队的领导人完成，但正如你所看到的，他目前不在这边。""",
	PRIESTESS_TALK_2_3 = """女祭司皱着眉头，但很快改变了表情，因为这对她来说并不重要。

 — 你是一个外来者，所以你可能不完全了解我们土地上的情况。作为弗雷娅的选民，我有责任通过为每个人提供合法的地位来维护我们人民的和平与秩序。母亲的律法对我们来说是绝对的，尽管我有这样的地位，但我无法挑战它们。

 — 但是，让我们来谈谈你为什么来这里。你已经证明了自己是一个不同寻常的人，在你等待埃伦的时候，我有一项个人任务要给你。我想让你去古庙给我们取一些圣水，为即将到来的仪式准备。通常情况下，这项挑战将由我们军队的领导人完成，但正如你所看到的，他目前不在这边。""",
	PRIESTESS_TALK_2_OPTION_1 = "你为什么现在找我?",
	PRIESTESS_TALK_2_OPTION_2 = "这个仪式你需要圣水做什么?",
	PRIESTESS_TALK_2_OPTION_3 = "这件事对我有什么好处?",
	PRIESTESS_TALK_3_1 = """ — 正如我所说，你已经证明了自己非常有冒险精神，不是吗？只有极少数精选的精灵被允许去那里。作为这些土地的外来者，这样的限制不适用于你。""",
	PRIESTESS_TALK_3_2 = """ — 作为一个外来者，这不是你真正应该关心的。这是我们必须以弗雷娅的名义进行的常规仪式。

 — 这是一个小药瓶，可以让你进入寺庙内部。你用它装满水。寺庙离这里不远，一旦你回来，我们可以满足你的任何要求。 """,
	PRIESTESS_TALK_3_3 = """ — 啊，我真傻，我差点忘了。我一直在想你之前说的话。这可能有点道理。我想如果你为我这样做，我们可以就你接触圣碗达成协议。这是你的目标，不是吗？

 — 这是一个小药瓶，可以让你进入寺庙内部。你用它装满水。寺庙离这里不远，一旦你回来，我们可以满足你的任何要求。""",
	PRIESTESS_TALK_3_OPTION_1 = "这将是我的荣幸",
	PRIESTESS_TALK_3_OPTION_2 = "好吧，如果你坚持",
	TEMPLE_START = """你来到了女祭司告诉你的地方，在四处寻找后，你找到了一个被毁坏的通往所谓寺庙的入口。然而，它被一块大石板挡住了。看起来你需要一个特别强壮的人来移动它...""",
	TEMPLE_START_OPTION_1 = "尝试搬动",
	TEMPLE_START_OPTION_2 = "使用酸性炸弹",
	TEMPLE_START_OPTION_3 = "离开",
	TEMPLE_1_1_1 = """[name] 用[his]力量推开石板，让你进入神殿。""",
	TEMPLE_1_1_2 = """你肌肉起伏如山脉，心脏搏动如战鼓，石板谅必退让。""",
	TEMPLE_1_2 = """你往石板上扔一个不稳定的催化剂，它会把石头融化到你能穿过的程度。这可能会阻止石头将来挡住其他入侵者，但现在想起来已经太晚了。""",
	TEMPLE_2_1 = """当你走进大厅时，你听到一群人向入口靠近的声音。这群人看起来很熟悉，但他们似乎认不出你。
	
小强盗: — 老大，你看，这群傻子给我们开的。

胖强盗: — 这些家伙看起来有点熟...

首领: — 闭嘴，你们这些白痴。日安，陌生人。你在这里发现了一个不错的地方。你让我们把里面的东西拿走怎么样？收藏家们会为古老的精灵艺术品和其他东西付出高昂的代价。比方说，1000金币，你留下什么就让我们拿走？""",
	TEMPLE_2_2 = """当你走进大厅时，你听到一群人向入口靠近的声音。这群人看起来很熟悉，但他们似乎认不出你。
	
小强盗: — 老大，你看，这群傻子给我们开的。

胖强盗: — 这些家伙看起来有点熟...

首领: — 闭嘴，你们这些白痴。日安，陌生人。你在这里发现了一个不错的地方。你让我们把里面的东西拿走怎么样？收藏家们会为古老的精灵艺术品和其他东西付出高昂的代价。比方说，1000金币，你留下什么就让我们拿走？

艾尔: — 这是不对的，你不能让任何人这样破坏圣地。""",
	TEMPLE_2_OPTION_1 = "成交",
	TEMPLE_2_OPTION_2 = "像这样的宝藏肯定比那个值钱（魅力因素检定）",
	TEMPLE_2_OPTION_3 = "不",
	TEMPLE_3_1_1 = """{color=green|成功}
小强盗: — 你在开玩笑?

首领: — 嗯，好吧，我想在这种情况下我们可以付给你1500金币，但这是我们最后的报价 """,
	TEMPLE_3_1_2 = """ {color=red|失败}

首领: — 不行，伙计，我们还没那么有钱。一千已经是一个不错的价格了。""",
	TEMPLE_3_2 = """首领: — 太糟糕了。我们不会放过这个机会的。抓住他们，伙计们。

这群人拔出武器，准备战斗。""",
	TEMPLE_4_1 = """艾尔皱着眉头，但什么也不敢说。

强盗首领愉快地笑了。

首领: — 很好，非常好。在这里，你可以像承诺的那样得到这些金子。我确信这个地方本身就是一个宝藏。

他递给你一大笔金子，然后你们分道扬镳，向前走进寺庙。""",
	TEMPLE_4_2 = """强盗首领愉快地微笑着。

首领: — 很好，非常好。在这里，你可以像承诺的那样得到这些金子。我确信这个地方本身就是一个宝藏。

他递给你一大笔金子，然后你们分道扬镳，向前走进寺庙。""",
	TEMPLE_5 = """首领: — 该死的混蛋，这次你赢了！
	
当你们让他们逃离现场时，你们可以安全地深入寺庙。""",
	TEMPLE_6_1 = """穿过这座墙壁已成废墟的古庙，你最终看到一扇大门，这似乎正是你所要寻找的。然而，当你走近时，一群类似精灵士兵的幽灵出现在你面前，说着某种未知的语言。这似乎是另一种审判，也可能是一种防御系统。""",
	TEMPLE_6_2 = """穿过这座墙壁已成废墟的古庙，你最终看到一扇大门，而这扇大门似乎正是你所要寻找的。然而，当你走近时，一群类似精灵士兵的幽灵出现在你面前，并说着某种未知的语言。这似乎是另一次审判，也可能是一种防御系统。

 — 等等，这些守护者必须被某种能量源召唤...

艾尔在周围搜寻了一段时间，直到她终于在天花板上发现了一块孤零零的水晶。她射出一箭，打碎了水晶，精灵幽灵消失在视线之外。""",
	TEMPLE_6_2_OPTION_1 = "干得好，艾尔",
	TEMPLE_6_2_OPTION_2 = "下次做之前问我",
	TEMPLE_7_1 = """ — 没什么特别的，我过去也遇到过类似的事情。这让我有点担心这个地方不会再受到保护了。""",
	TEMPLE_7_2 = """ — ...抱歉。我没想清楚。无论如何，我们现在可以安全通过了。""",
	TEMPLE_8 = """你进入一个小房间，房间中央有一个古老的精灵祭坛，看起来完好无损。水从上面流下来，消失在地板的裂缝下。你用女祭司提供的瓶子舀了一些水，然后离开了这个地方。""",
	AFTER_TEMPLE_PRIESTESS_1 = " — 你带了我要的东西吗？",
	AFTER_TEMPLE_PRIESTESS_1_OPTION_1 = "不",
	AFTER_TEMPLE_PRIESTESS_2 = " — 那你不应该考验我的耐心。等你有耐心了再回来。..",
	AFTER_TEMPLE_PRIESTESS_3 = """女祭司出乎意料地很快接受了你的请求。当你进入她的房间时，当你递给她装满圣水的小瓶时，她看起来几乎很幸福。

 — 你做的很好, [name]。杰出的工作，对于一个外来者来说...我想我不再应该称你为一个简单的外来者了，是吗？说到这里，我的真名是海伦维尔，你现在可以使用它了。我们终于可以举行仪式了... """,
	AFTER_TEMPLE_PRIESTESS_3_OPTION_1 = "我们的协议怎么样？",
	AFTER_TEMPLE_PRIESTESS_3_OPTION_2 = "我相信你欠我一些东西",
	AFTER_TEMPLE_PRIESTESS_4 = """ — 是的，确实，我没有忘记，但仪式目前对我们来说是更重要的。一旦完成，我以弗雷娅的荣誉发誓，将帮助你完成任务。在那之前，你可以把自己视为我的贵宾。 """,
	AFTER_TEMPLE_PRIESTESS_4_OPTION_1 = "也许在那之前你可以用其他方式感谢我",
	AFTER_TEMPLE_PRIESTESS_4_OPTION_2 = "我想我别无选择",
	AFTER_TEMPLE_PRIESTESS_4_OPTION_3 = "我会等待",
	AFTER_TEMPLE_PRIESTESS_5_1_1 = """海伦维尔在观察你的外表时，给你一个更亲密的眼神，之后她的脸上露出罕见的淡淡微笑。

 — 也许我可以。你知道吗，弗雷娅的高级女祭司是不允许被男人的触摸所玷污的，所以如果你是男性，我不得不拒绝。但是这里没有男人...

海伦维尔诱惑性地移到漂亮的床上，同时她一直盯着你。慢慢地，她脱下了优雅的连衣裙。""",
	AFTER_TEMPLE_PRIESTESS_5_1_2 = """— 你能得到许多男人梦寐以求的东西，这让你高兴吗？来吧，拿上你的奖励。
	
	没有人会错过这样的机会，你确实会得到你的奖励。当你滑到床上时，意识到它是多么柔软，给人留下了深刻的印象，但当你与她接触时，她的皮肤给你留下更深刻的印象。她的皮肤柔软，只有那些远离你所忍受的艰苦劳动的人才能拥有柔软的丝绸般的触感。
	
	你慢慢地向她爬去，当你屈服于诱惑时，双手向她的臀部滑动，你的脸在她的臀部上滑动，在轻轻咬皮肤之前轻轻地用鼻子蹭皮肤。海伦维尔对你的蚕食反应并不热烈，在她说话之前，你就被狠狠地瞪了一眼。""",
	AFTER_TEMPLE_PRIESTESS_5_1_3 = """— 文雅一点。

	她的指责没有表现出愤怒，只有一句坚定的话，表明了她希望得到遵守。考虑到这一“命令”，你仍然会咬她，尽管它的轻度足以让她摇晃，并再次尝试指责，但一旦你找到她的喉咙，它就会在轻柔的呻吟声中消失。她的皮肤很美味，质地柔软，有蜂蜜味。用她的脖子过一段时间后，当你把她拉得更近时，你会进一步滑到床上，膝盖放在她的大腿之间。

	现在，你们两个纠缠在一起，当你继续对她的脖子和肩膀的皮肤进行爱抚时，她的大腿摩擦，她的指甲在你的背部和肩膀上留下痕迹，偶尔还会因为位置特别好的研磨而留下很深的痕迹，导致她卡住。值得称赞的是，由于她对你做了同样的事情，你最终也没有按照她的“命令”给她打几次标记。

— 我-我说!-""", 
	AFTER_TEMPLE_PRIESTESS_5_1_4 = """你咬住她的嘴唇，打断了她的抗议，当你的手从她的臀部滑到她的胸部时，小精灵在发抖，轻轻地摩擦，然后一根手指在她的乳头上滑动，很快就引起了她的注意，迫使她忽略其他事情。

	几分钟后，吻被打破了，你们都在喘息，当你们探索时，你们的嘴顺着她往下流，沿着她品尝，直到她被抬到床上更高的位置，当你们现在抬头看着她时，她的膝盖被抬到你的肩膀上。当你们开始慢慢地把舌头滑过精灵女人的入口，还没有展开她的花瓣时，一些期待的时刻会带来一种柔软的快乐，你的舌头只能顺着她光滑女人的棱角。

	海伦维尔在这件事上很快恢复了镇静，当她低头看着你时，脸上仍然通红；你永远不会知道什么想法，但当你的舌头从她的嘴唇之间滑落，找到她敏感的阴蒂的那一刻，她发出的声音和表情都是纯粹的快乐。品尝她的几分钟很快就变成了再次用鼻子蹭她的大腿内侧，在你继续收集奖励之前，轻轻地咬了一下。
""", 
	AFTER_TEMPLE_PRIESTESS_5_1_5 = """值得称赞的是，海伦维尔保持了一段时间的冷静，她的臀部在颤抖，她像平时脸上一样有尊严地低头看着你，尽管她的眼睛上笼罩着一丝喜悦。驱使她前进的秘密并不难找到，但她的反应很微妙，直到你最后一次把舌头直接滑过她的阴蒂，她的手向下伸去抓对着你的头发，她喉咙里传出饥饿的呻吟声。	

知道你会继续在那里舔她，当她喘着粗气呻吟时，她的臀部在你的手中滚动，很快，当你感觉到她现在很紧张时，声音就不再微妙了，当她开始高潮时，她的屁股在发抖。
""", 
	AFTER_TEMPLE_PRIESTESS_5_1_6 = """海伦维尔在那里躺了一会儿，然后松开你的头发，她低头看着你，只是气喘吁吁，然后放松下来。几秒钟后，你意识到这不是一个互利的安排，当你开始纠正时，站起来，眼睛一直在她身上移动。

 — 警卫会...护送你出去。

	警卫安静地护送你出去，尽管一直以来，沉默的人的眼神在钦佩和恐惧之间徘徊。纪律严明，但你忍不住注意到，看起来两人几乎想殴打你。""", 
	AFTER_TEMPLE_PRIESTESS_5_1_1_BAD = """— 恐怕这是不可能的。弗雷娅的女祭司不会被男人的触摸所玷污。 """,
	AFTER_TEMPLE_PRIESTESS_5_1AND2 = """当你走出女祭司的房间时，一个戴着兜帽的士兵叫你。在确认了你的身份后，他告诉你，埃伦想见你在郊区的树林里。在向你转达了他的位置后，这个士兵悄悄地离开了。""",
	ERLERN_ENCOUNTER_START = """侦察完这个位置后，你找不到任何活动迹象，开始怀疑自己是不是来错地方了。突然，几个精灵士兵出现在你面前，让你大吃一惊。当他们检查你时，他们让你跟随他们去见埃伦。""",
	ERLERN_ENCOUNTER_1 = """埃伦在树林中的临时营地与你会面。如果你不知道那里有营地，你可能压根找不到。埃伦的脸上一直没有表情，直到你把莱昂的信递给他。看完信后，他的表情变得更加悲观。

 — 我明白了... 这很麻烦。 

经过长时间的停顿和思考这封信，他终于开口说话了。

 — 他们表示，在任何紧急情况下，他们都会支持在那里赢得信任的人。基本上，这使你成为他们在这里的代表。我不得不告诉你一些细节，我将需要你的进一步帮助。比如说，你对我们的社会到底了解多少？""",
	ERLERN_ENCOUNTER_1_OPTION_1 = "除了你所说的之外，没有太多",
	ERLERN_ENCOUNTER_1_OPTION_2 = "什么都不知道",
	ERLERN_ENCOUNTER_1_OPTION_3 = "我不在乎",
	ERLERN_ENCOUNTER_2_1AND2 = """ — 正如你所知，弗雷娅的女祭司是精灵的首领。虽然我的职位肯定不低，但在和平时期，我只不过是一名特种部队指挥官。我直接隶属于女祭司。

 — 虽然我并不怀疑弗雷娅的指导，但我关心的是海伦维尔的规则。此外，我和我的部队驻扎在这里，除了把我从首都赶走之外，没有任何原因。我把你送到兽人部落，因为他们对我们的政治有一些间接的影响，也可以发挥一些作用。海伦维尔对他们也不好，然而，她的统治并非不可避免。

 — 但事情似乎变得越来越复杂。我的目标仍然很坚定，但似乎我需要做更多的工作来实现它。我能再请你帮个忙吗？""", 
	ERLERN_ENCOUNTER_2_3 = """埃伦决定不理会你的话，仍然解释自己。

 — 正如你已经知道的，弗雷娅的女祭司是精灵的首领。虽然我的职位肯定不低，但在和平时期，我只不过是一名特种部队指挥官。我直接隶属于女祭司。

 — 虽然我并不怀疑弗雷娅的指导，但我关心的是海伦维尔的规则。此外，我和我的部队驻扎在这里，除了把我从首都赶走之外，没有任何原因。我把你送到兽人部落，因为他们对我们的政治有一些间接的影响，也可以发挥一些作用。海伦维尔对他们也不好，然而，她的统治并非不可避免。

 — 但事情似乎变得越来越复杂。我的目标仍然很坚定，但似乎我需要做更多的工作来实现它。我能再请你帮个忙吗？""",
	ERLERN_ENCOUNTER_2_OPTION_1 = "是",
	ERLERN_ENCOUNTER_2_OPTION_2 = "否",
	ERLERN_ENCOUNTER_3_1 = """ — 很好。我被困在这里，我需要你从首都带另一个人来找我。还有另一位年轻但聪明的弗雷娅女祭司，你可以在寺庙里找到她。我希望你把她带到我身边，因为她可能会成为下一任女祭司的候选人。

 — 你不应该再浪费时间了，不管怎样，只要把她带到这里。""",
	ERLERN_ENCOUNTER_3_2 = """""", # TODO add text
	LIRA_ENCOUNTER_1 = """四处寻找后，你终于找到了埃伦找你的女祭司。你把她带到一个隐蔽的地方，并解释说埃伦想让她来找他。

 — 埃-埃伦想让我来吗？恐怕这会很困难。最近我们被禁止离开寺庙。我不能冒险，因为我的行为已经让我脱颖而出。""",
	LIRA_ENCOUNTER_1_OPTION_1 = "肯定有办法的",
	LIRA_ENCOUNTER_1_OPTION_2 = "没有你我不能离开",
	LIRA_ENCOUNTER_2 = """里拉停顿了很长一段时间，思考各种可能性，然后提出了自己的建议。

 — 如果集合期间有人代替我，我可能会出去。如果你能找到一个和我长得很像的人，另一个部落精灵，那么我们就能欺骗寺庙的守卫。""",
	LIRA_ENCOUNTER_2_OPTION_1 = "也许我们可以考虑其他方式…（智慧因素检定）",
	LIRA_ENCOUNTER_2_OPTION_2 = "找到人我就回来",
	LIRA_ENCOUNTER_3_1_GOOD = """{color=green|成功}

 — 现在我想一想…我也许可以用一些饮料贿赂警卫。如果你给我带10杯威士忌，那就足够让他们放我走了。""",
	LIRA_ENCOUNTER_3_1_GOOD_OPTION_1 = "我一拿到就回来",
	LIRA_ENCOUNTER_3_1_BAD = """{color=red|失败}

 — 不-不，我真的没想到什么。对不起，我不擅长这种事。""",
	LIRA_ENCOUNTER_3_1_BAD_OPTION_1 = "找到人我就回来",
	LIRA_ENCOUNTER_4 = """你发现里拉似乎在热切地等待着你的进展。""",
	LIRA_ENCOUNTER_4_OPTION_1 = "我带来了另一个部落精灵来代替你",
	LIRA_ENCOUNTER_4_OPTION_2 = "我带来了你要的威士忌",
	LIRA_ENCOUNTER_4_OPTION_3 = "*离开*",
	LIRA_ENCOUNTER_5_1_1 = " — 好吧，那我们得换衣服了。请给我一两分钟换衣服...",
	LIRA_ENCOUNTER_5_1_2 = "过了一段时间，你设法把里拉从寺庙的场地上偷偷带走。她已经准备好与埃伦会面了。",
	LIRA_ENCOUNTER_5_2_1 = " — 好吧……给我，我会把它和一些草药混合，让它更正宗。 ",
	LIRA_ENCOUNTER_5_2_2 = "过了一段时间，里拉通过贿赂警卫通过了他们。她准备去见埃伦。",
	ERLEN_LIRA_1 = "你认为没有里拉就不应该去找埃伦。",
	ERLEN_LIRA_2 = """当里拉看到埃伦时，你会注意到部落精灵女孩的表情发生了变化，变得比以前更加紧张。

{color=yellow|里拉: — 很高兴见到你，指挥官埃伦。}

{color=aqua|埃伦: — 你成功了。你没有受伤吧？}

{color=yellow|里拉: — 不-不，不是那样的。}""",
	ERLEN_LIRA_2_OPTION_1 = "这有点困难，但我们成功了",
	ERLEN_LIRA_2_OPTION_2 = "这太容易了，也许你需要更严格的安全措施",
	ERLEN_LIRA_2_OPTION_3 = "现在怎么办？",
	ERLEN_LIRA_3_1 = """{color=aqua|埃伦: — 干得好，现在告诉我发生了什么。}""",
	ERLEN_LIRA_3_2 = """{color=aqua|埃伦: — 我向你保证，如果是我的私人团队，我不会对他们那么宽容，但无论如何都要做得好。}""",
	ERLEN_LIRA_3_3 = """{color=aqua|埃伦: — 首先，我想知道发生了什么。里拉，你能解释一下吗？}""",
	ERLEN_LIRA_4 = """里拉解释了她是如何被宵禁的。这个消息让埃伦变得更加紧张。

{color=aqua|埃伦: — 妈的，所以我们现在真的没有时间了……女祭司一定计划在接下来的几天或任何时候进行化身仪式。}""",
	ERLEN_LIRA_4_OPTION_1 = "化身仪式?",
	ERLEN_LIRA_4_OPTION_2 = "她为什么要把你赶走?",
	ERLEN_LIRA_4_OPTION_3 = "那么我们真的有机会阻止她吗？",
	ERLEN_LIRA_5_1 = """{color=aqua|埃伦: — 我必须解释。女祭司不是永恒的统治者，也不是由议会选出的。女祭司是弗雷娅每隔几年选出的。为了召唤女神，要举行仪式，将她的灵魂带进寺庙，暂时居住在一个凡人的身体里，并做出决定。

埃伦: — 当然，她只会选择一个当时在场的人，所以通常只允许虔诚的信徒。通常情况下，她会选择现任女祭司来维持她的统治，但如果弗雷娅愿意，可以选择一位新的女祭司。

埃伦: — 然而，这一次，女祭司感受到了她的规则引起的不满，包括我和许多其他人。因此，我被打发走了，那些级别较低的追随者也被关了起来。这是为了确保她的地位不会改变。}""",
	ERLEN_LIRA_5_2 = """{color=aqua|埃伦: — 仪式需要一位男性领袖的参与，以平衡我们女性主导的社会。因此，最强壮的男性精灵必须从古庙中获得原始水源。那就是我，但我不确定她的计划会如何展开，因为我知道我不会帮助她。}""",
	ERLEN_LIRA_5_2_OPTION_1 = "我可能给她拿到了这水...",
	ERLEN_LIRA_5_2_OPTION_2 = "我不知道是怎么回事，但她可能已经通过某种方式得到了",
	ERLEN_LIRA_5_2_1 = """{color=aqua|埃伦: — 是-是你干的？该死……我想那样的话我们真的没有时间了。不要太责怪自己，我相信她无论如何都会找到其他办法的。}""",
	ERLEN_LIRA_5_2_2 = """{color=aqua|埃伦: — 是的，那时做最后的准备是有意义的。我们现在真的没有时间了。}""",
	ERLEN_LIRA_5_3 = """{color=aqua|埃伦: — 不完全。但我想寻求你的帮助……不，事实上我需要你的帮助。 }

你和里拉都疑惑地看了埃伦一眼。

{color=aqua|埃伦: — 我想我终于要解释了。当我把你送到兽人部落时，你携带的信中包含了请求莱昂支持这场政变的请求，并向他提出了一些请求以确保他的帮助。虽然兽人被我们制服，但他们仍然可以构成重大威胁。然而，他们的回应...}""",
	ERLEN_LIRA_5_3_OPTION_1 = "结果如何?",
	ERLEN_LIRA_5_3_OPTION_2 = "他们拒绝了?",
	ERLEN_LIRA_5_3_OPTION_3 = "一定是以某种方式要求我参与",
	ERLEN_LIRA_6_1 = """{color=aqua|埃伦: — 莱昂表示，如果他们要被拖入这件事，他们只会追随赢得他们尊重的人。无论你做了什么，这都不是我们任何人都可能实现的。 }""",
	ERLEN_LIRA_6_2 = """{color=aqua|埃伦: — 不，至少不是直接的。莱昂表示，如果他们要被拖入这件事，他们只会追随赢得他们尊重的人。无论你做了什么，这都不是我们任何人都可能实现的。}""",
	ERLEN_LIRA_6_3 = """{color=aqua|埃伦: — 嗯，你猜到了吗？是的，莱昂表示，如果他们要被拖入这件事，他们只会追随赢得他们尊重的人。无论你做了什么，这都不是我们任何人都可能实现的。 }""",
	ERLEN_LIRA_6_OPTION_1 = "所以，这就是你需要我帮助的原因",
	ERLEN_LIRA_6_OPTION_2 = "我不确定我是否适合承担这种责任",
	ERLEN_LIRA_7_1 = """{color=aqua|埃伦: — 没错。我希望你能帮助我们。

埃伦: — 我已经以你的名义派信使去找莱昂了，所以他们应该朝着首都的方向前进。这很大胆，但有你在我们这边，我们应该能避免任何严重的后果。}""",
	ERLEN_LIRA_7_2 = """{color=aqua|埃伦: — 我不知道你是如何说服莱昂和部落接受你的，但如果兽人选择了你，你一定有独特之处。

埃伦: — 我已经以你的名义派信使去莱昂了，所以他们应该朝着首都的方向前进。这很大胆，但有你在我们这边，我们应该能避免任何严重的后果。}""",
	ERLEN_LIRA_7_OPTION_1 = "我没有完全把握住目标，你在为什么而战？",
	ERLEN_LIRA_7_OPTION_2 = "很好，计划是什么？",
	ERLEN_LIRA_8_1_1 = """埃伦停顿了很长一段时间，整理自己的想法，然后终于开口了。

{color=aqua|埃伦: — 我不相信我们精灵作为一个国家的发展方式。近几十年来，男女之间的隔离比以往任何时候都快。大多数男性充其量被当作仆人，最坏的情况下被当作弃儿。弗雷娅的追随者不被允许与他们接触，我们之间经常存在敌意。

埃伦: — 海伦维尔非常赞成继续这项政策，但一位新的女祭司可能会推动真正的变革。给我们更多的呼吸空间和减轻摩擦的政策。这就是为什么我让你把里拉带到这里。}""",
	ERLEN_LIRA_8_1_2 = """{color=yellow|里拉: — 我-我很感激你对我的信任，但我仍然不确定能否承担这样的大事业。我被寺庙接纳只是出于善意。我甚至不是本地人，现在你提议我应该成为下一任女祭司？即使我对你有感情，这也有点太过分了...}

{color=aqua|埃伦: — 你自己的感受并不重要。如果弗雷娅认为你值得，那么你就可以这么做。我厌倦了这种状态，我愿意把一切都押在对你的信任上。 }""",
	ERLEN_LIRA_8_2 = """{color=aqua|埃伦: —考虑到我们目前的情况，我们只能做一件事。我们必须在仪式的最终阶段进攻。当你不在的时候，我已经准备好了一切。再等两天，然后来到精灵之都，莱昂也应该在那时到达。在那之前最好远离那里。}""",
	ERLEN_LIRA_8_OPTION_1 = "我希望你没有忘记我们的交易",
	ERLEN_LIRA_8_OPTION_2 = "我可能会要求更多的东西来应对这种风险",
	ERLEN_LIRA_9_1 = """{color=aqua|埃伦: — 如果我们成功了，你会得到我的任何帮助，无论是使用圣碗还是其他任何东西。} """,
	ERLEN_LIRA_9_2 = """{color=aqua|埃伦: — 我……可以向你承诺更多，但如果我们不能真正成功，这些承诺将是空洞的。我建议我们稍后再谈。}""",
	ERLEN_LEON_1 = """埃伦的团队已经与莱昂和您会面。

{color=aqua|埃伦: — 很感激你能来。}

{color=yellow|莱昂: — 嗯，所以当你需要我们的时候，你会礼貌一点。记住，我们来这里只是因为 [name], 我们会听从他的命令，而不是你的。 }

埃伦决定不理会莱昂的话，继续说下去。

{color=aqua|埃伦: — 我的线人报告说，他们今天要举行仪式。我们必须迅速行动，寺庙将在仪式开始前半个小时封闭。从那时起，任何人都不能离开或取消仪式。}""",
	ERLEN_LEON_1_OPTION_1 = """我们该怎么办?""",
	ERLEN_LEON_1_OPTION_2 = """那我们最好不要浪费时间聊天""",
	ERLEN_LEON_2 = """{color=aqua|埃伦: — 我们必须进攻。此时大多数士兵应该远离首都，但剩下的士兵都将被征召来保护仪式。}

{color=yellow|莱昂: — 听起来很简单。问题是什么？}

{color=aqua|埃伦: — 我们必须在仪式结束前让里拉进入寺庙。我将领导渗透。}""",
	ERLEN_LEON_3 = """当你们由埃伦带领着穿过后街时，你们设法避开任何巡逻。埃伦对首都了如指掌。你的队伍相当小，由精灵和兽人首领以及你的私人团队组成。当你靠近主寺庙时，你被迫从隐蔽的角落出来，穿过通往寺庙大门的桥。

然而，这座桥是有人把守的。当你的队伍被发现时，士兵们冲向你。埃伦走到他们面前。

{color=aqua|埃伦: — 放心，这些人是我的手下。 }

{color=yellow|卫兵: — 我很抱歉，指挥官，但我们接到了女祭司的指示，要阻止你。}

{color=aqua|埃伦: — 该死。我们必须战斗。}""",
	ERLEN_LEON_4 = """你成功地击败了巡逻队并过桥。然而，当你离门越来越近时，你发现一支更大的部队从后面向你靠近。 

{color=yellow|莱昂: — 你应该走了，否则你就永远走不到了。我们会阻止他们的。}

{color=aqua|埃伦: — 我的人也会留下来。快, [name], 剩下的时间很少了！}""",
	CEREMONY_1 = """仪式已经进行了一段时间，其中一名助手冲到海伦维尔那里，向她通报正在进行的袭击。她没有表现出任何情绪，只是下达了继续仪式的命令。她似乎认为卫兵应该能够将埃伦拖得足够长，让她完成计划。

海伦维尔也听说了一些关于兽人采取行动的消息，但她认为可以等到她继承高级女祭司的身份。""",
	CEREMONY_2 = """当你的团队闯入时，你意识到仪式已经启动。房间里充满了白光。你在最后一刻来到了这里。""",
	CEREMONY_3 = """有趣。很长一段时间以来都没有发生过这样的事情。一个外来者卷入精灵的事情是多么厚颜无耻。很好，你为什么不在这种情况下逗我开心呢？告诉我，你会选择谁成为下一任女祭司？""",
	CEREMONY_3_OPTION_1 = "海伦维尔",
	CEREMONY_3_OPTION_2 = "里拉",
	CEREMONY_HELEVIEL_1 = """当你说出你的答案时，白雾在你周围消散，你发现自己在寺庙的中央。看起来你是弗雷娅的真正信使，现在海伦维尔将再次成为女大祭司。

 — 你们自己都听到了。弗雷娅再次选择了我。即使仪式几乎中止。

 — 至于你, [name], 看来你一定是赢得了女神的青睐才成为她的使者，所以我们原谅你在这里。""",
	CEREMONY_HELEVIEL_2 = """海伦维尔转身面对埃伦和里拉，他们都被她的卫兵抓住了。

 — 至于这些入侵者，埃伦将因背叛我们国家对他作为军事指挥官的信任而被处决。

埃伦以一种失败的姿态垂下头，什么也没说。里拉试图抗议，但卫兵很快让她沉默。

 — 这位女祭司也被证明是叛徒，尽管我们的初衷是允许她像其他人一样为弗雷娅服务。她将为其他可能想偏离道路的人树立榜样。我想你应该很高兴有同样的信仰。""",
	CEREMONY_HELEVIEL_2_OPTION_1 = "我认为你太苛刻了，他们可以被赦免",
	CEREMONY_HELEVIEL_2_OPTION_2 = "这是你的选择",
	CEREMONY_HELEVIEL_3_1 = """ — 胡说八道。埃伦对我们来说显然太危险了，在他试图破坏仪式后，他不能活下去。我可以看到女祭司是他的工具，但在这之后，她也不能被信任。""",
	CEREMONY_HELEVIEL_3_1_OPTION_1 = "那时你至少可以流放她",
	CEREMONY_HELEVIEL_3_1_OPTION_2 = "把她给我",
	CEREMONY_HELEVIEL_3_1_OPTION_3 = "你说服了我",
	CEREMONY_HELEVIEL_3_1_1 = """海伦维尔稍作停顿，然后下决定。

 — 很好，她将永远被逐出我们的森林。感谢 [name] 给你生命的礼物。""",
	CEREMONY_HELEVIEL_3_1_2 = """海伦维尔因你的要求微笑。

 — 很好，只要你把她留在你的领域，你就可以拥有她。如果在我们的土地之外，我们不在乎她会做什么。""",
	CEREMONY_HELEVIEL_3_2 = """事情解决后，你出去向莱昂解释这一切都结束了。他接受了你的命令，与他带到这里的兽人战士一起撤退。当你回到海伦维尔时，她解决了问题，并邀请你到她的房间。""",
	CEREMONY_HELEVIEL_4 = """ — 我想我必须感谢你的参与。尽管你帮助埃伦试图从我手中夺取权力，但我最终还是成功了，我终于摆脱了他。我知道，你在等待你的神器，正如我所承诺的，你可以拥有它。毕竟，你是我认识的第一个被弗雷娅选中的外来者，所以我没有理由反对你。以圣碗为证，我相信这最终会符合弗雷娅的利益。

 — 哦，还有一件事我必须告诉你。看来你说的女恶魔确实在密谋什么。她如你所描述的那样出现了。""",
	CEREMONY_HELEVIEL_4_OPTION_1 = "很高兴与你一起工作",
	CEREMONY_HELEVIEL_4_OPTION_2 = "再见",
	CEREMONY_LIRA_1 = """当你说出你的答案时，白雾在你周围消散，你发现自己在寺庙的中央。看起来你真的是弗雷娅的信使，现在里拉将成为女祭司，而不是海伦维尔。

{color=yellow|海伦维尔: — 不-不可能。这不可能！}

{color=aqua|埃伦: — 你听到了。海伦维尔，你将因试图颠覆弗雷娅下一任女祭司的任务而被抓住。}

{color=yellow|海伦维尔: — 不，你们这些叛徒！这都是法术，你们不能这样对我！}""",
	CEREMONY_LIRA_2 = """守卫们听从埃伦和里拉的命令，将海伦维尔从神庙带走。你告诉莱昂战斗结束了，他和他的战士们撤退了，之后你再次与埃伦会面。""",
	CEREMONY_LIRA_3 = """ — 很难相信这真的发生了，但因为你，里拉现在是女祭司。正如我所承诺的，我授予你圣碗。这是我能回报你的最低限度。""",
	CEREMONY_LIRA_3_OPTION_1 = "海伦维尔呢？",
	CEREMONY_LIRA_3_OPTION_2 = "很高兴它为你成功了",
	CEREMONY_LIRA_4_1 = """ — 她很可能会被处决或永远与世隔绝。试图阻止弗雷娅的化身仪式是我们社会中最严重的罪行。""",
	CEREMONY_LIRA_4_1_OPTION_1 = "把她给我",
	CEREMONY_LIRA_4_1_OPTION_2 = "那由你决定",
	CEREMONY_LIRA_4_1_1 = """埃伦考虑了一下，点了点头。

 — 很好，虽然这个要求非常奇特，但你在这里为我们做了太多。你可以拥有她，只要她能作为奴隶度过余生。不过，我警告你，她不会合作的。""",
	CEREMONY_LIRA_4_1_1_OPTION = "谢谢你",
	CEREMONY_LIRA_4_2 = """ — 祝你旅途顺利。我们有很多工作要做，但很快我们会很高兴再次接待你。""",
	DEMON_PRIESTESS_1 = """弗雷娅的女祭司做完了她的事，去了她的私人房间休息，但这一次她发现自己并不孤单。

{color=yellow|最高女祭司: — 所以，确实发生了一些见不得人的事情。 }

{color=aqua|女恶魔: — 太不愉快了。我只想提供一些合作。}""",
	DEMON_PRIESTESS_2 = """{color=yellow|最高女祭司: — 厚颜无耻。这里没有人会和你合作。}

{color=aqua|女恶魔: — 你现在真的应该这么不屑一顾吗？即使是你的身份也无法使你免受即将发生的事情的影响。 }

{color=yellow|最高女祭司: — 我不知道你是怎么进来的，但在我叫警卫之前，这是你最后一次离开的机会。}

{color=aqua|女恶魔: — 哼，就这样吧。如果你过几天悔不当初的话，不要爬到我身边。}""",
	DEMON_PRIESTESS_3 = """当恶魔带着传送魔法消失时，大女祭司叹了一口气，坐在床上回忆起她为保住自己的位置所面临的困难。""",
	
	
	JEAN_INTRO = """当你正要进入时，你听到门的另一边传来一个陌生的女声，听起来相当激动。

{color=yellow|不熟悉的声音: — 意思是一个人没有工作？！}

{color=aqua|梅尔: — 我说了什么。你以前的同伴怎么了？}

{color=yellow|不熟悉的声音: — 谁在乎，反正我现在自由了！}""",
	JEAN_INTRO_1 = """你进入房间并看到一个年轻的人类女孩，她用犀利的目光打量着你。

{color=aqua|梅尔: — 喔，你来了, [name]。时机很好。你为什么不带上这个为真正的工作而死的了不起的女巫？ }

从梅尔面无表情的声音里，你看不出她是认真的还是不认真的。""",
	JEAN_INTRO_2 = """{color=yellow|女孩: — 你是新的土地所有者。你凭什么认为我会为你工作！？ }

{color=aqua|梅尔: — 你别无选择，吉恩，你的宿舍费到期了。}

{color=yellow|女孩: — 啧...}

{color=aqua|梅尔: — 正如你所看到的，她的脾气很糟糕，但她是我见过的最熟练的学生之一。请多多关照。}""",
	JEAN_INTRO_2_OPTION_1 = "我想我还有一些可用房间",
	JEAN_INTRO_2_OPTION_2 = "不行",
	JEAN_INTRO_BAD = """{color=aqua|梅尔: — 该死……那给我更多的时间。}

你离开房间，等他们说完。""",
	JEAN_INTRO_3 = """{color=yellow|吉恩: — 嘿，你凭什么认为没有我的同意你能做决定？ }

{color=aqua|梅尔: — 太好了。我相信 [he]会有适合你的工作。也许你也会找到一个男人，不再那么令人头疼了。再见。}

{color=yellow|吉恩: — 等等，我还没说完！}

在吉恩抗议之前，强大的魔法力量已经把你们两个赶出了梅尔的办公室。""",
	JEAN_INTRO_4 = """ — 该死的那个巫婆！..见鬼... 

意识到自己处境的绝望，吉恩终于承认了你的存在，转身面对你。

 — 好吧，我想很高兴见到你。你一定有工作给我，对吧？你可以猜到我不擅长做家务，所以我希望你不要整天无所事事。""",
	JEAN_INTRO_4_OPTION_1 = "我经常打架",
	JEAN_INTRO_4_OPTION_2 = "你似乎不太经常与人交谈 ",
	JEAN_INTRO_4_OPTION_3 = "不，但我不介意时不时坐在你屁股上",
	JEAN_INTRO_5_1 = """ — 嗯，那太好了。好吧，给我指一下我睡觉的方向，我们可以在那里见面。

你把去你家的路告诉吉恩，让她自己去。""",
	JEAN_INTRO_5_2 = """ — 随便。好吧，给我指一下我睡觉的方向，我们可以在那里见面。

你把去你家的路告诉吉恩，让她自己去。""",
	JEAN_INTRO_5_3 = """吉恩脸红得厉害，扇你的脸，声音太大了，你想知道梅尔是否会从她的办公室出来看看你。 

 — 这就是你在想的？色狼！你最好记住，我不会做任何你梦想中的'服务'！现在告诉我从现在起我睡在哪里，然后滚开。

你把去你家的路告诉吉恩，让她自己去。""",


	LILIA_INTRO = """当你穿过村庄时，偶尔会有精灵和仙精在观察你，你会注意到大多数居民都非常谨慎，一旦你朝他们的方向看去，他们就会转身离开。也就是说，除了一个非常好奇的红长发精灵。当她意识到自己引起了你的注意后，她冲向你，完全无视任何安全距离。

 — 嗨！我是莉莉娅。你叫什么名字？你是个冒险家吗？你太大了！我们这里很少有像你这样的人。是什么把你带到这里来的？""",
	LILIA_INTRO_OPTION_1 = "很高兴认识你，我是 [name].",
	LILIA_INTRO_OPTION_2 = "哇，我们没这么熟",
	LILIA_INTRO_OPTION_3 = "你真的不懂礼貌，是吗?",
	LILIA_INTRO_2 = """ — 啊，对不起，能遇到像你这样的人真是太令人兴奋了，太难得了。你看起来又大又强壮，让我感到非常兴奋*咯咯笑*

 — 我可以和你一起去冒险吗？求你了？ """,
	LILIA_INTRO_2_OPTION_1 = "同意",
	LILIA_INTRO_2_OPTION_2 = "拒绝",
	LILIA_INTRO_3_1 = " — 谢谢！我还挺期待新家的。",
	LILIA_INTRO_3_2 = " — 哇……如果你改变主意，请告诉我！",
	
	CALI_INTRO = """当你穿过堡垒时，你发现一些奴隶贩子发来的一张短信，他们似乎与当地土匪有联系。他在附近有一个用作安全屋的小洞穴，并描述了奴隶贩子是如何被迫暂时留在那里的。你把这些信息记下来，然后继续前行。""",
	CALI_INTRO_1 = """你遇到一小群向你打招呼的奴隶贩子。

{color=aqua|奴隶贩子: — 嘿，看来我们有客人了。我们不想打架，实际上我们想扔掉一些剩下的商品，来看看吧。你看起来像个受人尊敬的绅士。 }

奴隶贩子把你带到另一个房间。""",
	CALI_INTRO_2 = """你看到一个年轻的女孩躺在地板上。她的耳朵和尾巴暴露了她其实是混血狼人。尽管被束缚，她的精神似乎还没有崩溃。

{color=yellow|奴隶贩子: — 叫萨利，或者类似的名字。}

{color=aqua|女孩: — 是卡莉！我是骄傲的狼族，如果不是因为这些绳子，我会踢烂你的屁股！}

{color=yellow|奴隶贩子: — 这小混蛋就是不肯闭嘴。我们为什么不再管教她一次？

奴隶贩子 2: — 打残了就卖不出好价钱了。我现在懒得管她，你去堵住她的嘴}""",
	CALI_INTRO_2_OPTION_1 = "她还是处女吗?",
	CALI_INTRO_2_OPTION_2 = "你在哪里找到她的?",
	CALI_INTRO_2_OPTION_3 = "我想买她",
	CALI_INTRO_2_OPTION_4 = "我要把她从你身边带走", # 战斗
	CALI_INTRO_3_1 = """女孩的脸被你的问题弄得通红。

{color=aqua|卡莉: — 我当然是！你们这些变态，打算干什么！？滚！}

男人们对她的反应哈哈大笑。

{color=yellow|奴隶贩子: — 嗯，她就是这么说的。}""",
	CALI_INTRO_3_2 = """{color=yellow|奴隶贩子: — 她独自一人在危险的道路上流浪。看起来她离家出走了。 }""",
	CALI_INTRO_3_3 = """首领抚摸着下巴思考几秒钟。

{color=yellow|奴隶贩子: — 我就知道我们可以和你建立一种富有成效的关系, [Sir]。一旦我们出发，把她留在身边会很烦人，所以我们会很高兴地在这里和她分开。}

{color=aqua|卡莉: — 混蛋，别再像我同意的那样讨论我了！}

{color=yellow|奴隶贩子: — 考虑到她健康的体格和外表，我相信她至少值1000金币。}""",
	CALI_INTRO_3_OPTION_1 = "她在我看来并不那么漂亮（魅力检定）",
	CALI_INTRO_3_OPTION_2 = "我会考虑的",
	CALI_INTRO_3_OPTION_3 = "成交",
	CALI_INTRO_3_OPTION_4 = "算了，我更倾向于从你们手里抢走她",
	CALI_INTRO_4_1_1 = """{color=aqua|卡莉: — 我TM不在乎！}

{color=yellow|奴隶贩子: — 我想一千可能太多了，但我们不能把价格降到低于750金币的水平。你必须支付她活着和安全的费用。 }

{color=aqua|卡莉: — 你在这里用猪食喂我！}""",
	CALI_INTRO_4_1_2 = """{color=aqua|卡莉: — 你以为我在乎吗!}

{color=yellow|奴隶贩子: — 即便如此，你也必须支付她活着和安全的费用。 }

{color=aqua|卡莉: — 你在这里用猪食喂我!}""",
	CALI_INTRO_4_2 = """{color=yellow|奴隶贩子: — 好吧，但不要花太长时间。等你下定决心的时候，她可能会有新客户。呵-呵。}""",
	CALI_INTRO_4_3 = """当你把钱递给奴隶贩子并让他们离开洞穴时，奴隶贩子笑了。你转向安静的卡莉。""",
	CALI_INTRO_4_4 = """{color=yellow|奴隶贩子: — 哦，是这样吗？你可以试试！}""",
	GOT_CALI_1_1 = """被绑的狼女坐在你面前，带着反抗和一丝恐惧抬头看着你。

 — 那么？你现在打算怎么处置我？""",
	GOT_CALI_1_2 = """被束缚的狼女静静地坐在你面前。她沉着的表情流露出一丝恐惧和好奇，她正试图将它们隐藏起来。

 — 你-你在看什么？你打算怎么处置我？ """,
	GOT_CALI_1_OPTION_1 = "*强奸她*",
	GOT_CALI_1_OPTION_2 = "我来解放你",
	GOT_CALI_2_1 = """你认为再聊下去真的没有意义了，你应该在这里品尝你的新收获。 """,
	FORCE_CALI_1 = """令卡莉震惊的是，你把她平放在地上，站在她身上。她的双手被绑在背后，膝盖紧紧地绑在一起，这个混血狼女几乎无法抵抗你的超强力量。

她试图扭动身体，痛苦地哭泣，但你很容易抓住她的尾巴，把她固定住。她的短裙搭起来，露出她可爱的圆屁股。卡利疯狂地扭动着身体，当你把她的裙子推到她的腰上，看着她无助的身体时，她竭尽全力抵抗你。但她被牢牢地束缚着，她的挣扎只会耗尽她自己的力气。""",
	FORCE_CALI_2 = """将被束缚的卡莉紧紧地压在地上，你的手探索她柔软脆弱的屁股。

 — 你-你在干什么！住手，你这个混蛋！

抓住卡莉丝袜的透明织物，你用力拉，把它们撕开，以便更好地看到她的白色棉质内裤。

 — 怪物！你会后悔的！

你轻轻地笑着，用手指抚摸着她的内裤，沿着她大腿之间柔软的缝隙。当你的指尖在织物中粗暴地戳着卡莉的阴蒂时，卡利不寒而栗。

 — 不-不！请不要这样做！我不是...我从来没有...

你把她的内裤裆部拉到一边，露出卡莉的粉红色紧致阴部。 """,
	FORCE_CALI_3 = """混血狼女的阴部暴露在外，她的语气发生了变化，她开始拼命地和你讨价还价。

 — 求你了, [sir], 我可以为你提供一些东西！你想要什么？我不介意当仆人，我只是...请停止...喔喔喔喔！

你开始用手指挑逗卡莉的阴蒂，让拇指逐渐在阴唇之间滑动，直到它压在她的处女膜上。没过多久，她的阴部就开始变得温暖起来，她的阴唇随着她不由自主的觉醒而变得光滑。卡莉用力抓住绑着她的绳子，扭动着她的上半身，她的大腿无助地扭在你试探的手指上。她那结实的小屁股颤抖着，因为她纤细的双腿紧紧地夹在一起。用你的另一只手，强迫她的腿在臀部弯曲，然后解开你的皮带。

 — 不-不，求你了！啊！请, [sir], 请停下! """,
	FORCE_CALI_4 = """女孩被束缚的双腿弯曲，你把手紧紧地抓在她的背部，把她钉在冰冷的地面上。你可以看到，当她被迫躺下时，她的小乳头上的硬乳头顶起了衬衫的布料。她的屁股和阴部伸到空中，你的手抚摸着它们，准备让她成为一个女人。

 — 天啊，不！不要这么做！我不想要！我还没准备好！

但卡莉那的潮湿的缝隙讲述了一个不同的观点，在没有进一步爱抚的情况下，你无视她的呜呜声，拔出你僵硬的阴茎，把它扎进她脆弱的阴部，刺穿她的处女膜。

 — AAAAaaiiieeehhh!

卡莉紧紧地闭上了眼睛，好像她可以不看就让它停下来，但你一直在她身上倾泻欲望，你的阴茎在她敏感的处女阴道里艰难而深入地挣扎。

 — 你-你这个混蛋! 我永远 — 不会原谅你!

狼女孩闭着眼睛哭泣，你的阴茎扎进她那令人耳目一新的紧致阴部，她流下了滚烫的泪水。""",
	FORCE_CALI_5 = """感觉到进一步抵抗的徒劳，卡莉的挣扎变得越来越弱。当你的阴茎有节奏地撞向她时，她的哭声开始改变。当你慢慢地把你的整个阴茎都压进她的阴部，你的睾丸靠在她肿胀的阴蒂上时，她会喘着粗气。她的紧张情绪有点缓和，当她的阴部在你的阴茎上跳动和颤抖时，她发出刺耳的叹息。

当你把你的阴茎一寸一寸地从卡利身上拔出来时，卡莉的眼睛睁开了一半。当你推倒并再次刺穿她时，她无法抑制一声轻柔的呻吟，当你用坚硬的肉填满她时，你的阴茎将她的处女小穴拉到了极限。

 — 啊！噢！请你不要伤害我！

女孩看着你，当你在她身上进进出出时，她紧紧地盯着你。她不再反抗她的束缚，而是拱起她的背，在你操她的时候帮你扶着她的屁股。

当你再次加快速度时，你会感觉到卡莉遍体鳞伤的阴部开始收紧并抓住你的阴茎，当你感觉到高潮很快就要到来时，活塞运动越来越快。 """,
	FORCE_CALI_6 = """抓住卡莉狭窄的臀部，当年轻的狼女徒劳地试图控制自己的非自愿反应时，你用新的活力操了她。

 — 啊！不，求你了，我... 我-

当一种不情愿的高潮掠过她的脸，摇晃着她的整个身体时，新鲜的泪水划过她的脸。你把手指伸进她屁股上结实的肌肉里，用力抓住她，把她弄得遍体鳞伤，用力拍打她无助的阴部，直到她痛苦地尖叫。

 — 啊！不要射进来！我求你了！

过了一会儿，你的精液深深地射入她扭动的身体，让她幼小的阴部充满了你滚烫的粘性种子。卡莉哭了，当从她的洞里流出的精液与她失去童贞时的血液混合在一起时，她放声大哭。

你花一分钟的时间来品味你对女孩的暴力，然后在她裸露的屁股上快速拍打一下，你就退出了。

卡利躺在那里一两分钟，当精液滴到大腿上时，她抽泣着。然后你把她抱起来，把她扔到你肩上。满足于你已经建立了对狼女的权威，你带着你新获得的玩具回到了豪宅。""",
	GOT_CALI_2_2 = """当你把狼女从束缚中解脱出来，扶她站起来时，狼女难以置信地看着你。尽管她肌肉麻木，身材矮小，但她的活泼令人羡慕。 

 — 呃-嗯，我想谢谢你。我很高兴你不像那些卑鄙小人。 

她停顿了很长一段时间，揉了揉疼痛的手腕，才愿意继续。

 — 那个... 我想你是个大人物吧？现在我真的无处可去。也许我可以为你做点工作？你看起来像个好人。""",
	GOT_CALI_2_OPTION_1 = "你能做什么样的工作？",
	GOT_CALI_2_OPTION_2 = "好啊",
	GOT_CALI_2_OPTION_3 = "不感兴趣",
	GOT_CALI_3_1 = """ — 我可能看起来不像，但我很坚强，毕竟我是狼。

卡莉骄傲地鼓起胸脯。

 — 我可以做一些琐碎的工作，或者我可以掩护你。但我宁愿什么都不做，你知道，下流...""",
	GOT_CALI_3_2 = """ — 太好了！我保证我会尽力的。

你离开山洞，带卡利回到你的豪宅。""",
	GOT_CALI_3_3 = """— 啊-啊……好吧，我想我该离开了。
	
卡莉看起来出乎意料地失望，但她决定离开。""",
	
	CALI_SIDEQUEST_1 = """中午，你的一位客人：卡莉走近你。她看着你，脸上有点担心。

— 嘿, [name]。你知道，我已经在这里住了一阵子了。我在想做一件大事。""",
	CALI_SIDEQUEST_1_OPTION_1 = "这是一种令人钦佩的态度",
	CALI_SIDEQUEST_1_OPTION_2 = "你仍需从小处着手",
	CALI_SIDEQUEST_1_OPTION_3 = "你不必担心这个，你想呆多久就呆多久",
	CALI_SIDEQUEST_1_1 = """— 哼，不需要奉承，这是一只骄傲的狼应该做的——而不仅仅是依靠别人的善意。 """,
	CALI_SIDEQUEST_1_2 = """— 你……这没错。但我还是得这么做。""",
	CALI_SIDEQUEST_1_3 = """— 不，不，这是错误的。我必须尽我所能，也要回报你。""",
	CALI_SIDEQUEST_1_ADDITIONAL = """

— 所以，我听说过这里的那些行会。我敢打赌，如果我加入其中，它会帮助我变得更强大。你一定对此有所了解，对吧？你认为哪一个更适合我？""",
	CALI_SIDEQUEST_2_OPTION_1 = "战士行会非常适合你",
	CALI_SIDEQUEST_2_OPTION_2 = "也许你可以在法师行会学一些魔法？",
	CALI_SIDEQUEST_2_OPTION_3 = "您可以加入工人行会进行一些踏实的劳动",
	CALI_SIDEQUEST_2_OPTION_4 = "仆人可能非常适合女孩",
	CALI_SIDEQUEST_3_1 = """— 嗯...是的，我喜欢！作为一名冒险家，与坏人和怪物战斗。 

— 所以，你认为我可以去那里成为一名战士吗？如果我变得更强壮，我也会对你更有用，对吧？让我们去那里！""",
	CALI_SIDEQUEST_2_2 = """— 不，我讨厌学习，我听说你要成为一名法师需要做很多事情。这真的不适合我，你觉得呢？""",
	CALI_SIDEQUEST_2_3 = """— 啊，无聊。我宁愿做一些更积极的事情。""",
	CALI_SIDEQUEST_2_4 = """— 哦，得了吧，你说话就像我妈妈一样！我可能是个女孩，但我不太擅长那种女孩味的东西。一定有更好的东西。""",
	CALI_FIGHTERS_INIT_OPTION = "卡莉",
	CALI_FIGHTERS_1 = """当你和卡莉一起走进公会时，她敬畏地环顾四周。在适应了周围的环境几秒钟后，你找到了登记处，然后走向它。当狼女开始热情地要求她登记时，接待员看起来并没有那么有活力。

{color=yellow|接待员: — 你看起来很年轻，没有经验。你要知道，这不是游乐场。}

{color=aqua|卡莉: — 嘿-嘿，我知道！如果我没有经验怎么办？} 

{color=yellow|接待员: — 我们不能保证您的安全。至少要带上您的法定监护人。}

{color=aqua|卡莉: — 呃-嗯……那么， [him]怎么样?! [He]是我的...}

卡莉不安地看着你。""",
	CALI_FIGHTERS_1_OPTION_1 = "[Master]",
	CALI_FIGHTERS_1_OPTION_2F = "父亲",
	CALI_FIGHTERS_1_OPTION_2M = "母亲",
	CALI_FIGHTERS_1_OPTION_2SF = "继父",
	CALI_FIGHTERS_1_OPTION_2SM = "继母",
	CALI_FIGHTERS_1_OPTION_3 = "只是朋友",
	CALI_FIGHTERS_2_1AND3 = "{color=aqua|卡莉: — 就这样！如果 [he] 允许，那就好了，对吧？}",
	CALI_FIGHTERS_2_2 = """卡莉看起来对你的说法有点不安，但很快意识到她必须配合。

{color=aqua|卡莉: — 是-是的，没问题，对吧？}""",
	CALI_FIGHTERS_2_ADDITIONAL = """

接待员疲惫地看了你一眼，但决定放行。

{color=yellow|接待员: — 好吧。你是地主，所以我想出事了我们可以追究你的责任。 }

{color=aqua|卡莉: — 好耶!.. — 卡莉听到后差点跳起来}

{color=yellow|接待员: — 然而，正如我所说，这不是一个游乐场。在你成为会员之前，将对你进行一次测试，以证明你的能力。}""",
	CALI_FIGHTERS_3 = """接待员打乱了桌子上的文件，直到找到其中一个请求。

{color=yellow|接待员: — 给。这是战士行会成员的一项简单任务。一群哥布林一直在袭击当地的一个村庄。如果你能把他们赶走，你就会被接受。}

卡莉热情地接过纸条，转向你。

{color=aqua|卡莉: — 太简单了。愚蠢的小哥布林还能做什么？我们会在晚上之前把他们干掉。我们走吧！}""",
	CALI_FIGHTERS_3_OPTION_1 = "当然，就在你身后",
	CALI_FIGHTERS_3_OPTION_2 = "小心为妙",
	CALI_FIGHTERS_4 = """你和卡莉走出战士行会，观察地图上所需的位置。""",
	CALI_GOBLINS_NO_CALI = """你认为不带卡莉参加这个任务是不明智的。""",
	CALI_GOBLINS_1 = """精神饱满的卡莉迅速跑到村庄，了解了袭击者的位置。又过了二十分钟，你走近了一个似乎是小森林营地的地方，那里有几个哥布林观察员，他们还没有发现你。然而，尽管你尽了最大努力不惊动他们，卡莉还是鲁莽地从灌木丛中走了出来，迅速引起了敌人的注意。 

随着多个哥布林从营地出来，现在别无选择，只能与他们战斗。""",
	CALI_GOBLINS_2 = """当你击败众多的哥布林时，你会注意到后面的一些哥布林是如何开始向营地深处逃跑的。似乎玩得很开心的卡莉也注意到了这一点，在你阻止她之前，就向他们冲去。 """,
	CALI_GOBLINS_3 = """当狼女追赶哥布林时，她没有发现树叶下的陷阱。当她绊倒陷阱时，几个哥布林从后面跃起，其中一个成功地抓住了她的背。 

— 放开我！...现在

当她挣扎着把哥布林从身上弄下来时，更多的哥布林慢慢靠近，包围了卡利，卡利最终挣脱了束缚。

— 喔, 哦... [name]... 你在哪里..?

意识到自己的处境，卡莉看起来很害怕，但还没有试图逃跑。

你已经离她很近了，但你的决定是...""",
	CALI_GOBLINS_3_OPTION_1 = "冲进去救她",
	CALI_GOBLINS_3_OPTION_2 = "让她来处理",
	CALI_GOBLINS_4_1 = """你勇敢地冲了进去，把卡莉从危险中拖了出来。然而，在她还没来得及感谢你的时候，更多的哥布林就进来了，你必须战斗。""",
	CALI_GOBLINS_4_2 = """你决定留下来给卡莉一个教训。别无选择，她不得不在一个不公平的场景中战斗。

当你击倒几个落单的哥布林后，你注意到卡莉在反击和保持距离的同时，似乎受到了一些伤害，如果没有你的帮助，可能无法成功。你认为是时候帮她了。""",
	CALI_GOBLINS_5 = """当你最终设法让其他哥布林在恐怖中逃离时，你和卡莉屏住呼吸，她向你说话。

— 对不起...我不该漫不经心地追着他们跑。谢谢你帮我。""",
	CALI_GOBLINS_5_OPTION_1 = "你要吸取教训",
	CALI_GOBLINS_5_OPTION_2 = "下次未经我允许，请勿采取行动",
	CALI_GOBLINS_5_OPTION_3 = "如果你再这样做，如果再发生这种情况，我会把你留给他们",
	CALI_GOBLINS_6_1 = """— 是的！最后我们成功了，对吧？

卡莉似乎对你的话松了一口气，当你回到村庄时，她抓住了你的手。""",
	CALI_GOBLINS_6_2AND3 = """— 对不起……我保证下次会更加小心。

当你回到村庄时，卡莉似乎对你的话有些不安""",
	CALI_GOBLINS_7 = """你向村里的长老报告了你的成功，并成功完成了任务。卡莉似乎对结果很满意。

— 我们做得很好。谢谢你帮我解决这个问题。""",
	CALI_GOBLINS_7_OPTION_1 = "你也做得很好",
	CALI_GOBLINS_7_OPTION_2 = "那只是一群哥布林，没什么大不了的",
	CALI_GOBLINS_7_OPTION_3 = "你确定这是你想做的吗?",
	CALI_GOBLINS_8_1 = """— 哈哈，你这么认为？我相信我们未来的冒险会更好!""",
	CALI_GOBLINS_8_2 = """— 也许对你来说是这样的，但这是我第一次感到非常刺激。""",
	CALI_GOBLINS_8_3 = """— 当然！这只是开始。""",
	CALI_GOBLINS_8_ADDITIONAL = """

无论如何, 卡莉有了一个好的开始，你们回家了""",
	CALI_SEX_1_1 = """当你晚上穿过豪宅时，你发现一扇微微打开的门通向你最近招募的一个混血狼人女孩——卡莉。当你听到那里传来一些噪音时，你决定看一眼。

你可以看到卡莉光着屁股躺在床上，双腿伸开，温柔地探索着她发痒的胯部，轻声呼吸。 """,
	CALI_SEX_1_2 = """— 我感觉很奇怪……想起 [him]...

当她转向你时，她意识到你已经看着她一段时间了。她的脸涨得通红，不知道该怎么反应。

— [Master]?! 这呃...""",
	CALI_SEX_1_OPTION_1 = "感觉不错，是吧?",
	CALI_SEX_1_OPTION_2 = "下次应该锁门",
	CALI_SEX_1_OPTION_3 = "*悄悄离开*",
	CALI_SEX_2_3 = """您决定忽略她并把门关上...""",
	CALI_SEX_2_3_OPTION_1 = "现在不是时候...",
	CALI_SEX_2_3_OPTION_2 = "我宁愿一点也不。",
	CALI_SEX_2_1AND2 = """看到你的反应，卡莉放松了一点，但仍然遮住了她的私处。

— 我...嗯…现在不知道该说什么。""",
	CALI_SEX_2_1AND2_OPTION_1 = "我希望看到你继续",
	CALI_SEX_2_1AND2_OPTION_2 = "不介意我看吗？",
	CALI_SEX_3_1 = """卡莉停顿了一下，但她的欲望占据了上风，她不再掩饰自己，再次向你露出了她的阴部。

— 你是个变态，主人。

当她的手开始摩擦阴蒂时，她开始使用顽皮的语气。

— 但是...我并不讨厌你看着我...""",
	CALI_SEX_3_2 = """当她的声音变得越来越热情时，她会盯着你和你的隆起部位看，但不会做任何更激进的事情。不到一分钟，她的声音就变高了，当她达到高潮时，她的身体抽搐，抚摸着自己。当她疲惫而安逸地躺在床上时，她的脸上充满了笑容。她开始裹毯子后不久

— 哇...我以前从未有过这种感觉。""",
	CALI_SEX_3_OPTION_1 = "演出很棒",
	CALI_SEX_3_OPTION_2 = "你不想让我帮忙吗?",
	
	CALI_SEX_4_1 = """— 是-是的，那有点疯狂。对不起，我想单独呆一会儿。""",
	CALI_SEX_4_2 = """— 是的，对不起，也许改天吧。我想休息一下。""",
	CALI_SEX_4_ADDITIONAL = """

卡莉确保你意识到是时候离开了，然后关上门。""",
	CALI_FIGHTERS_FINISH_OPTION = "卡莉的工作",
	CALI_SIDEQUEST_4 = """卡莉向接待员报告完成情况，接待员似乎对此持怀疑态度。

{color=aqua|卡莉: — 我们做到了，所以现在我是正式会员了，对吧？}

{color=yellow|接待员: — 我想你得到了帮助？}

{color=aqua|卡莉: — 啥-不? 我和一位受人尊敬的冒险家一起工作过。此外，这并不违反规则，是吗？} """,
	CALI_SIDEQUEST_5 = """接待员决定不再争论，并在合同完成后盖章。卡莉向您展示盖章的纸张。

{color=aqua|卡莉: — 看到了吗？我不再是流浪者了！我是哥布林杀手卡莉！} """,
	CALI_SIDEQUEST_5_OPTION_1 = "干得好，我为你感到高兴。",
	CALI_SIDEQUEST_5_OPTION_2 = "哦？计划把我们这些凡人抛在身后，开始一场盛大的冒险吗？",
	CALI_SIDEQUEST_6_1 = "{color=aqua|卡莉: — 嘿，没有你我做不到。谢谢, [name]。我希望我们还有更多的冒险。}",
	CALI_SIDEQUEST_6_2 = "{color=aqua|卡莉: — 别傻了，我还欠你一大笔债？我觉得在你的团队里还有更多的冒险。}",
	CALI_SIDEQUEST_7 = """一天早上，你遇到了卡莉。虽然平时她充满了欢乐，训练场里一片混乱，但现在这个女孩看起来正站在大厅里安静地沉思。她似乎在自言自语，大声解决了一些问题，然后低头看了看自己的衣服，叹了一口气，摇了摇头，她的眼睛显然在担心什么。

看见你出现，女孩立即走向你，当她不好意思地看着你时，她的正常举止消失了。

— 喔, [Master]... 很抱歉嗯，我能问你点什么吗？你认为我有女人味吗？我的意思是我是一个女孩，但是，女人味我不太确定。""",
	CALI_SIDEQUEST_7_OPTION_1 = "你已经足够女性化了。",
	CALI_SIDEQUEST_7_OPTION_2 = "好吧, 确实不太够",
	CALI_SIDEQUEST_7_OPTION_3 = "很重要吗?",
	CALI_SIDEQUEST_8_1 = """当你说话时，她的耳朵会随着你的反应而下垂。

— 嘿，怎么了？你是想安慰我吗？我在这里问你一个严肃的问题 [master].""",
	CALI_SIDEQUEST_8_2 = "卡莉: — 是的，我想是的。谢谢你的诚实。",
	CALI_SIDEQUEST_8 = "— 我是个女孩，你知道。很多人都提到我不是很有女孩气，最近我很受欢迎。我知道我通常表现得不像大多数女孩，我很活跃，喜欢游戏和冒险的东西。我不知道该怎么办...",
	CALI_SIDEQUEST_8_OPTION_1 = "如果你想，你可以学会变得更女性化",
	CALI_SIDEQUEST_8_OPTION_2 = "我不介意你表现得像个假小子。",
	CALI_SIDEQUEST_8_OPTION_2_alt = "你应该尝试更多‘男子汉’的东西来提升你的理智 ",
	CALI_SIDEQUEST_9_1 = """— 你这么认为…？我想我想。呃，我从来都不擅长连衣裙和礼仪之类的东西。我想，也许是时候试试了。据我所知，这可能很有趣。

经过思考，你决定去仆人行会寻求一些让卡莉更女性化的想法可能是个好主意。""",
	CALI_SIDEQUEST_9_2 = """— 你-你真的这么认为吗？我的意思是，我想我很想，但我从来没有真正擅长过这种东西。尽管对你来说，我觉得我可以试试。

经过思考，你决定去仆人行会寻求一些让卡莉更女性化的想法可能是个好主意。""",
	CALI_SIDEQUEST_9_2_alt = """— 嗯，如果你这么说，我会相信你的。不过，我不知道从哪里开始。你有什么想法吗？

经过思考，你决定去工人行会寻求一些想法可能是个好主意。""", #currentlyis meaningless due to no workers root
	CALI_SERVANTS_START_OPTION = "关于卡莉的女性礼仪培训",
	CALI_SERVANTS_1 = """你向周围的行会助手询问，他们会指导进行女性仆人的一般培训。缝纫、烹饪和礼仪的基本技能对任何女孩来说都是一个很好的起点。

带着一丝怀疑，卡莉同意尝试这些活动。

— 嗯，我不确定我是否擅长这些东西...""",
	CALI_SERVANTS_1_OPTION_1 = "别担心，你可以做到",
	CALI_SERVANTS_1_OPTION_2 = "一切都有第一次，只有尝试才能知道",
	CALI_SERVANTS_1_OPTION_3 = "我们一开始就不应该气馁",
	CALI_SERVANTS_2 = """— 好吧，好吧，我来试试。

在与助手们讨论后，向您解释了女仆的一般培训，首先是了解最有才华的方面，打扮、签名和语言礼仪。卡莉同意尝试一下。""",
	CALI_SERVANTS_3 = """当卡莉正在试穿一件新的长裙时，她穿起来似乎不是特别舒服，也不适合她的五官。尽管如此，她仍然在上礼仪课，这让她在精神上很疲惫。 """,
	CALI_SERVANTS_4 = """当她休息时，卡莉发现一只小猫在后院移动。她忘记了一切规范，试图冲向它，但由于着装原因绊倒了。

— 哦…哎哟…砰！

她也忘了注意自己的舌头，意识到自己的裙子因为摔倒而撕破了。遗憾的是，你必须为此付出代价。你决定到此为止，让狼女反回。""",
	CALI_SERVANTS_5 = """当卡莉回到你身边时，她看起来很抱歉。

— 对不起，出于某种原因，我很难表现得像普通女孩。不得不穿成这样真是令人沮丧...也许我应该忘记这件事。 """,
	CALI_SERVANTS_5_OPTION_1 = "你还不应该放弃",
	CALI_SERVANTS_5_OPTION_2 = "也许这根本不适合你",
	CALI_SERVANTS_6 = """{color=yellow|阿米莉亚: — 我看到你的训练了，卡莉是吗？很高兴见到你。}

{color=aqua|卡莉: — 你好……你是谁？}

{color=yellow|阿米莉亚: — 把我看作一个谦逊的，愿意给你建议的人吧。很抱歉，我的耳朵似乎窃听了你们的谈话，但事实上，我认为你采取了一个稍微错误的方法。}

{color=aqua|卡莉: — 你是什么意思?}""",
	CALI_SERVANTS_7 = """{color=yellow|阿米莉亚: — 你是个女孩，你想看起来更像一个女人，对吗？然而，正如你所注意到的，你和其他女孩不太一样。}

卡莉听到这些后在精神上感到气馁，但阿米莉亚并没有就此打住。

{color=yellow|阿米莉亚: — 但这并不意味着你应该放弃。如果有些事情对你不起作用，其他事情可能会。}

{color=aqua|卡莉: — 我不明白你的意思。}

{color=yellow|阿米莉亚: — 你介意我来试试吗？这不会花你任何钱。如果我的方法让你们不满意，你可以说。}""",
	CALI_SERVANTS_8 = """过了一会儿，卡莉同意了，阿米莉亚把她从你身边带走。当你等了大约半个小时时，卡莉再次出现在你面前，看起来心情比她离开时好多了。你不太清楚她发生了什么变化，但不知怎的，当她向你靠近时，她抓住了你潜意识的注意力。

{color=aqua|卡莉: — [Master]! 很抱歉耽误时间...}

当她观察到你的反应时，她开始露出更甜美的微笑。 """,
	CALI_SERVANTS_8_OPTION_1 = "你看起来很漂亮",
	CALI_SERVANTS_8_OPTION_2 = "怎么了?",
	CALI_SERVANTS_8_OPTION_3 = "你看起来有些不太一样",
	CALI_SERVANTS_9 = """{color=yellow|阿米莉亚: — 呵呵，你现在注意到了吗？你不需要换一身完整的衣服或化一个完整的妆来强调你的美。一些姿势和表情训练对你来说看起来更自然。好吧，这和一些小女人的秘密。}

你注意到卡莉现在是如何尊敬地看着阿米莉亚的。最后，在结果的鼓舞下，卡莉同意偶尔拜访阿米莉亚并向她学习。当她走到外面时，阿米莉亚和你说话。

{color=yellow|阿米莉亚: — 她是个好女孩，你最好不要辜负她对你的信任。}

没有等你的答复，她消失在视线中，就像她出现时一样迅速。 \n\n{color=green|卡莉: 魅力因素 +1\n卡莉:魅力 +10}""",
	CALI_SEX_5 = """快到中午了，你在大厅里全神贯注于这样或那样的事物。卡莉大步走到你面前，脚步中的规律在她出现之前很久就暴露了她。她在离你不远的地方停了下来，聚精会神地看着你，等你看见她。你抬头看了她一眼后，她终于兴奋地脱口而出。

— [Master]! 嘿 [Master] 那辆餐车又回到了豪宅前。他们的肉馅饺子闻起来很香！我-我想知道你能不能给我们买一些...

你会注意到卡莉在与阿米莉亚一起训练后，声音略微降低，双手从背后滑落。至少你可以说，这种姿势让人分心。""",
	CALI_SEX_5_OPTION_1 = "既然你问得这么期待，这是金币。给每个人都买一份吧。 (-100 金币)",
	CALI_SEX_5_OPTION_2 = "对不起，我们现在买不起。也许下次",
	CALI_SEX_5_1 = """卡利嘟了你一小嘴，但没有抗议。

— 好吧，改天吧。""",
	CALI_SEX_6 = """你把钱递给卡莉，过了一会儿，她拿着几盘饺子回来了。味道和她提到的一模一样。把饺子递给其他仆人，她也递给你一份饺子，然后就坐在你身边了。

你们两个边吃边默不作声地仔细考虑着食物。温暖、柔软、烹饪技巧，你会沉思片刻，走出家门，看看你和商家是否能就这些美食的交付达成一致。""",
	CALI_SEX_7 = """卡莉在你之后很快吃完了她的食物。她抬起头来，环视着大厅。她注意到你们两个单独相处。她从你的食物中拿走包装纸，现在抬头看着你，带着感激和兴奋的表情。

— 谢谢 [Master]. 味道好极了。

当女孩再次环顾房间时，她的脸有点红了，她在说话之前看起来很紧张。

— 阿米莉亚一直在给我教学，我想反过来为你做点什么...""",
	CALI_SEX_8 = """卡莉又紧张地瞟了一眼，然后鼓起勇气地看了你一眼。现在她什么也没说，女孩很快就在你面前跪了下来。她平稳地吸了一口气，一边把手伸到你的裤子上，一边把它解开。""",
	CALI_SEX_9 = """卡莉嘴唇上带着微笑凝视着你，开始轻轻地挤压你的阴茎。起初，她的手不稳定，然后她开始专心地给你的阴茎爱抚。

— 哇，我以前从未见过这么近的... 好温暖。

女孩继续抚摸你的阴茎，显然从阿米莉亚的指导下受益匪浅。过了一会儿，你会发现自己几乎在来回摇晃，女孩的手在你面前工作，就像它比她更有经验一样。

— 你似乎喜欢这个...

女孩慢慢加快抚摸你的速度，直到最后她俯下身子，嘴巴包住你的龟头。""",
	CALI_SEX_10 = """卡莉弯下腰，尽最大努力接纳你的阴茎，女孩的小嘴只前进了几英寸，她就不得不后退，抬起头来红着脸看着你。

— 啊，真的很大，天啊。我想知道我是否可以...

卡莉再次开始包住你的龟头，这一次她用手在吸龟头的同时仍在爱抚底部，偶尔会把嘴抽得更深一点。当你躺在那里时，体会这种奇妙的感觉，当你在心里记下感谢阿米莉亚后，你会平静下来。 """,
	CALI_SEX_11 = """她毫无怨言地工作，发出你从女孩那里听到的最感性的声音，你尽了最大努力坚持住。克服释放的冲动，最后在开始高潮时屏住呼吸。""",
	CALI_SEX_12 = """值得称赞的是，即使没有太多警告，卡莉也把嘴唇紧紧地封住了你的龟头。当你差点从座位上弹起时，她的眼睛很惊讶，但她的手紧紧地抓住了。很快，你就在你的位置上喘着粗气，低头看着那个女孩；当她把精液放在嘴里后，她的嘴慢慢地从你的杆首上扯下来。

她抬头看着你的眼睛，现在有点惊讶，女孩很快就下定决心，咽下了这一切，叹了一口气，然后很快对你报以微笑。""",
	CALI_SEX_13 = """— 嗯，希望你高兴, [Master].

当她确认你的反应后，她很快就从眼神交流中退出来履行职责。""",
	
	#needs addition of color tags
	CALI_HEIRLOOM_1 = """早上你看了一个接见请求：一个是关于你的仆人卡莉的。把她叫到你身边后，你准备迎接来访者。 """,
	CALI_HEIRLOOM_2 = """卡莉一看到来访者，一个中年男性，就变得很安静。

{color=aqua|来访者: — 你住在这里啊，卡莉。 }

{color=yellow|卡莉: — 叔叔...}

{color=aqua|来访者: — 我听说你住在这座城市的一座豪宅里……我是来接你回家的。}""",
	CALI_HEIRLOOM_3 = """{color=yellow|卡莉: — 不，我喜欢 [name]。}

{color=aqua|叔叔: — 你考虑过你妈妈吗？自从你失踪后，她一直很不安}

{color=yellow|卡莉: — ...}""",
	CALI_HEIRLOOM_3_OPTION_1 = "我需要一个解释",
	CALI_HEIRLOOM_3_OPTION_2 = "如果你妈妈那么想你，你就应该回家",
	CALI_HEIRLOOM_4_1 = """{color=aqua|叔叔: — 对不起，卡莉是我姐姐的女儿。几周前她离家出走了。看来你为她提供了庇护，为此我感谢你..

叔叔: — 她当时正处于引起部族内部冲突的阶段。我个人并不因此责怪她。}

{color=yellow|卡莉: — 这不是一个阶段！我不会回到部落，叔叔。我宁愿加入土匪。} """,
	CALI_HEIRLOOM_4_2 = """{color=yellow|卡莉: — 不，你不明白。他们不需要我在那里。他们只想要我是因为愚蠢的传统。
}
{color=aqua|叔叔: — 它们不是“愚蠢”的传统，这是非常重要的，你知道的。 }

{color=yellow|卡莉: — 不，我待在这里……我的意思是，如果 [name] 不反对的话。}""",
	CALI_HEIRLOOM_4_OPTION_1 = "如果你愿意，可以留下来。",
	CALI_HEIRLOOM_4_OPTION_2 = "很抱歉，我不会反对你的家人。",
	CALI_HEIRLOOM_FINISH = """{color=yellow|卡莉: — 那…该死！如果你不想让我在这里，我就离开。 
}
{color=aqua|叔叔: — 谢谢你的合作。然后我们该上路了。 }

卡莉很快就离开了，再也没有出现在你眼前。要么是因为她失踪了，要么是不愿意让你找到她。""",
	CALI_HEIRLOOM_5 = """{color=aqua|叔叔: — 我明白了……也许说服你回来真的没有用。很好，如果那样的话，把你偷来的传家宝剑还回来，我就不管你了。
}
卡莉的抗议一听到就突然平息了。

{color=yellow|卡莉: — 哦...你能给我一些时间吗？宝剑不在我身边...}

{color=aqua|叔叔: — 我明白了。很好，但我希望你能意识到它对我们的重要性。我会等到那时。}""",
	CALI_HEIRLOOM_6_INIT = """当卡莉的叔叔离开时，你问她发生了什么事。

— 是的，我离家出走，带了一件传家宝。我想这对我有用，你知道吗？这是一种武器，我需要它来保护自己，或者成为一名战士，你知道吗？然而，它没有成功。当我遇到一群土匪时，他们轻而易举地解除了我的武装，然后他们的首领抓住了我。之后我打算被卖掉。剩下的你知道，自从你找到我。

— 我还没有真正考虑过把它拿回来。老实说，我觉得这是假的，或者至少对我不起作用。也许是因为我是个女孩，或者因为我从来都不适合那里...不管怎样，现在我需要归还它。早知道就不拿走它了。""",
	CALI_HEIRLOOM_6_OPTION_1 = "每个人都会犯错",
	CALI_HEIRLOOM_6_OPTION_2 = "你为什么决定逃跑?",
	CALI_HEIRLOOM_6_OPTION_3 = "为什么这件传家宝很重要?",
	CALI_HEIRLOOM_6_OPTION_4 = "你知道它可能在哪里吗?",
	CALI_HEIRLOOM_6_1 = """— 哈哈，对。谢谢你让我振作起来，但最好等到我解决了这个问题再说。""",
	CALI_HEIRLOOM_6_2 = """卡莉停顿了很长时间才终于开口说话。

— 我根本不确定自己是否属于这个家族，我认为这对我和他们都会更好。我还不太愿意多谈这件事。""",
	CALI_HEIRLOOM_6_3 = """— 我真的不知道。大人们说这是上帝送给我们家族的礼物，会为下一个出生的英雄或诸如此类的愚蠢行为服务。这对我来说没有什么好处。 """,
	CALI_HEIRLOOM_7 = """— 是的，抓获我的土匪就在一个村庄附近。我至少能认出那个地方。当地人可能知道土匪迁移到了哪里。""",
	CALI_HEIRLOOM_7_OPTION_1 = "那我们去拿你部族的剑吧",
	CALI_HEIRLOOM_7_OPTION_2 = "不介意我和你一起去吧？",
	CALI_HEIRLOOM_8_1 = """— 你不必和我一起去，但我很感激。知道你在背后看着我，我会感到更安全。""",
	CALI_HEIRLOOM_8_2 = """卡莉疯狂地摇摇头。

— 当然不是！我很高兴你还在我身边。希望有一天我能还人情给你。""",
	CALI_HEIRLOOM_8 = """卡莉回忆起旧土匪营地所在的位置，而你意识到它就在斯通维尔附近。""",
	CALI_FARMER_1 = """当你四处寻找潜在的目击者时，其中一名农民发现了你。

{color=aqua|农民: — 土匪！土匪侦察兵}

当你意识到他指着卡莉时，你看起来很困惑，卡莉并没有毫无异议地接受这一点。""",
	CALI_FARMER_2 = """{color=yellow|卡莉: — 嘿，我不是土匪！}

{color=aqua|农民: — 你以为我会相信土匪？！叫警卫！}""",
	CALI_FARMER_2_OPTION_1 = "你为什么说她是土匪？",
	CALI_FARMER_2_OPTION_2 = "这是我的仆人，我可以为她担保",
	CALI_FARMER_3 = """{color=aqua|农民: — 她是个混血兽人。在我们的土地上，大多数人要么是土匪，要么是奴隶，我看不到她身上有皮带。 }

{color=yellow|卡莉: — 我告诉你，我不是土匪，我是个好女孩！}

农夫打量了她一眼，终于平静下来。

{color=aqua|农民: — 很好，但我会告诉所有人你的情况。所以，如果你离开后袭击者来了，你就会被列入通缉名单。 }""",
	CALI_FARMER_3_OPTION_1 = "我们实际上在追捕某个土匪团体",
	CALI_FARMER_3_OPTION_2 = "如果你不喜欢土匪，也许你可以帮助我们",
	CALI_FARMER_4_2 = """当你向农民解释你正在寻找的土匪时，他似乎对卡莉宽容了一点，但并没有太多热情。

{color=aqua|农民: — 是的，土匪是瘟疫。我帮你能得到什么？他们不在这里。你知道吗？自从他们上次突袭以来，我的围栏被毁了！你帮我怎么样？}

{color=yellow|卡莉: — 帮你吗？在叫我土匪之后?!}

农民无视卡利的话，继续试图说服你帮助他。

{color=aqua|农民: — 我需要一些木材来修理。你给我200块木材。我会告诉你在哪里可以找到他们，因为我无意中听到他们说要去哪里}""",
	CALI_FARMER_4_OPTION_1 = "你可以用木头做围栏 (-200 Wood)",
	CALI_FARMER_4_OPTION_1_1 = "你可以用木头做围栏 (-100 Wood)",
	CALI_FARMER_4_OPTION_2 = "你的围栏看起来没有那么糟糕。 (工人)",
	CALI_FARMER_4_OPTION_3 = "我们现在还没有",
	CALI_FARMER_4_3 = """农夫仔细打量了你一眼，意识到他骗不了你。

{color=aqua|农民: — 该死，好吧，我以为像你这样的城市 [boy] 会不知道……我会用100块木头。 }

你注意到卡莉对你更加尊重。""",
	CALI_FARMER_4_1 = """你找到了你以前遇到的农夫。他的心情似乎和以前一样糟糕。""",
	CALI_FARMER_5 = """{color=aqua|农民: — 好, 好...}

{color=yellow|卡莉: — 你现在要告诉我们吗?}

{color=aqua|农民: — 是的，是的……土匪在你问的时候就在这里。他们之前在森林里扎营，但过了一段时间，士兵的巡逻队吓坏了他们。现在他们撤退到河边的隐蔽洞穴。据我所知，他们最近一直在低调行事。 }

在农民的帮助下，你在地图上标出位置，然后继续前进。可以肯定的是，土匪会试图发动战斗，所以你最好做好准备。""",
	CALI_FARMER_6 = """{color=aqua|农民: — 那就不要浪费我的时间。我知道你们城里人身上有足够的钱。你帮我，我帮你。}""",
	CALI_BANDITS_1 = """— 我想就是这些人。他们把我交给了那些奴隶贩子。我等不及要算账了!""",
	CALI_BANDITS_1_OPTION_1 = "这应该不会花很长时间",
	CALI_BANDITS_1_OPTION_2 = "不要冲在前面，这可能很危险",
	CALI_BANDITS_1_OPTION_3 = "他们会因为伤害你而受到惩罚",
	CALI_BANDITS_2_1 = "— 让我报完仇，我才能自由。",
	CALI_BANDITS_2_2 = "— 好的，对不起，我上次吸取了教训。",
	CALI_BANDITS_2_3 = """卡莉对你的保护声明明显感到脸红，但只是点头表示同意。

— 是-是的，让我们上吧...""",
	CALI_BANDITS_3 = """当小队首领倒在地上时，你把他绑起来开始审问。

{color=aqua|小队首领: — 你们这些婊子来这里干什么？？你们需要我做什么？}

{color=aqua|卡莉: — 记得我吗?}

{color=aqua|小队首领: — 为什么我要记得某个混血裔的婊子？}""",
	CALI_BANDITS_4 = """卡莉愤怒地踢着被绑着的强盗的肚子，迫使他发出呻吟声。

{color=yellow|卡莉: — 你把我卖给奴隶贩子了！还拿走了我的东西。 }

{color=aqua|小队首领: — 那又怎样？你不是跳我们脸的那个人吗？大喊你要成为一个著名的英雄。}

{color=yellow|卡莉: — 这-这不是重点！我要回我的东西。你从我手里夺走的剑！}

{color=aqua|小队首领: — 那就让叛军公主吸我吊。}""",
	CALI_BANDITS_4_OPTION_1 = "再踢他几次，这是他自找的",
	CALI_BANDITS_4_OPTION_2 = "你最好不要惹她生气，否则我不会保护你",
	CALI_BANDITS_5_1 = """卡莉很高兴地答应了你的请求，直到土匪开始恳求她停止。""",
	CALI_BANDITS_5_2 = """当首领决定让步时，卡莉准备继续伸张正义。""",
	CALI_BANDITS_5 = """{color=aqua|小队首领: — 好吧，好吧，够了！反正我没有！阿利隆的一些收藏家花了足够多的钱买了它！}

{color=yellow|卡莉: — 该死……是谁？}

{color=aqua|小队首领: — 不知道，但他肯定很富有。也许是最富有的混蛋；留着胡子，像十几个保镖……我只知道这些。这就是你来的目的？}""",
	CALI_BANDITS_5_OPTION_1 = "我们现在可以走了",
	CALI_BANDITS_5_OPTION_2 = "卡莉，你可以玩得更开心点",
	CALI_BANDITS_5_OPTION_3 = "我们将把你绳之以法",
	CALI_BANDITS_6_1 = """你离开了被绑的土匪，他保持沉默，他可能希望最终自己挣脱。""",
	CALI_BANDITS_6_2 = """{color=yellow|卡莉: — 哦，是的，我确实认为我得到了一些回报...}

卡莉继续向这个无助的土匪复仇了几分钟，直到他的脸几乎认不出来。卡莉累坏了，最终在你离开的时候加入你。""",
	CALI_BANDITS_6_3 = """{color=aqua|小队首领: — 不，等等，我们可以讨论这个！}

{color=yellow|卡莉: — 哈，他必须为我所经历的一切负责！}

你无视土匪的恳求，堵住他的嘴，把他交给附近定居点的当地警卫。""",
	CALI_BANDITS_7 = """{color=yellow|卡莉: — 我们能找到它吗？我确信他们会有，但现在...}""",
	CALI_BANDITS_7_OPTION_1 = "我们将去城市看看我们能做些什么。",
	CALI_BANDITS_7_OPTION_2 = "不应该有那么多富有的收藏家，以至于我们找不到它",
	CALI_BANDITS_8 = """{color=yellow|卡莉: — 对，我还不应该放弃。}""",
	CALI_WILLIAM_INIT_OPTION = "四处打听", 
	CALI_WILLIAM_INIT = """四处打听后，你很幸运地得知，最有可能成为你要找的收藏家的人是威廉。这个人是贵族之一，即使在政变后也保留了他的职位。

{color=yellow|卡莉: — 我们去看看这个家伙，希望他还有那把剑。}""",
	CALI_WILLIAM_OPTION = "拜访威廉的豪宅", 
	CALI_WILLIAM_REFUSE = """你想去拜访威廉的尝试失败了。仆人暗示你太微不足道了，不能把主人的时间花在你身上。也许，在回来之前，你必须获得更多的名声...""",
	CALI_WILLIAM_1 = """你走进了这个男人的庄园。就在你漫步庄园的时候，金碧辉煌的装饰晃了你的眼，以至于你想知道你是否可以梦想实现类似的目标。一排排仆人礼貌地问候你，并引导你走向主人。

在短暂的认识之后，你开始做生意，并解释你来这里是为了什么。 

{color=aqua|威廉: — 市长，我很高兴你来过。有什么需要我的地方？ }""",
	CALI_WILLIAM_1_OPTION_1 = "我听说你买了属于我仆人的东西",
	CALI_WILLIAM_1_OPTION_2 = "有一件东西是土匪卖给你的。", 
	CALI_WILLIAM_2 = """卡莉胆怯地复述着她所经历的事情。你可以注意到，她对这座庄园的辉煌感到相当害怕。 

{color=aqua|威廉: — 啊，是的，那把剑。它是精美的艺术品，但质量很差。没错，我买它的目的是在某个时候把它换掉。既然你是来买的，我的报价是5000金币。 }

{color=yellow|卡莉: — 你在开玩笑！？那个价格太离谱了！}

卡莉愤怒地脱口而出，但威廉似乎一点也不吃惊。""",
	CALI_WILLIAM_2_OPTION_1 = "卡利说得对，太贵了",
	CALI_WILLIAM_2_OPTION_2 = "由卖方决定", 
	CALI_WILLIAM_3 = """— 确实它的价格很高，但没有其他像它一样的东西了，是吗？我也不真正需要钱，所以我可以有足够的耐心来获得最好的报价。

{color=aqua|威廉: — 但如果你不能提供这么多钱……我想我可以慷慨一下。这个女孩，卡莉，对吧？我可以同意让她做我的仆人一周。}

威廉强调了'仆人'一词，明确表示服务本身与劳动无关。

{color=aqua|威廉: — 你肯定她会受到很好的待遇。毕竟，你可以看出我的家是一个值得国王居住的地方。}

卡莉对这个命题无言以对，但作为她的主人，决定权落在你身上。""",
	CALI_WILLIAM_3_1 = """你和卡利又一次来到那个男人的豪宅，交换卡莉的传家宝。

{color=aqua|威廉: — 这次我们别开玩笑了。你把钱带来了？或者这个女孩会住在我这里吗？ }""",
	CALI_WILLIAM_3_2 = """""",
	CALI_WILLIAM_3_OPTION_1 = "我们可以讨论一下",
	CALI_WILLIAM_3_OPTION_2 = "我宁愿付钱", 
	CALI_WILLIAM_3_OPTION_3 = "我稍后返回", 
	CALI_WILLIAM_4 = """威廉保持安静，等待你的决定。""", 
	CALI_WILLIAM_4_OPTION_1 = "她真的不值得。作为交换，我可能会给你一个更好的仆人。",
	CALI_WILLIAM_4_OPTION_2 = "卡莉的能力比你想象的要高得多。", 
	CALI_WILLIAM_4_OPTION_3 = "卡莉会这么做。", 
	CALI_WILLIAM_4_OPTION_4 = "也许现在决定还为时过早...", 
	CALI_WILLIAM_5 = """威廉考虑了一下提议，然后点了点头。

{color=aqua|威廉: — 很好，我想她看起来并没有那么优雅。}

卡莉的脸上很快就充满了愤怒，但她明智地保持沉默..

{color=aqua|威廉: — 那么，我想知道你用谁来顶替她。 }""", 
	CALI_WILLIAM_5_OPTION_2 = "*重新考虑*", 
	CALI_WILLIAM_6 = """— 我很好。除非有人出价，否则它会等着你的。 """, 
	CALI_WILLIAM_7 = """当你走出豪宅时，卡莉拦住了你。她的声音很低，显然她对这种情况感到不舒服。

{color=yellow|卡莉: — 嘿-嘿，我不能向你要求那么多，这首先是我的错……我想我应该接受这笔交易，毕竟只有一周的时间。 }""",
	CALI_WILLIAM_7_OPTION_1 = "我会考虑的",
	CALI_WILLIAM_7_OPTION_2 = "即使你同意，我也不会让他把手放在你身上", 
	CALI_WILLIAM_8_1 = """卡莉点点头，你们安静地行走在回家的路上。""",
	CALI_WILLIAM_8_2 = """— 嘿，现在你真的很关心我。我真的不习惯……但谢谢。

卡莉对你突然的保护性声明感到脸红，她对你的看法明显改善了。""",
	CALI_WILLIAM_9 = """{color=aqua|威廉: — 很好，这就足够了。在这种情况下，很高兴与你做生意。}""",
	CALI_REPLACEMENT_RETURNS = """在约定的日期，您送给威廉的[name]将返回您的豪宅。 """, 
	CALI_WILLIAM_10 = """在你准备文件的时候，卡莉温柔地向你点头。你回家的时候，她会暂时住在威廉的庄园里。""", 
	CALI_RETURNS = """在约定的日期，卡莉回到了你的豪宅。尽管她已经带回了她的传家宝，但她坚决拒绝谈论在她逗留期间发生的任何事情。""", 
	CALI_WILLIAM_11_1 = """男人又看了卡利一眼，卡利明白了其中的含义，尽最大努力让自己看起来更有女人味。

{color=aqua|威廉: — 既然你这么说了，那可能是真的。你现在为什么要提这个？}""", 
	CALI_WILLIAM_11_2 = """威廉又看了卡利一眼，但她似乎没有理解你的意图，给了他一个充满敌意的眼神。

{color=aqua|威廉: — 我不确定我是否能同意你的意见。7天或5000金，我的报价不变。}""", 
	CALI_WILLIAM_11_1_OPTION_1 = "我想要这把剑和3000金，作为和她在一起一周的价钱。",
	CALI_WILLIAM_11_1_OPTION_2 = "她只能停留3天",
	CALI_WILLIAM_12 = """这名男子在故意检查狼女时沉默了一段时间。最后他软化了态度。

{color=aqua|威廉: — 非常好，如果你对她的评价和她的技能是正确的，这将是非常值得的。}

你把卡莉拉到一边，向她解释这是她现在的职责。

{color=yellow|卡莉: — 该死！我为什么要为这个家伙服务！啊，如果不是因为那些混蛋... }

最后，她承认自己必须处理自己行为的后果。""", 
	CALI_WILLIAM_13 = """当你在文件上签字时，卡莉有点不情愿地和威廉在约定的期限内离开了。""", 
	CALI_GRAT_BAD = """在约定的日期，卡莉回到你的豪宅。尽管她已经带回了她的传家宝，但她坚决拒绝谈论在她逗留期间发生的任何事情。 """,
	CALI_GRAT_1 = """当你回到官邸时，卡莉敬畏地看着你。

— 我不敢相信你真的把它拿回来了！有了这个，我就完全自由了。

— 呃...我能把它拿回来吗？""",
	CALI_GRAT_1_OPTION_1 = "当然，这毕竟是给你的",
	CALI_GRAT_1_OPTION_2 = "我想，你欠我一些回报", 
	CALI_GRAT_1_OPTION_3 = "我决定自己留着", 
	CALI_GRAT_2 = """— 谢谢！你为我做了这么多...

经过片刻的考虑，卡莉走近你，说话的声音中带着一丝挑逗。

— 啊, [Master], 也许我可以做点什么来回报你？这不能真正报答你为我做的一切，但我想回报你。""",
	CALI_GRAT_2_OPTION_1 = "我当然不能拒绝这样的请求。",
	CALI_GRAT_2_OPTION_2 = "我真的不感兴趣。", 
	CALI_GRAT_3 = """— 啊，是这样吗？太遗憾了。

卡莉显然很失望，但并没有坚持。她接过传家宝，在再次感谢你之后，离开房间准备。""",
	CALI_GRAT_4 = """卡利很快意识到你的意图并微笑。

— 是-是的，我不确定我能不能全部还，但我必须从某个地方开始...?""",
	CALI_GRAT_5 = """卡莉震惊地看着你，她的话带着一丝怀疑。

— 不可能，你是认真的吗？你不能...""",
	CALI_GRAT_5_OPTION_1 = "我只是开玩笑",
	CALI_GRAT_5_OPTION_2 = "我认真的", 
	CALI_GRAT_6 = """卡莉看起来快要哭了，但在最后一刻她咬牙切齿。

— 去你的！傻逼我不需要你，也不需要这该死的东西！

你还没来得及做什么，她就冲出了豪宅，消失在街上。你似乎不太可能再见到她了 """,
	CALI_GRAT_7 = """— 太棒了。

当卡莉躺在你旁边时，她转过头来，用一种有点紧张的声音问道，这与她很不一样。

— [Master]... 我想问你，你觉得我怎么样？..我对你来说是什么？

当她看着你的眼睛时，你意识到她在等待答案。""",
	CALI_GRAT_7_OPTION_1 = "情人",
	CALI_GRAT_7_OPTION_2 = "朋友", 
	CALI_GRAT_7_OPTION_3 = "女儿", 
	CALI_GRAT_8_1 = """— 我……我也爱你, [Master]。在我们刚刚做了这件事之后，现在宣布这件事感觉有点奇怪……但我很高兴我和你一起做了。哦，你也有同感。

卡莉把她的脸埋在你身边，你决定让她今天休息。""",
	CALI_GRAT_8_2 = """— 一个朋友，嗯……我以为这不仅仅是一段友谊。

卡莉沉默了，显然对你的回答感到失望。几分钟后，你悄悄地穿好衣服，她就离开了，为未来做准备。""",
	CALI_GRAT_8_3 = """卡莉惊讶地瞪大了眼睛。但她觉得你的回答很有趣。

--真的吗？！哈哈。不可能！你是变态吗，[Master]？不，也许我该叫你“爸爸”？我一直以为我父亲会对我严格要求，但你恰恰相反。

狼女深情地品尝了你的新昵称一会儿。

--爸爸，你知道狼有很强的耐力吗？我想再做一次...""",
	CALI_SWORD_RETURN_INIT = "让我们归还你的剑",
	CALI_SWORD_RETURN_1 = """— 对了。我试过了，但感觉还是像一大块无用的铁。

从表面上看，卡莉是完全正确的。传家宝剑感觉不像是一种合适的武器，充其量只能作为一种仪式工具。""",
	CALI_SWORD_RETURN_1_OPTION_1 = "也许还没到时间",
	CALI_SWORD_RETURN_1_OPTION_2 = "看起来像是个骗局",
	CALI_SWORD_RETURN_2 = """卡利在失败中耸耸肩，把它收起来。

— 好吧，让我们把它还回去，这一切就结束了。我叔叔应该住在附近的小酒馆里。""",
	CALI_SWORD_RETURN_3 = """你发现卡莉的叔叔独自一人在酒馆房间里。这个人看起来很不安，但看到你后变得更活跃了。

{color=yellow|卡莉: — 我得到了传家宝。这并不容易，但我成功了。}

{color=aqua|叔叔: — '很好，但我有个坏消息……在我报告我找到你后不久，我收到了一条消息。赫克托似乎已经夺取了当前首领的权力，并将你母亲作为人质。}

{color=yellow|卡莉: — 什-}

卡莉僵住了，不知道该怎么办。 """,
	CALI_SWORD_RETURN_3_OPTION_1 = "谁是赫克托?",
	CALI_SWORD_RETURN_3_OPTION_2 = "到底发生了什么?",
	CALI_SWORD_RETURN_4 = """{color=aqua|叔叔: — 我想我应该解释一下。你看，在我们家族中，有一个英雄领袖的世袭家族，受到造物主的保佑。那些出生在这个家族中的人应该领导和保护这个家族。卡莉的母亲属于这个家族，她必须生下下一个继承人。然而...}

{color=yellow|卡莉: — 我出生了，—卡莉大声嚷嚷。}

{color=aqua|叔叔: — 是的，卡莉是非婚生。她的母亲拒绝放弃她，我们也从未了解过她的父亲是谁。尽管如此，她还是被接纳加入了这个家族，但当然不是每个人都对此感到高兴。她的母亲本应结婚，并让她的下一个孩子成为继承人，但她无法再次怀孕，她的丈夫抛弃了她们，最终消失了。

叔叔: — 所以在那之后，我们决定需要卡莉来扮演这个角色，并给我们下一个继承人。这是一个艰难的决定，尤其是考虑到她的天性，但这比根本没有继承人要好，最终这是造物主决定的命运。}""",
	CALI_SWORD_RETURN_5 = """{color=aqua|叔叔: — 赫克托，她预订的伴侣，来自另一个家族，这个家族本身就有可能成为氏族首领。所以决定...}

{color=yellow|卡莉: — 我，成为他的妻子，所以我们的孩子将成为下一个有价值的继承人或诸如此类的愚蠢事情。}

{color=aqua|叔叔: — 是的，就是这个主意。但现在他似乎只想拥有这把剑。}""",
	CALI_SWORD_RETURN_5_OPTION_1 = "可能存在误解",
	CALI_SWORD_RETURN_5_OPTION_2 = "给他不是个好主意",
	CALI_SWORD_RETURN_6 = """卡莉给人一种不安的感觉，显然这种情况给她带来了压力。

{color=aqua|叔叔: — 既然你母亲是人质，我们别无选择，只能把传家宝还给他。尽管我讨厌他，但我们真的还有什么选择吗？}

{color=yellow|卡莉: — ...我应该回去了。即使我们不亲密，她仍然是我的母亲。}

{color=aqua|叔叔: — 至少让他和你一起去吧，他看起来很能干..}""",
	CALI_SWORD_RETURN_6_OPTION_1 = "别担心，我和你一起去",
	CALI_SWORD_RETURN_6_OPTION_2 = "既然没有更好的事情可做，我就跟着好了 ",
	CALI_SWORD_RETURN_7 = """卡莉感激地看着你，点了点头。

{color=aqua|叔叔: — 好的，做好准备，我们很快就会回家。}""",
	CALI_HECTOR_INIT = "跟随卡莉",
	CALI_HECTOR_1 = """当你来到氏族的村庄时，你从后面跟着卡莉，她把剑举到胸前。你的访问是意料之中的，许多人开始聚集在一起从远处观察。

很快，一群武装人员出来试图迎接你。从卡莉的反应来看，它是由赫克托率领的。在他们身后一点，你会发现一个孤独的女人被其他几个警卫监视着，意识到这应该是卡莉的母亲。""",
	CALI_HECTOR_2 = """当卡莉向前移动时，你被几个警卫拦住了。

{color=aqua|赫克托：—看谁回家了。我还以为你早就死了呢，卡莉}

{color=yellow|卡莉: — 你可以看到我很好。}""",
	CALI_HECTOR_3 = """{color=aqua|赫克托: — 我不在乎。你把偷来的东西带来了？}

{color=yellow|卡莉: — 我没有偷。它是属于我的。 }

{color=aqua|赫克托: — 嘁，把它给我。}

卡莉紧张起来，不愿意与剑分开。""",
	CALI_HECTOR_4 = """{color=yellow|卡莉: — 先放我妈妈走!}

{color=aqua|赫克托: — 你敢向我提出要求吗？向部族首领?}

{color=yellow|卡莉: — 你不是领导者！领导者不会把一个无助的女人当作人质！}

{color=aqua|赫克托: — 够了!}""",
	CALI_HECTOR_5 = """当赫克托靠近卡莉时，卡莉后退，但这个地方被赫克托的人包围了，无法逃脱。赫克托尔很快把手抓在剑上，用力拉扯，迫使剑从她手中夺下。

令他惊讶的是，卡莉拒绝放手。相反，她固执地紧紧抓住那个大得多的男人。

{color=aqua|赫克托: — 你这个小婊子，你以为你是谁!}

{color=yellow|卡莉: — 我不会把它交给像你这样的狗种!}""",
	CALI_HECTOR_6 = """尽管发生了这一切，但没有人试图干预；不确定这是否也是更高层次的意志。赫克托被她的话激怒了，他用自由的手拔剑，卡莉惊讶地睁大了眼睛。

当他的剑挥下时，卡莉无法逃脱，因为她手里拿着自己的剑，而这把剑毫无用处。 """,
	CALI_HECTOR_7 = """*刀剑划破肉体的声音*

卡利本能地闭上眼睛，却意识到自己没有受伤。然而，她的母亲倒在她身边，被赫克托的利刃砍倒了..

令所有人震惊的是，她冲了进来阻止赫克托，赫克托现在退缩了，对干预感到愤怒。

{color=aqua|赫克托: — 愚蠢的婊子！这都是你的错。 }

卡莉情绪失控，哑口无言。当她报复性攻击赫克托时，这把剑在她手中如身之使臂。尽管经过了训练，她仍然远远不是一名优秀的剑士，但当她奋力进攻时，她的剑闪闪发光。""",
	CALI_HECTOR_8 = """赫克托倍感压力，向忠于他的士兵发表讲话，试图控制局势。

{color=aqua|赫克托: — 你还在等什么？把她砍倒!}

卡莉寡不敌众，但胜负由你来决定。""",
	CALI_FINALE_1 = """当他的手下被击败时，赫克托举起剑来防御卡利的进攻。由于他的剑在一个奇迹般的交击中破碎，这个阻挡毫无用处。卡莉仍然愤怒，她又挥舞宝剑，刺穿了这个人的盔甲，使他倒下，他脸上露出了恐惧的表情。

然而，女孩的眼神丝毫没有丝毫的软化...""",
	CALI_FINALE_1_OPTION_1 = "阻止她",
	CALI_FINALE_1_OPTION_2 = "让她杀人",
	CALI_FINALE_2_1 = """在卡莉打出最后一击之前，你向她喊道。你看到她在发抖，剑的边缘离他的脖子只有几英寸。慢慢地，她恢复了理智，在赫克托失去意识时离开了他。""",
	CALI_FINALE_2_2 = """当卡莉打出最后一击时，你决定不该干涉；过了一会儿，剑从她手中落下。 """,
	CALI_FINALE_3 = """战斗结束后，卡莉迅速移到母亲身边。令她惊讶的是，她仍在呼吸，但伤口的大小毋庸置疑，她的伤势具有致命性。

{color=yellow|卡莉: — 妈妈！……妈妈！求你了，你不能死！}

{color=aqua|母亲: — 卡利，你真的长大了……我知道……我在做什么……我会怎么样……但我很高兴你安全了... }

{color=yellow|卡莉: — ..很高兴？你在说什么?} """,
	CALI_FINALE_4 = """{color=aqua|母亲: — 你不…看到了吗？你是被选中的人之一…所以这一直都是命运的安排……我一生中犯了很多错误……但保护你不是其中之一... }

卡莉无话可说，泪水夺眶而出。她妈妈轻轻地扫了一下她的脸颊。""",
	CALI_FINALE_5 = """经过几天的哀悼，卡莉准备和你一起回来。她拒绝成为下一任氏族首领，在发生了这一切之后，这可能是最好的。

— 你知道吗, [Master], 我想我明白妈妈的意思了。我从来没有想过她是一个有爱心的父母，但对她来说，摆脱我会容易得多... 

— 但没有你，我永远不会得出这样的结论, [Master]。 我想为此感谢你...现在我真的自由了。你不介意有我在身边，对吧？""",
	CALI_FINALE_5_OPTION_1 = "现在别那么认真，这不像你",
	CALI_FINALE_5_OPTION_2 = "童年已逝啊",
	CALI_FINALE_5_OPTION_3 = "这是互惠互利",
	CALI_FINALE_6_1 = """— 哈哈，你觉得呢？我想我最好去惩罚一些土匪放松一下。我的意思是，我们...""",
	CALI_FINALE_6_3 = """— 你-你在想什么？你知道，你应该小心，因为我仍有望成为下一个继承人的母亲……尽管，不知何故，我对此感到压力小了很多。""",
	
	CALI_GRAT_SEX_1 = """当你把卡莉抬起来时她会发抖，当你把她的小身体放在你的身体上时，你又一次惊叹她的小巧，眼睛紧紧地盯着她的。她轻轻颤抖，你现在紧紧抓住雌性的臀部，开始向她施压，她被迫气喘吁吁。

虽然曾经是一个亲密的伴侣，虽然女孩的入口潮湿，但仍然无法容纳，现在你不得不让她受一点折磨，她的身影仍然在颤抖，当她聚精会神地看着你时，她发出了轻微的呻吟。

— [Master]...

在她的帮助下，你很快就开始向她施压，十几岁的孩子紧紧地挤在你身上，每一寸都把她顶得更远。卡莉没有抱怨，而是让重力接管了她对你的控制，她几乎立刻把身体完全滑到你的阴茎上，当她抬头看着你时，嘴里传来一声轻柔的呜咽。
""",
	CALI_GRAT_SEX_2 = """你现在开始很容易地把女孩弹到你身上，看到女孩抬头看着你、气喘吁吁的样子驱使你前进，当她紧紧的入口威胁要把你从她紧张的身体中驱逐出来时，她会把你带到深处，只有重力和有点粗糙的技术会让你进入她不断收紧的身体。

随着时间的推移，女孩更加放松，当你继续向她猛扑时，她的手会变得更加柔韧，当她用腿挤得更紧时，她的眼睛会紧紧地盯着你，她的身体会因刺激而轻微颤抖。

— 请-请... [Master]... Aaah-ah...""",
	CALI_GRAT_SEX_3 = """狼女现在半推半就，再过几分钟，她的臀部就在你身上扭动，当她紧紧围绕你时，她的视线变得模糊，当你感觉到她的高潮开始时，她的脚踝紧紧锁住你。

你可以放慢脚步，慢慢来，再享受她一段时间，但她的呜咽声和轻柔的呻吟声很快就会促使你加入她的高潮，你们两个发现自己紧紧地靠在一起，当卡利闭上眼睛，在你的手中颤抖时，你们两人之间爆发出混乱。""",
	
	CALI_GRAT_SEX_ALTER_1 = """当你现在把卡莉抱起来时，她在发抖，她的眼睛移到你的眼睛上，然后移开视线，脸上明显有一种脸红的感觉。她感觉到你的阴茎在她两腿之间的温暖，头在她的花瓣之间滑动时，她的脸红的婉如熟透的苹果。

你慢慢来，卡莉嘴里传来轻柔的呜咽声，尽管很明显她在试图压制它们。当你继续研磨时，从她的颤抖中可以清楚地看出她很紧张，当她抬头看着你，睁大眼睛时，可以听到她呻吟的声音。

— [Master] 我... 好了，我准备好了...

当这个女孩勇敢地为你服务，即使有她自己的恐惧，也能满足你的需求时，你感到有点自豪。再磨几分钟后，你们两个都喘着粗气，当你开始按压时，你的眼睛会短暂地锁住，当你试图按压她的身体时，半狼女孩发出更大的呜咽声，当你慢慢地把她抱起来时，她的眼睛闭上。 """,
	CALI_GRAT_SEX_ALTER_2 = """当你发现自己现在卡在卡莉的身体里时，卡利的腿紧紧地围绕着你，当她像老虎钳一样紧紧地抓住你的阴茎时，她的眼睛闭上了。当你抓住她的臀部时，这种挤压只会驱使你继续前进，深入她的臀部，直到你的臀部和她的臀部相互挤压，青少年嘴里的呜咽声一刻不停。

— Aah-hah... 不是...和我想象的一样糟糕。

她的身体值得等待。当你开始撞她时，这只雌性的身体在你的手中闪闪发光，她的洞紧紧地挤压着以抗议入侵，但无论如何都无法阻止。卡莉自己要么尴尬，要么试图表现得勇敢，让你咬下她的嘴唇让自己安静下来，结果喜忧参半。""",
	CALI_GRAT_SEX_ALTER_3 = """
卡莉的呜咽很可爱，即使女孩允许她的身体满足你现在的任何需求，她也很兴奋。当你向她猛扑过去时，你的手紧紧地抓住了她的身体，当你深入她的女性深处，这个没经验的女孩没有提出抗议。很快，你会发现自己被埋在她体内的竖井底部，卡利第一次把你完全抱起来，她自然地挤压你，只会增加你的快乐。

在她付出了如此努力之后，如果说你对她的表现感到满意，那就太轻描淡写了，当她继续试图抑制自己的呜咽时，你的臀部如饥似渴地向这个青少年挤压。最终，当她喘着粗气时，她失去了挣扎，当你充满她的时候，她的眼睛会睁大一会儿。当她变得僵硬时，你的精液会深深地射入她的身体，当你把每一滴都留在她身上时，她的背部会用力拱起。""",
	CALI_GRAT_SEX_ALTER_4 = """
当你把她抱在那里的时候，一切都安静了一会儿，在她偷偷看你一眼之前，她穿着破旧的裤子呼出了一口气。 

— 我... 很高兴是你， [Master].""",
	
	CALI_AMELIA_1 = """像往常一样，今天卡莉和阿米莉亚一起在仆人公会上课。然而，这一次阿米莉亚忍不住注意到女孩分心了，她的专注与往常相去甚远。

{color=aqua|阿米莉亚: — 卡莉，告诉我，有什么事困扰着你吗?}

卡莉在沉思时会抬起头来，脸上带着一丝惊讶的表情看着阿米莉亚。

{color=yellow|卡莉: — 啊，不，没什么.}

{color=yellow|阿米莉亚: — 没关系，卡利，你可以相信我。如果不是作为你的导师，至少是作为你的朋友。}""",
	CALI_AMELIA_2 = """卡莉思考了很长一段时间，然后慢慢地呼吸。

{color=yellow|卡莉: — 我最近一直想在这里引起[master]的注意。但它不起作用。就像[he]根本没有注意到我...}

{color=aqua|阿米莉亚: — 我明白了。是的，那太令人沮丧了。 }

卡莉现在平静地往下看，但点头同意导师的话。

{color=aqua|阿米莉亚: — 但是，由于你很紧张，也很痛苦，你今天的课程可能不是特别有效。我认为现在休息更适合你。也许按摩一下。}""",
	CALI_AMELIA_3 = """卡莉仔细考虑几分钟，然后软化态度，点点头。女孩没有地方争论放松的机会。就阿米莉亚而言，她是这方面的专家，现在她开始努力消除女孩肩膀的紧张感时，她的手在女孩肩膀上滑动。过了一会儿，卡莉唯一的声音是愉快的呻吟和叹息，阿米莉亚展示了她在按摩方面的专业知识。女孩需要这种接触，因为她很快就会靠在阿米莉亚身上。

卡莉的呼吸加快，她现在把自己拉得离阿米莉亚更近了，当卡莉发觉时，这个女孩几乎坐在她的腿上，当她靠得更近时，她产生了一种感觉。这对阿米莉亚、卡利和他们两人来说是出乎意料的，她们现在接吻了，随着接吻的加深，身体相互挤压。之前给她按摩的手现在正在探索，轻轻地爱抚着卡莉的身体，但当附近能听到几声动静时，她才反应过来，两位女士都跳了起来，稍稍拉开了距离。""",

	CALI_AMELIA_3_1 = """{color=yellow|卡莉: — 啊……嗯……我不是...}

{color=aqua|阿米莉亚: — 对不起，卡莉，那……太好了。看来我们现在都很兴奋。 }

阿米莉亚把手放在下巴上思考，然后继续看着卡莉。

{color=aqua|阿米莉亚: — 不过，如果你喜欢的话，我有一个房间，我们不会被打扰的。}

卡莉转移了她那红着脸的目光，但她还是心甘情愿地点了点头。""",
	CALI_AMELIA_4 = """卡莉跟随阿米莉亚深入行会的住处，现在她发现自己在一个灯光昏暗的房间里，当她被带到一张相当大的床上时，空气中弥漫着柔和的气味。

{color=aqua|阿米莉亚: — 已经有一段时间没有人陪我了。}

卡莉仍在打量着房间，站在入口处，阿米莉亚引导她上床，当狼女转身时，她的手放在她的下背部，当阿米莉亚加入她的行列时，她靠在边缘休息。

{color=yellow|卡莉: — 我……不知道该怎么办……这里很好。}

{color=aqua|阿米莉亚: — 好好享受吧，卡莉，毕竟你是我的客人。}""",
CALI_AMELIA_4_1 = """当阿米莉亚把女孩拉得更近时，卡莉在闲聊中分散自己的注意力，她的腿跨在卡莉的腿上，微笑着靠近她。

{color=aqua|阿米莉亚: — 我知道你因为没能引起那个男人的注意十分沮丧，但今天我们不必担心。}

卡莉开始回应，当阿米莉亚把女孩们的上衣拉起来，她的手抓住女孩柔软的乳房时，她发出了一声轻柔的呻吟。它们并不大，但她年轻的身体是如此可爱，以至于阿米莉亚忍不住探索它们。 """,
	CALI_AMELIA_5 = """过了一会儿，两人再次接吻，舌头一碰就不间断了。阿米莉亚的臀部轻轻地摩擦着她裸露的腿。在呼吸要求他们停止接吻后，当阿米莉亚的手滑得更低，把内裤移到一边时，卡莉的脸变成了深红色。

{color=yellow|卡莉: — 啊-啊!}

卡莉在恍惚的恐慌中惊叫，然后当女人轻轻地开始摩擦时，她的抗议演变成了一种渴望的呻吟。抵抗现在已经平息，阿米莉亚将继续做需要做的事情。在女孩受到刺激的几分钟后，阿米莉亚把手移到裙子上，把它拉下来，为女孩露出胸部。""",
	CALI_AMELIA_6 = """卡莉很快就会再次亲吻阿米莉亚，随着女孩的欲望越来越强烈，这种亲吻变得迫切而绝望。嘴唇和舌头交织在一起的轻柔声音很快就被喉咙的呻吟声打断，阿米莉亚已经把手指伸进了女孩体内。

年轻的女孩现在正气喘吁吁地亲吻着，她被唤起了，不顾一切地想取悦别人，得到别人的认可。当这个女人现在用臀部在大腿上摩擦时，她能感觉到阿米莉亚作为女性的热度，这只会增加她的兴奋感。

最后，当卡莉因被唤醒和刺激而气喘吁吁时，呼吸再次要求亲吻破裂。

{color=yellow|卡莉: — 我-我快要-来了-}

现在，她又被一个吻打断了，当她开始达到高潮时，她的身体在女人的手指上收缩，她的臀部在抽搐，她竭尽全力扩大这种感觉。""",
	CALI_AMELIA_7 = """最终，两人就坐在那里，阿米莉亚轻轻呻吟，再次摩擦女孩的肩膀。

{color=aqua|阿米莉亚: — 现在，你感觉好多了吗？}

卡莉意识到自己刚刚做了什么，很害羞，点了点头，脸上仍然通红。

{color=yellow|卡莉: — 这是...?}

{color=aqua|阿米莉亚: — 别担心，几个女孩偶尔会有一些私人乐趣。你应该专注于为你的目标更加努力。}""",
	
	LILIA_PRELUDE1 = """当你穿过街道时，你偷听到一个不同寻常的对话，显然是来自一个冒险家。

{color=yellow|市民 A: — 我告诉你，在我到达那个村庄后，有一个疯狂的红发仙精。她从远处观察我，就像我是某种外来动物一样。}

{color=aqua|市民 B: — 他们都是这样，不是吗？ }

{color=yellow|市民 A: — 是的，但其他人都散开了，根本不理我。我无法把她叫出来...}""",
	LILIA_PRELUDE2 = "你决定记下这件事，也许下次去精灵森林时会去看看。",
	
	LILIA_STARTING_1 = """当你在村庄里穿行时，偶尔会有精灵和仙精在观察你，你会注意到大多数居民都非常谨慎，一旦你的目光落在他们身上，他们就会转身离开。也就是说，除了一个非常好奇的红长发仙精。当她意识到自己引起了你的注意后，她冲向你，喋喋不休地抛出问题，就像山洪一样势不可挡。

 — 嗨！我是莉莉娅。你叫什么名字？你是个冒险家吗？你太大了！我们这里很少有像你这样的人。是什么把你带到这里来的？""",
	LILIA_STARTING_1_OPTION_1 = "很高兴认识你，我是 [name].",
	LILIA_STARTING_1_OPTION_2 = "哇哦, 慢慢来",
	LILIA_STARTING_1_OPTION_3 = "你真的不懂礼貌，是吗?",
	LILIA_STARTING_2_1 = """ — 啊，对不起，能遇到像你这样的人真是太令人兴奋和难得了！你看起来又大又强壮！

— 嘿，嘿，你来干什么？

与大多数当地人不同，莉莉亚对你很友好.. """,
	LILIA_STARTING_2_2 = """— 嘿，嘿，你来干什么？

与大多数当地人不同，莉莉亚对你很友好..""",
	LILIA_STARTING_2_3 = """— 我喜欢它，好吧。但我在这里住了很久。你要知道，生活变得非常无聊。""",
	LILIA_STARTING_2_OPTION_1 = "你想去更私密的地方吗?",
	LILIA_STARTING_2_OPTION_2 = "你想加入我吗?",
	LILIA_STARTING_2_OPTION_3 = "你觉得这里怎么样?",
	LILIA_STARTING_2_OPTION_4 = "我现在该走了，改期见",
	LILIA_SEDUCTION_1 = """莉莉娅若有所思地看了你一眼，她似乎明白了你的意图，但她没有立即拒绝这个提议。

— 你很奇怪。我不知道，我没有这方面的经验...""",
	LILIA_SEDUCTION_1_OPTION_1 = "我可以看到你在我身边瑟瑟发抖（性因素）",
	LILIA_SEDUCTION_1_OPTION_2 = "我有很多经验",
	LILIA_SEDUCTION_1_OPTION_3 = "我可以给你一些好东西",
	LILIA_SEDUCTION_1_OPTION_4 = "但你一定很好奇它是什么样子的",
	LILIA_SEDUCTION_2_2AND3 = "— 对不起，我想我还不想。",
	LILIA_SEDUCTION_2_4 = "— 呵呵，其他女孩都说了很多，但我还是不确定。你太大了...",
	LILIA_SEDUCTION_2_4_OPTION_1 = "但这不是你感兴趣的吗？",
	LILIA_SEDUCTION_2_4_OPTION_2 = "我可以很温柔",
	LILIA_SEDUCTION_2_4_OPTION_3 = "如果出现问题，我们总是可以修补",
	LILIA_SEDUCTION_2_4_2AND3 = "莉莉娅表现得好像这次谈话没有发生，然后沉默了。",
#	LILIA_SEX_SCENE_1_1 = """— 我想... 
#
#莉莉娅沉默了，似乎很矛盾，但最终看起来她失去了耐心。
#
#— 啊，好吧，谁知道什么时候还会有这样的机会呢？
#
#仙精快速环顾四周，确保没人注意，然后抓住你的手，把你拉到附近的灌木丛中。""",
	LILIA_SEX_SCENE_0 = """当莉莉娅听到你的建议时，她的嘴唇变成了顽皮的微笑。

— 当然！我担心你不会问。""",
	LILIA_SEX_SCENE_1 = """由于体型相差太大，仙精走近，抬头看着你。几分钟后，她在森林里绕了一圈，伸手抓住了你的手。她很快就把你带到了一个阴凉的壁龛里。

仙精现在到处乱跑，一束能量在移动这个和那个，甚至在你一开始不太确定她在做什么时调整树枝，但很快意识到她正在搭建自己的舞台；让一切都变得完美，至少在她眼里是这样。终于一切都解决了，莉莉娅转向你，满怀期待地看着你。

— 好的！一切都很完美！""",


	LILIA_SEX_SCENE_1_1 = """莉莉娅说完了这句话，因为她小心翼翼地移动了一根树枝来遮挡一点阳光，突然啪的一声，树枝落在了她的身边。几秒钟后，她叹了一口气，承认了这一点，然后移过去把它放回原处，但现在却被她的手抓住，向后拉，直到她的背对着你。

— 哦！我的意思是，如果你坚持我们可以把它留在那里...

当你的手向女孩的侧面滑动，解开她裙子上的胸针，露出她的胸部，两个小而柔软的土堆时，女孩似乎因为恐惧或兴奋而有点发抖。当女性把臀部向后靠在你身上时，她轻轻地叹了一口气，回答了你之前的问题，可能甚至没有意识到。

你们两个就这样呆了一会儿，当你把精致的布移到一边时，她气喘吁吁，轻轻地呻吟着，当你的手终于在她皮肤的热量上滑动时，她的乳房在你手里变得柔软，浑身湿透，下面的小孔很容易勾引到你的手指。

— 这比我的手指好多了... 带我 [name]. 请...""",
	LILIA_SEX_SCENE_1_2 = """The girl seems to shiver a bit by either fear or excitement as your hand slides up her side, undoing the broach on her dress to expose her chest now, two small but soft mounds. A soft sigh from the female answers your question before as she grinds her hips back against you, likely without even realizing it.

You two stay like this for a few moments, her panting and softly moaning as you move aside the delicate cloth, her breast soft in your hand as finally your hand slides over the heat of her sex, only to find her soaked, the tiny hole easily stretching to allow your fingers. 

— T-that's so much better than my fingers... Take me, [name]. Please...""", # MISSING TRANSLATION
	LILIA_SEX_SCENE_2 = """过了一会儿，你的裤子就打开了，当你开始磨那个可爱的小洞时，小阴蒂很容易就在你面前立起了。莉莉娅在这个过程中发出了一声轻柔的呻吟，然后当你开始压到她身上时，她发出了更大的尖锐呻吟，拉伸并迫使你撕碎了她的处女膜。

你慢慢来，在意识到让她靠在你的轴上反弹更容易之前，臀部向她倾斜，几乎比预期的更容易触底。就莉莉亚而言，她持续不断的猥亵声音只会驱使你走得更远，现在更难了。

她不是一个经验丰富的情人，但她的紧绷感和取悦他人的意愿有助于弥补这一点。偶尔，当女孩在你身上剧烈颤抖时，你不得不停下来，这让你不确定她是在阻碍你，还是只是因为你在她身上有多深而发抖。每次莉莉娅不得不停止这种方式时，她都会很快敦促你，告诉你现在要更加努力地对待她。""",
	LILIA_SEX_SCENE_3 = """交配持续了一段时间，然后你开始在她体内跳动，女孩已经在用力地喘着粗气，发出令人愉悦的小声音，然后当你开始在她的体内交配时发出狂喜的声音时，浸湿了她的内壁，填满了她的子宫。她在那里呆了一会儿，当她夹住你的阴茎夹住时，她的臀部在发抖，当她气喘吁吁时，她的肚子微微膨胀。

— ...不可思议，让我们改天再做一次，好吗？'""",
	LILIA_RECRUIT_1_1 = """— 嗯？我不知道，我觉得我对你不够了解, [name]。""",
	LILIA_RECRUIT_1_2 = """— 和你一起去…？啊，我不确定，我从来没有离开过森林。我听说人类很可怕。""",
	LILIA_RECRUIT_1_OPTION_1 = "我很想有你在我身旁（魅力因素）",
	LILIA_RECRUIT_1_OPTION_2 = "习惯就好",
	LILIA_RECRUIT_1_OPTION_3 = "人类可能很糟糕，但你会受到我的保护",
	LILIA_RECRUIT_1_OPTION_4 = "不过你不怕我",
	LILIA_RECRUIT_NO = "— 下次再说吧，我还没有准备好离开我的家。",
	LILIA_RECRUIT_NO_RED = """{color=red|失败}

— 下次再说吧，我还没有准备好离开我的家。""",
	LILIA_RECRUITED = """莉莉娅犹豫了一下，但她对你的态度最终动摇了她的选择。

— 好吧，我不想等你下次来。让我拿一些我的东西！""",
	LILIA_RECRUITED_GREEN = """{color=green|成功}

莉莉娅犹豫了一下，但她对你的态度最终动摇了她的选择。

— 好吧，我不想等你下次来。让我拿一些我的东西!""",
	LILIA_RECRUIT_1_4 = """— 呵呵，没错，你一点都不可怕。但我在那里该怎么办？""",
	LILIA_RECRUIT_1_4_OPTION_1 = """你可以成为一名表演者""",
	LILIA_RECRUIT_1_4_OPTION_2 = """先当个门客吧""",
	LILIA_RECRUIT_1_4_OPTION_3 = """冒险生活多姿多彩""",
	
	SICK_LILIA_START = """自从莉莉娅搬来和你住了几天后，有一天早上你发现她躺在床上非常虚弱。

— [name]... 我不觉得...好吧...我能…今天休息吗？

当你意识到她一定生病了，你的恐惧就烟消云散了。但你的担忧越来越严重，因为你尝试使用魔法或常规药物都无法改善她的病情。当你让她休息时，你决定去拜访一个可能知道发生了什么的人。在你所有的熟人中，梅尔似乎是最合乎逻辑的选择。""",
	SICK_LILIA_1 = """你向梅尔解释莉莉娅生病背后的事情，希望她能帮忙。对此，她的反应一如既往地无私。

— 野生仙精不适合生活在城市里，它们更依赖自然能量，这让这个地方就像生活在沙漠里，你和我都没有水。她需要时间让身体适应这些恶劣的条件。当然，圈养的仙精们已经适应了，不会遇到这样的问题。""",
	SICK_LILIA_1_OPTION_1 = "所以她会没事的?",
	SICK_LILIA_1_OPTION_2 = "我能帮她什么吗?",
	SICK_LILIA_2_1 = """— 很难说她的身体在这一点上是否能够自己应对。

— 有一种啤酒可以让她在没有家乡森林的情况下更容易地重建魔力储备。让我给你写一个食谱。""",
	SICK_LILIA_2_2 = """— 有一种酿造的啤酒可以让她在没有家乡森林的情况下更容易地重建魔力储备。让我为你写下一个食谱。""",
	SICK_LILIA_2_OPTION_1 = "多少钱?",
	SICK_LILIA_2_OPTION_2 = "非常感谢，你是真正的救世主",
	SICK_LILIA_3_1 = """— 我只给你写了一个配方，你是需要生产它的人。它也会让你离开我的办公室。

— 还有一件事...我希望你能有礼貌地在她处于这种状态时不要对她进行性虐待。""",
	SICK_LILIA_3_2 = """梅尔对你的赞美置若罔闻，把纸递给你。

— 还有一件事...我希望你能有礼貌地在她处于这种状态时不要对她进行性虐待。""",
	SICK_LILIA_3_OPTION_1 = "我永远不会那样做。",
	SICK_LILIA_3_OPTION_2 = "你当我什么人!?",
	SICK_LILIA_4_1 = """— 我希望如此。但你的名声并不像你暗示的那样完美，所以我觉得有必要提醒。既然我们谈完了，那么你该走了。""",
	SICK_LILIA_4_2 = """— 一个性变态者，你把一个纯野生的仙精从森林里拖了出来，基本上只有性上瘾者会这么做。""",
	SICK_LILIA_4_2_OPTION_1 = "不是那样的，纯属巧合，她想自己来",
	SICK_LILIA_4_2_OPTION_2 = "嘿，你不能怪我，这是任何男人都会做的事",
	SICK_LILIA_5 = """梅尔重重地叹了口气，示意你离开。别无选择，你离开了她的办公室。""",
	SICK_LILIA_6 = """当你走出梅尔的办公室，仔细阅读她的笔记时，你发现了指示你去"我的骗子妹妹"的那一行，意识到你必须为此拜访扎里。""",
	
	XARI_CLOTHES_1 = """— 嘿, [name]。有一段时间没见你了。梅尔又派你来跑腿了吗？""",
	XARI_CLOTHES_1_OPTION_1 = "我这里有这张纸条...",
	XARI_CLOTHES_1_OPTION_2 = "不太对",
	XARI_CLOTHES_2 = """当扎里翻阅纸条时，你解释说你需要某种药物。她很快就明白了。

— 是的，我可以酿造这个，没问题。幸好你来到这里，因为在城里你无法制造出如此纯净的物质。给我500金币。""",
	XARI_CLOTHES_2_OPTION_1 = "支付 (500 Gold)",
	XARI_CLOTHES_2_OPTION_2 = "我还没有钱...",
	XARI_CLOTHES_3_1 = """— 太好了，让我开始准备...""",
	XARI_CLOTHES_3_2 = """— 好吧，我就在这里。毕竟你不会花很长时间的。""",
	XARI_CLOTHES_4 = """当你把钱递给扎里时，她开始在杂乱的货架上搜寻。

— 你知道...你在治疗一个仙精，对吗？既然这无论如何都需要一些时间，不如你为我做点什么，我会让它更特别一点？

— 几天前，有一个巨魔偷走了我正在烘干的一些衣服。我本来打算去教训他，但你能做到，不是吗？然后我可以使这种药剂更有效一点。

— 由于仙精们天生就喜欢魔法，所以每隔一段时间就要她们喝药。我可以让她变得更聪明、更忠诚或更淫荡。""",
	XARI_CLOTHES_4_OPTION_1 = "我宁愿放弃这项任务",
	XARI_CLOTHES_4_OPTION_2 = "好吧，让她更聪明（+智慧因素，+魔法因素）",
	XARI_CLOTHES_4_OPTION_3 = "好吧，让她更忠诚（+驯服因素）",
	XARI_CLOTHES_4_OPTION_4 = "好吧，让她更淫荡（+性因素）",
	XARI_CLOTHES_5_1 = """— 好吧，那我自己去拿。那就等一下，这不会花很长时间...""",
	XARI_CLOTHES_6 = """— 完成了。别一次性喝完。她应该在几天后有所改善。

扎里递给你一个装满液体的小药瓶，然后把你打发走。""",
	XARI_CLOTHES_5_2AND3AND4 = """— 好吧，那家伙离这里不远。你回来的时候我可能就完成了，所以去教训那个野蛮人吧。""",
	
	TROLL_CLOTHES_1 = """当你按照扎里的指示到达洞穴时，你很快就会发现它的居民还没有攻击你。

— 你...来碎布...

从他说普通语言的拙劣尝试中，你意识到他知道你来这里是为了什么。众所周知，巨魔的嗅觉很强，所以他很可能知道你去过扎里的住处。

— 交易...食物...

看起来巨魔愿意放弃他的战利品来换取一些可食用的东西。""",
	TROLL_CLOTHES_1_OPTION_1 = "给他50块肉（-50块肉）",
	TROLL_CLOTHES_1_OPTION_2 = "告诉他你在来这里的路上发现的鹿的放牧点（猎人）",
	TROLL_CLOTHES_1_OPTION_3 = "我不与肮脏的怪物交易（战斗）",
	TROLL_CLOTHES_1_OPTION_4 = "离开",
	TROLL_CLOTHES_2_1 = """你设法换到了衣服，这些衣服看起来比烘干前干净得多。希望这不会让她太失望，你决定不管这个巨魔。""",
	TROLL_CLOTHES_2_2 = """你几乎无法向巨魔解释，但巨魔理解你。虽然有点怀疑，但他还是把衣服交出来了。也许是你运气好，他没有经常被别人骗。""",
	TROLL_CLOTHES_2_3 = """击败巨魔后，你设法找到了比预期更糟糕的扎里的衣服。但既然你击败了巨魔，至少她应该很高兴这种情况不会再发生了。""",
	
	XARI_CLOTHES_7 = """当你把扎里的衣服递给她时，她看起来没有什么反应。然而，她按照约定继续履行自己的部分交易。

— 给。别一次性全喝了。几天后她应该会好转。

她递给你一个装满液体的小药瓶，然后送你走.""",
	
	LILIA_MANSION_1 = """你终于给莉莉娅带来了你花了整整一个晚上才得到的药水。仔细检查，你不在的时候，她的病情似乎没有恶化或好转。当你给她服用药水时，这个女孩太虚弱了，无法反对，味道显然很难闻。""",
	LILIA_MANSION_2 = """现在的情况已经解决了，你终于可以自己休息了。

几个小时过去了，你在房间里睡得很安稳，尽管在某个时刻，你觉得你的腿很冷。当你睁开眼睛看到莉莉娅开始把内裤往下滑，把她的身体向上压到你身上时，你才惊觉这不是梦。

— [Master]，很抱歉我有点饥渴，但我真的很想念这个...""",
	LILIA_MANSION_3 = """你还没有完全清醒，你不知道该怎么办，小仙精现在开始折磨你了。只花了几分钟，她的花瓣就在你的身体上摩擦了一阵子，变得光滑湿润而且准备好了，在愉快的小呻吟声中气喘吁吁。她给你留下深刻的印象，然后你又会感到好奇，因为小仙精似乎并没有因为她的行动而感到疲劳，如果有什么不同的话，她看起来更饥渴了。”。

几分钟后，当她站起来，把温暖的身体滑到你的阴茎上时，她的声音越来越大。她的臀部轻轻地移动，然后发出愉快的呜呜声，仙精停下来看着你，咕咕叫着，她开始慢慢地弹起她的臀部，随着时间的推移变得更具攻击性。你开始怀疑自己是否反应过度了，当然她以前不可能病得这么重，能够如此咄咄逼人地驾驭你。

莉莉娅的呻吟是无拘无束的，这些声音使她更加性感，因为她为你服务得很好；让你很难满足释放的需求。""",
	LILIA_MANSION_4 = """用力几分钟后，她身上开始出汗，而你的手紧紧地放在她的腿上，只需片刻就可以释放。尽管过了一会儿，你就无法控制自己了。当你填满她子宫的每一个缝隙时，小仙精现在正把自己压在地上，紧紧地抓住你的阴茎。

— 啊...这感觉太好了...[Master]! 我要高潮了!

当你感觉到莉莉娅夹住你的阴茎时，她几乎尖叫起来，小麻烦重重地压在你身上，她的眼睛模糊了；她的腿在高潮过程中几乎在抽筋。她融化在你的胸口，当她咕咕叫和颤抖时，小高潮再次袭击了她。""",
	LILIA_MANSION_5 = """莉莉娅在那里坐了一会儿，现在正沉浸在幸福的呼吸中，她小小的身体在颤抖，然后才向前倒在你的胸口。小仙精躺在那里试图喘口气，显然已经筋疲力尽了。

几分钟后，你会注意到这只小雌性正在睡觉，躺在那里，她甚至偶尔还会发抖。你注意到应该给她保暖，所以你决定今晚让她和你睡觉，你把她放在你旁边。""",
	
	CALI_ACT1_1 = """卡莉，你去看望你的俘虏。当你沉默地站着时，女孩抬头看着你，眼睛后面带着疲惫的愤怒。

— 你现在想要什么！？...你做得还不够吗？！滚开！

盯着她看，你仔细看她。她瘦削遍体鳞伤，身体不适合劳动，但她必须靠自己谋生。

— 你认为我会为你工作吗？在你做了那些之后？""",
	CALI_ACT1_1_OPTION_1 = "不工作的人不得进食。",
	CALI_ACT1_1_OPTION_2 = "你肯定不想被卖给奴隶主吧？你的新主人会远没有那么善良。",
	CALI_ACT1_1_OPTION_3 = "也许你需要另一个提醒，比如洞穴里的提醒？",
	CALI_ACT1_2_1 = """卡莉低着耳朵看着你，转移视线。她的眼睛环视着房间，接受着她现在所处的一切。

— 不管怎样，好吧...""",
	CALI_ACT1_2_2 = """卡莉的眼睛变得冰冷，她似乎在用目光刺穿你。你和她说完话后，她点了点头，在她的剩余时间里什么也没说。""",
	CALI_ACT1_2_3 = """当你掐住女孩的喉咙时，女孩向前冲去，她的背部现在被牢牢地固定在房间的墙上。当女孩愤怒地看着你，她的手臂愤怒地向你挥舞时，泪水从她的眼中涌出。

— 你这个混蛋！我不是你的婊子！""",
	CALI_ACT1_2_3_OPTION_1 = """你当然可以被当作一个人对待，前提是工作。""",
	CALI_ACT1_2_3_OPTION_2 = """用心服务，或用心服务，卡莉。""",
	CALI_ACT1_3 = """女孩点头时泪流满面。现在她在履行新职责时不会和你打架。""",
	
	CALI_ACT2_GONE = """一天早上，你醒来时发现庄园的后门开着。当你去查看卡莉的情况时，发现她的房间空无一人，你的困惑是短暂的。发现门锁被撬开，你大声咒骂，因为她似乎在绝望中逃脱了。""",
	CALI_ACT2_1 = """当你在你的豪宅里完成日常事务时，你会发现卡莉正在执行你分配给她的艰巨任务。停下来查看她的工作，你发现她在工作中大汗淋漓。她的白衬衫变得潮湿，几乎湿透了。你观察了她一会儿，她的胸部也很好看。

你走近时，这个女孩看起来一点也不高兴。她疲惫的眼睛没有聚焦。

— 你在看什么，哈？！你还没看够吗？！""",
	CALI_ACT2_1_OPTION_1 = "我看我想看的地方，奴隶。",
	CALI_ACT2_1_OPTION_2 = "保持敌意，卡莉，当我再次带你登上极乐的时候，一切都会变得更甜蜜。",
	CALI_ACT2_1_OPTION_3 = "我只是喜欢这景色。",
	CALI_ACT2_2_1 = """卡利对你咆哮，她的眼睛里充满了仇恨。

— 你这个混蛋！我不是拴狗绳的狗！

当你离开她时，你会忍不住想起"拴着皮带的狗"这句话。""",
	CALI_ACT2_2_2 = """女孩挑衅地对你嗤之以鼻，而不是专注于她的工作。

— 我不是什么愚蠢的宠物，混蛋！

你让她继续工作，专心思考如何把她变成宠物。""",
	CALI_ACT2_2_3 = """卡莉的脸在回答时变成了血红色。她试图通过转身来隐藏它，但你已经看够了。

你决定暂时别管她。也许有什么东西可以让她更顺从你的意愿？""",
	CALI_ACT2_3 = """你的想法越来越集中在驯服你的新奴隶卡莉上。卡莉一直很难相处，这个女孩一心想拒绝你。经过仔细考虑，你得出的结论是，仅仅称她为你的财产是不够的。她应该扮演这个角色。”。

项圈是最合乎逻辑的第一步，但普通的项圈是不够的。你决定去工人行会问问西格蒙德，希望他可以给你专家的建议，这可能是个好主意。""",
	CALI_ACT2_WORKERS_OPTION_1 = "向西格蒙德咨询",
	CALI_ACT2_WORKERS_1 = """西格蒙德:— 什么？找人做项圈吗？市场上的还不够好吗？

你向矮人解释说，这些确实很好，但你要找的是一件定制的作品。这只魁梧的雄性在抓胡子的时候想了一会儿，然后点了点头。

西格蒙德: — 利姆罗夫就是你想找的人。在前台询问，接待员可以带你去他那里。

因为没有其他事情可以问西格蒙德，你让他继续管理行会的事务。""",
	CALI_ACT2_WORKERS_2 = """你向接待员提起这个名字，不久你就站在一个散发着强烈商人手工艺品气味的密室里。见到利姆罗夫，你会发现他是一只年长的黑暗精灵。他那双锐利的眼睛从他目前正在制作的优秀作品中抬起头来看着你。

利姆罗夫: — 我还没叫快递员。威廉大师的修理工作可以再等几个小时。""",
	CALI_ACT2_WORKERS_2_OPTION_1 = "我不是快递员，我是客户。",
	CALI_ACT2_WORKERS_2_OPTION_2 = "我是来为您提供服务的。",
	CALI_ACT2_WORKERS_3 = """黑暗精灵上下打量了你一会儿，然后点了点头。

利姆罗夫: — 啊，我错了。我能为你做什么？

你向利姆罗夫解释了你想为一个最近获得的奴隶委托制作一件定制作品的愿望。在你给了他所需的细节后，精灵认真地点头，然后在纸上描绘。然后他递给你两张草图。

利姆罗夫: — 我有两种设计可以参考。前者是正常水准，然而，外面的雕刻不会让人怀疑谁是你奴隶的主人。然而，后者，我一直渴望创作。这是一个更加精致的作品，肯定会引起一些人的注意。""",
	CALI_ACT2_WORKERS_3_OPTION_1 = "生产简单项圈需要什么？",
	CALI_ACT2_WORKERS_3_OPTION_2 = "生产奢华项圈需要什么？",
	CALI_ACT2_WORKERS_3_OPTION_3 = "我需要一些时间来思考这个问题",
	CALI_ACT2_WORKERS_4_1 = """利姆罗夫开始写下他需要你采购的物品清单，然后再将其交给你：10厚皮革""",
	CALI_ACT2_WORKERS_4_2 = """利姆罗夫开始记下他需要你采购的物品清单，然后再交给你：10厚皮革，10丝绸""",
#	CALI_ACT2_WORKERS_4_2 = """利姆罗夫制作了一份物品清单，其中最值得注意的是一块大宝石，并将其交给你，看起来相当兴奋。""",
	CALI_ACT2_WORKERS_4_1_OPTION_1 = "这是简单项圈的材料",
	CALI_ACT2_WORKERS_4_2_OPTION_1 = "这是奢华衣领的材料",
	CALI_ACT2_WORKERS_4_3 = """利姆罗夫: — 很好，我会在这里。

利姆罗夫陪你到行会门口。""",
	CALI_ACT2_WORKERS_5_1 = """利姆罗夫聚精会神地看了看材料和付款，然后点了点头。

利姆罗夫: — 啊，是的，这就行了。给我几天时间，我会让快递员送过去的。""",
	CALI_ACT2_WORKERS_5_2 = """利姆罗夫聚精会神地检查材料的每一个细节。最终，这名男子满意地拿走了付款和所需的部件，然后咧嘴笑着看着你。

利姆罗夫: — 非常棒，非常棒。很好，我会确保你的奴隶有一个其他人都会觉得苍白的项圈。给我几天时间，我会让快递员送过去的。""",
	CALI_ACT2_WORKERS_6_1 = """正如他所承诺的，利姆罗夫的快递员在约定的日子一大早就到了你家。看了看包裹，你检查了一下简单的项圈。虽然它的设计没有太多装饰，但工艺质量很好。至少它应该很舒适。""",
#	CALI_ACT2_WORKERS_6_2 = """正如他所承诺的那样，利姆罗夫的快递员在约定的日子一大早就到达了你的家。看着包裹，你仔细检查精致的项圈。利姆罗夫用这个项圈创造了一个杰作。曲线和细节都是完美无瑕的，每一个都经过了精心的处理。他创作的核心，大宝石，被打磨成镜面般的反射，然后向你闪闪发光。""",
	CALI_ACT2_WORKERS_6_2 = """正如他所承诺的那样，利姆罗夫的快递员在约定的日子一大早就到了你家。翻看包裹，你发现精致的衣领。利姆罗夫用这个衣领创造了一个杰作。曲线和细节都完美无瑕，每一个都经过精心处理。""",
	CALI_ACT2_LIMNROV = """利姆罗夫: — 我有两个设计建议。前者是你的标准设计，但外面的雕刻不会让人怀疑谁是你奴隶的主人。然而，后者，我一直渴望创作一个更精致的作品，一定会引起一些人的注意。""",
	CALI_ACT2_SIMPLE_COLLAR_1 = """第二天早上你拜访卡莉时。这个女孩很安静，但盯着你看时有点厌恶。

— 你想要什么？我一直在努力做得更好, [name].

你把简单的项圈拔出来，给女孩看。卡莉的眼睛最初显示出恐惧的迹象，然后是否认，女孩用力摇头，远离你。

— 你是认真的吗？你想让我穿这个！？""",
	CALI_ACT2_SIMPLE_COLLAR_1_OPTION_1 = "没有什么可害怕的，卡莉，这是所有权的常见标志。",
	CALI_ACT2_SIMPLE_COLLAR_1_OPTION_2 = "我不是在问，奴隶。现在按照我说的做，我需要发挥创造力。",
	CALI_ACT2_SIMPLE_COLLAR_2_1 = """卡莉坐在那里一动不动。她做了一个长而稳定的呼吸，然后稍微放松了一下姿势。当你把项圈戴在她身上时，她没有和你打架。过了一会儿，你把手放在她的头上。作为回应，她不舒服地颤抖着。

— 你以为我是什么宠物！？""",
	CALI_ACT2_SIMPLE_COLLAR_2_1_OPTION_1 = "宠物有人照顾，不是吗？",
	CALI_ACT2_SIMPLE_COLLAR_2_1_OPTION_2 = "宠物还是奴隶，哪一个听起来更好？",
	CALI_ACT2_SIMPLE_COLLAR_3 = """卡莉没有找到合适的回应，保持沉默。最后你让女孩放松一天，这样你就可以继续你的工作了。""",
	CALI_ACT2_SIMPLE_COLLAR_2_2 = """当新鲜的泪水流到地板上时，卡莉颤抖着。女孩的姿势似乎放松了，她的眼睛盯着前方，轻轻地颤抖着。这个女孩没有抗拒你，但从她的肢体语言中可以清楚地看出，如果她认为自己可以摆脱你，她会立刻逃跑。

项圈挂在脖子上后，卡莉看着你，脸上一片空白，但身体在颤抖。最后你让女孩放松一天，这样你就可以继续你的工作了。""",
	CALI_ACT2_EXQUISITE_COLLAR_1_1 = """第二天早上你拜访卡莉。女孩很安静，但盯着你看时有点厌恶。

— 你想要什么？我一直在努力做得更好, [name].

当你拔出项圈时，卡利的眼睛亮了起来。女孩看东西的时候眼睛紧紧地盯着它。

— 好漂亮...""",
	CALI_ACT2_EXQUISITE_COLLAR_1_2 = """你利用她对项圈的着迷来分散注意力，迅速将项圈套在脖子上。她惊慌了一会儿，双手抱着项圈，半心半意地想把它扯下来，然后放弃，不情愿地摩擦它。

— ...至少它很舒服。但不要认为这会改变什么！尤其是在你做了这些之后...

当女孩安静下来时，她的手本能地移向那颗宝石。她似乎很放松，因为她睁大眼睛欣赏它。你利用这一刻将自己的手放在她的头上休息。她的身体在你的触摸下变得僵硬，但她没有挣脱。""",
	CALI_ACT2_EXQUISITE_COLLAR_1_OPTION_1 = "这里没有土匪。没有人会对你下手。除了我。",
	CALI_ACT2_EXQUISITE_COLLAR_1_OPTION_2 = "你比我找到你时好多了。",
	CALI_ACT2_EXQUISITE_COLLAR_2 = """卡莉张开嘴，似乎要反驳你所说的话，但她停了下来。她最终耸了耸肩，承认了这一点。解决了这一问题后，你让这个女孩离开，让她承担自己的职责。""",
	
	CALI_ACT3_MAGIC_1 = """你的奴隶卡莉态度缓和，不再违抗你的命令。然而，卡莉一如既往地坚贞不渝。但你还是忍不住想品尝这个女孩，你陷入了僵局。

一天早上，卡莉走近你，显然很累。

— [name], 我想知道今天是否可以休息一下。

这个女孩看起来确实累坏了。很明显，在豪宅工作的生活比她过去更艰苦。考虑一下，你认为今天可以让她休息一下，现在似乎也是让她放松一下的好时机。""",
	CALI_ACT3_MAGIC_1_OPTION_1 = "当然，但我想让你举起衬衫作为交换。",
	CALI_ACT3_MAGIC_1_OPTION_2 = "如果你能为我服务的话",
	CALI_ACT3_MAGIC_1_OPTION_3 = "很好，就今天。",
	CALI_ACT3_MAGIC_2_1AND2 = """卡莉面无表情地看着你几秒钟，然后厌恶地皱起了脸。

— 你真是个变态！

在你做出回应之前，女孩在上班时半摔门就走了，显然她认为这是一个比满足你的基本需求更好的选择。""",
	CALI_ACT3_MAGIC_2_3 = """卡利看着你松了一口气，然后点了点头。

卡莉: — 好吧，嗯……谢谢。""",
	CALI_ACT3_MAGIC_3_1 = """想想当时的情况，你的思绪就乱了。你可以强迫女孩上床睡觉。这并不难，但似乎远没有那么令人满意。你最终决定一定要做些什么来动摇她。你想到支配者。你听说过可以影响他人思想的法师。也许法师可以帮助你。""",
	CALI_ACT3_MAGIC_3_2 = """一想到这种情况，你的思绪就会恍惚。你当然可以用一个咒语来打破她的想法，让她成为你意志的傀儡，但你的自尊心要求不同。然而，由于魔法有广泛而多样的用途，你决定问另一个法师。也许他们有你所缺乏的一些知识。""",
	CALI_ACT3_JEAN_START_OPTION = "向吉恩咨询",
	CALI_ACT3_JEAN_1 = """与吉恩交谈时，你向她深入解释了这个问题。女孩的鼻子皱了起来，好像她要说出一些不礼貌的话语，然后才意识到她为谁工作。

在最后问你一个问题之前，吉恩似乎仔细地收集了她的想法

吉恩: — 那为什么不再买一个呢？她并不是什么特别的人，只是一个混血狼人。""",
	CALI_ACT3_JEAN_1_OPTION_1 = "我越来越喜欢她了。",
	CALI_ACT3_JEAN_1_OPTION_2 = "我很享受挑战。",
	CALI_ACT3_JEAN_2_1 = """吉恩皱起鼻子，然后摇摇头，在她的脸很快恢复专业之前，给你一种厌恶的表情。很明显，她正要说些什么，但她的脸色比卡莉的还糟。

女孩想了想你的问题，最后给了你一个答案。

吉恩: — 你为什么不给兽人的项圈施魔法？

你停下来思考一下这个问题。没错，你不会考虑给她的项圈施魔法，因为这种魔法远远超出了你的专业领域。吉恩看着你，终于叹了一口气。

吉恩: — 你有点麻烦, [name]。你可以向法师行会寻求帮助，你知道...我想我也可以做这样的事，但你得给我拿点东西。我需要一种罕见的魔法精华。有一个地方你可以收集一些。它在精灵森林里，但对你来说应该没有问题。""",
	CALI_ACT3_JEAN_2_2 = """吉恩叹了口气，然后向你点了点头。

吉恩: — 你当然会这么说。见鬼

女孩想了想你的问题，最后给了你一个答案。

吉恩: — 你为什么不给兽人的项圈施魔法？

你停下来思考一下这个问题。没错，你不会考虑给她的项圈施魔法，因为这种魔法远远超出了你的专业领域。吉恩看着你，终于叹了一口气。

吉恩: —你有点麻烦, [name]。你可以向法师行会寻求帮助，你知道...我想我也可以做这样的事，但你得给我拿点东西。我需要一种罕见的魔法精华。有一个地方你可以收集一些。它在精灵森林里，但对你来说应该没有问题。""",
	CALI_ACT3_JEAN_3 = """你到了吉恩标记的地方，发现了一个微弱发光的水泉。你从里面舀了足够的水来满足吉恩的需求。""",
	CALI_ACT3_JEAN_3_OPTION_1 = "给予稀有魔法精华",
	CALI_ACT3_JEAN_4 = """成功交付所需试剂后，吉恩开始工作。在你以需要清洁的物品为幌子取回卡莉的项圈后，吉恩迅速对其施魔法。

吉恩: — 好了，完成了。无论你打算用它做什么卑鄙的事情，这都不会让佩戴者服从你的命令。这只会让他们更愿意...""",
	CALI_ACT3_JEAN_5 = """把项圈还给卡莉，当你再次把项圈扣在她身上时，女孩没有任何抱怨。""",
	CALI_ACT3_MAGES_OPTION_INIT = "询问改变心智的咒语",
	CALI_ACT3_MAGES_1 = """看来梅尔今天不能满足你的要求。在行会周围打听后，你最终发现一个学徒脸上带着无聊的表情来询问你。

学徒: — 驯服奴隶的辅助魔法？而且她非常抗拒你的示好。啊，是的，我们可以帮忙。就像是是她项圈的魅力？我们可以为你做一些类似的事情，但行会大师梅尔一直在收取额外的服务费。""",
	CALI_ACT3_MAGES_1_OPTION_1 = "我肯定买得起。",
	CALI_ACT3_MAGES_1_OPTION_2 = "多少钱?",
	CALI_ACT3_MAGES_2 = """年轻的法师拿出一张大图表，仔细看了一遍，然后告诉你服务将是500金。""",
	CALI_ACT3_MAGES_2_OPTION_1 = "很好，看来我没有其他选择（500金）",
	CALI_ACT3_MAGES_2_OPTION_2 = "有办法获得折扣吗?",
	CALI_ACT3_MAGES_2_OPTION_3 = "我晚点回来。",
	CALI_ACT3_MAGES_3_1 = """在你以需要清洗的物品为幌子取回卡莉的项圈后，学徒迅速将魔法应用到项圈上，同时拿走你的大量金币。

学徒: — 搞定了。你要知道这不会让她盲目顺从，只会更愿意按你的要求去做...

把项圈还给卡莉，当你再次把它扣在她身上时，女孩没有抱怨""",
	CALI_ACT3_MAGES_3_2 = """年轻的法师摇摇头。

学徒: — 绝对不行，行会首领·梅尔会摘下我的脑袋的！""",
	CALI_ACT3_MAGES_3_3 = """学徒: — 很好，你回来的时候我会在这里。""",
	CALI_ACT3_MAGES_4 = """学徒: 欢迎回来，你有足够的钱吗?""",
	CALI_ACT3_BLOW_OPTION_INIT = "和卡莉谈话",
	CALI_ACT3_BLOW_1 = """卡莉在过去的几天里一直很安静，尽管你发现她一有机会就偷偷地看你一眼。在她不知道的情况下，这种魔法似乎做得很好，女孩的决心慢慢减弱。

最终，你质问那个女孩在偷看你，结果她的脸变成了暗红色。

— 什么？我没有盯着你看。我只是不喜欢你和我在同一个房间里。

你现在什么也不说，只是让女孩说话。当她继续脸红时，你的目光锁定在她身上，她的沮丧显而易见。

— 我现在正在休息！你想从我这里得到什么?!""",
	CALI_ACT3_BLOW_2 = """在和你对峙之后，卡莉紧张地看着你，当你让她跪向地板时，她的动作有点过于急切。当女孩跪在你面前时，每一步看起来都很矛盾，但无法拒绝。

当你在她面前打开你的裤子时，她大口吞咽唾沫，说话时浑身发抖。

— 很-很好...你这个变态...就这一次!""",
	CALI_ACT3_BLOW_3 = """卡莉一开始什么也没说，她跪下来，现在抬头看着你。她的脸上布满了尴尬的红晕。尽管如此，当她解开你的裤子时，她没有抱怨，当她看到你的阴茎时，她的脸更黑了。

— 什么...它比我记忆中的要大。""",
	CALI_ACT3_BLOW_4 = """卡莉在评论了你的尺码后，看到你脸上的淫荡表情，有点翻白眼。

— 够了！不要把这当成赞美。""",
	CALI_ACT3_BLOW_5 = """女孩把手绕在你的阴茎上，低头看着它，手指轻轻地绕着底部。一旦它的尖端膨胀，她就会退缩，但看上去有点期待。

你考虑过让女孩快点，但当她终于开口时，你软化了态度。她开始很好地吮吸头部，她的手上下跳动，然后抬头看着你，观察你的反应。""",
	CALI_ACT3_BLOW_6 = """卡莉只犹豫了一会儿，然后将她的脸向下压到你的阴茎上。她用力爱抚顶部几次，嘴唇在你的阴茎上上下滑动，然后用手顶起你的阴茎，同时她的嘴还在吸顶部。""",
	CALI_ACT3_BLOW_7 = """卡莉在重复这个过程时似乎很渴望，她的臀部前后摆动了一会儿，然后她停了下来。她加快了双手的速度，注意到随着你越来越近，阴茎在跳动。她睁大眼睛抬头看着你，当你开始高潮时，她天真的脸把你推到了边缘。 """,
	CALI_ACT3_BLOW_8 = """当你射到女孩的嘴里时，卡莉发出了一声惊讶的小吱吱声，当你射完的时候，她的眼睛睁得大大的。令你惊讶的是，她没有抽开，开始吞咽每一滴，尽管她的脸随着每一次吞咽都变成了更深的红色。
你们两个在那里坐了一会儿。卡莉什么也没说，突然站起来，把目光从你身上移开；她的脸涨红了。 """,
	CALI_ACT3_BLOW_9 = """— 我…我要回去休息了...

卡莉没有给你任何回应的时间。当你坐在那里的时候，她几乎要跑出房间了，她所做的工作给人留下了深刻的印象。""",
	CALI_ACT4_MERCHANT_START = """事实证明，附魔的质量非常好，但你不禁想知道是否还有更多的事情可以做。卡莉愿意献出自己的嘴，但阻力仍然存在。

考虑到你的困境，你决定在城里购物时仔细思考这个想法。也许其中一个商人会有什么可以帮助你？""",
	CALI_ACT4_MERCHANT_1 = """阿利隆市场的摊位上排列着一排排玩具、食物和异国情调的奢侈品，但似乎没有一个非常适合你当前的需求。当你在其中一个摊位吃午饭时，食品车对面的一位书商引起了你的注意。

商人很快发现有人在盯着他的商品。他向你挥手，大声喊道。

商人: — 你好，先生！我看你对商品很有眼光。也许你想要一本关于如何享受天使身姿的大部头书，或者 -

如果你不阻止商人，他似乎会喋喋不休。""",
	CALI_ACT4_MERCHANT_1_OPTION_1 = "我随便看看",
	CALI_ACT4_MERCHANT_1_OPTION_2 = "你有关于狼人的书吗？或者混血狼人的书？",
	CALI_ACT4_MERCHANT_2_1 = """商人带着会心的微笑看着你，摇着头。

商人: — 啊，但你看起来不是一个随便浏览的人的样子。告诉我，你需要什么，先生?""",
	CALI_ACT4_MERCHANT_3 = """没办法，你告诉商人你在市场上买一本关于狼人或它们的混血儿的书。

商人: — 啊，是的，是的。我确实有类似的东西。

这个男人把手伸到手推车的一个架子上，递给你一本小册子，不比你的拇指厚。快速浏览一下它的内容，就会发现这是一本关于狼人交配习惯的书。

虽然这本书本身并没有那么大，但信息是广泛的。列出了支持驯服的论点，她最适合的性姿势的插图，甚至还有一节关于最佳实践的内容。

这本书的标价是区区50金。""",
	CALI_ACT4_MERCHANT_3_OPTION_1 = "我买了 (50 金币)",
	CALI_ACT4_MERCHANT_3_OPTION_2 = "我还不太确定",
	CALI_ACT4_MERCHANT_4_1 = """商人微笑着拿走了你的金币。离开你去管理他的手推车，你现在回家，急切地想看看这会如何发展。""",
	CALI_ACT4_MERCHANT_4_2 = """当你离开时，该男子点了点头，然后转向另一位顾客。""",
	CALI_ACT4_MERCHANT_5 = """这个男人现在热切地欢迎你，当你从书架上挑选关于狼人的书时，他会向你提出问题和建议。""",
	CALI_ACT4_MERCHANT_6 = """回家后，你把书留在卡莉的房间里。也许对她同类交配习惯的一些启发会软化她的想法。""",
	CALI_ACT4_MAST_1 = """决定去看看卡莉，你走到她的房间，听到门那边传来轻柔的叹息声。""",
	CALI_ACT4_MAST_2 = """悄悄接近，你尽可能地保持沉默，尽管现在唯一能听到的声音是从她的房间里传来的轻柔的惊呼和呻吟声。走近一点时，你确实能听到卡莉的声音在颤抖。你往里面看，看到女孩躺在床上，旁边开着书，一只手放在裤子里。当卡莉的声音平静下来时，她翻身又看了看书。..

无论书中的图像如何激发了她的需求，似乎都重新点燃了它，女孩说话时声音颤抖，气喘吁吁,

— 为什么...我在做这个...

卡莉继续阅读了一会儿，当她再次触摸自己时，终于引起了一声轻柔的呻吟。当她被迫捂住嘴以防止大声呻吟时，她的臀部微微隆起。最后，她又看了一遍页面，调整好自己，继续提高自己摩擦的速度；她的臀部现在在扭动。 """,
	CALI_ACT4_MAST_3 = """— 我可能喜欢这样...

卡莉继续手淫，偶尔看着书，一边轻轻地呼吸和呻吟。最后，当她高潮的时候，她抓住了自己，脸埋在枕头里，发出了一声尖叫。""",
	CALI_ACT4_MAST_3_OPTION_1 = "进入",
	CALI_ACT4_MAST_4_LEAVE = """你悄悄地离开，让她沐浴在高潮的余晖中，欣赏她的行为变化。看起来卡莉的抵抗力开始减弱，她的自然冲动开始占据主导地位。""",
	CALI_ACT4_MAST_4 = """当你走进来时，卡莉发出尴尬的吱吱声，她的脸变成了血红色。

— [name]! 你-你在这里干什么！

你现在什么也不说，只给卡利一个会心的微笑。你让她在言语上绊倒了，因为很明显她被当场抓住了。

— 变态...

卡莉现在把目光从你身边移开，与其说是生气，不如说是尴尬，她的脸仍然红得很厉害。""",
	CALI_ACT4_MAST_4_OPTION_1 = "卡莉，豪宅里的每个人都能听到你的声音。",
	CALI_ACT4_MAST_4_OPTION_2 = "情欲不应在合适的时候抗拒？你为什么不给我看看你在做什么？",
	CALI_ACT4_MAST_5 = """卡莉现在很快就把自己裹在毯子里，脸上的红晕变暗了，她喃喃自语地说出了一个几乎听不见的回答，甚至连脸都看不见了。

— 我忍不住...

当你在床上向女孩靠近时，她只会脸红。她把目光移开，脸上全是红色，当你把她的毯子扔到一边时，她呜咽着，把她裸露的身影留在你的脚下。

— 等-等等，我不是...

当你打开裤子，把她裸露的身体向后推时，女孩的眼睛睁得大大的，惊叹于你的长度。当你提起她的衬衫，露出她的小乳房时，会听到一声轻微的吱吱声。""",
	CALI_ACT4_FUCK_1 = """当你的阴茎摩擦到女孩紧紧的入口时，卡莉什么也没说，只是在你推到她身上时以呻吟作为回应。眼睛向后翻，女孩所能做的就是当你一次又一次地深入她的身体时呻吟和呜咽。她的身体很明显地随着她的需要而颤抖。

当你在她身上驰骋时，看到这个十几岁的女孩扭动的画面是完美的。她乐意为你服务，甚至很热情。很快，随着你的高潮迫近，交配变得更加艰难，当你向她推进时，你紧紧抓住她的臀部。  
""",
	CALI_ACT4_FUCK_2 = """— 对-就是那里...

当女孩达到高潮时，她的身体最终变得僵硬，当你很快加入她的行列时，一声诱人的小呻吟从她的喉咙里冒出来。卡莉没有抗议，因此你把自己深深地埋在她身上，你的精液充满了这个小小的青少年。

之后，卡莉保持安静，你把她拉出，从床上下来，朝门口走去。当你最后一次看她的身体时，女孩一动不动地躺着，气喘吁吁，当你确保关上身后的门时，你嘴唇上带着傻笑。""",
	CALI_ACT4_MAST_6 = """卡莉看着你，脸还是红的，还是那本书。很明显，她在做什么，一幅画得很好的插图，画的是一只长的很像你的雄性从后面插进一只半狼里。她把书合上，默默地塞在枕头下。

看着你，然后她把书藏在哪里，她终于软化了态度，把封面移到一边，向你展示她最近高潮时浑身湿透的阴部。

— 那-那里！快乐？你再也不能-""",
	CALI_ACT4_MAST_7 = """当你在她身上移动时，她的话会被打断，她的小身体被完全压下。当你把她压住时，卡利没有和你打架。如果和之前有什么不同的话，女孩会自愿移动到你想要她的地方。

— 等-等等，我不是...

当你打开裤子，把她裸露的身体向后推时，女孩的眼睛睁得大大的，看到你的长度。当你提起她的衬衫，露出她的小乳房时，会听到一声轻微的吱吱声。""",
	CALI_ACT5_PET_START = """卡莉最近表现得出奇的宽容。虽然她并不急于服务，但女孩的训练进行得很好，即使你对此大多很微妙。尽管如此，她仍然没有变成一只合适的宠物，这是你想要补救的。

你考虑了你的选择，尽管她现在很可能会接受你的要求，但你决定是时候进入下一步了。

下定决心，你当天下午离开庄园，为你的 "宠物" 寻找合适的配件。""",
	CALI_ACT5_PET_1 = """宠物店闻起来像……嗯，动物的气味。当你经过一排排从大狗项圈到手工制作的食物时，你不太确定自己的期望是什么。当你转过街角时，一个景象映入你的眼帘，一名员工和一只狗走在过道上。狗在命令下停下来，坐在命令下，甚至看起来很想这样做。”。最终，猎犬的工作得到了食物的奖励，一个狗盘被放下，野兽狂热地从中吃掉。""",
	CALI_ACT5_PET_2 = """狗的服从令人印象深刻，所以你决定向员工询问这件事。

员工: — 我是怎么让他表现得这么好的？好吧，你自己看看。

这只狗很饿，但显然没有到饥肠辘辘的程度，因为它的骨头上有充足的肉。

员工: — 他知道，如果他按照别人说的去做，他就可以吃东西了。毕竟，食物是一种巨大的动力。

你感谢这位员工的洞察力，然后返回你的豪宅，利用新发现的知识。""",
	CALI_ACT5_PET_3 = """今天你确保卡莉的早餐和午餐都很少。除此之外，女孩今天的劳动特别繁重，这是食欲旺盛的完美组合。在正常工作一天后，你最终在晚餐开始前叫卡莉。

女孩照例来了，尽管她看起来对前景一点也不满意。

— 能等一下吗, [name]? 现在是晚饭时间，我饿了...

过了一会儿，你把她的晚餐放在你旁边的狗碗里。她的眼睛带着沮丧的表情向你走来，但很明显，当她低头盯着碗里的食物时，她的饥饿感正在增强。 """,
	CALI_ACT5_PET_3_OPTION_1 = "我这里有你的食物。",
	CALI_ACT5_PET_3_OPTION_2 = "我觉得你应该在这里吃，卡莉。像个乖女孩。",
	CALI_ACT5_PET_4 = """卡莉抬起头来看着你，有点震惊，然后拒绝了。很明显，这个女孩可能以为你在用她的食物强迫她做什么。

— 我…不为什么？我会看起来像动物...这太奇怪了!""",
	CALI_ACT5_PET_4_OPTION_1 = "你为什么这么担心自己的长相？",
	CALI_ACT5_PET_4_OPTION_2 = "我认为耳朵和尾巴比你吃的更重要。",
	CALI_ACT5_PET_4_OPTION_3 = "是这个，否则你会饿的，卡莉，做出你的选择。",
	CALI_ACT5_PET_5_1 = """— 我觉得我正在失去自己……只是变成你希望我成为的样子...""",
	CALI_ACT5_PET_5_2 = """卡利尴尬地看着你，耳朵低垂。

— 嘿，这并不是我的错...""",
	CALI_ACT5_PET_5_3 = """卡莉现在看了很长一眼碗，你的最后通牒显然触动了她的神经。下巴竖起来，女孩很快转身走了出去。也许你应该稍后再试。""",
	CALI_ACT5_PET_6 = """在几乎不知情的情况下，卡莉向碗走得更近了。她的胃显然对这个问题产生了影响。""",
	CALI_ACT5_PET_6_OPTION_1 = "你不饿吗?",
	CALI_ACT5_PET_6_OPTION_2 = "如果你尝试一下，你可能会喜欢它。",
	CALI_ACT5_PET_6_OPTION_3 = "你这个忘恩负义的小婊子，照你说的做……现在！",
	CALI_ACT5_PET_7_GONE = """当卡利走到碗旁，像别人告诉她的那样坐下来吃东西时，她的脸对你来说变得很冷。当你瞥见有东西朝你走来时，你正在思考你最终是如何打碎女孩的，当食物碗从你的额头上弹开时，一声巨大的撞击声响起。

— 我不是你的婊子，你这个怪物！

物体与你的脸相撞，让你眼花缭乱，吓了一跳，当你意识到发生了什么时，女孩手里拿着你的钥匙，正从大宅的前门逃走。

也许这对她来说太过分了...""",
	CALI_ACT5_PET_7 = """卡莉看着你一会儿，饥饿感消失时浑身发抖。女孩一边看着你，一边去捡起碗，然后你拦住了她。当她意识到自己必须像动物一样吃掉食物时，她的脸因尴尬而发红。

女孩四肢着地跪下，在碗的上方徘徊。当她品尝食物时，她的屁股微微抬起。很快，她就屈服于自己的本能，大快朵颐。""",
	CALI_ACT5_PET_8 = """她的内裤在吃东西的时候明显是湿的。当你坐在喂宠物的旁边时，你的手放在她光滑的内裤，把手指滑到她的背上，她发出呻吟声。卡利停止了她的进食，向后看去，一股深色的红晕爬到了她的脸上。

卡莉: — [Name], 你在做什么?

轻轻地摸一下下巴，这是女孩得到的全部回答，无声地提醒她吃完饭。卡利明显地试图保持冷静，但在抚摸胯部和已经确立的兴奋之间，她无法长时间专注于用餐。

卡莉: — 等-等等那不是-""",
	CALI_ACT5_PET_9_1 = """当你的手滑入女孩的内裤时，女孩的话被一声低沉的呻吟打断了，当你的手指继续进一步探索她以刺激她时，很容易找到她湿透的阴蒂。脸一刻比一刻恍惚——没过多久，她就会完全失去注意力，当她快速接近高潮时，她的臀部几乎嗡嗡作响。

卡莉: — Nhhh...

当女孩接受你的爱抚时，她收回了她的抗议，最后，当她的腿紧紧地搂着你的手，她浸湿了内裤时，她弯起了腰。当她几乎瘫倒在碗上时，喉咙里传来刺耳的叫声，她不专注的眼睛望向远方。""",
CALI_ACT5_PET_9_2 = """— 为什么... 感觉还好...?

卡利似乎很矛盾，然后叹了一口气，当你的手滑过她的头发时，她的身体在地板上放松。她似乎已经完全忘记了最初的怨恨。

当你把手放在女孩的背上和肩膀上时，她不会和你打架。她的头垂下来沉思，你几乎听不到她在说什么。

— 我喜欢... """,
	CALI_ACT5_PET_9_OPTION_1 = """没那么难，是吗？""",
	CALI_ACT5_PET_9_OPTION_2 = """好女孩。现在坐下。""",
	CALI_ACT5_PET_10_1 = """卡莉只是坐在那里，摇了摇头，脸涨得通红。你的手摩擦着她的头顶，抚摸着她。整个晚上都在抚摸她，她急切地靠在抚摸中，放松下来。""",
	CALI_ACT5_PET_10_2 = """卡莉一开始甚至没有意识到这一点，她的表情有些震惊，因为她不敢动。你的手摩擦着她的头顶，轻轻地抚摸着她。当你花了一晚上的时间抚摸她时，她很快就靠在你的抚摸中，放松下来，然后获得一天假期。""",
	CALI_ACT6_NAKED_1 = """就像前一天一样，今天卡莉在你的房间里和你见面。这一次女孩看起来更放松了，昨天的饭让她精神振奋。

— 我今天是个好宠物...

女孩说，期待地看着你，然后低头看碗。当她看到更多的东西时，她的眼睛睁大了。""",
	CALI_ACT6_NAKED_1_OPTION_1 = "卡莉，你一直是个好女孩，但你可以做得更好。我想让你今天吃饭时脱衣服。",
	CALI_ACT6_NAKED_1_OPTION_2 = "好宠物不穿衣服，对吗？",
	CALI_ACT6_NAKED_1_OPTION_3 = "不够好，卡莉，我想让你裸体，而你这次吃饭是为了弥补。 ",
	CALI_ACT6_NAKED_2_1 = """卡莉犹豫了一下，但她的决心已经碎了。女孩脱下衣服，在你旁边吃东西。""",
	CALI_ACT6_NAKED_2_2 = """卡莉看了你一眼，然后又看了她的衣服。她想反抗，但停了下来，考虑了什么，然后脱下衣服。女孩脸红了，但没有进一步反对，跪在你旁边吃饭。""",
	CALI_ACT6_NAKED_2_3 = """当你现在责备卡利时，她的眼睛里流露出一丝泪水。

— 对你来说，没有什么是足够好的...

卡莉把你留在那里。很明显，你的话伤害了她的感情。""",
	CALI_ACT6_NAKED_3 = """在吃东西的时候，女孩对你的眼睛在她身上移动没有任何抱怨。很明显，她的入口已经湿透了，当她的屁股诱人地举到空中时，她变得更湿了，无论她是否意识到这一点。""",
	CALI_ACT6_NAKED_4 = """当女孩快吃完饭时，你决定现在是她向你表达对食物的感激之情的时候了。

手从她裸露的屁股上滑下来，她什么也没说，但你只需要听到轻柔的吱吱声和轻微的呻吟声。当你的手往下滑，摩擦着她温暖的花瓣时，光滑的感觉让你享受的不仅仅是触摸。

当你在卡莉身后移动时，她的眼睛睁大了，当你用另一只手紧紧抓住她的臀部时，解开你的裤子。""",
	CALI_ACT6_NAKED_5 = """— 你-你在做什-

当你深入女孩的身体，你的身体向下压入她紧绷的阴部时，女孩的问题被打断了。卡莉没有和你打架，只是发出了一声长长的呻吟，当你开始向她抽打时，她的身体在你的控制下颤抖。

很快，卡莉也加入了对你阴茎的推搡，她需要将臀部推回你的臀部。当她无言地恳求你更努力地对待她时，她无法满足的需求占据了主导地位。她显然需要释放，而你感觉你们俩都很亲密。""",
	CALI_ACT6_NAKED_6 = """最后，你开始给女孩灌饱肚子，当她大声呻吟时，你的胸脯深深地压在她身上。当她压住你的老二时，你们两个都即将高潮时。半狼拒绝了，但无法挣脱你对她的控制，因此她热切地接受每一滴。

— 我…呃...我会成为一个好女孩...

当你还在享受时，你提醒她，她应该叫你什么。当她在你身下颤抖时，你的手仍然紧紧抓住她的臀部。

— [Master]... 我会成为一个好女孩, [Master]...""",
	CALI_ACT6_NAKED_7 = """训练结束后，卡利像以前一样坐在你身边。她的眼睛盲目地看着你。""",
	CALI_ACT6_NAKED_7_OPTION_1 = "好女孩",

	
	HALLOWEEN_EVENT_INTRO = """{color=magenta|西菲拉: — 欢迎, [Master]. 我想这是我们的新…演出？在这样的时间和日子里，这是一场让你娱乐的小戏剧。我被选中来讲述它。所以，放松一下，享受我们的小故事。 }

{color=magenta|西菲拉: — 今天我将讲述一个戴着红色头巾的年轻女孩的故事和她的悲惨故事。}""",
	HALLOWEEN_EVENT1 = """{color=magenta|西菲拉: — 一个年轻的女孩正在穿过森林。一片又深又黑的森林，手里拿着一个篮子，里面装着肉包子给她体弱多病的祖母。 }

{color=aqua|阿纳斯塔西娅: — 这真的很尴尬，我不应该同意来做... }

{color=magenta|西菲拉: — 尽管她很年轻，很害怕，但她仍然勇敢地开始了这项任务。她不知道等待她的是什么危险。}""",
	HALLOWEEN_EVENT2 = """{color=aqua|阿纳斯塔西娅: — 这不是关于一个女孩被狼吃掉的故事吗？！为什么是我...}

{color=magenta|西菲拉: — 如果她遇到一些坏人，她只能指望自己的天真在这里发挥作用。不幸的是，她确实遇到了他们。几个土匪看到她独自穿过树林，很快就向她靠近。}""",
	HALLOWEEN_EVENT3 = """{color=gray_text_dialogue|土匪: — 哇哦，漂亮的小姐，你要去哪里?}

{color=aqua|阿纳斯塔西娅: *咕噜* — 我要去我生病的奶奶那里，我要给她带肉包子...}

{color=gray_text_dialogue|土匪: — 哇，你听到了吗？一个女人和送餐员，二合一！你一定听说过我们所以穿着这样来这里吗?}

{color=aqua|阿纳斯塔西娅: — 我-我不明白你的意思。求你了，让我走...}

{color=gray_text_dialogue|土匪: — 不，这显然不行。如果你为我们做点什么，我们会考虑的。展示你巨大的乳房怎么样?}""",
	HALLOWEEN_EVENT4 = """{color=aqua|阿纳斯塔西娅: — 不，放开我，把手从我身边拿开！这到底是怎么回事?!}

{color=gray_text_dialogue|土匪: — 保持安静，傻女孩，在这些黑暗的树林里没有人能帮你!}

{color=magenta|西菲拉: — 如此悲伤的景象会让任何英雄都急于救她，但救援来自她意想不到的来源。}""",
	HALLOWEEN_EVENT5 = """{color=yellow|卡莉: — 你们这些混蛋干什么！？我、 土匪惩罚者，我的意思是，大灰狼会让你受惩罚的!}

{color=yellow|卡莉: — Ryaaaaa!}

{color=gray_text_dialogue|土匪: — 哇——啊！不，不要杀了我们!}

{color=magenta|西菲拉: — 作为一头真正的野兽，狼扑向那些害怕被吃掉而逃跑的土匪。 }""",
	HALLOWEEN_EVENT6 = """{color=aqua|阿纳斯塔西娅: — 哇，你穿那个真的不丢人吗？.. }

{color=yellow|卡莉: — 你是什么意思？我是一只狼，这就是我的样子。 }

{color=aqua|阿纳斯塔西娅: — 也许我太害羞了...}

{color=yellow|卡莉1: — 没关系，人类女孩。喂，你在我的树林里干什么?}""",
	HALLOWEEN_EVENT7 = """{color=magenta|西菲拉: — 狼对她从未见过的女孩表现出了兴趣。不管是好是坏，这个女孩一直很真诚。}

{color=aqua|阿纳斯塔西娅: — 我要去看望我奶奶。}

{color=yellow|卡莉: — 你为什么要那样做？年轻女孩独自旅行很危险。 }

{color=aqua|阿纳斯塔西娅: — 我知道，但是我要给她带一些肉包子。}

{color=yellow|卡莉: — 啥，肉包子！？哦，这我不能放过！}""",
	HALLOWEEN_EVENT8 = """{color=yellow|卡莉: — 那些肉包子，一定很好吃吧？给我看看，我想看看！}

{color=aqua|阿纳斯塔西娅: — ...他们在这个篮子里... }

{color=aqua|阿纳斯塔西娅: — 啊，它是空的...是土匪趁我不注意把他们带走的吗?}

{color=yellow|卡莉: — 我说我想看看肉包子，我能闻到它们的味道。你想骗大灰狼吗?}

{color=yellow|卡莉: — 行吧，我必须好好的搜你的身! }""",

	HALLOWEEN_EVENT9 = """{color=aqua|阿纳斯塔西娅: — 不，等等! Aah-}

{color=yellow|卡莉: — 嗯，你能把它们藏在这里吗？你的胸部怎么了，太大了！我嫉妒...}

{color=aqua|阿纳斯塔西娅: — 别-别挤他们...太粗暴了...}

{color=yellow|卡莉: — 哈，他们摸起来确实感觉很好。不完全像肉包子...但不知何故非常迷人...}""",
	HALLOWEEN_EVENT10 = """{color=aqua|阿纳斯塔西娅: — Ngh... 求你了... 放开我...}

{color=yellow|卡莉: — 放开你？那么这些就是你说的'肉包子'？我知道，它们闻起来不一样，但仍然很棒。}

{color=yellow|卡莉: — Hu-huh, 我想别无选择，我会尝一尝的! }

{color=aqua|阿纳斯塔西娅: — 等等，这是不对...停下来-Ah-h haa.... }""",
	HALLOWEEN_EVENT11 = """{color=magenta|西菲拉: — 不幸的是，在黑暗的树林里，没有人能听到她的呼救声。}

{color=magenta|西菲拉: — 那个可怕的夜晚，小红帽被狼吃掉了。}""",
	HALLOWEEN_EVENT12 = """{color=aqua|阿纳斯塔西娅: — 那个故事真的是这样的吗?}

{color=yellow|卡莉: — 我不知道，但我感觉没什么问题。 }

{color=aqua|阿纳斯塔西娅: — 至少我有一套不那么暴露的服装...}

{color=yellow|卡莉: — 啊，你知道我们可以保留它们吗？我希望 [Master] 会喜欢这个。 }

{color=aqua|阿纳斯塔西娅: — 嗯，只要 [Master] 喜欢，我想我不介意穿...}""",

	HELEVIEL_MANSION_1 = """尽管你一般会把一个新获得的奴隶带到他们的房间，或者你的房间，但海伦维尔的行为似乎需要另一种方法。当你决定把她带到房间下面时，你允许她向你和你的仆人吐出刻薄的话，当你把倒下的女祭司拖到地牢时，楼梯逐渐收窄。

到达楼梯底部时，你不太确定她在期待什么，但看到一个装备如此精良的地牢，可以供奴隶使用，似乎与她所认为的现实相去甚远。

{color=yellow|海伦维尔: 住手！我不是一个男人的玩具，我是-}""",
	HELEVIEL_MANSION_2 = """当你反手将她打倒在地，让她安静下来时，石墙发出回声。沉默了很长一段时间，因为从点燃火炬的房间里传来的唯一声音是她的链子被你举起的声音。她试图掩饰自己的震惊，这对大多数人来说都很好，但你已经看到比她更好的女演员尝试过了。

海伦维尔继续徒劳地挣扎，她被拉到墙上的一个大金属环旁，当她重新开始战斗时，她的眼睛睁得大大的，结果又被反手打了一个，然后是第三个。离开那里，当你把她的链子系在戒指上，困住这个麻烦的奴隶时，她不再挣扎了。""",
	HELEVIEL_MANSION_3 = """{color=yellow|海伦维尔: 我-我不是-}

精灵结结巴巴地说话，当你掐住她的喉咙，让她看着你的眼睛时，否认占据了上风，泪水开始流露出来。当她刚开始恢复镇静时，你的手发现了她的大腿，在她扭动时紧紧地挤压着，当你的手找到了她的丝绸内裤时，她的拍打加倍努力，你几乎会对破坏了如此华丽的工艺感到一丝遗憾，但当你把它们从她苍白的皮肤上撕下来时，它们撕裂的声音被她绝望的尖叫所掩盖，你对此不屑一顾。""",
	HELEVIEL_MANSION_4 = """当她的眼睛充满震惊时，你让这些话深入人心，当你把手伸下来，撕开她胸部的衣物时，又让她再次感到恐慌。当你占有欲很强地抓住她的胸部来检查你的新获得时，她的胸部很丰满，仍然充满活力和年轻。她试图抗议，但当你抓住她的乳头并扭动时，她只会结结巴巴地哭出来。现在，当你抓住她时，她会公开发出呜呜声。”她的头发，海伦维尔徒劳地挣扎，因为你允许这样做，她可能会筋疲力尽。  """,
	HELEVIEL_MANSION_5 = """她的身体活动受限，她只能看着你拉开她臀部的衣服，露出下面完美的皮肤，她在漫长道路上的汗水照耀着她。现在，当你抓住她，当她无助地在铁链中扭动时，她的挣扎变得更弱了。

{color=yellow|海伦维尔: 我-我不是...}

海伦维尔结结巴巴地自言自语，当你在她面前解开裤子时，她无法应对这种情况，她的眼睛一开始从怀疑变成了恐惧，最后当你在精灵面前勃起时，她屈服了。当你紧紧地重新梳理她的头发时，尿道球腺液会点缀在你的龟头上，当你把她拉向你的阴茎时，她的头发会在你的手指之间断裂。

海伦维尔挣扎着，摇头了一会儿，当她最后一次的抗议被堵住时，泪水显而易见地从她的眼睛里流了出来，当你把你的阴茎1塞进她的嘴里时，当她张开嘴唇的那一刻，泪水被压制住了。那一刻的震惊显然使她无法忍受。

{color=yellow|海伦维尔: Mmmrff 我 mrrf.}""",
	HELEVIEL_MANSION_6 = """只要严厉地看她一眼作为警告，就可以打破她的剩余决心，当你现在按下她的喉咙时，她的尊严就会崩溃，迫使精灵窒息在你的阴茎上，当你迫使她窒息时，她的身体就会蠕动。当你把自己深深地放在她的喉咙里，让她的视力开始模糊，她的身体继续前进时，腿踢和身体拍打并没有把你赶走。”几乎一瘸一拐，然后你把她拉出来，让她通过鼻子绝望地呼吸，当她咳嗽并痛苦地扭动时，她的眼睛流下了泪水。

当你在她完全清醒的那一刻把她推回喉咙，在她的喉咙里进进出出时，海伦维尔又一次惊慌失措地将目光转向上方，当你粗暴地凌辱她时，没有给她足够的空气来安慰她。在她再次达到极限后，你会再次拉出足够的东西，小精灵的口水垂在她的下巴上，然后你不断地重复这个过程，每次都把她推到极限，只是为了让她放弃，并让她希望它已经结束了。 """,
	HELEVIEL_MANSION_7 = """在她的舌头和喉咙上，你继续这种惩罚，直到最后你把她的头发抓得更紧，当她不再反抗时，她的身体变得柔韧。当曾经骄傲的弗雷娅女祭司瘫在那里，当你射精时无法阻止你，同时开始释放到她的嘴里时，她的眼泪从她的眼睛里涌了出来，当你最终结束她的折磨时，这个女人的眼睛变得模糊，把她留在那里。”你的精液还在她嘴里，直到她像奴隶一样咽下去。

她花了几分钟才服从，当她颤抖着吞下你的精液时，她的眼睛闭上了，当你从她无力的嘴里拔出来时，她的眼泪和疲惫模糊了她的眼睛，当你在一个多小时内第一次让她的嘴空着时，她的下巴太累了，甚至无法完全闭合。""",
	HELEVIEL_MANSION_8 = """海伦维尔咳嗽，她的头垂着，她的眼睛仍然在滴眼泪，当你现在站在这只雌性的身前，你的眼睛俯视着她，她躺在你脚下的地上，她属于你。最终，你会再次俯身抓住她的头发，当你只对被击败的女祭司微笑时，她的眼睛与你的眼睛相遇。在她的目光后面，有什么东西在闷烧，对她的处境感到愤怒。愤怒笼罩着她。”当她第一次打破凝视时泪流满面，当她的声音沙哑时，眼睛再次流下泪水。

{color=yellow|海伦维尔: 不-不要再…不要…不要再。停下，怪物...}

海伦维尔在喘着粗气和哽咽的呼吸之间重复着她的咒骂，她的眼睛呆滞地看着她似乎倒在了地板上。她的身体继续瘫在那里，疲惫压倒了她，刺耳的抗议声逐渐消失为疲惫的喃喃自语。你继续站在她身边几分钟，欣赏你的工作，然后转身把她留在那里，在心里记下，她可能比你的其他仆人休息得更长。  """,
	LIRA_MANSION_1 = """里拉悄悄地跟在你后面，低着头，把脸藏在斗篷的风帽里。虽然你的豪宅里通常很安静，但现在有一片繁忙的活动，仆人们在一天中为数不多的繁忙时间里处理他们的日常任务。很明显，她很害羞，当你把她带进你的家时，她不止一次地摇头，以避开偶尔仆人的目光。

{color=yellow|里拉: 我-我们要去哪里?}


里拉一边问你，一边继续试图隐藏自己，偶尔会惊恐地环顾四周，她的眼睛专注地追踪着每一个动作，就好像某个怪物躲在每个角落一样。你终于在一扇手工雕刻的木门前拦住了她，当她停下来凝视它时，木门的设计很复杂。  """,
	LIRA_MANSION_2 = """你很快就走到她身后，你的手放在她的脖子上，她立刻抓住了她，开始像一只受惊的兔子一样颤抖。她的喉咙紧紧地咬了几下，臀部扭动着，她似乎随时准备战斗，随时逃跑，直到她注意到你把她抱在那里时，你的几个仆人停止了他们正在做的事情，她的脸变成了血红色。”。她轻而易举地转过身来，很快就面对了围观的人群。

{color=yellow|里拉: 你-你在干什么！？我不是。}

现在，当你猛地扯下她的长袍下部时，她的话变成了尖锐的哭声，当她僵住时，她的乳房溢出，眼睛睁得大大的。仆人们看着她，她左右扭动着，无法从你的手中挣脱出来，因为她的内裤很快就和裙子一起在她脚边汇集在一起，她的皮肤摸起来很热，几乎因为尴尬而颤抖。过了一会儿，当你悠闲地抚摸她的胸部时，她哽咽着回应，而你现在正展示着她，对这位女祭司的皮肤是多么柔软印象深刻。

{color=yellow|里拉: [name]..请…不要这样。 }""",
	LIRA_MANSION_3 = """当你的仆人在看的时候，你继续抚摸她，这个精灵尴尬得几乎不能动，她的害羞让她感到困惑。很快你转过身来，打开了房间的门，然后再次领着她，一个大力的拖拽让她在跟着你进入房间时绊倒了。

{color=yellow|里拉: Ack! 你不需要 — }

当你再次抓住她的脖子时，她的眼睛睁得很大，这次她抖得更紧了，你的手把她的头向后仰，直到她的帽子掉下来，当你说话时，她的耳朵紧贴着你的嘴唇""",
	LIRA_MANSION_3_OPTION_1 = """如果你一直扭动，我们将在城镇广场上做这件事。""",
	LIRA_MANSION_3_OPTION_2 = """我想你会更感激的，我本可以让海伦维尔伤害你的。""",
	LIRA_MANSION_4_1 = """里拉听了你的话，明显地放弃了，她的身体仍然在发抖，但她现在停止了扭动。当你把她引导到床上时，她现在很柔韧，把她紧紧地拉到你的腿上，让精灵趴在你身上。当你把手伸下来，把你的阴茎从她身下拉开时，里拉没有进一步反抗你的触摸。 """,
	LIRA_MANSION_4_2 = """里拉在整理身体时停了一会儿。最终，她在你的抓握下放松了一些，很容易把她带到新床上。当你松开你的阴茎时，她仍然不好意思地扭动着，当你把她放好时，她的阴部紧贴着你的阴茎。""",
	LIRA_MANSION_4 = """
{color=yellow|里拉: 这-这是那个吗？！我从来没有见过...}""",
	LIRA_MANSION_5 = """你现在用力拍打着里拉的屁股，提醒她在接近阴茎的时候要表现出尊重，当你的身体顶部摩擦到她裸露的入口时，精灵开始气喘吁吁。里拉现在感觉很潮湿，你意识到在所有的羞耻和尴尬之下，她的身体背叛了她。  

{color=yellow|里拉: 太暖和了……我这里暖和吗？}


里拉用一种半恍惚的声音说话，偶尔试图离开你。当你把她拉回到你身边时，你的手紧紧地放在她的屁股上，当里拉抗议时，她的洞变得越发潮湿。过了一会儿，当你的龟头滑过她的入口时，年轻的精灵僵住了。

{color=yellow|里拉: 不-不! 你不应该!}""",
	LIRA_MANSION_6 = """里拉用力拍打，直到你紧紧抓住奴隶。当她尖叫并被紧紧抓住时，她的眼睛睁得大大的，使她的第一次变得更加紧密。在她扭动了几分钟以示温和的抗议后，你抓住她的头发，拉着她看你。

{color=yellow|里拉: 那-那...不...}

你一寸一寸地把阴茎推到里面，她一直在你腿上扭动。过了一会儿，她失败了，完全被你刺穿。最终，你开始把精灵顶到你的阴茎上，当她在你上方呜咽时，这种紧密感是完美的，当她放弃抵抗时，她的手紧紧抓住你身边的床单，无论如何都无法阻止你。

你继续像这样使用里拉几分钟，当把她上下研磨时，她的处女血在你的阴茎上流淌，她的入口在你的阴茎周围跳动。里拉什么也没说，她的脸很快就被她的兜帽遮住了，当你根据自己的欲望强奸她时，她把它当作一条安全毯。当她发出抗议性的吱吱声时，你再次拉下她脸上的布，然后她因为快感发出的呻吟引起你的注意。""",
	LIRA_MANSION_7 = """当你放松对她的控制，准备换姿势时，迎接你的是一个惊喜，里拉现在开始自己骑在你身上了。速度很慢，但她骑在你的轴上时很谨慎，她不止一次试图拉起兜帽遮住脸，每次你拦住她时都会呜呜地抗议。  

{color=yellow|里拉: — [name], 请-请不要看着我...} 

里拉很快就会更加努力地驾驭你，她不服从的意志也很快就会投降，但当她把臀部向下压到你的阴茎身上时，她是在盲目的欲望下投降的，当她发现自己在性爱中很快乐时，这种刻意的迎合会引起一连串的小叫声，她的进入会让你不得不与射精的冲动作斗争。你尽可能坚持，里拉似乎就明白了这一点，她的臀部摆动得更快，因为她拒绝看你，她的侧面脸因尴尬而血红。当她感觉到你的阴茎在她体内抽搐时，她那可耻的脸很快就变成了震惊，滚烫的精液流到精灵处女的身体里，把她据为己有。""",
	LIRA_MANSION_8 = """当尴尬占据了里拉的脸时，她继续紧咬着，过了一会儿，这份羞耻就被丢弃了，因为女孩现在高潮了，当她达到高潮时，浸泡在内壁的高温把她逼到了边缘，当她崩溃时，一种几乎快乐的声音悄悄地传了出来。在她睁开眼睛看着你之前，她有一刻放松的幸福，因为她仍然设法让自己的脸变得更红。

{color=yellow|里拉: — 你是不是— 里-里面?}

里拉似乎慌了一会儿，在她下床前紧紧地绕着你的阴茎扭动。过了一会儿，她向你快速鞠了一躬，然后跑到你去她房间的路上经过的浴室。你提醒自己，以这种速度，服从训练将成为她每天的事情。""",
	LIRA_MANSION_9 = """几分钟后，里拉穿好衣服回到房间。这完全没有意义。你突然想到，她的衣服在你脱下后被踢进了房间。尽管如此，你不记得看到她捡起它了。在警惕地看了里拉一眼之后，她的眼睛里有了一点闪光，因为她意识到你知道，即使她转过身去看别处，她的脸颊仍然是血红色的。

{color=yellow|里拉: 今晚就到此为止吗... [master]?}

最后一句话从她嘴里说出来，听起来像是试图安抚你的好奇心。你可以考虑询问女孩是什么时候抓住长袍的，但最终还是把这个想法扔掉了，相反，你认为这是一个好主意，可以确保在豪宅里更频繁地进行盘点。如果里拉很善于在不被注意的情况下拿走物品，那么她对你的用处可能比你想象的要大。""",
	
	EXCALIBUR_QUEST_1 = """你看到一块小空地，空地中央有一块大石头。当你仔细观察时，你会发现它有一个突出的剑柄，埋在石头里。尽管按常识来看不可能，但这把剑看起来状态很好。然而拔出它似乎并不容易...""",
	EXCALIBUR_QUEST_1_OPTION_1 = "拔出",
	EXCALIBUR_QUEST_GOOD = """你付出了难以置信的努力，终于把剑从石头里拔了出来！当它终于自由时，你可以感觉到一种强大的魔法存在于其中。你对于收获十分满意，离开了这片空地。 """,
	EXCALIBUR_QUEST_BAD = """你尽了最大的努力，花了几分钟的时间试图拉出这把剑，但没有成功。它甚至没有凸起，石头似乎也没有受到你所有努力的影响。你庆幸没有人看到你可怜的挣扎，你决定暂时别碰这把剑。""",
	
	CHRISTMAS_EVENT_PRE_INTRO = """{color=aqua|西菲拉: — 在一年中的这个快乐的时刻，我希望你事业顺利, [Master]. 

西菲拉: —今天我们要给你讲一个故事，讲的是一个孤独的女孩，她唯一的愿望就是一点幸福...请尽情享受。 }""",
	CHRISTMAS_EVENT_INTRO = """一个年轻的贫穷女孩在冬天一直流落街头。她独自一人，试图通过出售一些生命碎片来谋生。

{color=yellow|黛西: — 请…购买这些闪亮的石头...}

{color=aqua|陌生人: — 你不知道吗？这些东西的市场因为过多而崩溃了。 }

{color=yellow|黛西: — Uuuuh... 不可能…我花了最后一笔钱，希望能转售...}""",
	CHRISTMAS_EVENT_1 = """那是圣诞节前夕，但她想赚些钱——至少能买一夜安眠——的希望落空了。

她含着泪眼蹲下，点着那些碎片，仔细观察，试图耸耸肩摆脱寒冷。她一直在那微弱的光线中回忆自己的记忆...""",
	CHRISTMAS_EVENT_2 = """{color=aqua|鲁道夫: — 嘿，你真的想把你的生命扔掉吗？这行不通，这些都是治疗碎片，你知道的。}

{color=yellow|黛西: — 你-你是谁? }

{color=aqua|鲁道夫: — 我是这个场景的特邀嘉宾……啊，你的意思是字面意思。你可以把我看作一个节日精神。我来这里是为了给你一份工作。 }

{color=yellow|黛西: — 但-但是，我不是那种女孩...}

{color=aqua|鲁道夫: — 我不是皮条客，你们这些混蛋。这是一份标准的工作。拜托，你不想在这里过夜，是吗？}""",
	CHRISTMAS_EVENT_3 = """{color=aqua|鲁道夫: — 过来，我有东西给你。哦，是的，脱下你的衣服。}

{color=yellow|黛西: — 等-等等，我的衣服？！但你说...}

{color=aqua|鲁道夫: — 闭嘴，快点。}""",
	CHRISTMAS_EVENT_4 = """{color=yellow|黛西: — 这-这-这些衣服是什么？ }

{color=aqua|鲁道夫: — 你知道他们是怎么说的，有时你一开始就必须成为你需要的人。}

{color=yellow|黛西: — 但是……这条裙子太短了，而且没有内裤！}

{color=aqua|鲁道夫: — 这是这些天的既定制服，我对此无能为力。不过别担心，你看起来很好。}""",
	CHRISTMAS_EVENT_5 = """{color=yellow|黛西: — 但是我现在该怎么办?..}

{color=aqua|鲁道夫: — 我没告诉你吗？你得自己做一些圣诞老人的工作。现在拿着这个袋子跟我来}

{color=yellow|黛西: — Eeeeh?...}

女孩放弃了抗议，顺从地去跟随她的新雇主。""",
	CHRISTMAS_EVENT_6 = """当女孩不得不拜访一个又一个贫民窟时，她感到很惊讶。当父母和孩子们向她问候时，她发现这是一种新鲜的体验。

最后一天结束时，她来到了一家孤儿院。

{color=aqua|孩子: — 圣诞老人！这是真的圣诞老人吗？}

{color=yellow|黛西: — 我-我不是真正的圣诞老人，但他很忙，所以我在帮忙。}""",
	CHRISTMAS_EVENT_7 = """快乐的孩子们聚集在女孩周围，女孩对她在其他地方很少经历的欢乐感到惊讶。她花了一些时间和孩子们一起玩。

有几次，她差点被一群年纪较大的男孩发现，但最终还是成功了。""",
	CHRISTMAS_EVENT_8 = """{color=aqua|年幼的孩子: — 谢谢你来拜访我们，圣诞老人的助手！}

{color=yellow|黛西: — 哈哈……好吧，终于结束了？}

{color=aqua|鲁道夫: — 感谢你的辛勤工作。既然你做得这么好，这是你的礼物。信不信由你，我知道你圣诞节想要什么。 }

{color=yellow|黛西: — 你-你知道?}""",
	CHRISTMAS_EVENT_9 = """黛西收到了一个彩色盒子作为小礼物。她不等就打开了盒子。

{color=yellow|黛西: — 这是... 一个项圈?}

{color=aqua|鲁道夫: — 现在你将有一个家和一个 [Master]。这正是你真正想要的，不是吗？我相信你们在一起会有很多美好的回忆。 }

不知道该怎么回答，女孩还是设法感谢了她。""",
	CHRISTMAS_EVENT_10 = """鲁道夫: — 尽管这可能很难，但你还是应该尽力。 

{color=yellow|黛西: — 虽然好像哪里不太对，但我们可以享受这些平静和幸福的时刻。}

{color=aqua|鲁道夫: — 说得好，孩子。我看你走了很长的路才来到这里。 }

{color=yellow|Daisy: — 好-我们都想祝大家圣诞快乐，节日快乐！}""",
	
	ZCEVENT_1 = """当你穿过大厦时，你会注意到你的两位居民，西菲拉和卡莉正在交谈。

{color=aqua|西菲拉: — 你知道，我以前没有注意到，但我们有很多共同点。}

卡莉思考了一会儿，注意到它们在起源、音调和外表上的相似之处。

{color=yellow|卡莉: — 没错……哈哈，我们可以冒充姐妹。}

{color=aqua|西菲拉: — 呵-呵, 也许我们的 [Master] 对我们这样的女孩特别感兴趣？}""",
	ZCEVENT_2 = """{color=aqua|西菲拉: — 你今天想闲逛吗？我相信 [Master] 可以带我们去一个好地方。}

{color=yellow|卡莉: — 当然，为什么不呢！}

别无选择，今天你不得不带着可爱的居民去赴约。""",
	ZCEVENT_3 = """{color=aqua|西菲拉: — 这家酒馆真的很不错，就像他们在那本书中说的那样...}

{color=yellow|卡莉: — 我不读愚蠢的书。}

{color=aqua|西菲拉: — Hmmm... 确实。 }

{color=yellow|卡莉: — 你什么意思?}""",
	ZCEVENT_4 = """{color=aqua|西菲拉: — 你似乎为这句话感到骄傲。 }

{color=yellow|卡莉: — 那又怎样？谁还需要书？如果有什么不同的话，书虫会给普通人带来更多的麻烦。}

尽管西菲拉的表情很嫌弃，但她还是决定放弃这个话题。 

{color=aqua|西菲拉: — 那你喜欢玩什么?}""",
	ZCEVENT_5 = """{color=yellow|卡莉: — 啊, 我喜欢和 [Master]一起冒险。有时没有工作的时候我会和孩子们一起玩。}

{color=aqua|西菲拉: — 和孩子们一起玩…？你不是太老了吗？或者这很适合你的形象。}

{color=yellow|卡莉: — 嘿，闭嘴，你比我还矮！你所有的营养都进入了你那愚蠢的尾巴吗？ }

{color=aqua|西菲拉: — W-w...}

在为时已晚之前，你让两个女孩都沉默，并命令她们保持沉默，但她们明显表明了对彼此的仇恨。""",
	ZCEVENT_6 = """当你在外面喘口气时，一个服务员女孩走近你，私下告诉你，她看到了你的女伴之间的紧张关系，并建议你选择他们的一个受欢迎的软葡萄酒品牌，该品牌在兽化裔和混血裔中很受欢迎。你想不出更好的办法，这可能有助于让女孩们平静下来。""",
	ZCEVENT_7 = """你回到那些显然心情不太好的女孩身边。当你把你得到的酒递给她们时，她们的好奇心增强了。

{color=aqua|西菲拉: — 这似乎是一种相当令人愉快的饮料。卡莉，你能喝得下吗？}

{color=yellow|卡莉: — 我当然会喝酒！你能做到，你认为我就不能了？}

在消化了你点的饮料后，你和女孩们的情绪略有好转。尽管之前发生过争吵，但女孩们似乎没有那么紧张了。随着时间的推移，她们的谈话朝着相对平静的方向发展。

过了一会儿，你接到了一个来自行会的熟人的联络，不得不离开女孩们一段时间。""",
	ZCEVENT_8 = """{color=aqua|西菲拉: — 我认为不管我们之间有什么分歧，我们都可以在一件事上达成一致。}

{color=yellow|卡莉: — 什么意思?}

{color=aqua|西菲拉: — 我们来到这里是因为我们真正关心的一个人。 }

{color=yellow|卡莉: — ...我想你说得有道理。}

{color=aqua|西菲拉: — 嘿，你知道吗...}""",
	ZCEVENT_9 = """过了一段时间，你回到房间，看到两个女孩靠得很近，表现得有点可疑。

{color=yellow|卡莉: — [Master]...}

{color=aqua|西菲拉: — 你总是照顾我们，做得很好。..}

{color=yellow|卡莉: — 我们同意为此感谢你。}

{color=aqua|西菲拉: — *咯咯笑* 这是她的主意...}""",
	ZCEVENT_10 = """尽管在公共场所，女孩们还是顽皮地笑着换衣服。也许是因为最近摄入了酒精...

{color=aqua|西菲拉: — 你更喜欢哪一个？呵呵...}

{color=yellow|卡莉: — 那里变大了!}

{color=aqua|西菲拉: — 那叫勃起。你在心理上准备好了吗?}""",
	ZCEVENT_11 = """你无话可说，但谢天谢地，似乎没有其他人注意到这个小恶作剧。

然而，女孩们似乎发现了你的顾虑，用更多的咯咯笑来掩饰自己。

{color=yellow|卡莉: — 像个傻瓜一样。 }

{color=aqua|Zephyra: — 嘿，不要说 [Master] 愚蠢，那太粗鲁了。 *咯咯笑*}""",
	ZCEVENT_12 = """你回到豪宅，女孩们似乎相处得很好，像一对粘人的动物一样压在你身上。

结果一切都很好，你松了一口气。你到家后不久，女孩们就休息了。""",
	
	ZEPHYRA_QUEST_INIT_OPTION_1 = "和西菲拉谈话",
	ZEPHYRA_QUEST_1 = """你发现西菲拉正准备离开豪宅。你问她要去哪里。

— 啊，我本来打算去教堂看望金妮的。我们最近成了朋友。如果你愿意，你可以跟着走。""",
	ZEPHYRA_QUEST_1_OPTION_1 = "好啊",
	ZEPHYRA_QUEST_1_OPTION_2 = "下次吧",
	ZEPHYRA_QUEST_2 = """西菲拉听到你的回复后，眼睛里充满了喜悦。

— 太好了，那我们就不要浪费时间了！她说她想见我。""",
	ZEPHYRA_QUEST_3 = """你发现教堂在一天中的这个时候几乎空无一人，金妮出来迎接你。

金妮: — 啊，西菲拉...你还带了市长？

西菲拉: — 我忍不住让他跟着走。毕竟这不是一个女生俱乐部，对吧？

金妮: — 不，当然不是。很高兴见到你，市长。

西菲拉: — 那么，你找我有什么事?""",
	ZEPHYRA_QUEST_4 = """金妮: — 对……嗯，实际上我得请你帮个忙，我真的需要离开教堂几个小时。我的朋友生病了，需要我的帮助。你能帮我照看一下吗？

西菲拉: — 别再说了，我一直想尝试修女的角色。 

西菲拉似乎对整个情况相当放松，但你想金妮不会相信任何人。""",
	ZEPHYRA_QUEST_4_OPTION_1 = """我想我可以留下来陪你""",
	ZEPHYRA_QUEST_4_OPTION_2 = """让别人来扮演你的角色真的是个好主意吗？""",
	ZEPHYRA_QUEST_5_1 = """金妮: — 啊，我也不用担心这里的市长。谢谢！

西菲拉: — 我也不放心 [him] 独自一人, 但有我在，你就没有什么可担心的了。

金妮: — 那个...看起来有点粗鲁。不管怎样，我最好现在就走。啊，别让流浪猫走进来。""",
	ZEPHYRA_QUEST_5_2 = """金妮: — 我相信西菲拉很有能力。我从来没有遇到过像她这样的人，她像赛琳娜的教导所引导我们的那样善良和真诚。

西菲拉: — 求你了，别这么恭维我。

金妮: — 我不是！不管怎样，我最好现在就走。啊，别让流浪猫走进来。""",
	ZEPHYRA_QUEST_6 = """你和西菲拉巡视教堂。这似乎是一个缓慢的一天，来访者非常罕见，要求也很低。你会惊讶于西菲拉如何自然地扮演金妮帮助来访者的角色。直到一位来访者，一位年轻、贫穷的女性，走近西菲拉。

女人: — 对不起，我真的需要帮助...

西菲拉: — 告诉我们发生了什么事。

女人: — 我……钱包丢了，我的孩子们在我下次付款之前没有吃的...我知道赛琳娜帮助有需要的人。""",
	ZEPHYRA_QUEST_7 = """西菲拉: — 嗯……恐怕我无权调动教会的捐款。你应该等到金妮回来。此外，她可以告诉你一些其他获得帮助的渠道...

女人: — 不，求你了，我不能在这里呆太久，我必须尽快回家，否则我丈夫会生气的，我求你了！

西菲拉不确定该怎么办，似乎在寻求你的意见。""",
	ZEPHYRA_QUEST_7_OPTION_1 = "西菲拉是对的，我们不能把教堂的钱给任何人",
	ZEPHYRA_QUEST_7_OPTION_2 = "我们应该帮助那些需要帮助的人（魅力检定）",
	ZEPHYRA_QUEST_7_OPTION_3 = "没有必要进入教堂的金库，我可以自己帮助你（300金币）",
	ZEPHYRA_QUEST_8_1 = """你支持西菲拉，并告诉她整个情况似乎有点可疑。当西菲拉松了一口气时，这位女士沮丧地离开了。""",
	ZEPHYRA_QUEST_8_2_GOOD = """{color=green|成功}

西菲拉勉强同意这是她的责任。她从教堂的募捐箱里递给那个女人一些金币。

女人: — 谢谢！我不会忘记你的慷慨。

当女人离开时，西菲拉带着一种新近获得的尊重看着你。

西菲拉: — 呵呵，我没想到像你这样的人会这么体贴。""",
	ZEPHYRA_QUEST_8_2_BAD = """{color=red|失败}

西菲拉似乎不相信你的话，那个女人转身就走了，身上没有带钱。西菲拉看起来有点沮丧，但很快就克服了""",
	ZEPHYRA_QUEST_8_3 = """西菲拉和那个女人都对你的决定感到震惊。当你给那个女人钱，她离开时，西菲拉尊重地看着你。

西菲拉: — 哇，我没想到像你这样的人会这么慷慨。你想再次赢得我的心吗？呵呵。""",
	
	ZEPHYRA_DAISY_1 = """一个新访客出现了……正是你的奴隶兔女郎黛西。你决定隐藏起来，让西菲拉一个人来处理这件事。

黛西: — 你-你好，西菲拉，你为什么在这里？金妮在哪里？

西菲拉: — 她已经出去很长一段时间了。她临走前叫我顶班。

黛西: — 哦-哦...我希望能忏悔。我不确定我是否应该晚些时候回来...

西菲拉: — 我向你保证，我不会比她更糟。

黛西似乎对此不确定，但不知何故，她无法拒绝西菲拉的掠夺性兴趣。""",
	ZEPHYRA_DAISY_2_1 = """黛西: — *叹气* 我觉得自己有罪，非常肮脏。我做了一些非常不恰当的事情，如果不是因为我的 [Master] ，我通常不会同意。 

西菲拉: — 听到这个消息太可怕了。但我认为，这不是你的选择。这些行为有多糟糕？

黛西: — 这些都是下流可耻的事...我该怎么办？

西菲拉: — 你的罪必因你无辜的灵魂得赦免。毕竟，你对他们没有责任，不像那些应该在这里忏悔的人。

黛西: — 我明白了...谢谢你，我现在确实感觉好多了。你在这方面很自然...你不会告诉任何人这件事吗？

西菲拉: — 当然不是，我看起来真的像一个会把人出卖的人吗？我会保守秘密的。

黛西离开小教堂，回到自己的岗位。""",
	ZEPHYRA_DAISY_2_2 = """黛西: — 我想为发生在我身上的所有好事祈祷并捐款...

西菲拉: — 哦？你认为这是神圣的指引吗？

黛西: — 我-我喜欢这样想……毕竟，我很幸运有一个善良体贴的 [Master]. 

西菲拉: — 你说得对。但你不应该对我们的 [Master] 太过宽容。我听说 [he] 并非完人。 [He] 可能会做一些坏事。例如， [he] 现在甚至可能在窃听我们...

黛西: — 不可能，我相信我的 [Master]! 如果他听到了，我也不会感到尴尬。

谢天谢地，黛西似乎太迟钝了，没有注意到齐菲拉的冷笑。做完祷告后，她离开了小教堂。""",
	ZEPHYRA_VISITOR_1 = """过了一段时间，一个外表华而不实的男人出现在教堂里，看起来很不合适。当他环顾四周时，很明显他在找人。 

西菲拉: — 我能帮你吗，好先生？ 

访客: — 我本来希望能见到金妮。她今天不在吗？

西菲拉: — 恐怕她要离开一段时间了。 

访客: — 该死，太可怕了。我只是来看她。你知道，她是那么的天真无邪，穿上修女服真好看。事实上，我已经约她出去玩了一段时间...

西菲拉: — Uh-huh...

西菲拉似乎试图避免这场对话继续下去。""",
	ZEPHYRA_VISITOR_2 = """西菲拉: — 对不起，我觉得我应该去上班了。

防空: — 等等，你看起来也很善良，很纯洁...

西菲拉: — 不，不，你错了。事实上，我是纯粹的反面。

访客: — 嗯？这怎么可能？

西菲拉: — 你看...我有一个 [Master]。[he]已经玷污了我身体的每一寸。

访客: — 太-太无礼了!""",
	ZEPHYRA_VISITOR_2_OPTION_1 = """等一下，我没有这么做""",
	ZEPHYRA_VISITOR_2_OPTION_2 = """这是一种轻描淡写的说法，我们实际上做的更多""",
	ZEPHYRA_VISITOR_3_1 = """Zephyra: — 傻-傻鸟，跟我一起玩吧！

但这个有问题的访客似乎已经被拒之门外了。

访客: — 没关系！即使这是谎言，我也无法钦佩一位女士能如此轻易地说出如此淫秽的话。

访客: — 我想金妮回来的时候我会回来的。 

话虽如此，那个男人离开教堂，而你独自一人。""",
	ZEPHYRA_VISITOR_3_2 = """访客: — 呜呜！这真是邪恶，是我们这个时代最糟糕的一天！我无法钦佩一个如此被玷污的人！

西菲拉: — 是-是的，很遗憾我达不到你的标准。

访客: — 我想金妮回来的时候我会回来的。

话虽如此，那个男人离开教堂，而你独自一人。""",
	ZEPHYRA_MAN_1 = """一个男人走进教堂。他毫无生气的眼睛和闷闷不乐的表情看起来像一具行尸走肉。他似乎患有抑郁症。西菲拉平静地走近他。

西菲拉: — 你好。你好像有什么东西压在你身上。 

这个男人沉默了一段时间，整理着自己的想法。终于他开口了。""",
	ZEPHYRA_MAN_2 = """男人: — ...说，你真的相信赛琳娜吗？真的相信造物主吗？在我们周围的痛苦和折磨中，你能板着脸说生活中有一些深刻的意义吗？

西菲拉 — 我同意。没有造物主，这一切可能只是为了让你为了我们的利益而放弃你的钱。没有人监视你的生活，只有你一个人对此负责。

男人看着她，眼中流露出出乎意料的活泼。""",
	ZEPHYRA_MAN_3 = """男人: — 那……我该怎么办？

西菲拉: — 也许就做你觉得对的事吧？你来这里征求意见，看起来并不是个坏人。我相信你也许可以得出自己不同于其他人的结论。

男人停顿了很长一段时间，然后开始疯狂地点头。""",
	ZEPHYRA_MAN_4 = """男人: — 谢谢你……你真的帮了我。

说完，他就走了。

西菲拉: — 哈，他甚至没有留下一笔捐款。""",
	ZEPHYRA_MAN_4_OPTION_1 = "\"没有造物主\"?",
	ZEPHYRA_MAN_4_OPTION_2 = "你与他打交道相当有创意",
	ZEPHYRA_QUEST_9_1 = """西菲拉对你的问题傻笑。她清楚地意识到了这种情况的荒谬性，但这只会让她笑得更开心。

西菲拉: — 你真的以为我能证明他错了吗？他来这里之前就下定决心了。不过，我怀疑这将是他的最终决定。

西菲拉: — 说吧, [Master], 你觉得他的逻辑有道理吗？""",
	ZEPHYRA_QUEST_9_2 = """西菲拉: — 为什么，谢谢。毕竟我认为自己是一个主要的外交人士。但是，说实话，他让我想起了我的妹妹。如果不是这样，我甚至不会试图帮助他。我仍然不知道她大多数时候在想什么...

西菲拉: — 说吧, [Master], 你觉得他的逻辑有道理吗？""",
	ZEPHYRA_QUEST_9_OPTION_1 = "有时我会分享这些想法",
	ZEPHYRA_QUEST_9_OPTION_2 = "他是一个值得怜悯的迷失之人",
	ZEPHYRA_QUEST_9_OPTION_3 = "我宁愿不去想这些事情",
	ZEPHYRA_QUEST_10_1 = """西菲拉: — 啊，是这样吗？也许你应该多去你选择的宗教组织。或者，如果你没有，我应该引导你吗？…开玩笑，我是个糟糕的传教士。""",
	ZEPHYRA_QUEST_10_2 = """西菲拉: — 是的，是的。没错。

齐菲拉点头同意你的说法。

西菲拉: — 像你这样有道德信仰的人现在是很少见的。我找到你不是很幸运吗？呵呵。""",
	ZEPHYRA_QUEST_10_3 = """西菲拉: — 嗯？你是不是太害怕自己走神了？或者可能只是太简单了？好吧，我不怪你，毕竟对很多人来说，这是一种非常正常的看待事物的方式。它也有一定的魅力...""",
	ZEPHYRA_QUEST_11 = """金妮终于回到教堂。在西菲拉复述了今天的事件后，她感谢你们两个。

金妮: — 我真是感激不尽。很抱歉我今天不能陪你...啊，我从朋友的父母那里得到了一些礼物。给市长一些糖果和葡萄酒。

西菲拉 : — 正如你所知，我也不介意收到好酒。尽管我长得很可爱，但我已经是个成年人了。

金妮: — 我提到市长的时候，恐怕这是送给他的礼物...那你想把糖果还给我吗？

西菲拉: — ...不要让我难过得过分。

最后，你今天没有和西菲拉做太多其他事情，但看起来你还是越来越亲密了。""",
	ZEPHYRA_BATH_1 = """晚上，在漫长的一天后，你准备洗澡。一旦你进去，你就会意识到你并不孤单。还有另一个人躲在那里，显然一直在等你。

西菲拉: — 啊，你宽敞的浴室真不错, [Master]。真是巧合，在经历了这么无聊的一天之后，我们决定同时来到这里。

当你谨慎地看了她一眼时，她开始说漏嘴了。

西菲拉: — 哼-嗯，别这样看着我，我在这里呆了这么久，一直在准备迈出第一步。你不能指望像我这样可爱的女孩加入你的行列，只为了成为一个工作无人机。

西菲拉一丝不挂，坐在水里随意地在你旁边移动。""",
	ZEPHYRA_BATH_1_OPTION_1 = "你是不是有点太大胆了",
	ZEPHYRA_BATH_1_OPTION_2 = "你在计划什么?",
	ZEPHYRA_BATH_2_1 = """— 我-我不是……只是……好吧，我们必须尽快巩固我们的关系，不是吗？此外，我不能太落后于其他仆人，对吗？

西菲拉红了脸，但还是从水里爬了起来，靠在你身上，笨拙地吻着你。""",
	ZEPHYRA_BATH_2_2 = """— [Master], 你真的这么笨吗？叹气……这就是我爱上一个傻瓜所得到的。那就把它当作你在教堂帮忙的报酬吧...

西菲拉靠在你身上笨拙地吻了你，让你心情愉悦，没有留下任何谈判的余地。""",
	ZEPHYRA_BATH_3 = """嘴唇交织后，你让她柔软的屁股放在你的腿上。你用手臂搂住西菲拉的腰，把她拉到你身边。她的大尾巴搂着你的腿，顽皮地弹来弹去。

你能感觉到她身上散发出的热量，你会忍不住做出同样的反应。你用手抚摸她的身体，探索她光滑皮肤的每一寸。你忍不住想挑逗她，用手指抚摸她活泼的乳头。西菲拉轻轻地呻吟着，背拱着你。你将此视为继续探索的邀请。你把手指夹在她的两腿之间。尽管她显然是处女，但你觉得她已经湿透了，为你做好了准备。

— 你知道吗...狐狸只找终身伴侣? *咯咯笑*""",
	ZEPHYRA_BATH_4 = """当你把她引导到你身上时，你的手指伸进她柔软的臀部。当你刺穿她的处女膜时，她的温暖包裹着你的阴茎。西菲拉高兴地呻吟，当她抓住你的阴茎时，她紧紧的肉壁压在你的阴茎棒周围。她大口喘气，呻吟，每次用力都会弯曲和拱起身体。""",

	ZEPHYRA_BATH_5 = """你加快了步伐，更用力、更快地撞向她娇小的屁股。当西菲拉达到高潮时，她的呻吟变成了快乐的呼喊，在你的怀里瘫软。她内心痉挛的感觉太难以忍受了，你射进她体内，用你的种子粉刷她的肉壁。

然而，你还不太满意。当她淫荡的哭声充斥着浴缸时，你又开始猛烈地拍打她的屁股...""",
	ZEPHYRA_BATH_6 = """当你们都屏住呼吸时，你们紧紧地抱着她，享受着她柔软的皮肤紧贴着你的感觉。她紧紧地依偎着，用尾巴搂着你，平静地闭上眼睛。  

— 如果我请你帮我洗会不会太过分了？但我想我的腿再也不听使唤了。 *咯咯笑*""",
	
	GOBLIN_QUEST_0 = """第二天早上，你收到一封信，与通常收到的信不同，这封信似乎制作得很粗糙，似乎是用自制的纸和墨水制作的。你意识到这封信来自一个兽化裔定居点，请求你的帮助，所以你决定去看看它可能是个好主意。""",
	GOBLIN_QUEST_1 = """— 喔，是你啊, [name]。看来你收到了我的消息。很好，让我告诉你原因。我收到了一些想要局外人帮助的灵魂的信号。""",
	GOBLIN_QUEST_1_OPTION_1 = "它到底来自谁?",
	GOBLIN_QUEST_1_OPTION_2 = "真麻烦...",
	GOBLIN_QUEST_2_1 = """— 谁知道呢。你一到那里就得弄清楚。

萨夫拉向您解释如何找到需要帮助的神秘灵魂，并在你的地图上添加标记。""",
	GOBLIN_QUEST_2_2 = """— 哦，你不应该忽视灵魂的召唤。你要知道，众所周知，灵魂会保佑他们的恩人。

萨夫拉向您解释如何找到需要帮助的神秘灵魂，并在你的地图上添加标记。""",
	GOBLIN_QUEST_3 = """你到达小悬崖，注意到这个地方的空气感觉不一样。还没来得及环顾四周，一个白色的身影就出现在你面前，几乎让你大吃一惊。""",
	GOBLIN_QUEST_4 = """— 我就知道你会来的，凡人。别害怕，我不打算和你对抗。这次不会。""",
	GOBLIN_QUEST_4_OPTION_1 = """你-你吓到我了""",
	GOBLIN_QUEST_4_OPTION_2 = """我不希望我们再打一次...""",
	GOBLIN_QUEST_4_OPTION_3 = """你想要什么，灵魂？""",
	GOBLIN_QUEST_5_1 = """— 我记得你比这更勇敢，凡人。如果你的灵魂变得过于虚弱，我可能不得不把它拿走，更好地利用它。

— 我有一项任务给你。不久前，我注意到森林的一部分有奇怪的活动。动物们受到了干扰，大气中弥漫着一种不同寻常的能量。我自己去了那里，但找不到是谁造成的。但我确信这是凡人的行为。然而，这不可能是兽化裔或精灵所为。他们很清楚不能做这种事。这一定是外来者的杰作，我相信你更适合处理。""",
	GOBLIN_QUEST_5_2 = """— 我的意思是不会伤害你，凡人。我真诚地需要你的专业知识，所以你可以放心。

— 我有一项任务给你。不久前，我注意到森林的一部分有奇怪的活动。动物们受到了干扰，大气中弥漫着一种不同寻常的能量。我自己去了那里，但找不到是谁造成的。但我确信这是凡人的行为。然而，这不可能是兽化裔或精灵所为。他们很清楚不能做这种事。这一定是外来者的杰作，我相信你更适合处理。""",
	GOBLIN_QUEST_5_3 = """— 嗯，我记得凡人在沟通方面更为正式。很好。

— 我有一项任务给你。不久前，我注意到森林的一部分有奇怪的活动。动物们受到了干扰，大气中弥漫着一种不同寻常的能量。我自己去了那里，但找不到是谁造成的。但我确信这是凡人的行为。然而，这不可能是兽化裔或精灵所为。他们很清楚不能做这种事。这一定是外来者的杰作，我相信你更适合处理。""",
	GOBLIN_QUEST_5_OPTION_1 = """我为什么要为你做这件事?""",
	GOBLIN_QUEST_5_OPTION_2 = """好吧，那我从哪里开始?""",
	GOBLIN_QUEST_5_OPTION_3 = """我目前没有时间。""",
	GOBLIN_QUEST_6_1 = """— 嗯。我不伤害你毛茸茸的朋友们怎么样？这对你和我们都有利。我不认为你想伤害这些树林和居住在它们附近的凡人。但好吧，我知道凡人很少在没有报酬的情况下工作，所以一旦你处理好了，我会给你一个。""",
	GOBLIN_QUEST_6_2 = """— 离这里不远。

白牡鹿向你指明了方向，然后像她最初出现时一样安静地消失了。你觉得你需要花一些时间在这个地方寻找踪迹。""",
	GOBLIN_QUEST_6_3 = """— 你真是无忧无虑。要知道，如果不尽快解决，我会把这个问题变成不仅仅是森林的问题。如果你改变主意，你知道在哪里找我。""",
	GOBLIN_QUEST_TRACK_1 = """环顾四周几个小时后，你只发现了一些看起来像精致陷阱装置的金属碎片。在别无选择的情况下，你把它们打包，决定找一个可能能认出它们的人。""",
	GOBLIN_QUEST_7_OPTION_1 = """有些事情我需要你的帮助...""",
	GOBLIN_QUEST_7 = """你向西格蒙德展示了你发现的陷阱碎片。 

— 是啊，这些东西在任何地方都找不到。我从来没见过像这样的东西。它肯定是陷阱，它的设计真的很有创新性，太糟糕了，零件被摧毁得面目全非。遗憾的是，我不知道有谁能做出这样的工艺...

西格蒙德停顿了很长时间才继续。

— 但有一点很突出，金属的质量很差。我想我只见过哥布林使用这样的东西。

你意识到，现在你对自己应该寻找的东西有了更好的线索。你决定再次回到你发现陷阱的地方。""",
	GOBLIN_QUEST_8 = """你检查了一下你发现破碎零件的地方，很快你就找到了几个隐藏得很深的小脚印。跟着它走了一段时间后，你发现了一个小营地。你注意到有几个小哥布林在待命，很可能是布下陷阱的罪魁祸首。""",
	GOBLIN_QUEST_8_OPTION_1 = """接近他们""",
	GOBLIN_QUEST_8_OPTION_2 = """潜入""",
	GOBLIN_QUEST_9_1 = """当你在众目睽睽之下走到哥布林面前时，他们公开表现出敌意，并举起了他们的武器。似乎别无选择，只能与他们战斗。""",
	GOBLIN_QUEST_9_2_BAD = """{color=red|失败}

你试图偷偷靠近，但你被树枝绊倒了，然后被发现了。哥布林们迅速拿起武器，准备攻击你。""",
	GOBLIN_QUEST_9_2_GOOD = """{color=green|成功}

你设法在不被发现的情况下接近地精。你在最后一刻拔出武器跳了出来，让他们大吃一惊。""",
	GOBLIN_QUEST_10 = """一旦你确立了自己的统治地位，你就要求知道他们为什么非法侵入这里。作为回应，一个哥布林女孩走了出来，向你挥手。她从其他人中脱颖而出，似乎是这里的首领。

— 嘿，大 [boy], 不需要暴力。我们只是觉得这些树林是免费的，否则我们就不会在这里了。没必要用那根大棍子指着我""",
	GOBLIN_QUEST_10_OPTION_1 = """你在这里做什么?""",
	GOBLIN_QUEST_10_OPTION_2 = """没有什么是免费的""",
	GOBLIN_QUEST_10_OPTION_3 = """如果你不想发生更糟糕的事情，你就必须离开""",
	GOBLIN_QUEST_11_1 = """— 啊，我们刚刚实地测试了我最新的小发明。我雇这些人是为了陪伴我，一个女孩独自穿过这些树林很危险。

但是这些究竟是谁的土地？它离精灵之地很远，我可以用屁股发誓你也不是本地人。""",
	GOBLIN_QUEST_11_2 = """— 哈，真的。你不是来光着膀子抢劫我们的，我接受？那我们就走了。

但是这些究竟是谁的土地？它离精灵之地很远，我可以用屁股发誓你也不是本地人。""",
	GOBLIN_QUEST_11_3 = """— 好吧，好吧，我们不需要麻烦，好吗？我们会在日落前离开。

但是这些究竟是谁的土地？它离精灵之地很远，我可以用屁股发誓你也不是本地人。""",
	GOBLIN_QUEST_11_OPTION_1 = """实际上我是一个人来的""",
	GOBLIN_QUEST_11_OPTION_2 = """森林精灵对你的活动感到愤怒""",
	GOBLIN_QUEST_11_OPTION_3 = """这不关你事""",
	GOBLIN_QUEST_12_1 = """— 你说一个人吗？一定很孤独，哈哈，我在开玩笑。如果你不介意，那我们就上路了。""",
	GOBLIN_QUEST_12_2 = """— 嗯，你不是认真的吗？…你是……好吧，我不喜欢这段对话的内容，所以我要回到矮人的土地。再见。""",
	GOBLIN_QUEST_12_3 = """— 我明白了……那我们就上路了？""",
	GOBLIN_QUEST_12_OPTION_1 = """现在可以走了""",
	GOBLIN_QUEST_12_OPTION_2 = """问题是，你为什么不赔偿你所造成的伤害?""",
	GOBLIN_QUEST_13 = """— 该死……好吧，拿走我们剩下的。

哥布林离开后，你搜查他们的营地，寻找他们留下的贵重物品，获得约1000金币。""",
	GOBLIN_QUEST_14_OPTION_0 = """汇报任务""",
	GOBLIN_QUEST_14 = """当你呼唤时，白色牡鹿以人形出现在你面前。

— 你已完成任务。难怪，考虑到你的足智多谋，但我仍然感谢你。我想你应该为此得到一些奖励。告诉我，你在寻求什么？""",
	GOBLIN_QUEST_14_OPTION_1 = """财富""",
	GOBLIN_QUEST_14_OPTION_2 = """力量""",
	GOBLIN_QUEST_14_OPTION_3 = """快乐""",
	GOBLIN_QUEST_15_1 = """— 嗯，我从来没有理解过凡人对金钱的迷恋，但顺其自然。有很多傻瓜来到了这些森林，所以我可以分享他们留下的一些财产。拿走他们的金子，离开吧。

你回头一看，发现了一大堆宝藏。当你再次回头时，你意识到那只白色的牡鹿已经不见了。通过后，您可以从中获得5.000金币。""",
	GOBLIN_QUEST_15_2 = """— 你帮助了我们，我可以把你当作盟友。很好，你可以拥有这种古老的武器，你应该会发现它在狩猎和战斗中很有用。

白鹿手里拿着一支长矛，递给你。尽管它明显老旧了，但感觉比新的要好。如果没有进一步的对话，灵魂就会消失，只剩下你一个人。""",
	GOBLIN_QUEST_15_3 = """— ... 我没听错吗？你真的很喜欢我的身体吗？

尽管你提出了相当离谱的建议，但白牡鹿似乎并没有对此感到厌烦。""",
	GOBLIN_QUEST_15_3_OPTION_1 = """是的，我觉得你很有吸引力""",
	GOBLIN_QUEST_15_3_OPTION_2 = """不，我想我改变主意了""",
	GOBLIN_QUEST_HARA_1 = """— 嘿，是你。我知道我会在这里找到你。这可能有点突然，但我想既然你在这里是个大人物，我们或许可以达成一些协议。我不介意加入你的团队，至少一段时间。我甚至会在和你在一起的时候给你一些特殊的待遇。你说呢？""",
	GOBLIN_QUEST_HARA_1_OPTION_1 = """我当然可以利用你这样的…才能""",
	GOBLIN_QUEST_HARA_1_OPTION_2 = """不""",
	GOBLIN_QUEST_HARA_2_1 = """— 太好了，顺便说一句，我叫哈拉。我期待着我们未来的关系。你很幸运有我在你身边。我的工作计划会让你大吃一惊。""",
	GOBLIN_QUEST_HARA_2_2 = """— 太糟糕了。好吧，一旦我有其他东西可以提供，也许你会改变主意，但请注意，那时找我可没那么简单。""",
	GOBLIN_QUEST_SEX_1 = """白牡鹿似乎被你的请求逗乐了，自从你见到她以来，她的表情第一次变软了。她毫无征兆地把你推倒，用她有力的大腿跨坐在你身上。当她高高耸立在你的头顶，白色的长发披在她的肩膀上时，你会惊叹于她的美丽。她很快就会感觉到你的勃起。

— 看来你已经有心情了。

随着一个快速的动作，白牡鹿释放你的阴茎并包裹它，带你深入她的内心。她慢慢来，享受着每一次运动，同时优雅地移动臀部。你不确定这是她超凡脱俗的天性还是开放的环境，但这种感觉是你从未经历过的。 """,
	GOBLIN_QUEST_SEX_2 = """白牡鹿加快了速度，骑得更用力、更快。你可以听到你的身体拍打在一起的声音，在树上回荡。

你再也忍不住了，你射进了她的身体，一股狂喜席卷了你。当你给你身上的女人种满种子时，她会发出深深的呻吟，当她品味这一刻时，她闭上了眼睛.. 

— 哈...哈哈...凡人依旧...有趣...""",
	GOBLIN_QUEST_SEX_3 = """你说完，她站起来神秘地看了你一眼。 

— 后会有期。 在那之前...

你听不到她的留言，因为你的疲惫占据了上风，让你当场睡着了。你恢复理智时，就没有她的踪迹了。你决定继续前进。""",
	
	
	ZEPHYRA_LILIA_1 = """当你穿过豪宅时，你听到你的两位居民：西菲拉和莉莉娅之间发生了争吵。

{color=aqua|莉莉娅: — 够了，它应该是我的！}

{color=yellow|西菲拉: — 不，我也想要。}""",
	ZEPHYRA_LILIA_2 = """当你问发生了什么事时，你得到解释，莉莉娅是如何要求西菲拉给她一份她刚从城市带来的蛋糕的。一位来自遥远国度的流浪商人带来了它，所以它真的很受女孩们的欢迎。

{color=yellow|西菲拉: — 但你已经得到了你的那部分，我也想要...}

{color=aqua|莉莉娅: — 但你一开始只带了一半！} 

{color=yellow|西菲拉: — 我告诉过你，我和一些饥饿的孩子分享过。}""",
	ZEPHYRA_LILIA_3 = """{color=aqua|莉莉娅: — 我花的钱！}

{color=yellow|西菲拉: — 这-这是真的，但这不公平。}

{color=aqua|莉莉娅: — [Master], 告诉她我是对的。}

{color=yellow|西菲拉: — 你可能是对的，但这对我来说不公平。}

看起来西菲拉不得不向莉莉娅借钱，并承诺与她分享，所以尽管得到了一些钱，仙女还是想要现在剩下的一切...看来你必须解决这场纠纷。 """,
	ZEPHYRA_LILIA_3_OPTION_1 = """莉莉娅，你应该和西菲拉分享，不要太贪婪""",
	ZEPHYRA_LILIA_3_OPTION_2 = """既然是莉莉娅的零花钱，就应该是她的。""",
	ZEPHYRA_LILIA_3_OPTION_3 = """我再给你买个蛋糕... (100 金币)""",
	ZEPHYRA_LILIA_4_1 = """莉莉娅听到你的话后嘟着嘴。

{color=aqua|莉莉娅: — 好吧……下次我不会给你钱的！} 

当仙女回到她的房间时，你意识到这是一个空洞的威胁。

{color=yellow|西菲拉: — 谢谢你, [Master], 我就知道你会做出正确的选择

你想知道这到底是不是一个正确的选择。""",
	ZEPHYRA_LILIA_4_2 = """ZEPHYRA一脸悲伤地被迫放弃了自己的那份。

{color=aqua|莉莉娅: — 万岁! 我就知道 [Master] 是公平的。} 

莉莉娅抢过自己的那一份，冲出房间，让西菲拉很快就效仿了她。""",
	ZEPHYRA_LILIA_4_3 = """两个女孩都给你一个惊喜的眼神，但都不拒绝。

{color=aqua|莉莉娅: — 好吧，没有问题，对吧？} 

{color=yellow|Zephyra: — 是-是的... 谢谢, [Master]。}""",
	ZEPHYRA_LILIA_5 = """过了一段时间，西菲拉带着第二块蛋糕回来了，脸上露出了困惑的表情。

西菲拉: — 嗯...我感觉不对。

{color=aqua|莉莉娅: — 什么？我们又得到了一个免费的蛋糕。生活太棒了！}

{color=yellow|西菲拉: — 我的意思是，我认为这不是我们应得的。我们不应该这样滥用[Master]的仁慈。} 

莉莉娅皱着眉头沉思，这是西菲拉几乎从未从她身上看到过的。

{color=aqua|莉莉娅: — 那我们为什么不还人情呢？我知道有件事[he]不会拒绝...}""",
	ZEPHYRA_LILIA_6 = """晚上晚些时候，当你睡得很香时，莉莉娅和西菲拉都出现在你的房间里。

{color=yellow|西菲拉: — [Master]不会醒来...?}

{color=aqua|莉莉娅: — 别担心，我给[him]施了睡眠魔法，所以[he]不会那么容易醒来。}

{color=yellow|西菲拉: — 我……并没有真的把你当成这样一个女孩。}""",
	ZEPHYRA_LILIA_7 = """当你慢慢醒来时，你觉得自己的身体沉重。看起来你和两个女孩都脱了衣服，她们压在你上面。

{color=yellow|西菲拉: — [Master], 我们今天决定感谢您。} 

{color=aqua|莉莉娅: — 这是我的主意!}

莉莉娅立刻跨坐在你的脸上，她的臀部紧贴着你的嘴，露出了她的阴部。你感觉到她的手指抓着你的头发，把你的头拉得离她更近。

与此同时，西菲拉跨坐在你的腰上，她温暖、赤裸的身体摩擦着你的阴茎。她的大尾巴擦在你的腿上，当她锻炼臀部时，让你的脊椎颤抖，慢慢地，开玩笑地摩擦你。 """,
	ZEPHYRA_LILIA_8 = """{color=yellow|西菲拉: — [Master], 你已经很辛苦了……看来我们的奖励是你应得的。}

西菲拉把自己放在你的阴茎上，当阴茎进入她体内时呻吟。当莉莉娅看到这一点时，她忍不住感到有点嫉妒，但你的舌头让她回到了正轨。

随着呻吟声越来越接近高潮，两个女孩都加快了动作。""",
	ZEPHYRA_LILIA_9 = """{color=yellow|西菲拉: — Aahh... NNhhh....}

{color=aqua|莉莉娅: — Aaah!..}

你可以感觉到两个女孩在一起大口大口地喘着粗气，你的精液齐刷刷地充满了西菲拉的阴部。当莉莉娅在你身上呜咽时，她的体液流到了你的脸上。在这场激情的邂逅之后，当他们慢慢地压在你身上时，你可以感受到他们的重量。

你躺在那里很长一段时间，你们三个在快乐的余晖中迷失了方向。当西菲拉依偎在你身边，她的尾巴缠绕在你的腿上时，你感觉到莉莉娅的嘴唇抵着你的脖子，温柔地吻着你。看起来两个女孩都睡着了，不会让你像自私的猫一样离开。""",
	
	
	ZEPHYRA_PAINTING_1 = """当你在豪宅中漫步时，你会发现其中一间密室被你的一位居民西菲拉占据。当你溜进房子时，你可以看到她一边沉思着检查一块搭建好的画布，一边轻轻地用嘴叼着画笔。你还记得当你第一次见到她时，发生了什么。

西菲拉似乎发现你的出现，但没有动，也没有说任何话，似乎是为了不分散她的注意力。""",
	ZEPHYRA_PAINTING_1_OPTION_1 = "*保持安静*",
	ZEPHYRA_PAINTING_1_OPTION_2 = "那么，这是你的爱好吗?",
	ZEPHYRA_PAINTING_1_OPTION_3 = "你可以把时间浪费在更有趣的事情上",
	ZEPHYRA_PAINTING_2_1 = """— 啊, [Master], 你对我的画感兴趣吗？我其实只是个业余爱好者，但如果你愿意，你可以看。

— 不管怎样，既然你在这里，为什么不告诉我你想让我画什么？也许我这么做只是为了 [Master].""",
	ZEPHYRA_PAINTING_2_2 = """— 哈，你可以这么说。但我有一个借口，因为这对我来说也是一种占卜技巧。不过，在完成之前，你永远不知道自己看到了什么。但这会让它更放松、更令人兴奋。

— 不管怎样，既然你在这里，为什么不告诉我你想让我画什么？也许我这么做只是为了 [Master].""",
	ZEPHYRA_PAINTING_2_3 = """— Boo, [Master]! 这对我来说很有趣，你知道。或者你在暗示什么顽皮的东西？那么，这会更有用，毕竟这也是我长期以来的占卜练习。

— 不管怎样，既然你在这里，为什么不告诉我你想让我画什么？也许我这么做只是为了 [Master].""",
	ZEPHYRA_PAINTING_2_OPTION_1 = "风景画",
	ZEPHYRA_PAINTING_2_OPTION_2 = "肖像画",
	ZEPHYRA_PAINTING_2_OPTION_3 = "裸体画",
	ZEPHYRA_PAINTING_2_OPTION_4 = "随心而画吧",
	ZEPHYRA_PAINTING_3_1 = """— 这看起来有点无聊。你真的想请求其他东西，但太害羞了吗？哦，好吧，当涉及到预测时，没有第二次机会了，所以我接受它。""",
	ZEPHYRA_PAINTING_3_2 = """— 就像我送给你的那个，嗯？或者应该是某个可爱的女孩——也许是我自己？嗯，只有一种方法可以找到。""",
	ZEPHYRA_PAINTING_3_3 = """— 哈……你真的只会想这些吗？但你要知道，我只会给你画一张我自己的裸体，我看不到自己，所以你会得到一张空白的照片。 """,
	ZEPHYRA_PAINTING_3_4 = """西菲拉对你缺乏兴趣明显感到失望，但她的情绪并没有恶化。

— 好。那我就试着画一个傻瓜主人，看看会有什么结果。我不知道占卜会怎么说，呵呵...""",
	ZEPHYRA_PAINTING_4 = """西菲拉还没来得及把刷子拿到画布上，你就听到一声巨大的爆裂声，它从她的手上碎到了地板上。

— 啊，该死！这是本周的第三次...我想这些廉价的东西不足以承受我的力量。

西菲拉大声叹了一口气，戏剧性地倒在地板上。

— 我要去商店。""",
	ZEPHYRA_PAINTING_4_OPTION_1 = "你总是要处理这个？这是一个多么非传统的爱好啊。",
	ZEPHYRA_PAINTING_4_OPTION_2 = "我陪你",
	ZEPHYRA_PAINTING_4_OPTION_3 = "安全出行",
	ZEPHYRA_PAINTING_5_1 = """— 事实是，我和你一起离开米尔福德后的某个时候丢了它。真的很遗憾，它是阿利奥斯因为我的善举而送给我的……至少这是我唯一能解释我是如何在小村庄的垃圾堆里找到它的。""",
	ZEPHYRA_PAINTING_5_2 = """— 谢谢你, [Master], 但我认为这是我的个人任务。 """,
	ZEPHYRA_PAINTING_5_3 = """— 哦，好吧。对不起，今天的工作我得请假。 """,
	ZEPHYRA_DISAPPEARANCE_1 = """当你早上意识到西菲拉没回来，对她来说不同寻常。找她可能是个好主意。""",
	
	ZEPHYRA_DISAPPEARANCE_2 = """你发现了西菲拉前几天去的那家商店。这是一家位于街角的小文具店，并不特别显眼，所以你决定进去。当你走向柜台却没有发现任何人时，你在墙上发现各种各样的绘画工具。经过短暂的考虑，你决定按下柜台上的铃声...""",
	ZEPHYRA_DISAPPEARANCE_3 = """你发现自己身处一片白雪皑皑的针叶林中。你不知道自己是如何来到这里的，如果不是因为它非常真实，一切都感觉像是一场梦。持续的暴风雪几乎让人眼花缭乱，但你可以分辨出前方建筑物的阴影。""",
	ZEPHYRA_DISAPPEARANCE_3_OPTION_1 = "向建筑物移动",
	ZEPHYRA_DISAPPEARANCE_3_OPTION_2 = "远离建筑",
	ZEPHYRA_DISAPPEARANCE_3_OPTION_3 = "试着醒来",
	ZEPHYRA_DISAPPEARANCE_4_1 = """你穿过厚厚的雪，恍如隔世。过了一会儿，你就可以看出那是一层楼高的小木屋了。与恶劣的天气相反，它似乎几乎是一个理想的藏身之地，窗户里有少量的光。你打开未锁的门，走进去。""",
	ZEPHYRA_DISAPPEARANCE_4_2 = """你花了几分钟的时间在长得很像的树之间徘徊，但最终一无所获。你回到了最初的地方，眼前是一座建筑的剪影。""",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_1 = """你想办法从这个梦中醒来，如果它真的是一个...""",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_1 = "掐自己",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_2 = "咬舌头",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_3 = "坐着等",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_4 = "放空身心",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_2_1 = """用力捏手，但只会感到轻微疼痛。""",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_2_2 = """你咬着舌头，嘴里开始尝到一点血，但什么也没发生。你想知道这是不是一个好主意...""",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_2_3 = """你坐下来试着恢复理智，但唯一改变的是你开始感到寒冷……或者至少你认为如此。""",
	ZEPHYRA_DISAPPEARANCE_WAKEUP_2_4 = """""", #
	ZEPHYRA_DISAPPEARANCE_HUT_1 = """从内部看，这间小屋似乎相当宽敞。主屋由一个石头壁炉照亮，壁炉正在平静地燃烧，使空间变暖。你的鼻子闻到淡淡的烧焦的木头味。”。

一个头上戴着一对狐狸耳朵的小男孩坐在桌子旁。""",
	ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_1 = "走向厨房",
	ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_2 = "接近男孩",
	ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_3 = "休息",
	ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_4 = "看床下", #  (needs trigger 4, one shot)
	ZEPHYRA_DISAPPEARANCE_KITCHEN_1 = """厨房有点昏暗。你在准备做饭的过程中发现了一些食物。窗户上覆盖着厚厚的冰，你看不清外面是什么。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_1 = "检查食物",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2 = "看窗户",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2_2 = "看窗户",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_3 = "拿刀", # (needs trigger 2)
	ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_4 = "返回大厅",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_2_1 = """你在厨房的抽屉里翻找，但尽管它们有很多美味的蜜饯，你意识到你几乎没有食欲。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_1 = """窗户被漆成厚厚的白霜。在它后面你只能看到一种纯白的颜色。过了一会儿你就转身离开了。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_2 = """当你看到白霜的图案时，你开始注意到它们是如何慢慢移动形成女人的脸的形状的。你真的看不出任何细节，但其中有一些母性的东西。

— 困在这样一个简单的幻觉中，多么尴尬...我想普通人仍然不是神眷者的对手。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_1 = "你是谁?",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_2 = "怎么回事?",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_3 = "需要我做什么?", # (appears after seeing 1 and 2)
	ZEPHYRA_DISAPPEARANCE_KITCHEN_3_1 = """— 你只是站在这里，脸上带着愚蠢的表情，看着一块根本不存在的玻璃。这真是一次悲惨的经历。

图案背后的实体似乎没有听到你的问题，或者完全忽略了它。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_3_2 = """— 你陷入了一种法……神术？这就是你面临的问题。另一个神眷者设下的陷阱，不幸的是，她也被这个陷阱抓住了。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_3_3 = """在你终于能听到脑海中的声音之前，有很长一段时间的停顿。

— 也许吧。如果你做出承诺。您必须停止收集工件。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_3_OPTION_1 = "你为什么要我停下来?",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_3_OPTION_2 = "我同意",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_3_OPTION_3 = "我拒绝",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_4_1 = """声音忽略了你的问题，似乎只想要你的回答。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_4_2 = """当你回应时，你意识到面前的桌子上有一把刀。出于某种原因，你无法判断它是否一直在那里，或者你只是注意到了它，但它肯定引起了你的注意。玻璃上的图像和声音都消失了。""",
	ZEPHYRA_DISAPPEARANCE_KITCHEN_4_3 = """你什么也没听到，但你对自己的反应感到非常恼火，然后什么都没有。过了一会儿，你意识到你面前的桌子上有一把刀。出于某种原因，你不知道它是一直在那里，还是你刚刚注意到了它，但它确实引起了你的注意。玻璃上的图像和声音都消失了。""", # (add trigger 2)
	ZEPHYRA_DISAPPEARANCE_KNIFE = """你把刀拿在手里，它感觉又冷又奇怪，但很结实。你把它放在口袋里。""",
	ZEPHYRA_DISAPPEARANCE_BOY_1 = """男孩以友好、平静的方式与你交谈。

— 外面天气很恶劣，不是吗？但藏在里面会更好。我们的家非常舒适，你可以一直呆到暴雪结束。

男孩指着壁炉旁边的床。""",
	ZEPHYRA_DISAPPEARANCE_BOY_1_OPTION_1 = "询问",
	ZEPHYRA_DISAPPEARANCE_BOY_1_OPTION_2 = "刺伤他",
	ZEPHYRA_DISAPPEARANCE_BOY_1_OPTION_3 = "离开",
	
	ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_1 = "我在哪里?",
	ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_2 = "你是谁?",
	ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_3 = "我该怎么出去?",
	ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_4 = "说的够多了",
	
	ZEPHYRA_DISAPPEARANCE_BOY_2_1AND2 = """— 你一定是我姐姐的朋友吧？她去散步了，几个小时后就会回来。你为什么不在那边的床上休息呢？ 

— 我的名字是...

出于某种原因，你听不出他刚刚对你说的任何声音。""",
	ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_1 = "她在哪里?",
	ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_2 = "我该怎么出去?",
	ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_3 = "你在这里做什么?",
	ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_4 = "聊够了",
	ZEPHYRA_DISAPPEARANCE_BOY_3_1 = """— 姐姐前段时间出去了。希望她能尽快回来，毕竟她的身体很虚弱。在我们父母去世之前，她一直卧床不起。""",
	ZEPHYRA_DISAPPEARANCE_BOY_3_2 = """— 出去？天气这么坏，你不应该出去，我们等她回家吧。她很快就会回来的。""",
	ZEPHYRA_DISAPPEARANCE_BOY_3_3 = """— 啊，姐姐确实喜欢画画，尽管用我们这种家境很难买到画画的工具。她画画的时候看起来几乎很开心。你可能在床下可以找到她的一些素描。至于我……我想我真的不记得了。""",
	ZEPHYRA_DISAPPEARANCE_BOY_4 = """你走近一点，迅速地把刀伸进男孩的肚子里。""",
	ZEPHYRA_DISAPPEARANCE_BOY_5 = """— 咳-那-那是……你……混蛋！…你怎么回事？……你从哪里拿到刀的！？

你周围的世界很快开始变得模糊，你意识到你就在商店门口。男孩的样子迅速变成了一个痛苦地抱着肚子的中年精灵，带着仇恨和不屑的目光看着你。

— 像你这样的人是怎么从我的神术中挣脱出来的！？就连那个女孩也没有机会摆脱它。走开，否则你就再也见不到她了！""",
	ZEPHYRA_DISAPPEARANCE_BOY_5_OPTION_1 = "西菲拉在哪里?",
	ZEPHYRA_DISAPPEARANCE_BOY_5_OPTION_2 = "你想要什么?",
	ZEPHYRA_DISAPPEARANCE_BOY_5_OPTION_3 = "哈，我不在乎 *攻击*",
	ZEPHYRA_DISAPPEARANCE_BOY_6 = """— 在你找不到她的地方。和你不同，她掉进了这个陷阱，很好，该死。你一个人找不到她，她离这个城市很远。如果你想让她回来，就把你从精灵那里得到的碗带给我。然后我保证她会完好无损地回来……大多数情况下。""",
	ZEPHYRA_DISAPPEARANCE_BOY_6_OPTION_1 = "如果你想骗我，我一定会杀了你",
	ZEPHYRA_DISAPPEARANCE_BOY_6_OPTION_2 = "我…了解",
	ZEPHYRA_DISAPPEARANCE_BOY_6_OPTION_3 = "算了，我最好现在就杀了你。 *攻击*",
	ZEPHYRA_DISAPPEARANCE_BOY_7_1AND2 = """— 三天后我们将在城外见面。我的信使会去你家。我想现在你有事情要做..

小精灵打了个响指，商店迅速在墙上燃起大火。当人们开始聚集在它周围时，他很快就逃走了。""",
	ZEPHYRA_DISAPPEARANCE_BOY_8 = """过了一段时间，城市警卫已经封锁并调查了这座建筑，从天花板到地板。尽管他们做出了努力，但他们几乎无能为力。

— 从你对他们的描述来看，那个精灵可能就是那个被称为凯奇的精灵。据我们所知，他是个臭名昭著的罪犯。走私、谋杀、突袭。。。如果他像你说的那样是神眷者，情况会更糟。""",
	ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_1 = "像他这样的人怎么能自由活动？",
	ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_2 = "我需要帮助，西菲拉被他绑架了",
	ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_3 = "我要独处（关闭）",
	ZEPHYRA_DISAPPEARANCE_BOY_9_1 = """— 他一直以难以捉摸而闻名。每当当局发现他的位置时，他都会逃跑。这就是他赢得这一声誉的原因。这对你来说有点糟糕，因为我预计他现在可能会隐藏在一个无人知晓的藏身处。""",
	ZEPHYRA_DISAPPEARANCE_BOY_9_2 = """— 像我们这样的人无能为力。我已经通知了巡逻警卫，但鉴于他的经验，希望渺茫。对不起，我们无能为力。""",
	ZEPHYRA_DISAPPEARANCE_BOY_ATTACK = """你拿起武器，迅速干掉受伤的神眷者。当他倒下时，你意识到他的话很可能是真的，现在你不知道如何找到西菲拉。""",
	ZEPHYRA_DISAPPEARANCE_BED_1_1 = """你躺在床上，闭上眼睛。出于某种原因，你感觉很舒服，很快就在噼啪作响的炉火旁打盹睡着了...

直到你感觉到毛茸茸的东西狠狠地拍打在你的头上，让你恢复理智。你环顾四周，看不到任何人，只感到内疚。在你来到这里之前，你一直在寻找西菲拉，不是吗？

那个男孩微笑着看着你。

— 出什么事了?""",
	ZEPHYRA_DISAPPEARANCE_BED_1_2 = """你不再觉得困了。然而，尽管这只是一场梦或幻觉，你还是承认床很舒适...""",
	ZEPHYRA_DISAPPEARANCE_BED_2 = """你跪下来看床下，直到发现一个木箱。把它拖出来后，你会看到多幅略显灰尘的素描和业余绘画。有些画有熟悉的花朵图案。其他画则更抽象，总体上给人一种压抑的感觉。

在所有的画作中，你会发现一把精致的画笔，在它平淡的环境中脱颖而出。当你把它拿在手里时，你会听到男孩在对你说话。

— 啊，那是她的。自从我们搬家后，她有一段时间没用它了，但我建议你不要管它。

你把盒子放回原处站起来。""",
	ZEPHYRA_DISAPPEARANCE_BOWL_OPTION_1 = "我想谈谈西菲拉...",
	ZEPHYRA_DISAPPEARANCE_BOWL_1 = """你决定告诉金妮关于西菲拉的遭遇。

— 哦，不可能，太可怕了！他们想要你从精灵王国得到的圣碗？嗯…对不起，我不知道他们想要它干什么。我真的很担心西菲拉的命运。""",
	ZEPHYRA_DISAPPEARANCE_BOWL_1_OPTION_1 = """实际上，你们是如何认识彼此的？""",
	ZEPHYRA_DISAPPEARANCE_BOWL_1_OPTION_2 = """我们无能为力吗?""",
	ZEPHYRA_DISAPPEARANCE_BOWL_2_1 = """— 她是常客，我想我们已经成为朋友了！她对宗教故事和仪式出奇地热情，也许是因为她的地位…嗯…请做点什么，以免她受伤。""",
	ZEPHYRA_DISAPPEARANCE_BOWL_2_2 = """金妮似乎有一段时间陷入了沉思，直到她终于开口说话。

— 我想...我知道一种方法。我也许能够复制圣碗的神圣光环，或者至少在几天内让它看起来如此。你一眼就看不出来区别了。我认为对方应该也没办法短时间内看出来，但对西菲拉来说可能还是有风险的...

— 如果你同意这一点，我需要1000金币来购买必要的工具和物品。""",
	ZEPHYRA_DISAPPEARANCE_BOWL_2_OPTION_1 = "我会考虑的",
	ZEPHYRA_DISAPPEARANCE_BOWL_2_OPTION_2 = "好，去买吧 (支付 1000 金币)",
	ZEPHYRA_DISAPPEARANCE_BOWL_3_1 = """— 很好，但请快点。如果你说的是真的，我们可能没有太多时间。""",
	ZEPHYRA_DISAPPEARANCE_BOWL_3_OPTION_1 = "我带了钱 ",
	ZEPHYRA_DISAPPEARANCE_BOWL_3_2 = """— 太棒了，请在这里等一下，我已经准备好了大部分东西。

当金妮退出大厅时，你独自一人对教堂感到发呆一段时间。""",
	ZEPHYRA_DISAPPEARANCE_BOWL_4 = """你花了大约一个小时等待金妮终于带着一个闪闪发光的碗的复制品来找你，这很容易骗到你。你从她手里拿走它，她鞠了一个小躬。

— 你最好配合一下，这样他们就不会怀疑了。我为你的成功祈祷。
""",
	ZEPHYRA_DISAPPEARANCE_BOWL_4_OPTION_1 = "谢谢你",
	ZEPHYRA_DISAPPEARANCE_BOWL_4_OPTION_2 = "我会把西菲拉带回来",
	ZEPHYRA_DISAPPEARANCE_KETCH_1 = """早上你收到了凯奇的一封信。他想在镇上的郊区与你见面，并提供了如何找到他的详细信息。这可能是你找回西菲拉的唯一机会。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_1_OPTION_1 = "拜访凯奇",
	ZEPHYRA_DISAPPEARANCE_KETCH_2 = """西菲拉双手被绑在背后，眼睛蒙着，嘴巴塞住，站在他们旁边。尽管她的情况不对，但她看起来很好，让你怀疑这是否只是凯奇的另一种幻术。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_2_OPTION_1 = "*交出假碗* ",
	ZEPHYRA_DISAPPEARANCE_KETCH_2_OPTION_2 = "*交出真碗*",
	ZEPHYRA_DISAPPEARANCE_KETCH_2_OPTION_3 = "没有交易，我只是强行带走她",
	ZEPHYRA_DISAPPEARANCE_KETCH_3_3 = """— 你真傻。看来你根本不在乎这个女孩。好吧，我要你的头，强行拿走碗。

凯奇在空中做了一个简单的魔法手势，西菲拉消失在一股烟雾中。他的党羽向你冲锋。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_3_END = """经过长时间的战斗，你终于击败了凯奇的团队。在你能从他身上得到任何东西之前，他就死于伤口。这样，你夺回西菲拉的机会就为零...""",
	ZEPHYRA_DISAPPEARANCE_KETCH_3_1AND2 = """— 所以你是一个听话的[boy]。我想这次我原谅你之前杀我的企图，哈哈。那你可以继续养你的小宠物狐狸了。

他把西菲拉推向你的方向，命令她向前走。她犹豫着这么做，好像内疚在压着她。当她穿过场地的一半时，你把碗递给一个党羽。当西菲拉最终落入你的怀抱时，你意识到凯奇和他的人已经不在了。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_4 = """当西菲拉抬头看着你时，你帮助她摆脱束缚。你可以看到她的脸上流露出担忧和内疚的混合表情。

— 虽然我很感激，但你不应该把它送给他...""",
	ZEPHYRA_DISAPPEARANCE_KETCH_4_OPTION_1 = "反正那是假的",
	ZEPHYRA_DISAPPEARANCE_KETCH_4_OPTION_2 = "算了，你的安全更重要",
	ZEPHYRA_DISAPPEARANCE_KETCH_4_OPTION_3 = "别担心，我们可以再抢回来",
	ZEPHYRA_DISAPPEARANCE_KETCH_5_1 = """西菲拉茫然地看着你，不确定你是不是在开玩笑。最终，她明白你是认真的，笑了起来。

— 哈哈，真的吗。我没想到你这么聪明。呵呵，我可以想象他们发现后的表情...我想我应该从我选择的男人那里预料到这一点。从坏人手中救了我和那件文物。

— 所以你真的打破了凯奇的幻觉？这真的是我都喜欢的东西。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_5_2AND3 = """— 好的……谢谢你，我很高兴你能把我带回来。

— 所以你真的打破了凯奇的幻觉？这真的是我都喜欢的东西。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_5_OPTION_1 = "关于这个……我已经做出了承诺。",
	ZEPHYRA_DISAPPEARANCE_KETCH_5_OPTION_2 = "这对我这样有能力的人来说很自然",
	ZEPHYRA_DISAPPEARANCE_KETCH_5_OPTION_3 = "也许这只是因为它针对的是你而不是我",
	ZEPHYRA_DISAPPEARANCE_KETCH_6_1a = """你告诉西菲拉在幻觉之地的一次神秘遭遇，以及你与一个未知实体的承诺。

西菲拉看着你，脸上越来越痛苦。

— 你-你知道我无论如何都要搜寻那些文物吗？那样的话，我就不能再和你呆在一起了... 

齐菲拉低下头，慢慢地走开了。当她写完最后一行时，她的声音听起来很伤心。

— 谢谢你救了我。也许我们改期再见面。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_6_1b = """你告诉西菲拉在幻觉之地的一次神秘遭遇，以及你与一个未知实体的承诺。

— 嗯...这是一个奇怪的承诺。如果我不更清楚的话，我希望你能以这样的方式摆脱我。但你确实保留了圣碗，对吧？好吧，既然我的目标是找到所有文物，那我就和你呆在一起。

— 恐怕我不能告诉你发生了什么事。当我清醒过来的时候，我已经在他们的藏身处了，他们一路蒙住我的眼睛来到这里。我想他们已经计划用我作为诱饵至少几个星期了。我的表现真令人遗憾...""",
	ZEPHYRA_DISAPPEARANCE_KETCH_6_2 = """— 我们一点都不谦逊，是吗？但我跑题了——毕竟，你是我真正的救世主。

— 恐怕我不能告诉你发生了什么事。当我清醒过来的时候，我已经在他们的藏身处了，他们一路蒙住我的眼睛来到这里。我想他们已经计划用我作为诱饵至少几个星期了。我的表现真令人遗憾... """,
	ZEPHYRA_DISAPPEARANCE_KETCH_6_3 = """— 单凭意志力突破神术堪称奇迹。

— 恐怕我不能告诉你发生了什么事。当我清醒过来的时候，我已经在他们的藏身处了，他们一路蒙住我的眼睛来到这里。我想他们已经计划用我作为诱饵至少几个星期了。我的表现真令人遗憾... """,
	ZEPHYRA_DISAPPEARANCE_KETCH_6_OPTION_1 = "很高兴你没有受伤",
	ZEPHYRA_DISAPPEARANCE_KETCH_6_OPTION_2 = "他们没有对你做任何坏事?",
	ZEPHYRA_DISAPPEARANCE_KETCH_7_1 = """— 呵呵，谢谢你为我担心。我也担心他们也会伤害 [Master] 。

你注意到西菲拉是如何向你靠近的，在获救后寻求你的温暖。 

— 事实上，终于和你团聚可能让我有点太激动了...""",
	ZEPHYRA_DISAPPEARANCE_KETCH_7_2 = """西菲拉给你一个痛苦的眼神，但仍然能微笑。

— 我希望你不要问...""",
	ZEPHYRA_DISAPPEARANCE_KETCH_8 = """— 呵呵，这让你担心了吗？一想到我会被坏人猥亵和玷污？别担心，我不会让别人伤害我的。说到这里... 

你会注意到西菲拉在获救后如何向你靠近，寻求你的温暖。

— 我不会否认，我曾想过我最终能够与我的 [Master]团聚的那一刻。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_1 = "顺其自然",
	ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_2 = "拒绝",
	ZEPHYRA_DISAPPEARANCE_KETCH_9_2 = """狐狸女孩的耳朵在你把她拒之门外时垂了下来。她嘟着嘴，移开视线，在回家的路上默默地跟着你。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_9_1 = """感觉你进入了情绪，西菲拉把你从路上拖向最近的树。

— 原谅我的耻辱，但我们似乎都没有心情继续走下去...此外，你想为你的善举得到适当的奖励吗？

她没有多说什么，就吞咽着，靠在树上，把后面的衣服挪开，诱人地抬起尾巴，几乎就像一只发情的动物。当她用梦幻般的眼睛回头看你时，你很快就会发现她的私处因兴奋而完全湿润。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_10 = """凯奇: — 我抓不到 [him], 但我们应该可以用这个女孩换你想要的那个愚蠢的器具。

恶魔保持沉默，掩饰着她对神眷者的不满。至少他最终没有死。西菲拉双手被绑在头上，疲惫地从牢房门后看着他们。几名警卫驻扎在她的牢房旁。

凯奇: — 那么，我们应该试着教她一些礼貌吗？也许在玩的时候有点乐趣，嗨嗨...

恶魔: — 我强烈建议不要这样做。不管她的状态如何，如果我以这种方式威胁她，即使是我也不能保证她休眠的力量无动于衷。

凯奇: — 好吧，该死。你们听到老板的话了，伙计们——离我们的囚犯远点。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_11 = """由于西菲拉独自一人被关在禁闭室里，她的几个狱警无法完全放下对她的兴趣。

看守 A: — 伙计，我有一个月没喝酒了。

看守 B: — 是的，反正你也不能邀请任何人来，你的抱怨只会让事情变得更糟。

看守瞥了一眼安静地坐在栅栏后面的西菲拉。

看守 A: — 你知道，她还不错。难道我们不应该得到一些乐子吗？

看守 B: — 我不知道，老板很明确告诉我们根本不应该接近她。

看守 A: — 得了吧，她只是个小女孩，她不会告诉任何人的。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_12 = """当两名警卫都带着假笑走近西菲拉时，她不安地扭动着项圈，但无济于事。

看守 A: — 只要表现得好一点，我们就不会伤害你，呵呵。""",
	ZEPHYRA_DISAPPEARANCE_KETCH_13 = """由于西菲拉双手被绑，嘴巴塞住，她不得不避开这两个男人在强奸行为中完全迷失的方向，因为她幸福地没有意识到他们的状况——被困在幻觉中。这与她为自己倾倒的技巧没有太大区别，尽管没有那么恶心。

这似乎就是Zephyra在麻烦的情况下不怕完全独处的原因。""",
	ZEPHYRA_DISAPPEARANCE_GUARDS_1 = """当两名看守带着假笑走近西菲拉时，她不安地扭动着领带，但无济于事。

看守 A: — 只要表现得好一点，我们就不会伤害你，呵呵。

其中一名看守走近她，抓住她的衣服。他用力地扯下了她的衣服。西菲拉想反抗，但由于看守抓住她的下巴，她的尝试被打断了。

他拿出自己的阴茎，开始把它扫遍她的脸和嘴唇。厌恶和恐惧交织在一起，染上了西菲拉的脸，但她无法抗拒。她完全无助。

看守 A: — 现在，张嘴。""",
	ZEPHYRA_DISAPPEARANCE_GUARDS_2 = """ZEPHYRA尽可能地握紧下巴，试图摇头表示拒绝。但警卫的紧握并没有让她表达反对。

看守 A: — 想被揍一顿吗? 

警卫用另一只手捏她的鼻子。西菲拉别无选择，只能屈服并张开嘴，哪怕只是呼吸一口空气。但是，恢复呼吸能力的解脱很快被男人生殖器的味道所取代。在西菲拉再次合上它之前，守卫用力将他的阴茎推入了她的嘴里。""",
	ZEPHYRA_DISAPPEARANCE_GUARDS_3 = """看守A：现在才对嘛，好小狗。

看守 B: — 呵呵，我也想爽一爽，或者我应该从另一边开始？

看守把他的老二往里推，一直推到齐菲拉的喉咙。呼吸是一种奢侈，这些野兽似乎很快就不允许她呼吸了。她的眼睛开始流泪——这既是身体上的反应，也是精神上的反应。

看守开始移动他的臀部，用他的方式对付齐菲拉。粗暴地，完全无视她。她的嘴只是另一个用来娱乐的嘴巴。 

看守 A: — 这太好了！比城里的妓女好多了。我忍不住了...""",
	ZEPHYRA_DISAPPEARANCE_GUARDS_4 = """看守把他的精液射进了西菲拉的嘴里。她的舌头被阴茎压了下去，她甚至无法吞咽。强烈的气味挠着她的鼻孔和喉咙。但她必须忍受……也许他们会满足于只用她的嘴。如果她再忍受一点就好了...""",
	ZEPHYRA_DISAPPEARANCE_GUARDS_5 = """另一名警卫看到眼前发生的残忍事件，脱下裤子，开始自娱自乐。

看守 A: — 看在上帝的份上，你在干什么？！

看守 B: — 什么？我的意思是，她很性感，很克制。我也想要和她玩一玩！

看守 A: — 有点耐心。很快就轮到你了。在我再疯狂几次之后... 呵-呵...

西菲拉茫然地凝视着眼前的空间。她意识到一个可怕的事实：他们不会放过她。这种情况持续的时间将远远超过她所能承受的时间。没有人来帮忙...""",
	ZEPHYRA_DISAPPEARANCE_SEX_1 = """感觉你进入了情绪，西菲拉把你从路上拖到最近的树上。

- 原谅我的耻辱，但我们似乎都没有心情继续走下去...此外，你想为你的行为得到适当的奖励吗？

她没有多说什么，就吞咽着，靠在树上，把后面的衣服拉开，诱人地抬起尾巴，几乎像一只发情的动物。当她用梦幻般的眼睛回头看你时，你很快就会发现她的私处因兴奋而完全湿润。""",
	ZEPHYRA_DISAPPEARANCE_SEX_2 = """这景象太诱人了，忍不住。你急切地接受了她的邀请。当你走近时，露出你的阴茎，你开始在她湿漉漉的皮肤上摩擦。当你的皮肤碰到她的时候，西菲拉发出可爱的呜呜声。

— [Master]... 我们在露天，在中午…这不是让它更令人兴奋吗？ 

她是对的。随时可能有人来。你环顾四周，但只有你们两个。老实说，即使有人真的出现了，你现在也不会停下来。""",
	ZEPHYRA_DISAPPEARANCE_SEX_3 = """你的手沿着她的背部皮肤移动，抚摸着她，同时你往里面推得更深。西菲拉的尾巴急切地扭动着，尽管它有点挡住了去路。""",
	ZEPHYRA_DISAPPEARANCE_SEX_3_OPTION_1 = "*温柔地抱着她*",
	ZEPHYRA_DISAPPEARANCE_SEX_3_OPTION_2 = "*粗暴*",
	ZEPHYRA_DISAPPEARANCE_SEX_3_OPTION_3 = "*抓住尾巴*",
	ZEPHYRA_DISAPPEARANCE_SEX_4_1 = """你慢慢调整自己，让她更放松。她在你的触摸下变得柔和，明显放松了。

她的尾巴摆动得越来越少，越来越慢。

你的手在她的头发上滑动，然后顺着她的背。你抚摸着她的皮肤。它摸起来柔软温暖。

— 在我惹了这么多麻烦之后，你竟然如此温柔。

她扭动身体，把头转向你。她的一只手继续用树作为支撑，而另一只手则朝着你的脸移动。她摸了摸你的头，把它指向她的嘴唇。你们两个热情地接吻。

你的动作节奏加强。你注意到西菲拉的膝盖开始颤抖，变得虚弱。她的叹息变成了呻吟。起初很安静，但随着每一次推动，声音越来越大。很快，它们响彻了整个田野。

她的声音带有一点羞恼，但她的身体讲述了另一个故事。她完全沉浸在快乐之中。你也是。""",
	ZEPHYRA_DISAPPEARANCE_SEX_4_2 = """你抓住西菲拉，用力把你的阴茎往里推，让她呼气作为回应。然而，她的潮湿仍然让这很容易，她没有抗议。

— 啊.. [Master] [name]... 对不起…给你添麻烦了…

你打她的屁股。又一声叹息伴随着拍打的声音。

— 请-请…啊…宽恕… 

你无视她的恳求，再扇她一巴掌。尽管她一直求饶，但她还是很享受。

你的动作节奏加强。你注意到西菲拉的膝盖开始颤抖，变得虚弱。她的叹息变成了呻吟。起初很安静，但随着每一次推动，声音越来越大。很快，它们响彻了整个田野。

她的声音带有一点羞恼，但她的身体讲述了另一个故事。她完全沉浸在快乐之中。你也是。 """,
	ZEPHYRA_DISAPPEARANCE_SEX_4_3 = """当你把你的阴茎推到她身上时，你用手抓住她的尾巴，让她惊讶地尖叫。

— 你-你在干什么？！不要这么突然抓住它…它很敏感！

你觉得你的手越来越紧张，但她的阴部也会更拼命地挤压你。过了一会儿，西菲拉似乎不再抗拒你对她脆弱部位的占有欲，让你自私地抚摸它。

你的动作节奏加强。你注意到西菲拉的膝盖开始颤抖，变得虚弱。她的叹息变成了呻吟。起初很安静，但随着每一次推动，声音越来越大。很快，它们响彻了整个田野。

她的声音带有一点羞恼，但她的身体讲述了另一个故事。她完全沉浸在快乐之中。你也是。 """,
#	ZEPHYRA_DISAPPEARANCE_SEX_4 = """你的动作节奏加快了。你注意到西的膝盖开始颤抖和虚弱。她的叹息被呻吟所取代。起初很安静，但随着每一次推压，声音越来越大。很快，它们就响彻整个场地。
#
#— 天啊... [master]... 你真是个野蛮人...如此有力...抓住女孩的尾巴，甚至..!
#
#她的声音带有一点羞恼，但她的身体讲述了另一个故事。她完全沉浸在快乐之中。你也是。""",
	ZEPHYRA_DISAPPEARANCE_SEX_5 = """当你的身体接近其快乐承受能力的极限时，你让它在西菲拉体内全部释放。你感觉到她的尾巴失去了力量，不再试图挣脱。当你放开它时，它只是沿着她的屁股往下垂。如果不是因为她用来支撑的树，西菲拉自己也会以类似的方式倒下。 

— 那...有点...比我预想的更激烈...

西菲拉站起来整理衣服。她对你傻笑，拉着你的手。

— 现在你得到了适当的奖励, [master]。我们回家吧。""",
	
	ZEPHYRA_BRUSH_OPTION_0 = "有一件魔法物品我想知道...",
	ZEPHYRA_BRUSH_1 = """你问梅尔关于你被困在幻觉中记忆中的神秘画笔。

- 我想我已经读过几次了。这让我想起了狐尾刷。一件起源于古代的虚幻工艺品。有人说它有多个副本，但众所周知，它们很难获得和保存，部分原因是它们往往会在不同所有者之间或随着年龄的增长而改变形式。这些变化背后的原因尚不清楚。

- 好吧，如果你能回忆起它的外观，我们可以试着为你运行一个搜索咒语。把它画得尽可能像。而且你要支付1000金币，你要知道魔法羊皮纸并不便宜。""",
	ZEPHYRA_BRUSH_1_OPTION_1 = "同意 (智慧检定) (支付 1000 金币)",
	ZEPHYRA_BRUSH_1_OPTION_2 = "我晚点回来",
	ZEPHYRA_BRUSH_2_1 = """{color=green|成功}

你已经成功地画出了一个相当准确的复制品，复制了你在梦中看到的东西。在把它交给梅尔并完成搜索仪式后，咒语指向一个魔法地图位置和一些古老的废墟，这些废墟似乎有你想要的东西。抄下给他们的指示后，你离开了梅尔的办公室。""",
	ZEPHYRA_BRUSH_2_2 = """{color=red|失败}

尽管你尽了最大的努力，但你的画太业余了，画笔的细节也太模糊了。咒语闪烁并失败，让你后悔为此付出代价 """,
	ZEPHYRA_BRUSH_3 = """当你穿过灯光昏暗的大厅时，在尽头，你终于发现了一个临时搭建的小底座，上面放着一支画笔。毫无疑问，这就是你要找的那个。然而，当你走近时，你注意到另一个被黑暗光环包围的剪影也从另一边朝着底座的方向移动。""",
	ZEPHYRA_BRUSH_3_OPTION_1 = "打招呼",
	ZEPHYRA_BRUSH_3_OPTION_2 = "抢画笔 (physics check)",
	ZEPHYRA_BRUSH_4_1 = """当你把它叫过去的时候，你辨认出它的细节，很明显，它是一个长着黑色大狐尾的女孩，穿着与环境相适应的深色衣服。她不注意你的话，直到她漫不经心地拿起画笔转向你。她悠闲地转动着手中的画笔，带着一种令人费解的表情看着你。


- 这不属于你，陌生人。也许你是个小偷？你需要这个给谁？""", 
	ZEPHYRA_BRUSH_4_2_GOOD = """{color=green|成功}

你设法跑过了剪影，但当你的手伸进去抓住画笔时，画笔被后面的阴影猛地拉了出来，它比你更快的抓住了画笔。当你转向你的对手时，你意识到这是一个长着黑色大狐尾的女孩，穿着适合环境的深色衣服。她悠闲地转动着手中的画笔，带着一种难以理解的表情看着你。

— 这不属于你，陌生人。也许你是个小偷？你需要这个给谁？""",
	ZEPHYRA_BRUSH_4_2_BAD = """{color=red|失败}

你试图抢夺它，但没有成功。你意识到这个剪影是一个长着黑色大狐狸尾巴的女孩，穿着适合环境的深色衣服。直到她漫不经心地拿起画笔，她才把你放在眼里。她悠闲地转动着手中的画笔，带着一种难以理解的表情看着你。

— 这不属于你，陌生人。也许你是个小偷？你需要这个给谁?""",
	ZEPHYRA_BRUSH_4_OPTION_1 = "我",
	ZEPHYRA_BRUSH_4_OPTION_2 = "朋友",
	ZEPHYRA_BRUSH_4_OPTION_3 = "女孩",
	ZEPHYRA_BRUSH_5_1 = """女孩面无表情地看着你，但你可以看出她并不信服。要么是因为她认为你撒谎了，要么是她认为你不配。

— 忘了画笔。离开这里。再见

你还没来得及说什么，女孩就消失在阴影中，好像她从来没有出现过一样。""",
	ZEPHYRA_BRUSH_5_2 = """— 你说的朋友？很好，那你就可以拥有它。

女孩把画笔放回基座上，朝出口走去。""",
	ZEPHYRA_BRUSH_5_3 = """— 你说是个女孩吗？也许你爱上这个女孩了吗？

这个问题表达得尽可能地漠不关心，但感觉她真的对你的答案感兴趣。""",
	ZEPHYRA_BRUSH_5_3_OPTION_1 = "是",
	ZEPHYRA_BRUSH_5_3_OPTION_2 = "否",
	ZEPHYRA_BRUSH_6_1 = """- 你相信这样的事情会帮助你吗？胡说八道。好吧，拿你的奖品。""",
	ZEPHYRA_BRUSH_6_2 = """- 你傻吗？那你为什么要走这么远……不管怎样。

女孩把画笔放回基座上，朝出口走去。""",
	ZEPHYRA_BRUSH_6_OPTION_1 = "等等，你叫什么名字?",
	ZEPHYRA_BRUSH_6_OPTION_2 = "你就这样离开吗?",
	ZEPHYRA_BRUSH_6_OPTION_3 = "*什么也不说，拿起画笔*",
	ZEPHYRA_BRUSH_7_1 = """女孩停下来，瞟了你一眼。

— ...西菲拉。 现在，请原谅，我还有更重要的事情要处理。

你还没来得及说别的，她已经走了。过了一会儿，你们就开始怀疑她一开始是否在这里。""",
	ZEPHYRA_BRUSH_7_2 = """女孩短暂地转向你，她的表情暗示你问了一些非常愚蠢的问题。

— 天快亮了。到那时我还不是那种人。

你还没来得及说别的，她已经走了。过了一会儿，你们就开始怀疑她一开始是否在这里。""",
	ZEPHYRA_BRUSH_7_3 = """当你拿起画笔转身后，她已经走了。你质疑自己，她一开始是否在这里。""",
	ZEPHYRA_BRUSH_8_OPTION_0 = "*归还画笔*",
	ZEPHYRA_BRUSH_8 = """你拿着画笔递给西菲拉。西菲拉茫然地盯着它看了一会儿，终于反应过来。你很少看到这个女孩无话可说。

— 你是怎么得到的？..你怎么知道...不，我想你就是这么做的。你知道，你不应该这么擅长纠正我的错误。我的意思是，我已经给了你我所有的支持，我不能再给你了，哈哈...""",
	ZEPHYRA_BRUSH_9 = """西菲拉拿起画笔，画笔在她手中微微闪烁。光线在她的眼睛里反射了一会儿。

— 你知道，我想告诉你你所做的一切。告诉你我所知道的关于我们任务的一切。也就是说，如果你不介意的话，这可能需要一段时间。""",
	ZEPHYRA_BRUSH_9_OPTION_1 = "我有时间",
	ZEPHYRA_BRUSH_9_OPTION_2 = "我不想知道",
	ZEPHYRA_BRUSH_10 = """当西菲拉开始她的故事时，你坐在她旁边。

— 尽管不是每个人都相信造物主，但你已经亲眼目睹了他们的真正神力，比无知的大众要好一点。即使有像阿利奥斯这样乐于助人的好神，也有相反的神。邪恶的神试图腐蚀和毁灭我们的生活。你可以说我们自己管理得足够好，但他们确实潜伏在阴影中。 

— 从前，有一个伟大、善良的男人和慈爱的丈夫，他在一个小村庄过着正直的乡村生活。然而，一场饥荒发生了，他的家人正在挨饿。当时，一个恶神的仆人来到了这个村庄。他给那个男人提供食物来养活他的家人。代价是他们的一个邻居的福祉，他们也一直在挨饿。

— 尽管他们度过了饥荒，邻居们还是对他们产生了怀疑，这个人也越来越内疚。他的脑子里慢慢地充满了黑暗的想法，直到有一天，他因为一场小争吵勒死了妻子。我亲眼看到这个人堕落了。那个人是我的父亲。""",
	ZEPHYRA_BRUSH_11 = """— 说实话，在绑架事件发生后，无论是好是坏，我都想起了我的过去。从我出生起，我就是父母和家人的负担——虚弱、健康不佳，大多数时候卧床不起，但他们从未放弃我。然而，我父亲在母亲去世后不久就去世了，我们不能留在村里，所以我和兄弟离开了。我们在离另一个村庄几英里的地方找到了一所废弃的小房子，并在那里定居下来。

— 他非常照顾我，尤其是考虑到他的年龄，在村里帮忙换食物。但在他被土匪抓住后，一切都结束了。他们让他在杀了他之前告诉他们我们家的情况。我不知道是不是父亲的诅咒让我们走到了最后。 """,
	ZEPHYRA_BRUSH_12 = """她的哥哥没有回来，女孩当时也睡不着。当她意识到发生了可怕的事情时，她听到外面传来粗俗的喊叫和笑声。当她发现陌生人闯入他们的房子时，恐惧深深地袭来。她尽可能安静地从后门偷偷溜出房子，开始跑进森林。仅仅过了一会儿她意识到背后已经燃起了火焰。

她不顾一切地逃跑了。当她试图穿过树叶时，她的身体因疼痛而灼热。害怕被抓的恐惧驱使她向前走，她的身体从未经历过如此剧烈的运动。她能走得这么远，最终还是倒下了，这真是个奇迹。""",
	ZEPHYRA_BRUSH_13 = """过了一段未知的时间，她才恢复了理智。如果她身上还有力气的话，她会惊讶地发现自己还活着。她几乎没能把脸从潮湿的泥土中抬起来，就靠在一棵树上。她平时白色的头发和尾巴都被泥土弄脏了，眼泪从脸上掉了下来。

— 我讨厌这个...我讨厌这个虚弱愚蠢的身体...没用...

你真的讨厌它吗？-这个声音在女孩的脑海里产生了共鸣，那不是她自己的声音。

现在有什么可恨的？你是自由的，可以做你想做的事。

— 你为什么这么说...我只想结束这一切...""",
	ZEPHYRA_BRUSH_14 = """你想死吗？这一切很快就会结束。

女孩没有回应。她并没有活那么久，她的一生也没有什么意义上的多事之秋。就在此时此刻，她没有什么可失去的，也没有什么可期待的，但有什么东西仍然让她的心跳和灵魂充满希望。

— 我…想活下去...不管怎样。

随着她的决定，声音越来越大。神可怜她，用它的一点力量，实现了女孩的愿望。奇迹在任何人看不见的情况下发生了，女孩被治愈了。""",
	ZEPHYRA_BRUSH_15 = """— ...之后，我向阿利奥斯请求再帮我一个忙。我想忘记我之前经历的一切。这就是你所认识的西菲拉的存在方式。好吧，无论如何，这就是我的故事。

西菲拉讲完了她的故事，低下头表示顺从，紧张地等待着你的反应。""",
	ZEPHYRA_BRUSH_15_OPTION_1 = "你不用再受苦了，我会一直保护你",
	ZEPHYRA_BRUSH_15_OPTION_2 = "现在都已经过去了，不要责怪自己",
	ZEPHYRA_BRUSH_15_OPTION_3 = "你真是在浪费我的时间",
	ZEPHYRA_BRUSH_16_1AND2 = """听到这句话，西菲拉突然抓住胸口，像在痛苦中一样退缩。

— Aaaaah... Aahh... 你...不能这样做...

她假装向你崩溃，把脸埋在你的胸口。

— 你...啊...不可怜我少女的心吗?""",
	ZEPHYRA_BRUSH_16_3 = """- 抱-抱歉…我不该告诉你这件事，我…抱歉。。。

西菲拉跑出了房间，只留下你一个人，一整天都没有露面。""",
	ZEPHYRA_BRUSH_17 = """当你开口回应时，西菲拉猝不及防地抓住了你，立即用嘴唇封住了你的嘴唇。她缓慢而绝望的吻终于结束了，让你忘记了你要说的话。

— 不，你不能那样做。我一辈子都被别人照顾着。轮到我保护我爱的人了。

西菲拉顽皮地摇着尾巴，带着无与伦比的崇拜微笑着。

— 但是...如果你今晚照顾好我，我不会抗议的。""",
	ZEPHYRA_BRUSH_18 = """— 哈，真的吗？很好，我想你就是这样。好吧，我不会再打扰你了，不过，再次感谢你。""",
	ZEPHYRA_BRUSH_19_OPTION_0 = "关于你以前见过的女孩...",
	ZEPHYRA_BRUSH_19 = """你告诉西菲拉你在找回画笔时遇到了一个自称也是西菲拉的女孩。

— 那-那可能是我姐妹。这似乎是她开玩笑的方式，她很奇怪。你不是真的认为我是个骗子吧？""",
	ZEPHYRA_BRUSH_19_OPTION_1 = "告诉我更多关于你姐妹的信息，我以为你没有亲戚",
	ZEPHYRA_BRUSH_20 = """— 嗯，这并不是说我们是血亲。我不知道该怎么描述，只是……我们感觉自己是远亲或熟人。我从来没有想过这一点。我认为她是个好女孩，尽管我很少接触她。 """,

	
	
	
	AMELIA_INTRO = """一名信使刚刚抵达您的庄园，上面有一封装饰着仆人协会徽章的信。这封信是一张传票，要求您到仆人协会调查涉及其成员之一的"可疑活动"。请注意澄清，这是一个请求，尊重您的日程安排和时间限制。""",
	AMELIA_MAIN_GUILD_1 = """走进行会首领的办公室，一个惊喜在等着你。迎接你的不是阿米莉亚，而是一个陌生的人——一个人类。他很高，几乎顶到天花板，和蔼的脸与他威严的身高形成了鲜明的对比。

— 怎么了? 啊, 市长 [name], 欢迎。有什么我可以帮你的吗？请原谅我，但如果你有任何询问或要求，我将不胜感激。遗憾的是，目前我的日程已经满了。
""",
	AMELIA_MAIN_GUILD_1_OPTION_1 = """阿米莉亚呢?""",
	AMELIA_MAIN_GUILD_1_OPTION_2 = """忙什么呢?""",
	AMELIA_MAIN_GUILD_1_OPTION_3 = """我被请求来回答一些问题。""",
	AMELIA_MAIN_GUILD_2_1 = """— 很遗憾，她……嗯……目前不在。我现在负责行会事务。我叫诺兰。如果你需要行会方面的帮助，我会在这里为你提供帮助。但是，如果你的事情与阿米莉亚有关……嗯，恐怕必须暂时推迟。""",
	AMELIA_MAIN_GUILD_2_2 = """—行会及其成员出现了一些不可预见的事态发展。但是，[Name]市长，您不必担心。我可以向您保证，我们的业务互动不会受到这些事件的影响。尽管如此，在重新步入正轨之前，需要一段短暂的调整期来适当适应这种新情况。""",
	AMELIA_MAIN_GUILD_2_3 = """诺兰: — 嗯……很有趣。我明确地与我们的秘书沟通过，我们无意用这些琐碎的事情给你带来不便。""",
	AMELIA_MAIN_GUILD_2 = """当另一名男子冲进办公室时，办公室的门突然打开。他体格丰满，身材相对矮小。他的着装无疑散发出一种富裕和崇高的社会地位。

行会会员: 诺兰，有关于失踪奴隶的消息吗？我的客户要求解释。我不能让他们蒙在鼓里！哦我看你有客人了。市长，我应该如何为你效劳？

诺兰: 看来我们的秘书发现有必要浪费 [Name] 市长的宝贵时间，对阿米莉亚的行为进行无端的调查。我正在向他澄清，他的证词不会—
""",
	AMELIA_MAIN_GUILD_3_1 = """行会会员: — 太好了！我们需要所有能得到的信息。那个狡猾的女人太会掩饰自己的行踪了。

看到你眼中的困惑，诺兰重重地叹了一口气。

诺兰: — 市长，既然你已经来了，我想我应该给你一个恰当的解释。你看，阿米莉亚失踪了。她的任务是把新奴隶送到公会。然而，在她昨天晚上离开后，她没能到达。无论是她还是奴隶都无法解释。

行会会员: — 对。那只狡猾的猫逃跑了。总是领先一步，那个女人！
""",
	AMELIA_MAIN_GUILD_3_2 = """诺兰: — 我们已经开始调查她的下落，我必须承认，我们的调查结果相当有启发性。由于怀疑走私，公会已经对她的活动进行了一段时间的审查。然而，可以肯定的是，她比我们领先一步。我相信她可能已经躲藏起来了。

行会会员: — 带上我们的商品只是为了最后一次惹我们。
""",
	AMELIA_MAIN_GUILD_3_3 = """诺兰: — 鉴于您在业务上与阿米莉亚的频繁互动，我们推测您可能了解了她的潜在行踪。然而，您似乎与我们一样出乎意料。
""",
	AMELIA_MAIN_GUILD_3_OPTION_1 = """看来你知道她发生了什么。""",
	AMELIA_MAIN_GUILD_3_OPTION_2 = """那它和我有什么关系？""",
	AMELIA_MAIN_GUILD_3_OPTION_3 = """需要我帮忙吗？""",
	AMELIA_MAIN_GUILD_4_1 = """诺兰: — 我们已经控制住了一切，市长[姓名]，所以你不需要关心这件事——我相信我已经说过了。 

行会会员: — 诺兰，你在说什么？我们需要所有能得到的帮助。这里的市长好心地伸出援助之手。你能不能至少帮我们找到失踪的奴隶？

诺兰又叹了一口气。有一瞬间，你注意到他脸上有疲惫的迹象，但当他看着你时，他的表情很快变回了温柔的微笑。

诺兰: — 如果你有时间,  [name] 市长, 我们将感谢你的帮助。 """,
	AMELIA_MAIN_GUILD_4_2 = """诺兰: — 根据我们的消息，阿米莉亚在城门从商队中接走了奴隶。

行会会员: — 是的，所以即使他们想逃离城市，他们也无法逃离。他们无法越过警卫。所以他们必须在城墙内。由于他们不是本地人，他们不了解这个城市。我怀疑他们是否会远离被接走的地方。

诺兰: — 确实如此。我想我没有什么要补充的。""",
	AMELIA_MAIN_GUILD_4_3 = """诺兰: — 我们经常处理的商队有很多奴隶，我们不知道阿米莉亚此时捡到了哪些，所以恐怕我们无法向您提供任何描述。

行会会员: — 但他们是没有主人的奴隶。最有可能的是，他们穿着破烂的衣服，头发很脏，脖子和手腕上戴着镣铐。这样的事情应该很容易在人群中发现。他们很可能也感到困惑和害怕。没有什么可补充的，但这就是我们了解的全部。 """,
	AMELIA_MAIN_GUILD_4_OPTION_1 = """知道我可以从哪里开始搜索吗？""",
	AMELIA_MAIN_GUILD_4_OPTION_2 = """你能给我描述一下奴隶吗？这样我就知道我在找什么了？""",
	AMELIA_MAIN_GUILD_4_OPTION_3 = """我会帮你的。""",
	AMELIA_MAIN_GUILD_5 = """行会会员: — 太棒了！很高兴看到我们可以依靠市长。对吧，诺兰？

诺兰: — 我完全同意。

行会会员: — 哦，是的。我必须回到客户那里。很高兴与你交谈，市长先生，但是...职责召唤。

诺兰: 如果你有任何进一步的询问，你知道在哪里可以找到我。[name] 市长，我们祈祷你的追捕成功。 """,
	AMELIA_MAIN_INTERLUDE_1 = """—  [name] 市长，你还有什么要进一步的询问吗？我时间有点紧，但如果你需要，我可以抽出时间帮助你。""",
	AMELIA_MAIN_INTERLUDE_2 = """— 啊， [name] 市长。我们对你的帮助感激不尽。多亏了你的帮助，一些奴隶已经回到了我们身边。尽管仍有一些遗漏，但您已经为我们提供了出色的服务。现在，你还有什么要进一步的询问吗？我有点时间紧迫，但如果你需要的话，我可以抽出时间来帮助你。""",
	AMELIA_MAIN_INTERLUDE_OPTION = """没事了，你自己忙吧。""",
	AMELIA_SLAVE1_1 = """当你穿过城市街道时，你的注意力被一对乞讨的孩子吸引到了一个板条箱附近，这个板条箱奇怪地位于人行道的中心。

孩子 1: — 我告诉过你，它动了！我们应该告诉警卫或其他人！

孩子 2: — 他们只会说你在胡编乱造，然后再打我们一次。来吧，别当胆小鬼！我们会自己检查的。

孩子 1: — 但是...如果里面有怪物怎么办？如果是个哥布林呢？或者更糟...""",
	AMELIA_SLAVE1_1_1 = """Kid 2: — 如果这个怎么办，如果那个怎么办！在我们检查之前我们永远不会知道。不要害怕！

孩子 1: — 不，不，不！我要带一些成年人来。我不会靠近那个板条箱！

孩子 2: — 等等... 啊!

孩子们跑了。几分钟后，您可以观察到板条箱的盖子微微抬起。一对狼耳朵冒出，后面跟着一双绿色的眼睛。眼睛在盯着你之前仔细地打量周围的环境。他们惊讶地张大了嘴巴，盖子很快又合上了。""",
	AMELIA_SLAVE1_2_1 = """同样的一双绿眼睛，现在充满了泪水，从里面战战兢兢地凝视着你。一个狼人女孩，从外表上看是奴隶，蜷缩在里面。也许是仆人行会失踪的人之一？

奴隶女孩: — 我……我没有躲起来，不，不！我是我只是听从命令！就是这样！主人的命令！""",
	AMELIA_SLAVE1_2_2 = """奴隶女孩: — 我不能说。他们……他们告诉我不要和陌生人说话！是的！""",
	AMELIA_SLAVE1_2_3 = """奴隶女孩: — 我……我在守护这个盒子！它可能看起来不像，但对我的主人来说是一个非常重要的盒子！我负责守护它！""",
	AMELIA_SLAVE1_2_OPTION_1 = """真的，你主人是谁？""",
	AMELIA_SLAVE1_2_OPTION_2 = """你的主人到底命令你做什么？""",
	AMELIA_SLAVE1_2_OPTION_3 = """你能告诉我真相吗?""",
	AMELIA_SLAVE1_3_1 = """狼人女孩失声痛哭。

奴隶女孩: — 我-我-我太害怕了！那个善良的猫人带我和其他人去了某个行会，但后来我们遭到了袭击！拿着刀和剑的人！他们把她带走了！我只是跑出去躲在这里，不知道该怎么办！他们会因为我试图逃跑而惩罚我吗？
""",
	AMELIA_SLAVE1_3_2 = """奴隶女孩: — 她有蓬松的耳朵和一件非常漂亮的蓝色连衣裙！她说她的名字叫阿米莉亚，她要带我们去某个行会...""",
	AMELIA_SLAVE1_3_3 = """奴隶女孩: — 我不知道！事情发生得太快了，天很黑！我什么也没看到。但他们抓住了猫人并把她带走了。我不知道在哪里。我该怎么办？我以为他们会杀了我！""",
	AMELIA_SLAVE1_3_OPTION_1 = """猫人？她长什么样？""",
	AMELIA_SLAVE1_3_OPTION_2 = """谁袭击了你?""",
	AMELIA_SLAVE1_3_OPTION_3 = """你现在应该去仆人行会""",
	AMELIA_SLAVE1_4 = """奴隶女孩: — 哦-哦，好吧……我现在就去那里。我希望我不会再遇到那些可怕的男人...""",
	AMELIA_SLAVE2_1 = """在城市街道上漫步时，一个奴隶突然从拐角处出现，与你相撞。她向后倒在地上，开始揉头。

奴隶女孩: — 哎哟!

突然，一群警卫从同一个拐角处出现，追着她跑。 """,

	AMELIA_SLAVE2_1_1 = """

警卫 1: — 找到了！抓住她!
奴隶女孩: 不！不！我什么也没做！别抓我!

警卫 1: — 我们要收留你，你这个淘气的女孩。难道你不知道逃跑的警卫和拒捕是一样的吗？我们可以为此把你关起来！

警卫 2: — 是吗...那你为什么跑？很明显你在隐瞒什么。我们要审讯你...真正彻底的...呵-呵-呵。
""",
	AMELIA_SLAVE2_1_OPTION_1 = """够了。我是她的主人。""",
	AMELIA_SLAVE2_1_OPTION_2 = """难道你没有真正的罪行要制止吗？回去工作，否则我会举报你的。 """,
	AMELIA_SLAVE2_1_OPTION_3 = """*抓住女孩的手跑*""",
	AMELIA_SLAVE2_2 = """Guard 2: — 真的，现在？我们应该相信你的话吗？

警卫 1: — 嘿...这不是市长吗？

警卫 2: — 哈?! 真的?

警卫 1: — 是的! 啊,抱歉, [sir]。我们发现奴隶在城市里走来走去，当我们试图问她问题时，她就开始跑了。我们认为她可能犯罪了，所以我们不得不追她。
""",
	AMELIA_SLAVE2_2_OPTION_1 = """没事。你可以回去工作了。""",
	AMELIA_SLAVE2_2_OPTION_2 = """是这样吗？这就是发生的事情吗，奴隶？""",
	AMELIA_SLAVE2_3_1 = """警卫 1&2: — 是, [sir]!

警卫们互相交换目光。其中一个耸耸肩膀，他们立即离开了。""",
	AMELIA_SLAVE2_3_2 = """警卫 1: —  来吧，我们不需要更多麻烦了。

警卫 2: —  我会记住你的，婊子。祈祷我不会再绊倒你。

警卫立即离开。""",
	AMELIA_SLAVE2_3_3 = """警卫 2: —  你确定吗？那些逃跑的人可以随我们玩，你要知道，我可以玩疯他们！

警卫 1: —  够了，我们回营房去吧。

警卫 2: —  好的，好的。但如果 [mister] 市长需要任何帮助... 

警卫 1: —  闭嘴。你想再次被停职吗？

警卫 2: —  啊，好！我马上走！

警卫立即离开。你可以听到他们继续争吵一会儿，直到你看不见他们。""",
	AMELIA_SLAVE2_3_4 = """警卫 1: —  嘿! 你! 站住!

你需要一段时间才能在你和警卫之间建立足够的距离，但你成功地避开了他们。现在你和女孩现在一条小巷里。她屏住呼吸后，对你说:""",
	AMELIA_SLAVE2_4 = """奴隶女孩: — 不……他们是-

警卫 2: 来吧，小姑娘。一切都很好。你找到了你的 [master]，我们没有理由再质疑你了。结局很好，对吧？没必要搞的大家不愉快。 

奴隶女孩: — 是-是的...事情就是这样。""",
	AMELIA_SLAVE2_4_OPTION_1 = """好吧。你可以回去执勤了，警卫。""",
	AMELIA_SLAVE2_4_OPTION_2 = """你在撒谎。到底发生了什么?""",
	AMELIA_SLAVE2_5 = """奴隶女孩: —  我在去仆人行会的路上，他们想打我。我拒绝了，但后来他们想袭击我...

警卫 2: —  你这个小混蛋！那是个谎言！她看起来很可疑，我们试图拘留她！我们在做我们的工作！""",
	AMELIA_SLAVE2_5_OPTION_1 = """你可以走了。但如果我发现你又在浪费时间，你就可以去找一个新工作了""",
	AMELIA_SLAVE2_5_OPTION_2 = """那我就向你的上级反应，由你的上级决定。现在回到你的岗位上。""",
	AMELIA_SLAVE2_6 = """警卫 2: —  是吗？你到底是谁？这些自由反叛者之一?

警卫 1: — 嘿...这不是市长吗？

警卫 2: —  啊？！真的？呃…抱歉, [sir]。你知道这个奴隶是谁的吗?""",
	AMELIA_SLAVE2_6_OPTION_1 = """我知道，你该走了。""",
	AMELIA_SLAVE2_6_OPTION_2 = """ 我会找到的。不需要你的帮助。""",
	AMELIA_SLAVE2_7_1 = """奴隶女孩: —  感谢你的帮助, [sir]！我正在前往仆人行会，这时这些警卫出现了。他们的眼睛真的很吓人，所以我觉得他们想对我做一些可怕的事情！我不知道该怎么办，所以我就跑了。

你知道仆人行会在哪儿吗, [sir]?  女主人阿米莉亚说我应该被送到那里...""",
	AMELIA_SLAVE2_7_2 = """哦，你认识她吗？她从市场上接了我和另外两个人，我们正在去行会的路上，这时……一些武装人员包围了我们。我以为他们只是想抢劫，但后来他们开始说要服从命令。我真的不明白他们在说什么。

他们扭起她的胳膊，把她放进马车里。我们以为那些人会回来找我们，所以我们逃跑了...""",
	AMELIA_SLAVE2_7_3 = """如果你告诉我怎么去那里，呃，我不是很幸运，但我不会连续三次遇到任何事情。对吧？""",
	AMELIA_SLAVE2_7_OPTION_1 = """阿米莉亚怎么了?""",
	AMELIA_SLAVE2_7_OPTION_2 = """你能自己去行会吗？""",
	AMELIA_SLAVE2_7_OPTION_3 = """你自己去行会吧""",
	AMELIA_SLAVE2_8 = """奴隶: 谢谢你, [master]。我现在就去那里。我希望他们不会因为我逃跑而惩罚我。这不是我的错...""",
	AMELIA_SLAVE3_1_1 = """在一条小巷里，你发现一个深色头发的年轻人站着，靠在墙上，双臂交叉。他穿着破旧的衣服——从外表上看，他是一个奴隶。当他注意到你时，他站得很直。

奴隶: —  你是 [name]吗？阿米莉亚派我来的。""",
	AMELIA_SLAVE3_1_2 = """— 我昨天和她在一起。我被卖给了仆人行会。她本应该把我送到那里，但……事情发生了转折。""",
	AMELIA_SLAVE3_1_3 = """她处于危险之中，需要你的帮助。她告诉我去找你，只有你一个人。她说行会不安全。""",
	AMELIA_SLAVE3_1_OPTION_1 = """你是谁?""",
	AMELIA_SLAVE3_1_OPTION_2 = """阿米莉亚在那里?""",
	AMELIA_SLAVE3_1_OPTION_3 = """说详细点""",
	AMELIA_SLAVE3_2_1 = """奴隶: — 我们遭到伏击时，阿米莉亚正带我和另外两个女孩去仆人行会。武装人员带走了阿米莉亚。我跟着他们。我想把她救出来，但她说太危险了，我应该去寻求帮助。她让我找你，只找你。仆人行会不可信，她说。我可以告诉你他们把她关在哪里。""",
	AMELIA_SLAVE3_2_2 = """我不知道。她只说了这么多。行会是不可信任的，你是我唯一应该全盘托出的人。""",
	AMELIA_SLAVE3_2_3 = """我跟着男人们来到一辆马车上。当他们把阿米莉亚放进马车时，我偷偷靠近，藏在车底，车轮之间。等了一夜，然后偷偷溜了进去，找到了他们的监狱。不过，她没有把我的生命置于危险之中，她说我应该独自溜出去找你。""",
	AMELIA_SLAVE3_2_4 = """— 我想是雇佣兵。他们全副武装。不过我不知道是谁雇的。""",
	AMELIA_SLAVE3_2_OPTION_1 = """这是什么意思？为什么行会不能被信任？""",
	AMELIA_SLAVE3_2_OPTION_2 = """如果她被带走了，你是如何找到她的？""",
	AMELIA_SLAVE3_2_OPTION_3 = """谁把她带走了?""",
	AMELIA_SLAVE3_2_OPTION_4 = """好吧，他们把她关在哪里?""",
	AMELIA_SLAVE3_3 = """— 这是城郊一个洞穴里的营地。

奴隶告诉你如何到达那里，然后你在地图上记下。

— 还有什么我能帮忙的吗？""",
	AMELIA_SLAVE3_3_OPTION_1 = """去行会。如果他们有什么可疑之处，我们不希望他们怀疑任何事情。""",
	AMELIA_SLAVE3_3_OPTION_2 = """你可以随心所欲了。""",
	AMELIA_SLAVE3_4_1 = """— 好的。我会的。请救她。她是个好人。无论发生什么，她都不应该这样。""",
	AMELIA_SLAVE3_4_2 = """— 不过，请快点。谁知道他们打算对她做什么。""",
	AMELIA_PRISON_1 = """打败首领后，你下楼梯进入一个似乎是地牢的地方。一排排空荡荡的牢房蔓延至远处的黑暗。在最远的牢房里，你看到阿米莉亚跪着，被锁在墙上。

— 我开始担心我会不得不适应囚犯的新生活，但我似乎不应该怀疑你。我相信上面的人已经被处理了？你介意放开我吗？""",
	AMELIA_PRISON_1_OPTION_1 = """在你解释发生了什么之前不行。""",
	AMELIA_PRISON_1_OPTION_2 = """不过链条很适合你。""",
	AMELIA_PRISON_2_1 = """— 正如你所看到的，我被绑架了。至于为什么，我能想到很多原因。然而，我相信所有人都猜到了，雇佣这些雇佣兵的肇事者是仆人行会的某个人。""",
	AMELIA_PRISON_2_2 = """— 哦，我对此毫不怀疑。我很乐意遵守你的喜好，但这还得等一段时间。仆人行会内部有人雇佣了这些雇佣兵来绑架我。迟早，当他或他们无法联系到这些雇佣兵时，幕后主使会再次采取行动。 """,
	AMELIA_PRISON_2_3 = """— 我是一个受欢迎的女人。我相信你理解，有太多的相关方让我无法猜测。但我有一种感觉，犯罪者很快就会暴露出来。也许我只需要出现在行会宿舍里，就能发现幕后黑手。""",
	AMELIA_PRISON_2_4 = """— 你想让我先分享最辣的理论，还是留到最后？不过，我认为现在不是列出它们的好时机。增援力量随时可能到来。""",
	AMELIA_PRISON_2_OPTION_1 = """知道是谁下令绑架你的吗?""",
	AMELIA_PRISON_2_OPTION_2 = """为什么会有人绑架你?""",
	AMELIA_PRISON_2_OPTION_3 = """公会正在调查你的活动。一些关于走私的事情。""",
	AMELIA_PRISON_3_1 = """— 权力。我想这是一个很好的理由。有人瞄准了我的位置。很遗憾，他们决定采取这样的方法。他们本可以让我下台，我会很乐意遵守的。
无论如何，他们编织了一张阴谋之网。我开始担心我可能会失去我的秘密战术。""",
	AMELIA_PRISON_3_2 = """— 猜测？没有。方向，或许有一点。我可以调皮捣蛋，但即使是我也知道我不能永远逍遥法外。我也不打算。""",
	AMELIA_PRISON_3_3 = """— 我恳请你把我，一个你刚刚英勇逮捕的在逃危险罪犯，送到仆人行会。他们很可能会召集一个委员会来决定对我的惩罚。那就是绑架我的幕后黑手肯定会采取下一步行动的地方。""",
	AMELIA_PRISON_3_4 = """— 这当然是一个诱人的提议。但我不得不拒绝你的邀请。至少目前是这样。除非得到解决，否则这个问题不会简单地消失。我确实打算解决它。""",
	AMELIA_PRISON_3_OPTION_1 = """你预料到了吗?""",
	AMELIA_PRISON_3_OPTION_2 = """你的计划是?""",
	AMELIA_PRISON_3_OPTION_3 = """我可以把你藏在我的豪宅里""",
	AMELIA_PRISON_3_OPTION_4 = """先带你去行会好了""",
	AMELIA_PRISON_4_1 = """— 请这样做。还有最后一件事, [name]。一旦行会决定了委员会的开会日期，你能帮我弄清真相吗？我可以在委员会与会者中找到一个盟友。而你是我目前唯一能从嫌疑人名单中删除的人。""",
	AMELIA_PRISON_4_2 = """— 那么，你的宏伟计划是什么？是不是绑架了我，然后勇敢地救了我，让我坠入爱河？哦，你不必走这么远。""",
	AMELIA_PRISON_4_OPTION_1 = """你为什么不认为我可能是这一切的幕后黑手？""",
	AMELIA_PRISON_4_OPTION_2 = """有什么事吗?""",
	AMELIA_PRISON_4_OPTION_3 = """当然，我会帮你的。""",
	AMELIA_PRISON_5 = """— 啊，我以为我已经把你放在我的拇指上了，哈哈。好吧，我已经准备好做一个好女孩或坏女孩了。你想要一个还是另一个？或者其他什么？我现在没有太多其他可以可靠提供的。""",
	AMELIA_PRISON_5_OPTION_1 = """我说出来的话不会很有趣，是吗？""",
	AMELIA_PRISON_5_OPTION_2 = """我喜欢坏女孩。""",
	AMELIA_PRISON_5_OPTION_3 = """我喜欢好女孩。""",
	AMELIA_PRISON_6_1 = """— 谢谢。这让我对委员会可能带来的东西感到放心。""",
	AMELIA_PRISON_6_2 = """— 啊，我很欣赏那些对他们来说有点神秘的人。所以我想我将不得不等待委员会得知你的决定？多么有趣。现在我肯定要坚持到底。
那就带我去行会吧。""",
	AMELIA_PRISON_6_3 = """— 我可以是那样的。我也可以是相反的。毕竟，我受过适当的训练。那就带我去行会吧。我希望到委员会开会时，你会认为我的行为令你满意。""",
	AMELIA_INTERLUDE2_1_1 = """你背着阿米莉亚走进领导办公室。诺兰面对这突如其来的事件保持严肃。在她被警卫带走后，你一个人和他在一起。

—  [name] 市长，我很感谢你的帮助，让阿米莉亚回到我们身边。如前所述，我已经向我们的财务主管进行了询问，以确保您的努力得到适当的补偿。您的奖励将很快交送到您手上。""",
	AMELIA_INTERLUDE2_1_2 = """— 这是一个尚未做出的决定。到目前为止，我肩负着这一责任。因此，如果您有任何与行会有关的事情，请随时联系我。随后，公会成员将召开会议，确定新的领导人。""",
	AMELIA_INTERLUDE2_1_OPTION_1 = """那么，如果阿米莉亚被判有罪，现在谁来掌管公会？""",
	AMELIA_INTERLUDE2_1_OPTION_2 = """我会去的。""",
	AMELIA_INTERLUDE2_2 = """— 当然。我也必须去，在议会前还有很多准备工作要做。祝你今天愉快 [name] 市长。

诺兰匆匆离开了办公室。""",
	AMELIA_TRIAL_1 = """一个信使出现在你的门口，手里拿着一封来自仆人行会的传票。
委员会今天召开会议。正如诺兰所承诺的那样，这封信使你能够参加会议，尽管它通常是留给外人的。

你还记得阿米莉亚的话吗。仆人行会里有人在和她作对。如果真的是这样的话，她的前景看起来很黯淡。至少，在没有你的帮助的情况下。""",
	AMELIA_TRIAL_2 = """走进仆人行会大楼内的集会大厅，你会发现一个稀疏的集会场所。只有几个人，即行会高层，已经坐好了座位。坐在前面讲台上的是现任行会运作监督员诺兰。当你在其他人中找到自己的位置时，他微妙地点头确认你的存在。

诺兰: 大家都出席了，我们开始开会。请护送被告进去。""",
	AMELIA_TRIAL_3 = """阿米莉亚走进房间，向聚集在一起的帮会成员鞠躬致意。她的举止就像一个准备表演的舞台女演员。她坐在行会领袖讲台旁，平静地安顿下来。

诺兰: — 委员会现在开会。今天的议程涉及决定阿米莉亚的命运——我们的现任行会领袖，暂时停职。她面临渎职、未经授权的商业冒险、贪污公会财产和声誉受损的指控。阿米莉亚，你明白这些指控吗？你同意还是想为自己辩护？

阿米莉亚看起来不感兴趣，假装不被周围的骚动所困扰..""",
	AMELIA_TRIAL_4 = """阿米莉亚: —  是的，我同意，我承担全部责任。让我们不要延长委员会的时间。

会员 1: —  我同意。我们有整整两天的时间来了解情况，让我们集中注意力，进入投票阶段。""",
	AMELIA_TRIAL_4_ = """另一个公会成员站了出来。

会员 2: —  事实就是这样。她被免职是理所当然的。然而，我们不能忽视那些差点把我们推向丑闻领域的秘密交易。仅仅解除她的行会领袖身份是不够的；她需要承担责任。

阿米莉亚: —  西尔杜尔，你想受到什么惩罚？我记得你在我第一次当选时就很喜欢我的滑稽动作。

阿米莉亚笑了笑，看着站着的公会成员的眼睛，让他不舒服地脸红了。""",
	AMELIA_TRIAL_5 = """诺兰: —  被告，除非被要求陈述，否则请不要干涉。

阿米莉亚: —  哦，是的。我的错。直到三天前，我还曾领导这些人，旧习惯很难改掉。""",
	AMELIA_TRIAL_5_ = """另一个行会成员提高了声音。

会员 3: — 真的没什么可谈的。她确实违反了公会关于将受监管的精灵植物进口到城市的规定。我们不应该决定她的命运。她应该被移交给当局。

会员 2: — 同意。因为她，我们已经有足够多的问题了。如果我们把这件事留在家里，我们也得把它掩盖起来。""",
	AMELIA_TRIAL_6 = """阿米莉亚突然转向你，大声说话。

阿米莉亚: —  [name] 市长，你觉得怎么样？

行会成员之间的讨论安静下来，大厅的注意力集中在你身上。""",
	AMELIA_TRIAL_6_OPTION_1 = """这首先是行会的事情。我不认为这是我的职责。""",
	AMELIA_TRIAL_6_OPTION_2 = """阿米莉亚为公会做的那么多好事呢？这一点都不重要吗？""",
	AMELIA_TRIAL_7 = """阿米莉亚: — 嗯，你代表的是我应该被移交给的权威。除其他外。我相信你可以干涉……除非你不喜欢？""",
	AMELIA_TRIAL_7_OPTION_1 = """我决定不干涉，阿米莉亚。""",
	AMELIA_TRIAL_7_OPTION_2 = """你似乎非常渴望得到我的关注，不是吗？""",
	AMELIA_TRIAL_8_1 = """会员 4: —  我同意 [him]的观点！你已经忽视了阿米莉亚对公会的巨大贡献了吗？当然，她的成就应该在一定程度上减轻她的罪责？""",
	AMELIA_TRIAL_8_2 = """阿米莉亚: — 是这样吗？很遗憾。我希望你能帮助一个陷入困境的女人。""",
	AMELIA_TRIAL_8_3 = """阿米莉亚: 真是个笑话!

诺兰: — 阿米莉亚，够了。我已经说过，被告不应该在没有被提及的情况下发言，不是吗？?""",
	AMELIA_TRIAL_8 = """
	
会员 2: —  这不是法庭。我们的目的不是维护正义。我们正在决定一条风险更低、回报更大的道路——一个务实的解决方案。这个解决方案将包括迫使某人消失，而不是试图支持她。我很抱歉，阿米莉亚，但如果你处于我的位置，你可能会同意我的观点。""",
	AMELIA_TRIAL_8_OPTION_1 = """那么，为了保证口袋满满，你准备把她活活吃掉吗？""",
	AMELIA_TRIAL_8_OPTION_2 = """让前行会领袖被正式指控为犯罪对行会声誉也不好。""",
	AMELIA_TRIAL_9_1 = """会员 1: — 本质上，这是真的。我们不应该假装成英雄或圣人。毕竟，她要为自己的行为负责，不是吗？她有权力，但屈服于贪婪。做出善意的回应并让她面对后果是很自然的。""",
	AMELIA_TRIAL_9_2 = """会员 2: — 嗯……是的，你可以说确实是这样。那又怎样？我们掩盖了它？""",
	AMELIA_TRIAL_9 = """诺兰: — 我相信我们从两个角度都听够了。作为一名代理行会领袖，通常情况下，我会敦促所有与会者在两个既定的行动方案之间进行投票：将被告交给当局，或者干脆剥夺她的职位，让她离开。然而，我还有一个替代方案，还没有提出。

会员 2: — 真的吗？那是什么？ """,
	AMELIA_TRIAL_9_ = """诺兰: — 作为一名经历过自由的前奴隶，对被告来说，没有什么比回到奴隶生活更严厉的惩罚了。把她卖为奴隶既可以作为报复，也可以消除公开这种名誉耻辱的必要性。有趣的是，我确实有一个潜在的买家有兴趣收购她。

阿米莉亚: —  这么快？看来你没有等委员会的决定就已经制定了计划。

诺兰: —  被告，这是你离开大厅前的最后一次警告。

阿米莉亚看着你的眼睛。她默默地用头比划着诺兰。是他。就是那个下令绑架她的人。或者她似乎是这么认为的。

阿米莉亚的目光又回到了你身上。她的表情透露出一个无声的问题，一种恳求。"你能帮我揭露他吗？"她问道。""",
	AMELIA_TRIAL_9_OPTION_1 = """摇头。拒绝她的请求。""",
	AMELIA_TRIAL_9_OPTION_2 = """点头。帮她揭露诺兰。""",
	AMELIA_TRIAL_10 = """她很失望。一定是，尽管她没有表现出来。委员会在没有你干涉的情况下进行。

会员 2: — 这是解决我们问题的一个很好的办法。我不反对。
诺兰: 让我们开始投票。那些赞成卖掉阿米莉亚的人，请举手。

你环顾大厅。看来大多数行会成员都同意诺兰的提议。 """,
	AMELIA_TRIAL_10_ = """诺兰: — 然后由多数人投票决定。

说完最后一句话，行会成员开始从座位上起身离开大厅。阿米莉亚在被带出大厅之前，最后失望地瞥了你一眼。诺兰落在后面。你还没来得及离开，他就走近了你。

诺兰: — 我很感谢你今天抽出时间来参加我们的活动，[name] 市长。""",
	AMELIA_TRIAL_10_OPTION_1 = """你提到的买家是谁？你要把阿米莉亚卖给谁？""",
	AMELIA_TRIAL_10_OPTION_2 = """那么，我想你就是新的行会领袖了，诺兰？""",
	AMELIA_TRIAL_10_OPTION_3 = """我要走了。""",
	AMELIA_TRIAL_11_1 = """诺兰: —  [name] 市长,我深表歉意，但我无权透露交易条款或相关方。不过，你不必担心。我可以向你保证，阿米莉亚会得到很好的照顾。

诺兰的话伴随着微笑。""",
	AMELIA_TRIAL_11_2 = """诺兰: — 我是在昨天的会议上被选中的，但老实说，我认为我不太适合担任这个角色。我已经提出了新选举的请求，但我们需要等待今天的委员会结果，以防出现任何新的证据，阿米莉亚本可以被赦免，重新担任代理领导人。尽管很少有人相信这是可能的，但协议必须遵守。""",
	AMELIA_TRIAL_11_3 = """再次感谢您今天的出席。 [name] 市长, 我真诚地希望您对我们行会的持续支持，以及我们未来的合作能够像在这场……危机期间那样富有成果。 现在，请原谅, [name] 市长。

诺兰什么也没说就走了。""",
	AMELIA_TRIAL_11 = """我很抱歉，但我必须离开了。 [name] 市长,我真诚地希望您对我们协会的持续支持，以及我们未来的合作能够像在这场……危机期间那样富有成果。现在，请原谅, [name] 市长。

诺兰什么也没说就走了。""",
	AMELIA_TRIAL_12 = """会员 2: — 这是我们问题的完美解决方案。我不反对。

诺兰: — 让我们开始投票。那些赞成卖掉阿米莉亚的人，请举手。

阿米莉亚: — 在你发言之前，我想为自己辩护。我被允许，不是吗，诺兰？

诺兰: — ... 继续。

阿米莉亚: — 我所谓的秘密活动已经不是什么秘密了很长一段时间了。毕竟，今天聚集的会员中有很多是我的客户。

会员 1: — 什-什么胡说八道！ """,
	AMELIA_TRIAL_12_ = """阿米莉亚: — 别担心，我不会透露谁……也不会透露我被要求做什么。你的秘密对我来说是安全的。我现在提到这件事只有一个原因——因为我非常关心这个行会，看到它倒下我会很难过。而且它会倒下的，除非内部的腐败暴露出来。

诺兰: — 你的话，阿米莉亚，不要给人留下为你辩护的印象；相反，它们似乎带有指责的口吻。我负责维持议会的秩序，看来阿米莉亚的意图可能是破坏这一秩序。阿米莉亚，我承认你的情绪，但我不能允许你走这条路。""",
	AMELIA_TRIAL_13 = """阿米莉亚: — 哦，但你来晚了，因为这个议会已经只不过是一个马戏团了。但如果你想按规定行事，那就顺其自然吧。我想传唤一名证人。

诺兰: — 我们没有时间，阿米莉亚。安理会的结论定于今天作出；我们不能拖延到你的证人出现的那一天。

阿米莉亚: — 没有必要推迟任何事情，因为我的证人今天在场。[name] 市长，我想问你几个问题。""",
	AMELIA_TRIAL_13_ = """诺兰: — 您可以继续提问。但是，我必须强调，您的询问应该与案件直接相关。如果它们偏离了相关性，我需要结束您的最后陈述，即使您自己还没有结束。

阿米莉亚: — [name] 市长，前几天是你把我送到公会的。你能告诉各位成员我是在什么情况下被你发现的吗？""",
	AMELIA_TRIAL_13_OPTION_1 = """被雇佣兵绑架。我把你救出来了。""",
	AMELIA_TRIAL_13_OPTION_2 = """以相当顺从的姿势铐在墙上。""",
	AMELIA_TRIAL_14_1 = """阿米莉亚: — 确实。被绑架了。我觉得很奇怪，我的绑架恰逢我的活动开始调查。毕竟，在我没能回来之后，假设我发生了什么事情不是更自然吗？然而，我们的新行会领袖下令调查的第一件事不是我的神秘失踪，而是我在事情发生之前所做的事情。 """,
	AMELIA_TRIAL_14_2 = """阿米莉亚: — 谢谢你分享那些不必要的细节。确实。被绑架了。我应该补充一点。是雇佣兵绑架的。有人付钱给他们做的。我觉得很奇怪，我被绑架的同时，我的活动才开始调查。毕竟，在我没能回来之后，假设我发生了什么事情不是更自然吗？然而，我们新任行会领袖下令调查的第一件事并不是我的神秘失踪，而是我在失踪前所做的事情。""",
	AMELIA_TRIAL_14 = """诺兰: — 请继续你想要表达的观点，或者问你的下一个问题。

阿米莉亚: — 很好。 [name] 市长, 据我所知，你已经向行会伸出援手，发现了失踪的奴隶。这是谁的主意，是你的还是诺兰的？""",
	AMELIA_TRIAL_14_OPTION_1 = """我提供了帮助。诺兰试图说服我不要参与其中。""",
	AMELIA_TRIAL_14_OPTION_2 = """这当然是我的主意。你不能在我这个市长任期内神秘失踪，阿米莉亚。""",
	AMELIA_TRIAL_15_2 = """阿米莉亚: — 市长先生，我以后会记住这一点。你还记得诺兰对你的建议有什么反应吗？""",
	AMELIA_TRIAL_15 = """会员 2: — 我……我想补充一点！当这段对话发生时，我和他们在房间里，诺兰很不愿意接受市长的帮助。我也觉得这很奇怪。我们陷入了混乱，他就在那里，拒绝了市长的帮助！

诺兰: — 我理解这可能看起来是什么样子，但我的本意并不是劝阻你。我只是想让你知道我们完全有能力独自解决麻烦。使用"混乱"一词似乎有点夸张。""",
	AMELIA_TRIAL_15_ = """阿米莉亚: — 给你，诺兰。两个证人。

诺兰: — 阿米莉亚...这种孤注一掷的行为不适合你这种高雅的人。我有什么可能的理由策划这样的事情？

阿米莉亚: — 这不是很明显吗，行会领袖诺兰？""",
	AMELIA_TRIAL_16 = """诺兰: — 我明白了。我想做一个正式的声明。我必须强调这是为了记录在案，所以不要有误解。 

会员 5: — 记录是按照协议保存的。

诺兰: — 很好。我想正式辞去现任行会领袖的职务。

一个明显的惊喜染上了阿米莉亚的脸。她没想到会发生这种事。""",
	AMELIA_TRIAL_16_ = """会员 3: — 什么？你不能辞职！只有委员会才能做出这样的决定！

诺兰: — 当然。然而，阿米莉亚的观点集中在这样一个想法上，即我策划陷害她，以获得她作为行会领袖的角色。作为正式声明，我谨表示，如果这一决定能证明我是清白的，我会放弃这一职位。

阿米莉亚看着你。她需要帮助。要抓住的东西。至少可以推迟投票。""",
	AMELIA_TRIAL_16_OPTION_1 = "尝试分析不一致的情况。",
	AMELIA_TRIAL_16_OPTION_2 = """也许我们应该询问阿米莉亚被绑架时与她在一起的奴隶？""",
	AMELIA_TRIAL_16_OPTION_3 = """你说你有一个阿米莉亚的买家。是谁？""",
	AMELIA_TRIAL_16_OPTION_4 = """很明显，有人雇佣了那些雇佣兵。""",
	AMELIA_TRIAL_17 = """你试着从整体上看待这个案子。你认为阿米莉亚的想法很简单，既诺兰是一切的幕后黑手。然而，他只是公会的一个简单仆人，而不是土地所有者。这项行动需要大量资金才能完成。雇佣兵服务并不便宜。""",
	AMELIA_TRIAL_17_OPTION_1 = """雇佣雇佣兵需要资金。如果我们跟着钱走，我们可能会知道真相。""",
	AMELIA_TRIAL_17_OPTION_2 = """忘记前后矛盾吧。阿米莉亚败诉了。结束会议吧。""",
	AMELIA_TRIAL_18_1 = """诺兰: — 没必要。我们已经对他们进行了彻底的询问，他们的证词没有任何价值。据我所知，所有公会成员都有机会在委员会会议之前审查他们被询问的笔录。""",
	AMELIA_TRIAL_18_2 = """诺兰: — 我不明白这与本委员会有何关系。买家的意图是匿名，我有义务保秘他们的身份。""",
	AMELIA_TRIAL_19 = """诺兰: — 很明显。但是，如果你考虑到可能是我，我敦促你权衡一下其中的含义。我只不过是这个公会的一个卑微的仆人。我缺乏雇佣哪怕是一名雇佣兵所需的资源，更不用说雇佣整个团队了。""",
	AMELIA_TRIAL_NORMAL_1 = """阿米莉亚: — 喔... 我懂了。说吧，诺兰。委员会是否有可能向我提供一份调查期间在我藏匿处发现的没收物品清单？

诺兰: — 为了什么? 

阿米莉亚: — 里面有不可否认的证据证明你参与其中。

诺兰: — 这没必要。你已经做了足够多的尝试来破坏委员会，我不能再允许它继续下去了。 """,
	AMELIA_TRIAL_NORMAL_1_ = """阿米莉亚: — 可以理解。但我不必看它就知道了。我几天前进口的植物不会在清单上。你知道为什么吗？因为你偷了它，然后在我的地方卖掉了它。

诺兰: — 作为直接负责记录库存清单的人，我向你保证，没收的物品中没有精灵植物。如果它存在，我就不会错过它。我不可能犯这样的错误。

阿米莉亚: — 这株植物的订单是匿名的。我还没来得及与买家见面就被绑架了。很明显，是你订购的。很明显，你从来没有打算付钱。而且，显然，你计划偷它来资助你的小阴谋。""",
	AMELIA_TRIAL_NORMAL_1__ = """诺兰: — 看到你如此绝望，真是太不幸了。
然而，即使有这种植物，你有什么证据证明我拿走了它？你能提供什么证据来表明我已经卖掉了它？

阿米莉亚凝视着你，她的表情毫无疑问：她在示意你合作。但是以什么方式呢？""",
	AMELIA_TRIAL_NORMAL_1_OPTION_1 = """我自己把植物交给了阿米莉亚。它确实存在。""",
	AMELIA_TRIAL_NORMAL_1_OPTION_2 = """我的一个合伙人从你那里买了这株植物。""",
	AMELIA_TRIAL_NORMAL_1_OPTION_3 = """触摸植物会在你的皮肤上留下痕迹。我们能检查一下你的手吗，诺兰？""",
	AMELIA_TRIAL_NORMAL_2 = """诺兰: — 尽管如此，这并不能证明我参与其中。 

阿米莉亚: — 你整理了这份名单。我必须补充一句，你如何解释这件花了一大笔钱的特殊物品丢失了？

诺兰: — 我什么都不需要解释。你声称这种植物存在，而且它可能存在。但即使是这样，我也没有意识到，也没有以任何方式接触过它。你的说法是一种指控。因此，举证责任落在你身上。而你没能满足它。""",
	AMELIA_TRIAL_NORMAL_3 = """诺兰: — 这太荒谬了。我不知道是什么迫使你与阿米莉亚密谋，但我敦促你重新考虑。她在欺骗你。阿米莉亚没有任何精灵植物。即使有人偷了它，那也是在我有机会看到它之前。

会员 2: — 但是为什么阿米莉亚会这么用心呢？市长似乎同意她的观点。如果我们不进一步调查，那就太愚蠢了，诺兰！""",
	AMELIA_TRIAL_NORMAL_3_ = """诺兰: — 相反，让这件事占据我们更多的时间是不明智的。工厂与阿米莉亚的罪行无关，让我们记住，这仍然是委员会的首要关注点。即使我们接受这一点，阿米莉亚也没有证据证明我参与了出售工厂和雇佣雇佣兵的活动。至于阿米莉亚为什么会继续这样想...

诺兰花了点时间思考他的下一句话。他看了一眼阿米莉亚，然后又看了你一眼，然后又把注意力放回了行会会员身上。""",
	AMELIA_TRIAL_NORMAL_4 = """诺兰: — 她的动机很直接——令人产生怀疑。我们都欠阿米莉亚，有些人比其他人更欠她。现在，她努力利用这一事实。这背后的意图...由于没有更好的措辞，这种言论是为了迫使委员会休会，从而推迟决定她的命运。我不确定她潜在的动机，但她的策略是显而易见的。真正让我惊讶的是，你们中的许多人准备团结起来支持这个被证实的罪犯，并成为她的阴谋的牺牲品。

阿米莉亚: — 诺兰，你真是个演说家。我看到你终于决定把它个人化了。

诺兰: — 够了，阿米莉亚。我们给了你很多时间。你的最后一句话结束了。我们现在开始表决。你没有更多的反对意见了，是吗， [name] 市长?""",
	AMELIA_TRIAL_NORMAL_5 = """当你浏览大厅时，你注意到有几张脸朝下。诺兰的劝说已经站稳了脚跟，辞职的论调占据了整个空间。即使是那些支持阿米莉亚的人也开始怀疑她，并考虑站在诺兰一边。阿米莉亚所制定的策略似乎已经动摇了。所有拖延或暗示诺兰的潜在途径都已经用尽。”。

但是，还有其他角度可以考虑吗？诺兰迅速放弃行会领袖职位的意愿引发了质疑。也许阿米莉亚对诺兰的怀疑是错误的，而他并不是策划针对她的阴谋的人？或者诺兰的行为背后可能还有其他动机？""",
	AMELIA_TRIAL_NORMAL_5_OPTION_1 = """你在隐瞒什么，诺兰。在我弄清楚是什么之前，我不会让委员会结束。""",
	AMELIA_TRIAL_NORMAL_5_OPTION_2 = """如果出售阿米莉亚是不可避免的，我会自己买下她。我的报价是其他买家的两倍。""",
	AMELIA_TRIAL_NORMAL_5_OPTION_3 = """我没有进一步的反对意见""",
	AMELIA_TRIAL_NORMAL_6_1 = """诺兰: — 我理解你的心情， [name] 市长，但是，唉，这是一个仆人行会委员会，你在这里的权力是有限的。你无法在委员会上执行你的意愿。这对你来说是幸运的，因为它使你免于犯下严重错误。""",
	AMELIA_TRIAL_NORMAL_6_2 = """诺兰: — 好。那么我们终于可以把这件事平息下来，继续投票了。""",
	AMELIA_TRIAL_NORMAL_7 = """诺兰: —  我... 对不起, [name] 市长？但是……你甚至不知道为她提供了什么。此外，我不能对买家食言。

会员 3: — 够了，诺兰！我们得到了更多的钱，没有理由拒绝。你的买家会理解的。

诺兰: — 不，他不会的。一言为定懂吧，最亲爱的行会成员，一定会明白这一点。""",
	AMELIA_TRIAL_NORMAL_7_ = """会员 2: — 来吧！在市长改变主意之前！谁赞成把阿米莉亚卖给市长？举手！

你环顾大厅。看来大多数公会成员都表示赞同。

诺兰: — 你犯了一个错误。买家不会高兴的。你必须相信我，他是一个会让公会付出高昂代价的人。

阿米莉亚: — 如果你提到你的神秘买家是谁，也许他们会更愿意听你的。

诺兰: — 我不能透露...""",
	AMELIA_TRIAL_NORMAL_7__ = """阿米莉亚: — 因为没有买家，是吗？

诺兰: — 你在暗示什么，阿米莉亚？

阿米莉亚: — 如果你不用在这些雇佣兵身上花那么多钱就好了...你会有足够的钱把价格提高三倍，不是吗？公会也已经投票了。

诺兰的叹息很沉重。它在整个大厅里回响。

阿米莉亚: — 想到你会为了得到我而不遗余力。我真受宠若惊。""",
	AMELIA_TRIAL_NORMAL_8 = """诺兰: — [name]市长。你在她身上看到了什么？你希望通过保护她来获得什么？啊，但我想我不是那个问这样问题的人。我敦促你收回你的提议，[name] 市长。因为如果你不... 

诺兰露出手中的匕首。

诺兰: — 如果你不这样做，我仍然不准备失去我为之努力的东西。 

诺兰突然向阿米莉亚跳去，手里紧握着匕首。还没等任何人知道发生了什么，诺兰就已经把匕首对准了阿米莉亚的喉咙。

会员 1: — 诺兰！解释一下！发生了什么事？""",
	AMELIA_TRIAL_NORMAL_8_ = """诺兰: — 很简单。我绑架阿米莉亚的企图失败了，多亏了我们最亲爱的市长的努力，我即将再做一次。我必须警告你，如果真的不能拥有阿米莉亚，那么我会确保其他人都不会。如果有人轻举妄动，我会杀了她。

会员 3: 卫兵！快叫卫兵！

诺兰开始后退，把阿米莉亚紧紧地抱在身边。没有人敢动。这些人准备把阿米莉亚卖为奴隶，但看到她在他们眼前被杀，前景一定太不愉快了。这就是他们的底线。

阿米莉亚: — 你知道吗，诺兰。你不必这么做。你可以简单地告诉我你的感受。""",
	AMELIA_TRIAL_NORMAL_8__ = """诺兰: — 什么?

阿米莉亚: — 我也对你有感情，你知道吗？

一时的分心。足以让阿米莉亚绕着诺兰的腿，让他仰面摔倒，匕首从他手中掉了下来。
诺兰还没来得及理解发生了什么，几个男人就已经把他抱在原地，约束着他的胳膊和腿。

会员 1: — 现在不要动！卫兵！快叫卫兵！

阿米莉亚看着你，皱着眉头。

阿米莉亚: — 我受伤了。你打算让他绑架我吗？再一次?""",
	AMELIA_TRIAL_NORMAL_8_OPTION_1 = """他其实跑不掉的。""",
	AMELIA_TRIAL_NORMAL_8_OPTION_2 = """我就知道你已经控制住了。 """,
	AMELIA_TRIAL_NORMAL_9_1 = """阿米莉亚: —  你不是很英勇, [name]。你应该救遇险的少女，你知道吗？""",
	AMELIA_TRIAL_NORMAL_9_2 = """阿米莉亚: —  哦，是这样吗？谢谢你对我的信任，我的英雄。""",
	AMELIA_TRIAL_NORMAL_9 = """

诺兰: —  我输了吗？不可能的，所有这些准备，所有我必须做出的牺牲...你毁了一切，[name]。阿米莉亚...我本可以给你一切的。我无条件的、纯粹的爱，多年来蓬勃发展。你已经看到了我的决心和感受。然而你否认了它们。为什么？！""",
	AMELIA_TRIAL_NORMAL_9_ = """阿米莉亚: —  你为公会服务了这么长时间，但你没有理解我们工作的一个基本事实。是奴隶选择了他们的主人。而不是相反。我只是选择了一个关心我的人，而不仅仅是他自己。

按住诺兰的人把他拖了起来。

会员 3: —  让我们暂时把他关进奴隶笼吧。无论如何，当卫兵来的时候，我们必须解释他们发生了什么。

会员 1: — 好主意。

公会成员带走了诺兰。""",
	AMELIA_TRIAL_NORMAL_10 = """会员 2 (西尔杜尔): —  嗯。阿米莉亚。你知道你仍然被逮捕，不是吗？

阿米莉亚: —  我是吗？我以为公会投票决定把我卖给市长。

会员 2 (西尔杜尔): — 也许是这样，但我们还没有收到任何付款。

阿米莉亚: —  什么付款? [name] 承诺支付诺兰双倍的费用。零的两倍仍然是零，不是吗？""",
	AMELIA_TRIAL_NORMAL_10_ = """会员 2 (西尔杜尔): —  你一如既往地伶牙俐齿，但行会的政策很明确——没有免费赠送的商品。
[name] 市长。我感谢你的参与。我们将完成文书工作。一旦我们收到你的付款，你就可以随时把阿米莉亚带回你的豪宅。


会员 2 (西尔杜尔): —  [name] 市长。 请明天再来完成购买。到那时我们会把所有手续都办好的。我将亲自确保阿米莉亚暂时在公会得到适当的住宿。""",
		AMELIA_TRIAL_BAD_1 = """诺兰: —  我们在这次讨论上花了足够的时间。阿米莉亚的罪行是不可否认的。他们的准备情况与今天的委员会无关。因此，我建议我们不要浪费成员们的宝贵时间，继续投票。赞成出售阿米莉亚的人，请举手。

你环顾大厅。看来大多数行会成员都同意诺兰的提议。""",
	AMELIA_TRIAL_BAD_1_ = """诺兰: —  然后由多数人投票决定。

说完最后一句话，行会成员开始从座位上起身离开大厅。阿米莉亚在被带出大厅之前向你投了最后一眼。诺兰落在后面。你还没来得及离开，他就走近了你。

诺兰: —  [name] 市长，我很感谢你今天抽出时间来参加我们的活动。""",
	AMELIA_TRIAL_BAD_1_OPTION_1 = """你提到的买家是谁？你要把阿米莉亚卖给谁？""",
	AMELIA_TRIAL_BAD_1_OPTION_2 = """你调查过绑架阿米莉亚的人吗？""",
	AMELIA_TRIAL_BAD_1_OPTION_3 = """谁将成为下一任行会领袖？""",
	AMELIA_TRIAL_BAD_2_1 = """诺兰: —  [name] 市长，我深表歉意，但我无权透露交易条款或相关方。不过，你不必担心。我可以向你保证，阿米莉亚会得到很好的照顾。

诺兰的话伴随着微笑。""",
	AMELIA_TRIAL_BAD_2_2 = """诺兰: —  当然。尽管如此，调查没有产生重大结果。我的假设是，他们受雇于她的一位过去的客户，可能是她误导的土地所有者。进一步调查可能会损害我们在无辜土地所有者中的声誉。因此，我们选择停止调查。""",
	AMELIA_TRIAL_BAD_2_3 = """诺兰: —  这件事将在下一届委员会上决定。虽然我一直是公会这个职位的头号候选人，但现在我已经正式放弃了这个头衔，他们将不得不提名其他人。我相信公会会会做出正确的决定，所以你不必担心。""",
	AMELIA_TRIAL_BAD_3 = """我很抱歉，但我必须离开。我真诚地希望您对我们行会的持续支持，以及我们未来的合作能够像在这场……危机期间那样富有成果。现在，请原谅, [name] 市长。

诺兰什么也没说就走了。""",
	AMELIA_INTERLUDE3_1_1 = """你进入了会馆，西尔杜尔的脸向你打招呼，一看到你，严肃的表情就变成了笑容。

—啊，[name] 市长！我们一直在等你。所有的文书工作都完成了，我们准备委托阿米莉亚照顾你。这只是一个简单的付款问题。公会的结论是3000就足够了。""",
	AMELIA_INTERLUDE3_1_1a = """你进入了会馆，西尔杜尔的脸向你打招呼，一看到你，严肃的表情就变成了笑容。

—啊，[name] 市长！我们一直在等你。所有的文书工作都完成了，我们准备委托阿米莉亚照顾你。这只是一个简单的付款问题。公会的结论是1500就足够了。""",
	AMELIA_INTERLUDE3_1_2 = """— 我知道像你这样热衷于这些事情的人不会错过谈判的机会。我预料到了这一点，所以我已经说服了委员会提供谈判的空间。已经安排好了。阿米莉亚将被直接送到你的庄园。目前我还能帮你什么吗？""",
	AMELIA_INTERLUDE3_1_3 = """— 我们真的很感谢你的帮助。但行会必须生存下去。我们靠贸易和利润生存。我们不能为了几个一角硬币就把阿米莉亚这样的奴隶送人。我相信你理解，[name] 市长。""",
	AMELIA_INTERLUDE3_1_OPTION_1 = """对像我一样帮助过公会的人要求有点高，不是吗？（魅力检定）""",
	AMELIA_INTERLUDE3_1_OPTION_2 = """这个价钱很公道。""",
	AMELIA_INTERLUDE3_1_OPTION_3 = """我现在没有钱。""",
	AMELIA_INTERLUDE3_1_OPTION_4 = """Actually, I'd rather have Amelia return to being a leader""", # MISSING TRANSLATION
	AMELIA_INTERLUDE3_2_1 = """— 很高兴与您做生意，[name] 市长。阿米莉亚将被直接送到您的庄园。我相信没有比你更好的[master]了。我希望在这之后，我们将继续受到您的青睐。我暂时还有什么可以帮您的吗？ """,
	AMELIA_INTERLUDE3_2_2 = """—好吧，这不是一笔小数目，是吗？别担心。在你付得起费用之前，我们会确保阿米莉亚住得舒适。我暂时还能帮你什么吗？""",
	AMELIA_INTERLUDE3_2_3 = """我们把他交给了城市卫兵。他确实试图自杀。这不再是简单的违反行会规则。这是犯罪。""",
	AMELIA_INTERLUDE3_2_4 = """这不是一个简单的问题。几位候选人正在召集他们的支持者，为下一届委员会做出决定。目前，我已经承担起了这一责任。""",
	AMELIA_INTERLUDE3_2_OPTION_1 = """诺兰怎么样了?""",
	AMELIA_INTERLUDE3_2_OPTION_2 = """谁将成为新的行会领袖?""",
	AMELIA_INTERLUDE3_2_OPTION_3 = """不，仅此而已。""",
	AMELIA_INTERLUDE3_3 = """那么，很高兴见到你，[name] 市长。祝你今天愉快。""",
	AMELIA_INTERLUDE4 = """行会关闭""",
	AMELIA_RETURN_1 = """Sildur looks at you with a deeply puzzled expression.

— I-I suppose this is possible if that's your wish... After all, we haven't selected a proper new leader yet, so she can be restored to her position, if that's what you want.""", # MISSING TRANSLATION
	AMELIA_RETURN_1_OPTION_1 = """Yes, I want it.""", # MISSING TRANSLATION
	AMELIA_RETURN_1_OPTION_2 = """Maybe not, after all.""", # MISSING TRANSLATION
	AMELIA_RETURN_2_1 = """— Very well, we'll restore her to her position as a guild leader. She might actually become more famous after all of this.""", # MISSING TRANSLATION
	AMELIA_GREETING_AFTER_RETURN = """— [name]... That was a surprise you've given up on me just like that. But I'm not angry. After all, I'm used to disappointments. Anyway, what can I help you with?""", # MISSING TRANSLATION
	AMELIA_FINAL_1 = """—　终于，救世主出现了。[name] 市长，如此勇敢地来拯救这位需要帮助的少女，感觉如何？""",
	AMELIA_FINAL_1_OPTION_1 = """这不是第一次了，还记得吗？不过你最好不要习惯。""",
	AMELIA_FINAL_1_OPTION_2 = """很好。我喜欢成为英雄。""",
	AMELIA_FINAL_1_OPTION_3 = """我希望你不要把我卷入你的烂摊子。""",
	AMELIA_FINAL_2_1 = """— 没错。你和他们一样可靠。很难不习惯一件好事，但我会尽力的。""",
	AMELIA_FINAL_2_2 = """— 他们说现在骑士精神已经不复存在了。也许我只是幸运地在瓦砾中找到了一颗钻石？""",
	AMELIA_FINAL_2_3 = """— 哦，但你是这个城市的市长。我以为你现在已经习惯了被拖入行会的事务""",
	AMELIA_FINAL_2 = """— 好吧，没关系，我很高兴你站在我这边。我承认，我低估了我的敌人。很少有人这样做，而且最终脱颖而出。如果没有你的帮助，我是做不到的。我只想让你知道，我真的很感激。 """,
	AMELIA_FINAL_2_OPTION_1 = """你被卖为奴隶，你还认为这是一场胜利吗？""",
	AMELIA_FINAL_2_OPTION_2 = """你让它听起来像是你一直以来的意图""",
	AMELIA_FINAL_3_1 = """— 也许吧。像你这样有抱负的人可能不会得到它，但事实上，我已经厌倦了所有这些事务和责任。是的，我一直在寻找一个借口，让这份职责变得更简单，而你一直是我的主要候选人，可以让像我这样的人感到…宾至如归。 



— 哦，但我们忘记了一些重要的事情。我现在成了奴隶。你的奴隶。一个奴隶应该被领起来。这是正确的方式。你想…现在给我戴项圈吗？""",
	AMELIA_FINAL_3_2 = """— 好消息是，我有备而来。这是我以前当奴隶时的旧衣服。我把它留作纪念。是时候让它再次达到预期目的了。""",
	AMELIA_FINAL_3_OPTION_1 = """我现在没有空项圈。""",
	AMELIA_FINAL_3_OPTION_2 = """当然。我们不想忘记这么重要的事情，是吗？""",
	AMELIA_FINAL_3_OPTION_3 = """ 我想让你自己做。""",
	AMELIA_FINAL_4_1 = """阿米莉亚一直直视着你的眼睛。当你把项圈系在她的脖子上时，她稍微向前倾向你，把齐肩的头发调整到露出脖子的程度。

你还记得吗，她是个混血儿。露出脖子，这是他们身体最脆弱的部分，是完全信任和顺从的标志。

她的呼吸很平静，看起来很自然。多年的劳役经历并没有被她所拥有的相对自由所抹去，哪怕只是一段时间。""",
	AMELIA_FINAL_4_2 = """— 如您所愿。

阿米莉亚一直直视着你的眼睛。她收起齐肩的头发，露出脖子。

你还记得吗，她是个混血儿。露出脖子，这是他们身体最脆弱的部分，是完全信任和顺从的标志。

她用一个经验丰富的动作将衣领裹在脖子上，身体前倾，确保她把衣领系在颈背上时你能看清楚。""",
	AMELIA_FINAL_4 = """— 我看起来怎么样?""",
	AMELIA_FINAL_4_OPTION_1 = """项圈很适合你。""",
	AMELIA_FINAL_4_OPTION_2 = """你看起来异常开心。""",
	AMELIA_FINAL_4_OPTION_3 = """就像一个奴隶。""",
	AMELIA_FINAL_5_1 = """我很高兴你这么认为。也许这就是它一直以来的样子。""",
	AMELIA_FINAL_5_2 = """当然。没有什么比最终归属更让我高兴了。 """,
	AMELIA_FINAL_5_3 = """务实，是吗？我明白了，你身上没有浪漫。嗯，要想看清事物的真实面貌，需要一定的天赋。""",
	AMELIA_FINAL_5 = """— 您想…品鉴您的新奴隶吗？""",
	AMELIA_FINAL_5_OPTION_1 = """我担心你不会问""",
	AMELIA_FINAL_5_OPTION_2 = """也许，改天吧。""",
	AMELIA_FINAL_6 = """知道接下来会发生什么，阿米莉亚优雅地开始脱下衣服，非常清楚你在看，尽她所能。她慢慢地向你鞠躬，表示顺从，她的笑容没有离开嘴唇。

— 我的身体从很久以前就没有这么兴奋过。
""",
	AMELIA_FINAL_7 = """— 哦……好吧，看来我得引起你的注意了。对于这样一个公平的主人，我随时都准备好了。""",
	AMELIA_SEX_1 = """阿米莉亚转过身来，拱起背部，露出臀部时，她的动作很有吸引力。你的手在她的曲线上找到了位置。一声轻柔而挑逗的叹息从她的嘴唇中溢出。

她的头转向你的目光，眼睛里充满了热切的好奇，想知道你的下一步行动。她仍然一动不动，展示了她毫无防御能力的后方，以邀请你采取进一步行动..""",
	AMELIA_SEX_1_OPTION_1 = "拍打她",
	AMELIA_SEX_1_OPTION_2 = "爱抚她的大腿",
	AMELIA_SEX_2_1 = """你拍了拍她的屁股，一个响亮的回声在房间里回荡。作为回应，一声轻柔而闷热的呻吟从她的嘴唇里溜走，一种对进一步放纵的优美恳求。你的手满足了她的要求。

— 嗯...对对我粗暴点…惩罚我... 

你再打她一巴掌。她的话被另一声呻吟打断了。不管她有什么感觉，这都不是遗憾。

—这是我的梦想啊...""",
	AMELIA_SEX_2_2 = """你的手向下移动，沿着她的大腿后部滑动，细腻地抚摸着她光滑裸露的皮肤。她的呼吸加深，嘴唇弯曲成一个微妙而满足的微笑。她松开双腿，为你的手提供更多的探索空间。

— 你比我想象的要温和。在你代表我经历了这么多之后...""",
	AMELIA_SEX_2 = """你的手指顺着她大腿之间的路径，顺着她的缝隙。甜美的湿气流到你的指尖。当你的衣服掉到路边时，你把下半身拉得离她更近，重复着以前的动作。只是这次，而不是用手指。

— 别停下。我比看上去更强壮...不是说你还不知道。""",
	AMELIA_SEX_3 = """你的反应是行动。你的成员进入她，满足了她的要求。她向后仰着头呼气。空气很热，但即使静止，你也几乎可以看到一团淡淡的薄雾从她的嘴唇中溢出。也许，这只是一种光或想象的把戏。”。

你的动作加强了，她的动作也加强了。她不会让自己的渴望逃脱你的注意，当她按照你自己的节奏向你靠近时，她会发出一种非常诱人的声音。她的背上开始出现汗珠。

—现在..我只是你的, [Master]! 随意使用。

你想，当你感觉到快乐在增强时，你无法再忍受这种刺激了。你感觉到阿米莉亚的阴户唇紧紧地抓住了你的阴茎。她自己似乎也快高潮了。

然而，你还没有准备好让她高潮。你抓住她，一只手搂着她的腰，另一只手抚摸她的乳房，然后把她的上半身拉向自己，把她锁在一个感性的拥抱中。""",
	AMELIA_SEX_4 = """她首先沉浸在快乐中，你紧随其后。快乐从你的内心爆发到她身上。她的身体在你的怀里变得成熟，完全被高潮打败了。她又叹了一口气——长长的、自我平静的一声——恢复了足够的镇静，抬起头来迎接你的目光。并向你展示一个狡猾的微笑。


— 这个...这比我做的梦要好。真不敢相信我会在我这个年纪坠入爱河。我的错，别担心我刚才说的话，这不会给你带来任何麻烦。""",
	AMELIA_SEX_4_OPTION_1 = """我们的感情可能是相互的""",
	AMELIA_SEX_4_OPTION_2 = """不要涉及私人感情""",
	AMELIA_SEX_5_1 = """— 呵呵, [Master], 你开玩笑。现在别对我太软了，你还有很多其他奴隶要照顾。""",
	AMELIA_SEX_5_2 = """— 这只是愚蠢的废话，不用理会。""",
	AMELIA_SEX_5 = """她的力量似乎又回到了她的身体。她站起来，穿好衣服。她的手朝着脖子移动。她把手指放在刚刚合身的项圈上——脸上有一种梦幻般的表情。然后，她再次与你的目光相遇。

— 现在, [Master], 请允许我从现在起尽我所能为您服务。""",
	
	AMELIATASKNAME = "搜索阿米莉亚",
	AMELIATASKDESCRIPT = "派遣搜索小组寻找有关阿米莉亚下落的任何线索。",
	SERVANTSNOAMELIA = "由于阿米莉亚不再是仆人行会的领袖，这个地方目前是空的。",
	SERVANTS_INTRODUCTION_NEW_LEADER_1 = """""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_REPLY_1 = """You explain how you think Daisy could benefit from training to become more professional.

— Of course we have training which would improve her performance, depending on what you'd like.""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_OPTION_2_1 = """I want her to be trained normally. (200 gold)""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_OPTION_2_2 = """What other options are there?""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_OPTION_2_3 = """There's something else?""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_OPTION_2_4 = """I want her to be trained normally and sexually. (300 gold)""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_OPTION_2_5 = """I want to turn her into a fucktoy. (400 gold)""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_OPTION_2_6 = """I'll return later.""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_REPLY_2_2 = """— Well, I'd expect you'd want her to be trained to clean, serve, know proper etiquette and so on. We can do that, or additionally teach her to serve with her body. Nothing too exotic, a bit of assertiveness, oral skills, being a bit more honest in her needs, you know. In case you are wondering, she would keep her chastity for the most part, as this training will not include any real intercourse.""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_REPLY_2_3 = """— If you think she'd be better suited for something completely... different, we can train her especially to be a plaything. She'd be able to serve many men at once, perform degrading actions and enjoy herself while at it. That's a bit more difficult, but I'm sure she's more than predisposed to it. She would be constantly used by other people during the training, I'm sure you understand.""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_REPLY_2_1 = """— A splendid choice. Glad to do business with you, [name]. I vow you'll be happy with the results.

You arrange a time for Daisy's training and leave.""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_REPLY_2_4 = """— A splendid choice. Glad to do business with you, [name]. I vow you'll be happy with the results.

You fill out a small form denoting which actions should be excluded from her training and set up a time for Daisy to attend.""", # MISSING TRANSLATION
	DAISY_TRAINING_NEW_LEADER_REPLY_2_5 = """— A splendid choice. Glad to do business with you, [name]. I vow you'll be happy with the results.

You fill out a small form denoting which actions should be excluded from her training and set up a time for Daisy to attend.""", # MISSING TRANSLATION
	DAISY_LOST_NEW_LEADER_OPTION_0 = """I've lost someone...""", # MISSING TRANSLATION
	DAISY_LOST_NEW_LEADER_REPLY_0 = """— That's a grim situation, we certainly condemn kidnapping, even when it happens to a slave. I remember the girl, you did send her for our training, right? There was a landowner who seemed rather interested in her and asked after her owner. His name was Ramont... not quite one of ours.""", # MISSING TRANSLATION
	DAISY_LOST_NEW_LEADER_OPTION_1_1 = """I might have received a letter from him.""", # MISSING TRANSLATION
	DAISY_LOST_NEW_LEADER_OPTION_1_2 = """How could you give him my information like that?""", # MISSING TRANSLATION
	DAISY_LOST_NEW_LEADER_REPLY_1_1 = """— He offered to purchase her from you? It seems he'd be our prime suspect then. He lives aways from the city. You better be prepared before going to meet him.""", # MISSING TRANSLATION
	DAISY_LOST_NEW_LEADER_REPLY_1_2 = """— Relax, a slave's owner is a matter of general record. I know how you feel right now, but trust me I'm on your side here. Anyway, it seems he'd be our prime suspect then. He lives aways from the city. You better be prepared before going to meet him.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_1_1 = """— Finally going to seal the deal with our little princess? That's great news.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_1_2 = """— Ooh? Well, that's amazing news, I'm very happy for you, Mayor.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_1_3 = """So you want us to prepare everything for your wedding? A person of your caliber can't have a simple wedding, after all. We will likely need at least a couple hundred of each foodstuff to start with. As for the drinks, we can get away with 10 bottles of whiskey and, let's say, 25 pints of beer. The rest we'll be able to sell to the guests from a couple of local suppliers I know.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_2 = """— Lastly, I'm gonna need 3.000 gold from you for the performers and couriers. I'm sure you understand. Also, I'd like you to provide a list of guests you wish to see, and I won't get upset if you add me to it, hehe. Once you have everything, let me know and we'll start the preparations right away.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_OPTION = """I've prepared everything for the wedding.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_1 = """— Splendid, I hope you've prepared the other stuff as well. Before you go, there's one more thing I want to ask.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_2 = """— There's one more thing I want ask you about the guests if you'll pardon me. There's a certain category of... indecent people, who will surely seek to appear at the Mayor's wedding. While it might seem to you like a completely abhorrent thing, they are also quite rich and are known to be very generous if certain services are rendered by the bride.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_3 = """— In no way am I suggesting you should compromise your wedding. So let me know if you want them to be invited at all.""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_OPTION_1 = """*Invite them*""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_OPTION_2 = """*Refuse*""", # MISSING TRANSLATION
	MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_4 = """— Understood. With that set, I hope to see you soon and wish you a very happy wedding, [name].""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_START_OPTION = """*Ask on Cali's beneficence*""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_1 = """You approach ask around the guild helpers and they direct you to a general training for female servants. Basic skills of sewing, cooking and etiquette which will be a good spot for any girl to start with.

With a hint of doubt, Cali agrees to try these activities. 

— Huh, I'm not sure I'm good with this stuff...""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_1_OPTION_1 = """Don't worry, you can do it.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_1_OPTION_2 = """There's first time for everything, you won't know until you try.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_1_OPTION_3 = """You shouldn't get discouraged right as we started.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_2 = """— Okay, okay, I'm gonna try it. 

After discussing it with the helpers, you are explained about general training for future servant girls which starts with figuring out the most talented aspects, dressing up, signing and formal language. Cali agrees to try this out.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_3 = """As Cali is trying on a new long dress, she does not seem particularly comfortable in it, nor does it seem to suit her sharp features. Despite that she still undergoes etiquette lessons which visually tires her. """, # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_4 = """As she goes on a break, Cali spots a small cat moving through the backyard. Forgetting everything about the conduct, she tries to sprint to it but trips and falls due to her attire.

— O... Ouch... Crap!

Also forgetting to watch her tongue, she realized that her dress was torn because of the fall. Sadly, you'll have to pay for it. You decide to call it a day and make the wolf girl change back.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_5 = """Cali seems to be in a sorry state as she comes back to you.

— Sorry, for some reason it's really hard for me to act like normal girls. And having to dress like this is so frustrating... Maybe I should forget about this.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_5_OPTION_1 = """You shouldn't give up just yet.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_5_OPTION_2 = """Maybe it isn't for you after all.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_6 = """{color=yellow|Amelia: — I saw your training, Cali is it? Nice to meet you.}

{color=aqua|Cali: — Hello... Who are you?}

{color=yellow|Amelia: — Consider me a humble person who would like to give advice. I'm sorry these ears seem to eavesdrop on your conversation, but in truth I think you've taken a slightly wrong approach.}

{color=aqua|Cali: — What do you mean?}""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_7 = """{color=yellow|Amelia: — You are a girl and you want to look more like one, am I correct? However, as you've noticed, you aren't quite like other girls.}

Cali gets visually discouraged hearing this, but Amelia does not stop there.

{color=yellow|Amelia: — This does not mean you should give up, though. If some things don't work for you, others might.}

{color=aqua|Cali: — I still don't really understand.}

{color=yellow|Amelia: — Do you mind me taking some of your time? It won't cost you anything. I would not feel right if you left us unsatisfied.}""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_8 = """After a moment Cali agrees and Amelia takes her away from you. As you wait for about half an hour, Cali reappears before you and seems to be in a quite better mood than when she left. You can't quite make out what changed about her, but somehow she grabs your subconscious attention as she moves towards you. 

{color=aqua|Cali: — [Master]! Sorry for taking time...}

As she observes your reaction she starts smiling even more.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_8_OPTION_1 = """You look pretty.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_8_OPTION_2 = """What was it?""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_8_OPTION_3 = """You seem somewhat different.""", # MISSING TRANSLATION
	CALI_SERVANTS_NEW_LEADER_9 = """{color=yellow|Amelia: — He-he, so you notice it now? You don't need a complete attire change or a full makeup to emphasize your beauty. Some pose and expression training look a lot more natural for you. Well, that and a couple small woman secrets.}

You notice how Cali now looks at Amelia with respect. In the end, encouraged with the results, Cali agrees to occasionally visit and learn from Amelia. As she walks outside, Amelia speaks to you.

{color=yellow|Amelia: — She's a good girl, you better not betray her trust in you.}

Not waiting for your reply she disappears from sight as nonchalantly as she appeared. 

{color=green|Cali: Charm Factor +1
Cali: Charm +10}""", # MISSING TRANSLATION
	SERVANTS_NEW_LEADER_CLOSE = """""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_1_OPTION_1 = """Check elven houses""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_1_1 = """As you walk through the settlement, you come across an agitated elf woman.

— I can't believe my idiot husband. I knew marrying someone following a different deity is going to be tough, but I guess Alios followers are a special kind. Lately he has been really annoying about rumors of some champion or something.

Unable to find any words for this situation you decide to leave her alone.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_1_2 = """You walk by the familiar house. You aren't sure what you can do here right now.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_2 = """As you and Zephyra go through the village's side street, you are suddenly approached by an overly expressive elven civilian of ambiguous age. 

Elf: — No way, are you... Zephyra, The Champion of Alios?! 

Zephyra: — I wish I could lie about it, but my agreement requires me to confirm my identity to the believers...""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_2_OPTION_1 = """Aren't you happy that someone finally acknowledges you?""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_2_OPTION_2 = """You should be more faithful to your duty.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_2_OPTION_3 = """(To the man) Sorry, we aren't giving interviews to strangers.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_3_1 = """Elf: — I knew it! My name is Wirenth, I've been a devoted Alios follower since the times he was in our lands.

Zephyra: — Uh, huh, a long time ago then...

Wirenth: — I know you are a fairly recently became his Champion, but I knew one day Alios will give us a sign. You even look somewhat similar to our High Priestess with a beautiful face and gorgeous long white hair!

Zephyra: — You've done well flattering me, might I ask what can I do for your dutious worship?""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_3_2 = """Elf: — I knew it! My name is Wirenth, I've been a devoted Alios follower since the times he was in our lands.

Zephyra: — Uh, huh, a long time ago then...

Wirenth: — I know you are a fairly recently became his Champion, but I knew one day Alios will give us a sign. You even look somewhat similar to our High Priestess with a beautiful face and gorgeous long white hair!

Zephyra: — ...Former High Priestess.

Wirenth: — Gah, this is less important than meeting a herald of Alios herself.

Zephyra: — You've done well flattering me, might I ask what can I do for your dutious worship?""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_3_3 = """Zephyra: — Well, this is a shame, but I'm afraid because of my selfish [Master] I won't be able to help you out. 

Wirenth: — Oh... Uh, alright... I wish you the best on your journey... 

You leave the disappointed elven man and for some reason decide not to go over his place any time soon.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_4 = """Wirenth: — Truth be told... Can I ask for your private audience? 

Zephyra: — ...Huh?

Wirenth: — My wife is not currently at home and I don't have too much time till she returns. I know how it may look, but I'm doing it with the best faith in Alios.

Zephyra: — Uh, I'm somewhat busy right now, but if [Master] has no objections...""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_4_OPTION_1 = """Are you sure about that? It doesn't look safe""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_4_OPTION_2 = """This seems important, so just get on with it""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_4_OPTION_3 = """Sorry, I can't let you go like that""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_5_1 = """Zephyra: — I don't sense any danger from him, so I'm sure it's gonna be fine. Besides, I still have a duty to fulfill as a champion.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_5_2 = """As Zephyra and the man move into the house, you put your ear next to the door listening to their conversation...

Wirenth: — ...I'm sorry, this is kinda embarrassing for me, but...

......

Zephyra: — ...Look, you aren't serious about this, right? It's even more embarrassing for me... Well, since you've been a faithful follower... *Sigh*...

........

Wirenth: — ...Ooh, this is great!... I knew it, it is just the right size for your body...

Zephyra: — ...Don't say that, this sounds terrible...""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_5_OPTION_1 = """*Rush in*""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_5_OPTION_2 = """*Keep waiting*""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_6_1 = """As you barge inside, you find Zephyra wearing strange white and red clothes looking nothing like what she was wearing before. She does seem to be embarrassed wearing this.

Zephyra: — [Master]! Why are you rushing in like this?! Gosh, why did this happen to me...

Wirenth: — Oh no... Please, close the door before our neighbors see it.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_6_2 = """After a few minutes Zephyra leaves the house brushing her clothes with the sad looking man following after her. You can read embarrassment and annoyance on her face. 

Zephyra: — We shall not speak about what has been happening just now and lets be on our way.

Wirenth: — I-I'm sorry... But thank you for paying me a visit, perhaps, if you change your mind...

Before he could finish the foxgirl already went for a considerable distance making you follow her.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_7 = """After you've closed the door, Wirenth finally explains himself.

Wirenth: — W-well... You see, a few years ago there was a traveling merchant passing through our village, and I had this unbearable urge to purchase this outfit once I saw it... Even though its not even fit for my wife...

Zephyra: — I can't believe I agreed to wear this.

Wirenth: — But now I know this is exactly why I got it! It was meant for you, Champion Zephyra. It must have been Alios' guidance all this time.

Zephyra does not comment on it, trying to either facepalm herself or hide her blush with it. It seems she believes in what the man said.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_7_OPTION_1 = """I actually like it""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_7_OPTION_2 = """Is this some faraway land outfit?""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_8_1 = """Zephyra: — [Master], please, not you as well... What's wrong with men? I guess, there's no other choice for me but to keep this gift now.

Wirenth: — Yes! It suits you so well. It's not like I had any use for it so it was destined to end up being yours.

Zephyra: — Fine, fine... T-thank you for this... As long as [Master] finds this appealing.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_8_2 = """Wirenth: — Yes! It suits you so well. It's not like I had any use for it so it was destined to end up being yours.

Zephyra: — Fine, fine... T-thank you for this... As long as [Master] finds this appealing.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_9 = """After shaking the Wirenth's hand you both make out of his home. 

Zephyra: — [Master], are you planning to keep me wearing this? I can't shake the feeling this has some underlying meaning I can't quite comprehend yet, like being of fox ancestry has something obscure to do with this.""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_9_OPTION_1 = """I think it suits you really well""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_9_OPTION_2 = """You can take it off if you want""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_9_OPTION_3 = """Perhaps, you should dye your hair orange and learn cooking""", # MISSING TRANSLATION
	ZEPHYRA_COSTUME_10_1 = """Zephyra: — Of course [Master] does, I'm never going to question your deviant tastes. 

Zephyra makes a playful chuckle seemingly accepting this recent attire. """, # MISSING TRANSLATION
	ZEPHYRA_COSTUME_10_2 = """Zephyra: — Hmm... I'll consider it.

Despite your expectation for Zephyra to get rid of this costume as soon as possible, she smiles wryly at her own thoughts. """, # MISSING TRANSLATION
	ZEPHYRA_COSTUME_10_3 = """Zephyra: — Absolutely not, never, in no reality or fantasy this is going to happen. I value my life too much to make my older sister mad at me for trying to impersonate her. As for cooking, only if you promise to eat anything I make.""", # MISSING TRANSLATION
	DAISY_WEDDING_1 = """— ...Master, I'm— I'm the happiest I've ever been! You've taken such good care of me despite... my mistakes...

You reassure her that whatever mistakes she makes can't possibly outweigh your love for her.

— M–Master!

Daisy kisses you, her shaky hands grasping at your clothes as if you'll disappear.

— Ah! I did that without orders...! I— Um... Do you... want me tonight, Master?""", # MISSING TRANSLATION
	DAISY_WEDDING_1_OPTION_1 = """Of course.""", # MISSING TRANSLATION
	DAISY_WEDDING_1_OPTION_2 = """I'm a bit tired after the ceremony.""", # MISSING TRANSLATION
	DAISY_WEDDING_2_1 = """Daisy blushes. Her mouth opens and closes over and over again, but nothing comes out.

She lets you lead her to your bedroom, a silly smile on her face.""", # MISSING TRANSLATION
	DAISY_WEDDING_2_2 = """— O–Oh... Maybe we can... um, cuddle instead?

You tell her you might later, but you're going to get some sleep.

Daisy sits down on your bed, looking around at everything in the room but you.

— So, um... h–how do you want me, Master?""", # MISSING TRANSLATION
	DAISY_WEDDING_3 = """You push Daisy back onto the bed and lift her dress excitedly, exposing her wet pussy

— Ah...!

Daisy looks up at you with eyes glowing in the moonlight.

— Are you sure I'm worthy of your... love, Master?""", # MISSING TRANSLATION
	DAISY_WEDDING_4 = """You pull out your cock in response, watching as her eyes become glued to it. She gulps as you slide it over her pussy teasingly before inserting yourself all at once.

You start moving, plunging as deeply into her as you can. Pulling back until just your tip remains on the inside of her pussy, you thrust back in.""", # MISSING TRANSLATION
	DAISY_WEDDING_5 = """Her pussy clings tightly to your dick as you pleasure her with fast and hard motions. The wet sounds from your intercourse messily stain the bed. Daisy seems to have relaxed since your insertion, watching as you fuck her.

— Ngh...! I'm...!!""", # MISSING TRANSLATION
	DAISY_WEDDING_6 = """Daisy's pussy tightens around your dick as a wave of her cum flows out. She shivers as she submissively gives in to your will. Her exasperation leads to heavy breaths as she takes you inside her dutifully.

Despite her words, Daisy's eyes are locked to yours as you fill her pussy with your cum. Your dick wildly ejaculates inside her pussy, filling her up quickly. Her ears twitch and her whole body shivers from the heat warming her up inside.

— Master... Thank you for loving me... I still feel like I don't deserve this...

You lean over and kiss Daisy as your cum continues to messily spill out of her pussy. Despite just unleashing a load inside her, Daisy seems riled up and ready for more.

— K–Keep going... Master!

How can you deny a cute face like that? You grant her what she so desires for the rest of the night, making love to her until morning.""", # MISSING TRANSLATION
	AMELIA_WEDDING_1 = """As you pull yourself from the festivities, you feel a soft tail curl around your leg and tickle your skin. Amelia slinks closer to you, clinging to your arm and holding it between her breasts as she gives you a knowing stare.

— Master [name], getting away from the crowd? I thought you would be the life of the party, entertaining your guests with stories of your great accomplishments? Of course, once you were done with that, I would come “relieve” you of your duties. Looks like we'll get to have some fun early.""", # MISSING TRANSLATION
	AMELIA_WEDDING_1_OPTION_1 = """Trying to pull your Master away for yourself? Sounds like this kitty could use some discipline...""", # MISSING TRANSLATION
	AMELIA_WEDDING_1_OPTION_2 = """Getting rest is part of a Master's duties as well. You'll get your fun when I have time.""", # MISSING TRANSLATION
	AMELIA_WEDDING_2_1 = """You turn to her and pull her into your embrace, pointing her chin up to you. The mischief in her eyes is plain to see as she enjoys teasing you.

— Mmm... I'm here to please, Master [name]. Do what you must to make sure I understand exactly how naughty I've been...

Sharing a kiss with her, you grab one of her breasts and squeeze it tight, making her moan in your mouth. Amelia cups your bulge, rubbing it back and forth as it grows and fills out her palm. Her tail coils around your leg, gently pulling you towards her as she grinds her body against yours.

— Come on, show me how rough you can be with your property, Master [name]...

You pull her along with you to the bedroom, groping her plush ass the entire way. Even as you open the door, her body seems to pull at you for your attention.""", # MISSING TRANSLATION
	AMELIA_WEDDING_2_2 = """— I didn't know you would be such a tease, even on our wedding day. I'll have a long list of transgressions to discipline me for if you put my correction off, you know. I'm sure you'll be very rough when the time comes for my punishment...""", # MISSING TRANSLATION
	AMELIA_WEDDING_3 = """As soon as you close the door, Amelia takes a seat on the bed, pulling up her dress to reveal her pussy, ready and waiting for you. Her breasts fall out of the loose fabric of her dress, baring all of herself to you as she gives a devious smile.

— As a discerning Master, I'm sure you can spot my best assets. They're all yours to do as you please.

Matching her nude state, you lay your dick over her pussy as you decide how to treat your taunting slave.""", # MISSING TRANSLATION
	AMELIA_WEDDING_3_OPTION_1 = """Fast and hard.""", # MISSING TRANSLATION
	AMELIA_WEDDING_3_OPTION_2 = """Slow and gentle.""", # MISSING TRANSLATION
	AMELIA_WEDDING_4_1 = """You slip into her and press all the way in at once, feeling her pussy wrap around the entire length of your cock.

— Oh...! You are quite enthusiastic for our first night as an official spouses.

Pulling back just as fast, you start thrusting into her with all your weight. Each collision rocks her body, her tits bouncing back from your powerful thrusts. You grab her thigh with one hand and a breast in the other, squeezing both tight enough to leave marks as your fingers sink into her skin. Your pistoning dick makes loud and sloppy sounds with her pussy, your precum and her juices serving as the source.

— Ahh!! ...Harder.. You know I can take it...""", # MISSING TRANSLATION
	AMELIA_WEDDING_4_2 = """Sliding your cock inside, you push past all her folds and let her pussy slowly engulf your shaft.

— Mm... Are you trying to tease me like this?

Stroking her thigh, you reach forward and hold her face in your hand. You hear her purr as your cock slides all the way inside her, the subtle vibrations making you throb more. On the way back, her pussy does its best to keep you inside, feeling tighter the more you pull away until you push back in again and again. Her body begs for your attention, the heat and wetness of her pussy pulling you back in no matter how many times you rear back.

— You have a funny definition of punishment, Master... It's almost agonizing being treated so sensually...""", # MISSING TRANSLATION
	AMELIA_WEDDING_5 = """The warmth of her hole seems to transfer to your body, a familiar impulse building up inside you. Grabbing her hips, you start thrusting at a consistent pace, using her body to bring yourself closer to relief. Strings of precum help slicken the pathway, letting you slip in and out of her with ease.

Even as you start to rush things, you tease her every so often by pulling out to rub your tip over her clit, watching her moan at your touch. She plays with her breast, groping it as she bites her lip and watches you plow through her.""", # MISSING TRANSLATION
	AMELIA_WEDDING_6 = """— Let's come together... Darling...

You can hold on no longer as you stare into her eyes begging for your cum. Her pussy milks you of your seed as she clings to you, welcoming your cum as it pours out. A wave of her own fluids wash over your cock too as her folds spasm and Amelia shudders.

The mix of your cum spills out onto the bed, leaving a stain as proof of your love. Amelia looks to you for another round, not nearly satisfied with just one “reprimand.” You spend the night disciplining her and making sure she understands just how demanding being your servant can be.""", # MISSING TRANSLATION
	CALI_WEDDING_GOOD_1 = """— Hey... So do you want to...? You know...

Cali tries to look as enticing as possible, using the lighting of the room and a cute pose to accentuate her assets. Her confidence in herself shows with how forward she is, now that she's truly free. You wait for her to finish her sentence, smiling as you see her try to get past her own embarrassment.

— Come on... You know what I mean! I've never had... I never even thought I'd have a husband! I want to do it with you... I–If you want to, I mean!""", # MISSING TRANSLATION
	CALI_WEDDING_GOOD_1_OPTION_1 = """Let's do it.""", # MISSING TRANSLATION
	CALI_WEDDING_GOOD_1_OPTION_2 = """Maybe tomorrow.""", # MISSING TRANSLATION
	CALI_WEDDING_GOOD_2_1 = """— Really? Then... let's go already! 

Cali's tail wags back and forth at the prospect of sharing your time together in bed. She skips ahead and opens the door for you to the bedroom.""", # MISSING TRANSLATION
	CALI_WEDDING_GOOD_2_2 = """— Aw... Okay... But we better do something soon!

You play around with Cali some more before you head to bed for the day.""", # MISSING TRANSLATION
	CALI_WEDDING_BAD_1 = """— ...M–Master?

Cali hesitates to look you directly in the eye, but you can still glean her intentions from how her tail wags behind her. A far cry from how loud-mouthed and indolent she used to be. It seems she wants to receive a reward from her Master.""", # MISSING TRANSLATION
	CALI_WEDDING_BAD_1_OPTION_1 = """I suppose you deserve a little something.""", # MISSING TRANSLATION
	CALI_WEDDING_BAD_1_OPTION_2 = """You'll have to entertain yourself today.""", # MISSING TRANSLATION
	CALI_WEDDING_BAD_2_1 = """— Thank you, Master!

Cali seems hopeful and excited, but she stays behind you and lets you lead the way to the bedroom.""", # MISSING TRANSLATION
	CALI_WEDDING_BAD_2_2 = """— Of course, Master...

Cali walks away with her tail between her legs, slinking away from the festivities.""", # MISSING TRANSLATION
	CALI_WEDDING_3 = """As soon as you get into the room, Cali leans against the dresser and holds a leg up, exposing her pussy to you like a wolf in heat.

— Hurry up, I can't wait anymore...!

You smirk at Cali’s readiness, admiring how her arousal drips down onto the floor as she waits for you. You don’t keep her waiting for long, freeing your dick and stepping closer to caress her thigh. Pressing into her, you watch as her expression melts into pleasure as her pussy closes around you.

— Ah…! It feels even better today for some reason…!""", # MISSING TRANSLATION
	CALI_WEDDING_3_BAD = """As soon as you get into the room, Cali leans against the dresser and holds a leg up, exposing her pussy to you like a wolf in heat.

— Please, Master…!

You smirk at Cali's readiness, admiring how her arousal drips down onto the floor as she waits for you. You don't keep her waiting for long, freeing your dick and stepping closer to caress her thigh. Pressing into her, you watch as her expression melts into pleasure as her pussy closes around you.

— This pose... feels so right...""", # MISSING TRANSLATION
	CALI_WEDDING_4 = """You respond by pressing further into her and beginning to thrust. Cali’s tight pussy clamps down on you every time you push in, trying to keep you inside each time you pull back. She watches your cock plowing into her in awe, silent as she enjoys the pleasure of your dick warming her from the inside.

Her juices spill out around your shaft as her arousal builds, making each successive thrust smoother and easier from all the natural lubricant. The sticky sounds coming from Cali's pussy would surely give anyone a clear picture of what's going on between bride and groom, if Cali's squeaky moans weren't enough of a hint. Her tail flails around behind her as she takes heavy breaths, brushing against your leg every so often.""", # MISSING TRANSLATION
	CALI_WEDDING_5 = """— I-I can feel you so deep inside...

Cali’s pussy clings to your shaft as a wave of her cum flows past, spilling out as her body shivers from the pleasure. You hold her steady as her leg becomes wobbly from the sensations wracking her body.

Feeling the heat inside you welling up too, you pick up the pace. Her cum gives you ample leverage to slip in and out of her hole as she milks you for the seed you can barely hold back from her. Within a few moments, you burst inside her, your cum filling every nook in her pussy as you hold her close.""", # MISSING TRANSLATION
	CALI_WEDDING_5_BAD = """— Ahh…! M–Master! I’m sorry, please… Don’t s-stop…

Cali's pussy clings to your shaft as a wave of her cum flows past, spilling out as her body shivers from the pleasure. You hold her steady as her leg becomes wobbly from the sensations wracking her body.

Feeling the heat inside you welling up too, you pick up the pace. Her cum gives you ample leverage to slip in and out of her hole as she milks you for the seed you can barely hold back from her. Within a few moments, you burst inside her, your cum filling every nook in her pussy as you hold her close.""", # MISSING TRANSLATION
	CALI_WEDDING_6 = """It doesn't take long for your cum to spill out with her own, both fluids running down her leg as you mark her as yours. Cali is speechless as she watches the warmth inside her flow out of her pussy, only barely held in by your cock. Once you pull away from her, the rest follows suit and slides down her leg, making a mess of lust.

— T–That was a lot...

You hold Cali close and kiss her, spending the rest of the night close together in bed as you enjoy her petite body.""", # MISSING TRANSLATION
	CALI_WEDDING_6_BAD = """It doesn’t take long for your cum to spill out with her own, both fluids running down her leg as you mark her as yours. Cali is speechless as she watches the warmth inside her flow out of her pussy, only barely held in by your cock. Once you pull away from her, the rest follows suit and slides down her leg, making a mess of lust.

— ...T–Thank you so much, Master… for making me feel this…

You hold Cali close and kiss her, spending the rest of the night close together in bed as you enjoy her petite body.""", # MISSING TRANSLATION
	
	#   QUESTS   #
	MAIN_QUEST_LOAN_NAME = "贷款",
	MAIN_QUEST_LOAN_SUMMARY = "你的豪宅有贷款。你必须找到足够的钱来偿还银行贷款，否则你会被赶出新买的房子。或者，也许可以找到其他方法来处理它...",
	MAIN_QUEST_LOAN_STAGE0 = "您必须拥有超过 {custom_text_function=GetLoanSum#0|} 的金币，在 {custom_text_function=GetLoanDayDetailed#0|}之前。",
	MAIN_QUEST_LOAN_STAGE1 = "您必须拥有超过 {custom_text_function=GetLoanSum#1|} 的金币，在 {custom_text_function=GetLoanDayDetailed#1|}之前。",
	MAIN_QUEST_LOAN_STAGE2 = "您必须拥有超过 {custom_text_function=GetLoanSum#2|} 的金币，在 {custom_text_function=GetLoanDayDetailed#2|}之前。",
	MAIN_QUEST_LOAN_STAGE3 = "您必须拥有超过 {custom_text_function=GetLoanSum#3|} 的金币，在 {custom_text_function=GetLoanDayDetailed#3|}之前。",

	GUILDS_INTRODUCTION_NAME1 = "四大行会",
	GUILDS_INTRODUCTION_NAME2 = "第一步",
	GUILDS_INTRODUCTION_NAME3 = "新朋友",
	GUILDS_INTRODUCTION_SUMMARY = "你必须了解阿利隆最强大的机构。四大行会。你必须赢得他们的信任和忠诚。",
	GUILDS_INTRODUCTION_STAGE0 = "访问四个阿利隆行会：战士、仆人、工人、法师；并选择一个加入。",
	GUILDS_INTRODUCTION_STAGE1 = "现在，你已经习惯了阿利隆的秩序，你应该开始提高你的声望。在四个行会中的一个获得至少300的声誉。你可以通过完成城市公告板上的任务来做到这一点。",
	GUILDS_INTRODUCTION_STAGE1_5 = "您在其中一个派系中赢得了足够的声誉。请等待几天。",
	GUILDS_INTRODUCTION_STAGE2 = "今天早上来了一封意想不到的信。建议你去仆人公会看看他们的首领。",

	FIGHTERS_ELECTION_NAME = "通过仪式",
	FIGHTERS_ELECTION_SUMMARY = "在你试图获得战士行会对未来选举的支持时，邓肯要求你获得一件重要物品。",
	FIGHTERS_ELECTION_STAGE_1 = "获取并将巫妖的头骨交给战士行会，让他们支持你参加市长选举。邓肯给了你一个可以找到头骨的位置。",
	FIGHTERS_ELECTION_STAGE_2 = "你获得了一个巫妖的头骨。有了这个，战士行会将为你提供支持。你应该回到邓肯身边。",

	MAGES_ELECTION_NAME = "黑暗精灵女巫",
	MAGES_ELECTION_SUMMARY = "在你试图获得法师行会对未来选举的支持时，梅尔给了你一个个人任务。",
	MAGES_ELECTION_STAGE_1 = "梅尔让我去阿利隆附近看望她的妹妹扎里，取回她的书。",
	MAGES_ELECTION_STAGE_2 = "为了得到梅尔的书，扎里让你给她找一个精灵男孩，并把他带到她身边。",
	MAGES_ELECTION_STAGE_3 = "你有梅尔让你带的书。是时候给她汇报了。",

	WORKERS_ELECTION_NAME = "缺少付款",
	WORKERS_ELECTION_SUMMARY = "为了让工人行会支持未来的选举，西格蒙德要求你解决他们与战士行会的问题。",
	WORKERS_ELECTION_STAGE_1 = "工人协会的西格蒙德让你去拜访战士协会的邓肯，并从之前的发货中取回付款。",
	WORKERS_ELECTION_STAGE_2 = "邓肯告诉我雷姆是快递员，他应该给工人行会带钱。我应该在阿利隆找他，弄清楚发生了什么。",
	WORKERS_ELECTION_STAGE_3 = "雷姆拒绝完成他的职责，并要求你为他付款。你应该回到邓肯身边。",
	WORKERS_ELECTION_STAGE_4 = "你已经解决了战士行会的付款问题，现在是时候回到西格蒙德身边了。",

	ELECTION_GLOBAL_NAME = "市长选举",
	ELECTION_GLOBAL_SUMMARY = "根据城市的选举程序，任何土地所有者都有资格成为市长，只要他们得到行会的支持。",
	ELECTION_GLOBAL_STAGE_1 = "在至少3个主要行会中赢得500声誉，并获得他们对未来选举的支持。\n\n{custom_text_function=election_quest_text|}",

	ALIRON_CHURCH_NAME = "启发",
	ALIRON_CHURCH_SUMMARY = "你在阿利隆的教堂见过金妮。",
	ALIRON_CHURCH_STAGE_1 = "信仰赛琳娜的阿利隆教堂的金妮让你给她带25个肉汤。",

	CIVIL_WAR_START_NAME = "背叛",
	CIVIL_WAR_START_SUMMARY = "随着内战的开始，你的任务是找出本应防止城市内部被攻破的魔法屏障发生了什么。",
	CIVIL_WAR_START_STAGE_1 = "找到梅尔以获取更多信息 ",
	CIVIL_WAR_START_STAGE_2 = "你已经了解到，最有可能导致屏障故障的罪魁祸首是弗雷德，他失踪了，去了阿利隆的宿舍。 ",
	CIVIL_WAR_START_STAGE_3 = "你已经了解到，屏障故障最有可能的罪魁祸首是弗雷德，他失踪了，似乎他要去会见一个叫格雷格的人。请调查他们的会面地点。",
	CIVIL_WAR_START_STAGE_4 = "你已经处理完弗雷德的事情了，是时候向梅尔汇报了",
	CIVIL_WAR_START_STAGE_5 = "你已经处理完弗雷德和梅尔的事情了，是时候向邓肯汇报了",

	CIVIL_WAR_MINES_NAME = "矿井危机",
	CIVIL_WAR_MINES_SUMMARY = "随着战争的进展，您收到一条消息，西格蒙德和工人行会存在一些问题，可能会对战役产生负面影响。",
	CIVIL_WAR_MINES_STAGE_1 = "在工人行会与西格蒙德会面，找出问题所在。",
	CIVIL_WAR_MINES_STAGE_2 = "西格蒙德告诉你，其中一座矿井最近被反叛组织占领。你必须前往那里，让矿井恢复工作。",
	CIVIL_WAR_MINES_STAGE_3 = "你已经处理好了矿井问题，是时候回到西格蒙德身边了。",
	CIVIL_WAR_MINES_STAGE_4 = "你已经处理好了矿井问题，并向西格蒙德报告，是时候看看邓肯为你准备了什么新任务了。",

	LEAD_CONVOY_NAME = "行会反击",
	LEAD_CONVOY_SUMMARY = "行会准备从叛军手中夺回一座城镇。大围攻即将开始。",
	LEAD_CONVOY_STAGE_1 = "你应该去拜访邓肯，了解你的下一个目标。",
	LEAD_CONVOY_STAGE_2 = "邓肯命令你率领补给车队进行准备好的围攻。你可以在阿利隆找到它。",
	LEAD_CONVOY_STAGE_3 = "你必须和邓肯一起进攻叛军占领的城镇。",

	DIVINE_SYMBOL_NAME = "神术",
	DIVINE_SYMBOL_SUMMARY = "城镇之战被一个神术魔法罩打断了。你无法进入，战斗被暂停。",
	DIVINE_SYMBOL_STAGE_1 = "邓肯命令你找到一种方法来驱散魔法罩。梅尔建议你去附近的宗教机构看看，也许阿利隆的赛琳娜教堂可以给你一些帮助。",
	DIVINE_SYMBOL_STAGE_2 = "阿利隆教堂的金妮告诉你给她会做一个神圣的象征。这应该会帮助你越过障碍。",
	DIVINE_SYMBOL_STAGE_3 = "既然你已经从金妮那里收到了神圣的象征，是时候回到邓肯身边了。",
	DIVINE_SYMBOL_STAGE_4 = "邓肯告诉你要击溃神眷者和保护城市的屏障。组建团队，继续前进。",

	FINAL_OPERATION_NAME = "狩猎叛军",
	FINAL_OPERATION_SUMMARY = "虽然在围攻中获胜，但你仍然找不到叛军的领导人。然而，看起来邓肯对此有计划。",
	FINAL_OPERATION_STAGE_0 = "等待进一步的指示",
	FINAL_OPERATION_STAGE_1 = "你应该去拜访邓肯，了解你的下一个目标。",
	FINAL_OPERATION_STAGE_2 = "邓肯准备攻击叛军的藏身处。你应该在那里加入他的行列。",

	PRINCESS_SEARCH_NAME = "追捕公主",
	PRINCESS_SEARCH_SUMMARY = "随着叛军主要藏身处的清理，公主正在逃亡。然而，除非她被抓获并带回，无论是死是活，否则你都无法完成任务。",
	PRINCESS_SEARCH_STAGE_1 = "你应该去拜访邓肯，了解你的下一个目标。",
	PRINCESS_SEARCH_STAGE_2 = "邓肯解释说，在找到公主之前，你无法完成选举。是时候找到任何线索来帮助你找到她了。",
	PRINCESS_SEARCH_STAGE_3 = "你已经知道公主藏在精灵之地。前往精灵之都并抓捕她。",
	PRINCESS_SEARCH_STAGE_4 = "不幸的是，公主去世了，但你已经得到了她的尸体。回到邓肯那里完成任务。",
	PRINCESS_SEARCH_STAGE_5 = "你亲自抓了公主。是时候把她带回邓肯身边了。",

	PRINCESS_PERSUASION_NAME = "苦恼的少女",
	PRINCESS_PERSUASION_SUMMARY = "叛军的前领导人，公主阿纳斯塔西娅在行会之手。然而你反对处决她的想法。考虑到你的声誉，你被允许说服她服从行会，在这种情况下，你就能得到她。",
	PRINCESS_PERSUASION_STAGE_1 = "你被允许说服阿纳斯塔西娅屈服于行会。想办法这样做，或者同意处决她。",

	FINAL_WORDS_NAME = "感谢您的参与",
	FINAL_WORDS_SUMMARY = "您已经完成了现有主要故事内容的游玩。谢谢您，请等待下一次更新",

	DAISY_CLOTHES_NAME = "黛西: 新衣服",
	DAISY_CLOTHES_SUMMARY = "你的奴隶黛西可以用一套新衣服。",
	DAISY_CLOTHES_STAGE_1 = "和西格蒙德谈谈给黛西的一套新衣服。",
	DAISY_CLOTHES_STAGE_2 = "和阿米莉亚谈谈给黛西的一套新衣服",
	DAISY_CLOTHES_STAGE_3 = "等一下，直到黛西把新衣服穿好。 ",

	DAISY_TRAINING_NAME = "黛西: 训练",
	DAISY_TRAINING_SUMMARY = "你的奴隶黛西，作为一个合适的仆人，可以接受一些训练。",
	DAISY_TRAINING_STAGE_1 = "与阿米莉亚交谈，并为黛西选择具体的训练。",
	DAISY_TRAINING_STAGE_2 = "等待，直到黛西的训练完成。 ",

	DAISY_LOST_NAME = "黛西: 失踪",
	DAISY_LOST_SUMMARY = "你的奴隶黛西失踪了。你应该在为时已晚之前把她找回来。",
	DAISY_LOST_STAGE_1 = "拜访阿米莉亚，了解黛西可能发生了什么",
	DAISY_LOST_STAGE_2 = "找到应该在拉蒙特庄园的黛西",
	
	AMELIA_SILK_NAME = "阿米莉亚: 请求",
	AMELIA_SILK_SUMMARY = "在向仆人行会证明自己很有用之后，阿米莉亚给了你一项任务。",
	AMELIA_SILK_STAGE_1 = "在仆人行会给阿米莉亚送50块丝绸。",
	
	AMELIA_HERBS_NAME = "阿米莉亚: 精灵植物",
	AMELIA_HERBS_SUMMARY = "在帮助她之后，阿米莉亚给了你一项新任务来赢得她的青睐。",
	AMELIA_HERBS_STAGE_1 = "去仆人公会拜访阿米莉亚", # 去找阿米莉亚问她怎么了
	AMELIA_HERBS_STAGE_2 = "前往精灵之都，找到阿米莉亚告诉你的供应商。", # 获取草药
	AMELIA_HERBS_STAGE_3 = "回到仆人行会的阿米莉亚身边", # 返回阿米莉亚身边
	
	MARRIAGE_MAIN_NAME = "婚礼",
	MARRIAGE_MAIN_SUMMARY = "婚礼",
	MARRIAGE_MAIN_STAGE_1 = "支付500金币到阿利隆的教堂举行婚礼。",
	MARRIAGE_MAIN_STAGE_2 = "与仆人行会和工人行会完成准备工作，然后访问教堂开始婚礼",
	MARRIAGE_SERVANTS_SUMMARY = "婚姻：面包和马戏团",
	MARRIAGE_SERVANTS_NAME = "婚姻：面包和马戏团",
	MARRIAGE_SERVANTS_STAGE_1 = "在仆人行会为阿米莉亚送去200份鱼、肉、蔬菜和谷物、10杯威士忌、25杯啤酒和3000金币。",
	MARRIAGE_WORKERS_SUMMARY = "婚姻：一套漂亮的西装",
	MARRIAGE_WORKERS_NAME = "婚姻：一套漂亮的西装",
	MARRIAGE_WORKERS_STAGE_1 = "将150份丝绸、50份魔法布和1000金币交给工人行会裁缝。",
	
	GRYPHON_QUEST_NAME = "艾尔：力量证明",
	GRYPHON_QUEST_SUMMARY = "你决定向艾尔证明自己，这样她就可以放松对阿纳斯塔西娅安全的担忧",
	GRYPHON_QUEST_STAGE_1 = "与西格蒙德讨论老鹰头狮的可能位置",
	GRYPHON_QUEST_STAGE_2 = "在阿利隆与德里克交谈",
	GRYPHON_QUEST_STAGE_3 = "在鹰头狮灌木丛中搜寻鹰头狮的踪迹",
	GRYPHON_QUEST_STAGE_4 = "在老鹰头狮巢穴处追捕老鹰头鹰",
	
	PRE_SWORD_ARTIFACT_QUEST_NAME = "神眷者归来",
	PRE_SWORD_ARTIFACT_QUEST_SUMMARY = "似乎有人希望你出现在在阿利隆教堂",
	PRE_SWORD_ARTIFACT_QUEST_STAGE_1 = "参观阿利隆的教堂，看看是谁召唤了你。",
	
	SWORD_ARTIFACT_QUEST_NAME = "森林与野兽",
	SWORD_ARTIFACT_QUEST_SUMMARY = "即使内战已经结束，你的未来似乎还有更大的问题。西菲拉告诉你要去收集一件古代文物。下一件似乎可以在精灵之地找到。",
	SWORD_ARTIFACT_QUEST_STAGE_1 = "到阿利隆教堂拜访金妮",
	SWORD_ARTIFACT_QUEST_STAGE_2 = "与精灵首都的女祭司交谈",
	SWORD_ARTIFACT_QUEST_STAGE_3 = "访问兽化裔部落",
	SWORD_ARTIFACT_QUEST_STAGE_4 = "参观兽化裔部落的小屋",
	SWORD_ARTIFACT_QUEST_STAGE_5 = "将2000份肉和鱼带给萨夫拉",
	SWORD_ARTIFACT_QUEST_STAGE_6 = "1天后返回兽化裔部落",
	SWORD_ARTIFACT_QUEST_STAGE_7 = "拜访兽化裔部落",
	SWORD_ARTIFACT_QUEST_STAGE_77 = "与梅一起进行仪式",
	SWORD_ARTIFACT_QUEST_STAGE_8 = "在兽化裔部落寻找莱昂",
	SWORD_ARTIFACT_QUEST_STAGE_9 = "在森林位置搜索莱昂",
	SWORD_ARTIFACT_QUEST_STAGE_10 = "和萨夫拉谈谈阻止莱昂的疯狂",
	SWORD_ARTIFACT_QUEST_STAGE_11 = "向萨夫拉交付50块魔法木、25块铁木和15块神话皮革",
	SWORD_ARTIFACT_QUEST_STAGE_12 = "为萨夫拉的工作寻找助手",
	SWORD_ARTIFACT_QUEST_STAGE_13 = "再次寻找助莱昂",
	SWORD_ARTIFACT_QUEST_STAGE_14 = "追踪白牡鹿",
	SWORD_ARTIFACT_QUEST_STAGE_15 = "在精灵首都与精灵对话",
	
	TEMPLE_QUEST_NAME = "古代精灵神庙",
	TEMPLE_QUEST_SUMMARY = "弗雷娅的女祭司海伦维尔让你带一些仪式所需的圣水来。",
	TEMPLE_QUEST_STAGE_1 = "访问古精灵神庙获取圣水",
	TEMPLE_QUEST_STAGE_2 = "带圣水给海伦维尔",
	
	GETTING_LIRA_QUEST_NAME = "启示录",
	GETTING_LIRA_QUEST_SUMMARY = "一切就绪后，你必须与埃伦一起行动，试图对付海伦维尔。 ",
	GETTING_LIRA_QUEST_STAGE_1 = "寻找埃伦",
	GETTING_LIRA_QUEST_STAGE_2 = "想办法把年轻的女祭司从精灵之都带到埃伦处",
	GETTING_LIRA_QUEST_STAGE_3 = "拿10杯威士忌把里拉带出寺庙",
	GETTING_LIRA_QUEST_STAGE_4 = "带着里拉返回埃伦处",
	GETTING_LIRA_QUEST_STAGE_5 = "在精灵之都与埃伦相见",
	
	CALI_FIGHTERS_QUEST_NAME = "卡莉: 小而勇敢",
	CALI_FIGHTERS_QUEST_SUMMARY = "你的成员卡莉想变得更有用，决定加入战士行会",
	CALI_FIGHTERS_QUEST_STAGE_1 = "访问战士行会为卡莉注册",
	CALI_FIGHTERS_QUEST_STAGE_2 = "前往村庄帮助卡利驱逐哥布林",
	CALI_FIGHTERS_QUEST_STAGE_3 = "向战士行会报告",
	CALI_SERVANTS_QUEST_SUMMARY = "你的门客卡莉希望变得更女性化，并希望参加仆人课程。",
	CALI_SERVANTS_QUEST_NAME = "卡莉是个女孩",
	CALI_SERVANTS_QUEST_STAGE_1 = "代表卡莉访问仆人行会",
	CALI_HEIRLOOM_QUEST_SUMMARY = "卡莉的过去终于追上了她。如果你想让她留在你身边，你必须帮助她解决问题...",
	CALI_HEIRLOOM_QUEST_NAME = "卡莉: 贱民",
	CALI_HEIRLOOM_QUEST_STAGE_1 = "访问村庄 ",
	CALI_HEIRLOOM_QUEST_STAGE_2 = "给农民带来200块原木",
	CALI_HEIRLOOM_QUEST_STAGE_2_1 = "给农民带来100块原木",
	CALI_HEIRLOOM_QUEST_STAGE_3 = "寻找土匪",
	CALI_HEIRLOOM_QUEST_STAGE_4 = "寻找阿利隆的收藏家",
	CALI_HEIRLOOM_QUEST_STAGE_5 = "看来你还不能见到威廉……也许你现在必须做点什么。",
	CALI_HEIRLOOM_QUEST_STAGE_5_1 = "在阿利隆城拜访威廉",
	CALI_HEIRLOOM_QUEST_STAGE_6 = "从威廉那里得到卡利的传家宝剑",
	CALI_HEIRLOOM_QUEST_STAGE_7 = "等待卡莉返回",
	CALI_HEIRLOOM_QUEST_STAGE_8 = "等待一段时间",
	CALI_HEIRLOOM_QUEST_STAGE_9 = "与卡莉交谈",
	CALI_HEIRLOOM_QUEST_STAGE_10 = "拜访卡莉的家",
	
	LILIA_MEET_QUEST_NAME = "莉莉亚：不寻常的仙精",
	LILIA_MEET_QUEST_SUMMARY = "你了解到一个居住在森林定居点的非凡仙精。也许值得调查",
	LILIA_MEET_QUEST_STAGE_1 = "在一个森林定居点找到一个你听说过的仙精",
	LILIA_MEET_QUEST_STAGE_2 = "劝说莉莉娅加入您",
	
	SICK_LILIA_QUEST_NAME = "莉莉娅: 水土不服",
	SICK_LILIA_QUEST_SUMMARY = "莉莉娅生病了。现在由你来帮助她。",
	SICK_LILIA_QUEST_STAGE_1 = "向梅尔寻求帮助",
	SICK_LILIA_QUEST_STAGE_2 = "拜访扎里",
	SICK_LILIA_QUEST_STAGE_3 = "找到偷了扎里衣服的巨魔",
	SICK_LILIA_QUEST_STAGE_35 = "从巨魔那里得到扎里的衣服",
	SICK_LILIA_QUEST_STAGE_4 = "带着衣服回到扎里处",
	SICK_LILIA_QUEST_STAGE_5 = "治愈莉莉娅",
	
	CALI_TAMING_QUEST_NAME = "卡莉：驯兽",
	CALI_TAMING_QUEST_SUMMARY = "在带走一个狼女之前，你决定对她施暴。然而，这需要你的进一步关注。",
	CALI_TAMING_QUEST_STAGE_1 = "为了卡莉的新配件访问工人行会",
	CALI_TAMING_QUEST_STAGE_2 = "在阿利隆中找到利姆罗夫并咨询项圈",
	CALI_TAMING_QUEST_STAGE_3 = "带项圈材料返回",
	CALI_TAMING_QUEST_STAGE_4 = "等待项圈完成",
	CALI_TAMING_QUEST_STAGE_5 = "等一会",
	CALI_TAMING_QUEST_STAGE_6 = "找个法师帮你",
	CALI_TAMING_QUEST_STAGE_7 = "带着所需材料返回吉恩处",
	CALI_TAMING_QUEST_STAGE_8 = "返回法师行会",
	CALI_TAMING_QUEST_STAGE_9 = "等一会",
	CALI_TAMING_QUEST_STAGE_10 = "与卡莉谈话",
	CALI_TAMING_QUEST_STAGE_11 = "等一会",
	CALI_TAMING_QUEST_STAGE_12 = "在阿利隆中搜索新发现",
	CALI_TAMING_QUEST_STAGE_13 = "返回商户",
	CALI_TAMING_QUEST_STAGE_14 = "等待一段时间",
	CALI_TAMING_QUEST_STAGE_15 = "参观阿利隆的宠物店",
	CALI_TAMING_QUEST_STAGE_16 = "与卡莉谈话",
	CALI_TAMING_QUEST_STAGE_17 = "与卡莉谈话",
	
	ZEPHYRA_BATH_QUEST_NAME = "西菲拉：半日修女",
	ZEPHYRA_BATH_QUEST_SUMMARY = "看起来西菲拉在做什么...",
	ZEPHYRA_BATH_QUEST_STAGE_1 = "升级您的豪宅以容纳浴缸。",
	ZEPHYRA_BATH_QUEST_STAGE_2 = "等待某些事情发生。",
	
	GOBLIN_QUEST_NAME = "树林中的绿色",
	GOBLIN_QUEST_SUMMARY = "你收到了一个来自你之前战斗过的森林精灵的不同寻常的请求，想知道是谁扰乱了森林。",
	GOBLIN_QUEST_STAGE_0 = "访问兽化裔部落",
	GOBLIN_QUEST_STAGE_1 = "前往被破坏的森林",
	GOBLIN_QUEST_STAGE_2 = "在被破坏的森林寻找罪犯",
	GOBLIN_QUEST_STAGE_3 = "向行会领袖询问陷阱线索",
	GOBLIN_QUEST_STAGE_4 = "再次在被破坏的森林寻找罪犯",
	GOBLIN_QUEST_STAGE_5 = "返回白鹿处获得奖励", 
	
	ZEPHYRA_DISAPPEARANCE_QUEST_NAME = "白色画布",
	ZEPHYRA_DISAPPEARANCE_QUEST_SUMMARY = "西菲拉的绘画爱好遇到了一些问题，导致了一些不幸的事件", 
	ZEPHYRA_DISAPPEARANCE_QUEST_STAGE_1 = "在阿利隆搜索西菲拉", # 搜索西菲拉
	ZEPHYRA_DISAPPEARANCE_QUEST_STAGE_2 = "等到收到凯奇的来信", # 等信（或做圣碗）
	ZEPHYRA_DISAPPEARANCE_QUEST_STAGE_3 = "在既定地点会见凯奇", # 会见凯奇
	
	#2fix
	AMELIA_MAIN_QUEST_NAME = "阿米莉亚: 猫科罪犯",
	AMELIA_MAIN_QUEST_SUMMARY = "仆人行会的阿米莉亚有事情要做。也许你最好调查一下",
	AMELIA_MAIN_STAGE_0 = "拜访仆人行会领袖",
	AMELIA_MAIN_STAGE_1 = "在阿利隆中搜索失踪的奴隶",
	AMELIA_MAIN_STAGE_2 = "与阿利隆中找到的奴隶对话",
	AMELIA_MAIN_STAGE_3 = "在阿利隆中搜索失踪的奴隶",
	AMELIA_MAIN_STAGE_4 = "与阿利隆中找到的奴隶对话",
	AMELIA_MAIN_STAGE_5 = "在阿利隆中搜索失踪的奴隶",
	AMELIA_MAIN_STAGE_6 = "与阿利隆中找到的奴隶对话",
	AMELIA_MAIN_STAGE_7 = "在阿利隆之外找到阿米莉亚",
	AMELIA_MAIN_STAGE_8 = "和阿米莉亚一起回到仆人行会",
	AMELIA_MAIN_STAGE_9 = "参加对阿米莉亚的审判",
	AMELIA_MAIN_STAGE_10 = "从仆人行会那里购买阿米莉亚",
	AMELIA_MAIN_STAGE_11 = "在你的豪宅里与阿米莉亚交谈",
	
	DIALOGUEANAINITIATELP = "阿纳斯塔西娅害羞地向你打招呼。她似乎真的不习惯这个新角色。\n\n— 你-你好, [Master]... 你今天过得怎么样?",
	DIALOGUEANAINITIATELN = "阿纳斯塔西娅带着冷酷的表情来看你。也许你必须努力激发她的动力。她保持沉默，对你无话可说。\n\n— ......",
	DIALOGUEANAINITIATEHP = "阿纳斯塔西娅微笑着迎接你。尽管她没有表现出来，但她看起来很满足。\n\n— [Master]。你感觉好吗？我能为你做什么吗？",
	DIALOGUEANAINITIATEHN = "阿纳斯塔西娅以顺从的姿态迎接你。她似乎终于放弃了旧生活，接受了这个角色。\n\n— [Master]！我怎么能为你服务？",
	DIALOGUEANAINITIATEM = "你的妻子阿纳斯塔西娅对你热情地微笑。\n\n— 亲爱的，你找我？",
	DIALOGUEANAINITIATEB = "当阿纳斯塔西娅回应你的召唤时，她的眼睛几乎一片空白。\n\n— 你的命令是什么, [Master]?",
	DIALOGUEAIREINITIATELN = "你的精灵奴隶艾尔被单独留在你的监护之下，她默默地看着你，厌恶地看着你。她的姿势散发出抗议的气息。",
	DIALOGUEAIREINITIATEHN = "你的精灵奴隶艾尔已经服从你的支配，现在耐心地等待你的命令。\n\n— 你的命令是什么，主人？",
	DIALOGUEAIREINITIATELP = "你的精灵奴隶艾尔站在你面前，虽然不那么敌对，但仍然很谨慎。\n\n— 你想见我吗？安娜过得好吗？",
	DIALOGUEAIREINITIATEHP = "你的精灵奴隶艾尔随时恭候你的召唤。尽管她是奴隶，但她似乎对你越来越信任了。\n\n— [Master]。 你想见我吗？我希望你尊重安娜。",
	DIALOGUEZEPHINITIATEL = "神秘的西菲拉一如既往地出现在你面前，几乎不知不觉。\n\n— 你好, [Master]。 你在找我吗？",
	DIALOGUEZEPHINITIATEH = "狐狸女孩西菲拉漫不经心地出现在你面前。\n\n— [Master]。你今晚要做什么？来个茶话会怎么样？\n\n她似乎忽略了是你召唤她的事实。",
	DIALOGUEZEPHINITIATEM = "你的妻子，一向古怪的狐狸女孩西菲拉出现了，抓住你的手，迅速与你拉近距离。\n\n— 亲爱的！你想我了吗？\n\n她深情地用她的尾巴缠绕你的腿。..",
	DIALOGUEDAISYINITIATEL = "你最近的收获：一个害羞的兔子女孩，当你召唤她时，黛西出现了。\n\n— 是-是的, [Master]。我能做什么？\n\n你觉得她几乎不得不强迫自己注视你。",
	DIALOGUEDAISYINITIATEH = "小兔子黛西出现在你面前。她似乎已经习惯了为你服务。\n\n— [Master], 你今天过得怎么样？我能为你做什么？",
	DIALOGUEDAISYINITIATEM = "你的妻子和奴隶黛西站在你面前。\n\n— [Master], 你今天过得怎么样？你想吃饭、洗澡还是我…？对不起，有人告诉我这样问候你是个好方法！",
	DIALOGUECALIINITIATELP = "狼女卡莉很快出现了，没有任何恐惧或害羞的迹象。\n\n— 嘿，怎么了?!",
	DIALOGUECALIINITIATELN = "狼女卡莉在你召唤她的时候不情愿地来了。她几乎不开玩笑。\n\n— 你-你想要什么？",
	DIALOGUECALIINITIATEHP = "卡莉出现在你面前，急切地乞求你的注意，摇着尾巴。\n\n— [Master]! 我们今天要做什么？想一起去哪里吗？我听说有一个很好的肉摊...",
	DIALOGUECALIINITIATEHN = "卡莉低垂着耳朵顺从地出现在你的命令下。她顺从地服从你的命令，她的勇气终于被铲除了。\n\n— 我-我能为你做什么, [Master]?",
	DIALOGUECALIINITIATEM = "你年轻的妻子卡莉在你拜访她时向你扑来。她的婚姻状况似乎并没有真正影响她的性格。\n\n— [Master]! 我们今天在做什么？想一起玩吗？",
	DIALOGUELILIAINITIATEL = "莉莉娅开心地笑着出现在你面前。\n\n— [Master]? 你在干什么？你是来和我玩的吗？",
	DIALOGUELILIAINITIATEH = "小仙精在你召唤她的时候不耐烦地扑向你。 \n\n— 没有你，我太孤独了, [Master]! 你能让我高兴起来吗？",
	DIALOGUELILIAINITIATEM = "你生活奢侈的妻子莉莉娅热情地问候你，几乎没有掩饰她的兴奋。\n\n— [Master], 你一直在想念莉莉娅？我们上床睡觉吧！",
	DIALOGUEJEANINITIATEM = "",
	DIALOGUEZEPHYRA_UNDERWEAR = """In your hands you hold a piece of clothing which was surrendered to you by Zephyra. Pondering on what actual benefit it can have, one mind is stuck in your mind... What if you wear it on your head? Surely, this is a terrible idea...""", # MISSING TRANSLATION
	DIALOGUEZEPHYRA_UNDERWEAROPTION = """Do it""", # MISSING TRANSLATION
	DIALOGUEZEPHYRA_UNDERWEAR2 = """Despite your best judgement, you put a girl's underwear onto your head. You feel nothing like you would expect but the sudden revelation is abrupted by the owner entering your room just at this moment. 
	
— [Master], can I have a mo...

Zephyra freezes as she sees your deed. Her face spells your doom. The time stops and you can no longer process the world around you, as the last breath leaves your body...""", # MISSING TRANSLATION
	
	
	
	
	
	METRICS_BASE = "[name] 已经成为您家庭的一部分 {color=yellow|%d} 周 {color=yellow|%d} 天了。",
	METRICS_BASE_YOU = """[name] is a [master] and has been in this household for {color=yellow|%d} weeks and {color=yellow|%d} days.""", # MISSING TRANSLATION
	METRICS_DATES_MASTER = "[He] 约会了 {color=yellow|%d} 次，并进行了 {color=yellow|%d} 次性活动。",
	METRICS_DATES = "[He] 与你约会了 {color=yellow|%d} 次，并进行了 {color=yellow|%d} 次性活动。",
	METRICS_PARTNERS = "总的来说 [he]在这段时间里与 {color=yellow|%d} 名伴侣发生了性关系。 ",
	METRICS_PARTNERS_ONE = "[He] 一直只有一个 {color=yellow|single partner} 。 ",
	METRICS_PARTNERS_NONE = "到目前为止 [he] 似乎没有与任何人发生性行为... ",
	METRICS_IMPREGS = "[He] 已怀孕 {color=yellow|%d} 次，最终导致孩子出生 {color=yellow|%d} 次。 ",
	METRICS_PEGNANCIES = "[He] 使人怀孕 {color=yellow|%d} 次。 ",
	METRICS_VIRGINITY_YOU = "[He] 因 {color=yellow|you} 失去阴道童贞。 ",
	METRICS_VIRGINITY_OTHER = "[He] 因 {color=yellow|%s} 失去阴道童贞。 ",
	METRICS_ANAL_VIRGINITY_YOU = "[His] 初次肛交是与 {color=yellow|you} 进行的。 ",
	METRICS_ANAL_VIRGINITY_OTHER = "[His] 初次肛交是与 {color=yellow|%s} 进行的。 ",
	METRICS_EARNED = "[He] 在为你工作时获得了 {color=yellow|%d} 个金币，收集了 {color=yellow|%d} 份食物和 {color=yellow|%d} 份材料。 ",
	METRICS_COMBAT = "[He] 参加了 {color=yellow|%d} 场战斗，击败了 {color=yellow|%d} 名敌人。 ",
	
	
	METRICS_SOURCE_BROTHEL_CUSTOMER = "妓院的顾客",
	METRICS_SOURCE_GUILD_TRAINER = "行会训练师，在性玩具训练中",
	METRICS_SOURCE_WILLIAM = "威廉，阿利隆的著名收藏家",
	METRICS_WIN_NAME = """%d/%d Battles Won""", # MISSING TRANSLATION
	METRICS_SERVICEPERFORMED_NAME = """Performed service task for %d/%d turns""", # MISSING TRANSLATION
	METRICS_SOCSKILLUSED_NAME = """Social skills used %d/%d """, # MISSING TRANSLATION
	METRICS_SPELLUSED_NAME = """Spells Used %d/%d""", # MISSING TRANSLATION
	METRICS_HEALUSED_NAME = """Healing Skills Used %d/%d""", # MISSING TRANSLATION
	
	
	
	# DATING
	
	ANASTASIA_MARRIAGE_AGREED_TEXT = """根据我们的协议……我准备成为你的妻子。""",
	ANASTASIA_MARRIAGE_AGREED_DESCRIPTION = """阿纳斯塔西娅红了一点，但在回答之前，她像个女士一样镇定下来。""",
	ANASTASIA_ENSLAVEMENT_AGREED_TEXT = """对不起，这不会发生，即使你这么说，我也不被允许嫁给你。""",
	ANASTASIA_ENSLAVEMENT_AGREED_DESCRIPTION = """尽管阿纳斯塔西娅显然对你的话感到惊讶，但她还是保持着平静。""",
	AIRE_ANA_ALIVE_TEXT = """不管我对你的感觉如何，我都不能同意。你必须与安娜结婚，而不是我。""",
	AIRE_ANA_ALIVE_DESCRIPTION = """艾尔对你的提议完全无动于衷。""",
	AIRE_ANA_DEAD_TEXT = """不要浪费时间。在发生了安娜的事情之后，我永远不会同意这一点。""",
	AIRE_ANA_DEAD_DESCRIPTION = """艾尔对你的提议完全无动于衷。""",
	DAISY_QUEST_FINISHED_TEXT = """你-你是认真的吗, [Master]?.. 如-如果你觉得我值得……我当然同意！""",
	DAISY_QUEST_FINISHED_DESCRIPTION = """听到你的求婚，DAISY的眼睛睁得大大的。她几乎忍不住喜悦的泪水，慢慢地回答。""",
	DAISY_QUEST_UNFINISHED_TEXT = """我-我很抱歉, [Master], 我觉得这有点太突然了...""",
	DAISY_QUEST_UNFINISHED_DESCRIPTION = """黛西看起来很不安，移开了眼睛。""",
	CALI_QUEST_FINISHED_TEXT = """真的！？我当然同意。从来没有人为我做过这么多……我爱你, [Master]!""",
	CALI_QUEST_FINISHED_DESCRIPTION = """卡莉听到你的话欣喜若狂。和你经历了这么多，她的答案很明显。""",
	CALI_QUEST_UNFINISHED_TEXT = """你这么说真奇怪……对不起，我还没准备好。""",
	CALI_QUEST_UNFINISHED_DESCRIPTION = """卡莉看了你一眼，试图开玩笑。""",
	CALI_BAD_ROUTE_FINISHED_TEXT = """如-如果 [Master] 希望我成为 [his] 妻子，我会很乐意的！""",
	CALI_BAD_ROUTE_FINISHED_DESCRIPTION = """卡莉傻眼地抬头看着你。经过如此长的训练，她只能从你的认可中找到快乐。""",
	CALI_BAD_ROUTE_UNFINISHED_TEXT = """你在开玩笑吗？！谁会嫁给像你这样可怕的人？""",
	CALI_BAD_ROUTE_UNFINISHED_DESCRIPTION = """卡莉显然对你的求婚感到不安。看来你还没有完全掌控她。""",

	#ChatNode
	
	HIRE_LINE1 = "...很高兴见到你, [Master].",
	HIRE_LINE2 = "请多多关照, [Master].",
	HIRE_LINE3 = "所以你是我的新 [Master]! 很高兴见到你！",
	HIRE_LINE4 = "我希望你不要仅仅因为猥亵的需求而带走我。",
	HIRE_LINE5 = "啊，是的……很高兴见到你, [Master]!",
	HIRE_LINE6 = "所以你是我的新 [Master] huh? 你看起来没那么令人印象深刻。",
	HIRE_LINE7 = "太好了。让我们离开这里。迫不及待地想看看我的新家!",
	HIRE_LINE8 = "你看起来很有趣。我们走吧, [Master]。不管怎样，我的天赋都浪费在这里了。",
	HIRE_LINE9 = "我们要出发了，还是说, [Master]?",
	HIRE_LINE10 = "时候到了！再不走我们就永远都出不去了。走吧, [Master]!",
	HIRE_LINE11 = "哦，天哪……很荣幸能为您服务, [Master]。我希望能为您做好服务。",
	HIRE_LINE12 = "我很乐意为您服务, [Master].",
	HIRE_LINE13 = "我太激动了！我迫不及待地想展示我能为你做什么,[Master]!",
	HIRE_LINE14 = "私下里……我希望你能选择我。我不会让你失望的, [Master].",
	HIRE_LINE15 = "我会好好照顾你的, [Master]. 如果你也这样做?",
	HIRE_LINE16 = "的确。这是一个明智的选择, [Master]。让我们离开吧。",
	HIRE_LINE17 = "哦？我想这将是一次学习经历。你不同意吗, [Master]?",
	HIRE_LINE18 = "我看他们派了一个值得我施展才华的人。让我们离开这个地方 [Master]。",
	HIRE_LINE19 = "嗯？啊……对不起。你是我的新 [Master] 对吗？请不要用我来满足你的变态欲求。",
	HIRE_LINE20 = "我想没办法。我的技能是你的了, [Master].",
	HIRE_LINE21 = "我？我的意思是……如果你确信这一点, [Master]...",
	HIRE_LINE22 = "哦！我以为没人会带走我……我会尽力的...",
	HIRE_LINE23 = "很高兴见到你。希望我不会妨碍你, [Master]...",
	HIRE_LINE24 = "哇-哇……你看起来真的很强壮, [Master]... 请多多关照。",
	HIRE_LINE25 = "你-你不会占我便宜的……你是 [Master]吗?",
	
	SLAVERY_LINE1 = "你……把我变成了奴隶？不... *哭泣*",
	SLAVERY_LINE2 = "你为什么这么做!?",
	SLAVERY_LINE3 = "为什么...? *哭泣*",
	SLAVERY_LINE4 = "这太卑鄙了！我不会接受的！",
	SLAVERY_LINE5 = "你怎么可以？！我恨你！",
	SLAVERY_LINE6 = "我-我明白了……也许这样更好...?",
	SLAVERY_LINE7 = "我就知道这会发生在我身上...",
	SLAVERY_LINE8 = "我为什么信任你!?",
	SLAVERY_LINE9 = "是我做的什么吗？拜托……你怎么会这样?",
	SLAVERY_LINE10 = "我-我想这毕竟是我的真正目的...",
	SLAVERY_LINE11 = "虽然我对此不太高兴。我会一如既往地为您服务...",
	SLAVERY_LINE12 = "我对你来说不够好吗...?",
	SLAVERY_LINE13 = "请告诉我你不是认真的……为什么...?",
	SLAVERY_LINE14 = "就在我越来越喜欢你的时候...",
	SLAVERY_LINE15 = "我想…这还是比分手好...",
	SLAVERY_LINE16 = "我一看到你就知道你有好色的想法。",
	SLAVERY_LINE17 = "多么令人反感。",
	SLAVERY_LINE18 = "你没有修养吗？",
	SLAVERY_LINE19 = "想想我的生活会导致这样...",
	SLAVERY_LINE20 = "哎呀，我不会原谅你的。",
	SLAVERY_LINE21 = "你怎么敢这样对我!?",
	SLAVERY_LINE22 = "你这个混蛋！如果我更强壮就好了!",
	SLAVERY_LINE23 = "我不喜欢这个，我讨厌你!",
	SLAVERY_LINE24 = "你觉得你现在很强硬，是吧!?",
	SLAVERY_LINE25 = "太残忍了！我不会为你做任何事！",

	EXPERIENCE_LINE1 = "我最近学到了很多……我想我已经为更大的事情做好了准备！",
	EXPERIENCE_LINE2 = "我的技能有所提高。 ",
	EXPERIENCE_LINE3 = "我觉得我学到了很多……你觉得怎么样, [Master]?",
	EXPERIENCE_LINE5 = "呃, [Master], 我想我可以学到一些对你有用的新东西...",
	EXPERIENCE_LINE6 = "[Master], 凭借我的经验，我相信我会对你更有用。",
	EXPERIENCE_LINE61 = "这不是很棒的 [Master]吗？我希望为你做得更好。",
	EXPERIENCE_LINE7 = "[Master]! 我从你身上学到了很多。也许是时候学习新东西了？",
	EXPERIENCE_LINE8 = "哦！我想我掌握了窍门！谢谢你教我！",
	EXPERIENCE_LINE9 = "哇！我感觉很有活力！我准备学习更多！",
	EXPERIENCE_LINE10 = "谢谢你对我这么有耐心 [Master]! 我已经感觉更强壮了！",
	EXPERIENCE_LINE11 = "嗯？我想我应该涉猎其他技能。",
	EXPERIENCE_LINE12 = "准备好了？看起来我天赋不错。",
	EXPERIENCE_LINE13 = "啊……我想是时候学习新东西了。",
	EXPERIENCE_LINE14 = "我进步如此神速是很自然的。",
	EXPERIENCE_LINE15 = "喔。 [Master]。我获得了新的天赋。",
	EXPERIENCE_LINE16 = "一天比一天好！",
	EXPERIENCE_LINE17 = "你看到了吗, [Master]? 我不是很棒吗？",
	EXPERIENCE_LINE18 = "哈！很快我就会比你更强, [Master]",
	EXPERIENCE_LINE19 = "是的……我很好，但我会变得更伟大！",
	EXPERIENCE_LINE20 = "看起来我已经准备好学习更多了!",
	EXPERIENCE_LINE21 = "喔-哦... [Master]。 我想我已经准备好学习新东西了...",
	EXPERIENCE_LINE22 = "我-我明白了……我想我现在可以学到更多...",
	EXPERIENCE_LINE23 = "[Master]. 我认为我的技能正在提高...",
	EXPERIENCE_LINE24 = "就是这样做的……我想我现在明白了...",
	EXPERIENCE_LINE25 = "对……也许我正在变强?",
	
	ITEM_CREATED_LINE1 = "终于完成了...",
	ITEM_CREATED_LINE2 = "我完成了, [Master].",
	ITEM_CREATED_LINE3 = "你要求做的那个东西, [Master]...",
	ITEM_CREATED_LINE4 = "给, [Master], 我已经尽力了。",
	ITEM_CREATED_LINE5 = "说真的, [Master]? 你能给我一个真正的挑战吗？",
	ITEM_CREATED_LINE6 = "是的是的…完成了。",
	ITEM_CREATED_LINE7 = "太简单了!",
	ITEM_CREATED_LINE8 = "我可以做一整天!",
	ITEM_CREATED_LINE9 = "又一个满分作品!",
	ITEM_CREATED_LINE10 = "完美…如常.",
	ITEM_CREATED_LINE11 = "完成了这个, [Master].",
	ITEM_CREATED_LINE12 = "马上……完成。",
	ITEM_CREATED_LINE13 = "啊，这么简单的设计。",
	ITEM_CREATED_LINE14 = "嗯？我想它已经准备好了。",
	ITEM_CREATED_LINE15 = "看, [Master]! 它完成了!",
	ITEM_CREATED_LINE16 = "太有趣了！结果很棒！",
	ITEM_CREATED_LINE17 = "给你。一切都完成了！",
	ITEM_CREATED_LINE18 = "这会让, [Master] 高兴的! ",
	ITEM_CREATED_LINE19 = "及时完成!",
	ITEM_CREATED_LINE20 = "我-我希望一切顺利...",
	ITEM_CREATED_LINE21 = "我-完成了, [Master]...",
	ITEM_CREATED_LINE22 = "哦…那真的很难制作。",
	ITEM_CREATED_LINE23 = "我-我是怎么做到的...?",
	ITEM_CREATED_LINE24 = "全部完成...",
	
	
	COMBAT_WIN_LINE1 = "哇，我们做到了, [Master]...",
	COMBAT_WIN_LINE2 = "哈，小菜一碟。下一个是谁?",
	COMBAT_WIN_LINE3 = "打得好。让我们继续前进, [Master]. ",
	COMBAT_WIN_LINE4 = "我很高兴我们赢了，但让我们保持谨慎。 ",
	COMBAT_WIN_LINE5 = "哈，我一点汗都没流。",
	COMBAT_WIN_LINE6 = "那真的很可怕。我希望没有更多...",
	COMBAT_WIN_LINE7 = "我…不敢相信我们赢了...",
	COMBAT_WIN_LINE8 = "不-不要回来...",
	COMBAT_WIN_LINE9 = "我希望我帮了...",
	COMBAT_WIN_LINE10 = "他-他们让我们这么做...",
	COMBAT_WIN_LINE11 = "我们受到了致命打击。",
	COMBAT_WIN_LINE12 = "这就是他们所能召集的吗?",
	COMBAT_WIN_LINE13 = "一场简单的斗争。几乎不值得付出汗水。",
	COMBAT_WIN_LINE14 = "让我们继续前进。",
	COMBAT_WIN_LINE15 = "一场几乎不值得一提的战斗。",
	COMBAT_WIN_LINE16 = "这就是你得到的！",
	COMBAT_WIN_LINE17 = "不应该挑战我！",
	COMBAT_WIN_LINE18 = "准备好了吗!?",
	COMBAT_WIN_LINE19 = "该死！我还想再打一场。",
	COMBAT_WIN_LINE20 = "可悲。为什么还要攻击？",
	COMBAT_WIN_LINE21 = "我希望他们没事...",
	COMBAT_WIN_LINE22 = "大家还好吗?",
	COMBAT_WIN_LINE23 = "我们为什么要战斗?",
	COMBAT_WIN_LINE24 = "不能谈判吗...?",
	COMBAT_WIN_LINE25 = "希望我们不用再打仗了...",
	
	SEX_START_LINE1 = "嗯…你真的想让我这么做吗？我不确定我是否准备好了...",
	SEX_START_LINE2 = "你想让我做猥亵的事, [Master]...",
	SEX_START_LINE3 = "我不太渴望这个，但如果你坚持的话。",
	SEX_START_LINE4 = "嗯，斜眼看着我的身体, [Master]?",
	SEX_START_LINE5 = "好吧，如果你想要我...",
	SEX_START_LINE6 = "我……喜欢和你在一起, [Master]...",
	SEX_START_LINE7 = "啊……真的吗？很好，但你最好不要温柔!",
	SEX_START_LINE8 = "我就知道你对我有欲望!",
	SEX_START_LINE9 = "别以为我很轻松。你知道，我也需要解脱。",
	SEX_START_LINE10 = "怎么了？我们开始吧！",
	SEX_START_LINE11 = "看起来我们都在想同样的事情！",
	SEX_START_LINE12 = "让我照顾你的每一个需求。",
	SEX_START_LINE13 = "我一直在等你。",
	SEX_START_LINE14 = "让我们俩一起玩吧。",
	SEX_START_LINE15 = "哦，天哪……我几乎无法控制自己！",
	SEX_START_LINE16 = "这些亲密时刻让一切变得更好。",
	SEX_START_LINE17 = "嗯？我想我们可以休息一下。",
	SEX_START_LINE18 = "啊……你在放纵自己，是吗？",
	SEX_START_LINE19 = "你选择了我，是吗？",
	SEX_START_LINE20 = "我一整天都在想这个...",
	SEX_START_LINE21 = "在你周围保持冷静……很难。",
	SEX_START_LINE22 = "我-我？我希望我能满足你的愿望...",
	SEX_START_LINE23 = "请-请花点时间陪我。我愿意做任何事情...",
	SEX_START_LINE24 = "喔-哦？你想让我满足你的…需求吗？",
	SEX_START_LINE25 = "我-我会尽我所能为您服务...",
	SEX_START_LINE26 = "我-我的身体是你的…请温柔...",

	SEX_FINISH_LINE1 = "...我-我不反对再做一次。",
	SEX_FINISH_LINE3 = "啊，在这之后工作感觉很浪费。",
	SEX_FINISH_LINE4 = "嗯，我的身体现在都出汗了……我能洗澡吗, [Master]?",
	SEX_FINISH_LINE5 = "我会痛一段时间，但这是值得的。",
	SEX_FINISH_LINE6 = "已经完成了！？我想整晚都去！",
	SEX_FINISH_LINE7 = "这正是我所需要的！",
	SEX_FINISH_LINE8 = "不要以为这意味着我喜欢你。",
	SEX_FINISH_LINE9 = "多么棒的锻炼!",
	SEX_FINISH_LINE10 = "太棒了。",
	SEX_FINISH_LINE11 = "我从来没有这么高兴过。",
	SEX_FINISH_LINE12 = "这对你有好处吗？",
	SEX_FINISH_LINE13 = "我们应该经常这样做。",
	SEX_FINISH_LINE14 = "我想和你在床上多呆一会儿。",
	SEX_FINISH_LINE15 = "如此原始的快乐...",
	SEX_FINISH_LINE16 = "嗯……也许这比我想象的要好。",
	SEX_FINISH_LINE17 = "我的……超棒的爱人？",
	SEX_FINISH_LINE18 = "也许我们应该改天再做一次...",
	SEX_FINISH_LINE19 = "那……至少可以说是令人愉快的...",
	SEX_FINISH_LINE20 = "我们能……改天再做一次吗?",
	SEX_FINISH_LINE21 = "我们能拥抱一下吗...?",
	SEX_FINISH_LINE22 = "感觉……真的很好。",
	SEX_FINISH_LINE23 = "哦-哦……结束了？",
	SEX_FINISH_LINE24 = "我-我希望我没事...",
	
	MASTER_PRAISE_LINE1 = "我得到了 [Master]... 的表扬……这让我很开心",
	MASTER_PRAISE_LINE2 = "我赢得了，不是吗, [Master]?",
	MASTER_PRAISE_LINE3 = "哦-哦！谢谢你, [Master]。 我很高兴我能让你高兴...",
	MASTER_PRAISE_LINE4 = "我…我做得很好…对吧, [Master]?",
	MASTER_PRAISE_LINE5 = "被-被 [Master]表扬... ",
	MASTER_PRAISE_LINE6 = "谢-谢谢。我已经尽力了, [Master].",
	MASTER_PRAISE_LINE7 = "没什么……真的...",
	MASTER_PRAISE_LINE8 = "应该轮到我被表扬了！!",
	MASTER_PRAISE_LINE9 = "是的，是的……我知道我很棒。",
	MASTER_PRAISE_LINE10 = "求你了。没什么, [Master].",
	MASTER_PRAISE_LINE11 = "接着夸我, [Master]!",
	MASTER_PRAISE_LINE12 = "谁是最好的？我是最好的！",
	MASTER_PRAISE_LINE13 = "偶尔被人注意到很好。",
	MASTER_PRAISE_LINE14 = "嗯？哦。不客气, [Master].",
	MASTER_PRAISE_LINE15 = "你想讨好我吗, [Master]?",
	MASTER_PRAISE_LINE16 = "啊……没什么。 ",
	MASTER_PRAISE_LINE17 = "甜言蜜语不会动摇我, [Master]... 但谢谢你。",
	MASTER_PRAISE_LINE18 = "很高兴能为您服务！",
	MASTER_PRAISE_LINE19 = "谢谢你, [Master]! 我不会让你失望的!",
	MASTER_PRAISE_LINE20 = "住手 , [Master]。你让我脸红了。",
	MASTER_PRAISE_LINE21 = "哇！我没想到你对我评价这么高！",
	MASTER_PRAISE_LINE22 = "我一定会坚持下去！只为你, [Master]。",
	
	
	MASTER_PUNISH_LINE1 = "对不起，我下次会更好, [Master]...",
	MASTER_PUNISH_LINE2= "啊……真的很疼, [Master].",
	MASTER_PUNISH_LINE3 = "我知道……命令第一。",
	MASTER_PUNISH_LINE4 = "嗯！只是让你知道，它一点也不疼！",
	MASTER_PUNISH_LINE5 = "不……好可怜的一只小猫！",
	MASTER_PUNISH_LINE6 = "很抱歉……我知道我可以做得更好, [Master]...",
	MASTER_PUNISH_LINE7 = "我不是故意让你难过的。对不起 [Master]。",
	MASTER_PUNISH_LINE8 = "[Master]? 这真的有必要吗?",
	MASTER_PUNISH_LINE9 = "如果这是为了让我变得更好……比我接受的更好, [Master]。",
	MASTER_PUNISH_LINE10 = "哦……你为什么要这样对我, [Master]?",
	MASTER_PUNISH_LINE11 = "就像我需要你告诉我搞砸了一样, [Master].",
	MASTER_PUNISH_LINE12 = "我为什么让这种情况发生?",
	MASTER_PUNISH_LINE13 = "我会记住这个...",
	MASTER_PUNISH_LINE14 = "感觉很好, [Master]。",
	MASTER_PUNISH_LINE15 = "真的吗？这就是你的全部吗, [Master]?",
	MASTER_PUNISH_LINE16 = "我-我做错什么了吗, [Master]?",
	MASTER_PUNISH_LINE17 = "都-都是我的错…不是吗？",
	MASTER_PUNISH_LINE18 = "我-我应该做得更好…对不起...",
	MASTER_PUNISH_LINE19 = "那-那种感觉……很好...",
	MASTER_PUNISH_LINE20 = "我不会再做了。我保证, [Master]...",
	MASTER_PUNISH_LINE21 = "我看你还没有超过原始的惩罚...",
	MASTER_PUNISH_LINE22 = "真的吗？为了什么, [Master]?",
	MASTER_PUNISH_LINE23 = "我想这是我失败的正确途径...",
	MASTER_PUNISH_LINE24 = "[Master]? 啊，我明白了……这将是一堂不会很快忘记的课...",
	MASTER_PUNISH_LINE25 = "我会感觉刺痛很长一段时间...",
	
	MASTER_ABUSE_LINE1 = "为什么... *哭泣*",
	MASTER_ABUSE_LINE2 = "这太可怕了……你太可怕了!",
	MASTER_ABUSE_LINE3 = "啊！求你了，别碰耳朵!",
	MASTER_ABUSE_LINE4 = "请…不再...",
	MASTER_ABUSE_LINE5 = "我做了什么值得这样做, [Master]? *哭泣*",
	MASTER_ABUSE_LINE6 = "不！停！真的很疼！",
	MASTER_ABUSE_LINE7 = "你为什么对我这么刻薄!?",
	MASTER_ABUSE_LINE8 = "我为什么还要取悦你!?",
	MASTER_ABUSE_LINE9 = "*哭泣* 没关系……我知道你还在乎, [Master]...",
	MASTER_ABUSE_LINE10 = "你-你为什么这么刻薄, [Master]...?",
	MASTER_ABUSE_LINE11 = "我-我应该……接受这个吗?",
	MASTER_ABUSE_LINE12 = "太-太疼了...",
	MASTER_ABUSE_LINE13 = "我-我想这就是我所擅长的...",
	MASTER_ABUSE_LINE14 = "请-请不要让任何人看到这个...",
	MASTER_ABUSE_LINE15 = "你怎么敢！？放开我！",
	MASTER_ABUSE_LINE16 = "总有一天我会让你还回来的！",
	MASTER_ABUSE_LINE17 = "该死！我的脸颊刺痛得厉害...",
	MASTER_ABUSE_LINE18 = "你很幸运，你不是这个位置上的那个人…",
	MASTER_ABUSE_LINE19 = "啊！别以为你打败了我..",
	MASTER_ABUSE_LINE20 = "小心……太多了, [Master]...",
	MASTER_ABUSE_LINE21 = "这简直失控了。",
	MASTER_ABUSE_LINE22 = "你怎么敢这样对我?" ,
	MASTER_ABUSE_LINE23 = "哦……我会几个星期内都忘不掉...",
	MASTER_ABUSE_LINE24 = "我早该知道你有脾气...",
	
	SEX_REWARD_LINE1 = "这样的奖励？没有……啊...",
	SEX_REWARD_LINE2 = "[Master]? *狼吞虎咽* 我真的没有要求这个...",
	SEX_REWARD_LINE3 = "猥亵的奖励？…嗯，好吧，我需要休息一下。",
	SEX_REWARD_LINE4 = "终于到了！是时候照顾我的需求了。",
	SEX_REWARD_LINE5 = "啊。我想我确实需要一点安慰。",
	SEX_REWARD_LINE6 = "这只是你对我为所欲为的借口吗？",
	SEX_REWARD_LINE7 = "很好……我想我现在确实需要这个。",
	SEX_REWARD_LINE8 = "我想我们都有心情吧?",
	SEX_REWARD_LINE9 = "啊。我非常需要。谢谢。",
	SEX_REWARD_LINE10 = "如果你能这么好的话。我一直觉得需要...",
	SEX_REWARD_LINE11 = "我想我最近很紧张...",
	SEX_REWARD_LINE12 = "哦，天哪……我很乐意享受这个。.",
	SEX_REWARD_LINE13 = "不要告诉其他人...",
	SEX_REWARD_LINE14 = "拜托？我真的需要这个...",
	SEX_REWARD_LINE15 = "非常感谢！我就知道我可以依靠你。",
	SEX_REWARD_LINE16 = "我只是在想你，很兴奋...",
	SEX_REWARD_LINE17 = "太好了，但你最好在…之后让我照顾你...",
	SEX_REWARD_LINE18 = "你是最棒的！我真的很想得到帮助...",
	SEX_REWARD_LINE19 = "我-我？真的吗？好的...",
	SEX_REWARD_LINE20 = "我-我不想让任何人注意到...",
	SEX_REWARD_LINE21 = "请-请不要告诉任何人...",
	SEX_REWARD_LINE22 = "Haaaa...我无法抗拒你...",
	SEX_REWARD_LINE23 = "哦-哦……我必须乞求吗?",
	
	LOYALTY_LINE1 = "我... 我能向 [Master] 效忠吗？为了你对我所做的一切...",
	LOYALTY_LINE2 = "我的身体和灵魂都属于你, [Master]。",
	LOYALTY_LINE3 = "[Master]...? 请-请让我陪在你身边... ",
	LOYALTY_LINE4 = "这是什么感觉……我想和 [Master]在一起? ",
	LOYALTY_LINE5 = "不要有任何有趣的想法。我只是喜欢这里的一切!",
	LOYALTY_LINE6 = "你还不错, [Master]!",
	LOYALTY_LINE7 = "哈！我想我需要你就像你需要我一样。",
	LOYALTY_LINE8 = "我想按照你的命令做也没那么糟糕!",
	LOYALTY_LINE9 = "你一定对我做了什么！我不可能这么喜欢你。",
	LOYALTY_LINE10 = "一位值得服务的 [Master] ，很好。",
	LOYALTY_LINE11 = "看来我已经喜欢上你了, [Master].",
	LOYALTY_LINE12 = "我就知道这一天会到来。我找不到任何理由离开。",
	LOYALTY_LINE13 = "我希望继续为您服务, [Master]。直到永远。",
	LOYALTY_LINE14 = "我的脑海里只想着为你服务。真是一种奇怪的感觉。",
	LOYALTY_LINE15 = "我就知道我会喜欢这里的, [Master]!",
	LOYALTY_LINE16 = "请不要让这成为一场梦。我真的很喜欢你, [Master]!",
	LOYALTY_LINE17 = "我可以和 [Master] 呆在一起，为他们服务！",
	LOYALTY_LINE18 = "很高兴能为您服务, [Master]!",
	LOYALTY_LINE19 = "不可能……会不会是我爱上了你, [Master]?",
	LOYALTY_LINE20 = "请永远不要让我离开……我真的很想留在这里, [Master]...",
	LOYALTY_LINE21 = "我-我想尽我所能为 [Master]服务...",
	LOYALTY_LINE22 = "哦-哦……我只是觉得在你身边很安全, [Master]...",
	LOYALTY_LINE23 = "嗯？为什么我觉得……不得不为 [Master]服务?",
	LOYALTY_LINE24 = "Ahh... 我只想说我在这里等你, [Master]",
	
	SUBMISSION_LINE1 = "我屈服了, [Master]。求你了，我愿意做任何事情...",
	SUBMISSION_LINE2 = "不-不，请不要再惩罚了... *哭泣*",
	SUBMISSION_LINE3 = "我放弃…你赢了... [Master]...",
	SUBMISSION_LINE4 = "该死……好……我服从你, [Master].",
	SUBMISSION_LINE5 = "好的！不再！我会很好的。",
	SUBMISSION_LINE6 = "我再也没有足够的力量反抗你了... [Master]",
	SUBMISSION_LINE7 = "所以这就是我现在的生活，是吗？",
	SUBMISSION_LINE8 = "你赢了。我再也打不过你了, [Master].",
	SUBMISSION_LINE9 = "如此粗俗的纪律。尽管我再也无法与之抗争了...",
	SUBMISSION_LINE10 = "如你所愿。我不会再质疑你的话了, [Master].",
	SUBMISSION_LINE11 = "我一点力量都没有了。我服从。",
	SUBMISSION_LINE12 = " [Master]你破坏了我的意志和身体。我屈服了。",
	SUBMISSION_LINE13 = "想想我曾经认为我会有一个更加光明的未来...",
	SUBMISSION_LINE14 = "尽管你待我不好……我会一如既往地为你服务, [Master]",
	SUBMISSION_LINE15 = "我只是想为您服务，但……不是这样的...",
	SUBMISSION_LINE16 = "在内心深处，我知道你是个好人, [Master]...",
	SUBMISSION_LINE17 = "我不能再忍受这种折磨了。我会做任何你想做的事, [Master]",
	SUBMISSION_LINE18 = "我会尽我所能……为你服务, [Master]...",
	SUBMISSION_LINE19 = "我-我想这就是像我这样的人所希望的。",
	SUBMISSION_LINE20 = "如果我更优秀就好了……也许不会是这样。",
	SUBMISSION_LINE21 = "也-也许这样更好？只是为了听从我 [Master]的命令...",
	SUBMISSION_LINE22 = "哦-哦…我想这总比什么都没有好...",
	SUBMISSION_LINE23 = "够-够了。这……令人欣慰吗？ ",
	
	LOYALTY_SUBMISSION_LINE1 = "[Master]... 我明白了，我会按照你的意愿去做的。",
	LOYALTY_SUBMISSION_LINE2 = "这感觉很疯狂，但我已经准备好为你做任何事情了。",
	LOYALTY_SUBMISSION_LINE3 = "...我-我明白，我会为你做一切。",
	LOYALTY_SUBMISSION_LINE4 = "我理解, [Master]... 我只是希望我能对你有用...",
	LOYALTY_SUBMISSION_LINE5 = "我-我会为你奉献一切, [Master]...",
	LOYALTY_SUBMISSION_LINE6 = "我-我愿意做任何你要求的事, [Master]... 真的!",
	LOYALTY_SUBMISSION_LINE7 = "我-我和 [Master] 的新生活从今天开始...",
	LOYALTY_SUBMISSION_LINE8 = "这就是我所希望的...",
	LOYALTY_SUBMISSION_LINE9 = "我只想为你做一切, [Master]!",
	LOYALTY_SUBMISSION_LINE10 = "[Master] 是最棒的！我从来都不想离开。",
	LOYALTY_SUBMISSION_LINE11 = "我真的只想成为你最好的, [Master]",
	LOYALTY_SUBMISSION_LINE12 = "除了在 [Master]身边，我在其他地方都看不到自己的方向。",
	LOYALTY_SUBMISSION_LINE13 = "如果其他人能看到你有多棒, [Master]。",
	LOYALTY_SUBMISSION_LINE14 = " [Master] ，我向你宣誓永远忠诚。",
	LOYALTY_SUBMISSION_LINE15 = "你不用问, [Master]。你的命令会完成的。",
	LOYALTY_SUBMISSION_LINE16 = "我知道我来这里做了正确的选择。",
	LOYALTY_SUBMISSION_LINE17 = "真正的 [Master] 知道何时使用魅力和铁拳。",
	LOYALTY_SUBMISSION_LINE18 = "就这样吗？你可以随时指望我来完成你的任务。",
	LOYALTY_SUBMISSION_LINE19 = "是的！你说什么我都做！",
	LOYALTY_SUBMISSION_LINE20 = "我就知道你会想把我留在 [Master] 身边!",
	LOYALTY_SUBMISSION_LINE21 = "交给我吧, [Master]! 我不会让你失望的。",
	LOYALTY_SUBMISSION_LINE22 = "令人惊讶的是……我同意你做我的 [Master].",
	LOYALTY_SUBMISSION_LINE23 = "啊！好吧！我愿意做你想做的任何事, [Master]。",
	
	WRIT_SUCCESS1 = "...你真是太好了，但请允许我陪在你身边。",
	WRIT_SUCCESS2 = "哇，你是认真的吗？但我不能丢下你不管，是吗？ ",
	WRIT_SUCCESS3 = "我很感激这个状态，但我的位置在你身边, [Master]. ",
	WRIT_SUCCESS4 = "我……我想我一个人活不下去了……请让我留下来, [Master]...",
	WRIT_SUCCESS5 = "我-我能留在这里吗？请...?",
	WRIT_SUCCESS6 = "真-真的吗？我？你确定吗？我只想和你在一起...",
	WRIT_SUCCESS7 = "除-除了在你身边，我在任何地方都看不到自己的方向, [Master]...",
	WRIT_SUCCESS8 = "请…让我留在这里陪你...",
	WRIT_SUCCESS9 = "如果我不能和你在一起，自由就没有意义, [Master].",
	WRIT_SUCCESS10 = "很高兴你能为我做这件事，但是……我想留下来。",
	WRIT_SUCCESS11 = "你真好，但我想留在这里。",
	WRIT_SUCCESS12 = "我喜欢这里, [Master]。我不想离开你身边。",
	WRIT_SUCCESS13 = "你的心在正确的位置，我也是。我会留在这里陪你。",
	WRIT_SUCCESS14 = "谢谢你, [Master], 但我和你在一起。",
	WRIT_SUCCESS15 = "自由？是什么让你认为我在这里不受欢迎？",
	WRIT_SUCCESS16 = "我明白了……永远不会少。我属于这里。",
	WRIT_SUCCESS17 = "命运让我们走到了一起，尽管你给了我自由。我的位置就在这里。",
	WRIT_SUCCESS18 = "我留在这里对我们双方都有利，不是吗？",
	WRIT_SUCCESS19 = "不行！我就呆在这里！",
	WRIT_SUCCESS20 = "释放我？不行。你需要我！",
	WRIT_SUCCESS21 = "什么！？解放我？什么奇奇怪怪的想法！？我不走！",
	WRIT_SUCCESS22 = "只是不认为我欠你什么，但我会和你在一起",
	WRIT_SUCCESS23 = "如果这是某种把戏…我会密切关注你...",
	
	WRIT_FAIL1 = "我……谢谢，但我必须走了。",
	WRIT_FAIL2 = "谢谢，我想……我现在必须走了。",
	WRIT_FAIL3 = "这是出乎意料的……我很感激你，但恐怕这不包括我的服务。",
	WRIT_FAIL4 = "...对不起。 ",
	WRIT_FAIL5 = "虽然我很感激你为我所做的一切……但我必须分道扬镳。",
	WRIT_FAIL6 = "谢谢。保重身体。",
	WRIT_FAIL7 = "我明白了。也许我们还会见面...",
	WRIT_FAIL8 = "我欠你一大笔债。我的服务无法偿还。",
	WRIT_FAIL9 = "我很高兴，但是……这不是我的归属。",
	WRIT_FAIL10 = "谢谢，但我还有更好的地方。",
	WRIT_FAIL11 = "你解放我了吗？我想你还不错。回头见。",
	WRIT_FAIL12 = "哦？一秒钟都别想我会留在这里陪你。",
	WRIT_FAIL13 = "是的，是的…谢谢，但我要走了。",
	WRIT_FAIL14 = "哈！我想我终于摆脱了这一切！",
	WRIT_FAIL15 = "谢-谢谢，但我的家人一定很担心。我得走了...",
	WRIT_FAIL16 = "我-我很抱歉……你表现得很好，但我得走了。",
	WRIT_FAIL17 = "别-别把它当回事……我只是不准备留在这里。",
	WRIT_FAIL18 = "哦…那么我可以走了？谢谢...",
	WRIT_FAIL19 = "哇…我想我终于可以离开了...",
	WRIT_FAIL20 = "非常感谢！总有一天我会还你的!",
	WRIT_FAIL21 = "这么善良的心，但我不能留下来。",
	WRIT_FAIL22 = "我太开心了！我会非常想念你的！",
	WRIT_FAIL23 = "太棒了！请理解我必须离开你的身边...",
	WRIT_FAIL24 = "啊！我太高兴了！我一定会偶尔给你写信的！",
	
	RECRUIT_SUCCESS5 = "如-如果你愿意的话...." ,
	RECRUIT_SUCCESS6 = "真-真的吗？我？你确定吗？好的...",
	RECRUIT_SUCCESS7 = "我不知道我能帮多少忙，但是……我会加入你的。",
	RECRUIT_SUCCESS8 = "也-也许…这是最好的？",
	RECRUIT_SUCCESS9 = "你想让我加入你吗？我很高兴！",
	RECRUIT_SUCCESS10 = "我只希望为您服务。",
	RECRUIT_SUCCESS11 = "看来现在该轮到我来帮你了, [Master]!",
	RECRUIT_SUCCESS12 = "我会尽快收拾行李。",
	RECRUIT_SUCCESS13 = "哦！看到我的新家我太兴奋了！",
	RECRUIT_SUCCESS14 = "我想这对我们双方都有利。",
	RECRUIT_SUCCESS15 = "我看不出有什么理由拒绝。",
	RECRUIT_SUCCESS16 = "让我们一起离开这个地方, [Master]。",
	RECRUIT_SUCCESS17 = "似乎命运让我们走到一起是有原因的。",
	RECRUIT_SUCCESS18 = "不妨联合起来。对我们双方都有利，不是吗？",
	RECRUIT_SUCCESS19 = "很好，但只是因为你看起来足够强壮。",
	RECRUIT_SUCCESS20 = "你看到我的潜力了吗？我们走吧。",
	RECRUIT_SUCCESS21 = "我希望你超出我的期望。",
	RECRUIT_SUCCESS22 = "只是不认为我欠你什么，但我会加入你的。",
	RECRUIT_SUCCESS23 = "哈！我就知道你需要像我这样的人！",
	
	RECRUIT_FAIL5 = "虽然我非常感谢你的邀请。我必须恭敬地拒绝……请保重自己。",
	RECRUIT_FAIL6 = "我认为我还没有准备好做出这样的承诺。",
	RECRUIT_FAIL7 = "对不起。我想我现在不能加入您。",
	RECRUIT_FAIL8 = "也许你应该在其他地方寻求帮助？",
	RECRUIT_FAIL9 = "很抱歉。我不能加入你的事业。",
	RECRUIT_FAIL10 = "什么？不可能！我为什么要加入你？",
	RECRUIT_FAIL11 = "我不可能一时兴起就加入某人。",
	RECRUIT_FAIL12 = "哦，拜托……就像我愿意为你离开我的家一样。",
	RECRUIT_FAIL13 = "别想了。我要走了。",
	RECRUIT_FAIL14 = "谢谢，但不用谢。我一个人很好。",
	RECRUIT_FAIL15 = "嗯……对不起……我不能。",
	RECRUIT_FAIL16 = "我-我真的不信任你……对不起...",
	RECRUIT_FAIL17 = "别-别把它当成私人的……我只是还没有准备好...",
	RECRUIT_FAIL18 = "你-你可以找到更好的人。我知道...",
	RECRUIT_FAIL19 = "请-请离开。我不想和你一起去...",
	RECRUIT_FAIL20 = "你看起来真的很好，但我就是做不到。对不起。",
	RECRUIT_FAIL21 = "我有太多事情要做。请理解。",
	RECRUIT_FAIL22 = "一个诱人的报价，但我就是做不到。",
	RECRUIT_FAIL23 = "我祝你旅途顺利，但我不能和你一起去。",
	RECRUIT_FAIL24 = "也许我们能再见面，但现在不行。",
	
	APHRODISIAC1 = "啊…怎么了……感觉很热...",
	APHRODISIAC2 = "我的身体…越来越热了...",
	APHRODISIAC3 = "AAhhh... 这是什么…感觉...",
	APHRODISIAC4 = "Hnnn... 你最好对此负责...",
	APHRODISIAC5 = "你怎么敢这样对我……但嘿。感觉不错。",
	APHRODISIAC6 = "啊。我的全身都在燃烧！",
	APHRODISIAC7 = "啊！我真的需要处理这个。",
	APHRODISIAC8 = "我无法控制自己。你对我做了什么？",
	APHRODISIAC9 = "啊……看起来我渴望一点解脱...",
	APHRODISIAC10 = "这么奇怪的混合物...",
	APHRODISIAC11 = "也许这种欲望的感觉并没有那么糟糕...",
	APHRODISIAC12 = "想让我心情好吗？这很有效。",
	APHRODISIAC13 = "我的脑海里充满了快乐的想法...",
	APHRODISIAC14 = "我-我的身体越来越暖和了。",
	APHRODISIAC15 = "哦-哦，不……我无法阻止自己...",
	APHRODISIAC16 = "感觉很好…请不要让它结束...",
	APHRODISIAC17 = "如-如此难以抵抗...",
	APHRODISIAC18 = "你-你为什么这样对我...?",
	APHRODISIAC19 = "是不是不太爽？我也是。",
	APHRODISIAC20 = "啊……你知道该怎么办。",
	APHRODISIAC21 = "我们玩得开心吗？",
	APHRODISIAC22 = "这意味着我可以取悦你吗？",
	APHRODISIAC23 = "我太激动了！",
	
	LOCKPICK_SUCCESS1 = "我做到了, [Master]。让我们看看里面是什么。",
	LOCKPICK_SUCCESS2 = "嗯，小菜一碟。",
	LOCKPICK_SUCCESS3 = "我-我做到了。",
	LOCKPICK_SUCCESS4 = "完成。",
	LOCKPICK_SUCCESS5 = "这个锁不适合我。",
	LOCKPICK_SUCCESS6 = "可以……吗？它打开了...",
	LOCKPICK_SUCCESS7 = "哦-哦！我真的做到了！",
	LOCKPICK_SUCCESS8 = "哇-哇……我想知道里面是什么？",
	LOCKPICK_SUCCESS9 = "啊！哦？我真的把它打开了？",
	LOCKPICK_SUCCESS10 = "我-我不敢相信我真的这么做了...",
	LOCKPICK_SUCCESS11 = "我做到了！现在我们可以得到里面的东西了。",
	LOCKPICK_SUCCESS12 = "我当然希望没有人错过这个...",
	LOCKPICK_SUCCESS13 = "我们可以用这个宝藏让每个人都开心！",
	LOCKPICK_SUCCESS14 = "看起来我有一位很棒的老师！",
	LOCKPICK_SUCCESS15 = "如果总是这么容易就好了。",
	LOCKPICK_SUCCESS16 = "对我这样的人来说是一件小事。",
	LOCKPICK_SUCCESS17 = "一个转弯，然后转弯，就到了。",
	LOCKPICK_SUCCESS18 = "嗯？这把锁就这难度吗？",
	LOCKPICK_SUCCESS19 = "我似乎在这方面做得更好了。",
	LOCKPICK_SUCCESS20 = "宝藏属于我们。",
	LOCKPICK_SUCCESS21 = "没有锁能打败我！",
	LOCKPICK_SUCCESS22 = "这个战利品最好值得。",
	LOCKPICK_SUCCESS23 = "啊。真的吗？太容易了！",
	LOCKPICK_SUCCESS24 = "我们本来会把它砸碎的，但我拿到了。",
	LOCKPICK_SUCCESS25 = "这就是为什么你需要像我这样的人！",
	
	LOCKPICK_FAILURE1 = "哦，呃……对不起。",
	LOCKPICK_FAILURE2 = "这-这不可能是我的错。",
	LOCKPICK_FAILURE3 = "对不起！",
	LOCKPICK_FAILURE4 = "...这没有帮助。",
	LOCKPICK_FAILURE5 = "这把愚蠢的锁……我下次会拿到的",
	LOCKPICK_FAILURE6 = "愚蠢的锁！我打不开！",
	LOCKPICK_FAILURE7 = "它破坏了我的工具!",
	LOCKPICK_FAILURE8 = "不管怎样！我打赌这个宝藏根本不值得。",
	LOCKPICK_FAILURE9 = "我失败了！？不可能！",
	LOCKPICK_FAILURE10 = "啊！这对我来说太难了！",
	LOCKPICK_FAILURE11 = "看起来我失败了。",
	LOCKPICK_FAILURE12 = "锁对我这样的人来说太复杂了。",
	LOCKPICK_FAILURE13 = "太遗憾了。我想看看里面是什么。",
	LOCKPICK_FAILURE14 = "也许这超出了我的能力范围？",
	LOCKPICK_FAILURE15 = "我无法打开它。",
	LOCKPICK_FAILURE16 = "对不起。这太难了。",
	LOCKPICK_FAILURE17 = "哦，不。我的工具坏了。",
	LOCKPICK_FAILURE18 = "该死。我还以为我也有...",
	LOCKPICK_FAILURE19 = "哇……我打赌这也是一件好事...",
	LOCKPICK_FAILURE20 = "我下次会拿到的!",
	LOCKPICK_FAILURE21 = "我-我知道我做不到...",
	LOCKPICK_FAILURE22 = "抱-抱歉，太难了...",
	LOCKPICK_FAILURE23 = "哦-哦，我想我还不够好...",
	LOCKPICK_FAILURE24 = "请-请原谅。我失败了...",
	LOCKPICK_FAILURE25 = "太-太多了……我无法处理。",
	
	GREETING_LINE_POSITIVE1 = "[Master] 想花时间 {^together:with me}...?",
	GREETING_LINE_POSITIVE2 = "很高兴能陪你, [Master].",
	GREETING_LINE_POSITIVE3 = "让我们一起玩得开心, [Master]!",
	
	GREETING_LINE_CAUTIOUS1 = "是的, [Master], 你想让我做什么？",
	GREETING_LINE_CAUTIOUS2 = "我今天还有工作，我们能尽快解决吗？",
	GREETING_LINE_CAUTIOUS3 = "你想要我做什么？ *抱怨*",
	GREETING_LINE_CAUTIOUS4 = "是-是的, [Master]。我能为你做什么？",
	
	PUNISH_LINE_LIGHT1 = "哎哟！很疼！",
	PUNISH_LINE_LIGHT2 = "那是干什么的!?",
	PUNISH_LINE_LIGHT3 = "啊！…你...",
	PUNISH_LINE_LIGHT4 = "不！停止...",
	
	PUNISH_LINE_HEAVY1 = "哎哟！请停止！",
	
	PUBLIC_LINE1 = "不-不可能，请不要在所有人面前这样做...",
	PUBLIC_LINE2 = "什么…为什么你把所有人都带到这里!?",
	PUBLIC_LINE3 = "这…会很丢脸。",
	PUBLIC_LINE4 = "你想这样吓唬我吗？看看我是否在乎。",
	PUBLIC_LINE5 = "求-求你了, [Master], 我不喜欢别人看着我。",
	PUBLIC_LINE6 = "为-为什么每个人都在这里？我没有...",
	PUBLIC_LINE7 = "不-不…不！请...",
	
	PUBLIC_OBSERVE_LINE1 = "[Master] 要惩罚你, [2name]...?",
	PUBLIC_OBSERVE_LINE2 = "嗯，你做得对。",
	PUBLIC_OBSERVE_LINE3 = "看起来 [2name] 受到了惩罚。至少你可以休息一下。",
	PUBLIC_OBSERVE_LINE4 = "请有尊严地接受。",
	PUBLIC_OBSERVE_LINE5 = "......",
	PUBLIC_OBSERVE_LINE6 = "如果 [he] 死了，我会优先考虑 [his] 东西。", 
	PUBLIC_OBSERVE_LINE7 = "看来你会上一堂好课, [2name]. ",
	
	MARRY_PROPOSE_AGREE1 = "你-你是认真的吗？……我简直不敢相信，我当然会的, [Master]!",
	MARRY_PROPOSE_AGREE2 = "哇……你不是在开玩笑吧？我同意！",
	MARRY_PROPOSE_AGREE3 = "是-是的，我当然同意！",
	
	MARRY_PROPOSAL_AGREED_BEFORE1 = "我不是已经同意了吗…？", 
	MARRY_PROPOSAL_AGREED_BEFORE2 = "是-是的，我们已经讨论过了，我同意...",
	
	MARRY_PROPOSE_REFUSE1 = "那-那……真的很突然……对不起，我不能同意。",
	MARRY_PROPOSE_REFUSE2 = "你-你什么？不可能。别那样开玩笑, [Master]",
	MARRY_PROPOSE_REFUSE3 = "对不起，我不能同意!",
	
	DATE_PROPOSE_AGREE1 = "我-我想和你更亲近一点, [Master]. ",
	DATE_PROPOSE_AGREE2 = "好吧，你的魅力这次对我起了作用。 ",
	DATE_PROPOSE_AGREE3 = "好吧，为什么不顽皮一点呢？",
	DATE_PROPOSE_AGREE4 = "这是为了我们的身体需求，对吗？",
	DATE_PROPOSE_AGREE5 = "呃-嗯，如果你不介意像我这样的人...",
	DATE_PROPOSE_AGREE6 = "很高兴你也有同样的感受。",
	
	DATE_PROPOSE_REFUSE1 = "对不起，我对你的感觉不一样。",
	DATE_PROPOSE_REFUSE2 = "求-求你了，也许其他时间...",
	DATE_PROPOSE_REFUSE3 = "我宁愿不要。",
	DATE_PROPOSE_REFUSE4 = "嗯，不。这很尴尬。",
	DATE_PROPOSE_REFUSE5 = "我确信有人比我更优秀。",
	
	DATE_PROPOSE_HAD_SEX1 = "别傻了，我们不是已经做了吗？",
	DATE_PROPOSE_HAD_SEX2 = "当然，如果你想让我正式确认...",
	DATE_PROPOSE_HAD_SEX3 = "...但我们不是已经这么做了吗?",
	
	DATE_PROPOSE_WAS_FORCED1 = "上次你真的没有给我太多选择，为什么现在出麻烦?",
	DATE_PROPOSE_WAS_FORCED2 = "你以前为什么不问我？现在有什么意义...",
	DATE_PROPOSE_WAS_FORCED3 = "想怎么做就怎么做。不过你已经做了。 ",
	DATE_PROPOSE_WAS_FORCED4 = "在就解决这个问题？好吧。 ",
	
	DATE_SEX_OFFER1 = "...[Master]? 我想继续这件事。",
	DATE_SEX_OFFER2 = "嗯, [Master], 我们可以做一些猥亵的事情……如果你不介意的话。",
	DATE_SEX_OFFER3 = "嘿，你现在不打算离开我吗?",
	DATE_SEX_OFFER4 = "嘿，你介意多陪我一会儿吗?",
	DATE_SEX_OFFER5 = "我的身体感觉……需要更多的关注。",
	DATE_SEX_OFFER6 = "嗯，我们能继续吗？我不想离开你。",
	
	DATE_AFFECTION1 = "这…感觉很好。",
	DATE_AFFECTION2 = "我可能会习惯的。",
	DATE_AFFECTION3 = "你这样宠我, [Master].",
	DATE_AFFECTION4 = "拜托，我不……值得... [Master].",
	DATE_AFFECTION5 = "你对我太好了。",
	DATE_AFFECTION6 = "我不介意你再表扬我一些。",
	DATE_AFFECTION7 = "非常感谢您的喜爱, [Master].",
	
	DATE_SCOLD1 = "对不起 [Master]. ",
	DATE_SCOLD2 = "你不必对我大喊大叫。",
	DATE_SCOLD3 = "对不起，请不要生气。 ",
	DATE_SCOLD4 = "住手，我不配得到这个！ ",
	DATE_SCOLD5 = "很抱歉你有这种感觉。",
	
	MIMIC_EAT1 = "哦，不！它还活着！",
	MIMIC_EAT2 = "不！抓住我了！救命！",
	MIMIC_EAT3 = "啊，我出不去了！",
	
	MIMIC_MOLEST1 = "啊……它搞得我我浑身都是！",
	MIMIC_MOLEST2 = "怎么了…啊！停！",
	MIMIC_MOLEST3 = "不-不，停！不！",
	
	MIMIC_LEAVE1 = "不-不，停下！你不能离开我！",
	MIMIC_LEAVE2 = "请停下！帮帮我！",
	MIMIC_LEAVE3 = "不! *哭泣* 求你了，我求你了...",
	MIMIC_LEAVE4 = "等等，我不想死！",
	
	MIMIC_EROTIC_LEAVE1 = "你-你要离开我吗？啊！…像这样？",
	MIMIC_EROTIC_LEAVE2 = "不，我讨厌它！请帮忙！",
	MIMIC_EROTIC_LEAVE3 = "不！这感觉太恶心了！",
	MIMIC_EROTIC_LEAVE4 = "啊，你为什么不帮我？！",
	
	MIMIC_EROTIC_LEAVE5 = "哦！我开始…像这样...",
	MIMIC_EROTIC_LEAVE6 = "啊…这…还不错...",
	
	PRAISE_REJECT1 = "你以为你能这样驯服我!?",
	PRAISE_REJECT2 = "请停止这场闹剧。",
	PRAISE_REJECT3 = "你一定是在开玩笑。 ",
	
	DATE_START1 = "很高兴能陪你, [Master]. ",
	DATE_START2 = "你想让我做什么, [Master]? ",
	DATE_START3 = "[Master], 这……让我有点紧张。 ",
	DATE_START4 = "我和 [Master] 一起... ",
	DATE_START5 = "那么，我们现在该怎么办, [Master]?",
	DATE_START6 = "只要我能休息一下...",
	DATE_START7 = "嗯……很抱歉我不是 [Master] 的好队友",
	DATE_START8 = "你叫我来了, [Master]?",
	DATE_START9 = "我会尽我所能陪你,",
	
	DATE_START_HAPPY1 = "终于，我还以为你永远不会问",
	DATE_START_HAPPY2 = "嘿，你过得怎么样, [Master]?",
	DATE_START_HAPPY3 = "呵呵，想让我告诉你我是怎么度过一天的吗？",
	DATE_START_HAPPY4 = "很高兴能和你在一起, [Master]. ",
	DATE_START_HAPPY5 = "希望别人不要嫉妒我们...",
	DATE_START_HAPPY6 = "谢-谢谢你选择我, [Master]!",
	DATE_START_HAPPY7 = "很高兴能和您在一起, [Master].",
	DATE_START_HAPPY8 = "很高兴能呆在你的小队, [Master].",
	DATE_START_HAPPY9 = "很荣幸被您选中, [Master].",
	DATE_START_HAPPY10 = "很高兴你召唤给我, [Master].",
	DATE_START_HAPPY11 = "呵-呵，现在只有你和我, [Master].",
	
	DATE_START_ANGRY1 = "别以为你现在能让我喜欢你！",
	DATE_START_ANGRY2 = "嗯，你认为你可以通过谈话摆脱你对我所做的一切吗？",
	DATE_START_ANGRY3 = "快一点，你这个混蛋。",
	DATE_START_ANGRY4 = "我不想这么做。",
	DATE_START_ANGRY5 = "请让我自己走。",
	DATE_START_ANGRY6 = "你是个可怕的人，我不想在这里。",
	DATE_START_ANGRY7 = "请，让我走！",
	DATE_START_ANGRY8 = "我会按照你的要求去做，让-让我走...",
	DATE_START_ANGRY9 = "你为什么不能让我成为朋... *哭泣*",
	DATE_START_ANGRY10 = "你的努力是徒劳的。",
	DATE_START_ANGRY11 = "这是什么？你想让我喜欢你吗..?",
	DATE_START_ANGRY12 = "做你想做的事，这不会改变任何事情。",
	
	TREAT_FOOD_RESIST1 = "你想用那样的东西收买我的性格？太可悲了。",
	TREAT_FOOD_LIKE1 = "哇，你怎么知道这是我的最爱？",
	TREAT_FOOD_HATE1 = "对不起，我受不了这个。",
	TREAT_FOOD_NEUTRAL1 = "谢谢你, [master], 我收下了。",
	LEAVE_CHAT1 = """This is a farewell, I suppose...""", # MISSING TRANSLATION
	
	#worlddata land
	
	AREAPLAINS = "Plains",
	AREAFORESTS = "Forests",
	AREAMOUNTAINS = "Mountains",
	AREASTEPPE = "草原",
	AREASEAS = "海洋",
	AREABEASTKIN_TRIBE = "遥远的森林",
	AREACAPITALS = "首都",
	AREASETTLEMENTS = "村庄",
	AREAQUESTS = "探索",
	AREADUNGEONS = "地下城",
	AREAENCOUNTERS = "遭遇",
	
	AREAPLAIN = "平原",
	AREAFOREST = "森林",
	AREAMOUNTAIN = "山",
	AREASEA = "海",
	AREACAPITAL = "首都",
	AREASETTLEMENT = "Village 村庄",
	AREAQUEST = "Quest 探索",
	AREADUNGEON = "Dungeon 地下城",
	AREAENCOUNTER = "Encounter 遭遇",
	
	
	#worlddata guild_upgrades
	
	SLAVENUMBERUPGRADE_NAME = "招聘人数",
	SLAVENUMBERUPGRADE_DISC = "将可供雇佣的角色数一次增加1。",
	
	SLAVEQUALITY_NAME = "招聘质量",
	SLAVEQUALITY_DISC = "提高可雇佣角色的质量。更强的角色可能有更高的初始技能、属性和更多的职业，但成本更高。",
	SLAVERACES_NAME = "招聘稀缺性",
	SLAVERACES_DISC = "增加可雇佣角色的种族稀有度。稀有种族可能具有更好的属性和被动效果。",
	
	WORKERS_DISASSAMBY_UPGRADE_NAME = "拆卸",
	WORKERS_DISASSAMBY_UPGRADE_DISC = "允许拆卸装备以取回一些材料。更高级别会增加回收材料的基本量。",
	
	#factiondata
	
	FIGHTERS = "战士行会",
	MAGES = "法师行会",
	WORKERS = "工人行会",
	SERVANTS = "仆人行会",
	SLAVEMARKET = "奴隶市场",
	BEASTKIN_SLAVE_TRADER = "兽化裔奴隶贩子",
	ELVISH_SLAVE_TRADER = "精灵奴隶贩子",
	EXOTIC_SLAVE_TRADER = "异国奴隶贩子",
	ALIRON_CHURCH = "阿利隆教堂",
	
	#locations
	
	SETTLEMENT_PLAINS1_ = "village_human_quest",
	SETTLEMENT_PLAINS2_ = "Settlement",
	SETTLEMENT_MOUNTAINS1 = "Settlement",
	
	#questdata
	
	FIGHTERS_TASK_EASY_NAME = "助手",
	FIGHTERS_TASK_EASY_DESC = "战士行会正在找人来代替生病的几个扈从。",
	FIGHTERS_TASK_EASY_RNDCND_NAME = "助手",
	FIGHTERS_TASK_EASY_RNDCND_DESC = "战士行会正在找人来代替生病的几个扈从。",
	
	FIGHTERS_TASK_MEDIUM_NAME = "城镇巡逻队",
	FIGHTERS_TASK_MEDIUM_DESC = "战士行会正在寻找一些备用战士来扮演警卫的角色。",
	FIGHTERS_TASK_MEDIUM_RNDCND_NAME = "城镇巡逻队",
	FIGHTERS_TASK_MEDIUM_RNDCND_DESC = "战士行会正在寻找一些备用战士来扮演警卫的角色。",
	
	FIGHTERS_TASK_HARD_NAME = "新兵培训",
	FIGHTERS_TASK_HARD_DESC = "战士行会正在寻找经验丰富的训练师来指导新兵。",
	FIGHTERS_TASK_HARD_RNDCND_NAME = "新兵培训",
	FIGHTERS_TASK_HARD_RNDCND_DESC = "战士行会正在寻找经验丰富的训练师来指导新兵。",
	
	MAGES_TASK_EASY_NAME = "图书馆协助",
	MAGES_TASK_EASY_DESC = "法师行会需要一些助手来整理大量的书籍档案。",
	MAGES_TASK_EASY_RNDCND_NAME = "图书馆协助",
	MAGES_TASK_EASY_RNDCND_DESC = "法师行会需要一些助手来整理大量的书籍档案。",
	
	MAGES_TASK_MEDIUM_NAME = "仪式助手",
	MAGES_TASK_MEDIUM_DESC = "法师行会正在寻找一位有能力的法师来协助魔法仪式。",
	MAGES_TASK_MEDIUM_RNDCND_NAME = "仪式助手",
	MAGES_TASK_MEDIUM_RNDCND_DESC = "法师行会正在寻找一位有能力的法师来协助魔法仪式。",
	
	MAGES_TASK_HARD_NAME = "诅咒移除",
	MAGES_TASK_HARD_DESC = "法师行会正在寻找能够在复杂的诅咒移除中提供魔法支持的强大法师。",
	MAGES_TASK_HARD_RNDCND_NAME = "诅咒移除",
	MAGES_TASK_HARD_RNDCND_DESC = "法师行会正在寻找能够在复杂的诅咒移除中提供魔法支持的强大法师。",
	
	WORKERS_TASK_EASY_NAME = "铁匠助手",
	WORKERS_TASK_EASY_DESC = "工人行会可以多用几只手来帮助镇上的工作。",
	WORKERS_TASK_EASY_RNDCND_NAME = "铁匠助手",
	WORKERS_TASK_EASY_RNDCND_DESC = "工人行会可以多用几只手来帮助镇上的工作。",
	
	WORKERS_TASK_MEDIUM_NAME = "悬赏：裁缝",
	WORKERS_TASK_MEDIUM_DESC = "工人行会寻找可以帮助处理最近订单的裁缝。",
	WORKERS_TASK_MEDIUM_RNDCND_NAME = " ",
	WORKERS_TASK_MEDIUM_RNDCND_DESC = "工人行会寻找可以帮助处理最近订单的裁缝。",
	
	WORKERS_TASK_HARD_NAME = "修复工程",
	WORKERS_TASK_HARD_DESC = "工人行会需要额外的帮助来修复大型建筑。",
	WORKERS_TASK_HARD_RNDCND_NAME = "修复工程",
	WORKERS_TASK_HARD_RNDCND_DESC = "工人行会需要额外的帮助来修复大型建筑。",
	
	SERVANTS_TASK_EASY_NAME = "一次性服务员",
	SERVANTS_TASK_EASY_DESC = "仆人行会正在找一个人在公共餐厅工作。",
	SERVANTS_TASK_EASY_RNDCND_NAME = "一次性服务员",
	SERVANTS_TASK_EASY_RNDCND_DESC = "仆人行会正在找一个人在公共餐厅工作。",
	
	SERVANTS_TASK_HARD_NAME = "上流聚会",
	SERVANTS_TASK_HARD_DESC = "仆人行会为大型庆典寻找表演艺术家。",
	SERVANTS_TASK_HARD_RNDCND_NAME = "上流聚会",
	SERVANTS_TASK_HARD_RNDCND_DESC = "仆人行会为大型庆典寻找表演艺术家。",
	
	WORKERS_RESOURCES_NAME = "资源收集",
	WORKERS_RESOURCES_DESC = "工人行会需要额外的资源来满足其需求。",
	
	WORKERS_FOOD_NAME = "食品供应",
	WORKERS_FOOD_DESC = "工人行会需要额外的食品供应。",
	
	WORKERS_CRAFT_TOOLS_NAME = "工具制作",
	WORKERS_CRAFT_TOOLS_DESC = "工人行会需要一些以特定方式制作的乐器。",
	
	WORKERS_THREAT_NAME = "解决问题",
	WORKERS_THREAT_DESC = "工人行会在某个问题上需要帮助。",
	
	FIGHTERS_THREAT_NAME = "解决问题",
	FIGHTERS_THREAT_DESC = "战士行会在某个问题上需要帮助。",
	
	FIGHTERS_DUNGEON_NAME = "清空地下城",
	FIGHTERS_DUNGEON_DESC = "战士行会要求清空一个地下城。",
	
	FIGHTERS_MONSTER_HUNT_NAME = "怪物狩猎",
	FIGHTERS_MONSTER_HUNT_DESC = "战士行会有一项狩猎一定数量敌人的任务。",
	
	FIGHTERS_CRAFT_GEAR_NAME = "装备供应",
	FIGHTERS_CRAFT_GEAR_DESC = "战士行会需要一定质量的装备。",
	
	MAGES_MATERIALS_NAME = "资源供应",
	MAGES_MATERIALS_DESC = "法师行会需要额外的资源来满足其需求。",
	
	MAGES_CRAFT_POTIONS_NAME = "药剂制作",
	MAGES_CRAFT_POTIONS_DESC = "法师行会需要补给他们的储藏室。",
	
	MAGES_THREAT_NAME = "解决问题",
	MAGES_THREAT_DESC = "法师行会在某个问题上需要帮助。",
	
	MAGES_CRAFT_GEAR_NAME = "法师装备供应",
	MAGES_CRAFT_GEAR_DESC = "战士行会需要一定质量的装备。",
	
	SERVANTS_CRAFT_NAME = "项目需求",
	SERVANTS_CRAFT_DESC = "仆人行会需要特定的手工制作物品",
	
	SERVANTS_SLAVE_NAME = "仆人需求",
	SERVANTS_SLAVE_DESC = "仆人行会需要经过专门训练的人。",
	FIGHTERS_SLAVE_DESC = """The Fighters Guild is in need of fresh slave recruits.""", # MISSING TRANSLATION
	WORKERS_SLAVE_DESC = """The Workers Guild is in need of fresh worker recruits.""", # MISSING TRANSLATION
	
	SERVANTS_SLAVE_WORK_NAME = "分派的任务",
	SERVANTS_SLAVE_WORK_DESC = "仆人行会需要有人为其执行任务。",
	
	FIGHTERS_SLAVE_WORK_NAME = "分派的任务",
	FIGHTERS_SLAVE_WORK_DESC = "战士行会需要有人为他们执行任务。",
	
	#locationnames
	VILLAGE_HUMAN1 = "绿色",
	VILLAGE_HUMAN2 = "黑色",
	VILLAGE_HUMAN3 = "金色",
	VILLAGE_HUMAN4 = "灰色",
	VILLAGE_HUMAN5 = "伟大",
	VILLAGE_HUMAN6 = "下雨",
	VILLAGE_HUMAN7 = "风暴",
	VILLAGE_HUMAN8 = "红色",
	VILLAGE_HUMAN9 = "河流",
	VILLAGE_HUMAN10 = "橡木",
	VILLAGE_HUMAN11 = "灰烬",
	
	VILLAGE_HUMAN2_1 = "木头",
	VILLAGE_HUMAN2_2 = "浅溪",
	VILLAGE_HUMAN2_3 = "山谷",
	VILLAGE_HUMAN2_4 = "市",
	VILLAGE_HUMAN2_5 = "风",
	VILLAGE_HUMAN2_6 = "山脊",
	VILLAGE_HUMAN2_7 = "大教堂",
	VILLAGE_HUMAN2_8 = "沼泽",
	VILLAGE_HUMAN2_9 = "草地",
	
	VILLAGE_HUMAN_QUEST1 = "米尔福德",
	
	BANDIT_FORT_NOUNS1 = "堡垒",
	BANDIT_FORT_NOUNS2 = "寨子",
	BANDIT_FORT_NOUNS3 = "要塞",
	BANDIT_FORT_NOUNS4 = "城堡",
	BANDIT_FORT_NOUNS5 = "前哨",
	BANDIT_FORT_NOUNS6 = "塔",
	
	BANDIT_FORT_ADJS1 = "强盗",
	BANDIT_FORT_ADJS2 = "逃犯",
	BANDIT_FORT_ADJS3 = "匪徒",
	BANDIT_FORT_ADJS4 = "盗贼",
	BANDIT_FORT_ADJS5 = "杀人犯",
	
	GOBLIN_CAVE_NOUNS1 = "洞穴",
	GOBLIN_CAVE_NOUNS2 = "隧道",
	GOBLIN_CAVE_NOUNS3 = "地洞",
	GOBLIN_CAVE_NOUNS4 = "大洞穴",
	GOBLIN_CAVE_NOUNS5 = "兽穴",
	
	GOBLIN_CAVE_ADJS1 = "肮脏",
	GOBLIN_CAVE_ADJS2 = "昏暗",
	GOBLIN_CAVE_ADJS3 = "遥远",
	GOBLIN_CAVE_ADJS4 = "红色",
	GOBLIN_CAVE_ADJS5 = "蓝色",
	GOBLIN_CAVE_ADJS6 = "黑色",
	GOBLIN_CAVE_ADJS7 = "低洼",
	
	BANDIT_DEN_NOUNS1 = "藏身处",
	BANDIT_DEN_NOUNS2 = "洞穴",
	BANDIT_DEN_NOUNS3 = "兽穴",
	BANDIT_DEN_NOUNS4 = "深坑",
	
	BANDIT_DEN_ADJS1 = "强盗",
	BANDIT_DEN_ADJS2 = "肮脏",
	BANDIT_DEN_ADJS3 = "昏暗",
	BANDIT_DEN_ADJS4 = "遥远",
	BANDIT_DEN_ADJS5 = "红色",
	BANDIT_DEN_ADJS6 = "蓝色",
	BANDIT_DEN_ADJS7 = "黑色",
	BANDIT_DEN_ADJS8 = "低洼",
	
	GROVE_NOUNS1 = "森林",
	GROVE_NOUNS2 = "树林",
	GROVE_NOUNS3 = "灌木丛",
	GROVE_NOUNS4 = "林地",
	GROVE_NOUNS5 = "荒野",
	GROVE_NOUNS6 = "避难所",
	GROVE_NOUNS7 = "林场",
	GROVE_NOUNS8 = "丛林",
	GROVE_NOUNS9 = "果园",
	GROVE_NOUNS10 = "小树林",
	GROVE_NOUNS11 = "树篱",
	
	GROVE_ADJS1 = "深色",
	GROVE_ADJS2 = "绿色",
	GROVE_ADJS3 = "白色",
	GROVE_ADJS4 = "金色",
	GROVE_ADJS5 = "银色",
	GROVE_ADJS6 = "密集",
	GROVE_ADJS7 = "厚重",
	GROVE_ADJS8 = "过度生长",
	GROVE_ADJS9 = "闪亮",
	GROVE_ADJS10 = "浓密",
	GROVE_ADJS11 = "茂盛",
	
	CRYPT_NOUNS1 = "地穴",
	CRYPT_NOUNS2 = "墓地",
	CRYPT_NOUNS3 = "坟墓",
	CRYPT_NOUNS4 = "地下墓穴",
	CRYPT_NOUNS5 = "陵墓",
	CRYPT_NOUNS6 = "冢",
	CRYPT_NOUNS7 = "坟地墓穴",
	CRYPT_NOUNS8 = "腔室",
	
	CRYPT_ADJS1 = "深色",
	CRYPT_ADJS2 = "黑色",
	CRYPT_ADJS3 = "血液",
	CRYPT_ADJS4 = "骨骼",
	CRYPT_ADJS5 = "腐烂",
	CRYPT_ADJS6 = "肉",
	CRYPT_ADJS7 = "邪恶",
	CRYPT_ADJS8 = "血液",
	CRYPT_ADJS9 = "红色",
	CRYPT_ADJS10 = "可怕",
	CRYPT_ADJS11 = "伟大",
	CRYPT_ADJS12 = "恶魔",
	CRYPT_ADJS13 = "幽暗",
	CRYPT_ADJS14 = "致命",
	
	MOUNTAINS_NOUNS1 = "洞穴",
	MOUNTAINS_NOUNS2 = "隧道",
	MOUNTAINS_NOUNS3 = "地洞",
	MOUNTAINS_NOUNS4 = "洞穴",
	MOUNTAINS_NOUNS5 = "矿山",
	MOUNTAINS_NOUNS6 = "采石场",
	MOUNTAINS_NOUNS7 = "会议厅",
	MOUNTAINS_NOUNS8 = "地下城",
	
	MOUNTAINS_ADJS1 = "深色",
	MOUNTAINS_ADJS2 = "黑色",
	MOUNTAINS_ADJS3 = "遥远",
	MOUNTAINS_ADJS4 = "红色",
	MOUNTAINS_ADJS5 = "蓝色",
	MOUNTAINS_ADJS6 = "低洼",
	MOUNTAINS_ADJS7 = "深",
	MOUNTAINS_ADJS8 = "重",
	MOUNTAINS_ADJS9 = "水晶",
	MOUNTAINS_ADJS10 = "摇摆",
	
	FIRE_DEPTHS_NOUNS1 = "洞穴",
	FIRE_DEPTHS_NOUNS2 = "地下城",
	FIRE_DEPTHS_NOUNS3 = "疤痕",
	FIRE_DEPTHS_NOUNS4 = "会议厅",
	FIRE_DEPTHS_NOUNS5 = "大厅",
	FIRE_DEPTHS_NOUNS6 = "巢穴",
	
	FIRE_DEPTHS_ADJS1 = "燃烧",
	FIRE_DEPTHS_ADJS2 = "着火",
	FIRE_DEPTHS_ADJS3 = "烧焦",
	FIRE_DEPTHS_ADJS4 = "加热",
	
	CITY_NOUNS1 = "废墟",
	CITY_NOUNS2 = "会议厅",
	CITY_NOUNS3 = "大厅",
	CITY_NOUNS4 = "住处",
	CITY_NOUNS5 = "迷宫",
	
	CITY_ADJS1 = "深色",
	CITY_ADJS2 = "遥远",
	CITY_ADJS3 = "红色",
	CITY_ADJS4 = "蓝色",
	CITY_ADJS5 = "黑色",
	CITY_ADJS6 = "低洼",
	CITY_ADJS7 = "深",
	CITY_ADJS8 = "重",
	CITY_ADJS9 = "水晶",
	CITY_ADJS10 = "摇摆",
	
	ANCIENT_JUNGLES_NOUNS1 = "灌木丛",
	ANCIENT_JUNGLES_NOUNS2 = "丛林",
	ANCIENT_JUNGLES_NOUNS3 = "雨林",
	ANCIENT_JUNGLES_NOUNS4 = "荒野",
	ANCIENT_JUNGLES_NOUNS5 = "野林",
	ANCIENT_JUNGLES_NOUNS6 = "树篱",
	ANCIENT_JUNGLES_NOUNS7 = "灌木丛林",
	ANCIENT_JUNGLES_NOUNS8 = "泥淖",
	ANCIENT_JUNGLES_NOUNS9 = "纠缠",
	
	ANCIENT_JUNGLES_ADJS1 = "绿色",
	ANCIENT_JUNGLES_ADJS2 = "深色",
	ANCIENT_JUNGLES_ADJS3 = "密集",
	ANCIENT_JUNGLES_ADJS4 = "厚",
	ANCIENT_JUNGLES_ADJS5 = "过度生长",
	ANCIENT_JUNGLES_ADJS6 = "浓密",
	ANCIENT_JUNGLES_ADJS7 = "茂盛",
	ANCIENT_JUNGLES_ADJS8 = "古代",
	ANCIENT_JUNGLES_ADJS9 = "旧",
	ANCIENT_JUNGLES_ADJS10 = "伟大",
	ANCIENT_JUNGLES_ADJS11 = "红色",
	ANCIENT_JUNGLES_ADJS12 = "幽暗",
	
	#dungeonnoun
	
	DUNGEONNOUN1 = "隧道",
	DUNGEONNOUN2 = "住处",
	DUNGEONNOUN3 = "洞穴",
	DUNGEONNOUN4 = "大厅",
	DUNGEONNOUN5 = "翻找",
	DUNGEONNOUN6 = "地洞",
	DUNGEONNOUN7 = "坟地墓穴",
	DUNGEONNOUN8 = "迷宫",
	DUNGEONNOUN9 = "会议厅",
	DUNGEONNOUN10 = "地穴",
	DUNGEONNOUN11 = "坟墓",
	DUNGEONNOUN12 = "地下墓穴",
	DUNGEONNOUN13 = "巢穴",
	DUNGEONNOUN14 = "地下城",
	DUNGEONNOUN15 = "洞穴",
	
	#dungeonadj
	
	DUNGEONADJ1 = "暗",
	DUNGEONADJ2 = "白色",
	DUNGEONADJ3 = "红色",
	DUNGEONADJ4 = "黑色",
	DUNGEONADJ5 = "熔融",
	DUNGEONADJ6 = "遥远",
	DUNGEONADJ7 = "永恒",
	DUNGEONADJ8 = "悲观",
	DUNGEONADJ9 = "低洼",
	DUNGEONADJ10 = "哭泣",
	DUNGEONADJ11 = "恶魔",
	DUNGEONADJ12 = "摇摆",
	DUNGEONADJ13 = "茂盛",
	DUNGEONADJ14 = "水晶",
	DUNGEONADJ15 = "致命",
	DUNGEONADJ16 = "咆哮",
	
	#dungeons
	
	QUEST_FIGHTERS_LICH_TEXT = "巫妖的藏身之处",
	QUEST_FIGHTERS_LICH_DESC = "按照邓肯的指示，你发现一个小藏身处，里面有不死生物的痕迹。",
	
	QUEST_MAGES_XARI_TEXT = "扎里1的位置",
	QUEST_MAGES_XARI_DESC = "",
	QUEST_REBEL_BACKROOMS = """Rebel Hideout's Backrooms""", # MISSING TRANSLATION
	QUEST_REBEL_BACKROOMSDESCR = """""", # MISSING TRANSLATION
	
	QUEST_MAGES_FRED_TEXT = "弗雷德的位置",
	QUEST_MAGES_FRED_DESC = "",
	
	BASIC_THREAT_WOLVES_TEXT = "威胁-野狼",
	BASIC_THREAT_WOLVES_DESC = "农民报告一群野狼袭击了他们的羊群。",
	
	BASIC_THREAT_REBELS_TEXT = "威胁-叛军",
	BASIC_THREAT_REBELS_DESC = "一群叛军恐吓当地村民。",
	
	BASIC_THREAT_GOBLINS_TEXT = "威胁-哥布林",
	BASIC_THREAT_GOBLINS_DESC = "一群野哥布林攻击路过的旅行者。",
	
	BASIC_THREAT_OGRE_TEXT = "威胁-食人魔",
	BASIC_THREAT_OGRE_DESC = "一个愤怒的食人魔袭击路过的旅行者。",
	
	BASIC_THREAT_TROLL_TEXT = "威胁-巨魔",
	BASIC_THREAT_TROLL_DESC = "一个愤怒的巨魔攻击路过的旅行者。",
	
	DUNGEON_BANDIT_DEN_TEXT = "土匪_窝",
	DUNGEON_BANDIT_DEN_DESC = "",
	
	DUNGEON_BANDIT_FORT_TEXT = "土匪_堡",
	DUNGEON_BANDIT_FORT_DESC = "",
	
	DUNGEON_UNDEAD_CRYPT_TEXT = "教堂地下室",
	DUNGEON_UNDEAD_CRYPT_DESC = "",
	
	DUNGEON_GOBLIN_CAVE_TEXT = "哥布林_洞穴",
	DUNGEON_GOBLIN_CAVE_DESC = "",
	
	DUNGEON_GROVE_TEXT = "树丛",
	DUNGEON_GROVE_DESC = "",
	
	DUNGEON_ANCIENT_JUNGLES_TEXT = "古老_丛林",
	DUNGEON_ANCIENT_JUNGLES_DESC = "",
	
	DUNGEON_FIRE_DEPTHS_TEXT = "火_心",
	DUNGEON_FIRE_DEPTHS_DESC = "",
	
	QUEST_CALI_BANDITS_LOCATION_TEXT = "土匪的藏身处",
	QUEST_CALI_BANDITS_LOCATION_DESC = "",
	
	QUEST_GOBLIN_LOCATION_TEXT = "被破坏的丛林",
	QUEST_GOBLIN_LOCATION_DESC = "",
	
	QUEST_CALI_VILLAGE_TEXT = "卡莉的家乡",
	QUEST_CALI_VILLAGE_DESC = ".",
	
	QUEST_MINES_DUNGEON_TEXT = "矿山",
	QUEST_MINES_DUNGEON_DESC = "",
	
	QUEST_FINAL_OPERATION_LOCATION_TEXT = "叛军的藏身处",
	QUEST_FINAL_OPERATION_LOCATION_DESC = "",
	
	QUEST_DAISY_ADMIRER_LOCATION_TEXT = "拉蒙特庄园",
	QUEST_DAISY_ADMIRER_LOCATION_DESC = "",
	
	QUEST_GRYPHON_FOREST_LOCATION_TEXT = "鹰头狮丛林",
	QUEST_GRYPHON_FOREST_LOCATION_DESC = "",
	
	QUEST_GRYPHON_CAVE_LOCATION_TEXT = "老鹰头狮巢穴",
	QUEST_GRYPHON_CAVE_LOCATION_DESC = "",
	
	QUEST_RITUAL_LOCATION_TEXT = "草药田",
	QUEST_RITUAL_LOCATION_DESC = "",
	
	QUEST_LEON_FOREST_TEXT = "莱昂的位置",
	QUEST_LEON_FOREST_DESC = "",
	
	QUEST_CALI_CAVE_LOCATION_TEXT = "小型奴隶洞穴",
	QUEST_CALI_CAVE_LOCATION_DESC = "",
	
	QUEST_LEON_FOREST_2_TEXT = "莱昂的位置",
	QUEST_LEON_FOREST_2_DESC = "",
	
	QUEST_WHITE_STAG_LOCATION_TEXT = "白牡鹿位置",
	QUEST_WHITE_STAG_LOCATION_DESC = "",
	
	QUEST_TEMPLE_LOCATION_TEXT = "寺庙",
	QUEST_TEMPLE_LOCATION_DESC = "",
	
	QUEST_ERLEN_LOCATION_TEXT = "埃伦位置",
	QUEST_ERLEN_LOCATION_DESC = "",
	
	QUEST_CALI_GOBLINS_LOCATION_TEXT = "受威胁的村庄",
	QUEST_CALI_GOBLINS_LOCATION_DESC = "",
	
	QUEST_TROLL_CAVE_LOCATION_TEXT = "巨魔洞穴",
	QUEST_TROLL_CAVE_LOCATION_DESC = "",
	
	QUEST_DUNGEON_GROVE_TEXT = "树林",
	QUEST_DUNGEON_GROVE_DESC = "",
	
	QUEST_AMELIA_BANDITS_LOCATION_TEXT = "不显眼的洞穴",
	QUEST_AMELIA_BANDITS_LOCATION_DESC = "",
	
	QUEST_ANCIENT_JUNGLE_LOCATION_TEXT = "古代遗迹",
	QUEST_ANCIENT_JUNGLE_LOCATION_DESC = "",
	
	#eventscrits
	
	BANDITS_THREAT_QUEST_TEXT1 = "你来到这个地方，发现了土匪的踪迹。",
	BANDITS_THREAT_QUEST_TEXT2 = "战斗",
	
	MEET_ADVENTURER_AT_DUNGEON_EVENT_TEXT1 = "你遇到了一个孤独的冒险家: [name].",
	MEET_ADVENTURER_AT_DUNGEON_EVENT_TEXT2 = "攻击",
	
	#fixed_location_options
	
	ALIRON1 = "检查街道",
	ALIRON2 = "寻找雷姆",
	ALIRON3 = "访问弗雷德的宿舍",
	ALIRON4 = "访问弗雷德的宿舍",
	ALIRON5 = "阿利隆教堂",
	ALIRON6 = "阿利隆教堂",
	ALIRON7 = "带领车队",
	ALIRON8 = "探访监狱",
	ALIRON9 = "在监狱里见公主",
	ALIRON10 = "在监狱里见公主",
	ALIRON11 = "见猎人老兵",
	ALIRON12 = "阿利隆教堂",
	ALIRON13 = "寻找收藏者",
	ALIRON14 = "威廉的豪宅",
	ALIRON15 = "威廉的豪宅",
	ALIRON16 = "商户摊位",
	ALIRON17 = "商户摊位",
	ALIRON18 = "宠物店",
	ALIRON19 = "检查街道",
	ALIRON20 = "搜索周围环境",
	ALIRON21 = "寻找西菲拉",
	ALIRON22 = "与凯奇会面",
	ALIRON23 = "检查阿米莉亚的信息",
	
	ELF_CAPITAL1 = "见女祭司",
	ELF_CAPITAL2 = "寻找走私者",
	ELF_CAPITAL3 = "寻找走私者",
	ELF_CAPITAL4 = "寻找走私者",
	ELF_CAPITAL5 = "见女祭司",
	ELF_CAPITAL6 = "拜访埃伦",
	ELF_CAPITAL7 = "见女祭司",
	ELF_CAPITAL8 = "见女祭司",
	ELF_CAPITAL9 = "搜索里拉",
	ELF_CAPITAL10 = "找到里拉",
	ELF_CAPITAL11 = "启动",
	
	BEASTKIN_CAPITAL1 = "找首领",
	BEASTKIN_CAPITAL2 = "参观萨满小屋",
	BEASTKIN_CAPITAL3 = "拜访萨夫拉",
	BEASTKIN_CAPITAL4 = "拜访萨夫拉",
	BEASTKIN_CAPITAL5 = "开始仪式",
	BEASTKIN_CAPITAL6 = "拜访莱昂",
	BEASTKIN_CAPITAL7 = "拜访莱昂",
	BEASTKIN_CAPITAL8 = "四处询问",
	BEASTKIN_CAPITAL9 = "拜访萨夫拉",
	BEASTKIN_CAPITAL10 = "拜访萨夫拉",
	BEASTKIN_CAPITAL11 = "拜访萨夫拉",
	BEASTKIN_CAPITAL12 = "拜访萨夫拉",
	BEASTKIN_CAPITAL13 = "检查周围环境",
	BEASTKIN_CAPITAL14 = "与萨夫拉交谈",
	
	SETTLEMENT_PLAINS1_1 = "战斗",
	SETTLEMENT_PLAINS1_2 = "见邓肯",
	
	SETTLEMENT_PLAINS2_1 = "农民",
	SETTLEMENT_PLAINS2_2 = "农民",
	
	SETTLEMENT_FOREST1_1 = "检查周围环境",
	SETTLEMENT_FOREST1_2 = "检查周围环境",
	
	QUEST_FIGHTERS_LICH1 = "继续",
	
	QUEST_MAGES_XARI1 = "搜索扎里",
	QUEST_MAGES_XARI2 = "见扎里",
	QUEST_MAGES_XARI3 = "输入",
	QUEST_MAGES_XARI4 = "找扎里",
	QUEST_MAGES_XARI5 = "找扎里",
	
	QUEST_MAGES_FRED1 = "搜索弗雷德",
	
	BASIC_THREAT_WOLVES1 = "继续",
	
	BASIC_THREAT_REBELS1 = "继续",
	
	BASIC_THREAT_GOBLINS1 = "继续",
	
	BASIC_THREAT_OGRE1 = "继续",
	
	BASIC_THREAT_TROLL1 = "继续",
	
	QUEST_CALI_CAVE_LOCATION1 = "搜索洞穴",
	
	QUEST_CALI_GOBLINS_LOCATION1 = "搜索周围环境",
	
	QUEST_CALI_VILLAGE1 = "跟随卡莉",
	
	QUEST_FINAL_OPERATION_LOCATION1 = "搜索",
	QUEST_FINAL_OPERATION_LOCATION2 = "搜索",
	
	QUEST_DAISY_ADMIRER_LOCATION1 = "接近",
	
	QUEST_GRYPHON_CAVE_LOCATION1 = "接近洞穴",
	QUEST_MAE_SEARCH = """Search For Mae""", # MISSING TRANSLATION
	
	QUEST_LEON_FOREST_2_1 = "搜索莱昂",
	
	QUEST_WHITE_STAG_LOCATION1 = "搜索莱昂",
	
	QUEST_TEMPLE_LOCATION1 = "接近",
	QUEST_TEMPLE_LOCATION2 = "接近",
	
	QUEST_ERLEN_LOCATION1 = "四处搜索",
	QUEST_ERLEN_LOCATION2 = "见埃伦",
	QUEST_ERLEN_LOCATION3 = "见埃伦",
	
	QUEST_TROLL_CAVE_LOCATION1 = "找巨魔",
	QUEST_GOBLIN_LOCATION1 = "四处搜索",
	QUEST_GOBLIN_LOCATION2 = "追踪痕迹",
	QUEST_GOBLIN_LOCATION3 = "追踪哥布林的痕迹",
	QUEST_GOBLIN_LOCATION4 = "返回报告",
	
	# Missing keys
	CURRENT_PREFERRED_FOOD_CONSUMPTION = "Current Preferred Food Consumption",
	TOOLTIP_CLOCK1 = """Advance Time
Hotkey: 1""",
	TOOLTIP_CLOCK2 = """Advance Time for 12h
Hotkey: 2""",
	TOOLTIP_CLOCK3 = """Advance Time for a full day
Hotkey: 3""",
	TIME_TOOLTIP = """Current Week, Day and time. Some quests may have time limits.""",
	USAGE_COST = "使用成本",
	TOOLTIP_NONE = "无",
	MAX_CHARGES = "储存次数",
	TOOLTIP_COOLDOWN = "冷却",
	TOOLTIP_MANACOST = "魔力消耗",
	TOOLTIP_DAY_S = "天。",
	SKILL_SWITCH_TOOLTIP = "社交/战斗技能",
	SLAVE_LOYALTY = "Loyalty 忠诚",
	RACE_BONUSES = "种族奖励",
	SOCIAL_SKILLS = "社交技能",
	COMBAT_SKILLS = "战斗技能",
	PERSONAL_STAT = "Personal Statistics",
	REMOVE_BUTTON = """Set Free""", # MISSING TRANSLATION
	TALK_BUTTON = """Talk To""", # MISSING TRANSLATION
	BODY_UPGRADE_TOOLTIP = """""", # MISSING TRANSLATION
	
	# SlaveClassesModule
	CAT_ALL = "All",
	CAT_SOCIAL = "社交",
	CAT_LABOR = "劳动",
	CAT_SEXUAL = "性爱",
	CAT_COMBAT = "战斗",
	CAT_MAGIC = "魔法",
	
	CAT_ALL_DESC = "全部",
	CAT_SOCIAL_DESC = "社交",
	CAT_LABOR_DESC = "劳动",
	CAT_SEXUAL_DESC = "性爱",
	CAT_COMBAT_DESC = "战斗",
	CAT_MAGIC_DESC = "魔法",
	
	SKILLS_CAT_ALL_DESC = "All",
	SKILLS_CAT_COMBAT_DESC = "Combat",
	SKILLS_CAT_SPELLS_DESC = "Spells",
	SKILLS_CAT_SUPPORT_DESC = "Support",
	SKILLS_CAT_AOE_DESC = "Area Of Effect",
	SKILLS_CAT_HEAL_DESC = "Heal",
	
	UNLOCK_REQS = "Unlock Requirements",
	CLASSES_LABEL = "职业",
	SKILLS_LABEL = "技能",
	SKILL_POINTS_LABEL = "技能点",
	REQUIREMENTS_TOOLTIP = "Requirements",
	LOCKED_LABEL = "锁定",
	CUR_LEVEL_LABEL = "Current level",
	MAX_WORKERS_LABEL = "Max Workers",
	CURRENT_WORKERS_LABEL = "Current Workers",
	GATHERING_MOD_LABEL = "Gathering Mod",
	
	DESCRIPT_BUTTON_TEXT = "Add Custom Description",
	NICKNAME_BUTTON_TEXT = "Set Nickname",
	MNOUN_BUTTON_TEXT = "Set Master Noun",
	ICON_BUTTON_TEXT = "Select Custom Portrait",
	ICON2_BUTTON_TEXT = "Make random portrait",
	BODY_BUTTON_TEXT = "Select Custom Body",
	USPRITE_BUTTON_TEXT = "Select Unique Sprite",
	DETAILS_LABEL = "Details",
	DESCRIPT2_BUTTON_TEXT = "Add Custom Description (start with # to hide)",
	DESCRIPT_LABEL = "description",
	CUSTOM_NICK_LABEL = "Add Custom Nickname",
	CUSTOM_MNOUN_LABEL = "Add Custom Masternoun",
	PORT_FOLD_LABEL = "Portrait folder: ",
	BODY_FOLD_LABEL = "Body folder: ",
	CUSTOM_IMG_LABEL = "Add custom image",
	OPEN_SYS_FOLD_LABEL = "Open system folder",
	RELOAD_PORT_LABEL = "Reload portraits",
	RESET_IMG_LABEL = "Reset the image",
	REVERS_TO_DEF_LABEL = "Reverse to default",
	SELECT_FOLDRS_LABEL = "Select Folders",
	ASSIGN_BOTH_LABEL = "Assign Both",
	RACE_LOC_LABEL = "Race Locked",
	OWNED_LABEL = "Owned",
	TYPE_LABEL = "类型",
	SLOTS_LABEL = "插槽",
	TYPE_USABLE_LABEL = "Type: Usable",
	NAME_LABEL = "Name",
	SLAVERS_LIST = "List of Slaves",
	EXP_LABEL = "exp",
	SHOW_INFO_LABEL = "显示信息",
	UPGRADE_LABEL = "升级",
	BODY_ALTER_LABEL = """Body Modifications""", # MISSING TRANSLATION
	UPGRADES_LABEL = "Upgrades",
	REQUESTER_LABEL = "Requester: ",
	NO_QUESTS_LABEL = "There are no quests available",
	PRICE_LABEL = "Price",
	QUEST_SETTINGS = "Quest settings: ",
	FACTION_POINTS = "FactionPoints",
	UNSPENT_POINTS = "UnspentPoints",
	MARKETPLACE_LABEL = "市场",
	COST_LABEL = "价格",
	NUMBER_LABEL = "数量",
	ITEM_LABEL = "项目",
	TRADER_LABEL = "商店",
	LOCATIONS_LABEL = "位置",
	INFORMATION_LABEL = "Information",
	POSSIBLE_RES_LABEL = "可能存在的资源",
	LOCATION_NAME_LABEL = "Location Name",
	DIFFIC_LABEL = "Diff",
	WEEK_LABEL = "周数",
	DAY_LABEL = "天数",
	CLASS_LABEL = "Class",
	SKILL_BAR_LABEL = "技能栏",
	STARTING_LOC_LABEL = "Starting location",
	TRAVEL_LOC_LABEL = "Travel location",
	FORGET_LABEL = "遗忘",
	AVAIL_RES_LABEL = "可用资源",
	CHARS_SELECTED_LABEL = "Characters selected",
	TARGET_LOC_LABEL = "Target location",
	TRAVEL_TIME_LABEL = "Travel time",
	EST_TRAVEL_TIME_LABEL = "Estimated travel time",
	LOC_UNACCEPT_LABEL = "Location unaccessible",
	LOC_BEEN_REMOVED_LABEL = "Location has been removed",
	ARRIVED_AT_LOC_LABEL = "arrived at location",
	RETURNED_TO_MANSION_LABEL = "returned to mansion",
	TRAVEL_LABEL = "旅行",
	RETURN_ALL_MANSION_LABEL = "全部返回豪宅",
	TRAVELERS_LABEL = "旅行者",
	BATTLE_GROUP_LABEL = "战斗小队",
	ITEMS_LABEL = "项目",
	SPELLS_LABEL = "魔法",
	QUICK_SELL_LABEL = "快速销售",
	CAPTURED_CHARACTERS_LABEL = "捕获的角色",
	CYCLES_LABEL = "cycles",
	FORGET_LOC_LABEL = "遗忘地点",
	SKIP_TO_LAST_ROOM_LABEL = "跳至最后一个房间",
	ADVANCE_LABEL = "前进",
	LOC_COMPLETE = "位置完成",
	CANT_PAY_COSTS_LABEL = "无法支付成本",
	NO_CHARGES_LEFT_LABEL = "无剩余使用次数",
	CANT_USE_TODAY_LABEL = "今天不能再使用此技能了",
	REQS_NOT_MET_LABEL = "未满足要求",
	TARGET_REQS_NOT_MET_LABEL = "未满足目标要求",
	SPECTASKCOMPLETED = "已完成的特殊任务",
	FARM_LABEL = "Farm",
	SELECT_RES_FIRST_LABEL = "Select Resource",
	SELECT_SLOT_FIRST_LABEL = "Select Farm Slot",
	FARMAVAILABLEPRDODUCTS = "Avaliable Products",
	FARMAVAILABLEPRDODUCTSNO = "No Products Available for this character",
	LACKS_BASIC_SERV_LABEL = "lacks Training: Basic Servitude",
	REFUSE_TO_WHORE_LABEL = "refuses to perfrorm sexual tasks",
	REFUSE_THIS_TASK_LABEL = "refuses to perfrorm this task",
	LACKS_PROSTITUTUION_LABEL = "lacks Training: Prostitution",
	SPEND_REP_QUESTION_LABEL = "Are you sure you want to spend",
	REP_POINTS_LABEL = "reputation points for",
	DISLIKED_ACTIONS_LABEL = "Disliked actions",
	NOSERVITUDE = """-Servitude""", # MISSING TRANSLATION
	COMBAT_ABILS_LABEL = "Combat Abilitites",
	DATING_LIVING_ROOM = "Living Room",
	DATING_BEDROOM = "Bedroom",
	DATING_TORTURE_ROOM = "Torture Room",
	DATING_GARDEN = "Garden",
	DATING_STREETS = "Streets",
	DATING_JAIL_TEST = "You visit [name2] in [his2] cell and decide to spend some time with [him2]. ",
	DATING_LIVING_ROOM_TEXT_1 = "You meet {^[name2]:[race2] [boy2]} and order [him2] to keep you company. ",
	DATING_LIVING_ROOM_TEXT_2 = "[he2] gladly accepts your order and is ready to follow you anywhere you take [him2]. ",
	DATING_LIVING_ROOM_TEXT_3 = "[he2] obediently agrees to your order and tries [his2] best to please you. ",
	DATING_LIVING_ROOM_TEXT_4 = "Without great joy [he2] obeys your order and reluctantly joins you. ",
	DATING_DISLIKE_SAME_SEX = "\n{color=yellow|Sexuality: [name] does not seem to be enthusiastic in having relationship with you. Mood required for positive response is increased.}",
	DATING_MOVE_TO_TEXT = "You lead {^[name2]:[race2] [boy2]} to the [color=yellow]",
	DATING_LOC_INFLUENCE_1 = "\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather peaceful, [his2] mood improves.",
	DATING_LOC_INFLUENCE_2 = "\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather joyful, [his2] mood improves",
	DATING_LOC_INFLUENCE_3 = "\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather grim, [his2] fear grows.",
	DATING_NO_TIME = "\n\nYou have no more time left.",
	DATING_CHAT_START_1 = "你试图与 {^[name2]:[race2] [boy2]}进行友好的聊天。 ",
	DATING_CHAT_START_2 = "你与 {^[name2]:[race2] [boy2]} {^天真地:随意地:友好地} {^讨论世俗的事情:聊天} 。 ",
	DATING_CHAT_START_3 = "你和 {^[name2]:[race2] [boy2]}进行了一次闲聊。 ",
	DATING_CHAT_START_4 = "你和 [name2] 讨论天气。 ",
	DATING_CHAT_POSITIVE_1 = "{^[name2]:[race2] [boy2]:[he2]} 花一些时间与你进行友好聊天。",
	DATING_CHAT_POSITIVE_2 = "{^[name2]:[race2] [boy2]:[he2]} 以友好的方式回应你。 ",
	DATING_CHAT_NEGATIVE_1 = "{^[name2]:[race2] [boy2]:[he2]} 回复，但很不情愿。",
	DATING_CHAT_NEGATIVE_2 = "{^[name2]:[race2] [boy2]:[he2]} 对进一步聊天没有兴趣。 ",
	DATING_FLIRT_START_1 = "你随意地与 {^[name2]:[race2] [boy2]}调情。",
	DATING_FLIRT_START_2 = "你开始与 {^[name2]:[race2] [boy2]}进行猥亵谈话。",
	DATING_FLIRT_START_3 = "你问 {^[name2]:[race2] [boy2]} 关于 [his2] 幻想的问题。",
	DATING_FLIRT_POSITIVE_1 = "{^[name2]:[race2] [boy2]:[he2]} 积极回应您。 ",
	DATING_FLIRT_POSITIVE_2 = "{^[name2]:[race2] [boy2]:[he2]} 给你一种俏皮的感觉。 ",
	DATING_FLIRT_POSITIVE_3 = "{^[name2]:[race2] [boy2]:[he2]} 稍微靠近你。 ",
	DATING_FLIRT_NEGATIVE_1 = "{^[name2]:[race2] [boy2]:[he2]} 保持沉默，表现出 [his2] 不屑。",
	DATING_FLIRT_NEGATIVE_2 = "{^[name2]:[race2] [boy2]:[he2]} 给你一个严厉的眼神。 ",
	DATING_FLIRT_NEGATIVE_3 = "{^[name2]:[race2] [boy2]:[he2]} 离开你。 ",
	DATING_TOUCH_START_1 = "你 {^随便地:轻轻地} 触摸 {^[name2]:[race2] [boy2]}。",
	DATING_TOUCH_POSITIVE_1 = "{^[name2]:[race2] [boy2]:[he2]} 对你的感情做出放松的反应。 ",
	DATING_TOUCH_NEGATIVE_1 = "{^[name2]:[race2] [boy2]:[he2]} 看起来很无聊，反应很冷淡。",
	DATING_COMBHAIR_START_1 = "你 {^轻轻地:慢慢地} 梳理 {^[name2]:[race2] [boy2]}的 {^[hairlength]:}{^[haircolor]:}头发。",
	DATING_COMBHAIR_POSITIVE_1 = "{^[name2]:[race2] [boy2]} 对你的感情做出放松的反应。 ",
	DATING_COMBHAIR_NEGATIVE_1 = "{^[name2]:[race2] [boy2]} 看起来很无聊，反应很冷淡。",
	DATING_HUG_START_SAMESIZE_1 = "你给了 {^[name2]:[race2] [boy2]} 一个友好的拥抱。",
	DATING_HUG_START_SAMESIZE_2 = "你以友好的方式拥抱 {^[name2]:[race2] [boy2]} 。",
	DATING_HUG_START_SAMESIZE_3 = "你把 {^[name2]:[race2] [boy2]} 抱在怀里。",
	DATING_HUG_START_BIGSIZE_1 = "你 {^搂抱:拥抱} {^[name2]:[race2] [boy2]}的小身体。",
	DATING_HUG_START_BIGSIZE_2 = "你俯身拥抱 {^搂抱:拥抱} {^[name2]:[race2] [boy2]}。",
	DATING_HUG_START_SMALLSIZE_1 = "你让 {^[name2]:[race2] [boy2]} 俯身拥抱 [him2] 。",
	DATING_HUG_POSITIVE_SAMESIZE_1 = "{^[name2]:[race2] [boy2]} {^搂抱:拥抱} 你的背 {^将:把} [his2] 头靠在你的肩膀上。",
	DATING_HUG_POSITIVE_SAMESIZE_2 = "{^[name2]:[race2] [boy2]} 接受你的 {^搂抱:拥抱} 并热情微笑。",
	DATING_HUG_POSITIVE_BIGSIZE_1 = "{^[name2]:[race2] [boy2]} {^搂抱:拥抱} 你的背 {^将:把} [his2] 头放在你的胸前。",
	DATING_HUG_POSITIVE_BIGSIZE_2 = "{^[name2]:[race2] [boy2]} 对你的身材感到 {^不知所措:目瞪口呆} 然后抱住你的背 ",
	DATING_HUG_POSITIVE_SMALLSIZE_1 = "{^[name2]:[race2] [boy2]} 被你的行动打动，于是 {^搂抱:拥抱} 你的背。",
	DATING_HUG_POSITIVE_SMALLSIZE_2 = "由于你的体型 {^[name2]:[race2] [boy2]} 尴尬地向你抱了回来。",
	DATING_HUG_NEGATIVE_1 = "{^[name2]:[race2] [boy2]} 不做任何不舒服的事情等待你完成。",
	DATING_KISS_START_1 = "你 {^慢慢地 :}{^靠:倾斜:贴} 到 {^[name2]:[race2] [boy2]}的脸上。",
	DATING_KISS_POSITIVE_1 = "{^[name2]:[race2] [boy2]} {^温柔地:轻柔地} 回吻你。",
	DATING_KISS_POSITIVE_2 = "{^[name2]:[race2] [boy2]} 在{^ 闭上眼睛时:} 时回吻。",
	DATING_KISS_EROTIC_1 = "{^[name2]:[race2] [boy2]} {^热切地:热情地:淫荡地} 把 [his2] 舌头塞进嘴里。你们花了一些时间 {^拥抱:搂抱} {^在一起:对方}。最后 [name2] 带着 {^高兴:满意} 微笑离开了。",
	DATING_KISS_EROTIC_PUBLIC_1 = "{^[name2]:[race2] [boy2]} {^热切地:热情地:淫荡地} 把 [his2] 舌头塞进嘴里。你们花了一些时间 {^拥抱:搂抱} {^在一起:对方}，忽略 {^无礼的:目不转睛的} {^人群:观众}。最后 [name2] 带着 {^高兴:满意} 微笑离开了。",
	DATING_KISS_NEGATIVE_1 = "[he2] 不舒服地 {^转身:看着} 接受你在面颊上的 {^亲吻:接吻} 。",
	DATING_KISS_NEGATIVE_2 = "[he2] {^尴尬地:笨拙地} 移开，阻止了你的尝试。",
	DATING_MARRY_INITIATE_1 = "你在 [name2] 面前鞠躬并向 [him2]求婚。",
	DATING_MARRY_SAME_SEX_1 = "{^[name2]:[race2] [boy2]} 立即指出，在当前习俗中，不可能与同性结婚。",
	DATING_AGREED_TO_MARRY_PREV_1 = "{^[name2]:[race2] [boy2]} 看着你有点困惑。 [He2] 之前已经同意了。",
	DATING_AGREED_TO_MARRY_1 = "听到你的话 {^[name2]:[race2] [boy2]}的脸涨红了，闪闪发光。",
	DATING_REFUSED_TO_MARRY_1 = "{^[name2]:[race2] [boy2]:[he2]} 匆忙打断了你。",
	DATING_PROPOSE_INITIATE_1 = "你问 {^[name2]:[race2] [boy2]}  [he2] 是否愿意将你的关系提升到一个新的水平。",
	DATING_PROPOSE_HAD_SEX_BEFORE_1 = "{^[name2]:[race2] [boy2]:[he2]} 困惑地看着你，因为以前已经发生过性关系，很快就同意了。",
	DATING_PROPOSE_WAS_FORCED_BEFORE_1 = "{^[name2]:[race2] [boy2]:[he2]} 看着你，带着 {^轻蔑:蔑视}, 的表情，因为你以前已经 {^强制:强迫} [him2] 和 [his2] 的意愿发生性关系。叹息之后 [he2] 给了你 [his2] 口头同意。 ",
	DATING_PROPOSE_ALREADY_REACHED_CONSENT_1 = "{^[name2]:[race2] [boy2]:[he2]} 不假思索地做出响应，就像 [his2] 脑袋早已思考过这件事。",
	DATING_PROPOSE_ALREADY_REACHED_CONSENT_2 = "{^[name2]:[race2] [boy2]:[he2]} 很快同意了你的提议。看来 [he2] 已经对此下定决心了。",
	DATING_PROPOSE_REJECT_1 = "{^[name2]:[race2] [boy2]:[he2]} {^ 一脸苦恼:} 的 {^拒绝:回绝} 你的求婚。",
	DATING_PROPOSE_ACCEPT_1 = "{^[name2]:[race2] [boy2]:[he2]} 很高兴地 {^同意:接受} 你的 {^请求:提议}。",
	DATING_PROPOSE_ACCEPT_2 = "过了一会 {^[name2]:[race2] [boy2]:[he2]} {^同意:接受} 你的 {^请求:提议}。",
	DATING_PRAISE_INITIATE_1 = "您赞扬了 {^[name2]:[race2] [boy2]:[he2]}的努力",
	DATING_PRAISE_INITIATE_2 = "你 {^宣告:表达} 你对 {^[name2]:[race2] [boy2]:[he2]}的感谢。",
	DATING_PRAISE_INITIATE_3 = "你赞扬了 {^[name2]:[race2] [boy2]:[he2]} [his2] 最近的行为。",
	DATING_PRAISE_ACCEPT_1 = "{^[name2]:[race2] [boy2]:[he2]} 听着你的赞美，脸上流露出喜悦。",
	DATING_PRAISE_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} 没有表现出任何接受你赞扬的迹象。",
	DATING_PATHEAD_INITIATE_1 = "你 {^随意地:轻轻地} {^拍打:抚摸} {^[name2]:[race2] [boy2]}的头。",
	DATING_PATHEAD_ACCEPT_1 = "{^[name2]:[race2] [boy2]:[he2]} 对你微笑。",
	DATING_PATHEAD_ACCEPT_2 = "{^[name2]:[race2] [boy2]:[he2]} 尴尬地 {^害羞:视而不见} 。",
	DATING_PATHEAD_ACCEPT_3 = "{^[name2]:[race2] [boy2]:[he2]} 带着明显的喜悦接受了它。",
	DATING_PATHEAD_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} 给你一个不赞成的 {^glance:眼神}。",
	DATING_PATHEAD_RESIST_2 = "{^[name2]:[race2] [boy2]:[he2]} 似乎被你的手势冒犯了。",
	DATING_SCOLD_INITIATE_1 = "你因为 [his2] 最近的错误而斥责{^[name2]:[race2] [boy2]}。",
	DATING_SCOLD_ACCEPT_1 = "{^点头:向下看} 中的 {^[name2]:[race2] [boy2]:[he2]}  {^同意:接受}了。",
	DATING_SCOLD_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} 给你一个恼火的眼神。",
	DATING_RUBEARS_INITIATE_1 = "你 {^深情地:温柔地} {^划:擦:拍} {^[name2]:[race2] [boy2]} 的 [earadj] 耳朵后面。",
	DATING_RUBEARS_INITIATE_2 = "你 {^深情地:温柔地} {^划:擦:拍} {^[name2]:[race2] [boy2]} 的 [earadj]耳朵，向下移动到 [his2] {^[haircolor]:[hairlength]} 头发。",
	DATING_RUBEARS_ACCEPT_1 = "{^[name2]:[race2] [boy2]:[he2]} 似乎 {^对此感到高兴:享受它}, 并且 [his2] [earadj]耳朵 {^高兴地:调皮地} 抽搐。",
	DATING_RUBEARS_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} {^看起来:似乎} 对此 {^恼火:不高兴} 并且{^.: 并等待它结束。}",
	DATING_STROKETAIL_INITIATE_1 = "你 {^温柔地:深情地} {^抚摸:把手伸到}到 {^[name2]:[race2] [boy2]}的 [tailadj]尾巴上。",
	DATING_STROKETAIL_ACCEPT_1 = "{^[name2]:[race2] [boy2]:[he2]} 似乎 {^对此感到高兴:很享受}, 并且 [his2] [tailadj]尾巴 {^高兴地:调皮地} 摇摆。",
	DATING_STROKETAIL_ACCEPT_2 = "{^[name2]:[race2] [boy2]:[he2]} {^痉挛:抽搐} {^了一小会儿:了一段时间}, 但随后接受了你的 {^抚摸:爱抚:抚摸}。",
	DATING_STROKETAIL_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} {^看起来:似乎}对此 {^烦躁不安:生气} 并且{^.: 并等待你结束。}",
	DATING_PULLEARS_INITIATE_1 = "你用力地 {^猛拉:拉长} {^[name2]:[race2] [boy2]}的 [earadj]耳朵，导致 [him2] {^呲牙咧嘴:发出恳求的哭声}。",
	DATING_PULLEARS_ACCEPT_1 = "尽管疼痛难忍, {^[name2]:[race2] [boy2]:[he2]} 还是坚忍地忍受着你的虐待。",
	DATING_PULLEARS_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} 看起来 {^疯狂:愤怒} 并试图挣脱。",
	DATING_PULLEARS_RESIST_2 = "{^[name2]:[race2] [boy2]:[he2]} {^哀嚎:哭泣} 以示抗议{^:, 乞求宽恕}。",
	DATING_PULLTAIL_INITIATE_1 = "你用力 {^猛拉:拉长} {^[name2]:[race2] [boy2]}{^'s: by [his2]} [tailadj]尾巴，使 [him2] {^畏缩:发出恳求的哭声}。",
	DATING_PULLTAIL_ACCEPT_1 = "尽管疼痛难忍, {^[name2]:[race2] [boy2]:[he2]} 还是坚忍地忍受着你的虐待。",
	DATING_PULLTAIL_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} 看起来 {^疯狂:生气} 并试图挣脱。",
	DATING_PULLTAIL_RESIST_2 = "{^[name2]:[race2] [boy2]:[he2]} {^哀嚎:哭泣} 以示抗议 {^:, 乞求宽恕}。",
	DATING_SLAP_INITIATE_1 = "你拍打 {^[name2]:[race2] [boy2]} 的脸{: 在[his2]脸颊上留下印记}。",
	DATING_SLAP_ACCEPT_1 = "尽管疼痛难忍, {^[name2]:[race2] [boy2]:[he2]} 还是坚忍地忍受着你的虐待。",
	DATING_SLAP_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} 看起来 {^疯狂:非常生气}。",
	DATING_FOOD_INITIATE_1 = "您向 {^[name2]:[race2] [boy2]:[he2]} 提供一份 [food]。",
	DATING_FOOD_RESIST_1 = "{^[name2]:[race2] [boy2]:[he2]} 拒绝您的要求，表明 [his2] 还在抵抗。",
	DATING_FOOD_LIKED_1 = "{^[name2]:[race2] [boy2]:[he2]} 热情地接受并感谢您。",
	DATING_FOOD_HATED_1 = "{^[name2]:[race2] [boy2]:[he2]} 给你一个轻蔑的眼神。",
	DATING_FOOD_NEUTRAL_1 = "{^[name2]:[race2] [boy2]:[he2]} 尊重地接受了它，但没有表现出太多的喜悦。",
	DATING_INTIM_BED_1 = "'你在床上 {^谨慎地:专心地} 询问 [name2] 关于 [his2] 喜好。'",
	DATING_INTIM_BED_2 = "\n\n{color=green|[name2] 向您敞开心扉，您可以了解一些有关 [his2] 偏好。 ",
	DATING_INTIM_BED_3 = "\n您已经了解到 [name2] 的性特征: ",
	DATING_INTIM_BED_4 = "\n\n{color=green|[name2] 向您敞开心扉，但您没有了解到任何关于 [him2]的新特性。 ",
	DATING_INTIM_BED_5 = "{color=red|你没能让 [name2] 有心情谈论 [his2] 性偏好。}",
	DATING_INTIM_BED_6 = """{color=aqua|[name]'s consent level has increased to: """, # MISSING TRANSLATION
	DATING_HOLDHANDS_1 = " 当你四处闲逛时，你把[name2]的手拉起。 ",
	DATING_HOLDHANDS_2 = "你把 [name2]的手放进你的手，然后靠近。 ",
	DATING_HOLDHANDS_3 = "[he2] 紧握你的手。 ",
	DATING_HOLDHANDS_4 = "[he2] 握着你的手，但看起来很孤僻。 ",
	DATING_KISS_1 = " {^[name2]:[race2] [boy2]:[he2]} 脸红了，目光移开。 ",
	DATING_KISS_2 = " {^[name2]:[race2] [boy2]:[he2]} 看着你傻笑。 ",
	DATING_KISS_3 = "{^[name2]:[race2] [boy2]:[he2]} 微笑着用卧室的眼神看着你。",
	DATING_KISS_4 = "{^[name2]:[race2] [boy2]:[he2]} 看起来有点尴尬，意识到 [he2] 刚刚做了什么，然后移开了视线。",
	DATING_KISS_5 = "{^[name2]:[race2] [boy2]:[he2]} 满意地咯咯笑着{^:, grabbing your arm}. ",
	DATING_PUNISH_1 = "[Masochist][name2] 似乎以不同寻常的热情接受 [his2] 惩罚... ",
	DATING_PUNISH_2 = "[/color] 敬畏地看着 [name2]的羞辱。 ",
	DATING_SLAP_1 = "你在 [name2] 脸上打了一巴掌作为惩罚。 [his2] 脸颊变红了。",
	DATING_FLAG_1 = "你把 [name2] 放在惩罚台上，暴露 [his2] 的屁股后，用武力惩罚它。 ",
	DATING_WHIP_1 = "你把 [name2] 放在惩罚台上，露出 [his2] 的屁股后，用力鞭打它。",
	DATING_HORSE_1 = "你把 [name2] 牢牢地绑在木马上， [his2] 的腿张开。 [he2] 在自己的重量下痛苦地哭泣。 ",
	DATING_WAX_1 = "你把 [name2] 放在惩罚台上，暴露 [his2] 身体后，你把热蜡滴在上面，让 [him2] 痛苦地哭泣。 ",
	DATING_TRAIN_1 = "您花了一些时间与 [name2], 一起训练，提高了物理水平。 \n",
	DATING_STUDY_1 = "你花了一些时间和 [name2], 一起学习，提高了你的智慧。 \n",
	DATING_CHARM_1 = "你花了一些时间和 [name2], 一起学习，提高了你的魅力。 \n",
	DATING_PUBLIC_1 = "你把所有人都带进刑讯室，让他们观看 [name2]的耻辱。 ",
	DATING_PUBLIC_2 = "[/color] 过来观察 [name2]的处罚。\n",
	DATING_PUBLIC_3 = "\n\n你想让所有人都来观看 [name2]的羞辱，但除了你，没有人在附近。",
	DATING_PUBLIC_4 = "你命令每个人都回到他们的工作中，让你和 [name2] 独处。 ",
	DATING_ALCO_1 = "你向 [name2] 赠送了一瓶威士忌。 ",
	DATING_ALCO_2 = "但是, [he2] 拒绝在你的小队喝酒。 ",
	DATING_ALCO_3 = "[he2] 接受了你的邀请，和你一起喝酒。随着 [his2] 情绪的好转，你注意到 [he2] 喝醉了，和你在一起感觉很自在。 ",
	DATING_BEER_1 = "你向 [name2] 赠送了一份啤酒。 ",
	DATING_BEER_2 = "但是, [he2] 拒绝在你的小队喝酒。 ",
	DATING_BEER_3 = "[he2] 接受了你的邀请，和你一起喝酒。随着 [his2] 情绪的好转，你注意到 [he2] 喝醉了，和你在一起感觉很自在。 ",
	DATING_ALCO_OVERDOSE_1 = "\n\n[color=yellow][name2] 因饮酒过量而昏倒。 [/color]",
	DATING_ENOCOUNTER_ENDED_1 = "交流结束。",
	DATING_MOOD_1 = "\n气氛: ",
	DATING_FEAR_1 = "\n恐惧: ",
	DATING_POSITIVE_MODE_1 = "\n\n{color=green|积极的气氛}: ",
	DATING_LOYALTY_1 = "\n忠诚: +",
	DATING_CHARMF_BONUS_1 = " ([Master]的魅力因素加成: +",
	DATING_CONSENT_1 = "\n同意: +",
	DATING_SEXF_BONUS_1 = " ([Master]的性因素加成: ",
	DATING_AUTHORITY_BONUS_1 = "\n权威: +",
	DATING_AUTHORITY_BONUS_2 = "\n\n对在一起的时间感到满意，你和 [name] 更亲密了。",
	DATING_FEARFUL_1 = "\n\n{color=red|恐惧的气氛}: ",
	DATING_OBEDIENCE_1 = "\n服从: +",
	DATING_AUTHORITY_1 = "\n权威: +",
	DATING_PHYSF_BONUS_1 = " ([Master]的物理因素加成: +",
	DATING_PHYSF_BONUS_2 = "\n\n虽然对 [name]来说是一次令人不快的经历，但它肯定会教会 [him] 害怕你的愤怒。",
	DATING_SEX_OFFER_1 = "\n\n{color=green|似乎 [name] 似乎不介意继续这场遭遇...}",
	DATING_CHAT_DESC_1 = "Have a friendly chat. Will boost Mood slightly.",
	DATING_CHAT_1 = "聊天",
	DATING_FLIRT_DESC_1 = "Flirt with [name]. Will slightly improve Consent if Mood is high. Slightly increases Consent if mood is above low.",
	DATING_FLIRT_1 = "调情",
	DATING_INTIMATE_DESC_1 = "Have an intimate talk in attempt to learn more about [name]'s preferences. Can only be used once.",
	DATING_INTIMATE_1 = "亲密交谈",
	DATING_TOUCH_DESC_1 = "Light physical contact",
	DATING_TOUCH_1 = "触碰",
	DATING_HOLDHANDS_DESC_5 = "Take [name]'s hand into yours",
	DATING_HOLDHANDS_5 = "握住双手",
	DATING_PRAISE_DESC_1 = "Praise [name] for [his] previous success to encourage further good behavior. Can only be used once.",
	DATING_PRAISE_1 = "赞美",
	DATING_PATHEAD_DESC_1 = "Praise [name] and pat [his] head for [his] previous success to encourage further good behavior",
	DATING_PATHEAD_1 = "拍头",
	DATING_COMBHAIR_DESC_1 = "Comb [name]'s hair",
	DATING_COMBHAIR_1 = "梳头发",
	DATING_HUG_DESC_1 = "Prolonged close physical contact",
	DATING_HUG_1 = "拥抱",
	DATING_KISS_DESC_6 = "Attempt to kiss [name]. Can only be used once.",
	DATING_KISS_6 = "亲吻",
	DATING_RUBEARS_DESC_1 = "Gently rub [name]'s long ears",
	DATING_RUBEARS_1 = "抚摸耳朵",
	DATING_STROKETAIL_DESC_1 = "Gently stroke [name]'s tail",
	DATING_STROKETAIL_1 = "抚摸尾巴",
	DATING_ASK_TO_MARRY_DESC_1 = "Make a proposal for [name], to officially marry [him].",
	DATING_ASK_TO_MARRY_1 = "求婚",
	DATING_PROPOSE_DESC_1 = "Ask [name] if [he] would consent to become more intimate with you. Boosts Consent greatly when successful. ",
	DATING_PROPOSE_1 = "更进一步",
	DATING_SCOLD_DESC_1 = "Scold [name] for [his] previous mistakes to re-enforce obedience",
	DATING_SCOLD = "训斥",
	DATING_SLAP_DESC_1 = "Slap [name] across the face to reprimand [him].",
	DATING_SLAP = "打脸",
	DATING_PULLEAR_DESC_1 = "Forcefully pull [name] by ear as a mean of discipline. ",
	DATING_PULLEAR = "拉耳朵",
	DATING_PULLTAIL_DESC_1 = "Forcefully yank [name]'s tail to teach [him] [his] place.",
	DATING_PULLTAIL = "拉尾巴",
	DATING_FLAG_DESC_1 = "Spank [name] as punishment",
	DATING_FLAG = "打屁股",
	DATING_WHIP_DESC_1 = "Whip [name] as punishment",
	DATING_WHIP = "鞭打",
	DATING_WAX_DESC_1 = "Torture with hot wax",
	DATING_WAX = "热蜡",
	DATING_HORSE_DESC_1 = "Torture with a wooden horse",
	DATING_HORSE = "木马",
	DATING_PUBLIC_DESC_1 = "Invite other slaves to observe [name]'s punishments. It will slightly improve your autority among them and increase punishment effect. Use again to make them leave. Does not cost Time.  ",
	DATING_PUBLIC = "公开惩罚",
	DATING_GIFT_DESC_1 = "Make a small decorative gift for [name]. \n[color=yellow]Requires 10 gold.[/color]",
	DATING_GIFT = "制作礼物",
	DATING_SWEETS_DESC_1 = "Purchase flowers from street vendor for [name]\n[color=yellow]Requires 5 gold.[/color]",
	DATING_SWEETS = "买花",
	DATING_TEA_DESC_1 = "Serve tea for you and [name]. [color=yellow]Requires 1 supply.[/color]",
	DATING_TEA = "喝茶",
	DATING_WINE_DESC_1 = "Serve wine for you and [name] (Alcohol eases intimacy request but may cause a knockout). [color=yellow]Requires 2 supplies.[/color]",
	DATING_WINE = "饮酒",
	DATING_TRAIN_DESC_1 = "Do a paired training. Improves Physics for both based on Physics Factor and Time left. Ends encounter.",
	DATING_TRAIN = "物理训练",
	DATING_STUDY_DESC_1 = "Do a paired study. Improves Wits for both based on Wits Factor and Time left. Ends encounter.",
	DATING_STUDY = "学习",
	DATING_PRACTICE_CHARM_DESC_1 = "Practice Charm with [name]. Improves Charm for both based on Charm Factor and Time left. Ends encounter.",
	DATING_PRACTICE_CHARM = "魅力训练",
	DATING_USE_ITEM_DESC_1 = "Select an item from list to use with [name].",
	DATING_USE_ITEM = "使用项目",
	DATING_FOOD_DESC_1 = "Treat [name] with food.",
	DATING_FOOD = "用食物治疗",
	DATING_STOP_DESC_1 = "Stop interaction and let [name] return to work.",
	DATING_STOP = "停止",
	ALTAR_ITEM_1 = """[name] puts an offer on the altar. """, # MISSING TRANSLATION
	ALTAR_ITEM_GOOD = """

{color=green|The offering disappears in a thin air and after a moment a new item materialize in place. It seems your offer was correct and you are rewarded.}""", # MISSING TRANSLATION
	ALTAR_ITEM_BAD = """

The offering lays on the altar with no apparent reaction from it. It seems your offer wasn't liked.""", # MISSING TRANSLATION
	ALTAR_CHAR_1 = """[name] puts [his] hand on the altar. """, # MISSING TRANSLATION
	ALTAR_CHAR_GOOD = """

{color=green|A small glow emits from the altar and enshrouds [name]. It seems [he] has been blessed...}""", # MISSING TRANSLATION
	ALTAR_CHAR_BAD = """

After a few minutes nothing still happened and [name] decides to move on.""", # MISSING TRANSLATION
	ALTAR_DESTROY_1 = """[name] demolishes the shrine and gathers the resources. """, # MISSING TRANSLATION
	ALTAR_DESTROY_2 = """

{color=red|An eerie glow emits from the remnants of an altar and enshrouds [name]. It seems [he] has been cursed...}""", # MISSING TRANSLATION
	FREYA_ITEM_CLOTH = """

{color=green|The offering disappears in a thin air and a bright light surrounds [name]. It seems the offer was correct and [he] restored [his] magic energy.}""", # MISSING TRANSLATION
	FREYA_ITEM_CLOTHMAGICC = """

{color=green|The offering disappears in a thin air and a bright light surrounds [name]. It seems the offer was correct and [he] received a blessing.}""", # MISSING TRANSLATION
	FREYA_ITEM_CLOTHETHERIAL = """

{color=green|The offering disappears in a thin air and a bright light surrounds [name]. }""", # MISSING TRANSLATION
	FREYA_ITEM_WOOD = """

{color=red|The offering disappears from sight but an eerie glow erupts from the altar. It seems [name] as been cursed due to [his] offering...}""", # MISSING TRANSLATION
	FREYA_ITEM_OTHER = """

The offering disappears from sight but there's no other changes around. It seems your offer wasn't liked.""", # MISSING TRANSLATION
	FREYA_CHAR_BOW = """

{color=green|A small glow emits from the altar and enshrouds [name]. Before Aire can realize it, a bow materializes in her hands...}""", # MISSING TRANSLATION
	FREYA_CHAR_WOODEN = """

{color=red|An eerie glow emits from the remnants of an altar and enshrouds [name]. It seems [he] has been cursed. Perhaps, something what they wear might have aggrieved the entity...}""", # MISSING TRANSLATION
	FREYA_CHAR_RACE_GOOD = """

{color=green|A small glow emits from the altar and enshrouds [name]. It seems [he] has been blessed...}""", # MISSING TRANSLATION
	FREYA_CHAR_RACE_BAD = """

After a few minutes nothing still happened and [name] decides to move on.""", # MISSING TRANSLATION
	
	STOP_LABEL = "Stop",
	TIME_LEFT_LABEL = "Time Left",
	AFFECTION_LABEL = "Affection",
	DISCIPLINE_LABEL = "Discipline",
	TRAINING_LABEL = "Training",
	LOCATION_LABEL = "Location",
	
	BODYUPGRADENAME_UPGRADE_THICK_SKIN = "Thick Skin",
	BODYUPGRADEDESCRIPT_UPGRADE_THICK_SKIN = "[name]'s skin will be much more resilent to magical effects. MDEF +10. Incompatible with Fur/Scales.",
	BODYUPGRADENAME_UPGRADE_THICK_COVERAGE = "Thick Coverage",
	BODYUPGRADEDESCRIPT_UPGRADE_THICK_COVERAGE = "[name]'s fur or scales will be hardened at will for combat. DEF +10. Must have fur or scales.",
	BODYUPGRADENAME_UPGRADE_NIPPLES = "Hollow Nipples",
	BODYUPGRADEDESCRIPT_UPGRADE_NIPPLES = "[name]'s nipples will be modified to allow insertion of object into them, providing lubrication and act as erogenous zones. Must have above average breast size. Prostitution Income + 10%",
	BODYUPGRADENAME_UPGRADE_TONGUE = "Elongated Tongue",
	BODYUPGRADEDESCRIPT_UPGRADE_TONGUE = "[name]'s tongue will be modified to much longer length allowing to be used in more advance sexual performances. Prostitution Income + 10%",
	BODYUPGRADENAME_UPGRADE_EGGS = "Oviposition",
	BODYUPGRADEDESCRIPT_UPGRADE_EGGS = "[name]'s womb will be modified to allow production of eggs at the farm. Impregnation is still possible.",
	BODYUPGRADENAME_UPGRADE_SILK = "Silk Secretion",
	BODYUPGRADEDESCRIPT_UPGRADE_SILK = "[name]'s body will be modified to produce high quality silk at the farm.",
	BODYUPGRADENAME_UPGRADE_STRONGARM = "Strong Arms",
	BODYUPGRADEDESCRIPT_UPGRADE_STRONGARM = "[name]'s arms will be strong enough to wield two-handed melee weapons in one hand.",
	BODYUPGRADENAME_UPGRADE_RESIST = "Magic Resist",
	BODYUPGRADEDESCRIPT_UPGRADE_RESIST = "[name]'s magic resistance will allow to negate enemy spells with 25% chance.",
	BODYUPGRADENAME_UPGRADE_THICKBLOOD = "Thick Blood",
	BODYUPGRADEDESCRIPT_UPGRADE_THICKBLOOD = "[name] will gain immunity to bleed and poison.",
	QUALITYPOOR = """Poor""", # MISSING TRANSLATION
	QUALITYAVERAGE = """Average""", # MISSING TRANSLATION
	QUALITYGOOD = """Good""", # MISSING TRANSLATION
	QUALITYEPIC = """Epic""", # MISSING TRANSLATION
	QUALITYLEGENDARY = """Legendary""", # MISSING TRANSLATION
	ENCHSHARPNESS = """Sharpness""", # MISSING TRANSLATION
	ENCHSHARPNESSDESCRIPT = """Increases Attack by 10%*level and Hit Rate by 5+5*level of bladed weapons.""", # MISSING TRANSLATION
	ENCHSPELL_MASTERY = """Spell Mastery""", # MISSING TRANSLATION
	ENCHSPELL_MASTERYDESCRIPT = """Increases Spell Damage and Healing effects by 5%+5%*level. Does not stack.""", # MISSING TRANSLATION
	ENCHSTUN_IMMUNE = """Stun Immunity""", # MISSING TRANSLATION
	ENCHSTUN_IMMUNEDESCRIPT = """Wearer can't be stunned.""", # MISSING TRANSLATION
	ENCHTHORNS = """Thorns""", # MISSING TRANSLATION
	ENCHTHORNSDESCRIPT = """Returns 5%+5%*level of physical damage to the attacker.""", # MISSING TRANSLATION
	ENCHCARAPACE = """Carapace""", # MISSING TRANSLATION
	ENCHCARAPACEDESCRIPT = """Increases item's DEF value by 7%*level and boosts all elemental resists by 2*level.""", # MISSING TRANSLATION
	ENCHVAMPIRISM = """Vampirism""", # MISSING TRANSLATION
	ENCHVAMPIRISMDESCRIPT = """2%*level of physical damage dealt will be absorbed as health.""", # MISSING TRANSLATION
	ENCHCOMMANDER = """Commander""", # MISSING TRANSLATION
	ENCHCOMMANDERDESCRIPT = """Increases damage dealt and reduce damage received of all other party members by 3%/5%. Does not stack.""", # MISSING TRANSLATION
	ENCHWARLOCK = """Warlock""", # MISSING TRANSLATION
	ENCHWARLOCKDESCRIPT = """Reduces mana cost of skills by 5%+5%*level.""", # MISSING TRANSLATION
	ENCHTREASUREHUNT = """Treasure Hunter""", # MISSING TRANSLATION
	ENCHTREASUREHUNTDESCRIPT = """Increases chance to find higher quality gear""", # MISSING TRANSLATION
	ENCHREAPER = """Reaper""", # MISSING TRANSLATION
	ENCHREAPERDESCRIPT = """Increases damage versus humanoid enemies by 10%+10%*level""", # MISSING TRANSLATION
	ENCHBEASTHUNTER = """Beast Hunter""", # MISSING TRANSLATION
	ENCHBEASTHUNTERDESCRIPT = """Increases damage versus beast enemies by 10%+10%*level""", # MISSING TRANSLATION
	ENCHUNDEADBANE = """Undead Bane""", # MISSING TRANSLATION
	ENCHUNDEADBANEDESCRIPT = """Increases damage versus undead enemies by 10%+10%*level""", # MISSING TRANSLATION
	ENCHGIANTSLAYER = """Giant Slayer""", # MISSING TRANSLATION
	ENCHGIANTSLAYERDESCRIPT = """Increases damage versus giant type enemies by 10%+10%*level.""", # MISSING TRANSLATION
	ENCHDRAGONSLAYER = """Dragon Slayer""", # MISSING TRANSLATION
	ENCHDRAGONSLAYERDESCRIPT = """Increases damage versus dragon type enemies by 10%+10%*level.""", # MISSING TRANSLATION
	ENCHMANASIPHON = """Mana Siphon""", # MISSING TRANSLATION
	ENCHMANASIPHONDESCRIPT = """Skill attacks restore 1*level mana per use""", # MISSING TRANSLATION
	ENCHNIMBLE = """Nimbleness""", # MISSING TRANSLATION
	ENCHNIMBLEDESCRIPT = """Increases evasion by 5*level.""", # MISSING TRANSLATION
	ENCHKNOWLEDGE = """Knowledge""", # MISSING TRANSLATION
	ENCHKNOWLEDGEDESCRIPT = """Increases experience gained by 5%+5%*level """, # MISSING TRANSLATION
	CURSESTUB_MINOR = """""", # MISSING TRANSLATION
	CURSESTUB_MINORDESCRIPT = """""", # MISSING TRANSLATION
	CURSESTUB_MAJOR = """""", # MISSING TRANSLATION
	CURSESTUB_MAJORDESCRIPT = """""", # MISSING TRANSLATION
	CURSEWEAKNESS_MINOR = """Curse of Weakness (minor)""", # MISSING TRANSLATION
	CURSEWEAKNESS_MINORDESCRIPT = """Physics -30""", # MISSING TRANSLATION
	CURSEWEAKNESS_MAJOR = """Curse of Weakness (major)""", # MISSING TRANSLATION
	CURSEWEAKNESS_MAJORDESCRIPT = """Physics -60""", # MISSING TRANSLATION
	CURSESLOWWIT_MINOR = """Curse of Slow wit (minor)""", # MISSING TRANSLATION
	CURSESLOWWIT_MINORDESCRIPT = """Wits -30""", # MISSING TRANSLATION
	CURSESLOWWIT_MAJOR = """Curse of Slow wit (major)""", # MISSING TRANSLATION
	CURSESLOWWIT_MAJORDESCRIPT = """Wits -60""", # MISSING TRANSLATION
	CURSEFRAGILITY_MINOR = """Curse of Fragility (minor)""", # MISSING TRANSLATION
	CURSEFRAGILITY_MINORDESCRIPT = """Maximum HP -25%""", # MISSING TRANSLATION
	CURSEFRAGILITY_MAJOR = """Curse of Fragility (major)""", # MISSING TRANSLATION
	CURSEFRAGILITY_MAJORDESCRIPT = """Maximum HP -40%""", # MISSING TRANSLATION
	CURSEDECLINE_MINOR = """Curse of Decline (minor)""", # MISSING TRANSLATION
	CURSEDECLINE_MINORDESCRIPT = """Earned XP -25%""", # MISSING TRANSLATION
	CURSEDECLINE_MAJOR = """Curse of Decline (major)""", # MISSING TRANSLATION
	CURSEDECLINE_MAJORDESCRIPT = """Earned XP -50%""", # MISSING TRANSLATION
	CURSEDISTRUST_MINOR = """Curse of Distrust (minor)""", # MISSING TRANSLATION
	CURSEDISTRUST_MINORDESCRIPT = """+25% Obedience Drain""", # MISSING TRANSLATION
	CURSEDISTRUST_MAJOR = """Curse of Distrust (major)""", # MISSING TRANSLATION
	CURSEDISTRUST_MAJORDESCRIPT = """+50% Obedience Drain""", # MISSING TRANSLATION
	CURSEHIDEOUS_MAJOR = """Curse of Hideous (minor)""", # MISSING TRANSLATION
	CURSEHIDEOUS_MAJORDESCRIPT = """Charm -30""", # MISSING TRANSLATION
	CURSEHIDEOUS_MINOR = """Curse of Hideous (major)""", # MISSING TRANSLATION
	CURSEHIDEOUS_MINORDESCRIPT = """Charm -60""", # MISSING TRANSLATION
	ANASTASIA_EXECUTION1_SS = """Fail to recruite Anastasia at the end of Arc 1.""", # MISSING TRANSLATION
	LICH_AIRE_TALK4_SS = """Unlocks during Rite of Passage quest""", # MISSING TRANSLATION
	XARI_ENCOUNTER8_SS = """Successfully persuade Xari during your first encounter""", # MISSING TRANSLATION
	DAISY_DISCIPLINE_SS = """Unlocks in a week after finishing Daisy training""", # MISSING TRANSLATION
	DAISY_BJ1_SS = """Unlock during Daisy's training""", # MISSING TRANSLATION
	DAISY_TRAINING1_SS = """Subject Daisy to a harsh training""", # MISSING TRANSLATION
	DAISY_PUBLIC1_SS = """Further experiment with Daisy after harsh training""", # MISSING TRANSLATION
	DAISY_BENT1_SS = """Rescue Daisy and have her thank you""", # MISSING TRANSLATION
	ANASTASIA_SEX_1_SS = """Anastasia's good end of arc scene""", # MISSING TRANSLATION
	ANASTASIA_RAPE_1_SS = """Anastasia's bad end of arc scene""", # MISSING TRANSLATION
	AIRE_AMELIA1_SS = """Let Amelia 'interrogate' Aire for princess' location""", # MISSING TRANSLATION
	AMELIA_TITJOB1_SS = """Let Amelia reward you after her first sidequest""", # MISSING TRANSLATION
	AMELIA_BONDAGE1_SS = """Let Amelia reward you after her second sidequest""", # MISSING TRANSLATION
	ANASTASIA_AIRE1_SS = """Reward for completing Aire's sidequest after recruiting Anastasia""", # MISSING TRANSLATION
	AIRE_ANA1_SS = """Unlock after completing "Aire: Proof of Strength" quest in the Aire dialogue""", # MISSING TRANSLATION
	AIRE_ANA4_SS = """Unlock after completing "Aire: Proof of Strength" quest in the Aire dialogue""", # MISSING TRANSLATION
	FORCE_CALI1_SS = """Choose the worst option when encountering Cali for the first time""", # MISSING TRANSLATION
	MAE_SCENE1_SS = """Have Mae thank you during second story act""", # MISSING TRANSLATION
	MAE_SCENE3_SS = """Mae scene during ritual""", # MISSING TRANSLATION
	HELEVIEL1_SS = """Reward by Heleviel for female main characters""", # MISSING TRANSLATION
	LILIA_SEX_1_3_SS = """Complete first Lilia's quest""", # MISSING TRANSLATION
	CALI_TOUCHING_1_SS = """First scene with Cali during her sidequest""", # MISSING TRANSLATION
	CALI_BJ_HAPPY_1_SS = """Second scene with Cali during her sidequest""", # MISSING TRANSLATION
	CALI_RIDING_1_SS = """Complete Cali's sidequest""", # MISSING TRANSLATION
	HALLOWEEN_SCENE_SS = """Halloween event with Cali and Anastasia""", # MISSING TRANSLATION
	CHRISTMAS_SCENE_SS = """Christmas event with Daisy""", # MISSING TRANSLATION
	HELEVIEL_MANSION_SS = """Recruit Heleviel""", # MISSING TRANSLATION
	LIRA_SEX_1_SS = """Complete first Lilia sidequest""", # MISSING TRANSLATION
	CALI_ZEPHYRA_1_SS = """Both Cali and Zephyra in master's possession on good routes""", # MISSING TRANSLATION
	CALI_BOWL_1_SS = """Unlocks sometimes after you have sex with Cali""", # MISSING TRANSLATION
	CALI_BOWL_NAKED_1_SS = """Unlocks on Cali's bad route""", # MISSING TRANSLATION
	ZEPHYRA_BATH_1_SS = """Help Zephyra in church""", # MISSING TRANSLATION
	STAG_SEX_1_SS = """Unlock during a quest from beastkin settlement""", # MISSING TRANSLATION
	ZEPHYRA_LILIA_1_SS = """Have both Zephyra and Lilia and progress their quests""", # MISSING TRANSLATION
	AMELIA_SEX_1_SS = """Complete Amelia's sidequest, recruit her and talk to her in mansion""", # MISSING TRANSLATION
	ZEPHYRA_DISAPPEARANCE_SEX_1_SS = """Complete Zephyra's second sidequest""", # MISSING TRANSLATION
	ZEPHYRA_DISAPPEARANCE_GUARDS_1_SS = """Peek on Zephyra's fake story during her second sidequest""", # MISSING TRANSLATION
	DAISY_WEDDING_SS = """Take Daisy as your (slave) wife""", # MISSING TRANSLATION
	CALI_WEDDING_SS = """Make Cali your lifelong partner""", # MISSING TRANSLATION
	AMELIA_WEDDING_SS = """Promote Amelia to the vice presidency of your Mansion""", # MISSING TRANSLATION
	ANASTASIA_EVENT_ALIVE_SS = """Keep Anastasia alive in the end of act 1""", # MISSING TRANSLATION
	ELVEN_TEMPLE_SCENE_SS = """Event from elven temple""", # MISSING TRANSLATION
	ACT1_ART_SS = """Start first act""", # MISSING TRANSLATION
	ACT2_ART_SS = """Start second act""", # MISSING TRANSLATION
}





