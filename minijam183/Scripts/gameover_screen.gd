extends Node2D


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()
