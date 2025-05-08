@tool
extends Node2D

signal availabled_cells_changed

@export
var patterns : Array[MoveLogicPattern]:
	set(value):
		patterns = value
		notify_property_list_changed()
		availabled_cells_changed.emit()

var enabled_patterns : Array[MoveLogicPattern]:
	set(value):
		enabled_patterns = value
		availabled_cells_changed.emit()

var editor_enabled_pattern : int = 0:
	set(value):
		editor_enabled_pattern = value
		if editor_enabled_pattern >= 0 and patterns.size():
			enabled_patterns = [patterns[editor_enabled_pattern]]
		else:
			enabled_patterns = []


func _enter_tree() -> void:
	position = position.snapped(G.CELL)

func _validate_property(property: Dictionary) -> void:
	if property.name == &'editor_enabled_pattern':
		property.usage = (property.usage as int) | PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
		property.hint = PROPERTY_HINT_ENUM
		var hint_string : String
		for i in patterns.size():
			var pattern_name : String = 'None'
			if patterns[i]:
				pattern_name = MoveLogicPattern.Pattern.find_key(patterns[i].pattern)
			hint_string += '%s %s:%s,' % [i+1, pattern_name, i]
		property.hint_string = hint_string.erase(hint_string.length() - 1)


func can_go_to_cell(cell : Vector2i) -> bool:
	if cell in get_available_cells():
		return true
	
	## TODO добавить поддержку не только диагональных и ортогональных направлений
	for dir in get_available_directions():
		#var ang : float = Vector2(dir).angle()
		#if is_zero_approx(ang) or is_equal_approx(wrap(ang, 0, PI / 4), PI / 4.0):
		if is_zero_approx(Vector2(dir).angle_to(Vector2(cell))):
			return true
	
	return false

func go_to_cell(cell : Vector2i) -> void:
	if can_go_to_cell(cell):
		position = get_current_cell() + cell * G.CELL_SIZE

func get_current_cell() -> Vector2i:
	return position.snapped(G.CELL)

func get_available_cells() -> Array[Vector2i]:
	var cells : Dictionary[Vector2i, bool]
	for pattern in get_enabled_patterns():
		for cell in pattern.get_available_cells():
			cells[cell] = true
	return cells.keys()

func get_available_directions() -> Array[Vector2i]:
	var cells : Dictionary[Vector2i, bool]
	for pattern in get_enabled_patterns():
		for cell in pattern.get_available_directions():
			cells[cell] = true
	return cells.keys()

func get_enabled_patterns() -> Array[MoveLogicPattern]:
	var to_remove : Array[MoveLogicPattern]
	for pattern in enabled_patterns:
		if not pattern in patterns:
			to_remove.append(pattern)
	
	for pattern in to_remove:
		enabled_patterns.erase(pattern)
	
	if to_remove:
		push_error('')
	
	return enabled_patterns
