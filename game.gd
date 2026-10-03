extends Node
class_name Game

var round: int = 0
var max_rounds = 3

const level_scene: PackedScene = preload("res://core/level.tscn")
const ready_scene: PackedScene = preload("res://ui/ready_ui.tscn")
var level: Level
var ready_ui: Node
const player_scene: PackedScene = preload("res://core/player_car.tscn")
const car_scene: PackedScene = preload("res://core/car.tscn")
var player: HistoryObject
var cars: Array [HistoryObject]

func _ready() -> void:
	_reload_level()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("temp_reach_goal"):
		_end_level()

func _reload_level() -> void:
	if level:
		level.queue_free()
	level = level_scene.instantiate()
	add_child(level)
	level.process_mode = Node.PROCESS_MODE_DISABLED
	var temp = level.get_start_position()
	var start_pos = Vector2(temp.x, temp.y)
	var start_rot = temp.z + PI/2
	player = player_scene.instantiate()
	cars.append(player)
	for c in cars:
		c.global_position = start_pos
		c.global_rotation = start_rot
		level.add_child(c)
		c.reset_read_index()
	ready_ui = ready_scene.instantiate()
	add_child(ready_ui)

func _start_level() -> void:
	ready_ui.queue_free()
	level.process_mode = Node.PROCESS_MODE_INHERIT

func _end_level() -> void:
	cars.pop_back()
	var new_car: HistoryObject =  car_scene.instantiate()
	cars.append(new_car)
	new_car.set_history(player.get_history())
	player.queue_free()
	for c in cars:
		level.remove_child(c)
	_reload_level()
