extends Node
class_name State

var parent_state_machine: StateMachine = null


#### BUILT-IN ####

func _ready() -> void:
	if(get_parent() is StateMachine):
		parent_state_machine = get_parent()

#### VIRTUAL ####

func enter_state() -> void:
	pass


func exit_state() -> void:
	pass


func update(_delta: float) -> void:
	pass 


#### LOGIC ####


func is_current_state() -> bool:
	return parent_state_machine.get_state() == self
