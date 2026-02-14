@tool
@icon("res://addons/godotlytoria/textures/Lighting.svg")
extends PolyInstance
class_name PolyLighting

## Determines the color of the ambient light. 
## Ambient light is light that is not coming from any particular direction, 
## and is used to simulate light bouncing off of surfaces.
@export var AmbientColor: Color
## Determines the source of the ambient light
@export var AmbientSource: Polytoria.AmbientSource
## Determines the brightness of the sun
@export var SunBrightness: float
## Determines the color of the sun. This affects the color of the ambient lighting in the environment.
@export var SunColor: Color
## Determines whether or not shadows are enabled
@export var Shadows: bool
