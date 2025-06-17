@tool
extends StaticBody2D

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var polygon_2d: Polygon2D = $Polygon2D


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	collision_polygon_2d.polygon = polygon_2d.polygon
	collision_polygon_2d.position = polygon_2d.position
