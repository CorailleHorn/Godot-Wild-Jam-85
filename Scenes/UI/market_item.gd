extends Control

var dragging: bool = false
var offset: Vector2 = Vector2(0,0)
var dragged_object: TextureRect = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		dragged_object.position = get_global_mouse_position() - offset


func _on_button_button_down() -> void:
	# drag
	print("int")
	dragging = true
	dragged_object = TextureRect.new()
	dragged_object.texture = $Center/LaPlanete.texture
	dragged_object.position = $Center/LaPlanete.position
	$Center.add_child(dragged_object)
	offset = get_global_mouse_position() - dragged_object.position

func _on_button_button_up() -> void:
	# si on achète
	# si on achète pas
	print("out")
	dragging = false
	$Center.remove_child(dragged_object)
	dragged_object.queue_free()
	
