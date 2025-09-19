extends Control



func _ready() -> void:
	AudioController.play_music()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
