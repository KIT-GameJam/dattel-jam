class_name Game
extends Node

const world: PackedScene = preload("res://core/world.tscn")

@onready var world_container: Node = $World
@onready var title_screen_canvas: CanvasLayer = $TitleScreenCanvas
@onready var pause_menu: CanvasLayer = $PauseMenu

var current_world: World

func disable_title_screen() -> void:
	title_screen_canvas.hide()
	title_screen_canvas.process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED

func return_to_title_screen() -> void:
	unpause()
	title_screen_canvas.show()
	title_screen_canvas.process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
	world_container.remove_child(current_world)
	current_world.queue_free()
	current_world = null

func start() -> void:
	if current_world != null: return
	disable_title_screen()
	pause_menu.hide()
	get_tree().paused = false
	current_world = world.instantiate()
	world_container.add_child(current_world)

func pause() -> void:
	pause_menu.show()
	get_tree().paused = true

func unpause() -> void:
	pause_menu.hide()
	get_tree().paused = false
