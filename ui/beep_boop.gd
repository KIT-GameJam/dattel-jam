extends CanvasLayer

@onready var container: Control = $VBoxContainer/TrafficLightContainer
@onready var label: Label = $VBoxContainer/Label
@onready var timer: Timer = $Timer
@onready var beep: AudioStreamPlayer = $Beep
@onready var beeeeeeeeeeep: AudioStreamPlayer = $Beeeeeeeeeeep
var traffic_lights: Array[TrafficLight] = []
var step := 0
var is_done := false

func _ready() -> void:
	if Global.DEBUG:
		# reduce wait time in debug mode
		timer.wait_time = 0.4
	timer.start()
	traffic_lights.assign(container.get_children())

func update_text(val: String) -> void:
	label.text = "Neuer Geist erschienen: " + val

func _next_level():
	if is_done:
		var tween := create_tween()
		container.offset_transform_enabled = true
		tween.tween_property(container, "offset_transform_scale:y", 0.0, 0.15)
		tween.tween_callback(queue_free)
		return
	step += 1
	if step >= len(traffic_lights) - Global.get_stage()*1.25:
		Global.start_timestamping()
	if step <= len(traffic_lights):
		beep.play()
		traffic_lights[len(traffic_lights) - step].make_red()
	else:
		beeeeeeeeeeep.play()
		for light in traffic_lights:
			light.make_green()
			Global.get_game().start_race()
			is_done = true
