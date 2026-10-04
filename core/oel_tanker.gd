extends GhostCar

const oil_scene: PackedScene = preload("res://core/oil_patch.tscn")

@onready var oil_timer: Timer = $OilTimer

func _ready() -> void:
	Global.get_game().race_start.connect(oil_timer.start)

func _on_oil_timer_timeout() -> void:
	var patch: Node2D = oil_scene.instantiate()
	Global.get_level().add_child(patch)
	patch.global_position = global_position
