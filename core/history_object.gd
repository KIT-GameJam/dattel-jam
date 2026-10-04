extends CharacterBody2D

class_name HistoryObject

var _history: Array[HistoryEntry] = []
var _read_index: int = 0

@export var uses_ghost_shader := true

func _ready() -> void:
	if not uses_ghost_shader:
		material = null

func reset():
	_read_index = 0

func write_history():
	var entry: HistoryEntry = HistoryEntry.new(
		Global.get_timestamp(),
		global_position,
		global_rotation,
	)
	_history.append(entry)

func _get_history_entry() -> HistoryEntry:
	return _history[_read_index] if _read_index < len(_history) else null

func read_history() -> UnpackedHistoryEntry:
	var timestamp := Global.get_timestamp()
	var prev_entry := _get_history_entry()
	var next_entry := prev_entry
	while next_entry and next_entry.timestamp <= timestamp:
		_read_index += 1
		prev_entry = next_entry
		next_entry = _get_history_entry()
	var vel := Vector2.ZERO
	var rot := global_rotation
	if prev_entry and next_entry:
		var delta_t := next_entry.timestamp - timestamp
		var t := (timestamp - prev_entry.timestamp) / delta_t
		vel = (next_entry.pos - global_position) / delta_t
		rot = (1.0 - t) * prev_entry.rot + t * next_entry.rot
	return UnpackedHistoryEntry.new(vel, rot)

func set_history(hist: Array[HistoryEntry]):
	_history = hist

func get_history() -> Array[HistoryEntry]:
	return _history

class HistoryEntry:
	var timestamp: float
	var pos: Vector2
	var rot: float
	# var flag: int # for additional visual information (e.g.animation frame)

	func _init(_timestamp: float ,_pos: Vector2, _rot: float) -> void:
		timestamp = _timestamp
		pos = _pos
		rot = _rot

class UnpackedHistoryEntry:
	var vel: Vector2
	var rot: float
	# var flag: int # for additional visual information (e.g.animation frame)

	func _init(_vel: Vector2, _rot: float) -> void:
		vel = _vel
		rot = _rot
