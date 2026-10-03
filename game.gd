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
	level.get_start_position()
	add_child(level)
	ready_ui = ready_scene.instantiate()
	add_child(ready_ui)
	level.process_mode = Node.PROCESS_MODE_DISABLED

func _start_level() -> void:
	ready_ui.queue_free()
	level.process_mode = Node.PROCESS_MODE_INHERIT

func _end_level() -> void:
	pass
