class_name PlayerController
extends Resource

const PlayerCharacter = preload('res://player_character/player_character.gd')

signal cursor_moved

var character : PlayerCharacter

var cursor_cell : Vector2i:
	set(value):
		if cursor_cell != value:
			cursor_cell = value
			cursor_moved.emit()


func move_cursor(relative : Vector2i) -> void:
	cursor_cell += relative

func move_to_cursor() -> void:
	if character and character.move_logic:
		if character.move_logic.is_cell_availabled(cursor_cell):
			character.go_to_cell(character.get_current_cell() + cursor_cell)
			cursor_cell = Vector2i()
