extends Control
class_name card_slot

var occupied: bool
var spotID: int #0 to 4 player 1, 5 to 9 for player 2
@export var slotSnap: bool
@export var cardHeld: card_base

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
