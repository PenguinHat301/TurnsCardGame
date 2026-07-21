extends Node2D
class_name draw_pile

# for testing, holds number of current complete resources
var numTotalCards = 2

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
	# temporary, add 10 random cards to each deck on ready
	for i in 10:
		var random = randi_range(0, 1)
		randomize()
		_add_card(random)


func _connect_to_hand(funcConnectedHand: player_hand):
	connectedHand = funcConnectedHand


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	var whatCard = randi_range(0, numTotalCards - 1)
	_add_card(whatCard)

# test draw
func _on_test_draw_pressed() -> void:
	_draw_card()
