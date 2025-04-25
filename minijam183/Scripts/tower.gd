extends StaticBody2D

signal new_bullet(direction, speed, characteristics)

@export var number : int
var color: int = 1
var power: int = 1
var range: int = 100
var shot_speed: int = 10
var closestDistance: int

func _on_tower_timer_timeout() -> void:
	fire()

func find_closest_enemy():
	var closestEnemy
	closestDistance = range
	var all_enemy = get_tree().get_nodes_in_group("enemy")
	for enemy in all_enemy:
		var gun2enemy_distance = position.distance_to(enemy.position)
		if gun2enemy_distance < closestDistance:
			closestDistance = gun2enemy_distance
			closestEnemy = enemy
	return closestEnemy

func fire():
	# detect closest enemy
	var closestEnemy = find_closest_enemy()
	if closestEnemy != null :
		# create new bullet, with speed and rotation and characteristics (?)
		var direction = closestEnemy.position - self.position
		new_bullet.emit(direction.normalize(), shot_speed, [])
	pass
