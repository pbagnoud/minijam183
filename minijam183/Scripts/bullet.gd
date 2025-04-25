extends RigidBody2D

var color: String
var characteristics : Array


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
