@icon("res://addons/godotlytoria/textures/icons/GradientSky.svg")
extends PolyInstance
class_name PolyProceduralSky

# TODO: Add Godot functionality and proper icon

@export var SunSize: float = 0.04
@export var SunSizeConvergence: float = 5.0000
@export var AtmosphereThickness: float = 1.0
@export var SkyTint: Color = Color(0.6588,0.6588,0.6588,1.0)
@export var GroundColor: Color = Color(0.7255,0.7255,0.7255,1.0)
@export var Exposure: float = 1.2
