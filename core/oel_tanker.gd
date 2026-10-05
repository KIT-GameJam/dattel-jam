extends GhostCar

const oil_scene: PackedScene = preload("res://core/oil_patch.tscn")

@export_range(0.0, 10.0, 0.5) var min_time := 3.0
@export_range(0.0, 10.0, 0.5) var max_time := 4.0
@onready var oil_timer: Timer = $OilTimer

func _ready() -> void:
	Global.get_game().race_start.connect(start_timer)

func start_timer() -> void:
	oil_timer.start(randf_range(min_time, max_time))

func _on_oil_timer_timeout() -> void:
	var patch: Node2D = oil_scene.instantiate()
	Global.get_level().add_child(patch)
	patch.global_position = global_position

func reset() -> void:
	super.reset()
	oil_timer.stop()
