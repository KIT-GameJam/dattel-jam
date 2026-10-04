extends GhostCar

const mine_scene: PackedScene = preload("res://core/mine.tscn")

func _on_minen_timer_timeout() -> void:
	if not Global.is_race_started(): return
	var mine: Node2D = mine_scene.instantiate()
	Global.get_level().add_child(mine)
	mine.global_position = global_position
