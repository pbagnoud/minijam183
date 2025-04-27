extends RichTextLabel

func show_tuto_window(wave_id):
	get_tree().paused = true
	visible = true
	match wave_id:
		0:
			text = "Your towers will fire on
			enemies."
		1:
			text = "Towers deal more damage to same-color enemies ! Change tower color by clicking."
		2: 
			text = "Purple bats fly faster !"
		3: 
			text = "Orange invaders are sometimes shielded, making them invincible"
		4:
			text = "Green viruses split on death."
		
		

func _on_button_pressed() -> void:
	visible = false
	get_tree().paused = false
