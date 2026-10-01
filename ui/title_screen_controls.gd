extends VBoxContainer

var title_screen: TitleScreen = null

func _on_exit_button_on_click() -> void:
	Global.exit_game()

func _on_settings_button_on_click() -> void:
	title_screen.push_controls(title_screen.settings_screen_controls)
