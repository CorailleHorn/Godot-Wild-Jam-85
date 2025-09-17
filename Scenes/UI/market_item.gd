extends Control

@export var market_slot: int = 0

var planet: PlanetResource = null : set = set_planet

var dragging: bool = false
var offset: Vector2 = Vector2(0,0)
var dragged_object: TextureRect = null

var rect_market: Rect2 = Rect2()
var main_node: Main = null

func set_planet(value: PlanetResource) -> void:
	planet = value
	if(planet != null):
		$Center/Button.disabled = false
		$Center/LaPlanete.texture = planet.image
		$NamePlanete.text = planet.name
		$Effects/EffectOrCost.set_values(false, planet.cost_caillou, "Caillou")
		$Effects/EffectOrCost2.set_values(false, planet.cost_gaz, "Gaz")
		$Effects/EffectOrCost3.set_values(false, planet.cost_flotte, "Flotte")
		$Costs/EffectOrCost.set_values(true, planet.effect_caillou, "Caillou")
		$Costs/EffectOrCost2.set_values(true, planet.effect_gaz, "Gaz")
		$Costs/EffectOrCost3.set_values(true, planet.effect_flotte, "Flotte")
	else:
		$Center/Button.disabled = true
		$Center/LaPlanete.texture = null
		$NamePlanete.text = ""
		$Effects/EffectOrCost.set_values(false, 0, "Caillou")
		$Effects/EffectOrCost2.set_values(false, 0, "Gaz")
		$Effects/EffectOrCost3.set_values(false, 0, "Flotte")
		$Costs/EffectOrCost.set_values(true, 0, "Caillou")
		$Costs/EffectOrCost2.set_values(true, 0, "Gaz")
		$Costs/EffectOrCost3.set_values(true, 0, "Flotte")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var market: GridContainer = get_parent()
	await market.ready
	rect_market = Rect2(market.position, market.size)
	main_node = get_node("/root/Main") 
	await main_node
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		dragged_object.position = get_global_mouse_position() - offset


func _on_button_button_down() -> void:
	if(cannot_afford(planet)):
		print("could not buy !")
		return
	dragging = true
	dragged_object = TextureRect.new()
	dragged_object.texture = planet.image
	dragged_object.position = $Center/LaPlanete.position
	$Center.add_child(dragged_object)
	offset = get_global_mouse_position() - dragged_object.position

func _on_button_button_up() -> void:
	if(dragging == false):
		return
	dragging = false
	# si on achète
	if(!rect_market.has_point(get_global_mouse_position())):
		GAME_EVENTS.buy_planet.emit(market_slot, planet, dragged_object.get_screen_position() + Vector2(64,64))
		print("bought")
	# si on achète pas
	else:
		print("not bought")
	$Center.remove_child(dragged_object)
	dragged_object.queue_free()
	
func cannot_afford(planet: PlanetResource) -> bool:
	return main_node.caillou < planet.cost_caillou ||  main_node.gaz < planet.cost_gaz ||  main_node.flotte < planet.cost_flotte
	
