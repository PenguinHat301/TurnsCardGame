extends Node

var cardList: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_register_cards()

# use this as a format for adding new cards:
# _addCard(load(Addr_here))
func _register_cards():
	_addCard(load("res://Resources/Chimpy.tres")) # 0
	_addCard(load("res://Resources/SkaterG8r.tres")) # 1

func _addCard(card: CardData):
	cardList[card.cardID] = card

# Input a card global ID, return cardData of that cardqw
func _card_request(IDRequested: int) -> CardData:
	var newCardData: CardData = cardList[IDRequested]
	return newCardData
