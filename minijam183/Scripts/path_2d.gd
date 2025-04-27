extends Path2D

var timer = 0 
var spawntime = 1
var follower = preload("res://Scenes/path_follow_2d.tscn")
var wave = []
var rng = RandomNumberGenerator.new()
var MAX_WAVE = 10
var check_empty = false
var round_id: int
signal empty_list

var pv_min : int = 2
var current_pv : int

func _generate_wave(wave_id:int)-> void:
	if wave_id == 0 :
		wave = [0]
		# implement tutorial
		pass
	else : 
		var size_wave = 15 + wave_id * 5
		for _i in range(size_wave):
			wave.append(rng.randi_range(0, 3))
	return 

func _speed_up_wave(wave_id:int)->void:
	spawntime=1-wave_id/MAX_WAVE

func _update_life_ennemies(wave_id:int):
	current_pv = pv_min + wave_id

func new_round(wave_id:int)->float:
	_generate_wave(wave_id)
	_speed_up_wave(wave_id)
	_update_life_ennemies(wave_id)
	check_empty=true
	return wave.size()*spawntime

func _process(delta: float) -> void:
	if wave.is_empty():
		if check_empty:
			empty_list.emit()
			check_empty =false
		return
	timer += delta
	
	if timer > spawntime:
		var new_follower = follower.instantiate()
		new_follower.color=wave.pop_front()
		add_child(new_follower)
		new_follower.pv = current_pv 
		new_follower.set_pv(current_pv) # Je sais que set(value) est censé éviter ce genre de mochetés, mais j'ai pas réussi à faire sans
		# à cause des virus qui splittent et du timing de quand ils sont instantiés vs quand ils entrent dans l'arbre
		timer = 0
