extends Node

signal grid_cursor_move(relative : Vector2i)
signal grid_cursor_click


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('grid_cursor_move_up'):
		grid_cursor_move.emit(Vector2i.UP)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_move_left'):
		grid_cursor_move.emit(Vector2i.LEFT)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_move_down'):
		grid_cursor_move.emit(Vector2i.DOWN)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_move_right'):
		grid_cursor_move.emit(Vector2i.RIGHT)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_click'):
		grid_cursor_click.emit()
		get_viewport().set_input_as_handled()
