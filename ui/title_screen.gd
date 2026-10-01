extends Control

func on_exit_button_clicked() -> void:
	get_tree().quit()

# Handle URL clicks. Godot doesn't do this by default.
func _on_footer_text_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
