extends Area2D

@onready var label: Label = $Label
@onready var point_light_2d: PointLight2D = $PointLight2D

func _ready() -> void:
	label.self_modulate = Color.TRANSPARENT
	point_light_2d.texture_scale = 0
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		$CPUParticles2D.emitting = true
		$CPUParticles2D.rotation_degrees = -self.rotation_degrees
		var tween : Tween = get_tree().create_tween()
	
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_parallel(true)
		tween.tween_property(label, "self_modulate", Color.WHITE, 1)
		tween.tween_property(point_light_2d,"texture_scale", 0.5, 0.5)
		await tween.finished
		tween.kill()
