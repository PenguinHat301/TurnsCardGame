extends Node

@onready var player_1: playerType = $"../Players/Player1"
@onready var player_2: playerType = $"../Players/Player2"
@onready var turn_manager: turnManager = $"../TurnManager"

# This Script will likely handle all play card requests from 
# each player. Player 1 requests action, check with turn manager
# to make sure they are allowed to do that.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _request_card_play(player: playerType) -> bool:
	# your turn?
	# your slot?
	# occupied?
	return false


func _request_end_turn(player: playerType) -> bool:
	return false


func _game_end_turn() -> bool:
	turn_manager._end_turn()
	return false


# Will ensure certain special cards are activating their
# start of turn behavior
# for Ex: on start of turn, deal 1 damage, etc...
func _on_turn_start(player: playerType) -> void:
	pass


# Will ensure certain special cards are activating their
# start of turn behavior
# for Ex: on end of turn, deal 1 damage, etc...
func _on_turn_end(player: playerType) -> void:
	pass


func _end_game(player: playerType) -> void:
	pass
