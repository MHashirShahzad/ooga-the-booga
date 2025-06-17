extends Area2D

@export var fuel_amount : float = .5

func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		body.point_light.texture_scale += fuel_amount
		self.queue_free()
