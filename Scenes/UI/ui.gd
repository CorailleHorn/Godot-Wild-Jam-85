extends Control
@onready var btn_clic: AudioStreamPlayer = $BtnClic
@onready var resources_more: AudioStreamPlayer = $ResourcesMore
@onready var resources_less: AudioStreamPlayer = $ResourcesLess


@onready var label_caillou: Label = $ResourcesBar/Resources/ValueCaillou
@onready var label_gaz: Label = $ResourcesBar/Resources/ValueGaz
@onready var label_flotte: Label = $ResourcesBar/Resources/ValueFlotte

var planet_array = [
	preload(PLANET_CONSTANTS.PetiteRocheuse),
	preload(PLANET_CONSTANTS.PetiteGazeuse),
	preload(PLANET_CONSTANTS.PetiteOcean),
	preload(PLANET_CONSTANTS.Magmatique),
	preload(PLANET_CONSTANTS.Tempetueuse)
]
var main_node: Main = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GAME_EVENTS.add_new_market_item.connect(_on_GAME_EVENTS_add_new_market_item)
	main_node = get_node("/root/Main")
	await main_node
	# Set market items
	$Market/MarketItem1.set_planet(get_next_market_item())
	$Market/MarketItem2.set_planet(get_next_market_item())
	$Market/MarketItem3.set_planet(get_next_market_item())

	GAME_EVENTS.update_caillou.connect(_on_update_caillou)
	GAME_EVENTS.update_flotte.connect(_on_update_flotte)
	GAME_EVENTS.update_gaz.connect(_on_update_gaz)
	GAME_EVENTS.end_game.connect(_on_GAME_EVENTS_end_game)
	
func can_afford(planet: PlanetResource) -> bool:
	return main_node.caillou >= planet.cost_caillou &&  main_node.gaz >= planet.cost_gaz &&  main_node.flotte >= planet.cost_flotte

func get_next_market_item() -> PlanetResource:
	for i in range(planet_array.size()):
		if can_afford(planet_array[i]):
			return planet_array.pop_at(i)
	if(planet_array.size() != 0):
		return planet_array.pop_at(0)
	else:
		return null

func show_black_veil() -> void:
	$BlackVeil.visible = true
	var fade_tween = get_tree().create_tween()
	fade_tween.tween_property($BlackVeil, "color:a", 0.5, 0.2)
	
func check_end_game_conditions() -> void:
	var null_count: int = 0
	for i in range(1,4):
		var planet = get_node("Market/MarketItem" + str(i)).planet
		if(planet != null):
			if(can_afford(planet)):
				return
		else:
			null_count+=1
	GAME_EVENTS.end_game.emit(null_count == 3)

func _on_GAME_EVENTS_add_new_market_item(market_slot: int) -> void:
	get_node("Market/MarketItem" + str(market_slot)).set_planet(get_next_market_item())
	check_end_game_conditions()
	

func _on_update_caillou(value:int):
	var dif = value - int(label_caillou.text) 
	if (dif != 0) :
		# créer le label feedback + anim
		resources_update_feedback(label_caillou,dif)	
	# update le label value
	label_caillou.text = str(value)

func _on_update_flotte(value:int):
	var dif = value - int(label_flotte.text) 
	if (dif != 0) :
		# créer le label feedback + anim
		resources_update_feedback(label_flotte,dif)	
	# update le label value
	label_flotte.text = str(value)

func _on_update_gaz(value:int):
	var dif = value - int(label_gaz.text) 
	if (dif != 0) :
		# créer le label feedback + anim
		resources_update_feedback(label_gaz,dif)	
	# update le label value
	label_gaz.text = str(value)

func _on_setting_btn_button_down() -> void:
	btn_clic.play(0)
	get_tree().reload_current_scene()

func _on_caillou_mouse_entered() -> void:
	GAME_EVENTS.show_tooltips.emit("Rocks",true)
func _on_caillou_mouse_exited() -> void:
	GAME_EVENTS.show_tooltips.emit("Rocks",false)
func _on_gaz_mouse_entered() -> void:
	GAME_EVENTS.show_tooltips.emit("Gas",true)
func _on_gaz_mouse_exited() -> void:
	GAME_EVENTS.show_tooltips.emit("Gas",false)
func _on_flotte_mouse_entered() -> void:
	GAME_EVENTS.show_tooltips.emit("Liquid",true)
func _on_flotte_mouse_exited() -> void:
	GAME_EVENTS.show_tooltips.emit("Liquid",false)

func resources_update_feedback(label_base: Label,value : int):
	var label = Label.new()
	label.text = str(value)
	label.add_theme_font_size_override("font_size", 62)
	label.add_theme_constant_override("outline_size", 20)  
	var global_position_parent = label_base.get_global_position()
	var t = create_tween()
	if (value >0):
		label.global_position = global_position_parent + Vector2(0,-20)
		label.add_theme_color_override("font_color",  Color(0, 1, 0)) # vert
		label.add_theme_color_override("outline_color",  Color(0, 1, 0))
		add_child(label)
		# bouger le label feedbak ver le haut
		t.tween_property(label, "position", label.position + Vector2(0, -80), 1) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		resources_more.play()
	else:
		label.global_position = global_position_parent + Vector2(0,20)
		label.add_theme_color_override("font_color",  Color(1, 0, 0)) #rouge
		label.add_theme_color_override("outline_color",  Color(1, 0, 0))
		add_child(label)
		# bouger le label feedbak ver le bas
		t.tween_property(label, "position", label.position + Vector2(0, +80), 1) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		resources_less.play()
	# faire disparaitre
	t.parallel().tween_property(label, "modulate:a", 0.0, 0.8)
	# supprimer
	await t.finished
	label.queue_free()

func _on_retry_button_button_down() -> void:
	get_tree().reload_current_scene()

func _on_back_2_menu_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
func _on_GAME_EVENTS_end_game(win: bool) -> void:
	$FinalBox.visible = true
	$FinalBox/LabelYouWin.visible = win
	$FinalBox/LabelYouLose.visible = !win
	show_black_veil()
