extends Node2D

func _on_AudioStreamPlayer_finished():
	queue_free()

func play_sound(sound:AudioStream):
	$AudioStreamPlayer.stream = sound
	$AudioStreamPlayer.play(0)
