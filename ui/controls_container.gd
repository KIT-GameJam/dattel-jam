class_name ControlsContainer
extends PanelContainer

const FADE_TIME := 0.14

const settings_screen_controls: PackedScene = preload("res://ui/settings_controls.tscn")

@export var initial_controls_scene: PackedScene

var ui_stack: Array[Control] = []
var current: Control = null
var changing_controls := false

func _ready() -> void:
	set_control(initial_controls_scene.instantiate())

func set_control(new: Control) -> void:
	current = new
	current.controls_container = self
	add_child(current)

func remove_control_async() -> Control:
	var tween := create_tween()
	current.offset_transform_enabled = true
	tween.tween_property(current, "offset_transform_scale", Vector2.ZERO, FADE_TIME)
	await tween.finished
	var old := current
	remove_child(old)
	current = null
	return old

func set_control_async(control: Control):
	control.offset_transform_enabled = true
	control.offset_transform_scale = Vector2.ZERO
	set_control(control)
	var tween := create_tween()
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
	(await remove_control_async()).queue_free()
	var new: Control = ui_stack.pop_back()
	await set_control_async(new)
	changing_controls = false

func pop_controls() -> void:
	pop_controls_async.call_deferred()
