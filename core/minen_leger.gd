extends GhostCar

const mine_scene: PackedScene = preload("res://core/mine.tscn")

@onready var minen_timer: Timer = $MinenTimer

func _ready() -> void:
	Global.get_game().race_start.connect(minen_timer.start)

func _on_minen_timer_timeout() -> void:
	var mine: Node2D = mine_scene.instantiate()
	Global.get_level().add_child(mine)
	mine.global_position = global_position

func reset() -> void:
	super.reset()
	minen_timer.stop()
