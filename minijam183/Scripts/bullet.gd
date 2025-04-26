extends RigidBody2D

var color: int
var characteristics : Array
var power:int =1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
