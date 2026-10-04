class_name Explosion
extends Node2D

var animation_finished := false
var audio_finished := false

func _on_animated_sprite_2d_animation_finished() -> void:
	animation_finished = true
	create_tween().tween_property(self, "modulate:a", 0.0, 1.0)

func _on_audio_stream_player_2d_finished() -> void:
	audio_finished = true

func _process(_delta: float) -> void:
	if audio_finished and animation_finished:
		queue_free()
