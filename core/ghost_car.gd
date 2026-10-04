class_name GhostCar
extends HistoryObject

@export var ghost_name: String

func _physics_process(_delta: float) -> void:
	if Global.get_timestamp() <= 0: return
	var unpackedHistoryEntry: UnpackedHistoryEntry = read_history()
	global_rotation = unpackedHistoryEntry.rot
	velocity = unpackedHistoryEntry.vel
	move_and_slide()
