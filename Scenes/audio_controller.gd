extends Node
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func play_music():
	$AudioStreamPlayer.play()
