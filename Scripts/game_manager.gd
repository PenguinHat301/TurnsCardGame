extends Node
class_name gameManager

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


func _request_card_play(cardRequest: card_base_2D, slotWanted: card_slot_2D, curPlayer: playerType) -> void:
	# your turn?
	if curPlayer != turn_manager.curPlayerTurn:
		print("not your turn (playing card)")
		cardRequest._snap_back(cardRequest)
		return
	# your slot?
	if !curPlayer.player_board._owns_slot(slotWanted):
		print("not your slot")
		cardRequest._snap_back(cardRequest)
		return
	# occupied?
	if slotWanted.occupied == true:
		print("slot occupied")
		cardRequest._snap_back(cardRequest)
		return
	cardRequest.isDraggable = false
	curPlayer.player_board._place_in_slot(cardRequest, slotWanted)
	curPlayer.player_hand._remove_card_hand(cardRequest)


func _request_end_turn(curPlayer: playerType) -> void:
	# your turn?
	if curPlayer != turn_manager.curPlayerTurn:
		print("not your turn (end turn)")
	_game_end_turn()


func _game_end_turn() -> void:
	turn_manager._end_turn()
	return


# Will ensure certain special cards are activating their
# start of turn behavior, and drawing one card.
# for Ex: on start of turn, deal 1 damage, etc...
func _on_turn_start(player: playerType) -> void:
	player.draw_pile._draw_card()


# Will ensure certain special cards are activating their
# start of turn behavior
# for Ex: on end of turn, deal 1 damage, etc...
func _on_turn_end(player: playerType) -> void:
	pass


func _end_game(player: playerType) -> void:
	pass
