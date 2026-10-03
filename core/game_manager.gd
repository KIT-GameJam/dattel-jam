class_name GameManager
extends Node

const game_scene: PackedScene = preload("res://core/game.tscn")

@onready var game_container: Node = $Game
@onready var title_screen_canvas: CanvasLayer = $TitleScreenCanvas
@onready var pause_menu: CanvasLayer = $PauseMenu

var current_game: Game

func _ready() -> void:
	if Global.DEBUG: start()

func disable_title_screen() -> void:
	title_screen_canvas.hide()
	title_screen_canvas.process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED

func return_to_title_screen() -> void:
	unpause()
	title_screen_canvas.show()
	title_screen_canvas.process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
	game_container.remove_child(current_game)
	current_game.queue_free()
	current_game = null

func start() -> void:
	if current_game != null: return
	disable_title_screen()
	pause_menu.hide()
	get_tree().paused = false
	current_game = game_scene.instantiate()
	game_container.add_child(current_game)

func pause() -> void:
	pause_menu.show()
	get_tree().paused = true

func unpause() -> void:
	pause_menu.hide()
	get_tree().paused = false
