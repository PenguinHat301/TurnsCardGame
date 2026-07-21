extends Node2D
class_name card_base_2D

# Information about the card type and instantiation
@export var card_data: CardData 
@export var ID: int
@export var cardID: int

@onready var snap_area_self: Area2D = $SnapArea
@onready var hover_drag_area: Area2D = $HoverDragArea
var snap_area_slot: Area2D
var cardSlot: card_slot_2D
var overlappingAreas: Array[Area2D]

var originalPosition: Vector2 #position it should snap back to
var isHovered: bool
var isDragging: bool
var isDraggable: bool
var curDragOffset: Vector2 # used for moving the card

signal cardSnapping(curCard: card_base_2D, curSlot: card_slot_2D)

var curAttack: int
var curHealth: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ID = 0 # temporary placeholder
	isDraggable = true
	self.originalPosition = position
	_initialize(card_data)

func _initialize(cardData: CardData):
	self.originalPosition = Vector2(1250, 1250)
	self.card_data = cardData
	self.z_index = 5
	$Artwork.texture = cardData.artWork
	$Artwork.scale = Vector2(5.0,5.0)
	$UI/Name.text = cardData.name
	$UI/Description.text = cardData.description
	$UI/HealthLabel.text = cardData.healthStat
	$UI/AttackLabel.text = cardData.attackStat
	curAttack = cardData.attackStat.to_int()
	curHealth = cardData.healthStat.to_int()


func _process(delta: float) -> void:
	if self.isDragging:
		self.global_position = get_global_mouse_position() - curDragOffset


func _on_hover_mouse_entered() -> void:
	if GeneralManager.draggingCard != null and GeneralManager.draggingCard != self:
		return
	
	self.z_index = 100
	self.scale = Vector2(1.0,1.0)


func _on_hover_mouse_exited() -> void:
	self.z_index = 5
	self.scale = Vector2(0.8,0.8)


# True if it snaps, false if it returns to original spot
func _Card_Snap_Behavior() -> void:
	overlappingAreas = snap_area_self.get_overlapping_areas()
	if !overlappingAreas.is_empty():
		snap_area_slot = overlappingAreas[0]
		cardSlot = snap_area_slot.get_parent()
		print("Snap, starting signal chain for checking")
		cardSnapping.emit(self, cardSlot, get_parent().get_parent())
		overlappingAreas.remove_at(0)
	else:
		_snap_back(self)


# area for hovering and dragging
func _on_hover_drag_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if GeneralManager.draggingCard != null and GeneralManager.draggingCard != self:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and isDraggable:
				isDragging = true
				GeneralManager.draggingCard = self
				z_index = 100
				curDragOffset = get_global_mouse_position() - global_position
			elif isDragging:
				isDragging = false
				z_index = 0
				GeneralManager.draggingCard = null
				curDragOffset = Vector2.ZERO
				_Card_Snap_Behavior()


func _snap_back(cardSnapping: card_base_2D) -> void:
	global_position = originalPosition
