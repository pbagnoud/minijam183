extends Control
signal skip_tutorial
signal start_game
@onready var click_sound: AudioStreamPlayer2D = $Click_sound

func _on_button_start_pressed() -> void:
	click_sound.playing = true
	visible = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_quit_pressed() -> void:
	click_sound.playing = true
	get_tree().quit()
