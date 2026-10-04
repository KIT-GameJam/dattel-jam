extends Path2D

@export var speed := 50.0

@onready var follow: PathFollow2D = $PathFollow2D

func curve_ready() -> void:
	follow.progress_ratio = 1.0
	follow.progress = follow.progress - 100.0

func _physics_process(delta: float) -> void:
	if not Global.get_game().is_race_started: return
	follow.progress += delta * speed
