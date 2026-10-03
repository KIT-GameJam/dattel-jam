extends HistoryObject

const MAX_SPEED := 140.0
const ROTATION_SPEED := 2.0
const ACCEL := 72.0
const SPEED_DOWN_FACTOR := 0.3
const TURNING_MAX_SPEED_DAMP := 0.8

@onready var detection_area: Area2D = $DetectionArea
var speed := 0.0
var is_turning := false

func turn_left(angle: float) -> void:
	rotation -= angle
func turn_right(angle: float) -> void:
	rotation += angle

func process_input(delta: float) -> void:
	is_turning = false
	if Input.is_action_pressed("left"):
		turn_left(ROTATION_SPEED * delta)
		is_turning = true
	if Input.is_action_pressed("right"):
		turn_right(ROTATION_SPEED * delta)
		is_turning = true

func _physics_process(delta: float) -> void:
	process_input(delta)
	var ground_speed := 0.45
	for area in detection_area.get_overlapping_areas():
		if is_instance_of(area, Road):
			ground_speed = area.drive_speed
			break
	var max_speed: float = ground_speed * MAX_SPEED
	if is_turning:
		max_speed *= TURNING_MAX_SPEED_DAMP
	speed += ACCEL * delta
	if speed >= max_speed:
		# progressively speed down on max speed
		speed = speed * pow(SPEED_DOWN_FACTOR, delta)
		speed = max(speed, max_speed)
	velocity = Vector2(0, -1).rotated(rotation) * speed
	move_and_slide()
	write_history()
