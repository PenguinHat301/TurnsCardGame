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

# var current location?
var originalPosition: Vector2 
var isHovered: bool
var isDragging: bool
var isDraggable: bool
var curDragOffset: Vector2 # used for moving the card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ID = 0 # temporary placeholder
	cardID = card_data.cardID
	isDraggable = true
	self.originalPosition = position
	
	$Artwork.texture = card_data.artWork
	$Artwork.scale = Vector2(5.0,5.0)
	$UI/Name.text = card_data.name
	$UI/Description.text = card_data.description
	$UI/HealthLabel.text = card_data.healthStat
	$UI/AttackLabel.text = card_data.attackStat


func _process(delta: float) -> void:
	if self.isDragging:
		self.global_position = get_global_mouse_position() - curDragOffset


func _on_hover_mouse_entered() -> void:
	self.z_index = 100
	self.scale = Vector2(1.0,1.0)


func _on_hover_mouse_exited() -> void:
	self.z_index = 0
	self.scale = Vector2(0.8,0.8)


func _Card_Snap_Behavior() -> bool:
	overlappingAreas = snap_area_self.get_overlapping_areas()
	if !overlappingAreas.is_empty():
		snap_area_slot = overlappingAreas[0]
		print("detecting area")
		cardSlot = snap_area_slot.get_parent()
		if cardSlot.occupied == false:
			cardSlot.occupied = true
			self.set_position(cardSlot.position)
			self.isDraggable = false
			print("Snap")
			return true
		else:
			print("slot is occupied")
			return false
	else: 
		overlappingAreas.remove_at(0)
		return false


func _on_hover_drag_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed and isDraggable:
					isDragging = true
					z_index = 100
					curDragOffset = get_global_mouse_position() - global_position
				elif isDragging:
					isDragging = false
					z_index = 0
					curDragOffset = Vector2.ZERO
					if !_Card_Snap_Behavior():
						global_position = originalPosition
