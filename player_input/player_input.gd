extends Node

@export
var player_controller : PlayerController:
	set(value):
		player_controller = value
		print("SETTER: value == ", value)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('grid_cursor_move_up'):
		player_controller.move_cursor(Vector2i.UP)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_move_left'):
		player_controller.move_cursor(Vector2i.LEFT)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_move_down'):
		player_controller.move_cursor(Vector2i.DOWN)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_move_right'):
		player_controller.move_cursor(Vector2i.RIGHT)
		get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed('grid_cursor_click'):
		player_controller.move_to_cursor()
		get_viewport().set_input_as_handled()
