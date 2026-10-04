extends VBoxContainer

var controls_container: ControlsContainer = null

func _on_back_to_title_button_on_click() -> void:
	Global.get_game_manager().return_to_title_screen()
