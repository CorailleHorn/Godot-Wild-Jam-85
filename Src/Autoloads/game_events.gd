extends Node
# Place global signals here :
signal buy_planet(planet: PlanetResource, position: Vector2)


# Signaux pour mettre à jour l'UI
signal update_caillou(value: int)
signal update_gaz(value: int)
signal update_flotte(value: int)
