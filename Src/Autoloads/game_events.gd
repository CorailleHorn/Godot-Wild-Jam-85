extends Node
# Place global signals here :
signal buy_planet(market_slot: int, planet: PlanetResource, position: Vector2)
signal add_new_market_item(market_slot: int)

# Signaux pour mettre à jour l'UI
signal update_caillou(value: int)
signal update_gaz(value: int)
signal update_flotte(value: int)
