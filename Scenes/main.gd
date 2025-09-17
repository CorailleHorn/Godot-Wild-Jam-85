extends Node2D
@export_group("Ressources")
@export var caillou: int = 0
@export var gaz: int = 0
@export var flotte: int = 0

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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
