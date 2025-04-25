extends StaticBody2D

@export var number : int
var color: int


func _on_tower_timer_timeout() -> void:
	fire()

func fire():
	pass
