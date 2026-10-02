extends "res://core/car.gd"

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		turn_left(ROTATION_SPEED * delta)
	if Input.is_action_pressed("ui_right"):
		turn_right(ROTATION_SPEED * delta)
