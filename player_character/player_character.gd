extends Node2D

signal move_logic_changed

const PlayerController = preload('res://player_character/player_controller.gd')
var controller : PlayerController

@export
var move_logic : MoveLogic:
	set = set_move_logic


func _enter_tree() -> void:
	controller = load('res://player_character/player_controller.tres')
	controller.character = self
	go_to_cell(get_current_cell())

func _exit_tree() -> void:
	if controller.character == self:
		controller.character = null

func set_move_logic(value : MoveLogic) -> void:
	if value != move_logic:
		if move_logic:
			move_logic.changed.disconnect(move_logic_changed.emit)
		move_logic = value
		if move_logic:
			move_logic.changed.connect(move_logic_changed.emit)

func get_current_cell() -> Vector2i:
	return Vector2i(position.snapped(G.CELL) / Vector2(G.CELL))

func go_to_cell(cell : Vector2i) -> void:
	position = cell * G.CELL_SIZE
