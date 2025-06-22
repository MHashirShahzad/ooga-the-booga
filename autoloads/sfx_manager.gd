extends Node2D

@export var jump_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/cartoon-jump1.mp3"),
	preload("res://assets/audio/cartoon-jump2.mp3"),
	preload("res://assets/audio/cartoon-jump3.mp3"),
	preload("res://assets/audio/cartoon-jump4.mp3"),
	preload("res://assets/audio/cartoon-jump5.mp3")
]

@export var land_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/land1.mp3"),
	preload("res://assets/audio/land2.mp3"),
	preload("res://assets/audio/land3.mp3"),
	preload("res://assets/audio/land4.mp3"),
	preload("res://assets/audio/land5.mp3"),
	preload("res://assets/audio/land6.mp3")
]

@export var groundpound_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/groundpound1.mp3"),
	preload("res://assets/audio/groundpound2.mp3"),
	preload("res://assets/audio/groundpound3.mp3"),
	preload("res://assets/audio/groundpound4.mp3"),
	preload("res://assets/audio/groundpound5.mp3"),
	preload("res://assets/audio/groundpound6.mp3")
]

@export var level_end_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/level-end1.mp3"),
	preload("res://assets/audio/level-end2.mp3"),
	preload("res://assets/audio/level-end3.mp3"),
	preload("res://assets/audio/level-end4.mp3"),
	preload("res://assets/audio/level-end5.mp3"),
	preload("res://assets/audio/level-end6.mp3")
]

@export var light_refill_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/light-refill1.mp3"),
	preload("res://assets/audio/light-refill2.mp3"),
	preload("res://assets/audio/light-refill3.mp3"),
	preload("res://assets/audio/light-refill4.mp3"),
	preload("res://assets/audio/light-refill5.mp3"),
	preload("res://assets/audio/light-refill6.mp3")
]

@export var player_dead_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/player-dead1.mp3"),
	preload("res://assets/audio/player-dead2.mp3"),
	preload("res://assets/audio/player-dead3.mp3"),
	preload("res://assets/audio/player-dead4.mp3"),
	preload("res://assets/audio/player-dead5.mp3"),
	preload("res://assets/audio/player-dead6.mp3")
]

@export var spike_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/spike1.mp3"),
	preload("res://assets/audio/spike2.mp3"),
	preload("res://assets/audio/spike3.mp3"),
	preload("res://assets/audio/spike4.mp3"),
	preload("res://assets/audio/spike5.mp3"),
	preload("res://assets/audio/spike6.mp3")
]

@export var spring_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/spring1.mp3"),
	preload("res://assets/audio/spring2.mp3"),
	preload("res://assets/audio/spring3.mp3"),
	preload("res://assets/audio/spring4.mp3"),
	preload("res://assets/audio/spring5.mp3"),
	preload("res://assets/audio/spring6.mp3"),
	preload("res://assets/audio/spring7.mp3")
]

@onready var music_player: AudioStreamPlayer = $MusicPlayer

func play_music(stream : AudioStream, volume = 1, fade_dur = 0, pitch_scale = 1) -> void:
	# fade previous music
	var tween := get_tree().create_tween()
	tween.tween_property(music_player, "volume_db", -70, fade_dur)
	await tween.finished
	tween.kill()
	
	music_player.bus = &"Music"
	music_player.stream = stream
	music_player.pitch_scale = pitch_scale
	music_player.play()
	# fade in new music
	var tween_2 := get_tree().create_tween()
	tween_2.tween_property(music_player, "volume_db", volume, fade_dur)
	await tween_2.finished
	tween_2.kill()
	

func play_FX(stream: AudioStream, volume = 10, lower_bound: int = 0.9, upper_bound: int = 1.1):
	# Create new stream player
	var fx_player = AudioStreamPlayer.new()
	# Assign its variables
	fx_player.bus = &"SFX"
	fx_player.stream = stream
	fx_player.name = "fx_player"
	fx_player.volume_db = volume
	# Add random pitch
	fx_player.pitch_scale = randf_range(lower_bound, upper_bound)
	add_child(fx_player)
	fx_player.play()
	# Destroy when completed
	await fx_player.finished
	fx_player.queue_free()

func play_FX_2D(stream: AudioStream,pos : Vector2, volume = 10, lower_bound: int = 1, upper_bound: int = 1.5):
	# Create new stream player
	var fx_player = AudioStreamPlayer2D.new()
	# Assign its variables
	fx_player.global_position = pos
	# fx_player.bus = &"SFX"
	fx_player.stream = stream
	fx_player.name = "fx_player"
	fx_player.volume_db = volume
	# Add random pitch
	fx_player.pitch_scale = randf_range(lower_bound, upper_bound)
	add_child(fx_player)
	fx_player.play()
	# Destroy when completed
	await fx_player.finished
	fx_player.queue_free()

#func adjust_music_volume():
	## if any player is invalid
	#if !(GameManager.p1 or GameManager.p2):
		#return
	#
	#var lowest_health : float
	#if GameManager.p1.health < GameManager.p2.health:
		#lowest_health = GameManager.p1.health
	#else:
		#lowest_health = GameManager.p2.health
	#
#
	#print_debug("---- Music Speed Increased ----")
#
	#var music_speed : float = lerp(1.06, 1.0, lowest_health / 100)
	#
	#print("- Music_Speed : ", music_speed," - health : ", (lowest_health / 100))
	#var tween := get_tree().create_tween()
	#tween.tween_property(music_player, "pitch_scale", music_speed, 1)
	#await tween.finished
	#tween.kill()

#func play_random_bg_music() -> void:
	#var music : AudioStream = music_array.pick_random()
	#var index : int = music_array.find(music)
	#
	#if index == GameManager.level_prefs.prev_music_index:
		#music = music_array.pick_random()
		#index = music_array.find(music)
	#
	#GameManager.level_prefs.prev_music_index = index
	#
	#SFXManager.play_music(music, -10)
