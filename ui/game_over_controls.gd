extends VBoxContainer

var controls_container: ControlsContainer = null

func _ready() -> void:
	$Description.text = Global.get_game().game_over_message

func _on_back_to_title_button_on_click() -> void:
	Global.get_game_manager().return_to_title_screen()

func _on_restart_button_on_click() -> void:
	Global.get_game_manager().restart()
