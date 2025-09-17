extends Control

var planet_array = [
	preload(PLANET_CONSTANTS.PetiteRocheuse),
	preload(PLANET_CONSTANTS.PetiteGazeuse),
	preload(PLANET_CONSTANTS.PetiteOcean),
	preload(PLANET_CONSTANTS.Magmatique),
	preload(PLANET_CONSTANTS.Tempetueuse)
]
var main_node: Main = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GAME_EVENTS.add_new_market_item.connect(_on_GAME_EVENTS_add_new_market_item)
	main_node = get_node("/root/Main")
	await main_node
	# Set market items
	$Market/MarketItem1.set_planet(get_next_market_item())
	$Market/MarketItem2.set_planet(get_next_market_item())
	$Market/MarketItem3.set_planet(get_next_market_item())

	GAME_EVENTS.update_caillou.connect(_on_update_caillou)
	GAME_EVENTS.update_flotte.connect(_on_update_flotte)
	GAME_EVENTS.update_gaz.connect(_on_update_gaz)
	
func can_afford(planet: PlanetResource) -> bool:
	return main_node.caillou >= planet.cost_caillou &&  main_node.gaz >= planet.cost_gaz &&  main_node.flotte >= planet.cost_flotte

func get_next_market_item() -> PlanetResource:
	for i in range(planet_array.size()):
		if can_afford(planet_array[i]):
			return planet_array.pop_at(i)
	if(planet_array.size() != 0):
		return planet_array.pop_at(0)
	else:
		return null

func _on_GAME_EVENTS_add_new_market_item(market_slot: int) -> void:
	get_node("Market/MarketItem" + str(market_slot)).set_planet(get_next_market_item())

func _on_update_caillou(value:int):
	$ResourcesBar/Resources/ValueCaillou.text = str(value)

func _on_update_flotte(value:int):
	$ResourcesBar/Resources/ValueFlotte.text = str(value)

func _on_update_gaz(value:int):
	$ResourcesBar/Resources/ValueGaz.text = str(value)


func _on_setting_btn_button_down() -> void:
	#TODO : afficher une interface avec possibilité de reload la game, retourner au menutruc comme ça
	pass # Replace with function body.


func _on_caillou_mouse_entered() -> void:
	GAME_EVENTS.show_tooltips.emit("Rocks",true)

func _on_caillou_mouse_exited() -> void:
	GAME_EVENTS.show_tooltips.emit("Rocks",false)


func _on_gaz_mouse_entered() -> void:
	GAME_EVENTS.show_tooltips.emit("Gas",true)


func _on_gaz_mouse_exited() -> void:
	GAME_EVENTS.show_tooltips.emit("Gas",false)


func _on_flotte_mouse_entered() -> void:
	GAME_EVENTS.show_tooltips.emit("Liquid",true)


func _on_flotte_mouse_exited() -> void:
	GAME_EVENTS.show_tooltips.emit("Liquid",false)
