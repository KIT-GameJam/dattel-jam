extends Node2D
class_name Level

@onready var walz: Path2D = $Walze
var goal: FinishRoad
var timestamp: float = 0.0

func _ready() -> void:
	goal = find_children("*", "FinishRoad").get(0)
	create_joined_path()

func end_round():
	pass

func start_new_round():
	pass

func get_timestamp() -> float:
	return timestamp

func get_start_position() -> Vector3:
	return Vector3(goal.start_marker.global_position.x, goal.start_marker.global_position.y, goal.global_rotation)

func create_joined_path() -> void:
	var roads: Array[Road] = []
	for road: Road in find_children("*", "Road"):
		if road != goal:
			roads.append(road)

	var sorted_positions := PackedVector2Array()
	sorted_positions.append(goal.global_position)
	while not roads.is_empty():
		var last_pos := sorted_positions[-1]
		var min_dist := INF
		var closest_road_idx := -1
		for i in range(len(roads)):
			var dist := roads[i].global_position.distance_squared_to(last_pos)
			if dist < min_dist:
				min_dist = dist
				closest_road_idx = i
		sorted_positions.append(roads.pop_at(closest_road_idx).global_position)

	var num_positions := len(sorted_positions)
	for i in range(num_positions + 1):
		var i_prev := (i - 1 + num_positions) % num_positions
		var i_next := (i + 1) % num_positions
		var pos := sorted_positions[i % num_positions]
		var p_in := sorted_positions[i_prev] - pos
		var p_out := sorted_positions[i_next] - pos
		walz.curve.add_point(pos, p_in, p_out)
	walz.curve_ready()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed_by_event("pause", event):
		Global.pause()
		get_viewport().set_input_as_handled()

func _physics_process(delta: float) -> void:
	if Global.get_game().is_race_started:
		timestamp += delta
