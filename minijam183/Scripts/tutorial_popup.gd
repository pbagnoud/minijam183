extends RichTextLabel
@onready var button_2: Button = $Button2

signal skip_tutorial

func show_tuto_window(wave_id):
	get_tree().paused = true
	visible = true
	if wave_id > 2:
		button_2.visible = false
	match wave_id:
		0:
			text = "Your turrets will fire on enemies. "
		1:
			text = "Turrets deal more damage to\n same-color enemies !\n\n Change turret color by clicking."
		2: 
			text = "Purple bats fly faster !"
		3: 
			text = "Green viruses and orange invaders also have special powers. Good luck !"
		4:
			text = "Green viruses split on death."
		
		

func _on_button_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_button_2_pressed() -> void:
	visible = false
	skip_tutorial.emit()
