extends Area2D

var player : Player2D
@export var pull_velocity : float = -1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player: return
	player.velocity.y += 1000 * delta
	if player.velocity.y > pull_velocity:
		player.velocity.y = pull_velocity


func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		var tween = get_tree().create_tween()
		player = body
		tween.tween_property(player.sprite_2d, "scale", Vector2(.9, 1.1), .2).set_trans(Tween.TRANS_QUAD)


func _on_body_exited(body: Node2D) -> void:
	if body is Player2D:
		player.squash_and_stretch_finished()
		player = null
