extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed_by_event("pause", event):
		Global.game().pause()
		get_viewport().set_input_as_handled()
