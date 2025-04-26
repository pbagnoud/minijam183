extends RigidBody2D
var c=['#00FFC3','#FF00D8','#FFB200','#96FF00']
var durability=1
var color: int:
	set(value):
		color = value
		modulate = c[color]
	
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
