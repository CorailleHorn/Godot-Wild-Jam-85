extends Control

@export var market_slot: int = 0
@onready var drag_planet: AudioStreamPlayer = $DragPlanet

var texture_hover: Texture2D = preload("uid://bye5jiraa6l50")
var texture_normal: Texture2D = preload("uid://dftjth7g4jq1x")

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
		$Effects/EffectOrCost.set_values(false, planet.effect_caillou, "Caillou")
		$Effects/EffectOrCost2.set_values(false, planet.effect_gaz, "Gaz")
		$Effects/EffectOrCost3.set_values(false, planet.effect_flotte, "Flotte")
		$Costs/EffectOrCost.set_values(true, planet.cost_caillou, "Caillou")
		$Costs/EffectOrCost2.set_values(true, planet.cost_gaz, "Gaz")
		$Costs/EffectOrCost3.set_values(true, planet.cost_flotte, "Flotte")
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
	randomize()
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
	_play_drag_planet()

func _on_button_button_up() -> void:
	if(dragging == false):
		return
	dragging = false
	# si on achète
	if(!rect_market.has_point(get_global_mouse_position())):
		GAME_EVENTS.buy_planet.emit(market_slot, planet, get_viewport().get_camera_2d().get_target_position() + dragged_object.get_screen_position() + Vector2(64,64))
		print("bought")
	# si on achète pas
	else:
		print("not bought")
	$Center.remove_child(dragged_object)
	dragged_object.queue_free()
	
func cannot_afford(planet: PlanetResource) -> bool:
	return main_node.caillou < planet.cost_caillou ||  main_node.gaz < planet.cost_gaz ||  main_node.flotte < planet.cost_flotte
	

func _on_mouse_entered() -> void:
	if(cannot_afford(planet)):
		GAME_EVENTS.show_tooltips.emit("Not enough resources",true)
	else:
		$background.texture = texture_hover
	

func _on_mouse_exited() -> void:
	if(cannot_afford(planet)):
		GAME_EVENTS.show_tooltips.emit("Not enough resources",false)
	$background.texture = texture_normal

func _play_drag_planet():
	var x = randi_range(1, 3)
	print("sounds nb :"+str(x))
	match x:
		1:
			drag_planet.play(7)
			await get_tree().create_timer(1.1).timeout
			drag_planet.stop()
		2:
			drag_planet.play(16.9)
			await get_tree().create_timer(1).timeout
			drag_planet.stop()
		_:
			drag_planet.play(18.8)
			await get_tree().create_timer(1.2).timeout
			drag_planet.stop()
	
