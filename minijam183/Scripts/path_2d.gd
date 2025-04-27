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
signal show_tutorial(wave_id: int)

var pv_min : int = 3
var current_pv : int

func _generate_wave(wave_id:int)-> void:
	if wave_id == 0 :
		wave = [-1,0]
	elif wave_id == 1:
		wave = [0,0,0,0]
	elif wave_id == 2:
		wave = [0,1,1]
	elif wave_id == 3:
		wave = [0,1,0,1,2,-1,3]
	elif wave_id == 10:
		wave = [0,1,2,3,0,1,2,3,-1,-1,4]
	else : 
		var size_wave = 3 + int(wave_id * 1.5)
		for i in range(size_wave):
			if rng.randi_range(0, 3)==0:
				wave.append(-1)
			var next_enemy=rng.randi_range(0, 5)%4
			
			wave.append(next_enemy)
	return 

func _speed_up_wave(wave_id:int)->void:
	spawntime=1-pow(.8*wave_id/(3+MAX_WAVE),2)

func _update_life_ennemies(wave_id:int):
	current_pv = pv_min + int(0.3*wave_id)

func new_round(wave_id:int, skip_tuto:bool)->float:
	_generate_wave(wave_id)
	_speed_up_wave(wave_id)
	_update_life_ennemies(wave_id)
	if wave_id < 4 and skip_tuto == false:
		print("la wave est :", wave, "et j'affiche le tuto")

		show_tutorial.emit(wave_id)
	
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
		if not wave[0] == -1: 
			var new_follower = follower.instantiate()
			new_follower.color=wave.pop_front()
			add_child(new_follower)
			if new_follower.color == 4:
				new_follower.pv = 20
				new_follower.set_pv(20) 
			else : 
				new_follower.pv = current_pv 
				new_follower.set_pv(current_pv) # Je sais que set(value) est censé éviter ce genre de mochetés, mais j'ai pas réussi à faire sans
			# à cause des virus qui splittent et du timing de quand ils sont instantiés vs quand ils entrent dans l'arbre
		else :
			wave.pop_front()
		timer = 0
