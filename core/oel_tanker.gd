extends GhostCar

const oil_scene: PackedScene = preload("res://core/oil_patch.tscn")

func _on_oil_timer_timeout() -> void:
	if not Global.is_race_started(): return
	var patch: Node2D = oil_scene.instantiate()
	Global.get_level().add_child(patch)
	patch.global_position = global_position
