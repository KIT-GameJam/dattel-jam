class_name FinishRoad
extends Road

@onready var start_marker: Marker2D = $StartMarker
var active := false

func _on_finish_line_body_entered(body: Node2D) -> void:
	if active and body is PlayerCar:
		Global.get_game().end_level()
