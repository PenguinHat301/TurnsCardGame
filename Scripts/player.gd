extends Node
class_name playerType

@onready var draw_pile: draw_pile = $DrawPile
@onready var player_hand:  player_hand = $PlayerHand
@onready var player_board:  player_board = $PlayerBoard
@onready var end_turn: Button = $EndTurn


# one last passup to game manager
signal on_card_snap_cont(cardPlayed: card_base_2D, slotWanted: card_slot_2D, curPlayer: playerType)
signal request_turn_end(curPlayer)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_connect_to_hand()
	player_hand._on_card_snap_cont.connect(_board_valid_check)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _player_connect_to_hand() -> void:
	draw_pile._connect_to_hand(player_hand)


#func _player_connect_to_board() -> void:
#	player_hand._connect_to_board(...)

func _board_valid_check(cardRequested: card_base_2D, slotWanted: card_slot_2D, curPlayer: playerType) -> void:
	on_card_snap_cont.emit(cardRequested, slotWanted, curPlayer)
	print ("checking")
	pass


func _on_end_turn_pressed() -> void:
	request_turn_end.emit(self)
