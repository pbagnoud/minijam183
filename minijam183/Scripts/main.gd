extends Node2D

var is_holding = false

@onready var upgrade_screen: Control = $UpgradeScreen

func _process(delta):
	if is_holding:
		Engine.time_scale = 7.0
	else:
		Engine.time_scale = 1.0


func _on_spawn_timer_timeout() -> void:
	pass # Replace with function body.


func _on_round_timer_timeout() -> void:
	upgrade_screen.reset()

func _on_button_acceleration_button_down() -> void:
	is_holding = true

func _on_button_acceleration_button_up() -> void:
	is_holding = false
	
func _clear():
	pass
