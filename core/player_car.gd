extends HistoryObject

const SPEED := 80.0
const ROTATION_SPEED := 2.0

@onready var detection_area: Area2D = $DetectionArea

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
	var ground_speed := 0.45
	for area in detection_area.get_overlapping_areas():
		if is_instance_of(area, Road):
			ground_speed = area.drive_speed
			break
	velocity = Vector2(0, -1).rotated(rotation) * SPEED * ground_speed
	move_and_slide()
	write_history()
