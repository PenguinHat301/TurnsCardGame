extends Node2D
class_name player_board

@onready var card_slot_0: card_slot_2D = $CardSlot
@onready var card_slot_1: card_slot_2D = $CardSlot2
@onready var card_slot_2: card_slot_2D = $CardSlot3
@onready var card_slot_3: card_slot_2D = $CardSlot4
@onready var card_slot_4: card_slot_2D = $CardSlot5

var slot_list: Array[card_slot_2D] 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot_list = \
	[card_slot_0, card_slot_1, card_slot_2, card_slot_3, card_slot_4]


func _owns_slot(slot: card_slot_2D) -> bool:
	return slot in slot_list


func _place_in_slot(cardPlayed: card_base_2D, slot: card_slot_2D):
	var curSlot = slot_list.find(slot) # returns index
	slot_list[curSlot].cardHeld = cardPlayed
	slot_list[curSlot].occupied = true
	cardPlayed.global_position = slot.global_position
	cardPlayed.z_index = 5


func _connect_opposing_slots(opposingBoard: player_board) -> void:
	for i in 5:
		var curSlot = self.slot_list[i]
		var curOpposingSlot = opposingBoard.slot_list[i]
		curSlot.opposingSlot = curOpposingSlot
		curOpposingSlot.opposingSlot = curSlot

func _card_attack_wave() -> void:
	var cardInSlot: card_base_2D
	var cardAttack: int
	for cur in slot_list:
		if !cur.occupied:
			continue
		cardInSlot = cur.cardHeld
		cardAttack = cardInSlot._attack_info()
		# if no opposing slot
		if cur.opposingSlot.occupied == false:
			# TODO - Make it so players take damage
			continue 
		# opposing slot not empty
		if cur.opposingSlot.cardHeld._take_damage(cardAttack):
			# if opposing card dies
			cur.opposingSlot.occupied = false
