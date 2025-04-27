extends Node2D

var is_holding = false
var has_to_check_empty_screen = false

@onready var path_2d: Path2D = $Path2D

@onready var upgrade_screen: Control = $UpgradeScreen
@onready var start_screen: Control = $StartScreen

@onready var tower_1: StaticBody2D = $Tower1
@onready var tower_2: StaticBody2D = $Tower2
@onready var tower_3: StaticBody2D = $Tower3
@onready var tower_4: StaticBody2D = $Tower4
@onready var tower_5: StaticBody2D = $Tower5
@onready var tutorial_popup: RichTextLabel = $TutorialPopup
@onready var life: RichTextLabel = $life

@export var round_id = 0

		

@onready var failures_count = 0:
	set(value):
		failures_count=value
		life.text = str(value)+'/'+str(losing_condition)


var losing_condition = 3
var skip_tuto = false

func _ready():
	tower_1.set_start_time(0.05)
	tower_2.set_start_time(0.8)
	tower_3.set_start_time(0.5)
	tower_4.set_start_time(0.3)
	
	tower_1.start_start_timer()
	tower_2.start_start_timer()
	tower_3.start_start_timer()
	tower_4.start_start_timer()
	
	start_new_round(skip_tuto)

	
	



func _process(_delta):
	if is_holding:
		Engine.time_scale = 3.0
		Engine.physics_ticks_per_second = 180
	else:
		Engine.time_scale = 1.0
		Engine.physics_ticks_per_second = 60
	if has_to_check_empty_screen:
		if get_tree().get_nodes_in_group("enemy").is_empty():
			print(round_id)
			#await get_tree().create_timer(2).timeout
			if round_id < 3:
				start_new_round(skip_tuto)
				has_to_check_empty_screen = false
			elif round_id == 10:
				has_to_check_empty_screen = false
				get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
				# Show victory screen
			else :
				upgrade_screen.reset(round_id, skip_tuto)
				has_to_check_empty_screen = false


	
func _on_upgrade_screen_finished():
	start_new_round(skip_tuto)
	
func start_new_round(skip_tuto):
	print('new_round :', round_id )
	path_2d.new_round(round_id, skip_tuto)
	if round_id == 1:
		tower_1.change_color(1)
		tower_2.change_color(1)
		tower_3.change_color(1)
		tower_4.change_color(1)
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


func _on_upgrade_screen_add_upgrade_signal(id: String, tower: int) -> void:
	if tower == 1:
		tower_1.add_upgrade(id)
	if tower == 2:
		tower_2.add_upgrade(id)
	if tower == 3:
		tower_3.add_upgrade(id)
	if tower == 4:
		tower_4.add_upgrade(id)



func _on_world_boundary_area_entered(area: Area2D) -> void:
	failures_count = failures_count + 1
	if failures_count >= losing_condition:
		get_tree().change_scene_to_file("res://Scenes/gameover_screen.tscn")
		
	


func _on_upgrade_screen_add_tower_5() -> void:
	tower_5.visible = true
	tower_5.start_start_timer()


func _on_path_2d_show_tutorial(wave_id: int) -> void:
	tutorial_popup.show_tuto_window(wave_id)


func _on_tutorial_popup_skip_tutorial() -> void:
	skip_tuto = true
	get_tree().paused = false
	round_id = 3
	start_new_round(skip_tuto)
