extends Node

# Keep track of carried card, to not allow taking 2 cards, hover highlight, etc...
var draggingCard: card_base_2D = null # card being dragged
var hoveringCard: card_base_2D = null # card being hovered on
