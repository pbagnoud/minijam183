extends Control


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
