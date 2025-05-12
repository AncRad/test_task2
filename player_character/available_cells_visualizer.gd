extends Node2D

const PlayerCharacter = preload('res://player_character/player_character.gd')

@export
var player_character : PlayerCharacter


func _draw() -> void:
	if player_character and player_character.move_logic:
		var drawed : Dictionary[Vector2i, bool]
		for cell in player_character.move_logic.get_available_cells():
			if not cell in drawed:
				drawed[cell] = true
				draw_circle(cell * G.CELL, 10, Color.GREEN)
