extends StaticBody2D

signal new_bullet(direction, speed, characteristics)

var bullet_scene = load("res://Scenes/bullet.tscn")

@export var number : int
var color: int = 1
var power: int = 1
var range: int = 1000
var shot_speed: int = 400
var closestDistance: int

func _on_tower_timer_timeout() -> void:
	fire()

func find_closest_enemy():
	var closestEnemy
	closestDistance = range
	var all_enemy = get_tree().get_nodes_in_group("enemy")
	print(all_enemy)
	for enemy in all_enemy:
		var gun2enemy_distance = position.distance_to(enemy.position)
		if gun2enemy_distance < closestDistance:
			closestDistance = gun2enemy_distance
			closestEnemy = enemy
	return closestEnemy

func fire():
	print(bullet_scene)
	# detect closest enemy
	var closestEnemy = find_closest_enemy()
	print(closestEnemy)
	if closestEnemy != null :
		# create new bullet, with speed and rotation and characteristics (?)
		var direction = closestEnemy.position - self.position
		print(direction)
		new_bullet.emit(direction.normalized(), shot_speed, [])
		var bullet = bullet_scene.instantiate()
		# Choose a random location on Path2D.
		#var mob_spawn_location = $MobPath/MobSpawnLocation
		#mob_spawn_location.progress_ratio = randf()

		# Set the mob's position to the random location.
		#bullet.position = self.position

		#Choose the velocity for the mob.
		#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
		bullet.linear_velocity = direction.normalized()*shot_speed

		# Spawn the mob by adding it to the Main scene.
		add_child(bullet)
		
	pass
