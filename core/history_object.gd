extends CharacterBody2D

class_name HistoryObject

var _history: Array [HistoryEntry] = []
var _read_index: int = 0

@export var uses_ghost_shader := true

func _ready() -> void:
	if not uses_ghost_shader:
		material = null

func get_timestamp() -> float:
	return Global.get_timestamp()

func reset_read_index():
	_read_index = 0

func is_race_started() -> bool:
	return Global.get_game().is_race_started

func pausable_physics_process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_race_started():
		pausable_physics_process(delta)

func write_history():
	var entry: HistoryEntry = HistoryEntry.new(
		get_timestamp(),
		global_position,
		global_rotation)
	_history.append(entry)

func _get_history_entry() -> HistoryEntry:
	return _history[_read_index] if _read_index < len(_history) else null

func read_history() -> UnpackedHistoryEntry:
	var current_entry: HistoryEntry = _get_history_entry()
	var timestamp = get_timestamp()
	while current_entry and timestamp >= current_entry.timestamp:
		_read_index += 1
		current_entry = _get_history_entry()
	var vel: Vector2 = Vector2.ZERO
	var rot: float = global_rotation
	if current_entry:
		var delta_t = current_entry.timestamp - timestamp
		vel = (current_entry.pos - global_position)/delta_t
		# rot = (current_entry.rot - global_rotation)/delta_t # fehlerbehaftet
		rot = current_entry.rot
	return UnpackedHistoryEntry.new(vel, rot)

func set_history(hist: Array [HistoryEntry]):
	_history = hist
func get_history() -> Array [HistoryEntry]:
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
