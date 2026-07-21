extends Node
# will be responsible for connecting the top level componenet of
# the game. So for now, the signals connecting the players and 
# game manager

@onready var player_1: playerType = $Players/Player1
@onready var player_2: playerType = $Players/Player2
@onready var game_manager: gameManager = $GameManager
@onready var turn_manager: turnManager = $TurnManager



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1.on_card_snap_cont.connect(game_manager._request_card_play)
	player_2.on_card_snap_cont.connect(game_manager._request_card_play)
	
	player_1.request_turn_end.connect(game_manager._request_end_turn)
	player_2.request_turn_end.connect(game_manager._request_end_turn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
