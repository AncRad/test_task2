extends Node2D

const PlayerCharacter = preload('player_character.gd')

@export
var player_character : PlayerCharacter


func _ready() -> void:
	PlayerInput.player_controller.cursor_moved.connect(queue_redraw)

func _draw() -> void:
	if PlayerInput.player_controller.character == player_character:
		var rect_color : Color = Color.YELLOW
		var cell := PlayerInput.player_controller.cursor_cell
		if player_character.move_logic.is_cell_availabled(cell):
			rect_color = Color.GREEN
		draw_rect(Rect2(cell * G.CELL_SIZE - G.CELL / 2, G.CELL), rect_color, false, 3)
