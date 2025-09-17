extends Button

@onready var btn_clic: AudioStreamPlayer = $BtnClic

func _on_pressed() -> void:
	btn_clic.play(0)
	await get_tree().create_timer(0).timeout
	btn_clic.stop()
