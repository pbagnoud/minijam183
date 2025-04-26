extends RigidBody2D

var durability=1
var color: int
var characteristics : Array
var power:int = 1
var has_color_change : bool
#func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#queue_free()

func hit_something():
	durability-=1
	if durability==0:
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
