extends Node2D
class_name draw_pile

const CARD_MODEL = preload("res://Scenes/card_base_2D.tscn")

# TO DO: add player object class
# var playerOwnership: player
# order matters, will draw from position 0 of array
var cardList: Array[card_base_2D]
var numCards: int = 0
@onready var num_card_label: Label = $UI/NumCardLabel
var connectedHand: player_hand


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _connect_to_hand(funcConnectedHand: player_hand):
	connectedHand = funcConnectedHand


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	num_card_label.text = str(numCards)

func _draw_card() -> void:
	if numCards == 0:
		return
	var drawnCard = cardList.pop_front()
	connectedHand._add_card_hand(drawnCard)
	numCards = numCards - 1

# add a card to the pile
func _add_card(cardAddedID: int) -> void:
	var requestedData: CardData = GlobalCardList._card_request(cardAddedID)
	var newDeckCard: card_base_2D = CARD_MODEL.instantiate()
	newDeckCard._initialize(requestedData)
	cardList.append(newDeckCard)
	numCards = numCards + 1

func _shuffle() -> void:
	randomize()
	cardList.shuffle()

# for testing below:
# test add
func _on_testing_button_pressed() -> void:
	_add_card(0)

# test draw
func _on_test_draw_pressed() -> void:
	_draw_card()
