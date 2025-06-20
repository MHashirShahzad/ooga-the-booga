extends Node2D

@export var rotation_speed_multiplier : int = 30

func _process(delta: float) -> void:
	self.rotation_degrees += delta * rotation_speed_multiplier
