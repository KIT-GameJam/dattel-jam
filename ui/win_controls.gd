extends VBoxContainer

var controls_container: ControlsContainer = null

func _ready() -> void:
	# TODO: set description
	$Description.text = ""

func _on_back_to_title_button_on_click() -> void:
	Global.get_game_manager().return_to_title_screen()

func _on_restart_button_on_click() -> void:
	Global.get_game_manager().restart()

func _on_infinity_button_on_click() -> void:
	Global.get_game()._reload_level()
