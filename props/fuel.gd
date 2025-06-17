extends Area2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var polygon2D : Polygon2D = $Polygon2D

@export var fuel_amount : float = .5
@export var is_self_destruct : bool = true

func _ready() -> void:
	point_light_2d.texture_scale = fuel_amount
	
func _process(delta: float) -> void:
	polygon2D.rotation_degrees += delta * 30

func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		if is_self_destruct:
			body.point_light.texture_scale += fuel_amount
			self.queue_free()
		else:
			body.point_light.texture_scale = max(body.point_light.texture_scale, fuel_amount)
