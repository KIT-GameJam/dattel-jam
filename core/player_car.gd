extends HistoryObject

const SPEED := 300.0
const ROTATION_SPEED := 3.0

func turn_left(angle: float) -> void:
	rotation -= angle
func turn_right(angle: float) -> void:
	rotation += angle

func process_input(delta: float) -> void:
	if Input.is_action_pressed("left"):
		turn_left(ROTATION_SPEED * delta)
	if Input.is_action_pressed("right"):
		turn_right(ROTATION_SPEED * delta)

func _physics_process(delta: float) -> void:
	process_input(delta)
	velocity = Vector2(0, -1).rotated(rotation) * SPEED
	move_and_slide()
	write_history()
