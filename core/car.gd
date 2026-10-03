extends CharacterBody2D

const SPEED := 300.0
const ROTATION_SPEED := 3.0
var history: Array [CarHistoryEntry]

func _ready() -> void:
	history = []

func turn_left(angle: float) -> void:
	rotation -= angle

func turn_right(angle: float) -> void:
	rotation += angle

func _physics_process(_delta: float) -> void:
	velocity = Vector2(0, -1).rotated(rotation) * SPEED
	move_and_slide()

class CarHistoryEntry:
	var timestamp: float
	var pos: Vector2
	var rot: float
	# var visual_flag: int # for additional visual information (e.g.animation frame)
