extends Node

func exit_game() -> void:
	get_tree().quit()

func get_game_manager() -> GameManager:
	return get_tree().current_scene
	
func get_game() -> Game:
	return get_game_manager().current_game

func get_level() -> Level:
	return get_game().level

func get_timestamp() -> float:
	return get_level().get_timestamp()
