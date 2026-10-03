extends CanvasLayer

func _ready() -> void:
	$Button.grab_focus()

func _on_button_pressed() -> void:
	Global.get_game()._start_level()
