class_name MoveLogicPattern
extends Resource

enum Pattern {Rook, Horse, Elephant}

@export
var pattern : Pattern = Pattern.Rook:
	set = set_pattern


func get_available_cells() -> Array[Vector2i]:
	match pattern:
		Pattern.Horse:
			return [
				Vector2i(3, 1), Vector2i(3, -1),
				Vector2i(-3, 1), Vector2i(-3, -1),
				Vector2i(1, 3), Vector2i(-1, 3),
				Vector2i(1, -3), Vector2i(-1, -3),
			]
		
		_:
			return []

func get_available_directions() -> Array[Vector2i]:
	match pattern:
		Pattern.Rook:
			return [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
		
		Pattern.Elephant:
			return [Vector2i(1,1), Vector2i(-1,1), Vector2i(1,-1), Vector2i(-1,-1)]
		
		_:
			return []

func set_pattern(value : Pattern) -> void:
	pattern = value
	emit_changed()
