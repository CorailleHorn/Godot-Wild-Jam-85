extends PanelContainer

const offset: Vector2 = Vector2.ONE*(20.0)
var opacity_tween: Tween = null

func _ready() -> void:
	GAME_EVENTS.show_tooltips.connect(toggle)
	
func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + offset

func toggle(msg: String,on: bool):
	$Content.text = msg
	if on :
		show()
		modulate.a = 0.0
		tween_opacity(1.0)
	else:
		modulate.a = 1.0
		await tween_opacity(0.0).finished
		hide()
		
func tween_opacity(to:float):
	if opacity_tween: opacity_tween.kill()
	opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(self,'modulate:a',to,0.3)
	return opacity_tween
