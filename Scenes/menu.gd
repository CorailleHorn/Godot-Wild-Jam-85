extends Control



func _ready() -> void:
	# TODO : add audio controller ici
	pass # Replace with function body.


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
