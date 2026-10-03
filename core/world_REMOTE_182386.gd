extends Node2D
class_name World

@onready var walz_pfad : Path2D = $WalzPfad
var round: int = 0
var timestamp: float = 0.0

func end_round():
	pass

func start_new_round():
	pass

func get_timestamp() -> float:
	return timestamp

func create_joined_path() -> void:
	for child: Road in find_children("*", "Road"):
		var curve = child.path.curve
		for point_idx in range(curve.point_count):
			var local_point = curve.get_point_position(point_idx)
			var global_point = child.global_transform * local_point # or global_transform.xform(local_point)
			var target_local_point = walz_pfad.global_transform.affine_inverse() * global_point

			walz_pfad.curve.add_point(
				target_local_point,
				Vector2(0, 0), # TODO handle in and out points correctly
				Vector2(0, 0),
			)

func _ready() -> void:
	create_joined_path()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed_by_event("pause", event):
		Global.game().pause()
		get_viewport().set_input_as_handled()

func _physics_process(delta: float) -> void:
	timestamp += delta
