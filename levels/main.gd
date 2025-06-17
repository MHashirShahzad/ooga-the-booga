extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("[MainFPS] %s" % Engine.get_frames_per_second())
