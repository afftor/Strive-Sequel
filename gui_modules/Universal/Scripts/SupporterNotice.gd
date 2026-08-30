extends Control

# Main menu prompt asking the player to support the game. It only appears for players
# who already have a save (so a first launch is never interrupted), who haven't pressed
# "Don't show again" and who haven't unlocked the supporter features with a code yet.

onready var panel = $Panel
onready var code_popup = $CodePopup
onready var thanks_popup = $ThanksPopup
onready var code_edit = $CodePopup/MarginContainer/VBoxContainer/CodeEdit
onready var error_label = $CodePopup/MarginContainer/VBoxContainer/ErrorLabel
onready var message_label = $Panel/MarginContainer/Content/TextBox/MessageLabel


func _ready():
	hide()
	#bbcode_text is not auto-translated the way a Label's text is, so it is filled in here
	message_label.bbcode_text = tr("SUPPORTERNOTICETEXT")
	panel.get_node("MarginContainer/Content/ButtonBox/EnterCodeButton").connect("pressed", self, "open_code_popup")
	panel.get_node("MarginContainer/Content/ButtonBox/DismissButton").connect("pressed", self, "dismiss_forever")
	# CloseButton.tscn carries no script - like the other panels in the menu, it has to be wired up by hand
	panel.get_node("CloseButton").connect("pressed", self, "close")
	code_popup.get_node("MarginContainer/VBoxContainer/ConfirmButton").connect("pressed", self, "confirm_code")
	code_popup.get_node("MarginContainer/VBoxContainer/GetCodeButton").connect("pressed", $LinksPopup, "open")
	code_popup.get_node("CloseButton").connect("pressed", code_popup, "hide")
	code_edit.connect("text_entered", self, "code_entered")
	thanks_popup.get_node("MarginContainer/VBoxContainer/OkButton").connect("pressed", self, "close")


# Called by the main menu once it knows whether a save exists.
func try_show(has_save):
	if globals.is_experimental_build():
		# experimental builds go out to testers only - no point pitching a subscription there
		return
	if !has_save:
		return
	if input_handler.progress_data.supporter_prompt_dismissed:
		return
	if input_handler.cheats_unlocked():
		return
	panel.show()
	show()


func open_code_popup():
	code_edit.text = ""
	error_label.hide()
	code_popup.show()
	code_popup.raise()
	code_edit.grab_focus()


func code_entered(_text):
	confirm_code()


func confirm_code():
	if !input_handler.try_cheat_password(code_edit.text):
		error_label.show()
		return
	code_popup.hide()
	panel.hide()
	thanks_popup.show()


func dismiss_forever():
	input_handler.progress_data.supporter_prompt_dismissed = true
	input_handler.store_progress()
	close()


func close():
	ResourceScripts.core_animations.FadeAnimation(self)
	yield(get_tree().create_timer(0.3), "timeout")
	hide()
	panel.hide()
	code_popup.hide()
	thanks_popup.hide()
	$LinksPopup.hide()
	modulate.a = 1
