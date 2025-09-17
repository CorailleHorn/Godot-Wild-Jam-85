class_name PlanetResource
extends Resource


@export var name: String = ""
@export var image: Texture2D = null

@export_group("Cost")
@export var cost_caillou: int = 0
@export var cost_gaz: int = 0
@export var cost_flotte: int = 0

@export_group("Effect")
@export var effect_caillou: int = 0
@export var effect_gaz: int = 0
@export var effect_flotte: int = 0
