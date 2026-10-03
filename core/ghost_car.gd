extends HistoryObject

func pausable_physics_process(_delta: float) -> void:
	var unpackedHistoryEntry: UnpackedHistoryEntry = read_history()
	global_rotation = unpackedHistoryEntry.rot
	velocity = unpackedHistoryEntry.vel
	move_and_slide()
