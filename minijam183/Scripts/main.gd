extends Node2D

var is_holding = false
var has_to_check_empty_screen = false
var round_id=0
@onready var path_2d: Path2D = $Path2D
@onready var round_timer: Timer = $Round_timer

@onready var upgrade_screen: Control = $UpgradeScreen

func _process(delta):
	if is_holding:
		Engine.time_scale = 7.0
	else:
		Engine.time_scale = 1.0
	if has_to_check_empty_screen:
		if get_tree().get_nodes_in_group("enemy").is_empty():
			upgrade_screen.reset()


func _on_upgrade_screen_finished():
	round_timer.wait_time = path_2d.new_round(round_id)
	round_id +=1

func _on_round_timer_timeout() -> void:
	has_to_check_empty_screen = true # Replace with function body.

func _on_button_acceleration_button_down() -> void:
	is_holding = true

func _on_button_acceleration_button_up() -> void:
	is_holding = false
	
func _clear():
	pass
