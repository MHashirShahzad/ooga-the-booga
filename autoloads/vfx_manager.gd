extends Node2D

func add_vfx(scene : PackedScene, pos : Vector2):
	var vfx = scene.instantiate()
	if vfx is CPUParticles2D:
		self.add_child(vfx)
		vfx.global_position = pos
		#vfx.rotation_degrees = marker.rotation_degrees
		vfx.emitting = 1
		
		return
		await vfx.finished
		vfx.queue_free()
		self.remove_child(vfx)
