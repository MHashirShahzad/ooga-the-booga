@tool
extends StaticBody2D

@export var light_occluder_2d: LightOccluder2D 
@export var collision_polygon_2d: CollisionPolygon2D 
@export var polygon_2d: Polygon2D 


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		return

	collision_polygon_2d.polygon = polygon_2d.polygon
	collision_polygon_2d.position = polygon_2d.position
	light_occluder_2d.occluder = OccluderPolygon2D.new()
	light_occluder_2d.occluder.polygon = collision_polygon_2d.polygon
	light_occluder_2d.position = collision_polygon_2d.position
