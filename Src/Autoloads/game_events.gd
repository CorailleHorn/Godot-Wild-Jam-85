extends Node
# Place global signals here :
signal buy_planet(market_slot: int, planet: PlanetResource, position: Vector2)
signal add_new_market_item(market_slot: int)
signal new_turn(turn_number: int)
signal end_game(win: bool)

# Signaux pour mettre à jour l'UI
signal update_caillou(value: int)
signal update_gaz(value: int)
signal update_flotte(value: int)
signal update_caillou_par_tour(value: int)
signal update_gaz_par_tour(value: int)
signal update_flotte_par_tour(value: int)
signal update_planet_remaining(value: int)
signal show_tooltips(message: String,on: bool)
