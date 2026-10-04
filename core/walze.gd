class_name Walze
extends Path2D

@export var speed := 140.0

@onready var follow: PathFollow2D = $PathFollow2D

var current_speed := 0.0
var rubber_band := 0

func curve_ready() -> void:
	follow.progress_ratio = 1.0
	follow.progress = follow.progress - 100.0

func _physics_process(delta: float) -> void:
	if not Global.is_race_started(): return
	current_speed += delta * 40.0
	var max_speed := speed
	if rubber_band == 1: max_speed = speed * 1.03
	if rubber_band == 2: max_speed = speed * 1.55
	current_speed = min(max_speed, current_speed)
	follow.progress += delta * current_speed

func _find_progress_of(point: Vector2) -> float:
	return curve.get_closest_offset(to_local(point))

func is_behind_walz(point: Vector2) -> bool:
	var length := curve.get_baked_length()
	var progress := _find_progress_of(point) / length
	var walz_progress := follow.progress / length
	rubber_band = 0
	if progress < 0.1 and walz_progress > 0.9: return false
	if progress < walz_progress: return true
	var dist := progress - walz_progress
	if dist >= 0.05:
		print("STRONG rubber band")
		rubber_band = 2
	elif dist >= 0.02:
		print("soft rubber band")
		rubber_band = 1
	return false
