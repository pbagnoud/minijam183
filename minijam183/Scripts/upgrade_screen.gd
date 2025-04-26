extends Control


@onready var pool_names=["+1 Power","+2 Power","+1 Range","+ 1 shot speed","test2","test3"]
@onready var pool_indices=[0,1,2,3,4,5]
@export var upgrades : upgrades
@onready var upgrades_list: Array

@onready var button_upgrade_1: Button = $Button_upgrade_1
@onready var button_upgrade_2: Button = $Button_upgrade_2
@onready var button_next_wave: Button = $Button_next_wave

var upgrade_1_Id: String
var upgrade_2_Id: String

@onready var selected_upgrade = ""
@onready var selected_tower=0

@onready var an_update_is_selected = false

@onready var modif = [0,0,0,0,0]
signal round_start
signal add_upgrade_signal(id: String, tower: int)

func _ready():
	visible=false
	upgrades_list = upgrades.upgrades_list
	
func reset():
	visible=true
	pool_indices.shuffle()
	
	#upgrade_1_Id = upgrades_list[pool_indices[0]]["Id"]
	# For Debugging : 
	upgrade_1_Id = "damage+"
	upgrade_2_Id = upgrades_list[pool_indices[1]]["Id"]
	
	button_upgrade_1.text=str(pool_names[pool_indices[0]])
	button_upgrade_2.text=str(pool_names[pool_indices[1]])
	
	button_next_wave.disabled=true



func _process(delta)-> void:
	if selected_tower >0.5 and an_update_is_selected:
		button_next_wave.disabled=false
		
func _on_button_upgrade_1_pressed() -> void:
	selected_upgrade= upgrade_1_Id
	an_update_is_selected = true

func _on_button_upgrade_2_pressed() -> void:
	selected_upgrade= upgrade_2_Id
	an_update_is_selected = true

func _on_button_tower_1_pressed() -> void:
	selected_tower=1

func _on_button_next_wave_pressed() -> void:
	add_upgrade_signal.emit(selected_upgrade, selected_tower)
	visible=false
	round_start.emit()
	#get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
