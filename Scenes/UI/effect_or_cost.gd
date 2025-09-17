extends Control
var isCost: bool = true :
	set(value):
		isCost = value
		$Plus.visible = !isCost
		$Minus.visible = isCost

var val: int = 0 : 
	set(value):
		val = value
		# On masque l'object si le coût est de zéro
		if(val == 0):
			visible = false
		else:
			visible = true
		$Value.text = str(val)

var type: String = "Caillou" :
	set(value):
		get_node(type + "Img").visible = false
		type = value
		get_node(type + "Img").visible = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CaillouImg.visible = false
	$Plus.visible = false
	pass # Replace with function body.
	
func set_values(_isCost: bool, _val: int, _type: String) -> void:
	isCost = _isCost
	val = _val
	type = _type
