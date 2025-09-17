extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set market items
	var planet = preload(PLANET_CONSTANTS.PetiteRocheuse)
	var planet2 = preload(PLANET_CONSTANTS.PetiteGazeuse)
	var planet3 = preload(PLANET_CONSTANTS.Tempetueuse)
	$Market/MarketItem.set_planet(planet)
	$Market/MarketItem2.set_planet(planet2)
	$Market/MarketItem3.set_planet(planet3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
