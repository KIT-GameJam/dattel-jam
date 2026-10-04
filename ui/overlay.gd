class_name Overlay
extends CanvasLayer

const heart_img: Texture2D = preload("res://assets/heart.svg")

@onready var stage_label: Label = $HBoxContainer/StageLabel
@onready var heart_container: Control = $HBoxContainer/HeartContainer

func _ready() -> void:
	sync_stage(0)
	if Global.DEBUG:
		var debug_label := Label.new()
		debug_label.label_settings = LabelSettings.new()
		debug_label.label_settings.font_size = 10
		debug_label.label_settings.font_color = Color.CRIMSON
		debug_label.label_settings.shadow_color = Color.BLACK
		debug_label.label_settings.shadow_size = 2
		debug_label.text = "Debug Mode"
		add_child(debug_label)
		debug_label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)

func sync_stage(stage: int) -> void:
	stage_label.text = "Round " + str(stage + 1) + "/∞"

func update_health(n: int) -> void:
	n = 0
	while heart_container.get_child_count() < n:
		var rect := TextureRect.new()
		rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		rect.texture = heart_img
		heart_container.add_child(rect)
	while heart_container.get_child_count() > n:
		heart_container.remove_child(heart_container.get_child(0))
