extends Node2D

var linkedDrawPile

#dimension if important for later:
# x = 1500
# y = 300

var cardList: Array[card_base_2D] = []
var numCards: int = 0
const CENTER = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _add_card_hand(newCard: card_base_2D) -> void:
	cardList.append(newCard)
	self.add_child(newCard)
	numCards = numCards + 1
	_update_hand_visual()

# where is it going?
func _remove_card_hand(newCard: card_base_2D) -> void:
	numCards = numCards - 1
	pass


@export var max_hand_width: float = 1400.0
@export var normal_spacing: float = 150.0
@export var minimum_spacing: float = 60.0
func _update_hand_visual() -> void:
	var curSpacing = normal_spacing
	if numCards * normal_spacing > max_hand_width:
		curSpacing = max_hand_width / numCards
	var total_width = numCards * curSpacing
	var start_x = -total_width / 2
	for cur in range(numCards):
		var card = cardList[cur]
		card.position = Vector2(start_x + cur * curSpacing, 0)
		
