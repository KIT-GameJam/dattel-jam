extends Path2D

@export var speed := 50.0

@onready var follow: PathFollow2D = $PathFollow2D

func _physics_process(delta: float) -> void:
	follow.progress += delta * speed
