extends Node2D
class_name card_slot_2D

var occupied: bool
var spotID: int #0 to 4 player 1, 5 to 9 for player 2
@export var slotSnap: bool
@export var cardHeld: card_base_2D
var opposingSlot: card_slot_2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.z_index = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
