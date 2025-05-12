class_name MoveLogic
extends Resource

@export
var patterns : Array[MoveLogicPattern]:
	set(value):
		patterns = value
		patterns_reconnect()
		emit_changed()

var _connected_patterns : Array[MoveLogicPattern]


func get_available_cells() -> Array[Vector2i]:
	var cells : Dictionary[Vector2i, bool]
	for pattern in get_enabled_patterns():
		for cell in pattern.get_available_cells():
			cells[cell] = true
	return cells.keys()

func get_enabled_patterns() -> Array[MoveLogicPattern]:
	var enabled_patterns : Array[MoveLogicPattern]
	for pattern in patterns:
		if pattern.enabled:
			enabled_patterns.append(pattern)
	return enabled_patterns

func is_cell_availabled(cell : Vector2i) -> bool:
	return cell in get_available_cells()

func patterns_reconnect() -> void:
	for pattern in _connected_patterns:
		pattern.changed.disconnect(emit_changed)
	_connected_patterns.clear()
	for pattern in patterns:
		pattern.changed.connect(emit_changed)
		_connected_patterns.append(pattern)
