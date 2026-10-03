extends Node
class_name Game

var round: int = 0

const level_scene: PackedScene = preload("res://core/level.tscn")
var level: Level

func _ready() -> void:
	_reload_level()

func _reload_level() -> void:
	if level:
		level.queue_free()
	level = level_scene.instantiate()
	add_child(level)
