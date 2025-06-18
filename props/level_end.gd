extends Area2D

@export var next_level : PackedScene 

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var polygon_2d_2: Polygon2D = $Polygon2D2


func _process(delta: float) -> void:
	polygon_2d.rotation_degrees += delta * 40
	polygon_2d_2.rotation_degrees -= delta * 40


func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		if !next_level:
			return
		TransitionManager.transition_scene_packed(next_level)
