class_name TitleScreen
extends Control

@export var controls_container: PanelContainer
const FADE_TIME := 0.2

const title_screen_controls: PackedScene = preload("res://ui/title_screen_controls.tscn")
const settings_screen_controls: PackedScene = preload("res://ui/settings_controls.tscn")

var ui_stack: Array[Control] = []
var current: Control = null
var changing_controls := false

func _ready() -> void:
	set_control(title_screen_controls.instantiate())

func set_control(new: Control) -> void:
	current = new
	current.title_screen = self
	controls_container.add_child(current)

func remove_control_async() -> Control:
	var tween := get_tree().create_tween()
	current.offset_transform_enabled = true
	tween.tween_property(current, "offset_transform_scale", Vector2.ZERO, FADE_TIME)
	await tween.finished
	var old := current
	controls_container.remove_child(old)
	current = null
	return old

func set_control_async(control: Control):
	control.offset_transform_enabled = true
	control.offset_transform_scale = Vector2.ZERO
	set_control(control)
	var tween := get_tree().create_tween()
	tween.tween_property(control, "offset_transform_scale", Vector2.ONE, FADE_TIME)
	await tween.finished

func push_controls_async(new: PackedScene):
	if changing_controls: return
	changing_controls = true
	var old := await remove_control_async()
	ui_stack.push_back(old)
	await set_control_async(new.instantiate())
	changing_controls = false

func push_controls(new: PackedScene) -> void:
	push_controls_async.call_deferred(new)

func pop_controls_async() -> void:
	if changing_controls: return
	changing_controls = true
	await remove_control_async()
	var new: Control = ui_stack.pop_back()
	await set_control_async(new)
	changing_controls = false

func pop_controls() -> void:
	pop_controls_async.call_deferred()

# Handle URL clicks. Godot doesn't do this by default.
func _on_footer_text_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
