extends Path2D

var timer = 0 
var spawntime = 2
var follower = preload("res://Scenes/path_follow_2d.tscn")

func _process(delta: float) -> void:
	timer += delta
	
	if timer > spawntime:
		var new_follower = follower.instantiate()
		add_child(new_follower)
		timer = 0
