class_name PlayerCar
extends HistoryObject

const MAX_SPEED := 85.0
const ROTATION_SPEED := 1.8
const ACCEL := 50.0
const SPEED_DOWN_FACTOR := 0.3
const TURNING_MAX_SPEED_DAMP := 0.7
const DEFAULT_ROTATION: float = deg_to_rad(-90.0);
const TIRE_ANGLE: float = deg_to_rad(30.0);
const BRUMM1: AudioStreamOggVorbis = preload("res://assets/sfx/BrummBrumm1.ogg")
const BRUMM2: AudioStreamOggVorbis = preload("res://assets/sfx/BrummBrumm2.ogg")

@onready var detection_area: Area2D = $DetectionArea
@onready var tires: Array[Sprite2D] = [$Sprite2D/Tire, $Sprite2D/Tire2]
@onready var brumm: AudioStreamPlayer2D = $BrummPlayer
var speed := 0.0
var is_turning := false
var curr_tire_rot: int = 0

func turn_left(angle: float) -> void:
	rotation -= angle
func turn_right(angle: float) -> void:
	rotation += angle

func rotate_tire(rot: int) -> void:
	if curr_tire_rot == rot:
		pass
	curr_tire_rot = rot
	for tire in tires:
		tire.rotation = DEFAULT_ROTATION + rot * TIRE_ANGLE

func process_input(delta: float) -> void:
	is_turning = false
	rotate_tire(0)
	if Input.is_action_pressed("left"):
		turn_left(ROTATION_SPEED * delta)
		rotate_tire(-1)
		is_turning = true
	if Input.is_action_pressed("right"):
		turn_right(ROTATION_SPEED * delta)
		rotate_tire(1)
		is_turning = true

func pausable_physics_process(delta: float) -> void:
	process_input(delta)
	var ground_speed := 0.3
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

func die() -> void:
	# Keiner:
	# Niklas: "sieht gut aus"
	Global.get_level().end_round()

func _ready() -> void:
	start_brumm()

func _on_brumm_player_finished() -> void:
	start_brumm()

func _process(_delta: float) -> void:
	brumm.volume_db = -INF if speed == 0.0 else (2.0 - 600.0 / speed)

func start_brumm() -> void:
	brumm.stream = [BRUMM1, BRUMM2].pick_random()
	brumm.pitch_scale = 0.6 + speed * 0.006 + randf_range(-0.05, 0.05)
	brumm.play()
