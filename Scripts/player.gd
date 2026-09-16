extends Node
class_name playerType

# Players children it can manage
@onready var draw_pile: draw_pile = $DrawPile
@onready var player_hand:  player_hand = $PlayerHand
@onready var player_board:  player_board = $PlayerBoard
@onready var end_turn: Button = $EndTurn
@onready var turn_count: Label = $TurnCount

@export var turnsLeft = 5

# one last passup to game manager
signal on_card_snap_cont(cardPlayed: card_base_2D, slotWanted: card_slot_2D, curPlayer: playerType)
# sends request to game manager to end current turn
signal request_turn_end(curPlayer)
# sends request to game manager to INFLICT damage
signal request_doing_damage(curPlayer)
# sends a signal to the game manager to end the game. THE SENDER LOST
signal losing_player(curPlayer)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_connect_to_hand()
	player_hand._on_card_snap_cont.connect(_board_valid_check)
	turn_count.set_new(turnsLeft)


func _player_connect_to_hand() -> void:
	draw_pile._connect_to_hand(player_hand)


func _board_valid_check(cardRequested: card_base_2D, slotWanted: card_slot_2D, curPlayer: playerType) -> void:
	on_card_snap_cont.emit(cardRequested, slotWanted, curPlayer)
	print ("checking")
	pass

func _take_turn_damage():
	turnsLeft = turnsLeft - 1
	# Ending your turn, or taking damage to set turns under 0, emit game ending signal
	if turnsLeft < 0:
		losing_player.emit(self)
	turn_count.set_new(turnsLeft)

func _deal_turn_damage():
	request_doing_damage.emit(self)
	pass

func _on_end_turn_pressed() -> void:
	request_turn_end.emit(self)
