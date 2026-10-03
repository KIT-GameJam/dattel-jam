extends Node
class_name Game

@onready var overlay: Overlay = $Overlay

var stage: int = 0:
	set(val):
		stage = val
		if overlay != null:
			overlay.sync_stage(val)
var max_stages = 3

const level_scene: PackedScene = preload("res://core/level.tscn")
const ready_scene: PackedScene = preload("res://ui/ready_ui.tscn")
var level: Level
var ready_ui: Node
const player_scene: PackedScene = preload("res://core/player_car.tscn")
const car_scene: PackedScene = preload("res://core/car.tscn")
var player: HistoryObject
var cars: Array [HistoryObject] = []

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
		
	level.process_mode = Node.PROCESS_MODE_DISABLED

	ready_ui = ready_scene.instantiate()
	add_child(ready_ui)

func _start_level() -> void:
	ready_ui.queue_free()
	level.process_mode = Node.PROCESS_MODE_INHERIT

func _end_level() -> void:
	stage += 1
	cars.pop_back()
	var new_car: HistoryObject =  car_scene.instantiate()
	new_car.set_history(player.get_history())
	for c in cars:
		level.remove_child(c)
	player.queue_free()
	cars.append(new_car)
	if stage <= max_stages:
		_reload_level()
	else:
		pass
		# end_screen()
