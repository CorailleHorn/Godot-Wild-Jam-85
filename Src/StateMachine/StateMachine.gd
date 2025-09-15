extends State
class_name StateMachine

var current_state : Node = null :
	set = set_state
var previous_state : Node = null :
	get:
		return previous_state
	set(value):
		previous_state = value

signal state_changed(state)
signal state_changed_recursive(state)

#### ACCESSORS ####

func set_state(state) -> void:
	if state is String:
		state = get_node_or_null(state)
	
	if state == current_state:
		return
	
	if current_state != null:
		current_state.exit_state()
	
	previous_state = current_state
	current_state = state
	
	if current_state != null:
		current_state.enter_state()
	
	state_changed.emit(current_state)

func get_state_name() -> String:
	if current_state == null:
		return ""
	return current_state.name



#### BUILT-IN ####

func _ready() -> void:
	state_changed.connect(_on_state_changed)
	
	if parent_state_machine != null:
		connect("state_changed_recursive", Callable(parent_state_machine, "_on_State_state_changed_recursive"))
	else:
		set_to_default_state()


func _physics_process(delta: float) -> void:
	if current_state != null:
		current_state.update(delta)


#### VIRTUAL ####

func enter_state() -> void:
	set_to_default_state()


func exit_state() -> void:
	set_state(null)


#### LOGIC ####

func set_to_default_state() -> void:
	set_state(get_child(0))


func _on_state_changed(_state: Node) -> void:
	state_changed_recursive.emit(current_state)


func _on_State_state_changed_recursive(_state: Node) -> void:
	state_changed_recursive.emit(current_state)
