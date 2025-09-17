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
	
	GAME_EVENTS.update_caillou.connect(_on_update_caillou)
	GAME_EVENTS.update_flotte.connect(_on_update_flotte)
	GAME_EVENTS.update_gaz.connect(_on_update_gaz)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_update_caillou(value:int):
	$ResourcesBar/Resources/ValueCaillou.text = str(value)

func _on_update_flotte(value:int):
	$ResourcesBar/Resources/ValueFlotte.text = str(value)

func _on_update_gaz(value:int):
	$ResourcesBar/Resources/ValueGaz.text = str(value)


func _on_setting_btn_button_down() -> void:
	#TODO : afficher une interface avec possibilité de reload la game, retourner au menutruc comme ça
	pass # Replace with function body.
