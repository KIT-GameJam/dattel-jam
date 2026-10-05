extends GhostCar

const mine_scene: PackedScene = preload("res://core/mine.tscn")

@export_range(0.0, 10.0, 0.5) var min_time := 3.0
@export_range(0.0, 10.0, 0.5) var max_time := 4.0
@onready var minen_timer: Timer = $MinenTimer

func _ready() -> void:
	Global.get_game().race_start.connect(start_timer)

func start_timer() -> void:
	minen_timer.start(randf_range(min_time, max_time))

func _on_minen_timer_timeout() -> void:
	var mine: Node2D = mine_scene.instantiate()
	Global.get_level().add_child(mine)
	mine.global_position = global_position

func reset() -> void:
	super.reset()
	minen_timer.stop()
