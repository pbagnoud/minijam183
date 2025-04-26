extends Node2D

var is_holding = false
var has_to_check_empty_screen = false
var round_id=0
@onready var path_2d: Path2D = $Path2D

@onready var upgrade_screen: Control = $UpgradeScreen

@onready var tower_1: StaticBody2D = $Tower1
@onready var tower_2: StaticBody2D = $Tower2
@onready var tower_3: StaticBody2D = $Tower3
@onready var tower_4: StaticBody2D = $Tower4

@onready var failures_count = 0

var losing_condition = 1

func _ready():
	tower_1.set_start_time(0.05)
	tower_2.set_start_time(0.8)
	tower_3.set_start_time(0.5)
	tower_4.set_start_time(0.3)
	
	tower_1.start_start_timer()
	tower_2.start_start_timer()
	tower_3.start_start_timer()
	tower_4.start_start_timer()
	
	_on_upgrade_screen_finished()


func _process(_delta):
	if is_holding:
		Engine.time_scale = 3.0
		Engine.physics_ticks_per_second = 180
	else:
		Engine.time_scale = 1.0
		Engine.physics_ticks_per_second = 60
	if has_to_check_empty_screen:
		if get_tree().get_nodes_in_group("enemy").is_empty():
			upgrade_screen.reset()
			has_to_check_empty_screen = false


	
func _on_upgrade_screen_finished():
	print('new_round')
	path_2d.new_round(round_id)
	round_id +=1
	failures_count = 0

func _on_round_timeout() -> void:
	has_to_check_empty_screen = true # Replace with function body.

func _on_button_acceleration_button_down() -> void:
	is_holding = true

func _on_button_acceleration_button_up() -> void:
	is_holding = false
	
func _clear():
	pass





func _on_world_boundary_area_entered(area: Area2D) -> void:
	failures_count = failures_count + 1
	print("PERDU", failures_count)
	print("PERDU", failures_count)
	print("PERDU", failures_count)
	print("PERDU", failures_count)

	if failures_count >= losing_condition:
		pass   #game over screen
