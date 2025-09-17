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
