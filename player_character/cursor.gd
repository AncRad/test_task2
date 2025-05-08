extends Node2D

const PlayerCharacter = preload('res://player_character/player_character.gd')

@export
var player_character : PlayerCharacter

var cell : Vector2i


func _enter_tree() -> void:
	PlayerInput.grid_cursor_move.connect(cursor_move)
	PlayerInput.grid_cursor_click.connect(do_move)

func cursor_move(move : Vector2i) -> void:
	cell += move
	queue_redraw()

func do_move() -> void:
	player_character.go_to_cell(cell)
	queue_redraw()

func _draw() -> void:
	var rect_color : Color = Color.YELLOW
	if player_character.can_go_to_cell(cell):
		rect_color = Color.GREEN
	draw_rect(Rect2(cell * G.CELL_SIZE - G.CELL / 2, G.CELL), rect_color, false, 3)
