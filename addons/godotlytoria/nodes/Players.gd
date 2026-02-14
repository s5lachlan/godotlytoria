@tool
@icon("res://addons/godotlytoria/textures/Players.svg")
extends PolyInstance
class_name PolyPlayers

# Replace with PolyPlayer when implemented
var LocalPlayer: PolyPlayer
## Determines whether or not collisions between players are enabled.
@export var PlayerCollisionEnabled: bool = true
