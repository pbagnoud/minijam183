extends Control



@onready var pool_upgrades=["+1 Power","+2 Power","+1 Range","test1","test2","test3"]
@onready var pool_indices=[0,1,2,3,4,5]


@onready var button_upgrade_1: Button = $Button_upgrade_1
@onready var button_upgrade_2: Button = $Button_upgrade_2

@onready var button_tower_1: Button = $Button_tower_1


func _ready():
	pool_indices.shuffle()
	pool_indices.slice(0,2)
	
	button_upgrade_1.text=str(pool_upgrades[pool_indices[0]])
	button_upgrade_2.text=str(pool_upgrades[pool_indices[1]])
	
	

func _on_button_upgrade_1_up() -> void:
	pass
		


func _on_button_upgrade_2_up() -> void:
	pass # Replace with function body.
