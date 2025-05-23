extends StaticBody2D

signal new_bullet(direction, speed, characteristics)


 #Sprites ----------------------------------------------
@onready var color_sprite: AnimatedSprite2D = $Sprites/color_sprite
@onready var feet_sprite: Sprite2D = $Sprites/feet_sprite



 #------------------------------------------------------
var bullet_scene = load("res://Scenes/bullet.tscn")
@onready var tower_timer: Timer = $tower_timer
@onready var tower_start_timer: Timer = $tower_start_timer
@onready var size_change: SizeChange = $SizeChange
@onready var label: RichTextLabel = $Label
@onready var click_sound: AudioStreamPlayer2D = $Click_sound

@export var number : int


@export var color: int = 0
@export var power: int = 1

var detection_range: int = 300
var shot_speed: int = 400
var closestDistance: int
var cooldown:
	set(value):
		cooldown = value
		tower_timer.wait_time = cooldown
		print("le nouveau timer est : ", tower_timer.wait_time )
var lifespan_bullet : int = 1
var color_power = 0
var bullet_durability = 1
var has_explosive_bullets = false
@export var dot_damage = 0
@export var enemy_pushback_dist = 0
@export var enemy_slowdown = 0
@export var is_sniper = false
@export var is_gatling = false
@export var has_piercing = false
@export var is_specialized = false
@export var is_freezing = false
@export var is_pushback = false


@export var has_triple_shoot = false
var ready_to_start_firing : bool = false
var triple_shot_angle = .75
@export var has_color_change = false
@export var has_reload : bool = true
@export var is_on_fire = false


func _ready():
	color_sprite.play("blue")
	cooldown = 1.5
	label.visible = false

	
func change_color(new_color):
	if new_color ==0:
		color_sprite.play("blue")
	if new_color ==1:
		color_sprite.play("red")
	if new_color ==2:
		color_sprite.play("orange")
	if new_color ==3:
		color_sprite.play("green")
		

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
		var direction 
		# create new bullet, with speed and rotation and characteristics (?)
		if is_sniper and closestEnemy.progress_ratio + 5 < 1:
			direction = closestEnemy.next_position(5) - self.position
		else:
			direction = closestEnemy.next_position(55) - self.position

		print(direction)
		create_bullet(direction)
		#size_change.size_tween()
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
	if is_gatling:
		bullet.power = power * .1
	elif is_sniper:
		bullet.power = power * 5
	else:
		bullet.power = power
	
	bullet.durability=bullet_durability
	bullet.freeze_time=enemy_slowdown
	bullet.color_power = color_power
	bullet.enemy_pushback_distance = enemy_pushback_dist
	bullet.has_color_change = has_color_change
	bullet.dot_damage=dot_damage

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
		'special':
			return increase_color_damage()
		'pierce':
			return increase_bullet_durability()
		'paint':
			return enable_enemy_color_change()
		'missile':
			return explode_bullet()
		'fire':
			return increase_damage_over_time()
		'push':
			return push_back_enemy()
		'triple':
			return enable_triple_shoot()
		'freeze':
			return slow_down_enemy()
		'sniper':
			return tower_is_sniper()
		'gatling':
			return tower_is_gatling()
		'addTower':
			print('no fifth tower')
			return false
			
		
	print('no implementation')
	return false

func increase_damage()->bool:
	print("Damage Increased")
	power +=1
	return true

func decrease_reload_time()->bool:
	cooldown *=.8
	has_reload = true
	return true

func increase_color_damage() -> bool:
	is_specialized = true
	color_power += 1
	return true

func increase_bullet_durability() -> bool:
	has_piercing = true
	bullet_durability += 1
	return true

func enable_enemy_color_change()->bool:
	if has_color_change:
		return false
	else:
		has_color_change = true
		return true
		
func explode_bullet() -> bool:
	if has_explosive_bullets:
		return false
	else:
		has_explosive_bullets = true
		return true

func increase_damage_over_time()->bool:
	is_on_fire = true
	dot_damage += 1
	return true

func push_back_enemy() -> bool:
	is_pushback = true
	enemy_pushback_dist += 1
	return true

func enable_triple_shoot()->bool:
	if has_triple_shoot:
		return false
	else:
		has_triple_shoot = true
		return true

func slow_down_enemy() -> bool:
	is_freezing = true
	enemy_slowdown += 1
	return true

func tower_is_sniper() -> bool:
	if is_sniper or is_gatling:
		return false
	else:
		cooldown += 1
		shot_speed *= 10
		detection_range *= 2
		power += 4
		is_sniper = true
		return true

func tower_is_gatling() -> bool:
	if is_gatling or is_sniper:
		return false
	else:
		cooldown -= 0.7
		tower_timer.wait_time -= 0.7
		is_gatling = true
		return true
		

func set_start_time(time):
	tower_start_timer.wait_time = time

func start_start_timer():
	tower_start_timer.start()
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		click_sound.playing = true
		color = (color + 1) % 4
		change_color(color)
		print(color)


func _on_mouse_entered() -> void:
	#color_sprite.modulate = '#edac9b'
	size_change.size_tween()
	label.visible = true
	label.text = "Power=" + str(power) + "\nReload=" + str(cooldown) + " sec"
	if has_triple_shoot:
		label.text += "\nTriple shots"
	if has_color_change:
		label.text += "\nPaintball"
	if is_sniper:
		label.text += "\nSniper"
	if is_gatling:
		label.text += "\nGatling gun"
	if has_piercing:
		label.text += "\nPiercing shots"
	if is_specialized:
		label.text += "\nSpecialized"
	if is_on_fire:
		label.text += "\nIncendiary"
	if is_pushback:
		label.text += "\nPushback"
	if is_freezing:
		label.text += "\nFreezing"
		
		
	




func _on_mouse_exited() -> void:
	label.visible = false
	size_change.color_reset()
	#color_sprite.modulate = '#ffffff'
