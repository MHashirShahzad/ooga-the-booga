extends CharacterBody2D
class_name Player2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var point_light : PointLight2D = $PointLight2D
@export var light_fade_multiplier : float = .1
@export var acceleration : float = 25
@export var deceleration : float = 20

const jump_buffer_time:float = .1
const coyote_time:float = .3

var jump_buffer_timer:float = 0
var coyote_timer:float = 0

var speed : float = 500.0
var jump_velocity : float = -700.0
var jump_count : int = 0

var is_on_ground : bool 
var land_velocity : float 

var squashed_size:Vector2 = Vector2(1.1, 0.8) 
var stretched_size:Vector2 = Vector2(0.8, 1.1)

var wish_dir : float = 0

func _ready():
	jump_buffer_timer = 0
	coyote_timer = 0

func _process(delta):
	# Subtract delta(frame) every delta(frame) from these vars
	jump_buffer_timer -= delta
	coyote_timer -= delta

func _physics_process(delta: float) -> void:
	light_fade(delta)
	
	# Coyote stuff
	if is_on_floor():
		jump_count = 0
		if jump_buffer_timer > 0:
			jump_count = jump_count + 1
			velocity.y = jump_velocity
		 	
		if not is_on_ground:
			pass
			#dust_particles.emitting = true
			
			squash()
		is_on_ground = true
	else:
		land_velocity = velocity.y
		if is_on_ground:
			if !(jump_count > 0):
				coyote_timer = coyote_time
				jump_count = 1
		is_on_ground = false
		apply_gravity(delta)

	
	handle_input()
	lean_in_wish_dir(delta)
	move_and_slide()

func apply_gravity(delta) -> void:
	
	if velocity.y > 0:
		velocity += get_gravity() * delta * 1.2
	else:
		velocity += get_gravity() * delta 
	
func handle_input():
	#  JUMP
	if Input.is_action_just_pressed("jump"):
		
		if coyote_timer > 0:
				#AudioPlayer.play_FX(jump_sound, 0, 1, 1.5)
			velocity.y = jump_velocity
			jump_count = 1
		elif jump_count < 1:
			if jump_count == 0:
				pass
				stretch()
			# AUDIO  (sound, volume, lower_limit, upper_limit)
			#AudioPlayer.play_FX(jump_sound, 0, 1, 1.5)
			jump_count = jump_count + 1
			velocity.y = jump_velocity
		else:
			jump_buffer_timer = jump_buffer_time
	if Input.is_action_just_released('jump'):
		if jump_count < 1:
			velocity.y *= 0.5
	
	# Movement
	wish_dir = Input.get_axis("left", "right")
	
	if wish_dir:
		velocity.x = move_toward(velocity.x, wish_dir * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
	


func lean_in_wish_dir(delta : float):
	if wish_dir:
		rotation_degrees = move_toward(rotation_degrees, wish_dir * 10, acceleration / 4)
	else:
		rotation_degrees = move_toward(rotation_degrees, 0, deceleration / 2)
	pass
	
func light_fade(delta: float) -> void:
	if point_light.texture_scale <= 0:
		return
	
	point_light.texture_scale -= delta * light_fade_multiplier

# Squash on land for cute effects :)
func squash():

	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "scale",squashed_size, .1).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property(silhouette_sprite, "scale",squashed_size, .1).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(squash_and_stretch_finished)
	
# Strectch on jump for cute effects :)
func stretch():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "scale",stretched_size, .1).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property(silhouette_sprite, "scale",stretched_size, .1).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(squash_and_stretch_finished)

# Return character to original state after squas and strectch are finsihed
func squash_and_stretch_finished():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "scale",Vector2(1,1), .1).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property(silhouette_sprite, "scale",Vector2(1,1), .1).set_trans(Tween.TRANS_QUAD)
