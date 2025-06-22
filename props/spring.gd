extends Area2D

@export var launch_velocity = 800
@onready var ani_player: AnimationPlayer = $AniPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		var dir : Vector2 = self.global_position.direction_to($Marker2D.global_position)
		print(dir)
		if body.velocity.y >= body.ground_pound_velocity:
			body.velocity = dir * launch_velocity * 1.2
		else:
			body.velocity = dir * launch_velocity
		body.is_ground_pounding = false # if ground pounding cancel it cuz :P
		SFXManager.play_FX(SFXManager.spike_sfx_array.pick_random(), 3, 1, 1)
		body.jump_count += 1
		body.stretch()
		ani_player.play("bounce")
