extends Node2D

const PlayerCharacter = preload('res://player_character/player_character.gd')

@export
var player_character : PlayerCharacter


func _draw() -> void:
	var drawed : Dictionary[Vector2i, bool]
	for cell in player_character.get_available_cells():
		if not cell in drawed:
			drawed[cell] = true
			draw_circle(cell * G.CELL, 10, Color.GREEN)
	
	for dir in player_character.get_available_directions():
		for i in 500:
			var cell : Vector2i = dir * i
			if not Rect2(-get_viewport().size / 2, get_viewport().size).has_point(position + Vector2(cell * G.CELL)):
				break
			if not cell in drawed:
				drawed[cell] = true
				draw_circle(cell * G.CELL, 10, Color.GREEN)
	
	print('drawed cells', drawed.size())
