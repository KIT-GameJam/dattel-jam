extends Node
class_name Game

signal race_start

@onready var overlay: Overlay = $Overlay

var stage: int = 0:
	set(val):
		stage = val
		if overlay != null:
			overlay.sync_stage(val)
var lives := 2:
	set(new_lives):
		lives = new_lives
		overlay.update_health(new_lives)

const level_scene: PackedScene = preload("res://core/level.tscn")
const ready_scene: PackedScene = preload("res://ui/ready_ui.tscn")
const traffic_light_scene: PackedScene = preload("res://ui/beep_boop.tscn")
const game_over_scene: PackedScene = preload("res://ui/game_over_screen.tscn")
const win_scene: PackedScene = preload("res://ui/win_screen.tscn")
var max_stages: int = 3
var level: Level
var ready_ui: Node
var traffic_light_ui: Node
var win_screen: Node
const player_scene: PackedScene = preload("res://core/player_car.tscn")
const ghost_car_scenes: Array[PackedScene] = [
	# preload("res://core/minen_leger.tscn"),
	preload("res://core/oel_tanker.tscn"),
]
var player: HistoryObject
var cars: Array [HistoryObject] = []
var is_race_started := false
var next_ghost_car: GhostCar = null
var game_over_message := ""

func _ready() -> void:
	_reload_level()
	overlay.update_health(lives)

func _process(_delta: float) -> void:
	if Global.DEBUG and Input.is_action_just_pressed("temp_reach_goal"):
		end_level()

func _reload_level() -> void:
	if win_screen != null:
		win_screen.queue_free()
	if level:
		level.queue_free()
		await get_tree().process_frame
	is_race_started = false
	level = level_scene.instantiate()
	add_child(level)
	var temp := level.get_start_position()
	var start_pos := Vector2(temp.x, temp.y)
	var start_rot := temp.z + PI/2
	player = player_scene.instantiate()
	cars.append(player)
	for c in cars:
		c.global_position = start_pos
		c.global_rotation = start_rot
		level.add_child(c)
		overlay.sync_stage(stage)
		c.reset_read_index()

	ready_ui = ready_scene.instantiate()
	add_child(ready_ui)

func _start_level() -> void:
	ready_ui.queue_free()
	traffic_light_ui = traffic_light_scene.instantiate()
	if next_ghost_car:
		(func(): traffic_light_ui.update_text(next_ghost_car.ghost_name)).call_deferred()
	add_child(traffic_light_ui)

func start_race() -> void:
	is_race_started = true
	race_start.emit()

func end_level(lost: bool = false) -> void:
	if lost:
		game_over()
		return
	if ready_ui:
		return
	stage += 1
	cars.pop_back()
	next_ghost_car = ghost_car_scenes.pick_random().instantiate()
	var new_car: HistoryObject = next_ghost_car
	new_car.set_history(player.get_history())
	for c in cars:
		level.remove_child(c)
	player.queue_free()
	cars.append(new_car)

	if stage == max_stages:
		max_stages = -1
		win_screen = win_scene.instantiate()
		add_child(win_screen)
	else:
		_reload_level()

func game_over(msg: String = "") -> void:
	game_over_message = msg
	add_child(game_over_scene.instantiate())
	Global.get_game_manager().pause(false)
