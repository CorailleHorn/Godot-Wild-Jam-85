class_name Main
extends Node2D
@export_group("Ressources")
@export var caillou: int = 0 :
	set(value):
		caillou = value
		GAME_EVENTS.update_caillou.emit(caillou)
@export var gaz: int = 0 :
	set(value):
		gaz = value
		GAME_EVENTS.update_gaz.emit(gaz)
@export var flotte: int = 0 :
	set(value):
		flotte = value
		GAME_EVENTS.update_flotte.emit(flotte)

@export_group("Stats par tour")
@export var caillou_par_tour: int = 2
@export var gaz_par_tour: int = 2
@export var flotte_par_tour: int = 1

var turn_number = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caillou = caillou_par_tour
	gaz = gaz_par_tour
	flotte = flotte_par_tour
	GAME_EVENTS.buy_planet.connect(_on_GAME_EVENTS_buy_planet)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_GAME_EVENTS_buy_planet(market_slot: int, planet: PlanetResource, position: Vector2) -> void:
	var new_planet = Sprite2D.new()
	new_planet.texture = planet.image
	new_planet.global_position = position
	add_child(new_planet)
	
	# apply cost
	caillou -= planet.cost_caillou
	gaz -= planet.cost_gaz
	flotte -= planet.cost_flotte
	
	# add effect
	caillou_par_tour += planet.effect_caillou
	gaz_par_tour += planet.effect_gaz
	flotte_par_tour += planet.effect_flotte
	
	GAME_EVENTS.add_new_market_item.emit(market_slot)
