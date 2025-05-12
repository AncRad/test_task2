class_name MoveLogicPattern
extends Resource

enum Pattern {Rook, Horse, Elephant}

@export
var pattern : Pattern = Pattern.Rook:
	set = set_pattern

@export
var enabled : bool:
	set = set_enabled

@export_range(0, 20, 1, 'suffix:cells')
var directional_distance : int = 10:
	set = set_directional_distance


func set_pattern(value : Pattern) -> void:
	pattern = value
	emit_changed()

func set_enabled(value : bool) -> void:
		if enabled != value:
			enabled = value
			emit_changed()

func set_directional_distance(value : int) -> void:
	value = clamp(value, 0, 20)
	if directional_distance != value:
		directional_distance = value
		if pattern in [Pattern.Rook, Pattern.Elephant]:
			emit_changed()

func get_available_cells() -> Array[Vector2i]:
	match pattern:
		Pattern.Horse:
			return [
				Vector2i(3, 1), Vector2i(3, -1),
				Vector2i(-3, 1), Vector2i(-3, -1),
				Vector2i(1, 3), Vector2i(-1, 3),
				Vector2i(1, -3), Vector2i(-1, -3),
			]
		
		Pattern.Rook:
			var cells : Array[Vector2i]
			for dir in [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]:
				for i in directional_distance:
					cells.append(dir * (i + 1))
			return cells
		
		Pattern.Elephant:
			var cells : Array[Vector2i]
			for dir in [Vector2i(1,1), Vector2i(-1,1), Vector2i(1,-1), Vector2i(-1,-1)]:
				for i in directional_distance:
					cells.append(dir * (i + 1))
			return cells
		
		_:
			return []
