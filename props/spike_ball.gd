extends Node2D


func _process(delta: float) -> void:
	self.rotation_degrees += delta * 30
