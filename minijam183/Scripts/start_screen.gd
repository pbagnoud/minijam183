extends Control
signal skip_tutorial
signal start_game

func _on_button_start_pressed() -> void:
	visible = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()
