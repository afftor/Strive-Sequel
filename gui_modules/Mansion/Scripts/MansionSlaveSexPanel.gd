extends Panel

#The sex block the character screen keeps in its left column, opened from the mansion list
#instead. Both are filled by the same globals builders, so the two cannot drift apart.

var person

onready var ConsentValue = $Margin/Content/Consent
onready var StaminaValue = $Margin/Content/Stamina
onready var Skills = $Margin/Content/Skills
onready var TraitCapacity = $Margin/Content/TraitCapacity
onready var TraitItems = $Margin/Content/Scroll/Items


func _ready():
	$CloseButton.connect("pressed", self, "hide")
	globals.connecttexttooltip($Margin/Content/TraitsTitle, tr("SEXTRAITHELP"))


func set_person(value):
	person = value
	if person == null:
		return
	if person.is_master():
		ConsentValue.text = tr("SIBLINGMODULECONSENT") + tr("MASTER")
		globals.connecttexttooltip(ConsentValue, person.translate(tr("INFOCONSENTMASTER")))
	else:
		ConsentValue.text = (
			tr("SIBLINGMODULECONSENT")
			+ tr(variables.consent_dict[int(person.get_stat('consent'))])
		)
		globals.connecttexttooltip(ConsentValue, tr("INFOCONSENT"))
	StaminaValue.text = tr("STATSEX_STAMINA") + ": " + str(person.get_stat('sex_stamina'))
	globals.connecttexttooltip(StaminaValue,
		"[center]" + tr("STATSEX_STAMINA") + "[/center]\n" + tr("STATSEX_STAMINADESCRIPT"))
	globals.build_sex_training_rows(person, Skills)
	globals.build_sex_traits_list(person, TraitItems, TraitCapacity)
