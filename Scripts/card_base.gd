extends Control

@export var card_data: CardData 
@export var ID: int
@export var cardID: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ID = 0 # temporary placeholder
	cardID = card_data.cardID
	
	$Artwork.texture = card_data.artWork
	$Name.text = card_data.name
	$Description.text = card_data.description
	$HealthLabel.text = card_data.healthStat
	$AttackLabel.text = card_data.attackStat
