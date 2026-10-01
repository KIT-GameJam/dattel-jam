extends Node

func exit_game() -> void:
	get_tree().quit()

func game() -> Game:
	return get_tree().current_scene
