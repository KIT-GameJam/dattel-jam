extends Node2D
class_name Level

@onready var walz : Path2D = $Walze
@onready var goal: Node2D = $Goal
var timestamp: float = 0.0

func _find_start_road() -> Road:
	var query := PhysicsPointQueryParameters2D.new()
	query.position = goal.global_position
	query.collide_with_areas = true
	query.collide_with_bodies = false
	return get_world_2d().direct_space_state.intersect_point(query)[0]["collider"]

func end_round():
	pass

func start_new_round():
	pass

func get_timestamp() -> float:
	return timestamp

func create_joined_path() -> void:
	var path := _find_start_road().path
	var paths: Array[Path2D] = []
	for road: Road in find_children("*", "Road"): if road.path != path: paths.append(road.path)

	while true:
		var last_point: Vector2
		for point_index in range(path.curve.point_count):
			var pos := path.curve.get_point_position(point_index)
			var pin := path.curve.get_point_in(point_index)
			var pout := path.curve.get_point_out(point_index)
			last_point = path.to_global(pos)
			walz.curve.add_point(
				last_point,
				pin,
				pout,
			)
		if not paths: break
		var min_dist := INF
		var best_path_index := -1
		for i in range(len(paths)):
			var dist := paths[i].to_global(paths[i].curve.get_point_position(0)).distance_squared_to(last_point)
			if dist < min_dist:
				min_dist = dist
				best_path_index = i
		path = paths.pop_at(best_path_index)

func _ready() -> void:
	create_joined_path()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed_by_event("pause", event):
		Global.game().pause()
		get_viewport().set_input_as_handled()

func _physics_process(delta: float) -> void:
	timestamp += delta
