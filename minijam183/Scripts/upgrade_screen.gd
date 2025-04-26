extends Control

@onready var pool_indices: Array
@export var upgrades : upgrades
@onready var upgrades_list: Array

@onready var button_upgrade_1: Button = $Button_upgrade_1
@onready var button_upgrade_2: Button = $Button_upgrade_2
@onready var button_next_wave: Button = $Button_next_wave
@onready var button_upgrade_3: Button = $Button_upgrade_3

var upgrade_1_Id: String
var upgrade_2_Id: String
var upgrade_3_Id: String

@onready var selected_upgrade = ""
@onready var selected_tower=0

@onready var an_update_is_selected = false

signal round_start
signal add_upgrade_signal(id: String, tower: int)

func _ready():
	visible=true
	upgrades_list = upgrades.upgrades_list
	pool_indices = range(len(upgrades_list))
	# Comment next line to get out of debugging
	reset()
	
func reset():
	visible=true
	pool_indices.shuffle()
	#upgrade_1_Id = upgrades_list[pool_indices[0]]["Id"]
	# For Debugging, remove next line and uncomment above line to get intented gameplay 
	upgrade_1_Id = upgrades_list[pool_indices[0]]["Id"]
	upgrade_2_Id = upgrades_list[pool_indices[1]]["Id"]
	upgrade_2_Id = upgrades_list[pool_indices[2]]["Id"]
	
	button_upgrade_1.text=upgrades_list[pool_indices[0]]["Name"]
	button_upgrade_2.text=upgrades_list[pool_indices[1]]["Name"]
	button_upgrade_3.text=upgrades_list[pool_indices[2]]["Name"]
	
	print(upgrades_list)
	
	print(upgrades_list[pool_indices[0]]["Description"])
	print(upgrades_list[pool_indices[1]]["Description"])
	print(upgrades_list[pool_indices[2]]["Description"])
	
	button_upgrade_1.change_description(upgrades_list[pool_indices[0]]["Description"])
	button_upgrade_2.change_description(upgrades_list[pool_indices[1]]["Description"])
	button_upgrade_3.change_description(upgrades_list[pool_indices[2]]["Description"])
	
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
	
func _on_button_upgrade_3_pressed() -> void:
	selected_upgrade= upgrade_3_Id
	an_update_is_selected = true

func _on_button_next_wave_pressed() -> void:
	add_upgrade_signal.emit(selected_upgrade, selected_tower)
	visible=false
	round_start.emit()
	
func _on_button_tower_1_pressed() -> void:
	selected_tower=1

func _on_button_tower_2_pressed() -> void:
	selected_tower=2

func _on_button_tower_3_pressed() -> void:
	selected_tower=3

func _on_button_tower_4_pressed() -> void:
	selected_tower=4
