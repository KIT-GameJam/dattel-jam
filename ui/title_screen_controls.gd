extends VBoxContainer

var controls_container: ControlsContainer = null

func _on_start_button_on_click() -> void:
	Global.get_game_manager().start()

func _on_settings_button_on_click() -> void:
	controls_container.push_controls(controls_container.settings_screen_controls)

func _on_exit_button_on_click() -> void:
	Global.exit_game()

func _on_tutorial_button_on_click() -> void:
	Global.get_game_manager().toggle_tutorial()
