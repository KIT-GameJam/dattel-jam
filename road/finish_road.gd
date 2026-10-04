class_name FinishRoad
extends Road

@onready var start_marker: Marker2D = $StartMarker
var active := false

func _on_finish_line_body_entered(body: Node2D) -> void:
	if active and body is PlayerCar:
		Global.get_game().end_level()
	elif active:
		Global.get_game().game_over("You were your own enemy")

func _on_finish_line_body_exited(body: Node2D) -> void:
	if body is PlayerCar:
		active = true
