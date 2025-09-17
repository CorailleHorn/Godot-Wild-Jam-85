extends Control

var planet: PlanetResource = null : set = set_planet

var dragging: bool = false
var offset: Vector2 = Vector2(0,0)
var dragged_object: TextureRect = null

func set_planet(value: PlanetResource) -> void:
	planet = value
	$Center/LaPlanete.texture = planet.image
	$NamePlanete.text = planet.name
	$Effects/EffectOrCost.set_values(true, planet.cost_caillou, "Caillou")
	$Effects/EffectOrCost2.set_values(true, planet.cost_gaz, "Gaz")
	$Effects/EffectOrCost3.set_values(true, planet.cost_flotte, "Flotte")
	$Costs/EffectOrCost.set_values(false, planet.effect_caillou, "Caillou")
	$Costs/EffectOrCost2.set_values(false, planet.effect_gaz, "Gaz")
	$Costs/EffectOrCost3.set_values(false, planet.effect_flotte, "Flotte")

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
	var new_planet = Sprite2D.new()
	new_planet.texture = dragged_object.texture
	new_planet.global_position = dragged_object.get_screen_position() + Vector2(64,64)
	get_tree().get_root().add_child(new_planet)
	$Center.remove_child(dragged_object)
	dragged_object.queue_free()
	
