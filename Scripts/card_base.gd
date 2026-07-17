extends Control

# Information about the card type and instantiation
@export var card_data: CardData 
@export var ID: int
@export var cardID: int

# var current location?
var originalPosition: Vector2 
var isHovered: bool
var isDragging: bool
var curDragOffset: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ID = 0 # temporary placeholder
	cardID = card_data.cardID
	
	$Artwork.texture = card_data.artWork
	$Name.text = card_data.name
	$Description.text = card_data.description
	$HealthLabel.text = card_data.healthStat
	$AttackLabel.text = card_data.attackStat


func _process(delta: float) -> void:
	if self.isDragging:
		self.global_position = get_global_mouse_position() - curDragOffset


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				self.isDragging = true
				self.z_index = 100
				self.curDragOffset = get_global_mouse_position() - global_position
				print("card clicked!")
			elif self.isDragging:
				self.isDragging = false
				self.z_index = 0
				self.curDragOffset = Vector2.ZERO
				print("stopped hold")

func _on_Card_mouse_entered() -> void:
	self.z_index = 100
	self.scale = Vector2(1.0,1.0)


func _on_Card_mouse_exited() -> void:
	self.z_index = 0
	self.scale = Vector2(0.8,0.8)
