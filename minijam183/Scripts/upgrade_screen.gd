extends Control


@onready var pool_names=["+1 Power","+2 Power","+1 Range","+ 1 shot speed","test2","test3"]
@onready var pool_upgrades=[[0,1,0,0,0],[0,2,0,0,0],[0,0,20,0,0],[0,0,0,500,0],[0,0,0,0,0],[0,0,0,0,0]]
@onready var pool_indices=[0,1,2,3,4,5]


@onready var button_upgrade_1: Button = $Button_upgrade_1
@onready var button_upgrade_2: Button = $Button_upgrade_2

@onready var button_next_wave: Button = $Button_next_wave

@onready var selected_upgrade=0
@onready var selected_tower=0

@onready var modif = [0,0,0,0,0]
signal round_start

func _ready():
	visible=false
	
func reset():
	visible=true
	pool_indices.shuffle()
	pool_indices.slice(0,2)
	
	button_upgrade_1.text=str(pool_names[pool_indices[0]])
	button_upgrade_2.text=str(pool_names[pool_indices[1]])
	
	button_next_wave.disabled=true

func new_round():
	visible=false
	round_start.emit()

func _process(delta)-> void:
	if selected_tower >0.5 and selected_upgrade >0.5:
		button_next_wave.disabled=false
		
func _on_button_upgrade_1_pressed() -> void:
	selected_upgrade=1

func _on_button_upgrade_2_pressed() -> void:
	selected_upgrade=2

func _on_button_tower_1_pressed() -> void:
	selected_tower=1

func _on_button_next_wave_pressed() -> void:
	var upgrade_index=pool_indices[selected_upgrade-1]
	visible=false
	#get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
