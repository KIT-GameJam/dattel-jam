class_name Overlay
extends CanvasLayer

const heart_img: Texture2D = preload("res://assets/heart.svg")
const MIMAP_SCALE := 0.08
const MIMAP_OFF := Vector2(60.0, 20.0)

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

func sync_minimap(walze: Walze) -> void:
	var points := PackedVector2Array()
	for i in range(walze.curve.point_count):
		points.push_back(walze.to_global(walze.curve.get_point_position(i)) * MIMAP_SCALE + MIMAP_OFF)
	$MarginContainer/PanelContainer/SubViewport/Line2D.points = points

func _process(_delta: float) -> void:
	var game := Global.get_game()
	if game == null or game.player == null: return
	$MarginContainer/PanelContainer/SubViewport/PlayerIndicator.global_position = game.player.global_position * MIMAP_SCALE + MIMAP_OFF

func sync_stage(stage: int) -> void:
	var max_stages := Global.get_game().max_stages
	var max_text: String = "∞" if (max_stages == -1) else str(max_stages)
	stage_label.text = "Round " + str(stage + 1) + "/" + max_text

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
