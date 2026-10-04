extends Path2D

@export var speed := 195.0

@onready var follow: PathFollow2D = $PathFollow2D

var current_speed := 0.0

func curve_ready() -> void:
	follow.progress_ratio = 1.0
	follow.progress = follow.progress - 100.0

func _physics_process(delta: float) -> void:
	if not Global.get_game().is_race_started: return
	current_speed += delta * 50.0
	current_speed = min(speed, current_speed)
	follow.progress += delta * current_speed
