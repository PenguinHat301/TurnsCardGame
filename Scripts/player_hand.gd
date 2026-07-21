extends Node2D
class_name player_hand

var linkedDrawPile

#dimension of hand if important for later:
# x = 1500
# y = 300

var cardList: Array[card_base_2D] = []
var numCards: int = 0
const CENTER = Vector2(0.0, 0.0)

signal _on_card_snap_cont(cardPlayed: card_base_2D, slotWanted: card_slot_2D, curPlayer: playerType)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _add_card_hand(newCard: card_base_2D) -> void:
	cardList.append(newCard)
	self.add_child(newCard)
	newCard.cardSnapping.connect(_on_card_snap)
	numCards = numCards + 1
	_update_hand_visual()

func _remove_card_hand(ridCard: card_base_2D) -> void:
	cardList.erase(ridCard)
	numCards = numCards - 1
	_update_hand_visual()



func _on_card_snap(cardPlayed: card_base_2D, slotWanted: card_slot_2D, curPlayer: playerType):
	print("gets to hand call up")
	_on_card_snap_cont.emit(cardPlayed, slotWanted, curPlayer)


@export var max_hand_width: float = 1300
@export var normal_spacing: float = 210
@export var minimum_spacing: float = 100.0
func _update_hand_visual() -> void:
	var curSpacing = normal_spacing
	if numCards * normal_spacing > max_hand_width:
		curSpacing = max_hand_width / numCards
	var total_width = (numCards-1) * curSpacing
	var start_x = -total_width / 2
	for cur in range(numCards):
		var card = cardList[cur]
		card.position = Vector2(start_x + cur * curSpacing, 0)
		card.originalPosition = card.global_position
