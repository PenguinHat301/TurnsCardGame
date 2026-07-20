extends Node2D
class_name player_board

@onready var card_slot_0: card_slot_2D = $CardSlot
@onready var card_slot_1: card_slot_2D = $CardSlot2
@onready var card_slot_2: card_slot_2D = $CardSlot3
@onready var card_slot_3: card_slot_2D = $CardSlot4
@onready var card_slot_4: card_slot_2D = $CardSlot5

var slot_list: Array[card_slot_2D] = \
[card_slot_0, card_slot_1, card_slot_2, card_slot_3, card_slot_4]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _owns_slot(slot: card_slot_2D) -> bool:
	return slot in slot_list
