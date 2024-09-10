class_name PlayerAudio

extends AudioStreamPlayer2D

enum Sound {Jump, Roll}
@export var audio_clips: Array[AudioStreamWAV] = []

func _play_sound(sound: Sound) -> void:
	match sound:
		Sound.Jump:
			stream = audio_clips[0]
		Sound.Roll:
			stream = audio_clips[1]
		_:
			pass
	play()
