extends Path2D

var timer = 0 
var spawntime = 1
var follower = preload("res://Scenes/path_follow_2d.tscn")
var wave = []
var rng = RandomNumberGenerator.new()
var MAX_WAVE = 10

func _generate_wave(wave_id:int)-> void:
	var size_wave = 15 + wave_id * 5
	for _i in range(size_wave):
		wave.append(rng.randi_range(0, 3))
	return 

func _speed_up_wave(wave_id:int)->void:
	spawntime=1-wave_id/MAX_WAVE

func new_round(wave_id:int)->float:
	_generate_wave(wave_id)
	_speed_up_wave(wave_id)
	return wave.size()*spawntime

func _process(delta: float) -> void:
	if wave.is_empty():
		
		return
	timer += delta
	
	if timer > spawntime:
		var new_follower = follower.instantiate()
		add_child(new_follower)
		timer = 0
