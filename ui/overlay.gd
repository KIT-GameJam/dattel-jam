extends CanvasLayer

func _ready() -> void:
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
