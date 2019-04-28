extends TextureRect

var textdict = {
	character = 'Each character has its own class, defining what abilities they acquire and equipment they use. Some classes also have inbuilt traits. I.e. Rose gain additional damage from wearing items with magic defence. You can see more info by clicking "Class details".',
	explorepositioning = "You can assign your characters to front and back rows.\n\nCharacters at back rows can't be attacked by melee attacks while front row is alive. However, their melee attacks only deal half damage. Use it for ranged fighters and casters.",
	explore = "Areas can have progress or be a free roam. Progress areas require to complete multiple battles until you finish it. Free roam areas can be explored for loot and experience.",
	combat = "Different character have different affinities, skills and resists. Some of the info can be found at statistics tab. Right-click on the enemy to see details.",
	aftercombat = "Health and mana will regenerate as global time goes on, but can also be restored with skills and items in combat. Some items activate instantly without consuming your turn. ",
	blacksmith = "Upgrading Blacksmith will unlock more options. \n\nTip: try to use leather and cloth for armor to produce items more beneficial for your back rows. ",
}

func _ready():
#warning-ignore:return_value_discarded
	$CheckBox.connect("pressed", self, "disabletips")
#warning-ignore:return_value_discarded
	$Close.connect("pressed", self, 'hide')

func showtip(tip):
	show()
	$RichTextLabel.bbcode_text = textdict[tip]
	state.viewed_tips.append(tip)

func disabletips():
	globals.globalsettings.disabletips = $CheckBox.pressed

