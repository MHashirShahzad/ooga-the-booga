extends Node2D

func play_spike_audio():
	SFXManager.play_FX(SFXManager.spike_sfx_array.pick_random(), 3, 1, 1)
