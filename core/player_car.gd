extends "res://core/car.gd"

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		turn_left(ROTATION_SPEED * delta)
	if Input.is_action_pressed("right"):
		turn_right(ROTATION_SPEED * delta)

func add_history_entry():
	pass

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
