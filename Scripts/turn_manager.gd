extends Node
class_name turnManager

@onready var player_1: playerType = $"../Players/Player1"
@onready var player_2: playerType = $"../Players/Player2"
@onready var game_manager: gameManager = $"../GameManager"

var curPlayerTurn: playerType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random = randi_range(0, 1)
	if random:
		curPlayerTurn = player_1
		print("Go player 1!")
	else:
		curPlayerTurn = player_2
		print("Go player 2!")


func _end_turn() -> void:
	if curPlayerTurn == player_1: # now P2 turn
		curPlayerTurn = player_2
		game_manager._on_turn_end(player_1)
		game_manager._on_turn_start(player_2)
	else:
		curPlayerTurn = player_1 # now P1 turn
		game_manager._on_turn_end(player_2)
		game_manager._on_turn_start(player_1)
	
	# signals here later maybe
