extends VBoxContainer

var controls_container: ControlsContainer = null

func _on_continue_button_on_click() -> void:
	Global.unpause()

func _on_settings_button_on_click() -> void:
	controls_container.push_controls(controls_container.settings_screen_controls)

func _on_back_to_title_button_on_click() -> void:
	Global.return_to_title_screen()
