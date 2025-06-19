extends Node2D

func add_vfx(scene : PackedScene, marker : Marker2D):
	var vfx = scene.instantiate()
	if vfx is CPUParticles2D:
		self.add_child(vfx)
		vfx.global_position = marker.global_position
		vfx.rotation_degrees = marker.rotation_degrees
		vfx.emitting = 1
		
		return
		await vfx.finished
		vfx.queue_free()
		self.remove_child(vfx)
