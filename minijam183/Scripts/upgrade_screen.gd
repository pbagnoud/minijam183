extends Control

@onready var pool_indices: Array
@export var upgrades : upgrades
@onready var upgrades_list: Array

@onready var button_upgrade_1: Button = $Button_upgrade_1
@onready var button_upgrade_2: Button = $Button_upgrade_2
@onready var button_next_wave: Button = $Button_next_wave
@onready var button_upgrade_3: Button = $Button_upgrade_3
@onready var tuto_1: RichTextLabel = $Tuto1


var upgrade_1_Id: String
var upgrade_2_Id: String
var upgrade_3_Id: String
@onready var tuto_was_shown: bool = false

@onready var selected_upgrade = ""
@onready var selected_tower=0

@onready var an_update_is_selected = false

signal round_start
signal add_upgrade_signal(id: String, tower: int)
signal add_tower_5

func _ready():

	visible=false
	upgrades_list = upgrades.upgrades_list
	pool_indices = range(len(upgrades_list))
	# Comment next line to get out of debugging
	#reset()
	
func reset(round_id):
	if not tuto_was_shown:
		show_upgrading_tuto()
	visible=true
	var chosen_upgrades = pick_upgrades(round_id)
	
	upgrade_1_Id = upgrades_list[chosen_upgrades[0]]["Id"]
	upgrade_2_Id = upgrades_list[chosen_upgrades[1]]["Id"]
	upgrade_3_Id = upgrades_list[chosen_upgrades[2]]["Id"]
	
	button_upgrade_1.text=upgrades_list[chosen_upgrades[0]]["Name"]
	button_upgrade_2.text=upgrades_list[chosen_upgrades[1]]["Name"]
	button_upgrade_3.text=upgrades_list[chosen_upgrades[2]]["Name"]
	
	button_upgrade_1.change_description(upgrades_list[chosen_upgrades[0]]["Description"])
	button_upgrade_2.change_description(upgrades_list[chosen_upgrades[1]]["Description"])
	button_upgrade_3.change_description(upgrades_list[chosen_upgrades[2]]["Description"])
	
	button_next_wave.disabled=true

func pick_upgrades(round_id):
	var upgrade_1_index: int = 0
	var upgrade_2_index: int = 0
	var upgrade_3_index: int = 0
	var choices2: Array
	var choices3: Array
	upgrade_1_index = randi_range(0,2)
	if round_id < 6:
		upgrade_2_index = randi_range(0,2)
		upgrade_3_index = randi_range(3,6)
	elif round_id < 8:
		upgrade_2_index = randi_range(3,6)
		upgrade_3_index = randi_range(3,10)
	else :
		upgrade_2_index = randi_range(3,10)
		upgrade_3_index = randi_range(7,11)
		
	
	return [upgrade_1_index, upgrade_2_index, upgrade_3_index]

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
	if selected_upgrade == "addTower":
		add_tower_5.emit()
	else :
		add_upgrade_signal.emit(selected_upgrade, selected_tower)
	print("Added upgrade ", selected_upgrade, " to tower ", selected_tower)
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
	
func show_upgrading_tuto():
	tuto_1.visible = true
	tuto_was_shown = true
	
func _on_button_pressed() -> void:
	tuto_1.visible = false
