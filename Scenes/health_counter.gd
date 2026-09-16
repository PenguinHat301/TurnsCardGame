extends Node2D
@onready var health: Label = $Health


func displayHP(curHP: int):
	health.text = str(curHP)
