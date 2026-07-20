extends Node

@onready var draw_pile: draw_pile = $DrawPile
@onready var player_hand: Node2D = $PlayerHand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_connect_to_hand()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _player_connect_to_hand() -> void:
	draw_pile._connect_to_hand(player_hand)


#func _player_connect_to_board() -> void:
#	player_board._connect_to_board(...)
