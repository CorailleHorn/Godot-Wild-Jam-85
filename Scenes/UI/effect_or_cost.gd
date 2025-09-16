extends Control
@export var isCost: bool = true
@export var value: int = 0
@export var type: String = "caillou"


func _init(_isCost: bool, _value: int, _type: String ) -> void:
	isCost = _isCost
	value = _value
	type = _type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
