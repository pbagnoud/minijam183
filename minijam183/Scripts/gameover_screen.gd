extends Node2D

@onready var click_sound: AudioStreamPlayer2D = $Click_sound

func _on_button_start_pressed() -> void:
	click_sound.playing = true
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_button_quit_pressed() -> void:
	click_sound.playing = true
	get_tree().quit()
