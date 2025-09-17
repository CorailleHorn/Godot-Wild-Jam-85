extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set market items
	var planet = load(PLANET_CONSTANTS.PetiteRocheuse)
	$Market/MarketItem.set_planet(planet)
	$Market/MarketItem2.set_planet(planet)
	$Market/MarketItem3.set_planet(planet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
