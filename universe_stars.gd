extends Node2D
@onready var stars: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@export var min_timer: float = 4.0
@export var max_timer: float = 12.0
@export var texture: Texture2D = preload("uid://dmj34geudbjes")
@export_enum("brille","scale") var anim = "brille"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	stars.texture = texture
	start_random_timer()

func stars_animation():
	var opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(stars,'modulate:a',0.2,1)
	opacity_tween.tween_property(stars,'modulate:a',1,2)

func brume_animation():
	var scale_tween = get_tree().create_tween()
	scale_tween.tween_property(stars,'scale',Vector2(1.2,1.2),4) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(stars,'scale',Vector2(1,1),4) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)

func start_random_timer():
	var duration = randf_range(min_timer,max_timer)
	timer.start(duration)

func _on_timer_timeout() -> void:
	match anim:
		"brille":
			stars_animation()
		"scale":
			brume_animation()
	start_random_timer()
