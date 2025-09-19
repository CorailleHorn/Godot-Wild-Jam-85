class_name Main
extends Node2D
@export var camera_speed: float = 500.0
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

@onready var camera_2D = $Camera2D

var turn_number: int = 0 :
	set(value):
		turn_number = value
		if(turn_number != 0):
			GAME_EVENTS.new_turn.emit(turn_number)
var placed_planet: int = 0 :
	set(value):
		if(value == 3):
			turn_number += 1
			placed_planet = 0
		else:
			placed_planet = value
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caillou = caillou_par_tour
	gaz = gaz_par_tour
	flotte = flotte_par_tour
	GAME_EVENTS.buy_planet.connect(_on_GAME_EVENTS_buy_planet)
	GAME_EVENTS.new_turn.connect(_on_GAME_EVENT_new_turn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var moving_direction: Vector2 = Input.get_vector("go_left","go_right", "go_up", "go_down")
	camera_2D.position += moving_direction * camera_speed * delta

func _on_GAME_EVENTS_buy_planet(market_slot: int, planet: PlanetResource, position: Vector2) -> void:
	var new_planet = Sprite2D.new()
	new_planet.texture = planet.image
	new_planet.global_position = position
	add_child(new_planet)
	# TODO:anim : tween + sound
	
	
	# apply cost
	caillou -= planet.cost_caillou
	gaz -= planet.cost_gaz
	flotte -= planet.cost_flotte
	
	# add effect
	caillou_par_tour += planet.effect_caillou
	gaz_par_tour += planet.effect_gaz
	flotte_par_tour += planet.effect_flotte
	
	# increment counter for turn
	placed_planet += 1
	
	GAME_EVENTS.add_new_market_item.emit(market_slot)
	
func _on_GAME_EVENT_new_turn(_turn_number: int) -> void:
	apply_effect()
	
func apply_effect() -> void:
	caillou += caillou_par_tour
	gaz += gaz_par_tour
	flotte += flotte_par_tour
