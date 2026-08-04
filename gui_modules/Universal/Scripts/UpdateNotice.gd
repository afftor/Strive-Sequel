extends Control

# Checks itch.io for a newer build than the one currently running, using the
# public butler endpoint described at https://itch.io/docs/butler/pushing.html#looking-for-updates
# Set ENABLED to false to turn this feature off completely without removing the node.
const ENABLED = true

const REQUEST_TIMEOUT = 8.0

onready var http_request = $HTTPRequest
onready var timeout_timer = $TimeoutTimer
onready var title_label = $Panel/MarginContainer/VBoxContainer/TitleLabel
onready var message_label = $Panel/MarginContainer/VBoxContainer/MessageLabel


func _ready():
	hide()
	http_request.connect("request_completed", self, "_on_request_completed")
	timeout_timer.connect("timeout", self, "_on_timeout")
	$Panel/MarginContainer/VBoxContainer/ButtonRow/DownloadButton.connect("pressed", self, "_on_download_pressed")
	# CloseButton.tscn has no script of its own (other close buttons in the game
	# wire it up manually the same way), so its "pressed" signal has to be
	# connected here explicitly.
	$CloseButton.connect("pressed", self, "_dismiss")


# Call this from the main menu's own _ready() to kick off the check.
func start_update_check():
	if !ENABLED:
		return
	if _is_experimental_build():
		# Nothing is sent anywhere in this branch, so it doesn't go through the consent gate.
		title_label.text = tr("UPDATENOTICEEXPERIMENTALTITLE")
		message_label.text = tr("UPDATENOTICEEXPERIMENTAL") % [globals.gameversion]
		show()
		return
	match input_handler.progress_data.update_check_consent:
		null:
			# Not asked yet - ask, and only run the check if they say yes.
			# Their answer (yes or no) is remembered, so this only ever shows once.
			input_handler.get_spec_node(input_handler.NODE_YESORNOPANEL,
				[self, "_on_consent_given", "_on_consent_declined", tr("UPDATECHECKCONSENT")])
		true:
			_run_check()
		false:
			pass # player declined - stay silent, don't ask again


func _on_consent_given():
	_set_consent(true)
	_run_check()


func _on_consent_declined():
	_set_consent(false)


func _set_consent(value):
	input_handler.progress_data.update_check_consent = value
	input_handler.store_progress()


func _run_check():
	var channel = _get_channel_name()
	if channel == "":
		return # unsupported/unknown platform (e.g. html5) - nothing to check against

	# strive4power/strive-conquest is the same itch.io project the "Itch" social
	# button on the main menu links to (see input_handler.open_shell)
	var url = "https://api.itch.io/wharf/latest?target=strive4power/strive-conquest&channel_name=" + channel
	var err = http_request.request(url)
	if err != OK:
		return # no usable network stack (e.g. sandboxed/offline environment) - fail silently
	timeout_timer.start(REQUEST_TIMEOUT)


# Experimental builds ('0.13.1 experimental 1') carry the upcoming version number while
# itch still serves the previous one, so any comparison would report an update every launch.
func _is_experimental_build():
	return globals.gameversion.to_lower().find("experimental") >= 0


# Butler channel names must match whatever channel this platform's build was
# pushed to (`butler push <folder> strive4power/strive-conquest:<channel>`).
# Adjust these if the actual channel names on itch.io differ.
func _get_channel_name():
	match OS.get_name():
		"Windows":
			return "win64" if OS.has_feature("64") else "win32"
		"X11":
			return "linux"
		"OSX":
			return "osx"
	return ""


func _on_timeout():
	http_request.cancel_request()


func _on_request_completed(result, response_code, _headers, body):
	timeout_timer.stop()
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		return # no internet connection, DNS failure, itch.io unreachable, private/unlisted game, etc.

	var parsed = JSON.parse(body.get_string_from_utf8())
	if parsed.error != OK or typeof(parsed.result) != TYPE_DICTIONARY:
		return # unexpected/garbled response

	var latest = parsed.result.get("latest", "")
	if latest == "":
		# No version tag on the channel - we can't tell if we're current or not,
		# so treat it as "possibly outdated" and prompt the player to check manually
		# rather than silently assuming everything is fine.
		message_label.text = tr("UPDATENOTICEUNKNOWN")
		show()
		return
	if latest == globals.gameversion:
		return # already up to date

	message_label.text = tr("UPDATENOTICEAVAILABLE") % [latest, globals.gameversion]
	show()


func _on_download_pressed():
	input_handler.open_shell('Itch')
	_dismiss()


func _dismiss():
	ResourceScripts.core_animations.FadeAnimation(self)
	yield(get_tree().create_timer(0.3), "timeout")
	hide()
