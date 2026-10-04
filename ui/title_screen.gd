class_name TitleScreen
extends Control

@onready var controls_container: ControlsContainer = $TopContainer/VBoxContainer/HBoxContainer/ControlsContainer

# Handle URL clicks. Godot doesn't do this by default.
func _on_footer_text_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))

func toggle_tutorial() -> void:
	$Tutorial.visible = not $Tutorial.visible
