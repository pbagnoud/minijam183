extends StaticBody2D

signal new_bullet(direction, speed, characteristics)

@onready var tower_sprite: AnimatedSprite2D = $tower_sprite
var bullet_scene = load("res://Scenes/bullet.tscn")
@onready var tower_timer: Timer = $tower_timer
@onready var tower_start_timer: Timer = $tower_start_timer
@onready var size_change: SizeChange = $SizeChange
@onready var label = $Label

@export var number : int


@export var color: int = 0
@export var power: int = 1

var detection_range: int = 200
var shot_speed: int = 400
var closestDistance: int
var cooldown: float = 1.5 #tower_timer.wait_time=cooldown
var lifespan_bullet : int = 0.8

@export var has_triple_shoot =false
var ready_to_start_firing : bool = false
var triple_shot_angle = .75
@export var has_color_change = false

func _ready():
	tower_sprite.play("tower_rotation")

func change_color(new_color):
	tower_sprite.frame = new_color
	color = new_color


#Avoid the 1.5 s firing cycles to be synchronized
func _on_tower_start_timer_timeout() -> void:
	tower_timer.start()
	
func _on_tower_timer_timeout() -> void:
	if visible :
		fire()

func find_closest_enemy():
	var closestEnemy = null
	closestDistance = detection_range
	var all_enemy = get_tree().get_nodes_in_group("enemy")
	#print(all_enemy)
	#print("start loop")
	#print("ma position :", position)
	for enemy in all_enemy:
		#print("position ennemi :", enemy.position)
		var gun2enemy_distance = position.distance_to(enemy.position)
		if gun2enemy_distance < closestDistance:
			closestDistance = gun2enemy_distance
			#print("plus proche", closestDistance)
			closestEnemy = enemy
		#else :
			#print("nobody in range")
	return closestEnemy

func fire():
	# detect closest enemy
	var closestEnemy = find_closest_enemy()
	if closestEnemy != null :
		# create new bullet, with speed and rotation and characteristics (?)
		
		var direction = closestEnemy.next_position(75) - self.position

		print(direction)
		create_bullet(direction)
		size_change.size_tween()
		if has_triple_shoot:
			create_bullet(direction.rotated(triple_shot_angle))
			create_bullet(direction.rotated(-triple_shot_angle))

	
func create_bullet(direction):
	var bullet = bullet_scene.instantiate()
	var bullet_timer = bullet.get_node("bullet_timer")
	# Choose a random location on Path2D.
	#var mob_spawn_location = $MobPath/MobSpawnLocation
	#mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	#bullet.position = self.position

	#Choose the velocity for the mob.
	#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	bullet.linear_velocity = direction.normalized()*shot_speed
	bullet.position = direction.normalized()
	bullet.color = color
	bullet.power = power
	bullet.has_color_change = has_color_change

	# Spawn the mob by adding it to the Main scene.
	add_child(bullet)
	
	#Manage the lifetime of the bullet
	bullet_timer.start()
	bullet_timer.wait_time=lifespan_bullet


func add_upgrade(id:String)->bool:
	match id:
		'damage+':
			return increase_damage()
		'reload+':
			return decrease_reload_time()
		'triple':
			return enable_triple_shoot()
		'paint':
			return enable_enemy_color_change()
		'fire':
			return increase_damage_over_time()
	print('no implementation')
	return false

func increase_damage()->bool:
	print("Damage Increased")
	power +=1
	return true

func decrease_reload_time()->bool:
	shot_speed *=.8
	return true

func enable_triple_shoot()->bool:
	if has_triple_shoot:
		return false
	else:
		has_triple_shoot = true
		return true
func enable_enemy_color_change()->bool:
	if has_color_change:
		return false
	else:
		has_color_change = true
		return true
func increase_damage_over_time()->bool:
	return true


func set_start_time(time):
	tower_start_timer.wait_time = time

func start_start_timer():
	tower_start_timer.start()
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		color = (color + 1) % 4
		tower_sprite.frame = color
		print(color)


func _on_mouse_entered() -> void:
	tower_sprite.modulate = '#edac9b'
	label.text = "damages=" + str(power) + "\n reload=" + str(shot_speed)
	if has_triple_shoot:
		label.text += "\n triple shots"
	if has_color_change:
		label.text += "\n change color ennemies"


func _on_mouse_exited() -> void:
	label.text = ""
	tower_sprite.modulate = '#ffffff'
