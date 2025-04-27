extends Control

func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_tutorial_pressed() -> void:
	pass # Replace with function body.
