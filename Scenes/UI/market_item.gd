extends Control

var planet: PlanetResource = null : set = set_planet

var dragging: bool = false
var offset: Vector2 = Vector2(0,0)
var dragged_object: TextureRect = null

var rect_market: Rect2 = Rect2()

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
	var market: GridContainer = get_parent()
	await market.ready
	rect_market = Rect2(market.position, market.size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		dragged_object.position = get_global_mouse_position() - offset


func _on_button_button_down() -> void:
	# drag
	dragging = true
	dragged_object = TextureRect.new()
	dragged_object.texture = planet.image
	dragged_object.position = $Center/LaPlanete.position
	$Center.add_child(dragged_object)
	offset = get_global_mouse_position() - dragged_object.position

func _on_button_button_up() -> void:
	dragging = false
	# si on achète
	if(!rect_market.has_point(get_global_mouse_position())):
		GAME_EVENTS.buy_planet.emit(planet, dragged_object.get_screen_position() + Vector2(64,64))
		print("bought")
	# si on achète pas
	else:
		print("not bought")
	$Center.remove_child(dragged_object)
	dragged_object.queue_free()
	
