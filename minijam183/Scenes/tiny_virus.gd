extends "res://Scripts/enemy.gd"


func _ready():
	pv = 1
	change_color(3)
	is_split = true
	scale = Vector2(0.5, 0.5)
