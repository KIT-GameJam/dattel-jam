extends CharacterBody2D

const SPEED := 300.0
const ROTATION_SPEED := 3.0

func turn_left(angle: float) -> void:
	rotation -= angle

func turn_right(angle: float) -> void:
	rotation += angle

func _physics_process(_delta: float) -> void:
	velocity = Vector2(0, -1).rotated(rotation) * SPEED
	move_and_slide()
